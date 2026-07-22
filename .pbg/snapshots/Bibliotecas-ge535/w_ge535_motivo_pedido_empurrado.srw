HA$PBExportHeader$w_ge535_motivo_pedido_empurrado.srw
forward
global type w_ge535_motivo_pedido_empurrado from dc_w_cadastro_lista
end type
end forward

global type w_ge535_motivo_pedido_empurrado from dc_w_cadastro_lista
string tag = "w_gc026_motivo_pedido_empurrado"
integer width = 2277
integer height = 1492
string title = "GE535 - Cadastro Motivo Empurrado"
end type
global w_ge535_motivo_pedido_empurrado w_ge535_motivo_pedido_empurrado

forward prototypes
public function boolean wf_sequencial_motivo (ref long al_motivo)
public function long wf_permite_exclusao (long al_motivo)
public function boolean wf_verifica_registro_duplicado (string as_de_motivo)
end prototypes

public function boolean wf_sequencial_motivo (ref long al_motivo);Select max(cd_motivo_empurrado)
	Into :al_Motivo
From pedido_empurrado_motivo
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
From pedido_empurrado
Where cd_motivo_empurrado = :al_Motivo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o motivo em algum pedido empurrado.", StopSign!)
	Return -1
End If

If ll_Achou > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Motivo '" + String(al_Motivo) + "' j$$HEX1$$e100$$ENDHEX$$ foi utilizado em algum Pedido empurrado." + &
									"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitida a exclus$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
	Return 1
Else
	Return 0
End If
end function

public function boolean wf_verifica_registro_duplicado (string as_de_motivo);Long ll_Find
Long ll_Contador = 0

String ls_Find
String ls_Mensagem

dw_1.AcceptText()

ll_Find = dw_1.Find("de_motivo_empurrado = '" + as_de_motivo+ "'", 1, dw_1.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_1.", StopSign!)
	Return False
End If

Do While ll_Find > 0
	
	ll_Contador ++
	
	If ll_Contador > 1 Then
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Motivo: " +as_de_motivo + " j$$HEX1$$e100$$ENDHEX$$ cadastrado.", Exclamation!)
		Return False
	End If
	
	If ll_Find < dw_1.RowCount() Then
		ll_Find = dw_1.Find("de_motivo_empurrado = '" + as_de_motivo+ "'", ll_Find + 1, dw_1.RowCount())

		If ll_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_1.", StopSign!)
			Return False
		End If
	Else
		ll_Find = 0
	End If
Loop

Return True
end function

on w_ge535_motivo_pedido_empurrado.create
call super::create
end on

on w_ge535_motivo_pedido_empurrado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge535_motivo_pedido_empurrado
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge535_motivo_pedido_empurrado
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge535_motivo_pedido_empurrado
integer width = 2112
string dataobject = "dw_ge535_lista"
boolean controlmenu = true
end type

event dw_1::ue_preupdate;call super::ue_preupdate;Long ll_Find
Long ll_Motivo
Long ll_Linha

This.AcceptText()

ll_Find = This.Find("isnull(de_motivo_empurrado) Or Trim(de_motivo_empurrado) = '' ", 1, This.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_1.", StopSign!)
	Return -1
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Motivo n$$HEX1$$e300$$ENDHEX$$o pode ser vazio. ", Exclamation!)
	dw_1.Event ue_Pos(ll_Find,"de_motivo_empurrado") 
	Return -1
End If

ll_Find = This.Find("isnull(cd_motivo)", 1, This.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_1.", StopSign!)
	Return -1
End If


If ll_Find > 0 Then
	If Not wf_verifica_registro_duplicado(dw_1.Object.De_Motivo_Empurrado[ll_Find]) Then Return -1
	
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
End If


Return 1
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;This.AcceptText()

If AncestorReturnValue = 1 Then
	If This.RowCount() > 0 Then
		If IsNull(This.Object.De_Motivo_Empurrado[This.RowCount()]) Then
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
//			Return False
//			
//		Case 0
//			Return True
//			
//		Case -1
//			Return False
//	End Choose
//End If
//
//Return False
//
Return AncestorReturnValue
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;Parent.ivm_Menu.mf_Excluir(False)
Return pl_Linhas
end event

event dw_1::getfocus;call super::getfocus;Parent.ivm_Menu.mf_Excluir(False)
end event

event dw_1::ue_addrow;call super::ue_addrow;Parent.ivm_Menu.mf_Excluir(False)
Return AncestorReturnValue
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge535_motivo_pedido_empurrado
integer width = 2181
end type

