HA$PBExportHeader$w_ge543_selecao_tabela_interface_sap.srw
forward
global type w_ge543_selecao_tabela_interface_sap from dc_w_selecao_generica
end type
end forward

global type w_ge543_selecao_tabela_interface_sap from dc_w_selecao_generica
integer x = 704
integer y = 436
integer width = 2555
integer height = 1604
string title = "GE543 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Tabela de Interface"
end type
global w_ge543_selecao_tabela_interface_sap w_ge543_selecao_tabela_interface_sap

type variables
String	is_tipo
end variables

on w_ge543_selecao_tabela_interface_sap.create
call super::create
end on

on w_ge543_selecao_tabela_interface_sap.destroy
call super::destroy
end on

event open;call super::open;String	ls_de_tabela, ls_sistema


uo_ge543_tabela_interface_sap lo_tabela_interface_sap

lo_tabela_interface_sap	= Create uo_ge543_tabela_interface_sap

lo_tabela_interface_sap = Message.PowerObjectParm

ls_de_tabela = lo_tabela_interface_sap.is_Parametro

is_tipo	= lo_tabela_interface_sap.is_tipo

If ls_de_tabela <> "" Then
	dw_1.Object.de_tabela[1] = ls_de_tabela
	
	ivb_Pesquisa_Direta = True
End If

ls_sistema	= lo_tabela_interface_sap.is_cd_sistema

if IsNull(ls_sistema) then ls_sistema = 'EX'

dw_1.Object.cd_sistema[1]	= ls_sistema

if dw_1.Object.cd_sistema[1] <> 'EX' then
	dw_1.Modify("cd_sistema.TabSequence='0'")
end if
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge543_selecao_tabela_interface_sap
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge543_selecao_tabela_interface_sap
integer x = 18
integer y = 268
integer width = 2501
integer height = 1108
long backcolor = 80269524
string text = "Lista de Tabelas"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge543_selecao_tabela_interface_sap
integer x = 18
integer y = 4
integer width = 2491
integer height = 248
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge543_selecao_tabela_interface_sap
integer x = 32
integer y = 64
integer width = 2469
integer height = 180
string dataobject = "dw_ge543_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge543_selecao_tabela_interface_sap
integer x = 41
integer y = 320
integer width = 2455
integer height = 1032
string dataobject = "dw_ge543_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_de_tabela
String ls_ativo


dw_1.AcceptText()

ls_de_tabela	= Trim(dw_1.Object.de_tabela[1])
ls_ativo			= dw_1.Object.id_ativo[1]

If Not IsNull(ls_de_tabela) Then
	This.of_AppendWhere("de_tabela like '%" + ls_de_tabela + "%'")
End If

If ls_Ativo = 'S' Then
	This.of_AppendWhere("id_situacao = 'A'")
	This.of_AppendWhere("(id_situacao in ('A', 'I')  or id_situacao is null)")
End If

Return 1
end event

event dw_2::ue_recuperar;String	ls_sistema


ls_sistema	= dw_1.Object.cd_sistema[1]

if ls_sistema = 'EX' then
	SetNull(ls_sistema)
End If

Return This.Retrieve(is_tipo, ls_sistema)
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge543_selecao_tabela_interface_sap
integer x = 1760
integer y = 1396
end type

event cb_selecionar::clicked;call super::clicked;Long 		lvl_Linha
String 	ls_cd_tabela


lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	ls_cd_tabela = String(dw_2.Object.cd_tabela[lvl_Linha])
	CloseWithReturn(Parent, ls_cd_tabela)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma tabela.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge543_selecao_tabela_interface_sap
integer x = 2149
integer y = 1396
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Usuario

SetNull(lvs_Usuario)

CloseWithReturn(Parent, lvs_Usuario)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge543_selecao_tabela_interface_sap
integer x = 1349
integer y = 1396
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge543_selecao_tabela_interface_sap
integer x = 27
integer y = 1408
integer width = 992
long backcolor = 80269524
end type

