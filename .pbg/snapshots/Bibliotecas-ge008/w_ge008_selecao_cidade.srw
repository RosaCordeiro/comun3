HA$PBExportHeader$w_ge008_selecao_cidade.srw
forward
global type w_ge008_selecao_cidade from dc_w_selecao_generica
end type
end forward

global type w_ge008_selecao_cidade from dc_w_selecao_generica
integer x = 741
integer y = 412
integer width = 2185
integer height = 1568
string title = "GE008 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Cidades"
end type
global w_ge008_selecao_cidade w_ge008_selecao_cidade

type variables
uo_cidade ivo_cidade


end variables

on w_ge008_selecao_cidade.create
call super::create
end on

on w_ge008_selecao_cidade.destroy
call super::destroy
end on

event open;call super::open;STRING lvs_Cidade

ivo_cidade = Message.PowerObjectParm

lvs_Cidade = ivo_cidade.ivs_Parametro_Selecao

If lvs_Cidade <> "" Then
	dw_1.Object.nm_cidade[1] = lvs_Cidade
	ivb_Pesquisa_Direta = True
End If

end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge008_selecao_cidade
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge008_selecao_cidade
integer x = 23
integer y = 276
integer width = 2112
integer height = 1056
long backcolor = 80269524
string text = "Lista de Cidades"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge008_selecao_cidade
integer x = 23
integer y = 4
integer width = 1527
integer height = 260
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge008_selecao_cidade
integer x = 41
integer y = 72
integer width = 1499
integer height = 176
string dataobject = "dw_ge008_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge008_selecao_cidade
integer x = 41
integer y = 324
integer width = 2071
integer height = 984
string dataobject = "dw_ge008_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Cidade,&
       lvs_Uf


dw_1.AcceptText()

lvs_Cidade = Trim(dw_1.Object.Nm_Cidade[1])
lvs_Uf     = Trim(dw_1.Object.cd_unidade_federacao[1])

If lvs_Cidade <> "" Then
	This.of_AppendWhere("nm_cidade like '" + lvs_Cidade + "%'")
End If

If lvs_Uf <> "" Then
	This.of_AppendWhere("cd_unidade_federacao = '" + lvs_Uf + "'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge008_selecao_cidade
integer x = 1376
integer y = 1352
end type

event cb_selecionar::clicked;Long lvl_Linha, &
     lvl_Cidade

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Cidade = dw_2.Object.Cd_Cidade[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Cidade))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma cidade.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge008_selecao_cidade
integer x = 1765
integer y = 1352
end type

event cb_cancelar::clicked;STRING lvs_Cidade

SetNull(lvs_Cidade)

CloseWithReturn(Parent, lvs_Cidade)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge008_selecao_cidade
integer x = 978
integer y = 1352
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge008_selecao_cidade
integer x = 27
integer y = 1364
integer width = 928
long backcolor = 80269524
end type

