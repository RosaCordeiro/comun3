HA$PBExportHeader$w_ge112_coleta_codigo_barras.srw
forward
global type w_ge112_coleta_codigo_barras from Window
end type
type cb_modo from commandbutton within w_ge112_coleta_codigo_barras
end type
type st_1 from statictext within w_ge112_coleta_codigo_barras
end type
type em_codigo from editmask within w_ge112_coleta_codigo_barras
end type
type cb_confirmar from commandbutton within w_ge112_coleta_codigo_barras
end type
type cb_cancelar from commandbutton within w_ge112_coleta_codigo_barras
end type
type gb_1 from groupbox within w_ge112_coleta_codigo_barras
end type
end forward

global type w_ge112_coleta_codigo_barras from Window
int X=992
int Y=1220
int Width=2738
int Height=648
boolean TitleBar=true
long BackColor=80269524
WindowType WindowType=response!
cb_modo cb_modo
st_1 st_1
em_codigo em_codigo
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge112_coleta_codigo_barras w_ge112_coleta_codigo_barras

type variables
Long Tipo
end variables

on w_ge112_coleta_codigo_barras.create
this.cb_modo=create cb_modo
this.st_1=create st_1
this.em_codigo=create em_codigo
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.gb_1=create gb_1
this.Control[]={this.cb_modo,&
this.st_1,&
this.em_codigo,&
this.cb_confirmar,&
this.cb_cancelar,&
this.gb_1}
end on

on w_ge112_coleta_codigo_barras.destroy
destroy(this.cb_modo)
destroy(this.st_1)
destroy(this.em_codigo)
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

em_codigo.SetFocus()
end event

type cb_modo from commandbutton within w_ge112_coleta_codigo_barras
int X=41
int Y=380
int Width=370
int Height=108
int TabOrder=40
string Text="&Leitor"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If This.text = "&Leitor" Then
	
   This.text = "&Digita$$HEX2$$e700e300$$ENDHEX$$o"
Else
	
   This.text = "&Leitor"
End If	
end event

type st_1 from statictext within w_ge112_coleta_codigo_barras
int X=87
int Y=64
int Width=603
int Height=88
boolean Enabled=false
string Text="C$$HEX1$$f300$$ENDHEX$$digo de Barras"
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

type em_codigo from editmask within w_ge112_coleta_codigo_barras
event uo_config ( )
int X=87
int Y=164
int Width=2537
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

event uo_config;//String ls_Mask
//
//Choose Case Parent.Comando
//	Case 30										//Configura coleta de um campo string qualquer
//		
//		This.MinMax = String(Parent.TamanhoMinimo) + " ~~ "+ String(Parent.TamanhoMaximo)
//		
//		This.SetMask(StringMask!,Fill('x',Parent.TamanhoMaximo))
//		
//		This.Alignment = Left!
//		
//	Case 34										//Configura coleta de um campo n$$HEX1$$fa00$$ENDHEX$$merico
//		
//		This.MinMax = String(Parent.TamanhoMinimo) + " ~~ "+ String(Parent.TamanhoMaximo)
//
//		This.SetMask(NumericMask!, "###.###0,00")
//		
//		This.Alignment = Right!
//		
//		This.Text = '0,00'
//		
//End Choose
//


end event

event modified;
Long ll_Retorno

String ls_Codigo

ls_Codigo = This.Text

//If Parent.Tipo = 0 Then 	// Arrecada$$HEX2$$e700e300$$ENDHEX$$o
//
//ElseIf Parent.Tipo = 1 	// Titulo
//
//Else
//	
//	//ll_Retorno = .ValidaCampoCodigoEmBarras()
//	
//End If	
end event

type cb_confirmar from commandbutton within w_ge112_coleta_codigo_barras
int X=2309
int Y=380
int Width=370
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

event clicked;String ls_Leitura

String ls_Codigo

ls_Codigo = em_codigo.text

If IsNull(ls_Codigo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o c$$HEX1$$f300$$ENDHEX$$digo de barras corretamente.",Exclamation!)
	em_codigo.SetFocus()
	Return
End If	

ls_Leitura = "0:" + ls_Codigo

CloseWithReturn(Parent,ls_Leitura)
end event

type cb_cancelar from commandbutton within w_ge112_coleta_codigo_barras
int X=1920
int Y=380
int Width=370
int Height=108
int TabOrder=20
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

type gb_1 from groupbox within w_ge112_coleta_codigo_barras
int X=41
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

