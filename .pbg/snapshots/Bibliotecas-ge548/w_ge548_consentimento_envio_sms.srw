HA$PBExportHeader$w_ge548_consentimento_envio_sms.srw
forward
global type w_ge548_consentimento_envio_sms from dc_w_response
end type
type cb_1 from commandbutton within w_ge548_consentimento_envio_sms
end type
type dw_1 from dc_uo_dw_base within w_ge548_consentimento_envio_sms
end type
type gb_1 from groupbox within w_ge548_consentimento_envio_sms
end type
end forward

global type w_ge548_consentimento_envio_sms from dc_w_response
integer width = 2363
integer height = 828
string title = "GE548 - Link de aceite"
boolean controlmenu = false
boolean ivb_permite_fechar = false
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge548_consentimento_envio_sms w_ge548_consentimento_envio_sms

type variables
uo_cliente io_Cliente

Datetime idt_Abertura_Tela
end variables

on w_ge548_consentimento_envio_sms.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_ge548_consentimento_envio_sms.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;String ls_Cliente
String ls_Parametros

ls_Parametros = Message.StringParm

ls_Cliente 			= Mid(ls_Parametros, 1, Pos(ls_Parametros, "|") - 1)
idt_Abertura_Tela 	= DateTime( Mid(ls_Parametros, Pos(ls_Parametros, "|") + 1) )

io_Cliente = Create uo_Cliente
io_Cliente.of_localiza_codigo( ls_Cliente )

end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

dw_1.Object.nr_ddd		[1] = io_cliente.nr_ddd_celular
dw_1.Object.nr_telefone	[1] = io_Cliente.nr_fone_celular
dw_1.Object.de_email	[1] = io_cliente.de_email
end event

event close;call super::close;If IsValid(io_Cliente) Then Destroy io_Cliente
end event

type pb_help from dc_w_response`pb_help within w_ge548_consentimento_envio_sms
integer x = 9
integer y = 612
end type

type cb_1 from commandbutton within w_ge548_consentimento_envio_sms
integer x = 1495
integer y = 624
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
string text = "Enviar Link de Consentimento"
end type

event clicked;String ls_Fone, ls_DDD, ls_Email, ls_argumentos
String ls_Matricula_Captacao
String ls_id_Atendimento_Telefonico = 'S'

DateTime ldt_Termino_Coleta

dw_1.AcceptText()

ls_Fone 	= dw_1.Object.nr_telefone	[ 1 ]
ls_DDD 	= dw_1.Object.nr_ddd		[ 1 ]
ls_Email	= dw_1.Object.de_email		[ 1 ]

If ( IsNull(ls_Fone) Or ls_Fone = '' )  And ( IsNull(ls_Email) Or ls_Email = '' ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o n$$HEX1$$fa00$$ENDHEX$$mero do telefone celular ou o endere$$HEX1$$e700$$ENDHEX$$o de e-mail.", Exclamation! )
	dw_1.Event ue_Pos(1, "nr_telefone")
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
If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("COLETA_CONSENTIMENTOS_CLIENTE", ref ls_Matricula_Captacao) Then 
	Return -1
End If

//Formata argumentos para a chamada .php	
//Passa tambem o cd_cliente
ls_argumentos = "cd_cliente=" + String( io_Cliente.cd_cliente ) + ls_argumentos + '&id_rede=' + gvo_Parametro.id_rede_filial
								
uo_transacao_remota lo_SD
lo_SD = Create uo_transacao_remota
lo_SD.of_Executa_Rotina_Intranet( 'envio_link_consentimento', ls_argumentos )
Destroy lo_SD

//
ldt_Termino_Coleta = gf_GetServerDate()

//Atualiza a tabela coleta_consentimento_lgpd																																			//Cliente_Titular?
If Not gf_ge548_grava_tempo_coleta( io_Cliente.cd_cliente, idt_Abertura_Tela, ldt_Termino_Coleta, ls_Matricula_Captacao, ls_id_Atendimento_Telefonico,'') Then
	Return -1
End If

Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Link de aceite enviado.")

CloseWithReturn(Parent,"")
end event

type dw_1 from dc_uo_dw_base within w_ge548_consentimento_envio_sms
integer x = 27
integer y = 72
integer width = 2277
integer height = 500
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge548_envio_sms_consentimento"
end type

type gb_1 from groupbox within w_ge548_consentimento_envio_sms
integer x = 9
integer y = 20
integer width = 2318
integer height = 580
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

