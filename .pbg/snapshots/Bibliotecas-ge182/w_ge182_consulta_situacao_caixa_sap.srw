HA$PBExportHeader$w_ge182_consulta_situacao_caixa_sap.srw
forward
global type w_ge182_consulta_situacao_caixa_sap from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge182_consulta_situacao_caixa_sap from dc_w_selecao_lista_relatorio
integer width = 3941
integer height = 1756
string title = "GE182 - Relat$$HEX1$$f300$$ENDHEX$$rio Situa$$HEX2$$e700e300$$ENDHEX$$o Exporta$$HEX2$$e700e300$$ENDHEX$$o Caixas (SAP)"
end type
global w_ge182_consulta_situacao_caixa_sap w_ge182_consulta_situacao_caixa_sap

type variables
uo_Filial ivo_Filial
end variables

on w_ge182_consulta_situacao_caixa_sap.create
call super::create
end on

on w_ge182_consulta_situacao_caixa_sap.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;MaxWidth = 4905
MaxHeight = 12999

ivo_Filial = Create uo_Filial

end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-6)
dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)

ivm_menu.ivb_permite_imprimir = True
end event

event ue_print;//override
dw_3.Event ue_Print()
end event

event ue_printimmediate;call super::ue_printimmediate;//override
dw_3.Event ue_PrintImmediate()
end event

event ue_saveas;//override
dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge182_consulta_situacao_caixa_sap
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge182_consulta_situacao_caixa_sap
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge182_consulta_situacao_caixa_sap
integer x = 18
integer width = 3840
integer height = 1168
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge182_consulta_situacao_caixa_sap
integer x = 18
integer width = 2395
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge182_consulta_situacao_caixa_sap
integer x = 59
integer width = 2336
integer height = 272
string dataobject = "dw_ge182_sap_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;If Dwo.Name = "nm_filial" Then
	If Trim(Data) <> "" Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If	
	Else	
		ivo_Filial.Of_Inicializa()
		
		This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
		This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		
		ivo_Filial.of_Localiza_Filial(GetText())
		
		If ivo_Filial.Localizada Then
			
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
		End If
		
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If Not IsNull(This.Object.cd_filial[1]) Then
	If IsValid(ivo_Filial) Then
		This.Object.cd_filial	[1] = ivo_Filial.cd_filial
		This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge182_consulta_situacao_caixa_sap
integer x = 50
integer width = 3685
integer height = 1060
string dataobject = "dw_ge182_sap_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//override
Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio	= dw_1.Object.dt_inicio	[1]
lvdt_Fim		= dw_1.Object.dt_fim		[1]

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_menu.mf_Imprimir(This.RowCount() > 0)
ivm_menu.mf_SalvarComo(This.RowCount() > 0)

dw_2.setfilter("")
dw_2.filter( )

//Filtrar
if dw_1.Object.com_mov_sap[1] = 'S' then
	 dw_2.setfilter("qt_lanctos_sap > 0")
	 dw_2.filter()
end if

Return AncestorReturnValue
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial

String lvs_Situacao

dw_1.AcceptText( )

lvs_Situacao			= dw_1.Object.id_situacao		[1]
lvl_Filial				= dw_1.Object.cd_filial			[1]

If lvl_Filial > 0 Then
	This.Of_AppendWhere_SubQuery('cx.cd_filial='+String(lvl_Filial),2)
	This.Of_AppendWhere_SubQuery('cx.cd_filial='+String(lvl_Filial),1)
End If

Choose Case lvs_Situacao
	Case 'NF'
		This.Of_AppendWhere_SubQuery('cc.dh_conferencia is null',2)		
		This.Of_AppendWhere_SubQuery('cc.dh_conferencia is null',1)	
	Case 'NR'
		This.Of_AppendWhere_SubQuery('cc.dh_revisao is null',2)		
		This.Of_AppendWhere_SubQuery('cc.dh_revisao is null',1)						
	Case 'NE'
		This.Of_AppendWhere_SubQuery("le.dh_exportacao is null",2)
		This.Of_AppendWhere_SubQuery("le.dh_exportacao is null",1)
	Case 'IM'
		This.Of_AppendWhere_SubQuery("le.dh_exportacao is not null",2)
		This.Of_AppendWhere_SubQuery("le.dh_exportacao is not null",1)
End Choose

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.ShareData(dw_3)
end event

event dw_2::ue_reset;call super::ue_reset;ivm_menu.mf_Imprimir(False)
ivm_menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge182_consulta_situacao_caixa_sap
integer x = 2661
integer y = 40
integer height = 172
string dataobject = "dw_ge182_sap_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Fim

dw_1.accepttext( )

lvdt_Inicio	= dw_1.Object.dt_inicio	[1]
lvdt_Fim		= dw_1.Object.dt_fim		[1]

This.Object.st_periodo.Text		= 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Inicio,'DD/MM/YYYY')
This.Object.st_situacao.Text	= 'Situa$$HEX2$$e700e300$$ENDHEX$$o: '+dw_1.Describe("Evaluate('LookUpDisplay(id_situacao)',1)")

Return AncestorReturnValue
end event

