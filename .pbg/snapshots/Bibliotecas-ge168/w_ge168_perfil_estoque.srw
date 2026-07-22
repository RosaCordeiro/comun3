HA$PBExportHeader$w_ge168_perfil_estoque.srw
forward
global type w_ge168_perfil_estoque from dc_w_response_ok_cancela
end type
end forward

global type w_ge168_perfil_estoque from dc_w_response_ok_cancela
integer width = 1335
integer height = 1784
string title = "GE168 - Perfil de Estoque"
end type
global w_ge168_perfil_estoque w_ge168_perfil_estoque

type variables
Integer il_Perfil_Estoque
end variables

on w_ge168_perfil_estoque.create
call super::create
end on

on w_ge168_perfil_estoque.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;il_Perfil_Estoque = Long(Message.StringParm)

dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge168_perfil_estoque
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge168_perfil_estoque
integer width = 1253
integer height = 1552
integer weight = 700
string facename = "Verdana"
string text = "Dias de Cobertura"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge168_perfil_estoque
integer x = 69
integer y = 72
integer width = 1179
integer height = 1440
string dataobject = "dw_ge168_perfil_estoque"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;//OverRide

Return dw_1.Retrieve(il_Perfil_Estoque)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge168_perfil_estoque
integer x = 951
integer y = 1580
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge168_perfil_estoque
boolean visible = false
integer x = 64
integer y = 1596
boolean enabled = false
end type

