HA$PBExportHeader$w_ge021_selecao_ncm_situacao.srw
forward
global type w_ge021_selecao_ncm_situacao from dc_w_selecao_generica
end type
end forward

global type w_ge021_selecao_ncm_situacao from dc_w_selecao_generica
integer width = 2679
string title = "GE021 - Sele$$HEX2$$e700e300$$ENDHEX$$o Situa$$HEX2$$e700e300$$ENDHEX$$o NCM "
end type
global w_ge021_selecao_ncm_situacao w_ge021_selecao_ncm_situacao

type variables
uo_ncm ivo_ncm
end variables

on w_ge021_selecao_ncm_situacao.create
call super::create
end on

on w_ge021_selecao_ncm_situacao.destroy
call super::destroy
end on

event ue_preopen;call super::ue_preopen;ivo_ncm = Create uo_ncm
end event

event close;call super::close;Destroy(ivo_ncm)
end event

event ue_postopen;call super::ue_postopen;String lvs_Param
String lvs_NCM
String lvs_UF
String lvs_Filtro

dw_1.Event ue_AddRow()

lvs_Param = Message.StringParm

lvs_NCM		= Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
lvs_Param	= Mid(lvs_Param,Pos(lvs_Param,';') + 1)
lvs_UF 		= Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
lvs_Param	= Mid(lvs_Param,Pos(lvs_Param,';') + 1)
lvs_Filtro		= Mid(lvs_Param,1)

If IsNumber(lvs_NCM) Then
	ivo_ncm.of_localiza_codigo(Long(lvs_NCM))
	
	dw_1.Object.de_ncm	[1] = ivo_ncm.de_ncm
	dw_1.Object.nr_ncm	[1] = ivo_ncm.nr_ncm
End if

If Trim(lvs_UF)<>'' Then
	dw_1.Object.cd_uf		[1] = lvs_UF
End If

dw_1.Object.de_pesquisa[1] = lvs_Filtro

dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge021_selecao_ncm_situacao
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge021_selecao_ncm_situacao
integer y = 376
integer width = 2606
integer height = 912
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge021_selecao_ncm_situacao
integer width = 1783
integer height = 348
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge021_selecao_ncm_situacao
integer width = 1701
integer height = 260
string dataobject = "dw_ge021_selecao_sit_especial"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge021_selecao_ncm_situacao
integer y = 448
integer width = 2523
integer height = 812
string dataobject = "dw_ge021_lista_sit_especial"
end type

event dw_2::constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_NCM
String lvs_UF
String lvs_Pesquisa

dw_1.Accepttext( )

lvl_NCM		= dw_1.Object.nr_ncm		[1]
lvs_UF		= dw_1.Object.cd_uf			[1]
lvs_Pesquisa= dw_1.Object.de_pesquisa	[1]

If (Not IsNull(lvl_NCM)) and (lvl_NCM > 0) Then
	This.of_appendwhere('nr_ncm='+String(lvl_NCM))
End If

If lvs_UF <> "TD" Then
	This.of_appendwhere("cd_uf='"+lvs_UF+"'")
End If

If (Not IsNull(lvs_Pesquisa)) and (trim(lvs_Pesquisa)<>'') Then
	This.of_appendwhere("de_situacao_especial like '%"+lvs_Pesquisa+"%'")
End if

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge021_selecao_ncm_situacao
integer x = 1879
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Retorno

Long lvl_Linha

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Retorno = String(dw_2.Object.nr_ncm 	[lvl_Linha])	+ ';'
	lvs_Retorno += dw_2.Object.cd_uf 			[lvl_Linha]	+ ';'
	lvs_Retorno += dw_2.Object.nr_sequencial	[lvl_Linha]
	
	CloseWithReturn(Parent,lvs_Retorno)
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione uma situa$$HEX2$$e700e300$$ENDHEX$$o!')
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge021_selecao_ncm_situacao
integer x = 2267
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge021_selecao_ncm_situacao
integer x = 1435
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge021_selecao_ncm_situacao
end type

