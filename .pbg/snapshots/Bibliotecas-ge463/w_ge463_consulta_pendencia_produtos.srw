HA$PBExportHeader$w_ge463_consulta_pendencia_produtos.srw
forward
global type w_ge463_consulta_pendencia_produtos from dc_w_response_ok_cancela
end type
end forward

global type w_ge463_consulta_pendencia_produtos from dc_w_response_ok_cancela
integer width = 2213
integer height = 1384
string title = "ge463 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos com Pend$$HEX1$$ea00$$ENDHEX$$ncia"
end type
global w_ge463_consulta_pendencia_produtos w_ge463_consulta_pendencia_produtos

on w_ge463_consulta_pendencia_produtos.create
call super::create
end on

on w_ge463_consulta_pendencia_produtos.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge463_consulta_pendencia_produtos
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge463_consulta_pendencia_produtos
integer width = 2139
integer height = 1128
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge463_consulta_pendencia_produtos
integer width = 2080
integer height = 1048
string dataobject = "dw_ge463_pendencia_produtos"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_1::constructor;call super::constructor;This.of_setRowSelection()

This.Retrieve()
end event

event dw_1::ue_addrow;//OverRide

Return -1
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge463_consulta_pendencia_produtos
integer x = 1449
integer width = 375
string text = "&Selecionar"
end type

event cb_ok::clicked;call super::clicked;Long lvl_Linha

String lvs_Produto

lvl_Linha = dw_1.GetRow()

If lvl_Linha > 0 Then
	lvs_Produto = String(dw_1.Object.cd_produto[lvl_Linha])
	CloseWithReturn(Parent, lvs_Produto)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto na lista.", Information!, Ok!)
	dw_1.SetFocus()
End If

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge463_consulta_pendencia_produtos
integer x = 1851
end type

