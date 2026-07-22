HA$PBExportHeader$uo_ge481_wms_mov_estoque.sru
forward
global type uo_ge481_wms_mov_estoque from uo_ge481_exportacao
end type
end forward

global type uo_ge481_wms_mov_estoque from uo_ge481_exportacao
end type
global uo_ge481_wms_mov_estoque uo_ge481_wms_mov_estoque

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean of_atualiza_chave_interface (string as_chave, ref string ps_log)
public function boolean of_monta_xml_item_produto (string ps_nr_exportacao, ref string ps_xml_item, ref string ps_log)
end prototypes

public function boolean _of_parametros ();//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_MOV_MERCADORIA_SAIDA>'

is_Termino_XML	=	'</exp:MT_MOV_MERCADORIA_SAIDA>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho 			= False
is_DS 						= 'ds_ge481_movimento_estoque_novo'
is_Objeto 					= this.classname( )
is_nome_arquivo 			= 'wms_movimento_estoque_xml'
is_Parametro_URL 			= 'CD_URL_WMS_MOVIMENTO_ESTOQUE'
is_Tipo_Log_Exp 			= 'WMS_MOVIMENTO_ESTOQUE'
is_Descricao_Tipo_Log 	= 'WMS_MOVIMENTO_ESTOQUE'
is_Nome_Interface 		= 'WMS_MOVIMENTO_ESTOQUE'

ii_contador_xml = 1

ib_continua_apos_erro_montar_xml = True

return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);/*
	Dire$$HEX2$$e700e300$$ENDHEX$$o Movimento - SAP
	03 - Sa$$HEX1$$ed00$$ENDHEX$$da 
	04 - Transfer$$HEX1$$ea00$$ENDHEX$$ncia 
	05 - Entrada 
*/

String	ls_nr_solicitacao, ls_data_movimentacao, ls_data_lancamento, ls_direcao_movimento, ls_tipo_movimento, &
			ls_empresa, ls_xml_item, ls_nf_exportacao


ls_nf_exportacao		= pds_dados.GetItemString(pl_linha,"nr_exportacao")
ls_data_movimentacao = String(pds_dados.GetItemDateTime(pl_linha,"data_movimentacao"),"YYYYMMDD")
ls_data_lancamento 	= String(pds_dados.GetItemDateTime(pl_linha,"data_lancamento"),"YYYYMMDD")
ls_direcao_movimento = pds_dados.GetItemString(pl_linha,"direcao_movimento")
ls_tipo_movimento 	= pds_dados.GetItemString(pl_linha,"tipo_movimento")
ls_empresa 				= String(pds_dados.GetItemNumber(pl_linha,"empresa"))
ls_nr_solicitacao		= pds_dados.GetItemString(pl_linha,"cd_varchar3")

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

if ls_empresa = '' or isnull(ls_empresa) Then
	ps_log = 'Empresa do movimento de estoque {empresa} n$$HEX1$$e300$$ENDHEX$$o informada.'
	return false
end if

If Not of_monta_xml_item_produto(ls_nf_exportacao, ref ls_xml_item, ref ps_log) Then
	Return False
End If

if ls_tipo_movimento = '' or isnull(ls_tipo_movimento) Then
	ps_log = 'Tipo do movimento de estoque {tipo_movimento} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

ps_xml += '<CABECALHO>'+&
				'<NR_SOLICITACAO>'+ls_nr_solicitacao+'</NR_SOLICITACAO>'+&
				'<DATA_MOVIMENTACAO>'+ls_data_movimentacao+'</DATA_MOVIMENTACAO>'+&
				'<DATA_LANCAMENTO>'+ls_data_movimentacao+'</DATA_LANCAMENTO>'+&
				'<DIRECAO_MOVIMENTO>'+ls_direcao_movimento+'</DIRECAO_MOVIMENTO>'+&
				'<TIPO_MOVIMENTO>'+ls_tipo_movimento+'</TIPO_MOVIMENTO>'+&
				'<EMPRESA>'+ls_empresa+'</EMPRESA>'+&
				'<DADOS_ADICIONAIS></DADOS_ADICIONAIS>'+&
				'<FORNECEDOR></FORNECEDOR>'+&
				'<NF_TRANSPORTE></NF_TRANSPORTE>'+&
				'<CHAVE_ACESSO></CHAVE_ACESSO>'+&
            '<LOG></LOG>' + &
				'</CABECALHO>'

ps_xml += ls_xml_item

if IsNull(ps_xml) then
	ps_log = 'XML est$$HEX1$$e100$$ENDHEX$$ nulo para o envio da movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque.'
	return false
end if

return true
end function

public function boolean of_atualiza_chave_interface (string as_chave, ref string ps_log);String	ls_cd_chave


UPDATE
	log_exportacao
SET
	cd_varchar3 = :as_chave
WHERE
	nr_exportacao	= :is_nr_exportacao
USING SQLCA;

If SQLCA.SQLCode = -1 Then
	ps_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao 'of_atualiza_chave_interface': " + SqlCa.SqlerrText
	Return False
End If
end function

public function boolean of_monta_xml_item_produto (string ps_nr_exportacao, ref string ps_xml_item, ref string ps_log);/*
	Dire$$HEX2$$e700e300$$ENDHEX$$o Movimento - SAP
	03 - Sa$$HEX1$$ed00$$ENDHEX$$da 
	04 - Transfer$$HEX1$$ea00$$ENDHEX$$ncia 
	05 - Entrada 
*/

Date	ld_dt_atual
Long	ll_count, ll_for, ll_cd_produto, ll_quantidade
String	ls_material_sap, ls_unidade_medida, ls_centro_sap, ls_deposito_saida, ls_deposito_entrada, ls_centro_custo

dc_uo_ds_base lds_movimento_estoque_item


Try
	lds_movimento_estoque_item = create dc_uo_ds_base
	
	ld_dt_atual = Date(gf_getserverdate())
	
	If Not lds_movimento_estoque_item.of_ChangeDataObject('ds_ge481_movimento_estoque_item_novo', False) Then
		ps_log = "Erro ao alterar a DW 'ds_ge481_movimento_estoque_item_novo'."
		Return False
	End If
	
	ll_count = lds_movimento_estoque_item.Retrieve(ps_nr_exportacao)
	
	If ll_count < 0 Then
		ps_log = "Erro ao recuperar os dados da DW 'ds_ge481_movimento_estoque_item_novo'."
		Return False
	End If
	
	If ll_count = 0 Then
		ps_log = "Nenhum produto foi localizado na DW 'ds_ge481_movimento_estoque_item_novo'."
		Return False
	End If
	
	For ll_for = 1 To ll_count
		ll_cd_produto 	= lds_movimento_estoque_item.GetItemNumber(ll_for,"cd_produto")
		
		SELECT
			pg.cd_produto_sap,
			CASE WHEN pg.vl_fator_conversao > 1 THEN 'CXU' ELSE pg.cd_unidade_medida_venda END
		INTO
			:ls_material_sap,
			:ls_unidade_medida
		FROM
			produto_geral pg
		WHERE
			pg.cd_produto	= :ll_cd_produto;
			
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = 'Erro ao localizar dados do produto. Erro: ' + SQLCA.SQLErrText
				Continue
			Case 100
				ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foram localizados dados para o produto ' + String(ll_cd_produto)
				Continue
		End Choose
			
		if ls_material_sap = '' or isnull(ls_material_sap) Then
			ps_log = 'Campo do movimento de estoque {material sap} n$$HEX1$$e300$$ENDHEX$$o informado. Produto:' + String(ll_cd_produto)
			continue
		end if
		
		if ls_unidade_medida = '' or isnull(ls_unidade_medida) Then
			ps_log = 'Campo do movimento de estoque {unidade_medida} n$$HEX1$$e300$$ENDHEX$$o informado.'
			continue
		end if

		ll_quantidade			= lds_movimento_estoque_item.GetItemNumber(ll_for,"quantidade")
		ls_centro_sap			= lds_movimento_estoque_item.GetItemString(ll_for,"centro")	
		ls_deposito_saida 	= lds_movimento_estoque_item.GetItemString(ll_for,"deposito_saida")
		ls_deposito_entrada 	= lds_movimento_estoque_item.GetItemString(ll_for,"deposito_entrada")
		ls_centro_custo 		= lds_movimento_estoque_item.GetItemString(ll_for,"centro_de_custo")
		
		if ll_quantidade = 0 or IsNull(ll_quantidade) Then
			ps_log = 'Campo do movimento de estoque {quantidade} n$$HEX1$$e300$$ENDHEX$$o informado.'
			continue
		end if
		
		if ls_centro_sap = '' or isnull(ls_centro_sap) Then
			ps_log = 'Campo do movimento de estoque {centro_sap} n$$HEX1$$e300$$ENDHEX$$o informado.'
			continue
		end if
		
		if IsNull(ls_deposito_saida) then ls_deposito_saida = ''
		if IsNull(ls_deposito_entrada) then ls_deposito_entrada = ''
		
		if ls_deposito_entrada = '' and ls_deposito_saida = '' then
			ps_log = 'Nenhum dep$$HEX1$$f300$$ENDHEX$$sito informado para movimenta$$HEX2$$e700e300$$ENDHEX$$o.'
			continue
		end if
		
		if IsNull(ls_centro_custo) or ls_centro_custo = '0' then ls_centro_custo = ''
		
		ps_xml_item += '<ITENS>' 

		ps_xml_item += '<ITEM>'+String(ll_for)+'</ITEM>'+&
							'<MATERIAL>'+ls_material_sap+'</MATERIAL>'+&
							'<QUANTIDADE>'+String(ll_quantidade)+'</QUANTIDADE>'+&
							'<PRECO_UNITARIO></PRECO_UNITARIO>' +&
							'<UNIDADE_DE_MEDIDA>'+ls_unidade_medida+'</UNIDADE_DE_MEDIDA>'+&
							'<CENTRO>'+ls_centro_sap+'</CENTRO>'+&
							'<DEPOSITO_ENTRADA>'+ls_deposito_entrada+'</DEPOSITO_ENTRADA>'+&
							'<DEPOSITO_SAIDA>'+ls_deposito_saida+'</DEPOSITO_SAIDA>'+&
							'<CONTA_RAZAO></CONTA_RAZAO>'+&
							'<CENTRO_DE_CUSTO>'+ls_centro_custo+'</CENTRO_DE_CUSTO>'+&
							'<TEXTO></TEXTO>'+&
							'<MOTIVO></MOTIVO>'+&
							'<NR_LOTE></NR_LOTE>'+&
							'<DATA_FABRICACAO></DATA_FABRICACAO>'+&
							'<DATA_VALIDADE></DATA_VALIDADE>'
	
		ps_xml_item += '</ITENS>'
	Next
Finally
	Destroy(lds_movimento_estoque_item)
End Try

Return True
end function

on uo_ge481_wms_mov_estoque.create
call super::create
end on

on uo_ge481_wms_mov_estoque.destroy
call super::destroy
end on

