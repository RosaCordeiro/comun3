HA$PBExportHeader$uo_ge481_wms_ordem_venda_estorno.sru
forward
global type uo_ge481_wms_ordem_venda_estorno from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_wms_ordem_venda_estorno from uo_ge481_subida_generica autoinstantiate
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
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_ESTORNO_NF_REQ>'

is_Termino_XML	=	'</imp:MT_ESTORNO_NF_REQ>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_wms_ordem_venda_estorno2'
is_Objeto = this.classname( )
is_nome_arquivo = 'wms_ordem_venda_estorno'
is_Parametro_URL = 'CD_URL_WMS_ORDEM_VENDA_ESTORNO'
is_Tipo_Log_Exp = 'WMS_ORDEM_VENDA_ESTORNO'
is_Descricao_Tipo_Log = 'WMS_ORDEM_VENDA_ESTORNO'
is_Nome_Interface = 'WMS_ORDEM_VENDA_ESTORNO'

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
string ls_de_chave_acesso

ls_de_chave_acesso = pds_dados.GetItemString(pl_linha,"de_chave_acesso")

il_cd_filial = pds_dados.GetItemNumber(pl_linha,"cd_filial")
il_nr_nf = pds_dados.GetItemNumber(pl_linha,"nr_nf")
is_de_especie = pds_dados.GetItemString(pl_linha,"de_especie")
is_de_serie = pds_dados.GetItemString(pl_linha,"de_serie")

il_Integracao = Long(pds_dados.GetItemDecimal(pl_linha,"nr_atualizacao"))

if ls_de_chave_acesso = '' or isnull(ls_de_chave_acesso) Then
	ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da Chave de acesso da NF-e {de_chave_acesso} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

ps_xml += 	'<CHAVE>'+ls_de_chave_acesso+'</CHAVE>'

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
string ls_status

ll_contador = 1
ls_status = Trim(of_busca_valor(as_xml, '<STATUS>', ref ll_contador))

If Lower(ls_status) <> "estorno realizado com sucesso" Then
		
	this.of_atualiza_processado( il_Integracao, 'E', "Devolu$$HEX2$$e700e300$$ENDHEX$$o Estorno NF transfer$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o realizado" + "{ Log: " +ls_status + ' }', ref as_log)
	
Else
	
	Update log_exportacao_sap 
	Set id_status_integracao = 'I'
	Where nr_atualizacao = :il_Integracao
	Using SQLCA;
	
	Choose Case SqlCa.SqlCode
		Case -1 
			as_log = "Erro ao atualizar o status de integra$$HEX2$$e700e300$$ENDHEX$$o para (I)ntegrado '_of_processa_retorno_xml': " + SqlCa.SqlerrText
			Return False
		Case 100
			as_log = "Erro ao atualizar o status de integra$$HEX2$$e700e300$$ENDHEX$$o para (I)ntegrado. Integra$$HEX2$$e700e300$$ENDHEX$$o (log_exportacao_sap) n$$HEX1$$e300$$ENDHEX$$o encontrada na base de dados  '_of_processa_retorno_xml'" 
			Return False	
	End Choose
	
	Update nf_transferencia 
	Set dh_cancelamento = getdate(), nr_matricula_cancelamento = '14330'
	Where cd_filial_origem = :il_cd_filial
		and nr_nf = :il_nr_nf
		and de_especie = :is_de_especie
		and de_serie = :is_de_serie
	Using SQLCA;
	
	Choose Case SqlCa.SqlCode
		Case -1 
			as_log = "Erro ao atualizar a data de cancelamento da Devolu$$HEX2$$e700e300$$ENDHEX$$o Estorno NF transfer$$HEX1$$ea00$$ENDHEX$$ncia '_of_processa_retorno_xml': " + SqlCa.SqlerrText
			Return False
		Case 100
			as_log = "Erro ao atualizar a data de cancelamento da Devolu$$HEX2$$e700e300$$ENDHEX$$o Estorno NF transfer$$HEX1$$ea00$$ENDHEX$$ncia. NF-e n$$HEX1$$e300$$ENDHEX$$o encontrada na base de dados  '_of_processa_retorno_xml'" 
			Return False	
	End Choose
	
End If

Return True
end function

on uo_ge481_wms_ordem_venda_estorno.create
call super::create
end on

on uo_ge481_wms_ordem_venda_estorno.destroy
call super::destroy
end on

