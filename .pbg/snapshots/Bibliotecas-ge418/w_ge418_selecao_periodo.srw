HA$PBExportHeader$w_ge418_selecao_periodo.srw
forward
global type w_ge418_selecao_periodo from dc_w_response_ok_cancela
end type
end forward

global type w_ge418_selecao_periodo from dc_w_response_ok_cancela
integer x = 1038
integer y = 1092
integer width = 1687
integer height = 624
string title = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Per$$HEX1$$ed00$$ENDHEX$$odo"
end type
global w_ge418_selecao_periodo w_ge418_selecao_periodo

type variables
Long ivl_numero_promocao
end variables

event open;call super::open;X = 1050
Y = 1100

ivl_numero_promocao = Long(Message.StringParm)
end event

on w_ge418_selecao_periodo.create
call super::create
end on

on w_ge418_selecao_periodo.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;SetPointer(HourGlass!)

dw_1.Retrieve(ivl_numero_promocao)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge418_selecao_periodo
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge418_selecao_periodo
integer x = 18
integer y = 0
integer width = 1627
integer height = 324
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge418_selecao_periodo
integer x = 41
integer y = 52
integer width = 1582
integer height = 232
string dataobject = "dw_ge418_selecao_periodo"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge418_selecao_periodo
integer x = 905
integer y = 384
integer width = 352
integer height = 92
string facename = "MS Sans Serif"
end type

event cb_ok::clicked;SetPointer(HourGlass!)

uo_periodo lvo_periodo

dw_1.AcceptText()

If dw_1.Object.inicio[1] > dw_1.Object.fim[1] Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar corretamente o per$$HEX1$$ed00$$ENDHEX$$odo.", Information!, Ok!)
	dw_1.SetColumn("inicio")
	dw_1.SetRow(1)
	dw_1.SetFocus()
	Return
End If

lvo_periodo = Create uo_periodo

lvo_periodo.ivdt_inicio = dw_1.Object.inicio[1]
lvo_periodo.ivdt_fim    = dw_1.Object.fim[1]

CloseWithReturn(Parent, lvo_periodo)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge418_selecao_periodo
integer x = 1271
integer y = 384
integer width = 352
integer height = 92
string facename = "MS Sans Serif"
end type

event cb_cancelar::clicked;SetPointer(HourGlass!)

uo_periodo lvo_periodo

lvo_periodo = Create uo_periodo

SetNull(lvo_periodo.ivdt_inicio)

CloseWithReturn(Parent, lvo_periodo)
end event

