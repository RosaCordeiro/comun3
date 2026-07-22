HA$PBExportHeader$w_ge109_selecao_grupo_alteracao_preco.srw
forward
global type w_ge109_selecao_grupo_alteracao_preco from dc_w_selecao_generica
end type
end forward

global type w_ge109_selecao_grupo_alteracao_preco from dc_w_selecao_generica
integer x = 494
integer y = 436
integer width = 2491
integer height = 1520
string title = "GE209 - Grupos de Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o"
long backcolor = 80269524
end type
global w_ge109_selecao_grupo_alteracao_preco w_ge109_selecao_grupo_alteracao_preco

type variables
uo_grupo_produto_mkt ivo_grupo_produto_mkt


end variables

on w_ge109_selecao_grupo_alteracao_preco.create
call super::create
end on

on w_ge109_selecao_grupo_alteracao_preco.destroy
call super::destroy
end on

event open;call super::open;String lvs_Grupo

ivo_Grupo_Produto_MKT = Message.PowerObjectParm

lvs_Grupo = ivo_Grupo_Produto_MKT.ivs_Parametro_Selecao

If lvs_Grupo <> "" Then
	dw_1.Object.de_grupo[1] = Upper(lvs_Grupo)
	ivb_Pesquisa_Direta = True
End If

end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge109_selecao_grupo_alteracao_preco
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge109_selecao_grupo_alteracao_preco
integer x = 18
integer y = 188
integer width = 2432
integer height = 1096
long backcolor = 80269524
string text = "Lista de Grupos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge109_selecao_grupo_alteracao_preco
integer x = 18
integer y = 4
integer width = 1381
integer height = 176
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge109_selecao_grupo_alteracao_preco
integer x = 32
integer y = 64
integer width = 1339
integer height = 96
string dataobject = "dw_ge109_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge109_selecao_grupo_alteracao_preco
integer x = 55
integer y = 240
integer width = 2368
integer height = 1008
string dataobject = "dw_ge109_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Grupo

dw_1.AcceptText()

lvs_Grupo = Trim(dw_1.Object.de_grupo[1])

If lvs_Grupo <> "" Then
	This.of_AppendWhere("p.de_grupo like '" + lvs_Grupo + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge109_selecao_grupo_alteracao_preco
integer x = 1682
integer y = 1308
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Grupo

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Grupo = dw_2.Object.cd_grupo[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Grupo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um grupo.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge109_selecao_grupo_alteracao_preco
integer x = 2075
integer y = 1308
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Grupo

SetNull(lvs_Grupo)

CloseWithReturn(Parent, lvs_Grupo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge109_selecao_grupo_alteracao_preco
integer x = 1262
integer y = 1308
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge109_selecao_grupo_alteracao_preco
integer x = 23
integer y = 1320
integer width = 1207
long backcolor = 80269524
end type

