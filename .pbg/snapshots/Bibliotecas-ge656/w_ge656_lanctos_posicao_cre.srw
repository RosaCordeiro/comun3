HA$PBExportHeader$w_ge656_lanctos_posicao_cre.srw
forward
global type w_ge656_lanctos_posicao_cre from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge656_lanctos_posicao_cre from dc_w_selecao_lista_relatorio
integer width = 4311
integer height = 2316
string title = "GE656 - Relat$$HEX1$$f300$$ENDHEX$$rio de Lan$$HEX1$$e700$$ENDHEX$$amentos Posi$$HEX2$$e700e300$$ENDHEX$$o CRE"
end type
global w_ge656_lanctos_posicao_cre w_ge656_lanctos_posicao_cre

type variables
date	ivdt_fechamento		, &
		ivdt_movimentacao
		
Private:
uo_convenio 	ivo_convenio
uo_cliente 		ivo_cliente
uo_fornecedor 	ivo_fornecedor
end variables

forward prototypes
public subroutine wf_atualiza_saldo_patrimonio ()
public function boolean wf_verifica_datas ()
end prototypes

public subroutine wf_atualiza_saldo_patrimonio ();String lvs_Crediario
String lvs_Patrimonio
String lvs_Cd_Cliente_SAP
String lvs_Cd_Cliente
String lvs_Nm_Cliente
String lvs_Parametro
String lvs_Docto

Long lvl_Linha
Long lvl_Linhas
Long lvl_Find

Decimal{2} lvdc_Valor
Decimal{2} lvdc_Aux

Date 	lvdt_Inicio, &
		lvdt_Termino, &
		lvdt_Movimento
		
DateTime lvdth_Emissao		

Try
	dw_1.Accepttext( )
	lvdt_Inicio		= dw_1.Object.dt_posicao_ini	[1]
	lvdt_Termino	= dw_1.Object.dt_posicao_fim	[1]
	lvs_Crediario	= dw_1.Object.id_cr 		[1]
	lvs_Patrimonio	= dw_1.Object.id_pt 		[1]
	
	If lvdt_Termino > ivdt_movimentacao Then lvdt_Termino = ivdt_movimentacao
	
	Open(w_Aguarde)
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	
	w_Aguarde.Title = "Deduzindo os saldos referentes a vendas patrimoniais..."
	
	If Not lvds_1.of_ChangeDataObject("ds_ge656_posicao_patrimonio") Then Return
	
	lvl_Linhas = lvds_1.Retrieve(lvdt_Inicio, lvdt_Termino)
	
	For lvl_Linha = 1 To lvl_Linhas
		lvs_Cd_Cliente			= lvds_1.Object.cd_cliente		[lvl_Linha]
		lvs_Cd_Cliente_SAP	= lvds_1.Object.cd_cliente_sap	[lvl_Linha]
		lvs_Nm_Cliente			= lvds_1.Object.nm_cliente		[lvl_Linha]
		lvs_Docto				= lvds_1.Object.nr_docto		[lvl_Linha]
		lvdt_Movimento			= Date(lvds_1.Object.dh_emissao[lvl_Linha])
		lvdth_Emissao			= lvds_1.Object.dh_emissao	[lvl_Linha]
		lvdc_Valor				= lvds_1.Object.vl_total			[lvl_Linha]
		
		lvs_Parametro = String(lvdt_Movimento, "yyyy/mm/dd")
	
		//Reduzir as vendas credi$$HEX1$$e100$$ENDHEX$$rio
		If lvs_Crediario = "S" Then
			lvl_Find = dw_2.Find("id_tipo_conta = 'CR' and dh_movimento =  DateTime('" + lvs_Parametro + "')"  + "and cd_conta='"+lvs_Cd_Cliente+"'", 1, dw_2.RowCount())
			
			If lvl_Find > 0 Then
				lvdc_Aux 				= dw_2.Object.vl_movimento			[lvl_Find]
				
				If lvdc_Aux - lvdc_Valor = 0.00 Then 
					dw_2.DeleteRow( lvl_Find )
				Else
					dw_2.Object.vl_movimento	[lvl_Find] = lvdc_Aux - lvdc_Valor
				End If
			End If
		End If
		
		//Adicionar as vendas patrim$$HEX1$$f400$$ENDHEX$$nio
		If lvs_Patrimonio = "S" Then 
			lvl_Find = dw_2.InsertRow(0)
			
			dw_2.Object.id_tipo_conta				[lvl_Find] = "PT"			
			dw_2.Object.cd_conta					[lvl_Find] = lvs_Cd_Cliente
			dw_2.Object.cd_cliente_sap				[lvl_Find] = lvs_Cd_Cliente_SAP
			dw_2.Object.nm_cliente					[lvl_Find] = lvs_Nm_Cliente
			dw_2.Object.de_tipo_movimento		[lvl_Find] = 'VENDA CREDI$$HEX1$$c100$$ENDHEX$$RIO'
			dw_2.Object.nr_documento				[lvl_Find] = lvs_Docto
			dw_2.Object.vl_movimento				[lvl_Find] = lvdc_Valor
			dw_2.Object.dh_movimento				[lvl_Find] = lvdt_Movimento
			dw_2.Object.dh_sistema					[lvl_Find] = lvdth_Emissao
			dw_2.Object.id_credito_debito			[lvl_Find] = 'D' // D$$HEX1$$e900$$ENDHEX$$bito
			dw_2.Object.id_atualizacao_saldo		[lvl_Find] = '2' // Atualiza T$$HEX1$$ed00$$ENDHEX$$tulo			
			
		End If	
	Next
Finally
	If IsValid(lvds_1) Then Destroy(lvds_1)
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
End Try
end subroutine

public function boolean wf_verifica_datas ();Boolean lvb_Sucesso

DateTime lvdh_Movto, &
         lvdh_Fechamento

Select 	dh_movimentacao,
       		dh_fechamento_contas_receber 
Into 	:lvdh_Movto,
    	 	:lvdh_Fechamento
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ivdt_Fechamento   	= Date(lvdh_Fechamento)
		ivdt_Movimentacao 	= Date(lvdh_Movto)
		
		dw_1.Object.dt_posicao_fim[1] = ivdt_Movimentacao
		
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Data de fechamento n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Fechamento")
End Choose

Return lvb_Sucesso
end function

on w_ge656_lanctos_posicao_cre.create
call super::create
end on

on w_ge656_lanctos_posicao_cre.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;Maxwidth = 8316
Maxheight = 9999

ivo_convenio	= Create uo_convenio
ivo_cliente 		= Create uo_cliente
ivo_fornecedor	= Create uo_fornecedor
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_posicao_ini	[1] = gf_primeiro_dia_mes(RelativeDate(gf_primeiro_dia_mes(Today()),-1))
dw_1.Object.dt_posicao_fim[1] = RelativeDate(gf_primeiro_dia_mes(Today()),-1)
//dw_1.Object.dh_lancto_ini	[1] = gf_primeiro_dia_mes(Today())
//dw_1.Object.dh_lancto_fim	[1] = Datetime(Today(),Now())

If Not wf_Verifica_Datas() Then
	Close(This)
End If
end event

event close;call super::close;Destroy( ivo_cliente )
Destroy( ivo_convenio	 )
Destroy( ivo_fornecedor )
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge656_lanctos_posicao_cre
integer x = 219
integer y = 2236
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge656_lanctos_posicao_cre
integer x = 183
integer y = 2164
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge656_lanctos_posicao_cre
integer y = 744
integer width = 4210
integer height = 1372
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge656_lanctos_posicao_cre
integer width = 4206
integer height = 768
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge656_lanctos_posicao_cre
integer x = 69
integer width = 4142
integer height = 668
string dataobject = "dw_ge656_selecao"
end type

event dw_1::ue_key;call super::ue_key;Boolean	lvb_Selecionado = False

String		lvs_Coluna, &
			lvs_Conta

lvs_Coluna = This.GetColumnName()

lvs_Conta = This.GetText()

If ( lvs_Coluna = "ds_conta" ) Then 
	
	If ( key = KeyEnter! ) Then
		
		// CV
		If This.Object.Id_CV[1] = 'S' Then		
			If Not IsNull(lvs_Conta) and TRIM(lvs_Conta) <> "" Then 
			
				ivo_Convenio.Of_Localiza_Convenio(lvs_Conta)
				
				If ( ivo_Convenio.Localizado ) Then
					This.Object.Cd_Conta	[1] = String(ivo_Convenio.Cd_Convenio)
					This.Object.Ds_Conta	[1] = ivo_Convenio.Nm_Fantasia
				End If
			End If
					
			lvb_Selecionado = True
		End If
		
		// CC
		If This.Object.Id_CC[1] = 'S' and Not lvb_Selecionado Then
			ivo_Cliente.ivs_Tipo_Cliente = "CC"
			
			ivo_Cliente.of_Localiza_CLiente(lvs_Conta)
			
			If ivo_Cliente.Localizado Then			
				dw_1.Object.Cd_Conta	[1] = ivo_Cliente.Cd_Cliente
				dw_1.Object.Ds_Conta	[1] = ivo_Cliente.Nm_Cliente	
			End If

			lvb_Selecionado = True					
		End If			
		
		// CR
		If This.Object.Id_CR[1] = 'S' and Not lvb_Selecionado Then
			ivo_Cliente.ivs_Tipo_Cliente = "CR"
			
			ivo_Cliente.of_Localiza_Cliente(lvs_Conta)
			
			If ivo_Cliente.Localizado Then			
				dw_1.Object.Cd_Conta	[1] = ivo_Cliente.Cd_Cliente
				dw_1.Object.Ds_Conta	[1] = ivo_Cliente.Nm_Cliente	
			End If
			
			lvb_Selecionado = True					
		End If			
		
		// FO
		If This.Object.Id_FO[1] = 'S' and Not lvb_Selecionado Then
			ivo_Fornecedor.of_Localiza_Fornecedor(lvs_Conta)
			
			If ivo_Fornecedor.Localizado Then
				dw_1.Object.Cd_Conta	[1] = ivo_Fornecedor.Cd_Fornecedor
				dw_1.Object.Ds_Conta	[1] = ivo_Fornecedor.Nm_Razao_Social
			End If			
			
			lvb_Selecionado = True
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
		
	Case "ds_conta"
		If IsNull(Data) or Trim(Data) = "" Then		
			ivo_convenio.of_inicializa( )
			ivo_cliente.of_inicializa( )
			ivo_fornecedor.of_inicializa( )
			
			This.Object.ds_conta	[1] = ""
			This.Object.cd_conta	[1] = ""
			
		End If	
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge656_lanctos_posicao_cre
integer y = 820
integer width = 4142
integer height = 1264
string dataobject = "dw_ge656_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String 	lvs_CV, &
       		lvs_CC, &
		 	lvs_CR, &
		 	lvs_FO, &
		 	lvs_LP, &
		 	lvs_PT, &
		 	lvs_VB, &
		 	lvs_Filtro, &
		 	lvs_Tipo_Movto, &
			lvs_Cd_Conta, &
			lvs_Considera_PBM

String 	lvs_tp_venda			, &
       		lvs_tp_canc_venda		, &
		 	lvs_tp_tx_entr			, &
		 	lvs_tp_canc_tx_entr	, &
		 	lvs_tp_alt_venda_cre	, &
			lvs_tp_alt_venda_deb	, &
		 	lvs_tp_alt_tx_cre		, &
		 	lvs_tp_alt_tx_deb		, &
			lvs_tp_fec_venda		, &
			lvs_tp_est_fec_venda	, &
			lvs_tp_abert_titulo		, &
			lvs_tp_est_abert_titulo, &
			lvs_tp_pag_titulo		, &
			lvs_tp_est_pag_titulo	, &
			lvs_tp_out_cre			, &
			lvs_tp_out_deb			, &
			lvs_tp_luc_perd_cre	, &
			lvs_tp_luc_perd_deb	, &
			lvs_vd_pago_avista	, &
			lvs_Id_Considera_Conv_DV


Date lvdt_Posicao_ini
Date lvdt_Posicao_Fim
Datetime lvdh_Sistema_Ini
Datetime lvdh_Sistema_Fim

Boolean lvb_Ok = False

dw_1.AcceptText()

lvdt_Posicao_ini			= dw_1.Object.dt_posicao_ini			[1]
lvdt_Posicao_Fim			= dw_1.Object.dt_posicao_fim			[1]
lvdh_Sistema_Ini			= dw_1.Object.dh_lancto_ini			[1]
lvdh_Sistema_Fim			= dw_1.Object.dh_lancto_fim			[1]
lvs_CV     		 			= dw_1.Object.Id_CV   				 	[1]
lvs_CC      				= dw_1.Object.Id_CC   				 	[1]
lvs_CR      				= dw_1.Object.Id_CR    					[1]
lvs_FO      				= dw_1.Object.Id_FO    					[1]
lvs_LP      				= dw_1.Object.Id_LP    					[1]
lvs_PT      				= dw_1.Object.Id_PT    					[1]
lvs_VB      				= dw_1.Object.Id_VB    					[1]
lvs_Cd_Conta				= dw_1.Object.Cd_Conta					[1]
lvs_Considera_PBM			= dw_1.Object.id_considerar_pbm		[1]
lvs_Tipo_Movto				= dw_1.Object.id_tipo_movto			[1]
lvs_tp_venda				= dw_1.Object.id_tp_venda				[1]
lvs_tp_canc_venda			= dw_1.Object.id_tp_canc_venda		[1]
lvs_tp_tx_entr				= dw_1.Object.id_tp_tx_entr			[1]
lvs_tp_canc_tx_entr		= dw_1.Object.id_tp_canc_tx_entr		[1]
lvs_tp_alt_venda_cre		= dw_1.Object.id_tp_alt_venda_cre	[1]
lvs_tp_alt_venda_deb		= dw_1.Object.id_tp_alt_venda_deb	[1]
lvs_tp_alt_tx_cre			= dw_1.Object.id_tp_alt_tx_cre		[1]
lvs_tp_alt_tx_deb			= dw_1.Object.id_tp_alt_tx_deb		[1]
lvs_tp_fec_venda			= dw_1.Object.id_tp_fec_venda		[1]
lvs_tp_est_fec_venda		= dw_1.Object.id_tp_est_fec_venda	[1]
lvs_tp_abert_titulo			= dw_1.Object.id_tp_abert_titulo		[1]
lvs_tp_est_abert_titulo	= dw_1.Object.id_tp_est_abert_titulo	[1]
lvs_tp_pag_titulo			= dw_1.Object.id_tp_pag_titulo		[1]
lvs_tp_est_pag_titulo		= dw_1.Object.id_tp_est_pag_titulo	[1]
lvs_tp_out_cre				= dw_1.Object.id_tp_out_cre			[1]
lvs_tp_out_deb				= dw_1.Object.id_tp_out_deb			[1]
lvs_tp_luc_perd_cre		= dw_1.Object.id_tp_luc_perd_cre	[1]
lvs_tp_luc_perd_deb		= dw_1.Object.id_tp_luc_perd_deb	[1]
lvs_vd_pago_avista		= dw_1.Object.id_vd_pago_avista		[1]
lvs_Id_Considera_Conv_DV	= dw_1.Object.id_conv_devolucao	[1]

If IsNull(lvdt_Posicao_ini) or Not IsDate(String(lvdt_Posicao_ini, "dd/mm/yyyy")) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data in$$HEX1$$ed00$$ENDHEX$$cio da movimenta$$HEX2$$e700e300$$ENDHEX$$o corretamente.", Exclamation!, YesNo!, 2) = 2 Then
		dw_1.Event ue_Pos(1, "dt_posicao_ini")
		Return -1
	End If
Else
	lvb_Ok = True
	This.Of_AppendWhere("m.dh_movimento >= '"+String(lvdt_Posicao_ini,"YYYY.MM.DD")+"'")
End If

If IsNull(lvdt_Posicao_fim) or Not IsDate(String(lvdt_Posicao_fim, "dd/mm/yyyy")) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Data t$$HEX1$$e900$$ENDHEX$$rmino da movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o informada corretamente.~r~rDeseja continuar?", Exclamation!, YesNo!, 2) = 2 Then
		dw_1.Event ue_Pos(1, "dt_posicao_fim")
		Return -1
	End If
Else
	This.Of_AppendWhere("m.dh_movimento <= '"+String(lvdt_Posicao_fim,"YYYY.MM.DD")+"'")
End If

If IsNull(lvdh_Sistema_Ini) or Not IsDate(String(lvdh_Sistema_Ini, "dd/mm/yyyy")) Then
	If Not lvb_Ok Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Data de in$$HEX1$$ed00$$ENDHEX$$cio dos lan$$HEX1$$e700$$ENDHEX$$amentos n$$HEX1$$e300$$ENDHEX$$o informada corretamente.~r~rDeseja continuar?", Exclamation!, YesNo!, 2) = 2 Then
			dw_1.Event ue_Pos(1, "dh_lancto_ini")
			Return -1
		End If
	End If
Else
	This.Of_AppendWhere("m.dh_sistema >= '"+String(lvdh_Sistema_Ini,"YYYY.MM.DD HH:MM")+"'")
End If

If IsNull(lvdh_Sistema_Fim) or Not IsDate(String(lvdh_Sistema_Fim, "dd/mm/yyyy"))  Then
	If Not lvb_Ok Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Data de t$$HEX1$$e900$$ENDHEX$$rmino dos lan$$HEX1$$e700$$ENDHEX$$amentos n$$HEX1$$e300$$ENDHEX$$o informada corretamente.", Exclamation!, YesNo!, 2) = 2 Then
			dw_1.Event ue_Pos(1, "dh_lancto_fim")
			Return -1
		End If
	End If
Else
	This.Of_AppendWhere("m.dh_sistema <= '"+String(lvdh_Sistema_Fim,"YYYY.MM.DD HH:MM")+"'")
End If

If lvs_CV = "N" and lvs_CC = "N" and lvs_VB = "N" and lvs_CR = "N" and lvs_FO = "N" and lvs_LP = "N" and lvs_PT = "N" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione pelo menos um tipo de conta.", Exclamation!)
	dw_1.Event ue_Pos(1, "id_cv")
	Return -1
End If

lvs_Filtro = ""
If lvs_CV = "S" Then lvs_Filtro += IIF(lvs_Filtro <> "", ",", "")+"'CV'"
If lvs_CC = "S" Then lvs_Filtro += IIF(lvs_Filtro <> "", ",", "")+"'CC'"
If lvs_FO = "S" Then lvs_Filtro += IIF(lvs_Filtro <> "", ",", "")+"'FO'"
If lvs_LP = "S" Then lvs_Filtro += IIF(lvs_Filtro <> "", ",", "")+"'LP'"
If lvs_CR = "S" or lvs_PT = "S" or lvs_VB = "S" Then lvs_Filtro += IIF(lvs_Filtro <> "", ",", "")+"'CR'"

If lvs_Filtro <> "" Then
	This.Of_AppendWhere("m.id_tipo_conta in ("+lvs_Filtro+")")
End If

If lvs_PT = "S" Then
	If lvs_CR = "N" Then
		If lvs_VB = "N" Then
			This.Of_AppendWhere("((m.id_tipo_conta = 'CR' and (nd.nr_nf is not null or j_1bnfdoc.nr_nf is not null)) or (m.id_tipo_conta <>'CR'))")
		Else
			This.Of_AppendWhere("((m.id_tipo_conta = 'CR' and (nd.nr_nf is not null or j_1bnfdoc.nr_nf is not null or t.nr_conta_sap='0011201067' or m.id_tipo_lancto='1')) or (m.id_tipo_conta <>'CR'))")			
		End If
	End If
ElseIf Pos(lvs_Filtro, 'CR') > 0 Then
	This.Of_AppendWhere("(nd.nr_nf is null and j_1bnfdoc.nr_nf is null)")
End If

//Trazer movimentos de verba
If lvs_VB = "S" Then
	If lvs_CR = "N" Then
		If lvs_PT = "N" Then
			This.Of_AppendWhere("(m.id_tipo_conta <> 'CR' or (m.id_tipo_conta = 'CR' and (t.nr_conta_sap='0011201067' or m.id_tipo_lancto='1')))")		
		Else
			This.Of_AppendWhere("((m.id_tipo_conta = 'CR' and (nd.nr_nf is not null or j_1bnfdoc.nr_nf is not null or t.nr_conta_sap='0011201067' or m.id_tipo_lancto='1')) or (m.id_tipo_conta <>'CR'))")			
		End If
	End If
//Se tiver algum outro tipo de CR (CR=Credi$$HEX1$$e100$$ENDHEX$$rio ou PT=Patrim$$HEX1$$f400$$ENDHEX$$nio)
ElseIf Pos(lvs_Filtro, 'CR') > 0 Then
	This.Of_AppendWhere("coalesce(t.nr_conta_sap,'')<>'0011201067' and coalesce(m.id_tipo_lancto,'')<>'1'")			
End If

If Not IsNull(lvs_Cd_Conta) and lvs_Cd_Conta <> '' Then
	This.of_AppendWhere("m.cd_conta='" + lvs_Cd_Conta + "'")
End If

If lvs_Considera_PBM = "N" Then
	If lvs_CV = "S" Then	
		This.of_AppendWhere("m.cd_conta not in ('52575', '53724', '53725', '52349' ,'52718','53847')")
	End If
End If

If lvs_Tipo_Movto <> "T" Then
	This.Of_AppendWhere("tm.id_atualizacao_saldo = '"+lvs_Tipo_Movto+"'")	
End If

/*Filtro tipos de movimento */
If lvs_tp_venda = "N" Then
	This.of_AppendWhere("tm.id_venda='N'")
End If 

If lvs_tp_canc_venda = "N" Then
	This.of_AppendWhere("tm.id_cancelamento_venda='N'")
End If 

If lvs_tp_tx_entr = "N" Then
	This.of_AppendWhere("tm.id_taxa_entrega='N'")
End If 

If lvs_tp_canc_tx_entr = "N" Then
	This.of_AppendWhere("tm.id_cancelamento_taxa_entrega='N'")
End If 

If lvs_tp_alt_venda_cre = "N" Then
	This.of_AppendWhere("tm.id_alteracao_venda_credito='N'")
End If 

If lvs_tp_alt_venda_deb = "N" Then
	This.of_AppendWhere("tm.id_alteracao_venda_debito='N'")
End If 

If lvs_tp_alt_tx_cre = "N" Then
	This.of_AppendWhere("tm.id_alteracao_taxa_credito='N'")
End If 

If lvs_tp_alt_tx_deb = "N" Then
	This.of_AppendWhere("tm.id_alteracao_taxa_debito='N'")
End If 

If lvs_tp_fec_venda = "N" Then
	This.of_AppendWhere("tm.id_fechamento_vendas='N'")
End If 

If lvs_tp_est_fec_venda = "N" Then
	This.of_AppendWhere("tm.id_estorno_fechamento_vendas='N'")
End If 

If lvs_tp_abert_titulo = "N" Then
	This.of_AppendWhere("tm.id_abertura_titulo='N'")
End If 

If lvs_tp_est_abert_titulo = "N" Then
	This.of_AppendWhere("tm.id_estorno_abertura_titulo='N'")
End If 

If lvs_tp_pag_titulo = "N" Then
	This.of_AppendWhere("tm.id_pagamento_titulo='N'")
End If 

If lvs_tp_est_pag_titulo = "N" Then
	This.of_AppendWhere("tm.id_estorno_pagamento_titulo='N'")
End If 

If lvs_tp_out_cre = "N" Then
	This.of_AppendWhere("tm.id_outro_credito='N'")
End If 

If lvs_tp_out_deb = "N" Then
	This.of_AppendWhere("tm.id_outro_debito='N'")
End If 

If lvs_tp_luc_perd_cre = "N" Then
	This.of_AppendWhere("tm.id_lucro_perda_credito='N'")
End If 

If lvs_tp_luc_perd_deb = "N" Then
	This.of_AppendWhere("tm.id_lucro_perda_debito='N'")
End If 

If lvs_vd_pago_avista = "N" Then
	This.of_AppendWhere( "not exists (select 1 "													+ &
												"from titulo_receber t1 (index pk_titulo_receber) "	+ &
												"inner join nf_venda nv1 (index pk_nf_venda) "		+ &
												"	on nv1.cd_filial = t1.cd_filial_nf "					+ &
												"	and nv1.nr_nf = t1.nr_nf "							+ &
												"	and nv1.de_serie = t1.de_serie "					+ &
												"	and nv1.de_especie = t1.de_especie "			+ &
												"	and ((nv1.id_tipo_venda = 'CV') or (nv1.vl_pago_avista = t1.vl_nominal)) "		+ &
												"where t1.nr_titulo = substring(m.nr_documento,1,4)||substring(m.nr_documento,6,7)||substring(m.nr_documento,14,2))")
End If

If lvs_Id_Considera_Conv_DV = 'N' Then
	This.of_AppendWhere("m.cd_conta not in ('51014', '52602', '53847')")
End if

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_menu.mf_salvarcomo( pl_linhas > 0 )

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
Long lvl_Linhas
String lvs_Oculta_Zerados

This.SetRedraw(False)

lvl_Linhas = This.Retrieve()

//wf_atualiza_saldo_patrimonio( )

This.Sort()
This.GroupCalc()
This.SetRedraw(True)	

Return This.RowCount()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge656_lanctos_posicao_cre
integer x = 3141
integer y = 68
integer width = 320
integer height = 156
end type

