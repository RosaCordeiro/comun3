HA$PBExportHeader$w_ge084_numero_autorizacao.srw
forward
global type w_ge084_numero_autorizacao from window
end type
type em_1 from editmask within w_ge084_numero_autorizacao
end type
type st_titulo1 from statictext within w_ge084_numero_autorizacao
end type
type cb_confirmar from commandbutton within w_ge084_numero_autorizacao
end type
type cb_cancelar from commandbutton within w_ge084_numero_autorizacao
end type
type gb_1 from groupbox within w_ge084_numero_autorizacao
end type
end forward

global type w_ge084_numero_autorizacao from window
integer x = 741
integer y = 932
integer width = 1339
integer height = 596
boolean titlebar = true
string title = "Transa$$HEX2$$e700e300$$ENDHEX$$o TEF"
windowtype windowtype = response!
long backcolor = 80269524
em_1 em_1
st_titulo1 st_titulo1
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge084_numero_autorizacao w_ge084_numero_autorizacao

type variables
Long Campo
Long TamanhoMinimo
Long TamanhoMaximo
end variables

on w_ge084_numero_autorizacao.create
this.em_1=create em_1
this.st_titulo1=create st_titulo1
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.gb_1=create gb_1
this.Control[]={this.em_1,&
this.st_titulo1,&
this.cb_confirmar,&
this.cb_cancelar,&
this.gb_1}
end on

on w_ge084_numero_autorizacao.destroy
destroy(this.em_1)
destroy(this.st_titulo1)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.gb_1)
end on

event open;
st_Titulo1.Text = Message.StringParm

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

This.TamanhoMinimo = 0
This.TamanhoMaximo = 12

This.Show()

gf_Ativa_Janela(This)



end event

type em_1 from editmask within w_ge084_numero_autorizacao
integer x = 82
integer y = 176
integer width = 1147
integer height = 100
integer taborder = 10
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "############"
end type

type st_titulo1 from statictext within w_ge084_numero_autorizacao
integer x = 37
integer y = 24
integer width = 1239
integer height = 72
integer textsize = -10
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

type cb_confirmar from commandbutton within w_ge084_numero_autorizacao
integer x = 910
integer y = 352
integer width = 370
integer height = 108
integer taborder = 20
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

ls_Campo = Trim(em_1.Text)

If LenA(ls_Campo) < Parent.TamanhoMinimo Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados informados s$$HEX1$$e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lidos (m$$HEX1$$ed00$$ENDHEX$$nimo " + String(Parent.TamanhoMinimo) + " posi$$HEX2$$e700f500$$ENDHEX$$es).",Exclamation!)
	Return
End If	

If LenA(ls_Campo) > Parent.TamanhoMaximo Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados informados s$$HEX1$$e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lidos (m$$HEX1$$e100$$ENDHEX$$ximo " + String(Parent.TamanhoMinimo) + " posi$$HEX2$$e700f500$$ENDHEX$$es).",Exclamation!)
	Return
End If	

CloseWithReturn(Parent,ls_Campo)
end event

event getfocus;This.Weight  = 700

end event

event losefocus;This.Weight  = 400
end event

type cb_cancelar from commandbutton within w_ge084_numero_autorizacao
integer x = 521
integer y = 352
integer width = 370
integer height = 108
integer taborder = 10
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

type gb_1 from groupbox within w_ge084_numero_autorizacao
integer x = 37
integer y = 80
integer width = 1239
integer height = 252
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

