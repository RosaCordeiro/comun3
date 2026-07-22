HA$PBExportHeader$w_ge112_numero_autorizacao.srw
forward
global type w_ge112_numero_autorizacao from Window
end type
type em_1 from editmask within w_ge112_numero_autorizacao
end type
type st_titulo1 from statictext within w_ge112_numero_autorizacao
end type
type cb_confirmar from commandbutton within w_ge112_numero_autorizacao
end type
type cb_cancelar from commandbutton within w_ge112_numero_autorizacao
end type
type gb_1 from groupbox within w_ge112_numero_autorizacao
end type
end forward

global type w_ge112_numero_autorizacao from Window
int X=741
int Y=932
int Width=1339
int Height=596
boolean TitleBar=true
string Title="Transa$$HEX2$$e700e300$$ENDHEX$$o TEF"
long BackColor=80269524
WindowType WindowType=response!
em_1 em_1
st_titulo1 st_titulo1
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge112_numero_autorizacao w_ge112_numero_autorizacao

type variables
Long Campo
Long TamanhoMinimo
Long TamanhoMaximo
end variables

on w_ge112_numero_autorizacao.create
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

on w_ge112_numero_autorizacao.destroy
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

type em_1 from editmask within w_ge112_numero_autorizacao
int X=82
int Y=176
int Width=1147
int Height=100
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="############"
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
int TextSize=-13
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_titulo1 from statictext within w_ge112_numero_autorizacao
int X=37
int Y=24
int Width=1239
int Height=72
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_confirmar from commandbutton within w_ge112_numero_autorizacao
int X=910
int Y=352
int Width=370
int Height=108
int TabOrder=20
string Text="&Confirmar"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type cb_cancelar from commandbutton within w_ge112_numero_autorizacao
int X=521
int Y=352
int Width=370
int Height=108
int TabOrder=10
string Text="C&ancelar"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent,'CANCELAR')
end event

event getfocus;This.Weight  = 700
end event

event losefocus;This.Weight  = 400
end event

type gb_1 from groupbox within w_ge112_numero_autorizacao
int X=37
int Y=80
int Width=1239
int Height=252
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

