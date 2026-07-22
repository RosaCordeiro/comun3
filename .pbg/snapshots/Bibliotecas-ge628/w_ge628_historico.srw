HA$PBExportHeader$w_ge628_historico.srw
forward
global type w_ge628_historico from dc_w_response_ok_cancela
end type
end forward

global type w_ge628_historico from dc_w_response_ok_cancela
integer width = 3543
integer height = 1372
string title = "GE628 - Bloqueio Distribuidora(Historico)"
end type
global w_ge628_historico w_ge628_historico

type variables
String ivs_Parametros

end variables

on w_ge628_historico.create
call super::create
end on

on w_ge628_historico.destroy
call super::destroy
end on

event open;call super::open;ivs_Parametros = Message.StringParm


end event

event ue_postopen;call super::ue_postopen;dw_1.retrieve (ivs_Parametros)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge628_historico
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge628_historico
integer width = 3488
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge628_historico
integer width = 3438
integer height = 1048
string title = "GE628_Bloqueio_Distrib_Bloq"
string dataobject = "dw_ge628_historico"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge628_historico
boolean visible = false
integer x = 2619
integer y = 1176
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge628_historico
integer x = 3090
end type

