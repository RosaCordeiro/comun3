HA$PBExportHeader$uo_ge481_registro_info.sru
forward
global type uo_ge481_registro_info from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_registro_info from uo_ge481_subida_generica autoinstantiate
boolean ib_usa_cabecalho = false
end type

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
end prototypes

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_RegInf_SyBase_S4_Request>'

is_Termino_XML	=	'</exp:MT_RegInf_SyBase_S4_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'

is_DS = 'ds_ge481_registro_info'
is_Objeto = this.classname( )
is_nome_arquivo = 'registro_info_xml'
is_Parametro_URL = 'CD_URL_ENVIO_REGISTRO_INFO'
is_Tipo_Log_Exp = 'REGISTRO_INFO'
is_Descricao_Tipo_Log = 'REGISTRO INFO'
is_Nome_Interface = 'REGISTRO_INFO'

return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);string ls_cd_distribuidora, ls_cd_uf, ls_cd_produto_distrib, ls_produto_sap, ls_cd_fornecedor_sap, ls_cd_unidade, ls_filial_sap
long ll_cd_produto
decimal lvl_preco

ls_cd_distribuidora = pds_dados.object.cd_distribuidora[pl_linha]
ll_cd_produto = long(pds_dados.object.cd_produto[pl_linha])
ls_cd_uf = pds_dados.object.cd_uf[pl_linha]

Select dp.cd_produto_distribuidora, pg.cd_produto_sap, f.cd_fornecedor_sap, Coalesce(dp.vl_preco_novo,dp.vl_preco_atual), pg.cd_unidade_medida_compra
into :ls_cd_produto_distrib, :ls_produto_sap, :ls_cd_fornecedor_sap, :lvl_preco, :ls_cd_unidade
from distribuidora_produto dp
    inner join produto_geral pg on (pg.cd_produto = dp.cd_produto)
    inner join fornecedor f on (f.cd_fornecedor = dp.cd_distribuidora)
where dp.cd_distribuidora = :ls_cd_distribuidora
and dp.cd_produto = :ll_cd_produto
and dp.cd_unidade_federacao = :ls_cd_uf;

if sqlca.sqlcode = -1 then 
	ps_log = 'Problemas ao consultar a tabela "distribuidora_produto": ' + sqlca.sqlerrtext
	return false
end if

//N$$HEX1$$e300$$ENDHEX$$o existir codigo sap do produto ou fornecedor, n$$HEX1$$e300$$ENDHEX$$o envia o registro.
if isnull(ls_produto_sap) or ls_produto_sap = '' or ls_cd_fornecedor_sap = '' or isnull(ls_cd_fornecedor_sap) Then
	return true
end if

Select cd_chave_sap
into :ls_filial_sap
from integracao_sap
where cd_tabela = 'FILIAL_REFERENCIA'
and cd_chave_legado = :ls_cd_uf;

if sqlca.sqlcode = -1 then 
	ps_log = 'Problemas ao consultar a tabela "integracao_sap": ' + sqlca.sqlerrtext
	return false
end if

if ls_filial_sap = '' or isnull(ls_filial_sap) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar uma filial refer$$HEX1$$ea00$$ENDHEX$$ncia para o estado ' + ls_cd_uf + '.'
	return false
end if

ps_xml += '<dados>'
ps_xml += '<CD_PRODUTO_SAP>' + ls_produto_sap + '</CD_PRODUTO_SAP>'
ps_xml += '<CD_FORNECEDOR_SAP>' + ls_cd_fornecedor_sap + '</CD_FORNECEDOR_SAP>'
ps_xml += '<CD_FILIAL_SAP_REF>' + ls_filial_sap + '</CD_FILIAL_SAP_REF>'
ps_xml += '<CD_UNIDADE_MEDIDA_COMPRA>' + ls_cd_unidade + '</CD_UNIDADE_MEDIDA_COMPRA>'
ps_xml += '<CD_PRODUTO_FORNECEDOR>' + ls_cd_produto_distrib + '</CD_PRODUTO_FORNECEDOR>'
ps_xml += '<CD_GRUPO_COMPRADOR>023</CD_GRUPO_COMPRADOR>'
ps_xml += '<NR_DIAS_ENTREGA>1</NR_DIAS_ENTREGA>'
ps_xml += '<CD_IMPOSTO_SAP>ZZ</CD_IMPOSTO_SAP>'
ps_xml += '<VL_PRECO_BRUTO>' + gf_Valor_Com_Ponto(lvl_preco) + '</VL_PRECO_BRUTO>'
ps_xml += '</dados>'

return true
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere("id_status_integracao = 'C' " )
end if

return true
end function

on uo_ge481_registro_info.create
call super::create
end on

on uo_ge481_registro_info.destroy
call super::destroy
end on

