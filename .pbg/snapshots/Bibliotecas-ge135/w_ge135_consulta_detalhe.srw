HA$PBExportHeader$w_ge135_consulta_detalhe.srw
forward
global type w_ge135_consulta_detalhe from dc_w_response_ok_cancela
end type
type st_1 from statictext within w_ge135_consulta_detalhe
end type
end forward

global type w_ge135_consulta_detalhe from dc_w_response_ok_cancela
integer width = 2482
integer height = 1380
string title = "GE135 - Detalhes do Pedido"
st_1 st_1
end type
global w_ge135_consulta_detalhe w_ge135_consulta_detalhe

forward prototypes
public function long wf_arredonda (decimal adc_base, decimal adc_limite)
end prototypes

public function long wf_arredonda (decimal adc_base, decimal adc_limite);Decimal lvdc_Decimal

Long lvl_Base

lvl_Base     = Truncate(adc_Base, 0)
lvdc_Decimal = adc_Base - lvl_Base

If lvdc_Decimal >= adc_Limite Then
	lvl_Base += 1
End If	

Return lvl_Base
end function

on w_ge135_consulta_detalhe.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_ge135_consulta_detalhe.destroy
call super::destroy
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge135_consulta_detalhe
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge135_consulta_detalhe
integer width = 2405
integer height = 1048
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge135_consulta_detalhe
integer x = 46
integer height = 1124
string dataobject = "dw_ge135_detalhe_pedido"
end type

event dw_1::ue_recuperar;//Over
String ls_retorno

Long ll_Pedido, ll_Filial, ll_Produto

ls_Retorno = Message.StringParm

ll_Filial		= Long( Mid( ls_Retorno, 1, 4 ) )

ll_Pedido 	= Long( Mid( ls_Retorno, 5, 8 ) )

ll_Produto	= Long( Mid( ls_Retorno, 13 ) )

Return This.Retrieve( ll_Filial, ll_Pedido, ll_Produto )
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;Long ll_EB, ll_Dias_Cob, ll_Minimo, ll_Reforco, ll_EB_Utilizado, ll_Calculado

Decimal ldc_Demanda, ldc_Cob_Extra, ldc_Fat_Conv

Decimal ldc_Cobert_Total

Decimal lvdc_Estoque_Calculado, lvdc_Estoque_Decimal

String ls_MSG = ''

If pl_Linhas > 0 Then
	
	//	qt_dias_reforco_estoque
	
	ll_EB 				= This.Object.qt_estoque_base		[1]
	ll_Minimo		= This.Object.qt_estoque_minimo	[1]
	ldc_Demanda	= This.Object.qt_demanda_diaria	[1]
	ll_Dias_Cob		= This.Object.qt_dias_cobertura	[1]
	ldc_Fat_Conv	= This.Object.vl_fator_conversao	[1]
		
	ll_Reforco		= This.Object.qt_dias_reforco		[1] // refor$$HEX1$$e700$$ENDHEX$$o 
	ldc_Cob_Extra	= This.Object.qt_cobertura_extra	[1]
	
	If ll_Minimo > ll_EB Then
		ll_EB_Utilizado = ll_Minimo
		ls_MSG = "[MINIMO DE PROMOCAO] -> O m$$HEX1$$ed00$$ENDHEX$$nimo esta maior que o estoque base"
	Else
		ll_EB_Utilizado = ll_EB
	End If
	
	ldc_Cobert_Total = ll_Reforco + ldc_Cob_Extra
	
	If ldc_Cobert_Total > 0 Then
		ll_Calculado = wf_Arredonda(Round(ldc_Demanda * (ldc_Cobert_Total + ll_Dias_Cob), 2), 0.5)
	End If
				
	// Verifica o fator de convers$$HEX1$$e300$$ENDHEX$$o
	If ll_Calculado > 0 and ldc_Fat_Conv > 1 Then
		lvdc_Estoque_Calculado = Round(ll_Calculado / ldc_Fat_Conv, 2)

		ll_Calculado = Truncate(lvdc_Estoque_Calculado, 0)
		lvdc_Estoque_Decimal  = lvdc_Estoque_Calculado - ll_Calculado
		
		If lvdc_Estoque_Decimal > 0 Then
			ll_Calculado += 1
		End If
		
		ll_Calculado = Truncate(ll_Calculado * ldc_Fat_Conv, 0)
	End If
	
	If ll_Calculado > ll_EB_Utilizado Then
		ls_MSG = "[DIAS DE REFOR$$HEX1$$c700$$ENDHEX$$O] -> Foi calculado um novo EB utilizando a f$$HEX1$$f300$$ENDHEX$$rmula [(Dias de cobertura + dias de refor$$HEX1$$e700$$ENDHEX$$o) * Demanda di$$HEX1$$e100$$ENDHEX$$ria]"
		ll_EB_Utilizado = ll_Calculado
	End If
	
	This.Object.qt_eb_utilizado	[1] = ll_EB_Utilizado
	This.Object.t_mensagem.Text = ls_MSG
	
	If ll_EB_Utilizado > ll_EB Then
		This.Object.qt_eb_utilizado_t.Visible 	= True
		This.Object.qt_eb_utilizado.Visible 	= True
		This.Object.t_mensagem.Visible 		= True
		//pb_1.Visible 		= True
	End If

End If

Return pl_Linhas
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge135_consulta_detalhe
integer x = 2117
integer y = 1184
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge135_consulta_detalhe
boolean visible = false
integer x = 1673
integer y = 1184
end type

type st_1 from statictext within w_ge135_consulta_detalhe
integer x = 27
integer y = 1196
integer width = 1632
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "As informa$$HEX2$$e700f500$$ENDHEX$$es s$$HEX1$$e300$$ENDHEX$$o do momento em que o pedido foi gerado"
boolean focusrectangle = false
end type

