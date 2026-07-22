HA$PBExportHeader$w_ge326_rel_dinamico_vendas_mes.srw
forward
global type w_ge326_rel_dinamico_vendas_mes from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge326_rel_dinamico_vendas_mes from dc_w_selecao_lista_dinamica_relatorio
integer width = 4631
integer height = 2036
string title = "GE326 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Vendas (Resumo Mensal)"
end type
global w_ge326_rel_dinamico_vendas_mes w_ge326_rel_dinamico_vendas_mes

type variables
uo_filial ivo_filial
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

/*UF Filial*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

dw_1.Object.cd_uf[1] = "TD"

/*Regi$$HEX1$$e300$$ENDHEX$$o*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_regiao" )			

ldwc_Child.SetItem(1, "cd_regiao", 0)
ldwc_Child.SetItem(1, "de_regiao", "TODAS")

dw_1.Object.cd_regiao[1] = 0

/*Lei Gen$$HEX1$$e900$$ENDHEX$$rico*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			

ldwc_Child.SetItem(1, "id_lei_generico", "TD")
ldwc_Child.SetItem(1, "de_lei_generico", "TODAS")

dw_1.Object.id_lei_generico[1] = "TD"
end subroutine

on w_ge326_rel_dinamico_vendas_mes.create
call super::create
end on

on w_ge326_rel_dinamico_vendas_mes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_filial			= Create uo_filial
ivo_produto		= Create uo_produto

//Dimensionamento de tela
MaxWidth = 4745
MaxHeight = 1900

//SQL Base para formar o grid
ivs_SQLBase = 	"from resumo_produto_filial r " 									+ &
					"inner join filial f (index pk_filial) " 								+ &
					"	on f.cd_filial = r.cd_filial " 										+ &
					"inner join cidade ci (index pk_cidade) " 							+ &
					"	on ci.cd_cidade = f.cd_cidade " 								+ &
					"inner join regiao rg (index pk_regiao) " 							+ &
					"	on rg.cd_regiao = f.cd_regiao " 								+ &
					"inner join produto_geral p (index pk_produto_geral) "		+ &
					"	on p.cd_produto = r.cd_produto " 								+ &
					"inner join subcategoria t (index pk_subcategoria) "			+ &
					"	on t.cd_subcategoria = p.cd_subcategoria||'' "				+ &
					"Inner Join categoria c (index pk_categoria) "					+ &
					"	on c.cd_categoria = t.cd_categoria " 							+ &
					"Inner Join subgrupo s (index pk_subgrupo) "					+ &
					"	on s.cd_subgrupo = c.cd_subgrupo "							+ &
					"Inner Join grupo g (index pk_grupo) "							+ &
					"	on g.cd_grupo = s.cd_grupo "									

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 10
end event

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_produto)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = gf_primeiro_dia_mes(RelativeDate(Today(),-1))
dw_1.Object.dt_fim	[1] = gf_primeiro_dia_mes(RelativeDate(Today(),-1))

wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge326_rel_dinamico_vendas_mes
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge326_rel_dinamico_vendas_mes
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge326_rel_dinamico_vendas_mes
integer y = 392
integer width = 4530
integer height = 1440
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge326_rel_dinamico_vendas_mes
integer width = 4535
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge326_rel_dinamico_vendas_mes
integer width = 4466
integer height = 272
string dataobject = "dw_ge326_selecao"
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
			
		Case "de_produto"
			ivo_produto.of_localiza_produto(This.GetText())
			
			If ivo_produto.Localizado Then
				  
				This.Object.cd_produto	[1] = ivo_produto.cd_produto
				This.Object.de_produto	[1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
				
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
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge326_rel_dinamico_vendas_mes
integer y = 468
integer width = 4462
integer height = 1332
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Grupo
String lvs_UF_Fil
String lvs_Lei_Gen
String lvs_Lista_Pis
String lvs_NCM_Ini
String lvs_NCM_Fim
String lvs_Manipulado
String lvs_Frete

Long lvl_NCM
Long lvl_Filial
Long lvl_Produto
Long lvl_Regiao

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio			= gf_primeiro_dia_mes(dw_1.Object.dt_inicio	[1])
lvdt_Fim				= gf_primeiro_dia_mes(dw_1.Object.dt_fim		[1])
lvl_Filial				= dw_1.Object.cd_filial				[1]
lvs_UF_Fil			= dw_1.Object.cd_uf					[1]
lvl_Produto			= dw_1.Object.cd_produto			[1]
lvs_Grupo			= dw_1.Object.cd_grupo				[1]
lvl_NCM				= dw_1.Object.nr_ncm				[1]
lvs_Lista_Pis			= dw_1.Object.id_lista_pis_cofins	[1]
lvs_Lei_Gen			= dw_1.Object.id_lei_generico		[1]
lvl_Regiao			= dw_1.Object.cd_regiao			[1]
lvs_Manipulado		= dw_1.Object.id_manipulado		[1]
lvs_Frete				= dw_1.Object.id_frete				[1]

If IsNull(lvdt_Inicio) or (lvdt_Inicio < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data inicial para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_inicio')
	Return -1
Else
	This.Of_AppendWhere("r.dh_resumo >='"+String(lvdt_Inicio,'YYYY/MM/DD')+"'")
End If

If IsNull(lvdt_Fim) or (lvdt_Fim < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data final para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_fim')
	Return -1
Else
	This.Of_AppendWhere("r.dh_resumo <='"+String(lvdt_Fim,'YYYY/MM/DD')+"'")
End If

ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio,'MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim,'MM/YYYY')

If Not IsNull(lvl_Produto) and (lvl_Produto > 0) Then
	This.Of_AppendWhere("r.cd_produto="+String(lvl_Produto))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Produto: '+ivo_produto.de_produto+' ('+String(lvl_Produto)+')'
End If

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	This.Of_AppendWhere("r.cd_filial="+String(lvl_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_filial.nm_fantasia+' ('+String(lvl_Filial)+')'
End If

If Not IsNull(lvl_Regiao) and (lvl_Regiao > 0) Then
	This.Of_AppendWhere("f.cd_regiao="+String(lvl_Regiao))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Regi$$HEX1$$e300$$ENDHEX$$o: '+String(lvl_Regiao)
End If

If lvs_UF_Fil<>'TD' Then
	This.Of_AppendWhere("ci.cd_unidade_federacao='"+lvs_UF_Fil+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF Destino: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+lvs_UF_Fil+')'
End If

If lvs_Grupo<>'TD' Then
	This.Of_AppendWhere("substring(p.cd_subcategoria,1,1)='"+lvs_Grupo+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Grupo Prod.: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_grupo)',1)")
End If

If lvs_Manipulado='N' Then
	This.Of_AppendWhere("r.cd_produto<>684431")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Considera Manipulado: N$$HEX1$$c300$$ENDHEX$$O'
Else	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Considera Manipulado: SIM'
End If

If lvs_Frete = 'N' Then
	This.Of_AppendWhere("r.cd_produto<>712055")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Considera Frete: N$$HEX1$$c300$$ENDHEX$$O'
Else	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Considera Frete: SIM'
End If

If lvs_Lista_Pis<>'TD' Then
	This.Of_AppendWhere("p.id_situacao_pis_cofins='"+lvs_Lista_Pis+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lista PIS: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lista_pis_cofins)',1)")
End If

If lvs_Lei_Gen<>'TD' Then
	This.Of_AppendWhere("p.id_lei_generico='"+lvs_Lei_Gen+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lei Gen$$HEX1$$e900$$ENDHEX$$rico: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lei_generico)',1)")
End If

If Not IsNull(lvl_NCM) or (lvl_NCM > 0) Then
	lvs_NCM_Ini 	= String(lvl_NCM)
	lvs_NCM_Fim 	= String(lvl_NCM)

	Do While Len(lvs_NCM_Ini) < 8
		lvs_NCM_Ini += '0'
	Loop
	
	Do While Len(lvs_NCM_Fim) < 8
		lvs_NCM_Fim += '9'
	Loop
	
	If lvs_NCM_Fim <> lvs_NCM_Ini Then
		This.Of_AppendWhere("p.nr_classificacao_fiscal >= "+lvs_NCM_Ini)
		This.Of_AppendWhere("p.nr_classificacao_fiscal <= "+lvs_NCM_Fim)
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NCM: '+lvs_NCM_Ini+' $$HEX1$$e000$$ENDHEX$$ '+lvs_NCM_Fim
	Else
		This.Of_AppendWhere("p.nr_classificacao_fiscal = "+lvs_NCM_Ini)
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NCM: '+lvs_NCM_Ini
	End If
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge326_rel_dinamico_vendas_mes
integer x = 1865
integer y = 784
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Vendas (M$$HEX1$$ea00$$ENDHEX$$s)"
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge326_rel_dinamico_vendas_mes
integer x = 2606
integer y = 712
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge326_rel_dinamico_vendas_mes
end type

