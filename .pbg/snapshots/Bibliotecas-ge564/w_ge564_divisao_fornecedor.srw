HA$PBExportHeader$w_ge564_divisao_fornecedor.srw
forward
global type w_ge564_divisao_fornecedor from dc_w_response_ok_cancela
end type
end forward

global type w_ge564_divisao_fornecedor from dc_w_response_ok_cancela
integer height = 1372
string title = "GE564 - Divis$$HEX1$$e300$$ENDHEX$$o Fornecedor"
end type
global w_ge564_divisao_fornecedor w_ge564_divisao_fornecedor

type variables
str_divisao_fornecedor istr_divisao_fornecedor

boolean ib_Check
end variables

on w_ge564_divisao_fornecedor.create
call super::create
end on

on w_ge564_divisao_fornecedor.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

dw_1.Event ue_Retrieve()
end event

event open;call super::open;istr_divisao_fornecedor = Message.PowerObjectParm	
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge564_divisao_fornecedor
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge564_divisao_fornecedor
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge564_divisao_fornecedor
integer width = 2299
integer height = 1016
string dataobject = "dw_ge564_divisao_fornecedor"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;// OverRide
String ls_Fornecedor

ls_Fornecedor = istr_divisao_fornecedor.cd_fornecedor

Return This.Retrieve(ls_Fornecedor)
end event

event dw_1::doubleclicked;call super::doubleclicked;String ls_Marcacao

Integer li_Row

//If istr_divisao_fornecedor.id_selecao_varias_divisoes = 'S' Then
If dwo.Name = "p_imagem" Then
	If ib_Check Then
		ls_Marcacao = 'N'
		ib_Check 	 = False
	Else
		ls_Marcacao = 'S'
		ib_Check 	 = True
	End If
	
	For li_Row = 1 To This.RowCount()
		This.Object.id_selecionar[li_Row] = ls_Marcacao
	Next
End If
//Else
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitido a sele$$HEX2$$e700e300$$ENDHEX$$o de mais de uma divis$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
//End If
end event

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_1::itemchanged;call super::itemchanged;//If This.GetColumnName() = 'id_selecionar'  Then
//	If istr_divisao_fornecedor.id_selecao_varias_divisoes = 'N' Then
//		If data = 'S' Then
//			If dw_1.GetItemNumber(dw_1.RowCount(), "total_divisoes") > 0 Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitido a sele$$HEX2$$e700e300$$ENDHEX$$o de mais de uma divis$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
//				Return 1
//			End If
//		End If
//	End If
//End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge564_divisao_fornecedor
integer x = 1801
integer y = 1156
end type

event cb_ok::clicked;call super::clicked;Long ll_Find, ll_Linha, ll_Contador

String ls_Lista_Divisoes

ll_Find = dw_1.Find("id_selecionar = 'S'", 1, dw_1.RowCount())

ll_Contador = 0

If ll_Find > 0 Then
	For ll_Linha = 1 To dw_1.RowCount()
		If dw_1.Object.id_selecionar[ll_Linha] = 'S' Then
			ll_Contador++
			
//			istr_divisao_fornecedor.cd_fornecedor 					  = dw_1.Object.Cd_Fornecedor	[ll_Linha]
			istr_divisao_fornecedor.nr_divisao			[ll_Contador] = dw_1.Object.nr_divisao			[ll_Linha]
			istr_divisao_fornecedor.de_divisao			[ll_Contador] = dw_1.Object.de_divisao			[ll_Linha]
			istr_divisao_fornecedor.nm_fantasia		 				  = dw_1.Object.nm_fantasia		[ll_Linha]
			
//			If ll_Contador = 1 Then
//				ls_Lista_Divisoes =  String(dw_1.Object.nr_divisao[ll_Linha])
//			Else
//				ls_Lista_Divisoes =  ls_Lista_Divisoes + ", " + String(dw_1.Object.nr_divisao[ll_Linha])
//			End If
		End If
	Next
	
//	istr_divisao_fornecedor.nr_divisoes_in = ls_Lista_Divisoes
	
	If ll_Contador = dw_1.RowCount() Then
		istr_divisao_fornecedor.nr_divisoes_in = 'TODOS'
	Else
		istr_divisao_fornecedor.nr_divisoes_in = 'SELECIONADOS'
	End If	
	
	CloseWithReturn(Parent, istr_divisao_fornecedor)
	
ElseIf ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma divis$$HEX1$$e300$$ENDHEX$$o foi selecionada.", Exclamation!)
Else 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find ao localizar se alguma divis$$HEX1$$e300$$ENDHEX$$o foi selecionada.")
	Close(Parent)
End If


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge564_divisao_fornecedor
integer x = 2135
integer y = 1156
end type

