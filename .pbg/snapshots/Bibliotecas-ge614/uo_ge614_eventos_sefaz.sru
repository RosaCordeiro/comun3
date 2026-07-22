HA$PBExportHeader$uo_ge614_eventos_sefaz.sru
forward
global type uo_ge614_eventos_sefaz from nonvisualobject
end type
end forward

global type uo_ge614_eventos_sefaz from nonvisualobject
end type
global uo_ge614_eventos_sefaz uo_ge614_eventos_sefaz

type prototypes
Function Integer ConsultarDistribuicaoDFe (String as_cdUF, String as_deUF,  String as_CNPJ, String as_UltimoNSU, Ref Blob as_XML_Retorno) library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "ConsultarDistribuicaoDFe;Ansi"

Function Integer ConsultarDistribuicaoDFeChave (String as_cdUF,  String as_deUF, String as_CNPJ, String as_ChaveAcesso, Ref Blob as_XML_Retorno) library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "ConsultarDistribuicaoDFeChave;Ansi"

Function Integer DescompactarXMLZip(String as_ArquivoConpact, Ref String as_ArquivoDecompact)  library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "DescompactarXMLZip;Ansi"

Function Integer ConsultarNF(String as_Chave_Acesso, String as_Uf, Ref String as_Retorno)library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "ConsultarNF;Ansi"

Function Integer EnviaManifestacaoDestinatario_Novo(Byte ai_Evento, String as_ChaveNota, String as_CNPJ, String as_Justificativa, String as_DhEvento, String as_FusoHorario, String as_Orgao, String as_UF, Ref String as_Retorno)library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "EnviaManifestacaoDetinatario_Novo;Ansi"

Function Integer GeraCartaCorrecaoEletronica(String as_Chave_Acesso, String as_Fornecedor, String as_XML, String as_Diretorio_CCe, Ref String as_Erro)  library "C:\Sistemas\DLL\SEFAZ\Eventos_Sefaz.dll" alias for "GeraCartaCorrecaoEletronica;Ansi"
end prototypes

type variables
String is_Status = ""

MultilineEdit 	imle_XML

Integer	ii_Log,&
			ii_Arquivo_Envio
			
String	is_id_log_teste_destinadas	= 'N'
Long		ll_cd_filial_teste_destinadas
end variables

forward prototypes
private function boolean of_cgc_filial (long al_filial, ref string as_cgc)
private function boolean of_documentos_destinados (long al_filial, ref blob as_xml)
public function boolean of_localiza_documentos_destinados ()
public function boolean of_abre_log ()
public function boolean of_grava_log (string as_mensagem)
public function boolean of_envia_email_cce (string as_chave_acesso)
public function boolean of_insere_destinadas_cce (long al_filial, string as_chave_acesso, long al_sequencial, datetime adh_emissao, string as_correcao, string as_protocolo)
public function boolean of_insere_destinadas_cancelamento (string as_chave_acesso, long al_filial)
public function boolean of_envia_email_nf_cancelada (string as_chave_acesso)
public function boolean of_deleta_nfe_compra_pendente (string as_chave_acesso)
public function boolean of_localiza_documentos_por_filial (long al_filial, string as_chave_acesso)
public function boolean of_documentos_destinados_chave_acesso (long al_filial, string as_chave_acesso, ref blob as_xml)
public function boolean of_verifica_teste_destinadas (ref string as_log)
public function boolean of_grava_destinadas (string as_xml, long al_filial, long al_tipo, string ls_nsu_nota)
public function boolean of_insere_destinadas_nfe (string as_chave_acesso, string as_situacao_nf, long al_filial, string as_cgc_origem, string as_razao_social_origem, string as_inscricao_estadual_origem, datetime adh_emissao, decimal adc_vl_nf, string as_tipo_nf, datetime adh_recebimento, string ls_nsu_nota)
public function boolean of_grava_destinadas (string as_xml, long al_filial, long al_tipo)
public function boolean of_consultar_nf (string as_chave_acesso, ref string as_retorno)
public function boolean of_uf_autorizadora (string as_chave_acesso, ref string as_uf, ref string as_erro)
public function boolean of_fuso_horario (string as_uf, ref string as_fuso_horario, ref string as_mensagem_log)
public function boolean of_envia_manifestacao_destinatario_novo (integer ai_evento, string as_chave_nota, string as_cnpj, string as_justificativa, string as_orgao, string as_uf, string as_data_evento, ref string as_retorno)
public function boolean of_valida_consumo_indevido (string as_tipo, long al_cd_filial, ref string as_erro)
public function boolean of_grava_parametro_consumo_indevido (string as_tipo, long al_cd_filial, ref string as_erro)
public function string of_get_value_tag (string as_xml, string as_tag, integer ai_pos)
public function boolean of_descompacta_arquivo (string as_arquivo_compactado, long al_tipo, ref string as_arquivo_descompactado)
public function boolean of_grava_nsu (string as_nsu, long al_filial)
end prototypes

private function boolean of_cgc_filial (long al_filial, ref string as_cgc);
Select nr_cgc
Into :as_Cgc
From filial 
Where cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o CGC da filial "+String(al_Filial)+". " + SqlCa.sqlErrText)
		Return False
	Case -1 
		MessageBox("Erro", "Erro ao localizar o CGC da filial "+String(al_Filial)+". " + SqlCa.sqlErrText)
		Return False
End Choose

Return True
end function

private function boolean of_documentos_destinados (long al_filial, ref blob as_xml);Long	ll_Retorno,&
		ll_NSU
		

String 	ls_Cgc,&
			ls_UF,&
			ls_NSU,&
			ls_Cd_Uf



select 	nr_cgc, 
			b.cd_unidade_federacao,
			coalesce(max(c.nr_ultimo_nsu), 0) as nr_ultimo_nsu
Into	:ls_Cgc,
		:ls_UF,
		:ll_NSU			
from filial a
inner join cidade b on b.cd_cidade = a.cd_cidade
left outer join nfe_destinadas_nsu_historico c on c.cd_filial = a.cd_filial
where a.cd_filial = :al_Filial
group by nr_cgc, b.cd_unidade_federacao
Using SqlCa;

ls_Cd_Uf = gf_Codigo_UF(ls_UF)

ls_NSU = Right("000000000000000"+String(ll_NSU), 15)
as_XML = Blob(Space(800000))

ll_Retorno = ConsultarDistribuicaoDFe (ls_Cd_Uf, ls_UF,  ls_Cgc, ls_NSU, Ref as_XML)


Return ll_Retorno = 1
end function

public function boolean of_localiza_documentos_destinados ();dc_uo_ds_Base	lds_Filiais,&
					lds_Agendamento
					
Boolean	lb_operacao_sap_iniciada

Date ld_data

Long 	ll_Linhas,&
		ll_Linha,&
		ll_Filial,&
		ll_cd_filial_aux
		
String	ls_Chave_Acesso,&
		ls_Retira_Filial
		
String ls_Log


Try
	This.of_Abre_Log()
	
	lds_Filiais			= Create dc_uo_ds_Base
	lds_Agendamento	= Create dc_uo_ds_Base
	
	if is_id_log_teste_destinadas = 'S' then
		This.of_Grava_Log('In$$HEX1$$ed00$$ENDHEX$$cio processo.of_localiza_documentos_destinados() ')
	end if
	
	Open(w_aguarde)
	
	if not this.of_verifica_teste_destinadas(REF ls_log) then
		This.of_Grava_Log(ls_log)
		Return True //Deixa passar, mas, n$$HEX1$$e300$$ENDHEX$$o grava destinadas
	end if
		
	If Not lds_Filiais.of_ChangeDataObject("ds_ge614_filiais") Then
		This.of_Grava_Log("Erro no changeDataObject da ds_ge614_filiais")
		Return False
	End If
	
	If Not lds_Agendamento.of_ChangeDataObject("ds_ge614_notas_agendamento") Then
		This.of_Grava_Log("Erro no changeDataObject da ds_ge614_notas_agendamento")
		Return False
	End If
	
	If Not gf_inicio_operacao_cd_sap('DH_INICIO_CD_SAP_NOTAS', Ref ld_data, Ref ls_Log) Then
		This.of_Grava_Log(ls_Log)
		Return False
	End If
	
	// Assim que iniciar a opera$$HEX2$$e700e300$$ENDHEX$$o no SAP n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ mais realizada a manifesta$$HEX2$$e700e300$$ENDHEX$$o das notas do CD
	If Date(gf_getserverdate()) >= ld_data Then
		lds_Filiais.of_AppendWhere('a.cd_filial <> 534')
	End If
	
	if is_id_log_teste_destinadas = 'S' then
		ll_cd_filial_aux = ll_cd_filial_teste_destinadas
	else
		SetNull(ll_cd_filial_aux)
	end if
	
	ll_Linhas = lds_Filiais.Retrieve(ll_cd_filial_aux)
	
	if is_id_log_teste_destinadas = 'S' then
		This.of_Grava_Log('Processando: ' + String(ll_linhas) + ' Filiais.')
	end if
	
	w_aguarde.uo_Progress.of_SetMax(ll_Linhas)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			w_aguarde.uo_Progress.of_SetProgress(ll_Linha)
			
			ll_Filial = lds_Filiais.Object.cd_filial[ll_Linha]
			
			if is_id_log_teste_destinadas = 'S' then
				This.of_Grava_Log('Iniciando localiza$$HEX2$$e700e300$$ENDHEX$$o de destinadas da filial: ' + String(ll_Filial) + ' .')
			end if
			
			lb_operacao_sap_iniciada	= False
			
			if not gf_verifica_inicio_operacao_sap_loja(ll_Filial, 'DH_INICIO_FILIAL_SAP_NOTAS', REF lb_operacao_sap_iniciada, REF ls_log) then
				This.of_Grava_Log(ls_log+" Filial: "+String(ll_Filial))
				Continue
			end if
			
			//Caso a opera$$HEX2$$e700e300$$ENDHEX$$o do SAP j$$HEX1$$e100$$ENDHEX$$ tenha sido iniciada o sistema n$$HEX1$$e300$$ENDHEX$$o deve fazedr nada do processo abaixo.
			if lb_operacao_sap_iniciada then continue
			
			Select coalesce(vl_parametro, 'N')
			Into :ls_Retira_Filial
			From parametro_loja
			Where cd_parametro 	= 'ID_RETIRA_LOJA_LOCALIZACAO_DOC_DESTINADO'
			and cd_filial 			= :ll_Filial
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				This.of_Grava_Log("Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro da loja 'ID_RETIRA_LOJA_LOCALIZACAO_DOC_DESTINADO'. " + SqlCa.sqlErrText)
				Return False
			End If
			
			ls_Retira_Filial = iif(ls_Retira_Filial = '', 'N', ls_Retira_Filial)
			
			SetNull(ls_Chave_Acesso)
			
			w_aguarde.Title = "Buscando documentos destinados. Filial: " + String(ll_Filial)
			
			If ls_Retira_Filial = 'N' Then 				
				If Not of_localiza_documentos_por_filial(ll_Filial, ls_Chave_Acesso) Then
					SqlCa.Of_RollBack()
					Return False
				End If
			Else
				This.of_Grava_Log("A filial esta com o par$$HEX1$$e200$$ENDHEX$$metro 'ID_RETIRA_LOJA_LOCALIZACAO_DOC_DESTINADO' igual a 'S'. <<< NAO ESTA LOCALIZANDO OS DOCUMENTOS DESTINADOS >>>")
			End If
		Next
	End If
	
	//Localiza as notas do agendamento. Vai consultar pela chave de acesso para ver se a nota est$$HEX1$$e100$$ENDHEX$$ cancelada na SEFAZ
	ll_Linhas = lds_Agendamento.Retrieve()
	
	If ll_Linhas > 0 Then
		w_aguarde.Title = "Verificando cancelamento de notas do agendamento..."
		w_aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
			
			ls_Chave_Acesso = lds_Agendamento.Object.de_chave_acesso[ll_Linha]
			
			If Not of_localiza_documentos_por_filial(534, ls_Chave_Acesso) Then
				Return False
			End If
			
			w_aguarde.uo_Progress.of_SetProgress(ll_Linha)
			
		Next
	End If
	
Finally
	Destroy(lds_Filiais)
	Destroy(lds_Agendamento)
	Close(w_aguarde)
	FileClose (ii_Log )
End Try
end function

public function boolean of_abre_log ();String ls_Path

ls_Path 	= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

If IsNull(ls_Path) or Trim(ls_Path) = '' Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do log n$$HEX1$$e300$$ENDHEX$$o foi localizado no INI da aplica$$HEX2$$e700e300$$ENDHEX$$o. Chave: Diretorio | Se$$HEX2$$e700e300$$ENDHEX$$o: Diretorio = c:\sistemas\gn\arquivos\ .", StopSign!)
	Return False
End If

ls_Path = ls_Path + "Documentos_Destinados_" + string(Today(),"ddmm")

If Not gf_Cria_Logs(ls_Path, 4, ref ii_log) Then
	Return False
End If

Return True
end function

public function boolean of_grava_log (string as_mensagem);return gf_grava_log_basico(ii_log, as_mensagem)
end function

public function boolean of_envia_email_cce (string as_chave_acesso);String	ls_XML,&
		ls_Fornecedor,&
		ls_Especie,&
		ls_Serie,&
		ls_Chave_Acesso,&
		ls_Correcao,&
		ls_Nm_Fornecedor,&
		ls_Protocolo,&
		ls_Erro,&
		ls_Diretorio_CCe,&
		ls_Email,&
		ls_Mensagem
		
Long	ll_Nota,&
		ll_Sequencial,&
		ll_Filial
		
DateTime	ldh_Emissao	

s_email str

ls_XML	= 	'<?xml version="1.0" encoding="UTF-8"?>'+&
				'<procEventoNFe versao="1.00" xmlns="http://www.portalfiscal.inf.br/nfe"><evento xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.00"><infEvento Id="ID1101104213068468348101994355001000208482100208482001"><cOrgao>##cOrgao##</cOrgao><tpAmb>1</tpAmb><CNPJ>84683481019943</CNPJ><chNFe>##chNFe##</chNFe><dhEvento>##dhEvento##-03:00</dhEvento><tpEvento>110110</tpEvento><nSeqEvento>##nSeqEvento##</nSeqEvento><verEvento>1.00</verEvento><detEvento versao="1.00"><descEvento>Carta de Correcao</descEvento><xCorrecao>##xCorrecao##</xCorrecao><xCondUso>A Carta de Correcao e disciplinada pelo paragrafo 1o-A do art. 7o do Convenio S/N, de 15 de dezembro de 1970 e pode ser utilizada para regularizacao de erro ocorrido na emissao de documento fiscal, desde que o erro nao esteja relacionado com: I - as variaveis que determinam o valor do imposto tais como: base de calculo, aliquota, diferenca de preco, quantidade, valor da operacao ou da prestacao; II - a correcao de dados cadastrais que implique mudanca do remetente ou do de'+&
				'stinatario; III - a data de emissao ou de saida.</xCondUso></detEvento></infEvento><Signature xmlns="http://www.w3.org/2000/09/xmldsig#"><SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/><Reference URI="#ID1101104213068468348101994355001000208482100208482001"><Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/><Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/></Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/><DigestValue>7edjPKcoy+xYPcMQfTrXan74+Pw=</DigestValue></Reference></SignedInfo><SignatureValue>f1Dyzmbzu/azwjqKpJXJG3okjxsZVIQmPndB4Jh8qHmUBOUGokgEX6ESekjtVgukxJBuqPFYov33S4tRVeM/pmNl/GoWbMn1F8f52TEP+pJCr6KSmkzHDAyp2bGEvjpF1byGnccZMzA91zc/PiTNG20TDSzAJT0nUpA1vbzvMxyRMPQVlleCbsZiF+7QTk7x/IIzX7xrVQ1Kk1ucrYRBXttj6KEPoV1OyGXHPdMTrL+a8Fc7tW8kdr/X7eiooQEVmw0c41a0f5hw/5Vy0l/p7r5a/dKQqKcn9n0tPUoXt6JMXkLnNZJ'+&
				'jqv7kARF4To6rfvaoSpwCcDzJ96q7849MAA==</SignatureValue><KeyInfo><X509Data><X509Certificate>MIIH1zCCBb+gAwIBAgIIQoRZ4YHTIrYwDQYJKoZIhvcNAQELBQAwTDELMAkGA1UEBhMCQlIxEzARBgNVBAoTCklDUC1CcmFzaWwxKDAmBgNVBAMTH1NFUkFTQSBDZXJ0aWZpY2Fkb3JhIERpZ2l0YWwgdjIwHhcNMTMwNTEzMTIyNzAwWhcNMTQwNTEzMTIyNzAwWjCB7zELMAkGA1UEBhMCQlIxEzARBgNVBAoTCklDUC1CcmFzaWwxFDASBgNVBAsTCyhFTSBCUkFOQ08pMRgwFgYDVQQLEw8wMDAwMDEwMDQxODU2NTAxFDASBgNVBAsTCyhFTSBCUkFOQ08pMRQwEgYDVQQLEwsoRU0gQlJBTkNPKTEUMBIGA1UECxMLKEVNIEJSQU5DTykxFDASBgNVBAsTCyhFTSBCUkFOQ08pMRQwEgYDVQQLEwsoRU0gQlJBTkNPKTEtMCsGA1UEAxMkQ0lBIExBVElOTyBBTUVSSUNBTkEgREUgTUVESUNBTUVOVE9TMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApVnRDmIK3SFPNQACD9SDCBmZesQcZHj7WxEFrUCIxO3T8mQNv6iKF7Eglta857u/BHS1DjiTud/ZYXsYi6zPoGnw6md+TPWL38jonRKq9uAXOsSOi6oNmSIfFWNi8dPMPUkKebAfMPtj1yBdMfuzkz7JxRYliYDUPRG63MVKcTrhaEJv297v93qFZy3wni1Vrb+oGEegrldPSH/zAbJRFJYKWhH+bEnQYd+8'+&
				'+UhVhR0pBAQTNQjN4LinMKKy7UJPAvayBKEuUZ/x3zC0IZV2cFNuT1qA1oxWphTwdGMtcmLs5ChFAOQwM837sEjyThnPliuenEqwa8Va2YHHg3aYHwIDAQABo4IDFzCCAxMwgZcGCCsGAQUFBwEBBIGKMIGHMEcGCCsGAQUFBzAChjtodHRwOi8vd3d3LmNlcnRpZmljYWRvZGlnaXRhbC5jb20uYnIvY2FkZWlhcy9zZXJhc2FjZHYyLnA3YjA8BggrBgEFBQcwAYYwaHR0cDovL29jc3AuY2VydGlmaWNhZG9kaWdpdGFsLmNvbS5ici9zZXJhc2FjZHYyMB8GA1UdIwQYMBaAFJrggxDXJpvputqCsoHOORrTh3CGMHEGA1UdIARqMGgwZgYGYEwBAgEGMFwwWgYIKwYBBQUHAgEWTmh0dHA6Ly9wdWJsaWNhY2FvLmNlcnRpZmljYWRvZGlnaXRhbC5jb20uYnIvcmVwb3NpdG9yaW8vZHBjL2RlY2xhcmFjYW8tc2NkLnBkZjCB8AYDVR0fBIHoMIHlMEmgR6BFhkNodHRwOi8vd3d3LmNlcnRpZmljYWRvZGlnaXRhbC5jb20uYnIvcmVwb3NpdG9yaW8vbGNyL3NlcmFzYWNkdjIuY3JsMEOgQaA/hj1odHRwOi8vbGNyLmNlcnRpZmljYWRvcy5jb20uYnIvcmVwb3NpdG9yaW8vbGNyL3NlcmFzYWNkdjIuY3JsMFOgUaBPhk1odHRwOi8vcmVwb3NpdG9yaW8uaWNwYnJhc2lsLmdvdi5ici9sY3IvU2VyYXNhL3JlcG9zaXRvcmlvL2xjci9zZXJhc2FjZHYyLmNybDAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMIHABgNVHREEgbgwgbWBG1NPTklBLk1BUklBTk9AQ0xBTUVELkNPTS5CUqA+BgVgTAEDBKA1EzMyNzExMTk2MTQ4NjI0Nzk5OTUzMDAw'+&
				'MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDCgIgYFYEwBAwKgGRMXU09OSUEgQlJFU0NJQU5JIE1BUklBTk+gGQYFYEwBAwOgEBMOODQ2ODM0ODEwMDAxNzegFwYFYEwBAwegDhMMMDAwMDAwMDAwMDAwMA0GCSqGSIb3DQEBCwUAA4ICAQB18uRaCb9AvVD6ScccFnaZ6M4P/4slX0K6hjiX3fH5ftZn2z/E1ez7P7ESpa0Ndr0MLPPOYnRaqlS3/CybuYnMnbMldvuM6mbbBowERj6UgGQyBUvMBcUeURwjSnWp3dDijzNZsA6O7zMZ8Od5pNkmUnvsXf74ZN+tDrlQ0bWgndbyE47bZoKHHpCaIqWpL1KZaWkVL398FRSrcvF3kMbMhRornbLlE2dTnbMLu+VSko0gUv9B9kyPNdj4owuxSsKExuKOWmlEpmgk920I85EfATAOHBuWIEAH/rpBcad0JDgxydTppIDvQkGJR0+Iq9zIsA8nRiQ4JPvx8q6uy17wkbxaZjsEWLROJwBQ9UqHODrs5QU/7JvRl48qP+l5oFIOMBvhufENOqB8OLwn/zNdPTZ3zDmt8uKLlcrf1TskGX4/lpgARam5BCGS01epB+c1EWRMlW32aLie4gYKKpEuPSHhuzTT+gfePcDyAEIvP9JztBfRlWqjxRehSTwpF1ySK47jGhd1fYukJnQAIwqJAs+7eJjlIBmPBbE80KoiTAvU0cSvNg1JDj2gaLCEaCrlcsJYIpnOjtf9ShVUutluwTVLuAUbIc/9v8df6f1MJ0+ATq+NhPJ3nKt+Ut1T5lj7yfhgp1SxYqJJEpSS3vpetkDtWyj6D0st7AvgPUG4dQ==</X509Certificate></X509Data></KeyInfo></Signature></evento><retEvento xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.00"><infEvento Id="ID34213006363'+&
				'8479"><tpAmb>1</tpAmb><verAplic>SVRS20120906120553</verAplic><cOrgao>##cOrgao##</cOrgao><cStat>135</cStat><xMotivo>Evento registrado e vinculado a NF-e</xMotivo><chNFe>##chNFe##</chNFe><tpEvento>110110</tpEvento><nSeqEvento>##nSeqEvento##</nSeqEvento><CNPJDest>05558134000146</CNPJDest><dhRegEvento>##dhEvento##-03:00</dhRegEvento><nProt>##nProt##</nProt></infEvento></retEvento>'+&
				'</procEventoNFe>'

select	top 1 
		'('+substring(c.cd_fornecedor, 1, 4)+'-'+substring(c.cd_fornecedor, 5, 5)+') - '+c.nm_fantasia as fornecedor, 
		cast(substring(a.de_chave_acesso, 26, 9) as integer) as	nr_nf, 
		'NFE' as de_especie, 
		cast(substring(a.de_chave_acesso, 23, 3) as integer) as	de_serie, 
		a.nr_sequencial, 
		a.de_chave_acesso, 
		a.dh_emissao,
		a.de_correcao,
		b.cd_filial,
		c.nm_fantasia nm_fornecedor,
		coalesce(a.nr_protocolo, '')
Into	:ls_Fornecedor,
		:ll_Nota,
		:ls_Especie,
		:ls_Serie,
		:ll_Sequencial,
		:ls_Chave_Acesso,
		:ldh_Emissao,
		:ls_Correcao,
		:ll_Filial,
		:ls_Nm_Fornecedor,
		:ls_Protocolo
from nfe_destinadas_carta_correcao	a
inner join filial								b on b.nr_cgc = a.nr_cgc_destino
inner join fornecedor						c on c.nr_cgc = substring(a.de_chave_acesso, 7, 14)
inner join parametro_odbc				d on (d.cd_filial = b.cd_filial) or (b.cd_filial =  534)
where a.de_chave_acesso = :as_Chave_Acesso
order by a.nr_sequencial desc
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		//Se n$$HEX1$$e300$$ENDHEX$$o encontrar n$$HEX1$$e300$$ENDHEX$$o envia e-mail, tem casos que a filial fechou
		
//		This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi localizado as informa$$HEX2$$e700f500$$ENDHEX$$es da CC-e para enviar ao destinat$$HEX1$$e100$$ENDHEX$$rio. Chave de acesso: "+as_Chave_Acesso)
//		SqlCa.of_Rollback()
//		Return False

		Return True
	Case -1
		This.of_Grava_Log("Erro ao localizar dados da carta de corre$$HEX2$$e700e300$$ENDHEX$$o: " + SqlCa.sqlErrText)
		SqlCa.of_Rollback()
		Return False
End Choose

ls_XML	= gf_Replace(ls_XML, '##chNFe##', ls_Chave_Acesso,0);
ls_XML	= gf_Replace(ls_XML, '##dhEvento##', String(ldh_Emissao, "yyyy-mm-ddThh:mm:ss"), 0);
ls_XML	= gf_Replace(ls_XML, '##nSeqEvento##', String(ll_Sequencial), 0);
ls_XML	= gf_Replace(ls_XML, '##xCorrecao##', ls_Correcao, 0);
ls_XML	= gf_Replace(ls_XML, '##cOrgao##', Mid(ls_Chave_Acesso, 1, 2), 0);
ls_XML	= gf_Replace(ls_XML, '##nProt##', ls_Protocolo, 0);


ls_Diretorio_CCe = getcurrentdirectory()+"\CartaCorrecaoEletronica\"
	
If Not FileExists(ls_Diretorio_CCe) Then
	If CreateDirectory(ls_Diretorio_CCe ) = -1 Then
		If Not This.of_Grava_Log("Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o layout da CCe na m$$HEX1$$e100$$ENDHEX$$quina local. Diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Diretorio_CCe + "'.") Then
			MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_email_cce' da 'GE614 eventos sefaz'.", StopSign!)
		End If
		SqlCa.of_Rollback()
		Return False
	End If
End If

ls_Erro = Space(400)

ls_Nm_Fornecedor = gf_Replace(ls_Nm_Fornecedor, "/", " ", 0)

If GeraCartaCorrecaoEletronica(ls_Chave_Acesso, ls_Nm_Fornecedor, ls_XML, ls_Diretorio_CCe, Ref ls_Erro) <> 1 Then
	If Not This.of_Grava_Log(ls_Erro) Then
		MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_email_cce' da 'GE614 eventos sefaz'.", StopSign!)
	End If
	SqlCa.of_Rollback()
	Return False
End If

//Envia email
If ll_Filial = 534 Then
	ls_Email = 'recebimento_2@clamed.com.br'
Else
	ls_Email = Right("0000" + String(ll_Filial), 4) + "@clamedlocal.com.br"
end If	

ls_Mensagem =	"CARTA DE CORRE$$HEX2$$c700c300$$ENDHEX$$O ELETR$$HEX1$$d400$$ENDHEX$$NICA<br><br>"+&
						"Fornecedor: "+ ls_Fornecedor+"<br>"+&
						"Nota: "+String(ll_Nota)+"<br>"+&
						"Esp$$HEX1$$e900$$ENDHEX$$cie: "+ls_Especie+"<br>"+&
						"S$$HEX1$$e900$$ENDHEX$$rie: "+ls_Serie+"<br>"+&
						"Chave de Acesso: "+ls_Chave_Acesso+"<br><br>"+&
						"Arquivo para impress$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ anexo."



str.ps_to[1]			= ls_Email
str.ps_anexo[1]	= ls_Diretorio_CCe + ls_Chave_Acesso + '-cce.pdf'
str.ps_Mensagem	= ls_Mensagem
str.pb_assinatura = True


If Not gf_ge202_envia_email_padrao(113, str) Then
	If Not This.of_Grava_Log("Erro ao envia a CC-e para o email "+ls_Email) Then
		MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_email_cce' da 'GE614 eventos sefaz'.", StopSign!)
	End If
	SqlCa.of_Rollback()
	Return False	
End If



//Exclui a CC-e
If Not FileDelete(ls_Diretorio_CCe + ls_Chave_Acesso + '-cce.pdf') Then
	If Not This.of_Grava_Log("Erro ao deletar o arquivo "+ls_Diretorio_CCe + ls_Chave_Acesso + "-cce.pdf.") Then
		MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_email_cce' da 'GE614 eventos sefaz'.", StopSign!)
	End If
	SqlCa.of_Rollback()
	Return False
End If

Return True
end function

public function boolean of_insere_destinadas_cce (long al_filial, string as_chave_acesso, long al_sequencial, datetime adh_emissao, string as_correcao, string as_protocolo);Long	ll_Qtde

String		ls_Cgc_Destino

Select count(*)
Into :ll_Qtde
From nfe_destinadas_carta_correcao
Where de_chave_acesso	= :as_Chave_Acesso
	and nr_sequencial		= :al_Sequencial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_Grava_Log("Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o registro na tabela 'nfe_destinadas_carta_correcao' . " + SqlCa.sqlErrText)
	SqlCa.of_Rollback()
	Return False
End If
	
If ll_Qtde = 0 Then
	
	If Not This.of_cgc_filial(al_Filial, Ref ls_Cgc_Destino) Then
		SqlCa.of_Rollback()
		Return False
	End If
	
	INSERT INTO nfe_destinadas_carta_correcao (
		de_chave_acesso,
		nr_sequencial,
		dh_emissao,
		de_correcao,
		nr_cgc_destino,
		nr_protocolo)
	 VALUES (	:as_chave_acesso,
          			:al_Sequencial,
           			:adh_emissao,
           			:as_Correcao,
          			:ls_Cgc_Destino,
					:as_Protocolo)
	Using SqlCa;	
	
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Log("Erro ao inserir o registro na tabela 'nfe_destinadas_carta_correcao' . " + SqlCa.sqlErrText)
		SqlCa.of_Rollback()
		Return False
	End If
End If

Return True
end function

public function boolean of_insere_destinadas_cancelamento (string as_chave_acesso, long al_filial);Long	ll_Qtde

String	ls_Cgc_Destino,&
		ls_Cgc_Origem,&
		ls_Razao_Social_Origem,&
		ls_Inscricao_Estadual_Origem
		
DateTime	ldh_Emissao	

Decimal	ldc_Vl_Nf

Select count(*)
Into :ll_Qtde
From nfe_destinadas
Where de_chave_acesso = :as_Chave_Acesso
	and id_situacao_nf		= '3'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_Grava_Log("Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o registro na tabela 'nfe_destinadas' . " + SqlCa.sqlErrText)
	SqlCa.of_Rollback()
	Return False
End If
	
If ll_Qtde = 0 Then
	
	Select	a.nr_cgc_fornecedor,
			c.nm_fantasia,
			c.nr_inscricao_estadual,
			a.dh_emissao,
			a.vl_total_nf,
			(select nr_cgc from filial where cd_filial = :al_Filial)
	Into	:ls_Cgc_Origem,
			:ls_Razao_Social_Origem,
			:ls_Inscricao_Estadual_Origem,
			:ldh_Emissao,
			:ldc_Vl_Nf,
			:ls_Cgc_Destino
	From nf_agendamento_ent a
	Left Join	pedido_central b on b.nr_pedido = a.nr_pedido_central
	Left Join fornecedor		c on c.cd_fornecedor = b.cd_fornecedor
	Where a.de_chave_acesso = :as_Chave_Acesso
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			ls_Inscricao_Estadual_Origem = gf_Replace(ls_Inscricao_Estadual_Origem, ".", "", 0)
			ls_Inscricao_Estadual_Origem = gf_Replace(ls_Inscricao_Estadual_Origem, "-", "", 0)
			ls_Inscricao_Estadual_Origem = gf_Replace(ls_Inscricao_Estadual_Origem, " ", "", 0)
		Case 100
			This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi localizado as informa$$HEX2$$e700e300$$ENDHEX$$oes do fornecedor ao gravar o cancelamento da destinadas. Chave de acesso: "+as_Chave_Acesso)
			SqlCa.of_Rollback()
			Return False
		Case -1
			This.of_Grava_Log("Erro ao localizar informa$$HEX2$$e700e300$$ENDHEX$$oes do fornecedor ao gravar o cancelamento da destinadas: " + SqlCa.sqlErrText)
			SqlCa.of_Rollback()
			Return False
	End Choose
	
	
	Insert Into nfe_destinadas(
		de_chave_acesso,
		id_situacao_nf,
		nr_cgc_origem,
		nm_razao_social_origem,
		nr_inscricao_estadual_origem,
		dh_emissao,
		vl_nf,
		id_tipo_nf,
		id_situacao_manifestacao,
		nr_cgc_destino)
	Values(
		:as_Chave_Acesso,
		'3',
		:ls_Cgc_Origem,
		:ls_Razao_Social_Origem,
		:ls_Inscricao_Estadual_Origem,
		:ldh_Emissao,
		:ldc_Vl_Nf,
		'1',
		'0',
		:ls_Cgc_Destino)
	Using SqlCa;	
	
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Log("Erro ao inserir o registro na tabela 'nfe_destinadas' . " + SqlCa.sqlErrText)
		SqlCa.of_Rollback()
		Return False
	End If
End If

SqlCa.of_Commit()

Return True
end function

public function boolean of_envia_email_nf_cancelada (string as_chave_acesso);String	ls_Cgc_Origem,&
		ls_Fornecedor,&
		ls_Nm_Fantasia,&
		ls_Mensagem,&
		ls_Nr_Nf

s_email str

If (as_Chave_Acesso = "") or IsNull(as_Chave_Acesso) Then
	Return True
End If

If Len(as_Chave_Acesso) <> 44 Then
	Return True
End If

ls_Cgc_Origem = Mid(as_Chave_Acesso, 7, 14)
ls_Nr_Nf			= Mid(as_Chave_Acesso, 26, 9)

Select		top 1 cd_fornecedor,
			nm_fantasia
Into	:ls_Fornecedor,
		:ls_Nm_Fantasia
From fornecedor
Where	nr_cgc									= :ls_Cgc_Origem
	And	coalesce(id_importacao_nfe, 'N')	= 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ls_Mensagem =	"Ol$$HEX1$$e100$$ENDHEX$$<br><br>~n"+&
								"A nota fiscal "+ls_Nr_Nf+" foi cancelada na SEFAZ.<br><br>~n"+&
								"Chave de Acess: "+as_Chave_Acesso+"<br>~n"+&
								"Fornecedor: ("+Mid(ls_Fornecedor, 1, 4)+"-"+Mid(ls_Fornecedor, 5)+") "+ls_Nm_Fantasia
								
		str.ps_Mensagem	= ls_Mensagem
		str.pb_assinatura = True
		
		
		If Not gf_ge202_envia_email_padrao(124, str) Then
			If Not This.of_Grava_Log("Erro ao envia e-mail de nota cancelada. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_email_nf_cancelada'.") Then
				SqlCa.of_Rollback()
				MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_email_nf_cancelada' da 'GE614 eventos sefaz'.", StopSign!)
			End If
			SqlCa.of_Rollback()
			Return False	
		End If
		
		If Not of_Deleta_Nfe_Compra_Pendente(as_Chave_Acesso) Then
			Return False
		End If

	Case 100
		Return True
	Case -1
		If Not This.of_Grava_Log("Erro ao localizar informa$$HEX2$$e700e300$$ENDHEX$$oes do fornecedorfun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_email_nf_cancelada': " + SqlCa.sqlErrText) Then
			SqlCa.of_Rollback()
			MessageBox("Erro", "Erro ao gravar log na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_envia_email_nf_cancelada' da 'GE614 eventos sefaz'.", StopSign!)
		End If
		SqlCa.of_Rollback()
		Return False
End Choose

Return True
end function

public function boolean of_deleta_nfe_compra_pendente (string as_chave_acesso);Long	ll_Filial,&
		ll_Nota
		
String	ls_Fornecedor,&
		ls_Especie,&
		ls_Serie
		
Select	cd_filial,
		cd_fornecedor,
		nr_nf,
		de_especie,
		de_serie
Into	:ll_Filial,
		:ls_Fornecedor,
		:ll_Nota,
		:ls_Especie,
		:ls_Serie
From nfe_compra_pendente
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		Return True
	Case -1
		If Not This.of_Grava_Log("Erro ao localizar as informa$$HEX2$$e700f500$$ENDHEX$$es da nota na tabela 'nfe_compra_pendente'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_deleta_nfe_compra_pendente'.") Then
			SqlCa.of_Rollback()
			MessageBox("Erro", "Erro ao localizar as informa$$HEX2$$e700f500$$ENDHEX$$es da nota na tabela 'nfe_compra_pendente'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_deleta_nfe_compra_pendente' da 'GE614 eventos sefaz'.", StopSign!)
		End If
		SqlCa.of_Rollback()
		Return False
End Choose

//Exclui os produtos
Delete From nfe_compra_pendente_prd
Where	cd_filial 			= :ll_Filial
	And	cd_fornecedor	= :ls_Fornecedor
	And	nr_nf				= :ll_Nota
	And	de_especie		= :ls_Especie
	And	de_serie			= :ls_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	If Not This.of_Grava_Log("Erro ao excluir as informa$$HEX2$$e700f500$$ENDHEX$$es da nota na tabela 'nfe_compra_pendente_prd'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_deleta_nfe_compra_pendente'.") Then
		SqlCa.of_Rollback()
		MessageBox("Erro", "Erro ao excluir as informa$$HEX2$$e700f500$$ENDHEX$$es da nota na tabela 'nfe_compra_pendente_prd'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_deleta_nfe_compra_pendente' da 'GE614 eventos sefaz'.", StopSign!)
	End If
	SqlCa.of_Rollback()
	Return False
End If

//Exclui a nota
Delete From nfe_compra_pendente
Where	cd_filial 			= :ll_Filial
	And	cd_fornecedor	= :ls_Fornecedor
	And	nr_nf				= :ll_Nota
	And	de_especie		= :ls_Especie
	And	de_serie			= :ls_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	If Not This.of_Grava_Log("Erro ao excluir as informa$$HEX2$$e700f500$$ENDHEX$$es da nota na tabela 'nfe_compra_pendente'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_deleta_nfe_compra_pendente'.") Then
		SqlCa.of_Rollback()
		MessageBox("Erro", "Erro ao excluir as informa$$HEX2$$e700f500$$ENDHEX$$es da nota na tabela 'nfe_compra_pendente'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_deleta_nfe_compra_pendente' da 'GE614 eventos sefaz'.", StopSign!)
	End If
	SqlCa.of_Rollback()
	Return False
End If

If SqlCa.SqlnRows <> 1 Then
	If Not This.of_Grava_Log("Deveria ter excluido 1 linha da tabela 'nfe_compra_pendente', mas excluiu "+String(SqlCa.SqlnRows)+" linhas. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_deleta_nfe_compra_pendente'.") Then
		SqlCa.of_Rollback()
		MessageBox("Erro", "Deveria ter excluido 1 linha da tabela 'nfe_compra_pendente', mas excluiu "+String(SqlCa.SqlnRows)+" linhas. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_deleta_nfe_compra_pendente' da 'GE614 eventos sefaz'.", StopSign!)
	End If
	SqlCa.of_Rollback()
	Return False
End If

Return True
end function

public function boolean of_localiza_documentos_por_filial (long al_filial, string as_chave_acesso);Blob lbs_XML

String 	ls_Parte_XML,&
			ls_XML_Decompactado,&
			ls_NSU,&
			ls_Nulo,&
			ls_Erro
			
Long	ll_Pos1,&
		ll_Pos2,&
		ll_Tamanho,&
		ll_Tipo, &
		ll_count
		
s_email str		

dc_uo_eventos_sefaz ldc //GE238

Try
	if not of_valida_consumo_indevido('DESTINADAS', al_filial, REF ls_Erro) then
		This.of_Grava_Log(ls_Erro)
		Return True // Continua para proxima filial
	end if
	
	ldc = Create dc_uo_eventos_sefaz
	
	Try
		If Not IsNull(as_Chave_Acesso) Then
			If Not This.of_documentos_destinados_chave_acesso(al_Filial, as_Chave_Acesso, Ref lbs_XML) Then
				ls_Erro	= String(lbs_XML, EncodingANSI!)
				
				str.ps_Mensagem	= ls_Erro
				str.pb_assinatura	= True
				
				If Not gf_ge202_envia_email_padrao(83, str) Then
					This.of_Grava_Log( ls_Erro) 
				End If
				
				If Pos(ls_Erro, "Service Unavailable") > 0 Then
					Return True
				Else
					Return False
				End If
			End If
			
			is_Status = This.of_Get_Value_Tag(String(lbs_XML, EncodingANSI!) , "<cStat>", 1) 
			
			//653 -> NF-e Cancelada
			
			If is_Status = "653" Then
				If Not This.of_insere_destinadas_cancelamento (as_Chave_Acesso,	al_Filial) Then
					Return False
				End If			
			End If
		Else
			ll_count	= 0
			
			DO
				ll_count ++
				
				if is_id_log_teste_destinadas = 'S' then
					This.of_Grava_Log('Iniciando a consulta dos documentos na filial: ' + String(al_Filial) + ' .')
				end if
				
				If Not This.of_documentos_destinados(al_Filial, Ref lbs_XML) Then
					if is_id_log_teste_destinadas = 'S' then
						This.of_Grava_Log('Encontrou retorno na busca dos documentos destinados (Indice: ' + String(ll_count) + ' ). Detalhes abaixo.')
						This.of_Grava_Log(String(lbs_XML, EncodingANSI!))
					end if
					
					ls_Erro = String(lbs_XML, EncodingANSI!)
					
					str.ps_Mensagem	= ls_Erro
					str.pb_assinatura	= True
					
					If Not gf_ge202_envia_email_padrao(83, str) Then
						This.of_Grava_Log(ls_Erro)
					End If
					
					If Pos(ls_Erro, "Service Unavailable") > 0 Then
						Return True
					Else
						Return False
					End If
				End If
								
				//137 -> Nenhum documento localizado
				//138 -> Documento localizado
				//656 -> Rejei$$HEX2$$e700e300$$ENDHEX$$o: Consumo Indevido
				
				is_Status = This.of_Get_Value_Tag(String(lbs_XML, EncodingANSI!) , "<cStat>", 1) 
				
				If (is_Status = "656") Then
					if is_id_log_teste_destinadas = 'S' then
						This.of_Grava_Log('status 656 encontrado, problema de consumo indevido.')
					end if
					
					if not of_grava_parametro_consumo_indevido('DESTINADAS', al_filial, REF ls_Erro) then
						SqlCa.of_Rollback()
						This.of_Grava_Log(ls_Erro)
						Return False
					end if
					
					SqlCa.of_Commit()
					Return True
				ElseIf (is_Status = "137") Then
					//----------------------------
					Long	ll_Ultimo_NSU,&
							ll_Max_NSU	
							
					ll_Ultimo_NSU	= Long(This.of_Get_Value_Tag(String(lbs_XML, EncodingANSI!) , "<ultNSU>", 1) )
					ll_Max_NSU		= Long(This.of_Get_Value_Tag(String(lbs_XML, EncodingANSI!) , "<maxNSU>", 1) )
					
					if is_id_log_teste_destinadas = 'S' then
						This.of_Grava_Log('status 137 encontrado, NSUs: ' + String(ll_Ultimo_NSU) + ' - ' + String(ll_Max_NSU) + '.')
					end if
					
					If ll_Ultimo_NSU < ll_Max_NSU Then
						If This.of_Grava_NSU(String(ll_Ultimo_NSU), al_Filial) Then
							SqlCa.of_Commit()
							SetNull(ls_Nulo)
							
							If Not of_localiza_documentos_por_filial(al_Filial, ls_Nulo) Then
								Return False
							End If
						Else
							Return False
						End If
					Else
						if is_id_log_teste_destinadas = 'S' then
							This.of_Grava_Log('status 137 encontrado, N$$HEX1$$e300$$ENDHEX$$o mudou NSU, verificar novamente daqui a 70 minutos.')
						end if
						
						If This.of_Grava_NSU(String(ll_Ultimo_NSU), al_Filial) Then
							SqlCa.of_Commit()
						Else
							Return False
						End If
					End If
					//----------------------------
					
					Return True
				ElseIf (is_Status <> '138') and (is_Status <> '') Then
					//MessageBox("Aviso: Status "+is_Status, This.of_Get_Value_Tag(String(lbs_XML, EncodingANSI!) , "<xMotivo>", 1) )
					This.of_Grava_Log("Aviso: Status "+ is_Status + This.of_Get_Value_Tag(String(lbs_XML, EncodingANSI!) , "<xMotivo>", 1))
					Return False
				End If
				
				DO WHILE Pos(String(lbs_XML, EncodingANSI!), '<docZip') > 0
					if is_id_log_teste_destinadas = 'S' then
						This.of_Grava_Log('Encontrou doczip dentro do xml de retorno.')
					end if
					
					ll_Pos1		= Pos(String(lbs_XML, EncodingANSI!), "<docZip", 1)
					ll_Pos2		= Pos(String(lbs_XML, EncodingANSI!), "</docZip>", 1)
					
					ll_Tamanho = (ll_Pos2 + LenA('</docZip>')) - ll_Pos1
				
					ls_Parte_XML	= Mid(String(lbs_XML, EncodingANSI!), ll_Pos1, ll_Tamanho)
					
					If LenA(ls_Parte_XML) > 0 Then
						 lbs_XML = ldc.of_replace_blob(lbs_XML,  ls_Parte_XML , '', 0)	//Limpa parte j$$HEX1$$e100$$ENDHEX$$ utilizada
					End If
					 
					 //Descompacta o arquivo
					 Try
						
						If Pos(ls_Parte_XML , 'schema="resNFe') > 0 Then //Resumo de NF-e (Destinadas)
							ll_Tipo = 1
							
							if is_id_log_teste_destinadas = 'S' then
								This.of_Grava_Log('Resumo de NFE.')
							end if
						ElseIf Pos(ls_Parte_XML, 'schema="procEventoNFe') > 0 Then //Eventos de Manifesta$$HEX2$$e700e300$$ENDHEX$$o do Destinat$$HEX1$$e100$$ENDHEX$$rio, Evento de Carta de Corre$$HEX2$$e700e300$$ENDHEX$$o
							ll_Tipo = 2
							if is_id_log_teste_destinadas = 'S' then
								This.of_Grava_Log('Manifesta$$HEX2$$e700e300$$ENDHEX$$o de destinat$$HEX1$$e100$$ENDHEX$$rio.')
							end if
						ElseIf Pos(ls_Parte_XML, 'schema="procNFe') > 0 Then //Nota Fiscal Completa 
							ll_Tipo = 3
							if is_id_log_teste_destinadas = 'S' then
								This.of_Grava_Log('Nf Completa.')
							end if
						ElseIf Pos(ls_Parte_XML, 'schema="resEvento') > 0 Then //Evento de Cancelamento, Eventos de Suframa, EPEC, Resumo de Eventos de CT-e Autorizado/Cancelado e Resumo de Eventos de MDF-e Autorizado/Cancelado
							ll_Tipo = 4
							if is_id_log_teste_destinadas = 'S' then
								This.of_Grava_Log('Eventos.')
							end if
						Else
							ll_Tipo = 5
							if is_id_log_teste_destinadas = 'S' then
								This.of_Grava_Log('Outros.')
							end if
						End If
						
						ls_NSU = Mid(ls_Parte_XML, Pos(ls_Parte_XML, 'NSU="')+5, 15)
						
						if is_id_log_teste_destinadas = 'S' then
							This.of_Grava_Log('NSU Doc: ' + ls_NSU + '.')
						end if
						
						ll_Pos1 = Pos(ls_Parte_XML, '.xsd">') + LenA( '.xsd">')
						ll_Pos2 = Pos(ls_Parte_XML, "</docZip>")
					
						ll_Tamanho = ll_Pos2 - ll_Pos1
					
						ls_Parte_XML = Mid(ls_Parte_XML, ll_Pos1, ll_Tamanho)
									
						If  This.of_descompacta_arquivo(ls_Parte_XML, ll_Tipo, Ref ls_XML_Decompactado)  Then
							If This.of_Grava_NSU(ls_NSU, al_Filial) Then
										
								If This.of_Grava_Destinadas(ls_XML_Decompactado, al_Filial, ll_Tipo, ls_NSU) Then
									SqlCa.of_Commit()
								Else
									Return False
								End If						
							Else
								Return False
							End If
						Else
							Return False
						End If
						
					Catch	( runtimeerror  lo_rte )
						//MessageBox (	"Erro", "Erro: "+lo_rte.GetMessage( ), StopSign!)
						This.of_Grava_Log("Erro: "+lo_rte.GetMessage())
					End Try
				LOOP
				
			LOOP WHILE is_Status <> '137' and ll_count <= 15
			
		End If	
			
	Catch	( runtimeerror  lo_rte_1 )
		//MessageBox (	"Erro", "Erro: "+lo_rte_1.GetMessage( ), StopSign!)
		This.of_Grava_Log("Erro: " + lo_rte_1.GetMessage())
	End Try
	
Finally
	Destroy(ldc)
End Try

Return True
end function

public function boolean of_documentos_destinados_chave_acesso (long al_filial, string as_chave_acesso, ref blob as_xml);Long	ll_Retorno
		

String 	ls_Cgc,&
			ls_UF,&
			ls_Cd_Uf



select 	nr_cgc, 
			b.cd_unidade_federacao
Into	:ls_Cgc,
		:ls_UF			
from filial a
inner join cidade b on b.cd_cidade = a.cd_cidade
where a.cd_filial = :al_Filial
Using SqlCa;

ls_Cd_Uf = gf_Codigo_UF(ls_UF)

as_XML = Blob(Space(800000))

ll_Retorno = ConsultarDistribuicaoDFeChave (ls_Cd_Uf, ls_UF, ls_Cgc, as_Chave_Acesso, Ref as_XML)


Return ll_Retorno = 1
end function

public function boolean of_verifica_teste_destinadas (ref string as_log);SELECT
	vl_parametro
INTO
	:is_id_log_teste_destinadas
FROM
	parametro_geral
WHERE
	cd_parametro	= 'ID_LOG_TESTE_DESTINADAS'
USING SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao consultar par$$HEX1$$e200$$ENDHEX$$metro ID_LOG_TESTE_DESTINADAS. ~r~rErro: ' + SQLCA.SQLErrText
		Return False
End Choose

SELECT
	cast(vl_parametro as integer)
INTO
	:ll_cd_filial_teste_destinadas
FROM
	parametro_geral
WHERE
	cd_parametro	= 'CD_FILIAL_TESTE_DESTINADAS'
USING SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao consultar par$$HEX1$$e200$$ENDHEX$$metro CD_FILIAL_TESTE_DESTINADAS. ~r~rErro: ' + SQLCA.SQLErrText
		Return False
End Choose

Return True



end function

public function boolean of_grava_destinadas (string as_xml, long al_filial, long al_tipo, string ls_nsu_nota);DateTime 	ldh_Emissao,&
				ldh_Recebimento

Decimal ldc_Vl_Nf

Long ll_Seq_Evento

String	ls_Chave_Acesso,&
		ls_Situacao_Nf,&
		ls_Cgc_Origem,&
		ls_Razao_Social_Origem,&
		ls_Inscricao_Estadual_Origem,&
		ls_Tipo_Nf,&
		ls_Emissao,&
		ls_Tipo_Evento,&
		ls_Correcao,&
		ls_Protocolo,&
		ls_Recebimento

//al_Tipo = 1 Notas Destinadas
//la_Tipo = 2 Eventos SEFAZ
//la_Tipo = 3 Nota Fiscal Completa 

//110111 = Cancelamento
//110110 = Carta de Corre$$HEX2$$e700e300$$ENDHEX$$o

ls_Tipo_Evento = This.of_Get_Value_Tag(as_XML, "<tpEvento>", 1) 

If (al_Tipo = 1) or (al_Tipo = 3) or (ls_Tipo_Evento = "110111") Then
		
	ls_Chave_Acesso 					= This.of_Get_Value_Tag(as_XML, "<chNFe>", 1) 
	ls_Cgc_Origem						= This.of_Get_Value_Tag(as_XML, "<CNPJ>", 1) 
	ls_Razao_Social_Origem			= This.of_Get_Value_Tag(as_XML, "<xNome>", 1) 
	ls_Inscricao_Estadual_Origem	= This.of_Get_Value_Tag(as_XML, "<IE>", 1) 
	ls_Tipo_Nf							= This.of_Get_Value_Tag(as_XML, "<tpNF>", 1)
	
	/*Conforme TecnoSpeed, em: https://atendimento.tecnospeed.com.br/hc/pt-br/articles/360016362153-Como-obter-as-notas-emitidas-contra-o-seu-CNPJ-Consulta-Destinadas-
	1: Uso autorizado no momento da consulta.
    2: Uso denegado.
    3: NF-e cancelada.*/
	ls_Situacao_Nf						= This.of_Get_Value_Tag(as_XML, "<cSitNFe>", 1) 
	
	If ls_Tipo_Evento = "110111" Then //Cancelamento
		ls_Emissao						= This.of_Get_Value_Tag(as_XML, "<dhEvento>", 1)
		ls_Situacao_Nf					= "3"
		
		If Not This.of_Envia_Email_Nf_Cancelada(ls_Chave_Acesso) Then
			Return False
		End If
	Else
		if ls_Situacao_Nf <> '1' and ls_Situacao_Nf <> '2' and ls_Situacao_Nf <> '3' then
			Return true
		end if
		
		ls_Emissao			= This.of_Get_Value_Tag(as_XML, "<dhEmi>", 1)
		ls_Recebimento		= This.of_Get_Value_Tag(as_XML, "<dhRecbto>", 1)
		
		ls_Recebimento		= Mid(ls_Recebimento, 9, 2)+"/"+Mid(ls_Recebimento, 6, 2)+"/"+Mid(ls_Recebimento, 1, 4)+" "+Mid(ls_Recebimento, 12, 8)
		
		ldh_Recebimento	= DateTime(ls_Recebimento)
	End If
	
	ls_Emissao							= Mid(ls_Emissao, 9, 2)+"/"+Mid(ls_Emissao, 6, 2)+"/"+Mid(ls_Emissao, 1, 4)+" "+Mid(ls_Emissao, 12, 8)
	ldh_Emissao							= DateTime(ls_Emissao)
	
	ldc_Vl_Nf								= dec(gf_Replace(This.of_Get_Value_Tag(as_XML, "<vNF>", 1), ".", ",", 0))
	
	If IsNull(ls_Recebimento) Or ls_Recebimento = "" Then
		SetNull(ldh_Recebimento)
	End If
	
	If Not This.of_Insere_Destinadas_Nfe (	ls_Chave_Acesso,&
														ls_Situacao_Nf,&
														al_Filial,&
														ls_Cgc_Origem,&
														ls_Razao_Social_Origem,&
														ls_Inscricao_Estadual_Origem,&
														ldh_Emissao,&
														ldc_Vl_Nf,&
														ls_Tipo_Nf,&
														ldh_Recebimento,&
														ls_NSU_Nota) Then
		Return False
	End If
	
ElseIf	ls_Tipo_Evento = "110110" Then //Carta de Corre$$HEX2$$e700e300$$ENDHEX$$o
	ls_Chave_Acesso 	= This.of_Get_Value_Tag(as_XML, "<chNFe>", 1) 
	ll_Seq_Evento		= Long(This.of_Get_Value_Tag(as_XML, "<nSeqEvento>", 1) )
	
	ls_Emissao			= This.of_Get_Value_Tag(as_XML, "<dhEvento>", 1)
	ls_Emissao			= Mid(ls_Emissao, 9, 2)+"/"+Mid(ls_Emissao, 6, 2)+"/"+Mid(ls_Emissao, 1, 4)+" "+Mid(ls_Emissao, 12, 8)
	ldh_Emissao			= DateTime(ls_Emissao)
	
	ls_Correcao			=  This.of_Get_Value_Tag(as_XML, "<xCorrecao>", 1)
	ls_Protocolo			=  This.of_Get_Value_Tag(as_XML, "<nProt>", 1)	
	
	If Not This.of_Insere_Destinadas_Cce (	al_Filial,&
														ls_Chave_Acesso,&
														ll_Seq_Evento,&
														ldh_Emissao,&
														ls_Correcao,&
														ls_Protocolo) Then
		Return False
	End If
	
	If Not This.of_Envia_Email_CCe(ls_Chave_Acesso)	Then
		Return False
	End If
End If

Return True
end function

public function boolean of_insere_destinadas_nfe (string as_chave_acesso, string as_situacao_nf, long al_filial, string as_cgc_origem, string as_razao_social_origem, string as_inscricao_estadual_origem, datetime adh_emissao, decimal adc_vl_nf, string as_tipo_nf, datetime adh_recebimento, string ls_nsu_nota);Long	ll_Qtde,&
		ll_NSU

String	ls_Cgc_Destino

ll_NSU = Long(ls_NSU_Nota)

Select count(*)
Into :ll_Qtde
From nfe_destinadas
Where de_chave_acesso = :as_Chave_Acesso
	and id_situacao_nf		= :as_Situacao_Nf
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_Grava_Log("Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o registro na tabela 'nfe_destinadas' . " + SqlCa.sqlErrText)
	SqlCa.of_Rollback()
	Return False
End If
	
If ll_Qtde = 0 Then
	
	If Not This.of_cgc_filial(al_Filial, Ref ls_Cgc_Destino) Then
		SqlCa.of_Rollback()
		Return False
	End If
	
	Insert Into nfe_destinadas(
		de_chave_acesso,
		id_situacao_nf,
		nr_cgc_origem,
		nm_razao_social_origem,
		nr_inscricao_estadual_origem,
		dh_emissao,
		vl_nf,
		id_tipo_nf,
		id_situacao_manifestacao,
		nr_cgc_destino,
		dh_recebimento,
		nr_nsu_distribuicao_dfe)
	Values(
		:as_Chave_Acesso,
		:as_Situacao_Nf,
		:as_Cgc_Origem,
		:as_Razao_Social_Origem,
		:as_Inscricao_Estadual_Origem,
		:adh_Emissao,
		:adc_Vl_Nf,
		:as_Tipo_Nf,
		'0',
		:ls_Cgc_Destino,
		:adh_Recebimento,
		:ll_NSU)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Log("Erro ao inserir o registro na tabela 'nfe_destinadas' . " + SqlCa.sqlErrText)
		SqlCa.of_Rollback()
		Return False
	End If
End If

Return True
end function

public function boolean of_grava_destinadas (string as_xml, long al_filial, long al_tipo);string ls_nulo

setnull(ls_nulo)

return of_grava_destinadas(as_xml, al_filial, al_tipo, ls_nulo)
end function

public function boolean of_consultar_nf (string as_chave_acesso, ref string as_retorno);String ls_Uf

try
	If Not This.of_uf_autorizadora(as_Chave_Acesso, Ref ls_Uf, Ref as_retorno) Then
		Return False
	End If
	
	as_Retorno = Space(500000)
	
	If ConsultarNF(as_Chave_Acesso, ls_Uf, Ref as_Retorno) = 1 Then
		Return True
	Else
		Return False
	End If
catch (RunTimeError RTE)
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', RTE.GetMessage())
	Return False
end try
end function

public function boolean of_uf_autorizadora (string as_chave_acesso, ref string as_uf, ref string as_erro);Long ll_Codigo_Uf

ll_Codigo_Uf = Long(Mid(as_Chave_Acesso , 1, 2))

  Choose Case ll_Codigo_Uf
	Case 11
		as_Uf = 'RO'
	Case 12
		as_Uf = 'AC'
	Case 13
		as_Uf = 'AM'
	Case 14
		as_Uf = 'RR'
	Case 15
		as_Uf = 'PA'
	Case 16
		as_Uf = 'AP'
	Case 17
		as_Uf = 'TO'
	Case 21
		as_Uf = 'MA'
	Case 22
		as_Uf = 'PI'
	Case 23
		as_Uf = 'CE'
	Case 24
		as_Uf = 'RN'
	Case 25
		as_Uf = 'PB'
	Case 26
		as_Uf = 'PE'
	Case 27
		as_Uf = 'AL'
	Case 28
		as_Uf = 'SE'
	Case 29
		as_Uf = 'BA'
	Case 31
		as_Uf = 'MG'
	Case 32
		as_Uf = 'ES'
	Case 33
		as_Uf = 'RJ'
	Case 35
		as_Uf = 'SP'
	Case 41
		as_Uf = 'PR'
	Case 42
		as_Uf = 'SC'
	Case 43
		as_Uf = 'RS'
	Case 50
		as_Uf = 'MS'
	Case 51
		as_Uf = 'MT'
	Case 52
		as_Uf = 'GO'
	Case 53
		as_Uf = 'DF'
	Case else
		as_Erro = 'UF n$$HEX1$$e300$$ENDHEX$$o localizada'
		Return False
End Choose
  
  Return True
end function

public function boolean of_fuso_horario (string as_uf, ref string as_fuso_horario, ref string as_mensagem_log);
String ls_Id_Horario_Verao

as_Mensagem_Log = ""

select vl_parametro
into :ls_Id_Horario_Verao
from parametro_geral
where cd_parametro = 'ID_HORARIO_VERAO_NFE'
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1
		as_Mensagem_Log = "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro ID_HORARIO_VERAO_NFE: "+ SqlCa.SQLErrText
		Return False
	Case 100
		as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro ID_HORARIO_VERAO_NFE: "+ SqlCa.SQLErrText
		Return False					
End Choose		

as_Fuso_Horario = ""
If ls_Id_Horario_Verao = "S" Then
	as_Fuso_Horario = "-02:00"
Else
    as_Fuso_Horario = "-03:00"
End If

Return True

end function

public function boolean of_envia_manifestacao_destinatario_novo (integer ai_evento, string as_chave_nota, string as_cnpj, string as_justificativa, string as_orgao, string as_uf, string as_data_evento, ref string as_retorno);String 	ls_Fuso_Horario

Try
	If Not This.of_fuso_horario(as_UF, Ref ls_Fuso_Horario, Ref as_Retorno) Then
		Return False
	End If
	
	as_Retorno = Space(5000)
	
	If EnviaManifestacaoDestinatario_Novo(	ai_Evento,&
														as_Chave_Nota,&
														as_CNPJ,&
														as_Justificativa,&
														as_Data_Evento,&
														ls_Fuso_Horario,&
														as_Orgao,&
														as_UF,&
														Ref as_Retorno) = 1 Then
														
		Return True
	Else
		Return False
	End If
Catch ( runtimeerror  lo_rte )
	as_Retorno = "Ocorreu erro ao enviar manifesta$$HEX2$$e700e300$$ENDHEX$$o do destinat$$HEX1$$e100$$ENDHEX$$ro: "+lo_rte.GetMessage()
	Return False
End Try
end function

public function boolean of_valida_consumo_indevido (string as_tipo, long al_cd_filial, ref string as_erro);DateTime	ldt_dh_fim_consumo_indevido, ldt_agora
String			ls_vl_parametro


Choose Case as_tipo
	Case 'DESTINADAS'
		SELECT
			vl_parametro
		INTO
			:ls_vl_parametro
		FROM
			parametro_loja pl
		WHERE
			pl.cd_parametro = 'DH_FIM_CONSUMO_INDEVIDO_DEST'
			AND pl.cd_filial = :al_cd_filial;
			
		Choose Case SQLCA.SQLCode
			Case -1
				as_erro = 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro:  DH_FIM_CONSUMO_INDEVIDO_DEST.~r~rErro: ' + SQLCA.SQLErrText
				Return False
			Case 100
				Return True
			Case 0
				ldt_dh_fim_consumo_indevido = DateTime(ls_vl_parametro)
				ldt_agora	= gf_getserverdate()
				
				if IsNull(ldt_dh_fim_consumo_indevido) or ldt_dh_fim_consumo_indevido <= ldt_agora then
					Return True
				else
					as_erro	= 'Filial ' + String(al_cd_filial) + ' est$$HEX1$$e100$$ENDHEX$$ registrando consumo indevido at$$HEX1$$e900$$ENDHEX$$: ' + ls_vl_parametro + '. Favor aguardar.'
					Return False
				end if
		End Choose
End Choose
		
end function

public function boolean of_grava_parametro_consumo_indevido (string as_tipo, long al_cd_filial, ref string as_erro);DateTime	ldt_dh_fim_consumo_indevido, ldt_agora, ldt_prox_dh_fim_consumo_indevido
String			ls_vl_parametro, ls_prox_dh_fim_consumo_indevido


Choose Case as_tipo
	Case 'DESTINADAS'
		select dateadd(hour, 1, getdate())
		into :ldt_prox_dh_fim_consumo_indevido
		from dummy;
		
		ls_prox_dh_fim_consumo_indevido = String(ldt_prox_dh_fim_consumo_indevido)
		
		If IsNull(ls_prox_dh_fim_consumo_indevido) or Trim(ls_prox_dh_fim_consumo_indevido) = '' Then
			as_erro = 'Gera$$HEX2$$e700e300$$ENDHEX$$o de data inv$$HEX1$$e100$$ENDHEX$$lida para o par$$HEX1$$e200$$ENDHEX$$metro  DH_FIM_CONSUMO_INDEVIDO_DEST para a filial: ' + String(al_cd_filial) + '.'
			Return False
		End If
		
		SELECT
			vl_parametro
		INTO
			:ls_vl_parametro
		FROM
			parametro_loja pl
		WHERE
			pl.cd_parametro = 'DH_FIM_CONSUMO_INDEVIDO_DEST'
			AND pl.cd_filial = :al_cd_filial;
			
		Choose Case SQLCA.SQLCode
			Case -1
				as_erro = 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro:  DH_FIM_CONSUMO_INDEVIDO_DEST para registro de novo consumo indevido.~r~rErro: ' + SQLCA.SQLErrText
				Return False
			Case 100
				INSERT INTO 
					parametro_loja 
				SELECT
					:al_cd_filial,
					'DH_FIM_CONSUMO_INDEVIDO_DEST',
					:ls_prox_dh_fim_consumo_indevido;
					
				If SQLCA.SQLCode = -1 Then
					as_erro = 'Erro ao inserir registro do par$$HEX1$$e200$$ENDHEX$$metro:  DH_FIM_CONSUMO_INDEVIDO_DEST (' + ls_prox_dh_fim_consumo_indevido + ') na tabela parametro_loja para a filial: ' + String(al_cd_filial) + '.~r~rErro: ' + SQLCA.SQLErrText
					Return False
				End If
			Case 0
				UPDATE
					parametro_loja
				SET
					vl_parametro = :ls_prox_dh_fim_consumo_indevido
				WHERE
					cd_parametro	= 'DH_FIM_CONSUMO_INDEVIDO_DEST'
					AND cd_filial = :al_cd_filial;
					
				If SQLCA.SQLCode = -1 Then
					as_erro = 'Erro ao atualizar registro do par$$HEX1$$e200$$ENDHEX$$metro:  DH_FIM_CONSUMO_INDEVIDO_DEST (' + ls_prox_dh_fim_consumo_indevido + ') na tabela parametro_loja para a filial: ' + String(al_cd_filial) + '.~r~rErro: ' + SQLCA.SQLErrText
					Return False
				End If
		End Choose
End Choose
				
end function

public function string of_get_value_tag (string as_xml, string as_tag, integer ai_pos);Integer li_Esp, li_i, li_Inicio, li_Fim
string  ls_Result, ls_Xml_Aux

as_Tag = gf_Replace(as_Tag, '/', '', 0)
as_Tag = gf_Replace(as_Tag, '<', '', 0)
as_Tag = gf_Replace(as_Tag, '>', '', 0)
If Pos(' ', as_Tag) > 0 Then 
	li_Esp = Pos(' ',as_Tag)
Else
	li_Esp = LenA(as_Tag)
End If	

li_Inicio = 1
ls_Xml_Aux = as_xml
for li_i = 1 to ai_Pos 
	 ls_Result = Mid(	ls_Xml_Aux,  &
	 						Pos(ls_Xml_Aux, '<'+as_tag+'>')+LenA(as_tag)+2, &
	 						Pos(ls_Xml_Aux, '</'+as_tag+'>') - (Pos(ls_Xml_Aux, '<'+as_tag+'>')+LenA(as_tag)+2))
	ls_Xml_Aux = Mid(ls_Xml_Aux, Pos(ls_Xml_Aux, '</'+as_tag+'>') +  LenA(as_tag)+3)
Next
 Return ls_Result
end function

public function boolean of_descompacta_arquivo (string as_arquivo_compactado, long al_tipo, ref string as_arquivo_descompactado);Long ll_Retorno

String ls_Nulo

SetNull(ls_Nulo)

//If al_Tipo <> 3 Then
	as_Arquivo_Descompactado = Space(599999)
	ll_Retorno =  DescompactarXMLZip(as_Arquivo_Compactado, Ref as_Arquivo_Descompactado)
	
	If ll_Retorno <> 1 Then 	Return False
//End If

If LenA(as_Arquivo_Descompactado) > 599999 Then
	as_Arquivo_Descompactado = ls_Nulo
End If

Return True

end function

public function boolean of_grava_nsu (string as_nsu, long al_filial);Long 	ll_Nsu,&
		ll_Qtde

String ls_Erro

ll_Nsu = Long(as_NSU)

Select Count(*)
Into :ll_Qtde
From nfe_destinadas_nsu_historico
Where cd_filial			= :al_Filial
	and nr_ultimo_nsu	= :ll_Nsu
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	//MessageBox("Erro", "Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o NSU na tabela 'nfe_destinadas_nsu_historico': "+SqlCa.sqlErrText)
	This.of_Grava_Log("Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o NSU na tabela 'nfe_destinadas_nsu_historico': "+SqlCa.sqlErrText)
	Return False
End If

If ll_Qtde = 0 Then
	Insert nfe_destinadas_nsu_historico(
		cd_filial,
		nr_ultimo_nsu,
		dh_registro)
	values(
		:al_Filial,
		:ll_Nsu,
		GetDate())
	Using SqlCa;	
	
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Log("Erro ao gravar o NSU da filial "+String(al_Filial)+"." + SqlCa.sqlErrText)
		SqlCa.of_Rollback()
//		MessageBox("Erro", ls_Erro)
		Return False
	End If
else
	update
		nfe_destinadas_nsu_historico
	set
		dh_registro = getdate()
	where 
		cd_filial = :al_filial
		and nr_ultimo_nsu = :ll_nsu;
		
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Log("Erro ao atualizar o NSU da filial "+String(al_Filial)+"." + SqlCa.sqlErrText)
		SqlCa.of_Rollback()
//		MessageBox("Erro", ls_Erro)
		Return False
	End If
End If

Return True
end function

on uo_ge614_eventos_sefaz.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge614_eventos_sefaz.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;Destroy(imle_XML)
end event

event constructor;imle_XML = Create MultilineEdit
end event

