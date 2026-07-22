HA$PBExportHeader$w_ge135_consulta_promocao.srw
forward
global type w_ge135_consulta_promocao from dc_w_response_ok_cancela
end type
end forward

global type w_ge135_consulta_promocao from dc_w_response_ok_cancela
integer width = 1975
integer height = 692
string title = "GE135 - Consulta Promo$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge135_consulta_promocao w_ge135_consulta_promocao

on w_ge135_consulta_promocao.create
call super::create
end on

on w_ge135_consulta_promocao.destroy
call super::destroy
end on

event ue_postopen;//Over

dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge135_consulta_promocao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge135_consulta_promocao
integer width = 1915
integer height = 464
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge135_consulta_promocao
integer y = 72
integer width = 1851
integer height = 348
string dataobject = "dw_ge135_promocao"
end type

event dw_1::ue_recuperar;//OverRide

Long ll_Promocao, ll_Filial, ll_Produto

String ls_Retorno

ls_Retorno = Message.StringParm

ll_Filial			= Long( Mid( ls_Retorno, 1, 4 ) )

ll_Promocao 	= Long( Mid( ls_Retorno, 5, 6 ) )

ll_Produto		= Long( Mid( ls_Retorno, 11 ) )

Return This.Retrieve( ll_Promocao, ll_Produto, ll_Filial )
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then Return pl_Linhas
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge135_consulta_promocao
integer x = 1627
integer y = 488
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge135_consulta_promocao
boolean visible = false
integer x = 1262
integer y = 488
end type

