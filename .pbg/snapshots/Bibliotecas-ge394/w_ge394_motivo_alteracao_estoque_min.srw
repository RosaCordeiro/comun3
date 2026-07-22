HA$PBExportHeader$w_ge394_motivo_alteracao_estoque_min.srw
forward
global type w_ge394_motivo_alteracao_estoque_min from dc_w_cadastro_lista
end type
end forward

global type w_ge394_motivo_alteracao_estoque_min from dc_w_cadastro_lista
integer width = 1934
integer height = 1516
string title = "GE394 - Cadastro de Motivo de Altera$$HEX2$$e700e300$$ENDHEX$$o do Estoque M$$HEX1$$ed00$$ENDHEX$$nimo"
end type
global w_ge394_motivo_alteracao_estoque_min w_ge394_motivo_alteracao_estoque_min

forward prototypes
public function boolean wf_sequencial_motivo (ref long al_motivo)
public function long wf_permite_exclusao (long al_motivo)
end prototypes

public function boolean wf_sequencial_motivo (ref long al_motivo);Select max(cd_motivo)
	Into :al_Motivo
From motivo_alteracao_estq_minimo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial do motivo de altera$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return False
End If

If IsNull(al_Motivo) Then
	al_Motivo = 0
End If

Return True
end function

public function long wf_permite_exclusao (long al_motivo);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From historico_promocao_estoque_min
Where cd_motivo_alteracao = :al_Motivo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o motivo em alguma promo$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return -1
End If

If ll_Achou > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Motivo '" + String(al_Motivo) + "' j$$HEX1$$e100$$ENDHEX$$ foi utilizado em alguma Promo$$HEX2$$e700e300$$ENDHEX$$o de Estoque M$$HEX1$$ed00$$ENDHEX$$nimo." + &
									"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitida a exclus$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
	Return 1
Else
	Return 0
End If
end function

on w_ge394_motivo_alteracao_estoque_min.create
call super::create
end on

on w_ge394_motivo_alteracao_estoque_min.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivm_Menu.mf_Excluir(False)
end event

event ue_cancel;call super::ue_cancel;ivm_Menu.mf_Excluir(False)
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge394_motivo_alteracao_estoque_min
integer x = 37
integer y = 980
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge394_motivo_alteracao_estoque_min
integer x = 0
integer y = 908
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge394_motivo_alteracao_estoque_min
integer x = 78
integer width = 1723
integer height = 1172
string dataobject = "dw_ge394_lista"
end type

event dw_1::ue_preupdate;call super::ue_preupdate;Long ll_Find
Long ll_Motivo

This.AcceptText()

ll_Find = This.Find("isnull(cd_motivo)", 1, This.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_1.", StopSign!)
	Return -1
End If

If Not wf_Sequencial_Motivo(ll_Motivo) Then Return -1

Do While ll_Find > 0
	ll_Motivo ++
	
	This.Object.Cd_Motivo[ll_Find]	= ll_Motivo
	
	ll_Find = This.Find("isnull(cd_motivo)", 1, This.RowCount())
	
	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_1.", StopSign!)
		Return -1
	End If
Loop

Return 1
end event

event dw_1::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;This.AcceptText()

If AncestorReturnValue = 1 Then
	If This.RowCount() > 0 Then
		If IsNull(This.Object.De_Motivo[This.RowCount()]) Then
			Return - 1
		End If
	End If
End If

Return AncestorReturnValue
end event

event dw_1::ue_predeleterow;call super::ue_predeleterow;//This.AcceptText()
//
//If Not IsNull(This.Object.Cd_Motivo[This.GetRow()]) Then
//	Choose Case wf_Permite_Exclusao(This.Object.Cd_Motivo[This.GetRow()])
//		Case 1
//			//
//			
//		Case 0
//			Return True
//			
//		Case -1
//			//
//	End Choose
//End If
//
//Return False

Return AncestorReturnValue
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	ivm_Menu.mf_Excluir(False)
End If

Return pl_Linhas
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;ivm_Menu.mf_Excluir(False)
end event

event dw_1::editchanged;call super::editchanged;ivm_Menu.mf_Excluir(False)
end event

event dw_1::ue_addrow;call super::ue_addrow;ivm_Menu.mf_Excluir(False)

Return AncestorReturnValue
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge394_motivo_alteracao_estoque_min
integer x = 27
integer width = 1810
end type

