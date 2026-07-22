HA$PBExportHeader$w_ge506_motivo_desconto.srw
forward
global type w_ge506_motivo_desconto from dc_w_response_ok_cancela
end type
end forward

global type w_ge506_motivo_desconto from dc_w_response_ok_cancela
integer width = 1271
integer height = 1232
string title = "GE506 - Motivo Desconto"
end type
global w_ge506_motivo_desconto w_ge506_motivo_desconto

type prototypes

end prototypes

type variables
Boolean ib_cliente_identificado
end variables

on w_ge506_motivo_desconto.create
call super::create
end on

on w_ge506_motivo_desconto.destroy
call super::destroy
end on

event open;call super::open; //If Not IsNull( w_cl002_venda.ivo_venda.cd_cliente ) Then
//	This.ib_cliente_identificado = True
//Else
//	This.ib_cliente_identificado = False
//End If

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge506_motivo_desconto
integer x = 87
integer y = 148
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge506_motivo_desconto
integer x = 41
integer y = 32
integer width = 1179
integer height = 988
string text = "Motivo Desconto"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge506_motivo_desconto
integer x = 78
integer y = 92
integer width = 1115
integer height = 888
string dataobject = "dw_ge506_motivo_desconto"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case This.GetColumnName() 
	Case "id_tipo_preco"
		If This.GetText() <> "" Then
			If This.GetText() = 'V' Then
				dw_1.Object.t_texto_preco.text = 'INFORME O PRE$$HEX1$$c700$$ENDHEX$$O DO PRODUTO'
				dw_1.Object.t_preco.text = 'Pre$$HEX1$$e700$$ENDHEX$$o:'				
			End If
			If This.GetText() = 'P' Then
				dw_1.Object.t_texto_preco.text = 'INFORME O PERCENTUAL DE DESCONTO'
				dw_1.Object.t_preco.text = '% Desconto:'				
			End If	
			This.SetColumn("vl_preco")			
		Else
			Return 1
		End If		
	Case "id_motivo"
		If This.GetText() <> "" Then
			If This.GetText() = 'E' Then
				dw_1.Object.id_opcao.visible = true
				dw_1.Object.t_etiqueta.visible = True
				cb_ok.enabled = True
				This.SetColumn("id_opcao")
			Else		
				dw_1.Object.id_opcao.visible = False
				dw_1.Object.t_etiqueta.visible = False
				If (Not ib_cliente_identificado) And (This.GetText() <> 'F') And (This.GetText() <> 'P') Then
					MessageBox( "Informa$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio ter um cliente identificado para este motivo!" ,Exclamation! )
					cb_ok.enabled = False
					This.SetColumn("id_motivo")
					Return -1
				Else
					cb_ok.enabled = True
				End If
				This.SetColumn("id_tipo_preco")							
			End If
		Else
			Return 1
		End If				
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge506_motivo_desconto
integer x = 571
integer y = 1032
end type

event cb_ok::clicked;call super::clicked;Decimal ldc_preco
String ls_tipo
String ls_motivo_sel
String ls_tipo_etiq
String ls_motivo_gravar

dw_1.AcceptText()

ls_tipo			= dw_1.Object.id_tipo_preco[1]
ldc_preco 		= dw_1.Object.vl_preco[1]
ls_motivo_sel 	= dw_1.Object.id_motivo[1]
ls_tipo_etiq		= dw_1.Object.id_opcao[1]

If ldc_preco <= 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor informado inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
	dw_1.SetColumn("vl_preco")
	dw_1.SetFocus()
	dw_1.SelectText(1,10)
	Return
End If

If ldc_preco >= 100 And ls_tipo = 'P' Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Percentual de desconto informado inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
	dw_1.SetColumn("vl_preco")
	dw_1.SetFocus()
	dw_1.SelectText(1,10)
	Return
End If

Choose Case ls_motivo_sel
	Case 'E'
		If IsNull(ls_tipo_etiq) Or Trim(ls_tipo_etiq) = '' Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um motivo para Etiqueta de pre$$HEX1$$e700$$ENDHEX$$o errada.", Exclamation!)
			dw_1.SetColumn("id_opcao")
			dw_1.SetFocus()
			Return			
		End If
		ls_motivo_gravar = ls_tipo_etiq
	Case 'D'
		ls_motivo_gravar = 'PD'
	Case 'L'
		ls_motivo_gravar = 'LCT'
	Case 'G'
		ls_motivo_gravar = 'GER'
	Case 'P'
		ls_motivo_gravar = 'DP'		
	Case 'F'
		ls_motivo_gravar = 'FRT'
	Case Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum motivo selecionado.", Exclamation!)
		dw_1.SetColumn("id_motivo")
		dw_1.SetFocus()
		Return
End Choose

If ls_motivo_sel = 'D' Or ls_motivo_sel = 'L' Or ls_motivo_sel = 'G' Then
	If Not ib_cliente_identificado Then
		MessageBox( "Informa$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio ter um cliente identificado para esse Motivo." ,Exclamation! )
		Return
	End If
End If

CloseWithReturn(Parent,ls_tipo + '|' +String(ldc_preco)+ '|' + ls_motivo_gravar)

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge506_motivo_desconto
integer x = 905
integer y = 1032
end type

