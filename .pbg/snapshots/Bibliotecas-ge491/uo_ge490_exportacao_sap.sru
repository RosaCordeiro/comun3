HA$PBExportHeader$uo_ge490_exportacao_sap.sru
forward
global type uo_ge490_exportacao_sap from nonvisualobject
end type
end forward

global type uo_ge490_exportacao_sap from nonvisualobject
end type
global uo_ge490_exportacao_sap uo_ge490_exportacao_sap

forward prototypes
public function boolean uf_exportar (long pl_cd_tabela, ref string ps_msg)
private function boolean _uf_distrib_precos_desc (long pl_nr_atualizacao)
private function boolean _uf_melhor_condicao (long pl_nr_atualizacao)
private function boolean _uf_grava_log (string ps_tipo, long pl_cd_tabela)
private function boolean _uf_vigencia_estoque (long pl_nr_controle)
public function boolean uf_exportar (long pl_cd_tabela, long pl_nr_controle, ref string ps_msg)
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
end prototypes

public function boolean uf_exportar (long pl_cd_tabela, ref string ps_msg);return uf_exportar(pl_cd_tabela, 0, ref ps_msg)
end function

private function boolean _uf_distrib_precos_desc (long pl_nr_atualizacao);uo_ge481_distrib_preco_desc uo

if pl_nr_atualizacao > 0 Then
	uo.of_processa_envio(pl_nr_atualizacao)
else
	uo.of_processa_envio()
end if

return True
end function

private function boolean _uf_melhor_condicao (long pl_nr_atualizacao);uo_ge481_is_melhor_compra uo

Try
	uo = Create uo_ge481_is_melhor_compra
	uo.of_processa_envio()
	
Finally

	Destroy(uo)
End Try	

return true
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
		lvo_vigencia.of_atualiza_vigencia_promocao( pl_nr_controle, 58)
	else
		lvo_vigencia.of_processa_atualizacao( )
	end if
	
Finally
	Destroy(lvo_vigencia)
End Try	

return true
end function

public function boolean uf_exportar (long pl_cd_tabela, long pl_nr_controle, ref string ps_msg);Choose Case pl_cd_tabela
		
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
		
	Case 57	//REGISTRO_INFO_COMPRAS
			
		this._uf_registro_info( pl_nr_controle )
 
	Case 58 //VIGENCIA_ESTOQUE
		
		this._uf_vigencia_estoque(pl_nr_controle)
 
	Case 59 //CAMPANHA
		
		this._uf_campanha(pl_nr_controle)
 
	Case 62 //PRECO_FORNECEDOR
		
		this._uf_preco_fornecedor(pl_nr_controle)
		
	Case 65 //PEDIDO_DISTRIBUIDORA_RETORNO
		
		this._uf_pedido_distribuidora_retorno( pl_nr_controle )
 
	Case Else
		ps_msg = 'Tabela n$$HEX1$$e300$$ENDHEX$$o prevista para exporta$$HEX2$$e700e300$$ENDHEX$$o.'
		Return False
		
End Choose


return true
end function

private function boolean _uf_campanha (long pl_nr_controle);uo_ge473_campanha_sap lvo_campanha
Try
	
	lvo_campanha = Create uo_ge473_campanha_sap
	
	if pl_nr_controle > 0 Then	
		lvo_campanha.of_atualiza_campanha( pl_nr_controle, 59)
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
		lo_preco_forn.of_atualiza_preco_fornecedor( pl_nr_controle, 62)
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
		lo_pedido_liberacao_loja_ba.of_atualiza_pedido_liberacao_loja_ba( pl_nr_controle, 37)
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
		lo_Sap_EstBase_Min.of_processa_envio_est_base_min_pro()
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
		lo_comissao_produto.of_atualiza_comissao( pl_nr_controle,  41)
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
		lvo_Fornecedor_Conexao.of_executa_fornecedor_conexao( pl_nr_controle,  42)
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
		lo_pedido_liberacao_loja_nova.of_atualiza_pedido_liberacao_loja_nova( pl_nr_controle, 36)
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
		lo_Pedido_Filial_Bloqueio_SAP.of_atualiza_pedido_filial_bloqueio( pl_nr_controle, 32 )
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
		lo_planejamento_estoque_sap.of_atualiza_planejamento_estoque_sap( pl_nr_controle, 28)
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
		lo_preco_regular.of_atualiza_preco_regular( pl_nr_controle, 24 )
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
		lo_preco_transferencia.of_atualiza_preco_transferencia( pl_nr_controle, 31)
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
		lvo_promocao_sap.of_atualiza_promocao( pl_nr_controle, 34)
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
		lvo_re.of_atualiza_resumo_repos_est_sos_est_min( pl_nr_controle, 33)
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
		lvo_saldo_estoque_sap.of_atualiza_saldo_estoque_sap( pl_nr_controle,  27)
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

on uo_ge490_exportacao_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge490_exportacao_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

