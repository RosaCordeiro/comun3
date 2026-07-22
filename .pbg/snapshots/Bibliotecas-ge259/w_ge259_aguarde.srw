HA$PBExportHeader$w_ge259_aguarde.srw
forward
global type w_ge259_aguarde from window
end type
type st_processo from statictext within w_ge259_aguarde
end type
type st_1 from statictext within w_ge259_aguarde
end type
type uo_progress from uo_progressbar within w_ge259_aguarde
end type
type gb_1 from groupbox within w_ge259_aguarde
end type
end forward

global type w_ge259_aguarde from window
integer x = 974
integer y = 1228
integer width = 1893
integer height = 520
boolean titlebar = true
string title = "Aguarde ..."
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
st_processo st_processo
st_1 st_1
uo_progress uo_progress
gb_1 gb_1
end type
global w_ge259_aguarde w_ge259_aguarde

on w_ge259_aguarde.create
this.st_processo=create st_processo
this.st_1=create st_1
this.uo_progress=create uo_progress
this.gb_1=create gb_1
this.Control[]={this.st_processo,&
this.st_1,&
this.uo_progress,&
this.gb_1}
end on

on w_ge259_aguarde.destroy
destroy(this.st_processo)
destroy(this.st_1)
destroy(this.uo_progress)
destroy(this.gb_1)
end on

type st_processo from statictext within w_ge259_aguarde
integer x = 379
integer y = 68
integer width = 1408
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ge259_aguarde
integer x = 73
integer y = 68
integer width = 302
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Processo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_progress from uo_progressbar within w_ge259_aguarde
integer x = 50
integer y = 188
integer height = 200
integer taborder = 10
boolean border = false
long backcolor = 79741120
end type

on uo_progress.destroy
call uo_progressbar::destroy
end on

type gb_1 from groupbox within w_ge259_aguarde
integer x = 32
integer y = 4
integer width = 1810
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

