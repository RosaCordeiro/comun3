HA$PBExportHeader$w_ge084_processando.srw
forward
global type w_ge084_processando from window
end type
type st_msg from statictext within w_ge084_processando
end type
type mle_1 from statictext within w_ge084_processando
end type
type st_1 from statictext within w_ge084_processando
end type
type gb_1 from groupbox within w_ge084_processando
end type
end forward

global type w_ge084_processando from window
integer x = 887
integer y = 980
integer width = 1902
integer height = 440
windowtype windowtype = popup!
long backcolor = 80269524
st_msg st_msg
mle_1 mle_1
st_1 st_1
gb_1 gb_1
end type
global w_ge084_processando w_ge084_processando

on w_ge084_processando.create
this.st_msg=create st_msg
this.mle_1=create mle_1
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.st_msg,&
this.mle_1,&
this.st_1,&
this.gb_1}
end on

on w_ge084_processando.destroy
destroy(this.st_msg)
destroy(this.mle_1)
destroy(this.st_1)
destroy(this.gb_1)
end on

type st_msg from statictext within w_ge084_processando
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

type mle_1 from statictext within w_ge084_processando
integer x = 41
integer y = 68
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
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_ge084_processando
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
boolean enabled = false
string text = "... Favor Aguardar ..."
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ge084_processando
integer x = 32
integer y = 4
integer width = 1824
integer height = 288
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

