HA$PBExportHeader$w_ge475_cons_prod_precificacao.srw
forward
global type w_ge475_cons_prod_precificacao from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge475_cons_prod_precificacao from dc_w_selecao_lista_relatorio
integer width = 4215
integer height = 2036
string title = "GE475 - Consulta Produtos Pricing"
end type
global w_ge475_cons_prod_precificacao w_ge475_cons_prod_precificacao

type variables
uo_grupo_alteracao_preco	ivo_grupo_alteracao_preco  //GE209
uo_ge228_marca_produto	ivo_marca						//GE228
uo_categoria					ivo_categoria					//GE022
uo_subcategoria				ivo_subcategoria				//GE022
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child
Long lvl_Null
SetNull(lvl_Null)

/* Ordena para aparecer primeiro os estados que a empresa tem filial*/
If dw_1.GetChild("cd_uf", ldwc_Child) > 0 Then
	ldwc_Child.SetSort("nr_ordem asc, nm_unidade_federacao asc")
	ldwc_Child.Sort()
End If


/*Grupo*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_grupo" )			

ldwc_Child.SetItem(1, "cd_grupo", "0"	)
ldwc_Child.SetItem(1, "de_grupo", "TODOS")

dw_1.Object.cd_grupo[1] = "0"

/*Subgrupo*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_subgrupo" )			

ldwc_Child.SetItem(1, "cd_subgrupo", "0"	)
ldwc_Child.SetItem(1, "de_subgrupo", "TODOS")
ldwc_Child.SetItem(1, "cd_grupo", "0")
ldwc_Child.Setfilter(" ( cd_grupo = '0' )")
ldwc_Child.Filter()
dw_1.Object.cd_subgrupo[1] = "0"

/* Tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_tributacao_icms" )	
ldwc_Child.SetItem(1, "cd_tributacao_icms", ""	)
ldwc_Child.SetItem(1, "de_tributacao_icms", "TODOS")

/* Tier */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_tier" )	
ldwc_Child.SetItem(1, "cd_tier", 0	)
ldwc_Child.SetItem(1, "de_tier", "N$$HEX1$$c300$$ENDHEX$$O PREENCHIDO")

ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_tier" )	
ldwc_Child.SetItem(1, "cd_tier", lvl_Null	)
ldwc_Child.SetItem(1, "de_tier", "TODOS")

/* Tipo Precifica$$HEX2$$e700e300$$ENDHEX$$o */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_tipo_precificacao" )	
ldwc_Child.SetItem(1, "cd_tipo_precificacao", 999	)
ldwc_Child.SetItem(1, "de_tipo_precificacao", "N$$HEX1$$c300$$ENDHEX$$O PREENCHIDO")

ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_tipo_precificacao" )	
ldwc_Child.SetItem(1, "cd_tipo_precificacao", lvl_Null	)
ldwc_Child.SetItem(1, "de_tipo_precificacao", "TODOS")

/* Papel/Classifica$$HEX2$$e700e300$$ENDHEX$$o */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_classificacao" )	
ldwc_Child.SetItem(1, "cd_classificacao", 0	)
ldwc_Child.SetItem(1, "de_classificacao", "N$$HEX1$$c300$$ENDHEX$$O PREENCHIDA")

ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_classificacao" )	
ldwc_Child.SetItem(1, "cd_classificacao", lvl_Null	)
ldwc_Child.SetItem(1, "de_classificacao", "TODOS")

/*Lei Gen$$HEX1$$e900$$ENDHEX$$rico*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			

ldwc_Child.SetItem(1, "id_lei_generico", ""	)
ldwc_Child.SetItem(1, "de_lei_generico", "TODOS")

/*Lista Pis/Cofins*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lista_pis_cofins" )			

ldwc_Child.SetItem(1, "id_lista_pis_cofins", ""	)
ldwc_Child.SetItem(1, "de_lista_pis_cofins", "TODOS")

/*Tipo Apresenta$$HEX2$$e700e300$$ENDHEX$$o*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_apresentacao" )			
ldwc_Child.SetItem(1, "id_apresentacao", "00"	)
ldwc_Child.SetItem(1, "de_apresentacao", "N$$HEX1$$c300$$ENDHEX$$O PREENCHIDA")

ldwc_Child  = dw_1.of_InsertRow_DDDW("id_apresentacao" )			
ldwc_Child.SetItem(1, "id_apresentacao", ""	)
ldwc_Child.SetItem(1, "de_apresentacao", "TODOS")
dw_1.Object.id_apresentacao [1] = ""
end subroutine

on w_ge475_cons_prod_precificacao.create
call super::create
end on

on w_ge475_cons_prod_precificacao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;MaxWidth = 11100
Maxheight = 9999

ivo_grupo_alteracao_preco	= Create uo_grupo_alteracao_preco
ivo_marca						= Create uo_ge228_marca_produto
ivo_categoria					= Create uo_categoria
ivo_subcategoria				= Create uo_subcategoria
end event

event ue_saveas;call super::ue_saveas;dw_2.Event ue_SaveAs()
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()

dw_1.SetRedraw( True )
end event

event close;call super::close;Destroy( ivo_grupo_alteracao_preco )
Destroy( ivo_subcategoria )
Destroy( ivo_categoria )
Destroy( ivo_marca )
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge475_cons_prod_precificacao
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge475_cons_prod_precificacao
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge475_cons_prod_precificacao
integer y = 764
integer width = 4114
integer height = 1064
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge475_cons_prod_precificacao
integer width = 4114
integer height = 732
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge475_cons_prod_precificacao
integer x = 59
integer width = 4073
integer height = 656
string dataobject = "dw_ge475_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;DataWindowChild ldw_Child

String lvs_Texto

Choose Case Dwo.Name
	Case 'cd_grupo' 
		If Data <> '1' Then This.Object.id_lei_generico [Row] = ''
	
		If This.GetChild("cd_subgrupo", ldw_Child) = 1 Then
			ldw_Child.SetFilter("( cd_grupo = '0' or  cd_grupo = '"+Data+"')")
			ldw_Child.Filter()
			This.Object.cd_subgrupo [Row] = '0'
			
			ivo_categoria.of_inicializa( )
			ivo_subcategoria.of_inicializa( )
			This.Object.cd_categoria		[Row] = ivo_categoria.cd_categoria
			This.Object.de_categoria		[Row] = ivo_categoria.de_categoria
			This.Object.cd_subcategoria[Row] = ivo_subcategoria.cd_subcategoria
			This.Object.de_subcategoria[Row] = ivo_subcategoria.de_subcategoria
		End If
		
	Case 'cd_subgrupo' 	
		ivo_categoria.of_inicializa( )
		ivo_subcategoria.of_inicializa( )
		This.Object.cd_categoria		[Row] = ivo_categoria.cd_categoria
		This.Object.de_categoria		[Row] = ivo_categoria.de_categoria
		This.Object.cd_subcategoria[Row] = ivo_subcategoria.cd_subcategoria
		This.Object.de_subcategoria[Row] = ivo_subcategoria.de_subcategoria
		
	Case 'cd_tributacao_icms'
		This.Accepttext( )
		lvs_Texto =  This.Describe("Evaluate('LookUpDisplay(cd_tributacao_icms)',1)")
		This.Object.cd_tributacao_icms.ToolTip.Tip = lvs_Texto
		This.Object.cd_tributacao_icms.ToolTip.Enabled =  (Len(lvs_Texto) > 30)
		
	Case 'de_grupo_pricing' 
		If Data <> ivo_grupo_alteracao_preco.de_grupo Then
			If Data <> '' Then
				Return 1
			Else
				ivo_grupo_alteracao_preco.of_inicializa( )
				This.Object.cd_grupo_pricing	[Row] = ivo_grupo_alteracao_preco.cd_grupo
				This.Object.de_grupo_pricing	[Row] = ivo_grupo_alteracao_preco.de_grupo
			End If
		End If
	
	Case 'de_marca'
		If Data <> ivo_marca.de_marca Then
			If Data <> '' Then
				Return 1
			Else
				ivo_marca.of_inicializa( )
				This.Object.cd_marca	[Row] = ivo_marca.cd_marca
				This.Object.de_marca[Row] = ivo_marca.de_marca
			End If
		End If
		
	Case 'de_categoria'
		If Data <> ivo_categoria.de_categoria Then
			If Data <> '' Then
				Return 1
			Else
				ivo_categoria.of_inicializa( )
				ivo_subcategoria.of_inicializa( )
				This.Object.cd_categoria		[Row] = ivo_categoria.cd_categoria
				This.Object.de_categoria		[Row] = ivo_categoria.de_categoria
				This.Object.cd_subcategoria[Row] = ivo_subcategoria.cd_subcategoria
				This.Object.de_subcategoria[Row] = ivo_subcategoria.de_subcategoria
			End If
		End If
		
	Case 'de_subcategoria'
		If Data <> ivo_subcategoria.de_subcategoria Then
			If Data <> '' Then
				Return 1
			Else
				ivo_subcategoria.of_inicializa( )
				This.Object.cd_subcategoria[Row] = ivo_subcategoria.cd_subcategoria
				This.Object.de_subcategoria[Row] = ivo_subcategoria.de_subcategoria
			End If
		End If

End Choose

dw_2.Reset()
end event

event dw_1::ue_key;call super::ue_key;String lvs_Grupo
String lvs_Subgrupo
String lvs_Categoria

If Key=KeyEnter! Then
	Choose Case This.GetColumnName()
		Case 'de_grupo_pricing'
			ivo_grupo_alteracao_preco.of_localiza_grupo( This.GetText() )
			
			This.Object.cd_grupo_pricing	[1] = ivo_grupo_alteracao_preco.cd_grupo
			This.Object.de_grupo_pricing	[1] = ivo_grupo_alteracao_preco.de_grupo	
			
		Case 'de_marca'			
			ivo_marca.Of_inicializa( )
			ivo_marca.of_localiza_marca( This.GetText() )
			
			This.Object.cd_marca	[1] = ivo_marca.cd_marca
			This.Object.de_marca[1] = ivo_marca.de_marca				
			
		Case 'de_categoria'
			lvs_Grupo 		= This.Object.cd_grupo		[1]
			lvs_Subgrupo	= This.Object.cd_subgrupo	[1]
			ivo_categoria.Of_inicializa( )
			ivo_categoria.of_localiza( This.GetText() , lvs_Grupo, lvs_Subgrupo)
			
			This.Object.cd_categoria	[1] = ivo_categoria.cd_categoria
			This.Object.de_categoria[1] = ivo_categoria.de_categoria	
			
		Case 'de_subcategoria'
			lvs_Grupo 		= This.Object.cd_grupo		[1]
			lvs_Subgrupo	= This.Object.cd_subgrupo	[1]
			lvs_Categoria	= This.Object.cd_categoria 	[1]
			ivo_subcategoria.Of_inicializa( )
			ivo_subcategoria.of_localiza( This.GetText(), lvs_Grupo, lvs_Subgrupo, lvs_Categoria)
			
			This.Object.cd_subcategoria	[1] = ivo_subcategoria.cd_subcategoria
			This.Object.de_subcategoria	[1] = ivo_subcategoria.de_subcategoria
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_grupo_alteracao_preco) Then
	This.Object.de_grupo_pricing [1] = ivo_grupo_alteracao_preco.de_grupo
End if

If IsValid(ivo_marca) Then
	This.Object.de_marca [1] = ivo_marca.de_marca
End If

If IsValid(ivo_categoria) Then
	This.Object.de_categoria [1] = ivo_categoria.de_categoria
End If

If IsValid(ivo_subcategoria) Then
	This.Object.de_subcategoria [1] = ivo_subcategoria.de_subcategoria
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge475_cons_prod_precificacao
integer y = 840
integer width = 4046
integer height = 972
string dataobject = "dw_ge475_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_UF
String lvs_Lista
String lvs_Grupo
String lvs_SubGrupo
String lvs_Categoria
String lvs_Subcategoria
String lvs_Lei_G
String lvs_Trib
String lvs_Situacao
String lvs_ABC
String lvs_FPB
String lvs_Sem_PMC
String lvs_Gratis_FPB
String lvs_UN_Calc_Preco
String lvs_Sem_UN
String lvs_Sem_Marca
String lvs_Sem_Concentracao
String lvs_Preco_Forn
String lvs_Calc_Bloq
String lvs_Apresentacao

Long lvl_NCM_Ini
Long lvl_NCM_Fin
Long lvl_Marca
Long lvl_Grupo_Pricing
Long lvl_Tier
Long lvl_Classif
Long lvl_Tipo_Precif

dw_1.AcceptText()

lvs_UF 						= dw_1.Object.Cd_UF					[1]
lvl_NCM_Ini					= dw_1.Object.nr_ncm_inicio			[1]
lvl_NCM_Fin					= dw_1.Object.nr_ncm_fim				[1]
lvs_Lista						= dw_1.Object.id_lista_pis_cofins		[1]
lvs_Grupo					= dw_1.Object.cd_grupo					[1]
lvs_SubGrupo				= dw_1.Object.cd_subgrupo			[1]
lvs_Lei_G						= dw_1.Object.id_lei_generico			[1]
lvs_Situacao					= dw_1.Object.id_situacao				[1]
lvs_Trib						= dw_1.Object.cd_tributacao_icms	[1]
lvs_ABC						= dw_1.Object.id_abcfarma				[1]
lvs_FPB						= dw_1.Object.id_fpb						[1]
lvs_Sem_PMC				= dw_1.Object.id_sem_pmc				[1]
lvs_Gratis_FPB				= dw_1.Object.id_gratis_fpb			[1]
lvl_Marca					= dw_1.Object.cd_marca				[1]
lvl_Grupo_Pricing			= dw_1.Object.cd_grupo_pricing		[1]
lvs_Categoria				= dw_1.Object.cd_categoria			[1]
lvs_Subcategoria			= dw_1.Object.cd_subcategoria		[1]
lvl_Tier						= dw_1.Object.cd_tier					[1]

lvl_Classif					= dw_1.Object.cd_classificacao		[1]
lvs_UN_Calc_Preco		= dw_1.Object.id_unid_calc_preco	[1]
lvs_Sem_UN					= dw_1.Object.id_sem_un_venda		[1]
lvs_Sem_Marca			= dw_1.Object.id_sem_marca			[1]
lvs_Preco_Forn				= dw_1.Object.id_preco_forn			[1]
lvl_Tipo_Precif				= dw_1.Object.cd_tipo_precificacao	[1]
lvs_Calc_Bloq				= dw_1.Object.id_calc_preco_bloq	[1]
lvs_Apresentacao			= dw_1.Object.id_apresentacao		[1]
lvs_Sem_Concentracao	= dw_1.Object.id_sem_concentracao	[1]

If lvs_UF = "" or IsNull(lvs_UF) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Deve ser informado a UF para recupera$$HEX2$$e700e300$$ENDHEX$$o dos dados.", Exclamation!)
	Return -1
End If

If lvs_Apresentacao <> "" Then
	This.of_AppendWhere("coalesce(g.id_apresentacao,'00') = '"+lvs_Apresentacao+"'")
End If

If lvs_Situacao <> 'T' Then
	This.of_AppendWhere("g.id_situacao = '"+lvs_Situacao+"'")
End If

If lvs_ABC <> 'T' Then
	This.of_AppendWhere("coalesce(g.id_caderno_abcfarma,'N') = '"+lvs_ABC+"'")
End If

If lvs_FPB <> 'T' Then
	This.of_AppendWhere("coalesce(g.id_farmacia_popular,'N') = '"+lvs_FPB+"'")
End If

If lvs_Sem_PMC = 'S' Then
	This.of_AppendWhere("coalesce(u.vl_preco_venda_maximo,0.00)=0.00")
End If

If lvs_Sem_Concentracao = "S" Then
	This.of_AppendWhere("coalesce(g.qt_concentracao,0.00)=0.00")
End If

If lvs_Lista <> '' Then
	This.of_AppendWhere("g.id_situacao_pis_cofins = '"+lvs_Lista+"'")
End If

If lvs_Lei_G <> '' Then
	This.of_AppendWhere("g.id_lei_generico = '"+lvs_Lei_G+"'")
End If

If lvs_Trib <> '' Then
	This.of_AppendWhere("u.cd_tributacao_icms = '"+lvs_Trib+"'")
End If

If Not IsNull(lvl_NCM_Ini) Then
	This.of_AppendWhere("g.nr_classificacao_fiscal >= "+String(lvl_NCM_Ini))
End If

If ((Not IsNull(lvl_NCM_Fin)) and (lvl_NCM_Fin < 99999999)) Then
	This.of_AppendWhere("g.nr_classificacao_fiscal <= "+String(lvl_NCM_Fin))
End If

If lvs_SubCategoria<>'0' Then
	This.of_AppendWhere("g.cd_subcategoria='"+lvs_Subcategoria+"'")
ElseIf lvs_Categoria<>'0' Then
	This.of_AppendWhere("scp.cd_categoria='"+lvs_Categoria+"'")
ElseIf lvs_SubGrupo<>'0' Then
	This.of_AppendWhere("cp.cd_subgrupo='"+lvs_SubGrupo+"'")
ElseIf lvs_Grupo<>'0' Then
	This.of_AppendWhere("sgp.cd_grupo='"+lvs_Grupo+"'")
End If

If ((Not IsNull(lvl_Marca)) and (lvl_Marca > 0)) Then
	This.of_AppendWhere("g.cd_marca = "+String(lvl_Marca))
End If

If ((Not IsNull(lvl_Grupo_Pricing)) and (lvl_Grupo_Pricing > 0)) Then
	This.of_AppendWhere("pc.cd_grupo_alteracao_preco = "+String(lvl_Grupo_Pricing))
End If

If (Not IsNull(lvl_Tier)) Then
	If lvl_Tier = 0 Then
		This.of_AppendWhere("((srf1.cd_tier is null) or (srf2.cd_tier is null))")
	Else
		This.of_AppendWhere("((coalesce(srf1.cd_tier,0) = "+String(lvl_Tier)+") or (coalesce(srf2.cd_tier,0) = "+String(lvl_Tier)+"))")
	End If
End If

If (Not IsNull(lvl_Classif)) Then
	If lvl_Classif = 0 Then
		This.of_AppendWhere("((srf1.cd_classificacao is null) or (srf2.cd_classificacao is null))")
	Else
		This.of_AppendWhere("((coalesce(srf1.cd_classificacao,0) = "+String(lvl_Classif)+") or (coalesce(srf2.cd_classificacao,0) = "+String(lvl_Classif)+"))")
	End If
End If

If lvs_Sem_UN = 'S' Then
	This.of_AppendWhere("coalesce(g.cd_unidade_medida_venda,'') <> ''")
End If

If lvs_UN_Calc_Preco <> 'T' Then
	If lvs_UN_Calc_Preco = 'N' Then
		This.of_AppendWhere("coalesce(pc.id_tipo_un_calc_preco,'')=''")
	Else
		This.of_AppendWhere("coalesce(pc.id_tipo_un_calc_preco,'')='"+lvs_UN_Calc_Preco+"'")
	End If
End If

If lvs_Sem_Marca = 'S' Then
	This.of_AppendWhere("g.cd_marca is null")
End If

If lvs_Calc_Bloq = "S" Then
	This.of_AppendWhere("pc.id_bloqueia_calculo_preco='S'")
End If

Choose Case lvs_Preco_Forn
	Case 'S'
		This.of_AppendWhere("coalesce(u.vl_preco_venda_fornecedor,0) = 0.00")
	Case 'C'
		This.of_AppendWhere("coalesce(u.vl_preco_venda_fornecedor,0) > 0.00")
End Choose

If Not IsNull(lvl_Tipo_Precif) Then
	If lvl_Tipo_Precif = 999 Then
		This.of_AppendWhere("scp.cd_tipo_precificacao is null")
	Else
		This.of_AppendWhere("scp.cd_tipo_precificacao = "+String(lvl_Tipo_Precif))
	End If
End If

Return 1
end event

event dw_2::ue_recuperar;// OverRide

String lvs_UF

dw_1.AcceptText()

lvs_UF = dw_1.Object.Cd_UF[1]

Return This.Retrieve(lvs_UF)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)

Return pl_Linhas
end event

event dw_2::getfocus;call super::getfocus;If This.RowCount() > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
End If
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

event dw_2::doubleclicked;call super::doubleclicked;//Long lvl_Prod
//Long lvl_Linha
//
//If gvo_aplicacao.ivo_seguranca.of_acesso_procedimento('W_GP004_CADASTRO_PRODUTO') Then
//	lvl_Linha = This.GetRow()
//	If lvl_Linha > 0 Then
//		lvl_Prod = This.Object.cd_produto [lvl_Linha]
//		OpenSheetWithParm(w_gp004_cadastro_produto,String(lvl_Prod),dc_w_mdi)
//	End If
//End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge475_cons_prod_precificacao
integer x = 4119
integer y = 36
integer width = 233
integer height = 240
end type

