HA$PBExportHeader$uo_ge481_nf_transferencia_loja.sru
forward
global type uo_ge481_nf_transferencia_loja from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_nf_transferencia_loja from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long		il_nr_atualizacao, il_cd_filial_origem, il_nr_nf
String	is_id_tipo_nf, is_de_serie, is_de_especie
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
end prototypes

public function boolean _of_parametros ();//override
is_inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
   						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_TRANSLOJA_REQ>'
						
is_termino_XML	=	'</imp:MT_TRANSLOJA_REQ>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_ds = 'ds_ge481_nf_transferencia_loja'
is_objeto = this.ClassName()
is_nome_arquivo = 'transferencia_loja'
is_parametro_url = 'CD_URL_LOJA_NF_TRANSFERENCIA'
is_tipo_log_exp = 'LOJA_NF_TRANSFERENCIA'
is_descricao_tipo_log = 'LOJA_NF_TRANSFERENCIA'
is_nome_interface = 'LOJA_NF_TRANSFERENCIA'

ii_contador_xml = 1

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere("id_status_integracao = 'C' " )
end if

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);Long 		ll_contador = 1
String 	ls_status


//Aguardar para ver a mensagem real do retorno
ls_status = of_busca_valor(as_xml, '<STATUS>', ref ll_contador)

if Trim(left(ls_status, 31)) <> 'Processo realizado com sucesso' and Trim(ls_status) <> 'Integrado com sucesso' then	
	this.of_atualiza_processado( il_nr_atualizacao, 'E', ls_status, ref as_log)
else
	if Not this.of_atualiza_processado( il_nr_atualizacao, 'S', '', ref as_log) then return false
	
	if is_id_tipo_nf = '156' then
		update nf_transferencia
			set dh_enviado_sap	= getdate()
		 where cd_filial_origem	= :il_cd_filial_origem
		 	and nr_nf				= :il_nr_nf
			and de_serie			= :is_de_serie
			and de_especie			= :is_de_especie;
	else
		update nf_diversa
			set dh_enviado_sap	= getdate()
		 where cd_filial_origem	= :il_cd_filial_origem
		 	and nr_nf				= :il_nr_nf
			and de_serie			= :is_de_serie
			and de_especie			= :is_de_especie;
	end if
	
	choose case sqlca.sqlcode
		case -1
			as_log	= 'Erro ao atualizar nf com data de recebimento do SAP.' + SQLCA.SQLErrText
			return false
	end choose
end if

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);DateTime	ldt_dh_documento, ldt_dh_fabricacao, ldt_dh_validade, ldt_dh_envio
Dec{2}	ldc_vl_custo_unitario, ldc_base, ldc_rate, ldc_taxval, ldc_othbas, ldc_vl_total_nf, ldc_tax_difference, &
			ldc_srate, ldc_rate4dec, ldc_pauta_base, ldc_factor, ldc_factor4dec, ldc_excbas, ldc_basered1, ldc_basered2, &
			ldc_vl_custo_unitario_nf, ldc_pc_fcp, ldc_vl_fcp, ldc_total_item
Long		ll_total_linhas, ll_for, ll_qt_lote, ll_cd_filial_destino, &
			ll_for_impostos, ll_nr_sequencial, ll_cd_natureza_operacao, ll_cd_integer
String	ls_cd_produto_sap, ls_cd_unidade_medida_venda, ls_nr_lote, &
			ls_store, ls_qt_lote, ls_vl_custo_unitario, ls_dh_validade, ls_dh_fabricacao, &
			ls_centro, ls_de_dados_adicionais, ls_cd_transportadora_sap, ls_nr_protocolo_envio, ls_dh_envio, &
			ls_docnum9, ls_taxgrp, ls_base, ls_rate, ls_taxval, ls_othbas, ls_taxtyp, ls_cd_cst_tributacao, &
			ls_vl_total_nf, ls_de_chave_acesso, ls_proctrt, ls_tp_po, ls_nr_cgc, ls_rate4dec, ls_tax_difference, &
			ls_srate, ls_pauta_base, ls_factor, ls_factor4dec, ls_excbas, ls_basered1, ls_basered2, &
			ls_de_chave_acesso_origem, ls_cd_fornecedor_sap, ls_cd_fornecedor, ls_cd_cst_cofins, ls_cd_cst_pis, &
			ls_cd_varchar, ls_cd_cst_icms, ls_cd_cst_ipi, ls_po

dc_uo_ds_base ldc_uo_ge481_nf_transferencia_loja
ldc_uo_ge481_nf_transferencia_loja = create dc_uo_ds_base


try
	il_nr_atualizacao		= pds_dados.Object.nr_atualizacao[pl_linha]
	il_cd_filial_origem	= pds_dados.Object.cd_filial[pl_linha]
	il_nr_nf					= pds_dados.Object.nr_nf[pl_linha]
	is_de_serie				= pds_dados.Object.de_serie[pl_linha]
	is_de_especie			= pds_dados.Object.de_especie[pl_linha]
	ldt_dh_documento		= pds_dados.Object.dh_documento[pl_linha]
	ls_centro				= pds_dados.Object.centro[pl_linha]
	is_id_tipo_nf			= pds_dados.Object.id_tipo_nf[pl_linha]
	ls_cd_varchar			= pds_dados.Object.cd_varchar[pl_linha]
	ll_cd_integer			= pds_dados.Object.cd_integer[pl_linha]
	
	If Not ldc_uo_ge481_nf_transferencia_loja.of_changedataobject('ds_ge481_nf_transferencia_loja_dados', False) Then
		ps_log = "Erro ao alterar a DW 'ds_ge481_nf_transferencia_loja_dados'."
		return false
	end if
	
	if ISNull(ll_cd_integer ) then ll_cd_integer = 0
	
	ll_total_linhas	= ldc_uo_ge481_nf_transferencia_loja.Retrieve(il_cd_filial_origem, il_nr_nf, is_de_serie, is_de_especie, is_id_tipo_nf)
			
	If ll_total_linhas = 0 Then
		ps_log = "Nenhum produto foi localizado  na DW 'ds_ge481_nf_transferencia_loja_dados'."
		return false
	ElseIf ll_total_linhas < 0 Then
		ps_log = "Erro ao localizar os itens na DW 'ds_ge481_nf_transferencia_loja_dados'."
		return false
	End If
	
	if is_id_tipo_nf = '156' then
		select Coalesce(nt.de_dados_adicionais, ''),
				 Coalesce(f.cd_fornecedor_sap, '') as cd_transportadora,
				 Coalesce(nte.nr_protocolo_envio, ''),
				 nte.dh_envio,
				 Coalesce(SubString(nte.de_chave_acesso,35,9), ''),
				 nt.vl_total_nf,
				 nte.de_chave_acesso
		  into :ls_de_dados_adicionais,
				 :ls_cd_transportadora_sap,
				 :ls_nr_protocolo_envio,
				 :ldt_dh_envio,
				 :ls_docnum9,
				 :ldc_vl_total_nf,
				 :ls_de_chave_acesso
		  from nf_transferencia nt left outer join nf_transferencia_nfe nte on nt.nr_nf 					= nte.nr_nf and
																									  nt.de_serie 				= nte.de_serie and
																									  nt.de_especie			= nte.de_especie and
																									  nt.cd_filial_origem	= nte.cd_filial_origem
											left outer join fornecedor f on nte.cd_transportadora = f.cd_fornecedor
		 where nt.nr_nf 				= :il_nr_nf and
				 nt.de_serie 			= :is_de_serie and
				 nt.de_especie			= :is_de_especie and
				 nt.cd_filial_origem	= :il_cd_filial_origem;

		if ll_total_linhas > 0 then
			ll_cd_natureza_operacao		= ldc_uo_ge481_nf_transferencia_loja.object.cd_natureza_operacao[1]
		end if
	Elseif is_id_tipo_nf = 'BLE' then
		if ll_total_linhas > 0 then
			ls_de_dados_adicionais	= ldc_uo_ge481_nf_transferencia_loja.object.de_dados_adicionais[1]
		end if
		
		select Coalesce(f.cd_fornecedor_sap, '') as cd_transportadora,
				 Coalesce(nde.nr_protocolo_envio, ''),
				 nde.dh_envio,
				 Coalesce(SubString(nde.de_chave_acesso,35,9), ''),
				 nd.vl_total_nf,
				 nde.de_chave_acesso
		  into :ls_cd_transportadora_sap,
				 :ls_nr_protocolo_envio,
				 :ldt_dh_envio,
				 :ls_docnum9,
				 :ldc_vl_total_nf,
				 :ls_de_chave_acesso
		  from nf_diversa nd left outer join nf_diversa_nfe nde on nd.nr_nf 					= nde.nr_nf and
																					  nd.de_serie 				= nde.de_serie and
																					  nd.de_especie			= nde.de_especie and
																					  nd.cd_filial_origem	= nde.cd_filial_origem
									left outer join fornecedor f on nde.cd_transportadora = f.cd_fornecedor
		 where nd.nr_nf 				= :il_nr_nf and
				 nd.de_serie 			= :is_de_serie and
				 nd.de_especie			= :is_de_especie and
				 nd.cd_filial_origem	= :il_cd_filial_origem;
	Elseif is_id_tipo_nf = 'WDL' then
		if ll_total_linhas > 0 then
			ls_de_dados_adicionais	= ldc_uo_ge481_nf_transferencia_loja.object.de_dados_adicionais[1]
		end if
			
		select Coalesce(f.cd_fornecedor_sap, '') as cd_transportadora,
				 Coalesce(ndce.nr_protocolo_envio, ''),
				 ndce.dh_envio,
				 Coalesce(SubString(ndce.de_chave_acesso,35,9), ''),
				 ndc.vl_total_nf,
				 ndce.de_chave_acesso
		  into :ls_cd_transportadora_sap,
				 :ls_nr_protocolo_envio,
				 :ldt_dh_envio,
				 :ls_docnum9,
				 :ldc_vl_total_nf,
				 :ls_de_chave_acesso
		  from nf_devolucao_compra ndc left outer join nf_devolucao_compra_nfe ndce on ndc.nr_nf 			= ndce.nr_nf and
																												  ndc.de_serie 	= ndce.de_serie and
																												  ndc.de_especie	= ndce.de_especie and
																												  ndc.cd_filial 	= ndce.cd_filial
									left outer join fornecedor f on ndce.cd_transportadora = f.cd_fornecedor
		 where ndc.nr_nf 			= :il_nr_nf and
				 ndc.de_serie 		= :is_de_serie and
				 ndc.de_especie	= :is_de_especie and
				 ndc.cd_filial		= :il_cd_filial_origem;
	End If
	
	Choose Case SQLCA.SQLCode
		Case -1
			ps_log = "Erro ao buscar dados da nota (" + is_id_tipo_nf+ ")." + SQLCA.SQLErrText
			return false
		Case 100
			ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado dados da nota (" + is_id_tipo_nf+ ")."
			return false
	End Choose
	
	if IsNull(ls_de_dados_adicionais) then ls_de_dados_adicionais = ''
	
	ps_xml	= ''
	
	if not IsNull(ldt_dh_envio) then 
		ls_dh_envio	= String(ldt_dh_envio, 'yyyy-mm-dd hh:mm:ss')
	else
		ls_dh_envio	= ''
	end if
	
	if ldc_vl_total_nf > 0 then
		ls_vl_total_nf	= gf_replace(String(ldc_vl_total_nf), ',', '.', 0)
	else
		ls_vl_total_nf	= '0'
	end if
	
	ps_xml += '<HEADER>'

	ls_po	= ''
	
	if is_id_tipo_nf = '156' then
		if ls_cd_varchar = 'LEGADO' then
			ls_tp_po	= 'ZCD'
			ls_po	= String(ll_cd_integer) + String(il_nr_nf)
			
			ldt_dh_documento	= ldt_dh_envio
		else
			if ll_cd_natureza_operacao = 5209 or ll_cd_natureza_operacao = 6209 then
				ls_tp_po	= 'ZUD'
			else
				ls_tp_po	= 'UD'	
			end if			
		end if
	elseif is_id_tipo_nf = 'BLE' then
		ls_tp_po	= 'ZBON'
	else
		ls_tp_po	= 'ZFO'
	end if
	
	ps_xml += '<NUMBER_PO>'+ls_po+'</NUMBER_PO>'
	ps_xml += '<TP_PO>' + ls_tp_po + '</TP_PO>'
	ps_xml += '<CENTER_PROVIDER>' + ls_centro + '</CENTER_PROVIDER>'
	ps_xml += '<CODE_PGTO>' + '</CODE_PGTO>'
	ps_xml += '<DATE>' + String(ldt_dh_documento, 'YYYYMMDD') + '</DATE>'
	ps_xml += '<VOLUME></VOLUME>'
	ps_xml += '<KOSTL></KOSTL>'
	ps_xml += '<INFCPL>' + ls_de_dados_adicionais + '</INFCPL>'
	ps_xml += '<TRANSPORTADORA>' + ls_cd_transportadora_sap + '</TRANSPORTADORA>'
	ps_xml += '<NFENUM>' + String(il_nr_nf) + '</NFENUM>'
   ps_xml += '<AUTHCOD>' + ls_nr_protocolo_envio + '</AUTHCOD>'
   ps_xml += '<AUTHDATE_AUTHTIME>' + ls_dh_envio + '</AUTHDATE_AUTHTIME>'
   ps_xml += '<DOCNUM9>' + ls_docnum9 + '</DOCNUM9>'
	ps_xml += '<NFTOT>' + ls_vl_total_nf + '</NFTOT>'
	ps_xml += '<ACCKEY>' + ls_de_chave_acesso + '</ACCKEY>'
	
	if is_id_tipo_nf = 'WDL' then
		select nc.de_chave_acesso,
				 nc.cd_fornecedor
		  into :ls_de_chave_acesso_origem,
		  		 :ls_cd_fornecedor
		  from nf_devolucao_compra ndc inner join nf_compra nc on nc.nr_nf = ndc.nr_nf_compra and 
		  																			 nc.cd_filial	= ndc.cd_filial and
																					 nc.cd_fornecedor = ndc.cd_fornecedor and
																					 nc.de_serie = ndc.de_serie_compra and
																					 nc.de_especie = ndc.de_especie_compra
												inner join nf_devolucao_compra_nfe ndcn on ndcn.nr_nf = ndc.nr_nf and 
		  																			 ndcn.cd_filial	= ndc.cd_filial and
																					 ndcn.de_serie = ndc.de_serie and
																					 ndcn.de_especie = ndc.de_especie
		where ndcn.de_chave_acesso = :ls_de_chave_acesso;
		
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = "Erro ao buscar dados da nota de origem da devolu$$HEX2$$e700e300$$ENDHEX$$o." + SQLCA.SQLErrText
				return false
			Case 100
				ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado dados da nota de origem da devolu$$HEX2$$e700e300$$ENDHEX$$o."
				return false
		End Choose
	end if
	
	if IsNull(ls_de_chave_acesso_origem) then ls_de_chave_acesso_origem = ''
	if IsNull(ls_cd_fornecedor) then ls_cd_fornecedor = ''
	
	if not IsNull(ls_cd_fornecedor) and ls_cd_fornecedor <> '' then
		select f.cd_fornecedor_sap
		  into :ls_cd_fornecedor_sap
		  from fornecedor f
		 where f.cd_fornecedor = :ls_cd_fornecedor;
		 
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = "Erro ao buscar dados do fornecedor." + SQLCA.SQLErrText
				return false
			Case 100
				ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado dados do fornecedor."
				return false
		End Choose
	end if
	
	if IsNull(ls_cd_fornecedor_sap) then ls_cd_fornecedor_sap = ''
	
	//Enviar campos novos para devolu$$HEX2$$e700e300$$ENDHEX$$o
	ps_xml += '<NFORIGEM>' + ls_de_chave_acesso_origem + '</NFORIGEM>'
	ps_xml += '<CODFORNE>' + ls_cd_fornecedor_sap + '</CODFORNE>'
	
	if is_id_tipo_nf = '156' then
		ls_proctrt	= ''
	else
		ls_proctrt	= 'BONI'
	end if
	
	ps_xml += '<PROCTRT>' + ls_proctrt + '</PROCTRT>'

	ps_xml += '</HEADER>'
		
	for ll_for = 1 to ll_total_linhas
		ls_cd_produto_sap				= ldc_uo_ge481_nf_transferencia_loja.object.cd_produto_sap[ll_for]
		ls_cd_unidade_medida_venda	= ldc_uo_ge481_nf_transferencia_loja.object.cd_unidade_medida_venda[ll_for]
		ll_qt_lote						= ldc_uo_ge481_nf_transferencia_loja.object.qt_lote[ll_for]
		ldc_vl_custo_unitario		= ldc_uo_ge481_nf_transferencia_loja.object.vl_custo_unitario[ll_for]
		
		ldc_total_item	= ldc_vl_custo_unitario * ll_qt_lote
		
		ls_nr_lote						= ldc_uo_ge481_nf_transferencia_loja.object.nr_lote[ll_for]
		ldt_dh_fabricacao				= DateTime(ldc_uo_ge481_nf_transferencia_loja.object.dh_fabricacao[ll_for])
		ldt_dh_validade				= DateTime(ldc_uo_ge481_nf_transferencia_loja.object.dh_validade[ll_for])
		ll_cd_filial_destino			= ldc_uo_ge481_nf_transferencia_loja.object.cd_filial_destino[ll_for]
		ll_nr_sequencial				= ldc_uo_ge481_nf_transferencia_loja.object.nr_sequencial[ll_for]
		ls_nr_cgc						= ldc_uo_ge481_nf_transferencia_loja.object.nr_cgc_cpf[ll_for]
		ll_cd_natureza_operacao		= ldc_uo_ge481_nf_transferencia_loja.object.cd_natureza_operacao[ll_for]
		ls_cd_cst_cofins				= ldc_uo_ge481_nf_transferencia_loja.object.cd_cst_cofins[ll_for]
		ls_cd_cst_pis					= ldc_uo_ge481_nf_transferencia_loja.object.cd_cst_pis[ll_for]
		ls_cd_cst_icms					= ldc_uo_ge481_nf_transferencia_loja.object.cd_cst_icms[ll_for]
		ldc_vl_custo_unitario_nf	= ldc_uo_ge481_nf_transferencia_loja.object.vl_custo_unitario_nf[ll_for]
		
		If IsNull(ls_cd_produto_sap) or ls_cd_produto_sap = '' then
			ps_log = "C$$HEX1$$f300$$ENDHEX$$digo do produto SAP est$$HEX1$$e100$$ENDHEX$$ vazio {cd_produto_sap}."
			return false
		end if
		
		If IsNull(ls_cd_unidade_medida_venda) or ls_cd_unidade_medida_venda = '' then
			ps_log = "Unidade de medida est$$HEX1$$e100$$ENDHEX$$ vazia {ls_cd_unidade_medida_venda}."
			return false
		end if
		
		if IsNull(ll_qt_lote) then
			ps_log = "Qt Lote est$$HEX1$$e100$$ENDHEX$$ vazio {qt_lote}."
			return false
		end if
		
		if IsNull(ll_cd_natureza_operacao) then
			ps_log = "CFOP est$$HEX1$$e100$$ENDHEX$$ vazio {cd_natureza_operacao}."
			return false
		end if
		
		if IsNull(ldc_vl_custo_unitario) then
			ps_log = "Vl Custo Unit$$HEX1$$e100$$ENDHEX$$rio est$$HEX1$$e100$$ENDHEX$$ vazio {vl_custo_unitario}."
			return false
		end if
		
		if IsNull(ls_nr_lote) then
			ls_nr_lote	= ''
		end if
				
		ls_qt_lote 				= String(ll_qt_lote)
		ls_vl_custo_unitario	= gf_replace(String(ldc_vl_custo_unitario), ',', '.', 0)
		
		if is_id_tipo_nf = '156' then
			if not IsNull(ldt_dh_validade) then			
				if IsNull(ldt_dh_fabricacao) then
					ldt_dh_fabricacao = DateTime(RelativeDate(Date(ldt_dh_validade), -90))
				end if
				
				ls_dh_validade			= String(ldt_dh_validade, 'YYYYMMDD')
				ls_dh_fabricacao		= String(ldt_dh_fabricacao, 'YYYYMMDD')
			else
				ls_dh_validade		= ''
				ls_dh_fabricacao	= ''
			end if
			
			if ls_cd_varchar = 'LEGADO' then
				ls_vl_custo_unitario	= gf_replace(String(ldc_vl_custo_unitario_nf), ',', '.', 0)
			end if
			
			if ll_cd_filial_destino = 1 then
				ls_store = '1156'
			else
				//Enviar STORE vazio para devolu$$HEX2$$e700e300$$ENDHEX$$o
				select cd_chave_sap 
				  into :ls_store
				  from integracao_sap
				 where cd_chave_legado 	= cast(:ll_cd_filial_destino as varchar(10)) and 
						 cd_tabela 			= 'FILIAL' and 
						 cd_empresa 		= 1000;
				
				choose case sqlca.sqlcode
					case 100
						ps_log = "C$$HEX1$$f300$$ENDHEX$$digo da filial de destino do SAP n$$HEX1$$e300$$ENDHEX$$o encontrado {cd_chave_sap}."
						return false
					case -1
						ps_log = "Erro ao buscar c$$HEX1$$f300$$ENDHEX$$digo do SAP da filial de destino {cd_chave_sap}."
						return false
				end choose
				
				if IsNull(ls_store) then
					ps_log = "C$$HEX1$$f300$$ENDHEX$$digo da filial de destino do SAP est$$HEX1$$e100$$ENDHEX$$ vazio {cd_chave_sap}."
					return false
				end if
			end if
		elseif is_id_tipo_nf = 'BLE' then
			ls_store	= ''
			
			select cd_cliente_sap 
			  into :ls_store
			  from cliente
			 where nr_cpf_cgc	= :ls_nr_cgc;
			 
			choose case sqlca.sqlcode
				case 100
					ps_log = "C$$HEX1$$f300$$ENDHEX$$digo do cliente SAP n$$HEX1$$e300$$ENDHEX$$o encontrado {cd_cliente_sap}. CGC: " + ls_nr_cgc
					return false
				case -1
					ps_log = "Erro ao buscar c$$HEX1$$f300$$ENDHEX$$digo do SAP da filial de destino {cd_chave_sap}. CGC: " + ls_nr_cgc + ' Erro: ' + SQLCA.SQLErrText
					return false
			end choose
			
			if IsNull(ls_store) or trim(ls_store) = '' then
				ps_log = "Cliente est$$HEX1$$e100$$ENDHEX$$ sem c$$HEX1$$f300$$ENDHEX$$digo SAP. CGC: " + ls_nr_cgc
				return false
			end if
		else
			ls_store = ''
		end if
	  
	   ll_nr_sequencial = ll_nr_sequencial * 10
		
		ls_cd_cst_ipi		= ''
		
		ps_xml += '<ITEM>'
		ps_xml += '<ITEM_PO>' + String(ll_nr_sequencial) + '</ITEM_PO>'
		ps_xml += '<MATERIAL>' + ls_cd_produto_sap + '</MATERIAL>'
		ps_xml += '<UNIDADE_MEDIDA>' + ls_cd_unidade_medida_venda + '</UNIDADE_MEDIDA>'
		ps_xml += '<AMOUNT>' + ls_qt_lote + '</AMOUNT>'
		ps_xml += '<PRICE>' + ls_vl_custo_unitario + '</PRICE>'
		ps_xml += '<DESCONTO>0</DESCONTO>'
		ps_xml += '<STORE>' + ls_store + '</STORE>'
		ps_xml += '<DATE_SHIPPING>' + '</DATE_SHIPPING>'
		ps_xml += '<BATCH>' + ls_nr_lote + '</BATCH>'
		ps_xml += '<PROD_DATE>' + ls_dh_fabricacao + '</PROD_DATE>'
		ps_xml += '<EXPIRYDATE>' + ls_dh_validade + '</EXPIRYDATE>'
		ps_xml += '<LGORT>' + '</LGORT>' 
		ps_xml += '<UMLGO>' + '</UMLGO>' 
		ps_xml += '<TAXTYP>' + '</TAXTYP>'
		ps_xml += '<BASE>' + '</BASE>'
		ps_xml += '<RATE>' + '</RATE>'
		ps_xml += '<CFOP>' + String(ll_cd_natureza_operacao) + '</CFOP>'
		ps_xml += '<PIS>' + ls_cd_cst_pis + '</PIS>'
		ps_xml += '<COFINS>' + ls_cd_cst_cofins + '</COFINS>'
		ps_xml += '<TAXLW1>' + ls_cd_cst_icms + '</TAXLW1>' //CST do ICMS
		ps_xml += '<TAXLW2>' + ls_cd_cst_ipi + '</TAXLW2>' //CST do IPI
		ps_xml += '<TAXLW4>' + ls_cd_cst_cofins + '</TAXLW4>' //CST do COFINS
		ps_xml += '<TAXLW5>' + ls_cd_cst_pis + '</TAXLW5>' //CST do PIS

		For ll_for_impostos = 1 to 5
			Choose Case ll_for_impostos
				case 1
					ls_cd_cst_tributacao	= ldc_uo_ge481_nf_transferencia_loja.Object.cd_cst_tributacao[ll_for]
					
					ldc_tax_difference	= 0
					ldc_srate				= 0
					ldc_pauta_base			= 0
					ldc_factor				= 0
					ldc_factor4dec			= 0
					ldc_excbas				= 0
					ldc_basered1			= 0
					ldc_basered2			= 0
					ldc_rate					= 0
					ldc_rate4dec			= 0
					ldc_taxval				= 0
					ldc_base					= 0
					ldc_othbas				= 0
					
					if is_id_tipo_nf = '156' then
						if ls_cd_varchar = 'LEGADO' then
							choose case ls_cd_cst_tributacao
								case '00'
									ldc_rate			= ldc_uo_ge481_nf_transferencia_loja.Object.pc_icms[ll_for]
									ldc_taxval		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_icms[ll_for]
									ldc_base			= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
								case '10'
									ldc_rate			= ldc_uo_ge481_nf_transferencia_loja.Object.pc_icms[ll_for]
									ldc_taxval		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_icms[ll_for]
									ldc_base			= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
								case '20'
									ldc_excbas		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
								case '30'
									ldc_excbas		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
								case '40'
									ldc_excbas		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
									
									if ldc_excbas = 0 then
										ldc_excbas	= ldc_total_item
									end if
								case '41'
									ldc_excbas		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
									
									if ldc_excbas = 0 then
										ldc_excbas	= ldc_total_item
									end if
								case '50'
									ldc_othbas		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
									
									if ldc_othbas = 0 then
										ldc_othbas	= ldc_total_item
									end if
								case '51'
									ldc_othbas		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
									
									if ldc_othbas = 0 then
										ldc_othbas	= ldc_total_item
									end if
								case '60'
									ldc_othbas		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
									
									if ldc_othbas = 0 then
										ldc_othbas	= ldc_total_item
									end if
								case '70'
									ldc_othbas		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
									
									if ldc_othbas = 0 then
										ldc_othbas	= ldc_total_item
									end if
								case '90'
									ldc_othbas		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
									
									if ldc_othbas = 0 then
										ldc_othbas	= ldc_total_item
									end if
							end choose
						else
							choose case ls_cd_cst_tributacao
								case '51'
									ldc_othbas		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
								case else
									ldc_rate			= ldc_uo_ge481_nf_transferencia_loja.Object.pc_icms[ll_for]
									ldc_rate4dec	= 0
									ldc_taxval		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_icms[ll_for]
									ldc_base			= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
							end choose
						end if
					else
						ldc_base		= 0
						ldc_othbas	= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms[ll_for]
					end if
					
					ls_taxgrp	= 'ICMS'
					ls_taxtyp	= 'ICM0'					
					
					
				case 2
					ls_taxgrp	= 'PIS'
					ldc_base		= 0
					ldc_othbas	= 0
					ldc_rate		= 0
					ldc_taxval	= 0
					ls_taxtyp	= 'IPIS'
				case 3
					ls_taxgrp	= 'COFI'
					ldc_base		= 0
					ldc_othbas	= 0
					ldc_rate		= 0
					ldc_taxval	= 0
					ls_taxtyp	= 'ICOF'
				case 4
					ls_taxgrp	= 'ST'
					ls_taxtyp	= 'ST3'
					
					ldc_pc_fcp	= ldc_uo_ge481_nf_transferencia_loja.Object.pc_fcp[ll_for]
					ldc_vl_fcp	= ldc_uo_ge481_nf_transferencia_loja.Object.vl_fcp[ll_for]
					
					ldc_rate			= ldc_uo_ge481_nf_transferencia_loja.Object.pc_icms_st[ll_for]
					ldc_taxval		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_icms_st[ll_for]
					ldc_base			= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms_st[ll_for]
					
					if IsNull(ldc_pc_fcp) then ldc_pc_fcp = 0
					if IsNull(ldc_vl_fcp) then ldc_vl_fcp = 0
					if IsNull(ldc_rate) then ldc_rate = 0
					if IsNull(ldc_taxval) then ldc_taxval = 0
					
					ldc_rate		= ldc_rate - ldc_pc_fcp
					ldc_taxval	= ldc_taxval - ldc_vl_fcp
					
					ldc_rate4dec	= 0					
					ldc_othbas		= 0
				case 5
					ls_taxgrp	= 'FCP'
					ls_taxtyp	= 'ICFP'
					
					ldc_rate			= ldc_uo_ge481_nf_transferencia_loja.Object.pc_fcp[ll_for]
					ldc_rate4dec	= 0
					ldc_taxval		= ldc_uo_ge481_nf_transferencia_loja.Object.vl_fcp[ll_for]
					ldc_base			= ldc_uo_ge481_nf_transferencia_loja.Object.vl_bc_icms_st[ll_for] //N$$HEX1$$e300$$ENDHEX$$o temos a base do FCP ent$$HEX1$$e300$$ENDHEX$$o mandamos a base do ST
					ldc_othbas		= 0
			End Choose
			
			if (ldc_rate = 0 or IsNull(ldc_rate)) and ls_taxtyp <> 'ICM0' and ls_taxtyp <> 'ICM3' then continue
			
			If IsNull(ldc_base) Then
				ls_base = '0.00'
			Else
				ls_base = gf_replace(String(ldc_base, '#####0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_othbas) Then
				ls_othbas = '0.00'
			Else
				ls_othbas = gf_replace(String(ldc_othbas, '#####0.00'), ',', '.', 0)
			End If

			If IsNull(ldc_rate) Then
				ls_rate = '0.00'
			Else
				ls_rate = gf_replace(String(ldc_rate, '#####0.00'), ',', '.', 0)
			End If
			
			if IsNull(ldc_rate4dec) then
				ls_rate4dec	= '0.00'
			else
				ls_rate4dec	= gf_replace(String(ldc_rate4dec, '###,##0.0000'), ',', '.', 0)
			end if
			
			If IsNull(ldc_taxval) Then
				ls_taxval = '0.00'
			Else
				ls_taxval = gf_replace(String(ldc_taxval, '#####0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_tax_difference) Then
				ls_tax_difference = '0.00'
			Else
				ls_tax_difference = gf_replace(String(ldc_tax_difference, '#####0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_srate) Then
				ls_srate = '0.00'
			Else
				ls_srate = gf_replace(String(ldc_srate, '#####0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_factor) Then
				ls_factor = '0.00'
			Else
				ls_factor = gf_replace(String(ldc_factor), ',', '.', 0)
			End If
			
			If IsNull(ldc_factor4dec) Then
				ls_factor4dec = '0.00'
			Else
				ls_factor4dec = gf_replace(String(ldc_factor4dec), ',', '.', 0)
			End If
			
			If IsNull(ldc_excbas) Then
				ls_excbas = '0.00'
			Else
				ls_excbas = gf_replace(String(ldc_excbas, '#####0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_basered1) Then
				ls_basered1 = '0.00'
			Else
				ls_basered1 = gf_replace(String(ldc_basered1, '#####0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_basered2) Then
				ls_basered2 = '0.00'
			Else
				ls_basered2 = gf_replace(String(ldc_basered2, '#####0.00'), ',', '.', 0)
			End If
			
			ps_xml += '<IMPOSTOS>'
			ps_xml += '<TAXTYP>'+ls_taxtyp+'</TAXTYP>'
			ps_xml += '<BASE>'+ls_base+'</BASE>'
			ps_xml += '<RATE>'+ls_rate+'</RATE>'
			ps_xml += '<TAXVAL>'+ls_taxval+'</TAXVAL>'
			ps_xml += '<EXCBAS>'+ls_excbas+'</EXCBAS>'
			ps_xml += '<OTHBAS>'+ls_othbas+'</OTHBAS>'
			ps_xml += '<STATTX></STATTX>'
			ps_xml += '<RECTYPE></RECTYPE>'
			ps_xml += '<FACTOR>' + ls_factor + '</FACTOR>'
			ps_xml += '<UNIT></UNIT>'
			ps_xml += '<TAX_LOC></TAX_LOC>'
			ps_xml += '<SERVTYPE_IN></SERVTYPE_IN>'
			ps_xml += '<SERVTYPE_OUT></SERVTYPE_OUT>'
			ps_xml += '<WITHHOLD></WITHHOLD>'
			ps_xml += '<TAXINNET></TAXINNET>'
			ps_xml += '<WHTCOLLCODE></WHTCOLLCODE>'
			ps_xml += '<BASERED1>' + ls_basered1 + '</BASERED1>'
			ps_xml += '<BASERED2>' + ls_basered2 + '</BASERED2>'
			ps_xml += '<RATE4DEC>' + ls_rate4dec + '</RATE4DEC>'
			ps_xml += '<FACTOR4DEC>' + ls_factor4dec + '</FACTOR4DEC>'
			ps_xml += '<UNIT4DEC></UNIT4DEC>'		
			ps_xml += '<TAX_DIFFERENCE>' + ls_tax_difference + '</TAX_DIFFERENCE>'
			ps_xml += '<SRATE>' + ls_srate + '</SRATE>'
			ps_xml += '<PAUTA_BASE>' + ls_pauta_base + '</PAUTA_BASE>'
			ps_xml += '<TAXGRP>'+ls_taxgrp+'</TAXGRP>'
			ps_xml += '<TAXOFF></TAXOFF>'
			ps_xml += '<TAXOUTVALUE></TAXOUTVALUE>'
			ps_xml += '</IMPOSTOS>'
		next
		
		ps_xml += '</ITEM>'		
	next
finally
	destroy ldc_uo_ge481_nf_transferencia_loja
end try

return true
end function

on uo_ge481_nf_transferencia_loja.create
call super::create
end on

on uo_ge481_nf_transferencia_loja.destroy
call super::destroy
end on

