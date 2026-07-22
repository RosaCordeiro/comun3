HA$PBExportHeader$uo_ge481_wms_cancelamento_nfd.sru
forward
global type uo_ge481_wms_cancelamento_nfd from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_wms_cancelamento_nfd from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long il_Integracao
Long il_cd_filial
Long il_nr_nf
String is_de_especie
String is_de_serie
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
						'<exp:MT_DEVOLUCAO_ESTORNO_OUT>'

is_Termino_XML	=	'</exp:MT_DEVOLUCAO_ESTORNO_OUT>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_wms_cancelamento_nfd'
is_Objeto = this.classname( )
is_nome_arquivo = 'wms_cancelamento_nfd'
is_Parametro_URL = 'CD_URL_WMS_CANCELAMENTO_NFD'
is_Tipo_Log_Exp = 'WMS_CANCELAMENTO_NFD'
is_Descricao_Tipo_Log = 'WMS_CANCELAMENTO_NFD'
is_Nome_Interface = 'WMS_CANCELAMENTO_NFD'

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
string ls_nr_documento
string ls_ano_documento
string ls_data_solic_can
string ls_nr_solicitacao

ls_nr_solicitacao = pds_dados.GetItemString(pl_linha,"nr_solicitacao")
ls_data_solic_can = String(pds_dados.GetItemDateTime(pl_linha,"data_solic_can"),"YYYYMMDD")
ls_ano_documento = String(pds_dados.GetItemNumber(pl_linha,"ano_documento"))
ls_nr_documento = pds_dados.GetItemString(pl_linha,"nr_documento")

il_cd_filial = pds_dados.GetItemNumber(pl_linha,"cd_filial")
il_nr_nf = pds_dados.GetItemNumber(pl_linha,"nr_nf")
is_de_especie = pds_dados.GetItemString(pl_linha,"de_especie")
is_de_serie = pds_dados.GetItemString(pl_linha,"de_serie")

il_Integracao = Long(pds_dados.GetItemDecimal(pl_linha,"nr_atualizacao"))

if ls_nr_solicitacao = '' or isnull(ls_nr_solicitacao) Then
	ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o de envio {nr_solicitacao} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

if ls_data_solic_can = '' or isnull(ls_data_solic_can) Then
	ps_log = 'Data da solicita$$HEX2$$e700e300$$ENDHEX$$o de cancelamento {data_solic_can} n$$HEX1$$e300$$ENDHEX$$o informada.'
	return false
end if

if ls_ano_documento = '' or isnull(ls_ano_documento) Then
	ps_log = 'Ano do documento {ano_documento} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

if ls_nr_documento = '' or isnull(ls_nr_documento) Then
	ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do documento {nr_documento} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

ls_nr_solicitacao = Right('0000000000000' + ls_nr_solicitacao, 13) 

ps_xml += 	'<NR_SOLICITACAO>'+ls_nr_solicitacao+'</NR_SOLICITACAO>'+&
				'<NR_DOCUMENTO>'+ls_nr_documento+'</NR_DOCUMENTO>'+&
				'<ANO_DOCUMENTO>'+ls_ano_documento+'</ANO_DOCUMENTO>'+&
				'<DATA_SOLIC_CANC>'+ls_data_solic_can+'</DATA_SOLIC_CANC>'

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
string ls_log_estorno

ll_contador = 1

ls_log_estorno = Trim(of_busca_valor(as_xml, '<LOG_MIGO_CANC>', ref ll_contador))

ll_contador = 1

ls_log_estorno += " " + Trim(of_busca_valor(as_xml, '<LOG_MIRO_CANC>', ref ll_contador)) 

If Pos(ls_log_estorno,"n$$HEX1$$e300$$ENDHEX$$o existe") > 0 or &
 	Pos(ls_log_estorno,"n$$HEX1$$e300$$ENDHEX$$o criada") > 0 Then
		
	this.of_atualiza_processado( il_Integracao, 'E', "Devolu$$HEX2$$e700e300$$ENDHEX$$o Estorno NFD n$$HEX1$$e300$$ENDHEX$$o realizado" + "{ Log: " +ls_log_estorno + ' }', ref as_log)	
End If

Return True
end function

on uo_ge481_wms_cancelamento_nfd.create
call super::create
end on

on uo_ge481_wms_cancelamento_nfd.destroy
call super::destroy
end on

