HA$PBExportHeader$uo_ge481_wms_movimento_estoque.sru
forward
global type uo_ge481_wms_movimento_estoque from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_wms_movimento_estoque from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long il_Integracao
String is_tipo_movimento, is_cd_centro_custo_sap, is_id_tipo_nf
String is_Texto_Item = ''
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean of_busca_deposito_entrada (string as_cd_chave_movimento, long al_cd_produto, ref string as_deposito_entrada, ref string as_log)
public function boolean of_atualiza_chave_interface (string ps_chave, ref string ps_log)
public function boolean of_monta_xml_item_produto (long pl_nr_integracao, ref string ps_xml, ref string ps_log, ref string ps_tipo_movimento, string ps_centro_empresa)
public function boolean of_valida_quantidade_total (long al_integracao, long al_qt_total, ref string as_msg)
end prototypes

public function boolean _of_parametros ();//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_MOV_MERCADORIA_SAIDA>'

is_Termino_XML	=	'</exp:MT_MOV_MERCADORIA_SAIDA>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_wms_movimento_estoque'
is_Objeto = this.classname( )
is_nome_arquivo = 'wms_movimento_estoque_xml'
is_Parametro_URL = 'CD_URL_WMS_MOVIMENTO_ESTOQUE'
is_Tipo_Log_Exp = 'WMS_MOVIMENTO_ESTOQUE'
is_Descricao_Tipo_Log = 'WMS_MOVIMENTO_ESTOQUE'
is_Nome_Interface = 'WMS_MOVIMENTO_ESTOQUE'

//Subir um documento por vez
ii_contador_xml = 1

ib_continua_apos_erro_montar_xml = True

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);ib_validar_situacao	= False

if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 1)
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 2)
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 3)
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 4)
else
	pds_dados.of_appendwhere("id_status_integracao in ('C', 'E') ", 1 )
	pds_dados.of_appendwhere("id_status_integracao in ('C', 'E') ", 2 )
	pds_dados.of_appendwhere("id_status_integracao in ('C', 'E') ", 3 )
	pds_dados.of_appendwhere("id_status_integracao in ('C', 'E') ", 4 )
end if

//io_sap_comum.is_usuario = 'GRC_INTEGRACAO'
//io_sap_comum.is_senha = 'Grc_1nt3gNfe'
//io_sap_comum.is_usuario = 'Matavares'
//io_sap_comum.is_senha = 'Abap@001'
//io_sap_comum.is_usuario	= 'PO_INTEGRACAO'
//io_sap_comum.is_senha = 'P0_INTEGRACAO$'

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);//override
string ls_nr_solicitacao
string ls_data_movimentacao
string ls_data_lancamento
string ls_direcao_movimento
string ls_tipo_movimento
string ls_empresa
string ls_xml_item
string ls_Dados_Adicionais = ''
string ls_cd_fornecedor_incineracao
string ls_cd_fornecedor_incineracao_sap
string ls_nf_transporte

Long ll_Agrupamento
Long ll_Inventario

ls_data_movimentacao 			= String(pds_dados.GetItemDateTime(pl_linha,"data_movimentacao"),"YYYYMMDD")
ls_data_lancamento 				= String(pds_dados.GetItemDateTime(pl_linha,"data_lancamento"),"YYYYMMDD")
ls_direcao_movimento 			= pds_dados.GetItemString(pl_linha,"direcao_movimento")
ls_tipo_movimento 				= pds_dados.GetItemString(pl_linha,"tipo_movimento")
ls_empresa 							= String(pds_dados.GetItemNumber(pl_linha,"empresa"))
ls_nr_solicitacao	 				= pds_dados.GetItemString(pl_linha,"cd_chave_interface")
il_Integracao 						= Long(pds_dados.GetItemDecimal(pl_linha,"nr_atualizacao"))
is_tipo_movimento					= pds_dados.GetItemString(pl_linha,"cd_varchar")
ll_Agrupamento						= Long(pds_dados.GetItemDecimal(pl_linha,"nr_agrupamento_dev_compra"))
ll_Inventario						= Long(pds_dados.GetItemDecimal(pl_linha,"nr_inventario"))
ls_cd_fornecedor_incineracao	= pds_dados.GetItemString(pl_linha,"cd_fornecedor_incineracao")
ls_Dados_Adicionais				= pds_dados.GetItemString(pl_linha,"de_dados_adicionais")
is_cd_centro_custo_sap			= pds_dados.GetItemString(pl_linha,"cd_centro_custo_sap")
is_id_tipo_nf						= pds_dados.GetItemString(pl_linha,"id_tipo_nf")

// is_tipo_movimento => SEGREG RECEB
// O campo cd_varchar $$HEX1$$e900$$ENDHEX$$ prenchido pela objeto uo_ge473_wms_conf_migo_miro, serve para indicar que ser$$HEX1$$e100$$ENDHEX$$ apenas
// enviado uma movimenta$$HEX2$$e700e300$$ENDHEX$$o de sa$$HEX1$$ed00$$ENDHEX$$da do dep$$HEX1$$f300$$ENDHEX$$sito 0001 para 0002 (segregado).
// No WMS acontece apenas a entrada no segregado depois que vem a confirma$$HEX2$$e700e300$$ENDHEX$$o da migo e miro

If Not IsNull(is_tipo_movimento) Then
	If Trim(is_tipo_movimento) <> 'SEGREG RECEB' and Trim(is_tipo_movimento) <> 'SEGREG DESCARTE' and Trim(is_tipo_movimento) <> 'INVENTARIO' and &
		Trim(is_tipo_movimento) <> 'REVENDA_SEGREGADO' and Trim(is_tipo_movimento) <> 'SEGREGADO_REVENDA' and Trim(is_tipo_movimento) <> 'EQUALIZACAO' Then
		ps_log = 'Tipo de segregado diferente do esperado.'
		return false
	End If
End If

if IsNull(ls_Dados_Adicionais) or Trim(ls_Dados_Adicionais) = '' then
	If Not Isnull(ll_Inventario) and ll_Inventario > 0 Then
		ls_Dados_Adicionais 	= "Invent$$HEX1$$e100$$ENDHEX$$rio WMS: " + String(ll_Inventario)
	End If
	
	If Not Isnull(ll_Agrupamento) and ll_Agrupamento > 0 Then
		ls_Dados_Adicionais = "Segregado WMS: " + String(ll_Agrupamento)
	End If
end if

if IsNull(ls_Dados_Adicionais) then ls_Dados_Adicionais = ''

If Not Isnull(ll_Inventario) and ll_Inventario > 0 Then
	is_Texto_Item 			= String(ll_Inventario)
End If

If Not Isnull(ll_Agrupamento) and ll_Agrupamento > 0 Then
	is_Texto_Item 			= String(ll_Agrupamento)
End If

if ls_nr_solicitacao = '' or isnull(ls_nr_solicitacao) Then
	ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o de envio {nr_solicitacao} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

if ls_data_movimentacao = '' or isnull(ls_data_movimentacao) Then
	ps_log = 'Data da movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque {data_movimentacao} n$$HEX1$$e300$$ENDHEX$$o informada.'
	return false
end if

if ls_data_lancamento = '' or isnull(ls_data_lancamento) Then
	ps_log = 'Data de lan$$HEX1$$e700$$ENDHEX$$amento do movimento de estoque {data_lancamento} n$$HEX1$$e300$$ENDHEX$$o informada.'
	return false
end if

if Trim(is_tipo_movimento) <> 'EQUALIZACAO' or IsNull(is_tipo_movimento) then
	if ls_direcao_movimento = '' or isnull(ls_direcao_movimento) Then
		ps_log = 'Dire$$HEX2$$e700e300$$ENDHEX$$o do movimento de estoque {direcao_movimento} n$$HEX1$$e300$$ENDHEX$$o informada.'
		return false
	end if
else
	ls_direcao_movimento	= ''
end if

if ls_empresa = '' or isnull(ls_empresa) Then
	ps_log = 'Empresa do movimento de estoque {empresa} n$$HEX1$$e300$$ENDHEX$$o informada.'
	return false
end if

//Produto da movimentacao
If Not of_monta_xml_item_produto(il_Integracao, ref ls_xml_item, ref ps_log, ref ls_tipo_movimento, ls_empresa) Then
	Return False
End If

if IsNull(ls_xml_item) or Trim(ls_xml_item) = '' then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel montar o XML de items.'
	return false
end if

if ls_tipo_movimento = '' or isnull(ls_tipo_movimento) Then
	ps_log = 'Tipo do movimento de estoque {tipo_movimento} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

// Movimento de sa$$HEX1$$ed00$$ENDHEX$$da para centro de custo
If ls_tipo_movimento = '201' Then 
	ls_direcao_movimento = '03' 
End If

/*
	Dire$$HEX2$$e700e300$$ENDHEX$$o Movimento - SAP
	03 - sa$$HEX1$$ed00$$ENDHEX$$da 
	04 - Transfer$$HEX1$$ea00$$ENDHEX$$ncia 
	05 - Entrada 
*/

if not IsNull(ls_cd_fornecedor_incineracao) and trim(ls_cd_fornecedor_incineracao) <> '' then
	ls_nf_transporte = 'X'
else
	ls_nf_transporte = ''
end if

if IsNull(ls_cd_fornecedor_incineracao) then
	ls_cd_fornecedor_incineracao = ''
end if

if Trim(ls_cd_fornecedor_incineracao) <> '' then
	select cd_fornecedor_sap
	  into :ls_cd_fornecedor_incineracao_sap
	  from fornecedor
	 where cd_fornecedor	= :ls_cd_fornecedor_incineracao;
	 
	Choose Case SqlCa.SqlCode
		Case -1
			Sqlca.of_MsgDbError("Erro ao buscar c$$HEX1$$f300$$ENDHEX$$digo de fornecedor do SAP.")
			
			Return False
	End Choose
end if

if IsNull(ls_cd_fornecedor_incineracao_sap) then 
	ps_log = 'Fornecedor de incinera$$HEX2$$e700e300$$ENDHEX$$o ' + ls_cd_fornecedor_incineracao + ' n$$HEX1$$e300$$ENDHEX$$o cont$$HEX1$$e900$$ENDHEX$$m c$$HEX1$$f300$$ENDHEX$$digo SAP.'
	return false
end if

ps_xml += '<CABECALHO>'+&
				'<NR_SOLICITACAO>'+ls_nr_solicitacao+'</NR_SOLICITACAO>'+&
				'<DATA_MOVIMENTACAO>'+ls_data_movimentacao+'</DATA_MOVIMENTACAO>'+&
				'<DATA_LANCAMENTO>'+ls_data_movimentacao+'</DATA_LANCAMENTO>'+&
				'<DIRECAO_MOVIMENTO>'+ls_direcao_movimento+'</DIRECAO_MOVIMENTO>'+&
				'<TIPO_MOVIMENTO>'+ls_tipo_movimento+'</TIPO_MOVIMENTO>'+&
				'<EMPRESA>'+ls_empresa+'</EMPRESA>'+&
				'<DADOS_ADICIONAIS>'+ ls_Dados_Adicionais + '</DADOS_ADICIONAIS>'+&
				'<FORNECEDOR>'+ls_cd_fornecedor_incineracao_sap+'</FORNECEDOR>'+&
				'<NF_TRANSPORTE>'+ls_nf_transporte+'</NF_TRANSPORTE>'+&
				'<CHAVE_ACESSO></CHAVE_ACESSO>'+&
            '<LOG></LOG>' + &
				'</CABECALHO>'

ps_xml += ls_xml_item

if IsNull(ps_xml) or Trim(ps_xml) = '' then
	ps_log = 'XML est$$HEX1$$e100$$ENDHEX$$ nulo para o envio da movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque.'
	return false
end if

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
string ls_msg

ls_msg = of_busca_valor(as_xml, '<MENSAGEM>', ref ll_contador)

if upper(Trim(ls_msg)) <> 'INSERIDO COM SUCESSO' Then
	if Trim(ls_msg)	= 'Solicita$$HEX2$$e700e300$$ENDHEX$$o J$$HEX1$$e100$$ENDHEX$$ Processada' Then
		this.of_atualiza_processado( il_Integracao, 'P', ls_msg, ref as_log)
	else
		this.of_atualiza_processado( il_Integracao, 'E', ls_msg, ref as_log)
	end if
	
end if

return True
end function

public function boolean of_busca_deposito_entrada (string as_cd_chave_movimento, long al_cd_produto, ref string as_deposito_entrada, ref string as_log);select	b.cd_deposito_sap
  Into :as_deposito_entrada
from wms_movimento_estoque w
inner join wms_endereco e on (e.cd_endereco = w.cd_endereco_localizacao)
inner join wms_bairro b on (b.cd_bairro = e.cd_bairro)
inner join wms_tipo_movimento_estoque t on (t.cd_tipo_movimento = w.cd_tipo_movimento)
inner join produto_geral g on (g.cd_produto = w.cd_produto)
where w.cd_chave_movimento = :as_cd_chave_movimento
  and w.cd_produto = :al_cd_produto
  and t.id_entrada_saida = 'E'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro ao buscar o dep$$HEX1$$f300$$ENDHEX$$stio de entrada do movimento de estoque 'of_busca_deposito_entrada': " + SqlCa.SqlerrText
	Return False
End If

return true
end function

public function boolean of_atualiza_chave_interface (string ps_chave, ref string ps_log);String	ls_cd_chave


update log_exportacao_sap
set cd_chave_interface = :ps_chave
where nr_atualizacao = :il_Integracao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_sap 'of_atualiza_processado': " + SqlCa.SqlerrText
	Return False
End If

select cd_chave 
  into :ls_cd_chave
  from log_exportacao_sap 
 where id_tipo_nf in ('WMS', 'WMM', 'WMA', 'WMI') and 
 		 nr_atualizacao = :il_Integracao;

if ls_cd_chave <> '' and isnumber(ls_cd_chave) then
	update wms_int_sap
		set cd_chave_interface	= :ps_chave,
			 id_situacao			= 'I',
			 dh_envio_sap			= getdate()
	 where cast(nr_integracao as varchar(10))	= :ls_cd_chave;

	If SqlCa.SqlCode = -1 Then
		ps_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do wms_int_sap para marcar como integrado: " + SqlCa.SqlerrText
		Return False
	End If
end if
end function

public function boolean of_monta_xml_item_produto (long pl_nr_integracao, ref string ps_xml, ref string ps_log, ref string ps_tipo_movimento, string ps_centro_empresa);//override
Date 		ldt_atual
DateTime	ldt_dh_validade, ldt_dh_fabricacao
Long 		ll_for, ll_count, ll_cd_produto, ll_nr_atualizacao_pendente, ll_Qt_Total = 0, ll_vl_fator_conversao
String 	ls_material, ls_quantidade, ls_unidade_de_medida, ls_centro, ls_deposito_entrada, ls_deposito_saida, &
			ls_centro_de_custo, ls_cd_chave_movimento, ls_Entrada_Saida, ls_motivo, ls_nr_lote, ls_dh_fabricacao, &
			ls_dh_validade, ls_Conta_SAP, ls_SQL, ls_log

dc_uo_ds_base lds_movimento_estoque_item


Try
	lds_movimento_estoque_item = create dc_uo_ds_base
	
	ldt_atual = Date(gf_getserverdate())
	
	If Not lds_movimento_estoque_item.of_ChangeDataObject('ds_ge481_wms_movimento_estoque_item', False) Then
		ps_log = "Erro ao alterar a DW 'ds_ge481_wms_movimento_estoque_item'."
		Return False
	End If
	
	If is_tipo_movimento = 'SEGREG RECEB' Then
		ls_Entrada_Saida = 'E'
	Else
		ls_Entrada_Saida = 'S'
	End If
	
	ll_count = lds_movimento_estoque_item.retrieve( pl_nr_integracao, ls_Entrada_Saida, is_tipo_movimento)
	
	If ll_count < 0 Then
		ps_log = "Erro ao recuperar os dados da DW 'ds_ge481_wms_movimento_estoque_item'."
		Return False
	End If
	
	If ll_count = 0 Then
		ps_log = "Nenhum produto foi localizado na DW 'ds_ge481_wms_movimento_estoque_item'."
		Return False
	End If
							
	For ll_for = 1 To ll_count
		ll_cd_produto 	= lds_movimento_estoque_item.GetItemNumber(ll_for,"cd_produto")
		
		/* A valida$$HEX2$$e700e300$$ENDHEX$$o abaixo n$$HEX1$$e300$$ENDHEX$$o deve mais ser feita, pois, a transfer$$HEX1$$ea00$$ENDHEX$$ncia est$$HEX1$$e100$$ENDHEX$$ atrapalhando devido a ordem dos acontecimentos.
		
		if Not lf_ge481_verifica_mov_est_pen_sap(ll_cd_produto, il_Integracao, REF ll_nr_atualizacao_pendente, REF ps_log) then
			Return False
		end if
		
		if ll_nr_atualizacao_pendente > 0 then
			ps_log	= 'Envio de movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque pendente. Exporta$$HEX2$$e700e300$$ENDHEX$$o: ' + String(ll_nr_atualizacao_pendente) + ' Produto: ' + String(ll_cd_produto)
			Return False
		end if*/
				
		ls_cd_chave_movimento 	= lds_movimento_estoque_item.GetItemString(ll_for,"cd_chave_movimento")
		ll_cd_produto 					= lds_movimento_estoque_item.GetItemNumber(ll_for,"cd_produto")
		ls_material 						= lds_movimento_estoque_item.GetItemString(ll_for,"material")
		ls_quantidade 					= String(lds_movimento_estoque_item.GetItemNumber(ll_for,"quantidade"))
		ll_Qt_Total 						+= lds_movimento_estoque_item.GetItemNumber(ll_for,"quantidade")
		ls_unidade_de_medida 		= lds_movimento_estoque_item.GetItemString(ll_for,"unidade_de_medida")
		ls_centro 						= lds_movimento_estoque_item.GetItemString(ll_for,"centro")	
		ls_deposito_saida 				= lds_movimento_estoque_item.GetItemString(ll_for,"deposito_saida")
		ls_deposito_entrada 			= lds_movimento_estoque_item.GetItemString(ll_for,"deposito_entrada")
		ls_centro_de_custo 			= lds_movimento_estoque_item.GetItemString(ll_for,"centro_de_custo")
		ls_motivo						= lds_movimento_estoque_item.GetItemString(ll_for,"de_motivo_devolucao")
		ls_nr_lote						= lds_movimento_estoque_item.GetItemString(ll_for,"nr_lote")
		ldt_dh_validade				= lds_movimento_estoque_item.GetItemDateTime(ll_for,"dh_validade")
		ldt_dh_fabricacao				= lds_movimento_estoque_item.GetItemDateTime(ll_for,"dh_fabricacao")
		ls_Conta_SAP 					= lds_movimento_estoque_item.GetItemString(ll_for,"cd_conta_sap")
		ls_SQL		 					= lds_movimento_estoque_item.GetItemString(ll_for,"id_sql")
			
		If IsNull(ls_Conta_SAP) Then ls_Conta_SAP = ''
		
		if IsNull(ls_nr_lote) or Trim(ls_nr_lote) = '' or is_id_tipo_nf = 'WMM' then
			ls_nr_lote 			= ''
			ls_dh_validade 	= ''
			ls_dh_fabricacao	= ''
		else
			if IsNull(ldt_dh_validade) then
				ps_log = 'Um produto com lote obrigatoriamente deve ter uma data de validade.'
				continue
			else
				ls_dh_validade = String(ldt_dh_validade, "yyyymmdd")
			end if
			
			if IsNull(ldt_dh_fabricacao) then
				ldt_dh_fabricacao = DateTime(RelativeDate(ldt_atual, -90))
			end if
			
			if ldt_dh_fabricacao >= ldt_dh_validade then
				ldt_dh_fabricacao = DateTime(RelativeDate(Date(ldt_dh_validade), -90))
			end if
			
			ls_dh_fabricacao = String(ldt_dh_fabricacao, "yyyymmdd")			
		end if
		
		if not is_tipo_movimento = 'EQUALIZACAO' then //Equaliza$$HEX2$$e700e300$$ENDHEX$$o com o SAP $$HEX1$$e900$$ENDHEX$$ feito na unidade de venda
			//C$$HEX1$$f300$$ENDHEX$$digo de seguran$$HEX1$$e700$$ENDHEX$$a - Sistema est$$HEX1$$e100$$ENDHEX$$ enviando como UN produtos que deveriam ser descartados como CXU
			SELECT
				pg.vl_fator_conversao
			INTO
				:ll_vl_fator_conversao
			FROM
				produto_geral pg
			WHERE
				pg.cd_produto	= :ll_cd_produto
			USING SQLCA;
			
			Choose Case SQLCA.SQLCode
				Case -1
					ps_log = 'Erro ao consultar o fator de convers$$HEX1$$e300$$ENDHEX$$o do produto ' + String(ll_cd_produto) + '.'
					Return False
				Case 100
					ps_log = 'Fator de convers$$HEX1$$e300$$ENDHEX$$o do produto ' + String(ll_cd_produto) + ' n$$HEX1$$e300$$ENDHEX$$o foi localizado.'
					Return False
			End Choose
			
			if ll_vl_fator_conversao > 1 and ls_unidade_de_medida <> 'CXU' then
				ps_log = 'Fator de convers$$HEX1$$e300$$ENDHEX$$o do produto ' + String(ll_cd_produto) + ' n$$HEX1$$e300$$ENDHEX$$o corresponde com a unidade enviada para o SAP.'
				Return False
			end if
			
			if ll_vl_fator_conversao = 1 and ls_unidade_de_medida = 'CXU' then
				ps_log = 'Fator de convers$$HEX1$$e300$$ENDHEX$$o do produto ' + String(ll_cd_produto) + ' n$$HEX1$$e300$$ENDHEX$$o corresponde com a unidade enviada para o SAP.'
				Return False
			end if
		end if
		
		If Not IsNull(is_tipo_movimento) Then
			
			ls_centro_de_custo 	= ''
			
			Choose Case is_tipo_movimento
				Case 'SEGREG RECEB', 'REVENDA_SEGREGADO'
					ls_deposito_saida 	= '0001' // livre utiliza$$HEX2$$e700e300$$ENDHEX$$o
					ls_deposito_entrada 	= '0002' // segregado
				Case 'SEGREGADO_REVENDA'
					ls_deposito_saida 	= '0002' // segregado
					ls_deposito_entrada 	= '0001' // livre utiliza$$HEX2$$e700e300$$ENDHEX$$o
				Case 'INVENTARIO', 'EQUALIZACAO'
					If IsNull(ls_deposito_saida) Then ls_deposito_saida = ''
					If IsNull(ls_deposito_entrada) Then ls_deposito_entrada = ''
					ls_centro_de_custo = '1156021'
				Case Else // SEGREG DESCARTE
					ls_deposito_saida 		= '0002' // segregado
					ls_deposito_entrada 	= '' 	   
			End Choose
		Else		
			ls_deposito_entrada = ''
			If Not IsNull(ls_centro_de_custo) and Trim(ls_centro_de_custo) <> '' Then
				
				If ls_centro_de_custo = '100896' Then
					ls_centro_de_custo = '1156021'
				Else
					ps_log = "Centro de custo [" + ls_centro_de_custo + " ] n$$HEX1$$e300$$ENDHEX$$o previsto {centro_de_custo}."
				End If
				
				ps_tipo_movimento = '201'
			Else
				If Not This.of_busca_deposito_entrada(ls_cd_chave_movimento, ll_cd_produto, Ref ls_deposito_entrada, Ref ps_log) Then Return False
				ls_centro_de_custo = ''
			End If
		End If
		
		if not IsNull(is_cd_centro_custo_sap) and Trim(is_cd_centro_custo_sap) <> '' Then
			ls_centro_de_custo = is_cd_centro_custo_sap
		End If
		
		if ls_material = '' or isnull(ls_material) Then
			ps_log = 'Campo do movimento de estoque {material} n$$HEX1$$e300$$ENDHEX$$o informado. Produto:' + String(ll_cd_produto)
			continue
		end if

		if ls_quantidade = '' or isnull(ls_quantidade) Then
			ps_log = 'Campo do movimento de estoque {quantidade} n$$HEX1$$e300$$ENDHEX$$o informado.'
			continue
		end if		
		
		if ls_unidade_de_medida = '' or isnull(ls_unidade_de_medida) Then
			ps_log = 'Campo do movimento de estoque {unidade_de_medida} n$$HEX1$$e300$$ENDHEX$$o informado.'
			continue
		end if				
		
		if ls_centro = '' or isnull(ls_centro) Then
			ps_log = 'Campo do movimento de estoque {centro} n$$HEX1$$e300$$ENDHEX$$o informado.'
			continue
		end if						
		
		If is_tipo_movimento <> 'INVENTARIO' then
			if ls_deposito_saida = '' or isnull(ls_deposito_saida) Then
				ps_log = 'Campo do movimento de estoque {deposito_saida} n$$HEX1$$e300$$ENDHEX$$o informado.'
				continue
			end if		
		end if
		
		if IsNull(ls_motivo) then ls_motivo = ''
		
		If Not IsNull(is_tipo_movimento) Then
			If is_tipo_movimento = 'SEGREG DESCARTE' Then
				ls_centro_de_custo	= '1156021'
			End If
		End If
		
		if IsNull(ls_centro_de_custo) or ls_centro_de_custo = '0' then ls_centro_de_custo = ''
		
		if (ls_centro = '1156' or ls_centro = '2157') and ps_centro_empresa = '1000' then
		else
			if ls_centro <> ps_centro_empresa then
				if Trim(ls_centro_de_custo) = '' then 
					ps_log = 'Centro de custo inv$$HEX1$$e100$$ENDHEX$$lido para transfer$$HEX1$$ea00$$ENDHEX$$ncia entre centros.'
					continue
				end if
			end if
		end if
		
		ps_xml += '<ITENS>' 

		ps_xml += '<ITEM>'+String(ll_for)+'</ITEM>'+&
						'<MATERIAL>'+ls_material+'</MATERIAL>'+&
						'<QUANTIDADE>'+ls_quantidade+'</QUANTIDADE>'+&
						'<PRECO_UNITARIO></PRECO_UNITARIO>' +&
						'<UNIDADE_DE_MEDIDA>'+ls_unidade_de_medida+'</UNIDADE_DE_MEDIDA>'+&
						'<CENTRO>'+ls_centro+'</CENTRO>'+&
						'<DEPOSITO_ENTRADA>'+ls_deposito_entrada+'</DEPOSITO_ENTRADA>'+&
						'<DEPOSITO_SAIDA>'+ls_deposito_saida+'</DEPOSITO_SAIDA>'+&
						'<CONTA_RAZAO>'+ls_Conta_SAP+'</CONTA_RAZAO>'+&
						'<CENTRO_DE_CUSTO>'+ls_centro_de_custo+'</CENTRO_DE_CUSTO>'+&
						'<TEXTO>' + is_Texto_Item + '</TEXTO>'+&
						'<MOTIVO>'+ls_motivo+'</MOTIVO>'+&
						'<NR_LOTE>'+trim(ls_nr_lote)+'</NR_LOTE>'+&
						'<DATA_FABRICACAO>'+ls_dh_fabricacao+'</DATA_FABRICACAO>'+&
						'<DATA_VALIDADE>'+ls_dh_validade+'</DATA_VALIDADE>'
	
		ps_xml += '</ITENS>'
	Next
	
	If Not of_valida_quantidade_total(pl_nr_integracao, ll_Qt_Total, Ref ls_log) Then
		ps_log = "Quantidade total diferente do esperado pela wms_int_sap_detalhe. " + ls_log
		Return False
	End If
	
Finally
	Destroy(lds_movimento_estoque_item)
End Try
			
return true
end function

public function boolean of_valida_quantidade_total (long al_integracao, long al_qt_total, ref string as_msg);Long ll_Qt_wisd

Select Sum(wisd.qt_lote) 
Into :ll_Qt_wisd
From wms_int_sap_detalhe wisd
	Inner join wms_int_sap wis on wis.nr_integracao = wisd.nr_integracao 
	Inner join log_exportacao_sap les on les.cd_chave = (cast(wis.nr_integracao as varchar(20)))
Where les.nr_atualizacao  = :al_integracao
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	as_msg = sqlca.sqlerrtext
	Return False
End If

Return True
end function

on uo_ge481_wms_movimento_estoque.create
call super::create
end on

on uo_ge481_wms_movimento_estoque.destroy
call super::destroy
end on

