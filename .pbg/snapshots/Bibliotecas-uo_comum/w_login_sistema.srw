HA$PBExportHeader$w_login_sistema.srw
forward
global type w_login_sistema from w_response
end type
type cb_ok from commandbutton within w_login_sistema
end type
type dw_1 from u_dw within w_login_sistema
end type
type st_1 from statictext within w_login_sistema
end type
type st_2 from statictext within w_login_sistema
end type
type cb_cancelar from commandbutton within w_login_sistema
end type
end forward

global type w_login_sistema from w_response
integer width = 1874
integer height = 764
string title = "Verifica$$HEX2$$e700e300$$ENDHEX$$o de Acesso"
boolean controlmenu = false
cb_ok cb_ok
dw_1 dw_1
st_1 st_1
st_2 st_2
cb_cancelar cb_cancelar
end type
global w_login_sistema w_login_sistema

type prototypes


end prototypes

type variables
Integer ivi_Tentativas = 1

UO_SEGURANCA  ivo_seguranca

STRING ivs_Nr_Matricula,&
               ivs_Nm_Usuario,&
               ivs_De_Senha

BOOLEAN ivb_Id_Perfil

INTEGER ivi_Cd_Perfil

end variables

on w_login_sistema.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_cancelar
end on

on w_login_sistema.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_cancelar)
end on

event pfc_postopen;// Prepara a DW para a entrada de dados
dw_1.Event pfc_AddRow()



end event

event open;call super::open;// Posiciona a janela

X = 900
Y = 750

// Monta o nome do sistema

//
UO_PARAMETRO_SEGURANCA lvo_parametro
lvo_parametro = CREATE UO_PARAMETRO_SEGURANCA
//
lvo_parametro = Message.PowerObjectParm
//
ivo_seguranca = lvo_parametro.ivo_seguranca
ivo_Seguranca.ivb_Login_Sucesso = False
//
IF NOT ISNULL(lvo_parametro.ivs_titulo) AND lvo_parametro.ivs_titulo <> "" THEN
	st_1.text = lvo_parametro.ivs_titulo
ELSE
	st_2.Text = "de " + Upper(gvo_Aplicacao.iapp_Aplicacao.DisplayName)
END IF
//
//Dados usu$$HEX1$$e100$$ENDHEX$$rio atual
ivs_Nr_Matricula = ivo_Seguranca.nr_matricula
ivs_Nm_Usuario   = ivo_Seguranca.nm_usuario
ivs_De_Senha     = ivo_Seguranca.de_senha
ivb_Id_Perfil    = ivo_Seguranca.id_perfil_master
ivi_Cd_Perfil    = ivo_Seguranca.cd_perfil_usuario
//
DESTROY lvo_parametro
//
end event

event close;call super::close;IF NOT ivo_Seguranca.ivb_Login_Sucesso THEN
	ivo_Seguranca.nr_matricula      = ivs_Nr_Matricula
	ivo_Seguranca.nm_usuario        = ivs_Nm_Usuario
	ivo_Seguranca.de_senha          = ivs_De_Senha
	ivo_Seguranca.id_perfil_master  = ivb_Id_Perfil
	ivo_Seguranca.cd_perfil_usuario = ivi_Cd_Perfil
END IF	
end event

event closequery;call super::closequery;If KeyDown(KeyAlt!) and KeyDown(KeyF4!) Then	
	SetPointer(Arrow!)
	Return 1
End If	
end event

type cb_ok from commandbutton within w_login_sistema
integer x = 1093
integer y = 556
integer width = 352
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Ok"
boolean default = true
end type

event clicked;String lvs_De_Senha
Integer lvi_Retorno

dw_1.AcceptText()
lvs_De_Senha = Trim(dw_1.Object.De_Senha[1])

If lvs_De_Senha <> "" Then
	If lvs_De_Senha <> ivo_Seguranca.De_Senha Then
		If ivi_Tentativas < 4 Then
			ivi_Tentativas ++
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Senha incorreta.", Information!, Ok!)
			dw_1.SetFocus()
			dw_1.SetColumn("de_senha")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Limite de tentativas esgotado.", Information!, Ok!)
			ivo_Seguranca.ivb_Login_Sucesso = False
			Halt Close
		End If
	Else
		If ivo_Seguranca.De_Senha = ivo_Seguranca.Nr_Matricula Then
			Open(w_altera_senha)
			lvi_retorno = Message.DoubleParm
			If lvi_Retorno = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A senha deve ser trocada no primeiro acesso.", Information!, Ok!)
				ivo_Seguranca.ivb_Login_Sucesso = False
				Halt Close
			End If
		End If
		ivo_Seguranca.ivb_Login_Sucesso = True
		Close(Parent)		
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a senha do usu$$HEX1$$e100$$ENDHEX$$rio.", Information!, Ok!)
	dw_1.SetFocus()
	dw_1.SetColumn("de_senha")
End If
end event

type dw_1 from u_dw within w_login_sistema
integer x = 32
integer y = 200
integer width = 1815
integer height = 344
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_login_sistema"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String lvs_Nr_Matricula

If dwo.Name = "nr_matricula" Then
	// Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio digitado existe
	This.AcceptText()
	lvs_Nr_Matricula = String(This.Object.Nr_Matricula[1])
	//
	ivo_Seguranca.of_Localiza_Usuario(lvs_Nr_Matricula)
	//
	If Not ivo_Seguranca.ivb_Usuario_Localizado Then
		cb_Ok.Enabled = False
		This.Object.nm_usuario[1] = ''		
		Return 1
	Else
		This.Object.Nm_Usuario[1] = ivo_Seguranca.Nm_Usuario
		cb_Ok.Enabled = True
	End If
	//
End If
//
end event

event constructor;call super::constructor;ib_IsUpdateAble = False
end event

event itemerror;call super::itemerror;Return 1
end event

type st_1 from statictext within w_login_sistema
integer x = 32
integer y = 20
integer width = 1792
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "Favor informar sua matr$$HEX1$$ed00$$ENDHEX$$cula e senha para acesso ao sistema"
boolean focusrectangle = false
end type

type st_2 from statictext within w_login_sistema
integer x = 32
integer y = 92
integer width = 1792
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_login_sistema
integer x = 1463
integer y = 556
integer width = 352
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;ib_DisableCloseQuery = True

//gnv_App.ivo_Seguranca.ivb_Login_Sucesso = False
//Close(Parent)

//
ivo_Seguranca.ivb_Login_Sucesso = False
//
Close(Parent)
//
end event

