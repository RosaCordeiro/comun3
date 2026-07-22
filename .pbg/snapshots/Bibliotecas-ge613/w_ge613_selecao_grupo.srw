HA$PBExportHeader$w_ge613_selecao_grupo.srw
forward
global type w_ge613_selecao_grupo from dc_w_selecao_generica
end type
end forward

global type w_ge613_selecao_grupo from dc_w_selecao_generica
integer x = 786
integer y = 436
integer width = 2085
integer height = 1528
string title = "GE613 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Grupos de Produtos"
end type
global w_ge613_selecao_grupo w_ge613_selecao_grupo

on w_ge613_selecao_grupo.create
call super::create
end on

on w_ge613_selecao_grupo.destroy
call super::destroy
end on

event open;call super::open;String ls_Descricao

ls_Descricao = Message.StringParm

If Trim(ls_Descricao) <> '' Then
	dw_1.Object.De_Grupo [1] = ls_Descricao
End If

ivb_Pesquisa_Direta = True
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge613_selecao_grupo
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge613_selecao_grupo
integer x = 23
integer y = 188
integer width = 2011
integer height = 1100
long backcolor = 80269524
string text = "Lista de Grupos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge613_selecao_grupo
integer x = 23
integer y = 4
integer width = 1426
integer height = 172
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge613_selecao_grupo
integer x = 46
integer y = 64
integer width = 1390
integer height = 96
string dataobject = "dw_ge057_selecao_grupo"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge613_selecao_grupo
integer x = 50
integer y = 240
integer width = 1961
integer height = 1024
string dataobject = "dw_ge057_lista_grupo"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Descricao

dw_1.AcceptText ()

ls_Descricao = Trim (dw_1.Object.De_Grupo [1])

If ls_Descricao <> '' then
	This.of_AppendWhere ("de_grupo like '" + ls_Descricao + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge613_selecao_grupo
integer x = 1275
integer y = 1312
end type

event cb_selecionar::clicked;call super::clicked;Long		ll_Linha
String	ls_Cd_Grupo

ll_Linha = dw_2.GetRow ()

If ll_Linha > 0 then
	ls_Cd_Grupo = dw_2.Object.Cd_Grupo [ll_Linha]
	CloseWithReturn (Parent, ls_Cd_Grupo)
Else
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione um grupo na lista.', Information!)
	dw_2.SetFocus ()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge613_selecao_grupo
integer x = 1664
integer y = 1312
end type

event cb_cancelar::clicked;call super::clicked;String ls_Grupo

SetNull (ls_Grupo)

CloseWithReturn (Parent, ls_Grupo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge613_selecao_grupo
integer x = 882
integer y = 1312
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge613_selecao_grupo
integer x = 37
integer y = 1324
integer width = 827
long backcolor = 80269524
end type

