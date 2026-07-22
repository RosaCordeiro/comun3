HA$PBExportHeader$w_ge400_cadastro_produto.srw
forward
global type w_ge400_cadastro_produto from dc_w_sheet
end type
type dw_13 from dc_uo_dw_base within w_ge400_cadastro_produto
end type
type st_1 from statictext within w_ge400_cadastro_produto
end type
type tab_1 from tab within w_ge400_cadastro_produto
end type
type tabpage_1 from userobject within tab_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_1 gb_1
dw_1 dw_1
end type
type tabpage_6 from userobject within tab_1
end type
type gb_12 from groupbox within tabpage_6
end type
type dw_12 from dc_uo_dw_base within tabpage_6
end type
type tabpage_6 from userobject within tab_1
gb_12 gb_12
dw_12 dw_12
end type
type tabpage_5 from userobject within tab_1
end type
type gb_10 from groupbox within tabpage_5
end type
type dw_10 from dc_uo_dw_base within tabpage_5
end type
type tabpage_5 from userobject within tab_1
gb_10 gb_10
dw_10 dw_10
end type
type tabpage_2 from userobject within tab_1
end type
type gb_8 from groupbox within tabpage_2
end type
type gb_4 from groupbox within tabpage_2
end type
type gb_14 from groupbox within tabpage_2
end type
type gb_13 from groupbox within tabpage_2
end type
type pb_1 from picturebutton within tabpage_2
end type
type dw_7 from dc_uo_dw_base within tabpage_2
end type
type dw_8 from dc_uo_dw_base within tabpage_2
end type
type dw_9 from dc_uo_dw_base within tabpage_2
end type
type dw_14 from dc_uo_dw_base within tabpage_2
end type
type dw_2 from dc_uo_dw_base within tabpage_2
end type
type cb_replica_reposicao from commandbutton within tabpage_2
end type
type cb_replica_venda from commandbutton within tabpage_2
end type
type cb_preco_legado from commandbutton within tabpage_2
end type
type dw_18 from dc_uo_dw_base within tabpage_2
end type
type gb_16 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_8 gb_8
gb_4 gb_4
gb_14 gb_14
gb_13 gb_13
pb_1 pb_1
dw_7 dw_7
dw_8 dw_8
dw_9 dw_9
dw_14 dw_14
dw_2 dw_2
cb_replica_reposicao cb_replica_reposicao
cb_replica_venda cb_replica_venda
cb_preco_legado cb_preco_legado
dw_18 dw_18
gb_16 gb_16
end type
type tabpage_3 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_3
end type
type gb_7 from groupbox within tabpage_3
end type
type gb_6 from groupbox within tabpage_3
end type
type gb_5 from groupbox within tabpage_3
end type
type dw_3 from dc_uo_dw_base within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type dw_5 from dc_uo_dw_base within tabpage_3
end type
type cbx_mostra_produtos_planograma from checkbox within tabpage_3
end type
type dw_16 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_2 gb_2
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
cbx_mostra_produtos_planograma cbx_mostra_produtos_planograma
dw_16 dw_16
end type
type tabpage_4 from userobject within tab_1
end type
type gb_11 from groupbox within tabpage_4
end type
type gb_3 from groupbox within tabpage_4
end type
type dw_6 from dc_uo_dw_base within tabpage_4
end type
type dw_15 from dc_uo_dw_base within tabpage_4
end type
type dw_17 from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_1
gb_11 gb_11
gb_3 gb_3
dw_6 dw_6
dw_15 dw_15
dw_17 dw_17
end type
type tabpage_7 from userobject within tab_1
end type
type dw_19 from dc_uo_dw_base within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_19 dw_19
end type
type tab_1 from tab within w_ge400_cadastro_produto
tabpage_1 tabpage_1
tabpage_6 tabpage_6
tabpage_5 tabpage_5
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_7 tabpage_7
end type
type gb_15 from groupbox within w_ge400_cadastro_produto
end type
end forward

global type w_ge400_cadastro_produto from dc_w_sheet
integer width = 3762
integer height = 2876
string title = "GE400 - Cadastro de Produtos"
string menuname = ""
boolean resizable = false
long backcolor = 80269524
event ue_consulta_substancia ( )
dw_13 dw_13
st_1 st_1
tab_1 tab_1
gb_15 gb_15
end type
global w_ge400_cadastro_produto w_ge400_cadastro_produto

type variables
uo_produto 							ivo_produto						//GE001
uo_fornecedor 						ivo_fornecedor					//GE003
uo_fabricante 						ivo_fabricante					//GE087
uo_produto_abcfarma 			ivo_produto_abcfarma 		//GE011
uo_classificacao_produto 		ivo_classificacao 				//GE022
uo_dcb 								ivo_dcb 							//GE061
uo_grupo_alteracao_preco		ivo_grupo_alteracao_preco  //GE209
uo_ge228_marca_produto 		ivo_marca_produto			//GE228
uo_ge220_tributacao_produto	ivo_tributacao					//GE220
uo_ge199_Marca_Ecommerce	io_Marca_Ecommerce		//GE199
uo_ge216_filiais					io_filiais							//GE216
uo_ge149_comprador				io_Comprador					//GE149

Boolean ivb_produto_novo
Boolean ivb_Possui_Permissao = False
Boolean ib_Permite_Alter_Cutover = True
Boolean ib_Permite_Alterar_Preco

DateTime ivdh_parametro

Long ivl_produto_busca_facil
Long il_Pbm = 0

String ivs_path_fotos_ecommerce
String ivs_path_fotos_categoria
String is_Mensagem_Motivo_Situacao = "INFORME O MOTIVO PELO QUAL A SITUA$$HEX2$$c700c300$$ENDHEX$$O FOI ALTERADA..."
String is_Nm_Pbm = ""
String is_Filiais = ""
String is_Dw_Geral[]
String is_Dw_Subs[]
String is_Dw_Fiscal_Pre[]
String is_Dw_Fiscal_Pre_dw2[] //dw_2

String is_usa_lista_tecnica
end variables

forward prototypes
public subroutine wf_atualiza_fornecedor ()
public subroutine wf_atualiza_produto_abcfarma ()
public function boolean wf_produto_abcfarma_cadastrado (long pl_produto_abcfarma)
public function boolean wf_codigo_barras_duplicado ()
public subroutine wf_atualiza_sequencial_produto ()
public subroutine wf_inclui_grupo_psico_nulo ()
public subroutine wf_inclui_linha_nula ()
public subroutine wf_atualiza_classificacao ()
public function boolean wf_valida_campos ()
public subroutine wf_campo_not_null (string ps_mensagem, dc_uo_dw_base pdw_datawindow, string ps_campo, integer pi_tabpage)
public function boolean wf_valida_desc_clube_futuro ()
public subroutine wf_verifica_uf_ativa ()
public function boolean wf_valida_cadastro_uf ()
public subroutine wf_atualiza_fabricante ()
public subroutine wf_atualiza_dcb ()
public function boolean wf_atualiza_sequencial_produto (ref long al_produto)
public function boolean wf_inclui_produto_geral (long al_produto_atual, long al_produto_novo)
public function boolean wf_inclui_produto_uf (long al_produto_atual, long al_produto_novo)
public function boolean wf_inclui_comissao_produto (long al_produto_atual, long al_produto_novo)
public subroutine wf_localiza_niveis_categoria (long al_categoria, ref string as_niveis)
public subroutine wf_localiza_path_fotos ()
public function boolean wf_localiza_foto (long al_produto, string as_tipo)
public function boolean wf_localiza_categoria (long al_categoria, ref string as_categoria)
public function boolean wf_inclui_promocao_produto_novo (long al_produto)
public function boolean wf_consulta_produto (long al_produto, ref string as_grupo, ref string as_lei_generico)
public function boolean wf_preco_atual (long al_produto, ref decimal adc_valor, string as_uf)
public subroutine wf_atualiza_grupo_alteracao_preco ()
public subroutine wf_inclui_planograma_nulo ()
protected function boolean wf_inclui_produto_central (long al_produto_atual, long al_produto_novo)
public function boolean wf_valida_substancias ()
public function Boolean wf_localiza_dcb (string as_parametro)
public function Boolean wf_localiza_fabricante (string ps_parametro)
public function Boolean wf_localiza_fornecedor (string ps_parametro)
public function Boolean wf_localiza_classificacao (string as_parametro)
public function Boolean wf_localiza_grupo_alteracao_preco (string ps_parametro)
public function Boolean wf_localiza_produto_abcfarma (string ps_parametro, boolean pb_verificar)
public function boolean wf_fornecedor_conexao (string ps_fornecedor, ref string ps_projeto, ref string ps_descricao)
public subroutine wf_atualiza_divisao_fornecedor (string as_fornecedor, long al_produto)
public subroutine wf_lista_divisao_fornecedor ()
public subroutine wf_inclui_divisao_fornecedor_nulo ()
public subroutine wf_exclui_divisao_fornecedor_dw ()
public function boolean wf_exclui_divisao_fornecedor ()
public function boolean wf_produto_dw13 ()
public function boolean wf_valida_divisao_fornecedor ()
public function boolean wf_atualiza_tributacao_ncm (long al_ncm, ref string as_ncm, ref decimal adc_perc_ipi, ref string as_lista_pis_cofins)
public function boolean wf_valida_tributacao_ncm ()
public function boolean wf_verifica_pbm ()
public function boolean wf_valida_est_min_pbm ()
public subroutine wf_atalhos (keycode as_tecla)
public subroutine wf_set_somente_consulta ()
public function boolean wf_grava_historico_aba_geral ()
public function boolean wf_grava_historico_aba_substancias ()
public function boolean wf_grava_historico_aba_ecommerce ()
public function boolean wf_grava_historico_aba_fiscal_pricing ()
public function boolean wf_grava_historico_preco_uf ()
public function boolean wf_grava_historico_comissao ()
public function boolean wf_grava_historico_aba_estoque ()
public function boolean wf_grava_historico_ean ()
public function boolean wf_verifica_alteracao_controlado ()
public function boolean wf_inclui_produto_aprovacao (long al_produto, string as_tipo)
public function boolean wf_verifica_alteracao_ncm_lei_gene (long al_produto, ref boolean ab_alterado)
public subroutine wf_verifica_produto_abcfarma ()
public function boolean wf_verifica_permissao ()
public subroutine wf_inclui_prescricao_nula ()
public subroutine wf_inclui_alerta_restricao_nulo ()
public function boolean wf_valida_codigo_barras ()
public subroutine wf_verifica_atualizaco_custo (string as_subcategoria)
public function boolean wf_grava_historico_alteracao (string as_tabela, string as_chave, string as_coluna, string as_de, string as_operador, string as_tipo_alteracao)
public function boolean wf_verifica_uf_atendimento (string as_uf, ref string as_uf_situacao)
end prototypes

event ue_consulta_substancia();w_ge401_cadastro_substancias lvw

OpenSheetWithParm(lvw, '', This, 0, Original!)
end event

public subroutine wf_atualiza_fornecedor ();Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor_Usual	[1] = ivo_Fornecedor.Cd_Fornecedor
Tab_1.TabPage_1.dw_1.Object.Nm_Fornecedor			[1] = ivo_Fornecedor.Nm_Razao_Social

If ivo_Fornecedor.id_Situacao = "I" Then
	Tab_1.TabPage_1.dw_1.Object.fornecedor_inativo_t.Visible = 1
Else
	Tab_1.TabPage_1.dw_1.Object.fornecedor_inativo_t.Visible = 0
End If
end subroutine

public subroutine wf_atualiza_produto_abcfarma ();Tab_1.TabPage_2.dw_2.SetRedraw(False)

Tab_1.TabPage_2.dw_2.Object.Cd_Produto_ABCFarma     		[1] = ivo_Produto_ABCFarma.Cd_Produto_ABCFarma
Tab_1.TabPage_2.dw_2.Object.De_Produto_ABCFarma     		[1] = ivo_Produto_ABCFarma.De_Produto
Tab_1.TabPage_2.dw_2.Object.De_Apresentacao_ABCFarma	[1] = ivo_Produto_ABCFarma.De_Apresentacao
//Tab_1.TabPage_2.dw_2.Object.Id_Controle_Preco				[1] = ivo_Produto_ABCFarma.De_ControlePreco
If dec(Tab_1.TabPage_2.dw_14.Object.vl_preco_venda_maximo_sap[1]) > 0 Then
	Tab_1.TabPage_2.dw_2.Object.Id_Controle_Preco			[1] = "M"
Else
	Tab_1.TabPage_2.dw_2.Object.Id_Controle_Preco			[1] = ""
End If
Tab_1.TabPage_2.dw_2.Object.nm_fabricante_abc_farma		[1] = ivo_Produto_ABCFarma.De_Fabricante

Tab_1.TabPage_2.dw_2.SetRedraw(True)

end subroutine

public function boolean wf_produto_abcfarma_cadastrado (long pl_produto_abcfarma);String lvs_Descricao, &
       lvs_Apresentacao
		  
Long lvl_Produto, &
     lvl_Produto_Localizado
		  
Boolean lvb_Cadastrado

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then 
	Select pg.cd_produto,
	       pg.de_produto, 
	       pg.de_apresentacao_venda
	Into :lvl_Produto_Localizado, 
	     :lvs_Descricao,
	     :lvs_Apresentacao 		  
	From produto_geral pg,
	     produto_central pc
	Where pg.cd_produto          = pc.cd_produto
	  and pc.cd_produto_abcfarma = :pl_Produto_ABCFarma
	  and pc.cd_produto         <> :lvl_Produto
	Using SqlCa;
Else
	Select pg.cd_produto,
	       pg.de_produto, 
	       pg.de_apresentacao_venda
	Into :lvl_Produto_Localizado, 
	     :lvs_Descricao,
	     :lvs_Apresentacao 		  
	From produto_geral pg,
	     produto_central pc
	Where pg.cd_produto          = pc.cd_produto
	  and pc.cd_produto_abcfarma = :pl_Produto_ABCFarma
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto ABCFarma j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ vinculado ao produto '" + & 
									 String(lvl_Produto_Localizado) + "', " + Trim(lvs_Descricao) + " : " + &
									 Trim(lvs_Apresentacao), Information!)
		lvb_Cadastrado = True
	Case 100
		lvb_Cadastrado = False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto ABCFarma")
		lvb_Cadastrado = True
End Choose

Return lvb_Cadastrado
end function

public function boolean wf_codigo_barras_duplicado ();Boolean lvb_Retorno

Long lvl_Produto_Localizado, &
     lvl_Produto_Atual

String lvs_Codigo_Barras, &
       lvs_Nulo

lvs_Codigo_Barras = Tab_1.TabPage_1.dw_1.Object.De_Codigo_Barras  [1]
lvl_Produto_Atual = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Trim(lvs_Codigo_Barras) = "" or IsNull(lvs_Codigo_Barras) Then
	SetNull(lvs_Nulo)
	Tab_1.TabPage_1.dw_1.Object.De_Codigo_Barras[1] = lvs_Nulo
	lvb_Retorno = False	
Else
	Select cd_produto Into :lvl_Produto_Localizado
	From produto_geral
	Where de_codigo_barras = :lvs_Codigo_Barras;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(lvl_Produto_Atual) Then
				lvb_Retorno = True
			Else
				If lvl_Produto_Localizado <> lvl_Produto_Atual Then 
					lvb_Retorno = True
				Else
					lvb_Retorno = False
				End If
			End If
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o de duplicidade do c$$HEX1$$f300$$ENDHEX$$digo de barras." + SqlCa.SqlErrText, StopSign!, Ok!)
			lvb_Retorno = True
		Case 100
			lvb_Retorno = False			
	End Choose
End If

If lvb_Retorno Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo de barras '" + lvs_Codigo_Barras + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado para o produto '" + String(lvl_Produto_Localizado) + "'.", StopSign!, Ok!)
	Tab_1.SelectTab(1)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_codigo_barras")
End If

Return lvb_Retorno
end function

public subroutine wf_atualiza_sequencial_produto ();Long lvl_Produto

Tab_1.TabPage_1.dw_1.AcceptText()

If Tab_1.TabPage_1.dw_1.GetItemStatus(1, 0, Primary!) = NewModified! Then
	Select max(cd_produto) Into :lvl_Produto
   From produto_geral
	Where cd_produto < 900000
	Using SqlCa;

	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(lvl_Produto) Then
				lvl_Produto = 1
			Else
				lvl_Produto += 1
			End If
			
			Tab_1.Tabpage_1.dw_1.Object.Cd_Produto_Geral[1]   = lvl_Produto
			Tab_1.Tabpage_1.dw_1.Object.Cd_Produto_Central[1] = lvl_Produto
			
			ivb_Produto_Novo = True
		Case -1
			SqlCa.of_MsgdbError("Determina$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo do produto")
	End Choose
End If
end subroutine

public subroutine wf_inclui_grupo_psico_nulo ();Integer lvi_Retorno, &
        lvi_Linha

String lvs_Nulo

DataWindowChild lvdwc

SetNull(lvs_Nulo)

lvi_Retorno = Tab_1.TabPage_1.dw_1.GetChild("cd_grupo_psico", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_grupo_psico", lvs_Nulo)
		lvdwc.SetItem(lvi_Linha, "de_grupo_psico", "NENHUM")
		
		Tab_1.TabPage_1.dw_1.Object.Cd_Grupo_Psico[1] = lvs_Nulo
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do grupo psico nulo.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do grupo psico.", StopSign!)
End If
end subroutine

public subroutine wf_inclui_linha_nula ();Integer lvi_Retorno, &
        lvi_Linha

String lvs_Nulo

DataWindowChild lvdwc

SetNull(lvs_Nulo)

lvi_Retorno = Tab_1.TabPage_1.dw_1.GetChild("cd_linha_produto", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_linha_produto", lvs_Nulo)
		lvdwc.SetItem(lvi_Linha, "de_linha_produto", "NENHUMA")
		
		Tab_1.TabPage_1.dw_1.Object.Cd_Linha_Produto[1] = lvs_Nulo
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da linha nula.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da linha.", StopSign!)
End If

end subroutine

public subroutine wf_atualiza_classificacao ();Tab_1.TabPage_1.dw_1.Object.Cd_SubCategoria	[1] = ivo_Classificacao.Cd_SubCategoria
Tab_1.TabPage_1.dw_1.Object.De_Grupo       		[1] = ivo_Classificacao.De_Grupo
Tab_1.TabPage_1.dw_1.Object.De_SubGrupo    		[1] = ivo_Classificacao.De_SubGrupo
Tab_1.TabPage_1.dw_1.Object.De_Categoria  	 	[1] = ivo_Classificacao.De_Categoria
Tab_1.TabPage_1.dw_1.Object.De_SubCategoria	[1] = ivo_Classificacao.De_SubCategoria

//Localiza e atualiza Grupo Antigo
Tab_1.TabPage_1.dw_1.Object.cd_grupo_produto			[1] = ivo_Classificacao.cd_grupo_antigo
Tab_1.TabPage_1.dw_1.Object.cd_subgrupo_produto	[1] = 1

wf_verifica_atualizaco_custo(ivo_Classificacao.Cd_SubCategoria)


end subroutine

public function boolean wf_valida_campos ();DateTime lvdh_Dh

Decimal	lvdc_Concentracao, &
			lvdc_Volume, &
			lvdc_Largura, &
			lvdc_Altura, &
			lvdc_Profundidade, &
			lvdc_Peso, &
			lvdc_Altura_CD, &
			lvdc_Largura_CD, &
			lvdc_Profundidade_CD, &
			lvdc_Peso_Apres
			
Long	lvl_Qtde_Embalagem, &
		lvl_Fabricante, &
		lvl_Principal, &
		ll_Fator_Conversao, lvl_categoria

String	lvs_Valor, &
		lvs_Grupo_Psico, &
		lvs_Tipo_Apresentacao, &
		lvs_Liberado_Ecommerce, &
		lvs_DCB, &
		ls_Nulo, &
		ls_Matric_Solici, &
		ls_Situacao, &
		ls_Sit_Anterior, &
		ls_Motivo_Situacao, &
		ls_Tipo_Calc_Pre

dc_uo_DW_Base lvdw_1, lvdw_2, lvdw_10, lvdw_15, lvdw_19

lvdw_1 	= Tab_1.TabPage_1.dw_1
lvdw_2 	= Tab_1.TabPage_2.dw_2
lvdw_10 = Tab_1.TabPage_5.dw_10
lvdw_15 = Tab_1.TabPage_4.dw_15
lvdw_19 = Tab_1.TabPage_7.dw_19

lvdw_1.AcceptText()
lvdw_2.AcceptText()
lvdw_10.AcceptText()
lvdw_15.AcceptText()
lvdw_19.AcceptText()

lvs_Valor = lvdw_1.Object.De_Produto[1]

If IsNull(lvs_Valor) Or lvs_Valor = "" Then
	wf_Campo_Not_Null("DESCRI$$HEX2$$c700c300$$ENDHEX$$O", lvdw_1, "de_produto", 1)
	Return False
End If

lvs_Valor = lvdw_1.Object.De_Apresentacao_Estoque[1]

If IsNull(lvs_Valor) Or lvs_Valor = "" Then
	wf_Campo_Not_Null("APRESENTA$$HEX2$$c700c300$$ENDHEX$$O DE COMPRA", lvdw_1, "de_apresentacao_estoque", 1)
	Return False
End If

lvs_Valor = lvdw_1.Object.De_Apresentacao_Venda[1]

If IsNull(lvs_Valor) Or lvs_Valor = "" Then
	wf_Campo_Not_Null("APRESENTA$$HEX2$$c700c300$$ENDHEX$$O DE VENDA", lvdw_1, "de_apresentacao_venda", 1)
	Return False
End If

lvs_Valor = lvdw_1.Object.Cd_Fornecedor_Usual[1]

If IsNull(lvs_Valor) Or lvs_Valor = "" Then
	wf_Campo_Not_Null("FORNECEDOR USUAL", lvdw_1, "nm_fornecedor", 1)
	Return False
End If

If ivo_fornecedor.id_Situacao = 'I' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Fornecedor inativo. Selecione outro fornecedor.")
	Tab_1.SelectTab(1)
	lvdw_1.Event ue_Pos(1, "nm_fornecedor")	
	Return False
End If

//Verifica se a subcategoria $$HEX1$$e900$$ENDHEX$$ da integra$$HEX2$$e700e300$$ENDHEX$$o do SAP
lvs_Valor = lvdw_1.Object.cd_subcategoria[1]

If lvs_Valor = "901001001" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Altere a subcategoria.~rEssa subcategoria $$HEX1$$e900$$ENDHEX$$ utilizada apenas na integra$$HEX2$$e700e300$$ENDHEX$$o com o SAP.")
	Tab_1.SelectTab(1)
	lvdw_1.Event ue_Pos(1, "de_subcategoria")
	
//	lvdw_1.Object.id_liberado_filial[1] = "S"	//Quando o produto vem do SAP, vem com o valor 'N' ao trocar a subcategoria muda para 'S'
	
	Return False
End If

lvs_Valor = lvdw_1.Object.Cd_Unidade_Medida_Compra[1]

If IsNull(lvs_Valor) Or lvs_Valor = "" Then
	wf_Campo_Not_Null("UNIDADE DE COMPRA", lvdw_1, "cd_unidade_medida_compra", 1)
	Return False
End If

lvs_Valor = lvdw_1.Object.Cd_Unidade_Medida_Venda[1]

If IsNull(lvs_Valor) Or lvs_Valor = "" Then
	wf_Campo_Not_Null("UNIDADE DE VENDA", lvdw_1, "cd_unidade_medida_venda", 1)
	Return False
End If

lvs_Valor = lvdw_1.Object.De_Subcategoria[1]

If IsNull(lvs_Valor) Or lvs_Valor = "" Then
	wf_Campo_Not_Null("SUBCATEGORIA", lvdw_1, "de_subcategoria", 1)
	Return False
End If

//Cleser
lvs_Valor = String(lvdw_1.Object.cd_produto_central[1] ) //Cadastrando Produto novo
If IsNull(lvs_Valor) Then
	
	//ENVIAR EMAIL FLUXO CADASTRO PRODUTO
	
	lvs_Valor = Mid(String(lvdw_1.Object.cd_subcategoria[1]), 1, 1)
	If lvs_Valor = "1" Then //Se $$HEX1$$e900$$ENDHEX$$ medicamento
		
		lvs_Valor = lvdw_1.Object.id_apresentacao[1]	
		If IsNull(lvs_Valor) Or lvs_Valor = "00" Then
			wf_Campo_Not_Null("TIPO DE APRESENTA$$HEX2$$c700c300$$ENDHEX$$O", lvdw_1, "id_apresentacao", 1)
			Return False
		End If
		
		lvs_Valor = String(lvdw_1.Object.qt_concentracao[1])		
		If IsNull(lvs_Valor) Or lvs_Valor = "" Then
			wf_Campo_Not_Null("CONCENTRA$$HEX2$$c700c300$$ENDHEX$$O", lvdw_1, "qt_concentracao", 1)
			Return False
		End If			
		
	End If
End If

lvs_Valor = Mid(String(lvdw_1.Object.cd_subcategoria[1]), 1, 1)

If lvs_Valor <> '5' Then
	
	ls_Matric_Solici = lvdw_1.Object.nr_matric_solicitacao_alt_sit[1]
	ls_Motivo_Situacao = lvdw_1.Object.De_Alteracao_Situacao[1]
	ls_Situacao = lvdw_1.Object.Id_Situacao[1]
	ls_Sit_Anterior = lvdw_1.Object.Id_Situacao_Anterior[1]
	
	If ls_Situacao <> ls_Sit_Anterior Then
		If IsNull(ls_Matric_Solici) Then
			wf_Campo_Not_Null("SOLICITADO POR", lvdw_1, "nm_usuario", 1)
			Tab_1.SelectTab(1)
			lvdw_1.Event ue_Pos(1, "nm_usuario")
			Return False
		End If
	End If
	
	If ls_Motivo_Situacao = is_Mensagem_Motivo_Situacao Then
		wf_Campo_Not_Null("MOTIVO ALTERA$$HEX2$$c700c300$$ENDHEX$$O", lvdw_1, "de_alteracao_situacao", 1)
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo da altera$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o.")
		Tab_1.SelectTab(1)
		lvdw_1.Event ue_Pos(1, "de_alteracao_situacao")		
		Return False
	End If
	
//	If Len(Trim(ls_Motivo_Situacao)) < 5 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos 5 caract$$HEX1$$e900$$ENDHEX$$res no motivo altera$$HEX2$$e700e300$$ENDHEX$$o.")
//		Tab_1.SelectTab(1)
//		lvdw_1.Event ue_Pos(1, "de_alteracao_situacao")
//		Return False
//	End If
End If

lvl_Qtde_Embalagem		= lvdw_1.Object.Qt_Unidades_Embalagem	[1]
lvdc_Volume           		= lvdw_1.Object.Vl_Volume            			[1]
lvdc_Peso_Apres			= lvdw_1.Object.Qt_Peso_Apresentacao		[1]

If lvs_Valor <> "5" And lvs_Valor <> "6" And lvs_Valor <> "7" Then
	ls_Tipo_Calc_Pre = lvdw_1.Object.Id_Tipo_Un_Calc_Preco[1]

	//Comentado por solicita$$HEX2$$e700e300$$ENDHEX$$o da Liege e Rafael Paz, at$$HEX1$$e900$$ENDHEX$$ que seja alinhado como funcionar$$HEX1$$e100$$ENDHEX$$ a precifica$$HEX2$$e700e300$$ENDHEX$$o.
//	If IsNull(ls_Tipo_Calc_Pre) Or ls_Tipo_Calc_Pre = "" Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a unidade de c$$HEX1$$e100$$ENDHEX$$lculo de pre$$HEX1$$e700$$ENDHEX$$o.")
//		Tab_1.SelectTab(1)
//		lvdw_1.Event ue_Pos(1, "id_tipo_un_calc_preco")
//		Return False
//	End If
	
	//Quantidade
	If ls_Tipo_Calc_Pre = "Q" Then
		If IsNull(lvl_Qtde_Embalagem) Or lvl_Qtde_Embalagem = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a unidade da embalagem.")
			Tab_1.SelectTab(1)
			lvdw_1.Event ue_Pos(1, "qt_unidades_embalagem")
			Return False
		End If
	End If
	
	//Peso
	If ls_Tipo_Calc_Pre = "P" Then
		If IsNull(lvdc_Peso_Apres) Or lvdc_Peso_Apres = 0.00 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o peso do produto.")
			Tab_1.SelectTab(1)
			lvdw_1.Event ue_Pos(1, "qt_peso_apresentacao")
			Return False
		End If
	End If

	//Volume
	If ls_Tipo_Calc_Pre = "V" Then
		If IsNull(lvdc_Volume) Or lvdc_Volume = 0.00 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o volume do produto.")
			Tab_1.SelectTab(1)
			lvdw_1.Event ue_Pos(1, "vl_volume")
			Return False
		End If
	End If
End If

lvs_Valor = String(lvdw_1.Object.id_Lei_Generico[1])

If lvs_Valor = 'N' or IsNull(lvs_Valor) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Lei Gen$$HEX1$$e900$$ENDHEX$$ricos - Selecione uma op$$HEX2$$e700e300$$ENDHEX$$o da lista.")
	Tab_1.SelectTab(1)
	lvdw_1.Event ue_Pos(1, "id_Lei_Generico")		
	Return False		
End If

lvs_Valor = String(lvdw_2.Object.Nr_Classificacao_Fiscal[1])

If IsNull(lvs_Valor) Or lvs_Valor = "" Then
	wf_Campo_Not_Null("CLASSIF. FISCAL (NCM)", lvdw_2, "nr_classificacao_fiscal", 4)
	Return False
End If

lvdw_2.Object.Cd_Origem_Produto[1] = '0'

lvs_Valor = lvdw_2.Object.cd_st_origem [1]

If IsNull( lvs_Valor ) Then
	wf_Campo_Not_Null("ORIGEM DO PRODUTO", lvdw_2, "cd_st_origem", 4)
	Return False
End If

lvs_Valor = String(lvdw_2.Object.Pc_Desconto_Clube_Futuro[1])

If Dec(lvs_Valor) <> 0 Then
	
	If Dec(lvs_Valor) = lvdw_2.Object.Pc_Desconto_Clube_Atual[1] Then
		wf_Campo_Not_Null("O percentual de desconto clube futuro deve ser diferente do atual.", lvdw_2, "pc_desconto_clube_futuro", 3)
		Return False
	End If
	
	lvdh_Dh = lvdw_2.Object.Dh_Desconto_Clube_Futuro[1]
	
	If (lvdh_Dh <= ivdh_Parametro) Or IsNull(lvdh_Dh) Then
		wf_Campo_Not_Null("A data de desconto clube futuro deve ser maior que a data atual.", lvdw_2, "dh_desconto_clube_futuro", 3)
		Return False
	End If	
End If

lvs_Valor = lvdw_2.Object.Id_Caderno_AbcFarma[1]

If lvs_Valor = "S" Then
//	lvs_Valor = String(lvdw_2.Object.Cd_Produto_ABCFarma[1])
//	
//	If IsNull(lvs_Valor) Or Long(lvs_Valor) = 0 Then
//		wf_Campo_Not_Null("Informe o c$$HEX1$$f300$$ENDHEX$$digo do produto no caderno ABC Farma.", lvdw_2, "de_produto_abcfarma", 1)
//		Tab_1.SelectTab(4)
//		lvdw_2.Event ue_Pos(1, "cd_produto_abcfarma")
//		Return False
//	End If
	
	lvs_Valor = String(lvdw_2.Object.Vl_Fator_Conversao_ABCFarma[1])
	
	//Tirada valida$$HEX2$$e700e300$$ENDHEX$$o - chamado 867533 
	/*If IsNull(lvs_Valor) Or Dec(lvs_Valor) <= 0 Then  
		wf_Campo_Not_Null("Informe o fator de convers$$HEX1$$e300$$ENDHEX$$o para o caderno ABC Farma.", lvdw_2, "vl_fator_conversao_abcfarma", 1)
		Return False
	End If	*/
End If

lvs_Grupo_Psico       		= lvdw_1.Object.Cd_Grupo_Psico       		[1]
lvs_DCB						= lvdw_1.Object.cd_dcb				      		[1]
lvs_Tipo_Apresentacao	= lvdw_1.Object.Id_Apresentacao      		[1]
lvdc_Concentracao			= lvdw_1.Object.Qt_Concentracao      		[1]
lvl_Fabricante        		= lvdw_1.Object.Cd_Fabricante       			[1]

//Valida$$HEX2$$e700e300$$ENDHEX$$o de Controlados
If Not IsNull(ivo_Produto.Cd_Produto) Then //Produto j$$HEX1$$e100$$ENDHEX$$ existente
	If Not wf_Verifica_Alteracao_Controlado() Then Return False
End If

//Valida$$HEX2$$e700e300$$ENDHEX$$o dos Psicotr$$HEX1$$f300$$ENDHEX$$picos
If Not IsNull(lvs_Grupo_Psico) and lvs_Grupo_Psico <> "" and lvs_Grupo_Psico <> 'W' Then
	If IsNull(lvs_Tipo_Apresentacao) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o tipo de apresenta$$HEX2$$e700e300$$ENDHEX$$o do produto.")
		Tab_1.SelectTab(1)
		lvdw_1.Event ue_Pos(1, "id_apresentacao")		
		Return False
	End If
	
	If IsNull(lvdw_1.Object.de_registro_ms[1]) Or Trim(lvdw_1.Object.de_registro_ms[1]) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o registro do minist$$HEX1$$e900$$ENDHEX$$rio da sa$$HEX1$$fa00$$ENDHEX$$de.")
		Tab_1.SelectTab(1)
		lvdw_1.Event ue_Pos(1, "de_registro_ms")
		Return False
	End If
	
	// Se a apresenta$$HEX2$$e700e300$$ENDHEX$$o do produto for "LIQUIDO" obriga o volume sen$$HEX1$$e300$$ENDHEX$$o obriga a quantidade de unidades
	If lvs_Tipo_Apresentacao = "04" Then
		If IsNull(lvdc_Volume) or lvdc_Volume <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o volume do produto.")
			Tab_1.SelectTab(1)
			lvdw_1.Event ue_Pos(1, "vl_volume")
			Return False
		End If
	Else
		If IsNull(lvl_Qtde_Embalagem) or lvl_Qtde_Embalagem <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade de unidades por embalagem do produto.")
			Tab_1.SelectTab(2)
			lvdw_1.Event ue_Pos(1, "qt_unidades_embalagem")		
			Return False
		End If
	End If
	
	If IsNull(lvdc_Concentracao) or lvdc_Concentracao <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a concentra$$HEX2$$e700e300$$ENDHEX$$o do produto.")
		Tab_1.SelectTab(1)
		lvdw_1.Event ue_Pos(1, "qt_concentracao")		
		Return False
	End If
	
	If IsNull(lvl_Fabricante) or lvl_Fabricante = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fabricante do produto.")
		Tab_1.SelectTab(1)
		lvdw_1.Event ue_Pos(1, "nm_fabricante")		
		Return False
	End If
	
	If IsNull( lvs_DCB ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o DCB do produto.")
		Tab_1.SelectTab(1)
		lvdw_1.Event ue_Pos(1, "de_dcb")		
		Return False
	End If
End If

If Trim(lvdw_1.Object.de_registro_ms[1]) = "" Then
	SetNull(ls_Nulo)
	lvdw_1.Object.de_registro_ms[1] = ls_Nulo
End If

//// Valida$$HEX2$$e700e300$$ENDHEX$$o dos Produtos Internet
//lvl_categoria = lvdw_10.Object.cd_categoria_ecommerce[1]
//
//if  lvdw_1.Object.Id_Liberado_Ecommerce[1] = 'S' or lvdw_1.Object.Id_Liberado_Ecommerce_dc[1] = 'S' or lvdw_1.Object.Id_Liberado_Ecommerce_pp[1] = 'S' or lvdw_1.Object.Id_Liberado_Ecommerce_mp[1] = 'S' Then
//	lvs_Liberado_Ecommerce  = 'S'
//else
//	lvs_Liberado_Ecommerce  = 'N'
//end if
//
//// Faz a valida$$HEX2$$e700e300$$ENDHEX$$o se o produto for liberado para o eCommerce
//If lvs_Liberado_Ecommerce = "S" Then
//	
//	if lvl_categoria = 0 or isnull(lvl_categoria) Then
//		wf_Campo_Not_Null("CATEGORIA", lvdw_10, "cd_categoria_ecommerce", 3)
//		Return False
//	End If
//		
//End If

////Validacao Caixa Padrao: Diferente do Almoxarifado e do mix proformula
lvs_Valor = Mid(String(lvdw_1.Object.cd_subcategoria[1]), 1, 1)

If lvs_Valor <> '5' And lvs_Valor <> '6' And lvs_Valor <> '7' And lvdw_2.Object.Cd_Mix_Produto[1] <> 20 Then

//********* Estas informa$$HEX2$$e700f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o usadas no futuro
//	lvs_Valor = String(lvdw_2.Object.qt_altura_cm_caixa_forn[1])
//	
//	If IsNull(lvs_Valor) Or dec(lvs_Valor) = 0 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O campo ALTURA CAIXA FORNECEDOR deve ser informado.")
//		Tab_1.SelectTab(4)
//		lvdw_2.Event ue_Pos(1, "qt_altura_cm_caixa_forn")	
//		Return False
//	End If
//	
//	lvs_Valor = String(lvdw_2.Object.qt_largura_cm_caixa_forn[1])
//	
//	If IsNull(lvs_Valor) Or dec(lvs_Valor) = 0 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O campo LARGURA CAIXA FORNECEDOR deve ser informado.")
//		Tab_1.SelectTab(4)
//		lvdw_2.Event ue_Pos(1, "qt_largura_cm_caixa_forn")	
//		Return False
//	End If
//	
//	lvs_Valor = String(lvdw_2.Object.qt_profundidade_cm_caixa_forn[1])
//	
//	If IsNull(lvs_Valor) Or dec(lvs_Valor) = 0 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O campo PROFUNDIDADE CAIXA FORNECEDOR deve ser informado.")
//		Tab_1.SelectTab(4)
//		lvdw_2.Event ue_Pos(1, "qt_profundidade_cm_caixa_forn")	
//		Return False
//	End If
	
	ll_Fator_Conversao 	= lvdw_2.Object.vl_fator_conversao	 				[1]
	
	lvdc_Altura_CD 			= lvdw_2.Object.qt_altura_cm_caixa_estoque	[1]
	lvdc_Largura_CD			= lvdw_2.Object.qt_largura_cm_caixa_estoque	[1]
	lvdc_Profundidade_CD	= lvdw_2.Object.qt_profund_cm_caixa_estoque	[1]
	
	If (IsNull(lvdc_Altura_CD) Or lvdc_Altura_CD = 0) Or (IsNull(lvdc_Largura_CD) Or  lvdc_Largura_CD = 0) Or IsNull(lvdc_Profundidade_CD) Or lvdc_Profundidade_CD = 0 Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As informa$$HEX2$$e700f500$$ENDHEX$$es das dimens$$HEX1$$f500$$ENDHEX$$es da CX de Estoque n$$HEX1$$e300$$ENDHEX$$o foram informadas. Deseja continuar mesmo assim ?", Question!, YesNo!, 2) = 2 Then
			Tab_1.SelectTab(4)
			lvdw_2.Event ue_Pos(1, "qt_altura_cm_caixa_estoque")	
			Return False
		End If
	End If		
End If

lvs_Valor = String(lvdw_15.Object.Cd_Mix_Produto[1])

If IsNull(lvs_Valor) Then
	wf_Campo_Not_Null("MIX PRODUTO", lvdw_15, "cd_mix_produto", 4)
	Tab_1.SelectTab(6)
	lvdw_15.Event ue_Pos(1, "cd_mix_produto")
	Return False
End If

lvs_Valor = String(lvdw_15.Object.Id_Proprio_Consignado[1])

If IsNull(lvs_Valor) Then
	wf_Campo_Not_Null("TIPO ESTOQUE", lvdw_15, "id_proprio_consignado", 4)
	Tab_1.SelectTab(6)
	lvdw_15.Event ue_Pos(1, "id_proprio_consignado")
	Return False
End If

lvs_Valor = String(lvdw_15.Object.Nr_Embalagem_Padrao[1])

If IsNull(lvs_Valor) Or Long(lvs_Valor) <= 0 Then
	wf_Campo_Not_Null("A embalagem padr$$HEX1$$e300$$ENDHEX$$o deve ser maior que zero.", lvdw_15, "nr_embalagem_padrao", 4)
	Tab_1.SelectTab(6)
	lvdw_15.Event ue_Pos(1, "nr_embalagem_padrao")	
	Return False
End If

Return True
end function

public subroutine wf_campo_not_null (string ps_mensagem, dc_uo_dw_base pdw_datawindow, string ps_campo, integer pi_tabpage);If ps_Mensagem = Upper(ps_Mensagem) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O campo '" + ps_Mensagem + "' deve ser informado.")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ps_Mensagem)
End If

Tab_1.SelectTab(pi_tabpage)
pdw_Datawindow.Event ue_Pos(1, ps_campo)
end subroutine

public function boolean wf_valida_desc_clube_futuro ();Decimal lvdc_Atual, &
		  lvdc_Anterior
		  
Long lvl_Produto

DateTime lvdh_Atual, &
			lvdh_Anterior

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If IsNull(lvl_Produto) Or lvl_Produto = 0 Then Return True

lvdc_Atual = Tab_1.TabPage_2.dw_2.Object.Pc_Desconto_Clube_Futuro[1]
lvdh_Atual = Tab_1.TabPage_2.dw_2.Object.Dh_Desconto_Clube_Futuro[1]

Select pc_desconto_clube_futuro,
		 dh_desconto_clube_futuro
  Into :lvdc_Anterior,
  		 :lvdh_Anterior
  From produto_geral
 Where cd_produto = :lvl_Produto
 Using SqlCa;
 
If SqlCa.SqlCode <> 0 Then
//	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do percentual desconto clube futuro.")
//	Return False
	Return True
End If

If IsNull(lvdh_Anterior) Or (( lvdc_Atual <> lvdc_Anterior ) Or ( lvdh_Atual <> lvdh_Anterior )) Then
	
	If lvdh_Atual <= ivdh_Parametro Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data para o desconto clube futuro deve ser maior que: ' + String(lvdh_Atual, "dd/mm/yyyy"))
		Tab_1.TabPage_2.dw_2.Event ue_Pos(1, "dh_desconto_clube_futuro")
		Return False
	End If
	
	Tab_1.TabPage_2.dw_2.Object.Nr_Matric_Desc_Clube_Futuro[1] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	
	If IsNull(lvdc_Atual) Then
		Tab_1.TabPage_2.dw_2.Object.Pc_Desconto_Clube_Futuro[1] = 0
	End If

End If
 
Return True
end function

public subroutine wf_verifica_uf_ativa ();Long lvl_Total, &
     lvl_Contador, &
	  lvl_Linha
	  
String lvs_UF, &
       lvs_Nome

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge400_lista_uf_ativa") Then	
	Destroy(lvds)
	Return
End If

lvl_Total = lvds.Retrieve()

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvs_UF   = lvds.Object.Cd_Unidade_Federacao[lvl_Contador]
		lvs_Nome = lvds.Object.Nm_Unidade_Federacao[lvl_Contador]
		
		lvl_Linha = Tab_1.TabPage_2.dw_7.Find("cd_unidade_federacao = '" + lvs_UF + "'", 1, Tab_1.TabPage_2.dw_7.RowCount())
		
		If lvl_Linha < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da lista de U.F.'s.")
		End If
		
		If lvl_Linha = 0 Then
			lvl_Linha = Tab_1.TabPage_2.dw_7.InsertRow(0)
			
			Tab_1.TabPage_2.dw_7.Object.Cd_Unidade_Federacao      	[lvl_Linha] = lvs_UF
			Tab_1.TabPage_2.dw_7.Object.Nm_Unidade_Federacao       	[lvl_Linha] = lvs_Nome			
			Tab_1.TabPage_2.dw_7.Object.Dh_Preco_Venda_Atual      		[lvl_Linha] = ivdh_Parametro
			Tab_1.TabPage_2.dw_7.Object.Nr_Matric_Preco_Venda_Atual	[lvl_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		End If
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma U.F. ativa foi localizada para cadastramento dos dados espec$$HEX1$$ed00$$ENDHEX$$ficos.")
End If

Destroy(lvds)
end subroutine

public function boolean wf_valida_cadastro_uf ();Long lvl_Linha, &
     lvl_Tipo, &
	  lvl_Tributa_Produto
	  
String lvs_UF, &
       lvs_Tributacao, &
		 lvs_uf_situacao

Decimal lvdc_Preco_Venda, &
        lvdc_Preco_Reposicao

Tab_1.TabPage_2.dw_7.AcceptText()
Tab_1.TabPage_2.dw_8.AcceptText()
Tab_1.TabPage_2.dw_14.AcceptText()

For lvl_Linha = 1 To Tab_1.TabPage_2.dw_7.RowCount()
	//dw_7
	lvs_UF						= Tab_1.TabPage_2.dw_7.Object.Cd_Unidade_Federacao	[lvl_Linha]
	lvs_Tributacao				= Tab_1.TabPage_2.dw_7.Object.Cd_Tributacao_ICMS   		[lvl_Linha]
	lvl_Tributa_Produto		= Tab_1.TabPage_2.dw_7.Object.Cd_Tributacao_Produto		[lvl_Linha]
	lvl_Tipo						= Tab_1.TabPage_2.dw_7.Object.Cd_Tipo_ICMS        	 		[lvl_Linha]
	lvdc_Preco_Venda			= Tab_1.TabPage_2.dw_14.Object.Vl_Preco_Venda_Atual_sap 	[lvl_Linha]
	lvdc_Preco_Reposicao		= Tab_1.TabPage_2.dw_14.Object.Vl_Preco_Reposicao   		[lvl_Linha]
	
	//
	If IsNull(lvs_UF) Then Continue

	If IsNull(lvs_Tributacao) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o tipo de tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS do produto para o Estado '" + lvs_UF + "'.")
		Tab_1.SelectedTab = 4
		Tab_1.TabPage_2.dw_7.SetRow(lvl_Linha)
		Tab_1.TabPage_2.dw_8.Event ue_Pos(lvl_Linha, "cd_tributacao_icms")
		Return False
	End If

	If IsNull(lvl_Tributa_produto) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o tipo de tributa$$HEX2$$e700e300$$ENDHEX$$o de produto farmac$$HEX1$$ea00$$ENDHEX$$utico para o Estado '" + lvs_UF + "'.")
		Tab_1.SelectedTab = 4
		Tab_1.TabPage_2.dw_7.SetRow(lvl_Linha)
		Tab_1.TabPage_2.dw_8.Event ue_Pos(lvl_Linha, "cd_tributacao_produto")
		Return False
	End If

	If IsNull(lvl_Tipo) or lvl_Tipo = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o tipo de ICMS do produto para o Estado '" + lvs_UF + "'.")
		Tab_1.SelectedTab = 4
		Tab_1.TabPage_2.dw_7.SetRow(lvl_Linha)
		Tab_1.TabPage_2.dw_8.Event ue_Pos(lvl_Linha, "cd_tipo_icms")
		Return False
	End If
	
	//dw_14
	If IsNull(lvdc_Preco_Reposicao) or lvdc_Preco_Reposicao <= 0 Then
	
		Setnull(lvs_uf_situacao)
			
		If lvdc_Preco_Reposicao < 0 Then 
			Tab_1.TabPage_2.dw_14.Object.Vl_Preco_Reposicao	[lvl_Linha] = 0
		End If
			
		If Not wf_verifica_uf_atendimento(lvs_UF, Ref lvs_uf_situacao) Then Return False
	
		If lvs_uf_situacao = 'S' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o do produto para o Estado '" + lvs_UF + "' deve ser maior que zero.")
			Tab_1.SelectedTab = 4
			Tab_1.TabPage_2.dw_7.SetRow(lvl_Linha)
			Tab_1.TabPage_2.dw_14.Event ue_Pos(lvl_Linha, "vl_preco_reposicao")
			Return False
		End If
	End If
	
	If IsNull(lvdc_Preco_Venda) or lvdc_Preco_Venda <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de venda atual do produto para o Estado '" + lvs_UF + "' deve ser maior que zero.")
		Tab_1.SelectedTab = 4
		Tab_1.TabPage_2.dw_7.SetRow(lvl_Linha)
//		Posiciona na reposi$$HEX2$$e700e300$$ENDHEX$$o porque n$$HEX1$$e300$$ENDHEX$$o pode mais alterar a venda
		Tab_1.TabPage_2.dw_14.Event ue_Pos(lvl_Linha, "vl_preco_reposicao")
		Return False
	End If
Next

Return True
end function

public subroutine wf_atualiza_fabricante ();Tab_1.TabPage_1.dw_1.Object.Cd_Fabricante[1] = ivo_Fabricante.Cd_Fabricante
Tab_1.TabPage_1.dw_1.Object.Nm_Fabricante[1] = ivo_Fabricante.Nm_Razao_Social

end subroutine

public subroutine wf_atualiza_dcb ();Tab_1.TabPage_1.dw_1.Object.Cd_DCB[1] = ivo_DCB.Cd_DCB
Tab_1.TabPage_1.dw_1.Object.De_DCB[1] = ivo_DCB.De_DCB

end subroutine

public function boolean wf_atualiza_sequencial_produto (ref long al_produto);Select max(cd_produto) Into :al_produto
From produto_geral
Where cd_produto < 900000
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(al_produto) Then
			al_produto = 1
		Else
			al_produto += 1
		End If
	Case -1
		SqlCa.of_MsgdbError("Determina$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo do produto")
End Choose


Return True
end function

public function boolean wf_inclui_produto_geral (long al_produto_atual, long al_produto_novo);Date lvdh_Termino_Avaliacao

lvdh_Termino_Avaliacao = RelativeDate(Date(ivdh_Parametro), 90)

Insert Into produto_geral  
	 ( cd_produto,   
	   de_produto,   
	   de_apresentacao_estoque,   
	   de_apresentacao_venda,   
	   nr_embalagem_padrao,   
	   nr_classificacao_fiscal,   
	   cd_unidade_medida_compra,   
	   cd_unidade_medida_venda,   
	   cd_origem_produto,   
	   cd_tributacao_icms,   
	   pc_reducao_base_icms,   
	   id_situacao_pis_cofins,   
	   id_repasse_icms,   
	   cd_grupo_produto,   
	   cd_subgrupo_produto,   
	   cd_subcategoria,   
	   cd_fornecedor_usual,   
	   dh_alteracao_codigo_barras,   
	   vl_fator_conversao,   
	   id_superfluo,   
	   id_consumo_popular,   
	   id_cesta_basica,   
	   vl_preco_venda_atual,   
	   dh_preco_venda_atual,   
	   nr_matricula_preco_venda_atual,   
	   pc_desconto_atual,   
	   dh_desconto_atual,   
	   nr_matricula_desconto_atual,   
	   id_tipo_desconto_atual,   
	   id_preco_bloqueado,   
	   pc_comissao_extra,   
	   pc_ipi,   
	   id_caderno_abcfarma,   
	   id_situacao,   
	   id_proprio_consignado,   
	   id_liberado_filial,   
	   id_cartao_genio,   
	   dh_inclusao_produto,   
	   dh_termino_avaliacao,   
	   vl_preco_venda_futuro,   
	   dh_preco_venda_futuro,   
	   nr_matric_preco_venda_futuro,   
	   pc_desconto_futuro,   
	   dh_desconto_futuro,   
	   nr_matricula_desconto_futuro,   
	   id_tipo_desconto_futuro,   
	   cd_linha_produto,   
	   cd_grupo_psico,   
	   cd_dcb,   
	   pc_imposto,   
	   id_imposto_fixado,   
	   id_acumula_pontos_clube,   
	   pc_desconto_clube_atual,   
	   dh_desconto_clube_atual,   
	   nr_matric_desc_clube_atual,   
	   pc_desconto_clube_futuro,   
	   dh_desconto_clube_futuro,   
	   nr_matric_desc_clube_futuro,   
	   vl_ponto_clube,   
	   qt_pontos_resgate,   
	   id_utiliza_vale_resgate,   
	   qt_unidades_embalagem,   
	   qt_concentracao,   
	   id_apresentacao,   
	   qt_dias_maximo_tratamento,   
	   vl_volume,   
	   cd_tipo_icms,   
	   cd_fabricante,
	   id_lei_generico,
	   de_marca,
		cd_st_origem,
		nr_matricula_inclusao)  
		   
Select :al_Produto_Novo,   
	   de_produto,   
	   de_apresentacao_estoque,   
	   de_apresentacao_venda,   
	   nr_embalagem_padrao,   
	   nr_classificacao_fiscal,   
	   cd_unidade_medida_compra,   
	   cd_unidade_medida_venda,   
	   cd_origem_produto,   
	   cd_tributacao_icms,   
	   pc_reducao_base_icms,   
	   id_situacao_pis_cofins,   
	   id_repasse_icms,   
	   cd_grupo_produto,   
	   cd_subgrupo_produto,   
	   cd_subcategoria,   
	   cd_fornecedor_usual,   
	   getdate(),   
	   vl_fator_conversao,   
	   id_superfluo,   
	   id_consumo_popular,   
	   id_cesta_basica,   
	   vl_preco_venda_atual,   
	   dh_preco_venda_atual,   
	   nr_matricula_preco_venda_atual,   
	   0, 				//pc_desconto_atual   
	   :ivdh_Parametro, //dh_desconto_atual  
	   :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, //nr_matricula_desconto_atual   
	   id_tipo_desconto_atual,   
	   id_preco_bloqueado,   
	   pc_comissao_extra,   
	   pc_ipi,   
	   "N", //id_caderno_abcfarma
	   id_situacao,   
	   id_proprio_consignado,   
	   id_liberado_filial,   
	   id_cartao_genio,   
	   :ivdh_Parametro,   
	   :lvdh_Termino_Avaliacao,   
	   vl_preco_venda_futuro,   
	   dh_preco_venda_futuro,   
	   nr_matric_preco_venda_futuro,   
	   null, //pc_desconto_futuro   
	   null, //dh_desconto_futuro   
	   null, //nr_matricula_desconto_futuro   
	   null, //id_tipo_desconto_futuro   
	   cd_linha_produto,   
	   cd_grupo_psico,   
	   cd_dcb,   
	   pc_imposto,   
	   id_imposto_fixado,   
	   id_acumula_pontos_clube,   
	   null, //pc_desconto_clube_atual   
	   null, //dh_desconto_clube_atual   
	   null, //nr_matric_desc_clube_atual   
	   null, //pc_desconto_clube_futuro   
	   null, //dh_desconto_clube_futuro   
	   null, //nr_matric_desc_clube_futuro   
	   vl_ponto_clube, //vl_ponto_clube   
	   null, //qt_pontos_resgate   
	   null, //id_utiliza_vale_resgate   
	   qt_unidades_embalagem,   
	   qt_concentracao,   
	   id_apresentacao,   
	   qt_dias_maximo_tratamento,   
	   vl_volume,   
	   cd_tipo_icms,   
	   cd_fabricante,
	   id_lei_generico,
	   de_marca,
	  cd_st_origem,
	  :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
From produto_geral
Where cd_produto =:al_Produto_Atual
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao incluir o produto novo na tabela produto geral")
	Return False
End If
		   
Return True
end function

public function boolean wf_inclui_produto_uf (long al_produto_atual, long al_produto_novo);Insert Into produto_uf  
	 ( cd_unidade_federacao,   
	   cd_produto,   
	   cd_tributacao_icms, 
		cd_tributacao_produto,
	   cd_tipo_icms,   
	   vl_preco_reposicao,   
	   dh_preco_reposicao,   
	   nr_matricula_preco_reposicao,   
	   vl_preco_venda_atual,   
	   dh_preco_venda_atual,   
	   nr_matric_preco_venda_atual,   
	   vl_preco_venda_futuro,   
	   dh_preco_venda_futuro,   
	   nr_matric_preco_venda_futuro,   
	   pc_desconto_repassado_preco,   
	   pc_frete_preco,   
	   pc_acrescimo_financeiro_preco,   
	   pc_margem_resultado_preco,   
	   pc_icms_compra_preco,   
	   pc_icms_venda_preco )  

Select cd_unidade_federacao,   
	   :al_Produto_Novo,   
	   cd_tributacao_icms,   
		cd_tributacao_produto,
	   cd_tipo_icms,   
	   vl_preco_reposicao,   
	   dh_preco_reposicao,   
	   nr_matricula_preco_reposicao,   
	   vl_preco_venda_atual,   
	   dh_preco_venda_atual,   
	   nr_matric_preco_venda_atual,   
	   vl_preco_venda_futuro,   
	   dh_preco_venda_futuro,   
	   nr_matric_preco_venda_futuro,   
	   pc_desconto_repassado_preco,   
	   pc_frete_preco,   
	   pc_acrescimo_financeiro_preco,   
	   pc_margem_resultado_preco,   
	   pc_icms_compra_preco,   
	   pc_icms_venda_preco
From produto_uf
Where cd_produto =:al_Produto_Atual
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Erro ao incluir o produto na tabela produto uf")
	Return False
End If

Return True
end function

public function boolean wf_inclui_comissao_produto (long al_produto_atual, long al_produto_novo);Insert Into tipo_comissao_produto(cd_produto, cd_tipo_comissao, pc_comissao )
Select :al_Produto_Novo, cd_tipo_comissao, pc_comissao
From tipo_comissao_produto
Where cd_produto =:al_Produto_Atual
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao incluir o produto na tabela tipo_comissao_produto")
	Return False
End If

Return True
end function

public subroutine wf_localiza_niveis_categoria (long al_categoria, ref string as_niveis);String lvs_Nivel,&
	   lvs_Nivel_Array[]

Long lvl_Pai,&
	 lvl_Categoria
	 
Integer lvi_Array = 1,&
	    lvi_Niveis

Select de_categoria, cd_categoria_pai
Into :lvs_Nivel, :lvl_Pai
From categoria_ecommerce
Where cd_categoria = :al_Categoria
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
End Choose

as_Niveis = lvs_Nivel

lvs_Nivel_Array[lvi_Array] = lvs_Nivel

Do While lvl_Pai <> 0
	
	al_Categoria = lvl_Pai
	
	lvi_Array ++
	
	Select de_categoria, cd_categoria_pai
	Into :lvs_Nivel, :lvl_Pai
	From categoria_ecommerce
	Where cd_categoria = :al_Categoria
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
		Case -1
	End Choose
	
	lvs_Nivel_Array[lvi_Array] = lvs_Nivel

LOOP

lvi_Niveis = UpperBound(lvs_Nivel_Array)

// Se tiver mais de um n$$HEX1$$ed00$$ENDHEX$$vel monta os niveis
If lvi_Niveis > 1 Then
	
	as_Niveis = ""
	
	Do While lvi_Niveis <> 0
		
		as_Niveis = as_Niveis + lvs_Nivel_Array[lvi_Niveis] 
		
		If lvi_Niveis <> 1 Then
			as_Niveis = as_Niveis + " / "
		End If
				
		lvi_Niveis --
	Loop
		
End If






end subroutine

public subroutine wf_localiza_path_fotos ();Select vl_parametro
Into :ivs_Path_Fotos_Ecommerce
From parametro_geral
Where cd_parametro = 'DE_PATH_FOTOS_ECOMMERCE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O caminho para a localiza$$HEX2$$e700e300$$ENDHEX$$o das fotos do Ecommerce n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela PARAMETRO_GERAL.")
		Return
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do caminho para as fotos do eCommerce")
		Return 
End Choose

Select vl_parametro
Into :ivs_Path_Fotos_Categoria
From parametro_geral
Where cd_parametro = 'DE_PATH_FOTOS_CATEGORIA'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O caminho para a localiza$$HEX2$$e700e300$$ENDHEX$$o das fotos das categorias n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela PARAMETRO_GERAL.")
		Return
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do caminho para as fotos das categorias")
		Return 
End Choose
end subroutine

public function boolean wf_localiza_foto (long al_produto, string as_tipo);String lvs_Arquivo,&
	   lvs_EAN

// eCommerce
If as_Tipo = 'E' Then
	lvs_Arquivo = ivs_path_fotos_ecommerce + "\" + String(al_Produto) + ".jpg"
Else
	
	// Categoria
	
	Select de_codigo_barras
	Into :lvs_EAN
	From codigo_barras_produto
	Where cd_produto 	= :al_Produto
	  and id_principal 	= 'S'
	Using SqlCa;
	
	If SqlCA.SqlCode = -1 Then
		SqlCa.of_MsgDBError('Localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo de barras')
		Return False
	End IF
	
	lvs_Arquivo = ivs_path_fotos_categoria + "\" + lvs_EAN + ".1"	
End If

If FileExists(lvs_Arquivo) Then
	Return True
Else
	Return False
End If
end function

public function boolean wf_localiza_categoria (long al_categoria, ref string as_categoria);Select de_categoria
  Into :as_Categoria
  From categoria_ecommerce
 Where cd_categoria = :al_Categoria
 Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da categoria")
		Return False
End Choose

Return True
end function

public function boolean wf_inclui_promocao_produto_novo (long al_produto);Boolean lvb_Sucesso = True

Long 	lvl_Produto,&
	 	lvl_Linhas,&
	 	lvl_Linha,&
	 	lvl_Promocao_SOS
	
String lvs_Grupo,&
	   	lvs_Lei_Generico
	   
Decimal	lvdc_Desconto,&
		   	lvdc_Preco_Venda_SC,&
			lvdc_Preco_Liq_SC
			
Tab_1.Tabpage_1.dw_1.AcceptText()

//LICITA$$HEX2$$c700d500$$ENDHEX$$ES // SOMENTE ENCOMENDA (SOLICITA$$HEX2$$c700c300$$ENDHEX$$O RAFAEL PAZ)
// Se o produto fazer parte do mix licita$$HEX2$$e700e300$$ENDHEX$$o ou somente encomenda n$$HEX1$$e300$$ENDHEX$$o inclui o percentual de desconto.
// Solicitante: Ana do Compras
// Altera$$HEX2$$e700e300$$ENDHEX$$o: 09/05/2013
If Tab_1.Tabpage_1.dw_1.Object.cd_mix_produto[1] = 33 Or Tab_1.Tabpage_1.dw_1.Object.cd_mix_produto[1] = 2 Then
	Return True
End If

dc_uo_ds_base lvds 

lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("dw_ge400_promocao_sos_produto_novo") Then
	Destroy(lvds)
	Return False
End If

// Vem nulo quando $$HEX1$$e900$$ENDHEX$$ um cadastro novo
If IsNull(al_Produto) Then
	lvl_Produto = Tab_1.Tabpage_1.dw_1.Object.Cd_Produto_Central[1]
Else
	// N$$HEX1$$e300$$ENDHEX$$o vem nulo quando $$HEX1$$e900$$ENDHEX$$ um c$$HEX1$$f300$$ENDHEX$$pia de cadastro
	lvl_Produto = al_Produto
End If

If Not wf_Consulta_Produto(lvl_Produto, Ref lvs_Grupo, Ref lvs_Lei_Generico) Then 
	Destroy(lvds)
	Return False
End If

lvds.Retrieve(lvs_Grupo, lvs_Lei_Generico)

lvl_Linhas = lvds.RowCount()

If lvl_Linhas > 0 Then
	
	If Not wf_Preco_Atual(lvl_Produto, Ref lvdc_Preco_Venda_SC, 'SC') Then 
		Destroy(lvds)
		Return False
	End If
	
//	If Not wf_Preco_Atual(lvl_Produto, Ref lvdc_Preco_Venda_PR, 'PR') Then 
//		Destroy(lvds)
//		Return False
//	End If
	
	For lvl_Linha = 1 To lvl_Linhas
		
		lvl_Promocao_SOS 		= lvds.Object.cd_promocao_sos		[lvl_Linha]
		lvdc_Desconto				= lvds.Object.pc_desconto				[lvl_Linha]	
		//lvl_Promocao_SOS_PR	= lvds.Object.cd_promocao_sos_pr	[lvl_Linha]
		
		lvdc_Preco_Liq_SC = Round(lvdc_Preco_Venda_SC * ((100 - lvdc_Desconto) / 100), 2)
		
//		If lvdc_Preco_Liq_SC <= 10.00 Then
//			If lvs_Lei_Generico = 'R' Then
//				lvdc_Desconto = lvdc_Desconto - 1.8
//			Else
//				lvdc_Desconto = lvdc_Desconto - 3
//			End If
//		End If
		
		INSERT INTO promocao_sos_produto (	cd_promocao_sos,   
										   					cd_produto,   
														   	pc_desconto,   
										   					id_carregado_as400)  
		VALUES ( :lvl_Promocao_SOS,   
				     :lvl_Produto,   
					:lvdc_Desconto,   
				 	'N')
		Using SqlCa;
		  
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do produto '" + String(lvl_Produto) + "' na promo$$HEX2$$e700e300$$ENDHEX$$o '" +&
								String(lvl_Promocao_SOS) + "'")			
			lvb_Sucesso = False
		End If
		  
		If Not lvb_Sucesso Then Exit
		
//		If IsNull(lvl_Promocao_SOS_PR) Then Continue
//		  
//		If lvl_Promocao_SOS_PR <> lvl_Promocao_Anterior Then
//			
//			lvdc_Preco_Liq_SC = Round(lvdc_Preco_Venda_SC * ((100 - lvdc_Desconto) / 100), 2)
//			lvdc_Desconto	  = Round(((lvdc_Preco_Venda_PR - lvdc_Preco_Liq_SC) / lvdc_Preco_Venda_PR) * 100, 2)
//			
//			If lvdc_Desconto <= 0 Then Continue		
//			
//			INSERT INTO promocao_sos_produto ( cd_promocao_sos,   
//										 	   cd_produto,   
//											   pc_desconto,   
//											   id_carregado_as400)  
//			VALUES ( :lvl_Promocao_SOS_PR,   
//				   	 :lvl_Produto,   
//					 :lvdc_Desconto,   
//					 'N')
//			Using SqlCa;
//			  
//			If SqlCa.SqlCode = -1 Then
//				SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do produto '" + String(lvl_Produto) + "' na promo$$HEX2$$e700e300$$ENDHEX$$o '" +&
//									String(lvl_Promocao_SOS) + "'")			
//				lvb_Sucesso = False
//			End If
//			  
//			lvl_Promocao_Anterior = lvl_Promocao_SOS_PR
//		End If		  
		  
//		If Not lvb_Sucesso Then Exit
	  
	Next
	
	If lvb_Sucesso Then
		SqlCa.of_Commit();
	Else
		SqlCa.of_RollBack();
	End If
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean wf_consulta_produto (long al_produto, ref string as_grupo, ref string as_lei_generico);Select substring(cd_subcategoria, 1, 1), id_lei_generico
Into :as_Grupo, :as_Lei_Generico
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar os dados do produto '" + String(al_Produto) + "'.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do produto '" + String(al_Produto) + "'")
		Return False
End Choose

Return True


end function

public function boolean wf_preco_atual (long al_produto, ref decimal adc_valor, string as_uf);Select vl_preco_venda_atual
Into :adc_Valor
From produto_uf
Where cd_unidade_federacao = :as_UF
  and cd_produto		   = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de venda atual do produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foi localidado.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de venda atual do produto '" + String(al_Produto) + "'")
		Return False
End Choose

Return True
end function

public subroutine wf_atualiza_grupo_alteracao_preco ();Tab_1.TabPage_2.dw_2.Object.cd_grupo_alteracao_preco[1] = ivo_grupo_alteracao_preco.cd_grupo
Tab_1.TabPage_2.dw_2.Object.de_grupo_alteracao_preco[1] = ivo_grupo_alteracao_preco.de_grupo

end subroutine

public subroutine wf_inclui_planograma_nulo ();Integer lvi_Retorno, &
       	  lvi_Linha, &
  	      lvi_Nulo

DataWindowChild lvdwc

SetNull(lvi_Nulo)

lvi_Retorno = Tab_1.TabPage_1.dw_1.GetChild("cd_planograma", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_planograma", lvi_Nulo)
		lvdwc.SetItem(lvi_Linha, "de_planograma", "NENHUM")
		
		Tab_1.TabPage_1.dw_1.Object.Cd_planograma[1] = lvi_Nulo
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da linha nula do planograma.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da linha do planograma.", StopSign!)
End If

end subroutine

protected function boolean wf_inclui_produto_central (long al_produto_atual, long al_produto_novo);Insert Into produto_central  
	 ( cd_produto,   
	   cd_mix_produto,   
	   id_tipo_reposicao_estoque,   
	   cd_divisao_estocagem,   
	   cd_local_estocagem,   
	   id_origem_produto_fornecedor,   
	   pc_desconto_fornecedor,   
	   id_contrato_fornecedor,   
	   vl_peso_liquido,   
	   dh_situacao,   
	   vl_preco_reposicao,   
	   dh_preco_reposicao,   
	   nr_matricula_preco_reposicao,   
	   id_preco_informado,   
	   id_pagamento_apos_venda,   
	   vl_custo_gerencial,   
	   nr_matricula_comprador,   
	   id_sugere_pedido_filial,   
	   vl_acrescimo_estoque_base,   
	   id_lei_generico,   
	   id_indice_inflacao,   
	   vl_custo_gerencial_geral,
		id_revisao_fiscal,
		cd_bairro_wms)  
	   
Select :al_Produto_Novo,   
	   cd_mix_produto,   
	   id_tipo_reposicao_estoque,   
	   '00',   
	   cd_local_estocagem,   
	   id_origem_produto_fornecedor,   
	   0,   
	   id_contrato_fornecedor,   
	   vl_peso_liquido,   
	   getdate(),   
	   vl_preco_reposicao,   
	   getdate(),   
	   :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,   
	   id_preco_informado,   
	   id_pagamento_apos_venda,   
	   0,   
	   nr_matricula_comprador,   
	   id_sugere_pedido_filial,   
	   vl_acrescimo_estoque_base,   
	   id_lei_generico,   
	   id_indice_inflacao,   
	   0,
		'P',
		cd_bairro_wms
From produto_central
Where cd_produto =:al_Produto_Atual
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao incluir o produto na tabela produto central")
	Return False
End If

Return True
end function

public function boolean wf_valida_substancias ();Long lvl_Linha, &
     lvl_Substancia

Decimal lvdc_Concentracao

Tab_1.TabPage_6.dw_12.AcceptText()

For lvl_Linha = 1 To Tab_1.TabPage_6.dw_12.RowCount()
	lvl_Substancia		= Tab_1.TabPage_6.dw_12.Object.cd_substancia [lvl_Linha]
	lvdc_Concentracao	= Tab_1.TabPage_6.dw_12.Object.qt_concentracao [lvl_Linha]

	If IsNull(lvl_Substancia) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A subst$$HEX1$$e200$$ENDHEX$$ncia deve ser informada.")
		Tab_1.SelectedTab = 2
		Tab_1.TabPage_6.dw_12.SetRow(lvl_Linha)
		Tab_1.TabPage_6.dw_12.Event ue_Pos(lvl_Linha, "cd_substancia")
		Return False
	End If

	If IsNull(lvdc_Concentracao) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A concentra$$HEX2$$e700e300$$ENDHEX$$o deve ser informada.")
		Tab_1.SelectedTab = 2
		Tab_1.TabPage_6.dw_12.SetRow(lvl_Linha)
		Tab_1.TabPage_6.dw_12.Event ue_Pos(lvl_Linha, "qt_concentracao")
		Return False
	End If	
Next

Return True
end function

public function Boolean wf_localiza_dcb (string as_parametro);Boolean lb_Retorno

lb_Retorno = ivo_DCB.of_Localiza(as_Parametro)

If lb_Retorno Then wf_Atualiza_DCB()

Return lb_Retorno
end function

public function Boolean wf_localiza_fabricante (string ps_parametro);ivo_Fabricante.of_Localiza_Fabricante(ps_Parametro)

If ivo_Fabricante.Localizado Then wf_Atualiza_Fabricante()

Return ivo_Fabricante.Localizado
end function

public function Boolean wf_localiza_fornecedor (string ps_parametro);ivo_Fornecedor.ib_Valida_Situacao = False

ivo_Fornecedor.of_Localiza_Fornecedor(ps_Parametro)

If ivo_Fornecedor.Localizado Then wf_Atualiza_Fornecedor()

Return ivo_Fornecedor.Localizado
end function

public function Boolean wf_localiza_classificacao (string as_parametro);Boolean lb_Sucesso

lb_Sucesso = ivo_Classificacao.of_Localiza_SubCategoria(as_Parametro)

If lb_Sucesso Then wf_Atualiza_Classificacao()

Return lb_Sucesso
end function

public function Boolean wf_localiza_grupo_alteracao_preco (string ps_parametro);ivo_Grupo_Alteracao_Preco.of_Localiza_Grupo(ps_Parametro)

If ivo_Grupo_Alteracao_Preco.Localizado Then wf_Atualiza_Grupo_Alteracao_Preco()

Return ivo_Grupo_Alteracao_Preco.Localizado
end function

public function Boolean wf_localiza_produto_abcfarma (string ps_parametro, boolean pb_verificar);ivo_Produto_ABCFarma.of_Localiza_Produto(ps_Parametro)

If ivo_Produto_ABCFarma.Localizado Then
 	If pb_Verificar and wf_Produto_ABCFarma_Cadastrado(ivo_Produto_ABCFarma.Cd_Produto_ABCFarma) Then
	   ivo_Produto_ABCFarma.of_Inicializa()
	End If	
	
	wf_Atualiza_Produto_ABCFarma()
End If

Return ivo_Produto_ABCFarma.Localizado
end function

public function boolean wf_fornecedor_conexao (string ps_fornecedor, ref string ps_projeto, ref string ps_descricao);select f.id_projeto_conexao,
		c.de_projeto_conexao
into :ps_projeto,
	:ps_descricao
	from fornecedor f 
inner join conexao c
	on f.id_projeto_conexao = c.id_projeto_conexao
	where f.cd_fornecedor = :ps_fornecedor
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDBError("Erro ao localizar o projeto conex$$HEX1$$e300$$ENDHEX$$o do fornecedor: " + ps_fornecedor)
	Return False
End If

If IsNull(ps_projeto) Or ps_projeto = "" Then 
	SetNull(ps_projeto)
	ps_descricao = "NENHUM"
End If

Return True
end function

public subroutine wf_atualiza_divisao_fornecedor (string as_fornecedor, long al_produto);Long ll_Divisao

Select nr_divisao 
Into :ll_Divisao
From fornecedor_divisao_produto
Where cd_fornecedor = :as_fornecedor
  and cd_produto = :al_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor.")
	Return
Else
	If SqlCa.Sqlcode = 100 Then
		SetNull(ll_Divisao)
		Tab_1.TabPage_1.dw_1.Object.nr_divisao_fornecedor[1] = ll_Divisao
	Else
		Tab_1.TabPage_1.dw_1.Object.nr_divisao_fornecedor[1] = ll_Divisao
	End If
End If

end subroutine

public subroutine wf_lista_divisao_fornecedor ();DataWindowChild lvdwc

String ls_SQL, ls_Fornecedor

Tab_1.TabPage_1.dw_1.AcceptText()

ls_Fornecedor = Tab_1.TabPage_1.dw_1.Object.cd_fornecedor_usual[1]
	
If Tab_1.TabPage_1.dw_1.GetChild("nr_divisao_fornecedor", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
	
	//cast(f.nr_divisao as char(2)) + ' - ' + f.nm_divisao + ' | ' +  u.nm_usuario de_divisao,
		
	ls_SQL = " SELECT 	cast(f.nr_divisao as char(5)) + ' - ' + f.nm_divisao + ' | ' +  u.nm_usuario de_divisao, f.nr_divisao FROM fornecedor_divisao f   " +&
				 " inner join usuario u on u.nr_matricula = f.nr_matricula_comprador " +&
				 " where f.cd_fornecedor = '" + string(ls_Fornecedor) + "'" +&
				 " union " +&
				 " select 'NENHUMA', null"				 
	
	lvdwc.SetSQLSelect(ls_SQL)
		
	If lvdwc.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor.")
		Return 
	End If		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild divis$$HEX1$$e300$$ENDHEX$$o fornecedor.")
End If
end subroutine

public subroutine wf_inclui_divisao_fornecedor_nulo ();Integer lvi_Retorno, &
       	  lvi_Linha, &
  	      lvi_Nulo

DataWindowChild lvdwc

SetNull(lvi_Nulo)

lvi_Retorno = Tab_1.TabPage_1.dw_1.GetChild("nr_divisao_fornecedor", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "nr_divisao", lvi_Nulo)
		lvdwc.SetItem(lvi_Linha, "de_divisao", "NENHUMA")
		
		Tab_1.TabPage_1.dw_1.Object.nr_divisao_fornecedor[1] = lvi_Nulo
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da linha nula divis$$HEX1$$e300$$ENDHEX$$o de fornecedor.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da linha do planograma.", StopSign!)
End If

end subroutine

public subroutine wf_exclui_divisao_fornecedor_dw ();Long ll_Linha, ll_Linhas

ll_Linhas = dw_13.RowCount()

// Exclui	todos os registros
For ll_Linha = 1 To ll_Linhas
	dw_13.DeleteRow(ll_Linha)
Next

//dw_13.Reset()
//
//// Faz o delete, caso contr$$HEX1$$e100$$ENDHEX$$rio se mudar o fornecedor esta ficando mais de um fornecedor para um mesmo produto
//delete from fornecedor_divisao_produto
//where cd_produto = :al_Produto
//Using SqlCa;

//If SqlCa.Sqlcode = -1 Then
//	SqlCa.of_MsgDbError("Erro ao excluir a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor.")
//	Return
//End If
end subroutine

public function boolean wf_exclui_divisao_fornecedor ();String ls_Fornecedor

Long ll_Produto

ls_Fornecedor 	= Tab_1.TabPage_1.dw_1.Object.cd_fornecedor_usual 	[1]
ll_Produto		= Tab_1.TabPage_1.dw_1.Object.Cd_produto_central 	[1]

//// Faz o delete, caso contr$$HEX1$$e100$$ENDHEX$$rio se mudar o fornecedor esta ficando mais de um fornecedor para um mesmo produto
delete from fornecedor_divisao_produto
where cd_produto = :ll_Produto
  and cd_fornecedor <> :ls_Fornecedor
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgDbError("Erro ao excluir a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor.")
	Return False
End If

Return True
end function

public function boolean wf_produto_dw13 ();Long ll_Linha

Tab_1.Tabpage_1.dw_1.AcceptText()

For ll_Linha = 1 To dw_13.RowCount()
	dw_13.Object.cd_produto[ll_Linha] = Tab_1.Tabpage_1.dw_1.Object.Cd_Produto_Geral[1]
Next

Return True
end function

public function boolean wf_valida_divisao_fornecedor ();String ls_Fornecedor

Long ll_Divisoes

Tab_1.TabPage_1.dw_1.AcceptText()

If IsNull(Tab_1.TabPage_1.dw_1.Object.nr_divisao_fornecedor[1]) Then
	
	ls_Fornecedor = Tab_1.TabPage_1.dw_1.Object.cd_fornecedor_usual[1]
	
	Select count(*) 
	Into :ll_Divisoes
	From fornecedor_divisao
	Where cd_fornecedor = :ls_Fornecedor
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor.")
		Return False
	Else
		If ll_Divisoes > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor.")
			Tab_1.SelectTab(1)
			Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nr_divisao_fornecedor")	
			Return False
		End If	
	End If	
	
End If

Return True
end function

public function boolean wf_atualiza_tributacao_ncm (long al_ncm, ref string as_ncm, ref decimal adc_perc_ipi, ref string as_lista_pis_cofins);Boolean lb_Inicializa = False
Decimal ldc_Nulo
Decimal{4} ldc_Red_BC_ST
Long ll_Linha, ll_Tipo_ICMS, ll_Trib_PRD, ll_Nulo, ll_Aux, ll_Msg_Fiscal, ll_Situacao
String ls_UF, ls_Tributacao, ls_Nulo

SetNull(ls_Nulo)
SetNull(ll_Nulo)
SetNull(ldc_Nulo)

Tab_1.TabPage_2.dw_2.AcceptText()

ll_Aux = Tab_1.TabPage_2.dw_2.Object.Nr_Classificacao_Fiscal[1]

Select de_ncm, coalesce(pc_ipi,0),  id_lista_pis_cofins
Into :as_NCM, :adc_perc_ipi, :as_lista_pis_cofins
from ncm
where nr_ncm = :al_ncm
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "NCM '" + String(al_NCM) + "' n$$HEX1$$e300$$ENDHEX$$o cadastrado.", Exclamation!)
		lb_Inicializa = True
		as_lista_pis_cofins 	= ls_Nulo
		adc_perc_ipi			= ldc_Nulo
		Tab_1.TabPage_2.dw_2.Object.Nr_Classificacao_Fiscal[1] = ll_Aux
		Return False
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar o NCM.")
		Return False
End Choose

as_NCM = "[" + as_NCM + "]"

For ll_Linha = 1 To Tab_1.TabPage_2.dw_7.RowCount()
	ls_UF = Tab_1.TabPage_2.dw_7.Object.Cd_Unidade_Federacao  [ll_Linha]
	
	If Not lb_Inicializa Then
			
		Select nr_sequencial, cd_tributacao_icms, cd_tipo_icms, cd_tributacao_produto, cd_mensagem_fiscal, pc_reducao_base_st
		Into :ll_Situacao, :ls_Tributacao, :ll_Tipo_ICMS, :ll_Trib_PRD, :ll_Msg_Fiscal, :ldc_Red_BC_ST
		from ncm_situacao_especial
		where nr_ncm 		= :al_ncm
			 and cd_uf		= :ls_UF
			 and id_padrao	= 'S'
		Using SqlCa	;
		
		Choose Case SqlCa.SqlCode
			Case 0
				Tab_1.TabPage_2.dw_7.Object.cd_tributacao_icms	 	[ll_Linha] = ls_Tributacao
				Tab_1.TabPage_2.dw_7.Object.cd_tipo_icms			 	[ll_Linha] = ll_Tipo_ICMS
				Tab_1.TabPage_2.dw_7.Object.cd_tributacao_produto 	[ll_Linha] = ll_Trib_PRD
				Tab_1.TabPage_2.dw_7.Object.cd_mensagem_fiscal 	[ll_Linha] = ll_Msg_Fiscal
				Tab_1.TabPage_2.dw_7.Object.nr_ncm_situacao		 	[ll_Linha] = ll_Situacao
				Tab_1.TabPage_2.dw_7.Object.pc_reducao_base_st		[ll_Linha] = ldc_Red_BC_ST
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe tributa$$HEX2$$e700e300$$ENDHEX$$o cadastrada o NCM "+String(al_ncm,"00000000")+" da UF "+ls_UF+".", StopSign!)
				Return False
			Case -1
		End Choose
		
	Else
		Tab_1.TabPage_2.dw_7.Object.cd_tributacao_icms	 	[ll_Linha] = ls_Nulo
		Tab_1.TabPage_2.dw_7.Object.cd_tipo_icms			 	[ll_Linha] = ll_Nulo
		Tab_1.TabPage_2.dw_7.Object.cd_tributacao_produto 	[ll_Linha] = ll_Nulo
	End If
	
Next

Return True
end function

public function boolean wf_valida_tributacao_ncm ();Long ll_Linha
Long ll_Linhas
Long ll_Tipo_Icms
Long ll_Tributacao_Produto
Long ll_Tipo_Icms_Aux
Long ll_Tributacao_Prod_Aux
Long ll_NCM

String ls_Uf
String ls_Tributacao_Icms
String ls_Tributacao_Icms_Aux

Tab_1.TabPage_2.dw_7.AcceptText()

ll_Linhas = Tab_1.TabPage_2.dw_7.RowCount()

If ll_Linhas > 0 Then
	ll_NCM = Tab_1.TabPage_2.dw_2.Object.Nr_Classificacao_Fiscal[1]
	
	For ll_Linha = 1 To ll_Linhas
	
		ls_Uf							= Tab_1.TabPage_2.dw_7.Object.Cd_Unidade_Federacao	[ll_Linha]
		ls_Tributacao_Icms		= Tab_1.TabPage_2.dw_7.Object.Cd_Tributacao_Icms		[ll_Linha]
		ll_Tipo_Icms				= Tab_1.TabPage_2.dw_7.Object.Cd_Tipo_Icms				[ll_Linha]
		ll_Tributacao_Produto		= Tab_1.TabPage_2.dw_7.Object.Cd_Tributacao_Produto	[ll_Linha]
		
		If IsNull(ls_Uf) Then Continue
		
		Select cd_tributacao_icms, cd_tipo_icms, cd_tributacao_produto
		Into :ls_Tributacao_Icms_Aux, :ll_Tipo_Icms_Aux, :ll_Tributacao_Prod_Aux
		From ncm_situacao_especial
		Where nr_ncm	= :ll_NCM
		    And cd_uf	= :ls_Uf
			And id_padrao = 'S'
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				//
				
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a tributa$$HEX2$$e700e300$$ENDHEX$$o na ncm_situacao_especial." + SqlCa.SqlErrText)
				Return False
				
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar ncm_situacao_especial " + SqlCa.SqlErrText)
				Return False
		End Choose
		
		If ls_Tributacao_Icms <> ls_Tributacao_Icms_Aux Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS '" + ls_Tributacao_Icms + "' da U.F. '" + ls_Uf + "' $$HEX1$$e900$$ENDHEX$$ diferente da tributa$$HEX2$$e700e300$$ENDHEX$$o cadastrada '" + ls_Tributacao_Icms_Aux + "'.", Exclamation!)
			Return False
		End If
		
		If ll_Tipo_Icms <> ll_Tipo_Icms_Aux Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo ICMS '" + String(ll_Tipo_Icms) + "' da U.F. '" + ls_Uf + "' $$HEX1$$e900$$ENDHEX$$ diferente do tipo cadastrado '" + String(ll_Tipo_Icms_Aux) + "'.", Exclamation!)
			Return False
		End If
		
		If ll_Tributacao_Produto <> ll_Tributacao_Prod_Aux Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tributa$$HEX2$$e700e300$$ENDHEX$$o Produto '" + String(ll_Tributacao_Produto) + "' da U.F. '" + ls_Uf + "' $$HEX1$$e900$$ENDHEX$$ diferente da tributa$$HEX2$$e700e300$$ENDHEX$$o cadastrada '" + String(ll_Tributacao_Prod_Aux) + "'.", Exclamation!)
			Return False
		End If
	Next
End If

Return True
end function

public function boolean wf_verifica_pbm ();il_Pbm = 0
is_Nm_Pbm = ""

Select Count(pp.cd_pbm)//, p.nm_pbm
	Into :il_Pbm//, :is_Nm_Pbm
From pbm As p
	Inner Join pbm_produto As pp
		On pp.cd_pbm = p.cd_pbm
Where pp.cd_produto = :ivo_Produto.Cd_Produto
//	Group By p.nm_pbm
Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs do produto '" + String(ivo_Produto.Cd_Produto) + "'.")
	Return False
End If

Return True
end function

public function boolean wf_valida_est_min_pbm ();Long ll_Fator
Long ll_Qt_Est_Min

ll_Fator			= Tab_1.TabPage_2.dw_2.Object.Vl_Fator_Conversao	[1]
ll_Qt_Est_Min	= Tab_1.TabPage_2.dw_2.Object.Qt_Estoque_Minimo	[1]

If Mod(ll_Qt_Est_Min, ll_Fator) <> 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser m$$HEX1$$fa00$$ENDHEX$$ltiplo do fator de convers$$HEX1$$e300$$ENDHEX$$o '" + String(ll_Fator) + "' utilizado no estoque central.", Exclamation!)
	Tab_1.SelectTab(6)
	Tab_1.TabPage_4.dw_15.Event ue_Pos(1, 'qt_estoque_minimo' )
	Return False
End If

If ll_Fator > 1 Then
	If ll_Qt_Est_Min > ll_Fator Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto possui fator de convers$$HEX1$$e300$$ENDHEX$$o. A quantidade dever$$HEX1$$e100$$ENDHEX$$ ser igual ao fator de convers$$HEX1$$e300$$ENDHEX$$o '" + String(ll_Fator) + "'.")
		Tab_1.SelectTab(6)
		Tab_1.TabPage_4.dw_15.Event ue_Pos(1, 'qt_estoque_minimo' )
		Return False
	End If
	
Else
	If ll_Qt_Est_Min > 3 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade de estoque m$$HEX1$$ed00$$ENDHEX$$nimo PBM n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que 3.")
		Tab_1.SelectTab(6)
		Tab_1.TabPage_4.dw_15.Event ue_Pos(1, 'qt_estoque_minimo' )
		Return False
	End If
End If

Return True
end function

public subroutine wf_atalhos (keycode as_tecla);Boolean lvb_Sucesso = False

Long lvl_Produto_Novo,&
		 lvl_Produto_Atual
			 
String ls_Responsavel

Choose Case as_tecla	
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If
		
	Case KeyF12!
		
		If Not ivb_Possui_Permissao Then Return
		
		If Not ib_Permite_Alter_Cutover Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para cadastrar um novo produto utilize o SAP.", Exclamation!)
			Return
		End If
			
		If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE400_FUNCAO_COPIA_PRODUTO", ref ls_Responsavel ) Then 
			Return
		End If
			
		lvl_Produto_Atual = Tab_1.TabPage_1.dw_1.Object.cd_produto_central[1]
		
		If IsNull(lvl_Produto_Atual) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para gerar um novo cadastro.")
			Return
		End If
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a c$$HEX1$$f300$$ENDHEX$$pia das informa$$HEX2$$e700f500$$ENDHEX$$es para um novo cadastro ?", Question!, YesNo!, 2) = 2 Then
			Return
		End If
		
		If Not wf_Atualiza_Sequencial_Produto(Ref lvl_Produto_Novo) Then
			Return
		End If
		
		If wf_Inclui_Produto_Geral(lvl_Produto_Atual, lvl_Produto_Novo) Then
			If wf_Inclui_Produto_Central(lvl_Produto_Atual, lvl_Produto_Novo) Then
				If wf_Inclui_Produto_UF(lvl_Produto_Atual, lvl_Produto_Novo) Then
					If wf_Inclui_Comissao_Produto(lvl_Produto_Atual, lvl_Produto_Novo) Then
						If wf_Inclui_Promocao_Produto_Novo(lvl_Produto_Novo) Then
							//If wf_Inclui_Produto_Aprovacao(lvl_Produto_Novo, 'I') Then
								lvb_Sucesso = True
							//End If
						End If
					End If
				End If
			End If
		End If
		
		If lvb_Sucesso Then
			SqlCa.of_Commit();
		
			ivo_Produto.of_Localiza_Produto(String(lvl_Produto_Novo))
					
			If ivo_Produto.Localizado Then
				Tab_1.TabPage_1.dw_1.Event ue_Retrieve()
				
				Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Confirmar(True)
				Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Cancelar(True)
				
				ivb_Valida_Salva = True
			End If
		Else
			SqlCa.of_RollBack();
		End If
			
End Choose
end subroutine

public subroutine wf_set_somente_consulta ();If Not gf_Verifica_Cutover("DH_CUTOVER_MATERIAL") Then
	//Se n$$HEX1$$e300$$ENDHEX$$o passar da valida$$HEX2$$e700e300$$ENDHEX$$o do SAP libera somente os campos que est$$HEX1$$e300$$ENDHEX$$o abaixo
		
	ib_Permite_Alter_Cutover = False
	
	If This.ivm_menu.ivb_permite_alterar Then
		is_Dw_Geral[1] = "nr_divisao_fornecedor"
		is_Dw_Geral[2] = "de_subcategoria"
		is_Dw_Geral[3] = "cd_categ_mercadologica"
		
		is_Dw_Subs[1] = "cd_substancia"
		is_Dw_Subs[2] = "qt_concentracao"
		
		is_Dw_Fiscal_Pre[1] = "vl_preco_reposicao"
		is_Dw_Fiscal_Pre[2] = "vl_preco_venda_atual"
		
		is_Dw_Fiscal_Pre_dw2[1] = "pc_desconto_fornecedor"
		
		gf_ge400_Permite_Alterar_Campos_Cutover(False, is_Dw_Geral[], Tab_1.TabPage_1.dw_1)
		gf_ge400_Permite_Alterar_Campos_Cutover(False, is_Dw_Subs[], Tab_1.TabPage_6.dw_12)
		gf_ge400_Permite_Alterar_Campos_Cutover(False, is_Dw_Fiscal_Pre[], Tab_1.TabPage_2.dw_14)
		gf_ge400_Permite_Alterar_Campos_Cutover(False, is_Dw_Fiscal_Pre_dw2[], Tab_1.TabPage_2.dw_2)
	End If
	
	Tab_1.TabPage_3.dw_3.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = False) 
	Tab_1.TabPage_3.dw_4.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = False) 
	Tab_1.TabPage_3.dw_5.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = False) 
	Tab_1.TabPage_4.dw_6.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = False) 
	Tab_1.TabPage_2.dw_7.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = False) 
	Tab_1.TabPage_2.dw_8.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = False) 
	Tab_1.TabPage_2.dw_9.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = False) 
	Tab_1.TabPage_4.dw_15.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = False) 
	Tab_1.TabPage_4.dw_15.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = True) 
	
	dw_13.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = False)
	
//	if is_usa_lista_tecnica = 'S' Then
		Tab_1.TabPage_6.dw_12.of_Set_Somente_Leitura( false ) 
//	end if
	
Else
	//Se passar da valida$$HEX2$$e700e300$$ENDHEX$$o do SAP faz o controle das dws 1, 12 e 14 conforme permiss$$HEX1$$e300$$ENDHEX$$o do usu$$HEX1$$e100$$ENDHEX$$rio
	
	Tab_1.TabPage_1.dw_1.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 	
	
//	if is_usa_lista_tecnica = 'S' Then
		Tab_1.TabPage_6.dw_12.of_Set_Somente_Leitura( false ) 
//	else	
//		Tab_1.TabPage_6.dw_12.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar)
//	end if
	
	Tab_1.TabPage_2.dw_14.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	Tab_1.TabPage_2.dw_2.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	Tab_1.TabPage_3.dw_3.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	Tab_1.TabPage_3.dw_4.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	Tab_1.TabPage_3.dw_5.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	Tab_1.TabPage_4.dw_6.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	Tab_1.TabPage_2.dw_7.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	Tab_1.TabPage_2.dw_8.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	Tab_1.TabPage_2.dw_9.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	//Tab_1.TabPage_5.dw_10.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	Tab_1.TabPage_4.dw_15.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
	dw_13.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar)
End If
end subroutine

public function boolean wf_grava_historico_aba_geral ();DateTime ldh_Inclusao_Prod, ldh_Situacao, ldh_Termino_Ava

Decimal ldc_Vl_Volume, ldc_Concent, ldc_Desc_Forn

Long ll_Marca, ll_Qtd_Emb, ll_Cd_Fab, ll_Planograma, ll_Qt_Dias_Max_Trat, ll_Tipo_Prescri

String	ls_Mensagem, ls_Operador, ls_Descricao, ls_De_Apre_Est, ls_De_Apres_Ven, ls_Id_Apresentacao, ls_Situacao, ls_Forn, ls_Subcat, &
		ls_De_Alter, ls_Registro_Ms, ls_Uni_Med_Comp, ls_Uni_Med_Ven, ls_Produto_Forn, ls_Origem_Prod_Forn, ls_Linha_Prod, ls_Dcb, &
		ls_Lei_Gen, ls_Grupo_Psico, lvs_ValorPara, ls_Gluten, ls_Acucar, ls_Lactose, ls_Erro, ls_De, ls_Matric_Alter, ls_Chave

Tab_1.Tabpage_1.dw_1.AcceptText()

Select	g.de_produto, g.de_apresentacao_estoque, g.de_apresentacao_venda, g.id_apresentacao, g.cd_marca, coalesce(g.qt_unidades_embalagem, 0),
		g.cd_fabricante, g.cd_fornecedor_usual, g.cd_subcategoria, g.id_situacao, c.de_alteracao_situacao, g.de_registro_ms,
		g.dh_inclusao_produto, g.cd_unidade_medida_compra, g.cd_unidade_medida_venda, g.vl_volume, g.qt_concentracao, c.cd_produto_fornecedor,
		c.id_origem_produto_fornecedor, g.cd_planograma, g.cd_linha_produto, g.cd_dcb, c.id_lei_generico,
		g.cd_grupo_psico, coalesce(g.qt_dias_maximo_tratamento, 0), g.id_contem_gluten, g.id_contem_acucar, g.id_contem_lactose, g.dh_termino_avaliacao,
		c.dh_situacao, c.nr_matric_solicitacao_alt_sit, g.cd_tipo_prescricao
Into	:ls_Descricao, :ls_De_Apre_Est, :ls_De_Apres_Ven, :ls_Id_Apresentacao, :ll_Marca, :ll_Qtd_Emb,
		:ll_Cd_Fab, :ls_Forn, :ls_Subcat, :ls_Situacao, :ls_De_Alter, :ls_Registro_Ms,
		:ldh_Inclusao_Prod, :ls_Uni_Med_Comp, :ls_Uni_Med_Ven, :ldc_Vl_Volume, :ldc_Concent, :ls_Produto_Forn,
	 	:ls_Origem_Prod_Forn, :ll_Planograma, :ls_Linha_Prod, :ls_Dcb, :ls_Lei_Gen,
		:ls_Grupo_Psico, :ll_Qt_Dias_Max_Trat, :ls_Gluten, :ls_Acucar, :ls_Lactose, :ldh_Termino_Ava,
		:ldh_Situacao, :ls_Matric_Alter, :ll_Tipo_Prescri
From produto_geral as g
	Inner Join produto_central c
		On c.cd_produto = g.cd_produto
Where g.cd_produto = :ivo_Produto.Cd_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//		
	Case 100
		Return True
		
	Case -1
		SqlCa.of_MsgdbError()
		Return False
End Choose

ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

ls_Chave = String(ivo_Produto.Cd_Produto)

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'DE_PRODUTO', 1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'DE_PRODUTO', ls_Descricao, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'DE_APRESENTACAO_ESTOQUE', 1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'DE_APRESENTACAO_ESTOQUE', ls_De_Apre_Est, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'DE_APRESENTACAO_VENDA',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'DE_APRESENTACAO_VENDA', ls_De_Apres_Ven, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'ID_APRESENTACAO',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_APRESENTACAO', ls_Id_Apresentacao, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_MARCA',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_MARCA', String(ll_Marca), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_TIPO_PRESCRICAO',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_TIPO_PRESCRICAO', String(ll_Tipo_Prescri), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'QT_UNIDADES_EMBALAGEM',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'QT_UNIDADES_EMBALAGEM', String(ll_Qtd_Emb), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_FABRICANTE', 1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_FABRICANTE', String(ll_Cd_Fab), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_FORNECEDOR_USUAL',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_FORNECEDOR_USUAL', ls_Forn, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_SUBCATEGORIA',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_SUBCATEGORIA', ls_Subcat, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'ID_SITUACAO',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_SITUACAO', ls_Situacao, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'DE_ALTERACAO_SITUACAO',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'DE_ALTERACAO_SITUACAO', ls_De_Alter, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'DE_REGISTRO_MS',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'DE_REGISTRO_MS', ls_Registro_Ms, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'DH_INCLUSAO_PRODUTO',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'DH_INCLUSAO_PRODUTO', String(ldh_Inclusao_Prod), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_UNIDADE_MEDIDA_COMPRA',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_UNIDADE_MEDIDA_COMPRA', ls_Uni_Med_Comp, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_UNIDADE_MEDIDA_VENDA',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_UNIDADE_MEDIDA_VENDA', ls_Uni_Med_Ven, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'VL_VOLUME',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'VL_VOLUME', String(ldc_Vl_Volume), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'QT_CONCENTRACAO',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'QT_CONCENTRACAO', String(ldc_Concent), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_PRODUTO_FORNECEDOR',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'CD_PRODUTO_FORNECEDOR', ls_Produto_Forn, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'ID_ORIGEM_PRODUTO_FORNECEDOR',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'ID_ORIGEM_PRODUTO_FORNECEDOR', ls_Origem_Prod_Forn, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_PLANOGRAMA',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_PLANOGRAMA', String(ll_Planograma), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_LINHA_PRODUTO', 1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_LINHA_PRODUTO', ls_Linha_Prod, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_DCB', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_DCB', ls_Dcb, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'ID_LEI_GENERICO',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'ID_LEI_GENERICO', ls_Lei_Gen, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_GRUPO_PSICO', 1, lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_GRUPO_PSICO', ls_Grupo_Psico, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'QT_DIAS_MAXIMO_TRATAMENTO',1, ref lvs_ValorPara) Then	
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'QT_DIAS_MAXIMO_TRATAMENTO', String(ll_Qt_Dias_Max_Trat), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'ID_CONTEM_GLUTEN',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_CONTEM_GLUTEN', ls_Gluten, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'ID_CONTEM_ACUCAR',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_CONTEM_ACUCAR', ls_Acucar, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'ID_CONTEM_LACTOSE',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_CONTEM_LACTOSE', ls_Lactose, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'DH_TERMINO_AVALIACAO',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'DH_TERMINO_AVALIACAO', String(ldh_Termino_Ava), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'DH_SITUACAO',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'DH_SITUACAO', String(ldh_Situacao), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'NR_MATRIC_SOLICITACAO_ALT_SIT',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'NR_MATRIC_SOLICITACAO_ALT_SIT', ls_Matric_Alter, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

Return True
end function

public function boolean wf_grava_historico_aba_substancias ();Decimal ldc_Concentracao

Long ll_Linha, ll_Cd_Substancia, ll_Cd_Substancia_Aux, ll_Find

String ls_Operador, ls_Find, ls_Nulo, ls_Chave, lvs_ValorPara, ls_Erro

SetNull(ls_Nulo)

ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

For ll_Linha = 1 To Tab_1.TabPage_6.dw_12.RowCount()
	
	ll_Cd_Substancia_Aux = Tab_1.TabPage_6.dw_12.Object.Cd_Substancia[ll_Linha]
	
	ls_Chave = String(ivo_Produto.Cd_Produto) + '@#!' + String(ll_Cd_Substancia_Aux)

	SELECT TOP 1 cd_substancia, qt_concentracao 
		INTO :ll_Cd_Substancia, :ldc_Concentracao
	 FROM composicao_produto   
		WHERE cd_substancia= :ll_Cd_Substancia_Aux
		AND cd_produto		= :ivo_Produto.Cd_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If gf_Houve_Alteracao_Dw(Tab_1.TabPage_6.dw_12, 'QT_CONCENTRACAO', ll_Linha, ref lvs_ValorPara) Then			
				If Not gf_Grava_Historico_Alteracao_Tabela('COMPOSICAO_PRODUTO', ls_Chave, 'QT_CONCENTRACAO', String(ldc_Concentracao), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
			End If
			
		Case 100
			
			If Not gf_Grava_Historico_Alteracao_Tabela('COMPOSICAO_PRODUTO', ls_Chave, 'CD_SUBSTANCIA', ls_Nulo, String(ll_Cd_Substancia_Aux), ls_Operador, 'I', Ref ls_Erro, True) Then Return False						
			If Not gf_Grava_Historico_Alteracao_Tabela('COMPOSICAO_PRODUTO', ls_Chave, 'QT_CONCENTRACAO', ls_Nulo, String(Tab_1.TabPage_6.dw_12.Object.Qt_Concentracao[ll_Linha]), ls_Operador, 'I', Ref ls_Erro, True) Then Return False
			
		Case -1
			SqlCa.of_MsgdbError()
			Return False
	End Choose
Next

//Verifica exclus$$HEX1$$e300$$ENDHEX$$o

Try

	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("dw_ge400_detalhe_substancias") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a data store 'dw_ge400_detalhe_substancias'.", StopSign!)
		Return False
	End If
	
	lds.Retrieve(ivo_Produto.Cd_Produto)
	
	If lds.RowCount() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es.", StopSign!)
		Return False
	End If
	
	If lds.RowCount() > 0 Then
		For ll_Linha = 1 To lds.RowCount()
			ls_Find = ("cd_substancia = " + String(lds.Object.Cd_Substancia[ll_Linha]))
			ll_Find = Tab_1.TabPage_6.dw_12.Find(ls_Find, 1, Tab_1.TabPage_6.dw_12.RowCount())
			
			If ll_Find < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_12.", StopSign!)
				Return False
			End If
			
			ls_Chave = String(ivo_Produto.Cd_Produto) + '@#!' + String(lds.Object.Cd_Substancia[ll_Linha])
			
			If ll_Find = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na fun$$HEX2$$e700e300$$ENDHEX$$o Find da dw_12.", StopSign!)
				Return False
			End If
			
			If ll_Find = 0 Then
				If Not gf_Grava_Historico_Alteracao_Tabela('COMPOSICAO_PRODUTO', ls_Chave, 'CD_SUBSTANCIA', String(lds.Object.Cd_Substancia[ll_Linha]), ls_Nulo, ls_Operador, 'E', Ref ls_Erro, True) Then Return False
				If Not gf_Grava_Historico_Alteracao_Tabela('COMPOSICAO_PRODUTO', ls_Chave, 'QT_CONCENTRACAO', String(lds.Object.Qt_Concentracao[ll_Linha]), ls_Nulo, ls_Operador, 'E', Ref ls_Erro, True) Then Return False
			End If
		Next
	End If
	
	Return True
	
Finally
	If IsValid(lds) Then Destroy(lds)
End Try
end function

public function boolean wf_grava_historico_aba_ecommerce ();Decimal ldc_Qt_Altura, ldc_Qt_Largura, ldc_Qt_Profundidade, ldc_Peso

Long ll_Marca_Ecommerce

String	ls_Exclusivo, ls_Liberado_Ecommerce, ls_Mensagem, ls_Operador, ls_Descricao_Internet, ls_Princ_Internet, lvs_ValorPara, ls_Erro, ls_Chave
		
Tab_1.TabPage_5.dw_10.AcceptText()

Select 	coalesce(g.id_exclusivo, 'N'), coalesce(g.id_liberado_ecommerce, 'N'), g.de_descricao_internet, g.de_principal_internet,
			g.qt_altura_cm, g.qt_largura_cm, g.qt_profundidade_cm, g.qt_peso_grama, g.cd_marca_ecommerce
	Into 	:ls_Exclusivo, :ls_Liberado_Ecommerce, :ls_Descricao_Internet, :ls_Princ_Internet,
			:ldc_Qt_Altura, :ldc_Qt_Largura, :ldc_Qt_Profundidade, :ldc_Peso, :ll_Marca_Ecommerce
From produto_geral g
Where g.cd_produto = :ivo_Produto.Cd_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		Return True
		
	Case -1
		SqlCa.of_MsgdbError()
		Return False
End Choose

ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
ls_Chave = String(ivo_Produto.Cd_Produto)

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_5.dw_10, 'ID_EXCLUSIVO',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_EXCLUSIVO', ls_Exclusivo, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If	

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_5.dw_10, 'ID_LIBERADO_ECOMMERCE',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_LIBERADO_ECOMMERCE', ls_Liberado_Ecommerce, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_5.dw_10, 'DE_DESCRICAO_INTERNET',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'DE_DESCRICAO_INTERNET', ls_Descricao_Internet, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_5.dw_10, 'DE_PRINCIPAL_INTERNET',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'DE_PRINCIPAL_INTERNET', ls_Princ_Internet, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_5.dw_10, 'QT_ALTURA_CM',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'QT_ALTURA_CM', String(ldc_Qt_Altura),lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_5.dw_10, 'QT_LARGURA_CM',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'QT_LARGURA_CM', String(ldc_Qt_Largura), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_5.dw_10, 'QT_PROFUNDIDADE_CM',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'QT_PROFUNDIDADE_CM', String(ldc_Qt_Profundidade), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_5.dw_10, 'QT_PESO_GRAMA',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'QT_PESO_GRAMA', String(ldc_Peso), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_5.dw_10, 'CD_MARCA_ECOMMERCE',1, ref lvs_ValorPara) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_MARCA_ECOMMERCE', String(ll_Marca_Ecommerce), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

Return True
end function

public function boolean wf_grava_historico_aba_fiscal_pricing ();Decimal ldc_Desc_Forn

Long ll_Nr_Class_Fiscal

String	ls_Operador, ls_Id_Cad_Abcfarma, ls_St_Origem, ls_Farmacia_Popular, ls_Gratis_Farm_Pop, ls_Erro, ls_Chave, lvs_ValorPara, ls_Prd_ABCFar

Tab_1.TabPage_2.dw_2.AcceptText()

SELECT	g.nr_classificacao_fiscal, c.cd_produto_abcfarma, coalesce(g.id_caderno_abcfarma, 'N'), g.cd_st_origem, coalesce(g.id_farmacia_popular, 'N'),
			coalesce(g.id_gratis_farm_popular, 'N'), c.pc_desconto_fornecedor						
INTO	:ll_Nr_Class_Fiscal, :ls_Prd_ABCFar, :ls_Id_Cad_Abcfarma, :ls_St_Origem, :ls_Farmacia_Popular,
		:ls_Gratis_Farm_Pop, :ldc_Desc_Forn
FROM produto_geral g
	INNER JOIN produto_central c
		ON c.cd_produto = g.cd_produto
WHERE g.cd_produto = :ivo_Produto.Cd_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	
	Case 100
		Return True
	
	Case -1
		SqlCa.of_MsgdbError()
		Return False
End Choose

ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
ls_Chave = String(ivo_Produto.Cd_Produto)

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_2, 'NR_CLASSIFICACAO_FISCAL', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'NR_CLASSIFICACAO_FISCAL', String(ll_Nr_Class_Fiscal), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_2, 'CD_ST_ORIGEM', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_ST_ORIGEM', ls_St_Origem, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_2, 'ID_CADERNO_ABCFARMA', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_CADERNO_ABCFARMA', ls_Id_Cad_Abcfarma, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_2, 'ID_FARMACIA_POPULAR', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_FARMACIA_POPULAR', ls_Farmacia_Popular, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_2, 'ID_GRATIS_FARM_POPULAR', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_GRATIS_FARM_POPULAR', ls_Gratis_Farm_Pop, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_2, 'PC_DESCONTO_FORNECEDOR', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'PC_DESCONTO_FORNECEDOR', String(ldc_Desc_Forn), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_2, 'CD_PRODUTO_ABCFARMA', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'CD_PRODUTO_ABCFARMA', ls_Prd_ABCFar, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

Return True
end function

public function boolean wf_grava_historico_preco_uf ();Decimal ldc_Pre_Repos, ldc_Pre_Venda_Atual, ldc_Icms_Comp_Preco, ldc_Icms_Venda_Preco, ldc_Margem_Res_Pre

Long ll_Linha

String ls_Uf, ls_Operador, ls_Chave, ls_ValorPara, ls_Erro

Tab_1.TabPage_2.dw_7.AcceptText()
Tab_1.TabPage_2.dw_8.AcceptText()
Tab_1.TabPage_2.dw_14.AcceptText()

For ll_Linha = 1 To Tab_1.TabPage_2.dw_7.RowCount()
	
	ls_Uf = Tab_1.TabPage_2.dw_7.Object.Cd_Unidade_Federacao[ll_Linha]

	Select vl_preco_reposicao, vl_preco_venda_atual, pc_icms_compra_preco,	pc_icms_venda_preco, pc_margem_resultado_preco			
		Into :ldc_Pre_Repos, :ldc_Pre_Venda_Atual, :ldc_Icms_Comp_Preco, :ldc_Icms_Venda_Preco, :ldc_Margem_Res_Pre			
	From produto_uf
	Where cd_produto 				= :ivo_Produto.Cd_Produto
		And cd_unidade_federacao 	= :ls_UF
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
						
		Case 100
			Return True
			
		Case -1
			SqlCa.of_MsgdbError()
			Return False			
	End Choose
	
	ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	ls_Chave = ls_UF + '@#!' + String(ivo_Produto.Cd_Produto)
	
	If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_7, 'PC_ICMS_COMPRA_PRECO', ll_Linha, ref ls_ValorPara) Then
		If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_UF', ls_Chave, 'PC_ICMS_COMPRA_PRECO', String(ldc_Icms_Comp_Preco), ls_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
	End If
	
	If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_7, 'PC_ICMS_VENDA_PRECO', ll_Linha, ref ls_ValorPara) Then
		If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_UF', ls_Chave, 'PC_ICMS_VENDA_PRECO', String(ldc_Icms_Venda_Preco), ls_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
	End If
		
	If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_7, 'VL_PRECO_REPOSICAO', ll_Linha, ref ls_ValorPara) Then
		If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_UF', ls_Chave, 'VL_PRECO_REPOSICAO', String(ldc_Pre_Repos), ls_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
	End If
	
	If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_7, 'VL_PRECO_VENDA_ATUAL', ll_Linha, ref ls_ValorPara) Then
		If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_UF', ls_Chave, 'VL_PRECO_VENDA_ATUAL', String(ldc_Pre_Venda_Atual), ls_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
	End If
	
	If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_7, 'PC_MARGEM_RESULTADO_PRECO', ll_Linha, ref ls_ValorPara) Then
		If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_UF', ls_Chave, 'PC_MARGEM_RESULTADO_PRECO', String(ldc_Margem_Res_Pre), ls_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
	End If
Next

Return True
end function

public function boolean wf_grava_historico_comissao ();Decimal ldc_Pc_Comissao

Long ll_Linha, ll_Cd_Comissao, ll_Cd_Comissao_Aux, ll_Find

String ls_Operador, ls_Find, ls_Nulo, ls_Chave, ls_AlteraPara, ls_Erro

SetNull(ls_Nulo)

ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

For ll_Linha = 1 To Tab_1.TabPage_2.dw_9.RowCount()
	
	ll_Cd_Comissao_Aux	= Tab_1.TabPage_2.dw_9.Object.Cd_Tipo_Comissao[ll_Linha]
	ls_Chave					= String(ivo_Produto.Cd_Produto) + '@#!' + String(ll_Cd_Comissao_Aux)

	Select	t.cd_tipo_comissao, t.pc_comissao
	Into :ll_Cd_Comissao, :ldc_Pc_Comissao
	From tipo_comissao_produto t
	Where t.cd_produto			= :ivo_Produto.Cd_Produto
		And t.cd_tipo_comissao	= :ll_Cd_Comissao_Aux
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0			
			If gf_Houve_Alteracao_Dw(Tab_1.TabPage_2.dw_9, 'PC_COMISSAO', ll_Linha, ref ls_AlteraPara ) Then
				If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'PC_COMISSAO', String(ldc_Pc_Comissao), ls_AlteraPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
			End If
			
		Case 100
			
			If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'CD_TIPO_COMISSAO', ls_Nulo, String(ll_Cd_Comissao_Aux), ls_Operador, 'I', Ref ls_Erro, True) Then Return False			
			If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'PC_COMISSAO', ls_Nulo, String(Tab_1.TabPage_2.dw_9.Object.Pc_Comissao[ll_Linha]), ls_Operador, 'I', Ref ls_Erro, True) Then Return False
			
		Case -1
			SqlCa.of_MsgdbError()
			Return False
	End Choose
Next

//Verifica exclus$$HEX1$$e300$$ENDHEX$$o

Try

	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("dw_ge400_detalhe_comissao") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a data store 'dw_ge400_detalhe_comissao'.", StopSign!)
		Return False
	End If
	
	lds.Retrieve(ivo_Produto.Cd_Produto)
	
	If lds.RowCount() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da data store 'dw_ge400_detalhe_comissao'.", StopSign!)
		Return False
	End If
	
	If lds.RowCount() > 0 Then
		For ll_Linha = 1 To lds.RowCount()
			ls_Find = ("t.cd_tipo_comissao = " + String(lds.Object.Cd_Tipo_Comissao[ll_Linha]))
			ll_Find = Tab_1.TabPage_2.dw_9.Find(ls_Find, 1, Tab_1.TabPage_2.dw_9.RowCount())
			
			If ll_Find < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na fun$$HEX2$$e700e300$$ENDHEX$$o Find da dw_9.", StopSign!)
				Return False
			End If
			
			ls_Chave = String(ivo_Produto.Cd_Produto) + '@#!' + String(lds.Object.Cd_Tipo_Comissao[ll_Linha])
			
			If ll_Find = 0 Then
				If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'CD_TIPO_COMISSAO', String(lds.Object.Cd_Tipo_Comissao[ll_Linha]), ls_Nulo, ls_Operador, 'E', Ref ls_Erro, True) Then Return False
				If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'PC_COMISSAO', String(lds.Object.Pc_Comissao[ll_Linha]), ls_Nulo, ls_Operador, 'E', Ref ls_Erro, True) Then Return False
			End If
		Next
	End If
	
	Return True
	
Finally
	If IsValid(lds) Then Destroy(lds)
End Try
end function

public function boolean wf_grava_historico_aba_estoque ();Decimal	ldc_Vl_Fat_Conv, ldc_Alt_Cx_For, ldc_Larg_Cx_For, ldc_Pro_Cx_For, ldc_Alt_Cx_Est, ldc_Larg_Cx_Est, ldc_Pro_Cx_Est, ldc_Pt_Clube, ldc_Pt_Resgate

Long ll_Mix_Produto, ll_Nr_Emba_Padrao, ll_Qt_Est_Min, ll_Fat_Con_Padrao

String	ls_Operador, ls_Proprio_Consig, ls_Repos_Est, ls_Id_Geladeira, ls_Sugere_Pedido, ls_Utiliza_Vale_Res, lvs_ValorPara, ls_Id_Prom_Venda, ls_Permite_Dev, &
		ls_Erro, ls_Chave, ls_Uni_Med_Pad, ls_Conexao

Tab_1.TabPage_4.dw_15.AcceptText()

SELECT	g.id_proprio_consignado, c.id_tipo_reposicao_estoque, c.cd_mix_produto, g.nr_embalagem_padrao, g.vl_fator_conversao, coalesce(g.id_geladeira, 'N'),
			c.qt_altura_cm_caixa_forn, c.qt_largura_cm_caixa_forn, c.qt_profundidade_cm_caixa_forn, c.qt_altura_cm_caixa_estoque, c.qt_largura_cm_caixa_estoque,
			c.qt_profund_cm_caixa_estoque, coalesce(id_sugere_pedido_filial, 'N'), coalesce(g.id_utiliza_vale_resgate, 'N'), coalesce(g.vl_ponto_clube, 0),
			coalesce(g.qt_pontos_resgate, 0), coalesce(g.id_promover_venda, 'N'), coalesce(id_permite_devolucao, 'N'), g.qt_estoque_minimo, g.cd_unidade_medida_padrao,
			g.vl_fator_conversao_padrao, coalesce(c.id_projeto_conexao, 'N')
INTO	:ls_Proprio_Consig, :ls_Repos_Est, :ll_Mix_Produto, :ll_Nr_Emba_Padrao, :ldc_Vl_Fat_Conv, :ls_Id_Geladeira,
		:ldc_Alt_Cx_For, :ldc_Larg_Cx_For, :ldc_Pro_Cx_For, :ldc_Alt_Cx_Est, :ldc_Larg_Cx_Est,
		:ldc_Pro_Cx_Est, :ls_Sugere_Pedido, :ls_Utiliza_Vale_Res, :ldc_Pt_Clube,
		:ldc_Pt_Resgate, :ls_Id_Prom_Venda, :ls_Permite_Dev, :ll_Qt_Est_Min, :ls_Uni_Med_Pad,
		:ll_Fat_Con_Padrao, :ls_Conexao
FROM produto_geral g
	INNER JOIN produto_central c
		ON c.cd_produto = g.cd_produto
WHERE g.cd_produto = :ivo_Produto.Cd_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	
	Case 100
		Return True
	
	Case -1
		SqlCa.of_MsgdbError()
		Return False
End Choose

ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
ls_Chave = String(ivo_Produto.Cd_Produto)

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'CD_MIX_PRODUTO', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'CD_MIX_PRODUTO', String(ll_Mix_Produto), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'ID_PROPRIO_CONSIGNADO', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_PROPRIO_CONSIGNADO', ls_Proprio_Consig, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'ID_TIPO_REPOSICAO_ESTOQUE', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'ID_TIPO_REPOSICAO_ESTOQUE', ls_Repos_Est, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'QT_ESTOQUE_MINIMO', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'QT_ESTOQUE_MINIMO', String(ll_Qt_Est_Min), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'ID_GELADEIRA', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_GELADEIRA', ls_Id_Geladeira, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'VL_FATOR_CONVERSAO', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'VL_FATOR_CONVERSAO', String(ldc_Vl_Fat_Conv), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'NR_EMBALAGEM_PADRAO', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'NR_EMBALAGEM_PADRAO', String(ll_Nr_Emba_Padrao), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'QT_ALTURA_CM_CAIXA_FORN', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'QT_ALTURA_CM_CAIXA_FORN', String(ldc_Alt_Cx_For), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'QT_LARGURA_CM_CAIXA_FORN', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'QT_LARGURA_CM_CAIXA_FORN', String(ldc_Larg_Cx_For), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'QT_PROFUNDIDADE_CM_CAIXA_FORN', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'QT_PROFUNDIDADE_CM_CAIXA_FORN', String(ldc_Pro_Cx_For), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'QT_ALTURA_CM_CAIXA_ESTOQUE', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'QT_ALTURA_CM_CAIXA_ESTOQUE', String(ldc_Alt_Cx_Est), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'QT_LARGURA_CM_CAIXA_ESTOQUE', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'QT_LARGURA_CM_CAIXA_ESTOQUE', String(ldc_Larg_Cx_Est), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'QT_PROFUND_CM_CAIXA_ESTOQUE', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'QT_PROFUND_CM_CAIXA_ESTOQUE', String(ldc_Pro_Cx_Est), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'ID_PERMITE_DEVOLUCAO', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_PERMITE_DEVOLUCAO', Upper(ls_Permite_Dev), Upper(lvs_ValorPara), ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'ID_SUGERE_PEDIDO_FILIAL', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'ID_SUGERE_PEDIDO_FILIAL', ls_Sugere_Pedido, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'ID_PROMOVER_VENDA', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_PROMOVER_VENDA', ls_Id_Prom_Venda, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'ID_UTILIZA_VALE_RESGATE', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'ID_UTILIZA_VALE_RESGATE', ls_Utiliza_Vale_Res, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'VL_PONTO_CLUBE', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'VL_PONTO_CLUBE', String(ldc_Pt_Clube), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'QT_PONTOS_RESGATE', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'QT_PONTOS_RESGATE', String(ldc_Pt_Resgate), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'CD_UNIDADE_MEDIDA_PADRAO', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'CD_UNIDADE_MEDIDA_PADRAO', ls_Uni_Med_Pad, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'VL_FATOR_CONVERSAO_PADRAO', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_GERAL', ls_Chave, 'VL_FATOR_CONVERSAO_PADRAO', String(ll_Fat_Con_Padrao), lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_15, 'ID_PROJETO_CONEXAO', 1, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', ls_Chave, 'ID_PROJETO_CONEXAO', ls_Conexao, lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
End If

Return True
end function

public function boolean wf_grava_historico_ean ();Long ll_Linha, ll_Find

String ls_Cod_Barras, ls_Cod_Barras_Aux, ls_Principal, ls_Principal_Aux, ls_Operador, ls_Nulo, ls_Find, ls_AlteraPara, ls_Erro, ls_Chave

Tab_1.TabPage_4.dw_6.AcceptText()

SetNull(ls_Nulo)

ls_Operador = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

For ll_Linha = 1 To Tab_1.TabPage_4.dw_6.RowCount()
		
	ls_Cod_Barras_Aux	= Tab_1.TabPage_4.dw_6.Object.De_Codigo_Barras	[ll_Linha]
	ls_Principal_Aux		= Tab_1.TabPage_4.dw_6.Object.Id_Principal			[ll_Linha]
	
	ls_Chave = ls_Cod_Barras_Aux
	
	Select	de_codigo_barras, id_principal
		Into :ls_Cod_Barras, :ls_Principal
	From codigo_barras_produto
	Where de_codigo_barras	= :ls_Cod_Barras_Aux
	    And cd_produto				= :ivo_Produto.Cd_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If gf_Houve_Alteracao_Dw(Tab_1.TabPage_4.dw_6, 'ID_PRINCIPAL', ll_Linha, ref ls_AlteraPara ) Then
				If Not gf_Grava_Historico_Alteracao_Tabela('CODIGO_BARRAS_PRODUTO', ls_Chave, 'ID_PRINCIPAL', ls_Principal, ls_AlteraPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
			End If
		
		Case 100
			
			If Not gf_Grava_Historico_Alteracao_Tabela('CODIGO_BARRAS_PRODUTO', ls_Chave, 'DE_CODIGO_BARRAS', ls_Nulo, ls_Cod_Barras_Aux, ls_Operador, 'I', Ref ls_Erro, True) Then Return False			
			If Not gf_Grava_Historico_Alteracao_Tabela('CODIGO_BARRAS_PRODUTO', ls_Chave, 'ID_PRINCIPAL', ls_Nulo, ls_Principal_Aux, ls_Operador, 'I', Ref ls_Erro, True) Then Return False
			
		Case -1
			SqlCa.of_MsgdbError()
			Return False
	End Choose
		
Next

//Verifica exclus$$HEX1$$e300$$ENDHEX$$o

Try
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("dw_ge400_detalhe_codigo_barras") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'dw_ge400_detalhe_codigo_barras'.")
		Return False
	End If
	
	lds.Retrieve(ivo_Produto.Cd_Produto)
	
	If lds.RowCount() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw_ge400_detalhe_codigo_barras.", StopSign!)
		Return False
	End If
	
	For ll_Linha = 1 To lds.RowCount()
		ls_Find = ("de_codigo_barras = '" + lds.Object.De_Codigo_Barras[ll_Linha] + "'")	
		ll_Find = Tab_1.TabPage_4.dw_6.Find(ls_Find, 1, Tab_1.TabPage_4.dw_6.RowCount())
		
		If ll_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_6.", StopSign!)
			Return False
		End If
		
		ls_Chave = lds.Object.De_Codigo_Barras[ll_Linha]
		
		If ll_Find = 0 Then
			If Not gf_Grava_Historico_Alteracao_Tabela('CODIGO_BARRAS_PRODUTO', ls_Chave, 'DE_CODIGO_BARRAS', lds.Object.De_Codigo_Barras[ll_Linha], ls_Nulo, ls_Operador, 'E', Ref ls_Erro, True) Then Return False
			If Not gf_Grava_Historico_Alteracao_Tabela('CODIGO_BARRAS_PRODUTO', ls_Chave, 'ID_PRINCIPAL', lds.Object.Id_Principal[ll_Linha], ls_Nulo, ls_Operador, 'E', Ref ls_Erro, True) Then Return False
		End If
	Next
	
	Return True
	
Finally	
	If IsValid(lds) Then Destroy(lds)
End Try
end function

public function boolean wf_verifica_alteracao_controlado ();Long ll_Saldo

String ls_Para
String ls_Grupo_Psico

Select cd_grupo_psico
	Into :ls_Grupo_Psico
From produto_geral
Where cd_produto = :ivo_Produto.Cd_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar o cadastro do produto. " + SqlCa.SqlErrText)
	Return False
End If

If IsNull(ls_Grupo_Psico) Or ls_Grupo_Psico = "" Then //N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ controlado
	If gf_Houve_Alteracao_Dw(Tab_1.Tabpage_1.dw_1, 'CD_GRUPO_PSICO', 1, Ref ls_Para) Then //Altera$$HEX2$$e700e300$$ENDHEX$$o para controlado
		If Not IsNull(ls_Para) And ls_Para <> "" Then
			
			Select Sum(qt_saldo_final)
				Into: ll_Saldo
			From vw_saldo_atual_produto
			Where cd_filial Not In (1, 534)
				And cd_produto = :ivo_Produto.Cd_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o saldo do produto nas filiais. " + SqlCa.SqlErrText, StopSign!)
				Return False
			End If
			
			If ll_Saldo > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitida a altera$$HEX2$$e700e300$$ENDHEX$$o do produto para CONTROLADO, pois existe saldo nas filiais.", Exclamation!)
				Tab_1.SelectTab(1)
				Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "cd_grupo_psico")
				Return False
			End If
		End If
	End If
End If

Return True
end function

public function boolean wf_inclui_produto_aprovacao (long al_produto, string as_tipo);DateTime ldh_Atual

Long ll_Seq

String ls_Erro

ldh_Atual = gf_GetServerDate()

Select Coalesce(Max(nr_sequencial), 0)
	Into :ll_Seq
From produto_aprovacao
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar o sequencial do produto na tabela produto_aprovacao. " + ls_Erro, StopSign!)
	Return False
End If

ll_Seq ++

Insert Into produto_aprovacao(cd_produto, nr_sequencial, dh_registro, nr_matric_registro, id_inclusao_alteracao)
		Values(:al_Produto, :ll_Seq, :ldh_Atual, :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, :as_Tipo)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o produto na tabela produto_aprovacao. " + ls_Erro, StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_verifica_alteracao_ncm_lei_gene (long al_produto, ref boolean ab_alterado);Long ll_NCM

String ls_Lei_Gene
String ls_Erro
String ls_Para

Select c.id_lei_generico, g.nr_classificacao_fiscal
	Into :ls_Lei_Gene, :ll_NCM
From produto_geral g
	Inner Join produto_central c
		On c.cd_produto = g.cd_produto
Where g.cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = 1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar se houve altera$$HEX2$$e700e300$$ENDHEX$$o nos campos lei_generico e nr_classificacao_fiscal. " + ls_Erro, StopSign!)
	Return False
End If

If gf_houve_alteracao_dw(Tab_1.TabPage_1.dw_1, 'ID_LEI_GENERICO', 1, Ref ls_Para) Or gf_houve_alteracao_dw(Tab_1.TabPage_2.dw_2, 'NR_CLASSIFICACAO_FISCAL', 1, Ref ls_Para) Then
	ab_Alterado = True
Else
	ab_Alterado = False
End If

Return True
end function

public subroutine wf_verifica_produto_abcfarma ();Long ll_Linha

String ls_Ean

Tab_1.TabPage_4.dw_6.AcceptText()

If Tab_1.TabPage_4.dw_6.RowCount() > 0 Then
	ivo_produto_abcfarma.of_Inicializa()
	
	For ll_Linha = 1 To Tab_1.TabPage_4.dw_6.RowCount()	
		ls_Ean = Tab_1.TabPage_4.dw_6.Object.De_Codigo_Barras[ll_Linha]
		
		ivo_produto_abcfarma.of_Localiza_Codigo_Barras(ls_Ean)
			
		If ivo_produto_abcfarma.Localizado Then //Sai do FOR se for localizado o EAN no ABC Farma
			wf_Atualiza_Produto_ABCFarma()
			Return
		End If
	Next
End If
end subroutine

public function boolean wf_verifica_permissao ();Long ll_Achou

Select Count(*)
	Into :ll_Achou
From procedimento_perfil_usuario
Where cd_sistema = :gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
	And cd_perfil_usuario = :gvo_Aplicacao.ivo_Seguranca.Cd_Perfil_Usuario
	And cd_procedimento = 'W_GE400_CADASTRO_PRODUTO'
	And id_inclusao = 'S'
	And id_alteracao = 'S'
	And id_exclusao = 'S'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o usu$$HEX1$$e100$$ENDHEX$$rio possui permiss$$HEX1$$e300$$ENDHEX$$o para alterar o cadastro.", StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	ivb_Possui_Permissao = True
	Tab_1.TabPage_1.dw_1.SetTabOrder('cd_produto_central', 0)
Else
	ivb_Possui_Permissao = False
End If

Return True
end function

public subroutine wf_inclui_prescricao_nula ();Integer lvi_Retorno, &
       	  lvi_Linha, &
  	      lvi_Nulo

DataWindowChild lvdwc

SetNull(lvi_Nulo)

lvi_Retorno = Tab_1.TabPage_1.dw_1.GetChild("cd_tipo_prescricao", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_tipo_prescricao", lvi_Nulo)
		lvdwc.SetItem(lvi_Linha, "de_tipo_prescricao", "NENHUMA")
		
		Tab_1.TabPage_1.dw_1.Object.Cd_Tipo_Prescricao[1] = lvi_Nulo
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da linha nula do tipo de prescri$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da linha do tipo de prescri$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
End If
end subroutine

public subroutine wf_inclui_alerta_restricao_nulo ();Integer lvi_Retorno, &
       	  lvi_Linha, &
  	      lvi_Nulo

DataWindowChild lvdwc

SetNull(lvi_Nulo)

lvi_Retorno = Tab_1.TabPage_4.dw_15.GetChild("cd_tipo_alerta_restricao", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_tipo_alerta", lvi_Nulo)
		lvdwc.SetItem(lvi_Linha, "de_tipo_alerta", "NENHUM")
		
		Tab_1.TabPage_4.dw_15.Object.Cd_Tipo_Alerta_Restricao[1] = lvi_Nulo
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da linha nula do tipo de alerta de restri$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da linha do tipo de alerta de restri$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
End If
end subroutine

public function boolean wf_valida_codigo_barras ();Long ll_Find
Long ll_Linha

String ls_Ean

Tab_1.TabPage_4.dw_6.AcceptText()

For ll_Linha = 1 To Tab_1.TabPage_4.dw_6.RowCount()
	ls_Ean = Tab_1.TabPage_4.dw_6.Object.De_Codigo_Barras[ll_Linha]
	
	If Not IsNumber(ls_Ean) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "EAN " + ls_Ean + " inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
		Tab_1.SelectedTab = 6
		Tab_1.TabPage_4.dw_6.Event ue_Pos(ll_Linha, "de_codigo_barras")
		Return False
	End If
Next

Return True
end function

public subroutine wf_verifica_atualizaco_custo (string as_subcategoria);String ls_Atualiza_Custo

Select coalesce(id_atualiza_custo, 'S')
Into :ls_Atualiza_Custo
From subcategoria
Where cd_subcategoria = :as_subcategoria
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da subcategoria '" + String(ivo_Produto.Cd_Produto) + "'.")
		Return
End Choose

If ls_Atualiza_Custo = 'N' Then
	Tab_1.TabPage_1.dw_1.Object.t_custo_entrada.Visible = 1
Else
	Tab_1.TabPage_1.dw_1.Object.t_custo_entrada.Visible = 0
End If
end subroutine

public function boolean wf_grava_historico_alteracao (string as_tabela, string as_chave, string as_coluna, string as_de, string as_operador, string as_tipo_alteracao);String ls_Erro

Insert Into historico_alteracao_tabela(nm_tabela, de_chave, nm_coluna, de_alteracao_de, de_alteracao_para, nr_matric_alteracao, id_alteracao)
Values (:as_Tabela, :as_chave, :as_Coluna, :as_De, Null, :as_Operador, :as_tipo_alteracao)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = "Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es. " + SqlCa.SQLErrText
	SqlCa.of_RollBack()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_verifica_uf_atendimento (string as_uf, ref string as_uf_situacao);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From vw_filial
Where cd_uf = :as_uf
And Coalesce(id_aberta,'N') = 'S'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o UF est$$HEX1$$e100$$ENDHEX$$ no atendimento das filiais.", StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	as_uf_situacao = 'S'
Else
	as_uf_situacao = 'N'
End If

Return True
end function

on w_ge400_cadastro_produto.create
int iCurrent
call super::create
this.dw_13=create dw_13
this.st_1=create st_1
this.tab_1=create tab_1
this.gb_15=create gb_15
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_13
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.gb_15
end on

on w_ge400_cadastro_produto.destroy
call super::destroy
destroy(this.dw_13)
destroy(this.st_1)
destroy(this.tab_1)
destroy(this.gb_15)
end on

event ue_postopen;call super::ue_postopen;uo_parametro_geral luo_parametro

dc_uo_dw_Base lvo_DW[]
lvo_DW = {Tab_1.TabPage_1.dw_1, Tab_1.TabPage_4.dw_6, Tab_1.TabPage_2.dw_7, Tab_1.TabPage_2.dw_9, Tab_1.TabPage_6.dw_12, dw_13 }
This.wf_SetUpdate_DW(lvo_DW)

ivdh_Parametro = gvo_Parametro.of_Dh_Movimentacao()

luo_parametro = create uo_parametro_geral

luo_parametro.of_localiza_parametro( 'ID_UTILIZA_LISTA_TECNICA', ref is_usa_lista_tecnica )

Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_5.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_6.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_7.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_8.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_9.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_5.dw_10.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_6.dw_12.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_14.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_15.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_7.dw_19.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_16.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_4.dw_6.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_2.dw_9.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_6.dw_12.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_2.dw_14.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_4.dw_15.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_7.dw_19.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_3.dw_16.ivo_Controle_Menu.of_Incluir(True)

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_3.dw_16.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_produto_localizacao")

// Localiza o caminho das fotos para o eCommerce e para as Categorias
wf_Localiza_Path_Fotos()

Tab_1.TabPage_1.dw_1.Object.De_Registro_Ms.EditMask.Mask = "#.####.####.###-#"
Tab_1.TabPage_1.dw_1.Object.Cd_Subcategoria.EditMask.Mask = "#.##.###.###"
Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor_Usual.EditMask.Mask = "####-#####"

If Not wf_Verifica_Permissao() Then Return

wf_Set_Somente_Consulta()

//If Not ib_Permite_Alter_Cutover Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente alguns campos est$$HEX1$$e300$$ENDHEX$$o liberados para edi$$HEX2$$e700e300$$ENDHEX$$o.~rUtilize o SAP para cadastrar um novo produto ou editar demais dados.", Exclamation!)
//End If
end event

event open;call super::open;ivo_Produto          					= Create uo_Produto
ivo_Fornecedor       				= Create uo_Fornecedor
ivo_Produto_ABCFarma 			= Create uo_Produto_ABCFarma
ivo_Classificacao    				= Create uo_Classificacao_Produto
ivo_Fabricante       				= Create uo_Fabricante
ivo_DCB              					= Create uo_DCB
ivo_grupo_alteracao_preco		= Create uo_grupo_alteracao_preco
ivo_marca_produto				= Create uo_ge228_marca_produto
ivo_tributacao						= Create uo_ge220_tributacao_produto
io_Marca_Ecommerce			= Create uo_ge199_marca_ecommerce
io_filiais								= Create uo_ge216_filiais
io_Comprador						= Create uo_ge149_comprador
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Fornecedor)
Destroy(ivo_Produto_ABCFarma)
Destroy(ivo_Classificacao)
Destroy(ivo_Fabricante)
Destroy(ivo_DCB)
Destroy(ivo_grupo_alteracao_preco)
Destroy(ivo_marca_produto)
Destroy(ivo_tributacao)
Destroy(io_Marca_Ecommerce)
Destroy(io_Filiais)
Destroy(io_Comprador)
end event

event ue_cancel;call super::ue_cancel;Tab_1.TabPage_1.dw_1.Event ue_Cancel()
end event

event ue_preupdate;call super::ue_preupdate;If Not ivb_Possui_Permissao Then Return False

If Not ib_Permite_Alter_Cutover And IsNull(ivo_Produto.Cd_Produto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para cadastrar um novo produto utilize o SAP.", Exclamation!)
	Return False
End If

If Not wf_Valida_Campos() Then Return False

// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia de um produto com o mesmo c$$HEX1$$f300$$ENDHEX$$digo de barras
If wf_Codigo_Barras_Duplicado() Then Return False

If Not wf_Valida_Codigo_Barras() Then Return False

// Verifica se o desconto clube futuro foi alterado, se sim, coloca a matricula do respons$$HEX1$$e100$$ENDHEX$$vel
If Not wf_Valida_Desc_Clube_Futuro() Then Return False

If Not wf_Valida_Cadastro_UF() Then Return False

If Not wf_Valida_Substancias() Then Return False

//If Not wf_produto_dw13() Then Return False

If Not wf_valida_divisao_fornecedor() Then Return False

If Not wf_Exclui_Divisao_Fornecedor() Then Return False

If Not IsNull(ivo_Produto.Cd_Produto) Then
	If Not wf_Valida_Est_Min_Pbm() Then Return False
	
	If Not wf_Grava_Historico_Aba_Geral() Then Return False
	
	If Not wf_Grava_Historico_Aba_Substancias() Then Return False

	If Not wf_Grava_Historico_Aba_Ecommerce() Then Return False
		
	If Not wf_Grava_Historico_Aba_Fiscal_Pricing() Then Return False
	
	If Not wf_Grava_Historico_Preco_Uf() Then Return False
	
	If Not wf_Grava_Historico_Comissao() Then Return False
	
	If Not wf_Grava_Historico_Aba_Estoque() Then Return False
	
	If Not wf_Grava_Historico_EAN() Then Return False
	
Else
	
	If Not wf_Valida_Tributacao_NCM() Then Return False
End If

Return True
end event

event ue_save;call super::ue_save;Long lvl_Nulo

SetNull(lvl_Nulo)

If AncestorReturnValue = 1 Then
	If ivb_Produto_Novo Then
		// Inclui os produtos nas promo$$HEX2$$e700f500$$ENDHEX$$es 
		// *** Antes era feito via trigger

//		If Not wf_Inclui_Produto_Aprovacao(Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1], 'I') Then Return -1
		
		If wf_Inclui_Promocao_Produto_Novo(lvl_Nulo) Then 
			ivb_Produto_Novo = False
		End If
	End If

	//Atualiza as colunas antes do Retrieve
	//Os dados ficam na tela
	Tab_1.TabPage_1.dw_1.Object.de_alteracao_situacao_anterior	[1] = Tab_1.TabPage_1.dw_1.Object.de_alteracao_situacao	[1]
	Tab_1.TabPage_1.dw_1.Object.id_situacao_anterior 					[1] = Tab_1.TabPage_1.dw_1.Object.id_situacao					[1]		
End If

Return AncestorReturnValue
end event

event ue_preopen;//OverRide

//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CT" Then
//	This.ChangeMenu(m_janelas)
//Elseif gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
//	This.ChangeMenu(m_co010_cadastro_produtos)
//End If

This.ChangeMenu(m_janelas)

//Executa evento da tela pai
SUPER::EVENT ue_preopen()
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge400_cadastro_produto
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge400_cadastro_produto
end type

type dw_13 from dc_uo_dw_base within w_ge400_cadastro_produto
boolean visible = false
integer x = 1623
integer y = 2448
integer width = 1129
integer taborder = 0
string dataobject = "dw_ge400_divisao_fornecedor"
boolean livescroll = false
end type

event ue_recuperar;//Override

String ls_Fornecedor

Long ll_Produto

Tab_1.TabPage_1.dw_1.AcceptText()

ls_Fornecedor 	= Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor_Usual		[1]
ll_Produto		= Tab_1.TabPage_1.dw_1.Object.cd_produto_central		[1]
	
Return This.Retrieve(ls_Fornecedor, ll_Produto)
end event

event ue_preupdate;//Override
If Not wf_produto_dw13() Then Return -1

end event

type st_1 from statictext within w_ge400_cadastro_produto
integer x = 59
integer y = 2672
integer width = 3657
integer height = 108
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Hist. de Pre$$HEX1$$e700$$ENDHEX$$o de Repos. [F2] | Hist. de Pre$$HEX1$$e700$$ENDHEX$$o de Venda [F3] | Hist. de Desconto [F4] | PBM [F5] | Busca F$$HEX1$$e100$$ENDHEX$$cil [F6] | Hist. Promo$$HEX2$$e700e300$$ENDHEX$$o [F7] | Copia Cadastro [F12]"
alignment alignment = center!
boolean focusrectangle = false
end type

type tab_1 from tab within w_ge400_cadastro_produto
integer x = 9
integer y = 4
integer width = 3726
integer height = 2672
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 80269524
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_6 tabpage_6
tabpage_5 tabpage_5
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_7 tabpage_7
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_6=create tabpage_6
this.tabpage_5=create tabpage_5
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_1,&
this.tabpage_6,&
this.tabpage_5,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_7}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_6)
destroy(this.tabpage_5)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_7)
end on

event clicked;Choose Case Index
	Case 1
		If Tab_1.TabPage_1.dw_1.GetColumnName() = "" Then
			Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_produto")
		End If
		
	Case 3
		If Tab_1.TabPage_2.dw_2.GetColumnName() = "" Then
			Tab_1.TabPage_2.dw_2.Event ue_Pos(1, "id_situacao_pis_cofins")
		End If
End Choose
end event

event selectionchanged;This.Event Clicked(NewIndex)


If NewIndex = 4 then
	This.TabPage_2.dw_2.SetFocus()
	This.TabPage_2.dw_7.SetFocus()
	If Not ib_Permite_Alter_Cutover Then
		If ib_Permite_Alterar_Preco Then
		//	Tab_1.TabPage_2.cb_replica_venda.Visible = True
		Else
		//	Tab_1.TabPage_2.cb_replica_venda.Visible = False
		End If
	End If
End If
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3689
integer height = 2556
long backcolor = 79741120
string text = "Cadastro Geral"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_1 gb_1
dw_1 dw_1
end type

on tabpage_1.create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.gb_1,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.gb_1)
destroy(this.dw_1)
end on

type gb_1 from groupbox within tabpage_1
integer x = 14
integer width = 3648
integer height = 2544
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 27
integer y = 60
integer width = 3621
integer height = 2472
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_detalhe_principal"
end type

event constructor;call super::constructor;String lvs_Chave_Geral[], &
       lvs_Coluna_Geral[], &
		 lvs_Chave_Central[], &
		 lvs_Coluna_Central[]
		 
This.of_SetMultitable()

lvs_Chave_Geral   = {"cd_produto_geral"}
lvs_Chave_Central = {"cd_produto_central"}

lvs_Coluna_Geral = {	"cd_produto_geral",               &
						  	"de_produto",                     &   
						  	"de_apresentacao_estoque",        &
						  	"de_apresentacao_venda",          &
						  	"nr_embalagem_padrao",            &
						  	"nr_classificacao_fiscal",        &
						  	"cd_unidade_medida_compra",       &
						  	"cd_unidade_medida_venda",        &
						  	"cd_grupo_produto",               &
						  	"cd_subgrupo_produto",            &
						  	"cd_linha_produto",               &
						  	"cd_fornecedor_usual",            &
						  	"id_situacao",                    &
						  	"id_liberado_filial",             &   
						  	"dh_alteracao_codigo_barras",     &
						  	"vl_fator_conversao",             &
						  	"pc_desconto_atual",              &
						  	"pc_desconto_futuro",             &
						  	"id_preco_bloqueado",             &
						  	"pc_ipi",                         &
						  	"cd_grupo_psico",                 &
						  	"cd_dcb",                         &
						  	"cd_origem_produto",              &
						  	"id_caderno_abcfarma",            &
						  	"pc_reducao_base_icms",           &
						  	"nr_matricula_desconto_futuro",   &
						  	"nr_matricula_desconto_atual",    &
						  	"dh_desconto_atual",              &
						  	"dh_desconto_futuro",             &
						  	"dh_inclusao_produto",            &
						  	"dh_termino_avaliacao",           &
						  	"id_tipo_desconto_atual",         &
						  	"id_proprio_consignado",          &
						  	"id_situacao_pis_cofins",         &
						  	"cd_subcategoria",                &
       				  		"vl_ponto_clube",                 		&
       				  		"qt_pontos_resgate",					&
						  	"pc_desconto_clube_atual",				&
						  	"dh_desconto_clube_atual",				&
						  	"nr_matric_desc_clube_atual",     		&
						  	"pc_desconto_clube_futuro",				&
						  	"dh_desconto_clube_futuro",				&
						  	"nr_matric_desc_clube_futuro",    		&
						  	"id_utiliza_vale_resgate", 				&
						  	"qt_unidades_embalagem", 				&         
						  	"qt_concentracao", 						&
						  	"id_apresentacao", 						&
						  	"qt_dias_maximo_tratamento", 			&
						  	"vl_volume", 							&
						  	"cd_fabricante", 						&
						  	"de_registro_ms",						&
						  	"id_lei_generico",						&
						  	"id_recuperacao_vencido",				&
						  	"de_descricao_internet",				&
						  	"qt_altura_cm",							&
						  	"qt_largura_cm",						&
						  	"qt_profundidade_cm",					&
						  	"qt_peso_grama",						&
							"id_liberado_ecommerce",				&
							"de_principal_internet", &
							"id_farmacia_popular",&
							"id_gratis_farm_popular", &
							"cd_planograma",&
							"cd_marca",&
							"cd_st_origem",&
							"id_geladeira",&
							"id_exclusivo",&
							"cd_unidade_medida_padrao",&
							"vl_fator_conversao_padrao",&
							"id_promover_venda", &
							"id_permite_devolucao",&
							"cd_marca_ecommerce", &
							"qt_estoque_minimo", &
							"id_contem_gluten", &
							"id_contem_acucar", &
							"id_contem_lactose", &
							"vl_reembolso_fpb", &
							"nr_matricula_inclusao", &
							"cd_tipo_prescricao", &
							"qt_comprimento",&
							"de_motivo_registro_ms_isento",&
							"qt_prazo_reposicao",&
							"id_marca_propria",&
							"cd_arvore_mercadologica_sap",&
							"cd_segmento_ims",&
							"de_segmento",&
							"cd_area_farmacia",&
							"de_area_farmacia",&
							"cd_tarja",&
							"de_tarja",&
							"cd_cronicidade",&
							"de_cronicidade",&
							"cd_grupo_mercadorias",&
							"de_grupo_mercadorias",&
							"id_contem_corante",&
							"id_testado_animais",&
							"id_vegano"}

lvs_Coluna_Central = {"cd_produto_central",            &
                      "cd_mix_produto",                &
                      "id_tipo_reposicao_estoque",     &
					  "cd_produto_fornecedor",         &
					  "pc_desconto_fornecedor",        &
					  "vl_peso_liquido",               &
					  "dh_situacao",                   &
					  "cd_local_estocagem",            &
					  "id_origem_produto_fornecedor",  &
					  "cd_produto_abcfarma",           &
					  "vl_fator_conversao_abcfarma",   &
					  "cd_divisao_estocagem",          &
					  "id_preco_informado",            &
					  "id_contrato_fornecedor",        &
					  "id_pagamento_apos_venda",       & 
					  "id_sugere_pedido_filial",       &
					  "id_lei_generico",			   &
					  "id_projeto_conexao",&
					  "cd_grupo_alteracao_preco",&
					  "id_revisao_fiscal", &
					  "qt_largura_cm_caixa_forn", & 
					  "qt_altura_cm_caixa_forn", &
					  "qt_profundidade_cm_caixa_forn", &   
				   	"qt_largura_cm_caixa_estoque", &  
					   "qt_altura_cm_caixa_estoque", &   
					   "qt_profund_cm_caixa_estoque",&
						"nr_matric_alteracao_situacao", &
						"de_alteracao_situacao", &
						"cd_bairro_wms", &
						"nr_matric_solicitacao_alt_sit", &
						"id_tipo_un_calc_preco", &
						"cd_categoria_ecommerce", &
						"qt_peso_apresentacao", &
						"cd_categ_mercadologica", &
						"de_produto_primaria", &
						"de_produto_secundaria", &
						"de_texto_legal", &
						"de_alergenicos", &
						"id_permite_publicidade", &
						"id_publi_obriga_texto_legal"}

This.ivo_Multitable.of_SetUpdateTable("produto_geral"  , lvs_Chave_Geral  , lvs_Coluna_Geral)
This.ivo_Multitable.of_SetUpdateTable("produto_central", lvs_Chave_Central, lvs_Coluna_Central)

This.ivs_Coluna_Sem_Validacao_Salva = {"de_produto_localizacao"}

If This.ShareData(Tab_1.TabPage_2.dw_2) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Share Data da dw_2.", StopSign!)
	Return -1
End If

If This.ShareData(Tab_1.TabPage_5.dw_10) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Share Data da dw_10.", StopSign!)
	Return -1
End If

If This.ShareData(Tab_1.TabPage_4.dw_15) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Share Data da dw_15.", StopSign!)
	Return -1
End If

If This.ShareData(Tab_1.TabPage_7.dw_19) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Share Data da dw_19.", StopSign!)
	Return -1
End If

This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;String ls_Nulo

SetNull(ls_Nulo)

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	This.ivm_Menu.mf_Confirmar(True)
	This.ivm_Menu.mf_Cancelar(True)
End If

If dwo.Name = "de_dcb" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_DCB.De_DCB Then
			Return 1
		End If
	Else
		ivo_DCB.of_Inicializa()		
		wf_Atualiza_DCB()
	End If
End If

If dwo.Name = "nm_fabricante" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Fabricante.Nm_Razao_Social Then
			Return 1
		End If		
	Else
		ivo_Fabricante.of_Inicializa()
	
		wf_Atualiza_Fabricante()
	End If
End If

If dwo.Name = "de_subcategoria" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Classificacao.De_SubCategoria Then
			Return 1
		End If
	Else
		Tab_1.TabPage_1.dw_1.Object.Cd_Subcategoria[1] = ls_Nulo
		Tab_1.TabPage_1.dw_1.Object.De_Subcategoria[1] = ls_Nulo
	End If
End If

If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Comprador.nm_usuario Then
			Return 1
		End If
	Else
		io_Comprador.of_Inicializa()
		
		This.Object.nr_matric_solicitacao_alt_sit[1] = io_Comprador.nr_matricula
		This.Object.nm_usuario  [1] = io_Comprador.nm_usuario
	End If
End If
end event

event itemchanged;call super::itemchanged;Long lvl_Nulo, ll_Divisao, ll_Insert

DateTime lvdh_Termino_Avaliacao

String ls_Situacao_Anterior, ls_Nulo

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	This.ivm_Menu.mf_Confirmar(True)
	This.ivm_Menu.mf_Cancelar(True)
End If

Choose Case dwo.Name		
	Case "id_lei_generico"
		This.Object.Id_Revisao_Fiscal[1] = 'P'
		
	Case "de_subcategoria"
		If Data <> ivo_Classificacao.De_SubCategoria Then
			Return 1
		End If
		
	Case "nm_fornecedor"
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
		wf_Exclui_Divisao_Fornecedor_DW()	
		wf_lista_divisao_fornecedor()
		
	Case "nm_fabricante"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fabricante.Nm_Razao_Social Then
				Return 1
			End If		
		Else
			ivo_Fabricante.of_Inicializa()
			
			wf_Atualiza_Fabricante()
		End If
	
	Case "de_marca"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_marca_produto.De_Marca Then
				Return 1
			End If
		Else
			ivo_marca_produto.of_Inicializa()
			
			This.Object.cd_marca[1] = ivo_marca_produto.cd_marca
			This.Object.de_marca[1] = ivo_marca_produto.de_marca
		End If		
	
	Case "de_dcb"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_DCB.De_DCB Then
				Return 1
			End If
		Else
			ivo_DCB.of_Inicializa()
			
			wf_Atualiza_DCB()
		End If
		
	Case "de_codigo_barras"
		This.Object.dh_Alteracao_Codigo_Barras[1] = DateTime(Today(), Now())

	Case "dh_termino_avaliacao"
		lvdh_Termino_Avaliacao = DateTime(Date(MidA(Data, 9, 2) + "/" + MidA(Data, 6, 2) + "/" + MidA(Data, 1, 4)))
		
		If lvdh_Termino_Avaliacao < ivdh_Parametro Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino da avalia$$HEX2$$e700e300$$ENDHEX$$o do produto n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o atual.", StopSign!)
			Return 1
		End If
		
	Case "id_situacao"
			
		ls_Situacao_Anterior = This.Object.id_situacao_anterior	[ 1 ]
		SetNull(ls_Nulo)
	
		If ls_Situacao_Anterior <> Data Then
			This.Object.t_motivo.Text = "Motivo Altera$$HEX2$$e700e300$$ENDHEX$$o: "
			
			This.Object.Nr_Matric_Solicitacao_Alt_Sit[1] = ls_Nulo
			This.Object.Nm_Usuario[1] = ls_Nulo
			This.SetTabOrder('nm_usuario', 300)
			
			This.SetTabOrder('de_alteracao_situacao', 310)
			If Mid(This.Object.cd_subcategoria[1], 1,1) <> '5' Then 
				This.Object.de_alteracao_situacao [1] = is_Mensagem_Motivo_Situacao
			Else
				This.Object.de_alteracao_situacao [1] = ""
			End If
			
			This.Event ue_Pos(1, 'nm_usuario' )
			This.SelectText(1, Len(This.GetText()))
			
		Else
			This.Object.t_motivo.Text = "$$HEX1$$da00$$ENDHEX$$ltimo Motivo Altera$$HEX2$$e700e300$$ENDHEX$$o:"
			This.SetTabOrder('de_alteracao_situacao', 0)
			This.Object.de_alteracao_situacao [1] = This.Object.de_alteracao_situacao_anterior [1] 
		End If
		
	Case "nr_divisao_fornecedor"
		ll_Divisao = Long(Data)
		
		// Excluir todos os registros e inclui novamente
		wf_Exclui_Divisao_Fornecedor_DW()
		
		// Inclui
		If Not IsNull(ll_Divisao) Then
			ll_Insert = dw_13.InsertRow(0)
			
			dw_13.Object.nr_divisao			[ll_Insert] = ll_Divisao
			dw_13.Object.cd_fornecedor	[ll_Insert] = This.Object.cd_fornecedor_usual	[1]
			dw_13.Object.cd_produto		[ll_Insert] = This.Object.cd_produto_central	[1]
		End If
		
	Case "nm_usuario"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.nr_matric_solicitacao_alt_sit	[1] = io_Comprador.nr_matricula
			This.Object.nm_usuario  [1] = io_Comprador.nm_usuario
		End If
End Choose
end event

event losefocus;If IsValid(ivo_Fornecedor) Then
	wf_Atualiza_Fornecedor()
End If

If IsValid(ivo_Classificacao) Then
	wf_Atualiza_Classificacao()
End If

If IsValid(ivo_Fabricante) Then
	wf_Atualiza_Fabricante()
End If

If IsValid(ivo_DCB) Then
	wf_Atualiza_DCB()
End If
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then    
	wf_Inclui_Grupo_Psico_Nulo()
	wf_Inclui_Linha_Nula()
	wf_Inclui_Planograma_Nulo()
	wf_inclui_divisao_fornecedor_nulo()
	wf_Inclui_Prescricao_Nula()
//	wf_Inclui_Alerta_Restricao_Nulo()
	
	This.ivi_Tipo_Cancelar = ADDROW
	
	This.Object.De_Registro_Ms.Protect = 0
	
	if gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CO' then
		This.Object.nr_divisao_fornecedor.Protect = 1
		This.Object.de_subcategoria.Protect = 1	
		tab_1.Tabpage_5.dw_10.Object.de_principal_internet.Protect = 1
		tab_1.Tabpage_5.dw_10.Object.de_categoria_ecommerce.Protect = 1
		tab_1.Tabpage_2.dw_14.Object.vl_preco_reposicao.Protect = 1
		tab_1.Tabpage_2.dw_2.Object.pc_desconto_fornecedor.Protect = 1
		
	end if
	
	This.Object.De_Produto_Localizacao      	[1] = ""
   This.Object.Dh_Desconto_Atual           	[1] = ivdh_Parametro
	This.Object.Dh_Alteracao_Codigo_Barras  	[1] = DateTime(Today(), Now())
	This.Object.Dh_Situacao                 	[1] = DateTime(Today(), Now())
	This.Object.Nr_Matricula_Desconto_Atual 	[1] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	This.Object.Nr_Matric_Desc_Clube_Atual  	[1] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
   This.Object.Dh_Desconto_Clube_Atual     	[1] = ivdh_Parametro
	This.Object.Dh_Inclusao_Produto         	[1] = ivdh_Parametro
	This.Object.Dh_Termino_Avaliacao        	[1] = RelativeDate(Date(ivdh_Parametro), 90)
	This.Object.Id_Revisao_Fiscal             [1] = "P"
	
	This.SetTabOrder("dh_termino_avaliacao", 30)
	
	//Tab_1.TabPage_2.dw_2.of_Populate_DDDW("cd_origem_produto")
	Tab_1.TabPage_2.dw_2.of_Populate_DDDW("cd_divisao_estocagem")
	Tab_1.TabPage_2.dw_2.of_Populate_DDDW("cd_mix_produto")
	
	Tab_1.TabPage_3.dw_3.Event ue_Reset()
	Tab_1.TabPage_3.dw_4.Event ue_Reset()
	Tab_1.TabPage_3.dw_5.Event ue_Reset()
	Tab_1.TabPage_4.dw_6.Event ue_Reset()
	Tab_1.TabPage_2.dw_7.Event ue_Reset()
	Tab_1.TabPage_2.dw_9.Event ue_Reset()
	Tab_1.TabPage_2.dw_14.Event ue_Reset()
	
	dw_13.Event ue_Reset()
	
	ivo_Fornecedor.of_Inicializa()
	ivo_Fabricante.of_Inicializa()
	ivo_Produto_ABCFarma.of_Inicializa()
	ivo_Classificacao.of_Inicializa()
	ivo_DCB.of_Inicializa()
	
	Tab_1.TabPage_1.dw_1.Object.fornecedor_inativo_t.Visible = 0
	
	Tab_1.SelectTab(1)
	This.Event ue_Pos(1, "de_produto")
	
	This.Object.t_motivo.Text = "$$HEX1$$da00$$ENDHEX$$ltimo Motivo Altera$$HEX2$$e700e300$$ENDHEX$$o:"
	This.SetTabOrder('de_alteracao_situacao', 0)
	This.SetTabOrder('nm_usuario', 0)
	
	This.Object.Text_Avaliacao.Text = ""
	
	wf_Verifica_UF_Ativa()
	
	This.ivm_Menu.mf_Confirmar(False)
	This.ivm_Menu.mf_Cancelar(False)		
End If

Return AncestorReturnValue
end event

event ue_key;Boolean lb_Sucesso
String lvs_Coluna, ls_Conexao, ls_Descricao

Choose Case Key
	Case KeyEnter!
		lvs_Coluna = This.GetColumnName()
		
		Choose Case lvs_Coluna
			Case "de_produto_localizacao"
				ivo_Produto.of_Localiza_Produto(This.GetText())
				
				If ivo_Produto.Localizado Then
					//This.Object.Cd_Produto_Central[1] = ivo_Produto.Cd_Produto
					//Tab_1.TabPage_3.cbx_mostra_produtos_planograma.Checked = False
					
					Tab_1.TabPage_3.dw_16.Object.Id_Planograma[1] = "N"
					Tab_1.TabPage_3.dw_16.Object.Id_Filiais[1] = "T"
					SetNull(is_filiais)
					This.Event ue_Retrieve()				
				End If
				
			Case "nm_fornecedor"
				If Not ib_Permite_Alter_Cutover Then Return
				
				lb_Sucesso = wf_Localiza_Fornecedor(This.GetText())
				
				If lb_Sucesso Then
					If Not wf_Fornecedor_Conexao(ivo_fornecedor.cd_Fornecedor, Ref ls_Conexao, Ref ls_Descricao ) Then Return
					
					If IsNull(ls_Conexao) Or ls_Conexao="" Then
						Tab_1.TabPage_2.dw_2.Object.id_projeto_conexao	[1] = ls_Conexao
						Tab_1.TabPage_2.dw_2.Object.de_conexao			[1] = "NENHUM"
						Tab_1.TabPage_2.dw_2.Object.id_conexao				[1] = "N"
					End If
					
					wf_Exclui_Divisao_Fornecedor()
					wf_lista_divisao_fornecedor()
					
					wf_atualiza_divisao_fornecedor(This.Object.cd_fornecedor_usual[1], This.Object.cd_produto_central[1])
					
					dw_13.Event ue_Retrieve()
				End If
	
			Case "nm_fabricante"
				If Not ib_Permite_Alter_Cutover Then Return
				
				lb_Sucesso = wf_Localiza_Fabricante(This.GetText())
		
			Case "de_marca"
				If Not ib_Permite_Alter_Cutover Then Return
				
				ivo_marca_produto.of_Localiza_Marca(This.GetText())
				
				If ivo_marca_produto.Localizada Then
					This.Object.cd_marca[1] = ivo_marca_produto.cd_marca
					This.Object.de_marca[1] = ivo_marca_produto.de_marca	
					lb_Sucesso = True
				End If
	
			Case "de_subcategoria"
				//If Not ib_Permite_Alter_Cutover Then Return
				
				lb_Sucesso = wf_Localiza_Classificacao(This.GetText())
				
			Case "de_dcb"
				If Not ib_Permite_Alter_Cutover Then Return
				
				lb_Sucesso = wf_Localiza_DCB(This.GetText())
				
			Case "nm_usuario"
				io_Comprador.of_Localiza_Comprador(This.GetText())
				
				lb_Sucesso = io_Comprador.Localizado
				
				If io_Comprador.Localizado Then
					This.Object.nr_matric_solicitacao_alt_sit	[1] = io_Comprador.nr_matricula
					This.Object.nm_usuario  [1] = io_Comprador.nm_usuario
				End If
		End Choose
		
		If lb_Sucesso Then
			ivb_Valida_Salva = True
			ivm_Menu.mf_Confirmar(True)
			ivm_Menu.mf_Cancelar(True)
		End If
End Choose

wf_Atalhos(Key)
end event

event ue_postretrieve;DateTime lvdh_Termino_Avaliacao
Long ll_Categoria
String ls_Categoria, ls_niveis

Tab_1.TabPage_1.dw_1.AcceptText()

	If pl_Linhas > 0 Then
		
		This.Object.Cd_Divisao_Estocagem[1] = "00"
		
		This.ivi_Tipo_Cancelar = RETRIEVE
		
		//[Cleser]
		If Not IsNull(This.Object.Cd_Grupo_Psico[1]) and Not IsNull(This.Object.de_registro_ms[1]) Then
			This.Object.De_Registro_Ms.Protect = 1
		Else 
			This.Object.De_Registro_Ms.Protect = 0
		End If
		
		If Tab_1.TabPage_1.dw_1.Object.cd_subcategoria[1] = "901001001" Then
			ib_Permite_Alterar_Preco = True
		Else
			ib_Permite_Alterar_Preco = False
		End If
		
		Tab_1.TabPage_3.dw_3.Event ue_Retrieve()
		Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
		Tab_1.TabPage_3.dw_5.Event ue_Retrieve()
		Tab_1.TabPage_4.dw_6.Event ue_Retrieve()
		Tab_1.TabPage_2.dw_7.Event ue_Retrieve()
		Tab_1.TabPage_2.dw_9.Event ue_Retrieve()
		Tab_1.TabPage_6.dw_12.Event ue_Retrieve()
		
		dw_13.Event ue_Retrieve()
		
		Tab_1.TabPage_4.dw_17.Event ue_Retrieve()
			
		wf_Verifica_UF_Ativa()
		
		wf_Localiza_Fornecedor(This.Object.Cd_Fornecedor_Usual[1])
		
		If Not Isnull(Tab_1.TabPage_2.dw_2.Object.cd_grupo_alteracao_preco[1]) Then
			wf_Localiza_Grupo_Alteracao_Preco(string(Tab_1.TabPage_2.dw_2.Object.cd_grupo_alteracao_preco[1]))	
		End If
		
		ivo_Fabricante.of_Inicializa()
		
		If Not IsNull(This.Object.Cd_Fabricante[1]) Then
			wf_Localiza_Fabricante(String(This.Object.Cd_Fabricante[1]))
		End If
		
		ivo_Classificacao.of_Inicializa()
		
		If Not IsNull(This.Object.Cd_SubCategoria[1]) Then
			wf_Localiza_Classificacao(String(This.Object.Cd_SubCategoria[1]))
		End If
		
		ivo_Produto_ABCFarma.of_Inicializa()
		
		If This.Object.Id_Caderno_ABCFarma[1] = "S" Then
			wf_Verifica_Produto_ABCFarma()
		End If
		
	//	If Not IsNull(Tab_1.TabPage_2.dw_2.Object.Cd_Produto_ABCFarma[1]) Then
	//		wf_Localiza_Produto_ABCFarma(String(Tab_1.TabPage_2.dw_2.Object.Cd_Produto_ABCFarma[1]), False)
	//	End If
	
		ivo_DCB.of_Inicializa()
		
		If Not IsNull(This.Object.Cd_DCB[1]) Then
			wf_Localiza_DCB(This.Object.Cd_DCB[1])
		End If
		
		//w_Aguarde.uo_Progress.of_SetProgress(2)
		
		// Verifica a data de t$$HEX1$$e900$$ENDHEX$$rmino da avalia$$HEX2$$e700e300$$ENDHEX$$o do produto
		lvdh_Termino_Avaliacao = This.Object.Dh_Termino_Avaliacao[1]
		
		If lvdh_Termino_Avaliacao < ivdh_Parametro Then
			This.SetTabOrder("dh_termino_avaliacao", 0)
			This.Object.Text_Avaliacao.Text = ""
		Else
			This.SetTabOrder("dh_termino_avaliacao", 30)
			This.Object.Text_Avaliacao.Text = "PRODUTO NOVO EM AVALIA$$HEX2$$c700c300$$ENDHEX$$O"
		End If
		
		If Not wf_Verifica_Pbm() Then Return -1
		
		If il_Pbm > 0 Then
		//	This.Object.Nm_Pbm	[1] = is_Nm_Pbm
			This.Object.Id_Pbm	[1] = "S"
		Else
	//		This.Object.Nm_Pbm	[1] = ""
			This.Object.Id_Pbm	[1] = "N"
		End If
		
		wf_lista_divisao_fornecedor()
		
		If Not IsNull(This.Object.cd_fornecedor_usual[1]) and Not IsNull(This.Object.cd_produto_central[1]) Then
			wf_atualiza_divisao_fornecedor(This.Object.cd_fornecedor_usual[1],This.Object.cd_produto_central[1])
		End If
		
		This.ivm_Menu.mf_Confirmar(False)
		This.ivm_Menu.mf_Cancelar(False)	
		
		ivo_Controle_Menu.of_Atualiza()
		
		// Localiza foto do produto para o eCommerce
		If wf_Localiza_Foto(This.Object.cd_produto_central[1], 'E') Then
			This.Object.id_foto[1] = 'S'
		Else
			This.Object.id_foto[1] = 'N'
		End If
		
		// Localiza foto do produto para o gerenciamento de categorias
		If wf_Localiza_Foto(This.Object.cd_produto_central[1], 'C') Then
			This.Object.id_foto_categoria[1] = 'S'
		Else
			This.Object.id_foto_categoria[1] = 'N'
		End If
		
		ll_Categoria = This.Object.cd_categoria_ecommerce[1]
		
		If wf_localiza_categoria(ll_Categoria, ref ls_Categoria) Then
		
			wf_Localiza_Niveis_Categoria(ll_Categoria, Ref ls_Niveis)
			
			//This.Object.cd_categoria_ecommerce[1] = ll_Categoria
			//This.Object.de_categoria					[1] = ls_Categoria
			tab_1.tabpage_5.dw_10.Object.de_arvore_cat_t.text = ls_Niveis
		End If
		
		//w_Aguarde.uo_Progress.of_SetProgress(3)
		
	End If
	

Return pl_Linhas
end event

event ue_preinsertrow;call super::ue_preinsertrow;If wf_Valida_Salva() > 0 Then
	This.Reset()
	Return 1
Else
	Return -1
End If
end event

event ue_preretrieve;call super::ue_preretrieve;If wf_Valida_Salva() > 0 Then
	Return 1
Else
	Return -1
End If
end event

event ue_preupdate;call super::ue_preupdate;Boolean lb_Alteracao = False

String lvs_Nulo
String lvs_Grupo
String ls_Situacao
String ls_Situacao_Anterior
String ls_Psico
String ls_Fornecedor_Usual

//ls_Fornecedor_Usual = This.Object.Cd_Fornecedor_Usual	[1]
//
//If Not wf_Fornecedor_Conexao( ls_Fornecedor_Usual, Ref ls_Conexao ) Then Return -1
//
//If Not IsNull( ls_Conexao ) And ls_Conexao <> "" Then
//	 This.Object.id_projeto_conexao [1]
//End If1

This.AcceptText()

If IsNull(This.Object.Cd_Produto_Central[1]) Then
	This.Object.Nr_Matricula_Inclusao[1] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
End If

wf_Atualiza_Sequencial_Produto()

This.AcceptText()

This.Object.Cd_Divisao_Estocagem[1] = "00"

// Esta informa$$HEX2$$e700e300$$ENDHEX$$o s$$HEX1$$f300$$ENDHEX$$ existia no produto_central agora esta indo para a lojas e por isso foi colocado no produto_geral
This.Object.id_lei_generico_produto_geral[1] = This.Object.id_lei_generico[1]

If This.Object.Id_Apresentacao[1] = "00" Then
	SetNull(lvs_Nulo)
	
	This.Object.Id_Apresentacao[1] = lvs_Nulo
End If

ls_Psico = This.Object.cd_grupo_psico[1]

If Not IsNull( ls_Psico ) And Trim( ls_Psico ) <> "" Then
	This.Object.cd_bairro_wms [1] = "9"
Else
	This.Object.cd_bairro_wms [1] = "1"
End If

lvs_Grupo = Mid(This.Object.cd_subcategoria[1], 1,1)

//If lvs_Grupo = '1' Or lvs_Grupo = '2' Or lvs_Grupo = '3' Or lvs_Grupo = '4' or lvs_Grupo = '7' or lvs_Grupo = '6' Then
//	If IsNull(This.Object.id_liberado_filial[1]) or trim(This.Object.id_liberado_filial[1]) = ''  Then
//		This.Object.id_liberado_filial[1] = "S"
//	End If
//Else
//	This.Object.id_liberado_filial[1] = "N"
//End If

If (IsNull(This.Object.id_liberado_filial[1]) or trim(This.Object.id_liberado_filial[1]) = '' or This.Object.id_liberado_filial[1] = 'N') and (Not IsNull(This.Object.id_liberado_filial_sap[1]) and This.Object.id_liberado_filial_sap[1] = 'S')  Then
	This.Object.id_liberado_filial[1] = "S"
End If

//Se for produto novo n$$HEX1$$e300$$ENDHEX$$o libera para venda
//If ivb_Produto_Novo Then
//	This.Object.id_liberado_filial		[1] = "N"
//	This.Object.Nr_Matricula_Inclusao	[1] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
//End If

ls_Situacao 				= This.Object.id_situacao				[1]
ls_Situacao_Anterior 	= This.Object.id_situacao_anterior	[1]

If ls_Situacao <> ls_Situacao_Anterior Then
	This.Object.dh_Situacao							[1]	= DateTime(Today(), Now())
	This.Object.Nr_matric_alteracao_situacao	[1]	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	
//	//Se a situa$$HEX2$$e700e300$$ENDHEX$$o do produto foi alterada para 'ATIVO' grava um registro na produto_aprovacao (fun$$HEX2$$e700e300$$ENDHEX$$o abaixo wf_Inclui_Produto_Aprovacao)
//	If ls_Situacao = "A" Then
//		lb_Alteracao = True
//	End If
//Else
//	//Se o produto n$$HEX1$$e300$$ENDHEX$$o teve a situa$$HEX2$$e700e300$$ENDHEX$$o alterada, se o produto n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ novo e teve altera$$HEX2$$e700e300$$ENDHEX$$o no NCM ou Lei Gen$$HEX1$$e900$$ENDHEX$$rico, grava um registro na produto_aprovacao (fun$$HEX2$$e700e300$$ENDHEX$$o abaixo wf_Inclui_Produto_Aprovacao) 
//	If Not ivb_Produto_Novo Then 
//		If Not wf_Verifica_Alteracao_NCM_Lei_Gene(This.Object.Cd_Produto_Central[1], Ref lb_Alteracao) Then Return -1
//	End If
End If

//If lb_Alteracao Then
//	If Not wf_Inclui_Produto_Aprovacao(This.Object.Cd_Produto_Central[1], 'A') Then Return -1
//End If

Tab_1.TabPage_1.dw_1.Object.t_motivo.Text = "$$HEX1$$da00$$ENDHEX$$ltimo Motivo Altera$$HEX2$$e700e300$$ENDHEX$$o:"
This.SetTabOrder('de_alteracao_situacao', 0)
This.SetTabOrder('nm_usuario', 0)

Return 1
end event

event ue_recuperar;// Override

Return This.Retrieve(ivo_Produto.Cd_Produto)
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event ue_cancel;call super::ue_cancel;This.Object.t_motivo.Text = "$$HEX1$$da00$$ENDHEX$$ltimo Motivo Altera$$HEX2$$e700e300$$ENDHEX$$o:"
This.SetTabOrder('de_alteracao_situacao', 0)
This.SetTabOrder('nm_usuario', 0)
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3689
integer height = 2556
long backcolor = 80269524
string text = "Subst$$HEX1$$e200$$ENDHEX$$ncias"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_12 gb_12
dw_12 dw_12
end type

on tabpage_6.create
this.gb_12=create gb_12
this.dw_12=create dw_12
this.Control[]={this.gb_12,&
this.dw_12}
end on

on tabpage_6.destroy
destroy(this.gb_12)
destroy(this.dw_12)
end on

type gb_12 from groupbox within tabpage_6
integer x = 14
integer width = 3031
integer height = 1760
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_12 from dc_uo_dw_base within tabpage_6
integer x = 50
integer y = 64
integer width = 2953
integer height = 1664
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_detalhe_substancias"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()

datawindowChild dwc

Tab_1.TabPage_6.Dw_12.GetChild("cd_substancia", dwc)
dwc.setTransObject(SqlCa)
dwc.Retrieve()

end event

event itemchanged;call super::itemchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivo_Controle_Menu.of_Excluir(True)
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then
		ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	ivo_Controle_Menu.of_Excluir(True)
Else
	ivo_Controle_Menu.of_Excluir(False)
End If

Return pl_Linhas
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Produto, &
     lvl_Linha

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Produto[lvl_Linha]) Then
		This.Object.Cd_Produto[lvl_Linha] = lvl_Produto
	End If
Next

Return 1
end event

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event ue_reset;call super::ue_reset;ivo_Controle_Menu.of_Excluir(False)
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event buttonclicked;call super::buttonclicked;//SetPointer(HourGlass!)
//
//dc_m_mdi lvm_Menu
//
//lvm_Menu = Create dc_m_mdi
//
//lvm_Menu.mf_abre_janela("w_co194_cadastro_substancias", True)
//
//Destroy(lvm_Menu)
//
//SetPointer(Arrow!)

Event ue_Consulta_Substancia()
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3689
integer height = 2556
long backcolor = 80269524
string text = "e-Commerce"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_10 gb_10
dw_10 dw_10
end type

on tabpage_5.create
this.gb_10=create gb_10
this.dw_10=create dw_10
this.Control[]={this.gb_10,&
this.dw_10}
end on

on tabpage_5.destroy
destroy(this.gb_10)
destroy(this.dw_10)
end on

type gb_10 from groupbox within tabpage_5
integer x = 14
integer width = 3502
integer height = 1680
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_10 from dc_uo_dw_base within tabpage_5
integer x = 59
integer y = 68
integer width = 3424
integer height = 1592
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_detalhe_ecommerce"
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble()

This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	This.ivm_Menu.mf_Confirmar(True)
	This.ivm_Menu.mf_Cancelar(True)
End If

Choose Case dwo.Name
	Case "de_marca"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Marca_Ecommerce.De_Marca Then
				Return 1
			End If
		Else
			io_Marca_Ecommerce.of_Inicializa()
			
			This.Object.Cd_Marca_Ecommerce	[1] = io_Marca_Ecommerce.cd_marca
			This.Object.de_marca					[1] = io_Marca_Ecommerce.de_marca
		End If
End Choose
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event itemchanged;call super::itemchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

Choose Case dwo.Name
	Case "de_marca"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Marca_Ecommerce.De_Marca Then
				Return 1
			End If
		Else
			io_Marca_Ecommerce.of_Inicializa()
			
			This.Object.Cd_Marca_Ecommerce	[1] = io_Marca_Ecommerce.cd_marca
			This.Object.de_marca					[1] = io_Marca_Ecommerce.de_marca
		End If
End Choose
end event

event ue_key;call super::ue_key;string ls_categoria, ls_retorno, ls_Niveis
long ll_Categoria
boolean lb_Localizado

Choose Case Key
	Case KeyEnter!
		
		If This.GetColumnName() = "de_marca" Then
			If Not ib_Permite_Alter_Cutover Then Return
			
			io_Marca_Ecommerce.of_Localiza_Marca_Ecommerce(This.GetText())
			
			If io_Marca_Ecommerce.Localizada Then
				This.Object.cd_marca_Ecommerce	[1] = io_Marca_Ecommerce.cd_marca
				This.Object.de_marca					[1] = io_Marca_Ecommerce.de_marca
				
				ivb_Valida_Salva = True
				ivm_Menu.mf_Confirmar(True)
				ivm_Menu.mf_Cancelar(True)
			End If
		End If
		
		If This.GetColumnName()  = "de_categoria_ecommerce" Then
		
			ls_Categoria	= This.GetText()
			
			If IsNumber(Trim(ls_Categoria)) Then
				ll_Categoria   = Long(ls_Categoria)
				lb_Localizado = wf_localiza_categoria(ll_Categoria, ref ls_Categoria)
				
				If lb_Localizado Then
					wf_Localiza_Niveis_Categoria(ll_Categoria, Ref ls_Niveis)
					
					This.Object.cd_categoria_ecommerce[This.GetRow()] = ll_Categoria
					This.Object.de_categoria_ecommerce	[This.GetRow()] = ls_Categoria
					This.Object.de_arvore_cat_t.text = ls_Niveis
					
//					ivb_Valida_salva = True
//					ivm_Menu.mf_Confirmar(True)
//					ivm_Menu.mf_Cancelar(True)
				End If
			End If
				
			If Not lb_Localizado Then
				Open(w_ge102_selecao_categoria_ecommerce)
				
				ls_Retorno = Message.StringParm
				
				If Not IsNull(ls_Retorno) and ls_Retorno <> "" Then
					
					ll_Categoria = Long(MidA(ls_Retorno, 1, 3))
					ls_Categoria = MidA(ls_Retorno, 7)
					
					//001 - Medicamentos
					
					wf_Localiza_Niveis_Categoria(ll_Categoria, Ref ls_Niveis)
					
					This.Object.cd_categoria_ecommerce	[1] = ll_Categoria
					This.Object.de_categoria_ecommerce	[1] = ls_Categoria
					This.Object.de_arvore_cat_t.text = ls_Niveis
					
					//ivb_Valida_salva = True
					//ivm_Menu.mf_Confirmar(True)
					//ivm_Menu.mf_Cancelar(True)
				End If
			End If
		End If
		
		
End Choose

wf_Atalhos(Key)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Object.Cd_Divisao_Estocagem[1] = "00"
End If

Return pl_Linhas
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3689
integer height = 2556
long backcolor = 80269524
string text = "Fiscal / Pricing"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_8 gb_8
gb_4 gb_4
gb_14 gb_14
gb_13 gb_13
pb_1 pb_1
dw_7 dw_7
dw_8 dw_8
dw_9 dw_9
dw_14 dw_14
dw_2 dw_2
cb_replica_reposicao cb_replica_reposicao
cb_replica_venda cb_replica_venda
cb_preco_legado cb_preco_legado
dw_18 dw_18
gb_16 gb_16
end type

on tabpage_2.create
this.gb_8=create gb_8
this.gb_4=create gb_4
this.gb_14=create gb_14
this.gb_13=create gb_13
this.pb_1=create pb_1
this.dw_7=create dw_7
this.dw_8=create dw_8
this.dw_9=create dw_9
this.dw_14=create dw_14
this.dw_2=create dw_2
this.cb_replica_reposicao=create cb_replica_reposicao
this.cb_replica_venda=create cb_replica_venda
this.cb_preco_legado=create cb_preco_legado
this.dw_18=create dw_18
this.gb_16=create gb_16
this.Control[]={this.gb_8,&
this.gb_4,&
this.gb_14,&
this.gb_13,&
this.pb_1,&
this.dw_7,&
this.dw_8,&
this.dw_9,&
this.dw_14,&
this.dw_2,&
this.cb_replica_reposicao,&
this.cb_replica_venda,&
this.cb_preco_legado,&
this.dw_18,&
this.gb_16}
end on

on tabpage_2.destroy
destroy(this.gb_8)
destroy(this.gb_4)
destroy(this.gb_14)
destroy(this.gb_13)
destroy(this.pb_1)
destroy(this.dw_7)
destroy(this.dw_8)
destroy(this.dw_9)
destroy(this.dw_14)
destroy(this.dw_2)
destroy(this.cb_replica_reposicao)
destroy(this.cb_replica_venda)
destroy(this.cb_preco_legado)
destroy(this.dw_18)
destroy(this.gb_16)
end on

type gb_8 from groupbox within tabpage_2
integer x = 2126
integer y = 1348
integer width = 1522
integer height = 432
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Pre$$HEX1$$e700$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_2
integer x = 23
integer y = 1348
integer width = 2075
integer height = 432
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Comiss$$HEX1$$e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_14 from groupbox within tabpage_2
integer x = 1559
integer y = 660
integer width = 2089
integer height = 676
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Cadastro para U.F Selecionada"
borderstyle borderstyle = styleraised!
end type

type gb_13 from groupbox within tabpage_2
integer x = 23
integer y = 660
integer width = 1509
integer height = 676
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "U.F.~'s com Filiais Ativas"
borderstyle borderstyle = styleraised!
end type

type pb_1 from picturebutton within tabpage_2
boolean visible = false
integer x = 3648
integer y = 24
integer width = 119
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\question_1.png"
alignment htextalign = left!
end type

type dw_7 from dc_uo_dw_base within tabpage_2
event ue_atualiza_detalhe ( long al_linha )
integer x = 50
integer y = 736
integer width = 1449
integer height = 572
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_lista_uf_produto"
boolean vscrollbar = true
end type

event ue_atualiza_detalhe(long al_linha);dw_8.of_Populate_DDDW("cd_tributacao_icms")
dw_8.of_Populate_DDDW("cd_tributacao_produto")
dw_8.of_Populate_DDDW("cd_tipo_icms")

dw_8.ScrollToRow(al_Linha)
dw_8.SetRow(al_Linha)

//dw_14.ScrollToRow(al_Linha)
//dw_14.SetRow(al_Linha)

dw_18.retrieve( this.object.cd_unidade_federacao[al_linha], this.object.cd_produto[al_linha] )
end event

event constructor;call super::constructor;This.of_SetRowSelection()

If This.ShareData(dw_8) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Share Data da dw_8.", StopSign!)
	Return -1
End If

If This.ShareData(dw_14) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Share Data da dw_14.", StopSign!)
	Return -1
End If
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	This.Post Event ue_Atualiza_Detalhe(CurrentRow)
	dw_7.Object.cd_tributacao_icms		[dw_7.GetRow()] = This.Object.cd_tributacao_icms		[CurrentRow]
	dw_7.Object.cd_tipo_icms				[dw_7.GetRow()] = This.Object.cd_tipo_icms				[CurrentRow]
	dw_7.Object.cd_tributacao_produto	[dw_7.GetRow()] = This.Object.cd_tributacao_produto	[CurrentRow]
	
	dw_14.ScrollToRow(CurrentRow)
	dw_14.SetRow(CurrentRow)
End If
end event

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha

If pl_Linhas > 0 Then
	// Atualiza os indicadores de ICMS e margem espec$$HEX1$$ed00$$ENDHEX$$fica do produto
	For lvl_Linha = 1 To pl_Linhas
		If Not IsNull(This.Object.Pc_ICMS_Compra_Preco[lvl_Linha]) Then
			This.Object.Id_ICMS_Compra[lvl_Linha] = "S"
		End If
		
		If Not IsNull(This.Object.Pc_ICMS_Venda_Preco[lvl_Linha]) Then
			This.Object.Id_ICMS_Venda[lvl_Linha] = "S"
		End If
	
		If Not IsNull(This.Object.Pc_Margem_Resultado_Preco[lvl_Linha]) Then
			This.Object.Id_Margem_Resultado[lvl_Linha] = "S"
		End If
	Next
	
	This.Event RowFocusChanged(1)
End If

Return pl_Linhas
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Produto, &
     lvl_Linha

DateTime lvdh_ServerDate

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

lvdh_ServerDate = gf_GetServerDate()

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Produto[lvl_Linha]) Then
		This.Object.Cd_Produto[lvl_Linha] = lvl_Produto
	End If
	
	If This.Object.Vl_Preco_Reposicao[lvl_Linha] <> This.Object.Vl_Preco_Reposicao_Anterior[lvl_Linha] Then
		This.Object.Dh_Preco_Reposicao          		[lvl_Linha] = lvdh_ServerDate
		This.Object.Nr_Matricula_Preco_Reposicao	[lvl_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	End If
	
	// 1320045 - Almoxarifado e alterou pre$$HEX1$$e700$$ENDHEX$$o de venda (replicou reposi$$HEX2$$e700e300$$ENDHEX$$o)
	If Left(String(Tab_1.TabPage_1.dw_1.GetItemString(1, "cd_subcategoria")), 1) = '5' Then
		If This.GetItemDecimal(lvl_Linha, "Vl_Preco_Venda_Atual") <> This.GetItemDecimal(lvl_Linha, "Vl_Preco_Venda_Atual", Primary!, True) Then
			This.SetItem(lvl_Linha, "Dh_Preco_Venda_Atual", lvdh_ServerDate)
			This.SetItem(lvl_Linha, "Nr_Matric_Preco_Venda_Atual", gvo_Aplicacao.ivo_Seguranca.Nr_Matricula)
		End If
	End If
Next

Return 1
end event

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

type dw_8 from dc_uo_dw_base within tabpage_2
integer x = 1582
integer y = 732
integer width = 2011
integer height = 572
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_detalhe_uf_produto"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event itemchanged;call super::itemchanged;Decimal lvdc_Nulo

SetNull(lvdc_Nulo)

Choose Case dwo.Name
	Case "id_icms_compra"
		If Data = "N" Then
			This.Object.Pc_ICMS_Compra_Preco[Row] = lvdc_Nulo
		Else
			This.Object.Pc_ICMS_Compra_Preco[Row] = 0
		End If
		
	Case "id_icms_venda"
		If Data = "N" Then
			This.Object.Pc_ICMS_Venda_Preco[Row] = lvdc_Nulo
		Else
			This.Object.Pc_ICMS_Venda_Preco[Row] = 0
		End If
		
	Case "id_margem_resultado"
		If Data = "N" Then
			This.Object.Pc_Margem_Resultado_Preco[Row] = lvdc_Nulo
		Else
			This.Object.Pc_Margem_Resultado_Preco[Row] = 0
		End If		
End Choose

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event rowfocuschanged;call super::rowfocuschanged;Tab_1.TabPage_2.dw_7.ScrollToRow(CurrentRow)
Tab_1.TabPage_2.dw_7.SetRow(CurrentRow)
end event

event ue_populate_dddw;call super::ue_populate_dddw;String lvs_UF

lvs_UF = Tab_1.TabPage_2.dw_7.Object.Cd_Unidade_Federacao[Tab_1.TabPage_2.dw_7.GetRow()]

SetPointer(HourGlass!)

pdwc_dddw.SetTransObject(SqlCa)

If ps_Coluna = "cd_tipo_icms" Then
	pdwc_dddw.Retrieve(lvs_UF)
Else
	pdwc_dddw.Retrieve()
End If

SetPointer(Arrow!)
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

type dw_9 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 1400
integer width = 2034
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_detalhe_comissao"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event itemchanged;call super::itemchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivo_Controle_Menu.of_Excluir(True)
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then
		ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	ivo_Controle_Menu.of_Excluir(True)
Else
	ivo_Controle_Menu.of_Excluir(False)
End If

Return pl_Linhas
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Produto, &
     lvl_Linha

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Produto[lvl_Linha]) Then
		This.Object.Cd_Produto[lvl_Linha] = lvl_Produto
	End If
Next

Return 1
end event

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event ue_reset;call super::ue_reset;ivo_Controle_Menu.of_Excluir(False)
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

event buttonclicked;call super::buttonclicked;If This.RowCount() > 0 Then

	This.AcceptText()
	
	st_comissao_sap str
	
	str.cd_produto 			= This.Object.cd_produto				[This.GetRow()]
	str.cd_tipo_comissao 	= This.Object.cd_tipo_comissao		[This.GetRow()]
	
	OpenWithParm(w_ge400_comissao_sap, str)
End If
end event

type dw_14 from dc_uo_dw_base within tabpage_2
integer x = 2149
integer y = 1400
integer width = 1477
integer height = 364
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_detalhe_preco_sap"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()

If Not ib_Permite_Alter_Cutover Then
	If ib_Permite_Alterar_Preco Then
		This.Object.vl_preco_venda_atual_sap.Protect = 0
		//cb_replica_venda.Visible = True
	Else
		This.Object.vl_preco_venda_atual_sap.Protect = 1
		//cb_replica_venda.Visible = False
	End If
End If

end event

event itemchanged;call super::itemchanged;Decimal lvdc_Nulo

SetNull(lvdc_Nulo)

Choose Case dwo.Name
	Case "id_icms_compra"
		If Data = "N" Then
			This.Object.Pc_ICMS_Compra_Preco[Row] = lvdc_Nulo
		Else
			This.Object.Pc_ICMS_Compra_Preco[Row] = 0
		End If
		
	Case "id_icms_venda"
		If Data = "N" Then
			This.Object.Pc_ICMS_Venda_Preco[Row] = lvdc_Nulo
		Else
			This.Object.Pc_ICMS_Venda_Preco[Row] = 0
		End If
		
	Case "id_margem_resultado"
		If Data = "N" Then
			This.Object.Pc_Margem_Resultado_Preco[Row] = lvdc_Nulo
		Else
			This.Object.Pc_Margem_Resultado_Preco[Row] = 0
		End If	
	
	Case "vl_preco_reposicao"
		// 1320045 - Almoxarifado replicar pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o no pre$$HEX1$$e700$$ENDHEX$$o de venda
		If Dec(Data) > 0.00 And Left(String(Tab_1.TabPage_1.dw_1.GetItemString(1, "cd_subcategoria")), 1) = '5' Then
			This.SetItem(Row, "vl_preco_venda_atual_sap", Dec(Data))
		End If
		
End Choose

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	dw_7.ScrollToRow(CurrentRow)
	dw_7.SetRow(CurrentRow)
End If
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

type dw_2 from dc_uo_dw_base within tabpage_2
integer x = 14
integer width = 3657
integer height = 832
integer taborder = 20
string dataobject = "dw_ge400_detalhe_fiscal_preco"
end type

event constructor;call super::constructor;This.of_SetUpdateAble()

This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	This.ivm_Menu.mf_Confirmar(True)
	This.ivm_Menu.mf_Cancelar(True)
End If

If dwo.Name = "de_grupo_alteracao_preco" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Grupo_Alteracao_Preco.de_grupo Then
			Return 1
		End If
	Else
		ivo_Grupo_Alteracao_Preco.of_Inicializa()
	
		wf_Atualiza_Grupo_Alteracao_Preco()
	End If
End If
end event

event itemchanged;call super::itemchanged;Boolean lb_Altera_NCM

Decimal ldc_IPI

Long lvl_Nulo, ll_Classificacao, lvl_Produto

String ls_Projeto, ls_Descricao, ls_NCM, ls_Lista_Pis_Cofins

Tab_1.TabPage_1.dw_1.AcceptText()

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]
 
Choose Case dwo.Name
	Case "vl_fator_conversao"
		If Long(Data) <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O fator de convers$$HEX1$$e300$$ENDHEX$$o deve ser maior que zero.", Information!)			
			Return 1			
		End If	
		
//	Case "cd_local_estocagem"
//		If IsNumber(LeftA(Data, 1)) Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Caract$$HEX1$$e900$$ENDHEX$$r num$$HEX1$$e900$$ENDHEX$$rico inv$$HEX1$$e100$$ENDHEX$$lido. O primeiro caract$$HEX1$$e900$$ENDHEX$$r deve representar a rua do endere$$HEX1$$e700$$ENDHEX$$o.", Information!)			
//			Return 1						
//		End If

	Case "id_caderno_abcfarma"
		If Data = "N" Then			
			ivo_Produto_ABCFarma.of_Inicializa()
			wf_Atualiza_Produto_ABCFarma()
			
			SetNull(lvl_Nulo)
			This.Object.Vl_Fator_Conversao_ABCFarma[Row] = lvl_Nulo
			
			//Como a tela faz update na dw_1, os valores abaixo s$$HEX1$$e300$$ENDHEX$$o anulados para retirar as informa$$HEX2$$e700f500$$ENDHEX$$es da produto_central
			Tab_1.TabPage_1.dw_1.Object.Cd_Produto_ABCFarma				[1] = lvl_Nulo
			Tab_1.TabPage_1.dw_1.Object.Vl_Fator_Conversao_ABCFarma	[1] = lvl_Nulo
		Else
			wf_Verifica_Produto_ABCFarma()
						
			This.Object.Vl_Fator_Conversao_ABCFarma[Row] = 1
		End If
		
	Case "de_produto_abcfarma"
		If Trim(Data) = "" Then
			If This.Object.Id_Caderno_ABCFarma[Row] = "S" Then
				Return 1
			End If
		Else
			If ivo_Produto_ABCFarma.De_Produto <> Data Then
				Return 1
			End If
		End If
			
	Case "vl_fator_conversao_abcfarma"
		If Dec(Data) <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O fator de convers$$HEX1$$e300$$ENDHEX$$o deve ser maior que zero ABC FARMA.", Information!)			
			Return 1
		End If
		
	Case "de_grupo_alteracao_preco"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Grupo_Alteracao_Preco.de_grupo Then
				Return 1
			End If
		Else
			ivo_Grupo_Alteracao_Preco.of_Inicializa()
			
			wf_Atualiza_Grupo_Alteracao_Preco()
		End If
		
	Case 'id_conexao'
		If Data = 'S' Then
			If Not wf_Fornecedor_Conexao( ivo_Fornecedor.cd_fornecedor, Ref ls_Projeto, ls_Descricao) Then Return 1
			
			If IsNull(ls_Projeto) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O fornecedor selecionado n$$HEX1$$e300$$ENDHEX$$o pertence $$HEX1$$e000$$ENDHEX$$ nenhum projeto conex$$HEX1$$e300$$ENDHEX$$o.")
				This.Object.id_conexao [ 1 ] = 'N'
				Return 1
			Else
				This.Object.id_projeto_conexao	[ 1 ] = ls_Projeto
				This.Object.de_conexao				[ 1 ] = ls_Descricao
			End If
		Else
			SetNull( ls_Projeto )
			This.Object.id_projeto_conexao	[ 1 ] = ls_Projeto
			This.Object.de_conexao				[ 1 ] = "NENHUM"
		End If
	Case 'nr_classificacao_fiscal'
		
		If Not IsNull(lvl_Produto) Then
			lb_Altera_NCM = (MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Se o NCM for alterado a [TRIBUTA$$HEX2$$c700c300$$ENDHEX$$O] ser$$HEX1$$e100$$ENDHEX$$ alterada.~r~r" + "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o mesmo assim ?", Question!, YesNo!, 2) = 1)
			
			If Not lb_Altera_NCM Then 
				select nr_classificacao_fiscal
				Into :ll_Classificacao
				from produto_geral
				Where cd_produto = :lvl_Produto
				Using sqlca;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgDbError("Erro ao localizar o produto.")
				End If
				
				This.Object.nr_classificacao_fiscal[1] = ll_Classificacao
				
				Return 1
			End If
		End If
		
		If IsNull(lvl_Produto) or lb_Altera_NCM Then
			If Not wf_Atualiza_Tributacao_NCM(long(data), ref ls_NCM, ref ldc_IPI, ref ls_Lista_Pis_Cofins ) Then
				Return 1
			End If
			
			This.Object.de_ncm					[1] = ls_NCM
			This.Object.id_situacao_pis_cofins	[1] = ls_Lista_Pis_Cofins
			This.Object.pc_ipi						[1] = ldc_IPI
			This.Object.Id_Revisao_Fiscal		[1] = 'P'
		End If
		
End Choose

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event ue_populate_dddw;SetPointer(HourGlass!)

pdwc_dddw.SetTransObject(SqlCa)
pdwc_dddw.Retrieve()

SetPointer(Arrow!)
end event

event losefocus;call super::losefocus;If IsValid(ivo_Produto_ABCFarma) Then
	wf_Atualiza_Produto_ABCFarma()
End If
end event

event ue_key;Boolean lb_Sucesso

Choose Case Key
	Case KeyEnter!

		Choose Case This.GetColumnName()
	
			Case "de_produto_abcfarma"
				lb_Sucesso = wf_Localiza_Produto_ABCFarma(This.GetText(), True)
				
			Case "de_grupo_alteracao_preco"
				lb_Sucesso = wf_Localiza_Grupo_Alteracao_Preco(This.GetText())		
							
		End Choose
		
		If lb_Sucesso Then
			ivb_Valida_Salva = True
			ivm_Menu.mf_Confirmar(True)
			ivm_Menu.mf_Cancelar(True)
		End If		
End Choose

wf_Atalhos(Key)
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event ue_addrow;call super::ue_addrow;Messagebox("TESTE","TSTE")

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Object.Cd_Divisao_Estocagem[1] = "00"
End If

Return pl_Linhas
end event

type cb_replica_reposicao from commandbutton within tabpage_2
integer x = 3397
integer y = 1404
integer width = 224
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Rep. UF"
end type

event clicked;Long ll_Linha

String lvs_Tipo

Decimal ldc_Reposicao

Tab_1.TabPage_2.dw_14.accepttext( )

If dw_7.RowCount() > 0 Then
	
	ldc_Reposicao = Tab_1.TabPage_2.dw_14.Object.Vl_Preco_Reposicao[Tab_1.TabPage_2.dw_14.GetRow()]
	
	If IsNull(ldc_Reposicao) or ldc_Reposicao = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o deve maior que zero.")
		Return
	End If
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja atualizar o pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o em todos os estados ?", Question!, YesNo!, 2) = 2 Then Return
		
	For ll_Linha = 1 To dw_7.RowCount() 
		Tab_1.TabPage_2.dw_7.Object.Vl_Preco_Reposicao[ll_Linha] = ldc_Reposicao
		
		// 1320045 - Para almoxarifado replicar o reposi$$HEX2$$e700e300$$ENDHEX$$o para o de venda
		If Left(String(Tab_1.TabPage_1.dw_1.GetItemString(1, "cd_subcategoria")), 1) = '5' Then
			Tab_1.TabPage_2.dw_7.SetItem(ll_Linha, "vl_preco_venda_atual", ldc_Reposicao)
		End If
	Next
	
End If
end event

type cb_replica_venda from commandbutton within tabpage_2
boolean visible = false
integer x = 3397
integer y = 1496
integer width = 224
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Rep. UF"
end type

event clicked;Long ll_Linha

String lvs_Tipo

Decimal ldc_Venda

Tab_1.TabPage_2.dw_14.accepttext( )

If dw_7.RowCount() > 0 Then
	
	ldc_Venda = Tab_1.TabPage_2.dw_14.Object.vl_preco_venda_atual[Tab_1.TabPage_2.dw_14.GetRow()]
	
	If IsNull(ldc_Venda) or ldc_Venda = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de venda deve ser maior que zero.")
		Return
	End If
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja atualizar o pre$$HEX1$$e700$$ENDHEX$$o de venda em todos os estados ?", Question!, YesNo!, 2) = 2 Then Return
		
	For ll_Linha = 1 To dw_7.RowCount() 
		Tab_1.TabPage_2.dw_7.Object.vl_preco_venda_atual[ll_Linha] = ldc_Venda
	Next
	
End If
end event

type cb_preco_legado from commandbutton within tabpage_2
boolean visible = false
integer x = 3397
integer y = 1576
integer width = 224
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Legado"
end type

event clicked;long ll_cd_produto, ll_linha
string ls_uf
dc_uo_ds_base lds_dados

lds_dados = create dc_uo_ds_base
lds_dados.of_changedataobject( 'dw_ge400_preco_legado' )

tab_1.tabpage_1.dw_1.accepttext( )
ll_linha = tab_1.tabpage_1.dw_1.getrow( )

ll_cd_produto = tab_1.tabpage_1.dw_1.object.cd_produto_central[ll_linha]

ll_linha = dw_7.getrow()

ls_uf = dw_7.object.cd_unidade_federacao[ll_linha]

lds_dados.retrieve(ll_cd_produto, ls_uf)

OpenWithParm(w_ge400_preco_legado, lds_dados)

end event

type dw_18 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 1896
integer width = 1797
integer height = 224
integer taborder = 20
string dataobject = "dw_ge400_detalhe_pmc_sap"
end type

type gb_16 from groupbox within tabpage_2
integer x = 23
integer y = 1808
integer width = 2075
integer height = 432
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Pre$$HEX1$$e700$$ENDHEX$$o PMC SAP (Futuro)"
borderstyle borderstyle = styleraised!
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3689
integer height = 2556
long backcolor = 80269524
string text = "Descontos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_2 gb_2
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
cbx_mostra_produtos_planograma cbx_mostra_produtos_planograma
dw_16 dw_16
end type

on tabpage_3.create
this.gb_2=create gb_2
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_5=create gb_5
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cbx_mostra_produtos_planograma=create cbx_mostra_produtos_planograma
this.dw_16=create dw_16
this.Control[]={this.gb_2,&
this.gb_7,&
this.gb_6,&
this.gb_5,&
this.dw_3,&
this.dw_4,&
this.dw_5,&
this.cbx_mostra_produtos_planograma,&
this.dw_16}
end on

on tabpage_3.destroy
destroy(this.gb_2)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cbx_mostra_produtos_planograma)
destroy(this.dw_16)
end on

type gb_2 from groupbox within tabpage_3
integer x = 14
integer y = 4
integer width = 2373
integer height = 172
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filtro de Promo$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within tabpage_3
integer x = 14
integer y = 1464
integer width = 3630
integer height = 988
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Pre$$HEX1$$e700$$ENDHEX$$os Regionalizados"
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within tabpage_3
integer x = 14
integer y = 908
integer width = 3159
integer height = 536
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Contratos com Conv$$HEX1$$ea00$$ENDHEX$$nios"
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within tabpage_3
integer x = 14
integer y = 176
integer width = 3662
integer height = 728
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Promo$$HEX2$$e700f500$$ENDHEX$$es"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_3
integer x = 37
integer y = 236
integer width = 3611
integer height = 620
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_detalhe_promocao"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_preretrieve;call super::ue_preretrieve;Tab_1.TabPage_3.dw_3.Reset()

Tab_1.TabPage_3.dw_16.AcceptText()

//If Not cbx_mostra_produtos_planograma.Checked Then
If Tab_1.TabPage_3.dw_16.Object.Id_Planograma[1] = "N" Then
	This.of_appendwhere_subquery("a.id_tipo_promocao <> 'P' ",2)	
End If

If Tab_1.TabPage_3.dw_16.Object.Id_Filiais[1] = "C" And is_filiais <> "" Then
	This.of_appendwhere_subquery("(f.cd_filial in (" + is_Filiais + "))",2)
	
End If

Return 1
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 41
integer y = 952
integer width = 3104
integer height = 472
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_detalhe_contrato_convenio"
boolean vscrollbar = true
end type

event ue_recuperar;// Override
Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

type dw_5 from dc_uo_dw_base within tabpage_3
integer x = 37
integer y = 1516
integer width = 3575
integer height = 912
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_detalhe_preco_regionalizado"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

event ue_preretrieve;call super::ue_preretrieve;Tab_1.TabPage_3.dw_5.Reset()

Tab_1.TabPage_3.dw_16.AcceptText()

If Tab_1.TabPage_3.dw_16.Object.Id_Filiais[1] = "C" And is_filiais <> "" Then
	This.of_appendwhere("(f.cd_filial in (" + is_Filiais + "))")
	
End If

Return 1
end event

type cbx_mostra_produtos_planograma from checkbox within tabpage_3
boolean visible = false
integer x = 2546
integer y = 64
integer width = 82
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean lefttext = true
end type

event clicked;Tab_1.TabPage_3.dw_3.Reset()
Tab_1.TabPage_3.dw_3.Event ue_Retrieve()
end event

type dw_16 from dc_uo_dw_base within tabpage_3
integer x = 27
integer y = 68
integer width = 2341
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_filtros"
end type

event itemchanged;call super::itemchanged;Long ll_Lojas

Choose Case dwo.Name
	Case "id_filiais"
		
		If Data = 'C' Then
		
			SetNull(is_Filiais)
			
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			ll_Lojas = Message.DoubleParm
			
			If ll_Lojas > 0 Then
				is_Filiais = uo_Filiais.ivs_filiais
				
				Tab_1.TabPage_3.dw_3.Event ue_Retrieve()
				Tab_1.TabPage_3.dw_5.Event ue_Retrieve()
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
			
		Else
			//Se for selecionado "TODOS"
			Tab_1.TabPage_3.dw_3.Event ue_Retrieve()
			Tab_1.TabPage_3.dw_5.Event ue_Retrieve()
		End If
		
	Case "id_planograma"
		If Data = "S" Then
			This.Object.Id_Planograma[1] = "S"
		Else
			This.Object.Id_Planograma[1] = "N"
		End If
		
		Tab_1.TabPage_3.dw_3.Event ue_Retrieve()
		Tab_1.TabPage_3.dw_5.Event ue_Retrieve()
		
End Choose
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3689
integer height = 2556
long backcolor = 80269524
string text = "Estoque"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_11 gb_11
gb_3 gb_3
dw_6 dw_6
dw_15 dw_15
dw_17 dw_17
end type

on tabpage_4.create
this.gb_11=create gb_11
this.gb_3=create gb_3
this.dw_6=create dw_6
this.dw_15=create dw_15
this.dw_17=create dw_17
this.Control[]={this.gb_11,&
this.gb_3,&
this.dw_6,&
this.dw_15,&
this.dw_17}
end on

on tabpage_4.destroy
destroy(this.gb_11)
destroy(this.gb_3)
destroy(this.dw_6)
destroy(this.dw_15)
destroy(this.dw_17)
end on

type gb_11 from groupbox within tabpage_4
integer x = 1559
integer y = 1044
integer width = 1957
integer height = 404
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista PBM"
end type

type gb_3 from groupbox within tabpage_4
integer x = 14
integer y = 1044
integer width = 1499
integer height = 768
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de EAN"
borderstyle borderstyle = styleraised!
end type

type dw_6 from dc_uo_dw_base within tabpage_4
integer x = 18
integer y = 1100
integer width = 1463
integer height = 692
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_detalhe_codigo_barras"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_addrow;call super::ue_addrow;DateTime lvdh_ServerDate

If AncestorReturnValue > 0 Then
	lvdh_ServerDate = gf_GetServerDate()
	
	This.Object.Dh_Atualizacao          [AncestorReturnValue] = lvdh_ServerDate
	This.Object.Nr_Matricula_Atualizacao[AncestorReturnValue] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	This.Object.Nm_Usuario              [AncestorReturnValue] = gvo_Aplicacao.ivo_Seguranca.Nm_Usuario
	
	ivo_Controle_Menu.of_Excluir(True)
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then
		ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Produto, &
     lvl_Linha

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Produto[lvl_Linha]) Then
		This.Object.Cd_Produto[lvl_Linha] = lvl_Produto
	End If
Next

Return 1
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event itemchanged;call super::itemchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

This.Object.Nr_Matricula_Atualizacao[Row] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event ue_reset;call super::ue_reset;ivo_Controle_Menu.of_Excluir(False)
end event

event ue_postretrieve;String ls_produto_sap, ls_cd_sistema

ls_produto_sap = dw_15.object.cd_produto_sap [1]

This.Object.id_exclusao.Visible = False

If pl_Linhas > 0 Then
	ivo_Controle_Menu.of_Excluir(True)
	If ivb_Possui_Permissao Then 
		If Isnull(ls_produto_sap) Or ls_produto_sap = '' Then
			This.Object.id_exclusao.Visible = True
		Else
			This.Object.id_exclusao.Visible = False
		End If
	End If
Else
	ivo_Controle_Menu.of_Excluir(False)
End If

Return pl_Linhas
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

event ue_preinsertrow;call super::ue_preinsertrow;If Not ib_Permite_Alter_Cutover Then Return -1

Return AncestorReturnValue
end event

event ue_predeleterow;call super::ue_predeleterow;If Not ib_Permite_Alter_Cutover Then Return False

Return AncestorReturnValue
end event

event buttonclicked;call super::buttonclicked;Long ll_resposta, ll_produto
String ls_erro, ls_Operador, ls_codigo_barras

Boolean ib_achou

If not ivb_Possui_Permissao Then Return -1

ll_Produto 	= dw_15.Object.cd_produto_central[1]
ls_codigo_barras = this.Object.de_codigo_barras[row]
ls_Operador	= gvo_Aplicacao.ivo_seguranca.nr_matricula

ib_achou = False

ll_resposta = MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Deseja excluir o EAN?', Question!,OKCancel!,2)
								
If ll_resposta = 1 Then
	
	If Not wf_Grava_Historico_Alteracao('CODIGO_BARRAS_PRODUTO', String(ll_Produto), 'DE_CODIGO_BARRAS', ls_codigo_barras, ls_Operador, 'E') Then
		Return -1
	End If
	
	
	Delete codigo_barras_produto
	Where cd_produto = :ll_Produto
	And de_codigo_barras = :ls_codigo_barras
	And id_principal_sap Is null
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SQLErrText
		SqlCa.of_Rollback()
		MessageBox("Erro", "Erro em excluir o EAN."+ls_Erro )		
		Return -1
	End If
	ib_achou = True
Else
	//Cancelamento
End IF

If ib_achou Then
	SqlCa.of_Commit() 
	MessageBox("Sucesso", "EAN excluido com sucesso.")
	This.Retrieve(ll_Produto)
	Return 1
End If

Return 1
end event

type dw_15 from dc_uo_dw_base within tabpage_4
integer x = 9
integer width = 3543
integer height = 1036
integer taborder = 20
string dataobject = "dw_ge400_detalhe_estoque"
end type

event itemchanged;call super::itemchanged;Long lvl_Produto

String ls_Projeto, ls_Descricao

Tab_1.TabPage_1.dw_1.AcceptText()

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]
 
Choose Case dwo.Name
	Case 'id_conexao'
		If Data = 'S' Then
			If Not wf_Fornecedor_Conexao( ivo_Fornecedor.cd_fornecedor, Ref ls_Projeto, ls_Descricao) Then Return 1
			
			If IsNull(ls_Projeto) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O fornecedor selecionado n$$HEX1$$e300$$ENDHEX$$o pertence $$HEX1$$e000$$ENDHEX$$ nenhum projeto conex$$HEX1$$e300$$ENDHEX$$o.")
				This.Object.id_conexao [ 1 ] = 'N'
				Return 1
			Else
				This.Object.id_projeto_conexao	[ 1 ] = ls_Projeto
				This.Object.de_conexao				[ 1 ] = ls_Descricao
			End If
		Else
			SetNull( ls_Projeto )
			This.Object.id_projeto_conexao	[ 1 ] = ls_Projeto
			This.Object.de_conexao				[ 1 ] = "NENHUM"
		End If		
		
//	Case	'cd_tipo_alerta_restricao'
//		Tab_1.TabPage_4.dw_11.Event ue_Retrieve()
End Choose

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

type dw_17 from dc_uo_dw_base within tabpage_4
integer x = 1577
integer y = 1100
integer width = 1915
integer height = 324
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge400_pbm"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_recuperar;//OverRide

Return This.Retrieve(ivo_Produto.Cd_Produto)
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3689
integer height = 2556
long backcolor = 80269524
string text = "Outros Dados"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_19 dw_19
end type

on tabpage_7.create
this.dw_19=create dw_19
this.Control[]={this.dw_19}
end on

on tabpage_7.destroy
destroy(this.dw_19)
end on

type dw_19 from dc_uo_dw_base within tabpage_7
integer x = 9
integer y = 32
integer width = 3675
integer height = 2156
integer taborder = 20
string dataobject = "dw_ge400_cadastro_produto_outros"
end type

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event itemchanged;call super::itemchanged;Long lvl_Produto

String ls_Projeto, ls_Descricao

Tab_1.TabPage_1.dw_1.AcceptText()

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]
 
Choose Case dwo.Name
	Case 'id_conexao'
		If Data = 'S' Then
			If Not wf_Fornecedor_Conexao( ivo_Fornecedor.cd_fornecedor, Ref ls_Projeto, ls_Descricao) Then Return 1
			
			If IsNull(ls_Projeto) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O fornecedor selecionado n$$HEX1$$e300$$ENDHEX$$o pertence $$HEX1$$e000$$ENDHEX$$ nenhum projeto conex$$HEX1$$e300$$ENDHEX$$o.")
				This.Object.id_conexao [ 1 ] = 'N'
				Return 1
			Else
				This.Object.id_projeto_conexao	[ 1 ] = ls_Projeto
				This.Object.de_conexao				[ 1 ] = ls_Descricao
			End If
		Else
			SetNull( ls_Projeto )
			This.Object.id_projeto_conexao	[ 1 ] = ls_Projeto
			This.Object.de_conexao				[ 1 ] = "NENHUM"
		End If		
		
//	Case	'cd_tipo_alerta_restricao'
//		Tab_1.TabPage_4.dw_11.Event ue_Retrieve()
End Choose

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event ue_key;call super::ue_key;wf_Atalhos(Key)
end event

type gb_15 from groupbox within w_ge400_cadastro_produto
integer x = 23
integer y = 1560
integer width = 2075
integer height = 432
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Comiss$$HEX1$$e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

