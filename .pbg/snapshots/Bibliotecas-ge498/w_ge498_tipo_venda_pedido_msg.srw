HA$PBExportHeader$w_ge498_tipo_venda_pedido_msg.srw
forward
global type w_ge498_tipo_venda_pedido_msg from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge498_tipo_venda_pedido_msg
end type
type cb_sim from commandbutton within w_ge498_tipo_venda_pedido_msg
end type
type cb_nao from commandbutton within w_ge498_tipo_venda_pedido_msg
end type
type gb_1 from groupbox within w_ge498_tipo_venda_pedido_msg
end type
end forward

global type w_ge498_tipo_venda_pedido_msg from dc_w_response
integer width = 2441
integer height = 876
dw_1 dw_1
cb_sim cb_sim
cb_nao cb_nao
gb_1 gb_1
end type
global w_ge498_tipo_venda_pedido_msg w_ge498_tipo_venda_pedido_msg

on w_ge498_tipo_venda_pedido_msg.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_sim=create cb_sim
this.cb_nao=create cb_nao
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_sim
this.Control[iCurrent+3]=this.cb_nao
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge498_tipo_venda_pedido_msg.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_sim)
destroy(this.cb_nao)
destroy(this.gb_1)
end on

event open;call super::open;dc_uo_ds_base lds_dados

lds_dados = message.powerobjectparm

lds_dados.rowscopy( 1, lds_dados.rowcount(), primary!, dw_1, 1, primary!)

end event

type pb_help from dc_w_response`pb_help within w_ge498_tipo_venda_pedido_msg
end type

type dw_1 from dc_uo_dw_base within w_ge498_tipo_venda_pedido_msg
integer x = 96
integer y = 112
integer width = 2235
integer height = 480
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge498_tipo_venda_pedido_msg"
end type

type cb_sim from commandbutton within w_ge498_tipo_venda_pedido_msg
integer x = 1417
integer y = 620
integer width = 402
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Sim"
boolean default = true
end type

event clicked;CloseWithReturn(parent, 'S')
end event

type cb_nao from commandbutton within w_ge498_tipo_venda_pedido_msg
integer x = 1847
integer y = 620
integer width = 402
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&N$$HEX1$$e300$$ENDHEX$$o"
boolean cancel = true
end type

event clicked;Close(parent)
end event

type gb_1 from groupbox within w_ge498_tipo_venda_pedido_msg
integer x = 32
integer y = 32
integer width = 2377
integer height = 732
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

