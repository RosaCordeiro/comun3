HA$PBExportHeader$w_ge024_selecao_centro_custo.srw
forward
global type w_ge024_selecao_centro_custo from dc_w_selecao_generica
end type
end forward

global type w_ge024_selecao_centro_custo from dc_w_selecao_generica
integer x = 827
integer width = 2240
integer height = 1540
string title = "GE024 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Departamentos / Filiais"
end type
global w_ge024_selecao_centro_custo w_ge024_selecao_centro_custo

type variables
uo_centro_custo ivo_centro_custo



end variables

on w_ge024_selecao_centro_custo.create
call super::create
end on

on w_ge024_selecao_centro_custo.destroy
call super::destroy
end on

event open;call super::open;STRING lvs_Centro_Custo

ivo_Centro_Custo = Message.PowerObjectParm

lvs_Centro_Custo = ivo_Centro_Custo.ivs_Parametro_Selecao

If lvs_Centro_Custo <> "" Then
	dw_1.Object.de_centro_custo[1] = lvs_Centro_custo
	ivb_Pesquisa_Direta = True
End If

end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge024_selecao_centro_custo
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge024_selecao_centro_custo
integer x = 23
integer y = 188
integer width = 2185
integer height = 1116
long backcolor = 80269524
string text = "Lista de Departamentos / Filiais"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge024_selecao_centro_custo
integer x = 23
integer y = 4
integer width = 2185
integer height = 168
long backcolor = 80269524
string text = "Par$$HEX1$$e200$$ENDHEX$$metro de Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge024_selecao_centro_custo
integer x = 32
integer y = 60
integer width = 2158
integer height = 84
string dataobject = "dw_ge024_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge024_selecao_centro_custo
integer x = 50
integer y = 236
integer width = 2135
integer height = 1048
string dataobject = "dw_ge024_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Centro_Custo
String lvs_Situacao

dw_1.AcceptText()

lvs_Centro_Custo 	= Trim(dw_1.Object.de_centro_custo[1])
lvs_Situacao			= dw_1.Object.id_situacao	[1]

If lvs_Centro_Custo <> "" Then
	This.of_AppendWhere("de_centro_custo like '" + lvs_Centro_Custo + "%'")
End If

// S$$HEX1$$f300$$ENDHEX$$ vai trazer os departamentos
If ivo_Centro_Custo.ivb_Centro_Custo Then
	This.of_AppendWhere(" ( cd_filial = 534 Or id_tipo_centro_custo = 'E' )")
End If

If lvs_Situacao <> 'T' Then
	This.of_AppendWhere("id_situacao = '" + lvs_Situacao + "' ")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge024_selecao_centro_custo
integer x = 1449
integer y = 1324
end type

event cb_selecionar::clicked;Long lvl_Linha, &
     lvl_Centro_Custo

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Centro_Custo = dw_2.Object.cd_centro_custo[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_centro_custo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um centro de Custo.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge024_selecao_centro_custo
integer x = 1838
integer y = 1324
end type

event cb_cancelar::clicked;STRING lvs_Centro_Custo

SetNull(lvs_Centro_Custo)

CloseWithReturn(Parent, lvs_Centro_Custo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge024_selecao_centro_custo
integer x = 1061
integer y = 1324
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge024_selecao_centro_custo
integer x = 37
integer y = 1336
integer width = 759
long backcolor = 80269524
end type

