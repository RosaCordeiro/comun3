HA$PBExportHeader$uo_ge473_wms_nf_compra.sru
forward
global type uo_ge473_wms_nf_compra from nonvisualobject
end type
end forward

global type uo_ge473_wms_nf_compra from nonvisualobject
end type
global uo_ge473_wms_nf_compra uo_ge473_wms_nf_compra

type variables
String is_de_chave_acesso_sap
//***cabecalho da nota*****
String is_de_chave_acesso
String is_de_dados_adicionais
String is_de_natureza_operacao
String is_de_serie
String is_nm_razao_social
String is_nr_cgc_fornecedor
String is_id_modalidade_frete
DateTime idt_dh_emissao
Long il_nr_nf
Long il_nr_pedido_central
Decimal ide_qt_volumes
Decimal ide_vl_bc_icms
Decimal ide_vl_bc_icms_st
Decimal ide_vl_desconto
Decimal ide_vl_frete
Decimal ide_vl_icms
Decimal ide_vl_icms_st
Decimal ide_vl_ipi
Decimal ide_vl_outras_despesas
Decimal ide_vl_seguro
Decimal ide_vl_total_nf
Decimal ide_vl_total_produtos
//*********************
//***Item da Nota*********
Long il_cd_produto
String is_cd_cprod
String is_de_codigo_barras
String is_de_produto
Long il_nr_classificacao_fiscal
Long il_cd_natureza_operacao
Long il_nr_item_pedido
String is_cd_cst_tributacao
String is_de_codigo_barras_trib
String is_cd_cst_pis
String is_cd_cst_cofins
String is_cd_mod_bc_icms
String is_cd_unidade_comercial
String is_cd_unidade_tributavel
String is_cd_beneficio
String is_cd_mod_bc_st
String is_cd_cest
Decimal ide_vl_preco_unitario
Decimal ide_vl_bc_ipi
Decimal ide_vl_preco_unitario_tributado
Decimal ide_vl_pis
Decimal ide_vl_cofins
Decimal ide_vl_icms_operacao
Decimal ide_vl_icms_dif
Decimal ide_vl_bc_icms_st_retido
Decimal ide_vl_icms_st_retido
Decimal ide_vl_total_item
Decimal ide_vl_desconto_total
Decimal ide_qt_faturada
Decimal ide_pc_reducao_bc_icms
Decimal ide_pc_icms
Decimal ide_pc_reducao_bc_icms_st
Decimal ide_pc_icms_st
Decimal ide_pc_ipi
Decimal ide_qt_tributada
Decimal ide_pc_dif_icms
Decimal ide_qt_comercial
Decimal ide_qt_tributavel
Decimal ide_pc_st_retido
Decimal ide_vl_icms_retido
Decimal ide_pc_mva
Long il_nr_item
Long il_nr_sequencial
//*********************
//*****Lote da nota*******
DateTime idt_dh_fabricacao
DateTime idt_dh_validade
String is_nr_lote
Long il_qt_lote
//*********************
//****Titulo da Nota********
DateTime idt_dh_vencimento
string is_nr_titulo_pagar
Decimal ide_vl_pagar
//**********************
Long il_Tabela = 88
Long il_nr_requisicao

boolean ib_execucao_simultanea=false

//Reforma tribut$$HEX1$$e100$$ENDHEX$$ria
String 	is_cd_cst_is, is_cd_classificacao_trib_is, is_cd_un_trib_is, is_cd_cst_ibscbs, is_cd_class_trib_ibscbs, is_cd_cst_ibscbs_reg, &
			is_cd_class_trib_ibscbs_reg
Dec{2}	idc_vl_bc_is, idc_vl_is, idc_vl_bc_ibscbs, idc_vl_ibs, idc_vl_ibs_uf, idc_vl_dif_ibs_uf, idc_vl_dev_trib_ibs_uf, &
			idc_vl_ibs_mun, idc_vl_dif_ibs_mun, idc_vl_dev_trib_ibs_mun, idc_vl_dif_cbs, idc_vl_dev_trib_cbs, idc_vl_cbs, idc_vl_trib_reg_ibs_uf, &
			idc_vl_trib_reg_ibs_mun, idc_vl_trib_reg_cbs
Dec{4}	idc_pc_is, idc_pc_is_espec, idc_qt_trib_is, idc_pc_ibs_uf, idc_pc_dif_ibs_uf, idc_pc_reducao_ibs_uf, idc_pc_efetiva_ibs_uf, &
			idc_pc_ibs_mun, idc_pc_dif_ibs_mun, idc_pc_reducao_ibs_mun, idc_pc_efetiva_ibs_mun, idc_pc_cbs, idc_pc_dif_cbs, idc_pc_reducao_cbs, &
			idc_pc_efetiva_cbs, idc_pc_efetiva_reg_ibs_uf, idc_pc_efetiva_reg_ibs_mun, idc_pc_efetiva_reg_cbs
		
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_valida_dados (string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_atualiza_nota_fiscal (long al_controle, long al_tabela)
public function boolean of_insere_nota_fiscal (ref string as_log)
public function boolean of_insere_nota_fiscal_item (ref string as_log, long al_controle_pai)
public function boolean of_insere_nota_fiscal_item_lote (ref string as_log, long al_controle_pai)
public function boolean of_insere_nota_fiscal_titulo_pagar (ref string as_log, long al_controle_pai)
public function boolean of_localiza_pedido_central (string ps_pedido_sap, ref string as_log)
public function boolean of_atualiza_pedido_distribuidora (string as_chave_acesso, ref string as_log)
public function boolean of_atualiza_pedido_distribuidora_produto (long al_cd_produto, long al_qt_faturada, string as_de_chave_acesso, ref string as_log)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
			 
	SetNull(is_de_chave_acesso_sap)
	//***cabecalho da nota*****
	SetNull(is_de_chave_acesso)
	SetNull(is_de_dados_adicionais)
	SetNull(is_de_natureza_operacao)
	SetNull(is_de_serie)
	SetNull(is_nm_razao_social)
	SetNull(is_nr_cgc_fornecedor)
	SetNull(is_id_modalidade_frete)
	SetNull(idt_dh_emissao)
	SetNull(il_nr_nf)
	SetNull(il_nr_pedido_central)
	SetNull(ide_qt_volumes)
	SetNull(ide_vl_bc_icms)
	SetNull(ide_vl_bc_icms_st)
	SetNull(ide_vl_desconto)
	SetNull(ide_vl_frete)
	SetNull(ide_vl_icms)
	SetNull(ide_vl_icms_st)
	SetNull(ide_vl_ipi)
	SetNull(ide_vl_outras_despesas)
	SetNull(ide_vl_seguro)
	SetNull(ide_vl_total_nf)
	SetNull(ide_vl_total_produtos)
	//*********************
	//***Item da Nota*********
	SetNull(il_cd_produto)
	SetNull(is_cd_cprod)
	SetNull(is_de_codigo_barras)
	SetNull(is_de_produto)
	SetNull(il_nr_classificacao_fiscal)
	SetNull(il_cd_natureza_operacao)
	SetNull(il_nr_item_pedido)
	SetNull(is_cd_cst_tributacao)
	SetNull(is_de_codigo_barras_trib)
	SetNull(is_cd_cst_pis)
	SetNull(is_cd_cst_cofins)
	SetNull(is_cd_mod_bc_icms)
	SetNull(is_cd_unidade_comercial)
	SetNull(is_cd_unidade_tributavel)
	SetNull(is_cd_beneficio)
	SetNull(is_cd_mod_bc_st)
	SetNull(is_cd_cest)
	SetNull(ide_vl_preco_unitario)
	SetNull(ide_vl_bc_ipi)
	SetNull(ide_vl_preco_unitario_tributado)
	SetNull(ide_vl_pis)
	SetNull(ide_vl_cofins)
	SetNull(ide_vl_icms_operacao)
	SetNull(ide_vl_icms_dif)
	SetNull(ide_vl_bc_icms_st_retido)
	SetNull(ide_vl_icms_st_retido)
	SetNull(ide_vl_total_item)
	SetNull(ide_vl_desconto_total)
	SetNull(ide_qt_faturada)
	SetNull(ide_pc_reducao_bc_icms)
	SetNull(ide_pc_icms)
	SetNull(ide_pc_reducao_bc_icms_st)
	SetNull(ide_pc_icms_st)
	SetNull(ide_pc_ipi)
	SetNull(ide_qt_tributada)
	SetNull(ide_pc_dif_icms)
	SetNull(ide_qt_comercial)
	SetNull(ide_qt_tributavel)
	SetNull(ide_pc_st_retido)
	SetNull(ide_vl_icms_retido)
	SetNull(ide_pc_mva)
	SetNull(il_nr_item)
	SetNull(il_nr_sequencial)
	//*********************
	//*****Lote da nota*******
	SetNull(idt_dh_fabricacao)
	SetNull(idt_dh_validade)
	SetNull(is_nr_lote)
	SetNull(il_qt_lote)
	//*********************
	//****Titulo da Nota********
	SetNull(idt_dh_vencimento)
	SetNull(is_nr_titulo_pagar)
	SetNull(ide_vl_pagar)
	//**********************
	il_Tabela = 88
	ib_execucao_simultanea = false

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as variaveis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_valida_dados (string as_log);Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface NF Compra - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_wms_nf_compra.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			if ib_execucao_simultanea = True Then
				//
			else
			
				uo_ge473_wms_nf_compra   lo_nota
				 
				Try
					lo_nota	= Create uo_ge473_wms_nf_compra
					lo_nota.of_atualiza_nota_fiscal( lds.Object.nr_controle[ll_Linha],this.il_tabela )
	
				Finally
					Destroy(lo_nota)
				End Try			
			
			end if
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface NF Compra - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_wms_nf_compra.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_atualiza_nota_fiscal (long al_controle, long al_tabela);Boolean lb_Sucesso = False

Long ll_Atualizacao_Pend
Long ll_Linhas

String ls_Log
String ls_Chave_Controle

Try
		
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	Select de_chave_sap
	Into :is_de_chave_acesso_sap
	From interface_sap  i 
	Where i.cd_tabela = 88
		and i.nr_controle = :al_controle
	Using SqlCa;	
	
	If SqlCa.sqlcode = -1 Then
		ls_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		If ll_Linhas = 1 Then
			is_de_chave_acesso 		= lo_Comum.ids_lista_registros.Object.de_chave_acesso[1]	
			is_de_dados_adicionais 	= lo_Comum.ids_lista_registros.Object.de_dados_adicionais [1]	
			is_de_natureza_operacao = lo_Comum.ids_lista_registros.Object.de_natureza_operacao[1]	
			is_de_serie				= lo_Comum.ids_lista_registros.Object.de_serie[1]
			
			If Not lo_Comum.of_date_time_gmt(lo_Comum.ids_lista_registros.Object.dh_emissao[1], 'DH_EMISSAO', ref  idt_dh_emissao, ref ls_Log) Then Return False
			
			is_id_modalidade_frete= lo_Comum.ids_lista_registros.Object.id_modalidade_frete[1]	
			is_nm_razao_social	= lo_Comum.ids_lista_registros.Object.nm_razao_social	[1]	
			is_nr_cgc_fornecedor	= lo_Comum.ids_lista_registros.Object.nr_cgc_fornecedor[1]	
			il_nr_nf					= Long(lo_Comum.ids_lista_registros.Object.nr_nf[1]	)
			
			If Not This.of_localiza_pedido_central(lo_Comum.ids_lista_registros.Object.nr_pedido_central[1], ref ls_Log) Then Return False
						
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.qt_volumes[1], 'QT_VOLUMES', ref ide_qt_volumes, ref ls_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_bc_icms[1], 'VL_BC_ICMS', ref ide_vl_bc_icms, ref ls_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_bc_icms_st[1], 'VL_BC_ICMS_ST', ref ide_vl_bc_icms_st, ref ls_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_desconto[1], 'VL_DESCONTO', ref ide_vl_desconto, ref ls_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_frete[1], 'VL_FRETE', ref ide_vl_frete, ref ls_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_icms[1], 'VL_ICMS', ref ide_vl_icms, ref ls_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_icms_st[1], 'VL_ICMS_ST', ref ide_vl_icms_st, ref ls_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_ipi[1], 'VL_IPI', ref ide_vl_ipi, ref ls_log) Then Return False	
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_outras_despesas[1], 'VL_OUTRAS_DESPESAS', ref ide_vl_outras_despesas, ref ls_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_seguro[1], 'VL_SEGURO', ref ide_vl_seguro, ref ls_log) Then Return False	
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_total_nf[1], 'VL_TOTAL_NF', ref ide_vl_total_nf, ref ls_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_total_produtos[1], 'VL_TOTAL_PRODUTOS', ref ide_vl_total_produtos, ref ls_log) Then Return False
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Nota Fiscal: ' + is_de_chave_acesso , 3 )
			end if					
					
			If This.of_valida_dados( Ref ls_Log) Then
				
				If This.of_Insere_nota_fiscal(Ref ls_Log ) Then
					If This.of_insere_nota_fiscal_item(Ref ls_Log, al_controle) Then
						If This.of_insere_nota_fiscal_item_lote(Ref ls_Log, al_controle) Then
							If This.of_insere_nota_fiscal_titulo_pagar(Ref ls_Log, al_controle) Then
								lb_Sucesso	= True
							End If
						End If
					End If
				End If
				
			End If
				
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			end if	
				
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If
		
	End If

Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_wms_nf_compra], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_nota_fiscal]. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally
		
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum	
	
End Try
	

Return True
end function

public function boolean of_insere_nota_fiscal (ref string as_log);DateTime ldt_dh_emissao

Select dh_emissao
Into :ldt_dh_emissao
From nf_agendamento_ent
Where de_chave_acesso  = :is_de_chave_acesso
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		as_Log	= 'Nota Fiscal [' + is_de_chave_acesso + '] j$$HEX1$$e100$$ENDHEX$$ emitida na data [' + String(ldt_dh_emissao,'dd/mm/yyyy') + '].'
		Return False
	Case 100
		Insert into nf_agendamento_ent (
			de_chave_acesso,
			nr_nf,
			de_especie,
			de_serie,
			de_natureza_operacao,
			nr_cgc_fornecedor,
			dh_emissao,
			vl_bc_icms,
			vl_icms,
			vl_bc_icms_st,
			vl_icms_st,
			vl_total_produtos,
			vl_ipi,vl_frete,
			vl_seguro,
			vl_outras_despesas,
			vl_desconto,
			vl_total_nf,
			nr_pedido_central,
			dh_inclusao,
			dh_liberacao_agendamento,
			nr_matricula_lib_agendamento,
			de_retorno_webservice,
			de_dados_adicionais,
			dh_envio_site,
			de_tag_xped,
			qt_volumes,
			de_motivo_lib_agendamento,
			nr_matricula_canc_agendamento,
			dh_cancelamento_agendamento,
			id_modalidade_frete,
			nm_razao_social,
			de_motivo_canc_agendamento,
			dh_recebido_sap)
		values(
			:this.is_de_chave_acesso,
			:this.il_nr_nf,
			'NFE',
			:this.is_de_serie,
			:this.is_de_natureza_operacao,
			:this.is_nr_cgc_fornecedor,
			:this.idt_dh_emissao,
			:this.ide_vl_bc_icms,
			:this.ide_vl_icms,
			:this.ide_vl_bc_icms_st,
			:this.ide_vl_icms_st,
			:this.ide_vl_total_produtos,
			:this.ide_vl_ipi,
			:this.ide_vl_frete,
			:this.ide_vl_seguro,
			:this.ide_vl_outras_despesas,
			:this.ide_vl_desconto,
			:this.ide_vl_total_nf,
			:this.il_nr_pedido_central,
			getDate(),
			null,
			null,
			null,
			:this.is_de_dados_adicionais,
			null,
			null,
			:this.ide_qt_volumes,
			null,
			null,
			null,
			:this.is_id_modalidade_frete,
			:this.is_nm_razao_social,
			null,
			getdate() )
		Using SqlCA;
			
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao inserir registro na tabela 'nf_agendamento_ent'. Nota Fiscal [" + is_de_chave_acesso+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
	Case -1
		as_Log	= "Erro ao localizar registro na tabela 'nf_agendamento_ent'. Nota Fiscal [" + is_de_chave_acesso+"]. Erro: "+ SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_insere_nota_fiscal_item (ref string as_log, long al_controle_pai);Long ll_Controle_filho
Long ll_Linha
String ls_Requisicao_Chave
String ls_cd_cst_origem = "0"
String ls_Red_ICMS

Decimal lde_pec_desconto

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_Requisicao_Chave
	FROM interface_sap  i 
	Where i.cd_tabela = 89
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If IsNull(ls_Requisicao_Chave) Or Trim(ls_Requisicao_Chave)="" Then
		as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso informada na INTERFACE_SAP do filho est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	Else
		If Trim(ls_Requisicao_Chave) <> Trim(This.is_de_chave_acesso_sap ) Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da INTERFACE_SAP pai e filho est$$HEX1$$e300$$ENDHEX$$o diferentes."
			Return False
		End If
	End If
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()	
			
			// Chave de acesso da NFe			
			If IsNull(lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]) or Trim(lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]) = "" Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da NFe est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida no filho.' 	
				Return False
			End If
			
			// Chave de acesso da NFe			
			If Trim(is_de_chave_acesso) <> Trim(lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]) Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da NFe pai e filho(item) est$$HEX1$$e300$$ENDHEX$$o diferentes.' 	
				Return False
			End If
			
			is_cd_beneficio				= lo_Comum.ids_lista_registros.Object.cd_beneficio[ll_Linha]
			is_cd_cest					= lo_Comum.ids_lista_registros.Object.cd_cest[ll_Linha]
			is_cd_cprod					= lo_Comum.ids_lista_registros.Object.cd_cprod[ll_Linha]
			is_cd_cst_cofins			= lo_Comum.ids_lista_registros.Object.cd_cst_cofins[ll_Linha]
			is_cd_cst_pis				= lo_Comum.ids_lista_registros.Object.cd_cst_pis[ll_Linha]
			is_cd_cst_tributacao		= lo_Comum.ids_lista_registros.Object.cd_cst_tributacao[ll_Linha]
			is_cd_mod_bc_icms		= lo_Comum.ids_lista_registros.Object.cd_mod_bc_icms[ll_Linha]
			is_cd_mod_bc_st			= lo_Comum.ids_lista_registros.Object.cd_mod_bc_st[ll_Linha]
			
			il_cd_natureza_operacao= Long(lo_Comum.ids_lista_registros.Object.cd_natureza_operacao[ll_Linha])
			If IsNull(il_cd_natureza_operacao) Then
				as_log = "O valor informado 'NULO/VAZIO' para o campo 'CD_NATUREZA_OPERACAO' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
				Return False
			End If
			
			If Not lo_Comum.of_localiza_codigo_produto_legado(lo_Comum.ids_lista_registros.Object.cd_produto[ll_Linha], il_cd_produto, as_log) Then Return False
			
			is_cd_unidade_comercial= lo_Comum.ids_lista_registros.Object.cd_unidade_comercial[ll_Linha]
			is_cd_unidade_tributavel	= lo_Comum.ids_lista_registros.Object.cd_unidade_tributavel[ll_Linha]
			is_de_chave_acesso		= lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]
			is_de_codigo_barras		= lo_Comum.ids_lista_registros.Object.de_codigo_barras[ll_Linha]
			is_de_codigo_barras_trib= lo_Comum.ids_lista_registros.Object.de_codigo_barras_trib[ll_Linha]
			
			is_de_produto				= lo_Comum.ids_lista_registros.Object.de_produto[ll_Linha]
			If IsNull(is_de_produto) Then 
				as_log = "O valor informado 'NULO/VAZIO' para o campo 'DE_PRODUTO' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
				Return False
			End If
			
			il_nr_classificacao_fiscal	= Long(lo_Comum.ids_lista_registros.Object.nr_classificacao_fiscal[ll_Linha])
			il_nr_item					= Long(lo_Comum.ids_lista_registros.Object.nr_item[ll_Linha])
			il_nr_item_pedido			= Long(lo_Comum.ids_lista_registros.Object.nr_item_pedido[ll_Linha])
			il_nr_sequencial			= Long(lo_Comum.ids_lista_registros.Object.nr_sequencial[ll_Linha])
			
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_dif_icms[ll_linha], 'PC_DIF_ICMS', ref ide_pc_dif_icms, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_icms[ll_linha], 'PC_ICMS', ref ide_pc_icms, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_icms_st[ll_linha], 'PC_ICMS_ST', ref ide_pc_icms_st, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_ipi[ll_linha], 'PC_IPI', ref ide_pc_ipi, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_mva[ll_linha], 'PC_MVA', ref ide_pc_mva, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_reducao_bc_icms[ll_linha], 'PC_REDUCAO_BC_ICMS', ref ide_pc_reducao_bc_icms, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_reducao_bc_icms_st[ll_linha], 'PC_REDUCAO_BC_ICMS_ST', ref ide_pc_reducao_bc_icms_st, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_st_retido[ll_linha], 'PC_ST_RETIDO', ref ide_pc_st_retido, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.qt_comercial[ll_linha], 'QT_COMERCIAL', ref ide_qt_comercial, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.qt_faturada[ll_linha], 'QT_FATURADA', ref ide_qt_faturada, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.qt_tributada[ll_linha], 'QT_TRIBUTADA', ref ide_qt_tributada, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.qt_tributavel[ll_linha], 'QT_TRIBUTAVEL', ref ide_qt_tributavel, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_bc_icms[ll_linha], 'VL_BC_ICMS', ref ide_vl_bc_icms, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_bc_icms_st[ll_linha], 'VL_BC_ICMS_ST', ref ide_vl_bc_icms_st, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_bc_icms_st_retido[ll_linha], 'VL_BC_ICMS_ST_RETIDO', ref ide_vl_bc_icms_st_retido, ref as_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_bc_ipi[ll_linha], 'VL_BC_IPI', ref ide_vl_bc_ipi, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_cofins[ll_linha], 'VL_COFINS', ref ide_vl_cofins, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_desconto_total[ll_linha], 'VL_DESCONTO_TOTAL', ref ide_vl_desconto_total, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_frete[ll_linha], 'VL_FRETE', ref ide_vl_frete, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_icms[ll_linha], 'VL_ICMS', ref ide_vl_icms, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_icms_dif[ll_linha], 'VL_ICMS_DIF', ref ide_vl_icms_dif, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_icms_operacao[ll_linha], 'VL_ICMS_OPERACAO', ref ide_vl_icms_operacao, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_icms_retido[ll_linha], 'VL_ICMS_RETIDO', ref ide_vl_icms_retido, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_icms_st[ll_linha], 'VL_ICMS_ST', ref ide_vl_icms_st, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_icms_st_retido[ll_linha], 'VL_ICMS_ST_RETIDO', ref ide_vl_icms_st_retido, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_ipi[ll_linha], 'VL_IPI', ref ide_vl_ipi, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_outras_despesas[ll_linha], 'VL_OUTRAS_DESPESAS', ref ide_vl_outras_despesas, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_pis[ll_linha], 'VL_PIS', ref ide_vl_pis, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_preco_unitario[ll_linha], 'VL_PRECO_UNITARIO', ref ide_vl_preco_unitario, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_preco_unitario_tributado[ll_linha], 'VL_PRECO_UNITARIO_TRIBUTADO', ref ide_vl_preco_unitario_tributado, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_seguro[ll_linha], 'VL_SEGURO', ref ide_vl_seguro, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_total_item[ll_linha], 'VL_TOTAL_ITEM', ref ide_vl_total_item, ref as_log, true) Then Return False				
			
			If ide_vl_total_item > 0 Then
				lde_pec_desconto = Round(ide_vl_desconto_total / ide_vl_total_item * 100,2)
				If lde_pec_desconto < 0.00 or lde_pec_desconto > 100.00  Then
					as_log = 'Percentual de desconto inv$$HEX1$$e100$$ENDHEX$$lido para o produto [' + String(il_cd_produto) + '] da chave de acesso [' + is_de_chave_acesso +  '].' 	 	
					Return False
				End If
			Else
				lde_pec_desconto = 0
			End If
			
			// NR item da tabela
			If IsNull(il_nr_item) or il_nr_item <= 0  Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do item do produto [' + String(il_cd_produto) + '] da chave de acesso [' + is_de_chave_acesso +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
				Return False
			End If
						
			If ide_pc_reducao_bc_icms > 0 Then
				ls_Red_ICMS = 'S'
			Else
				ls_Red_ICMS = 'N'
			End If
			
			Insert into nf_agendamento_ent_item
					(	cd_beneficio,
						cd_cest,
						cd_cprod,
						cd_cst_cofins,
						cd_cst_origem,
						cd_cst_pis,
						cd_cst_tributacao,
						cd_mod_bc_icms,
						cd_mod_bc_st,
						cd_natureza_operacao,
						cd_produto,
						cd_unidade_comercial,
						cd_unidade_tributavel,
						de_chave_acesso,
						de_codigo_barras,
						de_codigo_barras_trib,
						de_produto,
						id_multiplic_dividir_cx_padrao,
						id_reducao_base_icms,
						nr_classificacao_fiscal,
						nr_item,
						nr_item_pedido,
						nr_recebimento_sap,
						nr_sequencial,
						pc_desconto,
						pc_dif_icms,
						pc_icms,
						pc_icms_st,
						pc_ipi,
						pc_mva,
						pc_reducao_bc_icms,
						pc_reducao_bc_icms_st,
						pc_st_retido,
						qt_caixa_padrao,
						qt_comercial,
						qt_faturada,
						qt_faturada_original,
						qt_tributada,
						qt_tributavel,
						vl_bc_icms,
						vl_bc_icms_original,
						vl_bc_icms_st,
						vl_bc_icms_st_original,
						vl_bc_icms_st_retido,
						vl_bc_icms_st_retido_original,
						vl_bc_ipi,
						vl_bc_ipi_original,
						vl_cofins,
						vl_desconto_total,
						vl_frete,
						vl_icms,
						vl_icms_dif,
						vl_icms_operacao,
						vl_icms_original,
						vl_icms_retido,
						vl_icms_st,
						vl_icms_st_original,
						vl_icms_st_retido,
						vl_icms_st_retido_original,
						vl_ipi,
						vl_ipi_original,
						vl_outras_despesas,
						vl_pis,
						vl_preco_unitario,
						vl_preco_unitario_original,
						vl_preco_unitario_tributado,
						vl_seguro,
						vl_total_item )
			values(	:is_cd_beneficio,
						:is_cd_cest,
						:is_cd_cprod,
						:is_cd_cst_cofins,
						:ls_cd_cst_origem,
						:is_cd_cst_pis,
						:is_cd_cst_tributacao,
						:is_cd_mod_bc_icms,
						:is_cd_mod_bc_st,
						:il_cd_natureza_operacao,
						:il_cd_produto,
						:is_cd_unidade_comercial,
						:is_cd_unidade_tributavel,
						:is_de_chave_acesso,
						:is_de_codigo_barras,
						:is_de_codigo_barras_trib,
						:is_de_produto,
						null,
						:ls_Red_ICMS,
						:il_nr_classificacao_fiscal,
						:il_nr_item,
						:il_nr_item_pedido,
						null,
						:il_nr_sequencial,
						:lde_pec_desconto,
						:ide_pc_dif_icms,
						:ide_pc_icms,
						:ide_pc_icms_st,
						:ide_pc_ipi,
						:ide_pc_mva,
						:ide_pc_reducao_bc_icms,
						:ide_pc_reducao_bc_icms_st,
						:ide_pc_st_retido,
						null,
						:ide_qt_comercial,
						:ide_qt_faturada,
						:ide_qt_faturada,
						:ide_qt_tributada,
						:ide_qt_tributavel,
						:ide_vl_bc_icms,
						:ide_vl_bc_icms,
						:ide_vl_bc_icms_st,
						:ide_vl_bc_icms_st,
						:ide_vl_bc_icms_st_retido,
						:ide_vl_bc_icms_st_retido,
						:ide_vl_bc_ipi,
						:ide_vl_bc_ipi,
						:ide_vl_cofins,
						:ide_vl_desconto_total,
						:ide_vl_frete,
						:ide_vl_icms,
						:ide_vl_icms_dif,
						:ide_vl_icms_operacao,
						:ide_vl_icms_operacao,
						:ide_vl_icms_retido,
						:ide_vl_icms_st,
						:ide_vl_icms_st,
						:ide_vl_icms_st_retido,
						:ide_vl_icms_st_retido,
						:ide_vl_ipi,
						:ide_vl_ipi,
						:ide_vl_outras_despesas,
						:ide_vl_pis,
						:ide_vl_preco_unitario,
						:ide_vl_preco_unitario,
						:ide_vl_preco_unitario_tributado,
						:ide_vl_seguro,
						:ide_vl_total_item )
			
			Using SqlCA;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao inserir registro na tabela 'nf_agendamento_ent_item'. Chave de Acesso/Produto ["+This.is_de_chave_acesso + "/" + this.is_de_produto + "]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
		Next	
	Else
		Return False				
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_wms_nf_compra], fun$$HEX2$$e700e300$$ENDHEX$$o [of_insere_nota_fiscal_item]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_insere_nota_fiscal_item_lote (ref string as_log, long al_controle_pai);Long ll_Controle_filho
Long ll_Linha
String ls_Requisicao_Chave

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_Requisicao_Chave
	FROM interface_sap  i 
	Where i.cd_tabela = 90
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If IsNull(ls_Requisicao_Chave) Or Trim(ls_Requisicao_Chave)="" Then
		as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso informada na INTERFACE_SAP do filho (lote) est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	Else
		If Trim(ls_Requisicao_Chave) <> Trim(This.is_de_chave_acesso_sap ) Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da INTERFACE_SAP pai e filho (lote) est$$HEX1$$e300$$ENDHEX$$o diferentes."
			Return False
		End If
	End If
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()	
			
			// Chave de acesso da NFe			
			If IsNull(lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]) or Trim(lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]) = "" Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da NFe est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida no filho (lote).' 	
				Return False
			End If
			
			// Chave de acesso da NFe			
			If Trim(is_de_chave_acesso) <> Trim(lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]) Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da NFe pai e filho (lote) est$$HEX1$$e300$$ENDHEX$$o diferentes.' 	
				Return False
			End If

			is_de_chave_acesso		= lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]
			is_nr_lote					= lo_Comum.ids_lista_registros.Object.nr_lote[ll_Linha]
			If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_fabricacao[1], 'DH_FABRICACAO', ref  idt_dh_fabricacao, ref as_Log) Then Return False
			If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_validade[1], 'DH_VALIDADE', ref  idt_dh_validade, ref as_Log) Then Return False
			il_nr_item					= Long(lo_Comum.ids_lista_registros.Object.nr_item[ll_Linha])
			il_qt_lote						= Long(lo_Comum.ids_lista_registros.Object.qt_lote[ll_linha])
			
			// NR item da tabela
			If IsNull(il_nr_item) or il_nr_item <= 0  Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do item do lote [' + is_nr_lote + '] da chave de acesso [' + is_de_chave_acesso +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
				Return False
			End If						
			
			Insert into nf_agendamento_ent_item_lote
					(	de_chave_acesso,
						nr_item,
						dh_fabricacao,
						dh_validade,
						nr_lote,
						qt_lote )
			values(	:is_de_chave_acesso,
						:il_nr_item,
						:this.idt_dh_fabricacao,
						:this.idt_dh_validade,
						:this.is_nr_lote,
						:this.il_qt_lote )			
			Using SqlCA;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao inserir registro na tabela 'nf_agendamento_ent_item_lote'. Chave de Acesso/Lote ["+This.is_de_chave_acesso + "/" + this.is_nr_lote + "]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
		Next	
	Else
		Return False				
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_wms_nf_compra], fun$$HEX2$$e700e300$$ENDHEX$$o [of_insere_nota_fiscal_item_lote]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_insere_nota_fiscal_titulo_pagar (ref string as_log, long al_controle_pai);Long ll_Controle_filho
Long ll_Linha
String ls_Requisicao_Chave

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_Requisicao_Chave
	FROM interface_sap  i 
	Where i.cd_tabela = 91
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If IsNull(ls_Requisicao_Chave) Or Trim(ls_Requisicao_Chave)="" Then
		as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso informada na INTERFACE_SAP do filho (titulo) est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	Else
		If Trim(ls_Requisicao_Chave) <> Trim(This.is_de_chave_acesso_sap ) Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da INTERFACE_SAP pai e filho (titulo) est$$HEX1$$e300$$ENDHEX$$o diferentes."
			Return False
		End If
	End If
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()	
			
			// Chave de acesso da NFe			
			If IsNull(lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]) or Trim(lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]) = "" Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da NFe est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida no filho (titulo).' 	
				Return False
			End If
			
			// Chave de acesso da NFe			
			If Trim(is_de_chave_acesso) <> Trim(lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]) Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da NFe pai e filho (titulo) est$$HEX1$$e300$$ENDHEX$$o diferentes.' 	
				Return False
			End If

			is_de_chave_acesso		= lo_Comum.ids_lista_registros.Object.de_chave_acesso[ll_Linha]
			is_nr_titulo_pagar			= lo_Comum.ids_lista_registros.Object.nr_titulo_pagar[ll_Linha]
			
			If IsNull(lo_Comum.ids_lista_registros.Object.dh_vencimento[1]) Then 
				as_log = "O valor informado 'NULO/VAZIO' para o campo 'DH_VENCIMENTO' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
				Return False
			End If
						
			If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_vencimento[1], 'DH_VENCIMENTO', ref  idt_dh_vencimento, ref as_Log) Then Return False
						
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_pagar[1], 'VL_PAGAR', ref ide_vl_pagar, ref as_log) Then Return False
			
			// Valor do titulo
			If IsNull(ide_vl_pagar) or ide_vl_pagar <= 0  Then
				as_log = 'Valor do tiulo [' + is_nr_titulo_pagar + '] da chave de acesso [' + is_de_chave_acesso +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
				Return False
			End If						
			
			Insert into nf_agendamento_ent_titulo
					(	de_chave_acesso,
						nr_titulo_pagar,
						dh_emissao,
						dh_vencimento,
						vl_pagar )
			values(	:is_de_chave_acesso,
						:this.is_nr_titulo_pagar,
						getDate(),
						:this.idt_dh_vencimento,
						:this.ide_vl_pagar )			
			Using SqlCA;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao inserir registro na tabela 'nf_agendamento_ent_titulo'. Chave de Acesso/Titulo ["+This.is_de_chave_acesso + "/" + this.is_nr_titulo_pagar + "]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
		Next	
	Else
		Return False				
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_wms_nf_compra], fun$$HEX2$$e700e300$$ENDHEX$$o [of_insere_nota_fiscal_titulo]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_localiza_pedido_central (string ps_pedido_sap, ref string as_log);If Trim(ps_pedido_sap) = "" or IsNull(ps_pedido_sap) Then
	as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o n$$HEX1$$fa00$$ENDHEX$$mero do pedido [nr_pedido_central]."
	Return False
End If

Select nr_pedido
Into	:il_nr_pedido_central
From pedido_central
Where	nr_pedido_sap = :ps_pedido_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "Pedido SAP [ps_pedido_sap] n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		Return False
	Case -1
		as_Log	= "Erro ao localizar o pedido SAP: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_atualiza_pedido_distribuidora (string as_chave_acesso, ref string as_log);Update	pedido_distribuidora
	Set	id_situacao = 'F'
	From	pedido_distribuidora pd
	Inner Join	pedido_central pc
		On	pd.cd_filial = pc.cd_filial
		And	pd.nr_pedido_distribuidora = pc.nr_pedido_distribuidora
		And	pd.cd_distribuidora = pc.cd_fornecedor
	Inner join nf_agendamento_ent ne 
		On ne.nr_pedido_central = pc.nr_pedido
	Where ne.de_chave_acesso = :as_chave_acesso
		And pc.nr_pedido = :il_nr_pedido_central
Using	SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao localizar a chave de acesso do recebimento SAP. ' + SQLCA.SQLErrText
		Return False
End Choose

Return true
end function

public function boolean of_atualiza_pedido_distribuidora_produto (long al_cd_produto, long al_qt_faturada, string as_de_chave_acesso, ref string as_log);	update pedido_distribuidora_produto
		set qt_faturada = isnull(pdp.qt_faturada, 0) + :al_qt_faturada
		from pedido_distribuidora_produto pdp
		join pedido_central pc
		on pdp.cd_filial = pc.cd_filial
		and pdp.nr_pedido_distribuidora = pc.nr_pedido_distribuidora
		Inner join nf_agendamento_ent ne
		On ne.nr_pedido_central = pc.nr_pedido
		where ne.de_chave_acesso = :is_de_chave_acesso
		and pdp.cd_produto = :al_cd_produto
Using	SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao localizar a chave de acesso do recebimento SAP. ' + SQLCA.SQLErrText
		Return False
End Choose

Return true
end function

on uo_ge473_wms_nf_compra.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_wms_nf_compra.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

