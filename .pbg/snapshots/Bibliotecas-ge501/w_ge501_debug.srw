HA$PBExportHeader$w_ge501_debug.srw
forward
global type w_ge501_debug from dc_w_response_ok_cancela
end type
end forward

global type w_ge501_debug from dc_w_response_ok_cancela
integer width = 1243
integer height = 528
string title = "GE501 - Sele$$HEX2$$e700e300$$ENDHEX$$o Debug"
end type
global w_ge501_debug w_ge501_debug

on w_ge501_debug.create
call super::create
end on

on w_ge501_debug.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge501_debug
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge501_debug
integer width = 1166
integer height = 292
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge501_debug
integer x = 46
integer y = 76
integer width = 1129
integer height = 176
string dataobject = "dw_selecao_debug"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge501_debug
integer x = 544
integer y = 324
integer weight = 700
end type

event cb_ok::clicked;call super::clicked;str_dados_debug str

dw_1.AcceptText()

str.id_rede_filial	= dw_1.Object.id_rede_filial[1]
str.nr_pedido	 	= dw_1.Object.nr_pedido	[1]

CloseWithReturn(Parent, str)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge501_debug
integer x = 878
integer y = 324
end type

event cb_cancelar::clicked;//OverRide
str_dados_debug str
CloseWithReturn(Parent, str)
end event

