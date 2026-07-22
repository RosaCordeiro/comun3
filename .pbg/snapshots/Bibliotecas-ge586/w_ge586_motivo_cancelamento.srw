HA$PBExportHeader$w_ge586_motivo_cancelamento.srw
forward
global type w_ge586_motivo_cancelamento from dc_w_response_ok_cancela
end type
end forward

global type w_ge586_motivo_cancelamento from dc_w_response_ok_cancela
string tag = "w_ws164_selecao_motivo_bloqueio"
integer width = 1723
integer height = 520
string title = "WS164 - Sele$$HEX2$$e700e300$$ENDHEX$$o Motivo Bloqueio de Endere$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge586_motivo_cancelamento w_ge586_motivo_cancelamento

type variables
string ivs_Parametro,&
		is_Cd_Endereco

Long il_qtd_solicitacao
end variables

on w_ge586_motivo_cancelamento.create
call super::create
end on

on w_ge586_motivo_cancelamento.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge586_motivo_cancelamento
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge586_motivo_cancelamento
integer width = 1669
integer height = 300
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge586_motivo_cancelamento
integer x = 261
integer y = 40
integer width = 1207
integer height = 252
string dataobject = "dw_ge586_motivo_cancelamento"
boolean livescroll = false
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge586_motivo_cancelamento
integer x = 1029
integer y = 312
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Qtd_Parcial
String ls_Motivo

dw_1.AcceptText()

ls_Motivo			= dw_1.Object.de_motivo[1]

If IsNull(ls_Motivo) Or ls_Motivo = "" Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Favor informar um motivo!')
	dw_1.Event ue_Pos(1, "de_motivo")
	Return 1
End If

If Len(ls_Motivo) > 50 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Tamanho m$$HEX1$$e100$$ENDHEX$$ximo do motivo excedido. ~nFavor reduzir o tamanho.')
	dw_1.Event ue_Pos(1, "de_motivo")
	Return 1
End If

ClosewithReturn(Parent, ls_Motivo) 

return 1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge586_motivo_cancelamento
integer x = 1362
integer y = 312
end type

