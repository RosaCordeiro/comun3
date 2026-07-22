HA$PBExportHeader$w_ge101_consulta_pedido_produto.srw
forward
global type w_ge101_consulta_pedido_produto from dc_w_response
end type
type gb_4 from groupbox within w_ge101_consulta_pedido_produto
end type
type gb_3 from groupbox within w_ge101_consulta_pedido_produto
end type
type gb_2 from groupbox within w_ge101_consulta_pedido_produto
end type
type gb_1 from groupbox within w_ge101_consulta_pedido_produto
end type
type dw_1 from dc_uo_dw_base within w_ge101_consulta_pedido_produto
end type
type cb_fechar from commandbutton within w_ge101_consulta_pedido_produto
end type
type dw_2 from dc_uo_dw_base within w_ge101_consulta_pedido_produto
end type
type cb_consultar from commandbutton within w_ge101_consulta_pedido_produto
end type
type dw_3 from dc_uo_dw_base within w_ge101_consulta_pedido_produto
end type
type dw_4 from dc_uo_dw_base within w_ge101_consulta_pedido_produto
end type
type cb_imprimir from commandbutton within w_ge101_consulta_pedido_produto
end type
type dw_5 from dc_uo_dw_base within w_ge101_consulta_pedido_produto
end type
end forward

global type w_ge101_consulta_pedido_produto from dc_w_response
integer x = 553
integer y = 624
integer width = 4517
integer height = 1936
string title = "GE101 - Consulta Pedidos do Produto"
boolean controlmenu = false
long backcolor = 80269524
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
cb_fechar cb_fechar
dw_2 dw_2
cb_consultar cb_consultar
dw_3 dw_3
dw_4 dw_4
cb_imprimir cb_imprimir
dw_5 dw_5
end type
global w_ge101_consulta_pedido_produto w_ge101_consulta_pedido_produto

type variables
long ivl_produto,&
        ivl_filial

string ivs_descricao

date ivdt_parametro
end variables

on w_ge101_consulta_pedido_produto.create
int iCurrent
call super::create
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_fechar=create cb_fechar
this.dw_2=create dw_2
this.cb_consultar=create cb_consultar
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_imprimir=create cb_imprimir
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_fechar
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.cb_consultar
this.Control[iCurrent+9]=this.dw_3
this.Control[iCurrent+10]=this.dw_4
this.Control[iCurrent+11]=this.cb_imprimir
this.Control[iCurrent+12]=this.dw_5
end on

on w_ge101_consulta_pedido_produto.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_fechar)
destroy(this.dw_2)
destroy(this.cb_consultar)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_imprimir)
destroy(this.dw_5)
end on

event open;call super::open;String lvs_Parametro

lvs_Parametro = Message.StringParm

ivl_Filial	   = Long(LeftA(lvs_Parametro, 4))
ivdt_Parametro = Date(MidA(lvs_Parametro, 5, 10))
ivl_Produto    = Long(MidA(lvs_Parametro, 15, 6))
ivs_Descricao  = MidA(lvs_Parametro, 21)

dw_4.Visible = False

end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_5.Event ue_AddRow()

dw_1.Object.Cd_Produto[1] = ivl_Produto
dw_1.Object.De_Produto[1] = ivs_Descricao
dw_1.Object.Dt_Inicio [1] = RelativeDate(ivdt_Parametro, -90)
dw_1.Object.Dt_Termino[1] = ivdt_Parametro

dw_2.Event ue_Retrieve()








end event

type pb_help from dc_w_response`pb_help within w_ge101_consulta_pedido_produto
end type

type gb_4 from groupbox within w_ge101_consulta_pedido_produto
integer x = 18
integer y = 1364
integer width = 1627
integer height = 460
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Dados do Faturamento"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_ge101_consulta_pedido_produto
integer x = 1701
integer y = 1364
integer width = 1504
integer height = 176
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge101_consulta_pedido_produto
integer x = 18
integer y = 264
integer width = 4471
integer height = 1084
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Pedidos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge101_consulta_pedido_produto
integer x = 18
integer width = 1797
integer height = 252
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge101_consulta_pedido_produto
integer x = 46
integer y = 60
integer width = 1755
integer height = 172
boolean bringtotop = true
string dataobject = "dw_ge101_selecao_consulta_pedido"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;dw_2.Reset()

cb_Imprimir.Enabled = False
end event

type cb_fechar from commandbutton within w_ge101_consulta_pedido_produto
integer x = 4087
integer y = 1700
integer width = 357
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type dw_2 from dc_uo_dw_base within w_ge101_consulta_pedido_produto
integer x = 46
integer y = 312
integer width = 4430
integer height = 1028
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge101_lista_consulta_pedido"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

dw_2.ShareData(dw_4)

end event

event ue_recuperar;// Override

Date lvdt_Inicio, &
     lvdt_Termino
	 
dw_1.AcceptText()

lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

If Not IsDate(String(lvdt_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsDate(String(lvdt_Termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

Return This.Retrieve(ivl_Produto, lvdt_Inicio, lvdt_Termino, ivl_Filial)
end event

event ue_postretrieve;If pl_Linhas = -1 Then Return -1

If pl_Linhas > 0 Then
	cb_Imprimir.Enabled = True
	This.SetFocus()
Else
	cb_Imprimir.Enabled = False
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido foi localizado no per$$HEX1$$ed00$$ENDHEX$$odo informado.", Information!)
	dw_5.Reset()
	dw_5.Event ue_AddRow()
End If

Return pl_Linhas
end event

event rowfocuschanged;call super::rowfocuschanged;Long lvl_Linha
Long lvl_Condicao
Long lvl_Produto
Long lvl_Pedido

This.AcceptText()

lvl_Linha = This.GetRow()

If lvl_Linha > 0 Then
	
	lvl_Produto = dw_1.Object.cd_produto[1]
	
	lvl_Condicao = This.Object.cd_condicao_pagamento[lvl_Linha]
	
	dw_3.Retrieve(lvl_Condicao)
	
	lvl_Pedido = This.Object.nr_pedido[lvl_Linha]
	
	dw_5.Retrieve(lvl_Pedido, lvl_Produto)
End If
end event

type cb_consultar from commandbutton within w_ge101_consulta_pedido_produto
integer x = 3909
integer y = 156
integer width = 562
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Con&sultar Pedidos"
boolean cancel = true
end type

event clicked;dw_2.Event ue_Retrieve()
end event

type dw_3 from dc_uo_dw_base within w_ge101_consulta_pedido_produto
integer x = 1733
integer y = 1424
integer width = 1458
integer height = 100
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge101_condicao_pgto"
end type

type dw_4 from dc_uo_dw_base within w_ge101_consulta_pedido_produto
integer x = 1911
integer y = 48
integer width = 288
integer height = 124
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge101_lista_consulta_pedido_relatorio"
end type

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino

String lvs_DE_Produto

Long lvl_Produto

dw_1.AcceptText()

lvdt_Inicio     = dw_1.Object.dt_inicio    [1] 
lvdt_Termino    = dw_1.Object.dt_termino   [1] 
lvl_Produto     = dw_1.Object.cd_produto   [1]
lvs_DE_Produto  = dw_1.Object.de_produto   [1]

dw_4.Object.st_periodo.text    = String(lvdt_Inicio, "dd/mm/yyyy") + " at$$HEX1$$e900$$ENDHEX$$: " + String(lvdt_Termino, "dd/mm/yyyy")

dw_4.Object.st_produto.text = lvs_DE_Produto + " (" + String(lvl_Produto) + ")"

Return AncestorReturnValue







end event

type cb_imprimir from commandbutton within w_ge101_consulta_pedido_produto
integer x = 3287
integer y = 156
integer width = 567
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Imprimir Consulta"
end type

event clicked;dw_4.Event ue_Print()
end event

type dw_5 from dc_uo_dw_base within w_ge101_consulta_pedido_produto
integer x = 46
integer y = 1416
integer width = 1573
integer height = 396
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge101_produto_nota_fiscal"
boolean vscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetRowSelection()

end event

