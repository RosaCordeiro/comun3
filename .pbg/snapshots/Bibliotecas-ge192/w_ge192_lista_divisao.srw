HA$PBExportHeader$w_ge192_lista_divisao.srw
forward
global type w_ge192_lista_divisao from dc_w_response_ok_cancela
end type
end forward

global type w_ge192_lista_divisao from dc_w_response_ok_cancela
integer width = 2898
integer height = 820
string title = "GE192 - Lista Divis$$HEX1$$e300$$ENDHEX$$o Fornecedor"
end type
global w_ge192_lista_divisao w_ge192_lista_divisao

on w_ge192_lista_divisao.create
call super::create
end on

on w_ge192_lista_divisao.destroy
call super::destroy
end on

event ue_postopen;//OverRide

st_fornecedor str

str = Message.PowerObjectParm

dw_1.Retrieve(str.Cd_Fornecedor)

dw_1.SetFocus()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge192_lista_divisao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge192_lista_divisao
integer width = 2830
integer height = 604
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge192_lista_divisao
integer width = 2770
integer height = 520
string dataobject = "dw_ge192_lista_divisao"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_1::getfocus;call super::getfocus;Cb_Ok.Default = True
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge192_lista_divisao
integer x = 2542
integer y = 624
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge192_lista_divisao
boolean visible = false
integer x = 37
integer y = 616
end type

