HA$PBExportHeader$w_ge147_motivo_cancelamento.srw
forward
global type w_ge147_motivo_cancelamento from dc_w_response_ok_cancela
end type
end forward

global type w_ge147_motivo_cancelamento from dc_w_response_ok_cancela
integer width = 1545
integer height = 724
string title = "GE147 - Motivo de Cancelamento do Pedido"
end type
global w_ge147_motivo_cancelamento w_ge147_motivo_cancelamento

on w_ge147_motivo_cancelamento.create
call super::create
end on

on w_ge147_motivo_cancelamento.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge147_motivo_cancelamento
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge147_motivo_cancelamento
integer width = 1467
integer height = 504
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge147_motivo_cancelamento
integer width = 1408
integer height = 412
string dataobject = "dw_ge147_motivo_cancelamento"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge147_motivo_cancelamento
integer x = 855
integer y = 524
end type

event cb_ok::clicked;call super::clicked;String ls_Motivo

dw_1.AcceptText()

ls_Motivo = dw_1.Object.De_Motivo_Cancelamento[1]

If IsNull(ls_Motivo) Or Trim(ls_Motivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo do cancelamento.", Exclamation!)
	dw_1.Event ue_Pos(1, "de_motivo_cancelamento")
	Return -1
End If

If LenA(Trim(ls_Motivo)) < 5 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O motivo de cancelamento deve ter pelo menos 5 caracteres.", Exclamation!)
	dw_1.Event ue_Pos(1, "de_motivo_cancelamento")
	Return -1
End If

CloseWithReturn(Parent, ls_Motivo)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge147_motivo_cancelamento
integer x = 1189
integer y = 524
end type

