HA$PBExportHeader$w_ge437_historico.srw
forward
global type w_ge437_historico from dc_w_response_ok_cancela
end type
end forward

global type w_ge437_historico from dc_w_response_ok_cancela
integer width = 2098
integer height = 968
string title = "GE437 - Altera$$HEX2$$e700f500$$ENDHEX$$es da Filial no Projeto"
end type
global w_ge437_historico w_ge437_historico

on w_ge437_historico.create
call super::create
end on

on w_ge437_historico.destroy
call super::destroy
end on

event ue_postopen;//OverRide

ivo_dbError = Create dc_uo_dbError

//Registra Tela para Controle de Inatividade
If (Not(ivb_permite_fechar)) and (IsValid(gvo_Aplicacao)) Then
	If gvo_Aplicacao.ivb_Usa_Timer_Out Then
		gvo_Aplicacao.of_insere_tela(This.Title)
	End If
End If

// Insere a tela response do array de responses abertas
// Necess$$HEX1$$e100$$ENDHEX$$rio a armazenagem para fechar as telas por inatividade
If IsValid(gvo_Aplicacao) Then
	If gvo_Aplicacao.ivb_usa_timer_out Then
		If This.WindowType = Response! Then
			gvo_Aplicacao.of_insere_response(This)
		End if
	End If
End If

//Verifica se no grupo de acesso a tela est$$HEX1$$e100$$ENDHEX$$ sem permiss$$HEX1$$e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o
// e seta como somente leitura os campos
wf_set_somente_consulta()

dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge437_historico
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge437_historico
integer width = 2039
integer height = 756
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge437_historico
integer x = 59
integer y = 56
integer width = 1979
integer height = 680
string dataobject = "dw_ge437_historico"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;//OverRide

Long ll_Filial

String ls_Fornecedor

ll_Filial 				= Long(Mid(Message.StringParm, 1, 4))
ls_Fornecedor		= Mid(Message.StringParm, 5)

Return This.Retrieve(ll_Filial, ls_Fornecedor)

end event

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge437_historico
integer x = 1751
integer y = 772
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge437_historico
boolean visible = false
integer x = 41
integer y = 784
integer width = 174
boolean enabled = false
end type

