HA$PBExportHeader$w_ge498_adicionar_pagamento.srw
forward
global type w_ge498_adicionar_pagamento from dc_w_response_ok_cancela
end type
end forward

global type w_ge498_adicionar_pagamento from dc_w_response_ok_cancela
integer width = 2222
integer height = 608
string title = "GE498 - Adicionar Forma Pagamento"
end type
global w_ge498_adicionar_pagamento w_ge498_adicionar_pagamento

type variables
Decimal{2} idc_Vl_Parcela_Minima_Tef
end variables

forward prototypes
public function boolean wf_calcula_parcela (decimal adc_pagamento, integer ai_nr_parcela)
end prototypes

public function boolean wf_calcula_parcela (decimal adc_pagamento, integer ai_nr_parcela);Decimal ldc_Vl_Parcela

dw_1.Object.st_Valor_Parcela.Text = ""

If IsNull(adc_pagamento) 	Then adc_pagamento 	= 0
If IsNull(ai_nr_parcela) 		Then ai_nr_parcela 		= 1

ldc_Vl_Parcela =  Round(( adc_pagamento ) / ai_nr_parcela, 2 )

If ai_nr_parcela > 1 Then			
	If ldc_Vl_Parcela < idc_Vl_Parcela_Minima_Tef Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor m$$HEX1$$ed00$$ENDHEX$$nimo da parcela n$$HEX1$$e300$$ENDHEX$$o atingido. ( R$ " +String( idc_Vl_Parcela_Minima_Tef, '#,##0.00' ) + ' )' )
		dw_1.Object.nr_parcelas_cartao[ 1 ] = 1
		dw_1.Object.st_Valor_Parcela.Text = String(1) + "x de R$ " + String(adc_pagamento,  '#,##0.00' ) + ' sem juros'
		Return False
	End If
End If

dw_1.Object.st_Valor_Parcela.Text = String(ai_nr_parcela) + "x de R$ " + String( ldc_Vl_Parcela,  '#,##0.00' ) + ' sem juros'

Return True
end function

on w_ge498_adicionar_pagamento.create
call super::create
end on

on w_ge498_adicionar_pagamento.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;string ls_tipo

ls_tipo = message.stringparm

if ls_tipo = 'CV' then
	dw_1.Modify("cd_forma_pagamento.Values='DINHEIRO	DI/'")  
else
	dw_1.Modify("cd_forma_pagamento.Values='DINHEIRO	DI/CART$$HEX1$$c300$$ENDHEX$$O CR$$HEX1$$c900$$ENDHEX$$DITO	CP/CART$$HEX1$$c300$$ENDHEX$$O D$$HEX1$$c900$$ENDHEX$$BITO	CA/'")  
end if

uo_parametro_filial lo_Parametro
lo_Parametro = Create uo_parametro_filial
lo_Parametro.of_localiza_parametro( 'VL_PARCELA_MINIMA_TEF', Ref idc_Vl_Parcela_Minima_Tef)
If IsValid( lo_Parametro ) Then Destroy lo_Parametro
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge498_adicionar_pagamento
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge498_adicionar_pagamento
integer width = 2167
integer height = 380
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge498_adicionar_pagamento
integer width = 2112
integer height = 296
string dataobject = "dw_ge498_adicionar_pagamento"
end type

event dw_1::itemchanged;call super::itemchanged;Integer  li_Parcelas, ll_Null
Decimal ldc_Vl_Parcela, ldc_Vl_Pagamento

SetNull(ll_Null)

dw_1.AcceptText()

Choose Case Lower(dwo.Name) 
	Case "cd_forma_pagamento"
		This.Object.st_Valor_Parcela.Text = ''
		
		This.Object.nr_parcelas_cartao[ Row ] = ll_Null
		
		If Data = 'CP' Then
			This.Object.nr_parcelas_cartao[Row] = 1
			This.Event ue_Pos(1, 'vl_pagamento')
			//This.Event itemchanged( row, This.Object.nr_parcelas_cartao, '1' )
			//This.acceptText()
		End If
		
	Case "nr_parcelas_cartao"		
		ldc_Vl_Pagamento = This.Object.vl_Pagamento[1]

		If Not wf_calcula_parcela(ldc_Vl_Pagamento, Integer( Data ) ) Then
			Return 1
		End If
		
	Case "vl_pagamento"
		If This.Object.cd_forma_pagamento[1] = 'CP' Then
			li_Parcelas = This.Object.nr_parcelas_cartao[1]
			
			If Not wf_calcula_parcela(Dec( Data ), li_Parcelas ) Then
				Return 1
			End If
			
		End If
	
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge498_adicionar_pagamento
integer x = 1518
integer y = 404
integer width = 357
string text = "Confirmar"
end type

event cb_ok::clicked;call super::clicked;String ls_Forma_Pagto, ls_Retorno

Integer li_Parcelas

Decimal ldc_Pagamento

dw_1.AcceptText()

ls_Forma_Pagto 	= dw_1.Object.cd_forma_pagamento		[1]
ldc_Pagamento 	= dw_1.Object.vl_pagamento				[1]
li_Parcelas			= dw_1.Object.nr_parcelas_cartao		[1]

If IsNull(ls_Forma_Pagto) Or ls_Forma_Pagto='' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a forma de pagamento corretamente", Exclamation!)
	dw_1.Event ue_Pos(1,"cd_forma_pagamento")
	Return -1
End If

If IsNull(ldc_Pagamento) Or ldc_Pagamento <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o valor corretamente", Exclamation!)
	dw_1.Event ue_Pos(1,"vl_pagamento")
	Return -1
End If

If IsNull(li_Parcelas) Then li_Parcelas = 1

ls_Retorno = ls_Forma_Pagto + String(li_Parcelas) +  String(ldc_Pagamento)

CloseWithReturn(Parent, ls_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge498_adicionar_pagamento
integer x = 1883
integer y = 400
end type

