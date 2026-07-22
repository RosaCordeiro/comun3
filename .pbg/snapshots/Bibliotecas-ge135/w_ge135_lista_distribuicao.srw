HA$PBExportHeader$w_ge135_lista_distribuicao.srw
forward
global type w_ge135_lista_distribuicao from dc_w_response_ok_cancela
end type
end forward

global type w_ge135_lista_distribuicao from dc_w_response_ok_cancela
integer width = 3058
integer height = 1352
string title = "GE135 - Ordem do Envio dos Pedidos"
end type
global w_ge135_lista_distribuicao w_ge135_lista_distribuicao

on w_ge135_lista_distribuicao.create
call super::create
end on

on w_ge135_lista_distribuicao.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge135_lista_distribuicao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge135_lista_distribuicao
integer width = 2994
integer weight = 700
string facename = "Verdana"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge135_lista_distribuicao
integer width = 2935
string dataobject = "dw_ge135_lista_distribuicao"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event dw_1::ue_retrieve;//Over
str_parametros st

st = Message.PowerObjectParm	

Return This.Retrieve( st.cd_filial, st.nr_pedido_filial, st.cd_produto )
end event

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge135_lista_distribuicao
boolean visible = false
integer x = 1097
integer y = 1160
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge135_lista_distribuicao
integer x = 2706
integer y = 1140
string text = "&Sair"
end type

