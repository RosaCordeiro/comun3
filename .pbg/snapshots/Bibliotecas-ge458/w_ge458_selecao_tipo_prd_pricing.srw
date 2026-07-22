HA$PBExportHeader$w_ge458_selecao_tipo_prd_pricing.srw
forward
global type w_ge458_selecao_tipo_prd_pricing from dc_w_selecao_generica
end type
end forward

global type w_ge458_selecao_tipo_prd_pricing from dc_w_selecao_generica
integer width = 2057
string title = "GE458 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tipo Produto Pricing"
end type
global w_ge458_selecao_tipo_prd_pricing w_ge458_selecao_tipo_prd_pricing

on w_ge458_selecao_tipo_prd_pricing.create
call super::create
end on

on w_ge458_selecao_tipo_prd_pricing.destroy
call super::destroy
end on

type pb_help from dc_w_selecao_generica`pb_help within w_ge458_selecao_tipo_prd_pricing
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge458_selecao_tipo_prd_pricing
integer y = 220
integer width = 1970
integer height = 1064
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge458_selecao_tipo_prd_pricing
integer width = 1541
integer height = 188
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge458_selecao_tipo_prd_pricing
integer width = 1490
integer height = 88
string dataobject = "dw_ge458_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge458_selecao_tipo_prd_pricing
integer y = 292
integer width = 1888
integer height = 964
string dataobject = "dw_ge458_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::doubleclicked;//override
cb_selecionar.event clicked( )
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Parametro

dw_1.Accepttext( )
lvs_Parametro = dw_1.Object.de_pesquisa [1]

If Not IsNull(lvs_Parametro) and (Trim(lvs_Parametro)<>"") Then
	This.Of_appendwhere( "de_tipo_produto like '%"+Upper(lvs_Parametro)+"%'" )
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge458_selecao_tipo_prd_pricing
integer x = 1243
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Codigo

If dw_2.GetRow() > 0 Then
	lvl_Codigo = dw_2.Object.cd_tipo_produto [dw_2.GetRow()]
	
	CloseWithReturn(Parent, String(lvl_Codigo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um registro para confirmar.")
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge458_selecao_tipo_prd_pricing
integer x = 1632
end type

event cb_cancelar::clicked;call super::clicked;Close( Parent )
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge458_selecao_tipo_prd_pricing
integer x = 800
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge458_selecao_tipo_prd_pricing
integer width = 754
integer height = 148
end type

