HA$PBExportHeader$w_ge085_selecao_prescritor_receita.srw
forward
global type w_ge085_selecao_prescritor_receita from dc_w_selecao_generica
end type
end forward

global type w_ge085_selecao_prescritor_receita from dc_w_selecao_generica
integer x = 613
integer y = 720
integer width = 3442
integer height = 1636
string title = "GE085 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Prescritores"
long backcolor = 80269524
end type
global w_ge085_selecao_prescritor_receita w_ge085_selecao_prescritor_receita

type variables
uo_prescritor_receita ivo_prescritor

end variables

on w_ge085_selecao_prescritor_receita.create
call super::create
end on

on w_ge085_selecao_prescritor_receita.destroy
call super::destroy
end on

event open;call super::open;String lvs_Prescritor

ivo_prescritor = Create uo_prescritor_receita
ivo_Prescritor = Message.PowerObjectParm

lvs_Prescritor = ivo_Prescritor.ivs_Parametro

If lvs_Prescritor <> "" Then
	dw_1.Object.Nm_Prescritor[1] = lvs_Prescritor
	This.ivb_Pesquisa_Direta  = True
End If

dw_1.Object.Cd_Uf[ 1 ] = gvo_Parametro.ivs_Uf_Filial
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge085_selecao_prescritor_receita
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge085_selecao_prescritor_receita
integer y = 292
integer width = 3355
integer height = 1100
long backcolor = 80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge085_selecao_prescritor_receita
integer y = 16
integer width = 3017
integer height = 272
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge085_selecao_prescritor_receita
integer x = 59
integer width = 2953
integer height = 188
string dataobject = "dw_ge085_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge085_selecao_prescritor_receita
integer x = 59
integer y = 344
integer width = 3314
integer height = 1020
string dataobject = "dw_ge085_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_where, &
       lvs_sql 
	   
Long   lvl_Linha

String lvs_id_registro
String lvs_nr_registro
String lvs_cd_uf
String lvs_nm_prescritor

dw_1.AcceptText()

lvl_Linha = dw_1.GetRow()

lvs_id_registro   = dw_1.Object.id_registro  [lvl_Linha]
lvs_nr_registro   = dw_1.Object.nr_registro  [lvl_Linha]
lvs_cd_uf         = dw_1.Object.cd_uf        [lvl_Linha]
lvs_nm_prescritor = dw_1.Object.nm_prescritor[lvl_Linha]

lvs_sql   = This.ivs_sql_original
lvs_where = ''

If lvs_id_registro <> 'T' Then
	lvs_where = "p.id_registro = '" + lvs_id_registro + "'"
End If

If Long(lvs_nr_registro) <> 0 Then
	If Trim(lvs_Where) <> '' Then lvs_where += " and "
	lvs_where += "p.nr_registro = '" + String(Long(lvs_nr_registro),'00000000') + "'"
End If

If Not IsNull(lvs_cd_uf) and Trim(lvs_cd_uf) <> "" Then
	If Trim(lvs_Where) <> '' Then lvs_where += " and "
	lvs_where += "p.cd_unidade_federacao = '" + lvs_cd_uf + "'"
End If

If Not IsNull(lvs_nm_prescritor) and Trim(lvs_nm_prescritor) <> "" Then
	If Trim(lvs_Where) <> '' Then lvs_where += " and "
	lvs_where += "p.nm_prescritor like '" + lvs_nm_prescritor + "%'"
End If

If Trim(lvs_where) <> '' Then
	This.of_AppendWhere(lvs_where)
	Return 1	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um par$$HEX1$$e200$$ENDHEX$$metro para sele$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Return -1
End If
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge085_selecao_prescritor_receita
integer x = 2633
integer y = 1412
end type

event cb_selecionar::clicked;Long   lvl_Linha

String lvs_id_registro
String lvs_nr_registro
String lvs_cd_uf

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	
	ivo_Prescritor.ivs_Retorno = "OK"
	
	ivo_Prescritor.id_registro          = dw_2.Object.id_registro[lvl_Linha]
	ivo_Prescritor.nr_registro          = dw_2.Object.nr_registro[lvl_Linha]
	ivo_Prescritor.cd_unidade_federacao = dw_2.Object.cd_uf      [lvl_Linha]
	
	CloseWithReturn(Parent, ivo_Prescritor)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Prescritor.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge085_selecao_prescritor_receita
integer x = 3022
integer y = 1412
end type

event cb_cancelar::clicked;ivo_Prescritor.ivs_Retorno = "CANCELAR"

CloseWithReturn(Parent, ivo_Prescritor)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge085_selecao_prescritor_receita
integer x = 2245
integer y = 1412
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge085_selecao_prescritor_receita
integer x = 41
integer y = 1428
integer width = 1568
long backcolor = 80269524
end type

