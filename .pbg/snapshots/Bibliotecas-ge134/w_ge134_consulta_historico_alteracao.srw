HA$PBExportHeader$w_ge134_consulta_historico_alteracao.srw
forward
global type w_ge134_consulta_historico_alteracao from dc_w_response_ok_cancela
end type
end forward

global type w_ge134_consulta_historico_alteracao from dc_w_response_ok_cancela
integer width = 4603
integer height = 1452
string title = "GE134 - Hist$$HEX1$$f300$$ENDHEX$$rico Altera$$HEX2$$e700e300$$ENDHEX$$o Estoque M$$HEX1$$ed00$$ENDHEX$$nimo"
end type
global w_ge134_consulta_historico_alteracao w_ge134_consulta_historico_alteracao

type variables

end variables

on w_ge134_consulta_historico_alteracao.create
call super::create
end on

on w_ge134_consulta_historico_alteracao.destroy
call super::destroy
end on

event open;call super::open;Long ll_Linhas

st_parametro_historico str

str = Message.PowerObjectParm

ll_Linhas = dw_1.Retrieve(str.Cd_Promocao, str.Cd_Filial, str.Cd_Produto)

Choose Case ll_Linhas
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto n$$HEX1$$e300$$ENDHEX$$o tem hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o.")
		Cb_Ok.Event Clicked()
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw_1.", StopSign!)
		Cb_Ok.Event Clicked()
				
End Choose
end event

event ue_postopen;//OverRide

dw_1.SetFocus()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge134_consulta_historico_alteracao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge134_consulta_historico_alteracao
integer width = 4526
integer height = 1216
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge134_consulta_historico_alteracao
integer width = 4466
integer height = 1124
string dataobject = "dw_ge134_lista_alteracao"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge134_consulta_historico_alteracao
integer x = 4238
integer y = 1236
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge134_consulta_historico_alteracao
boolean visible = false
integer x = 3831
integer y = 1236
end type

