HA$PBExportHeader$w_ge021_selecao_cest.srw
forward
global type w_ge021_selecao_cest from dc_w_selecao_generica
end type
end forward

global type w_ge021_selecao_cest from dc_w_selecao_generica
integer width = 2848
integer height = 1644
string title = "GE021 - Sele$$HEX2$$e700e300$$ENDHEX$$o CEST"
end type
global w_ge021_selecao_cest w_ge021_selecao_cest

type variables
String ivs_CEST
end variables

on w_ge021_selecao_cest.create
call super::create
end on

on w_ge021_selecao_cest.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Param
String lvs_NCM
String lvs_CEST
String lvs_Lista
String lvs_Tipo
String lvs_Pesquisa

lvs_Param	= Upper(Trim(Message.StringParm))
lvs_CEST		= Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
lvs_Param	= Mid(lvs_Param,Pos(lvs_Param,';') + 1)
lvs_Pesquisa= Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
lvs_Param	= Mid(lvs_Param,Pos(lvs_Param,';') + 1)
lvs_NCM		= Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
lvs_Param	= Mid(lvs_Param,Pos(lvs_Param,';') + 1)
lvs_Lista		= Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
lvs_Param	= Mid(lvs_Param,Pos(lvs_Param,';') + 1)
lvs_Tipo		= lvs_Param

If Trim(lvs_CEST)<>'' Then
	ivs_CEST = lvs_CEST
End If

If Trim(lvs_Lista) <> '' Then
	dw_1.Object.id_pis_cofins [1] = lvs_Lista
	dw_1.Object.id_pis_cofins.TabSequence = 0
End If

If Trim(lvs_Tipo) <> '' Then
	dw_1.Object.id_tipo [1] = lvs_Tipo
	dw_1.Object.id_tipo.TabSequence = 0
End If

dw_1.Object.de_pesquisa [1] = lvs_Pesquisa

If IsNumber(lvs_NCM) Then
	dw_1.Object.nr_ncm [1] = Long(lvs_NCM)
	dw_1.Object.nr_ncm.TabSequence = 0
End If 

If (Len(lvs_Pesquisa) > 3)or (Trim(lvs_NCM)<>'') then dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge021_selecao_cest
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge021_selecao_cest
integer y = 364
integer width = 2775
integer height = 1028
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge021_selecao_cest
integer width = 2053
integer height = 340
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge021_selecao_cest
integer width = 1993
integer height = 244
string dataobject = "dw_ge021_selecao_cest"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge021_selecao_cest
integer y = 436
integer width = 2720
integer height = 928
string dataobject = "dw_ge021_lista_cest"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_NCM

String lvs_Desc
String lvs_Tipo
String lvs_Lista
String lvs_Where = ''

dw_1.Accepttext( )

lvl_NCM	= dw_1.Object.nr_ncm		[1]
lvs_Desc	= dw_1.Object.de_pesquisa	[1]
lvs_Tipo	= dw_1.Object.id_tipo		[1]
lvs_Lista	= dw_1.Object.id_pis_cofins[1]

If (Not IsNull(lvl_NCM)) and (lvl_NCM >= 0) Then
	
	//Apenas medicamentos
	If (lvl_NCM >= 30020000) and (lvl_NCM <= 30049999) Then
		If (lvl_NCM >= 30030000) and Trim(lvs_Tipo)<>'X' Then 
			If lvs_Tipo = "E" Then lvs_Tipo = "S"
			lvs_Where = " and cn1.id_tipo_produto = '"+lvs_Tipo+"'"
		End If
		
		If Trim(lvs_Lista)<>'X' Then 
			lvs_Where += " and cn1.id_lista_pis_cofins = '"+lvs_Lista+"'"
		End If
	End if
	
	This.Of_AppendWhere('(exists (select 1 from cest_ncm cn1 where cn1.cd_cest = c.cd_cest and cn1.nr_ncm_inicial = '+String(lvl_NCM)+' and cn1.nr_ncm_final is null)'+ &
								' or exists (select 1 from cest_ncm cn1 where cn1.cd_cest = c.cd_cest and cn1.nr_ncm_inicial <= '+String(lvl_NCM)+' and cn1.nr_ncm_final >= '+String(lvl_NCM)+lvs_Where+'))')
End If

If (Not IsNull(lvs_Desc)) and (Trim(lvs_Desc)<>'') Then 
	This.Of_AppendWhere("c.de_cest like '%"+lvs_Desc+"%'" )
End If

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Find

If Trim(ivs_CEST)<>'' Then
	lvl_Find = This.Find("cd_cest='"+ivs_CEST+"'",1,This.RowCount())
	
	If lvl_Find > 0 Then
		This.ScrollToRow(lvl_Find)
		This.SetRow(lvl_Find)
	End If
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge021_selecao_cest
integer x = 2053
integer y = 1428
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Cest = ''

If dw_2.GetRow() > 0 Then
	lvs_Cest = dw_2.Object.cd_cest [dw_2.GetRow()]
End If

CloseWithReturn(Parent,lvs_Cest)
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge021_selecao_cest
integer x = 2441
integer y = 1428
string text = "Cancelar"
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge021_selecao_cest
integer x = 1609
integer y = 1428
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge021_selecao_cest
boolean visible = false
integer y = 1428
end type

