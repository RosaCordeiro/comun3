HA$PBExportHeader$w_ge144_nota_servico.srw
forward
global type w_ge144_nota_servico from dc_w_response_ok_cancela
end type
end forward

global type w_ge144_nota_servico from dc_w_response_ok_cancela
integer width = 1440
integer height = 640
string title = "GE144 - Nota Fiscal de Servi$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge144_nota_servico w_ge144_nota_servico

on w_ge144_nota_servico.create
call super::create
end on

on w_ge144_nota_servico.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge144_nota_servico
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge144_nota_servico
integer width = 1376
integer height = 392
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge144_nota_servico
integer width = 1294
integer height = 304
string dataobject = "dw_ge144_nota_servico"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge144_nota_servico
integer x = 750
integer y = 424
end type

event cb_ok::clicked;call super::clicked;LOng ll_NF_Servico

dw_1.AcceptText()

ll_NF_Servico = dw_1.Object.nr_nf_servico[1]

If ll_NF_Servico <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O n$$HEX1$$fa00$$ENDHEX$$mero informado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.")
	dw_1.Event ue_Pos(1,"nr_nf_servico")
	Return -1
End If

CloseWithReturn(Parent, String(ll_NF_Servico) )
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge144_nota_servico
integer x = 1083
integer y = 424
end type

