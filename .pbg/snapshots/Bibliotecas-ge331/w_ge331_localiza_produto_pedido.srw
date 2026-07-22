HA$PBExportHeader$w_ge331_localiza_produto_pedido.srw
forward
global type w_ge331_localiza_produto_pedido from dc_w_base
end type
type cb_2 from commandbutton within w_ge331_localiza_produto_pedido
end type
type cb_1 from commandbutton within w_ge331_localiza_produto_pedido
end type
type dw_1 from dc_uo_dw_base within w_ge331_localiza_produto_pedido
end type
type gb_1 from groupbox within w_ge331_localiza_produto_pedido
end type
end forward

global type w_ge331_localiza_produto_pedido from dc_w_base
integer width = 2537
integer height = 1476
string title = "GE331 - Localiza Produto"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge331_localiza_produto_pedido w_ge331_localiza_produto_pedido

on w_ge331_localiza_produto_pedido.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge331_localiza_produto_pedido.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;Long ll_pedido

ll_Pedido = Message.DoubleParm	

If dw_1.Retrieve(ll_Pedido) < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum produto para o pedido "+String(ll_Pedido)+".")
	CloseWithReturn(This, -1)
End If

gb_1.Text = "Produtos do Pedido "+String(ll_Pedido)
end event

type cb_2 from commandbutton within w_ge331_localiza_produto_pedido
integer x = 1522
integer y = 1276
integer width = 402
integer height = 104
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Selecionar"
end type

event clicked;Long ll_Produto

dw_1.AcceptText()

ll_Produto = dw_1.Object.cd_produto[dw_1.getRow()]

CloseWithReturn(Parent, ll_Produto)
end event

type cb_1 from commandbutton within w_ge331_localiza_produto_pedido
integer x = 2158
integer y = 1276
integer width = 320
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;CloseWithReturn(Parent, -1)
end event

type dw_1 from dc_uo_dw_base within w_ge331_localiza_produto_pedido
integer x = 73
integer y = 84
integer width = 2400
integer height = 1148
integer taborder = 20
string dataobject = "dw_ge331_localiza_produtos_pedido"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type gb_1 from groupbox within w_ge331_localiza_produto_pedido
integer x = 32
integer y = 20
integer width = 2464
integer height = 1232
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos do Pedido"
end type

