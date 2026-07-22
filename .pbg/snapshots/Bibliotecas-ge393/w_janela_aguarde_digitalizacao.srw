HA$PBExportHeader$w_janela_aguarde_digitalizacao.srw
forward
global type w_janela_aguarde_digitalizacao from window
end type
type mle_1 from multilineedit within w_janela_aguarde_digitalizacao
end type
type mle_2 from multilineedit within w_janela_aguarde_digitalizacao
end type
type gb_1 from groupbox within w_janela_aguarde_digitalizacao
end type
end forward

global type w_janela_aguarde_digitalizacao from window
integer x = 1134
integer y = 1016
integer width = 1262
integer height = 360
boolean enabled = false
windowtype windowtype = popup!
long backcolor = 79741120
boolean center = true
mle_1 mle_1
mle_2 mle_2
gb_1 gb_1
end type
global w_janela_aguarde_digitalizacao w_janela_aguarde_digitalizacao

forward prototypes
public subroutine wf_mensagem (string ps_mensagem)
end prototypes

public subroutine wf_mensagem (string ps_mensagem);mle_1.Text = UPPER(ps_mensagem)

SetRedraw(True)
Yield()
end subroutine

on w_janela_aguarde_digitalizacao.create
this.mle_1=create mle_1
this.mle_2=create mle_2
this.gb_1=create gb_1
this.Control[]={this.mle_1,&
this.mle_2,&
this.gb_1}
end on

on w_janela_aguarde_digitalizacao.destroy
destroy(this.mle_1)
destroy(this.mle_2)
destroy(this.gb_1)
end on

type mle_1 from multilineedit within w_janela_aguarde_digitalizacao
integer x = 73
integer y = 64
integer width = 1097
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HourGlass!"
long textcolor = 8388608
long backcolor = 79741120
boolean border = false
alignment alignment = center!
boolean displayonly = true
end type

type mle_2 from multilineedit within w_janela_aguarde_digitalizacao
integer x = 73
integer y = 164
integer width = 1097
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HourGlass!"
long textcolor = 8388608
long backcolor = 79741120
string text = "... Favor Aguardar ..."
boolean border = false
alignment alignment = center!
boolean displayonly = true
end type

type gb_1 from groupbox within w_janela_aguarde_digitalizacao
integer x = 37
integer width = 1170
integer height = 316
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

