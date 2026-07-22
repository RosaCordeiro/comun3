HA$PBExportHeader$w_ge202_selecao_mensagem_email.srw
forward
global type w_ge202_selecao_mensagem_email from dc_w_selecao_generica
end type
end forward

global type w_ge202_selecao_mensagem_email from dc_w_selecao_generica
string title = "GE202 - Sele$$HEX2$$e700e300$$ENDHEX$$o Mensagem Email Sistema"
end type
global w_ge202_selecao_mensagem_email w_ge202_selecao_mensagem_email

on w_ge202_selecao_mensagem_email.create
call super::create
end on

on w_ge202_selecao_mensagem_email.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

lvs_Parametro = Message.StringParm

dw_1.Object.de_filtro [1] = lvs_Parametro

If Trim(lvs_Parametro)<>'' Then dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge202_selecao_mensagem_email
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge202_selecao_mensagem_email
integer y = 220
integer height = 1064
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge202_selecao_mensagem_email
integer height = 188
string text = "Par$$HEX1$$e200$$ENDHEX$$metros"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge202_selecao_mensagem_email
integer height = 100
string dataobject = "dw_ge202_selecao_mensagem"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge202_selecao_mensagem_email
integer y = 292
integer width = 2373
integer height = 964
string dataobject = "dw_ge202_lista_selecao_mensagem"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Filtro

dw_1.Accepttext( )

lvs_Filtro = dw_1.Object.de_filtro [1]

If Trim(lvs_Filtro)<>'' Then
	This.Of_AppendWhere(	"(upper(de_assunto) like '%"+lvs_Filtro+"%' or "+&
									"upper(cd_sistema) like '%"+lvs_Filtro+"%' or "+&
									"upper(de_observacao) like '%"+lvs_Filtro+"%' or "+&
									"upper(cd_procedimento) like '%"+lvs_Filtro+"%')")									
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge202_selecao_mensagem_email
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Mensagem

If dw_2.GetRow() <= 0 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Selecione uma mensagem ou clique em cancelar!',Exclamation!)
	Return -1
Else
	lvl_Mensagem = dw_2.Object.cd_mensagem [dw_2.GetRow()]
	CloseWithReturn(Parent,String(lvl_Mensagem))
End If

end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge202_selecao_mensagem_email
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge202_selecao_mensagem_email
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge202_selecao_mensagem_email
end type

