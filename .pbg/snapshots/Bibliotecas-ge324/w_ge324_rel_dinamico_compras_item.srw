HA$PBExportHeader$w_ge324_rel_dinamico_compras_item.srw
forward
global type w_ge324_rel_dinamico_compras_item from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge324_rel_dinamico_compras_item from dc_w_selecao_lista_dinamica_relatorio
integer width = 4233
integer height = 2036
string title = "GE324 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Compras (Por Item Nota)"
end type
global w_ge324_rel_dinamico_compras_item w_ge324_rel_dinamico_compras_item

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

on w_ge324_rel_dinamico_compras_item.create
call super::create
end on

on w_ge324_rel_dinamico_compras_item.destroy
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
//N$$HEX1$$e300$$ENDHEX$$o definir o indice da nf_compra aqui, pois no dw_2.ue_PreRetrieve() tem tratamento
ivs_SQLBase = 'from nf_compra n ~r~n'															+ &
					'inner join item_nf_compra i (index pk_item_nf_compra) '				+ &
					'	on i.cd_filial = n.cd_filial+0 '													+ &
					'	and i.cd_fornecedor = n.cd_fornecedor '									+ &
					'	and i.nr_nf = n.nr_nf+0 '														+ &
					'	and i.de_serie = n.de_serie '												+ &
					'	and i.de_especie = n.de_especie ~r~n'									+ &
					'Left Outer Join produto_geral p (index pk_produto_geral) '				+ &
					'	on p.cd_produto = i.cd_produto+0 ~r~n'									+ &
					'Left Outer Join filial f (index pk_filial)   '										+ &
					'	on f.cd_filial = n.cd_filial+0 ~r~n'											+ &
					'Left Outer Join cidade cf (index pk_cidade)  '								+ &
					'	on cf.cd_cidade = f.cd_cidade+0 ~r~n'									+ &
					'Left Outer Join fornecedor fo (index pk_fornecedor)  '					+ &
					'	on fo.cd_fornecedor = n.cd_fornecedor ~r~n'							+ &
					'Left Outer Join cidade cfo (index pk_cidade)  '								+ &
					'	on cfo.cd_cidade = fo.cd_cidade ~r~n'									+ &
					'Left Outer Join produto_uf pu (index pk_produto_uf) '					+ &
					'	on pu.cd_produto = p.cd_produto+0 '										+ &
					'	and pu.cd_unidade_federacao = cf.cd_unidade_federacao ~r~n'	+ &
					'Left Outer Join unidade_federacao ud (index pk_unidade_federacao) '+ &
					'	on ud.cd_unidade_federacao = cf.cd_unidade_federacao ~r~n'	+ &
					'Left Outer Join historico_produto hp (index pk_historico_produto) '	+ &
					'	on hp.cd_produto = p.cd_produto+0 '										+ &
					"	and hp.dh_historico = cast(cast(year(n.dh_movimentacao_caixa) as varchar)||'/'||cast(month(n.dh_movimentacao_caixa) as varchar)||'/01' as datetime) ~r~n"	+ &
					'Left Outer Join historico_produto_uf hpu (index pk_historico_produto_uf) '				+ &
					'	on hpu.cd_produto = hp.cd_produto+0 '														+ &
					'	and hpu.dh_historico = hp.dh_historico '														+ &
					'	and hpu.cd_unidade_federacao = cf.cd_unidade_federacao ~r~n'						+ &
					'Left Outer Join ncm_pis_cofins npc '																+ &
					'	on npc.nr_ncm = p.nr_classificacao_fiscal '													+ &
					' 	and npc.id_lista_pis_cofins = p.id_situacao_pis_cofins '									+ &
					'Left Outer Join tributacao_pis_cofins tpis '														+ &
					'	on tpis.cd_tributacao_pis_cofins = coalesce(hp.cd_tributacao_pis, npc.cd_tributacao_pis) ~r~n '	+ &
					'Left Outer Join situacao_tributaria stpis '															+ &
					'	on stpis.cd_cst = tpis.cd_cst_entrada ~r~n '												+ &
					'Left Outer Join tributacao_pis_cofins tcof '														+ &
					'	on tcof.cd_tributacao_pis_cofins = coalesce(hp.cd_tributacao_cofins, npc.cd_tributacao_cofins) ~r~n '	+ &
					'Left Outer Join situacao_tributaria stcof '														+ &
					'	on stcof.cd_cst = tcof.cd_cst_entrada ~r~n '												+ &					
					'left outer join subcategoria scp (index pk_subcategoria) '									+ &
					" on scp.cd_subcategoria = coalesce(hp.cd_subcategoria, p.cd_subcategoria) ~r~n"	+ &
					'left outer join categoria cp (index pk_categoria) '							+ &
					"	on cp.cd_categoria = scp.cd_categoria||'' ~r~n"						+ &
					'left outer join subgrupo sgp (index pk_subgrupo) '						+ &
					"	on sgp.cd_subgrupo = cp.cd_subgrupo||'' ~r~n"						+ &
					'left outer join grupo gp (index pk_grupo) '									+ &
					"	on gp.cd_grupo = sgp.cd_grupo||'' ~r~n"								+ &
					'left outer join tipo_icms ti (index pk_tipo_icms) ~r~n'										+ &
					'	on ti.cd_tipo_icms = coalesce(hpu.cd_tipo_icms, pu.cd_tipo_icms) '					+ &
					'left outer join reducao_base_icms_st prst (index pk_reducao_base_icms_st) ~r~n'	+ &
					'	on prst.cd_unidade_federacao = cf.cd_unidade_federacao '								+ &		
					"	and prst.cd_grupo = '1' "																			+ &		
					'	and prst.id_lei_generico = coalesce(hp.id_lei_generico, p.id_lei_generico) '			+ &
					'	and prst.id_lista_pis_cofins = coalesce(hp.id_situacao_pis_cofins, p.id_situacao_pis_cofins) ~r~n'		+ &
					'left outer join tributa_produtos_farmaceuticos tpr (index pk_tributa_produtos_farmaceuti) '					+ &
					'	on tpr.cd_tributacao_produto = coalesce(hpu.cd_tributacao_produto, pu.cd_tributacao_produto) ~r~n'	
		

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 24
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

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge324_rel_dinamico_compras_item
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge324_rel_dinamico_compras_item
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge324_rel_dinamico_compras_item
integer y = 468
integer width = 4137
integer height = 1368
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge324_rel_dinamico_compras_item
integer width = 4133
integer height = 440
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge324_rel_dinamico_compras_item
integer width = 4064
integer height = 324
string dataobject = "dw_ge324_selecao"
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

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge324_rel_dinamico_compras_item
integer y = 544
integer width = 4069
integer height = 1260
string title = "Rel. Din$$HEX1$$e200$$ENDHEX$$mico de Compras (Item)"
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
String lvs_Indice = "idx_data_fornecedor"
String lvs_SQL
String lvs_Bonificacao

Long lvl_NCM
Long lvl_CFOP
Long lvl_Filial
Long lvl_Produto

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio		= dw_1.Object.dt_inicio				[1]
lvdt_Fim			= dw_1.Object.dt_fim					[1]
lvl_Filial			= dw_1.Object.cd_filial				[1]
lvs_UF_Fil		= dw_1.Object.cd_uf					[1]
lvl_Produto		= dw_1.Object.cd_produto			[1]
lvs_Fornecedor	= dw_1.Object.cd_fornecedor		[1]
lvs_UF_Forn		= dw_1.Object.cd_uf_forn			[1]
lvl_CFOP			= dw_1.Object.cd_cfop				[1]
lvs_Grupo		= dw_1.Object.cd_grupo				[1]
lvl_NCM			= dw_1.Object.nr_ncm				[1]
lvs_Lista_Pis		= dw_1.Object.id_lista_pis_cofins	[1]
lvs_Lei_Gen		= dw_1.Object.id_lei_generico		[1]
lvs_Bonificacao	= dw_1.Object.id_bonificacao		[1]

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

//Se n$$HEX1$$e300$$ENDHEX$$o tiver filial ou fornecedor bloqueia a extra$$HEX2$$e700e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio em 31 dias.
If (gf_coalesce(lvl_Filial, 0) = 0 and gf_coalesce(lvs_Fornecedor,'')='') Then
	If DaysAfter(lvdt_Inicio, lvdt_Fim) > 31 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Esse relat$$HEX1$$f300$$ENDHEX$$rio utiliza informa$$HEX2$$e700f500$$ENDHEX$$es detalhadas, por item de nota fiscal de compra, " + &
						"gerando um grande volume de dados e consumo excessivo do servidor da empresa. ~r~n~r~n"+ &
						"Favor filtrar por filial, fornecedor ou reduzir o per$$HEX1$$ed00$$ENDHEX$$odo para no m$$HEX1$$e100$$ENDHEX$$ximo 31 dias.", Exclamation!)
		Return -1
	End If
End If

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	lvs_Indice = "idx_filial_data_movimento"
	This.Of_AppendWhere("n.cd_filial="+String(lvl_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_filial.nm_fantasia+' ('+String(lvl_Filial)+')'
//Somente insere filtro de UF da filial caso n$$HEX1$$e300$$ENDHEX$$o tenha uma filial espec$$HEX1$$ed00$$ENDHEX$$fica informada
ElseIf lvs_UF_Fil<>'TD' Then
	lvs_Indice = "idx_filial_data_movimento"
	This.Of_AppendWhere("n.cd_filial in (select f1.cd_filial from filial f1 inner join cidade c1 on c1.cd_cidade = f1.cd_cidade where c1.cd_unidade_federacao='"+lvs_UF_Fil+"')")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF Destino: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+lvs_UF_Fil+')'
End If

If Not IsNull(lvs_Fornecedor) and (Trim(lvs_Fornecedor)<>'') Then
	lvs_Indice = IIF(lvl_Filial > 0 or lvs_UF_Fil <>"", "idx_forn_data_filial", "idx_data_fornecedor")
	This.Of_AppendWhere("n.cd_fornecedor='"+lvs_Fornecedor+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Fornecedor: '+ivo_fornecedor.nm_razao_social+' ('+ivo_fornecedor.cd_fornecedor+')'
//Somente insere filtro de UF da fornecedor caso n$$HEX1$$e300$$ENDHEX$$o tenha um fornecedor espec$$HEX1$$ed00$$ENDHEX$$fico informada
ElseIf lvs_UF_Forn<>'TD' Then
	lvs_Indice = IIF(lvl_Filial > 0, "idx_filial_data_movimento", "idx_data_fornecedor")
	This.Of_AppendWhere("n.cd_fornecedor in (select f1.cd_fornecedor from fornecedor f1 inner join cidade c1 on c1.cd_cidade = f1.cd_cidade where c1.cd_unidade_federacao='"+lvs_UF_Fil+"')")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF Origem: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf_forn)',1)")+' ('+lvs_UF_Forn+')'
End If

If Not IsNull(lvl_Produto) and (lvl_Produto > 0) Then
	This.Of_AppendWhere("i.cd_produto="+String(lvl_Produto))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Produto: '+ivo_produto.de_produto+' ('+String(lvl_Produto)+')'
End If

If Not IsNull(lvl_CFOP) and (lvl_CFOP > 0) Then
	This.Of_AppendWhere("i.cd_natureza_operacao+0="+String(lvl_CFOP))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'CFOP: '+String(lvl_CFOP)
End If

If lvs_Grupo<>'TD' Then
	This.Of_AppendWhere("substring(p.cd_subcategoria,1,1)='"+lvs_Grupo+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Grupo Prod.: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_grupo)',1)")
End If

If lvs_Lista_Pis<>'TD' Then
	This.Of_AppendWhere("coalesce(hp.id_situacao_pis_cofins, p.id_situacao_pis_cofins)='"+lvs_Lista_Pis+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lista PIS: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lista_pis_cofins)',1)")
End If

If lvs_Lei_Gen<>'TD' Then
	This.Of_AppendWhere("coalesce(hp.id_lei_generico, p.id_lei_generico)='"+lvs_Lei_Gen+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lei Gen$$HEX1$$e900$$ENDHEX$$rico: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lei_generico)',1)")
End If

//Filtra notas bonificadas
If lvs_Bonificacao <> "" Then
	Choose Case lvs_Bonificacao
		Case "B" //Somente notas bonificadas
			This.Of_AppendWhere("n.id_bonificacao in ('C','S')")
		Case Else
			This.Of_AppendWhere("n.id_bonificacao='"+lvs_Bonificacao+"'")
	End Choose
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Bonifica$$HEX2$$e700e300$$ENDHEX$$o: '+dw_1.Describe("Evaluate('LookUpDisplay(id_bonificacao)',1)")
End If

If Not IsNull(lvl_NCM) and (lvl_NCM > 0) Then
	lvs_NCM_Ini 	= String(lvl_NCM)
	lvs_NCM_Fim 	= String(lvl_NCM)

	Do While Len(lvs_NCM_Ini) < 8
		lvs_NCM_Ini += '0'
	Loop
	
	Do While Len(lvs_NCM_Fim) < 8
		lvs_NCM_Fim += '9'
	Loop
	
	If lvs_NCM_Fim <> lvs_NCM_Ini Then
		This.Of_AppendWhere("coalesce(hp.nr_classificacao_fiscal,p.nr_classificacao_fiscal) >= "+lvs_NCM_Ini)
		This.Of_AppendWhere("coalesce(hp.nr_classificacao_fiscal,p.nr_classificacao_fiscal) <= "+lvs_NCM_Fim)
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NCM: '+lvs_NCM_Ini+' $$HEX1$$e000$$ENDHEX$$ '+lvs_NCM_Fim
	Else
		This.Of_AppendWhere("coalesce(hp.nr_classificacao_fiscal, p.nr_classificacao_fiscal) = "+lvs_NCM_Ini)
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NCM: '+lvs_NCM_Ini
	End If
End If

lvs_SQL = This.GetSQLSelect( )
lvs_SQL = gf_replace(lvs_SQL,'from nf_compra n ','from nf_compra n (index '+lvs_Indice+') ',1)	
This.of_ChangeSQL(lvs_SQL)

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;String lvs_SQL


lvs_SQL = This.GetSQLSelect()

Return Super::Event ue_Recuperar()
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge324_rel_dinamico_compras_item
integer x = 1865
integer y = 784
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Compras"
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge324_rel_dinamico_compras_item
integer x = 2606
integer y = 712
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge324_rel_dinamico_compras_item
end type

