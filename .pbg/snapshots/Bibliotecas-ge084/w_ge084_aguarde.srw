HA$PBExportHeader$w_ge084_aguarde.srw
forward
global type w_ge084_aguarde from window
end type
type st_msg from statictext within w_ge084_aguarde
end type
type cb_cancelar from commandbutton within w_ge084_aguarde
end type
type mle_2 from multilineedit within w_ge084_aguarde
end type
type mle_1 from multilineedit within w_ge084_aguarde
end type
type gb_1 from groupbox within w_ge084_aguarde
end type
end forward

global type w_ge084_aguarde from window
integer x = 887
integer y = 980
integer width = 1902
integer height = 512
boolean titlebar = true
windowtype windowtype = popup!
long backcolor = 80269524
st_msg st_msg
cb_cancelar cb_cancelar
mle_2 mle_2
mle_1 mle_1
gb_1 gb_1
end type
global w_ge084_aguarde w_ge084_aguarde

type variables
Boolean ivb_Cancelar = False
end variables

forward prototypes
public subroutine wf_mensagem (string ps_mensagem)
end prototypes

public subroutine wf_mensagem (string ps_mensagem);mle_1.Text = ps_mensagem
end subroutine

on w_ge084_aguarde.create
this.st_msg=create st_msg
this.cb_cancelar=create cb_cancelar
this.mle_2=create mle_2
this.mle_1=create mle_1
this.gb_1=create gb_1
this.Control[]={this.st_msg,&
this.cb_cancelar,&
this.mle_2,&
this.mle_1,&
this.gb_1}
end on

on w_ge084_aguarde.destroy
destroy(this.st_msg)
destroy(this.cb_cancelar)
destroy(this.mle_2)
destroy(this.mle_1)
destroy(this.gb_1)
end on

type st_msg from statictext within w_ge084_aguarde
integer x = 41
integer y = 304
integer width = 1806
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_ge084_aguarde
integer x = 27
integer y = 456
integer width = 370
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Cancelar"
boolean default = true
end type

event clicked;ivb_Cancelar = True
end event

type mle_2 from multilineedit within w_ge084_aguarde
integer x = 41
integer y = 176
integer width = 1806
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "... Favor Aguardar ..."
boolean border = false
alignment alignment = center!
boolean displayonly = true
end type

type mle_1 from multilineedit within w_ge084_aguarde
integer x = 64
integer y = 80
integer width = 1733
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HourGlass!"
long textcolor = 128
long backcolor = 80269524
boolean border = false
alignment alignment = center!
boolean displayonly = true
end type

type gb_1 from groupbox within w_ge084_aguarde
integer x = 32
integer y = 4
integer width = 1824
integer height = 288
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

