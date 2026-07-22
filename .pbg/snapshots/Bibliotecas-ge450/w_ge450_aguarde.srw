HA$PBExportHeader$w_ge450_aguarde.srw
forward
global type w_ge450_aguarde from window
end type
type st_processo from statictext within w_ge450_aguarde
end type
type st_calculo from statictext within w_ge450_aguarde
end type
type uo_progress from uo_progressbar within w_ge450_aguarde
end type
type gb_1 from groupbox within w_ge450_aguarde
end type
end forward

global type w_ge450_aguarde from window
integer x = 901
integer y = 600
integer width = 1865
integer height = 592
boolean titlebar = true
string title = "C$$HEX1$$e100$$ENDHEX$$lculo Precifica$$HEX2$$e700e300$$ENDHEX$$o..."
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
st_processo st_processo
st_calculo st_calculo
uo_progress uo_progress
gb_1 gb_1
end type
global w_ge450_aguarde w_ge450_aguarde

on w_ge450_aguarde.create
this.st_processo=create st_processo
this.st_calculo=create st_calculo
this.uo_progress=create uo_progress
this.gb_1=create gb_1
this.Control[]={this.st_processo,&
this.st_calculo,&
this.uo_progress,&
this.gb_1}
end on

on w_ge450_aguarde.destroy
destroy(this.st_processo)
destroy(this.st_calculo)
destroy(this.uo_progress)
destroy(this.gb_1)
end on

type st_processo from statictext within w_ge450_aguarde
integer x = 59
integer y = 160
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

type st_calculo from statictext within w_ge450_aguarde
integer x = 59
integer y = 72
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
string text = "C$$HEX1$$e100$$ENDHEX$$lculo:"
boolean focusrectangle = false
end type

type uo_progress from uo_progressbar within w_ge450_aguarde
integer x = 37
integer y = 256
integer width = 1769
integer height = 188
integer taborder = 10
boolean border = false
long backcolor = 79741120
end type

on uo_progress.destroy
call uo_progressbar::destroy
end on

event ue_atualiza_tela;call super::ue_atualiza_tela;Yield()
end event

type gb_1 from groupbox within w_ge450_aguarde
integer x = 18
integer width = 1806
integer height = 476
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

