HA$PBExportHeader$w_ge488_selecao_produto_nf.srw
forward
global type w_ge488_selecao_produto_nf from dc_w_selecao_generica
end type
end forward

global type w_ge488_selecao_produto_nf from dc_w_selecao_generica
integer width = 2514
end type
global w_ge488_selecao_produto_nf w_ge488_selecao_produto_nf

type variables
String ivs_Chave_Acesso
end variables

on w_ge488_selecao_produto_nf.create
call super::create
end on

on w_ge488_selecao_produto_nf.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Parametro

lvs_Parametro 		= Message.StringParm
ivs_Chave_Acesso = Mid(lvs_Parametro, 1, Pos(lvs_Parametro, ";")-1)
lvs_Parametro		= Mid(lvs_Parametro, Pos(lvs_Parametro, ";")+1)

If Not IsNull(lvs_Parametro) and Trim(lvs_Parametro) <> "" Then
	dw_1.Object.de_filtro [1] = lvs_Parametro
End If

cb_pesquisar.Post Event Clicked( )
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge488_selecao_produto_nf
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge488_selecao_produto_nf
integer y = 228
integer width = 2427
integer height = 1068
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge488_selecao_produto_nf
integer width = 1943
integer height = 208
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge488_selecao_produto_nf
integer y = 96
integer width = 1870
integer height = 92
string dataobject = "dw_ge488_selecao_produto"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge488_selecao_produto_nf
integer x = 64
integer y = 300
integer width = 2345
integer height = 968
string dataobject = "dw_ge488_produto_nf"
end type

event dw_2::ue_recuperar;//override
Return This.Retrieve(ivs_Chave_Acesso)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Filtro
String lvs_Where

dw_1.Accepttext( )

lvs_Filtro = Upper(dw_1.Object.de_filtro [1])

If Trim(lvs_Filtro) <> "" Then
	lvs_Where = "(pg.de_produto like '%"+lvs_Filtro+"' or pg.de_apresentacao_venda like '%"+lvs_Filtro+"%'"
	If IsNumber(lvs_Filtro) Then
		lvs_Where += " or pg.cd_produto = "+lvs_Filtro+""
	End If
	lvs_Where += ")"
	
	This.Of_AppendWhere( lvs_Where )
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge488_selecao_produto_nf
end type

event cb_selecionar::clicked;call super::clicked;Long	ll_Produto
Long	ll_Linha

dw_1.AcceptText()

ll_Linha		= dw_2.GetRow()

If ll_Linha > 0 Then
	ll_Produto	= dw_2.Object.cd_produto[ ll_Linha ]
	
	If IsNull(ll_Produto) or (ll_Produto = 0) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deve ser selecionado um produto.")
		dw_2.SetFocus()
		Return 1
	End If
	
	CloseWithReturn(Parent, ll_Produto)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deve ser selecionado um produto.")
	dw_2.SetFocus()
	Return 1
End If

end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge488_selecao_produto_nf
string text = "Close"
end type

event cb_cancelar::clicked;call super::clicked;Close( Parent )
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge488_selecao_produto_nf
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge488_selecao_produto_nf
end type

