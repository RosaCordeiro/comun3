HA$PBExportHeader$w_ge039_informar_vale_desconto.srw
forward
global type w_ge039_informar_vale_desconto from dc_w_response_ok_cancela
end type
end forward

global type w_ge039_informar_vale_desconto from dc_w_response_ok_cancela
integer width = 1152
integer height = 524
string title = "GE039 - Vale Desconto"
end type
global w_ge039_informar_vale_desconto w_ge039_informar_vale_desconto

type variables
uo_ge039_vale_desconto io_Vale 
end variables

on w_ge039_informar_vale_desconto.create
call super::create
end on

on w_ge039_informar_vale_desconto.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;io_Vale = Create uo_ge039_vale_desconto
end event

event close;call super::close;If IsValid(io_Vale) Then Destroy io_Vale
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge039_informar_vale_desconto
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge039_informar_vale_desconto
integer width = 1088
integer height = 296
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge039_informar_vale_desconto
integer width = 1033
integer height = 188
string dataobject = "dw_ge039_informa_vale_desconto"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge039_informar_vale_desconto
integer x = 805
integer y = 316
end type

event cb_ok::clicked;call super::clicked;String ls_Nr_Vale, ls_De_Vale_Desconto

Decimal ldc_pc_desconto

Long ll_Campanha

dw_1.AcceptText()

ls_De_Vale_Desconto = dw_1.Object.nr_vale_desconto[1]

If IsNull(ls_De_Vale_Desconto) Or Trim(ls_De_Vale_Desconto) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o nr. do vale desconto.", Exclamation!)
	Return -1
End If

ls_Nr_Vale = Mid( ls_De_Vale_Desconto, 2, 10 )

If LenA(ls_Nr_Vale) <> 10 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O n$$HEX1$$fa00$$ENDHEX$$mero informado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
	Return -1
End If

str_cupom_desconto_pos_venda st_parametros

ls_Nr_Vale = String( LongLong( ls_Nr_Vale ) )

If Not io_Vale.of_localiza_vale_desconto( ls_Nr_Vale, ls_De_Vale_Desconto, Ref ll_Campanha ) Then
	dw_1.Object.nr_vale_desconto[1] = ''
	Return -1
End If

If Not io_Vale.of_pc_desconto( ll_Campanha, Ref ldc_pc_desconto) then
	Return -1
End If

st_parametros.nr_vale_desconto 	= ls_Nr_Vale
st_parametros.nr_campanha	   	= ll_Campanha
st_parametros.pc_desconto		   	= ldc_pc_desconto
st_parametros.de_vale_desconto	= ls_De_Vale_Desconto

CloseWithReturn( Parent, st_parametros )


   
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge039_informar_vale_desconto
integer x = 27
integer y = 316
boolean cancel = false
end type

