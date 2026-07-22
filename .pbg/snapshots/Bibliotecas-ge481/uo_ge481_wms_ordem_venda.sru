HA$PBExportHeader$uo_ge481_wms_ordem_venda.sru
forward
global type uo_ge481_wms_ordem_venda from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_wms_ordem_venda from uo_ge481_subida_generica
end type
global uo_ge481_wms_ordem_venda uo_ge481_wms_ordem_venda

type variables
Boolean	ib_valida_mov_estoque_pendente	= false

Long	il_nr_atualizacao, &
		il_nr_pedido_distribuidora, &
		il_cd_filial, &
		il_nr_pedido, &
		il_nr_integracao
		
String	is_cd_distribuidora, &
			is_cd_tipo_documento
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log)
public function boolean of_monta_xml_item_licitacao (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean of_monta_xml_item_sucata (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean of_busca_pedido_enviado (ref string as_log)
end prototypes

public function boolean _of_parametros ();//override
is_inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
   						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_ORDEMREMESSANF_REQ>'


is_termino_XML	=	'</imp:MT_ORDEMREMESSANF_REQ>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_ds = 'ds_ge481_wms_pedido_transferencia'
is_objeto = this.ClassName()
is_nome_arquivo = 'wms_pedido_transferencia'
is_parametro_url = 'CD_URL_WMS_ORDEM_VENDA'
is_tipo_log_exp = 'ENVIO_PEDIDO_TRANSFERENCIA'
is_descricao_tipo_log = 'ENVIO_PEDIDO_TRANSFERENCIA'
is_nome_interface = 'ENVIO_PEDIDO_TRANSFERENCIA'

// Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 1)
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 2)
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 3)
end if

//io_sap_comum.is_usuario = 'GRC_INTEGRACAO'
//io_sap_comum.is_senha = 'Grc_1nt3gNfe'
//io_sap_comum.is_usuario = 'Matavares'
//io_sap_comum.is_senha = 'Abap@001'
//io_sap_comum.is_usuario	= 'PO_INTEGRACAO'
//io_sap_comum.is_senha = 'P0_INTEGRACAO$'

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);DateTime	ldt_dh_validade

Date 		ld_dt_fab, ld_dt_hoje, ld_dt_exp

Long		ll_total_linhas, ll_for, ll_qtde_volumes, ll_find_controlado, ll_cd_produto, ll_cd_filial_origem, &
			ll_nr_atualizacao_pendente, ll_count_itens = 0, ll_amount, ll_total_produtos,ll_qt_separada,ll_qt_amount, ll_qt_atendida
			
String	ls_center_provider, ls_tp_po, ls_code_pgto, ls_date, ls_item_po, ls_material, ls_unidade_medida, &
			ls_amount, ls_store, ls_batch, ls_fab_date, ls_exp_date, ls_Centro_custo, ls_CC_Sap, ls_Almoxarifado, &
			ls_cd_tipo_documento, ls_cd_categoria, ls_transportadora, ls_centro_custo_aux, ls_de_tipo_pedido,ls_descricao_centro_custo, &
			ls_infcpl, ls_de_motivo_rejeicao, ls_cd_deposito_sap, ls_id_sobra, ls_infadprod,ls_TP_Pag

dc_uo_ds_base ldc_uo_ge481_wms_envio_pedido_transferencia_dados

ldc_uo_ge481_wms_envio_pedido_transferencia_dados = create dc_uo_ds_base

ld_dt_hoje	= Date(gf_getserverdate())

try
	il_cd_filial					= pds_dados.Object.cd_filial[pl_linha]
	il_nr_pedido_distribuidora	= pds_dados.Object.cd_integer[pl_linha]
	
	/*select count(*)
	  into :ll_total_produtos
	  from pedido_distribuidora_produto pdp
	  left join pedido_distribuidora_prd_lote pdpl
	 			on pdp.cd_filial = pdpl.cd_filial 
				and pdp.nr_pedido_distribuidora = pdpl.nr_pedido_distribuidora 
				and pdp.cd_produto = pdpl.cd_produto 
	 where pdp.cd_filial = :il_cd_filial
	 	and pdp.nr_pedido_distribuidora = :il_nr_pedido_distribuidora
		and pdp.qt_separada > 0
	using SQLCA;
	
	if SQLCA.SQLCode = -1 then
		ps_log = "Erro ao localizar os produtos da tabela pedido_distribuidora_produto. ~r~rErro: " + SQLCA.SQLErrText
		return false
	end if*/
	
	SELECT SUM(pdp.qt_separada) AS soma_qt_separada
	  into :ll_qt_separada
	  from pedido_distribuidora_produto pdp
	 where pdp.cd_filial = :il_cd_filial
	 	and pdp.nr_pedido_distribuidora = :il_nr_pedido_distribuidora
		and pdp.qt_separada > 0
	using SQLCA;
	
	if SQLCA.SQLCode = -1 then
		ps_log = "Erro ao localizar os produtos da tabela pedido_distribuidora_produto. ~r~rErro: " + SQLCA.SQLErrText
		return false
	end if
	
	il_nr_atualizacao				= pds_dados.Object.nr_atualizacao[pl_linha]
	ls_cd_tipo_documento		= pds_dados.Object.cd_tipo_documento[pl_linha]
	ls_transportadora				= pds_dados.Object.transportadora[pl_linha]
					
	Choose Case ls_cd_tipo_documento
		Case 'WML'
			//Pedido de Licita$$HEX2$$e700e300$$ENDHEX$$o - Tipo 'WML'		
			Return of_monta_xml_item_licitacao( pds_dados, pl_linha, ps_xml, ps_log )
		Case 'WMU'	
			//NFE Remessa Sucata - Tipo 'WMU'
			Return of_monta_xml_item_sucata( pds_dados, pl_linha, ps_xml, ps_log )	

		Case 'WMO'		
			//NFE Remessa Transfer$$HEX1$$ea00$$ENDHEX$$ncia - Tipo 'WMO'
			
			If Not ldc_uo_ge481_wms_envio_pedido_transferencia_dados.of_changedataobject('ds_ge481_wms_pedido_transferencia_dados', False) Then
				ps_log = "Erro ao alterar a DW 'ds_ge481_wms_pedido_transferencia_dados'."
				return false
			end if
			
			ll_total_linhas	= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Retrieve(il_cd_filial, il_nr_pedido_distribuidora)
			
			If ll_total_linhas = 0 Then
				ps_log = "Nenhum produto foi localizado  na DW 'ds_ge481_wms_pedido_transferencia_dados'."
				return false
			ElseIf ll_total_linhas < 0 Then
				ps_log = "Erro ao localizar os itens na DW 'ds_ge481_wms_pedido_transferencia_dados'."
				return false
			End If
				
			ll_count_itens = 0
			
			for ll_for = 1 to ll_total_linhas
				ll_cd_produto		= Long(ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.cd_produto[ll_for])
				ll_cd_filial_origem	= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.cd_filial_origem[ll_for]
				
				if ib_valida_mov_estoque_pendente then
					if Not lf_ge481_verifica_mov_est_pen_sap(ll_cd_produto, il_nr_atualizacao, REF ll_nr_atualizacao_pendente, REF ps_log) then
						Return False
					end if
					
					if ll_nr_atualizacao_pendente > 0 then
						ps_log	= 'Envio de movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque pendente. Exporta$$HEX2$$e700e300$$ENDHEX$$o: ' + String(ll_nr_atualizacao_pendente) + ' Produto: ' + String(ll_cd_produto)
						Return False
					end if
				end if				
				
				if ll_for = 1 then
					ls_tp_po						= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.tp_po									[ll_for]
					
					if ll_cd_filial_origem > 0 then
						Select cd_chave_sap
						into :ls_center_provider
						from integracao_sap
						where cd_tabela = 'FILIAL'
						and cd_chave_legado = cast(:ll_cd_filial_origem as varchar);
					
						if sqlca.sqlcode = -1 then 
							ps_log = 'Problemas ao consultar a tabela "integracao_sap": ' + sqlca.sqlerrtext
							return false
						end if
					else
						ls_center_provider		= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.center_provider						[ll_for]
					end if
					
					ls_code_pgto				= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.code_pgto								[ll_for]
					ls_date						= string(date(ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.date[ll_for]), 'YYYY-MM-DD')
					
					if left(ls_date, 10) = '1900-01-01' then
						ps_log = 'Data de emiss$$HEX1$$e300$$ENDHEX$$o incorreta para integra$$HEX2$$e700e300$$ENDHEX$$o do pedido (1900-01-01).'
						Return False
					End if
					
					is_cd_distribuidora			= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.cd_distribuidora					[ll_for]
					ls_Centro_custo			= String(ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.cd_centro_custo_legado	[ll_for])
					ls_Almoxarifado			= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.id_pedido_almoxarifado			[ll_for]
					ls_de_tipo_pedido			= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.de_tipo_pedido						[ll_for]
					ls_TP_Pag					= '90'
					
					if IsNull(ls_de_tipo_pedido) then ls_de_tipo_pedido = ''
					
					If Not IsNull(ls_Centro_custo) and Trim(ls_Centro_custo) <> '' and trim(ls_centro_custo) <> String(il_cd_filial) Then
						If Len(ls_Centro_custo) <> 6 and Len(ls_Centro_custo) <> 3 Then
							ps_log = "Centro de custo que est$$HEX1$$e100$$ENDHEX$$ com o tamanho diferente do esperado [3, 6]."
							return false
						End If
						
						if Len(ls_Centro_custo) = 6 Then
							ls_centro_custo_aux	= Mid(ls_Centro_custo, 4, 3)
							
							If Not io_sap_comum.of_verifica_codigo_de_para('CENTRO_CUSTO', ls_centro_custo_aux,  '', ref ls_CC_Sap, ref ps_log) Then Return False

							
							If Mid(ls_Centro_custo, 1,3) = '100' Then // CD
								ls_CC_Sap = "1156" + ls_CC_Sap
							ElseIf Mid(ls_Centro_custo, 1,3) = '534' Then // MATRIZ
								ls_CC_Sap = "1001" + ls_CC_Sap
							Else
								ps_log = "Filial do centro de custo diferente do esperado."
								return false
							End If
						end if		
					else
						ls_CC_Sap	= ''
					End If
					
					if ls_tp_po = 'X' then
						If ls_Almoxarifado = 'S' Then
							ls_tp_po = 'UCO'
						Else
							ps_log = "Tipo de pedido SAP n$$HEX1$$e300$$ENDHEX$$o previsto."
							return false
						End If
					end if
					
					select count(*)
					  into :ll_qtde_volumes
					  from wms_lista_separacao
					 where wms_lista_separacao.cd_filial					= :il_cd_filial and 
							 wms_lista_separacao.nr_pedido_distribuidora	= :il_nr_pedido_distribuidora
					using sqlca;
					
					if sqlca.SqlCode = -1 Then
						ps_log = "Erro ao consultar a quantidade de volumes do pedido "+String(il_nr_pedido_distribuidora)+" da filial "+String(il_cd_filial)+"."
						return false
					end if
					
					If ll_qtde_volumes = 0 Then ll_qtde_volumes = 1
					
					ps_xml += '<HEADER>'
					
					ps_xml += '<NUMBER_PO>' + String(il_nr_pedido_distribuidora) + '</NUMBER_PO>'
					ps_xml += '<TP_PO>' + String(ls_tp_po) + '</TP_PO>'
					ps_xml += '<CENTER_PROVIDER>' + String(ls_center_provider) + '</CENTER_PROVIDER>'
					ps_xml += '<CODE_PGTO>' + ls_code_pgto + '</CODE_PGTO>'
					ps_xml += '<DATE>' + ls_date + '</DATE>'
					ps_xml += '<VOLUME>' + string(ll_qtde_volumes) + '</VOLUME>'
					ps_xml += '<KOSTL>' + ls_CC_Sap + '</KOSTL>'
					ps_xml += '<TPPAG>' + ls_TP_Pag + '</TPPAG>'
					
					// Chamado 1369771
					ls_infcpl	= ls_de_tipo_pedido
					
					If ls_Almoxarifado = 'S' Then 
						If Not io_sap_comum.of_verifica_desc_centro_custo(Long(ls_Centro_custo), ref ls_descricao_centro_custo, ref ps_log ) Then Return False
							
						if not IsNull(ls_descricao_centro_custo) then
							ls_infcpl	+= ' C.C:'+ls_descricao_centro_custo
						end if
					end if
	
					if IsNull(ls_infcpl) then ls_infcpl = ''
					
					ps_xml += '<INFCPL>'+ls_infcpl+'</INFCPL>'
					
					ps_xml += '<TRANSPORTADORA>' + ls_transportadora + '</TRANSPORTADORA>'
					ps_xml += '</HEADER>'
				end if
				
				ll_amount				= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.amount[ll_for]
				ll_qt_amount += ll_amount
				
				If ll_amount = 0 then
					continue
				End if
				
				ls_material				= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.material				[ll_for]
				ls_unidade_medida		= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.unidade_medida		[ll_for]
				ls_amount				= String(ll_amount)
				ls_store					= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.store					[ll_for]
				ls_batch					= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.batch					[ll_for]
				ld_dt_fab				= date(ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.fab_date		[ll_for])
				ld_dt_exp				= date(ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.exp_date		[ll_for])
				ls_cd_categoria		= String(ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.cd_categoria[ll_for])
				ls_de_motivo_rejeicao= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.de_motivo_rejeicao	[ll_for]
				ll_qt_atendida			= ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.qt_atendida			[ll_for]
				ls_cd_deposito_sap   = ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.cd_deposito_sap		[ll_for]
				ls_id_sobra          = ldc_uo_ge481_wms_envio_pedido_transferencia_dados.Object.id_sobra				[ll_for]
				
				If ll_qt_atendida > 0 and ll_amount > ll_qt_atendida  then
					ps_log = "Qtde. separada acima da qtde definida. Mat:" + ls_material + ", Ped:" + string(il_nr_pedido_distribuidora) + ", Fil:" + string(il_cd_filial) + ". Verificar junto a TI."
					Return false
				End if
				
				If IsNull(ls_de_motivo_rejeicao) Then ls_de_motivo_rejeicao=""
				
				If IsNull(ls_batch) or Trim(ls_batch) = '' Then
					ls_fab_date = ''
					ls_exp_date = ''
				else
					If ld_dt_hoje < ld_dt_fab or IsNull(ld_dt_fab) Then
						ld_dt_fab = RelativeDate(ld_dt_hoje, - 90)
					End If
					
					If ld_dt_fab > ld_dt_exp and not IsNull(ld_dt_exp) Then
						ld_dt_fab = RelativeDate(ld_dt_exp, - 90)
					End If
					
					ls_fab_date			= string(ld_dt_fab, 'YYYY-MM-DD')
					ls_exp_date			= string(ld_dt_exp, 'YYYY-MM-DD')
					
					If ls_fab_date = '1900-01-01' or ls_exp_date = '1900-01-01' Then
						ls_fab_date = ''
						ls_exp_date = ''
						ls_batch		= ''
					End If	
				End If
				
				ls_infadprod = ls_de_motivo_rejeicao
				
//				If ls_id_sobra = 'S' then
//					If ls_infadprod <> '' then
//						ls_infadprod += '-'
//					End if
//					ls_infadprod += '**SOBRA DE MERCADORIA**'
//				End if
				
				ll_count_itens ++
				
				ls_item_po = string(ll_count_itens * 10)
		
				ps_xml += '<ITEM>'
				ps_xml += '<ITEM_PO>' + ls_item_po + '</ITEM_PO>'
				ps_xml += '<MATERIAL>' + ls_material + '</MATERIAL>'
				ps_xml += '<UNIDADE_MEDIDA>' + ls_unidade_medida + '</UNIDADE_MEDIDA>'
				ps_xml += '<AMOUNT>' + ls_amount + '</AMOUNT>'
				ps_xml += '<STORE>' + ls_store + '</STORE>'
				ps_xml += '<DATE_SHIPPING>' + '</DATE_SHIPPING>'
				ps_xml += '<BATCH>' + ls_batch + '</BATCH>'
				ps_xml += '<PROD_DATE>' + ls_fab_date + '</PROD_DATE>'
				ps_xml += '<EXPIRYDATE>' + ls_exp_date + '</EXPIRYDATE>'
				ps_xml += '<LGORT>' + ls_cd_deposito_sap + '</LGORT>'
				ps_xml += '<UMLGO>' + '</UMLGO>'   
				ps_xml += '<INFADPROD>' + ls_infadprod + '</INFADPROD>'   				
				ps_xml += '</ITEM>'
				
			next
			
			//A quantidade total do amount deve ser igual a quantidade total da quantidade separada do pedido
			If ll_qt_separada <> ll_qt_amount then
				ps_log = 'A quantidade total de produtos na nota est$$HEX1$$e100$$ENDHEX$$ diferente da quantidade separada do pedido'
				Return false
			End if		
		
		Case Else
				//Caso seja cadastrado um tipo de movimento diferente $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio desenvolver a montagem do xml
				ps_log = 'Tipo de documenta$$HEX2$$e700e300$$ENDHEX$$o "'+ ls_cd_tipo_documento + '", n$$HEX1$$e300$$ENDHEX$$o prevista para montagem do xml. (Fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml_item).' 
				Return False	
	End Choose
finally
	destroy ldc_uo_ge481_wms_envio_pedido_transferencia_dados
end try

if IsNull(ps_xml) Then
	ps_log = 'As informa$$HEX2$$e700f500$$ENDHEX$$es do xml da ordem de venda est$$HEX1$$e300$$ENDHEX$$o nulas.'
	Return False
end if

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);Long 		ll_contador = 1
String 	ls_status


//Aguardar para ver a mensagem real do retorno
ls_status = of_busca_valor(as_xml, '<STATUS>', ref ll_contador)

if ls_status <> 'Integrado com Sucesso' then	
	this.of_atualiza_processado( il_nr_atualizacao, 'E', ls_status, ref as_log)
else
	if Not this.of_atualiza_processado( il_nr_atualizacao, 'S', ls_status, ref as_log) then return false
end if

return true
end function

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log);long	ll_nr_atualizacao
String	ls_status, &
		ls_msg

if il_nr_atualizacao = 0 or isnull(il_nr_atualizacao) Then
	ll_nr_atualizacao 		= pds_itens.object.nr_atualizacao[pl_linha]
else
	ll_nr_atualizacao = il_nr_atualizacao
end if

if ps_status = 'E' Then
	ls_status = 'E'
	ls_msg = as_mensagem
else
	ls_status = 'P'
	ls_msg = as_mensagem
end if

update log_exportacao_sap
   set log_exportacao_sap.id_status_integracao = :ls_status, 
		 log_exportacao_sap.dh_exportacao = getdate(), 
		 log_exportacao_sap.de_erro = :ls_msg
 where log_exportacao_sap.nr_atualizacao = :ll_nr_atualizacao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_sap 'of_atualiza_processado': " + SqlCa.SqlerrText
	Return False
End If

Choose Case is_cd_tipo_documento
	Case 'WML'
	
		If ps_status = 'P' Then 
			update licitacao_pedido
				set dh_exportacao_sap = getdate(), 
					 id_exportacao_sap = 'I'
			 where nr_pedido = :il_nr_pedido 
			using sqlca;
		ElseIf ls_status = 'E' Then
			ls_msg = Left(Trim(ls_msg),255) //overflow
			update licitacao_pedido
				set id_exportacao_sap = 'R' , 
					 de_erro_envio_sap = :ls_msg
			 where nr_pedido = :il_nr_pedido
			using SqlCa;
		End If 
		
	Case 'WMU'
	
		If ps_status = 'P' Then 
			update wms_int_sap
				set dh_envio_sap = getdate(), 
					 id_situacao = 'I'
			 where nr_integracao = :il_nr_integracao
			using sqlca;
		ElseIf ls_status = 'E' Then
			ls_msg = Left(Trim(ls_msg),250) //overflow
			update wms_int_sap
				set dh_envio_sap = getdate(), 
					 id_situacao = 'E',
					 de_erro = :ls_msg
			 where nr_integracao = :il_nr_integracao
			using SqlCa;
		End If 
	
	Case Else
		
		if ls_status = 'P' then 
			update pedido_distribuidora
				set pedido_distribuidora.dh_exportacao_sap = getdate(), 
					 pedido_distribuidora.id_exportacao_sap = 'I'
			 where pedido_distribuidora.nr_pedido_distribuidora 	= :il_nr_pedido_distribuidora and
					 pedido_distribuidora.cd_filial 						= :il_cd_filial and	
					 pedido_distribuidora.cd_distribuidora 			= :is_cd_distribuidora
			using sqlca;
		elseif ls_status = 'E' then
			update pedido_distribuidora
				set pedido_distribuidora.id_exportacao_sap = 'R' , 
					 pedido_distribuidora.de_erro_envio_sap = 'Erro no Envio das Informa$$HEX2$$e700f500$$ENDHEX$$es ao SAP'
			 where pedido_distribuidora.nr_pedido_distribuidora 	= :il_nr_pedido_distribuidora and
					 pedido_distribuidora.cd_filial 						= :il_cd_filial and	
					 pedido_distribuidora.cd_distribuidora 			= :is_cd_distribuidora
			using SqlCa;
		end if 
End Choose

if sqlca.SqlCode = -1 Then
	as_log += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o dos campos de exportacao na tabela 'pedido_distribuidora | licitacao_pedido', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_processado	': " + SqlCa.SqlerrText
	return false
end if

return true
end function

public function boolean of_monta_xml_item_licitacao (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);String	ls_number_licitacao, &
		ls_volume, &
		ls_number_po, &
		ls_kostl, &
		ls_infcpl, &
		ls_transportadora, &
		ls_tp_po, &
		ls_center_provider, &
		ls_code_pgto, &
		ls_date
		
Long	ll_total_linhas, &
		ll_linha
		
String	ls_item_po, &
		ls_material, &
		ls_unidade_medida, &
		ls_amount, &
		ls_price, &
		ls_desconto, &
		ls_store, &
		ls_date_shipping, &
		ls_batch, &
		ls_prod_date, &
		ls_expirydate, &
		ls_umlgo, &
		ls_lgort,&
		ls_TP_Pag
		
		
dc_uo_ds_base ldc_uo_ge481_wms_pedido_transferencia_licitacao
ldc_uo_ge481_wms_pedido_transferencia_licitacao = create dc_uo_ds_base

try
	il_nr_atualizacao		= pds_dados.Object.nr_atualizacao[pl_linha]
	il_nr_pedido			= pds_dados.Object.number_po[pl_linha]
	is_cd_tipo_documento	= pds_dados.Object.cd_tipo_documento[pl_linha]
	ls_number_po			= String(il_nr_pedido)
	ls_number_licitacao	= pds_dados.Object.number_licitacao[pl_linha]
	ls_tp_po					= pds_dados.Object.tp_po[pl_linha]
	ls_center_provider	= pds_dados.Object.center_provider[pl_linha]
	ls_code_pgto			= pds_dados.Object.code_pgto[pl_linha]
	ls_date					= string(pds_dados.Object.date[pl_linha],'YYYY-MM-DD')
	ls_volume				= pds_dados.Object.volume[pl_linha]
	ls_kostl					= pds_dados.Object.kostl[pl_linha]
	ls_infcpl				= pds_dados.Object.infcpl[pl_linha]
	ls_transportadora		= pds_dados.Object.transportadora[pl_linha]
	ls_TP_Pag				= '99'
	
	If isNull(ls_number_licitacao) or ls_number_licitacao = '' Then
		ps_log = "Campo n$$HEX1$$fa00$$ENDHEX$$mero licita$$HEX2$$e700e300$$ENDHEX$$o {number_licitacao} $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio para o tipo 'WML'."
		return false
	End If
	
	If IsNull(ls_number_po) Then ls_number_po = ''
	If IsNull(ls_tp_po) Then ls_tp_po = ''
	If IsNull(ls_center_provider) Then ls_center_provider = ''
	If IsNull(ls_code_pgto) Then ls_code_pgto = ''
	If IsNull(ls_date) Then ls_date = ''
	If IsNull(ls_volume) Then ls_volume = ''
	If IsNull(ls_kostl) Then ls_kostl = ''
	If IsNull(ls_infcpl) Then ls_infcpl = ''
	If IsNull(ls_transportadora) Then ls_transportadora = ''
	
	ps_xml = '<HEADER>'
	ps_xml += '<NUMBER_PO>' + ls_number_po + '</NUMBER_PO>'
	ps_xml += '<NUMBER_LICITACAO>' + ls_number_licitacao + '</NUMBER_LICITACAO>'
	ps_xml += '<TP_PO>' + ls_tp_po + '</TP_PO>'
	ps_xml += '<CENTER_PROVIDER>' + ls_center_provider + '</CENTER_PROVIDER>'
	ps_xml += '<CODE_PGTO>' + ls_code_pgto + '</CODE_PGTO>'
	ps_xml += '<DATE>' + ls_date + '</DATE>'
	ps_xml += '<VOLUME>' + ls_volume + '</VOLUME>'
	ps_xml += '<KOSTL>' + ls_kostl + '</KOSTL>'
	ps_xml += '<TPPAG>' + ls_TP_Pag + '</TPPAG>'
	ps_xml += '<INFCPL>' + ls_infcpl + '</INFCPL>'
	ps_xml += '<TRANSPORTADORA>' + ls_transportadora + '</TRANSPORTADORA>'
	ps_xml += '</HEADER>'

	If Not ldc_uo_ge481_wms_pedido_transferencia_licitacao.of_changedataobject('ds_ge481_wms_pedido_transferencia_licitacao', False) Then
		ps_log = "Erro ao alterar a DW 'ds_ge481_wms_pedido_transferencia_licitacao'."
		return false
	end if
	
	ll_total_linhas	= ldc_uo_ge481_wms_pedido_transferencia_licitacao.Retrieve( Long(ls_number_po) )
	
	If ll_total_linhas = 0 Then
		ps_log = "Nenhum produto foi localizado  na DW 'ds_ge481_wms_pedido_transferencia_licitacao'."
		return false
	ElseIf ll_total_linhas < 0 Then
		ps_log = "Erro ao localizar os itens na DW 'ds_ge481_wms_pedido_transferencia_licitacao'."
		return false
	End If
		
	for ll_linha= 1 to ll_total_linhas		
		ls_item_po			= String(ll_linha * 10)
		ls_material			= ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.material[ll_linha]
		ls_unidade_medida	= ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.unidade_medida[ll_linha]
		ls_amount			= String(ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.amount[ll_linha])
		ls_price				= String(ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.price[ll_linha],'#0.000000')
		ls_desconto			= String(ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.desconto[ll_linha],'#0.00')
		ls_store				= ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.store[ll_linha]
		ls_date_shipping	= ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.date_shipping[ll_linha]
		ls_batch				= ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.batch[ll_linha]
		ls_prod_date		= string(date(ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.prod_date[ll_linha]), 'YYYY-MM-DD')
		ls_expirydate		= string(date(ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.expirydate[ll_linha]), 'YYYY-MM-DD')
		ls_umlgo				= ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.umlgo[ll_linha]
		ls_lgort				= ldc_uo_ge481_wms_pedido_transferencia_licitacao.Object.lgort[ll_linha]
		
		ls_price 	= gf_replace(ls_price,',','.',0)
		ls_desconto = gf_replace(ls_desconto,',','.',0)
		
		If IsNull(ls_store) or ls_store = '' Then
			ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo do cliente SAP {store} $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio no pedido de licita$$HEX2$$e700e300$$ENDHEX$$o'
			Return False
		End If
		
		If IsNull(ls_prod_date) or ls_prod_date = '' Then
			ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado data de fabrica$$HEX2$$e700e300$$ENDHEX$$o para o produto ' + ls_material
			Return False
		End If
		
		If IsNull(ls_expirydate) or ls_expirydate = '' Then
			ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado data de validade para o produto ' + ls_material
			Return False
		End If
		
		If IsNull(ls_item_po) Then ls_item_po = ''
		If IsNull(ls_material) Then ls_material = ''
		If IsNull(ls_unidade_medida) Then ls_unidade_medida = ''
		If IsNull(ls_amount) Then ls_amount = ''
		If IsNull(ls_price) Then ls_price = ''
		If IsNull(ls_desconto) Then ls_desconto = ''
		If IsNull(ls_date_shipping) Then ls_date_shipping = ''
		If IsNull(ls_batch) Then ls_batch = ''
		If IsNull(ls_umlgo) Then ls_umlgo = ''
		If IsNull(ls_lgort) Then ls_lgort = ''
		
		ps_xml += '<ITEM>'
		ps_xml += '<ITEM_PO>' + ls_item_po + '</ITEM_PO>'
		ps_xml += '<MATERIAL>' + ls_material + '</MATERIAL>'
		ps_xml += '<UNIDADE_MEDIDA>' + ls_unidade_medida + '</UNIDADE_MEDIDA>'
		ps_xml += '<AMOUNT>' + ls_amount + '</AMOUNT>'
		ps_xml += '<PRICE>' + ls_price + '</PRICE>'
		ps_xml += '<DESCONTO>' + ls_desconto + '</DESCONTO>'
		ps_xml += '<STORE>' + ls_store + '</STORE>'
		ps_xml += '<DATE_SHIPPING>' + ls_date_shipping + '</DATE_SHIPPING>'
		ps_xml += '<BATCH>' + ls_batch + '</BATCH>'
		ps_xml += '<PROD_DATE>' + ls_prod_date + '</PROD_DATE>'
		ps_xml += '<EXPIRYDATE>' + ls_expirydate + '</EXPIRYDATE>'
		ps_xml += '<UMLGO>' + ls_umlgo + '</UMLGO>'  
		ps_xml += '<LGORT>' + ls_lgort + '</LGORT>'
		ps_xml += '</ITEM>'
		
	next
		
finally
	destroy ldc_uo_ge481_wms_pedido_transferencia_licitacao
end try
			
return true
end function

public function boolean of_monta_xml_item_sucata (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);String	ls_number_licitacao, &
		ls_volume, &
		ls_number_po, &
		ls_kostl, &
		ls_infcpl, &
		ls_transportadora, &
		ls_tp_po, &
		ls_center_provider, &
		ls_code_pgto, &
		ls_date
		
Long	ll_total_linhas, &
		ll_linha
		
String	ls_item_po, &
		ls_material, &
		ls_unidade_medida, &
		ls_amount, &
		ls_price, &
		ls_desconto, &
		ls_store, &
		ls_date_shipping, &
		ls_batch, &
		ls_prod_date, &
		ls_expirydate, &
		ls_umlgo, &
		ls_lgort, &
		ls_tp_frete,&
		ls_TP_Pag
		
		
dc_uo_ds_base ldc_uo_ge481_wms_pedido_transferencia_sucata
ldc_uo_ge481_wms_pedido_transferencia_sucata = create dc_uo_ds_base

try
	il_nr_atualizacao		= pds_dados.Object.nr_atualizacao[pl_linha]
	il_nr_integracao		= pds_dados.Object.number_po[pl_linha]
	ls_number_po			= String(il_nr_integracao)
	is_cd_tipo_documento= pds_dados.Object.cd_tipo_documento[pl_linha]
	ls_number_licitacao	= pds_dados.Object.number_licitacao[pl_linha]
	ls_tp_po					= pds_dados.Object.tp_po[pl_linha]
	ls_center_provider		= pds_dados.Object.center_provider[pl_linha]
	ls_code_pgto			= pds_dados.Object.code_pgto[pl_linha]
	ls_date					= string(pds_dados.Object.date[pl_linha],'YYYY-MM-DD')
	ls_volume				= pds_dados.Object.volume[pl_linha]
	ls_kostl					= pds_dados.Object.kostl[pl_linha]
	ls_infcpl					= pds_dados.Object.infcpl[pl_linha]
	ls_transportadora		= pds_dados.Object.transportadora[pl_linha]
	ls_tp_frete				= string(pds_dados.Object.tp_frete[pl_linha])
	ls_TP_Pag				= '99'
	
	If isNull(ls_number_licitacao) Then ls_number_licitacao = '' 
	If IsNull(ls_number_po) Then ls_number_po = ''
	If IsNull(ls_tp_po) Then ls_tp_po = ''
	If IsNull(ls_center_provider) Then ls_center_provider = ''
	If IsNull(ls_code_pgto) Then ls_code_pgto = ''
	If IsNull(ls_date) Then ls_date = ''
	If IsNull(ls_volume) Then ls_volume = ''
	If IsNull(ls_kostl) Then ls_kostl = ''
	If IsNull(ls_infcpl) Then ls_infcpl = ''
	If IsNull(ls_transportadora) Then ls_transportadora = ''
	If IsNull(ls_tp_frete) Then ls_tp_frete = ''
	
	//Busca a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento padr$$HEX1$$e300$$ENDHEX$$o de sucata
	select vl_parametro
	  into :ls_code_pgto
	  from wms_parametro
	 where cd_parametro	= 'CD_CONDICAO_PAGAMENTO_SAP_SUCATA'
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			ps_log = "Erro ao localizar a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento padr$$HEX1$$e300$$ENDHEX$$o de sucata. ~r~rErro: " + SQLCA.SQLErrText
			return false
		Case 100
			ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento padr$$HEX1$$e300$$ENDHEX$$o de sucata. ~r~rErro: " + SQLCA.SQLErrText
			return false
	End Choose
	
	ps_xml = '<HEADER>'
	ps_xml += '<NUMBER_PO>' + ls_number_po + '</NUMBER_PO>'
	ps_xml += '<NUMBER_LICITACAO>' + ls_number_licitacao + '</NUMBER_LICITACAO>'
	ps_xml += '<TP_PO>' + ls_tp_po + '</TP_PO>'
	ps_xml += '<CENTER_PROVIDER>' + ls_center_provider + '</CENTER_PROVIDER>'
	ps_xml += '<CODE_PGTO>' + ls_code_pgto + '</CODE_PGTO>'
	ps_xml += '<DATE>' + ls_date + '</DATE>'
	ps_xml += '<VOLUME>' + ls_volume + '</VOLUME>'
	ps_xml += '<KOSTL>' + ls_kostl + '</KOSTL>'
	ps_xml += '<TPPAG>' + ls_TP_Pag + '</TPPAG>'
	ps_xml += '<INFCPL>' + ls_infcpl + '</INFCPL>'
	ps_xml += '<TRANSPORTADORA>' + ls_transportadora + '</TRANSPORTADORA>'
	ps_xml += '<TP_FRETE>' + ls_tp_frete + '</TP_FRETE>'
	ps_xml += '</HEADER>'

	If Not ldc_uo_ge481_wms_pedido_transferencia_sucata.of_changedataobject('ds_ge481_wms_pedido_transferencia_sucata', False) Then
		ps_log = "Erro ao alterar a DW 'ds_ge481_wms_pedido_transferencia_sucata'."
		return false
	end if
	
	ll_total_linhas	= ldc_uo_ge481_wms_pedido_transferencia_sucata.Retrieve( il_nr_integracao )
	
	If ll_total_linhas = 0 Then
		ps_log = "Nenhum produto foi localizado  na DW 'ds_ge481_wms_pedido_transferencia_sucata'."
		return false
	ElseIf ll_total_linhas < 0 Then
		ps_log = "Erro ao localizar os itens na DW 'ds_ge481_wms_pedido_transferencia_sucata'."
		return false
	End If
		
	for ll_linha= 1 to ll_total_linhas			
		
		ls_item_po			= String(ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.item_po[ll_linha])
		ls_material			= ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.material[ll_linha]
		ls_unidade_medida= ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.unidade_medida[ll_linha]
		ls_amount			= String(ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.amount[ll_linha])
		ls_price				= String(ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.price[ll_linha],'#0.0000')
		ls_desconto			= ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.desconto[ll_linha]
		ls_store				= ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.store[ll_linha]
		ls_date_shipping	= ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.date_shipping[ll_linha]
		ls_batch				= ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.batch[ll_linha]
		ls_prod_date		= ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.prod_date[ll_linha]
		ls_expirydate		= ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.expirydate[ll_linha]
		ls_umlgo				= ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.umlgo[ll_linha]
		ls_lgort				= ldc_uo_ge481_wms_pedido_transferencia_sucata.Object.lgort[ll_linha]
		
		ls_price = gf_replace(ls_price,',','.',0)
		
		If IsNull(ls_store) Then ls_store = ''
		If IsNull(ls_prod_date) Then ls_prod_date = ''
		If IsNull(ls_expirydate) Then ls_expirydate = ''
		If IsNull(ls_item_po) Then ls_item_po = ''
		If IsNull(ls_material) Then ls_material = ''
		If IsNull(ls_unidade_medida) Then ls_unidade_medida = ''
		If IsNull(ls_amount) Then ls_amount = ''
		If IsNull(ls_price) Then ls_price = ''
		If IsNull(ls_desconto) Then ls_desconto = ''
		If IsNull(ls_date_shipping) Then ls_date_shipping = ''
		If IsNull(ls_batch) Then ls_batch = ''
		If IsNull(ls_umlgo) Then ls_umlgo = ''
		If IsNull(ls_lgort) Then ls_lgort = ''
		
		ps_xml += '<ITEM>'
		ps_xml += '<ITEM_PO>' + ls_item_po + '</ITEM_PO>'
		ps_xml += '<MATERIAL>' + ls_material + '</MATERIAL>'
		ps_xml += '<UNIDADE_MEDIDA>' + ls_unidade_medida + '</UNIDADE_MEDIDA>'
		ps_xml += '<AMOUNT>' + ls_amount + '</AMOUNT>'
		ps_xml += '<PRICE>' + ls_price + '</PRICE>'
		ps_xml += '<DESCONTO>' + ls_desconto + '</DESCONTO>'
		ps_xml += '<STORE>' + ls_store + '</STORE>'
		ps_xml += '<DATE_SHIPPING>' + ls_date_shipping + '</DATE_SHIPPING>'
		ps_xml += '<BATCH>' + ls_batch + '</BATCH>'
		ps_xml += '<PROD_DATE>' + ls_prod_date + '</PROD_DATE>'
		ps_xml += '<EXPIRYDATE>' + ls_expirydate + '</EXPIRYDATE>'
		ps_xml += '<UMLGO>' + ls_umlgo + '</UMLGO>'  
		ps_xml += '<LGORT>' + ls_lgort + '</LGORT>'
		ps_xml += '</ITEM>'
		
	next
		
finally
	destroy ldc_uo_ge481_wms_pedido_transferencia_sucata
end try
			
return true
end function

public function boolean of_busca_pedido_enviado (ref string as_log);Long	ll_exists


select 1
  into :ll_exists
  from log_exportacao_sap
 where id_tipo_nf	= 'WMO'
 	and nr_atualizacao <> :il_nr_atualizacao;
	 
Return True
end function

on uo_ge481_wms_ordem_venda.create
call super::create
end on

on uo_ge481_wms_ordem_venda.destroy
call super::destroy
end on

event constructor;call super::constructor;il_timeout_webservice	= 500000
end event

