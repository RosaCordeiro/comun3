HA$PBExportHeader$uo_ge589_log_j1btax.sru
forward
global type uo_ge589_log_j1btax from nonvisualobject
end type
end forward

global type uo_ge589_log_j1btax from nonvisualobject
end type
global uo_ge589_log_j1btax uo_ge589_log_j1btax

type variables
Long  		ivl_nr_controle
DateTime 	ivdh_inicio
String	 	ivs_id_modulo
String 		ivs_id_imposto
String		ivs_id_grupo
Char  		ivc_id_revisao
DateTime 	ivdh_revisao_ini
DateTime 	ivdh_revisao_fim
String		ivs_cd_tabela_sap
String		ivs_cd_ambiente_sap
String		ivs_nr_matricula_responsavel
DateTime 	ivdh_inicio_geracao
DateTime 	ivdh_termino_geracao
Char  		ivc_id_exportado_planilha
String		ivs_de_obs
String		ivs_mandt
Long			ivl_qt_tempo_geracao
Long			ivl_qt_registros_gerados
String		ivs_id_imposto_futuro
DateTime		ivdh_imposto_futuro
String 		ivs_nr_versao_fi

// Situa$$HEX2$$e700f500$$ENDHEX$$es poss$$HEX1$$ed00$$ENDHEX$$veis para o relat$$HEX1$$f300$$ENDHEX$$rio
String 		ivs_id_situacao_relatorio 	// I - Gera$$HEX2$$e700e300$$ENDHEX$$o Iniciada | G - Gerado	| C - Confirmado	| X - Erro
String 		ivs_id_situacao_aprovacao	// N - N$$HEX1$$e300$$ENDHEX$$o Confirmado 	| P - Pendente | A - Aprovado		| X - Erro			
String 		ivs_id_situacao_exportacao	// A - Aguardando Envio | E - Enviado 	| F - Finalizado	| X - Erro

String		ivs_nr_matricula_resp_aprovacao
DateTime 	ivdh_aprovacao

DateTime 	ivdh_exportacao
DateTime 	ivdh_finalizacao

Char			ivc_id_aceitou_retroativo
String		ivs_nr_versao_fi_recente

String 		ivs_Null
Decimal 		ivdc_Null
DateTime		ivdh_Null
Char			ivc_Null

Long 			ivl_qt_itens // Mantido na of_insert_log_exportacao_j1btax_item

dc_uo_Transacao itr_Transacao // Inicializar com SQLCA no Constructor


end variables

forward prototypes
public subroutine _documentacao ()
public function boolean of_gera_log_item (dc_uo_dw_base pdw_regras, long pl_row)
private function string of_get_tabela (string ps_imposto)
private function boolean of_insert_log_exportacao_j1btax ()
private function boolean of_insert_log_exportacao_j1btax_item (long pl_item, string ps_country, string ps_gruop, string ps_land1, string ps_shipfrom, string ps_shipto, string ps_taxjurcode, string ps_value, string ps_value2, string ps_value3, string ps_stgrp, datetime pdh_validfrom, datetime pdh_validto, character pc_sur_type, decimal pdc_rate, decimal pdc_price, decimal pdc_base, character pc_exempt, decimal pdc_amount, decimal pdc_factor, string ps_unit, decimal pdc_basered1, decimal pdc_basered2, decimal pdc_icmsbaser, decimal pdc_minprice, string ps_waers, decimal pdc_minfact, character pc_surchin, decimal pdc_fcp_basered1, decimal pdc_fcp_basered2, string ps_taxlaw, character pc_conven100, decimal pdc_specf_rate, decimal pdc_specf_base, character pc_specf_resale, character pc_partilha_exempt, character pc_taxrelloc, character pc_withhold, decimal pdc_minval_wt, decimal pdc_rate4dec, decimal pdc_amount4dec, decimal pdc_factor4dec, decimal pdc_minprice_amount, string ps_minprice_currency, decimal pdc_minprice_quantity, string ps_minprice_uom, string ps_minprice_taxlaw, string ps_regra, long pl_cd_produto_sybase, string ps_de_produto, long pl_ncm, string ps_ncm_situacao, long pl_ordem_regra_sql)
private function long of_proximo_nr_controle ()
public function boolean of_geracao_finalizada (long pl_qt_registros_gerados)
public function boolean of_exportacao_finalizada (boolean pb_exportou)
public function boolean of_atualiza_qt_registros_gerados (long pl_qt_registros_gerados)
public function long of_calc_tempo_geracao ()
public function boolean of_geracao_iniciada (datetime pdh_inicio, string ps_id_modulo, string ps_id_imposto, string ps_id_grupo, character pc_id_revisao, datetime pdh_revisao_ini, datetime pdh_revisao_fim, string ps_cd_ambiente_sap, string ps_id_imposto_futuro, datetime pdh_imposto_futuro, character pc_aceitou_retroativo)
public function string of_get_last_nr_versao_fi ()
end prototypes

public subroutine _documentacao ();/*
	Objeto respons$$HEX1$$e100$$ENDHEX$$vel por:
		- Gravar logs de gera$$HEX2$$e700f500$$ENDHEX$$es e exporta$$HEX2$$e700f500$$ENDHEX$$es de deltas na FI085.
		
	1. of_Geracao_Iniciada()		: Insere log inicial de gera$$HEX2$$e700e300$$ENDHEX$$o. (com commit)
	2. of_Geracao_Finalizada()		: Atualiza o final da gera$$HEX2$$e700e300$$ENDHEX$$o com a data/hora final, resultado e o tempo. (com commit)
	3. of_Gera_Log_Item()			: Insere o item da exporta$$HEX2$$e700e300$$ENDHEX$$o no banco (sem commit)
	4. of_Exportacao_Finalizada()	: Chamar quando terminou de exportar a planilha. (com commit)
	
	
*/


end subroutine

public function boolean of_gera_log_item (dc_uo_dw_base pdw_regras, long pl_row);Long lvl_cd_produto_sybase, lvl_ncm, lvl_ordem_regra_sql
String lvs_de_produto, lvs_ncm_situacao

SetNull(lvl_cd_produto_sybase)
SetNull(lvs_de_produto)
SetNull(lvl_ncm)
SetNull(lvs_ncm_situacao)
SetNull(lvl_ordem_regra_sql)

// C$$HEX1$$f300$$ENDHEX$$digo do produto (as datawindows podem ter estes 2 nomes para o cd_produto)
If Long(pdw_Regras.Describe("produto_sybase.id")) > 0 Then
	lvl_cd_produto_sybase = pdw_Regras.GetItemNumber(pl_Row, "produto_sybase")
ElseIf Long(pdw_Regras.Describe("codigo_produto_legado.id")) > 0 Then
	lvl_cd_produto_sybase = pdw_Regras.GetItemNumber(pl_Row, "codigo_produto_legado")
End If

// Descri$$HEX2$$e700e300$$ENDHEX$$o
If Long(pdw_Regras.Describe("descricao_produto.id")) > 0 Then
	lvs_de_produto = pdw_Regras.GetItemString(pl_Row, "descricao_produto")
End If

// NCM
If Long(pdw_Regras.Describe("ncm.id")) > 0 Then
	lvl_ncm = pdw_Regras.GetItemNumber(pl_Row, "ncm")
End If

// NCM_SITUACAO
If Long(pdw_Regras.Describe("ncm_situacao.id")) > 0 Then
	lvs_ncm_situacao = pdw_Regras.GetItemString(pl_Row, "ncm_situacao")
End If

// Ordem da regra na datawindow (1=encerramento | 2,3,4...=regras)
If Long(pdw_Regras.Describe("ordem.id")) > 0 Then
	lvl_ordem_regra_sql = pdw_Regras.GetItemNumber(pl_Row, "ordem")
End If

Choose Case ivs_cd_tabela_sap
	Case 'J_1BTXPIS', 'J_1BTXCOF'
		Return of_insert_log_exportacao_j1btax_item(ivl_qt_itens +1,&
			pdw_Regras.GetItemString(pl_Row, "chave_pais"), &
			pdw_Regras.GetItemString(pl_Row, "grupo_imposto"), &
			ivs_Null, &
			ivs_Null, &
			ivs_Null, &
			ivs_Null, &
			pdw_Regras.GetItemString(pl_Row, "chave_dinamica_1"), &
			pdw_Regras.GetItemString(pl_Row, "chave_dinamica_2"), &
			pdw_Regras.GetItemString(pl_Row, "chave_dinamica_3"), &
			ivs_Null, &
			DateTime(pdw_Regras.GetItemString(pl_Row, "valido_desde")), &
			DateTime(pdw_Regras.GetItemString(pl_Row, "valido_ate")), &
			ivc_Null, &
			pdw_Regras.GetItemDecimal(pl_Row, "taxa_imposto"), &
			ivdc_Null, &
			pdw_Regras.GetItemDecimal(pl_Row, "base_imposto"), &
			ivc_Null, &
			pdw_Regras.GetItemDecimal(pl_Row, "reg_por_unidade"), &
			pdw_Regras.GetItemDecimal(pl_Row, "nro_unidades"), &
			pdw_Regras.GetItemString(pl_Row, "unidade_medida_pauta"), &
			ivdc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			pdw_Regras.GetItemString(pl_Row, "moeda"), &
			ivdc_Null, &
			ivc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			pdw_Regras.GetItemString(pl_Row, iif((ivs_cd_tabela_sap = 'J_1BTXPIS'), 'lei_pis', 'lei_cofins')), &
			ivc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivc_Null, &
			ivc_Null, &
			ivc_Null, &
			ivc_Null, &
			ivdc_Null, &
			pdw_Regras.GetItemDecimal(pl_Row, "taxa_4_decimais"), &
			pdw_Regras.GetItemDecimal(pl_Row, "tarifa_unid_4_decimais"), &
			pdw_Regras.GetItemDecimal(pl_Row, "nro_unid_4_decimais"), &
			pdw_Regras.GetItemDecimal(pl_Row, "preco_minimo_montante"), &
			pdw_Regras.GetItemString(pl_Row, "preco_minimo_moeda"), &
			pdw_Regras.GetItemDecimal(pl_Row, "preco_minimo_qtde"), &
			pdw_Regras.GetItemString(pl_Row, "preco_minimo_unidade"), &
			pdw_Regras.GetItemString(pl_Row, "preco_minimo_lei_trib"), &
			pdw_Regras.GetItemString(pl_Row, "regra"), &
			lvl_cd_produto_sybase, &
			lvs_de_produto, &
			lvl_ncm, &
			lvs_ncm_situacao, &
			lvl_ordem_regra_sql &
		)
		
	Case 'J_1BTXIC3'
		Return of_insert_log_exportacao_j1btax_item(ivl_qt_itens +1,&
			ivs_Null, &
			pdw_Regras.GetItemString(pl_Row, "grupo_imposto"), &
			pdw_Regras.GetItemString(pl_Row, "chave_pais"), &
			pdw_Regras.GetItemString(pl_Row, "emissor"), &
			pdw_Regras.GetItemString(pl_Row, "receptor"), &
			ivs_Null, &
			pdw_Regras.GetItemString(pl_Row, "chave_dinamica_1"), &
			pdw_Regras.GetItemString(pl_Row, "chave_dinamica_2"), &
			pdw_Regras.GetItemString(pl_Row, "chave_dinamica_3"), &
			ivs_Null, &
			DateTime(pdw_Regras.GetItemString(pl_Row, "valido_desde")), &
			DateTime(pdw_Regras.GetItemString(pl_Row, "valido_ate")), &
			ivc_Null, &
			pdw_Regras.GetItemNumber(pl_Row, "taxa_imposto"), &
			ivdc_Null, &
			pdw_Regras.GetItemNumber(pl_Row, "base_imposto"), &
			pdw_Regras.GetItemString(pl_Row, "outra_base"), &
			ivdc_Null, &
			ivdc_Null, &
			ivs_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivs_Null, &
			ivdc_Null, &
			ivc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			pdw_Regras.GetItemString(pl_Row, "direito_fiscal"), &
			pdw_Regras.GetItemString(pl_Row, "convenio_100"), &
			pdw_Regras.GetItemNumber(pl_Row, "taxa_fcp"), &
			pdw_Regras.GetItemNumber(pl_Row, "base_fcp"), &
			pdw_Regras.GetItemString(pl_Row, "calcular_fcp_revenda"), &
			pdw_Regras.GetItemString(pl_Row, "isencao_partilha_icms"), &
			ivc_Null, &
			ivc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivs_Null, &
			ivdc_Null, &
			ivs_Null, &
			ivs_Null, &
			pdw_Regras.GetItemString(pl_Row, "regra"), &
			lvl_cd_produto_sybase, &
			lvs_de_produto, &
			lvl_ncm, &
			lvs_ncm_situacao, &
			lvl_ordem_regra_sql &
		)
		
	Case 'J_1BTXST3'
		Return of_insert_log_exportacao_j1btax_item(ivl_qt_itens +1,&
			ivs_Null, &
			pdw_Regras.GetItemString(pl_Row, "grupo_imposto"), &
			pdw_Regras.GetItemString(pl_Row, "chave_pais"), &
			pdw_Regras.GetItemString(pl_Row, "emissor"), &
			pdw_Regras.GetItemString(pl_Row, "receptor"), &
			ivs_Null, &
			pdw_Regras.GetItemString(pl_Row, "chave_dinamica_1"), &
			pdw_Regras.GetItemString(pl_Row, "chave_dinamica_2"), &
			pdw_Regras.GetItemString(pl_Row, "chave_dinamica_3"), &
			pdw_Regras.GetItemString(pl_Row, "grupo_subfiscal"), &
			DateTime(pdw_Regras.GetItemString(pl_Row, "valido_desde")), &
			DateTime(pdw_Regras.GetItemString(pl_Row, "valido_ate")), &
			pdw_Regras.GetItemString(pl_Row, "regra_calculo"), &
			pdw_Regras.GetItemNumber(pl_Row, "taxa_custo_suplementar"), &
			pdw_Regras.GetItemNumber(pl_Row, "preco_fixo"), &
			ivdc_Null, &
			ivc_Null, &
			ivdc_Null, &
			pdw_Regras.GetItemNumber(pl_Row, "numero_unidades"), &
			pdw_Regras.GetItemString(pl_Row, "unidade_medida"), &
			pdw_Regras.GetItemNumber(pl_Row, "base_reducao_federal"), &
			pdw_Regras.GetItemNumber(pl_Row, "base_reducao_estado"), &
			pdw_Regras.GetItemNumber(pl_Row, "reducao_icms_sub_fiscal"), &
			pdw_Regras.GetItemNumber(pl_Row, "sub_trib_preco_minimo"), &
			pdw_Regras.GetItemString(pl_Row, "moeda"), &
			pdw_Regras.GetItemNumber(pl_Row, "fator_preco_minimo"), &
			pdw_Regras.GetItemString(pl_Row, "preco_minimo_sem_sobrataxas"), &
			pdw_Regras.GetItemNumber(pl_Row, "reducao_fcp_federal"), &
			pdw_Regras.GetItemNumber(pl_Row, "reducao_fcp_estadual"), &
			ivs_Null, &
			ivc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivc_Null, &
			ivc_Null, &
			ivc_Null, &
			ivc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivdc_Null, &
			ivs_Null, &
			ivdc_Null, &
			ivs_Null, &
			ivs_Null, &
			pdw_Regras.GetItemString(pl_Row, "regra"), &
			lvl_cd_produto_sybase, &
			lvs_de_produto, &
			lvl_ncm, &
			lvs_ncm_situacao, &
			lvl_ordem_regra_sql &
		)
		
	Case Else
		ivs_de_Obs = "Tabela desconhecida: "+ivs_cd_tabela_sap
		Return False
		
End Choose

Return True
end function

private function string of_get_tabela (string ps_imposto);Choose Case ps_Imposto
	Case 'PIS'
		Return 'J_1BTXPIS'
		
	Case 'COFINS'
		Return 'J_1BTXCOF'
		
	Case 'ICMS'
		Return 'J_1BTXIC3'
		
	Case 'ST'
		Return 'J_1BTXST3'
		
	Case 'ISS'
		Return 'J_1BTXISS'
		
	Case 'IPI'
		Return 'J_1BTXIP3'
		
End Choose

Return ''
end function

private function boolean of_insert_log_exportacao_j1btax ();
Insert Into log_exportacao_j1btax (	nr_controle,
												dh_inicio,
												id_modulo,
												id_imposto,
												id_grupo,
												id_revisao,
												dh_revisao_ini,
												dh_revisao_fim,
												cd_tabela_sap,
												cd_ambiente_sap,
												nr_matricula_responsavel,
												dh_inicio_geracao,
												dh_termino_geracao,
												id_exportado_planilha,
												de_obs,
												mandt,
												qt_registros_gerados,
												qt_tempo_geracao,
												id_imposto_futuro,
												dh_imposto_futuro,
												nr_versao_fi,
												id_situacao_relatorio,
												id_situacao_aprovacao,
												id_situacao_exportacao,
												nr_matricula_resp_aprovacao,
												dh_aprovacao,
												dh_exportacao,
												dh_finalizacao,
												id_aceitou_retroativo,
												nr_versao_fi_recente)
Values (	:ivl_nr_controle,
			:ivdh_inicio,
			:ivs_id_modulo,
			:ivs_id_imposto,
			:ivs_id_grupo,
			:ivc_id_revisao,
			:ivdh_revisao_ini,
			:ivdh_revisao_fim,
			:ivs_cd_tabela_sap,
			:ivs_cd_ambiente_sap,
			:ivs_nr_matricula_responsavel,
			:ivdh_inicio_geracao,
			:ivdh_termino_geracao,
			:ivc_id_exportado_planilha,
			:ivs_de_obs,
			:ivs_mandt,
			:ivl_qt_registros_gerados,
			:ivl_qt_tempo_geracao,
			:ivs_id_imposto_futuro,
			:ivdh_imposto_futuro,
			:ivs_nr_versao_fi,
			:ivs_id_situacao_relatorio,
			:ivs_id_situacao_aprovacao,
			:ivs_id_situacao_exportacao,
			:ivs_nr_matricula_resp_aprovacao,
			:ivdh_aprovacao,
			:ivdh_exportacao,
			:ivdh_finalizacao,
			:ivc_id_aceitou_retroativo,
			:ivs_nr_versao_fi_recente
)
Using itr_Transacao;

If itr_Transacao.SqlCode = -1 Then
	ivs_de_Obs = "of_insert_log_exportacao_j1btax: "+itr_Transacao.SqlErrText
	Return False
End If

Return True
end function

private function boolean of_insert_log_exportacao_j1btax_item (long pl_item, string ps_country, string ps_gruop, string ps_land1, string ps_shipfrom, string ps_shipto, string ps_taxjurcode, string ps_value, string ps_value2, string ps_value3, string ps_stgrp, datetime pdh_validfrom, datetime pdh_validto, character pc_sur_type, decimal pdc_rate, decimal pdc_price, decimal pdc_base, character pc_exempt, decimal pdc_amount, decimal pdc_factor, string ps_unit, decimal pdc_basered1, decimal pdc_basered2, decimal pdc_icmsbaser, decimal pdc_minprice, string ps_waers, decimal pdc_minfact, character pc_surchin, decimal pdc_fcp_basered1, decimal pdc_fcp_basered2, string ps_taxlaw, character pc_conven100, decimal pdc_specf_rate, decimal pdc_specf_base, character pc_specf_resale, character pc_partilha_exempt, character pc_taxrelloc, character pc_withhold, decimal pdc_minval_wt, decimal pdc_rate4dec, decimal pdc_amount4dec, decimal pdc_factor4dec, decimal pdc_minprice_amount, string ps_minprice_currency, decimal pdc_minprice_quantity, string ps_minprice_uom, string ps_minprice_taxlaw, string ps_regra, long pl_cd_produto_sybase, string ps_de_produto, long pl_ncm, string ps_ncm_situacao, long pl_ordem_regra_sql);
pdc_rate 					= round(pdc_rate, 				2)
pdc_price 					= round(pdc_price, 				2)
pdc_base 					= round(pdc_base,	 				2)
pdc_amount 					= round(pdc_amount, 				2)
pdc_factor 					= round(pdc_factor, 				2)
pdc_basered1	 			= round(pdc_basered1, 			2)
pdc_basered2 				= round(pdc_basered2, 			2)
pdc_icmsbaser	 			= round(pdc_icmsbaser,			2)
pdc_minprice 				= round(pdc_minprice, 			2)
pdc_minfact 				= round(pdc_minfact, 			2)
pdc_fcp_basered1			= round(pdc_fcp_basered1, 		2)
pdc_fcp_basered2 			= round(pdc_fcp_basered2, 		2)
pdc_specf_rate 			= round(pdc_specf_rate, 		2)
pdc_specf_base 			= round(pdc_specf_base, 		2)
pdc_minval_wt 				= round(pdc_minval_wt, 			2)
pdc_rate4dec 				= round(pdc_rate4dec, 			4)
pdc_amount4dec 			= round(pdc_amount4dec, 		4)
pdc_factor4dec 			= round(pdc_factor4dec, 		2) // nas tabelas $$HEX1$$e900$$ENDHEX$$ scale 2
pdc_minprice_amount 	 	= round(pdc_minprice_amount, 	2)
pdc_minprice_quantity 	= round(pdc_minprice_quantity,3)
ps_regra 					= Left(ps_regra, 					150)

Insert Into log_exportacao_j1btax_item (	nr_controle,   
														nr_item,   
														country,   
														gruop,   
														land1,   
														shipfrom,   
														shipto,   
														taxjurcode,   
														value,   
														value2,   
														value3,   
														stgrp,   
														validfrom,   
														validto,   
														sur_type,   
														rate,   
														price,   
														base,   
														exempt,   
														amount,   
														factor,   
														unit,   
														basered1,   
														basered2,   
														icmsbaser,   
														minprice,   
														waers,   
														minfact,   
														surchin,   
														fcp_basered1,   
														fcp_basered2,   
														taxlaw,   
														conven100,   
														specf_rate,   
														specf_base,   
														specf_resale,   
														partilha_exempt,   
														taxrelloc,   
														withhold,   
														minval_wt,   
														rate4dec,   
														amount4dec,   
														factor4dec,   
														minprice_amount,   
														minprice_currency,   
														minprice_quantity,   
														minprice_uom,   
														minprice_taxlaw,   
														regra,
														cd_produto_sybase,
														de_produto,
														ncm,
														ncm_situacao,
														ordem_regra_sql)
Values (	:ivl_nr_controle,
			:pl_item,
			:ps_country, 
			:ps_gruop, 
			:ps_land1, 
			:ps_shipfrom, 
			:ps_shipto, 
			:ps_taxjurcode, 
			:ps_value, 
			:ps_value2, 
			:ps_value3, 
			:ps_stgrp, 
			:pdh_validfrom, 
			:pdh_validto, 
			:pc_sur_type, 
			:pdc_rate, 
			:pdc_price, 
			:pdc_base, 
			:pc_exempt, 
			:pdc_amount, 
			:pdc_factor, 
			:ps_unit, 
			:pdc_basered1, 
			:pdc_basered2, 
			:pdc_icmsbaser, 
			:pdc_minprice, 
			:ps_waers, 
			:pdc_minfact, 
			:pc_surchin, 
			:pdc_fcp_basered1, 
			:pdc_fcp_basered2, 
			:ps_taxlaw, 
			:pc_conven100, 
			:pdc_specf_rate, 
			:pdc_specf_base, 
			:pc_specf_resale, 
			:pc_partilha_exempt, 
			:pc_taxrelloc, 
			:pc_withhold, 
			:pdc_minval_wt, 
			:pdc_rate4dec, 
			:pdc_amount4dec, 
			:pdc_factor4dec, 
			:pdc_minprice_amount, 
			:ps_minprice_currency, 
			:pdc_minprice_quantity, 
			:ps_minprice_uom, 
			:ps_minprice_taxlaw, 
			:ps_regra,
			:pl_cd_produto_sybase,
			:ps_de_produto,
			:pl_ncm,
			:ps_ncm_situacao,
			:pl_ordem_regra_sql
)
Using itr_Transacao;

If itr_Transacao.SqlCode = -1 Then
	ivs_de_Obs = "of_insert_log_exportacao_j1btax_item: ~r~r"+itr_Transacao.SqlErrText
	Return False
End If

ivl_qt_itens ++

Return True
end function

private function long of_proximo_nr_controle ();
Long lvl_Max

Select max(nr_controle)
Into :lvl_Max
From log_exportacao_j1btax
Using itr_Transacao;

If itr_Transacao.SqlCode = -1 Then
	ivs_de_Obs = "of_Proximo_nr_Controle: "+itr_Transacao.SqlErrText
	Return -1
End If

If Not IsNull(lvl_Max) Then Return lvl_Max+1

Return 1
end function

public function boolean of_geracao_finalizada (long pl_qt_registros_gerados);Boolean lvb_Sucesso=False

Try
	ivdh_termino_geracao 		= gf_GetServerDate()
	ivl_qt_tempo_geracao 		= of_calc_tempo_geracao()
	ivl_qt_registros_gerados 	= pl_qt_registros_gerados
	ivs_id_situacao_relatorio  = 'G' // Gerado
	
	Update log_exportacao_j1btax
	Set 	dh_termino_geracao 	= :ivdh_termino_geracao,
			de_obs					= :ivs_de_Obs,
			qt_tempo_geracao 		= :ivl_qt_tempo_geracao,
			qt_registros_gerados = :ivl_qt_registros_gerados,
			id_situacao_relatorio= :ivs_id_situacao_relatorio
	Where nr_controle 			= :ivl_nr_controle
	Using itr_Transacao;
	
	If itr_Transacao.SqlCode = -1 Then
		ivs_de_Obs = "of_geracao_finalizada: "+itr_Transacao.SqlErrText
		Return lvb_Sucesso
	End If
	
	lvb_Sucesso = True
	
	Return lvb_Sucesso
	
Finally
	If lvb_Sucesso Then
		itr_Transacao.of_Commit()
	Else
		itr_Transacao.of_Rollback()
	End If
	
End Try
end function

public function boolean of_exportacao_finalizada (boolean pb_exportou);Boolean lvb_Sucesso=False
String lvs_Parametro

Try
	
	ivc_id_exportado_planilha 	= iif(pb_Exportou, 'S', 'N')
	ivs_id_situacao_relatorio	= 'C' // Confirmado
	
	// Par$$HEX1$$e200$$ENDHEX$$metro do imposto deve estar ativo para enviar para aprova$$HEX2$$e700e300$$ENDHEX$$o
	lvs_Parametro = "ID_APROVA_"+ivs_id_imposto
	If gf_ge589_parametro_j1btax(lvs_Parametro, ivs_cd_ambiente_sap) = 'S' Then
		ivs_id_situacao_aprovacao	= 'P' // Aprova$$HEX2$$e700e300$$ENDHEX$$o Pendente
		ivl_qt_registros_gerados	= ivl_qt_itens
	End If
	
	Update log_exportacao_j1btax
	Set 	id_exportado_planilha 	= :ivc_id_exportado_planilha,
			de_obs 						= :ivs_de_obs,
			qt_registros_gerados		= :ivl_qt_registros_gerados,
			id_situacao_relatorio	= :ivs_id_situacao_relatorio, 
			id_situacao_aprovacao	= :ivs_id_situacao_aprovacao 
	Where nr_controle = :ivl_nr_controle
	Using itr_Transacao;
	
	If itr_Transacao.SqlCode = -1 Then
		ivs_de_Obs = "of_exportacao_finalizada: "+itr_Transacao.SqlErrText
		Return lvb_Sucesso
	End If
	
	lvb_Sucesso = True
	
	Return lvb_Sucesso
	
Finally
	If lvb_Sucesso Then
		itr_Transacao.of_Commit()
	Else
		itr_Transacao.of_Rollback()
	End If
	
End Try
end function

public function boolean of_atualiza_qt_registros_gerados (long pl_qt_registros_gerados);ivl_qt_registros_gerados = pl_qt_registros_gerados

UPDATE log_exportacao_j1btax
SET	 qt_registros_gerados = :ivl_qt_registros_gerados
WHERE	 nr_controle = :ivl_nr_controle
USING SQLCA;

If SQLCA.SQLCode = -1 Then
	ivs_de_obs = "Erro ao atualizar qt_registros_gerados. Controle: "+String(ivl_nr_controle)
	Return False
End If

SQLCA.of_Commit()

Return True
end function

public function long of_calc_tempo_geracao ();If Date(ivdh_termino_geracao) = Date(ivdh_inicio_geracao) Then
	Return SecondsAfter(Time(ivdh_inicio_geracao), Time(ivdh_termino_geracao))
Else
	Return SecondsAfter(Time(ivdh_inicio_geracao), Time("23:59:59")) + SecondsAfter(Time("00:00:00"), Time(ivdh_termino_geracao))
End If
end function

public function boolean of_geracao_iniciada (datetime pdh_inicio, string ps_id_modulo, string ps_id_imposto, string ps_id_grupo, character pc_id_revisao, datetime pdh_revisao_ini, datetime pdh_revisao_fim, string ps_cd_ambiente_sap, string ps_id_imposto_futuro, datetime pdh_imposto_futuro, character pc_aceitou_retroativo);
//Environment lve_Ambiente
DateTime lvdh_Null
SetNull(lvdh_Null)
SetNull(ivs_Null)

ivl_nr_controle 		= of_Proximo_nr_Controle()
If ivl_nr_controle 	= -1 Then Return False

ivdh_inicio				= pdh_inicio
ivs_id_modulo			= ps_id_modulo
ivs_id_imposto			= ps_id_imposto
ivs_id_grupo			= ps_id_grupo
ivc_id_revisao			= pc_id_revisao
ivdh_revisao_ini 		= iif((ivc_id_revisao='S'), pdh_revisao_ini, lvdh_Null)
ivdh_revisao_fim 		= iif((ivc_id_revisao='S'), pdh_revisao_fim, lvdh_Null)
ivs_cd_tabela_sap 	= of_get_tabela(ivs_id_imposto)
ivs_cd_ambiente_sap	= ps_cd_ambiente_sap
ivs_nr_matricula_responsavel 	= gvo_Aplicacao.ivo_seguranca.Nr_Matricula
ivdh_inicio_geracao				= gf_GetServerDate()
ivdh_termino_geracao 			= lvdh_Null
ivc_id_exportado_planilha 		= 'N'
SetNull(ivs_de_obs)
ivs_mandt 							= '500'
ivs_id_imposto_futuro			= ps_id_imposto_futuro
ivdh_imposto_futuro				= pdh_imposto_futuro

ivl_qt_itens						= 0

//GetEnvironment(lve_Ambiente)
ivs_nr_versao_fi					= gvo_Aplicacao.ivs_versao//iif((lve_Ambiente.machinecode), gvo_Aplicacao.ivs_versao, gvo_Aplicacao.ivs_versao+" DES")

ivs_id_situacao_relatorio 	= 'I' // Gera$$HEX2$$e700e300$$ENDHEX$$o Iniciada
ivs_id_situacao_aprovacao	= 'N' // N$$HEX1$$e300$$ENDHEX$$o Confirmado
ivs_id_situacao_exportacao	= 'A' // Aguardando Envio

ivs_nr_matricula_resp_aprovacao	= ivs_Null
ivdh_aprovacao 						= lvdh_Null
ivdh_exportacao 						= lvdh_Null
ivdh_finalizacao 						= lvdh_Null

ivc_id_aceitou_retroativo = pc_aceitou_retroativo

// Vers$$HEX1$$e300$$ENDHEX$$o recente s$$HEX1$$f300$$ENDHEX$$ possui dados v$$HEX1$$e100$$ENDHEX$$lidos em produ$$HEX2$$e700e300$$ENDHEX$$o
If Lower(itr_transacao.DataBase) <> 'homologa' Then
	ivs_nr_versao_fi_recente  = of_Get_Last_nr_Versao_FI()
Else
	ivs_nr_versao_fi_recente  = 'homologa'
End If

If Not of_insert_log_exportacao_j1btax() Then Return False

itr_Transacao.of_Commit()
Return True
end function

public function string of_get_last_nr_versao_fi ();String lvs_Last_FI

SELECT TOP 1 nr_versao
INTO :lvs_Last_FI
FROM sistema_versao
WHERE cd_sistema = 'FI'
ORDER BY dh_liberacao DESC
USING itr_transacao;

Return lvs_Last_FI
end function

on uo_ge589_log_j1btax.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge589_log_j1btax.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;itr_Transacao = SQLCA
end event

