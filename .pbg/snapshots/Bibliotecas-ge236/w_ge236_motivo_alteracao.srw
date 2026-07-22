HA$PBExportHeader$w_ge236_motivo_alteracao.srw
forward
global type w_ge236_motivo_alteracao from dc_w_response_ok_cancela
end type
end forward

global type w_ge236_motivo_alteracao from dc_w_response_ok_cancela
integer width = 1353
integer height = 836
string title = "GE236 - Motivo Altera$$HEX2$$e700e300$$ENDHEX$$o Estoque Base"
end type
global w_ge236_motivo_alteracao w_ge236_motivo_alteracao

on w_ge236_motivo_alteracao.create
call super::create
end on

on w_ge236_motivo_alteracao.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge236_motivo_alteracao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge236_motivo_alteracao
integer y = 0
integer width = 1294
integer height = 620
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge236_motivo_alteracao
integer y = 64
integer width = 1248
integer height = 528
string dataobject = "dw_ge236_motivo_alteracao"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge236_motivo_alteracao
integer x = 677
integer y = 640
end type

event cb_ok::clicked;call super::clicked;String ls_Motivo

dw_1.AcceptText()

ls_Motivo = dw_1.Object.De_Motivo_Alteracao[1]

If Trim(ls_Motivo) = "" Or IsNull(ls_Motivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo de altera$$HEX2$$e700e300$$ENDHEX$$o.")
	Return -1
End If

CloseWithReturn(Parent, ls_Motivo)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge236_motivo_alteracao
integer x = 1010
integer y = 640
end type

