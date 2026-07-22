HA$PBExportHeader$w_aguarde_3.srw
forward
global type w_aguarde_3 from window
end type
type st_8 from statictext within w_aguarde_3
end type
type st_7 from statictext within w_aguarde_3
end type
type st_6 from statictext within w_aguarde_3
end type
type st_5 from statictext within w_aguarde_3
end type
type st_2 from statictext within w_aguarde_3
end type
type st_4 from statictext within w_aguarde_3
end type
type st_3 from statictext within w_aguarde_3
end type
type st_1 from statictext within w_aguarde_3
end type
type uo_progress_2 from uo_progressbar within w_aguarde_3
end type
type uo_progress from uo_progressbar within w_aguarde_3
end type
end forward

global type w_aguarde_3 from window
integer x = 974
integer y = 1228
integer width = 1856
integer height = 820
boolean titlebar = true
string title = "Aguarde ..."
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
boolean center = true
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_2 st_2
st_4 st_4
st_3 st_3
st_1 st_1
uo_progress_2 uo_progress_2
uo_progress uo_progress
end type
global w_aguarde_3 w_aguarde_3

forward prototypes
public subroutine wf_settext (string ps_texto, integer pl_numero)
end prototypes

public subroutine wf_settext (string ps_texto, integer pl_numero);Choose Case pl_numero
	Case 1 
		st_1.text = ps_texto
	Case 2
		st_2.text = ps_texto
	Case 3
		st_3.text = ps_texto	
	Case 4
		st_4.text = ps_texto	
End Choose
end subroutine

on w_aguarde_3.create
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_2=create st_2
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.uo_progress_2=create uo_progress_2
this.uo_progress=create uo_progress
this.Control[]={this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_2,&
this.st_4,&
this.st_3,&
this.st_1,&
this.uo_progress_2,&
this.uo_progress}
end on

on w_aguarde_3.destroy
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.uo_progress_2)
destroy(this.uo_progress)
end on

type st_8 from statictext within w_aguarde_3
boolean visible = false
integer x = 14
integer y = 452
integer width = 55
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "4"
boolean focusrectangle = false
end type

type st_7 from statictext within w_aguarde_3
boolean visible = false
integer x = 14
integer y = 392
integer width = 55
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "3"
boolean focusrectangle = false
end type

type st_6 from statictext within w_aguarde_3
boolean visible = false
integer x = 14
integer y = 104
integer width = 55
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "2"
boolean focusrectangle = false
end type

type st_5 from statictext within w_aguarde_3
boolean visible = false
integer x = 14
integer y = 60
integer width = 55
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "1"
boolean focusrectangle = false
end type

type st_2 from statictext within w_aguarde_3
integer x = 78
integer y = 104
integer width = 1733
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_4 from statictext within w_aguarde_3
integer x = 78
integer y = 440
integer width = 1733
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_3 from statictext within w_aguarde_3
integer x = 78
integer y = 380
integer width = 1733
integer height = 52
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

type st_1 from statictext within w_aguarde_3
integer x = 78
integer y = 48
integer width = 1742
integer height = 52
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

type uo_progress_2 from uo_progressbar within w_aguarde_3
integer x = 41
integer y = 488
integer width = 1746
integer height = 200
integer taborder = 20
boolean border = false
end type

on uo_progress_2.destroy
call uo_progressbar::destroy
end on

event ue_atualiza_tela;call super::ue_atualiza_tela;yield()
end event

event ue_reset;call super::ue_reset;st_3.text = ''
st_4.text = ''
end event

type uo_progress from uo_progressbar within w_aguarde_3
integer x = 41
integer y = 156
integer width = 1746
integer height = 200
integer taborder = 10
boolean border = false
long backcolor = 79741120
end type

on uo_progress.destroy
call uo_progressbar::destroy
end on

event ue_atualiza_tela;call super::ue_atualiza_tela;Yield()
end event

event ue_reset;call super::ue_reset;st_1.text = ''
st_2.text = ''
end event

