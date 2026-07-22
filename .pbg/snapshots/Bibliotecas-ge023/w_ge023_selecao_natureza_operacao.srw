HA$PBExportHeader$w_ge023_selecao_natureza_operacao.srw
forward
global type w_ge023_selecao_natureza_operacao from dc_w_selecao_generica
end type
end forward

global type w_ge023_selecao_natureza_operacao from dc_w_selecao_generica
integer x = 850
integer y = 436
integer width = 2258
integer height = 1572
string title = "GE023 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Naturezas de Opera$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge023_selecao_natureza_operacao w_ge023_selecao_natureza_operacao

type variables

end variables

on w_ge023_selecao_natureza_operacao.create
call super::create
end on

on w_ge023_selecao_natureza_operacao.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

lvs_Parametro = Message.StringParm

If lvs_Parametro <> "" Then
	dw_1.Object.De_Natureza_Operacao[1] = lvs_Parametro
End If

ivb_Pesquisa_Direta = True
end event

event ue_postopen;call super::ue_postopen;Long lvl_cd_filial_matriz
Long lvl_cd_filial

lvl_cd_filial_matriz = gvo_parametro.of_filial_matriz()
lvl_cd_filial = gvo_parametro.of_filial()

If lvl_cd_filial = lvl_cd_filial_matriz Then
	dw_1.Object.id_situacao.TabSequence = 30
	dw_1.Object.id_diversa.TabSequence = 40	
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge023_selecao_natureza_operacao
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge023_selecao_natureza_operacao
integer x = 27
integer y = 256
integer width = 2194
integer height = 1104
long backcolor = 80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge023_selecao_natureza_operacao
integer x = 27
integer width = 2194
integer height = 244
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge023_selecao_natureza_operacao
integer x = 50
integer y = 68
integer width = 2153
integer height = 176
string dataobject = "dw_ge023_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge023_selecao_natureza_operacao
integer x = 55
integer y = 316
integer width = 2135
integer height = 1016
string dataobject = "dw_ge023_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	lvs_Descricao, &
		lvs_Tipo , &
		lvs_Ativo, &
		lvs_Diversa, &
		lvs_CFOP

Long lvl_Cd_Filial_Matriz
Long lvl_Cd_Filial

dw_1.AcceptText()

lvs_Descricao	= Trim(dw_1.Object.De_Natureza_Operacao[1])
lvs_CFOP			= Trim(gf_replace(lvs_Descricao, ".","", 0))
lvs_Tipo			= dw_1.Object.id_tipo_Operacao[1]
lvs_Ativo			= dw_1.Object.id_situacao[1]
lvs_Diversa		= dw_1.Object.id_diversa[1]

If lvs_Descricao <> "" and Not IsNull(lvs_Descricao) Then
	This.of_AppendWhere("de_natureza_operacao like '" + lvs_Descricao + "%'"+IIF(IsNumber(lvs_CFOP), " or cd_natureza_operacao = "+lvs_CFOP, ""))
End If

If lvs_Tipo <> 'T' Then
	If lvs_Tipo = 'E' Then
		This.of_AppendWhere("id_estadual = 'S'")
	Else
		This.of_AppendWhere("(id_estadual is null or id_estadual = 'N')")
	End If
End If

//Filtra apenas CFOPs habilitada para Diversas
lvl_cd_filial_matriz = gvo_parametro.of_filial_matriz()
lvl_cd_filial = gvo_parametro.of_filial()
If lvl_cd_filial_matriz <> lvl_cd_filial Then
	If lvs_Diversa <> 'N' Then
		This.of_AppendWhere("id_diversa = 'S'")
	End If
Else
	If lvs_Diversa <> 'N' Then
		This.of_AppendWhere("id_diversa_matriz = 'S'")
	End If
	If lvs_Ativo <> 'T' Then
		This.of_AppendWhere("id_situacao='"+lvs_Ativo+"'")
	End If
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge023_selecao_natureza_operacao
integer x = 1463
integer y = 1368
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Cd_Natureza_Operacao

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Cd_Natureza_Operacao = String(dw_2.Object.Cd_Natureza_operacao[lvl_Linha])
	CloseWithReturn(Parent, lvs_Cd_Natureza_Operacao)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto na lista.", Information!, Ok!)
	dw_2.SetFocus()
End If

end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge023_selecao_natureza_operacao
integer x = 1851
integer y = 1368
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Nulo

SetNull(lvs_Nulo)

CloseWithReturn(Parent, lvs_Nulo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge023_selecao_natureza_operacao
integer x = 1074
integer y = 1368
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge023_selecao_natureza_operacao
integer x = 37
integer y = 1380
integer width = 1010
integer weight = 400
long backcolor = 80269524
end type

