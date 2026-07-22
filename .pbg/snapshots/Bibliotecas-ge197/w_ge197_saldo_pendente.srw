HA$PBExportHeader$w_ge197_saldo_pendente.srw
forward
global type w_ge197_saldo_pendente from dc_w_response_ok_cancela
end type
end forward

global type w_ge197_saldo_pendente from dc_w_response_ok_cancela
integer width = 2482
integer height = 1272
string title = "GE197 - Consulta Saldo Pendente"
end type
global w_ge197_saldo_pendente w_ge197_saldo_pendente

on w_ge197_saldo_pendente.create
call super::create
end on

on w_ge197_saldo_pendente.destroy
call super::destroy
end on

event open;call super::open;dc_uo_ds_base lds
lds = Create dc_uo_ds_base

lds = Message.PowerObjectParm

If lds.RowsCopy(lds.GetRow(), lds.RowCount(), Primary!, dw_1, 1, Primary!) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no RowsCopy.", StopSign!)
End If

Destroy(lds)
end event

event ue_postopen;//OverRide

dw_1.SetFocus()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge197_saldo_pendente
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge197_saldo_pendente
integer height = 1048
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge197_saldo_pendente
integer width = 2363
integer height = 964
string dataobject = "dw_ge197_lista_pendencia_saldo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge197_saldo_pendente
integer x = 2135
integer y = 1072
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge197_saldo_pendente
boolean visible = false
integer x = 32
integer y = 1064
end type

