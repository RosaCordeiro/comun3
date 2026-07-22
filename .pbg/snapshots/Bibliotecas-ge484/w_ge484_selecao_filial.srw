HA$PBExportHeader$w_ge484_selecao_filial.srw
forward
global type w_ge484_selecao_filial from dc_w_selecao_generica
end type
end forward

global type w_ge484_selecao_filial from dc_w_selecao_generica
integer width = 2510
integer height = 1524
string title = "GE484 - Sele$$HEX2$$e700e300$$ENDHEX$$o Filial (Mult)"
end type
global w_ge484_selecao_filial w_ge484_selecao_filial

type variables
uo_mult_filial ivo_filial
end variables

on w_ge484_selecao_filial.create
call super::create
end on

on w_ge484_selecao_filial.destroy
call super::destroy
end on

event open;call super::open;String lvs_filtro

ivo_filial = Message.PowerObjectParm

lvs_filtro = Upper(ivo_filial.ivs_Parametro_Selecao)

If lvs_filtro <> "" Then
	dw_1.Object.de_filtro[1] = lvs_filtro
End If
end event

event ue_postopen;call super::ue_postopen;dw_2.of_SetTransObject(ivo_filial.ivtr_Trans)

If (ivo_filial.ivs_Parametro_Selecao) <> '' Then
 	dw_2.Event ue_Retrieve()
End if
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge484_selecao_filial
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge484_selecao_filial
integer y = 292
integer height = 1004
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge484_selecao_filial
integer width = 1710
integer height = 272
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge484_selecao_filial
integer width = 1627
integer height = 188
string dataobject = "dw_ge484_selecao_filial"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge484_selecao_filial
integer y = 364
integer width = 2373
integer height = 904
string dataobject = "dw_ge484_lista_filial"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Padrao

String lvs_Filtro
String lvs_CNPJ

dw_1.Accepttext( )

lvs_CNPJ 	= dw_1.Object.nr_cnpj	[1]
lvs_Filtro		= dw_1.Object.de_filtro 	[1]

If Len(lvs_CNPJ) = 17 Then
	This.of_appendwhere("c.identificacao='"+lvs_CNPJ+"'")
End If

If Trim(lvs_Filtro)<>'' Then
	This.of_appendwhere("((upper(c.fantasia) like '%"+lvs_Filtro+"%'))")
End If

This.of_appendwhere("a.idf_empresa="+String(ivo_filial.IDF_Empresa))

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge484_selecao_filial
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Id

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Id = dw_2.Object.id [lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Id))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Tipo de Documento.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge484_selecao_filial
end type

event cb_cancelar::clicked;call super::clicked;Close(Parent)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge484_selecao_filial
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge484_selecao_filial
end type

