HA$PBExportHeader$w_ge084_coleta_cheque.srw
forward
global type w_ge084_coleta_cheque from window
end type
type st_7 from statictext within w_ge084_coleta_cheque
end type
type st_c3 from statictext within w_ge084_coleta_cheque
end type
type em_c3 from editmask within w_ge084_coleta_cheque
end type
type st_6 from statictext within w_ge084_coleta_cheque
end type
type em_cheque from editmask within w_ge084_coleta_cheque
end type
type st_c2 from statictext within w_ge084_coleta_cheque
end type
type em_c2 from editmask within w_ge084_coleta_cheque
end type
type em_contacorrente from editmask within w_ge084_coleta_cheque
end type
type st_5 from statictext within w_ge084_coleta_cheque
end type
type em_c1 from editmask within w_ge084_coleta_cheque
end type
type st_4 from statictext within w_ge084_coleta_cheque
end type
type em_agencia from editmask within w_ge084_coleta_cheque
end type
type st_3 from statictext within w_ge084_coleta_cheque
end type
type em_banco from editmask within w_ge084_coleta_cheque
end type
type st_2 from statictext within w_ge084_coleta_cheque
end type
type st_1 from statictext within w_ge084_coleta_cheque
end type
type em_comp from editmask within w_ge084_coleta_cheque
end type
type cb_confirmar from commandbutton within w_ge084_coleta_cheque
end type
type cb_cancelar from commandbutton within w_ge084_coleta_cheque
end type
type gb_1 from groupbox within w_ge084_coleta_cheque
end type
end forward

global type w_ge084_coleta_cheque from window
integer x = 992
integer y = 1220
integer width = 2738
integer height = 644
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 80269524
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
global w_ge084_coleta_cheque w_ge084_coleta_cheque

type variables
Long Comando
Long TamanhoMinimo
Long TamanhoMaximo
end variables

on w_ge084_coleta_cheque.create
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

on w_ge084_coleta_cheque.destroy
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

type st_7 from statictext within w_ge084_coleta_cheque
integer x = 87
integer y = 408
integer width = 1696
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 80269524
boolean enabled = false
string text = "* Campos na parte superior do cheque"
boolean focusrectangle = false
end type

type st_c3 from statictext within w_ge084_coleta_cheque
integer x = 2377
integer y = 68
integer width = 242
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "C3"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_c3 from editmask within w_ge084_coleta_cheque
event uo_config ( )
integer x = 2377
integer y = 168
integer width = 242
integer height = 112
integer taborder = 80
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#"
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

type st_6 from statictext within w_ge084_coleta_cheque
integer x = 1979
integer y = 68
integer width = 393
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Cheque"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cheque from editmask within w_ge084_coleta_cheque
event uo_config ( )
integer x = 1979
integer y = 168
integer width = 393
integer height = 112
integer taborder = 70
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
string mask = "!!!!!!"
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

type st_c2 from statictext within w_ge084_coleta_cheque
integer x = 1733
integer y = 68
integer width = 242
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "C2"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_c2 from editmask within w_ge084_coleta_cheque
event uo_config ( )
integer x = 1733
integer y = 168
integer width = 242
integer height = 112
integer taborder = 60
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#"
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

type em_contacorrente from editmask within w_ge084_coleta_cheque
event uo_config ( )
integer x = 1115
integer y = 168
integer width = 613
integer height = 112
integer taborder = 50
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
string mask = "!!!!!!!!!!"
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

type st_5 from statictext within w_ge084_coleta_cheque
integer x = 1115
integer y = 68
integer width = 613
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Conta Corrente"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_c1 from editmask within w_ge084_coleta_cheque
event uo_config ( )
integer x = 869
integer y = 168
integer width = 242
integer height = 112
integer taborder = 40
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#"
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

type st_4 from statictext within w_ge084_coleta_cheque
integer x = 869
integer y = 68
integer width = 242
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "C1"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_agencia from editmask within w_ge084_coleta_cheque
event uo_config ( )
integer x = 590
integer y = 168
integer width = 274
integer height = 112
integer taborder = 30
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####"
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

type st_3 from statictext within w_ge084_coleta_cheque
integer x = 590
integer y = 68
integer width = 274
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Ag$$HEX1$$ea00$$ENDHEX$$ncia"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_banco from editmask within w_ge084_coleta_cheque
event uo_config ( )
integer x = 343
integer y = 168
integer width = 242
integer height = 112
integer taborder = 20
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

type st_2 from statictext within w_ge084_coleta_cheque
integer x = 343
integer y = 68
integer width = 242
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Banco"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_ge084_coleta_cheque
integer x = 87
integer y = 68
integer width = 251
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Comp."
alignment alignment = right!
boolean focusrectangle = false
end type

type em_comp from editmask within w_ge084_coleta_cheque
event uo_config ( )
integer x = 87
integer y = 168
integer width = 251
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

type cb_confirmar from commandbutton within w_ge084_coleta_cheque
integer x = 2309
integer y = 384
integer width = 370
integer height = 108
integer taborder = 100
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

type cb_cancelar from commandbutton within w_ge084_coleta_cheque
integer x = 1920
integer y = 384
integer width = 370
integer height = 108
integer taborder = 90
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

type gb_1 from groupbox within w_ge084_coleta_cheque
integer x = 41
integer y = 4
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

