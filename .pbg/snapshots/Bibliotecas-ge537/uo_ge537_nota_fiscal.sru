HA$PBExportHeader$uo_ge537_nota_fiscal.sru
forward
global type uo_ge537_nota_fiscal from nonvisualobject
end type
end forward

global type uo_ge537_nota_fiscal from nonvisualobject
end type
global uo_ge537_nota_fiscal uo_ge537_nota_fiscal

type variables
Boolean	ib_sucesso = false, ib_processo_paralelo = False, ib_desenvolvimento = True
DateTime idh_emissao, idh_movimentacao_caixa, idh_recebido_sap, idh_envio
Dec{2}	idc_vl_total_nf, idc_total_desp
Dec{3}	idc_qt_peso_liquido, idc_qt_peso_bruto

Long	il_docnum, il_linha_nf, il_nr_sequencial, il_nr_nf, il_cd_filial, il_qt_volume, il_nr_integracao, il_nr_pedido_distribuidora, il_cd_filial_destino, &
		il_nr_ano_documento_sap, il_nr_nota_chave_acesso, il_nr_nf_origem, il_docnum_ref, il_nr_pedido_distribuidora_original, il_cd_parceiro
Long 	il_Nat_OPeracao
Long 	il_Agrup_Dev_Compra
Long 	il_Motivo_Dev
Long 	il_inventario
Long 	il_nr_transferencia
						
String 	is_mandt, is_de_serie, is_de_especie, is_id_situacao, is_cd_fornecedor, is_id_tipo_nf, is_nr_chave_acesso, &
			is_de_especie_volume, is_nr_documento_sap, is_nr_cgc, is_cd_fornecedor_sap, is_cd_filial_sap, &
			is_de_serie_origem, is_de_especie_origem, is_nr_pedido_distribuidora, is_chave_interface, is_cd_cliente, &
			is_nr_pedido, is_chave_movimento_wms, is_categoria_nf_origem, is_id_estornado, is_tipo_doc_dca, is_doc_finalidade, &
			is_nr_cgc_dest, is_de_nome_dest, is_nr_ie_dest, is_cd_parceiro_sap

String is_Nat_Operacao
String is_Nm_Fantasia
String is_CGC
String is_Endereco
String is_NR_Endereco
String is_IE
String is_Bairro
String il_Cidade
String is_CEP
String is_Fone
String is_cidade
String is_UF
String is_Chave_NF_Origem
String is_nr_protocolo_envio
String is_cd_status_nfe /* j_1bnfdoc_1.code */


String is_Endereco_Avaria
String is_Endereco_Falta
String is_Endereco_Vencido
String is_Endereco_Outros
String is_Endereco_Outros_Agr
String is_Endereco_Defeito_Fabrica
String is_Endereco_Acordo_Comercial
String is_Endereco_Prestes_AVencer
String is_Endereco_Validade_ForaAcordo
String is_Endereco_Receb_Fracionado
String is_Endereco_Receb_Caixa_ForaPadrao  
String is_Endereco_Seg_Nf_Reentrada
String is_Endereco_Seg_Nf_Tranf_Canc
String is_Endereco_Segregado_Vencido_Danificado //CD_ENDERECO_SEGREGADO_VENCIDO_DANIFICADO
String is_Endereco_Excursao_Temperatura


PRIVATE LONG IL_TP_MOVTO_CANC_TRANSF_ENTRADA	= 4
PRIVATE LONG IL_CD_MOTIVO_AJUSTE_AUT_COMPRAS = 42
PRIVATE LONG IL_QT_CAIXA_PADRAO_SEGREGADO = 1
PRIVATE STRING IS_NR_MATRICULA_INTEG_AUT = '14330'
PRIVATE STRING IS_CD_TIPO_MOV_RESOLV_DESCARTE = 'J'

dc_uo_ds_base	idc_uo_ds_base_nota, idc_uo_ds_base_item, idc_uo_ds_base_item_imp, idc_uo_ds_base_item_lote, idc_melhor_compra, idc_valida_nf_transf
uo_ge473_comum	iuo_ge473_comum

uo_parametro_geral	ivo_parametro
uo_filial				ivo_filial

dc_uo_ds_base  ivds_itens
dc_uo_ds_base  ivds_lotes_dev // wms_int_sap_detalhe retrieve por nr_integracao e cd_produto



end variables

forward prototypes
public function boolean of_processa_doc (ref string ps_log)
public function boolean of_insere_nf_devolucao_compra_produto (ref string ps_log)
public function boolean of_insere_nf_devolucao_compra (ref string ps_log)
public function boolean of_insere_nf_devolucao_compra_nfe (ref string ps_log)
public function boolean of_atualiza_situacao (string ps_situacao, string ps_msg, ref boolean pb_pendente, ref string ps_log)
public subroutine of_envia_email (string as_erro, long al_docnum)
public function boolean of_grava_nf_devolucao_compra (ref string ps_log)
public function boolean of_grava_nf_transferencia (ref string ps_log)
public function boolean of_insere_nf_transferencia (ref string ps_log)
public function boolean of_insere_nf_transferencia_nfe (ref string ps_log)
public function boolean of_insere_nf_transferencia_produto (ref string ps_log)
public function boolean of_insere_nf_diversa (ref string ps_log)
public function boolean of_insere_nf_diversa_produto (ref string ps_log)
public function boolean of_insere_nf_diversa_nfe (ref string ps_log)
public function boolean of_grava_nf_diversa (ref string ps_log)
public function boolean of_insere_nf_diversa_reentrada (ref string ps_log)
public function boolean of_insere_nf_diversa_produto_reentrada (ref string ps_log)
public function boolean of_grava_nf_diversa_reentrada (ref string ps_log)
public function boolean of_valida_tipo_nf_saida (string ps_id_tipo_operacao, ref string ps_log)
public function boolean of_grava_nf_venda (ref string ps_log)
public function boolean of_insere_nf_venda (ref string ps_log)
public function boolean of_insere_nf_venda_produto (ref string ps_log)
public function boolean of_insere_nf_venda_nfe (ref string ps_log)
public function boolean of_processa_atualizacao (long pl_docnum)
public function boolean of_cancela_documento (ref string ps_log)
public function boolean of_localiza_chave_integracao (ref string ps_log)
public function boolean of_localiza_nat_operacao (long pl_linha, string ps_log)
public function boolean of_localiza_agrupamento (ref string ps_log)
public function boolean of_localiza_identificacao_nf_diversa (ref string ps_log)
public function boolean of_grava_melhor_compra_distribuidora (ref string ps_log, long al_cd_produto, long al_cd_natureza_operacao)
public function boolean of_gera_coleta_pendente (long al_agrupamento, string as_erro)
public function boolean of_verifica_nr_pedido_original_reenviado (ref string as_nr_pedido_distribuidora)
public function boolean of_buscar_nsu (ref long al_nsu, ref string as_log)
public function boolean of_busca_docnum_xped_repetido (ref string as_log)
public function boolean of_insere_nf_transferencia_produto_lote (ref string ps_log, long al_cd_natureza_operacao, long al_cd_produto, long al_qt_transferida)
public function boolean of_verifica_insere_wms_romaneio (ref string ps_log)
public function boolean of_valida_insere_lotes_dev (long pl_cd_filial, long pl_nr_nf, string ps_de_especie, string ps_de_serie, long pl_nr_item, long pl_cd_produto, long pl_qt_devolvida, ref string ps_log)
public function boolean of_busca_endereco_cancelamento (ref string ps_log)
public function boolean of_retorna_saldo_wms (long pl_produto, ref long pl_nr_nf, string ps_de_especie, string ps_de_serie, long pl_cd_filial_origem, long pl_cd_item, ref string ps_log)
public function boolean of_busca_centro_custo_almoxarifado (long al_nr_pedido_distribuidora, ref long al_cd_centro_custo, ref string as_log)
public function boolean of_ajuste_definitivo_estoque (ref string ps_log)
public function boolean of_grava_nfe_inutilizacao (ref string ps_log)
public function boolean of_determina_cd_tipo_documento (ref string ps_cd_tipo_documento, ref string ps_log)
public function boolean of_retira_saldo_wms (string ps_categoria_origem, ref string ps_log)
public function boolean of_retorna_saldo_wms (string ps_categoria_origem, ref long pl_nr_nf, string ps_de_especie, string ps_de_serie, long pl_cd_filial_origem, ref string ps_log)
public function boolean of_busca_endereco_motivo_dev (long al_cd_motivo_devolucao, long al_nr_agrupamento_dev_compra, ref string as_endereco, ref string as_log)
public function boolean of_localiza_nf_origem (string ps_categoria_reentrada, ref string ps_log)
public function boolean of_movimenta_estoque_loja (long pl_cd_produto, long pl_qt_movto, long pl_cd_filial_movimento, long pl_cd_filial_origem, long pl_nr_nf, string pl_de_especie, string pl_de_serie, decimal pdc_custo_transf, ref string ps_log)
public function boolean of_grava_ajuste_estoque_wms (long al_produto, string as_endereco, string as_lote, datetime adt_validade, long al_qtde_movimento, string as_entrada_saida, string amotivo, long al_nr_agrupamento, long al_motivo_ajuste, string as_nr_matricula_responsavel, long al_caixa_padrao, ref string ps_log)
public function boolean of_movimenta_estoque_descarte (long al_cd_filial, long al_nr_agrupamento, long al_cd_motivo_ajuste, long al_cd_produto, string as_nr_lote, date ad_dt_validade, long al_qt_lote, long al_nr_nf, string as_de_especie, string as_de_serie, string as_nr_matricula_responsavel, string as_tipo_movimento, ref string as_log)
public function boolean of_movimenta_estoque (ref long al_nr_nf, string as_de_especie, string as_de_serie, long al_cd_filial_origem, long al_cd_item, long al_cd_motivo_ajuste, string as_nr_matricula_responsavel, ref string as_log)
public function boolean of_busca_endereco_expedicao_transf (long al_cd_filial, ref string as_end_exped_transf, ref string as_log)
public function boolean of_busca_endereco_receb_transf (long al_cd_filial, ref string as_end_receb_transf, ref string as_log)
public function boolean of_cancela_transferencia_estoque (ref string ps_log)
public function boolean wf_movimenta_est_transf_cds (long al_cd_filial_origem, long al_cd_filial_destino, string as_log)
public function boolean wf_movimenta_canc_est_transf_cds (long al_cd_filial_origem, long al_cd_filial_destino, long al_cd_produto, string as_nr_lote, datetime adt_dh_validade, long al_qt_lote, ref string as_log, long al_qt_caixa_padrao)
public function boolean wf_atualiza_transf_cds (long al_cd_filial_origem, long al_cd_filial_destino, boolean ab_cancelamento, string as_log)
end prototypes

public function boolean of_processa_doc (ref string ps_log);Boolean 	lb_registro_pendente
String	ls_id_tipo_operacao

// PONTOS DE VERIFICA$$HEX2$$c700c300$$ENDHEX$$O
// cancelamento  ou estorno
// come$$HEX1$$e700$$ENDHEX$$ar a pegar somente depois que iniciar a opera$$HEX2$$e700e300$$ENDHEX$$o no SAP


try
	SetNull(il_nr_integracao)
	
	is_id_tipo_nf =  iif(isNull(is_id_tipo_nf), 'XX', is_id_tipo_nf)
	
	// Quando j_1bnfdoc_1.code for 102, deve apenas inserir a inutiliza$$HEX2$$e700e300$$ENDHEX$$o e n$$HEX1$$e300$$ENDHEX$$o precisa fazer o processamento normal.
	If is_cd_status_nfe = '102' or &
		(is_id_estornado = 'X' and (IsNull(il_nr_nota_chave_acesso) or il_nr_nota_chave_acesso = 0)) Then
		
		if not iuo_ge473_comum.of_localiza_codigo_filial_legado(is_cd_filial_sap, ref il_cd_filial, ref ps_log) then
			ps_log = 'Objeto: ' + this.ClassName( ) + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_doc' + '~nN$$HEX1$$e300$$ENDHEX$$o encontrado o c$$HEX1$$f300$$ENDHEX$$digo da filial ' + idc_uo_ds_base_nota.DataObject + '.'
			return false
		end if
		
		this.of_grava_nfe_inutilizacao(ref ps_log)
		Return ib_sucesso
	End If
	
	If gvo_Aplicacao.ivs_DataSource = 'central' then
		if IsNull(il_nr_nota_chave_acesso) then
			ps_log = 'Objeto: ' + this.ClassName( ) + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_doc' + '~nChave de acesso n$$HEX1$$e300$$ENDHEX$$o enviada pelo SAP ' + idc_uo_ds_base_nota.DataObject + '.'
			return false
		end if
		
		if not (is_id_estornado = 'X' and (is_id_tipo_nf = 'ZA' or is_id_tipo_nf = 'YC'  or is_id_tipo_nf = 'YB' or is_id_tipo_nf = 'YP')) then
			if il_nr_nota_chave_acesso <> il_nr_nf and is_id_tipo_nf <> 'ZF' and is_id_tipo_nf <> 'Z2' and is_id_tipo_nf <> 'YH' then
				ps_log = 'Objeto: ' + this.ClassName( ) + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_doc' + '~nChave de acesso n$$HEX1$$e300$$ENDHEX$$o confere com o n$$HEX1$$fa00$$ENDHEX$$mero de nota enviada pelo SAP ' + idc_uo_ds_base_nota.DataObject + '.'
				return false
			end if
		end if
	End If
	
	If IsNull(il_nr_nf) or il_nr_nf = 0 Then
		ps_log = 'Objeto: ' + this.ClassName( ) + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_doc' + '~nN$$HEX1$$fa00$$ENDHEX$$mero da nota veio nulo ou zerado.'
		return false
	End If
	
	if not iuo_ge473_comum.of_localiza_codigo_filial_legado(is_cd_filial_sap, ref il_cd_filial, ref ps_log) then
		ps_log = 'Objeto: ' + this.ClassName( ) + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_doc' + '~nN$$HEX1$$e300$$ENDHEX$$o encontrado o c$$HEX1$$f300$$ENDHEX$$digo da filial ' + idc_uo_ds_base_nota.DataObject + '.'
		return false
	end if
		
	if is_id_situacao = '1' then
		is_id_situacao	= 'A'
	else
		ps_log = 'Objeto: ' + this.ClassName( ) + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_doc' + '~nNota Fiscal pendente de processamento no SAP ' + idc_uo_ds_base_nota.DataObject + '.'
		return false
	end if
	
	// Foi criada a tabela CATEGORIA_NF_SAP
	// A1/YB/YY => DEVOLUCAO COMPRA
	// ZA/YC => TRANSFERENCIA
	// ZV 	=> VENDA/LICITA$$HEX2$$c700c300$$ENDHEX$$O
	// ZS/Z4	=> SUCATA
	// YA/ZT => COMPRAS
	// ZF 	=> CANCELAMENTO SAIDA
	// Z2 	=> CANCELAMENTO ENTRADA
	// YH		=> CANCELAMENTO INV ENTRADA
		
	choose case is_id_tipo_nf
		case 'A1', 'YB', 'YP', 'YY'
			this.of_grava_nf_devolucao_compra(ps_log)
		case 'ZA', 'YC'
			this.of_grava_nf_transferencia(ps_log)
		case 'ZV'
			this.of_grava_nf_venda(ps_log)
		case 'Z6', 'ZI', 'ZS', 'ZJ', 'YU', 'Z4', 'SM', 'SC', 'RC', 'S5', 'CM'
			this.of_grava_nf_diversa(ps_log)
		case 'YA', 'ZM', 'LE'
			this.of_grava_nf_diversa_reentrada(ps_log)
		case 'ZF', 'Z2', 'YH' /* Tipo 'LE - Cancelamento Extempor$$HEX1$$e200$$ENDHEX$$neo' n$$HEX1$$e300$$ENDHEX$$o deve cancelar a outra nota, deve lan$$HEX1$$e700$$ENDHEX$$ar a nova nota no banco, ser$$HEX1$$e100$$ENDHEX$$ implementado p/ inserir nf_diversa */
			this.of_cancela_documento(ps_log)
		case else
			//lb_sucesso	= this.of_grava_compra
			ps_log =  "Fun$$HEX2$$e700e300$$ENDHEX$$o [of_processar_doc]. Erro: categoria de NF n$$HEX1$$e300$$ENDHEX$$o prevista '"  + is_id_tipo_nf +  "'"
			return false
	end choose
	
	return ib_sucesso
catch ( runtimeerror  lo_rte )
	ps_log =  "Fun$$HEX2$$e700e300$$ENDHEX$$o [of_processar_doc]. Erro: "+lo_rte.GetMessage( )
	
	return false
finally
	if ib_sucesso then
		if not this.of_atualiza_situacao('P','',ref lb_registro_pendente, ref ps_log) then return false
		
		sqlca.of_commit( )
	else
		sqlca.of_rollback( )
		
		//Atualizo a situa$$HEX2$$e700e300$$ENDHEX$$o do doc para processado se ele ainda estiver pendente.
		if not this.of_atualiza_situacao('E', ps_log, ref lb_registro_pendente, ref ps_log ) then return false
		
		sqlca.of_commit( )
		
		this.of_envia_email(ps_log, il_docnum)
	end if
	
	ib_sucesso = false
end try

return true
end function

public function boolean of_insere_nf_devolucao_compra_produto (ref string ps_log);Boolean	lb_atualizou_compra	= false
Dec{2}	ldc_qt_devolvida, ldc_vl_desconto, ldc_vl_frete, &
			ldc_vl_bc_icms, ldc_pc_icms, ldc_vl_icms, ldc_vl_bc_icms_st, ldc_pc_icms_st, ldc_vl_icms_st, &
			ldc_total_vl_bc_icms, ldc_total_vl_icms, ldc_total_vl_frete, ldc_total_vl_desconto, ldc_vl_bc_pis, &
			ldc_pc_pis, ldc_vl_pis, ldc_vl_bc_cofins, ldc_pc_cofins, ldc_vl_cofins, ldc_vl_bc_ipi, &
			ldc_pc_ipi, ldc_vl_ipi, ldc_total_vl_ipi, ldc_vl_total_item, ldc_vl_total_itens, &
			ldc_vl_bc_st, ldc_pc_st, ldc_vl_st, ldc_vl_bc_othbas, ldc_vl_st_array[], &
			ldc_array_null[], ldc_diferenca, ldc_OutDesp, ldc_OutDesp_Tot_Item, ldc_valor_total_liquido_sem_impostos, &
			ldc_valor_total_bruto_sem_impostos, ldc_valor_total_liquido_sem_impostos_sem_desp, ldc_vl_desconto_sem_desconto
Dec{4}	ldc_vl_preco_unitario_origem, ldc_vl_preco_unitario_aux, ldc_valor_total_liquido_com_impostos
Dec{6}	ldc_vl_preco_unitario
Dec{8}	ldc_pc_desconto, ldc_vl_total_item_bruto_com_impostos, ldc_OutDesp_com_imposto, &
			ldc_valor_t
Long 		ll_for, ll_total_itens, ll_cd_produto, ll_nr_item, ll_total_itens_imp, ll_cd_natureza_operacao, &
			ll_nr_item_legado, ll_for_imp, ll_exists, ll_cd_motivo_devolucao, ll_nr_nf_origem, &
			ll_nr_agrupamento, ll_count, ll_for_array_st, ll_nr_sequencial_produto_ref, ll_vl_fator_conversao_entrada
String	ls_cd_cst_origem, ls_cd_cst_tributacao, ls_cd_beneficio, ls_tp_imp, ls_cd_natureza_operacao, &
			ls_tp_imp_lista[] = {'ICMS','PIS','COFI','IPI', 'ICST'}, ls_cd_produto_sap, ls_de_chave_acesso_origem, &
			ls_de_dados_adicionais, ls_contrato, ls_Chave_Movimento, ls_cd_cst_pis, ls_cd_cst_cofins, &
			ls_de_chave_acesso_atual, ls_cst, ls_cstreg, ls_cclasstrib, ls_cclasstribreg


ll_total_itens = idc_uo_ds_base_item.Retrieve(is_mandt, il_docnum, il_nr_sequencial)

if ll_total_itens > 0 then
	ldc_total_vl_bc_icms		= 0
	ldc_total_vl_icms			= 0
	ldc_total_vl_frete		= 0
	ldc_total_vl_desconto	= 0
	ldc_total_vl_ipi			= 0

	for ll_for = 1 to ll_total_itens
		ll_nr_item					= idc_uo_ds_base_item.Object.nr_item[ll_for]
		
		ll_nr_item_legado			= Long(left(String(ll_nr_item), Len(String(ll_nr_item)) -1))
		
		ls_cd_natureza_operacao	= idc_uo_ds_base_item.Object.cd_natureza_operacao[ll_for]
		
		ll_cd_natureza_operacao	= Long(left(ls_cd_natureza_operacao, 4))
		
		ldc_qt_devolvida					= idc_uo_ds_base_item.Object.qt_produto[ll_for]
		ldc_vl_desconto_sem_desconto	= idc_uo_ds_base_item.Object.vl_desconto[ll_for]
		ldc_vl_frete						= idc_uo_ds_base_item.Object.vl_frete[ll_for]
		ls_cd_cst_origem					= idc_uo_ds_base_item.Object.cd_cst_origem[ll_for]
		ls_cd_cst_tributacao				= idc_uo_ds_base_item.Object.cd_cst_tributacao[ll_for]
		ls_cd_beneficio					= idc_uo_ds_base_item.Object.cd_beneficio[ll_for]
		ls_cd_produto_sap					= idc_uo_ds_base_item.Object.cd_produto_sap[ll_for]
		ls_contrato							= idc_uo_ds_base_item.Object.contrato[ll_for]
		ls_cd_cst_pis						= idc_uo_ds_base_item.Object.cd_cst_pis[ll_for]
		ls_cd_cst_cofins					= idc_uo_ds_base_item.Object.cd_cst_cofins[ll_for]
		ldc_OutDesp							= idc_uo_ds_base_item.Object.nfoth[ll_for]
		ldc_OutDesp_Tot_Item				= idc_uo_ds_base_item.Object.nfoth_alt[ll_for]
		ls_cst								= idc_uo_ds_base_item.Object.cst[ll_for]
		ls_cstreg							= idc_uo_ds_base_item.Object.cstreg[ll_for]
		ls_cclasstrib						= idc_uo_ds_base_item.Object.cclasstrib[ll_for]
		ls_cclasstribreg					= idc_uo_ds_base_item.Object.cclasstribreg[ll_for]
		
		if IsNull(idh_recebido_sap) then
			ldc_vl_desconto				= idc_uo_ds_base_item.Object.nfdis[ll_for]
			ldc_vl_preco_unitario		= (idc_uo_ds_base_item.Object.nfnet[ll_for] / ldc_qt_devolvida)
			
			ldc_pc_desconto = Round(((ldc_vl_desconto / ldc_qt_devolvida) / ldc_vl_preco_unitario) * 100, 2)
		end if
						
		if not iuo_ge473_comum.of_localiza_codigo_produto_legado(ls_cd_produto_sap, ref ll_cd_produto, ps_log) then return false
		
		ll_total_itens_imp = idc_uo_ds_base_item_imp.Retrieve(is_mandt, il_docnum, il_nr_sequencial, ll_nr_item, ls_tp_imp_lista)
		
		if ll_total_itens_imp < 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nErro ao consultar a ' + idc_uo_ds_base_item_imp.DataObject + '.'
			
			return false
		end if
		
		ldc_vl_st_array = ldc_array_null
		
		ldc_vl_bc_icms		= 0
		ldc_pc_icms			= 0
		ldc_vl_icms			= 0
		ldc_vl_bc_ipi		= 0
		ldc_pc_ipi			= 0
		ldc_vl_ipi			= 0
		ldc_vl_bc_pis		= 0
		ldc_pc_pis			= 0
		ldc_vl_pis			= 0
		ldc_vl_bc_cofins	= 0
		ldc_pc_cofins		= 0
		ldc_vl_cofins		= 0
		ldc_vl_bc_st		= 0
		ldc_pc_st			= 0
		ldc_vl_st			= 0
		
		for ll_for_imp	= 1 to ll_total_itens_imp
			ls_tp_imp			= idc_uo_ds_base_item_imp.Object.taxgrp[ll_for_imp]
			ldc_vl_bc_othbas	= idc_uo_ds_base_item_imp.Object.othbas[ll_for_imp]
			
			choose case ls_tp_imp
				case 'ICMS'
					ldc_vl_bc_icms	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_icms		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_icms		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
				case 'IPI' //
					
					ldc_vl_bc_ipi	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_ipi		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_ipi			= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					// Se tiver IPI, mas n$$HEX1$$e300$$ENDHEX$$o possuir a base, tenta pegar a outras bases
					if ldc_vl_ipi > 0 and ldc_vl_bc_ipi <= 0 Then
						ldc_vl_bc_ipi = ldc_vl_bc_othbas
					End If
					
					If Not is_id_estornado = 'X' Then
						if ldc_vl_ipi > 0 and ldc_vl_bc_ipi <= 0 then
							ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado valor de IPI mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
							return false
						end if
						
						if ldc_vl_ipi <= 0 and ldc_vl_bc_ipi > 0 then
							ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado base de calculo de IPI mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
							return false
						end if
					End If							
				case 'PIS'
					ldc_vl_bc_pis	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_pis		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_pis		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if IsNull(ldc_vl_pis) then ldc_vl_pis = 0
				case 'COFI'
					ldc_vl_bc_cofins	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_cofins		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_cofins		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if IsNull(ldc_vl_cofins) then ldc_vl_cofins = 0
				case 'ICST'
					ldc_vl_bc_st	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_st		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_st		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					If Not is_id_estornado = 'X' Then
						if ldc_vl_st > 0 and ldc_vl_bc_st <= 0 then
							ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado valor de st mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
							return false
						end if
						
						if ldc_vl_st <= 0 and ldc_vl_bc_st > 0 then
							ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado base de calculo de st mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
							return false
						end if
					End If
					
					if IsNull(ldc_vl_st) then ldc_vl_st = 0
					
					ldc_vl_st_array[UpperBound(ldc_vl_st_array) + 1]	= ldc_vl_st
			end choose
		next
		
		if not IsNull(idh_recebido_sap) then
			ldc_valor_total_liquido_sem_impostos	= idc_uo_ds_base_item.Object.netwr [ll_for]
			ldc_valor_total_bruto_sem_impostos		= idc_uo_ds_base_item.Object.netwr [ll_for]
			
			if ldc_valor_total_liquido_sem_impostos > 0 and ldc_valor_total_bruto_sem_impostos > 0 then
				ldc_OutDesp	= idc_uo_ds_base_item.Object.netoth[ll_for]
				
				If IsNull(ldc_OutDesp) then ldc_OutDesp = 0
				If IsNull(ldc_vl_desconto_sem_desconto) then ldc_vl_desconto_sem_desconto = 0
				
				ldc_valor_total_liquido_sem_impostos_sem_desp	= ldc_valor_total_liquido_sem_impostos
				
				ldc_valor_total_liquido_sem_impostos	= ldc_valor_total_liquido_sem_impostos + ldc_OutDesp - ldc_vl_desconto_sem_desconto
				
				if is_id_tipo_nf = 'YY' then
					ldc_valor_total_liquido_com_impostos	= ldc_valor_total_liquido_sem_impostos
				else
					ldc_valor_total_liquido_com_impostos	= ldc_valor_total_liquido_sem_impostos + ldc_vl_icms + ldc_vl_cofins + ldc_vl_pis
				end if
				
				ldc_valor_t	= ldc_valor_total_liquido_sem_impostos / ldc_valor_total_liquido_com_impostos
				
				if ldc_OutDesp > 0 then
					ldc_OutDesp_com_imposto	= ldc_OutDesp / ldc_valor_t
				else
					ldc_OutDesp_com_imposto	= 0
				end if
				
				ldc_vl_total_item_bruto_com_impostos	= ldc_valor_total_bruto_sem_impostos / ldc_valor_t
				ldc_valor_total_liquido_com_impostos	= ldc_valor_total_liquido_sem_impostos / ldc_valor_t
				
				ldc_vl_desconto				= ldc_vl_total_item_bruto_com_impostos - (ldc_valor_total_liquido_com_impostos - ldc_OutDesp_com_imposto)
				
				ldc_vl_preco_unitario		= ldc_vl_total_item_bruto_com_impostos / ldc_qt_devolvida
				
				ldc_pc_desconto = Round((ldc_vl_desconto / ldc_vl_total_item_bruto_com_impostos) * 100, 2)
			else
				ldc_pc_desconto	= Round(((ldc_vl_desconto / ldc_qt_devolvida) / ldc_vl_preco_unitario) * 100, 2)
				
				ldc_vl_preco_unitario		= idc_uo_ds_base_item.Object.vl_preco_unitario[ll_for]
				ldc_vl_total_item_bruto_com_impostos	= idc_uo_ds_base_item.Object.vl_total_item[ll_for]
			end if
			
			idc_total_desp += ldc_OutDesp_com_imposto	
		else
			idc_total_desp += ldc_OutDesp
		end if		
		
		if IsNull(ldc_vl_frete) then ldc_vl_frete = 0
		if IsNull(ldc_vl_desconto) then ldc_vl_desconto = 0
		if IsNull(ldc_vl_ipi) then ldc_vl_ipi = 0
		if IsNull(ldc_vl_bc_icms) then ldc_vl_bc_icms = 0
		if IsNull(ldc_vl_icms) then ldc_vl_icms = 0
					
		ldc_total_vl_bc_icms		+= ldc_vl_bc_icms
		ldc_total_vl_icms			+= ldc_vl_icms
		ldc_total_vl_ipi			+= ldc_vl_ipi
		ldc_total_vl_frete		+= ldc_vl_frete
		ldc_total_vl_desconto	+= ldc_vl_desconto
		
		if not IsNull(idh_recebido_sap) then
			ldc_vl_preco_unitario_aux	= (ldc_vl_total_item_bruto_com_impostos / ldc_qt_devolvida) 
			
			ldc_vl_total_itens += ldc_valor_total_liquido_com_impostos
		else
			ldc_vl_preco_unitario_aux	= ldc_vl_preco_unitario
			
			ldc_vl_total_itens += (ldc_vl_preco_unitario * ldc_qt_devolvida) - ldc_vl_desconto
		end if
				
		if il_nr_integracao > 0 then
			ll_exists	= 0
			
			//Ajustar para trazer todos os lotes
			select top 1 cd_produto, 
					 cd_chave_movimento_estoque_wms
			  into :ll_exists, 
			  		 :ls_Chave_Movimento
			  from wms_int_sap_detalhe
			 where nr_integracao	= :il_nr_integracao 
			 	and cd_produto		= :ll_cd_produto;
			
			if sqlca.SqlCode < 0 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao verificar a existencia do lote: ~n' + sqlca.SqlErrText
				
				return false
			end if
					
			// Atualiza com os dados na NFD, em caso de cancelamento ser$$HEX1$$e300$$ENDHEX$$o requeridos pela trigger
			if not IsNull(ls_Chave_Movimento) and Trim(ls_Chave_Movimento) <> '' then
				update wms_movimento_estoque
					set nr_nf 		= :il_nr_nf, 
						 de_especie = :is_de_especie, 
						 de_serie 	= :is_de_serie, 
						 cd_filial 	= :il_cd_filial
 				 where cd_chave_movimento = :ls_Chave_Movimento
				Using SqlCa;
				
				if sqlca.SqlCode < 0 then
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao atualizar os dados do movimento do produto ' + String(ll_cd_produto) + ': ~n' + sqlca.SqlErrText
					return false
				end if				
			else
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi encontrado a chave da movimenta$$HEX2$$e700e300$$ENDHEX$$o.'
				return false
			end if
		end if
			
		select 1
		  into :ll_exists
		  from nf_devolucao_compra_produto
		 where cd_filial	= :il_cd_filial
		 	and nr_nf		= :il_nr_nf
			and de_especie	= :is_de_especie
			and de_serie	= :is_de_serie
			and cd_produto	= :ll_cd_produto
			and nr_item 	= :ll_nr_item_legado;
			
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nErro ao consultar a tabela nf_devolucao_compra_produto.'
			
				return false
			Case 100
				insert into nf_devolucao_compra_produto(
							cd_filial,
							nr_nf,
							de_especie,
							de_serie,
							nr_item,
							cd_produto,
							cd_natureza_operacao,
							qt_devolvida,
							vl_preco_unitario,
							pc_desconto,
							cd_cst_origem,
							cd_cst_tributacao,
							id_lista_pis_cofins,
							vl_bc_icms,
							pc_icms,
							vl_icms,
							pc_reducao_bc_icms,
							vl_bc_icms_st,
							pc_icms_st,
							vl_icms_st,
							pc_reducao_bc_icms_st,
							vl_bc_ipi,
							pc_ipi,
							vl_ipi,
							cd_cst_ipi,
							nr_classificacao_fiscal,
							vl_preco_venda_maximo,
							pc_mva,
							vl_desconto,
							vl_frete,
							vl_outras_despesas,
							vl_bc_icms_st_retido,
							vl_icms_st_retido,
							vl_bc_icms_st_auxiliar,
							vl_icms_st_auxiliar,
							cd_cst_pis,
							cd_cst_cofins,
							vl_bc_pis,
							vl_pis,
							vl_bc_cofins,
							vl_cofins,
							pc_st_retido,
							vl_icms_retido,
							cd_beneficio,
							vl_icms_operacao,
							pc_icms_diferido,
							vl_icms_diferido,
							vl_bc_icms_antecipacao,
							pc_mva_icms_antecipacao,
							pc_icms_antecipacao,
							vl_icms_antecipacao,
							cd_cest,
							cd_cst_ibscbs,
							cd_class_trib_ibscbs,
						 	cd_cst_ibscbs_reg,
						 	cd_class_trib_ibscbs_reg)
				 values (:il_cd_filial, 					//cd_filial
							:il_nr_nf,							//nr_nf
							:is_de_especie,					//de_especie
							:is_de_serie,						//de_serie
							:ll_nr_item_legado,				//nr_item
							:ll_cd_produto,					//cd_produto
							:ll_cd_natureza_operacao,		//cd_natureza_operacao
							:ldc_qt_devolvida,				//qt_devolvida
							:ldc_vl_preco_unitario_aux,	//vl_preco_unitario
							Round(:ldc_pc_desconto, 2),	//pc_desconto
							:ls_cd_cst_origem,				//cd_cst_origem
							:ls_cd_cst_tributacao,			//cd_cst_tributacao
							null,									//id_lista_pis_cofins
							:ldc_vl_bc_icms,					//vl_bc_icms
							:ldc_pc_icms,						//pc_icms
							:ldc_vl_icms,						//vl_icms
							0,										//pc_reducao_bc_icms
							:ldc_vl_bc_icms_st,				//vl_bc_icms_st
							:ldc_pc_icms_st,					//pc_icms_st
							:ldc_vl_icms_st,					//vl_icms_st
							0,										//pc_reducao_bc_icms_st
							:ldc_vl_bc_ipi,					//vl_bc_ipi
							:ldc_pc_ipi,						//pc_ipi
							:ldc_vl_ipi,						//vl_ipi
							'',									//cd_cst_ipi
							0,										//nr_classificacao_fiscal
							0,										//vl_preco_venda_maximo
							0,										//pc_mva
							:ldc_vl_desconto,					//vl_desconto
							:ldc_vl_frete,						//vl_frete
							:ldc_OutDesp,						//vl_outras_despesas
							0,										//vl_bc_icms_st_retido
							0,										//vl_icms_st_retido
							0,										//vl_bc_icms_st_auxiliar
							0,										//vl_icms_st_auxiliar
							:ls_cd_cst_pis,					//cd_cst_pis
							:ls_cd_cst_cofins,				//cd_cst_cofins
							:ldc_vl_bc_pis,					//vl_bc_pis
							:ldc_vl_pis,						//vl_pis
							:ldc_vl_bc_cofins,				//vl_bc_cofins
							:ldc_vl_cofins,					//vl_cofins
							0,										//pc_st_retido
							0,										//vl_icms_retido
							:ls_cd_beneficio,					//cd_beneficio
							0, 									//vl_icms_operacao  
							0,										//pc_icms_diferido
							0,										//vl_icms_diferido
							0,										//vl_bc_icms_antecipacao
							0,										//pc_mva_icms_antecipacao
							0,										//pc_icms_antecipacao
							0,										//vl_icms_antecipacao
							'',									//cd_cest
							:ls_cst,
						 	:ls_cclasstrib,
						 	:ls_cstreg,
						 	:ls_cclasstribreg)
				using sqlca;
				
				if sqlca.SqlCode <> 0 then 
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao inserir "nf_devolucao_compra_produto": ~n' + sqlca.SqlErrText
					return false
				end if
				
				// Chamado 1491818
				If Not of_valida_insere_lotes_dev(il_cd_filial, il_nr_nf, is_de_especie, is_de_serie, ll_nr_item_legado, ll_cd_produto, ldc_qt_devolvida, Ref ps_Log) Then
					return false
				End If
				
				lb_atualizou_compra	= True
			Case 0				
				update nf_devolucao_compra_produto
					set cd_natureza_operacao = :ll_cd_natureza_operacao,
						 qt_devolvida = :ldc_qt_devolvida,
						 vl_preco_unitario = :ldc_vl_preco_unitario_aux,
						 pc_desconto = :ldc_pc_desconto,
						 cd_cst_origem = :ls_cd_cst_origem,
						 cd_cst_tributacao = :ls_cd_cst_tributacao,
						 id_lista_pis_cofins = null,
						 vl_bc_icms = :ldc_vl_bc_icms,
						 pc_icms = :ldc_pc_icms,
						 vl_icms = :ldc_vl_icms,
						 pc_reducao_bc_icms = 0,
						 vl_bc_icms_st = :ldc_vl_bc_icms_st,
						 pc_icms_st = :ldc_pc_icms_st,
						 vl_icms_st = :ldc_vl_icms_st,
						 pc_reducao_bc_icms_st = 0,
						 vl_bc_ipi = :ldc_vl_bc_ipi,
						 pc_ipi = :ldc_pc_ipi,
						 vl_ipi = :ldc_vl_ipi,
						 cd_cst_ipi = '',
						 nr_classificacao_fiscal = 0,
						 vl_preco_venda_maximo = 0,
						 pc_mva = 0,
						 vl_desconto = :ldc_vl_desconto,
						 vl_frete = :ldc_vl_frete,
						 vl_outras_despesas = 0,
						 vl_bc_icms_st_retido = 0,
						 vl_icms_st_retido = 0,
						 vl_bc_icms_st_auxiliar = 0,
						 vl_icms_st_auxiliar = 0,
						 cd_cst_pis = :ls_cd_cst_pis,
						 cd_cst_cofins = :ls_cd_cst_cofins,
						 vl_bc_pis = :ldc_vl_bc_pis,
						 vl_pis = :ldc_vl_pis,
						 vl_bc_cofins = :ldc_vl_bc_cofins,
						 vl_cofins = :ldc_vl_cofins,
						 pc_st_retido = 0,
						 vl_icms_retido = 0,
						 cd_beneficio = :ls_cd_beneficio,
						 vl_icms_operacao = 0,
						 pc_icms_diferido = 0,
						 vl_icms_diferido = 0,
						 vl_bc_icms_antecipacao = 0,
						 pc_mva_icms_antecipacao = 0,
						 pc_icms_antecipacao = 0,
						 vl_icms_antecipacao = 0,
						 cd_cest = '',
						 cd_cst_ibscbs					= :ls_cst,
						 cd_class_trib_ibscbs		= :ls_cclasstrib,
						 cd_cst_ibscbs_reg			= :ls_cstreg,
						 cd_class_trib_ibscbs_reg	= :ls_cclasstribreg
				 where cd_filial	= :il_cd_filial 
				 	and nr_nf		= :il_nr_nf
					and de_especie	= :is_de_especie
					and de_serie	= :is_de_serie
					and nr_item 	= :ll_nr_item_legado
					and cd_produto = :ll_cd_produto;
				
				if sqlca.SqlCode <> 0 then 
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao atualizar "nf_devolucao_compra_produto": ~n' + sqlca.SqlErrText
					
					return false
				end if
				
				// Chamado 1491818
				If Not of_valida_insere_lotes_dev(il_cd_filial, il_nr_nf, is_de_especie, is_de_serie, ll_nr_item_legado, ll_cd_produto, ldc_qt_devolvida, Ref ps_Log) Then
					return false
				End If
				
				lb_atualizou_compra	= true
		End Choose
				
		if il_nr_integracao > 0 then
			SetNull(ll_nr_sequencial_produto_ref)
			
			select top 1 nr_sequencial
			  into :ll_nr_sequencial_produto_ref
			  from wms_int_sap_detalhe
			 where nr_integracao	= :il_nr_integracao
			 	and cd_produto		= :ll_cd_produto
			Using SQLCA;
			
			Choose Case SQLCA.SQLCode
				Case -1
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o sequencial do produto dentro da wms_int_sap: ~n' + sqlca.SqlErrText
				
					return false
			End Choose
			
			if ll_nr_sequencial_produto_ref = 0 or IsNull(ll_nr_sequencial_produto_ref) then
				ll_nr_sequencial_produto_ref	= ll_nr_item_legado
			end if
			
			SetNull(ls_de_chave_acesso_origem)
			
			select top 1 de_chave_acesso_origem
			  into :ls_de_chave_acesso_origem
			  from wms_int_sap_auxiliar
			 where nr_integracao = :il_nr_integracao 
			 	and nr_sequencial	= :ll_nr_sequencial_produto_ref
			order by nr_sequencial desc;
			
			if sqlca.SqlCode < 0 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a chave de acesso na nota de origem: ~n' + sqlca.SqlErrText
				
				return false
			end if
			
			if Trim(ls_de_chave_acesso_origem) = '' or IsNull(ls_de_chave_acesso_origem) then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a chave de acesso na nota de origem com o n$$HEX1$$fa00$$ENDHEX$$mero de integra$$HEX2$$e700e300$$ENDHEX$$o: '+string(il_nr_integracao)
				
				return false
			end if
			
			ldc_vl_preco_unitario_origem	= 0
			
			select top 1 coalesce(cast(round(i.vl_preco_unitario, 2) as decimal (7,2)), 0),
					 i.qt_faturada / Coalesce(i.qt_comercial, 1)
			into :ldc_vl_preco_unitario_origem,
				  :ll_vl_fator_conversao_entrada
			from nf_compra as n inner join item_nf_compra as i on i.nr_nf			= n.nr_nf and
			 		 													 			  i.de_serie		= n.de_serie and
					 																  i.de_especie		= n.de_especie and
					 													 			  i.cd_fornecedor = n.cd_fornecedor and
					 													 			  i.cd_filial		= n.cd_filial
			 where n.de_chave_acesso	= :ls_de_chave_acesso_origem and
 					 i.cd_produto			= :ll_cd_produto
			order by dh_recebido_sap desc;
			
			if sqlca.SqlCode < 0 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o pre$$HEX1$$e700$$ENDHEX$$o do produto da nota de origem: ~n' + sqlca.SqlErrText
				return false
			end if
			
			SetNull(ls_de_chave_acesso_atual)
			
			select de_chave_acesso
			  into :ls_de_chave_acesso_atual
			  from nf_devolucao_compra_entrada
			 where de_chave_acesso	= :ls_de_chave_acesso_origem
			 	and cd_filial			= :il_cd_filial
				and nr_nf				= :il_nr_nf
				and de_especie			= :is_de_especie
				and de_serie 			= :is_de_serie;
			  
			choose case sqlca.sqlcode
				case -1
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a chave de acesso de origem: ~n' + sqlca.SqlErrText
					return false
				case 100
					insert into nf_devolucao_compra_entrada(
								cd_filial,
								nr_nf,
								de_especie,
								de_serie,
								de_chave_acesso)
					 values (:il_cd_filial,
					 		   :il_nr_nf,
								:is_de_especie,
								:is_de_serie,
								:ls_de_chave_acesso_origem)
					using sqlca;
					
					if sqlca.SqlCode <> 0 then 
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao inserir "nf_devolucao_compra_entrada": ~n' + sqlca.SqlErrText
						
						return false
					end if
			end choose

			// Valida somente se a nota de compra n$$HEX1$$e300$$ENDHEX$$o entrou via SAP, neste caso na interface de subida $$HEX1$$e900$$ENDHEX$$ enviado os valores do Sybase, ou seja, o SAP dever$$HEX1$$e100$$ENDHEX$$ assumir este valores.
			If IsNull(idh_recebido_sap) and Not is_id_estornado = 'X' Then
				ldc_diferenca	= truncate(ldc_vl_preco_unitario_origem, 2) - truncate(ldc_vl_preco_unitario, 2)
				
				if ldc_diferenca < -0.02 or ldc_diferenca > 0.02 then
					ldc_diferenca	= truncate(ldc_vl_preco_unitario_origem * ll_vl_fator_conversao_entrada, 2) - truncate(ldc_vl_preco_unitario, 2)
					
					if ldc_diferenca < -0.02 or ldc_diferenca > 0.02 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao inserir "valor unit$$HEX1$$e100$$ENDHEX$$rio da nota origem diferente do valor unit$$HEX1$$e100$$ENDHEX$$rio retornado": ~n' + sqlca.SqlErrText
						return false
					end if
				end if
			End If
			
			select 1
			  into :ll_exists
			  from nf_devolucao_compra_prd_ent
			 where cd_filial	= :il_cd_filial 
			   and nr_nf		= :il_nr_nf
				and de_especie	= :is_de_especie
				and de_serie	= :is_de_serie
				and nr_item		= :ll_nr_item_legado;
			
			Choose Case SQLCA.SQLCode
				Case -1
				Case 0
				Case 100
					insert into nf_devolucao_compra_prd_ent( 
								cd_filial,
								nr_nf,
								de_especie,
								de_serie,
								nr_item,
								cd_fornecedor,
								nr_nf_compra,
								de_especie_compra,
								de_serie_compra)  
					 values (:il_cd_filial,				//cd_filial
								:il_nr_nf,					//nr_nf
								:is_de_especie,			//de_especie
								:is_de_serie,				//de_serie
								:ll_nr_item_legado,		//nr_item
								:is_cd_fornecedor,		//cd_fornecedor
								:il_nr_nf_origem,			//nr_nf_compra
								:is_de_especie_origem,	//de_especie_compra
								:is_de_serie_origem)		//de_serie_compra
					using sqlca;
			
					if sqlca.SqlCode <> 0 then 
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao inserir "nf_devolucao_compra_prd_ent": ~n' + sqlca.SqlErrText
						
						return false
					end if

			End Choose
		end if
	next
	
	if lb_atualizou_compra then		
		SetNull(ll_nr_agrupamento)
		SetNull(ll_cd_motivo_devolucao)
		
		select de_dados_adicionais,
				 cd_motivo_devolucao,
				 nr_agrupamento_dev_compra
		  into :ls_de_dados_adicionais,
				 :ll_cd_motivo_devolucao,
				 :ll_nr_agrupamento
		  from wms_int_sap
		 where nr_integracao	= :il_nr_integracao;
	
		if sqlca.SqlCode < 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar os dados adicionais: ~n' + sqlca.SqlErrText
			
			return false
		end if
		
		if IsNull(ll_cd_motivo_devolucao) or ll_cd_motivo_devolucao = 0 then
			ll_cd_motivo_devolucao	= 6
		end if
		
		update nf_devolucao_compra
			set vl_bc_icms				= :ldc_total_vl_bc_icms,
				 vl_icms					= :ldc_total_vl_icms,
				 vl_frete				= :ldc_total_vl_frete,
				 vl_desconto			= :ldc_total_vl_desconto,
				 vl_ipi					= :ldc_total_vl_ipi,
				 vl_total_produtos	= :ldc_vl_total_itens + :ldc_total_vl_desconto - :idc_total_desp,
				 vl_total_nf			= :ldc_vl_total_itens + :ldc_total_vl_ipi,
				 de_dados_adicionais	= :ls_de_dados_adicionais,
				 cd_motivo_devolucao	= :ll_cd_motivo_devolucao,
				 vl_outras_despesas	= :idc_total_desp
		 where cd_filial	= :il_cd_filial and
				 nr_nf		= :il_nr_nf and
				 de_serie	= :is_de_serie and
				 de_especie	= :is_de_especie;
				 
		if sqlca.SqlCode <> 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao atualizar "nf_devolucao_compra": ~n' + sqlca.SqlErrText
			
			return false
		end if
		
		if ll_nr_agrupamento > 0 then
			update nf_devolucao_compra
				set nr_agrupamento_dev_compra	= :ll_nr_agrupamento
			 where cd_filial	= :il_cd_filial and
					 nr_nf		= :il_nr_nf and
					 de_serie	= :is_de_serie and
					 de_especie	= :is_de_especie;
					 
			if sqlca.SqlCode <> 0 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao atualizar "nf_devolucao_compra": ~n' + sqlca.SqlErrText
				
				return false
			end if
			
			if not of_gera_coleta_pendente(ll_nr_agrupamento, ps_log) then
				return false
			end if
		end if
		
		update wms_int_sap
			set nr_nf						= :il_nr_nf,
				 de_especie					= :is_de_especie,
				 de_serie					= :is_de_serie,
				 nr_ano_documento_sap	= :il_nr_ano_documento_sap,
				 nr_documento_sap			= :is_nr_documento_sap,
				 dh_retorno_sap 			= getdate(),
				 cd_filial					= :il_cd_filial,
				 id_situacao				= 'P'
		 where nr_integracao	= :il_nr_integracao;
		 
		if sqlca.SqlCode <> 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao atualizar "wms_int_sap": ~n' + sqlca.SqlErrText
			return false
		end if
		
		ll_count	= 0
		
		select count(*)
		  into :ll_count
		  from wms_int_sap
		 where nr_agrupamento_dev_compra	= :ll_nr_agrupamento and
				 nr_nf 							is null;
		 
		if ll_nr_agrupamento > 0 and ll_count = 0 then
			update agrupamento_dev_compra
				set id_situacao = 'R', 
					 dh_alteracao_situacao = getdate()
			 where nr_agrupamento	= :ll_nr_agrupamento
			    and id_situacao <> 'R';
	
			if sqlca.SqlCode <> 0 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nProblemas ao atualizar "agrupamento_dev_compra": ~n' + sqlca.SqlErrText
				return false
			end if
		end if
	end if
elseif ll_total_itens = 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrado itens para serem inseridos na devolu$$HEX2$$e700e300$$ENDHEX$$o ' + idc_uo_ds_base_nota.DataObject + '.'
	return false
else
	ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nErro ao consultar a ' + idc_uo_ds_base_nota.DataObject + '.'
	return false
end if

return true
end function

public function boolean of_insere_nf_devolucao_compra (ref string ps_log);Long		ll_exists, ll_total_itens, ll_nr_item_legado, ll_nr_item
String	ls_contrato, ls_de_chave_acesso_origem, ls_nr_matricula_responsavel

ll_exists = 0

select top 1 1
  into :ll_exists
  from nf_devolucao_compra
 where cd_filial	= :il_cd_filial and
 		 nr_nf		= :il_nr_nf and
		 de_serie	= :is_de_serie and
		 de_especie	= :is_de_especie;

if sqlca.SqlCode < 0 then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a nota de devolu$$HEX2$$e700e300$$ENDHEX$$o de compra: ~n' + sqlca.SqlErrText
	
	return false
end if

// Carreg ds de ITEM
If idc_uo_ds_base_item.Retrieve(is_mandt, il_docnum, il_nr_sequencial) <= 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_chave_integracao' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrados itens na tabela [J_1BNFLIN]. '
	return false
End If

If Not This.of_localiza_chave_integracao(ref ps_log) Then Return False

//Notas de devolu$$HEX2$$e700e300$$ENDHEX$$o YY n$$HEX1$$e300$$ENDHEX$$o tem documento de referencia.
If (Isnull(il_nr_integracao)  or il_nr_integracao = 0) and is_id_tipo_nf <> 'YY' Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra' + '~nN$$HEX1$$e300$$ENDHEX$$o foi encontrado o n$$HEX1$$fa00$$ENDHEX$$mero de integra$$HEX2$$e700e300$$ENDHEX$$o. '
	return false
End If

if il_nr_integracao > 0 or is_id_tipo_nf = 'YY' then
	SetNull(ls_de_chave_acesso_origem)
	
	if is_id_tipo_nf <> 'YY' then
		ll_nr_item					= idc_uo_ds_base_item.Object.nr_item[1]
			
		ll_nr_item_legado			= Long(left(String(ll_nr_item), Len(String(ll_nr_item)) -1))
			
		select top 1 
			wisa.de_chave_acesso_origem,
			wis.nr_matricula_responsavel
		into 
			:ls_de_chave_acesso_origem,
			:ls_nr_matricula_responsavel
		from 
			wms_int_sap_auxiliar wisa
		inner join 
			wms_int_sap wis
			on wis.nr_integracao	= wisa.nr_integracao
		where 
			wisa.nr_integracao 	= :il_nr_integracao 
			and wisa.nr_item		= :ll_nr_item_legado
		order by wisa.nr_sequencial desc;
		
		if sqlca.SqlCode < 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nErro ao localizar a chave de acesso da NF de origem: ~n' + sqlca.SqlErrText
			return false
		end if
	else
		Choose Case il_docnum
			Case 777690
				ls_de_chave_acesso_origem = '35220460409075010034550010059551041906506510'
			Case 941978, 942011
				ls_de_chave_acesso_origem = '33230304522600000251550020000654381339017646'
			Case 957861
				ls_de_chave_acesso_origem = '33230833051491000159550040001043081000237016'
			Case 957862
				ls_de_chave_acesso_origem = '52230684684620000691550020001256191320160370'
			Case 1102165
				ls_de_chave_acesso_origem = '42230782873068000140550010251732651995479904'
			Case 1105251 
				ls_de_chave_acesso_origem = '42230782873068000140550010251732651995479904'
		End Choose
		//Implementar busca correta pela nota fiscal de origem
	end if
	
	SetNull(il_nr_nf_origem)
	SetNull(is_de_serie_origem)
	SetNull(is_de_especie_origem)
	
	select top 1 nr_nf,
			 de_serie, 
			 de_especie, 
			 dh_recebido_sap,
			 cd_fornecedor
	  into :il_nr_nf_origem, 
	  		 :is_de_serie_origem, 
			 :is_de_especie_origem, 
			 :idh_recebido_sap,
			 :is_cd_fornecedor
	  from nf_compra
	 where de_chave_acesso	= :ls_de_chave_acesso_origem
	 order by dh_recebido_sap desc
	Using Sqlca;
	
	Choose Case SqlCa.SqlCode 
		Case -1
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a chave de acesso na nota de origem: ~n' + sqlca.SqlErrText
			return false
		Case 100
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a nota de origem com a sua chave de acesso.'
			return false
	End Choose
end if

if IsNull(ls_nr_matricula_responsavel) or Trim(ls_nr_matricula_responsavel) = '' then
	ls_nr_matricula_responsavel	= '14330'
end if

select 1
  into :ll_exists
  from nf_devolucao_compra
 where nr_nf		= :il_nr_nf
   and cd_filial	= :il_cd_filial
	and de_especie	= :is_de_especie
	and de_serie	= :is_de_serie
using SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nErro ao localizar nota fiscal de compra: ~n' + sqlca.SqlErrText
		return false
	Case 0
		update nf_devolucao_compra
			set vl_bc_icms = 0,
			    vl_icms = 0,
			    vl_bc_icms_st = 0,
			    vl_icms_st = 0,
			    vl_icms_repassado = 0,
			    vl_total_produtos = 0,
			    vl_ipi = 0,
			    vl_frete = 0,
			    vl_seguro = 0,
			    vl_outras_despesas = 0,
			    vl_desconto = 0,
			    vl_indenizacao = 0,
			    vl_total_nf = :idc_vl_total_nf, 
			    cd_fornecedor = :is_cd_fornecedor, 
			    nr_nf_compra = :il_nr_nf_origem,
			    de_especie_compra = :is_de_especie_origem,
			    de_serie_compra = :is_de_serie_origem,
			    nr_matricula_operador = :ls_nr_matricula_responsavel, 
			    nr_titulo_receber = null, 
			    de_motivo_devolucao = null, 
			    nr_nsu = null, 
			    dh_emissao = :idh_emissao,
			    nr_documento_sap	=:il_docnum  
		 where nr_nf		= :il_nr_nf
			and cd_filial	= :il_cd_filial
			and de_especie	= :is_de_especie
			and de_serie	= :is_de_serie
		using SQLCA;
		
		if sqlca.SqlCode <> 0 then 
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra' + '~nProblemas ao atualizar "nf_devolucao_compra": ~n' + sqlca.SqlErrText
			return false
		end if
	Case 100
		insert into nf_devolucao_compra (
				  cd_filial,   
				  nr_nf,   
				  de_especie,   
				  de_serie,   
				  dh_movimentacao_caixa,   
				  vl_bc_icms,   
				  vl_icms,   
				  vl_bc_icms_st,   
				  vl_icms_st,   
				  vl_icms_repassado,   
				  vl_total_produtos,   
				  vl_ipi,   
				  vl_frete,   
				  vl_seguro,   
				  vl_outras_despesas,   
				  vl_desconto,   
				  vl_indenizacao,   
				  vl_total_nf,   
				  cd_fornecedor,   
				  nr_nf_compra,   
				  de_especie_compra,   
				  de_serie_compra,   
				  nr_matricula_operador,   
				  dh_cancelamento,   
				  nr_matricula_cancelamento,   
				  nr_titulo_receber,   
				  de_motivo_devolucao,   
				  nr_nsu,   
				  dh_emissao,   
				  de_email_envio_xml,   
				  id_motivo_devolucao,   
				  cd_motivo_devolucao,   
				  de_dados_adicionais,   
				  nr_agrupamento_dev_compra,   
				  cd_fornecedor_dev_compra,   
				  dh_importacao_matriz,
				  dh_recebido_sap,
				  nr_documento_sap)  
		values (:il_cd_filial,						//cd_filial   
				  :il_nr_nf, 							//nr_nf   
				  :is_de_especie, 					//de_especie
				  :is_de_serie, 						//de_serie 
				  :idh_movimentacao_caixa,		 	//dh_movimentacao_caixa 
				  0, 										//vl_bc_icms 
				  0, 										//vl_icms 
				  0, 										//vl_bc_icms_st 
				  0, 										//vl_icms_st 
				  0, 										//vl_icms_repassado 
				  0, 										//vl_total_produtos 
				  0, 										//vl_ipi 
				  0, 										//vl_frete 
				  0, 										//vl_seguro 
				  0, 										//vl_outras_despesas 
				  0, 										//vl_desconto 
				  0, 										//vl_indenizacao 
				  :idc_vl_total_nf, 					//vl_total_nf 
				  :is_cd_fornecedor, 				//cd_fornecedor 
				  :il_nr_nf_origem,					//nr_nf_compra 
				  :is_de_especie_origem,			//de_especie_compra 
				  :is_de_serie_origem,				//de_serie_compra 
				  :ls_nr_matricula_responsavel, 	//nr_matricula_operador 
				  null, 									//dh_cancelamento 
				  null, 									//nr_matricula_cancelamento 
				  null, 									//nr_titulo_receber 
				  null, 									//de_motivo_devolucao 
				  null, 									//nr_nsu 
				  :idh_emissao, 						//dh_emissao 
				  null, 									//de_email_envio_xml 
				  null, 									//id_motivo_devolucao 
				  null, 									//cd_motivo_devolucao 
				  null, 									//de_dados_adicionais 
				  null, 									//nr_agrupamento_dev_compra 
				  null, 									//cd_fornecedor_dev_compra 
				  null, 									//dh_importacao_matriz
				  getdate(),							//dh_recebido_sap
				  :il_docnum )							//DocNum
		using sqlca;
		
		if sqlca.SqlCode <> 0 then 
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra' + '~nProblemas ao inserir "nf_devolucao_compra": ~n' + sqlca.SqlErrText
			return false
		end if
End Choose

return true
end function

public function boolean of_insere_nf_devolucao_compra_nfe (ref string ps_log);Long	ll_exists

/*
ver

cd_transportadora
*/

ll_exists	= 0

select top 1 1
  into :ll_exists
  from nf_devolucao_compra_nfe
 where cd_filial	= :il_cd_filial and
 		 nr_nf		= :il_nr_nf and
		 de_especie	= :is_de_especie and
		 de_serie	= :is_de_serie;

if sqlca.SqlCode < 0 then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_nfe' + '~nErro ao encontrar o devolu$$HEX2$$e700e300$$ENDHEX$$o de compra nfe: ~n' + sqlca.SqlErrText
	
	return false
end if

if ll_exists = 1 then
	update nf_devolucao_compra_nfe
		set de_chave_acesso		= :is_nr_chave_acesso,
			 id_situacao			= :is_id_situacao, 
			 qt_volume				= :il_qt_volume, 
			 de_especie_volume	= :is_de_especie_volume, 
			 qt_peso_liquido		= :idc_qt_peso_liquido, 
			 qt_peso_bruto			= :idc_qt_peso_bruto,
			 dh_envio				= :idh_envio,
			 nr_protocolo_envio	= :is_nr_protocolo_envio
	 where cd_filial	= :il_cd_filial and
			 nr_nf		= :il_nr_nf and
			 de_especie	= :is_de_especie and
			 de_serie	= :is_de_serie;
else
	insert into nf_devolucao_compra_nfe ( 
				cd_filial,
				nr_nf,
				de_especie,
				de_serie,
				de_chave_acesso,
				nr_protocolo_envio,
				nr_protocolo_cancelamento,
				dh_envio,
				id_situacao,
				dh_cancelamento,
				nr_matricula_cancelamento,
				cd_transportadora,
				de_placa_veiculo,
				cd_uf_veiculo,
				de_registro_antt,
				qt_volume,
				de_especie_volume,
				de_marca_volume,
				nr_volume,
				qt_peso_liquido,
				qt_peso_bruto,
				nr_protocolo_contingencia,
				dh_envio_contingencia)  
	 values (:il_cd_filial,					//cd_filial
				:il_nr_nf,						//nr_nf
				:is_de_especie,				//de_especie
				:is_de_serie,					//de_serie
				:is_nr_chave_acesso,			//de_chave_acesso
				:is_nr_protocolo_envio, 	//nr_protocolo_envio
				null, 							//nr_protocolo_cancelamento
				:idh_envio,						//dh_envio
				:is_id_situacao,				//id_situacao
				null,								//dh_cancelamento
				null,								//nr_matricula_cancelamento
				null,								//cd_transportadora
				null,								//de_placa_veiculo
				null,								//cd_uf_veiculo
				null,								//de_registro_antt
				:il_qt_volume,					//qt_volume
				:is_de_especie_volume,		//de_especie_volume
				null,								//de_marca_volume
				null,								//nr_volume
				:idc_qt_peso_liquido,		//qt_peso_liquido
				:idc_qt_peso_bruto,			//qt_peso_bruto
				null,								//nr_protocolo_contingencia
				null)								//dh_envio_contingencia
	using sqlca;
end if

if sqlca.SqlCode <> 0 then 
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_nfe' + '~nProblemas ao inserir/atualizar "nf_devolucao_compra_nfe": ~n' + sqlca.SqlErrText
	
	return false
end if

return true
end function

public function boolean of_atualiza_situacao (string ps_situacao, string ps_msg, ref boolean pb_pendente, ref string ps_log);Long ll_existe, ll_Teste


if ps_situacao = 'P' Then
	If is_id_tipo_nf = 'ZF' Then
	
		update j_1bnfdoc_1
			set id_status = 'P', 
				 dh_processamento = getdate(), 
				 de_log = null
		 where docnum 			= :il_docnum 
		 	and mandt 			= :is_mandt 
			and nr_sequencial = :il_nr_sequencial;
			 
	Else
		// O docnum pode ter sido enviado mais de uma vez
		update j_1bnfdoc_1
			set id_status = 'P', 
				 dh_processamento = getdate(), 
				 de_log = null
		 where mandt 			= :is_mandt 
		    and docnum			= :il_docnum
			and nr_sequencial in (	select nr_sequencial from dbo.j_1bnfdoc_2
											where docnum = :il_docnum
											  and nftype <> 'ZF')	;
 		
	End If
		
	if sqlca.SqlCode = -1 then
		ps_log = 'Objeto: ' + this.ClassName( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_situacao ' + '~nProblemas ao atualizar a tabela "j_1bnfdoc_1": ~n' + sqlca.SqlErrText
		
		return false
	end if

else
	
	update j_1bnfdoc_1
		set id_status = 'E', 
			 dh_processamento = getdate(), 
			 de_log = :ps_msg
	 where docnum 			= :il_docnum and 
	 		 mandt 			= :is_mandt and 
			 nr_sequencial = :il_nr_sequencial;
		
	if sqlca.SqlCode = -1 then
		ps_log = 'Objeto: ' + this.ClassName( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_situacao ' + '~nProblemas ao atualizar a tabela "j_1bnfdoc_1": ~n' + sqlca.SqlErrText
		
		return false
	end if
	
end if
	
return true
end function

public subroutine of_envia_email (string as_erro, long al_docnum);String	ls_msg_email


if IsNull(as_erro) then as_erro = ''

if IsNull(al_docnum) then
	ls_msg_email = 'Houveram problemas na interface de descida do SAP . <br>'+ &
						 'Interface:<b>NOTA FISCAL DEVOLU$$HEX2$$c700c300$$ENDHEX$$O DE COMPRA SAP</b><br>'+ &
						 '</ul></ul>'+&
						 as_erro
else
	ls_msg_email = 'Houveram problemas na interface de descida do SAP . <br>'+ &
						 'Interface:<b>NOTA FISCAL DEVOLU$$HEX2$$c700c300$$ENDHEX$$O DE COMPRA SAP</b><br>'+ &
						 'Documento:' + String(al_docnum) + ' <br>'+ &
						 '</ul></ul>'+&
						 as_erro
end if

gf_ge202_envia_email_automatico(220 , '', ls_msg_email, {''})
end subroutine

public function boolean of_grava_nf_devolucao_compra (ref string ps_log);ib_sucesso	= false

if this.of_insere_nf_devolucao_compra(ps_log) then
	if this.of_insere_nf_devolucao_compra_nfe(ps_log) then
		if this.of_insere_nf_devolucao_compra_produto(ps_log) then
			ib_sucesso	= true
		end if
	end if
end If

return ib_sucesso
end function

public function boolean of_grava_nf_transferencia (ref string ps_log);Long	ll_cd_produto, ll_total_linhas, ll_for, ll_qt_transferida, ll_qt_separada, ll_vl_fator_conversao, ll_nr_pedido_validador


ib_sucesso = false

if this.of_insere_nf_transferencia(ps_log) then
	if this.of_insere_nf_transferencia_nfe(ps_log) then
		if this.of_insere_nf_transferencia_produto(ps_log) then
			if il_nr_pedido_distribuidora_original > 0 then
				ll_nr_pedido_validador		= il_nr_pedido_distribuidora_original
			else
				ll_nr_pedido_validador		= il_nr_pedido_distribuidora 
			end if
			
			ll_total_linhas = idc_valida_nf_transf.Retrieve(ll_nr_pedido_validador)
			
			if ll_total_linhas > 0 then
				ib_sucesso	= true	
			else
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_nf_transferencia' + '~nN$$HEX1$$e300$$ENDHEX$$o encontrado os produtos da transferencia'
						
				ib_sucesso	= False
				
				return ib_sucesso
			end if
		end if
		
		return ib_sucesso
	end if
end If

return ib_sucesso
end function

public function boolean of_insere_nf_transferencia (ref string ps_log);DateTime	ldh_exportacao_sap
Dec{2}	ldc_vl_bc_icms, ldc_vl_icms, ldc_vl_bc_icms_st, ldc_vl_icms_st, ldc_vl_total_produtos
Long		ll_nr_nsu, ll_null, ll_exists, ll_total_itens
String	ls_distribuidora_estoque, ls_dados_adicionais, ls_id_situacao_pedido, ls_nr_pedido, &
			ls_id_situacao, ls_id_almoxarifado
String	lvs_Erro
Long	lvl_cd_centro_custo


SetNull(ll_null)

ldc_vl_bc_icms		= 0
ldc_vl_icms			= 0
ldc_vl_bc_icms_st	= 0
ldc_vl_icms_st		= 0
ldc_vl_total_produtos	= 0

ls_distribuidora_estoque = gvo_parametro.of_distribuidora_estoque()

il_cd_filial_destino	= 0

select top 1 cd_filial
  into :il_cd_filial_destino
  from filial 
 where nr_cgc 			= :is_nr_cgc and
		 id_situacao 	= 'A';
		 
if sqlca.SqlCode < 0 then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia' + '~nErro ao encontrar filial pelo cgc: ~n' + sqlca.SqlErrText
	
	return false
end if

if IsNull(il_cd_filial_destino) or il_cd_filial_destino = 0 then
	ps_log = 'Objeto: ' + this.ClassName( ) + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia' + '~nFilial de destino de transferencia n$$HEX1$$e300$$ENDHEX$$o encontrada. ' + idc_uo_ds_base_nota.DataObject + '.'
	
	return false
end if
		 
SetNull(ll_nr_nsu)

ll_total_itens = idc_uo_ds_base_item.Retrieve(is_mandt, il_docnum, il_nr_sequencial)

if ll_total_itens <= 0 then
	ps_log	= 'N$$HEX1$$e300$$ENDHEX$$o foram encontrados os itens do docnum ' + String(il_docnum)
	return false
else
	is_nr_pedido_distribuidora	= idc_uo_ds_base_item.Object.xped[1]
	
	if IsNull(is_nr_pedido_distribuidora) or Trim(is_nr_pedido_distribuidora) = '' then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~N$$HEX1$$fa00$$ENDHEX$$mero do pedido est$$HEX1$$e100$$ENDHEX$$ nulo(xped): ~n' + sqlca.SqlErrText
		
		return false
	end if
	
	if not of_busca_docnum_xped_repetido(ps_log) then
		return false
	end if
	
	is_nr_pedido_distribuidora	= gf_tira_zero_esquerda(is_nr_pedido_distribuidora)
	
	if Pos(is_nr_pedido_distribuidora, '/') > 0 then
		is_nr_pedido_distribuidora = Left(is_nr_pedido_distribuidora, Len(is_nr_pedido_distribuidora) - Len(mid(is_nr_pedido_distribuidora, Pos(is_nr_pedido_distribuidora, '/'), 5)))
	end if
	
	if not IsNumber(is_nr_pedido_distribuidora) then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~xped incorreto: ~n' + sqlca.SqlErrText
		
		return false
	end if
	
	il_nr_pedido_distribuidora	= Long(is_nr_pedido_distribuidora)
		
	if is_nr_pedido_distribuidora <> String(il_nr_pedido_distribuidora) Then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~n. Pedido n$$HEX1$$e300$$ENDHEX$$o foi enviado pelo legado para o SAP. C$$HEX1$$f300$$ENDHEX$$digo recebido na tag xPed n$$HEX1$$e300$$ENDHEX$$o comp$$HEX1$$e100$$ENDHEX$$tivel (' + is_nr_pedido_distribuidora + ')'
			
		return false
	end if
	
	if il_nr_pedido_distribuidora > 0 then
		select id_situacao,
				 dh_exportacao_sap,
				 id_pedido_almoxarifado
		  into :ls_id_situacao_pedido,
				 :ldh_exportacao_sap,
				 :ls_id_almoxarifado
		  from pedido_distribuidora
		 where nr_pedido_distribuidora	= :il_nr_pedido_distribuidora
		 	and cd_filial = :il_cd_filial_destino;
		
		Choose Case sqlca.SqlCode
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~nErro ao encontrar situa$$HEX2$$e700e300$$ENDHEX$$o: ~n' + sqlca.SqlErrText
			
				return false
			Case 100
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~n N$$HEX1$$e300$$ENDHEX$$o foi encontrado registro na tabela pedido_distribuidora para o pedido: ' + String(il_nr_pedido_distribuidora)
			
				return false
			Case 0
		End Choose

		//Situa$$HEX2$$e700e300$$ENDHEX$$o diferente de envio pendente para o sap ou j$$HEX1$$e100$$ENDHEX$$ finalizado (Caso de atualiza$$HEX2$$e700e300$$ENDHEX$$o da nf)
		if ls_id_situacao_pedido <> 'P' and ls_id_situacao_pedido <> 'F' then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia' + '~nPedido (' + is_nr_pedido_distribuidora + ') que originou a transfer$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ com situa$$HEX2$$e700e300$$ENDHEX$$o de enviado para o SAP: ~n' + sqlca.SqlErrText
			
			return false
		end if
	end if
end if

SetNull(lvl_cd_centro_custo)

If ls_id_almoxarifado = "S" Then
	If Not of_Busca_Centro_Custo_Almoxarifado(il_nr_pedido_distribuidora, Ref lvl_cd_centro_custo, Ref lvs_Erro) Then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia' + '~nPedido (' + is_nr_pedido_distribuidora + '). Fun$$HEX2$$e700e300$$ENDHEX$$o of_Busca_Centro_Custo_Almoxarifado retornou: ~n' +lvs_Erro
		Return False
	End If
End If

//Verifica se existe romaneio para a filial destino, n$$HEX1$$e300$$ENDHEX$$o existindo faz o insert
// Chamado 1536322: Foi comentado devido a um pedido ter subido ao SAP as 21:10 e a nota descer as 21:17
//                              Criando um romaneio. O processo normal $$HEX1$$e900$$ENDHEX$$ o carga criar esse romaneio.
//If Not of_verifica_insere_wms_romaneio(Ref ps_log) Then
//	Return False
//End If


select 1
  into :ll_exists
  from nf_transferencia  
 where nr_nf = :il_nr_nf
 	and cd_filial_origem = :il_cd_filial
	and de_serie = :is_de_serie
	and de_especie = :is_de_especie;
	
Choose Case SQLCA.SQLCode
	Case 100
		insert into nf_transferencia  
						 (cd_filial_origem,   
						  nr_nf,   
						  de_especie,   
						  de_serie,   
						  cd_filial_destino,   
						  dh_emissao,   
						  dh_movimentacao_caixa,   
						  vl_bc_icms,   
						  vl_icms,   
						  vl_bc_icms_st,   
						  vl_icms_st,   
						  vl_total_produtos,   
						  vl_total_nf,   
						  nr_matricula_operador,   
						  id_produto_vencido,
						  cd_distribuidora,
						  nr_pedido_distribuidora,
						  nr_nsu,
						  id_atualizacao_mov_estoque,
						  de_dados_adicionais,
						  dh_recebido_sap,
						  id_devolucao,
						  id_almoxarifado,
						  nr_documento_sap,
						  cd_centro_custo)
				values (:il_cd_filial,							//cd_filial_origem
						  :il_nr_nf,								//nr_nf
						  :is_de_especie,							//de_especie
						  :is_de_serie,							//de_serie
						  :il_cd_filial_destino,				//cd_filial_destino
						  :idh_emissao,							//dh_emissao
						  :idh_movimentacao_caixa,				//dh_movimentacao_caixa
						  :ldc_vl_bc_icms,						//vl_bc_icms
						  :ldc_vl_icms,							//vl_icms
						  :ldc_vl_bc_icms_st,					//vl_bc_icms_st
						  :ldc_vl_icms_st,						//vl_icms_st
						  :ldc_vl_total_produtos,				//vl_total_produtos
						  :idc_vl_total_nf,						//vl_total_nf
						  '14330',									//nr_matricula_operador Deve continuar fixo 14330, pois, a conferencia pode ter sido feita por mais de um usu$$HEX1$$e100$$ENDHEX$$rio.
						  'N',										//id_produto_vencido
						  :ls_distribuidora_estoque,			//cd_distribuidora
						  :il_nr_pedido_distribuidora, 		//nr_pedido_distribuidora
						  :ll_nr_nsu,								//nr_nsu		
						  'N',										//id_atualizacao_mov_estoque
						  :ls_dados_adicionais,					//de_dados_adicionais
						  getdate(),								//dh_recebido_sap
						  'N',										//id_devolucao
						  :ls_id_almoxarifado,					//id_almoxarifado
						  :il_docnum,							// DocNum
						  :lvl_cd_centro_custo)				// Centro de Custo
		using sqlca;
			
		if sqlca.SqlCode = -1 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia' + '~nProblemas ao inserir "nf_transferencia": ~n' + sqlca.SqlErrText
			
			return false
		end if		
	Case 0
		update nf_transferencia  
			set cd_filial_destino				=:il_cd_filial_destino,   
				 dh_emissao					=:idh_emissao,   
				 dh_movimentacao_caixa	=:idh_movimentacao_caixa,   
				 vl_bc_icms						=:ldc_vl_bc_icms,   
				 vl_icms							=:ldc_vl_icms,   
				 vl_bc_icms_st					=:ldc_vl_bc_icms_st,   
				 vl_icms_st						=:ldc_vl_icms_st,   
				 vl_total_produtos				=:ldc_vl_total_produtos,   
				 vl_total_nf						=:idc_vl_total_nf,   
				 cd_distribuidora				=:ls_distribuidora_estoque,
				 nr_nsu							=:ll_nr_nsu,
				 de_dados_adicionais			=:ls_dados_adicionais,
				 nr_pedido_distribuidora		=:il_nr_pedido_distribuidora,
			 	 id_almoxarifado				=:ls_id_almoxarifado,
				 nr_documento_sap			=:il_docnum,
				 cd_centro_custo				=:lvl_cd_centro_custo
		 where nr_nf 				= :il_nr_nf
			and cd_filial_origem = :il_cd_filial
			and de_serie 			= :is_de_serie
			and de_especie 		= :is_de_especie;
			
		if sqlca.SqlCode = -1 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia' + '~nProblemas ao atualizar "nf_transferencia": ~n' + sqlca.SqlErrText
			
			return false
		end if	
	Case -1
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia' + '~nProblemas ao verificar existencia de "nf_transferencia": ~n' + sqlca.SqlErrText
			
		return false
End Choose
return true
end function

public function boolean of_insere_nf_transferencia_nfe (ref string ps_log);Long	ll_exists	= 0

select top 1 1
  into :ll_exists
  from nf_transferencia_nfe
 where cd_filial_origem	= :il_cd_filial and	
 		 nr_nf 				= :il_nr_nf and
		 de_especie			= :is_de_especie and	
		 de_serie			= :is_de_serie
 using sqlca;

if sqlca.SqlCode < 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_nfe' + '~nProblemas ao buscar "nf_transferencia_nfe": ~n' + sqlca.SqlErrText
	
	return false
end if


if ll_exists = 0 then
	INSERT INTO nf_transferencia_nfe  
         ( cd_filial_origem,   
           nr_nf,   
           de_especie,   
           de_serie,   
           de_chave_acesso,   
           qt_volume,
			  dh_envio,
			  nr_protocolo_envio,
			  id_situacao,
			  id_xml_enviado_email)  
  VALUES ( :il_cd_filial,   
           :il_nr_nf,   
           :is_de_especie,   
           :is_de_serie,   
           :is_nr_chave_acesso,   
           :il_qt_volume,
			  :idh_envio,
			  :is_nr_protocolo_envio,
			  'A',
			  'S');
else 
	update nf_transferencia_nfe
		set qt_volume 					= :il_qt_volume,
			 de_chave_acesso			= :is_nr_chave_acesso,
			 dh_envio					= :idh_envio,
			 nr_protocolo_envio		= :is_nr_protocolo_envio,
			 id_situacao				= 'A',
			 id_xml_enviado_email	= 'S'
	 where cd_filial_origem	= :il_cd_filial and	
			 nr_nf 				= :il_nr_nf and
			 de_especie			= :is_de_especie and	
			 de_serie			= :is_de_serie
	 using sqlca;
end if

if sqlca.SqlCode = -1 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_nfe' + '~nProblemas ao atualizar "nf_transferencia_nfe": ~n' + sqlca.SqlErrText
	
	return false
end if

return true
end function

public function boolean of_insere_nf_transferencia_produto (ref string ps_log);Boolean	lb_atualizou_compra	= false
DateTime	ldh_exportacao_sap

Dec{2}	ldc_faturada, ldc_pc_desconto, ldc_vl_desconto, &
			ldc_vl_bc_icms, ldc_pc_icms, ldc_vl_icms, ldc_vl_bc_icms_st, ldc_pc_icms_st, ldc_vl_icms_st, &
			ldc_total_vl_bc_icms, ldc_total_vl_icms, ldc_total_vl_frete, ldc_total_vl_desconto, ldc_vl_bc_pis, &
			ldc_pc_pis, ldc_vl_pis, ldc_vl_bc_cofins, ldc_pc_cofins, ldc_vl_cofins, ldc_vl_total_item, ldc_vl_total_itens, &
			ldc_vl_bc_st, ldc_pc_st, ldc_vl_st, ldc_preco_venda_maximo, ldc_pc_reducao_base_st, ldc_pc_mva, &
			ldc_vl_preco_unitario_aux, ldc_pc_fcp, ldc_vl_fcp, ldc_pc_red_icms, ldc_bc_antecipacao, &
			ldc_pc_mva_antecipacao, ldc_pc_icms_antecipacao, ldc_vl_icms_antecipacao, ldc_vl_icms_operacao, &
			ldc_pc_icms_diferido, ldc_vl_icms_diferido, ldc_faturada_gravada, ldc_vl_bc_st_gravada, ldc_vl_st_gravada, &
			ldc_vl_bc_icms_gravada, ldc_vl_icms_gravada, ldc_vl_fcp_gravada, ldc_bc_antecipacao_gravada,	&
			ldc_vl_icms_antecipacao_gravada,	ldc_vl_icms_operacao_gravada, ldc_vl_icms_diferido_gravada, &
			ldc_total_vl_bc_st, ldc_total_vl_st, ldc_vl_st_array[], ldc_array_null[], ldc_vl_icst, &
			ldc_vl_total_itens_sem_st, ldc_pc_icst
Dec{6}	ldc_vl_preco_unitario, ldc_vl_preco_unitario_origem
Long 		ll_for, ll_total_itens, ll_cd_produto, ll_nr_item, ll_total_itens_imp, ll_cd_natureza_operacao, &
			ll_nr_item_legado, ll_for_imp, ll_exists, ll_nr_nota_origem, ll_cd_motivo_devolucao, ll_nr_nf_origem, &
			ll_qt_separada, ll_for_array_st
String	ls_cd_cst_origem, ls_cd_cst_tributacao, ls_cd_beneficio, ls_nr_lote, ls_tp_imp, ls_cd_natureza_operacao, &
			ls_tp_imp_lista[] = {'ICMS','PIS','COFI','IPI', 'ICST'}, ls_cd_produto_sap, ls_de_chave_acesso_origem, &
			ls_de_serie_origem, ls_de_especie_origem, ls_de_dados_adicionais, ls_contrato, ls_cd_situacao_tributaria, &
			ls_cst_pis, ls_cst_cofins, ls_id_situacao, ls_id_almoxarifado = 'N', ls_taxtyp, ls_cst, ls_cstreg, &
			ls_cclasstrib, ls_cclasstribreg

// Campos para o Retido
Dec {2}	ldc_pc_st_retido
Dec {6}   ldc_vl_bc_icms_st_retido,ldc_vl_icms_st_retido,ldc_vl_icms_retido 		


ll_total_itens = idc_uo_ds_base_item.RowCount()

if ll_total_itens > 0 then
	ldc_total_vl_bc_icms		= 0
	ldc_total_vl_icms			= 0
	ldc_total_vl_bc_st		= 0
	ldc_total_vl_st			= 0
	ldc_total_vl_frete		= 0
	ldc_total_vl_desconto	= 0

	for ll_for = 1 to ll_total_itens
		ll_nr_item					= idc_uo_ds_base_item.Object.nr_item[ll_for]
		
		ll_nr_item_legado			= Long(left(String(ll_nr_item), Len(String(ll_nr_item)) -1))
		
		ls_cd_natureza_operacao	= idc_uo_ds_base_item.Object.cd_natureza_operacao[ll_for]
		
		ll_cd_natureza_operacao	= Long(left(ls_cd_natureza_operacao, 4))
		
		ldc_faturada						= idc_uo_ds_base_item.Object.qt_produto[ll_for]
		ldc_vl_preco_unitario			= idc_uo_ds_base_item.Object.vl_preco_unitario[ll_for]
		ldc_pc_desconto					= idc_uo_ds_base_item.Object.pc_desconto[ll_for]
		ldc_vl_desconto					= idc_uo_ds_base_item.Object.vl_desconto[ll_for]
		ls_cd_cst_origem					= idc_uo_ds_base_item.Object.cd_cst_origem[ll_for]
		ls_cd_cst_tributacao				= idc_uo_ds_base_item.Object.cd_cst_tributacao[ll_for]
		ls_cd_beneficio					= idc_uo_ds_base_item.Object.cd_beneficio[ll_for]
		ls_cd_produto_sap					= idc_uo_ds_base_item.Object.cd_produto_sap[ll_for]
		ls_contrato							= idc_uo_ds_base_item.Object.contrato[ll_for]
		ls_cst								= idc_uo_ds_base_item.Object.cst[ll_for]
		ls_cstreg							= idc_uo_ds_base_item.Object.cstreg[ll_for]
		ls_cclasstrib						= idc_uo_ds_base_item.Object.cclasstrib[ll_for]
		ls_cclasstribreg					= idc_uo_ds_base_item.Object.cclasstribreg[ll_for]
		
		// 1317158 - Procurar o n$$HEX1$$fa00$$ENDHEX$$mero do pedido original
		If Sqlca.DataBase = 'homologa' then
			if not of_verifica_nr_pedido_original_reenviado(Ref is_nr_pedido_distribuidora) then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~rN$$HEX1$$e300$$ENDHEX$$o encontrado o pedido original (pedido_distribuidora.nr_pedido_distrib_reenvio_sap) do xPed: '+is_nr_pedido_distribuidora+' ~r' + sqlca.SqlErrText
				return false
			end if
		End If
				
		// Chamado 1510241-1:  Dados de Retido
		If ls_cd_cst_tributacao = '60' Then 
			ldc_vl_bc_icms_st_retido 	= idc_uo_ds_base_item.Object.vbcstret[ll_for]		 		//<vBCSTRet>
			ldc_vl_icms_st_retido 		= idc_uo_ds_base_item.Object.vicmsstret  [ll_for]	    		//<vICMSSTRet>
			ldc_pc_st_retido 				= idc_uo_ds_base_item.Object.pst  [ll_for]	         		//<pST>
			ldc_vl_icms_retido			= idc_uo_ds_base_item.Object.vicmssubstituto[ll_for]	//<vICMSSubstituto>
		Else
			// Campos Para Retido
			SetNull(ldc_vl_bc_icms_st_retido)
			SetNull(ldc_vl_icms_retido)
			SetNull(ldc_pc_st_retido)
			SetNull(ldc_vl_icms_st_retido)
		End If 			
				
		ls_cst_pis				= idc_uo_ds_base_item.Object.cd_cst_pis[ll_for]
		ls_cst_cofins			= idc_uo_ds_base_item.Object.cd_cst_cofins[ll_for]

		ll_total_itens_imp = idc_uo_ds_base_item_imp.Retrieve(is_mandt, il_docnum, il_nr_sequencial, ll_nr_item, ls_tp_imp_lista)
		
		if ll_total_itens_imp < 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~nErro ao consultar a ' + idc_uo_ds_base_item_imp.DataObject + '.'
			
			return false
		end if
		
		ldc_vl_bc_icms		= 0
		ldc_pc_icms			= 0
		ldc_vl_icms			= 0
		ldc_vl_bc_st		= 0
		ldc_pc_st			= 0
		ldc_vl_st			= 0
		ldc_pc_fcp			= 0
		ldc_vl_fcp			= 0
		ldc_pc_icst			= 0
		ldc_vl_icst			= 0
		ldc_vl_bc_pis		= 0
		ldc_pc_pis			= 0
		ldc_vl_pis			= 0
		ldc_vl_bc_cofins	= 0
		ldc_pc_cofins		= 0
		ldc_vl_cofins		= 0
		
		ldc_vl_st_array = ldc_array_null
		
		for ll_for_imp	= 1 to ll_total_itens_imp
			ls_tp_imp	= idc_uo_ds_base_item_imp.Object.taxgrp[ll_for_imp]
			ls_taxtyp	= idc_uo_ds_base_item_imp.Object.taxtyp[ll_for_imp]
			
			choose case ls_tp_imp
				case 'ICMS'
					ldc_vl_bc_icms	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_icms		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_icms		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_icms > 0 and ldc_vl_bc_icms <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + 'Foi encontrado valor de icms mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_icms <= 0 and ldc_vl_bc_icms > 0.10 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + 'Foi encontrado base de calculo de icms mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
				case 'PIS'
					ldc_vl_bc_pis	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_pis		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_pis		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_pis > 0 and ldc_vl_bc_pis <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + 'Foi encontrado valor de pis mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_pis <= 0 and ldc_vl_bc_pis > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + 'Foi encontrado base de calculo de pis mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
				case 'COFI'
					ldc_vl_bc_cofins	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_cofins		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_cofins		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_cofins > 0 and ldc_vl_bc_cofins <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + 'Foi encontrado valor de cofins mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_cofins <= 0 and ldc_vl_bc_cofins > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + 'Foi encontrado base de calculo de cofins mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
				case 'ICST'
					ldc_vl_bc_st	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_icst		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_icst		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_icst > 0 and ldc_vl_bc_st <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + 'Foi encontrado valor de st mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if IsNull(ldc_vl_icst) then ldc_vl_icst = 0
					
					if ls_taxtyp = 'ICS3' then
						ldc_vl_st	= ldc_vl_icst
						ldc_pc_st	= ldc_pc_icst
					else
						ldc_vl_fcp	= ldc_vl_icst
						ldc_pc_fcp	= ldc_pc_icst
					end if
					
					ldc_vl_st_array[UpperBound(ldc_vl_st_array) + 1]	= ldc_vl_icst
			end choose
		next
		
		If IsNull(ldc_vl_desconto) 	Then ldc_vl_desconto = 0
		If IsNull(ldc_vl_bc_icms) 		Then ldc_vl_bc_icms = 0
		If IsNull(ldc_vl_icms) 			Then ldc_vl_icms = 0
		If IsNull(ldc_vl_fcp) 			Then ldc_vl_fcp = 0
				
		// Na notas do legado os campos ficam nulos
		If ldc_preco_venda_maximo 	= 0 	Then SetNull(ldc_preco_venda_maximo)
		If ldc_pc_mva 						= 0	Then SetNull(ldc_pc_mva)
		If ldc_bc_antecipacao 			= 0	Then SetNull(ldc_bc_antecipacao)
		If ldc_pc_mva_antecipacao 		= 0 	Then SetNull(ldc_pc_mva_antecipacao)
		If ldc_pc_icms_antecipacao 		= 0 	Then SetNull(ldc_pc_icms_antecipacao)
		If ldc_vl_icms_antecipacao 		= 0 	Then SetNull(ldc_vl_icms_antecipacao)
							
		ldc_total_vl_bc_icms		+= ldc_vl_bc_icms
		ldc_total_vl_icms			+= ldc_vl_icms
		ldc_total_vl_bc_st		+= ldc_vl_bc_st
		ldc_total_vl_st			+= ldc_vl_st + ldc_vl_fcp
		ldc_total_vl_desconto	+= ldc_vl_desconto
		
		ldc_vl_preco_unitario_aux	= ldc_vl_preco_unitario
		
		ldc_vl_total_item	= (ldc_faturada * ldc_vl_preco_unitario) - ldc_vl_desconto
		
		ldc_vl_total_itens_sem_st	+= (ldc_faturada * ldc_vl_preco_unitario) - ldc_vl_desconto
		
		for ll_for_array_st = 1 to UpperBound(ldc_vl_st_array)
			ldc_vl_total_item += ldc_vl_st_array[ll_for_array_st]
		next

		ldc_vl_total_itens	+= ldc_vl_total_item
				
		if not iuo_ge473_comum.of_localiza_codigo_produto_legado(ls_cd_produto_sap, ref ll_cd_produto, ps_log) then return false
		
		If IsNull(ll_cd_natureza_operacao) or ll_cd_natureza_operacao = 0 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + 'A natureza da opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi informada na interface'
			return false
		End If
		
		select 1
		  into :ll_exists
		  from natureza_operacao
		 where cd_natureza_operacao	= :ll_cd_natureza_operacao
		 Using SqlCa;
		 		 
		if sqlca.SqlCode < 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~nErro ao localizar a natureza da opera$$HEX2$$e700e300$$ENDHEX$$o: ~n' + sqlca.SqlErrText
			return false
		end if
			
		if ll_exists = 0 or IsNull(ll_exists) then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~Natureza da opera$$HEX2$$e700e300$$ENDHEX$$o ' + String(ll_cd_natureza_operacao) + ' n$$HEX1$$e300$$ENDHEX$$o cadastrada.'
			return false
		end if
		
		ls_cd_situacao_tributaria = '0' + mid(ls_cd_cst_tributacao, 1,1)
		
		If IsNull(ls_cd_situacao_tributaria) or trim(ls_cd_situacao_tributaria) = '' Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~N$$HEX1$$e300$$ENDHEX$$o veio o c$$HEX1$$f300$$ENDHEX$$digo da situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria.'
			return false
		End If
		
		ldc_faturada_gravada					= 0
		ldc_vl_bc_st_gravada					= 0
		ldc_vl_st_gravada						= 0
		ldc_vl_bc_icms_gravada				= 0
		ldc_vl_icms_gravada					= 0
		ldc_vl_fcp_gravada					= 0
		ldc_bc_antecipacao_gravada		= 0
		ldc_vl_icms_antecipacao_gravada	= 0
		ldc_vl_icms_operacao_gravada		= 0
		ldc_vl_icms_diferido_gravada		= 0
		 
		select qt_transferida,
				 vl_bc_icms_st,
				 vl_icms_st,
				 vl_bc_icms,
				 vl_icms,
				 vl_fcp,
				 vl_bc_icms_antecipacao,
				 vl_icms_antecipacao,
				 vl_icms_operacao,
				 vl_icms_diferido
		  into :ldc_faturada_gravada,   					//qt_transferida
				 :ldc_vl_bc_st_gravada,					//vl_bc_icms_st
				 :ldc_vl_st_gravada,						//vl_icms_st
				 :ldc_vl_bc_icms_gravada,				//vl_bc_icms
				 :ldc_vl_icms_gravada,					//vl_icms
				 :ldc_vl_fcp_gravada,						//vl_fcp
				 :ldc_bc_antecipacao_gravada,			//vl_bc_icms_antecipacao
				 :ldc_vl_icms_antecipacao_gravada,	//vl_icms_antecipacao
				 :ldc_vl_icms_operacao_gravada,		//vl_icms_operacao
				 :ldc_vl_icms_diferido_gravada			//vl_icms_diferido
		  from item_nf_transferencia
		 where cd_filial_origem				= :il_cd_filial and
				 nr_nf							= :il_nr_nf and
				 de_especie						= :is_de_especie and
				 de_serie						= :is_de_serie and
				 cd_natureza_operacao		= :ll_cd_natureza_operacao and
				 cd_produto						= :ll_cd_produto;
		
		choose case sqlca.sqlcode
			case 0
				update item_nf_transferencia
					set qt_transferida				= :ldc_faturada,
						 vl_bc_icms_st					= :ldc_vl_bc_st,
						 vl_icms_st						= :ldc_vl_st + :ldc_vl_fcp,
						 pc_icms_st						= :ldc_pc_st + :ldc_pc_fcp,
						 vl_bc_icms						= :ldc_vl_bc_icms,
						 vl_icms							= :ldc_vl_icms,
						 vl_fcp							= :ldc_vl_fcp,
						 vl_bc_icms_antecipacao		= :ldc_bc_antecipacao,
						 vl_icms_antecipacao			= :ldc_vl_icms_antecipacao,
						 vl_icms_operacao				= :ldc_vl_icms_operacao,
						 vl_icms_diferido				= :ldc_vl_icms_diferido,
						 vl_preco_unitario_fiscal	= :ldc_vl_preco_unitario,
						 vl_bc_icms_st_retido 		= :ldc_vl_bc_icms_st_retido,
						 vl_icms_st_retido			= :ldc_vl_icms_st_retido,
           			 pc_st_retido 					= :ldc_pc_st_retido,
						 vl_icms_retido 				= :ldc_vl_icms_retido,
						 cd_cst_ibscbs					= :ls_cst,
						 cd_class_trib_ibscbs		= :ls_cclasstrib,
						 cd_cst_ibscbs_reg			= :ls_cstreg,
						 cd_class_trib_ibscbs_reg	= :ls_cclasstribreg
				 where cd_filial_origem				= :il_cd_filial and
						 nr_nf						= :il_nr_nf and
						 de_especie					= :is_de_especie and
						 de_serie					= :is_de_serie and
						 cd_natureza_operacao	= :ll_cd_natureza_operacao and
						 cd_produto					= :ll_cd_produto;
						 
				if sqlca.SqlCode <> 0 then 
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~nProblemas ao atualizar dados de nota j$$HEX1$$e100$$ENDHEX$$ inserida": ~n' + sqlca.SqlErrText
					
					return false
				end if
			case 100, 1
				insert into item_nf_transferencia  
						  (cd_filial_origem,   
							nr_nf,   
							de_especie,   
							de_serie,   
							cd_natureza_operacao,   
							cd_produto,   
							cd_filial_destino,   
							cd_situacao_tributaria,   
							qt_transferida,   
							vl_custo_unitario,
							vl_custo_gerencial,
							pc_icms,
							vl_bc_icms_st,
							vl_icms_st,
							vl_bc_icms,
							vl_icms,
							pc_icms_st,
							vl_preco_venda_maximo,
							pc_reducao_base_st,
							cd_cst_origem,
							cd_cst_tributacao,
							pc_mva,
							pc_fcp,
							vl_fcp,
							cd_cst_pis,
							cd_cst_cofins,
							pc_reducao_base_icms,
							vl_bc_icms_antecipacao,
							pc_mva_icms_antecipacao,
							pc_icms_antecipacao,
							vl_icms_antecipacao,
							nr_sequencial,
							cd_beneficio,
							vl_icms_operacao,
							pc_icms_diferido,
							vl_icms_diferido,
							vl_preco_unitario_fiscal,
							vl_bc_icms_st_retido, 	  
							vl_icms_st_retido,	  			
							pc_st_retido	,		
							vl_icms_retido,
							cd_cst_ibscbs,
							cd_class_trib_ibscbs,
						 	cd_cst_ibscbs_reg,
						 	cd_class_trib_ibscbs_reg)
				 values (:il_cd_filial,								//cd_filial_origem
							:il_nr_nf,   								//nr_nf
							:is_de_especie, 						//de_especie  
							:is_de_serie,   							//de_serie
							:ll_cd_natureza_operacao,   		//cd_natureza_operacao
							:ll_cd_produto,   						//cd_produto
							:il_cd_filial_destino,   					//cd_filial_destino
							:ls_cd_situacao_tributaria,   		//cd_situacao_tributaria
							:ldc_faturada,   						//qt_transferida
							Round(:ldc_vl_preco_unitario, 2),	//vl_custo_unitario
							Round(:ldc_vl_preco_unitario, 2),	//vl_custo_gerencial
							:ldc_pc_icms,							//pc_icms
							:ldc_vl_bc_st,							//vl_bc_icms_st
							:ldc_vl_st + :ldc_vl_fcp,				//vl_icms_st
							:ldc_vl_bc_icms,						//vl_bc_icms
							:ldc_vl_icms,							//vl_icms
							:ldc_pc_st + :ldc_pc_fcp,				//pc_icms_st
							:ldc_preco_venda_maximo,			//vl_preco_venda_maximo
							:ldc_pc_reducao_base_st,			//pc_reducao_base_st
							:ls_cd_cst_origem,					//cd_cst_origem
							:ls_cd_cst_tributacao,					//cd_cst_tributacao
							:ldc_pc_mva,							//pc_mva
							:ldc_pc_fcp,								//pc_fcp
							:ldc_vl_fcp,								//vl_fcp
							:ls_cst_pis,								//cd_cst_pis
							:ls_cst_cofins,							//cd_cst_cofins
							:ldc_pc_red_icms,						//pc_reducao_base_icms
							:ldc_bc_antecipacao,					//vl_bc_icms_antecipacao
							:ldc_pc_mva_antecipacao,			//pc_mva_icms_antecipacao
							:ldc_pc_icms_antecipacao,			//pc_icms_antecipacao
							:ldc_vl_icms_antecipacao,			//vl_icms_antecipacao
							:ll_for,									//nr_sequencial
							:ls_cd_beneficio,						//cd_beneficio
							:ldc_vl_icms_operacao,				//vl_icms_operacao
							:ldc_pc_icms_diferido,				//pc_icms_diferido
							:ldc_vl_icms_diferido,					//vl_icms_diferido
							:ldc_vl_preco_unitario,				//vl_preco_unitario_fiscal
							:ldc_vl_bc_icms_st_retido, 	         //vl_bc_icms_st_retido 
							:ldc_vl_icms_st_retido, 		 		 //vl_icms_st_retido 
				         :ldc_pc_st_retido, 			  			//pc_st_retido 
							:ldc_vl_icms_retido,		  			//vl_icms_retido 					
							:ls_cst,
						 	:ls_cclasstrib,
						 	:ls_cstreg,
						 	:ls_cclasstribreg)
				using Sqlca;
				
				if sqlca.SqlCode <> 0 then 
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~nProblemas ao inserir "item_nf_transferencia": ~n' + sqlca.SqlErrText
					
					return false
				end if
			case -1
				if sqlca.SqlCode <> 0 then 
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~nProblemas ao buscar dados de nota j$$HEX1$$e100$$ENDHEX$$ inserida": ~n' + sqlca.SqlErrText
					
					return false
				end if
		end choose
		
		if not of_insere_nf_transferencia_produto_lote(ps_log, ll_cd_natureza_operacao, ll_cd_produto, ldc_faturada) then
			return false
		end if
		
		if not of_grava_melhor_compra_distribuidora(ps_log, ll_cd_produto, ll_cd_natureza_operacao) then
			return false
		end if
	next
	
	if idc_vl_total_nf <> ldc_vl_total_itens then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~Valor da nota fiscal incompativel com o valor dos itens.'
		
		return false
	end if
	
	update nf_transferencia
		set vl_bc_icms						= :ldc_total_vl_bc_icms,
			 vl_icms							= :ldc_total_vl_icms,
			 vl_bc_icms_st					= :ldc_total_vl_bc_st,
			 vl_icms_st						= :ldc_total_vl_st,
			 vl_total_produtos				= :ldc_vl_total_itens_sem_st,
			 de_dados_adicionais			= :ls_de_dados_adicionais,
			 nr_itens							= :ll_total_itens
	  from nf_transferencia
	 where cd_filial_origem	= :il_cd_filial and
			 nr_nf				= :il_nr_nf and
			 de_serie			= :is_de_serie and
			 de_especie			= :is_de_especie;
			 
	if sqlca.SqlCode <> 0 then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~nProblemas ao atualizar "nf_transferencia": ~n' + sqlca.SqlErrText
		
		return false
	end if
	
	update pedido_distribuidora
		set id_situacao	= 'F'
	 where nr_pedido_distribuidora	= :il_nr_pedido_distribuidora;
			  
	if sqlca.SqlCode <> 0 then 
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~nProblemas ao atualizar "pedido_distribuidora": ~n' + sqlca.SqlErrText
		
		return false
	end if
	
	if is_id_tipo_nf = 'YC' then
		if not wf_atualiza_transf_cds(il_cd_filial, il_cd_filial_destino, FALSE, REF ps_log) then
			ps_log = 'Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de situa$$HEX2$$e700e300$$ENDHEX$$o da transfer$$HEX1$$ea00$$ENDHEX$$ncia. Err: ' + ps_log
			return false
		end if
		
		if not wf_movimenta_est_transf_cds(il_cd_filial, il_cd_filial_destino, REF ps_log) then
			ps_log = 'Erro na movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque. Err: ' + ps_log
			return false
		end if
	end if
	
elseif ll_total_itens = 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrado itens para serem inseridos na devolu$$HEX2$$e700e300$$ENDHEX$$o ' + idc_uo_ds_base_nota.DataObject + '.'
	
	return false
else
	ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto' + '~nErro ao consultar a ' + idc_uo_ds_base_nota.DataObject + '.'
	
	return false
end if

return true
end function

public function boolean of_insere_nf_diversa (ref string ps_log);Date		ld_dt_atual
DateTime	ldt_dh_vencto
Dec{2}	ldc_vl_bc_icms, ldc_vl_icms, ldc_vl_bc_icms_st, ldc_vl_icms_st, ldc_vl_total_produtos
Long		ll_nr_nsu, ll_null, ll_exists, ll_portador

String 	ls_dados_adicionais, ls_cd_cliente, ls_nr_titulo, ls_cd_tipo_documento

uo_Titulo luo_Titulo


ld_dt_atual	= Date(gf_getserverdate())

SetNull(ll_null)

ldc_vl_bc_icms				= 0
ldc_vl_icms					= 0
ldc_vl_bc_icms_st			= 0
ldc_vl_icms_st				= 0
ldc_vl_total_produtos	= 0

// Carreg ds de ITEM
If idc_uo_ds_base_item.Retrieve(is_mandt, il_docnum, il_nr_sequencial) <= 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrados itens na tabela [J_1BNFLIN]. '
	return false
End If

If Not This.of_localiza_chave_integracao(ref ps_log) Then Return False

If Not This.of_localiza_nat_operacao(1, ref ps_log) Then Return False

if not ivo_parametro.of_proximo_nsu(ref ll_nr_nsu) then return false

If Not This.of_localiza_agrupamento(ps_Log) Then Return False

If Not This.of_localiza_identificacao_nf_diversa(ps_log) Then Return False

If Not This.of_Determina_cd_Tipo_Documento(Ref ls_cd_tipo_documento, Ref ps_Log) Then Return False

Choose Case is_id_tipo_nf
	Case 'CM'
		If Not This.of_localiza_nf_origem(is_id_tipo_nf, ref ps_log) Then Return False
	Case 'Z6', 'ZI', 'ZJ'
		//Mais tarde aqui deve buscar o usu$$HEX1$$e100$$ENDHEX$$rio que fez o descarte ou o invent$$HEX1$$e100$$ENDHEX$$rio
End Choose

if il_nr_nf_origem = 0 then SetNull(il_nr_nf_origem)
if Trim(is_de_especie_origem) = '' then SetNull(is_de_especie_origem)
if Trim(is_de_serie_origem) = '' then SetNull(is_de_serie_origem)

if il_Nat_OPeracao = 5927 or il_Nat_OPeracao = 1949 then
	SetNull(il_nr_nf_origem)
	SetNull(is_de_especie_origem)
	SetNull(is_de_serie_origem)
end if

select 1
  into :ll_exists
  from nf_diversa
 where cd_filial_origem	= :il_cd_filial
	and nr_nf				= :il_nr_nf
	and de_especie			= :is_de_especie
   and de_serie			= :is_de_serie;
 
Choose Case SQLCA.SQLCode
	Case -1
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa' + '~n Erro ao localizar "nf_diversa": ~n' + sqlca.SqlErrText
			
		return false
	Case 0
		Update nf_diversa
			set cd_natureza_operacao 				= :il_Nat_OPeracao,
				 de_natureza_operacao 				= :is_Nat_Operacao,
				 dh_emissao 							= :idh_emissao,
				 dh_movimentacao_caixa 				= :idh_movimentacao_caixa,
				 vl_bc_icms 							= :ldc_vl_bc_icms,
				 vl_icms 								= :ldc_vl_icms,
				 vl_bc_icms_st 						= :ldc_vl_bc_icms_st,
				 vl_icms_st 							= :ldc_vl_icms_st,
				 vl_frete 								= 0,
				 vl_outras_despesas 					= 0,
				 vl_seguro 								= 0,
				 vl_total_produtos 					= :ldc_vl_total_produtos,
				 vl_total_nf 							= :idc_vl_total_nf,
				 nm_destinatario 						= :is_Nm_Fantasia,
				 nr_cgc_cpf 							= :is_CGC,
				 nr_inscricao_estadual 				= :is_IE,
				 nm_cidade 								= :is_cidade, 
				 nm_uf 									= :is_UF,
				 de_endereco 							= :is_Endereco,
				 de_bairro 								= :is_Bairro,
				 nr_cep 									= :is_CEP,
				 nr_telefone 							= :is_Fone,
				 dh_cancelamento 						= null,
				 de_dados_adicionais_1 				= :ls_dados_adicionais, 
				 de_dados_adicionais_2 				= null,
				 de_dados_adicionais_3 				= null,
				 de_dados_adicionais_4 				= null,
				 de_dados_adicionais_5 				= null,
				 vl_ipi 									= 0,
				 nr_nsu 									= :ll_nr_nsu, 
				 de_dados_adicionais_8 				= null,
				 de_dados_adicionais_7 				= null,
				 de_dados_adicionais_6 				= null,
				 cd_cidade 								= null,
				 de_email_envio_xml 					= null,
				 id_tipo_frete 						= null,
				 id_patrimonio 						= null,
				 cd_filial_destino 					= null,
				 nr_endereco 							= :is_NR_Endereco,
				 cd_filial_complementar 			= :il_cd_filial,
				 nr_nf_complementar 					= :il_nr_nf_origem,
				 de_especie_complementar			= :is_de_especie_origem,
				 de_serie_complementar 				= :is_de_serie_origem,
				 cd_tipo_documento 					= :ls_cd_tipo_documento,
				 de_motivo_cancelamento 			= null,
				 nr_matricula_operador 				= '14330',
				 cd_centro_custo 						= null,
				 cd_conta_financeira 				= null,
				 de_comentario_ajuste 				= null,
				 cd_motivo_ajuste 					= :il_Motivo_Dev,
				 id_ajusta_estoque 					= 'S',
				 cd_perfil_nf 							= null,
				 id_ajuste_auditoria 				= 'N',
				 nr_otc 									= null,
				 nr_vending_machine 					= null,
				 nr_sequencial_cliente_caixa 		= null,
				 id_movimenta_reserva 				= 'N',
				 id_sistema_novo						= 'S',
				 nr_agrupamento_dev_compra_wms	= :il_Agrup_Dev_Compra,
			  	 nr_documento_sap						= :il_docnum,
			  	 id_tipo_nf								= :is_id_tipo_nf
		 where cd_filial_origem	= :il_cd_filial
			and nr_nf				= :il_nr_nf
			and de_especie			= :is_de_especie
			and de_serie			= :is_de_serie;

		if sqlca.SqlCode = -1 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa' + '~nProblemas ao atualizar "nf_diversa": ~n' + sqlca.SqlErrText
			
			return false
		end if	
	Case 100
		INSERT INTO nf_diversa  
					( cd_filial_origem,   
					  nr_nf,   
					  de_especie,   
					  de_serie,   
					  cd_natureza_operacao,   
					  de_natureza_operacao,   
					  dh_emissao,   
					  dh_movimentacao_caixa,   
					  vl_bc_icms,   
					  vl_icms,   
					  vl_bc_icms_st,   
					  vl_icms_st,   
					  vl_frete,   
					  vl_outras_despesas,   
					  vl_seguro,   
					  vl_total_produtos,   
					  vl_total_nf,   
					  nm_destinatario,   
					  nr_cgc_cpf,   
					  nr_inscricao_estadual,   
					  nm_cidade,   
					  nm_uf,   
					  de_endereco,   
					  de_bairro,   
					  nr_cep,   
					  nr_telefone,   
					  dh_cancelamento,   
					  de_dados_adicionais_1,   
					  de_dados_adicionais_2,   
					  de_dados_adicionais_3,   
					  de_dados_adicionais_4,   
					  de_dados_adicionais_5,   
					  vl_ipi,   
					  nr_nsu,   
					  de_dados_adicionais_8,   
					  de_dados_adicionais_7,   
					  de_dados_adicionais_6,   
					  cd_cidade,   
					  de_email_envio_xml,   
					  id_tipo_frete,   
					  id_patrimonio,   
					  cd_filial_destino,   
					  nr_endereco,   
					  cd_filial_complementar,   
					  nr_nf_complementar,   
					  de_especie_complementar,   
					  de_serie_complementar,   
					  cd_tipo_documento,   
					  de_motivo_cancelamento,   
					  nr_matricula_operador,   
					  cd_centro_custo,   
					  cd_conta_financeira,   
					  de_comentario_ajuste,   
					  cd_motivo_ajuste,   
					  id_ajusta_estoque,   
					  cd_perfil_nf,   
					  id_ajuste_auditoria,   
					  nr_otc,   
					  dh_importacao_matriz,   
					  nr_vending_machine,   
					  nr_sequencial_cliente_caixa,   
					  id_movimenta_reserva,   
					  id_sistema_novo,
					  nr_agrupamento_dev_compra_wms,
					  dh_recebido_sap,
					  nr_documento_sap,
					  id_tipo_nf)  
		  VALUES ( :il_cd_filial,  						//cd_filial_origem
					  :il_nr_nf,   							//nr_nf
					  :is_de_especie,							//de_especie
					  :is_de_serie,							//de_serie 
					  :il_Nat_OPeracao,						//cd_natureza_operacao,   
					  :is_Nat_Operacao,						//de_natureza_operacao,   
					  :idh_emissao,   						//dh_emissao
					  :idh_movimentacao_caixa,   			//dh_movimentacao_caixa
					  :ldc_vl_bc_icms,						//vl_bc_icms
					  :ldc_vl_icms,							//vl_icms
					  :ldc_vl_bc_icms_st,					//vl_bc_icms_st
					  :ldc_vl_icms_st,						//vl_icms_st
					  0, 											//vl_frete,   
					  0, 											//vl_outras_despesas,   
					  0, 											//vl_seguro,    
					  :ldc_vl_total_produtos,				//vl_total_produtos
					  :idc_vl_total_nf,						//vl_total_nf
					  :is_Nm_Fantasia,						//nm_destinatario
					  :is_CGC,									//nr_cgc_cpf
					  :is_IE,  									//nr_inscricao_estadual 
					  :is_cidade,   							//nm_cidade
					  :is_UF,   								//nm_uf
					  :is_Endereco,							//de_endereco
					  :is_Bairro,								//de_bairro
					  :is_CEP,									//nr_cep
					  :is_Fone,									//nr_telefone
					  null,   									//dh_cancelamento
					  :ls_dados_adicionais,   				//de_dados_adicionais_1
					  null,   									//de_dados_adicionais_2
					  null,   									//de_dados_adicionais_3
					  null,   									//de_dados_adicionais_4
					  null,   									//de_dados_adicionais_5
					  0,   										//vl_ipi
					  :ll_nr_nsu,   							//nr_nsu
					  null,   									//de_dados_adicionais_8
					  null,										//de_dados_adicionais_7
					  null,   									//de_dados_adicionais_6
					  null,   									//cd_cidade
					  null,   									//de_email_envio_xml
					  null,   									//id_tipo_frete
					  null,   									//id_patrimonio
					  null,   									//cd_filial_destino
					  :is_NR_Endereco,						//nr_endereco
					  null,   									//cd_filial_complementar
					  :il_nr_nf_origem, 						//nr_nf_complementar
					  :is_de_especie_origem,  				//de_especie_complementar
					  :is_de_serie_origem,					//de_serie_complementar
					  :ls_cd_tipo_documento,				//cd_tipo_documento
					  null,   									//de_motivo_cancelamento
					  '14330',									//nr_matricula_operador   
					  null,   									//cd_centro_custo
					  null,   									//cd_conta_financeira
					  null,   									//de_comentario_ajuste
					  :il_Motivo_Dev,							//cd_motivo_ajuste
					  'S',   									//id_ajsuta_estoque
					  null,   									//cd_perfil_nf
					  'N',   									//id_ajusta_auditoria
					  null,   									//cd_perfil_nf
					  getdate(),   							//dh_importacao_matriz
					  null,   									//nr_vending_machine
					  null,   									//nr_sequencial_cliente_caixa
					  'N',   									//id_movimenta_reserva
					  'S',  										//id_sistema_novo
					  :il_Agrup_Dev_Compra,		 			//nr_agrupamento_dev_compra_wms,
					  getdate(),								//dh_recebido_sap
					  :il_docnum,								// DocNum
					  :is_id_tipo_nf							//id_tipo_nf
					  )
		using SQLCA;
		
		if sqlca.SqlCode = -1 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa' + '~nProblemas ao inserir "nf_diversa": ~n' + sqlca.SqlErrText
			
			return false
		end if			
End Choose

Choose Case is_id_tipo_nf
	Case 'SM', 'SC', 'RC', 'S5', 'CM' // Simples remessa, Remessa p/ conserto, Retorno remessa, Reentrada Transferencia
		// N$$HEX1$$e300$$ENDHEX$$o busca
		
	Case Else // Outras
		// Busca cliente e invent$$HEX1$$e100$$ENDHEX$$rio da integra$$HEX2$$e700e300$$ENDHEX$$o
		select 
			cd_cliente, 
			nr_inventario
		into 
			:ls_cd_cliente, 
			:il_inventario
		from 
			wms_int_sap
		where 
		 	nr_integracao = :il_nr_integracao;
		
		if sqlca.SqlCode <> 0 then 
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa' + '~nProblemas ao buscar wms_int_sap": ~n' + sqlca.SqlErrText
			
			return false
		end if
		
End Choose

If Not ivo_parametro.of_Localiza_Parametro("CD_PORTADOR_SICREDI", ref ll_portador) Then
	Return false
End If

return true
end function

public function boolean of_insere_nf_diversa_produto (ref string ps_log);Boolean	lb_inserindo_novo = false
DateTime	ldt_dh_validade, ldt_dh_fabricacao
Dec{2}	ldc_faturada, ldc_pc_desconto, ldc_vl_desconto, &
			ldc_vl_bc_icms, ldc_pc_icms, ldc_vl_icms, ldc_vl_bc_icms_st, ldc_pc_icms_st, ldc_vl_icms_st, &
			ldc_total_vl_bc_icms, ldc_total_vl_icms, ldc_vl_bc_pis, ldc_pc_pis, ldc_vl_pis, ldc_vl_bc_cofins, &
			ldc_pc_cofins, ldc_vl_cofins, ldc_vl_total_itens, &
			ldc_vl_bc_st, ldc_pc_st, ldc_vl_st, ldc_vl_bc_ipi, ldc_pc_ipi, ldc_vl_ipi
Dec{2}	ldc_bc_st_acumulada, ldc_st_acumulada, ldc_pc_st_acumulada, ldc_icms_acumulada
Dec{4}	ldc_vl_preco_unitario_origem
Dec{8}	ldc_vl_total_item, ldc_vl_preco_unitario, ldc_vl_preco_liquido
Integer	li_tip_movto, li_pulo_sequencial = 10
Long 		ll_for, ll_total_itens, ll_cd_produto, ll_nr_item, ll_total_itens_imp, ll_cd_natureza_operacao, &
			ll_nr_item_legado, ll_for_imp, ll_exists, ll_nr_nota_origem, ll_cd_motivo_devolucao, ll_nr_nf_origem, &
			ll_qt_separada, ll_nr_sequencial, ll_nr_ajuste_estoque, ll_nr_agrupamento, ll_count, ll_null, ll_qt_lote, &
			ll_cd_motivo_ajuste
String	ls_cd_cst_origem, ls_cd_cst_tributacao, ls_cd_beneficio, ls_nr_lote, ls_tp_imp, ls_cd_natureza_operacao, &
			ls_tp_imp_lista[] = {'ICMS','PIS','COFI','IPI', 'ICST'}, ls_cd_produto_sap, ls_de_chave_acesso_origem, &
			ls_de_serie_origem, ls_de_especie_origem, ls_de_dados_adicionais, ls_contrato, ls_cd_situacao_tributaria, &
			ls_cst_pis, ls_cst_cofins, ls_id_situacao, ls_id_almoxarifado = 'N', ls_de_produto, ls_de_unidade_medida, &
			ls_de_produto_sap, ls_de_unidade_sap, ls_nr_matricula_responsavel, ls_cst, ls_cstreg, &
			ls_cclasstrib, ls_cclasstribreg


SetNull(ll_null)

ll_total_itens = idc_uo_ds_base_item.Retrieve(is_mandt, il_docnum, il_nr_sequencial, is_id_tipo_nf)

if ll_total_itens > 0 then
	If is_id_tipo_nf = 'ZI' or is_id_tipo_nf = 'Z6' then
		SELECT cd_tipo_movimento
		  INTO :li_tip_movto
		  FROM tipo_movimento_estoque 
		 WHERE id_tipo_movimento = 'A'
			AND id_entrada_saida  = 'S'
			AND id_cancelamento   = 'N'
		 USING SQLCA;
		 
		Choose case SQLCA.SQLCode
			case 100
				ps_log = 'Objeto: ' + this.ClassName () + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi encontrado o tipo de movimento de estoque para nota de baixa de estoque.'
				Return False
			case -1
				ps_log = 'Objeto: ' + this.ClassName () + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nErro no acesso $$HEX1$$e000$$ENDHEX$$ tabela tipo_movimento_estoque: ~n' + SQLCA.SQLErrText
				Return False
		End choose
	End if
	
	ldc_total_vl_bc_icms		= 0
	ldc_total_vl_icms			= 0
	
	ll_nr_sequencial	= 0
	
	select nr_matricula_responsavel
	  into :ls_nr_matricula_responsavel
		from wms_int_sap
	  where nr_integracao = :il_nr_integracao;
	  
	Choose Case SQLCA.SQLCode
		Case -1
			ps_log = 'Objeto: ' + this.ClassName () + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nErro buscar respons$$HEX1$$e100$$ENDHEX$$vel na tabela wms_int_sap: ~n' + SQLCA.SQLErrText
			Return False
	End Choose

	for ll_for = 1 to ll_total_itens
		ll_nr_item					= idc_uo_ds_base_item.Object.nr_item[ll_for]
		
		ldc_faturada					= idc_uo_ds_base_item.Object.qt_produto[ll_for]
		ldc_vl_preco_unitario		= idc_uo_ds_base_item.Object.vl_preco_unitario[ll_for]
		ldc_vl_preco_liquido			= idc_uo_ds_base_item.Object.nfnet[ll_for]
		ldc_pc_desconto				= idc_uo_ds_base_item.Object.pc_desconto[ll_for]
		ldc_vl_desconto				= idc_uo_ds_base_item.Object.vl_desconto[ll_for]
		ls_de_produto_sap				= idc_uo_ds_base_item.Object.maktx[ll_for]
		ls_de_unidade_sap				= idc_uo_ds_base_item.Object.meins[ll_for]
		ls_cd_cst_origem				= idc_uo_ds_base_item.Object.cd_cst_origem[ll_for]
		ls_cd_cst_tributacao			= idc_uo_ds_base_item.Object.cd_cst_tributacao[ll_for]
		ls_cd_beneficio				= idc_uo_ds_base_item.Object.cd_beneficio[ll_for]
		ls_cd_produto_sap				= idc_uo_ds_base_item.Object.cd_produto_sap[ll_for]
		ls_contrato						= idc_uo_ds_base_item.Object.contrato[ll_for]
		il_nr_pedido_distribuidora	= Long(idc_uo_ds_base_item.Object.xped[ll_for])
		ls_cst_pis						= idc_uo_ds_base_item.Object.cd_cst_pis[ll_for]
		ls_cst_cofins					= idc_uo_ds_base_item.Object.cd_cst_cofins[ll_for]
		ls_cst							= idc_uo_ds_base_item.Object.cst[ll_for]
		ls_cstreg						= idc_uo_ds_base_item.Object.cstreg[ll_for]
		ls_cclasstrib					= idc_uo_ds_base_item.Object.cclasstrib[ll_for]
		ls_cclasstribreg				= idc_uo_ds_base_item.Object.cclasstribreg[ll_for]
		
		if ldc_vl_preco_unitario = 0 then
			ldc_vl_preco_unitario	= ldc_vl_preco_liquido
		end if
		
		if IsNull(ldc_vl_preco_unitario) /*or ldc_vl_preco_unitario = 0*/ then
			ps_log	= 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + 'Valor unit$$HEX1$$e100$$ENDHEX$$rio do produto ' + ls_cd_produto_sap + ' est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.'
			return false
		end if
		
		ll_total_itens_imp = idc_uo_ds_base_item_imp.Retrieve(is_mandt, il_docnum, il_nr_sequencial, ll_nr_item, ls_tp_imp_lista)
		
		if ll_total_itens_imp < 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nErro ao consultar a ' + idc_uo_ds_base_item_imp.DataObject + '.'
			
			return false
		end if
		
		If is_id_tipo_nf = 'CM' Then
			DELETE FROM 
				item_nf_diversa_lote
			WHERE 
				cd_filial_origem = :il_cd_filial
				AND nr_nf = :il_nr_nf
				AND de_especie	= :is_de_especie
				AND de_serie = :is_de_serie;
				
			If SQLCA.SQLCode <> 0 then 
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao deletar "item_nf_diversa_lote": ~n' + sqlca.SqlErrText
				
				return false
			End IF
		End If
		
		for ll_for_imp	= 1 to ll_total_itens_imp
			ls_tp_imp	= idc_uo_ds_base_item_imp.Object.taxgrp[ll_for_imp]
			
			ldc_vl_bc_icms		= 0
			ldc_pc_icms			= 0
			ldc_vl_icms			= 0
			ldc_vl_bc_pis		= 0
			ldc_pc_pis			= 0
			ldc_vl_pis			= 0
			ldc_vl_bc_cofins	= 0
			ldc_pc_cofins		= 0
			ldc_vl_cofins		= 0
			ldc_vl_bc_st		= 0
			ldc_pc_st			= 0
			ldc_vl_st			= 0
			
			choose case ls_tp_imp
				case 'ICMS'
					ldc_vl_bc_icms	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_icms		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_icms		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_icms > 0 and ldc_vl_bc_icms <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + 'Foi encontrado valor de icms mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_icms <= 0 and ldc_vl_bc_icms > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + 'Foi encontrado base de calculo de icms mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
				case 'PIS'
					ldc_vl_bc_pis	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_pis		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_pis		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_pis > 0 and ldc_vl_bc_pis <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + 'Foi encontrado valor de pis mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_pis <= 0 and ldc_vl_bc_pis > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + 'Foi encontrado base de calculo de pis mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
				case 'COFI'
					ldc_vl_bc_cofins	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_cofins		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_cofins		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_cofins > 0 and ldc_vl_bc_cofins <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + 'Foi encontrado valor de cofins mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_cofins <= 0 and ldc_vl_bc_cofins > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + 'Foi encontrado base de calculo de cofins mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
				case 'ICST'
					ldc_vl_bc_st	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_st		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_st		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_st > 0 and ldc_vl_bc_st <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + 'Foi encontrado valor de st mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_st <= 0 and ldc_vl_bc_st > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + 'Foi encontrado base de calculo de st mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
			end choose
		next
		
		if IsNull(ldc_vl_desconto) then ldc_vl_desconto = 0
		if IsNull(ldc_vl_st) then ldc_vl_st = 0
		if IsNull(ldc_vl_bc_icms) then ldc_vl_bc_icms = 0
		if IsNull(ldc_vl_icms) then ldc_vl_icms = 0
		if IsNull(ldc_vl_st) then ldc_vl_st = 0
		
		// Na notas do legado os campos ficam nulos				
		ldc_total_vl_bc_icms		+= ldc_vl_bc_icms
		ldc_total_vl_icms			+= ldc_vl_icms
				
		ldc_vl_total_item	= (ldc_faturada * ldc_vl_preco_unitario) - ldc_vl_desconto + ldc_vl_st

		ldc_vl_total_itens	+= ldc_vl_total_item
		
		If Pos(',ZS,Z4,SM,SC,RC,S5,', is_id_tipo_nf) > 0 Then
			SetNull(ll_cd_produto)
			ls_cd_produto_sap	=  gf_Tira_Zero_Esquerda(ls_cd_produto_sap)
			ll_nr_item = ll_nr_item / 10
		else
			if not iuo_ge473_comum.of_localiza_codigo_produto_legado(ls_cd_produto_sap, ref ll_cd_produto, ps_log) then return false
		end if
				
		ls_cd_situacao_tributaria = '0' + mid(ls_cd_cst_tributacao, 1,1)
		
		If IsNull(ls_cd_situacao_tributaria) or trim(ls_cd_situacao_tributaria) = '' Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~N$$HEX1$$e300$$ENDHEX$$o veio o c$$HEX1$$f300$$ENDHEX$$digo da situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria.'
			return false
		End If
		
		Choose Case is_id_tipo_nf
			Case 'SM', 'SC', 'RC', 'S5', 'CM' // Simples remessa, Remessa p/ conserto, Retorno remessa, Reentrada de Transfer$$HEX1$$ea00$$ENDHEX$$ncia
				// N$$HEX1$$e300$$ENDHEX$$o busca
				ll_nr_sequencial = ll_nr_item
				SetNull(ldt_dh_validade)
				SetNull(ldt_dh_fabricacao)
				
			Case Else // Outras
				// Busca dados do lote da integra$$HEX2$$e700e300$$ENDHEX$$o
				select nr_sequencial,
						 nr_lote,
						 nr_ajuste_estoque,
						 dh_validade,
						 dh_fabricacao,
						 cd_motivo_ajuste
				  into :ll_nr_sequencial,
						 :ls_nr_lote,
						 :ll_nr_ajuste_estoque,
						 :ldt_dh_validade,
						 :ldt_dh_fabricacao,
						 :ll_cd_motivo_ajuste
					from wms_int_sap_detalhe
				  where nr_integracao = :il_nr_integracao
					 and nr_sequencial = :ll_nr_item;
		
				if sqlca.SqlCode <> 0 then 
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao buscar wms_int_sap_detalhe": ~n' + sqlca.SqlErrText
					
					return false
				end if
		End Choose
		
		// Para SM, SC, RC, S5, tenta encontrar o produto na produto_geral primeiro e depois na wms_produto_sucata.
		If Pos(',SM,SC,RC,S5', is_id_tipo_nf) > 0 Then
			SELECT cd_produto
			INTO :ll_cd_produto
			FROM produto_geral
			WHERE cd_produto_sap	= :ls_cd_produto_sap;
			If SQLCA.SQLCode = 100 Then SetNull(ll_cd_produto) // Se n$$HEX1$$e300$$ENDHEX$$o encontrou, mant$$HEX1$$e900$$ENDHEX$$m NULL.
		End If
		
		If Pos(',ZS,Z4,SM,SC,RC,S5', is_id_tipo_nf) > 0 And isNull(ll_cd_produto) Then
			select top 1 de_tipo_produto,
					 cd_unidade_medida
			  into :ls_de_produto,
					 :ls_de_unidade_medida
			  from wms_produto_sucata
			 where cd_produto_sap	= :ls_cd_produto_sap;

	 		choose case sqlca.SqlCode
				case 100
					ls_de_produto			= ls_de_produto_sap
					ls_de_unidade_medida	= ls_de_unidade_sap
				case -1
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao buscar dados do produto sucata": ~n' + sqlca.SqlErrText
					
					return false
			end choose
		else
			select de_produto + " : " + de_apresentacao_estoque,
					 dbo.retorna_um_compra_sap(cd_produto)
			  into :ls_de_produto,
					 :ls_de_unidade_medida
			  from produto_geral
			 where cd_produto	= :ll_cd_produto;
			 
			if sqlca.SqlCode <> 0 then 
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao buscar dados do produto ": ~n' + sqlca.SqlErrText
				
				return false
			end if
		end if
		
		select 1
		  into :ll_exists
		  from item_nf_diversa
		 where cd_filial_origem	= :il_cd_filial
		   and nr_nf				= :il_nr_nf
			and de_especie			= :is_de_especie
			and de_serie			= :is_de_serie
			and cd_item				= :ll_nr_sequencial;
					  
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao localizar "item_nf_diversa": ~n' + sqlca.SqlErrText
					
				return false
			Case 0
				update item_nf_diversa
					set de_item							=	:ls_de_produto,
						 de_unidade_medida			=	:ls_de_unidade_medida,
						 qt_item							=	:ldc_faturada,
						 vl_preco_unitario			=	Round(:ldc_vl_preco_unitario,2),
						 vl_preco_unitario_fiscal	=	Round(:ldc_vl_preco_unitario,6),
						 pc_desconto					=	:ldc_pc_desconto,
						 pc_icms							=	:ldc_pc_icms,
						 cd_situacao_tributaria		=	:ls_cd_situacao_tributaria,
						 vl_bc_icms_st					=	:ldc_vl_bc_st,
						 vl_icms_st						=	:ldc_vl_st,
						 vl_bc_icms						=	:ldc_vl_bc_icms,
						 vl_icms							=	:ldc_vl_icms,
						 nr_classificacao_fiscal	=	null,
						 pc_ipi							=	:ldc_pc_ipi,
						 pc_icms_st						=	:ldc_pc_st,
						 vl_bc_icms_st_retido		=	null,
						 vl_icms_st_retido			=	null,
						 cd_bem							=	null,
						 vl_outras_despesas			=	0,
						 vl_bc_ipi						=	:ldc_vl_bc_ipi,
						 vl_ipi							=	:ldc_vl_ipi,
						 cd_cst_origem					=	:ls_cd_cst_origem,
						 cd_cst_tributacao			=	:ls_cd_cst_tributacao,
						 vl_bc_icms_st_auxiliar		=	null,
						 vl_icms_st_auxiliar			=	null,
						 vl_frete						=	0,
						 cd_cest							=	null,
						 cd_cst_pis						=	:ls_cst_pis,
						 cd_cst_cofins					=	:ls_cst_cofins,
						 vl_bc_pis						=	:ldc_vl_bc_pis,
						 vl_pis							=	:ldc_vl_pis,
						 vl_bc_cofins					=	:ldc_vl_bc_cofins,
						 vl_cofins						=	:ldc_vl_cofins,
						 nr_lote							=	:ls_nr_lote,
						 cd_produto						=	:ll_cd_produto,
						 nr_ajuste_estoque			=	:ll_nr_ajuste_estoque,
						 dh_validade					=	:ldt_dh_validade,
						 dh_fabricacao					=	:ldt_dh_fabricacao,
						 nr_etiqueta_preste			=	null,
						 id_tributada_manual			=	'N',
						 pc_st_retido					=	0,
						 vl_icms_retido				=	0,
						 cd_beneficio					=	:ls_cd_beneficio,
						 cd_mod_bc_st					=	'0',
						 pc_mva							=	null,
						 qt_retornada					=	null,
						 pc_reducao_base_icms		=	null,
						 vl_bc_icms_uf_destino		=	null,
						 pc_icms_fcp_uf_destino		=	null,
						 pc_icms_uf_destino			=	null,
						 pc_partilha					=	null,
						 vl_icms_fcp_uf_destino		=	null,
						 vl_icms_uf_destino			=	null,
						 vl_icms_uf_origem			=	null,
						 cd_cst_ibscbs					= :ls_cst,
						 cd_class_trib_ibscbs		= :ls_cclasstrib,
						 cd_cst_ibscbs_reg			= :ls_cstreg,
						 cd_class_trib_ibscbs_reg	= :ls_cclasstribreg
				 where cd_filial_origem	= :il_cd_filial
					and nr_nf				= :il_nr_nf
					and de_especie			= :is_de_especie
					and de_serie			= :is_de_serie
					and cd_item				= :ll_nr_sequencial;
					
				if sqlca.SqlCode <> 0 then 
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao atualizar "item_nf_diversa": ~n' + sqlca.SqlErrText
					
					return false
				end if

			Case 100
				lb_inserindo_novo	= True
				
				INSERT INTO item_nf_diversa  
							( cd_filial_origem,   
							  nr_nf,   
							  de_especie,   
							  de_serie,   
							  cd_item,   
							  de_item,   
							  de_unidade_medida,   
							  qt_item,   
							  vl_preco_unitario,   
							  vl_preco_unitario_fiscal,
							  pc_desconto,   
							  pc_icms,   
							  cd_situacao_tributaria,   
							  vl_bc_icms_st,   
							  vl_icms_st,   
							  vl_bc_icms,   
							  vl_icms,   
							  nr_classificacao_fiscal,   
							  pc_ipi,   
							  pc_icms_st,   
							  vl_bc_icms_st_retido,   
							  vl_icms_st_retido,   
							  cd_bem,   
							  vl_outras_despesas,   
							  vl_bc_ipi,   
							  vl_ipi,   
							  cd_cst_origem,   
							  cd_cst_tributacao,   
							  vl_bc_icms_st_auxiliar,   
							  vl_icms_st_auxiliar,   
							  vl_frete,   
							  cd_cest,   
							  cd_cst_pis,   
							  cd_cst_cofins,   
							  vl_bc_pis,   
							  vl_pis,   
							  vl_bc_cofins,   
							  vl_cofins,   
							  nr_lote,   
							  cd_produto,   
							  nr_ajuste_estoque,   
							  dh_validade,   
							  dh_fabricacao,   
							  nr_etiqueta_preste,   
							  id_tributada_manual,   
							  pc_st_retido,   
							  vl_icms_retido,   
							  cd_beneficio,   
							  cd_mod_bc_st,   
							  pc_mva,   
							  qt_retornada,   
							  pc_reducao_base_icms,   
							  vl_bc_icms_uf_destino,   
							  pc_icms_fcp_uf_destino,   
							  pc_icms_uf_destino,   
							  pc_partilha,   
							  vl_icms_fcp_uf_destino,   
							  vl_icms_uf_destino,   
							  vl_icms_uf_origem,
							  cd_cst_ibscbs,
 							  cd_class_trib_ibscbs,
						 	  cd_cst_ibscbs_reg,
						 	  cd_class_trib_ibscbs_reg)
				  VALUES ( :il_cd_filial,								//cd_filial_origem
							  :il_nr_nf,   								//nr_nf
							  :is_de_especie, 							//de_especie  
							  :is_de_serie,   							//de_serie
							  :ll_nr_sequencial,							//cd_item
							  :ls_de_produto,   							//de_item
							  :ls_de_unidade_medida,   				//de_unidade_medida
							  :ldc_faturada,   							//qt_item
							  Round(:ldc_vl_preco_unitario, 2),   	//vl_preco_unitario
							  Round(:ldc_vl_preco_unitario, 6),   	//vl_preco_unitario_fiscal
							  :ldc_pc_desconto, 							//pc_desconto  
							  :ldc_pc_icms,   							//pc_icms
							  :ls_cd_situacao_tributaria,   			//cd_situacao_tributaria
							  :ldc_vl_bc_st,								//vl_bc_icms_st
							  :ldc_vl_st,   								//vl_icms_st
							  :ldc_vl_bc_icms,  							//vl_bc_icms 
							  :ldc_vl_icms,   							//vl_icms
							  null,   										//nr_classificacao_fiscal
							  :ldc_pc_ipi,									//pc_ipi
							  :ldc_pc_st,   								//pc_icms_st
							  null,   										//vl_bc_icms_st_retido
							  null,   										//vl_icms_st_retido
							  null,   										//cd_bem
							  0,   											//vl_outras_despesas
							  :ldc_vl_bc_ipi,   							//vl_bc_ipi
							  :ldc_vl_ipi,   								//vl_ipi
							  :ls_cd_cst_origem,   						//cd_cst_origem
							  :ls_cd_cst_tributacao,   				//cd_cst_tributacao
							  null,   										//vl_bc_icms_st_auxiliar
							  null,   										//vl_icms_st_auxiliar
							  0,   											//vl_frete
							  null,   										//cd_cest
							  :ls_cst_pis,   								//cd_cst_pis
							  :ls_cst_cofins,   							//cd_cst_cofins
							  :ldc_vl_bc_pis,   							//vl_bc_pis
							  :ldc_vl_pis,   								//vl_pis
							  :ldc_vl_bc_cofins,   						//vl_bc_cofins
							  :ldc_vl_cofins,   							//vl_cofins
							  :ls_nr_lote,									//nr_lote
							  :ll_cd_produto,   							//cd_produto
							  :ll_nr_ajuste_estoque,					//nr_ajuste_estoque
							  :ldt_dh_validade,							//dh_validade
							  :ldt_dh_fabricacao,						//dh_fabricacao
							  null,   										//nr_etiqueta_preste
							  'N',   										//id_tributada_manual
							  0,   											//pc_st_retido
							  0,   											//vl_icms_retido
							  :ls_cd_beneficio,   						//cd_beneficio
							  '0',   										//cd_mod_bc_st
							  null,   										//pc_mva
							  null,   										//qt_retornada
							  null,   										//pc_reducao_base_icms
							  null,   										//vl_bc_icms_uf_destino
							  null,   										//pc_icms_fcp_uf_destino
							  null,   										//pc_icms_uf_destino
							  null,   										//pc_partilha
							  null,   										//vl_icms_fcp_uf_destino
							  null,   										//vl_icms_uf_destino
							  null,											//vl_icms_uf_origem 
							  :ls_cst,
 						 	  :ls_cclasstrib,
						 	  :ls_cstreg,
						 	  :ls_cclasstribreg);
		
				if sqlca.SqlCode <> 0 then 
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao inserir "item_nf_diversa": ~n' + sqlca.SqlErrText
					
					return false
				else					
					If is_id_tipo_nf = 'ZI' or is_id_tipo_nf = 'Z6' then
						DECLARE sp_movto PROCEDURE FOR sp_grava_movto_tribut_saida
							@p_filial_movimento  = :il_cd_filial,
							@p_produto           = :ll_cd_produto, 
							@p_nota              = :il_nr_nf,
							@p_filial            = :il_cd_filial,
							@p_fornecedor        = null,
							@p_especie           = :is_de_especie,
							@p_serie             = :is_de_serie,
							@p_sequencial        = :ll_nr_sequencial,
							@p_data_movimento    = :idh_movimentacao_caixa,
							@p_qtde_movimento    = :ldc_faturada,
							@p_tipo_movimento    = :li_tip_movto,
							@p_nota_compra       = null,
							@p_fornecedor_compra = null,
							@p_especie_compra    = null,
							@p_serie_compra      = null,
							@p_bc_st_acumulada   = 0 output,
							@p_st_acumulada      = 0 output,
							@p_pc_st_acumulada   = 0 output,
							@p_icms_acumulada    = 0 output
						USING SQLCA;
							
						EXECUTE sp_movto;
								
						If SQLCA.SQLCode = -1 then
							 ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nErro na [sp_grava_movto_tribut_saida]: ' + SQLCA.SQLErrText
							 Return False
						End if
								
						FETCH sp_movto
						 INTO :ldc_bc_st_acumulada,
						 		:ldc_st_acumulada,
								:ldc_pc_st_acumulada,
								:ldc_icms_acumulada;
						
						CLOSE sp_movto;
					End if
				end if
		End Choose
		
		//Inicio inser$$HEX2$$e700e300$$ENDHEX$$o lote
		if is_id_tipo_nf = 'Z6' then
			select 1
			  into :ll_exists
			  from item_nf_diversa_lote
			 where cd_filial_origem	= :il_cd_filial
				and nr_nf				= :il_nr_nf
				and de_especie			= :is_de_especie
				and de_serie			= :is_de_serie
				and cd_item				= :ll_nr_sequencial
				and nr_lote				= :ls_nr_lote;
				
			Choose Case SQLCA.SQLCode
				Case -1
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nErro ao localizar registros na tabela item_nf_diversa_lote: ' + SQLCA.SQLErrText
					Return False
				Case 100
					insert into item_nf_diversa_lote (
						cd_filial_origem,
						nr_nf,
						de_especie,
						de_serie,
						cd_item,
						nr_lote,
						qt_lote,
						dh_fabricacao,
						dh_validade)
					values (
						:il_cd_filial,
						:il_nr_nf,
						:is_de_especie,
						:is_de_serie,
						:ll_nr_sequencial,
						:ls_nr_lote,
						:ldc_faturada,
						:ldt_dh_fabricacao,
						:ldt_dh_validade);
						
					if SQLCA.SQLCode = -1 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nErro ao inserir registros na tabela item_nf_diversa_lote: ' + SQLCA.SQLErrText
						Return False
					end if
				Case 0
					update 
						item_nf_diversa_lote
					set 
						qt_lote	= :ldc_faturada,
						dh_fabricacao	= :ldt_dh_fabricacao,
						dh_validade	= :ldt_dh_validade
					where
						cd_filial_origem	= :il_cd_filial
						and nr_nf			= :il_nr_nf
						and de_especie		= :is_de_especie
						and de_serie		= :is_de_serie
						and cd_item			= :ll_nr_sequencial
						and nr_lote			= :ls_nr_lote;
						
					if SQLCA.SQLCode = -1 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nErro ao atualizar registros na tabela item_nf_diversa_lote: ' + SQLCA.SQLErrText
						Return False
					end if
			End Choose
		end if
		//Fim inser$$HEX2$$e700e300$$ENDHEX$$o lote
		
		//Inicio movimenta$$HEX2$$e700e300$$ENDHEX$$o estoque descarte
		if lb_inserindo_novo then
			if not this.of_movimenta_estoque(il_nr_nf, is_de_especie, is_de_serie, il_cd_filial, ll_nr_sequencial, ll_cd_motivo_ajuste, ls_nr_matricula_responsavel, REF ps_log) then
				Return False
			End If
		end if
		//Fim inser$$HEX2$$e700e300$$ENDHEX$$o estoque
	
		If is_id_tipo_nf = 'CM' Then
			ll_nr_sequencial	= 0
			
			DECLARE transferencia_origem CURSOR FOR
				SELECT
					intl.nr_lote, 
					intl.qt_lote, 
					intl.dh_validade
				 FROM
					item_nf_transferencia_lote intl
				 WHERE
					intl.cd_filial_origem = :il_cd_filial
					AND intl.nr_nf = :il_nr_nf_origem
					AND intl.de_especie = :is_de_especie_origem
					AND intl.de_serie = :is_de_serie_origem
					AND intl.cd_produto = :ll_cd_produto;
			
			OPEN transferencia_origem;
			
			FETCH
				transferencia_origem 
			INTO
				:ls_nr_lote, 
				:ll_qt_lote, 
				:ldt_dh_validade;
						  
			Do While SqlCa.SqlCode = 0
				ll_nr_sequencial += li_pulo_sequencial
	
				INSERT INTO
					item_nf_diversa_lote
				SELECT
					:il_cd_filial, 
					:il_nr_nf, 
					:is_de_especie, 
					:is_de_serie, 
					:ll_nr_sequencial, 
					:ls_nr_lote, 
					:ll_qt_lote, 
					null, 
					:ldt_dh_validade;
					
				If SQLCA.SQLCode <> 0 then 
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao inserir "item_nf_diversa_lote": ~n' + sqlca.SqlErrText
					
					return false
				End IF
					
				FETCH
					transferencia_origem 
				INTO
					:ls_nr_lote, 
					:ll_qt_lote, 
					:ldt_dh_validade;
			Loop
			
			CLOSE transferencia_origem;
			
			If is_id_tipo_nf = 'CM' and lb_inserindo_novo Then
				If not This.of_retorna_saldo_wms(ll_null, il_nr_nf, is_de_especie, is_de_serie, il_cd_filial, ll_null, ref ps_log) Then Return False
			End If		
		End If
	next
	
	SetNull(ll_nr_agrupamento)
	
	Choose Case is_id_tipo_nf
		Case 'SM', 'SC', 'RC', 'S5', 'CM' // Simples remessa, Remessa p/ conserto, Retorno remessa, Reentrada Transfer$$HEX1$$ea00$$ENDHEX$$ncia
			// N$$HEX1$$e300$$ENDHEX$$o consulta nem atualiza agrupamento p/ essas notas
			
		Case Else
			// Consulta agrupamento WMS
			select nr_agrupamento_dev_compra
			  into :ll_nr_agrupamento
			  from wms_int_sap
			 where nr_integracao	= :il_nr_integracao;
			
			if sqlca.SqlCode < 0 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o n$$HEX1$$fa00$$ENDHEX$$mero do agrupamento: ~n' + sqlca.SqlErrText
				return false
			end if
			
			// Atualiza
			if ll_nr_agrupamento > 0 then
				update nf_diversa
					set nr_agrupamento_dev_compra_wms	= :ll_nr_agrupamento
				 where cd_filial_origem	= :il_cd_filial and
						 nr_nf				= :il_nr_nf and
						 de_serie			= :is_de_serie and
						 de_especie			= :is_de_especie;
						 
				if sqlca.SqlCode <> 0 then
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao atualizar "nf_diversa": ~n' + sqlca.SqlErrText
					return false
				end if
			end if
			
	End Choose
	
	update nf_diversa
		set vl_bc_icms						= :ldc_total_vl_bc_icms,
			 vl_icms							= :ldc_total_vl_icms,
			 vl_total_produtos			= :ldc_vl_total_itens
	 where cd_filial_origem	= :il_cd_filial and
			 nr_nf				= :il_nr_nf and
			 de_serie			= :is_de_serie and
			 de_especie			= :is_de_especie;
			 
	if sqlca.SqlCode <> 0 then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao atualizar "nf_diversa": ~n' + sqlca.SqlErrText
		
		return false
	end if
	
	Choose Case is_id_tipo_nf
		Case 'SM', 'SC', 'RC', 'S5', 'CM' // Simples remessa, Remessa p/ conserto, Retorno remessa, Reentrada Transfer$$HEX1$$ea00$$ENDHEX$$ncia
			// N$$HEX1$$e300$$ENDHEX$$o atualiza integra$$HEX2$$e700e300$$ENDHEX$$o WMS para essas NFs
			
		Case Else
			update wms_int_sap
				set nr_nf						= :il_nr_nf,
					 de_especie					= :is_de_especie,
					 de_serie					= :is_de_serie,
					 nr_ano_documento_sap	= :il_nr_ano_documento_sap,
					 nr_documento_sap			= :is_nr_documento_sap,
					 dh_retorno_sap 			= getdate(),
					 cd_filial					= :il_cd_filial,
					 id_situacao				= 'P'
			 where nr_integracao	= :il_nr_integracao;
			 
			if sqlca.SqlCode <> 0 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao atualizar "wms_int_sap": ~n' + sqlca.SqlErrText
				return false
			end if
			
			ll_count	= 0
			
			select count(*)
			  into :ll_count
			  from wms_int_sap
			 where nr_agrupamento_dev_compra	= :ll_nr_agrupamento and
					 nr_nf 							is null;
			 
			if ll_nr_agrupamento > 0 and ll_count = 0 then
				update agrupamento_dev_compra
					set id_situacao = 'R', 
						 dh_alteracao_situacao = getdate()
				 where nr_agrupamento	= :ll_nr_agrupamento
				     and id_situacao <> 'R';
		
				if sqlca.SqlCode <> 0 then
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nProblemas ao atualizar "agrupamento_dev_compra": ~n' + sqlca.SqlErrText
					return false
				end if
			end if
		
	End Choose
	
elseif ll_total_itens = 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrado itens para serem inseridos na item_nf_diversa ' + idc_uo_ds_base_nota.DataObject + '.'
	
	return false
else
	ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nErro ao consultar a ' + idc_uo_ds_base_nota.DataObject + '.'
	
	return false
end if

return true
end function

public function boolean of_insere_nf_diversa_nfe (ref string ps_log);Long	ll_exists	= 0,&
		ll_contagem

select top 1 1
  into :ll_exists
  from nf_diversa_nfe
 where cd_filial_origem	= :il_cd_filial and	
 		 nr_nf 				= :il_nr_nf and
		 de_especie			= :is_de_especie and	
		 de_serie			= :is_de_serie
 using sqlca;

if sqlca.SqlCode < 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_nfe' + '~nProblemas ao buscar "nf_transferencia_nfe": ~n' + sqlca.SqlErrText
	
	return false
end if

If Isnull(is_nr_protocolo_envio) or is_nr_protocolo_envio = '' Then
	ps_log = 'Erro na informa$$HEX2$$e700e300$$ENDHEX$$o do nr_protocolo_envio. N$$HEX1$$e300$$ENDHEX$$o pode ser nulo ou vazio.'
	Return False
Else 
	ll_contagem = len(is_nr_protocolo_envio)
	
	If ll_contagem <= 5 Then
		ps_log = 'Erro na informa$$HEX2$$e700e300$$ENDHEX$$o do nr_protocolo_envio. N$$HEX1$$e300$$ENDHEX$$o deve ter menos de 5 caracteres.'
		Return False
	End If
End If


if ll_exists = 0 then
  INSERT INTO nf_diversa_nfe  
         ( cd_filial_origem,   
           nr_nf,   
           de_especie,   
           de_serie,   
           de_chave_acesso, 
           qt_volume,
			  dh_envio,
			  nr_protocolo_envio,
			  id_situacao)  
  VALUES ( :il_cd_filial,
           :il_nr_nf,
           :is_de_especie,
           :is_de_serie,
           :is_nr_chave_acesso,
           :il_qt_volume,
			  :idh_envio,
			  :is_nr_protocolo_envio,
			  'A');
else
	update nf_diversa_nfe
		set qt_volume 				= :il_qt_volume,
			 de_chave_acesso		= :is_nr_chave_acesso,
			 dh_envio				= :idh_envio,
			 nr_protocolo_envio	= :is_nr_protocolo_envio,
			 id_situacao			= 'A'
	 where cd_filial_origem	= :il_cd_filial and	
			 nr_nf 				= :il_nr_nf and
			 de_especie			= :is_de_especie and	
			 de_serie			= :is_de_serie
	 using sqlca;
end if

if sqlca.SqlCode = -1 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_nfe' + '~nProblemas ao atualizar "nf_transferencia_nfe": ~n' + sqlca.SqlErrText
	
	return false
end if

return true
end function

public function boolean of_grava_nf_diversa (ref string ps_log);Long	ll_cd_produto, ll_total_linhas, ll_for, ll_qt_transferida, ll_qt_separada


ib_sucesso = false

if this.of_insere_nf_diversa(ps_log) then
	if this.of_insere_nf_diversa_nfe(ps_log) then
		if this.of_insere_nf_diversa_produto(ps_log) then
			If is_id_tipo_nf = 'ZI' or is_id_tipo_nf = 'ZJ' then
				If This.of_ajuste_definitivo_estoque (ps_log) then
					ib_sucesso	= true
				End if
			else
				ib_sucesso	= true
			End if
		end if
	end if
end If

return ib_sucesso
end function

public function boolean of_insere_nf_diversa_reentrada (ref string ps_log);Dec{2}	ldc_vl_bc_icms, ldc_vl_icms, ldc_vl_bc_icms_st, ldc_vl_icms_st, ldc_vl_total_produtos
Long		ll_nr_nsu, ll_null, ll_total_itens, ll_cd_natureza_operacao, ll_cd_cidade, ll_exists

String ls_distribuidora_estoque
String ls_dados_adicionais
String ls_cd_fornecedor

SetNull(ll_null)

ldc_vl_bc_icms		= 0
ldc_vl_icms			= 0
ldc_vl_bc_icms_st	= 0
ldc_vl_icms_st		= 0
ldc_vl_total_produtos	= 0

// Carreg ds de ITEM
If idc_uo_ds_base_item.Retrieve(is_mandt, il_docnum, il_nr_sequencial) <= 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_chave_integracao' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrados itens na tabela [J_1BNFLIN]. '
	return false
End If

If Not This.of_localiza_chave_integracao(ref ps_log) Then Return False

If Not This.of_localiza_nat_operacao(1, ref ps_log) Then Return False

ls_distribuidora_estoque = gvo_parametro.of_distribuidora_estoque()

if not ivo_parametro.of_proximo_nsu(ref ll_nr_nsu) then return false

If Not This.of_localiza_identificacao_nf_diversa(ps_log) Then Return False

// Localiza os dados da nota devolu$$HEX2$$e700e300$$ENDHEX$$o de compra
If Not This.of_localiza_nf_origem(is_id_tipo_nf, ref ps_log) Then Return False

If Not of_busca_endereco_cancelamento(ref ps_log) Then Return False

If is_categoria_nf_origem <> "" or Not IsNull(is_categoria_nf_origem) Then is_tipo_doc_dca = "DCA"

select de_endereco,
		 de_bairro,
		 nr_cep,
		 nr_telefone,
		 c.nm_cidade,
		 c.cd_unidade_federacao,
		 f.cd_fornecedor
  into :is_endereco,
		 :is_Bairro,
		 :is_CEP,
		 :is_Fone,
  		 :is_cidade,
		 :is_UF,
		 :ls_cd_fornecedor
  from fornecedor f
 inner join cidade c on c.cd_cidade = f.cd_cidade
 where (f.cd_fornecedor_sap	= :is_cd_fornecedor_sap or f.cd_fornecedor_sap	= '000000' + :is_cd_fornecedor_sap);
 
 Choose Case SQLCA.SQLCode
	Case -1
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_reentrada' + '~nProblemas ao buscar dados da tabela "fornecedor": ~n' + sqlca.SqlErrText
	
		return false
	Case 100
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_reentrada' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrados dados da tabela "fornecedor": ~n' + sqlca.SqlErrText
End Choose

if (il_Nat_OPeracao = 5927 or il_Nat_OPeracao = 1949) and is_id_tipo_nf <> 'ZM' then
	SetNull(il_nr_nf_origem)
	SetNull(is_de_especie_origem)
	SetNull(is_de_serie_origem)
end if

select 1
  into :ll_exists
  from nf_diversa
 where nr_nf	= :il_nr_nf
 	and cd_filial_origem	= :il_cd_filial
	and de_especie	= :is_de_especie
	and de_serie	= :is_de_serie;

Choose Case SQLCA.SQLCode
	Case -1
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_reentrada' + '~nProblemas ao buscar dados da tabela "nf_diversa": ~n' + SQLCA.SqlErrText
	
		return false
	Case 100
		INSERT INTO nf_diversa ( 
			cd_filial_origem,   
			nr_nf,   
			de_especie,   
			de_serie,   
			cd_natureza_operacao,   
			de_natureza_operacao,   
			dh_emissao,   
			dh_movimentacao_caixa,   
			vl_bc_icms,   
			vl_icms,   
			vl_bc_icms_st,   
			vl_icms_st,   
			vl_frete,   
			vl_outras_despesas,   
			vl_seguro,   
			vl_total_produtos,   
			vl_total_nf,   
			nm_destinatario,   
			nr_cgc_cpf,   
			nr_inscricao_estadual,   
			nm_cidade,   
			nm_uf,   
			de_endereco,   
			de_bairro,   
			nr_cep,   
			nr_telefone,   
			dh_cancelamento,   
			de_dados_adicionais_1,   
			de_dados_adicionais_2,   
			de_dados_adicionais_3,   
			de_dados_adicionais_4,   
			de_dados_adicionais_5,   
			vl_ipi,   
			nr_nsu,   
			de_dados_adicionais_8,   
			de_dados_adicionais_7,   
			de_dados_adicionais_6,   
			cd_cidade,   
			de_email_envio_xml,   
			id_tipo_frete,   
			id_patrimonio,   
			cd_filial_destino,   
			nr_endereco,   
			cd_filial_complementar,   
			nr_nf_complementar,   
			de_especie_complementar,   
			de_serie_complementar,   
			cd_tipo_documento,   
			de_motivo_cancelamento,   
			nr_matricula_operador,   
			cd_centro_custo,   
			cd_conta_financeira,   
			de_comentario_ajuste,   
			cd_motivo_ajuste,   
			id_ajusta_estoque,   
			cd_perfil_nf,   
			id_ajuste_auditoria,   
			nr_otc,   
			dh_importacao_matriz,   
			nr_vending_machine,   
			nr_sequencial_cliente_caixa,   
			id_movimenta_reserva,   
			id_sistema_novo,
			nr_agrupamento_dev_compra_wms,
			dh_recebido_sap,
			nr_documento_sap,
			id_finalidade_nfe )  
	  VALUES (
	  		:il_cd_filial,  					//cd_filial_origem
			:il_nr_nf,   						//nr_nf
			:is_de_especie,					//de_especie
			:is_de_serie,						//de_serie 
			:il_Nat_OPeracao,					//cd_natureza_operacao,   
			:is_Nat_Operacao,					//de_natureza_operacao,   
			:idh_emissao,   					//dh_emissao
			:idh_movimentacao_caixa,   	//dh_movimentacao_caixa
			:ldc_vl_bc_icms,					//vl_bc_icms
			:ldc_vl_icms,						//vl_icms
			:ldc_vl_bc_icms_st,				//vl_bc_icms_st
			:ldc_vl_icms_st,					//vl_icms_st
			0, 									//vl_frete,   
			0, 									//vl_outras_despesas,   
			0, 									//vl_seguro,    
			:ldc_vl_total_produtos,			//vl_total_produtos
			:idc_vl_total_nf,					//vl_total_nf
			:is_de_nome_dest,					//nm_destinatario
			:is_nr_cgc_dest,					//nr_cgc_cpf
			:is_nr_ie_dest,  					//nr_inscricao_estadual 
			:is_cidade,   						//nm_cidade
			:is_UF,   							//nm_uf
			:is_Endereco,						//de_endereco
			:is_Bairro,							//de_bairro
			:is_CEP,								//nr_cep
			:is_Fone,							//nr_telefone
			null,   								//dh_cancelamento
			:ls_dados_adicionais,   		//de_dados_adicionais_1
			null,   								//de_dados_adicionais_2
			null,   								//de_dados_adicionais_3
			null,   								//de_dados_adicionais_4
			null,   								//de_dados_adicionais_5
			0,   									//vl_ipi
			:ll_nr_nsu,   						//nr_nsu
			null,   								//de_dados_adicionais_8
			null,									//de_dados_adicionais_7
			null,   								//de_dados_adicionais_6
			null,   								//cd_cidade
			null,   								//de_email_envio_xml
			null,   								//id_tipo_frete
			null,   								//id_patrimonio
			null,   								//cd_filial_destino
			:is_NR_Endereco,					//nr_endereco
			:il_cd_filial,   					//cd_filial_complementar 
			:il_nr_nf_origem, 				//nr_nf_complementar
			:is_de_especie_origem,  		//de_especie_complementar
			:is_de_serie_origem,				//de_serie_complementar
			'DCD',								//cd_tipo_documento
			null,   								//de_motivo_cancelamento
			'14330',								//nr_matricula_operador   
			null,   								//cd_centro_custo
			null,   								//cd_conta_financeira
			null,   								//de_comentario_ajuste
			null,									//cd_motivo_ajuste
			'S',   								//id_ajsuta_estoque
			null,   								//cd_perfil_nf
			'N',   								//id_ajusta_auditoria
			null,   								//cd_perfil_nf
			getdate(),   						//dh_importacao_matriz
			null,   								//nr_vending_machine
			null,   								//nr_sequencial_cliente_caixa
			'N',   								//id_movimenta_reserva
			'S',  								//id_sistema_novo
			null, 								//nr_agrupamento_dev_compra_wms,
			getdate(),							//dh_recebido_sap
			:il_docnum,							// DocNum
			:is_doc_finalidade)           // finalidade da nota 
		USING SQLCA;
	
		if SQLCA.SqlCode = -1 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_reentrada' + '~nProblemas ao inserir "nf_diversa": ~n' + sqlca.SqlErrText
			
			return false
		end if	
	Case 0
		UPDATE 
			nf_diversa
		SET
			cd_natureza_operacao = :il_Nat_OPeracao,
			de_natureza_operacao = :is_Nat_Operacao,
			dh_emissao = :idh_emissao,
			dh_movimentacao_caixa = :idh_movimentacao_caixa,
			vl_bc_icms = :ldc_vl_bc_icms,
			vl_icms = :ldc_vl_icms,
			vl_bc_icms_st = :ldc_vl_bc_icms_st,
			vl_icms_st = :ldc_vl_icms_st,
			vl_total_produtos = :ldc_vl_total_produtos,
			vl_total_nf = :idc_vl_total_nf,
			nm_destinatario = :is_de_nome_dest,
			nr_cgc_cpf = :is_nr_cgc_dest,
			nr_inscricao_estadual = :is_nr_ie_dest,
			nm_cidade = :is_cidade,
			nm_uf = :is_UF,
			de_endereco = :is_Endereco,
			de_bairro = :is_Bairro,
			nr_cep = :is_CEP,
			nr_telefone = :is_Fone,
			de_dados_adicionais_1 = :ls_dados_adicionais,
			nr_nsu = :ll_nr_nsu,
			nr_endereco = :is_NR_Endereco,
			cd_filial_complementar = :il_cd_filial,
			nr_nf_complementar = :il_nr_nf_origem,
			de_especie_complementar = :is_de_especie_origem,
			de_serie_complementar = :is_de_serie_origem,
			de_motivo_cancelamento = null,
			nr_matricula_operador = '14330',
			id_ajusta_estoque = 'S',
			id_sistema_novo = 'S',
			dh_recebido_sap = getdate(),
			nr_documento_sap = :il_docnum,
			id_finalidade_nfe = :is_doc_finalidade
		WHERE
			nr_nf = :il_nr_nf
			AND cd_filial_origem = :il_cd_filial
			AND de_especie = :is_de_especie
			AND de_serie = :is_de_serie;
		
		if SQLCA.SqlCode = -1 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_reentrada' + '~nProblemas ao atualizar "nf_diversa": ~n' + sqlca.SqlErrText
			
			return false
		end if
End Choose

If not is_id_tipo_nf = 'LE' then
	update nf_devolucao_compra
		set dh_reentrada_mercadoria	= getdate()
	 where cd_fornecedor	= :ls_cd_fornecedor
		and cd_filial		= :il_cd_filial
		and nr_nf			= :il_nr_nf_origem
		and de_especie		= :is_de_especie_origem
		and de_serie		= :is_de_serie_origem;
	
	if sqlca.SqlCode = -1 Then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_reentrada' + '~nProblemas ao atualizar "nf_devolucao_compra" com a data da reentrada da mercadoria: ~n' + sqlca.SqlErrText
		
		return false
	end if
	
	if SQLCA.SQLNRows <= 0 Then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_reentrada' + '~nProblemas ao atualizar "nf_devolucao_compra" com a data da reentrada da mercadoria. Nenhuma linha foi atualizada.'
		
		return false
	End IF
end if

return true
end function

public function boolean of_insere_nf_diversa_produto_reentrada (ref string ps_log);Boolean	lb_calcular_unitario_pelo_total = False, lb_inserindo_novo	= True
Dec{2}	ldc_faturada, ldc_pc_desconto, ldc_vl_desconto, ldc_vl_bc_icms_othbas, &
			ldc_vl_bc_icms, ldc_pc_icms, ldc_vl_icms, ldc_vl_bc_icms_st, ldc_pc_icms_st, ldc_vl_icms_st, &
			ldc_total_vl_bc_icms, ldc_total_vl_icms, ldc_vl_bc_pis, ldc_pc_pis, ldc_vl_pis, ldc_vl_bc_cofins, &
			ldc_pc_cofins, ldc_vl_cofins, ldc_vl_total_item, ldc_vl_total_itens, &
			ldc_vl_bc_st, ldc_pc_st, ldc_vl_st, ldc_vl_bc_ipi, ldc_pc_ipi, ldc_vl_ipi, ldc_total_vl_ipi, &
			ldc_vl_diferenca, ldc_vl_total_item_nfnett
Dec{4}	ldc_vl_preco_unitario, ldc_vl_preco_unitario_origem, ldc_outras_despesas_item
Long 		ll_for, ll_total_itens, ll_cd_produto, ll_nr_item, ll_total_itens_imp, ll_cd_natureza_operacao, &
			ll_nr_item_legado, ll_for_imp, ll_exists, ll_nr_nota_origem, ll_cd_motivo_devolucao, ll_nr_nf_origem, &
			ll_qt_separada
String	ls_cd_cst_origem, ls_cd_cst_tributacao, ls_cd_beneficio, ls_nr_lote, ls_tp_imp, ls_cd_natureza_operacao, &
			ls_tp_imp_lista[] = {'ICMS','PIS','COFI','IPI', 'ICST'}, ls_cd_produto_sap, ls_de_chave_acesso_origem, &
			ls_de_serie_origem, ls_de_especie_origem, ls_de_dados_adicionais, ls_contrato, ls_cd_situacao_tributaria, &
			ls_cst_pis, ls_cst_cofins, ls_id_situacao, ls_id_almoxarifado = 'N', ls_de_produto, ls_de_unidade_medida, &
			ls_cst, ls_cstreg, ls_cclasstrib, ls_cclasstribreg

ll_total_itens = idc_uo_ds_base_item.Retrieve(is_mandt, il_docnum, il_nr_sequencial)


if ll_total_itens > 0 then
	ldc_total_vl_bc_icms		= 0
	ldc_total_vl_icms			= 0
	ldc_total_vl_ipi			= 0
	ldc_vl_total_itens		= 0

	for ll_for = 1 to ll_total_itens
		ll_nr_item					= idc_uo_ds_base_item.Object.nr_item[ll_for]
		
		ll_nr_item_legado			= Long(left(String(ll_nr_item), Len(String(ll_nr_item)) -1))
		
		ldc_faturada						= idc_uo_ds_base_item.Object.qt_produto[ll_for]
		ldc_vl_preco_unitario			= idc_uo_ds_base_item.Object.vl_preco_unitario[ll_for]
		ldc_vl_desconto					= idc_uo_ds_base_item.Object.nfdis[ll_for]
		ldc_vl_total_item_nfnett		= idc_uo_ds_base_item.Object.nfnett[ll_for]
		ldc_outras_despesas_item		= idc_uo_ds_base_item.Object.nfoth[ll_for]
		ls_cd_cst_origem					= idc_uo_ds_base_item.Object.cd_cst_origem[ll_for]
		ls_cd_cst_tributacao				= idc_uo_ds_base_item.Object.cd_cst_tributacao[ll_for]
		ls_cd_beneficio					= idc_uo_ds_base_item.Object.cd_beneficio[ll_for]
		ls_cd_produto_sap					= idc_uo_ds_base_item.Object.cd_produto_sap[ll_for]
		ls_contrato							= idc_uo_ds_base_item.Object.contrato[ll_for]
		il_nr_pedido_distribuidora		= Long(idc_uo_ds_base_item.Object.xped[ll_for])
		ls_cst_pis							= idc_uo_ds_base_item.Object.cd_cst_pis[ll_for]
		ls_cst_cofins						= idc_uo_ds_base_item.Object.cd_cst_cofins[ll_for]
		ls_cst								= idc_uo_ds_base_item.Object.cst[ll_for]
		ls_cstreg							= idc_uo_ds_base_item.Object.cstreg[ll_for]
		ls_cclasstrib						= idc_uo_ds_base_item.Object.cclasstrib[ll_for]
		ls_cclasstribreg					= idc_uo_ds_base_item.Object.cclasstribreg[ll_for]
		
		ldc_outras_despesas_item	= ldc_outras_despesas_item * ldc_faturada
		
		if lb_calcular_unitario_pelo_total then
			ldc_vl_preco_unitario	= ldc_vl_total_item_nfnett / ldc_faturada
			ldc_vl_desconto			= 0
		end if
										
		ll_total_itens_imp = idc_uo_ds_base_item_imp.Retrieve(is_mandt, il_docnum, il_nr_sequencial, ll_nr_item, ls_tp_imp_lista)
		
		if ll_total_itens_imp < 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto' + '~nErro ao consultar a ' + idc_uo_ds_base_item_imp.DataObject + '.'
			return false
		end if
		
		for ll_for_imp	= 1 to ll_total_itens_imp
			ls_tp_imp	= idc_uo_ds_base_item_imp.Object.taxgrp[ll_for_imp]
			
			choose case ls_tp_imp
				case 'ICMS'
					
					ldc_vl_bc_icms				= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_icms					= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_icms					= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					// Se tiver ICMS, mas n$$HEX1$$e300$$ENDHEX$$o possuir a base, tenta pegar a outras bases
					if ldc_vl_icms > 0 and ldc_vl_bc_icms <= 0 Then
						ldc_vl_bc_icms = ldc_vl_bc_icms_othbas
					End If
				case 'IPI' 
					
					ldc_vl_bc_ipi	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_ipi		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_ipi			= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					// Se tiver IPI, mas n$$HEX1$$e300$$ENDHEX$$o possuir a base, tenta pegar a outras bases
					if ldc_vl_ipi > 0 and ldc_vl_bc_ipi <= 0 Then
						ldc_vl_bc_ipi = ldc_vl_bc_icms_othbas
					End If
					
				case 'PIS'
					ldc_vl_bc_pis	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_pis		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_pis		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_pis > 0 and ldc_vl_bc_pis <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + 'Foi encontrado valor de pis mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_pis <= 0 and ldc_vl_bc_pis > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + 'Foi encontrado base de calculo de pis mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
					
				case 'COFI'
					ldc_vl_bc_cofins	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_cofins		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_cofins		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_cofins > 0 and ldc_vl_bc_cofins <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + 'Foi encontrado valor de cofins mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_cofins <= 0 and ldc_vl_bc_cofins > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + 'Foi encontrado base de calculo de cofins mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
				case 'ICST'
					ldc_vl_bc_st	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_st		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_st		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_st > 0 and ldc_vl_bc_st <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + 'Foi encontrado valor de st mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_st <= 0 and ldc_vl_bc_st > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + 'Foi encontrado base de calculo de st mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
			end choose
		next
		
		if IsNull(ldc_vl_desconto) then ldc_vl_desconto = 0
		if IsNull(ldc_vl_st) then ldc_vl_st = 0
		if IsNull(ldc_vl_bc_icms) then ldc_vl_bc_icms = 0
		if IsNull(ldc_vl_icms) then ldc_vl_icms = 0
		if IsNull(ldc_vl_st) then ldc_vl_st = 0
		
		// Na notas do legado os campos ficam nulos				
		ldc_total_vl_bc_icms	+= ldc_vl_bc_icms
		ldc_total_vl_icms		+= ldc_vl_icms
		ldc_total_vl_ipi			+= ldc_vl_ipi
				
		ldc_vl_total_item	= (ldc_faturada * ldc_vl_preco_unitario) - ldc_vl_desconto + ldc_vl_ipi + ldc_vl_st + ldc_outras_despesas_item
		
		ldc_pc_desconto = (ldc_vl_desconto / (ldc_faturada * ldc_vl_preco_unitario)) * 100

		ldc_vl_total_itens	+= ldc_vl_total_item
				
		if not iuo_ge473_comum.of_localiza_codigo_produto_legado(ls_cd_produto_sap, ref ll_cd_produto, ps_log) then return false
				
		ls_cd_situacao_tributaria = '0' + mid(ls_cd_cst_tributacao, 1,1)
		
		If IsNull(ls_cd_situacao_tributaria) or trim(ls_cd_situacao_tributaria) = '' Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + '~N$$HEX1$$e300$$ENDHEX$$o veio o c$$HEX1$$f300$$ENDHEX$$digo da situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria.'
			return false
		End If
		
		if is_id_tipo_nf = 'LE' then
			select de_tipo_produto,
					 cd_unidade_medida
			  into :ls_de_produto,
				    :ls_de_unidade_medida
		  	  from wms_produto_sucata
		 	 where cd_tipo_produto	= :ll_cd_produto;
		else
			select de_produto + " : " + de_apresentacao_estoque,
					 dbo.retorna_um_compra_sap(cd_produto)
			  into :ls_de_produto,
					 :ls_de_unidade_medida
			  from produto_geral
			 where cd_produto	= :ll_cd_produto;
		end if
		
		if sqlca.SqlCode <> 0 then 
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + '~nProblemas ao buscar dados do produto ": ~n' + sqlca.SqlErrText
			return false
		end if		
		
		select 1
		  into :ll_exists
		  from item_nf_diversa
		 where cd_filial_origem = :il_cd_filial
			and nr_nf 				= :il_nr_nf
			and de_especie 		= :is_de_especie
			and de_serie 			= :is_de_serie
			and cd_item 			= :ll_for;
		
		Choose Case SQLCA.SQlCode
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + '~nProblemas ao verificar exist$$HEX1$$ea00$$ENDHEX$$ncia da item_nf_diversa ": ~n' + sqlca.SqlErrText
				return false
			Case 0
				lb_inserindo_novo	= False
				
				UPDATE item_nf_diversa
					SET de_unidade_medida 			= :ls_de_unidade_medida,
						 qt_item 						= :ldc_faturada,
						 vl_preco_unitario 			= Round(:ldc_vl_preco_unitario, 2),
						 vl_preco_unitario_fiscal 	= Round(:ldc_vl_preco_unitario, 6),
						 pc_desconto 					= :ldc_pc_desconto,
						 pc_icms							= :ldc_pc_icms,
						 cd_situacao_tributaria 	= :ls_cd_situacao_tributaria,
						 vl_bc_icms_st 				= :ldc_vl_bc_st,
						 vl_icms_st 					= :ldc_vl_st,
						 vl_bc_icms						= :ldc_vl_bc_icms,
						 vl_icms 						= :ldc_vl_icms,
						 pc_ipi 							= :ldc_pc_ipi,
						 pc_icms_st 					= :ldc_pc_st,
						 vl_bc_ipi 						= :ldc_vl_bc_ipi,
						 vl_ipi 							= :ldc_vl_ipi,
						 cd_cst_origem 				= :ls_cd_cst_origem,
						 cd_cst_tributacao 			= :ls_cd_cst_tributacao,
						 cd_cst_pis 					= :ls_cst_pis,
						 cd_cst_cofins 				= :ls_cst_cofins,
						 vl_bc_pis 						= :ldc_vl_bc_pis,
						 vl_pis 							= :ldc_vl_pis,
						 vl_bc_cofins 					= :ldc_vl_bc_cofins,
						 vl_cofins 						= :ldc_vl_cofins,
						 cd_beneficio 					= :ls_cd_beneficio,
						 cd_cst_ibscbs					= :ls_cst,
						 cd_class_trib_ibscbs		= :ls_cclasstrib,
						 cd_cst_ibscbs_reg			= :ls_cstreg,
						 cd_class_trib_ibscbs_reg	= :ls_cclasstribreg
				 WHERE cd_filial_origem = :il_cd_filial
					AND nr_nf 				= :il_nr_nf
					AND de_especie 		= :is_de_especie
					AND de_serie 			= :is_de_serie
					AND cd_item 			= :ll_for;
					
				if sqlca.SqlCode <> 0 then 
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + '~nProblemas ao alterar "item_nf_diversa": ~n' + sqlca.SqlErrText
					
					return false
				end if
			Case 100
				lb_inserindo_novo	= True
				
				INSERT INTO item_nf_diversa  
							( cd_filial_origem,   
							  nr_nf,   
							  de_especie,   
							  de_serie,   
							  cd_item,   
							  de_item,   
							  de_unidade_medida,   
							  qt_item,   
							  vl_preco_unitario,   
							  vl_preco_unitario_fiscal,
							  pc_desconto,   
							  pc_icms,   
							  cd_situacao_tributaria,   
							  vl_bc_icms_st,   
							  vl_icms_st,   
							  vl_bc_icms,   
							  vl_icms,   
							  nr_classificacao_fiscal,   
							  pc_ipi,   
							  pc_icms_st,   
							  vl_bc_icms_st_retido,   
							  vl_icms_st_retido,   
							  cd_bem,   
							  vl_outras_despesas,   
							  vl_bc_ipi,   
							  vl_ipi,   
							  cd_cst_origem,   
							  cd_cst_tributacao,   
							  vl_bc_icms_st_auxiliar,   
							  vl_icms_st_auxiliar,   
							  vl_frete,   
							  cd_cest,   
							  cd_cst_pis,   
							  cd_cst_cofins,   
							  vl_bc_pis,   
							  vl_pis,   
							  vl_bc_cofins,   
							  vl_cofins,   
							  nr_lote,   
							  cd_produto,   
							  nr_ajuste_estoque,   
							  dh_validade,   
							  dh_fabricacao,   
							  nr_etiqueta_preste,   
							  id_tributada_manual,   
							  pc_st_retido,   
							  vl_icms_retido,   
							  cd_beneficio,   
							  cd_mod_bc_st,   
							  pc_mva,   
							  qt_retornada,   
							  pc_reducao_base_icms,   
							  vl_bc_icms_uf_destino,   
							  pc_icms_fcp_uf_destino,   
							  pc_icms_uf_destino,   
							  pc_partilha,   
							  vl_icms_fcp_uf_destino,   
							  vl_icms_uf_destino,   
							  vl_icms_uf_origem,
							  cd_cst_ibscbs,
							  cd_class_trib_ibscbs,
						 	  cd_cst_ibscbs_reg,
						 	  cd_class_trib_ibscbs_reg)
				  VALUES ( :il_cd_filial,								//cd_filial_origem
							  :il_nr_nf,   								//nr_nf
							  :is_de_especie, 							//de_especie  
							  :is_de_serie,   							//de_serie
							  :ll_for,										//cd_item
							  :ls_de_produto,				   			//de_item
							  :ls_de_unidade_medida,					//de_unidade_medida
							  :ldc_faturada,   							//qt_item
							  Round(:ldc_vl_preco_unitario, 2),   	//vl_preco_unitario
							  Round(:ldc_vl_preco_unitario, 6),   	//vl_preco_unitario_fiscal
							  :ldc_pc_desconto, 							//pc_desconto  
							  :ldc_pc_icms,   							//pc_icms
							  :ls_cd_situacao_tributaria,   			//cd_situacao_tributaria
							  :ldc_vl_bc_st,								//vl_bc_icms_st
							  :ldc_vl_st,   								//vl_icms_st
							  :ldc_vl_bc_icms,  							//vl_bc_icms 
							  :ldc_vl_icms,   							//vl_icms
							  null,   										//nr_classificacao_fiscal
							  :ldc_pc_ipi,									//pc_ipi
							  :ldc_pc_st,   								//pc_icms_st
							  null,   										//vl_bc_icms_st_retido
							  null,   										//vl_icms_st_retido
							  null,   										//cd_bem
							  0,   											//vl_outras_despesas
							  :ldc_vl_bc_ipi,   							//vl_bc_ipi
							  :ldc_vl_ipi,   								//vl_ipi
							  :ls_cd_cst_origem,   						//cd_cst_origem
							  :ls_cd_cst_tributacao,   				//cd_cst_tributacao
							  null,   										//vl_bc_icms_st_auxiliar
							  null,   										//vl_icms_st_auxiliar
							  0,   											//vl_frete
							  null,   										//cd_cest
							  :ls_cst_pis,   								//cd_cst_pis
							  :ls_cst_cofins,   							//cd_cst_cofins
							  :ldc_vl_bc_pis,   							//vl_bc_pis
							  :ldc_vl_pis,   								//vl_pis
							  :ldc_vl_bc_cofins,   						//vl_bc_cofins
							  :ldc_vl_cofins,   							//vl_cofins
							  :ls_nr_lote,									//nr_lote
							  :ll_cd_produto,   							//cd_produto
							  1,												//nr_ajuste_estoque
							  null,											//dh_validade
							  null,											//dh_fabricacao
							  null,   										//nr_etiqueta_preste
							  'N',   										//id_tributada_manual
							  0,   											//pc_st_retido
							  0,   											//vl_icms_retido
							  :ls_cd_beneficio,   						//cd_beneficio
							  '0',   										//cd_mod_bc_st
							  null,   										//pc_mva
							  null,   										//qt_retornada
							  null,   										//pc_reducao_base_icms
							  null,   										//vl_bc_icms_uf_destino
							  null,   										//pc_icms_fcp_uf_destino
							  null,   										//pc_icms_uf_destino
							  null,   										//pc_partilha
							  null,   										//vl_icms_fcp_uf_destino
							  null,   										//vl_icms_uf_destino
							  null,											//vl_icms_uf_origem 
							  :ls_cst,
						 	  :ls_cclasstrib,
						 	  :ls_cstreg,
						 	  :ls_cclasstribreg);
							  
			if SQLCA.SqlCode <> 0 then 
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + '~nProblemas ao inserir "item_nf_diversa": ~n' + sqlca.SqlErrText
				
				return false
			end if
		End Choose
		
		//Deleta e insere os lotes na nota fiscal diversa
		delete from item_nf_diversa_lote
				where cd_filial_origem	= :il_cd_filial
				  and nr_nf					= :il_nr_nf   		
				  and de_especie			= :is_de_especie
				  and de_serie				= :is_de_serie
				  and cd_item				= :ll_for;
					  
		if SQLCA.SqlCode <> 0 then 
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + '~nProblemas ao deletar "item_nf_diversa_lote": ~n' + sqlca.SqlErrText
			
			return false
		end if
		
		if is_id_tipo_nf = 'LE' then
			insert into item_nf_diversa_lote
			select :il_cd_filial, 
					 :il_nr_nf, 
					 :is_de_especie, 
					 :is_de_serie, 
					 :ll_for, 
					 'SEM LOTE', 
					 ind.qt_item, 
					 null, 
					 '2099-12-31'
			  from item_nf_diversa ind
			 where cd_filial_origem = :il_cd_filial 
				and nr_nf 				= :il_nr_nf_origem 
				and de_especie 		= :is_de_especie_origem 
				and de_serie 			= :is_de_serie_origem 
				and cd_item				= :ll_for;
		else
			insert into item_nf_diversa_lote
			select :il_cd_filial, 
					 :il_nr_nf, 
					 :is_de_especie, 
					 :is_de_serie, 
					 :ll_for, 
					 ndcpl.nr_lote, 
					 ndcpl.qt_lote, 
					 ndcpl.dh_fabricacao, 
					 ndcpl.dh_validade  
			  from nf_devolucao_compra_prd_lote ndcpl
			 where cd_filial 	= :il_cd_filial 
				and nr_nf 		= :il_nr_nf_origem 
				and de_especie = :is_de_especie_origem 
				and de_serie 	= :is_de_serie_origem 
				and nr_item 	= :ll_for;
		end if
			
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + '~nProblemas ao inserir registro na "item_nf_diversa_lote": ~n' + sqlca.SqlErrText
			
			return false
		End Choose
		
		// Reentrada
		If (is_id_tipo_nf = 'YA' or is_id_tipo_nf = 'ZM') and lb_inserindo_novo Then
			If not This.of_retorna_saldo_wms(ll_cd_produto, il_nr_nf, is_de_especie, is_de_serie, il_cd_filial, ll_for, ref ps_log) Then Return False
		End If
	Next
	
	update nf_diversa
		set vl_bc_icms				= :ldc_total_vl_bc_icms,
			 vl_icms					= :ldc_total_vl_icms,
			 vl_total_produtos	= :idc_vl_total_nf,
		 	 vl_ipi					= :ldc_total_vl_ipi
	 where cd_filial_origem	= :il_cd_filial and
			 nr_nf				= :il_nr_nf and
			 de_serie			= :is_de_serie and
			 de_especie			= :is_de_especie
	Using SqlCa;
			 
	if sqlca.SqlCode <> 0 then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + '~nProblemas ao atualizar "nf_diversa": ~n' + sqlca.SqlErrText
		return false
	end if
	
elseif ll_total_itens = 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrado itens para serem inseridos na devolu$$HEX2$$e700e300$$ENDHEX$$o ' + idc_uo_ds_base_nota.DataObject + '.'
	return false
else
	ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa_produto_reentrada' + '~nErro ao consultar a ' + idc_uo_ds_base_nota.DataObject + '.'
	return false
end if

return true
end function

public function boolean of_grava_nf_diversa_reentrada (ref string ps_log);Long	ll_cd_produto, ll_total_linhas, ll_for, ll_qt_transferida, ll_qt_separada


ib_sucesso = false

if this.of_insere_nf_diversa_reentrada(ps_log) then
	if this.of_insere_nf_diversa_nfe(ps_log) then
		if this.of_insere_nf_diversa_produto_reentrada(ps_log) then
			ib_sucesso	= true	
		end if
	end if
end If

return ib_sucesso
end function

public function boolean of_valida_tipo_nf_saida (string ps_id_tipo_operacao, ref string ps_log);Long		ll_total_itens, ll_cd_natureza_operacao
String	ls_cd_natureza_operacao


ll_total_itens = idc_uo_ds_base_item.Retrieve(is_mandt, il_docnum, il_nr_sequencial)

if ll_total_itens > 0 then
	ls_cd_natureza_operacao = idc_uo_ds_base_item.Object.cd_natureza_operacao[1]
	
	ll_cd_natureza_operacao	= Long(Left(ls_cd_natureza_operacao, 4))

	select id_operacao
	  into :ps_id_tipo_operacao
	  from natureza_operacao
	 where cd_natureza_operacao	= :ll_cd_natureza_operacao;
	 
	choose case SqlCa.Sqlcode
		case 100
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_tipo_nf_saida' + '~nN$$HEX1$$e300$$ENDHEX$$o foi localizado a natureza de opera$$HEX2$$e700e300$$ENDHEX$$o '+String(ll_cd_natureza_operacao) + '.'
			Return False
		case -1
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_tipo_nf_saida' + '~nErro ao localizar a natureza de opera$$HEX2$$e700e300$$ENDHEX$$o.' + SQLCA.SQLErrText
			return false
	end choose
else
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_tipo_nf_saida' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrados itens na NF recebida do SAP. '
	return false
end if

return true
end function

public function boolean of_grava_nf_venda (ref string ps_log);ib_sucesso	= false

if this.of_insere_nf_venda(ps_log) then
	if this.of_insere_nf_venda_nfe(ps_log) then
		if this.of_insere_nf_venda_produto(ps_log) then
			ib_sucesso	= true
		end if
	end if
end if

return ib_sucesso
end function

public function boolean of_insere_nf_venda (ref string ps_log);DateTime	ldt_dh_licitacao
Long		ll_nr_nsu, ll_total_itens, ll_nr_pedido, ll_cd_condicao_crediario
String	ls_nr_matricula_inclusao


if not ivo_parametro.of_proximo_nsu(ref ll_nr_nsu) then	return false

select cd_cliente
  into :is_cd_cliente
  from cliente
 where nr_cpf_cgc	= :is_nr_cgc;

choose case SqlCa.Sqlcode
	case 100
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nN$$HEX1$$e300$$ENDHEX$$o foi localizado cliente '+ is_nr_cgc + '.'
		Return False
	case -1
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nErro ao localizar o cliente.' + is_nr_cgc + ' ' + SQLCA.SQLErrText
		return false
end choose

ll_total_itens = idc_uo_ds_base_item.Retrieve(is_mandt, il_docnum, il_nr_sequencial)

if ll_total_itens > 0 then
	is_nr_pedido	= idc_uo_ds_base_item.Object.xped[1]
	
	if IsNull(is_nr_pedido) or Trim(is_nr_pedido) = '' then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nN$$HEX1$$e300$$ENDHEX$$o foi encontrado o n$$HEX1$$fa00$$ENDHEX$$mero de origem do pedido de venda/licita$$HEX2$$e700e300$$ENDHEX$$o recebida do SAP. '
		return false
	end if
else
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrados itens na nota de venda/licita$$HEX2$$e700e300$$ENDHEX$$o recebida do SAP. '
	return false
end if

ll_nr_pedido = Long(is_nr_pedido)

select nr_matricula_inclusao,
		 dh_licitacao,
		 cd_chave_movimento_wms
  into :ls_nr_matricula_inclusao,
  		 :ldt_dh_licitacao,
		 :is_chave_movimento_wms
  from licitacao_pedido
 where nr_pedido	= :ll_nr_pedido;

choose case SqlCa.Sqlcode
	case 100
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrados dados do or$$HEX1$$e700$$ENDHEX$$amento da venda/licita$$HEX2$$e700e300$$ENDHEX$$o recebida do SAP. '
		return false
		
	case -1
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nErro ao buscar dados do or$$HEX1$$e700$$ENDHEX$$amento da venda/licita$$HEX2$$e700e300$$ENDHEX$$o recebida do SAP. '+ SQLCA.SQLErrText
		return false
end choose

// Atualiza com os dados na NFD, em caso de cancelamento ser$$HEX1$$e300$$ENDHEX$$o requeridos pela trigger
if not IsNull(is_chave_movimento_wms) and Trim(is_chave_movimento_wms) <> '' then
	
	update wms_movimento_estoque
	set cd_filial = :il_cd_filial,  nr_nf = :il_nr_nf, de_especie =:is_de_especie, de_serie =:is_de_serie
	where cd_chave_movimento = :is_chave_movimento_wms
	Using SqlCa;
	
	if sqlca.SqlCode < 0 then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nProblemas ao atualizar os movimentos do WMS: ~n' + sqlca.SqlErrText
		return false
	end if

Else
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nN$$HEX1$$e300$$ENDHEX$$o foi localizado a chave do movimento do WMS. '
	return false
end if

update  licitacao_pedido
set id_situacao = 'F'
where nr_pedido = :ll_nr_pedido
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nErro a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido de licita$$HEX2$$e700e300$$ENDHEX$$o. '+ SQLCA.SQLErrText
	return false
End If

select lo.cd_condicao_crediario
  into :ll_cd_condicao_crediario
  from licitacao_orcamento lo inner join licitacao_pedido lp on lp.nr_orcamento = lo.nr_orcamento
 where lp.nr_pedido = :ll_nr_pedido;

choose case SqlCa.Sqlcode
	case 100
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nN$$HEX1$$e300$$ENDHEX$$o foram encontrados dados do or$$HEX1$$e700$$ENDHEX$$amento da venda/licita$$HEX2$$e700e300$$ENDHEX$$o recebida do SAP. '
	
		return false
	case -1
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nErro ao buscar dados do or$$HEX1$$e700$$ENDHEX$$amento da venda/licita$$HEX2$$e700e300$$ENDHEX$$o recebida do SAP. '+ SQLCA.SQLErrText
	
		return false
end choose
 
Insert Into nf_venda 
				( cd_filial, 
				  nr_nf,   
				  de_especie,   
				  de_serie,   
				  id_revenda,   
				  id_tipo_venda,
				  nr_matric_operador,
				  dh_emissao,   
				  dh_movimentacao_caixa,   
				  vl_bc_icms,   
				  vl_icms,   
				  vl_bc_icms_st,   
				  vl_icms_st,   
				  vl_total_produtos, 
				  vl_frete,
				  vl_outras_despesas,
				  pc_desconto,
				  vl_total_nf,
				  vl_pago_avista,
				  nr_matricula_vendedor, 
				  cd_condicao_crediario,
				  cd_cliente,
				  vl_total_nf_bruto,
				  vl_total_nf_tabela,
				  nr_nsu,
				  id_licitacao,
				  nr_matricula_licitacao,
				  dh_licitacao,
				  nr_pedido_licitacao,
				  de_dados_adicionais,
				  cd_canal_venda,
				  dh_recebido_sap,
				  nr_documento_sap
				)
		Values (:il_cd_filial, 					//cd_filial
				  :il_nr_nf,						//nr_nf
				  :is_de_especie,					//de_especie
				  :is_de_serie,					//de_serie
				  'N',								//id_revenda
				  'CR',								//id_tipo_venda
				  '14330',							//nr_matric_operador
				  :idh_emissao,					//dh_emissao
				  :idh_movimentacao_caixa,		//dh_movimentacao_caixa
				  0, 									//vl_bc_icms,
				  0,									//vl_icms
				  0,									//vl_bc_icms_st
				  0,									//vl_icms_st
				  0,									//vl_total_produtos
				  0, 									//vl_frete
				  0,									//vl_outras_despesas
				  0,									//pc_desconto
				  :idc_vl_total_nf,				//vl_total_nf
				  0,									//vl_pago_avista
				  '14330',							//nr_matricula_vendedor
				  :ll_cd_condicao_crediario,	//cd_condicao_crediario
				  :is_cd_cliente,					//cd_cliente
				  :idc_vl_total_nf,				//vl_total_nf_bruto
				  :idc_vl_total_nf,				//vl_total_nf_tabela
				  :ll_nr_nsu,						//nr_nsu
				  'S',								//id_licitacao
				  '14330',							//nr_matricula_licitacao
				  :ldt_dh_licitacao,				//dh_licitacao
				  :ll_nr_pedido,					//nr_pedido_licitacao
				  null,								//de_dados_adicionais
				  'LI',								//cd_canal_venda
				  getdate(),						//dh_recebido_sap
				  :il_docnum)					// Docnum 
Using Sqlca;
	
if sqlca.SqlCode = -1 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda' + '~nProblemas ao inserir "nf_venda": ~n' + sqlca.SqlErrText
	
	return false
end if

return true
end function

public function boolean of_insere_nf_venda_produto (ref string ps_log);Dec		ldc_total_vl_bc_icms, ldc_total_vl_icms, ldc_total_vl_frete, ldc_total_vl_desconto, ldc_total_vl_ipi, &
			ldc_vl_preco_unitario, ldc_vl_preco_unitario_fiscal, ldc_pc_desconto, ldc_vl_desconto, ldc_vl_frete, ldc_vl_bc_icms, ldc_pc_icms, &
			ldc_vl_icms, ldc_vl_bc_pis, ldc_pc_pis, ldc_vl_pis, ldc_vl_bc_cofins, ldc_pc_cofins, ldc_vl_cofins, &
			ldc_vl_bc_st, ldc_pc_st, ldc_vl_st, ldc_qt_vendida, ldc_vl_ipi, ldc_vl_preco_unitario_aux, &
			ldc_vl_total_item, ldc_vl_total_itens, ldc_icms_uf_destino, ldc_vl_bc_icms_uf_destino, &
			ldc_pc_icms_uf_destino, ldc_pc_icms_fcp_uf_destino, ldc_pc_partilha, ldc_vl_icms_fcp_uf_destino, &
			ldc_vl_icms_uf_destino, ldc_vl_icms_uf_origem, ldc_total_vl_bc_st, ldc_total_vl_st, ldc_pc_total_desconto
Long		ll_total_itens, ll_cd_natureza_operacao, ll_total_itens_imp, ll_for_imp, ll_for, ll_nr_item, &
			ll_cd_produto, ll_exists, ll_cd_cidade, ll_num_item
String	ls_cd_natureza_operacao, ls_cd_cst_origem, ls_cd_cst_tributacao, ls_cd_produto_sap, ls_tp_imp, &
			ls_tp_imp_lista[] = {'ICMS', 'PIS', 'COFI', 'ICST'}, ls_cd_situacao_tributaria, ls_cd_uf_destino, &
			ls_cd_cst_pis, ls_cd_cst_cofins, ls_cd_unidade_federacao, ls_cst, ls_cstreg, ls_cclasstrib, ls_cclasstribreg

select cd_cidade
  into :ll_cd_cidade
  from cliente
 where cd_cliente	= :is_cd_cliente;

select cd_unidade_federacao
  into :ls_cd_unidade_federacao
  from cidade
 where cd_cidade	= :ll_cd_cidade;

ll_total_itens = idc_uo_ds_base_item.Retrieve(is_mandt, il_docnum, il_nr_sequencial)

if ll_total_itens > 0 then
	ldc_total_vl_bc_icms		= 0
	ldc_total_vl_icms			= 0
	ldc_total_vl_frete		= 0
	ldc_total_vl_desconto	= 0
	ldc_total_vl_ipi			= 0
	ldc_total_vl_bc_st		= 0
	ldc_total_vl_st			= 0

	for ll_for = 1 to ll_total_itens
		ll_nr_item					= idc_uo_ds_base_item.Object.nr_item[ll_for]
		ll_num_item					= idc_uo_ds_base_item.Object.num_item[ll_for]
			
		ls_cd_natureza_operacao	= idc_uo_ds_base_item.Object.cd_natureza_operacao[ll_for]
		
		ll_cd_natureza_operacao	= Long(left(ls_cd_natureza_operacao, 4))
		
		
		ldc_qt_vendida						= idc_uo_ds_base_item.Object.qt_produto[ll_for]
		ldc_vl_preco_unitario			= Round(idc_uo_ds_base_item.Object.vl_preco_unitario[ll_for], 2)
		ldc_vl_preco_unitario_fiscal 	= Round(idc_uo_ds_base_item.Object.vl_preco_unitario[ll_for], 4)
		ldc_pc_desconto					= idc_uo_ds_base_item.Object.pc_desconto[ll_for]
		ldc_vl_desconto					= idc_uo_ds_base_item.Object.vl_desconto[ll_for]
		ldc_vl_frete						= idc_uo_ds_base_item.Object.vl_frete[ll_for]
		ls_cd_cst_origem					= idc_uo_ds_base_item.Object.cd_cst_origem[ll_for]
		ls_cd_cst_tributacao				= idc_uo_ds_base_item.Object.cd_cst_tributacao[ll_for]
		ls_cd_produto_sap					= idc_uo_ds_base_item.Object.cd_produto_sap[ll_for]
		ls_cd_cst_pis						= idc_uo_ds_base_item.Object.cd_cst_pis[ll_for]
		ls_cd_cst_cofins					= idc_uo_ds_base_item.Object.cd_cst_cofins[ll_for]
		ls_cst								= idc_uo_ds_base_item.Object.cst[ll_for]
		ls_cstreg							= idc_uo_ds_base_item.Object.cstreg[ll_for]
		ls_cclasstrib						= idc_uo_ds_base_item.Object.cclasstrib[ll_for]
		ls_cclasstribreg					= idc_uo_ds_base_item.Object.cclasstribreg[ll_for]
		
		ls_cd_situacao_tributaria = '0' + mid(ls_cd_cst_tributacao, 1,1)
		
		ll_total_itens_imp = idc_uo_ds_base_item_imp.Retrieve(is_mandt, il_docnum, il_nr_sequencial, ll_nr_item, ls_tp_imp_lista)
		
		if ll_total_itens_imp < 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + '~nErro ao consultar a ' + idc_uo_ds_base_item_imp.DataObject + '.'
			
			return false
		end if
		
		
		ldc_vl_bc_icms		= 0
		ldc_pc_icms			= 0
		ldc_vl_icms			= 0
		ldc_vl_bc_pis		= 0
		ldc_pc_pis			= 0
		ldc_vl_pis			= 0
		ldc_vl_bc_cofins	= 0
		ldc_pc_cofins		= 0
		ldc_vl_cofins		= 0
		ldc_vl_bc_st		= 0
		ldc_pc_st			= 0
		ldc_vl_st			= 0
		
		for ll_for_imp	= 1 to ll_total_itens_imp
			ls_tp_imp	= idc_uo_ds_base_item_imp.Object.taxgrp[ll_for_imp]
			
			choose case ls_tp_imp
				case 'ICMS'
					ldc_vl_bc_icms	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_icms		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_icms		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_icms > 0 and ldc_vl_bc_icms <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado valor de icms mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_icms <= 0 and ldc_vl_bc_icms > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado base de calculo de icms mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
				case 'PIS'
					ldc_vl_bc_pis	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_pis		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_pis		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_pis > 0 and ldc_vl_bc_pis <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado valor de pis mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_pis <= 0 and ldc_vl_bc_pis > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado base de calculo de pis mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
				case 'COFI'
					ldc_vl_bc_cofins	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_cofins		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_cofins		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_cofins > 0 and ldc_vl_bc_cofins <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado valor de cofins mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_cofins <= 0 and ldc_vl_bc_cofins > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado base de calculo de cofins mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
				case 'ICST'
					ldc_vl_bc_st	= idc_uo_ds_base_item_imp.Object.base[ll_for_imp]
					ldc_pc_st		= idc_uo_ds_base_item_imp.Object.rate[ll_for_imp]
					ldc_vl_st		= idc_uo_ds_base_item_imp.Object.taxval[ll_for_imp]
					
					if ldc_vl_st > 0 and ldc_vl_bc_st <= 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado valor de st mas n$$HEX1$$e300$$ENDHEX$$o foi encontrada a base de c$$HEX1$$e100$$ENDHEX$$lculo.'
						return false
					end if
					
					if ldc_vl_st <= 0 and ldc_vl_bc_st > 0 then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_produto' + 'Foi encontrado base de calculo de st mas n$$HEX1$$e300$$ENDHEX$$o foi encontrado valor.'
						return false
					end if
			end choose
		next
		
		if IsNull(ldc_vl_frete) then ldc_vl_frete = 0
		if IsNull(ldc_vl_desconto) then ldc_vl_desconto = 0
		if IsNull(ldc_vl_st) then ldc_vl_st = 0
		if IsNull(ldc_vl_ipi) then ldc_vl_ipi = 0
		if IsNull(ldc_vl_bc_icms) then ldc_vl_bc_icms = 0
		if IsNull(ldc_vl_icms) then ldc_vl_icms = 0
		if IsNull(ldc_vl_bc_st) then ldc_vl_bc_st = 0
		if IsNull(ldc_vl_st) then ldc_vl_st = 0
					
		ldc_total_vl_bc_icms		+= ldc_vl_bc_icms
		ldc_total_vl_icms			+= ldc_vl_icms
		ldc_total_vl_ipi			+= ldc_vl_ipi
		ldc_total_vl_frete		+= ldc_vl_frete
		ldc_total_vl_desconto	+= ldc_vl_desconto
		ldc_total_vl_bc_st		+= ldc_vl_bc_st
		ldc_total_vl_st			+= ldc_vl_st
		
		ldc_vl_preco_unitario_aux	= ldc_vl_preco_unitario
		
		ldc_vl_total_item	= (ldc_qt_vendida * ldc_vl_preco_unitario) - ldc_vl_desconto + ldc_vl_ipi + ldc_vl_st

		//ldc_vl_total_itens	+= ldc_vl_total_item
		ldc_vl_total_itens += round(Round(idc_uo_ds_base_item.Object.vl_preco_unitario[ll_for], 6) * ldc_qt_vendida, 2) - ldc_vl_desconto + ldc_vl_ipi + ldc_vl_st
				
		if not iuo_ge473_comum.of_localiza_codigo_produto_legado(ls_cd_produto_sap, ref ll_cd_produto, ps_log) then 
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda_produto' + '~nN$$HEX1$$e300$$ENDHEX$$o foi encontrado o c$$HEX1$$f300$$ENDHEX$$digo do produto do SAP no legado. Produto: ' + ls_cd_produto_sap
			
			return false
		end if
		
		Insert Into item_nf_venda (cd_filial,   
											nr_nf,   
											de_especie,   
											de_serie,   
											cd_natureza_operacao,   
											cd_produto,   
											cd_situacao_tributaria,   
											qt_vendida,   
											vl_preco_unitario,   
											pc_desconto_tabela,
											vl_preco_praticado,
											pc_icms,
											pc_comissao_extra,
											pc_comissao_normal,
											id_alteracao_preco,
											id_restricao_convenio,
											cd_cst_origem,
											cd_cst_tributacao,
											vl_preco_unitario_fiscal,
											cd_cst_pis,
											cd_cst_cofins,
											nr_sequencial,
											cd_cst_ibscbs,
											cd_class_trib_ibscbs)
	  							 Values (:il_cd_filial,						//cd_filial
										   :il_nr_nf,   						//nr_nf
										   :is_de_especie,   				//de_especie
										   :is_de_serie,   					//de_serie
										   :ll_cd_natureza_operacao,   	//cd_natureza_operacao
										   :ll_cd_produto,   				//cd_produto
										   :ls_cd_situacao_tributaria,	//cd_situacao_tributaria	
										   :ldc_qt_vendida,   				//qt_vendida
										   :ldc_vl_preco_unitario,   		//vl_preco_unitario
										   0,										//pc_desconto_tabela
										   :ldc_vl_preco_unitario,			//vl_preco_praticado
										   :ldc_pc_icms,						//pc_icms
										   0,										//pc_comissao_extra
										   0,										//pc_comissao_normal
										   'N',									//id_alteracao_preco
										   'N',									//id_restricao_convenio
										   :ls_cd_cst_origem,				//cd_cst_origem
										   :ls_cd_cst_tributacao,			//cd_cst_tributacao
										   :ldc_vl_preco_unitario,			//vl_preco_unitario_fiscal (possivelmente precisa ser ldc_vl_preco_unitario_fiscal, n$$HEX1$$e300$$ENDHEX$$o alterado ainda para n$$HEX1$$e300$$ENDHEX$$o gerar impactos)
										   :ls_cd_cst_pis,					//cd_cst_pis
										   :ls_cd_cst_cofins,				//cd_cst_cofins
										   :ll_num_item,						//num_item
											:ls_cst,
											:ls_cclasstrib)
		Using Sqlca;
		
		if sqlca.SqlCode = -1 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda_produto' + '~nProblemas ao inserir "item_nf_venda": ~n' + sqlca.SqlErrText
			
			return false
		end if
	next
	
	ldc_pc_total_desconto	= Round(ldc_total_vl_desconto / (ldc_vl_total_itens - ldc_total_vl_bc_st - ldc_vl_ipi + ldc_total_vl_desconto), 2)
	
	if idc_vl_total_nf <> ldc_vl_total_itens then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda_produto' + '~Valor da nota fiscal incompativel com o valor dos itens.'
		
		return false
	end if
	
	update nf_venda
		set vl_bc_icms				= :ldc_total_vl_bc_icms,
			 vl_icms					= :ldc_total_vl_icms,
			 vl_bc_icms_st			= :ldc_total_vl_bc_st,
			 vl_icms_st				= :ldc_total_vl_st,
			 vl_total_produtos	= :ldc_vl_total_itens,
			 vl_frete				= :ldc_total_vl_frete,
			 vl_outras_despesas	= 0,
			 pc_desconto			= :ldc_pc_total_desconto
	 where cd_filial		= :il_cd_filial and   
			 nr_nf			= :il_nr_nf and
			 de_especie		= :is_de_especie and
			 de_serie		= :is_de_serie; 
			 
	if sqlca.SqlCode = -1 Then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda_produto' + '~nProblemas ao atuaizar "nf_venda": ~n' + sqlca.SqlErrText
		
		return false
	end if
end if

return true
end function

public function boolean of_insere_nf_venda_nfe (ref string ps_log);Long	ll_exists


ll_exists	= 0

select top 1 1
  into :ll_exists
  from nf_venda_nfe
 where cd_filial	= :il_cd_filial and
 		 nr_nf		= :il_nr_nf and
		 de_especie	= :is_de_especie and
		 de_serie	= :is_de_serie;

if sqlca.SqlCode < 0 then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda_nfe' + '~nErro ao encontrar o venda nfe: ~n' + sqlca.SqlErrText
	
	return false
end if

if IsNull(is_nr_protocolo_envio) or Trim(is_nr_protocolo_envio) = '' then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_venda_nfe' + '~nN$$HEX1$$fa00$$ENDHEX$$mero de protocolo inv$$HEX1$$e100$$ENDHEX$$lido nfe: ~n' + sqlca.SqlErrText
	
	return false
end if

if ll_exists = 1 then
	update nf_venda_nfe
		set de_chave_acesso		= :is_nr_chave_acesso,
			 id_situacao			= :is_id_situacao, 
			 qt_volume				= :il_qt_volume, 
			 de_especie_volume	= :is_de_especie_volume, 
			 qt_peso_liquido		= :idc_qt_peso_liquido, 
			 qt_peso_bruto			= :idc_qt_peso_bruto,
			 dh_envio				= :idh_envio,
			 nr_protocolo_envio	= :is_nr_protocolo_envio
	 where cd_filial	= :il_cd_filial and
			 nr_nf		= :il_nr_nf and
			 de_especie	= :is_de_especie and
			 de_serie	= :is_de_serie;
else
	insert into nf_venda_nfe ( 
				cd_filial,
				nr_nf,
				de_especie,
				de_serie,
				de_chave_acesso,
				nr_protocolo_envio,
				nr_protocolo_cancelamento,
				dh_envio,
				id_situacao,
				dh_cancelamento,
				nr_matricula_cancelamento,
				cd_transportadora,
				de_placa_veiculo,
				cd_uf_veiculo,
				de_registro_antt,
				qt_volume,
				de_especie_volume,
				de_marca_volume,
				nr_volume,
				qt_peso_liquido,
				qt_peso_bruto,
				nr_protocolo_contingencia,
				dh_envio_contingencia )  
	 values (:il_cd_filial,					//cd_filial
				:il_nr_nf,						//nr_nf
				:is_de_especie,				//de_especie
				:is_de_serie,					//de_serie
				:is_nr_chave_acesso,			//de_chave_acesso
				:is_nr_protocolo_envio,		//nr_protocolo_envio
				null, 							//nr_protocolo_cancelamento
				null,								//dh_envio
				:is_id_situacao,				//id_situacao
				null,								//dh_cancelamento
				null,								//nr_matricula_cancelamento
				null,								//cd_transportadora
				null,								//de_placa_veiculo
				null,								//cd_uf_veiculo
				null,								//de_registro_antt
				:il_qt_volume,					//qt_volume
				:is_de_especie_volume,		//de_especie_volume
				null,								//de_marca_volume
				null,								//nr_volume
				:idc_qt_peso_liquido,		//qt_peso_liquido
				:idc_qt_peso_bruto,			//qt_peso_bruto
				null,								//nr_protocolo_contingencia
				null)								//dh_envio_contingencia
	using sqlca;
end if

if sqlca.SqlCode <> 0 then 
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_devolucao_compra_nfe' + '~nProblemas ao inserir/atualizar "nf_devolucao_compra_nfe": ~n' + sqlca.SqlErrText
	
	return false
end if

return true
end function

public function boolean of_processa_atualizacao (long pl_docnum);DateTime	ldh_credat
Boolean	lb_registro_pendente
Long 		ll_total_linhas, ll_nulo, ll_for
String 	ls_log, ls_cretim
Time		lt_create_time


SetNull(ll_nulo)

try
	if not idc_uo_ds_base_nota.of_changedataObject( 'ds_ge537_nota_fiscal' ) then 
		ls_log = 'Erro ao mudar a DW [ds_ge537_nota_fiscal].'
		return false
	end if
	
	if not idc_uo_ds_base_item.of_changedataObject( 'ds_ge537_nota_fiscal_item' ) then 
		ls_log = 'Erro ao mudar a DW [ds_ge537_nota_fiscal_item].'
		return false
	end If
	
	if not idc_uo_ds_base_item_imp.of_changedataObject( 'ds_ge537_nota_fiscal_item_imp' ) then 
		ls_log = 'Erro ao mudar a DW [ds_ge537_nota_fiscal_item_imp].'
		return false
	end If
	
	if not idc_uo_ds_base_item_lote.of_changedataObject( 'ds_ge537_pedido_dist_prd_lote' ) then 
		ls_log = 'Erro ao mudar a DW [ds_ge537_pedido_dist_prd_lote].'
		return false
	end If
		
	if not idc_melhor_compra.of_changedataObject( 'ds_ge537_melhor_compra' ) then 
		ls_log = 'Erro ao mudar a DW [ds_ge537_melhor_compra].'
		return false
	end If
	
	if not idc_valida_nf_transf.of_changedataObject( 'ds_ge537_valida_nf_transferencia' ) then 
		ls_log = 'Erro ao mudar a DW [ds_ge537_valida_nf_transferencia].'
		return false
	end If
	
	If Not IsNull(pl_docnum) and pl_docnum > 0 Then
		idc_uo_ds_base_nota.of_AppendWhere('jdoc.docnum = ' + String(pl_docnum)  )
	Else
		idc_uo_ds_base_nota.of_AppendWhere("(jdoc.id_status = 'C' or (jdoc.id_status = 'E' and jdoc.de_log like '%deadlock%'))"   ) //Precisamos melhorar o c$$HEX1$$f300$$ENDHEX$$digo referente aos deadlocks
	End If
			 
	ll_total_linhas = idc_uo_ds_base_nota.Retrieve()
	
	if ll_total_linhas < 0 Then
		ls_log = 'Objeto: ' + this.ClassName() + '. ~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao' + '~nProblemas ao executar retrieve na datawindow ' + idc_uo_ds_base_nota.DataObject + '.'
		
		return false
	elseif ll_total_linhas = 0 Then 
		return true
	end if
	
	for il_linha_nf = 1 to ll_total_linhas
		is_mandt 					= idc_uo_ds_base_nota.Object.mandt[il_linha_nf]
		il_docnum 					= idc_uo_ds_base_nota.Object.docnum[il_linha_nf]
		il_nr_sequencial 			= idc_uo_ds_base_nota.Object.nr_sequencial[il_linha_nf]
		
		if not ib_processo_paralelo and not ib_desenvolvimento then
			Run("C:\Sistemas\EX\Exe\ex.exe /AUTO/97P " + String(il_docnum))
		else
			// *** CANCELAMENTO emite uma NF com a categoria ZF
			// preechido quando $$HEX1$$e900$$ENDHEX$$ nota de cancelamento.
			il_docnum_ref					= idc_uo_ds_base_nota.Object.docref[il_linha_nf]		
			il_nr_nf							= idc_uo_ds_base_nota.Object.nr_nf[il_linha_nf]
			is_de_especie					= idc_uo_ds_base_nota.Object.de_especie[il_linha_nf]
			is_de_serie						= idc_uo_ds_base_nota.Object.de_serie[il_linha_nf]	
			idh_emissao						= idc_uo_ds_base_nota.Object.dh_emissao[il_linha_nf]
			idh_movimentacao_caixa		= idc_uo_ds_base_nota.Object.dh_movimentacao_caixa[il_linha_nf]
			is_id_tipo_nf					= idc_uo_ds_base_nota.Object.id_tipo_nf[il_linha_nf]
			idc_vl_total_nf					= idc_uo_ds_base_nota.Object.vl_total_nf[il_linha_nf]	
			is_nr_chave_acesso			= idc_uo_ds_base_nota.Object.nr_chave_acesso[il_linha_nf]
			il_qt_volume					= idc_uo_ds_base_nota.Object.qt_volume[il_linha_nf]
			is_de_especie_volume		= idc_uo_ds_base_nota.Object.de_especie_volume[il_linha_nf]
			idc_qt_peso_liquido			= idc_uo_ds_base_nota.Object.qt_peso_liquido[il_linha_nf]
			idc_qt_peso_bruto				= idc_uo_ds_base_nota.Object.qt_peso_bruto[il_linha_nf]
			is_id_situacao					= idc_uo_ds_base_nota.Object.id_situacao[il_linha_nf]
			is_cd_fornecedor_sap			= gf_Tira_Zero_Esquerda(idc_uo_ds_base_nota.Object.cd_fornecedor_sap[il_linha_nf])
			is_cd_parceiro_sap			= gf_Tira_Zero_Esquerda(idc_uo_ds_base_nota.Object.cd_parceiro_sap[il_linha_nf])
			is_cd_filial_sap					= idc_uo_ds_base_nota.Object.cd_filial_sap[il_linha_nf]
			il_nr_nota_chave_acesso		= idc_uo_ds_base_nota.Object.nr_nota_chave_acesso[il_linha_nf]
			il_nr_ano_documento_sap	= idc_uo_ds_base_nota.Object.nr_ano_documento_sap[il_linha_nf]
			is_nr_documento_sap			= idc_uo_ds_base_nota.Object.nr_documento_sap[il_linha_nf]
			is_nr_cgc						= idc_uo_ds_base_nota.Object.nr_cgc[il_linha_nf]
			ldh_credat						= idc_uo_ds_base_nota.Object.credat[il_linha_nf]
			ls_cretim							= idc_uo_ds_base_nota.Object.cretim[il_linha_nf]
			idh_envio						= DateTime(idc_uo_ds_base_nota.Object.dh_envio[il_linha_nf])
			is_nr_protocolo_envio			= idc_uo_ds_base_nota.Object.nr_protocolo_envio[il_linha_nf]
			is_doc_finalidade				= idc_uo_ds_base_nota.Object.doc_finalidade[il_linha_nf]
			is_nr_cgc_dest					= idc_uo_ds_base_nota.Object.nr_cgc_dest[il_linha_nf]
			is_de_nome_dest				= idc_uo_ds_base_nota.Object.de_nome_dest[il_linha_nf]
			is_nr_ie_dest					= idc_uo_ds_base_nota.Object.nr_ie_dest[il_linha_nf]
			is_cd_status_nfe				= idc_uo_ds_base_nota.Object.cd_status_nfe[il_linha_nf]
			is_id_estornado				= idc_uo_ds_base_nota.Object.id_estornado[il_linha_nf]
			
			if not iuo_ge473_comum.of_localiza_codigo_parceiro_legado(is_cd_parceiro_sap, il_cd_parceiro, REF ls_log) then
				Return False
			End if
			
			lt_create_time	= Time(mid(ls_cretim, 1,2) + ':' + mid(ls_cretim, 3,2) + ':' + mid(ls_cretim, 5,2))
			
			idh_emissao	= DateTime(Date(ldh_credat), lt_create_time)
			
			if IsNull(is_id_situacao) then is_id_situacao = '1'
			
			this.of_processa_doc(ref ls_log)
		end if
	next
catch ( runtimeerror  lo_rte )
	ls_log =  "Fun$$HEX2$$e700e300$$ENDHEX$$o [of_processa_atualizacao]. Erro: "+lo_rte.GetMessage( )

	return false
finally
	if IsValid(idc_uo_ds_base_nota) then destroy idc_uo_ds_base_nota
end try

return true
end function

public function boolean of_cancela_documento (ref string ps_log);Datetime ldh_Cancelamento
DateTime ldh_Recebido_SAP
Long ll_Nota, ll_exists, ll_null
String ls_Especie
String ls_Serie
String ls_Categoria_NF
Decimal lvdc_Total_NF


SetNull(ll_null)

ib_sucesso = false

If IsNull(il_docnum_ref) or il_docnum_ref = 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento ' + '~nDocumento refer$$HEX1$$ea00$$ENDHEX$$ncia nulo ou zerado'
End If

select coalesce(cast(jdoc2.nfenum as int), jdoc2.nfnum),
		 cast('NFE' as char(3)),
 		 coalesce(jdoc2.series, 'U'),
		 jdoc2.nftype
  Into :ll_Nota, 
	    :ls_Especie, 
	  	 :ls_Serie, 
	  	 :ls_Categoria_NF
  from j_1bnfdoc_1 as jdoc 
 inner join j_1bnfdoc_2 as jdoc2 on jdoc2.mandt				= jdoc.mandt 
										  and jdoc2.docnum 		 	= jdoc.docnum 
										  and jdoc2.nr_sequencial 	= jdoc.nr_sequencial
 where jdoc.docnum 	= :il_docnum_ref 
   and jdoc2.nftype 	in ('ZS', 'Z4', 'ZV', 'YB', 'YP', 'ZA', 'YA', 'ZM', 'YY', 'ZI', 'ZJ', 'LE', 'SM', 'SC', 'RC', 'S5', 'YC')
	and jdoc.id_substituida	= 'N'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0		
		// SUCATA
		If ls_Categoria_NF = 'ZS' or ls_Categoria_NF = 'Z4' or ls_Categoria_NF = 'LE' Then
			Select vl_total_nf, 
					 dh_cancelamento, 
					 dh_recebido_sap
			  Into :lvdc_Total_NF, 
					 :ldh_Cancelamento, 
					 :ldh_Recebido_SAP
			  From nf_diversa
			 Where cd_filial_origem	= :il_cd_filial
				and nr_nf 				= :ll_Nota
				and de_especie			= :ls_Especie
				and de_serie 			= :ls_Serie
			Using SqlCa;
		ElseIf ls_Categoria_NF = 'ZV' Then
			Select vl_total_nf, 
					 dh_cancelamento, 
					 dh_recebido_sap
			  Into :lvdc_Total_NF, 
					 :ldh_Cancelamento, 
					 :ldh_Recebido_SAP
			  From nf_venda
			 Where cd_filial 	= :il_cd_filial
				and nr_nf 		= :ll_Nota
				and de_especie	= :ls_Especie
				and de_serie 	= :ls_Serie
			Using SqlCa;
		ElseIf ls_Categoria_NF = 'YP' or ls_Categoria_NF = 'YB' or ls_Categoria_NF = 'YY' Then
			Select vl_total_nf, 
					 dh_cancelamento, 
					 dh_recebido_sap
			  Into :lvdc_Total_NF, 
					 :ldh_Cancelamento, 
					 :ldh_Recebido_SAP
			  From nf_devolucao_compra
			 Where cd_filial 		= :il_cd_filial
				and nr_nf 			= :ll_Nota
				and de_especie		= :ls_Especie
				and de_serie 		= :ls_Serie
			Using SqlCa;
		ElseIf ls_Categoria_NF = 'ZA' or ls_Categoria_NF = 'YC' Then
			select 1
			  into :ll_exists
			  from nf_transferencia
			 where cd_filial_origem	= :il_cd_filial
				and nr_nf 				= :ll_Nota
				and de_especie			= :ls_Especie
				and de_serie 			= :ls_Serie;
			  
			Choose Case SQLCA.SQLCode
				Case 100
			  		this.of_grava_nf_transferencia(ps_log)
				Case -1
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento' + '~nErro ao verificar existencia "NF_TRANSFERENCIA": [' + string(il_cd_filial) + '/' + string(ll_Nota) + '/' + ls_Especie + '/' + ls_Serie + '] ~n' +  sqlca.SqlErrText
					return false
			End Choose
			
			Select vl_total_nf, 
					 dh_cancelamento, 
					 dh_recebido_sap,
					 nr_pedido_distribuidora
			  Into :lvdc_Total_NF, 
					 :ldh_Cancelamento, 
					 :ldh_Recebido_SAP,
					 :il_nr_pedido_distribuidora
			  From nf_transferencia
			 Where cd_filial_origem	= :il_cd_filial
				and nr_nf 				= :ll_Nota
				and de_especie			= :ls_Especie
				and de_serie 			= :ls_Serie;
		ElseIf Pos(',ZM,YA,SM,SC,RC,S5,', ls_categoria_nf) > 0 Then
			Select vl_total_nf, 
					 dh_cancelamento, 
					 dh_recebido_sap
			  Into :lvdc_Total_NF, 
					 :ldh_Cancelamento, 
					 :ldh_Recebido_SAP
			  From nf_diversa
			 Where cd_filial_origem	= :il_cd_filial
				and nr_nf 				= :ll_Nota
				and de_especie			= :ls_Especie
				and de_serie 			= :ls_Serie;
				
			Choose Case SQLCA.SQLCode
				Case -1
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento' + '~nErro ao verificar existencia "NF_DIVERSA": [' + string(il_cd_filial) + '/' + string(ll_Nota) + '/' + ls_Especie + '/' + ls_Serie + '] ~n' +  sqlca.SqlErrText
					return false
			End Choose
		End If
		
		Choose Case SqlCa.SqlCode 
			Case 0
				If Not IsNull(ldh_Cancelamento) Then
					//Nota j$$HEX1$$e100$$ENDHEX$$ cancelada
					ib_sucesso	= true
					
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento' + '~nA nota j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cancelada no Sybase.'
					
					return true
				End If
				
				If IsNull(ldh_Recebido_SAP) Then
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento' + '~nA nota n$$HEX1$$e300$$ENDHEX$$o foi recebida do SAP.'
					return false
				End If
				
				If Pos(',ZS,Z4,ZM,YA,LE,SM,SC,RC,S5,', ls_Categoria_NF) > 0 Then
					update nf_diversa
					   set dh_cancelamento = :idh_emissao
					 Where cd_filial_origem	= :il_cd_filial
						and nr_nf 				= :ll_Nota
						and de_especie			= :ls_Especie
						and de_serie 			= :ls_Serie
					Using SqlCa;
				Elseif ls_categoria_nf = 'ZV' then
					update nf_venda
						set nr_matricula_cancelamento = '14330',  
							 dh_cancelamento = :idh_emissao
					 Where cd_filial 	= :il_cd_filial
						and nr_nf 		= :ll_Nota
						and de_especie	= :ls_Especie
						and de_serie 	= :ls_Serie
					Using SqlCa;
				ElseIf ls_categoria_nf = 'ZA' or ls_categoria_nf = 'YC' then
					// Cancelamento do estoque da transfer$$HEX1$$ea00$$ENDHEX$$ncia
					IF ls_categoria_nf = 'YC' THEN
						IF NOT of_cancela_transferencia_estoque(REF ps_log) THEN
							RETURN FALSE
						END IF
					END IF
					
					update nf_transferencia
						set nr_matricula_cancelamento = '14330',  
							 dh_cancelamento = :idh_emissao
					 Where cd_filial_origem 	= :il_cd_filial
						and nr_nf 					= :ll_Nota
						and de_especie				= :ls_Especie
						and de_serie 				= :ls_Serie
					Using SqlCa;
				Else					
					Update nf_devolucao_compra
					   Set dh_cancelamento = :idh_emissao,
						 	 nr_matricula_cancelamento = '14330',
							 dh_reentrada_mercadoria	= getdate()
					 Where cd_filial 	= :il_cd_filial
						and nr_nf 		= :il_nr_nf
						and de_especie = :is_de_especie
						and de_serie 	= :is_de_serie
					Using SQLCA;
				End If
								
				If SqlCa.SqlCode = -1 Then
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento' + '~nErro ao cancelar "NF_VENDA/NF_DIVERSA/NF_DEVOLUCAO_COMPRA": [' + string(il_cd_filial) + '/' + string(ll_Nota) + '/' + ls_Especie + '/' + ls_Serie + '] ~n' +  sqlca.SqlErrText
					return false
				End If	
				
				If ls_Categoria_NF = 'YP' or ls_Categoria_NF = 'YB' or ls_Categoria_NF = 'YY' Then
					Update nf_devolucao_compra_nfe
					   Set dh_cancelamento = :idh_emissao,
						 	 nr_matricula_cancelamento = '14330',
							 id_situacao = 'X'
					 Where cd_filial 	= :il_cd_filial
						and nr_nf 		= :il_nr_nf
						and de_especie = :is_de_especie
						and de_serie 	= :is_de_serie
					Using SQLCA;
					
					If SqlCa.SqlCode = -1 Then
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento' + '~nErro ao cancelar "NF_DEVOLUCAO_COMPRA_NFE": [' + string(il_cd_filial) + '/' + string(ll_Nota) + '/' + ls_Especie + '/' + ls_Serie + '] ~n' +  sqlca.SqlErrText
						return false
					End If
				End if
				
				if ls_Categoria_NF = 'YP' or ls_Categoria_NF = 'YB' Then
					if not This.of_retorna_saldo_wms(ls_Categoria_NF, il_nr_nf, is_de_especie, is_de_serie, il_cd_filial, REF ps_log) then
						return false
					end if
				ElseIf ls_Categoria_NF = 'ZM' or ls_Categoria_NF = 'YA' then
					if not This.of_retira_saldo_wms(ls_Categoria_NF, REF ps_log) then
						return false
					end if
				end if
				
				ib_sucesso = True
			Case 100				
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento' + '~nNota fiscal de sa$$HEX1$$ed00$$ENDHEX$$da n$$HEX1$$e300$$ENDHEX$$o foi localizada.'
				return false
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento' + '~nErro ao localizar "Nota Fiscal": ~n' + sqlca.SqlErrText
				return false
		End Choose
	Case 100
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento ' + '~nDocumento refer$$HEX1$$ea00$$ENDHEX$$ncia [' + String(il_docnum_ref) + '] n$$HEX1$$e300$$ENDHEX$$o foi localizado'
		Return False
	Case -1
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_documento' + '~nErro ao localizar "j_1bnfdoc_1": ~n' + sqlca.SqlErrText
		return false
End Choose

Return True
end function

public function boolean of_localiza_chave_integracao (ref string ps_log);String ls_Chave

// Foi criada a tabela CATEGORIA_NF_SAP
// A1/YB/YY => DEVOLUCAO COMPRA
// ZA/YC => TRANSFERENCIA
// ZV 	=> VENDA/LICITA$$HEX2$$c700c300$$ENDHEX$$O
// ZS/Z4	=> SUCATA
// YA/ZT => COMPRAS
// ZF =>CANCELAMENTO SAIDA (ZF)
// 'YA', 'ZM' => reentrada

choose case is_id_tipo_nf
	Case 'A1'
		ls_Chave = gf_replace(idc_uo_ds_base_item.Object.contrato[1], 'DV|','', 1)
	Case 'YY', 'SM', 'SC', 'RC', 'S5', 'CM'
		SetNull(il_nr_integracao)
		
		Return True
	Case 'YB', 'YP'
		 ls_Chave = gf_replace(idc_uo_ds_base_item.Object.contrato[1], 'DV|','', 1)
		 
		 select cd_chave
		   into :ls_Chave
			from log_exportacao_sap
		  where id_tipo_nf in ('WMD', 'WMA')
		  	 and cd_chave_interface	= :ls_Chave;
				
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~n Erro ao localizar a chave: ' + ls_Chave + '. ' + SQLCA.SQLErrtext
				return false
			Case 100
				If IsNull (ls_Chave) then
					ps_log = 'Objeto: ' + this.ClassName() + '~n O campo CONTRATO est$$HEX1$$e100$$ENDHEX$$ nulo e n$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a chave da interface.'
				else
					ps_log = 'Objeto: ' + this.ClassName() + '~n Chave: ' + ls_Chave + ' n$$HEX1$$e300$$ENDHEX$$o localizada.'
				End if
				return false
		End Choose
	case 'ZS', 'Z4'
		ls_Chave	= idc_uo_ds_base_item.Object.xped[1]
	case 'Z6', 'ZI', 'ZJ', 'YU'
		ls_Chave	= gf_replace(gf_replace(idc_uo_ds_base_item.Object.contrato[1], 'SOLIC|','', 1), "'SOLIC'",'', 1)
	case 'YA', 'ZM', 'LE' // reentrada
		ls_Chave	= gf_replace(idc_uo_ds_base_item.Object.contrato[1], 'DOCREF|','', 1)
		
		if IsNull(ls_Chave) or Trim(ls_Chave) = '' then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_chave_integracao' + '~nN$$HEX1$$e300$$ENDHEX$$o foi localizado a chave dentro do campo contrato.'
			return false
		end if
	case else
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_chave_integracao' + '~nTipo de nota n$$HEX1$$e300$$ENDHEX$$o previsto..'
		return false
end choose

if IsNull(ls_Chave) then
	SetNull(is_chave_interface)
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_chave_integracao' + '~nCampo contrato est$$HEX1$$e100$$ENDHEX$$ nulo.'
	return false
elseif IsNumber(ls_Chave) then
	is_chave_interface	= ls_Chave
	
	il_nr_integracao 		= Long(Right(ls_Chave, 9))
else
	SetNull(is_chave_interface)
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_chave_integracao' + '~nChave inv$$HEX1$$e100$$ENDHEX$$lida.'
	return false
end if

Return True


end function

public function boolean of_localiza_nat_operacao (long pl_linha, string ps_log);il_Nat_OPeracao	= Long(left(idc_uo_ds_base_item.Object.cd_natureza_operacao[pl_Linha], 4))
	
select de_natureza_operacao into :is_Nat_Operacao
from natureza_operacao
where cd_natureza_operacao = :il_Nat_OPeracao
Using SqlCa;

if sqlca.SqlCode < 0 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_nat_operacao' + '~nProblemas ao buscar "NATUREZA_OPERACAO": ~n' + sqlca.SqlErrText
	return false
end if

Return True
end function

public function boolean of_localiza_agrupamento (ref string ps_log);Choose Case is_id_tipo_nf
	Case 'ZS', 'Z4' // Venda de sucata
		select nr_agrupamento_dev_compra, cd_motivo_devolucao, nr_integracao 
		into :il_Agrup_Dev_Compra, :il_Motivo_Dev, :il_nr_integracao
		from wms_int_sap
		where nr_integracao = cast(:is_chave_interface as numeric)
		Using SqlCa;
		
		if sqlca.SqlCode <> 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa' + '~nErro dados do agrupamento devolu$$HEX2$$e700e300$$ENDHEX$$o: ' + is_chave_interface + ' ~n' + sqlca.SqlErrText
			return false
		end if
	Case 'SM', 'SC', 'RC', 'S5', 'CM' // Simples Remessa, Remessa p/ Conserto, Retorno remessa, Reentrada de transferencia
		// N$$HEX1$$e300$$ENDHEX$$o busca
		
	Case Else // Outras
		select nr_agrupamento_dev_compra, cd_motivo_devolucao, nr_integracao 
		into :il_Agrup_Dev_Compra, :il_Motivo_Dev, :il_nr_integracao
		from wms_int_sap
		where cd_chave_interface	= :is_chave_interface
		Using SqlCa;
		
		if sqlca.SqlCode <> 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_diversa' + '~nErro dados do agrupamento devolu$$HEX2$$e700e300$$ENDHEX$$o: ' + is_chave_interface + ' ~n' + sqlca.SqlErrText
			return false
		end if
	
End Choose

Return True
end function

public function boolean of_localiza_identificacao_nf_diversa (ref string ps_log);Choose Case is_id_tipo_nf
	Case 'ZS', 'Z4' // Venda de sucata
		SELECT	coalesce(c.nm_razao_social, c.nm_cliente),   
					c.nr_cpf_cgc,  
					c.de_endereco, 
					c.nr_inscricao_estadual, 
					c.de_bairro,    
					c.cd_cidade,   
					c.nr_endereco,   
					c.nr_cep,   
					c.nr_ddd_fone_comercial + c.nr_fone_comercial,   
					ci.nm_cidade,
					ci.cd_unidade_federacao  
		into	:is_Nm_Fantasia,
				:is_CGC,
				:is_Endereco,
				:is_IE,
				:is_Bairro,
				:il_Cidade,
				:is_NR_Endereco,
				:is_CEP,
				:is_Fone,
				:is_cidade,
				:is_UF
		 FROM cliente c
		inner join cidade ci on ci.cd_cidade = c.cd_cidade
		where c.nr_cpf_cgc = :is_nr_cgc
		Using SqlCa;
		
		if sqlca.SqlCode < 0 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_identificacao_nf_diversa' + '~nProblemas ao buscar "CLIENTE": ~n' + sqlca.SqlErrText
			return false
		end if
		
	Case 'SM', 'SC', 'RC', 'S5' // Simples remessa, Remessa p/ conserto, Retorno de remessa
		SELECT	coalesce(fo.nm_razao_social, fo.nm_fantasia),   
					fo.nr_cgc,  
					fo.de_endereco, 
					fo.nr_inscricao_estadual, 
					fo.de_bairro,    
					fo.cd_cidade,   
					fo.nr_endereco,   
					fo.nr_cep,   
					fo.nr_ddd_telefone + fo.nr_telefone,   
					ci.nm_cidade,
					ci.cd_unidade_federacao  
		into	:is_Nm_Fantasia,
				:is_CGC,
				:is_Endereco,
				:is_IE,
				:is_Bairro,
				:il_Cidade,
				:is_NR_Endereco,
				:is_CEP,
				:is_Fone,
				:is_cidade,
				:is_UF
		 FROM fornecedor fo
		inner join cidade ci on ci.cd_cidade = fo.cd_cidade
		where fo.cd_fornecedor_sap = :is_cd_fornecedor_sap
		Using SqlCa;
		
		if sqlca.SqlCode < 0 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_identificacao_nf_diversa' + '~nProblemas ao buscar "FORNECEDOR": ~n' + sqlca.SqlErrText
			return false
		end if
		
		// Se n$$HEX1$$e300$$ENDHEX$$o localizar o fornecedor, tenta pesquisar pelo cliente
		If sqlca.Sqlcode = 100 Then
			
			SELECT	coalesce(c.nm_razao_social, c.nm_cliente),   
					c.nr_cpf_cgc,  
					c.de_endereco, 
					c.nr_inscricao_estadual, 
					c.de_bairro,    
					c.cd_cidade,   
					c.nr_endereco,   
					c.nr_cep,   
					c.nr_ddd_fone_comercial + c.nr_fone_comercial,   
					ci.nm_cidade,
					ci.cd_unidade_federacao  
			into	:is_Nm_Fantasia,
					:is_CGC,
					:is_Endereco,
					:is_IE,
					:is_Bairro,
					:il_Cidade,
					:is_NR_Endereco,
					:is_CEP,
					:is_Fone,
					:is_cidade,
					:is_UF
			 FROM cliente c
			inner join cidade ci on ci.cd_cidade = c.cd_cidade
			where c.cd_cliente_sap = :is_cd_fornecedor_sap
			//c.nr_cpf_cgc = :is_nr_cgc
			Using SqlCa;
			
			if sqlca.SqlCode < 0 Then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_identificacao_nf_diversa' + '~nProblemas ao buscar "CLIENTE": ~n' + sqlca.SqlErrText
				return false
			end if
			
		End If
	Case 'CM' //Reentrada de transfer$$HEX1$$ea00$$ENDHEX$$ncia
		SELECT
			nm_fantasia,
			nr_cgc, 
			de_endereco, 
			nr_inscricao_estadual, 
			de_bairro, 
			c.cd_cidade, 
			cast(nr_endereco as varchar(10)), 
			nr_cep, 
			nr_ddd_telefone + nr_telefone,
			c.nm_cidade,
			c.cd_unidade_federacao,
			f.cd_filial
		INTO
			:is_Nm_Fantasia,
			:is_CGC,
			:is_Endereco,
			:is_IE,
			:is_Bairro,
			:il_Cidade,
			:is_NR_Endereco,
			:is_CEP,
			:is_Fone,
			:is_cidade,
			:is_UF,
			:il_cd_filial_destino
		FROM
			filial f
		INNER JOIN
			cidade c on c.cd_cidade = f.cd_cidade
		WHERE
			f.nr_cgc = :is_nr_cgc
			AND f.id_situacao = 'A'
		USING
			SqlCa;
		
		if SQLCA.SQLNRows > 1 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_identificacao_nf_diversa' + '~nFoi encontrada mais de uma filial com o CNPJ: ' + is_nr_cgc + '.'
			return false
		end if
		
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_identificacao_nf_diversa' + '~nProblemas ao buscar "FILIAL": ~n' + sqlca.SqlErrText
				return false
			Case 100
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_identificacao_nf_diversa' + '~nN$$HEX1$$e300$$ENDHEX$$o foi encontrada filial com o CNPJ: ' + is_nr_cgc + '.'
				return false
		End Choose
	Case Else // Outras
		select nm_fantasia,
				nr_cgc, 
				de_endereco, 
				nr_inscricao_estadual, 
				de_bairro, 
				c.cd_cidade, 
				cast(nr_endereco as varchar(10)), 
				nr_cep, 
				nr_ddd_telefone + nr_telefone,
				c.nm_cidade,
				c.cd_unidade_federacao
		into :is_Nm_Fantasia,
			 :is_CGC,
			 :is_Endereco,
			 :is_IE,
			 :is_Bairro,
			 :il_Cidade,
			 :is_NR_Endereco,
			 :is_CEP,
			 :is_Fone,
			 :is_cidade,
			 :is_UF
		from filial f
		inner join cidade c on c.cd_cidade = f.cd_cidade
		where f.cd_filial = :il_cd_filial
		Using SqlCa;
		
		if sqlca.SqlCode < 0 Then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_identificacao_nf_diversa' + '~nProblemas ao buscar "FILIAL": ~n' + sqlca.SqlErrText
			return false
		end if

End Choose

Return True
end function

public function boolean of_grava_melhor_compra_distribuidora (ref string ps_log, long al_cd_produto, long al_cd_natureza_operacao);Dec{2}	ldc_preco, ldc_desconto, ldc_repasse, ldc_st
Long		ll_total_linhas, ll_exists
String 	ls_distribuidora


ll_total_linhas	= idc_melhor_compra.Retrieve(il_cd_filial_destino, al_cd_produto)

if ll_total_linhas > 0 then
	ls_distribuidora	= idc_melhor_compra.Object.cd_distribuidora[1]
	ldc_preco			= idc_melhor_compra.Object.vl_preco_unitario[1]
	ldc_desconto		= idc_melhor_compra.Object.pc_desconto[1]
	ldc_repasse			= idc_melhor_compra.Object.pc_repasse_icms[1]
	ldc_st				= idc_melhor_compra.Object.vl_icms_st[1]
	
	select 1
	  into :ll_exists
	  from item_nf_transf_compra_dist
	 where cd_filial_origem			= :il_cd_filial
	 	and nr_nf						= :il_nr_nf
		and de_especie					= :is_de_especie
		and de_serie					= :is_de_serie
		and cd_natureza_operacao	= :al_cd_natureza_operacao
	  	and cd_produto					= :al_cd_produto;

	Choose Case SQLCA.SQLCode
		Case 100
			insert into item_nf_transf_compra_dist
						(cd_filial_origem, 
						 nr_nf, 
						 de_especie, 
						 de_serie,   
						 cd_natureza_operacao, 
						 cd_produto, 
						 cd_distribuidora,   
						 vl_preco_unitario, 
						 pc_desconto, 
						 pc_repasse_icms, 
						 vl_icms_st)  
			  values (:il_cd_filial, 				//cd_filial_origem
						 :il_nr_nf,  					//nr_nf
						 :is_de_especie,  	 		//de_especie
						 :is_de_serie, 				//de_serie
						 :al_cd_natureza_operacao, //cd_natureza_operacao
						 :al_cd_produto,   			//cd_produto
						 :ls_distribuidora,  		//cd_distribuidora
						 :ldc_preco,  					//vl_preco_unitario
						 :ldc_desconto,  				//pc_desconto
						 :ldc_repasse, 				//pc_repasse_icms
						 :ldc_st )   					//vl_icms_st
			Using SqlCa;
							
			if Sqlca.Sqlcode = -1 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_melhor_compra_distribuidora' + '~nProblemas ao inserir "item_nf_transf_compra_dist": ~n' + sqlca.SqlErrText
			
				return false
			end if
		Case 0
			update item_nf_transf_compra_dist
				set cd_distribuidora		= :ls_distribuidora,   
					 vl_preco_unitario	= :ldc_preco, 
					 pc_desconto			= :ldc_desconto, 
					 pc_repasse_icms		= :ldc_repasse, 
					 vl_icms_st				= :ldc_st
			 where cd_filial_origem			= :il_cd_filial
				and nr_nf						= :il_nr_nf
				and de_especie					= :is_de_especie
				and de_serie					= :is_de_serie
				and cd_natureza_operacao	= :al_cd_natureza_operacao
				and cd_produto					= :al_cd_produto;
				
			if Sqlca.Sqlcode = -1 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_melhor_compra_distribuidora' + '~nProblemas ao atualizar "item_nf_transf_compra_dist": ~n' + sqlca.SqlErrText
			
				return false
			end if
		Case -1
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_melhor_compra_distribuidora' + '~nProblemas ao buscar "item_nf_transf_compra_dist": ~n' + sqlca.SqlErrText
			
			return false
	End Choose
elseif ll_total_linhas < 0 then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_melhor_compra_distribuidora' + '~nErro ao buscar melhor compra'

	return false
end if

return true
end function

public function boolean of_gera_coleta_pendente (long al_agrupamento, string as_erro);String	ls_Erro,&
		ls_Especie,&
		ls_Serie,&
		ls_Fornecedor

Long	ll_Linhas,&
		ll_Linha,&
		ll_Filial,&
		ll_Nota,&
		ll_Qtde

dc_uo_ds_base	lds_Notas

Try
	lds_Notas = Create dc_uo_ds_base
	If Not lds_Notas.of_ChangeDataObject("ds_ge537_notas_coleta_segregado") Then Return False
	
	ll_Linhas	= lds_Notas.Retrieve(al_agrupamento)
	
	If ll_Linhas < 0 Then
		as_Erro	= "Erro no retrieve da 'ds_ge537_notas_coleta_segregado'."
		Return False
	End If
	
	If ll_Linhas < 1 Then
		as_Erro	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma nota para ser gravado nas coletas do segregado."
		Return False
	End If
	
	For ll_Linha = 1 To ll_Linhas
		ll_Filial		= lds_Notas.Object.cd_filial		[ll_Linha]
		ll_Nota			= lds_Notas.Object.nr_nf			[ll_Linha]
		ls_Especie		= lds_Notas.Object.de_especie		[ll_Linha]
		ls_Serie			= lds_Notas.Object.de_serie		[ll_Linha]
		ls_Fornecedor	= lds_Notas.Object.cd_fornecedor	[ll_Linha]
		
		Select count(*)
		Into	:ll_Qtde
		From wms_segregado_coleta
		Where cd_filial					= :ll_Filial
			And	nr_nf					= :ll_Nota
			And	de_especie			= :ls_Especie
			And	de_serie				= :ls_Serie
			And	cd_fornecedor		= :ls_Fornecedor
			And	nr_agrupamento	= :al_agrupamento
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro	= "Erro ao verificar se a nota j$$HEX1$$e100$$ENDHEX$$ registrada para coleta: "+SqlCa.SqlErrText
			Return False
		End If
		
		If ll_Qtde = 0 Then
			Insert into wms_segregado_coleta (	
				cd_filial,
				nr_nf,
				de_especie,
				de_serie,
				cd_fornecedor,
				id_situacao,
				dh_situacao,
				nr_agrupamento,
				dh_envio_email)
			Values(	:ll_Filial,
						:ll_Nota,
						:ls_Especie,
						:ls_Serie,
						:ls_Fornecedor,
						'P',
						GetDate(),
						:al_agrupamento,
						GetDate())
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Erro = "Erro ao inserir dados na tabela 'wms_segregado_coleta': "+SqlCa.SQLErrText	
				Return False
			End If
		End If
	Next
Finally
	Destroy(lds_Notas)
End Try

Return True
end function

public function boolean of_verifica_nr_pedido_original_reenviado (ref string as_nr_pedido_distribuidora);Long lvl_nr_pedido_distribuidora, lvl_xped

lvl_xped = Long(as_nr_pedido_distribuidora)

// Procurar pelo campo correto de n$$HEX1$$fa00$$ENDHEX$$mero do pedido
select nr_pedido_distrib_reenvio_sap
  into :lvl_nr_pedido_distribuidora
  from pedido_distribuidora
 where nr_pedido_distribuidora = :lvl_xped
 using sqlca;

Choose Case SqlCa.SqlCode
	Case is < 0
		Return False
	Case 0 // Achou, n$$HEX1$$e300$$ENDHEX$$o fazer nada.
		il_nr_pedido_distribuidora_original	= lvl_nr_pedido_distribuidora
		il_nr_pedido_distribuidora	= lvl_xped
		
		as_nr_pedido_distribuidora	= String(lvl_xped)
		
		Return True
	Case 100
		il_nr_pedido_distribuidora_original	= lvl_xped
		
		as_nr_pedido_distribuidora	= String(lvl_xped)
		
		Return True
End Choose
end function

public function boolean of_buscar_nsu (ref long al_nsu, ref string as_log);Update parametro_geral
   Set vl_parametro = cast(cast(vl_parametro as integer) + 1 as varchar(20))
 Where cd_parametro = 'NR_NSU_NF'
 Using SqlCa;
 
Choose Case SQLCA.SQLCode
	Case -1
		as_log 	= "Erro ao buscar valor do parametro NR_NSU_NF. Erro: " + SQLCA.SQLErrText
		Return False
	Case 100
		as_log	= "Par$$HEX1$$e200$$ENDHEX$$metro NR_NSU_NF n$$HEX1$$e300$$ENDHEX$$o encontrado."
		Return False
	Case 0
		Select cast(vl_parametro as integer)
		  Into :al_nsu
		  From parametro_geral
 	    Where cd_parametro = 'NR_NSU_NF'
		 Using SqlCa;
		 
		if SQLCA.SQLCode = -1 then
			as_log	= "Erro ao buscar NSU atualizado"
			
			Return False
		end if
		
		if IsNull(al_nsu) or al_nsu = 0 then
			al_nsu	= 1
		end if
 
		Return True
End Choose
end function

public function boolean of_busca_docnum_xped_repetido (ref string as_log);Long	ll_count


select count(distinct doc.docnum)
  into :ll_count
  from j_1bnflin lin
 inner join j_1bnfdoc_1 doc
    on doc.docnum	= lin.docnum
	and doc.mandt	= lin.mandt
	and doc.nr_sequencial	= lin.nr_sequencial
 where xped						= :is_nr_pedido_distribuidora
 	and doc.id_status			= 'P'
	and doc.id_substituida	= 'N'
	and doc.code 				= '100';
	
Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao localizar outros docnums para o mesmo pedido. Erro: ' + SQLCA.SQLErrText
		return False	
	Case 100
		Return True
	Case 0
		if ll_count > 1 then
			as_log	= 'Foram encontrados mais de um docnum para o pedido: ' + is_nr_pedido_distribuidora
			return False
		end if
End Choose

Return True
end function

public function boolean of_insere_nf_transferencia_produto_lote (ref string ps_log, long al_cd_natureza_operacao, long al_cd_produto, long al_qt_transferida);Date		ldt_atual
DateTime	ldh_fabricacao, ldh_validade
Long		ll_for, ll_qt_lote, ll_total_itens, ll_exists, ll_qt_lote_atual, ll_qt_lote_existente, ll_qt_transferida_restante, ll_qtd_transferida, ll_qtd_tranferencia_lote
String	ls_nr_lote, ls_cd_subcategoria, ls_id_medicamento
		
		
select substring(cd_subcategoria, 1, 1)
  into :ls_cd_subcategoria
  from produto_geral
 where cd_produto	= :al_cd_produto;
 
if sqlca.SqlCode < 0 then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nErro ao encontrar sub categoria do produto: ~n' + sqlca.SqlErrText
	
	return false
end if
		
if ls_cd_subcategoria = '1' then
	ls_id_medicamento	= 'S'
else
	ls_id_medicamento	= 'N'
end if

ll_total_itens	= idc_uo_ds_base_item_lote.Retrieve(al_cd_produto, il_cd_filial_destino, il_nr_pedido_distribuidora  )

if ll_total_itens < 0 then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nErro ao localizar os lotes conferidos no WMS "item_nf_transferencia_lote"'
	return false
end if

ll_qt_transferida_restante	= al_qt_transferida

for ll_for = 1 to ll_total_itens
	ls_nr_lote	= right(idc_uo_ds_base_item_lote.GetItemString(ll_for, 'nr_lote'), 10) //Tem chamado para o Sergio para resolver isso.
	ll_qt_lote	= idc_uo_ds_base_item_lote.GetItemNumber(ll_for, 'qt_lote')

	select sum(Coalesce(intl.qt_lote, 0))
	  into :ll_qt_lote_atual
	  from nf_transferencia nt
	 inner join item_nf_transferencia_lote intl
	 		   on nt.nr_nf					= intl.nr_nf
			  and nt.de_serie				= intl.de_serie
			  and nt.cd_filial_origem	= intl.cd_filial_origem	
			  and nt.de_especie			= intl.de_especie
	 where nt.nr_pedido_distribuidora	= :il_nr_pedido_distribuidora
	 	and nt.cd_filial_destino			= :il_cd_filial_destino
		and intl.cd_produto					= :al_cd_produto
		and intl.nr_lote						= :ls_nr_lote
		and nt.dh_cancelamento is null
	Using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nErro ao localizar os lotes j$$HEX1$$e100$$ENDHEX$$ inseridos na "item_nf_transferencia_lote" em outras notas'
			return false
		Case 100
			ll_qt_lote_atual	= 0
		Case 0
			if IsNull(ll_qt_lote_atual) then ll_qt_lote_atual = 0
			
			select sum(Coalesce(intl.qt_lote, 0))
			  into :ll_qt_lote_existente
			  from item_nf_transferencia_lote intl
			 where intl.cd_filial_origem		= :il_cd_filial
				and intl.nr_nf						= :il_nr_nf
				and intl.de_especie				= :is_de_especie
				and intl.de_serie					= :is_de_serie
				and intl.cd_natureza_operacao	= :al_cd_natureza_operacao
				and intl.cd_produto				= :al_cd_produto
				and intl.nr_lote					= :ls_nr_lote;
				
			Choose Case SQLCA.SQLCode
				Case -1
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nErro ao localizar os lotes j$$HEX1$$e100$$ENDHEX$$ inseridos na "item_nf_transferencia_lote"'
					return false
				Case 100
					ll_qt_lote_existente	= 0
				Case 0
					if IsNull(ll_qt_lote_existente) then ll_qt_lote_existente = 0
			End Choose
				
			ll_qt_lote_atual	= ll_qt_lote_atual - ll_qt_lote_existente
				
			ll_qt_lote	= ll_qt_lote - ll_qt_lote_atual
			
			if ll_qt_lote <= 0 then
				continue
			end if
	End Choose
	 
	if ls_id_medicamento = "S" then
		select dh_fabricacao,
				 dh_validade
		  into :ldh_fabricacao,
				 :ldh_validade
		  from produto_lote 
		 where cd_produto 	= :al_cd_produto and	
		 		 nr_lote 		= :ls_nr_lote
		using sqlca;
		
		choose case Sqlca.Sqlcode
			case 0
				if IsNull(ldh_fabricacao) then
					ldh_fabricacao = DateTime(RelativeDate(Date(gf_GetServerDate()), -10))
				end if
				
				if IsNull(ldh_validade) then
					ldh_validade = DateTime(RelativeDate(Date(gf_GetServerDate()), 450)) //15 meses
				end if
			case 100
				ldh_fabricacao = DateTime(RelativeDate(Date(gf_GetServerDate()), -10))
				ldh_validade	= DateTime(RelativeDate(Date(gf_GetServerDate()), 450)) //15 meses
			case -1
				Sqlca.of_MsgDbError('Erro ao localizar a data de fabricacao do produto' +  String(al_cd_produto) + '/' + ls_nr_lote)
				
				return false
		end choose
		
		ldt_atual	= Date(gf_GetServerDate())
		
		if ldh_fabricacao > DateTime(ldt_atual) then
			ldh_fabricacao	= DateTime(ldt_atual)
		end if
		
		if ldh_validade <= ldh_fabricacao then
			ldh_validade	= DateTime(RelativeDate(Date(gf_GetServerDate()), 90)) //Caso a validade esteja igual ou menor que a data de fabrica$$HEX2$$e700e300$$ENDHEX$$o, ajustar para 3 meses a frente.
		end if
	else
		SetNull(ldh_fabricacao)
		SetNull(ldh_validade)
	end if
	
	if ll_qt_lote > ll_qt_transferida_restante then
		ll_qt_lote	= ll_qt_transferida_restante
		ll_qt_transferida_restante	= 0
	else
		ll_qt_transferida_restante	= ll_qt_transferida_restante - ll_qt_lote
	end if
	
	if ll_qt_transferida_restante < 0 then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nProblemas ao calcular quantidade de lotes e itens transferidos "item_nf_transferencia_lote": ~n' + sqlca.SqlErrText
		return false
	end if
	
	select 1
	  into :ll_exists
	  from item_nf_transferencia_lote
	 where cd_filial_origem			= :il_cd_filial
	 	and nr_nf						= :il_nr_nf
		and de_especie					= :is_de_especie
		and de_serie					= :is_de_serie
		and cd_natureza_operacao	= :al_cd_natureza_operacao
		and cd_produto					= :al_cd_produto
		and nr_lote						= :ls_nr_lote;
	
	Choose Case SQLCA.SQLCode
		case 100
			insert into item_nf_transferencia_lote (cd_filial_origem,
																 nr_nf,
																 de_especie,   
																 de_serie,
																 cd_natureza_operacao,   
																 cd_produto,
																 nr_lote,
																 qt_lote,
																 dh_fabricacao,
																 dh_validade)
													  values (:il_cd_filial,				//cd_filial_origem
																 :il_nr_nf,						//nr_nf
																 :is_de_especie,  			//de_especie
																 :is_de_serie,					//de_serie
																 :al_cd_natureza_operacao,	//cd_natureza_operacao
																 :al_cd_produto,  			//cd_produto
																 :ls_nr_lote,					//nr_lote
																 :ll_qt_lote,					//qt_lote
																 :ldh_fabricacao,				//dh_fabricacao
																 :ldh_validade)				//dh_validade
			using sqlca;
				
			if Sqlca.Sqlcode = -1 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nProblemas ao inserir "item_nf_transferencia_lote": ~n' + sqlca.SqlErrText
				return false
			end if
		case 0
			update item_nf_transferencia_lote
				set qt_lote			= :ll_qt_lote,
					 dh_fabricacao	= :ldh_fabricacao,
					 dh_validade	= :ldh_validade
			 where cd_filial_origem			= :il_cd_filial
				and nr_nf						= :il_nr_nf
				and de_especie					= :is_de_especie
				and de_serie					= :is_de_serie
				and cd_natureza_operacao	= :al_cd_natureza_operacao
				and cd_produto					= :al_cd_produto
				and nr_lote						= :ls_nr_lote;
				
			if Sqlca.Sqlcode = -1 then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nProblemas ao atualizar "item_nf_transferencia_lote": ~n' + sqlca.SqlErrText
				return false
			end if
		case -1
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nProblemas ao buscar "item_nf_transferencia_lote": ~n' + sqlca.SqlErrText
			return false
	End Choose
	
	if ll_qt_transferida_restante = 0 then
		Select sum(qt_transferida)
		Into :ll_qtd_transferida
		From item_nf_transferencia
		Where cd_filial_origem		= :il_cd_filial
	 	and nr_nf						= :il_nr_nf
		and de_especie					= :is_de_especie
		and de_serie					= :is_de_serie
		and cd_natureza_operacao	= :al_cd_natureza_operacao
		and cd_produto					= :al_cd_produto
		using sqlca;
		
		if Sqlca.Sqlcode = -1 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nProblemas na consulta da tabela  "item_nf_transferencia" ~n' + sqlca.SqlErrText
			return false
		end if
		
		Select sum(qt_lote)
		Into :ll_qtd_tranferencia_lote
		From item_nf_transferencia_lote
		Where cd_filial_origem		= :il_cd_filial
	 	and nr_nf						= :il_nr_nf
		and de_especie					= :is_de_especie
		and de_serie					= :is_de_serie
		and cd_natureza_operacao	= :al_cd_natureza_operacao
		and cd_produto					= :al_cd_produto
		using sqlca;
		
		if Sqlca.Sqlcode = -1 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nProblemas em consultar da tabela "item_nf_transferencia_lote": ~n' + sqlca.SqlErrText
			return false
		end if
		
		If ll_qtd_tranferencia_lote = ll_qtd_transferida Then
			exit
		Else
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_nf_transferencia_produto_lote' + '~nProblemas na quantidade de lotes entre a tabela "item_nf_transferencia" e "item_nf_transferencia_lote".'
			return false
		end if
	end if
next

return true
end function

public function boolean of_verifica_insere_wms_romaneio (ref string ps_log);Long ll_Nr_Romaneio
Date ldt_Parametro

ldt_Parametro = Date(gf_GetServerDate())

Select top 1 nr_romaneio
Into :ll_Nr_Romaneio
from wms_romaneio
where cd_filial = :il_cd_filial_destino
and dh_movimentacao = :ldt_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		
		SELECT max(nr_romaneio)+1
		INTO :ll_Nr_Romaneio
		FROM wms_romaneio
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ps_log = "Erro encontrar o proximo numero de romaneio. " + SQLCA.SQLErrText
			Return False
		End If
		
		Insert Into wms_romaneio 
					(nr_romaneio,   
					 cd_filial,   
					 dh_movimentacao,
					 nr_matricula_inclusao, 
					 dh_inclusao)
		Values (:ll_nr_romaneio,
					 :il_cd_filial_destino,
					 :ldt_Parametro ,
					 '14330',
					 getdate())
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ps_log = "Erro ao inserir na wms_romaneio. " + SQLCA.SQLErrText
			Return False
		End If
		
	Case 0
		Return true

	Case -1
		ps_log = "Erro ao localizar existencia de romaneio. " + SQLCA.SQLErrText 
		Return False
End Choose

Return True
end function

public function boolean of_valida_insere_lotes_dev (long pl_cd_filial, long pl_nr_nf, string ps_de_especie, string ps_de_serie, long pl_nr_item, long pl_cd_produto, long pl_qt_devolvida, ref string ps_log);String 	ls_nr_lote, ls_log_email
Long 		ll_qt_lote, ll_soma_lotes
DateTime ldh_fabricacao, ldh_validade
Long 		ll_For, ll_Find

// Cria DS
If Not isValid(ivds_lotes_dev) Then
	ivds_lotes_dev = Create dc_uo_ds_base
	ivds_lotes_dev.of_ChangeDataObject("ds_ge537_wms_int_sap_detalhe")
End If

// Recupera os lotes da integra$$HEX2$$e700e300$$ENDHEX$$o WMS SAP
If ivds_lotes_dev.Retrieve(il_nr_integracao, pl_cd_produto) = -1 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_insere_lotes_dev' + '~nProblemas ao buscar lotes do produto ' + String(pl_cd_produto) + ': ~n' + SQLCA.is_LastErrorText
	Return False
End If

If ivds_lotes_dev.RowCount() = 0 Then Return True // sem lotes na integra$$HEX2$$e700e300$$ENDHEX$$o

////////////////////////////////////////////////////////
// AQUI CHEGA QUANDO POSSUI LOTE NA INTEGRA$$HEX2$$c700c300$$ENDHEX$$O DO WMS //
////////////////////////////////////////////////////////

// Primeiro apaga os lotes j$$HEX1$$e100$$ENDHEX$$ existentes do item (em caso de reprocessamento, reinsere abaixo)
DELETE FROM nf_devolucao_compra_prd_lote
WHERE  cd_filial	= :pl_cd_filial
	and nr_nf		= :pl_nr_nf
	and de_especie	= :ps_de_especie
	and de_serie	= :ps_de_Serie
	and nr_item		= :pl_nr_item
USING SQLCA;

If SQLCA.SqlCode = -1 Then 
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_insere_lotes_dev' + '~nProblemas ao deletar "nf_devolucao_compra_prd_lote": ~n' + SQLCA.SqlErrText
	Return False
End If

// Percorre os lotes e insere quando for menor ou igual a qt_devolvida
For ll_For = 1 To ivds_lotes_dev.RowCount()
	ls_nr_lote 		= ivds_lotes_dev.GetItemString(ll_For, "nr_lote")
	ll_qt_lote		= ivds_lotes_dev.GetItemNumber(ll_For, "qt_lote")
	ldh_fabricacao	= ivds_lotes_dev.GetItemDateTime(ll_For, "dh_fabricacao")
	ldh_validade	= ivds_lotes_dev.GetItemDateTime(ll_For, "dh_validade")
	
	ll_soma_lotes += ll_qt_lote // acumular qt_lote
	
	// n$$HEX1$$e300$$ENDHEX$$o deixar ultrapassar qt_devolvida
	If ll_soma_lotes > pl_qt_devolvida Then 
		ll_qt_lote 		= (ll_qt_lote - (ll_soma_lotes - pl_qt_devolvida)) // retira o excedente do lote
		ll_soma_lotes 	= pl_qt_devolvida
	End If
	
	// Lote menor ou igual ao total, insere
	If ll_soma_lotes <= pl_qt_devolvida Then
		If IsNull (ldh_validade) then
			ldh_validade = DateTime ('2099/12/31')
		else
			ldh_validade = DateTime (String (ldh_validade, '01/mm/yyyy'))
		End if
		
		INSERT INTO nf_devolucao_compra_prd_lote (
					cd_filial,
					nr_nf,
					de_especie,
					de_serie,
					nr_item,
					nr_lote,
					qt_lote,
					dh_validade,
					dh_fabricacao )  
		  VALUES(:pl_cd_filial,
					:pl_nr_nf,
					:ps_de_especie,
					:ps_de_Serie,
					:pl_nr_item,
					:ls_nr_lote,
					:ll_qt_lote,
					:ldh_validade,
					:ldh_fabricacao)
		USING SQLCA;
		
		If SQLCA.SqlCode = -1 Then 
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_insere_lotes_dev' + '~nProblemas ao inserir "nf_devolucao_compra_prd_lote": ~n' + SQLCA.SqlErrText
			Return False
		End If
	End If
	
	// Se j$$HEX1$$e100$$ENDHEX$$ fechou a quantidade total, para por aqui
	If ll_soma_lotes = pl_qt_devolvida Then
		Exit
	End If
	
Next


// Se terminou o loop de lotes, mas sobrou qt_devolvida, gerar um Log para investiga$$HEX2$$e700e300$$ENDHEX$$o
// (este caso pode acontecer quando na integra$$HEX2$$e700e300$$ENDHEX$$o foi solicitado menos qt_lotes e devolveu mais)
If ll_soma_lotes < pl_qt_devolvida Then
	ls_log_email = "A qt_devolvida $$HEX1$$e900$$ENDHEX$$ maior que a quantidade de lotes solicitados na wms_int_sap_detalhe."
	ls_log_email += "~rFilial|Nota|Especie|Serie: "+String(pl_cd_filial)+"|"+String(pl_nr_nf)+"|"+ps_de_especie+"|"+ps_de_Serie
	ls_log_email += "~rnr_item: "+String(pl_nr_item)
	ls_log_email += "~rcd_produto: "+String(pl_cd_produto)
	ls_log_email += "~rnr_integracao: "+String(il_nr_integracao)
	ls_log_email += "~rqt_devolvida: "+String(pl_qt_devolvida)
	ls_log_email += "~rll_soma_lotes: "+String(ll_soma_lotes)
	
	ls_log_email += "~r~rFavor analisar a integra$$HEX2$$e700e300$$ENDHEX$$o desta nota."
	
	This.of_Envia_Email(ls_log_email, il_docnum)
End If


Return True
end function

public function boolean of_busca_endereco_cancelamento (ref string ps_log);/*
String is_Endereco_Avaria                     		CD_ENDERECO_SEGREGADO_RECEBIMENTO_AVARIA    
String is_Endereco_Falta                       		CD_ENDERECO_SEGREGADO_RECEBIMENTO_FALTA    
String is_Endereco_Vencido                   		CD_ENDERECO_SEGREGADO_RECEBIMENTO_VENCID       
String is_Endereco_Defeito_Fabrica        			CD_ENDERECO_SEGREGADO_DEFEITO_FABRICA     
String is_Endereco_Outros                     		CD_ENDERECO_SEGREGADO_RECEBIMENTO_OUTROS   
String is_Endereco_Acordo_Comercial         			CD_ENDERECO_SEGREGADO_ACORDO_COMERCIAL    
String is_Endereco_Prestes_AVencer           		CD_ENDERECO_SEGREGADO_PRESTES_VENCER   
String is_Endereco_Validade_ForaAcordo     			CD_ENDERECO_SEGREGADO_VAL_FORA_ACORDO   
String is_Endereco_Receb_Caixa_ForaPadrao         	CD_ENDERECO_SEGREGADO_CX_FORA_PADRAO 
String is_Endereco_Seg_Nf_Reentrada                CD_ENDERECO_SEGREG_NF_REENTRADA    
String is_Endereco_Seg_Nf_Tranf_Canc               CD_ENDERECO_SEGREG_NF_TRANSF_CANC    
String is_Endereco_Receb_Fracionado                CD_ENDERECO_SEGREGADO_RECEBIMENTO_FRACIO
String is_Endereco_Segregado_Vencido_Danificado		CD_ENDERECO_SEGREGADO_VENCIDO_DANIFICADO
String is_Endereco_Outros_Agr								CD_ENDERECO_AGR_OUTROS
String is_Endereco_Excursao_Temperatura				CD_ENDERECO_EXCURSAO_TEMPERATURA_NFD
*/


String	ls_param_end


ls_param_end   = 'CD_ENDERECO_AGR_OUTROS'

SELECT vl_parametro
  INTO :is_Endereco_Outros_Agr
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

ls_param_end   = 'CD_ENDERECO_SEGREGADO_VENCIDO_DANIFICADO'

SELECT vl_parametro
  INTO :is_Endereco_Segregado_Vencido_Danificado
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

ls_param_end   = 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_AVARIA'

SELECT vl_parametro
  INTO :is_Endereco_Avaria
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

ls_param_end   = 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_FALTA'

SELECT vl_parametro
  INTO :is_Endereco_Falta
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose


ls_param_end   = 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_VENCID'

SELECT vl_parametro
  INTO :is_Endereco_Vencido
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose


ls_param_end   = 'CD_ENDERECO_SEGREGADO_DEFEITO_FABRICA'

SELECT vl_parametro
  INTO :is_Endereco_Defeito_Fabrica
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose



ls_param_end   = 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_OUTROS'

SELECT vl_parametro
  INTO :is_Endereco_Outros
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose




ls_param_end   = 'CD_ENDERECO_SEGREGADO_ACORDO_COMERCIAL'

SELECT vl_parametro
  INTO :is_Endereco_Acordo_Comercial
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose


ls_param_end   = 'CD_ENDERECO_SEGREGADO_PRESTES_VENCER'

SELECT vl_parametro
  INTO :is_Endereco_Prestes_AVencer
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

ls_param_end   = 'CD_ENDERECO_SEGREGADO_VAL_FORA_ACORDO'

SELECT vl_parametro
  INTO :is_Endereco_Validade_ForaAcordo
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose


 ls_param_end   = 'CD_ENDERECO_SEGREGADO_CX_FORA_PADRAO'

SELECT vl_parametro
  INTO :is_Endereco_Receb_Caixa_ForaPadrao
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose



ls_param_end   = 'CD_ENDERECO_SEGREG_NF_REENTRADA'                           

SELECT vl_parametro
  INTO :is_Endereco_Seg_Nf_Reentrada
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose


ls_param_end   = 'CD_ENDERECO_SEGREG_NF_TRANSF_CANC'

SELECT vl_parametro
  INTO :is_Endereco_Seg_Nf_Tranf_Canc
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose


 ls_param_end   = 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_FRACIO'

SELECT vl_parametro
  INTO :is_Endereco_Receb_Fracionado
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

ls_param_end   = 'CD_ENDERECO_EXCURSAO_TEMPERATURA_NFD'

SELECT vl_parametro
  INTO :is_Endereco_Excursao_Temperatura
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

Return True
end function

public function boolean of_retorna_saldo_wms (long pl_produto, ref long pl_nr_nf, string ps_de_especie, string ps_de_serie, long pl_cd_filial_origem, long pl_cd_item, ref string ps_log);DateTime ldh_Validade
Dec{2}	ldc_vl_custo_unitario
Long 		ll_Nulo, ll_nr_nf_compra, ll_cd_motivo_devolucao, ll_for, ll_linhas, ll_qt_lote, ll_nr_controle, &
			ll_nr_agrupamento_dev_compra, ll_cd_item
String 	ls_Lote, ls_Endereco_Entrada, ls_Endereco_Saida, ls_Nulo, ls_cd_fornecedor, &
			ls_de_especie_compra, ls_de_serie_compra, ls_cd_bairro

dc_uo_ds_base	lds_item_nf_diversa_lote


try
	if not this.of_busca_endereco_cancelamento(REF ps_log) then
		return false
	end if
	
	lds_item_nf_diversa_lote	= Create dc_uo_ds_base
		
	lds_item_nf_diversa_lote.of_ChangeDataObject('ds_ge537_item_nf_diversa_lote')
	
	ll_linhas	= lds_item_nf_diversa_lote.Retrieve(pl_nr_nf, ps_de_especie, ps_de_serie, pl_cd_filial_origem, pl_cd_item)
	
	For ll_for	= 1 to ll_linhas
		ll_cd_item		= lds_item_nf_diversa_lote.GetItemNumber(ll_for, 'cd_item')
		ll_qt_lote		= lds_item_nf_diversa_lote.GetItemNumber(ll_for, 'qt_lote')
		ls_Lote			= lds_item_nf_diversa_lote.GetItemString(ll_for, 'nr_lote')
		ldh_Validade	= lds_item_nf_diversa_lote.GetItemDateTime(ll_for, 'dh_validade')
		
		ldh_Validade	= DateTime (String (ldh_validade, '01/mm/yyyy'))
		
		is_Chave_NF_Origem = string(il_cd_filial) + '/' + String(il_nr_nf_origem) + '/' + is_de_serie_origem + '/' + is_de_especie_origem
		
		Choose Case is_id_tipo_nf
			Case 'CM'
				SELECT
					DISTINCT ind.cd_produto,
					ind.vl_preco_unitario
				INTO
					:pl_produto,
					:ldc_vl_custo_unitario
		   	FROM
					dbo.item_nf_diversa ind
		   	INNER JOIN
					dbo.item_nf_diversa_lote indl 
		   		ON ind.cd_filial_origem = indl.cd_filial_origem 
		   		AND ind.nr_nf = indl.nr_nf 
		   		AND ind.de_serie = indl.de_serie
		   		AND ind.de_especie = indl.de_especie
					AND ind.cd_item = indl.cd_item
		   	WHERE
					ind.nr_nf = :pl_nr_nf 
					AND ind.cd_filial_origem = :pl_cd_filial_origem 
					AND indl.cd_item = :ll_cd_item
					AND indl.de_serie = :ps_de_serie
					AND indl.de_especie = :ps_de_especie;
					
				Choose Case SQLCA.SQLCode
					Case -1
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nErro ao buscar o item [' + String(ll_cd_item) + '] na tabela item_nf_diversa. ~nErro: '  + SQLCA.SQLErrText
						return false
					Case 100
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nO item [' + String(ll_cd_item) + '] n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela item_nf_diversa.'
						return false
				End Choose
			Case 'LE'
				//
			Case Else
				SetNull(ls_cd_fornecedor)
				SetNull(ll_nr_nf_compra)
				SetNull(ls_de_especie_compra)
				SetNull(ls_de_serie_compra)
				SetNull(ll_cd_motivo_devolucao)
				SetNull(ll_nr_agrupamento_dev_compra)
				
				select top 1 ndc.cd_fornecedor, 
						 ndc.nr_nf_compra, 
						 ndc.de_especie_compra, 
						 ndc.de_serie_compra,
						 ndc.cd_motivo_devolucao,
						 ndc.nr_agrupamento_dev_compra
				  into :ls_cd_fornecedor,
						 :ll_nr_nf_compra,
						 :ls_de_especie_compra,
						 :ls_de_serie_compra,
						 :ll_cd_motivo_devolucao,
						 :ll_nr_agrupamento_dev_compra
				  from nf_devolucao_compra ndc
				 inner join nf_devolucao_compra_produto ndcp 
							on ndcp.cd_filial 	= ndc.cd_filial 
						  and ndcp.nr_nf			= ndc.nr_nf 
						  and ndcp.de_especie 	= ndc.de_especie
						  and ndcp.de_serie		= ndc.de_serie
				 inner join nf_devolucao_compra_prd_lote ndcpl 
							on ndcpl.cd_filial 	= ndc.cd_filial 
						  and ndcpl.nr_nf 		= ndc.nr_nf  
						  and ndcpl.de_especie 	= ndc.de_especie  
						  and ndcpl.de_serie 	= ndc.de_serie  
						  and ndcpl.nr_item 		= ndcp.nr_item
				 inner join produto_geral pg 
							on pg.cd_produto	= ndcp.cd_produto
				 where ndc.cd_filial 	= :il_cd_filial
					and ndc.nr_nf 			= :il_nr_nf_origem
					and ndc.de_especie 	= :is_de_especie_origem
					and ndc.de_serie 		= :is_de_serie_origem
					and ndcp.cd_produto	= :pl_produto
					and ndcpl.nr_lote		= :ls_Lote
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 100
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nLote do produto [' + String(pl_produto) + '] n$$HEX1$$e300$$ENDHEX$$o foi localizado na nota de origem [' + is_Chave_NF_Origem + '] .'
						return false
					Case -1
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nProblemas ao atualizar o saldo no WMS: ~n' + sqlca.SqlErrText
						return false
				End Choose
				
				if SQLCA.SQLNRows <= 0 then
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nProblemas ao atualizar o a quantidade devolvida na nota fiscal de origem. Nenhuma linha do banco de dados foi atualizada'
					return false
				End If
				
				update item_nf_compra_lote
					set qt_devolvida = qt_devolvida - :ll_qt_lote
				 where cd_produto		= :pl_produto
					and nr_lote			= :ls_Lote
					and cd_filial		= :il_cd_filial
					and cd_fornecedor	= :ls_cd_fornecedor
					and nr_nf			= :ll_nr_nf_compra
					and de_serie		= :ls_de_serie_compra
					and de_especie		= :ls_de_especie_compra
				Using SQLCA;
				
				Choose Case SqlCa.SqlCode
					Case -1
						ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nProblemas ao atualizar a quantidade devolvida na tabela item_nf_compra_lote: ~n' + sqlca.SqlErrText
						return false
				End Choose
				
				if SQLCA.SQLNRows <= 0 Then
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nProblemas ao atualizar a quantidade devolvida na tabela item_nf_compra_lote. Nenhuma linha atualizada'
					return false
				end if
		End Choose
		
		Choose Case is_id_tipo_nf
			Case 'CM'
				ls_Endereco_Entrada	= is_Endereco_Seg_Nf_Tranf_Canc
			Case Else
				If Not of_busca_endereco_motivo_dev(ll_cd_motivo_devolucao, ll_nr_agrupamento_dev_compra, REF ls_Endereco_Entrada, REF ps_log) Then
					ps_log	= 'Erro ao buscar endere$$HEX1$$e700$$ENDHEX$$o de retirada de estoque por motivo de devolu$$HEX2$$e700e300$$ENDHEX$$o.' + ps_log
					Return False
				End If 
		End Choose
		
		uo_ge258_movimentacao lo_Movimentacao
					
		SetNull(ll_Nulo)
		SetNull(ls_Nulo)
	
		lo_Movimentacao = Create uo_ge258_movimentacao
		
		lo_Movimentacao.ivb_Commit = False
		
		lo_Movimentacao.ib_mostra_erro_tela = False
		
		SetNull(ls_Endereco_Saida)
		
		If Not lo_Movimentacao.of_insere_movimentacao(	ls_Endereco_Entrada,&
																		ls_Endereco_Saida,&
																		pl_produto,&
																		1,&
																		ls_Lote,&
																		Date(ldh_Validade),&
																		ll_qt_lote,&
																		"J",&
																		il_cd_filial,&
																		ls_Nulo,&  
																		il_nr_nf,&
																		is_de_especie,&
																		is_de_serie,&
																		'14330') Then
			SqlCa.of_Rollback()
			ps_log	= 'Erro na movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque da reentrada. ~r~r' + lo_Movimentacao.is_log_erro
			Return False
		End If
		
		select we.cd_bairro
		  into :ls_cd_bairro
		  from wms_endereco we
		 where we.cd_endereco = :ls_Endereco_Entrada;
		 
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = "Problema ao procurar registro na wms_segregado_recebimento. ~r~rErro: '" + SQLCA.SQLErrText + "'."
				Return False
			Case 100
				ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado registro na wms_endereco para o endereco: " + ls_Endereco_Entrada + "."
				Return False
			Case 0
				if ls_cd_bairro = 'A' then
					SetNull(ll_nr_controle)
					
					select top 1 nr_controle
					  into :ll_nr_controle
					  from wms_segregado_recebimento wsr
					 where wsr.cd_produto		= :pl_produto
						and wsr.nr_lote			= :ls_Lote
						and wsr.dh_validade		= :ldh_Validade
						and wsr.nr_nf				= :ll_nr_nf_compra
						and wsr.cd_fornecedor	= :ls_cd_fornecedor
						and wsr.de_especie		= :ls_de_especie_compra
						and wsr.de_serie			= :ls_de_serie_compra
						and wsr.cd_endereco		= :ls_Endereco_Entrada;
						
					Choose Case SQLCA.SQLCode
						Case -1
							//Caso tenha dado problema de ter retornado mais de um registro deve ter algo errado e deve ser pesquisado a origem do problema.
							ps_log = "Problema ao procurar registro na wms_segregado_recebimento. ~r~rErro: '" + SQLCA.SQLErrText + "'."
							Return False
						Case 100
							INSERT INTO wms_segregado_recebimento  (cd_endereco,   
																				 cd_fornecedor,   
																				 nr_nf,   
																				 de_especie,   
																				 de_serie,   
																				 cd_produto,   
																				 nr_lote,   
																				 dh_validade,   
																				 qt_lote)  
							VALUES (	:ls_Endereco_Entrada,   
										:ls_cd_fornecedor,   
										:ll_nr_nf_compra,   
										:ls_de_especie_compra,   
										:ls_de_serie_compra,   
										:pl_produto,   
										:ls_Lote,   
										:ldh_Validade,   
										:ll_qt_lote)
							Using SqlCa;
					
							If SqlCa.SqlCode = -1 Then
								ps_log = "Problema na inclus$$HEX1$$e300$$ENDHEX$$oo do lote na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'."
								Return False
							End If
						Case 0
							update wms_segregado_recebimento
								set qt_lote	= qt_lote + :ll_qt_lote
							 where nr_controle	= :ll_nr_controle;
							 
							if SQLCA.SQLCode = -1 then
								ps_log = "Problema ao atualizar registro na wms_segregado_recebimento. ~r~rErro: '" + SQLCA.SQLErrText + "'."
								Return False
							end if
					End Choose
				end if
		End Choose
		
		if is_id_tipo_nf = 'CM' then
			if not of_movimenta_estoque_loja(pl_produto, ll_qt_lote, il_cd_filial_destino, il_cd_filial, il_nr_nf, is_de_especie, is_de_serie, ldc_vl_custo_unitario, REF ps_log) then
				Return False
			end if
		end if
		
		If Not This.of_grava_ajuste_estoque_wms(pl_produto, ls_Endereco_Entrada, ls_Lote, ldh_Validade, ll_qt_lote, 'E', 'NOTA DE REENTRADA (DIVERSA): ', 0, 0, '', 1, ref ps_log ) Then Return False
	Next
Finally
	Destroy(lo_Movimentacao)	
End Try

return True

end function

public function boolean of_busca_centro_custo_almoxarifado (long al_nr_pedido_distribuidora, ref long al_cd_centro_custo, ref string as_log);///Query
select max(pa.cd_centro_custo)
into	:al_cd_centro_custo
from pedido_almoxarifado pa
where pa.cd_filial = :il_cd_filial_destino //Filial de destino da mercadoria
and pa.nr_pedido in (select pda.nr_pedido_almoxarifado
							from pedido_distribuidora_almox pda 
							where pda.cd_filial = pa.cd_filial
							and pda.nr_pedido_distribuidora = :al_nr_pedido_distribuidora) // numero da tabela pedido_distribuidora
Using Sqlca;
	
Choose Case Sqlca.SQLCode
	Case -1
		as_log	= 'Erro ao localizar o centro de custo do pedido da distribuidora no almoxarifado. Erro: ' + Sqlca.SQLErrText
		return False	
End Choose

If IsNull(al_cd_centro_custo) Or al_cd_centro_custo <= 0 Then
	
	select cd_centro_custo
	into	: al_cd_centro_custo
	from pedido_distribuidora pd 
	where cd_filial  = 2 //estoque central 
	and nr_pedido_distribuidora = :al_nr_pedido_distribuidora
	Using Sqlca;
	
	Choose Case Sqlca.SQLCode
		Case -1
			as_log	= 'Erro ao localizar o centro de custo do pedido da distribuidora. Erro: ' + Sqlca.SQLErrText
			return False	
		Case 100
			SetNull(al_cd_centro_custo)
	End Choose
End If

Return True
end function

public function boolean of_ajuste_definitivo_estoque (ref string ps_log);//Declara$$HEX2$$e700f500$$ENDHEX$$es

Date				ldt_movimentacao_caixa

DateTime			ldh_validade, &
					ldh_ajuste

dc_uo_ds_base	lds_produtos_inventario

Long				ll_Linha, &
					ll_Linhas, &
					ll_nr_ajuste_estoque, &
					ll_produto, &
					ll_sequencial, &
					ll_qt_caixa_padrao, &
					ll_qt_ajuste, &
					ll_motivo_ajuste

String			ls_Erro, &
					ls_endereco, &
					ls_lote, &
					ls_comentario_ajuste, &
					ls_matricula_responsavel, &
					ls_id_entrada_saida

//Procedimentos

//Caso n$$HEX1$$e300$$ENDHEX$$o tenha o n$$HEX1$$fa00$$ENDHEX$$mero de invent$$HEX1$$e100$$ENDHEX$$rio $$HEX1$$e900$$ENDHEX$$ por que a nota se trata de um ajuste, ent$$HEX1$$e300$$ENDHEX$$o, o ajuste do estoque j$$HEX1$$e100$$ENDHEX$$ foi feito.
//Essa altera$$HEX2$$e700e300$$ENDHEX$$o ir$$HEX1$$e100$$ENDHEX$$ funcionar igual ao invent$$HEX1$$e100$$ENDHEX$$rio futuramente.
If IsNull (il_Inventario) or il_Inventario = 0 then
	Return True
End if

lds_produtos_inventario = Create dc_uo_ds_base

If not lds_produtos_inventario.of_ChangeDataObject ('ds_ge537_inventario_prev') then
	ps_log = 'Erro ao mudar a DW [ds_ge537_inventario_prev].'
	Return False
End if

ldt_movimentacao_caixa = Date (gf_GetServerDate ())

Choose case is_id_tipo_nf
	case 'ZI'
		ls_id_entrada_saida = 'S'
	case 'ZJ'
		ls_id_entrada_saida = 'E'
End choose

ll_Linhas = lds_produtos_inventario.Retrieve (il_Inventario, ls_id_entrada_saida)

For ll_Linha = 1 to ll_Linhas
	
	ll_produto               = lds_produtos_inventario.Object.cd_produto               [ll_Linha]
	ll_sequencial            = lds_produtos_inventario.Object.nr_sequencial            [ll_Linha]
	ls_endereco              = lds_produtos_inventario.Object.cd_endereco              [ll_Linha]
	ls_lote                  = lds_produtos_inventario.Object.nr_lote                  [ll_Linha]
	ldh_validade	          = lds_produtos_inventario.Object.dh_validade              [ll_Linha]
	ll_qt_caixa_padrao       = lds_produtos_inventario.Object.qt_caixa_padrao          [ll_Linha]
	ll_qt_ajuste             = lds_produtos_inventario.Object.qt_ajuste                [ll_Linha]
	ldh_ajuste		          = lds_produtos_inventario.Object.dh_ajuste                [ll_Linha]
	ls_matricula_responsavel = lds_produtos_inventario.Object.nr_matricula_responsavel [ll_Linha]
	ll_motivo_ajuste         = lds_produtos_inventario.Object.cd_motivo_ajuste         [ll_Linha]
				  
	SELECT COALESCE (MAX (nr_ajuste), 0) + 1
	  INTO :ll_nr_ajuste_estoque
	  FROM wms_ajuste_estoque
	 USING SQLCA;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = "Erro ao obter o sequencial na tabela 'wms_ajuste_estoque': " + SqlCa.SQLErrText
		SqlCa.of_RollBack ()
		Return False
	End if
	
	INSERT INTO wms_ajuste_estoque (	nr_ajuste,
												cd_produto,
												nr_sequencial,
												cd_endereco,
												nr_lote,
												dh_validade,
												qt_caixa_padrao,
												qt_ajuste,
												id_entrada_saida,
												dh_ajuste,
												dh_movimentacao_caixa,
												nr_matricula_responsavel,
												cd_motivo_ajuste,
												nr_inventario
											 )  
									VALUES ( :ll_nr_ajuste_estoque,
												:ll_produto,
												:ll_sequencial,
												:ls_endereco,
												:ls_lote,
												:ldh_validade,
												:ll_qt_caixa_padrao,
												:ll_qt_ajuste,
												:ls_id_entrada_saida,
												:ldh_ajuste,
												:ldt_movimentacao_caixa,
												:ls_matricula_responsavel,
												:ll_motivo_ajuste,
												:il_Inventario
											 )
	 USING SQLCA;
	
	If SQLCA.SQLCode = -1 then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_ajuste_definitivo_estoque' + '~nErro ao inserir na tabela "wms_ajuste_estoque": ~n' + SQLCA.SqlErrText
		SqlCa.of_RollBack ()
		Return False
	End if
	
	UPDATE wms_int_sap_detalhe
		SET nr_ajuste_estoque = :ll_nr_ajuste_estoque
	 WHERE nr_integracao = :il_nr_integracao
	 	AND cd_produto    = :ll_produto
		AND nr_lote       = :ls_lote
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_ajuste_definitivo_estoque' + '~nErro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da tabela "wms_int_sap_detalhe": ~n' + SQLCA.SqlErrText
		SqlCa.of_RollBack ()
		Return False
	End if
	
	lds_produtos_inventario.Object.id_ajustado_estoque [ll_Linha] = 'S'
Next

If lds_produtos_inventario.Update () < 0 then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_ajuste_definitivo_estoque' + '~nErro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da tabela "wms_ajuste_estoque" atrav$$HEX1$$e900$$ENDHEX$$s da DW [ds_ge537_inventario_prev]: ~n' + SQLCA.SqlErrText
	SqlCa.of_RollBack ()
	Return False
End if
	
Return True
end function

public function boolean of_grava_nfe_inutilizacao (ref string ps_log);
// S$$HEX1$$f300$$ENDHEX$$ insere caso ainda n$$HEX1$$e300$$ENDHEX$$o exista.

INSERT INTO nfe_inutilizacao
	(cd_filial, 
	nr_nf, 
	de_especie, 
	de_serie, 
	dh_inutilizacao, 
	nr_protocolo,
	nr_matricula)
SELECT 
	:il_cd_filial as cd_filial,
	:il_nr_nf as nr_nf,
	:is_de_especie as de_especie, 
	:is_de_serie as de_serie, 
	Coalesce(:idh_envio, GetDate()) as dh_inutilizacao, 
	Coalesce(:is_nr_protocolo_envio, '') as nr_protocolo,
	'14430' as nr_matricula
WHERE NOT EXISTS(	SELECT 1
						FROM nfe_inutilizacao i
						WHERE i.cd_filial = :il_cd_filial
							AND i.nr_nf = :il_nr_nf
							AND i.de_especie = :is_de_especie
							AND i.de_serie = :is_de_serie )
USING SQLCA;

Choose Case SQLCA.SqlCode
	Case 0, 100 // Se inseriu ou j$$HEX1$$e100$$ENDHEX$$ estava na tabela.
		ib_sucesso = True
		
	Case is < 0 // Erro
		ps_Log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_Grava_NFe_Inutilizacao: Erro ao inserir nfe_inutilizacao. Erro: ' + SQLCA.SqlErrText
		ib_sucesso = False
	
End Choose

Return ib_sucesso
end function

public function boolean of_determina_cd_tipo_documento (ref string ps_cd_tipo_documento, ref string ps_log);Choose Case is_id_tipo_nf
	Case 'ZS'
		ps_cd_tipo_documento = 'VDD' // Sa$$HEX1$$ed00$$ENDHEX$$da
		
	Case 'SM'
		ps_cd_tipo_documento = 'SMS' // Sa$$HEX1$$ed00$$ENDHEX$$da
		
	Case 'S5'
		ps_cd_tipo_documento = 'SME' // Entrada
		
	Case 'SC'
		ps_cd_tipo_documento = 'SC' // Sa$$HEX1$$ed00$$ENDHEX$$da
		
	Case 'RC'
		ps_cd_tipo_documento = 'RC' // Entrada
		
	Case Else
		SetNull(ps_cd_tipo_documento)
		
End Choose

Return True
end function

public function boolean of_retira_saldo_wms (string ps_categoria_origem, ref string ps_log);DateTime ldh_Validade
Long 		ll_Nulo, ll_nr_nf_compra, ll_cd_motivo_devolucao, ll_cd_filial_complementar, ll_nr_nf_complementar, &
			ll_nr_controle, ll_qt_lote, ll_Linhas, ll_qt_lote_devolucao, ll_for, ll_cd_produto, ll_nr_agrupamento_dev_compra
String 	ls_Lote, ls_Endereco_Entrada, ls_Endereco_Saida, ls_Nulo, ls_Grupo_Psico, ls_cd_fornecedor, &
			ls_de_especie_compra, ls_de_serie_compra, ls_de_especie_complementar, ls_de_serie_complementar, &
			ls_de_chave_acesso, ls_cd_bairro

dc_uo_ds_base				lds_lista_produtos_reentrada
uo_ge258_movimentacao 	lo_Movimentacao


SetNull(ll_Nulo)
SetNull(ls_Nulo)

Try
	if not this.of_busca_endereco_cancelamento(REF ps_log) then
		return false
	end if
	
	is_Chave_NF_Origem = string(il_cd_filial) + '/' + String(il_nr_nf) + '/' + is_de_especie + '/' + is_de_serie
	
	if ps_categoria_origem = 'YB' or ps_categoria_origem = 'YP' then
	else
		select nd.cd_filial_complementar,
				 nd.nr_nf_complementar,
				 nd.de_especie_complementar,
				 nd.de_serie_complementar,
				 ndn.de_chave_acesso
		  into :ll_cd_filial_complementar,
				 :ll_nr_nf_complementar,
				 :ls_de_especie_complementar,
				 :ls_de_serie_complementar,
				 :ls_de_chave_acesso
		  from nf_diversa nd
		 inner join nf_diversa_nfe ndn
			 on nd.cd_filial_origem	= ndn.cd_filial_origem
			and nd.nr_nf 			= ndn.nr_nf
			and nd.de_especie 	= ndn.de_especie
			and nd.de_serie 		= ndn.de_serie
		 where nd.cd_filial_origem	= :il_cd_filial
			and nd.nr_nf 				= :il_nr_nf
			and nd.de_especie 		= :is_de_especie
			and nd.de_serie 			= :is_de_serie;
			
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nErro ao procurar a nota complementar da nota de origem [' + is_Chave_NF_Origem + '] .'
				return false
			Case 100
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nNota complementar n$$HEX1$$e300$$ENDHEX$$o encontrada na nota de origem [' + is_Chave_NF_Origem + '] .'
				return false
		End Choose
	end if

	lds_lista_produtos_reentrada	= Create dc_uo_ds_base
	
	lds_lista_produtos_reentrada.of_ChangeDataObject('ds_ge537_lista_produtos_devolucao')

	ll_Linhas = lds_lista_produtos_reentrada.Retrieve(ll_cd_filial_complementar, ll_nr_nf_complementar, ls_de_especie_complementar, ls_de_serie_complementar)
	
	for ll_for	= 1 to ll_Linhas
		ll_cd_produto						= lds_lista_produtos_reentrada.GetItemNumber(ll_for, 'cd_produto')
		ll_nr_nf_compra					= lds_lista_produtos_reentrada.GetItemNumber(ll_for, 'nr_nf_compra')
		ll_cd_motivo_devolucao			= lds_lista_produtos_reentrada.GetItemNumber(ll_for, 'cd_motivo_devolucao')
		ll_qt_lote_devolucao				= lds_lista_produtos_reentrada.GetItemNumber(ll_for, 'qt_lote')
		ll_nr_agrupamento_dev_compra	= lds_lista_produtos_reentrada.GetItemNumber(ll_for, 'nr_agrupamento_dev_compra')
		ls_Lote								= lds_lista_produtos_reentrada.GetItemString(ll_for, 'nr_lote')
		ls_Grupo_Psico						= lds_lista_produtos_reentrada.GetItemString(ll_for, 'cd_grupo_psico')
		ls_cd_fornecedor					= lds_lista_produtos_reentrada.GetItemString(ll_for, 'cd_fornecedor')
		ls_de_especie_compra				= lds_lista_produtos_reentrada.GetItemString(ll_for, 'de_especie_compra')
		ls_de_serie_compra				= lds_lista_produtos_reentrada.GetItemString(ll_for, 'de_serie_compra')
		ldh_Validade						= lds_lista_produtos_reentrada.GetItemDateTime(ll_for, 'dh_validade')
		
		update item_nf_compra_lote
			set qt_devolvida = qt_devolvida + :ll_qt_lote_devolucao
		 where cd_produto		= :ll_cd_produto
			and nr_lote			= :ls_Lote
			and dh_validade	= :ldh_Validade
			and cd_filial		= il_cd_filial
			and cd_fornecedor	= :ls_cd_fornecedor
			and nr_nf			= :ll_nr_nf_compra
			and de_serie		= :ls_de_serie_compra
			and de_especie		= :ls_de_especie_compra
		Using SQLCA;
		
		Choose Case SqlCa.SqlCode
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retira_saldo_wms' + '~nProblemas ao atualizar a quantidade devolvida na tabela item_nf_compra_lote: ~n' + sqlca.SqlErrText
				return false
		End Choose
		
		if SQLCA.SQLNRows <= 0 then
			ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retira_saldo_wms' + '~nProblemas ao atualizar a quantidade devolvida na tabela item_nf_compra_lote. Nenhuma linha foi atualizada.'
			return false
		end if
		
		If Not of_busca_endereco_motivo_dev(ll_cd_motivo_devolucao, ll_nr_agrupamento_dev_compra, REF ls_Endereco_Saida, REF ps_log) Then
			ps_log	= 'Erro ao buscar endere$$HEX1$$e700$$ENDHEX$$o de retirada de estoque por motivo de devolu$$HEX2$$e700e300$$ENDHEX$$o. ' + ps_log
			Return False
		End If

		lo_Movimentacao = Create uo_ge258_movimentacao
		
		lo_Movimentacao.ivb_Commit = False
		
		lo_Movimentacao.ib_mostra_erro_tela = False
		
		SetNull(ls_Endereco_Entrada)
			
		If Not lo_Movimentacao.of_insere_movimentacao(	ls_Endereco_Entrada,&
																		ls_Endereco_Saida,&
																		ll_cd_produto,&
																		1,&
																		ls_Lote,&
																		Date(ldh_Validade),&
																		ll_qt_lote_devolucao,&
																		"J",&
																		il_cd_filial,&
																		ls_Nulo,&  
																		il_nr_nf,&
																		is_de_especie,&
																		is_de_serie,&
																		'14330') Then
			SqlCa.of_Rollback()
			Return False
		End If
		
		SetNull(ls_cd_bairro)
		
		select we.cd_bairro
		  into :ls_cd_bairro
		  from wms_endereco we
		 where we.cd_endereco = :ls_Endereco_Saida;
		 
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = "Problema ao procurar registro na wms_segregado_recebimento. ~r~rErro: '" + SQLCA.SQLErrText + "'."
				Return False
			Case 100
				ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado registro na wms_endereco para o endereco: " + ls_Endereco_Entrada + "."
				Return False
			Case 0
				SetNull(ll_nr_controle)
				SetNull(ll_qt_lote)
				
				select top 1 nr_controle,
						 qt_lote
				  into :ll_nr_controle,
						 :ll_qt_lote
				  from wms_segregado_recebimento wsr
				 where wsr.cd_produto		= :ll_cd_produto
					and wsr.nr_lote			= :ls_Lote
					and wsr.dh_validade		= :ldh_Validade
					and wsr.nr_nf				= :ll_nr_nf_compra
					and wsr.cd_fornecedor	= :ls_cd_fornecedor
					and wsr.de_especie		= :ls_de_especie_compra
					and wsr.de_serie			= :ls_de_serie_compra;
					
				Choose Case SQLCA.SQLCode
					Case -1
						//Caso tenha dado problema de ter retornado mais de um registro deve ter algo errado e deve ser pesquisado a origem do problema.
						ps_log = "Problema ao procurar registro na wms_segregado_recebimento. ~r~rErro: '" + SQLCA.SQLErrText + "'."
						Return False
					Case 100
						//Caso n$$HEX1$$e300$$ENDHEX$$o tenha encontrado registro no wms_segregado_recebimento para o produto e o lote, deve continuar o processo.
					Case 0
						if ll_qt_lote	>= ll_qt_lote_devolucao then
							delete from wms_segregado_recebimento
									where nr_controle	= :ll_nr_controle;
									
							if SQLCA.SQLCode = -1 then
								ps_log = "Problema ao deletar registro na wms_segregado_recebimento. ~r~rErro: '" + SQLCA.SQLErrText + "'."
								Return False
							end if
						else
							update wms_segregado_recebimento
								set qt_lote	= qt_lote - :ll_qt_lote_devolucao
							 where nr_controle	= :ll_nr_controle;
							 
							if SQLCA.SQLCode = -1 then
								ps_log = "Problema ao atualizar registro na wms_segregado_recebimento. ~r~rErro: '" + SQLCA.SQLErrText + "'."
								Return False
							end if
						end if
				End Choose
				
				If SqlCa.SqlCode = -1 Then
					ps_log = "Problema na inclus$$HEX1$$e300$$ENDHEX$$o do lote na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'."
					Return False
				End If
		End Choose
	
		If Not This.of_grava_ajuste_estoque_wms(ll_cd_produto, ls_Endereco_Saida, ls_Lote, ldh_Validade, ll_qt_lote_devolucao, 'S', 'CANCELAMENTO NOTA DE REENTRADA (DIVERSA): ', 0, 0, '', 1, ref ps_log ) Then Return False
	next
Finally
	Destroy(lo_Movimentacao)	
End Try	

Return True
end function

public function boolean of_retorna_saldo_wms (string ps_categoria_origem, ref long pl_nr_nf, string ps_de_especie, string ps_de_serie, long pl_cd_filial_origem, ref string ps_log);DateTime ldh_Validade
Long 		ll_Nulo, ll_nr_nf_compra, ll_cd_motivo_devolucao, ll_for, ll_linhas, ll_qt_lote, ll_nr_controle, &
			ll_nr_agrupamento_dev_compra, ll_cd_produto
String 	ls_Lote, ls_Endereco_Entrada, ls_Endereco_Saida, ls_Nulo, ls_cd_fornecedor, &
			ls_de_especie_compra, ls_de_serie_compra, ls_cd_bairro

dc_uo_ds_base	lds_item_nf_lote


try
	if not this.of_busca_endereco_cancelamento(REF ps_log) then
		return false
	end if
	
	lds_item_nf_lote	= Create dc_uo_ds_base
		
	if ps_categoria_origem = 'YB' or ps_categoria_origem = 'YP' then
		lds_item_nf_lote.of_ChangeDataObject('ds_ge537_item_nf_devolucao_lote')
		
		il_nr_nf_origem		= pl_nr_nf
		is_de_especie_origem	= ps_de_especie
		is_de_serie_origem	= ps_de_serie
	end if
	
	SetNull(ll_Nulo)
	
	ll_linhas	= lds_item_nf_lote.Retrieve(pl_nr_nf, ps_de_especie, ps_de_serie, pl_cd_filial_origem, ll_Nulo)
	
	For ll_for	= 1 to ll_linhas
		ll_cd_produto	= lds_item_nf_lote.GetItemNumber(ll_for, 'cd_produto')
		ll_qt_lote		= lds_item_nf_lote.GetItemNumber(ll_for, 'qt_lote')
		ls_Lote			= lds_item_nf_lote.GetItemString(ll_for, 'nr_lote')
		ldh_Validade	= lds_item_nf_lote.GetItemDateTime(ll_for, 'dh_validade')
		
		ldh_Validade	= DateTime (String (ldh_validade, '01/mm/yyyy'))
		
		is_Chave_NF_Origem = String(il_cd_filial)+'/' + String(il_nr_nf_origem) + '/' + is_de_serie_origem + '/' + is_de_especie_origem
		
		if not is_id_tipo_nf = 'LE' then
			SetNull(ls_cd_fornecedor)
			SetNull(ll_nr_nf_compra)
			SetNull(ls_de_especie_compra)
			SetNull(ls_de_serie_compra)
			SetNull(ll_cd_motivo_devolucao)
			SetNull(ll_nr_agrupamento_dev_compra)
			
			select top 1 ndc.cd_fornecedor, 
					 ndc.nr_nf_compra, 
					 ndc.de_especie_compra, 
					 ndc.de_serie_compra,
					 ndc.cd_motivo_devolucao,
					 ndc.nr_agrupamento_dev_compra
			  into :ls_cd_fornecedor,
					 :ll_nr_nf_compra,
					 :ls_de_especie_compra,
					 :ls_de_serie_compra,
					 :ll_cd_motivo_devolucao,
					 :ll_nr_agrupamento_dev_compra
			  from nf_devolucao_compra ndc
			 inner join nf_devolucao_compra_produto ndcp 
						on ndcp.cd_filial 	= ndc.cd_filial 
					  and ndcp.nr_nf			= ndc.nr_nf 
					  and ndcp.de_especie 	= ndc.de_especie
					  and ndcp.de_serie		= ndc.de_serie
			 inner join nf_devolucao_compra_prd_lote ndcpl 
						on ndcpl.cd_filial 	= ndc.cd_filial 
					  and ndcpl.nr_nf 		= ndc.nr_nf  
					  and ndcpl.de_especie 	= ndc.de_especie  
					  and ndcpl.de_serie 	= ndc.de_serie  
					  and ndcpl.nr_item 		= ndcp.nr_item
			 inner join produto_geral pg 
						on pg.cd_produto	= ndcp.cd_produto
			 where ndc.cd_filial 	= :il_cd_filial
				and ndc.nr_nf 			= :il_nr_nf_origem
				and ndc.de_especie 	= :is_de_especie_origem
				and ndc.de_serie 		= :is_de_serie_origem
				and ndcp.cd_produto	= :ll_cd_produto
				and ndcpl.nr_lote		= :ls_Lote
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 100
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nLote [' + ls_Lote + '] do produto [' + String(ll_cd_produto) + '] n$$HEX1$$e300$$ENDHEX$$o foi localizado na nota de origem [' + is_Chave_NF_Origem + '] .'
					return false
				Case -1
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nProblemas ao atualizar o saldo no WMS: ~n' + sqlca.SqlErrText
					return false
			End Choose
			
			update item_nf_compra_lote
				set qt_devolvida = qt_devolvida - :ll_qt_lote
			 where cd_produto		= :ll_cd_produto
				and nr_lote			= :ls_Lote
				and cd_filial		= :il_cd_filial
				and cd_fornecedor	= :ls_cd_fornecedor
				and nr_nf			= :ll_nr_nf_compra
				and de_serie		= :ls_de_serie_compra
				and de_especie		= :ls_de_especie_compra
			Using SQLCA;
			
			Choose Case SqlCa.SqlCode
				Case -1
					ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nProblemas ao atualizar a quantidade devolvida na tabela item_nf_compra_lote: ~n' + sqlca.SqlErrText
					return false
			End Choose
			
			if SQLCA.SQLNRows <= 0 Then
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_saldo_wms' + '~nProblemas ao atualizar a quantidade devolvida na tabela item_nf_compra_lote. Nenhuma linha atualizada'
				return false
			end if
		End If
		
		If Not of_busca_endereco_motivo_dev(ll_cd_motivo_devolucao, ll_nr_agrupamento_dev_compra, REF ls_Endereco_Entrada, REF ps_log) Then
			ps_log	= 'Erro ao buscar endere$$HEX1$$e700$$ENDHEX$$o de retirada de estoque por motivo de devolu$$HEX2$$e700e300$$ENDHEX$$o. ' + ps_log
			Return False
		End If
		
		uo_ge258_movimentacao lo_Movimentacao
					
		SetNull(ll_Nulo)
		SetNull(ls_Nulo)
	
		lo_Movimentacao = Create uo_ge258_movimentacao
		
		lo_Movimentacao.ivb_Commit = False
		
		lo_Movimentacao.ib_mostra_erro_tela = False
		
		SetNull(ls_Endereco_Saida)
		
		If Not lo_Movimentacao.of_insere_movimentacao(	ls_Endereco_Entrada,&
																		ls_Endereco_Saida,&
																		ll_cd_produto,&
																		1,&
																		ls_Lote,&
																		Date(ldh_Validade),&
																		ll_qt_lote,&
																		"J",&
																		il_cd_filial,&
																		ls_Nulo,&  
																		il_nr_nf,&
																		is_de_especie,&
																		is_de_serie,&
																		'14330') Then
			SqlCa.of_Rollback()
			Return False
		End If
		
		select we.cd_bairro
		  into :ls_cd_bairro
		  from wms_endereco we
		 where we.cd_endereco = :ls_Endereco_Entrada;
		 
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = "Problema ao procurar registro na wms_segregado_recebimento. ~r~rErro: '" + SQLCA.SQLErrText + "'."
				Return False
			Case 100
				ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado registro na wms_endereco para o endereco: " + ls_Endereco_Entrada + "."
				Return False
			Case 0
				if ls_cd_bairro = 'A' then
					SetNull(ll_nr_controle)
					
					select top 1 nr_controle
					  into :ll_nr_controle
					  from wms_segregado_recebimento wsr
					 where wsr.cd_produto		= :ll_cd_produto
						and wsr.nr_lote			= :ls_Lote
						and wsr.dh_validade		= :ldh_Validade
						and wsr.nr_nf				= :ll_nr_nf_compra
						and wsr.cd_fornecedor	= :ls_cd_fornecedor
						and wsr.de_especie		= :ls_de_especie_compra
						and wsr.de_serie			= :ls_de_serie_compra
						and wsr.cd_endereco		= :ls_Endereco_Entrada;
						
					Choose Case SQLCA.SQLCode
						Case -1
							//Caso tenha dado problema de ter retornado mais de um registro deve ter algo errado e deve ser pesquisado a origem do problema.
							ps_log = "Problema ao procurar registro na wms_segregado_recebimento. ~r~rErro: '" + SQLCA.SQLErrText + "'."
							Return False
						Case 100
							INSERT INTO wms_segregado_recebimento  (cd_endereco,   
																				 cd_fornecedor,   
																				 nr_nf,   
																				 de_especie,   
																				 de_serie,   
																				 cd_produto,   
																				 nr_lote,   
																				 dh_validade,   
																				 qt_lote)  
							VALUES (	:ls_Endereco_Entrada,   
										:ls_cd_fornecedor,   
										:ll_nr_nf_compra,   
										:ls_de_especie_compra,   
										:ls_de_serie_compra,   
										:ll_cd_produto,   
										:ls_Lote,   
										:ldh_Validade,   
										:ll_qt_lote)
							Using SqlCa;
					
							If SqlCa.SqlCode = -1 Then
								ps_log = "Problema na inclus$$HEX1$$e300$$ENDHEX$$oo do lote na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'."
								Return False
							End If
						Case 0
							update wms_segregado_recebimento
								set qt_lote	= qt_lote + :ll_qt_lote
							 where nr_controle	= :ll_nr_controle;
							 
							if SQLCA.SQLCode = -1 then
								ps_log = "Problema ao atualizar registro na wms_segregado_recebimento. ~r~rErro: '" + SQLCA.SQLErrText + "'."
								Return False
							end if
					End Choose
				end if
		End Choose
		
		If not ps_categoria_origem = 'YB' and not ps_categoria_origem = 'YP' then
			If Not This.of_grava_ajuste_estoque_wms(ll_cd_produto, ls_Endereco_Entrada, ls_Lote, ldh_Validade, ll_qt_lote, 'E', 'Retorno de Saldo: ' + is_Chave_NF_Origem, &
				0, 0, '', 1, ref ps_log ) Then Return False
		End If 
	Next
Finally
	Destroy(lo_Movimentacao) 	
End Try

return True

end function

public function boolean of_busca_endereco_motivo_dev (long al_cd_motivo_devolucao, long al_nr_agrupamento_dev_compra, ref string as_endereco, ref string as_log);if IsNull(al_nr_agrupamento_dev_compra) then //Endere$$HEX1$$e700$$ENDHEX$$os de devolu$$HEX2$$e700e300$$ENDHEX$$o no ato do recebimento
	Choose case al_cd_motivo_devolucao
		case 1 	//AVARIA
			as_endereco = is_Endereco_Avaria
		case 2 	//VENCIDO
			as_endereco = is_Endereco_Vencido	
		case 5 	//FALTA
			as_endereco = is_Endereco_Falta			
		case 11 	//PRODUTO FRACIONADO 
			as_endereco = 	is_Endereco_Receb_Fracionado	
		case 3, 4, 6, 7, 8, 9, 10, 12, 13, 14 // OUTROS 
			as_endereco = 	is_Endereco_Outros
		case 15 // EXCURS$$HEX1$$c300$$ENDHEX$$O DE TEMPERATURA 
			as_endereco = 	is_Endereco_Excursao_Temperatura
		case else	//Outros tipos de devolu$$HEX2$$e700e300$$ENDHEX$$o ou notas de reentrada que n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o devolu$$HEX2$$e700e300$$ENDHEX$$o v$$HEX1$$e300$$ENDHEX$$o para o endere$$HEX1$$e700$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rico
			as_endereco = is_Endereco_Outros
	End choose
else
	Choose case al_cd_motivo_devolucao //Endere$$HEX1$$e700$$ENDHEX$$os de devolu$$HEX2$$e700e300$$ENDHEX$$o de segregado (agrupamento)
		case 1 //AVARIA
			as_endereco = is_Endereco_Segregado_Vencido_Danificado
		case 2 // VENCIDO
			as_endereco = is_Endereco_Segregado_Vencido_Danificado	
		case 5, 6, 8, 11 //OUTROS
			as_endereco = is_Endereco_Outros_Agr			
		case 7 // DEFEITO FABRICA 
			as_endereco = 	is_Endereco_Defeito_Fabrica		
		case 8 // ACORDO COMERCIAL 
			as_endereco = 	is_Endereco_Acordo_Comercial	
		case 9 // PRESTES A VENCER
			as_endereco = 	is_Endereco_Prestes_AVencer		
		case 10 // VALIDADE FORA ACORDO
			as_endereco = 	is_Endereco_Validade_ForaAcordo			
		case 12 // ENTREGA CX FORA PADRAO
			as_endereco = 	is_Endereco_Receb_Caixa_ForaPadrao  						
		case 13 // SEGR. NF TRANSF CANC 
			as_endereco = 	is_Endereco_Seg_Nf_Tranf_Canc  						
		case 14 // SEGR. NF REENTRADA 
			as_endereco = 	is_Endereco_Seg_Nf_Reentrada  						
		case else //Outros tipos de devolu$$HEX2$$e700e300$$ENDHEX$$o ou notas de reentrada que n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o devolu$$HEX2$$e700e300$$ENDHEX$$o v$$HEX1$$e300$$ENDHEX$$o para o endere$$HEX1$$e700$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rico
			as_endereco = is_Endereco_Outros_Agr
	End choose
end if

If IsNull(as_endereco) or Trim(as_endereco) = '' then 
	as_log	= 'Endere$$HEX1$$e700$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em branco'
	Return False
End If

Return True
end function

public function boolean of_localiza_nf_origem (string ps_categoria_reentrada, ref string ps_log);Choose Case ps_categoria_reentrada
	Case 'CM'
		select coalesce(cast(jdoc2.nfenum as int), jdoc2.nfnum),
				 cast('NFE' as char(3)),
				 coalesce(jdoc2.series, 'U'),
				 jdoc2.nftype
		 Into  :il_nr_nf_origem, 
				 :is_de_especie_origem, 
				 :is_de_serie_origem, 
				 :is_categoria_nf_origem
		  from j_1bnfdoc_1 as jdoc inner join j_1bnfdoc_2 as jdoc2 on jdoc2.mandt				= jdoc.mandt and 
																						  jdoc2.docnum 		 	= jdoc.docnum and 
																						  jdoc2.nr_sequencial	= jdoc.nr_sequencial
		where jdoc.docnum 	= :il_docnum_ref and 
				jdoc2.nftype 	in ('ZA', 'YC') and 
				jdoc.id_status	= 'P' and
				jdoc.id_substituida = 'N'
				
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 100
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_nf_origem ' + '~nDocumento refer$$HEX1$$ea00$$ENDHEX$$ncia [' + is_chave_interface + ']n$$HEX1$$e300$$ENDHEX$$o foi localizado'
				Return False
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_nf_origem' + '~nErro ao localizar "j_1bnfdoc_1": ~n' + sqlca.SqlErrText
				return false
		End Choose
	Case Else
		select coalesce(cast(jdoc2.nfenum as int), jdoc2.nfnum),
				 cast('NFE' as char(3)),
				 coalesce(jdoc2.series, 'U'),
				 jdoc2.nftype
		 Into  :il_nr_nf_origem, 
				 :is_de_especie_origem, 
				 :is_de_serie_origem, 
				 :is_categoria_nf_origem
		  from j_1bnfdoc_1 as jdoc inner join j_1bnfdoc_2 as jdoc2 on jdoc2.mandt				= jdoc.mandt and 
																						  jdoc2.docnum 		 	= jdoc.docnum and 
																						  jdoc2.nr_sequencial	= jdoc.nr_sequencial
		where jdoc.docnum 	= cast(:is_chave_interface as integer) and 
				jdoc2.nftype 	in ('ZS', 'Z4', 'ZV', 'A1', 'YP', 'YB', 'YY') and 
				jdoc.id_status	= 'P' and
				jdoc.id_substituida = 'N'
				
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 100
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_nf_origem ' + '~nDocumento refer$$HEX1$$ea00$$ENDHEX$$ncia [' + is_chave_interface + ']n$$HEX1$$e300$$ENDHEX$$o foi localizado'
				Return False
			Case -1
				ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_localiza_nf_origem' + '~nErro ao localizar "j_1bnfdoc_1": ~n' + sqlca.SqlErrText
				return false
		End Choose
End Choose

Return True
end function

public function boolean of_movimenta_estoque_loja (long pl_cd_produto, long pl_qt_movto, long pl_cd_filial_movimento, long pl_cd_filial_origem, long pl_nr_nf, string pl_de_especie, string pl_de_serie, decimal pdc_custo_transf, ref string ps_log);DateTime	ldt_data_hora_atual
String	ls_erro


ldt_data_hora_atual	= DateTime(Date(gf_getserverdate()))

Declare sp_log Procedure for sp_inclui_movimento_estoque	:pl_cd_produto, 
	:IL_TP_MOVTO_CANC_TRANSF_ENTRADA, 
	:pl_qt_movto, 
	:pl_cd_filial_movimento, 
	:ldt_data_hora_atual, 
	null, 
	:pl_cd_filial_origem, 
	null, 
	:pl_nr_nf, 
	:pl_de_especie, 
	pl_de_serie, 
	null, 
	:pdc_custo_transf, 
	:pdc_custo_transf,
	null
USING SQLCA;
	
Execute sp_log;
		
If sqlca.sqlcode = -1 then
	 ps_log = 'Erro ao executar a procedure [sp_inclui_movimento_estoque]: ' + sqlca.sqlerrtext
	 return false
end if
		
Fetch sp_log Into :ls_erro;

Close sp_log;

Return True
end function

public function boolean of_grava_ajuste_estoque_wms (long al_produto, string as_endereco, string as_lote, datetime adt_validade, long al_qtde_movimento, string as_entrada_saida, string amotivo, long al_nr_agrupamento, long al_motivo_ajuste, string as_nr_matricula_responsavel, long al_caixa_padrao, ref string ps_log);Date 		ldh_Movimento
Long 		ll_nr_ajuste_estoque
String 	ls_Erro, ls_Comentario


ldh_Movimento = Date(gf_GetServerDate())

SELECT 
	coalesce(max(nr_ajuste), 0) + 1 
INTO 
	:ll_nr_ajuste_estoque
FROM
	wms_ajuste_estoque
USING
	SQLCA;

If SQLCA.SqlCode = -1 Then
	ls_Erro = SQLCA.SQLErrText
	SQLCA.of_RollBack()
	MessageBox("Erro", "Erro ao inserir dados na tabela 'wms_ajuste_estoque': "+ ls_Erro)		
	Return False
End If

If Not IsNull(is_Chave_NF_Origem) And Trim(is_Chave_NF_Origem) <> '' Then
	ls_Comentario = amotivo + ' ' + 'REF: ' + is_Chave_NF_Origem
Else
	ls_Comentario = amotivo
End If

if IsNull(al_motivo_ajuste) or al_motivo_ajuste <= 0 then
	al_motivo_ajuste	= IL_CD_MOTIVO_AJUSTE_AUT_COMPRAS
end if

if IsNull(as_nr_matricula_responsavel) or Trim(as_nr_matricula_responsavel) = '' then
	as_nr_matricula_responsavel = IS_NR_MATRICULA_INTEG_AUT
end if

if IsNull(al_caixa_padrao) or al_caixa_padrao <= 0 then
	al_caixa_padrao = IL_QT_CAIXA_PADRAO_SEGREGADO
end if

INSERT INTO wms_ajuste_estoque (	
	nr_ajuste,   
	cd_produto,   
	cd_endereco,   
	nr_lote,   
	dh_validade,   
	qt_caixa_padrao,   
	qt_ajuste,   
	id_entrada_saida,   
	dh_ajuste,   
	dh_movimentacao_caixa,   
	de_comentario_ajuste,   
	nr_matricula_responsavel,
	cd_motivo_ajuste,
	nr_agrupamento_dev_compra)  
VALUES (
	:ll_nr_ajuste_estoque, 			//nr_ajuste,   
	:al_produto,						//cd_produto,   
	:as_endereco,						//cd_endereco,   
	:as_lote,							//nr_lote,   
	:adt_validade,						//dh_validade,   
	:al_caixa_padrao,					// qt_caixa_padrao
	:al_qtde_movimento, 				//qt_ajuste,   
	:as_entrada_saida,				//id_entrada_saida,   
	getdate(),							//dh_ajuste,   
	:ldh_Movimento,					//dh_movimentacao_caixa,   
	:ls_Comentario, 					//de_comentario_ajuste,   
	:as_nr_matricula_responsavel,	//nr_matricula_responsavel
	:al_motivo_ajuste,				//cd_motivo_ajuste
	:al_nr_agrupamento)				//nr_agrupamento_dev_compra
Using SQLCA;

If SQLCA.SqlCode = -1 Then
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_ajuste_estoque_wms' + '~nProblemas ao inserir "wms_ajuste_estoque": ~n' + SQLCA.SqlErrText
	SQLCA.of_RollBack()
	return false
End If

Return True
end function

public function boolean of_movimenta_estoque_descarte (long al_cd_filial, long al_nr_agrupamento, long al_cd_motivo_ajuste, long al_cd_produto, string as_nr_lote, date ad_dt_validade, long al_qt_lote, long al_nr_nf, string as_de_especie, string as_de_serie, string as_nr_matricula_responsavel, string as_tipo_movimento, ref string as_log);Long		ll_Nr_Movimentacao
String	ls_cd_endereco_agrupamento, ls_nulo, ls_direcao_movimentacao, ls_id_exclui_movimentacao

uo_ge258_movimentacao lo_Movimentacao


Try
	SetNull(ls_Nulo)
	
	//Criar fun$$HEX2$$e700e300$$ENDHEX$$o para buscar dados do par$$HEX1$$e200$$ENDHEX$$metro wms_parametro.CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV
	ls_cd_endereco_agrupamento = "B900500A"
	as_tipo_movimento	= 'J'
	ls_direcao_movimentacao	= 'S'
	
	if IsNull(as_nr_matricula_responsavel) or Trim(as_nr_matricula_responsavel) = '' then
		as_nr_matricula_responsavel	= IS_NR_MATRICULA_INTEG_AUT
	end if
	
	if not This.of_grava_ajuste_estoque_wms(al_cd_produto, ls_cd_endereco_agrupamento, as_nr_lote, DateTime(ad_dt_validade), al_qt_lote, 'S', 'DESCARTE DE AGRUPAMENTO', & 
		al_nr_agrupamento, al_cd_motivo_ajuste, as_nr_matricula_responsavel, IL_QT_CAIXA_PADRAO_SEGREGADO, REF as_log) then
		Return False
	end if
	
	lo_Movimentacao = Create uo_ge258_movimentacao
	
	lo_Movimentacao.ivb_Commit = False
	lo_Movimentacao.ib_mostra_erro_tela = False

	If Not lo_Movimentacao.of_insere_movimentacao(ls_nulo,&
																	ls_cd_endereco_agrupamento,&
																	al_cd_produto,&
																	IL_QT_CAIXA_PADRAO_SEGREGADO,&
																	as_nr_lote,&
																	ad_dt_validade,&
																	al_qt_lote,&
																	as_tipo_movimento,&
																	al_cd_filial,&
																	ls_nulo,&  
																	al_nr_nf,&
																	as_de_especie,&
																	as_de_serie,&
																	as_nr_matricula_responsavel) Then
		SQLCA.of_Rollback()
		as_log	= 'Erro na movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque de descarte (of_movimenta_estoque_descarte). ~r~r' + lo_Movimentacao.is_log_erro
		Return False
	End If
	
	SELECT
		id_exclui_movimentacao
	INTO
		:ls_id_exclui_movimentacao
	FROM
		wms_tipo_movimento_estoque
	WHERE
		id_tipo_movimento = :as_tipo_movimento
		AND id_entrada_saida = :ls_direcao_movimentacao;
		
	Choose Case SQLCA.SQLCode
		Case -1
			SQLCA.of_Rollback()
			as_log	= 'Erro ao localizar registro na tabela wms_tipo_movimento_estoque (of_movimenta_estoque_descarte). ~r~r' + lo_Movimentacao.is_log_erro
			Return False
		Case 100
			SQLCA.of_Rollback()
			as_log	= 'N$$HEX1$$e300$$ENDHEX$$o foi localizado registro na tabela wms_tipo_movimento_estoque (of_movimenta_estoque_descarte). ~r~r' + lo_Movimentacao.is_log_erro
			Return False
	End Choose
	
	if ls_id_exclui_movimentacao = 'N' then
		//Pega o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o
		SELECT 
			nr_movimentacao
		INTO
			:ll_Nr_Movimentacao
		FROM 
			wms_movimentacao
		WHERE
			cd_produto 							= :al_cd_produto
			and nr_matricula_responsavel 	= :as_nr_matricula_responsavel
			and cd_endereco_saida 			= :ls_cd_endereco_agrupamento
			and nr_lote							= :as_nr_lote
			and qt_caixa_padrao 				= :IL_QT_CAIXA_PADRAO_SEGREGADO
			and dh_validade 					= :ad_dt_validade
			and id_tipo_movimento 			= :as_tipo_movimento
		USING 
			SQLCA;
	
		Choose Case SqlCa.SqlCode
			Case -1		
				as_log = "Erro selecionar dados do produto (of_movimenta_estoque_descarte): "+ SqlCa.SQLErrText	
				Return False
				
			Case 100
				as_log = "Produto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em movimenta$$HEX2$$e700e300$$ENDHEX$$o (of_movimenta_estoque_descarte)."	
				Return False	
		End Choose
		
		If Not lo_Movimentacao.of_Atualiza_Movimentacao(ls_cd_endereco_agrupamento,&
																		al_cd_produto,&
																		ll_Nr_Movimentacao,&
																		al_qt_lote,&
																		as_nr_lote,&
																		IL_QT_CAIXA_PADRAO_SEGREGADO,&
																		DateTime(ad_dt_validade)) Then
			Return False
		End If
	End If
	
	Return True
Catch (RunTimeError RTE)
	as_log = RTE.getmessage() + ' (of_movimenta_estoque_descarte)'
	Return False
Finally
	if IsValid(lo_Movimentacao) then Destroy lo_Movimentacao
End Try
end function

public function boolean of_movimenta_estoque (ref long al_nr_nf, string as_de_especie, string as_de_serie, long al_cd_filial_origem, long al_cd_item, long al_cd_motivo_ajuste, string as_nr_matricula_responsavel, ref string as_log);DateTime ldh_Validade
Dec{2}	ldc_vl_custo_unitario
Long 		ll_Nulo, ll_nr_nf_compra, ll_cd_motivo_devolucao, ll_for, ll_linhas, ll_qt_lote, ll_nr_controle, &
			ll_nr_agrupamento_dev_compra, ll_cd_item, ll_cd_filial, ll_cd_produto, ll_nr_agrupamento
String 	ls_Lote, ls_Endereco_Entrada, ls_Endereco_Saida, ls_Nulo, ls_cd_fornecedor, &
			ls_de_especie_compra, ls_de_serie_compra, ls_cd_bairro

dc_uo_ds_base	lds_item_nf_diversa_lote


try
	lds_item_nf_diversa_lote	= Create dc_uo_ds_base
		
	lds_item_nf_diversa_lote.of_ChangeDataObject('ds_ge537_item_nf_diversa_lote')
	
	ll_linhas	= lds_item_nf_diversa_lote.Retrieve(al_nr_nf, as_de_especie, as_de_serie, al_cd_filial_origem, al_cd_item)
	
	For ll_for	= 1 to ll_linhas
		ll_cd_filial		= lds_item_nf_diversa_lote.GetItemNumber(ll_for, 'cd_filial_origem')
		ll_cd_item			= lds_item_nf_diversa_lote.GetItemNumber(ll_for, 'cd_item')
		ll_qt_lote			= lds_item_nf_diversa_lote.GetItemNumber(ll_for, 'qt_lote')
		ll_cd_produto		= lds_item_nf_diversa_lote.GetItemNumber(ll_for, 'cd_produto')
		ll_nr_agrupamento	= lds_item_nf_diversa_lote.GetItemNumber(ll_for, 'nr_agrupamento_dev_compra_wms')
		ls_Lote				= lds_item_nf_diversa_lote.GetItemString(ll_for, 'nr_lote')
		ldh_Validade		= lds_item_nf_diversa_lote.GetItemDateTime(ll_for, 'dh_validade')
		
		ldh_Validade	= DateTime (String (ldh_validade, '01/mm/yyyy'))
		
		Choose Case is_id_tipo_nf
			Case 'Z6'
				if not This.of_movimenta_estoque_descarte(ll_cd_filial, ll_nr_agrupamento, al_cd_motivo_ajuste, ll_cd_produto, &
															ls_Lote, Date(ldh_Validade), ll_qt_lote, al_nr_nf, as_de_especie, as_de_serie, &
															as_nr_matricula_responsavel, IS_CD_TIPO_MOV_RESOLV_DESCARTE, REF as_log) then
					Return False
				end if
		End Choose
	Next
	
	Return True
Catch (RunTimeError RTE)
	as_log = RTE.getmessage() + ' (of_movimenta_estoque)'
	Return False
Finally
	if IsValid(lds_item_nf_diversa_lote) then
		Destroy(lds_item_nf_diversa_lote)
	end if
End Try

end function

public function boolean of_busca_endereco_expedicao_transf (long al_cd_filial, ref string as_end_exped_transf, ref string as_log);String	ls_param_end

ls_param_end = 'CD_ENDERECO_EXPEDICAO_TRANSFERENCIA@' + String(al_cd_filial)

SELECT vl_parametro
  INTO :as_end_exped_transf
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		as_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		as_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

Return True
end function

public function boolean of_busca_endereco_receb_transf (long al_cd_filial, ref string as_end_receb_transf, ref string as_log);String	ls_param_end

ls_param_end = 'CD_ENDERECO_RECEB_TRANSFERENCIA@' + String(al_cd_filial)

SELECT vl_parametro
  INTO :as_end_receb_transf
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		as_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		as_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

Return True
end function

public function boolean of_cancela_transferencia_estoque (ref string ps_log);// Cancela o efeito de estoque de uma nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia (YC/ZA)
// chamando a movimenta$$HEX2$$e700e300$$ENDHEX$$o reversa para cada lote.

Long ll_linhas, ll_for, ll_cd_produto, ll_cd_filial_destino, ll_qt_separada, ll_qt_caixa_padrao
String ls_nr_lote
DateTime ldt_validade
dc_uo_ds_base lds_lotes

TRY
	lds_lotes = CREATE dc_uo_ds_base
	
	IF NOT lds_lotes.of_ChangeDataObject("ds_ge537_item_transf_cd") THEN
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_transferencia_estoque' + '~nErro ao mudar DataStore ds_ge537_item_transf_cd.'
		RETURN FALSE
	END IF
	
	ll_linhas = lds_lotes.Retrieve(il_nr_pedido_distribuidora, il_cd_filial)
	
	IF ll_linhas < 0 THEN
		ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_transferencia_estoque' + '~nErro ao recuperar lotes da nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia.'
		RETURN FALSE
	END IF
	
	IF ll_linhas = 0 THEN
		// Sem lotes, n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ o que cancelar
		RETURN TRUE
	END IF
	
	// Para cada lote, chama a movimenta$$HEX2$$e700e300$$ENDHEX$$o de cancelamento
	FOR ll_for = 1 TO ll_linhas
		ll_cd_produto = lds_lotes.GetItemNumber(ll_for, "cd_produto")
		ls_nr_lote = lds_lotes.GetItemString(ll_for, "nr_lote")
		ldt_validade = lds_lotes.GetItemDateTime(ll_for, "dh_validade")
		ll_qt_separada = lds_lotes.GetItemNumber(ll_for, "qt_separada")
		ll_qt_caixa_padrao = lds_lotes.GetItemNumber(ll_for, "qt_caixa_padrao")  
		ll_cd_filial_destino = lds_lotes.GetItemNumber(ll_for, "cd_filial_destino")
		
		IF NOT wf_movimenta_canc_est_transf_cds(il_cd_filial, ll_cd_filial_destino, ll_cd_produto, ls_nr_lote, ldt_validade, ll_qt_separada, REF ps_log, ll_qt_caixa_padrao) THEN
			RETURN FALSE
		END IF
	NEXT
	
	IF NOT wf_atualiza_transf_cds(il_cd_filial, ll_cd_filial_destino, TRUE, REF ps_log) THEN
		ps_log = 'Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de situa$$HEX2$$e700e300$$ENDHEX$$o da transfer$$HEX1$$ea00$$ENDHEX$$ncia. Err: ' + ps_log
		RETURN FALSE
	END IF
	
	RETURN TRUE
CATCH (RuntimeError re)
	ps_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_cancela_transferencia_estoque' + '~nErro: ' + re.GetMessage()
	RETURN FALSE
FINALLY
	IF IsValid(lds_lotes) THEN DESTROY lds_lotes
END TRY
end function

public function boolean wf_movimenta_est_transf_cds (long al_cd_filial_origem, long al_cd_filial_destino, string as_log);/* Movimenta saida do CD origem e entrada do CD destino */
Boolean lb_sucesso = false
DateTime ldt_dh_validade
Long ll_qt_restante_a_faturar, ll_rows, ll_for, ll_cd_produto, ll_qt_separada, ll_qt_caixa_padrao
String	ls_nulo, ls_cd_end_exped_transf, ls_cd_end_receb_transf, ls_nr_lote

dc_uo_ds_base ldc_uo_ds_base
uo_ge258_movimentacao lo_Movimentacao


SetNull(ls_Nulo)

try
	if IsNull(il_nr_pedido_distribuidora) then
		as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado o n$$HEX1$$fa00$$ENDHEX$$mero do pedido referente a transfer$$HEX1$$ea00$$ENDHEX$$ncia entre CDs.'
		lb_sucesso = False
		return FALSE
	end if
	
	if not of_busca_endereco_receb_transf(al_cd_filial_destino, REF ls_cd_end_receb_transf, REF as_log) then return FALSE
	if not of_busca_endereco_expedicao_transf(al_cd_filial_origem, REF ls_cd_end_exped_transf, REF as_log) then return FALSE
	
	if IsNull(ls_cd_end_exped_transf) or ls_cd_end_exped_transf = '' then
		as_log = 'Endere$$HEX1$$e700$$ENDHEX$$o de expedi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o encontrado para realizar a transfer$$HEX1$$ea00$$ENDHEX$$ncia entre CDs.'
		lb_sucesso = False
		return FALSE
    end if
	 
    if IsNull(ls_cd_end_receb_transf) or ls_cd_end_receb_transf = '' then
		as_log = 'Endere$$HEX1$$e700$$ENDHEX$$o de recebimento n$$HEX1$$e300$$ENDHEX$$o encontrado para realizar a transfer$$HEX1$$ea00$$ENDHEX$$ncia entre CDs.'
		lb_sucesso = False
		return FALSE
    end if
	
	SELECT 
		sum(qt_atendida - qt_faturada) 
	INTO
		:ll_qt_restante_a_faturar
	FROM
		dbo.pedido_distribuidora_produto pdp 
	WHERE
		pdp.nr_pedido_distribuidora = :il_nr_pedido_distribuidora 
		AND pdp.cd_filial = :il_cd_filial_destino;
	
	Choose Case SQLCA.SQLCode
		Case -1
			as_log = 'Erro ao localizar total restante a faturar do pedido.~r~rError: ' + SQLCA.SQLErrText
			lb_sucesso = False
        		return FALSE
		Case 100
			as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi localizado pedidos referentes a transfer$$HEX1$$ea00$$ENDHEX$$ncia entre CDs.'
			lb_sucesso = False
        		return FALSE
	End Choose
	
	if ll_qt_restante_a_faturar > 0 then
		/* N$$HEX1$$e300$$ENDHEX$$o movimenta estoque, pois, ainda h$$HEX1$$e100$$ENDHEX$$ produtos a serem faturados e s$$HEX1$$f300$$ENDHEX$$ movimenta ap$$HEX1$$f300$$ENDHEX$$s faturar o pedido inteiro */
		lb_sucesso = True
		Return True
	else
		
		ldc_uo_ds_base = Create dc_uo_ds_base
		
		If Not ldc_uo_ds_base.of_ChangeDataObject("ds_ge537_item_transf_cd") Then
			as_log = "Erro no ChangeDataObject da ds_ge537_item_transf_cd"
			Return False
		End If
		
		ll_rows = ldc_uo_ds_base.Retrieve(il_nr_pedido_distribuidora, il_cd_filial)
		
		if ll_rows <= 0 then
			as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel recuperar os materiais da transfer$$HEX1$$ea00$$ENDHEX$$ncia para realizar as movimenta$$HEX2$$e700f500$$ENDHEX$$es de estoque entre CDs.'
			lb_sucesso = False
			Return False
		end if
		
		lo_Movimentacao = Create uo_ge258_movimentacao
		lo_Movimentacao.ivb_Commit = False
		lo_Movimentacao.ib_mostra_erro_tela = False	
		
		for ll_for = 1 to ll_rows
			ll_cd_produto		= ldc_uo_ds_base.GetItemNumber(ll_for, 'cd_produto')
			ls_nr_lote			= ldc_uo_ds_base.GetItemString(ll_for, 'nr_lote')
			ll_qt_separada		= ldc_uo_ds_base.GetItemNumber(ll_for, 'qt_separada')
			ll_qt_caixa_padrao	= ldc_uo_ds_base.GetItemNumber(ll_for, 'qt_caixa_padrao')
			ldt_dh_validade		= ldc_uo_ds_base.GetItemDateTime(ll_for, 'dh_validade')
			
			If Not lo_Movimentacao.of_insere_movimentacao(	ls_nulo, &
																			ls_cd_end_exped_transf, &
																			ll_cd_produto, &
																			ll_qt_caixa_padrao,&
																			ls_nr_lote, &
																			Date(ldt_dh_validade), &
																			ll_qt_separada, &
																			"3", &
																			al_cd_filial_origem, &
																			ls_nulo, &  
																			il_nr_nf, &
																			is_de_especie, &
																			is_de_serie, &
																			'14330') Then
				SqlCa.of_Rollback()
				as_log	= 'Erro na movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque da sa$$HEX1$$ed00$$ENDHEX$$da do material da expedi$$HEX2$$e700e300$$ENDHEX$$o do CD de origem. ~r~r' + lo_Movimentacao.is_log_erro
				Return False
			End If
			
			If Not lo_Movimentacao.of_insere_movimentacao(	ls_cd_end_receb_transf, &
																			ls_nulo, &
																			ll_cd_produto, &
																			ll_qt_caixa_padrao,&
																			ls_nr_lote, &
																			Date(ldt_dh_validade), &
																			ll_qt_separada, &
																			"4", &
																			al_cd_filial_origem, &
																			ls_nulo, &  
																			il_nr_nf, &
																			is_de_especie, &
																			is_de_serie, &
																			'14330') Then
				SqlCa.of_Rollback()
				as_log	= 'Erro na movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque da entrada do material do recebimento do CD de destino. ~r~r' + lo_Movimentacao.is_log_erro
				Return False
			End If
		next
	end if
	
	lb_sucesso = True
Catch (RunTimeError RTE)
	as_log	= 'RunTimeError wf_movimenta_est_transf_cds: ' + RTE.GetMessage()
	lb_sucesso = False
	SqlCa.of_Rollback()
Finally
	if IsValid(lo_Movimentacao) then Destroy lo_Movimentacao
End Try

Return lb_sucesso
end function

public function boolean wf_movimenta_canc_est_transf_cds (long al_cd_filial_origem, long al_cd_filial_destino, long al_cd_produto, string as_nr_lote, datetime adt_dh_validade, long al_qt_lote, ref string as_log, long al_qt_caixa_padrao);/* Movimenta saida do CD origem e entrada do CD destino */
Long ll_nulo
String ls_nulo, ls_cd_end_exped_transf, ls_cd_end_receb_transf

uo_ge258_movimentacao lo_Movimentacao

SetNull(ll_Nulo)
SetNull(ls_Nulo)

if not of_busca_endereco_receb_transf(al_cd_filial_destino, REF ls_cd_end_receb_transf, REF as_log) then return FALSE
if not of_busca_endereco_expedicao_transf(al_cd_filial_origem, REF ls_cd_end_exped_transf, REF as_log) then return FALSE

lo_Movimentacao = Create uo_ge258_movimentacao

lo_Movimentacao.ivb_Commit = False
lo_Movimentacao.ib_mostra_erro_tela = False

If Not lo_Movimentacao.of_insere_movimentacao( ls_cd_end_exped_transf, &
                                                              ls_nulo, &
                                                              al_cd_produto, &
                                                              al_qt_caixa_padrao,&
                                                              as_nr_Lote, &
                                                              Date(adt_dh_validade), &
                                                              al_qt_lote, &
                                                              "5", &
                                                              al_cd_filial_origem, &
                                                              ls_nulo, &  
                                                              il_nr_nf, &
                                                              is_de_especie, &
                                                              is_de_serie, &
                                                              '14330') Then
    SqlCa.of_Rollback()
    as_log = 'Erro na movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque do cancelamento da sa$$HEX1$$ed00$$ENDHEX$$da do material da expedi$$HEX2$$e700e300$$ENDHEX$$o do CD de origem. ~r~r' + lo_Movimentacao.is_log_erro
    Return False
End If

If Not lo_Movimentacao.of_insere_movimentacao(ls_nulo , &
                                                              ls_cd_end_receb_transf, &
                                                              al_cd_produto, &
                                                              al_qt_caixa_padrao, &
                                                              as_nr_Lote, &
                                                              Date(adt_dh_validade), &
                                                              al_qt_lote, &
                                                              "6", &
                                                              al_cd_filial_destino, &
                                                              ls_nulo, &  
                                                              il_nr_nf, &
                                                              is_de_especie, &
                                                              is_de_serie, &
                                                              '14330') Then
    SqlCa.of_Rollback()
    as_log = 'Erro na movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque do cancelamento da entrada do material do recebimento do CD de destino. ~r~r' + lo_Movimentacao.is_log_erro
    Return False
End If

// Se chegou at$$HEX1$$e900$$ENDHEX$$ aqui, tudo ocorreu bem
Destroy lo_Movimentacao
Return True
end function

public function boolean wf_atualiza_transf_cds (long al_cd_filial_origem, long al_cd_filial_destino, boolean ab_cancelamento, string as_log);/* Movimenta saida do CD origem e entrada do CD destino */
Boolean lb_sucesso = false
DateTime ldt_dh_validade, ldt_dt_faturamento
Long ll_qt_restante_a_faturar, ll_rows, ll_for, ll_cd_produto, ll_qt_separada, ll_qt_caixa_padrao
String	ls_nulo, ls_cd_end_exped_transf, ls_cd_end_receb_transf, ls_nr_lote, ls_id_situacao

dc_uo_ds_base ldc_uo_ds_base
uo_ge258_movimentacao lo_Movimentacao


SetNull(ls_Nulo)

try
	if IsNull(il_nr_pedido_distribuidora) then
		as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado o n$$HEX1$$fa00$$ENDHEX$$mero do pedido referente a transfer$$HEX1$$ea00$$ENDHEX$$ncia entre CDs.'
		lb_sucesso = False
		return FALSE
	end if

	SELECT
		wte.nr_transferencia
	INTO
		:il_nr_transferencia
	FROM
		wms_transferencia_estoque wte
	WHERE
		wte.nr_pedido_distribuidora	= :il_nr_pedido_distribuidora
		AND wte.cd_filial_origem = :al_cd_filial_origem
		AND wte.cd_filial_destino = :al_cd_filial_destino;
		
	Choose Case SQLCA.SQLCode
		Case -1
			as_log = 'Erro ao consultar a solicita$$HEX2$$e700e300$$ENDHEX$$o de transfer$$HEX1$$ea00$$ENDHEX$$ncia do pedido ' + String(il_nr_pedido_distribuidora) + '.~r~rErro: ' + SQLCA.SQLErrText
			Return False
		Case 100
			as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado a solicita$$HEX2$$e700e300$$ENDHEX$$o de transfer$$HEX1$$ea00$$ENDHEX$$ncia do pedido ' + String(il_nr_pedido_distribuidora) + '.'
			Return False
	End Choose
	
	if il_nr_transferencia <= 0 or IsNull(il_nr_transferencia) then
		as_log = 'Problema ao encontrar a solicita$$HEX2$$e700e300$$ENDHEX$$o de transfer$$HEX1$$ea00$$ENDHEX$$ncia referente ao pedido: ' + String(il_nr_pedido_distribuidora) + '.'
		Return False
	end if
	
	if ab_cancelamento then
		ls_id_situacao = 'P' //Volta para separa$$HEX2$$e700e300$$ENDHEX$$o
		SetNull(ldt_dt_faturamento)
	else
		ls_id_situacao = 'F' //Faturado
		ldt_dt_faturamento = gf_GetServerDate()
	end if
	
	UPDATE
		wms_transferencia_estoque
	SET
		id_situacao = :ls_id_situacao,
		dh_faturamento = :ldt_dt_faturamento
	WHERE
		nr_transferencia = :il_nr_transferencia;
	
	Choose Case SQLCA.SQLCode
		Case -1
			as_log = 'Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o da solicita$$HEX2$$e700e300$$ENDHEX$$o de transfer$$HEX1$$ea00$$ENDHEX$$ncia ' + String(il_nr_transferencia) + '.~r~rErro: ' + SQLCA.SQLErrText
			Return False
	End Choose
	
	if ls_id_situacao = 'F' then
		UPDATE
			wms_transferencia_estoque_prd
		SET
			qt_faturada = qt_separada
		WHERE
			nr_transferencia = :il_nr_transferencia;
	else
		UPDATE
			wms_transferencia_estoque_prd
		SET
			qt_faturada = 0
		WHERE
			nr_transferencia = :il_nr_transferencia;
	end if
	
	Choose Case SQLCA.SQLCode
		Case -1
			as_log = 'Erro ao atualizar a quantidade faturada dos itens da solicita$$HEX2$$e700e300$$ENDHEX$$o de transfer$$HEX1$$ea00$$ENDHEX$$ncia ' + String(il_nr_transferencia) + '.~r~rErro: ' + SQLCA.SQLErrText
			Return False
	End Choose
	
	lb_sucesso = True
Catch (RunTimeError RTE)
	as_log	= 'RunTimeError wf_movimenta_est_transf_cds: ' + RTE.GetMessage()
	lb_sucesso = False
	SqlCa.of_Rollback()
Finally
	if IsValid(lo_Movimentacao) then Destroy lo_Movimentacao
End Try

Return lb_sucesso
end function

on uo_ge537_nota_fiscal.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge537_nota_fiscal.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;iuo_ge473_comum 				= Create uo_ge473_comum
idc_uo_ds_base_nota			= Create dc_uo_ds_base
idc_uo_ds_base_item 			= Create dc_uo_ds_base
idc_uo_ds_base_item_imp		= Create dc_uo_ds_base
idc_uo_ds_base_item_lote	= Create dc_uo_ds_base
idc_melhor_compra				= Create dc_uo_ds_base
idc_valida_nf_transf			= Create dc_uo_ds_base
ivo_Parametro         		= Create uo_parametro_geral
end event

event destructor;if IsValid(iuo_ge473_comum) then destroy iuo_ge473_comum
if IsValid(idc_uo_ds_base_nota) then destroy idc_uo_ds_base_nota
if IsValid(idc_uo_ds_base_item) then destroy idc_uo_ds_base_item
if IsValid(idc_uo_ds_base_item_imp) then destroy idc_uo_ds_base_item_imp
if IsValid(idc_uo_ds_base_item_lote) then destroy idc_uo_ds_base_item_lote
if IsValid(idc_melhor_compra) then destroy idc_melhor_compra
if IsValid(idc_valida_nf_transf) then destroy idc_valida_nf_transf
if IsValid(ivds_lotes_dev) then destroy ivds_lotes_dev
end event

