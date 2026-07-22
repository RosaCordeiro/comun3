HA$PBExportHeader$w_ge193_rel_vendas_prestes_a_vencer.srw
forward
global type w_ge193_rel_vendas_prestes_a_vencer from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge193_rel_vendas_prestes_a_vencer from dc_w_selecao_lista_dinamica_relatorio
integer width = 5202
integer height = 1868
string title = "GE193 - Relat$$HEX1$$f300$$ENDHEX$$rio Vendas de Produtos Prestes $$HEX1$$e000$$ENDHEX$$ Vencer"
end type
global w_ge193_rel_vendas_prestes_a_vencer w_ge193_rel_vendas_prestes_a_vencer

type variables
uo_filial						ivo_filial				//GE063
uo_cliente				 	ivo_cliente			//GE002
uo_usuario				 	ivo_comprador		//GE010
uo_produto					ivo_produto 			//GE001
uo_convenio				 	ivo_convenio		//GE004
uo_categoria				ivo_categoria	 	//GE022
uo_fornecedor				ivo_fornecedor		//GE003
uo_subcategoria		 	ivo_subcategoria	//GE022

end variables

forward prototypes
public subroutine wf_insere_padrao ()
public subroutine wf_altera_filtro (string ps_campo, string ps_valor)
end prototypes

public subroutine wf_insere_padrao ();Long lvl_Regiao

DataWindowChild ldwc_Child

/* Regi$$HEX1$$e300$$ENDHEX$$o */ 
ldwc_Child = dw_1.Of_Insertrow_dddw("cd_regiao") 
ldwc_Child.SetItem(1, "cd_regiao", 0)
ldwc_Child.SetItem(1, "de_regiao", "TODAS")

select cd_regiao
Into :lvl_Regiao
From regiao
Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	dw_1.Object.cd_regiao[1] = lvl_Regiao
Else
	dw_1.Object.cd_regiao[1] = 0	
End If

/* Grupo Produto */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_grupo" )			
ldwc_Child.SetItem(1, "cd_grupo", "0")
ldwc_Child.SetItem(1, "de_grupo", "TODOS")
dw_1.Object.cd_grupo [1] = "0"

/* Subgrupo Produto */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_subgrupo" )			
ldwc_Child.SetItem(1, "cd_grupo", "0")	
ldwc_Child.SetItem(1, "cd_subgrupo", "0")
ldwc_Child.SetItem(1, "de_subgrupo", "TODOS")
dw_1.Object.cd_subgrupo [1] = "0"

/* Lei Gen$$HEX1$$e900$$ENDHEX$$rico */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			
ldwc_Child.SetItem(1, "id_lei_generico", "T")
ldwc_Child.SetItem(1, "de_lei_generico", "TODOS")
dw_1.Object.id_lei_generico [1] = "T"
end subroutine

public subroutine wf_altera_filtro (string ps_campo, string ps_valor);DatawindowChild ldwc_Child

If (ps_campo = 'cd_grupo') or (ps_campo = 'cd_subgrupo') or (ps_campo = 'de_categoria')  Then 
	ivo_subcategoria.Of_inicializa( )
	
	dw_1.Object.cd_subcategoria	[1] = ivo_subcategoria.cd_subcategoria
	dw_1.Object.de_subcategoria	[1] = ivo_subcategoria.de_subcategoria
	
	If (ps_campo = 'cd_grupo') or (ps_campo = 'cd_subgrupo')  Then 
		ivo_categoria.Of_inicializa( )
		
		dw_1.Object.cd_categoria	[1] = ivo_categoria.cd_categoria
		dw_1.Object.de_categoria	[1] = ivo_categoria.de_categoria
		
		
		If ps_campo = 'cd_grupo' Then 
			If ps_valor <> '1' Then dw_1.Object.id_lei_generico [1] = 'T'
		
			If dw_1.GetChild("cd_subgrupo", ldwc_Child) = 1 Then
				ldwc_Child.SetFilter("( cd_grupo = '0' or  cd_grupo = '"+ps_valor+"')")
				ldwc_Child.Filter()
			End If
			
			dw_1.Object.cd_subgrupo [1] = '0'
		End If
	End If
End If

Choose Case ps_campo
	Case 'cd_grupo' 
		If ps_valor <> '' Then dw_1.Post Event ue_Pos(1,'cd_subgrupo')
	Case 'cd_subgrupo' 
		If ps_valor <> '' Then dw_1.Post Event ue_Pos(1,'de_categoria')
	Case 'de_categoria' 
		If ps_valor <> '' Then dw_1.Post Event ue_Pos(1,'de_subcategoria')
End Choose
end subroutine

on w_ge193_rel_vendas_prestes_a_vencer.create
call super::create
end on

on w_ge193_rel_vendas_prestes_a_vencer.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivo_produto			= Create uo_produto
ivo_filial				= Create uo_filial
ivo_categoria		= Create uo_categoria
ivo_subcategoria	= Create uo_subcategoria
ivo_comprador		= Create uo_usuario		
ivo_fornecedor		= Create uo_fornecedor
ivo_convenio		= Create uo_convenio
ivo_cliente			= Create uo_cliente

//Dimensionamento de tela
MaxWidth = 5250
MaxHeight = 2000

//SQL Base para formar o grid
ivs_SQLBase = "from nf_venda n (index idx_data_filial) "									+ &
					"inner join item_nf_venda_desconto id (index pk_item_nf_venda_desconto) "+ &
						"on id.cd_filial = n.cd_filial+0 "											+ &
						"and id.nr_nf = n.nr_nf+0 "												+ &
						"and id.de_especie = n.de_especie "									+ &
						"and id.de_serie = n.de_serie "											+ &
					"Left outer join item_nf_venda i (index pk_item_nf_venda) "			+ &
						"on i.cd_filial = id.cd_filial+0 "											+ &
						"and i.nr_nf = id.nr_nf+0 "												+ &
						"and i.de_especie = id.de_especie "									+ &
						"and i.de_serie = id.de_serie "											+ &
						"and i.cd_produto = id.cd_produto "									+ &
						"and i.nr_sequencial = id.nr_sequencial "							+ &
					"Left outer join movimento_estoque m (index idx_nota) "			+ &
						"on m.cd_filial_movimento = id.cd_filial "							+ &
						"and m.nr_nf = id.nr_nf "												+ &
						"and m.de_especie = id.de_especie "									+ &
						"and m.de_serie = id.de_serie "										+ &
						"and m.cd_produto = id.cd_produto "									+ &
						"and coalesce(m.nr_sequencial,1) = id.nr_sequencial "			+ &
					"Left outer join filial f  (index pk_filial) "									+ &
						"on f.cd_filial = id.cd_filial "												+ &
					"Left outer join cidade cf  (index pk_cidade) "							+ &
						"on cf.cd_cidade = f.cd_cidade "										+ &
					"Left outer join produto_geral pg (index pk_produto_geral) "		+ &
						"on pg.cd_produto = id.cd_produto "									+ &
					"Left outer join produto_uf pu (index pk_produto_uf) "				+ &
						"on pu.cd_produto = pg.cd_produto "									+ &
						"and pu.cd_unidade_federacao = cf.cd_unidade_federacao "	+ &
					"Left outer join produto_central pc (index pk_produto_central) "	+ &
						"on pc.cd_produto = i.cd_produto+0 "								+ &
					"Left outer join subcategoria scp (index pk_subcategoria) "			+ &
						"on scp.cd_subcategoria = pg.cd_subcategoria+'' "				+ &
					"Left outer join categoria cp (index pk_categoria) "					+ &
						"on cp.cd_categoria = scp.cd_categoria+'' "							+ &
					"Left outer join subgrupo sgp (index pk_subgrupo) "					+ &
						"on sgp.cd_subgrupo = cp.cd_subgrupo+'' "							+ &
					"Left outer join grupo gp (index pk_grupo) "								+ &
						"on gp.cd_grupo =  sgp.cd_grupo "									+ &
					"Left outer join convenio co (index pk_convenio) "						+ &
						"on co.cd_convenio = n.cd_convenio "								+ &
					"Left outer join conveniado cv (index pk_conveniado) "				+ &
						"on cv.cd_convenio = n.cd_convenio "								+ &
						"and cv.cd_conveniado = n.cd_conveniado "							+ &
					"Left outer join cliente cli (index pk_cliente) "							+ &
						"on cli.cd_cliente = n.cd_cliente "										+ &
					"Left outer join usuario uc (index pk_usuario) "							+ &
						"on uc.nr_matricula = pc.nr_matricula_comprador "				+ &
					"Left outer join fornecedor fp (index pk_fornecedor) "					+ &
						"on fp.cd_fornecedor = pg.cd_fornecedor_usual "				/*	+ &
					"Left outer join produto_preste_a_vencer ppv "							+ &
						"on fp.cd_fornecedor = pg.cd_fornecedor_usual "*/

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 15
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio [1] = Today()
dw_1.Object.dt_fim	[1] = Today()

wf_insere_padrao()
end event

event close;call super::close;Destroy(ivo_subcategoria)
Destroy(ivo_fornecedor)
Destroy(ivo_comprador)
Destroy(ivo_categoria)
Destroy(ivo_convenio)
Destroy(ivo_produto)
Destroy(ivo_cliente)
Destroy(ivo_filial)

end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge193_rel_vendas_prestes_a_vencer
integer x = 123
integer y = 2008
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge193_rel_vendas_prestes_a_vencer
integer x = 87
integer y = 1936
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge193_rel_vendas_prestes_a_vencer
integer y = 528
integer width = 5102
integer height = 1136
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge193_rel_vendas_prestes_a_vencer
integer width = 5102
integer height = 500
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge193_rel_vendas_prestes_a_vencer
integer width = 5038
integer height = 420
string dataobject = "dw_ge193_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;DatawindowChild ldwc_Child

Choose Case Dwo.Name
	Case 'id_situacao'
		If Data <> 'B' Then This.Object.id_tipo_baixa [Row] = '0'
		
	Case 'id_tipo_baixa'
		If Data <> '0' Then This.Object.id_situacao [Row] = 'B'
		
	Case "nm_cliente"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cliente.nm_cliente Then
				Return 1
			End If	
		Else			
			ivo_cliente.Of_Inicializa()
			
			This.Object.nm_cliente	[1] = ivo_cliente.nm_cliente
			This.Object.cd_cliente	[1] = ivo_cliente.cd_cliente
			
		End If
		
	Case "nm_convenio"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_convenio.nm_fantasia Then
				Return 1
			End If	
		Else			
			ivo_convenio.Of_Inicializa()
			
			This.Object.nm_convenio[1] = ivo_convenio.nm_fantasia
			This.Object.cd_convenio	[1] = ivo_convenio.cd_convenio
			
		End If			
		
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
		
	Case "nm_comprador"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> (ivo_comprador.nm_usuario) Then
				Return 1
			End If	
		Else			
			ivo_comprador.Of_Inicializa()
			
			This.Object.nm_comprador	[1] = ivo_comprador.nm_usuario
			This.Object.cd_comprador	[1] = ivo_comprador.nr_matricula
			
		End If	
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> (ivo_fornecedor.nm_razao_social) Then
				Return 1
			End If	
		Else			
			ivo_fornecedor.Of_Inicializa()
			
			This.Object.nm_fornecedor	[1] = ivo_fornecedor.nm_razao_social
			This.Object.cd_fornecedor	[1] = ivo_fornecedor.cd_fornecedor
			
		End If	
		
	Case 'cd_grupo'
		wf_altera_filtro(Dwo.Name,Data)
	Case 'cd_subgrupo'
		wf_altera_filtro(Dwo.Name,Data)
	Case 'de_categoria'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_categoria.de_categoria Then
				Return 1
			End If	
		Else			
			ivo_categoria.Of_Inicializa()
			
			This.Object.cd_categoria	[1] = ivo_categoria.de_categoria
			This.Object.de_categoria	[1] = ivo_categoria.cd_categoria
		End If	
		
		wf_altera_filtro(Dwo.Name,Data)
		
	Case 'de_subcategoria'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_subcategoria.de_subcategoria Then
				Return 1
			End If	
		Else			
			ivo_subcategoria.Of_Inicializa()
			
			This.Object.cd_subcategoria	[1] = ivo_subcategoria.de_subcategoria
			This.Object.de_subcategoria	[1] = ivo_subcategoria.cd_subcategoria
		End If	
		
		wf_altera_filtro(Dwo.Name,Data)
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_produto) Then 
	If ivo_produto.Localizado Then	This.Object.de_produto [1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
End If

If IsValid(ivo_categoria) Then
	This.Object.de_categoria [1] = ivo_categoria.de_categoria
End If

If IsValid(ivo_subcategoria) Then
	This.Object.de_subcategoria [1] = ivo_subcategoria.de_subcategoria
End If

If IsValid(ivo_comprador) Then
	This.Object.nm_comprador [1] = ivo_comprador.nm_usuario
End If

If IsValid(ivo_fornecedor) Then
	This.Object.nm_fornecedor [1] = ivo_fornecedor.nm_razao_social
End If

If IsValid(ivo_cliente) Then
	This.Object.nm_cliente [1] = ivo_cliente.nm_cliente
End If

If IsValid(ivo_convenio) Then
	This.Object.nm_convenio [1] = ivo_convenio.nm_fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;String lvs_Grupo
String lvs_Subgrupo
String lvs_Categoria

If Key = KeyEnter! Then
	
	This.AcceptText( )
	
	Choose Case This.GetColumnName() 
			
		Case "nm_filial"
			ivo_filial.Of_Localiza_Filial(This.GetText()) 
			
			If ivo_filial.Localizada Then
				  
				This.Object.cd_filial	[1] = ivo_filial.cd_filial
				This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
				
			End If		
			
		Case "nm_convenio"
			ivo_convenio.Of_inicializa( )
			ivo_convenio.Of_Localiza_convenio(This.GetText())
			
			If ivo_convenio.localizado Then
				  
				This.Object.cd_convenio	[1] = ivo_convenio.cd_convenio
				This.Object.nm_convenio[1] = ivo_convenio.nm_fantasia
				
			End If		
			
		Case "nm_cliente"
			ivo_cliente.Of_inicializa( )
			ivo_cliente.Of_Localiza_cliente(This.GetText() )
			
			If ivo_cliente.Localizado Then
				  
				This.Object.cd_cliente	[1] = ivo_cliente.cd_cliente
				This.Object.nm_cliente	[1] = ivo_cliente.nm_cliente
				
			End If		
			
		Case "nm_comprador"
			ivo_comprador.Of_Localiza_usuario(This.GetText())
			
			If ivo_comprador.Localizado Then
				  
				This.Object.cd_comprador	[1] = ivo_comprador.nr_matricula
				This.Object.nm_comprador	[1] = ivo_comprador.nm_usuario
			
			End If	
			
		Case "nm_fornecedor"
			ivo_fornecedor.Of_Localiza_fornecedor(This.GetText())
			
			If ivo_fornecedor.Localizado Then
				  
				This.Object.cd_fornecedor	[1] = ivo_fornecedor.cd_fornecedor
				This.Object.nm_fornecedor	[1] = ivo_fornecedor.nm_razao_social
				
			End If	

		Case "de_produto"
			ivo_produto.of_localiza_produto(This.GetText())
			
			If ivo_produto.Localizado Then
				  
				This.Object.cd_produto	[1] = ivo_produto.cd_produto
				This.Object.de_produto	[1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
				
			End If
			
		Case 'de_categoria'
			lvs_Grupo		= This.Object.cd_grupo 		[1]
			lvs_Subgrupo	= This.Object.cd_subgrupo	[1]
			
			ivo_categoria.of_localiza(This.GetText(),lvs_Grupo,lvs_Subgrupo)
			
			This.Object.cd_categoria	[1] = ivo_categoria.cd_categoria
			This.Object.de_categoria	[1] = ivo_categoria.de_categoria
			
			wf_altera_filtro('de_categoria',ivo_categoria.cd_categoria)
			
		Case 'de_subcategoria'
			lvs_Grupo		= This.Object.cd_grupo 		[1]
			lvs_Subgrupo	= This.Object.cd_subgrupo	[1]
			lvs_Categoria	= This.Object.cd_categoria	[1]
			
			ivo_subcategoria.of_localiza(This.GetText(),lvs_Grupo,lvs_Subgrupo,lvs_Categoria)
			
			This.Object.cd_subcategoria	[1] = ivo_subcategoria.cd_subcategoria
			This.Object.de_subcategoria	[1] = ivo_subcategoria.de_subcategoria
			
			wf_altera_filtro('de_subcategoria',ivo_subcategoria.cd_subcategoria)
	End Choose
	
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge193_rel_vendas_prestes_a_vencer
integer y = 604
integer width = 5033
integer height = 1028
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Grupo
String lvs_Subgrupo
String lvs_Categoria
String lvs_Subcategoria
String lvs_Fornecedor
String lvs_Comprador
String lvs_Lei_G
String lvs_Desconto
String lvs_Tipo_Venda
String lvs_Forma_Pagto
String lvs_Cliente

Date lvdt_Inicio
Date lvdt_Fim

Long lvl_Regiao
Long lvl_Filial
Long lvl_Produto
Long lvl_Convenio

dw_1.AcceptText( )
lvdt_Inicio 			= dw_1.Object.dt_inicio				[1]
lvdt_Fim 				= dw_1.Object.dt_fim					[1]
lvs_Grupo 			= dw_1.Object.cd_grupo				[1]
lvs_Subgrupo 		= dw_1.Object.cd_subgrupo		[1]
lvs_Categoria 		= dw_1.Object.cd_categoria		[1]
lvs_Subcategoria 	= dw_1.Object.cd_subcategoria	[1]
lvs_Lei_G 			= dw_1.Object.id_lei_generico		[1]
lvl_Regiao 			= dw_1.Object.cd_regiao			[1]
lvl_Filial 				= dw_1.Object.cd_filial				[1]
lvl_Produto 			= dw_1.Object.cd_produto			[1]
lvs_Fornecedor		= dw_1.Object.cd_fornecedor		[1]
lvs_Comprador		= dw_1.Object.cd_comprador		[1]
lvs_Tipo_Venda	= dw_1.Object.id_tipo_venda		[1]
lvs_Forma_Pagto	= dw_1.Object.cd_forma_pagto	[1]
lvs_Cliente			= dw_1.Object.cd_cliente			[1]
lvl_Convenio			= dw_1.Object.cd_convenio			[1]

If (Not IsNull(lvdt_Inicio)) and (lvdt_Inicio > Date('2001/01/01')) Then
	This.of_AppendWhere("n.dh_movimentacao_caixa >= '"+String(lvdt_Inicio,'YYYY.MM.DD')+"'")
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Favor informar a data de $$HEX1$$ed00$$ENDHEX$$nicio para emiss$$HEX1$$e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio!',Exclamation!)
	dw_1.Event ue_Pos(1,'dt_inicio')
	Return -1
End If

If (Not IsNull(lvdt_Fim)) and (lvdt_Fim > Date('2001/01/01')) Then
	This.of_AppendWhere("n.dh_movimentacao_caixa <= '"+String(lvdt_Fim,'YYYY.MM.DD')+"'")
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Favor informar a data de t$$HEX1$$e900$$ENDHEX$$rmino para emiss$$HEX1$$e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio!',Exclamation!)
	dw_1.Event ue_Pos(1,'dt_fim')
	Return -1
End If

ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim,'DD/MM/YYYY')

If (Not IsNull(lvl_Produto)) and (lvl_Produto > 0) Then
	This.of_AppendWhere("id.cd_produto = "+String(lvl_Produto))
	This.of_AppendWhere("m.cd_produto = "+String(lvl_Produto))
	This.of_AppendWhere("m.cd_tipo_movimento = 1")
	This.of_AppendWhere("m.dh_movimento between '"+String(lvdt_Inicio,'YYYY.MM.DD')+"' and  '"+String(lvdt_Fim,'YYYY.MM.DD')+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Produto: '+ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_venda+' ('+String(lvl_Produto)+')'
ElseIf (Not IsNull(lvs_Subcategoria)) and (lvs_Subcategoria <> '')  Then
	This.of_AppendWhere("pg.cd_subcategoria = '"+lvs_Subcategoria+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Subcategoria: '+ivo_subcategoria.de_subcategoria+' ('+lvs_Subcategoria+')'
ElseIf (Not IsNull(lvs_Categoria)) and (lvs_Categoria <> '')  Then
	This.of_AppendWhere("scp.cd_categoria = '"+lvs_Categoria+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Subcategoria: '+ivo_categoria.de_categoria+' ('+lvs_Categoria+')'
ElseIf lvs_Subgrupo <> '0'  Then
	This.of_AppendWhere("cp.cd_subgrupo = '"+lvs_Subgrupo+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Subgrupo: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_subgrupo)',1)")
ElseIf lvs_Grupo <> '0'  Then
	This.of_AppendWhere("sgp.cd_grupo = '"+lvs_Grupo+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Grupo: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_grupo)',1)")
End If

If lvs_Lei_G <> 'T'  Then
	This.of_AppendWhere("pg.id_lei_generico = '"+lvs_Lei_G+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lei Gen$$HEX1$$e900$$ENDHEX$$rico: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lei_generico)',1)")
End If

If (Not IsNull(lvs_Comprador)) and (lvs_Comprador <> '')  Then
	This.of_AppendWhere("pc.nr_matricula_comprador = '"+lvs_Comprador+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Comprador: '+ivo_comprador.nm_usuario+' ('+lvs_Comprador+')'
End If

If (Not IsNull(lvs_Fornecedor)) and (lvs_Fornecedor <> '')  Then
	This.of_AppendWhere("pg.cd_fornecedor_usual = '"+lvs_Fornecedor+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Fornecedor: '+ivo_fornecedor.nm_razao_social+' ('+lvs_Comprador+')'
End If

If (Not IsNull(lvs_Cliente)) and (lvs_Cliente <> '')  Then
	This.of_AppendWhere("n.cd_cliente = '"+lvs_Cliente+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Cliente: '+ivo_cliente.nm_cliente+' ('+lvs_Cliente+')'
End If

If (Not IsNull(lvl_Convenio)) and (lvl_Convenio > 0) Then
	This.of_AppendWhere("n.cd_convenio = "+String(lvl_Convenio))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Conv$$HEX1$$ea00$$ENDHEX$$nio: '+ivo_convenio.nm_fantasia+' ('+String(lvl_Convenio)+')'
End If

If (Not IsNull(lvl_Regiao)) and (lvl_Regiao > 0) Then
	This.of_AppendWhere("f.cd_regiao = "+String(lvl_Regiao))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Regi$$HEX1$$e300$$ENDHEX$$o: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_regiao)',1)")
End If

If (Not IsNull(lvl_Filial)) and (lvl_Filial > 0) Then
	This.of_AppendWhere("n.cd_filial = "+String(lvl_Filial))
	This.of_AppendWhere("m.cd_filial_movimento = "+String(lvl_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_filial.nm_fantasia+' ('+String(lvl_Filial)+')'
Else
	This.of_AppendWhere("n.cd_filial > 0")
End If

If lvs_Tipo_Venda <> 'TD' Then
	This.of_AppendWhere("n.id_tipo_venda='"+lvs_Tipo_Venda+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Tipo Venda: '+dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_venda)',1)")
End if

If lvs_Forma_Pagto <> 'TD' Then
	This.of_AppendWhere("n.cd_forma_pagamento='"+lvs_Forma_Pagto+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Forma Pagto: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_forma_pagto)',1)")
End if

This.of_AppendWhere("n.dh_cancelamento is null")
This.of_AppendWhere("n.nr_nf_anexa is null")
This.of_AppendWhere("n.vl_total_nf_tabela > n.vl_total_nf")
This.of_AppendWhere("id.id_tipo_desconto='PVE'")

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge193_rel_vendas_prestes_a_vencer
integer x = 2021
integer y = 908
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge193_rel_vendas_prestes_a_vencer
integer x = 2021
integer y = 604
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge193_rel_vendas_prestes_a_vencer
end type

