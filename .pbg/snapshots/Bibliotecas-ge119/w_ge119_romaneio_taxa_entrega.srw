HA$PBExportHeader$w_ge119_romaneio_taxa_entrega.srw
forward
global type w_ge119_romaneio_taxa_entrega from dc_w_response_ok_cancela
end type
end forward

global type w_ge119_romaneio_taxa_entrega from dc_w_response_ok_cancela
integer width = 992
integer height = 492
string title = "GE119 - Busca Taxa de Entrega"
end type
global w_ge119_romaneio_taxa_entrega w_ge119_romaneio_taxa_entrega

type variables
uo_ge119_formula_certa ivo_FCerta

Decimal {2} idc_ValorReq, &
				idc_ValorDesc, &
				idc_ValorLiq, &
				idc_Sinal, &
				idc_Saldo
				
Long ivl_retorno_FC

Boolean ib_key

Boolean ib_Modo_Orcamento_De = False
end variables

on w_ge119_romaneio_taxa_entrega.create
call super::create
end on

on w_ge119_romaneio_taxa_entrega.destroy
call super::destroy
end on

event open;call super::open;ivo_FCerta = Create uo_ge119_formula_certa

//dw_1.SetFocus()


end event

event close;call super::close;If IsValid(ivo_FCerta) Then Destroy(ivo_FCerta)
end event

event ue_postopen;call super::ue_postopen;This.wf_centraliza_janela()



end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge119_romaneio_taxa_entrega
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge119_romaneio_taxa_entrega
integer width = 905
integer height = 236
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge119_romaneio_taxa_entrega
integer width = 827
integer height = 116
string dataobject = "dw_ge119_romaneio_taxa_entrega"
end type

event dw_1::itemchanged;call super::itemchanged;//Choose Case This.GetColumnName() 
//	Case "nr_registro_para"
//		If This.GetText() <> "" And Long(This.GetText()) > 0 Then
//			If ib_key = False Then
//				If wf_verifica_requisicao(Long(This.GetText())) Then
//					If ivl_retorno_FC = 0 Then 
//						//coloca o valor no campo
//						If idc_ValorLiq > idc_Sinal Then
//							dw_1.Object.vl_registro_para [1] = idc_ValorLiq
//							cb_OK.SetFocus()
//						Else
//							This.Event ue_Pos(1,"nr_registro_para")
//							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Requisi$$HEX2$$e700e300$$ENDHEX$$o sem Saldo $$HEX1$$e000$$ENDHEX$$ Receber.",StopSign!)
//							Return 1
//						End If
//					End If
////					If ivl_retorno_FC = 9 or ivl_retorno_FC = 10 Then //Servidor fora do ar ou em manuten$$HEX2$$e700e300$$ENDHEX$$o.
////						dw_1.Object.vl_registro.protect = 0												
////						This.SetFocus()
////						This.SetColumn("vl_registro_para")						
////					End If									
//				Else
//					Return 1
//				End If
//			End If
//		Else
//			Return 1
//		End If				
//
//End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge119_romaneio_taxa_entrega
integer x = 279
integer y = 280
end type

event cb_ok::clicked;call super::clicked;Decimal {2} pdc_taxa

dw_1.AcceptText()

If IsNull(dw_1.Object.nr_romaneio[1]) OR dw_1.Object.nr_romaneio[1] = 0 Then
	Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o Romaneio para Consulta.", Exclamation! )
	dw_1.Event ue_Pos( 1, "nr_romaneio" )
	Return
End If

If Not ivo_FCerta.of_localiza_valor_taxa_entrega(dw_1.Object.nr_romaneio[1], Ref pdc_taxa) Then
	CloseWithReturn(Parent,'CANCELAR|' +String(pdc_taxa))		
Else
	CloseWithReturn(Parent,'OK|' +String(pdc_taxa))	
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge119_romaneio_taxa_entrega
integer x = 613
integer y = 276
end type

event cb_cancelar::clicked;call super::clicked;//CloseWithReturn(Parent,'CANCELAR')
end event

