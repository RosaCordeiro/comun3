HA$PBExportHeader$uo_ge039_nfce.sru
forward
global type uo_ge039_nfce from nonvisualobject
end type
end forward

global type uo_ge039_nfce from nonvisualobject
end type
global uo_ge039_nfce uo_ge039_nfce

type prototypes
Function integer NFCe_ConfiguraParametros(	String a_UF,&
															String a_CNPJ,&
															String a_VersaoManua)LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_ConfiguraParametros;Ansi"

Function integer NFCe_Cabecalho(String a_versao,&
											String a_cUF,&
											String a_cNF,&
											String a_natOp,&
											String a_indPag,&
											String a_mod,&
											String a_serie,&
											String a_nNF,&
											String a_dhEmi,&
											String a_tpNF,&
											String a_idDest,&
											String a_cMunFG,&
											String a_tpImp,&
											String a_tpEmis,&
											String a_cDV,&
											String a_tpAmb,&
											String a_finNFe,&
											String a_indFinal,&
											String a_indPres,&
											String a_procEmi,&
											String a_verProc,&
											String a_dhCont,&
											String a_xJust, &
											String a_indIntermed, &
											String a_CPF_transp, &
											String a_CNPJ_transp, &
											String a_Nome_transp, &
											String a_Ender_transp, &
											String a_Mun_transp, &
											String a_UF_transp) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Cabecalho;Ansi"

Function integer NFCe_Emitente(	String  a_CNPJ,&
											String a_xNome,&
											String a_xFant,&
											String a_xLgr,&
											String a_nro,&
											String a_xCpl,&
											String a_xBairro,&
											String a_cMun,&
											String a_xMun,&
											String a_UF,&
											String a_CEP,&
											String a_fone,&
											String a_IE,&
											String a_IEST,&
											String a_IM,&
											String a_CNAE,&
											String a_CRT) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Emitente;Ansi"

Function integer NFCe_Destinatario(	String a_CNPJ,&
												String a_CPF,&
												String a_idEstrangeiro,&
												String a_xNome,&
												String a_xLgr,&
												String a_nro,&
												String a_xCpl,&
												String a_xBairro,&
												String a_cMun,&
												String a_xMun,&
												String a_UF,&
												String a_CEP,&
												String a_fone,&
												String a_indIEDest,&
												String a_IE,&
												String a_ISUF,&
												String a_IM,&
												String a_email) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Destinatario;Ansi"

Function integer NFCe_Destinatario_Resumido(	String a_CNPJ,&
												String a_CPF,&
												String a_idEstrangeiro,&
												String a_xNome,&
												String a_indIEDest,&
												String a_IE,&
												String a_ISUF,&
												String a_IM,&
												String a_email) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Destinatario_Resumido;Ansi"												

Function integer NFCe_Item(	String a_nItem,&
										String  a_cProd,&
										String  a_cEAN,&
										String  a_xProd,&
										String  a_NCM,&
										String  a_CFOP,&
										String  a_uCom,&
										String  a_qCom,&
										String  a_vUnCom,&
										String  a_vProd,&
										String  a_cEANTrib,&
										String  a_uTrib,&
										String  a_qTrib,&
										String  a_vUnTrib,&
										String  a_vDesc,&
										String  a_indTot,&
										String  a_vTotTrib,&										
										String  a_orig,&
										String  a_CST,&										
                   						String  a_modBC, &
                   						String  a_vBC, &
                   						String  a_pICMS, &
                   						String  a_vICMS, &
										String  a_CSTPIS, &
                   						String  a_vBCPIS, &
                   						String  a_pPIS, &
                   						String  a_vPIS, &
                   						String  a_CSTCOFINS, &
                   						String  a_vBCCOFINS, &
                   						String  a_pCOFINS, &
                   						String  a_vCOFINS, &
										String  a_CEST, &
										String  a_pRedBCEfet, &
										String  a_vBCEfet, &
										String  a_pICMSEfet, &
                   						String  a_vICMSEfet,&
										String  a_benefiico, &
										String  a_vIcmsDesonerado,&
										String  a_idMotivoDesoneracao) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Item;Ansi"

Function integer NFCe_Totais(	String  a_vBC,&
										String  a_vICMS,&
										String  a_vICMSDeson,&
										String  a_vBCST,&
										String  a_vST,&
										String  a_vProd,&
										String  a_vFrete,&
										String  a_vSeg,&
										String  a_vDesc,&
										String  a_vII,&
										String  a_vIPI,&
										String  a_vPIS,&
										String  a_vCOFINS,&
										String  a_vOutro,&
										String  a_vNF,&
										String  a_vTotTrib,&
										String  a_modFrete,&
										String  a_InfAdFisco,&
										String  a_InfAdCont) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Totais;Ansi"

Function integer NFCe_FormasPagamento(String  a_tPag,&
													   String  a_vPag,&
													   String  a_tBandiera,&
													   String  a_tAutorizacao,&
													   String  a_tCNPJ,&
													   String  a_vTroco, &
													   String  a_tCNPJInter, &
													   String  a_tIdentCad) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_FormasPagamento;Ansi"
										
Function integer NFCe_SalvarNota(Ref String a_ChaveNota, &
												  String a_EnviaReponsavel) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_SalvarNota;Ansi"

Function integer NFCe_AssinarNota() LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_AssinarNota;Ansi"

Function integer NFCe_ValidarLoteParaEnvio() LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_ValidarLoteParaEnvio;Ansi"

Function integer NFCe_EnviarSEFAZ(	Ref String a_ChaveNota,&
												Ref String a_CStatus,&
												Ref String a_Motivo,&
												Ref String a_dhRecbto,&
												Ref String a_nProt) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_EnviarSEFAZ;Ansi"
												
Function integer NFCe_Imprimir(	String a_ChaveNota,&
											String a_DirretorioXML,&
											String a_Impressora,&
											String a_Contingecia,&
											String a_ModeloRTM,&
											String a_Valor_Recebido,&
											String a_Valor_Troco,&
											Ref String a_ChaveRetorno) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Imprimir;Ansi"												

Function integer NFCe_Cancelar(	String a_ChaveNota,&
											String a_NrProtocolo,&
											String a_Justificativa,&
											String a_DataHoraEvento,&
											Integer a_SequenciaEvento,&
											String a_FusoHorario,&
											String a_IdLote,&
											Ref String a_Retorno, &
											Ref String a_Status, &
											Ref String a_Motivo, &
											Ref String a_dhRegEvento, &
											Ref String a_nrProcotocoloCanc) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Cancelar;Ansi"

Function integer NFCe_Envia_email(	String a_ChaveNota,&
											String a_email) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Envia_email;Ansi"												

Function integer NFCe_Consulta(	String a_ChaveNota,&
											Ref String a_NrProtocolo, &
											Ref String a_Retorno, &
											Ref String a_Status, &
											Ref String a_Motivo, &
											Ref String a_dhRegEvento, &
											Ref String a_ChaveRec) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Consulta;Ansi"

Function integer NFCe_Inutilizar(	String a_Ano,&
											String a_CNPJ,&
											String a_Modelo,&
											String a_Serie,&
											String a_NFIni,&
											String a_NFFim,&
											String a_Justificativa,&
											Ref String a_Retorno, &
											Ref String a_Status, &
											Ref String a_Motivo, &
											Ref String a_dhRegEvento, &
											Ref String a_Protocolo) LIBRARY "C:\sistemas\dll\nfce\NFCe.dll" alias for "NFCe_Inutilizar;Ansi"

end prototypes

type variables

CONSTANT INTEGER COLUNAS = 48

STRING id_CNAE

STRING nr_nfce
STRING cd_status_nfce
STRING cd_motivo_nfce
STRING ivs_xml_nfce
STRING dt_data_nfce
STRING cd_protocolo_nfce
STRING de_serie_nfce_pdv
STRING id_homologacao
STRING nm_impressora_nfce
STRING ivs_cod_barras
STRING dt_nova_NT
STRING nr_versao_manual
STRING id_atualiza_tls
STRING id_token_matriz
STRING nr_token_matriz

DateTime dt_data_recebimento

Long nr_job_impressao

Boolean ivb_cod_barras
Boolean ivb_contingencia
Boolean ivb_Porta_Aberta
end variables

forward prototypes
public function boolean of_abreporta ()
public function boolean of_efetua_pagamento (string ps_codigo_pagamento[], decimal pd_valor[], string ps_cnpj_cartao, string ps_bandeira_cartao, string ps_autorizacao_cartao, string ps_credenciadora)
public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pd_valor)
public function boolean of_inicializa_comprovante (string ps_tipo, string ps_recebimento, string ps_mensagem, string ps_forma_pgto, decimal pd_valor, long pl_parcelas, string ps_nf)
public function boolean of_imprime_texto (string ps_texto)
public function boolean of_desconto_item (long pl_item, decimal pdc_desconto, decimal pdc_valor)
public function boolean of_desconto_subtotal (string ps_texto, decimal pdc_valor)
public subroutine of_teste ()
public function boolean of_codigo_uf (string ps_uf, ref string ps_codigo_uf)
public function boolean of_emitente ()
public function boolean of_assina_valida ()
public function boolean of_finaliza_impressao_texto ()
public function boolean of_dados_nfce (string ps_caixa, ref long pl_sequencial, ref long pl_caixa)
public function boolean of_cancela_nfce (string ps_chave, string ps_protocolo, string ps_justificativa, ref string ps_protocolo_cancelamento, ref datetime pdt_data_cancelamento)
public function boolean of_comprovante_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor)
public function string of_retira_caracteres (string ps_texto)
public function boolean of_email_xml (string ps_chave, string ps_email, string ps_modo)
public function boolean of_envia_xml_ftp (string ps_chave)
public function boolean of_busca_xml_ftp (string ps_chave)
public function boolean of_exclui_xml (string ps_chave)
public subroutine of_verifica_fonte ()
public function boolean of_consulta_nfce (string ps_chave, ref string ps_protocolo, ref string ps_retorno, ref string ps_status, ref string ps_motivo, ref datetime pdt_data_rec, ref string ps_chave_rec)
public function boolean of_sangria (decimal pdc_valor)
public function boolean of_suprimento (decimal pdc_valor)
public function boolean of_carrega_data_nt ()
public function boolean of_destinatario (string ps_cpf_cgc, string ps_codigo_cliente, string ps_nm_cliente, string ps_endereco, string ps_nr_endereco, string ps_bairro, string ps_cidade_ibge, string ps_nm_cidade, string ps_uf, string ps_email_xml, boolean pb_programa_governo, boolean pb_mesmo_cpf)
public function boolean of_imprime (string ps_texto)
public function boolean of_fecha_nota (string ps_inf_complementares, string ps_campo_fisco, string ps_tempo_fisco, string ps_formato_impressao, string ps_tipo_envio, string ps_email_envio, ref string ps_codigo_nota, ref string ps_status, ref string ps_motivo_fechar, ref string ps_xml, ref datetime pdt_data_recebimento, ref string ps_protocolo, ref long pl_retorno, decimal pdc_vl_recebido, decimal pdc_troco, string ps_emite_em_contingencia)
public subroutine of_atualiza_dlls ()
public subroutine of_atualiza_certificado ()
public function boolean of_imprime_nota (string ps_chave_nota, string ps_protocolo, string ps_formato_cupom, string ps_contingencia, string ps_modo, decimal pdc_vl_recebido, decimal pdc_vl_troco, ref string ps_chave_retorno)
public function boolean of_grava_rejeicao (string ps_chave_nota, string ps_codigo_rejeicao)
public function boolean of_totais_nfce (decimal pd_total_bc, decimal pd_total_icms, decimal pd_total_bcst, decimal pd_total_st, decimal pd_total_produtos, decimal pd_total_frete, decimal pd_total_seg, decimal pd_total_desc, decimal pd_total_ii, decimal pd_total_ipi, decimal pd_total_pis, decimal pd_total_cofins, decimal pd_total_outros, decimal pd_total_nf, decimal pd_total_tributos, string ps_mod_frete, string ps_formas_pgto[], decimal ps_valores_pgto[], decimal pd_troco, ref string ps_chave_nota, string ps_dados_tef[], string ps_envia_responsavel, decimal ps_total_icms_desonerado, string ps_inf_adicional, string ps_inf_fisco, string ps_cnpj_intermediario, string ps_codigo_interm)
public function boolean of_cabecalho_nfce (string ps_nr_nf, string ps_forma_pagamento, string ps_natureza_operacao, datetime pdt_emissao, string ps_tipo_impressao, string ps_forma_emissao, string ps_finalidade, string ps_consumidor, string ps_ind_presenca, string ps_intermediador, string ps_cpf_transp, string ps_cnpj_transp, string ps_nome_transp, string ps_end_transp, string ps_cidade_transp, string ps_uf_transp)
public function boolean of_registra_item_nfce (long pl_item, string ps_produto, string ps_codigo_barras, string ps_descricao, long pl_ncm, long pl_cfop, string ps_unidade_medida, long pl_quantidade, decimal pd_valor_unitario, string ps_regra_calculo, decimal pd_valor_desconto, decimal pd_valor_outros, decimal pd_total_tributos, string ps_origem, string ps_cst_tributacao_icms, decimal pd_aliquota_icms, string ps_tributacao_pis_cofins, string ps_inf_adicionais, decimal pd_preco_praticado, ref decimal pd_total_icms, ref decimal pd_total_base_icms, string ps_cest, string ps_tributacao_icms_cadastro, decimal pd_red_bc_icms_efe, decimal pd_bc_icms_efe, decimal pd_icms_efe, decimal pd_valor_icms_efe, string ps_beneficio, integer pi_nr_item, decimal pd_vl_icms_desonerado, string ps_id_motivo_desoneracao, string ps_codigo_sap, string ps_cst_pis_cofins)
public function boolean of_inutiliza_nfce (long pl_filial, string ps_serie, long pl_nr_inicial, long pl_nr_final, string ps_justificativa, ref string ps_erro)
public function boolean of_abre_doc (string ps_uf_filial, string ps_cnpj_filial)
public function boolean of_abre_doc ()
public function boolean of_carrega_parametro_nfc_matriz (long pl_filial)
public function boolean of_abre_porta_inutilizacao (long pl_filial, string ps_uf, string ps_cnpj, long pl_ambiente)
end prototypes

public function boolean of_abreporta ();Long ll_Retorno
String ls_INI
String ls_INI_nfce = "C:\Sistemas\CL\NFCe\nfceConfig.ini"
String ls_Diretorio_log = "C:\Sistemas\CL\NFCe\log\"
String ls_verificacao = "C:\Sistemas\CL\NFCe\Templates\vm60\Conversor\NFCeDataSets.xml"
String ls_ambiente_nfce
String ls_token
String ls_id_token
String ls_arquivos[]
String ls_serv_mail
String ls_Imagem
Boolean lb_nova_nt

If This.ivb_Porta_Aberta Then Return True

ls_INI  = gvo_Aplicacao.ivs_Arquivo_INI

ls_ambiente_nfce = ProfileString(ls_INI, "ECF", "Homologacao_NFCE","")
This.nm_impressora_nfce = ProfileString(ls_INI, "ECF" , "NomeImpressora" , "")

If Trim(ls_ambiente_nfce) = 'S' Then //1 = Normal   -  2 = Homologcao
	This.id_homologacao = '2'
Else
	This.id_homologacao = '1'
End If

If FileExists(ls_INI_nfce) Then
	SetProfileString(ls_INI_nfce, "NFCE", "UF", gvo_parametro.ivs_uf_filial)
	SetProfileString(ls_INI_nfce, "NFCE", "CNPJ", gvo_parametro.nr_cgc)	
	ls_token = ProfileString(ls_INI_nfce, "DANFCE", "TokenNFce","")	
	If IsNull(ls_token) Or Trim(ls_token) = "" Or (ls_token <> gvo_parametro.nr_csc_token) Then
		SetProfileString(ls_INI_nfce, "DANFCE", "TokenNFce", gvo_parametro.nr_csc_token)			
	End If
	ls_id_token = ProfileString(ls_INI_nfce, "DANFCE", "idTokenNFce","")
	If IsNull(ls_id_token) Or Trim(ls_id_token) = "" Or (ls_id_token <> gvo_parametro.nr_token_NFCE) Then
		SetProfileString(ls_INI_nfce, "DANFCE", "idTokenNFce", gvo_parametro.nr_token_NFCE)			
	End If
	
	/*      ** Quando existir nova NT descomentar e alterar a nota data.  **
	If IsDate(This.dt_nova_NT) Then  
		If gf_getserverdate() >= DateTime(This.dt_nova_NT) Then
			lb_nova_nt = True
			If Not FileExists(ls_verificacao) Then
				Messagebox("NFC-e","Diretorios e arquivos da nova NT n$$HEX1$$e300$$ENDHEX$$o existem no PDV!"+&
							  " Avise o SAF.", StopSign!)	
				Return False				
			End If
		End If
	End If 
	
	If lb_nova_nt Then
		SetProfileString(ls_INI_nfce, "NFCE", "VersaoManual", "6.0")
		SetProfileString(ls_INI_nfce, "DANFCE", "ModeloRetrato", "C:\Sistemas\CL\NFCe\Templates\vm60\Danfce\retrato.rtm")
		SetProfileString(ls_INI_nfce, "DANFCE", "ModeloDanfce", "C:\Sistemas\CL\NFCe\Templates\vm60\Danfce\retrato.rtm")		
	Else
		SetProfileString(ls_INI_nfce, "NFCE", "VersaoManual", "5.0b")
		SetProfileString(ls_INI_nfce, "DANFCE", "ModeloRetrato", "C:\Sistemas\CL\NFCe\Templates\Vm50b\Danfce\retrato.rtm")
		SetProfileString(ls_INI_nfce, "DANFCE", "ModeloDanfce", "C:\Sistemas\CL\NFCe\Templates\Vm50b\Danfce\retrato.rtm")		
	End If	
	*/
	SetProfileString(ls_INI_nfce, "NFCE", "VersaoManual", "6.0")
	SetProfileString(ls_INI_nfce, "DANFCE", "ModeloRetrato", "C:\Sistemas\CL\NFCe\Templates\vm60\Danfce\retrato.rtm")
	SetProfileString(ls_INI_nfce, "DANFCE", "ModeloDanfce", "C:\Sistemas\CL\NFCe\Templates\vm60\Danfce\retrato.rtm")			
	
	ls_serv_mail = ProfileString(ls_INI_nfce, "MAIL" , "Servidor" , "")
	If IsNull(ls_serv_mail) Or Trim(ls_serv_mail) = '' Or Trim(ls_serv_mail) = "10.0.0.15" Then
		SetProfileString(ls_INI_nfce, "MAIL", "Servidor", "172.19.2.100")
		SetProfileString(ls_INI_nfce, "MAIL", "EmailRemetente", "nfe@clamed.com.br")
		SetProfileString(ls_INI_nfce, "MAIL", "Assunto", "XML CFe - CIA LATINO AMERICANA DE MEDICAMENTOS")
		SetProfileString(ls_INI_nfce, "MAIL", "Mensagem", "'O arquivo est$$HEX1$$e100$$ENDHEX$$ anexo.'")
		SetProfileString(ls_INI_nfce, "MAIL", "Usuario", "scanner@clamedlocal.com.br")
		SetProfileString(ls_INI_nfce, "MAIL", "Senha", "he3-sWetHlKl")
		SetProfileString(ls_INI_nfce, "MAIL", "Autenticacao", "1")
		SetProfileString(ls_INI_nfce, "MAIL", "Porta", "587")
	End If	
	
	If Trim(Upper(gvo_parametro.id_rede_filial)) = 'FA' Then
		ls_Imagem = "farmagora"
	Else
		ls_Imagem = Trim(Upper(gvo_parametro.id_rede_filial))
	End If
	
	IF FileExists("C:\Sistemas\CL\Arquivos\Imagens\" + ls_imagem + ".jpg") Then
		SetProfileString(ls_INI_nfce, "DANFCE", "LogotipoEmitente", "C:\Sistemas\CL\Arquivos\Imagens\" + ls_imagem + ".jpg")			
	Else
		SetProfileString(ls_INI_nfce, "DANFCE", "LogotipoEmitente", "")			
	End If
		
Else
	Messagebox("NFC-e","Arquivo INI do NFCe n$$HEX1$$e300$$ENDHEX$$o existe no PDV!"+&
				  " Avise o SAF.", StopSign!)	
	Return False
End If

If IsNull(This.nm_impressora_nfce) Or Trim(This.nm_impressora_nfce) = '' Then
	Messagebox("NFC-e","Nome da Impressora NFC-e n$$HEX1$$e300$$ENDHEX$$o definida no INI do Caixa!"+&
				  " Avise o SAF.", StopSign!)
	Return False
Else
	ll_retorno = PrintSetPrinter (This.nm_impressora_nfce)
	If ll_retorno <> 1 Then
		Messagebox("NFC-e","Impressora :" + This.nm_impressora_nfce + " n$$HEX1$$e300$$ENDHEX$$o encontrada no Windows!" +&
					  " Avise o TI - Infra.", StopSign!)			
		Return False
	End If
End If

//Limpa diretorio de logs da NFCe no PDV, quando possuir mais de 500 arquivos o diretorio $$HEX1$$e900$$ENDHEX$$ limpo.
gf_dir_list( ls_Diretorio_log, '*.xml', 0+1, Ref ls_Arquivos )
If UpperBound( ls_Arquivos ) > 500 Then
	gf_limpa_diretorio( ls_Diretorio_log )
End If

//Seta os protocolos de comunica$$HEX2$$e700e300$$ENDHEX$$o TLS 1.2, devido a migra$$HEX2$$e700e300$$ENDHEX$$o dos NFCe para 4.00, $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio o uso desse protocolo
//Seta SSL 3.0
//Seta TLS 1.0
//Seta TLS 1.2
If Upper(This.id_atualiza_tls) = 'S' Then
	If RegistrySet( "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "SecureProtocols", ReguLong!, 2208 ) = -1 Then
		gvo_aplicacao.of_grava_log("uo_ge039_nfce - of_abreporta - Erro ao tentar alterar os registros de protolocos TLS 1.2.")	
	End If	
End If

If IsValid(PDV) Then
	PDV.ivb_Porta_Aberta = True
End If

This.ivb_Porta_Aberta = True

Return True
end function

public function boolean of_efetua_pagamento (string ps_codigo_pagamento[], decimal pd_valor[], string ps_cnpj_cartao, string ps_bandeira_cartao, string ps_autorizacao_cartao, string ps_credenciadora);Integer ll_Retorno
Long ll_ind
String ls_Pagto
String ls_valor

/* Como o caixa devolve os pagamentos.
01 DINHEIRO
02 CHEQUE
03 CHEQUE-PRE
04 CARTAO CREDITO
05 CARTAO DEBITO
06 CONVENIO
07 CREDIARIO
08 CONTA CORRENTE 
09 CLUBE
10 PBM 
*/
//For ll_ind = 1 TO UpperBound(ps_codigo_pagamento)
//	
//	ls_Pagto    = MidA(ps_codigo_pagamento[ll_ind],1,2)	
//	Choose Case ls_Pagto
//		Case "01" 		
//			ls_Pagto = "01"
//		Case "02", "03"
//			ls_Pagto = "02"
//		Case "04"
////			ls_Pagto = "03"
//			ls_Pagto = "01"
//		Case "05"
////			ls_Pagto = "04"
//			ls_Pagto = "01"			
//		Case "06", "07", "08", "09"
//			ls_Pagto = "05"
//		Case Else
//			ls_Pagto = "99"	
//	End Choose	
//	
//	ls_valor   = gf_valor_com_ponto(pd_valor[ll_ind])
//
//	ll_Retorno = SWEDA_EfetuarPagamento(ls_Pagto, ls_valor, ps_CNPJ_Cartao, ps_Bandeira_cartao, ps_Autorizacao_cartao, ps_credenciadora)
//	
//	Choose Case ll_Retorno
//		Case 1 				// Comando OK
//			Return True
////			Return False
//		Case 0 				// Erro ao executar comando
//			Return False
//		Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
//			Return False
//	End Choose	
//	
//Next

//Return False

Return True
end function

public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pd_valor);Long  ll_linha
Long	ll_Retorno
Long 	ll_tam, ll_tamanho, ll_espaco
Long	ll_tam_linha = 60  //tamanho da linha na impressora
Long 	ll_dif

String  ls_Relatorio
String  ls_Texto, ls_texto2
String  ls_titulo
String ls_cabecalho1, ls_cabecalho2,ls_cabecalho3, ls_cabecalho4

If pdv.ivb_Modo_Teste Then Return True

Open(w_janela_aguarde)
w_janela_aguarde.mle_1.text = "IMPRIMINDO " + ps_Titulo

Choose Case gvo_parametro.id_rede_filial
	Case 'PP'
		ls_cabecalho1 = '            FARMACIA PRECO POPULAR'
	Case 'DC', 'MP'
		ls_cabecalho1 = '             DROGARIA CATARINENSE'
	Case 'AL'
		ls_cabecalho1 = '                        ALOMED'
	Case 'PF'
		ls_cabecalho1 = '                    PROFORMULA'
	Case 'FA'
		ls_cabecalho1 = '                     FARMAGORA'		
End Choose
ll_tamanho = LenA(ls_cabecalho1)
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho1 = Space(ll_espaco) + ls_cabecalho1

ls_cabecalho2 = gvo_parametro.nm_razao_social
ll_tamanho = LenA(ls_cabecalho2)
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho2 = Space(ll_espaco) + ls_cabecalho2

ll_tamanho = LenA(gvo_parametro.de_endereco)
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho3 = Space(ll_espaco) + gvo_parametro.de_endereco
ll_tamanho = LenA(gvo_parametro.de_bairro+' - '+gvo_parametro.nm_cidade_filial+' - '+gvo_parametro.ivs_uf_filial) 
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho4 = Space(ll_espaco) + gvo_parametro.de_bairro+' - '+gvo_parametro.nm_cidade_filial+' - '+gvo_parametro.ivs_uf_filial

ll_tam = LenA(ps_titulo)
ll_dif = ll_tam_linha - ll_tam
ll_dif = ll_dif / 2
ls_titulo = Space(ll_dif) + ps_titulo

ll_Retorno = PrintSetPrinter (This.nm_impressora_nfce)		
long Job		
// Open a print job.		

If ll_Retorno = 1 Then
	Job = PrintOpen()		
//	PrintDefineFont	(Job, 2, "Courier 10Cps", 250, 400, Default!, Modern!, FALSE, FALSE)
	PrintDefineFont	(Job, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
	PrintSetFont(Job, 1)
//	PrintSend(Job,ls_titulo + "~n" + "~n")

/*	FileWrite(gvo_Aplicacao.ivi_log, ls_cabecalho1)
	FileWrite(gvo_Aplicacao.ivi_log, ls_cabecalho2)
	FileWrite(gvo_Aplicacao.ivi_log, ls_cabecalho3)
	FileWrite(gvo_Aplicacao.ivi_log, ls_cabecalho4 + "~n")	*/
	
	Print(Job,ls_cabecalho1)
	Print(Job,ls_cabecalho2)
	Print(Job,ls_cabecalho3)
	Print(Job,ls_cabecalho4 + "~n")
	
	If Trim(ls_titulo) > '' Then
		//FileWrite(gvo_Aplicacao.ivi_log, ls_titulo + "~n")			
		Print(Job,ls_titulo + "~n")
	End If
	For ll_Linha = 1 To UpperBound(ps_texto)	

		String ls_Aux
		Long ll_loop, ll_pos1
		If (PDV.ivs_Tipo_Venda = "TR" or sitef.is_Tipo_Venda = "TRNCENTRE" or &
			PDV.ivs_Tipo_Venda = "FC" or sitef.is_Tipo_Venda = "FC" or &
			PDV.ivs_Tipo_Venda = "PS" or sitef.is_Tipo_Venda = "PS" or &
			PDV.ivs_Tipo_Venda = "EP" or sitef.is_Tipo_Venda = "EP" or &
			PDV.ivs_Tipo_Venda = "VL" or sitef.is_Tipo_Venda = "VL") And ps_Titulo = "VIA PBM" Then					

			ls_aux = ps_texto[ll_Linha]
			Do While ls_aux <> ""
				ll_pos1 = PosA(ls_aux, Char(10)) //procura o enter
				If ll_pos1 > 0 Then
//					ls_texto = MidA(ls_aux, 1, ll_pos1) + Char(13)  //copia ate o enter e coloca o retorno				
					ls_texto = MidA(ls_aux, 1, ll_pos1 - 1)  //copia ate o enter e coloca o retorno				
					//FileWrite(gvo_Aplicacao.ivi_log, ls_texto)
					ll_retorno = Print(Job,ls_texto)
					ls_aux = MidA(ls_aux, ll_pos1+1, LenA(ps_texto[ll_Linha]) - ll_pos1)
				Else
					//FileWrite(gvo_Aplicacao.ivi_log, ls_aux)
					ll_retorno = Print(Job,ls_aux)
					ls_aux = ""
				End If		
			Loop
		Else
			ls_texto = ps_texto[ll_Linha]
			//FileWrite(gvo_Aplicacao.ivi_log, ls_texto)
			ll_retorno = Print(Job,ls_texto)
		End If		
		
		Choose Case ll_Retorno
			Case 1 				// Comando OK
				If ll_Linha = UpperBound(ps_texto) Then
					If This.ivb_Cod_Barras Then
						This.of_verifica_fonte()
						PrintDefineFont	(Job, 2, "IDAutomationHC39M", 500, 400, Default!, AnyFont!, FALSE, FALSE)
						PrintSetFont(Job, 2)
						String ls_espaco
						ls_espaco = Space(3)	
						//FileWrite(gvo_Aplicacao.ivi_log, ls_espaco + '*' + This.ivs_Cod_Barras + '*')
						Print(Job, ls_espaco + '*' + This.ivs_Cod_Barras + '*')
						PrintDefineFont	(Job, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
						PrintSetFont(Job, 1)						
					End If
					//FileWrite(gvo_Aplicacao.ivi_log, String(Today(),'dd-mm-yyyy" "HH:mm:ss'))
					Print(Job,String(Today(),'dd-mm-yyyy" "HH:mm:ss') + ' - CAIXA: ' + PDV.cd_caixa)
					PrintClose(Job)
					Close(w_Janela_Aguarde)
					Return True
				End If
				Continue
			Case 0 				// Erro ao executar comando
				//Return False
				Exit
			Case 100 			// Impressora ocupada
				Exit
			Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
				//Return False
				Exit
		End Choose
	
	Next
End If

Close(w_Janela_Aguarde)

Return False
end function

public function boolean of_inicializa_comprovante (string ps_tipo, string ps_recebimento, string ps_mensagem, string ps_forma_pgto, decimal pd_valor, long pl_parcelas, string ps_nf);Long ll_Retorno, ll_tamanho, ll_espaco
String ls_titulo
String ls_cabecalho
String ls_cabecalho1, ls_cabecalho2,ls_cabecalho3, ls_cabecalho4

If pdv.ivb_Modo_Teste Then Return True

Choose Case gvo_parametro.id_rede_filial
	Case 'PP'
		ls_cabecalho1 = '            FARMACIA PRECO POPULAR'
	Case 'DC', 'MP'
		ls_cabecalho1 = '             DROGARIA CATARINENSE'
	Case 'AL'
		ls_cabecalho1 = '                        ALOMED'
	Case 'PF'
		ls_cabecalho1 = '                    PROFORMULA'
	Case 'FA'
		ls_cabecalho1 = '                     FARMAGORA'		
End Choose
ll_tamanho = LenA(ls_cabecalho1)
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho1 = Space(ll_espaco) + ls_cabecalho1

ls_cabecalho2 = gvo_parametro.nm_razao_social
ll_tamanho = LenA(ls_cabecalho2)
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho2 = Space(ll_espaco) + ls_cabecalho2

ll_tamanho = LenA(gvo_parametro.de_endereco)
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho3 = Space(ll_espaco) + gvo_parametro.de_endereco
ll_tamanho = LenA(gvo_parametro.de_bairro+' - '+gvo_parametro.nm_cidade_filial+' - '+gvo_parametro.ivs_uf_filial) 
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho4 = Space(ll_espaco) + gvo_parametro.de_bairro+' - '+gvo_parametro.nm_cidade_filial+' - '+gvo_parametro.ivs_uf_filial

Choose Case ps_Tipo
	Case 'CARTAO'
		ls_titulo = "        COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO"
	Case 'NAO_FISCAL'
		ls_titulo = "                COMPROVANTE N$$HEX1$$c300$$ENDHEX$$O FISCAL"		
	Case Else
		ls_titulo = "                      RELATORIO GERAL"
End Choose

ll_Retorno = PrintSetPrinter (This.nm_impressora_nfce)	
// Open a print job.		
This.nr_job_impressao = PrintOpen()		
PrintDefineFont	(This.nr_job_impressao, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
PrintSetFont(This.nr_job_impressao, 1)

/*FileWrite(gvo_Aplicacao.ivi_log,ls_cabecalho1)
FileWrite(gvo_Aplicacao.ivi_log,ls_cabecalho2)
FileWrite(gvo_Aplicacao.ivi_log,ls_cabecalho3)
FileWrite(gvo_Aplicacao.ivi_log,ls_cabecalho4 + "~n")
FileWrite(gvo_Aplicacao.ivi_log,ls_titulo + "~n")*/

ll_Retorno = Print(This.nr_job_impressao,ls_cabecalho1)
ll_Retorno = Print(This.nr_job_impressao,ls_cabecalho2)
ll_Retorno = Print(This.nr_job_impressao,ls_cabecalho3)
ll_Retorno = Print(This.nr_job_impressao,ls_cabecalho4 + "~n")
ll_Retorno = Print(This.nr_job_impressao,ls_titulo + "~n")

If ll_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_imprime_texto (string ps_texto);Long ll_Retorno

If pdv.ivb_Modo_Teste Then Return True

//FileWrite(gvo_Aplicacao.ivi_log,ps_texto)
ll_Retorno = Print(This.nr_job_impressao,ps_texto)

If ll_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_desconto_item (long pl_item, decimal pdc_desconto, decimal pdc_valor);String ls_valor
String ls_item

Long ll_Retorno

//ls_item = String(pl_item)
//ls_valor = gf_valor_com_ponto(pdc_valor)
//
//ll_Retorno = SWEDA_DescontoNoItem(ls_item,ls_valor)
//	
//If ll_Retorno = 1 Then
	Return True
//Else
//	Return False
//End If
end function

public function boolean of_desconto_subtotal (string ps_texto, decimal pdc_valor);String ls_valor

Long ll_Retorno

//ls_valor = gf_valor_com_ponto(pdc_valor)
//
//ll_Retorno = SWEDA_DescontoNoSubtotal(ls_valor)
//	
//If ll_Retorno = 1 Then
	Return True
//Else
//	Return False
//End If
end function

public subroutine of_teste ();long Job, ll_retorno		

This.of_verifica_fonte()

ll_retorno = PrintSetPrinter (This.nm_impressora_nfce)		
Job = PrintOpen()		
PrintDefineFont	(Job, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
PrintSetFont(Job, 1)

ll_retorno = Print(Job,"                         VIA TESTE" + "~n" + "~n")
	
ll_retorno = Print(Job,"TESTE IMPRESSAO")				
ll_retorno = Print(Job,"CLAMED")				
ll_retorno = Print(Job,"TEXTO IMPRESSO COM SUCESSO!!" + "~n")
ll_retorno = Print(Job,"TESTE LINHA COM MAIS DE 42 CARACTERES FIM...........")						

//PrintSetFont(Job, 0)

ll_retorno = PrintDefineFont	(Job, 2, "IDAutomationHC39M", 500, 400, Default!, AnyFont!, FALSE, FALSE)
PrintSetFont(Job, 2)

String ls_espaco
ls_espaco = Space(3)

ll_retorno = Print(Job, ls_espaco + '*1234567890*')
	
ll_retorno = PrintClose(Job)


////TESTE PARA INUTILIZACAO
//String ls_retorno, ls_Status, ls_Motivo, ls_Data, ls_Protocolo, ls_ano
//Date ldt_data
//
//ldt_data = Date( gf_GetServerDate() )
//ls_ano = String(year(ldt_data))
//ls_ano = RightA(ls_ano,2)
//
//This.of_abre_doc()
////parametros da fun$$HEX2$$e700e300$$ENDHEX$$o  ANO, CNPJ, MODELO, SERIE, NF INI, NF FIM, JUSTIFICATIVA
////O numero da NF n$$HEX1$$e300$$ENDHEX$$o deve ser gerado no BD. utilize um numero distinto.
//ll_Retorno = NFCe_Inutilizar(ls_ano, gvo_parametro.nr_cgc, '65', '1', '1', '10', 'Teste inutilizacao homologacao.', &
//									Ref ls_retorno,&
//									Ref ls_Status,&
//									Ref ls_Motivo,&
//									Ref ls_Data,&
//									Ref ls_Protocolo)			
//									
//messageBox("", "Ret: " + String( ll_Retorno ) +' - Ret: ' + ls_retorno + ' - Status: ' + ls_Status + ' - Prot: ' + ls_Protocolo )
//
end subroutine

public function boolean of_codigo_uf (string ps_uf, ref string ps_codigo_uf);Choose Case Upper(Trim(ps_UF))
	Case "RO"
    		ps_codigo_UF = "11"
	Case "AC"
    		ps_codigo_UF = "12"
	Case "AM"
    		ps_codigo_UF = "13"
	Case "RR"
    		ps_codigo_UF = "14"
	Case "PA"
    		ps_codigo_UF = "15"			 
	Case "AP"
    		ps_codigo_UF = "16"			 
	Case "TO"
    		ps_codigo_UF = "17"
	Case "MA"
    		ps_codigo_UF = "21"			 
	Case "PI"
    		ps_codigo_UF = "22"
	Case "CE"
    		ps_codigo_UF = "23"
	Case "RN"
    		ps_codigo_UF = "24"
	Case "PB"
    		ps_codigo_UF = "25"
	Case "PE"
    		ps_codigo_UF = "26"
	Case "AL"
    		ps_codigo_UF = "27"			 
	Case "SE"
    		ps_codigo_UF = "28"
	Case "BA"
    		ps_codigo_UF = "29"
	Case "MG"
    		ps_codigo_UF = "31"
	Case "ES"
    		ps_codigo_UF = "32"
	Case "RJ"
    		ps_codigo_UF = "33"
	Case "SP"
    		ps_codigo_UF = "35"
	Case "PR"
    		ps_codigo_UF = "41"
	Case "SC"
    		ps_codigo_UF = "42"
	Case "RS"
    		ps_codigo_UF = "43"
	Case "MS"
    		ps_codigo_UF = "50"
	Case "MT"
    		ps_codigo_UF = "51"
	Case "GO"
    		ps_codigo_UF = "52"
	Case "DF"
    		ps_codigo_UF = "53"
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo UF da Filial n$$HEX1$$e300$$ENDHEX$$o encontrado!", StopSign!)
		Return False
		
End Choose

Return True
end function

public function boolean of_emitente ();Integer ll_Retorno
String	ls_cnpj, & 
		ls_razao, &
		ls_fantasia, &
		ls_endereco, &
		ls_nr_endereco, &
		ls_bairro, &
		ls_cod_cidade, &
		ls_cidade, &
		ls_uf, &
		ls_cep, &
		ls_ins_est, &
		ls_regime_trib, &
		ls_regime_iss, &
		ls_rateio_iss, &
		ls_nulo, &
		ls_telefone, &
		ls_complemento

If pdv.ivb_Modo_Teste Then Return True

SetNull(ls_nulo)
ls_cnpj 				= gvo_parametro.nr_cgc
ls_razao 				= gvo_parametro.nm_razao_social
ls_fantasia			= of_retira_caracteres(gvo_parametro.nm_fantasia_filial)
ls_endereco			= of_retira_caracteres(gvo_parametro.de_endereco)
//tratamento para caracteres que na dll ocorre erro.
//ls_endereco 		= gf_replace(ls_endereco,"&","E",0)
//ls_endereco 		= gf_replace(ls_endereco,"$$HEX1$$c700$$ENDHEX$$","C",0)
ls_nr_endereco 	= String(gvo_parametro.nr_endereco)
If IsNull(ls_nr_endereco) Or Trim(ls_nr_endereco) = '' Then ls_nr_endereco = '0'	
ls_complemento	= gvo_parametro.de_complemento_endereco
ls_bairro				= gvo_parametro.de_bairro
ls_cod_cidade		= gvo_parametro.cd_cidade_ibge
ls_cidade				= gvo_parametro.nm_cidade_filial
ls_uf					= gvo_parametro.ivs_uf_filial
ls_cep				= gvo_parametro.cd_cep_filial
ls_ins_est			= gf_tira_mascara_inscricao_estadual(gvo_parametro.nr_inscricao_estadual)
ls_regime_trib		= "3" //Regime normal
ls_regime_iss		= "0" // N$$HEX1$$e300$$ENDHEX$$o tem
ls_rateio_iss			= "N"
If Trim(gvo_parametro.nr_telefone) = '0' Or IsNull(gvo_parametro.nr_telefone) Then
	ls_telefone 		= ls_nulo
Else	
	ls_telefone		= Trim(gvo_parametro.nr_ddd) + Trim(gvo_parametro.nr_telefone)
End If


ll_Retorno = NFCe_Emitente(ls_cnpj,&
									ls_razao,&
									ls_fantasia,&
									ls_endereco,&
									ls_nr_endereco,&
									ls_complemento,& 
									ls_bairro,&
									ls_cod_cidade,&
									ls_cidade,&
									ls_uf,&
									ls_cep,&
									ls_telefone,&
									ls_ins_est,&
									ls_nulo,&
									ls_nulo,&
									ls_nulo,&
									ls_regime_trib)

Choose Case ll_Retorno
	Case 1 				// Comando OK
		Return True
	Case 0 				// Erro ao executar comando
		Return False
	Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose	

Return False
end function

public function boolean of_assina_valida ();Integer ll_retorno, ll_retorno2

If pdv.ivb_Modo_Teste Then Return True

ll_retorno = NFCe_AssinarNota()

Choose Case ll_Retorno
	Case 1 				// Comando OK
		
		ll_retorno2 = NFCe_ValidarLoteParaEnvio()
		
		Choose Case ll_Retorno2
			Case 1 				// Comando OK
				Return True		
			Case 0 				// Erro ao executar comando
				Return False
			Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
				Return False
		End Choose			

	Case 0 				// Erro ao executar comando
		Return False
	Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose	


Return False
end function

public function boolean of_finaliza_impressao_texto ();Long ll_Retorno

If pdv.ivb_Modo_Teste Then Return True

//Print(This.nr_job_impressao,"~n")
If This.ivb_Cod_Barras Then	
	This.of_verifica_fonte()
	PrintDefineFont	(This.nr_job_impressao, 2, "IDAutomationHC39M", 500, 400, Default!, AnyFont!, FALSE, FALSE)
	PrintSetFont(This.nr_job_impressao, 2)
	String ls_espaco
	ls_espaco = Space(3)	
	//FileWrite(gvo_Aplicacao.ivi_log, ls_espaco + '*' + This.ivs_Cod_Barras + '*')
	Print(This.nr_job_impressao, ls_espaco + '*' + This.ivs_Cod_Barras + '*')
	
	PrintDefineFont	(This.nr_job_impressao, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
	PrintSetFont(This.nr_job_impressao, 1)	
End If

//FileWrite(gvo_Aplicacao.ivi_log, String(Today(),'dd-mm-yyyy" "HH:mm:ss'))
Print(This.nr_job_impressao,String(Today(),'dd-mm-yyyy" "HH:mm:ss') + ' - CAIXA: ' + PDV.cd_caixa)
ll_Retorno = PrintClose(This.nr_job_impressao)

If ll_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_dados_nfce (string ps_caixa, ref long pl_sequencial, ref long pl_caixa);Long ll_caixa

If LenA(ps_caixa) <> 6 Then
	Messagebox("NFC-e","N$$HEX1$$fa00$$ENDHEX$$mero do caixa n$$HEX1$$e300$$ENDHEX$$o configurado ou configurado incorretamente."+&
				  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
	Return False	
End If

ll_caixa = Long(RightA(ps_caixa, 2))
If ll_caixa = 0 Then
	Messagebox("NFC-e","N$$HEX1$$fa00$$ENDHEX$$mero do caixa configurado incorretamente."+&
				  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
	Return False		
End If

pl_caixa = ll_caixa

//Para NFC-e o numero do caixa ser$$HEX1$$e100$$ENDHEX$$ usado como sequencial. Para melhor tratamento de transa$$HEX2$$e700f500$$ENDHEX$$es TEF.
pl_sequencial = ll_caixa

Return True
end function

public function boolean of_cancela_nfce (string ps_chave, string ps_protocolo, string ps_justificativa, ref string ps_protocolo_cancelamento, ref datetime pdt_data_cancelamento);String ls_retorno, ls_Status, ls_Motivo, ls_data, ls_protocolo
String ls_nulo, ls_uf_filial, ls_cnpj, ls_hora, ls_fuso
DateTime ldh_data
Integer ll_retorno
Boolean lb_nova_nt

ldh_data = gf_getserverdate()		

ls_uf_filial 	= gvo_parametro.ivs_uf_filial
ls_cnpj 		= gvo_parametro.nr_cgc
ls_fuso 		= gvo_parametro.de_fuso_horario_NFCE

//Para cancelar n$$HEX1$$e300$$ENDHEX$$o precisa buscar o xml da venda.
//If Not This.of_busca_xml_ftp(ps_chave) Then
//	Return False
//End If

/*
If IsDate(This.dt_nova_NT) Then
	If ldh_data >= DateTime(This.dt_nova_NT) Then
		lb_nova_nt = True
	End If
End If

If lb_nova_nt Then   //Se for necess$$HEX1$$e100$$ENDHEX$$rio novamente usar o parametro.
	NFCe_ConfiguraParametros(ls_uf_filial, ls_cnpj, "vm60")
Else
	NFCe_ConfiguraParametros(ls_uf_filial, ls_cnpj, "vm50b")
End If*/

NFCe_ConfiguraParametros(ls_uf_filial, ls_cnpj, "vm60")

SetNull(ls_nulo)

ls_retorno = Space(1000)
ls_Status = Space(100)
ls_Motivo = Space(500)
ls_data = Space(100)
ls_protocolo = Space(15)

ll_retorno = NFCe_Cancelar( ps_chave,&
									  ps_protocolo,&
									  ps_justificativa,&
									  String(ldh_data,'YYYY-mm-dd"T"HH:mm:ss'),&
									  1,&
										ls_fuso,&
										"1",&
										Ref ls_retorno,&
										Ref ls_Status,&
										Ref ls_Motivo,&
										Ref ls_data,&
										Ref ls_protocolo)

If ll_Retorno = 1 Then
	ls_hora = MidA(ls_Data,12,8)
	ls_Data = MidA(ls_Data,9,2)+"/"+MidA(ls_Data,6,2)+"/"+MidA(ls_Data,1,4)
	pdt_Data_cancelamento			= DateTime(Date(ls_Data),Time(ls_Hora))
	ps_Protocolo_Cancelamento		= ls_Protocolo		
	
//	pl_retorno 					= ll_retorno
	
//	This.of_exclui_xml(ps_chave)
	If (ls_Status <> '135') Then  // 135 - SUCESSO no cancelamento Sefaz.
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas no Cancelamento da NFC-e - retorno: " + ls_motivo + " " +  ls_Status)
		Return False
	Else
		This.of_envia_xml_ftp(ps_chave)
		Return True
	End If

Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel cancelar a NFC-e!", StopSign!)	
	Return False
End If
end function

public function boolean of_comprovante_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor);Long ll_Retorno
Long ll_tamanho
Long ll_espaco
String ls_titulo
String ls_Forma_Pagamento
String ls_Tipo
String ls_cabecalho1, ls_cabecalho2,ls_cabecalho3, ls_cabecalho4

If pdv.ivb_Modo_Teste Then Return True

Choose Case gvo_parametro.id_rede_filial
	Case 'PP'
		ls_cabecalho1 = '            FARMACIA PRECO POPULAR'
	Case 'DC', 'MP'
		ls_cabecalho1 = '             DROGARIA CATARINENSE'
	Case 'AL'
		ls_cabecalho1 = '                        ALOMED'
	Case 'PF'
		ls_cabecalho1 = '                    PROFORMULA'
	Case 'FA'
		ls_cabecalho1 = '                     FARMAGORA'				
End Choose
ll_tamanho = LenA(ls_cabecalho1)
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho1 = Space(ll_espaco) + ls_cabecalho1

ls_cabecalho2 = gvo_parametro.nm_razao_social
ll_tamanho = LenA(ls_cabecalho2)
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho2 = Space(ll_espaco) + ls_cabecalho2

ll_tamanho = LenA(gvo_parametro.de_endereco)
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho3 = Space(ll_espaco) + gvo_parametro.de_endereco
ll_tamanho = LenA(gvo_parametro.de_bairro+' - '+gvo_parametro.nm_cidade_filial+' - '+gvo_parametro.ivs_uf_filial) 
If ll_tamanho >= 50 Then
	ll_espaco = 0
Else
	ll_espaco = (50 - ll_tamanho) / 2
End If
ls_cabecalho4 = Space(ll_espaco) + gvo_parametro.de_bairro+' - '+gvo_parametro.nm_cidade_filial+' - '+gvo_parametro.ivs_uf_filial

ls_titulo = "                COMPROVANTE N$$HEX1$$c300$$ENDHEX$$O FISCAL"		

Choose Case ps_pagamento
	Case "01" ; ls_Forma_Pagamento = "DINHEIRO               "
	Case "02" ; ls_Forma_Pagamento = "CHEQUE			      "	
	Case "03" ; ls_Forma_Pagamento = "CHEQUE-PRE           "
	Case "04" ; ls_Forma_Pagamento = "CARTAO CREDITO   "
	Case "05" ; ls_Forma_Pagamento = "CARTAO DEBITO     "
	Case "06" ; ls_Forma_Pagamento = "CONVENIO              " 
	Case "07" ; ls_Forma_Pagamento = "CREDIARIO             "
	Case "08" ; ls_Forma_Pagamento = "CONTA CORRENTE   "		
	Case "09" ; ls_Forma_Pagamento = "CLUBE               "
	Case "10" ; ls_Forma_Pagamento = "PBM                  "		
	Case "11" ; ls_Forma_Pagamento = "RECARGA           "	
End Choose

Choose Case ps_recebimento
	Case "01" ; ls_Tipo = "RECEBIMENTO......................"
	Case "02" 
		If ps_descricao = "VENDA GIFTCARD" Then
			ls_Tipo = "VENDA GIFTCARD.............."	
		Else
			ls_Tipo = "RECARGA.........................."	
		End If
	Case "03" ; ls_Tipo = "PAGTO. CONTA....................."
	Case "04" ; ls_Tipo = "SANGRIA..........................."
	Case "05" ; ls_Tipo = "SUPRIMENTO....................."
End Choose

PrintSetPrinter (This.nm_impressora_nfce)		
// Open a print job.		
This.nr_job_impressao = PrintOpen()		
PrintDefineFont	(This.nr_job_impressao, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
PrintSetFont(This.nr_job_impressao, 1)
ll_Retorno = Print(This.nr_job_impressao,ls_cabecalho1)
ll_Retorno = Print(This.nr_job_impressao,ls_cabecalho2)
ll_Retorno = Print(This.nr_job_impressao,ls_cabecalho3)
ll_Retorno = Print(This.nr_job_impressao,ls_cabecalho4 + "~n" + "~n")

If ll_Retorno = 1 Then
	Print(This.nr_job_impressao,ls_titulo + "~n" + "~n")	
	Print(This.nr_job_impressao,ls_Tipo + STRING(pdc_valor, "###,##0.00")  + "~n" + "~n")	
	If ps_recebimento <> "04" And ps_recebimento <> "05" Then
		Print(This.nr_job_impressao,ls_Forma_pagamento + STRING(pdc_valor, "###,##0.00") + "~n" + "~n")			
	End If
	If PosA(ps_descricao, "SAQUE PIX") > 0 Then
		Print(This.nr_job_impressao,ps_descricao + "~n")	
	End If	
	Print(This.nr_job_impressao,String(Today(),'dd-mm-yyyy" "HH:mm:ss') + " - CAIXA: " + PDV.cd_caixa + "~n")	
	
	ll_Retorno = PrintClose(This.nr_job_impressao)
	If ll_Retorno = 1 Then	
		Return True
	End If
Else
	Return False
End If

Return False
end function

public function string of_retira_caracteres (string ps_texto);String ls_retorno
//Substitui caracteres n$$HEX1$$e300$$ENDHEX$$o aceitos no XML por espa$$HEX1$$e700$$ENDHEX$$o

ls_retorno = ps_texto
ls_retorno = gf_replace(ls_retorno, '>', ' ', 0)
ls_retorno = gf_replace(ls_retorno, '<', ' ', 0)
ls_retorno = gf_replace(ls_retorno, '&', ' ', 0)
ls_retorno = gf_replace(ls_retorno, '"', ' ', 0)
ls_retorno = gf_replace(ls_retorno, "'", ' ', 0)

Return ls_retorno


end function

public function boolean of_email_xml (string ps_chave, string ps_email, string ps_modo);Integer ll_Retorno
String ls_mail

If ps_modo = 'E' Then   //Somente envio de e-mail
	If Not This.of_busca_xml_ftp(ps_chave) Then Return False
	
	This.of_abre_doc()

	ll_retorno =	NFCe_Envia_email(ps_chave, ps_email)		
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			This.of_exclui_xml(ps_chave)
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose		
End If

If ps_modo = 'V' Then   // No momento da finaliza$$HEX2$$e700e300$$ENDHEX$$o da Venda.

	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente deseja receber NFC-e por e-mail?", Question!,YesNo!, 2) = 1 Then
		OpenWithParm(w_ge039_email_envio_nfce, ps_email)					
		ls_mail = Trim(Message.StringParm)
		If Not IsNull(ls_mail) And Trim(ls_mail) > '' Then
			
			ll_retorno =	NFCe_Envia_email(ps_chave, ls_mail)		
			
			Choose Case ll_Retorno
				Case 1 				// Comando OK
					Messagebox("NFC-e","E-mail enviado com sucesso!.", Information!)				
				Case Else
					Messagebox("NFC-e","Problemas para enviar o e-mail."+&
								  "Tente novamente mais tarde.", Exclamation!)				
			End Choose					
		End If				
	End If

	If This.of_envia_xml_ftp(ps_chave) Then
		Return True
	End If		
End If

Return False
end function

public function boolean of_envia_xml_ftp (string ps_chave);Integer li_Total
Integer li_Contador
Integer li_Percentual_Atual

String	ls_Arquivos[]
String	ls_Arquivo
String	ls_Arquivo_Zip
String	ls_Extensao
String	ls_Error
String ls_Filial
String ls_Msg
String	ls_MD5_Remoto
String	ls_MD5_Local
String ls_Diretorio_Base = 'c:\sistemas\cl\nfce\XmlDestinatario\'
String ls_Servidor

If pdv.ivb_Modo_Teste Then Return True

uo_parametro_filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial
lvo_Parametro.of_Localiza_Parametro('DE_ENDERECO_SERVIDOR_FTP', ref ls_Servidor, False)
Destroy lvo_Parametro

ls_Filial = String( gvo_Parametro.Cd_Filial, "0000" )

dc_uo_zip lo_Zip
lo_Zip = Create dc_uo_zip

dc_uo_ftp lo_Ftp
lo_Ftp = Create dc_uo_ftp
//
///* Para verifica$$HEX2$$e700e300$$ENDHEX$$o do MD5 do arquivo enviado */
//uo_transacao_remota lo_SD
//lo_SD = Create uo_transacao_remota
//lo_SD.is_Servidor_Intranet = '10.0.0.4'
//
//uo_Bematech lo_Bema
//lo_Bema = Create uo_Bematech
//
gf_dir_list( ls_Diretorio_Base, ps_chave+'*.xml', 0+1, Ref ls_Arquivos )

For li_Contador = 1 To UpperBound( ls_Arquivos )
	ls_Arquivo = ls_Arquivos[ li_Contador ]
	
//	ls_Extensao = Upper( RightA( ls_Arquivo, 3 ) )
	
//	Choose Case ls_Extensao
//		Case 'MFD', 'ZIP'
//			FileDelete( ls_Diretorio_Base + ls_Arquivo )
//			
//		Case 'LOG', 'TXT'
//			/*
//			If Not DirectoryExists( ls_Diretorio_Base + 'LOG' ) Then
//				CreateDirectory( ls_Diretorio_Base + 'LOG' )
//			End If
//			
//		    FileMove( ls_Diretorio_Base + ls_Arquivo, ls_Diretorio_Base + 'LOG\' + ls_Arquivo )
//			*/ 
//		Case 'XML'
			lo_Zip.of_Salva_Estrutura( False )
			ls_Error = lo_Zip.of_Zip( ls_Diretorio_Base + ls_Arquivo, ls_Diretorio_Base + ls_Arquivo + '.zip' )
				
			If ls_Error <> "" Then
				MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao tentar compactar arquivo ' + ls_Arquivo + '~r~r' + ls_Error, StopSign! )
			Else
//				If Not DirectoryExists( ls_Diretorio_Base + 'BACKUP' ) Then
//					CreateDirectory( ls_Diretorio_Base + 'BACKUP' )
//				End If
//				
				lo_Ftp.of_DesConecta_Ftp()
				
				If lo_Ftp.of_Conecta_Ftp( 'NFCE - ' + ls_Filial, ls_Servidor, 'pdv2', 'pdv2', Ref ls_Msg ) Then
					If lo_Ftp.of_Ftp_Set_Dir( 'NFCE', ref ls_Msg ) < 0 Then
						lo_Ftp.of_Ftp_Cria_Dir( 'NFCE', ref ls_Msg ) // Cria+										

						If lo_Ftp.of_Ftp_Set_Dir( 'NFCE', ref ls_Msg ) < 0 Then
							MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar diret$$HEX1$$f300$$ENDHEX$$rio NFCE no servidor FTP " + ls_servidor +" ~r~r" + ls_Msg, StopSign! )
							Return False
						End If					
					End If													
					If lo_Ftp.of_Ftp_PutFile( ls_Diretorio_Base + ls_Arquivo + '.zip', ls_Arquivo + '.zip', Ref ls_Msg ) Then
//								/* Verifica os MD5 dos arquivos REMOTO e LOCAL, compara os dois para poder mover o arquivo local */
//								If  lo_SD.of_Executa_Rotina_Intranet( 'verifica_md5_troca_dados', "diretorio=Ecf/" + ls_Filial + "/&arquivo=" + ls_Arquivo + '.zip' ) Then
//									lo_SD.of_Retorno_Dados( ref ls_MD5_Remoto )
//									
//									If LeftA( ls_MD5_Remoto, 4 ) = 'ERRO' Then
//										MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_MD5_Remoto )
//									Else
//										ls_MD5_Local	= Space(33)
//										lo_Bema.of_Capturar_Md5( ls_Diretorio_Base + ls_Arquivo + '.zip', Ref ls_MD5_Local )
//										
//										If ls_MD5_Local = ls_MD5_Remoto Then
//											 FileMove( ls_Diretorio_Base + ls_Arquivo, ls_Diretorio_Base + 'BACKUP\' + ls_Arquivo )
									 FileDelete( ls_Diretorio_Base + ls_Arquivo + '.zip' )
									 FileDelete( ls_Diretorio_Base + ls_Arquivo )											 
//										End If
//									End If					
//								End If
//								/********/
//								
					Else
						MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao enviar arquivo " + ls_Arquivo + ".zip para NFCE no servidor FTP " + ls_servidor + " ~r~r" + ls_Msg, StopSign! )
					End If
					
					lo_Ftp.of_DesConecta_Ftp()
				Else
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor FTP " + ls_servidor + " ~r~r" + ls_Msg, StopSign! )
				End If
				
			End If
//			
//	End Choose
//	
Next

Destroy lo_Ftp
//Destroy lo_Bema
Destroy lo_Zip
//Destroy lo_SD

Return True
end function

public function boolean of_busca_xml_ftp (string ps_chave);String	ls_Arquivo
String	ls_Arquivo_Zip
String	ls_Error
String ls_Filial
String ls_Msg
String ls_Diretorio_Base = 'c:\sistemas\cl\nfce\XmlDestinatario\'
String ls_Servidor_Central
String ls_Servidor_local
String ls_ano
String ls_mes
String ls_dia
String ls_diretorio
String ls_situacao
DateTime ldt_emissao
Boolean lb_Busca_Central = False
Boolean lb_Sucesso = True

If pdv.ivb_Modo_Teste Then Return True

If FileExists(ls_Diretorio_base + ps_chave + '-nfce.xml') Then //Arquivo existe no PDV, n$$HEX1$$e300$$ENDHEX$$o precisa vir buscar.
	Return True
End If

ls_Filial 		= String( gvo_Parametro.Cd_Filial, "0000" )

uo_parametro_filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial
lvo_Parametro.of_Localiza_Parametro('DE_ENDERECO_SERVIDOR_FTP', ref ls_Servidor_local, False)
Destroy lvo_Parametro

ls_Servidor_central = '10.0.4.30'
ls_arquivo = ps_chave + '-nfce.xml'
//Busca dados da nota no sistema.
select nf.dh_emissao, nfe.id_situacao
  into :ldt_emissao, :ls_situacao
  from nf_venda_nfe nfe
  join nf_venda nf on nfe.cd_filial = nf.cd_filial
  		and nfe.nr_nf = nf.nr_nf
		and nfe.de_especie = nf.de_especie
		and nfe.de_serie = nf.de_serie
where nfe.cd_filial = :gvo_parametro.cd_filial
	and nfe.de_chave_acesso = :ps_chave
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_situacao <> 'A' Then
			MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Situa$$HEX2$$e700e300$$ENDHEX$$o da NFC-e n$$HEX1$$e300$$ENDHEX$$o permite prosseguir solicita$$HEX2$$e700e300$$ENDHEX$$o. Situa$$HEX2$$e700e300$$ENDHEX$$o : '+ ls_Situacao, StopSign! )		
			Return False						
		Else
			ls_ano 	= String( ldt_emissao, 'yyyy' )
			ls_mes 	= String( ldt_emissao, 'mm' )
			ls_dia		= String( ldt_emissao, 'dd' )
			ls_diretorio = ls_ano + '/'+ ls_mes +'/'+ ls_dia + '/' +ls_filial
		End If		
	Case -1
		SqlCa.Of_msgdberror("Localiza$$HEX2$$e700e300$$ENDHEX$$o NFCe.")
		Return False			
	Case Else
		SqlCa.Of_msgdberror("Localiza$$HEX2$$e700e300$$ENDHEX$$o NFCe.")
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi possivel encontrar dados da Nota.', StopSign! )		
		Return False					
		
End Choose

dc_uo_api lo_api
lo_api = Create dc_uo_api

dc_uo_ftp lo_Ftp
lo_Ftp = Create dc_uo_ftp

lo_Ftp.of_DesConecta_Ftp()				

//Verifica se o XML ainda est$$HEX1$$e100$$ENDHEX$$ no servidor local da loja
If lo_Ftp.of_Conecta_Ftp( 'NFCE - ' + ls_Filial, ls_Servidor_local, 'pdv2', 'pdv2', Ref ls_Msg ) Then
	If lo_Ftp.of_Ftp_Set_Dir( 'NFCE', ref ls_Msg ) >= 0 Then
		If lo_Ftp.of_Ftp_GetFile( ls_Arquivo + '.zip', ls_diretorio_Base + ls_Arquivo + '.zip', Ref ls_Msg ) Then
			If lo_api.of_unzip(ls_diretorio_Base + ls_Arquivo + '.zip',ls_diretorio_Base) Then
				lo_api.of_delete_file(ls_Diretorio_Base + ls_Arquivo + '.zip',False)
			Else
				MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao tentar descompactar arquivo ' + ls_Arquivo + '~r~r' + ls_Error, StopSign! )
				lb_sucesso = False				
			End If						
		Else
			lb_busca_central = True
		End If
	Else
		lb_busca_central = True
	End If
Else
	lb_busca_central = True
End If

lo_Ftp.of_DesConecta_Ftp()

//N$$HEX1$$e300$$ENDHEX$$o encontrou na loja vai buscar no central
If lb_busca_central Then
	If lo_Ftp.of_Conecta_Ftp( 'NFCE - ' + ls_Filial, ls_Servidor_central, 'nfce', 'nfce', Ref ls_Msg ) Then
		If lo_Ftp.of_Ftp_Set_Dir( ls_diretorio, ref ls_Msg ) >= 0 Then
			If lo_Ftp.of_Ftp_GetFile( ls_Arquivo + '.zip', ls_diretorio_Base + ls_Arquivo + '.zip', Ref ls_Msg ) Then
				If lo_api.of_unzip(ls_diretorio_Base + ls_Arquivo + '.zip',ls_diretorio_Base) Then
					lo_api.of_delete_file(ls_Diretorio_Base + ls_Arquivo + '.zip',False)
				Else
					MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao tentar descompactar arquivo ' + ls_Arquivo + '~r~r' + ls_Error, StopSign! )
					lb_sucesso = False
				End If						
			Else
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao buscar arquivo " + ls_Arquivo + ".zip no servidor FTP " + ls_servidor_central + " ~r~r" + ls_Msg, StopSign! )
				lb_sucesso = False
			End If
		Else
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar diret$$HEX1$$f300$$ENDHEX$$rio NFCE no servidor FTP " + ls_servidor_central +" ~r~r" + ls_Msg, StopSign! )
			lb_sucesso = False
		End If
	Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor FTP " + ls_servidor_central + " ~r~r" + ls_Msg, StopSign! )
		lb_sucesso = False					
	End If

	lo_Ftp.of_DesConecta_Ftp()
End If

Destroy lo_Ftp
Destroy lo_api

Return lb_sucesso
end function

public function boolean of_exclui_xml (string ps_chave);String ls_Diretorio_Base = 'c:\sistemas\cl\nfce\XmlDestinatario\'
String ls_Servidor
String ls_Arquivo

If pdv.ivb_Modo_Teste Then Return True

ls_Arquivo = ps_chave + '-nfce.xml'

FileDelete( ls_Diretorio_Base + ls_Arquivo + '.zip' )
FileDelete( ls_Diretorio_Base + ls_Arquivo )											 

Return True
end function

public subroutine of_verifica_fonte ();String ls_Folder

String ls_Validar[]

ls_Folder	= "c:\windows\fonts"

ls_Validar = {'IDAutomationHC39M.ttf'}

If Not FileExists( ls_Folder + '\' + ls_Validar[1] ) Then				
	If Not gf_download_matriz(ls_Validar, ls_Validar, ls_Folder, 'fonts',  False) Then Return
End If

If RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", "IDAutomationHC39M (TrueType)", RegString!, "IDAutomationHC39M.ttf" ) = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instalar a fonte necess$$HEX1$$e100$$ENDHEX$$ria para impress$$HEX1$$e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo de barras.', Information! )
End If
end subroutine

public function boolean of_consulta_nfce (string ps_chave, ref string ps_protocolo, ref string ps_retorno, ref string ps_status, ref string ps_motivo, ref datetime pdt_data_rec, ref string ps_chave_rec);Long ll_retorno
String ls_chave, ls_protocolo, ls_retorno, ls_status, ls_motivo, ls_data, ls_chaverec, ls_hora

ls_retorno = Space(10000)
ls_Status = Space(100)
ls_Motivo = Space(500)
ls_data = Space(100)
ls_protocolo = Space(15)
ls_chaveRec = Space(100)

If pdv.ivb_Modo_Teste Then Return True

This.of_abre_doc()

ll_retorno = NFCe_Consulta( ps_chave,&
										Ref ls_protocolo,&
										Ref ls_retorno,&
										Ref ls_Status,&
										Ref ls_Motivo,&
										Ref ls_data,&
										Ref ls_ChaveRec)

If ll_retorno = 1 Then
	ls_hora = MidA(ls_Data,12,8)
	ls_Data = MidA(ls_Data,9,2)+"/"+MidA(ls_Data,6,2)+"/"+MidA(ls_Data,1,4)
	ps_protocolo 	= ls_protocolo
	ps_retorno 		= ls_retorno
	ps_status		= ls_status
	ps_motivo		= ls_motivo
	pdt_Data_Rec	= DateTime(Date(ls_Data),Time(ls_Hora))	
	ps_chave_rec	= RightA(ls_ChaveRec, 44)	
	Return True
Else
	Return False
End If
end function

public function boolean of_sangria (decimal pdc_valor);Return This.of_comprovante_nao_fiscal('','','04',pdc_valor)
end function

public function boolean of_suprimento (decimal pdc_valor);Return This.of_comprovante_nao_fiscal('','','05',pdc_valor)
end function

public function boolean of_carrega_data_nt ();String ls_data_NT

//Comentado, porque a chamada dessa funcao ocorre no contructor desse objeto, que $$HEX1$$e900$$ENDHEX$$ feito no contructor do objeto PDV, 
//como ainda n$$HEX1$$e300$$ENDHEX$$o terminou de construir o objeto PDV, a variavel ainda n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ disponivel
//If pdv.ivb_Modo_Teste Then Return True

uo_Parametro_Filial lo_Parametro
lo_Parametro = Create uo_Parametro_Filial

lo_Parametro.of_Localiza_Parametro("DH_INICIA_NOVA_NT_NFCE", ref ls_data_NT, False) //foi usada para controlar troca de manual e versao de xml
lo_Parametro.of_Localiza_Parametro("ID_ATUALIZA_PROTOCOLO_TLS", ref id_atualiza_tls, False)

If IsDate(ls_data_NT) Then
	This.dt_nova_NT = ls_data_NT
End If

Destroy(lo_parametro)

Return True
end function

public function boolean of_destinatario (string ps_cpf_cgc, string ps_codigo_cliente, string ps_nm_cliente, string ps_endereco, string ps_nr_endereco, string ps_bairro, string ps_cidade_ibge, string ps_nm_cidade, string ps_uf, string ps_email_xml, boolean pb_programa_governo, boolean pb_mesmo_cpf);Integer ll_Retorno
String ls_nulo
String ls_nome
String ls_cpf
String ls_cgc
String ls_endereco
String ls_nr_endereco
String ls_Bairro
String ls_cidade_ibge
String ls_cidade
String ls_uf
String ls_uf_filial
String ls_cnpj
String ls_codigo_uf

Boolean lb_Endereco_Filial
Boolean lb_Resumido

SetNull(ls_nulo)

If pdv.ivb_Modo_Teste Then Return True

ls_uf_filial 	= gvo_parametro.ivs_uf_filial
ls_cnpj 		= gvo_parametro.nr_cgc

If (IsNull(ps_codigo_cliente) Or Trim(ps_codigo_cliente) = '') Then // N$$HEX1$$e300$$ENDHEX$$o foi informado DADOS DO CLIENTE - SAI da fun$$HEX2$$e700e300$$ENDHEX$$o sem montrar o destinatario.
	If IsNull(ps_cpf_cgc) Or Trim(ps_cpf_cgc) = '' Then
		Return True
	End If
End If

If pb_programa_governo = False Then 
	// Foi informado que cliente N$$HEX1$$c300$$ENDHEX$$O quer participar de programa do governo - SAI da fun$$HEX2$$e700e300$$ENDHEX$$o sem montrar o destinatario.
	Return True	
End If

If This.id_homologacao = '2' Then
	ls_nome = "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL"
Else
	ls_nome = Trim(of_retira_caracteres(ps_nm_cliente))
	
	If IsNull(ls_nome) or Trim(ls_nome) = '' or Not pb_mesmo_cpf Then
		ls_nome = 'NAO INFORMADO'
	End If
End If

If Len(Trim(ps_cpf_cgc)) > 11 Then
	ls_cgc = ps_cpf_cgc
	ls_cpf = ls_nulo
Else
	ls_cpf = ps_cpf_cgc
	ls_cgc = ls_nulo
End If

If IsNull(ps_cpf_cgc) Or Trim(ps_cpf_cgc) = '' Then
	ls_cpf = ls_nulo
	ls_cgc = ls_nulo			
End If

If IsNull(ps_codigo_cliente) Or Trim(ps_codigo_cliente) = '' Then
	If IsNull(ps_endereco) Or Trim(ps_endereco) 			= '' Then lb_Resumido = True
	If IsNull(ps_nr_endereco) Or Trim(ps_nr_endereco) 	= '' Then lb_Resumido = True
	If IsNull(ps_bairro) Or Trim(ps_bairro) 					= '' Then lb_Resumido = True
	If IsNull(ps_cidade_ibge) Or Trim(ps_cidade_ibge) 	= '' Then lb_Resumido = True
	If IsNull(ps_nm_cidade) Or Trim(ps_nm_cidade) 		= '' Then lb_Resumido = True
	If IsNull(ps_uf) Or Trim(ps_uf) 								= '' Then lb_Resumido = True
End If
	
If Not lb_Resumido Then
	//Se algum informa$$HEX2$$e700e300$$ENDHEX$$o obrigatoria de endere$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o estiver preenchido, s$$HEX1$$f300$$ENDHEX$$ envia nome e cpf/cnpj do cliente
	ls_endereco			= of_retira_caracteres(ps_endereco)
	ls_endereco 		= Trim(ls_endereco)
	If LenA(ls_endereco) <= 1 Then 	ls_endereco = 'RUA ' + ls_endereco //Acerto para ruas com nomes de Letra, com apenas 1 caractere.
	If IsNull(ps_endereco) Or Trim(ps_endereco) = '' Then	lb_Resumido = True	//ls_endereco = of_retira_caracteres(gvo_parametro.de_endereco)
	ls_nr_endereco 	= Trim(ps_nr_endereco)
	If IsNull(ps_nr_endereco) Or Trim(ps_nr_endereco) = '' Then lb_Resumido = True //	ls_nr_endereco = String(gvo_parametro.nr_endereco)	
	ls_bairro	= of_retira_caracteres(ps_bairro)
	ls_bairro	= Trim(ps_bairro)			
	If LenA(ls_bairro) <= 1 Then ls_bairro = 'BAIRRO ' + ls_bairro	
	If IsNull(ps_bairro) Or Trim(ps_bairro) = '' Then  lb_Resumido = True	//ls_bairro = gvo_parametro.de_bairro
	ls_cidade_ibge		= Trim(ps_cidade_ibge)
	If IsNull(ps_cidade_ibge) Or Trim(ps_cidade_ibge) = '' Then lb_Resumido = True	//ls_cidade_ibge = gvo_parametro.cd_cidade_ibge
	ls_cidade				= Trim(ps_nm_cidade)
	If IsNull(ps_nm_cidade) Or Trim(ps_nm_cidade) = '' Then 	lb_Resumido = True //ls_cidade = gvo_parametro.nm_cidade_filial
	ls_uf					= Trim(ps_uf)
	If IsNull(ps_uf) Or Trim(ps_uf) = '' Then lb_Resumido = True//ls_uf = gvo_parametro.ivs_uf_filial			
	If Not pb_mesmo_cpf Then //Se foi informado outro cpf para programa do governo, nao passo informa$$HEX2$$e700f500$$ENDHEX$$es cadastrais, somente o cpf.
		lb_Resumido = True		
	End If	
End If

If Not lb_Resumido Then
	ll_retorno = NFCe_Destinatario(ls_cgc,&
							ls_cpf,&
							ls_nulo,&
							ls_nome,&
							ls_endereco,&
							ls_nr_endereco,&
							ls_nulo,&
							ls_bairro,&
							ls_cidade_ibge,&
							ls_cidade,&
							ls_uf,&
							ls_nulo,&
							ls_nulo,&
							'9',&
							ls_nulo,&
							ls_nulo,&
							ls_nulo,&
							ps_email_xml)
Else
	ll_retorno = NFCe_Destinatario_Resumido(ls_cgc,&
							ls_cpf,&
							ls_nulo,&
							ls_nome,&
							'9',&
							ls_nulo,&
							ls_nulo,&
							ls_nulo,&
							ps_email_xml)							
End If					

Choose Case ll_Retorno
	Case 1 				// Comando OK
		Return True
	Case 0 				// Erro ao executar comando
		Return False
	Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose	

Return False
end function

public function boolean of_imprime (string ps_texto);Long ll_Retorno

If pdv.ivb_Modo_Teste Then Return True

PrintSetPrinter (This.nm_impressora_nfce)		
// Open a print job.		
This.nr_job_impressao = PrintOpen()		
PrintDefineFont	(This.nr_job_impressao, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
PrintSetFont(This.nr_job_impressao, 1)
ll_Retorno = Print(This.nr_job_impressao,ps_texto)

If ll_Retorno = 1 Then	
	ll_Retorno = PrintClose(This.nr_job_impressao)
	If ll_Retorno = 1 Then	
		Return True
	End If
Else
	Return False
End If
end function

public function boolean of_fecha_nota (string ps_inf_complementares, string ps_campo_fisco, string ps_tempo_fisco, string ps_formato_impressao, string ps_tipo_envio, string ps_email_envio, ref string ps_codigo_nota, ref string ps_status, ref string ps_motivo_fechar, ref string ps_xml, ref datetime pdt_data_recebimento, ref string ps_protocolo, ref long pl_retorno, decimal pdc_vl_recebido, decimal pdc_troco, string ps_emite_em_contingencia);Integer ll_Retorno
String		ls_Nota, &
			ls_Status, &
			ls_Motivo, &
			ls_XML, &
			ls_Data, &
			ls_Protocolo, &
			ls_Hora, &
			ls_mail, &
			ls_chave_contingencia
Long ll_Pos
			
ls_Nota 		= Space(100)
ls_Status 	= Space(100)
ls_Motivo 	= Space(1000)
ls_XML	 	= Space(100)
ls_Data 		= Space(100)
ls_Protocolo = Space(100)

If pdv.ivb_Modo_Teste Then 
	pl_retorno = -1
	Return False	
End If

If Upper(Trim(ps_emite_em_contingencia)) = 'S' Then
	gvo_aplicacao.of_grava_log("uo_ge039_nfce - of_fecha_nota - Fecha Nota NFC-e parametro de contingencia Ativo.")
	pl_retorno = -1
	Return False	
End If

ll_Retorno = NFCe_EnviarSEFAZ(	Ref ls_Nota,&
									Ref ls_Status,&
									Ref ls_Motivo,&
									Ref ls_Data,&
									Ref ls_Protocolo)

pl_retorno 					= ll_retorno

gvo_aplicacao.of_grava_log("uo_ge039_nfce - of_fecha_nota - Fecha Nota NFC-e, retorno EnviarSEFAZ: " + String(pl_retorno))				

If ll_Retorno = 1 Then
	ls_hora = MidA(ls_Data,12,8)
	ls_Data = MidA(ls_Data,9,2)+"/"+MidA(ls_Data,6,2)+"/"+MidA(ls_Data,1,4)
	If Trim(RightA(ls_Nota, 44)) <> '' Then
		ps_codigo_nota 			= RightA(ls_Nota, 44)
	End If
	ps_Status					= ls_Status
	ps_motivo_fechar			= ls_Motivo
	ps_XML						= ls_XML
	pdt_Data_Recebimento	= DateTime(Date(ls_Data),Time(ls_Hora))
	ps_Protocolo				= ls_Protocolo		
	This.dt_data_recebimento = DateTime(Date(ls_Data),Time(ls_Hora))			
	
	If (ls_Status <> '100' And ls_Status <> '150') Then	
		Choose Case ls_Status
			Case '108','109','110','203','205','206','207','208','209','210','211','212','213','214','215','220','225','226', &
					'227','228','229','230','231','232','233','234','235','236','237','238','239','240','241','242','243','244','245',&
					'246','247','252','253','257','259','261','264','267','269','270','271','272','273','274','275','276','277','278',&
					'279','280','281','282','283','284','285','286','289','290','291','292','293','294','295','296','297','298','299',&
					'301','302','303','351','352','353','359','360','361','391','392','394','395','396','397','398','399','400','401','402','405',&
					'406','409','410','411','417','418','434','436','437','438','439','440','441','442','443','450','451','452','462',&
					'463','464','479','480','481','482','483','489','490','491','492','493','494','501','502','503','504','505','506',&
					'516','517','518','519','522','523','528','529','530','531','532','533','534','535','536','537','538','545',&
					'546','547','548','549','550','551','552','553','554','555','556','557','558','560','561','562','564','565','567',&
					'568','569','572','573','574','575','576','577','578','579','580','587','588','589','590','591','592','593','594',&
					'595','596','601','602','603','604','605','606','607','608','609','610','611','612','613','614','615','616','617',&
					'618','619','620','621','622','623','624','625','626','627','628','629','630','631','635','656','657','658','680',&
					'681','682','685','701','702','703','704','705','706','707','708','709','710','711','712','713','714','715','716',&
					'717','718','719','724','725','726','729','730','733','734','735','737','740','741','742','743','745','746','748',&
					'749','750','751','752','753','765','766','767','768','769','772','773','774','775','777','778','779','780','781',&
					'782','783','784','785','786','787','788','789','793','806','930','931','972','927','928','934','897', '999'
				
				//Grava rejei$$HEX2$$e700e300$$ENDHEX$$o SEFAZ na tabela nfe_rejeicao para n$$HEX1$$e300$$ENDHEX$$o reenviar nota
				This.of_Grava_Rejeicao( ps_codigo_nota, ls_Status)
							
				If ps_tipo_envio = 'N'	Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas com a NFCe - retorno: " + ls_motivo + " " +  ls_Status +". "+&
													"A NFC-e ser$$HEX1$$e100$$ENDHEX$$ emitida em conting$$HEX1$$ea00$$ENDHEX$$ncia!", Exclamation!)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas com a NFCe - retorno: " + ls_motivo + " " +  ls_Status +".", Exclamation!)													
				End If
				pl_retorno = -2
				Return False
				
			Case '204','539' //Duplicidade - Nota j$$HEX1$$e100$$ENDHEX$$ existe no SEFAZ, vai atualizar informa$$HEX2$$e700f500$$ENDHEX$$es de envio.
				If ps_tipo_envio = 'C' Then
					pl_retorno = -3
					Return True
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas com a NFCe - retorno: " + ls_motivo + " " +  ls_Status +".", Exclamation!)																		
					pl_retorno = 0					
				End If		
				
			Case Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas com a NFCe - retorno: " + ls_motivo + " " +  ls_Status)
				pl_retorno = 0
				Return False
		End Choose		
	Else		
		If (ls_Status = '100') Then 				
			If Not ivb_contingencia Then
				This.of_imprime_nota( ls_Nota, ls_Protocolo, '0', 'N', 'V', pdc_vl_recebido, pdc_troco, Ref ls_chave_contingencia)
//				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente deseja receber NFC-e por e-mail?", Question!,YesNo!, 2) = 1 Then
//					OpenWithParm(w_ge039_email_envio_nfce, ps_email_envio)					
//					ls_mail = Trim(Message.StringParm)
//					If Not IsNull(ls_mail) And Trim(ls_mail) > '' Then
//						This.of_email_xml(ps_codigo_nota, ls_mail, 'V')
//					End If				
//				End If
			Else
				This.of_envia_xml_ftp(ls_Nota)				
			End If
			Return True
		Else
			If (ls_Status = '150') Then //Nota emitida em contig$$HEX1$$ea00$$ENDHEX$$ncia autorizada.
				This.of_envia_xml_ftp(ls_Nota)			
				Return True
			Else
				Return False
			End If
		End If
	End If
Else
	Return False
End If
	
Return False
end function

public subroutine of_atualiza_dlls ();String ls_Path_System
String ls_path_dll = 'c:\sistemas\dll\nfce'
String ls_filename

DateTime ldt_Anterior, ldt_Atual

Try
	If gvo_Aplicacao.of_is64bits() Then
		ls_Path_System = 'C:\Windows\SysWOW64'
	Else
		ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
	End If	
	
	dc_uo_api lo_api
	lo_api = Create dc_uo_api
	
	//Cria Diretorio NFCe
	If Not FileExists(ls_Path_dll) Then
		lo_Api.of_Create_Directory( ls_Path_dll )
	End If
	
	//Exclui DLL que possa existir no system32
	If FileExists(ls_Path_System + '\nfce.dll') Then
		fileDelete( ls_Path_System + '\nfce.dll' )
	End If
		
	If Not FileExists( 'c:\sistemas\cl\exe\nfce.dll' ) Then Return
	
	ls_filename = "C:\Sistemas\DLL\nfce\nfce.dll"
	
	If Not FileExists( ls_filename ) then
		FileMove( 'c:\sistemas\cl\exe\nfce.dll', ls_filename )
	Else
		
		//Comparacao de data
		ldt_Anterior 	= gvo_Aplicacao.of_data_criacao_arquivo( ls_filename )
		ldt_Atual		= gvo_Aplicacao.of_data_criacao_arquivo( "c:\sistemas\cl\exe\nfce.dll" )
		
		If ldt_Atual > ldt_Anterior Then
			If Not fileDelete( 'C:\Sistemas\DLL\nfce\nfce.dll' ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel excluir o arquivo: " + ls_filename + "~r~rAvise o depto. de Inform$$HEX1$$e100$$ENDHEX$$tica.")
				Return
			End If
					
			FileMove( 'c:\sistemas\cl\exe\nfce.dll', 'C:\Sistemas\DLL\nfce\nfce.dll' )	
		End If
			
	End If
Finally
	If IsValid( lo_api ) 			Then Destroy( lo_api ) 
	If IsValid(w_Aguarde_1) 	Then Close(w_Aguarde_1)
	
	If FileExists( 'c:\sistemas\cl\exe\nfce.dll' ) Then
		If Not fileDelete( 'c:\sistemas\cl\exe\nfce.dll' ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel excluir o arquivo: 'c:\sistemas\cl\exe\nfce.dll'.~r~rAvise o depto. de Inform$$HEX1$$e100$$ENDHEX$$tica.")
		End If
	End if
End Try
end subroutine

public subroutine of_atualiza_certificado ();String ls_filename
String ls_Ano
String ls_File

Try
	ls_Ano = String( Year( Date(gvo_Parametro.dh_movimentacao) ) )
	 
	ls_File =  "certificado_" + ls_Ano + ".pfx"
	 
	If Not FileExists( 'c:\sistemas\cl\exe\' + ls_File ) Then Return
	
	ls_filename = "C:\Sistemas\DLL\nfce\" + ls_File
	
	If FileExists( ls_filename ) Then
		If Not fileDelete( ls_filename ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel excluir o arquivo: " + ls_filename + ".~r~rAvise o depto. de Inform$$HEX1$$e100$$ENDHEX$$tica.")
			Return
		End If
	End if
		
	FileMove( 'c:\sistemas\cl\exe\' + ls_File, ls_filename )				

Finally
	If IsValid(w_Aguarde_1) 	Then Close(w_Aguarde_1)
End Try
end subroutine

public function boolean of_imprime_nota (string ps_chave_nota, string ps_protocolo, string ps_formato_cupom, string ps_contingencia, string ps_modo, decimal pdc_vl_recebido, decimal pdc_vl_troco, ref string ps_chave_retorno);Integer ll_Retorno
String ls_DataRec, ls_Vl_Recebido, ls_Troco
String ls_path
String ls_INI_nfce = "C:\Sistemas\CL\NFCe\nfceConfig.ini"
String ls_rtm_A4
DateTime ldh_data
Boolean lb_nova_nt = True

If pdv.ivb_Modo_Teste Then Return True

ldh_data = gf_getserverdate()		

/* ****SE PRECISAR DESCOMENTAR E ACERTAR VARIAVEL
If IsDate(This.dt_nova_NT) Then
	If ldh_data >= DateTime(This.dt_nova_NT) Then
		lb_nova_nt = True
	End If
End If */

ps_chave_retorno = Space(100)

If ps_modo = 'R' or ps_modo = 'A' Then	
	This.of_abre_doc()	
	
	ls_path 		= 'C:\Sistemas\CL\NFCe\Templates\'+ This.nr_versao_manual +'\Danfce'
	ls_rtm_A4 	= 'C:\Sistemas\CL\NFCe\Templates\' + This.nr_versao_manual + '\Danfce\retratoA4.rtm'
	
	If ps_modo = 'A' Then		
		If Not FileExists(ls_Path + '\retratoA4.rtm')  Then
			String   ls_Validar[]
			String   ls_Baixar[]
			
			ls_Validar = {"retratoA4.rtm"}
			ls_Baixar  = {"retratoA4.rtm"}			
			
			If Not gf_Download_Matriz(ls_Validar, ls_Baixar, ls_Path, "dll_nfce", True) Then
				Messagebox("NFC-e","Problemas para baixar o arquivo de impress$$HEX1$$e300$$ENDHEX$$o A4!"+&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
				Return False
			End If			
		End If	
	End If	
	
	If Not This.of_busca_xml_ftp(ps_chave_nota) Then Return False
End If

ls_Vl_Recebido	= gf_valor_com_ponto(pdc_vl_recebido)
ls_Troco			= gf_valor_com_ponto(pdc_vl_troco)

If lb_nova_nt Then
	ls_troco = ''
End If

If ps_modo = 'A' Then
	ll_retorno =	NFCe_Imprimir(ps_chave_nota,&
									  "C:\Sistemas\CL\NFCe\XmlDestinatario\",&
									 "",&
									 ps_contingencia, &
									 ls_rtm_A4, &
									 ls_Vl_Recebido,&
									 ls_troco,&
									 Ref ps_chave_retorno)	
Else
	ll_retorno =	NFCe_Imprimir(ps_chave_nota,&
									  "C:\Sistemas\CL\NFCe\XmlDestinatario\",&
									 This.nm_impressora_nfce,&
									 ps_contingencia, "", &
									 ls_Vl_Recebido,&
									 ls_Troco,&
									 Ref ps_chave_retorno)
End If

Choose Case ll_Retorno
	Case 1 				// Comando OK
		If ps_modo = 'R' or ps_modo = 'A' Then
			This.of_exclui_xml(ps_chave_nota)
		End If
		Return True
	Case 0 				// Erro ao executar comando
		Return False
	Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose	

Return False
end function

public function boolean of_grava_rejeicao (string ps_chave_nota, string ps_codigo_rejeicao);String lvs_Serie, ls_Status
Long lvl_Nr_NF
Long ll_Filial

Integer li_Contador

If pdv.ivb_Modo_Teste Then Return True

Try	
	ll_Filial = gvo_Parametro.cd_filial
	
	lvl_Nr_NF= Long(Mid(ps_chave_nota, 26, 9))
	lvs_Serie	= String(Long(Mid(ps_chave_nota, 23, 3)))
	
	Choose Case ls_Status
		Case '999', '108' //c$$HEX1$$f300$$ENDHEX$$digo de rejei$$HEX2$$e700e300$$ENDHEX$$o por servi$$HEX1$$e700$$ENDHEX$$o indispon$$HEX1$$ed00$$ENDHEX$$vel no momento
			ls_Status = 'I'
		Case Else
			ls_Status = 'P'
	End Choose
	
	//Verifica Se j$$HEX1$$e100$$ENDHEX$$ existe um registro da nota com status PENDENTE
	select count( nr_nf )
		Into :li_Contador
	From nfe_rejeicao
	Where cd_filial 	 	 = :ll_Filial 
		and nr_nf 		 =	:lvl_Nr_NF
		and de_especie = 'NFC'
		and de_serie	 = :lvs_Serie
		and id_status	 = 'P'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SQLCa.Of_Msgdberror( "Erro ao localizar a NF: " + String(lvl_Nr_NF) + " na tabela nfe_rejeicao (uo_ge039_nfe.of_grava_rejeicao())")
		Return False
	End If	
	
	If li_Contador = 0 Then //Se n$$HEX1$$e300$$ENDHEX$$o existe com a situa$$HEX2$$e700e300$$ENDHEX$$o P, insere o registro
	
		Insert into nfe_rejeicao(cd_filial, nr_nf, de_serie, de_especie, dh_rejeicao, cd_motivo_rejeicao, id_status)
		select p.cd_filial, :lvl_Nr_NF, :lvs_Serie, 'NFC', getdate(), :ps_codigo_rejeicao, :ls_Status
		from parametro p
		Where p.id_parametro = '1'
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.Of_Msgdberror( "Erro ao incluir nfe_rejeicao.")
			Return False
		End If
		
	End If

Catch (RuntimeError lvo_Erro)
	MessageBox("ERRO", lvo_erro.GetMessage(), StopSign!)
	Return False
	
Finally
	//
End Try

Return True
end function

public function boolean of_totais_nfce (decimal pd_total_bc, decimal pd_total_icms, decimal pd_total_bcst, decimal pd_total_st, decimal pd_total_produtos, decimal pd_total_frete, decimal pd_total_seg, decimal pd_total_desc, decimal pd_total_ii, decimal pd_total_ipi, decimal pd_total_pis, decimal pd_total_cofins, decimal pd_total_outros, decimal pd_total_nf, decimal pd_total_tributos, string ps_mod_frete, string ps_formas_pgto[], decimal ps_valores_pgto[], decimal pd_troco, ref string ps_chave_nota, string ps_dados_tef[], string ps_envia_responsavel, decimal ps_total_icms_desonerado, string ps_inf_adicional, string ps_inf_fisco, string ps_cnpj_intermediario, string ps_codigo_interm);String ls_Total_BC, &
		 ls_Total_ICMS, &
		 ls_Total_BCST, &
		 ls_Total_ST, &
		 ls_Total_produtos, &
		 ls_Frete, &
		 ls_Seguro, &
		 ls_total_desconto, &
		 ls_total_PIS, &
		 ls_total_COFINS, &
		 ls_outros, &
		 ls_total_NF, &
		 ls_total_tributos, &
		 ls_valores_pgto, &
		 ls_zero, &
		 ls_Pagto, &
		 ls_Valor_Pagto, &
		 ls_chave_nota, &
		 ls_bandeira, &
		 ls_autorizacao_tef, &
		 ls_cnpj_tef, &
		 ls_cod_bandeira, &
		 ls_troco

String ls_Total_Icms_Desonerado
		 
Long	ll_ind
Integer ll_Retorno
Decimal {2} ldc_valor
Decimal {2} ldc_PIS, ldc_COFINS
Boolean lb_troco = False
DateTime ldh_data
Boolean lb_nova_nt = True

If pdv.ivb_Modo_Teste Then 
	ps_chave_nota = '00000000000000000000000000000000000000000000'
	Return True
End If

ldh_data = gf_getserverdate()		

/* ***SE PRECISAR DESCOMENTAR E ACERTAR VALOR VARIAVEL
If IsDate(This.dt_nova_NT) Then
	If ldh_data >= DateTime(This.dt_nova_NT) Then
		lb_nova_nt = True
	End If
End If */

//Na inclus$$HEX1$$e300$$ENDHEX$$o do item s$$HEX1$$e300$$ENDHEX$$o usada 3 casas para o calculo ficar correto
//Para o SEFAZ deve ser enviado 2 casas, uso o Truncate porque tem casos que o arredondadmento faz errado.
ldc_PIS 							= Truncate( pd_total_pis , 2)
ldc_COFINS 						= Truncate( pd_total_cofins , 2 )
ps_total_icms_desonerado 	= Truncate( ps_total_icms_desonerado , 2 )

ls_zero 							= '0.00'
ls_Total_BC						= gf_valor_com_ponto(pd_total_bc)
ls_Total_ICMS					= gf_valor_com_ponto(pd_total_icms)
ls_Total_BCST					= gf_valor_com_ponto(pd_total_bcst)
ls_Total_ST						= gf_valor_com_ponto(pd_total_st)
ls_Total_produtos				= gf_valor_com_ponto(pd_total_produtos)
ls_frete							= gf_valor_com_ponto(pd_total_frete)
ls_Seguro						= gf_valor_com_ponto(pd_total_seg)
ls_Total_desconto				= gf_valor_com_ponto(pd_total_desc)
ls_Total_PIS						= gf_valor_com_ponto(pd_total_pis)
ls_Total_COFINS				= gf_valor_com_ponto(pd_total_cofins)
ls_outros							= gf_valor_com_ponto(pd_total_outros)
ls_Total_NF						= gf_valor_com_ponto(pd_total_nf)
ls_Total_Tributos				= gf_valor_com_ponto(pd_total_tributos)
ls_Total_Icms_Desonerado 	= gf_valor_com_ponto(ps_total_icms_desonerado)

ll_retorno = NFCe_Totais(ls_Total_BC,&
				ls_Total_ICMS,&
				ls_Total_Icms_Desonerado,&
				ls_Total_BCST,&
				ls_Total_ST,&
				ls_Total_produtos,&
				ls_frete,&				
				ls_Seguro,&
				ls_Total_desconto,&
				ls_zero,&
				ls_zero,&
				ls_Total_PIS,&
				ls_Total_COFINS,&
				ls_outros,&
				ls_Total_NF,&
				ls_Total_Tributos,&
				'9',&
				ps_inf_adicional,&
				ps_inf_fisco)
//				'01',&
//				ls_Total_NF)

If ll_retorno = 1 Then

//	ll_Retorno = NFCe_FormasPagamento('01',ls_Total_NF)	
	For ll_ind = 1 TO UpperBound(ps_formas_pgto)
		
		lb_troco = False
		ls_Pagto  	 	= MidA(ps_formas_pgto[ll_ind],1,2)
		Choose Case ls_Pagto
			Case "02", "03"   //cheques
				ls_Pagto = "02"
			Case "04"  //cart$$HEX1$$e300$$ENDHEX$$o cr$$HEX1$$e900$$ENDHEX$$dito
				ls_Pagto = "03"
			Case "05"  //cart$$HEX1$$e300$$ENDHEX$$o d$$HEX1$$e900$$ENDHEX$$bito
				ls_Pagto = "04"
			Case "06", "07", "08", "09"  //clube - conv$$HEX1$$ea00$$ENDHEX$$nio - crediario
				ls_Pagto = "05"
			Case "10"	//PBMs
				ls_Pagto = "99"
			Case "17", "18"
				//n$$HEX1$$e300$$ENDHEX$$o altera PIX ou outra carteira digital
			Case Else
				ls_Pagto = "01"
		End Choose
		
		If ls_Pagto = "01" And pd_troco > 0 Then
			lb_troco = True
			ldc_valor = ps_valores_pgto[ll_ind]			
			If not lb_nova_nt Then
				If ldc_valor > pd_troco Then
					ldc_valor = ldc_valor - pd_troco
				Else
					ldc_valor = pd_troco - ldc_valor
				End If
			End If
			ls_valor_pagto  = gf_valor_com_ponto(ldc_valor)			
		Else
			lb_troco = False
			ls_valor_pagto  = gf_valor_com_ponto(ps_valores_pgto[ll_ind])			
		End If
		
		ls_bandeira 			= ""
		ls_autorizacao_tef = ""
		ls_cnpj_tef 			= ""
		ls_cod_bandeira 	= ""
		
		If ls_Pagto = "99" Then
			ls_cod_bandeira	 		= Trim(ps_dados_tef[ll_ind])
		End If		
		
		If ls_Pagto = "03" Or ls_Pagto = "04" Then
			If Not IsNull(ps_dados_tef[ll_ind]) And Trim(ps_dados_tef[ll_ind]) > "" Then
				ls_bandeira 	 		= Trim(gf_captura_valor(ps_dados_tef[ll_ind], "|", 1, false))
				ls_cod_bandeira 	= ls_bandeira
				ls_autorizacao_tef	= Trim(gf_captura_valor(ps_dados_tef[ll_ind], "|", 2, false))
				ls_cnpj_tef 			= Trim(gf_captura_valor(ps_dados_tef[ll_ind], "|", 3, false))				
			End If			
		End If
		
		ll_Retorno = NFCe_FormasPagamento(ls_Pagto, ls_valor_pagto, ls_cod_bandeira, ls_autorizacao_tef, ls_cnpj_tef, '','','')	

		Choose Case ll_Retorno
			Case 0 				// Erro ao executar comando
				Return False
			Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
				Return False
		End Choose	
		
		If lb_nova_nt Then
			If lb_troco Then
				ls_troco 		= gf_valor_com_ponto(pd_troco)
				ll_Retorno 	= NFCe_FormasPagamento('', '', '', '', '', ls_troco,'','')	
				
				Choose Case ll_Retorno
					Case 0 				// Erro ao executar comando
						Return False
					Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
						Return False
				End Choose				
			End If	
		End If	
		
		If ll_ind = UpperBound(ps_formas_pgto)  Then //Ultima linha de pagamentos, vai enviar dados de intermediario se existir.
			If Not IsNull(ps_codigo_interm)  And  Trim(ps_codigo_interm) <> ''  Then			
				If Not IsNull(ps_cnpj_intermediario)  And  Trim(ps_cnpj_intermediario) <> ''  Then
					ll_Retorno 	= NFCe_FormasPagamento('', '', '', '', '', '', ps_cnpj_intermediario, ps_codigo_interm)
					
					Choose Case ll_Retorno
						Case 0 				// Erro ao executar comando
							Return False
						Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
							Return False
					End Choose
				End If
			End if
		End If
	Next
Else
	Return False
End If

//Monta dados intermediador

ls_chave_nota = Space(50)
ll_Retorno = NFCe_SalvarNota(Ref ls_chave_nota, ps_envia_responsavel)

Choose Case ll_Retorno
	Case 1 				// Comando OK
		ps_chave_nota = ls_chave_nota
		Return True
	Case 0 				// Erro ao executar comando
		Return False
	Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose	

Return False;
end function

public function boolean of_cabecalho_nfce (string ps_nr_nf, string ps_forma_pagamento, string ps_natureza_operacao, datetime pdt_emissao, string ps_tipo_impressao, string ps_forma_emissao, string ps_finalidade, string ps_consumidor, string ps_ind_presenca, string ps_intermediador, string ps_cpf_transp, string ps_cnpj_transp, string ps_nome_transp, string ps_end_transp, string ps_cidade_transp, string ps_uf_transp);Integer 	ll_Retorno, &
			ll_randomico
String		ls_versao, &
			ls_Codigo_uf, &
			ls_Pagamento, &
			ls_Modelo, &
			ls_Serie, &
			ls_Tipo_NF, &
			ls_Destino_operacao, &
			ls_cod_cidade, &
			ls_DV_acesso, &
			ls_Data_contingencia, &
			ls_Justificativa, &
			ls_fuso
Boolean lb_nova_nt

String ps_Controle_Interno

If pdv.ivb_Modo_Teste Then Return True

ls_fuso = gvo_parametro.de_fuso_horario_NFCE

ps_Controle_Interno	= String(pdt_emissao, 'YYSSHHMM')
		
ls_versao 				= "4.00"		
ls_modelo 				= "65"
ls_Tipo_NF				= "1"
ls_Destino_operacao 	= "1"
ls_DV_Acesso			= ""
ls_Serie					= gvo_parametro.de_serie_NFCE
ls_cod_cidade			= gvo_parametro.cd_cidade_ibge
This.of_codigo_uf(gvo_parametro.ivs_uf_filial, Ref ls_Codigo_uf)

Choose Case ps_forma_pagamento
	Case "AV"
		ls_Pagamento = "0"
	Case Else
		ls_Pagamento = "1"
End Choose

If ps_forma_emissao = "9" Then
	ls_data_contingencia  = String(pdt_emissao,'YYYY-mm-dd"T"HH:mm:ss')+ls_fuso
	ls_justificativa			= 'SEM COMUNICACAO COM O SEFAZ'
	ivb_contingencia		= True
Else
	ls_data_contingencia  = ''
	ls_justificativa			= ''
	ivb_contingencia		= False
End If

ps_nome_transp  = of_retira_caracteres(ps_nome_transp)
ps_end_transp 	   = of_retira_caracteres(ps_end_transp)
ps_cidade_transp = of_retira_caracteres(ps_cidade_transp)

ll_Retorno = NFCe_Cabecalho( ls_versao,&
						ls_codigo_uf,&
						ps_Controle_Interno,&
						ps_natureza_operacao,&
						ls_pagamento,&
						ls_modelo,&
						ls_serie,&
						ps_nr_nf,&
						String(pdt_emissao,'YYYY-mm-dd"T"HH:mm:ss')+ls_fuso,&
						ls_tipo_NF,&
						ls_destino_operacao,&
						ls_cod_cidade,&
						ps_tipo_impressao,&
						ps_forma_emissao,&
						ls_DV_Acesso,&
						This.id_homologacao,&
						ps_finalidade,&
						ps_consumidor,&
						ps_ind_presenca,&
						'0',&
						'000',&
						ls_data_contingencia,&
						ls_justificativa,&
						ps_intermediador,&
						ps_cpf_transp,&
						ps_cnpj_transp,&
						ps_nome_transp,&
						ps_end_transp,&
						ps_cidade_transp,&
						ps_uf_transp) 

Choose Case ll_Retorno
	Case 1 				// Comando OK
		Return True
	Case 0 				
		Return False
	Case -1 				
		Return False
End Choose	

Return False
end function

public function boolean of_registra_item_nfce (long pl_item, string ps_produto, string ps_codigo_barras, string ps_descricao, long pl_ncm, long pl_cfop, string ps_unidade_medida, long pl_quantidade, decimal pd_valor_unitario, string ps_regra_calculo, decimal pd_valor_desconto, decimal pd_valor_outros, decimal pd_total_tributos, string ps_origem, string ps_cst_tributacao_icms, decimal pd_aliquota_icms, string ps_tributacao_pis_cofins, string ps_inf_adicionais, decimal pd_preco_praticado, ref decimal pd_total_icms, ref decimal pd_total_base_icms, string ps_cest, string ps_tributacao_icms_cadastro, decimal pd_red_bc_icms_efe, decimal pd_bc_icms_efe, decimal pd_icms_efe, decimal pd_valor_icms_efe, string ps_beneficio, integer pi_nr_item, decimal pd_vl_icms_desonerado, string ps_id_motivo_desoneracao, string ps_codigo_sap, string ps_cst_pis_cofins);Integer ll_Retorno

String	lvs_tributos,&
      	lvs_precounit,&
		lvs_total_prod,&
		lvs_total_praticado,&
	   	lvs_outros,&
	   	lvs_desconto,&
	   	lvs_trib_icms,&
		lvs_base_icms,&
		lvs_pis_cofins,&
		lvs_qtd_pis_cofins,&
		lvs_valor_pis_cofins,&
		lvs_aliq_pis = '1.65',&
		lvs_aliq_cofins = '7.60',&
		lvs_descricao, &
		lvs_item, &
		lvs_valor_icms, &
		lvs_valor_pis, &
		lvs_valor_cofins, &
		lvs_NCM, &
		lvs_CEST, &
		lvs_cod_barras, &
		lvs_pRedBCEfet, &
		lvs_vBCEfet, &
		lvs_pICMSEfet, &
		lvs_vICMSEfet

String ls_Icms_Desonerado

Decimal {3} ldc_valor_icms
Decimal {2} ldc_valor_pis
Decimal {2} ldc_valor_cofins
Decimal {2} ldc_total_item
String ls_nulo
SetNull(ls_nulo)

If pdv.ivb_Modo_Teste Then Return True

If IsNull(ps_codigo_barras) Or Trim(ps_codigo_barras) = '' Or ps_produto = '723786' Then //Passebus
	lvs_cod_barras = 'SEM GTIN'
Else
	lvs_cod_barras = ps_codigo_barras
End If

lvs_item 					= String(pl_item)
lvs_NCM					= String(pl_NCM,'00000000')
lvs_precounit			= gf_valor_com_ponto(pd_valor_unitario)
lvs_total_prod			= gf_valor_com_ponto(pd_valor_unitario * pl_quantidade)
lvs_total_praticado 	= gf_valor_com_ponto(pd_preco_praticado * pl_quantidade)
ls_Icms_Desonerado 	= gf_valor_com_ponto(pd_vl_icms_desonerado)

If pd_valor_desconto = 0 Then
	lvs_desconto = ls_nulo
Else
	lvs_desconto  	= gf_valor_com_ponto(pd_valor_desconto)
End If
If pd_valor_outros = 0 Then
	lvs_outros = ls_nulo
Else
	lvs_outros  	= gf_valor_com_ponto(pd_valor_outros)
End If

lvs_tributos  	= gf_valor_com_ponto(pd_total_tributos)
lvs_trib_icms 	= gf_valor_com_ponto(pd_aliquota_icms)

lvs_CEST = ls_nulo
If ps_cst_tributacao_icms = "00" Then
	lvs_base_icms = lvs_total_praticado
	ldc_total_item = Round(pd_preco_praticado * pl_quantidade , 2)
	ldc_valor_icms = Round(ldc_total_item * (pd_aliquota_icms / 100) , 2 )
	lvs_valor_icms = gf_valor_com_ponto(ldc_valor_icms)
	pd_total_base_icms = pd_preco_praticado * pl_quantidade	
Else
	If ps_cst_tributacao_icms = "60" Then		
		lvs_CEST = ps_Cest
		If (IsNull(lvs_CEST) Or Trim(lvs_CEST) = '') And (ps_tributacao_icms_cadastro = '0' Or ps_tributacao_icms_cadastro = '2') Then
			lvs_CEST = '0000000'	
		End If
	End If
	lvs_base_icms 			= "0.000"
	lvs_valor_icms 			= "0.000"
	pd_total_base_icms	= 000.00
End If

If Not IsNull(pd_icms_efe) Then
	lvs_pRedBCEfet = gf_valor_com_ponto(pd_red_bc_icms_efe)
	lvs_vBCEfet		= gf_valor_com_ponto(pd_bc_icms_efe)
	lvs_pICMSEfet	= gf_valor_com_ponto(pd_icms_efe)
	lvs_vICMSEfet	= gf_valor_com_ponto(pd_valor_icms_efe)
Else
	lvs_pRedBCEfet = "0.000"
	lvs_vBCEfet		= "0.000"
	lvs_pICMSEfet	= "0.000"
	lvs_vICMSEfet	= "0.000"
End If

pd_total_icms = ldc_valor_icms
lvs_pis_cofins = ps_cst_Pis_Cofins //objeto uo_tratamento_fiscal

lvs_qtd_pis_cofins		= "0"
lvs_valor_pis_cofins 	= "0.000"
lvs_aliq_pis 				= "0.000"
lvs_aliq_cofins 			= "0.000"
lvs_valor_pis			= "0.000"
lvs_valor_cofins		= "0.000"

If ps_tributacao_pis_cofins = 'T' And lvs_pis_cofins = '01' Then
	lvs_qtd_pis_cofins		= String(pl_quantidade)
	lvs_valor_pis_cofins 	= lvs_total_praticado
	ldc_valor_pis			= ((pd_preco_praticado * pl_quantidade) * 1.65) / 100
	lvs_valor_pis			= gf_valor_com_ponto(ldc_valor_pis)
	ldc_valor_cofins		= ((pd_preco_praticado * pl_quantidade) * 7.60) / 100
	lvs_valor_cofins		= gf_valor_com_ponto(ldc_valor_cofins)
End If

/*
Choose Case ps_tributacao_pis_cofins
	Case "N"
		lvs_pis_cofins			= '06'
		lvs_qtd_pis_cofins		= "0"
		lvs_valor_pis_cofins 	= "0.000"
		lvs_aliq_pis 				= "0.000"
		lvs_aliq_cofins 			= "0.000"
		lvs_valor_pis			= "0.000"
		lvs_valor_cofins		= "0.000"
	Case "T"
		lvs_pis_cofins			= '01'
		lvs_qtd_pis_cofins		= String(pl_quantidade)
		lvs_valor_pis_cofins 	= lvs_total_praticado
		ldc_valor_pis			= ((pd_preco_praticado * pl_quantidade) * 1.65) / 100
		lvs_valor_pis			= 	gf_valor_com_ponto(ldc_valor_pis)
		ldc_valor_cofins		= ((pd_preco_praticado * pl_quantidade) * 7.60) / 100
		lvs_valor_cofins		= 	gf_valor_com_ponto(ldc_valor_cofins)		
	Case "P"
		lvs_pis_cofins			= '04'
		lvs_qtd_pis_cofins		= "0"
		lvs_valor_pis_cofins 	= "0.000"
		lvs_aliq_pis 				= "0.000"
		lvs_aliq_cofins 			= "0.000"
		lvs_valor_pis			= "0.000"
		lvs_valor_cofins		= "0.000"
End Choose
*/

lvs_Descricao = ps_descricao
lvs_Descricao = gf_replace(lvs_Descricao, '>', ' ', 0)
lvs_Descricao = gf_replace(lvs_Descricao, '<', ' ', 0)
lvs_Descricao = gf_replace(lvs_Descricao, '&', 'e', 0)
lvs_Descricao = gf_replace(lvs_Descricao, '"', ' ', 0)
lvs_Descricao = gf_replace(lvs_Descricao, "'", ' ', 0)
lvs_Descricao = gf_replace(lvs_Descricao, '$$HEX3$$a000a000a000$$ENDHEX$$', '', 0)
lvs_Descricao = Trim(lvs_descricao)

If This.id_homologacao = '2' Then // Regra Sefaz, primiero item da venda em ambiente homologacao a descri$$HEX2$$e700e300$$ENDHEX$$o deve ser como definida.
	//If pl_item = 1 Then
		lvs_descricao = 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL'
	//End If
End If

If Not IsNull(ps_codigo_sap) And Trim(ps_codigo_sap) > '' Then
	ps_produto = ps_codigo_sap
End If

ll_Retorno =	 NFCe_Item( String(pi_Nr_Item),&
								ps_produto,&
								lvs_cod_barras,&
								lvs_descricao,&
								lvs_NCM,&
								String(pl_CFOP),&
								ps_unidade_medida,&
								String(pl_quantidade),&
								lvs_precounit,&
								lvs_total_prod,&
								lvs_cod_barras,&
								ps_unidade_medida,&
								String(pl_quantidade),&
								lvs_precounit,&
								lvs_desconto,&
								'1',&
								lvs_tributos,&
								ps_origem,&
								ps_cst_tributacao_icms,&
								'3',&
								lvs_base_icms,&
								lvs_trib_icms,&
								lvs_valor_icms,&
								lvs_pis_cofins,&
								lvs_valor_pis_cofins,&
								lvs_aliq_pis,&
								lvs_valor_pis,&
								lvs_pis_cofins,&
								lvs_valor_pis_cofins,&
								lvs_aliq_cofins,&
								lvs_valor_cofins, &
								lvs_CEST, &
								lvs_pRedBCEfet, &
								lvs_vBCEfet, &
								lvs_pICMSEfet, &
								lvs_vICMSEfet, &
								ps_beneficio, &
								ls_Icms_Desonerado, &
								ps_Id_Motivo_Desoneracao)	

Choose Case ll_Retorno
	Case 1 				// Comando OK
		Return True
	Case 0 				// Erro ao executar comando
		Return False
	Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose	

Return False
end function

public function boolean of_inutiliza_nfce (long pl_filial, string ps_serie, long pl_nr_inicial, long pl_nr_final, string ps_justificativa, ref string ps_erro);String ls_retorno, ls_Status, ls_Motivo, ls_Data_Evento, ls_Protocolo, ls_ano, ls_CNPJ_Filial, ls_UF_Filial
Long ll_Retorno, ll_Qtde, ll_Nota

ls_retorno = Space(10000)
ls_Status = Space(100)
ls_Motivo = Space(500)
ls_Data_Evento = Space(100)
ls_Protocolo = Space(100)

Try
	//Confirma que o n$$HEX1$$fa00$$ENDHEX$$mero final $$HEX1$$e900$$ENDHEX$$ maior que o inicial
	If pl_nr_final > pl_nr_inicial Then 
		ps_erro = "N$$HEX1$$fa00$$ENDHEX$$mero inicial deve ser maior que o n$$HEX1$$fa00$$ENDHEX$$mero final."
		Return False 
	End If
	
	//Busca CNPJ e UF da filial
	Select fil.nr_cgc, cid.cd_unidade_federacao
	Into :ls_CNPJ_Filial, :ls_UF_Filial
	From filial fil
	Inner join cidade cid on cid.cd_cidade = fil.cd_cidade
	Where cd_filial = :pl_filial
	Using SQLCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_erro = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel buscar o CNPJ da filial ["+String(pl_filial)+"].~rErro: "+SqlCa.SqlErrText+"."
		Return False
	End If
	
	//Carrega par$$HEX1$$e200$$ENDHEX$$metros
	This.of_abre_doc(ls_UF_Filial, ls_CNPJ_Filial)
	//Ano com 2 d$$HEX1$$ed00$$ENDHEX$$gitos
	ls_ano = RightA(String(Date( gf_GetServerDate() )), 2)
	//Chama a fun$$HEX2$$e700e300$$ENDHEX$$o
	ll_Retorno = NFCe_Inutilizar( &
		/* Ano */					ls_ano, &
		/* CNPJ Emitente*/		ls_CNPJ_Filial, &
		/* Modelo */				'65', &
		/* S$$HEX1$$e900$$ENDHEX$$rie */					ps_serie, &
		/* N$$HEX1$$ba00$$ENDHEX$$ Inicial */				String(pl_nr_inicial), &
		/* N$$HEX1$$ba00$$ENDHEX$$ Final */				String(pl_nr_final), &
		/* Justificativa*/			ps_justificativa, &
		/* Mensgem Retorno */	Ref ls_retorno, &
		/* Status */					Ref ls_Status, &
		/* Motivo */					Ref ls_Motivo, &
		/* Data Reg. Evento*/	Ref ls_Data_Evento,&
		/* Protocolo */				Ref ls_Protocolo)				
	
	If ll_retorno = 1 Then					
		//Efetua um loop do n$$HEX1$$fa00$$ENDHEX$$mero inicial ao final
		For ll_Nota = pl_nr_inicial To pl_nr_final
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// Caso obtenha sucesso na inutiliza$$HEX2$$e700e300$$ENDHEX$$o, ou a numera$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ tenha sido anteriormente inutilizada 	//
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 102	-> Inutilizacao de numero homologado																	//
			// 563	-> Rejeicao: Ja existe pedido de Inutilizacao com a mesma faixa de inutilizacao				//
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			If (ls_Status = "102") or (ls_Status = "563") Then
				//Verifica se j$$HEX1$$e100$$ENDHEX$$ j$$HEX1$$e100$$ENDHEX$$ um registro gravado de inutiliza$$HEX2$$e700e300$$ENDHEX$$o
				select count(1)
				into :ll_Qtde
				from nfe_inutilizacao
				where	cd_filial		= :pl_filial
					and	nr_nf			= :ll_Nota
					and	de_especie	= 'NFC'
					and	de_serie		= :ps_serie
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ps_erro = "Erro no select da tabela 'nfe_inutilizacao': "+SqlCa.SqlErrText+"."
					Return False
				End If
				
				//Se ainda n$$HEX1$$e300$$ENDHEX$$o possui registro na tabela de inutiliza$$HEX2$$e700e300$$ENDHEX$$o
				If ll_Qtde = 0 Then
					//Insere registro
					insert into nfe_inutilizacao(	cd_filial,
														nr_nf,
														de_especie,
														de_serie,
														dh_inutilizacao,
														nr_protocolo,
														nr_matricula)
					values(	:pl_Filial,
								:ll_Nota,
								'NFC',
								:ps_Serie,
								getDate(),
								:ls_Protocolo,
								:gvo_Aplicacao.ivo_Seguranca.nr_matricula)
					Using SqlCa;	
					
					If SqlCa.SqlCode = -1 Then
						ps_erro	= "Erro no insert da tabela 'nfe_inutilizacao': "+SqlCa.SqlErrText+"."
						SqlCa.of_RollBack()
						Return False
					End If			
				End If
			Else
				//Retorno do Sefaz diferente do esperado
				ps_erro = ls_Status + " - " + ls_retorno
				Return False
			End If
		Next
		Return True
	End If	
	//messageBox("", "Ret: " + String( ll_Retorno ) +' - Ret: ' + ls_retorno + ' - Status: ' + ls_Status + ' - Prot: ' + ls_Protocolo )
	
Catch (RuntimeError lvo_Erro)
	SQLCa.Of_RollBack()
	ps_erro = lvo_Erro.GetMessage()
	Return False
	
Finally
	//
End Try

//Return ll_Retorno <> 1
end function

public function boolean of_abre_doc (string ps_uf_filial, string ps_cnpj_filial);Integer ll_Retorno
String ls_nulo
String ls_uf_filial
String ls_cnpj
Boolean lb_nova_nt = False

SetNull(ls_nulo)

SetNull(This.dt_data_recebimento)

ls_uf_filial 	= ps_uf_filial
ls_cnpj 		= ps_cnpj_filial
/*
If IsDate(This.dt_nova_NT) Then
	If gf_getserverdate() >= DateTime(This.dt_nova_NT) Then
		lb_nova_nt = True
	End If
End If

If lb_nova_nt Then   //Se for necess$$HEX1$$e100$$ENDHEX$$rio novamente usar o parametro.
	ll_Retorno = NFCe_ConfiguraParametros(ls_uf_filial, ls_cnpj, "vm60")
	This.nr_versao_manual = "vm60"
Else
	ll_Retorno = NFCe_ConfiguraParametros(ls_uf_filial, ls_cnpj, "vm50b")
	This.nr_versao_manual = "vm50b"
End If */

ll_Retorno = NFCe_ConfiguraParametros(ls_uf_filial, ls_cnpj, "vm60")
This.nr_versao_manual = "vm60"

//Seta os protocolos de comunica$$HEX2$$e700e300$$ENDHEX$$o TLS 1.2, devido a migra$$HEX2$$e700e300$$ENDHEX$$o dos NFCe para 4.00, $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio o uso desse protocolo
//Seta SSL 3.0
//Seta TLS 1.0
//Seta TLS 1.2
If Upper(This.id_atualiza_tls) = 'S' Then
	If RegistrySet( "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "SecureProtocols", ReguLong!, 2208 ) = -1 Then
		gvo_aplicacao.of_grava_log("uo_ge039_nfce - of_abreporta - Erro ao tentar alterar os registros de protolocos TLS 1.2.")	
	End If
End If

Choose Case ll_Retorno
	Case 1 				// Comando OK		
		Return True
	Case 0 				// Erro ao executar comando
		Return False
	Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False		
End Choose	

Return False
end function

public function boolean of_abre_doc ();Return This.Of_Abre_Doc(gvo_parametro.ivs_uf_filial, gvo_parametro.nr_cgc)
end function

public function boolean of_carrega_parametro_nfc_matriz (long pl_filial);//Fun$$HEX2$$e700e300$$ENDHEX$$o usada para buscar os dados de TOKEN e IDTOKEN do NFC-e da loja
//Usado somente em sistemas da matriz, que o parametro_loja $$HEX1$$e900$$ENDHEX$$ por filial

String ls_id_token, ls_nr_token
Boolean lb_valor_invalido = false

select (select pl.vl_parametro from dbo.parametro_loja pl where pl.cd_parametro = 'NR_ID_TOKEN_NFCE' and pl.cd_filial = :pl_filial) as id_token,
         (select pl.vl_parametro from dbo.parametro_loja pl where pl.cd_parametro = 'NR_TOKEN_NFCE' and pl.cd_filial = :pl_filial) as nr_token
	into :ls_id_token, :ls_nr_token
    from dbo.parametro p
	where p.id_parametro = '1'
	Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	MessageBox("Erro", "Erro no select da tabela 'parametro_loja': "+SqlCa.SqlErrText+".")
	Return False
End If

If IsNull(ls_id_token) Or Trim(ls_id_token) = "" Or Trim(ls_id_token) = "?" Then lb_valor_invalido = true
If IsNull(ls_nr_token) Or Trim(ls_nr_token) = "" Or Trim(ls_nr_token) = "?" Then lb_valor_invalido = true

If lb_valor_invalido Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metros de Token NFC-e inexistentes ou inv$$HEX1$$e100$$ENDHEX$$lidos para a filial "+String(pl_Filial)+".")
	Return False
Else
	This.id_token_matriz = ls_id_token
	This.nr_token_matriz = ls_nr_token
End If

Return True
end function

public function boolean of_abre_porta_inutilizacao (long pl_filial, string ps_uf, string ps_cnpj, long pl_ambiente);//Fun$$HEX2$$e700e300$$ENDHEX$$o similar a of_abreporta(), usada SOMENTE no sitema FISCAL DA MATRIZ para inutiliza$$HEX2$$e700e300$$ENDHEX$$o de notas.
Long ll_Retorno
String ls_INI
String ls_INI_nfce = "C:\Sistemas\CL\NFCe\nfceConfig.ini"
String ls_Diretorio_log = "C:\Sistemas\CL\NFCe\log\"
String ls_verificacao = "C:\Sistemas\CL\NFCe\Templates\vm60\Conversor\NFCeDataSets.xml"
String ls_ambiente_nfce
String ls_arquivos[]
String ls_serv_mail
String ls_Imagem
Boolean lb_nova_nt

If Not This.of_carrega_parametro_nfc_matriz( pl_filial ) Then Return False

ls_INI  = gvo_Aplicacao.ivs_Arquivo_INI

ls_ambiente_nfce = ProfileString(ls_INI, "ECF", "Homologacao_NFCE","")
This.nm_impressora_nfce = ProfileString(ls_INI, "ECF" , "NomeImpressora" , "")
//1 = Normal   -  2 = Homologcao
This.id_homologacao = String(pl_ambiente)

If FileExists(ls_INI_nfce) Then
	SetProfileString(ls_INI_nfce, "NFCE", "UF", ps_UF)
	SetProfileString(ls_INI_nfce, "NFCE", "CNPJ", ps_cnpj)	
	SetProfileString(ls_INI_nfce, "DANFCE", "TokenNFce", This.nr_token_matriz)			
	SetProfileString(ls_INI_nfce, "DANFCE", "idTokenNFce", This.id_token_matriz)			
	
	SetProfileString(ls_INI_nfce, "NFCE", "VersaoManual", "6.0")
	SetProfileString(ls_INI_nfce, "DANFCE", "ModeloRetrato", "C:\Sistemas\CL\NFCe\Templates\vm60\Danfce\retrato.rtm")
	SetProfileString(ls_INI_nfce, "DANFCE", "ModeloDanfce", "C:\Sistemas\CL\NFCe\Templates\vm60\Danfce\retrato.rtm")			
	
	ls_serv_mail = ProfileString(ls_INI_nfce, "MAIL" , "Servidor" , "")
	If IsNull(ls_serv_mail) Or Trim(ls_serv_mail) = '' Or Trim(ls_serv_mail) = "10.0.0.15" Then
		SetProfileString(ls_INI_nfce, "MAIL", "Servidor", "172.19.2.100")
		SetProfileString(ls_INI_nfce, "MAIL", "EmailRemetente", "nfe@clamed.com.br")
		SetProfileString(ls_INI_nfce, "MAIL", "Assunto", "XML CFe - CIA LATINO AMERICANA DE MEDICAMENTOS")
		SetProfileString(ls_INI_nfce, "MAIL", "Mensagem", "'O arquivo est$$HEX1$$e100$$ENDHEX$$ anexo.'")
		SetProfileString(ls_INI_nfce, "MAIL", "Usuario", "scanner@clamedlocal.com.br")
		SetProfileString(ls_INI_nfce, "MAIL", "Senha", "he3-sWetHlKl")
		SetProfileString(ls_INI_nfce, "MAIL", "Autenticacao", "1")
		SetProfileString(ls_INI_nfce, "MAIL", "Porta", "587")
	End If	
	
	If Trim(Upper(gvo_parametro.id_rede_filial)) = 'FA' Then
		ls_Imagem = "farmagora"
	Else
		ls_Imagem = Trim(Upper(gvo_parametro.id_rede_filial))
	End If
	
	IF FileExists("C:\Sistemas\CL\Arquivos\Imagens\" + ls_imagem + ".jpg") Then
		SetProfileString(ls_INI_nfce, "DANFCE", "LogotipoEmitente", "C:\Sistemas\CL\Arquivos\Imagens\" + ls_imagem + ".jpg")			
	Else
		SetProfileString(ls_INI_nfce, "DANFCE", "LogotipoEmitente", "")			
	End If
		
Else
	Messagebox("NFC-e","Arquivo INI do NFCe n$$HEX1$$e300$$ENDHEX$$o existe no PDV!", StopSign!)	
	Return False
End If

//Limpa diretorio de logs da NFCe no PDV, quando possuir mais de 500 arquivos o diretorio $$HEX1$$e900$$ENDHEX$$ limpo.
gf_dir_list( ls_Diretorio_log, '*.xml', 0+1, Ref ls_Arquivos )
If UpperBound( ls_Arquivos ) > 500 Then
	gf_limpa_diretorio( ls_Diretorio_log )
End If

This.ivb_Porta_Aberta = True

Return True
end function

on uo_ge039_nfce.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge039_nfce.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//This.of_fecha_conexao()
end event

event constructor;This.of_atualiza_dlls()
This.of_atualiza_certificado()
This.of_carrega_data_nt()

//Quando realizar testes em homologacao de novas lojas
//Fun$$HEX2$$e700e300$$ENDHEX$$o utilizada para INUTILIZAR NOTAS ////////This.of_teste()
end event

