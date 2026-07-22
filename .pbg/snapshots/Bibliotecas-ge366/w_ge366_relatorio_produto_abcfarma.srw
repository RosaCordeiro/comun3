HA$PBExportHeader$w_ge366_relatorio_produto_abcfarma.srw
forward
global type w_ge366_relatorio_produto_abcfarma from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge366_relatorio_produto_abcfarma from dc_w_selecao_lista_relatorio
integer width = 3163
integer height = 1856
string title = "GE366 - Produtos do Caderno ABC Farma"
end type
global w_ge366_relatorio_produto_abcfarma w_ge366_relatorio_produto_abcfarma

on w_ge366_relatorio_produto_abcfarma.create
call super::create
end on

on w_ge366_relatorio_produto_abcfarma.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;This.ivm_Menu.ivb_Permite_Imprimir = True

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge366_relatorio_produto_abcfarma
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge366_relatorio_produto_abcfarma
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge366_relatorio_produto_abcfarma
integer y = 204
integer width = 3045
integer height = 1436
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge366_relatorio_produto_abcfarma
integer width = 1710
integer height = 176
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge366_relatorio_produto_abcfarma
integer x = 55
integer y = 76
integer height = 92
string dataobject = "dw_ge366_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge366_relatorio_produto_abcfarma
integer x = 59
integer y = 264
integer width = 3003
integer height = 1360
string dataobject = "dw_ge366_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;STRING  lvs_Produto

LONG    lvl_Linhas

dw_1.AcceptText()

lvs_Produto = TRIM(dw_1.GetText()) + "%"

This.of_AppendWhere("g.de_produto like '" + lvs_Produto + "'")

Return AncestorReturnValue

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge366_relatorio_produto_abcfarma
integer x = 2258
integer y = 20
integer height = 260
string dataobject = "dw_ge366_relatorio"
boolean maxbox = true
end type

event dw_3::ue_preprint;call super::ue_preprint;STRING ls_produto

dw_1.Accepttext()

ls_produto = Trim( dw_1.Object.de_produto[1] )

If ( ls_produto = "") Then
	This.object.st_produto.Text = "TODOS"
Else 
	This.object.st_produto.Text = ls_produto
End If

Return AncestorReturnValue
end event

