HA$PBExportHeader$w_ge525_historico_acordos.srw
forward
global type w_ge525_historico_acordos from dc_w_response_ok_cancela
end type
end forward

global type w_ge525_historico_acordos from dc_w_response_ok_cancela
string tag = "w_ge525_historico_acordos"
integer width = 4050
integer height = 1324
string title = "GE525 - Historico Distribuidora Acordo Devolu$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge525_historico_acordos w_ge525_historico_acordos

type variables
String ivs_Parametros
end variables

on w_ge525_historico_acordos.create
call super::create
end on

on w_ge525_historico_acordos.destroy
call super::destroy
end on

event open;call super::open;ivs_Parametros = Message.StringParm

end event

event ue_postopen;call super::ue_postopen;dw_1.retrieve (ivs_Parametros)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge525_historico_acordos
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge525_historico_acordos
integer width = 4005
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge525_historico_acordos
integer width = 3936
integer height = 1040
string dataobject = "dw_ge525_historico"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge525_historico_acordos
integer x = 3383
integer y = 1132
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge525_historico_acordos
integer x = 3717
integer y = 1132
end type

