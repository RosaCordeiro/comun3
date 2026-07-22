HA$PBExportHeader$w_ge645_response_produtos_nfo.srw
forward
global type w_ge645_response_produtos_nfo from dc_w_response_ok_cancela
end type
end forward

global type w_ge645_response_produtos_nfo from dc_w_response_ok_cancela
string tag = "w_ge645_response_produtos_nfo"
integer width = 3945
integer height = 1364
string title = "GE645 - Detalhe Produtos NF Origem"
end type
global w_ge645_response_produtos_nfo w_ge645_response_produtos_nfo

type variables
Long il_Nr_Integracao
end variables

on w_ge645_response_produtos_nfo.create
call super::create
end on

on w_ge645_response_produtos_nfo.destroy
call super::destroy
end on

event open;call super::open;il_Nr_Integracao	= long(Trim(Message.StringParm))

end event

event ue_postopen;call super::ue_postopen;dw_1.retrieve( il_Nr_Integracao )
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge645_response_produtos_nfo
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge645_response_produtos_nfo
integer width = 3881
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge645_response_produtos_nfo
integer width = 3840
string dataobject = "dw_ge645_lista_produtos_nfo"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge645_response_produtos_nfo
boolean visible = false
integer x = 3237
integer y = 1160
boolean enabled = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge645_response_produtos_nfo
integer x = 3579
integer y = 1152
string text = "&Fechar"
end type

