HA$PBExportHeader$w_ge228_selecao_marca_produto.srw
forward
global type w_ge228_selecao_marca_produto from dc_w_selecao_generica
end type
end forward

global type w_ge228_selecao_marca_produto from dc_w_selecao_generica
integer width = 2496
integer height = 1320
string title = "GE228 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Marca de Produto"
end type
global w_ge228_selecao_marca_produto w_ge228_selecao_marca_produto

on w_ge228_selecao_marca_produto.create
call super::create
end on

on w_ge228_selecao_marca_produto.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

lvs_Parametro = Message.StringParm

If lvs_Parametro <> "" Then
	dw_1.Object.de_marca[1] = lvs_Parametro
End If

ivb_Pesquisa_Direta = True
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge228_selecao_marca_produto
integer y = 212
integer height = 872
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge228_selecao_marca_produto
integer width = 1577
integer height = 188
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge228_selecao_marca_produto
integer y = 84
integer width = 1518
integer height = 72
string dataobject = "dw_ge228_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge228_selecao_marca_produto
integer y = 284
integer width = 2368
integer height = 772
string dataobject = "dw_ge228_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao

dw_1.AcceptText()

lvs_Descricao = dw_1.Object.de_marca[1]

If lvs_Descricao <> "" Then
	If IsNumber(lvs_Descricao) Then
		This.Of_AppendWhere("m.cd_marca = " + lvs_Descricao)
	Else
		This.Of_AppendWhere("m.de_marca like '" + lvs_Descricao +"%'")
	End If
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge228_selecao_marca_produto
integer y = 1108
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Marca

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Marca = dw_2.Object.cd_marca[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Marca))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a marca do produto.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge228_selecao_marca_produto
integer y = 1108
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn ( Parent, 0 )
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge228_selecao_marca_produto
integer y = 1108
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge228_selecao_marca_produto
integer y = 1108
end type

