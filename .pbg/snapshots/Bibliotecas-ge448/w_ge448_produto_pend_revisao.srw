HA$PBExportHeader$w_ge448_produto_pend_revisao.srw
forward
global type w_ge448_produto_pend_revisao from dc_w_response_ok_cancela
end type
end forward

global type w_ge448_produto_pend_revisao from dc_w_response_ok_cancela
integer width = 2107
integer height = 1596
string title = "GE448 - Produto Pendente de Revis$$HEX1$$e300$$ENDHEX$$o"
end type
global w_ge448_produto_pend_revisao w_ge448_produto_pend_revisao

on w_ge448_produto_pend_revisao.create
call super::create
end on

on w_ge448_produto_pend_revisao.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge448_produto_pend_revisao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge448_produto_pend_revisao
integer width = 2030
integer height = 1352
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge448_produto_pend_revisao
integer width = 1961
integer height = 1256
string dataobject = "dw_ge448_lista"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;//OverRide

Choose Case gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
	Case "EC"
		dw_1.of_AppendWhere("a.dh_aprovacao_ecommerce is null")
		
	Case "FI"
		dw_1.of_AppendWhere("a.dh_aprovacao_fiscal is null")
		
	Case "GF"
		dw_1.of_AppendWhere("a.dh_aprovacao_farmaceutico is null")
		
	Case "GP"
		dw_1.of_AppendWhere("a.dh_aprovacao_price is null")
		
End Choose

Return This.Retrieve()
end event

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge448_produto_pend_revisao
integer x = 1399
integer y = 1384
end type

event cb_ok::clicked;call super::clicked;Long ll_Produto

dw_1.AcceptText()

If dw_1.RowCount() > 0 Then
	ll_Produto = dw_1.Object.Cd_Produto[dw_1.GetRow()]
	
	CloseWithReturn(Parent, String(ll_Produto))
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge448_produto_pend_revisao
integer x = 1742
integer y = 1384
end type

