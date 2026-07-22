HA$PBExportHeader$w_ge253_confirma_gravacao.srw
forward
global type w_ge253_confirma_gravacao from dc_w_response_ok_cancela
end type
end forward

global type w_ge253_confirma_gravacao from dc_w_response_ok_cancela
integer width = 3543
integer height = 1984
string title = "GE253 - Confirma$$HEX2$$e700e300$$ENDHEX$$o Dados Lote Cont$$HEX1$$e100$$ENDHEX$$bil"
end type
global w_ge253_confirma_gravacao w_ge253_confirma_gravacao

on w_ge253_confirma_gravacao.create
call super::create
end on

on w_ge253_confirma_gravacao.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge253_confirma_gravacao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge253_confirma_gravacao
integer width = 3488
integer height = 1732
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge253_confirma_gravacao
integer width = 3429
integer height = 1640
string dataobject = "dw_ge253_lista_itens"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;Long lvl_Lote

lvl_Lote = Message.DoubleParm

Return dw_1.Retrieve(lvl_Lote)
end event

event dw_1::constructor;call super::constructor;This.Of_SetRowselection( )
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge253_confirma_gravacao
integer x = 2862
integer y = 1772
end type

event cb_ok::clicked;call super::clicked;Decimal{2} lvdc_Diferenca

lvdc_Diferenca	= dw_1.getitemdecimal( 0, 'vl_total_diferenca')

If (Not IsNull(lvdc_Diferenca)) and (lvdc_Diferenca > 0) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Existe uma diferen$$HEX1$$e700$$ENDHEX$$a de '+String(lvdc_Diferenca,'#,##0.00')+' entre cr$$HEX1$$e900$$ENDHEX$$dito e d$$HEX1$$e900$$ENDHEX$$bito e este lote n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ gravado.',Exclamation!)
	Return -1
End If

CloseWithReturn(Parent,'S')
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge253_confirma_gravacao
integer x = 3195
integer y = 1772
end type

event cb_cancelar::clicked;CloseWithReturn(Parent,'N')
end event

