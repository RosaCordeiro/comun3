HA$PBExportHeader$w_ge084_leitura_cartao.srw
forward
global type w_ge084_leitura_cartao from window
end type
type st_msg from statictext within w_ge084_leitura_cartao
end type
type rb_magnetico from radiobutton within w_ge084_leitura_cartao
end type
type rb_digitado from radiobutton within w_ge084_leitura_cartao
end type
type st_titulo from statictext within w_ge084_leitura_cartao
end type
type em_cartao from editmask within w_ge084_leitura_cartao
end type
type cb_confirmar from commandbutton within w_ge084_leitura_cartao
end type
type cb_cancelar from commandbutton within w_ge084_leitura_cartao
end type
type gb_1 from groupbox within w_ge084_leitura_cartao
end type
end forward

global type w_ge084_leitura_cartao from window
integer x = 741
integer y = 932
integer width = 1947
integer height = 892
boolean titlebar = true
string title = "Transa$$HEX2$$e700e300$$ENDHEX$$o TEF - Leitura de Cart$$HEX1$$e300$$ENDHEX$$o"
windowtype windowtype = response!
long backcolor = 80269524
st_msg st_msg
rb_magnetico rb_magnetico
rb_digitado rb_digitado
st_titulo st_titulo
em_cartao em_cartao
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge084_leitura_cartao w_ge084_leitura_cartao

type variables
Long TamanhoMinimo
Long TamanhoMaximo
end variables

on w_ge084_leitura_cartao.create
this.st_msg=create st_msg
this.rb_magnetico=create rb_magnetico
this.rb_digitado=create rb_digitado
this.st_titulo=create st_titulo
this.em_cartao=create em_cartao
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.gb_1=create gb_1
this.Control[]={this.st_msg,&
this.rb_magnetico,&
this.rb_digitado,&
this.st_titulo,&
this.em_cartao,&
this.cb_confirmar,&
this.cb_cancelar,&
this.gb_1}
end on

on w_ge084_leitura_cartao.destroy
destroy(this.st_msg)
destroy(this.rb_magnetico)
destroy(this.rb_digitado)
destroy(this.st_titulo)
destroy(this.em_cartao)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.gb_1)
end on

event open;
String ls_Titulo
String ls_Recarga

//Instru$$HEX2$$e700e300$$ENDHEX$$o para passar cart$$HEX1$$e300$$ENDHEX$$o no leitor
st_msg.Visible = False

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

This.TamanhoMinimo = 0
This.TamanhoMaximo = 20

st_titulo.Text  = Message.StringParm

em_cartao.Event uo_Config()

//Habilita Default Digita$$HEX2$$e700e300$$ENDHEX$$o
rb_digitado.Checked = True

gf_Ativa_Janela(This)

This.Show()

//Foco no campo para Digita$$HEX2$$e700e300$$ENDHEX$$o
em_cartao.SetFocus()


end event

type st_msg from statictext within w_ge084_leitura_cartao
integer x = 78
integer y = 368
integer width = 1778
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Insira ou passe o cart$$HEX1$$e300$$ENDHEX$$o ..."
boolean focusrectangle = false
end type

type rb_magnetico from radiobutton within w_ge084_leitura_cartao
integer x = 704
integer y = 204
integer width = 1024
integer height = 76
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Leitura Magn$$HEX1$$e900$$ENDHEX$$tica - PINPAD"
boolean righttoleft = true
end type

event clicked;String ls_Digitado

String ls_Cartao
String ls_Trilha1
String ls_Trilha2

If This.Checked Then
	
	//Desabilita Confirmar
	cb_confirmar.Enabled = False
	
	//Limpa Digita$$HEX2$$e700e300$$ENDHEX$$o
	em_cartao.Text = Space(20)
	
	//Desabilita Digita$$HEX2$$e700e300$$ENDHEX$$o
	em_cartao.Enabled = False
	
	//Instru$$HEX2$$e700e300$$ENDHEX$$o para leitura do Cart$$HEX1$$e300$$ENDHEX$$o
	st_msg.Visible = True
	
   If Sitef.of_Leitura_Cartao() Then
		
		//Limpa Digita$$HEX2$$e700e300$$ENDHEX$$o
		em_cartao.Text = LeftA(Sitef.de_Cartao_Trilha2,PosA(Sitef.de_Cartao_Trilha2,'=')-1)
		
		//Desabilita Mensagem de Leitura do Cart$$HEX1$$e300$$ENDHEX$$o
		st_msg.Visible = False
		
		//Habilita Confirma$$HEX2$$e700e300$$ENDHEX$$o da Leitura
		cb_confirmar.Enabled = True
		
	Else
		rb_Digitado.Checked = True
		rb_Digitado.Event Clicked()
	End If	
			
Else
	em_cartao.Enabled = True
End If
end event

type rb_digitado from radiobutton within w_ge084_leitura_cartao
integer x = 37
integer y = 204
integer width = 389
integer height = 76
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Digitado"
boolean righttoleft = true
end type

event clicked;
Sitef.of_Cancela_Pinpad()

If This.Checked Then
	
	em_cartao.Enabled = True

	//Instru$$HEX2$$e700e300$$ENDHEX$$o para leitura do Cart$$HEX1$$e300$$ENDHEX$$o
	st_msg.Visible = False
	
	//Foco no campo para Digita$$HEX2$$e700e300$$ENDHEX$$o
	em_cartao.SetFocus()
	
	//Habilita Bot$$HEX1$$e300$$ENDHEX$$o Ok
	cb_confirmar.Enabled = True
	
Else	
	em_cartao.Enabled = False
End If	
end event

type st_titulo from statictext within w_ge084_leitura_cartao
integer x = 37
integer y = 40
integer width = 1851
integer height = 116
integer textsize = -13
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

type em_cartao from editmask within w_ge084_leitura_cartao
event uo_config ( )
integer x = 78
integer y = 464
integer width = 1778
integer height = 112
integer taborder = 30
integer textsize = -13
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

event uo_config;//Configura coleta de um campo string qualquer
		
This.MinMax = String(Parent.TamanhoMinimo) + " ~~ "+ String(Parent.TamanhoMaximo)

This.SetMask(StringMask!,FillA('x',Parent.TamanhoMaximo))

end event

event getfocus;cb_confirmar.Weight  = 700

end event

event losefocus;cb_confirmar.Weight  = 400
end event

type cb_confirmar from commandbutton within w_ge084_leitura_cartao
integer x = 1522
integer y = 644
integer width = 370
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar"
boolean default = true
end type

event clicked;String ls_Campo

ls_Campo = em_cartao.text

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

If rb_Digitado.Checked Then
	Sitef.id_Cartao_Digitado = True
	Sitef.de_Cartao_Digitado = Trim(ls_Campo)
End If	

CloseWithReturn(Parent,"OK")
end event

event getfocus;This.Weight  = 700

end event

event losefocus;This.Weight  = 400
end event

type cb_cancelar from commandbutton within w_ge084_leitura_cartao
integer x = 1134
integer y = 644
integer width = 370
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "C&ancelar"
boolean cancel = true
end type

event clicked;Sitef.of_Cancela_Pinpad()

CloseWithReturn(Parent,'CANCELAR')
end event

event getfocus;This.Weight  = 700
end event

event losefocus;This.Weight  = 400
end event

type gb_1 from groupbox within w_ge084_leitura_cartao
integer x = 37
integer y = 316
integer width = 1851
integer height = 304
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

