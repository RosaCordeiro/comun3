HA$PBExportHeader$w_ge645_response_email_forn.srw
forward
global type w_ge645_response_email_forn from dc_w_response_ok_cancela
end type
end forward

global type w_ge645_response_email_forn from dc_w_response_ok_cancela
string tag = "w_ge645_response_email_forn"
integer width = 2245
integer height = 688
string title = "GE645 - Informe o E-Mail"
end type
global w_ge645_response_email_forn w_ge645_response_email_forn

type variables
string is_fornecedor, is_nm_fornecedor
end variables

on w_ge645_response_email_forn.create
call super::create
end on

on w_ge645_response_email_forn.destroy
call super::destroy
end on

event open;call super::open;string ls_parm
long ll_pos
ls_Parm = Message.StringParm

if not isnull(ls_parm) then
	ll_pos = Pos(ls_parm, ";")
	is_fornecedor = Left(ls_Parm, ll_pos - 1)
	is_nm_fornecedor = Mid(ls_Parm, ll_pos + 1)
else
	ClosewithReturn(this, '') 
end if
end event

event ue_postopen;call super::ue_postopen;Long ll_linhas

DatawindowChild lvdwc_Child

If dw_1.GetChild('de_email_auto', lvdwc_Child) > 0 Then
	lvdwc_Child.SetTransobject( SQLCa )
	
	ll_linhas = lvdwc_Child.Retrieve(is_fornecedor)
	
	if ll_linhas < 1 Then
		dw_1.object.id_email_manual[1] = 'S'
	end if
end if

dw_1.object.nm_fornecedor[1] = is_nm_fornecedor

this.title = 'GE645 - Informe ou Selecione o E-Mail do respons$$HEX1$$e100$$ENDHEX$$vel para o Fornecedor: '
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge645_response_email_forn
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge645_response_email_forn
integer width = 2185
integer height = 428
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge645_response_email_forn
integer y = 80
integer width = 2144
integer height = 308
string dataobject = "dw_ge645_response_email_forn"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge645_response_email_forn
integer x = 1536
integer y = 464
boolean default = false
end type

event cb_ok::clicked;call super::clicked;String ls_Email, ls_parametro, ls_email_manual
Long ll_tipo

dw_1.AcceptText()

setnull(ls_parametro)

ls_email_manual = dw_1.Object.id_email_manual[1]
ll_tipo		= dw_1.Object.id_tipo_arq_env[1]

If ls_email_manual = 'S' then
	ls_Email	= Trim(dw_1.Object.de_email[1])
else
	ls_Email	= Trim(dw_1.Object.de_email_auto[1])
end if

If Not Len(ls_Email) > 0 Or IsNull(ls_Email) Or Not gf_valida_email(ls_Email) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe um E-mail v$$HEX1$$e100$$ENDHEX$$lido!')
	dw_1.Event ue_Pos(1, "de_email")
	Return 1
End If

ls_parametro = string(ll_tipo) + '!' + ls_Email

ClosewithReturn(Parent, ls_parametro) 

return 1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge645_response_email_forn
integer x = 1897
integer y = 464
end type

event cb_cancelar::clicked;call super::clicked;return 1
end event

