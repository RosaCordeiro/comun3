HA$PBExportHeader$w_ge108_reserva_pendente.srw
forward
global type w_ge108_reserva_pendente from dc_w_response_ok_cancela
end type
end forward

global type w_ge108_reserva_pendente from dc_w_response_ok_cancela
integer width = 3589
integer height = 1352
string title = "GE108 - Lista de Reserva Pendente e/ou Expirada"
end type
global w_ge108_reserva_pendente w_ge108_reserva_pendente

on w_ge108_reserva_pendente.create
call super::create
end on

on w_ge108_reserva_pendente.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_reserva_pendente
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_reserva_pendente
integer width = 3529
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_reserva_pendente
integer x = 59
integer y = 60
integer width = 3470
integer height = 1048
string dataobject = "dw_ge108_lista_reserva_pendente"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_setRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_reserva_pendente
integer x = 3241
integer y = 1148
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_reserva_pendente
boolean visible = false
integer x = 55
integer y = 1136
boolean enabled = false
end type

