HA$PBExportHeader$w_ge084_mostra_mensagem.srw
forward
global type w_ge084_mostra_mensagem from window
end type
type cb_confirmar from commandbutton within w_ge084_mostra_mensagem
end type
type mle_1 from multilineedit within w_ge084_mostra_mensagem
end type
type gb_1 from groupbox within w_ge084_mostra_mensagem
end type
end forward

global type w_ge084_mostra_mensagem from window
integer x = 1326
integer y = 868
integer width = 2057
integer height = 1356
boolean titlebar = true
string title = "TEF - Mensagem ao operador"
windowtype windowtype = response!
long backcolor = 80269524
cb_confirmar cb_confirmar
mle_1 mle_1
gb_1 gb_1
end type
global w_ge084_mostra_mensagem w_ge084_mostra_mensagem

on w_ge084_mostra_mensagem.create
this.cb_confirmar=create cb_confirmar
this.mle_1=create mle_1
this.gb_1=create gb_1
this.Control[]={this.cb_confirmar,&
this.mle_1,&
this.gb_1}
end on

on w_ge084_mostra_mensagem.destroy
destroy(this.cb_confirmar)
destroy(this.mle_1)
destroy(this.gb_1)
end on

event open;
String  ls_Mensagem
String  ls_Temp

Integer li_Byte

SetPointer(HourGlass!)

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

ls_Mensagem = Message.StringParm

//Retira Caracteres inv$$HEX1$$e100$$ENDHEX$$lidos e ajusta salto de linhas
For li_Byte = 1 To LenA(ls_Mensagem)
	If MidA(ls_Mensagem,li_Byte,1) = CharA(10) Then
		ls_Temp += CharA(13) + CharA(10)
	Else	
		ls_Temp += MidA(ls_Mensagem,li_Byte,1)
	End If
Next

mle_1.Text = ls_Temp

SetPointer(Arrow!)

cb_confirmar.SetFocus()

end event

event closequery;
IF KeyDown(KeyAlt!) and KeyDown(KeyF4!) Then Return 1


	
	
end event

type cb_confirmar from commandbutton within w_ge084_mostra_mensagem
integer x = 1563
integer y = 1096
integer width = 439
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Ok"
boolean default = true
end type

event getfocus;This.Weight  = 700
This.Default = True
end event

event losefocus;This.Weight  = 400
This.Default = False
end event

event clicked;Close(Parent)
end event

type mle_1 from multilineedit within w_ge084_mostra_mensagem
integer x = 69
integer y = 56
integer width = 1906
integer height = 996
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type gb_1 from groupbox within w_ge084_mostra_mensagem
integer x = 37
integer width = 1966
integer height = 1080
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 80269524
borderstyle borderstyle = styleraised!
end type

