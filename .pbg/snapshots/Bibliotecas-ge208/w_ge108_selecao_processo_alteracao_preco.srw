HA$PBExportHeader$w_ge108_selecao_processo_alteracao_preco.srw
forward
global type w_ge108_selecao_processo_alteracao_preco from dc_w_selecao_generica
end type
end forward

global type w_ge108_selecao_processo_alteracao_preco from dc_w_selecao_generica
integer x = 494
integer y = 436
integer width = 2491
integer height = 1520
string title = "GE108 - Sele$$HEX2$$e700e300$$ENDHEX$$o dos Processos de Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o"
long backcolor = 80269524
end type
global w_ge108_selecao_processo_alteracao_preco w_ge108_selecao_processo_alteracao_preco

type variables
uo_processo_alteracao_preco ivo_processo_alteracao_preco


end variables

on w_ge108_selecao_processo_alteracao_preco.create
call super::create
end on

on w_ge108_selecao_processo_alteracao_preco.destroy
call super::destroy
end on

event open;call super::open;String lvs_processo

ivo_processo_alteracao_preco = Message.PowerObjectParm

lvs_processo = ivo_processo_alteracao_preco.ivs_Parametro_Selecao

If lvs_processo <> "" Then
	dw_1.Object.de_processo[1] = lvs_processo
	ivb_Pesquisa_Direta = True
End If

end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge108_selecao_processo_alteracao_preco
integer x = 18
integer y = 188
integer width = 2432
integer height = 1096
long backcolor = 80269524
string text = "Lista de Grupos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge108_selecao_processo_alteracao_preco
integer x = 18
integer y = 4
integer width = 1833
integer height = 176
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge108_selecao_processo_alteracao_preco
integer x = 46
integer y = 64
integer width = 1778
integer height = 96
string dataobject = "dw_ge108_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge108_selecao_processo_alteracao_preco
integer x = 55
integer y = 240
integer width = 2368
integer height = 1008
string dataobject = "dw_ge108_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_processo

dw_1.AcceptText()

lvs_processo = Trim(dw_1.Object.de_processo[1])

If lvs_processo <> "" Then
	This.of_AppendWhere("p.de_processo like '" + lvs_processo + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge108_selecao_processo_alteracao_preco
integer x = 1682
integer y = 1308
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_processo

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_processo = dw_2.Object.nr_processo[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_processo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um processo.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge108_selecao_processo_alteracao_preco
integer x = 2075
integer y = 1308
end type

event cb_cancelar::clicked;call super::clicked;String lvs_processo

SetNull(lvs_processo)

CloseWithReturn(Parent, lvs_processo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge108_selecao_processo_alteracao_preco
integer x = 1262
integer y = 1308
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge108_selecao_processo_alteracao_preco
integer x = 23
integer y = 1320
integer width = 1207
long backcolor = 80269524
end type

