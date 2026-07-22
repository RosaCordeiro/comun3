HA$PBExportHeader$w_ge009_selecao_filial.srw
forward
global type w_ge009_selecao_filial from dc_w_selecao_generica
end type
end forward

global type w_ge009_selecao_filial from dc_w_selecao_generica
integer x = 494
integer y = 436
integer width = 2674
integer height = 1520
string title = "GE009 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Filiais"
end type
global w_ge009_selecao_filial w_ge009_selecao_filial

type variables
uo_filial ivo_filial


end variables

on w_ge009_selecao_filial.create
call super::create
end on

on w_ge009_selecao_filial.destroy
call super::destroy
end on

event open;call super::open;STRING lvs_Filial

ivo_Filial = Message.PowerObjectParm

lvs_Filial = Upper(ivo_Filial.ivs_Parametro_Selecao)

If Not IsNull(ivo_filial.ivs_Filtro_Situacao) and (ivo_filial.ivs_Filtro_Situacao<>"") Then
	dw_1.Object.id_situacao[1] 			= ivo_filial.ivs_Filtro_Situacao
	dw_1.Object.id_situacao.Protect 	= 1
Else
	dw_1.Object.id_situacao.Protect 	= 0
End If

If Not IsNull(ivo_filial.ivs_Filtro_UF) and (ivo_filial.ivs_Filtro_UF<>"") Then
	dw_1.Object.cd_uf	[1] 			= ivo_filial.ivs_Filtro_UF
	dw_1.Object.cd_uf.Protect 	= 1
End If

If lvs_Filial <> "" Then
	dw_1.Object.nm_fantasia[1] = lvs_Filial
	ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge009_selecao_filial
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge009_selecao_filial
integer x = 18
integer y = 188
integer width = 2610
integer height = 1096
long backcolor = 80269524
string text = "Lista de Filiais"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge009_selecao_filial
integer x = 18
integer y = 4
integer width = 2213
integer height = 176
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge009_selecao_filial
integer x = 41
integer y = 64
integer width = 2181
integer height = 96
string dataobject = "dw_ge009_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge009_selecao_filial
integer x = 41
integer y = 240
integer width = 2565
integer height = 1016
string dataobject = "dw_ge009_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Fantasia
String lvs_Situacao
String lvs_UF

dw_1.AcceptText()

lvs_Fantasia = Trim(dw_1.Object.Nm_Fantasia	[1])
lvs_Situacao = Trim(dw_1.Object.id_situacao	[1])
lvs_UF		 = Trim(dw_1.Object.cd_uf			[1])

If lvs_Fantasia <> "" Then
	This.of_AppendWhere("f.nm_fantasia like '%" + lvs_Fantasia + "%'"+IIF(IsNumber(lvs_Fantasia)," or f.cd_filial = "+lvs_Fantasia,''))
End If

If lvs_Situacao <> "T" Then
	This.of_AppendWhere("f.id_situacao = '" + lvs_Situacao + "'")
End If

If ivo_Filial.ivs_Centralizadora = "S" Then
	This.of_AppendWhere("f.id_regional = 'S'")	
End If

If Not IsNull(lvs_UF) and (lvs_UF<>"") Then
	This.Of_AppendWhere("c.cd_unidade_federacao='"+lvs_UF+"'")
End If

// N$$HEX1$$e300$$ENDHEX$$o mostra filiais DrogaExpress
//If gvo_parametro.cd_Filial <> gvo_parametro.cd_filial_matriz Then
//	This.of_AppendWhere("cd_filial_sede_drogaexpress is null")
//End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge009_selecao_filial
integer x = 1865
integer y = 1308
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Filial

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Filial = dw_2.Object.Cd_Filial[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Filial))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma filial.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge009_selecao_filial
integer x = 2258
integer y = 1308
end type

event cb_cancelar::clicked;call super::clicked;STRING lvs_Filial

SetNull(lvs_Filial)

CloseWithReturn(Parent, lvs_Filial)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge009_selecao_filial
integer x = 1371
integer y = 1308
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge009_selecao_filial
integer x = 23
integer y = 1320
integer width = 1207
long backcolor = 80269524
end type

