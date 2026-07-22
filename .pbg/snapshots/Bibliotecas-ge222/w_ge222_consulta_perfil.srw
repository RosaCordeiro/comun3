HA$PBExportHeader$w_ge222_consulta_perfil.srw
forward
global type w_ge222_consulta_perfil from dc_w_response_ok_cancela
end type
end forward

global type w_ge222_consulta_perfil from dc_w_response_ok_cancela
integer width = 2062
integer height = 1952
string title = "GE222 - Niveis de Libera$$HEX2$$e700e300$$ENDHEX$$o de Pedidos"
end type
global w_ge222_consulta_perfil w_ge222_consulta_perfil

on w_ge222_consulta_perfil.create
call super::create
end on

on w_ge222_consulta_perfil.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
dw_1.SetFocus()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge222_consulta_perfil
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge222_consulta_perfil
integer width = 1989
integer height = 1724
integer weight = 700
string facename = "Verdana"
string text = "N$$HEX1$$ed00$$ENDHEX$$veis de Libera$$HEX2$$e700e300$$ENDHEX$$o de Pedido"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge222_consulta_perfil
integer x = 59
integer y = 76
integer width = 1929
integer height = 1604
string dataobject = "dw_ge222_nivel_liberacao_pedido"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge222_consulta_perfil
integer x = 1701
integer y = 1748
end type

event cb_ok::clicked;call super::clicked;Close(Parent)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge222_consulta_perfil
boolean visible = false
end type

