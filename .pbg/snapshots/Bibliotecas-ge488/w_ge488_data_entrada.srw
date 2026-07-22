HA$PBExportHeader$w_ge488_data_entrada.srw
forward
global type w_ge488_data_entrada from dc_w_response_ok_cancela
end type
end forward

global type w_ge488_data_entrada from dc_w_response_ok_cancela
integer width = 1157
integer height = 444
string title = "GE488 - Informe a Data Fiscal"
end type
global w_ge488_data_entrada w_ge488_data_entrada

on w_ge488_data_entrada.create
call super::create
end on

on w_ge488_data_entrada.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge488_data_entrada
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge488_data_entrada
integer width = 1074
integer height = 188
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge488_data_entrada
integer width = 1015
integer height = 96
string dataobject = "dw_ge488_selecao_data"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge488_data_entrada
integer x = 448
integer y = 216
end type

event cb_ok::clicked;call super::clicked;Datetime lvdh_Movto

dw_1.Accepttext( )
lvdh_Movto = dw_1.Object.dh_movimento [1]

If lvdh_Movto > Datetime("2010/01/01") Then
	CloseWithReturn( Parent, String(lvdh_Movto, "YYYY/MM/DD"))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data de movimenta$$HEX2$$e700e300$$ENDHEX$$o v$$HEX1$$e100$$ENDHEX$$lida!", Exclamation!)
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge488_data_entrada
integer x = 782
integer y = 216
end type

