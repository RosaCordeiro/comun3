HA$PBExportHeader$w_ge112_mostra_mensagem.srw
forward
global type w_ge112_mostra_mensagem from Window
end type
type cb_confirmar from commandbutton within w_ge112_mostra_mensagem
end type
type mle_1 from multilineedit within w_ge112_mostra_mensagem
end type
type gb_1 from groupbox within w_ge112_mostra_mensagem
end type
end forward

global type w_ge112_mostra_mensagem from Window
int X=1326
int Y=868
int Width=2057
int Height=1356
boolean TitleBar=true
string Title="TEF - Mensagem ao operador"
long BackColor=80269524
WindowType WindowType=response!
cb_confirmar cb_confirmar
mle_1 mle_1
gb_1 gb_1
end type
global w_ge112_mostra_mensagem w_ge112_mostra_mensagem

on w_ge112_mostra_mensagem.create
this.cb_confirmar=create cb_confirmar
this.mle_1=create mle_1
this.gb_1=create gb_1
this.Control[]={this.cb_confirmar,&
this.mle_1,&
this.gb_1}
end on

on w_ge112_mostra_mensagem.destroy
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

type cb_confirmar from commandbutton within w_ge112_mostra_mensagem
int X=1563
int Y=1096
int Width=439
int Height=108
int TabOrder=10
string Text="&Ok"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;This.Weight  = 700
This.Default = True
end event

event losefocus;This.Weight  = 400
This.Default = False
end event

event clicked;Close(Parent)
end event

type mle_1 from multilineedit within w_ge112_mostra_mensagem
int X=69
int Y=56
int Width=1906
int Height=996
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean AutoVScroll=true
boolean HideSelection=false
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Courier New"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type gb_1 from groupbox within w_ge112_mostra_mensagem
int X=37
int Width=1966
int Height=1080
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=80269524
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

