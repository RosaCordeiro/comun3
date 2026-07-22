HA$PBExportHeader$w_ge350_periodo_aprovacao_venc.srw
forward
global type w_ge350_periodo_aprovacao_venc from dc_w_response_ok_cancela
end type
end forward

global type w_ge350_periodo_aprovacao_venc from dc_w_response_ok_cancela
integer width = 1399
integer height = 548
string title = "GE350 - Per$$HEX1$$ed00$$ENDHEX$$odo de Aprova$$HEX2$$e700e300$$ENDHEX$$o Autom$$HEX1$$e100$$ENDHEX$$tica"
end type
global w_ge350_periodo_aprovacao_venc w_ge350_periodo_aprovacao_venc

type variables
str_ge350_periodo_aprovacao st
end variables

on w_ge350_periodo_aprovacao_venc.create
call super::create
end on

on w_ge350_periodo_aprovacao_venc.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Inicio		[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Termino	[1] = gvo_Parametro.of_Dh_Movimentacao()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge350_periodo_aprovacao_venc
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge350_periodo_aprovacao_venc
integer width = 1330
integer height = 296
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge350_periodo_aprovacao_venc
integer width = 1271
integer height = 204
string dataobject = "dw_ge350_selecao_periodo"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge350_periodo_aprovacao_venc
integer x = 709
integer y = 328
end type

event cb_ok::clicked;call super::clicked;DateTime ldh_Inicio
DateTime ldh_Termino

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.Dh_Inicio		[1]
ldh_Termino	= dw_1.Object.Dh_Termino	[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da retirada.")
	dw_1.Event ue_Pos(dw_1.GetRow(), "dh_inicio")	
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da retirada.")
	dw_1.Event ue_Pos(dw_1.GetRow(), "dh_termino")	
	Return -1
End If

If ldh_Inicio < gvo_Parametro.of_Dh_Movimentacao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data corrente.")
	dw_1.Event ue_Pos(dw_1.GetRow(), "dh_inicio")	
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da retirada n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da retirada.")
	dw_1.Event ue_Pos(dw_1.GetRow(), "dh_termino")	
	Return -1
End If

st.Dh_Inicio		= ldh_Inicio
st.Dh_Termino	= ldh_Termino

CloseWithReturn(Parent, st)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge350_periodo_aprovacao_venc
integer x = 1042
integer y = 328
end type

event cb_cancelar::clicked;//OverRide

SetNull(st.Dh_Inicio)
SetNull(st.Dh_Termino)

CloseWithReturn(Parent, st)
end event

