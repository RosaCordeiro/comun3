HA$PBExportHeader$w_ge422_historico.srw
forward
global type w_ge422_historico from dc_w_response_ok_cancela
end type
end forward

global type w_ge422_historico from dc_w_response_ok_cancela
integer width = 1157
integer height = 1060
string title = "GE422 - Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge422_historico w_ge422_historico

on w_ge422_historico.create
call super::create
end on

on w_ge422_historico.destroy
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

String ls_Produto

ls_Produto = Message.StringParm

dw_1.Retrieve(Long(ls_Produto))

Cb_Ok.SetFocus()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge422_historico
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge422_historico
integer width = 1083
integer height = 836
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge422_historico
integer width = 1006
integer height = 744
string dataobject = "dw_ge422_historico"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge422_historico
integer x = 786
integer y = 860
end type

event cb_ok::clicked;call super::clicked;CloseWithReturn(Parent, "")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge422_historico
boolean visible = false
integer x = 41
integer y = 856
end type

