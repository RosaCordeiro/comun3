HA$PBExportHeader$w_ge021_selecao_ncm_situacao_tipo.srw
forward
global type w_ge021_selecao_ncm_situacao_tipo from dc_w_selecao_generica
end type
end forward

global type w_ge021_selecao_ncm_situacao_tipo from dc_w_selecao_generica
integer width = 2336
string title = "GE021 - Sele$$HEX2$$e700e300$$ENDHEX$$o NCM Situa$$HEX2$$e700e300$$ENDHEX$$o Tipo"
end type
global w_ge021_selecao_ncm_situacao_tipo w_ge021_selecao_ncm_situacao_tipo

on w_ge021_selecao_ncm_situacao_tipo.create
call super::create
end on

on w_ge021_selecao_ncm_situacao_tipo.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Parametro
String lvs_Pesquisa

lvs_Parametro = Message.StringParm

If Not IsNull(lvs_Parametro) and Trim(lvs_Parametro) <> "" Then
	dw_1.Object.de_pesquisa [1] = gf_replace(lvs_Parametro, ";", "", 0)
End If

If 	(Not IsNull(lvs_Parametro) and Trim(lvs_Parametro) <> "") Then
	dw_2.Event ue_Retrieve()
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge021_selecao_ncm_situacao_tipo
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge021_selecao_ncm_situacao_tipo
integer y = 212
integer width = 2249
integer height = 1076
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge021_selecao_ncm_situacao_tipo
integer width = 1499
integer height = 184
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge021_selecao_ncm_situacao_tipo
integer width = 1445
integer height = 96
string dataobject = "dw_ge021_selecao_ncm_sit_tipo"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge021_selecao_ncm_situacao_tipo
integer y = 284
integer width = 2181
integer height = 984
string dataobject = "dw_ge021_lista_ncm_sit_tipo"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Filtro

dw_1.AcceptText( )

lvs_Filtro	= dw_1.Object.de_pesquisa	[1]

If lvs_Filtro <> '' Then
	This.Of_AppendWhere("(de_tipo_situacao_ncm like '%"+lvs_Filtro+"%'"+IIF(IsNumber(lvs_Filtro), " or cd_tipo_situacao_ncm = "+lvs_Filtro, "")+")" )
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge021_selecao_ncm_situacao_tipo
integer x = 1518
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Codigo

If dw_2.GetRow() > 0 Then
	lvl_Codigo = dw_2.Object.cd_tipo_situacao_ncm [dw_2.GetRow()]
	CloseWithReturn(Parent,String(lvl_Codigo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Selecione um registro antes de confirmar.", Exclamation!)
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge021_selecao_ncm_situacao_tipo
integer x = 1906
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,"")
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge021_selecao_ncm_situacao_tipo
integer x = 1074
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge021_selecao_ncm_situacao_tipo
integer width = 1019
integer height = 128
end type

