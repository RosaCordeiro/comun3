HA$PBExportHeader$w_ge477_rel_dinamico_dev_vendas_item.srw
forward
global type w_ge477_rel_dinamico_dev_vendas_item from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge477_rel_dinamico_dev_vendas_item from dc_w_selecao_lista_dinamica_relatorio
integer width = 4233
integer height = 2036
string title = "GE477 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Vendas (Por Item Nota)"
end type
global w_ge477_rel_dinamico_dev_vendas_item w_ge477_rel_dinamico_dev_vendas_item

type variables
uo_filial ivo_filial
uo_natureza_operacao ivo_cfop
uo_produto ivo_produto
uo_cliente ivo_cliente
uo_convenio ivo_convenio

end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*Grupo Produto*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_grupo" )			

ldwc_Child.SetItem(1, "cd_grupo", "")
ldwc_Child.SetItem(1, "de_grupo", "TODOS")

dw_1.Object.cd_grupo[1] = ""

/*Lei Gen$$HEX1$$e900$$ENDHEX$$rico*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			

ldwc_Child.SetItem(1, "id_lei_generico", "")
ldwc_Child.SetItem(1, "de_lei_generico", "TODAS")

dw_1.Object.id_lei_generico[1] = ""

/*UF Filial*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			
ldwc_Child.SetItem(1, "cd_unidade_federacao", "")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")
dw_1.Object.cd_uf[1] = ""


/* Tipo Canal de Vendas */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_tipo_canal" )
ldwc_Child.SetItem(1, "id_tipo_canal_venda", "")
ldwc_Child.SetItem(1, "de_tipo_canal_venda",  "TODOS")
dw_1.Object.id_canal_venda[1] = ""

/* Canal de Vendas */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_canal_venda" )
ldwc_Child.SetItem(1, "cd_canal_venda", "")
ldwc_Child.SetItem(1, "de_canal_venda",  "TODOS")
dw_1.Object.id_canal_venda[1] = ""

/* Modo de Entrega */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_modo_entrega" )
ldwc_Child.SetItem(1, "cd_modo_entrega", "")
ldwc_Child.SetItem(1, "de_modo_entrega",  "TODOS")
dw_1.Object.cd_modo_entrega[1] = ""

/* $$HEX1$$c100$$ENDHEX$$rea de Vendas*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_area_vendas" )
ldwc_Child.SetItem(1, "rede", "TODAS")
ldwc_Child.SetItem(1, "vl_parametro",   "")
dw_1.Object.Id_Area_Vendas[1] = ""
end subroutine

on w_ge477_rel_dinamico_dev_vendas_item.create
call super::create
end on

on w_ge477_rel_dinamico_dev_vendas_item.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_filial			= Create uo_filial
ivo_cfop			= Create uo_natureza_operacao
ivo_produto		= Create uo_produto
ivo_cliente		= Create uo_cliente
ivo_convenio	= Create uo_convenio

//Dimensionamento de tela
MaxWidth = 4600
MaxHeight = 9999

//SQL Base para formar o grid
ivs_SQLBase = 'from nf_devolucao_venda n '										+ &
					'inner join item_nf_devolucao_venda i (index pk_item_nf_devolucao_venda) '	+ &
					'	on i.cd_filial = n.cd_filial+0 '										+ &
					'	and i.nr_nf = n.nr_nf+0 '											+ &
					'	and i.de_serie = n.de_serie '									+ &
					'	and i.de_especie = n.de_especie '								+ &
					'Inner Join filial f (index pk_filial) '									+ &
					'	on f.cd_filial = n.cd_filial '										+ &
					'Inner Join cidade cf (index pk_cidade) '							+ &
					'	on cf.cd_cidade = f.cd_cidade+0 '								+ &
					'Inner Join filial fv (index pk_filial) '								+ &
					'	on fv.cd_filial = n.cd_filial_venda+0 '							+ &
					'Left Outer Join produto_geral p (index pk_produto_geral) '	+ &
					'	on p.cd_produto = i.cd_produto+0 '							+ &
					'Left Outer Join item_nf_dev_venda_destino id (index pk_item_nf_dev_venda_destino) '		+ &
					'	on id.cd_filial = i.cd_filial+0 '									+ &
					'	and id.nr_nf = i.nr_nf+0 '										+ &
					'	and id.de_serie = i.de_serie '									+ &
					'	and id.de_especie = i.de_especie '							+ &
					'	and id.cd_produto = i.cd_produto '							+ &
					'	and id.nr_sequencial = i.nr_sequencial '						+ &
					'Left Outer Join nf_venda v (index pk_nf_venda) '				+ &
					'	on v.cd_filial = n.cd_filial_venda+0 '							+ &
					'	and v.nr_nf = n.nr_nf_venda+0 '								+ &
					'	and v.de_serie = n.de_serie_venda '							+ &
					'	and v.de_especie = n.de_especie_venda '					+ &
					'Left Outer Join cliente cl (index pk_cliente) '					+ &
					"	on cl.cd_cliente = n.cd_cliente||'' "							+ &
					'Left Outer Join convenio cv (index pk_convenio) '				+ &
					'	on cv.cd_convenio = n.cd_convenio+0 '						+ &
					'Left Outer Join conveniado co (index pk_conveniado) '		+ &
					'	on co.cd_convenio = n.cd_convenio+0 '						+ &
					'  and co.cd_conveniado = n.cd_conveniado '					+ &
					'Left Outer Join usuario uvv (index pk_usuario) '				+ &
					'	on uvv.nr_matricula = v.nr_matricula_vendedor '			+ &	
					'Left Outer Join usuario uvo (index pk_usuario) '				+ &
					'	on uvo.nr_matricula = v.nr_matric_operador '				+ &		
					'Left Outer Join usuario udo (index pk_usuario) '				+ &
					'	on udo.nr_matricula = n.nr_matricula_operador '			+ &		
					'Left Outer Join usuario udc (index pk_usuario) '				+ &
					'	on udc.nr_matricula = n.nr_matricula_cancelamento '	+ &		
					'Left Outer Join pedido_ecommerce pe (index pk_pedido_ecommerce) '	+ &			
					'	on pe.cd_filial_ecommerce = coalesce(v.cd_filial_ecommerce, 809) ' + &		
					'	and pe.nr_pedido = v.nr_pedido_ecommerce ' + &
					'Left Outer Join pedido_ecommerce_auxiliar pea (index pk_pedido_ecommerce_auxiliar) '	+ &
					'	on pea.cd_filial_ecommerce = coalesce(v.cd_filial_ecommerce, 809) ' + &		
					'	and pea.nr_pedido = v.nr_pedido_ecommerce '						+ &
					'Left Outer Join historico_produto hp (index pk_historico_produto) '	+ &
					'	on hp.cd_produto = p.cd_produto+0 '							+ &
					"	and hp.dh_historico = cast(cast(year(n.dh_movimentacao_caixa) as varchar)||'/'||cast(month(n.dh_movimentacao_caixa) as varchar)||'/01' as datetime)"	+ &
					'Left Outer Join historico_produto_uf hpu (index pk_historico_produto_uf) '		+ &
					'	on hpu.cd_produto = hp.cd_produto+0 '								+ &
					'	and hpu.dh_historico = hp.dh_historico '								+ &
					'	and hpu.cd_unidade_federacao = cf.cd_unidade_federacao '	+ &
					'Left Outer join subcategoria t (index pk_subcategoria) '				+ &
					"	on t.cd_subcategoria = coalesce(hp.cd_subcategoria, p.cd_subcategoria) "	 + &
					'Left Outer Join categoria c (index pk_categoria) '						+ &
					"	on c.cd_categoria = t.cd_categoria||'' "								+ &
					'Left Outer Join subgrupo s (index pk_subgrupo) '						+ &
					"	on s.cd_subgrupo = c.cd_subgrupo||'' "								+ &
					'Left Outer Join grupo g (index pk_grupo) '								+ &
					"	on g.cd_grupo = s.cd_grupo||'' "										+ &
					"Left Outer Join movimento_estoque me (index idx_nota) "			+ &
					"	on me.cd_filial_movimento = i.cd_filial+0 "							+ &
					"	and me.nr_nf = i.nr_nf+0 "												+ &
					"	and me.de_serie = i.de_serie "											+ &
					"	and me.de_especie = i.de_especie "									+ &
					"	and me.cd_produto = i.cd_produto+0 "								+ &
					"	and coalesce(me.nr_sequencial, 1) = i.nr_sequencial "			+ &
					'Left Outer Join canal_venda cnv (index pk_canal_venda) '	+ &
					" 	on cnv.cd_canal_venda = Upper(case when v.dh_movimentacao_caixa >= '2019/01/01' then coalesce(case when pe.de_canal_compra_vtex in ('app_android', 'app_ios', 'app_android_n', 'app_ios_n') then 'AP' else v.cd_canal_venda end, 'LF') else case when v.nr_pedido_ecommerce > 0 then 'EC'  else case when v.nr_pedido_drogaexpress is not null then 'DE' else 'LF' end end end)"

					
//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 23
end event

event close;call super::close;Destroy(ivo_cliente)
Destroy(ivo_convenio)
Destroy(ivo_filial)
Destroy(ivo_cfop)
Destroy(ivo_produto)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)

wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge477_rel_dinamico_dev_vendas_item
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge477_rel_dinamico_dev_vendas_item
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge477_rel_dinamico_dev_vendas_item
integer y = 708
integer width = 4137
integer height = 1120
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge477_rel_dinamico_dev_vendas_item
integer width = 4133
integer height = 680
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge477_rel_dinamico_dev_vendas_item
integer width = 4064
integer height = 592
string dataobject = "dw_ge477_selecao"
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
			
		Case "nm_cliente"
			ivo_cliente.of_localiza_cliente(This.GetText())
			
			If ivo_cliente.Localizado Then
				  
				This.Object.cd_cliente	[1] = ivo_cliente.cd_cliente
				This.Object.nm_cliente	[1] = ivo_cliente.nm_cliente
				
			End If
			
		Case "nm_convenio"
			ivo_convenio.of_localiza_convenio(This.GetText())
			
			If ivo_convenio.Localizado Then
				  
				This.Object.cd_convenio	[1] = ivo_convenio.cd_convenio
				This.Object.nm_convenio[1] = ivo_convenio.nm_razao_social
				
			End If

	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;DatawindowChild lvdw_Child

Choose Case dwo.Name
		
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
			If Data <> ivo_convenio.nm_razao_social Then
				Return 1
			End If	
		Else			
			ivo_convenio.Of_Inicializa()
			
			This.Object.nm_convenio[1] = ivo_convenio.nm_razao_social
			This.Object.cd_convenio	[1] = ivo_convenio.cd_convenio
			
		End If	
		
	Case "id_tipo_canal"
		If dw_1.GetChild("id_canal_venda", lvdw_Child) > 0 Then
			lvdw_Child.SetTransObject( SQLCa )
			lvdw_Child.SetFilter("isNull(id_tipo_canal) or id_tipo_canal = '"+Data+"'")
			lvdw_Child.Filter()
		End If
		This.Object.id_canal_venda 		[1] = ""
		This.Object.cd_modo_entrega	[1] = ""
		
	Case "id_canal_venda"
		If dw_1.GetChild("cd_modo_entrega", lvdw_Child) > 0 Then
			lvdw_Child.SetTransObject( SQLCa )
			lvdw_Child.SetFilter("isNull(cd_canal_venda) or cd_canal_venda = '"+Data+"'")
			lvdw_Child.Filter()
		End If
		This.Object.cd_modo_entrega [1] = ""
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

If IsValid(ivo_cliente) Then 
	This.Object.nm_cliente [1] = ivo_cliente.nm_cliente
End If

If IsValid(ivo_convenio) Then 
	This.Object.nm_convenio [1] = ivo_convenio.nm_razao_social
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge477_rel_dinamico_dev_vendas_item
integer y = 780
integer width = 4069
integer height = 1012
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Grupo
String lvs_UF_Fil
String lvs_Cliente
String lvs_Lei_Gen
String lvs_Lista_Pis
String lvs_Tipo_Vd
String lvs_Forma_Pagto
String lvs_NCM_Ini
String lvs_NCM_Fim
String lvs_Especie
String lvs_Indice = "idx_dh_movimentacao_caixa"
String lvs_SQL
String lvs_Situacao
String lvs_Area_Vd
String lvs_Tipo_Canal
String lvs_Canal_Vd
String lvs_Modo_Ent

Long lvl_NCM
Long lvl_CFOP
Long lvl_Filial
Long lvl_Produto
Long lvl_Convenio
Long lvl_NF_Venda
Long lvl_NF_Devol

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio			= dw_1.Object.dt_inicio				[1]
lvdt_Fim				= dw_1.Object.dt_fim					[1]
lvl_Filial				= dw_1.Object.cd_filial				[1]
lvl_Convenio			= dw_1.Object.cd_convenio			[1]
lvs_UF_Fil			= dw_1.Object.cd_uf					[1]
lvl_Produto			= dw_1.Object.cd_produto			[1]
lvs_Cliente			= dw_1.Object.cd_cliente			[1]
lvs_Tipo_Vd			= dw_1.Object.id_tipo_venda		[1]
lvs_Forma_Pagto	= dw_1.Object.cd_forma_pagto	[1]
lvl_CFOP				= dw_1.Object.cd_cfop				[1]
lvs_Grupo			= dw_1.Object.cd_grupo				[1]
lvl_NCM				= dw_1.Object.nr_ncm				[1]
lvs_Lista_Pis			= dw_1.Object.id_lista_pis_cofins	[1]
lvs_Lei_Gen			= dw_1.Object.id_lei_generico		[1]
lvs_Especie			= dw_1.Object.de_especie			[1]
lvs_Situacao			= dw_1.Object.id_situacao			[1]
lvs_Area_Vd			= dw_1.Object.id_area_vendas		[1]
lvs_Tipo_Canal		= dw_1.Object.id_tipo_canal		[1]
lvs_Canal_Vd		= dw_1.Object.id_canal_venda		[1]
lvs_Modo_Ent		= dw_1.Object.cd_modo_entrega	[1]
lvl_NF_Venda		= dw_1.Object.nr_nf_venda			[1]
lvl_NF_Devol		= dw_1.Object.nr_nf					[1]

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
	lvs_Indice = "idx_filial_dh_movimento"
	This.Of_AppendWhere("n.cd_filial="+String(lvl_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_filial.nm_fantasia+' ('+String(lvl_Filial)+')'
End If

If Not IsNull(lvl_Convenio) and (lvl_Convenio > 0) Then
	lvs_Indice = "idx_convenio_data"
	This.Of_AppendWhere("n.cd_convenio="+String(lvl_Convenio))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_convenio.nm_razao_social+' ('+String(lvl_Convenio)+')'
End If

If lvs_UF_Fil<>'' Then
	This.Of_AppendWhere("cf.cd_unidade_federacao='"+lvs_UF_Fil+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF Destino: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+lvs_UF_Fil+')'
End If

If lvs_Especie<>'' Then
	This.Of_AppendWhere("n.de_especie_venda='"+lvs_Especie+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Esp$$HEX1$$e900$$ENDHEX$$cie Venda: '+dw_1.Describe("Evaluate('LookUpDisplay(de_especie)',1)")
End If

If lvs_Tipo_Vd<>'' Then
	This.Of_AppendWhere("v.id_tipo_venda='"+lvs_Tipo_Vd+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Tipo Venda: '+dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_venda)',1)")
	
	If lvs_Tipo_Vd = 'CV' Then
		lvs_Indice = "idx_convenio_data"
		This.Of_AppendWhere("n.cd_convenio is not null")
	End If	
End If

If lvs_Forma_Pagto<>'' Then
	This.Of_AppendWhere("v.cd_forma_pagamento='"+lvs_Forma_Pagto+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Forma Pagto: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_forma_pagto)',1)")
End If

If (Not IsNull(lvs_Cliente)) and (Trim(lvs_Cliente)<>'') Then
	lvs_Indice = "idx_cd_cliente"
	This.Of_AppendWhere("n.cd_cliente='"+lvs_Cliente+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Cliente: '+ivo_cliente.nm_cliente+' ('+lvs_Cliente+')'
End If

If Not IsNull(lvl_CFOP) and (lvl_CFOP > 0) Then
	This.Of_AppendWhere("i.cd_natureza_operacao="+String(lvl_CFOP))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'CFOP: '+String(lvl_CFOP)
End If

If lvs_Grupo<>'' Then
	This.Of_AppendWhere("substring(p.cd_subcategoria,1,1)='"+lvs_Grupo+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Grupo Prod.: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_grupo)',1)")
End If

If lvs_Lista_Pis<>'' Then
	This.Of_AppendWhere("p.id_situacao_pis_cofins='"+lvs_Lista_Pis+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lista PIS: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lista_pis_cofins)',1)")
End If

If lvs_Lei_Gen<>'' Then
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

Choose Case lvs_Situacao
	Case 'N'
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = '[ X ] Somente Devolu$$HEX2$$e700f500$$ENDHEX$$es N$$HEX1$$e300$$ENDHEX$$o Canceladas'
		This.Of_AppendWhere("n.dh_cancelamento is null")
	Case 'C'
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = '[ X ] Somente Devolu$$HEX2$$e700f500$$ENDHEX$$es Canceladas'
		This.Of_AppendWhere("n.dh_cancelamento is not null")
End Choose

If lvs_Area_Vd <> "" Then
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Rede: " + dw_1.Describe("Evaluate('LookUpDisplay(id_area_vendas)',1)")
	This.Of_AppendWhere("coalesce(pea.id_rede_ecommerce, f.id_rede_filial) = '" + lvs_Area_Vd + "'")
End If

If lvs_Modo_Ent <> "" Then
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Modo Entrega: " + dw_1.Describe("Evaluate('LookUpDisplay(cd_modo_entrega)',1)")
	This.Of_AppendWhere("pe.nm_transportadora = '" + dw_1.Describe("Evaluate('LookUpDisplay(cd_modo_entrega)',1)") + "'")
End If

If lvl_NF_Venda > 0 Then
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Nota Venda: " + String(lvl_NF_Venda)
	This.Of_AppendWhere("n.nr_nf_venda = " + String(lvl_NF_Venda))
End If

If lvl_NF_Devol > 0 Then
	If lvl_Filial > 0 Then	lvs_Indice = "pk_nf_devolucao_venda"
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Nota Devolu$$HEX2$$e700e300$$ENDHEX$$o: " + String(lvl_NF_Devol)
	This.Of_AppendWhere("n.nr_nf = " + String(lvl_NF_Devol))
End If

If lvs_Tipo_Canal <> "" Then
	This.Of_AppendWhere("cnv.id_tipo_canal = '"+lvs_Tipo_Canal+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Tipo Canal de Venda: " + dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_canal)',1)")
End If

If lvs_Canal_Vd <> "" Then
	If lvs_Canal_Vd = "AP" Then
		This.of_AppendWhere("coalesce(pe.id_ecommerce,'1')='2'") //Todas as vendas VTEX, depois ajustar o filtro quando for poss$$HEX1$$ed00$$ENDHEX$$vel identificar
		This.of_AppendWhere("pe.de_canal_compra_vtex in ('app_android', 'app_ios', 'app_android_n', 'app_ios_n')") 
	Else
		This.Of_AppendWhere("cnv.cd_canal_venda = '"+lvs_Canal_Vd+"'")
		This.of_AppendWhere("coalesce(pe.de_canal_compra_vtex,'') not in ('app_android', 'app_ios', 'app_android_n', 'app_ios_n')") 
	End If
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Canal de Venda: " + dw_1.Describe("Evaluate('LookUpDisplay(id_canal_venda)',1)")
End If

lvs_SQL = This.GetSQLSelect( )
lvs_SQL = gf_replace(lvs_SQL,'from nf_devolucao_venda n ','from nf_devolucao_venda n (index '+lvs_Indice+') ',1)	
This.of_ChangeSQL(lvs_SQL)

lvs_SQL = This.GetSQLSelect( )

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge477_rel_dinamico_dev_vendas_item
integer x = 1865
integer y = 784
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Vendas (Item)"
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge477_rel_dinamico_dev_vendas_item
integer x = 2606
integer y = 712
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge477_rel_dinamico_dev_vendas_item
integer x = 1147
integer y = 1048
end type

