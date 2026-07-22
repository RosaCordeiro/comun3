HA$PBExportHeader$w_ge057_selecao_grupo_produto.srw
forward
global type w_ge057_selecao_grupo_produto from dc_w_selecao_generica
end type
end forward

global type w_ge057_selecao_grupo_produto from dc_w_selecao_generica
int X=786
int Y=436
int Width=2085
int Height=1528
boolean TitleBar=true
string Title="GE057 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Grupos de Produtos"
end type
global w_ge057_selecao_grupo_produto w_ge057_selecao_grupo_produto

on w_ge057_selecao_grupo_produto.create
call super::create
end on

on w_ge057_selecao_grupo_produto.destroy
call super::destroy
end on

event open;call super::open;String lvs_Descricao

lvs_Descricao = Message.StringParm

If Trim(lvs_Descricao) <> "" Then
	dw_1.Object.De_Grupo[1] = lvs_Descricao
End If

ivb_Pesquisa_Direta = True
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge057_selecao_grupo_produto
int X=23
int Y=188
int Width=2011
int Height=1100
string Text="Lista de Grupos"
long BackColor=80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge057_selecao_grupo_produto
int X=23
int Y=4
int Width=1426
int Height=172
long BackColor=80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge057_selecao_grupo_produto
int X=46
int Y=64
int Width=1390
int Height=96
boolean BringToTop=true
string DataObject="dw_ge057_selecao_grupo"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge057_selecao_grupo_produto
int X=50
int Y=240
int Width=1961
int Height=1024
boolean BringToTop=true
string DataObject="dw_ge057_lista_grupo"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao

dw_1.AcceptText()

lvs_Descricao = Trim(dw_1.Object.De_Grupo[1])

If lvs_Descricao <> "" Then
	This.of_AppendWhere("de_grupo_produto like '" + lvs_Descricao + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge057_selecao_grupo_produto
int X=1275
int Y=1312
boolean BringToTop=true
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Grupo

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Grupo = dw_2.Object.Cd_Grupo_Produto[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Grupo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um grupo na lista.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge057_selecao_grupo_produto
int X=1664
int Y=1312
boolean BringToTop=true
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Grupo

SetNull(lvs_Grupo)

CloseWithReturn(Parent, lvs_Grupo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge057_selecao_grupo_produto
int X=882
int Y=1312
boolean BringToTop=true
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge057_selecao_grupo_produto
int X=37
int Y=1324
int Width=827
boolean BringToTop=true
long BackColor=80269524
end type

