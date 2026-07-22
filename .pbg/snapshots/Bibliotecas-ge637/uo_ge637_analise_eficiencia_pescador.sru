HA$PBExportHeader$uo_ge637_analise_eficiencia_pescador.sru
forward
global type uo_ge637_analise_eficiencia_pescador from nonvisualobject
end type
end forward

global type uo_ge637_analise_eficiencia_pescador from nonvisualobject
end type
global uo_ge637_analise_eficiencia_pescador uo_ge637_analise_eficiencia_pescador

type variables
dc_uo_transacao	ISQLCA_CONSULTA

String	is_sql_completo	= ''
end variables

forward prototypes
public function boolean of_cria_conexao_consulta (ref string as_log)
public function boolean of_destroi_conexao_consulta (ref string as_log)
public function boolean of_idx_1_avaliar_distribuidoras_resumo (ref string as_log)
public function boolean of_idx_2_avaliar_distribuidoras_resumo (ref string as_log)
public function boolean of_idx_3_base_ruptura_estado (ref string as_log)
public function boolean of_idx_4_base_ruptura_geral (ref string as_log)
public function boolean of_in_analise_ruptura_estadual (ref string as_log)
public function boolean of_in_analise_ruptura_geral (ref string as_log)
public function boolean of_in_avaliar_atendimento_dist (string as_cd_distribuidora, ref string as_log)
public function boolean of_in_avaliar_distribuidoras (ref string as_log)
public function boolean of_in_avaliar_distribuidoras_resumo (ref string as_log)
public function boolean of_in_base_ruptura_estado (ref string as_log)
public function boolean of_in_base_ruptura_geral (ref string as_log)
public function boolean of_in_distribuidoras_prod_prob (ref string as_log)
public function boolean of_in_prod_sem_dest_estado (ref string as_log)
public function boolean of_in_produtos_sem_destino (ref string as_log)
public function boolean of_in_venda_perdida (ref string as_log)
public function boolean of_list_analise_ruptura_geral (ref string as_log)
public function boolean of_list_avaliar_atendimento_dist (ref dc_uo_ds_base ads_avaliar_atendimento_dist, ref string as_log)
public function boolean of_update_vl_venda (ref string as_log)
public function boolean of_list_avaliar_atendimento_dist_sku (ref dc_uo_ds_base ads_avaliar_atendimento_dist_sku, ref string as_log)
public function boolean of_list_analise_ruptura_estado (ref string as_log)
public function boolean of_update_avaliar_atend_dist_filial_ref (ref string as_log)
public function boolean of_in_filial (long al_cd_filial, string as_id_rede_filial, string as_cd_unidade_federacao, ref string as_log)
public function boolean of_in_pedido_filial_produto (date ad_dt_inicio, date ad_dt_fim, ref string as_log)
public function boolean of_in_bloqueio_preco (ref string as_log)
public function boolean of_in_produto (long al_cd_produto, long al_cd_grupo, string as_cd_curva, string as_nr_comprador, long al_divisao, string as_cd_fornecedor, string as_id_apenas_prod_ter_ava, ref string as_log)
public function boolean of_update_avaliar_atend_dist_bloq_pre (string as_id_bloqueio_preco, ref string as_log)
public function boolean of_update_avaliar_atend_dist_rup_est (string as_id_cons_rup_estadual, decimal adc_ruptura, long al_dias_alerta_ruptura, ref string as_log)
public function boolean of_update_avaliar_atend_dist_rup_ger (string as_id_cons_rup_geral, decimal adc_ruptura, integer al_dias_alerta_ruptura, ref string as_log)
public function boolean of_save_avaliar_atendimento_dist (ref string as_log)
public function boolean of_update_avaliar_atendimento_dist (ref string as_log)
public function boolean of_update_vl_custo_gerencial (ref string as_log)
public function boolean of_handle (long al_cd_filial, string as_id_rede_filial, string as_cd_unidade_federacao, datetime adt_dh_inicio, datetime adt_dh_fim, long al_cd_produto, long al_cd_grupo_produto, long al_nr_divisao, string as_cd_curva, string as_id_apenas_prod_ter_ava, string as_nr_comprador, string as_cd_distribuidora, string as_cd_fornecedor, string as_id_cons_rup_estadual, string as_id_cons_rup_geral, decimal adc_ruptura, long al_dias_alerta_ruptura, string as_id_bloqueio_preco, boolean ab_monitora_tempo_execucao, ref string as_log)
public function boolean of_handle_auto ()
end prototypes

public function boolean of_cria_conexao_consulta (ref string as_log);Boolean	lb_retorno	= False

Try
	ISQLCA_CONSULTA	= Create dc_uo_transacao
	ISQLCA_CONSULTA.ivs_database = "SYBASE"
	
	ISQLCA_CONSULTA.of_Connect(gvo_Aplicacao.ivs_DataSource, 'SQLCA - Als Eficiencia Pescador')
	ISQLCA_CONSULTA.AutoCommit	= true
	
	lb_retorno	= True
Catch (RunTimeError RTE)
	as_log	= "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_cria_conexao_consulta. ~r~rErro: " + RTE.GetMessage()
	
	lb_retorno	= False
Finally
	Return lb_retorno	
End Try
end function

public function boolean of_destroi_conexao_consulta (ref string as_log);Boolean	lb_retorno	= False

Try
	ISQLCA_CONSULTA.of_Disconnect()
	
	Destroy ISQLCA_CONSULTA
	
	lb_retorno	= True
Catch (RunTimeError RTE)
	as_log	= "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_destroi_conexao_consulta. ~r~rErro: " + RTE.GetMessage()
	
	lb_retorno	= False
Finally
	Return lb_retorno	
End Try
end function

public function boolean of_idx_1_avaliar_distribuidoras_resumo (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" CREATE INDEX idx_1 ON #avaliar_distribuidoras_resumo (cd_produto, cd_unidade_federacao) "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao criar $$HEX1$$ed00$$ENDHEX$$ndice na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_distribuidoras_resumo. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_idx_1_avaliar_distribuidoras_resumo" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_idx_1_avaliar_distribuidoras_resumo. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_idx_2_avaliar_distribuidoras_resumo (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" CREATE INDEX idx_2 ON #avaliar_distribuidoras_resumo (cd_produto, cd_unidade_federacao, id_situacao) "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao criar $$HEX1$$ed00$$ENDHEX$$ndice na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_distribuidoras_resumo. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_idx_2_avaliar_distribuidoras_resumo" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_idx_2_avaliar_distribuidoras_resumo. Erro: " + RTE.GetMessage()
	lb_retorno = False
Finally
	Return lb_retorno
End Try

end function

public function boolean of_idx_3_base_ruptura_estado (ref string as_log);Boolean lb_retorno
String ls_sql

Try
   ls_sql = &
   	" CREATE INDEX idx_3 ON #base_ruptura_estado (cd_produto, cd_unidade_federacao) "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
  	execute immediate :ls_sql Using ISQLCA_CONSULTA;

   if ISQLCA_CONSULTA.SQLCode <> 0 then
   	as_log = "Erro ao criar $$HEX1$$ed00$$ENDHEX$$ndice na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #base_ruptura_estado. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_idx_3_base_ruptura_estado" + &
               "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
      lb_retorno = False
      Return lb_retorno
  	end if

   lb_retorno = True
Catch (RunTimeError RTE)
   as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_idx_3_base_ruptura_estado. Erro: " + RTE.GetMessage()
   lb_retorno = False
Finally
   Return lb_retorno
End Try

end function

public function boolean of_idx_4_base_ruptura_geral (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" CREATE INDEX idx_4 ON #base_ruptura_geral (cd_produto) "
	
	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao criar $$HEX1$$ed00$$ENDHEX$$ndice na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #base_ruptura_geral. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_idx_4_base_ruptura_geral" + &
				  "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
lb_retorno = True
Catch (RunTimeError RTE)
    as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_idx_4_base_ruptura_geral. Erro: " + RTE.GetMessage()
    lb_retorno = False
Finally
    Return lb_retorno
End Try

end function

public function boolean of_in_analise_ruptura_estadual (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" select cd_produto, " + &
		" 		  cd_unidade_federacao, " + &
		"		  vl_venda,  " + &
		"		  qt_haver,  " + &
		"  		  qt_demanda_diaria, " + &
		"  		  qt_saldo_momento, " + &		  
		"  		  qt_faturada, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_unidade_federacao = br.cd_unidade_federacao " + &
		"           and ad.cd_produto = br.cd_produto " + &
		"        ) as estoque_estado_todos, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_unidade_federacao = br.cd_unidade_federacao " + &
		"           and ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'A' " + &
		"        ) as estoque_estado_ativo, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_unidade_federacao = br.cd_unidade_federacao " + &
		"           and ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'E' " + &
		"        ) as estoque_estado_espera, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_unidade_federacao = br.cd_unidade_federacao " + &
		"           and ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'P' " + &
		"        ) as estoque_estado_pendente, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_unidade_federacao = br.cd_unidade_federacao " + &
		"           and ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'D' " + &
		"        ) as estoque_estado_div_cadastro, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_unidade_federacao = br.cd_unidade_federacao " + &
		"           and ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'B' " + &
		"        ) as estoque_estado_bloqueado, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_unidade_federacao = br.cd_unidade_federacao " + &
		"           and ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'I' " + &
		"        ) as estoque_estado_inativa, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_unidade_federacao = br.cd_unidade_federacao " + &
		"           and ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'F' " + &
		"        ) as estoque_estado_analise_fiscal " + &
		" into #analise_rupturas_estadual " + &
		" from #base_ruptura_estado br " + &
		" order by 1,2 "
	
	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
	if ISQLCA_CONSULTA.SQlCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #analise_rupturas_estadual. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_analise_ruptura_estadual" + &
					  "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_analise_ruptura_estadual. Erro: " + RTE.GetMessage()
	lb_retorno = False
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_analise_ruptura_geral (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" select cd_produto, " + &
		"		  vl_venda, " + &
		"		  qt_haver, " + &
		"		  qt_demanda_diaria, " + &
		"		  qt_saldo_momento, " + &
		"		  qt_faturada, " + &		  
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_produto = br.cd_produto " + &
		"        ) as estoque_geral_todos, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'A' " + &
		"        ) as estoque_geral_ativo, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'E' " + &
		"        ) as estoque_geral_espera, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'P' " + &
		"        ) as estoque_geral_pendente, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'D' " + &
		"        ) as estoque_geral_div_cadastro, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'B' " + &
		"        ) as estoque_geral_bloqueado, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'I' " + &
		"        ) as estoque_geral_inativa, " + &
		"        ( " + &
		"         select sum(qt_estoque_disponivel) as qt_estoque_disponivel " + &
		"         from #avaliar_distribuidoras_resumo ad " + &
		"         where ad.cd_produto = br.cd_produto " + &
		"           and ad.id_situacao = 'F' " + &
		"        ) as estoque_geral_analise_fiscal " + &
		" into #analise_rupturas_geral " + &
		" from #base_ruptura_geral br " + &
		" order by 1,2 "
	
	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
	if ISQLCA_CONSULTA.SQlCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #analise_rupturas_geral. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_analise_ruptura_geral" + &
				  "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_analise_ruptura_geral. Erro: " + RTE.GetMessage()
	lb_retorno = False
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_avaliar_atendimento_dist (string as_cd_distribuidora, ref string as_log);Boolean 	lb_retorno
String 	ls_sql

Try	
	ls_sql = &
		"	SELECT " + &
		"    	pd.nr_pedido_filial, " + &
		"    	pd.cd_filial, " + &
		"		pdp.cd_produto, " + &
		"    	pd.nr_pedido_distribuidora, " + &
		"    	Coalesce(pdp.qt_pedida, 0) AS qt_pedido_dist, " + &
		"    	Coalesce(pdp.qt_atendida, 0) as qt_atendida, " + &
		"    	Coalesce(pdp.qt_separada, 0) as qt_separada, " + &
		"    	Coalesce(pdp.qt_faturada, 0) as qt_faturada, " + &
		"    	Coalesce(pdp.qt_corte, 0) - Coalesce(pdp.qt_faturada, 0) AS qt_corte, " + &
		"    	Coalesce(pdp.qt_lista_separacao, 0) as qt_lista_separacao, " + &
		"    	pd.cd_distribuidora, " + &
		"    	f.nm_fantasia as de_distribuidora, " + &
		"		pd.id_situacao " + &
		" 	INTO #pedido_distribuidora " + &
		" 	FROM #pedido_filial_produto pfp " + &
		" 	INNER JOIN pedido_distribuidora pd " + &
		"    	ON pd.cd_filial = pfp.cd_filial " + &
		"    	AND pd.nr_pedido_filial = pfp.nr_pedido_filial " + &
		" 	INNER JOIN fornecedor f " + &
		"    	ON f.cd_fornecedor	= pd.cd_distribuidora " + &
		" 	INNER JOIN pedido_distribuidora_produto pdp " + &
		"    	ON pdp.cd_filial = pd.cd_filial " + &
		"    	AND pdp.nr_pedido_distribuidora = pd.nr_pedido_distribuidora " + &
	  	"    	AND pdp.cd_produto = pfp.cd_produto "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
   execute immediate :ls_sql Using ISQLCA_CONSULTA;

   if ISQLCA_CONSULTA.SQLCode <> 0 then
   	as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #pedido_distribuidora. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_avaliar_atendimento_dist" + &
					"~r~r Erro "  + ISQLCA_CONSULTA.SqlErrText
			
     	lb_retorno = False
		  
      Return lb_retorno
  	end if
	  
	ls_sql = &
		"	SELECT " + &
		"    	CASE WHEN COALESCE(pd.qt_faturada, 0) = Coalesce(pfp.qt_sugerida, 0) and COALESCE(pd.qt_faturada, 0) > 0 THEN 'DEMANDA ATENDIDA' " + &
		"    	ELSE 'PROBLEMA' " + &
		"    	END AS situacao, " + &
		"    	pfp.nr_pedido_filial, " + &
		"    	pfp.cd_filial, " + &
		"		pfp.nm_filial, " + &
		" 		pfp.cd_unidade_federacao, " + &	
		"		pfp.id_rede_filial, " + &	
		"    	pd.nr_pedido_distribuidora, " + &
		"    	pfp.cd_produto, " + &
		"    	CAST(null as integer) as id_null, " + &		  
		"    	pfp.de_produto, " + &
		"    	ROUND((pfp.qt_dias_cobertura * pfp.qt_demanda_diaria), 0) AS est_base_venda, " + &
		"    	pfp.qt_dias_cobertura, " + &
		"    	pfp.qt_estoque_base, " + &
		"    	pfp.qt_saldo_momento, " + &
		"    	pfp.qt_demanda_diaria, " + &
		"    	pfp.qt_sugerida, " + &
		"    	pfp.qt_pedida AS qt_demanda, " + &
		"    	COALESCE(pd.qt_pedido_dist, 0) qt_pedido_dist, " + &
		"    	COALESCE(pd.qt_atendida, 0) qt_atendida, " + &
		"    	COALESCE(pd.qt_separada, 0) qt_separada, " + &
		"    	COALESCE(pd.qt_faturada, 0) qt_faturada, " + &
		"    	pfp.qt_rateada, " + &
		"    	pd.qt_corte, " + &
		"    	pd.qt_lista_separacao, " + &
		"    	pd.cd_distribuidora, " + &
		"    	pd.de_distribuidora, " + &
		"    	pfp.dh_emissao, " + &
		"    	pfp.vl_fator_conversao, " + &
		" 		pfp.cd_curva_abc_filiais, " + &
		" 		pfp.cd_curva_abc_perini, " + &
		"		pfp.cd_grupo_produto, " + &
		"		pfp.de_grupo_produto, " + &
		"		pfp.cd_fornecedor, " + &
		"		pfp.nm_fornecedor, " + &
		"		pfp.nr_divisao, " + &
		"		pfp.nm_divisao, " + &
		"		pfp.dh_termino_avaliacao, " + &
		"		pfp.nr_matricula_comprador, " + &
		"		pfp.nm_comprador, " + &
		"		pfp.id_projeto_conexao, " + &
		"		pd.id_situacao, " + &
		"    	CAST(0 AS DECIMAL(12,2)) AS vl_custo_gerencial, " + &		
		"    	0 AS cd_filial_referencia_preco, " + &
		"    	CAST(pfp.vl_preco_venda_filial AS DECIMAL(12,2)) AS vl_venda, " + &
		"    	CAST('N' as varchar(1)) AS id_ruptura_estadual, " + &
		"    	CAST('N' as varchar(1)) AS id_ruptura_geral, " + &
		"    	CAST('N' as varchar(1)) AS id_bloqueio_preco, " + &
		"    	CAST(0 AS decimal(12,2)) AS qt_est_dist, " + &
		"    	CAST(0 AS integer) AS estoque_estado_ativo, " + &
		"    	CAST(0 AS integer) AS estoque_estado_espera, " + &
		"    	CAST(0 AS integer) AS estoque_estado_pendente, " + &
		"    	CAST(0 AS integer) AS estoque_estado_div_cadastro, " + &
		"    	CAST(0 AS integer) AS estoque_estado_analise_fiscal, " + &
		"    	CAST(0 AS integer) AS estoque_estado_bloqueado, " + &
		"    	CAST(0 AS integer) AS estoque_estado_inativa, " + &
		"    	CAST(0 AS integer) AS estoque_geral_ativo, " + &
		"    	CAST(0 AS integer) AS estoque_geral_espera, " + &
		"    	CAST(0 AS integer) AS estoque_geral_pendente, " + &
		"    	CAST(0 AS integer) AS estoque_geral_div_cadastro, " + &
		"    	CAST(0 AS integer) AS estoque_geral_analise_fiscal, " + &
		"    	CAST(0 AS integer) AS estoque_geral_bloqueado, " + &
		"    	CAST(0 AS integer) AS estoque_geral_inativa, " + &
		"		pfp.id_utilizou_desconto_clube " + &
		" 	INTO #avaliar_atendimento_dist " + &
		" 	FROM #pedido_filial_produto pfp " + &
		" 	LEFT JOIN #pedido_distribuidora pd " + &
		"    	ON pd.cd_filial = pfp.cd_filial " + &
		"    	AND pd.nr_pedido_filial = pfp.nr_pedido_filial " + &
		"    	AND pd.cd_produto = pfp.cd_produto "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
   execute immediate :ls_sql Using ISQLCA_CONSULTA;

   if ISQLCA_CONSULTA.SQLCode <> 0 then
   	as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_avaliar_atendimento_dist" + &
					"~r~r Erro "  + ISQLCA_CONSULTA.SqlErrText
			
     	lb_retorno = False
		  
      Return lb_retorno
  	end if
	  
	ls_sql = &
		"	DELETE FROM " + &
		"    	#avaliar_atendimento_dist " + &
		"	WHERE " + &
		"    	#avaliar_atendimento_dist.nr_pedido_distribuidora is not null " + &		
		"    	AND EXISTS (SELECT " + &
		"							1 " + &
		"						FROM " + &
		"							#avaliar_atendimento_dist as aad2 " + &
		"						WHERE " + &
		"							aad2.cd_filial	= #avaliar_atendimento_dist.cd_filial " + &
		"							AND aad2.nr_pedido_filial	= #avaliar_atendimento_dist.nr_pedido_filial " + &
		"							AND aad2.cd_produto	= #avaliar_atendimento_dist.cd_produto " + &
		"							AND aad2.nr_pedido_distribuidora > #avaliar_atendimento_dist.nr_pedido_distribuidora) "
	
	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao deletar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist para retornar apenas ultimo pedido distribuidora do produto x pedido. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_avaliar_atendimento_dist" + &
					"~r~r Erro "  + ISQLCA_CONSULTA.SqlErrText
			
		lb_retorno = False
		  
		Return lb_retorno
	end if
	
	if as_cd_distribuidora = '999999999' then
		ls_sql = &
			"	DELETE FROM " + &
			"    	#avaliar_atendimento_dist " + &
			"	WHERE " + &
			"    	#avaliar_atendimento_dist.cd_distribuidora is not null "
		
		is_sql_completo	+= ls_sql + '; ~r~r'
		
		execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
		if ISQLCA_CONSULTA.SQLCode <> 0 then
			as_log = "Erro ao deletar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist para filtrar sem distribuidora. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_avaliar_atendimento_dist" + &
						"~r~r Erro "  + ISQLCA_CONSULTA.SqlErrText
				
			lb_retorno = False
			  
			Return lb_retorno
		end if
	elseif Not IsNull(as_cd_distribuidora) and Trim(as_cd_distribuidora) <> '' Then
		ls_sql = &
			"	DELETE FROM " + &
			"    	#avaliar_atendimento_dist " + &
			"	WHERE " + &
			"    	#avaliar_atendimento_dist.cd_distribuidora is null " + &
			"    	OR #avaliar_atendimento_dist.cd_distribuidora <> '" + as_cd_distribuidora + "' "
		
		is_sql_completo	+= ls_sql + '; ~r~r'
		
		execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
		if ISQLCA_CONSULTA.SQLCode <> 0 then
			as_log = "Erro ao deletar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist para filtrar por distribuidora. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_avaliar_atendimento_dist" + &
						"~r~r Erro "  + ISQLCA_CONSULTA.SqlErrText
				
			lb_retorno = False
			  
			Return lb_retorno
		end if
	End If

   lb_retorno = True
Catch (RunTimeError RTE)
    as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_avaliar_atendimento_dist. Erro: " + RTE.GetMessage()
Finally
    Return lb_retorno
End Try
end function

public function boolean of_in_avaliar_distribuidoras (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" SELECT cd_unidade_federacao, " + &
		"        dist_possivel, " + &
		"        cd_produto, " + &
		"        vl_venda, " + &
		"        dh_alteracao_situacao, " + &
		"        SUM(qt_demanda_diaria) AS qt_demanda_diaria, " + &
		"        SUM(qt_haver) AS qt_haver, " + &
		"        qt_estoque_disponivel, " + &
		"        id_situacao " + &
		" INTO #avaliar_distribuidoras " + &
		" FROM #distribuidoras_prod_prob " + &
		" GROUP BY cd_unidade_federacao, " + &
		"          dist_possivel, " + &
		"          cd_produto, " + &
		"          vl_venda, " + &
		"          dh_alteracao_situacao, " + &
		"          qt_estoque_disponivel, " + &
		"          id_situacao "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_distribuidoras. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_avaliar_distribuidoras" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_avaliar_distribuidoras. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_avaliar_distribuidoras_resumo (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" SELECT cd_unidade_federacao, " + &
		"        cd_produto, " + &
		"        vl_venda, " + &
		"        qt_demanda_diaria, " + &
		"        qt_haver, " + &
		"        SUM(qt_estoque_disponivel) AS qt_estoque_disponivel, " + &
		"        id_situacao " + &
		" INTO #avaliar_distribuidoras_resumo " + &
		" FROM #avaliar_distribuidoras " + &
		" GROUP BY cd_unidade_federacao, " + &
		"          cd_produto, " + &
		"          vl_venda, " + &
		"          qt_demanda_diaria, " + &
		"          qt_haver, " + &
		"          id_situacao "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_distribuidoras_resumo. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_avaliar_distribuidoras_resumo" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_avaliar_distribuidoras_resumo. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_base_ruptura_estado (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" SELECT cd_produto, " + &
		"        cd_unidade_federacao, " + &
		"        vl_venda, " + &
		"        SUM(qt_saldo_momento) AS qt_saldo_momento, " + &
		"        SUM(qt_faturada) AS qt_faturada, " + &
		"        SUM(qt_demanda_diaria) AS qt_demanda_diaria, " + &
		"        SUM(qt_haver) AS qt_haver " + &
		" INTO #base_ruptura_estado " + &
		" FROM #prod_sem_dest_estado psde " + &
		" GROUP BY cd_produto, " + &
		"          cd_unidade_federacao, " + &
		"          vl_venda "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #base_ruptura_estado. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_base_ruptura_estado" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_base_ruptura_estado. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_base_ruptura_geral (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" SELECT cd_produto, " + &
		"        vl_venda, " + &
		"        SUM(qt_saldo_momento) AS qt_saldo_momento, " + &
		"        SUM(qt_faturada) AS qt_faturada, " + &		
		"        SUM(qt_demanda_diaria) AS qt_demanda_diaria, " + &
		"        SUM(qt_haver) AS qt_haver " + &
		" INTO #base_ruptura_geral " + &
		" FROM #prod_sem_dest_estado psde " + &
		" GROUP BY cd_produto, " + &
		"          vl_venda "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #base_ruptura_geral. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_base_ruptura_geral" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_base_ruptura_geral. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_distribuidoras_prod_prob (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" SELECT dp.cd_unidade_federacao, " + &
		"        p.cd_filial, " + &
		"        dp.cd_distribuidora AS dist_possivel, " + &
		"        p.cd_produto, " + &
		"        COALESCE(p.vl_venda, 0) AS vl_venda, " + &
		"        dp.dh_alteracao_situacao, " + &
		"        dp.qt_estoque_disponivel, " + &
		"        qt_demanda_diaria, " + &
		"        qt_haver, " + &
		"        dp.id_situacao " + &
		" INTO #distribuidoras_prod_prob " + &
		" FROM dbo.distribuidora_produto dp " + &
		" INNER JOIN #produtos_sem_destino p " + &
		"     ON p.cd_produto = dp.cd_produto " + &
		" INNER JOIN distribuidora_uf uf " + &
		"     ON uf.cd_distribuidora = dp.cd_distribuidora " + &
		"     AND uf.cd_unidade_federacao = dp.cd_unidade_federacao " + &
		" INNER JOIN fornecedor fo " + &
		"     ON fo.cd_fornecedor = dp.cd_distribuidora " + &
		" WHERE uf.id_homologando_pedido = 'N' " + &
		"   AND fo.id_distribuidora = 'S' "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #distribuidoras_prod_prob. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_distribuidoras_prod_prob" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_distribuidoras_prod_prob. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_prod_sem_dest_estado (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" SELECT psd.cd_produto, " + &
		"        psd.vl_venda, " + &
		"        psd.qt_demanda_diaria, " + &
		"        psd.qt_haver, " + &
		"        psd.qt_saldo_momento, " + &		
		"        psd.qt_faturada, " + &		
		"        c.cd_unidade_federacao " + &
		" INTO #prod_sem_dest_estado " + &
		" FROM #produtos_sem_destino psd " + &
		" INNER JOIN filial f " + &
		"     ON f.cd_filial = psd.cd_filial " + &
		" INNER JOIN cidade c " + &
		"     ON c.cd_cidade = f.cd_cidade "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #prod_sem_dest_estado. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_prod_sem_dest_estado" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_prod_sem_dest_estado. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_produtos_sem_destino (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" SELECT cd_filial,  " + &
		"			cd_produto,  " + &
		"			qt_demanda_diaria, " + &
		"			qt_saldo_momento, " + &		
		"			qt_faturada, " + &		
		"        COALESCE(qt_demanda, 0) - COALESCE(qt_faturada, 0) AS qt_haver, " + &
		"        cd_filial_referencia_preco,  " + &
		"			vl_venda " + &
		" INTO #produtos_sem_destino " + &
		" FROM #avaliar_atendimento_dist " + &
		" WHERE situacao = 'PROBLEMA' " + &
		"   AND nr_pedido_distribuidora IS NULL "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #produtos_sem_destino. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_produtos_sem_destino" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_produtos_sem_destino. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_venda_perdida (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" select (aad.qt_demanda_diaria * 2) - case when aad.qt_saldo_momento > 0 then aad.qt_saldo_momento else 0 end as qt_possivel_venda_perdida, " + &
		"        aad.vl_venda, " + &
		"        aad.cd_produto, " + &
		"        c.cd_unidade_federacao " + &
		" into   #venda_perdida " + &
		" from   #avaliar_atendimento_dist aad " + &
		" inner join filial f on aad.cd_filial = f.cd_filial " + &
		" inner join cidade c on c.cd_cidade = f.cd_cidade "
	
	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #venda_perdida. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_venda_perdida" + &
				  "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_venda_perdida. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try
end function

public function boolean of_list_analise_ruptura_geral (ref string as_log);Boolean	lb_retorno	= False
Dec{2}	ldc_vl_venda
Dec{4}	ldc_qt_demanda_diaria
Long		ll_qt_haver, ll_estoque_geral_todos, ll_estoque_geral_ativo, &
			ll_estoque_geral_espera, ll_estoque_geral_pendente, ll_estoque_geral_div_cadastro, &
			ll_estoque_geral_bloqueado, ll_estoque_geral_inativa, ll_estoque_geral_analise_fiscal, &
			ll_cd_produto, ll_row, ll_qt_saldo_momento, ll_qt_faturada
String	ls_sql


Try
	/*ids_analise_ruptura_geral = Create dc_uo_ds_base
	ids_analise_ruptura_geral.of_ChangeDataObject("ds_ge637_analise_ruptura_geral")*/
	
	DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA;
	
	ls_sql = &
	"SELECT  " + &
	"	arg.cd_produto, " + &	
	"	arg.vl_venda, " + &	
	"	Coalesce(arg.qt_haver, 0) as qt_haver, " + &	
	"	Coalesce(arg.qt_demanda_diaria, 0) as qt_demanda_diaria, " + &	
	"	Coalesce(arg.qt_saldo_momento, 0) as qt_saldo_momento, " + &	
	"	Coalesce(arg.qt_faturada, 0) as qt_faturada, " + &		
	"	Coalesce(arg.estoque_geral_todos, 0) as estoque_geral_todos, " + &	
	"	Coalesce(arg.estoque_geral_ativo, 0) as estoque_geral_ativo, " + &	
	"	Coalesce(arg.estoque_geral_espera, 0) as estoque_geral_espera, " + &	
	"	Coalesce(arg.estoque_geral_pendente, 0) as estoque_geral_pendente, " + &	
	"	Coalesce(arg.estoque_geral_div_cadastro, 0) as estoque_geral_div_cadastro, " + &	
	"	Coalesce(arg.estoque_geral_bloqueado, 0) as estoque_geral_bloqueado, " + &	
	"	Coalesce(arg.estoque_geral_inativa, 0) as estoque_geral_inativa, " + &	
	"	Coalesce(arg.estoque_geral_analise_fiscal, 0) as estoque_geral_analise_fiscal " + &
	"FROM " + &
	"	#analise_rupturas_geral arg "
		  
	PREPARE SQLSA FROM :ls_sql USING ISQLCA_CONSULTA;
	
	If ISQLCA_CONSULTA.SQLCode = -1 Then
		as_log = "Erro ao realizar ao preparar o cursor na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_analise_ruptura_geral." + "~r~rErro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	End If
	
	OPEN DYNAMIC my_cursor;
	
	If ISQLCA_CONSULTA.SQLCode = -1 Then
		as_log = "Erro ao realizar ao abrir o cursor na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_analise_ruptura_geral." + "~r~rErro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	End If
	
	FETCH 
		my_cursor 
	INTO 
		:ll_cd_produto,
		:ldc_vl_venda,
		:ll_qt_haver, 
		:ldc_qt_demanda_diaria, 
		:ll_qt_saldo_momento, 
		:ll_qt_faturada,
		:ll_estoque_geral_todos, 
		:ll_estoque_geral_ativo, 
		:ll_estoque_geral_espera, 
		:ll_estoque_geral_pendente, 
		:ll_estoque_geral_div_cadastro, 
		:ll_estoque_geral_bloqueado, 
		:ll_estoque_geral_inativa, 
		:ll_estoque_geral_analise_fiscal;
	
	If ISQLCA_CONSULTA.SQLCode = -1 Then
		as_log = "Erro ao realizar o fetch do cursor na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_analise_ruptura_geral." + "~r~rErro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	End If
	 
	Do While ISQLCA_CONSULTA.SQLCode = 0
		/*ll_row	= ids_analise_ruptura_geral.InsertRow(0)
		
		if ll_row > 0 then
			ids_analise_ruptura_geral.Object.cd_produto[ll_row] = ll_cd_produto
			ids_analise_ruptura_geral.Object.vl_venda[ll_row] = ldc_vl_venda
			ids_analise_ruptura_geral.Object.qt_haver[ll_row] = ll_qt_haver
			ids_analise_ruptura_geral.Object.qt_demanda_diaria[ll_row] = ldc_qt_demanda_diaria
			ids_analise_ruptura_geral.Object.qt_saldo_momento[ll_row] = ll_qt_saldo_momento
			ids_analise_ruptura_geral.Object.qt_faturada[ll_row] = ll_qt_faturada
			ids_analise_ruptura_geral.Object.qt_estoque_todos[ll_row] = ll_estoque_geral_todos
			ids_analise_ruptura_geral.Object.qt_estoque_ativo[ll_row] = ll_estoque_geral_ativo
			ids_analise_ruptura_geral.Object.qt_estoque_espera[ll_row] = ll_estoque_geral_espera
			ids_analise_ruptura_geral.Object.qt_estoque_pendente[ll_row] = ll_estoque_geral_pendente
			ids_analise_ruptura_geral.Object.qt_estoque_div_cadastro[ll_row] = ll_estoque_geral_div_cadastro
			ids_analise_ruptura_geral.Object.qt_estoque_bloqueado[ll_row] = ll_estoque_geral_bloqueado
			ids_analise_ruptura_geral.Object.qt_estoque_inativa[ll_row] = ll_estoque_geral_inativa
			ids_analise_ruptura_geral.Object.qt_estoque_analise_fiscal[ll_row] = ll_estoque_geral_analise_fiscal
		end if*/
		 
		FETCH 
			my_cursor 
		INTO 
			:ll_cd_produto,
			:ldc_vl_venda,
			:ll_qt_haver, 
			:ldc_qt_demanda_diaria, 
			:ll_qt_saldo_momento, 
			:ll_qt_faturada,			
			:ll_estoque_geral_todos, 
			:ll_estoque_geral_ativo, 
			:ll_estoque_geral_espera, 
			:ll_estoque_geral_pendente, 
			:ll_estoque_geral_div_cadastro, 
			:ll_estoque_geral_bloqueado, 
			:ll_estoque_geral_inativa, 
			:ll_estoque_geral_analise_fiscal;
	Loop
	
	If ISQLCA_CONSULTA.SQLCode = -1 Then
		as_log = "Erro ao realizar o fetch do cursor na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_analise_ruptura_geral." + "~r~rErro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	End If
	
	CLOSE my_cursor;

	//ids_analise_ruptura_geral.RowsCopy(ids_analise_ruptura_geral.GetRow(), ids_analise_ruptura_geral.RowCount(), Primary!, tab_1.tabpage_1.dw_12, 1, Primary!)
	//ids_analise_ruptura_geral.RowsCopy(ids_analise_ruptura_geral.GetRow(), ids_analise_ruptura_geral.RowCount(), Primary!, tab_1.tabpage_1.dw_16, 1, Primary!)
	
	lb_retorno	= True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_analise_ruptura_geral. Erro: " + RTE.GetMessage()
	
	lb_retorno	= False
Finally
	if not lb_retorno then
		//Destroy ids_analise_ruptura_geral
	end if
	
	Return lb_retorno	
End Try
end function

public function boolean of_list_avaliar_atendimento_dist (ref dc_uo_ds_base ads_avaliar_atendimento_dist, ref string as_log);Boolean	lb_retorno = False
String	ls_sql, ls_Create_DS, ls_Erro_Create_DS


Try
	ls_sql = &
		"SELECT  " + &
		"	aad.cd_filial, " + &
		"	aad.nm_filial, " + &	
		"	aad.id_rede_filial, " + &	
		"	aad.cd_unidade_federacao, " + &	
		"	aad.nr_pedido_filial, " + &	
		"	aad.nr_pedido_distribuidora, " + &
		"	aad.dh_emissao, " + &
		"	aad.id_null, " + &	
		"	aad.cd_produto, " + &
		"	aad.de_produto, " + &
		"	aad.vl_fator_conversao, " + &
		"	aad.est_base_venda, " + &
		"	aad.qt_estoque_base, " + &
		"	aad.qt_saldo_momento, " + &
		"	aad.qt_demanda_diaria, " + &
		"	aad.qt_sugerida, " + &
		"	aad.qt_separada, " + &
		"	aad.qt_demanda, " + &
		"	aad.qt_faturada, " + &
		"	aad.qt_pedido_dist, " + &
		"	aad.qt_rateada, " + &
		"	aad.qt_atendida, " + &
		"	aad.qt_corte, " + &
		"	aad.qt_lista_separacao, " + &
		"	aad.situacao, " + &
		"	aad.cd_distribuidora, " + &
		"	aad.de_distribuidora, " + &
		"	aad.vl_custo_gerencial, " + &
		"	aad.cd_filial_referencia_preco, " + &
		"	aad.vl_venda, " + &
		"	aad.id_ruptura_estadual, " + &
		"	aad.id_ruptura_geral, " + &
		"	aad.id_bloqueio_preco " + &
		"FROM " + &
		"	avaliar_atendimento_dist aad " + &
		"ORDER BY " + &
		"	aad.cd_produto "
	
	ls_Create_DS = ISQLCA_CONSULTA.SyntaxFromSQL(ls_sql,  "style(type=grid)", REF ls_Erro_Create_DS)
	
	IF Len(ls_Erro_Create_DS) > 0 THEN
		as_log = "Erro SyntaxFromSQL '" + ls_Erro_Create_DS+ "'. Fun$$HEX2$$e700e300$$ENDHEX$$o [of_list_avaliar_atendimento_dist]."
		
		lb_retorno	= False
		
		Return lb_retorno
	END IF
	
	if ads_avaliar_atendimento_dist.Create( ls_Create_DS, REF ls_Erro_Create_DS) = -1 Then
		as_log = "Erro SyntaxFromSQL '" + ls_Erro_Create_DS+ "'. Fun$$HEX2$$e700e300$$ENDHEX$$o [of_list_avaliar_atendimento_dist]."
		
		lb_retorno	= False
		
		Return lb_retorno
	END IF
	
	ads_avaliar_atendimento_dist.SetTransObject(ISQLCA_CONSULTA)

	If ads_avaliar_atendimento_dist.Retrieve() < 0 Then
		as_Log = "Erro ao recuperar dados. Erro: " + ISQLCA_CONSULTA.is_LastErrorText
		
		lb_retorno	= False
		
		Return lb_retorno
	End If

	lb_retorno	= True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_avaliar_atendimento_dist. Erro: " + RTE.GetMessage()
	
	lb_retorno	= False
Finally
	Return lb_retorno	
End Try
end function

public function boolean of_update_vl_venda (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" UPDATE #avaliar_atendimento_dist " + &
		" SET vl_venda = COALESCE(pvf.vl_preco_liquido, 0) * pg.vl_fator_conversao " + &
		" FROM dbo.preco_venda_filial pvf " + &
		" INNER JOIN produto_geral pg ON pg.cd_produto = pvf.cd_produto " + &
		" WHERE pvf.cd_produto = #avaliar_atendimento_dist.cd_produto " + &
		"   AND pvf.cd_filial = #avaliar_atendimento_dist.cd_filial_referencia_preco "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_vl_venda" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_update_vl_venda. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try
end function

public function boolean of_list_avaliar_atendimento_dist_sku (ref dc_uo_ds_base ads_avaliar_atendimento_dist_sku, ref string as_log);Boolean	lb_retorno = False
String	ls_sql, ls_Create_DS, ls_Erro_Create_DS


Try
	ls_sql = &
		"SELECT  " + &
		"	aad.id_null, " + &	
		"	aad.cd_produto, " + &
		"	aad.de_produto, " + &
		"	aad.vl_fator_conversao, " + &
		"	Sum(aad.est_base_venda) as est_base_venda, " + &
		"	Sum(aad.qt_estoque_base) as qt_estoque_base, " + &
		"	Sum(aad.qt_saldo_momento) as qt_saldo_momento, " + &
		"	Sum(aad.qt_demanda_diaria) as qt_demanda_diaria, " + &
		"	Sum(aad.qt_sugerida) as qt_sugerida, " + &
		"	Sum(aad.qt_separada) as qt_separada, " + &
		"	Sum(aad.qt_demanda) as qt_demanda, " + &
		"	Sum(aad.qt_faturada) as qt_faturada, " + &
		"	Sum(aad.qt_pedido_dist) as qt_pedido_dist, " + &
		"	Sum(aad.qt_rateada) as qt_rateada, " + &
		"	Sum(aad.qt_atendida) as qt_atendida, " + &
		"	Sum(aad.qt_corte) as qt_corte, " + &
		"	Sum(aad.qt_lista_separacao) as qt_lista_separacao, " + &
		"	Round(Coalesce((Sum(aad.vl_venda * aad.qt_demanda) / Sum(aad.qt_demanda)), 0), 2) as vl_venda_media " + &
		"FROM " + &
		"	#avaliar_atendimento_dist aad " + &
		"GROUP BY " + &
		"	aad.id_null, " + &	
		"	aad.cd_produto, " + &
		"	aad.de_produto, " + &
		"	aad.vl_fator_conversao " + &
		"ORDER BY " + &
		"	aad.cd_produto "
	
	ls_Create_DS = ISQLCA_CONSULTA.SyntaxFromSQL(ls_sql,  "style(type=grid)", REF ls_Erro_Create_DS)
	
	IF Len(ls_Erro_Create_DS) > 0 THEN
		as_log = "Erro SyntaxFromSQL '" + ls_Erro_Create_DS+ "'. Fun$$HEX2$$e700e300$$ENDHEX$$o [of_list_avaliar_atendimento_dist_sku]."
		
		lb_retorno	= False
		
		Return lb_retorno
	END IF
	
	if ads_avaliar_atendimento_dist_sku.Create( ls_Create_DS, REF ls_Erro_Create_DS) = -1 Then
		as_log = "Erro SyntaxFromSQL '" + ls_Erro_Create_DS+ "'. Fun$$HEX2$$e700e300$$ENDHEX$$o [of_list_avaliar_atendimento_dist_sku]."
		
		lb_retorno	= False
		
		Return lb_retorno
	END IF
	
	ads_avaliar_atendimento_dist_sku.SetTransObject(ISQLCA_CONSULTA)

	// Recuperar dados
	If ads_avaliar_atendimento_dist_sku.Retrieve() < 0 Then
		as_Log = "Erro ao recuperar dados. Erro: " + ISQLCA_CONSULTA.is_LastErrorText
		
		lb_retorno	= False
		
		Return lb_retorno
	End If

	lb_retorno	= True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_avaliar_atendimento_dist_sku. Erro: " + RTE.GetMessage()
	
	lb_retorno	= False
Finally
	Return lb_retorno	
End Try
end function

public function boolean of_list_analise_ruptura_estado (ref string as_log);Boolean	lb_retorno	= False
Dec{2}	ldc_vl_venda
Dec{4}	ldc_qt_demanda_diaria
Long		ll_qt_haver, ll_estoque_estado_todos, ll_estoque_estado_ativo, &
			ll_estoque_estado_espera, ll_estoque_estado_pendente, ll_estoque_estado_div_cadastro, &
			ll_estoque_estado_bloqueado, ll_estoque_estado_inativa, ll_estoque_estado_analise_fiscal, &
			ll_cd_produto, ll_row, ll_qt_saldo_momento, ll_qt_faturada
String	ls_sql, ls_cd_unidade_federacao


Try
	/*ids_analise_ruptura_estado = Create dc_uo_ds_base
	ids_analise_ruptura_estado.of_ChangeDataObject("ds_ge637_analise_ruptura_estado")*/
	
	DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA;
	
	ls_sql = &
		"SELECT  " + &
		"	are.cd_produto, " + &	
		"	are.cd_unidade_federacao, " + &	
		"	are.vl_venda, " + &	
		"	Coalesce(are.qt_haver, 0) as qt_haver, " + &	
		"	Coalesce(are.qt_demanda_diaria, 0) as qt_demanda_diaria, " + &	
		"	Coalesce(are.qt_saldo_momento, 0) as qt_saldo_momento, " + &		
		"	Coalesce(are.qt_faturada, 0) as qt_faturada, " + &			
		"	Coalesce(are.estoque_estado_todos, 0) as estoque_estado_todos, " + &	
		"	Coalesce(are.estoque_estado_ativo, 0) as estoque_estado_ativo, " + &	
		"	Coalesce(are.estoque_estado_espera, 0) as estoque_estado_espera, " + &	
		"	Coalesce(are.estoque_estado_pendente, 0) as estoque_estado_pendente, " + &	
		"	Coalesce(are.estoque_estado_div_cadastro, 0) as estoque_estado_div_cadastro, " + &	
		"	Coalesce(are.estoque_estado_bloqueado, 0) as estoque_estado_bloqueado, " + &	
		"	Coalesce(are.estoque_estado_inativa, 0) as estoque_estado_inativa, " + &	
		"	Coalesce(are.estoque_estado_analise_fiscal, 0) as estoque_estado_analise_fiscal " + &
		"FROM " + &
		"	#analise_rupturas_estadual are "
		  
	PREPARE SQLSA FROM :ls_sql USING ISQLCA_CONSULTA;
	
	If ISQLCA_CONSULTA.SQLCode = -1 Then
		as_log = "Erro ao preparar o cursor na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_analise_ruptura_estado." + "~r~rErro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	End If
	
	OPEN DYNAMIC my_cursor;
	
	If ISQLCA_CONSULTA.SQLCode = -1 Then
		as_log = "Erro ao abrir o cursor na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_analise_ruptura_estado." + "~r~rErro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	End If
	
	FETCH 
		my_cursor 
	INTO 
		:ll_cd_produto,
		:ls_cd_unidade_federacao,
		:ldc_vl_venda,
		:ll_qt_haver, 
		:ldc_qt_demanda_diaria, 
		:ll_qt_saldo_momento, 
		:ll_qt_faturada,
		:ll_estoque_estado_todos, 
		:ll_estoque_estado_ativo, 
		:ll_estoque_estado_espera, 
		:ll_estoque_estado_pendente, 
		:ll_estoque_estado_div_cadastro, 
		:ll_estoque_estado_bloqueado, 
		:ll_estoque_estado_inativa, 
		:ll_estoque_estado_analise_fiscal;
	
	If ISQLCA_CONSULTA.SQLCode = -1 Then
		as_log = "Erro ao realizar o fetch do cursor na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_analise_ruptura_estado." + "~r~rErro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	End If
	 
	Do While ISQLCA_CONSULTA.SQLCode = 0
		/*ll_row	= ids_analise_ruptura_estado.InsertRow(0)
		
		if ll_row > 0 then
			ids_analise_ruptura_estado.Object.cd_produto[ll_row] = ll_cd_produto
			ids_analise_ruptura_estado.Object.cd_unidade_federacao[ll_row] = ls_cd_unidade_federacao
			ids_analise_ruptura_estado.Object.vl_venda[ll_row] = ldc_vl_venda
			ids_analise_ruptura_estado.Object.qt_haver[ll_row] = ll_qt_haver
			ids_analise_ruptura_estado.Object.qt_demanda_diaria[ll_row] = ldc_qt_demanda_diaria
			ids_analise_ruptura_estado.Object.qt_saldo_momento[ll_row] = ll_qt_saldo_momento
			ids_analise_ruptura_estado.Object.qt_faturada[ll_row] = ll_qt_faturada			
			ids_analise_ruptura_estado.Object.qt_estoque_todos[ll_row] = ll_estoque_estado_todos
			ids_analise_ruptura_estado.Object.qt_estoque_ativo[ll_row] = ll_estoque_estado_ativo
			ids_analise_ruptura_estado.Object.qt_estoque_espera[ll_row] = ll_estoque_estado_espera
			ids_analise_ruptura_estado.Object.qt_estoque_pendente[ll_row] = ll_estoque_estado_pendente
			ids_analise_ruptura_estado.Object.qt_estoque_div_cadastro[ll_row] = ll_estoque_estado_div_cadastro
			ids_analise_ruptura_estado.Object.qt_estoque_bloqueado[ll_row] = ll_estoque_estado_bloqueado
			ids_analise_ruptura_estado.Object.qt_estoque_inativa[ll_row] = ll_estoque_estado_inativa
			ids_analise_ruptura_estado.Object.qt_estoque_analise_fiscal[ll_row] = ll_estoque_estado_analise_fiscal
		end if*/
		 
		FETCH 
			my_cursor 
		INTO 
			:ll_cd_produto,
			:ls_cd_unidade_federacao,
			:ldc_vl_venda,
			:ll_qt_haver, 
			:ldc_qt_demanda_diaria, 
			:ll_qt_saldo_momento, 
			:ll_qt_faturada,			
			:ll_estoque_estado_todos, 
			:ll_estoque_estado_ativo, 
			:ll_estoque_estado_espera, 
			:ll_estoque_estado_pendente, 
			:ll_estoque_estado_div_cadastro, 
			:ll_estoque_estado_bloqueado, 
			:ll_estoque_estado_inativa, 
			:ll_estoque_estado_analise_fiscal;
	Loop
	
	If ISQLCA_CONSULTA.SQLCode = -1 Then
		as_log = "Erro ao realizar o fetch do cursor na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_analise_ruptura_estado." + "~r~rErro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	End If
	
	CLOSE my_cursor;

	//ids_analise_ruptura_estado.RowsCopy(ids_analise_ruptura_estado.GetRow(), ids_analise_ruptura_estado.RowCount(), Primary!, tab_1.tabpage_1.dw_8, 1, Primary!)
	//ids_analise_ruptura_estado.RowsCopy(ids_analise_ruptura_estado.GetRow(), ids_analise_ruptura_estado.RowCount(), Primary!, tab_1.tabpage_1.dw_9, 1, Primary!)
	
	//tab_1.tabpage_1.dw_9.Sort()
	
	lb_retorno	= True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_list_analise_ruptura_estado. Erro: " + RTE.GetMessage()
	
	lb_retorno	= False
Finally
	if not lb_retorno then
		//Destroy ids_analise_ruptura_estado
	end if
	
	Return lb_retorno	
End Try
end function

public function boolean of_update_avaliar_atend_dist_filial_ref (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" UPDATE #avaliar_atendimento_dist " + &
		" SET cd_filial_referencia_preco = ( " + &
		"    SELECT cd_filial_referencia " + &
		"    FROM preco_venda_filial_referencia pvfr " + &
		"    WHERE pvfr.cd_uf = c.cd_unidade_federacao " + &
		"      AND f.id_rede_filial = pvfr.id_rede_filial " + &
		") " + &
		" FROM filial f " + &
		" INNER JOIN cidade c " + &
		"    ON c.cd_cidade = f.cd_cidade " + &
		" WHERE f.cd_filial = #avaliar_atendimento_dist.cd_filial "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atendimento_dist" + &
			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	ls_sql = &
		" DELETE FROM #avaliar_atendimento_dist " + &
		" WHERE cd_distribuidora = '053404705' "// + &
//		" AND id_projeto_conexao is null "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao deletar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist para distribuidora CD. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atendimento_dist" + &
			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_update_avaliar_atendimento_dist. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_filial (long al_cd_filial, string as_id_rede_filial, string as_cd_unidade_federacao, ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		"SELECT " + &
		"	f.cd_filial, " + &
		"	f.nm_fantasia, " + &
		"	f.id_rede_filial, " + &
		"	c.cd_unidade_federacao " + &
		"INTO " + &
		"	#filial " + &
		"FROM " + &
		"	filial f " + &
		"INNER JOIN " + &
		"	cidade c " + &
		"	ON c.cd_cidade = f.cd_cidade " + &
		"WHERE f.id_centro_distribuicao = 'N' "
		  
	if Not IsNull(al_cd_filial) and al_cd_filial > 0 then
		ls_sql += " AND f.cd_filial	= " + String(al_cd_filial)
	end if
	
	if Not IsNull(as_id_rede_filial) and Trim(as_id_rede_filial) <> '' Then
		ls_sql += " AND f.id_rede_filial	= '" + as_id_rede_filial + "'"
	End If
	
	if Not IsNull(as_cd_unidade_federacao) and Trim(as_cd_unidade_federacao) <> '' Then
		ls_sql += " AND c.cd_unidade_federacao	= '" + as_cd_unidade_federacao + "'"
	End If
	
	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

   if ISQLCA_CONSULTA.SQLCode <> 0 then
   	as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #filial. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_filial" + &
      			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
     	lb_retorno = False
      Return lb_retorno
 	end if

   lb_retorno = True
Catch (RunTimeError RTE)
   as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_filial. Erro: " + RTE.GetMessage()
Finally
   Return lb_retorno
End Try
end function

public function boolean of_in_pedido_filial_produto (date ad_dt_inicio, date ad_dt_fim, ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		"CREATE TABLE #pedido_filial_produto (" + &
		 "	nr_pedido_filial           INT NULL," + &
		 "	cd_filial                  INT NULL," + &
		 "	dh_emissao                 DATETIME NULL," + &
		 "	cd_produto               	INT NULL," + &
		 "	de_produto               	VARCHAR(100) NULL," + &
		 "	vl_fator_conversao       	DECIMAL(10,4) NULL," + &
		 "	cd_curva_abc_filiais     	CHAR(1) NULL," + &
		 "	cd_curva_abc_perini      	CHAR(1) NULL," + &
		 "	cd_grupo_produto         	SMALLINT NULL," + &
		 "	de_grupo_produto         	VARCHAR(40) NULL," + &
		 "	cd_fornecedor            	VARCHAR(9) NULL," + &
		 "	nm_fornecedor            	VARCHAR(40) NULL," + &
		 "	nr_divisao               	SMALLINT NULL," + &
		 "	nm_divisao               	VARCHAR(40) NULL," + &
		 "	dh_termino_avaliacao     	DATETIME NULL," + &
		 "	nr_matricula_comprador   	CHAR(6) NULL," + &
		 "	nm_comprador             	VARCHAR(40) NULL," + &
		 "	qt_dias_cobertura        	SMALLINT NULL," + &
		 "	qt_demanda_diaria        	DECIMAL(9,4) NULL," + &
		 "	qt_estoque_base          	INT NULL," + &
		 "	qt_saldo_momento         	SMALLINT NULL," + &
		 "	qt_sugerida              	SMALLINT NULL," + &
		 "	qt_pedida                	SMALLINT NULL," + &
		 "	qt_rateada               	SMALLINT NULL," + &
		 "	nr_pedido_distribuidora  	INT NULL," + &
		 "	nm_filial                	VARCHAR(40) NULL," + &
		 "	cd_unidade_federacao     	CHAR(2) NULL," + &
		 "	id_rede_filial           	VARCHAR(2) NULL," + &
		 "	vl_preco_venda_filial    	DECIMAL(7,2) NULL," + &
		 "	id_projeto_conexao       	CHAR(1) NULL," + &
		 "	id_utilizou_desconto_clube	CHAR(1) NULL" + &
		 ")"
		 
		 is_sql_completo	+= ls_sql + '; ~r~r'
	
		execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
		if ISQLCA_CONSULTA.SQLCode <> 0 then
			as_log = "Erro ao criar tabela tempor$$HEX1$$e100$$ENDHEX$$ria #pedido_filial_produto.~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_pedido_filial_produto" + &
						"~r~rErro: " + ISQLCA_CONSULTA.SqlErrText
			lb_retorno = False
			Return lb_retorno
		end if
		 
	ls_sql = &
		" INSERT INTO #pedido_filial_produto " + &
		" SELECT " + &
		" 		pfp.nr_pedido_filial, " + &
		" 		pfp.cd_filial, " + &
		" 		pf.dh_emissao, " + &
		" 		pfp.cd_produto, " + &
		" 		p.de_produto, " + &
		" 		p.vl_fator_conversao, " + &
		" 		COALESCE(pfp.cd_classe_reposicao, p.cd_curva_abc_filiais) as cd_curva_abc_filiais, " + &
		" 		p.cd_curva_abc_perini, " + &
		"		p.cd_grupo_produto, " + &
		"		p.de_grupo_produto, " + &
		"		p.cd_fornecedor, " + &
		"		p.nm_fornecedor, " + &
		"		p.nr_divisao, " + &
		"		p.nm_divisao, " + &
		"		p.dh_termino_avaliacao, " + &
		"		p.nr_matricula_comprador, " + &
		"		p.nm_comprador, " + &
		" 		pfp.qt_dias_cobertura, " + &
		" 		pfp.qt_demanda_diaria, " + &
		" 		pfp.qt_estoque_base, " + &
		" 		pfp.qt_saldo_momento, " + &
		" 		pfp.qt_sugerida, " + &
		" 		pfp.qt_pedida, " + &
		" 		pfp.qt_rateada, " + &
		" 		pfp.nr_pedido_distribuidora, " + &	
		" 		f.nm_fantasia as nm_filial, " + &	
		" 		f.cd_unidade_federacao, " + &	
		" 		f.id_rede_filial, " + &	
		" 		pfp.vl_preco_venda_filial, " + &	
		" 		pfp.id_projeto_conexao, " + &
		" 		pfp.id_utilizou_desconto_clube " + &
		" FROM " + &
		"		pedido_filial pf " + &
		" INNER JOIN " + &
		"		dbo.pedido_filial_produto pfp  " + &
		" 		ON pf.cd_filial = pfp.cd_filial  " + &
		" 		AND pf.nr_pedido_filial = pfp.nr_pedido_filial  " + &
		" INNER JOIN " + &
		"		#produto p  " + &
		" 		ON p.cd_produto = pfp.cd_produto  " + &
		" INNER JOIN " + &
		"		#filial f  " + &
		" 		ON f.cd_filial = pf.cd_filial  " + &
		" WHERE " + &
		"		dh_emissao BETWEEN '" + String(ad_dt_inicio, 'YYYY-MM-DD') + "' AND '" + String(ad_dt_fim, 'YYYY-MM-DD') + "' " + &
		" 		AND pf.id_gerado_logistica = 'N' " + &
		"  		AND pfp.id_projeto_conexao IS NULL " +&
		" 		AND Coalesce(pfp.id_compra_via_distrib_bloq, 'N') <> 'S' " +&
		" UNION " +&
		" SELECT DISTINCT" + &
		" 		pfp.nr_pedido_filial, " + &
		" 		pfp.cd_filial, " + &
		" 		pf.dh_emissao, " + &
		" 		pfp.cd_produto, " + &
		" 		p.de_produto, " + &
		" 		p.vl_fator_conversao, " + &
		" 		COALESCE(pfp.cd_classe_reposicao, p.cd_curva_abc_filiais) as cd_curva_abc_filiais, " + &
		" 		p.cd_curva_abc_perini, " + &
		"		p.cd_grupo_produto, " + &
		"		p.de_grupo_produto, " + &
		"		p.cd_fornecedor, " + &
		"		p.nm_fornecedor, " + &
		"		p.nr_divisao, " + &
		"		p.nm_divisao, " + &
		"		p.dh_termino_avaliacao, " + &
		"		p.nr_matricula_comprador, " + &
		"		p.nm_comprador, " + &
		" 		pfp.qt_dias_cobertura, " + &
		" 		pfp.qt_demanda_diaria, " + &
		" 		pfp.qt_estoque_base, " + &
		" 		pfp.qt_saldo_momento, " + &
		" 		pfp.qt_sugerida, " + &
		" 		pfp.qt_pedida, " + &
		" 		pfp.qt_rateada, " + &
		" 		pfp.nr_pedido_distribuidora, " + &	
		" 		f.nm_fantasia as nm_filial, " + &	
		" 		f.cd_unidade_federacao, " + &	
		" 		f.id_rede_filial, " + &	
		" 		pfp.vl_preco_venda_filial, " + &	
		" 		pfp.id_projeto_conexao, " + &
		" 		pfp.id_utilizou_desconto_clube " + &
		" FROM " + &
		"		pedido_filial pf " + &
		" INNER JOIN " + &
		"		dbo.pedido_filial_produto pfp  " + &
		" 		ON pf.cd_filial = pfp.cd_filial  " + &
		" 		AND pf.nr_pedido_filial = pfp.nr_pedido_filial  " + &
		" INNER JOIN " + &
		"		#produto p  " + &
		" 		ON p.cd_produto = pfp.cd_produto  " + &
		" INNER JOIN " + &
		"		#filial f  " + &
		" 		ON f.cd_filial = pf.cd_filial  " + &
		" INNER JOIN pedido_conexao pc   " + &
    		"		ON pc.cd_filial = pfp.cd_filial   " + &
    		"		AND pc.nr_pedido_filial = pfp.nr_pedido_filial   " + &
    		"		AND pc.id_projeto_conexao = pfp.id_projeto_conexao " + &
		" WHERE " + &
		"		dh_emissao BETWEEN '" + String(ad_dt_inicio, 'YYYY-MM-DD') + "' AND '" + String(ad_dt_fim, 'YYYY-MM-DD') + "' " + &
		" 		AND pf.id_gerado_logistica = 'N' " + &
		"  		AND pfp.id_projeto_conexao IS NOT NULL " +&
		" 		AND Coalesce(pfp.id_compra_via_distrib_bloq, 'N') <> 'S' " +&
		"		 AND pc.dh_envio IS NOT NULL " +&
		"		 AND pc.dh_retorno IS NOT NULL " 		

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao inserir registros na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #pedido_filial_produto.~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_pedido_filial_produto" + &
		         "~r~rErro: " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True

Catch (RunTimeError rte)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_pedido_filial_produto. ~r~rErro: " + rte.GetMessage()

Finally
	Return lb_retorno
End Try
end function

public function boolean of_in_bloqueio_preco (ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		"SELECT " + &
		"	aad.cd_filial, " + &
		"	aad.nr_pedido_filial, " + &
		"	aad.cd_produto, " + &
		"	pfpcb.cd_distribuidora " + &
		"INTO " + &
		"	#bloqueio_preco " + &
		"FROM " + &
		"	#avaliar_atendimento_dist aad " + &
		"INNER JOIN " + &
		"	pedido_filial_prd_compra_bloq pfpcb " + &
		"	ON aad.cd_filial = pfpcb.cd_filial " + &
		"	AND aad.cd_produto = pfpcb.cd_produto " + &
		"	AND aad.nr_pedido_filial = pfpcb.nr_pedido_filial"
	
	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #bloqueio_preco. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_bloqueio_preco" + &
				  "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_bloqueio_preco. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_in_produto (long al_cd_produto, long al_cd_grupo, string as_cd_curva, string as_nr_comprador, long al_divisao, string as_cd_fornecedor, string as_id_apenas_prod_ter_ava, ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		"SELECT " + &
		"	pg.cd_produto, " + &
		"	pg.de_produto + ' : ' + pg.de_apresentacao_estoque as de_produto, " + &
		"	pg.vl_fator_conversao, " + &
		"	pc.cd_curva_abc_filiais, " + &
		"	pc.cd_curva_abc_perini, " + &
		"	gp.cd_grupo_produto, " + &
		"	gp.de_grupo_produto, " + &
		"	f.cd_fornecedor, " + &
		"	f.nm_fantasia as nm_fornecedor, " + &
		"	fd.nr_divisao, " + &
		"	fd.nm_divisao, " + &
		"	u.nr_matricula as nr_matricula_comprador, " + &
		"	u.nm_usuario as nm_comprador, " + &
		"	pg.dh_termino_avaliacao " + &
		"INTO " +&
		"	#produto " + &
		"FROM " + &
		"	produto_geral pg " + &
		"INNER JOIN " + &
		"	produto_central pc " + &
		"	ON pc.cd_produto = pg.cd_produto " + &
		"INNER JOIN " + &
		"	grupo_produto gp " + & 
		"	ON gp.cd_grupo_produto = pg.cd_grupo_produto " + &
		"LEFT JOIN " + & 
		"	fornecedor_divisao_produto fdp " + &
		"	ON fdp.cd_produto = pg.cd_produto " + &
		"LEFT JOIN " + & 
		"	fornecedor_divisao fd " + &
		"	ON fd.cd_fornecedor = fdp.cd_fornecedor " + &
		"	AND fd.nr_divisao = fdp.nr_divisao " + &
		"LEFT JOIN " + & 
		"	usuario u " + &
		"	ON u.nr_matricula = fd.nr_matricula_comprador " + &
		"LEFT JOIN " + & 
		"	fornecedor f " + &
		"	ON f.cd_fornecedor = fd.cd_fornecedor " + &
		"WHERE " + & 
		"	pg.id_situacao = 'A'" + &
		"	AND COALESCE(pg.id_servico, 'N') = 'N'" +&
		"	AND pg.cd_produto not in ( select cd_produto from produto_exc_an_efic_pesc ) "
		  
	if Not IsNull(al_cd_produto) and al_cd_produto > 0 then
		ls_sql += " AND pg.cd_produto	= " + String(al_cd_produto)
	end if
	
	if Not IsNull(al_cd_grupo) and al_cd_grupo > 0 Then
		ls_sql += " AND pg.cd_grupo_produto	= " + String(al_cd_grupo)
	End If
	
	if Not IsNull(as_cd_curva) and Trim(as_cd_curva) <> '' Then
		ls_sql += " AND pc.cd_curva_abc_filiais	= '" + as_cd_curva + "'"
	End If
	
	if Not IsNull(as_nr_comprador) and Trim(as_nr_comprador) <> '' Then
		ls_sql += " AND u.nr_matricula	= '" + as_nr_comprador + "'"
	End If
	
	if Not IsNull(al_divisao) and al_divisao > 0 Then
		ls_sql += " AND fd.nr_divisao	= " + String(al_divisao)
	End If
	
	if Not IsNull(as_cd_fornecedor) and Trim(as_cd_fornecedor) <> '' Then
		ls_sql += " AND f.cd_fornecedor	= '" + as_cd_fornecedor + "'"
	End If
	
	If as_id_apenas_prod_ter_ava = 'S' Then
		ls_sql += " AND dh_termino_avaliacao < getdate() and not dh_termino_avaliacao is null "
	End If

	is_sql_completo	+= ls_sql + '; ~r~r'
	
   execute immediate :ls_sql Using ISQLCA_CONSULTA;

   if ISQLCA_CONSULTA.SQLCode <> 0 then
   	as_log = "Erro ao inserir registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #produto. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_in_produto" + &
      			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
     	lb_retorno = False
      Return lb_retorno
 	end if

   lb_retorno = True
Catch (RunTimeError RTE)
   as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_in_produto. Erro: " + RTE.GetMessage()
Finally
   Return lb_retorno
End Try
end function

public function boolean of_update_avaliar_atend_dist_bloq_pre (string as_id_bloqueio_preco, ref string as_log);Boolean lb_retorno
String ls_sql

Try
	ls_sql = &
		" UPDATE #avaliar_atendimento_dist " + &
		" SET id_bloqueio_preco = 'S' " + &
		" WHERE #avaliar_atendimento_dist.cd_distribuidora is null " + &
		" AND EXISTS ( " + &
		"					SELECT  " + &
		"						1 " + &
		"					FROM " + &
		"						#bloqueio_preco bp " + &
		"					WHERE " + &
		"						bp.cd_filial	= #avaliar_atendimento_dist.cd_filial " + &
		"						AND bp.cd_produto	= #avaliar_atendimento_dist.cd_produto " + &
		"						AND bp.nr_pedido_filial	= #avaliar_atendimento_dist.nr_pedido_filial ) "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_bloq_pre" + &
			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	ls_sql = &
		" UPDATE #avaliar_atendimento_dist " + &
		" SET id_bloqueio_preco = 'S' " + &
		" WHERE #avaliar_atendimento_dist.cd_distribuidora is not null " + &
		" AND EXISTS ( " + &
		"					SELECT  " + &
		"						1 " + &
		"					FROM " + &
		"						#bloqueio_preco bp " + &
		"					WHERE " + &
		"						bp.cd_filial	= #avaliar_atendimento_dist.cd_filial " + &
		"						AND bp.cd_produto	= #avaliar_atendimento_dist.cd_produto " + &
		"						AND bp.cd_distribuidora	= #avaliar_atendimento_dist.cd_distribuidora " + &
		"						AND bp.nr_pedido_filial	= #avaliar_atendimento_dist.nr_pedido_filial ) "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_bloq_pre" + &
			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	Choose Case as_id_bloqueio_preco
		Case 'T' //Todos
			//
		Case 'S' //Sem bloqueio de pre$$HEX1$$e700$$ENDHEX$$o
			ls_sql = &
				" DELETE FROM #avaliar_atendimento_dist " + &
				" WHERE #avaliar_atendimento_dist.id_bloqueio_preco = 'S' "
		
			is_sql_completo	+= ls_sql + '; ~r~r'
			
			execute immediate :ls_sql Using ISQLCA_CONSULTA;
		
			if ISQLCA_CONSULTA.SQLCode <> 0 then
				as_log = "Erro ao deletar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist para filtrar apenas produtos sem bloqueio de pre$$HEX1$$e700$$ENDHEX$$o. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_bloq_pre" + &
					"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
				lb_retorno = False
				Return lb_retorno
			end if
		Case 'C' //Com bloqueio de pre$$HEX1$$e700$$ENDHEX$$o
			ls_sql = &
				" DELETE FROM #avaliar_atendimento_dist " + &
				" WHERE #avaliar_atendimento_dist.id_bloqueio_preco = 'N' "
		
			is_sql_completo	+= ls_sql + '; ~r~r'
			
			execute immediate :ls_sql Using ISQLCA_CONSULTA;
		
			if ISQLCA_CONSULTA.SQLCode <> 0 then
				as_log = "Erro ao deletar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist para filtrar apenas produtos com bloqueio de pre$$HEX1$$e700$$ENDHEX$$o. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_bloq_pre" + &
					"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
				lb_retorno = False
				Return lb_retorno
			end if
	End Choose
	
	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_update_avaliar_atend_dist_bloq_pre. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_update_avaliar_atend_dist_rup_est (string as_id_cons_rup_estadual, decimal adc_ruptura, long al_dias_alerta_ruptura, ref string as_log);Boolean 	lb_retorno
Dec{2}	ldc_alerta_ruptura
String 	ls_sql

Try
	if IsNull(al_dias_alerta_ruptura) or al_dias_alerta_ruptura < 1 then
		al_dias_alerta_ruptura	= 1
	end if
	
	ldc_alerta_ruptura	= al_dias_alerta_ruptura * 100
	
	ls_sql = &
		" 	SELECT  " + &
		"		aad.cd_produto, " + &
		"		aad.cd_unidade_federacao, " + &
		"		Sum(aad.qt_demanda) as qt_demanda_total " + &
		"	INTO #total_demanda_produto_estado " + &
		" 	FROM #avaliar_atendimento_dist aad " + &
		" 	GROUP BY " + &
		"		aad.cd_produto, " + &
		"		aad.cd_unidade_federacao "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #total_demanda_produto_estado. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_rup_est" + &
			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	//Alerta de ruptura
	ls_sql = &
		" UPDATE #avaliar_atendimento_dist " + &
		" SET id_ruptura_estadual = 'A' " + &
		" WHERE EXISTS (SELECT  " + &
		"						1 " + &
		"					FROM " + &
		"						#analise_rupturas_estadual are " + &
		"					INNER JOIN " + &
		"						#total_demanda_produto_estado tdpe " + &
		"						ON tdpe.cd_produto	= are.cd_produto " + &
		"						AND tdpe.cd_unidade_federacao	= are.cd_unidade_federacao " + &
		"					WHERE " + &
		"						are.cd_unidade_federacao						= #avaliar_atendimento_dist.cd_unidade_federacao " + &
		"						AND are.cd_produto								= #avaliar_atendimento_dist.cd_produto " + &
		"						AND ((Coalesce(Cast(are.estoque_estado_todos as decimal(12,2)), 0) / Coalesce(Cast(tdpe.qt_demanda_total as decimal(12,2)), 1)) * 100.00)	between " + gf_replace(String(adc_ruptura + 0.01), ',', '.', 0) + " and " + gf_replace(String(ldc_alerta_ruptura), ',', '.', 0) + " ) "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist (Alerta de Ruptura). ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_rup_est" + &
			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	//Ruptura eminente
	ls_sql = &
		" UPDATE #avaliar_atendimento_dist " + &
		" SET id_ruptura_estadual = 'S' " + &
		" WHERE EXISTS (SELECT  " + &
		"						1 " + &
		"					FROM " + &
		"						#analise_rupturas_estadual are " + &
		"					INNER JOIN " + &
		"						#total_demanda_produto_estado tdpe " + &
		"						ON tdpe.cd_produto	= are.cd_produto " + &
		"						AND tdpe.cd_unidade_federacao	= are.cd_unidade_federacao " + &
		"					WHERE " + &
		"						are.cd_unidade_federacao						= #avaliar_atendimento_dist.cd_unidade_federacao " + &
		"						AND are.cd_produto								= #avaliar_atendimento_dist.cd_produto " + &
		"						AND ((Coalesce(Cast(are.estoque_estado_todos as decimal(12,2)), 0) / Coalesce(Cast(tdpe.qt_demanda_total as decimal(12,2)), 1)) * 100.00) <= " + gf_replace(String(adc_ruptura), ',', '.', 0) + " ) "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist (Ruptura Eminente). ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_rup_est" + &
			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	Choose Case as_id_cons_rup_estadual
		Case 'N'
			ls_sql = &
				" DELETE FROM #avaliar_atendimento_dist " + &
				" WHERE id_ruptura_estadual = 'S' "
			
			is_sql_completo	+= ls_sql + '; ~r~r'
			
			execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
			if ISQLCA_CONSULTA.SQLCode <> 0 then
				as_log = "Erro ao deletar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist para n$$HEX1$$e300$$ENDHEX$$o mostrar produtos com ruptura estadual. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_rup_est" + &
					"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
				lb_retorno = False
				Return lb_retorno
			end if
		Case 'A'
			ls_sql = &
				" DELETE FROM #avaliar_atendimento_dist " + &
				" WHERE id_ruptura_estadual <> 'S' "
			
			is_sql_completo	+= ls_sql + '; ~r~r'
			
			execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
			if ISQLCA_CONSULTA.SQLCode <> 0 then
				as_log = "Erro ao deletar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist para n$$HEX1$$e300$$ENDHEX$$o mostrar produtos sem ruptura estadual. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_rup_est" + &
					"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
				lb_retorno = False
				Return lb_retorno
			end if
	End Choose
	
	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_update_avaliar_atend_dist_rup_est. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try
end function

public function boolean of_update_avaliar_atend_dist_rup_ger (string as_id_cons_rup_geral, decimal adc_ruptura, integer al_dias_alerta_ruptura, ref string as_log);Boolean 	lb_retorno
Dec{2}	ldc_alerta_ruptura
String 	ls_sql

Try
	if IsNull(al_dias_alerta_ruptura) or al_dias_alerta_ruptura < 1 then
		al_dias_alerta_ruptura	= 1
	end if
	
	ldc_alerta_ruptura	= al_dias_alerta_ruptura * 100
	
	ls_sql = &
		" 	SELECT  " + &
		"		aad.cd_produto, " + &
		"		Sum(aad.qt_demanda) as qt_demanda_total " + &
		"	INTO #total_demanda_produto_geral " + &
		" 	FROM #avaliar_atendimento_dist aad " + &
		" 	GROUP BY " + &
		"		aad.cd_produto "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #total_demanda_produto_geral. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_rup_ger" + &
			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	//Alerta de ruptura
	ls_sql = &
		" UPDATE #avaliar_atendimento_dist " + &
		" SET id_ruptura_geral = 'A' " + &
		" WHERE EXISTS (SELECT  " + &
		"						1 " + &
		"					FROM " + &
		"						#analise_rupturas_geral arg " + &
		"					INNER JOIN " + &
		"						#total_demanda_produto_geral tdpe " + &
		"						ON tdpe.cd_produto	= arg.cd_produto " + &
		"					WHERE " + &
		"						arg.cd_produto	= #avaliar_atendimento_dist.cd_produto " + &
		"						AND ((Coalesce(Cast(arg.estoque_geral_todos as decimal(12,2)), 0) / Coalesce(Cast(tdpe.qt_demanda_total as decimal(12,2)), 1)) * 100.00)	between " + gf_replace(String(adc_ruptura + 0.01), ',', '.', 0) + " and " + gf_replace(String(ldc_alerta_ruptura), ',', '.', 0) + " ) "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist (Alerta de Ruptura). ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_rup_ger" + &
			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	//Ruptura eminente
	ls_sql = &
		" UPDATE #avaliar_atendimento_dist " + &
		" SET id_ruptura_geral = 'S' " + &
		" WHERE EXISTS (SELECT  " + &
		"						1 " + &
		"					FROM " + &
		"						#analise_rupturas_geral arg " + &
		"					INNER JOIN " + &
		"						#total_demanda_produto_geral tdpe " + &
		"						ON tdpe.cd_produto	= arg.cd_produto " + &
		"					WHERE " + &
		"						arg.cd_produto	= #avaliar_atendimento_dist.cd_produto " + &
		"						AND ((Coalesce(Cast(arg.estoque_geral_todos as decimal(12,2)), 0) / Coalesce(Cast(tdpe.qt_demanda_total as decimal(12,2)), 1)) * 100.00) <= " + gf_replace(String(adc_ruptura), ',', '.', 0) + " ) "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist (Ruptura Eminente). ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_rup_ger" + &
			"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if
	
	Choose Case as_id_cons_rup_geral
		Case 'N'
			ls_sql = &
				" DELETE FROM #avaliar_atendimento_dist " + &
				" WHERE id_ruptura_geral = 'S' "
			
			is_sql_completo	+= ls_sql + '; ~r~r'
			
			execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
			if ISQLCA_CONSULTA.SQLCode <> 0 then
				as_log = "Erro ao deletar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist para n$$HEX1$$e300$$ENDHEX$$o mostrar produtos com ruptura geral. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_rup_ger" + &
					"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
				lb_retorno = False
				Return lb_retorno
			end if
		Case 'A'
			ls_sql = &
				" DELETE FROM #avaliar_atendimento_dist " + &
				" WHERE id_ruptura_geral <> 'S' "
			
			is_sql_completo	+= ls_sql + '; ~r~r'
			
			execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
			if ISQLCA_CONSULTA.SQLCode <> 0 then
				as_log = "Erro ao deletar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist para n$$HEX1$$e300$$ENDHEX$$o mostrar produtos sem ruptura geral. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atend_dist_rup_ger" + &
					"~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
				lb_retorno = False
				Return lb_retorno
			end if
	End Choose

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_update_avaliar_atend_dist_rup_ger. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try

end function

public function boolean of_save_avaliar_atendimento_dist (ref string as_log);Boolean	lb_retorno = False
String	ls_sql, ls_Create_DS, ls_Erro_Create_DS


Try
	ls_sql = & 
		"UPDATE avaliar_atendimento_dist " + & 
		"SET " + & 
		"    nr_pedido_distribuidora = aad.nr_pedido_distribuidora, " + & 
		"    cd_distribuidora = aad.cd_distribuidora, " + & 
		"    de_distribuidora = aad.de_distribuidora, " + & 
		"    qt_pedido_dist = aad.qt_pedido_dist, " + & 
		"    qt_atendida = aad.qt_atendida, " + & 
		"    qt_separada = aad.qt_separada, " + & 
		"    qt_faturada = aad.qt_faturada, " + & 
		"    qt_rateada = aad.qt_rateada, " + & 
		"    qt_corte = aad.qt_corte " + & 
		"FROM #avaliar_atendimento_dist aad " + & 
		"WHERE avaliar_atendimento_dist.cd_filial = aad.cd_filial " + & 
		"AND avaliar_atendimento_dist.nr_pedido_filial = aad.nr_pedido_filial " + & 
		"AND avaliar_atendimento_dist.cd_produto = aad.cd_produto"

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
	if ISQLCA_CONSULTA.SQlCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela avaliar_atendimento_dist. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_save_avaliar_atendimento_dist" + &
			"~r~r Erro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	end if
	
	ls_sql = & 
		"INSERT INTO avaliar_atendimento_dist ( " + & 
    	"    nr_pedido_filial, " + & 
    	"    dh_emissao, " + & 
    	"    cd_filial, " + & 
    	"    nm_filial, " + & 
   	"    id_rede_filial, " + & 
    	"    cd_unidade_federacao, " + & 
    	"    nr_pedido_distribuidora, " + & 
   	"    cd_distribuidora, " + & 
    	"    de_distribuidora, " + & 
    	"    cd_produto, " + & 
    	"    de_produto, " + & 
    	"    vl_fator_conversao, " + & 
    	"    cd_grupo_produto, " + & 
    	"    cd_fornecedor, " + & 
    	"    nm_fornecedor, " + & 
    	"    nr_divisao, " + & 
    	"    nm_divisao, " + & 
    	"    dh_termino_avaliacao, " + & 
    	"    nr_matricula_comprador, " + & 
    	"    nm_comprador, " + & 
    	"    id_projeto_conexao, " + & 
   	"    cd_filial_referencia_preco, " + & 
   	"    vl_venda, " + & 
    	"    id_ruptura_estadual, " + & 
    	"    id_ruptura_geral, " + & 
    	"    id_bloqueio_preco, " + & 
 	   "    qt_est_dist, " + & 
 	   "    cd_curva_abc_filiais, " + & 
  	  	"    cd_curva_abc_perini, " + & 
  	  	"    qt_dias_cobertura, " + & 
 	   "    qt_demanda_diaria, " + & 
	   "    qt_estoque_base, " + & 
  	  	"    qt_saldo_momento, " + & 
	   "    qt_sugerida, " + & 
  	  	"    qt_demanda, " + & 
	   "    qt_pedido_dist, " + & 
 	   "    qt_atendida, " + & 
 	   "    qt_separada, " + & 
    	"    qt_faturada, " + & 
    	"    qt_rateada, " + & 
    	"    qt_corte, " + & 
    	"    qt_lista_separacao, " + & 
    	"    vl_custo, " + &
    	"    id_utilizou_desconto_clube " + &		 
    	") " + & 
    	"SELECT " + & 
    	"    nr_pedido_filial, " + & 
    	"    dh_emissao, " + & 
    	"    cd_filial, " + & 
    	"    nm_filial, " + & 
    	"    id_rede_filial, " + & 
    	"    cd_unidade_federacao, " + & 
    	"    nr_pedido_distribuidora, " + & 
    	"    cd_distribuidora, " + & 
    	"    de_distribuidora, " + & 
    	"    cd_produto, " + & 
    	"    de_produto, " + & 
    	"    vl_fator_conversao, " + & 
    	"    cd_grupo_produto, " + & 
    	"    cd_fornecedor, " + & 
    	"    nm_fornecedor, " + & 
    	"    nr_divisao, " + & 
    	"    nm_divisao, " + & 
    	"    dh_termino_avaliacao, " + & 
    	"    nr_matricula_comprador, " + & 
    	"    nm_comprador, " + & 
    	"    id_projeto_conexao, " + & 
    	"    cd_filial_referencia_preco, " + & 
    	"    vl_venda, " + & 
    	"    id_ruptura_estadual, " + & 
    	"    id_ruptura_geral, " + & 
   	"    id_bloqueio_preco, " + & 
    	"    qt_est_dist, " + & 
    	"    cd_curva_abc_filiais, " + & 
    	"    cd_curva_abc_perini, " + & 
    	"    qt_dias_cobertura, " + & 
    	"    qt_demanda_diaria, " + & 
    	"    qt_estoque_base, " + & 
    	"    qt_saldo_momento, " + & 
    	"    qt_sugerida, " + & 
    	"    qt_demanda, " + & 
    	"    qt_pedido_dist, " + & 
    	"    qt_atendida, " + & 
    	"    qt_separada, " + & 
    	"    qt_faturada, " + & 
    	"    qt_rateada, " + & 
    	"    qt_corte, " + & 
    	"    qt_lista_separacao, " + & 
    	"    vl_custo_gerencial, " + &
		"    id_utilizou_desconto_clube " + & 
    	"FROM #avaliar_atendimento_dist aadt " + &
    	"WHERE NOT EXISTS ( " + & 
    	"    SELECT 1 " + & 
    	"    FROM avaliar_atendimento_dist aad " + & 
    	"    WHERE aadt.cd_produto	= aad.cd_produto " + & 
    	"    AND aadt.nr_pedido_filial	= aad.nr_pedido_filial " + & 
    	"    AND aadt.cd_filial	= aad.cd_filial) "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
	if ISQLCA_CONSULTA.SQlCode <> 0 then
		as_log = "Erro ao inserir registro na tabela avaliar_atendimento_dist. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_save_avaliar_atendimento_dist" + &
			"~r~r Erro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	end if

	lb_retorno	= True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_save_ Erro: " + RTE.GetMessage()
	
	lb_retorno	= False
Finally
	Return lb_retorno	
End Try
end function

public function boolean of_update_avaliar_atendimento_dist (ref string as_log);Boolean	lb_retorno = False
String	ls_sql


Try
	ls_sql = & 
		"UPDATE aad " + & 
		"SET " + & 
		"    aad.dh_emissao = src.dh_emissao, " + & 
		"    aad.nm_filial = src.nm_filial, " + & 
		"    aad.id_rede_filial = src.id_rede_filial, " + & 
		"    aad.cd_unidade_federacao = src.cd_unidade_federacao, " + & 
		"    aad.nr_pedido_distribuidora = src.nr_pedido_distribuidora, " + & 
		"    aad.cd_distribuidora = src.cd_distribuidora, " + & 
		"    aad.de_distribuidora = src.de_distribuidora, " + & 
		"    aad.de_produto = src.de_produto, " + & 
		"    aad.vl_fator_conversao = src.vl_fator_conversao, " + & 
		"    aad.cd_grupo_produto = src.cd_grupo_produto, " + & 
		"    aad.cd_fornecedor = src.cd_fornecedor, " + & 
		"    aad.nm_fornecedor = src.nm_fornecedor, " + & 
		"    aad.nr_divisao = src.nr_divisao, " + & 
		"    aad.nm_divisao = src.nm_divisao, " + & 
		"    aad.dh_termino_avaliacao = src.dh_termino_avaliacao, " + & 
		"    aad.nr_matricula_comprador = src.nr_matricula_comprador, " + & 
		"    aad.nm_comprador = src.nm_comprador, " + & 
		"    aad.cd_filial_referencia_preco = src.cd_filial_referencia_preco, " + & 
		"    aad.vl_venda = src.vl_venda, " + & 
		"    aad.id_ruptura_estadual = src.id_ruptura_estadual, " + & 
		"    aad.id_ruptura_geral = src.id_ruptura_geral, " + & 
		"    aad.id_bloqueio_preco = src.id_bloqueio_preco, " + & 
		"    aad.qt_est_dist = src.qt_est_dist, " + & 
		"    aad.cd_curva_abc_filiais = src.cd_curva_abc_filiais, " + & 
		"    aad.cd_curva_abc_perini = src.cd_curva_abc_perini, " + & 
		"    aad.qt_dias_cobertura = src.qt_dias_cobertura, " + & 
		"    aad.qt_demanda_diaria = src.qt_demanda_diaria, " + & 
		"    aad.qt_estoque_base = src.qt_estoque_base, " + & 
		"    aad.qt_saldo_momento = src.qt_saldo_momento, " + & 
		"    aad.qt_sugerida = src.qt_sugerida, " + & 
		"    aad.qt_demanda = src.qt_demanda, " + & 
		"    aad.qt_pedido_dist = src.qt_pedido_dist, " + & 
		"    aad.qt_atendida = src.qt_atendida, " + & 
		"    aad.qt_separada = src.qt_separada, " + & 
		"    aad.qt_faturada = src.qt_faturada, " + & 
		"    aad.qt_rateada = src.qt_rateada, " + & 
		"    aad.qt_corte = src.qt_corte, " + & 
		"    aad.qt_lista_separacao = src.qt_lista_separacao " + & 
		"FROM avaliar_atendimento_dist aad " + & 
		"JOIN #avaliar_atendimento_dist src " + & 
		"ON aad.cd_filial = src.cd_filial " + & 
		"AND aad.nr_pedido_filial = src.nr_pedido_filial " + & 
		"AND aad.cd_produto = src.cd_produto;"

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;
	
	if ISQLCA_CONSULTA.SQlCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela avaliar_atendimento_dist. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_avaliar_atendimento_dist" + &
			"~r~r Erro "  + ISQLCA_CONSULTA.SqlErrText
		
		lb_retorno	= False
		
		Return lb_retorno
	end if

	lb_retorno	= True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_update_avaliar_atendimento_dist. Erro: " + RTE.GetMessage()
	
	lb_retorno	= False
Finally
	Return lb_retorno	
End Try
end function

public function boolean of_update_vl_custo_gerencial (ref string as_log);Boolean lb_retorno
DateTime	ldt_dh_atual
String ls_sql

Try
	ldt_dh_atual	= gf_getServerDate()
	
	ls_sql = &
		" UPDATE #avaliar_atendimento_dist " + &
		" SET vl_custo_gerencial = COALESCE(sp.vl_custo_gerencial, 0) * pg.vl_fator_conversao " + &
		" FROM dbo.saldo_produto sp " + &
		" INNER JOIN produto_geral pg ON pg.cd_produto = sp.cd_produto " + &
		" WHERE sp.cd_produto = #avaliar_atendimento_dist.cd_produto " + &
		"   AND sp.cd_filial = #avaliar_atendimento_dist.cd_filial " + &
		"   AND sp.dh_saldo = '" + String(ldt_dh_atual, 'yyyy-mm-01') + "' "

	is_sql_completo	+= ls_sql + '; ~r~r'
	
	execute immediate :ls_sql Using ISQLCA_CONSULTA;

	if ISQLCA_CONSULTA.SQLCode <> 0 then
		as_log = "Erro ao atualizar registro na tabela tempor$$HEX1$$e100$$ENDHEX$$ria #avaliar_atendimento_dist. ~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_update_vl_custo_gerencial" + &
				 "~r~r Erro " + ISQLCA_CONSULTA.SqlErrText
		lb_retorno = False
		Return lb_retorno
	end if

	lb_retorno = True
Catch (RunTimeError RTE)
	as_log = "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_update_vl_custo_gerencial. Erro: " + RTE.GetMessage()
Finally
	Return lb_retorno
End Try
end function

public function boolean of_handle (long al_cd_filial, string as_id_rede_filial, string as_cd_unidade_federacao, datetime adt_dh_inicio, datetime adt_dh_fim, long al_cd_produto, long al_cd_grupo_produto, long al_nr_divisao, string as_cd_curva, string as_id_apenas_prod_ter_ava, string as_nr_comprador, string as_cd_distribuidora, string as_cd_fornecedor, string as_id_cons_rup_estadual, string as_id_cons_rup_geral, decimal adc_ruptura, long al_dias_alerta_ruptura, string as_id_bloqueio_preco, boolean ab_monitora_tempo_execucao, ref string as_log);DateTime	ldt_inicio_processo[] 
Date 		ldh_Inicio, ldh_Fim
Long		ll_total_processos	= 25, ll_progresso = 0, ll_for
String	ls_lista_processos[]

Open(w_Aguarde)

w_aguarde.uo_progress.of_setmax(ll_total_processos)

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Criando conex$$HEX1$$e300$$ENDHEX$$o paralela com o banco de dados."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
if not this.of_cria_conexao_consulta(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Buscando registros da tabela de produtos."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
if not this.of_in_produto(al_cd_produto, al_cd_grupo_produto, as_cd_curva, as_nr_comprador, al_nr_divisao, as_cd_fornecedor, as_id_apenas_prod_ter_ava, REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Buscando registros da tabela de filiais."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
if not this.of_in_filial(al_cd_filial, as_id_rede_filial, as_cd_unidade_federacao, REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Carregando dados das demandas do per$$HEX1$$ed00$$ENDHEX$$odo."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
if not this.of_in_pedido_filial_produto(Date(adt_dh_inicio), Date(adt_dh_fim), REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] =  "Carregando dados do atendimento das distribuidoras."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_avaliar_atendimento_dist(as_cd_distribuidora, REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Atualizando dados do atendimento das distribuidoras (Filial Refer$$HEX1$$ea00$$ENDHEX$$ncia de PrecIfica$$HEX2$$e700e300$$ENDHEX$$o)."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_update_avaliar_atend_dist_filial_ref(REF as_log) then 
	Return False
End If

/*ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Carregando valores de venda dos produtos."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_update_vl_venda(REF as_log) then 
	Return False
End If*/

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Carregando os custos dos produtos."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_update_vl_custo_gerencial(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Analisando demandas sem destino."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_produtos_sem_destino(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Analisando demandas com problemas de atendimento."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_distribuidoras_prod_prob(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Sintetizando dados das distribuidoras."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_avaliar_distribuidoras(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Sintetizando dados de demandas sem destino."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_prod_sem_dest_estado(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Sintetizando dados das demandas de distribuidoras."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_avaliar_distribuidoras_resumo(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Carregando dados de rupturas estaduais."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_base_ruptura_estado(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Carregando dados de rupturas gerais."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_base_ruptura_geral(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Ajustando $$HEX1$$ed00$$ENDHEX$$ndices de tabelas (1)."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_idx_1_avaliar_distribuidoras_resumo(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Ajustando $$HEX1$$ed00$$ENDHEX$$ndices de tabelas (2)."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_idx_2_avaliar_distribuidoras_resumo(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Ajustando $$HEX1$$ed00$$ENDHEX$$ndices de tabelas (3)."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_idx_3_base_ruptura_estado(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Ajustando $$HEX1$$ed00$$ENDHEX$$ndices de tabelas (4)."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_idx_4_base_ruptura_geral(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Sintetizando dados de rupturas estaduais."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_analise_ruptura_estadual(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Sintetizando dados de rupturas gerais."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_analise_ruptura_geral(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Carregando dados de vendas perdidas."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_venda_perdida(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Atualizando dados de ruptura estadual."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_update_avaliar_atend_dist_rup_est(as_id_cons_rup_estadual, adc_ruptura, al_dias_alerta_ruptura, REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Atualizando dados de ruptura geral."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_update_avaliar_atend_dist_rup_ger(as_id_cons_rup_geral, adc_ruptura, al_dias_alerta_ruptura, REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Carregando dados de bloqueios de pre$$HEX1$$e700$$ENDHEX$$os."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_in_bloqueio_preco(REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Atualizando dados de bloqueios de pre$$HEX1$$e700$$ENDHEX$$os."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_update_avaliar_atend_dist_bloq_pre(as_id_bloqueio_preco, REF as_log) then 
	Return False
End If

ll_progresso++
ldt_inicio_processo[ll_progresso]	= gf_GetServerDate()
ls_lista_processos[ll_progresso] = "Salvando dados de demandas atendidas e n$$HEX1$$e300$$ENDHEX$$o atendidas por sku's."
w_Aguarde.Title = ls_lista_processos[ll_progresso]
w_aguarde.uo_progress.of_setprogress(ll_progresso)
If not this.of_save_avaliar_atendimento_dist(REF as_log) then 
	SQLCA.of_rollback()
	Return False
Else
	SQLCA.of_commit();
End If

If ab_monitora_tempo_execucao then
	as_log	= ''
	
	for ll_for = 1 to UpperBound(ldt_inicio_processo)
		as_log += ls_lista_processos[ll_for] + ' - ' + String(ldt_inicio_processo[ll_for]) + '~r'
	next
end If

Close(w_Aguarde)

If ab_monitora_tempo_execucao then
	MessageBox('Log do Processo', as_log)
end If
end function

public function boolean of_handle_auto ();Datetime ldt_dh_inicio, ldt_dh_fim
Date ldt_Inicio, ldt_Fim, ldt_Atual
Decimal ldc_ruptura
Boolean lb_monitora_tempo_execucao
Long ll_cd_filial, ll_cd_produto, ll_cd_grupo_produto, ll_nr_divisao, ll_dias_alerta_ruptura
String ls_id_rede_filial, ls_cd_unidade_federacao, ls_cd_curva, ls_id_apenas_prod_ter_ava, &
		ls_nr_comprador, ls_cd_distribuidora, ls_cd_fornecedor, ls_id_cons_rup_estadual, &
		ls_id_cons_rup_geral, ls_id_bloqueio_preco, ls_log

If gvb_Auto Then

	ldt_Inicio = RelativeDate(Today(), -6)  // Data inicial: hoje - 6 dias
	ldt_Fim = RelativeDate(Today(), -1)  // Data final: hoje - 1 dia
	ldt_Atual = ldt_Inicio
	
	// Loop enquanto a data atual for menor ou igual $$HEX1$$e000$$ENDHEX$$ data final
	Do While ldt_Atual <= ldt_Fim
		
		If IsValid(ISQLCA_CONSULTA) Then
			If Not of_destroi_conexao_consulta(Ref ls_log) Then
				Return False
			End If
		End If
		
		If Not of_cria_conexao_consulta(Ref ls_log) Then
			Return False
		End If
		
		SetNull(ll_cd_filial)
		ls_id_rede_filial = ''
		ls_cd_unidade_federacao = ''
		ldt_dh_inicio = Datetime(ldt_Atual)
		ldt_dh_fim = Datetime(ldt_Atual)
		SetNull(ll_cd_produto) 
		SetNull(ll_cd_grupo_produto) 
		SetNull(ll_nr_divisao) 
		SetNull(ls_cd_curva) 
		ls_id_apenas_prod_ter_ava = 'S' 
		SetNull(ls_nr_comprador) 
		SetNull(ls_cd_distribuidora)
		SetNull(ls_cd_fornecedor) 
		ls_id_cons_rup_estadual = 'S' 
		ls_id_cons_rup_geral = 'S' 
		ldc_ruptura = 50
		ll_dias_alerta_ruptura = 5
		ls_id_bloqueio_preco = 'T' 
		lb_monitora_tempo_execucao = False
		ls_log = ''
		
		If Not This.of_handle( ll_cd_filial, ls_id_rede_filial, ls_cd_unidade_federacao, ldt_dh_inicio, ldt_dh_fim, ll_cd_produto, &
							ll_cd_grupo_produto, ll_nr_divisao, ls_cd_curva, ls_id_apenas_prod_ter_ava, ls_nr_comprador, &
							ls_cd_distribuidora, ls_cd_fornecedor, ls_id_cons_rup_estadual, ls_id_cons_rup_geral, &
							ldc_ruptura, ll_dias_alerta_ruptura, ls_id_bloqueio_preco, lb_monitora_tempo_execucao, Ref ls_log) Then
			Return False
		End If

		ldt_Atual = RelativeDate(ldt_Atual, +1) 
		
	Loop
	
End If

Return True
end function

on uo_ge637_analise_eficiencia_pescador.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge637_analise_eficiencia_pescador.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

