HA$PBExportHeader$w_ge629_informacoes_produto.srw
forward
global type w_ge629_informacoes_produto from dc_w_response_ok_cancela
end type
end forward

global type w_ge629_informacoes_produto from dc_w_response_ok_cancela
integer width = 1920
integer height = 788
end type
global w_ge629_informacoes_produto w_ge629_informacoes_produto

on w_ge629_informacoes_produto.create
call super::create
end on

on w_ge629_informacoes_produto.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;//long ll_produto
//
//dw_1.Event ue_AddRow()
//dw_1.SetFocus()
//
//dc_uo_ds_base lvds
//lvds = Create dc_uo_ds_base
//lvds.Of_ChangeDataObject('dw_ge629_informacoes_produto')
//lvds.Retrieve(ll_produto)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge629_informacoes_produto
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge629_informacoes_produto
integer width = 1865
integer height = 572
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge629_informacoes_produto
integer width = 1783
integer height = 460
string dataobject = "dw_ge629_informacoes_produto"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge629_informacoes_produto
boolean visible = false
integer x = 1239
integer y = 584
boolean enabled = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge629_informacoes_produto
integer x = 1573
integer y = 584
string text = "&OK"
end type

