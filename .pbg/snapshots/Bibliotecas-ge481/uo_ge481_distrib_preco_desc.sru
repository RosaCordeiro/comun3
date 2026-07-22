HA$PBExportHeader$uo_ge481_distrib_preco_desc.sru
forward
global type uo_ge481_distrib_preco_desc from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_distrib_preco_desc from uo_ge481_subida_generica autoinstantiate
boolean ib_usa_cabecalho = false
end type

forward prototypes
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_parametros ()
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
end prototypes

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);decimal ldc_vl_preco, ldc_desconto, ldc_repasse
long ll_cd_produto, ll_nr_atualizacao
string ls_cd_produto_sap, ls_cd_fornecedor, ls_cd_uf, ls_fornecedor_sap, ls_cd_unidade

ls_cd_fornecedor = pds_dados.object.cd_fornecedor[pl_linha]
ls_cd_uf = pds_dados.object.cd_uf[pl_linha]
ll_cd_produto = pds_dados.object.cd_produto[pl_linha]
ll_nr_atualizacao = pds_dados.object.nr_atualizacao[pl_linha]
ls_fornecedor_sap = pds_dados.object.cd_fornecedor_sap[pl_linha]
ls_cd_produto_sap = pds_dados.object.cd_produto_sap[pl_linha]

ldc_vl_preco = pds_dados.object.vl_preco_atual[pl_linha]
ldc_desconto = pds_dados.object.pc_desconto_atual[pl_linha]
ldc_repasse = pds_dados.object.pc_repasse_icms[pl_linha]
ls_cd_unidade = pds_dados.object.cd_unidade_medida_compra[pl_linha]

if isnull(ldc_vl_preco) Then ldc_vl_preco = 0
if isnull(ldc_desconto) Then ldc_desconto = 0
if isnull(ldc_repasse) Then ldc_repasse = 0

ps_xml += '<dados>'
ps_xml += '<cd_fornecedor>' + ls_fornecedor_sap + '</cd_fornecedor>'
ps_xml += '<cd_material>' + ls_cd_produto_sap + '</cd_material>'
ps_xml += '<cd_regiao>' + ls_cd_uf + '</cd_regiao>'
ps_xml += '<cd_unidade>' + ls_cd_unidade + '</cd_unidade>'
ps_xml += '<cd_pb00>' + gf_Valor_Com_Ponto(ldc_vl_preco) + '</cd_pb00>'
ps_xml += '<cd_ra00>' + gf_Valor_Com_Ponto(ldc_desconto) + '</cd_ra00>'
ps_xml += '<cd_r000>' + gf_Valor_Com_Ponto(ldc_repasse) + '</cd_r000>'
ps_xml += '<nr_doc_externo>' + string(ll_nr_atualizacao) + '</nr_doc_externo>'
ps_xml += '</dados>'

return true
end function

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_RegistroCondicoes_Request>'


is_Termino_XML	=	'</exp:MT_RegistroCondicoes_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'

is_DS = 'ds_ge481_distrib_preco_desc'
is_Objeto = 'uo_ge481_distrib_preco_desc'
is_nome_arquivo = 'preco_desc_xml'
is_Parametro_URL = 'CD_URL_DISTRIB_PRECOS_DESCONTOS'
is_Tipo_Log_Exp = 'DIS'
is_Descricao_Tipo_Log = 'PRE$$HEX1$$c700$$ENDHEX$$O/DESCONTO DISTRIBUIDORA'
is_Nome_Interface = 'DISTRIB_PRECO_DESC'

return True
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador=0
string ls_nr_doc, ls_status, ls_condicao, ls_nr_doc_ant

ll_contador = 1

DO 
	
	ls_nr_doc = of_busca_valor(as_xml, '<nr_doc_externo>', ref ll_contador)
	
	if ls_nr_doc = '' or isnull(ls_nr_doc) Then
		Exit
	end if
	
	ls_condicao = of_busca_valor(as_xml, '<condicao>', ref ll_contador)
	
	ls_status = of_busca_valor(as_xml, '<status>', ref ll_contador)
	
	if upper(ls_status) <> 'INTEGRADO COM SUCESSO!' Then
		
		this.of_atualiza_processado( long(ls_nr_doc), 'E', ls_status, ref as_log)
		
	end if
	
Loop While ll_contador > 0

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);//Filtra a datastore para trazer um registro espec$$HEX1$$ed00$$ENDHEX$$fico.

string ls_teste

if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere_subquery( 'nr_atualizacao = ' + String(pl_nr_atualizacao), 2 )
else
	pds_dados.of_appendwhere_subquery( "id_status_integracao = 'C' " , 2 )
end if

ls_teste = pds_dados.getsqlselect()

return true
end function

on uo_ge481_distrib_preco_desc.create
call super::create
end on

on uo_ge481_distrib_preco_desc.destroy
call super::destroy
end on

