HA$PBExportHeader$w_altera_senha.srw
$PBExportComments$Janela para permitir a troca da senha do usu$$HEX1$$e100$$ENDHEX$$rio
forward
global type w_altera_senha from w_response
end type
type cb_2 from commandbutton within w_altera_senha
end type
type cb_1 from commandbutton within w_altera_senha
end type
type dw_1 from u_dw within w_altera_senha
end type
type st_1 from statictext within w_altera_senha
end type
type st_2 from statictext within w_altera_senha
end type
type st_3 from statictext within w_altera_senha
end type
type st_4 from statictext within w_altera_senha
end type
type st_5 from statictext within w_altera_senha
end type
end forward

global type w_altera_senha from w_response
int X=1102
int Y=500
int Width=1472
int Height=1004
boolean TitleBar=true
string Title="Altera$$HEX2$$e700e300$$ENDHEX$$o de Senha"
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
end type
global w_altera_senha w_altera_senha

type variables

end variables

on w_altera_senha.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_5
end on

on w_altera_senha.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
end on

event open;call super::open;SetPointer(HourGlass!)

// Posiciona a Janela

X = 1100
Y = 700

// Insere uma linha na dw

dw_1.InsertRow(0)

// Desabilita a fun$$HEX2$$e700e300$$ENDHEX$$o de closequery

ib_disableclosequery = True
end event

type cb_2 from commandbutton within w_altera_senha
int X=745
int Y=792
int Width=352
int Height=92
int TabOrder=30
boolean BringToTop=true
string Text="&Cancelar"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)

// Fecha a janela, invalidando o processo

CloseWithReturn(Parent, 0)
end event

type cb_1 from commandbutton within w_altera_senha
int X=366
int Y=792
int Width=352
int Height=92
int TabOrder=20
boolean BringToTop=true
string Text="&Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)

Integer lit_retorna_funcao

dw_1.AcceptText()

// Verifica as informa$$HEX2$$e700f500$$ENDHEX$$es digitadas

If IsNull(dw_1.Object.senha_atual[1]) or Trim(dw_1.Object.senha_atual[1]) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor Informar sua Senha atual.", Information!, Ok!)
	dw_1.SetColumn("senha_atual")
	dw_1.SetFocus()
	Return
End If

If dw_1.Object.senha_atual[1] <> gnv_App.ivo_Seguranca.De_Senha Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Senha atual n$$HEX1$$e300$$ENDHEX$$o confere.", Information!, Ok!)
	dw_1.SetColumn("senha_atual")
	dw_1.SetFocus()
	Return
End If

If IsNull(dw_1.Object.senha_nova1[1]) or Trim(dw_1.Object.senha_nova1[1]) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar sua nova senha.", Information!, Ok!)
	dw_1.SetColumn("senha_nova1")
	dw_1.setFocus()
	Return
End If

If PosA(dw_1.Object.senha_nova1[1], " ") > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nova senha n$$HEX1$$e300$$ENDHEX$$o pode conter espa$$HEX1$$e700$$ENDHEX$$os em branco.", Information!, Ok!)
	dw_1.SetColumn("senha_nova1")
	dw_1.SetFocus()
	Return
End If

If IsNull(dw_1.Object.senha_nova2[1]) or Trim(dw_1.Object.senha_nova2[1]) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar sua nova senha para confirma$$HEX2$$e700e300$$ENDHEX$$o.", Information!, Ok!)
	dw_1.SetColumn("senha_nova2")
	dw_1.setFocus()
	Return
End If

If Trim(dw_1.Object.senha_nova1[1]) <> Trim(dw_1.Object.senha_nova2[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Novas senhas digitadas n$$HEX1$$e300$$ENDHEX$$o conferem.", Information!, Ok!)
	dw_1.SetColumn("senha_nova1")
	dw_1.SetFocus()
	Return
End If

If Trim(dw_1.Object.senha_atual[1]) = Trim(dw_1.Object.senha_nova1[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Senhas atuais e novas iguais.", Information!, Ok!)
	dw_1.SetColumn("senha_nova1")
	dw_1.SetFocus()
	Return
End If

If Trim(dw_1.Object.senha_nova1[1]) = gnv_App.ivo_Seguranca.Nr_Matricula Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Nova senha n$$HEX1$$e300$$ENDHEX$$o pode ser igual ao seu c$$HEX1$$f300$$ENDHEX$$digo.", Information!, Ok!)
	dw_1.SetColumn("senha_nova1")
	dw_1.setFocus()
	return
End If

// Troca a senha do usu$$HEX1$$e100$$ENDHEX$$rio

lit_retorna_funcao = gnv_App.ivo_seguranca.of_troca_senha(dw_1.Object.senha_nova1[1])

If lit_retorna_funcao = 0 Then
	dw_1.SetColumn("senha_atual")
	dw_1.SetFocus()
	Return
End If

// Informa a troca e fecha a janela, validando o processo

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Troca de senha efetuada.", Information!, Ok!)

CloseWithReturn(Parent, 1)

end event

type dw_1 from u_dw within w_altera_senha
int X=389
int Y=416
int Width=695
int Height=332
int TabOrder=10
boolean BringToTop=true
string DataObject="dw_senha"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;ib_isupdateable = False
end event

type st_1 from statictext within w_altera_senha
int X=41
int Y=32
int Width=1394
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Informe sua senha atual e duas vezes a nova senha."
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_altera_senha
int X=41
int Y=108
int Width=1394
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="A nova senha n$$HEX1$$e300$$ENDHEX$$o pode:"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_altera_senha
int X=96
int Y=184
int Width=1339
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="1) Ser igual a senha atual;"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_altera_senha
int X=91
int Y=260
int Width=1339
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="2) Ser igual a sua matr$$HEX1$$ed00$$ENDHEX$$cula;"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_altera_senha
int X=96
int Y=336
int Width=1339
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="3) Conter espa$$HEX1$$e700$$ENDHEX$$os em branco."
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

