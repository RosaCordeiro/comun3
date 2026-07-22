HA$PBExportHeader$dc_w_response_ok_cancela.srw
forward
global type dc_w_response_ok_cancela from dc_w_response
end type
type gb_1 from groupbox within dc_w_response_ok_cancela
end type
type dw_1 from dc_uo_dw_base within dc_w_response_ok_cancela
end type
type cb_ok from commandbutton within dc_w_response_ok_cancela
end type
type cb_cancelar from commandbutton within dc_w_response_ok_cancela
end type
end forward

global type dc_w_response_ok_cancela from dc_w_response
integer x = 567
integer y = 424
integer width = 2487
integer height = 1408
boolean controlmenu = false
gb_1 gb_1
dw_1 dw_1
cb_ok cb_ok
cb_cancelar cb_cancelar
end type
global dc_w_response_ok_cancela dc_w_response_ok_cancela

type variables
boolean ivb_pesquisa_direta = false
end variables

on dc_w_response_ok_cancela.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_cancelar
end on

on dc_w_response_ok_cancela.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_cancelar)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_1.SetFocus()
end event

type pb_help from dc_w_response`pb_help within dc_w_response_ok_cancela
end type

type gb_1 from groupbox within dc_w_response_ok_cancela
integer x = 23
integer y = 4
integer width = 2418
integer height = 1124
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within dc_w_response_ok_cancela
integer x = 55
integer y = 68
integer width = 2359
integer height = 1032
integer taborder = 40
boolean bringtotop = true
end type

type cb_ok from commandbutton within dc_w_response_ok_cancela
integer x = 1810
integer y = 1168
integer width = 311
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
boolean default = true
end type

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

type cb_cancelar from commandbutton within dc_w_response_ok_cancela
integer x = 2144
integer y = 1168
integer width = 311
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

