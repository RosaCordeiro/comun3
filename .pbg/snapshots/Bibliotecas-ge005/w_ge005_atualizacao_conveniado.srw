HA$PBExportHeader$w_ge005_atualizacao_conveniado.srw
forward
global type w_ge005_atualizacao_conveniado from dc_w_response
end type
type cb_1 from commandbutton within w_ge005_atualizacao_conveniado
end type
type dw_1 from dc_uo_dw_base within w_ge005_atualizacao_conveniado
end type
type cb_2 from commandbutton within w_ge005_atualizacao_conveniado
end type
type gb_1 from groupbox within w_ge005_atualizacao_conveniado
end type
end forward

global type w_ge005_atualizacao_conveniado from dc_w_response
integer width = 2363
integer height = 764
string title = "GE005 - Link para Cadastro de Senha em Compras Online"
boolean controlmenu = false
boolean ivb_permite_fechar = false
cb_1 cb_1
dw_1 dw_1
cb_2 cb_2
gb_1 gb_1
end type
global w_ge005_atualizacao_conveniado w_ge005_atualizacao_conveniado

type variables
String is_Conveniado

Long il_Convenio

String is_CPF
end variables

on w_ge005_atualizacao_conveniado.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_2=create cb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge005_atualizacao_conveniado.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.gb_1)
end on

event open;call super::open;String ls_Cliente
String ls_Parametros

ls_Parametros = Message.StringParm

il_Convenio 			= Long(Mid(ls_Parametros, 1, Pos(ls_Parametros, "|") - 1))
is_Conveniado	 	= Mid(ls_Parametros, Pos(ls_Parametros, "|") + 1)

uo_conveniado lo_Conveniado
lo_Conveniado = Create uo_conveniado
lo_Conveniado.of_localiza_codigo( il_Convenio, is_conveniado)
If lo_Conveniado.localizado Then
	is_CPF = lo_Conveniado.nr_cpf
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o CPF do conveniado.")
	This.il_Retorno = -1
	Return
End If
If IsValid(lo_Conveniado) Then Destroy lo_Conveniado
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
end event

type pb_help from dc_w_response`pb_help within w_ge005_atualizacao_conveniado
integer x = 9
integer y = 540
end type

type cb_1 from commandbutton within w_ge005_atualizacao_conveniado
integer x = 1495
integer y = 552
integer width = 837
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Enviar Link (Cadastro Online)"
end type

event clicked;String ls_Fone, ls_DDD, ls_Email, ls_argumentos
String ls_Matricula_Captacao

DateTime ldt_Termino_Coleta

dw_1.AcceptText()

ls_Fone 	= dw_1.Object.nr_telefone	[ 1 ]
ls_DDD 	= dw_1.Object.nr_ddd		[ 1 ]
ls_Email	= Trim(dw_1.Object.de_email	[ 1 ])

If Trim(ls_Email) = '' Then SetNull(ls_Email)
If Trim(ls_DDD) = '' Then SetNull(ls_DDD)
If Trim(ls_Fone) = '' Then SetNull(ls_Fone)

If ( IsNull(ls_Fone) Or ls_Fone = '' )  And ( IsNull(ls_Email) Or ls_Email = '' ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o n$$HEX1$$fa00$$ENDHEX$$mero do telefone celular ou o endere$$HEX1$$e700$$ENDHEX$$o de e-mail.", Exclamation! )
	dw_1.Event ue_Pos(1, "nr_ddd")
	Return -1
End If

// Valida$$HEX2$$e700e300$$ENDHEX$$o do DDD celular
If Not IsNull( ls_DDD ) Then
	If LenA( ls_DDD ) < 2 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o DDD do telefone celular corretamente (2 d$$HEX1$$ed00$$ENDHEX$$gitos).", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_ddd")
		Return -1
	End If
	If Long(ls_DDD) < 2 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O DDD do telefone celular n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido.", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_ddd")
		Return -1				
	End If	
	// Valida DDD preenchido com telefone n$$HEX1$$e300$$ENDHEX$$o preenchido
	If IsNull( ls_Fone ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O DDD do telefone celular foi preenchido, por$$HEX1$$e900$$ENDHEX$$m, o n$$HEX1$$fa00$$ENDHEX$$mero do celular n$$HEX1$$e300$$ENDHEX$$o.", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_telefone")
		Return -1
	End If
End If

// Telefone deve ter o DDD preenchido corretamente, e o telefone deve ter no m$$HEX1$$ed00$$ENDHEX$$nimo 9 d$$HEX1$$ed00$$ENDHEX$$gitos sem incluir o DDD no mesmo campo
If Not IsNull( ls_Fone ) Then
	If LenA( ls_Fone ) < 9 Or LenA( ls_Fone ) > 9 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O telefone celular informado n$$HEX1$$e300$$ENDHEX$$o possui 9 d$$HEX1$$ed00$$ENDHEX$$gitos.", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_telefone")
		Return -1
	End If
	// Valida telefone preenchido com DDD n$$HEX1$$e300$$ENDHEX$$o preenchido
	If IsNull( ls_DDD ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero do celular foi preenchido, por$$HEX1$$e900$$ENDHEX$$m, o n$$HEX1$$fa00$$ENDHEX$$mero do DDD n$$HEX1$$e300$$ENDHEX$$o.", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_ddd")
		Return -1
	End If
	
	//Se informou o fone
	ls_argumentos +=	"&fone=" + ls_DDD + ls_Fone	
End If

//E-mail
If LenA(ls_Email) > 0 Then
	If Not gf_Valida_Email(ls_Email) Then
		dw_1.Event ue_Pos(1, "de_email")
		Return -1
	End If
	
	//Se informou o email
	ls_argumentos +=	"&email=" + ls_email
End If

//Solicita a matricula do atendente
If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("ATUALIZA_CONVENIADO", ref ls_Matricula_Captacao) Then 
	Return -1
End If

Update conveniado
	Set de_email 						= :ls_Email,
	 	   nr_fone 						= :ls_DDD + :ls_Fone,
		 nr_matricula_atualizacao 	= :ls_Matricula_Captacao,
		 cd_filial_atualizacao			= :gvo_Parametro.cd_filial,
		 dh_atualizacao					= getdate()	
	Where cd_convenio 		= :il_Convenio
		and cd_conveniado 	= :is_Conveniado
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_rollback( )
	SqlCa.of_Msgdberror("Erro ao atualizar o e-mail/fone do conveniado.")
	Return -1
Else
	SqlCa.of_commit( )
End If

//Formata argumentos para a chamada .php
ls_argumentos = "&cpf=" + String( is_CPF ) + ls_argumentos
ls_argumentos = "convenio=" + String( il_Convenio ) + ls_argumentos

//								
uo_transacao_remota lo_SD
lo_SD = Create uo_transacao_remota
lo_SD.of_Executa_Rotina_Intranet( 'envio_link_atualizacao_conveniados', ls_argumentos )
If lo_SD.is_retorno = '1' Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Link enviado com sucesso.")
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na comunica$$HEX2$$e700e300$$ENDHEX$$o com a matriz.~r~rLink n$$HEX1$$e300$$ENDHEX$$o enviado.", StopSign!)
End If
Destroy lo_SD

CloseWithReturn(Parent,"")
end event

type dw_1 from dc_uo_dw_base within w_ge005_atualizacao_conveniado
integer x = 27
integer y = 72
integer width = 2277
integer height = 420
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge005_atualizacao_conveniado"
end type

type cb_2 from commandbutton within w_ge005_atualizacao_conveniado
integer x = 1138
integer y = 552
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Voltar"
end type

event clicked;CloseWithReturn(Parent,"")
end event

type gb_1 from groupbox within w_ge005_atualizacao_conveniado
integer x = 9
integer y = 20
integer width = 2318
integer height = 500
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

