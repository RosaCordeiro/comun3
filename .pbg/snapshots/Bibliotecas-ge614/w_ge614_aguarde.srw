HA$PBExportHeader$w_ge614_aguarde.srw
forward
global type w_ge614_aguarde from window
end type
type st_ftp from statictext within w_ge614_aguarde
end type
type st_notas from statictext within w_ge614_aguarde
end type
type st_filial from statictext within w_ge614_aguarde
end type
type st_fornecedor from statictext within w_ge614_aguarde
end type
type uo_progress_3 from uo_progressbar within w_ge614_aguarde
end type
type uo_progress_2 from uo_progressbar within w_ge614_aguarde
end type
type uo_progress_1 from uo_progressbar within w_ge614_aguarde
end type
end forward

global type w_ge614_aguarde from window
integer x = 974
integer y = 1228
integer width = 1865
integer height = 1040
boolean titlebar = true
string title = "Aguarde ... Manifesta$$HEX2$$e700e300$$ENDHEX$$o do Destinat$$HEX1$$e100$$ENDHEX$$rio."
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
st_ftp st_ftp
st_notas st_notas
st_filial st_filial
st_fornecedor st_fornecedor
uo_progress_3 uo_progress_3
uo_progress_2 uo_progress_2
uo_progress_1 uo_progress_1
end type
global w_ge614_aguarde w_ge614_aguarde

type variables


end variables

on w_ge614_aguarde.create
this.st_ftp=create st_ftp
this.st_notas=create st_notas
this.st_filial=create st_filial
this.st_fornecedor=create st_fornecedor
this.uo_progress_3=create uo_progress_3
this.uo_progress_2=create uo_progress_2
this.uo_progress_1=create uo_progress_1
this.Control[]={this.st_ftp,&
this.st_notas,&
this.st_filial,&
this.st_fornecedor,&
this.uo_progress_3,&
this.uo_progress_2,&
this.uo_progress_1}
end on

on w_ge614_aguarde.destroy
destroy(this.st_ftp)
destroy(this.st_notas)
destroy(this.st_filial)
destroy(this.st_fornecedor)
destroy(this.uo_progress_3)
destroy(this.uo_progress_2)
destroy(this.uo_progress_1)
end on

type st_ftp from statictext within w_ge614_aguarde
integer x = 73
integer y = 836
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

type st_notas from statictext within w_ge614_aguarde
integer x = 73
integer y = 528
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

type st_filial from statictext within w_ge614_aguarde
integer x = 73
integer y = 276
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

type st_fornecedor from statictext within w_ge614_aguarde
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

type uo_progress_3 from uo_progressbar within w_ge614_aguarde
integer x = 37
integer y = 576
integer height = 200
integer taborder = 30
boolean border = false
end type

on uo_progress_3.destroy
call uo_progressbar::destroy
end on

event ue_atualiza_tela;call super::ue_atualiza_tela;
Yield()
end event

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

type uo_progress_2 from uo_progressbar within w_ge614_aguarde
integer x = 37
integer y = 324
integer height = 200
integer taborder = 20
boolean border = false
end type

on uo_progress_2.destroy
call uo_progressbar::destroy
end on

event ue_atualiza_tela;call super::ue_atualiza_tela;Yield()
end event

event dragdrop;call super::dragdrop;Yield()
end event

type uo_progress_1 from uo_progressbar within w_ge614_aguarde
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

