HA$PBExportHeader$uo_ge481_wms_envio_divergencias_nfd.sru
forward
global type uo_ge481_wms_envio_divergencias_nfd from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_wms_envio_divergencias_nfd from uo_ge481_subida_generica autoinstantiate
end type

type variables
Boolean	ib_recebido_sap = false
Dec		idc_vl_total_nf	= 0
Long 		il_Integracao, il_nr_atualizacao

t_infnfe	it_InfNFe[]
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean of_atualiza_chave_interface (string ps_chave, ref string ps_log)
public function boolean of_monta_xml_item_origem (long pl_nr_devolucao, ref string ps_xml, ref string ps_log, string ps_nr_solicitacao)
public function boolean of_monta_xml_item_produto (long pl_nr_devolucao, ref string ps_xml, ref string ps_log, string ps_nr_solicitacao)
public function boolean of_busca_cfop_origem (string as_de_chave_acesso_origem, long al_cd_produto, ref long al_cd_natureza_operacao, ref string as_log)
end prototypes

public function boolean _of_parametros ();//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_DEVOLUCAO_OUT>'

is_Termino_XML	=	'</exp:MT_DEVOLUCAO_OUT>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_envio_divergencias_nfd'
is_Objeto = this.classname( )
is_nome_arquivo = 'envio_divergencias_nfd_xml'
is_Parametro_URL = 'CD_URL_ENVIO_DIVERGENCIAS_NFD'
is_Tipo_Log_Exp = 'ENVIO_DIVERGENCIAS_NFD'
is_Descricao_Tipo_Log = 'ENVIO_DIVERGENCIAS_NFD'
is_Nome_Interface = 'ENVIO_DIVERGENCIAS_NFD'

//Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere("id_status_integracao = 'C' " )
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
long		ll_exists
string 	ls_nr_devolucao
string 	ls_cd_fornecedor_sap
string 	ls_de_dados_adicionais
string 	ls_cd_transportadora
string	ls_qt_volume
string	ls_de_especie
string 	ls_de_marca
string 	ls_nr_volume
string 	ls_qt_peso_bruto
string 	ls_qt_peso_liquido
string 	ls_cd_motivo_devolucao
string 	ls_status_devolucao
string 	ls_nr_docnum
string 	ls_dh_solicitacao
string	ls_devolucao_sem_referencia
string	ls_valor_total_nf
string 	ls_nr_solicitacao
string	ls_cd_chave_interface

Date ldh_Inclusao, ldh_hoje

ls_nr_devolucao 			= String(pds_dados.GetItemNumber(pl_linha,"nr_devolucao"))
ls_cd_fornecedor_sap 	= pds_dados.GetItemString(pl_linha,"cd_fornecedor_sap")
ls_de_dados_adicionais 	= pds_dados.GetItemString(pl_linha,"de_dados_adicionais")
ls_cd_transportadora 	= pds_dados.GetItemString(pl_linha,"cd_transportadora")
ls_qt_volume 				= String(pds_dados.GetItemNumber(pl_linha,"qt_volume"))
ls_de_especie 				= pds_dados.GetItemString(pl_linha,"de_especie")
ls_de_marca 				= pds_dados.GetItemString(pl_linha,"de_marca")
ls_nr_volume 				= pds_dados.GetItemString(pl_linha,"nr_volume")
ls_qt_peso_bruto 			= String(pds_dados.GetItemDecimal(pl_linha,"qt_peso_bruto"))
ls_qt_peso_liquido 		= String(pds_dados.GetItemDecimal(pl_linha,"qt_peso_liquido"))
ls_cd_motivo_devolucao 	= pds_dados.GetItemString(pl_linha,"cd_motivo_devolucao")
ls_status_devolucao 		= pds_dados.GetItemString(pl_linha,"status_devolucao")
ls_nr_docnum 				= pds_dados.GetItemString(pl_linha,"nr_docnum")
ldh_Inclusao	 			= Date(pds_dados.GetItemDateTime(pl_linha,"dh_inclusao"))
il_nr_atualizacao			= pds_dados.GetItemNumber(pl_linha,"nr_atualizacao")
ls_cd_chave_interface	= pds_dados.GetItemString(pl_linha,"cd_chave_interface")

il_Integracao		= Long(ls_nr_devolucao)
ldh_hoje				= Date(gf_getserverdate())
ls_dh_solicitacao = String(ldh_hoje, 'YYYYMMDD')

if ls_nr_devolucao = '' or isnull(ls_nr_devolucao) Then
	ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero de devolu$$HEX2$$e700e300$$ENDHEX$$o da NF {nr_devolucao} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

if ls_cd_fornecedor_sap = '' or isnull(ls_cd_fornecedor_sap) Then
	ps_log = 'C$$HEX1$$f300$$ENDHEX$$dido do fornecedor SAP n$$HEX1$$e300$$ENDHEX$$o informado para o n$$HEX1$$fa00$$ENDHEX$$mero de devolu$$HEX2$$e700e300$$ENDHEX$$o '+ls_nr_devolucao+'.'
	return false
end if

ps_xml	= ''

ls_nr_solicitacao	 = ls_cd_chave_interface

if ls_nr_solicitacao = '' or isnull(ls_nr_solicitacao) Then
	ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o de envio {nr_solicitacao} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

//Origem da devolucao
If of_monta_xml_item_origem(Long(ls_nr_devolucao), ref ps_xml, ref ps_log, ls_nr_solicitacao) Then
	//Produto da devolucao
	If Not of_monta_xml_item_produto(Long(ls_nr_devolucao), ref ps_xml, ref ps_log, ls_nr_solicitacao) Then
		Return False
	End If
Else 
	Return False
End If

if ib_recebido_sap then
	ls_devolucao_sem_referencia 	= ''
	ls_valor_total_nf					= ''
else
	ls_devolucao_sem_referencia 	= 'X'
	ls_valor_total_nf					= gf_replace(String(idc_vl_total_nf), ',','.',1)
end if

ps_xml = '<CABECALHO>'+&
			'<nr_devolucao>'+ls_nr_solicitacao+'</nr_devolucao>'+&
			'<cd_fornecedor_sap>'+ls_cd_fornecedor_sap+'</cd_fornecedor_sap>'+&
			'<de_dados_adicionais>'+ls_de_dados_adicionais+'</de_dados_adicionais>'+&
			'<cd_transportadora>'+ls_cd_transportadora+'</cd_transportadora>'+&
			'<qt_volume>'+ls_qt_volume+'</qt_volume>'+&
			'<de_especie>'+ls_de_especie+'</de_especie>'+&
			'<de_marca>'+ls_de_marca+'</de_marca>'+&
			'<nr_volume>'+ls_nr_volume+'</nr_volume>'+&
			'<qt_peso_bruto>'+ls_qt_peso_bruto+'</qt_peso_bruto>'+&
			'<qt_peso_liquido>'+ls_qt_peso_liquido+'</qt_peso_liquido>'+&
			'<cd_motivo_devolucao>'+ls_cd_motivo_devolucao+'</cd_motivo_devolucao>'+&
			'<status_devolucao>'+ls_status_devolucao+'</status_devolucao>'+&
			'<nr_docnum>'+ls_nr_docnum+'</nr_docnum>'+&
			'<dh_solicitacao>'+ls_dh_solicitacao+'</dh_solicitacao>'+&
			'<devolucao_sem_referencia>'+ls_devolucao_sem_referencia+'</devolucao_sem_referencia>' + &
         '<valor_total_nf>'+ls_valor_total_nf+'</valor_total_nf>' + &
			'</CABECALHO>' + ps_xml
			
idc_vl_total_nf = 0

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
string ls_status, ls_msg

ls_status = of_busca_valor(as_xml, '<STATUS>', ref ll_contador)

if upper(ls_status) <> 'S' Then
	ls_msg = of_busca_valor(as_xml, '<MENSAGEM>', ref ll_contador)
	
	if ls_msg = 'Devolu$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ processada anteriormente' then
		//Continuar e aceitar como sucesso
	else
		ll_contador = 1
		ls_msg = of_busca_valor(as_xml, '<MENSAGEM>', ref ll_contador)
		this.of_atualiza_processado( il_nr_atualizacao, 'E', ls_msg, ref as_log)
		
		Return True
	end if
end if

update wms_int_sap
set id_situacao = 'I', dh_envio_sap = GetDate()
where nr_integracao = :il_Integracao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento wms_int_sap '_of_processa_retorno_xml': " + SqlCa.SqlerrText
	Return False
End If

return True
end function

public function boolean of_atualiza_chave_interface (string ps_chave, ref string ps_log);String	ls_cd_chave


update log_exportacao_sap
set cd_chave_interface = :ps_chave
where nr_atualizacao = :il_nr_atualizacao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_sap 'of_atualiza_processado': " + SqlCa.SqlerrText
	Return False
End If
end function

public function boolean of_monta_xml_item_origem (long pl_nr_devolucao, ref string ps_xml, ref string ps_log, string ps_nr_solicitacao);//override
boolean	lb_valida_teste_integrado = False
datetime	ldh_recebido_sap, ldt_dh_emissao
string 	ls_nr_devolucao
string 	ls_nr_item
string 	ls_de_chave_acesso
string 	ls_nr_nf
long 		ll_for
long 		ll_count
long		ll_cd_filial

dc_uo_ds_base lds_envio_diver_origem
lds_envio_diver_origem = create dc_uo_ds_base
t_InfNFe	lt_InfNFe, lt_InfNFe_vazio[] 

ps_xml	= ''

Try
	it_InfNFe	= lt_InfNFe_vazio
	
	If Not lds_envio_diver_origem.of_ChangeDataObject('ds_ge481_envio_divergencias_nfd_origem', False) Then
		ps_log = "Erro ao alterar a DW 'ds_ge481_envio_divergencias_nfd_origem'."
		Return False
	End If
	
	ll_count = lds_envio_diver_origem.retrieve( pl_nr_devolucao )
	
	If ll_count < 0 Then
		ps_log = "Erro ao recuperar os dados da DW 'ds_ge481_envio_divergencias_nfd_origem'."
		Return False
	End If
	
	lb_valida_teste_integrado	= gf_valida_teste_integrado()
	
	ps_xml += '<NF_ORIGEM>'
						
	For ll_for = 1 To ll_count
		
		ls_nr_devolucao = String(lds_envio_diver_origem.GetItemDecimal(ll_for,"nr_devolucao"))
		ls_nr_item = String(lds_envio_diver_origem.GetItemNumber(ll_for,"nr_item"))
		ls_de_chave_acesso = lds_envio_diver_origem.GetItemString(ll_for,"de_chave_acesso")
		ls_nr_nf = String(lds_envio_diver_origem.GetItemNumber(ll_for,"nr_nf"))
		
		SetNull(ldh_recebido_sap)
		
		select top 1 dh_recebido_sap,
				 dh_emissao,
				 cd_filial
		  into :ldh_recebido_sap,
		  		 :ldt_dh_emissao,
				 :ll_cd_filial
		  from nf_compra
		 where de_chave_acesso	= :ls_de_chave_acesso;
		 
		Choose Case SqlCa.SqlCode
			Case -1
				Sqlca.of_MsgDbError("Erro ao buscar o campo dh_recebido_sap na tabela nf_compra.")
				
				Return False
			End Choose
		 
		ib_recebido_sap	= not IsNull(ldh_recebido_sap)
		
		if lb_valida_teste_integrado and ib_recebido_sap then
			select de_chave_acesso_alterada
			  into :ls_de_chave_acesso
			  from recebimento_sap
			 where de_chave_acesso	= :ls_de_chave_acesso;
			
			Choose Case SQLCA.SQLCode
				Case -1
					Sqlca.of_MsgDbError("Erro ao buscar o campo cd_chave_acesso_alterada na tabela recebimento_sap.")
				
					Return False
				Case 100
					Sqlca.of_MsgDbError("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o recebimento_sap para buscar o valor do campo cd_chave_acesso_alterada.")
				
					Return False
				Case 0
			End Choose
		end if
		
		if not ib_recebido_sap then
			if not gf_busca_xml_nfe(ll_cd_filial, ls_de_chave_acesso, ldt_dh_emissao, REF lt_InfNFe, REF ps_log) then
				Return False
			end if
		end if
		
		it_InfNFe[UpperBound(it_InfNFe) + 1] = lt_InfNFe
		
		ps_xml += '<NF_ORIGEM>'+&
						'<NR_DEVOLUCAO>'+ps_nr_solicitacao+'</NR_DEVOLUCAO>'+&
						'<NR_ITEM>'+ls_nr_item+'</NR_ITEM>'+&
						'<DE_CHAVE_ACESSO>'+ls_de_chave_acesso+'</DE_CHAVE_ACESSO>'+&
						'<NR_NF>'+ls_nr_nf+'</NR_NF>'+&
						'</NF_ORIGEM>'
	Next
	
	ps_xml += '</NF_ORIGEM>'
	
Finally
	Destroy(lds_envio_diver_origem)
End Try
			
return true
end function

public function boolean of_monta_xml_item_produto (long pl_nr_devolucao, ref string ps_xml, ref string ps_log, string ps_nr_solicitacao);//override
dec	 	ldc_valor_unitario_liquido
dec	 	ldc_qt_lote
dec	 	ldc_total_item
dec		ldc_pc_reducao_base_icms
dec {8}	ldc_vl_bc_icms_original
dec {8}	ldc_vl_icms_original
dec {8}	ldc_vl_bc_icms_st_original
dec {8}	ldc_vl_icms_st_original
dec {8}	ldc_vl_bc_ipi_original
dec {8}	ldc_vl_ipi_original
dec {8}	ldc_vl_pis_original
dec {8}	ldc_vl_cofins_original
dec {8}	ldc_valor_unitario_liquido_xml
dec {8}	ldc_vl_desconto_xml
dec {8}	ldc_diferenca
string	ls_nr_devolucao
string 	ls_nr_item
string 	ls_cd_produto_sap
string 	ls_nr_lote
string 	ls_qt_lote
string 	ls_dh_fabricacao
string 	ls_dh_validade
string 	ls_cd_grupo_produto
string	ls_valor_unitario_liquido
string	ls_centro
string 	ls_item_op
string 	ls_unidade_moeda
string 	ls_cod_imposto
string 	ls_valor_icms
string 	ls_base_icms
string 	ls_aliquota_icms
string 	ls_valor_icms_st
string 	ls_base_icms_st
string 	ls_aliquota_icms_st
string 	ls_valor_ipi
string 	ls_base_ipi
string 	ls_aliquota_ipi
string 	ls_valor_pis
string 	ls_base_pis
string 	ls_aliquota_pis
string 	ls_valor_cofins
string 	ls_base_cofins
string 	ls_aliquota_cofins
string 	ls_xml
string	ls_de_chave_acesso
string		ls_cd_fornecedor_origem
string		ls_de_especie_origem
string		ls_de_serie_origem
string		ls_nr_lote_nf_origem
string		ls_un_medida
string 	ls_cd_cst_tributacao
string		ls_cd_cst_pis
string		ls_cd_cst_cofins
string		ls_cd_natureza_operacao
string		ls_cd_cst_origem
string		ls_vl_desconto
string		ls_valor_mva
string		ls_valor_pmc
string 	ls_pc_reducao_base_icms
string	ls_de_chave_acesso_origem
string	ls_codigo_barras_nf_compra
string	ls_codigo_barras_nf_compra_trib
long		ll_idx_item_xml_nfe
long		ll_qt_faturada
long 		ll_for
long 		ll_count
long		ll_cd_produto
long		ll_nr_agrupamento
long		ll_nr_nf_origem
long		ll_cd_filial_origem
long		ll_cd_natureza_operacao_origem
long		ll_qt_devolver
long		ll_vl_fator_conversao
long		ll_nr_atualizacao_pendente
long		ll_for_xml, ll_for_det

dc_uo_ds_base lds_envio_diver_detalhe
lds_envio_diver_detalhe = create dc_uo_ds_base

ls_xml	= ''

Try
	
	If Not lds_envio_diver_detalhe.of_ChangeDataObject('ds_ge481_envio_divergencias_nfd_detalhe', False) Then
		ps_log = "Erro ao alterar a DW 'ds_ge481_envio_divergencias_nfd_detalhe'."
		Return False
	End If
	
	ll_count = lds_envio_diver_detalhe.retrieve( pl_nr_devolucao )
	
	If ll_count <= 0 Then
		ps_log = "Erro ao recuperar os dados da DW 'ds_ge481_envio_divergencias_nfd_detalhe'."
		Return False
	End If
	
	ls_xml += '<ITEM>'
	
	// DEPOSITOS
	//0001    Revenda Dispensa
	//0002    Segregados Dispe
	//0003    Ativo/Logistica
	//0004    Consumo        
						
	select nr_agrupamento_dev_compra
	  into :ll_nr_agrupamento
	  from wms_int_sap
	 where nr_integracao	= :il_Integracao;
	 
	For ll_for = 1 To ll_count
		ll_cd_produto							= lds_envio_diver_detalhe.GetItemNumber(ll_for,"cd_produto")		
		ls_nr_devolucao 						= String(lds_envio_diver_detalhe.GetItemDecimal		(ll_for,"nr_devolucao"))
		ls_nr_item 								= String(lds_envio_diver_detalhe.GetItemNumber		(ll_for,"nr_item"))
		ls_cd_produto_sap 					= lds_envio_diver_detalhe.GetItemString					(ll_for,"cd_produto_sap")
		ls_nr_lote 								= lds_envio_diver_detalhe.GetItemString					(ll_for,"nr_lote")
		ldc_qt_lote								= lds_envio_diver_detalhe.GetItemNumber				(ll_for,"qt_lote")
		ls_dh_fabricacao 						= String(lds_envio_diver_detalhe.GetItemDateTime	(ll_for,"dh_fabricacao"), 'yyyymmdd')
		ls_dh_validade 						= String(lds_envio_diver_detalhe.GetItemDateTime	(ll_for,"dh_validade"), 'yyyymmdd')
		ls_cd_grupo_produto					= lds_envio_diver_detalhe.GetItemString					(ll_for,"cd_grupo_produto")
		ll_nr_nf_origem						= lds_envio_diver_detalhe.GetItemNumber				(ll_for,"nr_nf")
		ll_cd_filial_origem					= lds_envio_diver_detalhe.GetItemNumber				(ll_for,"cd_filial")
		ls_cd_fornecedor_origem				= lds_envio_diver_detalhe.GetItemString					(ll_for,"cd_fornecedor")
		ls_de_especie_origem					= lds_envio_diver_detalhe.GetItemString					(ll_for,"de_especie")
		ls_de_serie_origem					= lds_envio_diver_detalhe.GetItemString					(ll_for,"de_serie")
		ll_cd_natureza_operacao_origem	= lds_envio_diver_detalhe.GetItemNumber				(ll_for,"cd_natureza_operacao")
		ls_nr_lote_nf_origem					= lds_envio_diver_detalhe.GetItemString					(ll_for,"nr_lote_nf")
		ll_qt_devolver							= lds_envio_diver_detalhe.GetItemNumber				(ll_for,"qt_devolver")
		ls_de_chave_acesso_origem			= lds_envio_diver_detalhe.GetItemString(ll_for,"de_chave_acesso_origem")
		
		if IsNull(ll_nr_nf_origem) and not IsNull(ls_de_chave_acesso_origem) then
			select
				nc.nr_nf,
				nc.cd_fornecedor,
				nc.cd_filial,
				nc.de_especie,
				nc.de_serie,
				inc.cd_natureza_operacao
			into
				:ll_nr_nf_origem,
				:ls_cd_fornecedor_origem,
				:ll_cd_filial_origem,
				:ls_de_especie_origem,
				:ls_de_serie_origem,
				:ll_cd_natureza_operacao_origem
			from
				nf_compra nc
			inner join item_nf_compra inc
				on nc.cd_filial = inc.cd_filial
				and nc.nr_nf = inc.nr_nf
				and nc.de_serie = inc.de_serie
				and nc.de_especie = inc.de_especie
				and nc.cd_fornecedor = inc.cd_fornecedor				
			where 
				nc.de_chave_acesso = :ls_de_chave_acesso_origem
				and inc.cd_produto = :ll_cd_produto;
				
			Choose Case SQLCA.SQLCode
				Case -1
					ps_log = "Erro ao procurar dados da nota fiscal " + ls_de_chave_acesso_origem
					Return False
				Case 100
					ps_log = "N$$HEX1$$e300$$ENDHEX$$o encontrado dados da nota fiscal " + ls_de_chave_acesso_origem
					Return False
			end choose
		end if
		
		ls_qt_lote								= String(ldc_qt_lote)
		
		Setnull(ls_pc_reducao_base_icms)
		
		if not IsNull(ll_nr_agrupamento) then
			if ls_cd_grupo_produto <> '1' then
				if not IsNull(ls_nr_lote) and Trim(ls_nr_lote) <> '' then
					if IsNull(ls_dh_validade) then 
						ps_log = "Produto " + ls_cd_produto_sap + " com lote informado, mas, com validade em branco."
						Return False
					end if
					
					if IsNull(ls_dh_fabricacao) then 
						ps_log = "Produto " + ls_cd_produto_sap + " com lote informado, mas, com data de fabrica$$HEX2$$e700e300$$ENDHEX$$o em branco."
						Return False
					end if
					
					ls_nr_lote_nf_origem	= ls_nr_lote
				else
					ls_nr_lote				= ''
					ls_dh_fabricacao		= ''
					ls_dh_validade			= ''
					ls_nr_lote_nf_origem	= ''
				end if
			end if
		end if
		
		//O c$$HEX1$$f300$$ENDHEX$$digo abaixo deve ser melhorado - Cordeiro
		select de_chave_acesso
		  into :ls_de_chave_acesso
		  from nf_compra
		 where nr_nf						= :ll_nr_nf_origem and
				 cd_filial					= :ll_cd_filial_origem and
				 cd_fornecedor				= :ls_cd_fornecedor_origem and
				 de_especie					= :ls_de_especie_origem and
				 de_serie					= :ls_de_serie_origem;
				 
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = "Erro ao localizar a chave de acesso da nota de compra para buscar os dados do agendamento. ~r~rErro: " + SQLCA.SQLErrText
				Return False
		End Choose
		
		// Localiza o EAN da nota fiscal de origem (entrada), a Hypera exige o EAN da nota de origem
		select top 1 (Case when coalesce(fo.id_utiliza_ean_compra_nfd, 'N') = 'S' Then naei.de_codigo_barras else '' END),
						(Case when coalesce(fo.id_utiliza_ean_compra_nfd, 'N') = 'S' Then naei.de_codigo_barras_trib else '' END)
		  into 	 :ls_codigo_barras_nf_compra,
				 :ls_codigo_barras_nf_compra_trib
		 from dbo.nf_agendamento_ent_item naei
		 inner join dbo.nf_compra nc 
					  on nc.de_chave_acesso = naei.de_chave_acesso
		 inner join dbo.fornecedor fo
					 on fo.cd_fornecedor = nc.cd_fornecedor
		 where naei.de_chave_acesso 	= :ls_de_chave_acesso
			and naei.cd_produto 			= :ll_cd_produto;
		
		Choose Case SQLCA.SQLCode
			Case -1
				ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar os dados da nota fiscal de origem para a devolu$$HEX2$$e700e300$$ENDHEX$$o. ~r~rErro: " + SQLCA.SQLErrText
				Return False
		End Choose
				
		if ib_recebido_sap then
			if not This.of_busca_cfop_origem(ls_de_chave_acesso_origem, ll_cd_produto, REF ll_cd_natureza_operacao_origem, REF ps_log) then
				return False
			else
				ls_cd_natureza_operacao	= string(ll_cd_natureza_operacao_origem)
			end if
			
			ls_valor_unitario_liquido		= ''
			ls_centro							= ''
			ls_valor_icms					= ''
			ls_base_icms					= ''
			ls_aliquota_icms				= ''
			ls_valor_icms_st				= ''
			ls_base_icms_st				= ''
			ls_aliquota_icms_st			= ''
			ls_valor_ipi						= ''
			ls_base_ipi						= ''
			ls_aliquota_ipi					= ''
			ls_valor_pis						= ''
			ls_base_pis						= ''
			ls_aliquota_pis					= ''
			ls_valor_cofins					= ''
			ls_base_cofins					= ''
			ls_aliquota_cofins				= ''
			ls_cd_cst_tributacao			= ''
			ls_cd_cst_pis					= ''
			ls_cd_cst_cofins				= ''
			ls_cd_cst_origem				= ''
			ls_vl_desconto					= ''
			ls_valor_mva					= ''
			ls_valor_pmc					= ''
			ls_pc_reducao_base_icms	= ''
						
		else
		
			SetNull(ll_idx_item_xml_nfe)
			
			select top 1 naei.nr_item,
					 naei.vl_bc_icms_original,
					 naei.vl_icms_original,
					 naei.vl_bc_icms_st_original,
					 naei.vl_icms_st_original,
					 naei.vl_bc_ipi_original,
					 naei.vl_ipi_original,
					 naei.vl_pis,
					 naei.vl_cofins,
					 naei.qt_faturada
			  into :ll_idx_item_xml_nfe,
			  		 :ldc_vl_bc_icms_original,
					 :ldc_vl_icms_original,
					 :ldc_vl_bc_icms_st_original,
					 :ldc_vl_icms_st_original,
					 :ldc_vl_bc_ipi_original,
					 :ldc_vl_ipi_original,
					 :ldc_vl_pis_original,
					 :ldc_vl_cofins_original,
					 :ll_qt_faturada
			  from dbo.nf_agendamento_ent_item naei
			 inner join dbo.nf_agendamento_ent_item_lote naeil
						on naeil.de_chave_acesso = naei.de_chave_acesso 
					  and naeil.nr_item = naei.nr_item
			 where naei.de_chave_acesso 	= :ls_de_chave_acesso
				and naei.cd_produto 			= :ll_cd_produto
				and naeil.nr_lote				= :ls_nr_lote;
			
			Choose Case SQLCA.SQLCode
				Case -1
					ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar os dados da nota fiscal de origem para a devolu$$HEX2$$e700e300$$ENDHEX$$o. ~r~rErro: " + SQLCA.SQLErrText
					Return False
			End Choose

			ll_for_xml = 1
			
			if UpperBound(it_InfNFe) > 0 and ll_idx_item_xml_nfe > 0 then
				ldc_valor_unitario_liquido_xml	= it_InfNFe[ll_for_xml].det[ll_idx_item_xml_nfe].prod.vUnCom
				ldc_vl_desconto_xml					= it_InfNFe[ll_for_xml].det[ll_idx_item_xml_nfe].prod.vDesc
			end if
			
			select coalesce(cast(round(i.vl_preco_unitario, 2) as decimal (7,2)), 0) as valor_unitario_liquido,
					 coalesce(cast(round((i.vl_preco_unitario * (i.pc_desconto / 100)) * :ll_qt_devolver, 2) as decimal (7,2)), 0) as vl_desconto_item,
					 coalesce(cast(i.vl_icms * :ll_qt_devolver as varchar(20)), '') as valor_icms,
					 coalesce(cast(i.vl_bc_icms * :ll_qt_devolver as varchar(20)), '') as base_icms,  
					 coalesce(cast(i.pc_icms as varchar(20)), '') aliquota_icms,
					 coalesce(cast(i.vl_icms_st * :ll_qt_devolver as varchar(20)), '') as valor_icms_st,			
					 coalesce(cast(i.vl_preco_base_icms_st * :ll_qt_devolver as varchar(20)), '') as base_icms_st,
					 coalesce(cast(i.pc_icms_st as varchar(20)), '') as aliquota_icms_st,
					 coalesce(cast(coalesce(i.vl_ipi * :ll_qt_devolver, 0) as varchar(20)), '') as valor_ipi,
					 coalesce(cast(coalesce(i.vl_bc_ipi * :ll_qt_devolver, 0) as varchar(20)), '') as base_ipi,
					 coalesce(cast(coalesce(i.pc_ipi, 0) as varchar(20)), '') as aliquota_ipi,
					 coalesce(cast(round((coalesce(i.vl_pis, 0) / i.qt_faturada) * :ll_qt_devolver, 2) as varchar(20)), '') as valor_pis,			
					 coalesce(cast(round(((i.vl_total_item - i.vl_desconto_total) / i.qt_faturada) * :ll_qt_devolver, 2) as varchar(20)), '') as base_pis,
					 coalesce(cast(round(coalesce(i.vl_pis, 0) / (i.vl_total_item - i.vl_desconto_total) * 100, 2) as varchar(20)), '') as aliquota_pis,
					 coalesce(cast(round((coalesce(i.vl_cofins, 0) / i.qt_faturada) * :ll_qt_devolver, 2) as varchar(20)), '') as valor_cofins,
					 coalesce(cast(round(((i.vl_total_item - i.vl_desconto_total) / i.qt_faturada) * :ll_qt_devolver, 2) as varchar(20)), '') as base_cofins,	
					 coalesce(cast(round(coalesce(i.vl_cofins, 0) / (i.vl_total_item - i.vl_desconto_total) * 100, 2) as varchar(20)), '') as aliquota_cofins,
					 coalesce(cd_cst_tributacao, ''),
					 coalesce(cd_cst_pis, ''),
					 coalesce(cd_cst_cofins, ''),
					 coalesce(cast(cd_natureza_operacao as varchar(4)), ''),
					 coalesce(cd_cst_origem, ''),
					 coalesce(cast(i.pc_mva as varchar(20)), '0'),
					 coalesce(cast(i.vl_pmc as varchar(20)), '0'),
					 coalesce(i.pc_reducao_base_icms , 100) as pc_reducao_base_icms
			  into :ldc_valor_unitario_liquido,
			  		 :ls_vl_desconto,
					 :ls_valor_icms,
					 :ls_base_icms,
					 :ls_aliquota_icms,
					 :ls_valor_icms_st,
					 :ls_base_icms_st,
					 :ls_aliquota_icms_st,
					 :ls_valor_ipi,
					 :ls_base_ipi,
					 :ls_aliquota_ipi,
					 :ls_valor_pis,
					 :ls_base_pis,
					 :ls_aliquota_pis,
					 :ls_valor_cofins,
					 :ls_base_cofins,
					 :ls_aliquota_cofins,
					 :ls_cd_cst_tributacao,
					 :ls_cd_cst_pis,
					 :ls_cd_cst_cofins,
					 :ls_cd_natureza_operacao,
					 :ls_cd_cst_origem,
					 :ls_valor_mva,
					 :ls_valor_pmc,
					 :ldc_pc_reducao_base_icms
			  from item_nf_compra i
 			 where	i.cd_produto					= :ll_cd_produto and
			  			i.nr_nf						= :ll_nr_nf_origem and
						i.cd_filial						= :ll_cd_filial_origem and
						i.cd_fornecedor				= :ls_cd_fornecedor_origem and
						i.de_especie					= :ls_de_especie_origem and
						i.de_serie					= :ls_de_serie_origem and
						i.cd_natureza_operacao	= :ll_cd_natureza_operacao_origem;
					 
			Choose Case SqlCa.SqlCode
				Case -1
					Sqlca.of_MsgDbError("Erro ao buscar valores no agrupamento para montar o xml de produtos.")
					
					Return False
				End Choose
				
			ldc_diferenca = ldc_valor_unitario_liquido - ldc_valor_unitario_liquido_xml
			
			if Not IsNull(ll_idx_item_xml_nfe) and ll_idx_item_xml_nfe > 0 and &
				(ldc_diferenca > -1 and ldc_diferenca < 1) then
				ldc_valor_unitario_liquido = ldc_valor_unitario_liquido_xml
				ls_vl_desconto					= gf_replace(String((ldc_vl_desconto_xml / ll_qt_faturada) * ll_qt_devolver), ',', '.', 1)
				ls_base_icms					= gf_replace(String((ldc_vl_bc_icms_original / ll_qt_faturada) * ll_qt_devolver), ',', '.', 1)
				ls_valor_icms					= gf_replace(String((ldc_vl_icms_original / ll_qt_faturada) * ll_qt_devolver), ',', '.', 1)
				ls_base_icms_st				= gf_replace(String((ldc_vl_bc_icms_st_original / ll_qt_faturada) * ll_qt_devolver), ',', '.', 1)
				ls_valor_icms_st				= gf_replace(String((ldc_vl_icms_st_original / ll_qt_faturada) * ll_qt_devolver), ',', '.', 1)
				ls_base_ipi						= gf_replace(String((ldc_vl_bc_ipi_original / ll_qt_faturada) * ll_qt_devolver), ',', '.', 1)
				ls_valor_ipi					= gf_replace(String((ldc_vl_ipi_original / ll_qt_faturada) * ll_qt_devolver), ',', '.', 1)
				ls_valor_pis					= gf_replace(String((ldc_vl_pis_original / ll_qt_faturada) * ll_qt_devolver), ',', '.', 1)
				ls_valor_cofins				= gf_replace(String((ldc_vl_cofins_original / ll_qt_faturada) * ll_qt_devolver), ',', '.', 1)
			end if
			
			ls_centro	= '1156'
			
			If ldc_pc_reducao_base_icms <> 100.00 Then
				ldc_pc_reducao_base_icms = 100.00 - ldc_pc_reducao_base_icms
			end if
			
			ls_pc_reducao_base_icms = gf_replace(String(ldc_pc_reducao_base_icms), ',', '.', 1)
			
			SetNull(ldc_pc_reducao_base_icms)
			
			if ldc_valor_unitario_liquido <= 0 then
				ps_log = "Valor unit$$HEX1$$e100$$ENDHEX$$rio do produto " + String(ll_cd_produto) + " est$$HEX1$$e100$$ENDHEX$$ zerado. Favor verificar."
					
				Return False
			end if
		end if
		
		ls_item_op	= ''
		ls_unidade_moeda	= ''
		ls_cod_imposto	= ''
		
		ldc_total_item	= ldc_valor_unitario_liquido * ldc_qt_lote
		
		ls_valor_unitario_liquido	= gf_replace(String(ldc_valor_unitario_liquido), ',', '.', 1)
		
		if not IsNull(ldc_total_item) then idc_vl_total_nf	+= ldc_total_item
		
		if not IsNull(ll_nr_agrupamento) then
			ls_nr_lote	= ls_nr_lote_nf_origem
			ls_qt_lote	= String(ll_qt_devolver)
		end if
				
		select dbo.retorna_um_compra_sap(:ll_cd_produto)
		  into :ls_un_medida
		  from dummy
		using SQLCA;
		
		Choose Case SqlCa.SqlCode
			Case -1
				Sqlca.of_MsgDbError("Erro ao buscar unidade de medida de compra dos produtos.")
				
				Return False
		End Choose
		
		if IsNull(ls_un_medida) or ls_un_medida = '' Then
			ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrada a unidade de medida de compra do produto " + String(ll_cd_produto) + "."
			Return False
		end if
		
		ls_xml += '<itens_nf>'+&
						'<nr_devolucao>'+ps_nr_solicitacao+'</nr_devolucao>'+&
						'<nr_item>'+ls_nr_item+'</nr_item>'+&
						'<cd_produto_sap>'+ls_cd_produto_sap+'</cd_produto_sap>'+&
						'<nr_lote>'+ls_nr_lote+'</nr_lote>'+&
						'<qt_lote>'+ls_qt_lote+'</qt_lote>'+&
						'<dh_fabricacao>'+ls_dh_fabricacao+'</dh_fabricacao>'+&
						'<dh_validade>'+ls_dh_validade+'</dh_validade>'+&
						'<deposito>0002</deposito>'+&
						'<valor_uniario_liquido>'+ls_valor_unitario_liquido+'</valor_uniario_liquido>'+&
						'<item_po>'+ls_item_op+'</item_po>'+&
						'<unidade_medida>'+ls_un_medida+'</unidade_medida>'+&
						'<cod_imposto>'+ls_cod_imposto+'</cod_imposto>'+&
						'<centro>'+ls_centro+'</centro>'+&
						'<valor_icms>'+ls_valor_icms+'</valor_icms>'+&
						'<base_icms>'+ls_base_icms+'</base_icms>'+&
						'<base_red_icms>'+ls_pc_reducao_base_icms+'</base_red_icms>'+&
						'<aliquota_icms>'+ls_aliquota_icms+'</aliquota_icms>'+&
						'<valor_icms_st>'+ls_valor_icms_st+'</valor_icms_st>'+&
						'<base_icms_st>'+ls_base_icms_st+'</base_icms_st>'+&
						'<aliquota_icms_st>'+ls_aliquota_icms_st+'</aliquota_icms_st>'+&
						'<valor_ipi>'+ls_valor_ipi+'</valor_ipi>'+&
						'<base_ipi>'+ls_base_ipi+'</base_ipi>'+&
						'<aliquota_ipi>'+ls_aliquota_ipi+'</aliquota_ipi>'+&
						'<valor_pis>'+ls_valor_pis+'</valor_pis>'+&
						'<base_pis>'+ls_base_pis+'</base_pis>'+&
						'<aliquota_pis>'+ls_aliquota_pis+'</aliquota_pis>'+&
						'<valor_cofins>'+ls_valor_cofins+'</valor_cofins>'+&
						'<base_cofins>'+ls_base_cofins+'</base_cofins>'+&
						'<aliquota_cofins>'+ls_aliquota_cofins+'</aliquota_cofins>'+&
						'<CST_ICMS>'+ls_cd_cst_tributacao+'</CST_ICMS>'+&
						'<CST_IPI></CST_IPI>'+&
						'<CST_PIS>'+ls_cd_cst_pis+'</CST_PIS>'+&
						'<CST_COFINS>'+ls_cd_cst_cofins+'</CST_COFINS>'+&
						'<CFOP>'+ls_cd_natureza_operacao+'</CFOP>'+&
						'<Origem>'+ls_cd_cst_origem+'</Origem>'+&
						'<Desconto_Item>'+ls_vl_desconto+'</Desconto_Item>'+&
						'<MVA>'+ls_valor_mva+'</MVA>'+&
						'<Pauta>'+ls_valor_pmc+'</Pauta>'+&											
						'<Frete></Frete>'+&
						'<Seguro></Seguro>'+&
						'<Despesas></Despesas>'+&
						'<CEAN>' + ls_codigo_barras_nf_compra + '</CEAN>'+&
						'<CEAN_TRIB>' + ls_codigo_barras_nf_compra_trib + '</CEAN_TRIB>'+&
						'</itens_nf>'			
	Next
	
	ls_xml += '</ITEM>'
Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_monta_xml_item_produto', objeto 'uo_ge481_wms_envio_divergencias_nfd'. Erro: "+lo_rte.GetMessage())
	Return False
Finally
	Destroy(lds_envio_diver_detalhe)
End Try

if not IsNull(ls_xml) then ps_xml	= ls_xml + ps_xml
			
return true
end function

public function boolean of_busca_cfop_origem (string as_de_chave_acesso_origem, long al_cd_produto, ref long al_cd_natureza_operacao, ref string as_log);Boolean	lb_sucesso = False

Try
	SELECT
		TOP 1 inc.cd_natureza_operacao_xml 
	INTO
		:al_cd_natureza_operacao
	FROM
		nf_compra nc
	INNER JOIN
		dbo.item_nf_compra inc
		ON nc.cd_filial = inc.cd_filial 
		AND nc.cd_fornecedor = inc.cd_fornecedor 
		AND nc.nr_nf = inc.nr_nf 
		AND nc.de_especie = inc.de_especie 
		AND nc.de_serie = inc.de_serie 
	WHERE
		nc.de_chave_acesso = :as_de_chave_acesso_origem
		AND inc.cd_produto = :al_cd_produto
	USING SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			as_log	= 'Erro ao buscar a CFOP do item na nota fiscal de origem. Objeto: of_busca_cfop_origem.~r~rErro: ' + SQLCA.SQLErrText
			lb_sucesso = False
			Return False
		Case 100
			as_log	= 'CFOP do item na nota fiscal de origem n$$HEX1$$e300$$ENDHEX$$o encontrado. Objeto: of_busca_cfop_origem.'
			lb_sucesso = False
			Return False
		Case 0
			lb_sucesso = True
	End Choose
Catch (RunTimeError RTE)
	as_log	= 'Erro n$$HEX1$$e300$$ENDHEX$$o catalogado. Objeto: of_busca_cfop_origem.' + RTE.GetMessage()
	lb_sucesso = False
	Return False
Finally
	Return lb_sucesso
End Try
end function

on uo_ge481_wms_envio_divergencias_nfd.create
call super::create
end on

on uo_ge481_wms_envio_divergencias_nfd.destroy
call super::destroy
end on

