HA$PBExportHeader$w_ge187_selecao_conta_sap.srw
forward
global type w_ge187_selecao_conta_sap from dc_w_selecao_generica
end type
end forward

global type w_ge187_selecao_conta_sap from dc_w_selecao_generica
integer width = 2053
string title = "GE187 - Sele$$HEX2$$e700e300$$ENDHEX$$o Conta SAP"
end type
global w_ge187_selecao_conta_sap w_ge187_selecao_conta_sap

on w_ge187_selecao_conta_sap.create
call super::create
end on

on w_ge187_selecao_conta_sap.destroy
call super::destroy
end on

event ue_preopen;call super::ue_preopen;String lvs_Pesquisa

lvs_Pesquisa = Message.StringParm

If lvs_Pesquisa <> "" Then 	
	dw_1.Object.de_pesquisa[1] = lvs_Pesquisa
	
	ivb_pesquisa_direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge187_selecao_conta_sap
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge187_selecao_conta_sap
integer y = 220
integer width = 1966
integer height = 1068
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge187_selecao_conta_sap
integer width = 1627
integer height = 196
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge187_selecao_conta_sap
integer y = 96
integer width = 1545
integer height = 96
string dataobject = "dw_ge187_selecao_conta_sap"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge187_selecao_conta_sap
integer y = 292
integer width = 1906
integer height = 968
string dataobject = "dw_ge187_lista_conta_sap"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Pesquisa

dw_1.AcceptText()

lvs_Pesquisa = dw_1.Object.de_pesquisa [1]

If lvs_Pesquisa <> "" Then
	This.Of_Appendwhere( "(cd_conta_sap like '%"+lvs_Pesquisa+"%' or de_conta_sap like '%"+lvs_Pesquisa+"%')")
End If

Return AncestorReturnValue
end event

event dw_2::doubleclicked;call super::doubleclicked;cb_selecionar.Post Event Clicked()
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge187_selecao_conta_sap
integer x = 1239
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Conta

If dw_2.GetRow() > 0 Then
	lvs_Conta = dw_2.Object.cd_conta_sap [dw_2.GetRow()]
	
	CloseWithReturn(Parent, lvs_Conta)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione um registro.")
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge187_selecao_conta_sap
integer x = 1627
end type

event cb_cancelar::clicked;call super::clicked;Close(Parent)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge187_selecao_conta_sap
integer x = 795
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge187_selecao_conta_sap
integer width = 763
integer height = 140
end type

