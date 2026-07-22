HA$PBExportHeader$uo_ge473_produto_sap.sru
forward
global type uo_ge473_produto_sap from nonvisualobject
end type
end forward

global type uo_ge473_produto_sap from nonvisualobject
end type
global uo_ge473_produto_sap uo_ge473_produto_sap

type variables
uo_ge470_sap_comum io_sap_comum

uo_ge473_comum	io_Comum

uo_cest ivo_cest //GE021

//

Boolean ib_revisao_fiscal 
Boolean ib_NCM_Alterado

DateTime idh_Situacao
DateTime idh_inicio_standby /*pc*/
DateTime idh_fim_standby /*pc*/





Long				il_cd_grupo_alteracao_preco,&
		/*pg*/	il_cd_marca,&
		/*pg*/	il_cd_marca_ecommerce,&
		/*pg*/	il_cd_planograma,&
					il_cd_prod_referencia_preco,&
					il_cd_tipo_alerta_restricao,&
		/*pg*/	il_cd_tipo_prescricao,&
					il_cd_tipo_produto_pricing,&
		/*pg*/	il_nr_classificacao_fiscal,&
		/*pg*/	il_nr_embalagem_padrao,&
		/*pg*/	il_qt_dias_maximo_tratamento,&
		/*pg*/	il_qt_estoque_minimo,&
		/*pg*/	il_qt_pontos_resgate,&
		/*pg*/	il_qt_unidades_embalagem,&
		/*pc*/	il_cd_mix_produto,&
					il_qt_prazo_reposicao,&
					il_cd_area_farmacia,&
					il_cd_tarja,&
					il_cd_cronicidade, &
		/*pg*/	il_cd_produto_texto_min_saude, &
					il_cd_produto_area_atuacao,    &
					il_cd_produto_atributo,        &
					il_cd_produto_posologia,       &
					il_cd_produto_precaucoes,      &
					il_cd_produto_publico_dest,    &
					il_cd_produto_faixa_etaria,    &
					il_cd_produto_selo
					
String			is_Coluna,&
					is_Vl_Item,&
					is_Obrig,&
		/*pg*/	is_cd_dcb,&
		/*pg*/	is_cd_fornecedor_usual,&
		/*pg*/	is_cd_grupo_psico,&
		/*pg*/	is_cd_linha_produto,&
					is_cd_produto_fornecedor,&
					is_cd_segmento_ims,&
		/*pg*/	is_cd_st_origem,&
		/*pg*/	is_cd_unidade_medida_compra,&
		/*pg*/	is_cd_unidade_medida_padrao,&
		/*pg*/	is_cd_unidade_medida_venda,&
		/*pg*/	is_de_apresentacao_estoque,&
		/*pg*/	is_de_apresentacao_venda,&
					is_de_cest,&
					is_de_codigo_barras,&
					is_de_dcb,&
		/*pg*/	is_de_descricao_internet,&
					is_de_grupo_alteracao_preco,&
					is_de_grupo_psico,&
		/*pc*/	is_de_historico_fiscal,&
					is_de_lei_generico,&
					is_de_linha_produto,&
		/*pg*/	is_de_marca,&
					is_de_marca_ecommerce,&
					is_de_mix_produto,&
					is_de_planograma,&
		/*pg*/	is_de_principal_internet,&
		/*pg*/	is_de_produto,&
		/*pg*/	is_de_registro_ms,&
		/****/	is_de_motivo_registro_ms_isento,&
					is_de_segmento_ims,&
					is_de_tipo_alerta_restricao,&
					is_de_tipo_prescricao,&
					is_de_tipo_produto_pricing,&
					is_de_tipo_reposicao_estoque,&
					is_de_tipo_un_calc_preco,&
					is_id_alt_preco_blq_farmagora,&
					is_id_bloqueia_calculo_preco,&
		/*pg*/	is_id_caderno_abcfarma,&
		/*pg*/	is_id_contem_acucar,&
		/*pg*/	is_id_contem_gluten,&
		/*pg*/	is_id_contem_lactose,&
		/*pg*/	is_id_exclusivo,&
					is_id_exclusivo_pedido_falta_ba,&
		/*pg*/	is_id_farmacia_popular,&
		/*pg*/	is_id_geladeira,&
		/*pg*/	is_id_gratis_farm_popular,&
		/*pg*/	is_id_lei_generico,&
		/*pg*/	is_id_liberado_ecommerce,&
		/*pg*/	is_id_liberado_filial,&
		/*pg*/	is_id_permite_devolucao,&
		/*pc*/	is_id_projeto_conexao,&
		/*pg*/	is_id_promover_venda,&
					is_id_retira_bloq_compra_distrib,&
		/*pg*/	is_id_situacao,&
		/*pc*/	is_id_sugere_pedido_filial,&
					is_id_tipo_reposicao_estoque,&
					is_id_tipo_un_calc_preco,&
		/*pg*/	is_id_utiliza_vale_resgate,&
					is_nr_cas_dcb, &
					is_cd_produto_sap_generico, &
					is_Medicamento,&
					is_de_area_farmacia,&
					is_de_tarja,&
					is_de_cronicidade,&  					
					is_cd_arvore_mercadologica,&
					is_cd_grupo_mercadoria,&
					is_de_grupo_mercadoria,&
					is_id_sem_gtin,&
					is_farm_gov_bolsa_familia,&
					is_id_marca_propria,&
					is_id_caract_variante,&
					is_id_cobre_preco_pbm,&
					is_desc_com_prin,&
					is_desc_com_sec,&
					is_permite_publicidade, &
					is_publicidade_obri_texto_legal, &
					is_texto_legal, &
		/*pc*/	is_id_lib_marketing_externo,   &
		/*pc*/	is_id_lib_marketing_interno,   &
		/*pg*/	is_cd_produto_area_atuacao,    &
					is_cd_produto_atributo,        &
					is_cd_produto_posologia,       &
					is_cd_produto_precaucoes,      &
					is_cd_produto_publico_dest,    &
					is_cd_produto_faixa_etaria,    &
					is_cd_produto_selo,            &
					is_cd_produto_texto_min_saude, &
					is_id_contem_corante,          &
					is_id_testado_animais,         &
					is_id_vegano,					&
		/*pc*/	is_id_standby,					&
		/*pc*/	is_desc_standby
					
String is_cd_cest
String is_id_situacao_pis_cofins
String is_de_tipo_apresentacao
String is_id_apresentacao					/*pg*/
String is_nr_cnpj_fabricante
String is_nm_razao_social_fabricante
String is_cd_produto_sap
String is_Usuario_SAP = "SAP001"
String is_id_liberado_ecommerce_dc
String is_id_liberado_ecommerce_mp
String is_id_liberado_ecommerce_pp
String is_id_liberado_filial_sap
String is_de_alteracao_situacao
String is_SubCategoria
String is_cd_prod_referencia_preco
String is_de_tag_title
String is_de_tag_description
String is_id_rede_filial

Long	il_cd_fabricante /*pg*/

Long il_cd_produto_legado
Long il_cd_categ_mercadologica
		
Decimal				idc_pc_comissao_normal,&
						idc_pc_comissao_seletiva,&
						idc_pc_desconto_conexao,&
						idc_pc_desconto_fornecedor,&
						idc_pc_prod_referencia_preco,&
			/*pg*/	idc_qt_altura_cm,&
			/*pc*/	idc_qt_altura_cm_caixa_estoque,&
						idc_qt_dosagem_maxima_dcb,&
						idc_qt_dosagem_minima_dcb,&
			/*pg*/	idc_qt_largura_cm,&
			/*pc*/	idc_qt_largura_cm_caixa_estoque,&
						idc_qt_peso_apresentacao,&
			/*pg*/	idc_qt_peso_grama,&
						idc_qt_peso_kg_estoque,&
			/*pg*/	idc_qt_profundidade_cm,&
			/*pc*/	idc_qt_profund_cm_caixa_estoque,&
			/*pg*/	idc_vl_fator_conversao,&
			/*pg*/	idc_vl_fator_conversao_padrao,&
			/*pg*/	idc_vl_ponto_clube,&
			/*pg*/	idc_vl_reembolso_fpb,&
			/*pg*/	idc_vl_volume,&
			/*pg*/    idc_qt_comprimento
			
Decimal idc_qt_concentracao
Decimal idc_vl_fator_conversao_abcfarma

Decimal idc_qt_altura_cm_caixa_forn
Decimal idc_qt_largura_cm_caixa_forn
Decimal idc_qt_profundidade_cm_caixa_forn
Decimal idc_vl_temp_minima
Decimal idc_vl_temp_maxima
			
dc_uo_ds_base ids_ean
dc_uo_ds_base ids_ean_cad
dc_uo_ds_base ids_ean_cadastrados

//			is_de_alteracao_situacao,&
end variables

forward prototypes
public function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_valida_dados (ref string as_log)
public function boolean of_cadastra_planograma (ref string as_log)
public function boolean of_cadastra_alerta_restricao (ref string as_log)
public function boolean of_cadastra_fabricante (ref string as_log)
public function boolean of_cadastra_tipo_apresentacao (ref string as_log)
public function boolean of_cadastra_dcb (ref string as_log)
public function boolean of_cadastra_lei_generico (ref string as_log)
public function boolean of_cadastra_linha_produto (ref string as_log)
public function boolean of_cadastra_marca_ecommerce (ref string as_log)
public function boolean of_cadastra_cest (ref string as_log)
public function boolean of_cadastra_tipo_prescricao (ref string as_log)
public function boolean of_cadastra_mix_produto (ref string as_log)
public function boolean of_cadastra_grupo_alteracao_preco (ref string as_log)
public function boolean of_cadastra_tipo_produto_pricing (ref string as_log)
public function boolean of_cadastra_segmento_ims (ref string as_log)
public function boolean of_cadastra_marca_produto (ref string as_log)
public function boolean of_carrega_codigo_barra (long al_controle_pai, ref string as_log)
public function boolean of_produto_novo (ref long al_produto, ref boolean ab_produto_novo, ref string as_log)
public function boolean of_insere_produto_geral (long al_produto, boolean ab_produto_novo, ref string as_log)
public function boolean of_insere_produto_central (long al_produto, boolean ab_produto_novo, ref string as_log)
public function boolean of_insere_produto_uf (long al_produto, boolean ab_produto_novo, ref string as_log)
public function boolean of_grava_historico_produto_geral (long al_produto, ref string as_log)
public function boolean of_grava_historico_produto_central (long al_produto, ref string as_log)
public function boolean of_insere_codigo_barras (ref long al_produto, ref boolean ab_produto_novo, ref string as_log)
public function boolean of_cadastra_comissao (long al_produto, long al_tipo_comissao, ref string as_log)
public function string of_retorna_valor ()
public function boolean of_verifica_ean_cadastrados (long al_produto, ref string as_log)
public function boolean of_verifica_ncm (ref string as_log)
public function boolean of_valida_minimo_pbm (ref string as_log)
public function boolean of_carrega_ean_dimensoes_un (boolean ab_produto_novo, long al_produto, ref string as_log)
public function string of_texto_internet (string as_texto)
public function boolean of_fornecedor_divisao (long al_produto, string as_fornecedor, ref string as_log)
public function boolean of_envia_sap_codigo_legado (string as_codigo_sap, string as_codigo_legado, ref string as_log)
public function boolean of_processa_retorno_sap (string as_xml_retorno, ref string as_erro)
public function boolean of_atualiza_produto (long al_controle)
public function boolean of_atualiza_cod_barra_sap (long al_controle_pai, ref string as_log)
public function boolean of_revisao_desconto_preste (long al_produto, ref string as_log)
public function boolean of_valida_categ_mercadologica (ref string ps_log)
public function boolean of_insere_ecommerce_prd (long pl_cd_produto, ref string ps_log)
public function boolean of_atualiza_ecommerce_prd (long pl_cd_produto, long al_controle_pai, ref string as_log)
public function boolean of_cadastra_area_farmacia (ref string as_log)
public function boolean of_cadastra_tarja (ref string as_log)
public function boolean of_cadastra_cronicidade (ref string as_log)
public function boolean of_verifica_arvore_mercadologica (string as_arvore_mercadologica)
public function boolean of_cadastra_grupo_mercadorias (ref string as_log)
public function boolean of_verifica_origem_st ()
public function boolean of_verifica_medicamento ()
public function boolean of_get_data_alt_lote_cont_saldo_loja (ref date ad_data_permitida, ref string as_log)
public function boolean of_permite_alt_cont_saldo_filial (long al_cd_produto, ref boolean ab_permite, ref string as_log)
public function boolean of_get_prod_alt_lote_cont_saldo_loja (ref any aa_produtos[], ref string as_log)
public function boolean of_valida_area_atuacao (ref string ps_log)
public function boolean of_valida_atributo (ref string ps_log)
public function boolean of_valida_posologia (ref string ps_log)
public function boolean of_valida_precaucoes (ref string ps_log)
public function boolean of_valida_publico_dest (ref string ps_log)
public function boolean of_valida_faixa_etaria (ref string ps_log)
public function boolean of_valida_selo (ref string ps_log)
public function boolean of_valida_texto_min_saude (ref string ps_log)
public function boolean of_processa_atualizacao ()
end prototypes

public function boolean of_inicializa_variaveis (ref string as_log);Try
	ib_revisao_fiscal = False
	ib_NCM_Alterado = False
	
	SetNull(idh_Situacao)
	setNull(il_cd_fabricante)
	setNull(il_cd_grupo_alteracao_preco)
	setNull(il_cd_marca)
	setNull(il_cd_marca_ecommerce)
	setNull(il_cd_planograma)
	setNull(il_cd_prod_referencia_preco)
	setNull(il_cd_tipo_alerta_restricao)
	setNull(il_cd_tipo_prescricao)
	setNull(il_cd_tipo_produto_pricing)
	setNull(il_nr_classificacao_fiscal)
	setNull(il_nr_embalagem_padrao)
	setNull(il_qt_dias_maximo_tratamento)
	setNull(il_qt_estoque_minimo)
	setNull(il_qt_pontos_resgate)
	setNull(il_qt_unidades_embalagem)
	setNull(il_cd_produto_legado)
	setNull(il_cd_mix_produto)
	SetNull(il_cd_produto_area_atuacao)
	SetNull(il_cd_produto_atributo)
	SetNull(il_cd_produto_posologia)
	SetNull(il_cd_produto_precaucoes)
	SetNull(il_cd_produto_publico_dest)
	SetNull(il_cd_produto_faixa_etaria)
	SetNull(il_cd_produto_selo)
	SetNull(il_cd_produto_texto_min_saude)

	SetNull(is_desc_com_prin)
	SetNull(is_desc_com_sec)
	SetNull(is_permite_publicidade)
	SetNull(is_publicidade_obri_texto_legal)
	SetNull(is_texto_legal)
	setNull(is_cd_produto_sap)
	setNull(is_Coluna)
	setNull(is_Vl_Item)
	setNull(is_Obrig)
	//setNull(is_cd_cest)
	setNull(is_cd_dcb)
	setNull(is_cd_fornecedor_usual)
	setNull(is_cd_grupo_psico)
	setNull(is_cd_linha_produto)
	setNull(is_cd_produto_fornecedor)
	setNull(is_cd_segmento_ims)
	setNull(is_cd_st_origem)
	setNull(is_cd_unidade_medida_compra)
	setNull(is_cd_unidade_medida_padrao)
	setNull(is_cd_unidade_medida_venda)
//	setNull(is_de_alteracao_situacao)
	setNull(is_de_apresentacao_estoque)
	setNull(is_de_apresentacao_venda)
	setNull(is_de_cest)
	setNull(is_de_codigo_barras)
	setNull(is_de_dcb)
	setNull(is_de_descricao_internet)
	setNull(is_de_grupo_alteracao_preco)
	setNull(is_de_grupo_psico)
	setNull(is_de_historico_fiscal)
	setNull(is_de_lei_generico)
	setNull(is_de_linha_produto)
	setNull(is_de_marca)
	setNull(is_de_marca_ecommerce)
	setNull(is_de_mix_produto)
	setNull(is_de_planograma)
	setNull(is_de_principal_internet)
	setNull(is_de_produto)
	setNull(is_de_registro_ms)
	setNull(is_de_motivo_registro_ms_isento)
	setNull(is_de_segmento_ims)
//	setNull(is_de_situacao_pis_cofins)
	setNull(is_de_tipo_alerta_restricao)
	setNull(is_de_tipo_prescricao)
	setNull(is_de_tipo_produto_pricing)
	setNull(is_de_tipo_reposicao_estoque)
	setNull(is_de_tipo_un_calc_preco)
	setNull(is_id_alt_preco_blq_farmagora)
	setNull(is_id_apresentacao)
	setNull(is_id_bloqueia_calculo_preco)
	setNull(is_id_caderno_abcfarma)
	setNull(is_id_contem_acucar)
	setNull(is_id_contem_gluten)
	setNull(is_id_contem_lactose)
	setNull(is_id_exclusivo)
	setNull(is_id_exclusivo_pedido_falta_ba)
	setNull(is_id_farmacia_popular)
	setNull(is_id_geladeira)
	setNull(is_id_gratis_farm_popular)
	setNull(is_id_lei_generico)
	setNull(is_id_liberado_ecommerce)
	setNull(is_id_liberado_filial)
	setNull(is_id_permite_devolucao)
	setNull(is_id_projeto_conexao)
	setNull(is_id_promover_venda)
	setNull(is_id_retira_bloq_compra_distrib)
	setNull(is_id_situacao)
//	setNull(is_id_situacao_pis_cofins)
	setNull(is_id_sugere_pedido_filial)
	setNull(is_id_tipo_reposicao_estoque)
	setNull(is_id_tipo_un_calc_preco)
	setNull(is_id_utiliza_vale_resgate)
	setNull(is_nm_razao_social_fabricante)
	setNull(is_nr_cas_dcb)
	setNull(is_nr_cnpj_fabricante)
	setNull(is_id_lib_marketing_externo)
	setNull(is_id_lib_marketing_interno)
	SetNull(is_cd_produto_area_atuacao)
	SetNull(is_cd_produto_atributo)
	SetNull(is_cd_produto_posologia)
	SetNull(is_cd_produto_precaucoes)
	SetNull(is_cd_produto_publico_dest)
	SetNull(is_cd_produto_faixa_etaria)
	SetNull(is_cd_produto_selo)
	SetNull(is_cd_produto_texto_min_saude)
	setNull(is_id_contem_corante)
	setNull(is_id_testado_animais)
	setNull(is_id_vegano)
	
	setNull(idh_fim_standby)
	setNull(idh_inicio_standby)
	setNull(is_id_standby)
	setNull(is_desc_standby)
		
	setNull(idc_pc_comissao_normal)
	setNull(idc_pc_comissao_seletiva)
	setNull(idc_pc_desconto_conexao)
	setNull(idc_pc_desconto_fornecedor)
	setNull(idc_pc_prod_referencia_preco)
	setNull(idc_qt_altura_cm)
	setNull(idc_qt_altura_cm_caixa_estoque)
	setNull(idc_qt_altura_cm_caixa_forn)
	setNull(idc_qt_dosagem_maxima_dcb)
	setNull(idc_qt_dosagem_minima_dcb)
	setNull(idc_qt_largura_cm)
	setNull(idc_qt_largura_cm_caixa_estoque)
	setNull(idc_qt_largura_cm_caixa_forn)
	setNull(idc_qt_peso_apresentacao)
	setNull(idc_qt_peso_grama)
	setNull(idc_qt_peso_kg_estoque)
	setNull(idc_qt_profundidade_cm)
	setNull(idc_qt_profundidade_cm_caixa_forn)
	setNull(idc_qt_profund_cm_caixa_estoque)
	setNull(idc_vl_fator_conversao)
	setNull(idc_vl_fator_conversao_padrao)
	setNull(idc_vl_ponto_clube)
	setNull(idc_vl_reembolso_fpb)
	setNull(idc_vl_volume)
	setNull(idc_qt_comprimento)
	setNull(idc_vl_temp_maxima)
	setNull(idc_vl_temp_minima)
	
	setNull(il_qt_prazo_reposicao)
	setNull(il_cd_area_farmacia)
	setNull(il_cd_tarja)
	setNull(il_cd_cronicidade)
	setNull(is_de_area_farmacia)
	setNull(is_de_tarja)
	setNull(is_de_cronicidade)
	setNull(is_cd_arvore_mercadologica)
	setNull(is_id_sem_gtin)
	setNull(is_farm_gov_bolsa_familia)
	setNull(is_id_marca_propria) 
	setNull(is_id_caract_variante) 	
	SetNull(is_id_cobre_preco_pbm)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_valida_dados (ref string as_log);String	ls_Situacao
String ls_Fornecedor
String ls_Achou
//String ls_Produto_SAP_Pesq

Try
	//Verifica se o fornecedor est$$HEX1$$e100$$ENDHEX$$ ativo
	If Not IsNull(is_cd_fornecedor_usual)  Then
		Select coalesce(id_situacao, 'A'), cd_fornecedor
		Into: ls_Situacao, :ls_Fornecedor
		From fornecedor
		Where (cd_fornecedor_sap = :is_cd_fornecedor_usual
			or cd_fornecedor_sap = Right('000000' + :is_cd_fornecedor_usual, 10))
		  and coalesce(id_situacao, 'A') = 'A'
		Using SqlCa;
		
		Choose Case  SqlCa.sqlcode
			Case 100
				as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o fornecedor '"+is_cd_fornecedor_usual+"' para verificar se est$$HEX1$$e100$$ENDHEX$$ ativo."
				Return False
			Case 0
				//Caso o produto esteja inativo (01/02/03/04), a situa$$HEX2$$e700e300$$ENDHEX$$o do fornecedor n$$HEX1$$e300$$ENDHEX$$o precisa ser validada 
				If ls_Situacao = "I" and is_id_situacao <> '01' and is_id_situacao <> '02' and is_id_situacao <> '03' and is_id_situacao <> '04' Then
					as_Log	= "O fornecedor '"+is_cd_fornecedor_usual+"' est$$HEX1$$e100$$ENDHEX$$ inativo."
				Return False
				End If
			Case -1
				as_Log	= "Erro ao verificar se o fornecedor est$$HEX1$$e100$$ENDHEX$$ ativo. Erro: "+SqlCa.sqlErrText
				Return False
		End Choose
		
		is_cd_fornecedor_usual = ls_Fornecedor
	End If
	
	//Verifica se foi informado a embalagem padr$$HEX1$$e300$$ENDHEX$$o
	// esta na fun$$HEX2$$e700e300$$ENDHEX$$o de ean
//	If IsNull(il_nr_embalagem_padrao) or (il_nr_embalagem_padrao = 0) Then
//		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado a quantidade da embalagem padr$$HEX1$$e300$$ENDHEX$$o."
//		Return False
//	End If
	
	If Not IsNull(is_cd_arvore_mercadologica) and Trim(is_cd_arvore_mercadologica) <> "" Then
		If Not of_verifica_arvore_mercadologica(is_cd_arvore_mercadologica) Then
			as_Log = "Arvore Mercadologica: " + is_cd_arvore_mercadologica + " N$$HEX1$$e300$$ENDHEX$$o cadastrada no sybase."
			Return False
		End If
	End If
	
	If IsNull(il_nr_classificacao_fiscal) Then il_nr_classificacao_fiscal = 0
	
	If IsNull(is_id_caderno_abcfarma) Then is_id_caderno_abcfarma = 'N'
	
	If IsNull(is_id_sugere_pedido_filial) Then is_id_sugere_pedido_filial = 'N'
	
	If IsNull(is_de_alteracao_situacao) Then is_de_alteracao_situacao = "      "
	
	If isnull(is_id_liberado_filial) Then is_id_liberado_filial = 'N'

	If isnull(is_id_lib_marketing_externo) Then is_id_lib_marketing_externo = 'N'
	
	If isnull(is_id_lib_marketing_interno) Then is_id_lib_marketing_interno = 'N'
	
	If IsNull (is_id_contem_corante) then is_id_contem_corante = 'N'
	
	If IsNull (is_id_testado_animais) then is_id_testado_animais = 'N'
	
	If IsNull (is_id_vegano) then is_id_vegano = 'N'
	
	If IsNull(is_cd_unidade_medida_compra) Then
		as_Log	= "Informe a unidade de compra. Verifique se o fornecedor esta marcado como regular."
		Return False
	End If
	
	If Not IsNull(is_cd_st_origem) and Trim(is_cd_st_origem) <> "" Then
		If Not of_verifica_origem_st() Then
			as_Log = "Origem ST: " + is_cd_st_origem + ". N$$HEX1$$e300$$ENDHEX$$o cadastrada no sybase."
			Return False
		End If
	End If
	
	If Not of_verifica_medicamento() Then
		as_Log	= "Problema ao Verificar se $$HEX1$$e900$$ENDHEX$$ Medicamento."
		Return False
	End If
	
	//Verifica se foi informado a Lei Gen$$HEX1$$e900$$ENDHEX$$rico corretamente
	If Not IsNull(is_id_lei_generico) and Trim(is_id_lei_generico) <> "" Then
		If is_id_lei_generico <> 'R' and is_id_lei_generico <> 'S' and is_id_lei_generico <> 'E' and is_id_lei_generico <> 'G' and is_id_lei_generico <> 'O' Then
			as_Log	= "Lei Gen$$HEX1$$e900$$ENDHEX$$rico diferente do esperado R/S/E/G/O. Enviado pelo SAP: " + is_id_lei_generico + " - " + iif(IsNull(is_de_lei_generico), '', is_de_lei_generico)
			Return False
		End If
	End If
	
	//Verifica se foi informado o Grupo Psico corretamente
	If Not IsNull(is_cd_grupo_psico) and Trim(is_cd_grupo_psico) <> "" Then
		If	(is_cd_grupo_psico <> 'A1') and (is_cd_grupo_psico <> 'A2') and (is_cd_grupo_psico <> 'A3') and (is_cd_grupo_psico <> 'B1') and (is_cd_grupo_psico <> 'B2') and (is_cd_grupo_psico <> 'C1')	 and &
			(is_cd_grupo_psico <> 'C2') and (is_cd_grupo_psico <> 'C3') and (is_cd_grupo_psico <> 'C4') and (is_cd_grupo_psico <> 'C5') and (is_cd_grupo_psico <> 'W') and (is_cd_grupo_psico <> 'W1') Then
			as_Log	= "Grupo Psico diferente do esperado A1/A2/A3/B1/B2/C1/C2/C3/C4/C5/W/W1. Enviado pelo SAP: " + is_cd_grupo_psico + " - " + iif(IsNull(is_de_grupo_psico), '', is_de_grupo_psico)
			Return False
		End If
	End If
	
	//Verifica se foi informado a Situa$$HEX2$$e700e300$$ENDHEX$$o do PIS COFINS corretamente
//	If Not IsNull(is_id_situacao_pis_cofins) and Trim(is_id_situacao_pis_cofins) <> "" Then
//		If (is_id_situacao_pis_cofins <> 'N') and (is_id_situacao_pis_cofins <> 'P') and (is_id_situacao_pis_cofins <> 'T') Then
//			as_Log	= "Situa$$HEX2$$e700e300$$ENDHEX$$o PIS COFINS diferente do esperado N/P/T. Enviado pelo SAP: " + is_id_situacao_pis_cofins + " - " + iif(IsNull(is_de_situacao_pis_cofins), '', is_de_situacao_pis_cofins)
//			Return False
//		End If
//	Else
//		as_Log	= "Situa$$HEX2$$e700e300$$ENDHEX$$o PIS COFINS diferente do esperado N/P/T."
//		Return False
//	End If
	
	If IsNull(is_id_situacao_pis_cofins) or ((is_id_situacao_pis_cofins <> 'N') and (is_id_situacao_pis_cofins <> 'P') and (is_id_situacao_pis_cofins <> 'T')) Then
		as_Log	= "Situa$$HEX2$$e700e300$$ENDHEX$$o PIS COFINS diferente do esperado N/P/T."
		Return False
	End If

//	If idc_qt_concentracao > 9999.9999 Then
//		as_Log	= "A concentra$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser superior a 9.999.999.999,99999."
//		Return False
//	End If
	
	//Verifica se foi informado o Tipo de Unidade de C$$HEX1$$e100$$ENDHEX$$lculo de Pre$$HEX1$$e700$$ENDHEX$$o corretamente
	If Not IsNull(is_id_tipo_un_calc_preco) and Trim(is_id_tipo_un_calc_preco) <> "" Then
		If (is_id_tipo_un_calc_preco <> 'Q') and (is_id_tipo_un_calc_preco <> 'V') and (is_id_tipo_un_calc_preco <> 'P')  and      (is_id_tipo_un_calc_preco <> 'M')     Then
			as_Log	= "O Tipo de Unidade de C$$HEX1$$e100$$ENDHEX$$lculo de Pre$$HEX1$$e700$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ diferente do esperado Q/V/P/M. Enviado pelo SAP: " + is_id_tipo_un_calc_preco + " - " + iif(IsNull(is_de_tipo_un_calc_preco), '', is_de_tipo_un_calc_preco)
			Return False
		End If
	End If
	
	//Verifica se foi informado o Tipo de Reposi$$HEX2$$e700e300$$ENDHEX$$o de Estoque corretamente
	If Not IsNull(is_id_tipo_reposicao_estoque) and Trim(is_id_tipo_reposicao_estoque) <> "" Then
		If (is_id_tipo_reposicao_estoque <> 'E') and (is_id_tipo_reposicao_estoque <> 'S') Then
			as_Log	= "Tipo de Reposi$$HEX2$$e700e300$$ENDHEX$$o de Estoque diferente do esperado E/S. Enviado pelo SAP: " + is_id_tipo_reposicao_estoque + " - " + iif(IsNull(is_de_tipo_un_calc_preco), '', is_de_tipo_un_calc_preco)
			Return False
		End If
	End If
	
	If is_Medicamento = 'S' and is_id_situacao = 'A' Then
		//Se de_registro_ms for nulo, vazio ou conter letras e se for medicamento (S), campo motivo da isen$$HEX2$$e700e300$$ENDHEX$$o passa a ser obrigat$$HEX1$$f300$$ENDHEX$$rio
		If  Not IsNumber(is_de_registro_ms) or IsNull(is_de_registro_ms) or Trim(is_de_registro_ms) = '' Then
			If IsNull(is_de_motivo_registro_ms_isento) or Trim(is_de_motivo_registro_ms_isento) = '' Then
				as_Log = "Para Medicamento Sem Registro MS o Motivo da Isen$$HEX2$$e700e300$$ENDHEX$$o Deve Ser Preenchido."
				Return False
			End If
		Else
			// Produto com registro MS n$$HEX1$$e300$$ENDHEX$$o pode ter motivo da isen$$HEX2$$e700e300$$ENDHEX$$o
			If Not IsNull(is_de_motivo_registro_ms_isento) and Trim(is_de_motivo_registro_ms_isento) <> '' Then
				as_Log = "Para Medicamento COM Registro MS o Motivo da Isen$$HEX2$$e700e300$$ENDHEX$$o N$$HEX1$$c300$$ENDHEX$$O DEVE Ser Preenchido."
				Return False
			End If
		End If
	End If
	
	If IsNull(il_cd_mix_produto) Then
		as_Log	= 'O CD_MIX_PRODUTO $$HEX1$$e900$$ENDHEX$$ um campo obrig$$HEX1$$e100$$ENDHEX$$t$$HEX1$$f300$$ENDHEX$$rio.'
		Return False
	End If
	
	If Not IsNull(is_cd_prod_referencia_preco)  and trim(is_cd_prod_referencia_preco) <> '' Then
		
		Select g.cd_produto
		Into :il_cd_prod_referencia_preco
		From produto_geral g
		Where cd_produto_sap = :is_cd_prod_referencia_preco
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
			Case 100
				as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o c$$HEX1$$f300$$ENDHEX$$digo do produto no legado com o c$$HEX1$$f300$$ENDHEX$$digo do SAP informado no campo 'Produto Ref. Pre$$HEX1$$e700$$ENDHEX$$o'."
				Return False
			Case -1
				as_Log	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo do legado atrav$$HEX1$$e900$$ENDHEX$$s do c$$HEX1$$f300$$ENDHEX$$digo SAP. Erro: "+SqlCa.sqlErrText
				Return False
		End Choose		
		
	End If
	
	If is_cd_unidade_medida_padrao = 'L' Then is_cd_unidade_medida_padrao = 'LT'
	If is_cd_unidade_medida_padrao = 'M' Then is_cd_unidade_medida_padrao = 'MT'
			
	If Not IsNull(is_cd_unidade_medida_padrao) Then
		SELECT m.cd_unidade_medida
		Into :ls_Achou
		FROM unidade_medida AS m
			INNER JOIN unidade_medida_utilizacao AS u
				ON u.cd_unidade_medida = m.cd_unidade_medida
		WHERE u.id_utilizacao = 'E'
			and m.cd_unidade_medida =:is_cd_unidade_medida_padrao
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
			Case 100
				as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizada a 'Uni. Medida Etiqueta' com o c$$HEX1$$f300$$ENDHEX$$digo informado no SAP '" + is_cd_unidade_medida_padrao + "'."
				Return False
			Case -1
				as_Log	= "Erro ao localizar ao localizar a unidade de medida padr$$HEX1$$e300$$ENDHEX$$o 'Uni. Medida Etiqueta'. Erro: "+SqlCa.sqlErrText
				Return False
		End Choose		
	End If
		
	If Not of_verifica_ncm(ref as_Log) Then Return False	
	
	If Not of_valida_minimo_pbm(ref as_Log) Then Return False
	
	if Not this.of_valida_categ_mercadologica( ref as_log ) Then return false
	
	If Not this.of_valida_area_atuacao (Ref as_log) then Return False
	
	If Not this.of_valida_atributo (Ref as_log) then Return False
	
	If Not this.of_valida_faixa_etaria (Ref as_log) then Return False
	
	If Not this.of_valida_posologia (Ref as_log) then Return False
	
	If Not this.of_valida_precaucoes (Ref as_log) then Return False
	
	If Not this.of_valida_publico_dest (Ref as_log) then Return False
	
	If Not this.of_valida_selo (Ref as_log) then Return False
	
	If Not this.of_valida_texto_min_saude (Ref as_log) then Return False
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try


Return True
end function

public function boolean of_cadastra_planograma (ref string as_log);String ls_de_planograma

If IsNull(il_cd_planograma) or il_cd_planograma = 0 Then Return True

Select de_planograma
Into :ls_de_planograma
From categoria_planograma
Where cd_planograma = :il_cd_planograma
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_planograma) or Trim(is_de_planograma) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do planograma n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
End if

Choose Case SqlCa.SqlCode
		
	Case 0
		
		If is_de_planograma <> ls_de_planograma Then
			
			Update categoria_planograma
			Set de_planograma = :is_de_planograma
			Where cd_planograma = :il_cd_planograma
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log = "Erro no insert da tabela 'categoria_planograma'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
			
		End if
		
	Case 100
		
		Insert Into categoria_planograma(cd_planograma, de_planograma)
		Values(:il_cd_planograma, :is_de_planograma)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'categoria_planograma'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		
		as_Log	= "Erro no select da tabela 'categoria_planograma'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_cadastra_alerta_restricao (ref string as_log);String ls_de_tipo_alerta

If IsNull(il_cd_tipo_alerta_restricao) or il_cd_tipo_alerta_restricao = 0 Then Return True

Select de_tipo_alerta
Into :ls_de_tipo_alerta
From tipo_alerta_restricao
Where cd_tipo_alerta = :il_cd_tipo_alerta_restricao
Using SqlCa;

If Sqlca.sqlcode <> -1 then	
	If IsNull(is_de_tipo_alerta_restricao) or Trim(is_de_tipo_alerta_restricao) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do tipo de alerta de restri$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
end if

Choose Case Sqlca.Sqlcode
	Case 0 //Encontrou o registro: Atualiza as informa$$HEX2$$e700f500$$ENDHEX$$es.
		
		If ls_de_tipo_alerta <> is_de_tipo_alerta_restricao Then
		
			Update tipo_alerta_restricao
			Set de_tipo_alerta = :is_de_tipo_alerta_restricao
			where cd_tipo_alerta = :il_cd_tipo_alerta_restricao
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'tipo_alerta_restricao'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
			
		End if
		
	Case 100 //N$$HEX1$$e300$$ENDHEX$$o encontrou o registro: Insere no banco.
		
		Insert Into tipo_alerta_restricao(cd_tipo_alerta, de_tipo_alerta)
		Values(:il_cd_tipo_alerta_restricao, :is_de_tipo_alerta_restricao)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'tipo_alerta_restricao'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1 //Erro
	
		as_Log	= "Erro no select da tabela 'tipo_alerta_restricao'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_cadastra_fabricante (ref string as_log);Long ll_Achou

If IsNull(il_cd_fabricante) or il_cd_fabricante = 0 Then Return True

Select count(*)
Into :ll_Achou
From fabricante
Where cd_fabricante = :il_cd_fabricante
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro no select da tabela 'fabricante'. Erro: "+SqlCa.sqlErrText
	Return False
End If

If ll_Achou = 0 Then
	
	If Not IsNull(is_nr_cnpj_fabricante) and Trim(is_nr_cnpj_fabricante) <> "" Then
		If Not gf_CGC_Valido(is_nr_cnpj_fabricante, False) Then
			as_Log	= "CNPJ do fabricante $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
			Return False
		End If
	Else
		as_Log	= "CNPJ do fabricante n$$HEX1$$e300$$ENDHEX$$o foi informado."
		Return False
	End If	

	If IsNull(is_nm_razao_social_fabricante) or Trim(is_nm_razao_social_fabricante) = '' Then
		as_Log	= "A raz$$HEX1$$e300$$ENDHEX$$o social do fabricante n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
		
	Insert Into fabricante(cd_fabricante, nm_razao_social, nr_cgc)
	Values(:il_cd_fabricante, :is_nm_razao_social_fabricante, :is_nr_cnpj_fabricante)
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro no insert da tabela 'fabricante'. Erro: "+SqlCa.sqlErrText
		Return False
	End If
Else
	UPDATE fabricante  
		SET nm_razao_social = :is_nm_razao_social_fabricante, nr_cgc = :is_nr_cnpj_fabricante
	Where cd_fabricante = :il_cd_fabricante
	    and (nm_razao_social <> :is_nm_razao_social_fabricante or nr_cgc <> :is_nr_cnpj_fabricante)
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro no update da tabela 'fabricante'. Erro: "+SqlCa.sqlErrText
		Return False
	End If	
		
	If Sqlca.SQLNRows > 0 Then
		ll_Achou = 100
	End If
End If

Return True
end function

public function boolean of_cadastra_tipo_apresentacao (ref string as_log);String ls_id_apresentacao

If IsNull(is_id_apresentacao) or Trim(is_id_apresentacao) = '' Then Return True

Select de_apresentacao
Into :ls_id_apresentacao
From tipo_apresentacao_produto
Where id_apresentacao = :is_id_apresentacao
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_tipo_apresentacao) or Trim(is_de_tipo_apresentacao) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do tipo de apresenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
End If

Choose Case Sqlca.Sqlcode
		
	Case 0
	
		If is_de_tipo_apresentacao <> ls_id_apresentacao Then
			
			Update tipo_apresentacao_produto
			Set de_apresentacao = :is_de_tipo_apresentacao
			Where id_apresentacao = :is_id_apresentacao
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'tipo_apresentacao_produto'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
			
		End if
	
	Case 100
		
		Insert Into tipo_apresentacao_produto(id_apresentacao, de_apresentacao)
		Values(:is_id_apresentacao, :is_de_tipo_apresentacao)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'tipo_apresentacao_produto'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		
		as_Log	= "Erro no select da tabela 'tipo_apresentacao_produto'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_cadastra_dcb (ref string as_log);Decimal ldc_qt_dosagem_max, &
			ldc_qt_dosagem_min
			
String ls_de_dcb, &
			ls_nr_cas

If IsNull(is_cd_dcb) or Trim(is_cd_dcb) = '' Then Return True

Select de_dcb, qt_dosagem_minima, qt_dosagem_maxima, nr_cas
Into :ls_de_dcb, :ldc_qt_dosagem_min, :ldc_qt_dosagem_max, :ls_nr_cas
From dcb_produto
Where cd_dcb = :is_cd_dcb
Using SqlCa;

If SqlCa.SqlCode <> -1 then
	If IsNull(is_de_dcb) or Trim(is_de_dcb) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do DCB n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
end if

Choose Case SqlCa.SqlCode
	Case 0
		
		//Somente faz o update se realmente houveram altera$$HEX2$$e700f500$$ENDHEX$$es.
		If ( is_de_dcb <> ls_de_dcb ) or &
			( idc_qt_dosagem_minima_dcb <> ldc_qt_dosagem_min ) or &
			( idc_qt_dosagem_maxima_dcb <> ldc_qt_dosagem_max ) or &
			( is_nr_cas_dcb <> ls_nr_cas ) Then
			
			Update dcb_produto
			Set de_dcb = :is_de_dcb , 
				qt_dosagem_minima = :idc_qt_dosagem_minima_dcb ,  
				qt_dosagem_maxima = :idc_qt_dosagem_maxima_dcb , 
				nr_cas = :is_nr_cas_dcb 
			Where cd_dcb = :is_cd_dcb
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'dcb_produto'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
			
		End if
		
	Case 100
		
		Insert Into dcb_produto(cd_dcb, de_dcb, qt_dosagem_minima, qt_dosagem_maxima, nr_cas)
		Values(:is_cd_dcb, :is_de_dcb, :idc_qt_dosagem_minima_dcb,  :idc_qt_dosagem_maxima_dcb, :is_nr_cas_dcb )
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'dcb_produto'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
	
	Case -1
		
		as_Log	= "Erro no select da tabela 'dcb_produto'. Erro: "+SqlCa.sqlErrText
		Return False	
		
End Choose

Return True
end function

public function boolean of_cadastra_lei_generico (ref string as_log);Long ll_Achou
//
//If IsNull(is_id_lei_generico) or Trim(is_id_lei_generico) = "" Then Return True
//
//Select count(*)
//Into :ll_Achou
//From lei_generico
//Where id_lei_generico = :is_id_lei_generico
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	as_Log	= "Erro no select da tabela 'lei_generico'. Erro: "+SqlCa.sqlErrText
//	Return False
//End If
//
//If ll_Achou = 0 Then
//	
//	If IsNull(is_de_planograma) or Trim(is_de_planograma) = '' Then
//		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do planograma n$$HEX1$$e300$$ENDHEX$$o foi informada."
//		Return False
//	End If
//	
//	Insert Into categoria_planograma(cd_planograma, de_planograma)
//	Values(:il_cd_planograma, :is_de_planograma)
//	Using SqlCa;
//	
//	If SqlCa.sqlcode = -1 Then
//		as_Log	= "Erro no insert da tabela 'categoria_planograma'. Erro: "+SqlCa.sqlErrText
//		Return False
//	End If
//End If

Return True
end function

public function boolean of_cadastra_linha_produto (ref string as_log);String ls_Linha

If IsNull(is_cd_linha_produto) or Trim(is_cd_linha_produto) = '' Then Return True

Select de_linha_produto
Into :ls_Linha
From linha_produto
Where cd_linha_produto = :is_cd_linha_produto
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_linha_produto) or Trim(is_de_linha_produto) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o da Linha do Produto n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
End If

Choose Case SqlCa.SqlCode
	Case 0
		
		If ls_Linha <> is_de_linha_produto Then
			UPDATE linha_produto  
				SET de_linha_produto = :is_de_linha_produto
			Where cd_linha_produto = :is_cd_linha_produto
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro no update da tabela 'linha_produto'. Erro: "+SqlCa.sqlErrText
				Return False
			End If	
		End If
		
	Case 100
		
		Insert Into linha_produto(cd_linha_produto, de_linha_produto, cd_empresa, id_carregado_as400)
		Values(:is_cd_linha_produto, :is_de_linha_produto, 1,  'N')
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'linha_produto'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
	
	Case -1
		as_Log	= "Erro no select da tabela 'linha_produto'. Erro: "+SqlCa.sqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_cadastra_marca_ecommerce (ref string as_log);String ls_de_marca

If IsNull(il_cd_marca_ecommerce) or il_cd_marca_ecommerce = 0 Then Return True

Select de_marca
Into :ls_de_marca
From marca_ecommerce
Where cd_marca = :il_cd_marca_ecommerce
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_marca_ecommerce) or Trim(is_de_marca_ecommerce) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o da Marca Ecommerce n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
end if

Choose Case SqlCa.SqlCode
	Case 0
		
		If is_de_marca_ecommerce <> ls_de_marca Then
		
			Update marca_ecommerce
			Set de_marca = :is_de_marca_ecommerce
			Where cd_marca = :il_cd_marca_ecommerce
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'marca_ecommerce'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
			
		End if
		
	Case 100
		
		Insert Into marca_ecommerce(cd_marca, de_marca)
		Values(:il_cd_marca_ecommerce, :is_de_marca_ecommerce)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'marca_ecommerce'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		as_Log	= "Erro no select da tabela 'marca_ecommerce'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_cadastra_cest (ref string as_log);Long ll_Achou

//If IsNull(is_cd_cest) or Trim(is_cd_cest) = '' Then Return True
//
//Select count(*)
//Into :ll_Achou
//From cest
//Where cd_cest = :is_cd_cest
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	as_Log	= "Erro no select da tabela 'cest'. Erro: "+SqlCa.sqlErrText
//	Return False
//End If
//
//If ll_Achou = 0 Then
//	
//	If IsNull(is_de_cest) or Trim(is_de_cest) = '' Then
//		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do CEST n$$HEX1$$e300$$ENDHEX$$o foi informada."
//		Return False
//	End If
//	
//	Insert Into cest(cd_cest, de_cest)
//	Values(:is_cd_cest, :is_de_cest)
//	Using SqlCa;
//	
//	If SqlCa.sqlcode = -1 Then
//		as_Log	= "Erro no insert da tabela 'cest'. Erro: "+SqlCa.sqlErrText
//		Return False
//	End If
//End If

Return True
end function

public function boolean of_cadastra_tipo_prescricao (ref string as_log);String ls_de_tipo_prescricao


If IsNull(il_cd_tipo_prescricao) Then Return True

Select de_tipo_prescricao
Into :ls_de_tipo_prescricao
From tipo_prescricao
Where cd_tipo_prescricao = :il_cd_tipo_prescricao
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_tipo_prescricao) or Trim(is_de_tipo_prescricao) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do tipo_prescricao n$$HEX1$$e300$$ENDHEX$$o foi informada ou foi informada de forma errada no SAP, favor verificar."
		Return False
	End If
End If
	
Choose Case SqlCa.SqlCode
		
	Case 0
		
		If is_de_tipo_prescricao <> ls_de_tipo_prescricao Then
		
			Update tipo_prescricao
			Set de_tipo_prescricao = :is_de_tipo_prescricao
			Where cd_tipo_prescricao = :il_cd_tipo_prescricao
			Using SqlCa;
		
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'tipo_prescricao'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
		
		End if
		
	Case 100
		
		Insert Into tipo_prescricao(cd_tipo_prescricao, de_tipo_prescricao)
		Values(:il_cd_tipo_prescricao, :is_de_tipo_prescricao)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'tipo_prescricao'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		
		as_Log = "Erro no select da tabela 'tipo_prescricao'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_cadastra_mix_produto (ref string as_log);String ls_de_mix

If IsNull(il_cd_mix_produto) or il_cd_mix_produto = 0 Then Return True

Select de_mix_produto
Into :ls_de_mix
From mix_produto
Where cd_mix_produto = :il_cd_mix_produto
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_mix_produto) or Trim(is_de_mix_produto) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do mix_produto n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
End if

Choose Case SqlCa.SqlCode
		
	Case 0

		If is_de_mix_produto <> ls_de_mix Then
			
			Update mix_produto
			set de_mix_produto = :is_de_mix_produto
			Where cd_mix_produto = :il_cd_mix_produto
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'mix_produto'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
			
		End if
		
	Case 100
		
		Insert Into mix_produto(cd_mix_produto, de_mix_produto)
		Values(:il_cd_mix_produto, :is_de_mix_produto)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'mix_produto'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		
		as_Log	= "Erro no select da tabela 'mix_produto'. Erro: "+SqlCa.sqlErrText
		Return False
	
End Choose

Return True
end function

public function boolean of_cadastra_grupo_alteracao_preco (ref string as_log);String ls_Desc_Atual

If IsNull(il_cd_grupo_alteracao_preco) or il_cd_grupo_alteracao_preco = 0 Then Return True

Select de_grupo
Into :ls_Desc_Atual
From grupo_alteracao_preco
Where cd_grupo = :il_cd_grupo_alteracao_preco
Using SqlCa;

If SqlCa.Sqlcode <> -1 Then
	If IsNull(is_de_grupo_alteracao_preco) or Trim(is_de_grupo_alteracao_preco) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do grupo_alteracao_preco n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
End If

Choose Case SqlCa.SqlCode
	Case 0
		
		If ls_Desc_Atual <> is_de_grupo_alteracao_preco Then
		  UPDATE grupo_alteracao_preco  
		  SET de_grupo = :is_de_grupo_alteracao_preco
		  Where cd_grupo = :il_cd_grupo_alteracao_preco
		  Using SqlCa;
		  
		  If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no update da tabela 'grupo_alteracao_preco'. Erro: "+SqlCa.sqlErrText
			Return False
		  End If
		End If
		
	Case 100
			
		Insert Into grupo_alteracao_preco(cd_grupo, de_grupo)
		Values(:il_cd_grupo_alteracao_preco, :is_de_grupo_alteracao_preco)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'grupo_alteracao_preco'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		as_Log	= "Erro no select da tabela 'grupo_alteracao_preco'. Erro: "+SqlCa.sqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_cadastra_tipo_produto_pricing (ref string as_log);String ls_de_tipo_produto

If IsNull(il_cd_tipo_produto_pricing) or il_cd_tipo_produto_pricing = 0 Then Return True

Select de_tipo_produto
Into :ls_de_tipo_produto
From tipo_produto_pricing
Where cd_tipo_produto = :il_cd_tipo_produto_pricing
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_tipo_produto_pricing) or Trim(is_de_tipo_produto_pricing) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do tipo_produto_pricing n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
End If
	
Choose Case Sqlca.Sqlcode
		
	Case 0
		
		If is_de_tipo_produto_pricing <> ls_de_tipo_produto Then
			
			Update tipo_produto_pricing
			Set de_tipo_produto = :is_de_tipo_produto_pricing
			Where cd_tipo_produto = :il_cd_tipo_produto_pricing
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log = "Erro ao atualizar registro da tabela 'tipo_produto_pricing'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
			
		End if
		
	Case 100
		
		Insert Into tipo_produto_pricing(cd_tipo_produto, de_tipo_produto)
		Values(:il_cd_tipo_produto_pricing, :is_de_tipo_produto_pricing)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro no insert da tabela 'tipo_produto_pricing'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		
		as_Log = "Erro no select da tabela 'tipo_produto_pricing'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_cadastra_segmento_ims (ref string as_log);String ls_de_segmento

If IsNull(is_cd_segmento_ims) or Trim(is_cd_segmento_ims) = '' Then Return True

Select de_segmento
Into :ls_de_segmento
From segmento_ims
Where cd_segmento = :is_cd_segmento_ims
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	// Caso n$$HEX1$$e300$$ENDHEX$$o exista
	If (IsNull(is_de_segmento_ims) or Trim(is_de_segmento_ims) = '') and SqlCa.SqlCode = 100 Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do segmento_ims n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
End if

Choose Case SqlCa.SqlCode
		
	Case 0
		
		If (is_de_segmento_ims <> ls_de_segmento) and  is_de_segmento_ims <> '' Then
			
			Update segmento_ims
			Set de_segmento = :is_de_segmento_ims
			Where cd_segmento = :is_cd_segmento_ims
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'segmento_ims'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
			
		End if
		
	Case 100
		
		Insert Into segmento_ims(cd_segmento, de_segmento)
		Values(:is_cd_segmento_ims, :is_de_segmento_ims)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'segmento_ims'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		
		as_Log	= "Erro no select da tabela 'segmento_ims'. Erro: "+SqlCa.sqlErrText
		Return False
	
End Choose

Return True
end function

public function boolean of_cadastra_marca_produto (ref string as_log);String ls_de_marca
String ls_marca_propria

If IsNull(il_cd_marca) or il_cd_marca = 0 Then Return True

Select de_marca ,  coalesce(id_marca_propria,'N')   
Into :ls_de_marca, :ls_marca_propria
From marca_produto
Where cd_marca = :il_cd_marca
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_marca) or Trim(is_de_marca) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o do marca_produto n$$HEX1$$e300$$ENDHEX$$o foi informada."
		Return False
	End If
End if

Choose Case Sqlca.Sqlcode
		
	Case 0
		
		If ( is_de_marca <> ls_de_marca    OR  ls_marca_propria<> is_id_marca_propria )      Then
		 
			Update marca_produto
			Set de_marca = :is_de_marca,
				id_marca_propria=:is_id_marca_propria
			Where cd_marca = :il_cd_marca
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'marca_produto'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
			
		End if
		
	Case 100
		
		Insert Into marca_produto(cd_marca, de_marca, id_marca_propria  )
		Values(:il_cd_marca, :is_de_marca,  :is_id_marca_propria   )
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'marca_produto'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		as_Log = "Erro ao consultar registro da tabela 'marca_produto'. Erro: "+SqlCa.sqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_carrega_codigo_barra (long al_controle_pai, ref string as_log);Boolean lb_Sucesso = True

Long ll_Achou
Long ll_Linhas
Long ll_Linha
Long ll_Controle
Long ll_Item
Long ll_Item_Ant
Long ll_Contador
Long ll_Insert

String ls_Coluna
String ls_Vl_Item
String ls_Obrig

Decimal ldc_Altura
Decimal ldc_Largura
Decimal ldc_Profund
Decimal ldc_Peso
Decimal ldc_Qtde_Unid_Medida

Boolean lb_Entrou_Cod_Barras = False, &
			lb_Entrou_Id_Principal = False

try
	
	SELECT count(*)
	Into :ll_Achou
	FROM interface_sap  i 
	Where i.cd_tabela = 3
		and i.cd_tabela_pai = 1
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao verificar a exist$$HEX1$$ea00$$ENDHEX$$ncia de mais de um registro para a tabela pai na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If ll_Achou > 1 Then
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o pode haver mais um registro filho de codigo de barras para uma mesma tabela pai de produto. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+"."
		Return False
	End If
	
	If ll_Achou = 0 Then
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro filho de codigo de barras para a tabela pai de produto. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+"."
		Return False
	End If
	
	ll_Linhas = ids_ean.Retrieve(al_controle_pai)
	
	ids_ean_cad.Reset()
	
	If ll_Linhas > 0 Then
		
		For ll_Linha = 1 To ll_Linhas
			ll_Controle 	= ids_ean.Object.nr_controle		[ll_Linha]
			ls_Coluna 	= Upper(ids_ean.Object.cd_coluna[ll_Linha])
			ls_Vl_Item	= Upper(ids_ean.Object.vl_item	[ll_Linha])
			ls_Obrig		= ids_ean.Object.id_obrigatorio	[ll_Linha]
			ll_Item		= ids_ean.Object.nr_item	[ll_Linha]
			
			If ll_Item <> ll_Item_Ant  Then
				If Not lb_Entrou_Cod_Barras And ll_Linha > 1 Then
					ids_ean_cad.Object.de_ean[ll_Insert] = ''
				End If
				If Not lb_Entrou_Id_Principal And ll_Linha > 1 Then
					ids_ean_cad.Object.id_principal			[ll_Insert] = 'N'
					ids_ean_cad.Object.id_principal_original	[ll_Insert] = 'N'
					ids_ean_cad.Object.id_principal_sap		[ll_Insert] = 'N'
				End If
				
				ll_Insert 		= ids_ean_cad.InsertRow(0)
				ll_Item_Ant 	= ll_Item
				ids_ean_cad.Object.nr_item[ll_Insert] = ll_Insert
				
				lb_Entrou_Cod_Barras = False
				lb_Entrou_Id_Principal = False
			End If
			
			If ll_Linha = 1 Then 
				If Not io_Comum.of_Muda_Situacao_Interface(ll_Controle, Ref as_Log) Then Return False
			End If
			
			//If Trim(ls_Vl_Item) = "" Then SetNull(ls_Vl_Item)
										
			If Not io_Comum.of_verifica_obrigatoriedade_campo(ls_Coluna, ls_Obrig, ls_Vl_Item, Ref as_Log) Then Return False
			
			Choose Case ls_Coluna
				Case 'DE_CODIGO_BARRAS'
					
					If Trim(ls_VL_Item) <> '' Then
						
						//Se tiver 12 caracteres acrescenta um zero a esquerda.
						if len(trim(ls_vl_item)) = 12 then ls_vl_item = '0' + ls_vl_item
						
						//If Not gf_Valida_EAN(ls_VL_Item, False, Ref as_Log) Then Return False
						ids_ean_cad.Object.de_ean[ll_Insert] = ls_VL_Item
					Else
						ids_ean_cad.Object.de_ean[ll_Insert] = ''
					End If
					lb_Entrou_Cod_Barras = True
					
				Case 'ID_PRINCIPAL'
					ls_Vl_Item = iif(IsNull(ls_Vl_Item), 'N', ls_Vl_Item)	
					ls_Vl_Item = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
					If Trim(ls_Vl_Item) <> '' and ls_Vl_Item <> 'S' and ls_Vl_Item <> 'N' Then
						as_Log	= "Indica$$HEX2$$e700e300$$ENDHEX$$o de c$$HEX1$$f300$$ENDHEX$$digo principal esta diferente do esperado S/N."
						Return False
					End If
					
					If ls_VL_Item <> 'S' Then
						ls_VL_Item = 'N'
					End If
					
					ids_ean_cad.Object.id_principal			[ll_Insert] = ls_VL_Item
					ids_ean_cad.Object.id_principal_original	[ll_Insert] = ls_VL_Item
					ids_ean_cad.Object.id_principal_sap		[ll_Insert] = ls_VL_Item
					lb_Entrou_Id_Principal = True
															
				Case 'CD_UNIDADE_ALTERNATIVA'
					ids_ean_cad.Object.cd_unidade_alternativa[ll_Insert] = ls_VL_Item
					
				Case 'CD_UNIDADE_MEDIDA_INFERIOR'
					ids_ean_cad.Object.cd_unidade_medida_inferior[ll_Insert] = ls_VL_Item
				
				Case 'CD_UNIDADE_PESO'
					ids_ean_cad.Object.cd_unidade_peso[ll_Insert] = ls_VL_Item
				
				Case 'QT_ALTURA_CM'
					If Not io_Comum.of_decimal(ls_Vl_Item, 'ALTURA', ref ldc_Altura, ref as_log) Then Return False
					ids_ean_cad.Object.qt_altura_cm[ll_Insert] = ldc_Altura
				
				Case 'QT_LARGURA_CM'
					If Not io_Comum.of_decimal(ls_Vl_Item, 'LARGURA', ref ldc_Largura, ref as_log) Then Return False
					ids_ean_cad.Object.qt_largura_cm[ll_Insert] = ldc_Largura
					
				Case 'QT_PROFUNDIDADE_CM'
					If Not io_Comum.of_decimal(ls_Vl_Item, 'PROFUNCIDADE', ref ldc_Profund, ref as_log) Then Return False
					ids_ean_cad.Object.qt_profundidade_cm[ll_Insert] = ldc_Profund
				
				Case 'QT_PESO_BRUTO'	
					If Not io_Comum.of_decimal(ls_Vl_Item, 'PESO BRUTO', ref ldc_Peso, ref as_log) Then Return False
					ids_ean_cad.Object.qt_peso_bruto[ll_Insert] = ldc_Peso
					
				Case 'QT_PESO_LIQUIDO'
//				If Not This.of_decimal(ls_Vl_Item, 'PESO LIQUIDO', ref idc_qt_dosagem_maxima_dcb, ref as_log) Then Return False
//				ids_ean_cad.Object.qt_peso_liquido[ll_Insert] = ls_VL_Item

				Case 'QT_UNIDADE_MEDIDA_SUBORDINADA'
					If Not io_Comum.of_decimal(ls_Vl_Item, 'QTDE UNIDADE MEDIDA', ref ldc_Qtde_Unid_Medida, ref as_log) Then Return False
					ids_ean_cad.Object.qt_unidade_medida_subordinada[ll_Insert] = ldc_Qtde_Unid_Medida
					
				Case Else
					as_Log	= "Coluna '" + ls_Coluna + "' n$$HEX1$$e300$$ENDHEX$$o prevista na interface de produto."
					Return False
			End Choose
			
			If ll_Linha = ll_Linhas Then
				If Not lb_Entrou_Cod_Barras And ll_Linha > 1 Then
					ids_ean_cad.Object.de_ean[ll_Insert] = ''
				End If
				If Not lb_Entrou_Id_Principal And ll_Linha > 1 Then
					ids_ean_cad.Object.id_principal			[ll_Insert] = 'N'
					ids_ean_cad.Object.id_principal_original	[ll_Insert] = 'N'
					ids_ean_cad.Object.id_principal_sap		[ll_Insert] = 'N'
				End If
			End If
			
		Next
		
		If ids_ean_cad.RowCount() > 0 Then
			ids_ean_cad.SaveAs("d:\ean_sap.xlsx", XLSX!, True)
		End If
		
		lb_Sucesso = True
		
	ElseIf ll_Linhas = 0 Then
		// Retornar com caso seja exigido o c$$HEX1$$f300$$ENDHEX$$digo de barras para o produto
	ElseIf ll_Linhas < 0 Then
		as_Log	= "Erro ao recuperar os c$$HEX1$$f300$$ENDHEX$$digos de barras. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+"."
		Return False
	End If
	
finally
	If Not lb_Sucesso Then
		SqlCa.of_RollBack();
	End If
end try

Return True
end function

public function boolean of_produto_novo (ref long al_produto, ref boolean ab_produto_novo, ref string as_log);Long ll_Produto
Long ll_Linha 
Long ll_Linhas

String ls_EAN
String ls_Produto_SAP

Try
	
	Select cd_produto, cd_subcategoria
	Into	:ll_Produto, :is_SubCategoria
	From produto_geral
	Where cd_produto_sap = :is_cd_produto_sap
	Using SqlCa;
	
//	If gvo_Aplicacao.ivs_DataSource = 'central' Then
//		Select cd_produto, cd_subcategoria
//		Into	:ll_Produto, :is_SubCategoria
//		From produto_geral
//		Where cd_produto_sap = :is_cd_produto_sap
//		Using SqlCa;
//	Else
//				
//		If Isnull(il_cd_produto_legado) or  il_cd_produto_legado = 0 Then
//			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "HOMOLOGA~r" +&
//								"N$$HEX1$$e300$$ENDHEX$$o foi informado o c$$HEX1$$f300$$ENDHEX$$digo do material no  legado (Sybase), neste caso ser$$HEX1$$e100$$ENDHEX$$ cadastrado um novo material no LEGADO.~r" +&
//								"Deseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
//				as_Log	= "N$$HEX1$$e300$$ENDHEX$$o veio da interface o c$$HEX1$$f300$$ENDHEX$$digo do material no legado para verificar o produto $$HEX1$$e900$$ENDHEX$$ novo no Sybase."
//				Return False
//			End If
//		End If
//		
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente informativo: Na base de homologa$$HEX2$$e700e300$$ENDHEX$$o do Sybase a identifica$$HEX2$$e700e300$$ENDHEX$$o se o produto $$HEX1$$e900$$ENDHEX$$ novo $$HEX1$$e900$$ENDHEX$$ pelo c$$HEX1$$f300$$ENDHEX$$digo do material no legado.", Exclamation!)
//		
//		Select cd_produto, cd_subcategoria
//		Into	:ll_Produto, :is_SubCategoria
//		From produto_geral
//		Where cd_produto = :il_cd_produto_legado
//		Using SqlCa;	
//		
//		
//	End If
	
	Choose Case SqlCa.sqlcode
		Case 0
			ab_Produto_Novo	= False
			
			//If gvo_Aplicacao.ivs_DataSource = 'central' Then
				If IsNull(il_cd_produto_legado) or il_cd_produto_legado = 0 Then
					
					// N$$HEX1$$e300$$ENDHEX$$o faz a valida$$HEX2$$e700e300$$ENDHEX$$o para o homologa
					//If (gvo_Aplicacao.ivs_DataSource = 'central') Then
						as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o c$$HEX1$$f300$$ENDHEX$$digo do legado no SAP."
						Return False
					//End If
				Else
					// Se o c$$HEX1$$f300$$ENDHEX$$digo do legado do SAP for diferente do localizado no Sybase atrav$$HEX1$$e900$$ENDHEX$$s do c$$HEX1$$f300$$ENDHEX$$digo SAP
					If il_cd_produto_legado <> ll_Produto Then
						as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do legado informado no SAP '" + String(il_cd_produto_legado) + "' esta diferente do legado(Sybase) '"+ String(ll_Produto)  + "'."
						Return False
					End If
				End If
			//End If	
			
			//Garante que o EAN do produto reativado realmente $$HEX1$$e900$$ENDHEX$$ igual, caso contr$$HEX1$$e100$$ENDHEX$$rio pode haver problema 								
			////////////
			ll_Linhas = ids_ean_cad.RowCount()
			
			If ll_Linhas > 0 Then
				
				// Verifica se existe algum produto cadastrado no legado com o c$$HEX1$$f300$$ENDHEX$$digo de EAN recebido do SAP
				For ll_Linha = 1 To ll_Linhas
					ls_EAN = ids_ean_cad.Object.de_ean[ll_Linha]
					
					If IsNull(ls_EAN) or Trim(ls_EAN) = '' Then Continue
					
					Select cd_produto
					Into :ll_Produto
					From codigo_barras_produto
					Where de_codigo_barras = :ls_EAN
					Using SqlCa;
					
					If SqlCa.SqlCode = 0 Then
						If il_cd_produto_legado <> ll_Produto Then
							//as_Log	= "O produto localizado pelo EAN '" + ls_EAN + "' [" + STring(ll_Produto)  + "] esta diferente do informado no material no SAP"
							as_Log	=  "Foi localizado o produto [" + String(ll_Produto) + "] para o EAN '" + ls_EAN + "'"
							Return False
						End If	
					ElseIf SqlCa.SqlCode = -1 Then
						as_Log	= "Erro ao verificar se o produto $$HEX1$$e900$$ENDHEX$$ cadastro novo pelo EAN. Erro: "+SqlCa.sqlErrText
						Return False
					End If
				Next
			ElseIf ll_Linhas < 0 Then
				as_Log	= "Erro ao listar o EAN para verificar se o produto j$$HEX1$$e100$$ENDHEX$$ esta cadastrado."
				Return False
			ElseIf ll_Linhas = 0 Then
				as_Log	= "Nenhum EAN foi cadastrado SAP para garantir que o produto j$$HEX1$$e100$$ENDHEX$$ existe no SAP."
				Return False
			End If
			/////////////				
			
		Case 100
			ab_Produto_Novo	= True
			
			//If gvo_Aplicacao.ivs_DataSource = 'central' Then
				
				If Not IsNull(il_cd_produto_legado) and il_cd_produto_legado > 0 Then
					
					// Faz uma procura pelo c$$HEX1$$f300$$ENDHEX$$digo interno atraves do codigo do legado informado no SAP
					Select cd_produto, cd_produto_sap
					Into	:ll_Produto, :ls_Produto_SAP
					From produto_geral
					Where cd_produto = :il_cd_produto_legado
					Using SqlCa;
					
					Choose Case SqlCa.SqlCode
						Case 0
							// V$$HEX1$$e100$$ENDHEX$$rios material que estavam como INATIVOS sem saldo n$$HEX1$$e300$$ENDHEX$$o subiram para o SAP, por$$HEX1$$e900$$ENDHEX$$m existe a necessidade de reaproveit$$HEX1$$e100$$ENDHEX$$-los, 
							// desta forma o mesmo $$HEX1$$e900$$ENDHEX$$ cadatrado no SAP referenciando o c$$HEX1$$f300$$ENDHEX$$digo do legado.
							
							// Se o produto do legado j$$HEX1$$e100$$ENDHEX$$ possuir um c$$HEX1$$f300$$ENDHEX$$digo SAP n$$HEX1$$e300$$ENDHEX$$o deixa fazer novamente
							If Not IsNull(ls_Produto_SAP) Then
								as_Log	= "Foi encontrado um material com o c$$HEX1$$f300$$ENDHEX$$digo do legado informado no SAP."
								Return False
							Else
								ab_Produto_Novo	= False
								
								Select cd_subcategoria
								Into	:is_SubCategoria
								From produto_geral
								Where cd_produto = :il_cd_produto_legado
								Using SqlCa;
								
								If SqlCa.SqlCode = - 1 Then
									as_Log	= "Erro ao localizar o produto com o c$$HEX1$$f300$$ENDHEX$$digo do legado informado no SAP. Erro: "+SqlCa.sqlErrText
									Return False
								End If
								
								//Garante que o EAN do produto reativado realmente $$HEX1$$e900$$ENDHEX$$ igual, caso contr$$HEX1$$e100$$ENDHEX$$rio pode haver problema 								
								////////////
								ll_Linhas = ids_ean_cad.RowCount()
								
								If ll_Linhas > 0 Then
									
									// Verifica se existe algum produto cadastrado no legado com o c$$HEX1$$f300$$ENDHEX$$digo de EAN recebido do SAP
									For ll_Linha = 1 To ll_Linhas
										ls_EAN = ids_ean_cad.Object.de_ean[ll_Linha]
										
										If IsNull(ls_EAN) or Trim(ls_EAN) = '' Then Continue
										
										Select cd_produto
										Into :ll_Produto
										From codigo_barras_produto
										Where de_codigo_barras = :ls_EAN
										Using SqlCa;
										
										If SqlCa.SqlCode = 0 Then
											If il_cd_produto_legado <> ll_Produto Then
												as_Log	= "O produto legado localizado pelo EAN esta diferente do informado no material no SAP."
												Return False
											End If	
										ElseIf SqlCa.SqlCode = -1 Then
											as_Log	= "Erro ao verificar se o produto $$HEX1$$e900$$ENDHEX$$ cadastro novo pelo EAN. Erro: "+SqlCa.sqlErrText
											Return False
										End If
									Next
								ElseIf ll_Linhas < 0 Then
									as_Log	= "Erro ao listar o EAN para verificar se o produto j$$HEX1$$e100$$ENDHEX$$ esta cadastrado."
									Return False
								ElseIf ll_Linhas = 0 Then
									as_Log	= "Nenhum EAN foi cadastrado SAP para garantir que o produto j$$HEX1$$e100$$ENDHEX$$ existe no SAP."
									Return False
								End If
								/////////////			
								
								al_produto = ll_Produto
								Return True
							End If
							
						Case 100
						Case -1
							as_Log	= "Erro ao localizar o produto com o c$$HEX1$$f300$$ENDHEX$$digo do legado informado no SAP. Erro: "+SqlCa.sqlErrText
							Return False
					End Choose
					
				End If // If Not IsNull(il_cd_produto_legado) and il_cd_produto_legado > 0 Then
							
			//End If //If gvo_Aplicacao.ivs_DataSource = 'central' Then
			
			ll_Linhas = ids_ean_cad.RowCount()
			
			If ll_Linhas > 0 Then
				// Verifica se existe algum produto cadastrado no legado com o c$$HEX1$$f300$$ENDHEX$$digo de EAN recebido do SAP
				For ll_Linha = 1 To ll_Linhas
					ls_EAN = ids_ean_cad.Object.de_ean[ll_Linha]
					
					Select cd_produto
					Into :ll_Produto
					From codigo_barras_produto
					Where de_codigo_barras = :ls_EAN
					Using SqlCa;
					
					If SqlCa.SqlCode = 0 Then
						//ab_Produto_Novo	= False
						//Exit
						as_Log	= "Foi encontrado o produto '" + String(ll_Produto) + "' para o EAN cadastrado no SAP '" + ls_EAN + "'."
						Return False
					ElseIf SqlCa.SqlCode = -1 Then
						as_Log	= "Erro ao verificar se o produto $$HEX1$$e900$$ENDHEX$$ cadastro novo pelo EAN. Erro: "+SqlCa.sqlErrText
						Return False
					End If
				Next
			ElseIf ll_Linhas < 0 Then
				as_Log	= "Erro ao listar o EAN para verificar se o produto j$$HEX1$$e100$$ENDHEX$$ esta cadastrado."
				Return False
			End If
					
		Case -1
			as_Log	= "Erro ao verificar se o produto $$HEX1$$e900$$ENDHEX$$ cadastro novo. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	// Localiza o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo de produto
	If ab_Produto_Novo Then
		Select coalesce(max(cd_produto), 0) + 1
		Into :ll_Produto
		From produto_geral
		Where cd_produto < 900000
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro na determina$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo do produto. Erro: "+SqlCa.sqlErrText
			Return False
		End If
	End If
	
	al_produto = ll_Produto
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_produto_novo'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True

end function

public function boolean of_insere_produto_geral (long al_produto, boolean ab_produto_novo, ref string as_log);Boolean	lb_liberar_validacao_saldo = False
Date	ldt_Termino_Avaliacao

DateTime	ldh_alteracao_codigo_barras,&
				ldh_desconto_atual,&
				ldh_preco_venda_atual

Date ldh_Inclusao_Produto

String	ls_id_proprio_consignado,&
		ls_cd_origem_produto,&
		ls_cd_tributacao_icms,&
		ls_id_tipo_desconto_atual,&
		ls_nr_matricula_desconto_atual,&
		ls_nr_matricula_preco_venda_atual,&
		ls_id_cartao_genio,&
		ls_id_cesta_basica,&
		ls_id_consumo_popular,&
		ls_cd_subcategoria,&
		ls_id_preco_bloqueado,&
		ls_id_repasse_icms,&
		ls_id_superfluo,&
		ls_id_liberado_filial


String ls_ID_Situacao_Pis_Cofins_Atual
String ls_Lei_Generico_Atual
String ls_ID_Situacao_Atual
String ls_Fornecedor_Atual
String ls_cd_cest_Atual
String ls_Grupo_Psico_Atual
String ls_cd_st_origem_atual
String ls_ID_Permite_Devolucao_Atual

Long	ll_cd_grupo_produto,&
		ll_cd_subgrupo_produto

Long ll_Classificacao
Long ll_Saldo
Long ll_UF_Sem_Preco
		
Decimal	ldc_pc_desconto_atual,&
			ldc_vl_preco_venda_atual,&
			ldc_pc_comissao_extra,&
			ldc_pc_ipi,&
			ldc_pc_reducao_base_icms

DateTime ldh_Situacao_Atual, ldt_dh_atual

Decimal ldc_PC_IPI_Atual
Decimal ldc_Vl_Fator_Conversao_Atual
			
Try			
	ldt_dh_atual	= gf_getserverdate()
	
	ldt_Termino_Avaliacao					= RelativeDate(Date(gf_GetServerDate()), 90)
	ldh_Inclusao_Produto						= Date(gf_GetServerDate())
	ls_id_proprio_consignado				= "P"
	ll_cd_grupo_produto						= 9
	ll_cd_subgrupo_produto					= 1	
	ls_cd_origem_produto					= "0"
	ls_cd_tributacao_icms					= "1" //  A trigger atualiza conforme a UF SC
	ldh_alteracao_codigo_barras			= gf_GetServerDate()
	ls_id_tipo_desconto_atual				= "F"
	ldh_desconto_atual						= gf_GetServerDate()	
	ldc_pc_desconto_atual					= 0.00
	ls_nr_matricula_desconto_atual		= is_Usuario_SAP
	ldh_preco_venda_atual					= gf_GetServerDate()
	ls_nr_matricula_preco_venda_atual	= is_Usuario_SAP
	ls_id_cartao_genio							= "N"
	ls_id_consumo_popular					= "N"
	ls_cd_subcategoria						= "901001001"
	ls_id_preco_bloqueado					= "N"
	ls_id_repasse_icms						= "N"
	ldc_pc_comissao_extra					= 0.00
	ldc_pc_reducao_base_icms				= 0.00
	ls_id_liberado_filial						= 'N'
	ls_id_superfluo								= 'N'
	ls_id_cesta_basica							= 'N'
	idc_vl_fator_conversao_abcfarma 		= 1
				
	If idc_vl_fator_conversao > 1 Then is_cd_unidade_medida_compra = 'CX'
	
	is_id_liberado_filial_sap = is_id_liberado_filial

	If ab_Produto_Novo Then
		// Ir$$HEX1$$e100$$ENDHEX$$ nascer como n$$HEX1$$e300$$ENDHEX$$o liberado, isso porque ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio corrigir o pre$$HEX1$$e700$$ENDHEX$$o primeiro
		is_id_liberado_filial 	   = "N" /// reavaliar
		If is_id_situacao <> 'A'  Then is_id_situacao = 'I' // Se estiver bloqueado no SAP nasce como INATIVO
	Else
		select coalesce(g.nr_classificacao_fiscal, 0), g.pc_ipi, g.id_situacao_pis_cofins, g.id_lei_generico, g.id_situacao, c.dh_situacao, g.cd_fornecedor_usual, g.cd_cest, g.cd_grupo_psico, g.vl_fator_conversao, g.cd_st_origem, COALESCE(g.id_permite_devolucao, 'N')
		Into :ll_Classificacao,  :ldc_PC_IPI_Atual, :ls_ID_Situacao_Pis_Cofins_Atual, :ls_Lei_Generico_Atual, :ls_ID_Situacao_Atual, :ldh_Situacao_Atual, :ls_Fornecedor_Atual, :ls_cd_cest_atual, :ls_Grupo_Psico_Atual, :ldc_Vl_Fator_Conversao_Atual, :ls_cd_st_origem_atual, :ls_ID_Permite_Devolucao_Atual
		from produto_geral g
		inner join produto_central c
			on c.cd_produto = g.cd_produto
		Where g.cd_produto = :al_Produto
		Using sqlca;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao localizar o percentual do IPI/NCM/LISTA/PIS_COFINS'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		/*Estava removendo o fornecedor divisao produto sendo que agora existe outra interface para isso.*/
		// Se houve altera$$HEX2$$e700e300$$ENDHEX$$o no fornecedor exclui o produto das divis$$HEX1$$f500$$ENDHEX$$es
//		If Not IsNull(is_cd_fornecedor_usual) and is_cd_fornecedor_usual <> ls_Fornecedor_Atual Then
//			If Not This.of_fornecedor_divisao(al_produto, is_cd_fornecedor_usual, ref as_log) Then Return False
//		End If
		
		// Houve altera$$HEX2$$e700e300$$ENDHEX$$o na lei gen$$HEX1$$e900$$ENDHEX$$rico
		If (ls_Lei_Generico_Atual <> is_id_lei_generico) or (ls_cd_st_origem_atual <> iif(IsNull(is_cd_st_origem), 'X', is_cd_st_origem) )  Then 
			ib_Revisao_Fiscal = True
		End If
		
//		If idc_vl_fator_conversao <> ldc_Vl_Fator_Conversao_Atual Then
//			as_Log	= "Houve altera$$HEX2$$e700e300$$ENDHEX$$o do fator de convers$$HEX1$$e300$$ENDHEX$$o, controle para n$$HEX1$$e300$$ENDHEX$$o deixar alterar. Precisar$$HEX1$$e100$$ENDHEX$$ ser analisado."
//			Return False
//		End If
		
		idh_Situacao = ldh_Situacao_Atual
		
		// Mudou a situa$$HEX2$$e700e300$$ENDHEX$$o de INATIVO/PENDENTE para ATIVO
		If  is_id_situacao = 'A' and ls_ID_Situacao_Atual <> 'A' Then 
			idh_Situacao 		= DateTime(Today(), Now())
			
			// Ativado e no legado esta INATIVO
			If is_id_situacao = 'A' and ls_ID_Situacao_Atual = 'I' Then
				ib_Revisao_Fiscal 	= True
			End If
		End If
		
		// Se o produto foi bloqueado no SAP
		If is_id_situacao <> 'A' Then
			// Se o produto estiver como ATIVO no legado, altera para PENDENTE
			If ls_ID_Situacao_Atual = 'A' Then
				idh_Situacao	= DateTime(Today(), Now())
				is_id_situacao	= 'P'
			Else
				// Permanece com a mesma situacao
				is_id_situacao = ls_ID_Situacao_Atual
			End If
		End If
		//This.Object.Nr_matric_alteracao_situacao	[1]	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	
		If IsNull(ls_Grupo_Psico_Atual) and Not IsNull(is_cd_grupo_psico) and Trim(is_cd_grupo_psico) <> '' Then
			Select Sum(qt_saldo_final)
				Into: ll_Saldo
			From vw_saldo_atual_produto
			Where cd_filial Not In (1, 534)
				And cd_produto = :al_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao consultar o saldo do produto nas filiais. Erro: " + SqlCa.SqlErrText
				Return False
			End If
			
			//of_get_prod_alt_lote_cont_saldo_loja()
			
			//Excluir c$$HEX1$$f300$$ENDHEX$$digo abaixo ap$$HEX1$$f300$$ENDHEX$$s o dia 01/01/2024
			/*if (al_Produto = 14449 or al_Produto = 737321) and ldt_dh_atual >= DateTime('2023-12-30') and ldt_dh_atual <= DateTime('2024-01-01') then
				lb_liberar_validacao_saldo = true
			else
				lb_liberar_validacao_saldo = false
			end if*/
			
			if not of_permite_alt_cont_saldo_filial(al_Produto, REF lb_liberar_validacao_saldo, REF as_log) then
				Return False
			end if
			
			If ll_Saldo > 0 and not lb_liberar_validacao_saldo Then
				as_Log	= "N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitida a altera$$HEX2$$e700e300$$ENDHEX$$o do produto para CONTROLADO, pois existe saldo nas filiais."
				Return False
			End If
		End If
		
//		//Controle Produto Preste
//		If ls_ID_Permite_Devolucao_Atual <> is_Id_Permite_Devolucao Then
//			If Not This.of_revisao_desconto_preste( al_Produto, Ref as_Log ) Then
//				Return False
//			End If
//		End If
		
	End If
	
	//Se houve altera$$HEX2$$e700e300$$ENDHEX$$o de NCM ou se for um produto novo
	If (ll_Classificacao <> il_nr_classificacao_fiscal) or ab_Produto_Novo Then
		//pc_ipi
		Select  coalesce(pc_ipi,0)
		Into :ldc_pc_ipi
		from ncm
		where nr_ncm = :il_nr_classificacao_fiscal
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
			Case 100
				ldc_pc_ipi	= 0.00
			Case -1
				as_Log	= "Erro ao localizar o percentual do IPI'. Erro: "+SqlCa.sqlErrText
				Return False
		End Choose
		
		ib_NCM_Alterado = True
		ib_Revisao_Fiscal = True
	Else
		//Mantem o mesmo IPI
		ldc_pc_ipi 			 = ldc_PC_IPI_Atual		
	End If
	
	idc_vl_volume = Round(idc_vl_volume, 2)
	
	idc_qt_altura_cm				= Round(idc_qt_altura_cm, 2)			
	idc_qt_profundidade_cm		= Round(idc_qt_profundidade_cm, 2)
	idc_qt_largura_cm				= Round(idc_qt_largura_cm, 2)		
	idc_qt_comprimento			= Round(idc_qt_comprimento, 2)		
	
		
	If ab_Produto_Novo Then
		Insert Into produto_geral(	cd_produto,
											dh_termino_avaliacao,
											cd_unidade_medida_compra,
											cd_unidade_medida_venda,
											dh_inclusao_produto,
											id_situacao,
											nr_classificacao_fiscal,
											id_caderno_abcfarma,
											id_proprio_consignado,
											vl_fator_conversao,
											nr_embalagem_padrao,
											cd_grupo_produto,
											cd_subgrupo_produto,
											cd_origem_produto,
											cd_tributacao_icms,
											dh_alteracao_codigo_barras,
											id_tipo_desconto_atual,
											dh_desconto_atual,
											pc_desconto_atual,
											nr_matricula_desconto_atual,
											dh_preco_venda_atual,
											nr_matricula_preco_venda_atual,
											vl_preco_venda_atual,
											id_cartao_genio,
											id_cesta_basica,
											id_consumo_popular,
											id_liberado_filial,
											id_situacao_pis_cofins,
											cd_fornecedor_usual,
											cd_subcategoria,
											de_produto,
											de_apresentacao_estoque,
											de_apresentacao_venda,
											id_preco_bloqueado,
											id_repasse_icms,
											id_superfluo,
											pc_comissao_extra,
											pc_ipi,
											pc_reducao_base_icms,
											id_contem_acucar,
											id_contem_gluten,
											id_contem_lactose,
											id_exclusivo,
											id_liberado_ecommerce,
											de_descricao_internet,
											//de_principal_internet,
											qt_altura_cm,
											qt_profundidade_cm,
											qt_largura_cm,
											qt_peso_grama,
											cd_st_origem,
											id_farmacia_popular,
											id_gratis_farm_popular,
											id_permite_devolucao,
											id_geladeira,
											id_utiliza_vale_resgate,
											vl_ponto_clube,
											qt_pontos_resgate,
											cd_unidade_medida_padrao,
											vl_fator_conversao_padrao,
											de_marca,
											id_apresentacao,
											cd_fabricante,
											cd_planograma,
											cd_dcb,
											id_lei_generico,
											cd_grupo_psico,
											cd_linha_produto,
											cd_marca_ecommerce,
											//cd_cest,
											cd_tipo_prescricao,
											qt_unidades_embalagem,
											cd_marca,
											de_registro_ms,
											qt_dias_maximo_tratamento,
											vl_volume,
											qt_estoque_minimo,
											vl_reembolso_fpb,
											qt_concentracao,
											cd_produto_sap,
											id_liberado_ecommerce_dc,
											id_liberado_ecommerce_mp,
											cd_tipo_alerta_restricao,
											id_liberado_filial_sap,
											cd_produto_sap_generico,
											id_liberado_ecommerce_pp,
											qt_comprimento,
											de_motivo_registro_ms_isento,
											qt_prazo_reposicao,
											cd_arvore_mercadologica_sap,
											cd_cronicidade,
											cd_area_farmacia,
											cd_tarja,
											cd_grupo_mercadoria_sap,
											id_sem_gtin,
											id_farm_gov_bolsa_familia,
											id_caract_variante,
											vl_temp_minima,
											vl_temp_maxima,
											id_pbm_permite_cobre_preco,
											cd_produto_area_atuacao,
											cd_produto_atributo,
											cd_produto_posologia,
											cd_produto_precaucoes,
											cd_produto_publico_dest,
											cd_produto_faixa_etaria,
											cd_produto_selo,
											cd_produto_texto_min_saude,
											id_contem_corante,
											id_testado_animais,
											id_vegano
			)
		Values(	:al_produto,
					:ldt_Termino_Avaliacao,
					:is_cd_unidade_medida_compra,
					:is_cd_unidade_medida_venda,
					:ldh_Inclusao_Produto,
					:is_id_situacao,
					:il_nr_classificacao_fiscal,
					:is_id_caderno_abcfarma,
					:ls_id_proprio_consignado,
					:idc_vl_fator_conversao,
					:il_nr_embalagem_padrao,
					:ll_cd_grupo_produto,
					:ll_cd_subgrupo_produto	,
					:ls_cd_origem_produto,
					:ls_cd_tributacao_icms,
					:ldh_alteracao_codigo_barras,
					:ls_id_tipo_desconto_atual,
					:ldh_desconto_atual,
					:ldc_pc_desconto_atual,
					:ls_nr_matricula_desconto_atual,
					:ldh_preco_venda_atual,
					:ls_nr_matricula_preco_venda_atual,
					:ldc_vl_preco_venda_atual,
					:ls_id_cartao_genio,
					:ls_id_cesta_basica,
					:ls_id_consumo_popular,
					:ls_id_liberado_filial,
					:is_id_situacao_Pis_Cofins,
					:is_cd_fornecedor_usual,
					:ls_cd_subcategoria,
					:is_de_produto,
					:is_de_apresentacao_estoque,
					:is_de_apresentacao_venda,
					:ls_id_preco_bloqueado,
					:ls_id_repasse_icms,
					:ls_id_superfluo,
					:ldc_pc_comissao_extra,
					:ldc_pc_ipi,
					:ldc_pc_reducao_base_icms,
					:is_id_contem_acucar,
					:is_id_contem_gluten,
					:is_id_contem_lactose,
					:is_id_exclusivo,
					:is_id_liberado_ecommerce,
					:is_de_descricao_internet,
					//:is_de_principal_internet,
					:idc_qt_altura_cm,
					:idc_qt_profundidade_cm,
					:idc_qt_largura_cm,
					:idc_qt_peso_grama,
					:is_cd_st_origem,
					:is_id_farmacia_popular,
					:is_id_gratis_farm_popular,
					:is_id_permite_devolucao,
					:is_id_geladeira,
					:is_id_utiliza_vale_resgate,
					:idc_vl_ponto_clube,
					:il_qt_pontos_resgate,
					:is_cd_unidade_medida_padrao,
					:idc_vl_fator_conversao_padrao,
					:is_de_marca,
					:is_id_apresentacao,
					:il_cd_fabricante,
					:il_cd_planograma,
					:is_cd_dcb,
					:is_id_lei_generico,
					:is_cd_grupo_psico,
					:is_cd_linha_produto,
					:il_cd_marca_ecommerce,
					//:is_cd_cest,
					:il_cd_tipo_prescricao,
					:il_qt_unidades_embalagem,
					:il_cd_marca,
					:is_de_registro_ms,
					:il_qt_dias_maximo_tratamento,
					:idc_vl_volume,
					:il_qt_estoque_minimo,
					:idc_vl_reembolso_fpb,
					:idc_qt_concentracao,
					:is_cd_produto_sap,
					:is_id_liberado_ecommerce_dc,
					:is_id_liberado_ecommerce_mp,
					:il_cd_tipo_alerta_restricao,
					:is_id_liberado_filial_sap,
					:is_cd_produto_sap_generico,
					:is_id_liberado_ecommerce_pp,
					:idc_qt_comprimento,
					:is_de_motivo_registro_ms_isento,
					:il_qt_prazo_reposicao,				
					:is_cd_arvore_mercadologica,
					:il_cd_cronicidade,
					:il_cd_area_farmacia,
					:il_cd_tarja,
					:is_cd_grupo_mercadoria,
					:is_id_sem_gtin,
					:is_farm_gov_bolsa_familia,
					:is_id_caract_variante,
					:idc_vl_temp_minima,
					:idc_vl_temp_maxima,
					:is_id_cobre_preco_pbm,
					:il_cd_produto_area_atuacao,
					:il_cd_produto_atributo,
					:il_cd_produto_posologia,
					:il_cd_produto_precaucoes,
					:il_cd_produto_publico_dest,
					:il_cd_produto_faixa_etaria,
					:il_cd_produto_selo,
					:il_cd_produto_texto_min_saude,
					:is_id_contem_corante,
					:is_id_testado_animais,
					:is_id_vegano)
		Using SqlCa;
		
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'produto_geral'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		If SqlCa.sqlnrows <> 1 Then
			as_Log	= "Erro no insert da tabela 'produto_geral'. Deveria ter inserido um registro mas inseriu "+String(SqlCa.sqlnrows)+" registro(s)."
			Return False
		End If
	Else
		
		// Alteracao
		If iif(IsNull(is_id_situacao_pis_cofins), 'X', is_id_situacao_pis_cofins) <> ls_ID_Situacao_Pis_Cofins_Atual Then
			
			// Conforme alinhado com a Lais a partir de hoje (27/06/2019) o CEST n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ mais atualizado.
			/*
			If Not IsNull(is_id_situacao_pis_cofins)  Then
				ivo_cest.of_localiza_cest_ncm(il_nr_classificacao_fiscal,is_id_situacao_pis_cofins,is_id_lei_generico)
				is_cd_cest = ivo_cest.cd_cest
			Else
				SetNull(is_cd_cest)
			End If
			
			If Not IsNull(ls_cd_cest_atual) and IsNull(is_cd_cest) Then
				as_Log	= "Controle para identificar o que esta anulando o CEST [Avisar o S$$HEX1$$e900$$ENDHEX$$rgio do Projeto CEM]."
				Return False
			End If
			*/
			
			ib_Revisao_Fiscal = True
		Else
			is_cd_cest = ls_cd_cest_atual
		End If
				
		If Not This.of_Grava_Historico_Produto_Geral(al_produto, Ref as_Log) Then Return False
		
		// No central n$$HEX1$$e300$$ENDHEX$$o grava o c$$HEX1$$f300$$ENDHEX$$digo do SAP.
//		If gvo_Aplicacao.ivs_DataSource = 'central' Then 

		Select count(*)
		Into :ll_UF_Sem_Preco
		From produto_geral g
		Where g.cd_produto = :al_produto
		     and substring(g.cd_subcategoria, 1,1) <> '5' //n$$HEX1$$e300$$ENDHEX$$o considera produto almoxarifado
			 and dh_inclusao_produto >= '2020-02-01' //somente cadastros mais recentes
			 and exists (select * from produto_uf u
			 				where u.cd_produto 				= g.cd_produto
							    and u.vl_preco_venda_atual = 0.00)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao localizar o pre$$HEX1$$e700$$ENDHEX$$o de venda atual. Erro: "+SqlCa.sqlErrText
			Return False
		End If		
		
		//Permanece bloqueado para movimenta$$HEX2$$e700e300$$ENDHEX$$o caso existam UF'S sem pre$$HEX1$$e700$$ENDHEX$$o
		If ll_UF_Sem_Preco > 0 Then
			is_id_liberado_filial = 'N'
		End If
		
		Update produto_geral
		Set	cd_unidade_medida_compra	= :is_cd_unidade_medida_compra,
				cd_unidade_medida_venda		= :is_cd_unidade_medida_venda,
				id_situacao							= :is_id_situacao,
				nr_classificacao_fiscal			= :il_nr_classificacao_fiscal,
				id_caderno_abcfarma				= :is_id_caderno_abcfarma,
				vl_fator_conversao				= :idc_vl_fator_conversao,
				nr_embalagem_padrao			= :il_nr_embalagem_padrao,
				id_liberado_filial					= :is_id_liberado_filial,
				id_situacao_pis_cofins			= :is_id_situacao_pis_cofins,
//				cd_fornecedor_usual				= :is_cd_fornecedor_usual, N$$HEX1$$e300$$ENDHEX$$o deve mais atualizar por aqui. A atualiza$$HEX2$$e700e300$$ENDHEX$$o ocorre pela interface do subsortimento
				de_produto							= :is_de_produto,
				de_apresentacao_estoque		= :is_de_apresentacao_estoque,
				de_apresentacao_venda			= :is_de_apresentacao_venda,
				id_contem_acucar					= :is_id_contem_acucar,
				id_contem_gluten					= :is_id_contem_gluten,
				id_contem_lactose					= :is_id_contem_lactose,
				id_exclusivo							= :is_id_exclusivo,
				id_liberado_ecommerce			= :is_id_liberado_ecommerce,
				de_descricao_internet			= :is_de_descricao_internet,
				qt_altura_cm						= :idc_qt_altura_cm,
				qt_profundidade_cm				= :idc_qt_profundidade_cm,
				qt_largura_cm						= :idc_qt_largura_cm,
				qt_peso_grama						= :idc_qt_peso_grama,
				cd_st_origem						= :is_cd_st_origem,
				id_farmacia_popular				= :is_id_farmacia_popular,
				id_gratis_farm_popular			= :is_id_gratis_farm_popular,
				id_permite_devolucao				= :is_id_permite_devolucao,
				id_geladeira							= :is_id_geladeira,
				id_utiliza_vale_resgate			= :is_id_utiliza_vale_resgate,
				vl_ponto_clube						= :idc_vl_ponto_clube,
				qt_pontos_resgate					= :il_qt_pontos_resgate,
				cd_unidade_medida_padrao		= :is_cd_unidade_medida_padrao,
				vl_fator_conversao_padrao		= :idc_vl_fator_conversao_padrao,
				de_marca							= :is_de_marca,
				id_apresentacao					= :is_id_apresentacao,
				cd_fabricante						= :il_cd_fabricante,
				cd_planograma						= :il_cd_planograma,
				cd_dcb								= :is_cd_dcb,
				id_lei_generico						= :is_id_lei_generico,
				cd_grupo_psico						= :is_cd_grupo_psico,
				cd_linha_produto					= :is_cd_linha_produto,
				cd_marca_ecommerce			= :il_cd_marca_ecommerce,
				cd_tipo_prescricao					= :il_cd_tipo_prescricao,
				qt_unidades_embalagem			= :il_qt_unidades_embalagem,
				cd_marca							= :il_cd_marca,
				de_registro_ms						= :is_de_registro_ms,
				qt_dias_maximo_tratamento	= :il_qt_dias_maximo_tratamento,
				vl_volume							= :idc_vl_volume,
				qt_estoque_minimo				= :il_qt_estoque_minimo,
				vl_reembolso_fpb					= :idc_vl_reembolso_fpb,
				qt_concentracao					= :idc_qt_concentracao,
				id_liberado_ecommerce_dc		= :is_id_liberado_ecommerce_dc,
				id_liberado_ecommerce_mp	= :is_id_liberado_ecommerce_mp,
				cd_tipo_alerta_restricao			= :il_cd_tipo_alerta_restricao,
				id_liberado_filial_sap				= :is_id_liberado_filial_sap,
				cd_produto_sap					= :is_cd_produto_sap,
				cd_produto_sap_generico 		= :is_cd_produto_sap_generico,
				id_liberado_ecommerce_pp 	=:is_id_liberado_ecommerce_pp,
				qt_comprimento					=:idc_qt_comprimento,
				de_motivo_registro_ms_isento = :is_de_motivo_registro_ms_isento,
				cd_origem_produto				= :is_cd_st_origem,
				qt_prazo_reposicao 				= :il_qt_prazo_reposicao,				
				cd_arvore_mercadologica_sap 	= :is_cd_arvore_mercadologica,
				cd_cronicidade 						= :il_cd_cronicidade,
				cd_area_farmacia 					= :il_cd_area_farmacia,
				cd_tarja 								= :il_cd_tarja,
				cd_grupo_mercadoria_sap		= :is_cd_grupo_mercadoria,
				id_sem_gtin 						= :is_id_sem_gtin,
				id_farm_gov_bolsa_familia		= :is_farm_gov_bolsa_familia,
				//id_caract_variante 	              = :is_id_caract_variante,
				vl_temp_minima 	              	= :idc_vl_temp_minima,
				vl_temp_maxima 	              	= :idc_vl_temp_maxima,
				id_pbm_permite_cobre_preco	= :is_id_cobre_preco_pbm,
				cd_produto_area_atuacao    = :il_cd_produto_area_atuacao,
				cd_produto_atributo        = :il_cd_produto_atributo,
				cd_produto_posologia       = :il_cd_produto_posologia,
				cd_produto_precaucoes      = :il_cd_produto_precaucoes,
				cd_produto_publico_dest    = :il_cd_produto_publico_dest,
				cd_produto_faixa_etaria    = :il_cd_produto_faixa_etaria,
				cd_produto_selo            = :il_cd_produto_selo,
				cd_produto_texto_min_saude = :il_cd_produto_texto_min_saude,
				id_contem_corante          = :is_id_contem_corante,
				id_testado_animais         = :is_id_testado_animais,
				id_vegano                  = :is_id_vegano
		Where cd_produto = :al_produto
		Using SqlCa;

		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no update da tabela 'produto_geral'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		If SqlCa.sqlnrows <> 1 Then
			as_Log	= "Erro no update da tabela 'produto_geral'. Deveria ter atualizado um registro mas atualizou "+String(SqlCa.sqlnrows)+" registro(s)."
			Return False
		End If
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_produto_geral'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_insere_produto_central (long al_produto, boolean ab_produto_novo, ref string as_log);String	ls_cd_divisao_estocagem
String 	ls_Revisao_Fiscal
String 	ls_preco_informado
String 	ls_id_origem_produto_fornecedor
String 	ls_Pagmto_Apos_Venda
String 	ls_Contrato_Fornecedor
String 	ls_Bairro_WMS
String 	ls_Revisao_Fiscal_Atual
String 	ls_Nulo
String	ls_id_projeto_conexao_sap
		
Decimal	ldc_vl_peso_liquido,&
			ldc_Volume,&
			ldc_Volume_Limite
			
DateTime	ldh_dh_situacao

SetNull(ls_Nulo)

Try
	ls_cd_divisao_estocagem			= "00"	//Verificar
	ls_id_origem_produto_fornecedor	= "R"
	ldh_dh_situacao						= gf_GetServerDate()
	ls_preco_informado					= "N"
	ls_Pagmto_Apos_Venda				= "N"
	
	If Not IsNull( is_cd_grupo_psico ) And Trim( is_cd_grupo_psico ) <> "" Then
		ls_Bairro_WMS = "9"
	Else
		ls_Bairro_WMS = "1"
	End If

	If ib_Revisao_Fiscal Then ls_Revisao_Fiscal = 'P'
	
	If Not IsNull(is_id_projeto_conexao) and is_Id_Projeto_Conexao = "S" Then
		ls_id_projeto_conexao_sap	= 'S'
			
		select f.id_projeto_conexao
		into :is_Id_Projeto_Conexao
		from fornecedor f 
		where f.cd_fornecedor = :is_cd_fornecedor_usual
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= 'Erro ao localizar o projeto conex$$HEX1$$e300$$ENDHEX$$o do fornecedor: ' + is_cd_fornecedor_usual + '. Erro: '+SqlCa.sqlErrText
			Return False
		End If
		
	Else
		SetNull(is_id_projeto_conexao)
		
		ls_id_projeto_conexao_sap	= 'N'
	End If	

	If IsNull(idc_pc_desconto_fornecedor) Then
		idc_pc_desconto_fornecedor = 0 
	End If
	
	idc_qt_altura_cm_caixa_estoque		= Round(idc_qt_altura_cm_caixa_estoque, 2)		
	idc_qt_largura_cm_caixa_estoque		= Round(idc_qt_largura_cm_caixa_estoque, 2)	
	idc_qt_profund_cm_caixa_estoque		= Round(idc_qt_profund_cm_caixa_estoque, 2)
	idc_qt_altura_cm_caixa_forn			= Round(idc_qt_altura_cm_caixa_forn,2)
	idc_qt_largura_cm_caixa_forn			= Round(idc_qt_largura_cm_caixa_forn,2)
	idc_qt_profundidade_cm_caixa_forn	= Round(idc_qt_profundidade_cm_caixa_forn,2)
	
	// Manicure/corte de cabelo / smile
	If al_Produto <> 707440 and al_Produto <> 722279 and al_produto <> 707439 and al_Produto <> 700118 Then
		If idc_qt_altura_cm_caixa_estoque <= 0 Then
			as_Log = "A altura da dimens$$HEX1$$e300$$ENDHEX$$o do produto que $$HEX1$$e900$$ENDHEX$$ utilizada no Estoque Central n$$HEX1$$e300$$ENDHEX$$o foi informada ou $$HEX1$$e900$$ENDHEX$$ menor do que 0,01 cm. [Altura SAP: "+String(idc_qt_altura_cm_caixa_estoque)+"]"
			Return False
		End If
		
		If idc_qt_largura_cm_caixa_estoque <= 0 Then
			as_Log = "A largura da dimens$$HEX1$$e300$$ENDHEX$$o do produto que $$HEX1$$e900$$ENDHEX$$ utilizada no Estoque Central n$$HEX1$$e300$$ENDHEX$$o foi informada ou $$HEX1$$e900$$ENDHEX$$ menor do que 0,01 cm. [Largura SAP: "+String(idc_qt_largura_cm_caixa_estoque)+"]"
			Return False
		End If
		
		If idc_qt_profund_cm_caixa_estoque <= 0 Then
			as_Log = "A profundidade da dimens$$HEX1$$e300$$ENDHEX$$o do produto que $$HEX1$$e900$$ENDHEX$$ utilizada no Estoque Central n$$HEX1$$e300$$ENDHEX$$o foi informada ou $$HEX1$$e900$$ENDHEX$$ menor do que 0,01 cm. [Profundidade SAP: "+String(idc_qt_profund_cm_caixa_estoque)+"]"
			Return False
		End If
	End If
	
	//If idc_qt_altura_cm_caixa_forn <= 0 Then
	//	as_Log = "A altura da dimens$$HEX1$$e300$$ENDHEX$$o do produto, caixa do fornecedor, n$$HEX1$$e300$$ENDHEX$$o foi informada ou $$HEX1$$e900$$ENDHEX$$ menor do que 0,01 cm. [Altura SAP: "+String(idc_qt_altura_cm_caixa_forn)+"]"
	//	Return False
	//End If
	
	//If idc_qt_largura_cm_caixa_forn <= 0 Then
	//	as_Log = "A largura da dimens$$HEX1$$e300$$ENDHEX$$o do produto, caixa do fornecedor, n$$HEX1$$e300$$ENDHEX$$o foi informada ou $$HEX1$$e900$$ENDHEX$$ menor do que 0,01 cm. [Largura SAP: "+String(idc_qt_largura_cm_caixa_forn)+"]"
	//	Return False
	//End If
	
	//If idc_qt_profundidade_cm_caixa_forn <= 0 Then
	//	as_Log = "A profundidade da dimens$$HEX1$$e300$$ENDHEX$$o do produto, caixa do fornecedor, n$$HEX1$$e300$$ENDHEX$$o foi informada ou $$HEX1$$e900$$ENDHEX$$ menor do que 0,01 cm. [Profundidade SAP: "+String(idc_qt_profundidade_cm_caixa_forn)+"]"
	//	Return False
	//End If
	
	ldc_Volume	= round((idc_qt_largura_cm_caixa_estoque * idc_qt_altura_cm_caixa_estoque * idc_qt_profund_cm_caixa_estoque ) / 1000, 4)
	
	// s$$HEX1$$f300$$ENDHEX$$ valida para produto novo porque quanto $$HEX1$$e900$$ENDHEX$$ atualiza$$HEX2$$e700e300$$ENDHEX$$o o sistema mantem as mesmas informa$$HEX2$$e700f500$$ENDHEX$$es cadastradas anteriormente
	If ab_Produto_Novo Then
		If mid(is_cd_produto_sap,1,1) = '8'Then
			ldc_Volume_Limite = 500
		Else
			ldc_Volume_Limite =50
		End If
		
		If ldc_Volume > ldc_Volume_Limite Then
			as_Log = "O volume m$$HEX1$$e100$$ENDHEX$$ximo permitido $$HEX1$$e900$$ENDHEX$$ de [" + String(ldc_Volume_Limite) + "] litros. Produto "+String(al_produto)+". [Altura: "+String(idc_qt_altura_cm_caixa_estoque)+"] [Largura: "+String(idc_qt_largura_cm_caixa_estoque)+"] [Profundidade: "+String(idc_qt_profund_cm_caixa_estoque)+"] [Total: "+String(ldc_Volume)+"]"
			Return False
		End If
	End If
	
	If ab_Produto_Novo Then
		Insert Into produto_central	(	cd_produto,
							id_sugere_pedido_filial,
							qt_altura_cm_caixa_estoque,
							qt_largura_cm_caixa_estoque,
							qt_profund_cm_caixa_estoque,
							id_projeto_conexao,
							de_historico_fiscal,
							cd_mix_produto,
							id_tipo_reposicao_estoque,
							cd_divisao_estocagem,
							id_origem_produto_fornecedor, 
							pc_desconto_fornecedor, 
							vl_peso_liquido, 
							dh_situacao, 
							vl_fator_conversao_abcfarma, 
							id_lei_generico,
							id_revisao_fiscal,
							id_preco_informado,
							id_pagamento_apos_venda,
							id_contrato_fornecedor,
							cd_bairro_wms,
							cd_produto_fornecedor,
							cd_prod_referencia_preco,
							pc_prod_referencia_preco,
							id_tipo_un_calc_preco,
							id_bloqueia_calculo_preco,
							qt_peso_apresentacao,
							cd_tipo_produto_pricing,
							cd_segmento_ims,
							de_alteracao_situacao,
							qt_altura_cm_caixa_forn,
					 		qt_largura_cm_caixa_forn,
					 		qt_profundidade_cm_caixa_forn,
							cd_grupo_alteracao_preco,
							pc_desconto_conexao,
							qt_peso_kg_estoque,
							cd_categ_mercadologica,
							de_produto_primaria,
							de_produto_secundaria,
							id_permite_publicidade, 
							id_publi_obriga_texto_legal, 
							de_texto_legal,
							id_lib_marketing_externo,
							id_lib_marketing_interno,
							id_projeto_conexao_sap,
							dt_inicio_stb,
							dt_fim_stb,
							id_stb,
							de_desc_stb
							)
		Values(	:al_produto,
					:is_id_sugere_pedido_filial,
					:idc_qt_altura_cm_caixa_estoque,
					:idc_qt_largura_cm_caixa_estoque,
					:idc_qt_profund_cm_caixa_estoque,
					:is_id_projeto_conexao,
					:is_de_historico_fiscal,
					:il_cd_mix_produto,
					:is_id_tipo_reposicao_estoque,
					:ls_cd_divisao_estocagem,
					:ls_id_origem_produto_fornecedor,
					:idc_pc_desconto_fornecedor,
					:ldc_vl_peso_liquido,
					:ldh_dh_situacao,
					:idc_vl_fator_conversao_abcfarma,
					:is_id_lei_generico,
					:ls_Revisao_Fiscal,
					:ls_preco_informado,
					:ls_Pagmto_Apos_Venda,
					:ls_Contrato_Fornecedor,
					:ls_Bairro_WMS,
					:is_cd_produto_fornecedor,
					:il_cd_prod_referencia_preco,
					:idc_pc_prod_referencia_preco,
					:is_id_tipo_un_calc_preco,
					:is_id_bloqueia_calculo_preco,
					:idc_qt_peso_apresentacao,
					:il_cd_tipo_produto_pricing,
					:is_cd_segmento_ims,
					:is_de_alteracao_situacao,
					:idc_qt_altura_cm_caixa_forn,
					:idc_qt_largura_cm_caixa_forn,
					:idc_qt_profundidade_cm_caixa_forn,
					:il_cd_grupo_alteracao_preco,
					:idc_pc_desconto_conexao,
					:idc_qt_peso_kg_estoque,
					:il_cd_categ_mercadologica,
					:is_desc_com_prin,
					:is_desc_com_sec,
					:is_permite_publicidade, 
					:is_publicidade_obri_texto_legal, 
					:is_texto_legal,
					:is_id_lib_marketing_externo,
					:is_id_lib_marketing_interno,
					:ls_id_projeto_conexao_sap,
					:idh_inicio_standby,
					:idh_fim_standby,
					:is_id_standby,
					:is_desc_standby
					)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'produto_central'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		If SqlCa.sqlnrows <> 1 Then
			as_Log	= "Erro no insert da tabela 'produto_central'. Deveria ter inserido um registro mas inseriu "+String(SqlCa.sqlnrows)+" registro(s)."
			Return False
		End If
		
	Else
		If Not This.of_grava_historico_produto_central(al_produto, Ref as_Log) Then Return False
		
		select p.id_revisao_fiscal
		Into :ls_Revisao_Fiscal_Atual
		from produto_central p
		Where p.cd_produto = :al_produto
		Using sqlca;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao localizar o produto central. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		If ls_Revisao_Fiscal_Atual = "P" Then
			ls_Revisao_Fiscal = ls_Revisao_Fiscal_Atual
		End If
						
		Update produto_central
		Set	id_sugere_pedido_filial				= :is_id_sugere_pedido_filial,
				qt_altura_cm_caixa_estoque		= :idc_qt_altura_cm_caixa_estoque,
				qt_largura_cm_caixa_estoque		= :idc_qt_largura_cm_caixa_estoque,
				qt_profund_cm_caixa_estoque		= :idc_qt_profund_cm_caixa_estoque,
				id_projeto_conexao					= :is_id_projeto_conexao,
				de_historico_fiscal						= :is_de_historico_fiscal,
				cd_produto_fornecedor				= :is_cd_produto_fornecedor,
				cd_mix_produto						= :il_cd_mix_produto,
				id_tipo_reposicao_estoque			= :is_id_tipo_reposicao_estoque,
				id_lei_generico							= :is_id_lei_generico,
				id_revisao_fiscal						= :ls_Revisao_Fiscal,
				dh_situacao								= :idh_Situacao,
				cd_prod_referencia_preco			= :il_cd_prod_referencia_preco,
				pc_prod_referencia_preco			= :idc_pc_prod_referencia_preco,
				id_tipo_un_calc_preco				= :is_id_tipo_un_calc_preco,
				id_bloqueia_calculo_preco			= :is_id_bloqueia_calculo_preco,
				qt_peso_apresentacao				= :idc_qt_peso_apresentacao,
				cd_tipo_produto_pricing				= :il_cd_tipo_produto_pricing,
				cd_segmento_ims						= :is_cd_segmento_ims,
				id_exclusivo_pedido_falta_ba		= :is_id_exclusivo_pedido_falta_ba,
				de_alteracao_situacao				= :is_de_alteracao_situacao,
				qt_altura_cm_caixa_forn				= :idc_qt_altura_cm_caixa_forn,
				qt_largura_cm_caixa_forn			= :idc_qt_largura_cm_caixa_forn,	
				qt_profundidade_cm_caixa_forn	= :idc_qt_profundidade_cm_caixa_forn,
				cd_grupo_alteracao_preco			= :il_cd_grupo_alteracao_preco,
				pc_desconto_conexao					= :idc_pc_desconto_conexao,
				nr_matric_solicitacao_alt_sit		= :ls_Nulo,
				cd_categ_mercadologica				= :il_cd_categ_mercadologica,
				de_produto_primaria					= :is_desc_com_prin,
				de_produto_secundaria				= :is_desc_com_sec,
				id_permite_publicidade				= :is_permite_publicidade,
				id_publi_obriga_texto_legal			= :is_publicidade_obri_texto_legal,
				de_texto_legal							= :is_texto_legal,
				id_lib_marketing_externo			= :is_id_lib_marketing_externo,
				id_lib_marketing_interno				= :is_id_lib_marketing_interno,
				id_projeto_conexao_sap				= :ls_id_projeto_conexao_sap,
				dt_inicio_stb								= :idh_inicio_standby,
				dt_fim_stb								= :idh_fim_standby,
				id_stb										= :is_id_standby,
				de_desc_stb								= :is_desc_standby
		Where cd_produto	= :al_produto
		Using SqlCa;
		
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no update da tabela 'produto_central'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		If SqlCa.sqlnrows <> 1 Then
			as_Log	= "Erro no update da tabela 'produto_central'. Deveria ter atualizado um registro mas atualizou "+String(SqlCa.sqlnrows)+" registro(s)."
			Return False
		End If
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_produto_central'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True

end function

public function boolean of_insere_produto_uf (long al_produto, boolean ab_produto_novo, ref string as_log);String	ls_Unidade_Federacao,&
		ls_cd_tributacao_icms,&
		ls_matricula_preco_reposicao,&
		ls_matric_preco_venda_atual

Long	ll_Linhas,&
		ll_Linha,&
		ll_cd_tipo_icms,&
		ll_cd_tributacao_produto
		
Long ll_Situacao
Long ll_Msg_Fiscal
		
Decimal	ldc_vl_preco_reposicao,&
			ldc_vl_preco_venda_atual,&
			ldc_pc_desconto_repassado_preco,&
			ldc_pc_frete_preco,&
			ldc_pc_acrescimo_financeiro_preco

Decimal ldc_Red_BC_ST

DateTime	ldh_preco_reposicao,&
				ldh_preco_venda_atual
								
//If Not ab_produto_novo Then Return True

dc_uo_ds_base lds_UF

Try
	Try
		lds_UF	= Create dc_uo_ds_base
		
		If Not lds_UF.of_ChangeDataObject('ds_ge473_uf', False) Then 
			as_log = "Erro ao alterar a DW [ds_ge473_uf]."
			Return False
		End If
		
		ll_Linhas	= lds_UF.Retrieve()
		
		If ll_Linhas	= 0 Then
			as_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma UF na DW [ds_ge473_uf]."
			Return False
		End If
		
		If ll_Linhas	< 0 Then
			as_log = "Erro no retrieve da DW [ds_ge473_uf]."
			Return False
		End If
		
		//ls_cd_tributacao_icms					= "1"	//Verificar
		//ll_cd_tipo_icms								= 1	//Verificar
		ldc_vl_preco_reposicao					= 0.00	//Verificar. Deve ser maior do que zero
		ldh_preco_reposicao						= gf_GetServerDate()
		ls_matricula_preco_reposicao			= "SAP001"
		ldc_vl_preco_venda_atual				= 0.00	//Verificar. Deve ser maior do que zero
		ldh_preco_venda_atual					= gf_GetServerDate()
		ls_matric_preco_venda_atual			= "SAP001"
		ldc_pc_desconto_repassado_preco	= 0.00
		ldc_pc_frete_preco						= 0.00
		ldc_pc_acrescimo_financeiro_preco	= 0.00
		//ll_cd_tributacao_produto					= 0		//Verificar
	
		For	ll_Linha = 1 To ll_Linhas
			ls_Unidade_Federacao	= lds_UF.object.cd_unidade_federacao	[ll_linha]
			
			// Quando tiver NCM alterado ou for um novo produto
			If ib_NCM_Alterado Then
				Select nr_sequencial, cd_tributacao_icms, cd_tipo_icms, cd_tributacao_produto, cd_mensagem_fiscal, pc_reducao_base_st
				Into :ll_Situacao, :ls_cd_tributacao_icms, :ll_cd_tipo_icms, :ll_cd_tributacao_produto, :ll_Msg_Fiscal, :ldc_Red_BC_ST
				from ncm_situacao_especial
				where nr_ncm 		= :il_nr_classificacao_fiscal
					 and cd_uf		= :ls_Unidade_Federacao
					 and id_padrao	= 'S'
				Using SqlCa	;
				
				Choose Case SqlCa.SqlCode
					Case 0
					Case 100
						as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado as informa$$HEX2$$e700f500$$ENDHEX$$es da tributa$$HEX2$$e700e300$$ENDHEX$$o do produto na fun$$HEX1$$e700$$ENDHEX$$ao [of_insere_produto_uf]."
						Return False
					Case -1
						as_Log	= "Erro ao localizar as informa$$HEX2$$e700f500$$ENDHEX$$es da tributa$$HEX2$$e700e300$$ENDHEX$$o do produto na fun$$HEX1$$e700$$ENDHEX$$ao [of_insere_produto_uf]. Erro: "+SqlCa.sqlErrText
						Return False
				End Choose
			End If
				
			If ab_Produto_Novo	Then
			
				Insert Into produto_uf(	cd_unidade_federacao,
												cd_produto,
												cd_tributacao_icms,
												cd_tipo_icms,
												vl_preco_reposicao,
												dh_preco_reposicao,
												nr_matricula_preco_reposicao,
												vl_preco_venda_atual,
												dh_preco_venda_atual,
												nr_matric_preco_venda_atual,
												pc_desconto_repassado_preco,
												pc_frete_preco,
												pc_acrescimo_financeiro_preco,
												cd_tributacao_produto,
												cd_mensagem_fiscal,
												nr_ncm_situacao,
												pc_reducao_base_st)
				Values(	:ls_Unidade_Federacao,
							:al_produto,
							:ls_cd_tributacao_icms,
							:ll_cd_tipo_icms,
							:ldc_vl_preco_reposicao,
							:ldh_preco_reposicao,
							:ls_matricula_preco_reposicao,
							:ldc_vl_preco_venda_atual,
							:ldh_preco_venda_atual,
							:ls_matric_preco_venda_atual,
							:ldc_pc_desconto_repassado_preco,
							:ldc_pc_frete_preco,
							:ldc_pc_acrescimo_financeiro_preco,
							:ll_cd_tributacao_produto,
							:ll_Msg_Fiscal,
							:ll_Situacao,
							:ldc_Red_BC_ST							
				)
				Using SqlCa;
				
				If SqlCa.sqlcode = -1 Then
					as_Log	= "Erro no insert da tabela 'produto_uf'. Erro: "+SqlCa.sqlErrText
					Return False
				End If
				
				If SqlCa.sqlnrows <> 1 Then
					as_Log	= "Erro no insert da tabela 'produto_uf'. Deveria ter inserido um registro mas inseriu "+String(SqlCa.sqlnrows)+" registro(s)."
					Return False
				End If
			
			Else
				// Produto antigo que teve altera$$HEX2$$e700e300$$ENDHEX$$o de NCM
				If ib_NCM_Alterado Then
					Update produto_uf	
					Set cd_tributacao_icms =:ls_cd_tributacao_icms, 
						cd_tipo_icms =:ll_cd_tipo_icms, 
						cd_tributacao_produto =:ll_cd_tributacao_produto, 
						cd_mensagem_fiscal =:ll_Msg_Fiscal, 
						nr_ncm_situacao =:ll_Situacao, 
						pc_reducao_base_st =:ldc_Red_BC_ST
					Where cd_unidade_federacao 	=:ls_Unidade_Federacao
						and cd_produto					=:al_produto 
					Using SqlCa;
					
					If SqlCa.sqlcode = -1 Then
						as_Log	= "Erro no insert da tabela 'produto_uf'. Erro: "+SqlCa.sqlErrText
						Return False
					End If
				
					If SqlCa.sqlnrows <> 1 Then
						as_Log	= "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da tabela 'produto_uf'. Deveria ter atualizado um registro mas atualizou "+String(SqlCa.sqlnrows)+" registro(s)."
						Return False
					End If
				End If				
			End If
		Next
		
	Catch ( runtimeerror  lo_rte )
		as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_produto_uf'. Erro: "+lo_rte.GetMessage( )
		Return False						 
	End Try	
		
Finally
	Destroy(lds_UF)
End Try

Return True
end function

public function boolean of_grava_historico_produto_geral (long al_produto, ref string as_log);String		ls_cd_unidade_medida_compra,&
			ls_cd_unidade_medida_venda,&
			ls_id_situacao,&
			ls_id_caderno_abcfarma,&
			ls_id_liberado_filial,&
			ls_id_situacao_pis_cofins,&
			ls_cd_fornecedor_usual,&
			ls_de_produto,&
			ls_de_apresentacao_estoque,&
			ls_de_apresentacao_venda,&
			ls_id_contem_acucar,&
			ls_id_contem_gluten,&
			ls_id_contem_lactose,&
			ls_id_exclusivo,&
			ls_id_liberado_ecommerce,&
			ls_de_descricao_internet,&
			ls_de_principal_internet,&
			ls_cd_st_origem,&
			ls_id_farmacia_popular,&
			ls_id_gratis_farm_popular,&
			ls_id_permite_devolucao,&
			ls_id_geladeira,&
			ls_id_utiliza_vale_resgate,&
			ls_cd_unidade_medida_padrao,&
			ls_de_marca,&
			ls_id_apresentacao,&
			ls_cd_dcb,&
			ls_id_lei_generico,&
			ls_cd_grupo_psico,&
			ls_cd_linha_produto,&
			ls_cd_cest,&
			ls_de_registro_ms,&
			ls_de_motivo_registro_ms_isento,&
			ls_id_sem_gtin,&
			ls_farm_gov_bolsa_familia,     &
			ls_cd_produto_area_atuacao,    &
			ls_cd_produto_atributo,        &
			ls_cd_produto_faixa_etaria,    &
			ls_cd_produto_posologia,       &
			ls_cd_produto_precaucoes,      &
			ls_cd_produto_publico_dest,    &
			ls_cd_produto_selo,            &
			ls_cd_produto_texto_min_saude, &
			ls_id_contem_corante,          &
			ls_id_testado_animais,         &
			ls_id_vegano

Long	ll_nr_classificacao_fiscal,&
		ll_nr_embalagem_padrao,&
		ll_qt_pontos_resgate,&
		ll_cd_fabricante,&
		ll_cd_planograma,&
		ll_cd_marca_ecommerce,&
		ll_cd_tipo_prescricao,&
		ll_qt_unidades_embalagem,&
		ll_cd_marca,&
		ll_qt_dias_maximo_tratamento,&
		ll_qt_estoque_minimo

Decimal	ldc_vl_fator_conversao,&
			ldc_qt_altura_cm,&
			ldc_qt_profundidade_cm,&
			ldc_qt_largura_cm,&
			ldc_qt_peso_grama,&
			ldc_vl_ponto_clube,&
			ldc_vl_fator_conversao_padrao,&
			ldc_vl_volume,&
			ldc_vl_reembolso_fpb,&
			ldc_qt_comprimento
			
Try			
	
	Select		cd_unidade_medida_compra,
				cd_unidade_medida_venda,
				id_situacao,
				nr_classificacao_fiscal,
				id_caderno_abcfarma,
				vl_fator_conversao,
				nr_embalagem_padrao,
				id_liberado_filial,
				id_situacao_pis_cofins,
				cd_fornecedor_usual,
				de_produto,
				de_apresentacao_estoque,
				de_apresentacao_venda,
				id_contem_acucar,
				id_contem_gluten,
				id_contem_lactose,
				id_exclusivo,
				id_liberado_ecommerce,
				de_descricao_internet,
				de_principal_internet,
				qt_altura_cm,
				qt_profundidade_cm,
				qt_largura_cm,
				qt_peso_grama,
				cd_st_origem,
				id_farmacia_popular,
				id_gratis_farm_popular,
				id_permite_devolucao,
				id_geladeira,
				id_utiliza_vale_resgate,
				vl_ponto_clube,
				qt_pontos_resgate,
				cd_unidade_medida_padrao,
				vl_fator_conversao_padrao,
				de_marca,
				id_apresentacao,
				cd_fabricante,
				cd_planograma,
				cd_dcb,
				id_lei_generico,
				cd_grupo_psico	,
				cd_linha_produto,
				cd_marca_ecommerce,
				cd_cest,
				cd_tipo_prescricao,
				qt_unidades_embalagem,
				cd_marca,
				de_registro_ms,
				qt_dias_maximo_tratamento,
				vl_volume,
				qt_estoque_minimo,
				vl_reembolso_fpb,
				qt_comprimento,
				de_motivo_registro_ms_isento, 
				id_sem_gtin,
				id_farm_gov_bolsa_familia,
				cd_produto_area_atuacao,
				cd_produto_atributo,
				cd_produto_faixa_etaria,
				cd_produto_posologia,
				cd_produto_precaucoes,
				cd_produto_publico_dest,
				cd_produto_selo,
				cd_produto_texto_min_saude,
				id_contem_corante,
				id_testado_animais,
				id_vegano
	Into	:ls_cd_unidade_medida_compra,
			:ls_cd_unidade_medida_venda,
			:ls_id_situacao,
			:ll_nr_classificacao_fiscal,
			:ls_id_caderno_abcfarma,
			:ldc_vl_fator_conversao,
			:ll_nr_embalagem_padrao,
			:ls_id_liberado_filial,
			:ls_id_situacao_pis_cofins,
			:ls_cd_fornecedor_usual,
			:ls_de_produto,
			:ls_de_apresentacao_estoque,
			:ls_de_apresentacao_venda,
			:ls_id_contem_acucar,
			:ls_id_contem_gluten,
			:ls_id_contem_lactose,
			:ls_id_exclusivo,
			:ls_id_liberado_ecommerce,
			:ls_de_descricao_internet,
			:ls_de_principal_internet,
			:ldc_qt_altura_cm,
			:ldc_qt_profundidade_cm,
			:ldc_qt_largura_cm,
			:ldc_qt_peso_grama,
			:ls_cd_st_origem,
			:ls_id_farmacia_popular,
			:ls_id_gratis_farm_popular,
			:ls_id_permite_devolucao,
			:ls_id_geladeira,
			:ls_id_utiliza_vale_resgate,
			:ldc_vl_ponto_clube,
			:ll_qt_pontos_resgate,
			:ls_cd_unidade_medida_padrao,
			:ldc_vl_fator_conversao_padrao,
			:ls_de_marca,
			:ls_id_apresentacao,
			:ll_cd_fabricante,
			:ll_cd_planograma,
			:ls_cd_dcb,
			:ls_id_lei_generico,
			:ls_cd_grupo_psico,
			:ls_cd_linha_produto,
			:ll_cd_marca_ecommerce,
			:ls_cd_cest,
			:ll_cd_tipo_prescricao,
			:ll_qt_unidades_embalagem,
			:ll_cd_marca,
			:ls_de_registro_ms,
			:ll_qt_dias_maximo_tratamento,
			:ldc_vl_volume,
			:ll_qt_estoque_minimo,
			:ldc_vl_reembolso_fpb,
			:ldc_qt_comprimento,
			:ls_de_motivo_registro_ms_isento,
			:ls_id_sem_gtin,
			:ls_farm_gov_bolsa_familia,
			:ls_cd_produto_area_atuacao,
			:ls_cd_produto_atributo,
			:ls_cd_produto_faixa_etaria,
			:ls_cd_produto_posologia,
			:ls_cd_produto_precaucoes,
			:ls_cd_produto_publico_dest,
			:ls_cd_produto_selo,
			:ls_cd_produto_texto_min_saude,
			:ls_id_contem_corante,
			:ls_id_testado_animais,
			:ls_id_vegano
	From produto_geral		
	Where cd_produto = :al_produto
	Using SqlCa;
	
	Choose Case SqlCa.sqlcode
		Case 0
			
		Case 100
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto, fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_produto_geral'. Erro: "+SqlCa.sqlErrText
			Return False
		Case -1
			as_Log	= "Erro no select da tabela 'produto_geral', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_produto_geral'. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	
	If ls_cd_unidade_medida_compra	<>	is_cd_unidade_medida_compra Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_UNIDADE_MEDIDA_COMPRA", ls_cd_unidade_medida_compra, is_cd_unidade_medida_compra, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_cd_unidade_medida_venda	<>	is_cd_unidade_medida_venda Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_UNIDADE_MEDIDA_VENDA", ls_cd_unidade_medida_venda, is_cd_unidade_medida_venda, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_situacao	<>	is_id_situacao Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_SITUACAO", ls_id_situacao, is_id_situacao, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If iif(IsNull(ll_nr_classificacao_fiscal), 0,ll_nr_classificacao_fiscal) <>	iif(IsNull(il_nr_classificacao_fiscal), 0, il_nr_classificacao_fiscal) Then
		//ib_revisao_fiscal = True
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "NR_CLASSIFICACAO_FISCAL", String(ll_nr_classificacao_fiscal), String(il_nr_classificacao_fiscal), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_caderno_abcfarma	<>	is_id_caderno_abcfarma Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_CADERNO_ABCFARMA", ls_id_caderno_abcfarma, is_id_caderno_abcfarma, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_vl_fator_conversao	<>	idc_vl_fator_conversao Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "VL_FATOR_CONVERSAO", String(ldc_vl_fator_conversao), String(idc_vl_fator_conversao), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ll_nr_embalagem_padrao	<>	il_nr_embalagem_padrao Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "NR_EMBALAGEM_PADRAO", String(ll_nr_embalagem_padrao), String(il_nr_embalagem_padrao), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_liberado_filial	<>	is_id_liberado_filial Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_LIBERADO_FILIAL", ls_id_liberado_filial, is_id_liberado_filial, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
//	If ls_id_situacao_pis_cofins	<>	is_id_situacao_pis_cofins Then
//		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_SITUACAO_PIS_COFINS", ls_id_situacao_pis_cofins, is_id_situacao_pis_cofins, 'SAP001', 'A', Ref as_log, True) Then Return False
//	End If
	
	If ls_cd_fornecedor_usual	<>	is_cd_fornecedor_usual Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_FORNECEDOR_USUAL", ls_cd_fornecedor_usual, is_cd_fornecedor_usual, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_de_produto	<>	is_de_produto Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "DE_PRODUTO", ls_de_produto, is_de_produto, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_de_apresentacao_estoque	<>	is_de_apresentacao_estoque Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "DE_APRESENTACAO_ESTOQUE", ls_de_apresentacao_estoque, is_de_apresentacao_estoque, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_de_apresentacao_venda	<>	is_de_apresentacao_venda Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "DE_APRESENTACAO_VENDA", ls_de_apresentacao_venda, is_de_apresentacao_venda, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_contem_acucar	<>	is_id_contem_acucar Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_CONTEM_ACUCAR", ls_id_contem_acucar, is_id_contem_acucar, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_contem_gluten	<>	is_id_contem_gluten Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_CONTEM_GLUTEN", ls_id_contem_gluten, is_id_contem_gluten, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_contem_lactose	<>	is_id_contem_lactose Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_CONTEM_LACTOSE", ls_id_contem_lactose, is_id_contem_lactose, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_exclusivo	<>	is_id_exclusivo Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_EXCLUSIVO", ls_id_exclusivo, is_id_exclusivo, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_liberado_ecommerce	<>	is_id_liberado_ecommerce Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_LIBERADO_ECOMMERCE", ls_id_liberado_ecommerce, is_id_liberado_ecommerce, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_de_descricao_internet	<>	is_de_descricao_internet Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "DE_DESCRICAO_INTERNET", ls_de_descricao_internet, is_de_descricao_internet, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_de_principal_internet	<>	is_de_principal_internet Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "DE_PRINCIPAL_INTERNET", ls_de_principal_internet, is_de_principal_internet, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_qt_altura_cm	<>	idc_qt_altura_cm Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "QT_ALTURA_CM", String(ldc_qt_altura_cm), String(idc_qt_altura_cm), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_qt_profundidade_cm	<>	idc_qt_profundidade_cm Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "QT_PROFUNDIDADE_CM", String(ldc_qt_profundidade_cm), String(idc_qt_profundidade_cm), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_qt_largura_cm	<>	idc_qt_largura_cm Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "QT_LARGURA_CM", String(ldc_qt_largura_cm), String(idc_qt_largura_cm), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_qt_peso_grama	<>	idc_qt_peso_grama Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "QT_PESO_GRAMA", String(ldc_qt_peso_grama), String(idc_qt_peso_grama), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_cd_st_origem	<>	is_cd_st_origem Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_ST_ORIGEM", ls_cd_st_origem, is_cd_st_origem, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_farmacia_popular	<>	is_id_farmacia_popular Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_FARMACIA_POPULAR", ls_id_farmacia_popular, is_id_farmacia_popular, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_gratis_farm_popular		<>	is_id_gratis_farm_popular Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_GRATIS_FARM_POPULAR", ls_id_gratis_farm_popular, is_id_gratis_farm_popular, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_permite_devolucao	<>	is_id_permite_devolucao Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_PERMITE_DEVOLUCAO", ls_id_permite_devolucao, is_id_permite_devolucao, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_geladeira	<>	is_id_geladeira Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_GELADEIRA", ls_id_geladeira, is_id_geladeira, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_utiliza_vale_resgate	<>	is_id_utiliza_vale_resgate Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_UTILIZA_VALE_RESGATE", ls_id_utiliza_vale_resgate, is_id_utiliza_vale_resgate, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_vl_ponto_clube	<>	idc_vl_ponto_clube Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "VL_PONTO_CLUBE", String(ldc_vl_ponto_clube), String(idc_vl_ponto_clube), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ll_qt_pontos_resgate	<>	il_qt_pontos_resgate Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "QT_PONTOS_RESGATE", String(ll_qt_pontos_resgate), String(il_qt_pontos_resgate), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_cd_unidade_medida_padrao	<>	is_cd_unidade_medida_padrao Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_UNIDADE_MEDIDA_PADRAO", ls_cd_unidade_medida_padrao, is_cd_unidade_medida_padrao, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_vl_fator_conversao_padrao	<>	idc_vl_fator_conversao_padrao Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "VL_FATOR_CONVERSAO_PADRAO", String(ldc_vl_fator_conversao_padrao), String(idc_vl_fator_conversao_padrao), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_de_marca	<>	is_de_marca Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "DE_MARCA", ls_de_marca, is_de_marca, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_apresentacao	<>	is_id_apresentacao Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_APRESENTACAO", ls_id_apresentacao, is_id_apresentacao, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ll_cd_fabricante	<>	il_cd_fabricante Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_FABRICANTE", String(ll_cd_fabricante), String(il_cd_fabricante), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ll_cd_planograma	<>	il_cd_planograma Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_PLANOGRAMA", String(ll_cd_planograma), String(il_cd_planograma), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_cd_dcb	<>	is_cd_dcb Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_DCB", ls_cd_dcb, is_cd_dcb, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If iif(IsNull(ls_id_lei_generico), 'X', ls_id_lei_generico) <>	iif(IsNull(is_id_lei_generico), 'X', is_id_lei_generico)  Then
		//ib_revisao_fiscal = True
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_LEI_GENERICO", ls_id_lei_generico, is_id_lei_generico, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_cd_grupo_psico	<>	is_cd_grupo_psico Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_GRUPO_PSICO", ls_cd_grupo_psico, is_cd_grupo_psico, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_cd_linha_produto	<>	is_cd_linha_produto Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_LINHA_PRODUTO", ls_cd_linha_produto, is_cd_linha_produto, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ll_cd_marca_ecommerce	<>	il_cd_marca_ecommerce Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_MARCA_ECOMMERCE", String(ll_cd_marca_ecommerce), String(il_cd_marca_ecommerce), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
//	If ls_cd_cest	<>	is_cd_cest Then
//		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_CEST", ls_cd_cest, is_cd_cest, 'SAP001', 'A', Ref as_log, True) Then Return False
//	End If
	
	If ll_cd_tipo_prescricao	<>	il_cd_tipo_prescricao Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_TIPO_PRESCRICAO", String(ll_cd_tipo_prescricao), String(il_cd_tipo_prescricao), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ll_qt_unidades_embalagem	<>	il_qt_unidades_embalagem Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "QT_UNIDADES_EMBALAGEM", String(ll_qt_unidades_embalagem), String(il_qt_unidades_embalagem), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ll_cd_marca	<>	il_cd_marca Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "CD_MARCA", String(ll_cd_marca), String(il_cd_marca), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_de_registro_ms	<>	is_de_registro_ms Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "DE_REGISTRO_MS", ls_de_registro_ms, is_de_registro_ms, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_de_motivo_registro_ms_isento	<>	is_de_motivo_registro_ms_isento Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "DE_MOTIVO_REGISTRO_MS_ISENTO", ls_de_motivo_registro_ms_isento, is_de_motivo_registro_ms_isento, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ll_qt_dias_maximo_tratamento	<>	il_qt_dias_maximo_tratamento Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "QT_DIAS_MAXIMO_TRATAMENTO", String(ll_qt_dias_maximo_tratamento), String(il_qt_dias_maximo_tratamento), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_vl_volume	<>	idc_vl_volume Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "VL_VOLUME", String(ldc_vl_volume), String(idc_vl_volume), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ll_qt_estoque_minimo	<>	il_qt_estoque_minimo Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "QT_ESTOQUE_MINIMO", String(ll_qt_estoque_minimo), String(il_qt_estoque_minimo), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_vl_reembolso_fpb	<>	idc_vl_reembolso_fpb Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "VL_REEMBOLSO_FPB", String(ldc_vl_reembolso_fpb), String(idc_vl_reembolso_fpb), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_qt_comprimento	<>	idc_qt_comprimento Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "QT_COMPRIMENTO", String(ldc_qt_comprimento), String(idc_qt_comprimento), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If iif(IsNull(ls_id_sem_gtin), 'X', ls_id_sem_gtin) <>	iif(IsNull(is_id_sem_gtin), 'X', is_id_sem_gtin)  Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_SEM_GTIN", ls_id_sem_gtin, is_id_sem_gtin, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_farm_gov_bolsa_familia	<>	is_farm_gov_bolsa_familia Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_GERAL", String(al_produto), "ID_FARM_GOV_BOLSA_FAMILIA", ls_farm_gov_bolsa_familia, is_farm_gov_bolsa_familia, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_cd_produto_area_atuacao <> is_cd_produto_area_atuacao or IsNull (ls_cd_produto_area_atuacao) <> IsNull (is_cd_produto_area_atuacao) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'CD_PRODUTO_AREA_ATUACAO', ls_cd_produto_area_atuacao, is_cd_produto_area_atuacao, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If ls_cd_produto_atributo <> is_cd_produto_atributo or IsNull (ls_cd_produto_atributo) <> IsNull (is_cd_produto_atributo) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'CD_PRODUTO_ATRIBUTO', ls_cd_produto_atributo, is_cd_produto_atributo, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If ls_cd_produto_faixa_etaria	<>	is_cd_produto_faixa_etaria or IsNull (ls_cd_produto_faixa_etaria) <> IsNull (is_cd_produto_faixa_etaria) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'CD_PRODUTO_FAIXA_ETARIA', ls_cd_produto_faixa_etaria, is_cd_produto_faixa_etaria, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If ls_cd_produto_posologia	<>	is_cd_produto_posologia or IsNull (ls_cd_produto_posologia) <> IsNull (is_cd_produto_posologia) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'CD_PRODUTO_POSOLOGIA', ls_cd_produto_posologia, is_cd_produto_posologia, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If ls_cd_produto_precaucoes <> is_cd_produto_precaucoes or IsNull (ls_cd_produto_precaucoes) <> IsNull (is_cd_produto_precaucoes) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'CD_PRODUTO_PRECAUCOES', ls_cd_produto_precaucoes, is_cd_produto_precaucoes, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If ls_cd_produto_publico_dest <> is_cd_produto_publico_dest or IsNull (ls_cd_produto_publico_dest) <> IsNull (is_cd_produto_publico_dest) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'CD_PRODUTO_PUBLICO_DEST', ls_cd_produto_publico_dest, is_cd_produto_publico_dest, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If ls_cd_produto_selo <> is_cd_produto_selo or IsNull (ls_cd_produto_selo) <> IsNull (is_cd_produto_selo) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'CD_PRODUTO_SELO', ls_cd_produto_selo, is_cd_produto_selo, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If ls_cd_produto_texto_min_saude <> is_cd_produto_texto_min_saude or IsNull (ls_cd_produto_texto_min_saude) <> IsNull (is_cd_produto_texto_min_saude) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'CD_PRODUTO_TEXTO_MIN_SAUDE', ls_cd_produto_texto_min_saude, is_cd_produto_texto_min_saude, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If Iif (IsNull (ls_id_contem_corante), 'X', ls_id_contem_corante) <> Iif (IsNull (is_id_contem_corante), 'X', is_id_contem_corante) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'ID_CONTEM_CORANTE', ls_id_contem_corante, is_id_contem_corante, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If Iif (IsNull (ls_id_testado_animais), 'X', ls_id_testado_animais) <> Iif (IsNull (is_id_testado_animais), 'X', is_id_testado_animais) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'ID_TESTADO_ANIMAIS', ls_id_testado_animais, is_id_testado_animais, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If Iif (IsNull (ls_id_vegano), 'X', ls_id_vegano) <> Iif (IsNull (is_id_vegano), 'X', is_id_vegano) then
		If Not gf_Grava_Historico_Alteracao_Tabela ('PRODUTO_GERAL', String (al_produto), 'ID_VEGANO', ls_id_vegano, is_id_vegano, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_produto_geral'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True
end function

public function boolean of_grava_historico_produto_central (long al_produto, ref string as_log);String		ls_id_sugere_pedido_filial,&
			ls_id_projeto_conexao,&
			ls_de_historico_fiscal, &
			ls_id_lib_marketing_externo, &
			ls_id_lib_marketing_interno

Decimal	ldc_qt_altura_cm_caixa_forn,&
			ldc_qt_largura_cm_caixa_forn,&
			ldc_qt_profundidade_cm_caixa_forn,&
			ldc_qt_altura_cm_caixa_estoque,&
			ldc_qt_largura_cm_caixa_estoque,&
			ldc_qt_profund_cm_caixa_estoque	
			
Try			
	
	Select		id_sugere_pedido_filial,
				qt_altura_cm_caixa_forn,
				qt_largura_cm_caixa_forn,
				qt_profundidade_cm_caixa_forn,
				qt_altura_cm_caixa_estoque,
				qt_largura_cm_caixa_estoque,
				qt_profund_cm_caixa_estoque,
				id_projeto_conexao,
				de_historico_fiscal,
				id_lib_marketing_externo,
				id_lib_marketing_interno		
	Into	:ls_id_sugere_pedido_filial,
			:ldc_qt_altura_cm_caixa_forn,
			:ldc_qt_largura_cm_caixa_forn,
			:ldc_qt_profundidade_cm_caixa_forn,
			:ldc_qt_altura_cm_caixa_estoque,
			:ldc_qt_largura_cm_caixa_estoque,
			:ldc_qt_profund_cm_caixa_estoque,
			:ls_id_projeto_conexao,
			:ls_de_historico_fiscal,
			:ls_id_lib_marketing_externo,
			:ls_id_lib_marketing_interno	
	From produto_central		
	Where cd_produto = :al_produto
	Using SqlCa;
	
	Choose Case SqlCa.sqlcode
		Case 0
			
		Case 100
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto, fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_produto_central'. Erro: "+SqlCa.sqlErrText
			Return False
		Case -1
			as_Log	= "Erro no select da tabela 'produto_central', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_produto_central'. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	
	If ls_id_sugere_pedido_filial	<>	is_id_sugere_pedido_filial Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "ID_SUGERE_PEDIDO_FILIAL", ls_id_sugere_pedido_filial, is_id_sugere_pedido_filial, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
//	If ldc_qt_altura_cm_caixa_forn	<>	idc_qt_altura_cm_caixa_forn Then
//		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "QT_ALTURA_CM_CAIXA_FORN", String(ldc_qt_altura_cm_caixa_forn), String(idc_qt_altura_cm_caixa_forn), 'SAP001', 'A', Ref as_log, True) Then Return False
//	End If
	
//	If ldc_qt_largura_cm_caixa_forn	<>	idc_qt_largura_cm_caixa_forn Then
//		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "QT_LARGURA_CM_CAIXA_FORN", String(ldc_qt_largura_cm_caixa_forn), String(idc_qt_largura_cm_caixa_forn), 'SAP001', 'A', Ref as_log, True) Then Return False
//	End If
	
//	If ldc_qt_profundidade_cm_caixa_forn	<>	idc_qt_profundidade_cm_caixa_forn Then
//		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "QT_PROFUNDIDADE_CM_CAIXA_FORN", String(ldc_qt_profundidade_cm_caixa_forn), String(idc_qt_profundidade_cm_caixa_forn), 'SAP001', 'A', Ref as_log, True) Then Return False
//	End If
	
	If ldc_qt_altura_cm_caixa_estoque	<>	idc_qt_altura_cm_caixa_estoque Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "QT_ALTURA_CM_CAIXA_ESTOQUE", String(ldc_qt_altura_cm_caixa_estoque), String(idc_qt_altura_cm_caixa_estoque), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_qt_largura_cm_caixa_estoque	<>	idc_qt_largura_cm_caixa_estoque Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "QT_LARGURA_CM_CAIXA_ESTOQUE", String(ldc_qt_largura_cm_caixa_estoque), String(idc_qt_largura_cm_caixa_estoque), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ldc_qt_profund_cm_caixa_estoque	<>	idc_qt_profund_cm_caixa_estoque Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "QT_PROFUND_CM_CAIXA_ESTOQUE", String(ldc_qt_profund_cm_caixa_estoque), String(idc_qt_profund_cm_caixa_estoque), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_id_projeto_conexao	<>	is_id_projeto_conexao Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "ID_PROJETO_CONEXAO", ls_id_projeto_conexao, is_id_projeto_conexao, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If ls_de_historico_fiscal	<>	is_de_historico_fiscal Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "DE_HISTORICO_FISCAL", ls_de_historico_fiscal, is_de_historico_fiscal, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If ls_id_lib_marketing_externo <> is_id_lib_marketing_externo Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "ID_LIB_MARKETING_EXTERNO", ls_id_lib_marketing_externo, is_id_lib_marketing_externo, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

	If ls_id_lib_marketing_interno <> is_id_lib_marketing_interno Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(al_produto), "ID_LIB_MARKETING_INTERNO", ls_id_lib_marketing_interno, is_id_lib_marketing_interno, 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_produto_geral'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True
end function

public function boolean of_insere_codigo_barras (ref long al_produto, ref boolean ab_produto_novo, ref string as_log);Long ll_Produto
Long ll_Linha 
Long ll_Linhas
Long ll_Achou
Long ll_Find

String ls_EAN
String ls_Principal
String ls_Principal_Legado
String ls_UM
String ls_UM_Legado
String ls_Principal_SAP
String ls_Principal_SAP_Legado

Try
	
	If Not ab_produto_novo Then
		If Not of_verifica_ean_cadastrados(al_Produto, Ref as_Log) Then Return False
	End If
	
	ll_Linhas = ids_ean_cad.RowCount()
		
	If ll_Linhas > 0 Then
		
		ids_ean_cad.Sort()
				
		// Verificar se existe algum produto cadastrado no legado com o c$$HEX1$$f300$$ENDHEX$$digo de EAN recebido do SAP
		For ll_Linha = 1 To ll_Linhas
			
			ls_EAN 					= ids_ean_cad.Object.de_ean						[ll_Linha]
			ls_Principal 				= ids_ean_cad.Object.id_principal					[ll_Linha]
			ls_UM						= ids_ean_cad.Object.cd_unidade_alternativa	[ll_Linha]
			ls_Principal_SAP	 	= ids_ean_cad.Object.id_principal_sap			[ll_Linha]
						
			If Trim(ls_EAN) = '' Or IsNull(ls_EAN) Then Continue
			If IsNull(ls_Principal) Then ls_Principal = 'N'
			
			If ls_Principal = 'N' Then
				
				ll_Find = ids_ean_cad	.Find("id_principal = 'S'", 1, ids_ean_cad.RowCount())
				
				// N$$HEX1$$e300$$ENDHEX$$o existe material marcado como principal, isso acontece quando n$$HEX1$$e300$$ENDHEX$$o existe EAN cadastrado no SAP.
				If ll_Find = 0 Then
					ls_Principal = 'S' 
				End If
				
				If ll_Find < 0 Then
					as_Log	= "Erro no FIND ao procurar o cadastro principal."
					Return False
				End If				
				
			End If
			
			// Se for uma atualiza$$HEX2$$e700e300$$ENDHEX$$o e almoxarifado
			If Not ab_produto_novo and Mid(is_SubCategoria, 1,1) = '5' Then 
				If Pos(ls_EAN, String(al_Produto)) > 0 Then
					ls_EAN = Right('0000000000000' + ls_EAN, 13) 
				End If
			End If
			
			Select c.cd_produto, c.id_principal, coalesce(c.cd_unidade_medida_venda, 'X'), coalesce(c.id_principal_sap, 'X')
			Into :ll_Achou, :ls_Principal_Legado, :ls_UM_Legado, :ls_Principal_SAP_Legado
			from codigo_barras_produto c
			where c.de_codigo_barras = :ls_EAN
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					
					If ab_produto_novo Then
						as_Log	= "Foi encontrado o produto '" + String(ll_Achou) + "' para o EAN cadastrado no SAP '" + ls_EAN + "'."
						Return False
					Else
						If (ls_Principal <> ls_Principal_Legado) or (ls_UM <> ls_UM_Legado) or (ls_Principal_SAP <> ls_Principal_SAP_Legado)  Then
							Update codigo_barras_produto
							Set id_principal = :ls_Principal, cd_unidade_medida_venda = :ls_UM, id_principal_sap = :ls_Principal_SAP
							where de_codigo_barras = :ls_EAN
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
								as_Log	= "Erro ao marcar/desmarcar o EAN principal. Erro: "+SqlCa.sqlErrText
								Return False
							End If
						End If
					End If
					
				Case 100
					
					INSERT INTO codigo_barras_produto (de_codigo_barras,cd_produto,id_principal,nr_matricula_atualizacao,dh_atualizacao, cd_unidade_medida_venda, id_principal_sap )  
					VALUES (:ls_EAN,:al_produto,:ls_Principal,:is_Usuario_SAP,getdate(), :ls_UM, :ls_Principal_SAP)
					USING SqlCA;
					
					If SqlCa.SqlCode = -1 Then
						as_Log	= "Erro no select da tabela 'CODIGO_BARRAS_PRODUTO'. Erro: "+SqlCa.sqlErrText
						Return False
					End If
					
				Case -1
					as_Log	= "Erro ao localizar o produto utilizando o c$$HEX1$$f300$$ENDHEX$$digo de barras. Erro: "+SqlCa.sqlErrText
					Return False
			End Choose
			
		Next
			
	End If
		
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_codigo_barras'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True

end function

public function boolean of_cadastra_comissao (long al_produto, long al_tipo_comissao, ref string as_log);Long ll_Comissao_SAP

Date ldh_Inicio_Comissao

Decimal ldc_Comissao_SAP
Decimal ldc_Comissao

String ls_Tipo

If gvo_Aplicacao.ivs_DataSource = 'central' Then
	If Not lf_ge486_inicio_comissao_sap(ref ldh_Inicio_Comissao, as_log) Then Return False	
	// N$$HEX1$$e300$$ENDHEX$$o faz nada
	If ldh_Inicio_Comissao > Date(gf_GetServerDate()) Then Return True
End If

Select count(*) 
Into :ll_Comissao_SAP
From tipo_comissao_produto_sap 
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao verificar se a comiss$$HEX1$$e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ esta descendo pela VKP5 (SAP)." + " Erro: "+SqlCa.sqlErrText
	Return False
End If

// J$$HEX1$$e100$$ENDHEX$$ come$$HEX1$$e700$$ENDHEX$$ou a descer a comiss$$HEX1$$e300$$ENDHEX$$o atrav$$HEX1$$e900$$ENDHEX$$s da VKP5
If ll_Comissao_SAP > 0 Then Return True	

If al_tipo_comissao = 1 Then
	ldc_Comissao_SAP = idc_pc_comissao_normal
	ls_Tipo				 = "NORMAL"
Else
	ldc_Comissao_SAP = idc_pc_comissao_seletiva
	ls_Tipo				 = "SELETIVA"
End If

If IsNull(ldc_Comissao_SAP) Then ldc_Comissao_SAP = 0.00

Select pc_comissao 
Into :ldc_Comissao
From tipo_comissao_produto
Where cd_produto 		 = :al_produto
    and cd_tipo_comissao = :al_tipo_comissao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		// Atualiza
		If ldc_Comissao <> ldc_Comissao_SAP Then
			// Se a comiss$$HEX1$$e300$$ENDHEX$$o que estiver sendo imputada for zerada faz a exclus$$HEX1$$e300$$ENDHEX$$o
			If ldc_Comissao_SAP = 0  Then
				Delete From tipo_comissao_produto
				WHERE cd_produto 			= :al_produto
					AND cd_tipo_comissao 	= :al_tipo_comissao
				USING SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Log	= "Erro ao excluir o percentual de comiss$$HEX1$$e300$$ENDHEX$$o do tipo " + ls_Tipo + "." + " Erro: "+SqlCa.sqlErrText
					Return False
				End If					
			Else
				UPDATE tipo_comissao_produto  
					  SET pc_comissao = :ldc_Comissao_SAP
				WHERE cd_produto 			= :al_produto
					AND cd_tipo_comissao 	= :al_tipo_comissao
				USING SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Log	= "Erro ao atualizar o percentual de comiss$$HEX1$$e300$$ENDHEX$$o do tipo " + ls_Tipo + "." + " Erro: "+SqlCa.sqlErrText
					Return False
				End If	
			End If
			
			If Not gf_Grava_Historico_Alteracao_Tabela("TIPO_COMISSAO_PRODUTO", String(al_produto), "PC_COMISSAO", String(ldc_Comissao), String(ldc_Comissao_SAP), 'SAP001', 'A', Ref as_log, True) Then Return False
		Else
			// Se a comiss$$HEX1$$e300$$ENDHEX$$o atual fo zerada, exclui
			If ldc_Comissao = 0 Then
				Delete From tipo_comissao_produto
				WHERE cd_produto 			= :al_produto
					AND cd_tipo_comissao 	= :al_tipo_comissao
				USING SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Log	= "Erro ao excluir o percentual de comiss$$HEX1$$e300$$ENDHEX$$o do tipo " + ls_Tipo + "." + " Erro: "+SqlCa.sqlErrText
					Return False
				End If	
			End If
		End If
		
	Case 100
		
		If ldc_Comissao_SAP > 0 Then
			INSERT INTO tipo_comissao_produto ( cd_produto, cd_tipo_comissao, pc_comissao )  
			VALUES ( :al_produto, :al_tipo_comissao, :ldc_Comissao_SAP )
			USING SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao incluir o percentual de comiss$$HEX1$$e300$$ENDHEX$$o do tipo " + ls_Tipo + "." + " Erro: "+SqlCa.sqlErrText
				Return False
			End If	
		End If
		
	Case -1
		as_Log	= "Erro ao localizar o percentual de comiss$$HEX1$$e300$$ENDHEX$$o do tipo " + ls_Tipo + "." + " Erro: "+SqlCa.sqlErrText
		Return False
End Choose

Return True
end function

public function string of_retorna_valor ();return 'xx'
end function

public function boolean of_verifica_ean_cadastrados (long al_produto, ref string as_log);Long ll_Linhas
Long ll_Linha
Long ll_Find

String ls_Ean

Try
	ll_Linhas = ids_ean_cadastrados.Retrieve(al_Produto)
		
	If ll_Linhas > 0 Then
		
		// Verificar se existe algum produto cadastrado no legado com o c$$HEX1$$f300$$ENDHEX$$digo de EAN recebido do SAP
		For ll_Linha = 1 To ll_Linhas
			
			ls_EAN = ids_ean_cadastrados.Object.de_codigo_barras	[ll_Linha]
			
			// Localiza na lista que veio do SAP
			ll_Find = ids_ean_cad.Find("de_ean = '" + ls_EAN + "'",1, ids_ean_cad.RowCount())
			
			// Se o EAN existente no legado n$$HEX1$$e300$$ENDHEX$$o existir na lista do SAP, significa que o EAN foi excluido no SAP
			If ll_Find = 0 Then
				Delete From codigo_barras_produto
				Where de_codigo_barras = :ls_EAN
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Log	= "Erro ao excluir o c$$HEX1$$f300$$ENDHEX$$digo de barras. Erro: "+SqlCa.sqlErrText
					Return False
				End If	
			ElseIf ll_Find < 0 Then
				as_Log	= "Erro no find  'of_verifica_ean_cadastrados'."
				Return False
			End If
			
		Next
	Else
		//as_Log	= "Erro ao carregar os c$$HEX1$$f300$$ENDHEX$$digos de barras do material no legado."
		//Return False	
	End If
		
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_verifica_ean_cadastrados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True
end function

public function boolean of_verifica_ncm (ref string as_log);Long ll_Achou	
	
If isnull(il_nr_classificacao_fiscal) Then 
	as_Log	= "Campo nr_classificacao_fiscal est$$HEX1$$e100$$ENDHEX$$ Nulo, n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel verificar o NCM."
	Return False	
End If

Select  count(nr_ncm)
Into :ll_Achou
from ncm_uf
where nr_ncm = :il_nr_classificacao_fiscal
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
		as_Log	= "Erro ao localizar o NCM v$$HEX1$$e100$$ENDHEX$$lido."
		Return False
End Choose

If ll_Achou = 0 Then
	as_Log	= "NCM  '" + STring(il_nr_classificacao_fiscal) + "' + n$$HEX1$$e300$$ENDHEX$$o localizado na banco de dados do legado."
	Return False
End If

Return True
end function

public function boolean of_valida_minimo_pbm (ref string as_log);Long ll_Fator
Long ll_Qt_Est_Min

ll_Fator			= Long(idc_Vl_Fator_Conversao)
ll_Qt_Est_Min	= il_qt_estoque_minimo

If Mod(ll_Qt_Est_Min, ll_Fator) <> 0 Then
	as_log = "O estoque m$$HEX1$$ed00$$ENDHEX$$nimo PBM deve ser m$$HEX1$$fa00$$ENDHEX$$ltiplo do fator de convers$$HEX1$$e300$$ENDHEX$$o '" + String(ll_Fator) + "' utilizado no estoque central."
	Return False
End If

If ll_Fator > 1 Then
	If ll_Qt_Est_Min > ll_Fator Then
		as_log = "Produto possui fator de convers$$HEX1$$e300$$ENDHEX$$o. A quantidade do estoque m$$HEX1$$ed00$$ENDHEX$$nimo PBM dever$$HEX1$$e100$$ENDHEX$$ ser igual ao fator de convers$$HEX1$$e300$$ENDHEX$$o '" + String(ll_Fator) + "'."
		Return False
	End If
Else
	/*If ll_Qt_Est_Min > 6 Then
		as_log = "A quantidade de estoque m$$HEX1$$ed00$$ENDHEX$$nimo PBM n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que 4."
		Return False
		End If	
	*/
End If

Return True
end function

public function boolean of_carrega_ean_dimensoes_un (boolean ab_produto_novo, long al_produto, ref string as_log);Boolean lb_Principal = False
Boolean lb_Fat_Conv = False
Boolean lb_CX_Embarque = False

Long ll_Linhas
Long ll_Linha
Long ll_Find

String ls_EAN
String ls_Principal_Original
String ls_Alternativa
String ls_UM_Inf
String ls_UM_Peso

Decimal ldc_Altura
Decimal ldc_Largura
Decimal ldc_Profund
Decimal ldc_Peso
Decimal ldc_Qtde_Unid_Medida

Decimal ldc_Alt_CX_Estoq_Base
Decimal ldc_Larg_CX_Estoq_Base
Decimal ldc_Prof_CX_Estoq_Base
Decimal ldc_Peso_Estoque_Base

try
	
	ll_Linhas = ids_ean_cad.RowCount()
	
	ids_ean_cad.Sort()
	
	If ll_Linhas > 0 Then
		
		// Fator de convers$$HEX1$$e300$$ENDHEX$$o padr$$HEX1$$e300$$ENDHEX$$o
		idc_vl_fator_conversao 		= 1
		il_nr_embalagem_padrao 	= 1
		
		// Altera o id_principal se n$$HEX1$$e300$$ENDHEX$$o for a menor unidade
		For ll_Linha = 1 To ll_Linhas
			
			//// SOMENTE PARA MARCAR O EAN COMO PRINCIPAL
			//Se n$$HEX1$$e300$$ENDHEX$$o for a menor unidade, n$$HEX1$$e300$$ENDHEX$$o pode ser principal, com exce$$HEX2$$e700e300$$ENDHEX$$o do produto com fator de convers$$HEX1$$e300$$ENDHEX$$o pois neste caso o principal $$HEX1$$e900$$ENDHEX$$ o CXU
			If (ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha]	 <> 'UN' 		and &
				ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha]	 <> 'KTE'	and &
				ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha]	 <> 'CXU'	and &
				ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha]	 <> 'KTP')   and & 
				ids_ean_cad.Object.id_principal[ll_Linha] = 'S'	Then
				
				ids_ean_cad.Object.id_principal[ll_Linha] = 'N'
			End If
						
			//// SOMENTE PARA GARANTIR QUE AS DIMENSOES SERAO PEGAS DA MENOR UNIDADE			
			//Se n$$HEX1$$e300$$ENDHEX$$o for a menor unidade, n$$HEX1$$e300$$ENDHEX$$o pode ser principal
			// Garantir para n$$HEX1$$e300$$ENDHEX$$o pegar as dimens$$HEX1$$f500$$ENDHEX$$es da CXU, e sim da menor unidade
			If (ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha]	 <> 'UN' 		and &
				ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha]	 <> 'KTE'	and &
				ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha]	 <> 'KTP')   and & 
				ids_ean_cad.Object.id_principal_original[ll_Linha] = 'S'	Then
				
				ids_ean_cad.Object.id_principal_original[ll_Linha] = 'N'
			End If
		Next
		
		//// SOMENTE PARA MARCAR O EAN COMO PRINCIPAL
		// Se for a menor unidade e j$$HEX1$$e100$$ENDHEX$$ tiver uma CXU como principal, deixa o da CXU como principal
		For ll_Linha = 1 To ll_Linhas
			If (ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha]	 = 'UN' or ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha] = 'KTE'	or  ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha]	 = 'KTP') and ids_ean_cad.Object.id_principal[ll_Linha] = 'S' Then
				 ll_Find = ids_ean_cad.Find("cd_unidade_alternativa = 'CXU' and id_principal = 'S' ", 1, ids_ean_cad.RowCount())
				 
				 If ll_Find > 0 Then
					// Deixa de ser o principal, porque j$$HEX1$$e100$$ENDHEX$$ existe uma CXU como principal
					ids_ean_cad.Object.id_principal[ll_Linha] = 'N' 
				End If
			End If
		Next
			
		For ll_Linha = 1 To ll_Linhas
			
			ls_EAN 						= ids_ean_cad.Object.de_ean					[ll_Linha]
			ls_Principal_Original		= ids_ean_cad.Object.id_principal_original	[ll_Linha] // Somente para pegar as dimens$$HEX1$$f500$$ENDHEX$$es corretamente
			
			ls_Alternativa 				= ids_ean_cad.Object.cd_unidade_alternativa[ll_Linha]	
			ls_UM_Inf					= ids_ean_cad.Object.cd_unidade_medida_inferior[ll_Linha]
			
			ls_UM_Peso					= ids_ean_cad.Object.cd_unidade_peso[ll_Linha]
			
			ldc_Altura					= ids_ean_cad.Object.qt_altura_cm[ll_Linha]
			ldc_Largura					= ids_ean_cad.Object.qt_largura_cm[ll_Linha]
			ldc_Profund					= ids_ean_cad.Object.qt_profundidade_cm[ll_Linha]
			ldc_Peso						= ids_ean_cad.Object.qt_peso_bruto[ll_Linha]
			
			ldc_Qtde_Unid_Medida	= ids_ean_cad.Object.qt_unidade_medida_subordinada[ll_Linha]
			
//			//Se n$$HEX1$$e300$$ENDHEX$$o for a menor unidade, n$$HEX1$$e300$$ENDHEX$$o pode ser principal
//			If (ls_Alternativa <> 'UN' and ls_Alternativa <> 'KTE' and ls_Alternativa <> 'KTP') Then
//				If ls_Principal_Original = 'S' Then
//					ids_ean_cad.Object.id_principal[ll_Linha] = 'N'
//					ls_Principal_Original = 'N'
//				End If
//			End If
			
			// Em tese a menor unidade s$$HEX1$$e300$$ENDHEX$$o iguais
			If (ls_Alternativa = 'UN' or ls_Alternativa = 'KTE' or ls_Alternativa = 'KTP' ) and (ls_Alternativa = ls_UM_Inf) and (ls_Principal_Original <> 'S') Then
				ll_Find = ids_ean_cad	.Find("id_principal_original = 'S'", 1, ids_ean_cad.RowCount())
				
				// N$$HEX1$$e300$$ENDHEX$$o existe material marcado como principal, isso acontece quando n$$HEX1$$e300$$ENDHEX$$o existe EAN cadastrado no SAP.
				If ll_Find = 0 Then
					ls_Principal_Original = 'S' 
				End If
				
				If ll_Find < 0 Then
					as_Log	= "Erro no FIND ao procurar o cadastro principal."
					Return False
				End If				
			End If			
									
			If ls_Principal_Original = 'S' Then
				If ls_Alternativa <> ls_UM_Inf Then
					as_Log	= "Para o EAN principal a unidade alternativa e a inferior devem ser iguais ."
					Return False
				End If
				
				If (ls_Alternativa <> 'UN' and ls_Alternativa <> 'KTE' and ls_Alternativa <> 'KTP') Then
					as_Log	= "Unidade de venda diferente de UN/KTE/KTP."
					Return False
				End If
				
				is_cd_unidade_medida_venda = ls_Alternativa
				
				// dimensoes do ecommerce
				idc_qt_altura_cm 	 		= ldc_Altura
				idc_qt_largura_cm  		= ldc_Largura
				idc_qt_profundidade_cm = ldc_Profund
				idc_qt_peso_grama 		= ldc_Peso

				// Conforme acordado com o Felipe as dimens$$HEX1$$f500$$ENDHEX$$es de estoque s$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e300$$ENDHEX$$o alteradas que for uma inclus$$HEX1$$e300$$ENDHEX$$o nova
				If ab_produto_novo Then
					idc_qt_altura_cm_caixa_estoque 		= ldc_Altura
					idc_qt_largura_cm_caixa_estoque 		= ldc_Largura
					idc_qt_profund_cm_caixa_estoque		= ldc_Profund
					idc_qt_peso_kg_estoque					= ldc_Peso
					
					If ldc_Altura = 0 or ldc_Largura = 0 or ldc_Profund = 0 Then
						as_Log	= "Informe as dimens$$HEX1$$f500$$ENDHEX$$es do produto corretamente."
						Return False
					End If
				Else
					select c.qt_altura_cm_caixa_estoque,
							 c.qt_largura_cm_caixa_estoque, 
							 c.qt_profund_cm_caixa_estoque, 	
							 c.qt_peso_kg_estoque	
					Into :ldc_Alt_CX_Estoq_Base, 
						  :ldc_Larg_CX_Estoq_Base, 
						  :ldc_Prof_CX_Estoq_Base, 
						  :ldc_Peso_Estoque_Base
					from produto_central c
					where c.cd_produto = :al_produto
					Using SqlCa;
					
					Choose Case SqlCa.SqlCode
						Case 0
						Case 100
							as_Log	= "O produto n$$HEX1$$e300$$ENDHEX$$o foi localizado no Sybase."
							Return False
						Case -1 
							as_Log	= "Erro ao localizar produto no Sybase. Erro: "+SqlCa.sqlErrText
							Return False
						Return False
					End Choose
					
					idc_qt_altura_cm_caixa_estoque 	= ldc_Alt_CX_Estoq_Base
					idc_qt_largura_cm_caixa_estoque 	= ldc_Larg_CX_Estoq_Base
					idc_qt_profund_cm_caixa_estoque	= ldc_Prof_CX_Estoq_Base
					idc_qt_peso_kg_estoque				= ldc_Peso_Estoque_Base
					
					// Se as informa$$HEX2$$e700f500$$ENDHEX$$es atuais estiverem zeradas ou nulas, isso acontece quando o produto INATIVO(antigo) $$HEX1$$e900$$ENDHEX$$ cadastrado no SAP
					If IsNull(idc_qt_altura_cm_caixa_estoque) or idc_qt_altura_cm_caixa_estoque = 0 then
						idc_qt_altura_cm_caixa_estoque	= ldc_Altura
					End If
					
					If IsNull(idc_qt_largura_cm_caixa_estoque) or idc_qt_largura_cm_caixa_estoque = 0 then
						idc_qt_largura_cm_caixa_estoque	= ldc_Largura
					End If
					
					If IsNull(idc_qt_profund_cm_caixa_estoque) or idc_qt_profund_cm_caixa_estoque = 0 then
						idc_qt_profund_cm_caixa_estoque	= ldc_Profund
					End If
					
					If IsNull(idc_qt_peso_kg_estoque) or idc_qt_peso_kg_estoque = 0 then
						idc_qt_peso_kg_estoque	= ldc_Peso
					End If				
				End If
				
				lb_Principal = True
			Else
				// Produto com fator de convers$$HEX1$$e300$$ENDHEX$$o
				If ls_Alternativa = 'CXU' and (ls_UM_Inf = 'UN'  or ls_UM_Inf = 'KTE' or  ls_UM_Inf = 'KTP' ) Then	
					lb_Fat_Conv = True
					
					idc_vl_fator_conversao = ldc_Qtde_Unid_Medida
					
					// Neste caos os valores de altura, largura e profundidade ser$$HEX1$$e300$$ENDHEX$$o da caixa
					If ab_produto_novo Then
						idc_qt_altura_cm_caixa_estoque 		= ldc_Altura
						idc_qt_largura_cm_caixa_estoque 	= ldc_Largura
						idc_qt_profund_cm_caixa_estoque		= ldc_Profund
						idc_qt_peso_kg_estoque					= ldc_Peso
					End If					
				End If
				
				// Caixa embarque 
				If ls_Alternativa = 'CXE' and (ls_UM_Inf = 'CXU' or ls_UM_Inf = 'UN' or ls_UM_Inf = 'KTE' or ls_UM_Inf = 'KTP') Then
					 lb_CX_Embarque = True
					 il_nr_embalagem_padrao =  Long(ldc_Qtde_Unid_Medida)
					 
					 idc_qt_altura_cm_caixa_forn			= ldc_Altura
					 idc_qt_largura_cm_caixa_forn			= ldc_Largura
					 idc_qt_profundidade_cm_caixa_forn	= ldc_Profund
					 
				End If
								
			End If			
			
		Next
	
		If Not lb_Principal Then
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado unidade principal."
			Return False
		End If
		
		If Not lb_CX_Embarque then
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado unidade embarque."
			Return False
		End If
		
		If lb_Fat_Conv Then
			il_nr_embalagem_padrao = il_nr_embalagem_padrao / idc_vl_fator_conversao
		End If
		
	ElseIf ll_Linhas = 0 Then
		// Retornar com caso seja exigido o c$$HEX1$$f300$$ENDHEX$$digo de barras para o produto
	ElseIf ll_Linhas < 0 Then
//		as_Log	= "Erro ao recuperar os c$$HEX1$$f300$$ENDHEX$$digos de barras. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+"."
		Return False
	End If
	
finally
end try

Return True
end function

public function string of_texto_internet (string as_texto);String ls_Vl_Item

Long ll_Pos

ls_Vl_Item = as_texto	

If Trim(ls_Vl_Item) <> '' Then
	
	ls_Vl_Item = gf_replace(ls_Vl_Item, "ENTER/ ", "ENTER/",  0)
	ls_Vl_Item = gf_replace(ls_Vl_Item, " ENTER/", "ENTER/",  0)
	
	ls_Vl_Item = gf_replace(ls_Vl_Item, "CC/ ENTER/", "~r~n~r~n",  0)
	
	ls_Vl_Item = gf_replace(ls_Vl_Item, "ENTER/", "~r~n~r~n",  0)

	ls_Vl_Item = gf_replace(ls_Vl_Item, "CC/ ", "CC/",  0)
	ls_Vl_Item = gf_replace(ls_Vl_Item, " CC/", "CC/",  0)
	
	ll_Pos = Pos(ls_Vl_Item, "CC/")
	
	//ls_Vl_Item = gf_replace(ls_Vl_Item, "CC/", "",  0)
	
	If ll_Pos > 0 Then
		If Mid(ls_Vl_Item, ll_Pos + 3) <> '' Then
			ls_Vl_Item = gf_replace(ls_Vl_Item, "CC/", "~r~n",  0)
		Else
			ls_Vl_Item = gf_replace(ls_Vl_Item, "CC/", "",  0)
		End If
	End If
	
End If
	
Return ls_Vl_Item
end function

public function boolean of_fornecedor_divisao (long al_produto, string as_fornecedor, ref string as_log);// Faz o delete, caso contr$$HEX1$$e100$$ENDHEX$$rio se mudar o fornecedor esta ficando mais de um fornecedor para um mesmo produto
delete from fornecedor_divisao_produto
where cd_produto = :al_produto
  and cd_fornecedor <> :as_fornecedor
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	as_Log	= "Erro ao excluir a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor. Erro: "+SqlCa.sqlErrText
	Return False
End If

Return True
end function

public function boolean of_envia_sap_codigo_legado (string as_codigo_sap, string as_codigo_legado, ref string as_log);String ls_XML
String ls_AmbsAP
String ls_URL
String ls_Xml_Retorno

//ls_AmbsAP = gvo_Aplicacao.of_GetFromINI("Configuracao", "AmbienteSap")

// N$$HEX1$$e300$$ENDHEX$$o faz o envio quando for o homologa
//If (gvo_Aplicacao.ivs_DataSource <> 'central') Then
//	Return True
//End If

ls_AmbsAP = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "AmbienteSap", "")

If IsNull(ls_AmbsAP) or  Trim(ls_AmbsAP) = "" Then 
	select
		vl_parametro
	into 
		:ls_AmbsAP 
	from
		parametro_geral
	where
		cd_parametro = 'CD_AMBIENTE_SAP';
		
	Choose Case SQLCA.SQLCode
		Case -1
			as_log = 'Erro ao consultar par$$HEX1$$e200$$ENDHEX$$metro CD_AMBIENTE_SAP.~r~rErro: ' + SQLCA.SQLErrText
			Return False
		Case 100
			as_log = 'PRD'
	End Choose
End IF

// Sybase(homologa) -> SAP(produ$$HEX2$$e700e300$$ENDHEX$$o)
If (gvo_Aplicacao.ivs_DataSource <> 'central') and (ls_AmbsAP = 'PRD') Then
	as_Log = "Ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o do SYBASE n$$HEX1$$e300$$ENDHEX$$o pode atualizar na base produ$$HEX2$$e700e300$$ENDHEX$$o do SAP."
	Return False
End If

// Sybase(central) -> SAP(DEV/QAS)
If (gvo_Aplicacao.ivs_DataSource = 'central') and (ls_AmbsAP <> 'PRD') Then
	as_Log = "Ambiente de produ$$HEX2$$e700e300$$ENDHEX$$o do SYBASE n$$HEX1$$e300$$ENDHEX$$o pode atualizar na base DEV/QAS do SAP."
	Return False
End If

If Not gf_retorna_pametro_sap(SQLCA, ls_AmbsAP, 'CD_URL_PRODUTO_ENVIO', ref ls_URL, ref as_log) Then Return False

If Len(as_codigo_sap) < 18 Then
	as_codigo_sap = Right("000000000000000000" + as_codigo_sap, 18)
End If

ls_XML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">' +&
			 '<soapenv:Header/>' +&
   				'<soapenv:Body>' +&
						'<imp:MT_MAT_RET_REQ>' +&
							 '<MATERIAL_SAP>' + as_codigo_sap + '</MATERIAL_SAP>' +&
							'<MATERIAL_SYBASE>' + as_codigo_legado + '</MATERIAL_SYBASE>' +&
						'</imp:MT_MAT_RET_REQ>' +&
   				'</soapenv:Body>' +&
			'</soapenv:Envelope>'
	
If io_sap_comum.of_envia_webservice(ls_URL, ls_XML, Ref ls_Xml_Retorno, Ref as_log) Then
	If Not This.of_processa_retorno_sap(ls_Xml_Retorno, Ref as_log) Then
		If Trim(as_log) <> '' Then
			as_Log = "Retorno SAP: " + as_log
			Return False
		End If
	End If
Else
	Return False
End If	
			
Return True
end function

public function boolean of_processa_retorno_sap (string as_xml_retorno, ref string as_erro);String	ls_Status,&
		ls_Erro,&
		ls_Parte_Xml


Long	ll_Pos_1, &
		ll_Pos_2, &
		ll_Lenght

Try
	
	as_Erro = ""
	
	DO WHILE Pos(as_xml_retorno, "<ns0:MT_MAT_RET_RES xmlns:ns0='importa_sap.com'>") > 0
		
		ll_Pos_1	= Pos(as_xml_retorno, "<ns0:MT_MAT_RET_RES xmlns:ns0='importa_sap.com'>")
		ll_Pos_2	= Pos(as_xml_retorno, "</ns0:MT_MAT_RET_RES>")
		ll_Lenght	= Len( "</ns0:MT_MAT_RET_RES>")
		
		ls_Parte_Xml	= Mid(as_xml_retorno, ll_Pos_1, (ll_Pos_2 + ll_Lenght) - ll_Pos_1)

		ll_Pos_1	= Pos(ls_Parte_Xml, '<TIPO>')
		ll_Pos_2	= Pos(ls_Parte_Xml, '</TIPO>')
		ll_Lenght	= Len( '</TIPO>')		
		ls_Status = Mid(ls_Parte_Xml, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		//Atualiza$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso
		If ls_Status = "S" Then Return True
		
		ll_Pos_1	= Pos(ls_Parte_Xml, '<MENSAGEM>')
		ll_Pos_2	= Pos(ls_Parte_Xml, '</MENSAGEM>')
		ll_Lenght	= Len( '</MENSAGEM>')		
		ls_Erro = Mid(ls_Parte_Xml, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		If as_Erro = "" Then
			as_Erro = ls_Erro
		Else
			as_Erro += "~r"+ ls_Erro
		End If
		
		as_xml_retorno = gf_Replace(as_xml_retorno, ls_Parte_Xml, '', 0)	//Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida	
	
	LOOP	
	
Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_processa_retorno_sap', objeto 'uo_ge473_produto_sap'. Erro: "+lo_rte.GetMessage())
	Return False
End Try

If as_Erro = "" Then
	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o para processar o retorno."
End If
Return False
end function

public function boolean of_atualiza_produto (long al_controle);dc_uo_ds_base lds

Boolean	lb_Produto_Novo,&
			lb_Sucesso

Long	ll_Linhas,&
		ll_Linha,&
		ll_Produto,&
		ll_Nulo,&
		ll_cd_texto_min_saude
		
Long ll_Achou
		
String	ls_Coluna,&
		ls_Vl_Item,&
		ls_Obrig		
		
String ls_Log

String ls_NCM

lb_Sucesso = False

SetNull(ll_Nulo)

Select count(*)
Into :ll_Achou
From 	interface_sap
Where nr_controle = :al_controle
	 and id_situacao in ('C', 'E')
	and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	io_Comum.of_grava_erro(al_controle, 175, "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText)
	Return False
End If

If ll_Achou = 0 Then Return True

Try
	
	lds		= Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_produto_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_produto]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_controle)
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_produto_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_produto]."
		Return False
	End If
	
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_produto_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_produto]."
		Return False
	End If	
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not This.of_carrega_codigo_barra(al_controle, Ref ls_Log) Then Return False
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	
	/*
	 PRODUTO (1)
	 PRODUTO_CODIGO_BARRAS (3)
			
	*/
	
	For ll_Linha = 1 To ll_Linhas
		ls_Coluna 	= lds.Object.cd_coluna		[ll_Linha]
		ls_Vl_Item	= lds.Object.vl_item			[ll_Linha]
		ls_Obrig		= lds.Object.id_obrigatorio	[ll_Linha]
		
		If ls_Coluna <> 'de_principal_internet' and ls_coluna <> 'desc_com_prin' and ls_coluna <> 'desc_com_sec' and ls_coluna <> 'texto_legal' Then
			ls_VL_Item = Upper(ls_VL_Item)
		End If
		
		If Trim(ls_Vl_Item) = "" Then
			SetNull(ls_Vl_Item)
		End If
		
		If Not io_Comum.of_verifica_obrigatoriedade_campo(ls_Coluna, ls_Obrig, ls_Vl_Item, Ref ls_Log) Then
			Return False
		End if
		
		Choose Case  Lower(ls_Coluna)
			Case 'cd_area_atuacao'
				is_cd_produto_area_atuacao = ls_Vl_Item
				
			Case 'cd_atributo'
				is_cd_produto_atributo = ls_Vl_Item
				
			Case 'cd_cest'
			//	is_cd_cest = ls_Vl_Item
			
			Case 'cd_faixa_etaria'
				is_cd_produto_faixa_etaria = ls_Vl_Item
				
			Case 'cd_fornecedor_usual'
				is_cd_fornecedor_usual = gf_Tira_Zero_Esquerda(ls_Vl_Item)
			Case 'cd_grupo_alteracao_preco'
				il_cd_grupo_alteracao_preco = Long(ls_Vl_Item)
			Case 'cd_grupo_psico'
				is_cd_grupo_psico = ls_Vl_Item
			Case 'cd_linha_produto'
				is_cd_linha_produto = ls_Vl_Item
			Case 'cd_marca'
				il_cd_marca = Long(ls_Vl_Item)
				il_cd_marca = iif(il_cd_marca = 0, ll_Nulo, il_cd_marca)
				
			Case 'cd_posologia'
				is_cd_produto_posologia = ls_Vl_Item
				
			Case 'cd_precaucoes'
				is_cd_produto_precaucoes = ls_Vl_Item
				
			Case 'cd_publico_destinado'
				is_cd_produto_publico_dest = ls_Vl_Item
				
			Case 'cd_selo'
				is_cd_produto_selo = ls_Vl_Item
				
			Case 'cd_texto_min_saude'
				is_cd_produto_texto_min_saude = ls_Vl_Item
				
			Case 'id_contem_corante'
				is_id_contem_corante = Iif (ls_Vl_Item = 'X', 'S', ls_Vl_Item)
				
			Case 'id_marca_propria'  
				is_id_marca_propria = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)
			
			Case 'id_testado_animais'
				is_id_testado_animais = Iif (ls_Vl_Item = 'X', 'S', ls_Vl_Item)
				
			Case 'id_vegano'
				is_id_vegano = Iif (ls_Vl_Item = 'X', 'S', ls_Vl_Item)
				
			Case 'id_cobre_preco_pbm'
				is_id_cobre_preco_pbm = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)
				
			Case 'cd_marca_ecommerce'
				il_cd_marca_ecommerce = Long(ls_Vl_Item)
			Case 'cd_mix_produto'
				il_cd_mix_produto = Long(ls_Vl_Item)
			Case 'cd_produto_fornecedor'
				is_cd_produto_fornecedor = ls_Vl_Item
			Case 'cd_produto_legado'
				
				If Not IsNull(ls_Vl_Item) Then
					If IsNumber (ls_Vl_Item) Then
						il_cd_produto_legado = Long(ls_Vl_Item)
					Else
						ls_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do material do legado informado no SAP deve conter apenas n$$HEX1$$fa00$$ENDHEX$$meros."
						Return False
					End If
				End If
				
			Case 'cd_produto_sap'
				is_cd_produto_sap = gf_Tira_Zero_Esquerda(ls_Vl_Item)
				
				If IsNull(is_cd_produto_sap) or trim(is_cd_produto_sap) = '' Then
					ls_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do material do SAP n$$HEX1$$e300$$ENDHEX$$o pode ser nulo ou branco."
					Return False
				End If
				
				If Not IsNumber(is_cd_produto_sap) Then
					ls_Log = "O c$$HEX1$$f300$$ENDHEX$$digo do material do SAP deve conter apenas n$$HEX1$$fa00$$ENDHEX$$meros."
					Return False
				End If
				
				If Len(is_cd_produto_sap) <> 10 and Len(is_cd_produto_sap) <> 13 Then
					ls_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do material do SAP deve conter 10 ou 13 caracteres."
					Return False
				End If
				
			Case 'cd_produto_sap_generico'
				is_cd_produto_sap_generico = gf_Tira_Zero_Esquerda(ls_Vl_Item)
				
				if Trim(is_cd_produto_sap_generico) = '' Then
					setnull(is_cd_produto_sap_generico)
				end if
				
			Case 'cd_prod_referencia_preco'
				is_cd_prod_referencia_preco = ls_Vl_Item
			Case 'cd_segmento_ims'
				is_cd_segmento_ims = ls_Vl_Item
			Case 'cd_st_origem'
				is_cd_st_origem = ls_Vl_Item
				
			Case 'cd_tipo_alerta_restricao'
				If (ls_Vl_Item <> '000' and ls_Vl_Item <> 'XXX') Then
					il_cd_tipo_alerta_restricao = Long(ls_Vl_Item)
				End If
			Case 'de_tipo_alerta_restricao'
				is_de_tipo_alerta_restricao = ls_Vl_Item
				
			Case 'id_apresentacao'
				is_id_apresentacao = ls_Vl_Item			
				If Not IsNull(is_id_apresentacao) and Len(is_id_apresentacao) > 2 Then
					ls_Log	= "ID Apresenta$$HEX2$$e700e300$$ENDHEX$$o maior do que o esperado. Espera-se 2 Caracteres (ex: 01), mas est$$HEX1$$e100$$ENDHEX$$ vindo: " + is_id_apresentacao
					Return False
				End If
			Case 'de_tipo_apresentacao'
				is_de_tipo_apresentacao = ls_Vl_Item
			
			Case 'cd_fabricante'
				il_cd_fabricante = Long(ls_Vl_Item)
			Case 'nr_cgc_fabricante'
				is_nr_cnpj_fabricante = ls_Vl_Item
			Case 'nm_razao_social_fabricante'
				is_nm_razao_social_fabricante = ls_Vl_Item
				
			Case 'cd_planograma'
				il_cd_planograma = Long(ls_Vl_Item)
			Case 'de_planograma'
				is_de_planograma = ls_Vl_Item
				
			Case 'cd_dcb'
				is_cd_dcb = ls_Vl_Item
			Case 'de_dcb'
				is_de_dcb = ls_Vl_Item
			Case 'nr_cas_dcb'
				is_nr_cas_dcb = ls_Vl_Item
			Case 'qt_dosagem_maxima_dcb'
				//idc_qt_dosagem_maxima_dcb = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'DOSAGEM MAXIMA DCB', ref idc_qt_dosagem_maxima_dcb, ref ls_Log) Then Return False
			Case 'qt_dosagem_minima_dcb'
				//idc_qt_dosagem_minima_dcb = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'DOSAGEM M$$HEX1$$cd00$$ENDHEX$$NIMA DCB', ref idc_qt_dosagem_minima_dcb, ref ls_Log) Then Return False
				
			Case 'id_lei_generico'
				is_id_lei_generico = ls_Vl_Item
			Case 'de_lei_generico'
				is_de_lei_generico = ls_Vl_Item
			
			Case 'cd_tipo_prescricao'
				il_cd_tipo_prescricao = Long(ls_Vl_Item)
			Case 'cd_tipo_produto_pricing'
				il_cd_tipo_produto_pricing = Long(ls_Vl_Item)
			Case 'cd_categ_mercadologica'
				il_cd_categ_mercadologica = long(ls_vl_item)
				
				if  il_cd_categ_mercadologica = 0 Then setnull(il_cd_categ_mercadologica)
				
			Case 'cd_unidade_medida_compra'
				is_cd_unidade_medida_compra = ls_Vl_Item
				
			Case 'cd_unidade_medida_padrao'
				is_cd_unidade_medida_padrao = ls_Vl_Item
			Case 'cd_unidade_medida_venda'
				is_cd_unidade_medida_venda = ls_Vl_Item
				
				If Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' Then
					If is_cd_unidade_medida_venda = 'L' Then is_cd_unidade_medida_venda = 'LT' 
					If is_cd_unidade_medida_venda = 'M' Then is_cd_unidade_medida_venda = 'MT' 
				End If
				
			Case 'de_apresentacao_estoque'
				is_de_apresentacao_estoque = ls_Vl_Item
			Case 'de_apresentacao_venda'
				is_de_apresentacao_venda = ls_Vl_Item
			Case 'de_cest'
				is_de_cest = ls_Vl_Item
			Case 'de_codigo_barras'
				is_de_codigo_barras = ls_Vl_Item
			Case 'de_grupo_alteracao_preco'
				is_de_grupo_alteracao_preco = ls_Vl_Item
			Case 'de_grupo_psico'
				is_de_grupo_psico = ls_Vl_Item
			Case 'de_historico_fiscal'
				is_de_historico_fiscal = ls_Vl_Item
			Case 'de_linha_produto'
				is_de_linha_produto = ls_Vl_Item
			Case 'de_marca'
				is_de_marca = ls_Vl_Item
			Case 'de_marca_ecommerce'
				is_de_marca_ecommerce = ls_Vl_Item
			Case 'de_mix_produto'
				is_de_mix_produto = ls_Vl_Item
			Case 'de_produto'
				is_de_produto = ls_Vl_Item
			Case 'de_registro_ms'
				is_de_registro_ms = ls_Vl_Item
				
				If Trim(Upper(is_de_registro_ms)) = 'ISENTO' Then
					SetNull(is_de_registro_ms)
				End If
			Case 'de_motivo_registro_ms_isento'
				is_de_motivo_registro_ms_isento = ls_Vl_Item
				
				If Trim(is_de_motivo_registro_ms_isento) = '' Then
					SetNull(is_de_motivo_registro_ms_isento)
				End If
				
			Case 'de_segmento_ims'
				is_de_segmento_ims = ls_Vl_Item
			Case 'de_situacao_pis_cofins'
//				Foi retirado porque no legado a lista $$HEX1$$e900$$ENDHEX$$ conform o ncm
//				is_de_situacao_pis_cofins = ls_Vl_Item
			Case 'de_tipo_prescricao'
				is_de_tipo_prescricao = ls_Vl_Item
			Case 'de_tipo_produto_pricing'
				is_de_tipo_produto_pricing = ls_Vl_Item
			Case 'de_tipo_reposicao_estoque'
				is_de_tipo_reposicao_estoque = ls_Vl_Item
			Case 'de_tipo_un_calc_preco'
				is_de_tipo_un_calc_preco = ls_Vl_Item
			Case 'id_alt_preco_blq_farmagora'
				is_id_alt_preco_blq_farmagora = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)
			Case 'id_bloqueia_calculo_preco'
				is_id_bloqueia_calculo_preco = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)
			Case 'id_caderno_abcfarma'
				is_id_caderno_abcfarma = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_contem_acucar'
				is_id_contem_acucar = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_contem_gluten'
				is_id_contem_gluten = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_contem_lactose'
				is_id_contem_lactose = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_exclusivo'
				is_id_exclusivo = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_exclusivo_pedido_falta_ba'
				is_id_exclusivo_pedido_falta_ba =iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_farmacia_popular'
				is_id_farmacia_popular = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_geladeira'
				is_id_geladeira = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_gratis_farm_popular'
				is_id_gratis_farm_popular = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_liberado_ecommerce'
				is_id_liberado_ecommerce = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_liberado_filial'
				is_id_liberado_filial = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)
				is_id_liberado_filial = iif(isnull(is_id_liberado_filial), 'N', is_id_liberado_filial)
			Case 'id_permite_devolucao'
				is_id_permite_devolucao = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_projeto_conexao'
				is_id_projeto_conexao = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_promover_venda'
				is_id_promover_venda = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_retira_bloq_compra_distrib'
				is_id_retira_bloq_compra_distrib = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_situacao'
				is_id_situacao = ls_Vl_Item
				
				// Se tiver em branco no SAP significa que o mesmo esta ATIVO em todos os centros //2- Colocado pra vir 00 pois vazio n$$HEX1$$e300$$ENDHEX$$o vem a tag
				If IsNull(is_id_situacao) or Trim(is_id_situacao)  = '' Or is_id_situacao  = '00' Or is_id_situacao  = '04' Then is_id_situacao = 'A'
				
				If is_id_situacao <> 'A' and is_id_situacao <> '01' and is_id_situacao <> '02' and is_id_situacao <> '03' and is_id_situacao <> '04' Then
					ls_Log	= "A situa$$HEX2$$e700e300$$ENDHEX$$o do material esta diferente da esperada A(em branco SAP)/01/02/03/04."
					Return False
				End If
				
			Case 'id_situacao_pis_cofins'
				is_id_situacao_pis_cofins = ls_Vl_Item
			Case 'id_sugere_pedido_filial'
				is_id_sugere_pedido_filial = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_tipo_reposicao_estoque'
				is_id_tipo_reposicao_estoque = ls_Vl_Item
			Case 'id_tipo_un_calc_preco'
				is_id_tipo_un_calc_preco = ls_Vl_Item
			Case 'id_utiliza_vale_resgate'
				is_id_utiliza_vale_resgate = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	

			Case 'nr_classificacao_fiscal'
				ls_NCM = iif(IsNull(ls_Vl_Item), '0', ls_Vl_Item)
				ls_NCM = gf_Replace(ls_NCM, '.', '', 0)
				il_nr_classificacao_fiscal = Long(ls_NCM)
			Case 'nr_embalagem_padrao'
			Case 'pc_comissao_normal'
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PERC. COMISSAO NORMAL', ref idc_pc_comissao_normal, ref ls_Log) Then Return False
			Case 'pc_comissao_seletiva'
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PERC. COMISSAO SELETIVA', ref idc_pc_comissao_seletiva, ref ls_Log) Then Return False
			Case 'pc_desconto_conexao'
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PERC. DESC. CONEX$$HEX1$$c300$$ENDHEX$$O', ref idc_pc_desconto_conexao, ref ls_Log) Then Return False
			Case 'pc_desconto_fornecedor'
				//idc_pc_desconto_fornecedor = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PERC. DESC. FORNECEDOR', ref idc_pc_desconto_fornecedor, ref ls_Log) Then Return False
			Case 'pc_prod_referencia_preco'
				//idc_pc_prod_referencia_preco = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PERC. PRODUTO REF. PRE$$HEX1$$c700$$ENDHEX$$O', ref idc_pc_prod_referencia_preco, ref ls_Log) Then Return False
			Case 'qt_altura_cm'
				//idc_qt_altura_cm = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'ALTURA CM', ref idc_qt_altura_cm, ref ls_Log) Then Return False
			Case 'qt_altura_cm_caixa_estoque'
				//idc_qt_altura_cm_caixa_estoque = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'ALTURA CM ESTOQUE', ref idc_qt_altura_cm_caixa_estoque, ref ls_Log) Then Return False
			Case 'qt_dias_maximo_tratamento'
				il_qt_dias_maximo_tratamento = Long(ls_Vl_Item)
			Case 'qt_estoque_minimo'
				il_qt_estoque_minimo = Long(ls_Vl_Item)
			Case 'qt_largura_cm'
				//idc_qt_largura_cm = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'LARGURA CM', ref idc_qt_largura_cm, ref ls_Log) Then Return False
			Case 'qt_largura_cm_caixa_estoque'
				//idc_qt_largura_cm_caixa_estoque = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'LARGURA CM ESTOQUE', ref idc_qt_largura_cm_caixa_estoque, ref ls_Log) Then Return False
			Case 'qt_peso_apresentacao'
				//idc_qt_peso_apresentacao = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PESO APRESENTA$$HEX2$$c700c300$$ENDHEX$$O', ref idc_qt_peso_apresentacao, ref ls_Log) Then Return False
			Case 'qt_peso_grama'
				//idc_qt_peso_grama = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PESO GRAMA', ref idc_qt_peso_grama, ref ls_Log) Then Return False
			Case 'qt_peso_kg_estoque'
				//idc_qt_peso_kg_estoque = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PESO KG ESTOQUE', ref idc_qt_peso_kg_estoque, ref ls_Log) Then Return False
			Case 'qt_pontos_resgate'
				il_qt_pontos_resgate = Long(ls_Vl_Item)
			Case 'qt_profundidade_cm'
				//idc_qt_profundidade_cm = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PROFUNDIDADE CM', ref idc_qt_profundidade_cm, ref ls_Log) Then Return False
			Case 'qt_profund_cm_caixa_estoque'
				//idc_qt_profund_cm_caixa_estoque = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PROFUNDIDADE CM ESTOQUE', ref idc_qt_profund_cm_caixa_estoque, ref ls_Log) Then Return False
			Case 'qt_unidades_embalagem'
				il_qt_unidades_embalagem = Long(ls_Vl_Item)
			Case 'vl_fator_conversao'
				//idc_vl_fator_conversao = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'FATOR CONVERSAO', ref idc_vl_fator_conversao, ref ls_Log) Then Return False
			Case 'vl_fator_conversao_padrao'
				//idc_vl_fator_conversao_padrao = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'FATOR CONVERSAO PADRAO', ref idc_vl_fator_conversao_padrao, ref ls_Log) Then Return False
			Case 'vl_ponto_clube'
				//idc_vl_ponto_clube = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'VLR PONTO CLUBE', ref idc_vl_ponto_clube, ref ls_Log) Then Return False
			Case 'vl_reembolso_fpb'
				//idc_vl_reembolso_fpb = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'VALOR REEMBOLSO FARM. POPULAR DO BRASIL', ref idc_vl_reembolso_fpb, ref ls_Log) Then Return False
			Case 'vl_volume'
				//idc_vl_volume = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'VOLUME', ref idc_vl_volume, ref ls_Log) Then Return False
			Case 'qt_concentracao'
				//idc_qt_concentracao = Dec(ls_Vl_Item)
				If Not io_Comum.of_decimal(ls_Vl_Item, 'QTDE. CONCENTRA$$HEX2$$c700c300$$ENDHEX$$O', ref idc_qt_concentracao, ref ls_Log) Then Return False
			Case 'id_liberado_ecommerce_dc'
				is_id_liberado_ecommerce_dc = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
			Case 'id_liberado_ecommerce_mp'
				is_id_liberado_ecommerce_mp = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)
			Case 'id_liberado_ecommerce_pp'
				is_id_liberado_ecommerce_pp = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)				
			Case 'de_descricao_internet'
				is_de_descricao_internet = gf_replace(ls_Vl_Item, "CC/", "",  0)
				is_de_descricao_internet = trim(is_de_descricao_internet)
			Case 'de_principal_internet'
//				If Not IsNull(ls_Vl_Item) Then
//					is_de_principal_internet = of_texto_internet(ls_Vl_Item)
//				Else
//					is_de_principal_internet = ls_Vl_Item
//				End If
			
			Case 'de_texto_qm'
				is_de_alteracao_situacao  = gf_replace(ls_Vl_Item, "CC/", "",  0)
				is_de_alteracao_situacao  = gf_replace(is_de_alteracao_situacao, "ENTER/", "",  0)			
				is_de_alteracao_situacao = Trim(is_de_alteracao_situacao)
				
			Case 'qt_comprimento'
				If Not io_Comum.of_decimal(ls_Vl_Item, 'QT_COMPRIMENTO', ref idc_qt_comprimento, ref ls_Log) Then Return False				
				
			Case 'qt_prazo_reposicao'								
				il_qt_prazo_reposicao = Long(ls_Vl_Item)
				
			Case 'cd_area'
				il_cd_area_farmacia = Long(ls_Vl_Item)
				
			Case 'de_area'
				is_de_area_farmacia = ls_Vl_Item
				
			Case 'cd_tarja'
				il_cd_tarja = Long(ls_Vl_Item)
				
			Case 'de_tarja'
				is_de_tarja = ls_Vl_Item
				
			Case 'cd_cronicidade'
				il_cd_cronicidade = Long(ls_Vl_Item)
				
			Case 'de_cronicidade'
				is_de_cronicidade = ls_Vl_Item
				
			Case 'cd_arvore_mercadologica'
				is_cd_arvore_mercadologica = ls_Vl_Item

			Case 'cd_grupo_mercadoria'
				is_cd_grupo_mercadoria = ls_Vl_Item
				
			Case 'de_grupo_mercadoria'
				is_de_grupo_mercadoria = ls_Vl_Item
				
			Case 'id_sem_gtin'				
				is_id_sem_gtin = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	
										
			Case 	'id_farm_gov_bolsa_familia'
				is_farm_gov_bolsa_familia = iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)	 	

			Case 'id_caract_variante'
				is_id_caract_variante =  ls_Vl_Item
				
			Case 'vl_temp_minima'
				If Match(ls_Vl_Item, '-') Then 
					ls_Vl_Item = gf_replace(ls_Vl_Item, '-', '', 0)
					ls_Vl_Item = '-' + ls_Vl_Item
				End If
				If Not io_Comum.of_decimal(ls_Vl_Item, 'TEMPERATURA MINIMA', ref idc_vl_temp_minima, ref ls_Log) Then Return False
				
			Case 'vl_temp_maxima'
				If Match(ls_Vl_Item, '-') Then 
					ls_Vl_Item = gf_replace(ls_Vl_Item, '-', '', 0)
					ls_Vl_Item = '-' + ls_Vl_Item
				End If
				If Not io_Comum.of_decimal(ls_Vl_Item, 'TEMPERATURA MAXIMA', ref idc_vl_temp_maxima, ref ls_Log) Then Return False
			
			Case 'mark_externo'
				is_id_lib_marketing_externo =  iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)
				
			Case 'mark_interno'
				is_id_lib_marketing_interno =  iif(ls_Vl_Item = 'X', 'S', ls_Vl_Item)
				
//			Case 'cd_texto_min_saude'
//				if Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' then
//					SELECT
//						cd_texto_min_saude
//					INTO
//						:il_cd_texto_min_saude
//					FROM
//						texto_min_saude
//					WHERE
//						cd_texto_min_saude_sap = :ls_Vl_Item
//					USING SQLCA;
//					
//					Choose Case SQLCA.SQLCode
//						Case -1
//							ls_Log	= "Erro ao localizar o registro de texto do minist$$HEX1$$e900$$ENDHEX$$rio da sa$$HEX1$$fa00$$ENDHEX$$de. ~r~rErro: " + SQLCA.SQLErrText					
//							Return False
//						Case 100
//							ls_Log	= "Texto do minist$$HEX1$$e900$$ENDHEX$$rio da sa$$HEX1$$fa00$$ENDHEX$$de n$$HEX1$$e300$$ENDHEX$$o encontrado conforme cadastro proveniente do SAP."
//							Return False
//					End Choose
//				end if
			Case 'desc_com_prin'
				if Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' then
					is_desc_com_prin = ls_Vl_Item
				end if
			Case 'desc_com_sec'
				if Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' then
					is_desc_com_sec = ls_Vl_Item
				end if
			Case 'permite_publicidade'
				if Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' then
					if ls_Vl_Item = 'SIM' then 
						is_permite_publicidade = 'S'
					else
						is_permite_publicidade = 'N'
					end if
				end if
				
			//Criar case para dt_inicio_stb,dt_fim_stb,id_stb,desc_stb
			
			Case	'dt_inicio_stb'
				If Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' then
					idh_inicio_standby = datetime(ls_Vl_Item)
				End if				
			
			Case	'dt_fim_stb'
				If Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' then
					idh_fim_standby = datetime(ls_Vl_Item)
				End if	
				
			Case	'id_stb'
				If Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' then
					is_id_standby = ls_Vl_Item
				End if
				
			Case	'desc_stb'
				If Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' then
					is_desc_standby = ls_Vl_Item
				End if		
				
			//Criar case para dt_inicio_stb,dt_fim_stb,id_stb,desc_stb
			
			
			Case 'publicidade_obri_texto_legal'
				if Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' then
					if ls_Vl_Item = 'SIM' then 
						is_publicidade_obri_texto_legal = 'S'
					else
						is_publicidade_obri_texto_legal = 'N'
					end if
				end if
			Case 'texto_legal'
				if Not IsNull(ls_Vl_Item) and Trim(ls_Vl_Item) <> '' then
					is_texto_legal = ls_vl_item
				end if
				
		End Choose
	Next
		
	If This.of_Valida_Dados(Ref ls_Log) Then
		
		If Not This.of_cadastra_alerta_restricao(Ref ls_Log) Then Return False
		If Not This.of_cadastra_tipo_apresentacao(Ref ls_Log) Then Return False
		If Not This.of_cadastra_fabricante(Ref ls_Log) Then Return False
		If Not This.of_cadastra_planograma(Ref ls_Log) Then Return False
		If Not This.of_cadastra_dcb(Ref ls_Log) Then Return False
		If Not This.of_cadastra_linha_produto(Ref ls_Log) Then Return False
		If Not This.of_cadastra_marca_ecommerce(Ref ls_Log) Then Return False
		If Not This.of_cadastra_cest(Ref ls_Log) Then Return False
		If Not This.of_cadastra_tipo_prescricao(Ref ls_Log) Then Return False
		If Not This.of_cadastra_mix_produto(Ref ls_Log) Then Return False
		If Not This.of_cadastra_grupo_alteracao_preco(Ref ls_Log) Then Return False
		If Not This.of_cadastra_tipo_produto_pricing(Ref ls_Log) Then Return False
		If Not This.of_cadastra_segmento_ims(Ref ls_Log) Then Return False
		If Not This.of_cadastra_marca_produto(Ref ls_Log) Then Return False
		
		If Not This.of_cadastra_area_farmacia(Ref ls_Log) Then Return False
		If Not This.of_cadastra_tarja(Ref ls_Log) Then Return False
		If Not This.of_cadastra_cronicidade(Ref ls_Log) Then Return False
		If Not This.of_cadastra_grupo_mercadorias(Ref ls_Log) Then Return False
		
		// Retorna o c$$HEX1$$f300$$ENDHEX$$digo do produto
		If This.of_Produto_Novo(ref ll_Produto, Ref lb_Produto_Novo, Ref ls_Log) Then
			
			If Not This.of_carrega_ean_dimensoes_un(lb_Produto_Novo, ll_Produto,  Ref ls_Log) Then Return False
			
			If This.of_Insere_Produto_Geral(ll_Produto, lb_Produto_Novo, Ref ls_Log) Then
				If This.of_Insere_Produto_Central(ll_Produto, lb_Produto_Novo, Ref ls_Log) Then
					If This.of_cadastra_comissao(ll_Produto, 1, Ref ls_Log) Then // NORMAL
						If This.of_cadastra_comissao(ll_Produto, 2, Ref ls_Log) Then // SELETIVA
							If This.of_Insere_Codigo_Barras(ll_Produto, lb_Produto_Novo, Ref ls_Log) Then
								If This.of_Insere_Produto_UF(ll_Produto, lb_Produto_Novo, Ref ls_Log) Then
									if This.of_atualiza_ecommerce_prd(ll_Produto, al_controle, ref ls_log ) Then
										//if This.of_atualiza_cod_barra_sap( al_controle, ref ls_log ) Then
										
											If lb_Produto_Novo Then
												// Grava o c$$HEX1$$f300$$ENDHEX$$digo do legado no SAP
												If This.of_envia_sap_codigo_legado(is_cd_produto_sap, String(ll_Produto), ref ls_Log ) Then
													lb_Sucesso	= True
												End If
											Else
												lb_Sucesso	= True
											End If
										End if
									//End if //Cod barras SAP
								End If
							End If
						End If // comissao seletiva
					End If // comissao normal
				End If
			End If
		End If
	End If
			
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 175, ls_Log)
	End If
		
	Destroy(lds)
	
End Try

Return lb_Sucesso
end function

public function boolean of_atualiza_cod_barra_sap (long al_controle_pai, ref string as_log);Long ll_linhas
Long ll_linha, ll_existe
Long ll_controle_filho, ll_cd_produto
string ls_de_cod_barras, ls_id_principal

Try

	SELECT nr_controle
	Into :ll_Controle_filho
	FROM interface_sap  i 
	Where i.cd_tabela = 3
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If

	If ll_Controle_filho = 0 Or IsNull(ll_Controle_filho) Then
		return true
	End If		
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then	
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ls_de_cod_barras = lo_Comum.ids_lista_registros.Object.de_codigo_barras[ll_Linha]
			ls_id_principal =  lo_Comum.ids_lista_registros.Object.id_principal[ll_Linha]
			
			if ls_de_cod_barras <> '' and not isnull(ls_de_cod_barras) Then
				
				if ls_id_principal = 'X' or ls_id_principal = 'S' Then
					ls_id_principal = 'S'
				else
					ls_id_principal = 'N'
				end if
		
				update codigo_barras_produto
				set id_principal_sap = :ls_id_principal
				where de_codigo_barras = :ls_de_cod_barras;
				
				if sqlca.sqlcode = -1 then
					as_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_cod_barra_sap ~nErro ao atualizar a tabela "codigo_barras_produto": ~n' + sqlca.sqlerrtext
					return false
				end if
			end if
			
		Next
		
	Else
		Return False
	End If	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_cod_barra_sap'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_revisao_desconto_preste (long al_produto, ref string as_log);//
//as_Log = ""
//
//update produto_preste_a_vencer set id_revisar_desconto = 'S'
//	where cd_produto 	= :al_produto
//	  and id_situacao 		= 'A'
//	  and dateadd(Month, 1, dh_validade ) > getdate()
//Using SqlCa;
//	
//If SqlCa.SqlCode = -1 Then
//	SqlCa.of_rollback( )
//	as_Log = "Erro no update produto_preste_a_vencer. Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge473_produto_sap.of_revisao_desconto_preste. Erro: " + SqlCa.sqlErrText
//	Return False
//End If

Return True

end function

public function boolean of_valida_categ_mercadologica (ref string ps_log);long ll_existe
	
if isnull(il_cd_categ_mercadologica) Then return true
	
//Valida categoria mercadologica
Select count(*)
into :ll_existe
from categoria_mercadologica
where cd_categ_mercadologica = :il_cd_categ_mercadologica;

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela "categoria_mercadologica": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) Then
	ps_log = 'Categoria mercadologica n$$HEX1$$e300$$ENDHEX$$o encontrada: ' + string(il_cd_categ_mercadologica)
	return false
end if

return true
end function

public function boolean of_insere_ecommerce_prd (long pl_cd_produto, ref string ps_log);long ll_existe


Select count(*)
into :ll_existe
from ecommerce_prd
where id_ecommerce = '2'
and id_rede_filial = :is_id_rede_filial
and cd_produto = :pl_cd_produto;

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela ecommerce_prd: ' + sqlca.sqlerrtext
	return false
end if

if ll_existe > 0 and not isnull(ll_existe) Then

	update ecommerce_prd
	set de_tag_title = :is_de_tag_title,
		de_tag_description = :is_de_tag_description,
		de_principal_internet = :is_de_descricao_internet
		where id_ecommerce = '2'
		and id_rede_filial = :is_id_rede_filial
		and cd_produto = :pl_cd_produto;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao atualizar a tabela ecommerce_prd: ' + sqlca.sqlerrtext
		return false
	end if
	
ENd if

return true
end function

public function boolean of_atualiza_ecommerce_prd (long pl_cd_produto, long al_controle_pai, ref string as_log);Long ll_linhas
Long ll_linha, ll_existe
Long ll_controle_filho, ll_cd_produto
string ls_rede, ls_tag_title, ls_tag_description, ls_de_principal_internet

Try

	SELECT nr_controle
	Into :ll_Controle_filho
	FROM interface_sap  i 
	Where i.cd_tabela = 4
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If

	If ll_Controle_filho = 0 Or IsNull(ll_Controle_filho) Then
		return true
	End If		
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	lo_Comum.ib_troca_ds_com_text = True
	
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then	
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ls_tag_title = lo_Comum.ids_lista_registros.Object.de_tag_title[ll_Linha]
			ls_tag_description =  lo_Comum.ids_lista_registros.Object.de_tag_description[ll_Linha]
			ls_rede =  lo_Comum.ids_lista_registros.Object.id_rede_filial[ll_Linha]
			ls_de_principal_internet =  trim(lo_Comum.ids_lista_registros.Object.de_principal_internet[ll_Linha])
			
			Select count(*)
			into :ll_existe
			from ecommerce_prd
			where id_ecommerce = '2'
			and id_rede_filial = :ls_rede
			and cd_produto = :pl_cd_produto;
			
			if sqlca.sqlcode = -1 then
				as_log = 'Problemas ao consultar a tabela ecommerce_prd: ' + sqlca.sqlerrtext
				return false
			end if

			if ll_existe > 0 and not isnull(ll_existe) Then
			
				update ecommerce_prd
				set de_tag_title = :ls_tag_title,
					de_tag_description = :ls_tag_description,
					de_principal_internet = :ls_de_principal_internet
					where id_ecommerce = '2'
					and id_rede_filial = :ls_rede
					and cd_produto = :pl_cd_produto;
				
				if sqlca.sqlcode = -1 then
					as_log = 'Problemas ao atualizar a tabela ecommerce_prd: ' + sqlca.sqlerrtext
					return false
				end if
	
			End if
			
		Next
		
	Else
		Return False
	End If	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_cod_barra_sap'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_cadastra_area_farmacia (ref string as_log);String ls_de_area_farmacia

If IsNull(il_cd_area_farmacia) Then Return True

Select de_area_farmacia
Into :ls_de_area_farmacia
From area_farmacia
Where cd_area_farmacia = :il_cd_area_farmacia
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_area_farmacia) or Trim(is_de_area_farmacia) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o de area_farmacia n$$HEX1$$e300$$ENDHEX$$o foi informada ou foi informada de forma errada no SAP, favor verificar."
		Return False
	End If
End If
	
Choose Case SqlCa.SqlCode
		
	Case 0
		
		If is_de_area_farmacia <> ls_de_area_farmacia Then
		
			Update area_farmacia
			Set de_area_farmacia = :is_de_area_farmacia
			Where cd_area_farmacia = :il_cd_area_farmacia
			Using SqlCa;
		
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'area_farmacia'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
		
		End if
		
	Case 100
		
		Insert Into area_farmacia(cd_area_farmacia, de_area_farmacia)
		Values(:il_cd_area_farmacia, :is_de_area_farmacia)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'area_farmacia'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		
		as_Log = "Erro no select da tabela 'area_farmacia'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_cadastra_tarja (ref string as_log);String ls_de_tarja

If IsNull(il_cd_tarja) Then Return True

Select de_tarja
Into :ls_de_tarja
From tarja
Where cd_tarja = :il_cd_tarja
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_tarja) or Trim(is_de_tarja) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o de tarja n$$HEX1$$e300$$ENDHEX$$o foi informada ou foi informada de forma errada no SAP, favor verificar."
		Return False
	End If
End If
	
Choose Case SqlCa.SqlCode
		
	Case 0
		
		If is_de_tarja <> ls_de_tarja Then
		
			Update tarja
			Set de_tarja = :is_de_tarja
			Where cd_tarja = :il_cd_tarja
			Using SqlCa;
		
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'tarja'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
		
		End if
		
	Case 100
		
		Insert Into tarja(cd_tarja, de_tarja)
		Values(:il_cd_tarja, :is_de_tarja)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'tarja'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		
		as_Log = "Erro no select da tabela 'tarja'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_cadastra_cronicidade (ref string as_log);String ls_de_cronicidade

If IsNull(il_cd_cronicidade) Then Return True

Select de_cronicidade
Into :ls_de_cronicidade
From cronicidade
Where cd_cronicidade = :il_cd_cronicidade
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_cronicidade) or Trim(is_de_cronicidade) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o de cronicidade n$$HEX1$$e300$$ENDHEX$$o foi informada ou foi informada de forma errada no SAP, favor verificar."
		Return False
	End If
End If
	
Choose Case SqlCa.SqlCode
		
	Case 0
		
		If is_de_cronicidade <> ls_de_cronicidade Then
		
			Update cronicidade
			Set de_cronicidade = :is_de_cronicidade
			Where cd_cronicidade = :il_cd_cronicidade
			Using SqlCa;
		
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'cronicidade'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
		
		End if
		
	Case 100
		
		Insert Into cronicidade(cd_cronicidade, de_cronicidade)
		Values(:il_cd_cronicidade, :is_de_cronicidade)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'cronicidade'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		
		as_Log = "Erro no select da tabela 'cronicidade'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_verifica_arvore_mercadologica (string as_arvore_mercadologica);Long ll_Achou

SELECT COUNT(cd_hiernode6)
INTO :ll_Achou
FROM arvore_mercadologica
WHERE cd_arvore_mercadologica = :as_arvore_mercadologica
Using SqlCA;
		
If Sqlca.Sqlcode = -1 Then
	Return False
End If

If ll_Achou = 0 Or IsNull(ll_Achou) Then
	Return False
Else
	Return True
End If


end function

public function boolean of_cadastra_grupo_mercadorias (ref string as_log);String ls_de_grupo_mercadoria

If (IsNull(is_cd_grupo_mercadoria) Or Trim(is_cd_grupo_mercadoria) = "" ) Then Return True

Select de_grupo
Into :ls_de_grupo_mercadoria
From grupo_mercadorias
Where cd_grupo = :is_cd_grupo_mercadoria
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	If IsNull(is_de_grupo_mercadoria) or Trim(is_de_grupo_mercadoria) = '' Then
		as_Log	= "A descri$$HEX2$$e700e300$$ENDHEX$$o de grupo_mercadorias n$$HEX1$$e300$$ENDHEX$$o foi informada ou foi informada de forma errada no SAP, favor verificar."
		Return False
	End If
End If
	
Choose Case SqlCa.SqlCode
		
	Case 0
		
		If is_de_grupo_mercadoria <> ls_de_grupo_mercadoria Then
		
			Update grupo_mercadorias
			Set de_grupo = :is_de_grupo_mercadoria
			Where cd_grupo = :is_cd_grupo_mercadoria
			Using SqlCa;
		
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao atualizar registro da tabela 'grupo_mercadorias'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
		
		End if
		
	Case 100
		
		Insert Into grupo_mercadorias(cd_grupo, de_grupo)
		Values(:is_cd_grupo_mercadoria, :is_de_grupo_mercadoria)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'grupo_mercadorias'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Case -1
		
		as_Log = "Erro no select da tabela 'grupo_mercadorias'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_verifica_origem_st ();Long ll_Achou

SELECT COUNT(*)
INTO :ll_Achou
FROM origem_produto
WHERE cd_origem_produto = :is_cd_st_origem
Using SqlCA;
		
If Sqlca.Sqlcode = -1 Then
	Return False
End If

If ll_Achou = 0 Or IsNull(ll_Achou) Then
	Return False
Else
	Return True
End If


end function

public function boolean of_verifica_medicamento ();//Anteriormente fazia o select no banco de dados na fun$$HEX2$$e700e300$$ENDHEX$$o produto_medicamento passando o codigo do produto

String ls_classificacao

ls_classificacao = Left(string(il_nr_classificacao_fiscal), 4)

If ls_classificacao = '3001' Or ls_classificacao = '3002' Or ls_classificacao = '3003' Or ls_classificacao = '3004' Or ls_classificacao = '3005' Or ls_classificacao = '3006' Then
	is_Medicamento = 'S'
Else
	is_Medicamento = 'N'
End If

Return True


end function

public function boolean of_get_data_alt_lote_cont_saldo_loja (ref date ad_data_permitida, ref string as_log);String	ls_data_permitida_alt_lote_cont_saldo_loja
uo_ge040_array	luo_ge040_array


SELECT
	vl_parametro
INTO
	:ls_data_permitida_alt_lote_cont_saldo_loja
FROM
	parametro_geral
WHERE
	cd_parametro = 'DATA_ALT_LOTE_CONT_SALDO_LOJA'
USING SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		as_log = 'Erro ao buscar par$$HEX1$$e200$$ENDHEX$$metro DATA_ALT_LOTE_CONT_SALDO_LOJA (uo_ge473_produto_sap.of_get_data_alt_lote_cont_saldo_loja). ~r~rErro: ' + SQLCA.SQLErrText
		Return false
	Case 100
		as_log = 'Erro ao buscar par$$HEX1$$e200$$ENDHEX$$metro DATA_ALT_LOTE_CONT_SALDO_LOJA (uo_ge473_produto_sap.of_get_data_alt_lote_cont_saldo_loja). ~r~rErro: ' + 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado registro do par$$HEX1$$e200$$ENDHEX$$metro DATA_ALT_LOTE_CONT_SALDO_LOJA'
		Return False
End Choose

if IsNull(ls_data_permitida_alt_lote_cont_saldo_loja) or Trim(ls_data_permitida_alt_lote_cont_saldo_loja) = '' then
	//Nenhuma data com altera$$HEX2$$e700e300$$ENDHEX$$o permitida, seguir, pois, est$$HEX1$$e100$$ENDHEX$$ correto caso ningu$$HEX1$$e900$$ENDHEX$$m tenha configurado nada.
	Return True
end if

ad_data_permitida = Date(ls_data_permitida_alt_lote_cont_saldo_loja)

Return True

end function

public function boolean of_permite_alt_cont_saldo_filial (long al_cd_produto, ref boolean ab_permite, ref string as_log);Any	la_produtos_permitidos[]
Date	ld_data_permitida, ld_hoje
Long	ll_index_array_find, ll_for
uo_ge040_array	luo_ge040_array


If Not of_get_prod_alt_lote_cont_saldo_loja(REF la_produtos_permitidos, REF as_log) Then
	ab_permite = False
	Return False
End If

If UpperBound(la_produtos_permitidos) = 0 Then
	ab_permite = False
	Return True
End If

If Not of_get_data_alt_lote_cont_saldo_loja(REF ld_data_permitida, REF as_log) Then
	ab_permite = False
	Return False
End If

ld_hoje	= Date(gf_getserverdate())

If IsNull(ld_data_permitida) or ld_hoje <> ld_data_permitida then
	ab_permite = False
	Return True
End If

ll_index_array_find	= 0

for ll_for = 1 to UpperBound(la_produtos_permitidos)
	if al_cd_produto = Long(la_produtos_permitidos[ll_for]) then
		ll_index_array_find	= ll_for
		exit
	end if
next

if ll_index_array_find <= 0 then
	ab_permite = False
	Return True
else
	ab_permite = true
end if

Return True
end function

public function boolean of_get_prod_alt_lote_cont_saldo_loja (ref any aa_produtos[], ref string as_log);String	ls_lista_produtos
uo_ge040_array	luo_ge040_array


ls_lista_produtos = '735771,735772,742251,742252,742253,748255,748256,748257,748258,748259,717385,729940,733478,730596,734225,734206,750601,750602,750603,750604,750605,750606'

if IsNull(ls_lista_produtos) or Trim(ls_lista_produtos) = '' then
	//Nenhum produto com altera$$HEX2$$e700e300$$ENDHEX$$o permitida, seguir, pois, est$$HEX1$$e100$$ENDHEX$$ correto caso ningu$$HEX1$$e900$$ENDHEX$$m tenha configurado nada.
	Return True
end if

luo_ge040_array.uof_list_to_array(ls_lista_produtos, aa_produtos, ',')

Return True

end function

public function boolean of_valida_area_atuacao (ref string ps_log);Long	ll_Existe

If IsNull (is_cd_produto_area_atuacao) then Return True

//Valida $$HEX1$$e100$$ENDHEX$$rea de atua$$HEX2$$e700e300$$ENDHEX$$o

SELECT cd_produto_area_atuacao
  INTO :il_cd_produto_area_atuacao
  FROM produto_area_atuacao
 WHERE cd_codigo_sap = :is_cd_produto_area_atuacao
 USING SQLCA;

Choose case SQLCA.SQLCode
	case -1
		ps_log = 'Erro ao consultar a tabela "produto_area_atuacao": ' + SQLCA.SQLErrText
		Return False
		
	case 100
		ps_log = '$$HEX1$$c100$$ENDHEX$$rea de atua$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o encontrada: ' + is_cd_produto_area_atuacao
		Return False
End choose

Return True
end function

public function boolean of_valida_atributo (ref string ps_log);Long	ll_Existe

If IsNull (is_cd_produto_atributo) then Return True

//Valida $$HEX1$$e100$$ENDHEX$$rea de atua$$HEX2$$e700e300$$ENDHEX$$o

SELECT cd_produto_atributo
  INTO :il_cd_produto_atributo
  FROM produto_atributo
 WHERE cd_codigo_sap = :is_cd_produto_atributo
 USING SQLCA;

Choose case SQLCA.SQLCode
	case -1
		ps_log = 'Erro ao consultar a tabela "produto_atributo": ' + SQLCA.SQLErrText
		Return False
		
	case 100
		ps_log = 'Atributo n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + is_cd_produto_atributo
		Return False
End choose

Return True
end function

public function boolean of_valida_posologia (ref string ps_log);Long	ll_Existe

If IsNull (is_cd_produto_posologia) then Return True

//Valida $$HEX1$$e100$$ENDHEX$$rea de atua$$HEX2$$e700e300$$ENDHEX$$o

SELECT cd_produto_posologia
  INTO :il_cd_produto_posologia
  FROM produto_posologia
 WHERE cd_codigo_sap = :is_cd_produto_posologia
 USING SQLCA;

Choose case SQLCA.SQLCode
	case -1
		ps_log = 'Erro ao consultar a tabela "produto_posologia": ' + SQLCA.SQLErrText
		Return False
		
	case 100
		ps_log = 'Posologia n$$HEX1$$e300$$ENDHEX$$o encontrada: ' + is_cd_produto_posologia
		Return False
End choose

Return True
end function

public function boolean of_valida_precaucoes (ref string ps_log);Long	ll_Existe

If IsNull (is_cd_produto_precaucoes) then Return True

//Valida $$HEX1$$e100$$ENDHEX$$rea de atua$$HEX2$$e700e300$$ENDHEX$$o

SELECT cd_produto_precaucoes
  INTO :il_cd_produto_precaucoes
  FROM produto_precaucoes
 WHERE cd_codigo_sap = :is_cd_produto_precaucoes
 USING SQLCA;

Choose case SQLCA.SQLCode
	case -1
		ps_log = 'Erro ao consultar a tabela "produto_precaucoes": ' + SQLCA.SQLErrText
		Return False
		
	case 100
		ps_log = 'Precau$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o encontrada: ' + is_cd_produto_precaucoes
		Return False
End choose

Return True
end function

public function boolean of_valida_publico_dest (ref string ps_log);Long	ll_Existe

If IsNull (is_cd_produto_publico_dest) then Return True

//Valida $$HEX1$$e100$$ENDHEX$$rea de atua$$HEX2$$e700e300$$ENDHEX$$o

SELECT cd_produto_publico_dest
  INTO :il_cd_produto_publico_dest
  FROM produto_publico_dest
 WHERE cd_codigo_sap = :is_cd_produto_publico_dest
 USING SQLCA;

Choose case SQLCA.SQLCode
	case -1
		ps_log = 'Erro ao consultar a tabela "produto_publico_dest": ' + SQLCA.SQLErrText
		Return False
		
	case 100
		ps_log = 'P$$HEX1$$fa00$$ENDHEX$$blico de destino n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + is_cd_produto_publico_dest
		Return False
End choose

Return True
end function

public function boolean of_valida_faixa_etaria (ref string ps_log);Long	ll_Existe

If IsNull (is_cd_produto_faixa_etaria) then Return True

//Valida $$HEX1$$e100$$ENDHEX$$rea de atua$$HEX2$$e700e300$$ENDHEX$$o

SELECT cd_produto_faixa_etaria
  INTO :il_cd_produto_faixa_etaria
  FROM produto_faixa_etaria
 WHERE cd_codigo_sap = :is_cd_produto_faixa_etaria
 USING SQLCA;

Choose case SQLCA.SQLCode
	case -1
		ps_log = 'Erro ao consultar a tabela "produto_faixa_etaria": ' + SQLCA.SQLErrText
		Return False
		
	case 100
		ps_log = 'Faixa et$$HEX1$$e100$$ENDHEX$$ria n$$HEX1$$e300$$ENDHEX$$o encontrada: ' + is_cd_produto_faixa_etaria
		Return False
End choose

Return True
end function

public function boolean of_valida_selo (ref string ps_log);Long	ll_Existe

If IsNull (is_cd_produto_selo) then Return True

//Valida $$HEX1$$e100$$ENDHEX$$rea de atua$$HEX2$$e700e300$$ENDHEX$$o

SELECT cd_produto_selo
  INTO :il_cd_produto_selo
  FROM produto_selo
 WHERE cd_codigo_sap = :is_cd_produto_selo
 USING SQLCA;

Choose case SQLCA.SQLCode
	case -1
		ps_log = 'Erro ao consultar a tabela "produto_selo": ' + SQLCA.SQLErrText
		Return False
		
	case 100
		ps_log = 'Selo n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + is_cd_produto_selo
		Return False
End choose

Return True
end function

public function boolean of_valida_texto_min_saude (ref string ps_log);Long	ll_Existe

If IsNull (is_cd_produto_texto_min_saude) then Return True

//Valida $$HEX1$$e100$$ENDHEX$$rea de atua$$HEX2$$e700e300$$ENDHEX$$o

SELECT cd_produto_texto_min_saude
  INTO :il_cd_produto_texto_min_saude
  FROM produto_texto_min_saude
 WHERE cd_codigo_sap = :is_cd_produto_texto_min_saude
 USING SQLCA;

Choose case SQLCA.SQLCode
	case -1
		ps_log = 'Erro ao consultar a tabela "produto_texto_min_saude": ' + SQLCA.SQLErrText
		Return False
		
	case 100
		ps_log = 'Texto do Minist$$HEX1$$e900$$ENDHEX$$rio da Sa$$HEX1$$fa00$$ENDHEX$$de n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + is_cd_produto_texto_min_saude
		Return False
End choose

Return True
end function

public function boolean of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_produtos', False) Then 
		gvo_aplicacao.of_grava_log("Interface Produto - Erro alterar a DW [ds_ge473_lista_produtos] - uo_ge473_produto_sap.of_processa_atualizacao.")
		Return False
	End If
	
	ll_Linhas = lds.Retrieve()
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			//of_atualiza_produto(lds.Object.nr_controle[ll_Linha])
			
			// Para n$$HEX1$$e300$$ENDHEX$$o ficar gerando erro de conex$$HEX1$$e300$$ENDHEX$$o com a mult
			gvb_Carrega_Contas_Mult = False
			uo_ge473_produto_sap lo_Produto_SAP
			 
			Try
				lo_Produto_SAP	= Create uo_ge473_produto_sap
				lo_Produto_SAP.of_atualiza_produto(lds.Object.nr_controle[ll_Linha])
			Finally
				Destroy(lo_Produto_SAP)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Produto - Erro ao recuperar os da DW [ds_ge473_lista_produtos] - uo_ge473_produto_sap.of_processa_atualizacao.")
		Return False
	End If	
	
	Return True
finally
	Destroy lds
end try
end function

on uo_ge473_produto_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_produto_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_ean = Create dc_uo_ds_base
ids_ean.of_ChangeDataObject("ds_ge473_codigo_barras")


ids_ean_cad = Create dc_uo_ds_base
ids_ean_cad.of_ChangeDataObject("ds_ge473_codigo_barras_cad")

ids_ean_cadastrados = Create dc_uo_ds_base
ids_ean_cadastrados.of_ChangeDataObject("ds_ge473_codigo_barras_cadastrados")

io_sap_comum = Create uo_ge470_sap_comum

io_Comum	= Create uo_ge473_comum	

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log)

ivo_cest = Create uo_cest



end event

event destructor;Destroy ids_ean
Destroy ids_ean_cad
Destroy ids_ean_cadastrados
Destroy io_sap_comum
Destroy ivo_cest
Destroy io_Comum
end event

