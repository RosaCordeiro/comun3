HA$PBExportHeader$w_ge002_selecao_dependente_cliente.srw
forward
global type w_ge002_selecao_dependente_cliente from dc_w_selecao_generica
end type
end forward

global type w_ge002_selecao_dependente_cliente from dc_w_selecao_generica
integer x = 37
integer y = 400
integer width = 3209
integer height = 1612
string title = "GE002 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Dependentes de Clientes"
long backcolor = 80269524
end type
global w_ge002_selecao_dependente_cliente w_ge002_selecao_dependente_cliente

type variables
uo_cliente ivo_cliente
end variables

on w_ge002_selecao_dependente_cliente.create
call super::create
end on

on w_ge002_selecao_dependente_cliente.destroy
call super::destroy
end on

event open;call super::open;ivo_Cliente = Message.PowerObjectParm

dw_1.Object.Cd_Cliente[1] = ivo_Cliente.Cd_Cliente
dw_1.Object.Nm_Cliente[1] = ivo_Cliente.Nm_Cliente

If ivo_Cliente.ivs_Parametro <> "" Then
	dw_1.Object.Nm_Dependente[1] = ivo_Cliente.ivs_Parametro
End If

This.ivb_Pesquisa_Direta = True
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge002_selecao_dependente_cliente
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge002_selecao_dependente_cliente
integer x = 18
integer y = 292
integer width = 3141
integer height = 1076
long backcolor = 80269524
string text = "Lista de Dependentes"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge002_selecao_dependente_cliente
integer x = 18
integer y = 8
integer width = 2103
integer height = 268
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge002_selecao_dependente_cliente
integer x = 41
integer y = 76
integer width = 2071
integer height = 184
string dataobject = "dw_ge002_selecao_dependente"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge002_selecao_dependente_cliente
integer x = 41
integer y = 344
integer width = 3095
integer height = 1004
string dataobject = "dw_ge002_lista_dependente"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Linhas

String lvs_Cliente, &
       lvs_Nome

dw_1.AcceptText()

lvs_Cliente = dw_1.Object.Cd_Cliente   [1]
lvs_Nome    = dw_1.Object.Nm_Dependente[1]

This.of_AppendWhere("cd_cliente = '" + lvs_Cliente + "'")

If Not IsNull(lvs_Nome) and Trim(lvs_Nome) <> "" Then
	This.of_AppendWhere("nm_dependente like '" + lvs_Nome + "%'")
End If

lvl_Linhas = dw_2.RowCount()

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge002_selecao_dependente_cliente
integer x = 2391
integer y = 1396
end type

event cb_selecionar::clicked;Long lvl_Linha

String lvs_Dependente

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Dependente = dw_2.Object.Cd_Dependente_Cliente[lvl_Linha]
	
	CloseWithReturn(Parent, lvs_Dependente)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um dependente.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge002_selecao_dependente_cliente
integer x = 2789
integer y = 1396
end type

event cb_cancelar::clicked;String lvs_Cliente

SetNull(lvs_Cliente)

CloseWithReturn(Parent, lvs_Cliente)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge002_selecao_dependente_cliente
integer x = 1920
integer y = 1396
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge002_selecao_dependente_cliente
integer x = 27
integer y = 1408
integer width = 1467
long backcolor = 80269524
end type

