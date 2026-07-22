HA$PBExportHeader$w_ge187_selecao_conta_fluxo_caixa.srw
forward
global type w_ge187_selecao_conta_fluxo_caixa from dc_w_selecao_generica
end type
end forward

global type w_ge187_selecao_conta_fluxo_caixa from dc_w_selecao_generica
integer x = 329
integer y = 348
integer width = 3561
integer height = 1712
string title = "GE187 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Contas de Fluxo de Caixa"
end type
global w_ge187_selecao_conta_fluxo_caixa w_ge187_selecao_conta_fluxo_caixa

on w_ge187_selecao_conta_fluxo_caixa.create
call super::create
end on

on w_ge187_selecao_conta_fluxo_caixa.destroy
call super::destroy
end on

event open;call super::open;String lvs_Conta

lvs_Conta = Message.StringParm

If lvs_Conta <> "" Then
	dw_1.Object.De_Conta[1] = lvs_Conta
	This.ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge187_selecao_conta_fluxo_caixa
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge187_selecao_conta_fluxo_caixa
integer x = 23
integer y = 276
integer width = 3511
integer height = 1196
long backcolor = 80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge187_selecao_conta_fluxo_caixa
integer x = 23
integer width = 1897
integer height = 256
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge187_selecao_conta_fluxo_caixa
integer x = 50
integer y = 76
integer width = 1851
integer height = 180
string dataobject = "dw_ge187_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge187_selecao_conta_fluxo_caixa
integer x = 46
integer y = 320
integer width = 3474
integer height = 1132
string dataobject = "dw_ge187_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Conta, &
       	lvs_Credito_Debito, &
		lvs_Tipo,&
		lvs_ExportaSAP
		 
dw_1.AcceptText()

lvs_Conta          = dw_1.Object.De_Conta         [1]
lvs_Credito_Debito = dw_1.Object.Id_Credito_Debito[1]
lvs_Tipo           = dw_1.Object.Id_Tipo          [1]


If Trim(lvs_Conta) <> "" Then
	This.of_AppendWhere("de_conta_fluxo_caixa like '" + lvs_Conta + "%'")
End If

If lvs_Credito_Debito <> "T" Then
	This.of_AppendWhere("id_credito_debito = '" + lvs_Credito_Debito + "'")
End If

If lvs_Tipo <> "A" Then
	This.of_AppendWhere("id_tipo_conta = '" + lvs_Tipo + "'")
End If







Return 1
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection("if (id_situacao = ~"A~", rgb(255,255,255), rgb(255,0,0))","")
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge187_selecao_conta_fluxo_caixa
integer x = 2510
integer y = 1488
end type

event cb_selecionar::clicked;Long lvl_Linha, &
     lvl_Conta

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Conta = dw_2.Object.Cd_Conta_Fluxo_Caixa[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Conta))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma conta.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge187_selecao_conta_fluxo_caixa
integer x = 2903
integer y = 1488
integer width = 311
end type

event cb_cancelar::clicked;String lvs_Conta

SetNull(lvs_Conta)

CloseWithReturn(Parent, lvs_Conta)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge187_selecao_conta_fluxo_caixa
integer x = 1979
integer y = 1488
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge187_selecao_conta_fluxo_caixa
integer x = 23
integer y = 1488
integer width = 1495
long backcolor = 80269524
end type

