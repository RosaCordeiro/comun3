HA$PBExportHeader$w_ge289_selecao_consulta_rentabilidade.srw
forward
global type w_ge289_selecao_consulta_rentabilidade from dc_w_selecao_generica
end type
end forward

global type w_ge289_selecao_consulta_rentabilidade from dc_w_selecao_generica
integer width = 3154
integer height = 1572
string title = "GE289 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Consulta de Rentabilidade"
long backcolor = 80269524
end type
global w_ge289_selecao_consulta_rentabilidade w_ge289_selecao_consulta_rentabilidade

on w_ge289_selecao_consulta_rentabilidade.create
call super::create
end on

on w_ge289_selecao_consulta_rentabilidade.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;STRING lvs_Consulta

lvs_Consulta = Message.StringParm

If lvs_Consulta <> "" Then
	dw_1.Object.descricao[1] = lvs_Consulta
	dw_2.Event ue_Retrieve()
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge289_selecao_consulta_rentabilidade
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge289_selecao_consulta_rentabilidade
integer y = 216
integer width = 3063
integer height = 1112
long backcolor = 80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge289_selecao_consulta_rentabilidade
integer width = 1541
integer height = 192
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge289_selecao_consulta_rentabilidade
integer width = 1472
integer height = 92
string dataobject = "dw_ge289_selecao_consulta_rentabilidade"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge289_selecao_consulta_rentabilidade
integer y = 272
integer width = 2990
integer height = 1028
string dataobject = "dw_ge289_lista_consulta_rentab"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_descricao

dw_1.AcceptText()

lvs_Descricao = dw_1.Object.descricao[1]

If Trim(lvs_Descricao) <> "" Then
	This.of_AppendWhere("de_consulta like '" + lvs_Descricao + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge289_selecao_consulta_rentabilidade
integer x = 2299
integer y = 1352
end type

event cb_selecionar::clicked;Long lvl_Linha

String lvs_Consulta

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Consulta = String(dw_2.Object.Cd_Consulta[lvl_Linha])
	
	CloseWithReturn(Parent, lvs_Consulta)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma consulta.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge289_selecao_consulta_rentabilidade
integer x = 2725
integer y = 1352
end type

event cb_cancelar::clicked;String lvs_Consulta

SetNull(lvs_Consulta)

CloseWithReturn(Parent, lvs_Consulta)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge289_selecao_consulta_rentabilidade
integer x = 1856
integer y = 1352
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge289_selecao_consulta_rentabilidade
integer y = 1356
long backcolor = 80269524
end type

