HA$PBExportHeader$uo_sweda.sru
forward
global type uo_sweda from nonvisualobject
end type
end forward

global type uo_sweda from nonvisualobject
end type
global uo_sweda uo_sweda

type prototypes
// INICIO FUN$$HEX2$$c700d500$$ENDHEX$$ES NOVAS

Function Long ECF_AbrePortaSerial() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_AbreConnectC(Long Meio,String Caminho) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_AbreConnectC;Ansi";
Function Long ECF_LeituraMemoriaFiscalDataMFD(String DataInicial , String DataFinal , String FlagLeitura ) LIBRARY 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_LeituraMemoriaFiscalDataMFD;Ansi" ;
Function Long ECF_LeituraMemoriaFiscalReducaoMFD(String ReducaoInicial , String ReducaoFinal , String FlagLeitura ) LIBRARY 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_LeituraMemoriaFiscalReducaoMFD;Ansi" ;
Function Long ECF_LeituraMemoriaFiscalSerialDataMFD(String DataInicial , String DataFinal , String FlagLeitura ) LIBRARY 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_LeituraMemoriaFiscalSerialDataMFD;Ansi" ;
Function Long ECF_LeituraMemoriaFiscalSerialReducaoMFD(String ReducaoInicial , String ReducaoFinal , String FlagLeitura ) LIBRARY 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_LeituraMemoriaFiscalSerialReducaoMFD;Ansi" ;
Function Long ECF_Sangria(String Valor) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_Sangria;Ansi"; 
Function Long ECF_Suprimento(String Valor, String NomePagto) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_Suprimento;Ansi"; 
Function Long ECF_FechaPortaSerial() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_ReproduzirMemoriaFiscalMFD(String TipoDownload, String ParametroInicial , String ParametroFinal , String Arquivo , String LocalBin) LIBRARY "CONVECF.DLL" alias for "ECF_ReproduzirMemoriaFiscalMFD;Ansi" ;
Function Long ECF_DownloadMF(String Arquivo) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_DownloadMF;;Ansi"
//Function Long ECF_ApagaTabelaNomesNaoFiscais() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
//Function Long ECF_NomeiaTotalizadorNaoSujeitoIcms(Long Indice,String Totalizador) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for ECF_NomeiaTotalizadorNaoSujeitoIcms;
Function Long ECF_FechaComprovanteNaoFiscalVinculado() LIBRARY 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_FechaComprovanteNaoFiscalVinculado" ;
Function Long ECF_ConfiguraCodigoBarrasMFD(Long Altura, Long Largura, Long Posicao, Long Fonte, Long Margem) Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_CodigoBarrasCODABARMFD(String Codigo) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_CodigoBarrasCODABARMFD;Ansi";
Function Long ECF_CodigoBarrasCODE39MFD(String Codigo) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_CodigoBarrasCODE39MFD;Ansi";
Function Long ECF_CodigoBarrasEAN13MFD(String Codigo) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_CodigoBarrasEAN13MFD;Ansi";
Function Long ECF_CodigoBarrasEAN8MFD(String Codigo) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_CodigoBarrasEAN8MFD;Ansi";
Function Long ECF_CodigoBarrasITFMFD(String Codigo) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_CodigoBarrasITFMFD;Ansi";
Function Long ECF_CodigoBarrasUPCAMFD(String Codigo) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_CodigoBarrasUPCAMFD;Ansi";
Function Long ECF_CodigoBarrasUPCEMFD(String Codigo) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_CodigoBarrasUPCEMFD;Ansi";
Function Long ECF_RelatorioGerencial(String Codigo) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_RelatorioGerencial;Ansi";

// FIM FUN$$HEX2$$c700d500$$ENDHEX$$ES NOVAS

// INICIO FUN$$HEX2$$c700d500$$ENDHEX$$ES LIMA

Function Long ECF_AberturaDoDia(String Valor, String FormaPagamento) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_AberturaDoDia;Ansi"
Function Long ECF_GrandeTotal(Ref String GrandeTotal) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_GrandeTotal;Ansi"
Function Long ECF_CancelaCupomMFD(String CGC_CPF, String Nome, String Endereco) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_CancelaCupomMFD;Ansi"
Function Long ECF_CancelaItemAnterior() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_CancelaRecebimentoNaoFiscalMFD(String CNPJ, String Nome, String Endereco) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_CancelaRecebimentoNaoFiscalMFD;Ansi"
Function Long ECF_Registry_Log(String Valor) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_Registry_Log;Ansi"
Function Long ECF_HabilitaDesabilitaRetornoEstendidoMFD(String FlagRetorno) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_HabilitaDesabilitaRetornoEstendidoMFD;Ansi"
Function Long ECF_ContadorComprovantesCreditoMFD(Ref String Comprovantes) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_ContadorComprovantesCreditoMFD;Ansi"
Function Long ECF_ContadorCupomFiscalMFD(Ref String CuponsEmitidos) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_ContadorCupomFiscalMFD;Ansi"
Function Long ECF_NumeroOperacoesNaoFiscais(Ref String NumeroOperacoes) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_NumeroOperacoesNaoFiscais;Ansi"
Function Long ECF_ContadorRelatoriosGerenciaisMFD(Ref String Relatorios) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_ContadorRelatoriosGerenciaisMFD;Ansi"
Function Long ECF_NumeroCupom(Ref String NumeroCupom) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_NumeroCupom;Ansi"
Function Long ECF_DataHoraGravacaoUsuarioSWBasicoMFAdicional(Ref String DataUsuario, Ref String DataSWBasico, Ref String MFAdicional) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_DataHoraGravacaoUsuarioSWBasicoMFAdicional;Ansi"
Function Long ECF_DataHoraReducao(Ref String Data, Ref String Hora) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_DataHoraReducao;Ansi"
Function Long ECF_DataMovimentoUltimaReducaoMFD(Ref String Data) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_DataMovimentoUltimaReducaoMFD;Ansi"
Function Long ECF_DataHoraUltimoDocumentoMFD(Ref String cDataHora) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_DataHoraUltimoDocumentoMFD;Ansi"
Function Long ECF_DataHoraImpressora(Ref String Data, Ref String Hora) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_DataHoraImpressora;Ansi"
Function Long ECF_DataMovimento(Ref String Data) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_DataMovimento;Ansi"
Function Long ECF_IniciaFechamentoCupomMFD(String AcrescimoDesconto, String TipoAcrescimoDesconto, String ValorAcrescimo, String ValorDesconto) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_IniciaFechamentoCupomMFD;Ansi"
Function Long ECF_AcrescimoDescontoItemMFD(String Item, String AcrescimoDesconto, String TipoAcrescimoDesconto, String ValorAcrescimoDesconto) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_AcrescimoDescontoItemMFD;Ansi"
Function Long ECF_EfetuaRecebimentoNaoFiscalMFD(String IndiceTotalizador, String ValorRecebimento) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_EfetuaRecebimentoNaoFiscalMFD;Ansi"
Function Long ECF_AbreRelatorioGerencialMFD(String Indice) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_AbreRelatorioGerencialMFD;Ansi"
Function Long ECF_AbreRelatorioGerencial() Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_AbreRelatorioGerencial;Ansi"
Function Long ECF_FechaRelatorioGerencial() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_UsaRelatorioGerencialMFD(String Texto) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_UsaRelatorioGerencialMFD;Ansi"
Function Long ECF_TerminaFechamentoCupom(String Mensagem) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_TerminaFechamentoCupom;Ansi"
Function Long ECF_FechaRecebimentoNaoFiscalMFD(String Mensagem) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_FechaRecebimentoNaoFiscalMFD;Ansi"
Function Long ECF_GeraRegistrosCAT52MFD(String ArquivoMFD, String cDataMovimento) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_GeraRegistrosCAT52MFD;Ansi"
Function Long ECF_InicioFimGTsMFD(Ref String Inicial, Ref String Final) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_InicioFimGTsMFD;Ansi"
Function Long ECF_InicioFimCOOsMFD(Ref String Inicial, Ref String Final) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_InicioFimCOOsMFD;Ansi"
Function Long ECF_FlagsFiscaisStr(Ref String Flag) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_FlagsFiscaisStr;Ansi"
Function Long ECF_ProgramaHorarioVerao() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_VerificaImpressoraLigada() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_AbreRecebimentoNaoFiscalMFD(String CNPJ, String Nome, String Endereco) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_AbreRecebimentoNaoFiscalMFD;Ansi"
Function Long ECF_VendeItemDepartamento(String Codigo, String Descricao, String Aliquota, String ValorUnit, String Quantidade, String Acrescimo, String Desconto, String IndiceDepartamento, String UnidadeMedida) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_VendeItemDepartamento;Ansi"
Function Long ECF_Sangria() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_RetornoImpressoraMFD(Ref Long ACK, Ref Long ST1, Ref Long ST2, Ref Long ST3)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_RetornoImpressoraMFD;Ansi"
Function Long ECF_StatusEstendidoMFD(Ref Integer Status)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_StatusEstendidoMFD;Ansi"
Function Long ECF_UsaComprovanteNaoFiscalVinculado(String Texto)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_UsaComprovanteNaoFiscalVinculado;Ansi"
Function Long ECF_EfetuaFormaPagamentoIndice(String FormaPagamento, String ValorFormaPagamento)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_EfetuaFormaPagamentoIndice;Ansi"
Function Long ECF_SubTotalizaRecebimentoMFD() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_TotalizaRecebimentoMFD() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_ValorPagoUltimoCupom(Ref String ValorCupom)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_ValorPagoUltimoCupom;Ansi"
Function Long ECF_VendaBruta(Ref String Valor)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_VendaBruta;Ansi"
Function Long ECF_VerificaFormasPagamento(Ref String Formas)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_VerificaFormasPagamento;Ansi"
Function Long ECF_NumeroSerieMFD(Ref String NumeroSerie)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_NumeroSerieMFD;Ansi"
Function Long ECF_VersaoDll(Ref String Versao)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_VersaoDll;Ansi"
Function Long ECF_VersaoFirmwareMFD(Ref String VersaoFirmware)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_VersaoFirmwareMFD;Ansi"
Function Long ECF_MarcaModeloTipoImpressoraMFD(Ref String Marca, Ref String Modelo, Ref String Tipo)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_MarcaModeloTipoImpressoraMFD;Ansi"
Function Long ECF_NumeroCaixa(Ref String NumeroCaixa)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_NumeroCaixa;Ansi"
Function Long ECF_StatusCupomFiscal(Ref String Info)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_StatusCupomFiscal;Ansi"
Function Long ECF_AbreCupomMFD(String CGC, String Nome, String Endereco)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_AbreCupomMFD;Ansi"
Function Long ECF_AbreComprovanteNaoFiscalVinculado(String FormaPagamento, String Valor, String NumeroCupom)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_AbreComprovanteNaoFiscalVinculado;Ansi"
Function Long ECF_LeituraXSerial() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_LeituraX() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_PercentualLivreMFD(Ref String MemoriaLivre)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_PercentualLivreMFD;Ansi"
Function Long ECF_ReducaoZ(String Data, String Hora)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_ReducaoZ;Ansi"
Function Long ECF_DadosUltimaReducaoMFD(Ref String DadosReducao)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_DadosUltimaReducaoMFD;Ansi"
Function Long ECF_DadosUltimaReducao(Ref String DadosReducao)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_DadosUltimaReducao;Ansi"
Function Long ECF_AcionaGaveta() Library 'C:\sistemas\dll\sweda\CONVECF.dll';
Function Long ECF_Registry_RFD(Ref String Valor)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_Registry_RFD;Ansi"
Function Long ECF_FormatoDadosMFD(String ArquivoOrigem, String ArquivoDestino, String TipoFormato, String TipoDownload, String ParametroInicial, String ParametroFinal, String UsuarioECF)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_FormatoDadosMFD;Ansi"
Function Long ECF_DownloadMFD(String Arquivo, String TipoDownload, String ParametroInicial, String ParametroFinal, String UsuarioECF)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_DownloadMFD;Ansi"
Function Long ECF_RecebimentoNaoFiscal(String IndiceTotalizador, String Valor, String FormaPagamento)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_RecebimentoNaoFiscal;Ansi"
Function Long ECF_GeraRegistrosCAT52MFDEx(String ArquivoMFD, String cDataMovimento, String ArquivoDestino)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_GeraRegistrosCAT52MFDEx;Ansi"
Function Long ECF_ProgramaAliquota(String Aliquota, Long Vinculo)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_ProgramaAliquota;Ansi"
Function Long ECF_RetornoAliquotas(Ref String Aliquotas)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_RetornoAliquotas;Ansi"
Function Long ECF_CancelaItemGenerico(String Item)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_CancelaItemGenerico;Ansi"
Function Long ECF_StatusComprovanteNaoFiscalVinculado(Ref String Info)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_StatusComprovanteNaoFiscalVinculado;Ansi"
Function Long ECF_StatusComprovanteNaoFiscalNaoVinculado(Ref String Info)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_StatusComprovanteNaoFiscalNaoVinculado;Ansi"
Function Long ECF_StatusRelatorioGerencial(Ref String Info)Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_StatusRelatorioGerencial;Ansi"
Function Long ECF_SubTotal(Ref String SubTotalCupom) Library 'C:\sistemas\dll\sweda\CONVECF.dll' alias for "ECF_SubTotal;Ansi"

// FIM FUN$$HEX2$$c700d500$$ENDHEX$$ES LIMA

end prototypes

type variables
CONSTANT INTEGER COLUNAS = 48

BOOLEAN ivb_cancelar        = FALSE
BOOLEAN ivb_showerror      = TRUE
BOOLEAN ivb_gaveta          =  FALSE
BOOLEAN ivb_modo_teste   = FALSE
BOOLEAN ivb_porta_aberta = FALSE
BOOLEAN ivb_Ativa        = True
BOOLEAN ivb_Cadastrada   = FALSE
BOOLEAN ivb_Cod_Barras	 = FALSE
BOOLEAN ivb_ReducaoZ		= FALSE

LONG ECF
LONG Porta
LONG Timeout
LONG Log

STRING ivs_status

STRING ivs_Path_Log
STRING ivs_Versao

STRING Modelo
STRING nr_Serie
STRING de_Marca
STRING de_Tipo
STRING nr_versao_swbasico
STRING Id_Situacao
STRING ivs_Cod_Barras
STRING ivs_grava_log

STRING Id_MFAdicional

LONG Ack
LONG St1
LONG St2
LONG St3

DATETIME dh_ultima_venda
DATETIME dh_SWBasico

DECIMAL pc_livre_mfd
end variables

forward prototypes
public function boolean of_desconto_cupom (string ps_texto, decimal pd_valor)
public subroutine of_msg_impressoraoffline ()
public function boolean of_pergunta_impressoraoffline ()
public function boolean of_pergunta_leiturax ()
public function boolean of_pergunta_reducaoz ()
public function boolean of_reducaoz ()
public function boolean of_pergunta_posiciona_cheque ()
public function integer of_statusok ()
public subroutine of_sleep (long pl_segundos)
public function boolean of_verifica_data_movimentacao ()
public function boolean of_dataecf (ref date pd_dataecf)
public function string of_converte_indicador (string ps_indicador)
public function boolean of_pergunta_cancelacupom ()
public function boolean of_horaecf (ref string ps_hora)
public function boolean of_nr_ecf (ref long pl_ecf)
public function boolean of_texto_nao_fiscal_tef (string ps_texto)
public function boolean of_fecha_comprovante_tef ()
public function boolean of_pergunta_folha_solta ()
public function boolean of_pergunta_deseja_imprimir_cheque ()
public function boolean of_pergunta_falta_papel ()
public function boolean of_verifica_cupons_pendentes ()
public subroutine of_msg_cupom_aberto_gravado ()
public subroutine of_msg_cupom_aberto ()
public subroutine of_msg_cancelamento_invalido ()
public function boolean of_leitura_totais (integer pi_tipo)
public function boolean of_configuracoes ()
public function boolean of_aguarda_execucao_comando_tef ()
public function boolean of_datafiscal (ref date pd_datafiscal)
public function boolean of_mapa_resumo (ref s_ge039_mapa_resumo ps_mapa_resumo)
public function integer of_controle_caixa_conferido (long pl_ecf, long pl_seq)
public function boolean of_cupom_gravado (long pl_ecf, long pl_seq)
public function datetime of_dh_movimentacao ()
public function boolean of_fecha_cupom_nao_fiscal (string ps_vinculado)
public function boolean of_fecha_cupom_nao_fiscal ()
public function string of_indicador_aliquota (decimal pd_aliquota, string ps_tributacao_icms)
public function boolean of_verifica_drivers ()
public function boolean of_path_log (string ps_path_log)
public function boolean of_cancela_item (integer pl_item)
public function boolean of_aguarda_execucao ()
public function boolean of_dados_impressora (ref long pl_sequencial, ref long pl_ecf)
public function boolean of_verifica_venda_bruta_diaria ()
public function boolean of_horario_verao_parametros (ref date adt_inicio, ref date adt_termino)
public function boolean of_horario_verao_ajuste (string ps_modo)
public function string of_encripta (string ps_texto)
public function string of_desencripta (string ps_texto)
public function boolean of_inicializa_comprovante_tef_nao_fiscal (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor)
public function boolean of_registra_cancelamento (long pl_ecf, long pl_seq)
public function boolean of_horario_verao ()
public function boolean of_marca_modelo ()
public function long of_status_ecf ()
public function boolean of_verifica_ultimo_mapa_resumo ()
public function boolean of_desconto_item (long pl_item, decimal pd_desconto, decimal pd_valor)
public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final)
public function boolean of_porta_comunicacao ()
public subroutine of_grava_logerro (string ps_comando)
public function boolean of_cancela_cupom (long pl_ecf, long pl_seq)
public function boolean of_timeout_ecf ()
public function boolean of_numero_serie ()
public function boolean of_permite_cancelamento_cupom ()
public function boolean of_verifica_problemas_impressora ()
public function boolean of_atualiza_data_fiscal ()
public function boolean of_leiturax (boolean pb_arquivo)
public function boolean of_leitura_memoria_fiscal (string ps_data_de, string ps_data_ate, boolean pb_arquivo, string ps_tipo)
public function boolean of_conecta_impressora ()
public subroutine of_fechaporta ()
public function boolean of_leitura_memoria_fiscal_reducao (long pl_reducao_inicial, long pl_reducao_final, boolean pb_arquivo, string ps_tipo)
public function boolean of_totaliza_cupom (string ps_tipo[], decimal pd_valor[])
public function boolean of_abreporta ()
public function boolean of_suprimento_caixa (decimal pdc_valor)
public function boolean of_sangria_caixa (decimal pdc_valor)
public function boolean of_leitura_memoria_fiscal_ac1704 (string ps_dado_inicio, string ps_dado_final)
public function boolean of_abre_gaveta ()
public function boolean of_fecha_cupom (string ps_msg[], boolean pb_repete, string ps_indicadores[6, 2], string ps_vinculado)
public function boolean of_atualiza_cadastro_ecf ()
public function boolean of_data_hora_ecf (ref datetime pdt_data)
public function boolean of_atualiza_drivers ()
public function boolean of_codigo_barras (integer pl_tipo, string ps_codigo, string ps_tamanho)
public function boolean of_fecha_comprovante_nao_finalizado ()
public function boolean of_inicializa_comprovante_nao_fiscal (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor)
public function boolean of_inicializa_cupom (string ps_cpf_cgc)
public function boolean of_abertura_dia ()
public function boolean of_atualiza_numero_seriemfd ()
public function boolean of_grande_total (ref decimal pdc_venda)
public function boolean of_carrega_dados_ecf (long pl_ecf)
public function boolean of_contador_credito_debito (ref long pl_contador)
public function boolean of_contador_cupom_fiscal (ref long pl_contador)
public function boolean of_contador_operacao_nao_fiscal (ref long pl_contador)
public function boolean of_contador_relatorio_gerencial (ref long pl_contador)
public function boolean of_nr_cupom (ref long pl_sequencial)
public function boolean of_data_hora_usuario_software_basico ()
public function boolean of_data_ultima_reducaoz (ref date pd_datafiscal)
public function boolean of_data_ultimo_documento_fiscal (ref datetime pd_datahora)
public function boolean of_efetua_recebimento_nao_fiscal (string ps_tipo, string ps_valor)
public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor)
public subroutine of_status_extendido_ecf ()
public function boolean of_inicializa_relatorio_gerencial (string ps_relatorio, decimal pdc_valor)
public function boolean of_pergunta_tentativa (boolean pvb_abrindo)
public function boolean of_fecha_relatorio_gerencial ()
public function boolean of_imprime_relatorio_gerencial (string ps_texto[], string ps_tipo)
public function boolean of_cancela_recebimento_nao_fiscal ()
public function boolean of_flags_st1 ()
public function boolean of_flags_st2 ()
public function boolean of_gera_arquivo_cat52 (string ps_arquivo, date pdh_data_fiscal)
public function boolean of_grava_mapa_resumo (date pdh_data)
public function boolean of_gt_inicial_final (ref decimal pdc_inicial, ref decimal pdc_final)
public function boolean of_verifica_status_horario_verao (ref string ps_status)
public function boolean of_verifica_flags_fiscais ()
public function boolean of_programa_horario_verao ()
public function boolean of_impressora_online ()
public function string of_meio_pagamento (string ps_pagamento)
public function boolean of_inicializa_recebimento_nao_fiscal ()
public function boolean of_registra_documento_ecf (string ps_documento)
public function boolean of_registra_documento_ecf (string ps_documento, string ps_totalizador, decimal pdc_valor)
public function boolean of_registra_documento_ecf (string ps_documento, decimal pdc_valor)
public function boolean of_registra_item_vendido (string ps_produto, long pd_qtd, decimal pd_precounitario, decimal pd_pretototal, string ps_descricao, decimal pd_aliquota, string ps_complemento, string ps_tributacao_icms, string ps_un)
public function string of_status_st3 ()
public function boolean of_texto_relatorio_gerencial (string ps_texto)
public function boolean of_totaliza_recebimento_nao_fiscal (string ps_pagamento, string ps_valor)
public function boolean of_valor_pago_ultimo_cupom (decimal pdc_valor)
public function boolean of_venda_bruta (ref decimal pdc_venda)
public function boolean of_verifica_forma_pagamento (ref string ps_formapagto[])
public function boolean of_verifica_versao_dll ()
public function boolean of_verifica_versao_software_basico ()
public function boolean of_atualiza_venda_bruta ()
public function boolean of_inicializa_comprovante_tef (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor, string ps_cupom)
public function boolean of_percentual_livre_mfd ()
public function boolean of_grava_log_ecf ()
public function boolean of_recebimento_nao_fiscal (string ps_tipo, string ps_valor)
public function boolean of_capturar_md5 (string ps_arquivo, ref string ps_md5)
public function boolean of_gera_arquivo_cat52 (string ps_arquivo, date pdh_data_fiscal, ref string ps_arquivo_destino)
protected function boolean of_assinatura_digital (string ps_arquivo)
public function boolean of_gera_arquivo_cotepe1704 (string ps_tipo, string ps_inicio, string ps_final)
public function boolean of_data_movimento_ultima_reducao (ref date pd_datafiscal)
public function boolean of_coo_inicial_final (ref long pl_inicial, ref long pl_final)
public function boolean of_abre_porta_serial ()
public function boolean of_fecha_recebimento_nao_fiscal (string ps_texto)
public function string of_centraliza_texto (string ps_texto)
public function boolean of_programa_aliquota (boolean pb_automatico, decimal pdc_aliquota, long pl_tipo, boolean pb_mostra_mensagem)
public function boolean of_cancela_item_anterior ()
public function long of_verifica_retorno_ecf (long pl_retorno, string ps_funcao)
public function string of_normaliza_texto (string ps_texto)
public function long of_verifica_retorno_ecf_mfd (long pl_retorno, string ps_funcao)
public function boolean of_retorna_doc_aberto (ref long pl_doc)
public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final, string ps_arquivo)
public function boolean of_gera_arquivo_mfd (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_caminho_mfd)
public function boolean of_gera_arquivo_cotepe_mensal (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_dir_mfd, boolean pb_gera_mfd, ref boolean pb_mfd_gerado)
public function boolean of_subtotal_cupom (ref string ps_subtotal)
public function boolean of_gera_arquivos_ecf (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_espelhos, long pl_tipo_geracao, string ps_dir_mfd, ref string ps_arquivo_gerado)
end prototypes

public function boolean of_desconto_cupom (string ps_texto, decimal pd_valor);If This.ivb_Modo_Teste Then Return True

String ls_valor

Long ll_Retry
Long ll_Retorno

ls_valor = String(pd_valor)

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_IniciaFechamentoCupomMFD("D","$","0,00",ls_valor),'ECF_IniciaFechamentoCupomMFD')
	
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

public subroutine of_msg_impressoraoffline ();//
Messagebox("Impressora Fiscal","Verifique se a impressora "+&
           "fiscal est$$HEX1$$e100$$ENDHEX$$ ligada e se os cabos est$$HEX1$$e300$$ENDHEX$$o corretamente "+&
   		  "conectados.", StopSign!)
//
end subroutine

public function boolean of_pergunta_impressoraoffline ();Long  lvl_resp

lvl_resp = Messagebox("Impressora Fiscal","Verifique se a impressora "+&
                      "fiscal est$$HEX1$$e100$$ENDHEX$$ ligada e se os cabos est$$HEX1$$e300$$ENDHEX$$o corretamente "+&
					  	    "conectados.Tentar novamente ?", Question!,YesNo!,1)

If lvl_resp = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_pergunta_leiturax ();Long  lvl_resp

lvl_resp = messagebox("Impressora Fiscal","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a Leitura X da Impressora Fiscal. Confirma Leitura X ?",Question!,YesNo!,1)

If lvl_resp = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_pergunta_reducaoz ();Long  lvl_resp

lvl_resp = messagebox("Impressora Fiscal","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a Redu$$HEX2$$e700e300$$ENDHEX$$o Z da Impressora Fiscal. Confirma Redu$$HEX2$$e700e300$$ENDHEX$$o Z ?",Question!,YesNo!,1)
If lvl_resp = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_reducaoz ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Ecf

String ls_data
String ls_hora
String ls_Arquivo

Date ldt_DataFiscal
Date ldt_ReducaoZ
DateTime ldt_ultima_venda

Boolean lb_sucesso
Boolean lb_blocox

ls_data = String(Day(Today()),'00')+"/"+String(Month(Today()),'00')+"/"+RightA(String(Year(Today()),'0000'),2)
ls_hora = String(Now(),"hh:mm:ss")

uo_Menu_Fiscal lvo_Menu

SetPointer(HourGlass!)

If Not of_Nr_Ecf(ref ll_Ecf) Then Return False

If Not This.of_Numero_Serie() Then Return False

If Not This.of_Marca_Modelo()		Then Return False

If Not This.of_Percentual_Livre_MFD()	Then Return False

If Not of_DataFiscal(Ref ldt_DataFiscal) Then Return False

If Not of_Data_Ultima_ReducaoZ(Ref ldt_ReducaoZ) Then	Return False

If ldt_DataFiscal = Date("1900/01/01") Then
	
	This.of_Abertura_Dia()
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","ECF est$$HEX1$$e100$$ENDHEX$$ sem movimenta$$HEX2$$e700e300$$ENDHEX$$o desde a $$HEX1$$fa00$$ENDHEX$$ltima Redu$$HEX2$$e700e300$$ENDHEX$$o Z.~r~r" + &
						 		"N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio efetu$$HEX1$$e100$$ENDHEX$$-la.~r~r"+&
						 		"Data $$HEX1$$da00$$ENDHEX$$ltima Redu$$HEX2$$e700e300$$ENDHEX$$o Z " + String(ldt_ReducaoZ),Exclamation!)
	
	Return True
	
Else
	
	If Not of_verifica_cupons_pendentes() Then Return False
	
	ls_data = String(Today(), "ddmmyy")
	ls_hora = String(Now(),"hhmmss")
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ReducaoZ(ls_data, ls_hora),'ECF_ReducaoZ')
	If ll_Retorno = 1 Then
		If Not pdv.of_verifica_aliquotas() Then //Busca as aliquotas no banco e se necess$$HEX1$$e100$$ENDHEX$$rio inclui na ECF.
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Problemas na verifica$$HEX2$$e700e300$$ENDHEX$$o de aliquotas da ECF.")
		End If		
		
//		This.of_Horario_Verao()
//		This.of_Abertura_Dia()
	Else
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Erro no retorno: " + String(ll_Retorno) + " ECF: " + String(This.ECF) + " ao gravar Mapa Resumo.")
	End If
	
	This.of_Data_Hora_Usuario_Software_Basico()

	This.of_Verifica_Versao_Software_Basico()
	
	This.of_Atualiza_Numero_Seriemfd()
		
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

PDV.of_gera_espelho_mfd_mensal(ll_ECF, ldt_DataFiscal)

PDV.of_gera_cotepe_mensal(ll_ECF, ldt_DataFiscal)

If lb_sucesso Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Mapa Resumo gravado com sucesso !")

SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o

If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI,"Desenvolvimento","Homologacao","") = "S" Then

	lvo_Menu = Create uo_Menu_Fiscal
	
	PDV.of_data_ultima_venda_sistema(ldt_ultima_venda)
	
	If Not lvo_Menu.of_Gera_Movimento_pafecf(Ref ls_Arquivo,PDV.ecf, ldt_DataFiscal, ldt_DataFiscal, Date(ldt_ultima_venda)) Then Return False
	
	If Not lvo_Menu.of_Assinatura_Digital(ls_Arquivo) Then Return False
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Arquivo + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
		Run('Notepad.exe ' + ls_Arquivo )
	End If
	
	Destroy(lvo_Menu)
	
End If

Return True
end function

public function boolean of_pergunta_posiciona_cheque ();Long  lvl_resp

lvl_resp = Messagebox("Impressora Fiscal","Insira o cheque para impress$$HEX1$$e300$$ENDHEX$$o e posicione-o corretamente. Tentar novamente ?",Question!,YesNo!,1)

If lvl_resp = 1 Then
	Return True
Else
	Return False
End If
end function

public function integer of_statusok ();If ivs_status = ".-P006}" Then
	Return 1
ElseIf ivs_status = ".-P002}" THEN
	Return 2
ElseIf LeftA(ivs_status,6) = ".-P555" OR LeftA(ivs_status,6) = ".-P550" THEN
	Return 3
End If

Return 0
end function

public subroutine of_sleep (long pl_segundos);Time	lvt_inicio

lvt_inicio = Now()

Do While True
	If SecondsAfter(lvt_inicio , Now()) >= pl_segundos Then
		Exit
	End If
Loop
end subroutine

public function boolean of_verifica_data_movimentacao ();Date   ldt_datafiscal
Date   ldt_dataecf
Date   ldt_dataReducaoZ
Date   ldt_movimento

String ls_DataMovimento

ldt_movimento = Date(PDV.of_dh_movimentacao())

If Not of_DataFiscal(Ref ldt_DataFiscal) 		     Then Return False

If Not of_DataEcf(Ref ldt_dataecf)       			     Then Return False

If Not of_Data_Ultima_ReducaoZ(Ref ldt_dataReducaoZ) Then Return False

If ldt_movimento = ldt_dataecf and ldt_movimento = ldt_DataFiscal Then Return True

If ldt_datafiscal = Date( '1900/01/01' ) Then
	If This.of_Suprimento_Caixa( 0.01 ) Then
		Return This.of_Verifica_Data_Movimentacao( )	
	Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Impressora Fiscal Bloqueada. Redu$$HEX2$$e700e300$$ENDHEX$$o Z j$$HEX1$$e100$$ENDHEX$$ efetuada.", StopSign! )
		Return False
	End If
End If

IF ldt_datafiscal > ldt_movimento Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","ECF:" + String(This.Ecf,'000') + "~r~r"+&
								"J$$HEX1$$e100$$ENDHEX$$ foi feito a redu$$HEX2$$e700e300$$ENDHEX$$o Z na impressora fiscal. Para continuar as vendas "+ &
						      "ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer o fechamento di$$HEX1$$e100$$ENDHEX$$rio.~r~r"+& 
								"Data Fiscal ECF: " + String(ldt_datafiscal)+"~r~r"+&
								"Data Movimento : " + String(ldt_movimento), Exclamation!)
	RETURN FALSE						 
ELSEIF ldt_datafiscal < ldt_movimento THEN
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","ECF:" + String(This.Ecf,'000') + "~r~r"+&
								"J$$HEX1$$e100$$ENDHEX$$ foi feito o fechamento di$$HEX1$$e100$$ENDHEX$$rio. Para continuar as vendas "+ &
						      "ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a redu$$HEX2$$e700e300$$ENDHEX$$o Z ou atualizar a data fiscal.~r~r"+&
								"Data Fiscal ECF: " + String(ldt_datafiscal)+"~r~r"+&
								"Data Movimento : " + String(ldt_movimento), Exclamation!)
								
	RETURN FALSE
End If

Return True
end function

public function boolean of_dataecf (ref date pd_dataecf);If This.ivb_Modo_Teste Then Return True

String ls_Data
String ls_Hora
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Data = Space(06)
ls_Hora = Space(06)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DataHoraImpressora(Ref ls_Data, Ref ls_Hora),'ECF_DataHoraImpressora')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

If lb_Sucesso Then

	If Long(MidA(ls_Data,5,2)) <= 60 Then
		ls_Ano = '20'
	Else
		ls_Ano = '19'
	End If
	
	ls_Data = MidA(ls_Data,1,2)+"/"+MidA(ls_Data,3,2)+"/"+ls_Ano+MidA(ls_Data,5,2)
	
	pd_dataecf = Date(ls_Data)

End If

Return lb_Sucesso
end function

public function string of_converte_indicador (string ps_indicador);String lvs_Indicador

Choose Case Upper(ps_indicador)
	Case "OPERADOR"   	; lvs_Indicador = "01"
	Case "LOJA"       		; lvs_Indicador = "04"	
	Case "VENDEDOR"   	; lvs_Indicador = "05"
	Case "CAIXA"      		; lvs_Indicador = "11"
	Case "ENTREGADOR"	; lvs_Indicador = "16"
	Case "FUNC"       		; lvs_Indicador = "24"
	Case "CARTAO"     	; lvs_Indicador = "32"	
	Case "DOC"        		; lvs_Indicador = "29"	
End Choose

Return lvs_Indicador
end function

public function boolean of_pergunta_cancelacupom ();Long  lvl_resp

lvl_resp = messagebox("Impressora Fiscal","Deseja cancelar cupom fiscal ?",Question!,YesNo!,2)
										  
If lvl_resp = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_horaecf (ref string ps_hora);If This.ivb_Modo_Teste Then Return True

String ls_Data
String ls_Hora
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Data = Space(06)
ls_Hora = Space(06)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DataHoraImpressora(Ref ls_Data, Ref ls_Hora),'ECF_DataHoraImpressora')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

If lb_Sucesso Then

	ps_hora = MidA(ls_Hora,1,2)+":"+MidA(ls_Hora,3,2)+":"+MidA(ls_Hora,5,2)

End If

Return lb_Sucesso
end function

public function boolean of_nr_ecf (ref long pl_ecf);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Caixa
String ls_Cupom

SetPointer(HourGlass!)

ls_Caixa = Space(4)

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_NumeroCaixa(Ref ls_Caixa),'ECF_NumeroCaixa')
	
	pl_ecf = Long(ls_Caixa)
		
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_texto_nao_fiscal_tef (string ps_texto);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_St1

Do While ll_Retry <= 3
	
	If PosA( Upper( SqlCa.SqlReturnData ) , 'POSTGRESQL' ) = 0 Then				
		ps_texto = CharA(16) + CharA(67) + ps_texto + CharA(13) + CharA(10)
	Else
		ps_texto = CharA(16) + CharA(67) + ps_texto
	End If
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_UsaComprovanteNaoFiscalVinculado(ps_texto),'ECF_UsaComprovanteNaoFiscalVinculado')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			If of_Status_ECF() = -1 Then Return False
			
			If (This.St1 = 0) Or (This.St1 = 64) Then					
				Return True
			Else
				ll_st1 = This.St1
				
				If ll_St1 >= 128 Then                 // sem papel
					Return False
				End If
			End If		
//			Return True						
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False

end function

public function boolean of_fecha_comprovante_tef ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_FechaComprovanteNaoFiscalVinculado(),'ECF_FechaComprovanteNaoFiscalVinculado')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100				// Impressora ocupada
			Continue
		Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			
			If This.st3 = 33 Then Return This.of_cancela_recebimento_nao_fiscal()
		
			Return False
			
	End Choose
	
	ll_Retry ++

Loop

Return False


end function

public function boolean of_pergunta_folha_solta ();Long  lvl_Resposta

lvl_Resposta = Messagebox("Impressora Fiscal","H$$HEX1$$e100$$ENDHEX$$ folha solta na Impressora Fiscal.Tentar novamente ?",Question!,YesNo!,1)

If lvl_Resposta = 1 Then Return True

Return False
end function

public function boolean of_pergunta_deseja_imprimir_cheque ();Long  lvl_Resposta

lvl_Resposta = Messagebox("Impressora Fiscal","Deseja Imprimir Cheque ?",Question!,YesNo!)

If lvl_Resposta = 1 Then Return True

Return False
end function

public function boolean of_pergunta_falta_papel ();Long  lvl_Resposta

lvl_Resposta = Messagebox("Impressora Fiscal","Falta de papel ou t$$HEX1$$e900$$ENDHEX$$rmino de bobina detectado. A troca j$$HEX1$$e100$$ENDHEX$$ foi efetuada ?",Question!,YesNo!,1)

If lvl_Resposta = 1 Then Return True

Return False
end function

public function boolean of_verifica_cupons_pendentes ();If This.ivb_Modo_Teste Then Return True

Boolean lb_Sucesso

Long ll_Retorno

String ls_Status

ls_Status = Space(2)

ll_Retorno = This.of_Verifica_Retorno_Ecf(ECF_StatusCupomFiscal(ref ls_Status),'ECF_StatusCupomFiscal')

If Long(ls_Status) = 1 Then
	
	PDV.Of_msg_Cupom_Aberto()
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("CANCELAMENTO_CUPOM_FISCAL", PDV.ivs_Matricula_Cancelamento_Venda) Then Return False

	If Not PDV.of_cancela_ultimo_cupom(False) Then Return False	

	Return True
	
End If		

Return True
end function

public subroutine of_msg_cupom_aberto_gravado ();//
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","                               CUPOM FISCAL N$$HEX1$$c300$$ENDHEX$$O ENCERRADO~r~r" + &
							"O $$HEX1$$da00$$ENDHEX$$ltimo cupom fiscal impresso n$$HEX1$$e300$$ENDHEX$$o foi finalizado corretamente. " + &
							"Este cupom j$$HEX1$$e100$$ENDHEX$$ se encontra cadastrado no sistema. Utilize a tecla [F12] " + &
							"para efetuar o cancelamento deste cupom. ",Exclamation!)

end subroutine

public subroutine of_msg_cupom_aberto ();//
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","                               CUPOM FISCAL N$$HEX1$$c300$$ENDHEX$$O ENCERRADO~r~r" + &
										"O $$HEX1$$da00$$ENDHEX$$ltimo cupom fiscal impresso n$$HEX1$$e300$$ENDHEX$$o foi finalizado corretamente. " + &
										"O Sistema ir$$HEX1$$e100$$ENDHEX$$ cancel$$HEX1$$e100$$ENDHEX$$-lo automaticamente na impressora fiscal.",Information!)
end subroutine

public subroutine of_msg_cancelamento_invalido ();//
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","                               CANCELAMENTO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO~r~r" + &
							"Este cupom j$$HEX1$$e100$$ENDHEX$$ se encontra cadastrado no sistema. Utilize a tecla [F12] " + &
							"no sistema de caixa para efetuar o cancelamento deste cupom. ",Exclamation!)

end subroutine

public function boolean of_leitura_totais (integer pi_tipo);Return True
end function

public function boolean of_configuracoes ();If This.ivb_Modo_Teste Then Return True

//Impressora j$$HEX1$$e100$$ENDHEX$$ foi configurada
If This.ECF > 0 Then Return True

If This.of_Verifica_Retorno_ECF(ECF_HabilitaDesabilitaRetornoEstendidoMFD("1"),'ECF_HabilitaDesabilitaRetornoEstendidoMFD') <> 1 Then Return False

Return True
end function

public function boolean of_aguarda_execucao_comando_tef ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While True
	
    ll_Retorno = This.of_Status_ECF()

	If This.ST3 = 9 Then Continue // ECF Ocupado
	
	Exit

Loop

Return True
end function

public function boolean of_datafiscal (ref date pd_datafiscal);If This.ivb_Modo_Teste Then Return True

String ls_DataMovimento
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_DataMovimento = Space(6)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DataMovimento(Ref ls_DataMovimento),'ECF_DataMovimento')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

If lb_Sucesso Then

	If Long(MidA(ls_DataMovimento,5,2)) <= 60 Then
		ls_Ano = '20'
	Else
		ls_Ano = '19'
	End If
	
	ls_DataMovimento = MidA(ls_DataMovimento,1,2)+"/"+MidA(ls_DataMovimento,3,2)+"/"+ls_Ano+MidA(ls_DataMovimento,5,2)

	pd_datafiscal = Date(ls_DataMovimento)

End If

Return lb_Sucesso
end function

public function boolean of_mapa_resumo (ref s_ge039_mapa_resumo ps_mapa_resumo);If This.ivb_Modo_Teste Then Return True

Long    ll_Retry
Long    ll_Retorno
Long    ll_Totalizador
Long    ll_Posicao
Long	  ll_Coo_Ini
Long	  ll_Coo_Fim
Long	  ll_Arquivo
Long	  ll_contador_aliquota = 335
Long 	  ll_linha

String  ls_Dados    = Space(631)
String  ls_DadosMFD = Space(1278)
String  ls_DadosAliquotas = Space(80)
String  ls_Serie
String  ls_Arquivo
String  ls_Arquivos[]
String  ls_Path
String  ls_Aliquota

Decimal{2} ldc_gt_inicial
Decimal{2} ldc_gt_final
Decimal{2} ldc_vl_aliquota

Boolean lb_Sucesso = False

DateTime dt_Ultimo_Mov
Date		 dt_emissao_reducao, &
			 dt_fiscal_reducao
			 
//Exclui arquivos da ECF para n$$HEX1$$e300$$ENDHEX$$o gerar mapa com valores errados.
ls_Serie = "*" + This.nr_serie + "*.txt"
ls_Path  = "c:\sweda\"

gf_dir_list( ls_Path, ls_Serie, 0+1, ref ls_Arquivos[] )

For ll_Arquivo = 1 To UpperBound( ls_Arquivos )
	ls_Arquivo = ls_Arquivos[ll_Arquivo]	
	FileDelete(ls_Path + ls_Arquivo)	
Next

//Delay para verificar se diminui os problemas na grava$$HEX2$$e700e300$$ENDHEX$$o do mapa resumo
gf_delay(2)

If Not of_GT_inicial_final(Ref ldc_gt_inicial, Ref ldc_gt_final) Then Return False
 
Do While ll_Retry <= 3 and Not lb_Sucesso
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DadosUltimaReducaoMFD(Ref ls_DadosMFD),'ECF_DadosUltimaReducaoMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao ler dados da $$HEX1$$fa00$$ENDHEX$$ltima redu$$HEX2$$e700e300$$ENDHEX$$o Z. ACK=" + String(This.Ack) + " ST1=" + String(This.St1) + "ST2=" + String(This.St2) + "ST3=" + String(This.St3))
			Return False
	End Choose
	
	ll_Retry ++

Loop

If Not lb_Sucesso Then Return False

ll_Retry = 0

lb_Sucesso = False

Do While ll_Retry <= 3 and Not lb_Sucesso
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DadosUltimaReducao(Ref ls_Dados),'ECF_DadosUltimaReducao')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao ler dados da $$HEX1$$fa00$$ENDHEX$$ltima redu$$HEX2$$e700e300$$ENDHEX$$o Z. ACK=" + String(This.Ack) + " ST1=" + String(This.St1) + "ST2=" + String(This.St2) + "ST3=" + String(This.St3))
			Return False
	End Choose
	
	ll_Retry ++

Loop

ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_RetornoAliquotas( Ref ls_DadosAliquotas ), 'ECF_RetornoAliquotas' )
	
Choose Case ll_Retorno
	Case 1 				// Comando OK	
		lb_Sucesso = True		
	Case 0 				// Erro ao executar comando
		Return False
	Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido		
		This.of_Status_Extendido_ECF()					
		Return False		
End Choose

If Not lb_Sucesso Then Return False

If This.ECF = 0 Then
	If Not This.of_Nr_Ecf(ref This.ECF) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Leitura do N$$HEX1$$fa00$$ENDHEX$$mero da ECF.")
		Return False
	End If
End If

ps_mapa_resumo.ecf           				= This.ECF

ps_mapa_resumo.isento        				= DEC(MidA(ls_DadosMFD,560,14))/100
ps_mapa_resumo.vl_nao_incidencia			= DEC(MidA(ls_DadosMFD,575,14))/100
ps_mapa_resumo.vlst          				= DEC(MidA(ls_DadosMFD,590,14))/100

ps_mapa_resumo.qt_cupom_cancelado 		= LONG(MidA(ls_DadosMFD,54,04))
ps_mapa_resumo.qt_reinicio_z 		 		= LONG(MidA(ls_DadosMFD,04,04))
ps_mapa_resumo.reducoes           		= LONG(MidA(ls_DadosMFD,09,04))
ps_mapa_resumo.operacao           		= LONG(MidA(ls_DadosMFD,14,06))

ps_mapa_resumo.grande_total  				= DEC(MidA(ls_DadosMFD,316,18))/100

Do While Trim(ls_DadosAliquotas) > ''
	ll_linha += 1
	ls_Aliquota = Trim(MidA(ls_DadosAliquotas, 1, PosA(ls_DadosAliquotas,',') - 1))
	If Trim(ls_Aliquota) = '' Then // ultima posi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o tem a virgula
		ls_Aliquota = Trim(ls_DadosAliquotas)
		ls_DadosAliquotas = ''
	Else
		ls_DadosAliquotas = Trim(MidA(ls_DadosAliquotas,PosA(ls_DadosAliquotas,',') + 1))		
	End If	
	ldc_vl_aliquota = DEC(MidA(ls_DadosMFD,ll_contador_aliquota,14))/100
	ps_mapa_resumo.str_aliquota[ll_linha].aliquota	 = Long(Dec(ls_Aliquota) / 100)
	ps_mapa_resumo.str_aliquota[ll_linha].valor		 = ldc_vl_aliquota	
	ll_contador_aliquota += 14	
Loop

//ps_mapa_resumo.icm07         				= DEC(MidA(ls_DadosMFD,335,14))/100
//ps_mapa_resumo.icm12         				= DEC(MidA(ls_DadosMFD,349,14))/100
//ps_mapa_resumo.icm25         				= DEC(MidA(ls_DadosMFD,363,14))/100
//ps_mapa_resumo.icm17         				= DEC(MidA(ls_DadosMFD,377,14))/100
//ps_mapa_resumo.icm18         				= DEC(MidA(ls_DadosMFD,391,14))/100

ps_mapa_resumo.vl_isento_iss 				= DEC(MidA(ls_DadosMFD,605,14))/100
ps_mapa_resumo.vl_nao_incidencia_iss	= DEC(MidA(ls_DadosMFD,620,14))/100
ps_mapa_resumo.vl_st_iss 					= DEC(MidA(ls_DadosMFD,635,14))/100
ps_mapa_resumo.descontos     				= DEC(MidA(ls_DadosMFD,650,14))/100
ps_mapa_resumo.vl_desconto_iss			= DEC(MidA(ls_DadosMFD,665,14))/100
ps_mapa_resumo.vl_acrescimo				= DEC(MidA(ls_DadosMFD,680,14))/100
ps_mapa_resumo.vl_acrescimo_iss			= DEC(MidA(ls_DadosMFD,695,14))/100
ps_mapa_resumo.cancelamentos 				= DEC(MidA(ls_DadosMFD,710,14))/100
ps_mapa_resumo.vl_cancelamento_iss		= DEC(MidA(ls_DadosMFD,725,14))/100

If ldc_gt_final > 0 And ldc_gt_inicial = 0 Then	
	If (ps_mapa_resumo.cancelamentos + ps_mapa_resumo.descontos) = 0 Then
		Long lvl_Notas
		Date lvdt_Data
		
		lvdt_Data = Date(MidA(ls_DadosMFD,1273,2) + "/" + MidA(ls_DadosMFD,1275,2) + "/" + MidA(ls_DadosMFD,1277,2))
		
		Select Count(*)
		  Into :lvl_Notas
		  From nf_venda
		 Where nr_ecf = :This.ECF
		   and dh_movimentacao_caixa = :lvdt_Data
		 Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas do dia '" + String(lvdt_Data,"DD/MM/YYYY") + "' na ECF '" + String(This.ECF) + "'.")
		End If
		
		If lvl_Notas = 0 Then
			ldc_gt_final = 0
			Return False
		End If		
	End If
End If

ps_mapa_resumo.liquido       		      = ( ldc_gt_final - ldc_gt_inicial ) - ( ps_mapa_resumo.cancelamentos + ps_mapa_resumo.descontos )

ll_Posicao = 740

For ll_Totalizador = 1 To 28
	
	ps_mapa_resumo.vl_operacao_nao_fiscal	+= DEC(MidA(ls_DadosMFD,ll_Posicao,14))/100
	
	ll_Posicao += 14
	
Next

Return True
end function

public function integer of_controle_caixa_conferido (long pl_ecf, long pl_seq);DateTime lvdh_Movimento,&
         lvdh_Conferencia

lvdh_Movimento = This.of_dh_movimentacao()

SetPointer(HourGlass!)

Select controle_caixa.dh_conferencia Into :lvdh_Conferencia
From nf_venda,
     controle_caixa
Where nf_venda.nr_ecf                  = :pl_ecf
  and nf_venda.nr_operacao_ecf         = :pl_seq
  and nf_venda.dh_movimentacao_caixa   = :lvdh_Movimento
  and controle_caixa.cd_caixa          = nf_venda.cd_caixa
  and controle_caixa.nr_controle_caixa = nf_venda.nr_controle_caixa
Using Sqlca;  

If Sqlca.Sqlcode = -1 Then
	Sqlca.Of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do controle caixa")
	gvo_aplicacao.of_grava_log("Erro ao localizar controle caixa, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_controle_caixa_conferido()."+Sqlca.SQLErrText)	
	Return -1
ElseIf Sqlca.Sqlcode = 100 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Controle caixa referente ao cupom n$$HEX1$$e300$$ENDHEX$$o foi encontrado.",StopSign!)
	Return -1
End If	

If Not IsNull(lvdh_Conferencia) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Controle do Caixa referencia ao cupom fiscal j$$HEX1$$e100$$ENDHEX$$ foi conferido.",Exclamation!)
	Return -1
End If

Return 1
end function

public function boolean of_cupom_gravado (long pl_ecf, long pl_seq);Long     lvl_nr_nf

Datetime lvdh_Movimento

lvdh_Movimento = This.of_dh_movimentacao()

SetPointer(HourGlass!)

Select nf.nr_nf INTO :lvl_nr_nf
From nf_venda nf
Where nf.nr_ecf                = :pl_ecf
  and nf.nr_operacao_ecf       = :pl_seq
  and nf.dh_movimentacao_caixa = :lvdh_Movimento
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.Of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o do cupom fiscal.')
	gvo_aplicacao.of_grava_log("Erro ao localizar cupom fiscal, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_cupom_gravado()."+Sqlca.SQLErrText)	
	Return False
End If

//Cupom Fiscal n$$HEX1$$e300$$ENDHEX$$o foi localizado
If IsNull(lvl_nr_nf) OR lvl_nr_nf = 0 Then Return False

Return True
end function

public function datetime of_dh_movimentacao ();DateTime ldh_movimentacao
DateTime ldh_nulo

SetNull(ldh_Nulo)

Select dh_movimentacao Into :ldh_movimentacao
From parametro 
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return ldh_movimentacao		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada nos par$$HEX1$$e200$$ENDHEX$$metros.", StopSign!)
		Return ldh_nulo
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da data de movimenta$$HEX2$$e700e300$$ENDHEX$$o nos par$$HEX1$$e200$$ENDHEX$$metros." + SqlCa.SqlErrText, StopSign!)
		gvo_aplicacao.of_grava_log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da data de movimenta$$HEX2$$e700e300$$ENDHEX$$o nos par$$HEX1$$e200$$ENDHEX$$metros, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_dh_movimentacao()."+Sqlca.SQLErrText)	
		Return ldh_Nulo
End Choose
end function

public function boolean of_fecha_cupom_nao_fiscal (string ps_vinculado);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_FechaComprovanteNaoFiscalVinculado(), 'ECF_FechaComprovanteNaoFiscalVinculado')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case 0 				// Comando n$$HEX1$$e300$$ENDHEX$$o executado
			
			//N$$HEX1$$e300$$ENDHEX$$o existe cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto
			If This.St3 = 101 Then Return True
			
			This.of_Status_Extendido_ECF()
			
			Return False

		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			
			If This.st3 = 33 Then Return This.of_cancela_recebimento_nao_fiscal()
			
			Return False
			
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_fecha_cupom_nao_fiscal ();Return of_Fecha_Cupom_Nao_Fiscal("N")
end function

public function string of_indicador_aliquota (decimal pd_aliquota, string ps_tributacao_icms);String ls_Indicador

If pd_aliquota > 0 Then
	ls_indicador = gf_replace(String(pd_aliquota),',','',1)
	ls_indicador = String(Long(ls_indicador),'0000')	
Else
	If ps_tributacao_icms = '06' Then
		ls_Indicador = "FF"
	Else
		ls_Indicador = "II"
	End If		
End If

//Choose Case pd_aliquota
//	Case 7    	; ls_Indicador = "01"
//	Case 12   	; ls_Indicador = "02"
//	Case 25   	; ls_Indicador = "03"		
//	Case 17   	; ls_Indicador = "04"
//	Case 18	  	; ls_Indicador = "05"
//	Case Else 
//		If ps_tributacao_icms = '06' Then
//			ls_Indicador = "FF"
//		Else
//			ls_Indicador = "II"
//		End If	
//End Choose

Return ls_Indicador
end function

public function boolean of_verifica_drivers ();Integer	lvi_Contador
String		lvs_Drivers[]
String		lvs_Arquivo
String 	lvs_path = 'c:\sistemas\dll\sweda\'

SetPointer(HourGlass!)

If Not This.of_Atualiza_Drivers() Then Return False

lvs_Drivers[1] = "SWMFD.dll"
lvs_Drivers[2] = "CONVECF.dll"

For lvi_Contador = 1 To UpperBound(lvs_Drivers)
	If Not FileExists(lvs_path + lvs_Drivers[lvi_Contador]) Then
		gvo_aplicacao.of_grava_log("Driver da Impressora Fiscal n$$HEX1$$e300$$ENDHEX$$o encontrado " + lvs_path + lvs_Drivers[lvi_Contador])	
		MessageBox('IMPRESSORA SWEDA','Driver da Impressora Fiscal n$$HEX1$$e300$$ENDHEX$$o encontrado : ' + lvs_path + lvs_Drivers[lvi_Contador],StopSign!)
		Return False
	End If	
Next

Return True
end function

public function boolean of_path_log (string ps_path_log);This.ivs_path_log = ps_path_log

Return True
end function

public function boolean of_cancela_item (integer pl_item);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
String ls_item

ls_item = String(pl_item)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_CancelaItemGenerico(ls_item),'ECF_CancelaItemGenerico')
	
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

public function boolean of_aguarda_execucao ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While True
	
    ll_Retorno = This.of_Status_ECF()

	If This.ST3 = 9 Then Continue // ECF Ocupado
	
	Exit

Loop

Return True
end function

public function boolean of_dados_impressora (ref long pl_sequencial, ref long pl_ecf);If Not of_nr_ecf(Ref pl_ecf) Then Return False

If Not of_nr_cupom(Ref pl_sequencial) Then Return False

Return True
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
		
	ls_Serie = Space(20)

	If of_Verifica_Retorno_ECF(ECF_NumeroSerieMFD(ls_Serie),'ECF_NumeroSerieMFD') <> 1 Then Return False
	
	SetProfileString(ls_File, "ECF", "Serie",of_Encripta(ls_Serie))
	
	SetProfileString(ls_File, "ECF", "VendaBruta",of_Encripta(String(ldc_Valor,'###,###,###,###.00')))
	
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Registro de Venda Bruta e N$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie efetuados !")
	
Else
	
	If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Homologacao","") <> 'S' Then
		Return True
	End If
	
	If Not of_Grande_Total(Ref ldc_Valor) Then Return False
		
	ls_Serie = Space(20)

	If of_Verifica_Retorno_ECF(ECF_NumeroSerieMFD(ls_Serie),'ECF_NumeroSerieMFD') <> 1 Then Return False
	
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

public function boolean of_horario_verao_parametros (ref date adt_inicio, ref date adt_termino);Boolean lvb_Sucesso = False

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

If lvo_Parametro.of_Localiza_Parametro("DT_INICIO_HORARIO_VERAO", ref adt_Inicio) Then
	If lvo_Parametro.of_Localiza_Parametro("DT_TERMINO_HORARIO_VERAO", ref adt_Termino) Then
		lvb_Sucesso = True
	End If	
End If

Destroy(lvo_Parametro)

Return lvb_Sucesso
end function

public function boolean of_horario_verao_ajuste (string ps_modo);If This.ivb_Modo_Teste Then Return True

STRING lvs_Modo_Atual , lvs_Mensagem

ivb_showerror = FALSE

SetPointer(HourGlass!)

If Not This.of_Verifica_status_Horario_Verao(Ref lvs_Modo_Atual) Then Return False

SetPointer(Arrow!)

If lvs_Modo_Atual = 'S' and ps_Modo = 'S' THEN
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Impressora Fiscal j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ em modo Hor$$HEX1$$e100$$ENDHEX$$rio de Ver$$HEX1$$e300$$ENDHEX$$o (hh:mm HV).',Information!,Ok!)
	Return True
END IF

If lvs_Modo_Atual = 'N' and ps_Modo = 'N' THEN
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Impressora Fiscal n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em modo Hor$$HEX1$$e100$$ENDHEX$$rio de Ver$$HEX1$$e300$$ENDHEX$$o (hh:mm).',Information!,Ok!)
	Return True
End If

If Not This.of_Programa_Horario_Verao() Then Return False

Return True
end function

public function string of_encripta (string ps_texto);String ls_Byte
String ls_Valor

Integer li_Ind

For li_Ind = 1 To LenA(ps_texto)
	
	Choose Case MidA(ps_texto,li_Ind,1)
		Case '0'	
			ls_Byte = 'P'
		Case '1'	
			ls_Byte = 'E'
		Case '2'	
			ls_Byte = 'R'
		Case '3'	
			ls_Byte = 'N'
		Case '4'	
			ls_Byte = 'A'
		Case '5'	
			ls_Byte = 'M'
		Case '6'
			ls_Byte = 'B'
		Case '7'	
			ls_Byte = 'U'
		Case '8'	
			ls_Byte = 'C'
		Case '9'			
			ls_Byte = 'O'
		Case Else
			ls_Byte = ''
	End Choose
	
	ls_Valor += ls_Byte
	
Next	

Return ls_Valor
end function

public function string of_desencripta (string ps_texto);String ls_Byte
String ls_Texto

Integer li_Ind

For li_Ind = 1 To LenA(ps_texto)
	
	Choose Case MidA(ps_texto,li_Ind,1)
		Case 'P'	
			ls_Byte = '0'
		Case 'E'	
			ls_Byte = '1'
		Case 'R'	
			ls_Byte = '2'
		Case 'N'	
			ls_Byte = '3'
		Case 'A'	
			ls_Byte = '4'
		Case 'M'	
			ls_Byte = '5'
		Case 'B'
			ls_Byte = '6'
		Case 'U'	
			ls_Byte = '7'
		Case 'C'	
			ls_Byte = '8'
		Case 'O'			
			ls_Byte = '9'
	End Choose
	
	ls_texto += ls_Byte
	
Next	

Return ls_Texto
end function

public function boolean of_inicializa_comprovante_tef_nao_fiscal (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

String	ls_Pagamento
String	ls_Forma_Pagamento 

Choose Case ps_tipo_pagamento
	Case "01" ; ls_Forma_Pagamento = "DINHEIRO"
	Case "02" ; ls_Forma_Pagamento = "CHEQUE"	
	Case "03" ; ls_Forma_Pagamento = "CHEQUE-PRE"
	Case "04" ; ls_Forma_Pagamento = "CARTAO CREDITO"
	Case "05" ; ls_Forma_Pagamento = "CARTAO DEBITO "
	Case "06" ; ls_Forma_Pagamento = "CONVENIO"
	Case "07" ; ls_Forma_Pagamento = "CREDIARIO"
	Case "08" ; ls_Forma_Pagamento = "CONTA CORRENTE"
	Case "09" ; ls_Forma_Pagamento = "CLUBE"
	Case "10" ; ls_Forma_Pagamento = "PBM"
	Case "11" ; ls_Forma_Pagamento = "RECARGA"
End Choose

//Retorna descri$$HEX2$$e700e300$$ENDHEX$$o do meio de pagamento
ls_Pagamento = of_meio_pagamento(ps_tipo_pagamento)

If Not of_inicializa_recebimento_nao_fiscal() Then Return False

If Not of_efetua_recebimento_nao_fiscal(ps_tipo_recebimento,String(pdc_valor)) Then Return False

If Not of_Registra_documento_ecf('CN',ls_Forma_Pagamento,pdc_valor) Then Return False

If Not of_totaliza_recebimento_nao_fiscal(ps_tipo_pagamento,String(pdc_valor)) Then Return False

If Not of_fecha_recebimento_nao_fiscal(String(pdc_valor)) Then Return False

If Not of_inicializa_comprovante_tef(ps_tipo_pagamento,ps_descricao,ps_tipo_pagamento,pdc_valor, '') Then Return False

Return True
end function

public function boolean of_registra_cancelamento (long pl_ecf, long pl_seq);String			lvs_Msg , lvs_File
Integer		lvi_file, lvi_Bytes
DateTime	lvdh_Data_Movimento

lvdh_Data_Movimento = This.of_dh_movimentacao()

lvs_file = ivs_Path_Log+"\cupons_cancelados.txt"

lvi_file = FileOpen(lvs_file,StreamMode!,Write!,Shared!,Append!)

If lvi_file = -1 Then
	gvo_aplicacao.of_grava_log('Erro ao abrir o arquivo ['+lvs_File+'] de log.')	
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao abrir o arquivo ' + lvs_file , StopSign!)
	Return False
End If

lvs_Msg = ""
lvs_Msg = "ECF: " + String(THIS.ECF,'000') + " SEQ: " + String(pl_seq,'0000') + ' DATA: ' + String(lvdh_Data_Movimento,'dd/mm/yyyy') + CharA(13)+CharA(10)

lvi_Bytes = FileWrite (lvi_file,Trim(lvs_Msg))

FileClose(lvi_file)

If lvi_Bytes <> LenA(lvs_Msg) Then
	gvo_aplicacao.of_grava_log('Erro ao gravar arquivo ['+lvs_File+'] de log.')	
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao gravar arquivo de log. ' + lvs_File ,StopSign!)
	Return False
End If

Return True
end function

public function boolean of_horario_verao ();Return True

/*  RETIRADO POR N$$HEX1$$c300$$ENDHEX$$O SER MAIS USADO A ATIVA$$HEX2$$c700c300$$ENDHEX$$O/DESATIVACAO DO MODO A ECF
	AGORA $$HEX1$$c900$$ENDHEX$$ USADO O AJUSTE DE 5 MIN A CADA REDUCAO

If ivb_modo_teste Then Return True

BOOLEAN  lvb_Retorno

DATETIME lvdh_Movimentacao

Date lvdt_Inicio,&
	  lvdt_Termino
			
STRING   lvs_Modo_Atual,&
         lvs_Modo,&
		   lvs_Msg

If Not This.of_Horario_Verao_Parametros(ref lvdt_Inicio, ref lvdt_Termino) Then Return False

lvdh_Movimentacao = This.of_dh_Movimentacao()

SetNull(lvs_Modo)

//IF Not of_status_transacao() Then Return False

lvs_Modo_Atual = of_parametro28("VERAO")

SetPointer(Arrow!)

If lvs_Modo_Atual = 'N' and &
	Date(lvdh_Movimentacao) >= lvdt_Inicio and &
	( Date(lvdh_Movimentacao) < lvdt_Termino or IsNull(lvdt_Termino) )  THEN
	lvs_Msg  = 'Entrada no Hor$$HEX1$$e100$$ENDHEX$$rio de Ver$$HEX1$$e300$$ENDHEX$$o - Rel$$HEX1$$f300$$ENDHEX$$gio da ECF alterado automaticamente.'
	lvs_Modo = 'S'
End If

If lvs_Modo_Atual = 'S' and Date(lvdh_Movimentacao) >= lvdt_Termino Then
	lvs_Msg  = 'Sa$$HEX1$$ed00$$ENDHEX$$da do Hor$$HEX1$$e100$$ENDHEX$$rio de Ver$$HEX1$$e300$$ENDHEX$$o - Rel$$HEX1$$f300$$ENDHEX$$gio da ECF alterado automaticamente.'
	lvs_Modo = 'N'
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Aguarde 1 hora antes de clicar no <OK>, para ajustar hor$$HEX1$$e100$$ENDHEX$$rio de ver$$HEX1$$e300$$ENDHEX$$o.",StopSign!)
End If

If IsNull(lvs_Modo) Then Return True

lvb_Retorno = This.Of_Horario_Verao_Ajuste(lvs_Modo)

If lvb_Retorno Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_Msg,Information!)

Return lvb_Retorno */
end function

public function boolean of_marca_modelo ();If This.ivb_Modo_Teste Then Return True

String ls_Marca
String ls_Modelo
String ls_Tipo

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Marca		= Space(15)
ls_Modelo	= Space(20)
ls_Tipo 		= Space(7)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_MarcaModeloTipoImpressoraMFD(Ref ls_Marca,Ref ls_Modelo, Ref ls_Tipo),'ECF_MarcaModeloTipoImpressoraMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			This.de_Marca 	= Trim(LeftA(ls_Marca + Space(20) , 20))
			This.Modelo = Trim(LeftA(ls_Modelo + Space(20) , 20))
			This.de_Tipo 	= Trim(LeftA(ls_Tipo + Space(7) , 7))
			

//********Este trecho foi colocada em outra funcao, para tamb$$HEX1$$e900$$ENDHEX$$m cadastrar a ECF e ser chamada apenas uma vez.******
//			Update impressora_fiscal
//			Set de_fabricante = :This.de_Marca,
//			    de_modelo		= :This.de_Modelo,
//				 de_tipo			= :This.de_Tipo
//			Where nr_ecf 		= :This.Ecf	 
//			Using Sqlca;
//			
//			If Sqlca.Sqlcode = -1 Then
//				Sqlca.of_RollBack()
//				Sqlca.of_MsgDbError('Grava$$HEX2$$e700e300$$ENDHEX$$o Marca/Modelo/Tipo ECF.')
//				Return False
//			End If	
//			
//			Sqlca.of_Commit()
			
			lb_Sucesso = True
			
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return lb_Sucesso
end function

public function long of_status_ecf ();Long ll_Ack
Long ll_St1
Long ll_St2
Long ll_St3

Long ll_Retorno

ll_Retorno = ECF_RetornoImpressoraMFD(Ref ll_Ack,Ref ll_St1,Ref ll_St2, Ref ll_St3)

This.Ack = ll_Ack
This.St1 = ll_St1
This.St2 = ll_St2
This.St3 = ll_St3

//Comando executado corretamente
If This.Ack = 6 and This.St1 = 0 and This.St2 = 0 and This.St3 = 0 Then Return 1

//Erro Impressora Retornou NAK
If This.Ack = 21 Then 
	gvo_aplicacao.of_grava_log("Erro Impressora Retornou NAK")
	Return -1
End If
	
//ECF Ocupado
If This.St3 = 9 Then 
	gvo_aplicacao.of_grava_log("ECF Ocupado")
	Return 100
End If

//Erro ao verificar status ECF
If ll_Retorno <> 1 Then 
	gvo_aplicacao.of_grava_log("Erro ao verificar status ECF")
	Return -1 
End If

If This.St3 <> 0 And This.St3 <> 101 Then 
	gvo_aplicacao.of_grava_log("ST3: " + String(This.St3) + " - " + This.of_status_st3())
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "ST3: " + String(This.St3) + " - " + This.of_status_st3())
	Return -1
End If

Return 1
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

ldt_Movimento = of_dh_Movimentacao()
ldt_Movimento_Relativo = DateTime(RelativeDate(Date(ldt_Movimento),-5))

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
	gvo_aplicacao.of_grava_log("Erro ao verificar $$HEX1$$fa00$$ENDHEX$$ltima data de movimenta$$HEX2$$e700e300$$ENDHEX$$o, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_verifica_ultimo_mapa_resumo()." +Sqlca.SQLErrText)	
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
	gvo_aplicacao.of_grava_log("Erro ao verificar $$HEX1$$fa00$$ENDHEX$$ltimo mapa resumo registrado, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_verifica_ultimo_mapa_resumo()." +Sqlca.SQLErrText)	
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

public function boolean of_desconto_item (long pl_item, decimal pd_desconto, decimal pd_valor);If This.ivb_Modo_Teste Then Return True

String ls_valor

Long ll_Retry
Long ll_Retorno

ls_valor = String(pd_valor)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_AcrescimoDescontoItemMFD(String(pl_item,'000'),"D","$",ls_valor),'ECF_AcrescimoDescontoItemMFD')
	 	
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

public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Origem  = 'C:\Sistemas\CL\Arquivos\PAF-ECF\download.mfd'
String ls_Destino = 'C:\Sistemas\CL\Arquivos\PAF-ECF\leitura-memoria-fita-detalhe.txt'

FileDelete(ls_Origem)
FileDelete(ls_Destino)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DownloadMFD(ls_Origem,ps_Tipo,ps_inicio,ps_final,'1'),'ECF_DownloadMFD')

   Exit
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

If FileExists(ls_Origem) Then
	
	Do While ll_Retry <= 3
	
		ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_FormatoDadosMFD(ls_Origem,ls_Destino,'0',ps_Tipo,ps_inicio,ps_final,'1'),'ECF_FormatoDadosMFD')
		
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
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar arquivo " + ls_Destino ,StopSign!)
End If
	
Return False
end function

public function boolean of_porta_comunicacao ();String lvs_INI,&
       lvs_Porta

lvs_INI  = gvo_Aplicacao.ivs_Arquivo_INI

// Verifica se o caminho dos arquivos de ajuda est$$HEX1$$e300$$ENDHEX$$o especificados no INI
lvs_Porta = ProfileString(lvs_INI, "ECF", "Porta","")

If Not IsNumber(lvs_Porta) Then
	gvo_aplicacao.of_grava_log("Arquivo de configura$$HEX2$$e700e300$$ENDHEX$$o " + lvs_INI + " n$$HEX1$$e300$$ENDHEX$$o possui o par$$HEX1$$e200$$ENDHEX$$metro Porta na sess$$HEX1$$e300$$ENDHEX$$o [ECF].")	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de configura$$HEX2$$e700e300$$ENDHEX$$o : " + lvs_INI + '~n~nN$$HEX1$$e300$$ENDHEX$$o possui par$$HEX1$$e200$$ENDHEX$$metros~n~n[ECF]~nPorta=', StopSign! )
	Return False
End If

This.Porta = Long(lvs_Porta)

Return True
end function

public subroutine of_grava_logerro (string ps_comando);String  lvs_erro, lvs_status, lvs_file, lvs_comando
Integer lvi_file, lvi_Bytes

lvs_file = ivs_Path_Log+"\ecf.log"

lvi_file = FileOpen(lvs_file,LineMode!,Write!,Shared!,Append!)

If lvi_file = -1 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao gravar arquivo ' + lvs_file , StopSign!)
	Return
End If

lvs_erro = ""
lvs_erro = String(DateTime(Today(),Now())) + ' ECF:' + String(This.ECF) + " ENVIADO : '" + ps_comando + "' RECEBIDO : '" + ivs_status + "'"

lvi_Bytes = FileWrite (lvi_file,Trim(lvs_erro))

If lvi_Bytes <> LenA(lvs_erro) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao gravar log.',StopSign!)
End If

FileClose(lvi_file)
end subroutine

public function boolean of_cancela_cupom (long pl_ecf, long pl_seq);
If This.ivb_Modo_Teste Then Return True

ivb_showerror = False

Long ll_Retry
Long ll_Retorno

Boolean lb_Sucesso = False

Open(w_Janela_Aguarde)
w_Janela_Aguarde.Wf_Mensagem("CANCELANDO CUPOM FISCAL")

Do While ll_Retry <= 3 and Not lb_Sucesso 
	
	ll_Retry ++
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_CancelaCupomMFD("","",""),'ECF_CancelaCupomMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
	End Choose
	
	Exit
	
Loop

//*******RETIRADO 09/2015 - O arquivo estava ficando no PDV sem necessidade,
// pois os dados de cancelamentos j$$HEX1$$e100$$ENDHEX$$ estavam gravados no sistema.
//If lb_Sucesso Then
//	of_Registra_Cancelamento(pl_Ecf,pl_Seq)
//End If	

If IsValid(w_Janela_Aguarde) Then Close(w_Janela_Aguarde)

SetPointer(HourGlass!)

Return lb_Sucesso
end function

public function boolean of_timeout_ecf ();String lvs_INI,&
	   lvs_Timeout

lvs_INI = gvo_Aplicacao.ivs_Arquivo_INI

lvs_Timeout = ProfileString(lvs_INI, "ECF" , "Timeout" , "")

If IsNumber(lvs_Timeout) Then
	This.Timeout = Long(lvs_Timeout)
Else
	This.Timeout = 10
End If

Return True
end function

public function boolean of_numero_serie ();
If This.ivb_Modo_Teste Then Return True

String ls_Serie,&
       ls_SerieCompleto,&
		 ls_SerieAtual,&
	    ls_Situacao,&
	    ls_ecf,&
		 ls_File
		 
Long   ll_retorno
Long   ll_ecf

ls_File = 'c:\sistemas\cl\arquivos\pafecf.ini'

ls_Ecf = Space(04)
 
If of_verifica_retorno_ecf(ECF_NumeroCaixa(Ref ls_ECF),'ECF_NumeroCaixa') <> 1 Then Return False

This.ECF = Long(ls_ECF)

ls_SerieCompleto = Space(20)

ll_Retorno = ECF_NumeroSerieMFD(Ref ls_SerieCompleto)

If of_Verifica_Retorno_ECF(ll_Retorno,'ECF_NumeroSerieMFD') <> 1 Then Return False

This.nr_Serie = ls_SerieCompleto

ls_Serie = ProfileString (ls_File, "ECF", "Serie","")

ls_Serie = of_Desencripta(ls_Serie)

//If This.nr_Serie <> ls_Serie Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de s$$HEX1$$e900$$ENDHEX$$rie diferente do habilitado para esse terminal.", Exclamation!)
//	Return False
//End If

Return True
end function

public function boolean of_permite_cancelamento_cupom ();If This.ivb_Modo_Teste Then Return True

If Not This.of_Verifica_Flags_Fiscais() Then Return False

// Verifica se existem cupons fiscais pendentes 
If Long(ivs_Status) >= 32 Then Return True

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o cancelamento do documento impresso.",Exclamation!)

Return False
end function

public function boolean of_verifica_problemas_impressora ();
If This.ivb_Modo_Teste Then Return True

STRING  ls_aut,&
        ls_slip,&
			ls_bobina,&
		ls_status,&
		ls_transacao
		  
LONG    lvl_Retry

DECIMAL lvdc_soma

Do While True
	
	If Not This.of_Impressora_online() Then Return False
	
	If Not of_Verifica_Cupons_Pendentes() Then Return False
	
	If Sqlca.ivs_DataBase <> "ACCESS" Then
	
		// VerIfica se a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ igual a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o do parametro
		If Not of_verifica_data_movimentacao() Then Return False
		
		//If Not This.of_Verifica_Ultimo_Mapa_Resumo() Then Return False
		This.of_Verifica_Ultimo_Mapa_Resumo()
	
		If of_Status_ECF() = -1 Then Return False
		
		If Not of_flags_st1() Then Return False

		If Not of_flags_st2() Then Return False
		
		Choose Case This.St3
			Case 33
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente.",StopSign!)
	
				If Not of_cancela_Recebimento_Nao_Fiscal() Then Return False
	
			Case 63 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Impressora Fiscal Bloqueada. Redu$$HEX2$$e700e300$$ENDHEX$$o Z j$$HEX1$$e100$$ENDHEX$$ efetuada.",StopSign!)

		End Choose
		
	End If
		
	of_Verifica_Flags_Fiscais()
	
	If ivs_Status = "008" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Impressora Fiscal Bloqueada. Redu$$HEX2$$e700e300$$ENDHEX$$o Z j$$HEX1$$e100$$ENDHEX$$ efetuada.",StopSign!)

	End If
	
	Exit
	
Loop

Return True
end function

public function boolean of_atualiza_data_fiscal ();Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais necess$$HEX1$$e100$$ENDHEX$$rio atualizar a data fiscal na ECF Sweda.", Exclamation!)

//If This.ivb_Modo_Teste Then Return True
////
//DATE    lvd_Data_Corrente, lvd_Data_Fiscal
//STRING  lvs_aut, lvs_slip, lvs_bobina
////
//DO WHILE TRUE
//	//
////	IF NOT of_Status_Impressora() THEN RETURN FALSE
//	//
//	lvs_aut    = of_parametro23("AUT")
//	lvs_slip   = of_parametro23("SLIP")
//	lvs_bobina = of_parametro23("BOBINA")
//	//
//	IF lvs_aut = "1" OR lvs_slip = "1" OR lvs_bobina = "1" OR &
//		lvs_aut = "2" OR lvs_slip = "2" OR lvs_bobina = "2" OR &
//		lvs_aut = "6" OR lvs_slip = "6" OR lvs_bobina = "6" THEN
//		IF NOT of_pergunta_impressoraoffline() THEN RETURN FALSE
//	   CONTINUE
//	END IF
//	//
////	IF NOT of_status_transacao() THEN CONTINUE
//	//
//	IF of_parametro28("FAZX") = "F" THEN
//		//Verifica se h$$HEX1$$e100$$ENDHEX$$ algum cupom pendente
////		IF NOT Of_Verifica_Ultimo_Cupom_Concluido() THEN RETURN FALSE
//		IF NOT of_pergunta_leiturax()               THEN RETURN FALSE
//		IF NOT of_LeituraX(False)                     THEN RETURN FALSE
//
//		CONTINUE
//	END IF
//	//
////	IF NOT of_status_transacao() THEN CONTINUE
//	// Verifica se $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a Redu$$HEX2$$e700e300$$ENDHEX$$o Z
//	IF of_parametro28("REDUCAO") = "F" THEN
//		Messagebox("Impressora Fiscal","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a Redu$$HEX2$$e700e300$$ENDHEX$$o Z na impressora fiscal.", StopSign!)
//		RETURN FALSE
//	END IF
//	//
//	// Verifica se pode Vender
//	IF of_parametro28("ABRIR") = "S" THEN
//		 messagebox("Impressora Fiscal","Dia j$$HEX1$$e100$$ENDHEX$$ encerrado.", StopSign!)
//		 RETURN FALSE
//	ELSEIF of_parametro28("ABRIR") = "F" THEN
//	    messagebox("Impressora Fiscal","Dia deve ser encerrado para abrir o caixa.", StopSign!) 
//		 RETURN FALSE
//	END IF
//	//
//	EXIT
//	//
//LOOP
////
//IF NOT THIS.of_DataECF(Ref lvd_Data_Corrente) THEN
//	RETURN FALSE
//END IF
////
//IF NOT THIS.of_DataFiscal(Ref lvd_Data_Fiscal) THEN
//	RETURN FALSE
//END IF
////
//IF lvd_Data_Corrente = lvd_Data_Fiscal THEN
//	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio executar este comando. Data fiscal est$$HEX1$$e100$$ENDHEX$$ igual a data corrente da impressora fiscal ("+String(lvd_Data_Corrente)+").", Information!)
//	RETURN TRUE
//ELSEIF lvd_Data_Corrente < lvd_Data_Fiscal THEN
//	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data fiscal maior que data corrente. Comando n$$HEX1$$e300$$ENDHEX$$o pode ser executado.", Information!)
//	RETURN FALSE
//END IF
////
//IF NOT THIS.of_inicializa_cupom("") THEN RETURN FALSE
////
//IF NOT THIS.of_cancela_ultimo_cupom(False) THEN RETURN FALSE

Return True
end function

public function boolean of_leiturax (boolean pb_arquivo);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
DateTime ldt_data

This.of_data_hora_ecf(Ref ldt_Data)

Do While ll_Retry <= 3
	
	If pb_arquivo Then
		
		FileDelete('c:\retorno.txt')

		ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_LeituraXSerial(),'ECF_LeituraXSerial')

	Else	
	   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_LeituraX(),'ECF_LeituraX')
	End If	
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK	
			PDV.of_atualiza_primeira_venda_ecf(This.ECF, ldt_data, True)						
		
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

public function boolean of_leitura_memoria_fiscal (string ps_data_de, string ps_data_ate, boolean pb_arquivo, string ps_tipo);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
	If pb_arquivo Then
		ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_LeituraMemoriaFiscalSerialDataMFD(ps_data_de,ps_data_ate,lower(ps_tipo)),'ECF_LeituraMemoriaFiscalSerialDataMFD')
	Else	
	   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_LeituraMemoriaFiscalDataMFD(ps_data_de,ps_data_ate,lower(ps_tipo)),'ECF_LeituraMemoriaFiscalDataMFD')
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

public function boolean of_conecta_impressora ();String lvs_Nf_Paulista

ivs_grava_log = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF" , "Log" , "")
//PDV.ivs_unidade_federacao = gvo_parametro.ivs_uf_filial

If ivs_grava_log = "SIM" Then
 	SetProfileString('c:\sweda\Conversor.ini',"Sistema", "Log", "S")
Else
  	SetProfileString('c:\sweda\Conversor.ini',"Sistema", "Log", "N")
End If

If Trim(gvo_parametro.ivs_uf_filial) = 'SP' Then
	SetProfileString("c:\sweda\Conversor.ini", "Sistema", "RFD", "S")
	SetProfileString("c:\sweda\Conversor.ini", "Sistema", "PathMFD", "c:\sistemas\rl\arquivos\ecf")
Else
	SetProfileString("c:\sweda\Conversor.ini", "Sistema", "RFD", "N")	
End If

//Para verificar se para os problemas de erro de comunica$$HEX2$$e700e300$$ENDHEX$$o na impress$$HEX1$$e300$$ENDHEX$$o de comprovantes.
SetProfileString('c:\sweda\Conversor.ini',"Sistema", "Veloc115200", "1")
//SetProfileString('c:\sweda\Conversor.ini',"Sistema", "DSR", "N")
SetProfileString('c:\sweda\Conversor.ini',"Sistema", "CTS", "N")
SetProfileString('c:\sweda\Conversor.ini',"Sistema", "TEXTORAPIDO", "S")

Return True
end function

public subroutine of_fechaporta ();Long lvl_Retorno

If This.ivb_modo_teste Then Return

If This.ivb_Porta_Aberta Then

	lvl_Retorno = ECF_FechaPortaSerial()

	If lvl_Retorno = 1 Then
		This.ivb_Porta_Aberta = False
		PDV.ivb_Porta_Aberta = False
		THis.ECF = 0
	End If	

End If
end subroutine

public function boolean of_leitura_memoria_fiscal_reducao (long pl_reducao_inicial, long pl_reducao_final, boolean pb_arquivo, string ps_tipo);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
	If pb_arquivo Then
		ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_LeituraMemoriaFiscalSerialReducaoMFD(String(pl_reducao_inicial,'0000'),String(pl_reducao_final,'0000'),ps_tipo),'ECF_LeituraMemoriaFiscalSerialReducaoMFD')
	Else	
	   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_LeituraMemoriaFiscalReducaoMFD(String(pl_reducao_inicial,'0000'),String(pl_reducao_final,'0000'),ps_tipo),'ECF_LeituraMemoriaFiscalReducaoMFD')
	End If
	
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

public function boolean of_totaliza_cupom (string ps_tipo[], decimal pd_valor[]);If This.ivb_Modo_Teste Then Return True

Integer li_File
String	ls_valor,&
		ls_Pagto,&
		ls_parcelas,&
		ls_msg

Long    ll_ind
Long    ll_Retry
Long    ll_Retorno

For ll_ind = 1 TO UpperBound(ps_tipo)
	
	ls_Pagto    = MidA(ps_tipo[ll_ind],1,2)
	ls_valor    = String(pd_valor[ll_ind])
	ls_parcelas = "0"
	ls_msg      = ""

	Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_EfetuaFormaPagamentoIndice(ls_Pagto,ls_valor),'ECF_EfetuaFormaPagamentoIndice')

		Choose Case ll_Retorno
			Case 1 				// Comando OK
				Exit
			Case 0 				// Erro ao executar comando
				Return False
			Case 100 			// Impressora ocupada
				Continue
			Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
				Return False
		End Choose
		
		ll_Retry ++

	Loop

Next

Return True
end function

public function boolean of_abreporta ();If This.ivb_modo_teste Or This.ivb_Porta_Aberta Then
	If IsValid(PDV) Then	
		PDV.ivb_Porta_Aberta = True		
	End If
	Return True
End If

If Not This.of_verifica_drivers() Then Return False

//Seta o diretorio, pois aqui est$$HEX1$$e100$$ENDHEX$$ setado o c:\client, que foi setado na abertura do sistema.
//Com a dll da SWEDA sou obrigado a fazer isso, pois setar o diretorio do executavel n$$HEX1$$e300$$ENDHEX$$o funcionou.
//ChangeDirectory( gvo_Aplicacao.ivs_Path_Sistema )
ChangeDirectory( 'c:\sistemas\dll\sweda' )

If This.of_Abre_Porta_Serial() Then
	If This.of_Conecta_Impressora() Then
		If This.of_Numero_Serie() Then
			If This.of_Marca_Modelo() Then
				If This.of_Configuracoes() Then
					Return True
				End If
			End If	
		End If
	End If
End If

Return False
end function

public function boolean of_suprimento_caixa (decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
DateTime ldt_data

This.of_data_hora_ecf(Ref ldt_Data)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_Suprimento(String(pdc_valor,"###,###,##0.00"),"Dinheiro"),'ECF_Suprimento')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			PDV.of_atualiza_primeira_venda_ecf(This.ECF, ldt_data, True)	
			
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

public function boolean of_sangria_caixa (decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_Sangria(String(pdc_valor,"###,###,##0.00")),'ECF_Sangria')
	
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

public function boolean of_leitura_memoria_fiscal_ac1704 (string ps_dado_inicio, string ps_dado_final);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_OrigemBin  = "C:\SWEDA\MFISCAL.MF"
String ls_Destino

ll_Retorno = This.of_Verifica_Retorno_ECF_MFD(ECF_DownloadMF("C:\SWEDA\MFISCAL.MF"),'ECF_DownloadMF')

If ll_Retorno <> 1 Then 
	Return False
End If

ls_Destino = "C:\"+ PDV.nr_Serie + "_" + String(Date(ps_dado_inicio),'ddmmyyyy') + "_" + String(Date(ps_dado_final),'ddmmyyyy') + ".txt"
	 
ll_Retorno = This.of_Verifica_Retorno_ECF_MFD(ECF_ReproduzirMemoriaFiscalMFD('3', ps_dado_inicio , ps_dado_final , ls_Destino, ls_OrigemBin),'ECF_ReproduzirMemoriaFiscalMFD')

If ll_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_abre_gaveta ();This.of_Verifica_Retorno_Ecf(ECF_AcionaGaveta(),'ECF_AcionaGaveta')

Return True
end function

public function boolean of_fecha_cupom (string ps_msg[], boolean pb_repete, string ps_indicadores[6, 2], string ps_vinculado);If This.ivb_Modo_Teste Then Return True

Long   ll_ind
Long   ll_Retry
Long   ll_Retorno

String ls_msg   = ''
String ls_linha = ''

ls_msg += Trim(ps_msg[1]) + CharA(10)

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

For ll_ind = 2 TO UpperBound(ps_msg)
	
	If Not IsNull(ps_msg [ll_ind]) and Trim(ps_msg [ll_ind]) <> "" Then
		
		ls_msg += Trim(MidA(ps_msg [ll_ind],1,60)) + CharA(10)	
		
	End If
	
Next

//ls_msg = CharA(27) + CharA(15) + ls_msg + CharA(27) + CharA(18)
ls_msg = CharA(16) + CharA(67) + ls_msg + CharA(13) + CharA(18)

Long lvl_Pos, lvl_Pos2

//lvl_Pos = Pos(ls_msg, "VOCE ECONOMIZOU")
//If lvl_Pos > 0 Then
//	ls_msg = Mid(ls_msg, 1, lvl_Pos - 1) + Char(27) + Char(69) + Mid(ls_msg, lvl_Pos, 30) + Char(27) + Char(70) + Mid(ls_msg, lvl_Pos + 30)
//End If 

lvl_Pos = PosA(ls_msg, "SUA ECONOMIA")
If lvl_Pos > 0 Then
	lvl_Pos2 = PosA(ls_msg, "PTOS CLUBE")
	If lvl_Pos2 > 0 Then
//		ls_msg = MidA(ls_msg, 1, lvl_Pos - 1) + CharA(27) + CharA(69) + MidA(ls_msg, lvl_Pos, 40) + CharA(27) + CharA(70) + MidA(ls_msg, lvl_Pos + 40)	
		ls_msg = MidA(ls_msg, 1, lvl_Pos - 1) + CharA(16) + CharA(66) + MidA(ls_msg, lvl_Pos, 40) + MidA(ls_msg, lvl_Pos + 40)	
	Else
//	   ls_msg = MidA(ls_msg, 1, lvl_Pos - 1) + CharA(27) + CharA(69) + MidA(ls_msg, lvl_Pos, 21) + CharA(27) + CharA(70) + MidA(ls_msg, lvl_Pos + 21)
	   ls_msg = MidA(ls_msg, 1, lvl_Pos - 1) + CharA(16) + CharA(66) + MidA(ls_msg, lvl_Pos, 21) + MidA(ls_msg, lvl_Pos + 21)
	End If
End If 
	
Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_TerminaFechamentoCupom(ls_msg),'ECF_TerminaFechamentoCupom')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose

	ll_Retry ++
		
Loop

Return True
end function

public function boolean of_atualiza_cadastro_ecf ();STRING ls_Marca, &
		 ls_Modelo, &
		 ls_Tipo, &
		 ls_CPD, &
		 ls_Serie

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

Select nr_ecf, de_fabricante, de_modelo, de_tipo 
Into :ll_ECF, :ls_Marca, :ls_Modelo, :ls_Tipo
From Impressora_fiscal
	Where nr_ecf = :This.Ecf
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case -1

		gvo_aplicacao.of_grava_log("Erro ao consultar Marca/Modelo/Tipo ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_atualiza_cadastro_ecf()."+Sqlca.SQLErrText)		
		Sqlca.of_MsgDbError('Consulta Marca/Modelo/Tipo ECF.')
		lb_Sucesso = False
		
	Case 100
		
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
		ls_modelo = LeftA(This.modelo,15)		
		
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
				  :ls_Modelo,   
				  :This.nr_Serie,
				  :This.de_Tipo,
				  :ldt_data_ecf,
				  '381902')
		Using Sqlca;
				  
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_RollBack()
			Sqlca.of_MsgDbError('Inclus$$HEX1$$e300$$ENDHEX$$o ECF.')
			gvo_aplicacao.of_grava_log("Erro ao incluir ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_atualiza_cadastro_ecf()."+Sqlca.SQLErrText)		
			Return False
		Else
			Sqlca.of_Commit()				
		End If
		
		lb_Sucesso = True
	
		This.ivb_Cadastrada = True		
		
	Case 0
		
		If (Trim(ls_Marca) = '' Or IsNull(ls_Marca)) Or &
			(Trim(ls_Modelo) = '' Or IsNull(ls_Modelo)) Or &
			(Trim(ls_Tipo) = '' Or IsNull(ls_Tipo)) Then
			
			ls_Marca = LeftA(This.de_marca,15)
			ls_modelo = LeftA(This.modelo,15)			
		
			Update impressora_fiscal
			Set de_fabricante = :ls_Marca,
				 de_modelo		= :ls_Modelo,
				 de_tipo			= :This.de_Tipo
			Where nr_ecf 		= :This.Ecf	 
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				gvo_aplicacao.of_grava_log("Erro ao atualizar Marca/Modelo/Tipo ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_atualiza_cadastro_ecf()."+Sqlca.SQLErrText)		
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

public function boolean of_data_hora_ecf (ref datetime pdt_data);Date ld_DataEcf
String ls_Hora, ls_Data

If Not This.Of_HoraEcf(Ref ls_Hora)          Then Return False

If Not This.of_dataecf(Ref ld_dataecf)       Then Return False

ls_Data = String(ld_DataEcf)

pdt_Data = DateTime(Date(ls_Data),Time(ls_Hora))

Return True
end function

public function boolean of_atualiza_drivers ();
Boolean	lb_Sucesso 		= True
Boolean	lb_Existe 		= False

String	ls_Path_System
String	ls_Path
String ls_Error
String	ls_Path_dll = 'C:\sistemas\dll\sweda'

String	ls_Versao
String	ls_Valor
String ls_Baixar[]
String ls_Validar[]
String ls_arquivos[]
String ls_arquivo

Long ll_arquivo
Long ll_File

ls_Validar = {"CONVECF.DLL", "SWMFD.DLL", "RSA.BIN"}
ls_Baixar  = {'sweda.zip'}

If gvo_Aplicacao.of_is64bits() Then
	ls_Path_System = 'C:\Windows\SysWOW64'
Else
	ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
End If	

If Not FileExists(ls_Path_System + '\' + "AZIP32.DLL") Or Not FileExists(ls_Path_System + '\' + "aunzip32.dll") Then		
	
	Open(w_Aguarde_1)
				
	dc_uo_ftp lo_Ftp
	lo_Ftp = Create dc_uo_ftp
	
	Select vl_parametro
	Into :ls_Valor
	from parametro_loja
	Where cd_parametro = 'DE_SERVIDOR_DOWNLOAD_VERSAO_MATRIZ'
	Using SqlCa;
 
	Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_LogDbError(gvo_Aplicacao.ivi_Log)
		lb_Sucesso = False
		
	Case 100
		gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi encontrado o par$$HEX1$$e200$$ENDHEX$$metro 'DE_SERVIDOR_DOWNLOAD_VERSAO_MATRIZ' na tabela par$$HEX1$$e200$$ENDHEX$$metro_loja")
		lb_Sucesso = False
		
	Case 0
		lb_Sucesso = True
	End Choose	
	
	If lb_Sucesso Then	
		
		If lo_Ftp.of_Conecta_Ftp("Verifica Versao", ls_Valor, "pdv2", "pdv2") Then
			
			lo_Ftp.of_Ftp_Set_Dir('dll')
			
			If Not FileExists(ls_Path_System + '\' + "AZIP32.DLL") Then
				
				lb_Sucesso = False
				
				w_Aguarde_1.Title = "Atualizando driver ... " + "azip32.dll"
				
				ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
			
				If lo_Ftp.of_Ftp_GetFile('AZIP32.DLL', ls_Path_System + '\' + "AZIP32.DLL") Then
					lb_Sucesso = True				
				End If
				
			End If
			
			If Not FileExists(ls_Path_System + '\' + "aunzip32.dll") And lb_Sucesso Then
				
				lb_Sucesso = False
				
				w_Aguarde_1.Title = "Atualizando driver ... " + "aunzip32.dll"
			
				If lo_Ftp.of_Ftp_GetFile('aunzip32.dll', ls_Path_System + '\' + "aunzip32.dll") Then
					lb_Sucesso = True
				End If
				
			End If
		End If				
	End If
End If

dc_uo_api lo_api
lo_api = Create dc_uo_api

If FileExists(ls_Path_System + "\convecf.dll")  And lb_Sucesso Then
	
	If Not FileExists(ls_Path_dll) Then
		lo_Api.of_Create_Directory(ls_Path_dll)
	End If	
	//Move para diretorio das dlls	
	If Not lo_api.of_move_file(ls_Path_System + '\swmfd.dll', ls_Path_dll + '\swmfd.dll', true, true) Then lb_Sucesso = False
	If Not lo_api.of_move_file(ls_Path_System + '\CONVECF.dll', ls_Path_dll + '\CONVECF.dll', true, true) Then lb_Sucesso = False
	
End If
	
If Not FileExists(ls_Path_dll + "\convecf.dll") And lb_Sucesso Then			
	lb_Sucesso = gf_Download_Matriz(ls_Validar, ls_Baixar, ls_Path_dll, "dll_sweda", True)
End If

destroy(lo_api)

If IsValid(lo_Ftp) Then Destroy lo_Ftp

If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)

Return lb_Sucesso
end function

public function boolean of_codigo_barras (integer pl_tipo, string ps_codigo, string ps_tamanho);Long lvl_Retorno
String lvs_Codigo

//Configura Codigo barras
lvl_Retorno = This.of_Verifica_Retorno_ECF(ECF_ConfiguraCodigoBarrasMFD(80,1,0,0,0),'ECF_ConfiguraCodigoBarrasMFD')

If lvl_Retorno > 0 Then	
	Choose Case pl_tipo
		Case 0
			lvl_Retorno = This.of_Verifica_Retorno_ECF(ECF_CodigoBarrasEAN13MFD(ps_codigo),'ECF_CodigoBarrasEAN13MFD')
		Case 1
			lvl_Retorno = This.of_Verifica_Retorno_ECF(ECF_CodigoBarrasCODABARMFD(ps_codigo),'ECF_CodigoBarrasCODABARMFD')
		Case 2
			lvl_Retorno = This.of_Verifica_Retorno_ECF(ECF_CodigoBarrasCODE39MFD(ps_codigo),'ECF_CodigoBarrasCODE39MFD')			
		Case 3
			lvl_Retorno = This.of_Verifica_Retorno_ECF(ECF_CodigoBarrasEAN8MFD(ps_codigo),'ECF_CodigoBarrasEAN8MFD')						
		Case 4
			//Para usar esse formato de codigo de barras, o tamanho do codigo deve ser de 16 digitos
			//Este $$HEX1$$e900$$ENDHEX$$ o unico codigo de barras que na Sweda n$$HEX1$$e300$$ENDHEX$$o inclui digito verificador no final.
			ps_codigo = FillA("0",4) + ps_codigo
			lvl_Retorno = This.of_Verifica_Retorno_ECF(ECF_CodigoBarrasITFMFD(ps_codigo),'ECF_CodigoBarrasITFMFD')						
		Case 5
			lvl_Retorno = This.of_Verifica_Retorno_ECF(ECF_CodigoBarrasUPCAMFD(ps_codigo),'ECF_CodigoBarrasUPCAMFD')						
		Case 6
			lvl_Retorno = This.of_Verifica_Retorno_ECF(ECF_CodigoBarrasUPCEMFD(ps_codigo),'ECF_CodigoBarrasUPCEMFD')									
		Case Else
			lvl_Retorno = This.of_Verifica_Retorno_ECF(ECF_CodigoBarrasEAN13MFD(ps_codigo),'ECF_CodigoBarrasEAN13MFD')
	End Choose		
End If

If lvl_Retorno > 0 Then
	lvs_Codigo = ps_codigo + '0'
	This.of_Verifica_Retorno_ECF(ECF_RelatorioGerencial(lvs_codigo),'ECF_RelatorioGerencial')
End If

If lvl_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_fecha_comprovante_nao_finalizado ();String lvs_aut,&
         lvs_slip,&
		lvs_bobina,&
		lvs_status,&
		lvs_transacao 	

Decimal {2} lvdc_Soma

This.ivb_Porta_Aberta = False
PDV.ivb_Porta_Aberta = False

If Not This.of_Abre_Porta_Serial() Then Return False
	
If Not This.of_Conecta_Impressora() Then Return False

If Not This.of_Configuracoes() Then Return False

If Not of_fecha_cupom_nao_fiscal() Then Return False		

Return True
end function

public function boolean of_inicializa_comprovante_nao_fiscal (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

String	ls_Pagamento
String	ls_Forma_Pagamento 

Choose Case ps_tipo_pagamento
	Case "01" ; ls_Forma_Pagamento = "DINHEIRO"
	Case "02" ; ls_Forma_Pagamento = "CHEQUE"
	Case "03" ; ls_Forma_Pagamento = "CHEQUE-PRE"
	Case "04" ; ls_Forma_Pagamento = "CARTAO CREDITO"
	Case "05" ; ls_Forma_Pagamento = "CARTAO DEBITO"
	Case "06" ; ls_Forma_Pagamento = "CONVENIO"
	Case "07" ; ls_Forma_Pagamento = "CREDIARIO"
	Case "08" ; ls_Forma_Pagamento = "CONTA CORRENTE	"
	Case "09" ; ls_Forma_Pagamento = "CLUBE"
	Case "10" ; ls_Forma_Pagamento = "PBM"
	Case "11" ; ls_Forma_Pagamento = "RECARGA"
End Choose

//Retorna descri$$HEX2$$e700e300$$ENDHEX$$o do meio de pagamento
ls_Pagamento = of_meio_pagamento(ps_tipo_pagamento)

If Not of_inicializa_recebimento_nao_fiscal() Then Return False

If Not of_efetua_recebimento_nao_fiscal(ps_tipo_recebimento,String(pdc_valor)) Then Return False

If Not of_Registra_documento_ecf('CN',ls_Forma_Pagamento,pdc_valor) Then Return False

If Not of_totaliza_recebimento_nao_fiscal(ps_tipo_pagamento,String(pdc_valor)) Then Return False

If Not of_fecha_recebimento_nao_fiscal(ps_descricao) Then Return False

Return True
end function

public function boolean of_inicializa_cupom (string ps_cpf_cgc);If This.ivb_Modo_Teste Then Return True

Long ll_Sequencia,&
     ll_Retorno,&
     ll_Ecf

ivb_showerror = FALSE

Do While ll_Retorno <> 1 

	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_AbreCupomMFD(ps_cpf_cgc,"",""),'ECF_AbreCupomMFD')
	
	Choose Case ll_Retorno
		Case 1 						// Comando OK
	
			If of_Status_ECF() = -1 Then
				
				If This.St3 = 33 Then
		
					gvo_aplicacao.of_grava_log("Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_inicializa_cupom().")	
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente.",Exclamation!)

					If Not of_cancela_Recebimento_Nao_Fiscal() Then Return False
					
					Return of_Inicializa_Cupom(ps_cpf_cgc)
					
				End If
				
			End If	
			
			If This.St3 = 0 Then Return True
			
			Return False
			
		Case 100 					// Impressora ocupada
			Continue
		Case -1 					// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida
			Return False
		Case 0 						// Erro ao executar comando

			If This.Ack >= 1 Then	// Cupom Fiscal Aberto

				If Not This.of_nr_cupom(Ref ll_Sequencia) Then Return False
				
				If Of_Cupom_Gravado(ll_sequencia,ll_ecf) Then

					Of_msg_Cupom_Aberto_Gravado()

				Else

					Of_msg_Cupom_Aberto()

					IF Not PDV.of_cancela_ultimo_cupom(False) Then Return False					

					If of_inicializa_cupom(ps_cpf_cgc) Then Return True

				End If				
				
			End If
			
	End Choose
	
Loop
end function

public function boolean of_abertura_dia ();If This.ivb_Modo_Teste Then Return True

ECF_AberturaDoDia("0,00", "Dinheiro")

Return True
end function

public function boolean of_atualiza_numero_seriemfd ();Boolean lvb_Sucesso = False
DateTime ldh_Ultima_Venda

Select max(dh_emissao) Into :ldh_Ultima_Venda
From nf_venda
Where nr_ecf = :This.Ecf 
  and	dh_movimentacao_caixa >= cast( getdate() as date ) -2
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Data Ultima Venda ECF no sistema.')
	gvo_aplicacao.of_grava_log("Erro ao localizar data $$HEX1$$fa00$$ENDHEX$$ltima venda ECF no sistema, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_atualiza_numero_seriemfd()."+Sqlca.SQLErrText)	
//	Return False
End If	

If IsNull(ldh_Ultima_Venda) Then

	Update impressora_fiscal
	Set nr_serie_mfd = :This.nr_Serie		
	Where nr_ecf = :This.Ecf
	Using Sqlca;
	
Else

	Update impressora_fiscal
	Set nr_serie_mfd = :This.nr_Serie,
		 dh_ultima_venda = :ldh_Ultima_Venda 
	Where nr_ecf = :This.Ecf
	Using Sqlca;

End If

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_RollBack()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF.~n~n Erro: " + Sqlca.SqlErrText)
	gvo_aplicacao.of_grava_log("Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_atualiza_numero_seriemfd()."+Sqlca.SQLErrText)		
Else			
	Sqlca.of_Commit()
	lvb_Sucesso = True
End If	

Return lvb_Sucesso
end function

public function boolean of_grande_total (ref decimal pdc_venda);If This.ivb_Modo_Teste Then Return True

String ls_Valor
Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Valor = Space(18)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_GrandeTotal(Ref ls_Valor),'ECF_GrandeTotal')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

If lb_Sucesso Then
	pdc_venda = Dec(ls_Valor) / 100
Else
	pdc_venda = 000.00
End If

Return lb_Sucesso
end function

public function boolean of_carrega_dados_ecf (long pl_ecf);Select nr_serie,   
		 id_situacao,   
		 de_fabricante,   
		 de_modelo,   
 		 de_tipo,   
		 dh_ultima_venda,   
		 pc_livre_mfd,   
		 id_mfadicional,   
		 dh_swbasico,   
		 nr_versao_swbasico  
 Into :This.nr_Serie,
		:This.Id_Situacao,
		:This.de_marca,
		:This.modelo,
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
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o de par$$HEX1$$e200$$ENDHEX$$metros da ECF.')
	Return False
End If

Return True
end function

public function boolean of_contador_credito_debito (ref long pl_contador);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Contador

ls_Contador = Space(4)

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ContadorComprovantesCreditoMFD(Ref ls_Contador),'ECF_ContadorComprovantesCreditoMFD')
	
	pl_contador = Long(ls_Contador)
		
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

public function boolean of_contador_cupom_fiscal (ref long pl_contador);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Contador

ls_Contador = Space(6)

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ContadorCupomFiscalMFD(Ref ls_Contador),'ECF_ContadorCupomFiscalMFD')
	
	pl_contador = Long(ls_Contador)
		
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

public function boolean of_contador_operacao_nao_fiscal (ref long pl_contador);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Contador

ls_Contador = Space(6)

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_NumeroOperacoesNaoFiscais(Ref ls_Contador),'ECF_NumeroOperacoesNaoFiscais')
	
	pl_contador = Long(ls_Contador)
		
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

public function boolean of_contador_relatorio_gerencial (ref long pl_contador);If This.ivb_Modo_Teste Then Return True

Long ll_Retry

Long ll_Retorno

String ls_Contador

ls_Contador = Space(6)

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ContadorRelatoriosGerenciaisMFD(Ref ls_Contador),'ECF_ContadorRelatoriosGerenciaisMFD')
	
	pl_contador = Long(ls_Contador)
		
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

public function boolean of_nr_cupom (ref long pl_sequencial);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Caixa
String ls_Cupom

SetPointer(HourGlass!)

ls_Cupom = Space(6)

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_NumeroCupom(Ref ls_Cupom),'ECF_NumeroCupom')
	
	pl_sequencial = Long(ls_Cupom)
		
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_data_hora_usuario_software_basico ();If This.ivb_Modo_Teste Then Return True

String ls_DataUsuario
String ls_DataSWBasico
String ls_MFAdicional

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_dataUsuario	 = Space(20)
ls_dataSWBasico = Space(20)
ls_MFAdicional  = Space(5)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DataHoraGravacaoUsuarioSWBasicoMFAdicional(Ref ls_DataUsuario, Ref ls_DataSWBasico, Ref ls_MFAdicional),'ECF_DataHoraGravacaoUsuarioSWBasicoMFAdicional')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			If Trim(ls_MFAdicional) = '' Then 
				ls_MFAdicional = 'N'
			Else
				ls_MFAdicional = 'S'	
			End If	
				
			This.id_MFAdicional = ls_MFAdicional
			This.dh_SWBasico    = DateTime(Date(LeftA(ls_DataSWBasico,10)),Time(RightA(ls_DataSWBasico,08)))
	
			Update impressora_fiscal
			Set id_mfadicional = :This.id_MFAdicional,
			    dh_swbasico    = :This.dh_SWBasico
			Where nr_ecf = :This.Ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF.~n~n Erro: " + Sqlca.SqlErrText,Exclamation!)
				gvo_aplicacao.of_grava_log("Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_data_hora_usuario_software_basico()."+Sqlca.SQLErrText)	
				lb_Sucesso = False
			Else			
				Sqlca.of_Commit()
				lb_Sucesso = True
			End If	
			
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return lb_Sucesso
end function

public function boolean of_data_ultima_reducaoz (ref date pd_datafiscal);If This.ivb_Modo_Teste Then Return True

String ls_DataMovimento
String ls_Hora
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_DataMovimento = Space(6)
ls_Hora = Space(6)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DataHoraReducao(Ref ls_DataMovimento, Ref ls_Hora),'ECF_DataHoraReducao')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

If lb_Sucesso Then

	If Long(MidA(ls_DataMovimento,5,2)) <= 60 Then
		ls_Ano = '20'
	Else
		ls_Ano = '19'
	End If
	
	ls_DataMovimento = MidA(ls_DataMovimento,1,2)+"/"+MidA(ls_DataMovimento,3,2)+"/"+ls_Ano+MidA(ls_DataMovimento,5,2)
	
	pd_datafiscal = Date(ls_DataMovimento)

End If

Return lb_Sucesso
end function

public function boolean of_data_ultimo_documento_fiscal (ref datetime pd_datahora);If This.ivb_Modo_Teste Then Return True

String ls_Hora
String ls_DataMovimento
String ls_Data
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Data = Space(12)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DataHoraUltimoDocumentoMFD(Ref ls_Data),'ECF_DataHoraUltimoDocumentoMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

If lb_Sucesso Then

	If Long(MidA(ls_Data,5,2)) <= 60 Then
		ls_Ano = '20'
	Else
		ls_Ano = '19'
	End If
	
	ls_DataMovimento = MidA(ls_Data,1,2)+"/"+MidA(ls_Data,3,2)+"/"+ls_Ano+MidA(ls_Data,5,2)
	
	ls_Hora = MidA(ls_Data,07,02) + ":" + MidA(ls_Data,09,02) + ":" + MidA(ls_Data,11,02)
	
	pd_DataHora = DateTime(Date(ls_DataMovimento),Time(ls_Hora))

End If

Return lb_Sucesso

end function

public function boolean of_efetua_recebimento_nao_fiscal (string ps_tipo, string ps_valor);If This.ivb_Modo_Teste Then Return True

Integer li_File
String  ls_msg
String ls_CPD

Long    ll_Retry
Long    ll_Retorno

ls_CPD = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF", "CPD","")

If Trim(UPPER(ls_CPD)) = 'SIM' Then 
	If ps_tipo = '02' Then ps_tipo = '05'
	If ps_tipo = '03' Then ps_tipo = '06'
End If	

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_EfetuaRecebimentoNaoFiscalMFD(ps_tipo,ps_valor),'ECF_EfetuaRecebimentoNaoFiscalMFD')

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			  // Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++
	
Loop

Return True
end function

public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long    ll_linha

String  ls_Relatorio
String  ls_Texto

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

If Not of_inicializa_relatorio_gerencial(ls_Relatorio, pdc_valor) Then
Tenta_Iniciar:
	If Not This.of_pergunta_tentativa(true) Then	
		If IsNull(PDV.ivs_Tipo_Venda) Or PDV.ivs_Tipo_Venda = "TR" Then	
			SITEF.of_transacao_pendente(This.ECF, PDV.cd_caixa)
		End If
		Return False
	Else		
		If Not of_inicializa_relatorio_gerencial(ls_Relatorio,pdc_valor) Then Goto Tenta_Iniciar
	End If
End If

If Not This.of_imprime_relatorio_gerencial(ps_texto,ls_Relatorio) Then
	If Not This.of_pergunta_tentativa(false) Then	
		If IsNull(PDV.ivs_Tipo_Venda) Or PDV.ivs_Tipo_Venda = "TR" Then	
			SITEF.of_transacao_pendente(This.ECF, PDV.cd_caixa)
		End If
		Return False
	Else					
		
		If Not of_inicializa_relatorio_gerencial(ls_Relatorio,pdc_valor) Then Return False		
		
		If Not This.of_imprime_relatorio_gerencial(ps_texto,ls_Relatorio) Then Return False					
		
	End If
End If	

If Not This.of_fecha_relatorio_gerencial() Then Return False 

Close(w_Janela_Aguarde)

Return True
end function

public subroutine of_status_extendido_ecf ();Long ll_Ack
Long ll_St1
Long ll_St2
Long ll_St3
Long ll_Retorno

String ls_Msg

ll_St1 = This.St1
ll_St2 = This.St2
ll_St3 = This.St3

ls_Msg = ''

If ll_St1 >= 128 Then                 // bit 7
	ll_St1 = ll_St1 - 128 
	ls_Msg += "Fim de Papel" 
End If 
If ll_St1 >= 64 Then                  // bit 6 
	ll_St1 = ll_St1 - 64 
	ls_Msg += " : Pouco Papel" 
End If 
If ll_St1 >= 32 Then                  // bit 5 
	ll_St1 = ll_St1 - 32 
	ls_Msg += " : Erro no Rel$$HEX1$$f300$$ENDHEX$$gio" 
End If 
If ll_St1 >= 16 Then                  // bit 4 
	ll_St1 = ll_St1 - 16 
	ls_Msg += " : Impressora em Erro" 
End If 
If ll_St1 >= 8 Then                  // bit 3 
	ll_St1 = ll_St1 - 8 
	ls_Msg += " : Comando n$$HEX1$$e300$$ENDHEX$$o iniciado com ESC" 
End If 
If ll_St1 >= 4 Then                  // bit 2 
	ll_St1 = ll_St1 - 4 
	ls_Msg += " : Comando Inexistente" 
End If 
If ll_St1 >= 2 Then                  // bit 1 
	ll_St1 = ll_St1 - 2 
	ls_Msg += " : Cupom Aberto" 
End If 
If ll_St1 >= 1 Then                  // bit 0 
	ll_St1 = ll_St1 - 1 
	ls_Msg += " : N$$HEX1$$fa00$$ENDHEX$$mero de Par$$HEX1$$e200$$ENDHEX$$metro(s) Inv$$HEX1$$e100$$ENDHEX$$lido(s)" 
End If 

// Codificando o ll_St2

If ll_St2 >= 128 Then                  // bit 7 
   ll_St2 = ll_St2 - 128 
   ls_Msg += " : Tipo de Par$$HEX1$$e200$$ENDHEX$$metro de Comando Inv$$HEX1$$e100$$ENDHEX$$lido" 
End If 
If ll_St2 >= 64 Then                  // bit 6 
   ll_St2 = ll_St2 - 64 
   ls_Msg += " : Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal Lotada" 
End If 
If ll_St2 >= 32 Then                  // bit 5 
   ll_St2 = ll_St2 - 32 
   ls_Msg += " : Erro na Mem$$HEX1$$f300$$ENDHEX$$ria RAM" 
End If 
If ll_St2 >= 16 Then                  // bit 4 
   ll_St2 = ll_St2 - 16 
   ls_Msg += " : Al$$HEX1$$ed00$$ENDHEX$$quota N$$HEX1$$e300$$ENDHEX$$o Programada" 
End If 
If ll_St2 >= 8 Then                  // bit 3 
   ll_St2 = ll_St2 - 8 
   ls_Msg += " : Capacidade de Al$$HEX1$$ed00$$ENDHEX$$quotas Lotada" 
End If 
If ll_St2 >= 4 Then                  // bit 2 
   ll_St2 = ll_St2 - 4 
   ls_Msg += " : Cancelamento N$$HEX1$$e300$$ENDHEX$$o Permitido" 
End If 
If ll_St2 >= 2 Then                  // bit 1 
   ll_St2 = ll_St2 - 2 
   ls_Msg += " : CNPJ/IE do Propriet$$HEX1$$e100$$ENDHEX$$rio N$$HEX1$$e300$$ENDHEX$$o Programado" 
End If 
If ll_St2 >= 1 Then                  // bit 0 
   ll_St2 = ll_St2 - 1 
   ls_Msg += " : Comando N$$HEX1$$e300$$ENDHEX$$o Executado" 
End If 

ls_Msg += This.Of_Status_St3()
/*Choose Case ll_St3
	Case 1   ; ls_Msg += ' : COMANDO INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 2   ; ls_Msg += ' : ERRO DESCONHECIDO'
	Case 3   ; ls_Msg += ' : N$$HEX1$$da00$$ENDHEX$$MERO DE PAR$$HEX1$$c200$$ENDHEX$$METRO INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 4   ; ls_Msg += ' : TIPO DE PAR$$HEX1$$c200$$ENDHEX$$METRO INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 5   ; ls_Msg += ' : TODAS AL$$HEX1$$cd00$$ENDHEX$$QUOTAS J$$HEX1$$c100$$ENDHEX$$ PROGRAMADAS'
	Case 6   ; ls_Msg += ' : TOTALIZADOR N$$HEX1$$c300$$ENDHEX$$O FISCAL J$$HEX1$$c100$$ENDHEX$$ PROGRAMADO'
	Case 7   ; ls_Msg += ' : CUPOM FISCAL ABERTO'
	Case 8   ; ls_Msg += ' : CUPOM FISCAL FECHADO'
	Case 9   ; ls_Msg += ' : ECF OCUPADO'
	Case 10  ; ls_Msg += ' : IMPRESSORA EM ERRO'
	Case 11  ; ls_Msg += ' : IMPRESSORA SEM PAPEL'
	Case 12  ; ls_Msg += ' : IMPRESSORA COM CABE$$HEX1$$c700$$ENDHEX$$A LEVANTADA'
	Case 13  ; ls_Msg += ' : IMPRESSORA OFF LINE'
	Case 14  ; ls_Msg += ' : AL$$HEX1$$cd00$$ENDHEX$$QUOTA N$$HEX1$$c300$$ENDHEX$$O PROGRAMADA'
	Case 15  ; ls_Msg += ' : TERMINADOR DE STRING FALTANDO'
	Case 16  ; ls_Msg += ' : ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO MAIOR QUE O TOTAL DO CUPOM FISCAL'
	Case 17  ; ls_Msg += ' : CUPOM FISCAL SEM ITEM VENDIDO'
	Case 18  ; ls_Msg += ' : COMANDO N$$HEX1$$c300$$ENDHEX$$O EFETIVADO'
	Case 19  ; ls_Msg += ' : SEM ESPA$$HEX1$$c700$$ENDHEX$$O PARA NOVAS FORMAS DE PAGAMENTO'
	Case 20  ; ls_Msg += ' : FORMA DE PAGAMENTO N$$HEX1$$c300$$ENDHEX$$O PROGRAMADA'
	Case 21  ; ls_Msg += ' : $$HEX1$$cd00$$ENDHEX$$NDICE MAIOR QUE N$$HEX1$$da00$$ENDHEX$$MERO DE FORMA DE PAGAMENTO'
	Case 22  ; ls_Msg += ' : FORMAS DE PAGAMENTO ENCERRADAS'
	Case 23  ; ls_Msg += ' : CUPOM N$$HEX1$$c300$$ENDHEX$$O TOTALIZADO'
	Case 24  ; ls_Msg += ' : COMANDO MAIOR QUE 7Fh (127d)'
	Case 25  ; ls_Msg += ' : CUPOM FISCAL ABERTO E SEM $$HEX1$$cd00$$ENDHEX$$TEM'
	Case 26  ; ls_Msg += ' : CANCELAMENTO N$$HEX1$$c300$$ENDHEX$$O IMEDIATAMENTE AP$$HEX1$$d300$$ENDHEX$$S'
	Case 27  ; ls_Msg += ' : CANCELAMENTO J$$HEX1$$c100$$ENDHEX$$ EFETUADO'
	Case 28  ; ls_Msg += ' : COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO OU J$$HEX1$$c100$$ENDHEX$$ EMITIDO'
	Case 29  ; ls_Msg += ' : MEIO DE PAGAMENTO N$$HEX1$$c300$$ENDHEX$$O PERMITE TEF'
	Case 30  ; ls_Msg += ' : SEM COMPROVANTE N$$HEX1$$c300$$ENDHEX$$O FISCAL ABERTO'
	Case 31  ; ls_Msg += ' : COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO J$$HEX1$$c100$$ENDHEX$$ ABERTO'
	Case 32  ; ls_Msg += ' : REIMPRESS$$HEX1$$c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA'
	Case 33  ; ls_Msg += ' : COMPROVANTE N$$HEX1$$c300$$ENDHEX$$O FISCAL J$$HEX1$$c100$$ENDHEX$$ ABERTO'
	Case 34  ; ls_Msg += ' : TOTALIZADOR N$$HEX1$$c300$$ENDHEX$$O FISCAL N$$HEX1$$c300$$ENDHEX$$O PROGRAMADO'
	Case 35  ; ls_Msg += ' : CUPOM N$$HEX1$$c300$$ENDHEX$$O FISCAL SEM $$HEX1$$cd00$$ENDHEX$$TEM VENDIDO'
	Case 36  ; ls_Msg += ' : ACR$$HEX1$$c900$$ENDHEX$$SCIMO E DESCONTO MAIOR QUE TOTAL CNF'
	Case 37  ; ls_Msg += ' : MEIO DE PAGAMENTO N$$HEX1$$c300$$ENDHEX$$O INDICADO'
	Case 38  ; ls_Msg += ' : MEIO DE PAGAMENTO DIFERENTE DO TOTAL DO RECEBIMENTO'
	Case 39  ; ls_Msg += ' : N$$HEX1$$c300$$ENDHEX$$O PERMITIDO MAIS DE UMA SANGRIA OU SUPRIMENTO'
	Case 40  ; ls_Msg += ' : RELAT$$HEX1$$d300$$ENDHEX$$RIO GERENCIAL J$$HEX1$$c100$$ENDHEX$$ PROGRAMADO'
	Case 41  ; ls_Msg += ' : RELAT$$HEX1$$d300$$ENDHEX$$RIO GERENCIAL N$$HEX1$$c300$$ENDHEX$$O PROGRAMADO'
	Case 42  ; ls_Msg += ' : RELAT$$HEX1$$d300$$ENDHEX$$RIO GERENCIAL N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 43  ; ls_Msg += ' : MFD N$$HEX1$$c300$$ENDHEX$$O INICIALIZADA'
	Case 44  ; ls_Msg += ' : MFD AUSENTE'
	Case 45  ; ls_Msg += ' : MFD SEM N$$HEX1$$da00$$ENDHEX$$MERO DE S$$HEX1$$c900$$ENDHEX$$RIE'
	Case 46  ; ls_Msg += ' : MFD J$$HEX1$$c100$$ENDHEX$$ INICIALIZADA'
	Case 47  ; ls_Msg += ' : MFD LOTADA'
	Case 48  ; ls_Msg += ' : CUPOM N$$HEX1$$c300$$ENDHEX$$O FISCAL ABERTO'
	Case 49  ; ls_Msg += ' : MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL DESCONECTADA'
	Case 50  ; ls_Msg += ' : MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL SEM N$$HEX1$$da00$$ENDHEX$$MERO DE S$$HEX1$$c900$$ENDHEX$$RIE DA MFD'
	Case 51  ; ls_Msg += ' : MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL LOTADA'
	Case 52  ; ls_Msg += ' : DATA INICIAL INV$$HEX1$$c100$$ENDHEX$$LIDA'
	Case 53  ; ls_Msg += ' : DATA FINAL INV$$HEX1$$c100$$ENDHEX$$LIDA'
	Case 54  ; ls_Msg += ' : CONTADOR DE REDU$$HEX2$$c700c300$$ENDHEX$$O Z INICIAL INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 55  ; ls_Msg += ' : CONTADOR DE REDU$$HEX2$$c700c300$$ENDHEX$$O Z FINAL INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 56  ; ls_Msg += ' : ERRO DE ALOCA$$HEX2$$c700c300$$ENDHEX$$O'
	Case 57  ; ls_Msg += ' : DADOS DO RTC INCORRETOS'
	Case 58  ; ls_Msg += ' : DATA ANTERIOR AO $$HEX1$$da00$$ENDHEX$$LTIMO DOCUMENTO EMITIDO'
	Case 59  ; ls_Msg += ' : FORA DE INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA'
	Case 60  ; ls_Msg += ' : EM INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA'
	Case 61  ; ls_Msg += ' : ERRO NA MEM$$HEX1$$d300$$ENDHEX$$RIA DE TRABALHO'
	Case 62  ; ls_Msg += ' : J$$HEX1$$c100$$ENDHEX$$ HOUVE MOVIMENTO NO DIA'
	Case 63  ; ls_Msg += ' : BLOQUEIO POR RZ'
	Case 64  ; ls_Msg += ' : FORMA DE PAGAMENTO ABERTA'
	Case 65  ; ls_Msg += ' : AGUARDANDO PRIMEIRO PROPRIET$$HEX1$$c100$$ENDHEX$$RIO'
	Case 66  ; ls_Msg += ' : AGUARDANDO RZ'
	Case 67  ; ls_Msg += ' : ECF OU LOJA IGUAL A ZERO'
	Case 68  ; ls_Msg += ' : CUPOM ADICIONAL N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 69  ; ls_Msg += ' : DESCONTO MAIOR QUE TOTAL VENDIDO EM ICMS'
	Case 70  ; ls_Msg += ' : RECEBIMENTO N$$HEX1$$c300$$ENDHEX$$O FISCAL NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 71  ; ls_Msg += ' : ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO MAIOR QUE TOTAL N$$HEX1$$c300$$ENDHEX$$O FISCAL'
	Case 72  ; ls_Msg += ' : MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL LOTADA PARA NOVO CARTUCHO'
	Case 73  ; ls_Msg += ' : ERRO DE GRAVA$$HEX2$$c700c300$$ENDHEX$$O NA MF'
	Case 74  ; ls_Msg += ' : ERRO DE GRAVA$$HEX2$$c700c300$$ENDHEX$$O NA MFD'
	Case 75  ; ls_Msg += ' : DADOS DO RTC ANTERIORES AO $$HEX1$$da00$$ENDHEX$$LTIMO DOC ARMAZENADO'
	Case 76  ; ls_Msg += ' : MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL SEM ESPA$$HEX1$$c700$$ENDHEX$$O PARA GRAVAR LEITURAS DA MFD'
	Case 77  ; ls_Msg += ' : MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL SEM ESPA$$HEX1$$c700$$ENDHEX$$O PARA GRAVAR VERSAO DO SB'
	Case 78  ; ls_Msg += ' : DESCRI$$HEX2$$c700c300$$ENDHEX$$O IGUAL A DEFAULT N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 79  ; ls_Msg += ' : EXTRAPOLADO N$$HEX1$$da00$$ENDHEX$$MERO DE REPETI$$HEX2$$c700d500$$ENDHEX$$ES PERMITIDAS'
	Case 80  ; ls_Msg += ' : SEGUNDA VIA DO COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 81  ; ls_Msg += ' : PARCELAMENTO FORA DA SEQU$$HEX1$$ca00$$ENDHEX$$NCIA'
	Case 82  ; ls_Msg += ' : COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO ABERTO'
	Case 83  ; ls_Msg += ' : TEXTO COM SEQU$$HEX1$$ca00$$ENDHEX$$NCIA DE ESC INV$$HEX1$$c100$$ENDHEX$$LIDA'
	Case 84  ; ls_Msg += ' : TEXTO COM SEQU$$HEX1$$ca00$$ENDHEX$$NCIA DE ESC INCOMPLETA'
	Case 85  ; ls_Msg += ' : VENDA COM VALOR NULO'
	Case 86  ; ls_Msg += ' : ESTORNO DE VALOR NULO'
	Case 87  ; ls_Msg += ' : FORMA DE PAGAMENTO DIFERENTE DO TOTAL DA SANGRIA'
	Case 88  ; ls_Msg += ' : REDU$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA EM INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA'
	Case 89  ; ls_Msg += ' : AGUARDANDO RZ PARA ENTRADA EM INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA'
	Case 90  ; ls_Msg += ' : FORMA DE PAGAMENTO COM VALOR NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 91  ; ls_Msg += ' : ACR$$HEX1$$c900$$ENDHEX$$SCIMO E DESCONTO MAIOR QUE VALOR DO $$HEX1$$cd00$$ENDHEX$$TEM'
	Case 92  ; ls_Msg += ' : AUTENTICA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA'
	Case 93  ; ls_Msg += ' : TIMEOUT NA VALIDA$$HEX2$$c700c300$$ENDHEX$$O'
	Case 94  ; ls_Msg += ' : COMANDO N$$HEX1$$c300$$ENDHEX$$O EXECUTADO EM IMPRESSORA BILHETE DE PASSAGEM'
	Case 95  ; ls_Msg += ' : COMANDO N$$HEX1$$c300$$ENDHEX$$O EXECUTADO EM IMPRESSORA DE CUPOM FISCAL'
	Case 96  ; ls_Msg += ' : CUPOM N$$HEX1$$c300$$ENDHEX$$O FISCAL FECHADO'
	Case 97  ; ls_Msg += ' : PAR$$HEX1$$c200$$ENDHEX$$METRO N$$HEX1$$c300$$ENDHEX$$O ASCII EM CAMPO ASCII'
	Case 98  ; ls_Msg += ' : PAR$$HEX1$$c200$$ENDHEX$$METRO N$$HEX1$$c300$$ENDHEX$$O ASCII NUM$$HEX1$$c900$$ENDHEX$$RICO EM CAMPO ASCII NUM$$HEX1$$c900$$ENDHEX$$RICO'
	Case 99  ; ls_Msg += ' : TIPO DE TRANSPORTE INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 100 ; ls_Msg += ' : DATA E HORA INV$$HEX1$$c100$$ENDHEX$$LIDA'
	Case 101 ; ls_Msg += ' : SEM RELAT$$HEX1$$d300$$ENDHEX$$RIO GERENCIAL OU COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO ABERTO'
	Case 102 ; ls_Msg += ' : N$$HEX1$$da00$$ENDHEX$$MERO DO TOTALIZADOR N$$HEX1$$c300$$ENDHEX$$O FISCAL INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 103 ; ls_Msg += ' : PAR$$HEX1$$c200$$ENDHEX$$METRO DE ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 104 ; ls_Msg += ' : ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO EM SANGRIA OU SUPRIMENTO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 105 ; ls_Msg += ' : N$$HEX1$$da00$$ENDHEX$$MERO DO RELAT$$HEX1$$d300$$ENDHEX$$RIO GERENCIAL INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 106 ; ls_Msg += ' : FORMA DE PAGAMENTO ORIGEM N$$HEX1$$c300$$ENDHEX$$O PROGRAMADA'
	Case 107 ; ls_Msg += ' : FORMA DE PAGAMENTO DESTINO N$$HEX1$$c300$$ENDHEX$$O PROGRAMADA'
	Case 108 ; ls_Msg += ' : ESTORNO MAIOR QUE FORMA PAGAMENTO'
	Case 109 ; ls_Msg += ' : CARACTER NUM$$HEX1$$c900$$ENDHEX$$RICO NA CODIFICA$$HEX2$$c700c300$$ENDHEX$$O GT N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 110 ; ls_Msg += ' : ERRO NA INICIALIZA$$HEX2$$c700c300$$ENDHEX$$O DA MF'
	Case 111 ; ls_Msg += ' : NOME DO TOTALIZADOR EM BRANCO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 112 ; ls_Msg += ' : DATA E HORA ANTERIORES AO $$HEX1$$da00$$ENDHEX$$LTIMO DOC ARMAZENADO'
	Case 113 ; ls_Msg += ' : PAR$$HEX1$$c200$$ENDHEX$$METRO DE ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 114 ; ls_Msg += ' : $$HEX1$$cd00$$ENDHEX$$TEM ANTERIOR AOS TREZENTOS $$HEX1$$da00$$ENDHEX$$LTIMOS'
	Case 115 ; ls_Msg += ' : $$HEX1$$cd00$$ENDHEX$$TEM N$$HEX1$$c300$$ENDHEX$$O EXISTE OU J$$HEX1$$c100$$ENDHEX$$ CANCELADO'
	Case 116 ; ls_Msg += ' : C$$HEX1$$d300$$ENDHEX$$DIGO COM ESPA$$HEX1$$c700$$ENDHEX$$OS N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 117 ; ls_Msg += ' : DESCRICAO SEM CARACTER ALFAB$$HEX1$$c900$$ENDHEX$$TICO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 118 ; ls_Msg += ' : ACR$$HEX1$$c900$$ENDHEX$$SCIMO MAIOR QUE VALOR DO $$HEX1$$cd00$$ENDHEX$$TEM'
	Case 119 ; ls_Msg += ' : DESCONTO MAIOR QUE VALOR DO $$HEX1$$cd00$$ENDHEX$$TEM'
	Case 120 ; ls_Msg += ' : DESCONTO EM ISS N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 121 ; ls_Msg += ' : ACR$$HEX1$$c900$$ENDHEX$$SCIMO EM $$HEX1$$cd00$$ENDHEX$$TEM J$$HEX1$$c100$$ENDHEX$$ EFETUADO'
	Case 122 ; ls_Msg += ' : DESCONTO EM $$HEX1$$cd00$$ENDHEX$$TEM J$$HEX1$$c100$$ENDHEX$$ EFETUADO'
	Case 123 ; ls_Msg += ' : ERRO NA MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL CHAMAR CREDENCIADO'
	Case 124 ; ls_Msg += ' : AGUARDANDO GRAVA$$HEX2$$c700c300$$ENDHEX$$O NA MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL'
	Case 125 ; ls_Msg += ' : CARACTER REPETIDO NA CODIFICA$$HEX2$$c700c300$$ENDHEX$$O DO GT'
	Case 126 ; ls_Msg += ' : VERS$$HEX1$$c300$$ENDHEX$$O J$$HEX1$$c100$$ENDHEX$$ GRAVADA NA MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL'
	Case 127 ; ls_Msg += ' : ESTOURO DE CAPACIDADE NO CHEQUE'
	Case 128 ; ls_Msg += ' : TIMEOUT NA LEITURA DO CHEQUE'
	Case 129 ; ls_Msg += ' : M$$HEX1$$ca00$$ENDHEX$$S INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 130 ; ls_Msg += ' : COORDENADA INV$$HEX1$$c100$$ENDHEX$$LIDA'
	Case 131 ; ls_Msg += ' : SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO'
	Case 132 ; ls_Msg += ' : SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO VALOR'
	Case 133 ; ls_Msg += ' : SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO EXTENSO'
	Case 134 ; ls_Msg += ' : SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO FAVORECIDO'
	Case 135 ; ls_Msg += ' : SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NA LOCALIDADE'
	Case 136 ; ls_Msg += ' : SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO OPCIONAL'
	Case 137 ; ls_Msg += ' : SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO DIA'
	Case 138 ; ls_Msg += ' : SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO M$$HEX1$$ca00$$ENDHEX$$S'
	Case 139 ; ls_Msg += ' : SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO ANO'
	Case 140 ; ls_Msg += ' : USANDO MFD DE OUTRO ECF'
	Case 141 ; ls_Msg += ' : PRIMEIRO DADO DIFERENTE DE ESC OU 1C'
	Case 142 ; ls_Msg += ' : N$$HEX1$$c300$$ENDHEX$$O PERMITIDO ALTERAR SEM INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA'
	Case 143 ; ls_Msg += ' : DADOS DA $$HEX1$$da00$$ENDHEX$$LTIMA RZ CORROMPIDOS'
	Case 144 ; ls_Msg += ' : COMANDO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO NO MODO INICIALIZA$$HEX2$$c700c300$$ENDHEX$$O'
	Case 145 ; ls_Msg += ' : AGUARDANDO ACERTO DE REL$$HEX1$$d300$$ENDHEX$$GIO'
	Case 146 ; ls_Msg += ' : MFD J$$HEX1$$c100$$ENDHEX$$ INICIALIZADA PARA OUTRA MF'
	Case 147 ; ls_Msg += ' : AGUARDANDO ACERTO DO REL$$HEX1$$d300$$ENDHEX$$GIO OU DESBLOQUEIO PELO TECLADO'
	Case 148 ; ls_Msg += ' : VALOR FORMA DE PAGAMENTO MAIOR QUE M$$HEX1$$c100$$ENDHEX$$XIMO PERMITIDO'
	Case 149 ; ls_Msg += ' : RAZ$$HEX1$$c300$$ENDHEX$$O SOCIAL EM BRANCO'
	Case 150 ; ls_Msg += ' : NOME DE FANTASIA EM BRANCO'
	Case 151 ; ls_Msg += ' : ENDERE$$HEX1$$c700$$ENDHEX$$O EM BRANCO'
	Case 152 ; ls_Msg += ' : ESTORNO DE CDC N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 153 ; ls_Msg += ' : DADOS DO PROPRIET$$HEX1$$c100$$ENDHEX$$RIO IGUAIS AO ATUAL'
	Case 154 ; ls_Msg += ' : ESTORNO DE FORMA DE PAGAMENTO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 155 ; ls_Msg += ' : DESCRI$$HEX2$$c700c300$$ENDHEX$$O FORMA DE PAGAMENTO IGUAL J$$HEX1$$c100$$ENDHEX$$ PROGRAMADA'
	Case 156 ; ls_Msg += ' : ACERTO DE HOR$$HEX1$$c100$$ENDHEX$$RIO DE VER$$HEX1$$c300$$ENDHEX$$O S$$HEX1$$d300$$ENDHEX$$ IMEDIATAMENTE AP$$HEX1$$d300$$ENDHEX$$S RZ'
	Case 157 ; ls_Msg += ' : IT N$$HEX1$$c300$$ENDHEX$$O PERMITIDA MF RESERVADA PARA RZ'
	Case 158 ; ls_Msg += ' : SENHA CNPJ INV$$HEX1$$c100$$ENDHEX$$LIDA'
	Case 159 ; ls_Msg += ' : TIMEOUT NA INICIALIZA$$HEX2$$c700c300$$ENDHEX$$O DA NOVA MF'
	Case 160 ; ls_Msg += ' : N$$HEX1$$c300$$ENDHEX$$O ENCONTRADO DADOS NA MFD'
	Case 161 ; ls_Msg += ' : SANGRIA OU SUPRIMENTO DEVEM SER $$HEX1$$da00$$ENDHEX$$NICOS NO CNF'
	Case 162 ; ls_Msg += ' : $$HEX1$$cd00$$ENDHEX$$NDICE DA FORMA DE PAGAMENTO NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 163 ; ls_Msg += ' : UF DESTINO INV$$HEX1$$c100$$ENDHEX$$LIDA'
	Case 164 ; ls_Msg += ' : TIPO DE TRANSPORTE INCOMPAT$$HEX1$$cd00$$ENDHEX$$VEL COM UF DESTINO'
	Case 165 ; ls_Msg += ' : DESCRI$$HEX2$$c700c300$$ENDHEX$$O DO PRIMEIRO $$HEX1$$cd00$$ENDHEX$$TEM DO BILHETE DE PASSAGEM DIFERENTE DE "TARIFA"'
	Case 166 ; ls_Msg += ' : AGUARDANDO IMPRESS$$HEX1$$c300$$ENDHEX$$O DE CHEQUE OU AUTENTICA$$HEX2$$c700c300$$ENDHEX$$O'
	Case 167 ; ls_Msg += ' : N$$HEX1$$c300$$ENDHEX$$O PERMITIDO PROGRAMA$$HEX1$$c700$$ENDHEX$$AO CNPJ IE COM ESPA$$HEX1$$c700$$ENDHEX$$OS EM BRANCO'
	Case 168 ; ls_Msg += ' : N$$HEX1$$c300$$ENDHEX$$O PERMITIDO PROGRAMA$$HEX2$$c700c300$$ENDHEX$$O UF COM ESPA$$HEX1$$c700$$ENDHEX$$OS EM BRANCO'
	Case 169 ; ls_Msg += ' : N$$HEX1$$da00$$ENDHEX$$MERO DE IMPRESS$$HEX1$$d500$$ENDHEX$$ES DA FITA DETALHE NESTA INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA ESGOTADO'
	Case 170 ; ls_Msg += ' : CF J$$HEX1$$c100$$ENDHEX$$ SUBTOTALIZADO'
	Case 171 ; ls_Msg += ' : CUPOM N$$HEX1$$c300$$ENDHEX$$O SUBTOTALIZADO'
	Case 172 ; ls_Msg += ' : ACR$$HEX1$$c900$$ENDHEX$$SCIMO EM SUBTOTAL J$$HEX1$$c100$$ENDHEX$$ EFETUADO'
	Case 173 ; ls_Msg += ' : DESCONTO EM SUBTOTAL J$$HEX1$$c100$$ENDHEX$$ EFETUADO'
	Case 174 ; ls_Msg += ' : ACR$$HEX1$$c900$$ENDHEX$$SCIMO NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 175 ; ls_Msg += ' : DESCONTO NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 176 ; ls_Msg += ' : CANCELAMENTO DE ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO EM SUBTOTAL N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 177 ; ls_Msg += ' : DATA INV$$HEX1$$c100$$ENDHEX$$LIDA'
	Case 178 ; ls_Msg += ' : VALOR DO CHEQUE NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 179 ; ls_Msg += ' : VALOR DO CHEQUE INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 180 ; ls_Msg += ' : CHEQUE SEM LOCALIDADE N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 181 ; ls_Msg += ' : CANCELAMENTO ACR$$HEX1$$c900$$ENDHEX$$SCIMO EM $$HEX1$$cd00$$ENDHEX$$TEM N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 182 ; ls_Msg += ' : CANCELAMENTO DESCONTO EM $$HEX1$$cd00$$ENDHEX$$TEM N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 183 ; ls_Msg += ' : N$$HEX1$$da00$$ENDHEX$$MERO M$$HEX1$$c100$$ENDHEX$$XIMO DE $$HEX1$$cd00$$ENDHEX$$TENS ATINGIDO'
	Case 184 ; ls_Msg += ' : N$$HEX1$$da00$$ENDHEX$$MERO DE $$HEX1$$cd00$$ENDHEX$$TEM NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 185 ; ls_Msg += ' : MAIS QUE DUAS AL$$HEX1$$cd00$$ENDHEX$$QUOTAS DIFERENTES NO BILHETE DE PASSAGEM N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 186 ; ls_Msg += ' : ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO EM ITEM N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 187 ; ls_Msg += ' : CANCELAMENTO DE ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO EM ITEM N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 188 ; ls_Msg += ' : CLICHE J$$HEX1$$c100$$ENDHEX$$ IMPRESSO'
	Case 189 ; ls_Msg += ' : TEXTO OPCIONAL DO CHEQUE EXCEDEU O M$$HEX1$$c100$$ENDHEX$$XIMO PERMITIDO'
	Case 190 ; ls_Msg += ' : IMPRESS$$HEX1$$c300$$ENDHEX$$O AUTOM$$HEX1$$c100$$ENDHEX$$TICA NO VERSO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO NESTE EQUIPAMENTO'
	Case 191 ; ls_Msg += ' : TIMEOUT NA INSER$$HEX2$$c700c300$$ENDHEX$$O DO CHEQUE'
	Case 192 ; ls_Msg += ' : OVERFLOW NA CAPACIDADE DE TEXTO DO COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO'
	Case 193 ; ls_Msg += ' : PROGRAMA$$HEX2$$c700c300$$ENDHEX$$O DE ESPA$$HEX1$$c700$$ENDHEX$$OS ENTRE CUPONS MENOR QUE O M$$HEX1$$cd00$$ENDHEX$$NIMO PERMITIDO'
	Case 194 ; ls_Msg += ' : EQUIPAMENTO N$$HEX1$$c300$$ENDHEX$$O POSSUI LEITOR DE CHEQUE'
	Case 195 ; ls_Msg += ' : PROGRAMA$$HEX2$$c700c300$$ENDHEX$$O DE AL$$HEX1$$cd00$$ENDHEX$$QUOTA COM VALOR NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 196 ; ls_Msg += ' : PAR$$HEX1$$c200$$ENDHEX$$METRO BAUD RATE INV$$HEX1$$c100$$ENDHEX$$LIDO'
	Case 197 ; ls_Msg += ' : CONFIGURA$$HEX2$$c700c300$$ENDHEX$$O PERMITIDA SOMENTE PELA PORTA DOS FISCO'
	Case 198 ; ls_Msg += ' : VALOR TOTAL DO ITEM EXCEDE 11 D$$HEX1$$cd00$$ENDHEX$$GITOS'
	Case 199 ; ls_Msg += ' : PROGRAMA$$HEX2$$c700c300$$ENDHEX$$O DA MOEDA COM ESPA$$HEX1$$c700$$ENDHEX$$OS EM BRACO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 200 ; ls_Msg += ' : CASAS DECIMAIS DEVEM SER PROGRAMADAS COM 2 OU 3'
	Case 201 ; ls_Msg += ' : N$$HEX1$$c300$$ENDHEX$$O PERMITE CADASTRAR USU$$HEX1$$c100$$ENDHEX$$RIOS DIFERENTES NA MESMA MFD'
	Case 202 ; ls_Msg += ' : IDENTIFICA$$HEX2$$c700c300$$ENDHEX$$O DO CONSUMIDOR N$$HEX1$$c300$$ENDHEX$$O PERMITIDA PARA SANGRIA OU SUPRIMENTO'
	Case 203 ; ls_Msg += ' : CASAS DECIMAIS EM QUANTIDADE MAIOR DO QUE A PERMITIDA'
	Case 204 ; ls_Msg += ' : CASAS DECIMAIS DO UNIT$$HEX1$$c100$$ENDHEX$$RIO MAIOR DO QUE O PERMITIDA'
	Case 205 ; ls_Msg += ' : POSI$$HEX2$$c700c300$$ENDHEX$$O RESERVADA PARA ICMS'
	Case 206 ; ls_Msg += ' : POSI$$HEX2$$c700c300$$ENDHEX$$O RESERVADA PARA ISS'
	Case 207 ; ls_Msg += ' : TODAS AS AL$$HEX1$$cd00$$ENDHEX$$QUOTAS COM A MESMA VINCULA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDO'
	Case 208 ; ls_Msg += ' : DATA DE EMBARQUE ANTERIOR A DATA DE EMISS$$HEX1$$c300$$ENDHEX$$O'
	Case 208 ; ls_Msg += ' : RETORNO_DATA_DE_EMBARQUE_ANTERIOR_A_DATA_DA_EMISSAO'
	Case 209 ; ls_Msg += ' : RETORNO_ALIQUOTA_DE_ISS_NAO_PERMITIDO_SEM_INSCRICAO_MUNICIPAL'
	Case 210 ; ls_Msg += ' : RETORNO_PACOTE_CLICHE_FORA_DA_SEQUENCIA'
	Case 211 ; ls_Msg += ' : RETORNO_ESPACO_PARA_PARA_ARMAZENAMENTO_CLICHE_ESGOTADO'
	Case 212 ; ls_Msg += ' : RETORNO_CLICHE_GRAFICO_NAO_DISPONIVEL_PARA_CONFIRMACAO'
	Case 213 ; ls_Msg += ' : RETORNO_CRC_DO_CLICHE_GRAFICO_DIFERENTE_DO_INFORMADO'
End Choose*/

gvo_aplicacao.of_grava_log(ls_Msg)	
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg,StopSign!)
end subroutine

public function boolean of_inicializa_relatorio_gerencial (string ps_relatorio, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Sequencia,&
     ll_Retorno,&
     ll_Ecf
	  
String ls_Relatorio
	  
If ps_relatorio = '01' Then  //Para comprovantes de recarga.
	ls_Relatorio = '03'
Else
	ls_Relatorio = ps_Relatorio
End If

Do While ll_Retorno <> 1 

	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_AbreRelatorioGerencialMFD(ls_Relatorio),'ECF_AbreRelatorioGerencialMFD')
	
	Choose Case ll_Retorno
		Case 1 						// Comando OK
			
			If This.St3 = 0 Then 
				
				//of_Registra_documento_ecf('RG',pdc_valor)
				
				Return True
				
			End If	
			
			This.of_Status_Extendido_ECF()
			
			Return False
			
		Case 100 						// Impressora ocupada
			Continue
		Case -1 					   	// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida
			Return False
		Case 0 							// Erro ao executar comando

			If This.Ack >= 1 Then	// Cupom Fiscal Aberto

				If Not This.of_nr_cupom(Ref ll_Sequencia) Then Return False
				
				If Of_Cupom_Gravado(ll_sequencia,ll_ecf) Then

					Of_msg_Cupom_Aberto_Gravado()

				Else

					Of_msg_Cupom_Aberto()

					IF Not PDV.of_cancela_ultimo_cupom(False) Then Return False

					If of_inicializa_cupom("") Then Return True

				End If				
				
			End If
			
	End Choose
	
Loop
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

public function boolean of_fecha_relatorio_gerencial ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

If This.ivb_Cod_Barras Then
	This.of_codigo_barras(0,This.ivs_Cod_Barras,'1')	
End If

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_FechaRelatorioGerencial(),'ECF_FechaRelatorioGerencial')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_imprime_relatorio_gerencial (string ps_texto[], string ps_tipo);If This.ivb_Modo_Teste Then Return True

Long   ll_Retry
Long   ll_Retorno
Long   ll_Linha
Long   ll_Loop
Long   ll_Texto = 1
Long	 ll_st1

String ls_Aux
String ls_Texto
String ls_Log = ''
String ls_Texto2, ls_Texto3

//Do While ll_Retry <= 3
	
	For ll_Linha = 1 To UpperBound(ps_texto)
		If Not LenA(ps_texto[ll_Linha])>0 Then Continue
				
		If ps_tipo = '05' Then
			ls_Texto = ps_texto[ll_Linha]			
//			ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_UsaRelatorioGerencialMFD(ps_texto[ll_Linha]),'ECF_UsaRelatorioGerencialMFD')
		End If
	
		If ps_tipo <> '05' Then
			If PosA( Upper( SqlCa.SqlReturnData ) , 'POSTGRESQL' ) = 0 Then							
				ls_texto = CharA(16) + CharA(67) + ps_texto[ll_Linha] + CharA(10) + CharA(18)
			Else
				ls_texto = CharA(16) + CharA(67) + ps_texto[ll_Linha]
			End If				
//			ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_UsaRelatorioGerencialMFD(ls_texto),'ECF_UsaRelatorioGerencialMFD')
		End If		
		
		If LenA(ls_texto) > 1000 Then			
			ls_texto2 = ls_texto
			Do While LenA(Trim(ls_Texto2)) > 0
				ls_texto3 = LeftA(ls_texto2,1000)
				
				ls_Log = 'Parte '+String(ll_Texto)+': ['+ls_texto3+']~r'
				ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_UsaRelatorioGerencialMFD(ls_texto3),'ECF_UsaRelatorioGerencialMFD')
				
				Trata_Retorno_1:
				Choose Case ll_Retorno
					Case 1 				// Comando OK
						If of_Status_ECF() = -1 Then Return False
						
						If (This.St1 = 0) Or (This.St1 = 64) Then					
							//If ll_Linha = UpperBound(ps_texto) Then Return True
						Else
							ll_st1 = This.St1
							
							If ll_St1 >= 128 Then                 // sem papel
								Return False
							End If
						End If
					Case 0 				// Erro ao executar comando
						Return False					
					Case 100 			// Impressora ocupada
						Return False
					Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
						//Se houver retorno de fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido ser$$HEX1$$e100$$ENDHEX$$ enviado o texto novamente permitindo apenas os caracteres ANSI
						ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_UsaRelatorioGerencialMFD(This.Of_Normaliza_Texto(ls_texto3)),'ECF_UsaRelatorioGerencialMFD')
						
						If ll_Retorno = -1 Then
							gvo_aplicacao.of_grava_log('Falha ao imprimir o parte '+String(ll_Texto)+' do relat$$HEX1$$f300$$ENDHEX$$rio gerencial ['+ls_texto3+'].~rTexto '+ls_Log+'.')
							Return False		
						Else
							GoTo Trata_Retorno_1
						End If
				End Choose			
				
				ll_Texto ++
				ls_texto2 = MidA(ls_texto2, 1001)				
			Loop
			
			If ll_Linha = UpperBound(ps_texto) Then Return True		
		Else		
			ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_UsaRelatorioGerencialMFD(ls_texto),'ECF_UsaRelatorioGerencialMFD')
			
			Trata_Retorno2:
			Choose Case ll_Retorno
				Case 1 				// Comando OK
					If of_Status_ECF() = -1 Then Return False
					
					If (This.St1 = 0) Or (This.St1 = 64) Then					
						If ll_Linha = UpperBound(ps_texto) Then Return True
					Else
						ll_st1 = This.St1
						
						If ll_St1 >= 128 Then                 // sem papel
							Return False
						End If
					End If
				Case 0 				// Erro ao executar comando
					Return False					
				Case 100 			// Impressora ocupada
					Return False
				Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
					//Se houver retorno de fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido ser$$HEX1$$e100$$ENDHEX$$ enviado o texto novamente permitindo apenas os caracteres ANSI
					ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_UsaRelatorioGerencialMFD(This.Of_Normaliza_Texto(ls_texto)),'ECF_UsaRelatorioGerencialMFD')
					
					If ll_Retorno = -1 Then
						gvo_aplicacao.of_grava_log('Falha ao imprimir relat$$HEX1$$f300$$ENDHEX$$rio gerencial ['+ls_texto+'].')
						Return False
					Else
						GoTo Trata_Retorno2
					End If
			End Choose	
		End If

	Next
			
	gf_Delay(3)
	ll_Retry ++
//Loop

Return False
end function

public function boolean of_cancela_recebimento_nao_fiscal ();If This.ivb_Modo_Teste Then Return True

ivb_showerror = False

Long ll_Retry
Long ll_Retorno
Long ll_gnf

String ls_Time

Boolean lb_Sucesso = False

DateTime ldh_Emissao

Open(w_Janela_Aguarde)

w_Janela_Aguarde.Wf_Mensagem("CANCELANDO CUPOM N$$HEX1$$c300$$ENDHEX$$O FISCAL")

Do While ll_Retry <= 3 and Not lb_Sucesso 
	
	ll_Retry ++
	
	If Not of_Data_Ultimo_Documento_Fiscal(Ref ldh_Emissao) Then Return False
	
	If Not of_Contador_Operacao_Nao_Fiscal(Ref ll_gnf) Then Return False
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_CancelaRecebimentoNaoFiscalMFD("","",""),'ECF_CancelaRecebimentoNaoFiscalMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			Update documento_ecf
			Set id_estorno = 'S'
			Where dh_movimento = :ldh_Emissao
			  and nr_ecf       = :This.ECF
			  and nr_gnf       = :ll_gnf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				Sqlca.of_MsgDbError('Estorno de recebimento n$$HEX1$$e300$$ENDHEX$$o fiscal')
			Else
				Sqlca.of_Commit()
			End If	
						
			lb_Sucesso = True
			
		Case 100 			// Impressora ocupada
			Continue
	End Choose
	
	Exit
	
Loop

If IsValid(w_Janela_Aguarde) Then Close(w_Janela_Aguarde)

SetPointer(HourGlass!)

Return lb_Sucesso
end function

public function boolean of_flags_st1 ();If This.St1 = 0 Then Return True

Long   ll_st1 

String ls_Msg

ll_st1 = This.St1

If ll_St1 >= 128 Then                 // bit 7
	ll_St1 = ll_St1 - 128
	gvo_aplicacao.of_grava_log("Falta de papel na ECF.")	
	If of_pergunta_falta_papel() Then 
		Return of_verifica_problemas_impressora()
	Else
		Return False
	End If
End If 

If ll_St1 >= 64 Then                  // bit 6 
	ll_St1 = ll_St1 - 64 
	gvo_aplicacao.of_grava_log("Pouco papel na ECF.")	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pouco Papel",Exclamation!)
	Return True
End If 

If ll_St1 >= 32 Then                  // bit 5 
	ll_St1 = ll_St1 - 32 
	ls_Msg += " : Erro no Rel$$HEX1$$f300$$ENDHEX$$gio" 
End If 

If ll_St1 >= 16 Then                  // bit 4 
	ll_St1 = ll_St1 - 16 
	ls_Msg += " : Impressora em Erro" 
End If 

If ll_St1 >= 8 Then                  // bit 3 
	ll_St1 = ll_St1 - 8 
	ls_Msg += " : Comando n$$HEX1$$e300$$ENDHEX$$o iniciado com ESC" 
End If 

If ll_St1 >= 4 Then                  // bit 2 
	ll_St1 = ll_St1 - 4 
	ls_Msg += " : Comando Inexistente" 
End If 

If ll_St1 >= 2 Then                  // bit 1 
	ll_St1 = ll_St1 - 2 
	ls_Msg += " : Cupom Aberto" 
End If

If ll_St1 >= 1 Then                  // bit 0 
	ll_St1 = ll_St1 - 1 
	ls_Msg += " : N$$HEX1$$fa00$$ENDHEX$$mero de Par$$HEX1$$e200$$ENDHEX$$metro(s) Inv$$HEX1$$e100$$ENDHEX$$lido(s)" 
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg,StopSign!)
gvo_aplicacao.of_grava_log(ls_Msg)	

Return False
end function

public function boolean of_flags_st2 ();If This.St2 = 0 Then Return True

Long   ll_st2

String ls_Msg

ll_st2 = This.St2

If ll_st2 >= 128 Then                  // bit 7 
   ll_st2 = ll_st2 - 128 
   ls_Msg = " Tipo de Par$$HEX1$$e200$$ENDHEX$$metro de Comando Inv$$HEX1$$e100$$ENDHEX$$lido" 
End If 

If ll_st2 >= 64 Then                  // bit 6 
   ll_st2 = ll_st2 - 64 
   ls_Msg += " Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal Lotada" 
End If 

If ll_st2 >= 32 Then                  // bit 5 
   ll_st2 = ll_st2 - 32 
   ls_Msg += " Erro na Mem$$HEX1$$f300$$ENDHEX$$ria RAM" 
End If 

If ll_st2 >= 16 Then                  // bit 4 
   ll_st2 = ll_st2 - 16 
   ls_Msg += " Al$$HEX1$$ed00$$ENDHEX$$quota N$$HEX1$$e300$$ENDHEX$$o Programada" 
End If 

If ll_st2 >= 8 Then                  // bit 3
   ll_st2 = ll_st2 - 8 
   ls_Msg += " Capacidade de Al$$HEX1$$ed00$$ENDHEX$$quotas Lotada" 
End If 

If ll_st2 >= 4 Then                  // bit 2 
   ll_st2 = ll_st2 - 4 
   ls_Msg += " Cancelamento N$$HEX1$$e300$$ENDHEX$$o Permitido" 
End If 

If ll_st2 >= 2 Then                  // bit 1 
   ll_st2 = ll_st2 - 2 
   ls_Msg += " CNPJ/IE do Propriet$$HEX1$$e100$$ENDHEX$$rio N$$HEX1$$e300$$ENDHEX$$o Programado" 
End If 

If ll_st2 >= 1 Then                  // bit 0 
   ll_st2 = ll_st2 - 1 
   ls_Msg += " Comando N$$HEX1$$e300$$ENDHEX$$o Executado" 
End If 

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg)
gvo_aplicacao.of_grava_log(ls_Msg)	

Return False
end function

public function boolean of_gera_arquivo_cat52 (string ps_arquivo, date pdh_data_fiscal);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Row
String ls_Data

ls_Data = String(pdh_data_fiscal, "ddmmyyyy")

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_GeraRegistrosCAT52MFD(ps_Arquivo, ls_Data),'ECF_GeraRegistrosCAT52MFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
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

public function boolean of_gt_inicial_final (ref decimal pdc_inicial, ref decimal pdc_final);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_inicial
String ls_final

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
	ls_inicial = Space(18)
	ls_final   = Space(18)
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_InicioFimGTsMFD(Ref ls_Inicial, Ref ls_Final),'ECF_InicioFimGTsMFD')		

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			pdc_inicial = Dec(ls_Inicial) / 100
			pdc_final   = Dec(ls_Final) / 100
			
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			   // Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_verifica_status_horario_verao (ref string ps_status);If This.ivb_Modo_Teste Then Return True

If Not This.of_Verifica_Flags_Fiscais() Then Return False

Long ll_Status

ll_Status = Long(ivs_Status)

If ll_Status >= 128 Then                 // bit 7
	ll_Status = ll_Status - 128 
End If 

If ll_Status >= 64 Then                  // bit 6 
	ll_Status = ll_Status - 64 
End If 

If ll_Status >= 32 Then                  // bit 5 
	ll_Status = ll_Status - 32 
End If 

If ll_Status >= 16 Then                  // bit 4 
	ll_Status = ll_Status - 16 
End If 

If ll_Status >= 8 Then                  // bit 3 
	ll_Status = ll_Status - 8 
End If 

If ll_Status >= 4 Then                  // bit 2 
	ps_status = "S"
Else
	ps_status = "N"
End If	

Return True
end function

public function boolean of_verifica_flags_fiscais ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

ivs_Status = Space(3)

Do While ll_Retry <= 3
	
    ll_Retorno = of_Verifica_Retorno_ECF(ECF_FlagsFiscaisStr(Ref ivs_Status),'ECF_FlagsFiscaisStr')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_programa_horario_verao ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ProgramaHorarioVerao(),'ECF_ProgramaHorarioVerao')
	 	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			
			This.of_Status_Extendido_ECF()
			
			Return False
			
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_impressora_online ();If This.ivb_Modo_Teste Then Return True

Boolean lb_Sucesso

Long    ll_Retorno

Do While ll_Retorno <> 1
	
	ll_Retorno = ECF_VerificaImpressoraLigada()

	Choose Case ll_Retorno
		Case 1
			lb_Sucesso = True
		Case 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o",StopSign!)
		Case -4
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o BemaFI32.ini n$$HEX1$$e300$$ENDHEX$$o foi encontrado no diret$$HEX1$$f300$$ENDHEX$$rio de sistema do Windows.",StopSign!)
		Case -5
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao abrir a porta de comunica$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!)
		Case -6
			If of_pergunta_impressoraoffline() Then Continue
			Exit
	End Choose
	
Loop

Return lb_Sucesso
end function

public function string of_meio_pagamento (string ps_pagamento);String ls_FormasPagto[]

//Long 	 ll_Forma
//
//If This.of_Verifica_Forma_Pagamento(ls_FormasPagto) Then
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
		Case Else ; Return "DINHEIRO"
	End Choose
	
//End If
end function

public function boolean of_inicializa_recebimento_nao_fiscal ();If This.ivb_Modo_Teste Then Return True

Long ll_Sequencia,&
     ll_Retorno,&
     ll_Ecf

ivb_showerror = FALSE

Do While ll_Retorno <> 1 

	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_AbreRecebimentoNaoFiscalMFD("","",""),'ECF_AbreRecebimentoNaoFiscalMFD')
	
	Choose Case ll_Retorno
		Case 1 						// Comando OK
			
			If of_Status_ECF() = -1 Then
				
				If This.St3 = 33 Then
	
					gvo_aplicacao.of_grava_log("Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_inicializa_recebimento_nao_fiscal().")	
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente.",Exclamation!)

					If Not of_cancela_Recebimento_Nao_Fiscal() Then Return False
					
					Return of_Inicializa_recebimento_nao_fiscal()
					
				End If
				
			End If		
			
			If This.St3 = 0 Then Return True

			This.of_Status_Extendido_ECF()
			
			Return False
			
		Case 100 					// Impressora ocupada
			Continue
		Case -1 					// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida
			Return False
		Case 0 						// Erro ao executar comando

			If This.Ack >= 1 Then	// Cupom Fiscal Aberto

				If Not This.of_nr_cupom(Ref ll_Sequencia) Then Return False
				
				If Of_Cupom_Gravado(ll_sequencia,ll_ecf) Then

					Of_msg_Cupom_Aberto_Gravado()

				Else

					Of_msg_Cupom_Aberto()

					IF Not PDV.of_cancela_ultimo_cupom(False) Then Return False

					If of_inicializa_cupom("") Then Return True

				End If				
				
			End If
			
	End Choose
	
Loop
end function

public function boolean of_registra_documento_ecf (string ps_documento);String ls_Nulo

Decimal ldc_Nulo

SetNull(ls_Nulo)
SetNull(ldc_Nulo)

Return of_Registra_Documento_ecf(ps_documento,ls_Nulo,ldc_Nulo)
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

ldh_Movimento = This.of_dh_movimentacao()
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

public function boolean of_registra_documento_ecf (string ps_documento, decimal pdc_valor);String ls_Nulo

SetNull(ls_Nulo)

Return of_Registra_Documento_ecf(ps_documento,ls_Nulo,pdc_valor)
end function

public function boolean of_registra_item_vendido (string ps_produto, long pd_qtd, decimal pd_precounitario, decimal pd_pretototal, string ps_descricao, decimal pd_aliquota, string ps_complemento, string ps_tributacao_icms, string ps_un);If This.ivb_Modo_Teste Then Return True

String	lvs_qtd,&
      	lvs_precounit,&
	   	lvs_precotot,&
	   	lvs_comando,&
	   	lvs_desconto,&
	   	lvs_trib

Long 	ll_Retry
Long 	ll_Retorno

lvs_trib = This.of_Indicador_Aliquota(pd_Aliquota,ps_tributacao_icms)

//ps_descricao = LeftA(Trim(ps_descricao),24)

lvs_qtd  			= String(pd_qtd,"####0.000")
lvs_precounit	= String(pd_precounitario,"####0.000")
lvs_precotot		= String(pd_pretototal)
lvs_desconto  	= String(pd_pretototal - (pd_precounitario*pd_qtd))

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_VendeItemDepartamento(ps_produto,ps_descricao,lvs_trib,lvs_precounit,lvs_qtd,"0",lvs_desconto,"01",ps_un),'ECF_VendeItemDepartamento')
		
	Choose Case ll_Retorno

		Case 1 				// Comando OK			
			of_Status_ECF()	
			If This.Ack = 21 Then//Erro Impressora Retornou NAK			
				Return False
			End if
			If This.St1 >= 128 Then                 // sem papel
				Return False
			End If			

			If This.St3 = 0 Then
				This.of_Atualiza_Venda_Bruta()
				Return True
			End If	
			
			This.of_Status_Extendido_ECF()
			
			Return False
		Case 100 			// Impressora ocupada
			Continue 
		Case Else
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function string of_status_st3 ();Choose Case This.ST3
	Case	0
			Return	"COMANDO OK"
	Case	1					
			Return	"COMANDO INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	2					
			Return	"ERRO DESCONHECIDO"
	Case	3					
			Return	"N$$HEX1$$da00$$ENDHEX$$MERO DE PAR$$HEX1$$c200$$ENDHEX$$METRO INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	4					
			Return	"TIPO DE PAR$$HEX1$$c200$$ENDHEX$$METRO INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	5					
			Return	"TODAS AL$$HEX1$$cd00$$ENDHEX$$QUOTAS J$$HEX1$$c100$$ENDHEX$$ PROGRAMADAS"
	Case	6					
			Return	"TOTALIZADOR N$$HEX1$$c300$$ENDHEX$$O FISCAL J$$HEX1$$c100$$ENDHEX$$ PROGRAMADO"
	Case	7					
			Return	"CUPOM FISCAL ABERTO"
	Case	8					
			Return	"CUPOM FISCAL FECHADO"
	Case	9					
			Return	"ECF OCUPADO"
	Case	10					
			Return	"IMPRESSORA EM ERRO"
	Case	11					
			Return	"IMPRESSORA SEM PAPEL"
	Case	12					
			Return	"IMPRESSORA COM CABE$$HEX1$$c700$$ENDHEX$$A LEVANTADA"
	Case	13					
			Return	"IMPRESSORA OFF LINE"
	Case	14					
			Return	"AL$$HEX1$$cd00$$ENDHEX$$QUOTA N$$HEX1$$c300$$ENDHEX$$O PROGRAMADA"
	Case	15					
			Return	"TERMINADOR DE STRING FALTANDO"
	Case	16					
			Return	"ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO MAIOR QUE O TOTAL DO CUPOM FISCAL"
	Case	17					
			Return	"CUPOM FISCAL SEM ITEM VENDIDO"
	Case	18					
			Return	"COMANDO N$$HEX1$$c300$$ENDHEX$$O EFETIVADO"
	Case	19					
			Return	"SEM ESPA$$HEX1$$c700$$ENDHEX$$O PARA NOVAS FORMAS DE PAGAMENTO"
	Case	20					
			Return	"FORMA DE PAGAMENTO N$$HEX1$$c300$$ENDHEX$$O PROGRAMADA"
	Case	21					
			Return	"$$HEX1$$cd00$$ENDHEX$$NDICE MAIOR QUE N$$HEX1$$da00$$ENDHEX$$MERO DE FORMA DE PAGAMENTO"
	Case	22					
			Return	"FORMAS DE PAGAMENTO ENCERRADAS"
	Case	23					
			Return	"CUPOM N$$HEX1$$c300$$ENDHEX$$O TOTALIZADO"
	Case	24					
			Return	"COMANDO MAIOR QUE 7Fh (127d)"
	Case	25					
			Return	"CUPOM FISCAL ABERTO E SEM $$HEX1$$cd00$$ENDHEX$$TEM"
	Case	26					
			Return	"CANCELAMENTO N$$HEX1$$c300$$ENDHEX$$O IMEDIATAMENTE AP$$HEX1$$d300$$ENDHEX$$S"
	Case	27					
			Return	"CANCELAMENTO J$$HEX1$$c100$$ENDHEX$$ EFETUADO"
	Case	28					
			Return	"COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO OU J$$HEX1$$c100$$ENDHEX$$ EMITIDO"
	Case	29					
			Return	"MEIO DE PAGAMENTO N$$HEX1$$c300$$ENDHEX$$O PERMITE TEF"
	Case	30					
			Return	"SEM COMPROVANTE N$$HEX1$$c300$$ENDHEX$$O FISCAL ABERTO"
	Case	31					
			Return	"COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO J$$HEX1$$c100$$ENDHEX$$ ABERTO"
	Case	32					
			Return	"REIMPRESS$$HEX1$$c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA"
	Case	33					
			Return	"COMPROVANTE N$$HEX1$$c300$$ENDHEX$$O FISCAL J$$HEX1$$c100$$ENDHEX$$ ABERTO"
	Case	34					
			Return	"TOTALIZADOR N$$HEX1$$c300$$ENDHEX$$O FISCAL N$$HEX1$$c300$$ENDHEX$$O PROGRAMADO"
	Case	35					
			Return	"CUPOM N$$HEX1$$c300$$ENDHEX$$O FISCAL SEM $$HEX1$$cd00$$ENDHEX$$TEM VENDIDO"
	Case	36					
			Return	"ACR$$HEX1$$c900$$ENDHEX$$SCIMO E DESCONTO MAIOR QUE TOTAL CNF"
	Case	37					
			Return	"MEIO DE PAGAMENTO N$$HEX1$$c300$$ENDHEX$$O INDICADO"
	Case	38					
			Return	"MEIO DE PAGAMENTO DIFERENTE DO TOTAL DO RECEBIMENTO"
	Case	39					
			Return	"N$$HEX1$$c300$$ENDHEX$$O PERMITIDO MAIS DE UMA SANGRIA OU SUPRIMENTO"
	Case	40					
			Return	"RELAT$$HEX1$$d300$$ENDHEX$$RIO GERENCIAL J$$HEX1$$c100$$ENDHEX$$ PROGRAMADO"
	Case	41					
			Return	"RELAT$$HEX1$$d300$$ENDHEX$$RIO GERENCIAL N$$HEX1$$c300$$ENDHEX$$O PROGRAMADO"
	Case	42					
			Return	"RELAT$$HEX1$$d300$$ENDHEX$$RIO GERENCIAL N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	43					
			Return	"MFD N$$HEX1$$c300$$ENDHEX$$O INICIALIZADA"
	Case	44					
			Return	"MFD AUSENTE"
	Case	45					
			Return	"MFD SEM N$$HEX1$$da00$$ENDHEX$$MERO DE S$$HEX1$$c900$$ENDHEX$$RIE"
	Case	46					
			Return	"MFD J$$HEX1$$c100$$ENDHEX$$ INICIALIZADA"
	Case	47					
			Return	"MFD LOTADA"
	Case	48					
			Return	"CUPOM N$$HEX1$$c300$$ENDHEX$$O FISCAL ABERTO"
	Case	49					
			Return	"MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL DESCONECTADA"
	Case	50					
			Return	"MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL SEM N$$HEX1$$da00$$ENDHEX$$MERO DE S$$HEX1$$c900$$ENDHEX$$RIE DA MFD"
	Case	51					
			Return	"MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL LOTADA"
	Case	52					
			Return	"DATA INICIAL INV$$HEX1$$c100$$ENDHEX$$LIDA"
	Case	53					
			Return	"DATA FINAL INV$$HEX1$$c100$$ENDHEX$$LIDA"
	Case	54					
			Return	"CONTADOR DE REDU$$HEX2$$c700c300$$ENDHEX$$O Z INICIAL INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	55					
			Return	"CONTADOR DE REDU$$HEX2$$c700c300$$ENDHEX$$O Z FINAL INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	56					
			Return	"ERRO DE ALOCA$$HEX2$$c700c300$$ENDHEX$$O"
	Case	57					
			Return	"DADOS DO RTC INCORRETOS"
	Case	58					
			Return	"DATA ANTERIOR AO $$HEX1$$da00$$ENDHEX$$LTIMO DOCUMENTO EMITIDO"
	Case	59					
			Return	"FORA DE INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA"
	Case	60					
			Return	"EM INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA"
	Case	61					
			Return	"ERRO NA MEM$$HEX1$$d300$$ENDHEX$$RIA DE TRABALHO"
	Case	62					
			Return	"J$$HEX1$$c100$$ENDHEX$$ HOUVE MOVIMENTO NO DIA"
	Case	63					
			Return	"BLOQUEIO POR RZ"
	Case	64					
			Return	"FORMA DE PAGAMENTO ABERTA"
	Case	65					
			Return	"AGUARDANDO PRIMEIRO PROPRIET$$HEX1$$c100$$ENDHEX$$RIO"
	Case	66					
			Return	"AGUARDANDO RZ"
	Case	67					
			Return	"ECF OU LOJA IGUAL A ZERO"
	Case	68					
			Return	"CUPOM ADICIONAL N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	69					
			Return	"DESCONTO MAIOR QUE TOTAL VENDIDO EM ICMS"
	Case	70					
			Return	"RECEBIMENTO N$$HEX1$$c300$$ENDHEX$$O FISCAL NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	71					
			Return	"ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO MAIOR QUE TOTAL N$$HEX1$$c300$$ENDHEX$$O FISCAL"
	Case	72					
			Return	"MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL LOTADA PARA NOVO CARTUCHO"
	Case	73					
			Return	"ERRO DE GRAVA$$HEX2$$c700c300$$ENDHEX$$O NA MF"
	Case	74					
			Return	"ERRO DE GRAVA$$HEX2$$c700c300$$ENDHEX$$O NA MFD"
	Case	75					
			Return	"DADOS DO RTC ANTERIORES AO $$HEX1$$da00$$ENDHEX$$LTIMO DOC ARMAZENADO"
	Case	76					
			Return	"MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL SEM ESPA$$HEX1$$c700$$ENDHEX$$O PARA GRAVAR LEITURAS DA MFD"
	Case	77					
			Return	"MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL SEM ESPA$$HEX1$$c700$$ENDHEX$$O PARA GRAVAR VERSAO DO SB"
	Case	78					
			Return	"DESCRI$$HEX2$$c700c300$$ENDHEX$$O IGUAL A DEFAULT N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	79					
			Return	"EXTRAPOLADO N$$HEX1$$da00$$ENDHEX$$MERO DE REPETI$$HEX2$$c700d500$$ENDHEX$$ES PERMITIDAS"
	Case	80					
			Return	"SEGUNDA VIA DO COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	81					
			Return	"PARCELAMENTO FORA DA SEQU$$HEX1$$ca00$$ENDHEX$$NCIA"
	Case	82					
			Return	"COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO ABERTO"
	Case	83					
			Return	"TEXTO COM SEQU$$HEX1$$ca00$$ENDHEX$$NCIA DE ESC INV$$HEX1$$c100$$ENDHEX$$LIDA"
	Case	84					
			Return	"TEXTO COM SEQU$$HEX1$$ca00$$ENDHEX$$NCIA DE ESC INCOMPLETA"
	Case	85					
			Return	"VENDA COM VALOR NULO"
	Case	86					
			Return	"ESTORNO DE VALOR NULO"
	Case	87					
			Return	"FORMA DE PAGAMENTO DIFERENTE DO TOTAL DA SANGRIA"
	Case	88					
			Return	"REDU$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA EM INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA"
	Case	89					
			Return	"AGUARDANDO RZ PARA ENTRADA EM INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA"
	Case	90					
			Return	"FORMA DE PAGAMENTO COM VALOR NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	91					
			Return	"ACR$$HEX1$$c900$$ENDHEX$$SCIMO E DESCONTO MAIOR QUE VALOR DO $$HEX1$$cd00$$ENDHEX$$TEM"
	Case	92					
			Return	"AUTENTICA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA"
	Case	93					
			Return	"TIMEOUT NA VALIDA$$HEX2$$c700c300$$ENDHEX$$O"
	Case	94					
			Return	"COMANDO N$$HEX1$$c300$$ENDHEX$$O EXECUTADO EM IMPRESSORA BILHETE DE PASSAGEM"
	Case	95					
			Return	"COMANDO N$$HEX1$$c300$$ENDHEX$$O EXECUTADO EM IMPRESSORA DE CUPOM FISCAL"
	Case	96					
			Return	"CUPOM N$$HEX1$$c300$$ENDHEX$$O FISCAL FECHADO"
	Case	97					
			Return	"PAR$$HEX1$$c200$$ENDHEX$$METRO N$$HEX1$$c300$$ENDHEX$$O ASCII EM CAMPO ASCII"
	Case	98					
			Return	"PAR$$HEX1$$c200$$ENDHEX$$METRO N$$HEX1$$c300$$ENDHEX$$O ASCII NUM$$HEX1$$c900$$ENDHEX$$RICO EM CAMPO ASCII NUM$$HEX1$$c900$$ENDHEX$$RICO"
	Case	99					
			Return	"TIPO DE TRANSPORTE INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	100					
			Return	"DATA E HORA INV$$HEX1$$c100$$ENDHEX$$LIDA"
	Case	101					
			Return	"SEM RELAT$$HEX1$$d300$$ENDHEX$$RIO GERENCIAL OU COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO ABERTO"
	Case	102					
			Return	"N$$HEX1$$da00$$ENDHEX$$MERO DO TOTALIZADOR N$$HEX1$$c300$$ENDHEX$$O FISCAL INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	103					
			Return	"PAR$$HEX1$$c200$$ENDHEX$$METRO DE ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	104					
			Return	"ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO EM SANGRIA OU SUPRIMENTO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	105					
			Return	"N$$HEX1$$da00$$ENDHEX$$MERO DO RELAT$$HEX1$$d300$$ENDHEX$$RIO GERENCIAL INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	106					
			Return	"FORMA DE PAGAMENTO ORIGEM N$$HEX1$$c300$$ENDHEX$$O PROGRAMADA"
	Case	107					
			Return	"FORMA DE PAGAMENTO DESTINO N$$HEX1$$c300$$ENDHEX$$O PROGRAMADA"
	Case	108					
			Return	"ESTORNO MAIOR QUE FORMA PAGAMENTO"
	Case	109					
			Return	"CARACTER NUM$$HEX1$$c900$$ENDHEX$$RICO NA CODIFICA$$HEX2$$c700c300$$ENDHEX$$O GT N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	110					
			Return	"ERRO NA INICIALIZA$$HEX2$$c700c300$$ENDHEX$$O DA MF"
	Case	111					
			Return	"NOME DO TOTALIZADOR EM BRANCO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	112					
			Return	"DATA E HORA ANTERIORES AO $$HEX1$$da00$$ENDHEX$$LTIMO DOC ARMAZENADO"
	Case	113					
			Return	"PAR$$HEX1$$c200$$ENDHEX$$METRO DE ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	114					
			Return	"$$HEX1$$cd00$$ENDHEX$$TEM ANTERIOR AOS TREZENTOS $$HEX1$$da00$$ENDHEX$$LTIMOS"
	Case	115					
			Return	"$$HEX1$$cd00$$ENDHEX$$TEM N$$HEX1$$c300$$ENDHEX$$O EXISTE OU J$$HEX1$$c100$$ENDHEX$$ CANCELADO"
	Case	116					
			Return	"C$$HEX1$$d300$$ENDHEX$$DIGO COM ESPA$$HEX1$$c700$$ENDHEX$$OS N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	117					
			Return	"DESCRICAO SEM CARACTER ALFAB$$HEX1$$c900$$ENDHEX$$TICO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	118					
			Return	"ACR$$HEX1$$c900$$ENDHEX$$SCIMO MAIOR QUE VALOR DO $$HEX1$$cd00$$ENDHEX$$TEM"
	Case	119					
			Return	"DESCONTO MAIOR QUE VALOR DO $$HEX1$$cd00$$ENDHEX$$TEM"
	Case	120					
			Return	"DESCONTO EM ISS N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	121					
			Return	"ACR$$HEX1$$c900$$ENDHEX$$SCIMO EM $$HEX1$$cd00$$ENDHEX$$TEM J$$HEX1$$c100$$ENDHEX$$ EFETUADO"
	Case	122					
			Return	"DESCONTO EM $$HEX1$$cd00$$ENDHEX$$TEM J$$HEX1$$c100$$ENDHEX$$ EFETUADO"
	Case	123					
			Return	"ERRO NA MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL CHAMAR CREDENCIADO"
	Case	124					
			Return	"AGUARDANDO GRAVA$$HEX2$$c700c300$$ENDHEX$$O NA MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL"
	Case	125					
			Return	"CARACTER REPETIDO NA CODIFICA$$HEX2$$c700c300$$ENDHEX$$O DO GT"
	Case	126					
			Return	"VERS$$HEX1$$c300$$ENDHEX$$O J$$HEX1$$c100$$ENDHEX$$ GRAVADA NA MEM$$HEX1$$d300$$ENDHEX$$RIA FISCAL"
	Case	127					
			Return	"ESTOURO DE CAPACIDADE NO CHEQUE"
	Case	128					
			Return	"TIMEOUT NA LEITURA DO CHEQUE"
	Case	129					
			Return	"M$$HEX1$$ca00$$ENDHEX$$S INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	130					
			Return	"COORDENADA INV$$HEX1$$c100$$ENDHEX$$LIDA"
	Case	131					
			Return	"SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO"
	Case	132					
			Return	"SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO VALOR"
	Case	133					
			Return	"SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO EXTENSO"
	Case	134					
			Return	"SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO FAVORECIDO"
	Case	135					
			Return	"SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NA LOCALIDADE"
	Case	136					
			Return	"SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO OPCIONAL"
	Case	137					
			Return	"SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO DIA"
	Case	138					
			Return	"SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO M$$HEX1$$ca00$$ENDHEX$$S"
	Case	139					
			Return	"SOBREPOSI$$HEX2$$c700c300$$ENDHEX$$O DE TEXTO NO ANO"
	Case	140					
			Return	"USANDO MFD DE OUTRO ECF"
	Case	141					
			Return	"PRIMEIRO DADO DIFERENTE DE ESC OU 1C"
	Case	142					
			Return	"N$$HEX1$$c300$$ENDHEX$$O PERMITIDO ALTERAR SEM INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA"
	Case	143					
			Return	"DADOS DA $$HEX1$$da00$$ENDHEX$$LTIMA RZ CORROMPIDOS"
	Case	144					
			Return	"COMANDO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO NO MODO INICIALIZA$$HEX2$$c700c300$$ENDHEX$$O"
	Case	145					
			Return	"AGUARDANDO ACERTO DE REL$$HEX1$$d300$$ENDHEX$$GIO"
	Case	146					
			Return	"MFD J$$HEX1$$c100$$ENDHEX$$ INICIALIZADA PARA OUTRA MF"
	Case	147					
			Return	"AGUARDANDO ACERTO DO REL$$HEX1$$d300$$ENDHEX$$GIO OU DESBLOQUEIO PELO TECLADO"
	Case	148					
			Return	"VALOR FORMA DE PAGAMENTO MAIOR QUE M$$HEX1$$c100$$ENDHEX$$XIMO PERMITIDO"
	Case	149					
			Return	"RAZ$$HEX1$$c300$$ENDHEX$$O SOCIAL EM BRANCO"
	Case	150					
			Return	"NOME DE FANTASIA EM BRANCO"
	Case	151					
			Return	"ENDERE$$HEX1$$c700$$ENDHEX$$O EM BRANCO"
	Case	152					
			Return	"ESTORNO DE CDC N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	153					
			Return	"DADOS DO PROPRIET$$HEX1$$c100$$ENDHEX$$RIO IGUAIS AO ATUAL"
	Case	154					
			Return	"ESTORNO DE FORMA DE PAGAMENTO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	155					
			Return	"DESCRI$$HEX2$$c700c300$$ENDHEX$$O FORMA DE PAGAMENTO IGUAL J$$HEX1$$c100$$ENDHEX$$ PROGRAMADA"
	Case	156					
			Return	"ACERTO DE HOR$$HEX1$$c100$$ENDHEX$$RIO DE VER$$HEX1$$c300$$ENDHEX$$O S$$HEX1$$d300$$ENDHEX$$ IMEDIATAMENTE AP$$HEX1$$d300$$ENDHEX$$S RZ"
	Case	157					
			Return	"IT N$$HEX1$$c300$$ENDHEX$$O PERMITIDA MF RESERVADA PARA RZ"
	Case	158					
			Return	"SENHA CNPJ INV$$HEX1$$c100$$ENDHEX$$LIDA"
	Case	159					
			Return	"TIMEOUT NA INICIALIZA$$HEX2$$c700c300$$ENDHEX$$O DA NOVA MF"
	Case	160					
			Return	"N$$HEX1$$c300$$ENDHEX$$O ENCONTRADO DADOS NA MFD"
	Case	161					
			Return	"SANGRIA OU SUPRIMENTO DEVEM SER $$HEX1$$da00$$ENDHEX$$NICOS NO CNF"
	Case	162					
			Return	"$$HEX1$$cd00$$ENDHEX$$NDICE DA FORMA DE PAGAMENTO NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	163					
			Return	"UF DESTINO INV$$HEX1$$c100$$ENDHEX$$LIDA"
	Case	164					
			Return	"TIPO DE TRANSPORTE INCOMPAT$$HEX1$$cd00$$ENDHEX$$VEL COM UF DESTINO"
	Case	165					
			Return	"DESCRI$$HEX2$$c700c300$$ENDHEX$$O DO PRIMEIRO $$HEX1$$cd00$$ENDHEX$$TEM DO BILHETE DE PASSAGEM DIFERENTE DE 'TARIFA'"
	Case	166					
			Return	"AGUARDANDO IMPRESS$$HEX1$$c300$$ENDHEX$$O DE CHEQUE OU AUTENTICA$$HEX2$$c700c300$$ENDHEX$$O"
	Case	167					
			Return	"N$$HEX1$$c300$$ENDHEX$$O PERMITIDO PROGRAMA$$HEX1$$c700$$ENDHEX$$AO CNPJ IE COM ESPA$$HEX1$$c700$$ENDHEX$$OS EM BRANCO"
	Case	168					
			Return	"N$$HEX1$$c300$$ENDHEX$$O PERMITIDO PROGRAMA$$HEX2$$c700c300$$ENDHEX$$O UF COM ESPA$$HEX1$$c700$$ENDHEX$$OS EM BRANCO"
	Case	169					
			Return	"N$$HEX1$$da00$$ENDHEX$$MERO DE IMPRESS$$HEX1$$d500$$ENDHEX$$ES DA FITA DETALHE NESTA INTERVEN$$HEX2$$c700c300$$ENDHEX$$O T$$HEX1$$c900$$ENDHEX$$CNICA ESGOTADO"
	Case	170					
			Return	"CF J$$HEX1$$c100$$ENDHEX$$ SUBTOTALIZADO"
	Case	171					
			Return	"CUPOM N$$HEX1$$c300$$ENDHEX$$O SUBTOTALIZADO"
	Case	172					
			Return	"ACR$$HEX1$$c900$$ENDHEX$$SCIMO EM SUBTOTAL J$$HEX1$$c100$$ENDHEX$$ EFETUADO"
	Case	173					
			Return	"DESCONTO EM SUBTOTAL J$$HEX1$$c100$$ENDHEX$$ EFETUADO"
	Case	174					
			Return	"ACR$$HEX1$$c900$$ENDHEX$$SCIMO NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	175					
			Return	"DESCONTO NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	176					
			Return	"CANCELAMENTO DE ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO EM SUBTOTAL N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	177					
			Return	"DATA INV$$HEX1$$c100$$ENDHEX$$LIDA"
	Case	178					
			Return	"VALOR DO CHEQUE NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	179					
			Return	"VALOR DO CHEQUE INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	180					
			Return	"CHEQUE SEM LOCALIDADE N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	181					
			Return	"CANCELAMENTO ACR$$HEX1$$c900$$ENDHEX$$SCIMO EM $$HEX1$$cd00$$ENDHEX$$TEM N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	182					
			Return	"CANCELAMENTO DESCONTO EM $$HEX1$$cd00$$ENDHEX$$TEM N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	183					
			Return	"N$$HEX1$$da00$$ENDHEX$$MERO M$$HEX1$$c100$$ENDHEX$$XIMO DE $$HEX1$$cd00$$ENDHEX$$TENS ATINGIDO"
	Case	184					
			Return	"N$$HEX1$$da00$$ENDHEX$$MERO DE $$HEX1$$cd00$$ENDHEX$$TEM NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	185					
			Return	"MAIS QUE DUAS AL$$HEX1$$cd00$$ENDHEX$$QUOTAS DIFERENTES NO BILHETE DE PASSAGEM N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	186					
			Return	"ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO EM ITEM N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	187					
			Return	"CANCELAMENTO DE ACR$$HEX1$$c900$$ENDHEX$$SCIMO OU DESCONTO EM ITEM N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	188					
			Return	"CLICHE J$$HEX1$$c100$$ENDHEX$$ IMPRESSO"
	Case	189					
			Return	"TEXTO OPCIONAL DO CHEQUE EXCEDEU O M$$HEX1$$c100$$ENDHEX$$XIMO PERMITIDO"
	Case	190					
			Return	"IMPRESS$$HEX1$$c300$$ENDHEX$$O AUTOM$$HEX1$$c100$$ENDHEX$$TICA NO VERSO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO NESTE EQUIPAMENTO"
	Case	191					
			Return	"TIMEOUT NA INSER$$HEX2$$c700c300$$ENDHEX$$O DO CHEQUE"
	Case	192					
			Return	"OVERFLOW NA CAPACIDADE DE TEXTO DO COMPROVANTE DE CR$$HEX1$$c900$$ENDHEX$$DITO OU D$$HEX1$$c900$$ENDHEX$$BITO"
	Case	193					
			Return	"PROGRAMA$$HEX2$$c700c300$$ENDHEX$$O DE ESPA$$HEX1$$c700$$ENDHEX$$OS ENTRE CUPONS MENOR QUE O M$$HEX1$$cd00$$ENDHEX$$NIMO PERMITIDO"
	Case	194					
			Return	"EQUIPAMENTO N$$HEX1$$c300$$ENDHEX$$O POSSUI LEITOR DE CHEQUE"
	Case	195					
			Return	"PROGRAMA$$HEX2$$c700c300$$ENDHEX$$O DE AL$$HEX1$$cd00$$ENDHEX$$QUOTA COM VALOR NULO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	196					
			Return	"PAR$$HEX1$$c200$$ENDHEX$$METRO BAUD RATE INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	197					
			Return	"CONFIGURA$$HEX2$$c700c300$$ENDHEX$$O PERMITIDA SOMENTE PELA PORTA DOS FISCO"
	Case	198					
			Return	"VALOR TOTAL DO ITEM EXCEDE 11 D$$HEX1$$cd00$$ENDHEX$$GITOS"
	Case	199					
			Return	"PROGRAMA$$HEX2$$c700c300$$ENDHEX$$O DA MOEDA COM ESPA$$HEX1$$c700$$ENDHEX$$OS EM BRACO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	200					
			Return	"CASAS DECIMAIS DEVEM SER PROGRAMADAS COM 2 OU 3"
	Case	201					
			Return	"N$$HEX1$$c300$$ENDHEX$$O PERMITE CADASTRAR USU$$HEX1$$c100$$ENDHEX$$RIOS DIFERENTES NA MESMA MFD"
	Case	202					
			Return	"IDENTIFICA$$HEX2$$c700c300$$ENDHEX$$O DO CONSUMIDOR N$$HEX1$$c300$$ENDHEX$$O PERMITIDA PARA SANGRIA OU SUPRIMENTO"
	Case	203					
			Return	"CASAS DECIMAIS EM QUANTIDADE MAIOR DO QUE A PERMITIDA"
	Case	204					
			Return	"CASAS DECIMAIS DO UNIT$$HEX1$$c100$$ENDHEX$$RIO MAIOR DO QUE O PERMITIDA"
	Case	205					
			Return	"POSI$$HEX2$$c700c300$$ENDHEX$$O RESERVADA PARA ICMS"
	Case	206					
			Return	"POSI$$HEX2$$c700c300$$ENDHEX$$O RESERVADA PARA ISS"
	Case	207					
			Return	"TODAS AS AL$$HEX1$$cd00$$ENDHEX$$QUOTAS COM A MESMA VINCULA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
	Case	208					
			Return	"DATA DE EMBARQUE ANTERIOR A DATA DE EMISS$$HEX1$$c300$$ENDHEX$$O"
	Case	209					
			Return	"AL$$HEX1$$cd00$$ENDHEX$$QUOTA DE ISS N$$HEX1$$c300$$ENDHEX$$O PERMITIDA SEM INSCRI$$HEX2$$c700c300$$ENDHEX$$O MUNICIPAL"
	Case	210					
			Return	"RETORNO PACOTE CLICHE FORA DA SEQU$$HEX1$$ca00$$ENDHEX$$NCIA"
	Case	211					
			Return	"ESPA$$HEX1$$c700$$ENDHEX$$O PARA ARMAZENAMENTO DO CLICHE ESGOTADO"
	Case	212					
			Return	"CLICHE GR$$HEX1$$c100$$ENDHEX$$FICO N$$HEX1$$c300$$ENDHEX$$O DISPON$$HEX1$$cd00$$ENDHEX$$VEL PARA CONFIRMA$$HEX2$$c700c300$$ENDHEX$$O"
	Case	213					
			Return	"CRC DO CLICHE GR$$HEX1$$c100$$ENDHEX$$FICO DIFERENTE DO INFORMADO"
	Case	214					
			Return	"INTERVALO INV$$HEX1$$c100$$ENDHEX$$LIDO"
	Case	215					
			Return	"USU$$HEX1$$c100$$ENDHEX$$RIO J$$HEX1$$c100$$ENDHEX$$ PROGRAMADO "
	Case	217					
			Return	"DETECTADA ABERTURA DO EQUIPAMENTO "
	Case	218					
			Return	"CANCELAMENTO DE ACR$$HEX1$$c900$$ENDHEX$$SCIMO/DESCONTO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO"
End Choose
		
Return ""
end function

public function boolean of_texto_relatorio_gerencial (string ps_texto);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_St1


ps_texto = CharA(16) + CharA(67) + ps_texto + CharA(13) + CharA(10)

ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_UsaRelatorioGerencialMFD(ps_texto),'ECF_UsaRelatorioGerencialMFD')


Choose Case ll_Retorno
	Case 1 				// Comando OK
		If of_Status_ECF() = -1 Then Return False
		
		If (This.St1 = 0) Or (This.St1 = 64) Then					
			Return True
		Else
			ll_st1 = This.St1
			
			If ll_St1 >= 128 Then                 // sem papel
				Return False
			End If
		End If		

	Case 0 				// Erro ao executar comando
		Return False
	Case 100 			// Impressora ocupada
		Return False
	Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose	

Return False
end function

public function boolean of_totaliza_recebimento_nao_fiscal (string ps_pagamento, string ps_valor);If This.ivb_Modo_Teste Then Return True

Long    ll_Retry
Long    ll_Retorno

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_SubTotalizaRecebimentoMFD(),'ECF_SubTotalizaRecebimentoMFD')

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++
	
Loop

ll_Retry = 0

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_TotalizaRecebimentoMFD(),'ECF_TotalizaRecebimentoMFD')

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++
	
Loop

ll_Retry = 0

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_EfetuaFormaPagamentoIndice(ps_pagamento,ps_valor),'ECF_EfetuaFormaPagamentoIndice')

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++
	
Loop

Return True
end function

public function boolean of_valor_pago_ultimo_cupom (decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Valor

SetPointer(HourGlass!)

ls_Valor = Space(14)

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ValorPagoUltimoCupom(Ref ls_Valor),'ECF_ValorPagoUltimoCupom'	)
			
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False


end function

public function boolean of_venda_bruta (ref decimal pdc_venda);If This.ivb_Modo_Teste Then Return True

String ls_Valor
Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Valor = Space(18)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_VendaBruta(Ref ls_Valor),'ECF_VendaBruta')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

If lb_Sucesso Then
	pdc_venda = Dec(ls_Valor) / 100
Else
	pdc_venda = 000.00
End If

Return lb_Sucesso
end function

public function boolean of_verifica_forma_pagamento (ref string ps_formapagto[]);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Pos
Long ll_Ind

String ls_FormasPagto
String ls_Forma

ls_FormasPagto = Space(3016)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_VerificaFormasPagamento(Ref ls_FormasPagto),'ECF_VerificaFormasPagamento')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			ll_Pos = 1
			
			Do While True
				
				ls_Forma = Trim(MidA(ls_FormasPagto,ll_Pos,16))
				
				If ls_Forma <> '' and ls_Forma <> 'Valor Recebido' and ls_Forma <> 'Troco' Then
				
					ll_Ind++
					ps_formaPagto[ll_Ind] = ls_Forma
					
				End If
				
				ll_Pos += 58
				
				If ll_Pos > LenA(ls_FormasPagto) Then Exit
				
			Loop	
			
			Return True
			
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_verifica_versao_dll ();If This.ivb_Modo_Teste Then Return True

String ls_Versao

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Versao = Space(09)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_VersaoDll(Ref ls_Versao),'ECF_VersaoDll')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
	
			If Long(LeftA(ls_Versao,1)) < 5 Then
				//If ls_Versao <> "5,10,4,7" And ls_Versao <> "5,10,6,5" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Vers$$HEX1$$e300$$ENDHEX$$o da dll (" + ls_Versao + ") Sweda incompat$$HEX1$$ed00$$ENDHEX$$vel. Favor contactar suporte.")
				gvo_aplicacao.of_grava_log("Vers$$HEX1$$e300$$ENDHEX$$o da dll (" + ls_Versao + ") Sweda incompat$$HEX1$$ed00$$ENDHEX$$vel.")
			End If
			
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return lb_Sucesso
end function

public function boolean of_verifica_versao_software_basico ();If This.ivb_Modo_Teste Then Return True

String ls_Versao

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Versao = Space(06)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_VersaoFirmwareMFD(Ref ls_Versao),'ECF_VersaoFirmwareMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			This.nr_Versao_SWBasico = LeftA(ls_Versao + Space(10),10)
			
			Update impressora_fiscal
			Set nr_versao_swbasico = :This.nr_Versao_SWBasico
			Where nr_ecf = :This.Ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF.~n~n Erro: " + Sqlca.SqlErrText,Exclamation!)
				gvo_aplicacao.of_grava_log("Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_verifica_versao_software_basico()." +Sqlca.SQLErrText)
				lb_Sucesso = False
			Else			
				Sqlca.of_Commit()
				lb_Sucesso = True
			End If	
			
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return lb_Sucesso
end function

public function boolean of_atualiza_venda_bruta ();Decimal{2}	ldc_Valor

String 		ls_File = 'c:\sistemas\cl\arquivos\pafecf.ini'
String 		ls_Serie
String   	ls_Valor

If Not FileExists(ls_File) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo " + ls_File + " n$$HEX1$$e300$$ENDHEX$$o encontrado.",StopSign!)
	Return False
End If
	
If Not of_Grande_Total(Ref ldc_Valor) Then Return False

SetProfileString(ls_File, "ECF", "Serie",of_Encripta(This.nr_Serie))
SetProfileString(ls_File, "ECF", "VendaBruta",of_Encripta(String(ldc_Valor,'###,###,###,###.00')))
	
Return True
end function

public function boolean of_inicializa_comprovante_tef (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor, string ps_cupom);If This.ivb_Modo_Teste Then Return True

Long   ll_Retry
Long   ll_Retorno

String ls_Pagamento
String ls_Valor 
String ls_Cupom

ls_Valor = String(pdc_Valor)
ls_Cupom = ps_cupom

If Trim(ls_Cupom) = '' Then ls_Valor = ''

//Retorna descri$$HEX2$$e700e300$$ENDHEX$$o do meio de pagamento
ls_Pagamento = of_meio_pagamento(ps_tipo_pagamento)

Do While ll_Retry <= 3

	 ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_AbreComprovanteNaoFiscalVinculado(ls_Pagamento,ls_Valor,ls_Cupom),'ECF_AbreComprovanteNaoFiscalVinculado')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			of_Registra_documento_ecf('CC',pdc_valor)
			
			Return True
			
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			   // Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Choose Case This.st3
				Case 3,23,28
					Return of_inicializa_comprovante_tef_nao_fiscal(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor)
			End Choose
			
			Return False
			
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_percentual_livre_mfd ();If This.ivb_Modo_Teste Then Return True

String ls_MemoriaLivre

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_MemoriaLivre = Space(06)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_PercentualLivreMFD(Ref ls_MemoriaLivre),'ECF_PercentualLivreMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
					
			This.pc_Livre_MFD = Dec(MidA(ls_MemoriaLivre,1,LenA(ls_MemoriaLivre) -1))
			
			Update impressora_fiscal
			Set pc_livre_mfd = :This.pc_Livre_MFD
			Where nr_ecf = :This.Ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				Sqlca.of_MsgDbError('Atualiza$$HEX2$$e700e300$$ENDHEX$$o do percentual de mem$$HEX1$$f300$$ENDHEX$$ria livre')
				gvo_aplicacao.of_grava_log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do percentual de mem$$HEX1$$f300$$ENDHEX$$ria livre, fun$$HEX2$$e700e300$$ENDHEX$$o uo_sweda.of_percentual_livre_mfd()."+Sqlca.SQLErrText)	
				lb_Sucesso = False
			Else			
				Sqlca.of_Commit()
				lb_Sucesso = True
			End If	
			
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return lb_Sucesso
end function

public function boolean of_grava_log_ecf ();String lvs_INI,&
	   lvs_Log

lvs_INI = gvo_Aplicacao.ivs_Arquivo_INI

// Verifica se o caminho dos arquivos de ajuda est$$HEX1$$e300$$ENDHEX$$o especificados no INI
lvs_Log     = ProfileString(lvs_INI, "ECF" , "Log" , "")

If Upper(Trim(lvs_Log)) = "SIM" Then 
	This.ivs_Grava_Log = "SIM"
Else
	This.ivs_Grava_Log = "NAO"
End If

Return True
end function

public function boolean of_recebimento_nao_fiscal (string ps_tipo, string ps_valor);If This.ivb_Modo_Teste Then Return True

Integer li_File
String  ls_msg

Long    ll_Retry
Long    ll_Retorno

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_RecebimentoNaoFiscal(ps_tipo,ps_valor,""),'ECF_RecebimentoNaoFiscal')

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++
	
Loop

Return True
end function

public function boolean of_capturar_md5 (string ps_arquivo, ref string ps_md5);pdv.of_capturar_md5(ps_arquivo, ps_md5)

Return True
end function

public function boolean of_gera_arquivo_cat52 (string ps_arquivo, date pdh_data_fiscal, ref string ps_arquivo_destino);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Row
String ls_Data

ls_Data = String(pdh_data_fiscal, "ddmmyyyy")
ps_arquivo_destino = Space(512)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_GeraRegistrosCAT52MFDEx(ps_Arquivo, ls_Data, ps_arquivo_destino),'ECF_GeraRegistrosCAT52MFDEx')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
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

protected function boolean of_assinatura_digital (string ps_arquivo);pdv.of_assinatura_digital(ps_arquivo)

Return True
end function

public function boolean of_gera_arquivo_cotepe1704 (string ps_tipo, string ps_inicio, string ps_final);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Origem  = 'c:\sistemas\cl\arquivos\paf-ecf\download.mf'
String ls_Destino = 'c:\sistemas\cl\arquivos\paf-ecf\retorno.txt'
String ls_Cotepe

ls_Cotepe = 'c:\sistemas\cl\arquivos\paf-ecf\cotepe1704-' + ps_tipo + '.txt'

FileDelete(ls_Origem)
FileDelete(ls_Destino)
FileDelete(ls_Cotepe)

ll_Retorno = This.of_Verifica_Retorno_ECF_MFD(ECF_DownloadMF(ls_Origem),'ECF_DownloadMF')

If ll_Retorno <> 1 Then 
	Return False
End If

If LenA(ps_Inicio) = 6 Then
	ps_Inicio = '0'+ps_Inicio
	ps_Final  = '0'+ps_Final
End If
	 
ll_Retorno = This.of_Verifica_Retorno_ECF_MFD(ECF_ReproduzirMemoriaFiscalMFD('3', ps_inicio , ps_final , ls_Cotepe, ls_Origem),'ECF_ReproduzirMemoriaFiscalMFD')

If ll_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_data_movimento_ultima_reducao (ref date pd_datafiscal);If This.ivb_Modo_Teste Then Return True

String ls_DataMovimento
String ls_Hora
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_DataMovimento = Space(6)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DataMovimentoUltimaReducaoMFD(Ref ls_DataMovimento),'ECF_DataMovimentoUltimaReducaoMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
		Case 100 			// Impressora ocupada
			Continue
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

If lb_Sucesso Then

	If Long(MidA(ls_DataMovimento,5,2)) <= 60 Then
		ls_Ano = '20'
	Else
		ls_Ano = '19'
	End If
	
	ls_DataMovimento = MidA(ls_DataMovimento,1,2)+"/"+MidA(ls_DataMovimento,3,2)+"/"+ls_Ano+MidA(ls_DataMovimento,5,2)
	
	pd_datafiscal = Date(ls_DataMovimento)

End If

Return lb_Sucesso
end function

public function boolean of_coo_inicial_final (ref long pl_inicial, ref long pl_final);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_inicial
String ls_final

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
	ls_inicial = Space(6)
	ls_final   = Space(6)
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_InicioFimCOOsMFD(Ref ls_Inicial, Ref ls_Final),'ECF_InicioFimCOOsMFD')		

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			pl_inicial = Long(ls_Inicial)
			pl_final   = Long(ls_Final)
			
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			   // Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_abre_porta_serial ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_AbrePortaSerial(),'ECF_AbrePortaSerial')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			This.ivb_Porta_Aberta = True
			If IsValid(PDV) Then
				PDV.ivb_Porta_Aberta = True
			End If
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

public function boolean of_fecha_recebimento_nao_fiscal (string ps_texto);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_FechaRecebimentoNaoFiscalMFD(ps_texto),'ECF_FechaRecebimentoNaoFiscalMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return True
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
ls_aliquotas_cadastradas = Space(80)

ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_RetornoAliquotas( Ref ls_aliquotas_cadastradas ),'ECF_RetornoAliquotas' )
	
Choose Case ll_Retorno
	Case 1 				// Comando OK	
		
	Case 0 				// Erro ao executar comando
		Return False
	Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido		
		This.of_Status_Extendido_ECF()					
		Return False		
End Choose

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
		ll_Pos = PosA(ls_aliquotas_cadastradas, ls_aliquota)
		If ll_pos = 0 Then //N$$HEX1$$e300$$ENDHEX$$o econtrou, vai cadastrar.
			ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ProgramaAliquota( ls_aliquota, pl_tipo ),'ECF_ProgramaAliquota' )
				
			Choose Case ll_Retorno
				Case 1 				// Comando OK
					Continue
				Case 0 				// Erro ao executar comando
					Return False
				Case 100 			// Impressora ocupada
					Return False
				Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido					
					This.of_Status_Extendido_ECF()								
					Return False					
			End Choose	
		End If	
	Next
	Return True
Else			
	ls_aliquota = gf_replace(String(pdc_aliquota),',','',1)
	ls_aliquota = String(Long(ls_aliquota),'0000')
	
	ll_Pos = PosA(ls_aliquotas_cadastradas, ls_aliquota)
	If ll_pos = 0 Then
		ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ProgramaAliquota( ls_aliquota, pl_tipo ),'ECF_ProgramaAliquota'	 )
			
		Choose Case ll_Retorno
			Case 1 				// Comando OK
				Return True
			Case 0 				// Erro ao executar comando
				Return False
			Case 100 			// Impressora ocupada
				Return False
			Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido					
				This.of_Status_Extendido_ECF()								
				Return False					
		End Choose	
	Else
		If pb_mostra_mensagem Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Aliquota informada j$$HEX1$$e100$$ENDHEX$$ existe na ECF.",Information!)
		End If
		Return False
	End If		

End If

Return False


end function

public function boolean of_cancela_item_anterior ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_CancelaItemAnterior(),'ECF_CancelaItemAnterior')
	
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

public function long of_verifica_retorno_ecf (long pl_retorno, string ps_funcao);Long ll_Retorno = -1
String lvs_Msg

This.Ack = 0
This.St1 = 0 
This.St2 = 0
This.St3 = 0

Choose Case pl_retorno
	Case 1
		ll_Retorno = 1
	Case 0
		lvs_Msg = "Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o com o ECF na fun$$HEX2$$e700e300$$ENDHEX$$o "+ps_funcao+"."
	Case -1
		lvs_Msg = "A ECF retornou um erro na tentativa de execu$$HEX2$$e700e300$$ENDHEX$$o da fun$$HEX2$$e700e300$$ENDHEX$$o "+ps_funcao+"."
	Case -2
		lvs_Msg = "Par$$HEX1$$e200$$ENDHEX$$metro inv$$HEX1$$e100$$ENDHEX$$lido para a fun$$HEX2$$e700e300$$ENDHEX$$o "+ps_funcao+"."
	Case -6
		lvs_Msg = "Impressora Desligada ou Desconectada."
	Case -8
		lvs_Msg = "Erro ao criar ou gravar no arquivo STATUS.TXT ou RETORNO.TXT."
	Case -27
		ll_Retorno = This.of_Status_ECF()
	Case Else
		lvs_Msg = "Erro desconhecido para a fun$$HEX2$$e700e300$$ENDHEX$$o "+ps_funcao+".~rC$$HEX1$$f300$$ENDHEX$$digo retorno da ECF "+String(pl_retorno)+"."
End Choose

If Trim(lvs_Msg)<>'' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_Msg,StopSign!)
	gvo_aplicacao.of_grava_log(lvs_Msg)
End If

Return ll_Retorno
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

public function long of_verifica_retorno_ecf_mfd (long pl_retorno, string ps_funcao);Long ll_Retorno = -1
String lvs_Msg = ''

This.Ack = 0
This.St1 = 0 
This.St2 = 0
This.St3 = 0

Choose Case pl_retorno
	Case 1
		ll_Retorno = 1
	Case 0
		lvs_Msg = "Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o com o ECF, fun$$HEX2$$e700e300$$ENDHEX$$o "+ps_funcao+"."
	Case -1
		lvs_Msg = "Falta um dos arquivos (Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal ou MFD)."
	Case -2
		lvs_Msg = "Par$$HEX1$$e200$$ENDHEX$$metro inv$$HEX1$$e100$$ENDHEX$$lido para o comando "+ps_funcao+"."
	Case -3
		lvs_Msg = "N$$HEX1$$e300$$ENDHEX$$o existe movimento."
	Case -8
		lvs_Msg = "Erro na gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo ou n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ movimento na data."
	Case -27
		ll_Retorno = This.of_Status_ECF()
	Case -30
		lvs_Msg = "N$$HEX1$$e300$$ENDHEX$$o implementado no modelo conectado."		
	Case Else
		lvs_Msg = "Erro desconhecido na chamada da fun$$HEX2$$e700e300$$ENDHEX$$o "+ps_funcao+".~rC$$HEX1$$f300$$ENDHEX$$digo retorno da ECF "+String(pl_retorno)+"."
End Choose

If pl_retorno <> -27 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_Msg,StopSign!)
	gvo_aplicacao.of_grava_log(lvs_Msg)
End If

Return ll_Retorno
end function

public function boolean of_retorna_doc_aberto (ref long pl_doc);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
String ls_status

pl_doc = -1

ls_Status = Space(2)

ll_Retorno = This.of_Verifica_Retorno_Ecf(ECF_StatusCupomFiscal(ref ls_Status),'ECF_StatusCupomFiscal')

If ll_retorno = 1 Then
	If Long(ls_Status) = 1 Then
		pl_doc = 1
	Else
		pl_doc = 0
	End If
Else
	Return False
End If

ll_Retorno = This.of_Verifica_Retorno_Ecf(ECF_StatusComprovanteNaoFiscalVinculado(ref ls_Status),'ECF_StatusComprovanteNaoFiscalVinculado')

If ll_retorno = 1 Then
	If Long(ls_Status) = 1 Then
		pl_doc = 2
	End If
Else
	Return False
End If

ll_Retorno = This.of_Verifica_Retorno_Ecf(ECF_StatusRelatorioGerencial(ref ls_Status),'ECF_StatusRelatorioGerencial')

If ll_retorno = 1 Then
	If Long(ls_Status) = 1 Then
		pl_doc = 3
	End If
Else
	Return False
End If

ll_Retorno = This.of_Verifica_Retorno_Ecf(ECF_StatusComprovanteNaoFiscalNaoVinculado(ref ls_Status),'ECF_StatusComprovanteNaoFiscalNaoVinculado')

If ll_retorno = 1 Then
	If Long(ls_Status) = 1 Then
		pl_doc = 4
	End If
Else
	Return False
End If

If pl_doc <> -1 Then
	Return True
Else
	Return False
End If

end function

public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final, string ps_arquivo);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Origem  = 'C:\Sistemas\RL\Arquivos\MFD\download.mfd'
String ls_Destino = 'C:\Sistemas\RL\Arquivos\MFD\'

dc_uo_api lo_api
lo_api = Create dc_uo_api

lo_api.of_create_directory('C:\Sistemas\RL\Arquivos\MFD')

Destroy(lo_api)

ls_Destino = ls_Destino + ps_arquivo

FileDelete(ls_Origem)
FileDelete(ls_Destino)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DownloadMFD(ls_Origem,ps_Tipo,ps_inicio,ps_final,'1'),'ECF_DownloadMFD')

   Exit
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

If FileExists(ls_Origem) Then
	
	Do While ll_Retry <= 3
	
		ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_FormatoDadosMFD(ls_Origem,ls_Destino,'0',ps_Tipo,ps_inicio,ps_final,'1'),'ECF_FormatoDadosMFD')
		
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
	
Else
	gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar arquivo " + ls_Destino + ' uo_sweda - of_leitura_memoria_fita_detalhe')		
End If
	
Return False
end function

public function boolean of_gera_arquivo_mfd (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_caminho_mfd);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Row

String ls_Origem
String ls_Destino
String ls_tipo

FileDelete(ls_Origem)
FileDelete(ls_Destino)

ls_Destino = ps_endereco
//ls_origem = "C:\Sistemas\CL\Arquivos\PAF-ECF\MFISCAL.MF"
ls_Origem  = 'MFISCAL.MF'

ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DownloadMF(ls_origem),'ECF_DownloadMF')

If ll_Retorno <> 1 Then 
	Return False
End If

Choose Case pl_tipo_geracao
	Case 0
		ls_tipo = '1'
	Case 1
		ls_tipo = '3'
End Choose

If LenA(ps_Inicio) = 6 Then
	ps_Inicio = '0'+ps_Inicio
	ps_Final  = '0'+ps_Final
End If
	 
ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ReproduzirMemoriaFiscalMFD(ls_tipo, ps_inicio , ps_final , ls_destino, ls_Origem),'ECF_ReproduzirMemoriaFiscalMFD')

If ll_Retorno = 1 Then
	ps_caminho_MFD = ls_origem	
	Return True
Else
	Return False
End If
end function

public function boolean of_gera_arquivo_cotepe_mensal (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_dir_mfd, boolean pb_gera_mfd, ref boolean pb_mfd_gerado);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Row
String ls_arquivo_mfd
String ls_tipo

ls_arquivo_mfd = ps_dir_mfd + 'Download.MFD'

If pb_gera_mfd Then
	Filedelete(ls_arquivo_mfd)	
	//Gera binario
	ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DownloadMFD(ls_arquivo_mfd,'0','','','1'),'ECF_DownloadMFD')
	If ll_retorno <> 1 Then
		Return False
	End If	
	pb_mfd_gerado = True
Else
	pb_mfd_gerado = True	
End If

Choose Case pl_tipo_geracao
	Case 0
		ls_tipo = '1'
	Case 1
		ls_tipo = '3'
End Choose

If LenA(ps_Inicio) = 6 Then
	ps_Inicio = '0'+ps_Inicio
	ps_Final  = '0'+ps_Final
End If
	 
ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ReproduzirMemoriaFiscalMFD(ls_tipo, ps_inicio , ps_final , ps_endereco, ls_arquivo_mfd),'ECF_ReproduzirMemoriaFiscalMFD')

If ll_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_subtotal_cupom (ref string ps_subtotal);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_subtotal

ls_subtotal = Space(14)

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_SubTotal(Ref ls_subtotal),'ECF_SubTotal')
	
	ps_subtotal = Trim(ls_subtotal)
		
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

public function boolean of_gera_arquivos_ecf (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_espelhos, long pl_tipo_geracao, string ps_dir_mfd, ref string ps_arquivo_gerado);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Row
String ls_arquivo_mfd
String ls_tipo
String ls_tipo_geracao

ls_arquivo_mfd = ps_dir_mfd + 'Download.MFD'

//Tipos arquivo MFD:  1 = Data /  2 = COO   /   0 = Total
Choose Case ps_tipo
	Case 'D'
		ls_tipo = '1'
	Case 'C'
		ls_tipo = '2'
	Case 'T'
		ls_tipo = '0'
End Choose
If LenA(ps_Inicio) = 6 Then
	ps_Inicio = '0'+ps_Inicio
	ps_Final  = '0'+ps_Final
End If

Filedelete(ls_arquivo_mfd)	
//Gera binario
ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_DownloadMFD(ls_arquivo_mfd,ls_tipo,ps_Inicio,ps_Final,'1'),'ECF_DownloadMFD')
If ll_retorno <> 1 Then
	Return False
End If	

Choose Case pl_tipo_geracao
	Case 0  //MF
		ls_tipo_geracao = '1'
	Case 1 //MFD
		ls_tipo_geracao = '2'
	case 3 //TDM
		ls_tipo_geracao = '3'		
End Choose
	 
ll_Retorno = This.of_Verifica_Retorno_ECF(ECF_ReproduzirMemoriaFiscalMFD(ls_tipo_geracao, ps_inicio , ps_final , ps_endereco, ls_arquivo_mfd),'ECF_ReproduzirMemoriaFiscalMFD')

If ll_Retorno = 1 Then
	ps_arquivo_gerado = ls_arquivo_mfd
	Return True
Else
	Return False
End If
end function

on uo_sweda.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_sweda.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;ECF_FechaPortaSerial()
end event

