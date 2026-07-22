HA$PBExportHeader$w_ge130_aguarde.srw
forward
global type w_ge130_aguarde from window
end type
type st_message_1 from statictext within w_ge130_aguarde
end type
type st_message_2 from statictext within w_ge130_aguarde
end type
type uo_progress_2 from uo_progressbar within w_ge130_aguarde
end type
type uo_progress_1 from uo_progressbar within w_ge130_aguarde
end type
end forward

global type w_ge130_aguarde from window
integer width = 1870
integer height = 776
boolean titlebar = true
string title = "Aguarde..."
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_message_1 st_message_1
st_message_2 st_message_2
uo_progress_2 uo_progress_2
uo_progress_1 uo_progress_1
end type
global w_ge130_aguarde w_ge130_aguarde

on w_ge130_aguarde.create
this.st_message_1=create st_message_1
this.st_message_2=create st_message_2
this.uo_progress_2=create uo_progress_2
this.uo_progress_1=create uo_progress_1
this.Control[]={this.st_message_1,&
this.st_message_2,&
this.uo_progress_2,&
this.uo_progress_1}
end on

on w_ge130_aguarde.destroy
destroy(this.st_message_1)
destroy(this.st_message_2)
destroy(this.uo_progress_2)
destroy(this.uo_progress_1)
end on

type st_message_1 from statictext within w_ge130_aguarde
integer x = 41
integer y = 32
integer width = 1778
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_message_2 from statictext within w_ge130_aguarde
integer x = 41
integer y = 368
integer width = 1778
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_progress_2 from uo_progressbar within w_ge130_aguarde
integer x = 46
integer y = 448
integer taborder = 20
boolean border = false
end type

on uo_progress_2.destroy
call uo_progressbar::destroy
end on

type uo_progress_1 from uo_progressbar within w_ge130_aguarde
integer x = 41
integer y = 104
integer taborder = 10
boolean border = false
end type

on uo_progress_1.destroy
call uo_progressbar::destroy
end on

