HA$PBExportHeader$w_ge021_selecao_imposto_sap.srw
forward
global type w_ge021_selecao_imposto_sap from dc_w_selecao_generica
end type
end forward

global type w_ge021_selecao_imposto_sap from dc_w_selecao_generica
integer width = 2336
string title = "GE021 - Sele$$HEX2$$e700e300$$ENDHEX$$o Imposto SAP"
end type
global w_ge021_selecao_imposto_sap w_ge021_selecao_imposto_sap

on w_ge021_selecao_imposto_sap.create
call super::create
end on

on w_ge021_selecao_imposto_sap.destroy
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

type pb_help from dc_w_selecao_generica`pb_help within w_ge021_selecao_imposto_sap
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge021_selecao_imposto_sap
integer y = 212
integer width = 2249
integer height = 1076
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge021_selecao_imposto_sap
integer width = 1499
integer height = 184
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge021_selecao_imposto_sap
integer width = 1445
integer height = 96
string dataobject = "dw_ge021_selecao_imposto_sap"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge021_selecao_imposto_sap
integer y = 284
integer width = 2199
integer height = 984
string dataobject = "dw_ge021_lista_imposto_sap"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Filtro

dw_1.AcceptText( )

lvs_Filtro	= dw_1.Object.de_pesquisa	[1]

If lvs_Filtro <> '' Then
	This.Of_AppendWhere("(de_imposto like '%"+lvs_Filtro+"%'"+IIF(Len(lvs_Filtro)< 5, " or cd_imposto = '"+lvs_Filtro+"'", "")+")" )
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge021_selecao_imposto_sap
integer x = 1518
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Codigo

If dw_2.GetRow() > 0 Then
	lvs_Codigo = dw_2.Object.cd_imposto [dw_2.GetRow()]
	CloseWithReturn(Parent,lvs_Codigo)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Selecione um registro antes de confirmar.", Exclamation!)
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge021_selecao_imposto_sap
integer x = 1906
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,"")
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge021_selecao_imposto_sap
integer x = 1074
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge021_selecao_imposto_sap
integer width = 1019
integer height = 128
end type

