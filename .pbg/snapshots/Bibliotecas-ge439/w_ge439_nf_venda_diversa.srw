HA$PBExportHeader$w_ge439_nf_venda_diversa.srw
forward
global type w_ge439_nf_venda_diversa from dc_w_sheet
end type
type dw_1 from dc_uo_dw_base within w_ge439_nf_venda_diversa
end type
type tab_1 from tab within w_ge439_nf_venda_diversa
end type
type tabpage_1 from userobject within tab_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type dw_6 from dc_uo_dw_base within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type gb_6 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_2 dw_2
dw_6 dw_6
gb_4 gb_4
gb_6 gb_6
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type dw_5 from dc_uo_dw_base within tabpage_2
end type
type gb_2 from groupbox within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
gb_2 gb_2
gb_3 gb_3
end type
type tab_1 from tab within w_ge439_nf_venda_diversa
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type gb_1 from groupbox within w_ge439_nf_venda_diversa
end type
end forward

global type w_ge439_nf_venda_diversa from dc_w_sheet
integer width = 2610
integer height = 2060
string title = "GE439 - Emiss$$HEX1$$e300$$ENDHEX$$o de Nota Fiscal de Venda de Sucata"
dw_1 dw_1
tab_1 tab_1
gb_1 gb_1
end type
global w_ge439_nf_venda_diversa w_ge439_nf_venda_diversa

type variables
Private:
uo_filial                          	ivo_filial						//GE009
uo_cliente                     		ivo_cliente					//GE002
uo_nota_fiscal               		ivo_nota_fiscal				//GE033
uo_parametro_geral      		ivo_parametro				//GE014
uo_Titulo 						ivo_Titulo					//GE020
uo_Tratamento_Fiscal		ivo_Tratamento_fiscal	//GE021

//CST Padr$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ 51 - Diferido
String ivs_CST = '51'
String ivs_Msg = 'ICMS DIFERIDO CFE RICMS/SC ANEXO 3, ART. 8$$HEX1$$ba00$$ENDHEX$$ XIV'
//% ICMS padr$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ 0%
Decimal{2} ivdc_Pc_ICMS = 0.00

Boolean ib_Iniciado_Operacao_SAP = False

String is_id_frete_nf_diversa

Date idt_data_parametro


/* CBS/IBS */
String ivs_Trib_CBSIBS = 'CBSIBS.000001.001'

Boolean ivb_Fechando = False

end variables

forward prototypes
public subroutine wf_formata_parcelas ()
public subroutine wf_calcula_totais ()
public subroutine wf_altera_tributacao_itens ()
public subroutine wf_calcula_item_tributacao (long pl_linha)
public function boolean wf_inclui_movimento_conta (string ps_cliente, string ps_tipo_titulo, string ps_titulo, long pl_filial, decimal pdc_valor, date pdt_movimento)
public function boolean wf_tipo_movto_conta (string ps_tipo_conta, ref long pl_codigo)
public function string wf_retorna_beneficio (long pl_tipo_sucata, string ps_cst)
public function boolean wf_verifica_produto_sap (long pl_tipo, ref string ps_erro)
public function boolean wf_grava_integracao_wmu_sap (ref string as_erro)
public function boolean wf_busca_produto_sucata (integer pl_tipo, ref string ps_produto_sap, ref string ps_unidade_medida, ref long pl_nr_classificacao_fiscal, ref string ps_erro)
public subroutine wf_bloqueio_campo_tipo_nf_sucata ()
public subroutine wf_insere_padrao_tipo_nf_sucata ()
public function boolean wf_vincula_tipo_nf_sucata_cliente (ref string as_erro)
public function boolean wf_busca_parametro_loja ()
public function boolean wf_verifica_ultimo_tipo_frete (ref string as_ultimo_tipo_frete)
public function boolean wf_verifica_tipo_tributacao (string ps_cst)
public subroutine wf_atribui_pecentual_icms_digitado (decimal pd_percentual)
end prototypes

public subroutine wf_formata_parcelas ();Date lvdt_Primeiro_Vcto
Date lvdt_Vcto

Long lvl_Nr_Parcelas
Long lvl_Intervalo
Long lvl_Linha

Decimal{2} lvdc_Valor
Decimal{2} lvdc_Total_Valor
Decimal{2} lvdc_Total_Nf
Decimal{2} lvdc_Parcela

Tab_1.Tabpage_2.dw_3.Accepttext( )
lvdt_Primeiro_Vcto 	= Tab_1.Tabpage_2.dw_3.Object.dt_primeiro_vcto	[1]
lvl_Nr_Parcelas			= Tab_1.Tabpage_2.dw_3.Object.nr_parcelas 			[1]
lvl_Intervalo				= Tab_1.Tabpage_2.dw_3.Object.nr_intervalo			[1]
lvdc_Total_Nf			= dw_1.Object.vl_total_nf 									[1]

//Verifica/Ajusta N$$HEX1$$ba00$$ENDHEX$$ Parcelas
If IsNull(lvl_Nr_Parcelas)or(lvl_Nr_Parcelas=0) Then
	lvl_Nr_Parcelas = 1
	Tab_1.Tabpage_2.dw_3.Object.nr_parcelas	[1] = lvl_Nr_Parcelas
End If

//Verifica/Ajusta Intervalo Entre as Parcelas
If IsNull(lvl_Intervalo)or((lvl_Intervalo=0)and(lvl_Nr_Parcelas>1)) Then
	lvl_Intervalo = 30
	Tab_1.Tabpage_2.dw_3.Object.nr_intervalo	[1] = lvl_Intervalo
End If

//Verifica/Ajusta Data Vencto
If IsNull(lvdt_Primeiro_Vcto)or(lvdt_Primeiro_Vcto < Date(gvo_parametro.dh_movimentacao)) Then
	lvdt_Primeiro_Vcto	 = gf_add_dias_uteis(Date(gvo_parametro.dh_movimentacao),10)
	Tab_1.Tabpage_2.dw_3.Object.dt_primeiro_vcto	[1] = lvdt_Primeiro_Vcto
End if

//Calcula Valor Parcelas
lvdc_Parcela = Round(lvdc_Total_Nf / lvl_Nr_Parcelas,2)
lvdc_Total_Valor = 0

//Limpa as parcelas existentes
Tab_1.Tabpage_2.dw_4.Reset()
//Insere novas parcelas
For lvl_Linha = 1 To lvl_Nr_Parcelas
	//Define Vencimento
	If lvl_Linha = 1 then
		lvdt_Vcto = lvdt_Primeiro_Vcto
	Else
		lvdt_Vcto = RelativeDate(lvdt_Vcto,lvl_Intervalo)
	End if
	
	//Define valor parcela
	lvdc_Total_Valor += lvdc_Parcela
	If  lvl_Linha = lvl_Nr_Parcelas Then
		//Arredondamento na $$HEX1$$fa00$$ENDHEX$$ltima parcela
		lvdc_Valor = lvdc_Parcela + (lvdc_Total_Nf - lvdc_Total_Valor) 
	Else 
		lvdc_Valor = lvdc_Parcela
	End If
	
	//Insere valor na DW
	Tab_1.Tabpage_2.dw_4.InsertRow(0)
	Tab_1.Tabpage_2.dw_4.Object.vl_nominal			[lvl_linha] = lvdc_Valor
	Tab_1.Tabpage_2.dw_4.Object.vl_aberto			[lvl_linha] = lvdc_Valor
	Tab_1.Tabpage_2.dw_4.Object.dh_vencimento	[lvl_linha] = lvdt_Vcto
Next
end subroutine

public subroutine wf_calcula_totais ();//Aceita textos digitados n$$HEX1$$e300$$ENDHEX$$o efetivados
Tab_1.Tabpage_1.dw_2.Accepttext( )
//Calcula valores de agrupamentos
Tab_1.Tabpage_1.dw_2.GroupCalc( )
//Seta valores Tributa$$HEX2$$e700e300$$ENDHEX$$o
dw_1.Object.vl_bc_icms 			[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_bc_icms")
dw_1.Object.vl_icms 				[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_icms")

dw_1.Object.vl_total_bc_cbs_ibs	[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_bc_ibscbs")
dw_1.Object.vl_total_dif_ibs_uf	[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_dif_ibs_uf")
dw_1.Object.vl_total_dev_ibs_uf	[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_dev_trib_ibs_uf")
dw_1.Object.vl_total_ibs_uf		[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_ibs_uf")
dw_1.Object.vl_total_dif_ibs_mun [1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_dif_ibs_mun")
dw_1.Object.vl_total_dev_ibs_mun	[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_dev_trib_ibs_mun")
dw_1.Object.vl_total_ibs_mun 		[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_ibs_mun")
dw_1.Object.vl_total_ibs			[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_ibs")
dw_1.Object.vl_total_dif_cbs 		[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_dif_cbs")
dw_1.Object.vl_total_dev_cbs		[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_dev_trib_cbs")
dw_1.Object.vl_total_cbs			[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_cbs")

//Seta Totais NF
dw_1.Object.vl_total_produtos [1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_produtos")
dw_1.Object.vl_total_nf			[1] = Tab_1.Tabpage_1.dw_2.GetItemDecimal(0, "vl_total_produtos")
//Atualiza parcelas
wf_formata_parcelas()
end subroutine

public subroutine wf_altera_tributacao_itens ();Long lvl_Linha
Long lvl_Tipo_Sucata

ivo_filial.of_localiza_codigo(dw_1.Object.cd_filial_origem[1])

//Venda de sucata p/ PF na filial 2
If ivo_Cliente.id_fisica_juridica = 'F' And ivo_Filial.cd_filial = 2 Then
	
	Tab_1.TabPage_1.dw_6.Object.cd_cst_tributacao.TabSequence = 1
	Tab_1.TabPage_1.dw_6.Object.cd_cst_tributacao.background.color = rgb(255,255,255)
	Tab_1.TabPage_1.dw_6.Object.pc_icms.TabSequence = 1
	ivs_CST = "00"
	ivs_Msg = ''
			
Else
	
	Tab_1.TabPage_1.dw_6.Object.cd_cst_tributacao.TabSequence = 0
	Tab_1.TabPage_1.dw_6.Object.cd_cst_tributacao.background.color = rgb(227,227,227)
	
	Tab_1.TabPage_1.dw_6.Object.cd_beneficio.TabSequence 		= 0
	Tab_1.TabPage_1.dw_6.Object.cd_beneficio.background.color = rgb(227,227,227)

	// Em opera$$HEX2$$e700f500$$ENDHEX$$es interestaduais $$HEX1$$e900$$ENDHEX$$ tributado
	If (ivo_cliente.Localizado) and ((ivo_cliente.cd_uf <> ivo_filial.cd_unidade_federacao) /*or dw_1.Object.id_tipo[1] = 'U'*/) Then
		ivs_CST 			= '00'
		ivs_Msg			= ''
		
		if ivo_cliente.cd_uf <> ivo_filial.cd_unidade_federacao then
			Select pc_icms_interestadual
			Into :ivdc_Pc_ICMS
			From unidade_federacao
			Where cd_unidade_federacao = :ivo_cliente.cd_uf
			Using SQLCa;
				
			If SQLCa.SQLCode <> 0 Then
				ivdc_Pc_ICMS = 12.00
			End If
		else
			//Fomos solicitados para remover o c$$HEX1$$f300$$ENDHEX$$digo acima e colocar o percentual fixo de 12% para o tipo USO/CONSUMO
			ivdc_Pc_ICMS = 12.00
		end if
	Else
		ivs_CST 			= '51'
		ivdc_Pc_ICMS 	= 0.00
		ivs_Msg 			= 'ICMS DIFERIDO CFE RICMS/SC ANEXO 3, ART. 8$$HEX1$$ba00$$ENDHEX$$ XIV'
	End If
	
End If

Tab_1.TabPage_1.dw_6.Object.cd_cst_tributacao[1] = ivs_CST
Tab_1.TabPage_1.dw_6.Event itemchanged(1,Tab_1.TabPage_1.dw_6.Object.cd_cst_tributacao, ivs_CST)

For lvl_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
	lvl_Tipo_Sucata = Tab_1.TabPage_1.dw_2.Object.id_tipo_sucata	[lvl_Linha]
	
	Tab_1.TabPage_1.dw_2.Object.cd_situacao_tributaria	[lvl_Linha] = '0'+Mid(ivs_CST,1,1)
	Tab_1.TabPage_1.dw_2.Object.cd_cst_tributacao		[lvl_Linha] = ivs_CST
	Tab_1.TabPage_1.dw_2.Object.pc_icms						[lvl_Linha] = ivdc_Pc_ICMS
	Tab_1.Tabpage_1.dw_2.Object.cd_beneficio				[lvl_Linha] = wf_retorna_beneficio(lvl_Tipo_Sucata, ivs_CST)
	
	Tab_1.TabPage_1.dw_6.Object.cd_beneficio[1]			= Tab_1.Tabpage_1.dw_2.Object.cd_beneficio				[lvl_Linha]
	
	wf_calcula_item_tributacao(lvl_Linha)
Next
end subroutine

public subroutine wf_calcula_item_tributacao (long pl_linha);Long lvl_Qtde

String lvs_ID_Trib_CBSIBS

Decimal{2} lvdc_Pc_ICMS
Decimal{2} lvdc_BC_ICMS = 0.00
Decimal{6} lvdc_Vl_Item
Decimal{2} lvdc_vl_bc_pis_cofins
Decimal{2} lvdc_vl_pis
Decimal{2} lvdc_vl_cofins

If ivb_Fechando Then Return 

If pl_linha > 0 Then
	Tab_1.TabPage_1.dw_2.AcceptText()
	dw_1.AcceptText()
	
	If Not ivo_Filial.Localizada or ivo_Filial.cd_filial <> dw_1.Object.cd_filial_origem [1] Then
		ivo_Filial.Of_localiza_codigo( dw_1.Object.cd_filial_origem [1] )
	End If
	
	lvs_ID_Trib_CBSIBS	= Tab_1.TabPage_1.dw_2.Object.id_imposto_tributacao	[pl_linha]
	lvdc_Pc_ICMS			= Tab_1.TabPage_1.dw_2.Object.pc_icms						[pl_linha]
	lvl_Qtde					= Tab_1.TabPage_1.dw_2.Object.qt_item						[pl_linha] 
	lvdc_Vl_Item			= Tab_1.TabPage_1.dw_2.Object.vl_preco_unitario_fiscal[pl_linha]
	
	If lvdc_Pc_ICMS > 0 Then
		lvdc_BC_ICMS = Round(lvdc_Vl_Item * lvl_Qtde,2)
	End If
	
	Tab_1.TabPage_1.dw_2.Object.vl_bc_icms	[pl_linha] = lvdc_BC_ICMS
	Tab_1.TabPage_1.dw_2.Object.vl_icms		[pl_linha] = Round(lvdc_BC_ICMS * (lvdc_Pc_ICMS/100),2)
	//Novo preco unitario - Calculado a partir do preco unitario fiscal do item (vl_preco_unitario_fiscal)
	Tab_1.TabPage_1.dw_2.Object.vl_preco_unitario[pl_linha] = Round(lvdc_Vl_Item,2)
	
	//Calcula CBS/IBS
	If IsNull(lvs_ID_Trib_CBSIBS) or lvs_ID_Trib_CBSIBS='' Then 
		Tab_1.TabPage_1.dw_2.Object.id_imposto_tributacao	[pl_linha] = ivs_Trib_CBSIBS
		Tab_1.TabPage_1.dw_6.Object.id_imposto_tributacao	[pl_linha] = ivs_Trib_CBSIBS
		lvs_ID_Trib_CBSIBS = ivs_Trib_CBSIBS
	End If
	
	ivo_Tratamento_fiscal.of_calcula_cbs_ibs( &
			/*string as_uf_destino*/				ivo_Filial.cd_unidade_federacao, &
			/*long al_cidade_destino*/				ivo_Filial.cd_cidade, &
			/*string as_id_tributacao_cbs_ibs*/	lvs_ID_Trib_CBSIBS, & 
			/*decimal adc_qt_item*/					lvl_Qtde, &
			/*decimal adc_vl_total_operacao*/	lvdc_Vl_Item * lvl_Qtde, & 
			/*decimal adc_vl_frete*/				0, & 
			/*decimal adc_vl_outras*/				0, &
			/*decimal adc_vl_seguro */				0)
	
	Tab_1.TabPage_1.dw_2.Object.cd_cst_ibscbs					[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.cd_cst_ibscbs
	Tab_1.TabPage_1.dw_2.Object.cd_class_trib_ibscbs		[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.cd_class_trib_ibscbs
	Tab_1.TabPage_1.dw_2.Object.vl_bc_ibscbs					[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_bc_ibscbs
	Tab_1.TabPage_1.dw_2.Object.vl_ibs							[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_ibs
	Tab_1.TabPage_1.dw_2.Object.pc_ibs_uf						[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_ibs_uf
	Tab_1.TabPage_1.dw_2.Object.vl_ibs_uf						[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_ibs_uf
	Tab_1.TabPage_1.dw_2.Object.pc_dif_ibs_uf					[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_dif_ibs_uf
	Tab_1.TabPage_1.dw_2.Object.vl_dif_ibs_uf					[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_dif_ibs_uf
	Tab_1.TabPage_1.dw_2.Object.vl_dev_trib_ibs_uf			[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_dev_trib_ibs_uf
	Tab_1.TabPage_1.dw_2.Object.pc_reducao_ibs_uf			[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_reducao_ibs_uf
	Tab_1.TabPage_1.dw_2.Object.pc_efetiva_ibs_uf			[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_efetiva_ibs_uf
	Tab_1.TabPage_1.dw_2.Object.pc_ibs_mun						[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_ibs_mun
	Tab_1.TabPage_1.dw_2.Object.vl_ibs_mun						[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_ibs_mun
	Tab_1.TabPage_1.dw_2.Object.pc_dif_ibs_mun				[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_dif_ibs_mun
	Tab_1.TabPage_1.dw_2.Object.vl_dif_ibs_mun				[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_dif_ibs_mun
	Tab_1.TabPage_1.dw_2.Object.vl_dev_trib_ibs_mun			[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_dev_trib_ibs_mun
	Tab_1.TabPage_1.dw_2.Object.pc_reducao_ibs_mun			[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_reducao_ibs_mun
	Tab_1.TabPage_1.dw_2.Object.pc_efetiva_ibs_mun			[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_efetiva_ibs_mun
	Tab_1.TabPage_1.dw_2.Object.pc_cbs							[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_cbs
	Tab_1.TabPage_1.dw_2.Object.pc_dif_cbs						[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_dif_cbs
	Tab_1.TabPage_1.dw_2.Object.vl_dif_cbs						[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_dif_cbs
	Tab_1.TabPage_1.dw_2.Object.vl_dev_trib_cbs				[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_dev_trib_cbs
	Tab_1.TabPage_1.dw_2.Object.pc_reducao_cbs				[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_reducao_cbs
	Tab_1.TabPage_1.dw_2.Object.pc_efetiva_cbs				[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_efetiva_cbs
	Tab_1.TabPage_1.dw_2.Object.vl_cbs							[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_cbs
	Tab_1.TabPage_1.dw_2.Object.cd_cst_ibscbs_reg			[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.cd_cst_ibscbs_reg
	Tab_1.TabPage_1.dw_2.Object.cd_class_trib_ibscbs_reg	[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.cd_class_trib_ibscbs_reg
	Tab_1.TabPage_1.dw_2.Object.pc_efetiva_reg_ibs_uf		[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_efetiva_reg_ibs_uf
	Tab_1.TabPage_1.dw_2.Object.vl_trib_reg_ibs_uf			[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_trib_reg_ibs_uf
	Tab_1.TabPage_1.dw_2.Object.pc_efetiva_reg_ibs_mun		[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_efetiva_reg_ibs_mun
	Tab_1.TabPage_1.dw_2.Object.vl_trib_reg_ibs_mun			[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_trib_reg_ibs_mun
	Tab_1.TabPage_1.dw_2.Object.pc_efetiva_reg_cbs			[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.pc_efetiva_reg_cbs
	Tab_1.TabPage_1.dw_2.Object.vl_trib_reg_cbs				[pl_linha] = ivo_Tratamento_fiscal.ivo_atributo_nf.vl_trib_reg_cbs
End If
end subroutine

public function boolean wf_inclui_movimento_conta (string ps_cliente, string ps_tipo_titulo, string ps_titulo, long pl_filial, decimal pdc_valor, date pdt_movimento);String lvs_Conta, &
       	lvs_Documento
			 
Long	lvl_Tipo_Movto

lvs_Conta = String(ps_cliente)

lvs_Documento = LeftA(ps_titulo, 4) + "-" + MidA(ps_titulo, 5, 7) + "-" + RightA(ps_titulo, 2)

If Not wf_Tipo_Movto_Conta(ps_tipo_titulo, ref lvl_Tipo_Movto) Then Return False

Insert Into contas_receber_movimento (cd_conta,   
												  id_tipo_conta,   
												  cd_tipo_movimento,   
												  dh_movimento,   
												  dh_sistema,   
												  vl_movimento,
												  cd_filial,
												  nr_documento,   
												  de_historico,   
												  nr_titulo_fechamento)  
Select 	:lvs_Conta,
       		:ps_tipo_titulo,
		 	:lvl_Tipo_Movto,
		 	:pdt_movimento,
		 	getdate(),
		 	:pdc_Valor,
		 	:pl_filial,
		 	:lvs_Documento,
		 	null,
		 	:ps_Titulo
From parametro
Where id_parametro = '1'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Movimento")
	Return False
End If

Return True
end function

public function boolean wf_tipo_movto_conta (string ps_tipo_conta, ref long pl_codigo);Boolean lvb_Sucesso = False

Select cd_tipo_movimento Into :pl_Codigo
From contas_receber_tipo_movimento
Where id_tipo_conta  = :ps_tipo_conta
  and id_venda 			= 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do movimento de vendas n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo do Movimento de Venda")
End Choose

Return lvb_Sucesso
end function

public function string wf_retorna_beneficio (long pl_tipo_sucata, string ps_cst);String lvs_UF
String lvs_Beneficio

Long lvl_CFOP
Long lvl_Null

dw_1.Accepttext( )
lvs_UF = dw_1.Object.nm_uf [1]

lvl_CFOP = IIF(lvs_UF = gvo_parametro.ivs_uf_filial, 5102, 6102)
SetNull(lvl_Null)
lvs_Beneficio = ivo_Tratamento_fiscal.of_retorna_codigo_beneficio( lvs_UF, lvl_CFOP, '0', ps_cst, lvl_Null)

If IsNull(lvs_Beneficio) and (ps_cst = '50' or ps_cst = '51') then
	Choose Case gvo_parametro.ivs_uf_filial
		Case 'RS' 
			lvs_Beneficio = 'RS052019'
		Case 'PR'
			lvs_Beneficio = 'PR830006'
		Case 'SC' 
			lvs_Beneficio = 'SC830085'
		Case Else
			SetNull(lvs_Beneficio)
	End Choose
Else
	SetNull(lvs_Beneficio)
End If

Return lvs_Beneficio
end function

public function boolean wf_verifica_produto_sap (long pl_tipo, ref string ps_erro);Boolean lvb_Sucesso = False
String ls_produto_sap

Select cd_produto_sap 
Into :ls_produto_sap
From wms_produto_sucata
Where cd_tipo_produto  = :pl_tipo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(ls_produto_sap) or ls_produto_sap = '' Then
			ps_erro = "C$$HEX1$$f300$$ENDHEX$$digo do produto SAP {cd_produto_sap} n$$HEX1$$e300$$ENDHEX$$o informado para o tipo de sucata: " + String(pl_tipo)
		Else
			lvb_Sucesso = True
		End If
	Case 100
		ps_erro = "C$$HEX1$$f300$$ENDHEX$$digo do tipo de sucata n$$HEX1$$e300$$ENDHEX$$o localizado."
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo do tipo de sucata")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_grava_integracao_wmu_sap (ref string as_erro);Long	ll_nr_integracao, &
		ll_for, &
		ll_count, &
		ll_nr_sequencial, &
		ll_qt_lote, &
		ll_cd_tipo_sucata, &
		ll_class_fiscal, ll_id_tipo_frete
String	ls_de_dados_adicionais, &
		ls_cd_cliente, &
		ls_cd_produto_sap, &
		ls_cd_unidade_medida
//		ls_cd_forma_pagamento, &
//		ls_cd_condicao_pagamento_sap
Decimal lde_vl_preco

If not gf_proximo_seq_int_wms(ref ll_nr_integracao, ref as_erro) Then
	 Return False
End If

ls_de_dados_adicionais = ''

//Dados adicionais 
For ll_for = 1 to 8	
	If ls_de_dados_adicionais = '' Then
		ls_de_dados_adicionais = Tab_1.TabPage_2.dw_5.GetItemString(1,"de_dados_adicionais_"+String(ll_for))
	Else
		ls_de_dados_adicionais += ' | '+Tab_1.TabPage_2.dw_5.GetItemString(1,"de_dados_adicionais_"+String(ll_for))
	End If
Next

ls_cd_cliente = String(ivo_cliente.cd_cliente)

If is_id_frete_nf_diversa = 'S' Then
	ll_id_tipo_frete = long(dw_1.object.id_tipo_frete[1])
Else
	setnull(ll_id_tipo_frete)
End If

//comentado por conta do erro no chamado 1618306
//ls_cd_forma_pagamento	= tab_1.tabpage_2.dw_3.Object.cd_forma_pagamento [1]
//
//select cd_chave_sap
//  into :ls_cd_condicao_pagamento_sap
//  from integracao_sap 
// where cd_tabela = 'CONDICAO_PAGAMENTO'
//   and cd_chave_legado	= :ls_cd_forma_pagamento;
//
//Choose Case SQLCA.SQLCode
//	Case -1
//		as_Erro	= "Erro ao buscar condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento SAP na integracao_sap. Erro: "+SqlCa.SqlErrText
//		Return False
//	Case 100
//		as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o encontrado registro da condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento SAP na integracao_sap. Erro: "+SqlCa.SqlErrText
//		Return False
//End Choose

//Grava wms_int_sap
INSERT INTO wms_int_sap
            (nr_integracao,
             cd_tipo,
             dh_inclusao,
             id_situacao,
             cd_cliente,
             cd_filial,
             qt_volume,
             de_dados_adicionais,
				 cd_tipo_frete )
VALUES  (:ll_nr_integracao,
             5,
             getdate(),
             'C',
             :ls_cd_cliente,
             534,
             1,
             :ls_de_dados_adicionais,
				 :ll_id_tipo_frete ) 
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro	= "Erro ao gravar na tabela {wms_int_sap}. Erro: "+SqlCa.SqlErrText
	Return False
End If

//Grava wms_int_sap_detalhe
ll_count = Tab_1.TabPage_1.dw_2.RowCount()
ll_nr_sequencial = 0

For ll_for = 1 to ll_count
	
	ll_nr_sequencial ++
	lde_vl_preco =  Tab_1.TabPage_1.dw_2.GetItemDecimal( ll_for, "vl_preco_unitario")
	ll_qt_lote = Tab_1.TabPage_1.dw_2.GetItemNumber( ll_for, "qt_item")
	ll_cd_tipo_sucata = Tab_1.TabPage_1.dw_2.GetItemNumber( ll_for, "id_tipo_sucata")
	If Not wf_busca_produto_sucata(ll_cd_tipo_sucata, ref ls_cd_produto_sap, ref ls_cd_unidade_medida, ref ll_class_fiscal, ref as_erro) Then
		Return False
	End If
			
	INSERT INTO wms_int_sap_detalhe
					(nr_integracao,
					 nr_sequencial,
					 qt_lote,
					 cd_produto_sap,
					 vl_preco,
					 cd_unidade_medida)
	VALUES      (:ll_nr_integracao,
					 :ll_nr_sequencial,
					 :ll_qt_lote,
					 :ls_cd_produto_sap,
					 :lde_vl_preco,
					 :ls_cd_unidade_medida) 
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro	= "Erro ao gravar na tabela {wms_int_sap_detalhe}. Erro: "+SqlCa.SqlErrText
		Return False
	End If

Next

Return True

end function

public function boolean wf_busca_produto_sucata (integer pl_tipo, ref string ps_produto_sap, ref string ps_unidade_medida, ref long pl_nr_classificacao_fiscal, ref string ps_erro);Boolean lvb_Sucesso = False

Select cd_produto_sap, cd_unidade_medida, nr_classificacao_fiscal 
Into :ps_produto_sap, :ps_unidade_medida, :pl_nr_classificacao_fiscal
From wms_produto_sucata
Where cd_tipo_produto  = :pl_tipo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		ps_erro = "C$$HEX1$$f300$$ENDHEX$$digo do tipo de sucata n$$HEX1$$e300$$ENDHEX$$o localizado."
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo do tipo de sucata")
End Choose

Return lvb_Sucesso
end function

public subroutine wf_bloqueio_campo_tipo_nf_sucata ();If not isnull(dw_1.Object.id_tipo[1]) and long(dw_1.Object.id_tipo[1]) <> 0 then 
	dw_1.Object.id_tipo.protect = 1
Else
	dw_1.Object.id_tipo[1] = 0
	dw_1.Object.id_tipo.protect = 0
End If
end subroutine

public subroutine wf_insere_padrao_tipo_nf_sucata ();DataWindowChild	ldwc_Child

ldwc_Child  = dw_1.of_InsertRow_DDDW("id_tipo" )			
ldwc_Child.SetItem(1, "cd_tipo_nf_sucata", 0	)
ldwc_Child.SetItem(1, "de_tipo_nf_sucata", "SELECIONE")
ldwc_Child.SetItem(1, "cd_tipo_nf_sucata_sap", "0")

end subroutine

public function boolean wf_vincula_tipo_nf_sucata_cliente (ref string as_erro);String ls_cd_cliente
Long ll_Cd_Tipo_Nf_Sucata

ls_cd_cliente = String(ivo_cliente.cd_cliente)

If IsNull( ivo_cliente.cd_tipo_nf_sucata ) Then
	ll_Cd_Tipo_Nf_Sucata = dw_1.object.id_tipo[1]
	
	Update cliente 
	set cd_tipo_nf_sucata = :ll_Cd_Tipo_Nf_Sucata
	where cd_cliente = :ls_cd_cliente
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro	= "Erro ao gravar tipo_nf_sucata do cliente " + ls_cd_cliente + ". Erro: "+SqlCa.SqlErrText
		Return False
	End If
End If

Return True

end function

public function boolean wf_busca_parametro_loja ();Long ll_Filial

ll_Filial = dw_1.object.cd_filial_origem[1]

Select vl_parametro
Into :is_id_frete_nf_diversa
from parametro_loja 
Where cd_parametro = 'ID_FRETE_NF_DIVERSA'
		and cd_filial = :ll_Filial
Using SqlCa;

If SqlCa.SQLCode < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao buscar o par$$HEX1$$e200$$ENDHEX$$metro de loja ID_FRETE_NF_DIVERSA. ERRO: "+SqlCa.SqlErrText)
	Return false
End If

If is_id_frete_nf_diversa = 'S' Then
	dw_1.object.t_id_tipo_frete.visible = true
	dw_1.object.id_tipo_frete.visible = true
Else
	dw_1.object.t_id_tipo_frete.visible = false
	dw_1.object.id_tipo_frete.visible = false
End If

Return true

end function

public function boolean wf_verifica_ultimo_tipo_frete (ref string as_ultimo_tipo_frete);String ls_cd_cliente

ls_cd_cliente = String(ivo_cliente.cd_cliente)

setnull(as_ultimo_tipo_frete)

SELECT cd_tipo_frete
INTO :as_ultimo_tipo_frete
FROM wms_int_sap 
where cd_tipo = 5 
	and cd_cliente = :ls_cd_cliente
	and dh_inclusao = (select max(dh_inclusao) from wms_int_sap 
								where cd_tipo = 5 and cd_cliente = :ls_cd_cliente)
using sqlca;

If SqlCa.SQLCode < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao buscar o ultimo tipo de frete do Cliente. ERRO: "+SqlCa.SqlErrText)
	Return false
End If

If IsNull(as_ultimo_tipo_frete) Or Trim(as_ultimo_tipo_frete) = '' Then
	//Venda de sucata p/ PF na filial 2
	If ivo_Filial.cd_filial = 2 Then 
		as_ultimo_tipo_frete = "1" //1 - Dest
	End If
End If

Return true

end function

public function boolean wf_verifica_tipo_tributacao (string ps_cst);Boolean lvb_Sucesso = False
String ls_id_icms_normal 

ps_cst = Left(ps_cst,1)

Select id_icms_normal 
Into :ls_id_icms_normal
From tributacao_icms
Where cd_tributacao_icms = :ps_cst
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_id_icms_normal = 'S' Then 
			lvb_Sucesso = True
		End If
	Case -1
		lvb_Sucesso = False
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo do tipo de sucata")
End Choose

Return lvb_Sucesso
end function

public subroutine wf_atribui_pecentual_icms_digitado (decimal pd_percentual);Long lvl_for

If pd_percentual > 0 and pd_percentual <= 100 Then
	For lvl_for = 1 To Tab_1.TabPage_1.dw_2.RowCount( )
		//Percentual digitado
		Tab_1.TabPage_1.dw_2.Object.pc_icms[lvl_for] = pd_percentual
		//Ajuste tributacao do produto
		wf_calcula_item_tributacao(lvl_for)
	Next
	//Totais
	wf_calcula_totais()
Else
	Tab_1.TabPage_1.dw_6.Object.pc_icms[Tab_1.TabPage_1.dw_6.GetRow()] = 0
	Tab_1.TabPage_1.dw_6.AcceptText()
End If
end subroutine

on w_ge439_nf_venda_diversa.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.tab_1=create tab_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_ge439_nf_venda_diversa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.tab_1)
destroy(this.gb_1)
end on

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_cliente)
Destroy(ivo_nota_fiscal)
Destroy(ivo_parametro)
Destroy(ivo_Titulo)
Destroy(ivo_Tratamento_fiscal)
end event

event ue_preopen;call super::ue_preopen;ivo_filial 						= Create uo_filial
ivo_cliente 					= Create uo_cliente
ivo_nota_fiscal 				= Create uo_nota_fiscal
ivo_parametro 				= Create uo_parametro_geral
ivo_Titulo					= Create uo_Titulo
ivo_Tratamento_fiscal	= Create uo_Tratamento_Fiscal

/* Seta Menu nas DWs */
dw_1.of_SetMenu( This.ivm_Menu )
Tab_1.TabPage_1.dw_2.of_SetMenu( This.ivm_Menu )
Tab_1.TabPage_2.dw_3.of_SetMenu( This.ivm_Menu )
Tab_1.TabPage_2.dw_4.of_SetMenu( This.ivm_Menu )
Tab_1.TabPage_2.dw_5.of_SetMenu( This.ivm_Menu )

/* Seta controles de inclus$$HEX1$$e300$$ENDHEX$$o e exclus$$HEX1$$e300$$ENDHEX$$o por DW */
dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_1.ivo_Controle_Menu.of_Excluir(False)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Excluir(False)
Tab_1.TabPage_2.dw_5.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_2.dw_5.ivo_Controle_Menu.of_Excluir(False)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Excluir(True)
Tab_1.TabPage_2.dw_4.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_2.dw_4.ivo_Controle_Menu.of_Excluir(True)

/*Seta DW para update*/
//Ver ue_postopen
//dc_uo_dw_Base lvo_Update[]
//lvo_Update = {	dw_1,	Tab_1.TabPage_1.dw_2,Tab_1.TabPage_2.dw_4}
//This.wf_SetUpdate_DW(lvo_Update)

/*Inicia menus*/
This.ivm_menu.mf_incluir(False)
This.ivm_menu.mf_excluir(False)
end event

event ue_postopen;call super::ue_postopen;String ls_msg

dw_1.Event ue_AddRow()
Tab_1.Tabpage_2.dw_3.Event ue_AddRow()
Tab_1.Tabpage_1.dw_2.Event ue_AddRow()

dw_1.SetFocus()

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'FI' Then
	dw_1.Object.cd_filial_origem.TabSequence = 1
	dw_1.Object.cd_filial_origem.Initial = '2'
	dw_1.Object.cd_filial_origem [1] = 2
Else
	dw_1.Object.cd_filial_origem.TabSequence = 0
	// 1424125 - S$$HEX1$$f300$$ENDHEX$$ busca o par$$HEX1$$e200$$ENDHEX$$metro SAP se n$$HEX1$$e300$$ENDHEX$$o foi aberto pelo FI.
	If Not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref ib_Iniciado_Operacao_SAP, ref ls_msg ) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg)
		Close(This)
	End If
End If

dw_1.Event ue_Pos(1,'nm_destinatario')

//Deve permitir a venda para clientes n$$HEX1$$e300$$ENDHEX$$o credi$$HEX1$$e100$$ENDHEX$$rio, pois $$HEX1$$e900$$ENDHEX$$ realizada venda de ativos para funcion$$HEX1$$e100$$ENDHEX$$rios.
//ivo_Cliente.ivs_Tipo_Cliente = 'CR'

If ib_Iniciado_Operacao_SAP Then	
	Tab_1.TabPage_1.dw_6.Object.de_item.TabSequence = 0
	Tab_1.TabPage_1.dw_6.Object.cd_beneficio.TabSequence = 0
	Tab_1.TabPage_2.dw_3.Object.cd_forma_pagamento.TabSequence = 0
	Tab_1.TabPage_2.dw_3.Object.dt_primeiro_vcto.TabSequence = 0
	Tab_1.TabPage_2.dw_3.Object.nr_parcelas.TabSequence = 0
	Tab_1.TabPage_2.dw_3.Object.nr_intervalo.TabSequence = 0
	Tab_1.TabPage_2.dw_4.Object.dh_vencimento.TabSequence = 0
	Tab_1.TabPage_2.dw_4.Object.vl_nominal.TabSequence = 0
	Tab_1.TabPage_2.dw_5.Object.vl_bc_icms.TabSequence = 0
	Tab_1.TabPage_2.dw_5.Object.vl_icms.TabSequence = 0
Else
	/*Seta DW para update*/
	dc_uo_dw_Base lvo_Update[]
	lvo_Update = {	dw_1,	Tab_1.TabPage_1.dw_2,Tab_1.TabPage_2.dw_4}
	This.wf_SetUpdate_DW(lvo_Update)
End If

wf_insere_padrao_tipo_nf_sucata()

wf_busca_parametro_loja()

gf_data_parametro(idt_data_parametro)
end event

event ue_cancel;call super::ue_cancel;ivo_cliente.Of_inicializa( )
ivo_filial.of_localiza_codigo(2)

dw_1.Event ue_Cancel()
Tab_1.Tabpage_2.dw_3.Event ue_Cancel()
Tab_1.Tabpage_1.dw_2.Event ue_Cancel()

end event

event ue_update;call super::ue_update;String ls_log

If dw_1.object.id_tipo[1] <> 0 Then
	If Not wf_vincula_tipo_nf_sucata_cliente(ref ls_log) Then
		SqlCa.of_RollBack( )
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_log)
		Return False
	End If
End If 

If ib_Iniciado_Operacao_SAP Then
	If wf_grava_integracao_wmu_sap(ref ls_log) Then
		SqlCa.of_Commit( )
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Aguarde a gera$$HEX2$$e700e300$$ENDHEX$$o de nota dentro do SAP.")
		This.Event ue_cancel()
	Else
		SqlCa.of_RollBack( )
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_log, StopSign!)
	End If
Else
	If AncestorReturnValue Then
		If (Tab_1.TabPage_2.dw_4.Event ue_Update() >= 0) Then
			If dw_1.Object.de_especie[1] = "NFE" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A nota fiscal deve ser impressa pelo sistema de NF-e.")
			End If
			This.Event ue_cancel()
		End If
	End If
End If

Return AncestorReturnValue
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha
Long lvl_Qtde
Long lvl_id_tipo_sucata

Decimal{2} lvdc_Produtos
Decimal{2} lvdc_Receber
Decimal{2} lvdc_NF
Decimal{2} lvdc_Parcela
Decimal{2} lvdc_Pc_ICMS
Decimal{6} lvdc_Vl_Unit

String lvs_Cliente
String lvs_CST
String lvs_Tipo_Venda
String lvs_Desc_Item
String lvs_Msg
String lvs_Cd_Beneficio

If long(dw_1.Object.id_tipo[1]) = 0 Or Isnull(dw_1.Object.id_tipo[1]) Then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Favor Selecionar o Tipo!')
	dw_1.Event ue_Pos(1, "id_tipo")
	Return false
End If

If Not ib_Iniciado_Operacao_SAP Then 
	wf_calcula_totais()
End If

dw_1.Accepttext( )
Tab_1.Tabpage_2.dw_5.Accepttext( )
Tab_1.Tabpage_1.dw_6.Accepttext( )
lvs_Cliente		= dw_1.Object.nr_cgc_cpf			[1]
lvdc_Produtos	= dw_1.Object.vl_total_produtos	[1]
lvdc_NF			= dw_1.Object.vl_total_nf 			[1]
lvdc_Receber	= Tab_1.Tabpage_2.dw_4.GetItemDecimal(0, "vl_total_receber")
lvs_Cd_Beneficio = Tab_1.tabpage_1.dw_6.Object.cd_beneficio	[1]

//Valida$$HEX2$$e700f500$$ENDHEX$$es Gerais 
If (IsNull(lvs_Cliente)or(lvs_Cliente='')) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Favor preencher o cliente da nota!',Exclamation!)
	dw_1.Event ue_pos(1,'nm_destinatario')
	Return False
End if

//Valida$$HEX2$$e700f500$$ENDHEX$$es Itens
If Tab_1.tabpage_1.dw_2.RowCount()=0 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio que seja informado ao menos um produto!',Exclamation!)
	Tab_1.Selectedtab = 1
	Tab_1.tabpage_1.dw_2.Setfocus( )
	Return False
End if

If IsNull(lvdc_Produtos)or(lvdc_Produtos = 0.00) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio que os valores dos produtos sejam maiores que zero!',Exclamation!)
	Tab_1.Selectedtab = 1
	Tab_1.tabpage_1.dw_2.Setfocus( )
	Return False
End if

For lvl_Linha = 1 To Tab_1.tabpage_1.dw_2.RowCount()
	lvs_CST				= Tab_1.tabpage_1.dw_2.Object.cd_cst_tributacao			[lvl_Linha]
	lvdc_Pc_ICMS		= Tab_1.tabpage_1.dw_2.Object.pc_icms						[lvl_Linha]
	lvl_Qtde				= Tab_1.tabpage_1.dw_2.Object.qt_item						[lvl_Linha]
	lvdc_Vl_Unit			= Tab_1.tabpage_1.dw_2.Object.vl_preco_unitario_fiscal	[lvl_Linha]
	lvs_Desc_Item		= Tab_1.tabpage_1.dw_2.Object.de_item						[lvl_Linha]
	lvl_id_tipo_sucata	= Tab_1.tabpage_1.dw_2.Object.id_tipo_sucata				[lvl_Linha]
//	lvs_Cd_Beneficio	= Tab_1.tabpage_1.dw_2.Object.cd_beneficio				[lvl_Linha]
	
	If IsNull(lvs_Desc_Item) or lvs_Desc_Item = '' Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar uma descri$$HEX2$$e700e300$$ENDHEX$$o para o item!',Exclamation!)
		Tab_1.Selectedtab = 1
		Tab_1.tabpage_1.dw_2.Setfocus( )
		Tab_1.tabpage_1.dw_2.Event ue_Pos(lvl_Linha,'de_item')
		Return False		
	End If
	
	If IsNull(lvl_Qtde)or(Not (lvl_Qtde > 0)) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','A quantidade deve ser maior que zero!',Exclamation!)
		Tab_1.Selectedtab = 1
		Tab_1.tabpage_1.dw_2.Setfocus( )
		Tab_1.tabpage_1.dw_2.Event ue_Pos(lvl_Linha,'qt_item')
		Return False			
	End If

	If IsNull(lvdc_Vl_Unit)or(Not (lvdc_Vl_Unit > 0)) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','O valor unit$$HEX1$$e100$$ENDHEX$$rio deve ser maior que zero!',Exclamation!)
		Tab_1.Selectedtab = 1
		Tab_1.tabpage_1.dw_2.Setfocus( )
		Tab_1.tabpage_1.dw_2.Event ue_Pos(lvl_Linha,'vl_preco_unitario_fiscal')
		Return False			
	End If
	
	If Not ib_Iniciado_Operacao_SAP Then
		If (lvdc_Pc_ICMS>100) Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Verifique a al$$HEX1$$ed00$$ENDHEX$$quota de ICMS informada!',Exclamation!)
			Tab_1.Selectedtab = 1
			Tab_1.tabpage_1.dw_6.Setfocus( )
			Tab_1.tabpage_1.dw_6.Event ue_Pos(lvl_Linha,'pc_icms')
			Return False	
		End If
		
		If ((lvs_CST = '00')or(lvs_CST = '10')or(lvs_CST = '20')or(lvs_CST = '70'))and(lvdc_Pc_ICMS=0.00) Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Produtos com CST '+lvs_CST+' devem ter a al$$HEX1$$ed00$$ENDHEX$$quota de ICMS informada!',Exclamation!)
			Tab_1.Selectedtab = 1
			Tab_1.tabpage_1.dw_6.Setfocus( )
			Tab_1.tabpage_1.dw_6.Event ue_Pos(lvl_Linha,'pc_icms')
			Return False	
		End If
	End If
	
	// O c$$HEX1$$f300$$ENDHEX$$digo do benef$$HEX1$$ed00$$ENDHEX$$cio da filial 534 $$HEX1$$e900$$ENDHEX$$ preenchida pelo SAP
//	If dw_1.Object.cd_filial_origem	[1]  <> 534 Then
//		If IsNull(lvs_Cd_Beneficio) or lvs_Cd_Beneficio = '' Then
//			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','O c$$HEX1$$f300$$ENDHEX$$digo benef$$HEX1$$ed00$$ENDHEX$$cio do produto deve ser informado para emitir a nota!',Exclamation!)
//			Tab_1.Selectedtab = 1
//			Tab_1.tabpage_1.dw_6.Setfocus( )
//			Tab_1.tabpage_1.dw_6.Event ue_Pos(lvl_Linha,'cd_beneficio')
//			Return False
//		End If
//	End If
	
	If ib_Iniciado_Operacao_SAP Then
		If Not wf_verifica_produto_sap( lvl_id_tipo_sucata, ref lvs_msg ) Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', lvs_msg, Exclamation!)
			Tab_1.Selectedtab = 1
			Tab_1.tabpage_1.dw_2.Setfocus( )
			Tab_1.tabpage_1.dw_2.Event ue_Pos(lvl_Linha,'id_tipo_sucata')
			Return False	
		End If
	End If
Next

//Valida$$HEX2$$e700f500$$ENDHEX$$es CRE
If Not ib_Iniciado_Operacao_SAP Then
	If Tab_1.tabpage_2.dw_4.RowCount()=0 Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio que seja informado o parcelamento!',Exclamation!)
		Tab_1.Selectedtab = 2
		Tab_1.tabpage_2.dw_4.Setfocus( )
		Return False
	End if
	
	If lvdc_NF <> lvdc_Receber Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','A somat$$HEX1$$f300$$ENDHEX$$ria das parcelas n$$HEX1$$e300$$ENDHEX$$o fecha com o valor da Nota!',Exclamation!)
		Tab_1.Selectedtab = 2
		Tab_1.Tabpage_2.dw_4.Setfocus( )
		Return False	
	End If
	
	For lvl_Linha = 1 To Tab_1.Tabpage_2.dw_4.RowCount()
		lvdc_Parcela = Tab_1.Tabpage_2.dw_4.Object.vl_nominal [lvl_Linha]
		If Not(lvdc_Parcela > 0) Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','O valor da parcela tem de ser maior que zero!',Exclamation!)
			Tab_1.Selectedtab = 2
			Tab_1.Tabpage_2.dw_4.Setfocus( )
			Tab_1.Tabpage_2.dw_4.Event ue_Pos(lvl_Linha,'vl_nominal')
			Return False	
		End If
	Next
End If

Return AncestorReturnValue
end event

event ue_save;//override
Integer lvi_Retorno = -1,&
			lvl_linhas

Long 	lvl_linha,&
		lvl_linha_s,&
		lvl_localizou,&
		ll_id_tipo_sucata,&
		ll_id_tipo_sucata_atual
		
String ls_de_tipo_produto
		 
Boolean lvb_Update, &
        lvb_EndTran

SetPointer(HourGlass!)

This.ivb_Salvando = True

lvl_linhas = Tab_1.TabPage_1.dw_2.RowCount()

For lvl_linha = 1 To lvl_linhas
	
	ll_id_tipo_sucata  = Tab_1.TabPage_1.dw_2.GetItemNumber(lvl_linha, "id_tipo_sucata")
	
	lvl_localizou = 0
	
   For lvl_linha_s = 1 To lvl_linhas
        ll_id_tipo_sucata_atual = Tab_1.TabPage_1.dw_2.GetItemNumber(lvl_linha_s, "id_tipo_sucata")
        If ll_id_tipo_sucata = ll_id_tipo_sucata_atual Then
            lvl_localizou += 1
		  End If
	Next

   If lvl_localizou > 1 Then
			
			Select de_tipo_produto
				Into :ls_de_tipo_produto
			From wms_produto_sucata
			Where cd_tipo_produto = :ll_id_tipo_sucata
			Using SqlCa;

			Choose Case SqlCa.SqlCode
				Case 100
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo da sucata '"+String(ll_id_tipo_sucata)+"' n$$HEX1$$e300$$ENDHEX$$o localizado.")
					Return -1
				Case -1
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Error na localiza$$HEX2$$e700e300$$ENDHEX$$o" + SQLCA.SQLErrText)
					Return -1
				Case 0
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto "+ls_de_tipo_produto+" j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ na lista de faturamento.~rN$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido faturar o mesmo produto mais de uma vez.")
      			Return -1
			End Choose
	End If
Next


If This.Event ue_PreSave() Then 
	If wf_AcceptText() Then 
		If This.Event ue_PreUpdate() Then 
			If wf_UpdatesPending() Or ib_Iniciado_Operacao_SAP Then
				If This.Event ue_BeginTran() Then 
					lvb_Update = This.Event ue_Update()
					
					lvb_EndTran = This.Event ue_EndTran(lvb_Update)
					
					If lvb_Update Then 
						If lvb_EndTran Then 
							lvi_Retorno = 1 // Sucesso
							This.ivb_Valida_Salva = False
						End If
					Else
						This.Event ue_dbError()
					End If
				End If
			Else
				Return -1
			End If
		Else
			Return -1
		End If
	End If
Else
	Return -1
End If

//This.ivb_Valida_Salva = False
This.ivb_Salvando     = False

SetPointer(Arrow!)

Close(This)

Return lvi_Retorno
end event

event ue_presave;call super::ue_presave;Long	ll_for, ll_id_tipo_sucata

If long(dw_1.Object.id_tipo[1]) = 0 Or Isnull(dw_1.Object.id_tipo[1]) Then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Favor Selecionar o Tipo!')
	dw_1.Event ue_Pos(1, "id_tipo")
	Return false
End If

Tab_1.Tabpage_1.dw_2.AcceptText()

if IsValid(ivo_cliente) then
	for ll_for = 1 to Tab_1.Tabpage_1.dw_2.RowCount()
		ll_id_tipo_sucata	= Tab_1.Tabpage_1.dw_2.Object.id_tipo_sucata[ll_for]
			
//		if ll_id_tipo_sucata	<> 8 and ivo_cliente.localizado and ( dw_1.Object.id_tipo[1] = 'U') then
//			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel vender esse tipo de sucata (' + String(ll_id_tipo_sucata) + ') para este cliente. Em caso de d$$HEX1$$fa00$$ENDHEX$$vidas, contate o respons$$HEX1$$e100$$ENDHEX$$vel.', StopSign!)
//			This.SetRedraw( True )
//			return False
//		end if
	next
end if

return true
end event

event closequery;call super::closequery;ivb_Fechando = True
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge439_nf_venda_diversa
integer x = 37
integer y = 2192
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge439_nf_venda_diversa
integer x = 0
integer y = 2120
end type

type dw_1 from dc_uo_dw_base within w_ge439_nf_venda_diversa
integer x = 73
integer y = 112
integer width = 2405
string dataobject = "dw_ge439_nf_diversa"
end type

event constructor;call super::constructor;ivi_tipo_cancelar = ADDROW

This.ShareData(Tab_1.TabPage_2.dw_5)
end event

event ue_key;call super::ue_key;String lvs_Cliente
If Key = KeyEnter! Then
	Choose Case This.GetColumnName( )
		Case "nm_destinatario"
			ivo_cliente.of_localiza_cliente(This.GetText())
			If ivo_Cliente.Localizado Then	
				If ivo_Cliente.id_fisica_juridica = 'J' Then
					This.Object.nm_destinatario		[1] = ivo_Cliente.nm_razao_social
				ElseIf dw_1.Object.cd_filial_origem[1] <> 2 Then // Permite NFe sucata p/ PF na filial 2
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ permitido emitir Nota Fiscal de Venda de Sucata apenas para pessoa jur$$HEX1$$ed00$$ENDHEX$$dica." , Exclamation!)
					
					ivo_Cliente.of_inicializa()
					Return 1
				Else
					This.Object.nm_destinatario		[1] = ivo_Cliente.nm_cliente	
				End if
				This.Object.nr_cgc_cpf				[1] = ivo_Cliente.nr_cpf_cgc
				This.Object.nr_inscricao_estadual	[1] = ivo_Cliente.nr_inscricao_estadual
				This.Object.nm_cidade				[1] = ivo_Cliente.nm_cidade
				This.Object.nm_uf						[1] = ivo_Cliente.cd_unidade_federacao
				This.Object.de_endereco				[1] = ivo_Cliente.de_endereco
				This.Object.de_bairro					[1] = ivo_Cliente.de_bairro
				This.Object.nr_cep					[1] = ivo_Cliente.nr_cep
				This.Object.cd_cidade				[1] = ivo_Cliente.cd_cidade
				This.Object.nr_endereco				[1] = ivo_Cliente.nr_endereco
				This.Object.nr_telefone				[1] = ivo_cliente.nr_ddd_fone+ivo_cliente.nr_fone		
				This.Object.de_email_envio_xml	[1] = ivo_cliente.de_email
				This.Object.id_tipo						[1] = long(ivo_Cliente.cd_tipo_nf_sucata)
				
				wf_bloqueio_campo_tipo_nf_sucata()
				
				wf_altera_tributacao_itens()
				Tab_1.Tabpage_1.dw_2.SetFocus()			
			Else				
				ivo_Cliente.of_inicializa()
				
				This.Object.nm_destinatario			[1] = ivo_Cliente.nm_razao_social
				This.Object.nr_cgc_cpf				[1] = ivo_Cliente.nr_cpf_cgc
				This.Object.nr_inscricao_estadual	[1] = ivo_Cliente.nr_inscricao_estadual
				This.Object.nm_cidade				[1] = ivo_Cliente.nm_cidade
				This.Object.nm_uf						[1] = ivo_Cliente.cd_unidade_federacao
				This.Object.de_endereco				[1] = ivo_Cliente.de_endereco
				This.Object.de_bairro					[1] = ivo_Cliente.de_bairro
				This.Object.nr_cep					[1] = ivo_Cliente.nr_cep
				This.Object.cd_cidade				[1] = ivo_Cliente.cd_cidade
				This.Object.nr_endereco				[1] = ivo_Cliente.nr_endereco		
				This.Object.nr_telefone				[1] = ivo_cliente.nr_ddd_fone+ivo_cliente.nr_fone				
				This.Object.de_email_envio_xml	[1] = ivo_cliente.de_email	
				This.Object.id_tipo						[1] = long(ivo_Cliente.cd_tipo_nf_sucata)
			End If	
			
			If ivo_filial.cd_unidade_federacao <> ivo_cliente.cd_unidade_federacao Then
				This.Object.cd_natureza_operacao	[1] = 6102
			Else
				This.Object.cd_natureza_operacao	[1] = 5102
			End If
			
			wf_bloqueio_campo_tipo_nf_sucata()
			This.ivm_menu.mf_confirmar(ivo_Cliente.Localizado)
			This.ivm_menu.mf_cancelar(ivo_Cliente.Localizado)
			
			String ls_Ult_Tp_Frete
			wf_verifica_ultimo_tipo_frete(Ref ls_Ult_Tp_Frete)
			dw_1.object.id_tipo_frete[1] = ls_Ult_Tp_Frete		
			
	End Choose
End If
end event

event itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case 'cd_filial'
		ivo_Filial.of_localiza_filial(Data)	
		
		If ivo_filial.cd_unidade_federacao <> ivo_cliente.cd_unidade_federacao Then
			This.Object.cd_natureza_operacao	[1] = 6102
		Else
			This.Object.cd_natureza_operacao	[1] = 5102
		End If
		
	Case "nm_destinatario"
		If Data <> ivo_cliente.Nm_Cliente Then
			If Data <> '' Then
				Return 1
			Else
				ivo_cliente.of_inicializa( )
				This.Object.nm_destinatario			[Row] = ivo_Cliente.nm_razao_social
				This.Object.nr_cgc_cpf				[Row] = ivo_Cliente.nr_cpf_cgc
				This.Object.nr_inscricao_estadual	[Row] = ivo_Cliente.nr_inscricao_estadual
				This.Object.nm_cidade				[Row] = ivo_Cliente.nm_cidade
				This.Object.nm_uf						[Row] = ivo_Cliente.cd_unidade_federacao
				This.Object.de_endereco				[Row] = ivo_Cliente.de_endereco
				This.Object.de_bairro					[Row] = ivo_Cliente.de_bairro
				This.Object.nr_cep					[Row] = ivo_Cliente.nr_cep
				This.Object.cd_cidade				[Row] = ivo_Cliente.cd_cidade
				This.Object.nr_endereco				[Row] = ivo_Cliente.nr_endereco
				This.Object.id_tipo						[Row] = long(ivo_Cliente.cd_tipo_nf_sucata)
				
				String ls_Ult_Tp_Frete
				wf_verifica_ultimo_tipo_frete(Ref ls_Ult_Tp_Frete)
				dw_1.object.id_tipo_frete[1] = ls_Ult_Tp_Frete
				
			End If
			
			If ivo_filial.cd_unidade_federacao <> ivo_cliente.cd_unidade_federacao Then
				This.Object.cd_natureza_operacao	[1] = 6102
			Else
				This.Object.cd_natureza_operacao	[1] = 5102
			End If
			
			wf_bloqueio_campo_tipo_nf_sucata()
			
		End If
	Case 'cd_filial_origem'
		wf_busca_parametro_loja()
		
End Choose
end event

event losefocus;call super::losefocus;If IsValid(ivo_cliente) Then
	If ivo_Cliente.id_fisica_juridica = 'J' Then
		This.Object.nm_destinatario		[1] = ivo_Cliente.nm_razao_social
	Else
		This.Object.nm_destinatario		[1] = ivo_Cliente.nm_cliente
	End if
End If

wf_calcula_totais()
end event

event ue_preupdate;call super::ue_preupdate;String lvs_Cliente
String lvs_Especie
String lvs_Serie
String lvs_CFOP
String lvs_Msg
String ls_id_tipo_frete

Long lvl_Filial
Long lvl_Nr_Nf
Long lvl_nr_nsu
Long lvl_CFOP
Long lvl_Msg

This.AcceptText( )

If long(dw_1.Object.id_tipo[1]) = 0 Or Isnull(dw_1.Object.id_tipo[1]) Then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Favor Selecionar o Tipo!')
	dw_1.Event ue_Pos(1, "id_tipo")
	Return -1
End If

lvl_CFOP = dw_1.Object.cd_natureza_operacao[1]

If long(lvl_CFOP) = 0 Or Isnull(lvl_CFOP) Then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Favor Selecionar o CFOP!')
	dw_1.Event ue_Pos(1, "cd_natureza_operacao")
	Return -1
End If

lvl_Filial		= This.Object.cd_filial_origem	[1]
ivo_filial.of_localiza_codigo(lvl_Filial)

If Not ivo_Parametro.of_Proximo_nsu(ref lvl_nr_nsu) Then	Return -1

If lvl_Filial = 2 Then
	If Not ivo_Parametro.of_Especie_NF_Fiscal(ref lvs_Especie) Then Return -1
	If Not ivo_Parametro.of_Serie_NF_Fiscal(ref lvs_Serie) Then Return -1	
	If Not ivo_Parametro.of_Proxima_NF_Fiscal(ref lvl_nr_nf) Then Return -1
Else
	If Not ivo_Parametro.of_Especie_NF(ref lvs_Especie) Then Return -1
	If Not ivo_Parametro.of_Serie_NF(ref lvs_Serie) Then Return -1
	If Not ivo_Parametro.of_Proxima_NF(ref lvl_nr_nf) Then Return -1
End If

If lvl_CFOP = 6102 Then
	lvs_CFOP		= 'VENDA INTERESTADUAL DE SUCATA'
Else
	lvs_CFOP		= 'VENDA ESTADUAL DE SUCATA'
End If

This.Object.nr_nf 							[1] = lvl_nr_nf
This.Object.de_especie					[1] = lvs_Especie
This.Object.de_serie						[1] = lvs_Serie
This.Object.nr_nsu						[1] = lvl_nr_nsu
This.Object.dh_emissao					[1] = gf_getserverdate()
This.Object.dh_movimentacao_caixa	[1] = gvo_parametro.of_dh_movimentacao()
This.Object.nr_matricula_operador	[1] = gvo_aplicacao.ivo_seguranca.nr_matricula
This.Object.cd_natureza_operacao		[1] = lvl_CFOP
This.Object.de_natureza_operacao		[1] = lvs_CFOP

//Insere a mensagem fiscal no primeiro campo dispon$$HEX1$$ed00$$ENDHEX$$vel
If Trim(ivs_Msg) <> '' Then
	lvs_Msg	= This.Object.de_dados_adicionais_1	[1]
	If (IsNull(lvs_Msg)) or (Trim(lvs_Msg)='') Then
		This.Object.de_dados_adicionais_1	[1] = ivs_Msg
	Else
		lvs_Msg	= This.Object.de_dados_adicionais_2	[1]
		If (IsNull(lvs_Msg)) or (Trim(lvs_Msg)='') Then
			This.Object.de_dados_adicionais_2	[1] = ivs_Msg
		Else	
			lvs_Msg	= This.Object.de_dados_adicionais_3	[1]
			If (IsNull(lvs_Msg)) or (Trim(lvs_Msg)='') Then
				This.Object.de_dados_adicionais_3	[1] = ivs_Msg
			Else
				lvs_Msg	= This.Object.de_dados_adicionais_4	[1]
				If (IsNull(lvs_Msg)) or (Trim(lvs_Msg)='') Then
					This.Object.de_dados_adicionais_4	[1] = ivs_Msg
				Else	
					lvs_Msg	= This.Object.de_dados_adicionais_5	[1]
					If (IsNull(lvs_Msg)) or (Trim(lvs_Msg)='') Then
						This.Object.de_dados_adicionais_5	[1] = ivs_Msg
					Else
						lvs_Msg	= This.Object.de_dados_adicionais_6	[1]
						If (IsNull(lvs_Msg)) or (Trim(lvs_Msg)='') Then
							This.Object.de_dados_adicionais_6	[1] = ivs_Msg
						Else	
							lvs_Msg	= This.Object.de_dados_adicionais_7	[1]
							If (IsNull(lvs_Msg)) or (Trim(lvs_Msg)='') Then
								This.Object.de_dados_adicionais_7	[1] = ivs_Msg
							Else
								This.Object.de_dados_adicionais_8	[1] = ivs_Msg
							End If
						End If
					End If
				End If
			End If
		End If
	End If
End If
end event

type tab_1 from tab within w_ge439_nf_venda_diversa
integer x = 18
integer y = 496
integer width = 2523
integer height = 1352
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2487
integer height = 1236
long backcolor = 79741120
string text = "Itens"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
dw_6 dw_6
gb_4 gb_4
gb_6 gb_6
end type

on tabpage_1.create
this.dw_2=create dw_2
this.dw_6=create dw_6
this.gb_4=create gb_4
this.gb_6=create gb_6
this.Control[]={this.dw_2,&
this.dw_6,&
this.gb_4,&
this.gb_6}
end on

on tabpage_1.destroy
destroy(this.dw_2)
destroy(this.dw_6)
destroy(this.gb_4)
destroy(this.gb_6)
end on

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 55
integer y = 76
integer width = 2400
integer height = 652
integer taborder = 20
string dataobject = "dw_ge439_itens"
end type

event losefocus;call super::losefocus;wf_calcula_item_tributacao(This.GetRow())
wf_calcula_totais()

This.ivm_menu.mf_incluir(False)
This.ivm_menu.mf_excluir(False)
end event

event rowfocuschanged;call super::rowfocuschanged;ivm_Menu.mf_Excluir(This.RowCount() > 0)

If CurrentRow > 0 Then
	Parent.Dw_6.ScrollToRow(CurrentRow)
End if
end event

event getfocus;call super::getfocus;This.ivm_menu.mf_incluir(True)
This.ivm_Menu.mf_Excluir(This.RowCount() > 0)

If This.GetRow() > 0 Then
	This.Event ue_Pos(This.GetRow(),'qt_item')
ElseIf (This.RowCount() > 0) Then
	This.Event ue_Pos(1,'qt_item')
End If
end event

event constructor;call super::constructor;ivi_tipo_cancelar = ADDROW

This.ShareData(dw_6)


end event

event itemfocuschanged;call super::itemfocuschanged;wf_calcula_item_tributacao(Row)
wf_calcula_totais()
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha
Long lvl_Filial
Long lvl_Nr_Nf
Long ll_id_tipo_sucata

String lvs_Serie
String lvs_Especie

This.SetRedraw(False)

dw_1.Accepttext( )
lvl_Filial		= dw_1.Object.cd_filial_origem	[1]
lvl_Nr_Nf		= dw_1.Object.nr_nf				[1]
lvs_Serie		= dw_1.Object.de_serie			[1]
lvs_Especie	= dw_1.Object.de_especie		[1]

For lvl_Linha = 1 To This.RowCount() 
	This.Object.cd_filial_origem	[lvl_Linha] = lvl_Filial
	This.Object.nr_nf				[lvl_Linha] = lvl_Nr_Nf
	This.Object.de_especie		[lvl_Linha] = lvs_Especie
	This.Object.de_serie			[lvl_Linha] = lvs_Serie
	This.Object.cd_item			[lvl_Linha] = lvl_Linha
Next

This.SetRedraw( True )

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If This.RowCount() = 0 Then
	This.Event ue_AddRow()
End If

Return AncestorReturnValue
end event

event itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case 'id_tipo_sucata'
		This.AcceptText()
		
		String	ls_UN, &
				ls_prod, &
				ls_erro
		Long	ll_class_fiscal
		
		If wf_busca_produto_sucata( Long(Data), ref ls_prod, ref ls_UN, ref ll_class_fiscal, ref ls_erro ) Then
			This.Object.nr_classificacao_fiscal	[Row] = ll_class_fiscal
			This.Object.de_unidade_medida	[Row] = ls_UN
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_erro)
			Choose Case Long(Data)
				Case 0 //OUTROS
					This.Object.nr_classificacao_fiscal	[Row] = 99999999
					This.Object.de_unidade_medida	[Row] = 'UN'
				Case 1 //PAPELAO
					This.Object.nr_classificacao_fiscal	[Row] = 47079000
					This.Object.de_unidade_medida	[Row] = 'KG'
				Case 2 //PALETE
					This.Object.nr_classificacao_fiscal	[Row] = 44152000
					This.Object.de_unidade_medida	[Row] = 'UN'
				Case 3 //PLASTICO
					This.Object.nr_classificacao_fiscal	[Row] = 39159000
					This.Object.de_unidade_medida	[Row] = 'KG'
				Case 4 //METAL
					This.Object.nr_classificacao_fiscal	[Row] = 74040000
					This.Object.de_unidade_medida	[Row] = 'KG'
				Case 5 //BORRACHA - PNEU
					This.Object.nr_classificacao_fiscal	[Row] = 40040000
					This.Object.de_unidade_medida	[Row] = 'UN'
				Case 6 //CAIXA DE ISOPOR
					This.Object.nr_classificacao_fiscal	[Row] = 39231090
					This.Object.de_unidade_medida	[Row] = 'UN'
				Case 7 //GELO
					This.Object.nr_classificacao_fiscal	[Row] = 39249000
					This.Object.de_unidade_medida	[Row] = 'UN'	
				Case 8 //PAPELAO USADO
					This.Object.nr_classificacao_fiscal	[Row] = 48191000
					This.Object.de_unidade_medida	[Row] = 'UN'	
			End Choose
		End If
		
		If Long(Data) > 0 Then
			This.Object.de_item	[Row] = This.Describe("Evaluate('LookUpDisplay(id_tipo_sucata)',"+String(Row)+")")
			This.Event ue_Pos(Row,'qt_item')
		Else
			This.Object.de_item	[Row] = ''
			This.Event ue_Pos(Row,'de_item')
		End If
		
		//C$$HEX1$$f300$$ENDHEX$$digo de benef$$HEX1$$ed00$$ENDHEX$$cio
		This.Object.cd_beneficio	[Row] = wf_retorna_beneficio(Long(Data), This.Object.cd_cst_tributacao[Row])
				
	Case 'vl_preco_unitario_fiscal'
		wf_calcula_item_tributacao(Row)
		wf_calcula_totais()
		
	Case 'de_item'
		// Se alterou de_item e na dw_6 estiver sem descri$$HEX2$$e700e300$$ENDHEX$$o, atribuir
		If gf_Coalesce(Tab_1.Tabpage_1.dw_6.GetItemString(Tab_1.Tabpage_1.dw_6.getrow(), 'de_item'), '') = '' Then
			Tab_1.Tabpage_1.dw_6.SetItem(Tab_1.Tabpage_1.dw_6.getrow(), 'de_item', Data)
		End If
		
	Case 'cd_beneficio'
		If gf_Coalesce(Tab_1.Tabpage_1.dw_6.GetItemString(Tab_1.Tabpage_1.dw_6.getrow(), 'cd_beneficio'), '') = '' Then
			Tab_1.Tabpage_1.dw_6.SetItem(Tab_1.Tabpage_1.dw_6.getrow(), 'cd_beneficio', Data)
		End If
		
End Choose
end event

event ue_addrow;call super::ue_addrow;This.Object.cd_situacao_tributaria	[This.GetRow()] = '0'+Mid(ivs_CST,2,1)
This.Object.cd_cst_tributacao			[This.GetRow()] = ivs_CST
This.Object.pc_icms						[This.GetRow()] = ivdc_Pc_ICMS
This.Object.id_imposto_tributacao	[This.GetRow()] = ivs_Trib_CBSIBS

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;If Key = KeyEnter! then
	Choose Case This.GetColumnName()
		Case 'de_item'
			This.Event ue_Pos(This.GetRow(),'de_unidade_medida')
		Case 'de_unidade_medida'
			This.Event ue_Pos(This.GetRow(),'qt_item')
		Case 'qt_item'
			This.Event ue_Pos(This.GetRow(),'vl_preco_unitario_fiscal')
		Case 'vl_preco_unitario_fiscal'
			Parent.dw_6.SetFocus()
	End Choose
End If
end event

type dw_6 from dc_uo_dw_base within tabpage_1
integer x = 64
integer y = 828
integer width = 2363
integer height = 352
integer taborder = 20
string dataobject = "dw_ge439_itens_tributacao"
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;If ivb_Fechando Then Return -1

Choose Case Dwo.Name
	Case 'cd_cst_tributacao'
		This.Object.cd_situacao_tributaria [Row] = '0'+Mid(Data,2,1)
		
		Choose Case Data
			Case '40', '50', '60'
				This.Object.pc_icms [Row] = 0.00
		End Choose
		
		This.Event ue_Pos(Row,'pc_icms')
		
	Case 'pc_icms'
		If Long(Data) > 0 Then
			If Not wf_verifica_tipo_tributacao(This.Object.cd_cst_tributacao [Row]) Then
				Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria marcada para n$$HEX1$$e300$$ENDHEX$$o tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS.~n~rVerificar tabela {tributacao_icms}, campo {id_icms_normal}.',Exclamation!)
				Return 1
			Else
				wf_atribui_pecentual_icms_digitado(Dec(Data))
			End If
		End If
	
	Case 'de_item'
		// Se alterou de_item e na dw_2 estiver sem descri$$HEX2$$e700e300$$ENDHEX$$o, atribuir
		If gf_Coalesce(Tab_1.Tabpage_1.dw_2.GetItemString(Tab_1.Tabpage_1.dw_2.getrow(), 'de_item'), '') = '' Then
			Tab_1.Tabpage_1.dw_2.SetItem(Tab_1.Tabpage_1.dw_2.getrow(), 'de_item', Data)
		End If
		
	Case 'cd_beneficio'
		If gf_Coalesce(Tab_1.Tabpage_1.dw_2.GetItemString(Tab_1.Tabpage_1.dw_2.getrow(), 'cd_beneficio'), '') = '' Then
			Tab_1.Tabpage_1.dw_2.SetItem(Tab_1.Tabpage_1.dw_2.getrow(), 'cd_beneficio', Data)
		End If
		
	Case 'id_imposto_tributacao'
		Tab_1.Tabpage_1.dw_2.SetItem(Tab_1.Tabpage_1.dw_2.getrow(), 'id_imposto_tributacao', Data)
		wf_calcula_item_tributacao( Row )
		Post wf_calcula_totais( )
		
End Choose
end event

event losefocus;call super::losefocus;wf_calcula_item_tributacao(Tab_1.TabPage_1.dw_2.GetRow())
end event

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = 'de_item' Then
		Tab_1.SelectedTab = 2
		Tab_1.tabpage_2.dw_3.SetFocus()
	End If
End If
end event

type gb_4 from groupbox within tabpage_1
integer x = 14
integer width = 2446
integer height = 748
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type gb_6 from groupbox within tabpage_1
integer x = 18
integer y = 768
integer width = 2446
integer height = 444
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Inf. Adicionais Item"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2487
integer height = 1236
long backcolor = 79741120
string text = "Resumo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
gb_2 gb_2
gb_3 gb_3
end type

on tabpage_2.create
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.dw_3,&
this.dw_4,&
this.dw_5,&
this.gb_2,&
this.gb_3}
end on

on tabpage_2.destroy
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.gb_2)
destroy(this.gb_3)
end on

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 55
integer y = 68
integer width = 1129
integer height = 268
integer taborder = 20
string dataobject = "dw_ge439_cab_parcela"
end type

event itemfocuschanged;call super::itemfocuschanged;wf_formata_parcelas()
end event

event losefocus;call super::losefocus;wf_formata_parcelas()
end event

event constructor;call super::constructor;ivi_tipo_cancelar = ADDROW
end event

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 64
integer y = 444
integer width = 1125
integer height = 744
integer taborder = 20
string dataobject = "dw_ge439_parcela"
end type

event ue_update;//override
String lvs_Responsavel
String lvs_Nr_Titulo
String lvs_Titulo_Banco
String lvs_Serie
String lvs_Especie
String lvs_Tipo_Titulo
String lvs_Cliente

Long lvl_Tipo_Movimento
Long lvl_Linha
Long lvl_Portador
//Long lvl_Matriz
Long lvl_Filial
Long lvl_Nr_Nf
Long lvl_Convenio

Datetime lvdh_Emissao
Datetime lvdh_Vencto

Decimal{2} lvdc_Valor

Boolean lvb_Sucesso = False   

If This.Event ue_PreUpdate() = -1 Then Return -1

SetNull(lvs_Titulo_Banco)

//lvl_Matriz		= gvo_parametro.cd_filial_matriz
lvdh_Emissao	= gvo_parametro.dh_movimentacao
lvs_Tipo_Titulo	= Parent.dw_3.Object.cd_forma_pagamento [1]
lvl_Filial			= dw_1.Object.cd_filial_origem		[1]
lvl_Nr_Nf			= dw_1.Object.nr_nf					[1]
lvs_Especie		= dw_1.Object.de_especie			[1]
lvs_Serie			= dw_1.Object.de_serie				[1]
lvs_Cliente		= ivo_cliente.cd_cliente

If Not ivo_parametro.of_Localiza_Parametro("CD_PORTADOR_SICREDI", ref lvl_Portador) Then
	Return -1
End If

For lvl_Linha = 1 To This.RowCount()

	lvs_Nr_Titulo	= ivo_Titulo.of_Proximo_Titulo(lvl_Filial)
	lvdh_Vencto		= This.Object.dh_vencimento	[lvl_Linha]
	lvdc_Valor		= This.Object.vl_nominal			[lvl_Linha]
	
	Insert Into titulo_receber (	nr_titulo,   
										cd_filial,   
										id_tipo_titulo,   
										cd_portador,   
										dh_emissao,   
										dh_vencimento,   
										dh_calculo_juros,   
										vl_nominal,   
										vl_juros_recebidos,   
										vl_desconto_concedido,   
										vl_despesas_pagas,   
										vl_despesas_recebidas,   
										vl_recebido,   
										vl_aberto,   
										id_situacao,   
										id_carne_bloqueto,   
										id_protesto,
										nr_titulo_banco,
										cd_cliente,
										cd_filial_nf,
										nr_nf,
										de_especie,
										de_serie)
	Values (:lvs_Nr_Titulo,   
			  :lvl_Filial,   
			  :lvs_Tipo_Titulo,   
			  :lvl_Portador,   
			  :lvdh_Emissao,   
			  :lvdh_Vencto,   
			  :lvdh_Vencto,   
			  :lvdc_Valor,   
			  0,   
			  0,   
			  0,   
			  0,   
			  0,   
			  :lvdc_Valor,   
			  'A',   
			  'B',   
			  'N',
			  :lvs_Titulo_Banco,
			  :lvs_Cliente,
			  :lvl_Filial,
			  :lvl_Nr_NF,
			  :lvs_Especie,
			  :lvs_Serie)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do T$$HEX1$$ed00$$ENDHEX$$tulo")
		Return -1
	Else
		lvs_Responsavel = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		
		lvl_Tipo_Movimento = ivo_Titulo.of_Movto_Abertura()
		
		Insert Into movimento_titulo_receber (nr_titulo,   
														  nr_movimento,
														  cd_tipo_movimento,   
														  nr_matricula_responsavel,   
														  dh_sistema,					
														  dh_movimento,   
														  dh_credito,
														  vl_movimento,   
														  vl_juros_recebidos,   
														  vl_desconto_concedido,   
														  vl_despesas_recebidas, 
														  id_estorno,   
														  de_historico,   					
														  nr_recibo_cobranca,
														  cd_filial_movimento)
		Values (:lvs_Nr_Titulo, 
				  1,
				  :lvl_Tipo_Movimento,
				  :lvs_Responsavel,
				  getdate(),   
				  :lvdh_Emissao,   
				  :lvdh_Emissao,   				
				  :lvdc_Valor,
				  0,   
				  0,   
				  0,
				  'N',   
				  Null,   
				  Null,
				  :lvl_Filial)
		Using SqlCa;	
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Abertura")
			Return -1
		End If	
		
		//Movimento inserido pela trigger
		//If Not wf_Inclui_Movimento_Conta(lvs_Cliente, lvs_Tipo_Titulo, lvs_Nr_Titulo, lvl_Filial, lvdc_Valor, Date(lvdh_Emissao)) Then Return -1
	End If
Next

Return 1

end event

event losefocus;call super::losefocus;ivm_menu.mf_incluir(False)
ivm_menu.mf_excluir(False)
end event

event getfocus;call super::getfocus;ivm_menu.mf_incluir(True)
ivm_menu.mf_excluir(True)
end event

event constructor;call super::constructor;ivi_tipo_cancelar = RESET
end event

type dw_5 from dc_uo_dw_base within tabpage_2
integer x = 1248
integer y = 4
integer width = 1221
integer height = 1248
integer taborder = 20
string dataobject = "dw_ge439_dados_adicionais"
end type

type gb_2 from groupbox within tabpage_2
integer x = 18
integer y = 384
integer width = 1207
integer height = 836
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Parcelas"
end type

type gb_3 from groupbox within tabpage_2
integer x = 18
integer width = 1207
integer height = 376
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Financeiro"
end type

type gb_1 from groupbox within w_ge439_nf_venda_diversa
integer x = 32
integer y = 16
integer width = 2496
integer height = 452
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "NFe Venda"
end type

