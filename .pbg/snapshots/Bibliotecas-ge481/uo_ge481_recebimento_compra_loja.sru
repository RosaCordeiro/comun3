HA$PBExportHeader$uo_ge481_recebimento_compra_loja.sru
forward
global type uo_ge481_recebimento_compra_loja from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_recebimento_compra_loja from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long il_Integracao
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
						'<imp:MT_BIP>'

is_Termino_XML	=	'</imp:MT_BIP>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_recebimento_compra_loja'
is_Objeto = this.classname( )
is_nome_arquivo = 'recebimento_compra_loja'
is_Parametro_URL = 'CD_URL_RECEBIMENTO_COMPRA_LOJA'
is_Tipo_Log_Exp = 'RECEBIMENTO_COMPRA_LOJA'
is_Descricao_Tipo_Log = 'RECEBIMENTO_COMPRA_LOJA'
is_Nome_Interface = 'RECEBIMENTO_COMPRA_LOJA'

//Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('l.nr_atualizacao = ' + String(pl_nr_atualizacao), 1)
	pds_dados.of_appendwhere('l.nr_atualizacao = ' + String(pl_nr_atualizacao), 2)
else
	pds_dados.of_appendwhere("l.id_status_integracao = 'C' ", 1 )
	pds_dados.of_appendwhere("l.id_status_integracao = 'C' ", 2 )
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
String ls_cd_centro
String ls_descricao_centro
String ls_cd_fornecedor_sap
String ls_nm_forncedor
String ls_nr_nf
String ls_criadopor
String ls_dtaEmissaonf
String ls_datarecebimento
String ls_horarecebimento
String ls_datafinalizacao
String ls_horafinalizacao
String ls_valornf
String ls_chaveacesso
String ls_cd_unidade_federacao

ls_cd_centro 				= pds_dados.GetItemString(pl_linha,"cd_centro")
ls_descricao_centro 		= pds_dados.GetItemString(pl_linha,"descricao_centro")
ls_cd_fornecedor_sap 	= pds_dados.GetItemString(pl_linha,"cd_fornecedor_sap")
ls_nm_forncedor 			= pds_dados.GetItemString(pl_linha,"nm_forncedor")
ls_nr_nf 					= pds_dados.GetItemString(pl_linha,"nr_nf")
ls_criadopor 				= pds_dados.GetItemString(pl_linha,"criadopor")
ls_dtaEmissaonf 			= pds_dados.GetItemString(pl_linha,"dtaEmissaonf")
ls_datarecebimento 		= pds_dados.GetItemString(pl_linha,"datarecebimento")
ls_datafinalizacao 		= pds_dados.GetItemString(pl_linha,"datafinalizacao")
ls_horafinalizacao 		= pds_dados.GetItemString(pl_linha,"horafinalizacao")
ls_horarecebimento 		= pds_dados.GetItemString(pl_linha,"horarecebimento")
ls_cd_centro 				= pds_dados.GetItemString(pl_linha,"cd_centro")
ls_valornf 					= String(pds_dados.GetItemDecimal(pl_linha,"valornf"))
ls_valornf 					= gf_Replace(ls_valornf, ',', '.', 0)
ls_chaveacesso 			= pds_dados.GetItemString(pl_linha,"chaveacesso")
ls_cd_unidade_federacao	= pds_dados.GetItemString(pl_linha,"cd_unidade_federacao")
il_Integracao 				= Long(pds_dados.GetItemDecimal(pl_linha,"nr_atualizacao"))

If ls_cd_centro = '' or isnull(ls_cd_centro) Then
	ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo do centro de custo {cd_centro} n$$HEX1$$e300$$ENDHEX$$o informado.'
	Return False
End If

If ls_descricao_centro = '' or isnull(ls_descricao_centro) Then
	ps_log = 'Descri$$HEX2$$e700e300$$ENDHEX$$o do centro de custo {descricao_centro} n$$HEX1$$e300$$ENDHEX$$o informada.'
	Return False
End If

If ls_cd_fornecedor_sap = '' or isnull(ls_cd_fornecedor_sap) Then
	ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo do fornecedor  {cd_fornecedor_sap} n$$HEX1$$e300$$ENDHEX$$o informado.'
	Return False
End If

If ls_nm_forncedor = '' or isnull(ls_nm_forncedor) Then
	ps_log = 'Nome do fornecedor  {nm_forncedor} n$$HEX1$$e300$$ENDHEX$$o informado.'
	Return False
End If

If ls_nr_nf = '//' or isnull(ls_nr_nf) Then
	ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da nota fiscal  {nr_nf} n$$HEX1$$e300$$ENDHEX$$o informado.'
	Return False
End If

If ls_criadopor = '-' or isnull(ls_criadopor) Then
	ps_log = 'Usu$$HEX1$$e100$$ENDHEX$$rio de emiss$$HEX1$$e300$$ENDHEX$$o da nota fiscal  {criadopor} n$$HEX1$$e300$$ENDHEX$$o informado.'
	Return False
End If

If ls_dtaEmissaonf = '' or isnull(ls_dtaEmissaonf) Then
	ps_log = 'Data de emiss$$HEX1$$e300$$ENDHEX$$o da nota fiscal {dtaEmissaonf} n$$HEX1$$e300$$ENDHEX$$o informada.'
	Return False
End If

If ls_datarecebimento = '' or isnull(ls_datarecebimento) Then
	ps_log = 'Data de recebimento {datarecebimento} n$$HEX1$$e300$$ENDHEX$$o informada.'
	Return False
End If

If ls_horarecebimento = '' or isnull(ls_horarecebimento) Then
	ps_log = 'Hora de recebimento {horarecebimento} n$$HEX1$$e300$$ENDHEX$$o informada.'
	Return False
End If

If ls_datafinalizacao = '' or isnull(ls_datafinalizacao) Then
	ps_log = 'Data de finaliza$$HEX2$$e700e300$$ENDHEX$$o {datafinalizacao} n$$HEX1$$e300$$ENDHEX$$o informada.'
	Return False
End If

If ls_valornf = '' or isnull(ls_valornf) Then
	ps_log = 'Valor total da Nota Fiscal {valornf} n$$HEX1$$e300$$ENDHEX$$o informado.'
	Return False
End If

If ls_cd_unidade_federacao = '' or isnull(ls_cd_unidade_federacao) Then
	ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo da UF {cd_unidade_federacao} n$$HEX1$$e300$$ENDHEX$$o informada.'
	Return False
End If

If ls_chaveacesso = '' or isnull(ls_chaveacesso) Then
	ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da Chave de acesso da NF-e {de_chave_acesso} n$$HEX1$$e300$$ENDHEX$$o informado.'
	Return False
End If

If ls_horafinalizacao = '' or isnull(ls_horafinalizacao) Then
	ps_log = 'Hora da Finalizacao {horafinalizacao} n$$HEX1$$e300$$ENDHEX$$o informada.'	
	Return False
End If

ps_xml = '<imp:ITENS>'
ps_xml += '<imp:CD_UNIDADE_FEDERACAO>'+ls_cd_unidade_federacao+'</imp:CD_UNIDADE_FEDERACAO>'
ps_xml += '<imp:CD_FORNECEDOR_SAP>'+ls_cd_fornecedor_sap+'</imp:CD_FORNECEDOR_SAP>'
ps_xml += '<imp:NM_FORNECEDOR_SAP>'+gf_retira_caracteres_especiais_xml(ls_nm_forncedor)+'</imp:NM_FORNECEDOR_SAP>'
ps_xml += '<imp:NR_NF>'+ls_nr_nf+'</imp:NR_NF>'
ps_xml += '<imp:VALORNF>'+ls_valornf+'</imp:VALORNF>'
ps_xml += '<imp:CD_CENTRO>'+ls_cd_centro+'</imp:CD_CENTRO>'
ps_xml += '<imp:DESCRICAO_CENTRO>'+gf_retira_caracteres_especiais_xml(ls_descricao_centro)+'</imp:DESCRICAO_CENTRO>'
ps_xml += '<imp:DTAEMISSAONF>'+ls_dtaEmissaonf+'</imp:DTAEMISSAONF>'
ps_xml += '<imp:DATARECEBIMENTO>'+ls_datarecebimento+'</imp:DATARECEBIMENTO>'
ps_xml += '<imp:HORARECEBIMENTO>'+ls_horarecebimento+'</imp:HORARECEBIMENTO>'
ps_xml += '<imp:DATAFINALIZACAO>'+ls_datafinalizacao+'</imp:DATAFINALIZACAO>'
ps_xml += '<imp:HORAFINALIZACAO>'+ls_horafinalizacao+'</imp:HORAFINALIZACAO>'
ps_xml += '<imp:CHAVEACESSO>'+ls_chaveacesso+'</imp:CHAVEACESSO>'
ps_xml += '<imp:CRIADOPOR>'+gf_retira_caracteres_especiais_xml(ls_criadopor)+'</imp:CRIADOPOR>'
ps_xml += '</imp:ITENS>'

Return True
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
string ls_status


ls_status = Trim(of_busca_valor(as_xml, '<DESC_MSG>', ref ll_contador))

If Lower(ls_status) <> "integrado com sucesso" Then
		
	this.of_atualiza_processado( il_Integracao, 'E', "Envio do recebimento de compra na loja n$$HEX1$$e300$$ENDHEX$$o realizado" + "{ Log: " +ls_status + ' }', ref as_log)
	
Else
	/*
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
	*/
	
End If

Return True
end function

on uo_ge481_recebimento_compra_loja.create
call super::create
end on

on uo_ge481_recebimento_compra_loja.destroy
call super::destroy
end on

