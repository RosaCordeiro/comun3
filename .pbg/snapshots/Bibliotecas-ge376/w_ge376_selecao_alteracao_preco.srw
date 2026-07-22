HA$PBExportHeader$w_ge376_selecao_alteracao_preco.srw
forward
global type w_ge376_selecao_alteracao_preco from dc_w_selecao_generica
end type
end forward

global type w_ge376_selecao_alteracao_preco from dc_w_selecao_generica
integer width = 3003
integer height = 1376
string title = "GE376 - Sele$$HEX2$$e700e300$$ENDHEX$$o Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge376_selecao_alteracao_preco w_ge376_selecao_alteracao_preco

on w_ge376_selecao_alteracao_preco.create
call super::create
end on

on w_ge376_selecao_alteracao_preco.destroy
call super::destroy
end on

event open;call super::open;String ls_Alteracao

ls_Alteracao = Message.StringParm

If ls_Alteracao <> "" Then
	dw_1.Object.de_alteracao[1] = ls_Alteracao
	dw_1.AcceptText()
End If

ivb_Pesquisa_Direta = True	
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge376_selecao_alteracao_preco
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge376_selecao_alteracao_preco
integer y = 212
integer width = 2926
integer height = 936
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge376_selecao_alteracao_preco
integer width = 1609
integer height = 188
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge376_selecao_alteracao_preco
integer x = 64
integer width = 1563
integer height = 76
string dataobject = "dw_ge260_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge376_selecao_alteracao_preco
integer y = 284
integer width = 2862
integer height = 840
string dataobject = "dw_ge376_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Descricao

dw_1.AcceptText()

ls_Descricao = Trim( dw_1.Object.de_alteracao [1] )

If ls_Descricao <> "" Then
	This.of_AppendWhere("de_analise like '" + ls_Descricao + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge376_selecao_alteracao_preco
integer x = 2199
integer y = 1172
end type

event cb_selecionar::clicked;call super::clicked;Long ll_Linha, ll_Alteracao

ll_Linha = dw_2.GetRow()

If ll_Linha > 0 Then
	ll_Alteracao = dw_2.Object.nr_alteracao [ ll_Linha ]
	CloseWithReturn(Parent, String( ll_Alteracao) )
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma altera$$HEX2$$e700e300$$ENDHEX$$o na lista.", Information! )
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge376_selecao_alteracao_preco
integer x = 2587
integer y = 1172
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent, '')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge376_selecao_alteracao_preco
integer x = 1755
integer y = 1172
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge376_selecao_alteracao_preco
integer y = 1172
end type

