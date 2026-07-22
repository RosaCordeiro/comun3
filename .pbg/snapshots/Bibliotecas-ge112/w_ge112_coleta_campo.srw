HA$PBExportHeader$w_ge112_coleta_campo.srw
forward
global type w_ge112_coleta_campo from Window
end type
type cb_voltar from commandbutton within w_ge112_coleta_campo
end type
type em_1 from editmask within w_ge112_coleta_campo
end type
type cb_confirmar from commandbutton within w_ge112_coleta_campo
end type
type cb_cancelar from commandbutton within w_ge112_coleta_campo
end type
type gb_1 from groupbox within w_ge112_coleta_campo
end type
end forward

global type w_ge112_coleta_campo from Window
int X=1454
int Y=1236
int Width=1586
int Height=636
boolean TitleBar=true
long BackColor=80269524
WindowType WindowType=response!
cb_voltar cb_voltar
em_1 em_1
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge112_coleta_campo w_ge112_coleta_campo

type variables
Long Comando
Long TamanhoMinimo
Long TamanhoMaximo
end variables

on w_ge112_coleta_campo.create
this.cb_voltar=create cb_voltar
this.em_1=create em_1
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.gb_1=create gb_1
this.Control[]={this.cb_voltar,&
this.em_1,&
this.cb_confirmar,&
this.cb_cancelar,&
this.gb_1}
end on

on w_ge112_coleta_campo.destroy
destroy(this.cb_voltar)
destroy(this.em_1)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.gb_1)
end on

event open;
String ls_Titulo

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

This.Comando       = Long(MidA(Message.StringParm,01,5))
This.TamanhoMinimo = Long(MidA(Message.StringParm,07,5))
This.TamanhoMaximo = Long(MidA(Message.StringParm,13,5))

ls_Titulo = MidA(Message.StringParm,19)

This.Title = ls_Titulo

This.Show()

gf_Ativa_Janela(This)

em_1.Event uo_Config()

em_1.SetFocus()
end event

type cb_voltar from commandbutton within w_ge112_coleta_campo
int X=41
int Y=360
int Width=439
int Height=108
int TabOrder=30
string Text="&Voltar"
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent,'VOLTAR')
end event

event getfocus;This.Weight  = 700
end event

event losefocus;This.Weight  = 400
end event

type em_1 from editmask within w_ge112_coleta_campo
event uo_config ( )
int X=82
int Y=124
int Width=1399
int Height=112
int TabOrder=20
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
int TextSize=-13
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event uo_config;String ls_Mask

Choose Case Parent.Comando
	Case 30										//Configura coleta de um campo string qualquer
		
		This.MinMax = String(Parent.TamanhoMinimo) + " ~~ "+ String(Parent.TamanhoMaximo)
		
		This.SetMask(StringMask!,FillA('x',Parent.TamanhoMaximo))
		
		This.Alignment = Left!
		
	Case 34										//Configura coleta de um campo n$$HEX1$$fa00$$ENDHEX$$merico
		
		This.MinMax = String(Parent.TamanhoMinimo) + " ~~ "+ String(Parent.TamanhoMaximo)
		
		Integer i
		
		i = This.SetMask(DecimalMask!, "###.###0,00")

		This.Alignment = Right!
				
End Choose



end event

event getfocus;cb_confirmar.Weight  = 700
end event

event losefocus;cb_confirmar.Weight = 400
end event

type cb_confirmar from commandbutton within w_ge112_coleta_campo
int X=1088
int Y=360
int Width=439
int Height=108
int TabOrder=30
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

ls_Campo = em_1.text

If IsNull(ls_Campo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados solicitados.",Exclamation!)
	Return
End If	

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

type cb_cancelar from commandbutton within w_ge112_coleta_campo
int X=631
int Y=360
int Width=439
int Height=108
int TabOrder=40
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

type gb_1 from groupbox within w_ge112_coleta_campo
int X=41
int Y=16
int Width=1486
int Height=320
int TabOrder=10
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

