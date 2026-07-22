HA$PBExportHeader$w_ge446_cadastro_email_msg_auto.srw
forward
global type w_ge446_cadastro_email_msg_auto from dc_w_cadastro_lista
end type
end forward

global type w_ge446_cadastro_email_msg_auto from dc_w_cadastro_lista
integer width = 4215
integer height = 1316
string title = "GE446 - Cadastro de Endere$$HEX1$$e700$$ENDHEX$$o de E-mail para Mensagem Autom$$HEX1$$e100$$ENDHEX$$tica"
end type
global w_ge446_cadastro_email_msg_auto w_ge446_cadastro_email_msg_auto

type variables
uo_usuario io_Usuario

Long il_Mensagem
end variables

forward prototypes
public function boolean wf_usuario_duplicado ()
end prototypes

public function boolean wf_usuario_duplicado ();Long ll_Find

dw_1.AcceptText()

ll_Find = dw_1.Find("nr_matricula = '" + io_Usuario.Nr_Matricula + "'", 1, dw_1.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_1.", StopSign!)
	Return False
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Matr$$HEX1$$ed00$$ENDHEX$$cula '" + io_Usuario.Nr_Matricula + "' j$$HEX1$$e100$$ENDHEX$$ foi informada.", Exclamation!)
	Return False
End If

Return True
end function

on w_ge446_cadastro_email_msg_auto.create
call super::create
end on

on w_ge446_cadastro_email_msg_auto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Dw[]
lvo_Dw = {dw_1}
This.wf_SetUpdate_DW(lvo_Dw)
end event

event close;call super::close;Destroy(io_Usuario)
end event

event ue_preupdate;call super::ue_preupdate;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Linha

String ls_Email
String ls_Erro
String ls_Matricula

dw_1.AcceptText()

For ll_Linha = 1 To dw_1.RowCount()
	ls_Email			= dw_1.Object.De_Email				[ll_Linha]
	ldh_Inicio		= dw_1.Object.Dh_Inicio_Envio		[ll_Linha]
	ldh_Termino	= dw_1.Object.Dh_Termino_Envio	[ll_Linha]
	ls_Matricula		= dw_1.Object.Nr_Matricula			[ll_Linha]
	
	If IsNull(ls_Matricula) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o usu$$HEX1$$e100$$ENDHEX$$rio.", Exclamation!)
		dw_1.Event ue_Pos(ll_Linha, "nm_usuario")
		Return False
	End If
	
	If IsNull(ls_Email) Or Trim(ls_Email) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o endere$$HEX1$$e700$$ENDHEX$$o de e-mail.", Exclamation!)
		dw_1.Event ue_Pos(ll_Linha, "de_email")
		Return False
	End If
	
	If Not gf_Valida_Email(ls_Email, True, Ref ls_Erro) Then Return False
	
	If IsNull(ldh_Inicio) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
		dw_1.Event ue_Pos(ll_Linha, "dh_inicio_envio")
		Return False
	End If
	
	If ldh_Inicio < DateTime(Date(gf_GetServerDate())) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data atual.", Exclamation!)
		dw_1.Event ue_Pos(ll_Linha, "dh_inicio_envio")
		Return False
	End If
	
	If ldh_Termino < DateTime(Date(gf_GetServerDate())) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data atual.", Exclamation!)
		dw_1.Event ue_Pos(ll_Linha, "dh_termino_envio")
		Return False
	End If
	
	If ldh_Termino < ldh_Inicio Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
		dw_1.Event ue_Pos(ll_Linha, "dh_termino_envio")
		Return False
	End If
Next

Return True
end event

event ue_preopen;call super::ue_preopen;io_Usuario = Create uo_usuario

Choose Case gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
	Case "EC"
		il_Mensagem = 141
	
	Case "FI"
		il_Mensagem = 142
		
	Case "GF"
		il_Mensagem = 143
		
	Case "GP"
		il_Mensagem = 144
		
	Case "GC"
		il_Mensagem = 145
End Choose
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge446_cadastro_email_msg_auto
integer x = 37
integer y = 736
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge446_cadastro_email_msg_auto
integer x = 0
integer y = 664
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge446_cadastro_email_msg_auto
integer width = 4009
integer height = 980
string dataobject = "dw_ge446_lista"
end type

event dw_1::ue_recuperar;//OverRide

Return This.Retrieve(il_Mensagem)
end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Usuario.Nm_Usuario Then
			Return 1
		End If
	Else
		io_Usuario.of_Inicializa()
		
		This.Object.Nr_Matricula	[This.GetRow()] = io_Usuario.Nr_Matricula
		This.Object.Nm_Usuario	[This.GetRow()] = io_Usuario.Nm_Usuario
	End If
End If

If dwo.Name = "nm_usuario" Then
	dw_1.Object.De_Email[This.GetRow()] = ""
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Usuario.Nm_Usuario Then
			Return 1
		End If
	Else
		io_Usuario.of_Inicializa()
		
		This.Object.Nr_Matricula	[This.GetRow()] = io_Usuario.Nr_Matricula
		This.Object.Nm_Usuario	[This.GetRow()] = io_Usuario.Nm_Usuario
	End If
End If

If dwo.Name = "nm_usuario" Then
	dw_1.Object.De_Email[This.GetRow()] = ""
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_usuario" Then
		io_Usuario.of_Localiza_Usuario(This.GetText())
		
		If Not io_Usuario.Localizado Then
			io_Usuario.of_Inicializa()
		End If
		
		If Not wf_Usuario_Duplicado() Then Return -1
		
		This.Object.Nr_Matricula		[This.GetRow()] = io_Usuario.Nr_Matricula
		This.Object.Nm_Usuario		[This.GetRow()] = io_Usuario.Nm_Usuario
		This.Object.De_Email			[This.GetRow()] = io_Usuario.De_Email
	End If
End If
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;If This.RowCount() > 0 Then
	If IsNull(This.Object.Nr_Matricula[This.RowCount()]) Then
		Return -1
	End If
End If

Return 1
end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	This.Object.Cd_Mensagem	[This.RowCount()] = il_Mensagem
	This.Object.Dh_Inicio_Envio	[This.RowCount()] = DateTime(Date(gf_GetServerDate()))
End If

Return AncestorReturnValue
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge446_cadastro_email_msg_auto
integer width = 4091
integer height = 1080
end type

