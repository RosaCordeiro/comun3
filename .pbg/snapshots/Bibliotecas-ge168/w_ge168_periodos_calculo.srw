HA$PBExportHeader$w_ge168_periodos_calculo.srw
forward
global type w_ge168_periodos_calculo from dc_w_response_ok_cancela
end type
end forward

global type w_ge168_periodos_calculo from dc_w_response_ok_cancela
integer width = 1257
integer height = 724
string title = "GE168 - Per$$HEX1$$ed00$$ENDHEX$$odos C$$HEX1$$e100$$ENDHEX$$lculo"
end type
global w_ge168_periodos_calculo w_ge168_periodos_calculo

on w_ge168_periodos_calculo.create
call super::create
end on

on w_ge168_periodos_calculo.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Retrieve(Long(Message.StringParm))
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge168_periodos_calculo
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge168_periodos_calculo
integer width = 1184
integer height = 492
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge168_periodos_calculo
integer width = 1134
integer height = 416
string dataobject = "dw_ge168_detalhe_novo_calc"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge168_periodos_calculo
boolean visible = false
integer x = 567
integer y = 520
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge168_periodos_calculo
integer x = 891
integer y = 520
string text = "&Fechar"
end type

