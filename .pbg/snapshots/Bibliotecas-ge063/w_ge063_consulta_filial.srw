HA$PBExportHeader$w_ge063_consulta_filial.srw
forward
global type w_ge063_consulta_filial from dc_w_2tab_consulta_selecao_lista_det
end type
end forward

global type w_ge063_consulta_filial from dc_w_2tab_consulta_selecao_lista_det
integer width = 4210
integer height = 2440
string title = "GE063 - Consulta Filiais"
end type
global w_ge063_consulta_filial w_ge063_consulta_filial

type variables
uo_cidade ivo_cidade //GE008
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/* UF */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_uf" )			
ldwc_Child.SetItem(1, "cd_unidade_federacao", ""	)
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODOS")

Tab_1.Tabpage_1.dw_1.Object.cd_uf [1] = ""


/* Regi$$HEX1$$e300$$ENDHEX$$o */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_regiao" )			
ldwc_Child.SetItem(1, "cd_regiao", 0 )
ldwc_Child.SetItem(1, "de_regiao", "TODOS")

Tab_1.Tabpage_1.dw_1.Object.cd_regiao [1] = 0

/* Porte */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_porte" )			
ldwc_Child.SetItem(1, "cd_porte", 0 )
ldwc_Child.SetItem(1, "de_porte", "TODOS")

Tab_1.Tabpage_1.dw_1.Object.cd_porte [1] = 0

/* Rede */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("id_rede_filial" )			
ldwc_Child.SetItem(1, "rede", "TODAS" )
ldwc_Child.SetItem(1, "vl_parametro", "")

Tab_1.Tabpage_1.dw_1.Object.id_rede_filial [1] = ""
end subroutine

on w_ge063_consulta_filial.create
call super::create
end on

on w_ge063_consulta_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivo_cidade = Create uo_cidade

This.ivl_largura_1 = 4175
This.ivl_largura_2 = 2220
This.ivl_altura_1 = 2170
This.ivl_altura_2 = 2170

This.ivm_menu.ivb_permite_imprimir = True
end event

event close;call super::close;Destroy(ivo_cidade)
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()
end event

event ue_print;//override
Tab_1.Tabpage_1.dw_2.event ue_imprimir_relatorio( "Listagem de Filiais", "CL", False)
end event

event ue_printimmediate;//override
Tab_1.Tabpage_1.dw_2.event ue_imprimir_relatorio( "Listagem de Filiais", "CL", True)
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge063_consulta_filial
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge063_consulta_filial
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge063_consulta_filial
integer width = 4128
integer height = 2224
end type

event tab_1::selectionchanged;call super::selectionchanged;If NewIndex = 1 Then
	Tab_1.tabpage_1.dw_2.ivm_menu.mf_salvarcomo( Tab_1.tabpage_1.dw_2.RowCount() > 0)
End If
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4091
integer height = 2108
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 440
integer width = 4037
integer height = 1636
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 4037
integer height = 412
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 3954
integer height = 316
string dataobject = "dw_ge063_consulta_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case 'nm_cidade' 
		If Data <> ivo_cidade.nm_cidade Then
			If Data <> '' Then
				Return 1
			Else
				ivo_cidade.of_inicializa( )
				This.Object.cd_cidade	[Row] = ivo_cidade.cd_cidade
				This.Object.nm_cidade	[Row] = ivo_cidade.nm_cidade
			End If
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key=KeyEnter! Then
	Choose Case This.GetColumnName()			
		Case 'nm_cidade'
			
			ivo_cidade.Of_inicializa( )
			ivo_cidade.of_localiza_cidade( This.GetText() )
			
			This.Object.cd_cidade	[1] = ivo_cidade.cd_cidade
			This.Object.nm_cidade	[1] = ivo_cidade.nm_cidade	
			
		Case 'de_pesquisa'
			
			Parent.dw_2.Event ue_Retrieve()
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_cidade) Then
	This.Object.nm_cidade [1] = ivo_cidade.nm_cidade
End if
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 512
integer width = 3954
integer height = 1524
string dataobject = "dw_ge063_consulta_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Pesquisa
String lvs_DrugStore
String lvs_Manip
String lvs_Beauty
String lvs_UF
String lvs_Rede
String lvs_Situacao
String lvs_24horas
String lvs_Abre_Domingo
String ls_Utiliza_Regio_Pre

Long lvl_Cidade
Long lvl_Porte
Long lvl_Regiao

Parent.dw_1.Accepttext( )
lvs_Pesquisa			= Parent.dw_1.Object.de_pesquisa					[1]
lvs_DrugStore			= Parent.dw_1.Object.id_drugstore					[1]
lvs_Manip				= Parent.dw_1.Object.id_manipulacao				[1]
lvs_Beauty				= Parent.dw_1.Object.id_beauty_club					[1]
lvs_UF					= Parent.dw_1.Object.cd_uf								[1]
lvs_Rede					= Parent.dw_1.Object.id_rede_filial					[1]
lvs_Situacao				= Parent.dw_1.Object.id_situacao						[1]
lvs_24horas				= Parent.dw_1.Object.id_24horas						[1]
lvl_Cidade				= Parent.dw_1.Object.cd_cidade						[1]
lvl_Porte					= Parent.dw_1.Object.cd_porte						[1]
lvl_Regiao				= Parent.dw_1.Object.cd_regiao						[1]
lvs_Abre_Domingo		= Parent.dw_1.Object.id_abre_domingo				[1]
ls_Utiliza_Regio_Pre	= Parent.dw_1.Object.Id_Utiliza_Regionali_Preco	[1]

If Not IsNull(lvs_Pesquisa) and (Trim(lvs_Pesquisa)<>"") Then
	If IsNumber(Trim(lvs_Pesquisa)) Then
		This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Filial C$$HEX1$$f300$$ENDHEX$$digo: "+Trim(lvs_Pesquisa)
		This.Of_AppendWhere( "((f.cd_filial = "+Trim(lvs_Pesquisa)+")or(isf.cd_chave_sap='"+Trim(lvs_Pesquisa)+"'))")
	Else
		This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Fantasia Cont$$HEX1$$e900$$ENDHEX$$m: "+lvs_Pesquisa
		This.Of_AppendWhere( "f.nm_fantasia like '%"+lvs_Pesquisa+"%'")
	//	This.Of_AppendWhere( "((f.nm_fantasia like '%"+lvs_Pesquisa+"%') or "+&
	//									"(f.de_endereco like '%"+lvs_Pesquisa+"%') or "+&
	//									"(f.de_bairro like '%"+lvs_Pesquisa+"%'))" )
	End If
End If

If lvs_UF<>"" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "UF: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")
	This.Of_AppendWhere( "c.cd_unidade_federacao='"+lvs_UF+"'" )
End If

If Not IsNull(lvl_Cidade) and (lvl_Cidade > 0) Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Cidade: "+ivo_cidade.nm_cidade+" ("+ivo_cidade.cd_unidade_federacao+")"
	This.Of_AppendWhere( "f.cd_cidade=" +String(lvl_Cidade))
End If

If Not IsNull(lvl_Regiao) and (lvl_Regiao > 0) Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Regi$$HEX1$$e300$$ENDHEX$$o: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_regiao)',1)")
	This.Of_AppendWhere( "f.cd_regiao=" +String(lvl_Regiao))
End If

If Not IsNull(lvl_Porte) and (lvl_Porte > 0) Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Porte: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_porte)',1)")
	This.Of_AppendWhere( "f.cd_porte=" +String(lvl_Porte))
End If

If lvs_Rede<>"" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Rede: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_rede_filial)',1)")
	This.Of_AppendWhere( "f.id_rede_filial='"+lvs_Rede+"'" )
End If

If lvs_Situacao<>"T" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Situa$$HEX2$$e700e300$$ENDHEX$$o: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_situacao)',1)")
	This.Of_AppendWhere( "f.id_situacao='"+lvs_Situacao+"'" )
End If

If lvs_DrugStore<>"T" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Drugstore: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_drugstore)',1)")
	This.Of_AppendWhere( "f.id_drugstore='"+lvs_DrugStore+"'" )
End If

If lvs_Abre_Domingo <> "T" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Abre Domingo: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_abre_domingo)',1)")
	This.Of_AppendWhere( "f.id_abre_domingo='"+lvs_Abre_Domingo+"'" )
End If

If lvs_Manip<>"T" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Manipula$$HEX2$$e700e300$$ENDHEX$$o: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_manipulacao)',1)")
	This.Of_AppendWhere( "f.id_manipulacao='"+lvs_Manip+"'" )
End If

If lvs_24horas<>"T" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "24 Horas: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_24horas)',1)")
	This.Of_AppendWhere( "f.id_24horas='"+lvs_24horas+"'" )
End If

If lvs_Beauty<>"T" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Beauty Club: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_beauty_club)',1)")
	This.Of_AppendWhere( "pb.vl_parametro='"+lvs_Beauty+"'" )
End If

If ls_Utiliza_Regio_Pre <> "T" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Utiliza Regionaliza$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_utiliza_regionali_preco)',1)")
	This.of_AppendWhere( " exists (select * from parametro_loja where cd_filial = f.cd_filial and cd_parametro = 'ID_UTILIZA_REGIONALIZACAO_PRECO' and vl_parametro = '" + String(ls_Utiliza_Regio_Pre) + "')")
End If

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_SalvarComo( pl_linhas > 0 )

If pl_linhas = 1 Then
	Tab_1.Selectedtab = 2
	Parent.dw_1.Object.de_pesquisa		[1] = ""
End If

Return AncestorReturnValue
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4091
integer height = 2108
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 2130
integer height = 2020
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 41
integer width = 2098
integer height = 1924
string dataobject = "dw_ge063_consulta_detalhe"
end type

event dw_3::ue_recuperar;//override
Long lvl_Linha
Long lvl_Filial

lvl_Linha = Tab_1.Tabpage_1.dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Filial = Tab_1.Tabpage_1.dw_2.Object.cd_filial [lvl_Linha]
End If

Return This.Retrieve(lvl_Filial)
end event

