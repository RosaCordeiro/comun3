HA$PBExportHeader$w_ge084_coleta_campo_senha.srw
forward
global type w_ge084_coleta_campo_senha from window
end type
type em_1 from singlelineedit within w_ge084_coleta_campo_senha
end type
type st_titulo3 from statictext within w_ge084_coleta_campo_senha
end type
type st_titulo2 from statictext within w_ge084_coleta_campo_senha
end type
type st_titulo1 from statictext within w_ge084_coleta_campo_senha
end type
type cb_voltar from commandbutton within w_ge084_coleta_campo_senha
end type
type cb_confirmar from commandbutton within w_ge084_coleta_campo_senha
end type
type cb_cancelar from commandbutton within w_ge084_coleta_campo_senha
end type
type gb_1 from groupbox within w_ge084_coleta_campo_senha
end type
end forward

global type w_ge084_coleta_campo_senha from window
integer x = 1294
integer y = 1156
integer width = 2149
integer height = 804
boolean titlebar = true
string title = "Transa$$HEX2$$e700e300$$ENDHEX$$o TEF"
windowtype windowtype = response!
long backcolor = 80269524
em_1 em_1
st_titulo3 st_titulo3
st_titulo2 st_titulo2
st_titulo1 st_titulo1
cb_voltar cb_voltar
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge084_coleta_campo_senha w_ge084_coleta_campo_senha

type variables

end variables

forward prototypes
public subroutine wf_titulo (string ps_titulo)
end prototypes

public subroutine wf_titulo (string ps_titulo);
String ls_titulo

Long   ll_Pos    = 0
Long   ll_Titulo = 1

For ll_Pos = 1 To LenA(ps_titulo)
	
	If MidA(ps_titulo,ll_Pos,1) <> CharA(10) Then
		ls_Titulo += Upper(MidA(ps_titulo,ll_Pos,1))
	End If	
		
	If MidA(ps_titulo,ll_Pos,1) = CharA(10) or ll_Pos = LenA(ps_Titulo) Then	

		Choose Case ll_Titulo
			Case 1				
				st_titulo1.text = ls_titulo
			Case 2
				st_titulo2.text = ls_titulo
			Case 3	
				st_titulo3.text = ls_titulo
		End Choose
		
		ll_Titulo ++
		ls_Titulo = ''
		
	End If
	
Next
end subroutine

on w_ge084_coleta_campo_senha.create
this.em_1=create em_1
this.st_titulo3=create st_titulo3
this.st_titulo2=create st_titulo2
this.st_titulo1=create st_titulo1
this.cb_voltar=create cb_voltar
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.gb_1=create gb_1
this.Control[]={this.em_1,&
this.st_titulo3,&
this.st_titulo2,&
this.st_titulo1,&
this.cb_voltar,&
this.cb_confirmar,&
this.cb_cancelar,&
this.gb_1}
end on

on w_ge084_coleta_campo_senha.destroy
destroy(this.em_1)
destroy(this.st_titulo3)
destroy(this.st_titulo2)
destroy(this.st_titulo1)
destroy(this.cb_voltar)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.gb_1)
end on

event open;
String ls_Titulo

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

ls_Titulo  = MidA(Message.StringParm,50)

Wf_Titulo(ls_Titulo)

This.Show()

gf_Ativa_Janela(This)

em_1.SetFocus()
end event

type em_1 from singlelineedit within w_ge084_coleta_campo_senha
integer x = 87
integer y = 364
integer width = 1979
integer height = 112
integer taborder = 20
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type st_titulo3 from statictext within w_ge084_coleta_campo_senha
integer x = 41
integer y = 148
integer width = 2053
integer height = 60
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_titulo2 from statictext within w_ge084_coleta_campo_senha
integer x = 41
integer y = 80
integer width = 2053
integer height = 60
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_titulo1 from statictext within w_ge084_coleta_campo_senha
integer x = 41
integer y = 12
integer width = 2053
integer height = 60
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type cb_voltar from commandbutton within w_ge084_coleta_campo_senha
integer x = 50
integer y = 544
integer width = 370
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Voltar"
end type

event clicked;CloseWithReturn(Parent,'VOLTAR')
end event

event getfocus;This.Weight  = 700
end event

event losefocus;This.Weight  = 400
end event

type cb_confirmar from commandbutton within w_ge084_coleta_campo_senha
integer x = 1723
integer y = 544
integer width = 370
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar"
boolean default = true
end type

event clicked;String ls_Campo

ls_Campo = em_1.text

If IsNull(ls_Campo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados solicitados.",Exclamation!)
	em_1.SetFocus()
	Return
End If	

If ls_Campo <> '13918' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$digo do Supervisor Inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
	em_1.SetFocus()
	Return
End If

CloseWithReturn(Parent,ls_Campo)
end event

event getfocus;This.Weight  = 700

end event

event losefocus;This.Weight  = 400
end event

type cb_cancelar from commandbutton within w_ge084_coleta_campo_senha
integer x = 1335
integer y = 544
integer width = 370
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "C&ancelar"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,'CANCELAR')
end event

event getfocus;This.Weight  = 700
end event

event losefocus;This.Weight  = 400
end event

type gb_1 from groupbox within w_ge084_coleta_campo_senha
integer x = 41
integer y = 216
integer width = 2053
integer height = 304
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

