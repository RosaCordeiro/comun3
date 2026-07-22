HA$PBExportHeader$w_ge488_aguarde.srw
forward
global type w_ge488_aguarde from window
end type
type uo_progress_2 from uo_progressbar within w_ge488_aguarde
end type
type st_itens from statictext within w_ge488_aguarde
end type
type st_notas from statictext within w_ge488_aguarde
end type
type uo_progress_1 from uo_progressbar within w_ge488_aguarde
end type
end forward

global type w_ge488_aguarde from window
integer x = 974
integer y = 1228
integer width = 1865
integer height = 644
boolean titlebar = true
string title = "Aguarde ... Manifesta$$HEX2$$e700e300$$ENDHEX$$o do Destinat$$HEX1$$e100$$ENDHEX$$rio."
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
uo_progress_2 uo_progress_2
st_itens st_itens
st_notas st_notas
uo_progress_1 uo_progress_1
end type
global w_ge488_aguarde w_ge488_aguarde

type variables


end variables

on w_ge488_aguarde.create
this.uo_progress_2=create uo_progress_2
this.st_itens=create st_itens
this.st_notas=create st_notas
this.uo_progress_1=create uo_progress_1
this.Control[]={this.uo_progress_2,&
this.st_itens,&
this.st_notas,&
this.uo_progress_1}
end on

on w_ge488_aguarde.destroy
destroy(this.uo_progress_2)
destroy(this.st_itens)
destroy(this.st_notas)
destroy(this.uo_progress_1)
end on

type uo_progress_2 from uo_progressbar within w_ge488_aguarde
integer x = 37
integer y = 340
integer height = 188
integer taborder = 10
boolean border = false
long backcolor = 79741120
end type

event dragdrop;call super::dragdrop;Yield()
end event

event dragenter;call super::dragenter;Yield()
end event

event dragleave;call super::dragleave;Yield()
end event

event dragwithin;call super::dragwithin;Yield()
end event

event other;call super::other;Yield()
end event

event rbuttondown;call super::rbuttondown;Yield()
end event

event ue_atualiza_tela;call super::ue_atualiza_tela;Yield()
end event

on uo_progress_2.destroy
call uo_progressbar::destroy
end on

type st_itens from statictext within w_ge488_aguarde
integer x = 73
integer y = 292
integer width = 1742
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_notas from statictext within w_ge488_aguarde
integer x = 73
integer y = 36
integer width = 1742
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type uo_progress_1 from uo_progressbar within w_ge488_aguarde
integer x = 37
integer y = 84
integer height = 188
integer taborder = 10
boolean border = false
long backcolor = 79741120
end type

on uo_progress_1.destroy
call uo_progressbar::destroy
end on

event ue_atualiza_tela;call super::ue_atualiza_tela;Yield()
end event

event dragdrop;call super::dragdrop;Yield()
end event

event dragenter;call super::dragenter;Yield()
end event

event dragleave;call super::dragleave;Yield()
end event

event dragwithin;call super::dragwithin;Yield()
end event

event rbuttondown;call super::rbuttondown;Yield()
end event

event other;call super::other;Yield()
end event

