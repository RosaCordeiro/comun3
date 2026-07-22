HA$PBExportHeader$uo_ge473_nota_fiscal_sap.sru
forward
global type uo_ge473_nota_fiscal_sap from nonvisualobject
end type
end forward

global type uo_ge473_nota_fiscal_sap from nonvisualobject
end type
global uo_ge473_nota_fiscal_sap uo_ge473_nota_fiscal_sap

type variables
uo_ge473_comum io_Comum

String is_chave_sap, is_categoria_nf
Long il_Tabela = 73


end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_atualiza_nota_fiscal (long al_controle, long al_tabela)
public function string of_formata_data (string ps_data)
public function boolean of_gera_sequencial (string ps_mandt, long pl_docnum, ref long pl_sequencial, ref string ps_log)
public function boolean of_insere_item (long al_controle_pai, long al_sequencial, ref dc_uo_ds_base lds_dados, ref string as_log)
public function boolean of_insere_impostos (long al_controle_pai, long al_sequencial, ref dc_uo_ds_base lds_dados, ref string as_log)
public function boolean of_insere_cancelamento (long al_controle_pai, long al_sequencial, ref dc_uo_ds_base lds_dados, ref string as_log)
public function boolean of_atualiza_cnpj (ref string ps_log)
public function boolean of_atualiza_campo_contrato (long al_docnum, string as_mandt, ref string as_log)
public function boolean of_verificar_de_chave_sap (long al_controle, ref string as_chave_sap, ref string as_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);Try	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha
Long ll_controle
String ls_log
String ls_chave_sap_atual
string ls_chave_sap_ant
dc_uo_ds_base lds 

try
	// Atualizar interface_sap.cd_varchar com o CNPJ da tag <cgc>
	If il_Tabela = 73 Then
		If Not of_atualiza_cnpj(Ref ls_log) Then
			gvo_aplicacao.of_grava_log(ls_log)
			//Return
		End If
	End If
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles_nf_sap', False) Then 
		gvo_aplicacao.of_grava_log("Interface Nota Fiscal - Erro alterar a DW [ds_ge473_lista_controles_nf_sap] - uo_ge473_nota_fiscal_sap.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then		
		If not isvalid(w_aguarde_3) Then Open(w_aguarde_3)
		
		w_aguarde_3.uo_progress.of_reset()
		w_aguarde_3.uo_progress.of_setmax(ll_linhas)
		
		For ll_Linha = 1 To ll_Linhas
			
			ll_controle = lds.Object.nr_controle[ll_Linha] 
			
			w_aguarde_3.wf_settext('Controle: ' + String(ll_controle) + ' (' + String(ll_linha) + ' de ' + string(ll_linhas) + ')' , 1 )
			
			If Not this.of_verificar_de_chave_sap( ll_controle, ref ls_chave_sap_atual, ref ls_log) Then Return
			
			If ls_chave_sap_atual <> ls_chave_sap_ant Then
				ls_chave_sap_ant = ls_chave_sap_atual
				Run("C:\Sistemas\EX\Exe\ex.exe /AUTO/73P " + String(ll_controle))
			End If
			
			w_aguarde_3.uo_progress.of_setprogress(ll_linha)
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Nota Fiscal - Erro ao recuperar os da DW [ds_ge473_lista_controles_nf_sap] - uo_ge473_nota_fiscal_sap.of_processa_atualizacao.")
	End If	
	
finally	
	Destroy lds
end try
end subroutine

public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log);
select de_chave_sap
into :as_chave_sap
from interface_sap
where nr_controle = :al_controle
Using SQLCA;

if sqlca.sqlcode = -1 then 
	as_log = 'Erro ao consultar a tabela "interface_sap": ' + sqlca.sqlerrtext
	return false
end if

as_chave_sap =  gf_Tira_Zero_Esquerda(as_chave_sap)

return True
end function

public function boolean of_atualiza_nota_fiscal (long al_controle, long al_tabela);dc_uo_ds_base lds, lds_nota_1, lds_nota_2, lds_item, lds_imposto, lds_nfe

Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente, ll_row, ll_existe, ll_nfnum
		
String	ls_Log, ls_id_finaliza_promocao, ls_id_prioritaria
String ls_mandt, ls_nfenum, ls_docstat, ls_centro
Long ll_docnum, ll_sequencial
			
Boolean	lb_Sucesso = False
Datetime ldt_authdate, ldt_candat, ldt_chadat, ldt_credat, ldt_dcompet, ldt_docdat, ldt_dsaient, ldt_itmf_repdat, ldt_pln_dt_dlv, ldt_pstdat, ldt_zfbdt
decimal ldc_nftot, ldc_vdesc, ldc_total_ref_amt, ldc_vfor, ldc_vliq, ldc_vliqfor, ldc_vorig, ldc_vtotded, ldc_v_troco, ldc_witha, ldc_xmlvers
decimal{3} ldc_peso1, ldc_peso2

Try
	
	if Not io_Comum.of_atualizacao_pendente( al_controle, ref ll_registro_pendente, ref ls_log) Then 
		//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
		If ll_registro_pendente = 0 Then 
			lb_sucesso = True
			Return True
		Else
			return false
		End If
	end if
		
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	if Not this.of_carrega_chave( al_controle, ref is_chave_sap, ref ls_log ) Then Return False
	
	uo_ge473_comum lo_Comum
 	lo_Comum = Create uo_ge473_comum
	
	lds_nota_1 = create dc_uo_ds_base
	lds_nota_2 = create dc_uo_ds_base
	
	lds_nota_1.of_changedataobject( 'ds_ge473_nota_fiscal_doc_1')
	lds_nota_2.of_changedataobject( 'ds_ge473_nota_fiscal_doc_2')
	
	If lo_Comum.of_processa_carrega_dados(al_controle, ref ls_Log) Then
		
		ll_linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		For ll_Linha = 1 To ll_linhas
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Documento: ' + is_chave_sap , 3 )
			end if
			
			ll_row = lds_nota_1.insertrow(ll_linha)

			ls_mandt = lo_Comum.ids_lista_registros.Object.mandt[ll_Linha]
			ll_docnum = long(lo_Comum.ids_lista_registros.Object.docnum[ll_Linha])
			
			lds_nota_1.object.mandt[ll_row] = ls_mandt
			lds_nota_1.object.docnum[ll_row] = ll_docnum
			
			lds_nota_1.object.anred[ll_row] = lo_Comum.ids_lista_registros.Object.anred[ll_Linha]
			lds_nota_1.object.anzpk[ll_row] = long(lo_Comum.ids_lista_registros.Object.anzpk[ll_Linha])
			lds_nota_1.object.authcod[ll_row] = lo_Comum.ids_lista_registros.Object.authcod[ll_Linha]
			
			If Not io_Comum.of_date_time( of_formata_data(lo_Comum.ids_lista_registros.Object.authdate[ll_Linha]), 'AUTHDATE', ref ldt_authdate, ref ls_Log) Then Return False
			lds_nota_1.object.authdate[ll_row] = ldt_authdate
			
			lds_nota_1.object.authtime[ll_row] = lo_Comum.ids_lista_registros.Object.authtime[ll_Linha]
			lds_nota_1.object.autom_incoming[ll_row] = lo_Comum.ids_lista_registros.Object.autom_incoming[ll_Linha]
			lds_nota_1.object.awsys[ll_row] = lo_Comum.ids_lista_registros.Object.awsys[ll_Linha]
			lds_nota_1.object.balsa[ll_row] = lo_Comum.ids_lista_registros.Object.balsa[ll_Linha]
			lds_nota_1.object.bapi_flag[ll_row] = lo_Comum.ids_lista_registros.Object.bapi_flag[ll_Linha]
			lds_nota_1.object.belnr[ll_row] = lo_Comum.ids_lista_registros.Object.belnr[ll_Linha]
			lds_nota_1.object.branch[ll_row] = lo_Comum.ids_lista_registros.Object.branch[ll_Linha]
									
			lds_nota_1.object.bukrs[ll_row] = lo_Comum.ids_lista_registros.Object.bukrs[ll_Linha]
			lds_nota_1.object.cancel[ll_row] = lo_Comum.ids_lista_registros.Object.cancel[ll_Linha]
			
			// peso
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.brgew[ll_Linha], 'BRGEW', ref ldc_peso1, ref ls_Log) Then Return False
			lds_nota_1.object.brgew[ll_row] = ldc_peso1
			
			//peso
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.ntgew[ll_Linha], 'NTGEW', ref ldc_peso2, ref ls_Log) Then Return False
			lds_nota_2.object.ntgew[ll_row] = ldc_peso2
					
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.candat[ll_Linha]), 'CANDAT', ref ldt_candat, ref ls_Log) Then Return False
			lds_nota_1.object.candat[ll_row] = ldt_candat
			
			lds_nota_1.object.cgc[ll_row] = lo_Comum.ids_lista_registros.Object.cgc[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.chadat[ll_Linha]), 'CHADAT', ref ldt_chadat, ref ls_Log) Then Return False
			lds_nota_1.object.chadat[ll_row] = ldt_chadat
			
			lds_nota_1.object.chanam[ll_row] = lo_Comum.ids_lista_registros.Object.chanam[ll_Linha]
			lds_nota_1.object.chatim[ll_row] = lo_Comum.ids_lista_registros.Object.chatim[ll_Linha]
			lds_nota_1.object.checod[ll_row] = lo_Comum.ids_lista_registros.Object.checod[ll_Linha]
			lds_nota_1.object.cnae_bupla[ll_row] = lo_Comum.ids_lista_registros.Object.cnae_bupla[ll_Linha]
			lds_nota_1.object.cnae_partner[ll_row] = lo_Comum.ids_lista_registros.Object.cnae_partner[ll_Linha]
			lds_nota_1.object.cnpj_bupla[ll_row] = lo_Comum.ids_lista_registros.Object.cnpj_bupla[ll_Linha]
			lds_nota_1.object.code[ll_row] = lo_Comum.ids_lista_registros.Object.code[ll_Linha]
			lds_nota_1.object.cod_cta_header[ll_row] = lo_Comum.ids_lista_registros.Object.cod_cta_header[ll_Linha]
			lds_nota_1.object.cod_sit[ll_row] = lo_Comum.ids_lista_registros.Object.cod_sit[ll_Linha]
			lds_nota_1.object.conting[ll_row] = lo_Comum.ids_lista_registros.Object.conting[ll_Linha]
			lds_nota_1.object.cpf[ll_row] = lo_Comum.ids_lista_registros.Object.cpf[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.credat[ll_Linha]), 'CREDAT', ref ldt_credat, ref ls_Log) Then Return False
			lds_nota_1.object.credat[ll_row] = ldt_credat
			
			lds_nota_1.object.cregtrib[ll_row] = lo_Comum.ids_lista_registros.Object.cregtrib[ll_Linha]
			lds_nota_1.object.crenam[ll_row] = lo_Comum.ids_lista_registros.Object.crenam[ll_Linha]
			lds_nota_1.object.cretim[ll_row] = lo_Comum.ids_lista_registros.Object.cretim[ll_Linha]
			
			lds_nota_1.object.cre_timestamp[ll_row] = lo_Comum.ids_lista_registros.Object.cre_timestamp[ll_Linha]
			
			lds_nota_1.object.crt_bupla[ll_row] = lo_Comum.ids_lista_registros.Object.crt_bupla[ll_Linha]
			lds_nota_1.object.crt_partner[ll_row] = lo_Comum.ids_lista_registros.Object.crt_partner[ll_Linha]
			lds_nota_1.object.cte_end_lct[ll_row] = lo_Comum.ids_lista_registros.Object.cte_end_lct[ll_Linha]
			lds_nota_1.object.cte_partner[ll_row] = lo_Comum.ids_lista_registros.Object.cte_partner[ll_Linha]
			lds_nota_1.object.cte_serv_taker[ll_row] = lo_Comum.ids_lista_registros.Object.cte_serv_taker[ll_Linha]
			lds_nota_1.object.cte_strt_lct[ll_row] = lo_Comum.ids_lista_registros.Object.cte_strt_lct[ll_Linha]
			lds_nota_1.object.cte_type[ll_row] = lo_Comum.ids_lista_registros.Object.cte_type[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.dcompet[ll_Linha]), 'DCOMPET', ref ldt_dcompet, ref ls_Log) Then Return False
			lds_nota_1.object.dcompet[ll_row] = ldt_dcompet
			
			lds_nota_1.object.direct[ll_row] = lo_Comum.ids_lista_registros.Object.direct[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.docdat[ll_Linha]), 'DOCDAT', ref ldt_docdat, ref ls_Log) Then Return False
			lds_nota_1.object.docdat[ll_row] = ldt_docdat
			
			lds_nota_1.object.docnum_next[ll_row] = long(lo_Comum.ids_lista_registros.Object.docnum_next[ll_Linha])
			lds_nota_1.object.docnum_prev[ll_row] = long(lo_Comum.ids_lista_registros.Object.docnum_prev[ll_Linha])
			lds_nota_1.object.docref[ll_row] = long(lo_Comum.ids_lista_registros.Object.docref[ll_Linha])
			
			ls_docstat = lo_Comum.ids_lista_registros.Object.docstat[ll_Linha]
			
			lds_nota_1.object.docstat[ll_row] = ls_docstat
			lds_nota_1.object.doctyp[ll_row] = lo_Comum.ids_lista_registros.Object.doctyp[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.dsaient[ll_Linha]), 'DSAIENT', ref ldt_dsaient, ref ls_Log) Then Return False
			lds_nota_1.object.dsaient[ll_row] = ldt_dsaient
			
			lds_nota_1.object.entrad[ll_row] = lo_Comum.ids_lista_registros.Object.entrad[ll_Linha]
			lds_nota_1.object.fatura[ll_row] =	 lo_Comum.ids_lista_registros.Object.fatura[ll_Linha]
			lds_nota_1.object.follow[ll_row] =	 lo_Comum.ids_lista_registros.Object.follow[ll_Linha]
			lds_nota_1.object.foreignid[ll_row] = lo_Comum.ids_lista_registros.Object.foreignid[ll_Linha]
			lds_nota_1.object.form[ll_row] = lo_Comum.ids_lista_registros.Object.form[ll_Linha]
			lds_nota_1.object.ftl_ind[ll_row] = lo_Comum.ids_lista_registros.Object.ftl_ind[ll_Linha]
			lds_nota_1.object.gewei[ll_row] = lo_Comum.ids_lista_registros.Object.gewei[ll_Linha]
			lds_nota_1.object.gjahr[ll_row] =	long(lo_Comum.ids_lista_registros.Object.gjahr[ll_Linha])
			lds_nota_1.object.hausn[ll_row] = lo_Comum.ids_lista_registros.Object.hausn[ll_Linha]
			lds_nota_1.object.hemi[ll_row] = lo_Comum.ids_lista_registros.Object.hemi[ll_Linha]
			lds_nota_1.object.house_num1[ll_row] = lo_Comum.ids_lista_registros.Object.house_num1[ll_Linha]
			lds_nota_1.object.house_num2[ll_row] = lo_Comum.ids_lista_registros.Object.house_num2[ll_Linha]
			lds_nota_1.object.hsaient[ll_row] = lo_Comum.ids_lista_registros.Object.hsaient[ll_Linha]
			lds_nota_1.object.id_dest[ll_row] = lo_Comum.ids_lista_registros.Object.id_dest[ll_Linha]
			lds_nota_1.object.iest_bupla[ll_row] = lo_Comum.ids_lista_registros.Object.iest_bupla[ll_Linha]
			lds_nota_1.object.iest_partner[ll_row] = lo_Comum.ids_lista_registros.Object.iest_partner[ll_Linha]
			lds_nota_1.object.ie_bupla[ll_row] = lo_Comum.ids_lista_registros.Object.ie_bupla[ll_Linha]
			lds_nota_1.object.im_bupla[ll_row] = lo_Comum.ids_lista_registros.Object.im_bupla[ll_Linha]
			lds_nota_1.object.inco1[ll_row] = lo_Comum.ids_lista_registros.Object.inco1[ll_Linha]
			lds_nota_1.object.inco2[ll_row] = lo_Comum.ids_lista_registros.Object.inco2[ll_Linha]
			lds_nota_1.object.indpag[ll_row] = lo_Comum.ids_lista_registros.Object.indpag[ll_Linha]
			lds_nota_1.object.indust[ll_row] = lo_Comum.ids_lista_registros.Object.indust[ll_Linha]
			lds_nota_1.object.ind_badi_ctrl[ll_row] = lo_Comum.ids_lista_registros.Object.ind_badi_ctrl[ll_Linha]
			lds_nota_1.object.ind_emit[ll_row] = lo_Comum.ids_lista_registros.Object.ind_emit[ll_Linha]
			lds_nota_1.object.ind_final[ll_row] = lo_Comum.ids_lista_registros.Object.ind_final[ll_Linha]
			lds_nota_1.object.ind_iedest[ll_row] = long(lo_Comum.ids_lista_registros.Object.ind_iedest[ll_Linha])
			lds_nota_1.object.ind_pres[ll_row] = lo_Comum.ids_lista_registros.Object.ind_pres[ll_Linha]
			lds_nota_1.object.isuf[ll_row] = lo_Comum.ids_lista_registros.Object.isuf[ll_Linha]
			lds_nota_1.object.itmf_pco_category[ll_row] = lo_Comum.ids_lista_registros.Object.itmf_pco_category[ll_Linha]
			
			ll_nfnum = long(lo_Comum.ids_lista_registros.Object.nfnum[ll_Linha])
			
			if IsNull(ll_nfnum) or ll_nfnum <= 0 then
				ls_nfenum = lo_Comum.ids_lista_registros.Object.nfenum[ll_Linha]
				
				if IsNumber(ls_nfenum) then
					ll_nfnum	= Long(ls_nfenum)
				end if
			end if
			
			lds_nota_1.object.nfnum[ll_row] = ll_nfnum
			
			lds_nota_1.object.id_status[ll_row] = 'C'
			lds_nota_1.object.dh_inclusao[ll_row] = gf_getserverdate()

			ll_row = lds_nota_2.insertrow(ll_linha)

			lds_nota_2.object.mandt[ll_row] = lo_Comum.ids_lista_registros.Object.mandt[ll_Linha]
			lds_nota_2.object.docnum[ll_row] = long(lo_Comum.ids_lista_registros.Object.docnum[ll_Linha])
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.itmf_repdat[ll_Linha]), 'ITMF_REPDAT', ref ldt_itmf_repdat, ref ls_Log) Then Return False
			lds_nota_2.object.itmf_repdat[ll_row] = ldt_itmf_repdat
			
			lds_nota_2.object.land1[ll_row] = lo_Comum.ids_lista_registros.Object.land1[ll_Linha]
			lds_nota_2.object.main_product[ll_row] = lo_Comum.ids_lista_registros.Object.main_product[ll_Linha]
			lds_nota_2.object.manual[ll_row] = lo_Comum.ids_lista_registros.Object.manual[ll_Linha]
			lds_nota_2.object.mod[ll_row] = lo_Comum.ids_lista_registros.Object.mod[ll_Linha]
			
			lds_nota_2.object.model[ll_row] = long(lo_Comum.ids_lista_registros.Object.model[ll_Linha])
			
			lds_nota_2.object.modfrete[ll_row] = lo_Comum.ids_lista_registros.Object.modfrete[ll_Linha]
			lds_nota_2.object.municipal[ll_row] = lo_Comum.ids_lista_registros.Object.municipal[ll_Linha]
			lds_nota_2.object.munins[ll_row] = lo_Comum.ids_lista_registros.Object.munins[ll_Linha]
			lds_nota_2.object.name1[ll_row] = lo_Comum.ids_lista_registros.Object.name1[ll_Linha]
			lds_nota_2.object.name2[ll_row] = lo_Comum.ids_lista_registros.Object.name2[ll_Linha]
			lds_nota_2.object.name3[ll_row] = lo_Comum.ids_lista_registros.Object.name3[ll_Linha]
			lds_nota_2.object.name4[ll_row] = lo_Comum.ids_lista_registros.Object.name4[ll_Linha]
			lds_nota_2.object.natop[ll_row] = lo_Comum.ids_lista_registros.Object.natop[ll_Linha]
			lds_nota_2.object.ncoo[ll_row] = long(lo_Comum.ids_lista_registros.Object.ncoo[ll_Linha])
			lds_nota_2.object.nfat[ll_row] = lo_Comum.ids_lista_registros.Object.nfat[ll_Linha]
			lds_nota_2.object.nfdec[ll_row] = long(lo_Comum.ids_lista_registros.Object.nfdec[ll_Linha])
			lds_nota_2.object.nfe[ll_row] = lo_Comum.ids_lista_registros.Object.nfe[ll_Linha]
			lds_nota_2.object.nfenrnr[ll_row] = lo_Comum.ids_lista_registros.Object.nfenrnr[ll_Linha]
			lds_nota_2.object.nfenum[ll_row] = lo_Comum.ids_lista_registros.Object.nfenum[ll_Linha]
			lds_nota_2.object.nfesrv[ll_row] = lo_Comum.ids_lista_registros.Object.nfesrv[ll_Linha]
			lds_nota_2.object.nfnum[ll_row] = long(lo_Comum.ids_lista_registros.Object.nfnum[ll_Linha])
			lds_nota_2.object.nfnum_utilities[ll_row] = long(lo_Comum.ids_lista_registros.Object.nfnum_utilities[ll_Linha])
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nftot[ll_Linha], 'NFTOT', ref ldc_nftot, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.nftot[ll_row] = ldc_nftot
			
			is_categoria_nf	= lo_Comum.ids_lista_registros.Object.nftype[ll_Linha]
			lds_nota_2.object.nftype[ll_row] = is_categoria_nf
			
			ls_centro = lo_Comum.ids_lista_registros.Object.branch[ll_Linha]
			
			// Para code = 102 n$$HEX1$$e300$$ENDHEX$$o muda pra P, vai inserir a inutiliza$$HEX2$$e700e300$$ENDHEX$$o na GE537
			if is_categoria_nf = 'A1' or & 
				is_categoria_nf = 'YA' or & 
				(is_categoria_nf = 'ZF' and ls_docstat = '2' and lo_Comum.ids_lista_registros.Object.code[ll_Linha] <> '102') or &
				ls_centro = '1001' &
				then
				lds_nota_1.object.id_status[ll_row] = 'P'
			end if
			
			lds_nota_2.object.observat[ll_row] = lo_Comum.ids_lista_registros.Object.observat[ll_Linha]
			lds_nota_2.object.ort01[ll_row] = lo_Comum.ids_lista_registros.Object.ort01[ll_Linha]
			lds_nota_2.object.ort02[ll_row] = lo_Comum.ids_lista_registros.Object.ort02[ll_Linha]
			lds_nota_2.object.parid[ll_row] = lo_Comum.ids_lista_registros.Object.parid[ll_Linha]
			lds_nota_2.object.partner_role[ll_row] = lo_Comum.ids_lista_registros.Object.partner_role[ll_Linha]
			lds_nota_2.object.partr[ll_row] = long(lo_Comum.ids_lista_registros.Object.partr[ll_Linha])
			lds_nota_2.object.partyp[ll_row] = lo_Comum.ids_lista_registros.Object.partyp[ll_Linha]
			lds_nota_2.object.parvw[ll_row] = lo_Comum.ids_lista_registros.Object.parvw[ll_Linha]
			lds_nota_2.object.parxcpdk[ll_row] = lo_Comum.ids_lista_registros.Object.parxcpdk[ll_Linha]
			lds_nota_2.object.pfach[ll_row] = lo_Comum.ids_lista_registros.Object.pfach[ll_Linha]
			lds_nota_2.object.placa[ll_row] = lo_Comum.ids_lista_registros.Object.placa[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.pln_dt_dlv[ll_Linha]), 'PLN_DT_DLV', ref ldt_pln_dt_dlv, ref ls_Log) Then Return False
			lds_nota_2.object.pln_dt_dlv[ll_row] = ldt_pln_dt_dlv
			
			lds_nota_2.object.prefno[ll_row] = lo_Comum.ids_lista_registros.Object.prefno[ll_Linha]
			lds_nota_2.object.printd[ll_row] = lo_Comum.ids_lista_registros.Object.printd[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.pstdat[ll_Linha]), 'PSTDAT', ref ldt_pstdat, ref ls_Log) Then Return False
			lds_nota_2.object.pstdat[ll_row] = ldt_pstdat
			
			lds_nota_2.object.pstl2[ll_row] = lo_Comum.ids_lista_registros.Object.pstl2[ll_Linha]
			lds_nota_2.object.pstlz[ll_row] = lo_Comum.ids_lista_registros.Object.pstlz[ll_Linha]
			lds_nota_2.object.qtotant[ll_row] = long(lo_Comum.ids_lista_registros.Object.qtotant[ll_Linha])
			lds_nota_2.object.qtotger[ll_row] = long(lo_Comum.ids_lista_registros.Object.qtotger[ll_Linha])
			lds_nota_2.object.qtotmes[ll_row] = long(lo_Comum.ids_lista_registros.Object.qtotmes[ll_Linha])
			lds_nota_2.object.rcvr_wdw[ll_row] = lo_Comum.ids_lista_registros.Object.rcvr_wdw[ll_Linha]
			lds_nota_2.object.ref_month_year[ll_row] = lo_Comum.ids_lista_registros.Object.ref_month_year[ll_Linha]
			lds_nota_2.object.regio[ll_row] = lo_Comum.ids_lista_registros.Object.regio[ll_Linha]
			lds_nota_2.object.rettransp_cfop[ll_row] = lo_Comum.ids_lista_registros.Object.rettransp_cfop[ll_Linha]
			lds_nota_2.object.rettransp_cmunfg[ll_row] = long(lo_Comum.ids_lista_registros.Object.rettransp_cmunfg[ll_Linha])
			lds_nota_2.object.rntc[ll_row] = lo_Comum.ids_lista_registros.Object.rntc[ll_Linha]
			lds_nota_2.object.safra[ll_row] = lo_Comum.ids_lista_registros.Object.safra[ll_Linha]
			lds_nota_2.object.series[ll_row] = lo_Comum.ids_lista_registros.Object.series[ll_Linha]
			lds_nota_2.object.serv_tp[ll_row] = lo_Comum.ids_lista_registros.Object.serv_tp[ll_Linha]
			lds_nota_2.object.shpmrk[ll_row] = lo_Comum.ids_lista_registros.Object.shpmrk[ll_Linha]
			lds_nota_2.object.shpnum[ll_row] = lo_Comum.ids_lista_registros.Object.shpnum[ll_Linha]
			lds_nota_2.object.shpunt[ll_row] = lo_Comum.ids_lista_registros.Object.shpunt[ll_Linha]
			lds_nota_2.object.smtp_addr[ll_row] = lo_Comum.ids_lista_registros.Object.smtp_addr[ll_Linha]
			lds_nota_2.object.sortl[ll_row] = lo_Comum.ids_lista_registros.Object.sortl[ll_Linha]
			lds_nota_2.object.spras[ll_row] = lo_Comum.ids_lista_registros.Object.spras[ll_Linha]
			lds_nota_2.object.spras_bupla[ll_row] = lo_Comum.ids_lista_registros.Object.spras_bupla[ll_Linha]
			lds_nota_2.object.stains[ll_row] = lo_Comum.ids_lista_registros.Object.stains[ll_Linha]
			lds_nota_2.object.stkzn[ll_row] = lo_Comum.ids_lista_registros.Object.stkzn[ll_Linha]
			lds_nota_2.object.stock[ll_row] = lo_Comum.ids_lista_registros.Object.stock[ll_Linha]
			lds_nota_2.object.stras[ll_row] = lo_Comum.ids_lista_registros.Object.stras[ll_Linha]
			lds_nota_2.object.street[ll_row] = lo_Comum.ids_lista_registros.Object.street[ll_Linha]
			lds_nota_2.object.subseq[ll_row] = lo_Comum.ids_lista_registros.Object.subseq[ll_Linha]
			lds_nota_2.object.subser[ll_row] = lo_Comum.ids_lista_registros.Object.subser[ll_Linha]
			lds_nota_2.object.telf1[ll_row] = lo_Comum.ids_lista_registros.Object.telf1[ll_Linha]
			lds_nota_2.object.telfx[ll_row] = lo_Comum.ids_lista_registros.Object.telfx[ll_Linha]
			lds_nota_2.object.teltx[ll_row] = lo_Comum.ids_lista_registros.Object.teltx[ll_Linha]
			lds_nota_2.object.telx1[ll_row] = lo_Comum.ids_lista_registros.Object.telx1[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.total_ref_amt[ll_Linha], 'TOTAL_REF_AMT', ref ldc_total_ref_amt, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.total_ref_amt[ll_row] = ldc_total_ref_amt
			
			lds_nota_2.object.traid[ll_row] = lo_Comum.ids_lista_registros.Object.traid[ll_Linha]
			lds_nota_2.object.transp_mode[ll_row] = lo_Comum.ids_lista_registros.Object.transp_mode[ll_Linha]
			lds_nota_2.object.traty[ll_row] = lo_Comum.ids_lista_registros.Object.traty[ll_Linha]
			lds_nota_2.object.txjcd[ll_row] = lo_Comum.ids_lista_registros.Object.txjcd[ll_Linha]
			lds_nota_2.object.uf1[ll_row] = lo_Comum.ids_lista_registros.Object.uf1[ll_Linha]
			lds_nota_2.object.ufembarq[ll_row] = lo_Comum.ids_lista_registros.Object.ufembarq[ll_Linha]
			lds_nota_2.object.vagao[ll_row] = lo_Comum.ids_lista_registros.Object.vagao[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vdesc[ll_Linha], 'VDESC', ref ldc_vdesc, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.vdesc[ll_row] = ldc_vdesc
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vfor[ll_Linha], 'VFOR', ref ldc_vfor, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.vfor[ll_row] = ldc_vfor
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vliq[ll_Linha], 'VLIQ', ref ldc_vliq, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.vliq[ll_row] = ldc_vliq
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vliqfor[ll_Linha], 'VLIQFOR', ref ldc_vliqfor, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.vliqfor[ll_row] = ldc_vliqfor
			
			lds_nota_2.object.vol_transp[ll_row] = long(lo_Comum.ids_lista_registros.Object.vol_transp[ll_Linha])
			lds_nota_2.object.vol_unit[ll_row] = lo_Comum.ids_lista_registros.Object.vol_unit[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vorig[ll_Linha], 'VORIG', ref ldc_vorig, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.vorig[ll_row] = ldc_vorig
			
			lds_nota_2.object.vstel[ll_row] = lo_Comum.ids_lista_registros.Object.vstel[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vtotded[ll_Linha], 'VTOTDED', ref ldc_vtotded, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.vtotded[ll_row] = ldc_vtotded
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.v_troco[ll_Linha], 'V_TROCO', ref ldc_v_troco, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.v_troco[ll_row] = ldc_v_troco
			
			lds_nota_2.object.waerk[ll_row] = lo_Comum.ids_lista_registros.Object.waerk[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.witha[ll_Linha], 'WITHA', ref ldc_witha, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.witha[ll_row] = ldc_witha
			
			lds_nota_2.object.xlocdespacho[ll_row] = lo_Comum.ids_lista_registros.Object.xlocdespacho[ll_Linha]
			lds_nota_2.object.xlocembarq[ll_row] = lo_Comum.ids_lista_registros.Object.xlocembarq[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.xmlvers[ll_Linha], 'XMLVERS', ref ldc_xmlvers, ref ls_Log) Then 
				Return False
			end if
			lds_nota_2.object.xmlvers[ll_row] = ldc_xmlvers
			
			lds_nota_2.object.xnemp[ll_row] = lo_Comum.ids_lista_registros.Object.xnemp[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.zfbdt[ll_Linha]), 'PSTDAT', ref ldt_zfbdt, ref ls_Log) Then Return False
			lds_nota_2.object.zfbdt[ll_row] = ldt_zfbdt
			
			lds_nota_2.object.zterm[ll_row] = lo_Comum.ids_lista_registros.Object.zterm[ll_Linha]

			If Not this.of_gera_sequencial( ls_mandt, ll_docnum, ref ll_sequencial, ref ls_log) Then return false
			
			lds_nota_1.object.nr_sequencial[ll_row] = ll_sequencial
			lds_nota_2.object.nr_sequencial[ll_row] = ll_sequencial
			
			If Not this.of_insere_item( al_controle, ll_sequencial, ref lds_item, ref ls_log ) Then 
				return false
			end if
		
			If Not this.of_insere_impostos( al_controle, ll_sequencial, ref lds_imposto, ref ls_log ) Then 
				return false
			end if
			
			If Not this.of_insere_cancelamento( al_controle, ll_sequencial, ref lds_nfe, ref ls_log ) Then 
				return false
			end if
			
			if lds_nota_1.update( ) < 0 Then
				ls_log = 'Erro ao inserir registros na tabela "j_1bnfdoc_1". - '  + lds_nota_1.ivo_dbError.ivs_SqlErrText
				return false
			end if
	
			if lds_nota_2.update( ) < 0 Then
				ls_log = 'Erro ao inserir registros na tabela "j_1bnfdoc_2". - ' + lds_nota_2.ivo_dbError.ivs_SqlErrText
				return false
			end if
			
			if lds_item.update( ) < 0 Then
				ls_log = 'Erro ao inserir registros na tabela "j_1bnflin".'
				return false
			end if
			
			if lds_imposto.update( ) < 0 Then
				ls_log = 'Erro ao inserir registros na tabela "j_1bnfstx".'
				return false
			end if
			
			if lds_nfe.update( ) < 0 Then
				ls_log = 'Erro ao inserir registros na tabela "j_1bnfe_active".'
				return false
			end if
			
			if Not this.of_atualiza_campo_contrato(ll_docnum, ls_mandt, REF ls_log) Then
				return false
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
			end if
			
		Next
		
		lb_sucesso = True
		
	Else
		lb_sucesso = false
		Return False
	End If	
	
	Destroy(lo_comum)	
	
Catch ( runtimeerror  lo_rte )
	ls_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_ge473_nota_fiscal_sap.of_atualiza_nota_fiscal'. Erro: "+lo_rte.GetMessage( )
	lb_sucesso = false
	Return False	
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 167, ls_Log)
	End If
		
	Destroy(lds)
	Destroy(lo_comum)
	
End Try

Return lb_Sucesso
end function

public function string of_formata_data (string ps_data);String ls_retorno

ls_retorno = mid(ps_data, 7,2) + '/' + mid(ps_data, 5,2) + '/' + mid(ps_data, 1,4)

if ls_retorno = '00/00/0000' Then
	setnull(ls_retorno)
end if

return ls_retorno
end function

public function boolean of_gera_sequencial (string ps_mandt, long pl_docnum, ref long pl_sequencial, ref string ps_log);long ll_seq

select Max(nr_sequencial)
into :ll_seq
from j_1bnfdoc_1
where mandt = :ps_mandt
	and docnum = :pl_docnum;

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: '	 + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_gera_sequencial' + '~nProblemas ao consultar a tabela "j_1bnfdoc_1": ' + sqlca.sqlerrtext
	return false
end if

if ll_seq = 0 or isnull(ll_seq) Then
	ll_seq = 1
else
	ll_seq++
end if

pl_sequencial = ll_seq

return true
end function

public function boolean of_insere_item (long al_controle_pai, long al_sequencial, ref dc_uo_ds_base lds_dados, ref string as_log);long ll_controle_filho, ll_linha, ll_row
string ls_chave_sap_item
decimal ldc_netdis, ldc_netfre, ldc_netins, ldc_netoth, ldc_netpr, ldc_netwr, ldc_netwrt
decimal ldc_nfdis, ldc_nffre, ldc_nficmsdeson, ldc_nfins, ldc_nfnet, ldc_nfnett, ldc_nfoth, ldc_nfpri
boolean lb_sucesso=true

decimal ldc_vbcefet
decimal ldc_vbcfcpstret
decimal ldc_vbcstdest
decimal ldc_vbcstret
decimal ldc_vdespadu
decimal ldc_vfcpstret
decimal ldc_vicmsdeson
decimal ldc_vicmsdif
decimal ldc_vicmsefet
decimal ldc_vicmsstdest
decimal ldc_vicmsstret
decimal ldc_vicmssubstituto
decimal ldc_viof
decimal ldc_vtottrib
decimal ldc_pfcpstret
decimal ldc_picmsefet
decimal ldc_pipidevol
decimal ldc_prctr
decimal ldc_predbcefet
decimal ldc_pst
decimal ldc_ps_psp_pnr
decimal ldc_p_mvast
decimal ldc_qselo
decimal ldc_ststcl_vicmsdeson
decimal ldc_subtavr
decimal ldc_subtvalp
decimal ldc_taxsi2
decimal ldc_tax_rate
decimal ldc_icmsavr
decimal ldc_icmsvalp
decimal ldc_lppbrt
decimal ldc_lppnet
decimal ldc_menge_trib
decimal ldc_menge

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_item
	FROM interface_sap  i 
	Where i.cd_tabela = 74
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	ls_chave_sap_item = gf_Tira_Zero_Esquerda(ls_chave_sap_item)
	
	if (ll_controle_filho = 0 or isnull(ll_controle_filho) ) Then

			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ informa$$HEX2$$e700f500$$ENDHEX$$es de produto na tabela interface_sap."
			return false

	end if
	
//	if ls_chave_sap_item <> is_chave_sap Then
//		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de produto [' + ls_chave_sap_prod + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de promo$$HEX2$$e700e300$$ENDHEX$$o [' + is_chave_sap + '].'
//		return false
//	end if
	
	lds_dados = create dc_uo_ds_base
	lds_dados.of_changedataobject( 'ds_ge473_nota_fiscal_item' )
	
	uo_ge473_comum lo_Comum
 	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then	
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ll_row =  lds_dados.insertrow( ll_linha )
			
			lds_dados.object.nr_sequencial[ll_row] = al_sequencial
			
			lds_dados.object.mandt[ll_row] = lo_Comum.ids_lista_registros.Object.mandt[ll_Linha]
			lds_dados.object.docnum[ll_row] = long(lo_Comum.ids_lista_registros.Object.docnum[ll_Linha])
			lds_dados.object.itmnum[ll_row] = long(lo_Comum.ids_lista_registros.Object.itmnum[ll_Linha])
			lds_dados.object.aufnr[ll_row] = lo_Comum.ids_lista_registros.Object.aufnr[ll_Linha]
			lds_dados.object.bwkey[ll_row] = lo_Comum.ids_lista_registros.Object.bwkey[ll_Linha]
			lds_dados.object.bwtar[ll_row] = lo_Comum.ids_lista_registros.Object.bwtar[ll_Linha]
			lds_dados.object.cbenef[ll_row] = lo_Comum.ids_lista_registros.Object.cbenef[ll_Linha]
			lds_dados.object.cbenef_iss[ll_row] = lo_Comum.ids_lista_registros.Object.cbenef_iss[ll_Linha]
			lds_dados.object.cean[ll_row] = lo_Comum.ids_lista_registros.Object.cean[ll_Linha]
			lds_dados.object.cean_trib[ll_row] = lo_Comum.ids_lista_registros.Object.cean_trib[ll_Linha]
			lds_dados.object.cenq[ll_row] = lo_Comum.ids_lista_registros.Object.cenq[ll_Linha]
			lds_dados.object.cest[ll_row] = lo_Comum.ids_lista_registros.Object.cest[ll_Linha]
			lds_dados.object.cfop[ll_row] = lo_Comum.ids_lista_registros.Object.cfop[ll_Linha]
			lds_dados.object.charg[ll_row] = lo_Comum.ids_lista_registros.Object.charg[ll_Linha]
			lds_dados.object.clenq[ll_row] = lo_Comum.ids_lista_registros.Object.clenq[ll_Linha]
			lds_dados.object.cnpjfab[ll_row] = long(lo_Comum.ids_lista_registros.Object.cnpjfab[ll_Linha])
			lds_dados.object.cod_cta[ll_row] = lo_Comum.ids_lista_registros.Object.cod_cta[ll_Linha]
			lds_dados.object.cod_cta_cofins[ll_row] = lo_Comum.ids_lista_registros.Object.cod_cta_cofins[ll_Linha]
			lds_dados.object.cod_cta_pis[ll_row] = lo_Comum.ids_lista_registros.Object.cod_cta_pis[ll_Linha]
			lds_dados.object.contrato[ll_row] = lo_Comum.ids_lista_registros.Object.contrato[ll_Linha]
			lds_dados.object.cselo[ll_row] = lo_Comum.ids_lista_registros.Object.cselo[ll_Linha]
			lds_dados.object.direct[ll_row] = lo_Comum.ids_lista_registros.Object.direct[ll_Linha]
			lds_dados.object.docref[ll_row] = long(lo_Comum.ids_lista_registros.Object.docref[ll_Linha])
			lds_dados.object.dstcat[ll_row] = lo_Comum.ids_lista_registros.Object.dstcat[ll_Linha]
			
			/*If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.icmsavr[ll_Linha], 'ICMSAVR', ref ldc_icmsavr, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if*/
			lds_dados.object.icmsavr[ll_row] = 0
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.icmsvalp[ll_Linha], 'ICMSVALP', ref ldc_icmsvalp, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.icmsvalp[ll_row] = ldc_icmsvalp
			
			
			lds_dados.object.incltx[ll_row] = lo_Comum.ids_lista_registros.Object.incltx[ll_Linha]
			lds_dados.object.indescala[ll_row] = lo_Comum.ids_lista_registros.Object.indescala[ll_Linha]
			lds_dados.object.indincentivo[ll_row] = long(lo_Comum.ids_lista_registros.Object.indincentivo[ll_Linha])
			lds_dados.object.indus2[ll_row] = lo_Comum.ids_lista_registros.Object.indus2[ll_Linha]
			lds_dados.object.indus3[ll_row] = lo_Comum.ids_lista_registros.Object.indus3[ll_Linha]
			lds_dados.object.ind_mov[ll_row] = lo_Comum.ids_lista_registros.Object.ind_mov[ll_Linha]
			lds_dados.object.itmref[ll_row] = long(lo_Comum.ids_lista_registros.Object.itmref[ll_Linha])
			lds_dados.object.itmtyp[ll_row] = lo_Comum.ids_lista_registros.Object.itmtyp[ll_Linha]
			lds_dados.object.kalsm[ll_row] = lo_Comum.ids_lista_registros.Object.kalsm[ll_Linha]
			lds_dados.object.kostl[ll_row] = lo_Comum.ids_lista_registros.Object.kostl[ll_Linha]
			lds_dados.object.kstrg[ll_row] = lo_Comum.ids_lista_registros.Object.kstrg[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.lppbrt[ll_Linha], 'LPPBRT', ref ldc_lppbrt, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.lppbrt[ll_row] = ldc_lppbrt
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.lppnet[ll_Linha], 'LPPNET', ref ldc_lppnet, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.lppnet[ll_row] = ldc_lppnet
			
			lds_dados.object.maktx[ll_row] = lo_Comum.ids_lista_registros.Object.maktx[ll_Linha]
			lds_dados.object.matkl[ll_row] = lo_Comum.ids_lista_registros.Object.matkl[ll_Linha]
			lds_dados.object.matnr[ll_row] = lo_Comum.ids_lista_registros.Object.matnr[ll_Linha]
			lds_dados.object.matorg[ll_row] = lo_Comum.ids_lista_registros.Object.matorg[ll_Linha]
			lds_dados.object.matuse[ll_row] = lo_Comum.ids_lista_registros.Object.matuse[ll_Linha]
			lds_dados.object.meins[ll_row] = lo_Comum.ids_lista_registros.Object.meins[ll_Linha]
			lds_dados.object.meins_trib[ll_row] = lo_Comum.ids_lista_registros.Object.meins_trib[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.menge[ll_Linha], 'MENGE', ref ldc_menge, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.menge[ll_row] = ldc_menge
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.menge_trib[ll_Linha], 'MENGE_TRIB', ref ldc_menge_trib, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.menge_trib[ll_row] = ldc_menge_trib
			
			lds_dados.object.modbc[ll_row] = lo_Comum.ids_lista_registros.Object.modbc[ll_Linha]
			lds_dados.object.modbcst[ll_row] = lo_Comum.ids_lista_registros.Object.modbcst[ll_Linha]
			lds_dados.object.motdesicms[ll_row] = lo_Comum.ids_lista_registros.Object.motdesicms[ll_Linha]
			lds_dados.object.mwskz[ll_row] = lo_Comum.ids_lista_registros.Object.mwskz[ll_Linha]
			lds_dados.object.nat_bc_cred[ll_row] = lo_Comum.ids_lista_registros.Object.nat_bc_cred[ll_Linha]
			lds_dados.object.nbm[ll_row] = lo_Comum.ids_lista_registros.Object.nbm[ll_Linha]
			lds_dados.object.nbs[ll_row] = lo_Comum.ids_lista_registros.Object.nbs[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.netdis[ll_Linha], 'NETDIS', ref ldc_netdis, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.netdis[ll_row] = ldc_netdis
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.netfre[ll_Linha], 'NETFRE', ref ldc_netfre, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.netfre[ll_row] = ldc_netfre
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.netins[ll_Linha], 'NETINS', ref ldc_netins, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.netins[ll_row] = ldc_netins
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.netoth[ll_Linha], 'NETOTH', ref ldc_netoth, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.netoth[ll_row] = ldc_netoth
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.netpr[ll_Linha], 'NETPR', ref ldc_netpr, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.netpr[ll_row] = ldc_netpr
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.netwr[ll_Linha], 'NETWR', ref ldc_netwr, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.netwr[ll_row] = ldc_netwr
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.netwrt[ll_Linha], 'NETWRT', ref ldc_netwrt, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.netwrt[ll_row] = ldc_netwrt
			
			lds_dados.object.nfci[ll_row] = lo_Comum.ids_lista_registros.Object.nfci[ll_Linha]
			
			//**************************************************************//
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nfdis[ll_Linha], 'NFDIS', ref ldc_nfdis, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.nfdis[ll_row] = ldc_nfdis
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nffre[ll_Linha], 'NFFRE', ref ldc_nffre, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.nffre[ll_row] = ldc_nffre
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nficmsdeson[ll_Linha], 'NFICMSDESON', ref ldc_nficmsdeson, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.nficmsdeson[ll_row] = ldc_nficmsdeson
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nfins[ll_Linha], 'NFINS', ref ldc_nfins, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.nfins[ll_row] = ldc_nfins
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nfnet[ll_Linha], 'NFNET', ref ldc_nfnet, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.nfnet[ll_row] = ldc_nfnet
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nfnett[ll_Linha], 'NFNETT', ref ldc_nfnett, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.nfnett[ll_row] = ldc_nfnett
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nfoth[ll_Linha], 'NFOTH', ref ldc_nfoth, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.nfoth[ll_row] = ldc_nfoth
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nfpri[ll_Linha], 'NFPRI', ref ldc_nfpri, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.nfpri[ll_row] = ldc_nfpri
			
			lds_dados.object.nitemped[ll_row] = lo_Comum.ids_lista_registros.Object.nitemped[ll_Linha]
			lds_dados.object.nplnr[ll_row] = lo_Comum.ids_lista_registros.Object.nplnr[ll_Linha]
			lds_dados.object.nprocesso[ll_row] = lo_Comum.ids_lista_registros.Object.nprocesso[ll_Linha]
			lds_dados.object.nrecopi[ll_row] = lo_Comum.ids_lista_registros.Object.nrecopi[ll_Linha]
			lds_dados.object.num_item[ll_row] = long(lo_Comum.ids_lista_registros.Object.num_item[ll_Linha])
			lds_dados.object.ownpro[ll_row] = lo_Comum.ids_lista_registros.Object.ownpro[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pfcpstret[ll_Linha], 'PFCPSTRET', ref ldc_pfcpstret, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.pfcpstret[ll_row] = ldc_pfcpstret
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.picmsefet[ll_Linha], 'PICMSEFET', ref ldc_picmsefet, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.picmsefet[ll_row] = ldc_picmsefet
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pipidevol[ll_Linha], 'PIPIDEVOL', ref ldc_pipidevol, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.pipidevol[ll_row] = ldc_pipidevol
			
			
			lds_dados.object.prctr[ll_row] = lo_Comum.ids_lista_registros.Object.prctr[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.predbcefet[ll_Linha], 'PREDBDEFET', ref ldc_predbcefet, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.predbcefet[ll_row] = ldc_predbcefet
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pst[ll_Linha], 'PST', ref ldc_pst, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.pst[ll_row] = ldc_pst
			
			lds_dados.object.ps_psp_pnr[ll_row] = long(lo_Comum.ids_lista_registros.Object.ps_psp_pnr[ll_Linha])
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.p_mvast[ll_Linha], 'P_MVAST', ref ldc_p_mvast, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.p_mvast[ll_row] = ldc_p_mvast
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.qselo[ll_Linha], 'QSELO', ref ldc_qselo, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.qselo[ll_row] = ldc_qselo
			
			lds_dados.object.refitm[ll_row] = long(lo_Comum.ids_lista_registros.Object.refitm[ll_Linha])
			lds_dados.object.refitm_prev[ll_row] = long(lo_Comum.ids_lista_registros.Object.refitm_prev[ll_Linha])
			
			
			lds_dados.object.refkey[ll_row] = lo_Comum.ids_lista_registros.Object.refkey[ll_Linha]
			lds_dados.object.refkey_prev[ll_row] = lo_Comum.ids_lista_registros.Object.refkey_prev[ll_Linha]
			lds_dados.object.reftyp[ll_row] = lo_Comum.ids_lista_registros.Object.reftyp[ll_Linha]
			lds_dados.object.reftyp_prev[ll_row] = lo_Comum.ids_lista_registros.Object.reftyp_prev[ll_Linha]
			lds_dados.object.segment[ll_row] = lo_Comum.ids_lista_registros.Object.segment[ll_Linha]
			lds_dados.object.spcsto[ll_row] = lo_Comum.ids_lista_registros.Object.spcsto[ll_Linha]
			lds_dados.object.srvnr[ll_row] = lo_Comum.ids_lista_registros.Object.srvnr[ll_Linha]
			lds_dados.object.statit[ll_row] = lo_Comum.ids_lista_registros.Object.statit[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.ststcl_vicmsdeson[ll_Linha], 'STSTCL_VICMSDESON', ref ldc_ststcl_vicmsdeson, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.ststcl_vicmsdeson[ll_row] = ldc_ststcl_vicmsdeson
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.subtavr[ll_Linha], 'SUBTAVR', ref ldc_subtavr, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.subtavr[ll_row] = ldc_subtavr
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.subtvalp[ll_Linha], 'SUBTVALP', ref ldc_subtvalp, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.subtvalp[ll_row] = ldc_subtvalp
			
			
			lds_dados.object.taxlw1[ll_row] = lo_Comum.ids_lista_registros.Object.taxlw1[ll_Linha]
			lds_dados.object.taxlw2[ll_row] = lo_Comum.ids_lista_registros.Object.taxlw2[ll_Linha]
			lds_dados.object.taxlw3[ll_row] = lo_Comum.ids_lista_registros.Object.taxlw3[ll_Linha]
			lds_dados.object.taxlw4[ll_row] = lo_Comum.ids_lista_registros.Object.taxlw4[ll_Linha]
			lds_dados.object.taxlw5[ll_row] = lo_Comum.ids_lista_registros.Object.taxlw5[ll_Linha]
			lds_dados.object.taxsi2[ll_row] = long(lo_Comum.ids_lista_registros.Object.taxsi2[ll_Linha])
			lds_dados.object.taxsi3[ll_row] = lo_Comum.ids_lista_registros.Object.taxsi3[ll_Linha]
			lds_dados.object.taxsi4[ll_row] = lo_Comum.ids_lista_registros.Object.taxsi4[ll_Linha]
			lds_dados.object.taxsi5[ll_row] = lo_Comum.ids_lista_registros.Object.taxsi5[ll_Linha]
			lds_dados.object.taxsit[ll_row] = lo_Comum.ids_lista_registros.Object.taxsit[ll_Linha]
			lds_dados.object.tax_info_source[ll_row] = lo_Comum.ids_lista_registros.Object.tax_info_source[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.tax_rate[ll_Linha], 'TAX_RATE', ref ldc_tax_rate, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.tax_rate[ll_row] = ldc_tax_rate
			
			lds_dados.object.tmiss[ll_row] = lo_Comum.ids_lista_registros.Object.tmiss[ll_Linha]
			lds_dados.object.utrib[ll_row] = lo_Comum.ids_lista_registros.Object.utrib[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vbcefet[ll_Linha], 'VBCEFET', ref ldc_vbcefet, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vbcefet[ll_row] = ldc_vbcefet
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vbcfcpstret[ll_Linha], 'VBCFCPSTRET', ref ldc_vbcfcpstret, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vbcfcpstret[ll_row] = ldc_vbcfcpstret
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vbcstdest[ll_Linha], 'VBCSTDEST', ref ldc_vbcstdest, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vbcstdest[ll_row] = ldc_vbcstdest
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vbcstret[ll_Linha], 'VBCSTRET', ref ldc_vbcstret, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vbcstret[ll_row] = ldc_vbcstret
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vdespadu[ll_Linha], 'VDESPADU', ref ldc_vdespadu, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vdespadu[ll_row] = ldc_vdespadu
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vfcpstret[ll_Linha], 'VFCPSTRET', ref ldc_vfcpstret, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vfcpstret[ll_row] = ldc_vfcpstret
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vicmsdeson[ll_Linha], 'VICMSDESON', ref ldc_vicmsdeson, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vicmsdeson[ll_row] = ldc_vicmsdeson
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vicmsdif[ll_Linha], 'TAX_RATE', ref ldc_vicmsdif, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vicmsdif[ll_row] = ldc_vicmsdif
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vicmsefet[ll_Linha], 'VICMSEFET', ref ldc_vicmsefet, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vicmsefet[ll_row] = ldc_vicmsefet
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vicmsstdest[ll_Linha], 'VICMSSTDEST', ref ldc_vicmsstdest, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vicmsstdest[ll_row] = ldc_vicmsstdest
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vicmsstret[ll_Linha], 'VICMSSTRET', ref ldc_vicmsstret, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vicmsstret[ll_row] = ldc_vicmsstret
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vicmssubstituto[ll_Linha], 'VICMSSUBSTITUTO', ref ldc_vicmssubstituto, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vicmssubstituto[ll_row] = ldc_vicmssubstituto
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.viof[ll_Linha], 'VIOF', ref ldc_viof, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.viof[ll_row] = ldc_viof
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vtottrib[ll_Linha], 'VTOTTRIB', ref ldc_vtottrib, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.vtottrib[ll_row] = ldc_vtottrib
			

			lds_dados.object.werks[ll_row] = lo_Comum.ids_lista_registros.Object.werks[ll_Linha]
			lds_dados.object.xped[ll_row] = lo_Comum.ids_lista_registros.Object.xped[ll_Linha]
			lds_dados.object.xprod[ll_row] = lo_Comum.ids_lista_registros.Object.xprod[ll_Linha]
			
			lds_dados.object.cst[ll_row] = lo_Comum.ids_lista_registros.Object.cst[ll_Linha]
			lds_dados.object.cstreg[ll_row] = lo_Comum.ids_lista_registros.Object.cstreg[ll_Linha]
			lds_dados.object.cclasstrib[ll_row] = lo_Comum.ids_lista_registros.Object.cclasstrib[ll_Linha]
			lds_dados.object.cclasstribreg[ll_row] = lo_Comum.ids_lista_registros.Object.cclasstribreg[ll_Linha]

		Next	
	Else
		Return False				
	End If	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_ge473_nota_fiscal_sap.of_insere_item'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_insere_impostos (long al_controle_pai, long al_sequencial, ref dc_uo_ds_base lds_dados, ref string as_log);long ll_controle_filho, ll_linha, ll_row
string ls_chave_sap_item, ls_imposto_estatistico, ls_tipo_imposto
boolean lb_sucesso=true

decimal ldc_mandt
decimal ldc_docnum
decimal ldc_itmnum
decimal ldc_taxtyp
decimal ldc_base
decimal ldc_basered1
decimal ldc_basered2
decimal ldc_excbas
decimal ldc_factor
decimal ldc_factor4dec
decimal ldc_othbas
decimal ldc_pauta_base
decimal ldc_rate
decimal ldc_rate4dec
decimal ldc_rectype
decimal ldc_servtype_in
decimal ldc_servtype_out
decimal ldc_srate
decimal ldc_stattx
decimal ldc_taxgrp
decimal ldc_taxinnet
decimal ldc_taxoff
decimal ldc_taxoutvalue
decimal ldc_taxval
decimal ldc_tax_difference
decimal ldc_tax_loc
decimal ldc_unit
decimal ldc_unit4dec
decimal ldc_whtcollcode
decimal ldc_withhold

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_item
	FROM interface_sap  i 
	Where i.cd_tabela = 75
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	ls_chave_sap_item = gf_Tira_Zero_Esquerda(ls_chave_sap_item)
	
	if (ll_controle_filho = 0 or isnull(ll_controle_filho) ) Then
			//Quando for NF de servi$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o possui registro na tabela de impostos.
			return True
	end if
	
//	if ls_chave_sap_item <> is_chave_sap Then
//		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de produto [' + ls_chave_sap_prod + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de promo$$HEX2$$e700e300$$ENDHEX$$o [' + is_chave_sap + '].'
//		return false
//	end if
	
	lds_dados = create dc_uo_ds_base
	lds_dados.of_changedataobject( 'ds_ge473_nota_fiscal_impostos' )
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then	
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			ls_imposto_estatistico	= lo_Comum.ids_lista_registros.Object.stattx[ll_Linha]
			ls_tipo_imposto			= lo_Comum.ids_lista_registros.Object.taxtyp[ll_Linha]
			
			//No caso da devolu$$HEX2$$e700e300$$ENDHEX$$o YB, alguns impostos deve sem tratados de forma diferente por n$$HEX1$$e300$$ENDHEX$$o ter campos pr$$HEX1$$f300$$ENDHEX$$prios (IPI e ST)
			if not is_categoria_nf = 'YB' and not is_categoria_nf = 'ZM' and ls_tipo_imposto <> 'IPI2' then
				if ls_imposto_estatistico = 'X' then
					Continue 
				end if
			end if
			
			//Estamos usando apenas o imposto IPI2 de devolu$$HEX2$$e700e300$$ENDHEX$$o no momento para importar no valor da nf
			if ls_imposto_estatistico = 'X' and ls_tipo_imposto <> 'IPI2' then
				Continue
			end if
			
			ll_row =  lds_dados.insertrow( ll_linha )
			
			lds_dados.object.nr_sequencial[ll_row] = al_sequencial
			
			lds_dados.object.mandt[ll_row] 	= lo_Comum.ids_lista_registros.Object.mandt[ll_Linha]
			lds_dados.object.docnum[ll_row] 	= long(lo_Comum.ids_lista_registros.Object.docnum[ll_Linha])
			lds_dados.object.itmnum[ll_row] 	= long(lo_Comum.ids_lista_registros.Object.itmnum[ll_Linha])		
			
			lds_dados.object.taxtyp[ll_row] = ls_tipo_imposto
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.base[ll_Linha], 'BASE', ref ldc_base, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			
			lds_dados.object.base[ll_row] = ldc_base
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.basered1[ll_Linha], 'BASERED1', ref ldc_basered1, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			
			lds_dados.object.basered1[ll_row] = ldc_basered1
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.basered2[ll_Linha], 'BASERED2', ref ldc_basered2, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.basered2[ll_row] = ldc_basered2
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.excbas[ll_Linha], 'EXCBAS', ref ldc_excbas, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.excbas[ll_row] = ldc_excbas
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.factor[ll_Linha], 'FACTOR', ref ldc_factor, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.factor[ll_row] = ldc_factor
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.factor4dec[ll_Linha], 'FACTOR4DEC', ref ldc_factor4dec, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.factor4dec[ll_row] = ldc_factor4dec
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.othbas[ll_Linha], 'OTHBAS', ref ldc_othbas, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.othbas[ll_row] = ldc_othbas
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pauta_base[ll_Linha], 'PAUTA_BASE', ref ldc_pauta_base, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.pauta_base[ll_row] = ldc_pauta_base
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.rate[ll_Linha], 'RATE', ref ldc_rate, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.rate[ll_row] = ldc_rate
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.rate4dec[ll_Linha], 'RATE4DEC', ref ldc_rate4dec, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.rate4dec[ll_row] = ldc_rate4dec
			
			lds_dados.object.rectype[ll_row] = lo_Comum.ids_lista_registros.Object.rectype[ll_Linha]
			lds_dados.object.servtype_in[ll_row] = lo_Comum.ids_lista_registros.Object.servtype_in[ll_Linha]
			lds_dados.object.servtype_out[ll_row] = lo_Comum.ids_lista_registros.Object.servtype_out[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.srate[ll_Linha], 'SRATE', ref ldc_srate, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.srate[ll_row] = ldc_srate
			
			lds_dados.object.stattx[ll_row] = lo_Comum.ids_lista_registros.Object.stattx[ll_Linha]
			lds_dados.object.taxgrp[ll_row] = lo_Comum.ids_lista_registros.Object.taxgrp[ll_Linha]
			lds_dados.object.taxinnet[ll_row] = lo_Comum.ids_lista_registros.Object.taxinnet[ll_Linha]
			lds_dados.object.taxoff[ll_row] = lo_Comum.ids_lista_registros.Object.taxoff[ll_Linha]
			lds_dados.object.taxoutvalue[ll_row] = lo_Comum.ids_lista_registros.Object.taxoutvalue[ll_Linha]
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.taxval[ll_Linha], 'TAXVAL', ref ldc_taxval, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			lds_dados.object.taxval[ll_row] = ldc_taxval
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.tax_difference[ll_Linha], 'TAX_DIFFERENCE', ref ldc_tax_difference, ref as_Log) Then 
				lb_sucesso = false
				Return False
			end if
			
			lds_dados.object.tax_difference[ll_row] = ldc_tax_difference
			
			lds_dados.object.tax_loc[ll_row] = lo_Comum.ids_lista_registros.Object.tax_loc[ll_Linha]
			lds_dados.object.unit[ll_row] = lo_Comum.ids_lista_registros.Object.unit[ll_Linha]
			lds_dados.object.unit4dec[ll_row] = lo_Comum.ids_lista_registros.Object.unit4dec[ll_Linha]
			lds_dados.object.whtcollcode[ll_row] = lo_Comum.ids_lista_registros.Object.whtcollcode[ll_Linha]
			lds_dados.object.withhold[ll_row] = lo_Comum.ids_lista_registros.Object.withhold[ll_Linha]

		Next	
	Else
		Return False				
	End If
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_ge473_nota_fiscal_sap.of_insere_impostos'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_insere_cancelamento (long al_controle_pai, long al_sequencial, ref dc_uo_ds_base lds_dados, ref string as_log);long ll_controle_filho, ll_linha, ll_row
string ls_chave_sap_item
boolean lb_sucesso=true
datetime ldt_authdate, ldt_action_date, ldt_conting_date, ldt_credat

Try
	lds_dados = create dc_uo_ds_base
	lds_dados.of_changedataobject( 'ds_ge473_nota_fiscal_cancelamento' )
		
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_item
	FROM interface_sap  i 
	Where i.cd_tabela = 76
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	ls_chave_sap_item = gf_Tira_Zero_Esquerda(ls_chave_sap_item)
	
	if (ll_controle_filho = 0 or isnull(ll_controle_filho) ) Then

			//Quando for NF de servi$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o possui registro na tabela.
			return True

	end if
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then	
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ll_row =  lds_dados.insertrow( ll_linha )
			
			lds_dados.object.nr_sequencial[ll_row] = al_sequencial
			
			lds_dados.object.mandt[ll_row] = lo_Comum.ids_lista_registros.Object.mandt[ll_Linha]
			lds_dados.object.docnum[ll_row] = long(lo_Comum.ids_lista_registros.Object.docnum[ll_Linha])
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.action_date[ll_Linha]), 'ACTION_DATE', ref ldt_action_date, ref as_Log) Then Return False
			lds_dados.object.action_date[ll_row] = ldt_action_date
		
			lds_dados.object.action_requ[ll_row] = lo_Comum.ids_lista_registros.Object.action_requ[ll_Linha]
			lds_dados.object.action_time[ll_row] = lo_Comum.ids_lista_registros.Object.action_time[ll_Linha]
			lds_dados.object.action_user[ll_row] = lo_Comum.ids_lista_registros.Object.action_user[ll_Linha]
			lds_dados.object.active_service[ll_row] = lo_Comum.ids_lista_registros.Object.active_service[ll_Linha]
			lds_dados.object.authcod[ll_row] = lo_Comum.ids_lista_registros.Object.authcod[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.authdate[ll_Linha]), 'AUTHDATE', ref ldt_authdate, ref as_Log) Then Return False
			lds_dados.object.authdate[ll_row] = ldt_authdate
			
			lds_dados.object.authtime[ll_row] = lo_Comum.ids_lista_registros.Object.authtime[ll_Linha]
			lds_dados.object.branch[ll_row] = lo_Comum.ids_lista_registros.Object.branch[ll_Linha]
			lds_dados.object.bukrs[ll_row] = lo_Comum.ids_lista_registros.Object.bukrs[ll_Linha]
			lds_dados.object.callrfc[ll_row] = lo_Comum.ids_lista_registros.Object.callrfc[ll_Linha]
			lds_dados.object.cancel[ll_row] = lo_Comum.ids_lista_registros.Object.cancel[ll_Linha]
			lds_dados.object.cancel_allowed[ll_row] = lo_Comum.ids_lista_registros.Object.cancel_allowed[ll_Linha]
			lds_dados.object.cancel_pa[ll_row] = lo_Comum.ids_lista_registros.Object.cancel_pa[ll_Linha]
			lds_dados.object.cdv[ll_row] = lo_Comum.ids_lista_registros.Object.cdv[ll_Linha]
			lds_dados.object.checktmpl[ll_row] = lo_Comum.ids_lista_registros.Object.checktmpl[ll_Linha]
			lds_dados.object.cmsg[ll_row] = lo_Comum.ids_lista_registros.Object.cmsg[ll_Linha]
			lds_dados.object.code[ll_row] = lo_Comum.ids_lista_registros.Object.code[ll_Linha]
			lds_dados.object.code_description[ll_row] = lo_Comum.ids_lista_registros.Object.code_description[ll_Linha]
			lds_dados.object.conting[ll_row] = lo_Comum.ids_lista_registros.Object.conting[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.conting_date[ll_Linha]), 'CONTING_DATE', ref ldt_conting_date, ref as_Log) Then Return False
			lds_dados.object.conting_date[ll_row] = ldt_conting_date
			
			lds_dados.object.conting_s[ll_row] = lo_Comum.ids_lista_registros.Object.conting_s[ll_Linha]
			lds_dados.object.conting_time[ll_row] = lo_Comum.ids_lista_registros.Object.conting_time[ll_Linha]
			lds_dados.object.contin_time_zone[ll_row] = lo_Comum.ids_lista_registros.Object.contin_time_zone[ll_Linha]
			
			If Not io_Comum.of_date_time(of_formata_data(lo_Comum.ids_lista_registros.Object.credat[ll_Linha]), 'CREDAT', ref ldt_credat, ref as_Log) Then Return False
			lds_dados.object.credat[ll_row] = ldt_credat
			
			lds_dados.object.crenam[ll_row] = lo_Comum.ids_lista_registros.Object.crenam[ll_Linha]
			lds_dados.object.direct[ll_row] = lo_Comum.ids_lista_registros.Object.direct[ll_Linha]
			lds_dados.object.docnum9[ll_row] = lo_Comum.ids_lista_registros.Object.docnum9[ll_Linha]
			lds_dados.object.docsta[ll_row] = lo_Comum.ids_lista_registros.Object.docsta[ll_Linha]
			lds_dados.object.event_flag[ll_row] = lo_Comum.ids_lista_registros.Object.event_flag[ll_Linha]
			lds_dados.object.form[ll_row] = lo_Comum.ids_lista_registros.Object.form[ll_Linha]
			lds_dados.object.model[ll_row] = long(lo_Comum.ids_lista_registros.Object.model[ll_Linha])
			lds_dados.object.msstat[ll_row] = lo_Comum.ids_lista_registros.Object.msstat[ll_Linha]
			lds_dados.object.nfmonth[ll_row] = lo_Comum.ids_lista_registros.Object.nfmonth[ll_Linha]
			lds_dados.object.nfnum9[ll_row] = lo_Comum.ids_lista_registros.Object.nfnum9[ll_Linha]
			lds_dados.object.nfse_check_code[ll_row] = lo_Comum.ids_lista_registros.Object.nfse_check_code[ll_Linha]
			lds_dados.object.nfse_number[ll_row] = lo_Comum.ids_lista_registros.Object.nfse_number[ll_Linha]
			lds_dados.object.nfyear[ll_row] = lo_Comum.ids_lista_registros.Object.nfyear[ll_Linha]
			lds_dados.object.parid[ll_row] = lo_Comum.ids_lista_registros.Object.parid[ll_Linha]
			lds_dados.object.partyp[ll_row] = lo_Comum.ids_lista_registros.Object.partyp[ll_Linha]
			lds_dados.object.printd[ll_row] = lo_Comum.ids_lista_registros.Object.printd[ll_Linha]
			lds_dados.object.reason[ll_row] = lo_Comum.ids_lista_registros.Object.reason[ll_Linha]
			lds_dados.object.reason1[ll_row] = lo_Comum.ids_lista_registros.Object.reason1[ll_Linha]
			lds_dados.object.reason2[ll_row] = lo_Comum.ids_lista_registros.Object.reason2[ll_Linha]
			lds_dados.object.reason3[ll_row] = lo_Comum.ids_lista_registros.Object.reason3[ll_Linha]
			lds_dados.object.reason4[ll_row] = lo_Comum.ids_lista_registros.Object.reason4[ll_Linha]
			lds_dados.object.reason_conting[ll_row] = lo_Comum.ids_lista_registros.Object.reason_conting[ll_Linha]
			lds_dados.object.reason_conting1[ll_row] = lo_Comum.ids_lista_registros.Object.reason_conting1[ll_Linha]
			lds_dados.object.reason_conting2[ll_row] = lo_Comum.ids_lista_registros.Object.reason_conting2[ll_Linha]
			lds_dados.object.reason_conting3[ll_row] = lo_Comum.ids_lista_registros.Object.reason_conting3[ll_Linha]
			lds_dados.object.reason_conting4[ll_row] = lo_Comum.ids_lista_registros.Object.reason_conting4[ll_Linha]
			lds_dados.object.refnum[ll_row] = long(lo_Comum.ids_lista_registros.Object.refnum[ll_Linha])
			lds_dados.object.regio[ll_row] = lo_Comum.ids_lista_registros.Object.regio[ll_Linha]
			lds_dados.object.rps[ll_row] = long(lo_Comum.ids_lista_registros.Object.rps[ll_Linha])
			lds_dados.object.scan_active[ll_row] = lo_Comum.ids_lista_registros.Object.scan_active[ll_Linha]
			lds_dados.object.scssta[ll_row] = lo_Comum.ids_lista_registros.Object.scssta[ll_Linha]
			lds_dados.object.sefaz_active[ll_row] = lo_Comum.ids_lista_registros.Object.sefaz_active[ll_Linha]
			lds_dados.object.serie[ll_row] = lo_Comum.ids_lista_registros.Object.serie[ll_Linha]
			lds_dados.object.source[ll_row] = lo_Comum.ids_lista_registros.Object.source[ll_Linha]
			lds_dados.object.stcd1[ll_row] = lo_Comum.ids_lista_registros.Object.stcd1[ll_Linha]
			lds_dados.object.svc_active[ll_row] = lo_Comum.ids_lista_registros.Object.svc_active[ll_Linha]
			lds_dados.object.svc_rs_active[ll_row] = lo_Comum.ids_lista_registros.Object.svc_rs_active[ll_Linha]
			lds_dados.object.svc_sp_active[ll_row] = lo_Comum.ids_lista_registros.Object.svc_sp_active[ll_Linha]
			lds_dados.object.tpamb[ll_row] = lo_Comum.ids_lista_registros.Object.tpamb[ll_Linha]
			lds_dados.object.tpemis[ll_row] = lo_Comum.ids_lista_registros.Object.tpemis[ll_Linha]
			lds_dados.object.vstel[ll_row] = lo_Comum.ids_lista_registros.Object.vstel[ll_Linha]
			lds_dados.object.xmsg[ll_row] = lo_Comum.ids_lista_registros.Object.xmsg[ll_Linha]

		Next	
	Else
		Return False				
	End If	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_ge473_nota_fiscal_sap.of_insere_cancelamento'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_atualiza_cnpj (ref string ps_log);Long		lvl_for, lvl_nr_controle
String 	lvs_vl_item, lvs_cnpj, lvs_Select, lvs_Syntax, lvs_err
dc_uo_ds_base lds

Try
	// Criar DS com o select dos controles e tags
	lds = CREATE dc_uo_ds_base
	
	lvs_Select = 	"select "+&
						"	isapi.nr_controle, "+&
						"	isapi.vl_item "+&
						"from "+&
						"	interface_sap isap (index idx_situacao) "+&
						"	inner join interface_sap_item isapi (index PK_INTERFACE_SAP_ITEM) "+&
						"		on isapi.nr_controle = isap.nr_controle "+&
						"		and isapi.cd_coluna = 'XML' "+&
						"		and isapi.nr_item = 1 "+&
						"where "+&
						"	isap.cd_tabela = 73 "+&
						"	and isap.id_situacao = 'C' "+&
						"	and isap.cd_varchar is null "
	
	lvs_Syntax = SQLCA.SyntaxFromSQL(lvs_Select, '', ref lvs_err)
	If lds.Create(lvs_Syntax) = -1 Then
		ps_log = "Interface Nota Fiscal - Erro ao criar datastore - uo_ge473_nota_fiscal_sap.of_atualiza_cnpj - "+lvs_err
		Return False
	End If
	lds.of_SetTransObject(SQLCA)
	
	// Carregar os controles
	If lds.Retrieve() = -1 Then
		ps_log = "Interface Nota Fiscal - Erro ao recuperar controles - uo_ge473_nota_fiscal_sap.of_atualiza_cnpj - "+SQLCA.is_lasterrortext
		Return False
	End If
	
	// Percorrer os controles e atualizar o cd_varchar com o CNPJ
	For lvl_for = 1 To lds.RowCount()
		lvs_cnpj = ''
		lvl_nr_controle = lds.GetItemNumber(lvl_for, "isapi_nr_controle")
		lvs_vl_item 	 = lds.GetItemString(lvl_for, "isapi_vl_item")
		
		// Pegar o CNPJ da tag <cgc>
		If Pos(lvs_vl_item, '<cgc>') > 0 Then
			lvs_cnpj = Trim(Mid(lvs_vl_item, Pos(lvs_vl_item, '<cgc>') + 5, Pos(lvs_vl_item, '</cgc>') - Pos(lvs_vl_item, '<cgc>') - 5))
		End If
		
		// Se n$$HEX1$$e300$$ENDHEX$$o tiver um CNPJ pula
		If Len(lvs_cnpj) <> 14 Then Continue
	
		// Se tiver CNPJ, atualiza o cd_varchar
		UPDATE interface_sap 
		SET 	cd_varchar = :lvs_cnpj
		WHERE nr_controle = :lvl_nr_controle
		USING SQLCA;
		
		If SQLCA.SqlCode = -1 Then 
			ps_log = "Interface Nota Fiscal - Erro ao atualizar interface_sap.cd_varchar - uo_ge473_nota_fiscal_sap.of_atualiza_cnpj - "+SQLCA.SqlErrText
			Return False
		End If
		
		SQLCA.of_Commit()
	
	Next
	
	Return True
	
Finally
	Destroy lds
End Try
end function

public function boolean of_atualiza_campo_contrato (long al_docnum, string as_mandt, ref string as_log);/*O SAP faz algumas vezes o envio do campo contrato nulo quando envia a segunda vez a nota
Temos um bug que ainda n$$HEX1$$e300$$ENDHEX$$o foi corrigido que est$$HEX1$$e100$$ENDHEX$$ fazendo reenviar v$$HEX1$$e100$$ENDHEX$$rias vezes para o legado e essas vezes o campo vem nulo.
Dessa forma n$$HEX1$$e300$$ENDHEX$$o estamos conseguindo importar o registro.
Para isso essa fun$$HEX2$$e700e300$$ENDHEX$$o serve para pegar o contrato enviado a primeira vez pelo SAP e replicado para a vers$$HEX1$$e300$$ENDHEX$$o atual.*/

Boolean	lb_retorno = true


Try
	UPDATE
		dbo.j_1bnflin 
	SET 
		contrato = (
			SELECT 
				jlin.contrato 
			FROM
				j_1bnflin jlin 
			WHERE jlin.docnum 		= j_1bnflin.docnum 
			AND jlin.nr_sequencial 	= 1 
			AND jlin.mandt 			= j_1bnflin.mandt 
			AND jlin.itmnum 			= j_1bnflin.itmnum)
	WHERE 
		docnum = :al_docnum
		AND mandt = :as_mandt
		AND nr_sequencial >= 2
		AND contrato is null;
		
	Choose Case SQLCA.SQLCode
		Case -1
			as_log	= "Erro ao atualizar contrato vazio na j_1bnflin. ~r~rObjeto: uo_ge473_nota_fiscal_sap~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_campo_contrato~r~rErro: " + SQLCA.SQLErrText
			
			lb_retorno	= False
			
			Return lb_retorno
	End Choose
Catch (RunTimeError RTE)
	as_log	= "Erro ao atualizar contrato vazio na j_1bnflin. ~r~rObjeto: uo_ge473_nota_fiscal_sap~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_campo_contrato~r~rErro: " + RTE.GetMessage()
	
	lb_retorno	= False
			
	Return lb_retorno
Finally
	Return lb_retorno
End Try
end function

public function boolean of_verificar_de_chave_sap (long al_controle, ref string as_chave_sap, ref string as_log);Select 
	de_chave_sap
Into 
	:as_chave_sap
From interface_sap
where nr_controle = :al_controle
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi encontrado nem uma informa$$HEX2$$e700e300$$ENDHEX$$o na coluna de_chave_sap da tabela interface_sap."
		Return False
	Case -1
		as_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da informa$$HEX2$$e700e300$$ENDHEX$$o da coluna de_chave_sap na tabela interface_sap" + SqlCa.SqlerrText
		Return False
End Choose

Return True
end function

on uo_ge473_nota_fiscal_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_nota_fiscal_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum

end event

event destructor;Destroy(io_Comum)

end event

