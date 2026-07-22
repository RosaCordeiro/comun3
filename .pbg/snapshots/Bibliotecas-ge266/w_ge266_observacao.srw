HA$PBExportHeader$w_ge266_observacao.srw
forward
global type w_ge266_observacao from dc_w_response_ok_cancela
end type
end forward

global type w_ge266_observacao from dc_w_response_ok_cancela
integer width = 2176
integer height = 616
string title = "GE266 - Lote Devolu$$HEX2$$e700e300$$ENDHEX$$o Compra"
end type
global w_ge266_observacao w_ge266_observacao

on w_ge266_observacao.create
call super::create
end on

on w_ge266_observacao.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge266_observacao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge266_observacao
integer width = 2103
integer height = 384
integer weight = 700
string facename = "Verdana"
string text = "Observa$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge266_observacao
integer y = 76
integer width = 2053
integer height = 304
string dataobject = "dw_ge266_observacao"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge266_observacao
integer x = 1472
integer y = 416
string facename = "Verdana"
end type

event cb_ok::clicked;call super::clicked;String lvs_Observacao

dw_1.AcceptText()

lvs_Observacao = dw_1.Object.de_observacao[1]

If IsNull(lvs_Observacao) or Trim(lvs_Observacao) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a observa$$HEX2$$e700e300$$ENDHEX$$o da simula$$HEX2$$e700e300$$ENDHEX$$o corretamente.", Information!)
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "de_observacao")
	Return 
End If

CloseWithReturn(Parent, lvs_Observacao)

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge266_observacao
integer x = 1819
integer y = 416
string facename = "Verdana"
end type

event cb_cancelar::clicked;//OverRide

//cb_ok.Event clicked()

CloseWithReturn(Parent, "")
end event

