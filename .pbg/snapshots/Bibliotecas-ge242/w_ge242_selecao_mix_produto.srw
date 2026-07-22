HA$PBExportHeader$w_ge242_selecao_mix_produto.srw
forward
global type w_ge242_selecao_mix_produto from dc_w_selecao_generica
end type
end forward

global type w_ge242_selecao_mix_produto from dc_w_selecao_generica
integer width = 1710
integer height = 1536
string title = "GE242 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Mix de Produtos"
long backcolor = 80269524
end type
global w_ge242_selecao_mix_produto w_ge242_selecao_mix_produto

type variables
uo_ge242_Mix_Produto ivo_Mix
end variables

on w_ge242_selecao_mix_produto.create
call super::create
end on

on w_ge242_selecao_mix_produto.destroy
call super::destroy
end on

event open;call super::open;String lvs_Mix

ivo_Mix = Message.PowerObjectParm

lvs_Mix = ivo_Mix.ivs_Parametro_Selecao

If lvs_Mix <> "" Then
	dw_1.Object.Localizacao[1] = lvs_Mix
	ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge242_selecao_mix_produto
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge242_selecao_mix_produto
integer y = 224
integer width = 1618
integer height = 1060
long backcolor = 80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge242_selecao_mix_produto
integer width = 1623
integer height = 192
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge242_selecao_mix_produto
integer x = 55
integer width = 1554
integer height = 84
string dataobject = "dw_ge242_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge242_selecao_mix_produto
integer y = 284
integer width = 1536
integer height = 972
string dataobject = "dw_ge242_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Mix

dw_1.AcceptText()

lvs_Mix = Trim(dw_1.Object.Localizacao[1])

If lvs_Mix <> "" Then
	This.of_AppendWhere("de_mix_produto like '" + lvs_Mix + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge242_selecao_mix_produto
integer x = 891
integer width = 366
end type

event cb_selecionar::clicked;Long lvl_Linha, &
     lvl_Mix
	
dw_2.AcceptText()

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Mix = dw_2.Object.cd_mix_produto[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Mix))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um mix.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge242_selecao_mix_produto
integer x = 1280
end type

event cb_cancelar::clicked;STRING lvs_Mix

SetNull(lvs_Mix)

CloseWithReturn(Parent, lvs_Mix)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge242_selecao_mix_produto
integer x = 443
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge242_selecao_mix_produto
boolean visible = false
integer x = 27
integer width = 631
end type

