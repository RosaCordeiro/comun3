HA$PBExportHeader$w_ge350_datas_retiradas.srw
forward
global type w_ge350_datas_retiradas from dc_w_response_ok_cancela
end type
end forward

global type w_ge350_datas_retiradas from dc_w_response_ok_cancela
string tag = "w_ge350_datas_retiradas"
integer width = 1097
integer height = 560
string title = "GE350 -  Datas Retiradas"
end type
global w_ge350_datas_retiradas w_ge350_datas_retiradas

type variables
str_ge350_datas std
end variables

on w_ge350_datas_retiradas.create
call super::create
end on

on w_ge350_datas_retiradas.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dh_inicio_data		[1] = Date(gvo_Parametro.of_Dh_Movimentacao())
dw_1.Object.dh_fim_data		[1] = Date(gvo_Parametro.of_Dh_Movimentacao()) 
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge350_datas_retiradas
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge350_datas_retiradas
integer width = 1024
integer height = 320
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge350_datas_retiradas
integer width = 978
integer height = 200
string dataobject = "dw_ge350_datas_retiradas"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge350_datas_retiradas
integer x = 402
integer y = 336
end type

event cb_ok::clicked;call super::clicked;DateTime ldh_Inicio_Data
DateTime ldh_Termino_Data

dw_1.AcceptText()

ldh_Inicio_Data		= dw_1.Object.dh_inicio_data		[1]
ldh_Termino_Data	= dw_1.Object.dh_fim_data	[1]

If IsNull(ldh_Inicio_Data) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da retirada.")
	dw_1.Event ue_Pos(dw_1.GetRow(), "dh_inicio_data")	
	Return -1
End If

If IsNull(ldh_Termino_Data) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da retirada.")
	dw_1.Event ue_Pos(dw_1.GetRow(), "dh_termino_data")	
	Return -1
End If

If ldh_Inicio_Data < gvo_Parametro.of_Dh_Movimentacao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data corrente.")
	dw_1.Event ue_Pos(dw_1.GetRow(), "dh_inicio_data")	
	Return -1
End If

If ldh_Inicio_Data > ldh_Termino_Data Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da retirada n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da retirada.")
	dw_1.Event ue_Pos(dw_1.GetRow(), "dh_termino_data")	
	Return -1
End If

std.Dh_Inicio_Data		= ldh_Inicio_Data
std.Dh_Fim_Data		= ldh_Termino_Data

CloseWithReturn(Parent, std)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge350_datas_retiradas
integer x = 736
integer y = 336
end type

event cb_cancelar::clicked;//OverRide

SetNull(std.Dh_Inicio_Data)
SetNull(std.Dh_Fim_Data)

CloseWithReturn(Parent, std)
end event

