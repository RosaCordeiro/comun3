HA$PBExportHeader$dc_w_sobre.srw
forward
global type dc_w_sobre from dc_w_inicial
end type
type cb_fechar from commandbutton within dc_w_sobre
end type
end forward

global type dc_w_sobre from dc_w_inicial
integer width = 2345
integer height = 1312
boolean border = false
cb_fechar cb_fechar
end type
global dc_w_sobre dc_w_sobre

on dc_w_sobre.create
int iCurrent
call super::create
this.cb_fechar=create cb_fechar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_fechar
end on

on dc_w_sobre.destroy
call super::destroy
destroy(this.cb_fechar)
end on

type dw_1 from dc_w_inicial`dw_1 within dc_w_sobre
end type

type cb_fechar from commandbutton within dc_w_sobre
integer x = 1975
integer y = 1164
integer width = 302
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
boolean cancel = true
boolean default = true
end type

event clicked;close(parent)
end event

