HA$PBExportHeader$w_ge138_historico_alteracao.srw
forward
global type w_ge138_historico_alteracao from dc_w_response_ok_cancela
end type
end forward

global type w_ge138_historico_alteracao from dc_w_response_ok_cancela
integer width = 3511
integer height = 1436
string title = "GE138 - Hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es"
end type
global w_ge138_historico_alteracao w_ge138_historico_alteracao

on w_ge138_historico_alteracao.create
call super::create
end on

on w_ge138_historico_alteracao.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String ls_Retorno

Long ll_Filial
Long ll_Produto

ls_Retorno = Message.StringParm

ll_Filial = Long( Mid(ls_Retorno, 1, 4) )

ll_Produto = Long( MId(ls_Retorno, 5) )

dw_1.Retrieve(ll_Filial, ll_Produto )
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge138_historico_alteracao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge138_historico_alteracao
integer width = 3442
integer height = 1224
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge138_historico_alteracao
integer width = 3369
integer height = 1132
string dataobject = "dw_ge138_lista_hist_alteracao"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge138_historico_alteracao
integer x = 3154
integer y = 1236
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge138_historico_alteracao
boolean visible = false
integer x = 1984
integer y = 1240
end type

