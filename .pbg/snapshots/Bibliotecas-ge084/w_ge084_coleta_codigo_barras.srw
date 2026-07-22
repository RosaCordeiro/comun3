HA$PBExportHeader$w_ge084_coleta_codigo_barras.srw
forward
global type w_ge084_coleta_codigo_barras from window
end type
type cb_modo from commandbutton within w_ge084_coleta_codigo_barras
end type
type st_1 from statictext within w_ge084_coleta_codigo_barras
end type
type em_codigo from editmask within w_ge084_coleta_codigo_barras
end type
type cb_confirmar from commandbutton within w_ge084_coleta_codigo_barras
end type
type cb_cancelar from commandbutton within w_ge084_coleta_codigo_barras
end type
type gb_1 from groupbox within w_ge084_coleta_codigo_barras
end type
end forward

global type w_ge084_coleta_codigo_barras from window
integer x = 992
integer y = 1220
integer width = 2738
integer height = 648
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 80269524
cb_modo cb_modo
st_1 st_1
em_codigo em_codigo
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge084_coleta_codigo_barras w_ge084_coleta_codigo_barras

type variables
Long Tipo
end variables

on w_ge084_coleta_codigo_barras.create
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

on w_ge084_coleta_codigo_barras.destroy
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

type cb_modo from commandbutton within w_ge084_coleta_codigo_barras
integer x = 41
integer y = 380
integer width = 370
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Leitor"
boolean cancel = true
end type

event clicked;If This.text = "&Leitor" Then
	
   This.text = "&Digita$$HEX2$$e700e300$$ENDHEX$$o"
Else
	
   This.text = "&Leitor"
End If	
end event

type st_1 from statictext within w_ge084_coleta_codigo_barras
integer x = 87
integer y = 64
integer width = 603
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "C$$HEX1$$f300$$ENDHEX$$digo de Barras"
boolean focusrectangle = false
end type

type em_codigo from editmask within w_ge084_coleta_codigo_barras
event uo_config ( )
integer x = 87
integer y = 164
integer width = 2537
integer height = 112
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
string mask = "###"
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

type cb_confirmar from commandbutton within w_ge084_coleta_codigo_barras
integer x = 2309
integer y = 380
integer width = 370
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar"
boolean default = true
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

type cb_cancelar from commandbutton within w_ge084_coleta_codigo_barras
integer x = 1920
integer y = 380
integer width = 370
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,'CANCELAR')
end event

type gb_1 from groupbox within w_ge084_coleta_codigo_barras
integer x = 41
integer width = 2638
integer height = 360
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

