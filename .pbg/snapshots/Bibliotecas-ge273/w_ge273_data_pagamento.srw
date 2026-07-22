HA$PBExportHeader$w_ge273_data_pagamento.srw
forward
global type w_ge273_data_pagamento from dc_w_response_ok_cancela
end type
end forward

global type w_ge273_data_pagamento from dc_w_response_ok_cancela
integer width = 846
integer height = 432
string title = "GE273 - Data Pagamento"
end type
global w_ge273_data_pagamento w_ge273_data_pagamento

type variables
Date	ivdt_Movimento
end variables

forward prototypes
public function string wf_identifica_valor_parametro (string ps_parametro, integer pi_coluna)
end prototypes

public function string wf_identifica_valor_parametro (string ps_parametro, integer pi_coluna);String lvs_Coluna

Integer lvi_Contador, &
        lvi_Posicao = -2, &
        lvi_Start

For lvi_Contador = 1 To pi_Coluna
	lvi_Start = lvi_Posicao + 3
	
	lvi_Posicao = PosA(ps_Parametro, "@#!", lvi_Start)
Next

If lvi_Posicao = 0 Then
	lvs_Coluna = MidA(ps_Parametro, lvi_Start)
Else
	lvs_Coluna = MidA(ps_Parametro, lvi_Start, lvi_Posicao - lvi_Start)
End If

Return lvs_Coluna
end function

on w_ge273_data_pagamento.create
call super::create
end on

on w_ge273_data_pagamento.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Parametro

Date 	lvdt_Pagamento

lvs_Parametro = Message.StringParm

ivdt_Movimento = Date(wf_Identifica_Valor_Parametro(lvs_Parametro,1))
lvdt_Pagamento = Date(wf_Identifica_Valor_Parametro(lvs_Parametro,2))

If String(lvdt_Pagamento,"DD/MM/YYYY") = "01/01/1900" Then
	dw_1.Object.Dt_Pagamento[1] = ivdt_Movimento
Else
	dw_1.Object.Dt_Pagamento[1] = lvdt_Pagamento
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge273_data_pagamento
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge273_data_pagamento
integer width = 773
integer height = 184
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge273_data_pagamento
integer width = 713
integer height = 92
string dataobject = "dw_ge273_selecao_dt_pagamento"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge273_data_pagamento
integer x = 155
integer y = 220
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

Date	lvdt_Pagamento

dw_1.AcceptText()

lvdt_Pagamento = dw_1.Object.Dt_Pagamento[1]

If lvdt_Pagamento < ivdt_Movimento Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","A data de pagamento n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data de movimento.", Exclamation!)
	Return
End If

lvs_Retorno = String(lvdt_Pagamento, "YYYY/MM/DD")

CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge273_data_pagamento
integer x = 489
integer y = 220
end type

