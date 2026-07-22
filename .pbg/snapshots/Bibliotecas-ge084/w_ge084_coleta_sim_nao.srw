HA$PBExportHeader$w_ge084_coleta_sim_nao.srw
forward
global type w_ge084_coleta_sim_nao from window
end type
type cb_cancelar from commandbutton within w_ge084_coleta_sim_nao
end type
type st_titulo1 from statictext within w_ge084_coleta_sim_nao
end type
type cb_sim from commandbutton within w_ge084_coleta_sim_nao
end type
type cb_nao from commandbutton within w_ge084_coleta_sim_nao
end type
type gb_1 from groupbox within w_ge084_coleta_sim_nao
end type
end forward

global type w_ge084_coleta_sim_nao from window
integer x = 741
integer y = 932
integer width = 2149
integer height = 624
boolean titlebar = true
string title = "Transa$$HEX2$$e700e300$$ENDHEX$$o TEF"
windowtype windowtype = response!
long backcolor = 80269524
cb_cancelar cb_cancelar
st_titulo1 st_titulo1
cb_sim cb_sim
cb_nao cb_nao
gb_1 gb_1
end type
global w_ge084_coleta_sim_nao w_ge084_coleta_sim_nao

type variables

end variables

on w_ge084_coleta_sim_nao.create
this.cb_cancelar=create cb_cancelar
this.st_titulo1=create st_titulo1
this.cb_sim=create cb_sim
this.cb_nao=create cb_nao
this.gb_1=create gb_1
this.Control[]={this.cb_cancelar,&
this.st_titulo1,&
this.cb_sim,&
this.cb_nao,&
this.gb_1}
end on

on w_ge084_coleta_sim_nao.destroy
destroy(this.cb_cancelar)
destroy(this.st_titulo1)
destroy(this.cb_sim)
destroy(this.cb_nao)
destroy(this.gb_1)
end on

event open;
String ls_Titulo
String ls_Recarga

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

ls_Titulo  = Message.StringParm

This.Show()

gf_Ativa_Janela(This)

This.Title = ls_Titulo
end event

type cb_cancelar from commandbutton within w_ge084_coleta_sim_nao
integer x = 37
integer y = 380
integer width = 370
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,'CANCELAR')
end event

event getfocus;This.Weight  = 700
end event

event losefocus;This.Weight  = 400
end event

type st_titulo1 from statictext within w_ge084_coleta_sim_nao
integer x = 64
integer y = 68
integer width = 1998
integer height = 272
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_sim from commandbutton within w_ge084_coleta_sim_nao
integer x = 1714
integer y = 380
integer width = 370
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Sim"
end type

event clicked;CloseWithReturn(Parent,'S')
end event

event getfocus;This.Weight  = 700

end event

event losefocus;This.Weight  = 400
end event

type cb_nao from commandbutton within w_ge084_coleta_sim_nao
integer x = 1326
integer y = 380
integer width = 370
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&N$$HEX1$$e300$$ENDHEX$$o"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,'N')
end event

event getfocus;This.Weight  = 700
end event

event losefocus;This.Weight  = 400
end event

type gb_1 from groupbox within w_ge084_coleta_sim_nao
integer x = 37
integer y = 12
integer width = 2053
integer height = 352
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

