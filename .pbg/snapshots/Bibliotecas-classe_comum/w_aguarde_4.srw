HA$PBExportHeader$w_aguarde_4.srw
forward
global type w_aguarde_4 from window
end type
type st_processo from statictext within w_aguarde_4
end type
type uo_progress from uo_progressbar within w_aguarde_4
end type
type gb_1 from groupbox within w_aguarde_4
end type
end forward

global type w_aguarde_4 from window
integer x = 901
integer y = 600
integer width = 1865
integer height = 496
boolean titlebar = true
string title = "Atualizando Estoque Base das Filiais..."
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
st_processo st_processo
uo_progress uo_progress
gb_1 gb_1
end type
global w_aguarde_4 w_aguarde_4

on w_aguarde_4.create
this.st_processo=create st_processo
this.uo_progress=create uo_progress
this.gb_1=create gb_1
this.Control[]={this.st_processo,&
this.uo_progress,&
this.gb_1}
end on

on w_aguarde_4.destroy
destroy(this.st_processo)
destroy(this.uo_progress)
destroy(this.gb_1)
end on

type st_processo from statictext within w_aguarde_4
integer x = 59
integer y = 64
integer width = 1723
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Processo:"
boolean focusrectangle = false
end type

type uo_progress from uo_progressbar within w_aguarde_4
integer x = 37
integer y = 152
integer width = 1769
integer height = 188
integer taborder = 10
boolean border = false
long backcolor = 79741120
end type

on uo_progress.destroy
call uo_progressbar::destroy
end on

type gb_1 from groupbox within w_aguarde_4
integer x = 18
integer width = 1806
integer height = 380
integer taborder = 20
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

