HA$PBExportHeader$w_ge057_selecao_subgrupo_produto.srw
forward
global type w_ge057_selecao_subgrupo_produto from dc_w_selecao_generica
end type
end forward

global type w_ge057_selecao_subgrupo_produto from dc_w_selecao_generica
int X=800
int Y=436
int Width=2071
int Height=1528
boolean TitleBar=true
string Title="GE057 - Sele$$HEX2$$e700e300$$ENDHEX$$o de SubGrupos de Produtos"
end type
global w_ge057_selecao_subgrupo_produto w_ge057_selecao_subgrupo_produto

type variables
uo_subgrupo_produto ivo_subgrupo
end variables

on w_ge057_selecao_subgrupo_produto.create
call super::create
end on

on w_ge057_selecao_subgrupo_produto.destroy
call super::destroy
end on

event open;call super::open;SetPointer(HourGlass!)

uo_Grupo_Produto lvo_Grupo

lvo_Grupo    = Create uo_Grupo_Produto
ivo_SubGrupo = Create uo_SubGrupo_Produto

ivo_SubGrupo = Message.PowerObjectParm

lvo_Grupo.of_Localiza_Codigo(ivo_SubGrupo.ivl_Grupo)

If lvo_Grupo.Localizado Then
	dw_1.Object.Cd_Grupo[1] = lvo_Grupo.Cd_Grupo_Produto
   dw_1.Object.De_Grupo[1] = lvo_Grupo.De_Grupo_Produto
End If

If Trim(ivo_SubGrupo.ivs_Parametro) <> "" Then
	dw_1.Object.De_SubGrupo[1] = ivo_SubGrupo.ivs_Parametro
End If

ivb_Pesquisa_Direta = True

Destroy(lvo_Grupo)
SetPointer(Arrow!)
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge057_selecao_subgrupo_produto
int X=23
int Y=264
int Width=1998
int Height=1024
string Text="Lista de SubGrupos"
long BackColor=80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge057_selecao_subgrupo_produto
int X=23
int Y=4
int Width=1591
int Height=252
long BackColor=80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge057_selecao_subgrupo_produto
int X=37
int Y=64
int Width=1563
int Height=176
boolean BringToTop=true
string DataObject="dw_ge057_selecao_subgrupo"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge057_selecao_subgrupo_produto
int X=46
int Y=316
int Width=1952
int Height=952
boolean BringToTop=true
string DataObject="dw_ge057_lista_subgrupo"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao
		 
dw_1.AcceptText()

lvs_Descricao = dw_1.Object.De_SubGrupo[1]

If Trim(lvs_Descricao) <> "" Then
	This.of_AppendWhere("de_subgrupo_produto like '" + lvs_Descricao + "%'")
End If

Return 1
end event

event dw_2::ue_recuperar;// Override

Long lvl_Grupo

lvl_Grupo = dw_1.Object.Cd_Grupo[1]

If IsNull(lvl_Grupo) or lvl_Grupo = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o grupo.", StopSign!)
	dw_1.Event ue_Pos(1, "de_grupo")
	Return -1
End If

Return This.Retrieve(lvl_Grupo)
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge057_selecao_subgrupo_produto
int X=1262
int Y=1312
boolean BringToTop=true
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_SubGrupo

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_SubGrupo = dw_2.Object.Cd_SubGrupo_Produto[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_SubGrupo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um subgrupo na lista.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge057_selecao_subgrupo_produto
int X=1650
int Y=1312
boolean BringToTop=true
end type

event cb_cancelar::clicked;call super::clicked;String lvs_SubCategoria

SetNull(lvs_SubCategoria)

CloseWithReturn(Parent, lvs_SubCategoria)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge057_selecao_subgrupo_produto
int X=873
int Y=1312
boolean BringToTop=true
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge057_selecao_subgrupo_produto
int X=37
int Y=1328
int Width=809
boolean BringToTop=true
long BackColor=80269524
end type

