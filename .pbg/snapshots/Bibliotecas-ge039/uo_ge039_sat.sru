HA$PBExportHeader$uo_ge039_sat.sru
forward
global type uo_ge039_sat from nonvisualobject
end type
end forward

global type uo_ge039_sat from nonvisualobject
end type
global uo_ge039_sat uo_ge039_sat

type prototypes
Function integer SAT_ConfiguraParametros(	String a_UF,&
															String a_CNPJ,&
															String a_CNPJ_Soft,&
															String a_CodigoAtivacao)LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_ConfiguraParametros;Ansi"

Function integer SAT_Cabecalho(	String a_versao,&
										   	String a_CNPJs,&
											String a_CNPJc,&
											String a_assinatura,&
											String a_caixa_venda) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Cabecalho;Ansi"

Function integer SAT_Emitente(	String  a_CNPJ,&
											String a_IE,&
											String a_IM,&
											String a_IndRatISS) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Emitente;Ansi"

Function integer SAT_Destinatario(	String a_CNPJ,&
												String a_CPF,&
												String a_xNome,&
												String a_xLgr,&
												String a_nro,&
												String a_xCpl,&
												String a_xBairro,&
												String a_xMun,&
												String a_UF) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Destinatario;Ansi"

Function integer SAT_Destinatario_Resumido(	String a_CNPJ,&
												String a_CPF,&
												String a_xNome) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Destinatario_Resumido;Ansi"												

Function integer SAT_Item(	String a_nItem,&
										String  a_cProd,&
										String  a_cEAN,&
										String  a_xProd,&
										String  a_NCM,&
										String  a_CFOP,&
										String  a_uCom,&
										String  a_qCom,&
										String  a_vUnCom,&
										String  a_vDesc,&
										String  a_vTotTrib,&										
										String  a_orig,&
										String  a_CST,&										
                   						String  a_pICMS, &
										String  a_CSTPIS, &
                   						String  a_vBCPIS, &
                   						String  a_pPIS, &
                   						String  a_CSTCOFINS, &
                   						String  a_vBCCOFINS, &
                   						String  a_pCOFINS, &
                   						String  a_indArred, &
										String  a_CEST) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Item;Ansi"

Function integer SAT_Totais(	String  a_vDesc,&
										String  a_vTotTrib,&
										String  a_Obs) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Totais;Ansi"

Function integer SAT_FormasPagamento(String  a_tPag,&
													   String  a_vPag) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_FormasPagamento;Ansi"
										
Function integer SAT_SalvarNota(Ref String a_ChaveNota) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_SalvarNota;Ansi"

Function integer SAT_AssinarNota() LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_AssinarNota;Ansi"

Function integer SAT_ValidarLoteParaEnvio() LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_ValidarLoteParaEnvio;Ansi"

Function integer SAT_EnviarSEFAZ(	Ref String a_ChaveNota,&
												Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_EnviarSEFAZ;Ansi"
												
Function integer SAT_Imprimir(	String a_ChaveNota,&
											String a_DirretorioXML,&
											String a_Impressora,&
											String a_Contingecia,&
											String a_ModeloRTM) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Imprimir;Ansi"												

Function integer SAT_Cancelar(	String a_ChaveNota,&
											String a_CNPJsoft,&
											String a_CNPJDest,&
											String a_CaixaCanc,&
											String a_Assinatura,&
											Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Cancelar;Ansi"

Function integer SAT_Comunica(	Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Comunica;Ansi"												

Function integer SAT_Status_Oper(	Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Status_Oper;Ansi"												

Function integer SAT_Ativacao( String a_a_TipoCertificado,&
										Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Ativacao;Ansi"												
										
Function integer SAT_Associar_Assinatura_AC(String a_CNPJs,&
														String a_CNPJc,&
														String a_Ambiente,&
														Ref String a_Assinatura,&
														Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Associar_Assinatura_AC;Ansi"
														
Function integer SAT_Atualizar_Software(	Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Atualizar_Software;Ansi"

Function integer SAT_Teste_FimAFim(	String a_ArquivoTeste,&
														Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Teste_FimAFim;Ansi"

Function integer SAT_Bloquear(	Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Bloquear;Ansi"

Function integer SAT_Desbloquear(	Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Desbloquear;Ansi"

Function integer SAT_Consulta_Sessao(	String a_Sessao,&
											Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Consulta_Sessao;Ansi"

Function integer SAT_Extrair_Log(	Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Extrair_Log;Ansi"

Function integer SAT_Troca_Codigo_Ativacao(	String a_Opcao,&
															String a_Codigo,&
															String a_ConfirmaCodigo,&
															Ref String a_Retorno) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Troca_Codigo_Ativacao;Ansi"
															
Function integer SAT_Gera_Codigo_Vinculacao(String a_CNPJs,&
															String a_CNPJc,&
															Ref String a_Codigo) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Gera_Codigo_Vinculacao;Ansi"
															
Function integer SAT_Envia_email(	String a_xmlAD,&
											String a_email) LIBRARY "C:\sistemas\dll\sat\SAT.dll" alias for "SAT_Envia_email;Ansi"												
															
end prototypes

type variables
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
STRING ivs_assinatura_sat

DateTime dt_data_recebimento

Long nr_job_impressao
Long ECF

Boolean ivb_cod_barras
Boolean ivb_contingencia
Boolean ivb_Cadastrada
Boolean ivb_Porta_Aberta

STRING nr_Serie
STRING nr_versao_swbasico
STRING nr_versao_layout
STRING Id_Situacao
STRING is_versao_sb
STRING is_versao_leiaute

end variables

forward prototypes
public function boolean of_abreporta ()
public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pd_valor)
public function boolean of_inicializa_comprovante (string ps_tipo, string ps_recebimento, string ps_mensagem, string ps_forma_pgto, decimal pd_valor, long pl_parcelas, string ps_nf)
public function boolean of_imprime_texto (string ps_texto)
public subroutine of_teste ()
public function boolean of_codigo_uf (string ps_uf, ref string ps_codigo_uf)
public function boolean of_emitente ()
public function boolean of_assina_valida ()
public function boolean of_finaliza_impressao_texto ()
public function boolean of_comprovante_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor)
public function boolean of_abre_doc ()
public function string of_retira_caracteres (string ps_texto)
public function boolean of_email_xml (string ps_chave, string ps_email, string ps_modo)
public function boolean of_envia_xml_ftp (string ps_chave)
public function boolean of_busca_xml_ftp (string ps_chave)
public function boolean of_exclui_xml (string ps_chave)
public subroutine of_verifica_fonte ()
public function boolean of_fecha_nota (string ps_inf_complementares, string ps_campo_fisco, string ps_tempo_fisco, string ps_formato_impressao, string ps_tipo_envio, string ps_email_envio, ref string ps_codigo_nota, ref string ps_status, ref string ps_motivo_fechar, ref string ps_xml, ref datetime pdt_data_recebimento, ref string ps_protocolo, ref long pl_retorno)
public function boolean of_atualiza_dlls ()
public function boolean of_sangria (decimal pdc_valor)
public function boolean of_suprimento (decimal pdc_valor)
public subroutine of_trata_retorno (string ps_retorno)
public subroutine of_interpreta_retorno_c (string ps_retorno_c, ref string ps_tipo, ref string ps_mensagem)
public function boolean of_cancela_sat (string ps_chave, string ps_protocolo, string ps_cpf, ref string ps_protocolo_cancelamento, ref datetime pdt_data_cancelamento)
public function boolean of_imprime_nota (string ps_chave_nota, string ps_protocolo, string ps_formato_cupom, string ps_cancelamento, string ps_modo)
public function boolean of_comunica_sat ()
public function boolean of_status_operacional (ref string ps_retorno)
public function boolean of_atualiza_cadastro_sat ()
public function boolean of_ativa_sat ()
public function boolean of_associar_assinatura (string ps_cnpj_sh, string ps_cnpj_loja)
public function boolean of_bloquear_sat ()
public function boolean of_desbloquear_sat ()
public function boolean of_atualizar_software ()
public function boolean of_extrair_logs ()
public function boolean of_consulta_sessao (string ps_sessao, ref string ps_retorno)
public function boolean of_teste_fimafim ()
public function boolean of_troca_codigo_ativacao (string ps_tipo, string ps_codigo_novo)
public function boolean of_cabecalho_sat (string ps_nr_nf, string ps_forma_pagamento, string ps_natureza_operacao, datetime pdt_emissao, string ps_tipo_impressao, string ps_forma_emissao, string ps_finalidade, string ps_consumidor, string ps_ind_presenca)
public function boolean of_consulta_sat (string ps_chave, ref string ps_protocolo, ref string ps_retorno, ref string ps_status, ref string ps_motivo, ref datetime pdt_data_rec, ref string ps_chave_rec)
public function boolean of_dados_sat (string ps_caixa, ref long pl_sequencial, ref long pl_caixa)
public function boolean of_totais_sat (decimal pd_total_bc, decimal pd_total_icms, decimal pd_total_bcst, decimal pd_total_st, decimal pd_total_produtos, decimal pd_total_frete, decimal pd_total_seg, decimal pd_total_desc, decimal pd_total_ii, decimal pd_total_ipi, decimal pd_total_pis, decimal pd_total_cofins, decimal pd_total_outros, decimal pd_total_nf, decimal pd_total_tributos, string ps_mod_frete, string ps_formas_pgto[], decimal ps_valores_pgto[], decimal pd_troco, ref string ps_chave_nota, string ps_observacao)
public function boolean of_gera_codigo_vinculacao (string ps_cnpj_sh, string ps_cnpj_loja, ref string ps_codigo)
public function boolean of_destinatario (string ps_cpf_cgc, string ps_codigo_cliente, string ps_nm_cliente, string ps_endereco, string ps_nr_endereco, string ps_bairro, string ps_cidade_ibge, string ps_nm_cidade, string ps_uf, string ps_email_xml, boolean pb_programa_governo, boolean pb_mesmo_cpf)
public function boolean of_registra_item_sat (long pl_item, string ps_produto, string ps_codigo_barras, string ps_descricao, long pl_ncm, long pl_cfop, string ps_unidade_medida, long pl_quantidade, decimal pd_valor_unitario, string ps_regra_calculo, decimal pd_valor_desconto, decimal pd_valor_outros, decimal pd_total_tributos, string ps_origem, string ps_cst_tributacao_icms, decimal pd_aliquota_icms, string ps_tributacao_pis_cofins, string ps_inf_adicionais, decimal pd_preco_praticado, string ps_cest, string ps_beneficio, integer pi_nr_item, string ps_codigo_sap)
end prototypes

public function boolean of_abreporta ();Long ll_Retorno
Long ll_Dif_Data
String ls_INI
String ls_INI_sat = "C:\Sistemas\CL\SAT\cfesatConfig.ini"
String ls_dir_sat = "C:\Sistemas\CL\SAT"
String ls_Diretorio_log = "C:\Sistemas\CL\SAT\log\"
String ls_ativacao
String ls_arquivos[]
String ls_retorno_sat
String ls_vencto_certif
String ls_ambiente_sat
String ls_ultimo_envio
String ls_serv_mail
String ls_imagem

If This.ivb_Porta_Aberta Then Return True

ls_INI  = gvo_Aplicacao.ivs_Arquivo_INI

ls_ambiente_sat = ProfileString(ls_INI, "ECF", "Homologacao_NFCE","")

If Trim(ls_ambiente_sat) = 'S' Then //1 = PRODU$$HEX2$$c700c300$$ENDHEX$$O   -  2 = Homologcao
	This.id_homologacao = '2'
Else
	This.id_homologacao = '1'
End If

This.nm_impressora_nfce = ProfileString(ls_INI, "ECF" , "NomeImpressora" , "")

If FileExists(ls_INI_sat) Then
	SetProfileString(ls_INI_sat, "CFESAT", "UF", gvo_parametro.ivs_uf_filial)
	SetProfileString(ls_INI_sat, "CFESAT", "CnpjContribuinte", gvo_parametro.nr_cgc)		
	ls_ativacao = ProfileString(ls_INI_sat, "CFESAT", "CodigoAtivacao","")
	If IsNull(ls_ativacao) Or Trim(ls_ativacao) = "" Or (ls_ativacao <> gvo_parametro.cd_ativacao_SAT) Then
		SetProfileString(ls_INI_sat, "CFESAT", "CodigoAtivacao", gvo_parametro.cd_ativacao_SAT)			
	End If
	
	If Trim(Upper(gvo_parametro.id_rede_filial)) = 'FA' Then
		ls_Imagem = "farmagora"
	Else
		ls_Imagem = Trim(Upper(gvo_parametro.id_rede_filial))
	End If	
	IF FileExists("C:\Sistemas\CL\Arquivos\Imagens\" + ls_imagem + ".jpg") Then
		SetProfileString(ls_INI_sat, "CFESATPRINT", "LogotipoEmitente", "C:\Sistemas\CL\Arquivos\Imagens\" + ls_imagem + ".jpg")			
	Else
		SetProfileString(ls_INI_sat, "CFESATPRINT", "LogotipoEmitente", "")			
	End If	
Else
	Messagebox("SAT","Arquivo INI do SAT n$$HEX1$$e300$$ENDHEX$$o existe no PDV!"+&
				  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)	
	Return False
End If

If IsNull(This.nm_impressora_nfce) Or Trim(This.nm_impressora_nfce) = '' Then
	Messagebox("SAT","Nome da Impressora SAT n$$HEX1$$e300$$ENDHEX$$o definida no INI do Caixa!"+&
				  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
	Return False
Else
	ll_retorno = PrintSetPrinter (This.nm_impressora_nfce)
	If ll_retorno <> 1 Then
		Messagebox("SAT","Impressora :" + This.nm_impressora_nfce + " n$$HEX1$$e300$$ENDHEX$$o encontrada no Windows!" +&
					  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)			
		Return False
	End If
End If

ls_serv_mail = ProfileString(ls_INI, "MAIL" , "ServidorSmtp" , "")
If IsNull(ls_serv_mail) Or Trim(ls_serv_mail) = '' Or Trim(ls_serv_mail) = "10.0.0.15" Then
	SetProfileString(ls_INI_sat, "MAIL", "ServidorSmtp", "172.19.2.100")
	SetProfileString(ls_INI_sat, "MAIL", "EmailRemetente", "nfe@clamed.com.br")
	SetProfileString(ls_INI_sat, "MAIL", "Assunto", "XML CFe - CIA LATINO AMERICANA DE MEDICAMENTOS")
	SetProfileString(ls_INI_sat, "MAIL", "Mensagem", "'O arquivo est$$HEX1$$e100$$ENDHEX$$ anexo.'")
	SetProfileString(ls_INI_sat, "MAIL", "Usuario", "scanner@clamedlocal.com.br")
	SetProfileString(ls_INI_sat, "MAIL", "Senha", "he3-sWetHlKl")
	SetProfileString(ls_INI_sat, "MAIL", "Autenticacao", "1")
	SetProfileString(ls_INI_sat, "MAIL", "Porta", "587")
End If

//Limpa diretorio de logs da NFCe no PDV, quando possuir mais de 500 arquivos o diretorio $$HEX1$$e900$$ENDHEX$$ limpo.
gf_dir_list( ls_Diretorio_log, '*.xml', 0+1, Ref ls_Arquivos )
If UpperBound( ls_Arquivos ) > 500 Then
	gf_limpa_diretorio( ls_Diretorio_log )
End If

//Copia o arquivo de configura$$HEX2$$e700e300$$ENDHEX$$o para o diretorio do executavel
dc_uo_api lo_api
lo_api = Create dc_uo_api

FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\cfesatConfig.ini')
If Not lo_api.of_copy_file(ls_dir_sat + '\cfesatConfig.ini', gvo_Aplicacao.ivs_Path_Sistema + '\cfesatConfig.ini', true) Then Return False

Destroy(lo_api)

If IsValid(PDV) Then
	PDV.ivb_Porta_Aberta = True
	ChangeDirectory( 'c:\sistemas\dll\sat' )
End If

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "RL" Then
	//Verificar defini$$HEX2$$e700f500$$ENDHEX$$es de rede, se faltar album n$$HEX1$$e300$$ENDHEX$$o deixa prosseguir
	
	If Not This.of_status_operacional(Ref ls_Retorno_sat) Then
		Return False
	Else		
		This.is_versao_sb		= Trim(gf_captura_valor(ls_retorno_sat, '|', 19, false))
		This.is_versao_leiaute= Trim(gf_captura_valor(ls_retorno_sat, '|', 20, false))		
		This.nr_serie	 		= Trim(gf_captura_valor(ls_retorno_sat, '|', 6, false))
		ls_vencto_certif			= Trim(gf_captura_valor(ls_retorno_sat, '|', 27, false))		
		ls_vencto_certif 		= MidA(ls_vencto_certif,7,2)+"/"+MidA(ls_vencto_certif,5,2)+"/"+MidA(ls_vencto_certif,1,4)	
		ls_ultimo_envio			= Trim(gf_captura_valor(ls_retorno_sat, '|', 24, false))
		ls_ultimo_envio 		= MidA(ls_ultimo_envio,7,2)+"/"+MidA(ls_ultimo_envio,5,2)+"/"+MidA(ls_ultimo_envio,1,4)	
		This.id_situacao		= Trim(gf_captura_valor(ls_retorno_sat, '|', 28, false))
		Choose Case This.id_situacao
			Case "0" //SAT Desbloqueado
			Case "1"	
				Messagebox("SAT","Aparelho com Bloqueio do SEFAZ!" +&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)			
				Return False
			Case "2"	
				Messagebox("SAT","Aparelho com Bloqueio da Empresa!" +&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)			
				Return False
			Case "3"	
				Messagebox("SAT","Aparelho com Bloqueio de Fabrica!" +&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)			
				Return False					
		End Choose
		ll_Dif_Data = DaysAfter(Date(Today()), Date(ls_vencto_certif))
		//SEFAZ/SP informou que o certificado deles atualiza automaticamente nos equipamentos depios de vencido.
		If ll_Dif_Data <= 0 Then
			Messagebox("SAT","Certificado instalado no SAT est$$HEX1$$e100$$ENDHEX$$ vencido!" +&
						  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
			//Return False
		End If	
//		If ll_Dif_Data <= 30 Then
//			Messagebox("SAT","Certificado instalado no SAT vence em menos de 30 dias!" +&
//						  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", Information!)		
//		End If
		
		ll_Dif_Data = DaysAfter(Date(ls_ultimo_envio), Date(Today()))
		If ll_Dif_Data >= 5 Then
			gf_ge202_envia_email_log(63,'SAT 5 DIAS OU MAIS SEM ENVIAR NOTAS - LOJA(' + String(gvo_parametro.cd_filial) +')', &
												'Equipamento SAT ' + This.nr_serie + ' est$$HEX1$$e100$$ENDHEX$$ a ' + String(ll_Dif_data) + ' dias sem enviar notas ao SEFAZ.<br />' +&
												'Se a loja j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ em funcionamento, verificar o motivo.')			
			Messagebox("SAT","Fazem 5 dias ou mais que o SAT n$$HEX1$$e300$$ENDHEX$$o envia as vendas ao SEFAZ.~n" +&
									 "Se o led CFe do equipamento SAT estiver aceso avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", Information!)
		End If		
		
	End If
	
	If Not This.of_atualiza_cadastro_sat() Then	Return False	
	
End If

This.ivb_Porta_Aberta = True

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
	Print(Job,ls_cabecalho1)
	Print(Job,ls_cabecalho2)
	Print(Job,ls_cabecalho3)
	Print(Job,ls_cabecalho4 + "~n")
	If Trim(ls_titulo) > '' Then
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
					ll_retorno = Print(Job,ls_texto)
					ls_aux = MidA(ls_aux, ll_pos1+1, LenA(ps_texto[ll_Linha]) - ll_pos1)
				Else
					ll_retorno = Print(Job,ls_aux)
					ls_aux = ""
				End If		
			Loop
		Else
			ls_texto = ps_texto[ll_Linha]
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
						Print(Job, ls_espaco + '*' + This.ivs_Cod_Barras + '*')
						
						PrintDefineFont	(Job, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
						PrintSetFont(Job, 1)						
					End If
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
	
ll_Retorno = Print(This.nr_job_impressao,ps_texto)

If ll_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public subroutine of_teste ();long Job, ll_retorno		

string ls_sessao, ls_retorno_E, ls_retorno_C, ls_mensagem, ls_cod_msg, ls_msg_SEFAZ,&
		ls_data, ls_retorno, ls_hora, ls_chave

ls_sessao 	 		= gf_captura_valor(ls_retorno, '|', 1, false)
ls_retorno_E 		= gf_captura_valor(ls_retorno, '|', 2, false)
ls_retorno_C 		= gf_captura_valor(ls_retorno, '|', 3, false)
ls_mensagem 		= gf_captura_valor(ls_retorno, '|', 4, false)
ls_cod_msg	 		= gf_captura_valor(ls_retorno, '|', 5, false)
ls_msg_SEFAZ		= gf_captura_valor(ls_retorno, '|', 6, false)
ls_data				= gf_captura_valor(ls_retorno, '|', 8, false)
ls_hora = MidA(ls_Data,9,6)
ls_Data = MidA(ls_Data,7,2)+"/"+MidA(ls_Data,5,2)+"/"+MidA(ls_Data,1,4)
ls_chave				= gf_captura_valor(ls_retorno, '|', 9, false)
ls_chave	 			= RightA(ls_chave, 44)	

This.of_verifica_fonte()

ll_retorno = PrintSetPrinter (This.nm_impressora_nfce)		
Job = PrintOpen()		
PrintDefineFont	(Job, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
PrintSetFont(Job, 1)

ll_retorno = Print(Job,"                         VIA TESTE" + "~n" + "~n")
	
ll_retorno = Print(Job,"TESTE IMPRESSAO")				
ll_retorno = Print(Job,"CLAMED")				
ll_retorno = Print(Job,"TEXO IMPRESSO COM SUCESSO!!" + "~n")
ll_retorno = Print(Job,"TESTE LINHA COM MAIS DE 42 CARACTERES FIM...........")						

//PrintSetFont(Job, 0)

ll_retorno = PrintDefineFont	(Job, 2, "IDAutomationHC39M", 500, 400, Default!, AnyFont!, FALSE, FALSE)
PrintSetFont(Job, 2)

String ls_espaco
ls_espaco = Space(3)

ll_retorno = Print(Job, ls_espaco + '*1234567890*')
	
ll_retorno = PrintClose(Job)

//PrintSetPrinter (This.nm_impressora_nfce)
//Job = PrintOpen()		
//PrintDefineFont	(Job, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
//
//dc_uo_ds_Base lvds_1
//lvds_1 = Create dc_uo_ds_Base
//
//If Not lvds_1.of_ChangeDataObject('ds_ge039_comprovante_codigo_barra') Then 
//	Destroy(lvds_1)
//	Return
//End If
//
//lvds_1.Object.de_texto[1]    = 'TESTE IMPRESSAO' + "~n" + &
//										  'CLAMED' + "~n" + &
//										  'TEXO IMPRESSO COM SUCESSO!!' + "~n" + &
//										  'TESTE LINHA COM MAIS DE 42 CARACTERES FIM...........'
//lvds_1.Object.de_barras[1] = '*056301235678*'
//lvds_1.Object.de_texto2[1] = '056301235678'
//	
//lvds_1.Print()
//
//Destroy(lvds_1)
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
		ls_ins_est, &
		ls_nulo, &
		ls_rateio_ISS

SetNull(ls_nulo)

If This.id_homologacao = '2' Then //Em homologacao	
	ls_cnpj 				= "53485215000106"
	ls_ins_est			= "111072115110"
Else
	ls_cnpj 				= gvo_parametro.nr_cgc
//	ls_ins_est			= gf_tira_mascara_inscricao_estadual(gvo_parametro.nr_inscricao_estadual)
	ls_ins_est			= gf_replace(gvo_parametro.nr_inscricao_estadual, '.', '', 0)
	ls_ins_est			= gf_replace(ls_ins_est, '/', '', 0)
	ls_ins_est			= gf_replace(ls_ins_est, '-', '', 0)
End If
ls_rateio_iss			= "N"

ll_Retorno = SAT_Emitente(ls_cnpj,&
									ls_ins_est,&
									ls_nulo,&
									ls_rateio_iss)

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

ll_retorno = SAT_AssinarNota()

Choose Case ll_Retorno
	Case 1 				// Comando OK
		Return True
		
//		ll_retorno2 = NFCe_ValidarLoteParaEnvio()		
//		Choose Case ll_Retorno2
//			Case 1 				// Comando OK
//				Return True		
//			Case 0 				// Erro ao executar comando
//				Return False
//			Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
//				Return False
//		End Choose			

	Case 0 				// Erro ao executar comando
		Return False
	Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose	


Return False
end function

public function boolean of_finaliza_impressao_texto ();Long ll_Retorno

//Print(This.nr_job_impressao,"~n")
If This.ivb_Cod_Barras Then	
	This.of_verifica_fonte()
	PrintDefineFont	(This.nr_job_impressao, 2, "IDAutomationHC39M", 500, 400, Default!, AnyFont!, FALSE, FALSE)
	PrintSetFont(This.nr_job_impressao, 2)
	String ls_espaco
	ls_espaco = Space(3)	
	Print(This.nr_job_impressao, ls_espaco + '*' + This.ivs_Cod_Barras + '*')
	
	PrintDefineFont	(This.nr_job_impressao, 1, "Courier 10Cps", 120, 400, Default!, AnyFont!, FALSE, FALSE)
	PrintSetFont(This.nr_job_impressao, 1)	
End If

Print(This.nr_job_impressao,String(Today(),'dd-mm-yyyy" "HH:mm:ss') + ' - CAIXA: ' + PDV.cd_caixa)
ll_Retorno = PrintClose(This.nr_job_impressao)

If ll_Retorno = 1 Then
	Return True
Else
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
	Print(This.nr_job_impressao,String(Today(),'dd-mm-yyyy" "HH:mm:ss')  + " - CAIXA: " + PDV.cd_caixa + "~n")
	
	ll_Retorno = PrintClose(This.nr_job_impressao)
	If ll_Retorno = 1 Then	
		Return True
	End If
Else
	Return False
End If

Return False
end function

public function boolean of_abre_doc ();Integer ll_Retorno
String ls_nulo
String ls_uf_filial
String ls_cnpj
String ls_cnpj_soft
String ls_ativacao

SetNull(ls_nulo)

SetNull(This.dt_data_recebimento)

If This.id_homologacao = '2' Then //Em homologacao	
	ls_cnpj 			= '53485215000106'
	ls_cnpj_soft 	= '10615281000140'
Else
	ls_cnpj 			= gvo_parametro.nr_cgc	
	ls_cnpj_soft 	= '84683481000177'	
End If

ls_uf_filial 		= gvo_parametro.ivs_uf_filial
ls_ativacao		= gvo_parametro.cd_ativacao_SAT

ll_Retorno = SAT_ConfiguraParametros(ls_uf_filial, ls_cnpj, ls_cnpj_soft, ls_ativacao)

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
String ls_Diretorio_Enviados = 'c:\sistemas\cl\sat\copiaseguranca\enviados\'
String ls_Diretorio_Base = 'c:\sistemas\cl\sat\copiaseguranca\'
String ls_xml
String ls_xml_caminho
String ls_Arquivo
Boolean lb_econtrou = False

Try
	dc_uo_api lo_api
	lo_api = Create dc_uo_api
	
	dc_uo_ftp lo_Ftp
	lo_Ftp = Create dc_uo_ftp
	
	If ps_modo = 'E' Then   //Somente envio de e-mail
		If Not This.of_busca_xml_ftp(ps_chave) Then Return False
		
		This.of_abre_doc()
		
		ls_xml_caminho = ls_Diretorio_Base + 'AD' + ps_chave + '.xml'
		If FileExists(ls_xml_caminho) Then
			ll_retorno =	SAT_Envia_email(ls_xml_caminho, ps_email)		
			
			Choose Case ll_Retorno
				Case 1 				// Comando OK
					This.of_exclui_xml(ps_chave)
					Return True				
				Case Else
					Return False
			End Choose				
		Else
			Return False
		End If			
	End If	
	
	If ps_modo = 'V' Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente deseja receber CF-e SAT por e-mail?", Question!,YesNo!, 2) = 1 Then
			OpenWithParm(w_ge039_email_envio_nfce, ps_email)					
			ls_mail = Trim(Message.StringParm)
			If Not IsNull(ls_mail) And Trim(ls_mail) > '' Then		
				//O xml est$$HEX1$$e100$$ENDHEX$$ zipado, primeiro descompacta para enviar, depois exclui
				If FileExists(ls_Diretorio_Enviados +'AD' + ps_chave+'.xml.zip') Then
					ls_Arquivo = 'AD' + ps_chave+'.xml.zip'
					If lo_api.of_unzip(ls_Diretorio_Enviados + ls_Arquivo,ls_Diretorio_Enviados) Then
						ls_xml = 'AD' + ps_chave+'.xml'
						If FileExists(ls_Diretorio_Enviados + ls_xml) Then
							//Econtrou xml
							ls_xml_caminho = ls_Diretorio_Enviados + ls_xml
							lb_econtrou = True
						End If	
					Else	
						MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao descompactar arquivo ' + ls_Arquivo , StopSign! )
						Return False
					End If
				Else
					MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Arquivo XML n$$HEX1$$e300$$ENDHEX$$o encontrado ' + ls_Arquivo , StopSign! )
					Return False			
				End If	
			End If
		End If
		
		If lb_econtrou Then
			ll_retorno =	SAT_Envia_email(ls_xml_caminho, ls_mail)		
	
			Choose Case ll_Retorno
				Case 1 				// Comando OK
					Messagebox("SAT","E-mail enviado com sucesso!.", Information!)				
					Return True
				Case Else
					Messagebox("SAT","Problemas para enviar o e-mail."+&
								  "Tente novamente mais tarde.", Exclamation!)
					Return False
			End Choose		
		Else
			Return False
		End If	
		
	End If

Finally
	lo_api.of_delete_file(ls_xml_caminho,False)		
	Destroy lo_Ftp
	Destroy lo_api
End Try
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
String ls_Diretorio_Base = 'c:\sistemas\cl\sat\copiaseguranca\'
String ls_Diretorio_Enviados = 'c:\sistemas\cl\sat\copiaseguranca\enviados'
String ls_Servidor

dc_uo_api lo_api
lo_api = Create dc_uo_api

lo_api.of_create_directory(ls_diretorio_enviados)

Destroy(lo_api)

uo_parametro_filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial
lvo_Parametro.of_Localiza_Parametro('DE_ENDERECO_SERVIDOR_FTP', ref ls_Servidor, False)
Destroy lvo_Parametro

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "SAT - Vai enviar o xml para o PDV1. Chave [" + ps_chave + "]")

ls_Filial = String( gvo_Parametro.Cd_Filial, "0000" )

dc_uo_zip lo_Zip
lo_Zip = Create dc_uo_zip

dc_uo_ftp lo_Ftp
lo_Ftp = Create dc_uo_ftp

gf_dir_list( ls_Diretorio_Base, '*'+ps_chave+'*.xml', 0+1, Ref ls_Arquivos )

For li_Contador = 1 To UpperBound( ls_Arquivos )
	ls_Arquivo = ls_Arquivos[ li_Contador ]
	
	lo_Zip.of_Salva_Estrutura( False )
	ls_Error = lo_Zip.of_Zip( ls_Diretorio_Base + ls_Arquivo, ls_Diretorio_Base + ls_Arquivo + '.zip' )
		
	If ls_Error <> "" Then
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao tentar compactar arquivo ' + ls_Arquivo + '~r~r' + ls_Error, StopSign! )
	Else

		lo_Ftp.of_DesConecta_Ftp()
		
		If lo_Ftp.of_Conecta_Ftp( 'NFCE - ' + ls_Filial, ls_Servidor, 'pdv2', 'pdv2', Ref ls_Msg ) Then
			If lo_Ftp.of_Ftp_Set_Dir( 'NFCE', ref ls_Msg ) < 0 Then
				lo_Ftp.of_Ftp_Cria_Dir( 'NFCE', ref ls_Msg ) // Cria+										

				If lo_Ftp.of_Ftp_Set_Dir( 'NFCE', ref ls_Msg ) < 0 Then
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar diret$$HEX1$$f300$$ENDHEX$$rio NFCE no servidor FTP " + ls_servidor +" ~r~r" + ls_Msg, StopSign! )
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "SAT - Erro ao localizar diretorio para envio. [" + ls_Msg + "]")					
					Return False
				End If					
			End If													
			If lo_Ftp.of_Ftp_PutFile( ls_Diretorio_Base + ls_Arquivo + '.zip', ls_Arquivo + '.zip', Ref ls_Msg ) Then
							 FileMove( ls_Diretorio_Base + ls_Arquivo + '.zip', ls_Diretorio_Enviados +'\'+ ls_Arquivo + '.zip' )
							 FileDelete( ls_Diretorio_Base + ls_Arquivo )											 

			Else
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao enviar arquivo " + ls_Arquivo + ".zip para NFCE no servidor FTP " + ls_servidor + " ~r~r" + ls_Msg, StopSign! )
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "SAT - Erro ao enviar o xml para o PDV1. [" + ls_Msg + "]")									
			End If
			
			lo_Ftp.of_DesConecta_Ftp()
		Else
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor FTP " + ls_servidor + " ~r~r" + ls_Msg, StopSign! )
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "SAT - Erro de conex$$HEX1$$e300$$ENDHEX$$o com o PDV1. [" + ls_Msg + "]")												
		End If
		
	End If
Next

Destroy lo_Ftp
Destroy lo_Zip

Return True
end function

public function boolean of_busca_xml_ftp (string ps_chave);String	ls_Arquivo
String	ls_Arquivo_Zip
String	ls_Error
String ls_Filial
String ls_Msg
String ls_Diretorio_Base = 'c:\sistemas\cl\sat\copiaseguranca\'
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

If FileExists(ls_Diretorio_base + 'AD' + ps_chave + '.xml') Then //Arquivo existe no PDV, n$$HEX1$$e300$$ENDHEX$$o precisa vir buscar.
	Return True
End If

ls_Filial 		= String( gvo_Parametro.Cd_Filial, "0000" )

uo_parametro_filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial
lvo_Parametro.of_Localiza_Parametro('DE_ENDERECO_SERVIDOR_FTP', ref ls_Servidor_local, False)
Destroy lvo_Parametro

ls_Servidor_central = '10.0.4.30'
ls_arquivo = 'AD' + ps_chave + '.xml'
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
			MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Situa$$HEX2$$e700e300$$ENDHEX$$o do SAT n$$HEX1$$e300$$ENDHEX$$o permite prosseguir solicita$$HEX2$$e700e300$$ENDHEX$$o. Situa$$HEX2$$e700e300$$ENDHEX$$o : '+ ls_Situacao, StopSign! )		
			Return False						
		Else
			ls_ano 	= String( ldt_emissao, 'yyyy' )
			ls_mes 	= String( ldt_emissao, 'mm' )
			ls_dia		= String( ldt_emissao, 'dd' )
			ls_diretorio = ls_ano + '/'+ ls_mes +'/'+ ls_dia + '/' +ls_filial
		End If		
	Case -1
		SqlCa.Of_msgdberror("Localiza$$HEX2$$e700e300$$ENDHEX$$o SAT.")
		Return False			
	Case Else
		SqlCa.Of_msgdberror("Localiza$$HEX2$$e700e300$$ENDHEX$$o SAT.")
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
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar diret$$HEX1$$f300$$ENDHEX$$rio SAT no servidor FTP " + ls_servidor_central +" ~r~r" + ls_Msg, StopSign! )
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

public function boolean of_exclui_xml (string ps_chave);String ls_Diretorio_Base = 'c:\sistemas\cl\sat\copiaseguranca\'
String ls_Servidor
String ls_Arquivo

ls_Arquivo = 'AD' + ps_chave + '.xml'

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

public function boolean of_fecha_nota (string ps_inf_complementares, string ps_campo_fisco, string ps_tempo_fisco, string ps_formato_impressao, string ps_tipo_envio, string ps_email_envio, ref string ps_codigo_nota, ref string ps_status, ref string ps_motivo_fechar, ref string ps_xml, ref datetime pdt_data_recebimento, ref string ps_protocolo, ref long pl_retorno);Integer ll_Retorno
String		ls_Nota, &
			ls_Status, &
			ls_Motivo, &
			ls_XML, &
			ls_Data, &
			ls_Protocolo, &
			ls_Hora, &
			ls_mail, &
			ls_retorno, &
			ls_sessao, &
			ls_retorno_E,&
			ls_retorno_C,&
			ls_mensagem,&
			ls_cod_msg,&
			ls_msg_SEFAZ,&
			ls_chave			
Long ll_Pos
Boolean lb_erro = False
			
ls_Nota 		= Space(100)
ls_Retorno   = Space(100000)

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "SAT - Vai chamar a fun$$HEX2$$e700e300$$ENDHEX$$o EnviarSEFAZ do objeto.")			

ll_Retorno = SAT_EnviarSEFAZ(	Ref ls_Nota,&
									Ref ls_Retorno)

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "SAT - Vai ler o retorno da chamada da fun$$HEX2$$e700e300$$ENDHEX$$o EnviarSEFAZ. Retorno [" + String(ll_retorno) + "]")

pl_retorno 					= ll_retorno

If ll_Retorno = 1 And Trim(ls_Retorno) <> '' Then

//$$HEX1$$1c20$$ENDHEX$$numeroSessao|EEEEE|CCCC|mensagem|cod|mensagemSEFAZ|arquivoCFeBase64|timeStamp|chaveConsulta|valorTotalCFe|CPFCNPJValue|assinaturaQRCODE$$HEX1$$1d20$$ENDHEX$$

	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_retorno_C 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 6, false))
	ls_data				= Trim(gf_captura_valor(ls_retorno, '|', 8, false))
	ls_hora 				= MidA(ls_Data,9,6)
	ls_hora				= MidA(ls_hora,1,2) + ':' + MidA(ls_hora,3,2) + ':' + MidA(ls_hora,5,2)
	ls_Data 				= MidA(ls_Data,7,2)+"/"+MidA(ls_Data,5,2)+"/"+MidA(ls_Data,1,4)
	ls_chave				= Trim(gf_captura_valor(ls_retorno, '|', 9, false))
	ls_chave	 			= RightA(ls_chave, 44)	
	
	ps_codigo_nota 			= ls_chave
	ps_Status					= ls_retorno_E
	pdt_Data_Recebimento	= DateTime(Date(ls_Data),Time(ls_Hora))
	ps_Protocolo				= '000000000000000' //SAT n$$HEX1$$e300$$ENDHEX$$o tem protocolo, preencho com zeros.
	This.dt_data_recebimento = DateTime(Date(ls_Data),Time(ls_Hora))				
	
	If ls_retorno_E = '06000' Then
		//Deu certo, fazer envio xml /impressao/ etc.		
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "SAT - Conseguiu ler os retornos da fun$$HEX2$$e700e300$$ENDHEX$$o EnviarSEFAZ e vai Imprimir a nota. Chave [" + ls_chave + "]")
		This.of_imprime_nota( ls_chave,'', '0', 'N', 'V')
		This.of_envia_xml_ftp(ls_chave)	
		If ls_retorno_C <> '0000' Then
			//ALERTA - MOSTRAR AO USUARIO??		
			ps_motivo_fechar			= 'RetornoC: ' + ls_retorno_C + ': ' + ls_mensagem
		End If
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "SAT - Saiu da fun$$HEX2$$e700e300$$ENDHEX$$o de impress$$HEX1$$e300$$ENDHEX$$o e envio xml.")									
		If ls_cod_msg <> '' Then
			ps_motivo_fechar = ps_motivo_fechar + ' CodMsg: ' + ls_cod_msg + ': '  + ls_msg_SEFAZ
		End If	
		
		If Trim(ps_motivo_fechar) > '' Then		
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "ALERTA SEFAZ: " + ps_motivo_fechar + ' Avise o Depto de Inform$$HEX1$$e100$$ENDHEX$$tica!', Information!)
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "ALERTA SEFAZ: [" + ps_motivo_fechar + "]")			
		End If		
		Return True			
	Else
		pl_retorno = -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Rejei$$HEX2$$e700e300$$ENDHEX$$o SAT - retorno: " + ls_retorno_E + " - " +  ls_retorno_C +" - "+ ls_mensagem, Exclamation!)
		Return False			
	End If
Else
	Return False
End If
	
Return False
end function

public function boolean of_atualiza_dlls ();Boolean	lb_Sucesso 		= True

String   ls_Path_System
String	   ls_path_dll = 'c:\sistemas\dll\sat'
String   ls_Validar[]
String   ls_Baixar[]

ls_Validar = {"sat.dll"}
ls_Baixar  = {"sat.zip"}

If gvo_Aplicacao.of_is64bits() Then
	ls_Path_System = 'C:\Windows\SysWOW64'
Else
	ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
End If	

dc_uo_api lo_api
lo_api = Create dc_uo_api

If FileExists(ls_Path_System + '\sat.dll')  And lb_Sucesso Then
	
	If Not FileExists(ls_Path_dll) Then
		lo_Api.of_Create_Directory(ls_Path_dll)
	End If
	
	//Move para diretorio das dlls	
	If Not lo_api.of_move_file(ls_Path_System + '\sat.dll', ls_Path_dll + '\sat.dll', true, true) Then lb_Sucesso = False					
	
End If

If Not FileExists(ls_Path_dll + '\sat.dll')  And lb_Sucesso Then

	lb_Sucesso = gf_Download_Matriz(ls_Validar, ls_Baixar, ls_Path_dll, "dll_sat", True)	

End If

Destroy(lo_api)

If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)

Return lb_Sucesso
end function

public function boolean of_sangria (decimal pdc_valor);Return This.of_comprovante_nao_fiscal('','','04',pdc_valor)
end function

public function boolean of_suprimento (decimal pdc_valor);Return This.of_comprovante_nao_fiscal('','','05',pdc_valor)
end function

public subroutine of_trata_retorno (string ps_retorno);
end subroutine

public subroutine of_interpreta_retorno_c (string ps_retorno_c, ref string ps_tipo, ref string ps_mensagem);//ps_tipo 	 'E' = Erro  'A' = Alerta

Choose Case ps_retorno_C
	Case '1002'
		ps_tipo = 'E'
		ps_mensagem = 'C$$HEX1$$f300$$ENDHEX$$digo da UF n$$HEX1$$e300$$ENDHEX$$o confere com a Tabela do IBGE.'

	Case '1003'
		ps_tipo = 'E'
		ps_mensagem = 'C$$HEX1$$f300$$ENDHEX$$digo da UF diferente da UF registrada no SAT.'

	Case '1004'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Vers$$HEX1$$e300$$ENDHEX$$o do leiaute do arquivo de entrada do SAT n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lida.'

	Case '1005'
		ps_tipo = 'A'
		ps_mensagem = 'Alerta: Vers$$HEX1$$e300$$ENDHEX$$o do leiaute do arquivo de entrada do SAT n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ a mais atual.'

	Case '1226'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo da UF do Emitente diverge da UF receptora.'

	Case '1450'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de modelo de documento fiscal diferente de 59.'
	
	Case '1258'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Data/hora inv$$HEX1$$e100$$ENDHEX$$lida. Problemas com o rel$$HEX1$$f300$$ENDHEX$$gio interno do SAT-CF-e.'

	Case '1224'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: CNPJ da Software House inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1222'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Assinatura do Aplicativo Comercial n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lida.'
		
	Case '1207'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: CNPJ do emitente inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1203'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Emitente n$$HEX1$$e300$$ENDHEX$$o autorizado para uso do SAT.'
		
	Case '1229'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: IE do emitente n$$HEX1$$e300$$ENDHEX$$o informada.'
		
	Case '1230'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: IE do emitente diferente da IE do contribuinte autorizado para uso do SAT.'
		
	Case '1457'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Natureza da Opera$$HEX2$$e700e300$$ENDHEX$$o para ISSQN inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1507'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Indicador de rateio para ISSQN inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1235'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: CNPJ do destinat$$HEX1$$e100$$ENDHEX$$rio inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1237'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: CPF do destinat$$HEX1$$e100$$ENDHEX$$rio inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1234'
		ps_tipo = 'A'
		ps_mensagem = 'Alerta: Raz$$HEX1$$e300$$ENDHEX$$o Social/Nome do destinat$$HEX1$$e100$$ENDHEX$$rio em branco.'		
		
	Case '1019'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: numera$$HEX2$$e700e300$$ENDHEX$$o dos itens n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ sequencial crescente.'
		
	Case '1459'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo do produto ou servi$$HEX1$$e700$$ENDHEX$$o em branco.'
		
	Case '1460'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: GTIN do item (N) inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1461'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Descri$$HEX2$$e700e300$$ENDHEX$$o do produto ou servi$$HEX1$$e700$$ENDHEX$$o em branco.'
		
	Case '1462'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: CFOP n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ de Opera$$HEX2$$e700e300$$ENDHEX$$o de sa$$HEX1$$ed00$$ENDHEX$$da prevista para CF-e-SAT.'
		
	Case '1463'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Unidade Comercial do produto ou servi$$HEX1$$e700$$ENDHEX$$o em branco.'
		
	Case '1464'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Quantidade Comercial do item inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1465'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor Unit$$HEX1$$e100$$ENDHEX$$rio do item inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1467'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Regra de c$$HEX1$$e100$$ENDHEX$$lculo do Item inv$$HEX1$$e100$$ENDHEX$$lido (diferente de "A" e "T").'
		
	Case '1468'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor do Desconto do item inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1469'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor de outras despesas acess$$HEX1$$f300$$ENDHEX$$rias do item inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1535'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: c$$HEX1$$f300$$ENDHEX$$digo da credenciadora de cart$$HEX1$$e300$$ENDHEX$$o de d$$HEX1$$e900$$ENDHEX$$bito ou cr$$HEX1$$e900$$ENDHEX$$dito inv$$HEX1$$e100$$ENDHEX$$lido.'		
		
	Case '1220'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor do rateio do desconto sobre subtotal do item inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1228'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor do rateio do acr$$HEX1$$e900$$ENDHEX$$scimo sobre subtotal do item inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1751'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: n$$HEX1$$e300$$ENDHEX$$o informado c$$HEX1$$f300$$ENDHEX$$digo do produto.'
		
	Case '1752'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: c$$HEX1$$f300$$ENDHEX$$digo de produto informado fora do padr$$HEX1$$e300$$ENDHEX$$o ANP.'
		
	Case '1534'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor aproximado dos tributos do produto negativo.'
		
	Case '1533'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor aproximado dos tributos do CF-e_SAT negativo.'
		
	Case '1471'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o:Origem da mercadoria do Item inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 0, 1 , 2, 3, 4, 5, 6, 7, 8).'
		
	Case '1472'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o:CST do Item inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 00, 20, 90).'
		
	Case '1473'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Al$$HEX1$$ed00$$ENDHEX$$quota efetiva do ICMS do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior ou igual a zero.'
		
	Case '1475'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o:CST do Item inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 40 e 41 e 50 e 60).'
		
	Case '1476'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o:C$$HEX1$$f300$$ENDHEX$$digo de situa$$HEX2$$e700e300$$ENDHEX$$o da opera$$HEX2$$e700e300$$ENDHEX$$o - Simples Nacional - do Item inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 102, 300 e 500).'
		
	Case '1477'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o:C$$HEX1$$f300$$ENDHEX$$digo de situa$$HEX2$$e700e300$$ENDHEX$$o da opera$$HEX2$$e700e300$$ENDHEX$$o - Simples Nacional - do Item inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 900).'
		
	Case '1478'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria do PIS Inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 01, 02 e 05).'
		
	Case '1479'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Base de c$$HEX1$$e100$$ENDHEX$$lculo do PIS do item inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1480'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Al$$HEX1$$ed00$$ENDHEX$$quota do PIS do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior ou igual a zero.'
		
	Case '1482'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria do PIS Inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 03).'
		
	Case '1483'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Qtde Vendida do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior ou igual a zero.'
		
	Case '1484'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Al$$HEX1$$ed00$$ENDHEX$$quota do PIS em R$ do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior ou igual a zero.'
		
	Case '1486'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria do PIS Inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 04, 06, 07, 08 e 09).'
		
	Case '1487'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria do PIS inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 49).'
		
	Case '1488'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria do PIS Inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 99).'
		
	Case '1490'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria da COFINS Inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 01, 02 e 05).'
		
	Case '1491'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Base de c$$HEX1$$e100$$ENDHEX$$lculo do COFINS do item inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1492'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Al$$HEX1$$ed00$$ENDHEX$$quota da COFINS do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior ou igual a zero.'
		
	Case '1494'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria da COFINS Inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 03).'
		
	Case '1496'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Al$$HEX1$$ed00$$ENDHEX$$quota da COFINS em R$ do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior ou igual a zero.'
		
	Case '1498'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria da COFINS Inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 04, 06, 07, 08 e 09).'
		
	Case '1499'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria da COFINS Inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 49).'
		
	Case '1500'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Situa$$HEX2$$e700e300$$ENDHEX$$o Tribut$$HEX1$$e100$$ENDHEX$$ria da COFINS Inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 99).'
		
	Case '1501'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Opera$$HEX2$$e700e300$$ENDHEX$$o com tributa$$HEX2$$e700e300$$ENDHEX$$o de ISSQN sem informar a Inscri$$HEX2$$e700e300$$ENDHEX$$o Municipal.'
		
	Case '1503'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor das dedu$$HEX2$$e700f500$$ENDHEX$$es para o ISSQN do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior ou igual a zero.'
		
	Case '1505'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Al$$HEX1$$ed00$$ENDHEX$$quota efetiva do ISSQN do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior ou igual a 2,00 (2%) e menor ou igual a 5,00 (5%).'
		
	Case '1287'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo Munic$$HEX1$$ed00$$ENDHEX$$pio do FG - ISSQN: d$$HEX1$$ed00$$ENDHEX$$gito inv$$HEX1$$e100$$ENDHEX$$lido. Exceto os c$$HEX1$$f300$$ENDHEX$$digos descritos no Anexo 2 que apresentam d$$HEX1$$ed00$$ENDHEX$$gito inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1509'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o:C$$HEX1$$f300$$ENDHEX$$digo municipal de Tributa$$HEX2$$e700e300$$ENDHEX$$o do ISSQN do Item em branco.'
		
	Case '1510'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo de Natureza da Opera$$HEX2$$e700e300$$ENDHEX$$o para ISSQN inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1511'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Indicador de Incentivo Fiscal do ISSQN do item (N) inv$$HEX1$$e100$$ENDHEX$$lido (diferente de 1 e 2).'
		
	Case '1527'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: C$$HEX1$$f300$$ENDHEX$$digo do Meio de Pagamento inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1528'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor do Meio de Pagamento inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1408'		
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor total do CF-e-SAT maior que o somat$$HEX1$$f300$$ENDHEX$$rio dos valores de Meio de Pagamento empregados em seu pagamento.'
		
	Case '1409'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor total do CF-e-SAT supera o m$$HEX1$$e100$$ENDHEX$$ximo permitido no arquivo de Parametriza$$HEX2$$e700e300$$ENDHEX$$o de Uso.'
		
	Case '1073'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor de Desconto sobre total n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior ou igual a zero.'
		
	Case '1074'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Valor de Acr$$HEX1$$e900$$ENDHEX$$scimo sobre total n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior ou igual a zero.'
		
	Case '1084'
		ps_tipo = 'E'
		ps_mensagem = 'Formata$$HEX2$$e700e300$$ENDHEX$$o do Certificado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1085'
		ps_tipo = 'E'
		ps_mensagem = 'Assinatura do Aplicativo Comercial n$$HEX1$$e300$$ENDHEX$$o confere com o registro do SAT.'
		
	Case '1998'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel gerar o cupom com os dados de entrada informados, pois resultam valores negativos.'
		
	Case '1999'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Erro n$$HEX1$$e300$$ENDHEX$$o identificado.'
		
	Case '1270'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Chave de acesso do CFe a ser cancelado inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1412'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: CFe de cancelamento n$$HEX1$$e300$$ENDHEX$$o corresponde a um CFe emitido nos 30 minutos anteriores ao pedido de cancelamento.'
		
	Case '1210'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: Intervalo de tempo entre a emiss$$HEX1$$e300$$ENDHEX$$o do CF-e a ser cancelado e a emiss$$HEX1$$e300$$ENDHEX$$o do respectivo CF-e de cancelamento $$HEX1$$e900$$ENDHEX$$ maior que 30 (trinta) minutos.'
		
	Case '1454'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: CNPJ da Software House inv$$HEX1$$e100$$ENDHEX$$lido.'
		
	Case '1232'		
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: CNPJ do destinat$$HEX1$$e100$$ENDHEX$$rio do CF-e de cancelamento diferente daquele do CF-e a ser cancelado.'
		
	Case '1233'
		ps_tipo = 'E'
		ps_mensagem = 'Rejei$$HEX2$$e700e300$$ENDHEX$$o: CPF do destinat$$HEX1$$e100$$ENDHEX$$rio do CF-e de cancelamento diferente daquele do CF-e a ser cancelado.'
		
	Case '1218'
		ps_tipo = 'E'
		ps_mensagem = 'Chave de acesso do CF-e-SAT j$$HEX1$$e100$$ENDHEX$$ consta como cancelado.'
		
	Case Else	
		ps_tipo = 'E'
		ps_mensagem = 'Codigo de retorno n$$HEX1$$e300$$ENDHEX$$o esperado pelo Sistema!'
		
End Choose

end subroutine

public function boolean of_cancela_sat (string ps_chave, string ps_protocolo, string ps_cpf, ref string ps_protocolo_cancelamento, ref datetime pdt_data_cancelamento);String ls_nulo,  ls_cnpj_soft, ls_caixa, &
		ls_Data, &
		ls_Hora, &
		ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_retorno_C,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_chave, &
		ls_alerta, &
		ls_assinatura
DateTime ldh_data
Integer ll_retorno

If This.id_homologacao = '2' Then //Em homologacao	
	ls_cnpj_soft 	= '10615281000140'
	ls_assinatura 	= 'SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT'
Else
	ls_cnpj_soft 	= '84683481000177'	
	ls_assinatura 	= ''
End If
ls_caixa	= '0' + RightA(PDV.cd_caixa, 2)

If This.is_versao_leiaute = '0.07' Then //Esse leiaute n$$HEX1$$e300$$ENDHEX$$o deve ser informado o CPF.
	ps_cpf = ''
End If

SetNull(ls_nulo)

ls_retorno = Space(10000)

ll_retorno = SAT_Cancelar(ps_chave,&
									 	ls_cnpj_soft,&
									  	ps_cpf,&
										ls_caixa,&
									 	ls_assinatura,&
										Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	
//$$HEX1$$1c20$$ENDHEX$$numeroSessao|EEEEE|CCCC|mensagem|cod|mensagemSEFAZ|arquivoCFeBase64|timeStamp|chaveConsulta|valorTotalCFe|CPFCNPJValue|assinaturaQRCODE$$HEX1$$1d20$$ENDHEX$$

	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_retorno_C 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 6, false))
	ls_data				= Trim(gf_captura_valor(ls_retorno, '|', 8, false))
	ls_hora 				= MidA(ls_Data,9,6)
	ls_hora				= MidA(ls_hora,1,2) + ':' + MidA(ls_hora,3,2) + ':' + MidA(ls_hora,5,2)
	ls_Data 				= MidA(ls_Data,7,2)+"/"+MidA(ls_Data,5,2)+"/"+MidA(ls_Data,1,4)
	ls_chave				= Trim(gf_captura_valor(ls_retorno, '|', 9, false))
	ls_chave	 			= RightA(ls_chave, 44)	
	
	pdt_Data_cancelamento			= DateTime(Date(ls_Data),Time(ls_Hora))
	ps_Protocolo_Cancelamento		= '000000000000000' //SAT n$$HEX1$$e300$$ENDHEX$$o tem protocolo, preencho com zeros.	

	If ls_retorno_E = '07000' Then
		//Deu certo, fazer envio xml /impressao/ etc.		
		This.of_imprime_nota( ps_chave, '', '0', 'S', 'R')
		This.of_envia_xml_ftp(ps_chave)						
		If ls_retorno_C <> '0000' Then
			//ALERTA - MOSTRAR AO USUARIO??		
			ls_alerta			= 'RetornoC: ' + ls_retorno_C + ': ' + ls_mensagem
		End If
		If ls_cod_msg <> '' Then
			ls_alerta = ls_alerta + ' CodMsg: ' + ls_cod_msg + ': '  + ls_msg_SEFAZ
		End If			
		If Trim(ls_alerta) > '' Then		
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "ALERTA SEFAZ: " + ls_alerta + ' - Avise o Depto de Inform$$HEX1$$e100$$ENDHEX$$tica!', Information!)
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "ALERTA SEFAZ: [" + ls_alerta + "]")			
		End If		
		Return True			
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Rejei$$HEX2$$e700e300$$ENDHEX$$o SAT - retorno: " + ls_retorno_E + " - " +  ls_retorno_C +" - "+ ls_mensagem, Exclamation!)
		Return False			
	End If	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel cancelar CFe!", StopSign!)	
	Return False
End If
end function

public function boolean of_imprime_nota (string ps_chave_nota, string ps_protocolo, string ps_formato_cupom, string ps_cancelamento, string ps_modo);Integer ll_Retorno
String ls_DataRec
String ls_rtm_A4
String ls_path

If ps_modo = 'R' or ps_modo = 'A' Then	
	If Not This.of_busca_xml_ftp(ps_chave_nota) Then Return False
	
	This.of_abre_doc()  // Verifique se o envio est$$HEX1$$e100$$ENDHEX$$ sendo feito fora da venda.
	
	ls_path 		= 'C:\Sistemas\CL\SAT\Templates\impressao'
	ls_rtm_A4 	= 'C:\Sistemas\CL\SAT\Templates\impressao\retrato.rtm'
	
	If ps_modo = 'A' Then		
		If Not FileExists(ls_Path + '\retrato.rtm')  Then
			String   ls_Validar[]
			String   ls_Baixar[]
			
			ls_Validar = {"retrato.rtm"}
			ls_Baixar  = {"retrato.rtm"}			
			
			If Not gf_Download_Matriz(ls_Validar, ls_Baixar, ls_Path, "dll_sat", True) Then
				Messagebox("SAT","Problemas para baixar o arquivo de impress$$HEX1$$e300$$ENDHEX$$o A4!"+&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
				Return False
			End If			
		End If	
	End If	
	
End If

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "SAT - Envio da impress$$HEX1$$e300$$ENDHEX$$o da nota para dll. Chave [" + ps_chave_nota + "]")

If ps_modo = 'A' Then
	ll_retorno =	SAT_Imprimir(ps_chave_nota,&
									  "C:\Sistemas\CL\SAT\CopiaSeguranca\",&
									 "",&
									 ps_cancelamento, &
									 ls_rtm_A4)
Else
	ll_retorno =	SAT_Imprimir(ps_chave_nota,&
									  "C:\Sistemas\CL\SAT\CopiaSeguranca\",&
									 This.nm_impressora_nfce,&
									 ps_cancelamento, &
									 "")	
End If			

Choose Case ll_Retorno
	Case 1 				// Comando OK
		If ps_modo = 'R' Then
			This.of_exclui_xml(ps_chave_nota)
		End If
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "SAT - Sem erro na fun$$HEX2$$e700e300$$ENDHEX$$o da impress$$HEX1$$e300$$ENDHEX$$o.")		
		Return True
	Case 0 				// Erro ao executar comando
		Return False
	Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose	

Return False
end function

public function boolean of_comunica_sat ();Integer ll_retorno
String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_alerta

ls_retorno = Space(10000)
ll_retorno = SAT_Comunica(Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	
//numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ

	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))

	If ls_retorno_E = '08000' Then //SAT em opera$$HEX2$$e700e300$$ENDHEX$$o
//		If Trim(ls_cod_msg) <> '' Then
			//ALERTA - ser$$HEX1$$e100$$ENDHEX$$ mostrado em outras fun$$HEX2$$e700f500$$ENDHEX$$es.
//			ls_alerta			= ls_cod_msg + ': ' + ls_msg_SEFAZ
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "ALERTA SEFAZ: " + ls_alerta + ' Avise o Depto de Inform$$HEX1$$e100$$ENDHEX$$tica!', Information!)
//			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "ALERTA SEFAZ CANCELAMENTO: [" + ls_alerta + "]")			
//		End If		
		Return True
	Else
		If ls_retorno_E = '08098' Then //Quando est$$HEX1$$e100$$ENDHEX$$ desligado vem esse retorno		
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Comunica SAT - retorno: " + ls_retorno_E + " - SAT Desligado ou "+ ls_mensagem, StopSign!)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Comunica SAT - retorno: " + ls_retorno_E + " - "+ ls_mensagem, StopSign!)		
		End If
		Return False			
	End If	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT", StopSign!)	
	Return False
End If

Return True

end function

public function boolean of_status_operacional (ref string ps_retorno);Integer ll_retorno
String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_alerta

ls_retorno = Space(10000)
ll_retorno = SAT_Status_Oper(Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	
//numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ

	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))

	If ls_retorno_E = '10000' Then //SAT em opera$$HEX2$$e700e300$$ENDHEX$$o		
		If Trim(ls_cod_msg) <> '' Then
			//ALERTA - MOSTRAR AO USUARIO??		
			ls_alerta			= ls_cod_msg + ': ' + ls_msg_SEFAZ
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "ALERTA SEFAZ: " + ls_alerta + ' Avise o Depto de Inform$$HEX1$$e100$$ENDHEX$$tica!', Information!)
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "ALERTA SEFAZ CANCELAMENTO: [" + ls_alerta + "]")			
		End If
		ps_retorno = ls_retorno
		Return True
	Else
		If ls_retorno_E = '10098' Then //Quando est$$HEX1$$e100$$ENDHEX$$ desligado vem esse retorno				
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Status SAT - retorno: " + ls_retorno_E + " - SAT Desligado ou "+ ls_mensagem, StopSign!)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Status SAT - retorno: " + ls_retorno_E + " - "+ ls_mensagem, StopSign!)			
		End If
		Return False			
	End If	
Else
	If ll_Retorno = -3 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Vers$$HEX1$$e300$$ENDHEX$$o do componente SAT("+ ls_retorno +") do PDV est$$HEX1$$e100$$ENDHEX$$ desatualizada!~n" +&
									    "Avise o SAF.", StopSign!)	
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT.", StopSign!)			
	End If
	Return False
End If
end function

public function boolean of_atualiza_cadastro_sat ();STRING ls_Serie, &
		 ls_Modelo, &
		 ls_Tipo, &
		 ls_CPD

LONG ll_ECF

BOOLEAN lb_Sucesso = False

//ls_CPD = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF", "CPD","")

//If Trim(UPPER(ls_CPD)) = 'SIM' Then // Fixo para n$$HEX1$$e300$$ENDHEX$$o cadastra SAT teste em base quente.
//	This.ivb_Cadastrada = True		
//	This.ECF = 1
//	Return True
//End If

If Trim(This.nr_serie) = '' Or IsNull(This.nr_serie) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas na leitura dos dados do SAT! ~n"  + &
								"Entre novamente no Sistema de Caixa." ,Exclamation!)		
	Return False
End If

Select nr_ecf, nr_serie
Into :ll_ECF, :ls_serie
From Impressora_fiscal
	Where nr_serie = :This.nr_serie
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case -1
		
		Sqlca.of_MsgDbError('Consulta Cadastro SAT.')
		lb_Sucesso = False
		
	Case 100				

		Select max(nr_ecf) Into :ll_ECF
		From Impressora_fiscal
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_MsgDbError('Sequencial cadastro SAT.')
			Return False
		End If	
		
		If IsNull(ll_ECF) Then ll_ECF = 0		
		ll_ECF ++		
		
		Insert Into impressora_fiscal  
				( nr_ecf,   
				  nr_serie,   
				  id_situacao,   
				  de_fabricante,   
				  de_modelo,   
				  de_tipo)   
		Values (:ll_ECF,
				  :This.nr_serie,   
				  'L',   
				  'SAT',   
				  'SAT',   
				  'SAT')
		Using Sqlca;
				  
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_RollBack()
			Sqlca.of_MsgDbError('Inclus$$HEX1$$e300$$ENDHEX$$o SAT.')
			Return False
		Else
			Sqlca.of_Commit()	
			This.ecf = ll_ECF			
		End If
		
		lb_Sucesso = True		
		
		This.ivb_Cadastrada = True
	
	Case 0
		
		This.ecf = ll_ECF
		
		lb_Sucesso = True		
		
		This.ivb_Cadastrada = True		

End Choose	

Return lb_Sucesso
end function

public function boolean of_ativa_sat ();Integer ll_retorno
String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_alerta, &
		ls_tipo_certificado

ls_tipo_certificado = '1'  // 1 - AC-SAT/SEFAZ     2 - ICP-BRASIL   3 - RENOVACAO ICP-BRASIL
ls_retorno = Space(10000)
ll_retorno = SAT_Ativacao(ls_tipo_certificado, Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	
//numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ

	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))

	If ls_retorno_E = '04000' Then //SAT Ativado com Sucesso!
		Return True
	Else
		If ls_retorno_E = '04003' or ls_retorno_E = '04006' Then //J$$HEX1$$e100$$ENDHEX$$ ativado.
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ativa$$HEX2$$e700e300$$ENDHEX$$o SAT - retorno: " + ls_retorno_E + " - "+ ls_mensagem, Information!)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ativa$$HEX2$$e700e300$$ENDHEX$$o SAT - retorno: " + ls_retorno_E + " - "+ ls_mensagem, StopSign!)			
		End If
		Return False			
	End If	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT.", StopSign!)	
	Return False
End If
end function

public function boolean of_associar_assinatura (string ps_cnpj_sh, string ps_cnpj_loja);Integer ll_retorno
String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_alerta, &
		ls_assinatura, &
		ls_cnpj_loja, &
		ls_cnpj_software_house

ls_retorno = Space(10000)
ls_assinatura = Space(1000)

If This.id_homologacao = '2' Then //Em homologacao	
	ls_cnpj_loja					= '53485215000106'
	ls_cnpj_software_house	= '10615281000140'
Else
	ls_cnpj_loja					= ps_cnpj_loja
	ls_cnpj_software_house	= ps_cnpj_sh
End If

ll_retorno = SAT_Associar_Assinatura_AC(ls_cnpj_software_house, ls_cnpj_loja, This.id_homologacao, Ref ls_assinatura, Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))

	If ls_retorno_E = '13000' Then //Assinatura registrada
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "ASSINATURA ASSOCIADA - Assinatura gerada pela dll: [" + ls_assinatura + "]")
		This.ivs_assinatura_sat = ls_assinatura
		Return True		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Associar Assinatura - retorno: " + ls_retorno_E + " - "+ ls_mensagem, StopSign!)			
		Return False			
	End If	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT.", StopSign!)	
	Return False
End If
end function

public function boolean of_bloquear_sat ();Integer ll_retorno
String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_alerta

ls_retorno = Space(10000)
ll_retorno = SAT_Bloquear(Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))

	If ls_retorno_E = '16000' Then //SAT bloqueado com sucesso.
		Return True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Bloqueio SAT - retorno: " + ls_retorno_E + " - "+ ls_mensagem, StopSign!)			
		Return False			
	End If	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT.", StopSign!)	
	Return False
End If
end function

public function boolean of_desbloquear_sat ();Integer ll_retorno
String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_alerta

ls_retorno = Space(10000)
ll_retorno = SAT_Desbloquear(Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))

	If ls_retorno_E = '17000' Then //SAT desbloqueado com sucesso.
		Return True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desbloqueio SAT - retorno: " + ls_retorno_E + " - "+ ls_mensagem, StopSign!)			
		Return False			
	End If	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT.", StopSign!)	
	Return False
End If
end function

public function boolean of_atualizar_software ();Integer ll_retorno
String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_alerta

ls_retorno = Space(10000)
ll_retorno = SAT_Atualizar_Software(Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))

	If ls_retorno_E = '14000' Then
		Return True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o SAT - retorno: " + ls_retorno_E + " - "+ ls_mensagem, StopSign!)			
		Return False			
	End If	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT.", StopSign!)	
	Return False
End If
end function

public function boolean of_extrair_logs ();Integer ll_retorno, &
		  li_file, &
		  li_Bytes
String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_alerta
String ls_file

ls_retorno = Space(2)
//Devido ao tamanho do texto gerado pelo componente o arquivo de log $$HEX1$$e900$$ENDHEX$$ gravado pela dll
ll_retorno = SAT_Extrair_Log(Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	If Upper(Trim(ls_retorno)) = 'OK' Then
		Return True		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas ao gerar Log do SAT.", StopSign!)	
		Return False		
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT.", StopSign!)	
	Return False
End If
end function

public function boolean of_consulta_sessao (string ps_sessao, ref string ps_retorno);Integer ll_retorno
String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_alerta

ls_retorno = Space(10000)
ll_retorno = SAT_Consulta_Sessao(ps_sessao, Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))

	If ls_retorno_E = '11000' Then //consulta processada com sucesso.
		ps_retorno = ls_retorno
		Return True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o SAT - retorno: " + ls_retorno_E + " - "+ ls_mensagem, StopSign!)			
		Return False			
	End If	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT.", StopSign!)	
	Return False
End If
end function

public function boolean of_teste_fimafim ();Integer ll_retorno
String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ,&
		ls_alerta,&
		ls_arquivo = 'C:\Sistemas\DLL\sat\TesteFimAFim.xml'
		
If Not FileExists(ls_arquivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo para Teste n$$HEX1$$e300$$ENDHEX$$o encontrado.(" + ls_arquivo + ")", StopSign!)
	Return False				
End If

ls_retorno = Space(10000)
ll_retorno = SAT_Teste_FimAFim(ls_arquivo, Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))

	If ls_retorno_E = '09000' Then
		Return True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "TesteFimAFim SAT - retorno: " + ls_retorno_E + " - "+ ls_mensagem, StopSign!)			
		Return False			
	End If	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT.", StopSign!)	
	Return False
End If
end function

public function boolean of_troca_codigo_ativacao (string ps_tipo, string ps_codigo_novo);String ls_retorno, &
		ls_sessao, &
		ls_retorno_E,&
		ls_retorno_C,&
		ls_mensagem,&
		ls_cod_msg,&
		ls_msg_SEFAZ
Integer ll_retorno

ls_retorno = Space(10000)

ll_retorno = SAT_Troca_Codigo_Ativacao(ps_tipo,&
									 	ps_codigo_novo,&
									  	ps_codigo_novo,&
										Ref ls_retorno)

If ll_Retorno = 1 and Trim(ls_retorno) <> '' Then
	
//$$HEX1$$1c20$$ENDHEX$$numeroSessao|EEEEE|CCCC|mensagem|cod|mensagemSEFAZ|arquivoCFeBase64|timeStamp|chaveConsulta|valorTotalCFe|CPFCNPJValue|assinaturaQRCODE$$HEX1$$1d20$$ENDHEX$$

	ls_sessao 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
	ls_retorno_E 		= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
	ls_mensagem 		= Trim(gf_captura_valor(ls_retorno, '|', 3, false))
	ls_cod_msg	 		= Trim(gf_captura_valor(ls_retorno, '|', 4, false))
	ls_msg_SEFAZ		= Trim(gf_captura_valor(ls_retorno, '|', 5, false))

	If ls_retorno_E = '18000' Then //SAT em opera$$HEX2$$e700e300$$ENDHEX$$o
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "TROCA de codigo SAT novo codigo e tipo: [" + ps_codigo_novo + "  -  "+ ps_tipo + "]")			
		Return True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Troca Codigo SAT - retorno: " + ls_retorno_E + " - "+ ls_mensagem, StopSign!)		
		Return False			
	End If	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel Comunicar com o SAT", StopSign!)	
	Return False
End If
end function

public function boolean of_cabecalho_sat (string ps_nr_nf, string ps_forma_pagamento, string ps_natureza_operacao, datetime pdt_emissao, string ps_tipo_impressao, string ps_forma_emissao, string ps_finalidade, string ps_consumidor, string ps_ind_presenca);Integer 	ll_Retorno
String		ls_versao, &
			ls_Codigo_uf, &
			ls_assinatura, &
			ls_fuso, &
			ls_cod_cidade, &
			ls_CNPJ_soft, &
			ls_CNPJ_Loja,&
			ls_caixa
			
ls_fuso 			= gvo_parametro.de_fuso_horario_NFCE

If This.id_homologacao = '2' Then //Em homologacao	
	ls_cnpj_soft		= '10615281000140' //CNPJ Software House
	ls_cnpj_loja		= ''
	ls_assinatura = 'SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT'
Else
	ls_cnpj_soft		= '84683481000177' //CNPJ Software House
	ls_cnpj_loja		= gvo_parametro.nr_cgc		
	ls_assinatura 	= ''
End If

ls_caixa = '0' + RightA(PDV.cd_caixa, 2)
//ls_versao 		= "0.06"  - Agora usa a vers$$HEX1$$e300$$ENDHEX$$o suportada pelo equipamento, que $$HEX1$$e900$$ENDHEX$$ carregada no of_abreporta()
ls_versao = This.is_versao_leiaute
ls_cod_cidade	= gvo_parametro.cd_cidade_ibge
This.of_codigo_uf(gvo_parametro.ivs_uf_filial, Ref ls_Codigo_uf)

ll_Retorno = SAT_Cabecalho( ls_versao,&
									   ls_cnpj_soft, &
									   ls_cnpj_loja, &
									   ls_assinatura, &
									   ls_caixa) 

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

public function boolean of_consulta_sat (string ps_chave, ref string ps_protocolo, ref string ps_retorno, ref string ps_status, ref string ps_motivo, ref datetime pdt_data_rec, ref string ps_chave_rec);Long ll_retorno
String ls_chave, ls_protocolo, ls_retorno, ls_status, ls_motivo, ls_data, ls_chaverec, ls_hora

ls_retorno = Space(1000)
ls_Status = Space(100)
ls_Motivo = Space(500)
ls_data = Space(100)
ls_protocolo = Space(15)
ls_chaveRec = Space(100)

This.of_abre_doc()

//ll_retorno = NFCe_Consulta( ps_chave,&
//										Ref ls_protocolo,&
//										Ref ls_retorno,&
//										Ref ls_Status,&
//										Ref ls_Motivo,&
//										Ref ls_data,&
//										Ref ls_ChaveRec)

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

public function boolean of_dados_sat (string ps_caixa, ref long pl_sequencial, ref long pl_caixa);Long ll_caixa

//If LenA(ps_caixa) <> 6 Then
//	Messagebox("NFC-e","N$$HEX1$$fa00$$ENDHEX$$mero do caixa n$$HEX1$$e300$$ENDHEX$$o configurado ou configurado incorretamente."+&
//				  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
//	Return False	
//End If
//
//ll_caixa = Long(RightA(ps_caixa, 2))
//If ll_caixa = 0 Then
//	Messagebox("NFC-e","N$$HEX1$$fa00$$ENDHEX$$mero do caixa configurado incorretamente."+&
//				  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
//	Return False		
//End If

pl_caixa = This.ECF

//Para SAT o numero do SAT ser$$HEX1$$e100$$ENDHEX$$ usado como sequencial. Para melhor tratamento de transa$$HEX2$$e700f500$$ENDHEX$$es TEF.
pl_sequencial = This.ECF

Return True
end function

public function boolean of_totais_sat (decimal pd_total_bc, decimal pd_total_icms, decimal pd_total_bcst, decimal pd_total_st, decimal pd_total_produtos, decimal pd_total_frete, decimal pd_total_seg, decimal pd_total_desc, decimal pd_total_ii, decimal pd_total_ipi, decimal pd_total_pis, decimal pd_total_cofins, decimal pd_total_outros, decimal pd_total_nf, decimal pd_total_tributos, string ps_mod_frete, string ps_formas_pgto[], decimal ps_valores_pgto[], decimal pd_troco, ref string ps_chave_nota, string ps_observacao);String ls_total_desconto, &
		 ls_total_tributos, &
		 ls_zero, &
		 ls_Pagto, &
		 ls_chave_nota, &
		 ls_valor_pagto
		 
Long	ll_ind
Integer ll_Retorno
Decimal {2} ldc_valor
Decimal {2} ldc_PIS, ldc_COFINS

//Na inclus$$HEX1$$e300$$ENDHEX$$o do item s$$HEX1$$e300$$ENDHEX$$o usada 3 casas para o calculo ficar correto
//Para o SEFAZ deve ser enviado 2 casas, uso o Truncate porque tem casos que o arredondadmento faz errado.
//ldc_PIS 		= Truncate( pd_total_pis , 2)
//ldc_COFINS = Truncate( pd_total_cofins , 2 )

//Verifica se o aparelho SAT est$$HEX1$$e100$$ENDHEX$$ ligado e conectado ao PDV
If Not This.of_comunica_sat() Then Return False		 
		 
ls_zero 					= '0.00'
ls_Total_desconto		= gf_valor_com_ponto(pd_total_desc)
ls_Total_Tributos		= gf_valor_com_ponto(pd_total_tributos)

ll_retorno = SAT_Totais(ls_Total_desconto,&
								ls_Total_Tributos,&
								ps_Observacao)

If ll_retorno = 1 Then

	For ll_ind = 1 TO UpperBound(ps_formas_pgto)
		
		ls_Pagto  	 	= MidA(ps_formas_pgto[ll_ind],1,2)
			
		Choose Case ls_Pagto
			Case "02", "03" //cheques
				ls_Pagto = "02"
			Case "04" //Cartao credito
				ls_Pagto = "03"
			Case "05" //carto debito
				ls_Pagto = "04"
			Case "06", "07", "08", "09" //clube - conv$$HEX1$$ea00$$ENDHEX$$nio - crediario
				ls_Pagto = "05"
			Case "10" //PBM
				ls_Pagto = "99"
//			Case "17", "18" //Pix - carteira digital
//				ls_Pagto = ls_Pagto
			Case Else
				ls_Pagto = "01"
		End Choose
		
		if ls_Pagto = "01" And pd_troco > 0 Then	
			ldc_valor = ps_valores_pgto[ll_ind]			
//			If ldc_valor > pd_troco Then
//				ldc_valor = ldc_valor - pd_troco
//			Else
//				ldc_valor = pd_troco - ldc_valor
//			End If
			ls_valor_pagto  = gf_valor_com_ponto(ldc_valor)			
		Else
			ls_valor_pagto  = gf_valor_com_ponto(ps_valores_pgto[ll_ind])			
		End If
		
		ll_Retorno = SAT_FormasPagamento(ls_Pagto,ls_valor_pagto)	

		Choose Case ll_Retorno
			Case 1 				// Comando OK
				//Return True
			Case 0 				// Erro ao executar comando
				Return False
			Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
				Return False
		End Choose	
	
	Next
Else
	Return False
End If

ls_chave_nota = Space(50)
ll_Retorno = SAT_SalvarNota(Ref ls_chave_nota)

Choose Case ll_Retorno
	Case 1 				// Comando OK
		ps_chave_nota = ls_chave_nota
		Return True
	Case 0 				// Erro ao executar comando
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar a venda no SAT. Venda ser$$HEX1$$e100$$ENDHEX$$ cancelada!~r" + &
									  "Enquanto essa mensagem estiver sendo exibida, poder$$HEX1$$e100$$ENDHEX$$ ocorrer o travamento de outras vendas.~r" +&
									  "uo_ge039_sat - of_totais_sat() - erro comando",Exclamation!)		
		Return False
	Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar a venda no SAT. Venda ser$$HEX1$$e100$$ENDHEX$$ cancelada!~r" + &
									  "Enquanto essa mensagem estiver sendo exibida, poder$$HEX1$$e100$$ENDHEX$$ ocorrer o travamento de outras vendas.~r" +&
									  "uo_ge039_sat - of_totais_sat() - erro fun$$HEX2$$e700e300$$ENDHEX$$o",Exclamation!)		
		Return False
End Choose	

Return False;
end function

public function boolean of_gera_codigo_vinculacao (string ps_cnpj_sh, string ps_cnpj_loja, ref string ps_codigo);Integer ll_retorno
String ls_codigo

ls_codigo = Space(1000)

ll_retorno = SAT_Gera_Codigo_Vinculacao(ps_cnpj_sh, ps_cnpj_loja, Ref ls_codigo)

If ll_Retorno = 1 and Trim(ls_codigo) <> '' Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "CODIGO VINCULACAO - Codigo gerado pela dll: [" + ls_codigo + "]")
//	Messagebox("SAT C$$HEX1$$f300$$ENDHEX$$digo Vincula$$HEX2$$e700e300$$ENDHEX$$o",ls_codigo)
	ps_codigo = ls_codigo
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas ao gerar o C$$HEX1$$f300$$ENDHEX$$digo de Vincula$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)	
	Return False
End If
end function

public function boolean of_destinatario (string ps_cpf_cgc, string ps_codigo_cliente, string ps_nm_cliente, string ps_endereco, string ps_nr_endereco, string ps_bairro, string ps_cidade_ibge, string ps_nm_cidade, string ps_uf, string ps_email_xml, boolean pb_programa_governo, boolean pb_mesmo_cpf);Integer ll_Retorno
String ls_nulo
String ls_nome
String ls_cpf
String ls_cgc
String ls_endereco
String ls_nr_endereco
String ls_Bairro
String ls_cidade
String ls_uf
String ls_uf_filial
String ls_cnpj
String ls_codigo_uf

Boolean lb_Endereco_Filial
Boolean lb_Resumido

SetNull(ls_nulo)

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
	lb_Resumido = True
Else
	ls_nome			= ps_nm_cliente
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
	ls_cidade				= Trim(ps_nm_cidade)
	If IsNull(ps_nm_cidade) Or Trim(ps_nm_cidade) = '' Then 	lb_Resumido = True //ls_cidade = gvo_parametro.nm_cidade_filial
	ls_uf					= Trim(ps_uf)
	If IsNull(ps_uf) Or Trim(ps_uf) = '' Then lb_Resumido = True//ls_uf = gvo_parametro.ivs_uf_filial			
	If Not pb_mesmo_cpf Then //Se foi informado outro cpf para programa do governo, nao passo informa$$HEX2$$e700f500$$ENDHEX$$es cadastrais, somente o cpf.
		lb_Resumido = True		
		ls_nome 		 = ls_nulo
	End If
End If

If Not lb_Resumido Then
	ll_retorno = SAT_Destinatario(ls_cgc,&
							ls_cpf,&
							ls_nome,&
							ls_endereco,&
							ls_nr_endereco,&
							ls_nulo,&
							ls_bairro,&
							ls_cidade,&
							ls_uf)
Else
	ll_retorno = SAT_Destinatario_Resumido(ls_cgc,&
							ls_cpf,&
							ls_nome)							
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

public function boolean of_registra_item_sat (long pl_item, string ps_produto, string ps_codigo_barras, string ps_descricao, long pl_ncm, long pl_cfop, string ps_unidade_medida, long pl_quantidade, decimal pd_valor_unitario, string ps_regra_calculo, decimal pd_valor_desconto, decimal pd_valor_outros, decimal pd_total_tributos, string ps_origem, string ps_cst_tributacao_icms, decimal pd_aliquota_icms, string ps_tributacao_pis_cofins, string ps_inf_adicionais, decimal pd_preco_praticado, string ps_cest, string ps_beneficio, integer pi_nr_item, string ps_codigo_sap);Integer ll_Retorno

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
		lvs_aliq_pis = '1.6500',&
		lvs_aliq_cofins = '7.6000',&
		lvs_descricao, &
		lvs_item, &
		lvs_valor_icms, &
		lvs_valor_pis, &
		lvs_valor_cofins, &
		lvs_NCM, &
		lvs_CEST

Decimal {3} ldc_valor_icms
Decimal {2} ldc_valor_pis
Decimal {2} ldc_valor_cofins
Decimal {4} ldc_aliq_pis
Decimal {4} ldc_aliq_cofins
String ls_nulo
String ls_qtd, ls_auxiliar
Long ll_posicao
SetNull(ls_nulo)

ls_auxiliar = string(pl_quantidade, "0.0000")
ll_posicao  = PosA(ls_auxiliar, ",")
ls_qtd    = LeftA(ls_auxiliar,ll_posicao - 1) + "." + &
               MidA(ls_auxiliar,ll_posicao + 1,4)


lvs_item 			= String(pl_item)
lvs_NCM			= String(pl_NCM,'00000000')
lvs_precounit	= gf_valor_com_ponto(pd_valor_unitario)
lvs_total_prod	= gf_valor_com_ponto(pd_valor_unitario * pl_quantidade)
lvs_total_praticado = gf_valor_com_ponto(pd_preco_praticado * pl_quantidade)
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

lvs_CEST			= ls_nulo
If ps_cst_tributacao_icms = "00" Then
	lvs_base_icms = lvs_total_praticado
	ldc_valor_icms = ((pd_preco_praticado * pl_quantidade) * pd_aliquota_icms) / 100
	lvs_valor_icms = gf_valor_com_ponto(ldc_valor_icms)
Else
	If ps_cst_tributacao_icms = "60" Then
		lvs_CEST = ps_CEST
	End If
	lvs_base_icms = "0.00"
	lvs_valor_icms = "0.00"
End If

Choose Case ps_tributacao_pis_cofins
	Case "N"
		lvs_pis_cofins			= "06"
		lvs_qtd_pis_cofins		= "0.0000"
		lvs_valor_pis_cofins 	= "0.00"
		lvs_aliq_pis 				= "0.00"
		lvs_aliq_cofins 			= "0.00"
		lvs_valor_pis			= "0.00"
		lvs_valor_cofins		= "0.00"
	Case "T"
		//No caso do SAT Sweda $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio passar o percentual da aliquota PIS/COFINS divido por 100. O SAT calcula o total destes impostos.
		lvs_aliq_pis = '0.0165'
		lvs_aliq_cofins = '0.0760'
		//
		lvs_pis_cofins			= "01"
		lvs_qtd_pis_cofins		= ls_qtd
		lvs_valor_pis_cofins 	= lvs_total_praticado
		ldc_valor_pis			= ((pd_preco_praticado * pl_quantidade) * 1.65) / 100
		lvs_valor_pis			= 	gf_valor_com_ponto(ldc_valor_pis)
		ldc_valor_cofins		= ((pd_preco_praticado * pl_quantidade) * 7.60) / 100
		lvs_valor_cofins		= 	gf_valor_com_ponto(ldc_valor_cofins)		
	Case "P"
		lvs_pis_cofins			= "04"
		lvs_qtd_pis_cofins		= "0.0000"
		lvs_valor_pis_cofins 	= "0.00"
		lvs_aliq_pis 				= "0.00"
		lvs_aliq_cofins 			= "0.00"
		lvs_valor_pis			= "0.00"
		lvs_valor_cofins		= "0.00"
		
End Choose

lvs_Descricao = ps_descricao
lvs_Descricao = gf_replace(lvs_Descricao, '>', ' ', 0)
lvs_Descricao = gf_replace(lvs_Descricao, '<', ' ', 0)
lvs_Descricao = gf_replace(lvs_Descricao, '&', 'e', 0)
lvs_Descricao = gf_replace(lvs_Descricao, '"', ' ', 0)
lvs_Descricao = gf_replace(lvs_Descricao, "'", ' ', 0)
lvs_Descricao = gf_replace(lvs_Descricao, '$$HEX3$$a000a000a000$$ENDHEX$$', '', 0)
lvs_Descricao = Trim(lvs_descricao)

If Not IsNull(ps_codigo_sap) And Trim(ps_codigo_sap) > '' Then
	ps_produto = ps_codigo_sap
End If

ll_Retorno = SAT_Item( lvs_item,&		
								ps_produto,&	
								ls_nulo,&	
								lvs_descricao,&	
								lvs_NCM,&	
								String(pl_CFOP),&	
								ps_unidade_medida,&	
								ls_qtd,&
								lvs_precounit,&	
								lvs_desconto,&	
								lvs_tributos,&	
								ps_origem,&	
								ps_cst_tributacao_icms,&	
								lvs_trib_icms,&	
								lvs_pis_cofins,&	
								lvs_valor_pis_cofins,&	
								lvs_aliq_pis,&	
								lvs_pis_cofins,&	
								lvs_valor_pis_cofins,&	
								lvs_aliq_cofins,&
								'T',&
								lvs_CEST)

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

on uo_ge039_sat.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge039_sat.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//This.of_fecha_conexao()
end event

event constructor;This.of_atualiza_dlls()
end event

