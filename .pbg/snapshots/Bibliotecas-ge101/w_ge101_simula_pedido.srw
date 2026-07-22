HA$PBExportHeader$w_ge101_simula_pedido.srw
forward
global type w_ge101_simula_pedido from dc_w_response
end type
type cb_cancelar from commandbutton within w_ge101_simula_pedido
end type
type cb_confirmar from commandbutton within w_ge101_simula_pedido
end type
type dw_1 from dc_uo_dw_base within w_ge101_simula_pedido
end type
type gb_1 from groupbox within w_ge101_simula_pedido
end type
end forward

global type w_ge101_simula_pedido from dc_w_response
string tag = "w_ge101_simula_pedido"
integer width = 3186
integer height = 2344
string title = "GE101 - Simula$$HEX2$$e700e300$$ENDHEX$$o de Compra"
boolean controlmenu = false
cb_cancelar cb_cancelar
cb_confirmar cb_confirmar
dw_1 dw_1
gb_1 gb_1
end type
global w_ge101_simula_pedido w_ge101_simula_pedido

type variables
uo_simula_pedido ivo_simula    //GE222
uo_produto ivo_produto


end variables

forward prototypes
public subroutine wf_carrega_informacoes ()
public subroutine wf_confirma_simulacao ()
public subroutine wf_valores_impostos ()
public subroutine wf_mostra_valores ()
end prototypes

public subroutine wf_carrega_informacoes ();Decimal ldc_bc_pis_cofins

dw_1.Object.pc_tx_adm_logistica			[1] = ivo_Simula.pc_tx_adm_logistica
dw_1.Object.cd_produto						[1] = ivo_Simula.cd_Produto
dw_1.Object.de_produto						[1] = ivo_Simula.de_Produto
dw_1.Object.vl_preco_unitario				[1] = ivo_Simula.vl_Preco_Unitario
dw_1.Object.pc_desconto						[1] = ivo_Simula.pc_Desconto
dw_1.Object.pc_desconto_pedido			[1] = ivo_Simula.pc_Desconto_pedido
dw_1.Object.vl_icms_st						[1] = ivo_Simula.vl_icms_st
dw_1.Object.vl_repasse						[1] = ivo_Simula.vl_repasse
dw_1.Object.cd_grupo							[1] = ivo_Simula.cd_grupo
dw_1.Object.id_icms_normal					[1] = ivo_Simula.id_icms_normal
dw_1.Object.pc_icms							[1] = ivo_Simula.pc_icms
dw_1.Object.vl_preco_final_fab			[1] = ivo_Simula.vl_preco_final_fab
dw_1.Object.cd_distribuidora				[1] = ivo_Simula.cd_distribuidora
dw_1.Object.nm_razao_distribuidora		[1] = ivo_Simula.nm_razao_distribuidora
dw_1.Object.vl_preco_dist					[1] = ivo_Simula.vl_preco_dist
dw_1.Object.pc_midia_calculada			[1] = ivo_Simula.pc_midia_calculada
dw_1.Object.pc_juros							[1] = ivo_Simula.pc_juros
dw_1.Object.qt_embalagem_padrao_distrib [1] = ivo_Simula.qt_embalagem_padrao_distrib
dw_1.Object.pc_desc_dist					[1] = ivo_Simula.pc_desc_dist
dw_1.Object.pc_promocao_desconto_finan	[1] = ivo_Simula.pc_promocao_desconto_finan
if isnull(dw_1.Object.pc_promocao_desconto_finan[1]) then dw_1.Object.pc_promocao_desconto_finan[1] = 0
dw_1.Object.vl_repasse_dist				[1] = ivo_Simula.vl_repasse_dist
dw_1.Object.vl_icms_st_dist				[1] = ivo_Simula.vl_icms_st_dist
dw_1.Object.vl_preco_compra_dist			[1] = ivo_Simula.vl_preco_compra_dist
dw_1.Object.vl_ipi							[1] = ivo_Simula.vl_ipi
dw_1.Object.vl_juros_decrescimo			[1] = ivo_Simula.vl_juros_decrescimo
dw_1.Object.vl_juros_decrescimo_dist	[1] = ivo_Simula.vl_juros_decrescimo_dist
dw_1.Object.vl_acrescimo_logistica		[1] = ivo_Simula.vl_acrescimo_logistica
dw_1.Object.pc_red_icms_calc				[1] = ivo_Simula.pc_reducao_base_icms
dw_1.Object.pc_repasse_icms_dist			[1] = ivo_Simula.pc_repasse_icms_dist
//dw_1.Object.vl_juros						[1] = ivo_Simula.vl_juros



dw_1.Object.pc_reducao_icms_dist			[1] = ivo_Simula.pc_reducao_icms_dist
dw_1.Object.pc_icms_dist					[1] = ivo_Simula.pc_icms_dist

dw_1.Object.pc_desc_finan_dist			[1] = ivo_Simula.pc_desc_finan_dist

//base icms distribuidora
dw_1.Object.vl_bc_icms_dist				[1] = round((((ivo_Simula.vl_preco_dist) * ((100 -  ivo_Simula.pc_desc_dist ) / 100)) - ivo_Simula.vl_repasse_dist) * (( 100 - ivo_Simula.pc_reducao_icms_dist ) / 100 ), 2)

//icms distribuidora
dw_1.Object.vl_icms_dist					[1] = round(round((((ivo_Simula.vl_preco_dist) * ((100 -  ivo_Simula.pc_desc_dist ) / 100)) - ivo_Simula.vl_repasse_dist) * (( 100 - ivo_Simula.pc_reducao_icms_dist ) / 100 ), 2) * ((ivo_Simula.pc_icms_dist) / 100), 2)

If dw_1.Object.pc_red_icms_calc[1]  > 0 Then
	dw_1.Object.vl_bc_icms_calc[1] = round((ivo_Simula.vl_bc_icms / (100 - dw_1.Object.pc_red_icms_calc[1])) * 100 , 2)
Else
	dw_1.Object.vl_bc_icms_calc[1] = ivo_Simula.vl_bc_icms
End If

dw_1.Object.pc_icms_calc					[1] = ivo_Simula.pc_icms_compra
dw_1.Object.vl_icms_calc					[1] = ivo_Simula.vl_icms

dw_1.Object.pc_mva_calc						[1] = ivo_Simula.vl_mva
dw_1.Object.pc_reducao_base_st_calc		[1] = ivo_Simula.pc_Reducao_Base_ST
dw_1.Object.pc_icms_st_calc				[1] = ivo_Simula.pc_icms_venda
dw_1.Object.vl_icms_st_calc				[1] = ivo_Simula.vl_icms_st
dw_1.Object.pc_ipi							[1] = ivo_Simula.pc_ipi

dw_1.Object.vl_bc_icms_st_calc			[1] = ivo_Simula.vl_bc_icms_st

If ivo_Simula.vl_pmc > 0 Then
	dw_1.Object.vl_bc_icms_st_calc[1] = ivo_Simula.vl_pmc
End If

dw_1.Object.pc_repasse_icms_calc[1] = ivo_Simula.pc_repasse

//////Aqui ser$$HEX1$$e100$$ENDHEX$$ o c$$HEX1$$e100$$ENDHEX$$lculo

ivo_simula.of_calculo_melhor_compra()

dw_1.Object.vl_preco_compra_dist	[1] = ivo_Simula.vl_preco_compra_calculado

dw_1.Object.pc_pis						[1] = ivo_Simula.pc_pis
dw_1.Object.pc_cofins					[1] = ivo_Simula.pc_cofins
dw_1.Object.vl_pis_distribuidora		[1] = ivo_Simula.vl_pis_distribuidora
dw_1.Object.vl_cofins_distribuidora	[1] = ivo_Simula.vl_cofins_distribuidora
dw_1.Object.vl_juros						[1] = ivo_Simula.vl_juros
//If ivo_Simula.ib_parametro_pis_cofins Then
//	dw_1.Object.pc_pis		[1] = ivo_Simula.pc_pis
//	dw_1.Object.pc_cofins	[1] = ivo_Simula.pc_cofins
//	
//	ldc_bc_pis_cofins = round(((ivo_Simula.vl_preco_dist) * ((100 -  ivo_Simula.pc_desc_dist ) / 100)) - ivo_Simula.vl_repasse_dist, 2)
//
//	ivo_Simula.vl_pis_distribuidora		= Round(ldc_bc_pis_cofins * (ivo_Simula.pc_pis / 100), 2) 
//	ivo_Simula.vl_cofins_distribuidora 	= Round(ldc_bc_pis_cofins * (ivo_Simula.pc_cofins / 100), 2) 
//	
//	//dw_1.Object.vl_pis_pedido				[1] = ivo_Simula.vl_pis_pedido
//	//dw_1.Object.vl_cofins_pedido			[1] = ivo_Simula.vl_cofins_pedido
//	
//	dw_1.Object.vl_pis_distribuidora		[1] = ivo_Simula.vl_pis_distribuidora
//	dw_1.Object.vl_cofins_distribuidora	[1] = ivo_Simula.vl_cofins_distribuidora
//	
//	//Desconta pis cofins do valor final
//	//dw_1.Object.vl_preco_final_fab		[1] = (ivo_Simula.vl_preco_final_fab - (ivo_Simula.vl_pis_pedido + ivo_Simula.vl_cofins_pedido))
//	dw_1.Object.vl_preco_compra_dist	[1] = (ivo_Simula.vl_preco_compra_dist  - (ivo_Simula.vl_pis_distribuidora + ivo_Simula.vl_cofins_distribuidora))
//End If

//This.pc_repasse 					= 0.00
//This.vl_repasse 					= 0.00


//////Aqui ser$$HEX1$$e100$$ENDHEX$$ o c$$HEX1$$e100$$ENDHEX$$lculo

ivo_Produto.of_Localiza_Codigo_Interno(ivo_Simula.cd_Produto)

wf_mostra_valores()

dw_1.ResetUpdate()

end subroutine

public subroutine wf_confirma_simulacao ();dw_1.AcceptText()

ivo_simula.id_alteracao_pedido = 'S'

ivo_Simula.vl_Preco_Unitario 	= dw_1.Object.vl_preco_unitario	[1]
ivo_Simula.pc_Desconto			= dw_1.Object.pc_desconto			[1]	
ivo_Simula.vl_repasse			= dw_1.Object.vl_repasse			[1]
ivo_Simula.vl_icms_st				= dw_1.Object.vl_icms_st			[1] 
ivo_Simula.vl_ipi					= dw_1.Object.vl_ipi					[1] 
ivo_Simula.vl_preco_final_fab	= dw_1.Object.vl_preco_final_fab	[1]

end subroutine

public subroutine wf_valores_impostos ();
end subroutine

public subroutine wf_mostra_valores ();dw_1.AcceptText()

If dw_1.Object.vl_icms_calc[1] > 0 Then
	//ICMS PEDIDO CD
	dw_1.Object.gb_icms.Visible 					= True
	dw_1.Object.pc_red_icms_calc.Visible 		= True
	dw_1.Object.pc_icms_calc.Visible 				= True
	dw_1.Object.vl_icms_calc.Visible 				= True
	dw_1.Object.t_pc_red_icms_calc.Visible 		= True
	dw_1.Object.t_pc_icms_calc.Visible 			= True
	dw_1.Object.t_vl_icms_calc.Visible 			= True
	dw_1.Object.vl_bc_icms_calc.Visible 			= True
	dw_1.Object.t_vl_bc_icms_calc.Visible 		= True
	
	//ICMS DISTRIBUIDORA
	dw_1.Object.gb_icms_distribuidora.Visible 	= True
	dw_1.Object.vl_bc_icms_dist_t.Visible 		= True
	dw_1.Object.pc_reducao_icms_dist_t.Visible= True
	dw_1.Object.pc_icms_dist_t.Visible 			= True
	dw_1.Object.vl_icms_dist_t.Visible 			= True	
	dw_1.Object.vl_bc_icms_dist.Visible 			= True
	dw_1.Object.pc_reducao_icms_dist.Visible	= True
	dw_1.Object.pc_icms_dist.Visible 				= True
	dw_1.Object.vl_icms_dist.Visible				= True

End If

If dw_1.Object.vl_icms_st_calc[1]  > 0 Then
	dw_1.Object.gb_icms_st.Visible 						= True
	dw_1.Object.vl_bc_icms_st_calc.Visible				= True
	dw_1.Object.pc_reducao_base_st_calc.Visible 		= True
	dw_1.Object.pc_icms_st_calc.Visible 					= True
	dw_1.Object.vl_icms_st_calc.Visible 					= True
	dw_1.Object.t_vl_bc_icms_st_calc.Visible			= True
	dw_1.Object.t_pc_reducao_base_st_calc.Visible 	= True
	dw_1.Object.t_pc_icms_st_calc.Visible 				= True
	dw_1.Object.t_vl_icms_st_calc.Visible 				= True
	
	If dw_1.Object.pc_mva_calc[1] > 0 Then
		dw_1.Object.pc_mva_calc.Visible 		= True
		dw_1.Object.t_pc_mva_calc.Visible 	= True
	Else
		dw_1.Object.t_vl_bc_icms_st_calc.Text = 'PMC.:'
	End If
End If

If dw_1.Object.pc_ipi[1] > 0 Then
	dw_1.Object.gb_ipi.Visible 								= True
	dw_1.Object.pc_ipi.Visible 								= True
	//dw_1.Object.t_pc_ipi.Visible 							= True
End If

If dw_1.Object.pc_repasse_icms_calc[1] > 0 Then
	dw_1.Object.gb_repasse.Visible 					= True
	dw_1.Object.pc_repasse_icms_calc.Visible 		= True
	//dw_1.Object.t_pc_repasse_icms_calc.Visible 	= True
End If

If dw_1.Object.vl_pis_pedido[1] > 0 OR dw_1.Object.vl_cofins_pedido[1] > 0 OR &
   dw_1.Object.vl_pis_distribuidora[1] > 0 OR dw_1.Object.vl_cofins_distribuidora[1] > 0 Then
	dw_1.Object.gb_pis.visible						= True
	dw_1.Object.gb_cofins.visible					= True
	dw_1.Object.t_vl_pis.visible						= True
	dw_1.Object.t_vl_cofins.visible					= True
	dw_1.Object.vl_pis_pedido.visible				= True
	dw_1.Object.vl_cofins_pedido.visible			= True
	dw_1.Object.vl_pis_distribuidora.visible		= True
	dw_1.Object.vl_cofins_distribuidora.visible	= True
	dw_1.Object.pc_pis.visible						= True
	dw_1.Object.pc_cofins.visible					= True	
End If

end subroutine

on w_ge101_simula_pedido.create
int iCurrent
call super::create
this.cb_cancelar=create cb_cancelar
this.cb_confirmar=create cb_confirmar
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelar
this.Control[iCurrent+2]=this.cb_confirmar
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge101_simula_pedido.destroy
call super::destroy
destroy(this.cb_cancelar)
destroy(this.cb_confirmar)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;ivo_simula = Create uo_simula_pedido

ivo_produto = Create uo_produto 

ivo_simula = Message.PowerObjectParm	

ivo_simula.id_alteracao_pedido = 'N'
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_1.SetFocus()

wf_carrega_informacoes()

dw_1.Event ue_atualiza_valores()

dw_1.ResetUpdate()


end event

event key;call super::key;If Key = KeyEscape! Then
	cb_cancelar.Event clicked()
End If
end event

event close;call super::close;Destroy(ivo_Produto)
end event

type pb_help from dc_w_response`pb_help within w_ge101_simula_pedido
end type

type cb_cancelar from commandbutton within w_ge101_simula_pedido
integer x = 1810
integer y = 2168
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
end type

event clicked;Long lvl_Modificado

Integer lvi_Retorno

dw_1.AcceptText()

lvl_Modificado = dw_1.ModifiedCount() + dw_1.DeletedCount()

If lvl_Modificado > 0 Then
	
	lvi_Retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A simula$$HEX2$$e700e300$$ENDHEX$$o do pedido foi alterada.~r~r" + &
										"Confirma as altera$$HEX2$$e700f500$$ENDHEX$$es da simula$$HEX2$$e700e300$$ENDHEX$$o no pedido ?", Question!, YesNoCancel!, 2)
		
	if lvi_Retorno = 1 then
		ivo_simula.id_alteracao_pedido = 'S'
		wf_Confirma_Simulacao()
	elseif lvi_Retorno = 2 then
		ivo_simula.id_alteracao_pedido = 'N'
	else
		Return 
	end if
End If

CloseWithReturn(Parent, ivo_Simula)

end event

type cb_confirmar from commandbutton within w_ge101_simula_pedido
integer x = 1138
integer y = 2172
integer width = 645
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Confirmar Simula$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;Long lvl_Modificado

Integer lvi_Retorno

dw_1.AcceptText()

lvl_Modificado = dw_1.ModifiedCount() + dw_1.DeletedCount()

If lvl_Modificado > 0 Then
	
	lvi_Retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma as altera$$HEX2$$e700f500$$ENDHEX$$es da simula$$HEX2$$e700e300$$ENDHEX$$o no pedido ?", Question!, YesNoCancel!, 2)

//	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma as altera$$HEX2$$e700f500$$ENDHEX$$es da simula$$HEX2$$e700e300$$ENDHEX$$o no pedido ?", Question!, YesNo!, 2) = 1 Then
//		ivo_simula.id_alteracao_pedido = 'S'
//		wf_Confirma_Simulacao()
//	End If
	
	if lvi_Retorno = 1 then
		ivo_simula.id_alteracao_pedido = 'S'
		wf_Confirma_Simulacao()
	elseif lvi_Retorno = 2 then
		ivo_simula.id_alteracao_pedido = 'N'
	else
		Return 
	end if
		
	CloseWithReturn(Parent, ivo_Simula)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o houve nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o na simula$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
End If

end event

type dw_1 from dc_uo_dw_base within w_ge101_simula_pedido
event ue_atualiza_valores ( )
integer x = 55
integer y = 108
integer width = 3031
integer height = 2020
integer taborder = 20
string dataobject = "dw_ge101_simulacao"
end type

event ue_atualiza_valores();Decimal 	lvdc_Preco_Unitario,&
			lvdc_Desconto,&
			lvdc_PC_ICMS_Venda,&
			lvdc_PC_ICMS_Compra,&
			lvdc_PC_Repasse,&
			lvdc_Repasse,&
			lvdc_ICMS_ST,&
			lvdc_PC_Juros_Compra,&
			lvdc_Valor_Compra,&
		   lvdc_Juros_Pagto,&
			lvdc_Preco_Liquido,&
			lvdc_Valor_IPI,&
			lvdc_PC_IPI,&
			lvdc_Acrescimo_Logistica,&
			lvdc_Reducao_ICMS,&
			lvdc_Valor_ICMS

Long 	lvl_Produto

String	lvs_Grupo,&
		lvs_ICMS_Normal,&
		ls_Fornecedor
		
dw_1.AcceptText()

//lvs_UF_Fornecedor	= ivo_Simula.cd_uf_fornecedor	
//lvs_UF_Filial				= ivo_Simula.cd_uf_filial
lvdc_PC_IPI				= ivo_Simula.pc_ipi
lvs_Grupo				= dw_1.Object.cd_grupo						[1]
lvdc_Preco_Unitario	= dw_1.Object.vl_preco_unitario			[1]
lvdc_Desconto			= dw_1.Object.pc_desconto					[1]
lvs_ICMS_Normal		= dw_1.Object.id_icms_normal				[1]
lvdc_PC_ICMS_Venda	= dw_1.Object.pc_icms						[1]

// Percentual de ICMS para compras interestaduais
lvdc_Repasse				= 0.00
lvdc_ICMS_ST				= 0.00
lvdc_Valor_IPI				= 0.00	

lvdc_Preco_Liquido = round(round(lvdc_Preco_Unitario * (100 - lvdc_Desconto) / 100, 2)  * ((100 - ivo_simula.pc_desconto_pedido) / 100), 2)

//lvdc_Valor_Compra = ivo_Simula.of_Valor_Compra(	lvdc_Preco_Unitario, lvdc_Desconto,& 
//																ivo_Simula.pc_desconto_pedido,&
//																ivo_Simula.PC_ICMS, ivo_Simula.cd_Tributacao_ICMS, &
//																ivo_Simula.cd_Tributacao_Produto, &
//																ivo_Simula.id_Caderno_ABCFarma, ivo_Simula.id_Lei_Generico,  &
//																ivo_Simula.cd_UF_Filial,  ivo_Simula.cd_UF_Fornecedor,&
//																ivo_Simula.id_Situacao_Pis_Cofins,&
//																ivo_Simula.vl_preco_venda_maximo, ivo_Produto,&
//																lvs_ICMS_Normal, lvdc_PC_IPI, ivo_Simula.nr_classificacao_fiscal, 0.00)


lvdc_Valor_Compra = ivo_Simula.of_Valor_Compra_Nova(	lvdc_Preco_Unitario,& 
																			lvdc_Desconto,& 
																			ivo_Simula.pc_desconto_pedido,&
																			ivo_Simula.cd_UF_Filial,&
																			ivo_Simula.cd_UF_Fornecedor,&
																			ivo_Produto,&
																			ivo_Simula.pc_ipi,&
																			ivo_Simula.cd_fornecedor, 0.00)

ivo_Simula.of_calcula_juros_diario(ivo_Simula.cd_condicao_pagamento, lvdc_Valor_Compra, Ref lvdc_Juros_Pagto)

// (-) Juros ao contr$$HEX1$$e100$$ENDHEX$$rio
lvdc_Valor_Compra = lvdc_Valor_Compra  - lvdc_Juros_Pagto

lvdc_Acrescimo_Logistica  = round(lvdc_Valor_Compra * (ivo_Simula.pc_tx_adm_logistica / 100),2)

// (+) Custo ADM logistica
lvdc_Valor_Compra = lvdc_Valor_Compra + round(lvdc_Valor_Compra * (ivo_Simula.pc_tx_adm_logistica / 100),2)

dw_1.Object.vl_repasse					[1] = ivo_Simula.vl_Repasse
dw_1.Object.vl_icms_st					[1] = ivo_Simula.vl_ICMS_ST
dw_1.Object.vl_preco_final_fab		[1] = lvdc_Valor_Compra
dw_1.Object.vl_ipi							[1] = ivo_Simula.vl_IPI
dw_1.Object.vl_juros_decrescimo		[1] = lvdc_Juros_Pagto
dw_1.Object.vl_acrescimo_logistica	[1] = lvdc_Acrescimo_Logistica

dw_1.Object.pc_red_icms_calc				[1] = ivo_Simula.pc_reducao_base_icms
//dw_1.Object.vl_bc_icms_calc				[1] = ivo_Simula.vl_bc_icms
dw_1.Object.pc_icms_calc					[1] = ivo_Simula.pc_icms_compra
dw_1.Object.vl_icms_calc					[1] = ivo_Simula.vl_icms

If dw_1.Object.pc_red_icms_calc[1]  > 0 Then
	dw_1.Object.vl_bc_icms_calc[1] = round((ivo_Simula.vl_bc_icms / (100 - dw_1.Object.pc_red_icms_calc[1])) * 100 , 2)
Else
	dw_1.Object.vl_bc_icms_calc[1] = ivo_Simula.vl_bc_icms
End If

dw_1.Object.pc_mva_calc					[1] = ivo_Simula.vl_mva
dw_1.Object.pc_reducao_base_st_calc	[1] = ivo_Simula.pc_Reducao_Base_ST
dw_1.Object.pc_icms_st_calc				[1] = ivo_Simula.pc_icms_venda
dw_1.Object.vl_icms_st_calc				[1] = ivo_Simula.vl_icms_st
dw_1.Object.pc_ipi							[1] = ivo_Simula.pc_ipi
dw_1.Object.vl_bc_icms_st_calc			[1] = ivo_Simula.vl_bc_icms_st

If ivo_Simula.vl_pmc > 0 Then
	dw_1.Object.vl_bc_icms_st_calc[1] = ivo_Simula.vl_pmc
End If

dw_1.Object.pc_repasse_icms_calc[1] = ivo_Simula.pc_repasse

If ivo_Simula.ib_parametro_pis_cofins Then	
	dw_1.Object.vl_pis_pedido				[1] = ivo_Simula.vl_pis_pedido
	dw_1.Object.vl_cofins_pedido			[1] = ivo_Simula.vl_cofins_pedido
	
	dw_1.Object.vl_preco_final_fab		[1] = (lvdc_Valor_Compra - (ivo_Simula.vl_pis_pedido + ivo_Simula.vl_cofins_pedido))
	
End If

wf_mostra_valores()

end event

event itemchanged;call super::itemchanged;Boolean lb_Visivel

If dwo.name = "id_mostra_valores_calculado" Then
	
	If data = 'S' Then
		lb_Visivel = True
	Else
		lb_Visivel = False
	End If
	
	dw_1.Object.gb_icms.Visible 					= lb_Visivel
	dw_1.Object.pc_red_icms_calc.Visible 		= lb_Visivel
	dw_1.Object.pc_icms_calc.Visible 				= lb_Visivel
	dw_1.Object.vl_icms_calc.Visible 				= lb_Visivel
	dw_1.Object.t_pc_red_icms_calc.Visible 		= lb_Visivel
	dw_1.Object.t_pc_icms_calc.Visible 			= lb_Visivel
	dw_1.Object.t_vl_icms_calc.Visible 			= lb_Visivel
	
	dw_1.Object.pc_mva_calc.Visible 					= lb_Visivel
	dw_1.Object.pc_reducao_base_st_calc.Visible 	= lb_Visivel
	dw_1.Object.pc_icms_st_calc.Visible 				= lb_Visivel
	dw_1.Object.vl_icms_st_calc.Visible 				= lb_Visivel
	
	dw_1.Object.t_pc_mva_calc.Visible 					= lb_Visivel
	dw_1.Object.t_pc_reducao_base_st_calc.Visible 	= lb_Visivel
	dw_1.Object.t_pc_icms_st_calc.Visible 				= lb_Visivel
	dw_1.Object.t_vl_icms_st_calc.Visible 				= lb_Visivel
	
	dw_1.Object.vl_bc_icms_dist_t.Visible 			= lb_Visivel
	dw_1.Object.pc_reducao_icms_dist_t.Visible	= lb_Visivel
	dw_1.Object.pc_icms_dist_t.Visible 				= lb_Visivel
	dw_1.Object.vl_bc_icms_dist_t.Visible 			= lb_Visivel
	
	dw_1.Object.vl_bc_icms_dist.Visible 			= lb_Visivel
	dw_1.Object.pc_reducao_icms_dist.Visible	= lb_Visivel
	dw_1.Object.pc_icms_dist.Visible 				= lb_Visivel
	dw_1.Object.vl_icms_dist.Visible				= lb_Visivel
		
End If


cb_confirmar.Enabled = True

This.Event ue_atualiza_valores()
end event

event ue_key;call super::ue_key;If Key = KeyEscape! Then
	cb_cancelar.Event clicked()
End If

end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type gb_1 from groupbox within w_ge101_simula_pedido
integer x = 32
integer y = 8
integer width = 3099
integer height = 2156
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Simula$$HEX2$$e700e300$$ENDHEX$$o de Compra"
borderstyle borderstyle = styleraised!
end type

