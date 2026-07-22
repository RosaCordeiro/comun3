HA$PBExportHeader$uo_ge473_contabil.sru
forward
global type uo_ge473_contabil from nonvisualobject
end type
end forward

global type uo_ge473_contabil from nonvisualobject
end type
global uo_ge473_contabil uo_ge473_contabil

type variables
uo_ge473_comum io_Comum

String is_chave_sap
Long il_Tabela = 78


end variables

forward prototypes
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_insere_item (long al_controle_pai, long al_sequencial, ref string as_log)
public function boolean of_gera_sequencial (string ps_mandt, string ps_bukrs, string ps_belnr, long pl_gjahr, ref long pl_sequencial, ref string ps_log)
public function boolean of_atualiza_contabil (long al_controle, long al_tabela)
end prototypes

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha
long ll_controle
dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Nota Fiscal - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_contabil.of_processa_atualizacao" )
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
			
			uo_ge473_contabil lo_contabil
			 
			Try
				lo_contabil	= Create uo_ge473_contabil
				lo_contabil.of_atualiza_contabil( ll_controle , il_Tabela )
			Finally
				Destroy(lo_contabil)
			End Try			
			
			w_aguarde_3.uo_progress.of_setprogress(ll_linha)
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Nota Fiscal - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_contabil.of_processa_atualizacao.")
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

public function boolean of_insere_item (long al_controle_pai, long al_sequencial, ref string as_log);long ll_controle_filho, ll_linha, ll_row, ll_existe
string ls_chave_sap_item, ls_mandt, ls_bukrs, ls_belnr
long ll_buzei, ll_gjahr
boolean lb_sucesso=true

dc_uo_ds_base lds_bseg_1, lds_bseg_2, lds_bseg_3

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_item
	FROM interface_sap  i 
	Where i.cd_tabela = 79
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	ls_chave_sap_item = gf_Tira_Zero_Esquerda(ls_chave_sap_item)
	
	if (ll_controle_filho = 0 or isnull(ll_controle_filho) ) Then

			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ informa$$HEX2$$e700f500$$ENDHEX$$es contabil na tabela interface_sap."
			return false

	end if
	
	lds_bseg_1 = create dc_uo_ds_base
	lds_bseg_1.of_changedataobject( 'ds_ge473_contabil_bseg_1' )
	
	lds_bseg_2 = create dc_uo_ds_base
	lds_bseg_2.of_changedataobject( 'ds_ge473_contabil_bseg_2' )
	
	lds_bseg_3 = create dc_uo_ds_base
	lds_bseg_3.of_changedataobject( 'ds_ge473_contabil_bseg_3' )
	
	uo_ge473_comum lo_Comum
 	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then	
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ls_mandt = lo_Comum.ids_lista_registros.object.mandt[ll_Linha]
			ls_bukrs = lo_Comum.ids_lista_registros.object.bukrs[ll_Linha]
			ls_belnr = lo_Comum.ids_lista_registros.object.belnr[ll_Linha]
			ll_gjahr = long(lo_Comum.ids_lista_registros.object.gjahr[ll_Linha])
			ll_buzei = long(lo_Comum.ids_lista_registros.object.buzei[ll_Linha])	
			
			ll_row =  lds_bseg_1.insertrow( ll_linha )
			
			lds_bseg_1.object.mandt[ll_row] =ls_mandt
			lds_bseg_1.object.bukrs[ll_row] =ls_bukrs
			lds_bseg_1.object.belnr[ll_row] = ls_belnr
			lds_bseg_1.object.gjahr[ll_row] =ll_gjahr
			lds_bseg_1.object.buzei[ll_row] = ll_buzei
			lds_bseg_1.object.nr_sequencial[ll_row] = al_sequencial
			
			lds_bseg_1.object.abper[ll_row] = lo_Comum.ids_lista_registros.object.abper[ll_Linha]
			lds_bseg_1.object.absbt[ll_row] = lo_Comum.ids_lista_registros.object.absbt[ll_Linha]
			lds_bseg_1.object.acritmtype[ll_row] = lo_Comum.ids_lista_registros.object.acritmtype[ll_Linha]
			lds_bseg_1.object.acrobjtype[ll_row] = lo_Comum.ids_lista_registros.object.acrobjtype[ll_Linha]
			lds_bseg_1.object.acrobj_id[ll_row] = lo_Comum.ids_lista_registros.object.acrobj_id[ll_Linha]
			lds_bseg_1.object.acrsobj_id[ll_row] = lo_Comum.ids_lista_registros.object.acrsobj_id[ll_Linha]
			lds_bseg_1.object.agzei[ll_row] = lo_Comum.ids_lista_registros.object.agzei[ll_Linha]
			lds_bseg_1.object.altkt[ll_row] = lo_Comum.ids_lista_registros.object.altkt[ll_Linha]
			lds_bseg_1.object.anbtr_pn[ll_row] = lo_Comum.ids_lista_registros.object.anbtr_pn[ll_Linha]
			lds_bseg_1.object.anbwa[ll_row] = lo_Comum.ids_lista_registros.object.anbwa[ll_Linha]
			lds_bseg_1.object.anfae[ll_row] = lo_Comum.ids_lista_registros.object.anfae[ll_Linha]
			lds_bseg_1.object.anfbj[ll_row] = lo_Comum.ids_lista_registros.object.anfbj[ll_Linha]
			lds_bseg_1.object.anfbn[ll_row] = lo_Comum.ids_lista_registros.object.anfbn[ll_Linha]
			lds_bseg_1.object.anfbu[ll_row] = lo_Comum.ids_lista_registros.object.anfbu[ll_Linha]
			lds_bseg_1.object.anln1[ll_row] = lo_Comum.ids_lista_registros.object.anln1[ll_Linha]
			lds_bseg_1.object.anln2[ll_row] = lo_Comum.ids_lista_registros.object.anln2[ll_Linha]
			lds_bseg_1.object.anln2_pn[ll_row] = lo_Comum.ids_lista_registros.object.anln2_pn[ll_Linha]
			lds_bseg_1.object.aplzl[ll_row] = lo_Comum.ids_lista_registros.object.aplzl[ll_Linha]
			lds_bseg_1.object.aufnr[ll_row] = lo_Comum.ids_lista_registros.object.aufnr[ll_Linha]
			lds_bseg_1.object.aufpl[ll_row] = lo_Comum.ids_lista_registros.object.aufpl[ll_Linha]
			lds_bseg_1.object.augbl[ll_row] = lo_Comum.ids_lista_registros.object.augbl[ll_Linha]
			lds_bseg_1.object.augcp[ll_row] = lo_Comum.ids_lista_registros.object.augcp[ll_Linha]
			lds_bseg_1.object.augdt[ll_row] = lo_Comum.ids_lista_registros.object.augdt[ll_Linha]
			lds_bseg_1.object.auggj[ll_row] = lo_Comum.ids_lista_registros.object.auggj[ll_Linha]
			lds_bseg_1.object.awkey[ll_row] = lo_Comum.ids_lista_registros.object.awkey[ll_Linha]
			lds_bseg_1.object.awsys[ll_row] = lo_Comum.ids_lista_registros.object.awsys[ll_Linha]
			lds_bseg_1.object.awtyp[ll_row] = lo_Comum.ids_lista_registros.object.awtyp[ll_Linha]
			lds_bseg_1.object.bdif2[ll_row] = lo_Comum.ids_lista_registros.object.bdif2[ll_Linha]
			lds_bseg_1.object.bdif3[ll_row] = lo_Comum.ids_lista_registros.object.bdif3[ll_Linha]
			lds_bseg_1.object.bdiff[ll_row] = lo_Comum.ids_lista_registros.object.bdiff[ll_Linha]
			lds_bseg_1.object.bewar[ll_row] = lo_Comum.ids_lista_registros.object.bewar[ll_Linha]
			lds_bseg_1.object.blnbt[ll_row] = lo_Comum.ids_lista_registros.object.blnbt[ll_Linha]
			lds_bseg_1.object.blnkz[ll_row] = lo_Comum.ids_lista_registros.object.blnkz[ll_Linha]
			lds_bseg_1.object.blnpz[ll_row] = lo_Comum.ids_lista_registros.object.blnpz[ll_Linha]
			lds_bseg_1.object.bonfb[ll_row] = lo_Comum.ids_lista_registros.object.bonfb[ll_Linha]
			lds_bseg_1.object.bpmng[ll_row] = lo_Comum.ids_lista_registros.object.bpmng[ll_Linha]
			lds_bseg_1.object.bprme[ll_row] = lo_Comum.ids_lista_registros.object.bprme[ll_Linha]
			lds_bseg_1.object.bschl[ll_row] = lo_Comum.ids_lista_registros.object.bschl[ll_Linha]
			lds_bseg_1.object.btype[ll_row] = lo_Comum.ids_lista_registros.object.btype[ll_Linha]
			lds_bseg_1.object.bualt[ll_row] = lo_Comum.ids_lista_registros.object.bualt[ll_Linha]
			lds_bseg_1.object.budget_pd[ll_row] = lo_Comum.ids_lista_registros.object.budget_pd[ll_Linha]
			lds_bseg_1.object.bupla[ll_row] = lo_Comum.ids_lista_registros.object.bupla[ll_Linha]
			lds_bseg_1.object.bustw[ll_row] = lo_Comum.ids_lista_registros.object.bustw[ll_Linha]
			lds_bseg_1.object.buzei_sender[ll_row] = lo_Comum.ids_lista_registros.object.buzei_sender[ll_Linha]
			lds_bseg_1.object.buzid[ll_row] = lo_Comum.ids_lista_registros.object.buzid[ll_Linha]
			lds_bseg_1.object.bvtyp[ll_row] = lo_Comum.ids_lista_registros.object.bvtyp[ll_Linha]
			lds_bseg_1.object.bwasl_pn[ll_row] = lo_Comum.ids_lista_registros.object.bwasl_pn[ll_Linha]
			lds_bseg_1.object.bwkey[ll_row] = lo_Comum.ids_lista_registros.object.bwkey[ll_Linha]
			lds_bseg_1.object.bwtar[ll_row] = lo_Comum.ids_lista_registros.object.bwtar[ll_Linha]
			lds_bseg_1.object.bzdat[ll_row] = lo_Comum.ids_lista_registros.object.bzdat[ll_Linha]
			lds_bseg_1.object.bzdat_pn[ll_row] = lo_Comum.ids_lista_registros.object.bzdat_pn[ll_Linha]
			lds_bseg_1.object.ccbtc[ll_row] = lo_Comum.ids_lista_registros.object.ccbtc[ll_Linha]
			lds_bseg_1.object.cession_kz[ll_row] = lo_Comum.ids_lista_registros.object.cession_kz[ll_Linha]
			lds_bseg_1.object.dabrz[ll_row] = lo_Comum.ids_lista_registros.object.dabrz[ll_Linha]
			lds_bseg_1.object.depot[ll_row] = lo_Comum.ids_lista_registros.object.depot[ll_Linha]
			lds_bseg_1.object.dh_vencimento[ll_row] = lo_Comum.ids_lista_registros.object.dh_vencimento[ll_Linha]
			lds_bseg_1.object.diekz[ll_row] = lo_Comum.ids_lista_registros.object.diekz[ll_Linha]
			lds_bseg_1.object.disbj[ll_row] = lo_Comum.ids_lista_registros.object.disbj[ll_Linha]
			lds_bseg_1.object.disbn[ll_row] = lo_Comum.ids_lista_registros.object.disbn[ll_Linha]
			lds_bseg_1.object.disbz[ll_row] = lo_Comum.ids_lista_registros.object.disbz[ll_Linha]
			lds_bseg_1.object.dmb21[ll_row] = lo_Comum.ids_lista_registros.object.dmb21[ll_Linha]
			lds_bseg_1.object.dmb22[ll_row] = lo_Comum.ids_lista_registros.object.dmb22[ll_Linha]
			lds_bseg_1.object.dmb23[ll_row] = lo_Comum.ids_lista_registros.object.dmb23[ll_Linha]
			lds_bseg_1.object.dmb31[ll_row] = lo_Comum.ids_lista_registros.object.dmb31[ll_Linha]
			lds_bseg_1.object.dmb32[ll_row] = lo_Comum.ids_lista_registros.object.dmb32[ll_Linha]
			lds_bseg_1.object.dmb33[ll_row] = lo_Comum.ids_lista_registros.object.dmb33[ll_Linha]
			lds_bseg_1.object.dmbe2[ll_row] = lo_Comum.ids_lista_registros.object.dmbe2[ll_Linha]
			lds_bseg_1.object.dmbe3[ll_row] = lo_Comum.ids_lista_registros.object.dmbe3[ll_Linha]
			lds_bseg_1.object.dmbt1[ll_row] = lo_Comum.ids_lista_registros.object.dmbt1[ll_Linha]
			lds_bseg_1.object.dmbt2[ll_row] = lo_Comum.ids_lista_registros.object.dmbt2[ll_Linha]
			lds_bseg_1.object.dmbt3[ll_row] = lo_Comum.ids_lista_registros.object.dmbt3[ll_Linha]
			lds_bseg_1.object.dmbtr[ll_row] = lo_Comum.ids_lista_registros.object.dmbtr[ll_Linha]
			lds_bseg_1.object.docln[ll_row] = lo_Comum.ids_lista_registros.object.docln[ll_Linha]
			lds_bseg_1.object.dtws1[ll_row] = lo_Comum.ids_lista_registros.object.dtws1[ll_Linha]
			lds_bseg_1.object.dtws2[ll_row] = lo_Comum.ids_lista_registros.object.dtws2[ll_Linha]
			lds_bseg_1.object.dtws3[ll_row] = lo_Comum.ids_lista_registros.object.dtws3[ll_Linha]
			lds_bseg_1.object.dtws4[ll_row] = lo_Comum.ids_lista_registros.object.dtws4[ll_Linha]
			lds_bseg_1.object.dummy_incl_eew_cobl[ll_row] = lo_Comum.ids_lista_registros.object.dummy_incl_eew_cobl[ll_Linha]
			lds_bseg_1.object.ebeln[ll_row] = lo_Comum.ids_lista_registros.object.ebeln[ll_Linha]
			lds_bseg_1.object.ebelp[ll_row] = lo_Comum.ids_lista_registros.object.ebelp[ll_Linha]
			lds_bseg_1.object.egbld[ll_row] = lo_Comum.ids_lista_registros.object.egbld[ll_Linha]
			lds_bseg_1.object.eglld[ll_row] = lo_Comum.ids_lista_registros.object.eglld[ll_Linha]
			lds_bseg_1.object.egrup[ll_row] = lo_Comum.ids_lista_registros.object.egrup[ll_Linha]
			lds_bseg_1.object.elikz[ll_row] = lo_Comum.ids_lista_registros.object.elikz[ll_Linha]
			lds_bseg_1.object.empfb[ll_row] = lo_Comum.ids_lista_registros.object.empfb[ll_Linha]
			lds_bseg_1.object.erfme[ll_row] = lo_Comum.ids_lista_registros.object.erfme[ll_Linha]
			lds_bseg_1.object.erfmg[ll_row] = lo_Comum.ids_lista_registros.object.erfmg[ll_Linha]
			lds_bseg_1.object.esrnr[ll_row] = lo_Comum.ids_lista_registros.object.esrnr[ll_Linha]
			lds_bseg_1.object.esrpz[ll_row] = lo_Comum.ids_lista_registros.object.esrpz[ll_Linha]
			lds_bseg_1.object.esrre[ll_row] = lo_Comum.ids_lista_registros.object.esrre[ll_Linha]
			lds_bseg_1.object.eten2[ll_row] = lo_Comum.ids_lista_registros.object.eten2[ll_Linha]
			lds_bseg_1.object.etype[ll_row] = lo_Comum.ids_lista_registros.object.etype[ll_Linha]
			lds_bseg_1.object.fastpay[ll_row] = lo_Comum.ids_lista_registros.object.fastpay[ll_Linha]
			lds_bseg_1.object.fdgrp[ll_row] = lo_Comum.ids_lista_registros.object.fdgrp[ll_Linha]
			lds_bseg_1.object.fdlev[ll_row] = lo_Comum.ids_lista_registros.object.fdlev[ll_Linha]
			lds_bseg_1.object.fdtag[ll_row] = lo_Comum.ids_lista_registros.object.fdtag[ll_Linha]
			lds_bseg_1.object.fdwbt[ll_row] = lo_Comum.ids_lista_registros.object.fdwbt[ll_Linha]
			lds_bseg_1.object.filkd[ll_row] = lo_Comum.ids_lista_registros.object.filkd[ll_Linha]
			lds_bseg_1.object.fipos[ll_row] = lo_Comum.ids_lista_registros.object.fipos[ll_Linha]
			lds_bseg_1.object.fistl[ll_row] = lo_Comum.ids_lista_registros.object.fistl[ll_Linha]
			lds_bseg_1.object.fkber[ll_row] = lo_Comum.ids_lista_registros.object.fkber[ll_Linha]
			lds_bseg_1.object.fkber_long[ll_row] = lo_Comum.ids_lista_registros.object.fkber_long[ll_Linha]
			lds_bseg_1.object.fkont[ll_row] = lo_Comum.ids_lista_registros.object.fkont[ll_Linha]
			lds_bseg_1.object.fmfgus_key[ll_row] = lo_Comum.ids_lista_registros.object.fmfgus_key[ll_Linha]
			lds_bseg_1.object.fmxdocln[ll_row] = lo_Comum.ids_lista_registros.object.fmxdocln[ll_Linha]
			lds_bseg_1.object.fmxdocnr[ll_row] = lo_Comum.ids_lista_registros.object.fmxdocnr[ll_Linha]
			lds_bseg_1.object.fmxyear[ll_row] = lo_Comum.ids_lista_registros.object.fmxyear[ll_Linha]
			lds_bseg_1.object.fmxzekkn[ll_row] = lo_Comum.ids_lista_registros.object.fmxzekkn[ll_Linha]
			lds_bseg_1.object.fqftype[ll_row] = lo_Comum.ids_lista_registros.object.fqftype[ll_Linha]
			lds_bseg_1.object.fwbas[ll_row] = lo_Comum.ids_lista_registros.object.fwbas[ll_Linha]
			lds_bseg_1.object.fwzuz[ll_row] = lo_Comum.ids_lista_registros.object.fwzuz[ll_Linha]
			lds_bseg_1.object.gbetr[ll_row] = lo_Comum.ids_lista_registros.object.gbetr[ll_Linha]
			lds_bseg_1.object.geber[ll_row] = lo_Comum.ids_lista_registros.object.geber[ll_Linha]
			lds_bseg_1.object.ghkon[ll_row] = lo_Comum.ids_lista_registros.object.ghkon[ll_Linha]
			lds_bseg_1.object.gityp[ll_row] = lo_Comum.ids_lista_registros.object.gityp[ll_Linha]
			lds_bseg_1.object.gkart[ll_row] = lo_Comum.ids_lista_registros.object.gkart[ll_Linha]
			lds_bseg_1.object.gkont[ll_row] = lo_Comum.ids_lista_registros.object.gkont[ll_Linha]
			lds_bseg_1.object.glupm[ll_row] = lo_Comum.ids_lista_registros.object.glupm[ll_Linha]
			lds_bseg_1.object.gmvkz[ll_row] = lo_Comum.ids_lista_registros.object.gmvkz[ll_Linha]
			lds_bseg_1.object.grant_nbr[ll_row] = lo_Comum.ids_lista_registros.object.grant_nbr[ll_Linha]
			lds_bseg_1.object.gricd[ll_row] = lo_Comum.ids_lista_registros.object.gricd[ll_Linha]

			ll_row =  lds_bseg_2.insertrow( ll_linha )
			
			lds_bseg_2.object.dh_vencimento[ll_row] = lo_Comum.ids_lista_registros.object.dh_vencimento[ll_Linha]
			
			lds_bseg_2.Object.mandt[ll_row] = lo_Comum.ids_lista_registros.Object.mandt[ll_Linha]
			lds_bseg_2.Object.bukrs[ll_row] = lo_Comum.ids_lista_registros.Object.bukrs[ll_Linha]
			lds_bseg_2.Object.belnr[ll_row] = lo_Comum.ids_lista_registros.Object.belnr[ll_Linha]
			lds_bseg_2.Object.gjahr[ll_row] = long(lo_Comum.ids_lista_registros.Object.gjahr[ll_Linha])
			lds_bseg_2.Object.buzei[ll_row] = long(lo_Comum.ids_lista_registros.Object.buzei[ll_Linha])
			lds_bseg_2.Object.nr_sequencial[ll_row] = al_sequencial
			
			lds_bseg_2.Object.grirg[ll_row] = lo_Comum.ids_lista_registros.Object.grirg[ll_Linha]
			lds_bseg_2.Object.ground_dt[ll_row] = lo_Comum.ids_lista_registros.Object.ground_dt[ll_Linha]
			lds_bseg_2.Object.ground_no[ll_row] = lo_Comum.ids_lista_registros.Object.ground_no[ll_Linha]
			lds_bseg_2.Object.ground_typ[ll_row] = lo_Comum.ids_lista_registros.Object.ground_typ[ll_Linha]
			lds_bseg_2.Object.gsber[ll_row] = lo_Comum.ids_lista_registros.Object.gsber[ll_Linha]
			lds_bseg_2.Object.gst_part[ll_row] = lo_Comum.ids_lista_registros.Object.gst_part[ll_Linha]
			lds_bseg_2.Object.gvtyp[ll_row] = lo_Comum.ids_lista_registros.Object.gvtyp[ll_Linha]
			lds_bseg_2.Object.hbkid[ll_row] = lo_Comum.ids_lista_registros.Object.hbkid[ll_Linha]
			lds_bseg_2.Object.hkont[ll_row] = lo_Comum.ids_lista_registros.Object.hkont[ll_Linha]
			lds_bseg_2.Object.hktid[ll_row] = lo_Comum.ids_lista_registros.Object.hktid[ll_Linha]
			lds_bseg_2.Object.hrkft[ll_row] = lo_Comum.ids_lista_registros.Object.hrkft[ll_Linha]
			lds_bseg_2.Object.hsn_sac[ll_row] = lo_Comum.ids_lista_registros.Object.hsn_sac[ll_Linha]
			lds_bseg_2.Object.hwbas[ll_row] = lo_Comum.ids_lista_registros.Object.hwbas[ll_Linha]
			lds_bseg_2.Object.hwmet[ll_row] = lo_Comum.ids_lista_registros.Object.hwmet[ll_Linha]
			lds_bseg_2.Object.hwzuz[ll_row] = lo_Comum.ids_lista_registros.Object.hwzuz[ll_Linha]
			lds_bseg_2.Object.hzuon[ll_row] = lo_Comum.ids_lista_registros.Object.hzuon[ll_Linha]
			lds_bseg_2.Object.h_blart[ll_row] = lo_Comum.ids_lista_registros.Object.h_blart[ll_Linha]
			lds_bseg_2.Object.h_bldat[ll_row] = lo_Comum.ids_lista_registros.Object.h_bldat[ll_Linha]
			lds_bseg_2.Object.h_bstat[ll_row] = lo_Comum.ids_lista_registros.Object.h_bstat[ll_Linha]
			lds_bseg_2.Object.h_budat[ll_row] = lo_Comum.ids_lista_registros.Object.h_budat[ll_Linha]
			lds_bseg_2.Object.h_hwae2[ll_row] = lo_Comum.ids_lista_registros.Object.h_hwae2[ll_Linha]
			lds_bseg_2.Object.h_hwae3[ll_row] = lo_Comum.ids_lista_registros.Object.h_hwae3[ll_Linha]
			lds_bseg_2.Object.h_hwaer[ll_row] = lo_Comum.ids_lista_registros.Object.h_hwaer[ll_Linha]
			lds_bseg_2.Object.h_monat[ll_row] = lo_Comum.ids_lista_registros.Object.h_monat[ll_Linha]
			lds_bseg_2.Object.h_waers[ll_row] = lo_Comum.ids_lista_registros.Object.h_waers[ll_Linha]
			lds_bseg_2.Object.idxsp[ll_row] = lo_Comum.ids_lista_registros.Object.idxsp[ll_Linha]
			lds_bseg_2.Object.ignr_ivref[ll_row] = lo_Comum.ids_lista_registros.Object.ignr_ivref[ll_Linha]
			lds_bseg_2.Object.imkey[ll_row] = lo_Comum.ids_lista_registros.Object.imkey[ll_Linha]
			lds_bseg_2.Object.intreno[ll_row] = lo_Comum.ids_lista_registros.Object.intreno[ll_Linha]
			lds_bseg_2.Object.inward_dt[ll_row] = lo_Comum.ids_lista_registros.Object.inward_dt[ll_Linha]
			lds_bseg_2.Object.inward_no[ll_row] = lo_Comum.ids_lista_registros.Object.inward_no[ll_Linha]
			lds_bseg_2.Object.j_1tpbupl[ll_row] = lo_Comum.ids_lista_registros.Object.j_1tpbupl[ll_Linha]
			lds_bseg_2.Object.kblnr[ll_row] = lo_Comum.ids_lista_registros.Object.kblnr[ll_Linha]
			lds_bseg_2.Object.kblpos[ll_row] = lo_Comum.ids_lista_registros.Object.kblpos[ll_Linha]
			lds_bseg_2.Object.kidno[ll_row] = lo_Comum.ids_lista_registros.Object.kidno[ll_Linha]
			lds_bseg_2.Object.kkber[ll_row] = lo_Comum.ids_lista_registros.Object.kkber[ll_Linha]
			lds_bseg_2.Object.klibt[ll_row] = lo_Comum.ids_lista_registros.Object.klibt[ll_Linha]
			lds_bseg_2.Object.koart[ll_row] = lo_Comum.ids_lista_registros.Object.koart[ll_Linha]
			lds_bseg_2.Object.kokrs[ll_row] = lo_Comum.ids_lista_registros.Object.kokrs[ll_Linha]
			lds_bseg_2.Object.kontl[ll_row] = lo_Comum.ids_lista_registros.Object.kontl[ll_Linha]
			lds_bseg_2.Object.kontt[ll_row] = lo_Comum.ids_lista_registros.Object.kontt[ll_Linha]
			lds_bseg_2.Object.kostl[ll_row] = lo_Comum.ids_lista_registros.Object.kostl[ll_Linha]
			lds_bseg_2.Object.kstar[ll_row] = lo_Comum.ids_lista_registros.Object.kstar[ll_Linha]
			lds_bseg_2.Object.kstrg[ll_row] = lo_Comum.ids_lista_registros.Object.kstrg[ll_Linha]
			lds_bseg_2.Object.ktosl[ll_row] = lo_Comum.ids_lista_registros.Object.ktosl[ll_Linha]
			lds_bseg_2.Object.kunnr[ll_row] = lo_Comum.ids_lista_registros.Object.kunnr[ll_Linha]
			lds_bseg_2.Object.kursr[ll_row] = lo_Comum.ids_lista_registros.Object.kursr[ll_Linha]
			lds_bseg_2.Object.kzbtr[ll_row] = lo_Comum.ids_lista_registros.Object.kzbtr[ll_Linha]
			lds_bseg_2.Object.landl[ll_row] = lo_Comum.ids_lista_registros.Object.landl[ll_Linha]
			lds_bseg_2.Object.lifnr[ll_row] = lo_Comum.ids_lista_registros.Object.lifnr[ll_Linha]
			lds_bseg_2.Object.linfv[ll_row] = lo_Comum.ids_lista_registros.Object.linfv[ll_Linha]
			lds_bseg_2.Object.lnran[ll_row] = lo_Comum.ids_lista_registros.Object.lnran[ll_Linha]
			lds_bseg_2.Object.lokkt[ll_row] = lo_Comum.ids_lista_registros.Object.lokkt[ll_Linha]
			lds_bseg_2.Object.lqitem[ll_row] = lo_Comum.ids_lista_registros.Object.lqitem[ll_Linha]
			lds_bseg_2.Object.lstar[ll_row] = lo_Comum.ids_lista_registros.Object.lstar[ll_Linha]
			lds_bseg_2.Object.lzbkz[ll_row] = lo_Comum.ids_lista_registros.Object.lzbkz[ll_Linha]
			lds_bseg_2.Object.maber[ll_row] = lo_Comum.ids_lista_registros.Object.maber[ll_Linha]
			lds_bseg_2.Object.madat[ll_row] = lo_Comum.ids_lista_registros.Object.madat[ll_Linha]
			lds_bseg_2.Object.mansp[ll_row] = lo_Comum.ids_lista_registros.Object.mansp[ll_Linha]
			lds_bseg_2.Object.manst[ll_row] = lo_Comum.ids_lista_registros.Object.manst[ll_Linha]
			lds_bseg_2.Object.matnr[ll_row] = lo_Comum.ids_lista_registros.Object.matnr[ll_Linha]
			lds_bseg_2.Object.measure[ll_row] = lo_Comum.ids_lista_registros.Object.measure[ll_Linha]
			lds_bseg_2.Object.meins[ll_row] = lo_Comum.ids_lista_registros.Object.meins[ll_Linha]
			lds_bseg_2.Object.menge[ll_row] = lo_Comum.ids_lista_registros.Object.menge[ll_Linha]
			lds_bseg_2.Object.mndid[ll_row] = lo_Comum.ids_lista_registros.Object.mndid[ll_Linha]
			lds_bseg_2.Object.mschl[ll_row] = lo_Comum.ids_lista_registros.Object.mschl[ll_Linha]
			lds_bseg_2.Object.mwart[ll_row] = lo_Comum.ids_lista_registros.Object.mwart[ll_Linha]
			lds_bseg_2.Object.mwsk1[ll_row] = lo_Comum.ids_lista_registros.Object.mwsk1[ll_Linha]
			lds_bseg_2.Object.mwsk2[ll_row] = lo_Comum.ids_lista_registros.Object.mwsk2[ll_Linha]
			lds_bseg_2.Object.mwsk3[ll_row] = lo_Comum.ids_lista_registros.Object.mwsk3[ll_Linha]
			lds_bseg_2.Object.mwskz[ll_row] = lo_Comum.ids_lista_registros.Object.mwskz[ll_Linha]
			lds_bseg_2.Object.mwst2[ll_row] = lo_Comum.ids_lista_registros.Object.mwst2[ll_Linha]
			lds_bseg_2.Object.mwst3[ll_row] = lo_Comum.ids_lista_registros.Object.mwst3[ll_Linha]
			lds_bseg_2.Object.mwsts[ll_row] = lo_Comum.ids_lista_registros.Object.mwsts[ll_Linha]
			lds_bseg_2.Object.navfw[ll_row] = lo_Comum.ids_lista_registros.Object.navfw[ll_Linha]
			lds_bseg_2.Object.navh2[ll_row] = lo_Comum.ids_lista_registros.Object.navh2[ll_Linha]
			lds_bseg_2.Object.navh3[ll_row] = lo_Comum.ids_lista_registros.Object.navh3[ll_Linha]
			lds_bseg_2.Object.navhw[ll_row] = lo_Comum.ids_lista_registros.Object.navhw[ll_Linha]
			lds_bseg_2.Object.nebtr[ll_row] = lo_Comum.ids_lista_registros.Object.nebtr[ll_Linha]
			lds_bseg_2.Object.netdt[ll_row] = lo_Comum.ids_lista_registros.Object.netdt[ll_Linha]
			lds_bseg_2.Object.nplnr[ll_row] = lo_Comum.ids_lista_registros.Object.nplnr[ll_Linha]
			lds_bseg_2.Object.nprei[ll_row] = lo_Comum.ids_lista_registros.Object.nprei[ll_Linha]
			lds_bseg_2.Object.nr_cgc[ll_row] = lo_Comum.ids_lista_registros.Object.nr_cgc[ll_Linha]
			lds_bseg_2.Object.obzei[ll_row] = lo_Comum.ids_lista_registros.Object.obzei[ll_Linha]
			lds_bseg_2.Object.paobjnr[ll_row] = lo_Comum.ids_lista_registros.Object.paobjnr[ll_Linha]
			lds_bseg_2.Object.pargb[ll_row] = lo_Comum.ids_lista_registros.Object.pargb[ll_Linha]
			lds_bseg_2.Object.pasubnr[ll_row] = lo_Comum.ids_lista_registros.Object.pasubnr[ll_Linha]
			lds_bseg_2.Object.pays_prov[ll_row] = lo_Comum.ids_lista_registros.Object.pays_prov[ll_Linha]
			lds_bseg_2.Object.pays_tran[ll_row] = lo_Comum.ids_lista_registros.Object.pays_tran[ll_Linha]
			lds_bseg_2.Object.pbudget_pd[ll_row] = lo_Comum.ids_lista_registros.Object.pbudget_pd[ll_Linha]
			lds_bseg_2.Object.peinh[ll_row] = lo_Comum.ids_lista_registros.Object.peinh[ll_Linha]
			lds_bseg_2.Object.pendays[ll_row] = lo_Comum.ids_lista_registros.Object.pendays[ll_Linha]
			lds_bseg_2.Object.penfc[ll_row] = lo_Comum.ids_lista_registros.Object.penfc[ll_Linha]
			lds_bseg_2.Object.penlc1[ll_row] = lo_Comum.ids_lista_registros.Object.penlc1[ll_Linha]
			lds_bseg_2.Object.penlc2[ll_row] = lo_Comum.ids_lista_registros.Object.penlc2[ll_Linha]
			lds_bseg_2.Object.penlc3[ll_row] = lo_Comum.ids_lista_registros.Object.penlc3[ll_Linha]
			lds_bseg_2.Object.penrc[ll_row] = lo_Comum.ids_lista_registros.Object.penrc[ll_Linha]
			lds_bseg_2.Object.pernr[ll_row] = lo_Comum.ids_lista_registros.Object.pernr[ll_Linha]
			lds_bseg_2.Object.perop_beg[ll_row] = lo_Comum.ids_lista_registros.Object.perop_beg[ll_Linha]
			lds_bseg_2.Object.perop_end[ll_row] = lo_Comum.ids_lista_registros.Object.perop_end[ll_Linha]
			lds_bseg_2.Object.pfkber[ll_row] = lo_Comum.ids_lista_registros.Object.pfkber[ll_Linha]
			lds_bseg_2.Object.pgeber[ll_row] = lo_Comum.ids_lista_registros.Object.pgeber[ll_Linha]
			lds_bseg_2.Object.pgrant_nbr[ll_row] = lo_Comum.ids_lista_registros.Object.pgrant_nbr[ll_Linha]
			lds_bseg_2.Object.plc_sup[ll_row] = lo_Comum.ids_lista_registros.Object.plc_sup[ll_Linha]
			lds_bseg_2.Object.popts[ll_row] = lo_Comum.ids_lista_registros.Object.popts[ll_Linha]
			lds_bseg_2.Object.posn2[ll_row] = lo_Comum.ids_lista_registros.Object.posn2[ll_Linha]
			lds_bseg_2.Object.posnr[ll_row] = lo_Comum.ids_lista_registros.Object.posnr[ll_Linha]
			lds_bseg_2.Object.ppa_ex_ind[ll_row] = lo_Comum.ids_lista_registros.Object.ppa_ex_ind[ll_Linha]
			lds_bseg_2.Object.ppdif2[ll_row] = lo_Comum.ids_lista_registros.Object.ppdif2[ll_Linha]
			lds_bseg_2.Object.ppdif3[ll_row] = lo_Comum.ids_lista_registros.Object.ppdif3[ll_Linha]
			lds_bseg_2.Object.ppdiff[ll_row] = lo_Comum.ids_lista_registros.Object.ppdiff[ll_Linha]
			lds_bseg_2.Object.pprct[ll_row] = lo_Comum.ids_lista_registros.Object.pprct[ll_Linha]
			lds_bseg_2.Object.prctr[ll_row] = lo_Comum.ids_lista_registros.Object.prctr[ll_Linha]
			lds_bseg_2.Object.prodper[ll_row] = lo_Comum.ids_lista_registros.Object.prodper[ll_Linha]
			lds_bseg_2.Object.projk[ll_row] = lo_Comum.ids_lista_registros.Object.projk[ll_Linha]
			lds_bseg_2.Object.projn[ll_row] = lo_Comum.ids_lista_registros.Object.projn[ll_Linha]
			lds_bseg_2.Object.prozs_pn[ll_row] = lo_Comum.ids_lista_registros.Object.prozs_pn[ll_Linha]
			lds_bseg_2.Object.prznr[ll_row] = lo_Comum.ids_lista_registros.Object.prznr[ll_Linha]
			lds_bseg_2.Object.psalt[ll_row] = lo_Comum.ids_lista_registros.Object.psalt[ll_Linha]
			lds_bseg_2.Object.psegment[ll_row] = lo_Comum.ids_lista_registros.Object.psegment[ll_Linha]
			lds_bseg_2.Object.pswbt[ll_row] = lo_Comum.ids_lista_registros.Object.pswbt[ll_Linha]
			lds_bseg_2.Object.pswsl[ll_row] = lo_Comum.ids_lista_registros.Object.pswsl[ll_Linha]
			lds_bseg_2.Object.pyamt[ll_row] = lo_Comum.ids_lista_registros.Object.pyamt[ll_Linha]
			lds_bseg_2.Object.pycur [ll_row] = lo_Comum.ids_lista_registros.Object.pycur [ll_Linha]

			ll_row =  lds_bseg_3.insertrow( ll_linha )
			
			lds_bseg_3.Object.mandt[ll_row] = lo_Comum.ids_lista_registros.Object.mandt[ll_Linha]
			lds_bseg_3.Object.bukrs[ll_row] = lo_Comum.ids_lista_registros.Object.bukrs[ll_Linha]
			lds_bseg_3.Object.belnr[ll_row] = lo_Comum.ids_lista_registros.Object.belnr[ll_Linha]
			lds_bseg_3.Object.gjahr[ll_row] = long(lo_Comum.ids_lista_registros.Object.gjahr[ll_Linha])
			lds_bseg_3.Object.buzei[ll_row] = long(lo_Comum.ids_lista_registros.Object.buzei[ll_Linha])
			lds_bseg_3.Object.nr_sequencial[ll_row] = al_sequencial
			
			lds_bseg_3.Object.pymtkey[ll_row] = lo_Comum.ids_lista_registros.Object.pymtkey[ll_Linha]
			lds_bseg_3.Object.qbshb[ll_row] = lo_Comum.ids_lista_registros.Object.qbshb[ll_Linha]
			lds_bseg_3.Object.qsfbt[ll_row] = lo_Comum.ids_lista_registros.Object.qsfbt[ll_Linha]
			lds_bseg_3.Object.qsshb[ll_row] = lo_Comum.ids_lista_registros.Object.qsshb[ll_Linha]
			lds_bseg_3.Object.qsskz[ll_row] = lo_Comum.ids_lista_registros.Object.qsskz[ll_Linha]
			lds_bseg_3.Object.qsznr[ll_row] = lo_Comum.ids_lista_registros.Object.qsznr[ll_Linha]
			lds_bseg_3.Object.rdif2[ll_row] = lo_Comum.ids_lista_registros.Object.rdif2[ll_Linha]
			lds_bseg_3.Object.rdif3[ll_row] = lo_Comum.ids_lista_registros.Object.rdif3[ll_Linha]
			lds_bseg_3.Object.rdiff[ll_row] = lo_Comum.ids_lista_registros.Object.rdiff[ll_Linha]
			lds_bseg_3.Object.rebzg[ll_row] = lo_Comum.ids_lista_registros.Object.rebzg[ll_Linha]
			lds_bseg_3.Object.rebzj[ll_row] = lo_Comum.ids_lista_registros.Object.rebzj[ll_Linha]
			lds_bseg_3.Object.rebzt[ll_row] = lo_Comum.ids_lista_registros.Object.rebzt[ll_Linha]
			lds_bseg_3.Object.rebzz[ll_row] = lo_Comum.ids_lista_registros.Object.rebzz[ll_Linha]
			lds_bseg_3.Object.recid[ll_row] = lo_Comum.ids_lista_registros.Object.recid[ll_Linha]
			lds_bseg_3.Object.recrf[ll_row] = lo_Comum.ids_lista_registros.Object.recrf[ll_Linha]
			lds_bseg_3.Object.rewrt[ll_row] = lo_Comum.ids_lista_registros.Object.rewrt[ll_Linha]
			lds_bseg_3.Object.rewwr[ll_row] = lo_Comum.ids_lista_registros.Object.rewwr[ll_Linha]
			lds_bseg_3.Object.re_account[ll_row] = lo_Comum.ids_lista_registros.Object.re_account[ll_Linha]
			lds_bseg_3.Object.re_bukrs[ll_row] = lo_Comum.ids_lista_registros.Object.re_bukrs[ll_Linha]
			lds_bseg_3.Object.rfzei[ll_row] = lo_Comum.ids_lista_registros.Object.rfzei[ll_Linha]
			lds_bseg_3.Object.rpacq[ll_row] = lo_Comum.ids_lista_registros.Object.rpacq[ll_Linha]
			lds_bseg_3.Object.rstgr[ll_row] = lo_Comum.ids_lista_registros.Object.rstgr[ll_Linha]
			lds_bseg_3.Object.ryacq[ll_row] = lo_Comum.ids_lista_registros.Object.ryacq[ll_Linha]
			lds_bseg_3.Object.saknr[ll_row] = lo_Comum.ids_lista_registros.Object.saknr[ll_Linha]
			lds_bseg_3.Object.samnr[ll_row] = lo_Comum.ids_lista_registros.Object.samnr[ll_Linha]
			lds_bseg_3.Object.sctax[ll_row] = lo_Comum.ids_lista_registros.Object.sctax[ll_Linha]
			lds_bseg_3.Object.secco[ll_row] = lo_Comum.ids_lista_registros.Object.secco[ll_Linha]
			lds_bseg_3.Object.segment[ll_row] = lo_Comum.ids_lista_registros.Object.segment[ll_Linha]
			lds_bseg_3.Object.sgtxt[ll_row] = lo_Comum.ids_lista_registros.Object.sgtxt[ll_Linha]
			lds_bseg_3.Object.shkzg[ll_row] = lo_Comum.ids_lista_registros.Object.shkzg[ll_Linha]
			lds_bseg_3.Object.shzuz[ll_row] = lo_Comum.ids_lista_registros.Object.shzuz[ll_Linha]
			lds_bseg_3.Object.sk1dt[ll_row] = lo_Comum.ids_lista_registros.Object.sk1dt[ll_Linha]
			lds_bseg_3.Object.sk2dt[ll_row] = lo_Comum.ids_lista_registros.Object.sk2dt[ll_Linha]
			lds_bseg_3.Object.skfbt[ll_row] = lo_Comum.ids_lista_registros.Object.skfbt[ll_Linha]
			lds_bseg_3.Object.sknt2[ll_row] = lo_Comum.ids_lista_registros.Object.sknt2[ll_Linha]
			lds_bseg_3.Object.sknt3[ll_row] = lo_Comum.ids_lista_registros.Object.sknt3[ll_Linha]
			lds_bseg_3.Object.sknto[ll_row] = lo_Comum.ids_lista_registros.Object.sknto[ll_Linha]
			lds_bseg_3.Object.spgrc[ll_row] = lo_Comum.ids_lista_registros.Object.spgrc[ll_Linha]
			lds_bseg_3.Object.spgrg[ll_row] = lo_Comum.ids_lista_registros.Object.spgrg[ll_Linha]
			lds_bseg_3.Object.spgrm[ll_row] = lo_Comum.ids_lista_registros.Object.spgrm[ll_Linha]
			lds_bseg_3.Object.spgrp[ll_row] = lo_Comum.ids_lista_registros.Object.spgrp[ll_Linha]
			lds_bseg_3.Object.spgrq[ll_row] = lo_Comum.ids_lista_registros.Object.spgrq[ll_Linha]
			lds_bseg_3.Object.spgrs[ll_row] = lo_Comum.ids_lista_registros.Object.spgrs[ll_Linha]
			lds_bseg_3.Object.spgrt[ll_row] = lo_Comum.ids_lista_registros.Object.spgrt[ll_Linha]
			lds_bseg_3.Object.spgrv[ll_row] = lo_Comum.ids_lista_registros.Object.spgrv[ll_Linha]
			lds_bseg_3.Object.squan[ll_row] = lo_Comum.ids_lista_registros.Object.squan[ll_Linha]
			lds_bseg_3.Object.srtype[ll_row] = lo_Comum.ids_lista_registros.Object.srtype[ll_Linha]
			lds_bseg_3.Object.stbuk[ll_row] = lo_Comum.ids_lista_registros.Object.stbuk[ll_Linha]
			lds_bseg_3.Object.stceg[ll_row] = lo_Comum.ids_lista_registros.Object.stceg[ll_Linha]
			lds_bseg_3.Object.stekz[ll_row] = lo_Comum.ids_lista_registros.Object.stekz[ll_Linha]
			lds_bseg_3.Object.sttax[ll_row] = lo_Comum.ids_lista_registros.Object.sttax[ll_Linha]
			lds_bseg_3.Object.taxps[ll_row] = lo_Comum.ids_lista_registros.Object.taxps[ll_Linha]
			lds_bseg_3.Object.tbtkz[ll_row] = lo_Comum.ids_lista_registros.Object.tbtkz[ll_Linha]
			lds_bseg_3.Object.txbfw[ll_row] = lo_Comum.ids_lista_registros.Object.txbfw[ll_Linha]
			lds_bseg_3.Object.txbh2[ll_row] = lo_Comum.ids_lista_registros.Object.txbh2[ll_Linha]
			lds_bseg_3.Object.txbh3[ll_row] = lo_Comum.ids_lista_registros.Object.txbh3[ll_Linha]
			lds_bseg_3.Object.txbhw[ll_row] = lo_Comum.ids_lista_registros.Object.txbhw[ll_Linha]
			lds_bseg_3.Object.txdat[ll_row] = lo_Comum.ids_lista_registros.Object.txdat[ll_Linha]
			lds_bseg_3.Object.txgrp[ll_row] = lo_Comum.ids_lista_registros.Object.txgrp[ll_Linha]
			lds_bseg_3.Object.txjcd[ll_row] = lo_Comum.ids_lista_registros.Object.txjcd[ll_Linha]
			lds_bseg_3.Object.uebgdat[ll_row] = lo_Comum.ids_lista_registros.Object.uebgdat[ll_Linha]
			lds_bseg_3.Object.umsks[ll_row] = lo_Comum.ids_lista_registros.Object.umsks[ll_Linha]
			lds_bseg_3.Object.umskz[ll_row] = lo_Comum.ids_lista_registros.Object.umskz[ll_Linha]
			lds_bseg_3.Object.uzawe[ll_row] = lo_Comum.ids_lista_registros.Object.uzawe[ll_Linha]
			lds_bseg_3.Object.valut[ll_row] = lo_Comum.ids_lista_registros.Object.valut[ll_Linha]
			lds_bseg_3.Object.vbel2[ll_row] = lo_Comum.ids_lista_registros.Object.vbel2[ll_Linha]
			lds_bseg_3.Object.vbeln[ll_row] = lo_Comum.ids_lista_registros.Object.vbeln[ll_Linha]
			lds_bseg_3.Object.vbewa[ll_row] = lo_Comum.ids_lista_registros.Object.vbewa[ll_Linha]
			lds_bseg_3.Object.vbund[ll_row] = lo_Comum.ids_lista_registros.Object.vbund[ll_Linha]
			lds_bseg_3.Object.vertn[ll_row] = lo_Comum.ids_lista_registros.Object.vertn[ll_Linha]
			lds_bseg_3.Object.vertt[ll_row] = lo_Comum.ids_lista_registros.Object.vertt[ll_Linha]
			lds_bseg_3.Object.vname[ll_row] = lo_Comum.ids_lista_registros.Object.vname[ll_Linha]
			lds_bseg_3.Object.vorgn[ll_row] = lo_Comum.ids_lista_registros.Object.vorgn[ll_Linha]
			lds_bseg_3.Object.vprsv[ll_row] = lo_Comum.ids_lista_registros.Object.vprsv[ll_Linha]
			lds_bseg_3.Object.vptnr[ll_row] = lo_Comum.ids_lista_registros.Object.vptnr[ll_Linha]
			lds_bseg_3.Object.vrsdt[ll_row] = lo_Comum.ids_lista_registros.Object.vrsdt[ll_Linha]
			lds_bseg_3.Object.vrskz[ll_row] = lo_Comum.ids_lista_registros.Object.vrskz[ll_Linha]
			lds_bseg_3.Object.werks[ll_row] = lo_Comum.ids_lista_registros.Object.werks[ll_Linha]
			lds_bseg_3.Object.wmwst[ll_row] = lo_Comum.ids_lista_registros.Object.wmwst[ll_Linha]
			lds_bseg_3.Object.wrbt1[ll_row] = lo_Comum.ids_lista_registros.Object.wrbt1[ll_Linha]
			lds_bseg_3.Object.wrbt2[ll_row] = lo_Comum.ids_lista_registros.Object.wrbt2[ll_Linha]
			lds_bseg_3.Object.wrbt3[ll_row] = lo_Comum.ids_lista_registros.Object.wrbt3[ll_Linha]
			lds_bseg_3.Object.wrbtr[ll_row] = lo_Comum.ids_lista_registros.Object.wrbtr[ll_Linha]
			lds_bseg_3.Object.wskto[ll_row] = lo_Comum.ids_lista_registros.Object.wskto[ll_Linha]
			lds_bseg_3.Object.wverw[ll_row] = lo_Comum.ids_lista_registros.Object.wverw[ll_Linha]
			lds_bseg_3.Object.xanet[ll_row] = lo_Comum.ids_lista_registros.Object.xanet[ll_Linha]
			lds_bseg_3.Object.xauto[ll_row] = lo_Comum.ids_lista_registros.Object.xauto[ll_Linha]
			lds_bseg_3.Object.xbilk[ll_row] = lo_Comum.ids_lista_registros.Object.xbilk[ll_Linha]
			lds_bseg_3.Object.xcpdd[ll_row] = lo_Comum.ids_lista_registros.Object.xcpdd[ll_Linha]
			lds_bseg_3.Object.xegdr[ll_row] = lo_Comum.ids_lista_registros.Object.xegdr[ll_Linha]
			lds_bseg_3.Object.xfakt[ll_row] = lo_Comum.ids_lista_registros.Object.xfakt[ll_Linha]
			lds_bseg_3.Object.xfrge_bseg[ll_row] = lo_Comum.ids_lista_registros.Object.xfrge_bseg[ll_Linha]
			lds_bseg_3.Object.xhkom[ll_row] = lo_Comum.ids_lista_registros.Object.xhkom[ll_Linha]
			lds_bseg_3.Object.xhres[ll_row] = lo_Comum.ids_lista_registros.Object.xhres[ll_Linha]
			lds_bseg_3.Object.xinve[ll_row] = lo_Comum.ids_lista_registros.Object.xinve[ll_Linha]
			lds_bseg_3.Object.xkres[ll_row] = lo_Comum.ids_lista_registros.Object.xkres[ll_Linha]
			lds_bseg_3.Object.xlgclr[ll_row] = lo_Comum.ids_lista_registros.Object.xlgclr[ll_Linha]
			lds_bseg_3.Object.xncop[ll_row] = lo_Comum.ids_lista_registros.Object.xncop[ll_Linha]
			lds_bseg_3.Object.xnegp[ll_row] = lo_Comum.ids_lista_registros.Object.xnegp[ll_Linha]
			lds_bseg_3.Object.xopvw[ll_row] = lo_Comum.ids_lista_registros.Object.xopvw[ll_Linha]
			lds_bseg_3.Object.xpanz[ll_row] = lo_Comum.ids_lista_registros.Object.xpanz[ll_Linha]
			lds_bseg_3.Object.xpypr[ll_row] = lo_Comum.ids_lista_registros.Object.xpypr[ll_Linha]
			lds_bseg_3.Object.xragl[ll_row] = lo_Comum.ids_lista_registros.Object.xragl[ll_Linha]
			lds_bseg_3.Object.xref1[ll_row] = lo_Comum.ids_lista_registros.Object.xref1[ll_Linha]
			lds_bseg_3.Object.xref2[ll_row] = lo_Comum.ids_lista_registros.Object.xref2[ll_Linha]
			lds_bseg_3.Object.xref3[ll_row] = lo_Comum.ids_lista_registros.Object.xref3[ll_Linha]
			lds_bseg_3.Object.xsauf[ll_row] = lo_Comum.ids_lista_registros.Object.xsauf[ll_Linha]
			lds_bseg_3.Object.xserg[ll_row] = lo_Comum.ids_lista_registros.Object.xserg[ll_Linha]
			lds_bseg_3.Object.xskrl[ll_row] = lo_Comum.ids_lista_registros.Object.xskrl[ll_Linha]
			lds_bseg_3.Object.xskst[ll_row] = lo_Comum.ids_lista_registros.Object.xskst[ll_Linha]
			lds_bseg_3.Object.xspro[ll_row] = lo_Comum.ids_lista_registros.Object.xspro[ll_Linha]
			lds_bseg_3.Object.xuman[ll_row] = lo_Comum.ids_lista_registros.Object.xuman[ll_Linha]
			lds_bseg_3.Object.xumsw[ll_row] = lo_Comum.ids_lista_registros.Object.xumsw[ll_Linha]
			lds_bseg_3.Object.xvabg_pn[ll_row] = lo_Comum.ids_lista_registros.Object.xvabg_pn[ll_Linha]
			lds_bseg_3.Object.xzahl[ll_row] = lo_Comum.ids_lista_registros.Object.xzahl[ll_Linha]
			lds_bseg_3.Object.zbd1p[ll_row] = lo_Comum.ids_lista_registros.Object.zbd1p[ll_Linha]
			lds_bseg_3.Object.zbd1t[ll_row] = lo_Comum.ids_lista_registros.Object.zbd1t[ll_Linha]
			lds_bseg_3.Object.zbd2p[ll_row] = lo_Comum.ids_lista_registros.Object.zbd2p[ll_Linha]
			lds_bseg_3.Object.zbd2t[ll_row] = lo_Comum.ids_lista_registros.Object.zbd2t[ll_Linha]
			lds_bseg_3.Object.zbd3t[ll_row] = lo_Comum.ids_lista_registros.Object.zbd3t[ll_Linha]
			lds_bseg_3.Object.zbfix[ll_row] = lo_Comum.ids_lista_registros.Object.zbfix[ll_Linha]
			lds_bseg_3.Object.zekkn[ll_row] = lo_Comum.ids_lista_registros.Object.zekkn[ll_Linha]
			lds_bseg_3.Object.zfbdt[ll_row] = lo_Comum.ids_lista_registros.Object.zfbdt[ll_Linha]
			lds_bseg_3.Object.zinkz[ll_row] = lo_Comum.ids_lista_registros.Object.zinkz[ll_Linha]
			lds_bseg_3.Object.zlsch[ll_row] = lo_Comum.ids_lista_registros.Object.zlsch[ll_Linha]
			lds_bseg_3.Object.zlspr[ll_row] = lo_Comum.ids_lista_registros.Object.zlspr[ll_Linha]
			lds_bseg_3.Object.zolld[ll_row] = lo_Comum.ids_lista_registros.Object.zolld[ll_Linha]
			lds_bseg_3.Object.zollt[ll_row] = lo_Comum.ids_lista_registros.Object.zollt[ll_Linha]
			lds_bseg_3.Object.zterm[ll_row] = lo_Comum.ids_lista_registros.Object.zterm[ll_Linha]
			lds_bseg_3.Object.zumsk[ll_row] = lo_Comum.ids_lista_registros.Object.zumsk[ll_Linha]
			lds_bseg_3.Object.zuonr[ll_row] = lo_Comum.ids_lista_registros.Object.zuonr[ll_Linha]
			lds_bseg_3.Object.cdataaging[ll_row] = lo_Comum.ids_lista_registros.Object.cdataaging[ll_Linha]

			
		Next	
	Else
		Return False				
	End If
	
	if lds_bseg_1.update( ) < 0 then
		lb_sucesso = false
		as_log = 'Erro ao inserir registros na tabela "bseg_1".'
		return false
	end if
	
//	if lds_bseg_1.update( ) < 0 Then
//		lb_sucesso = false
//		as_log = 'Erro ao inserir registros na tabela "bseg_1".'
//		return false
//	end if
	
	if lds_bseg_2.update( ) < 0 Then
		lb_sucesso = false
		as_log = 'Erro ao inserir registros na tabela "bseg_2".'
		return false
	end if
	
	if lds_bseg_3.update( ) < 0 Then
		lb_sucesso = false
		as_log = 'Erro ao inserir registros na tabela "bseg_3".'
		return false
	end if
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_ge473_contabil.of_insere_item'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
	
//	if lb_sucesso = True Then
//		Commit;
//	else
//		Rollback;
//	end if
	
End Try	

Return True
end function

public function boolean of_gera_sequencial (string ps_mandt, string ps_bukrs, string ps_belnr, long pl_gjahr, ref long pl_sequencial, ref string ps_log);long ll_seq

select Max(nr_sequencial)
into :ll_seq
from bkpf
where mandt = :ps_mandt
	and bukrs = :ps_bukrs
	and belnr = :ps_belnr
	and gjahr = :pl_gjahr;

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: '	 + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_gera_sequencial' + '~nProblemas ao consultar a tabela "bkpf": ' + sqlca.sqlerrtext
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

public function boolean of_atualiza_contabil (long al_controle, long al_tabela);dc_uo_ds_base lds, lds_dados

Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente, ll_row,ll_existe
		
String	ls_Log
String ls_mandt, ls_bukrs, ls_belnr
Long ll_docnum, ll_sequencial, ll_gjahr			
Boolean	lb_Sucesso = False

Try
	
	if Not io_Comum.of_atualizacao_pendente( al_controle, ref ll_registro_pendente, ref ls_log) Then 
		return false
	end if
		
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_registro_pendente = 0 Then Return True
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	if Not this.of_carrega_chave( al_controle, ref is_chave_sap, ref ls_log ) Then Return False
	
	uo_ge473_comum lo_Comum
 	lo_Comum = Create uo_ge473_comum
	
	lds_dados = create dc_uo_ds_base
	
	lds_dados.of_changedataobject( 'ds_ge473_contabil_bkpf')
	
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

			ls_mandt = lo_Comum.ids_lista_registros.Object.mandt[ll_Linha]
			ls_bukrs = lo_Comum.ids_lista_registros.Object.bukrs[ll_Linha]
			ls_belnr = lo_Comum.ids_lista_registros.Object.belnr[ll_Linha]
			ll_gjahr = long(lo_Comum.ids_lista_registros.Object.gjahr[ll_Linha])
			
			If Not this.of_gera_sequencial( ls_mandt, ls_bukrs, ls_belnr, ll_gjahr, ref ll_sequencial, ref ls_log ) then 
				lb_sucesso = false
				return false
			end if
			
			Select count(*)
			into :ll_existe
			from bkpf
			where mandt = :ls_mandt
				and bukrs = :ls_bukrs
				and belnr = :ls_belnr
				and gjahr = :ll_gjahr
				and nr_sequencial = :ll_sequencial;
				
			If sqlca.sqlcode = -1 then 
				ls_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_contabil' + '~nProblemas ao consultar a tabela "BKPF": ' + sqlca.sqlerrtext
				lb_sucesso = false
				return false
			end if
				
			if ll_existe > 0 Then
				ls_log = 'Registro j$$HEX1$$e100$$ENDHEX$$ existe no banco de dados: Tabela BKPF [mandt = ' + ls_mandt + '; bukrs = ' + ls_bukrs + '; belnr = ' + ls_belnr + '; gjahr = ' + string(ll_gjahr) + '; nr_sequencial = ' + string(ll_sequencial) + ']'
				lb_sucesso = false
				return false
			end if
			
			ll_row = lds_dados.insertrow(ll_linha)
			
			lds_dados.object.mandt[ll_row] = ls_mandt
			lds_dados.object.bukrs[ll_row] = ls_bukrs
			lds_dados.object.belnr[ll_row] = ls_belnr
			lds_dados.object.gjahr[ll_row] = ll_gjahr
			
			lds_dados.object.acc_principle[ll_row] = lo_Comum.ids_lista_registros.Object.acc_principle[ll_Linha]
			lds_dados.object.adisc[ll_row] = lo_Comum.ids_lista_registros.Object.adisc[ll_Linha]
			lds_dados.object.aedat[ll_row] = lo_Comum.ids_lista_registros.Object.aedat[ll_Linha]
			lds_dados.object.afabespec_pn[ll_row] = lo_Comum.ids_lista_registros.Object.afabespec_pn[ll_Linha]
			lds_dados.object.anxamnt[ll_row] = lo_Comum.ids_lista_registros.Object.anxamnt[ll_Linha]
			lds_dados.object.anxperc[ll_row] = lo_Comum.ids_lista_registros.Object.anxperc[ll_Linha]
			lds_dados.object.anxtype[ll_row] = lo_Comum.ids_lista_registros.Object.anxtype[ll_Linha]
			lds_dados.object.arcid[ll_row] = lo_Comum.ids_lista_registros.Object.arcid[ll_Linha]
			lds_dados.object.ausbk[ll_row] = lo_Comum.ids_lista_registros.Object.ausbk[ll_Linha]
			lds_dados.object.awkey[ll_row] = lo_Comum.ids_lista_registros.Object.awkey[ll_Linha]
			lds_dados.object.aworg_rev[ll_row] = lo_Comum.ids_lista_registros.Object.aworg_rev[ll_Linha]
			lds_dados.object.awref_rev[ll_row] = lo_Comum.ids_lista_registros.Object.awref_rev[ll_Linha]
			lds_dados.object.awsys[ll_row] = lo_Comum.ids_lista_registros.Object.awsys[ll_Linha]
			lds_dados.object.awtyp[ll_row] = lo_Comum.ids_lista_registros.Object.awtyp[ll_Linha]
			lds_dados.object.basw2[ll_row] = lo_Comum.ids_lista_registros.Object.basw2[ll_Linha]
			lds_dados.object.basw3[ll_row] = lo_Comum.ids_lista_registros.Object.basw3[ll_Linha]
			lds_dados.object.batch[ll_row] = lo_Comum.ids_lista_registros.Object.belnr_sender[ll_Linha]
			lds_dados.object.bktxt[ll_row] = lo_Comum.ids_lista_registros.Object.bktxt[ll_Linha]
			lds_dados.object.blart[ll_row] = lo_Comum.ids_lista_registros.Object.blart[ll_Linha]
			lds_dados.object.bldat[ll_row] = lo_Comum.ids_lista_registros.Object.bldat[ll_Linha]
			lds_dados.object.blind[ll_row] = lo_Comum.ids_lista_registros.Object.blind[ll_Linha]
			lds_dados.object.blo[ll_row] = lo_Comum.ids_lista_registros.Object.blo[ll_Linha]
			lds_dados.object.brnch[ll_row] = lo_Comum.ids_lista_registros.Object.brnch[ll_Linha]
			lds_dados.object.bstat[ll_row] = lo_Comum.ids_lista_registros.Object.bstat[ll_Linha]
			lds_dados.object.budat[ll_row] = lo_Comum.ids_lista_registros.Object.budat[ll_Linha]
			lds_dados.object.bukrs_sender[ll_row] = lo_Comum.ids_lista_registros.Object.bukrs_sender[ll_Linha]
			lds_dados.object.bvorg[ll_row] = lo_Comum.ids_lista_registros.Object.bvorg[ll_Linha]
			lds_dados.object.cash_alloc[ll_row] = lo_Comum.ids_lista_registros.Object.cash_alloc[ll_Linha]
			lds_dados.object.ccins[ll_row] = lo_Comum.ids_lista_registros.Object.ccins[ll_Linha]
			lds_dados.object.ccnum[ll_row] = lo_Comum.ids_lista_registros.Object.ccnum[ll_Linha]
			lds_dados.object.cnt[ll_row] = lo_Comum.ids_lista_registros.Object.cnt[ll_Linha]
			lds_dados.object.co_alebn[ll_row] = lo_Comum.ids_lista_registros.Object.co_alebn[ll_Linha]
			lds_dados.object.co_belnr_sender[ll_row] = lo_Comum.ids_lista_registros.Object.co_belnr_sender[ll_Linha]
			lds_dados.object.co_refbt[ll_row] = lo_Comum.ids_lista_registros.Object.co_refbt[ll_Linha]
			lds_dados.object.co_valdt[ll_row] = lo_Comum.ids_lista_registros.Object.co_valdt[ll_Linha]
			lds_dados.object.co_vrgng[ll_row] = lo_Comum.ids_lista_registros.Object.co_vrgng[ll_Linha]
			lds_dados.object.cpudt[ll_row] = lo_Comum.ids_lista_registros.Object.cpudt[ll_Linha]
			lds_dados.object.cputm[ll_row] = lo_Comum.ids_lista_registros.Object.cputm[ll_Linha]
			lds_dados.object.ctxkrs[ll_row] = lo_Comum.ids_lista_registros.Object.ctxkrs[ll_Linha]
			lds_dados.object.curt2[ll_row] = lo_Comum.ids_lista_registros.Object.curt2[ll_Linha]
			lds_dados.object.curt3[ll_row] = lo_Comum.ids_lista_registros.Object.curt3[ll_Linha]
			lds_dados.object.dbblg[ll_row] = lo_Comum.ids_lista_registros.Object.dbblg[ll_Linha]
			lds_dados.object.dbblg_bukrs[ll_row] = lo_Comum.ids_lista_registros.Object.dbblg_bukrs[ll_Linha]
			lds_dados.object.dbblg_gjahr[ll_row] = lo_Comum.ids_lista_registros.Object.dbblg_gjahr[ll_Linha]
			lds_dados.object.doccat[ll_row] = lo_Comum.ids_lista_registros.Object.doccat[ll_Linha]
			lds_dados.object.dokid[ll_row] = lo_Comum.ids_lista_registros.Object.dokid[ll_Linha]
			lds_dados.object.duefl[ll_row] = lo_Comum.ids_lista_registros.Object.duefl[ll_Linha]
			lds_dados.object.exclude_flag[ll_row] = lo_Comum.ids_lista_registros.Object.exclude_flag[ll_Linha]
			lds_dados.object.fikrs[ll_row] = lo_Comum.ids_lista_registros.Object.fikrs[ll_Linha]
			lds_dados.object.fm_umart[ll_row] = lo_Comum.ids_lista_registros.Object.fm_umart[ll_Linha]
			lds_dados.object.follow_on[ll_row] = lo_Comum.ids_lista_registros.Object.follow_on[ll_Linha]
			lds_dados.object.frath[ll_row] = lo_Comum.ids_lista_registros.Object.frath[ll_Linha]
			lds_dados.object.gjahr_sender[ll_row] = lo_Comum.ids_lista_registros.Object.gjahr_sender[ll_Linha]
			lds_dados.object.glbtgrp[ll_row] = lo_Comum.ids_lista_registros.Object.glbtgrp[ll_Linha]
			lds_dados.object.glvor[ll_row] = lo_Comum.ids_lista_registros.Object.glvor[ll_Linha]
			lds_dados.object.grpid[ll_row] = lo_Comum.ids_lista_registros.Object.grpid[ll_Linha]
			lds_dados.object.hwae2[ll_row] = lo_Comum.ids_lista_registros.Object.hwae2[ll_Linha]
			lds_dados.object.hwae3[ll_row] = lo_Comum.ids_lista_registros.Object.hwae3[ll_Linha]
			lds_dados.object.hwaer[ll_row] = lo_Comum.ids_lista_registros.Object.hwaer[ll_Linha]
			lds_dados.object.iblar[ll_row] = lo_Comum.ids_lista_registros.Object.iblar[ll_Linha]
			lds_dados.object.intdate[ll_row] = lo_Comum.ids_lista_registros.Object.intdate[ll_Linha]
			lds_dados.object.intform[ll_row] = lo_Comum.ids_lista_registros.Object.intform[ll_Linha]
			lds_dados.object.intsubid[ll_row] = lo_Comum.ids_lista_registros.Object.intsubid[ll_Linha]
			lds_dados.object.inwarddt_hd[ll_row] = lo_Comum.ids_lista_registros.Object.inwarddt_hd[ll_Linha]
			lds_dados.object.inwardno_hd[ll_row] = lo_Comum.ids_lista_registros.Object.inwardno_hd[ll_Linha]
			lds_dados.object.knumv[ll_row] = lo_Comum.ids_lista_registros.Object.knumv[ll_Linha]
			lds_dados.object.kokrs_sender[ll_row] = lo_Comum.ids_lista_registros.Object.kokrs_sender[ll_Linha]
			lds_dados.object.kur2x[ll_row] = lo_Comum.ids_lista_registros.Object.kur2x[ll_Linha]
			lds_dados.object.kur3x[ll_row] = lo_Comum.ids_lista_registros.Object.kur3x[ll_Linha]
			lds_dados.object.kurs2[ll_row] = lo_Comum.ids_lista_registros.Object.kurs2[ll_Linha]
			lds_dados.object.kurs3[ll_row] = lo_Comum.ids_lista_registros.Object.kurs3[ll_Linha]
			lds_dados.object.kursf[ll_row] = lo_Comum.ids_lista_registros.Object.kursf[ll_Linha]
			lds_dados.object.kurst[ll_row] = lo_Comum.ids_lista_registros.Object.kurst[ll_Linha]
			lds_dados.object.kursx[ll_row] = lo_Comum.ids_lista_registros.Object.kursx[ll_Linha]
			lds_dados.object.kuty2[ll_row] = lo_Comum.ids_lista_registros.Object.kuty2[ll_Linha]
			lds_dados.object.kuty3[ll_row] = lo_Comum.ids_lista_registros.Object.kuty3[ll_Linha]
			lds_dados.object.kzkrs[ll_row] = lo_Comum.ids_lista_registros.Object.kzkrs[ll_Linha]
			lds_dados.object.kzwrs[ll_row] = lo_Comum.ids_lista_registros.Object.kzwrs[ll_Linha]
			lds_dados.object.ldgrp[ll_row] = lo_Comum.ids_lista_registros.Object.ldgrp[ll_Linha]
			lds_dados.object.ldgrpspec_pn[ll_row] = lo_Comum.ids_lista_registros.Object.ldgrpspec_pn[ll_Linha]
			lds_dados.object.logsystem_sender[ll_row] = lo_Comum.ids_lista_registros.Object.logsystem_sender[ll_Linha]
			lds_dados.object.lotkz[ll_row] = lo_Comum.ids_lista_registros.Object.lotkz[ll_Linha]
			lds_dados.object.monat[ll_row] = lo_Comum.ids_lista_registros.Object.monat[ll_Linha]
			lds_dados.object.numpg[ll_row] = lo_Comum.ids_lista_registros.Object.numpg[ll_Linha]
			lds_dados.object.offset_refer_dat[ll_row] = lo_Comum.ids_lista_registros.Object.offset_refer_dat[ll_Linha]
			lds_dados.object.offset_status[ll_row] = lo_Comum.ids_lista_registros.Object.offset_status[ll_Linha]
			lds_dados.object.penrc[ll_row] = lo_Comum.ids_lista_registros.Object.penrc[ll_Linha]
			lds_dados.object.ppdat[ll_row] = lo_Comum.ids_lista_registros.Object.ppdat[ll_Linha]
			lds_dados.object.ppnam[ll_row] = lo_Comum.ids_lista_registros.Object.ppnam[ll_Linha]
			lds_dados.object.pptme[ll_row] = lo_Comum.ids_lista_registros.Object.pptme[ll_Linha]
			lds_dados.object.propmano[ll_row] = lo_Comum.ids_lista_registros.Object.propmano[ll_Linha]
			lds_dados.object.psoak[ll_row] = lo_Comum.ids_lista_registros.Object.psoak[ll_Linha]
			lds_dados.object.psobt[ll_row] = lo_Comum.ids_lista_registros.Object.psobt[ll_Linha]
			lds_dados.object.psodt[ll_row] = lo_Comum.ids_lista_registros.Object.psodt[ll_Linha]
			lds_dados.object.psofn[ll_row] = lo_Comum.ids_lista_registros.Object.psofn[ll_Linha]
			lds_dados.object.psoks[ll_row] = lo_Comum.ids_lista_registros.Object.psoks[ll_Linha]
			lds_dados.object.psosg[ll_row] = lo_Comum.ids_lista_registros.Object.psosg[ll_Linha]
			lds_dados.object.psotm[ll_row] = lo_Comum.ids_lista_registros.Object.psotm[ll_Linha]
			lds_dados.object.psoty[ll_row] = lo_Comum.ids_lista_registros.Object.psoty[ll_Linha]
			lds_dados.object.psozl[ll_row] = lo_Comum.ids_lista_registros.Object.psozl[ll_Linha]
			lds_dados.object.pybasdat[ll_row] = lo_Comum.ids_lista_registros.Object.pybasdat[ll_Linha]
			lds_dados.object.pybasno[ll_row] = lo_Comum.ids_lista_registros.Object.pybasno[ll_Linha]
			lds_dados.object.pybastyp[ll_row] = lo_Comum.ids_lista_registros.Object.pybastyp[ll_Linha]
			lds_dados.object.pyiban[ll_row] = lo_Comum.ids_lista_registros.Object.pyiban[ll_Linha]
			lds_dados.object.reindat[ll_row] = lo_Comum.ids_lista_registros.Object.reindat[ll_Linha]
			lds_dados.object.reprocessing_status_code[ll_row] = lo_Comum.ids_lista_registros.Object.reprocessing_status_code[ll_Linha]
			lds_dados.object.resubmission[ll_row] = lo_Comum.ids_lista_registros.Object.resubmission[ll_Linha]
			lds_dados.object.rldnr[ll_row] = lo_Comum.ids_lista_registros.Object.rldnr[ll_Linha]
			lds_dados.object.sampled[ll_row] = lo_Comum.ids_lista_registros.Object.sampled[ll_Linha]
			lds_dados.object.sname[ll_row] = lo_Comum.ids_lista_registros.Object.sname[ll_Linha]
			lds_dados.object.ssblk[ll_row] = lo_Comum.ids_lista_registros.Object.ssblk[ll_Linha]
			lds_dados.object.status[ll_row] = lo_Comum.ids_lista_registros.Object.status[ll_Linha]
			lds_dados.object.stblg[ll_row] = lo_Comum.ids_lista_registros.Object.stblg[ll_Linha]
			lds_dados.object.stgrd[ll_row] = lo_Comum.ids_lista_registros.Object.stgrd[ll_Linha]
			lds_dados.object.stjah[ll_row] = lo_Comum.ids_lista_registros.Object.stjah[ll_Linha]
			lds_dados.object.stodt[ll_row] = lo_Comum.ids_lista_registros.Object.stodt[ll_Linha]
			lds_dados.object.subset[ll_row] = lo_Comum.ids_lista_registros.Object.subset[ll_Linha]
			lds_dados.object.tcode[ll_row] = lo_Comum.ids_lista_registros.Object.tcode[ll_Linha]
			lds_dados.object.trava_pn[ll_row] = lo_Comum.ids_lista_registros.Object.trava_pn[ll_Linha]
			lds_dados.object.trr_partial_ind[ll_row] = lo_Comum.ids_lista_registros.Object.trr_partial_ind[ll_Linha]
			lds_dados.object.txkrs[ll_row] = lo_Comum.ids_lista_registros.Object.txkrs[ll_Linha]
			lds_dados.object.umrd2[ll_row] = lo_Comum.ids_lista_registros.Object.umrd2[ll_Linha]
			lds_dados.object.umrd3[ll_row] = lo_Comum.ids_lista_registros.Object.umrd3[ll_Linha]
			lds_dados.object.upddt[ll_row] = lo_Comum.ids_lista_registros.Object.upddt[ll_Linha]
			lds_dados.object.usnam[ll_row] = lo_Comum.ids_lista_registros.Object.usnam[ll_Linha]
			lds_dados.object.vatdate[ll_row] = lo_Comum.ids_lista_registros.Object.vatdate[ll_Linha]
			lds_dados.object.waers[ll_row] = lo_Comum.ids_lista_registros.Object.waers[ll_Linha]
			lds_dados.object.wwert[ll_row] = lo_Comum.ids_lista_registros.Object.wwert[ll_Linha]
			lds_dados.object.xblnr[ll_row] = lo_Comum.ids_lista_registros.Object.xblnr[ll_Linha]
			lds_dados.object.xblnr_alt[ll_row] = lo_Comum.ids_lista_registros.Object.xblnr_alt[ll_Linha]
			lds_dados.object.xmca[ll_row] = lo_Comum.ids_lista_registros.Object.xmca[ll_Linha]
			lds_dados.object.xmwst[ll_row] = lo_Comum.ids_lista_registros.Object.xmwst[ll_Linha]
			lds_dados.object.xnetb[ll_row] = lo_Comum.ids_lista_registros.Object.xnetb[ll_Linha]
			lds_dados.object.xref1_hd[ll_row] = lo_Comum.ids_lista_registros.Object.xref1_hd[ll_Linha]
			lds_dados.object.xref2_hd[ll_row] = lo_Comum.ids_lista_registros.Object.xref2_hd[ll_Linha]
			lds_dados.object.xreorg[ll_row] = lo_Comum.ids_lista_registros.Object.xreorg[ll_Linha]
			lds_dados.object.xreversal[ll_row] = lo_Comum.ids_lista_registros.Object.xreversal[ll_Linha]
			lds_dados.object.xreversed[ll_row] = lo_Comum.ids_lista_registros.Object.xreversed[ll_Linha]
			lds_dados.object.xreversing[ll_row] = lo_Comum.ids_lista_registros.Object.xreversing[ll_Linha]
			lds_dados.object.xrueb[ll_row] = lo_Comum.ids_lista_registros.Object.xrueb[ll_Linha]
			lds_dados.object.xsecondary[ll_row] = lo_Comum.ids_lista_registros.Object.xsecondary[ll_Linha]
			lds_dados.object.xsnet[ll_row] = lo_Comum.ids_lista_registros.Object.xsnet[ll_Linha]
			lds_dados.object.xsplit[ll_row] = lo_Comum.ids_lista_registros.Object.xsplit[ll_Linha]
			lds_dados.object.xstov[ll_row] = lo_Comum.ids_lista_registros.Object.xstov[ll_Linha]
			lds_dados.object.xusvr[ll_row] = lo_Comum.ids_lista_registros.Object.xusvr[ll_Linha]
			lds_dados.object.xwvof[ll_row] = lo_Comum.ids_lista_registros.Object.xwvof[ll_Linha]
			lds_dados.object.zvat_indc[ll_row] = lo_Comum.ids_lista_registros.Object.zvat_indc[ll_Linha]
			lds_dados.object.cdataaging[ll_row] = lo_Comum.ids_lista_registros.Object.cdataaging[ll_Linha]
			lds_dados.object.id_status[ll_row] = 'C'
//			lds_dados.object.de_log[ll_row] = 
			lds_dados.object.dh_inclusao[ll_row] = gf_getserverdate()
//			lds_dados.object.dh_processamento[ll_row] = 

			lds_dados.object.nr_sequencial[ll_row] = ll_sequencial

//			if lds_dados.of_update( ) = false then 
//				ls_log = 'erro'
//				return false
//			end if

			if lds_dados.update( ) < 0 Then
				ls_log = 'Erro ao inserir registros na tabela "bkpf".'
				return false
			end if
			
			If Not this.of_insere_item( al_controle, ll_sequencial, ref ls_log ) Then 
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
	ls_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_ge473_contabil.of_atualiza_contabil'. Erro: "+lo_rte.GetMessage( )
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

on uo_ge473_contabil.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_contabil.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

