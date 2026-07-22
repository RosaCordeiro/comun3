HA$PBExportHeader$w_ge441_rel_dinamico_devcp_item.srw
forward
global type w_ge441_rel_dinamico_devcp_item from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge441_rel_dinamico_devcp_item from dc_w_selecao_lista_dinamica_relatorio
integer width = 4142
integer height = 2036
string title = "GE441 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compras EC (Por Item Nota)"
end type
global w_ge441_rel_dinamico_devcp_item w_ge441_rel_dinamico_devcp_item

type variables
uo_fornecedor ivo_fornecedor
uo_filial ivo_filial
uo_natureza_operacao ivo_cfop
uo_produto ivo_produto

end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*Grupo Produto*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_grupo" )			

ldwc_Child.SetItem(1, "cd_grupo", "TD")
ldwc_Child.SetItem(1, "de_grupo", "TODOS")

dw_1.Object.cd_grupo[1] = "TD"

/*Lei Gen$$HEX1$$e900$$ENDHEX$$rico*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			

ldwc_Child.SetItem(1, "id_lei_generico", "TD")
ldwc_Child.SetItem(1, "de_lei_generico", "TODAS")

dw_1.Object.id_lei_generico[1] = "TD"

/*UF Filial*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

dw_1.Object.cd_uf[1] = "TD"

/*UF Fornecedor*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf_forn" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

dw_1.Object.cd_uf_forn[1] = "TD"
end subroutine

on w_ge441_rel_dinamico_devcp_item.create
call super::create
end on

on w_ge441_rel_dinamico_devcp_item.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_fornecedor = Create uo_fornecedor
ivo_filial			= Create uo_filial
ivo_cfop			= Create uo_natureza_operacao
ivo_produto		= Create uo_produto

//Dimensionamento de tela
MaxWidth = 4600
MaxHeight = 9999

//SQL Base para formar o grid
ivs_SQLBase = " from nf_devolucao_compra n " 						+ &
					" inner join nf_devolucao_compra_produto i (index pk_nf_devolucao_compra_produto) " + &
						" on i.cd_filial = n.cd_filial " 							+ &
						" and i.nr_nf = n.nr_nf " 								+ &
						" and i.de_serie = n.de_serie " 					+ & 
						" and i.de_especie = n.de_especie " 				+ &
					" inner join nf_devolucao_compra_prd_ent ie (index pk_nf_devolucao_compra_prd_ent) " + &
						" on ie.cd_filial = i.cd_filial " 						+ &
						" and ie.nr_nf = i.nr_nf " 							+ &
						" and ie.de_serie = i.de_serie " 					+ & 
						" and ie.de_especie = i.de_especie " 				+ &
						" and ie.nr_item = i.nr_item " 						+ &
					" inner join item_nf_compra ic (index pk_item_nf_compra) " + &
						" on ic.cd_filial = ie.cd_filial " 						+ &
						" and ic.cd_fornecedor = ie.cd_fornecedor " 	+ &
						" and ic.nr_nf = ie.nr_nf_compra " 				+ &
						" and ic.de_serie = ie.de_serie_compra " 		+ &
						" and ic.de_especie = ie.de_especie_compra " + &
						" and ic.cd_produto = i.cd_produto " 				+ &
					" inner join fornecedor fo (index pk_fornecedor) " + &
						" on fo.cd_fornecedor = n.cd_fornecedor " 		+ &
					" inner join cidade cfo (index pk_cidade) " 			+ &
						" on cfo.cd_cidade = fo.cd_cidade " 				+ &
					" inner join filial fi (index pk_filial) " 					+ &
						" on fi.cd_filial = n.cd_filial " 						+ &
					" inner join cidade cfi (index pk_cidade) " 			+ &
						" on cfi.cd_cidade = fi.cd_cidade " 				+ &
					" inner join produto_geral pg (index pk_produto_geral) " + &
						" on pg.cd_produto = i.cd_produto " 				+ &
					" inner join subcategoria scp "							+ &
						" on scp.cd_subcategoria = pg.cd_subcategoria||'' " + &
					" Inner Join categoria cp 	" 								+ &
						" on cp.cd_categoria = scp.cd_categoria " 		+ &
					" Inner Join subgrupo sgp " 								+ &
						" on sgp.cd_subgrupo = cp.cd_subgrupo " 		+ &
					" Inner Join grupo gp " 									+ &
						" on gp.cd_grupo = sgp.cd_grupo " 				+ & 
					" inner join nf_devolucao_compra_nfe ne (index pk_nf_devolucao_compra_nfe) " + &
						" on ne.cd_filial = n.cd_filial "						+ &
						" and ne.nr_nf = n.nr_nf "							+ &
						" and ne.de_serie = n.de_serie "					+ &
						" and ne.de_especie = n.de_especie "			+ &
					" inner join nf_compra nc (index pk_nf_compra) "	+ &
						" on nc.cd_filial = ie.cd_filial " 						+ &
						" and nc.cd_fornecedor = ie.cd_fornecedor " 	+ &
						" and nc.nr_nf = ie.nr_nf_compra " 				+ &
						" and nc.de_serie = ie.de_serie_compra "		+ &
						" and nc.de_especie = ie.de_especie_compra "
		

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 20
end event

event close;call super::close;Destroy(ivo_fornecedor)
Destroy(ivo_filial)
Destroy(ivo_cfop)
Destroy(ivo_produto)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)

wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge441_rel_dinamico_devcp_item
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge441_rel_dinamico_devcp_item
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge441_rel_dinamico_devcp_item
integer y = 544
integer width = 4041
integer height = 1288
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge441_rel_dinamico_devcp_item
integer width = 4041
integer height = 516
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge441_rel_dinamico_devcp_item
integer width = 3973
integer height = 400
string dataobject = "dw_ge441_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	This.AcceptText( )
	
	Choose Case This.GetColumnName() 
			
		Case "nm_filial"
			ivo_filial.Of_Localiza_Filial(This.GetText()) 
			
			If ivo_filial.Localizada Then
				  
				This.Object.cd_filial	[1] = ivo_filial.cd_filial
				This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
				
			End If
			
		Case "nm_cfop"
			ivo_cfop.of_localiza_natureza(This.GetText())
			
			If ivo_cfop.Localizado Then
				  
				This.Object.cd_cfop	[1] = ivo_cfop.cd_natureza_operacao
				This.Object.nm_cfop	[1] = ivo_cfop.de_natureza_operacao
				
			End If
			
		Case "de_produto"
			ivo_produto.of_localiza_produto(This.GetText())
			
			If ivo_produto.Localizado Then
				  
				This.Object.cd_produto	[1] = ivo_produto.cd_produto
				This.Object.de_produto	[1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
				
			End If
			
		Case "nm_fornecedor"
			ivo_fornecedor.of_localiza_fornecedor(This.GetText())
			
			If ivo_fornecedor.Localizado Then
				  
				This.Object.cd_fornecedor	[1] = ivo_fornecedor.cd_fornecedor
				This.Object.nm_fornecedor	[1] = ivo_fornecedor.nm_razao_social
				
			End If

	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
		
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_Inicializa()
			
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			
		End If	
		
	Case "nm_cfop"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cfop.de_natureza_operacao Then
				Return 1
			End If	
		Else			
			ivo_cfop.Of_Inicializa()
			
			This.Object.nm_cfop	[1] = ivo_cfop.de_natureza_operacao
			This.Object.cd_cfop	[1] = ivo_cfop.cd_natureza_operacao
			
		End If	
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_razao_social Then
				Return 1
			End If	
		Else			
			ivo_fornecedor.Of_Inicializa()
			
			This.Object.nm_fornecedor	[1] = ivo_fornecedor.nm_razao_social
			This.Object.cd_fornecedor	[1] = ivo_fornecedor.cd_fornecedor
			
		End If	
		
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> (ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque) Then
				Return 1
			End If	
		Else			
			ivo_produto.Of_Inicializa()
			
			This.Object.de_produto	[1] = ivo_produto.de_produto
			This.Object.cd_produto	[1] = ivo_produto.cd_produto
			
		End If	
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_produto) Then 
	If ivo_produto.Localizado Then	This.Object.de_produto [1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
End If

If IsValid(ivo_cfop) Then 
	This.Object.nm_cfop [1] = ivo_cfop.de_natureza_operacao
End If

If IsValid(ivo_fornecedor) Then 
	This.Object.nm_fornecedor [1] = ivo_fornecedor.nm_razao_social
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge441_rel_dinamico_devcp_item
integer y = 620
integer width = 3973
integer height = 1180
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio Devolu$$HEX2$$e700f500$$ENDHEX$$es de Compra"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Grupo
String lvs_UF_Forn
String lvs_UF_Fil
String lvs_Fornecedor
String lvs_Lei_Gen
String lvs_Lista_Pis
String lvs_NCM_Ini
String lvs_NCM_Fim
String lvs_ST_Destac
String lvs_ST_Calc
String lvs_ST_Obs
String lvs_ST_Ret
String lvs_Situacao

Long lvl_NCM_Ini
Long lvl_NCM_Fim
Long lvl_CFOP
Long lvl_Filial
Long lvl_Produto

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio		= dw_1.Object.dt_inicio					[1]
lvdt_Fim			= dw_1.Object.dt_fim						[1]
lvl_Filial			= dw_1.Object.cd_filial					[1]
lvs_UF_Fil		= dw_1.Object.cd_uf						[1]
lvl_Produto		= dw_1.Object.cd_produto				[1]
lvs_Fornecedor	= dw_1.Object.cd_fornecedor			[1]
lvs_UF_Forn		= dw_1.Object.cd_uf_forn				[1]
lvl_CFOP			= dw_1.Object.cd_cfop					[1]
lvs_Grupo		= dw_1.Object.cd_grupo					[1]
lvl_NCM_Ini		= dw_1.Object.nr_ncm_ini				[1]
lvl_NCM_Fim	= dw_1.Object.nr_ncm_fim				[1]
lvs_Lista_Pis		= dw_1.Object.id_lista_pis_cofins		[1]
lvs_Lei_Gen		= dw_1.Object.id_lei_generico			[1]
lvs_ST_Calc		= dw_1.Object.id_st_retido_ent		[1]
lvs_ST_Destac	= dw_1.Object.id_icms_st				[1]
lvs_ST_Ret		= dw_1.Object.id_icms_st_retido		[1]
lvs_ST_Obs		= dw_1.Object.id_icms_st_nao_dest	[1]
lvs_Situacao		= dw_1.Object.id_situacao				[1]

If IsNull(lvdt_Inicio) or (lvdt_Inicio < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data inicial para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_inicio')
	Return -1
Else
	This.Of_AppendWhere("n.dh_movimentacao_caixa>='"+String(lvdt_Inicio,'YYYY/MM/DD')+"'")
End If

If IsNull(lvdt_Fim) or (lvdt_Fim < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data final para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_fim')
	Return -1
Else
	This.Of_AppendWhere("n.dh_movimentacao_caixa<='"+String(lvdt_Fim,'YYYY/MM/DD')+"'")
End If

ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim,'DD/MM/YYYY')

If Not IsNull(lvl_Produto) and (lvl_Produto > 0) Then
	This.Of_AppendWhere("i.cd_produto="+String(lvl_Produto))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Produto: '+ivo_produto.de_produto+' ('+String(lvl_Produto)+')'
End If

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	This.Of_AppendWhere("n.cd_filial="+String(lvl_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_filial.nm_fantasia+' ('+String(lvl_Filial)+')'
End If

If lvs_UF_Fil<>'TD' Then
	This.Of_AppendWhere("cfi.cd_unidade_federacao='"+lvs_UF_Fil+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF Origem: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+lvs_UF_Fil+')'
End If

If Not IsNull(lvs_Fornecedor) and (Trim(lvs_Fornecedor)<>'') Then
	This.Of_AppendWhere("n.cd_fornecedor='"+lvs_Fornecedor+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Fornecedor: '+ivo_fornecedor.nm_razao_social+' ('+ivo_fornecedor.cd_fornecedor+')'
End If

If lvs_UF_Forn<>'TD' Then
	This.Of_AppendWhere("cfo.cd_unidade_federacao='"+lvs_UF_Forn+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF Destino: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf_forn)',1)")+' ('+lvs_UF_Forn+')'
End If

If Not IsNull(lvl_CFOP) and (lvl_CFOP > 0) Then
	This.Of_AppendWhere("i.cd_natureza_operacao="+String(lvl_CFOP))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'CFOP: '+String(lvl_CFOP)
End If

If lvs_Situacao <> "T" Then
	This.Of_AppendWhere("n.dh_cancelamento is "+IIF(lvs_Situacao="C", "not","")+" null")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Situa$$HEX2$$e700e300$$ENDHEX$$o: "+dw_1.Describe("Evaluate('LookUpDisplay(id_situacao)',1)")
End If

If lvs_Grupo<>'TD' Then
	This.Of_AppendWhere("substring(p.cd_subcategoria,1,1)='"+lvs_Grupo+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Grupo Prod.: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_grupo)',1)")
End If

If lvs_Lista_Pis<>'TD' Then
	This.Of_AppendWhere("pg.id_situacao_pis_cofins='"+lvs_Lista_Pis+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lista PIS: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lista_pis_cofins)',1)")
End If

If lvs_Lei_Gen<>'TD' Then
	This.Of_AppendWhere("pg.id_lei_generico='"+lvs_Lei_Gen+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lei Gen$$HEX1$$e900$$ENDHEX$$rico: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lei_generico)',1)")
End If

If lvs_ST_Calc = "S" Then
	This.Of_AppendWhere("coalesce(ic.vl_icms_st_calculado,0) > 0")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "[ X ] ICMS ST Retido na Entrada da Compra"
End If

If lvs_ST_Destac = "S" Then
	This.Of_AppendWhere("coalesce(i.vl_icms_st,0) > 0")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "[ X ] ICMS ST Destacado na Devolu$$HEX2$$e700e300$$ENDHEX$$o"
End If

If lvs_ST_Ret = "S" Then
	This.Of_AppendWhere("coalesce(i.vl_icms_st_retido,0) > 0")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "[ X ] ICMS ST Retido Anteriormente pelo Fornecedor"
End If

If lvs_ST_Obs = "S" Then
	This.Of_AppendWhere("coalesce(i.vl_icms_st_auxiliar,0) > 0")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "[ X ] ICMS ST em Informa$$HEX2$$e700f500$$ENDHEX$$es Adicionais (N$$HEX1$$e300$$ENDHEX$$o Destacado)"
End If

If (Not IsNull(lvl_NCM_Ini)) or (Not IsNull(lvl_NCM_Fim)) Then
	If IsNull(lvl_NCM_Fim) Then lvl_NCM_Fim = lvl_NCM_Ini
	If IsNull(lvl_NCM_Ini) Then lvl_NCM_Ini = lvl_NCM_Fim
	lvs_NCM_Ini 	= String(lvl_NCM_Ini)
	lvs_NCM_Fim 	= String(lvl_NCM_Fim)

	Do While Len(lvs_NCM_Ini) < 8
		lvs_NCM_Ini += '0'
	Loop
	
	Do While Len(lvs_NCM_Fim) < 8
		lvs_NCM_Fim += '9'
	Loop
	
	If lvs_NCM_Fim <> lvs_NCM_Ini Then
		This.Of_AppendWhere("i.nr_classificacao_fiscal >= "+lvs_NCM_Ini)
		This.Of_AppendWhere("i.nr_classificacao_fiscal <= "+lvs_NCM_Fim)
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NCM: '+lvs_NCM_Ini+' $$HEX1$$e000$$ENDHEX$$ '+lvs_NCM_Fim
	Else
		This.Of_AppendWhere("i.nr_classificacao_fiscal = "+lvs_NCM_Ini)
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NCM: '+lvs_NCM_Ini
	End If
End If

lvs_NCM_Ini = This.GetSQLSelect()

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge441_rel_dinamico_devcp_item
integer x = 1865
integer y = 784
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Compras"
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge441_rel_dinamico_devcp_item
integer x = 2606
integer y = 712
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge441_rel_dinamico_devcp_item
integer x = 133
integer y = 824
end type

