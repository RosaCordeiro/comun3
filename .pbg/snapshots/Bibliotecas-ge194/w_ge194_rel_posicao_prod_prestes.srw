HA$PBExportHeader$w_ge194_rel_posicao_prod_prestes.srw
forward
global type w_ge194_rel_posicao_prod_prestes from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge194_rel_posicao_prod_prestes from dc_w_selecao_lista_dinamica_relatorio
string tag = "w_ge194_rel_posicao_prod_prestes"
integer width = 4539
integer height = 1464
string title = "GE194 - Relat$$HEX1$$f300$$ENDHEX$$rio Posi$$HEX2$$e700e300$$ENDHEX$$o - Produtos Prestes $$HEX1$$e000$$ENDHEX$$ Vencer"
end type
global w_ge194_rel_posicao_prod_prestes w_ge194_rel_posicao_prod_prestes

type variables
uo_filial						ivo_filial				//GE063
uo_usuario				 	ivo_comprador		//GE010
uo_produto					ivo_produto 			//GE001
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

/* Lei Gen$$HEX1$$e900$$ENDHEX$$rico */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			
ldwc_Child.SetItem(1, "id_lei_generico", "T")
ldwc_Child.SetItem(1, "de_lei_generico", "TODOS")
dw_1.Object.id_lei_generico [1] = "T"

/* Subgrupo Produto */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_subgrupo" )			
ldwc_Child.SetItem(1, "cd_grupo", "0")	
ldwc_Child.SetItem(1, "cd_subgrupo", "0")
ldwc_Child.SetItem(1, "de_subgrupo", "TODOS")
dw_1.Object.cd_subgrupo [1] = "0"
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

on w_ge194_rel_posicao_prod_prestes.create
call super::create
end on

on w_ge194_rel_posicao_prod_prestes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivo_produto			= Create uo_produto
ivo_filial				= Create uo_filial
ivo_categoria		= Create uo_categoria
ivo_subcategoria	= Create uo_subcategoria
ivo_comprador		= Create uo_usuario		
ivo_fornecedor		= Create uo_fornecedor

//Dimensionamento de tela
MaxWidth = 4580
MaxHeight = 2000

//SQL Base para formar o grid
ivs_SQLBase = "from produto_preste_a_vencer ppv "										+ &
					"inner join produto_geral pg "												+ &
						"on pg.cd_produto = ppv.cd_produto "								+ &
					"inner join produto_central pc (index pk_produto_central) "			+ &
						"on pc.cd_produto = pg.cd_produto "									+ &
					"inner join grupo gp (index pk_grupo) "									+ &
						"on gp.cd_grupo = substring(pg.cd_subcategoria,1,1) "			+ &
					"inner join subgrupo sgp (index pk_subgrupo) "						+ &
						"on sgp.cd_subgrupo = substring(pg.cd_subcategoria,1,3) "		+ &
					"inner join categoria cp (index pk_categoria) "							+ &
						"on cp.cd_categoria = substring(pg.cd_subcategoria,1,6) "		+ &
					"inner join subcategoria scp (index pk_subcategoria) "				+ &
						"on scp.cd_subcategoria = pg.cd_subcategoria "					+ &
					"inner join filial fi "																+ &
						"on fi.cd_filial = ppv.cd_filial_inclusao "								+ &
					"inner join cidade cfi "														+ &
						"on cfi.cd_cidade = fi.cd_cidade "										+ &
					"inner join produto_uf pu "													+ &		
						"on pu.cd_produto = ppv.cd_produto "								+ &
						"and pu.cd_unidade_federacao = cfi.cd_unidade_federacao "	+ &
					"inner join regiao r "															+ &
						"on r.cd_regiao = fi.cd_regiao "										+ &
					"Inner join saldo_produto sp (index saldo_prod_5850531202) "		+ &
						"On sp.cd_filial = ppv.cd_filial_inclusao "								+ &
						"and sp.cd_produto = ppv.cd_produto "								+ &
						"and sp.dh_saldo = sp.dh_saldo "										+ &
					"Left outer join usuario ur (index pk_usuario)"							+ &	
						"on ur.nr_matricula = r.nr_matricula_regional "					+ &
					"Left Outer join promocao_vencimento pv "								+ &
						"On Cast(pv.nm_promocao as Integer) = Floor(dbo.diffdate( 'month', GetDate(), ppv.dh_validade)) * 30 "+ &
						"And pv.cd_grupo = substring(pg.cd_subcategoria,1,1) "			+ &
						"And (pv.dh_termino is null or pv.dh_termino >= getdate()) "+ &
					"Left Outer join promocao_vencimento pvv "							+ &
						"On Cast(pvv.nm_promocao as Integer) = Floor(dbo.diffdate( 'month', ppv.dh_baixa, ppv.dh_validade)) * 30 "	+ &
						"And pvv.cd_grupo = substring(pg.cd_subcategoria,1,1) "		+ &
					"Left outer join usuario ui (index pk_usuario) "							+ &
						"on ui.nr_matricula = ppv.nr_matricula_inclusao "					+ &
					"Left outer join usuario ub (index pk_usuario) "							+ &	
						"on ub.nr_matricula = ppv.nr_matricula_baixa "					+ &
					"Left outer join filial fv "														+ &
						"on fv.cd_filial = ppv.cd_filial "											+ &
					"Left outer join nf_venda v (index pk_nf_venda) "						+ &
						"on v.cd_filial = ppv.cd_filial "											+ &
						"and v.nr_nf = ppv.nr_nf "												+ &
						"and v.de_especie = ppv.de_especie "								+ &
						"and v.de_serie = ppv.de_serie "										+ &
					"Left outer join item_nf_venda i (index pk_item_nf_venda) "			+ &
						"on i.cd_filial = ppv.cd_filial "											+ &
						"and i.nr_nf = ppv.nr_nf "												+ &
						"and i.de_especie = ppv.de_especie "									+ &
						"and i.de_serie = ppv.de_serie "										+ &
						"and i.cd_produto = ppv.cd_produto "									+ &
						"and i.nr_sequencial = coalesce(ppv.nr_sequencial,i.nr_sequencial) "	+ &
					"Left outer join convenio co (index pk_convenio) "						+ &
						"on co.cd_convenio = v.cd_convenio "								+ &
					"Left outer join conveniado cv (index pk_conveniado) "				+ &
						"on cv.cd_convenio = v.cd_convenio "									+ &
						"and cv.cd_conveniado = v.cd_conveniado "							+ &
					"Left outer join cliente cli (index pk_cliente) "							+ &
						"on cli.cd_cliente = v.cd_cliente "										+ &
					"Left outer join usuario uc (index pk_usuario) "							+ &
						"on uc.nr_matricula = pc.nr_matricula_comprador "				+ &
					"Left outer join fornecedor fp (index pk_fornecedor) "					+ &
						"on fp.cd_fornecedor = pg.cd_fornecedor_usual "

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 13
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_posicao [1] = Today()

wf_insere_padrao()
end event

event close;call super::close;Destroy(ivo_subcategoria)
Destroy(ivo_fornecedor)
Destroy(ivo_comprador)
Destroy(ivo_categoria)
Destroy(ivo_produto)
Destroy(ivo_filial)
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge194_rel_posicao_prod_prestes
integer x = 123
integer y = 2008
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge194_rel_posicao_prod_prestes
integer x = 87
integer y = 1936
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge194_rel_posicao_prod_prestes
integer y = 528
integer width = 4434
integer height = 728
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge194_rel_posicao_prod_prestes
integer width = 4434
integer height = 500
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge194_rel_posicao_prod_prestes
integer width = 4366
integer height = 404
string dataobject = "dw_ge194_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;DatawindowChild ldwc_Child

Choose Case Dwo.Name
	Case 'id_situacao'
		If Data <> 'B' Then This.Object.id_tipo_baixa [Row] = '0'
		
	Case 'id_tipo_baixa'
		If Data <> '0' Then This.Object.id_situacao [Row] = 'B'
		
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
			ivo_produto.Of_Inicializa()
			
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

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge194_rel_posicao_prod_prestes
integer y = 604
integer width = 4366
integer height = 620
string title = "Posi$$HEX2$$e700e300$$ENDHEX$$o Produtos Prestes $$HEX1$$e000$$ENDHEX$$ Vencer"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_SQL
String lvs_Posicao = 'getdate()'
String lvs_Situacao
String lvs_Tipo_Baixa
String lvs_Grupo
String lvs_Subgrupo
String lvs_Categoria
String lvs_Subcategoria
String lvs_Fornecedor
String lvs_Comprador
String lvs_Lei_G
String lvs_Concede_Desc
String lvs_Validade

Date lvdt_Posicao

Long lvl_Regiao
Long lvl_Filial
Long lvl_Produto

dw_1.AcceptText( )
lvdt_Posicao 		= dw_1.Object.dt_posicao			[1]
lvs_Situacao 		= dw_1.Object.id_situacao			[1]
lvs_Tipo_Baixa		= dw_1.Object.id_tipo_baixa		[1]
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
lvs_Concede_Desc	= dw_1.Object.id_concede_desc	[1]
lvs_Validade			= dw_1.Object.id_validade			[1]

lvs_SQL = This.GetSQLSelect()
lvs_SQL = gf_replace(lvs_SQL,"ppv.dh_baixa > GetDate()","ppv.dh_baixa > "+lvs_Posicao,0)
This.Of_ChangeSql(lvs_SQL)

If (Not IsNull(lvdt_Posicao)) and (lvdt_Posicao > Date('2001/01/01')) Then
	/* Altera parametros do Select e From*/
	lvs_SQL = This.GetSQLSelect()
	lvs_Posicao = "'"+String(lvdt_Posicao,'YYYY.MM.DD')+"'"
	lvs_SQL = gf_replace(lvs_SQL,'getdate()',lvs_Posicao,0)
	lvs_SQL = gf_replace(lvs_SQL,'sp.dh_saldo = sp.dh_saldo',"sp.dh_saldo = '"+String(lvdt_Posicao,'YYYY.MM')+".01'",0)
	This.Of_ChangeSql(lvs_SQL)
	
	/*Insere no Where*/
	This.of_AppendWhere("ppv.dh_inclusao <= "+lvs_Posicao)
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Favor informar a data da posi$$HEX2$$e700e300$$ENDHEX$$o para emiss$$HEX1$$e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio!',Exclamation!)
	dw_1.Event ue_Pos(1,'dt_posicao')
	Return -1
End If

ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Posi$$HEX2$$e700e300$$ENDHEX$$o: '+String(lvdt_Posicao,'DD/MM/YYYY')

/* Situa$$HEX2$$e700e300$$ENDHEX$$o Etiqueta */
Choose Case lvs_Situacao
	Case 'A'
		This.of_AppendWhere("((ppv.dh_baixa is null) or ( ppv.dh_baixa >"+lvs_Posicao+"))")	
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Situa$$HEX2$$e700e300$$ENDHEX$$o Etiqueta: ATIVA'
	Case 'B'
		This.of_AppendWhere("ppv.dh_baixa <= "+lvs_Posicao)	
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Situa$$HEX2$$e700e300$$ENDHEX$$o Etiqueta: BAIXADA'
End Choose

/* Situa$$HEX2$$e700e300$$ENDHEX$$o Validade */
If lvs_Validade <> 'T' Then
	Choose Case lvs_Validade
		Case 'N'
			This.of_AppendWhere("Floor(dbo.diffdate( 'month', "+lvs_Posicao+", ppv.dh_validade)) > 3")
		Case 'P'
			This.of_AppendWhere("Floor(dbo.diffdate( 'month', "+lvs_Posicao+", ppv.dh_validade)) <= 3")
			This.of_AppendWhere("Floor(dbo.diffdate( 'month', "+lvs_Posicao+", ppv.dh_validade)) > 0")
		Case 'V'
			This.of_AppendWhere("ppv.dh_validade < "+lvs_Posicao)	
	End Choose
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Validade: '+dw_1.Describe("Evaluate('LookUpDisplay(id_validade)',1)")
End If

If lvs_Tipo_Baixa <> '0'  Then
	This.of_AppendWhere("((ppv.id_tipo_baixa = '"+lvs_Tipo_Baixa+"') and (ppv.dh_baixa <= "+lvs_Posicao+"))")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Tipo Baixa: '+dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_baixa)',1)")
End If

If (Not IsNull(lvl_Produto)) and (lvl_Produto > 0) Then
	This.of_AppendWhere("ppv.cd_produto = "+String(lvl_Produto))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Produto: '+dw_1.Object.de_produto [1]+' ('+String(lvl_Produto)+')'
ElseIf (Not IsNull(lvs_Subcategoria)) and (lvs_Subcategoria <> '')  Then
	This.of_AppendWhere("pg.cd_subcategoria = '"+lvs_Subcategoria+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Subcategoria: '+ivo_subcategoria.de_subcategoria
ElseIf (Not IsNull(lvs_Categoria)) and (lvs_Categoria <> '')  Then
	This.of_AppendWhere("substring(pg.cd_subcategoria,1,6) = '"+lvs_Categoria+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Categoria: '+ivo_categoria.de_categoria
ElseIf lvs_Subgrupo <> '0'  Then
	This.of_AppendWhere("substring(pg.cd_subcategoria,1,3) = '"+lvs_Subgrupo+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Subgrupo: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_subgrupo)',1)")
ElseIf lvs_Grupo <> '0'  Then
	This.of_AppendWhere("substring(pg.cd_subcategoria,1,1) = '"+lvs_Grupo+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Grupo: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_grupo)',1)")
End If

If lvs_Lei_G <> 'T'  Then
	This.of_AppendWhere("pg.id_lei_generico = '"+lvs_Lei_G+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lei Gen$$HEX1$$e900$$ENDHEX$$rico: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lei_generico)',1)")
End If

If lvs_Concede_Desc <> 'T'  Then
	This.of_AppendWhere("coalesce(ppv.id_concede_desconto,'S') = '"+lvs_Concede_Desc+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Concede Desconto: SIM'
End If

If (Not IsNull(lvs_Comprador)) and (lvs_Comprador <> '')  Then
	This.of_AppendWhere("pc.nr_matricula_comprador = '"+lvs_Comprador+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Comprador: '+ivo_comprador.nm_usuario+' ('+lvs_Comprador+')'
End If

If (Not IsNull(lvs_Fornecedor)) and (lvs_Fornecedor <> '')  Then
	This.of_AppendWhere("pg.cd_fornecedor_usual = '"+lvs_Fornecedor+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Fornecedor: '+ivo_fornecedor.nm_razao_social+' ('+lvs_Fornecedor+')'
End If

If (Not IsNull(lvl_Regiao)) and (lvl_Regiao > 0) Then
	This.of_AppendWhere("fi.cd_regiao = "+String(lvl_Regiao))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Regi$$HEX1$$e300$$ENDHEX$$o: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_regiao)',1)")
End If

If (Not IsNull(lvl_Filial)) and (lvl_Filial > 0) Then
	This.of_AppendWhere("ppv.cd_filial_inclusao = "+String(lvl_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_filial.nm_fantasia+' ('+String(lvl_Filial)+')'
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge194_rel_posicao_prod_prestes
integer x = 2021
integer y = 908
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge194_rel_posicao_prod_prestes
integer x = 2021
integer y = 604
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge194_rel_posicao_prod_prestes
end type

