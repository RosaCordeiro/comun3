HA$PBExportHeader$w_ge569_subgrupo_almoxarifado.srw
forward
global type w_ge569_subgrupo_almoxarifado from dc_w_response_ok_cancela
end type
end forward

global type w_ge569_subgrupo_almoxarifado from dc_w_response_ok_cancela
string tag = "w_ge569_subgrupo_almoxarifado"
integer width = 1605
integer height = 1180
string title = "GE569 - Subgrupo de Almoxarifado"
end type
global w_ge569_subgrupo_almoxarifado w_ge569_subgrupo_almoxarifado

type variables
str_subgrupo istr_subgrupo

boolean ib_Check
end variables

on w_ge569_subgrupo_almoxarifado.create
call super::create
end on

on w_ge569_subgrupo_almoxarifado.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

dw_1.Event ue_Retrieve()
end event

event open;call super::open;istr_subgrupo = Message.PowerObjectParm	
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge569_subgrupo_almoxarifado
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge569_subgrupo_almoxarifado
integer width = 1531
integer height = 956
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge569_subgrupo_almoxarifado
integer width = 1467
integer height = 876
string dataobject = "dw_ge569_selecao_subgrupo"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;// OverRide
Return This.Retrieve()
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

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge569_subgrupo_almoxarifado
integer x = 905
integer y = 976
end type

event cb_ok::clicked;call super::clicked;Long ll_Find, ll_Linha, ll_Contador

String ls_Lista_Divisoes

ll_Find = dw_1.Find("id_selecionar = 'S'", 1, dw_1.RowCount())

ll_Contador = 0

If ll_Find > 0 Then
	For ll_Linha = 1 To dw_1.RowCount()
		If dw_1.Object.id_selecionar[ll_Linha] = 'S' Then
			ll_Contador++

			istr_subgrupo.cd_subgrupo[ll_Contador] = dw_1.Object.cd_subgrupo	[ll_Linha]
			istr_subgrupo.de_subgrupo[ll_Contador] = dw_1.Object.de_subgrupo	[ll_Linha]
			
		End If
	Next
	
	
	If ll_Contador = dw_1.RowCount() Then
		istr_subgrupo.de_subgrupo_in = 'TODOS'
	Else
		istr_subgrupo.de_subgrupo_in = 'SELECIONADOS'
	End If	
	
	CloseWithReturn(Parent, istr_subgrupo)
	
ElseIf ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma Subgrupo foi selecionado!", Exclamation!)
Else 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao tentar localizar se algum Subgrupo foi selecionado.")
	Close(Parent)
End If


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge569_subgrupo_almoxarifado
integer x = 1239
integer y = 976
end type

