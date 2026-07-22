HA$PBExportHeader$w_ge011_selecao_produto_abcfarma.srw
forward
global type w_ge011_selecao_produto_abcfarma from dc_w_selecao_generica
end type
end forward

global type w_ge011_selecao_produto_abcfarma from dc_w_selecao_generica
integer x = 146
integer y = 412
integer width = 4110
integer height = 1748
string title = "GE011 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos do Caderno ABC Farma"
long backcolor = 80269524
end type
global w_ge011_selecao_produto_abcfarma w_ge011_selecao_produto_abcfarma

on w_ge011_selecao_produto_abcfarma.create
call super::create
end on

on w_ge011_selecao_produto_abcfarma.destroy
call super::destroy
end on

event open;call super::open;String lvs_Produto

lvs_Produto = Message.StringParm

If lvs_Produto <> "" Then
	dw_1.Object.De_Produto[1] = lvs_Produto
	dw_1.AcceptText()
	
	ivb_Pesquisa_Direta = True
End If


end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge011_selecao_produto_abcfarma
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge011_selecao_produto_abcfarma
integer x = 18
integer y = 284
integer width = 4041
integer height = 1224
long backcolor = 80269524
string text = "Lista de Produtos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge011_selecao_produto_abcfarma
integer x = 18
integer y = 4
integer width = 1838
integer height = 260
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge011_selecao_produto_abcfarma
integer x = 37
integer y = 64
integer width = 1783
integer height = 184
string dataobject = "dw_ge011_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge011_selecao_produto_abcfarma
integer x = 46
integer y = 336
integer width = 3982
integer height = 1144
string dataobject = "dw_ge011_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao
String ls_Cod_Barras

dw_1.AcceptText()

lvs_Descricao	= dw_1.Object.De_Produto			[1]
ls_Cod_Barras	= dw_1.Object.De_Codigo_Barras	[1]

If Trim(lvs_Descricao) <> "" Then
	This.of_AppendWhere("a.de_produto like '" + lvs_Descricao + "%'")
End If

If Not IsNull(ls_Cod_Barras) And Trim(ls_Cod_Barras) <> "" Then
	This.of_AppendWhere("a.de_codigo_barras = '" + ls_Cod_Barras + "'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge011_selecao_produto_abcfarma
integer x = 3291
integer y = 1540
end type

event cb_selecionar::clicked;Long lvl_Linha

String lvs_Produto

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Produto = String(dw_2.Object.Cd_Produto_ABCFarma[lvl_Linha])
	CloseWithReturn(Parent, lvs_Produto)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto na lista.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge011_selecao_produto_abcfarma
integer x = 3685
integer y = 1540
end type

event cb_cancelar::clicked;String lvs_Produto

SetNull(lvs_Produto)

CloseWithReturn(Parent, lvs_Produto)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge011_selecao_produto_abcfarma
integer x = 2761
integer y = 1540
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge011_selecao_produto_abcfarma
integer x = 27
integer y = 1552
long backcolor = 80269524
end type

