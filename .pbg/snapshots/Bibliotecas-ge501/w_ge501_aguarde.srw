HA$PBExportHeader$w_ge501_aguarde.srw
forward
global type w_ge501_aguarde from window
end type
type st_msg from statictext within w_ge501_aguarde
end type
type uo_progress from uo_progressbar within w_ge501_aguarde
end type
end forward

global type w_ge501_aguarde from window
integer x = 974
integer y = 1228
integer width = 1865
integer height = 456
boolean titlebar = true
string title = "Aguarde ..."
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
boolean center = true
st_msg st_msg
uo_progress uo_progress
end type
global w_ge501_aguarde w_ge501_aguarde

on w_ge501_aguarde.create
this.st_msg=create st_msg
this.uo_progress=create uo_progress
this.Control[]={this.st_msg,&
this.uo_progress}
end on

on w_ge501_aguarde.destroy
destroy(this.st_msg)
destroy(this.uo_progress)
end on

type st_msg from statictext within w_ge501_aguarde
integer x = 69
integer y = 252
integer width = 1691
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type uo_progress from uo_progressbar within w_ge501_aguarde
integer x = 37
integer y = 44
integer height = 200
integer taborder = 10
boolean border = false
long backcolor = 79741120
end type

on uo_progress.destroy
call uo_progressbar::destroy
end on

event ue_atualiza_tela;call super::ue_atualiza_tela;Yield()
SetRedraw(True)
end event

