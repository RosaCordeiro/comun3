HA$PBExportHeader$w_ge084_coleta_campo.srw
forward
global type w_ge084_coleta_campo from window
end type
type cb_voltar from commandbutton within w_ge084_coleta_campo
end type
type em_1 from editmask within w_ge084_coleta_campo
end type
type cb_confirmar from commandbutton within w_ge084_coleta_campo
end type
type cb_cancelar from commandbutton within w_ge084_coleta_campo
end type
type gb_1 from groupbox within w_ge084_coleta_campo
end type
end forward

global type w_ge084_coleta_campo from window
integer x = 1454
integer y = 1236
integer width = 1586
integer height = 636
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 80269524
cb_voltar cb_voltar
em_1 em_1
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge084_coleta_campo w_ge084_coleta_campo

type variables
Long Comando
Long TamanhoMinimo
Long TamanhoMaximo
end variables

on w_ge084_coleta_campo.create
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

on w_ge084_coleta_campo.destroy
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

type cb_voltar from commandbutton within w_ge084_coleta_campo
integer x = 41
integer y = 360
integer width = 439
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

type em_1 from editmask within w_ge084_coleta_campo
event uo_config ( )
integer x = 82
integer y = 124
integer width = 1399
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
maskdatatype maskdatatype = stringmask!
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

type cb_confirmar from commandbutton within w_ge084_coleta_campo
integer x = 1088
integer y = 360
integer width = 439
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

type cb_cancelar from commandbutton within w_ge084_coleta_campo
integer x = 631
integer y = 360
integer width = 439
integer height = 108
integer taborder = 40
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

type gb_1 from groupbox within w_ge084_coleta_campo
integer x = 41
integer y = 16
integer width = 1486
integer height = 320
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

