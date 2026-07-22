HA$PBExportHeader$w_aguarde_2.srw
forward
global type w_aguarde_2 from window
end type
type uo_progress from uo_progressbar within w_aguarde_2
end type
end forward

global type w_aguarde_2 from window
integer x = 974
integer y = 1228
integer width = 1865
integer height = 368
boolean titlebar = true
string title = "Aguarde ..."
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
boolean center = true
uo_progress uo_progress
end type
global w_aguarde_2 w_aguarde_2

on w_aguarde_2.create
this.uo_progress=create uo_progress
this.Control[]={this.uo_progress}
end on

on w_aguarde_2.destroy
destroy(this.uo_progress)
end on

type uo_progress from uo_progressbar within w_aguarde_2
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

event dragdrop;call super::dragdrop;Yield()
end event

