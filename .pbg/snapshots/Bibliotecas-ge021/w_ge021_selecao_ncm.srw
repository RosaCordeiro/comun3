HA$PBExportHeader$w_ge021_selecao_ncm.srw
forward
global type w_ge021_selecao_ncm from dc_w_selecao_generica
end type
end forward

global type w_ge021_selecao_ncm from dc_w_selecao_generica
integer width = 2427
string title = "GE021 - Sele$$HEX2$$e700e300$$ENDHEX$$o NCM"
end type
global w_ge021_selecao_ncm w_ge021_selecao_ncm

type variables
Long ivl_NCM
end variables

on w_ge021_selecao_ncm.create
call super::create
end on

on w_ge021_selecao_ncm.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Param
String lvs_NCM

lvs_Param = Upper(Trim(Message.StringParm))
lvs_NCM = Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)

If IsNumber(lvs_NCM) Then
	ivl_NCM = Long(lvs_NCM)
End If 

dw_1.Object.de_ncm [1] = Mid(lvs_Param,Pos(lvs_Param,';') + 1)

If Len(lvs_Param) > 3 then dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge021_selecao_ncm
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge021_selecao_ncm
integer y = 276
integer width = 2350
integer height = 1012
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge021_selecao_ncm
integer width = 2048
integer height = 256
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge021_selecao_ncm
integer width = 1989
integer height = 156
string dataobject = "dw_ge021_selecao_ncm"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge021_selecao_ncm
integer y = 348
integer width = 2295
integer height = 912
string dataobject = "dw_ge021_lista_ncm"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Ini
Long lvl_Fim

String lvs_Desc

dw_1.Accepttext( )

lvl_Ini		= dw_1.Object.nr_ncm_ini	[1]
lvl_Fim	= dw_1.Object.nr_ncm_fim	[1]
lvs_Desc	= dw_1.Object.de_ncm		[1]

If (Not IsNull(lvl_Ini)) and (lvl_Ini > 0) Then 
	This.Of_AppendWhere('nr_ncm >= '+String(lvl_Ini))
End If

If (Not IsNull(lvl_Fim)) and (lvl_Fim > 0) Then 
	This.Of_AppendWhere('nr_ncm <= '+String(lvl_Fim))
End If

If (Not IsNull(lvs_Desc)) and (Trim(lvs_Desc)<>'') Then 
	This.Of_AppendWhere("((de_ncm like '%"+lvs_Desc+"%') or (cast(nr_ncm as varchar(10)) like '"+lvs_Desc+"%'))" )
End If

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Find

If Not IsNull(ivl_NCM) Then
	lvl_Find = This.Find('nr_ncm='+String(ivl_NCM),1,This.RowCount())
	
	If lvl_Find > 0 Then
		This.ScrollToRow(lvl_Find)
		This.SetRow(lvl_Find)
	End If
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge021_selecao_ncm
integer x = 1623
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_NCM

SetNull(lvl_NCM)
If dw_2.GetRow() > 0 Then
	lvl_NCM = dw_2.Object.nr_ncm [dw_2.GetRow()]
End If

CloseWithReturn(Parent,String(lvl_NCM))
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge021_selecao_ncm
integer x = 2011
string text = "Cancelar"
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge021_selecao_ncm
integer x = 1179
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge021_selecao_ncm
boolean visible = false
end type

