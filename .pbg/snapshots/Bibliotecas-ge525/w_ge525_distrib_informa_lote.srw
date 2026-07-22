HA$PBExportHeader$w_ge525_distrib_informa_lote.srw
forward
global type w_ge525_distrib_informa_lote from dc_w_response_ok_cancela
end type
end forward

global type w_ge525_distrib_informa_lote from dc_w_response_ok_cancela
integer width = 2025
string title = "GE525 - Distribuidora Informa Acordo Lote"
end type
global w_ge525_distrib_informa_lote w_ge525_distrib_informa_lote

on w_ge525_distrib_informa_lote.create
call super::create
end on

on w_ge525_distrib_informa_lote.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge525_distrib_informa_lote
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge525_distrib_informa_lote
integer x = 18
integer width = 1947
integer height = 1164
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge525_distrib_informa_lote
integer x = 50
integer width = 1874
integer height = 1080
string dataobject = "dw_ge525_distrib_informa_lote_acordo"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge525_distrib_informa_lote
integer x = 1326
integer y = 1200
string text = "Gravar"
end type

event cb_ok::clicked;call super::clicked;Boolean lb_Alteracao = False

Long ll_Linha

String ls_Distribuidora
String ls_De
String ls_Para
String ls_Erro

dw_1.AcceptText()

For ll_Linha = 1 To dw_1.RowCount()
	If gf_Houve_Alteracao_Dw(dw_1, "ID_INFORMA_LOTE_ACORDO", ll_Linha, Ref ls_Para) Then
		
		//Vai fazer a pergunta apenas na primeira altera$$HEX2$$e700e300$$ENDHEX$$o
		If Not lb_Alteracao Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 2 Then Return -1
		End If
		
		lb_Alteracao = True
		
		ls_Distribuidora = dw_1.Object.Cd_Fornecedor[ll_Linha]
		
		Update fornecedor
			Set id_informa_lote_acordo = :ls_Para
		Where cd_fornecedor = :ls_Distribuidora
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o campo id_informa_lote_acordo.", StopSign!)
			Return -1
		End If
		
		If ls_Para = "S" Then
			ls_De = "N"
		Else
			ls_De = "S"
		End If
		
		If Not gf_Grava_Historico_Alteracao_Tabela("FORNECEDOR", ls_Distribuidora, "ID_INFORMA_LOTE_ACORDO", ls_De, ls_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "A", Ref ls_Erro, True) Then Return -1
	End If
Next

If lb_Alteracao Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Altera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.")
End If

cb_Cancelar.Event Clicked()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge525_distrib_informa_lote
integer x = 1659
integer y = 1200
end type

