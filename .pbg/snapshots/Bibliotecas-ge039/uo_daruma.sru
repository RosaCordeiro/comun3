HA$PBExportHeader$uo_daruma.sru
forward
global type uo_daruma from nonvisualobject
end type
end forward

global type uo_daruma from nonvisualobject
end type
global uo_daruma uo_daruma

type prototypes
FUNCTION Long eInterpretarRetorno_ECF_Daruma(Integer iIndice, Ref String Retorno) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" Alias For "eInterpretarRetorno_ECF_Daruma;Ansi";//Daruma_FI_RetornoImpressora
FUNCTION Long eRetornarAvisoErroUltimoCMD_ECF_Daruma(Ref String Aviso, Ref String Erro) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" Alias For "eRetornarAvisoErroUltimoCMD_ECF_Daruma;Ansi";//Daruma_FI_RetornaErroExtendido
FUNCTION Long iCFAbrir_ECF_Daruma(String CPF,String Nome,String Endereco) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" Alias For "iCFAbrir_ECF_Daruma;Ansi";//Daruma_FI_AbreCupom
FUNCTION Long iRGAbrir_ECF_Daruma(String NomeRG) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" Alias For "iRGAbrir_ECF_Daruma;Ansi";//Daruma_FIMFD_AbreRelatorioGerencial
FUNCTION Long iRGAbrirPadrao_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iRGAbrirPadrao_ECF_Daruma;Ansi"; //Daruma_FIMFD_AbreRelatorioGerencial
FUNCTION Long iCFLancarAcrescimoUltimoItem_ECF_Daruma(String TipoAcresc, String ValorAcresc) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" Alias For "aCFLancarAcrescimoItem_NFCe_Daruma;Ansi";//Daruma_FIMFD_DescontoAcrescimoItem
FUNCTION Long iCFLancarDescontoUltimoItem_ECF_Daruma(String TipoDesc, String ValDesc) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" Alias For "aCFLancarDescontoItem_NFCe_Daruma;Ansi";//Daruma_FIMFD_DescontoAcrescimoItem
FUNCTION Long iCFCancelar_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll";//Daruma_FI_CancelaCupom
FUNCTION Long rDataHoraImpressora_ECF_Daruma(Ref String Data, Ref String Hora) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" Alias For "rDataHoraImpressora_ECF_Daruma;Ansi";//Daruma_FI_DataHoraImpressora
FUNCTION Long rRetornarDadosReducaoZ_ECF_Daruma(Ref String Retorno) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" Alias For "rRetornarDadosReducaoZ_ECF_Daruma;Ansi";//Daruma_FI_DataHoraReducao
FUNCTION Long iCFEfetuarPagamentoFormatado_ECF_Daruma(String FormaPgto, String Valor) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" Alias For "iCFEfetuarPagamentoFormatado_ECF_Daruma;Ansi";//Daruma_FI_EfetuaFormaPagamento
FUNCTION Long iCNFCancelar_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll";//Daruma_FI_FechaComprovanteNaoFiscalVinculado
FUNCTION Long iRGFechar_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll";//Daruma_FI_FechaRelatorioGerencial
FUNCTION Long rVerificarGTCodificado_ECF_Daruma(Ref String Valor) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rVerificarGTCodificado_ECF_Daruma;Ansi";//Daruma_FI_GrandeTotal
FUNCTION Long iCFEncerrarResumido_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll";//Daruma_FI_IniciaFechamentoCupom
FUNCTION Long iLeituraX_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll";//Daruma_FI_LeituraX
FUNCTION Long rLeituraX_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll";//Daruma_FI_LeituraXSerial
FUNCTION Long iReducaoZ_ECF_Daruma(String Data, String Hora) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iReducaoZ_ECF_Daruma;Ansi";//Daruma_FI_ReducaoZ
FUNCTION Long iCFEncerrarConfigMsg_ECF_Daruma(String Mensagem) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCFEncerrarConfigMsg_ECF_Daruma;Ansi";//Daruma_FI_TerminaFechamentoCupom
FUNCTION Long iRGImprimirTexto_ECF_Daruma(String Texto) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iRGImprimirTexto_ECF_Daruma;Ansi";//Daruma_FI_RelatorioGerencial
FUNCTION Long rRetornarVendaBruta_ECF_Daruma(Ref String Retorno) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rRetornarVendaBruta_ECF_Daruma;Ansi";//Daruma_FI_VendaBruta
FUNCTION Long iCFVender_ECF_Daruma(String CargaTributaria, String Quantidade, String PrecoUnitario, String TipoDescAcresc, String ValorDescAcresc, String CodigoItem, String UnidadeMedida, String DescricaoItem) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCFVender_ECF_Daruma;Ansi";//Daruma_FI_VendeItem
FUNCTION Long rVerificarImpressoraLigada_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll";//Daruma_FI_VerificaImpressoraLigada
FUNCTION Long rCFVerificarStatus_ECF_Daruma(Ref String StatusStr, Ref Int StatusInt) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rCFVerificarStatus_ECF_Daruma;Ansi";//Daruma_FI_StatusCupomFiscal
FUNCTION Long rAssinarRSA_ECF_Daruma(String PathArquivo, string ChavePrivada, string AssinaturaGerada) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rAssinarRSA_ECF_Daruma;Ansi";//Daruma_RSA_CriarAssinatura
FUNCTION Long eAbrirGaveta_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll";//Daruma_FI_AcionaGaveta
FUNCTION Long rRetornarNumeroSerieCodificado_ECF_Daruma(Ref String Valor) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rRetornarNumeroSerieCodificado_ECF_Daruma;Ansi";//Daruma_FI_NumeroSerie
FUNCTION Long rRSAChavePublica_ECF_Daruma(Ref String ChavePrivada, Ref String ChavePublica, Ref String Expoente) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rRSAChavePublica_ECF_Daruma;Ansi";//Daruma_RSA_RetornaChavePublica
FUNCTION Long rEfetuarDownloadMFD_ECF_Daruma(String Tipo, String Inicial, String Final, String NomeArquivo) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rEfetuarDownloadMFD_ECF_Daruma;Ansi";//Daruma_FIMFD_DownloadDaMFD
FUNCTION Long iCFCancelarUltimoItem_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll";//Daruma_FI_CancelaItemAnterior
FUNCTION Long iSangria_ECF_Daruma(String Valor, String Mensagem) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iSangria_ECF_Daruma;Ansi"; //Daruma_FI_Sangria
FUNCTION Long iSuprimento_ECF_Daruma (String Valor, String Mensagem) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iSuprimento_ECF_Daruma;Ansi"; //Daruma_FI_Suprimento
FUNCTION Long regAlterarValor_Daruma(String PathChave, String Valor) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "regAlterarValor_Daruma;Ansi";//Daruma_Registry_AlterarRegistry
FUNCTION Long rGerarRelatorio_ECF_Daruma(String Relatorio, String Tipo, String Str_Inicial, String Str_Final) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rGerarRelatorio_ECF_Daruma;Ansi";//Daruma_FIMFD_GerarAtoCotepePafData
FUNCTION Long rGerarEspelhoMFD_ECF_Daruma(String Tipo, String Inicial, String Final) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rGerarEspelhoMFD_ECF_Daruma;Ansi";//Daruma_FIMFD_GerarAtoCotepePafData
FUNCTION Long iMFLer_ECF_Daruma(String Inicial, String Final) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iMFLer_ECF_Daruma;Ansi";//Daruma_FI_LeituraMemoriaFiscalData
FUNCTION Long iMFLerSerial_ECF_Daruma(String Inicial, String Final) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iMFLerSerial_ECF_Daruma;Ansi";
FUNCTION Long eSinalSonoro_ECF_Daruma(String Numero_Beep) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "eSinalSonoro_ECF_Daruma;Ansi";//Daruma_FIMFD_SinalSonoro
FUNCTION Long iImprimirCodigoBarras_ECF_Daruma(String Tipo, String Largura, String Altura, String ImprTexto, String Codigo, String Orientacao, String TextoLivre) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iImprimirCodigoBarras_ECF_Daruma;Ansi";//Daruma_FIMFD_ImprimeCodigoBarras
FUNCTION Long rRetornarInformacao_ECF_Daruma(String Indice, Ref String Retornar) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rRetornarInformacao_ECF_Daruma;Ansi";//Daruma_FIMFD_RetornaInformacao
FUNCTION Long rCalcularMD5_ECF_Daruma(string pszPathArquivo, ref string pszMD5GeradoHex, ref string pszMD5GeradoAscii) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rCalcularMD5_ECF_Daruma;Ansi"; 
FUNCTION Long iCFLancarDescontoItem_ECF_Daruma(String NumItem, String TipoDesc, String ValorDesc) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCFLancarDescontoItem_ECF_Daruma;Ansi"; //Daruma_FIMFD_DescontoAcrescimoItem
FUNCTION Long iCFTotalizarCupom_ECF_Daruma(String TipoDesc, String ValorDesc) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCFTotalizarCupom_ECF_Daruma;Ansi"; //Daruma_FI_IniciaFechamentoCupom
FUNCTION Long iCCDAbrirSimplificado_ECF_Daruma(String FormaPgto, String Parcelas, String COOVenda, String Valor) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCCDAbrirSimplificado_ECF_Daruma;Ansi"; //Daruma_FI_AbreComprovanteNaoFiscalVinculado
FUNCTION Long iCCDImprimirTexto_ECF_Daruma(String Texto) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCCDImprimirTexto_ECF_Daruma;Ansi"; //Daruma_FI_UsaComprovanteNaoFiscalVinculado
FUNCTION Long iCCDFechar_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCCDFechar_ECF_Daruma;Ansi"; //Daruma_FI_FechaComprovanteNaoFiscalVinculado
FUNCTION Long iCNFAbrirPadrao_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCNFAbrirPadrao_ECF_Daruma;Ansi"; //Daruma_FIMFD_AbreRecebimentoNaoFiscal
FUNCTION Long iCNFReceber_ECF_Daruma(String Indice, String Valor, String TipoDesc, String ValorDesc) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCNFReceber_ECF_Daruma;Ansi"; //Daruma_FIMFD_RecebimentoNaoFiscal
FUNCTION Long iCNFTotalizarComprovante_ECF_Daruma(String TipoDesc, String ValorDesc) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCNFTotalizarComprovante_ECF_Daruma;Ansi"; //Daruma_FIMFD_IniciaFechamentoNaoFiscal
FUNCTION Long iCNFEfetuarPagamentoFormatado_ECF_Daruma(String FormaPgto, String Valor) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCNFEfetuarPagamentoFormatado_ECF_Daruma;Ansi"; //Daruma_FIMFD_EfetuaFormaPagamentoNaoFiscal
FUNCTION Long iCNFEncerrar_ECF_Daruma(String Mensagem) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCNFEncerrar_ECF_Daruma;Ansi"; //Daruma_FIMFD_TerminaFechamentoNaoFiscal
FUNCTION Long rStatusImpressoraBinario_ECF_Daruma(ref String Status) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rStatusImpressoraBinario_ECF_Daruma;Ansi"; //flagsfiscias
FUNCTION Long rTipoUltimoDocumentoInt_ECF_Daruma(ref String Doc) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rTipoUltimoDocumentoInt_ECF_Daruma;Ansi";
FUNCTION Long rTipoUltimoDocumentoStr_ECF_Daruma(ref String Doc) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rTipoUltimoDocumentoStr_ECF_Daruma;Ansi";
FUNCTION Long confCadastrar_ECF_Daruma(String Cadastrar, String Valor, String Separador) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "confCadastrar_ECF_Daruma;Ansi";//Daruma_FIMFD_ProgramaRelatoriosGerenciais
FUNCTION Long iCNFEncerrarPadrao_ECF_Daruma() LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCNFEncerrarPadrao_ECF_Daruma;Ansi";//Daruma_FI_FechaComprovanteNaoFiscalVinculado
FUNCTION Long rInfoCNF_ECF_Daruma(ref String Retorno) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rInfoCNF_ECF_Daruma;Ansi";//Daruma_FI_VerificaRecebimentosNaoFiscal
FUNCTION Long rStatusUltimoCmdInt_ECF_Daruma(ref Int Erro, ref int Aviso) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rStatusUltimoCmdInt_ECF_Daruma;Ansi";
FUNCTION Long eInterpretarErro_ECF_Daruma(Int Indice, ref String Erro) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "eInterpretarErro_ECF_Daruma;Ansi";
FUNCTION Long eInterpretarAviso_ECF_Daruma(Int Indice, ref String Aviso) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "eInterpretarAviso_ECF_Daruma;Ansi";
FUNCTION Long rStatusUltimoCmd_ECF_Daruma(ref String sErro, ref String sAviso, ref int iErro, ref int iAviso) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rStatusUltimoCmd_ECF_Daruma;Ansi";
FUNCTION Long rConsultaStatusImpressoraInt_ECF_Daruma(Int Indice, ref Int Retorno) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rConsultaStatusImpressoraInt_ECF_Daruma;Ansi";
FUNCTION Long rVerificarReducaoZ_ECF_Daruma(ref String Retorno) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rVerificarReducaoZ_ECF_Daruma;Ansi";
FUNCTION Long eVerificarVersaoDLL_Daruma(ref String Versao) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "eVerificarVersaoDLL_Daruma;Ansi";
FUNCTION Long rLerAliquotas_ECF_Daruma(Ref String Aliquotas) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rLerAliquotas_ECF_Daruma;Ansi";//Daruma_FI_StatusCupomFiscal
FUNCTION Long iCFCancelarItem_ECF_Daruma(String Item) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "iCFCancelarItem_ECF_Daruma;Ansi";
FUNCTION Long rEfetuarDownloadMF_ECF_Daruma(String NomeMF) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rEfetuarDownloadMF_ECF_Daruma;Ansi";
FUNCTION Long rEfetuarDownloadMFD_ECF_Daruma(String NomeMFD) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rEfetuarDownloadMFD_ECF_Daruma;Ansi";
FUNCTION Long rGerarRelatorioOffline_ECF_Daruma(String Relatorio, String Tipo, String Str_Inicial, String Str_Final, String Str_ArqMF, String Str_ArqMFD, String Str_ArqINF) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rGerarRelatorioOffline_ECF_Daruma;Ansi"
FUNCTION Long rCFSubTotal_ECF_Daruma(Ref String SubTotalCupom) LIBRARY "C:\sistemas\dll\daruma\DarumaFrameWork.dll" alias for "rCFSubTotal_ECF_Daruma;Ansi";
end prototypes

type variables
CONSTANT INTEGER COLUNAS = 57

STRING ivs_status

BOOLEAN ivb_cancelar       =  FALSE
BOOLEAN ivb_showerror      = TRUE
BOOLEAN ivb_gaveta          =  FALSE
BOOLEAN ivb_modo_teste   = FALSE
BOOLEAN ivb_porta_aberta = FALSE
BOOLEAN ivb_Ativa             = FALSE
BOOLEAN ivb_ReducaoZ    = FALSE
BOOLEAN ivb_Cadastrada  = FALSE
BOOLEAN ivb_Cod_Barras	= FALSE
BOOLEAN ivb_ReducaoZ_Pendente = FALSE

LONG ECF
LONG Porta
LONG Timeout
Integer Ack
Integer St1
Integer St2
Integer St3

STRING ivs_Path_Log
STRING ivs_Versao
STRING ivs_grava_log
STRING ivs_MD5_CL

STRING nr_Serie
STRING nr_Serie_MFD
STRING de_Modelo
STRING de_Marca
STRING de_Tipo
STRING nr_versao_swbasico
STRING Id_Situacao
STRING ivs_Cod_Barras

STRING Id_MFAdicional

DATETIME dh_SWBasico
DATETIME dh_ultima_venda

DECIMAL pc_Livre_mfd
end variables

forward prototypes
public function string of_indicador_aliquota (decimal pd_aliquota, string ps_tributacao_icms)
public function boolean of_impressora_online ()
public function boolean of_fecha_recebimento_nao_fiscal ()
public function boolean of_registra_documento_ecf (string ps_documento)
public function boolean of_grava_mapa_resumo (date pdh_data)
public function string of_formata_valor_pafecf (decimal pdc_valor, long pl_inteiro, long pl_decimal)
public function boolean of_verifica_ultimo_mapa_resumo ()
public function boolean of_verifica_drivers ()
public function boolean of_cancela_cupom ()
public function boolean of_permite_cancelamento_cupom ()
public function boolean of_mapa_resumo (ref s_ge039_mapa_resumo ps_mapa_resumo)
public function boolean of_cancela_recebimento_nao_fiscal ()
public function boolean of_abre_gaveta ()
public function boolean of_data_ultimo_documento (ref datetime pd_data)
public function boolean of_atualiza_drivers ()
public function boolean of_imprime_relatorio_gerencial (string ps_texto[])
public function boolean of_reducaoz ()
public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final)
public function boolean of_sangria_caixa (decimal pdc_valor)
public function boolean of_suprimento_caixa (decimal pdc_valor)
public function boolean of_configuracoes ()
public function boolean of_cancela_ultimo_cupom (boolean pb_confirmar)
public function boolean of_cancela_ultimo_cupom (boolean pb_confirmar, string ps_responsavel)
public function boolean of_verifica_cupons_pendentes ()
public function boolean of_verifica_flags_fiscais ()
public function boolean of_verifica_forma_pagamento (ref string ps_formapagto[])
public function boolean of_conecta_impressora ()
public function boolean of_gera_arquivo_cotepe1704 (string ps_tipo, string ps_inicio, string ps_final)
public function boolean of_data_ultima_reducaoz (ref date pdt_data)
public function boolean of_fecha_comprovante_nao_fiscal ()
public function boolean of_fecha_comprovante_tef ()
public function boolean of_fecha_relatorio_gerencial ()
public function boolean of_desconto_cupom (string ps_texto, decimal pdc_valor)
public function boolean of_leiturax ()
public function boolean of_leiturax (boolean pb_arquivo)
public function boolean of_valor_pago_ultimo_cupom (decimal pdc_valor)
public function boolean of_venda_bruta (ref decimal pdc_venda)
public function boolean of_texto_nao_fiscal_tef (string ps_texto)
public function boolean of_desconto_item (long pl_item, decimal pdc_desonto, decimal pdc_valor)
public function boolean of_recebimento_nao_fiscal (string ps_tipo, string ps_valor)
public function boolean of_efetua_recebimento_nao_fiscal (string ps_tipo, string ps_valor, string ps_forma_pgmto)
public function boolean of_programa_recebimento_nao_fiscal (long pl_totalizador, string ps_descricao)
public function boolean of_inicializa_recebimento_nao_fiscal ()
public function boolean of_programa_formas_pagamento (string ps_forma)
public function boolean of_percentual_livre_mfd ()
public function boolean of_data_hora_usuario_software_basico ()
public function boolean of_fecha_cupom_nao_fiscal ()
public function boolean of_sequencial_cancelamento (ref long pl_seq)
public function boolean of_verifica_problemas_impressora ()
public function boolean of_leitura_memoria_fiscal (string ps_inicio, string ps_final, boolean pb_arquivo, string ps_tipo, boolean pb_data)
public function string of_meio_pagamento (string ps_pagamento)
public function boolean of_programa_relatorio_gerencial (string ps_tipo)
public function boolean of_verifica_versao_software_basico ()
public function boolean of_verifica_recebimento_nao_fiscal (ref string ps_recebimento[])
public function boolean of_verifica_data_movimentacao ()
public function boolean of_abreporta ()
public function boolean of_marca_modelo_tipo ()
public function boolean of_totaliza_cupom (string ps_tipo[], decimal pd_valor[])
public function boolean of_leitura_memoria_fiscal_ac1704 (string ps_dado_inicio, string ps_dado_final)
public function boolean of_nr_cupom (ref long pl_cupom)
public function boolean of_nr_ecf (ref long pl_ecf)
public function boolean of_horaecf (ref string ps_hora)
public function boolean of_dataecf (ref date pdt_data)
public function boolean of_datafiscal (ref date pdt_data)
public function boolean of_dados_impressora (ref long pl_sequencial, ref long pl_ecf)
public function boolean of_atualiza_data_fiscal ()
public function boolean of_carrega_dados_ecf (long pl_ecf)
public function boolean of_contador_credito_debito (ref long pl_contador)
public function boolean of_contador_cupom_fiscal (ref long pl_contador)
public function boolean of_contador_operacao_nao_fiscal (ref long pl_contador)
public function boolean of_contador_relatorio_gerencial (ref long pl_contador)
public function boolean of_registra_documento_ecf (string ps_documento, decimal pdc_valor)
public function boolean of_inicializa_relatorio_gerencial (string ps_relatorio, decimal pdc_valor)
public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor)
public function boolean of_inicializa_comprovante_tef_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor)
public function boolean of_inicializa_comprovante_tef (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor, string ps_cupom)
public function boolean of_registra_item_vendido (string ps_produto, long pl_qtde, decimal pdc_precounit, decimal pdc_precotot, string ps_descricao, decimal pdc_aliquota, string ps_complemento, string ps_tributacao_icms)
public function String of_desencripta (string ps_texto)
public function string of_encripta (string ps_texto)
public function boolean of_atualiza_venda_bruta ()
public function boolean of_numero_serie ()
public function boolean of_verifica_venda_bruta_diaria ()
public function boolean of_grande_total (ref decimal pdc_venda)
public function boolean of_cancela_item_anterior ()
public function boolean of_fecha_cupom (string ps_msg[], boolean pb_repete, string ps_indicadores[6, 2], string ps_vinculado)
public function boolean of_registra_documento_ecf (string ps_documento, string ps_totalizador, decimal pdc_valor)
public function boolean of_abertura_dia ()
public function boolean of_pergunta_impressora_offline ()
public function string of_gera_hash (string ps_arquivo)
public function boolean of_atualiza_cadastro_ecf ()
public function boolean of_codigo_barras (integer pl_tipo, string ps_codigo, string ps_tamanho)
public function boolean of_inicializa_comprovante_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor)
public function boolean of_pergunta_tentativa (boolean pvb_abrindo)
public function boolean of_texto_relatorio_gerencial (string ps_texto)
public function boolean of_inicializa_relatorio_gerencial (string ps_relatorio)
public function boolean of_inicializa_cupom (string ps_cpf_cgc)
public function boolean of_verifica_retorno_ecf (long pl_retorno, boolean pb_mostra_aviso)
public function long of_status_ecf ()
public function boolean of_cancela_documento_aberto (long pl_tipo)
public function boolean of_leitura_memoria_fiscal_reducao (long pl_reducao_inicial, long pl_reducao_final, boolean pb_arquivo, string ps_tipo)
public function boolean of_verifica_reducao_pendente ()
public function boolean of_totaliza_recebimento_nao_fiscal (string ps_pagamento, string ps_valor, string ps_texto)
public function boolean of_verifica_dlls ()
public function string of_centraliza_texto (string ps_texto)
public function boolean of_programa_aliquota (boolean pb_automatico, decimal pdc_aliquota, long pl_tipo, boolean pb_mostra_mensagem)
public function boolean of_cancela_item (long pl_item)
public function string of_normaliza_texto (string ps_texto)
public function boolean of_data_hora_ecf (ref datetime pdt_data)
public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final, string ps_arquivo)
public function boolean of_gera_arquivo_cotepe_mensal (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_dir_mfd, boolean pb_gera_mfd, ref boolean pb_mfd_gerado, string ps_inicio_mfd, string ps_fim_mfd)
public function boolean of_subtotal_cupom (ref string ps_subtotal)
public function boolean of_gera_arquivos_ecf (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_espelhos, long pl_tipo_geracao, string ps_dir_mfd, ref string ps_arquivo_gerado)
end prototypes

public function string of_indicador_aliquota (decimal pd_aliquota, string ps_tributacao_icms);String ls_Indicador

If pd_aliquota > 0 Then
	ls_indicador = gf_replace(String(pd_aliquota),',','',1)
	ls_indicador = String(Long(ls_indicador),'0000')
	ls_indicador = 'T' + ls_indicador
Else
	If ps_tributacao_icms = '06' Then
		ls_Indicador = "FF"
	Else
		ls_Indicador = "II"
	End If		
End If

//Choose Case pd_aliquota
//	Case 7    ; ls_Indicador = "01"
//	Case 12   ; ls_Indicador = "02"
//	Case 25   ; ls_Indicador = "03"		
//	Case 17   ; ls_Indicador = "04"
//	Case 18	  ; ls_Indicador = "05"
//	Case Else 
//		If ps_tributacao_icms = '06' Then
//			ls_Indicador = "FF"
//		Else
//			ls_Indicador = "II"
//		End If	
//End Choose

Return ls_Indicador
end function

public function boolean of_impressora_online ();If This.ivb_Modo_Teste Then Return True

Boolean lb_Sucesso

Long    ll_Retorno

Do While ll_Retorno <> 1
	
	ll_Retorno = rVerificarImpressoraLigada_ECF_Daruma()

	Choose Case ll_Retorno
		Case 1
			lb_Sucesso = True
		Case Else
			If of_pergunta_impressora_offline() Then Continue
			Exit
	End Choose
	
Loop

Return lb_Sucesso
end function

public function boolean of_fecha_recebimento_nao_fiscal ();Return True
end function

public function boolean of_registra_documento_ecf (string ps_documento);String ls_Nulo

Decimal ldc_Nulo

SetNull(ls_Nulo)
SetNull(ldc_Nulo)

Return of_Registra_Documento_ecf(ps_documento,ls_Nulo,ldc_Nulo)
end function

public function boolean of_grava_mapa_resumo (date pdh_data);Boolean lb_Sucesso

uo_mapa_resumo lvo_mapa_resumo
lvo_mapa_resumo = Create uo_mapa_resumo

lvo_mapa_resumo.dh_fiscal = pdh_data

If lvo_mapa_resumo.of_gravacao_mapa_resumo_ok() Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Mapa Resumo gravado com sucesso !")
	lb_Sucesso = True
End If

Destroy(lvo_mapa_resumo)

Return lb_Sucesso
end function

public function string of_formata_valor_pafecf (decimal pdc_valor, long pl_inteiro, long pl_decimal);String 	ls_Valor

ls_Valor = FillA('0', pl_inteiro + pl_decimal) + MidA( String(pdc_valor) , 1, LenA(String(pdc_valor)) -3 ) + RightA(String(pdc_valor),2)

ls_Valor = RightA( ls_Valor, pl_inteiro + pl_decimal )

Return ls_Valor
end function

public function boolean of_verifica_ultimo_mapa_resumo ();If This.ivb_ReducaoZ Then Return True

Datetime	ldt_venda
Datetime ldt_Movimento
Datetime ldt_Movimento_Relativo

Long     ll_filial
Long 		ll_ecf
Long 		ll_mapa

ll_filial = gvo_Parametro.cd_filial

ll_ecf	 = This.ECF

ldt_Movimento = PDV.of_dh_Movimentacao()
ldt_Movimento_Relativo = DateTime(RelativeDate(Date(ldt_Movimento),-5))

If Not This.of_Nr_Ecf(ref ll_ecf) Then Return False

select max(dh_movimentacao_caixa) Into :ldt_Venda
from nf_venda
where cd_filial 					= :ll_filial
  and dh_movimentacao_caixa	< :ldt_Movimento
  and dh_movimentacao_caixa	>=:ldt_Movimento_Relativo  
  and nr_ecf 						= :ll_ecf
  and de_especie = 'CF'
  and de_serie = 'ECF'  
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	gvo_aplicacao.of_grava_log("Erro ao verificar $$HEX1$$fa00$$ENDHEX$$ltima data de movimenta$$HEX2$$e700e300$$ENDHEX$$o, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_verifica_ultimo_mapa_resumo()."+Sqlca.SQLErrText)
	Sqlca.of_MsgDbError("Localiza $$HEX1$$fa00$$ENDHEX$$ltima venda - mapa resumo")
	Return False
End If

//If IsNull(ldt_Venda) Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data da venda nula.")
	
If Sqlca.Sqlcode = 100 or IsNull(ldt_Venda) Then Return True

SetNull(ll_Mapa)

Select count(mr.nr_mapa) Into :ll_Mapa
From mapa_resumo mr, mapa_resumo_ecf mre
Where mr.dh_emissao = :ldt_Venda
  and mr.nr_mapa    = mre.nr_mapa
  and mre.nr_ecf    = :ll_ecf
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	gvo_aplicacao.of_grava_log("Erro ao verificar $$HEX1$$fa00$$ENDHEX$$ltimo mapa resumo registrado, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_verifica_ultimo_mapa_resumo()."+Sqlca.SQLErrText)
	Sqlca.of_MsgDbError("Localiza mapa resumo")
	Return False
End If

If Not IsNull(ll_Mapa) and ll_Mapa <> 0 Then
	This.ivb_ReducaoZ = True
	Return True
End If

If This.of_Grava_Mapa_Resumo(Date(ldt_Venda)) Then
	uo_Menu_Fiscal lvo_menu
	lvo_Menu = Create uo_Menu_Fiscal
	If Trim(lvo_Menu.id_gera_blocoX) = 'S' Then
		lvo_menu.of_gera_blocox_reducao( Date(ldt_Venda), ll_ecf, PDV.ivl_seq_historico)		
		lvo_menu.of_envia_pendencias_blocox_matriz( 'RZ', ll_ecf, False, False)
	End If
	Destroy(lvo_Menu)	
	Return True
Else
	Return False	
End If
end function

public function boolean of_verifica_drivers ();Return This.of_Atualiza_Drivers()
end function

public function boolean of_cancela_cupom ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
String ls_Aviso

ll_Retorno = iCFCancelar_ECF_Daruma()

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, True)
end function

public function boolean of_permite_cancelamento_cupom ();Integer li_informacao
String ls_Informacao

If This.ivb_Modo_Teste Then Return True

//If Not This.of_Verifica_Flags_Fiscais() Then Return False -- DLL nova n$$HEX1$$e300$$ENDHEX$$o tem essa funcao, verificacao substituida pela funcao abaixo

Long ll_Retorno
Long ll_Tentativas = 0

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ls_Informacao = Space(3)
//	ll_Retorno = rTipoUltimoDocumentoInt_ECF_Daruma(ref ls_Informacao )
	ll_Retorno = rTipoUltimoDocumentoStr_ECF_Daruma(ref ls_Informacao )
	ll_Tentativas++
Loop

// Se o ultimo documento impresso for CF = 1, permite candelar cupom.
If Upper(Trim(ls_Informacao)) = 'CF' Then Return True

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o cancelamento do documento impresso.",Exclamation!)

Return False
end function

public function boolean of_mapa_resumo (ref s_ge039_mapa_resumo ps_mapa_resumo);If This.ivb_Modo_Teste Then Return True

Decimal{2} ldc_gt_inicial
Decimal{2} ldc_gt_final
Decimal{2} ldc_vl_aliquota

String  ls_Dados = Space(1164)
String  ls_DadosAliquotas = Space(150)
String  ls_Aliquota

Long ll_contador_aliquota = 129
Long ll_linha
Long ll_Retorno
Long ll_Tentativas = 0

If Not This.of_Nr_Ecf(ref This.ECF) Then Return False

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('140', Ref ls_Dados)
	ll_Tentativas++
Loop

If Not of_Verifica_Retorno_EcF(ll_Retorno, False) Then Return False

ll_Retorno = rLerAliquotas_ECF_Daruma(Ref ls_DadosAliquotas)

If Not This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then Return False

ps_mapa_resumo.ecf           				= This.ECF

ldc_gt_inicial                         = DEC(MidA(ls_Dados, 27, 18))/100
ldc_gt_final                           = DEC(MidA(ls_Dados, 9, 18))/100

ps_mapa_resumo.isento        				= DEC(MidA(ls_Dados,381,14))/100
ps_mapa_resumo.vl_nao_incidencia			= DEC(MidA(ls_Dados,409,14))/100
ps_mapa_resumo.vlst          				= DEC(MidA(ls_Dados,353,14))/100

ps_mapa_resumo.qt_cupom_cancelado 		= LONG(MidA(ls_Dados,985,04))
ps_mapa_resumo.qt_reinicio_z 		 		= LONG(MidA(ls_Dados,923,04))
ps_mapa_resumo.reducoes           		= LONG(MidA(ls_Dados,927,04))
ps_mapa_resumo.operacao           		= LONG(MidA(ls_Dados,935,06))

ps_mapa_resumo.grande_total  				= DEC(MidA(ls_Dados,9,18))/100

Do While Trim(ls_DadosAliquotas) > ''
	ll_linha += 1
	ls_Aliquota = Trim(MidA(ls_DadosAliquotas, 1, PosA(ls_DadosAliquotas,';') - 1))	
	If Trim(ls_Aliquota) = '' Then
		ls_Aliquota = Trim(ls_DadosAliquotas)
		ls_DadosAliquotas = ''
	Else
		If Upper(LeftA(ls_aliquota,1)) = "T" And LenA(ls_aliquota) = 5 Then
			ls_aliquota = RightA(ls_aliquota,4)			
			If Long(ls_Aliquota) = 0 Then //Neste caso j$$HEX1$$e100$$ENDHEX$$ passou da ultima aliquota v$$HEX1$$e100$$ENDHEX$$lida cadastrada
				ls_DadosAliquotas = ''
				Continue
			End If
			ls_DadosAliquotas = Trim(MidA(ls_DadosAliquotas,PosA(ls_DadosAliquotas,';') + 1))		
		Else
			ls_DadosAliquotas = Trim(MidA(ls_DadosAliquotas,PosA(ls_DadosAliquotas,';') + 1))					
			ll_contador_aliquota += 14							
			Continue
		End If		
	End If	
	ldc_vl_aliquota = DEC(MidA(ls_Dados,ll_contador_aliquota,14))/100
	ps_mapa_resumo.str_aliquota[ll_linha].aliquota	 = Long(Dec(ls_Aliquota) / 100)
	ps_mapa_resumo.str_aliquota[ll_linha].valor		 = ldc_vl_aliquota	
	ll_contador_aliquota += 14	
Loop

//ps_mapa_resumo.icm07         				= DEC(MidA(ls_Dados,129,14))/100
//ps_mapa_resumo.icm12         				= DEC(MidA(ls_Dados,143,14))/100
//ps_mapa_resumo.icm25         				= DEC(MidA(ls_Dados,157,14))/100
//ps_mapa_resumo.icm17         				= DEC(MidA(ls_Dados,171,14))/100
//ps_mapa_resumo.icm18         				= DEC(MidA(ls_Dados,185,14))/100

ps_mapa_resumo.vl_isento_iss 				= DEC(MidA(ls_Dados,465,14))/100 
ps_mapa_resumo.vl_nao_incidencia_iss	= DEC(MidA(ls_Dados,493,14))/100
ps_mapa_resumo.vl_st_iss 					= DEC(MidA(ls_Dados,437,14))/100

ps_mapa_resumo.descontos     				= DEC(MidA(ls_Dados,45,14))/100
ps_mapa_resumo.vl_desconto_iss			= DEC(MidA(ls_Dados,59,14))/100
ps_mapa_resumo.vl_acrescimo				= DEC(MidA(ls_Dados,101,14))/100
ps_mapa_resumo.vl_acrescimo_iss			= DEC(MidA(ls_Dados,115,14))/100
ps_mapa_resumo.cancelamentos 				= DEC(MidA(ls_Dados,73,14))/100
ps_mapa_resumo.vl_cancelamento_iss		= DEC(MidA(ls_Dados,87,14))/100

ps_mapa_resumo.liquido       		      = ( ldc_gt_final - ldc_gt_inicial ) - ( ps_mapa_resumo.cancelamentos + ps_mapa_resumo.descontos )

Return True
end function

public function boolean of_cancela_recebimento_nao_fiscal ();If This.ivb_Modo_Teste Then Return True

ivb_showerror = False

Long ll_Retorno
Long ll_gnf

Boolean lb_Sucesso = False

DateTime ldh_Emissao
Date ldt_Emissao

Open(w_Janela_Aguarde)

w_Janela_Aguarde.Wf_Mensagem("CANCELANDO CUPOM N$$HEX1$$c300$$ENDHEX$$O FISCAL")

	
If Not of_Data_Ultimo_Documento(Ref ldh_Emissao) Then Return False

ldt_Emissao = Date(ldh_Emissao)

If Not of_Contador_Operacao_Nao_Fiscal(Ref ll_gnf) Then Return False

lb_Sucesso = of_Cancela_Cupom()

If lb_Sucesso Then
	Update documento_ecf
	Set id_estorno = 'S'
	Where dh_movimento = :ldh_Emissao
	  and nr_ecf       = :This.ECF
	  and nr_gnf       = :ll_gnf
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_RollBack()
		Sqlca.of_MsgDbError('Estorno de recebimento n$$HEX1$$e300$$ENDHEX$$o fiscal')
		gvo_aplicacao.of_grava_log("Erro no estorno de recebimento n$$HEX1$$e300$$ENDHEX$$o fiscal, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_cancela_recebimento_nao_fiscal()."+SQLCA.SQLErrText)	
	Else
		Sqlca.of_Commit()
	End If	
End If
					
If IsValid(w_Janela_Aguarde) Then Close(w_Janela_Aguarde)

SetPointer(HourGlass!)

Return lb_Sucesso
end function

public function boolean of_abre_gaveta ();Return of_Verifica_Retorno_Ecf(eAbrirGaveta_ECF_Daruma(),False)

Return True
end function

public function boolean of_data_ultimo_documento (ref datetime pd_data);If This.ivb_Modo_Teste Then Return True

String ls_DataMovimento

Long   ll_Retorno
Long ll_Tentativas = 0

ls_DataMovimento = Space(14)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('72', Ref ls_DataMovimento)
	ll_Tentativas++
Loop

If Not This.of_Verifica_Retorno_ECF(ll_Retorno,False) Then Return False

pd_data = DateTime(Date(MidA(ls_DataMovimento,1,2)+"/"+MidA(ls_DataMovimento,3,2)+"/"+MidA(ls_DataMovimento,5,4)), &
			 Time(MidA(ls_DataMovimento,9,2)+":"+MidA(ls_DataMovimento,11,2)+":"+MidA(ls_DataMovimento,13,2)))

Return True
end function

public function boolean of_atualiza_drivers ();String ls_Porta
String ps_Baixar[]
String ps_Validar[]
String ls_Chave
String ls_Chave2
String ls_log

Boolean lb_Sucesso = False

If IsValid(PDV) Then
	If PDV.ivb_Atualizou_Registro Then Return True
End If

//ls_Chave = "HKEY_LOCAL_MACHINE\SOFTWARE\DARUMA\ECF"
// ****DLL NOVA****
ls_Chave		= "HKEY_LOCAL_MACHINE\SOFTWARE\DarumaFramework\ECF"
ls_Chave2	= "HKEY_LOCAL_MACHINE\SOFTWARE\DarumaFramework"

ps_Validar = {"DarumaFrameWork.dlll", "LeituraMFDBin.dll", "lebin.dll"}
ps_Baixar  = {'DarumaFrameWork.zip'}

ls_Porta = Trim(ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF", "Porta",""))
	
If ls_Porta = "" Or IsNull(ls_Porta) Then
	ls_Porta = "DEFAULT"
Else
	ls_Porta = "COM" + ls_Porta
End If

Select vl_parametro
  Into :ivs_MD5_CL
  From parametro_loja
 Where cd_parametro = 'ID_AUTENTICACAO_PAFECF_CL'
 Using SqlCa;
 
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		Return False
End Choose

ls_log = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF" , "Log" , "")
If UPPER(ls_log) = "SIM" Then
	ls_log = "1"
Else
	ls_log = "0"
End If

ivs_MD5_CL = 'MD5: ' + ivs_MD5_CL

//If RegistrySet(ls_Chave, "StatusFuncao", RegString!, '1') <> -1 Then
	If RegistrySet(ls_Chave, "ReceberInfoExtendida", RegString!, '1') <> -1 Then		
		If RegistrySet(ls_Chave, "MensagemApl1", RegString!, ivs_MD5_CL) <> -1 Then
			If RegistrySet(ls_Chave, "MensagemApl2", RegString!, '') <> -1 Then
//				If RegistrySet(ls_Chave, "Vende1Linha", RegString!, '1') <> -1 Then
					If RegistrySet(ls_Chave, "NaoAvisarPoucoPapel", RegString!, '0') <> -1 Then
						If RegistrySet(ls_Chave, "ReducaoZAutomatica", RegString!, '0') <> -1 Then
							If RegistrySet(ls_Chave, "PortaSerial", RegString!, ls_Porta) <> -1 Then
								If RegistrySet(ls_Chave2, "ThreadAoIniciar", RegString!, '0') <> -1 Then
									If RegistrySet(ls_Chave, "ControleAutomatico", RegString!, '1') <> -1 Then	
//										If RegistrySet(ls_Chave, "MFDTamMinDescProd", RegString!, '00') <> -1 Then
											If RegistrySet(ls_Chave, "SinalSonoroIniciar", RegString!, '1') <> -1 Then
												If RegistrySet(ls_Chave, "Auditoria", RegString!, ls_log) <> -1 Then
													If RegistrySet(ls_Chave, "ArredondarTruncar", RegString!, "T") <> -1 Then												
		//												If RegistrySet(ls_Chave, "Produto", RegString!, 'FS700') <> -1 Then
															If RegistrySet(ls_Chave2, "LogTamMaxMB", RegString!, '5') <> -1 Then
																If RegistrySet(ls_Chave2, "Produto", RegString!, 'ECF') <> -1 Then																									
																	If of_verifica_dlls() Then
																		lb_Sucesso = True
																	End If
																End If
															End If
		//												End If
													End If
												End If
											End If
										End If
//									End If
								End If
							End If
						End If
					End If
//				End If
			End If
		End If
	End If
//End If

If lb_Sucesso Then
	regAlterarValor_Daruma( 'LogTamMaxMB', '5' )
	regAlterarValor_Daruma( 'ThreadAoIniciar', '0' )
	regAlterarValor_Daruma( 'Produto', 'ECF' )	
	regAlterarValor_Daruma( 'ECF\ReceberInfoExtendida', '1' )
	regAlterarValor_Daruma( 'ECF\MensagemApl1', ivs_MD5_CL )
	regAlterarValor_Daruma( 'ECF\NaoAvisarPoucoPapel', '0' )
	regAlterarValor_Daruma( 'ECF\PortaSerial', ls_Porta )
	regAlterarValor_Daruma( 'ECF\ControleAutomatico', '1' )	
	regAlterarValor_Daruma( 'ECF\Auditoria', ls_Log )	
	regAlterarValor_Daruma( 'ECF\ArredondarTruncar', 'T' )	
	//regAlterarValor_Daruma( 'ECF\TamanhoMinimoDescricao', '00' )	 Quando for imprimir CEST e NCM descomentar
	If IsValid(PDV) Then	
		PDV.ivb_Atualizou_Registro = True
	End If
	Return True
Else
	gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar as configura$$HEX2$$e700f500$$ENDHEX$$es da impressora DARUMA no registro." + &
								 "  Chave: [HKEY_LOCAL_MACHINE\SOFTWARE\DarumaFramework\ECF].")
	MessageBox("Impressora Fiscal", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar as configura$$HEX2$$e700f500$$ENDHEX$$es da impressora DARUMA no registro.~r~r" + &
								 "      Chave: [HKEY_LOCAL_MACHINE\SOFTWARE\DarumaFramework\ECF]", StopSign!)
	Return False	
End If


end function

public function boolean of_imprime_relatorio_gerencial (string ps_texto[]);If This.ivb_Modo_Teste Then Return True

Long   ll_Retorno
Long   ll_Linha
Long	 ll_Loop
Long	 ll_Texto = 1

String ls_Texto
String ls_Texto2, ls_Texto3
String ls_Log = ''
String ls_Aux

gvo_aplicacao.of_grava_log('Iniciada impress$$HEX1$$e300$$ENDHEX$$o relat$$HEX1$$f300$$ENDHEX$$rio gerencial.')

For ll_Linha = 1 To UpperBound(ps_texto)
	If Not LenA(ps_texto[ll_Linha])> 0 Then Continue
	//ls_texto = Char(15) + Left(ps_texto[ll_Linha],57) + Char(18) + Char(13) + Char(10)
	
	ls_texto = ps_texto[ll_Linha]
	
	If LenA(ls_texto) > 610 Then		
		ls_texto2 = ls_texto
		Do While LenA(Trim(ls_Texto2)) > 0
			ls_texto3 = LeftA(ls_texto2,610)
			ls_Log += 'Parte '+String(ll_Texto)+': [<c>'+ls_texto3+'</c>]~r'
			
			ll_Retorno = iRGImprimirTexto_ECF_Daruma("<c>"+ls_texto3+"</c>")	
			
			If ll_Retorno = -99 Then
				ll_Retorno = iRGImprimirTexto_ECF_Daruma("<c>"+This.Of_Normaliza_Texto(ls_texto3)+"</c>")
			End If
		
			If Not This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then 
				gvo_aplicacao.of_grava_log('Falha ao imprimir relat$$HEX1$$f300$$ENDHEX$$rio gerencial ['+ls_texto3+'].~rTexto '+ls_Log+'.')
				Return False			
			End If
			
			ls_texto2 = MidA(ls_texto2, 611)
			ll_Texto ++
		Loop
	Else
		ll_Retorno = iRGImprimirTexto_ECF_Daruma("<c>"+ls_texto+"</c>")	
		
		If ll_Retorno = -99 Then
			ll_Retorno = iRGImprimirTexto_ECF_Daruma("<c>"+This.Of_Normaliza_Texto(ls_texto)+"</c>")
		End If
		
		If Not This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
			gvo_aplicacao.of_grava_log('Falha ao imprimir relat$$HEX1$$f300$$ENDHEX$$rio gerencial [<c>'+ls_texto+'</c>].')
			Return False		
		End If
	End If	
		
Next

gvo_aplicacao.of_grava_log('Finalizada impress$$HEX1$$e300$$ENDHEX$$o relat$$HEX1$$f300$$ENDHEX$$rio gerencial.')

Return True
end function

public function boolean of_reducaoz ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Ecf
Long ll_dif

String ls_data
String ls_hora
String ls_Arquivo

Date ldt_DataFiscal
Date ldt_ReducaoZ

Boolean lb_sucesso
Boolean lb_blocox

ls_data = String(Day(Today()),'00')+"/"+String(Month(Today()),'00')+"/"+RightA(String(Year(Today()),'0000'),2)
ls_hora = String(Now(),"hh:mm:ss")

uo_Menu_Fiscal lvo_Menu

If Not of_Nr_Ecf(ref ll_Ecf) Then Return False

If Not This.of_Marca_Modelo_Tipo()		Then Return False

If Not This.of_Percentual_Livre_MFD()	Then Return False

If Not of_DataFiscal(Ref ldt_DataFiscal) Then Return False

If Not of_Data_Ultima_ReducaoZ(Ref ldt_ReducaoZ) Then	Return False

If ldt_DataFiscal = Date("2000/01/01") Then
	
	//This.of_Abertura_Dia() dll nova n$$HEX1$$e300$$ENDHEX$$o necessita.
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","ECF est$$HEX1$$e100$$ENDHEX$$ sem movimenta$$HEX2$$e700e300$$ENDHEX$$o desde a $$HEX1$$fa00$$ENDHEX$$ltima Redu$$HEX2$$e700e300$$ENDHEX$$o Z.~r~r" + &
						 		"N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio efetu$$HEX1$$e100$$ENDHEX$$-la.~r~r"+&
						 		"Data $$HEX1$$da00$$ENDHEX$$ltima Redu$$HEX2$$e700e300$$ENDHEX$$o Z " + String(ldt_ReducaoZ),Exclamation!)
	
	Return True
	
Else
	
	If Not of_verifica_cupons_pendentes() Then Return False
	
	ls_data = String(Today(), "ddmmyy")
	ls_hora = String(Now(),"hhmmss")	
	
	If This.of_Verifica_Retorno_ECF(iReducaoZ_ECF_Daruma(ls_data, ls_hora), False) Then
		If Not of_Data_Ultima_ReducaoZ(Ref ldt_ReducaoZ) Then	Return False			
		
		If Not pdv.of_verifica_aliquotas() Then //Busca as aliquotas no banco e se necess$$HEX1$$e100$$ENDHEX$$rio inclui na ECF.
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Problemas na verifica$$HEX2$$e700e300$$ENDHEX$$o de aliquotas da ECF.")
		End If		

		If ldt_ReducaoZ <> Today() Then		
			//This.of_Abertura_Dia()
		End If
	Else
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Erro no retorno: " + String(ll_Retorno) + " ECF: " + String(This.ECF) + " ao gravar Mapa Resumo.")
	End If
	
	This.of_Data_Hora_Usuario_Software_Basico()

	This.of_Verifica_Versao_Software_Basico()
		
End If

If of_Grava_Mapa_Resumo(ldt_DataFiscal) Then
	lb_sucesso = True
Else
	lb_sucesso = False
End if

//Envia arquivo BlocoX
If lb_sucesso Then
	lvo_Menu = Create uo_Menu_Fiscal
	If Trim(lvo_Menu.id_envia_blocoX) = 'L' Then 
		lvo_Menu.of_envia_pendencias_blocox('RZ', PDV.ecf, True)
	End If
	If Trim(lvo_Menu.id_gera_blocoX) = 'S' And Date(ldt_DataFiscal) >= lvo_menu.dt_inicio_blocox Then
		lvo_menu.of_gera_blocox_reducao( ldt_DataFiscal, PDV.ecf, PDV.ivl_seq_historico)
		lvo_menu.of_envia_pendencias_blocox_matriz( 'RZ', PDV.ecf, False, False)		
		//lvo_menu.of_verifica_pendencias_blocox('RZ', PDV.ecf, True, False, Ref lb_blocox)
	End If
	Destroy(lvo_Menu)	
End If

PDV.of_gera_espelho_mfd_mensal(ll_ecf, ldt_DataFiscal)

PDV.of_gera_cotepe_mensal(ll_ECF, ldt_DataFiscal)

If lb_sucesso Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Mapa Resumo gravado com sucesso !")

//If Not of_Gera_Movimento_pafecf(Ref ls_Arquivo,This.ecf, ldt_ReducaoZ,ldt_ReducaoZ) Then Return False
//
//If Not of_Assinatura_Digital(ls_Arquivo) Then Return False

Return True
end function

public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final);
If This.ivb_Modo_Teste Then Return True

Boolean lb_Retorno

String ls_Versao
String ls_File = 'C:\Sistemas\CL\Arquivos\PAF-ECF\leitura-memoria-fita-detalhe.txt'
String ls_caminho = 'C:\Sistemas\CL\Arquivos\PAF-ECF\'
String ls_Tipo
String ls_Nome_Arquivo
String ls_Inicio
String ls_Final

Date ldh_Data

FileDelete(ls_File)
FileDelete(ls_caminho+'Espelho_MFD.txt')

regAlterarValor_Daruma( 'START\LocalArquivos', ls_caminho)
regAlterarValor_Daruma( 'START\LocalArquivosRelatorios', ls_caminho)

If ps_Tipo = "1" Then
	ldh_Data = Date(ps_Inicio)
	ls_Inicio = String(ldh_Data,'DDMMYY')
	ldh_Data = Date(ps_Final)
	ls_Final = String(ldh_Data,'DDMMYY')
	
	lb_Retorno = This.of_Verifica_Retorno_ECF(rGerarEspelhoMFD_ECF_Daruma(ps_Tipo, ls_Inicio, ls_Final), False)	
Else
	
	lb_Retorno = This.of_Verifica_Retorno_ECF(rGerarEspelhoMFD_ECF_Daruma(ps_Tipo, RightA("000000" + ps_inicio, 6), RightA("000000" + ps_final, 6)), False)	
	
End If

If lb_Retorno Then

	dc_uo_api lvo_Api
	lvo_api = Create dc_uo_api
			
	If Not lvo_Api.of_Move_File(ls_caminho+'Espelho_MFD.txt',ls_File,True) Then
		gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel mover arquivo espelho MFD para "+ls_File+", fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_leitura_memoria_fita_detalhe().")			
		lb_Retorno = False
	End If	
	
	Destroy(lvo_Api)

End If	

Return lb_Retorno

end function

public function boolean of_sangria_caixa (decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Return This.of_Verifica_Retorno_ECF(iSangria_ECF_Daruma(String(pdc_valor,"##0.00"), ""), False)
end function

public function boolean of_suprimento_caixa (decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

DateTime ldt_data
This.of_data_hora_ecf(Ref ldt_Data)

If This.of_Verifica_Retorno_ECF(iSuprimento_ECF_Daruma(String(pdc_valor,"##0.00"), ""), False) Then
	PDV.of_atualiza_primeira_venda_ecf(This.ECF, ldt_data, True)	
	Return True
End If
end function

public function boolean of_configuracoes ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
//Na nova dll N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ usado
//ll_Retorno = Daruma_FI_EspacoEntreLinhas(002)

//Return This.of_Verifica_Retorno_Ecf(ll_Retorno)
Return True
end function

public function boolean of_cancela_ultimo_cupom (boolean pb_confirmar);If This.ivb_Modo_Teste Then Return True

String ls_Responsavel

SetNull(ls_Responsavel)

Return PDV.of_Cancela_Ultimo_Cupom(pb_confirmar, ls_Responsavel)

end function

public function boolean of_cancela_ultimo_cupom (boolean pb_confirmar, string ps_responsavel);If This.ivb_Modo_Teste Then Return True

String ls_Responsavel

SetNull(ls_Responsavel)

Return This.of_Cancela_Cupom()
end function

public function boolean of_verifica_cupons_pendentes ();If This.ivb_Modo_Teste Then Return True

Boolean lb_Sucesso

Long ll_Retorno
Integer li_Status

String ls_Status
String ls_Status_Descricao

ls_Status					= Space(2)

If Not This.of_Verifica_Retorno_Ecf(rCFVerificarStatus_ECF_Daruma(Ref ls_Status, Ref li_Status), False) Then Return False

If Long(li_Status) <> 0 Then
	
	PDV.Of_msg_Cupom_Aberto()
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("CANCELAMENTO_CUPOM_FISCAL", PDV.ivs_Matricula_Cancelamento_Venda) Then Return False

	If Not of_cancela_ultimo_cupom(False) Then Return False

	Return True
	
End If		

Return True
end function

public function boolean of_verifica_flags_fiscais ();Integer li_Informacao

Long ll_Retorno
Long ll_Tentativas = 0

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
//	ll_Retorno = Daruma_FI_FlagsFiscais(ref li_Informacao )
	ll_Tentativas++
Loop

ivs_Status = String(li_Informacao)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_verifica_forma_pagamento (ref string ps_formapagto[]);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Pos = 0
Long ll_Ind
Long ll_Inicio

String ls_FormasPagto
String ls_Forma

ls_FormasPagto = Space(1027)

//ll_Retorno = Daruma_FI_VerificaFormasPagamentoEx(Ref ls_FormasPagto) //na DLL nova n$$HEX1$$e300$$ENDHEX$$o precisa usar essa funcao

If ll_Retorno <> 1 Or Not This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then Return False

ls_Forma = Trim(MidA(ls_FormasPagto,ll_Pos,16))

Do While True
				
	ll_Inicio = ll_Pos +1
	
	If ls_Forma <> '' and ls_Forma <> 'Valor Recebido' and ls_Forma <> 'Troco' Then
	
		ll_Ind++
		ps_formaPagto[ll_Ind] = ls_Forma
		
	End If
	
	ll_Pos = PosA(ls_FormasPagto, ',', ll_Inicio)
	
	If ll_Pos = 0 Then Exit
	
	ls_Forma = Trim(MidA(ls_FormasPagto, ll_Pos+1, 16))
	
Loop

Return True
end function

public function boolean of_conecta_impressora ();//ivs_grava_log = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF" , "Log" , "")

//If ivs_grava_log = "SIM" Then
//	This.Daruma_Registry_Log("1")	
//Else
//	This.Daruma_Registry_Log("0")
//End If

Return True
end function

public function boolean of_gera_arquivo_cotepe1704 (string ps_tipo, string ps_inicio, string ps_final);Boolean lvb_Sucesso
String ls_Arquivo

regAlterarValor_Daruma('Path', 'C:\')
regAlterarValor_Daruma('Beep', '1')  

If ps_Tipo = '1' Then
	ls_Arquivo = 'ATO_MFD_DATA.TXT'
	lvb_Sucesso = This.of_Verifica_Retorno_ECF(rGerarRelatorio_ECF_Daruma('MFD','DATAM', String(Date(ps_inicio), "ddmmyyyy"), String(Date(ps_final), "ddmmyyyy")), False)
Else
	ls_Arquivo = 'ATO_MFD_COO.TXT'	
	lvb_Sucesso = This.of_Verifica_Retorno_ECF(rGerarRelatorio_ECF_Daruma('MFD','COO',Right("000000" + ps_inicio, 6), Right("000000" + ps_final, 6)), False)
End If

If lvb_Sucesso Then	

	dc_uo_api lvo_Api
	lvo_api = Create dc_uo_api
			
	If Not lvo_Api.of_Move_File('c:\' + ls_Arquivo, "C:\Sistemas\CL\Arquivos\PAF-ECF\cotepe1704-" + ps_Tipo + ".txt",True) Then
		lvb_Sucesso = False
	End If	
	
	Destroy(lvo_Api)

End If	

Return lvb_Sucesso 
end function

public function boolean of_data_ultima_reducaoz (ref date pdt_data);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

String	ls_Data, &
		ls_Retorno_Reducao	 

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	ls_Retorno_Reducao = Space(1209)
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarDadosReducaoZ_ECF_Daruma(Ref ls_Retorno_Reducao)
	ll_Tentativas++
Loop		 

ls_Data = MidA(ls_Retorno_Reducao,1,8)
	
ls_Data = MidA(ls_Data,1,2)+"/"+MidA(ls_Data,3,2)+"/"+MidA(ls_Data,5,4)
	
pdt_data = Date(ls_Data)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_fecha_comprovante_nao_fiscal ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = iCNFEncerrarPadrao_ECF_Daruma()
	ll_Tentativas++
Loop

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, True)
end function

public function boolean of_fecha_comprovante_tef ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = iCCDFechar_ECF_Daruma()
	ll_Tentativas++
Loop

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, True)
end function

public function boolean of_fecha_relatorio_gerencial ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

If This.ivb_Cod_Barras Then
	This.of_codigo_barras(0,This.ivs_Cod_Barras,'1')
End If

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = iRGFechar_ECF_Daruma()
	ll_Tentativas++
Loop

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, True)
end function

public function boolean of_desconto_cupom (string ps_texto, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

String ls_valor

Long ll_Retry
Long ll_Retorno
Long ll_Tentativas = 0

ls_valor = String(pdc_valor)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = iCFTotalizarCupom_ECF_Daruma("D$", ls_Valor)
	ll_Tentativas++
Loop

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_leiturax ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0
DateTime ldt_data

This.of_data_hora_ecf(Ref ldt_Data)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = iLeituraX_ECF_Daruma()
	ll_Tentativas++
Loop

If This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
	PDV.of_atualiza_primeira_venda_ecf(This.ECF, ldt_data, True)	
	Return True
End If
end function

public function boolean of_leiturax (boolean pb_arquivo);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

If pb_arquivo Then		
	FileDelete('c:\retorno.txt')
	ll_Retorno = rLeituraX_ECF_Daruma()		
Else	
	ll_Retorno = iLeituraX_ECF_Daruma()	
End If

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_valor_pago_ultimo_cupom (decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

String ls_Valor

Return True  //Na nova dll n$$HEX1$$e300$$ENDHEX$$o tem fun$$HEX2$$e700e300$$ENDHEX$$o que retorna essa informa$$HEX2$$e700e300$$ENDHEX$$o.

//ls_Valor = Space(14)

//ll_Retorno =$$HEX1$$a000$$ENDHEX$$Daruma_FI_ValorPagoUltimoCupom(ref ls_Valor)

//If ll_Retorno = 1 Then
//	pdc_valor = Dec(ls_Valor) / 100
//Else
//	pdc_valor = 000.00
//End If

//ll_Retorno = 1
//
//Return This.of_Verifica_Retorno_Ecf(ll_Retorno)
			
end function

public function boolean of_venda_bruta (ref decimal pdc_venda);If This.ivb_Modo_Teste Then Return True

String ls_Valor
Long   ll_Retorno
Long ll_Tentativas = 0

ls_Valor = Space(18)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarVendaBruta_ECF_Daruma(Ref ls_Valor)
	ll_Tentativas++
Loop

If ll_Retorno = 1 Then
	pdc_venda = Dec(ls_Valor) / 100
Else
	pdc_venda = 000.00
End If

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_texto_nao_fiscal_tef (string ps_texto);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

ps_texto = CharA(15) + ps_texto + CharA(18) + CharA(13) + CharA(10)
	
Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
ll_Retorno = iCCDImprimirTexto_ECF_Daruma(ps_texto)
	ll_Tentativas++
Loop
	
Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_desconto_item (long pl_item, decimal pdc_desonto, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

String ls_Tipo_Desc
String ls_Val_Desc
String ls_Item

ls_Item = String(pl_Item)
ls_Tipo_Desc = String(pl_item)
ls_Val_Desc = String(pdc_valor)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = iCFLancarDescontoItem_ECF_Daruma(ls_Tipo_Desc, "D$", ls_Val_Desc)
	ll_Tentativas++
Loop

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_recebimento_nao_fiscal (string ps_tipo, string ps_valor);If This.ivb_Modo_Teste Then Return True

Long    ll_Retorno
Long ll_Tentativas = 0

Return True  // NA dll NOVA n$$HEX1$$e300$$ENDHEX$$o tem fun$$HEX2$$e700e300$$ENDHEX$$o igual a essa, que abre/totaliza/fecha o comprovante num unico comando.

//Do While ll_Tentativas < 3 And ll_Retorno <> 1
//	If ll_Tentativas > 0 Then gf_Delay(2)
////	ll_Retorno = Daruma_FI_RecebimentoNaoFiscal(ps_tipo,ps_valor,"")
//	ll_Tentativas++
//Loop
//
//Return This.of_Verifica_Retorno_Ecf(ll_Retorno)
end function

public function boolean of_efetua_recebimento_nao_fiscal (string ps_tipo, string ps_valor, string ps_forma_pgmto);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Linha
Long ll_Tentativas = 0

String ls_Tipo

ls_Tipo = String(Long(ps_Tipo) + 2, "00")

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = iCNFReceber_ECF_Daruma(ls_Tipo, ps_Valor, 'A$', '0.00')
	ll_Tentativas++
Loop

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_programa_recebimento_nao_fiscal (long pl_totalizador, string ps_descricao);Long ll_Retorno

Return True

//ll_Retorno = confCadastrar_ECF_Daruma("TNF","RECEBIMENTO"," ")
//ll_Retorno = confCadastrar_ECF_Daruma("TNF","RECARGA"," ")
//ll_Retorno = confCadastrar_ECF_Daruma("TNF","PAGTO. CONTA"," ")
//
//ll_Retorno = confCadastrar_ECF_Daruma("TNF",ps_Descricao," ")

//Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_inicializa_recebimento_nao_fiscal ();If This.ivb_Modo_Teste Then Return True

Long	ll_Sequencia,&
     	ll_Retorno,&
     	ll_Ecf

String ls_Retorno
String ls_Status
ls_Retorno = Space(2)

ivb_showerror = FALSE

ls_status = Space(1)

ll_Retorno = rRetornarInformacao_ECF_Daruma('57', ref ls_Status) //Verifica se tem CF ou CNF aberto.

If Not This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then Return False

If Long(ls_Status) <> 0 Then
	If Long(ls_Status) >= 1 And Long(ls_Status) <= 4 Then //CF Aberto
		IF Not of_cancela_ultimo_cupom(False) Then Return False	
	End If
	
	If Long(ls_Status) >= 5 And Long(ls_Status) <= 8 Then //CNF aberto		
		If Not of_cancela_documento_aberto(79) Then Return False		
	End If			
End If

ll_Retorno = iCNFAbrirPadrao_ECF_Daruma()
If This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then Return True

If Not This.of_nr_cupom(Ref ll_Sequencia) Then Return False
//If Not This.of_nr_ecf(Ref ll_Ecf) Then Return False
ll_ECF = This.ECF
			
If PDV.Of_Cupom_Gravado(ll_Ecf, ll_Sequencia) Then
	PDV.Of_msg_Cupom_Aberto_Gravado()
Else

	PDV.Of_msg_Cupom_Aberto()
	
	IF Not of_cancela_ultimo_cupom(False) Then Return False

	If of_inicializa_cupom("") Then Return True

End If				
	

end function

public function boolean of_programa_formas_pagamento (string ps_forma);long ll_Retorno

//confCadastrar_ECF_Daruma("FPGTO","CHEQUE"," ")
//confCadastrar_ECF_Daruma("FPGTO","CHEQUE-PRE"," ")
//confCadastrar_ECF_Daruma("FPGTO","CARTAO CREDITO"," ")
//confCadastrar_ECF_Daruma("FPGTO","CARTAO DEBITO"," ")
//confCadastrar_ECF_Daruma("FPGTO","CONVENIO"," ")
//confCadastrar_ECF_Daruma("FPGTO","CREDIARIO"," ")
//confCadastrar_ECF_Daruma("FPGTO","CONTA CORRENTE"," ")
//confCadastrar_ECF_Daruma("FPGTO","CLUBE"," ")
//confCadastrar_ECF_Daruma("FPGTO","PBM"," ")

Return True

//ll_Retorno = confCadastrar_ECF_Daruma("FPGTO",Upper(ps_Forma)," ")

//Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_percentual_livre_mfd ();If This.ivb_Modo_Teste Then Return True

String ls_MemoriaLivre

Long ll_Retorno
Long ll_Tentativas = 0

Boolean lb_Sucesso = False

ls_MemoriaLivre = Space ( 5 )

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('103', Ref ls_MemoriaLivre)
	ll_Tentativas++
Loop

If This.of_Verifica_Retorno_ECF(ll_Retorno, False) Then

	This.pc_Livre_MFD = Dec(ls_MemoriaLivre) / 100
	
	Update impressora_fiscal
		Set pc_livre_mfd = :This.pc_Livre_MFD
	 Where nr_ecf = :This.Ecf
	 Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_RollBack()
		Sqlca.of_MsgDbError('Atualiza$$HEX2$$e700e300$$ENDHEX$$o do percentual de mem$$HEX1$$f300$$ENDHEX$$ria livre')
		gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar do percentual de mem$$HEX1$$f300$$ENDHEX$$ria livre, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_percentual_livre_mfd()."+Sqlca.SQLErrText)			
		lb_Sucesso = False
	Else			
		Sqlca.of_Commit()
		lb_Sucesso = True
	End If
	
End If
			
Return lb_Sucesso
end function

public function boolean of_data_hora_usuario_software_basico ();If This.ivb_Modo_Teste Then Return True

Boolean lb_Sucesso = False

String ls_DataSWBasico
String ls_MFAdicional
String ls_Fabricacao

Long ll_Retorno = 0 
Long ll_Tentativas = 0

DateTime ldh_Ultima_Venda

ls_DataSWBasico = Space( 14 )
ls_Fabricacao = Space( 21 )

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('85', ref ls_DataSWBasico)
	ll_Tentativas++
Loop

ll_Tentativas = 0

If ll_Retorno = 1 Then
	ll_Retorno = 0
	Do While ll_Tentativas < 3 And ll_Retorno <> 1
		If ll_Tentativas > 0 Then gf_Delay(2)
		//Usa a informacao 78 (n$$HEX1$$ba00$$ENDHEX$$ fabricacao) porque na Daruma se ao final da informacao existir a letra A indica MF Adicional. 
		ll_Retorno = rRetornarInformacao_ECF_Daruma('78', ref ls_Fabricacao)
		ll_Tentativas++
	Loop
End If

If This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
	ls_MFAdicional = RightA(ls_Fabricacao,1)
	If Trim(ls_MFAdicional) = '' Then	
		ls_MFAdicional = 'N'
	Else
		ls_MFAdicional = 'S'	
	End If	
	
	This.id_MFAdicional = ls_MFAdicional
	This.dh_SWBasico    = DateTime(Date(LeftA(ls_DataSWBasico,10)),Time(RightA(ls_DataSWBasico,08)))
	
	//Data hora ultima venda da ECF
	Select max(dh_emissao) Into :ldh_Ultima_Venda
	From nf_venda
	Where nr_ecf = :This.Ecf 
	  and	dh_movimentacao_caixa >= cast( getdate() as date) -2
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_MsgDbError('Data $$HEX1$$fa00$$ENDHEX$$ltima venda ECF no sistema.')
		gvo_aplicacao.of_grava_log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da data $$HEX1$$fa00$$ENDHEX$$ltima venda ECF no sistema, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_data_hora_usuario_software_basico()."+SQLCA.SQLErrText)	
	End If			

	If IsNull(ldh_Ultima_Venda) Then
		Update impressora_fiscal
		Set id_mfadicional = :This.id_MFAdicional,
			 dh_swbasico    = :This.dh_SWBasico
		Where nr_ecf = :This.Ecf
		Using Sqlca;
	Else
		Update impressora_fiscal
		Set id_mfadicional = :This.id_MFAdicional,
			 dh_swbasico    = :This.dh_SWBasico,
	 		 dh_ultima_venda = :ldh_Ultima_Venda 
		Where nr_ecf = :This.Ecf
		Using Sqlca;
	End if			
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF.~n~n Erro: " + Sqlca.SqlErrText)
		gvo_aplicacao.of_grava_log("Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_data_hora_usuario_software_basico()."+SQLCA.SQLErrText)	
		lb_Sucesso = False
	Else			
		Sqlca.of_Commit()
		lb_Sucesso = True
	End If	
	
End If

Return lb_Sucesso
end function

public function boolean of_fecha_cupom_nao_fiscal ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Indice

Integer li_Indice_Retorno

rConsultaStatusImpressoraInt_ECF_Daruma(12, Ref li_Indice_Retorno)
//If Not This.of_Verifica_Retorno_ECF(iCNFCancelar_ECF_Daruma()) Then Return False
ll_Indice = Long(li_Indice_Retorno)
If ll_Indice = 1 Then
	If Not This.of_Verifica_Retorno_ECF(iCNFEncerrarPadrao_ECF_Daruma(), True) Then Return False  //Testar
End If

Return True
end function

public function boolean of_sequencial_cancelamento (ref long pl_seq);String ls_Informacao
Long ll_Tentativas = 0
Long ll_Retorno, ll_Retorno2

ls_Informacao = Space(1)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma("57", ref ls_Informacao)
	ll_Tentativas++
Loop

If of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
	If Long(ls_Informacao) = 0 Then
		pl_Seq --
	End If
Else
	Return False
End If
//Daruma permite cancelar cupom referente a venda com cartao(CCD)
//Esta verificacao foi colocada para n$$HEX1$$e300$$ENDHEX$$o deixar isso ocorrer, que $$HEX1$$e900$$ENDHEX$$ o padrao nas demais ECFs.
ls_Informacao = Space(6)
ll_Tentativas = 0

Do While ll_Tentativas < 3 And ll_Retorno2 <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno2 = rRetornarInformacao_ECF_Daruma("50", ref ls_Informacao)
	ll_Tentativas++
Loop

If of_Verifica_Retorno_Ecf(ll_Retorno2, False) Then
	If Long(ls_Informacao) = pl_Seq Then
		Return True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o cancelamento do documento impresso.",Exclamation!)
		Return False
	End If
Else
	Return False
End If

Return False
end function

public function boolean of_verifica_problemas_impressora ();If This.ivb_Modo_Teste Then Return True

STRING  ls_aut,&
        ls_slip,&
		ls_bobina,&
		ls_status ,&
		ls_transacao
		
DECIMAL lvdc_soma

Long ll_Tentativas = 0
Long ll_Retorno

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	ls_status = Space(1)
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('57', ref ls_Status)
	ll_Tentativas++
Loop

If Not This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then Return False

If Not This.of_Impressora_online() Then Return False

If Long(ls_Status) >= 1 And Long(ls_Status) <= 4 Then 
	If Not of_Verifica_Cupons_Pendentes() Then Return False
End If

// VerIfica se a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ igual a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o do parametro
If Not of_verifica_data_movimentacao() Then Return False

//If Not This.of_Verifica_Ultimo_Mapa_Resumo() Then Return False
This.of_Verifica_Ultimo_Mapa_Resumo()

If Long(ls_Status) >= 5 And Long(ls_Status) <= 8 Then //CNF aberto
	
	gvo_aplicacao.of_grava_log("Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_verifica_problemas_impressora().")	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente.",StopSign!)
	If Not of_cancela_documento_aberto(79) Then Return False
	
End If

Return True
end function

public function boolean of_leitura_memoria_fiscal (string ps_inicio, string ps_final, boolean pb_arquivo, string ps_tipo, boolean pb_data);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Date ldt_Inicial, ldt_Final
String lvs_Parametro

//pb_Arquivo 	- Salvar em arquivo ou na impressora
//ps_Tipo		- Tipo da leitura (C - Completa | S - Simplificada)
//pb_Data		- Gerar por Data ou Redu$$HEX2$$e700e300$$ENDHEX$$o

If pb_Data Then
	ldt_Inicial 	= Date(ps_Inicio)
	ldt_Final		= Date(ps_Final)
	lvs_Parametro = String(ldt_Inicial,'ddmmyy')
	ps_inicio = lvs_Parametro
	lvs_Parametro = String(ldt_Final,'ddmmyy')
	ps_Final = lvs_Parametro
End If

If ps_tipo = "C" Then
	regAlterarValor_Daruma('ECF\LMFCompleta', '1')
Else
	regAlterarValor_Daruma('ECF\LMFCompleta', '0')
End If

Do While ll_Retry <= 3
	
	If pb_arquivo Then
		If pb_data Then
			ll_Retorno = iMFLerSerial_ECF_Daruma(ps_inicio, ps_final)
		End If 
	Else
		If pb_data Then
			ll_Retorno = iMFLer_ECF_Daruma(ps_inicio, ps_final)
		End If 
	End IF

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False

end function

public function string of_meio_pagamento (string ps_pagamento);String ls_FormasPagto[]

Long 	 ll_Forma

//If This.of_Verifica_Forma_Pagamento(ls_FormasPagto) Then   na DLL NOVA N$$HEX1$$c300$$ENDHEX$$O PRECISA USAR ESSA FUNCAO
//	
//	ll_Forma = Long(ps_pagamento)
//	
//	Return ls_FormasPagto[ll_Forma]
//	
//Else	

	Choose Case ps_pagamento
		Case "01" ; Return "DINHEIRO"
		Case "02" ; Return "CHEQUE"	
		Case "03" ; Return "CHEQUE-PRE"
		Case "04" ; Return "CARTAO CREDITO"
		Case "05" ; Return "CARTAO DEBITO"
		Case "06" ; Return "CONVENIO"
		Case "07" ; Return "CREDIARIO"
		Case "08" ; Return "CONTA CORRENTE"		
		Case "09" ; Return "CLUBE"
		Case "10" ; Return "PBM"		
		Case "11" ; Return "RECARGA"	
	End Choose
	
//End If
end function

public function boolean of_programa_relatorio_gerencial (string ps_tipo);long ll_Retorno

Return True

ll_Retorno = confCadastrar_ECF_Daruma("RG", ps_tipo, " ")

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_verifica_versao_software_basico ();If This.ivb_Modo_Teste Then Return True

String ls_Versao

Long   ll_Retorno
Long ll_Tentativas = 0

Boolean lb_Sucesso = False

ls_Versao = Space( 6 )

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('137', Ref ls_Versao)
	ll_Tentativas++
Loop

If This.of_Verifica_Retorno_ECF(ll_Retorno, False) Then
	
	This.nr_Versao_SWBasico = LeftA(ls_Versao + Space(10),10)
	
	Update impressora_fiscal
	   Set nr_versao_swbasico = :This.nr_Versao_SWBasico
	 Where nr_ecf = :This.Ecf
	 Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF.~n~n Erro: " + Sqlca.SqlErrText,Exclamation!)
		gvo_aplicacao.of_grava_log("Erro ao verificar $$HEX1$$fa00$$ENDHEX$$ltima data de movimenta$$HEX2$$e700e300$$ENDHEX$$o, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_verifica_versao_software_basico()."+Sqlca.SQLErrText)
		lb_Sucesso = False
	Else			
		Sqlca.of_Commit()
		lb_Sucesso = True
	End If	
	
End If

Return lb_Sucesso
end function

public function boolean of_verifica_recebimento_nao_fiscal (ref string ps_recebimento[]);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Pos = 0
Long ll_Ind
Long ll_Inicio
Long ll_Tentativas = 0

String ls_Recebimento
String ls_Forma

ls_Recebimento = Space(662)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rInfoCNF_ECF_Daruma(Ref ls_Recebimento)
	ll_Tentativas++
Loop

If Not This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then Return False

ls_Forma = Trim(MidA(ls_Recebimento, 25, 19))

Do While True
				
	ll_Inicio = ll_Pos +1
	
	If Long(ls_Forma) = 0 Then
	
		ll_Ind++
		ps_recebimento[ll_Ind] = ls_Forma
		
	End If
	
	ll_Pos = PosA(ls_Recebimento, ',', ll_Inicio)
	
	If ll_Pos = 0 Then Exit
	
	ls_Forma = Trim(MidA(ls_Recebimento, ll_Pos +25, 19))
	
Loop

Return True
end function

public function boolean of_verifica_data_movimentacao ();Date   ldt_datafiscal
Date   ldt_dataecf
Date   ldt_dataReducaoZ
Date   ldt_movimento

String ls_DataMovimento

ldt_movimento = Date(PDV.of_dh_movimentacao())

If Not of_DataFiscal(Ref ldt_DataFiscal) 		     Then Return False

/* Gambiarra 25/04/2014 - Para tentar evitar problema de realizar venda com data de movimenta$$HEX2$$e700e300$$ENDHEX$$o errrada */
If ldt_datafiscal = Date( '2000/01/01' ) Then
	If This.of_Suprimento_Caixa( 0.01 ) Then
		Return This.of_Verifica_Data_Movimentacao( )	
	Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Impressora Fiscal Bloqueada. Redu$$HEX2$$e700e300$$ENDHEX$$o Z j$$HEX1$$e100$$ENDHEX$$ efetuada.", StopSign! )
		Return False
	End If
End If
/* Trecho de c$$HEX1$$f300$$ENDHEX$$digo acima igualado ao do objeto uo_Bematech */

If Not of_DataEcf(Ref ldt_dataecf)       			     Then Return False

If Not of_Data_Ultima_ReducaoZ(Ref ldt_dataReducaoZ) Then Return False

If ldt_movimento = ldt_dataecf and ldt_movimento = ldt_DataFiscal Then Return True

If ldt_datafiscal < ldt_dataecf and ldt_datafiscal <> Date('2000/01/01') Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","ECF:" + String(This.Ecf,'000') + "~r~r"+&
	 					"Redu$$HEX2$$e700e300$$ENDHEX$$o Z pendente. Para iniciar as vendas ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio efetu$$HEX1$$e100$$ENDHEX$$-la.~r~r"+&
						"Data Fiscal ECF: " + String(ldt_datafiscal)+"~r~r"+&
						"Data Atual ECF : " + String(ldt_dataecf)+"~r~r"+&
						"Data Movimento : " + String(ldt_movimento)+"~r~r"+&
						"$$HEX1$$da00$$ENDHEX$$ltima Redu$$HEX2$$e700e300$$ENDHEX$$o Z : " + String(ldt_dataReducaoZ), Exclamation!)
	Return False
End If

If ldt_dataecf <> ldt_movimento Then
	Messagebox("Abertura ECF n$$HEX1$$e300$$ENDHEX$$o iniciada","ECF:" + String(This.Ecf,'000') + "~r~r"+&
	 					"Fechamento di$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o efetuado.~r~r"+&
						"Data Atual ECF : " + String(ldt_dataecf)+"~r~r"+&
						"Data Movimento : " + String(ldt_movimento)+"~r~r"+&
						"$$HEX1$$da00$$ENDHEX$$ltima Redu$$HEX2$$e700e300$$ENDHEX$$o Z : " + String(ldt_dataReducaoZ) , Exclamation!)
	Return False
End If

Return True
end function

public function boolean of_abreporta ();Long ll_Retorno

If This.ivb_modo_teste or This.ivb_Porta_Aberta 	Then Return True

//This.of_Conecta_Impressora() servia somente para setar gravacao do log, agora isso $$HEX1$$e900$$ENDHEX$$ feito na gravacao do registro na funcao atualiza_drivers.

If Not This.of_marca_modelo_tipo() Then Return False

If Not This.of_Numero_Serie() Then Return False

Return True
end function

public function boolean of_marca_modelo_tipo ();If This.ivb_Modo_Teste Then Return True

String ls_Marca
String ls_Modelo
String ls_Tipo

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Marca		= Space(20)
ls_Modelo	= Space(20)
ls_Tipo 		= Space(7)

Long ll_Tentativas = 0

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('79', Ref ls_Tipo)
	ll_Tentativas++
Loop

ll_Tentativas	= 0

If ll_Retorno = 1 Then 
	ll_Retorno = 0
	Do While ll_Tentativas < 3 And ll_Retorno <> 1
		If ll_Tentativas > 0 Then gf_Delay(2)
		ll_Retorno = rRetornarInformacao_ECF_Daruma('80', Ref ls_Marca)
		ll_Tentativas++
	Loop
End If

ll_Tentativas	= 0

If ll_Retorno = 1 Then 
	ll_Retorno = 0
	Do While ll_Tentativas < 3 And ll_Retorno <> 1
		If ll_Tentativas > 0 Then gf_Delay(2)
		ll_Retorno = rRetornarInformacao_ECF_Daruma('81', Ref ls_Modelo)
		ll_Tentativas++
	Loop	
End If

If This.of_Verifica_Retorno_ECF(ll_Retorno, False) Then

	This.de_Marca 	= Trim(LeftA(ls_Marca + Space(20) , 20))
	This.de_Modelo = Trim(LeftA(ls_Modelo + Space(20) , 20))
	This.de_Tipo 	= Trim(LeftA(ls_Tipo + Space(7) , 7))

//***** Retirado daqui e criada funcao especifica que $$HEX1$$e900$$ENDHEX$$ chamada apenas uma vez. *****	
//	Update impressora_fiscal
//	Set de_fabricante = :This.de_Marca,
//		 de_modelo		= :This.de_Modelo,
//		 de_tipo			= :This.de_Tipo
//	Where nr_ecf 		= :This.Ecf	 
//	Using Sqlca;
//	
//	If Sqlca.Sqlcode = -1 Then
//		Sqlca.of_RollBack()
//		Sqlca.of_MsgDbError('Grava$$HEX2$$e700e300$$ENDHEX$$o Marca/Modelo/Tipo ECF.')
//		Return False
//	End If	
//	
//	Sqlca.of_Commit()
	
	lb_Sucesso = True
	
End If


Return lb_Sucesso
end function

public function boolean of_totaliza_cupom (string ps_tipo[], decimal pd_valor[]);If This.ivb_Modo_Teste Then Return True

String  ls_valor,&
        ls_Pagto,&
		  ls_parcelas,&
		  ls_msg

Long    ll_ind
Long    ll_Retorno

Long ll_Tentativas = 0

For ll_ind = 1 TO UpperBound(ps_tipo)	
    ls_Pagto = of_meio_pagamento(MidA(ps_tipo[ll_ind],1,2))	

	ls_valor    = String(pd_valor[ll_ind])
	ls_parcelas = "0"
	ls_msg      = ""
	
	ll_Retorno 		= 0
	ll_Tentativas	= 0

	Do While ll_Tentativas < 3 And ll_Retorno <> 1
		If ll_Tentativas > 0 Then gf_Delay(2)
		ll_Retorno = iCFEfetuarPagamentoFormatado_ECF_Daruma(ls_Pagto, ls_valor)
		ll_Tentativas++
	Loop
	  
	If ll_Retorno <> 1 Then Exit
	  
Next

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_leitura_memoria_fiscal_ac1704 (string ps_dado_inicio, string ps_dado_final);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

regAlterarValor_Daruma("Path", "C:\")
regAlterarValor_Daruma("Beep", "1")
 
Do While ll_Retry <= 3 And ll_Retorno <> 1
	If ll_Retry > 0 Then gf_Delay(2)
	
	If Not IsDate(ps_Dado_Inicio) Then
//		ls_Arquivo = 'ATO_MF_COO.TXT'	
		ll_Retorno = rGerarRelatorio_ECF_Daruma('MF','COO',Right("000000" + ps_dado_inicio, 6), Right("000000" + ps_dado_final, 6))
	Else
//		ls_Arquivo = 'ATO_MF_DATA.TXT'
		ll_Retorno = rGerarRelatorio_ECF_Daruma('MF','DATAM', String(Date(ps_dado_inicio), "ddmmyyyy"), String(Date(ps_dado_final), "ddmmyyyy"))
	End If
	ll_Retry ++
Loop

Return This.of_Verifica_Retorno_ECF(ll_Retorno, False)

end function

public function boolean of_nr_cupom (ref long pl_cupom);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
String ls_Cupom
String ls_status

//Verifica se o cupom j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ aberto.
ls_status = Space(1)
If Not This.of_Verifica_Retorno_Ecf(rRetornarInformacao_ECF_Daruma('57', ref ls_Status), False) Then
	Return False
End If

ls_Cupom = Space(6)	
ll_Retorno = rRetornarInformacao_ECF_Daruma('26', ref ls_Cupom)

If ll_Retorno = 1 Then
	//O cupom ainda n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ aberto.
	If Long(ls_Status) = 0 Then
		pl_Cupom = Long(ls_Cupom) + 1
	Else
		pl_Cupom = Long(ls_Cupom)
	End If
End If

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_nr_ecf (ref long pl_ecf);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

String ls_Caixa

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	ls_Caixa = Space(3)	
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('107', ref ls_Caixa)
	ll_Tentativas++
Loop

pl_ecf = Long(ls_Caixa)

If pl_Ecf = 0 Then
	gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi possivel verificar N$$HEX1$$ba00$$ENDHEX$$ ECF.")
End If

This.Ecf = pl_ecf

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_horaecf (ref string ps_hora);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

String Str_Data, &
       Str_Hora

Str_Data = Space( 8 )
Str_Hora = Space( 6 )
ps_Hora  = Space( 6 )

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)	
	ll_Retorno = rDataHoraImpressora_ECF_Daruma(ref Str_Data, ref ps_Hora)
	ll_Tentativas++
Loop

ps_Hora = MidA(ps_Hora, 0, 2) + ":" + MidA(ps_Hora, 3, 2) + ":" + MidA(ps_Hora, 5, 2)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_dataecf (ref date pdt_data);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

String ls_Data, &
       ls_Hora, &
		 ls_Ano
		 
ls_Data = Space(8)
ls_Hora = Space(6)		 

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rDataHoraImpressora_ECF_Daruma(ref ls_Data, ref ls_Hora)
	ll_Tentativas++
Loop

ls_Data = MidA(ls_Data,1,2)+"/"+MidA(ls_Data,3,2)+"/"+MidA(ls_Data,5,4)
	
pdt_data = Date(ls_Data)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_datafiscal (ref date pdt_data);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

String	ls_Data, &
		ls_Hora, &
		ls_Ano

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	ls_Data = Space(8)	
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('70', ref ls_Data)  //*****RETORNA 01/01/2000 na nova DLL ****
//	ll_Retorno = rRetornarInformacao_ECF_Daruma('171', ref ls_Data)
	ll_Tentativas++
Loop

//If Long(MidA(ls_Data,7,2)) <= 60 Then
//	ls_Ano = '20'
//Else
//	ls_Ano = '19'
//End If
	
ls_Data = MidA(ls_Data,1,2)+"/"+MidA(ls_Data,3,2)+"/"+MidA(ls_Data,5,4)
	
pdt_data = Date(ls_Data)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_dados_impressora (ref long pl_sequencial, ref long pl_ecf);//If Not of_nr_ecf(Ref pl_ecf) Then Return False
pl_Ecf = This.Ecf

If Not of_nr_cupom(Ref pl_sequencial) Then Return False


Return True
end function

public function boolean of_atualiza_data_fiscal ();If This.ivb_Modo_Teste Then Return True

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esse processo n$$HEX1$$e300$$ENDHEX$$o se aplica a esse modelo de impressora Fiscal",Exclamation!)

Return True
end function

public function boolean of_carrega_dados_ecf (long pl_ecf);Select nr_serie,   
		 id_situacao,   
		 de_fabricante,   
		 de_modelo,   
		 dh_ultima_venda,   
		 pc_livre_mfd,   
		 de_tipo,   
		 id_mfadicional,   
		 dh_swbasico,   
		 nr_versao_swbasico  
 Into :This.nr_Serie,
		:This.Id_Situacao,
		:This.de_marca,
		:This.de_modelo,
		:This.de_tipo,
		:This.dh_ultima_venda,   
		:This.pc_livre_mfd,   
		:This.id_mfadicional,   
		:This.dh_swbasico,   
		:This.nr_versao_swbasico  
 From impressora_fiscal  
Where impressora_fiscal.nr_ecf = :pl_ecf
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	gvo_aplicacao.of_grava_log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o de par$$HEX1$$e200$$ENDHEX$$metros da ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_carrega_dados_ecf()."+SQLCA.SQLErrText)	
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o de par$$HEX1$$e200$$ENDHEX$$metros da ECF.')
	Return False
End If

Return True
end function

public function boolean of_contador_credito_debito (ref long pl_contador);Long ll_Retorno
Long ll_Tentativas = 0

String ls_Indice = '45'
String ls_Contador

ls_Contador = Space(4)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma(ls_Indice, Ref ls_Contador)
	ll_Tentativas++
Loop

pl_Contador = Long(ls_Contador)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_contador_cupom_fiscal (ref long pl_contador);Long ll_Retorno
Long ll_Tentativas = 0

String ls_Indice = '30'
String ls_Contador

ls_Contador = Space(6)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma(ls_Indice, Ref ls_Contador)
	ll_Tentativas++
Loop

pl_Contador = Long(ls_Contador)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_contador_operacao_nao_fiscal (ref long pl_contador);Long ll_Retorno
Long ll_Tentativas = 0

String ls_Indice = '28'
String ls_Contador

ls_Contador = Space(6)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma(ls_Indice, Ref ls_Contador)
	ll_Tentativas++
Loop

pl_Contador = Long(ls_Contador)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_contador_relatorio_gerencial (ref long pl_contador);Long ll_Retorno
Long ll_Tentativas = 0

String ls_Indice = '33'
String ls_Contador

ls_Contador = Space(6)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma(ls_Indice, Ref ls_Contador)
	ll_Tentativas++
Loop

pl_Contador = Long(ls_Contador)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_registra_documento_ecf (string ps_documento, decimal pdc_valor);
String ls_Nulo

SetNull(ls_Nulo)

Return of_Registra_Documento_ecf(ps_documento,ls_Nulo,pdc_valor)
end function

public function boolean of_inicializa_relatorio_gerencial (string ps_relatorio, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno = 0
Long ll_Tentativas = 0

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	If ps_Relatorio = '01' Then
		ll_Retorno = iRGAbrirPadrao_ECF_Daruma()
	Else
		ll_Retorno = iRGAbrir_ECF_Daruma(ps_relatorio)		
	End If
	ll_Tentativas++
Loop

//of_Registra_documento_ecf('RG',pdc_valor)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long    ll_linha

String  ls_Relatorio
String  ls_Texto

//This.of_Programa_Relatorio_Gerencial(ps_titulo)  - J$$HEX1$$e100$$ENDHEX$$ vem programado das autorizadas.

gf_Delay(2) //Na Daruma as vezes ocorre erro pelo fato da ECF n$$HEX1$$e300$$ENDHEX$$o estar "pronta" para ler todas as informa$$HEX2$$e700f500$$ENDHEX$$es necess$$HEX1$$e100$$ENDHEX$$rias, ent$$HEX1$$e300$$ENDHEX$$o foi colocado um delay.

If Not Of_Verifica_Problemas_Impressora() Then Return False

Choose Case ps_titulo
	Case "VIA CONVENIO"
		ls_Relatorio = "02"
	Case "VIA RECIBO"
		ls_Relatorio = "03"
	Case "VIA CREDIARIO"
		ls_Relatorio = "04"
	Case "VIA PBM"
		ls_Relatorio = "05"
	Case "VIA CLUBE"	
		ls_Relatorio = "06"
	Case "RELATORIO GERAL"
		ls_Relatorio = "01"
	Case Else
		ls_Relatorio = "01"
End Choose		

Open(w_janela_aguarde)
w_janela_aguarde.mle_1.text = "IMPRIMINDO " + ps_Titulo

If Not of_inicializa_relatorio_gerencial(ps_titulo, pdc_valor) Then	
Tenta_Iniciar:
	If Not This.of_pergunta_tentativa(true) Then	
		If IsNull(PDV.ivs_Tipo_Venda) Or PDV.ivs_Tipo_Venda = "TR" Then	
			SITEF.of_transacao_pendente(This.ECF, PDV.cd_caixa)
		End If
		Return False
	Else		
		If Not This.of_inicializa_relatorio_gerencial(ls_Relatorio,pdc_valor) Then Goto Tenta_Iniciar
	End If	
End If			

If Not This.of_imprime_relatorio_gerencial(ps_texto) Then 
	If Not This.of_pergunta_tentativa(false) Then	
		If IsNull(PDV.ivs_Tipo_Venda) Or PDV.ivs_Tipo_Venda = "TR" Then	
			SITEF.of_transacao_pendente(This.ECF, PDV.cd_caixa)
		End If
		Return False
	Else					
		
		If Not This.of_inicializa_relatorio_gerencial(ls_Relatorio,pdc_valor) Then Return False		
		
		If Not This.of_imprime_relatorio_gerencial(ps_texto) Then Return False					
		
	End If
End If

If Not This.of_fecha_relatorio_gerencial() Then Return False


//MODO PARA O TRN NOVO
/*
If Not of_inicializa_relatorio_gerencial(ps_titulo, pdc_valor) Then
Tenta_iniciar:
	If Not This.of_pergunta_tentativa(true) Then	
		If IsNull(PDV.ivs_Tipo_Venda) Or PDV.ivs_Tipo_Venda = "TR" Then	
			SITEF.of_transacao_pendente(This.ECF)
		End If
		Return False
	Else		
		If Not of_inicializa_relatorio_gerencial(ps_titulo,pdc_valor) Then Goto Tenta_iniciar
	End If
End If

//If Not This.of_imprime_relatorio_gerencial(ps_texto) Then Return False

If Not This.of_imprime_relatorio_gerencial(ps_texto,ls_Relatorio) Then
	If Not This.of_pergunta_tentativa(false) Then	
		If IsNull(PDV.ivs_Tipo_Venda) Or PDV.ivs_Tipo_Venda = "TR" Then	
			SITEF.of_transacao_pendente(This.ECF)
		End If
		Return False
	Else					
		
		If Not of_inicializa_relatorio_gerencial(ps_titulo,pdc_valor) Then Return False		
		
		If Not This.of_imprime_relatorio_gerencial(ps_texto,ls_Relatorio) Then Return False					
		
	End If
End If	

If Not This.of_fecha_relatorio_gerencial() Then Return False

*/
Close(w_Janela_Aguarde)

Return True
end function

public function boolean of_inicializa_comprovante_tef_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

String	ls_Forma_Pagamento 

Long ll_Retorno = 1

ls_Forma_Pagamento = This.of_Meio_Pagamento(ps_Pagamento)

If Not of_inicializa_recebimento_nao_fiscal() Then Return False

If Not of_efetua_recebimento_nao_fiscal(ps_Recebimento, String(pdc_valor), ls_Forma_Pagamento) Then
	of_cancela_ultimo_cupom(False)
	Return False
End If

If Not of_Registra_documento_ecf('CN',ls_Forma_Pagamento,pdc_valor) Then Return False

If Not of_totaliza_recebimento_nao_fiscal(ls_Forma_Pagamento, String(pdc_valor), '') Then Return False

If Not of_inicializa_comprovante_tef(ps_pagamento,ps_descricao,ps_pagamento,pdc_valor, '') Then Return False

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_inicializa_comprovante_tef (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor, string ps_cupom);If This.ivb_Modo_Teste Then Return True

Long   ll_Retorno

String ls_Pagamento
String ls_Valor 
String ls_Cupom

Long ll_Cupom

ls_Valor = ""
ls_Cupom = ""

gf_Delay(2) //Na Daruma as vezes ocorre erro pelo fato da ECF n$$HEX1$$e300$$ENDHEX$$o estar "pronta" para ler todas as informa$$HEX2$$e700f500$$ENDHEX$$es necess$$HEX1$$e100$$ENDHEX$$rias, ent$$HEX1$$e300$$ENDHEX$$o foi colocado um delay.

//Busca o COO do documento vinculado
This.of_Nr_Cupom(ref ll_Cupom)

ls_Valor = String(pdc_Valor)
ls_Cupom = ps_cupom

//Se n$$HEX1$$e300$$ENDHEX$$o foi passado o COO, usa o buscado anteriormente, teoricamente aqui o COO retornado $$HEX1$$e900$$ENDHEX$$ o proximo, pois o comprovante j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ aberto
//ent$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ subtraido 1 do COO capturado da ECF
If Trim(ls_Cupom) = '' Then
	ll_Cupom = ll_Cupom - 1
	ls_Cupom = String(ll_Cupom)
End If

//Retorna descri$$HEX2$$e700e300$$ENDHEX$$o do meio de pagamento
ls_Pagamento = of_meio_pagamento(ps_pagamento)

ll_Retorno = iCCDAbrirSimplificado_ECF_Daruma(ls_Pagamento, "1", ls_Cupom, ls_Valor)

If Not This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then 
	PDV.ivb_Iniciou_Erro = True
	Return False
End If

If Not This.of_Registra_documento_ecf('CC', ps_Pagamento, pdc_Valor) Then
	PDV.ivb_Iniciou_Erro = True
	Return False		
Else
	Return True
End If

end function

public function boolean of_registra_item_vendido (string ps_produto, long pl_qtde, decimal pdc_precounit, decimal pdc_precotot, string ps_descricao, decimal pdc_aliquota, string ps_complemento, string ps_tributacao_icms);If This.ivb_Modo_Teste Then Return True

String	lvs_qtd,&
      	lvs_precounit,&
	   	lvs_precotot,&
	   	lvs_comando,&
	   	lvs_desconto,&
	   	lvs_trib

Long 		ll_Retorno

lvs_trib = This.of_Indicador_Aliquota(pdc_Aliquota,ps_tributacao_icms)

//ps_descricao = LeftA(Trim(ps_descricao),24)

lvs_qtd			= String(pl_qtde)
lvs_precounit	= String(pdc_precounit)
lvs_precotot		= String(pdc_precotot)
lvs_desconto  	= String(pdc_precotot - (pdc_precounit*pl_qtde))


ll_Retorno = iCFVender_ECF_Daruma(lvs_trib, lvs_qtd, lvs_precounit, "D$", lvs_desconto, trim(ps_produto),"un", ps_descricao)

If This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
	This.of_Atualiza_Venda_Bruta()
	Return True
Else 
	Return False
End If
	
//If ll_Retorno = 1 Then
//	If This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
//		This.of_Atualiza_Venda_Bruta()
//		Return True
//	Else 
//		Return False
//	End If
//End If	

Return False
end function

public function String of_desencripta (string ps_texto);
String ls_Byte
String ls_Valor

Integer li_Ind

For li_Ind = 1 To LenA(ps_texto)

	ls_Byte = CharA(AscA(MidA(ps_texto,li_Ind,1)) - li_Ind )

	ls_Valor += ls_Byte
	
Next

Return ls_Valor
end function

public function string of_encripta (string ps_texto);
String ls_Byte
String ls_Valor

Integer li_Ind

For li_Ind = 1 To LenA(ps_texto)
		
	ls_Byte = CharA(AscA(MidA(ps_texto,li_Ind,1)) + li_Ind)
		
	ls_Valor += ls_Byte
	
Next

Return ls_Valor
end function

public function boolean of_atualiza_venda_bruta ();
Decimal{2}	ldc_Valor

String 		ls_File = 'c:\sistemas\cl\arquivos\pafecf.ini'
String 		ls_Serie
String   	ls_Valor

If Not FileExists(ls_File) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo " + ls_File + " n$$HEX1$$e300$$ENDHEX$$o encontrado.",StopSign!)
	gvo_aplicacao.of_grava_log("Arquivo " + ls_File + " n$$HEX1$$e300$$ENDHEX$$o encontrado, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_atualiza_venda_bruta().")	
	Return False
End If
	
If Not of_Grande_Total(Ref ldc_Valor) Then Return False

SetProfileString(ls_File, "ECF", "Serie",of_Encripta(This.nr_Serie))
SetProfileString(ls_File, "ECF", "VendaBruta",of_Encripta(String(ldc_Valor,'###,###,###,###.00')))
	
Return True
end function

public function boolean of_numero_serie ();Long ll_Retorno

String ls_Serie_MFD, ls_Serie
Long ll_Tentativas = 0

ls_Serie_MFD = Space(21)
ls_Serie = Space(20)

rRetornarInformacao_ECF_Daruma('77', ref ls_Serie)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('78', ref ls_Serie_MFD)
	ll_Tentativas++
Loop	

If of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
	This.nr_Serie_MFD = Trim(LeftA(ls_Serie_MFD,21))
	This.nr_Serie = Trim(RightA(ls_Serie_MFD,8))
	Return True	
End If	

Return False
end function

public function boolean of_verifica_venda_bruta_diaria ();//Return True

//Desabilitado - Utilizado na Homologa$$HEX2$$e700e300$$ENDHEX$$o

Decimal{2}	ldc_Valor

Long 			ll_ecf

String 		ls_File = 'C:\Sistemas\CL\Arquivos\Pafecf.ini'
String 		ls_Serie
String 		ls_SerieIni
String   	ls_ValorIni
String 		ls_Instalacao
String		ls_ecf

If Not FileExists(ls_File) Then
	
	If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Homologacao","") = 'S' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo de registro de Venda Bruta e N$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie n$$HEX1$$e300$$ENDHEX$$o encontrado.~r~rVenda bloqueada!")
		Return False
	End If
	
	FileClose(FileOpen(ls_file,StreamMode!,Write!,Shared!,Append!))
	
	If Not of_Grande_Total(Ref ldc_Valor) Then Return False	

//	If Not of_Verifica_Retorno_ECF(rRetornarNumeroSerieCodificado_ECF_Daruma(ls_Serie)) Then Return False
    ls_Serie = This.nr_Serie_MFD
	
	SetProfileString(ls_File, "ECF", "Serie",of_Encripta(ls_Serie))
	
	SetProfileString(ls_File, "ECF", "VendaBruta",of_Encripta(String(ldc_Valor,'###,###,###,###.00')))
	
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Registro de Venda Bruta e N$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie efetuados !")
	
Else
	
	If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Homologacao","") <> 'S' Then
		Return True
	End If
	
	If Not of_Grande_Total(Ref ldc_Valor) Then Return False	

//	If Not of_Verifica_Retorno_ECF(rRetornarNumeroSerieCodificado_ECF_Daruma(ls_Serie)) Then Return False
    ls_Serie = This.nr_Serie_MFD	
	
	ls_SerieIni = ProfileString(ls_File, "ECF", "Serie","none")
	ls_ValorIni = ProfileString(ls_File, "ECF", "VendaBruta","none")

	ls_SerieIni = of_Desencripta(ls_SerieIni)
	ls_ValorIni	= of_Desencripta(ls_ValorIni)

	If ls_SerieIni <> ls_Serie Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie da ECF incompat$$HEX1$$ed00$$ENDHEX$$vel com o n$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie liberado para o PDV.~n~nECF: " + ls_Serie + " PDV: " + ls_SerieIni,Exclamation!)
		Return False
	End If

	If Dec(ls_ValorIni) <> ldc_Valor Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor da Venda Bruta da ECF divergente do valor acumulado no PDV.~n~nECF: " + String(ldc_Valor,'###,###,###,##0.00') + " PDV: " + ls_ValorIni,Exclamation!)
		Return False
	End If

End If

Return True
end function

public function boolean of_grande_total (ref decimal pdc_venda);If This.ivb_Modo_Teste Then Return True

String ls_Valor
Long   ll_Retorno,&
		ll_Tentativas

Boolean lb_Sucesso = False

ls_Valor = Space(18)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rRetornarInformacao_ECF_Daruma('1', Ref ls_Valor)
	ll_Tentativas++
Loop

lb_Sucesso =  This.of_Verifica_Retorno_ECF(ll_Retorno, False)
		
If lb_Sucesso Then
	pdc_venda = Dec(ls_Valor) / 100
Else
	pdc_venda = 000.00
End If

Return lb_Sucesso
end function

public function boolean of_cancela_item_anterior ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

ll_Retorno = iCFCancelarUltimoItem_ECF_Daruma()

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_fecha_cupom (string ps_msg[], boolean pb_repete, string ps_indicadores[6, 2], string ps_vinculado);If This.ivb_Modo_Teste Then Return True

Long   ll_ind
Long   ll_Retorno
Long ll_Tentativas = 0

String ls_msg   = ''
String ls_linha = ''

//ls_msg += Trim(ps_msg[1]) + Char(10)

For ll_ind = 1 TO UpperBound(ps_indicadores)
	
	If Not IsNull(ps_indicadores[ll_ind,2]) and Trim(ps_indicadores[ll_ind,2]) <> "" Then
		
		If LenA(ls_linha + Trim(ps_indicadores[ll_ind,1]) + ':' + Trim(ps_indicadores[ll_ind,2]) + ' ') < 60 Then
			ls_linha += Trim(ps_indicadores[ll_ind,1]) + ':' + Trim(ps_indicadores[ll_ind,2]) + ' '
			Continue
		End If
		
		ls_msg += Trim(ls_linha) + CharA(10)
		
		ls_linha = ''
		
	End If
	
Next

If Trim(ls_linha) <> '' Then ls_msg += ls_linha + CharA(10)

For ll_ind = 1 TO UpperBound(ps_msg)
	
	If Not IsNull(ps_msg [ll_ind]) and Trim(ps_msg [ll_ind]) <> "" And ps_msg[ll_ind] <> ivs_MD5_CL Then
		
		ls_msg += Trim(ps_msg [ll_ind]) + CharA(10)
		
	End If
	
Next

ls_msg = CharA(15) + ls_msg + CharA(18)

Long lvl_Pos 

lvl_Pos = PosA(ls_msg, "VOCE ECONOMIZOU")
If lvl_Pos > 0 Then
	ls_msg = MidA(ls_msg, 1, lvl_Pos - 1) + CharA(27) + CharA(69) + MidA(ls_msg, lvl_Pos, 30) + CharA(27) + CharA(70) + MidA(ls_msg, lvl_Pos + 30)
End If 

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = iCFEncerrarConfigMsg_ECF_Daruma(ls_msg)
	ll_Tentativas++
Loop

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, True)
end function

public function boolean of_registra_documento_ecf (string ps_documento, string ps_totalizador, decimal pdc_valor);Long ll_coo
Long ll_gnf
Long ll_grg
Long ll_cdc
Long ll_ccf

Datetime ldh_Movimento
Datetime ldh_Final

String ls_Hash

If Not of_nr_cupom(Ref ll_coo) Then Return False

If (ps_documento = 'RG') or (ps_documento = 'CC') or (ps_documento = 'CN') Then
	ll_coo = Int(ll_coo - 1)
End If

ldh_Movimento = PDV.of_dh_movimentacao()
ldh_Final	  = gf_GetServerDate()

If Not This.of_contador_credito_debito(Ref ll_cdc) Then Return False

If Not This.of_contador_relatorio_gerencial(Ref ll_grg) Then Return False
		
If Not This.of_contador_operacao_nao_fiscal(Ref ll_gnf) Then Return False

If Not This.of_contador_cupom_fiscal(Ref ll_ccf) Then Return False

Insert Into documento_ecf  
		( nr_ecf,   
		  dh_movimento,   
		  nr_coo,   
		  dh_final,   
		  id_documento,   
		  nr_gnf,   
		  nr_grg,
		  nr_cdc,
		  cd_forma_pagamento,
		  vl_documento,
		  nr_ccf)  
Values (:This.ECF,
		  :ldh_Movimento,   
		  :ll_coo,   
		  :ldh_Final,   
		  :ps_documento,   
		  :ll_gnf,   
		  :ll_grg,
		  :ll_cdc,
		  :ps_totalizador,
		  :pdc_valor,
		  :ll_ccf)
Using Sqlca;
		  
If Sqlca.Sqlcode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, 'Registro do documento ECF. ECF[' + String(This.ECF) + "] " + &
								"Movimento[" + String(ldh_Movimento,"DDMMYYYY") + "] " + &
								"COO[" + String(ll_Coo) + "] " + &
								"Data Final[" + String(ldh_Final, "DDMMYYYY") + "] " + &
								"Documento[" + ps_Documento + &
								"GNF[" + String(ll_gnf) + "] " + &
								"GRG[" + String(ll_grg) + "] " + &
								"CDC[" + String(ll_cdc) + "] " + &
								"Pagamento[" + ps_Totalizador + "] " + &
								"Valor[" + String(pdc_valor) + "] " + &
								"CCF[" + String(ll_Ccf) + "] ")
	Sqlca.of_MsgDbError('Registro do documento ECF')
	Return False
Else
	Sqlca.of_Commit()
	Return True
End If
end function

public function boolean of_abertura_dia ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
//dll nova n$$HEX1$$e300$$ENDHEX$$o tem necessidade de abertura.
//Daruma_FI_AberturaDoDia("0,00", "Dinheiro")

Return True
 

end function

public function boolean of_pergunta_impressora_offline ();//
LONG  lvl_resp
//
lvl_resp = Messagebox("Impressora Fiscal","Verifique se a impressora "+&
                      "fiscal est$$HEX1$$e100$$ENDHEX$$ ligada e se os cabos est$$HEX1$$e300$$ENDHEX$$o corretamente "+&
					  	    "conectados.Tentar novamente ?", Question!,YesNo!,1)
								
//
IF lvl_resp = 1 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
//
end function

public function string of_gera_hash (string ps_arquivo);String ls_Hash_Hex
String ls_Hash_Asc


ls_Hash_Hex = Space(32)
ls_Hash_Asc = Space(32)

Long ll_Retorno

ll_Retorno = rCalcularMD5_ECF_Daruma( ps_Arquivo, ls_Hash_Hex, ls_Hash_Asc )

Return ls_Hash_Hex
end function

public function boolean of_atualiza_cadastro_ecf ();STRING ls_Marca, &
		 ls_Modelo, &
		 ls_Tipo, &
		 ls_CPD, &
		 ls_Serie, &
		 ls_SerieMFD

LONG ll_ECF, &
		ll_mes, &
		ll_ano

BOOLEAN lb_Sucesso = False

Date ldt_data_ecf

ls_CPD = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF", "CPD","")

If Trim(UPPER(ls_CPD)) = 'SIM' Then
	This.ivb_Cadastrada = True		
	Return True
End If

If This.Ecf = 0 Or IsNull(This.Ecf) Then
	This.of_nr_ecf(This.ECF)
	If This.ECF = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas na leitura dos dados da ECF! ~n"  + &
									"Entre novamente no Sistema de Caixa." ,Exclamation!)		
		Return False
//		Event Close
	End If	
End If

Select nr_ecf, de_fabricante, de_modelo, de_tipo, nr_serie_mfd 
Into :ll_ECF, :ls_Marca, :ls_Modelo, :ls_Tipo, :ls_SerieMFD
From Impressora_fiscal
	Where nr_ecf = :This.Ecf
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case -1
		gvo_aplicacao.of_grava_log("Erro ao consultar Marca/Modelo/Tipo ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_atualiza_cadastro_ecf()."+SQLCA.SQLErrText)	
		Sqlca.of_MsgDbError('Consulta Marca/Modelo/Tipo ECF.')
		lb_Sucesso = False
		
	Case 100				
		
		If Not This.of_numero_serie() Then Return False
		
		This.of_dataecf(Ref ldt_data_ecf)
		If Not IsDate(String(ldt_data_ecf,'dd/mm/yyyy')) Then
			gvo_aplicacao.of_grava_log("Problemas na leitura dos dados da ECF - Data.")
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas na leitura dos dados da ECF! ~n"  + &
										"Entre novamente no Sistema de Caixa." ,Exclamation!)		
			Return False
		End If
		ll_mes	= Month(ldt_data_ecf)
		ll_ano		= Year(ldt_data_ecf)
		If ll_mes = 1 Then
			ll_mes = 12
			ll_ano = ll_ano - 1
		Else
			ll_mes = ll_mes - 1
		End If		
		ldt_data_ecf = Date('01/'+String(ll_mes)+'/'+String(ll_ano))								
		
		ls_Serie = RightA(This.nr_serie,8)	
		ls_Marca = LeftA(This.de_marca,15)
		ls_modelo = LeftA(This.de_modelo,15)
		
		Insert Into impressora_fiscal  
				( nr_ecf,   
				  nr_serie,   
				  id_situacao,   
				  de_fabricante,   
				  de_modelo,
				  nr_serie_mfd,
				  de_tipo,
				  dh_referencia_arquivo_mfd,
				  cd_identificacao_nacional)   
		Values (:This.ECF,
				  :ls_Serie,   
				  'L',   
				  :ls_marca,   
				  :ls_modelo,
				  :This.nr_Serie_MFD,
				  :This.de_Tipo,
				  :ldt_data_ecf,
				  '081201')
		Using Sqlca;
				  
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_RollBack()
			Sqlca.of_MsgDbError('')
			Return False
		Else
			Sqlca.of_Commit()				
		End If
		
		lb_Sucesso = True		
		
		This.ivb_Cadastrada = True				
	
	Case 0	

		If (Trim(ls_Marca) = '' Or IsNull(ls_Marca)) Or &
			(Trim(ls_Modelo) = '' Or IsNull(ls_Modelo)) Or &
			(Trim(ls_Tipo) = '' Or IsNull(ls_Tipo)) Or &
			(Trim(ls_serieMFD) = '' Or Isnull(ls_serieMFD)) Or &
			LenA(ls_serieMFD) <> 20 Then			
			
			If Not This.of_numero_serie() Then 
				Return False			
			Else
				If LenA(This.nr_Serie_MFD) <> 20 Then
					gvo_aplicacao.Of_Grava_Log("Atualizacao Cadastro ECF - ECF: " + String(This.ecf) + ' MFD Retornada: ' + String(This.nr_Serie_MFD) + " (uo_daruma - of_atualiza_cadastro_ecf).")								
				End If
			End If
			
			ls_Marca = LeftA(This.de_marca,15)
			ls_modelo = LeftA(This.de_modelo,15)			
	
			Update impressora_fiscal
			Set de_fabricante = :ls_Marca,
				 de_modelo		= :ls_modelo,
				 de_tipo			= :This.de_Tipo,
				 nr_serie_mfd  = :This.nr_Serie_MFD
			Where nr_ecf 		= :This.Ecf	 
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o ECF Daruma - fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_atualiza_cadastro_ecf().")
				Sqlca.of_MsgDbError('Atualiza$$HEX2$$e700e300$$ENDHEX$$o Marca/Modelo/Tipo ECF.')
				Return False
			End If		
			
			Sqlca.of_Commit()
			
		End If
		
		lb_Sucesso = True		

		This.ivb_Cadastrada = True		
		
End Choose	

Return lb_Sucesso
end function

public function boolean of_codigo_barras (integer pl_tipo, string ps_codigo, string ps_tamanho);Long ll_Retorno
Long ll_Tentativas = 0
String ls_Codigo

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = iImprimirCodigoBarras_ECF_Daruma('01', '3', '080', '0', ps_codigo, 'H', '')
	ll_Tentativas++
Loop

//Imprime
ls_Codigo = ps_Codigo + '0'
iRGImprimirTexto_ECF_Daruma(ls_Codigo)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_inicializa_comprovante_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

String	ls_Forma_Pagamento 

Long ll_Retorno = 1

ls_Forma_Pagamento = This.of_Meio_Pagamento(ps_Pagamento)

If Not of_inicializa_recebimento_nao_fiscal() Then Return False

If Not of_efetua_recebimento_nao_fiscal(ps_Recebimento, String(pdc_valor), ls_Forma_Pagamento) Then
	of_cancela_ultimo_cupom(False)
	Return False
End If

If Not of_totaliza_recebimento_nao_fiscal(ls_Forma_Pagamento, String(pdc_valor), ps_descricao) Then Return False

If Not of_Registra_documento_ecf('CN',ls_Forma_Pagamento,pdc_valor) Then Return False

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_pergunta_tentativa (boolean pvb_abrindo);Boolean lb_FechouRel

lb_FechouRel = False

Do While lb_FechouRel = False
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Falha durante a impress$$HEX1$$e300$$ENDHEX$$o. Tentar Novamente ?", Question!,YesNo!, 2) = 1 Then
		If pvb_Abrindo Then
			Return True
		Else
			If Not This.of_fecha_relatorio_gerencial() Then 
				Continue			
			Else
				lb_FechouRel = True			
				Return True			
			End If
		End If
	Else
		lb_FechouRel = True
		Return False
	End If
Loop
end function

public function boolean of_texto_relatorio_gerencial (string ps_texto);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

ps_texto = CharA(15) + ps_texto + CharA(18) + CharA(13) + CharA(10)
	
//Do While ll_Tentativas < 3 And ll_Retorno <> 1
//	If ll_Tentativas > 0 Then gf_Delay(2)
ll_Retorno = iRGImprimirTexto_ECF_Daruma(ps_texto)
	
If ll_Retorno <> 1 Then Return False

//	ll_Tentativas++
//Loop
	
Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_inicializa_relatorio_gerencial (string ps_relatorio);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno = 0
Long ll_Tentativas = 0

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	If ps_Relatorio = '01' Then
		ll_Retorno = iRGAbrirPadrao_ECF_Daruma()
	Else
		ll_Retorno = iRGAbrir_ECF_Daruma(ps_relatorio)		
	End If
	ll_Tentativas++
Loop

//of_Registra_documento_ecf('RG',pdc_valor)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_inicializa_cupom (string ps_cpf_cgc);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

Do While ll_Retorno <> 1 

	ll_Retorno = iCFAbrir_ECF_Daruma(ps_cpf_cgc,"","")
	
	Choose Case ll_Retorno
		Case 1 						// Comando OK
	
			If This.of_Status_ECF() = -1 Then
				
				If This.St3 = 79 Or This.St3 = 80 Or This.St3 = 81 Then //CNF Aberto - CCD Aberto - RG Aberto
		
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente.",Exclamation!)
					gvo_aplicacao.of_grava_log("Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_inicializa_cupom().")	

					If Not This.of_cancela_documento_aberto(This.St3) Then Return False
					
					Return This.of_Inicializa_Cupom(ps_cpf_cgc)
				Else
					Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)								
				End If
				
			Else
			
				Return True
			
			End If
			
		Case Else

			Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)			
			
	End Choose
	
Loop
end function

public function boolean of_verifica_retorno_ecf (long pl_retorno, boolean pb_mostra_aviso);Long	ll_Retorno, &
		ll_Retorno_Extendido, &
		ll_Indice, &
		ll_Erro, &
		ll_Aviso

Integer 	li_Indice_Erro, &
			li_Indice_Aviso, &
			li_Erro, &
			li_Aviso, &
			li_Retorno

String	ls_Retorno, &
		ls_Msg = "", &
		ls_Msg_Aviso = "", &
		ls_Retorno_Impressora, &
		ls_Aviso, ls_Aviso_Ult_Cmd, &
		ls_Erro, ls_Erro_Ult_Cmd	

If pl_retorno = 1 Then 
	//	Retorna a mensagem referente ao erro e aviso do ultimo comando enviado
	ls_Aviso_Ult_Cmd = Space(300)
	ls_Erro_Ult_Cmd = Space(300)
	eRetornarAvisoErroUltimoCMD_ECF_Daruma(Ref ls_Aviso_Ult_Cmd, Ref ls_Erro_Ult_Cmd)
	// Retorna em string e um inteiro com c$$HEX1$$f300$$ENDHEX$$digo do erro e aviso do $$HEX1$$fa00$$ENDHEX$$ltimo comando enviado
	ls_Erro = Space(4)
	ls_Aviso = Space(4)
	rStatusUltimoCmd_ECF_Daruma(Ref ls_Erro, Ref ls_Aviso, Ref li_Erro, Ref li_Aviso)
	
	ll_Erro = Long(li_Erro)
	ll_Aviso = Long(li_Aviso)
	
	If ll_Aviso > 0 Then
		ls_Msg_Aviso = ls_Msg_Aviso + 'Aviso: ' + String(ll_Aviso) + ' - ' + Trim(ls_Aviso_Ult_Cmd)	+'.'
		gvo_aplicacao.of_grava_log(ls_Msg_Aviso)
	End If	
	
	If ll_Erro = 0 Then
		If pb_Mostra_Aviso Then
			If ll_Aviso > 0 Then MessageBox("Impressora Fiscal", ls_Msg_Aviso)
		End If
		Return True
	Else
		ls_Msg = 'Erro: ' + String(ll_Erro) + ' - ' + Trim(ls_Erro_Ult_Cmd)
		gvo_aplicacao.of_grava_log(ls_Msg)
		If pb_Mostra_Aviso And ll_Aviso > 0 Then
			ls_Msg += CharA(13) + CharA(10) + ' Aviso: ' + Trim(ls_Msg_Aviso) 
		End If
	End If	
End If

If pl_Retorno = 0 Then
	gvo_aplicacao.of_grava_log("Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o, n$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel enviar o m$$HEX1$$e900$$ENDHEX$$todo.")	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o com o ECF",StopSign!)	
	Return False
End If

If pl_Retorno < 0 Then		
	li_Retorno = Int(pl_Retorno)
	ls_Retorno_Impressora = Space(200)
	eInterpretarRetorno_ECF_Daruma(li_Retorno, Ref ls_Retorno_Impressora)
	gvo_aplicacao.of_grava_log("Erro no comando enviado a ECF DARUMA. Retorno original: " + String(pl_retorno) + " Retorno convertido: " + String(li_Retorno) + " Texto do retorno:" + Trim(ls_Retorno_Impressora))	
	MessageBox("Impressora Fiscal",Trim(ls_Retorno_Impressora),StopSign!)
	Return False
End If

MessageBox("Impressora Fiscal", ls_Msg)

Return False
end function

public function long of_status_ecf ();Long	ll_Erro, &
		ll_Aviso

Integer	li_Erro, &
			li_Aviso

String	ls_Aviso, &
		ls_Erro

// Retorna em string e um inteiro com c$$HEX1$$f300$$ENDHEX$$digo do erro e aviso do $$HEX1$$fa00$$ENDHEX$$ltimo comando enviado
ls_Erro = Space(4)
ls_Aviso = Space(4)
rStatusUltimoCmd_ECF_Daruma(Ref ls_Erro, Ref ls_Aviso, Ref li_Erro, Ref li_Aviso)

ll_Erro = Long(li_Erro)
ll_Aviso = Long(li_Aviso)

If ll_Erro = 0 Then
	Return 1
Else
	This.St3 = ll_Erro
	Return -1
End If	
end function

public function boolean of_cancela_documento_aberto (long pl_tipo);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

If pl_Tipo = 79 Then //CNF
	ll_Retorno = iCNFCancelar_ECF_Daruma()
End If

If pl_Tipo = 80 Then //CCD
	ll_Retorno = iCCDFechar_ECF_Daruma()
End If

If pl_Tipo = 81 Then //RG
	ll_Retorno = iRGFechar_ECF_Daruma()
End If

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, True)
end function

public function boolean of_leitura_memoria_fiscal_reducao (long pl_reducao_inicial, long pl_reducao_final, boolean pb_arquivo, string ps_tipo);If This.ivb_Modo_Teste Then Return True

Boolean lvb_Sucesso
String ls_Arquivo
Long ll_Retorno

regAlterarValor_Daruma('Path', 'C:\')
regAlterarValor_Daruma('Beep', '1')  

If pb_arquivo Then
	ll_Retorno = iMFLerSerial_ECF_Daruma(String(pl_reducao_inicial,'0000'),String(pl_reducao_final,'0000'))	
Else
	ll_Retorno = iMFLer_ECF_Daruma(String(pl_reducao_inicial,'0000'),String(pl_reducao_final,'0000'))
End If

lvb_Sucesso = This.of_Verifica_Retorno_ECF(ll_Retorno, False)

Return lvb_Sucesso 
end function

public function boolean of_verifica_reducao_pendente ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

String	ls_Z

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	ls_Z = Space(1)	
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rVerificarReducaoZ_ECF_Daruma(ref ls_Z)
	ll_Tentativas++
Loop

If Trim(ls_Z) = '1' Then
	This.ivb_ReducaoZ_Pendente = True
Else
	This.ivb_ReducaoZ_Pendente = False
End If

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_totaliza_recebimento_nao_fiscal (string ps_pagamento, string ps_valor, string ps_texto);If This.ivb_Modo_Teste Then Return True

Long    ll_Retorno

ll_Retorno = iCNFTotalizarComprovante_ECF_Daruma('A$','0')

If This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
	ll_Retorno = iCNFEfetuarPagamentoFormatado_ECF_Daruma(ps_pagamento, ps_valor)
	
	If This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
		
		ll_Retorno = iCNFEncerrar_ECF_Daruma(ps_texto)
		
	End If
	
End If

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)

end function

public function boolean of_verifica_dlls ();Boolean lb_sucesso = true
String	ls_Path_dll = 'C:\sistemas\dll\daruma'
String ls_Path_Atu = 'c:\sistemas'
String ps_Baixar[]
String ps_Validar[]

ps_Validar = {"DarumaFrameWork.dlll", "LeituraMFDBin.dll", "lebin.dll"}
ps_Baixar  = {'DarumaFrameWork.zip'}

dc_uo_api lo_api
lo_api = Create dc_uo_api

If FileExists(ls_path_atu + "\DarumaFrameWork.dll")  And lb_Sucesso Then
	
	If Not FileExists(ls_Path_dll) Then
		lo_Api.of_Create_Directory(ls_Path_dll)
	End If	
	//Move para diretorio das dlls	
	If Not lo_api.of_move_file(ls_path_atu + '\DarumaFrameWork.dll', ls_Path_dll + '\DarumaFrameWork.dll', true, true) Then lb_Sucesso = False
	If Not lo_api.of_move_file(ls_path_atu + '\lebin.dll', ls_Path_dll + '\lebin.dll', true, true) Then lb_Sucesso = False
	If Not lo_api.of_move_file(ls_path_atu + '\LeituraMFDBin.dll', ls_Path_dll + '\LeituraMFDBin.dll', true, true) Then lb_Sucesso = False
	
End If
	
If Not FileExists(ls_path_dll + '\DarumaFrameWork.dll') Then											
	lb_Sucesso = gf_Download_Matriz(ps_Validar, ps_Baixar, ls_path_dll, "dll_daruma", True)
End If

destroy(lo_api)

Return lb_sucesso
end function

public function string of_centraliza_texto (string ps_texto);String ls_texto

ls_texto = Space(Int(COLUNAS - LenA(Trim(ps_texto)))/2) + Trim(ps_texto)
ls_texto = ls_texto + Space(COLUNAS - LenA(ls_texto))

Return ls_texto

end function

public function boolean of_programa_aliquota (boolean pb_automatico, decimal pdc_aliquota, long pl_tipo, boolean pb_mostra_mensagem);//Fun$$HEX2$$e700e300$$ENDHEX$$o para programar aliquotas na ECF - 18/02/2106
//pb_automatico - Se True $$HEX1$$e900$$ENDHEX$$ o processo automatico na abertura do sistema.
//pdc_aliquota $$HEX1$$e900$$ENDHEX$$ o precentual da aliquota a ser cadastrada.
//pl_tipo = 0 para ICMS e 1 para ISS
//A fun$$HEX2$$e700e300$$ENDHEX$$o antes verifica se a aliquota j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrada.

If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Pos
String ls_aliquota
String ls_aliquotas_cadastradas
Long ll_row
Decimal {2} ldc_pc_icms, ldc_pc_f

//Busca aliquotas cadastradas na ECF
ls_aliquotas_cadastradas = Space(150)

ll_Retorno = rLerAliquotas_ECF_Daruma(Ref ls_aliquotas_cadastradas)
	
If ll_Retorno = 1 Then
	If Not This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
		Return False
	End If
Else
	Return False
End If	

If pb_automatico Then
	For ll_row = 1 To PDV.ids_aliquotas.RowCount()
		If IsNull(PDV.ids_aliquotas.object.pc_icms [ll_row]) Then
			ldc_pc_icms = 0
		Else
			ldc_pc_icms = PDV.ids_aliquotas.object.pc_icms [ll_row]
		End If
		If IsNull(PDV.ids_aliquotas.object.pc_fcp [ll_row]) Then
			ldc_pc_f = 0
		Else
			ldc_pc_f = PDV.ids_aliquotas.object.pc_fcp [ll_row]
		End If 
		pdc_aliquota = ldc_pc_icms + ldc_pc_f		
		ls_aliquota = gf_replace(String(pdc_aliquota),',','',1)
		ls_aliquota = String(Long(ls_aliquota),'0000')
		If pl_tipo = 1 Then
			ls_aliquota = 'S' + ls_aliquota
		Else
			ls_aliquota = 'T' + ls_aliquota
		End If
		ll_Pos = PosA(ls_aliquotas_cadastradas, ls_aliquota)
		If ll_pos = 0 Then //N$$HEX1$$e300$$ENDHEX$$o econtrou, vai cadastrar.
			ll_Retorno = confCadastrar_ECF_Daruma( 'ALIQUOTA', ls_aliquota, '|' )
			
			If ll_Retorno = 1 Then
				If This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
					Continue
				Else
					Return False
				End If
			Else
				Return False
			End If		

		End If	
	Next
	Return True
Else			
	ls_aliquota = gf_replace(String(pdc_aliquota),',','',1)
	ls_aliquota = String(Long(ls_aliquota),'0000')
	If pl_tipo = 1 Then
		ls_aliquota = 'S' + ls_aliquota
	Else
		ls_aliquota = 'T' + ls_aliquota		
	End If	
	ll_Pos = PosA(ls_aliquotas_cadastradas, ls_aliquota)
	If ll_pos = 0 Then		
		ll_Retorno = confCadastrar_ECF_Daruma( 'ALIQUOTA', ls_aliquota, '|' )
		
		If ll_Retorno = 1 Then
			If This.of_Verifica_Retorno_Ecf(ll_Retorno, False) Then
				Return True
			Else
				Return False
			End If
		Else
			Return False
		End If		
	Else
		If pb_mostra_mensagem Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Aliquota informada j$$HEX1$$e100$$ENDHEX$$ existe na ECF.",Information!)
		End If
		Return False
	End If		

End If

Return False


end function

public function boolean of_cancela_item (long pl_item);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
String ls_item

ls_item = String(pl_item)

ll_Retorno = iCFCancelarItem_ECF_Daruma(ls_item)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function string of_normaliza_texto (string ps_texto);Long lvl_Char

String lvs_Ansi = ''
String lvs_Retorno = ''
String lvs_Char

/* Cria uma vari$$HEX1$$e100$$ENDHEX$$vel com os caracteres ANSI */
For lvl_Char = 1 To 255
	lvs_Ansi += String(CharA(lvl_Char))
Next

/* Verifica os caracteres e se eles existem no ANSI */
For lvl_Char = 1 To LenA(ps_texto)
	lvs_Char = Mid(ps_texto,lvl_Char,1)
	If Pos(lvs_Ansi,lvs_Char) > 0 Then
		lvs_Retorno += Mid(ps_texto,lvl_Char,1)
	End If
Next

Return lvs_Retorno
end function

public function boolean of_data_hora_ecf (ref datetime pdt_data);Date ld_DataEcf
String ls_Hora, ls_Data

If Not This.Of_HoraEcf(Ref ls_Hora)          Then Return False

If Not This.of_dataecf(Ref ld_dataecf)       Then Return False

ls_Data = String(ld_DataEcf)

pdt_Data = DateTime(Date(ls_Data),Time(ls_Hora))

Return True
end function

public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final, string ps_arquivo);
If This.ivb_Modo_Teste Then Return True

Boolean lb_Retorno

String ls_Versao
String ls_caminho = 'C:\Sistemas\RL\Arquivos\MFD\'
String ls_File
String ls_Tipo
String ls_Nome_Arquivo
String ls_Inicio
String ls_Final

Date ldh_Data

dc_uo_api lo_api
lo_api = Create dc_uo_api

lo_api.of_create_directory('C:\Sistemas\RL\Arquivos\MFD')

Destroy(lo_api)

ls_file = ls_caminho + ps_arquivo

FileDelete(ls_File)
FileDelete(ls_caminho + 'Espelho_MFD.txt')

regAlterarValor_Daruma( 'START\LocalArquivos', ls_caminho)
regAlterarValor_Daruma( 'START\LocalArquivosRelatorios', ls_caminho)

If ps_Tipo = "1" Then	
	ls_inicio = MidA(ps_inicio,1,2)+"/"+MidA(ps_inicio,3,2)+"/"+MidA(ps_inicio,5,4)
	ls_final = MidA(ps_Final,1,2)+"/"+MidA(ps_Final,3,2)+"/"+MidA(ps_final,5,4)
	ldh_Data = Date(ls_Inicio)
	ls_Inicio = String(ldh_Data,'DDMMYY')
	ldh_Data = Date(ls_Final)
	ls_Final = String(ldh_Data,'DDMMYY')
	
	lb_Retorno = This.of_Verifica_Retorno_ECF(rGerarEspelhoMFD_ECF_Daruma(ps_Tipo, ls_Inicio, ls_Final), False)	
Else
	
	lb_Retorno = This.of_Verifica_Retorno_ECF(rGerarEspelhoMFD_ECF_Daruma(ps_Tipo, RightA("000000" + ps_inicio, 6), RightA("000000" + ps_final, 6)), False)	
	
End If

If lb_Retorno Then

	dc_uo_api lvo_Api
	lvo_api = Create dc_uo_api
			
	If Not lvo_Api.of_Move_File(ls_caminho + 'Espelho_MFD.txt',ls_File,True) Then
		gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel mover arquivo espelho MFD para "+ls_File+", fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_leitura_memoria_fita_detalhe().")			
		lb_Retorno = False
	End If	
	
	Destroy(lvo_Api)

End If	

Return lb_Retorno

end function

public function boolean of_gera_arquivo_cotepe_mensal (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_dir_mfd, boolean pb_gera_mfd, ref boolean pb_mfd_gerado, string ps_inicio_mfd, string ps_fim_mfd);
If This.ivb_Modo_Teste Then Return True

Long ll_Row
Boolean lb_sucesso
String ls_arquivo_mfd
String ls_arquivo_mf

regAlterarValor_Daruma( 'START\LocalArquivos', ps_dir_mfd)
regAlterarValor_Daruma( 'START\LocalArquivosRelatorios', ps_dir_mfd)

ls_arquivo_mfd = 'Download.MFD'

//If pb_gera_mfd Then
//	Filedelete(ps_dir_mfd + ls_arquivo_mfd)	
//	//Gera MFD do perido total, para depois gerar somente dos meses, assim gero MFD uma vez s$$HEX1$$f300$$ENDHEX$$.
////	If Not This.of_Verifica_Retorno_ECF(rEfetuarDownloadMF_ECF_Daruma(ls_arquivo_mf),False)  Then
////		Return False
////	End If	
//	If Not This.of_Verifica_Retorno_ECF(rEfetuarDownloadMFD_ECF_Daruma('DATAM', ps_inicio_mfd, ps_fim_mfd,ls_arquivo_mfd),False)  Then
//		Return False
//	End If		
//	
//	pb_mfd_gerado = True
//Else
//	pb_mfd_gerado = True	
//End If

pb_mfd_gerado = True

//lb_sucesso = This.of_Verifica_Retorno_ECF(rGerarRelatorioOffline_ECF_Daruma('MFD','DATAM',ps_inicio,ps_final,'', ps_dir_mfd + ls_arquivo_mfd, ''),False)
lb_sucesso = This.of_Verifica_Retorno_ECF(rGerarRelatorio_ECF_Daruma('MFD','DATAM',ps_inicio,ps_final),False)

If lb_sucesso Then	
	If FileExists(ps_dir_mfd+'ATO_MFD_DATA.txt') Then
		FileCopy(ps_dir_mfd+'ATO_MFD_DATA.txt',ps_endereco,False)
		Filedelete(ps_dir_mfd+'ATO_MFD_DATA.txt')				
		Return True
	End If
End If
	
Return False
end function

public function boolean of_subtotal_cupom (ref string ps_subtotal);Long ll_Retorno
Long ll_Tentativas = 0

String ls_subtotal

ls_subtotal = Space(12)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = rCFSubTotal_ECF_Daruma(Ref ls_subtotal)
	ll_Tentativas++
Loop

ps_subtotal = Trim(ls_subtotal)

Return This.of_Verifica_Retorno_Ecf(ll_Retorno, False)
end function

public function boolean of_gera_arquivos_ecf (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_espelhos, long pl_tipo_geracao, string ps_dir_mfd, ref string ps_arquivo_gerado);
If This.ivb_Modo_Teste Then Return True

Long ll_Row
Boolean lb_sucesso
String ls_arquivo_mfd
String ls_arquivo_mf
String ls_tipo_geracao
String ls_tipo

regAlterarValor_Daruma( 'START\LocalArquivos', ps_dir_mfd)
regAlterarValor_Daruma( 'START\LocalArquivosRelatorios', ps_dir_mfd)

Choose Case pl_tipo_geracao
	Case 0
		ls_tipo_geracao = 'MF'
	Case 1
		ls_tipo_geracao = 'MFD'
	Case 3
		ls_tipo_geracao = 'TDM'
End Choose

Choose Case ps_tipo
	Case 'D'
		ls_tipo = 'DATAM'
	Case 'Z'
		ls_tipo = 'CRZ'
	Case 'C'
		ls_tipo = 'COO'
End Choose

ls_arquivo_mfd = 'Daruma.mfd'

lb_sucesso = This.of_Verifica_Retorno_ECF(rGerarRelatorio_ECF_Daruma(ls_tipo_geracao,ls_tipo,ps_inicio,ps_final),False)

If lb_sucesso Then	
	If FileExists(ps_dir_mfd+'ATO_TDM_DATA.txt') Then
		FileCopy(ps_dir_mfd+'ATO_TDM_DATA.txt',ps_endereco,False)
		Filedelete(ps_dir_mfd+'ATO_TDM_DATA.txt')
		ps_arquivo_gerado = ps_dir_mfd + ls_arquivo_mfd
		Return True
	End If
End If
	
Return False
end function

on uo_daruma.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_daruma.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Verifica_Drivers()

If Not of_Nr_Ecf(ref This.ecf) Then Return -1
end event

