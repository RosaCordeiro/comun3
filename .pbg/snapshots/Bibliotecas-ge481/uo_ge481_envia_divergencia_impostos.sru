HA$PBExportHeader$uo_ge481_envia_divergencia_impostos.sru
forward
global type uo_ge481_envia_divergencia_impostos from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_envia_divergencia_impostos from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long		il_nr_atualizacao
Long		il_cd_produto
String 	is_cd_unidade_federacao
String 	is_cd_distribuidora
end variables

forward prototypes
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_parametros ()
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log)
protected function boolean of_valida_situacao (datastore pds_itens, long pl_linha, ref long pl_situacao_pendente, ref string ps_log)
end prototypes

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);Long		ll_for
String	ls_sql

dc_uo_ds_base lds_campos_divergentes


if pl_nr_atualizacao > 0 Then
	pds_dados.of_AppendWhere('nr_atualizacao = ' + String(pl_nr_atualizacao))
end if

lds_campos_divergentes = create dc_uo_ds_base

If Not lds_campos_divergentes.of_ChangeDataObject('ds_ge481_sel_campos_divergentes', False) Then
	ps_log = "Erro ao alterar a DS 'ds_ge481_sel_campos_divergentes'."
	Return False
End If

ls_sql = "("

lds_campos_divergentes.Retrieve()

for ll_for = 1 to lds_campos_divergentes.rowcount()
	ls_sql += +lds_campos_divergentes.GetItemString(ll_for, 'nm_campo_clamed') + " <> "+lds_campos_divergentes.GetItemString(ll_for, 'nm_campo_distrib') + " or "
next

ls_sql = left(ls_sql, len(ls_sql) - 3)

ls_sql += ")"

pds_dados.of_AppendWhere(ls_sql)

return true
end function

public function boolean _of_parametros ();//override
is_inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:syn="http://Divergencia_Pescador./SyncSOAP2Proxy">'+&
   						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<syn:MT_Request>'
						
is_termino_XML	=	'</syn:MT_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'

ib_usa_cabecalho = False
is_ds = 'ds_ge481_envia_divergencia_impostos'
is_objeto = this.ClassName()
is_nome_arquivo = 'envia_divergencia_impostos'
is_parametro_url = 'CD_URL_ENVIA_DIVERGENCIA_IMPOSTOS'
is_tipo_log_exp = 'ENVIA_DIVERGENCIA_IMPOSTOS'
is_descricao_tipo_log = 'ENVIA_DIVERGENCIA_IMPOSTOS'
is_nome_interface = 'ENVIA_DIVERGENCIA_IMPOSTOS'

// Subir um documento por vez
ii_contador_xml = 500

return True
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);Long 		ll_contador = 1
String 	ls_status


//Aguardar para ver a mensagem real do retorno
ls_status = of_busca_valor(as_xml, '<status>', ref ll_contador)

if ls_status <> 'Integrado com sucesso' then
	ll_contador = 1
		
	this.of_atualiza_processado( il_nr_atualizacao, 'E', ls_status, ref as_log)
end if

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);DateTime	ldt_dh_atualizacao_dist
Dec		ldc_vl_preco, ldc_vl_desconto, ldc_pc_desconto
String	ls_cd_fornecedor_sap, ls_cd_produto_sap, ls_cd_grupo, ls_de_produto, ls_nm_razao_social, &
			ls_id_icms_st, ls_id_situacao, ls_cd_cest, ls_cd_origem_produto, ls_cd_cst, ls_cd_origem_dist, &
			ls_id_situacao_dist, ls_cd_cst_dist, ls_cd_produto_dist, &
			ls_cd_fornecedor_sap_usual, ls_ncm, ls_pc_mva, ls_ncm_dist, ls_cd_cest_dist, ls_vl_preco, &
			ls_vl_desconto, ls_pc_icms_st, ls_vl_pmc, ls_pc_icms_st_dist, ls_pc_mva_dist, ls_vl_pmc_dist


ls_cd_produto_sap				= pds_dados.Object.cd_produto_sap[pl_linha]
ls_cd_fornecedor_sap			= pds_dados.Object.cd_fornecedor_sap[pl_linha]
ls_cd_produto_dist			= pds_dados.Object.cd_produto_distribuidora[pl_linha]
ls_cd_grupo						= pds_dados.Object.cd_grupo[pl_linha]
ls_de_produto					= gf_retira_caracteres_especiais_xml(pds_dados.Object.de_produto[pl_linha])
ls_nm_razao_social			= gf_retira_caracteres_especiais_xml(pds_dados.Object.nm_razao_social[pl_linha])
ls_cd_fornecedor_sap_usual	= pds_dados.Object.cd_fornecedor_sap_usual[pl_linha]
ldc_vl_preco					= pds_dados.Object.vl_preco[pl_linha]
ldc_pc_desconto				= pds_dados.Object.pc_desconto[pl_linha]
ls_id_icms_st					= pds_dados.Object.id_icms_st[pl_linha]
ls_ncm							= String(pds_dados.Object.ncm[pl_linha])
ls_id_situacao					= pds_dados.Object.id_situacao[pl_linha]
ls_cd_cest						= pds_dados.Object.cd_cest[pl_linha]
ls_cd_origem_produto			= pds_dados.Object.cd_origem_produto[pl_linha]
ls_cd_cst						= pds_dados.Object.cd_cst[pl_linha]
ls_pc_icms_st					= gf_valor_com_ponto(pds_dados.Object.pc_icms_st[pl_linha])
ls_pc_mva						= gf_valor_com_ponto(pds_dados.Object.pc_mva[pl_linha])
ls_vl_pmc						= gf_valor_com_ponto(pds_dados.Object.vl_pmc[pl_linha])
ldt_dh_atualizacao_dist		= pds_dados.Object.dh_atualizacao_dist[pl_linha]

ls_vl_preco	= gf_valor_com_ponto(ldc_vl_preco)

ldc_vl_desconto	= ldc_vl_preco * (ldc_pc_desconto / 100.00)
ls_vl_desconto 	= gf_valor_com_ponto(ldc_vl_desconto)

ls_ncm_dist				= String(pds_dados.Object.ncm_dist[pl_linha])
ls_id_situacao_dist	= pds_dados.Object.id_situacao_dist[pl_linha]
ls_cd_cest_dist		= String(pds_dados.Object.cd_cest_dist[pl_linha])
ls_cd_origem_dist		= pds_dados.Object.cd_origem_dist[pl_linha]
ls_cd_cst_dist			= pds_dados.Object.cd_cst_dist[pl_linha]
ls_pc_icms_st_dist	= gf_valor_com_ponto(pds_dados.Object.pc_icms_st_dist[pl_linha])
ls_pc_mva_dist			= gf_valor_com_ponto(pds_dados.Object.pc_mva_dist[pl_linha])
ls_vl_pmc_dist			= gf_valor_com_ponto(pds_dados.Object.vl_pmc_dist[pl_linha])

if IsNull(ls_cd_cest) then ls_cd_cest = ''
if IsNull(ls_cd_cst) then ls_cd_cst = ''
if IsNull(ls_cd_cest_dist) then ls_cd_cest_dist = ''
if IsNull(ls_pc_mva_dist) then ls_pc_mva_dist = ''
if IsNull(ls_vl_pmc_dist) then ls_vl_pmc_dist = ''
if IsNull(ls_ncm_dist) then ls_ncm_dist = ''
if IsNull(ls_cd_cst_dist) then ls_cd_cst_dist = ''
if IsNull(ls_cd_origem_dist) then ls_cd_origem_dist = ''

if IsNull(ls_cd_produto_sap) then return true
if IsNull(ls_cd_fornecedor_sap) then return true

ps_xml += '<Tabela_Dados>'
ps_xml += '<cd_material>'+ls_cd_produto_sap+'</cd_material>'
ps_xml += '<cd_fornecedor>'+ls_cd_fornecedor_sap+'</cd_fornecedor>'
ps_xml += '<cd_estado>'+is_cd_unidade_federacao+'</cd_estado>'
ps_xml += '<cd_grupo>'+ls_cd_grupo+'</cd_grupo>'
ps_xml += '<desc_material>'+ls_de_produto+'</desc_material>'
ps_xml += '<desc_fornecedor>'+ls_nm_razao_social+'</desc_fornecedor>'
ps_xml += '<vl_preco>'+ls_vl_preco+'</vl_preco>'
ps_xml += '<vl_desconto>'+ls_vl_desconto+'</vl_desconto>'
ps_xml += '<st>'+ls_id_icms_st+'</st>'
ps_xml += '<ncm>'+ls_ncm+'</ncm>'
ps_xml += '<situacao_m>'+ls_id_situacao+'</situacao_m>'
ps_xml += '<cest>'+ls_cd_cest+'</cest>'
ps_xml += '<origem>'+ls_cd_origem_produto+'</origem>'
ps_xml += '<cst>'+ls_cd_cst+'</cst>'
ps_xml += '<st_percentual>'+ls_pc_icms_st+'</st_percentual>'
ps_xml += '<mva>'+ls_pc_mva+'</mva>'
ps_xml += '<pmc>'+ls_vl_pmc+'</pmc>'
ps_xml += '<ncm_d>'+ls_ncm_dist+'</ncm_d>'
ps_xml += '<situacao_d>'+ls_id_situacao_dist+'</situacao_d>'
ps_xml += '<cest_d>'+ls_cd_cest_dist+'</cest_d>'
ps_xml += '<origem_d>'+ls_cd_origem_dist+'</origem_d>'
ps_xml += '<cst_d>'+ls_cd_cst_dist+'</cst_d>'
ps_xml += '<std_percentual>'+ls_pc_icms_st_dist+'</std_percentual>'
ps_xml += '<mva_d>'+ls_pc_mva_dist+'</mva_d>'
ps_xml += '<pmc_d>'+ls_vl_pmc_dist+'</pmc_d>'
ps_xml += '<fornecedor_regular>'+ls_cd_fornecedor_sap_usual+'</fornecedor_regular>'
ps_xml += '<material_distrib>'+ls_cd_produto_dist+'</material_distrib>'
ps_xml += '<acoes>'+''+'</acoes>'
ps_xml += '<status_acoes>'+''+'</status_acoes>'
ps_xml += '<data>'+String(ldt_dh_atualizacao_dist, "YYYYMMDD")+'</data>'
ps_xml += '<hora>'+String(ldt_dh_atualizacao_dist, "hhmmss")+'</hora>'
ps_xml += '</Tabela_Dados>'

return true
end function

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log);is_cd_unidade_federacao	= pds_itens.Object.cd_unidade_federacao[pl_linha]
is_cd_distribuidora		= pds_itens.Object.cd_fornecedor[pl_linha]
il_cd_produto				= pds_itens.Object.cd_produto[pl_linha]

update distribuidora_produto
	set dh_exportacao_divergencia_sap	= GetDate()
 where cd_produto					= :il_cd_produto
 	and cd_distribuidora 		= :is_cd_distribuidora
	and cd_unidade_federacao 	= :is_cd_unidade_federacao;
	
Choose Case SQLCA.SQLCode
	Case -1
		as_log	= "Erro ao atualizar o campo dh_exportacao_divergencia_sap da tabela distribuidora_produto." + SQLCA.SQLErrText
		return False
End Choose

return true
end function

protected function boolean of_valida_situacao (datastore pds_itens, long pl_linha, ref long pl_situacao_pendente, ref string ps_log);pl_situacao_pendente = 1

return true
end function

on uo_ge481_envia_divergencia_impostos.create
call super::create
end on

on uo_ge481_envia_divergencia_impostos.destroy
call super::destroy
end on

