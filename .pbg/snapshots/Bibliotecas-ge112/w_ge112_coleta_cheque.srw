HA$PBExportHeader$w_ge112_coleta_cheque.srw
forward
global type w_ge112_coleta_cheque from Window
end type
type st_7 from statictext within w_ge112_coleta_cheque
end type
type st_c3 from statictext within w_ge112_coleta_cheque
end type
type em_c3 from editmask within w_ge112_coleta_cheque
end type
type st_6 from statictext within w_ge112_coleta_cheque
end type
type em_cheque from editmask within w_ge112_coleta_cheque
end type
type st_c2 from statictext within w_ge112_coleta_cheque
end type
type em_c2 from editmask within w_ge112_coleta_cheque
end type
type em_contacorrente from editmask within w_ge112_coleta_cheque
end type
type st_5 from statictext within w_ge112_coleta_cheque
end type
type em_c1 from editmask within w_ge112_coleta_cheque
end type
type st_4 from statictext within w_ge112_coleta_cheque
end type
type em_agencia from editmask within w_ge112_coleta_cheque
end type
type st_3 from statictext within w_ge112_coleta_cheque
end type
type em_banco from editmask within w_ge112_coleta_cheque
end type
type st_2 from statictext within w_ge112_coleta_cheque
end type
type st_1 from statictext within w_ge112_coleta_cheque
end type
type em_comp from editmask within w_ge112_coleta_cheque
end type
type cb_confirmar from commandbutton within w_ge112_coleta_cheque
end type
type cb_cancelar from commandbutton within w_ge112_coleta_cheque
end type
type gb_1 from groupbox within w_ge112_coleta_cheque
end type
end forward

global type w_ge112_coleta_cheque from Window
int X=992
int Y=1220
int Width=2738
int Height=644
boolean TitleBar=true
long BackColor=80269524
WindowType WindowType=response!
st_7 st_7
st_c3 st_c3
em_c3 em_c3
st_6 st_6
em_cheque em_cheque
st_c2 st_c2
em_c2 em_c2
em_contacorrente em_contacorrente
st_5 st_5
em_c1 em_c1
st_4 st_4
em_agencia em_agencia
st_3 st_3
em_banco em_banco
st_2 st_2
st_1 st_1
em_comp em_comp
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge112_coleta_cheque w_ge112_coleta_cheque

type variables
Long Comando
Long TamanhoMinimo
Long TamanhoMaximo
end variables

on w_ge112_coleta_cheque.create
this.st_7=create st_7
this.st_c3=create st_c3
this.em_c3=create em_c3
this.st_6=create st_6
this.em_cheque=create em_cheque
this.st_c2=create st_c2
this.em_c2=create em_c2
this.em_contacorrente=create em_contacorrente
this.st_5=create st_5
this.em_c1=create em_c1
this.st_4=create st_4
this.em_agencia=create em_agencia
this.st_3=create st_3
this.em_banco=create em_banco
this.st_2=create st_2
this.st_1=create st_1
this.em_comp=create em_comp
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.gb_1=create gb_1
this.Control[]={this.st_7,&
this.st_c3,&
this.em_c3,&
this.st_6,&
this.em_cheque,&
this.st_c2,&
this.em_c2,&
this.em_contacorrente,&
this.st_5,&
this.em_c1,&
this.st_4,&
this.em_agencia,&
this.st_3,&
this.em_banco,&
this.st_2,&
this.st_1,&
this.em_comp,&
this.cb_confirmar,&
this.cb_cancelar,&
this.gb_1}
end on

on w_ge112_coleta_cheque.destroy
destroy(this.st_7)
destroy(this.st_c3)
destroy(this.em_c3)
destroy(this.st_6)
destroy(this.em_cheque)
destroy(this.st_c2)
destroy(this.em_c2)
destroy(this.em_contacorrente)
destroy(this.st_5)
destroy(this.em_c1)
destroy(this.st_4)
destroy(this.em_agencia)
destroy(this.st_3)
destroy(this.em_banco)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_comp)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.gb_1)
end on

event open;
SetPointer(Arrow!)

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

This.Title = Message.StringParm

This.Show()

gf_Ativa_Janela(This)

em_comp.SetFocus()
end event

type st_7 from statictext within w_ge112_coleta_cheque
int X=87
int Y=408
int Width=1696
int Height=76
boolean Enabled=false
string Text="Campos na parte superior do cheque"
boolean FocusRectangle=false
long TextColor=255
long BackColor=80269524
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_c3 from statictext within w_ge112_coleta_cheque
int X=2377
int Y=68
int Width=242
int Height=88
boolean Enabled=false
string Text="C3"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_c3 from editmask within w_ge112_coleta_cheque
event uo_config ( )
int X=2377
int Y=168
int Width=242
int Height=112
int TabOrder=80
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="#"
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

		This.SetMask(NumericMask!, "###.###0,00")
		
		This.Alignment = Right!
		
		This.Text = '0,00'
		
End Choose



end event

type st_6 from statictext within w_ge112_coleta_cheque
int X=1979
int Y=68
int Width=393
int Height=88
boolean Enabled=false
string Text="Cheque"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_cheque from editmask within w_ge112_coleta_cheque
event uo_config ( )
int X=1979
int Y=168
int Width=393
int Height=112
int TabOrder=70
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="!!!!!!"
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

		This.SetMask(NumericMask!, "###.###0,00")
		
		This.Alignment = Right!
		
		This.Text = '0,00'
		
End Choose



end event

type st_c2 from statictext within w_ge112_coleta_cheque
int X=1733
int Y=68
int Width=242
int Height=88
boolean Enabled=false
string Text="C2"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_c2 from editmask within w_ge112_coleta_cheque
event uo_config ( )
int X=1733
int Y=168
int Width=242
int Height=112
int TabOrder=60
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="#"
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

		This.SetMask(NumericMask!, "###.###0,00")
		
		This.Alignment = Right!
		
		This.Text = '0,00'
		
End Choose



end event

type em_contacorrente from editmask within w_ge112_coleta_cheque
event uo_config ( )
int X=1115
int Y=168
int Width=613
int Height=112
int TabOrder=50
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="!!!!!!!!!!"
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

		This.SetMask(NumericMask!, "###.###0,00")
		
		This.Alignment = Right!
		
		This.Text = '0,00'
		
End Choose



end event

type st_5 from statictext within w_ge112_coleta_cheque
int X=1115
int Y=68
int Width=613
int Height=88
boolean Enabled=false
string Text="Conta Corrente"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_c1 from editmask within w_ge112_coleta_cheque
event uo_config ( )
int X=869
int Y=168
int Width=242
int Height=112
int TabOrder=40
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="#"
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

		This.SetMask(NumericMask!, "###.###0,00")
		
		This.Alignment = Right!
		
		This.Text = '0,00'
		
End Choose



end event

type st_4 from statictext within w_ge112_coleta_cheque
int X=869
int Y=68
int Width=242
int Height=88
boolean Enabled=false
string Text="C1"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_agencia from editmask within w_ge112_coleta_cheque
event uo_config ( )
int X=590
int Y=168
int Width=274
int Height=112
int TabOrder=30
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
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

		This.SetMask(NumericMask!, "###.###0,00")
		
		This.Alignment = Right!
		
		This.Text = '0,00'
		
End Choose



end event

type st_3 from statictext within w_ge112_coleta_cheque
int X=590
int Y=68
int Width=274
int Height=88
boolean Enabled=false
string Text="Ag$$HEX1$$ea00$$ENDHEX$$ncia"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_banco from editmask within w_ge112_coleta_cheque
event uo_config ( )
int X=343
int Y=168
int Width=242
int Height=112
int TabOrder=20
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###"
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

		This.SetMask(NumericMask!, "###.###0,00")
		
		This.Alignment = Right!
		
		This.Text = '0,00'
		
End Choose



end event

type st_2 from statictext within w_ge112_coleta_cheque
int X=343
int Y=68
int Width=242
int Height=88
boolean Enabled=false
string Text="Banco"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_ge112_coleta_cheque
int X=87
int Y=68
int Width=251
int Height=88
boolean Enabled=false
string Text="Comp."
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_comp from editmask within w_ge112_coleta_cheque
event uo_config ( )
int X=87
int Y=168
int Width=251
int Height=112
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###"
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

		This.SetMask(NumericMask!, "###.###0,00")
		
		This.Alignment = Right!
		
		This.Text = '0,00'
		
End Choose



end event

type cb_confirmar from commandbutton within w_ge112_coleta_cheque
int X=2309
int Y=384
int Width=370


int Height=108
int TabOrder=100
string Text="&Confirmar"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String ls_Leitura

String ls_Comp
String ls_Banco
String ls_Agencia
String ls_ContaCorrente
String ls_Cheque
String ls_CC
String ls_C1,ls_C2,ls_C3

ls_Comp    = em_comp.text
ls_Banco   = em_banco.text
ls_Agencia = em_agencia.text
ls_C1      = em_c1.text
ls_C2      = em_c2.text
ls_C3      = em_c3.text
ls_CC      = em_contacorrente.text
ls_Cheque  = em_cheque.text

If IsNull(ls_Comp) or LenA(Trim(ls_Comp)) <> 3 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados corretos para o campo COMP.",Exclamation!)
	em_comp.SetFocus()
	Return
End If	

If IsNull(ls_Banco) or LenA(Trim(ls_Banco)) <> 3 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados corretos para o campo BANCO.",Exclamation!)
	em_banco.SetFocus()
	Return
End If	

If IsNull(ls_Agencia) or LenA(Trim(ls_Agencia)) <> 4 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados corretos para o campo AG$$HEX1$$ca00$$ENDHEX$$NCIA.",Exclamation!)
	em_agencia.SetFocus()
	Return
End If	

If IsNull(ls_c1) or LenA(Trim(ls_c1)) <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados corretos para o campo C1.",Exclamation!)
	em_c1.SetFocus()
	Return
End If	

If IsNull(ls_CC) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados corretos para o campo CONTA CORRENTE.",Exclamation!)
	em_contacorrente.SetFocus()
	Return
End If	

If IsNull(ls_c2) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados corretos para o campo C2.",Exclamation!)
	em_c2.SetFocus()
	Return
End If	

If IsNull(ls_Cheque) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados corretos para o campo CHEQUE.",Exclamation!)
	em_cheque.SetFocus()
	Return
End If	

If IsNull(ls_c3) or LenA(Trim(ls_c3)) <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados corretos para o campo C3.",Exclamation!)
	em_c3.SetFocus()
	Return
End If	

ls_Leitura = "0:" + LeftA(ls_Comp+space(3),3) + LeftA(ls_Banco+space(3),3) + LeftA(ls_Agencia+space(4),4) + ls_C1 + LeftA(ls_CC+space(10),10) + ls_C2 + LeftA(ls_Cheque+space(6),6) + ls_C3

CloseWithReturn(Parent,ls_Leitura)
end event

type cb_cancelar from commandbutton within w_ge112_coleta_cheque
int X=1920
int Y=384
int Width=370
int Height=108
int TabOrder=90
string Text="&cancelar"
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

type gb_1 from groupbox within w_ge112_coleta_cheque
int X=41
int Y=4
int Width=2638
int Height=360
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

