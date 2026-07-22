HA$PBExportHeader$w_ge328_divergencia_nf_compra_pedido.srw
forward
global type w_ge328_divergencia_nf_compra_pedido from dc_w_selecao_lista_relatorio
end type
type gb_4 from groupbox within w_ge328_divergencia_nf_compra_pedido
end type
type dw_4 from dc_uo_dw_base within w_ge328_divergencia_nf_compra_pedido
end type
end forward

global type w_ge328_divergencia_nf_compra_pedido from dc_w_selecao_lista_relatorio
integer width = 3616
integer height = 1884
string title = "GE328 - Relat$$HEX1$$f300$$ENDHEX$$rio de Diverg$$HEX1$$ea00$$ENDHEX$$ncias Nota Fiscal x Pedido"
long backcolor = 80269524
gb_4 gb_4
dw_4 dw_4
end type
global w_ge328_divergencia_nf_compra_pedido w_ge328_divergencia_nf_compra_pedido

type variables
uo_fornecedor ivo_fornecedor
end variables

on w_ge328_divergencia_nf_compra_pedido.create
int iCurrent
call super::create
this.gb_4=create gb_4
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_4
end on

on w_ge328_divergencia_nf_compra_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_4)
destroy(this.dw_4)
end on

event ue_postopen;call super::ue_postopen;DateTime lvdh_Parametro

dw_4.Event ue_AddRow()
dw_1.SetFocus()

ivm_Menu.ivb_Permite_Imprimir = True

lvdh_Parametro = gvo_Parametro.of_Dh_Movimentacao()

dw_1.Object.Dt_Inicio [1] = lvdh_Parametro
dw_1.Object.Dt_Termino[1] = lvdh_Parametro


end event

event open;call super::open;ivo_Fornecedor = Create uo_Fornecedor
end event

event close;call super::close;Destroy(ivo_Fornecedor)
end event

event ue_preprint;call super::ue_preprint;Date 	lvdt_Inicio, &
		lvdt_Termino
	  
//String	lvs_Repasse

lvdt_Inicio  		= dw_1.Object.Dt_Inicio 			[1]
lvdt_Termino	= dw_1.Object.Dt_Termino			[1]
//lvs_Repasse	= dw_1.Object.id_repasse_icms	[1]

dw_1.AcceptText()

dw_3.Object.Cab_Periodo.Text = String(lvdt_Inicio, "dd/mm/yyyy") + "  at$$HEX1$$e900$$ENDHEX$$  " + String(lvdt_Termino, "dd/mm/yyyy")

//dw_3.Object.id_repasse[1] = lvs_Repasse

Return AncestorReturnValue
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge328_divergencia_nf_compra_pedido
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge328_divergencia_nf_compra_pedido
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge328_divergencia_nf_compra_pedido
integer x = 18
integer y = 348
integer width = 3538
integer height = 1328
integer weight = 700
string text = "Lista de Notas Fiscais com Diverg$$HEX1$$ea00$$ENDHEX$$ncias"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge328_divergencia_nf_compra_pedido
integer x = 18
integer y = 4
integer width = 2139
integer height = 332
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge328_divergencia_nf_compra_pedido
integer x = 46
integer y = 60
integer width = 2094
integer height = 260
string dataobject = "dw_ge328_selecao"
end type

event dw_1::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fornecedor" Then
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social	
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_fornecedor" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social			
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge328_divergencia_nf_compra_pedido
integer x = 50
integer y = 400
integer width = 3483
integer height = 1252
integer taborder = 30
string dataobject = "dw_ge328_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date	lvdt_Inicio, &
     	lvdt_Termino

String	lvs_Fornecedor, &
		lvs_Div_Condicao, &
       	lvs_Div_Qtde, &
		lvs_Div_Preco, &
		lvs_Div_Desconto,&
		lvs_Repasse

Long	lvl_NF, &
     	lvl_Variacao_Custo

dw_1.AcceptText()
dw_4.AcceptText()

lvdt_Inicio        			= dw_1.Object.Dt_Inicio        			[1]
lvdt_Termino       		= dw_1.Object.Dt_Termino       		[1]
lvs_Fornecedor     		= dw_1.Object.Cd_Fornecedor    		[1]
lvl_NF             			= dw_1.Object.Nr_NF            			[1]
lvs_Repasse     		= dw_1.Object.id_repasse_icms   		[1]
lvs_Div_Condicao   	= dw_4.Object.Id_Condicao      		[1]
lvs_Div_Qtde       		= dw_4.Object.Id_Qtde          			[1]
lvs_Div_Preco      		= dw_4.Object.Id_Preco         			[1]
lvs_Div_Desconto   	= dw_4.Object.Id_Desconto      		[1]
lvl_Variacao_Custo 	= dw_4.Object.Pc_Variacao_Custo	[1]

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvs_Div_Condicao = "N" and lvs_Div_Qtde = "N" and lvs_Div_Preco = "N" and lvs_Div_Desconto = "N" and &
	(lvl_Variacao_Custo = 0 or IsNull(lvl_Variacao_Custo)) Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um tipo de diverg$$HEX1$$ea00$$ENDHEX$$ncia.")
	dw_4.Event ue_Pos(1, "id_condicao")
	Return -1	
End If

This.of_AppendWhere("n.dh_movimentacao_caixa between '" + String(lvdt_Inicio,  "yyyy/mm/dd") + "' and '" + &
																			 String(lvdt_Termino, "yyyy/mm/dd") + "'", 1)

This.of_AppendWhere("convert(char(8), n.dh_registro, 112) between '" + String(lvdt_Inicio,  "yyyymmdd") + "' and '" + &
																			 				  String(lvdt_Termino, "yyyymmdd") + "'", 2)

If Not IsNull(lvs_Fornecedor) and lvs_Fornecedor <> "" Then
	This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 1)
	This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 2)
End If

If Not IsNull(lvl_NF) and lvl_NF > 0 Then
	This.of_AppendWhere("n.nr_nf = " + String(lvl_NF), 1)
	This.of_AppendWhere("n.nr_nf = " + String(lvl_NF), 2)
End If

If lvs_Div_Condicao = "S" Then
	This.of_AppendWhere("n.cd_condicao_pagamento <> p.cd_condicao_pagamento", 1)
	This.of_AppendWhere("n.cd_condicao_pagamento <> p.cd_condicao_pagamento", 2)
End If

If lvs_Div_Qtde = "S" Then
	This.of_AppendWhere("i.qt_faturada <> b.qt_pedida", 1)
	This.of_AppendWhere("i.qt_faturada <> b.qt_pedida", 2)
End If

If lvs_Div_Preco = "S" Then
	This.of_AppendWhere("i.vl_preco_unitario <> b.vl_preco_unitario", 1)
	This.of_AppendWhere("i.vl_preco_unitario <> b.vl_preco_unitario", 2)
End If

//If lvs_Div_Desconto = "S" Then
//	This.of_AppendWhere("i.pc_desconto <> b.pc_desconto", 1)
//	This.of_AppendWhere("i.pc_desconto <> b.pc_desconto", 2)
//End If

If lvs_Div_Desconto = "S" Then
	If lvs_Repasse = 'S' Then
		This.of_AppendWhere("i.pc_desconto <> Round((1 - (((100 - b.pc_desconto) / 100) * ((100 - p.pc_desconto) / 100) * ((100 - isnull(b.pc_repasse_icms, 0)) / 100))) * 100, 2)", 1)
		This.of_AppendWhere("i.pc_desconto <> Round((1 - (((100 - b.pc_desconto) / 100) * ((100 - p.pc_desconto) / 100) * ((100 - isnull(b.pc_repasse_icms,0)) / 100))) * 100, 2)", 2)
	Else
		This.of_AppendWhere("i.pc_desconto <> Round((1 - ((100 - b.pc_desconto) / 100) * ((100 - p.pc_desconto) / 100)) * 100, 2)", 1)
		This.of_AppendWhere("i.pc_desconto <> Round((1 - ((100 - b.pc_desconto) / 100) * ((100 - p.pc_desconto) / 100)) * 100, 2)", 2)
	End If
End If

This.SetRedraw(False)
This.SetFilter("")
This.Filter()

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Variacao_Custo

String lvs_Filtro

If pl_Linhas > 0 Then
	lvl_Variacao_Custo = dw_4.Object.Pc_Variacao_Custo[1]
	
	If Not IsNull(lvl_Variacao_Custo) and lvl_Variacao_Custo > 0 Then
		lvs_Filtro = "abs(pc_variacao_custo) >= " + String(lvl_Variacao_Custo)
		
		This.SetFilter(lvs_Filtro)
		This.Filter()
		
		This.Sort()
		This.GroupCalc()
	End If
	
	ivm_Menu.mf_SalvarComo(True)
Else
	ivm_Menu.mf_SalvarComo(False)
End If

This.SetRedraw(True)

Return pl_Linhas
end event

event dw_2::ue_recuperar;//OverRide

String	lvs_Div_Desconto,&
		lvs_Repasse

dw_1.AcceptText()

lvs_Repasse     		= dw_1.Object.id_repasse_icms   		[1]
lvs_Div_Desconto   	= dw_4.Object.Id_Desconto      		[1]

Return This.Retrieve(lvs_Repasse)


end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge328_divergencia_nf_compra_pedido
integer x = 1486
integer y = 52
integer width = 334
integer height = 84
string dataobject = "dw_ge328_relatorio"
end type

type gb_4 from groupbox within w_ge328_divergencia_nf_compra_pedido
integer x = 2185
integer y = 4
integer width = 1371
integer height = 332
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Tipos de Diverg$$HEX1$$ea00$$ENDHEX$$ncias"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within w_ge328_divergencia_nf_compra_pedido
integer x = 2199
integer y = 60
integer width = 1335
integer height = 260
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge328_tipo_divergencia"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
end event

