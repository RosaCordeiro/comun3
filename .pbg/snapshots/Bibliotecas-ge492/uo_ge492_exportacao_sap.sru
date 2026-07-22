HA$PBExportHeader$uo_ge492_exportacao_sap.sru
forward
global type uo_ge492_exportacao_sap from nonvisualobject
end type
end forward

global type uo_ge492_exportacao_sap from nonvisualobject
end type
global uo_ge492_exportacao_sap uo_ge492_exportacao_sap

type variables
long il_cd_tabela
end variables

forward prototypes
private function boolean _uf_distrib_precos_desc (long pl_nr_atualizacao)
private function boolean _uf_grava_log (string ps_tipo, long pl_cd_tabela)
private function boolean _uf_vigencia_estoque (long pl_nr_controle)
private function boolean _uf_campanha (long pl_nr_controle)
private function boolean _uf_preco_fornecedor (long pl_nr_controle)
private function boolean _uf_libera_pedido_filial_loja_ba (long pl_nr_controle)
private function boolean _uf_est_base_min_promo (long pl_nr_controle)
private function boolean _uf_comissao_produto (long pl_nr_controle)
private function boolean _uf_custo_produto (long pl_nr_controle)
private function boolean _uf_fornecedor_conexao (long pl_nr_controle)
private function boolean _uf_historico_mrp (long pl_nr_controle)
private function boolean _uf_libera_pedido_filial_loja_nova (long pl_nr_controle)
private function boolean _uf_pbm_produto (long pl_nr_controle)
private function boolean _uf_pedido_distribuidora (long pl_nr_controle)
private function boolean _uf_pedido_filial_bloqueio (long pl_nr_controle)
private function boolean _uf_planejamento_estoque (long pl_nr_controle)
private function boolean _uf_planograma (long pl_nr_controle)
private function boolean _uf_preco_regular (long pl_nr_controle)
private function boolean _uf_preco_transferencia (long pl_nr_controle)
private function boolean _uf_promocao (long pl_nr_controle)
private function boolean _uf_recalculo_est_base (long pl_nr_controle)
private function boolean _uf_registro_info (long pl_nr_controle)
private function boolean _uf_requisicao_mrp_sap (long pl_nr_controle)
private function boolean _uf_resumo_repos_estoque_min (long pl_nr_controle)
private function boolean _uf_saldo_estoque_sap (long pl_nr_controle)
private function boolean _uf_pedido_distribuidora_retorno (long pl_nr_controle)
private function boolean _uf_melhor_condicao_venda (long pl_nr_controle)
private function boolean _uf_melhor_condicao (long pl_nr_controle)
private function boolean _uf_remanejamento (long pl_nr_controle)
private function boolean _uf_lista_tecnica_prd (long pl_nr_controle)
private function boolean _uf_lista_tecnica_prd_agrup (long pl_nr_controle)
public function boolean uf_executar (long pl_cd_tabela, long pl_nr_controle, ref string ps_msg)
public function boolean uf_executar (long pl_cd_tabela, ref string ps_msg)
private function boolean _uf_maximo_promocao (long pl_nr_controle)
private function boolean _uf_pedido_distribuidora_cancelamento (long pl_nr_controle)
private function boolean _uf_pedido_alteracao_sap (long pl_nr_controle)
public function boolean _uf_nota_fiscal (long pl_nr_controle)
private function boolean _uf_distrib_saldo (long pl_nr_atualizacao)
private function boolean _uf_contabil (long pl_nr_controle)
public function boolean _uf_campanha_c4 (long pl_nr_controle)
public function boolean _uf_clientes_excluidos (long pl_nr_controle)
private function boolean _uf_envia_confirma_qtde_recebida_nf (long pl_nr_controle)
public function boolean _uf_pedido_central (long pl_nr_controle)
public function boolean _uf_recebimento_nota_fiscal (long pl_nr_controle)
public function boolean _uf_recebimento_confirmacao_migo_miro (long pl_nr_controle)
public function boolean _uf_distrib_f5 (long pl_nr_controle)
private function boolean _uf_envia_divergencia_nfd (long pl_nr_controle)
public function boolean _uf_notas_fiscais (long pl_nr_controle)
private function boolean _uf_envia_movimento_estoque (long pl_nr_controle)
private function boolean _uf_envia_movimento_estoque_estorno (long pl_nr_controle)
public function boolean _uf_movimento_estoque_confirmacao (long pl_nr_controle)
private function boolean _uf_envia_cancelamento_nfd (long pl_nr_controle)
public function boolean _uf_estorno_recebimento (long pl_nr_controle)
private function boolean _uf_envia_ordem_venda_estorno (long pl_nr_controle)
private function boolean _uf_envia_recebimento_compra_loja (long pl_nr_controle)
public function boolean _uf_envio_ordem_venda (long pl_nr_controle)
private function boolean _uf_envia_confere_estoque (long pl_nr_controle)
private function boolean _uf_envia_verba_pescador (long pl_nr_controle)
private function boolean _uf_envia_devolucao_coleta (long pl_nr_controle)
public function boolean _uf_envia_imposto (long pl_nr_controle)
public function boolean _uf_envia_retira_venda_promocao (long pl_nr_controle)
public function boolean _uf_envia_loja_nf_transferencia (long pl_nr_controle)
private function boolean _uf_envia_loja_nf_inventario (long pl_nr_controle)
private function boolean _uf_envia_loja_nf_inventario_est (long pl_nr_controle)
public function boolean _uf_recebe_estorno_nf_compra (long pl_nr_controle)
public function boolean _uf_confirma_rec_nf_trans (long pl_nr_controle)
public function boolean uf_recebe_registro_info (long pl_nr_controle)
public function boolean _uf_recebe_retirada_excesso_estoque (long pl_nr_controle)
private function boolean _uf_envia_nf_servico (long pl_nr_controle)
public function boolean _uf_recebe_arvore_mercadologica (long pl_nr_controle)
private function boolean _uf_envia_est_nf_servico (long pl_nr_controle)
private function boolean _uf_envia_divergencia_impostos (long pl_nr_controle)
private function boolean _uf_envia_nf_diversa (long pl_nr_controle)
public function boolean uf_limpar_tabelas ()
private function boolean _uf_est_nf_diversa (long pl_nr_controle)
public function boolean _uf_recebe_grupo_mercadorias (long pl_nr_controle)
private function boolean _uf_titulo_receber (long pl_nr_controle)
private function boolean _uf_preco_desconto (long pl_nr_controle)
private function boolean _uf_envia_imposto_j1btax (long pl_nr_controle)
private function boolean _uf_estoque_produto (long pl_nr_controle)
public function boolean _uf_subsortimento_forn (long pl_nr_controle)
public function boolean _uf_recebe_meta_compras (long pl_nr_controle)
public function boolean uf_executar (long pl_cd_tabela, long pl_nr_controle, string ps_nr_controle, ref string ps_msg)
private function boolean _uf_est_base_minimo_promocao_sap (string ps_nr_controle)
private function boolean _uf_est_base_principal_sap (string ps_nr_controle)
private function boolean _uf_est_base_minimo_plan_sap (string ps_nr_controle)
public function boolean _uf_mov_estoque (string ps_nr_controle)
public function boolean _uf_titulo_sap (long pl_nr_controle)
public function boolean _uf_estoque_base_resumo_filial (string ps_nr_controle)
private function boolean _uf_fornecedor (long pl_nr_controle)
private function boolean _uf_preco_pmc (long pl_nr_controle)
private function boolean _uf_preco_regular_profimetrics (long pl_nr_controle)
public function boolean _uf_recebe_produto_grupo_extra (long pl_nr_controle)
end prototypes

private function boolean _uf_distrib_precos_desc (long pl_nr_atualizacao);uo_ge481_distrib_preco_desc uo

if pl_nr_atualizacao > 0 Then
	uo.of_processa_envio(pl_nr_atualizacao)
else
	uo.of_processa_envio()
end if

return True
end function

private function boolean _uf_grava_log (string ps_tipo, long pl_cd_tabela);//long ll_nr_sequencial
//string ls_erro
//
//If ps_tipo = 'I' Then
//	
//	Select max(nr_sequencial)
//	into :ll_nr_sequencial
//	from log_execucao_interface;
//	
//	if sqlca.sqlcode = -1 then 
//		ls_erro = sqlca.sqlerrtext
//		Rollback;
//		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela "log_execucao_interface": ' + ls_erro)
//		return false
//	end if
//	
//	if ll_nr_sequencial = 0 or isnull(ll_nr_sequencial) Then
//		ll_nr_sequencial = 1
//	else
//		ll_nr_sequencial++
//	end if
//	
//	Insert into log_execucao_interface(nr_sequencial, cd_tabela, dh_inicio)
//	values(:ll_nr_sequencial, :pl_cd_tabela, getdate());
//
//	if sqlca.sqlcode = -1 then 
//		ls_erro = sqlca.sqlerrtext
//		Rollback;
//		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao inserir registro na tabela "log_execucao_interface": ' + ls_erro)
//		return false
//	end if
//
//	pl_nr_sequencial = ll_nr_sequencial
//	
//elseif ps_tipo = 'T' Then
//	
//	Update log_execucao_interface
//	set dh_termino = getdate()
//	where nr_sequencial = :pl_nr_sequencial;
//	
//	if sqlca.sqlcode = -1 then 
//		ls_erro = sqlca.sqlerrtext
//		Rollback;
//		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao atualizar a tabela "log_execucao_interface": ' + ls_erro)
//		return false
//	end if
//	
//end if
//
//Commit;
//
return true
end function

private function boolean _uf_vigencia_estoque (long pl_nr_controle);uo_ge473_vigencia_estoque_promocao  lvo_vigencia
Try
	
	lvo_vigencia = Create uo_ge473_vigencia_estoque_promocao
	
	if pl_nr_controle > 0 Then
		lvo_vigencia.of_atualiza_vigencia_promocao( pl_nr_controle, il_cd_tabela)
	else
		lvo_vigencia.of_processa_atualizacao( )
	end if
	
Finally
	Destroy(lvo_vigencia)
End Try	

return true
end function

private function boolean _uf_campanha (long pl_nr_controle);uo_ge473_campanha_sap lvo_campanha
Try
	
	lvo_campanha = Create uo_ge473_campanha_sap
	
	if pl_nr_controle > 0 Then	
		lvo_campanha.of_atualiza_campanha( pl_nr_controle, il_cd_tabela)
	else
		lvo_campanha.of_processa_atualizacao( )
	end if
	
Finally
	Destroy(lvo_campanha)
End Try	

return true
end function

private function boolean _uf_preco_fornecedor (long pl_nr_controle);uo_ge473_preco_fornecedor lo_preco_forn
Try
	lo_preco_forn = Create uo_ge473_preco_fornecedor
	
	if pl_nr_controle > 0 then
		lo_preco_forn.of_atualiza_preco_fornecedor( pl_nr_controle, il_cd_tabela)
	else
		lo_preco_forn.of_processa_atualizacao()
	end if

Finally
	Destroy(lo_preco_forn)
End Try	

return true
end function

private function boolean _uf_libera_pedido_filial_loja_ba (long pl_nr_controle);uo_ge473_pedido_liberacao_loja_ba lo_pedido_liberacao_loja_ba
Try
	lo_pedido_liberacao_loja_ba = Create uo_ge473_pedido_liberacao_loja_ba
	
	if pl_nr_controle > 0 Then
		lo_pedido_liberacao_loja_ba.of_atualiza_pedido_liberacao_loja_ba( pl_nr_controle, il_cd_tabela)
	else
		lo_pedido_liberacao_loja_ba.of_processa_atualizacao()
	end if

Finally
	Destroy(lo_pedido_liberacao_loja_ba)
End Try	

return true
end function

private function boolean _uf_est_base_min_promo (long pl_nr_controle);uo_ge481_est_base_min_promo lo_Sap_EstBase_Min

Try
	lo_Sap_EstBase_Min = Create uo_ge481_est_base_min_promo
	
	if pl_nr_controle > 0 Then
		lo_Sap_EstBase_Min.of_processa_envio_est_base_min_pro( pl_nr_controle )
	else
		lo_Sap_EstBase_Min.of_processa_envio_est_base_min_pro(0)
	end if
	
Finally
	Destroy(lo_Sap_EstBase_Min)
End Try
	
return true
end function

private function boolean _uf_comissao_produto (long pl_nr_controle);uo_ge473_comissao_produto lo_comissao_produto
Try
	lo_comissao_produto = Create uo_ge473_comissao_produto
	
	if pl_nr_controle > 0 then
		lo_comissao_produto.of_atualiza_comissao( pl_nr_controle,  il_cd_tabela)
	else
		lo_comissao_produto.of_processa_atualizacao()
	end if

Finally
	Destroy(lo_comissao_produto)
End Try	

return true
end function

private function boolean _uf_custo_produto (long pl_nr_controle);uo_ge481_custo_produto luo_custo_produto

if pl_nr_controle > 0 Then
	luo_custo_produto.of_processa_envio(pl_nr_controle)
else
	luo_custo_produto.of_processa_envio()
end if

return true
end function

private function boolean _uf_fornecedor_conexao (long pl_nr_controle);uo_ge473_fornecedor_conexao lvo_Fornecedor_Conexao

Try
	
	lvo_Fornecedor_Conexao = Create uo_ge473_fornecedor_conexao
	
	if pl_nr_controle > 0 Then
		lvo_Fornecedor_Conexao.of_executa_fornecedor_conexao( pl_nr_controle,  il_cd_tabela)
	else
		lvo_Fornecedor_Conexao.of_processa_atualizacao()
	end if
	
Finally

	Destroy(lvo_Fornecedor_Conexao)

End Try	

return true
end function

private function boolean _uf_historico_mrp (long pl_nr_controle);uo_ge481_hist_consumo_mrp uo
	
if pl_nr_controle > 0 Then	
	uo.of_processa_envio(pl_nr_controle)
else
	uo.of_processa_envio()
end if

return true
end function

private function boolean _uf_libera_pedido_filial_loja_nova (long pl_nr_controle);uo_ge473_pedido_liberacao_loja_nova lo_pedido_liberacao_loja_nova
Try
	lo_pedido_liberacao_loja_nova = Create uo_ge473_pedido_liberacao_loja_nova
	
	if pl_nr_controle > 0 then
		lo_pedido_liberacao_loja_nova.of_atualiza_pedido_liberacao_loja_nova( pl_nr_controle, il_cd_tabela)
	else
		lo_pedido_liberacao_loja_nova.of_processa_atualizacao()
	end if

Finally
	Destroy(lo_pedido_liberacao_loja_nova)
End Try	

return true
end function

private function boolean _uf_pbm_produto (long pl_nr_controle);uo_ge481_pbm_produto luo_pbm_produto

if pl_nr_controle > 0 then
	luo_pbm_produto.of_processa_envio(pl_nr_controle)
else
	luo_pbm_produto.of_processa_envio()
end if

return true
end function

private function boolean _uf_pedido_distribuidora (long pl_nr_controle);uo_ge481_sap_pedido lo_pedido

Try
	
	lo_pedido = Create uo_ge481_sap_pedido
	
	if pl_nr_controle > 0 then
		lo_pedido.of_processa_envio_pedido(pl_nr_controle)
	else
		lo_pedido.of_processa_envio_pedido()
	end if
	
Finally
	Destroy(lo_pedido)
End Try	

return true
end function

private function boolean _uf_pedido_filial_bloqueio (long pl_nr_controle);uo_ge473_pedido_filial_bloqueio_sap	lo_Pedido_Filial_Bloqueio_SAP
						 
Try
	lo_Pedido_Filial_Bloqueio_SAP	= Create uo_ge473_pedido_filial_bloqueio_sap
	
	if pl_nr_controle > 0 then
		lo_Pedido_Filial_Bloqueio_SAP.of_atualiza_pedido_filial_bloqueio( pl_nr_controle, il_cd_tabela )
	else
		lo_Pedido_Filial_Bloqueio_SAP.of_processa_atualizacao( )
	end if

Finally
	Destroy(lo_Pedido_Filial_Bloqueio_SAP)
End Try

return true







end function

private function boolean _uf_planejamento_estoque (long pl_nr_controle);uo_ge473_planejamento_estoque_sap lo_planejamento_estoque_sap
Try
	lo_planejamento_estoque_sap = Create uo_ge473_planejamento_estoque_sap
	
	if pl_nr_controle > 0 then
		lo_planejamento_estoque_sap.of_atualiza_planejamento_estoque_sap( pl_nr_controle, il_cd_tabela)
	else
		lo_planejamento_estoque_sap.of_processa_atualizacao()
	end if

Finally
	Destroy(lo_planejamento_estoque_sap)
End Try	

return true
end function

private function boolean _uf_planograma (long pl_nr_controle);uo_ge481_planograma uo

Try
	uo = Create uo_ge481_planograma
	
	if pl_nr_controle > 0 Then
		uo.of_processa_envio(pl_nr_controle)
	else
		uo.of_processa_envio()
	end if
	
Finally

	Destroy(uo)
End Try	

return true
end function

private function boolean _uf_preco_regular (long pl_nr_controle);uo_ge473_preco_regular lo_preco_regular
Try
	lo_preco_regular = Create uo_ge473_preco_regular
	
	if pl_nr_controle > 0 then
		lo_preco_regular.of_atualiza_preco_regular( pl_nr_controle, il_cd_tabela )
	else
		lo_preco_regular.of_processa_atualizacao()
	end if
	
Finally
	Destroy(lo_preco_regular)
End Try	


return true
end function

private function boolean _uf_preco_transferencia (long pl_nr_controle);uo_ge473_preco_transferencia lo_preco_transferencia
Try
	lo_preco_transferencia = Create uo_ge473_preco_transferencia
	
	if pl_nr_controle > 0 Then
		lo_preco_transferencia.of_atualiza_preco_transferencia( pl_nr_controle, il_cd_tabela)
	else
		lo_preco_transferencia.of_processa_atualizacao()
	end if

Finally
	Destroy(lo_preco_transferencia)
End Try	

return true
end function

private function boolean _uf_promocao (long pl_nr_controle);uo_ge473_promocao_sap  lvo_promocao_sap
Try
	
	lvo_promocao_sap = Create uo_ge473_promocao_sap

	if pl_nr_controle > 0 then
		lvo_promocao_sap.of_atualiza_promocao( pl_nr_controle, il_cd_tabela)
	else
		lvo_promocao_sap.of_processa_atualizacao( )
	end if

Finally
	Destroy(lvo_promocao_sap)
End Try	

return true
end function

private function boolean _uf_recalculo_est_base (long pl_nr_controle);uo_ge481_est_base luo_est_base

if pl_nr_controle > 0 Then
	luo_est_base.of_processa_envio(pl_nr_controle)
else
	luo_est_base.of_processa_envio()
end if	

return true
end function

private function boolean _uf_registro_info (long pl_nr_controle);uo_ge481_registro_info luo_registro_info

if pl_nr_controle > 0 Then
	luo_registro_info.of_processa_envio(pl_nr_controle)
else
	luo_registro_info.of_processa_envio()
end if

return true
end function

private function boolean _uf_requisicao_mrp_sap (long pl_nr_controle);uo_ge473_requisicao_mrp_sap  lvo_requisicao_mrp_sap

Try
	
	lvo_requisicao_mrp_sap = Create uo_ge473_requisicao_mrp_sap
	
	if pl_nr_controle > 0 then
		lvo_requisicao_mrp_sap.of_atualiza_requisicao_mrp_sap( pl_nr_controle)
	else
		lvo_requisicao_mrp_sap.of_processa_atualizacao()
	end if
	
Finally

	Destroy(lvo_requisicao_mrp_sap)

End Try	

return true
end function

private function boolean _uf_resumo_repos_estoque_min (long pl_nr_controle);uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap lvo_re
Try
	lvo_re = Create uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap
	
	if pl_nr_controle > 0 Then
		lvo_re.of_atualiza_resumo_repos_est_sos_est_min( pl_nr_controle, il_cd_tabela)
	else
		lvo_re.of_processa_atualizacao()
	end if

Finally
	Destroy(lvo_re)
End Try	

return true
end function

private function boolean _uf_saldo_estoque_sap (long pl_nr_controle);uo_ge473_saldo_estoque_sap lvo_saldo_estoque_sap
Try
	lvo_saldo_estoque_sap = Create uo_ge473_saldo_estoque_sap

	if pl_nr_controle > 0 Then
		lvo_saldo_estoque_sap.of_atualiza_saldo_estoque_sap( pl_nr_controle,  il_cd_tabela)
	else
		lvo_saldo_estoque_sap.of_processa_atualizacao()	
	end if

Finally
	Destroy(lvo_saldo_estoque_sap)
End Try	

return true
end function

private function boolean _uf_pedido_distribuidora_retorno (long pl_nr_controle);uo_ge481_sap_pedido_retorno lo_pedido

Try
	
	lo_pedido = Create uo_ge481_sap_pedido_retorno
	
	if pl_nr_controle > 0 then
		lo_pedido.of_processa_envio(pl_nr_controle)
	else
		lo_pedido.of_processa_envio()
	end if
	
Finally
	Destroy(lo_pedido)
End Try	

return true
end function

private function boolean _uf_melhor_condicao_venda (long pl_nr_controle);uo_ge473_melhor_condicao_venda  lvo_condicao_venda
Try
	
	lvo_condicao_venda = Create uo_ge473_melhor_condicao_venda

	if pl_nr_controle > 0 then
		lvo_condicao_venda.of_atualiza_melhor_condicao( pl_nr_controle, il_cd_tabela)
	else
		lvo_condicao_venda.of_processa_atualizacao( )
	end if

Finally
	Destroy(lvo_condicao_venda)
End Try	
	
return true
end function

private function boolean _uf_melhor_condicao (long pl_nr_controle);uo_ge481_is_melhor_compra uo

Try
	uo = Create uo_ge481_is_melhor_compra
	
	if pl_nr_controle > 0 Then
		uo.of_processa_envio(pl_nr_controle)
	else
		uo.of_processa_envio()
	End if
	
Finally

	Destroy(uo)
End Try	

return true
end function

private function boolean _uf_remanejamento (long pl_nr_controle);uo_ge473_remanejamento lvo_lista
Try
	
	lvo_lista = Create uo_ge473_remanejamento
	
	if pl_nr_controle > 0 Then	
		lvo_lista.of_atualiza_remanejamento( pl_nr_controle, il_cd_tabela)
	else
		lvo_lista.of_processa_atualizacao( )
	end if
	
Finally
	Destroy(lvo_lista)
End Try	

return true
end function

private function boolean _uf_lista_tecnica_prd (long pl_nr_controle);uo_ge473_lista_tecnica_prd lvo_lista
Try
	
	lvo_lista = Create uo_ge473_lista_tecnica_prd
	
	if pl_nr_controle > 0 Then	
		lvo_lista.of_atualiza_composicao( pl_nr_controle, il_cd_tabela)
	else
		lvo_lista.of_processa_atualizacao( )
	end if
	
Finally
	Destroy(lvo_lista)
End Try	

return true
end function

private function boolean _uf_lista_tecnica_prd_agrup (long pl_nr_controle);uo_ge473_lista_tecnica_prd_agrup lvo_lista
Try
	
	lvo_lista = Create uo_ge473_lista_tecnica_prd_agrup
	
	if pl_nr_controle > 0 Then	
		lvo_lista.of_atualiza_agrupamento( pl_nr_controle, il_cd_tabela)
	else
		lvo_lista.of_processa_atualizacao( )
	end if
	
Finally
	Destroy(lvo_lista)
End Try	

return true
end function

public function boolean uf_executar (long pl_cd_tabela, long pl_nr_controle, ref string ps_msg);String	ls_null


SetNull(ls_null)

Return uf_executar(pl_cd_tabela, pl_nr_controle, ls_null, REF ps_msg)
end function

public function boolean uf_executar (long pl_cd_tabela, ref string ps_msg);return uf_executar(pl_cd_tabela, 0, ref ps_msg)
end function

private function boolean _uf_maximo_promocao (long pl_nr_controle);uo_ge473_maximo_promocao lvo_maximo
Try
	
	lvo_maximo = Create uo_ge473_maximo_promocao
	
	if pl_nr_controle > 0 Then	
		lvo_maximo.of_atualiza_maximo_promocao( pl_nr_controle, il_cd_tabela)
	else
		lvo_maximo.of_processa_atualizacao( )
	end if
	
Finally
	Destroy(lvo_maximo)
End Try	

return true
end function

private function boolean _uf_pedido_distribuidora_cancelamento (long pl_nr_controle);uo_ge481_sap_pedido_cancelamento lo_pedido

Try
	
	lo_pedido = Create uo_ge481_sap_pedido_cancelamento
	
	if pl_nr_controle > 0 then
		lo_pedido.of_processa_envio(pl_nr_controle)
	else
		lo_pedido.of_processa_envio()
	end if
	
Finally
	Destroy(lo_pedido)
End Try	

return true
end function

private function boolean _uf_pedido_alteracao_sap (long pl_nr_controle);uo_ge473_pedido_alteracao_sap lo_pedido

Try
	
	lo_pedido = Create uo_ge473_pedido_alteracao_sap
	
	if pl_nr_controle > 0 then
		lo_pedido.of_atualiza_pedido_alteracao( pl_nr_controle, il_cd_tabela)
	else
		lo_pedido.of_processa_atualizacao( )
	end if
	
Finally
	Destroy(lo_pedido)
End Try	

return true
end function

public function boolean _uf_nota_fiscal (long pl_nr_controle);uo_ge473_nota_fiscal_sap  lvo_nota
Try
	
	lvo_nota = Create uo_ge473_nota_fiscal_sap

	if pl_nr_controle > 0 then
		lvo_nota.of_atualiza_nota_fiscal( pl_nr_controle, il_cd_tabela)
	else
		lvo_nota.of_processa_atualizacao( )
		
		gf_atualiza_data_execucao_tarefa(116,True)	
		
	end if

Finally
	Destroy(lvo_nota)
End Try	

return true
end function

private function boolean _uf_distrib_saldo (long pl_nr_atualizacao);uo_ge481_distrib_saldo uo

if pl_nr_atualizacao > 0 Then
	uo.of_processa_envio(pl_nr_atualizacao)
else
	uo.of_processa_envio()
end if

return True
end function

private function boolean _uf_contabil (long pl_nr_controle);uo_ge473_contabil lvo_contabil
Try
	
	lvo_contabil = Create uo_ge473_contabil

	if pl_nr_controle > 0 then
		lvo_contabil.of_atualiza_contabil(pl_nr_controle, il_cd_tabela)
	else
		lvo_contabil.of_processa_atualizacao( )
		
		gf_atualiza_data_execucao_tarefa(117,True)	
		
	end if

Finally
	Destroy(lvo_contabil)
End Try	

return true
end function

public function boolean _uf_campanha_c4 (long pl_nr_controle);uo_ge473_campanha_c4 lvo_campanha
Try
	
	lvo_campanha = Create uo_ge473_campanha_c4
	
	if pl_nr_controle > 0 Then	
		lvo_campanha.of_atualiza_campanha( pl_nr_controle, il_cd_tabela)
	else
		lvo_campanha.of_processa_atualizacao( )
		
		gf_atualiza_data_execucao_tarefa(86,True)	
		
	end if
	
Finally
	Destroy(lvo_campanha)
End Try	

return true
end function

public function boolean _uf_clientes_excluidos (long pl_nr_controle);uo_ge481_clientes_excluidos luo_interface

luo_interface = create uo_ge481_clientes_excluidos 

if pl_nr_controle > 0 Then
	luo_interface.of_processa_envio(pl_nr_controle)
else
	luo_interface.of_processa_envio()
end if	

Destroy(luo_interface)

return true
end function

private function boolean _uf_envia_confirma_qtde_recebida_nf (long pl_nr_controle);uo_ge481_wms_confirma_receb_nf_compra luo_envio_confirma_receb_nf_compra

if pl_nr_controle > 0 Then
	luo_envio_confirma_receb_nf_compra.of_processa_envio(pl_nr_controle)
else
	luo_envio_confirma_receb_nf_compra.of_processa_envio()
end if

return true
end function

public function boolean _uf_pedido_central (long pl_nr_controle);uo_ge473_pedido_central lvo_pedido_central   
Try
	
	lvo_pedido_central = Create uo_ge473_pedido_central
//	pl_nr_controle = 1450785
	if pl_nr_controle > 0 then
		lvo_pedido_central.of_processa_pedido_central( pl_nr_controle, il_cd_tabela)
	else
		lvo_pedido_central.of_processa_atualizacao( )		
	end if

Finally
	Destroy(lvo_pedido_central)
End Try	

return true
end function

public function boolean _uf_recebimento_nota_fiscal (long pl_nr_controle);uo_ge473_wms_recebimento_nf  lvo_receb
Try
	
	lvo_receb = Create uo_ge473_wms_recebimento_nf

	if pl_nr_controle > 0 then
		lvo_receb.of_atualiza_recebimento_nota_fiscal( pl_nr_controle, il_cd_tabela)
	else
		lvo_receb.of_processa_atualizacao( )
		
	end if

Finally
	Destroy(lvo_receb)
End Try	

return true
end function

public function boolean _uf_recebimento_confirmacao_migo_miro (long pl_nr_controle);uo_ge473_wms_conf_migo_miro  lvo_receb_conf
Try
	
	lvo_receb_conf = Create uo_ge473_wms_conf_migo_miro

	if pl_nr_controle > 0 then
		lvo_receb_conf.of_atualiza_recebimento_nota_fiscal( pl_nr_controle, il_cd_tabela)
	else
		lvo_receb_conf.of_processa_atualizacao( )
		
	end if

Finally
	Destroy(lvo_receb_conf)
End Try	

return true
end function

public function boolean _uf_distrib_f5 (long pl_nr_controle);uo_ge481_distribuidora_produto lo_distribuidora_f5
Try
	lo_distribuidora_f5 = Create uo_ge481_distribuidora_produto
	
	if pl_nr_controle > 0 then
		lo_distribuidora_f5.of_processa_envio(pl_nr_controle)
	else
		lo_distribuidora_f5.of_processa_envio()
	end if

Finally
	Destroy(lo_distribuidora_f5)
End Try	

return true
end function

private function boolean _uf_envia_divergencia_nfd (long pl_nr_controle);uo_ge481_wms_envio_divergencias_nfd luo_ge481_envio_divergencias_nfd

if pl_nr_controle > 0 Then
	luo_ge481_envio_divergencias_nfd.of_processa_envio(pl_nr_controle)
else
	luo_ge481_envio_divergencias_nfd.of_processa_envio()
end if

return true
end function

public function boolean _uf_notas_fiscais (long pl_nr_controle);String ls_log

uo_ge537_nota_fiscal  lvo_nota
Try
	
	lvo_nota = Create uo_ge537_nota_fiscal

	if pl_nr_controle > 0 then
		//lvo_nota.of_atualiza_nota_fiscal( pl_nr_controle, il_cd_tabela)
	else
		lvo_nota.of_processa_atualizacao(0)
		
	end if

Finally
	Destroy(lvo_nota)
End Try	

return true
end function

private function boolean _uf_envia_movimento_estoque (long pl_nr_controle);uo_ge481_wms_movimento_estoque luo_ge481_wms_movimento_estoque

if pl_nr_controle > 0 Then
	luo_ge481_wms_movimento_estoque.of_processa_envio(pl_nr_controle)
else
	luo_ge481_wms_movimento_estoque.of_processa_envio()
end if

return true

/* Aqui se pl_nr_controle for zero,
	processa todos chamando a of_processa_envio para cada um.
	Descomentar caso continue abortando no primeiro erro a interface /MVTO.
	O prob. e a solu$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o documentados no chamado #1719600.
	Necess$$HEX1$$e100$$ENDHEX$$rio testar.

String lvs_Log
Long lvl_Linhas, lvl_For, lvl_nr_atualizacao
uo_ge481_wms_movimento_estoque luo_ge481_wms_movimento_estoque

// Chegou controle, processa e finaliza
if pl_nr_controle > 0 Then
	luo_ge481_wms_movimento_estoque.of_processa_envio(pl_nr_controle)
	Return True
End If

// Chegou 0, carregar e processar todos
dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject(luo_ge481_wms_movimento_estoque.is_DS, False) Then
	/// gerar log
	Return False
End If

luo_ge481_wms_movimento_estoque._of_filtra_nr_atualizacao( ref lds, 0, ref lvs_Log)

lvl_Linhas = lds.Retrieve()

For lvl_For = 1 To lvl_Linhas
	lvl_nr_atualizacao = lds.GetItemNumber(lvl_For, "nr_atualizacao")
//	luo_ge481_wms_movimento_estoque.of_processa_envio(lvl_nr_atualizacao) // Verificar se deixa esta
//	This._uf_envia_movimento_estoque(lvl_nr_atualizacao)						 // ou esta, se precisar instanciar um luo_ge481_wms_movimento_estoque a cada controle
Next

Destroy lds

Return True
*/
end function

private function boolean _uf_envia_movimento_estoque_estorno (long pl_nr_controle);uo_ge481_wms_movimento_estoque_estorno luo_ge481_wms_movimento_estoque_estorno

if pl_nr_controle > 0 Then
	luo_ge481_wms_movimento_estoque_estorno.of_processa_envio(pl_nr_controle)
else
	luo_ge481_wms_movimento_estoque_estorno.of_processa_envio()
end if

return true
end function

public function boolean _uf_movimento_estoque_confirmacao (long pl_nr_controle);uo_ge473_wms_movimento_estoque_confirmacao  lvo_mov_estoque
Try
	
	lvo_mov_estoque = Create uo_ge473_wms_movimento_estoque_confirmacao

	if pl_nr_controle > 0 then
		lvo_mov_estoque.of_atualiza_confirmacao_mov_estoque( pl_nr_controle, il_cd_tabela)
	else
		lvo_mov_estoque.of_processa_atualizacao( )
		
	end if

Finally
	Destroy(lvo_mov_estoque)
End Try	

return true
end function

private function boolean _uf_envia_cancelamento_nfd (long pl_nr_controle);uo_ge481_wms_cancelamento_nfd luo_ge481_wms_cancelamento_nfd

if pl_nr_controle > 0 Then
	luo_ge481_wms_cancelamento_nfd.of_processa_envio(pl_nr_controle)
else
	luo_ge481_wms_cancelamento_nfd.of_processa_envio()
end if

return true
end function

public function boolean _uf_estorno_recebimento (long pl_nr_controle);uo_ge481_wms_estorno_recebimento	luo_ge481_estorno_recebimento


luo_ge481_estorno_recebimento	= create uo_ge481_wms_estorno_recebimento

if pl_nr_controle > 0 Then
	luo_ge481_estorno_recebimento.of_processa_envio(pl_nr_controle)
else
	luo_ge481_estorno_recebimento.of_processa_envio()
end if

Destroy luo_ge481_estorno_recebimento

return true
end function

private function boolean _uf_envia_ordem_venda_estorno (long pl_nr_controle);uo_ge481_wms_ordem_venda_estorno luo_ge481_wms_ordem_venda_estorno

if pl_nr_controle > 0 Then
	luo_ge481_wms_ordem_venda_estorno.of_processa_envio(pl_nr_controle)
else
	luo_ge481_wms_ordem_venda_estorno.of_processa_envio()
end if

return true
end function

private function boolean _uf_envia_recebimento_compra_loja (long pl_nr_controle);uo_ge481_recebimento_compra_loja luo_ge481_recebimento_compra_loja

if pl_nr_controle > 0 Then
	luo_ge481_recebimento_compra_loja.of_processa_envio(pl_nr_controle)
else
	luo_ge481_recebimento_compra_loja.of_processa_envio()
end if

return true
end function

public function boolean _uf_envio_ordem_venda (long pl_nr_controle);Long ldh_Dia
Long ldh_Hora

ldh_Dia = Day(Date(gf_getServerDate()))
ldh_Hora = Hour(Time(gf_getServerDate()))

//  No dia 01 do M$$HEX1$$ea00$$ENDHEX$$s 
If ldh_Dia = 1 Then 
	// das 00:00 at$$HEX1$$e900$$ENDHEX$$ 04:00 
	If ldh_Hora >= 0 and ldh_Hora  <= 4 Then 
		Return True    //// N$$HEX1$$e300$$ENDHEX$$o deve executar Esta Inteface
	End If 	
End If 


uo_ge481_wms_ordem_venda	luo_ge481_wms_ordem_venda
luo_ge481_wms_ordem_venda	= Create uo_ge481_wms_ordem_venda

If pl_nr_controle > 0 Then
	luo_ge481_wms_ordem_venda.of_processa_envio(pl_nr_controle)
Else
	luo_ge481_wms_ordem_venda.of_processa_envio()
End If

Destroy luo_ge481_wms_ordem_venda

Return True 
end function

private function boolean _uf_envia_confere_estoque (long pl_nr_controle);uo_ge481_wms_confere_saldo luo_ge481_wms_confere_saldo

if pl_nr_controle > 0 Then
	luo_ge481_wms_confere_saldo.of_processa_envio(pl_nr_controle)
else
	luo_ge481_wms_confere_saldo.of_processa_envio()
end if

return true
end function

private function boolean _uf_envia_verba_pescador (long pl_nr_controle);uo_ge481_co_verbas_percador luo_ge481_co_verbas_percador

if pl_nr_controle > 0 Then
	luo_ge481_co_verbas_percador.of_processa_envio(pl_nr_controle)
else
	luo_ge481_co_verbas_percador.of_processa_envio()
end if

return true
end function

private function boolean _uf_envia_devolucao_coleta (long pl_nr_controle);uo_ge481_co_coleta_devolucao luo_ge481_co_coleta_devolucao

if pl_nr_controle > 0 Then
	luo_ge481_co_coleta_devolucao.of_processa_envio(pl_nr_controle)
else
	luo_ge481_co_coleta_devolucao.of_processa_envio()
end if

return true
end function

public function boolean _uf_envia_imposto (long pl_nr_controle);//DESCIDA

uo_ge473_wms_imposto	lvo_imposto
Try
	
	lvo_imposto = Create uo_ge473_wms_imposto

	if pl_nr_controle > 0 then
		lvo_imposto.of_atualiza_imposto( pl_nr_controle, il_cd_tabela)
	else
		lvo_imposto.of_processa_atualizacao( il_cd_tabela )
		
	end if

Finally
	Destroy(lvo_imposto)
End Try	

return true
end function

public function boolean _uf_envia_retira_venda_promocao (long pl_nr_controle);uo_ge473_retira_venda_promocao lvo_retira_venda_promocao
Try
	
	lvo_retira_venda_promocao = Create uo_ge473_retira_venda_promocao

	if pl_nr_controle > 0 then
		lvo_retira_venda_promocao.of_atualiza_retira_venda_promocao( pl_nr_controle, il_cd_tabela)
	else
		lvo_retira_venda_promocao.of_processa_atualizacao( il_cd_tabela )
		
	end if

Finally
	Destroy(lvo_retira_venda_promocao)
End Try	

return true
end function

public function boolean _uf_envia_loja_nf_transferencia (long pl_nr_controle);uo_ge481_nf_transferencia_loja lvo_nf_transf_loja

if pl_nr_controle <> 0 Then
	lvo_nf_transf_loja.of_processa_envio(pl_nr_controle)
else
	lvo_nf_transf_loja.of_processa_envio()
end if

return true
end function

private function boolean _uf_envia_loja_nf_inventario (long pl_nr_controle);uo_ge481_loja_nf_inventario luo_ge481_loja_nf_inventario

if pl_nr_controle > 0 Then
	luo_ge481_loja_nf_inventario.of_processa_envio(pl_nr_controle)
else
	luo_ge481_loja_nf_inventario.of_processa_envio()
end if

return true
end function

private function boolean _uf_envia_loja_nf_inventario_est (long pl_nr_controle);uo_ge481_loja_nf_inventario_estorno luo_ge481_loja_nf_inventario_est

if pl_nr_controle > 0 Then
	luo_ge481_loja_nf_inventario_est.of_processa_envio(pl_nr_controle)
else
	luo_ge481_loja_nf_inventario_est.of_processa_envio()
end if

return true
end function

public function boolean _uf_recebe_estorno_nf_compra (long pl_nr_controle);uo_ge473_estorno_nf_compra lvo_estorno_nf_compra

Try
	lvo_estorno_nf_compra = Create uo_ge473_estorno_nf_compra

	if pl_nr_controle > 0 then
		lvo_estorno_nf_compra.of_estorna_nf_compra( pl_nr_controle, il_cd_tabela)
	else
		lvo_estorno_nf_compra.of_processa_atualizacao( il_cd_tabela )
		
	end if

Finally
	Destroy(lvo_estorno_nf_compra)
End Try	

return true
end function

public function boolean _uf_confirma_rec_nf_trans (long pl_nr_controle);uo_ge481_conf_rec_nf_trans luo_conf_rec_nf_trans

if pl_nr_controle > 0 Then
	luo_conf_rec_nf_trans.of_processa_envio(pl_nr_controle)
else
	luo_conf_rec_nf_trans.of_processa_envio()
end if

return true
end function

public function boolean uf_recebe_registro_info (long pl_nr_controle);uo_ge473_registro_info lvo_registro_info
Try
	
	lvo_registro_info = Create uo_ge473_registro_info

	if pl_nr_controle > 0 then
		lvo_registro_info.of_atualiza_registro_info( pl_nr_controle, il_cd_tabela)
	else
		lvo_registro_info.of_processa_atualizacao( il_cd_tabela )
		
	end if

Finally
	Destroy(lvo_registro_info)
End Try	

return true
end function

public function boolean _uf_recebe_retirada_excesso_estoque (long pl_nr_controle);uo_ge473_retira_excesso_estoque lvo_retira_excesso_estoque

Try
	lvo_retira_excesso_estoque = Create uo_ge473_retira_excesso_estoque

	if pl_nr_controle > 0 then
		lvo_retira_excesso_estoque.of_atualiza_retira_excesso_estoque( pl_nr_controle, il_cd_tabela)
	else
		lvo_retira_excesso_estoque.of_processa_atualizacao( il_cd_tabela )
	end if
Finally
	Destroy(lvo_retira_excesso_estoque)
End Try	

return true
end function

private function boolean _uf_envia_nf_servico (long pl_nr_controle);uo_ge481_nf_servico luo_ge481_nf_servico

if pl_nr_controle > 0 Then
	luo_ge481_nf_servico.of_processa_envio(pl_nr_controle)
else
	luo_ge481_nf_servico.of_processa_envio()
end if

return true
end function

public function boolean _uf_recebe_arvore_mercadologica (long pl_nr_controle);uo_ge473_arvore_mercadologica luo_ge473_arvore_mercadologica

Try
	luo_ge473_arvore_mercadologica = Create uo_ge473_arvore_mercadologica

	if pl_nr_controle > 0 then
		luo_ge473_arvore_mercadologica.of_atualiza_arvore_mercadologica( pl_nr_controle, il_cd_tabela)
	else
		luo_ge473_arvore_mercadologica.of_processa_atualizacao( il_cd_tabela )
	end if
Finally
	Destroy(luo_ge473_arvore_mercadologica)
End Try	

return true
end function

private function boolean _uf_envia_est_nf_servico (long pl_nr_controle);uo_ge481_est_nf_servico luo_ge481_est_nf_servico

if pl_nr_controle > 0 Then
	luo_ge481_est_nf_servico.of_processa_envio(pl_nr_controle)
else
	luo_ge481_est_nf_servico.of_processa_envio()
end if

return true
end function

private function boolean _uf_envia_divergencia_impostos (long pl_nr_controle);uo_ge481_envia_divergencia_impostos luo_ge481_envia_divergencia_impostos

if pl_nr_controle > 0 Then
	luo_ge481_envia_divergencia_impostos.of_processa_envio(pl_nr_controle)
else
	luo_ge481_envia_divergencia_impostos.of_processa_envio()
end if

return true
end function

private function boolean _uf_envia_nf_diversa (long pl_nr_controle);uo_ge481_nf_diversas luo_ge481_nf_diversas

if pl_nr_controle > 0 Then
	luo_ge481_nf_diversas.of_processa_envio(pl_nr_controle)
else
	luo_ge481_nf_diversas.of_processa_envio()
end if

return true
end function

public function boolean uf_limpar_tabelas ();Date		ldt_atual, ldt_dois_anos_atras
Long		ll_for, ll_nr_atualizacao, ll_nr_controle
String	ls_Erro

dc_uo_ds_base lds_lista_log_exportacao, lds_lista_interface_sap


lds_lista_log_exportacao	= Create dc_uo_ds_base
lds_lista_interface_sap	= Create dc_uo_ds_base

If Not lds_lista_log_exportacao.of_ChangeDataObject('dw_ge492_lista_log_exportacao', False) Then 
	ls_Erro = "SAP - Limpar tabelas: Erro no of_ChangeDataObject - uo_ge492_exportacao_sap.uf_limpar_tabelas()"
	gvo_aplicacao.of_grava_log( ls_Erro )
	Return False
End If

If Not lds_lista_interface_sap.of_ChangeDataObject('dw_ge492_lista_interface_sap', False) Then 
	ls_Erro = "SAP - Limpar tabelas: Erro no of_ChangeDataObject - uo_ge492_exportacao_sap.uf_limpar_tabelas()"
	gvo_aplicacao.of_grava_log( ls_Erro )
	Return False
End If

ldt_atual				= Date(gf_getserverdate())
ldt_dois_anos_atras 	= RelativeDate(ldt_atual, -730)

SetPointer(HourGlass!)

try
	Open(w_Aguarde)
			
//	w_Aguarde.Title = 'Limpando Informa$$HEX2$$e700f500$$ENDHEX$$es Legado > SAP ' + String(ldt_dois_anos_atras, 'dd/mm/yyyy')
//			
//	lds_lista_log_exportacao.Retrieve(ldt_dois_anos_atras)
//	
//	w_Aguarde.uo_Progress.of_SetMax(lds_lista_log_exportacao.RowCount())
//	
//	for ll_for = 1 to lds_lista_log_exportacao.RowCount()
//		w_Aguarde.uo_Progress.of_SetProgress(ll_for)
//		
//		ll_nr_atualizacao = lds_lista_log_exportacao.GetItemNumber(ll_for, 'nr_atualizacao')
//	
//		delete from log_exportacao_sap_historico
//				where nr_atualizacao = :ll_nr_atualizacao;
//		
//		Choose Case SQLCA.SQLCode
//			Case -1
//				ls_Erro = 'Erro ao excluir o log_exportacao_sap_historico ' + String(ll_nr_atualizacao) + '. Erro: ' + SQLCA.SQLErrText
//				SQLCA.of_rollback();
//				return False
//		End Choose
//		
//		delete from log_exportacao_sap
//				where nr_atualizacao = :ll_nr_atualizacao;
//		
//		Choose Case SQLCA.SQLCode
//			Case -1
//				ls_Erro = 'Erro ao excluir o log_exportacao_sap ' + String(ll_nr_atualizacao) + '. Erro: ' + SQLCA.SQLErrText
//				SQLCA.of_rollback();
//				return False
//		End Choose
//		
//		if mod(ll_for, 100) = 0 or ll_for = lds_lista_log_exportacao.RowCount() then
//			SQLCA.of_commit();
//		end if
//	next
	
	w_Aguarde.Title = 'Limpando Informa$$HEX2$$e700f500$$ENDHEX$$es SAP > Legado' + String(ldt_dois_anos_atras, 'dd/mm/yyyy')
			
	lds_lista_interface_sap.Retrieve(ldt_dois_anos_atras)
	
	w_Aguarde.uo_Progress.of_SetMax(lds_lista_interface_sap.RowCount())
	w_Aguarde.uo_Progress.of_SetProgress(0)
	
	for ll_for = 1 to lds_lista_interface_sap.RowCount()
		w_Aguarde.uo_Progress.of_SetProgress(ll_for)
		
		ll_nr_controle = lds_lista_interface_sap.GetItemNumber(ll_for, 'nr_controle')
	
		delete from interface_sap_item
				where nr_controle = :ll_nr_controle;
		
		Choose Case SQLCA.SQLCode
			Case -1
				ls_Erro = 'Erro ao excluir o interface_sap_item ' + String(ll_nr_controle) + '. Erro: ' + SQLCA.SQLErrText
				SQLCA.of_rollback();
				return False
		End Choose
		
		delete from interface_sap
				where nr_controle = :ll_nr_controle;
		
		Choose Case SQLCA.SQLCode
			Case -1
				ls_Erro = 'Erro ao excluir o interface_sap ' + String(ll_nr_controle) + '. Erro: ' + SQLCA.SQLErrText
				SQLCA.of_rollback();
				return False
		End Choose
		
		if mod(ll_for, 100) = 0 or ll_for = lds_lista_interface_sap.RowCount() then
			SQLCA.of_commit();
		end if
	next
finally
	Close(w_Aguarde)
	SetPointer(Arrow!)
end try

return true
end function

private function boolean _uf_est_nf_diversa (long pl_nr_controle);uo_ge481_est_nf_diversa luo_ge481_est_nf_diversa

if pl_nr_controle > 0 Then
	luo_ge481_est_nf_diversa.of_processa_envio(pl_nr_controle)
else
	luo_ge481_est_nf_diversa.of_processa_envio()
end if

return true
end function

public function boolean _uf_recebe_grupo_mercadorias (long pl_nr_controle);uo_ge473_grupo_mercadorias luo_ge473_grupo_mercadorias

Try
	luo_ge473_grupo_mercadorias = Create uo_ge473_grupo_mercadorias

	if pl_nr_controle > 0 then
		luo_ge473_grupo_mercadorias.of_atualiza_grupo_mercadorias( pl_nr_controle, il_cd_tabela)
	else
		luo_ge473_grupo_mercadorias.of_processa_atualizacao( il_cd_tabela )
	end if
Finally
	Destroy(luo_ge473_grupo_mercadorias)
End Try	

return true
end function

private function boolean _uf_titulo_receber (long pl_nr_controle);uo_ge473_titulo_receber lvo_titulo
Try
	
	lvo_titulo = Create uo_ge473_titulo_receber
	
	if pl_nr_controle > 0 Then	
		lvo_titulo.of_processa_titulo( pl_nr_controle, il_cd_tabela)
	else
		lvo_titulo.of_processa_atualizacao( )
	end if
	
Finally
	Destroy(lvo_titulo)
End Try	

return true
end function

private function boolean _uf_preco_desconto (long pl_nr_controle);uo_ge473_preco_desconto  lo_Preco_Desconto
Try
	lo_Preco_Desconto = Create uo_ge473_preco_desconto
	
	if pl_nr_controle > 0 then
		lo_Preco_Desconto.of_atualiza_preco_desconto( pl_nr_controle, il_cd_tabela )
	else
		lo_Preco_Desconto.of_processa_atualizacao()
	end if
	
Finally
	Destroy(lo_Preco_Desconto)
End Try	


return true
end function

private function boolean _uf_envia_imposto_j1btax (long pl_nr_controle);//SUBIDA

uo_ge481_wms_imposto lvo_imposto_subida

lvo_imposto_subida.of_Inicializa(il_cd_tabela, pl_nr_controle)

if pl_nr_controle > 0 Then
	lvo_imposto_subida.of_processa_envio(pl_nr_controle)
else
	lvo_imposto_subida.of_processa_envio()
end if

return true
end function

private function boolean _uf_estoque_produto (long pl_nr_controle);uo_ge481_estoque_produto luo_estoque_produto

if pl_nr_controle > 0 Then
	luo_estoque_produto.of_processa_envio(pl_nr_controle)
else
	luo_estoque_produto.of_processa_envio()
end if	

return true
end function

public function boolean _uf_subsortimento_forn (long pl_nr_controle);uo_ge473_fornecedor_divisao luo_ge473_fornecedor_divisao

Try
	luo_ge473_fornecedor_divisao = Create uo_ge473_fornecedor_divisao

	if pl_nr_controle > 0 then
		luo_ge473_fornecedor_divisao.of_atualiza_fornecedor_divisao( pl_nr_controle )
	else
		luo_ge473_fornecedor_divisao.of_processa_atualizacao(  )
	end if
Finally
	Destroy(luo_ge473_fornecedor_divisao)
End Try	

return true
end function

public function boolean _uf_recebe_meta_compras (long pl_nr_controle);uo_ge473_co_meta_compras luo_ge473_co_meta_compras

Try
	luo_ge473_co_meta_compras = Create uo_ge473_co_meta_compras

	if pl_nr_controle > 0 then
          luo_ge473_co_meta_compras.of_processa_atualizacao_meta(pl_nr_controle)
	else
	    luo_ge473_co_meta_compras.of_processa_atualizacao()
	end if
Finally
	Destroy(luo_ge473_co_meta_compras)
End Try	

Return True



end function

public function boolean uf_executar (long pl_cd_tabela, long pl_nr_controle, string ps_nr_controle, ref string ps_msg);il_cd_tabela = pl_cd_tabela



Choose Case il_cd_tabela
	Case 10 //FORNECEDOR 10, 11, 12, 15: FORNECEDOR, FORNECEDOR_CONTATO (FORNECEDOR_EMAIL, FORNECEDOR_TELEFONE), CONDICAO_PAGAMENTO
		
		this._uf_fornecedor(pl_nr_controle)
		
	Case 24 //PRECO_REGULAR
		
		this._uf_preco_regular(pl_nr_controle)
		
	Case 27 //SALDO_ESTOQUE_SAP
		
		this._uf_saldo_estoque_sap(pl_nr_controle)
		
	Case 28 //PLANEJAMENTO_ESTOQUE
		
		this._uf_planejamento_estoque(pl_nr_controle)
		
	Case 29 //REQUISICAO_MRP_SAP
		
		this._uf_requisicao_mrp_sap(pl_nr_controle)
		
	Case 31 //PRECO_TRANSFERENCIA
		
		this._uf_preco_transferencia( pl_nr_controle)
		
	Case 32 //PEDIDO_FILIAL_BLOQUEIO
		
		this._uf_pedido_filial_bloqueio(pl_nr_controle)
		
	Case 33 //RESUMO_REPOS_ESTOQUE_MIN
		
		this._uf_resumo_repos_estoque_min(pl_nr_controle)
		
	Case 34 //PROMOCAO
		
		this._uf_promocao(pl_nr_controle)
		
	Case 36 //LIBERA_PEDIDO_FILIAL_LOJA_NOVA
		
		this._uf_libera_pedido_filial_loja_nova(pl_nr_controle)
		
	Case 37 //LIBERA_PEDIDO_FILIAL_LOJA_BA	
		
		this._uf_libera_pedido_filial_loja_ba(pl_nr_controle)
		
	Case 41 //COMISSAO_PRODUTO
		
		this._uf_comissao_produto(pl_nr_controle)
		
	Case 42 //FORNECEDOR_CONEXAO
		
		this._uf_fornecedor_conexao(pl_nr_controle)
		
	Case 43	//MELHOR_CONDICAO
		
		this._uf_melhor_condicao(pl_nr_controle)
		
	Case 44	//ESTOQUE BASE / MINIMO PROMOCAO

		this._uf_est_base_min_promo(pl_nr_controle)
	
	Case 45	//PEDIDO_DISTRIBUIDORA
		
		this._uf_pedido_distribuidora(pl_nr_controle)
		
	Case 46	//PLANOGRAMA
			 
		this._uf_planograma(pl_nr_controle)
		
	Case 47 //MAXIMO_PROMOCAO
		
		this._uf_maximo_promocao( pl_nr_controle)
		
	Case 49	//DISTRIB_PRECO_DESC
			
		this._uf_distrib_precos_desc(pl_nr_controle)
			
	Case 50	//HISTORICO_MRP_LEGADO
		
		this._uf_historico_mrp(pl_nr_controle)
		
	Case 51	//ESTOQUE_BASE_RECALCULO
		
		this._uf_recalculo_est_base(pl_nr_controle)
	
	Case 53	//CUSTO_PRODUTO
		
		this._uf_custo_produto(pl_nr_controle)
		
	Case 54	//PRODUTO PBM
		
		this._uf_pbm_produto( pl_nr_controle )
	Case 55 //ENVIO REGISTRO INFO COMPRAS
		this._uf_registro_info( pl_nr_controle )
		
	Case 57	//REGISTRO_INFO_COMPRAS
		this.uf_recebe_registro_info(pl_nr_controle)
		
	Case 58 //VIGENCIA_ESTOQUE
		
		this._uf_vigencia_estoque(pl_nr_controle)
 
	Case 59 //CAMPANHA
		
		this._uf_campanha(pl_nr_controle)
 
	Case 62 //PRECO_FORNECEDOR
		
		this._uf_preco_fornecedor(pl_nr_controle)
	
	Case 64 //MELHOR_CONDICAO_VENDA
		
		this._uf_melhor_condicao_venda( pl_nr_controle )
	
	Case 65 //PEDIDO_DISTRIBUIDORA_RETORNO
		
		this._uf_pedido_distribuidora_retorno( pl_nr_controle )
 
	Case 67 //LISTA_TECNICA_PRD
 
 		this._uf_lista_tecnica_prd( pl_nr_controle )
 
 	Case 68 //LISTA_TECNICA_PRD_AGRUP
 
 		this._uf_lista_tecnica_prd_agrup( pl_nr_controle )
 
	Case 69 //REMANEJAMENTO
		
		this._uf_remanejamento( pl_nr_controle )
 
	Case 71 //PEDIDO_DISTRIBUIDORA_CANCELAMENTO
		
		this._uf_pedido_distribuidora_cancelamento( pl_nr_controle )
 
	Case 72 //PEDIDO_ALTERACAO_SAP
 
 		this._uf_pedido_alteracao_sap( pl_nr_controle )
 
	Case 73 //NOTA_FISCAL
 
 		this._uf_nota_fiscal( pl_nr_controle )
		 		 
	Case 77	//DISTRIB_SALDO
			
		this._uf_distrib_saldo(pl_nr_controle)
 
	Case 78 //CONTABIL
		
		this._uf_contabil( pl_nr_controle )
 
	Case 80 //CAMPANHA_C4
		
		this._uf_campanha_c4( pl_nr_controle )
 
	Case 86 //CLIENTE - EXCLUSAO
		
		this._uf_clientes_excluidos( pl_nr_controle )
		
	Case 87
		
		this._uf_envia_confirma_qtde_recebida_nf( pl_nr_controle )

	Case 92		
		this._uf_pedido_central( pl_nr_controle )	
		
	Case 95
		this._uf_envia_divergencia_nfd( pl_nr_controle)		
		
	Case 96
		this._uf_distrib_f5( pl_nr_controle)
		
	Case 97
		this._uf_notas_fiscais( pl_nr_controle )
	
	Case 98
		this._uf_envio_ordem_venda(pl_nr_controle)
		
	Case 99
		this._uf_recebimento_nota_fiscal( pl_nr_controle)
	
	Case 101
		this._uf_recebimento_confirmacao_migo_miro(pl_nr_controle)
		
	Case 102
		this._uf_envia_movimento_estoque( pl_nr_controle)
		
	Case 103
		this._uf_envia_movimento_estoque_estorno( pl_nr_controle)

	Case 104
		this._uf_movimento_estoque_confirmacao( pl_nr_controle)
	
	Case 105
		this._uf_envia_cancelamento_nfd( pl_nr_controle)

	Case 106 //Estorno do recebimento
  		this._uf_estorno_recebimento( pl_nr_controle )
		  
	Case 107 
  		this._uf_envia_ordem_venda_estorno( pl_nr_controle )
		  
	Case 109 
  		this._uf_envia_recebimento_compra_loja( pl_nr_controle )
		  
	 Case 110 
  		this._uf_envia_confere_estoque( pl_nr_controle )
		  
	Case 111
  		this._uf_envia_verba_pescador( pl_nr_controle )
		  
	Case 112
  		this._uf_envia_devolucao_coleta( pl_nr_controle )
		  
	Case 113, 114, 115, 116, 117, 118
		this._uf_envia_imposto( pl_nr_controle )
		
	Case 119
		this._uf_envia_retira_venda_promocao(pl_nr_controle)

	Case 120, 124, 126
		this._uf_envia_loja_nf_transferencia(pl_nr_controle)
		
	Case 121
		this._uf_envia_loja_nf_inventario(pl_nr_controle)
	
	Case 122
		this._uf_envia_loja_nf_inventario_est(pl_nr_controle)
		
	Case 123
		this._uf_recebe_estorno_nf_compra(pl_nr_controle)
		
	Case 125, 127, 128 //Confirma$$HEX2$$e700e300$$ENDHEX$$o de transfer$$HEX1$$ea00$$ENDHEX$$ncia/Cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia/Cancelamento de Devolu$$HEX2$$e700e300$$ENDHEX$$o
		this._uf_confirma_rec_nf_trans(pl_nr_controle)
		
	Case 129
		this._uf_recebe_retirada_excesso_estoque(pl_nr_controle)
		
	Case 131
		this._uf_envia_nf_servico(pl_nr_controle)

	Case 146
		this._uf_recebe_arvore_mercadologica(pl_nr_controle)

	Case 133
		this._uf_envia_est_nf_servico(pl_nr_controle)

	Case 134
		this._uf_envia_divergencia_impostos(pl_nr_controle)
	
	Case 135
		this._uf_envia_nf_diversa(pl_nr_controle)
		
	Case 136
		this._uf_est_nf_diversa(pl_nr_controle)
		
	Case 137
		this._uf_recebe_grupo_mercadorias(pl_nr_controle)
		
	Case 138
		this._uf_titulo_receber(pl_nr_controle)
		
	Case 140, 141, 142, 143, 144, 145
		this._uf_envia_imposto_j1btax(pl_nr_controle)
		
	Case 147
		this._uf_preco_desconto(pl_nr_controle)
		
	Case 148	//ESTOQUE_PRODUTO
		
		this._uf_estoque_produto (pl_nr_controle)
		
	Case 149 //149,150 SUBSORTIMENTO/DIVISAO_FORNECEDOR E PRODUTOS
		
		this._uf_subsortimento_forn (pl_nr_controle)
	
	Case 151  // META DE COMPRAS		
		this._uf_recebe_meta_compras (pl_nr_controle)
		
	Case 153 //Estoque Base M$$HEX1$$ed00$$ENDHEX$$nimo de Promo$$HEX2$$e700e300$$ENDHEX$$o
		
		this._uf_est_base_minimo_promocao_sap(ps_nr_controle)

	Case 154 //Estoque Base Principal
		
		this._uf_est_base_principal_sap(ps_nr_controle)
		
	Case 155  //Estoque Base M$$HEX1$$ed00$$ENDHEX$$nimo de Planograma
		
		this._uf_est_base_minimo_plan_sap(ps_nr_controle)
		
	Case 156 //Mov Estoque Novo
		
		this._uf_mov_estoque(ps_nr_controle)
		
	Case 157 //T$$HEX1$$ed00$$ENDHEX$$tulo SAP (interface com campos SAP)
		this._uf_titulo_sap(pl_nr_controle)
		
	Case 159 //Estoque base resumo das filiais
		this._uf_estoque_base_resumo_filial(ps_nr_controle)
	
	Case 160 //Preco Profimetrics
		this._uf_preco_regular_profimetrics( pl_nr_controle )
		
	Case 161 //Preco PMC
		this._uf_preco_pmc( pl_nr_controle )
	
	Case 163 //produto grupo extra
		this._uf_recebe_produto_grupo_extra (pl_nr_controle)
	
	Case Else
		ps_msg = 'Tabela n$$HEX1$$e300$$ENDHEX$$o prevista no processo de integra$$HEX2$$e700e300$$ENDHEX$$o SAP [' + string(il_cd_tabela) + '].'
		Return False
End Choose


return true
end function

private function boolean _uf_est_base_minimo_promocao_sap (string ps_nr_controle);uo_ge481_estoque_base_min_promo_sap lo_uo_ge481_estoque_base_min_promo_sap

Try
	lo_uo_ge481_estoque_base_min_promo_sap = Create uo_ge481_estoque_base_min_promo_sap
	
	if Trim(ps_nr_controle) <> '' and not IsNull(ps_nr_controle) Then
		lo_uo_ge481_estoque_base_min_promo_sap.of_processa_envio( ps_nr_controle )
	else
		lo_uo_ge481_estoque_base_min_promo_sap.of_processa_envio( )
	end if
Finally
	Destroy(lo_uo_ge481_estoque_base_min_promo_sap)
End Try
	
return true
end function

private function boolean _uf_est_base_principal_sap (string ps_nr_controle);uo_ge481_estoque_base_prin_sap lo_uo_ge481_estoque_base_prin_sap

Try
	lo_uo_ge481_estoque_base_prin_sap = Create uo_ge481_estoque_base_prin_sap
	
	if Trim(ps_nr_controle) <> '' and not IsNull(ps_nr_controle) Then
		lo_uo_ge481_estoque_base_prin_sap.of_processa_envio( ps_nr_controle )
	else
		lo_uo_ge481_estoque_base_prin_sap.of_processa_envio( )
	end if
Finally
	Destroy(lo_uo_ge481_estoque_base_prin_sap)
End Try
	
return true
end function

private function boolean _uf_est_base_minimo_plan_sap (string ps_nr_controle);uo_ge481_estoque_base_min_plan_sap lo_uo_ge481_estoque_base_min_plan_sap

Try
	lo_uo_ge481_estoque_base_min_plan_sap = Create uo_ge481_estoque_base_min_plan_sap
	
	if Trim(ps_nr_controle) <> '' and not IsNull(ps_nr_controle) Then
		lo_uo_ge481_estoque_base_min_plan_sap.of_processa_envio( ps_nr_controle )
	else
		lo_uo_ge481_estoque_base_min_plan_sap.of_processa_envio( )
	end if
Finally
	Destroy(lo_uo_ge481_estoque_base_min_plan_sap)
End Try
	
return true
end function

public function boolean _uf_mov_estoque (string ps_nr_controle);uo_ge481_wms_mov_estoque lo_uo_ge481_wms_mov_estoque

Try
	lo_uo_ge481_wms_mov_estoque = Create uo_ge481_wms_mov_estoque
	
	if Trim(ps_nr_controle) <> '' and not IsNull(ps_nr_controle) Then
		lo_uo_ge481_wms_mov_estoque.of_processa_envio( ps_nr_controle )
	else
		lo_uo_ge481_wms_mov_estoque.of_processa_envio( )
	end if
Finally
	Destroy(lo_uo_ge481_wms_mov_estoque)
End Try
	
return true
end function

public function boolean _uf_titulo_sap (long pl_nr_controle);uo_ge473_titulo_sap lvo_titulo
Try
	
	lvo_titulo = Create uo_ge473_titulo_sap
	
	if pl_nr_controle > 0 Then	
		lvo_titulo.of_processa_titulo( pl_nr_controle, il_cd_tabela)
	else
		lvo_titulo.of_processa_atualizacao( )
	end if
	
Finally
	Destroy(lvo_titulo)
End Try	

return true
end function

public function boolean _uf_estoque_base_resumo_filial (string ps_nr_controle);uo_ge481_estoque_base_resumo_filial luo_ge481_estoque_base_resumo_filial

Try
	luo_ge481_estoque_base_resumo_filial = Create uo_ge481_estoque_base_resumo_filial
	
	if Trim(ps_nr_controle) <> '' and not IsNull(ps_nr_controle) Then
		luo_ge481_estoque_base_resumo_filial.of_processa_envio( ps_nr_controle )
	else
		luo_ge481_estoque_base_resumo_filial.of_processa_envio( )
	end if
Finally
	Destroy(luo_ge481_estoque_base_resumo_filial)
End Try
	
return true
end function

private function boolean _uf_fornecedor (long pl_nr_controle);uo_ge473_fornecedor luo_ge473_fornecedor

Try
	luo_ge473_fornecedor = Create uo_ge473_fornecedor

	If pl_nr_controle > 0 then
		luo_ge473_fornecedor.of_atualiza_fornecedor( pl_nr_controle, il_cd_tabela )
	Else
		luo_ge473_fornecedor.of_processa_atualizacao( il_cd_tabela )
	End if
Finally
	Destroy(luo_ge473_fornecedor)
End Try	

Return true
end function

private function boolean _uf_preco_pmc (long pl_nr_controle);uo_ge473_preco_pmc lo_preco_pmc
Try
	lo_preco_pmc = Create uo_ge473_preco_pmc
	
	if pl_nr_controle > 0 then
		lo_preco_pmc.of_atualiza_preco_pmc( pl_nr_controle, il_cd_tabela )
	else
		lo_preco_pmc.of_processa_atualizacao()
	end if
	
Finally
	Destroy(lo_preco_pmc)
End Try	


return true
end function

private function boolean _uf_preco_regular_profimetrics (long pl_nr_controle);uo_ge473_preco_profimetrics lo_preco_prof
Try
	lo_preco_prof = Create uo_ge473_preco_profimetrics
	
	if pl_nr_controle > 0 then
		lo_preco_prof.of_atualiza_preco_profimetrics( pl_nr_controle, il_cd_tabela )
	else
		lo_preco_prof.of_processa_atualizacao()
	end if
	
Finally
	Destroy(lo_preco_prof)
End Try	


return true
end function

public function boolean _uf_recebe_produto_grupo_extra (long pl_nr_controle);uo_ge473_produto_grupo_extra	luo_ge473_produto_grupo_extra

Try
	luo_ge473_produto_grupo_extra = Create uo_ge473_produto_grupo_extra
	
	If pl_nr_controle > 0 then
		luo_ge473_produto_grupo_extra.of_atualiza_produto_grupo_extra (pl_nr_controle, il_cd_tabela)
	else
		luo_ge473_produto_grupo_extra.of_processa_atualizacao (il_cd_tabela)
	End if
	
Finally
	Destroy luo_ge473_produto_grupo_extra
	
End try

Return True
end function

on uo_ge492_exportacao_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge492_exportacao_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

