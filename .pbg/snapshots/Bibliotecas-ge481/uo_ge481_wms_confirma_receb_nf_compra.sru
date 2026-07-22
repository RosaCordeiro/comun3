HA$PBExportHeader$uo_ge481_wms_confirma_receb_nf_compra.sru
forward
global type uo_ge481_wms_confirma_receb_nf_compra from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_wms_confirma_receb_nf_compra from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long	il_nr_atualizacao
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
end prototypes

public function boolean _of_parametros ();//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
   						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_CONFERENCIA_OUT>'+&
						'<!--Zero or more repetitions:-->'


is_Termino_XML	=	'</exp:MT_CONFERENCIA_OUT>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_envio_confirma_receb_nf_compra'

is_Objeto = this.classname( )

is_nome_arquivo = 'envio_confirma_receb_nf_compra_xml'
is_Parametro_URL = 'CD_URL_ENVIO_CONFIRMA_RECEB_NF_COMPRA'

// Utilizado na lf_ge470_log
is_Tipo_Log_Exp = 'WMR'
is_Descricao_Tipo_Log = 'WMS - RECEBIMENTO ENVIO CONFER$$HEX1$$ca00$$ENDHEX$$NCIA'

is_Nome_Interface = 'ENVIO_CONFIRMA_RECEB_NF_COMPRA'

// Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 1)
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 2)
else
	pds_dados.of_appendwhere("id_status_integracao = 'C' ", 1 )
	pds_dados.of_appendwhere("id_status_integracao = 'C' ", 2 )
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
Boolean	lb_valida_teste_integrado
String 	ls_fornecedor
String 	ls_chave_acesso
String 	ls_nota_fiscal
String	ls_dt_conferencia


ls_fornecedor 		= pds_dados.GetItemString(pl_linha,"fornecedor")
ls_chave_acesso 	= pds_dados.GetItemString(pl_linha,"chave_acesso")
ls_nota_fiscal 	= String(pds_dados.GetItemNumber(pl_linha,"nota_fiscal"))
ls_dt_conferencia = String(pds_dados.GetItemDateTime(pl_linha,"dt_conferencia"),"YYYYMMDD")
il_nr_atualizacao	= pds_dados.GetItemNumber(pl_linha,"nr_atualizacao")

if ls_chave_acesso = '' or isnull(ls_chave_acesso) Then
	ps_log = 'Chave de acesso da NF ' + ls_nota_fiscal + ' n$$HEX1$$e300$$ENDHEX$$o informada.'
	return false
end if

if isnull(ls_fornecedor) Then
	ls_fornecedor = ''
end if

if ls_nota_fiscal = '' or isnull(ls_nota_fiscal) Then
	ps_log = 'Chave de acesso ' + ls_chave_acesso + ' sem n$$HEX1$$fa00$$ENDHEX$$mero de nota fiscal.'
	return false
end if

lb_valida_teste_integrado = gf_valida_teste_integrado()

if lb_valida_teste_integrado then
	select de_chave_acesso_alterada
	  into :ls_chave_acesso
	  from recebimento_sap
	 where de_chave_acesso	= :ls_chave_acesso;
	 
	Choose Case SQLCA.SQLCode
		Case -1
			ps_log = 'Erro ao buscar chave de acesso original.' + SQLCA.SQLErrText
			return false
	End Choose
end if

ps_xml += '<DADOS>'
ps_xml += '<CHAVE_DE_ACESSO>' + ls_chave_acesso + '</CHAVE_DE_ACESSO>'
ps_xml += '<FORNECEDOR>' + ls_fornecedor + '</FORNECEDOR>'
ps_xml += '<NOTA_FISCAL>' + ls_nota_fiscal + '</NOTA_FISCAL>'
ps_xml += '<DT_CONFERENCIA>' + ls_dt_conferencia + '</DT_CONFERENCIA>'
ps_xml += '<NF_REJEITADA></NF_REJEITADA>'
ps_xml += '</DADOS>'

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
string ls_msg
	
ls_msg = of_busca_valor(as_xml, '<msg>', ref ll_contador)

if upper(ls_msg) <> upper('Inserido com sucesso') Then
	this.of_atualiza_processado( il_nr_atualizacao, 'E', ls_msg, ref as_log)
end if

return True
end function

on uo_ge481_wms_confirma_receb_nf_compra.create
call super::create
end on

on uo_ge481_wms_confirma_receb_nf_compra.destroy
call super::destroy
end on

