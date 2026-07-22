HA$PBExportHeader$w_ge590_rel_dinamico_movimento_fiscal.srw
forward
global type w_ge590_rel_dinamico_movimento_fiscal from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge590_rel_dinamico_movimento_fiscal from dc_w_selecao_lista_dinamica_relatorio
integer width = 4233
integer height = 2036
string title = "GE590 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Movimento Fiscal"
end type
global w_ge590_rel_dinamico_movimento_fiscal w_ge590_rel_dinamico_movimento_fiscal

type variables
uo_filial ivo_filial
uo_natureza_operacao ivo_cfop

end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*UF Filial*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

dw_1.Object.cd_uf[1] = "TD"
end subroutine

on w_ge590_rel_dinamico_movimento_fiscal.create
call super::create
end on

on w_ge590_rel_dinamico_movimento_fiscal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_filial			= Create uo_filial
ivo_cfop			= Create uo_natureza_operacao

//Dimensionamento de tela
MaxWidth = 4600
MaxHeight = 9999

//SQL Base para formar o grid
ivs_SQLBase = "from																	"+&
					"(select                                                                "+&
					"	inf.cd_natureza_operacao,                                           "+&
					"	nf.cd_filial,                                                       "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	'co' as tipo_docto,                                                 "+&
					"	'e' as tipo_movto,                                                  "+&
					"	'Compras' as descr_tipo_docto,                                      "+&
					"	'Entradas' as descr_tipo_movto,                                     "+&
					"	nf.nr_matric_atualizacao_estoque as usuario_inclusao,               "+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	sum(coalesce(inf.vl_bc_icms_total, inf.qt_faturada * inf.vl_bc_icms)) as vl_bc_icms,                "+&
					"	sum(coalesce(inf.vl_icms_total, inf.qt_faturada * inf.vl_icms)) as vl_icms,                      "+&
					"	sum(inf.vl_bc_icms_st_total) as vl_bc_icms_st,    "+&
					"	sum(inf.vl_icms_st_total) as vl_icms_st,                "+&
					"	sum(inf.vl_outras_despesas) as vl_outras_despesas,"+&     
					"	sum(coalesce(inf.vl_ipi_total, inf.qt_faturada * inf.vl_ipi)) as vl_ipi,                        "+&
					"	sum(inf.qt_faturada * inf.vl_pis) as vl_pis,                        "+&
					"	sum(inf.qt_faturada * inf.vl_cofins) as vl_cofins,                  "+&
					"	sum(inf.qt_faturada * inf.vl_icms_st_retido) as vl_icms_st_retido,  "+&
					"	sum(inf.qt_faturada * inf.vl_bc_icms_st_retido) as vl_bc_icms_st_retido,  "+&
					"	sum(round(inf.vl_st_fcp * inf.qt_faturada,2)) as vl_fcp_st, "+&
					"	0 as vl_icms_efetivo,  												"+&
					"	0 as vl_bc_icms_efetivo,  											"+&						
					"	sum(coalesce(inf.vl_total_item - inf.vl_desconto_total + inf.vl_outras_despesas, round(inf.qt_faturada * (round(coalesce(inf.vl_preco_unitario_fiscal, inf.vl_preco_unitario) * ((100 - inf.pc_desconto) / 100), 2) - inf.vl_icms_repassado), 2)) )  as valor_contabil, "+&
					"	nf.de_chave_acesso as chave_nfe,                                    "+&
					"	c.cd_unidade_federacao                                      "+&
					"from nf_compra nf (index idx_filial_data_movimento)  "+&
					"inner join filial f                              "+&
  					"on  f.cd_filial = nf.cd_filial                              "+&
					"inner join cidade c                              "+&
  					"on c.cd_cidade = f.cd_cidade                              "+&
					"inner join item_nf_compra inf                                          "+&
					"	on	inf.cd_filial = nf.cd_filial                                 "+&
					"	and inf.cd_fornecedor = nf.cd_fornecedor                             "+&
					"	and inf.nr_nf         = nf.nr_nf                                     "+&
					"	and inf.de_especie    = nf.de_especie                                "+&
					"	and inf.de_serie      = nf.de_serie                                   "+&			
					"group by                                                               "+&
					"	inf.cd_natureza_operacao,                                           "+&
					"	nf.cd_filial,                                                       "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	nf.nr_matric_atualizacao_estoque,                                   "+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	nf.de_chave_acesso,                                              "+&
					"	c.cd_unidade_federacao                                        "+&
					"		                                                                "+&
					"	union all                                                           "+&
					"		                                                                "+&
					"	select                                                              "+&
					"	inf.cd_natureza_operacao as cd_natureza_operacao,                                           "+&
					"	nf.cd_filial,                                                       "+&
					"	inf.cd_cst_tributacao as cd_situacao_tributaria,                                         "+&
					"	'dv' as tipo_docto,                                                 "+&
					"	'e' as tipo_movto,                                                  "+&
					"	'Devolu$$HEX2$$e700e300$$ENDHEX$$o' as descr_tipo_docto,                                    "+&
					"	'Entradas' as descr_tipo_movto,                                     "+&
					"	nf.nr_matricula_operador as usuario_inclusao,               		"+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	sum(inf.vl_bc_icms) as vl_bc_icms,                "+&
					"	sum(inf.vl_icms) as vl_icms,                      "+&
					"	sum(inf.vl_bc_icms_st) as vl_bc_icms_st,    		"+&
					"	sum(inf.vl_icms_st) as vl_icms_st,                "+&
					"	sum(inf.vl_outras_despesas) as vl_outras_despesas,"+&     
					"	0 as vl_ipi,                        								"+&
					"	0 as vl_pis,                        								"+&
					"	0 as vl_cofins,                  									"+&
					"	0 as vl_icms_st_retido,  "+&
					"	0 as vl_bc_icms_st_retido,  "+&
					"	0 as vl_fcp_st, "+&
					"	sum(inf.vl_icms_efetivo) as vl_icms_efetivo,  	"+&
					"	sum(inf.vl_bc_icms_efetivo) as vl_bc_icms_efetivo,  "+&							
					"	sum(coalesce( (inf.qt_devolvida * inf.vl_preco_unitario) - vl_desconto_total, inf.qt_devolvida * Round(inf.vl_preco_unitario * ((100 - inf.pc_desconto) / 100), 2))) as valor_contabil, "+&
					"	nfe.de_chave_acesso as chave_nfe,  									"+&
					"	c.cd_unidade_federacao  											"+&
					"FROM   nf_devolucao_venda nf (index idx_filial_dh_movimento)			"+&
					"inner join item_nf_devolucao_venda inf  "	+ &
					"	on inf.cd_filial = nf.cd_filial+0 "										+ &
					"	and inf.nr_nf = nf.nr_nf+0 "											+ &
					"	and inf.de_serie = nf.de_serie "									+ &
					"	and inf.de_especie = nf.de_especie "								+ &
					"INNER JOIN filial f                                                    "+&
					"  on  f.cd_filial = nf.cd_filial                                       "+&
					"  and nf.dh_cancelamento is null                                      "+&
					"INNER JOIN cidade c                                                    "+&
					"  on c.cd_cidade = f.cd_cidade                                         "+&
					"LEFT OUTER JOIN nf_devolucao_venda_nfe nfe                             "+&
					"  on  nfe.nr_nf		= nf.nr_nf                                      "+&
					"  and nfe.cd_filial	= nf.cd_filial                                  "+&
					"  and nfe.de_especie= nf.de_especie                                    "+&
					"  and nfe.de_serie	= nf.de_serie                                       "+&
					"  and nfe.id_origem_nf= nf.id_origem_nf                                "+&
					"group by                                                               "+&
					"	inf.cd_natureza_operacao,                                      		"+&
					"	nf.cd_filial,                                                       "+&
					"	inf.cd_cst_tributacao,                                      		"+&
					"	nf.nr_matricula_operador, 			                                  "+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	nfe.de_chave_acesso,                                              	"+&
					"	c.cd_unidade_federacao                                        		"+&
					"		                                                                "+&
					"	union all                                                           "+&
					"		                                                                "+&
					"	select                                                              "+&
					"	nf.cd_natureza_operacao,                							"+&
					"	nf.cd_filial_origem as cd_filial,                                   "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	'di' as tipo_docto,                                                 "+&
					"	'e' as tipo_movto,                                                  "+&
					"	'diversas' as descr_tipo_docto,                                    	"+&
					"	'entradas' as descr_tipo_movto,                                     "+&
					"	nf.nr_matricula_operador as usuario_inclusao,               		"+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	sum(inf.vl_bc_icms) as vl_bc_icms,                	"+&
					"	sum(inf.vl_icms) as vl_icms,                      	"+&
					"	sum(inf.vl_bc_icms_st) as vl_bc_icms_st,    			"+&
					"	sum(inf.vl_icms_st) as vl_icms_st,                	"+&
					"	sum(inf.vl_outras_despesas) as vl_outras_despesas,	"+&     
					"	sum(inf.vl_ipi) as vl_ipi,                        	"+&
					"	sum(inf.vl_pis) as vl_pis,                        	"+&
					"	sum(inf.vl_cofins) as vl_cofins,                  	"+&
					"	sum(inf.vl_icms_st_retido) as vl_icms_st_retido,  	"+&
					"	sum(inf.vl_bc_icms_st_retido) as vl_bc_icms_st_retido,"+&
					"	0 as vl_fcp_st, "+&
					"	0 as vl_icms_efetivo,  												"+&
					"	0 as vl_bc_icms_efetivo,  											"+&					
					"	sum(inf.vl_outras_despesas + coalesce(inf.qt_item * coalesce(inf.vl_preco_unitario_fiscal, inf.vl_preco_unitario) - inf.vl_total_desconto, round(inf.qt_item * ((coalesce(inf.vl_preco_unitario_fiscal, inf.vl_preco_unitario) * ((100 - inf.pc_desconto)))/100),2))) as valor_contabil, "+&
					"	nfe.de_chave_acesso as chave_nfe,  									"+&
					"	c.cd_unidade_federacao  											"+&
					"from	nf_diversa nf (index idx_data_movimento)						"+&
					"inner join item_nf_diversa inf  		                                "+&
					"  on  inf.nr_nf		= nf.nr_nf                                      "+&
					"  and inf.cd_filial_origem	= nf.cd_filial_origem                       "+&
					"  and inf.de_especie= nf.de_especie                                    "+&
					"  and inf.de_serie	= nf.de_serie                                       "+&
					"  and nf.dh_cancelamento is null                                      "+&		
					"  and nf.cd_natureza_operacao < 5000                                "+&	
					"  and nf.cd_filial_origem >  0                              "+&
					"inner join filial f                                                    "+&
					"  on  f.cd_filial = nf.cd_filial_origem                                "+&
					"inner join cidade c                                                    "+&
					"  on c.cd_cidade = f.cd_cidade                                         "+&
					"left outer join nf_diversa_nfe nfe                             		"+&
					"  on  nfe.nr_nf		= nf.nr_nf                                      "+&
					"  and nfe.cd_filial_origem	= nf.cd_filial_origem                       "+&
					"  and nfe.de_especie= nf.de_especie                                    "+&
					"  and nfe.de_serie	= nf.de_serie                                       "+&
					"group by                                                               "+&
					"	nf.cd_natureza_operacao,                                        	"+&
					"	nf.cd_filial_origem,                                                "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	nf.nr_matricula_operador, 			                                "+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	nfe.de_chave_acesso,                                              	"+&
					"	c.cd_unidade_federacao                                        		"+&	
					"		                                                                "+&
					"	union all                                                           "+&
					"		                                                                "+&
					"	select                                                              "+&
					"	inf.cd_natureza_operacao,                							"+&
					"	nf.cd_filial_origem as cd_filial,                                   "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	'tr' as tipo_docto,                                                 "+&
					"	'e' as tipo_movto,                                                  "+&
					"	'transferencias' as descr_tipo_docto,                              	"+&
					"	'entradas' as descr_tipo_movto,                                     "+&
					"	nf.nr_matricula_operador as usuario_inclusao,               		"+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	sum(inf.vl_bc_icms) as vl_bc_icms,		"+&
					"	sum(inf.vl_icms) as vl_icms,           "+&
					"	sum(inf.vl_bc_icms_st) as vl_bc_icms_st, "+&
					"	sum(inf.vl_icms_st) as vl_icms_st, 		 "+&
					"	0 as vl_outras_despesas,											"+&     
					"	0 as vl_ipi,                										"+&
					"	0 as vl_pis,                									"+&
					"	0 as vl_cofins,             										"+&
					"	sum(inf.vl_icms_st_retido) as vl_icms_st_retido,			"+&
					"	sum(inf.vl_bc_icms_st_retido) as vl_bc_icms_st_retido, "+&
					"	0 as vl_fcp_st, "+&
					"	0 as vl_icms_efetivo,  												"+&
					"	0 as vl_bc_icms_efetivo,  											"+&					
					"	cast(round(sum(inf.qt_transferida * coalesce(inf.vl_preco_unitario_fiscal,inf.vl_custo_unitario)),2) as decimal(18,2)) as valor_contabil, "+&
					"	nfe.de_chave_acesso as chave_nfe,  									"+&
					"	c.cd_unidade_federacao  											"+&
					"from	nf_transferencia nf (index idx_data_filial_origem)				"+&
					"inner join item_nf_transferencia inf  	                                "+&
					"  on  inf.nr_nf		= nf.nr_nf                                      "+&
					"  and inf.cd_filial_origem	= nf.cd_filial_origem                       "+&
					"  and inf.de_especie= nf.de_especie                                    "+&
					"  and inf.de_serie	= nf.de_serie                                       "+&
					"  and inf.cd_natureza_operacao < 5000 						"+&					
					"  and nf.cd_filial_origem > 0                                       "+&
					"inner join produto_geral pg		                                    "+&
					"  on pg.cd_produto	= inf.cd_produto                                	"+&
					"inner join filial f                                                    "+&
					"  on  f.cd_filial = nf.cd_filial_origem                                "+&
					"inner join cidade c                                                    "+&
					"  on c.cd_cidade = f.cd_cidade                                         "+&
					"left outer join nf_transferencia_nfe nfe                          		"+&
					"  on  nfe.nr_nf		= nf.nr_nf                                      "+&
					"  and nfe.cd_filial_origem	= nf.cd_filial_origem                       "+&
					"  and nfe.de_especie= nf.de_especie                                    "+&
					"  and nfe.de_serie	= nf.de_serie                                       "+&
					"  and coalesce(nfe.dh_cancelamento,nf.dh_cancelamento) is null     "+&
					"group by                                                               "+&
					"	inf.cd_natureza_operacao,                                        	"+&
					"	nf.cd_filial_origem,                                                "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	nf.nr_matricula_operador, 			                                "+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	nfe.de_chave_acesso,                                              	"+&
					"	c.cd_unidade_federacao                                        		"+&
					"		                                                                "+&
					"	union all                                                           "+&
					"		                                                                "+&
					"	select                                                              "+&
					"	inf.cd_natureza_operacao,                							"+&
					"	nf.cd_filial as cd_filial,		                                    "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	've' as tipo_docto,                                                 "+&
					"	's' as tipo_movto,                                                  "+&
					"	'vendas' as descr_tipo_docto,                                    	"+&
					"	'saidas' as descr_tipo_movto,                                     	"+&
					"	nf.nr_matric_operador as usuario_inclusao, 		              		"+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"   sum(case when inf.pc_icms > 0 then (Round((inf.qt_vendida * inf.vl_preco_praticado) * ( 1 - coalesce(inf.pc_reducao_base_icms, 0) / 100) * ( 1 - (coalesce(nf.pc_desconto,0) / 100) ), 2)) else 0.00 end) as vl_bc_icms,     " +&
					"   sum(case when inf.pc_icms > 0 then (Round((inf.qt_vendida * inf.vl_preco_praticado) * ( 1 - coalesce(inf.pc_reducao_base_icms, 0) / 100) * ( 1 - (coalesce(nf.pc_desconto,0) / 100) ) * inf.pc_icms / 100, 2)) else 0.00 end) as vl_icms,      	"+&
					"	0 as vl_bc_icms_st,    								"+&
					"	0 as vl_icms_st,                					"+&
					"	sum(inf.vl_outras_despesas) as vl_outras_despesas,	"+&     
					"	0 as vl_ipi,                        				"+&
					"	sum(case when coalesce(hp.id_situacao_pis_cofins, p.id_situacao_pis_cofins) = Upper('T') then round(((inf.qt_vendida * inf.vl_preco_praticado) - round( inf.qt_vendida * inf.vl_preco_praticado * (coalesce(nf.pc_desconto,0) / 100), 2)) * 0.0165, 2) else 0.00 end) as vl_pis,  "+&
					"	sum(case when coalesce(hp.id_situacao_pis_cofins, p.id_situacao_pis_cofins) = Upper('T') then round(((inf.qt_vendida * inf.vl_preco_praticado) - round( inf.qt_vendida * inf.vl_preco_praticado * (coalesce(nf.pc_desconto,0) / 100), 2)) * 0.076, 2) else 0.00 end) as vl_cofins,	  "+&
					"	sum(inf.vl_icms_st_retido) as vl_icms_st_retido,  	"+&
					"	sum(inf.vl_bc_icms_st_retido) as vl_bc_icms_st_retido,"+&
					"	0 as vl_fcp_st, "+&
					"	sum(inf.vl_icms_efetivo) as vl_icms_efetivo,  			"+&
					"	sum(inf.vl_bc_icms_efetivo) as vl_bc_icms_efetivo,  	"+&
					"   sum((inf.qt_vendida * inf.vl_preco_praticado) - round( inf.qt_vendida * inf.vl_preco_praticado * (coalesce(nf.pc_desconto,0) / 100), 2))  as valor_contabil, "+&
					"	nfe.de_chave_acesso as chave_nfe,  									"+&
					"	c.cd_unidade_federacao  											"+&
					"from	nf_venda nf (index idx_data_filial)								"+&
					"inner join item_nf_venda inf	  		                                "+&
					"  on  inf.nr_nf		= nf.nr_nf+0                                      "+&
					"  and inf.cd_filial	= nf.cd_filial	+0		                        "+&
					"  and inf.de_especie	= nf.de_especie                                 "+&
					"  and inf.de_serie		= nf.de_serie                                   "+&
					"  and nf.dh_cancelamento is null                                   "+&
					"inner join produto_geral p 									"+ &
					"	on p.cd_produto = inf.cd_produto+0 						"+ &
					"left outer join historico_produto hp 						"+ &
					"	on hp.cd_produto = p.cd_produto+0						 "+ &
					"	and hp.dh_historico = cast(cast(year(nf.dh_movimentacao_caixa) as varchar)||'/'||cast(month(nf.dh_movimentacao_caixa) as varchar)||'/01' as datetime)  "	+ &
					"inner join filial f                                                    "+&
					"  on  f.cd_filial = nf.cd_filial	+0	                                "+&
					"inner join cidade c                                                    "+&
					"  on c.cd_cidade = f.cd_cidade+0                                         "+&
					"left outer join nf_venda_nfe nfe 	                            		"+&
					"  on  nfe.nr_nf		= nf.nr_nf+0                                      "+&
					"  and nfe.cd_filial	= nf.cd_filial	+0	                       		"+&
					"  and nfe.de_especie	= nf.de_especie                                 "+&
					"  and nfe.de_serie		= nf.de_serie                                   "+&
					"group by                                                               "+&
					"	inf.cd_natureza_operacao,                                        	"+&
					"	nf.cd_filial,				                                                "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	nf.nr_matric_operador, 			                                "+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	nfe.de_chave_acesso,                                              	"+&
					"	c.cd_unidade_federacao                                        		"+&
					"		                                                                "+&
					"	union all                                                           "+&
					"		                                                                "+&
					"	select                                                              "+&
					"	coalesce(inf2.cd_natureza_operacao,inf.cd_natureza_operacao) as cd_natureza_operacao,                							"+&
					"	nf.cd_filial as cd_filial,		                                    "+&
					"	coalesce(inf2.cd_cst_tributacao,inf.cd_cst_tributacao) as cd_situacao_tributaria,              "+&
					"	'dv' as tipo_docto,                                                 "+&
					"	's' as tipo_movto,                                                  "+&
					"	'devolu$$HEX2$$e700e300$$ENDHEX$$o' as descr_tipo_docto,                                   	"+&
					"	'saidas' as descr_tipo_movto,                                     	"+&
					"	nf.nr_matricula_operador as usuario_inclusao, 		              	"+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	sum(coalesce(inf.vl_bc_icms_total,coalesce(inf2.vl_bc_icms,inf.vl_bc_icms))) as vl_bc_icms,							"+&
					"	sum(coalesce(inf.vl_icms_total,coalesce(inf2.vl_icms,inf.vl_icms))) as vl_icms,              						"+&
					"	sum(coalesce(inf2.vl_bc_icms_st,inf.vl_bc_icms_st)) as vl_bc_icms_st,    					"+&
					"	sum(coalesce(inf2.vl_icms_st,inf.vl_icms_st)) as vl_icms_st,                			"+&
					"	sum(coalesce(inf2.vl_outras_despesas,inf.vl_outras_despesas)) as vl_outras_despesas,	"+&     
					"	sum(coalesce(inf2.vl_ipi,inf.vl_ipi)) as vl_ipi,         					"+&
					"	sum(coalesce(inf2.vl_pis,inf.vl_pis)) as vl_pis,                        				"+&
					"	sum(coalesce(inf2.vl_cofins,inf.vl_cofins)) as vl_cofins,                  				"+&
					"	sum(coalesce(inf2.vl_icms_st_retido,inf.vl_icms_st_retido)) as vl_icms_st_retido,  		"+&
					"	sum(coalesce(inf2.vl_bc_icms_st_retido,inf.vl_bc_icms_st_retido)) as vl_bc_icms_st_retido,		"+&
					"	0 as vl_fcp_st, "+&
					"	0 as vl_icms_efetivo,  			"+&
					"	0 as vl_bc_icms_efetivo,  		"+&					
					"   sum(coalesce(inf.vl_total_item - inf.vl_desconto_total + inf.vl_outras_despesas, round((coalesce(inf2.qt_devolvida,inf.qt_devolvida) * coalesce(inf2.vl_preco_unitario,inf.vl_preco_unitario) * (1 - coalesce(inf2.pc_desconto,inf.pc_desconto)/100)) + coalesce(coalesce(inf2.vl_ipi,inf.vl_ipi),0) + coalesce(coalesce(inf2.vl_icms_st,inf.vl_icms_st),0) + coalesce(inf.vl_frete,0) + coalesce(coalesce(inf2.vl_outras_despesas,inf.vl_outras_despesas),0),2))) as valor_contabil, " +&
					"	nfe.de_chave_acesso as chave_nfe,  									"+&
					"	c.cd_unidade_federacao  											"+&
					"from	nf_devolucao_compra nf (index idx_dh_movimentacao_caixa)		"+&
					" left outer join nf_devolucao_compra_produto inf " + &
						" on inf.cd_filial = nf.cd_filial " 							+ &
						" and inf.nr_nf = nf.nr_nf " 								+ &
						" and inf.de_serie = nf.de_serie " 					+ & 
						" and inf.de_especie = nf.de_especie " 				+ &
					" left outer join item_nf_devolucao_compra inf2 " + &
						" on inf2.cd_filial = nf.cd_filial " 							+ &
						" and inf2.nr_nf = nf.nr_nf " 								+ &
						" and inf2.de_serie = nf.de_serie " 					+ & 
						" and inf2.de_especie = nf.de_especie " 				+ &
					"inner join filial f                                                    "+&
					"  on  f.cd_filial = nf.cd_filial		                                "+&
					"  and nf.dh_cancelamento is null							"+&
					"inner join cidade c                                                    "+&
					"  on c.cd_cidade = f.cd_cidade                                         "+&
					"left outer join nf_devolucao_compra_nfe nfe 	                        "+&
					"  on  nfe.nr_nf		= nf.nr_nf                                      "+&
					"  and nfe.cd_filial	= nf.cd_filial		                       		"+&
					"  and nfe.de_especie	= nf.de_especie                                 "+&
					"  and nfe.de_serie		= nf.de_serie                                   "+&
					"group by                                                               "+&
					"	coalesce(inf2.cd_natureza_operacao,inf.cd_natureza_operacao),								"+&
					"	nf.cd_filial,		                                                "+&
					"	coalesce(inf2.cd_cst_tributacao,inf.cd_cst_tributacao),                                             "+&
					"	nf.nr_matricula_operador, 				                            "+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	nfe.de_chave_acesso,                                              	"+&
					"	c.cd_unidade_federacao                                        		"+&		
					"		                                                                "+&
					"	union all                                                           "+&
					"		                                                                "+&
					"	select                                                              "+&
					"	nf.cd_natureza_operacao,                							"+&
					"	nf.cd_filial_origem as cd_filial,                                   "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	'di' as tipo_docto,                                                 "+&
					"	's' as tipo_movto,                                                  "+&
					"	'diversas' as descr_tipo_docto,                                    	"+&
					"	'saidas' as descr_tipo_movto,                                     "+&
					"	nf.nr_matricula_operador as usuario_inclusao,               		"+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	sum(inf.vl_bc_icms) as vl_bc_icms,                	"+&
					"	sum(inf.vl_icms) as vl_icms,                      	"+&
					"	sum(inf.vl_bc_icms_st) as vl_bc_icms_st,    			"+&
					"	sum(inf.vl_icms_st) as vl_icms_st,                	"+&
					"	sum(inf.vl_outras_despesas) as vl_outras_despesas,	"+&     
					"	sum(inf.vl_ipi) as vl_ipi,                        	"+&
					"	sum(inf.vl_pis) as vl_pis,                        	"+&
					"	sum(inf.vl_cofins) as vl_cofins,                  	"+&
					"	sum(inf.vl_icms_st_retido) as vl_icms_st_retido,  	"+&
					"	sum(inf.vl_bc_icms_st_retido) as vl_bc_icms_st_retido,"+&
					"	0 as vl_fcp_st, "+&
					"	0 as vl_icms_efetivo,  												"+&
					"	0 as vl_bc_icms_efetivo,  											"+&					
					"	sum(round(inf.qt_item * ((inf.vl_preco_unitario * ((100 - inf.pc_desconto)))/100),2)) as valor_contabil, "+&
					"	nfe.de_chave_acesso as chave_nfe,  									"+&
					"	c.cd_unidade_federacao  											"+&
					"from	nf_diversa nf (index idx_data_movimento)						"+&
					"inner join item_nf_diversa inf  		                                "+&
					"  on  inf.nr_nf		= nf.nr_nf                                      "+&
					"  and inf.cd_filial_origem	= nf.cd_filial_origem                       "+&
					"  and inf.de_especie= nf.de_especie                                    "+&
					"  and inf.de_serie	= nf.de_serie                                       "+&
					"  and nf.dh_cancelamento is null                                      "+&
					"  and nf.cd_natureza_operacao >= 5000                                "+&	
					"  and nf.cd_filial_origem >  0                              "+&
					"inner join filial f                                                    "+&
					"  on  f.cd_filial = nf.cd_filial_origem                                "+&
					"inner join cidade c                                                    "+&
					"  on c.cd_cidade = f.cd_cidade                                         "+&
					"inner join natureza_operacao nop                                       "+&
					"  on nop.cd_natureza_operacao = nf.cd_natureza_operacao                "+&
					"left outer join nf_diversa_nfe nfe                             		"+&
					"  on  nfe.nr_nf		= nf.nr_nf                                      "+&
					"  and nfe.cd_filial_origem	= nf.cd_filial_origem                       "+&
					"  and nfe.de_especie= nf.de_especie                                    "+&
					"  and nfe.de_serie	= nf.de_serie                                       "+&
					"group by                                                               "+&
					"	nf.cd_natureza_operacao,                                        	"+&
					"	nf.cd_filial_origem,                                                "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	nf.nr_matricula_operador, 			                                "+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	nfe.de_chave_acesso,                                              	"+&
					"	c.cd_unidade_federacao                                        		"+&	
					"		                                                                "+&
					"	union all                                                           "+&
					"		                                                                "+&
					"	select                                                              "+&
					"	inf.cd_natureza_operacao,                							"+&
					"	nf.cd_filial_origem as cd_filial,                                   "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	'tr' as tipo_docto,                                                 "+&
					"	's' as tipo_movto,                                                  "+&
					"	'transferencias' as descr_tipo_docto,                              	"+&
					"	'entradas' as descr_tipo_movto,                                     "+&
					"	nf.nr_matricula_operador as usuario_inclusao,               		"+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	sum(inf.vl_bc_icms) as vl_bc_icms,		"+&
					"	sum(inf.vl_icms) as vl_icms,           "+&
					"	sum(inf.vl_bc_icms_st) as vl_bc_icms_st, "+&
					"	sum(inf.vl_icms_st) as vl_icms_st, 		 "+&
					"	0 as vl_outras_despesas,											"+&     
					"	0 as vl_ipi,                										"+&
					"	0 as vl_pis,                										"+&
					"	0 as vl_cofins,             										"+&
					"	sum(inf.vl_icms_st_retido) as vl_icms_st_retido,			"+&
					"	sum(inf.vl_bc_icms_st_retido) as vl_bc_icms_st_retido, "+&
					"	0 as vl_fcp_st, "+&
					"	0 as vl_icms_efetivo,  												"+&
					"	0 as vl_bc_icms_efetivo,  											"+&					
					"	cast(round(sum(inf.qt_transferida * coalesce(inf.vl_preco_unitario_fiscal,inf.vl_custo_unitario)),2) as decimal(18,2)) as valor_contabil, "+&
					"	nfe.de_chave_acesso as chave_nfe,  									"+&
					"	c.cd_unidade_federacao  											"+&
					"from	nf_transferencia nf (index idx_data_filial_origem)				"+&
					"inner join item_nf_transferencia inf  (index pk_item_nf_transferencia)	                                "+&
					"    on inf.cd_filial_origem	= nf.cd_filial_origem+0                       "+&					
					"  and inf.nr_nf		= nf.nr_nf+0                                      "+&
					"  and inf.de_especie= nf.de_especie                                    "+&
					"  and inf.de_serie	= nf.de_serie                                       "+&
					"  and nf.dh_cancelamento is null                                      "+&
					"inner join produto_geral pg		                                    "+&
					"  on pg.cd_produto	= inf.cd_produto+0                                	"+&
					"inner join filial f                                                    "+&
					"  on  f.cd_filial = nf.cd_filial_origem+0                                "+&
					"inner join cidade c                                                    "+&
					"  on c.cd_cidade = f.cd_cidade +0                                        "+&
					"left outer join nf_transferencia_nfe nfe                          		"+&
					"  on  nfe.nr_nf		= nf.nr_nf                                      "+&
					"  and nfe.cd_filial_origem	= nf.cd_filial_origem                       "+&
					"  and nfe.de_especie= nf.de_especie                                    "+&
					"  and nfe.de_serie	= nf.de_serie                                       "+&
					"  and coalesce(nfe.dh_cancelamento,nf.dh_cancelamento) is null     	"+&
					"group by                                                               "+&
					"	inf.cd_natureza_operacao,                                        	"+&
					"	nf.cd_filial_origem,                                                "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	nf.nr_matricula_operador, 			                                "+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	nfe.de_chave_acesso,                                              	"+&
					"	c.cd_unidade_federacao                                        		"+&
					"		                                                                "+&
					"	union all                                                           "+&
					"		                                                                "+&
					"	select                                                              "+&
					"	nf.cd_natureza_operacao,                							"+&
					"	nf.cd_filial_origem as cd_filial,                                   "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	'tr' as tipo_docto,                                                 "+&
					"	's' as tipo_movto,                                                  "+&
					"	'transferencias' as descr_tipo_docto,                                    	"+&
					"	'saidas' as descr_tipo_movto,                                     	"+&
					"	nf.nr_matricula_operador as usuario_inclusao,               		"+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	sum(inf.vl_bc_icms) as vl_bc_icms,                	"+&
					"	sum(inf.vl_icms) as vl_icms,                      	"+&
					"	sum(inf.vl_bc_icms_st) as vl_bc_icms_st,    			"+&
					"	sum(inf.vl_icms_st) as vl_icms_st,                	"+&
					"	sum(inf.vl_outras_despesas) as vl_outras_despesas,	"+&     
					"	sum(inf.vl_ipi) as vl_ipi,                        	"+&
					"	sum(inf.vl_pis) as vl_pis,                        	"+&
					"	sum(inf.vl_cofins) as vl_cofins,                  	"+&
					"	sum(inf.vl_icms_st_retido) as vl_icms_st_retido,  	"+&
					"	sum(inf.vl_bc_icms_st_retido) as vl_bc_icms_st_retido,"+&
					"	0 as vl_fcp_st, "+&
					"	0 as vl_icms_efetivo,  												"+&
					"	0 as vl_bc_icms_efetivo,  											"+&					
					"	sum(round(inf.qt_item * ((inf.vl_preco_unitario * ((100 - inf.pc_desconto)))/100),2)) as valor_contabil, "+&
					"	nfe.de_chave_acesso as chave_nfe,  									"+&
					"	c.cd_unidade_federacao  											"+&
					"from	nf_diversa nf (index idx_data_movimento)						"+&
					"inner join item_nf_diversa inf  		                                "+&
					"  on  inf.nr_nf		= nf.nr_nf                                      "+&
					"  and inf.cd_filial_origem	= nf.cd_filial_origem                       "+&
					"  and inf.de_especie= nf.de_especie                                    "+&
					"  and inf.de_serie	= nf.de_serie                                       "+&
					"  and nf.dh_cancelamento is null                                      "+&
					"  and nf.cd_natureza_operacao not in (1604,1102,5929)                 "+&
					"  and coalesce(nf.id_patrimonio,Upper('N'))=Upper('S')                              "+&
					"inner join filial f                                                    "+&
					"  on  f.cd_filial = nf.cd_filial_origem                                "+&
					"inner join cidade c                                                    "+&
					"  on c.cd_cidade = f.cd_cidade                                         "+&
					"inner join natureza_operacao nop                                       "+&
					"  on nop.cd_natureza_operacao = nf.cd_natureza_operacao                "+&
					"left outer join nf_diversa_nfe nfe                             		"+&
					"  on  nfe.nr_nf		= nf.nr_nf                                      "+&
					"  and nfe.cd_filial_origem	= nf.cd_filial_origem                       "+&
					"  and nfe.de_especie= nf.de_especie                                    "+&
					"  and nfe.de_serie	= nf.de_serie                                       "+&
					"group by                                                               "+&
					"	nf.cd_natureza_operacao,                                        	"+&
					"	nf.cd_filial_origem,                                                "+&
					"	inf.cd_situacao_tributaria,                                         "+&
					"	nf.nr_matricula_operador, 			                                "+&
					"	nf.nr_nf,                                                           "+&
					"	nf.de_especie,                                                      "+&
					"	nf.de_serie,                                                        "+&
					"	nf.dh_movimentacao_caixa,                                           "+&
					"	nfe.de_chave_acesso,                                              	"+&
					"	c.cd_unidade_federacao                                        		"+&
					"	) nf "
		

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 30
end event

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_cfop)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)

wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge590_rel_dinamico_movimento_fiscal
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge590_rel_dinamico_movimento_fiscal
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge590_rel_dinamico_movimento_fiscal
integer y = 468
integer width = 4137
integer height = 1368
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge590_rel_dinamico_movimento_fiscal
integer width = 2830
integer height = 440
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge590_rel_dinamico_movimento_fiscal
integer x = 41
integer width = 2798
integer height = 324
string dataobject = "dw_ge590_selecao"
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
		
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_cfop) Then 
	This.Object.nm_cfop [1] = ivo_cfop.de_natureza_operacao
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge590_rel_dinamico_movimento_fiscal
integer y = 544
integer width = 4069
integer height = 1260
string title = "Rel. Din$$HEX1$$e200$$ENDHEX$$mico de Movimento Fiscal"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_UF_Fil
String lvs_SQL
String lvs_Movimento
String lvs_TipoDocto
String lvs_Imposto

Long lvl_CFOP
Long lvl_Filial

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio		= dw_1.Object.dt_inicio				[1]
lvdt_Fim			= dw_1.Object.dt_fim					[1]
lvl_Filial			= dw_1.Object.cd_filial				[1]
lvs_UF_Fil		= dw_1.Object.cd_uf					[1]
lvl_CFOP			= dw_1.Object.cd_cfop				[1]
lvs_Movimento	= dw_1.Object.id_movimento		[1]
lvs_TipoDocto	= dw_1.Object.id_tipo_doctos		[1]
lvs_Imposto		= dw_1.Object.id_imposto			[1]

If IsNull(lvdt_Inicio) or (lvdt_Inicio < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data inicial para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_inicio')
	Return -1
Else
	This.Of_AppendWhere("nf.dh_movimentacao_caixa>='"+String(lvdt_Inicio,'YYYY/MM/DD')+"'")
End If

If IsNull(lvdt_Fim) or (lvdt_Fim < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data final para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_fim')
	Return -1
Else
	This.Of_AppendWhere("nf.dh_movimentacao_caixa<='"+String(lvdt_Fim,'YYYY/MM/DD')+"'")
End If

ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim,'DD/MM/YYYY')

//Se n$$HEX1$$e300$$ENDHEX$$o tiver filial ou fornecedor bloqueia a extra$$HEX2$$e700e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio em 31 dias.
If gf_coalesce(lvl_Filial, 0) = 0 Then
	If DaysAfter(lvdt_Inicio, lvdt_Fim) > 31 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Esse relat$$HEX1$$f300$$ENDHEX$$rio utiliza informa$$HEX2$$e700f500$$ENDHEX$$es detalhadas, por item de nota fiscal de compra, " + &
						"gerando um grande volume de dados e consumo excessivo do servidor da empresa. ~r~n~r~n"+ &
						"Favor filtrar por filial, fornecedor ou reduzir o per$$HEX1$$ed00$$ENDHEX$$odo para no m$$HEX1$$e100$$ENDHEX$$ximo 31 dias.", Exclamation!)
		Return -1
	End If
End If

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	This.Of_AppendWhere("nf.cd_filial="+String(lvl_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_filial.nm_fantasia+' ('+String(lvl_Filial)+')'
//Somente insere filtro de UF da filial caso n$$HEX1$$e300$$ENDHEX$$o tenha uma filial espec$$HEX1$$ed00$$ENDHEX$$fica informada
ElseIf lvs_UF_Fil<>'TD' Then
	This.Of_AppendWhere("nf.cd_unidade_federacao='"+lvs_UF_Fil+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF Destino: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+lvs_UF_Fil+')'
End If

If Not IsNull(lvl_CFOP) and (lvl_CFOP > 0) Then
	This.Of_AppendWhere("nf.cd_natureza_operacao+0="+String(lvl_CFOP))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'CFOP: '+String(lvl_CFOP)
End If

If Not IsNull(lvs_TipoDocto) and (lvs_TipoDocto <> 'TD') Then
	This.Of_AppendWhere("nf.tipo_docto='"+lower(lvs_TipoDocto)+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Tipo Docto: '+lvs_TipoDocto
End If

If Not IsNull(lvs_Movimento) and (lvs_Movimento <> 'T') Then
	This.Of_AppendWhere("nf.tipo_movto='"+lower(lvs_Movimento)+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Movimento: '+lvs_Movimento
End If

If Not IsNull(lvs_Imposto) and (lvs_Imposto <> 'TD') Then
	Choose Case lvs_Imposto
		Case 'IC'
			This.Of_AppendWhere("nf.vl_icms>0")
		Case 'IP'
			This.Of_AppendWhere("nf.vl_ipi>0")
		Case 'PI'
			This.Of_AppendWhere("nf.vl_pis>0")
		Case 'CO'
			This.Of_AppendWhere("nf.vl_cofins>0")
		Case 'ST'
			This.Of_AppendWhere("nf.vl_icms_st>0")
		Case Else
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Tipo de imposto n$$HEX1$$e300$$ENDHEX$$o habilitado nos filtros.',Exclamation!)
	End Choose
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Imposto: '+lvs_Imposto
End If

lvs_SQL = This.GetSQLSelect( )
This.of_ChangeSQL(lvs_SQL)

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;String lvs_SQL


lvs_SQL = This.GetSQLSelect()

Return Super::Event ue_Recuperar()
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge590_rel_dinamico_movimento_fiscal
integer x = 1865
integer y = 784
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Compras"
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge590_rel_dinamico_movimento_fiscal
integer x = 2606
integer y = 712
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge590_rel_dinamico_movimento_fiscal
end type

