HA$PBExportHeader$w_ge645_response_email_manual.srw
forward
global type w_ge645_response_email_manual from dc_w_response_ok_cancela
end type
end forward

global type w_ge645_response_email_manual from dc_w_response_ok_cancela
string tag = "w_ge645_response_email_manual"
integer width = 2016
integer height = 504
string title = "GE645 - Informe o E-Mail"
end type
global w_ge645_response_email_manual w_ge645_response_email_manual

type variables
string is_fornecedor, is_nm_fornecedor
end variables

on w_ge645_response_email_manual.create
call super::create
end on

on w_ge645_response_email_manual.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge645_response_email_manual
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge645_response_email_manual
integer x = 18
integer width = 1957
integer height = 280
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge645_response_email_manual
integer y = 76
integer width = 1911
integer height = 156
string dataobject = "dw_ge645_response_email_manual"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge645_response_email_manual
integer x = 1307
integer y = 304
boolean default = false
end type

event cb_ok::clicked;call super::clicked;String ls_Email, ls_parametro, ls_email_manual
Long ll_tipo

dw_1.AcceptText()

setnull(ls_parametro)

ll_tipo		= dw_1.Object.id_tipo_arq_env[1]
ls_Email	= Trim(dw_1.Object.de_email[1])

If Not Len(ls_Email) > 0 Or IsNull(ls_Email) Or Not gf_valida_email(ls_Email) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe um E-mail v$$HEX1$$e100$$ENDHEX$$lido!')
	dw_1.Event ue_Pos(1, "de_email")
	Return 1
End If

ls_parametro = string(ll_tipo) + '!' + ls_Email

ClosewithReturn(Parent, ls_parametro) 

return 1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge645_response_email_manual
integer x = 1669
integer y = 304
end type

event cb_cancelar::clicked;call super::clicked;return 1
end event

