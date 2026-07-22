HA$PBExportHeader$uo_ge481_wms_estorno_recebimento.sru
forward
global type uo_ge481_wms_estorno_recebimento from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_wms_estorno_recebimento from uo_ge481_subida_generica
end type
global uo_ge481_wms_estorno_recebimento uo_ge481_wms_estorno_recebimento

type variables
Long	il_nr_atualizacao
end variables

forward prototypes
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_parametros ()
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log)
end prototypes

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere("id_status_integracao = 'C' " )
end if
//
return true
end function

public function boolean _of_parametros ();//override
is_inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
   						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_CONFERENCIA_OUT>'


is_termino_XML	=	'</exp:MT_CONFERENCIA_OUT>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_ds = 'ds_ge481_estorno_recebimento'
is_objeto = this.ClassName()
is_nome_arquivo = 'estorno_recebimento'
is_parametro_url = 'CD_URL_WMS_RECEBIMENTO_ESTORNO'
is_tipo_log_exp = 'ESTORNO_RECEBIMENTO'
is_descricao_tipo_log = 'ESTORNO_RECEBIMENTO'
is_nome_interface = 'ESTORNO_RECEBIMENTO'

// Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);Long 		ll_contador = 1
String 	ls_status


//Aguardar para ver a mensagem real do retorno
ls_status = of_busca_valor(as_xml, '<msg>', ref ll_contador)

if ls_status <> 'Inserido com sucesso' then
	ll_contador = 1
		
	this.of_atualiza_processado( il_nr_atualizacao, 'E', ls_status, ref as_log)
else
	if Not this.of_atualiza_processado( il_nr_atualizacao, 'S', '', ref as_log) then return false
end if

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);DateTime	ldh_documento
Long		ll_nr_nf
String	ls_cd_chave_interface, ls_cd_fornecedor_sap


ls_cd_chave_interface	= pds_dados.Object.cd_chave_interface[pl_linha]
ls_cd_fornecedor_sap		= pds_dados.Object.cd_fornecedor_sap[pl_linha]
ll_nr_nf						= pds_dados.Object.nr_nf[pl_linha]
ldh_documento				= pds_dados.Object.dh_documento[pl_linha]
il_nr_atualizacao			= pds_dados.Object.nr_atualizacao[pl_linha]
		
ps_xml += '<DADOS>'
ps_xml += '<CHAVE_DE_ACESSO>' +ls_cd_chave_interface + '</CHAVE_DE_ACESSO>'
ps_xml += '<FORNECEDOR>' + ls_cd_fornecedor_sap + '</FORNECEDOR>'
ps_xml += '<NOTA_FISCAL>' + String(ll_nr_nf) + '</NOTA_FISCAL>'
ps_xml += '<DT_CONFERENCIA>' + String(ldh_documento, 'yyyymmdd') + '</DT_CONFERENCIA>'
ps_xml += '<NF_REJEITADA>' + 'X' + '</NF_REJEITADA>'
ps_xml += '</DADOS>'
			
return true
end function

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log);long ll_nr_atualizacao
String ls_status, ls_msg


if pl_nr_atualizacao = 0 or isnull(pl_nr_atualizacao) Then
	ll_nr_atualizacao = pds_itens.object.nr_atualizacao[pl_linha]
else
	ll_nr_atualizacao = pl_nr_atualizacao
end if

if ps_status = 'E' Then
	ls_status = 'E'
	ls_msg = as_mensagem
else
	ls_status = 'P'
	setnull(ls_msg)
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
			
if sqlca.SqlCode = -1 Then
	as_log += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o dos campos de exportacao na tabela 'pedido_distribuidora', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_processado	': " + SqlCa.SqlerrText
	return false
end if

return true
end function

on uo_ge481_wms_estorno_recebimento.create
call super::create
end on

on uo_ge481_wms_estorno_recebimento.destroy
call super::destroy
end on

