HA$PBExportHeader$w_ge386_consulta_cliente.srw
forward
global type w_ge386_consulta_cliente from dc_w_2tab_consulta_selecao_lista_det
end type
end forward

global type w_ge386_consulta_cliente from dc_w_2tab_consulta_selecao_lista_det
integer width = 4192
integer height = 2408
string title = "GE386 - Consulta Cliente"
end type
global w_ge386_consulta_cliente w_ge386_consulta_cliente

type variables
Private:
uo_cidade ivo_cidade  //GE008

Boolean ivb_Alterando_Aba = False

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
end subroutine

on w_ge386_consulta_cliente.create
call super::create
end on

on w_ge386_consulta_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivo_cidade = Create uo_cidade

This.ivl_largura_1	= 4130
This.ivl_largura_2	= 3420
This.ivl_Altura_1	= 3200
This.ivl_Altura_2	= 1450

This.ivm_menu.ivb_permite_imprimir = True
end event

event resize;call super::resize;If (Tab_1.SelectedTab = 1) and (not ivb_Alterando_Aba) Then
	Tab_1.Height = Newheight - 20
	This.ivl_Altura_1	= NewHeight
End If

Tab_1.Tabpage_1.gb_2.Height	= Tab_1.Height - Tab_1.Tabpage_1.gb_1.height - 170
Tab_1.Tabpage_1.dw_2.Height	= Tab_1.tabpage_1.gb_2.Height - 100
end event

event close;call super::close;Destroy(ivo_cidade)
end event

event ue_print;//override
Tab_1.Tabpage_1.dw_2.event ue_imprimir_relatorio( "Listagem Clientes", "CL", False)
end event

event ue_printimmediate;//override
Tab_1.Tabpage_1.dw_2.event ue_imprimir_relatorio( "Listagem Clientes", "CL", True)
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()


end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge386_consulta_cliente
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge386_consulta_cliente
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge386_consulta_cliente
integer width = 4128
integer height = 2204
end type

event tab_1::selectionchanged;call super::selectionchanged;If NewIndex = 2 Then
	Tab_1.Tabpage_1.dw_2.ivm_menu.mf_salvarcomo( Tab_1.Tabpage_1.dw_2.RowCount() > 0)
End If

ivb_Alterando_Aba = False
end event

event tab_1::selectionchanging;//override
ivb_Alterando_Aba = True

Return Super::Event SelectionChanging( OldIndex, NewIndex)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4091
integer height = 2088
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 292
integer width = 4037
integer height = 1776
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 4041
integer height = 264
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 3986
integer height = 176
string dataobject = "dw_ge386_selecao"
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

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_cidade) Then
	This.Object.nm_cidade [1] = ivo_cidade.nm_cidade
End if
end event

event dw_1::ue_key;call super::ue_key;If Key=KeyEnter! Then
	Choose Case This.GetColumnName()			
		Case 'nm_cidade'
			
			ivo_cidade.Of_inicializa( )
			ivo_cidade.of_localiza_cidade( This.GetText() )
			
			This.Object.cd_cidade	[1] = ivo_cidade.cd_cidade
			This.Object.nm_cidade	[1] = ivo_cidade.nm_cidade	
	End Choose
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 364
integer width = 3982
integer height = 1664
string dataobject = "dw_ge386_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Pesquisa
String lvs_Uf
String lvs_Tipo
String lvs_CPF
String lvs_CNPJ
String lvs_Natureza
String lvs_Sexo

Long lvl_Cidade

Boolean lvb_OK = False

Parent.dw_1.AcceptText( )
lvs_Pesquisa	= Parent.dw_1.Object.de_pesquisa		[1]
lvs_Uf 			= Parent.dw_1.Object.cd_uf					[1]
lvl_Cidade 		= Parent.dw_1.Object.cd_cidade			[1]
lvs_Tipo 			= Parent.dw_1.Object.id_tipo_cliente		[1]
lvs_CPF 			= Parent.dw_1.Object.nr_cpf				[1]
lvs_CNPJ 		= Parent.dw_1.Object.nr_cnpj				[1]
lvs_Natureza 	= Parent.dw_1.Object.id_fisica_juridica	[1]
lvs_Sexo 		= Parent.dw_1.Object.id_sexo				[1]

If Not IsNull(lvs_Pesquisa) and (Trim(lvs_Pesquisa)<>"") Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Cliente Cont$$HEX1$$e900$$ENDHEX$$m: "+lvs_Pesquisa
	This.Of_AppendWhere( "c.nm_cliente like '"+lvs_Pesquisa+"%'")
	lvb_OK = (Len(Trim(lvs_Pesquisa)) > 3)
End If

If Not IsNull(lvs_Uf) and (Trim(lvs_Uf)<>"") Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "UF: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")
	This.Of_AppendWhere( "ci.cd_unidade_federacao='" +lvs_Uf+"'")
End If

If Not IsNull(lvl_Cidade) and (lvl_Cidade > 0) Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Cidade: "+ivo_cidade.nm_cidade+" ("+ivo_cidade.cd_unidade_federacao+")"
	This.Of_AppendWhere( "c.cd_cidade=" +String(lvl_Cidade))
	lvb_OK = True
End If

If Not IsNull(lvs_Tipo) and (lvs_Tipo <> "") Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Tipo Cliente: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_cliente)',1)")
	This.Of_AppendWhere( "c.id_tipo_cliente='" +lvs_Tipo+"'")
End If

If Not IsNull(lvs_CPF) and (lvs_CPF <> "") Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "CPF: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(nr_cpf)',1)")
	This.Of_AppendWhere( "c.nr_cpf_cgc='" +lvs_CPF+"'")
	lvb_OK = True
ElseIf Not IsNull(lvs_CNPJ) and (lvs_CNPJ <> "") Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "CNPJ: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(nr_cnpj)',1)")
	This.Of_AppendWhere( "c.nr_cpf_cgc='" +lvs_CNPJ+"'")
	lvb_OK = True
End If

If Not IsNull(lvs_Natureza) and (lvs_Natureza <> "") Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Natureza: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_fisica_juridica)',1)")
	This.Of_AppendWhere( "c.id_fisica_juridica='" +lvs_Natureza+"'")
	
	If lvs_Natureza = 'J' Then lvb_OK = True
End If

If Not IsNull(lvs_Sexo) and (lvs_Sexo <> "") Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Sexo: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_sexo)',1)")
	This.Of_AppendWhere( "c.id_sexo='" +lvs_Sexo+"'")
End If

If Not lvb_OK Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Foram informados poucos filtros para a pesquisa.~r"+ &
						"Se essa consulta for executada poder$$HEX1$$e100$$ENDHEX$$ demorar v$$HEX1$$e100$$ENDHEX$$rios minutos.~r~r"+ &
						"Deseja continuar assim mesmo?", Exclamation!, YesNo!, 2) = 2 Then
		Return -1
	End If
End If

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_salvarcomo( pl_linhas > 0 )
This.ivo_controle_menu.of_salvarcomo( pl_linhas > 0 )

Return AncestorReturnValue
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4091
integer height = 2088
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3346
integer height = 1312
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3264
integer height = 1216
string dataobject = "dw_ge386_detalhe"
end type

event dw_3::ue_recuperar;//override
String lvs_Cliente
Long lvl_Linha

Tab_1.Tabpage_1.dw_2.Accepttext( )
lvl_Linha = Tab_1.Tabpage_1.dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Cliente = Tab_1.Tabpage_1.dw_2.Object.cd_cliente [lvl_Linha]
End If

Return This.Retrieve( lvs_Cliente ) 
end event

