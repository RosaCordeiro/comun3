HA$PBExportHeader$uo_bematech.sru
forward
global type uo_bematech from nonvisualobject
end type
end forward

global type uo_bematech from nonvisualobject
end type
global uo_bematech uo_bematech

type prototypes
FUNCTION Long genkkey(Ref String cChavePublica, Ref String cChavePrivada) LIBRARY "c:\sistemas\dll\bematech\sign_bema.dll" alias for "genkkey;Ansi";
FUNCTION Long setLibType(Integer Tipo) LIBRARY "c:\sistemas\dll\bematech\sign_bema.dll";
FUNCTION Long generateEAD(String cArquivo, String cChavePublica, String cChavePrivada, Ref String cEAD, Integer iSign) LIBRARY "c:\sistemas\dll\bematech\sign_bema.dll" alias for "generateEAD;Ansi";
FUNCTION Long validateFile(String cNomeArquivo, String cChavePublica, String cChavePrivada) LIBRARY "c:\sistemas\dll\bematech\sign_bema.dll" alias for "validateFile;Ansi";
FUNCTION Long md5FromFile(String cNomeArquivo, Ref String cMD5) LIBRARY "c:\sistemas\dll\bematech\sign_bema.dll" alias for "md5FromFile;Ansi";

FUNCTION Long Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional( Ref String dataUsuario, Ref String dataSWBasico, Ref String MFAdicional )  LIBRARY "bemafi32.dll" alias for "Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional;Ansi" ;
FUNCTION Long BemaGeraRegistrosTipoE(String cArqMFD, String cArqTXT, String cDataInicial, String cDataFinal, String cRazaoSocial, String cEndereco, String cPAR1, String cCMD, String cPAR2, String cPAR3, String cPAR4, String cPAR5, String cPAR6, String cPAR7, String cPAR8, String cPAR9, String cPAR10, String cPAR11, String cPAR12, String cPAR13, String cPAR14) LIBRARY "BemaMFD2.DLL" alias for "BemaGeraRegistrosTipoE;Ansi";
FUNCTION Long Bematech_FI_NumeroSerieMFD(Ref String NumeroSerie ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_NumeroSerieMFD;Ansi" ;
FUNCTION Long Bematech_FI_StatusEstendidoMFD(Ref Integer Status) LIBRARY "bemafi32.dll" alias for "Bematech_FI_StatusEstendidoMFD;Ansi" ;
FUNCTION Long Bematech_FI_MarcaModeloTipoImpressoraMFD(Ref String Marca , Ref String Modelo , Ref String Tipo ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_MarcaModeloTipoImpressoraMFD;Ansi" ;
FUNCTION Long Bematech_FI_AbreCupomMFD(String CGC , String Nome , String Endereco ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_AbreCupomMFD;Ansi" ;
FUNCTION Long Bematech_FI_CancelaCupomMFD(String CGC , String Nome , String Endereco ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CancelaCupomMFD;Ansi" ;
FUNCTION Long Bematech_FI_AcrescimoDescontoItemMFD(String Item , String AcrescimoDesconto , String TipoAcrescimoDesconto , String ValorAcrescimoDesconto ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_AcrescimoDescontoItemMFD;Ansi" ;
FUNCTION Long Bematech_FI_AbreRecebimentoNaoFiscalMFD(String CGC , String Nome , String Endereco ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_AbreRecebimentoNaoFiscalMFD;Ansi" ;
FUNCTION Long Bematech_FI_EfetuaRecebimentoNaoFiscalMFD(String IndiceTotalizador , String ValorRecebimento ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_EfetuaRecebimentoNaoFiscalMFD;Ansi" ;
FUNCTION Long Bematech_FI_FechaRecebimentoNaoFiscalMFD(String Mensagem ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_FechaRecebimentoNaoFiscalMFD;Ansi" ;
FUNCTION Long Bematech_FI_CancelaRecebimentoNaoFiscalMFD(String CGC , String Nome , String Endereco ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CancelaRecebimentoNaoFiscalMFD;Ansi" ;
FUNCTION Long Bematech_FI_AbreRelatorioGerencialMFD(String Indice ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_AbreRelatorioGerencialMFD;Ansi" ;
FUNCTION Long Bematech_FI_UsaRelatorioGerencialMFD(String Texto ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_UsaRelatorioGerencialMFD;Ansi" ;
FUNCTION Long Bematech_FI_VersaoFirmwareMFD(Ref String VersaoFirmware ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_VersaoFirmwareMFD;Ansi" ;
FUNCTION Long Bematech_FI_ContadorComprovantesCreditoMFD(Ref String Comprovantes ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_ContadorComprovantesCreditoMFD;Ansi" ;
FUNCTION Long Bematech_FI_ContadorRelatoriosGerenciaisMFD(Ref String Relatorios ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_ContadorRelatoriosGerenciaisMFD;Ansi" ;
FUNCTION Long Bematech_FI_ContadorCupomFiscalMFD(Ref String CuponsEmitidos ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_ContadorCupomFiscalMFD;Ansi" ;
FUNCTION Long Bematech_FI_DadosUltimaReducaoMFD(Ref String DadosReducao ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_DadosUltimaReducaoMFD;Ansi" ;
FUNCTION Long Bematech_FI_LeituraMemoriaFiscalDataMFD(String DataInicial , String DataFinal , String FlagLeitura ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_LeituraMemoriaFiscalDataMFD;Ansi" ;
FUNCTION Long Bematech_FI_LeituraMemoriaFiscalReducaoMFD(String ReducaoInicial , String ReducaoFinal , String FlagLeitura ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_LeituraMemoriaFiscalReducaoMFD;Ansi" ;
FUNCTION Long Bematech_FI_LeituraMemoriaFiscalSerialDataMFD(String DataInicial , String DataFinal , String FlagLeitura ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_LeituraMemoriaFiscalSerialDataMFD;Ansi" ;
FUNCTION Long Bematech_FI_LeituraMemoriaFiscalSerialReducaoMFD(String ReducaoInicial , String ReducaoFinal , String FlagLeitura ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_LeituraMemoriaFiscalSerialReducaoMFD;Ansi" ;
FUNCTION Long Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD(String FlagRetorno ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD;Ansi" ;
FUNCTION Long Bematech_FI_RetornoImpressoraMFD(Ref Long _ACK , Ref Long _ST1 , Ref Long _ST2 , Ref Long _ST3 ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_RetornoImpressoraMFD;Ansi" ;
FUNCTION Long Bematech_FI_SubTotalizaRecebimentoMFD() LIBRARY "bemafi32.dll" ;
FUNCTION Long Bematech_FI_TotalizaRecebimentoMFD() LIBRARY "bemafi32.dll" ;
FUNCTION Long Bematech_FI_PercentualLivreMFD(Ref String cMemoriaLivre ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_PercentualLivreMFD;Ansi" ;
FUNCTION Long Bematech_FI_DataHoraUltimoDocumentoMFD(Ref String cDataHora ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_DataHoraUltimoDocumentoMFD;Ansi" ;
FUNCTION Long Bematech_FI_IniciaFechamentoCupomMFD(String AcrescimoDesconto , String TipoAcrescimoDesconto , String ValorAcrescimo , String ValorDesconto ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_IniciaFechamentoCupomMFD;Ansi" ;
FUNCTION Long Bematech_FI_DownloadMF(String Arquivo ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_DownloadMF;Ansi" ;
FUNCTION Long Bematech_FI_DownloadMFD(String Arquivo , String TipoDownload , String ParametroInicial , String ParametroFinal , String UsuarioECF ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_DownloadMFD;Ansi" ;
FUNCTION Long Bematech_FI_FormatoDadosMFD(String ArquivoOrigem , String ArquivoDestino , String TipoFormato , String TipoDownload , String ParametroInicial , String ParametroFinal , String UsuarioECF ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_FormatoDadosMFD;Ansi" ;
FUNCTION Long Bematech_FI_ArquivoMFD(String Arquivo , String ParametroInicial , String ParametroFinal , String TipoDownload , String UsuarioECF , Integer TipoGeracao , String ChavePublica , String ChavePrivada , Integer UnicoArquivo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_ArquivoMFD;Ansi" ;
FUNCTION Long Bematech_FI_ArquivoMFDPath(String Arquivo , String ArquivoDestino, String ParametroInicial , String ParametroFinal , String TipoDownload , String UsuarioECF , Integer TipoGeracao , String ChavePublica , String ChavePrivada , Integer UnicoArquivo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_ArquivoMFDPath;Ansi" ;

// Outras Fun$$HEX2$$e700f500$$ENDHEX$$es 
FUNCTION Long Bematech_FI_AbrePortaSerial() LIBRARY "bemafi32.dll" ;
FUNCTION Long Bematech_FI_RetornoImpressora(Ref Long _ACK , Ref Long _ST1 , Ref Long _ST2 ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_RetornoImpressora;Ansi" ;
FUNCTION Long Bematech_FI_FechaPortaSerial() LIBRARY "bemafi32.dll" ;
FUNCTION Long Bematech_FI_VerificaImpressoraLigada() LIBRARY "bemafi32.dll" ;
FUNCTION Long Bematech_FI_AberturaDoDia(String Valor , String FormaPagamento ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_AberturaDoDia;Ansi" ;
FUNCTION Long Bematech_FI_VersaoDll(Ref String Versao ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_VersaoDll;Ansi" ;
FUNCTION Long Bematech_FI_DataHoraReducao(Ref String Data , Ref String Hora ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_DataHoraReducao;Ansi" ;
FUNCTION Long Bematech_FI_DataMovimento(Ref String Data ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_DataMovimento;Ansi" ;
FUNCTION Long Bematech_FI_VerificaFormasPagamento(Ref String Formas ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_VerificaFormasPagamento;Ansi" ;
FUNCTION Long Bematech_FI_DadosUltimaReducao(Ref String DadosReducao ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_DadosUltimaReducao;Ansi" ;
FUNCTION Long Bematech_FI_ProgramaAliquota(String Aliquota, Long Vinculo ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_ProgramaAliquota;Ansi" ;
FUNCTION Long Bematech_FI_RetornoAliquotas(Ref String Aliquotas ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_RetornoAliquotas;Ansi" ;

// Fun$$HEX2$$e700f500$$ENDHEX$$es de Informa$$HEX2$$e700e300$$ENDHEX$$o da Impressora
FUNCTION Long Bematech_FI_InicioFimGTsMFD(Ref String ls_Inicial, Ref String ls_Final) LIBRARY "bemafi32.dll" alias for "Bematech_FI_InicioFimGTsMFD;Ansi" ;
FUNCTION Long Bematech_FI_SubTotal(Ref String SubTotal ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_SubTotal;Ansi" ;
FUNCTION Long Bematech_FI_NumeroCupom(Ref String NumeroCupom ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_NumeroCupom;Ansi" ;
FUNCTION Long Bematech_FI_VersaoFirmware(Ref String VersaoFirmware ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_VersaoFirmware;Ansi" ;
FUNCTION Long Bematech_FI_GrandeTotal(Ref String GrandeTotal ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_GrandeTotal;Ansi" ;
FUNCTION Long Bematech_FI_NumeroOperacoesNaoFiscais(Ref String NumeroOperacoes ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_NumeroOperacoesNaoFiscais;Ansi" ;
FUNCTION Long Bematech_FI_NumeroCaixa(Ref String NumeroCaixa ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_NumeroCaixa;Ansi" ;
FUNCTION Long Bematech_FI_FlagsFiscaisStr(Ref String Flag ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_FlagsFiscaisStr;Ansi" ;
FUNCTION Long Bematech_FI_ValorPagoUltimoCupom(Ref String ValorCupom ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_ValorPagoUltimoCupom;Ansi" ;
FUNCTION Long Bematech_FI_DataHoraImpressora(Ref String Data ,Ref String Hora ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_DataHoraImpressora;Ansi" ;
FUNCTION Long Bematech_FI_VendaBruta(Ref String Valor) LIBRARY "bemafi32.dll" alias for "Bematech_FI_VendaBruta;Ansi" ;
FUNCTION Long Bematech_FI_FlagsFiscais(Ref Long Flag ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_FlagsFiscais;Ansi" ;

// Fun$$HEX2$$e700f500$$ENDHEX$$es para Impress$$HEX1$$e300$$ENDHEX$$o dos C$$HEX1$$f300$$ENDHEX$$digos de Barras 
FUNCTION Long Bematech_FI_ConfiguraCodigoBarrasMFD(Long Altura , Long Largura , Long PosicaoCaracteres , Long Fonte , Long Margem ) LIBRARY "bemafi32.dll" ;
FUNCTION Long Bematech_FI_CodigoBarrasUPCAMFD(String Codigo ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasUPCAMFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasUPCEMFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasUPCEMFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasEAN13MFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasEAN13MFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasEAN8MFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasEAN8MFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasCODE39MFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasCODE39MFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasCODE93MFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasCODE93MFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasCODE128MFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasCODE128MFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasITFMFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasITFMFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasCODABARMFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasCODABARMFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasISBNMFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasISBNMFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasMSIMFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasMSIMFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasPLESSEYMFD(String Codigo) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasPLESSEYMFD;Ansi" ;
FUNCTION Long Bematech_FI_CodigoBarrasPDF417MFD(Long NivelCorrecaoErros , Long Altura , Long Largura , Long Colunas , String Codigo ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CodigoBarrasPDF417MFD;Ansi" ;

// Fun$$HEX2$$e700f500$$ENDHEX$$es das Opera$$HEX2$$e700f500$$ENDHEX$$es N$$HEX1$$e300$$ENDHEX$$o Fiscais
FUNCTION Long Bematech_FI_RecebimentoNaoFiscal(String IndiceTotalizador , String Valor , String FormaPagamento ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_RecebimentoNaoFiscal;Ansi" ;
FUNCTION Long Bematech_FI_AbreComprovanteNaoFiscalVinculado(String FormaPagamento , String Valor , String NumeroCupom ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_AbreComprovanteNaoFiscalVinculado;Ansi" ;
FUNCTION Long Bematech_FI_UsaComprovanteNaoFiscalVinculado(String Texto ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_UsaComprovanteNaoFiscalVinculado;Ansi" ;
FUNCTION Long Bematech_FI_FechaComprovanteNaoFiscalVinculado() LIBRARY "bemafi32.dll" alias for "Bematech_FI_FechaComprovanteNaoFiscalVinculado;Ansi";
FUNCTION Long Bematech_FI_Sangria(String Valor ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_Sangria;Ansi" ;
FUNCTION Long Bematech_FI_Suprimento(String Valor , String FormaPagamento ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_Suprimento;Ansi" ;

// Fun$$HEX2$$e700f500$$ENDHEX$$es dos Relat$$HEX1$$f300$$ENDHEX$$rios Fiscais
FUNCTION Long Bematech_FI_LeituraX() LIBRARY "bemafi32.dll" ;
FUNCTION Long Bematech_FI_LeituraXSerial() LIBRARY "bemafi32.dll" ;
FUNCTION Long Bematech_FI_ReducaoZ(String Data , String Hora ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_ReducaoZ;Ansi" ;
FUNCTION Long Bematech_FI_FechaRelatorioGerencial() LIBRARY "bemafi32.dll" alias for "Bematech_FI_FechaRelatorioGerencial;Ansi" ;
FUNCTION Long Bematech_FI_GeraRegistrosCAT52MFD(String ArquivoMFD, String cDataMovimento) LIBRARY "bemafi32.dll" alias for "Bematech_FI_GeraRegistrosCAT52MFD;Ansi";
FUNCTION Long Bematech_FI_GeraRegistrosCAT52MFDEx(String ArquivoMFD, String cDataMovimento, Ref String ArquivoDestino) LIBRARY "bemafi32.dll" alias for "Bematech_FI_GeraRegistrosCAT52MFDEx;Ansi";

// Fun$$HEX2$$e700f500$$ENDHEX$$es de Inicializa$$HEX2$$e700e300$$ENDHEX$$o Bematech
FUNCTION Long Bematech_FI_ProgramaHorarioVerao() LIBRARY "bemafi32.dll" ;
FUNCTION Long Bematech_FI_VerificaSensorPoucoPapelMFD( Ref String cFlag ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_VerificaSensorPoucoPapelMFD;Ansi" ;

// Fun$$HEX2$$e700f500$$ENDHEX$$es do Cupom Fiscal
FUNCTION Long Bematech_FI_CancelaItemAnterior() LIBRARY "bemafi32.dll" ;
FUNCTION Long Bematech_FI_CancelaItemGenerico(String Item) LIBRARY "bemafi32.dll" alias for "Bematech_FI_CancelaItemGenerico;Ansi" ;
FUNCTION Long Bematech_FI_VendeItemDepartamento(String Codigo , String Descricao , String Aliquota , String ValorUnitario , String Quantidade , String Acrescimo , String Desconto , String IndiceDepartamento , String UnidadeMedida ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_VendeItemDepartamento;Ansi" ;
FUNCTION Long Bematech_FI_EfetuaFormaPagamentoIndice(String FormaPagamento ,String ValorFormaPagamento) Library "bemafi32.dll" alias for "Bematech_FI_EfetuaFormaPagamentoIndice;Ansi";
FUNCTION Long Bematech_FI_TerminaFechamentoCupom(String Mensagem ) LIBRARY "bemafi32.dll" alias for "Bematech_FI_TerminaFechamentoCupom;Ansi" ;

//Fun$$HEX2$$e700f500$$ENDHEX$$es Novas para usar com MP4200 -  conv.09/09
FUNCTION Long Bematech_FI_AbreCupomCV0909(String CGC , String Nome , String Endereco ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_AbreCupomCV0909;Ansi" ;
FUNCTION Long Bematech_FI_AbreComprovanteNaoFiscalVinculadoCV0909(Integer SeqPagamento, String FormaPagamento, Integer QtdParcelas, Integer Parcela, String CGC , String Nome , String Endereco ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_AbreComprovanteNaoFiscalVinculadoCV0909;Ansi" ;
FUNCTION Long Bematech_FI_VendeItemCV0909(String Codigo , String Descricao , String Aliquota , String Quantidade , Integer DecimaisQtd  , String ValorUnitario , String UnidadeMedida , String DecimaisVlr, String IndiceArredondamento ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_VendeItemCV0909;Ansi" ;
FUNCTION Long Bematech_FI_AbreRecebimentoNaoFiscalCV0909(String CGC , String Nome , String Endereco ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_AbreRecebimentoNaoFiscalCV0909;Ansi" ;
FUNCTION Long Bematech_FI_AbreRelatorioGerencialCV0909(String IndiceREL) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_AbreRelatorioGerencialCV0909;Ansi" ;
FUNCTION Long Bematech_FI_AcrescimoDescontoItemCV0909(String Item ,  String TipoAcrescimoDesconto , String AcrescimoDesconto , String ValorAcrescimoDesconto ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_AcrescimoDescontoItemCV0909;Ansi" ;
FUNCTION Long Bematech_FI_AcrescimoDescontoSubtotalCV0909( String TipoDesconto , String FormatoDesconto , String ValorDesconto ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_AcrescimoDescontoSubtotalCV0909;Ansi" ;
FUNCTION Long Bematech_FI_BufferRespostaCV0909(Ref String Buffer ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_BufferRespostaCV0909;Ansi" ;
FUNCTION Long Bematech_FI_CancelaAcrescimoDescontoItemCV0909(String Tipo ,  String Item ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_CancelaAcrescimoDescontoItemCV0909;Ansi" ;
FUNCTION Long Bematech_FI_CancelaAcrescimoDescontoSubtotalCV0909(String Tipo ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_CancelaAcrescimoDescontoSubtotalCV0909;Ansi" ;
FUNCTION Long Bematech_FI_CancelaCupomAtualCV0909() LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_CancelaCupomAtualCV0909;Ansi" ;
FUNCTION Long Bematech_FI_CancelaCupomCV0909(String COO) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_CancelaCupomCV0909;Ansi" ;
FUNCTION Long Bematech_FI_DadosUltimaReducaoCV0909(Ref String Dados ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_DadosUltimaReducaoCV0909;Ansi" ;
FUNCTION Long Bematech_FI_DownloadMFCV0909(String Arquivo , String TipoDownload , String ParametroInicial , String ParametroFinal) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_DownloadMFCV0909;Ansi" ;
FUNCTION Long Bematech_FI_DownloadMFDCV0909(String Arquivo , String TipoDownload , String ParametroInicial , String ParametroFinal) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_DownloadMFDCV0909;Ansi" ;
FUNCTION Long Bematech_FI_DownloadSBCV0909(String Arquivo) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_DownloadSBCV0909;Ansi" ;
FUNCTION Long Bematech_FI_EfetuaFormaPagamentoIndiceCV0909(String FormaPagamento ,String ValorFormaPagamento, String Parcela, String Obs, String CodFormaPagamento) Library "BEMAFI32.DLL" alias for "Bematech_FI_EfetuaFormaPagamentoIndiceCV0909;Ansi";
FUNCTION Long Bematech_FI_EfetuaRecebimentoNaoFiscalCV0909(String FormaPagamento ,String ValorFormaPagamento) Library "BEMAFI32.DLL" alias for "Bematech_FI_EfetuaRecebimentoNaoFiscalCV0909;Ansi";
FUNCTION Long Bematech_FI_EstornoFormasPagamentoCV0909(String FormaPagamentoOrigem ,String FormaPagamentoDestino, String ValorEstorno, String Parcela, String Obs) Library "BEMAFI32.DLL" alias for "Bematech_FI_EstornoFormasPagamentoCV0909;Ansi";
FUNCTION Long Bematech_FI_EstornoNaoFiscalVinculadoCV0909(String CPF ,String Nome, String Endereco, String COO) Library "BEMAFI32.DLL" alias for "Bematech_FI_EstornoNaoFiscalVinculadoCV0909;Ansi";
FUNCTION Long Bematech_FI_FechaRecebimentoNaoFiscalCV0909(String Mensagem, Integer Guilhotina) Library "BEMAFI32.DLL" alias for "Bematech_FI_FechaRecebimentoNaoFiscalCV0909;Ansi";
FUNCTION Long Bematech_FI_FechaRelatorioGerencialCV0909(Integer Guilhotina) Library "BEMAFI32.DLL" alias for "Bematech_FI_FechaRelatorioGerencialCV0909;Ansi";
FUNCTION Long Bematech_FI_ImpressaoFitaDetalheCV0909(String Tipo ,String DadoInicial, String DadoFinal) Library "BEMAFI32.DLL" alias for "Bematech_FI_ImpressaoFitaDetalheCV0909;Ansi";
FUNCTION Long Bematech_FI_InterrompeLeiturasCV0909() Library "BEMAFI32.DLL" alias for "Bematech_FI_InterrompeLeiturasCV0909;Ansi";
FUNCTION Long Bematech_FI_NumeroCupomCV0909(Ref String Numero) Library "BEMAFI32.DLL" alias for "Bematech_FI_NumeroCupomCV0909;Ansi";
FUNCTION Long Bematech_FI_ReducaoZCV0909(String Data, String Hora, Integer Situacao) Library "BEMAFI32.DLL" alias for "Bematech_FI_ReducaoZCV0909;Ansi";
FUNCTION Long Bematech_FI_RetornoImpressoraCV0909(Ref Long _CAT , Ref Long _RET1 , Ref Long _RET2 , Ref Long _RET3, Ref Long _RET4 ) LIBRARY "BEMAFI32.DLL" alias for "Bematech_FI_RetornoImpressoraCV0909;Ansi" ;
FUNCTION Long Bematech_FI_TerminaFechamentoCupomCV0909(String Mensagem, Integer CupomAdd, Integer Guilhotina) Library "BEMAFI32.DLL" alias for "Bematech_FI_TerminaFechamentoCupomCV0909;Ansi";
FUNCTION Long Bematech_FI_UsaRelatorioGerencialCV0909(String Mensagem) Library "BEMAFI32.DLL" alias for "Bematech_FI_UsaRelatorioGerencialCV0909;Ansi";
FUNCTION Long Bematech_FI_InicioFimGTsCV0909(Ref String ls_Inicial, Ref String ls_Final) LIBRARY "bemafi32.dll" alias for "Bematech_FI_InicioFimGTsCV0909;Ansi" ;
end prototypes

type variables
CONSTANT INTEGER COLUNAS = 60

STRING ivs_status
Long	   ivl_status

BOOLEAN ivb_cancelar       =  FALSE
BOOLEAN ivb_showerror      = TRUE
BOOLEAN ivb_gaveta          =  FALSE
BOOLEAN ivb_modo_teste   = FALSE
BOOLEAN ivb_porta_aberta = FALSE
BOOLEAN ivb_Ativa             = FALSE
BOOLEAN ivb_ReducaoZ    = FALSE
BOOLEAN ivb_Cadastrada  = FALSE
BOOLEAN ivb_Cod_Barras	 = FALSE
BOOLEAN ivb_modelo_CONV0909

LONG ECF
LONG Porta
LONG Timeout
LONG Ack
LONG St1
LONG St2
LONG St3

STRING ivs_Path_Log
STRING ivs_Versao
STRING ivs_grava_log

STRING nr_Serie
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
public function boolean of_desconto_cupom (string ps_texto, decimal pd_valor)
public subroutine of_msg_impressoraoffline ()
public function boolean of_pergunta_impressoraoffline ()
public function boolean of_pergunta_leiturax ()
public function boolean of_pergunta_reducaoz ()
public function boolean of_pergunta_posiciona_cheque ()
public function integer of_statusok ()
public subroutine of_sleep (long pl_segundos)
public function boolean of_dataecf (ref date pd_dataecf)
public function string of_converte_indicador (string ps_indicador)
public function boolean of_pergunta_cancelacupom ()
public subroutine of_grava_logerro (string ps_comando)
public function boolean of_permite_cancelamento_cupom ()
public function boolean of_texto_nao_fiscal_tef (string ps_texto)
public function boolean of_pergunta_folha_solta ()
public function boolean of_pergunta_deseja_imprimir_cheque ()
public function boolean of_pergunta_falta_papel ()
public subroutine of_msg_cupom_aberto_gravado ()
public subroutine of_msg_cupom_aberto ()
public subroutine of_msg_cancelamento_invalido ()
public function boolean of_leitura_totais (integer pi_tipo)
public function boolean of_aguarda_execucao_comando_tef ()
public function boolean of_cancela_cupom (long pl_ecf, long pl_seq)
public function integer of_controle_caixa_conferido (long pl_ecf, long pl_seq)
public function boolean of_cupom_gravado (long pl_ecf, long pl_seq)
public function boolean of_fecha_cupom_nao_fiscal (string ps_vinculado)
public function boolean of_fecha_cupom_nao_fiscal ()
public function string of_indicador_aliquota (decimal pd_aliquota, string ps_tributacao_icms)
public function boolean of_verifica_drivers ()
public function boolean of_path_log (string ps_path_log)
public subroutine of_fechaporta ()
public function boolean of_aguarda_execucao ()
public function boolean of_grava_log_ecf ()
public function boolean of_timeout_ecf ()
public function boolean of_horario_verao_parametros (ref date adt_inicio, ref date adt_termino)
public function boolean of_horario_verao_ajuste (string ps_modo)
public function boolean of_datafiscal (ref date pd_datafiscal)
public function boolean of_registra_cancelamento (long pl_ecf, long pl_seq)
public function boolean of_impressora_online ()
public function boolean of_nr_ecf (ref long pl_ecf)
public function boolean of_dados_impressora (ref long pl_sequencial, ref long pl_ecf)
public function string of_centraliza_texto (string ps_texto)
public function boolean of_horaecf (ref string ps_hora)
public function boolean of_fecha_comprovante_tef ()
public function boolean of_gt_inicial_final (ref decimal pdc_inicial, ref decimal pdc_final)
public function boolean of_inicializa_recebimento_nao_fiscal ()
public function boolean of_efetua_recebimento_nao_fiscal (string ps_tipo, string ps_valor)
public function boolean of_totaliza_cupom (string ps_tipo[], decimal pd_valor[])
public function boolean of_recebimento_nao_fiscal (string ps_tipo, string ps_valor)
public function boolean of_totaliza_recebimento_nao_fiscal (string ps_pagamento, string ps_valor)
public function boolean of_cancela_recebimento_nao_fiscal ()
public function boolean of_valor_pago_ultimo_cupom (ref decimal pdc_valor)
public function boolean of_modo_impressora_old ()
public function boolean of_verifica_status_horario_verao (ref string ps_status)
public function boolean of_programa_horario_verao ()
public function boolean of_horario_verao ()
public function boolean of_grava_mapa_resumo (date pdh_data)
public function boolean of_desconto_item (long pl_item, decimal pdc_desconto, decimal pdc_valor)
public function boolean of_leiturax (boolean pb_arquivo)
public function boolean of_leitura_memoria_fiscal (string ps_data_inicio, string ps_data_final, boolean pb_arquivo, string ps_tipo)
public function boolean of_marca_modelo_tipo ()
public function boolean of_data_hora_usuario_software_basico ()
public function boolean of_verifica_versao_software_basico ()
public function boolean of_percentual_livre_mfd ()
public function boolean of_carrega_dados_ecf (long pl_ecf)
public function string of_formata_valor_pafecf (decimal pdc_valor, long pl_inteiro, long pl_decimal)
public function boolean of_contador_credito_debito (ref long pl_contador)
public function boolean of_contador_relatorio_gerencial (ref long pl_contador)
public function boolean of_contador_operacao_nao_fiscal (ref long pl_contador)
public function boolean of_renomeia_arquivo (string ps_antigo, string ps_novo, boolean pb_replace)
public function boolean of_registra_documento_ecf (string ps_documento, decimal pdc_valor)
public function boolean of_suprimento_caixa (decimal pdc_valor)
public function boolean of_sangria_caixa (decimal pdc_valor)
public function boolean of_leitura_memoria_fiscal_reducao (long pl_reducao_inicial, long pl_reducao_final, boolean pb_arquivo, string ps_tipo)
public function boolean of_flags_st1 ()
public function boolean of_flags_st2 ()
public function string of_meio_pagamento (string ps_pagamento)
public function boolean of_verifica_forma_pagamento (ref string ps_formapagto[])
public function boolean of_assinatura_digital (string ps_arquivo)
public function boolean of_verifica_cupons_pendentes ()
public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final)
public function datetime of_dh_movimentacao ()
public function boolean of_verifica_versao_dll ()
public function boolean of_venda_bruta (ref decimal pdc_venda)
public function boolean of_grande_total (ref decimal pdc_venda)
public function boolean of_data_ultima_reducaoz (ref date pd_datafiscal)
public function boolean of_data_ultimo_documento_fiscal (ref datetime pd_datahora)
public function boolean of_mapa_resumo (ref s_ge039_mapa_resumo ps_mapa_resumo)
public function boolean of_verifica_data_movimentacao ()
public function boolean of_verifica_ultimo_mapa_resumo ()
public function boolean of_atualiza_drivers ()
public function boolean of_atualiza_numero_seriemfd ()
public function boolean of_verifica_problemas_impressora ()
public function boolean of_verifica_flags_fiscais ()
public function boolean of_abreporta ()
public function boolean of_registra_item_vendido (string ps_produto, long pd_qtd, decimal pd_precounit, decimal pd_pretotot, string ps_descricao, decimal pd_aliquota, string ps_complemento, string ps_tributacao_icms, string ps_un)
public function boolean of_nr_cupom (ref long pl_sequencial)
public function boolean of_inicializa_comprovante_tef_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor)
public function boolean of_numero_serie ()
public function boolean of_reducaoz ()
public function boolean of_capturar_md5 (string ps_arquivo, ref string ps_md5)
public subroutine of_status_extendido_ecf ()
public subroutine of_status_extendido_nao_fiscal_ecf ()
public function boolean of_status_papel_ok ()
public function string of_status_st3 ()
public function long of_status_ecf ()
public function boolean of_contador_cupom_fiscal (ref long pl_contador)
public function boolean of_gera_arquivo_cotepe1704 (string ps_tipo, string ps_inicio, string ps_final, string ps_razao_social, string ps_endereco)
public function string of_desencripta (string ps_texto)
public function string of_encripta (string ps_texto)
public function boolean of_atualiza_data_fiscal ()
public function boolean of_atualiza_venda_bruta ()
public function boolean of_leitura_memoria_fiscal_ac1704 (string ps_dado_inicio, string ps_dado_final)
public function boolean of_registra_documento_ecf (string ps_documento)
public function boolean of_cancela_item_anterior ()
public function boolean of_verifica_venda_bruta_diaria ()
public function boolean of_fecha_cupom (string ps_msg[], boolean pb_repete, string ps_indicadores[6, 2], string ps_vinculado)
public function boolean of_registra_documento_ecf (string ps_documento, string ps_totalizador, decimal pdc_valor)
public function boolean of_inicializa_comprovante_tef (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor, string ps_cupom)
public function boolean of_fecha_relatorio_gerencial ()
public function boolean of_inicializa_relatorio_gerencial (string ps_relatorio, decimal pdc_valor)
public function boolean of_conecta_impressora ()
public function boolean of_configuracoes ()
public function boolean of_abertura_dia ()
public function boolean of_porta_comunicacao ()
public function boolean of_atualiza_cadastro_ecf ()
public function boolean of_codigo_barras (integer pl_tipo, string ps_codigo, string ps_tamanho)
public function boolean of_pergunta_tentativa (boolean pvb_abrindo)
public function boolean of_texto_relatorio_gerencial (string ps_texto)
public function boolean of_inicializa_comprovante_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor)
public function boolean of_imprime_relatorio_gerencial (string ps_texto[], string ps_tipo)
public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor)
public function boolean of_inicializa_cupom (string ps_cpf_cgc)
public function boolean of_gera_arquivo_cat52 (string ps_arquivo, date pdh_data_fiscal)
public function boolean of_gera_arquivo_cat52 (string ps_arquivo, date pdh_data_fiscal, ref string ps_arquivo_destino)
public function boolean of_fecha_recebimento_nao_fiscal (string ps_texto)
public function boolean of_atualiza_dll_sign ()
public function boolean of_programa_aliquota (boolean pb_automatico, decimal pdc_aliquota, long pl_tipo, boolean pb_mostra_mensagem)
public function boolean of_cancela_item (integer pl_item)
public function long of_verifica_retorno_ecf (long pl_retorno, string ps_funcao)
public function string of_normaliza_texto (string ps_texto)
public function boolean of_data_hora_ecf (ref datetime pd_dataecf)
public function boolean of_retorna_doc_aberto (ref long pl_doc)
public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final, string ps_arquivo)
public function boolean of_gera_arquivo_mfd (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_caminho_mfd)
public function boolean of_gera_arquivo_cotepe_mensal (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_dir_mfd, boolean pb_gera_mfd, ref boolean pb_mfd_gerado)
public function boolean of_subtotal_cupom (ref string ps_subtotal)
public function boolean of_gera_arquivos_ecf (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_espelhos, long pl_tipo_geracao, string ps_dir_mfd, ref string ps_arquivo_gerado)
public function boolean of_verifica_arquivo_manutencao (ref boolean pb_existe_arquivo)
end prototypes

public function boolean of_desconto_cupom (string ps_texto, decimal pd_valor);If This.ivb_Modo_Teste Then Return True

String ls_valor

Long ll_Retry
Long ll_Retorno

ls_valor = String(pd_valor)

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_IniciaFechamentoCupomMFD("D","$","0,00",ls_valor),'Bematech_FI_IniciaFechamentoCupomMFD')
	
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

public function boolean of_pergunta_impressoraoffline ();Return (Messagebox("Impressora Fiscal","Verifique se a impressora fiscal est$$HEX1$$e100$$ENDHEX$$ ligada e se os cabos est$$HEX1$$e300$$ENDHEX$$o corretamente conectados.~r~nTentar novamente ?", Question!,YesNo!,1) = 1)
end function

public function boolean of_pergunta_leiturax ();Return (Messagebox("Impressora Fiscal","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a Leitura X da Impressora Fiscal. Confirma Leitura X ?",Question!,YesNo!,1) = 1)
end function

public function boolean of_pergunta_reducaoz ();Return (MessageBox("Impressora Fiscal","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a Redu$$HEX2$$e700e300$$ENDHEX$$o Z da Impressora Fiscal. ~r~nConfirma Redu$$HEX2$$e700e300$$ENDHEX$$o Z ?",Question!,YesNo!,1) = 1)
end function

public function boolean of_pergunta_posiciona_cheque ();Return (Messagebox("Impressora Fiscal","Insira o cheque para impress$$HEX1$$e300$$ENDHEX$$o e posicione-o corretamente. Tentar novamente ?",Question!,YesNo!,1) = 1)
end function

public function integer of_statusok ();
IF ivs_status = ".-P006}" THEN
	RETURN 1
ELSEIF ivs_status = ".-P002}" THEN
	RETURN 2
ELSEIF LeftA(ivs_status,6) = ".-P555" OR LeftA(ivs_status,6) = ".-P550" THEN
	RETURN 3
END IF

RETURN 0

end function

public subroutine of_sleep (long pl_segundos);//
TIME  lvt_inicio
//
lvt_inicio = Now()
//
DO WHILE TRUE
	IF SecondsAfter(lvt_inicio , Now()) >= pl_segundos THEN		 
		EXIT
	END IF
LOOP
//
end subroutine

public function boolean of_dataecf (ref date pd_dataecf);If This.ivb_Modo_Teste Then Return True

String ls_Data
String ls_Hora
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Data = Space( 7 )
ls_Hora = Space( 7 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DataHoraImpressora(Ref ls_Data, Ref ls_Hora),'Bematech_FI_DataHoraImpressora')
	
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

public function string of_converte_indicador (string ps_indicador);
//Estes indicadores s$$HEX1$$e300$$ENDHEX$$o exclusivamento propriet$$HEX1$$e100$$ENDHEX$$rios da impressora SWEDA

String ls_Indicador

CHOOSE CASE Upper(ps_indicador)
	CASE "OPERADOR"   ; ls_Indicador = "01"
	CASE "LOJA"       ; ls_Indicador = "04"
	CASE "VENDEDOR"   ; ls_Indicador = "05"
	CASE "CAIXA"      ; ls_Indicador = "11"
	CASE "ENTREGADOR" ; ls_Indicador = "16"
	CASE "FUNC"       ; ls_Indicador = "24"
	CASE "CARTAO"     ; ls_Indicador = "32"		
	CASE "DOC"        ; ls_Indicador = "29"	
END CHOOSE

RETURN ls_Indicador


		
end function

public function boolean of_pergunta_cancelacupom ();RETURN (messagebox("Impressora Fiscal","Deseja cancelar cupom fiscal ?",Question!,YesNo!,2) = 1)

end function

public subroutine of_grava_logerro (string ps_comando);//
STRING  lvs_erro, lvs_status, lvs_file, lvs_comando
INTEGER lvi_file, lvi_Bytes
//
lvs_file = ivs_Path_Log+"\ecf.log"
//
lvi_file = FileOpen(lvs_file,LineMode!,Write!,Shared!,Append!)
//
IF lvi_file = -1 THEN
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao gravar arquivo ' + lvs_file , StopSign!)
	RETURN
END IF
//
lvs_erro = ""
lvs_erro = String(DateTime(Today(),Now())) + ' ECF:' + String(THIS.ECF) + " ENVIADO : '" + ps_comando + "' RECEBIDO : '" + ivs_status + "'"
//
lvi_Bytes = FileWrite (lvi_file,Trim(lvs_erro))
//
IF lvi_Bytes <> LenA(lvs_erro) THEN
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao gravar log.',StopSign!)
END IF
//
FileClose(lvi_file)
//
end subroutine

public function boolean of_permite_cancelamento_cupom ();If This.ivb_Modo_Teste Then Return True

If Not This.of_Verifica_Flags_Fiscais() Then Return False

// Verifica se existem cupons fiscais pendentes 
//If Long(ivs_Status) >= 32 Then Return True
If ivl_Status >= 32 Then Return True

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o cancelamento do documento impresso.",Exclamation!)

Return False
end function

public function boolean of_texto_nao_fiscal_tef (string ps_texto);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_St1
Long ll_asc

Do While ll_Retry <= 3	

	ll_asc = AscA(ps_texto)
	If ll_asc = 13 Then //para resolver problema com a MP4200
		ps_texto = '      '
	Else
		ll_asc = AscA(Trim(ps_texto))
		If ll_asc = 13 Then
			ps_texto = '      '			
		End If
	End If	
	If LenA(Trim(ps_texto)) < 35 Then //para resolver problema com a MP4200
		ps_texto = ps_texto  + FillA(" ",(35 - LenA(Trim(ps_texto))))
	End If
		
	ps_texto = CharA(27) + CharA(15) + ps_texto + CharA(13) + CharA(10)
		
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_UsaComprovanteNaoFiscalVinculado(ps_texto),'Bematech_FI_UsaComprovanteNaoFiscalVinculado')
	
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

public function boolean of_pergunta_folha_solta ();Return (Messagebox("Impressora Fiscal","H$$HEX1$$e100$$ENDHEX$$ folha solta na Impressora Fiscal.Tentar novamente ?",Question!,YesNo!,1) = 1)
end function

public function boolean of_pergunta_deseja_imprimir_cheque ();RETURN (Messagebox("Impressora Fiscal","Deseja Imprimir Cheque ?",Question!,YesNo!) = 1)

end function

public function boolean of_pergunta_falta_papel ();Return (Messagebox("Impressora Fiscal","Falta de papel ou t$$HEX1$$e900$$ENDHEX$$rmino de bobina detectado. A troca j$$HEX1$$e100$$ENDHEX$$ foi efetuada?",Question!,YesNo!,1) = 1)
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

public function boolean of_leitura_totais (integer pi_tipo);
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
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_CancelaCupomMFD("","",""),'Bematech_FI_CancelaCupomMFD')
	
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
	gvo_aplicacao.of_grava_log("Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do controle caixa, fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_controle_caixa_conferido().~r~n"+&
									Sqlca.SQLErrText+".")
	Return -1
ElseIf Sqlca.Sqlcode = 100 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Controle caixa referente ao cupom n$$HEX1$$e300$$ENDHEX$$o foi encontrado.",StopSign!)
	Return -1
End If	

If Not IsNull(lvdh_Conferencia) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Controle do Caixa referente ao cupom fiscal j$$HEX1$$e100$$ENDHEX$$ foi conferido.",Exclamation!)
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
	gvo_aplicacao.of_grava_log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do cupom fiscal, fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_cupom_gravado().~r~n"+&
									Sqlca.SQLErrText+".")
	Sqlca.Of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o do cupom fiscal.')
	Return False
End If

//Cupom Fiscal n$$HEX1$$e300$$ENDHEX$$o foi localizado
If IsNull(lvl_nr_nf) OR lvl_nr_nf = 0 Then Return False

Return True
end function

public function boolean of_fecha_cupom_nao_fiscal (string ps_vinculado);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_FechaComprovanteNaoFiscalVinculado(),'Bematech_FI_FechaComprovanteNaoFiscalVinculado')
	
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

public function boolean of_fecha_cupom_nao_fiscal ();
Return of_Fecha_Cupom_Nao_Fiscal("N")

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
//	Case 7    	; ls_Indicador = "0700"
//	Case 12   	; ls_Indicador = "1200"
//	Case 25   	; ls_Indicador = "2500"		
//	Case 17   	; ls_Indicador = "1700"
//	Case 18	  	; ls_Indicador = "1800"
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
String	lvs_Drivers []
String lvs_path = 'c:\sistemas\dll\bematech\'
String lvs_Msg

SetPointer(HourGlass!)

If Not This.of_Atualiza_Drivers() Then Return False

lvs_Drivers[1] = "MSJET35.dll"
lvs_Drivers[2] = "BemaFI32.ini"
lvs_Drivers[3] = "DAO350.DLL"
lvs_Drivers[4] = "BemaMFD2.dll"
lvs_Drivers[5] = "BemaMFD.dll"
lvs_Drivers[6] = "BemaFI32.dll"
lvs_Drivers[7] = "AX6R32.DLL"
lvs_Drivers[8] = "SIGN_BEMA.dll"

For lvi_Contador = 1 To UpperBound(lvs_Drivers)
	If Not FileExists(lvs_path + lvs_Drivers[lvi_Contador]) Then
		lvs_Msg = 'Arquivo de driver da Impressora Fiscal n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + lvs_path + lvs_Drivers[lvi_Contador]
		MessageBox('IMPRESSORA Bematech',lvs_Msg,StopSign!)
		gvo_aplicacao.of_grava_log(lvs_Msg)
		Return False
	End If	
Next

Return True
end function

public function boolean of_path_log (string ps_path_log);
This.ivs_path_log = ps_path_log

Return True
end function

public subroutine of_fechaporta ();Long lvl_Retorno
//
If This.ivb_modo_teste Then Return
//
If This.ivb_Porta_Aberta Then
	//
	lvl_Retorno = Bematech_FI_FechaPortaSerial()
	//
	If lvl_Retorno = 1 Then
		This.ivb_Porta_Aberta = False
		THis.ECF              = 0
	End If	
	//
End If



end subroutine

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

public function boolean of_datafiscal (ref date pd_datafiscal);If This.ivb_Modo_Teste Then Return True

String ls_DataMovimento
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_DataMovimento = Space( 7 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DataMovimento(Ref ls_DataMovimento),'Bematech_FI_DataMovimento')
	
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

public function boolean of_registra_cancelamento (long pl_ecf, long pl_seq);
STRING   lvs_Msg , lvs_File
INTEGER  lvi_file, lvi_Bytes
DATETIME lvdh_Data_Movimento

lvdh_Data_Movimento = This.of_dh_movimentacao()

lvs_file = ivs_Path_Log+"\cupons_cancelados.txt"

lvi_file = FileOpen(lvs_file,StreamMode!,Write!,Shared!,Append!)

If lvi_file = -1 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao gravar arquivo ' + lvs_file , StopSign!)
	Return False
End If

lvs_Msg = ""
lvs_Msg = "ECF: " + String(THIS.ECF,'000') + " SEQ: " + String(pl_seq,'0000') + ' DATA: ' + String(lvdh_Data_Movimento,'dd/mm/yyyy') + CharA(13)+CharA(10)

lvi_Bytes = FileWrite (lvi_file,Trim(lvs_Msg))

FileClose(lvi_file)

IF lvi_Bytes <> LenA(lvs_Msg) THEN
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao gravar arquivo de log. ' + lvs_File ,StopSign!)
	Return False
END IF

Return True
end function

public function boolean of_impressora_online ();If This.ivb_Modo_Teste Then Return True

Boolean lb_Sucesso

Long    ll_Retorno

Do While ll_Retorno <> 1
	
	ll_Retorno = Bematech_FI_VerificaImpressoraLigada()

	Choose Case ll_Retorno
		Case 1
			lb_Sucesso = True
		Case 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!)
		Case -4
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o BemaFI32.ini n$$HEX1$$e300$$ENDHEX$$o foi encontrado no diret$$HEX1$$f300$$ENDHEX$$rio de sistema do Windows.",StopSign!)
		Case -5
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao abrir a porta de comunica$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!)
		Case -6
			If of_pergunta_impressoraoffline() Then Continue
			Exit
		Case -27
			//As vezes ocorre com a dll 7 (conv 09/09)
			//Neste caso pelo o Status Atual e saio da fun$$HEX2$$e700e300$$ENDHEX$$o para poder continuar as verifica$$HEX2$$e700f500$$ENDHEX$$es
			This.of_Status_ECF()
			Return True
	End Choose
	
Loop

Return lb_Sucesso
end function

public function boolean of_nr_ecf (ref long pl_ecf);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Caixa
String ls_Cupom

SetPointer(HourGlass!)

ls_Caixa = Space( 5 )

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_NumeroCaixa(Ref ls_Caixa),'Bematech_FI_NumeroCaixa')
	
	pl_ecf = Long(ls_Caixa)
		
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			If pl_ecf = 0 Then  // Em algumas situa$$HEX2$$e700f500$$ENDHEX$$es est$$HEX1$$e100$$ENDHEX$$ ocorrendo erro no envio dos comandos a ECF "NACK", 
									//assim o retorno $$HEX1$$e900$$ENDHEX$$ 1 e o valor fica zero. Por isso foi colocado para tentar novamente
				Continue
			Else
				Return True
			End If
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

public function boolean of_dados_impressora (ref long pl_sequencial, ref long pl_ecf);
If Not of_nr_ecf(Ref pl_ecf) Then Return False

If Not of_nr_cupom(Ref pl_sequencial) Then Return False

Return True
end function

public function string of_centraliza_texto (string ps_texto);String ls_texto

ls_texto = Space(Int(COLUNAS - LenA(Trim(ps_texto)))/2) + Trim(ps_texto)
ls_texto = ls_texto + Space(COLUNAS - LenA(ls_texto))

Return ls_texto

end function

public function boolean of_horaecf (ref string ps_hora);If This.ivb_Modo_Teste Then Return True

String ls_Data
String ls_Hora
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Data = Space( 7 )
ls_Hora = Space( 7 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DataHoraImpressora(Ref ls_Data, Ref ls_Hora),'Bematech_FI_DataHoraImpressora')
	
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

public function boolean of_fecha_comprovante_tef ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_FechaComprovanteNaoFiscalVinculado(),'Bematech_FI_FechaComprovanteNaoFiscalVinculado')
	
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

public function boolean of_gt_inicial_final (ref decimal pdc_inicial, ref decimal pdc_final);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_inicial
String ls_final

SetPointer(HourGlass!)

Try
	Do While ll_Retry <= 3
		
		ls_inicial = Space( 19 )
		ls_final   = Space( 19 )
		
		If not ivb_modelo_CONV0909 Then		
			 ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_InicioFimGTsMFD(Ref ls_Inicial, Ref ls_Final),'Bematech_FI_InicioFimGTsMFD')		
		Else
				ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_InicioFimGTsCV0909(Ref ls_Inicial, Ref ls_Final),'Bematech_FI_InicioFimGTsCV0909')				
		End If
	
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
Catch ( Exception ex )
	gvo_aplicacao.Of_Grava_Log('Falha ao executar a fun$$HEX2$$e700e300$$ENDHEX$$o of_gt_inicial_final() na impressora Bematech.~r'+ex.Text)
	Return False
End Try

Return False
end function

public function boolean of_inicializa_recebimento_nao_fiscal ();If This.ivb_Modo_Teste Then Return True

Long ll_Sequencia,&
     ll_Retorno,&
     ll_Ecf

ivb_showerror = FALSE

Do While ll_Retorno <> 1 

	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_AbreRecebimentoNaoFiscalMFD("","",""),'Bematech_FI_AbreRecebimentoNaoFiscalMFD')
	
	Choose Case ll_Retorno
		Case 1 						// Comando OK
			
			If of_Status_ECF() = -1 Then
				
				If This.St3 = 33 Then
		
					gvo_aplicacao.of_grava_log("Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente, fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_inicializa_recebimento_nao_fiscal().")
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente.",Exclamation!)

					If Not of_cancela_Recebimento_Nao_Fiscal() Then Return False
					
					Return of_Inicializa_recebimento_nao_fiscal()
					
				End If				

				If This.St3 = 31 Or This.St3 = 82 Then
					If Not of_fecha_cupom_nao_fiscal() Then Return False
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

public function boolean of_efetua_recebimento_nao_fiscal (string ps_tipo, string ps_valor);If This.ivb_Modo_Teste Then Return True

Integer li_File
String  ls_msg

Long    ll_Retry
Long    ll_Retorno

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_EfetuaRecebimentoNaoFiscalMFD(ps_tipo,ps_valor),'Bematech_FI_EfetuaRecebimentoNaoFiscalMFD')

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

public function boolean of_totaliza_cupom (string ps_tipo[], decimal pd_valor[]);If This.ivb_Modo_Teste Then Return True

Integer li_File
String  ls_valor,&
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
	
    	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_EfetuaFormaPagamentoIndice(ls_Pagto,ls_valor),'Bematech_FI_EfetuaFormaPagamentoIndice')
	
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

Next

Return True
end function

public function boolean of_recebimento_nao_fiscal (string ps_tipo, string ps_valor);If This.ivb_Modo_Teste Then Return True

Integer li_File
String  ls_msg

Long    ll_Retry
Long    ll_Retorno

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_RecebimentoNaoFiscal(ps_tipo,ps_valor,""),'Bematech_FI_RecebimentoNaoFiscal')

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

public function boolean of_totaliza_recebimento_nao_fiscal (string ps_pagamento, string ps_valor);If This.ivb_Modo_Teste Then Return True

Long    ll_Retry
Long    ll_Retorno

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_SubTotalizaRecebimentoMFD(),'Bematech_FI_SubTotalizaRecebimentoMFD')

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

	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_TotalizaRecebimentoMFD(),'Bematech_FI_TotalizaRecebimentoMFD')

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

	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_EfetuaFormaPagamentoIndice(ps_pagamento,ps_valor),'Bematech_FI_EfetuaFormaPagamentoIndice')

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

public function boolean of_cancela_recebimento_nao_fiscal ();
If This.ivb_Modo_Teste Then Return True

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
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_CancelaRecebimentoNaoFiscalMFD("","",""),'Bematech_FI_CancelaRecebimentoNaoFiscalMFD')
	
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
				gvo_aplicacao.of_grava_log("Erro no estorno de recebimento n$$HEX1$$e300$$ENDHEX$$o fiscal na fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_cancela_recebimento_nao_fiscal().~r~n"+Sqlca.SQLErrText+".")
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

public function boolean of_valor_pago_ultimo_cupom (ref decimal pdc_valor);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Valor

SetPointer(HourGlass!)

ls_Valor = Space( 14 )

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ValorPagoUltimoCupom(Ref ls_Valor),'Bematech_FI_ValorPagoUltimoCupom')
			
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

public function boolean of_modo_impressora_old ();String lvs_INI,&
       lvs_Modo,&
       lvs_Gaveta,&
	   lvs_Timeout,&
	   lvs_Log

lvs_INI = gvo_Aplicacao.ivs_Arquivo_INI

// Verifica se o caminho dos arquivos de ajuda est$$HEX1$$e300$$ENDHEX$$o especificados no INI
lvs_Modo    = ProfileString(lvs_INI, "ECF" , "Modo","")
lvs_Gaveta  = ProfileString(lvs_INI, "ECF" , "Gaveta","")
lvs_Timeout = ProfileString(lvs_INI, "ECF" , "Timeout" , "")
lvs_Log     = ProfileString(lvs_INI, "ECF" , "Log" , "")

If Upper(Trim(lvs_Modo)) = "TESTE" Then 
	This.ivb_modo_teste = True
Else
	This.ivb_modo_teste = False	
End If	

If Upper(Trim(lvs_Gaveta)) = "SIM" Then 
	This.ivb_gaveta = True
Else
	This.ivb_gaveta = False
End If

If IsNumber(lvs_Timeout) Then
	This.Timeout = Long(lvs_Timeout)
Else
	This.Timeout = 10
End If

If Upper(Trim(lvs_Log)) = "SIM" Then 
	This.ivs_Grava_Log = "SIM"
Else
	This.ivs_Grava_Log = "NAO"
End If

Return True
end function

public function boolean of_verifica_status_horario_verao (ref string ps_status);If This.ivb_Modo_Teste Then Return True

If Not This.of_Verifica_Flags_Fiscais() Then Return False

Long ll_Status

//ll_Status = Long(ivs_Status)
ll_Status = ivl_Status

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

public function boolean of_programa_horario_verao ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ProgramaHorarioVerao(),'Bematech_FI_ProgramaHorarioVerao' )
	 	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			
			This.of_Status_Extendido_ECF()			
			
			Return False
			
	End Choose
	
	ll_Retry ++

Loop

Return False


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

If Not This.of_Verifica_Status_Horario_Verao(Ref lvs_Modo_Atual) Then Return False

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
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Aguarde 1 hora antes de clicar no <OK>, para ajustar hor$$HEX1$$e100$$ENDHEX$$rio de ver$$HEX1$$e300$$ENDHEX$$o.",StopSign!)
End If

If IsNull(lvs_Modo) Then Return True

lvb_Retorno = This.Of_Horario_Verao_Ajuste(lvs_Modo)

If lvb_Retorno Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_Msg,Information!)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel ajustar hor$$HEX1$$e100$$ENDHEX$$rio de ver$$HEX1$$e300$$ENDHEX$$o.",StopSign!)
End If	

Return lvb_Retorno */
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

public function boolean of_desconto_item (long pl_item, decimal pdc_desconto, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

String ls_valor

Long ll_Retry
Long ll_Retorno

ls_valor = String(pdc_valor)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_AcrescimoDescontoItemMFD(String(pl_item,'000'),"D","$",ls_valor),'Bematech_FI_AcrescimoDescontoItemMFD')
	 	
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

public function boolean of_leiturax (boolean pb_arquivo);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
DateTime ldt_data

This.of_data_hora_ecf(Ref ldt_Data)

Do While ll_Retry <= 3
	
	If pb_arquivo Then
		
		FileDelete('c:\retorno.txt')

		ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_LeituraXSerial(),'Bematech_FI_LeituraXSerial')
		
	Else	
	   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_LeituraX(),'Bematech_FI_LeituraX')
	End If	
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK						
			If of_Status_ECF() = -1 Then				
				If This.St3 = 33 Then		
					If Not of_cancela_Recebimento_Nao_Fiscal() Then Return False					
					Return of_leiturax(pb_arquivo)
				End If
				
				If This.St3 = 31 Or This.St3 = 82 Then
					If Not of_fecha_cupom_nao_fiscal() Then Return False
					Return of_leiturax(pb_arquivo)
				End If				
			End If	
				
			PDV.of_atualiza_primeira_venda_ecf(This.ECF, ldt_data, True)	
			
			This.of_registra_documento_ecf( 'LX' )	
			
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

public function boolean of_leitura_memoria_fiscal (string ps_data_inicio, string ps_data_final, boolean pb_arquivo, string ps_tipo);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
	If pb_arquivo Then
		ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_LeituraMemoriaFiscalSerialDataMFD(ps_data_inicio,ps_data_final,lower(ps_tipo)),'Bematech_FI_LeituraMemoriaFiscalSerialDataMFD')
	Else	
	   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_LeituraMemoriaFiscalDataMFD(ps_data_inicio,ps_data_final,lower(ps_tipo)),'Bematech_FI_LeituraMemoriaFiscalDataMFD')
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

public function boolean of_marca_modelo_tipo ();If This.ivb_Modo_Teste Then Return True

String ls_Marca
String ls_Modelo
String ls_Tipo

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Marca		= Space( 16 )
ls_Modelo	= Space( 21 )
ls_Tipo 		= Space( 8 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_MarcaModeloTipoImpressoraMFD(Ref ls_Marca,Ref ls_Modelo, Ref ls_Tipo),'Bematech_FI_MarcaModeloTipoImpressoraMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			This.de_Marca 	= Trim(LeftA(ls_Marca + Space(20) , 20))
			This.de_Modelo = Trim(LeftA(ls_Modelo + Space(20) , 20))
			This.de_Tipo 	= Trim(LeftA(ls_Tipo + Space(7) , 7))
			
			If Pos(UPPER(This.de_modelo),'4200') > 0 Then
				This.ivb_modelo_CONV0909 = True
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

public function boolean of_data_hora_usuario_software_basico ();If This.ivb_Modo_Teste Then Return True

String ls_DataUsuario
String ls_DataSWBasico
String ls_MFAdicional

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_dataUsuario		= Space( 21 )
ls_dataSWBasico	= Space( 21 )
ls_MFAdicional		= Space( 2 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF( Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional( Ref ls_DataUsuario, Ref ls_DataSWBasico, Ref ls_MFAdicional ),'Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional' )
	
	Choose Case ll_Retorno
		Case 1 // Comando OK
			
			If Trim(ls_MFAdicional) = '' Then 
				ls_MFAdicional = 'N'
			Else
				ls_MFAdicional = 'S'	
			End If	
				
			This.id_MFAdicional	= ls_MFAdicional
			This.dh_SWBasico		= DateTime( Date( LeftA( ls_DataSWBasico, 10 ) ), Time( RightA( ls_DataSWBasico, 08 ) ) )		
		
			Update impressora_fiscal
			Set id_mfadicional = :This.id_MFAdicional,
			    dh_swbasico    = :This.dh_SWBasico
			Where nr_ecf = :This.Ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF.~n~n Erro: " + Sqlca.SqlErrText)
				gvo_aplicacao.of_grava_log("Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_data_hora_usuario_software_basico().~r~n"+&
								Sqlca.SQLErrText+".")
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

public function boolean of_verifica_versao_software_basico ();If This.ivb_Modo_Teste Then Return True

String ls_Versao
String ls_cniie

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Versao = Space( 7 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF( Bematech_FI_VersaoFirmwareMFD( Ref ls_Versao ), 'Bematech_FI_VersaoFirmwareMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			This.nr_Versao_SWBasico = LeftA(ls_Versao + Space(10),10)					
			
			Choose Case Trim(This.nr_Versao_SWBasico)
				Case '010001'
					If Trim(Upper(This.de_modelo)) = 'MP-4000 TH FI' Then	ls_cniie = '032101'
				Case '010002'
					If Trim(Upper(This.de_modelo)) = 'MP-4000 TH FI' Then	ls_cniie = '032102'
					If Trim(Upper(This.de_modelo)) = 'MP-4200 TH FI I' Then	ls_cniie = '032303'
				Case '010003'
					If Trim(Upper(This.de_modelo)) = 'MP-4200 TH FI I' Then	ls_cniie = '032304'
				Case '019901'
					If Trim(Upper(This.de_modelo)) = 'MP-4200 TH FI I' Then	ls_cniie = '032306'			
			End Choose			
			
			Update impressora_fiscal
			Set nr_versao_swbasico = :This.nr_Versao_SWBasico,
				 cd_identificacao_nacional = :ls_cniie
			Where nr_ecf = :This.Ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				gvo_aplicacao.of_grava_log("Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_verifica_versao_software_basico()."+SQLCA.SQLErrText)
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF.~n~n Erro: " + Sqlca.SqlErrText)
				Sqlca.of_RollBack()
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

public function boolean of_percentual_livre_mfd ();If This.ivb_Modo_Teste Then Return True

String ls_MemoriaLivre

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_MemoriaLivre = Space( 7 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_PercentualLivreMFD(Ref ls_MemoriaLivre),'Bematech_FI_PercentualLivreMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
					
			This.pc_Livre_MFD = Dec(MidA(ls_MemoriaLivre,1,LenA(ls_MemoriaLivre) -1))
			
			Update impressora_fiscal
			Set pc_livre_mfd = :This.pc_Livre_MFD
			Where nr_ecf = :This.Ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				gvo_aplicacao.of_grava_log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do percentual de mem$$HEX1$$f300$$ENDHEX$$ria livre "+SQLCa.SQLErrText)
				Sqlca.of_MsgDbError('Atualiza$$HEX2$$e700e300$$ENDHEX$$o do percentual de mem$$HEX1$$f300$$ENDHEX$$ria livre')
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

public function boolean of_carrega_dados_ecf (long pl_ecf);
Select nr_serie,   
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
	gvo_aplicacao.of_grava_log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o de par$$HEX1$$e200$$ENDHEX$$metros da ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_carrega_dados_ecf().~r~n"+&
									Sqlca.SQLErrText+".")
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o de par$$HEX1$$e200$$ENDHEX$$metros da ECF.')
	Return False
End If

Return True
end function

public function string of_formata_valor_pafecf (decimal pdc_valor, long pl_inteiro, long pl_decimal);
String 	ls_Valor

If IsNull(pdc_Valor) Then pdc_Valor = 000.00

ls_Valor = FillA('0', pl_inteiro + pl_decimal) + MidA( String(pdc_valor) , 1, LenA(String(pdc_valor)) -3 ) + RightA(String(pdc_valor),2)

ls_Valor = RightA( ls_Valor, pl_inteiro + pl_decimal )

Return ls_Valor
end function

public function boolean of_contador_credito_debito (ref long pl_contador);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Contador

ls_Contador = Space( 10 )

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF( Bematech_FI_ContadorComprovantesCreditoMFD( Ref ls_Contador ), 'Bematech_FI_ContadorComprovantesCreditoMFD' )
	
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

public function boolean of_contador_relatorio_gerencial (ref long pl_contador);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry

Long ll_Retorno

String ls_Contador

ls_Contador = Space( 10 )

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF( Bematech_FI_ContadorRelatoriosGerenciaisMFD( Ref ls_Contador ), 'Bematech_FI_ContadorRelatoriosGerenciaisMFD' )
	
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

public function boolean of_contador_operacao_nao_fiscal (ref long pl_contador);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Contador

ls_Contador = Space( 10 )

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_NumeroOperacoesNaoFiscais(Ref ls_Contador), 'Bematech_FI_NumeroOperacoesNaoFiscais')
	
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

public function boolean of_renomeia_arquivo (string ps_antigo, string ps_novo, boolean pb_replace);Boolean lb_Retorno = False

Long ll_Retorno = 0

If pb_replace Then
	
	If FileExists(ps_novo) Then
	
		lb_Retorno = FileDelete( ps_novo )
		
		If Not lb_Retorno Then Return False
		
	End If	

End If

ll_Retorno = FileMove(ps_antigo,ps_novo)

IF ll_Retorno <> 1 THEN
	lb_Retorno = False
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao renomear arquivo : " + ps_antigo + " para " + ps_novo , StopSign!) 
	gvo_aplicacao.of_grava_log("Erro ao renomear arquivo : " + ps_antigo + " para " + ps_novo+".")
END IF	

Return lb_Retorno
end function

public function boolean of_registra_documento_ecf (string ps_documento, decimal pdc_valor);
String ls_Nulo

SetNull(ls_Nulo)

Return of_Registra_Documento_ecf(ps_documento,ls_Nulo,pdc_valor)
end function

public function boolean of_suprimento_caixa (decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
DateTime ldt_data

This.of_data_hora_ecf(Ref ldt_Data)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_Suprimento(String(pdc_valor,"###,###,##0.00"),"Dinheiro"), 'Bematech_FI_Suprimento')
	
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
DateTime ldt_data

This.of_data_hora_ecf(ldt_Data)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_Sangria(String(pdc_valor,"###,###,##0.00")), 'Bematech_FI_Sangria')
	
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

public function boolean of_leitura_memoria_fiscal_reducao (long pl_reducao_inicial, long pl_reducao_final, boolean pb_arquivo, string ps_tipo);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
	If pb_arquivo Then
		ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_LeituraMemoriaFiscalSerialReducaoMFD(String(pl_reducao_inicial,'0000'),String(pl_reducao_final,'0000'),ps_tipo), 'Bematech_FI_LeituraMemoriaFiscalSerialReducaoMFD')
	Else	
	   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_LeituraMemoriaFiscalReducaoMFD(String(pl_reducao_inicial,'0000'),String(pl_reducao_final,'0000'),ps_tipo), 'Bematech_FI_LeituraMemoriaFiscalReducaoMFD')
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

public function boolean of_flags_st1 ();
If This.St1 = 0 Then Return True

Long   ll_st1 

String ls_Msg

ll_st1 = This.St1

If ll_St1 >= 128 Then                 // bit 7
	ll_St1 = ll_St1 - 128
	gvo_aplicacao.of_grava_log('Falta de papel.')
	If of_pergunta_falta_papel() Then 
		Return of_verifica_problemas_impressora()
	Else
		Return False
	End If
End If 

If ll_St1 >= 64 Then                  // bit 6 
	ll_St1 = ll_St1 - 64 
	gvo_aplicacao.of_grava_log('Pouco papel.')
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

gvo_aplicacao.of_grava_log(ls_Msg)
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg,StopSign!)

Return False
end function

public function boolean of_flags_st2 ();
If This.St2 = 0 Then Return True

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

public function string of_meio_pagamento (string ps_pagamento);String ls_FormasPagto[]
String ls_CPD
Boolean lb_CPD

ls_CPD = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF", "CPD","")

If Trim(UPPER(ls_CPD)) = 'SIM' Then		lb_CPD = True

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

public function boolean of_verifica_forma_pagamento (ref string ps_formapagto[]);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Pos
Long ll_Ind

String ls_FormasPagto
String ls_Forma

ls_FormasPagto = Space( 3017 )

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_VerificaFormasPagamento(Ref ls_FormasPagto), 'Bematech_FI_VerificaFormasPagamento')
	
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

public function boolean of_assinatura_digital (string ps_arquivo);Long 	  ll_Retorno

String ls_Registro 
String ls_Msg

String ls_ChavePublica
String ls_ChavePrivada
String ls_ead

ls_ChavePublica = "9716BE0910DB085542B39EE19383F3EB45A32D8962D57FFC6DAF0F04B872F52EF36F144131F6923B1A9EA73F13527A9CFD5A26F688505FC63ED9F95D240BF9D3A9655E26AE6AB706A1633693FCB3048A750E4B15EAE98F64EF6E941A78422E7ECB1D126C268DF5FA8E228A2CDD5206CE50B4D15D14B99906604C73E6DF807939"
ls_ChavePrivada = "C59A1793009F74E975542E2841C840B34D8C45143D5B761DE1FADFE447289D4308452A882AED183FB5781A1C23AED97726023C3710161C68ABA7275AE9826119C3BD9FC24E4C6DE977B674EDA0CE56F4E1F3884F51230A10CAF8362FE4C758A1DD0F9F50F0810F8507E8419884BAA981771B5EACE835E94EB62CDE4DAFE73D21"

ls_ead = Space(256)

ll_Retorno = generateEAD(ps_arquivo, ls_ChavePublica ,ls_ChavePrivada , Ref ls_ead , 1 )

If ll_Retorno = -1 Then
	ls_Msg = "Erro ao assinar digitalmente o arquivo " + ps_arquivo+"."
	gvo_aplicacao.of_grava_log(ls_Msg)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg, StopSign!)
	Return False
Else
	Return True
End If


end function

public function boolean of_verifica_cupons_pendentes ();If Not This.of_Verifica_Flags_Fiscais() Then Return False

// Verifica se existem cupons fiscais pendentes 
//If Mod(Long(This.ivs_Status),2) = 1 Then
If This.ivl_Status = 1 or This.ivl_Status = 33 or This.ivl_Status = 35 or This.ivl_Status = 37 or This.ivl_Status = 39 Then
	
	If Not PDV.ivb_Aviso_cupom_aberto Then
		Of_msg_Cupom_Aberto()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","                               CUPOM FISCAL N$$HEX1$$c300$$ENDHEX$$O ENCERRADO~r~r" + &
										"O $$HEX1$$da00$$ENDHEX$$ltimo cupom fiscal impresso n$$HEX1$$e300$$ENDHEX$$o foi finalizado!.~r" + &
										"Utilize o Sitema de Caixa para encerrar ou fazer o cancelamento.",Exclamation!)
		Return False
	End If
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("CANCELAMENTO_CUPOM_FISCAL", PDV.ivs_Matricula_Cancelamento_Venda) Then Return False

	If Not PDV.of_cancela_ultimo_cupom(False) Then Return False

	Return True
	
End If	

//of_fecha_cupom_nao_fiscal()
		
Return True
end function

public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Origem  = 'C:\Sistemas\CL\Arquivos\PAF-ECF\download.mfd'
String ls_Destino = 'C:\Sistemas\CL\Arquivos\PAF-ECF\leitura-memoria-fita-detalhe.txt'

FileDelete(ls_Origem)
FileDelete(ls_Destino)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DownloadMFD(ls_Origem,ps_Tipo,ps_inicio,ps_final,'1'),'Bematech_FI_DownloadMFD')

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
	
		ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_FormatoDadosMFD(ls_Origem,ls_Destino,'0',ps_Tipo,ps_inicio,ps_final,'1'), 'Bematech_FI_FormatoDadosMFD')
		
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
		gvo_aplicacao.of_grava_log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da data de movimenta$$HEX2$$e700e300$$ENDHEX$$o nos par$$HEX1$$e200$$ENDHEX$$metros, fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_dh_movimentacao().~r~n"+&
						Sqlca.SQLErrText+".")
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da data de movimenta$$HEX2$$e700e300$$ENDHEX$$o nos par$$HEX1$$e200$$ENDHEX$$metros." + SqlCa.SqlErrText, StopSign!)
		Return ldh_Nulo
End Choose
end function

public function boolean of_verifica_versao_dll ();If This.ivb_Modo_Teste Then Return True

String ls_Versao

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Versao = Space( 10 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_VersaoDll(Ref ls_Versao), 'Bematech_FI_VersaoDll')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
	
			If Long(LeftA(ls_Versao,1)) < 5 Then
				//If ls_Versao <> "5,10,4,7" And ls_Versao <> "5,10,6,5" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Vers$$HEX1$$e300$$ENDHEX$$o da dll (" + ls_Versao + ") Bematech incompat$$HEX1$$ed00$$ENDHEX$$vel. Favor contactar suporte.")
				gvo_aplicacao.of_grava_log("Vers$$HEX1$$e300$$ENDHEX$$o da dll (" + ls_Versao + ") Bematech incompat$$HEX1$$ed00$$ENDHEX$$vel.")
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

public function boolean of_venda_bruta (ref decimal pdc_venda);If This.ivb_Modo_Teste Then Return True

String ls_Valor
Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Valor = Space( 19 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_VendaBruta(Ref ls_Valor), 'Bematech_FI_VendaBruta')
	
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

public function boolean of_grande_total (ref decimal pdc_venda);If This.ivb_Modo_Teste Then Return True

String ls_Valor
Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Valor = Space( 19 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_GrandeTotal(Ref ls_Valor), 'Bematech_FI_GrandeTotal')
	
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

public function boolean of_data_ultima_reducaoz (ref date pd_datafiscal);If This.ivb_Modo_Teste Then Return True

String ls_DataMovimento
String ls_Hora
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_DataMovimento = Space( 7 )
ls_Hora				= Space( 7 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DataHoraReducao(Ref ls_DataMovimento, Ref ls_Hora), 'Bematech_FI_DataHoraReducao')
	
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

public function boolean of_data_ultimo_documento_fiscal (ref datetime pd_datahora);If This.ivb_Modo_Teste Then 
	pd_datahora = gf_getserverdate()			
	Return True
End If

String ls_Hora
String ls_DataMovimento
String ls_Data
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Data = Space( 13 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DataHoraUltimoDocumentoMFD(Ref ls_Data), 'Bematech_FI_DataHoraUltimoDocumentoMFD')
	
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

public function boolean of_mapa_resumo (ref s_ge039_mapa_resumo ps_mapa_resumo);
If This.ivb_Modo_Teste Then Return True

Long    ll_Retry
Long    ll_Retorno
Long    ll_Totalizador
Long    ll_Posicao
Long	  ll_contador_aliquota = 335
Long 	  ll_linha

String  ls_Dados		= Space( 632 )
String  ls_DadosMFD = Space( 1279 )
String  ls_DadosAliquotas = Space(80)
String  ls_DadosCV0909 = Space(879)
String  ls_Aliquota

Decimal{2} ldc_gt_inicial
Decimal{2} ldc_gt_final
Decimal{2} ldc_vl_aliquota

Boolean lb_Sucesso = False

If Not of_GT_inicial_final( Ref ldc_gt_inicial, Ref ldc_gt_final ) Then Return False
 
Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF( Bematech_FI_DadosUltimaReducaoMFD( Ref ls_DadosMFD ), 'Bematech_FI_DadosUltimaReducaoMFD' )
	
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

If Not lb_Sucesso Then Return False

ll_Retry = 0

lb_Sucesso = False

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF( Bematech_FI_DadosUltimaReducao( Ref ls_Dados ), 'Bematech_FI_DadosUltimaReducao' )
	
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

If ivb_modelo_CONV0909 Then		
	ll_Retry = 0
	lb_Sucesso = False
	Do While ll_Retry <= 3 and Not lb_Sucesso
		
		 ll_Retorno = This.of_Verifica_Retorno_ECF( Bematech_FI_DadosUltimaReducaoCV0909( Ref ls_DadosCV0909 ), 'Bematech_FI_DadosUltimaReducaoCV0909' )
		
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
End If


ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_RetornoAliquotas( Ref ls_DadosAliquotas ), 'Bematech_FI_RetornoAliquotas' )
	
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
		gvo_aplicacao.of_grava_log("Erro na Leitura do N$$HEX1$$fa00$$ENDHEX$$mero da ECF.")
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Leitura do N$$HEX1$$fa00$$ENDHEX$$mero da ECF.")
		Return False
	End If
End If

ps_mapa_resumo.ecf           				= This.ECF

ps_mapa_resumo.isento        				= DEC(MidA(ls_DadosMFD,560,14))/100
ps_mapa_resumo.vl_nao_incidencia		= DEC(MidA(ls_DadosMFD,575,14))/100
ps_mapa_resumo.vlst          				= DEC(MidA(ls_DadosMFD,590,14))/100

ps_mapa_resumo.qt_cupom_cancelado 	= LONG(MidA(ls_DadosMFD,54,04))
ps_mapa_resumo.qt_reinicio_z 		 	= LONG(MidA(ls_DadosMFD,04,04))
ps_mapa_resumo.reducoes           		= LONG(MidA(ls_DadosMFD,09,04))
ps_mapa_resumo.operacao           		= LONG(MidA(ls_DadosMFD,14,06))

//Feito para casos que a 4200 retorna zero na informa$$HEX2$$e700e300$$ENDHEX$$o do contador de COO
If ps_mapa_resumo.operacao = 0 and ivb_modelo_CONV0909 Then
	ps_mapa_resumo.operacao = Long(Trim(gf_captura_valor(ls_DadosCV0909, ',', 6, false)))
End If

//TESTE, NAS MP4200 COM FIRMWARE ANTIGA O RETORNO ESTAVA ERRADO
//ps_mapa_resumo.grande_total  			= DEC(MidA(ls_DadosMFD,316,18))/100
ps_mapa_resumo.grande_total  			= DEC(MidA(ls_Dados,4,18))/100
If ivb_modelo_CONV0909 Then		
	ps_mapa_resumo.grande_total	 = ldc_gt_final
End If	
	
Do While Trim(ls_DadosAliquotas) > ''
	ll_linha += 1
	ls_Aliquota = Trim(MidA(ls_DadosAliquotas, 1, PosA(ls_DadosAliquotas,',') - 1))
	If Trim(ls_Aliquota) = '' Then // ultima posi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o tem a virgula
		ls_Aliquota = Trim(ls_DadosAliquotas)
		ls_DadosAliquotas = ''
	Else
		If Long(ls_Aliquota) = 0 Then //Neste caso j$$HEX1$$e100$$ENDHEX$$ passou da ultima aliquota v$$HEX1$$e100$$ENDHEX$$lida cadastrada
			ls_DadosAliquotas = ''
			Continue
		End If
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

ps_mapa_resumo.vl_isento_iss 			= DEC(MidA(ls_DadosMFD,605,14))/100
ps_mapa_resumo.vl_nao_incidencia_iss	= DEC(MidA(ls_DadosMFD,620,14))/100
ps_mapa_resumo.vl_st_iss 					= DEC(MidA(ls_DadosMFD,635,14))/100
ps_mapa_resumo.descontos     			= DEC(MidA(ls_DadosMFD,650,14))/100
ps_mapa_resumo.vl_desconto_iss			= DEC(MidA(ls_DadosMFD,665,14))/100
ps_mapa_resumo.vl_acrescimo			= DEC(MidA(ls_DadosMFD,680,14))/100
ps_mapa_resumo.vl_acrescimo_iss		= DEC(MidA(ls_DadosMFD,695,14))/100
ps_mapa_resumo.cancelamentos 			= DEC(MidA(ls_DadosMFD,710,14))/100
ps_mapa_resumo.vl_cancelamento_iss	= DEC(MidA(ls_DadosMFD,725,14))/100

If ldc_gt_final > 0 And ldc_gt_inicial = 0 Then	
	If (ps_mapa_resumo.cancelamentos + ps_mapa_resumo.descontos) = 0 Then
		Long lvl_Notas
		Date lvdt_Data
		
		lvdt_Data = Date(MidA(ls_DadosMFD,1273,2) + "/" + MidA(ls_DadosMFD,1275,2) + "/" + MidA(ls_DadosMFD,1277,2))
		
		Select Count(1)
		  Into :lvl_Notas
		  From nf_venda
		 Where nr_ecf = :This.ECF
		   and dh_movimentacao_caixa = :lvdt_Data
		 Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			gvo_aplicacao.of_grava_log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas do dia '" + String(lvdt_Data,"DD/MM/YYYY") + "' na ECF '" + String(This.ECF) + "'.")
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

public function boolean of_verifica_data_movimentacao ();
Date   ldt_datafiscal
Date   ldt_dataecf
Date   ldt_dataReducaoZ
Date   ldt_movimento

String ls_DataMovimento

ldt_movimento = Date(This.of_dh_movimentacao())

If Not of_DataFiscal(Ref ldt_DataFiscal) 			     Then Return False

If ldt_datafiscal = Date('1900/01/01') Then
	If PDV.of_Suprimento_Caixa(0.01) Then
		Return This.of_Verifica_Data_Movimentacao()	
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Impressora Fiscal Bloqueada. Redu$$HEX2$$e700e300$$ENDHEX$$o Z j$$HEX1$$e100$$ENDHEX$$ efetuada.",StopSign!)
		Return False
	End If
End If

If Not of_DataEcf(Ref ldt_dataecf)       			     Then Return False

If Not of_Data_Ultima_ReducaoZ(Ref ldt_dataReducaoZ) Then Return False

If ldt_movimento = ldt_dataecf and ldt_movimento = ldt_DataFiscal Then Return True

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

public function boolean of_verifica_ultimo_mapa_resumo ();
If This.ivb_ReducaoZ Then Return True

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

select max(dh_movimentacao_caixa)
Into :ldt_Venda
from nf_venda
where cd_filial 					= :ll_filial
  and dh_movimentacao_caixa	< :ldt_Movimento
  and dh_movimentacao_caixa	>=:ldt_Movimento_Relativo
  and nr_ecf 						= :ll_ecf
  and de_especie = 'CF'
  and de_serie = 'ECF'  
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	gvo_aplicacao.of_grava_log("Erro ao verificar $$HEX1$$fa00$$ENDHEX$$ltima data de movimenta$$HEX2$$e700e300$$ENDHEX$$o, fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_verifica_ultimo_mapa_resumo()."+SQLCA.SQLErrText)
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
	gvo_aplicacao.of_grava_log("Erro ao verificar $$HEX1$$fa00$$ENDHEX$$ltimo mapa resumo registrado, fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_verifica_ultimo_mapa_resumo()."+SQLCA.SQLErrText)
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

public function boolean of_atualiza_drivers ();
Boolean	lb_Sucesso 		= True
Boolean	lb_Existe 		= False

String   ls_Path_System
String   ls_Path
String   ls_Error
String	   ls_path_dll = 'c:\sistemas\dll\bematech'
String   ls_Validar[]
String   ls_Baixar[]

String 	ls_Versao
String	ls_Valor

Long 		ll_File

ls_Validar = {"bemafi32.dll", "msjet35.dll", "dao350.dll", "bemamfd.dll", "bemamfd2.dll", "ax6r32.dll", "sign_bema.dll"}
ls_Baixar  = {'bematech.zip'}

If gvo_Aplicacao.of_is64bits() Then
	ls_Path_System = 'C:\Windows\SysWOW64'
Else
	ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
End If	

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
	gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi encontrado o par$$HEX1$$e200$$ENDHEX$$metro 'DE_SERVIDOR_DOWNLOAD_VERSAO_MATRIZ' na tabela par$$HEX1$$e200$$ENDHEX$$metro_loja.")
	lb_Sucesso = False
	
Case 0
	lb_Sucesso = True
End Choose	

If (Not FileExists(ls_Path_System + '\AZIP32.DLL')  or Not FileExists(ls_Path_System + '\aunzip32.dll'))  And lb_Sucesso Then
	Open(w_Aguarde_1)				
	
	If lo_Ftp.of_Conecta_Ftp("Verifica Versao", ls_Valor, "pdv2", "pdv2") Then			
		lo_Ftp.of_Ftp_Set_Dir('dll')

		lb_Sucesso = False
		
		If Not FileExists(ls_Path_System + '\AZIP32.DLL') Then			
			w_Aguarde_1.Title = "Atualizando driver ... " + "azip32.dll"	
		
			If lo_Ftp.of_Ftp_GetFile('AZIP32.DLL', ls_Path_System + '\AZIP32.DLL') Then
				lb_Sucesso = True				
			End If
		End If
		
		If Not FileExists(ls_Path_System + '\aunzip32.dll') And lb_Sucesso Then
			
			lb_Sucesso = False
			
			w_Aguarde_1.Title = "Atualizando driver ... " + "aunzip32.dll"
		
			If lo_Ftp.of_Ftp_GetFile('aunzip32.dll', ls_Path_System + '\aunzip32.dll') Then
				lb_Sucesso = True
			End If
		End If
	End If	
End If

dc_uo_api lo_api
lo_api = Create dc_uo_api

If FileExists(ls_Path_System + '\bemafi32.dll')  And lb_Sucesso Then
	
	If Not FileExists(ls_Path_dll) Then
		lo_Api.of_Create_Directory(ls_Path_dll)
	End If
	
	//Move para diretorio das dlls	
	If Not lo_api.of_move_file(ls_Path_System + '\bemafi32.dll', ls_Path_dll + '\bemafi32.dll', true, true) Then lb_Sucesso = False
	If Not lo_api.of_move_file(ls_Path_System + '\bemafi32.ini', ls_Path_dll + '\bemafi32.ini', true, true) Then lb_Sucesso = False	
	If Not lo_api.of_move_file(ls_Path_System + '\msjet35.dll', ls_Path_dll + '\msjet35.dll', true, true) Then lb_Sucesso = False	
	If Not lo_api.of_move_file(ls_Path_System + '\dao350.dll', ls_Path_dll + '\dao350.dll', true, true) Then lb_Sucesso = False		
	If Not lo_api.of_move_file(ls_Path_System + '\bemamfd.dll', ls_Path_dll + '\bemamfd.dll', true, true) Then lb_Sucesso = False
	If Not lo_api.of_move_file(ls_Path_System + '\bemamfd2.dll', ls_Path_dll + '\bemamfd2.dll', true, true) Then lb_Sucesso = False				
	If Not lo_api.of_move_file(ls_Path_System + '\ax6r32.dll', ls_Path_dll + '\ax6r32.dll', true, true) Then lb_Sucesso = False
	If FileExists(ls_Path_System + '\sign_bema.dll')  Then //Esta dll j$$HEX1$$e100$$ENDHEX$$ pode ter sido movida no constuctor do objeto.
		If Not lo_api.of_move_file(ls_Path_System + '\sign_bema.dll', ls_Path_dll + '\sign_bema.dll', true, true) Then lb_Sucesso = False	
	End If
	
End If

If Not FileExists(ls_Path_dll + '\bemafi32.dll')  And lb_Sucesso Then

	lb_Sucesso = gf_Download_Matriz(ls_Validar, ls_Baixar, ls_Path_dll, "dll_bematech", True)	

End If

// ***Retirado, em venda de manipulado se o arquivo n$$HEX1$$e300$$ENDHEX$$o estiver na pasta do sistema operacional ocorre erro.***
// ***Aguardando retorno da Bematech sobre o assunto***
//If FileExists(ls_Path_System + '\manutencao.xml')  And lb_Sucesso Then
//	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\manutencao.xml')
//	If Not lo_api.of_move_file(ls_Path_System + '\manutencao.xml', gvo_Aplicacao.ivs_Path_Sistema + '\manutencao.xml', true, true) Then lb_Sucesso = False		
//Else
//	If Not FileExists(gvo_Aplicacao.ivs_Path_Sistema + '\manutencao.xml')  And lb_Sucesso Then
//		ll_file = FileOpen(gvo_Aplicacao.ivs_Path_Sistema + '\manutencao.xml',LineMode!, Write!, Shared!, Replace! )					
//		
//		If ll_file > 0 Then
//			FileClose(ll_file)
//		End If			
//	End If	
//End If

//***Remocao do arquivo no diretorio do sistema, se este existir.
If FileExists(gvo_Aplicacao.ivs_Path_Sistema + '\manutencao.xml') Then
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\manutencao.xml')
End If

Destroy(lo_api)

If IsValid(lo_Ftp) Then Destroy lo_Ftp

If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)

Return lb_Sucesso
end function

public function boolean of_atualiza_numero_seriemfd ();Boolean lvb_Sucesso = False
DateTime ldh_Ultima_Venda

Select max(dh_emissao) Into :ldh_Ultima_Venda
From nf_venda
Where nr_ecf = :This.Ecf 
  and	dh_movimentacao_caixa >= cast( getdate() as date ) -2
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	gvo_aplicacao.of_grava_log('Data Ultima Venda ECF no sistema.~r~n'+Sqlca.SQLErrText)
	Sqlca.of_MsgDbError('Data Ultima Venda ECF no sistema.')
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
	gvo_aplicacao.of_grava_log("Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF.~n~n Erro: " + Sqlca.SqlErrText)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF.~n~n Erro: " + Sqlca.SqlErrText)
	Sqlca.of_RollBack()
Else			
	Sqlca.of_Commit()
	lvb_Sucesso = True
End If	

Return lvb_Sucesso
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
	
	If This.ivl_Status = 8 or This.ivl_Status = 12 or This.ivl_Status = 40 Then		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Impressora Fiscal Bloqueada. Redu$$HEX2$$e700e300$$ENDHEX$$o Z j$$HEX1$$e100$$ENDHEX$$ efetuada.",StopSign!)
		Return False
	End If	
	
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
	
//	If ivs_Status = "008" Then
	If ivl_Status = 8 or ivl_Status = 12 Then		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Impressora Fiscal Bloqueada. Redu$$HEX2$$e700e300$$ENDHEX$$o Z j$$HEX1$$e100$$ENDHEX$$ efetuada.",StopSign!)

	End If
	
	Exit
	
Loop

Return True
end function

public function boolean of_verifica_flags_fiscais ();
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
//	ivs_Status = ''
	ivl_Status = 0
	
//    ll_Retorno = of_Verifica_Retorno_ECF(Bematech_FI_FlagsFiscaisStr(Ref ivs_Status))
    ll_Retorno = of_Verifica_Retorno_ECF(Bematech_FI_FlagsFiscais(Ref ivl_Status), 'Bematech_FI_FlagsFiscais')
	
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

public function boolean of_abreporta ();String ls_dir = 'C:\sistemas\dll\bematech'
//Long ll_ret
//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" Then
//	ll_ret = gf_process_is_running('cl')
//	If ll_ret > 0 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O Sistema de Caixa est$$HEX1$$e100$$ENDHEX$$ aberto, encerre o programa e tente novamente.", Information!)		
//		Return False
//	End If
//End If

If This.ivb_modo_teste or This.ivb_Porta_Aberta 	Then Return True

If Not This.of_Conecta_Impressora()     				Then Return False

If Not This.of_Impressora_online() 						Then Return False

This.of_Configuracoes()

If Not This.of_Marca_Modelo_Tipo()						Then Return False

If Not This.of_Numero_Serie()           				Then Return False

If Not This.ivb_modelo_CONV0909 Then
	//SetProfileString(gvo_Aplicacao.ivs_Path_Sistema + '\BemaFI32.ini',"Sistema", "ProtocoloUnico", "0")			
	//SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "ProtocoloUnico", "0")
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "Tentativas", "10")		
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "WakMilisegundos", "40")
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "TimeoutSegundos", "20")
Else
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "Tentativas", "40")		
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "WakMilisegundos", "40")
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "TimeoutSegundos", "180")	
End If

Return True
end function

public function boolean of_registra_item_vendido (string ps_produto, long pd_qtd, decimal pd_precounit, decimal pd_pretotot, string ps_descricao, decimal pd_aliquota, string ps_complemento, string ps_tributacao_icms, string ps_un);If This.ivb_Modo_Teste Then Return True

String	lvs_qtd,&
      	lvs_precounit,&
	   	lvs_precotot,&
	   	lvs_comando,&
	   	lvs_desconto,&
	   	lvs_trib

Long 		ll_Retry
Long 		ll_Retorno

lvs_trib = This.of_Indicador_Aliquota(pd_Aliquota,ps_tributacao_icms)

//ps_descricao = LeftA(Trim(ps_descricao),24)

lvs_qtd  		= String(pd_qtd,"####0.000")
//lvs_precounit	= String(pd_precounit,"####0.000") -- alterado para duas casas defido a incompatibilidade da dll Bematech, essa fun$$HEX2$$e700e300$$ENDHEX$$o nos modelos conv$$HEX1$$ea00$$ENDHEX$$nio 09/09 ocorria problema em venda de itens com valor acima de 10mil.
lvs_precounit	= String(pd_precounit,"####0.00")
lvs_precotot	= String(pd_pretotot)
lvs_desconto  	= String(pd_pretotot - (pd_precounit*pd_qtd))

Do While ll_Retry <= 3
	
// ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_VendeItem(ps_produto,ps_descricao,lvs_trib,"I",lvs_qtd, 2,lvs_precounit, "$",lvs_desconto) )

	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_VendeItemDepartamento(ps_produto,ps_descricao,lvs_trib,lvs_precounit,lvs_qtd,"0",lvs_desconto,"01",ps_un) , 'Bematech_FI_VendeItemDepartamento')
		
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

public function boolean of_nr_cupom (ref long pl_sequencial);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Caixa
String ls_Cupom

SetPointer(HourGlass!)

ls_Cupom = Space( 10 )

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_NumeroCupom(Ref ls_Cupom), 'Bematech_FI_NumeroCupom')
	
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

public function boolean of_inicializa_comprovante_tef_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

String	ls_Pagamento
String	ls_Forma_Pagamento 

Choose Case ps_pagamento
	Case "01" ; ls_Forma_Pagamento = "DINHEIRO       "
	Case "02" ; ls_Forma_Pagamento = "CHEQUE			 "	
	Case "03" ; ls_Forma_Pagamento = "CHEQUE-PRE     "
	Case "04" ; ls_Forma_Pagamento = "CARTAO CREDITO "
	Case "05" ; ls_Forma_Pagamento = "CARTAO DEBITO  "
	Case "06" ; ls_Forma_Pagamento = "CONVENIO       " 
	Case "07" ; ls_Forma_Pagamento = "CREDIARIO      "
	Case "08" ; ls_Forma_Pagamento = "CONTA CORRENTE "		
	Case "09" ; ls_Forma_Pagamento = "CLUBE          "
	Case "10" ; ls_Forma_Pagamento = "PBM            "		
	Case "11" ; ls_Forma_Pagamento = "RECARGA        "	
End Choose

//Retorna descri$$HEX2$$e700e300$$ENDHEX$$o do meio de pagamento
ls_Pagamento = of_meio_pagamento(ps_pagamento)

If Not of_inicializa_recebimento_nao_fiscal() Then Return False

If Not of_efetua_recebimento_nao_fiscal(ps_recebimento,String(pdc_valor)) Then Return False

If Not of_Registra_documento_ecf('CN',ls_Forma_Pagamento,pdc_valor) Then Return False

If Not of_totaliza_recebimento_nao_fiscal(ps_pagamento,String(pdc_valor)) Then Return False

If Not of_fecha_recebimento_nao_fiscal(String(pdc_valor)) Then Return False

If Not of_inicializa_comprovante_tef(ps_pagamento,ps_descricao,ps_pagamento,pdc_valor, '') Then Return False

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

ls_Ecf = Space( 5 )
 
If of_verifica_retorno_ecf(Bematech_FI_NumeroCaixa( Ref ls_ECF ), 'Bematech_FI_NumeroCaixa') <> 1 Then Return False

This.ECF = Long(ls_ECF)

ls_SerieCompleto = Space( 21 )

If of_verifica_retorno_ecf(Bematech_FI_NumeroSerieMFD( Ref ls_SerieCompleto ), 'Bematech_FI_NumeroSerieMFD') <> 1 Then Return False

This.nr_Serie = ls_SerieCompleto

ls_Serie = ProfileString (ls_File, "ECF", "Serie","")

ls_Serie = of_Desencripta(ls_Serie)

Return True
end function

public function boolean of_reducaoz ();If This.ivb_Modo_Teste Then Return True

Date    	ldt_DataFiscal
Date    	ldt_ReducaoZ
Date		ldt_DataAtual
DateTime ldt_ultima_venda
DateTime ldt_data_hora_ecf

String  	ls_data
String  	ls_hora
String     ls_data_ecf
String		ls_hora_ecf
String		ls_data_h_atual
String		ls_data_h_ecf
String 	ls_Arquivo
String		ls_Endereco
String		ls_Periodo
String		ls_Extensao
String  	ls_Arquivos[]

Long    	ll_Retry
Long    	ll_Retorno
Long		ll_Contador
Long 		ll_Total
Long		ll_dif
Long		ll_ecf

Boolean lb_sucesso
Boolean lb_blocox

uo_Menu_Fiscal lvo_Menu

SetPointer(HourGlass!)

If Not of_Nr_Ecf(ref ll_Ecf) Then Return False

If Not This.of_AbrePorta() 				Then Return False

If Not This.of_Marca_Modelo_Tipo()		Then Return False

If Not This.of_Percentual_Livre_MFD()	Then Return False

This.of_data_hora_ecf(Ref ldt_data_hora_ecf)

If Not of_DataFiscal(Ref ldt_DataFiscal) Then
	This.of_FechaPorta()
	Return False
End If

If Not of_Data_Ultima_ReducaoZ(Ref ldt_ReducaoZ) Then
	This.of_FechaPorta()
	Return False
End If

If ldt_DataFiscal = Date("1900/01/01") Then
	
	This.of_Horario_Verao()
	This.of_Abertura_Dia()
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","ECF est$$HEX1$$e100$$ENDHEX$$ sem movimenta$$HEX2$$e700e300$$ENDHEX$$o desde a $$HEX1$$fa00$$ENDHEX$$ltima Redu$$HEX2$$e700e300$$ENDHEX$$o Z.~r~r" + &
						 		"N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio efetu$$HEX1$$e100$$ENDHEX$$-la.~r~r"+&
						 		"Data $$HEX1$$da00$$ENDHEX$$ltima Redu$$HEX2$$e700e300$$ENDHEX$$o Z " + String(ldt_ReducaoZ),Exclamation!)
	
	This.of_FechaPorta()
	
	Return True
	
Else
	
	If Not of_verifica_cupons_pendentes() Then
		This.of_FechaPorta()
		Return False
	End If
	
	ls_data = String(Day(Today()),'00')+"/"+String(Month(Today()),'00')+"/"+RightA(String(Year(Today()),'0000'),2)
	ls_hora = String(Now(),"hh:mm:ss")	
	
	EnviaReducaoNovamente:
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ReducaoZ(ls_data,ls_Hora), 'Bematech_FI_ReducaoZ')
   
	If ll_Retorno = 1 Then
		If of_Status_ECF() = -1 Then				
			If This.St3 = 33 Then		
				If Not of_cancela_Recebimento_Nao_Fiscal() Then Return False					
				Goto EnviaReducaoNovamente
			End If
			
			If This.St3 = 31 Or This.St3 = 82 Then
				If Not of_fecha_cupom_nao_fiscal() Then Return False
				Goto EnviaReducaoNovamente
			End If				
		End If		
		
		If Not pdv.of_verifica_aliquotas() Then //Busca as aliquotas no banco e se necess$$HEX1$$e100$$ENDHEX$$rio inclui na ECF.
			gvo_aplicacao.of_grava_log("Problemas na verifica$$HEX2$$e700e300$$ENDHEX$$o de aliquotas da ECF.")
		End If		

	Else
		gvo_aplicacao.of_grava_log("Erro no retorno: " + String(ll_Retorno) + " ECF: " + String(This.ECF) + " ao gravar Mapa Resumo.")
	End If
	
	This.of_Data_Hora_Usuario_Software_Basico()

	This.of_Verifica_Versao_Software_Basico()
	
	//PDV.of_data_ultima_venda_sistema(ldt_ultima_venda)		
	
	This.of_Atualiza_Numero_SerieMFD()
	
	This.of_registra_documento_ecf( 'RZ' )
		
 End If

If of_Grava_Mapa_Resumo(ldt_DataFiscal) Then
	lb_sucesso = True
Else
	lb_sucesso = False
End if

//Envia arquivo BlocoX
//HOMOLOGA$$HEX2$$c700c300$$ENDHEX$$O colocar essa parte depois de gerar o arquivo ECF.
If lb_sucesso Then
	lvo_Menu = Create uo_Menu_Fiscal
	If Trim(lvo_Menu.id_envia_blocoX) = 'L' Then 
		lvo_Menu.of_envia_pendencias_blocox('RZ', PDV.ecf, True)
	End If
	If Trim(lvo_Menu.id_gera_blocoX) = 'S' And Date(ldt_DataFiscal) >= lvo_menu.dt_inicio_blocox Then
		lvo_menu.of_gera_blocox_reducao( ldt_DataFiscal, PDV.ecf, PDV.ivl_seq_historico)				
		lvo_menu.of_envia_pendencias_blocox_matriz( 'RZ', PDV.ecf, False, False)
		//lvo_menu.of_verifica_pendencias_blocox('RZ', PDV.ecf, True, False, Ref lb_blocox,'N')
	End If
	Destroy(lvo_Menu)	
End If

PDV.of_gera_espelho_mfd_mensal(ll_ecf, ldt_DataFiscal)

PDV.of_gera_cotepe_mensal(ll_ECF, ldt_DataFiscal)

If lb_sucesso Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Mapa Resumo gravado com sucesso !")

If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI,"Desenvolvimento","Homologacao","") = "S" Then

	lvo_Menu = Create uo_Menu_Fiscal
	PDV.of_data_ultima_venda_sistema(ldt_ultima_venda)//Homologacao tirar daqui e descomentar o de cima.		
	If Not lvo_Menu.of_Gera_Movimento_pafecf(Ref ls_Arquivo,PDV.ecf, ldt_DataFiscal, ldt_DataFiscal, Date(ldt_ultima_venda)) Then Return False	
	
	If Not lvo_Menu.of_Assinatura_Digital(ls_Arquivo) Then Return False
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_Arquivo + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
		Run('Notepad.exe ' + ls_Arquivo )
	End If
	
	Destroy(lvo_Menu)
End If

Return True
end function

public function boolean of_capturar_md5 (string ps_arquivo, ref string ps_md5);Long ll_Retorno
	
String ls_MD5
	
ls_MD5 = Space(33)	

ll_Retorno = This.of_Verifica_Retorno_ECF(md5FromFile(ps_Arquivo,Ref ls_MD5),'md5FromFile')

If ll_Retorno = 1 Then
	ps_MD5 = ls_MD5
	Return True
End IF	

Return False
end function

public subroutine of_status_extendido_ecf ();
Long ll_Ack
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

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg,StopSign!)
end subroutine

public subroutine of_status_extendido_nao_fiscal_ecf ();
Integer	li_Status
Long 		ll_Retorno

String ls_Msg

//li_Status = 0

ll_Retorno = Bematech_FI_StatusEstendidoMFD( Ref li_Status )

ls_Msg = ''

If li_Status >= 128 Then                 // bit 7
	li_Status = li_Status - 128 
End If 

If li_Status >= 64 Then                  // bit 6 
	li_Status = li_Status - 64 
End If 

If li_Status >= 32 Then                  // bit 5 
	li_Status = li_Status - 32 
End If 

If li_Status >= 16 Then                  // bit 4 
	li_Status = li_Status - 16 
End If 

If li_Status >= 8 Then                  // bit 3 
	li_Status = li_Status - 8 
End If 

If li_Status >= 4 Then                  // bit 2 
	li_Status = li_Status - 4 
End If 

If li_Status >= 2 Then                  // bit 1 
	li_Status = li_Status - 2 
End If

If li_Status >= 1 Then                  // bit 1 
	This.St3 = 33
End If
end subroutine

public function boolean of_status_papel_ok ();If This.ivb_Modo_Teste Then Return True

Long   ll_Retorno
Long   ll_Retry
String ls_Bobina

ls_Bobina = Space( 1 )

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_VerificaSensorPoucoPapelMFD(Ref ls_Bobina),'Bematech_FI_VerificaSensorPoucoPapelMFD')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			If ls_Bobina = "1" Then 
				Return True
			Else
				gvo_aplicacao.of_grava_log('Pouco papel na impressora.')
				If Not of_pergunta_falta_papel() Then Return False
				Continue
			End If	
		Case 100 			// Impressora ocupada
			Continue
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

public function long of_status_ecf ();Long ll_Ack
Long ll_St1
Long ll_St2
Long ll_St3

Long ll_Retorno

ll_Retorno = Bematech_FI_RetornoImpressoraMFD(Ref ll_Ack,Ref ll_St1,Ref ll_St2, Ref ll_St3)

This.Ack = ll_Ack
This.St1 = ll_St1
This.St2 = ll_St2
This.St3 = ll_St3

//Comando executado corretamente
If This.Ack = 6 and This.St1 = 0 and This.St2 = 0 and This.St3 = 0 Then Return 1
//Comando executado corretamente, ecf com pouco papel
If This.Ack = 6 and This.St1 = 64 and This.St2 = 0 and This.St3 = 0 Then Return 1

//Erro Impressora Retornou NAK
If This.Ack = 21 Then 
	gvo_aplicacao.of_grava_log("Erro Impressora Retornou NAK.")
	Return -1
End If
	
//ECF Ocupado
If This.St3 = 9 Then 
	gvo_aplicacao.of_grava_log("ECF Ocupado.")
	Return 100
End If

//Erro ao verificar status ECF
If ll_Retorno <> 1 Then 
	gvo_aplicacao.of_grava_log("Erro ao verificar status ECF.")
	Return -1 
End If

If This.St3 = 31 Or This.St3 = 82 Then 
	gvo_aplicacao.of_grava_log("Comprovante CCD Aberto na ECF.")
	Return -1
End If

If This.St3 <> 0 And This.St3 <> 101 Then
	gvo_aplicacao.of_grava_log("ST3: " + String(This.St3) + " - " + This.of_status_st3())
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "ST3: " + String(This.St3) + " - " + This.of_status_st3())
	Return -1
End If

Return 1
end function

public function boolean of_contador_cupom_fiscal (ref long pl_contador);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Contador

ls_Contador = Space( 10 )

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ContadorCupomFiscalMFD(Ref ls_Contador), 'Bematech_FI_ContadorCupomFiscalMFD')
	
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

public function boolean of_gera_arquivo_cotepe1704 (string ps_tipo, string ps_inicio, string ps_final, string ps_razao_social, string ps_endereco);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Row

String ls_Origem  = 'c:\sistemas\cl\arquivos\paf-ecf\download.mfd'
String ls_Destino = 'c:\sistemas\cl\arquivos\paf-ecf\retorno.txt'
String ls_Cotepe
String ls_nulo

SetNull(ls_nulo)

If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI,"Desenvolvimento","Homologacao","") = "S" Then
	ls_Cotepe = 'c:\sistemas\cl\arquivos\paf-ecf\cotepe1704-' + ps_tipo + '.txt'
Else
	If Trim(gvo_parametro.ivs_uf_filial) = 'SP' Then
		ls_Cotepe = ps_endereco
	Else	
		ls_Cotepe = 'c:\sistemas\cl\arquivos\paf-ecf\cotepe1704-' + ps_tipo + '.txt'
	End If
End If

FileDelete(ls_Origem)
FileDelete(ls_Destino)
FileDelete(ls_Cotepe)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DownloadMFD(ls_Origem,ps_Tipo,ps_inicio,ps_final,'1'),'Bematech_FI_DownloadMFD')
	
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
	
	If ps_Tipo = '2' Then
	
		Do While ll_Retry <= 3
		
			ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_FormatoDadosMFD(ls_Origem,ls_Destino,'0',ps_Tipo,ps_inicio,ps_final,'1'),'Bematech_FI_FormatoDadosMFD')
			
			Choose Case ll_Retorno
				Case 1 				// Comando OK				
					If Not FileExists(ls_Destino) Then
						gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar arquivo " + ls_Destino+", fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_gera_arquivo_cotepe1704().")
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar arquivo " + ls_Destino ,StopSign!)
						Return False
					End If	
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
		
		datastore lds_temp
		lds_temp = Create datastore
		lds_temp.DataObject = 'dw_ge038_leitura_ecf'
		
		Long ll_i
		
		ll_i = lds_temp.ImportFile(ls_Destino)
		
		For ll_row = 1 To lds_Temp.RowCount()
			
			If MidA(lds_Temp.object.de_linha[ll_row],3,1) = '/' Then Exit
			
		Next	
		
		ps_inicio = MidA(lds_temp.object.de_linha[ll_row],01,10)
		
		For ll_row = lds_Temp.RowCount() To 1 Step -1
	
			If MidA(lds_Temp.object.de_linha[ll_row],22,1) = '/' Then Exit
			
		Next
		
		ps_final  = MidA(lds_temp.object.de_linha[ll_row],20,10)
		
		ps_inicio = MidA(ps_inicio,1,2)+MidA(ps_inicio,4,2)+MidA(ps_inicio,7,4)
		ps_final  = MidA(ps_final,1,2)+MidA(ps_final,4,2)+MidA(ps_final,7,4)
		
		Destroy(lds_temp)
		
	End If	
		
	Do While ll_Retry <= 3
	
		ll_Retorno = BemaGeraRegistrosTipoE(ls_Origem,ls_Cotepe,ps_inicio,ps_final,ps_razao_social,ps_endereco,ls_nulo,'2',ls_nulo,ls_nulo,ls_nulo,ls_nulo,ls_nulo,ls_nulo,ls_nulo,ls_nulo,ls_nulo,ls_nulo,ls_nulo,ls_nulo,ls_nulo)
				
		Choose Case ll_Retorno
			Case 0,1 			// Comando OK
				Return True				
			Case -3 				// Erro ao executar comando
				gvo_aplicacao.of_grava_log("Erro ao localizar arquivo origem " + ls_Origem+", fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_gera_arquivo_cotepe1704().")
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar arquivo origem " + ls_Origem ,StopSign!)
				Return False					
			Case 100 			// Impressora ocupada
				Continue
			Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
				Return False
		End Choose
		
		ll_Retry ++

	Loop
		
Else
	gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar arquivo " + ls_Destino+", fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_gera_arquivo_cotepe1704().")
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar arquivo " + ls_Destino ,StopSign!)
End If
	
Return False
end function

public function string of_desencripta (string ps_texto);
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

public function boolean of_atualiza_data_fiscal ();
If This.ivb_Modo_Teste Then Return True

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esse processo n$$HEX1$$e300$$ENDHEX$$o se aplica a esse modelo de impressora Fiscal",Exclamation!)

Return True

end function

public function boolean of_atualiza_venda_bruta ();
Decimal{2}	ldc_Valor

String 		ls_File = 'c:\sistemas\cl\arquivos\pafecf.ini'
String 		ls_Serie
String   	ls_Valor

If Not FileExists(ls_File) Then
	gvo_aplicacao.of_grava_log("Arquivo " + ls_File + " n$$HEX1$$e300$$ENDHEX$$o encontrado. Fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_atualiza_venda_bruta().")
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo " + ls_File + " n$$HEX1$$e300$$ENDHEX$$o encontrado.",StopSign!)
	Return False
End If
	
If Not of_Grande_Total(Ref ldc_Valor) Then Return False

SetProfileString(ls_File, "ECF", "Serie",of_Encripta(This.nr_Serie))
SetProfileString(ls_File, "ECF", "VendaBruta",of_Encripta(String(ldc_Valor,'###,###,###,###.00')))
	
Return True
end function

public function boolean of_leitura_memoria_fiscal_ac1704 (string ps_dado_inicio, string ps_dado_final);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Geracao

String ls_ChavePublica
String ls_ChavePrivada
String ls_Tipo

ls_ChavePublica = "9716BE0910DB085542B39EE19383F3EB45A32D8962D57FFC6DAF0F04B872F52EF36F144131F6923B1A9EA73F13527A9CFD5A26F688505FC63ED9F95D240BF9D3A9655E26AE6AB706A1633693FCB3048A750E4B15EAE98F64EF6E941A78422E7ECB1D126C268DF5FA8E228A2CDD5206CE50B4D15D14B99906604C73E6DF807939"
ls_ChavePrivada = "C59A1793009F74E975542E2841C840B34D8C45143D5B761DE1FADFE447289D4308452A882AED183FB5781A1C23AED97726023C3710161C68ABA7275AE9826119C3BD9FC24E4C6DE977B674EDA0CE56F4E1F3884F51230A10CAF8362FE4C758A1DD0F9F50F0810F8507E8419884BAA981771B5EACE835E94EB62CDE4DAFE73D21"

If Not IsDate(ps_Dado_Inicio) Then
	ls_Tipo = 'C'
	ll_Geracao = 3
Else
	ls_Tipo = 'D'
	ll_Geracao = 2
End If

Do While ll_Retry <= 3
		 
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ArquivoMFD('' , ps_dado_inicio , ps_dado_final , ls_Tipo , '01' , 0 , ls_ChavePublica , ls_ChavePrivada , 1),'Bematech_FI_ArquivoMFD')
		
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

public function boolean of_registra_documento_ecf (string ps_documento);
String ls_Nulo

Decimal ldc_Nulo

SetNull(ls_Nulo)
SetNull(ldc_Nulo)

Return of_Registra_Documento_ecf(ps_documento,ls_Nulo,ldc_Nulo)
end function

public function boolean of_cancela_item_anterior ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_CancelaItemAnterior(),'Bematech_FI_CancelaItemAnterior')
	
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

public function boolean of_verifica_venda_bruta_diaria ();//Return True

//Desabilitado - Utilizado na Homologa$$HEX2$$e700e300$$ENDHEX$$o

Decimal{2}	ldc_Valor

Long 			ll_ecf

String	ls_File = 'C:\Sistemas\CL\Arquivos\Pafecf.ini'
String	ls_Serie
String	ls_SerieIni
String	ls_ValorIni
String	ls_Instalacao
String	ls_ecf

ls_Serie = Space( 21 )

If Not FileExists(ls_File) Then
	
	If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Homologacao","") = 'S' And PDV.id_recria_gt <> 'S' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo de registro de Venda Bruta e N$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie n$$HEX1$$e300$$ENDHEX$$o encontrado.~r~rVenda bloqueada!")
		Return False
	End If
	
	FileClose(FileOpen(ls_file,StreamMode!,Write!,Shared!,Append!))
	
	If Not of_Grande_Total(Ref ldc_Valor) Then Return False
		
	If of_Verifica_Retorno_ECF(Bematech_FI_NumeroSerieMFD(ls_Serie),'Bematech_FI_NumeroSerieMFD') <> 1 Then Return False
	
	SetProfileString(ls_File, "ECF", "Serie",of_Encripta(ls_Serie))
	
	SetProfileString(ls_File, "ECF", "VendaBruta",of_Encripta(String(ldc_Valor,'###,###,###,###.00')))
	
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Registro de Venda Bruta e N$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie efetuados !")
	
Else
	
	If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Homologacao","") <> 'S' Then
		Return True
	End If
	
	If Not of_Grande_Total(Ref ldc_Valor) Then Return False
		
	If of_Verifica_Retorno_ECF(Bematech_FI_NumeroSerieMFD(ls_Serie),'Bematech_FI_NumeroSerieMFD') <> 1 Then Return False
	
	ls_SerieIni = ProfileString(ls_File, "ECF", "Serie","none")
	ls_ValorIni = ProfileString(ls_File, "ECF", "VendaBruta","none")

	ls_SerieIni = of_Desencripta(ls_SerieIni)
	ls_ValorIni	= of_Desencripta(ls_ValorIni)

	If ls_SerieIni <> ls_Serie Then
		gvo_aplicacao.of_grava_log("N$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie da ECF incompat$$HEX1$$ed00$$ENDHEX$$vel com o n$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie liberado para o PDV.~n~nECF: " + ls_Serie + " PDV: " + ls_SerieIni)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie da ECF incompat$$HEX1$$ed00$$ENDHEX$$vel com o n$$HEX1$$fa00$$ENDHEX$$mero de S$$HEX1$$e900$$ENDHEX$$rie liberado para o PDV.~n~nECF: " + ls_Serie + " PDV: " + ls_SerieIni,Exclamation!)
		Return False
	End If

	If Dec(ls_ValorIni) <> ldc_Valor Then
		gvo_aplicacao.of_grava_log("Valor da Venda Bruta da ECF divergente do valor acumulado no PDV.~n~nECF: " + String(ldc_Valor,'###,###,###,##0.00') + " PDV: " + ls_ValorIni)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor da Venda Bruta da ECF divergente do valor acumulado no PDV.~n~nECF: " + String(ldc_Valor,'###,###,###,##0.00') + " PDV: " + ls_ValorIni,Exclamation!)
		Return False
	End If

End If

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
	
	If UpperBound(ps_msg) >= 8 And ll_ind = 8 Then Continue
	
	If Not IsNull(ps_msg [ll_ind]) and Trim(ps_msg [ll_ind]) <> "" Then
		
		ls_msg += Trim(MidA(ps_msg [ll_ind],1,60)) + CharA(10)	
		
	End If
	
Next

ls_msg = CharA(27) + CharA(15) + ls_msg + CharA(27) + CharA(18)

Long lvl_Pos, lvl_Pos2

//lvl_Pos = Pos(ls_msg, "VOCE ECONOMIZOU")
//If lvl_Pos > 0 Then
//	ls_msg = Mid(ls_msg, 1, lvl_Pos - 1) + Char(27) + Char(69) + Mid(ls_msg, lvl_Pos, 30) + Char(27) + Char(70) + Mid(ls_msg, lvl_Pos + 30)
//End If 

lvl_Pos = PosA(ls_msg, "SUA ECONOMIA")
If lvl_Pos > 0 Then
	lvl_Pos2 = PosA(ls_msg, "PTOS CLUBE")
	If lvl_Pos2 > 0 Then
		ls_msg = MidA(ls_msg, 1, lvl_Pos - 1) + CharA(27) + CharA(69) + MidA(ls_msg, lvl_Pos, 40) + CharA(27) + CharA(70) + MidA(ls_msg, lvl_Pos + 40)	
	Else
	   ls_msg = MidA(ls_msg, 1, lvl_Pos - 1) + CharA(27) + CharA(69) + MidA(ls_msg, lvl_Pos, 21) + CharA(27) + CharA(70) + MidA(ls_msg, lvl_Pos + 21)
	End If
End If 
	
Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_TerminaFechamentoCupom(ls_msg),'Bematech_FI_TerminaFechamentoCupom')
	
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

public function boolean of_registra_documento_ecf (string ps_documento, string ps_totalizador, decimal pdc_valor);Long ll_coo
Long ll_gnf
Long ll_grg
Long ll_cdc
Long ll_ccf

Date ldh_Movimento
Datetime ldh_Final

String ls_Hash

//If pdc_valor = 000.00 Then Return True

If Not of_nr_cupom(Ref ll_coo) Then Return False

//ldh_Movimento = This.of_dh_movimentacao()
//ldh_Final	  = gf_GetServerDate()

This.of_datafiscal( ref ldh_movimento )
This.of_data_hora_ecf(Ref ldh_final)

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

public function boolean of_inicializa_comprovante_tef (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor, string ps_cupom);If This.ivb_Modo_Teste Then Return True

Long   ll_Retry
Long   ll_Retorno

String ls_Pagamento
String ls_Valor 
String ls_Cupom

ls_Valor = String(pdc_Valor)
ls_Cupom = ps_cupom

If Trim(ls_Cupom) = '' Then ls_Valor = ''

//Retorna descri$$HEX2$$e700e300$$ENDHEX$$o do meio de pagamento
ls_Pagamento = of_meio_pagamento(ps_pagamento)

Do While ll_Retry <= 3

	 ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_AbreComprovanteNaoFiscalVinculado(ls_Pagamento,ls_Valor,ls_Cupom),'Bematech_FI_AbreComprovanteNaoFiscalVinculado')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			If of_Status_ECF() = -1 Then				
				If This.St3 = 33 Then		
					If Not of_cancela_Recebimento_Nao_Fiscal() Then Return False					
					Return of_inicializa_comprovante_tef(ps_pagamento, ps_descricao, ps_recebimento, pdc_valor, ps_cupom)
				End If
				
				If This.St3 = 31 Or This.St3 = 82 Then
					If Not of_fecha_cupom_nao_fiscal() Then Return False
					Return of_inicializa_comprovante_tef(ps_pagamento, ps_descricao, ps_recebimento, pdc_valor, ps_cupom)
				End If				
			End If								
			
			of_Registra_documento_ecf('CC',pdc_valor)
			
			Return True
			
		Case 0 				// Erro ao executar comando
			Return False
		Case 100 			// Impressora ocupada
			Continue
		Case -1 			   // Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Choose Case This.st3
				Case 3,23,28
					Return of_inicializa_comprovante_tef_nao_fiscal(ps_pagamento,ps_descricao,ps_recebimento,pdc_valor)
			End Choose
			
			Return False		
		
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_fecha_relatorio_gerencial ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

If This.ivb_Cod_Barras Then
	This.of_codigo_barras(0,This.ivs_Cod_Barras,'1')	
End If

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_FechaRelatorioGerencial(),'Bematech_FI_FechaRelatorioGerencial')
	
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

public function boolean of_inicializa_relatorio_gerencial (string ps_relatorio, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Sequencia,&
     ll_Retorno,&
     ll_Ecf

Do While ll_Retorno <> 1 

	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_AbreRelatorioGerencialMFD(ps_relatorio),'Bematech_FI_AbreRelatorioGerencialMFD')
	
	Choose Case ll_Retorno
		Case 1 						// Comando OK
			If of_Status_ECF() = -1 Then				
				If This.St3 = 33 Then		
					If Not of_cancela_Recebimento_Nao_Fiscal() Then Return False					
					Return of_inicializa_relatorio_gerencial(ps_relatorio, pdc_valor)
				End If
				
				If This.St3 = 31 Or This.St3 = 82 Then
					If Not of_fecha_cupom_nao_fiscal() Then Return False
					Return of_inicializa_relatorio_gerencial(ps_relatorio, pdc_valor)
				End If				
			End If					
			
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

public function boolean of_conecta_impressora ();
If This.ivb_Modo_Teste Then Return True

SetPointer(HourGlass!)

LONG lvl_Porta
LONG lvl_Retorno
LONG ll_diretorio

String ls_ECF
String ls_dir = 'C:\sistemas\dll\bematech'
String ls_log

Boolean lb_arquivo_manutencao = True

of_porta_comunicacao()
of_timeout_ecf()
of_grava_log_ecf()

If Not Of_Verifica_Drivers() Then Return False

If FileExists(ls_dir + '\BemaFI32.ini') Then		
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "CrLfVinculado", "0")
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "CrLfGerencial", "0")
	If This.ivs_Grava_Log = 'SIM' Then
		ls_Log     = ProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "Log", "")
		If Long(ls_log) < 1 Then
			SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "Log", "1")
		End If
	Else
		SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "Log", "0")		
	End If
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "CupomAdicional", "0")
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "VersaoAtoCotepe", "1")
	SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "CleanValidation", "0")	
End If	

//Controle colocado para o Retuaguarda, porque ao usar a dll  a primeira vez, ela fica alocada at$$HEX1$$e900$$ENDHEX$$ o programa ser fechado
//e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ possivel fazer a copia para outro diretorio, neste caso s$$HEX1$$f300$$ENDHEX$$ fara a copia a primeira vez que acessar a tela de impressora fiscal.
If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" And gvo_Aplicacao.ivb_Acessou_ECF  Then
	Goto PuloRetaguarda
End If

dc_uo_api lo_api
lo_api = Create dc_uo_api

//Copia as dlls para pasta do Executavel

FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\bemafi32.ini')
If Not lo_api.of_copy_file(ls_dir + '\BemaFI32.ini', gvo_Aplicacao.ivs_Path_Sistema + '\BemaFI32.ini', true) Then Return False
FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\AX6R32.DLL')
If Not lo_api.of_copy_file(ls_dir + '\AX6R32.DLL', gvo_Aplicacao.ivs_Path_Sistema + '\AX6R32.DLL', true) Then Return False
FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\BemaFI32.dll')
If Not lo_api.of_copy_file(ls_dir + '\BemaFI32.dll', gvo_Aplicacao.ivs_Path_Sistema + '\BemaFI32.dll', true) Then Return False
FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\BemaFI32.lib')
If Not lo_api.of_copy_file(ls_dir + '\BemaFI32.lib', gvo_Aplicacao.ivs_Path_Sistema + '\BemaFI32.lib', true) Then Return False
FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\BemaMFD.dll')
If Not lo_api.of_copy_file(ls_dir + '\BemaMFD.dll', gvo_Aplicacao.ivs_Path_Sistema + '\BemaMFD.dll', true) Then Return False
FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\BemaMFD2.dll')
If Not lo_api.of_copy_file(ls_dir + '\BemaMFD2.dll', gvo_Aplicacao.ivs_Path_Sistema + '\BemaMFD2.dll', true) Then Return False
FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\DAO350.DLL')
If Not lo_api.of_copy_file(ls_dir + '\DAO350.DLL', gvo_Aplicacao.ivs_Path_Sistema + '\DAO350.DLL', true) Then Return False
FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\DAO2535.TLB')
If Not lo_api.of_copy_file(ls_dir + '\DAO2535.TLB', gvo_Aplicacao.ivs_Path_Sistema + '\DAO2535.TLB', true) Then Return False
FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\MSJET35.dll')
If Not lo_api.of_copy_file(ls_dir + '\MSJET35.dll', gvo_Aplicacao.ivs_Path_Sistema + '\MSJET35.dll', true) Then Return False
//RETIRADO - pode afetar outras aplica$$HEX2$$e700f500$$ENDHEX$$es, por exemplo autoriza$$HEX2$$e700e300$$ENDHEX$$o FUNCIONAL.
//FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\libeay32.dll')
//If Not lo_api.of_copy_file(ls_dir + '\libeay32.dll', gvo_Aplicacao.ivs_Path_Sistema + '\libeay32.dll', true) Then Return False

//Dll MFD da MP4200
//Quando a dll da MP4200 estiver estavel e usando para todos os modelos, fazer o tratamento igual as demais dlls.
FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\BemaMFD3.dll')
lo_api.of_copy_file(ls_dir + '\BemaMFD3.dll', gvo_Aplicacao.ivs_Path_Sistema + '\BemaMFD3.dll', True, False)

//Tratamento para arquivo manutencao.xml - Retirado pois nos ECFs com problema n$$HEX1$$e300$$ENDHEX$$o resolveu
//This.of_verifica_arquivo_manutencao( Ref lb_arquivo_manutencao )

Destroy(lo_api)

//Seta o diretorio, pois aqui est$$HEX1$$e100$$ENDHEX$$ setado o c:\client, que foi setado na abertura do sistema.
ll_diretorio = ChangeDirectory( gvo_Aplicacao.ivs_Path_Sistema )

PuloRetaguarda:

lvl_Retorno = Bematech_FI_AbrePortaSerial()
	
If of_verifica_retorno_ecf(lvl_Retorno,'Bematech_FI_AbrePortaSerial') <> 1 Then Return False

//If Not lb_arquivo_manutencao Then
//	This.of_verifica_arquivo_manutencao( Ref lb_arquivo_manutencao )
//	If lb_arquivo_manutencao Then //Primeira vez que a dll cria o arquivo manutencao.xml tem liberar a dll e carregar novamente
//		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Primeira configura$$HEX2$$e700e300$$ENDHEX$$o da dll, ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fechar o Sistema e abrir novamente.", StopSign!)
//		End If
//		Return False
//	End If
//End If

of_verifica_versao_dll()

This.ivb_Porta_Aberta = True

gvo_Aplicacao.ivb_Acessou_ECF = True

//Processo para gravar arquivos da NF PAULISTA.
If gvo_parametro.ivs_uf_filial = 'SP' Then
	If (ProfileString(ls_dir + '\BemaFI32.ini',"ECF", "UF", "")) <> gvo_parametro.ivs_uf_filial Then
		SetProfileString(ls_dir + '\BemaFI32.ini',"Sistema", "Path", "C:\Sistemas\Rl\Arquivos\ECF")		
		SetProfileString(ls_dir + '\BemaFI32.ini',"SoftwareHouse", "NumeroAplicativo", "01")
		SetProfileString(ls_dir + '\BemaFI32.ini',"SoftwareHouse", "CNPJ", "84683481000177")
		SetProfileString(ls_dir + '\BemaFI32.ini',"SoftwareHouse", "IE", "250330539")		
		SetProfileString(ls_dir + '\BemaFI32.ini',"SoftwareHouse", "RazaoSocial", "CIA LATINO AMERICANA DE MEDICAMENTOS")
		SetProfileString(ls_dir + '\BemaFI32.ini',"SoftwareHouse", "NomeAplicativo", "SISTEMA DE CAIXA")		
		SetProfileString(ls_dir + '\BemaFI32.ini',"SoftwareHouse", "Versao", gvo_aplicacao.ivs_Versao)
		SetProfileString(ls_dir + '\BemaFI32.ini',"ECF", "UF", "SP")		
	End If
End If

Return True

end function

public function boolean of_configuracoes ();If This.ivb_Modo_Teste Then Return True

//Impressora j$$HEX1$$e100$$ENDHEX$$ foi configurada
If This.ECF > 0 Then Return True

//If This.of_Verifica_Retorno_ECF(Bematech_FI_EspacoEntreLinhas(002)) <> 1 Then Return False

If This.of_Verifica_Retorno_ECF(Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD("1"),'Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD') <> 1 Then Return False

Return True
end function

public function boolean of_abertura_dia ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_AberturaDoDia("0,00", "Dinheiro"),'Bematech_FI_AberturaDoDia')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
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

public function boolean of_porta_comunicacao ();
String lvs_INI,&
       lvs_Porta

lvs_INI  = gvo_Aplicacao.ivs_Arquivo_INI

// Verifica se o caminho dos arquivos de ajuda est$$HEX1$$e300$$ENDHEX$$o especificados no INI
lvs_Porta = ProfileString(lvs_INI, "ECF", "Porta","")

If Not IsNumber(lvs_Porta) Then
	gvo_aplicacao.of_grava_log("Arquivo de configura$$HEX2$$e700e300$$ENDHEX$$o: " + lvs_INI + ' n$$HEX1$$e300$$ENDHEX$$o possui o par$$HEX1$$e200$$ENDHEX$$metro Porta na sess$$HEX1$$e300$$ENDHEX$$o [ECF]')
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de configura$$HEX2$$e700e300$$ENDHEX$$o : " + lvs_INI + '~n~nN$$HEX1$$e300$$ENDHEX$$o possui par$$HEX1$$e200$$ENDHEX$$metros~n~n[ECF]~nPorta=', StopSign! )
	Return False
End If

This.Porta = Long(lvs_Porta)

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
		gvo_aplicacao.of_grava_log("Problemas na leitura dos dados da ECF.")
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
				
		gvo_aplicacao.of_grava_log("Erro na consulta Marca/Modelo/Tipo ECF "+SQLCa.SQLErrText)
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
				  dh_referencia_arquivo_mfd)   
		Values (:This.ECF,
				  :ls_Serie,   
				  'L',   
				  :ls_Marca,   
				  :ls_Modelo,   
				  :This.nr_Serie,
				  :This.de_Tipo,
				  :ldt_data_ecf)
		Using Sqlca;
				  
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_RollBack()
			gvo_aplicacao.of_grava_log("Erro na inclus$$HEX1$$e300$$ENDHEX$$o ECF "+SQLCa.SQLErrText)
			Sqlca.of_MsgDbError('Inclus$$HEX1$$e300$$ENDHEX$$o ECF.')
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
			ls_modelo = LeftA(This.de_modelo,15)			
		
			Update impressora_fiscal
			Set de_fabricante = :ls_Marca,
				 de_modelo		= :ls_Modelo,
				 de_tipo			= :This.de_Tipo
			Where nr_ecf 		= :This.Ecf	 
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				gvo_aplicacao.of_grava_log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o Marca/Modelo/Tipo ECF "+SQLCa.SQLErrText)
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

public function boolean of_codigo_barras (integer pl_tipo, string ps_codigo, string ps_tamanho);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
String ls_Codigo

ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ConfiguraCodigoBarrasMFD(100,1,0,0,5),'Bematech_FI_ConfiguraCodigoBarrasMFD')

If ll_Retorno = 1 Then

	Do While ll_Retry <= 3
		
	   Choose Case pl_Tipo
			Case 0		
				ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_CodigoBarrasEAN13MFD(ps_Codigo),'Bematech_FI_CodigoBarrasEAN13MFD')
			Case 4
				ps_codigo = FillA("0",4) + ps_codigo				
				ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_CodigoBarrasITFMFD(ps_Codigo),'Bematech_FI_CodigoBarrasITFMFD')
			Case Else
				ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_CodigoBarrasEAN13MFD(ps_Codigo),'Bematech_FI_CodigoBarrasEAN13MFD')
		End Choose
		
		Choose Case ll_Retorno
			Case 1 				// Comando OK
				//Imprime o texto do codigo de barras + digito.
				ls_Codigo = ps_Codigo + '0'
				ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_UsaRelatorioGerencialMFD(ls_Codigo),'Bematech_FI_UsaRelatorioGerencialMFD')
				
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
	
End If

Return False


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

Long ll_Retry
Long ll_Retorno
Long ll_St1
Long ll_asc

ll_asc = AscA(ps_texto)
If ll_asc = 13 Then //para resolver problema com a MP4200
	ps_texto = '      '
Else
	ll_asc = AscA(Trim(ps_texto))
	If ll_asc = 13 Then
		ps_texto = '      '			
	End If
End If	
If LenA(Trim(ps_texto)) < 35 Then //para resolver problema com a MP4200
	ps_texto = ps_texto  + FillA(" ",(35 - LenA(Trim(ps_texto))))
End If

ps_texto = CharA(27) + CharA(15) + ps_texto + CharA(13) + CharA(10)

ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_UsaRelatorioGerencialMFD(ps_texto),'Bematech_FI_UsaRelatorioGerencialMFD')

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

public function boolean of_inicializa_comprovante_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

String	ls_Pagamento
String	ls_Forma_Pagamento 

Choose Case ps_pagamento
	Case "01" ; ls_Forma_Pagamento = "DINHEIRO       "
	Case "02" ; ls_Forma_Pagamento = "CHEQUE			 "	
	Case "03" ; ls_Forma_Pagamento = "CHEQUE-PRE     "
	Case "04" ; ls_Forma_Pagamento = "CARTAO CREDITO "
	Case "05" ; ls_Forma_Pagamento = "CARTAO DEBITO  "
	Case "06" ; ls_Forma_Pagamento = "CONVENIO       " 
	Case "07" ; ls_Forma_Pagamento = "CREDIARIO      "
	Case "08" ; ls_Forma_Pagamento = "CONTA CORRENTE "		
	Case "09" ; ls_Forma_Pagamento = "CLUBE          "
	Case "10" ; ls_Forma_Pagamento = "PBM            "		
	Case "11" ; ls_Forma_Pagamento = "RECARGA        "	
End Choose

//Retorna descri$$HEX2$$e700e300$$ENDHEX$$o do meio de pagamento
ls_Pagamento = of_meio_pagamento(ps_pagamento)

If Not of_inicializa_recebimento_nao_fiscal() Then Return False

If Not of_efetua_recebimento_nao_fiscal(ps_recebimento,String(pdc_valor)) Then Return False

If Not of_Registra_documento_ecf('CN',ls_Forma_Pagamento,pdc_valor) Then Return False

If Not of_totaliza_recebimento_nao_fiscal(ps_pagamento,String(pdc_valor)) Then Return False

If Not of_fecha_recebimento_nao_fiscal(ps_descricao) Then Return False

Return True
end function

public function boolean of_imprime_relatorio_gerencial (string ps_texto[], string ps_tipo);If This.ivb_Modo_Teste Then Return True

Long   ll_Retry
Long   ll_Retorno
Long   ll_Linha
Long   ll_Loop
Long	 ll_st1
Long 	 ll_asc
Long 	 ll_Texto = 1

String ls_Aux
String ls_Texto
String ls_Log =''
String ls_Texto_tratado
String ls_texto2, ls_texto3

//Do While ll_Retry <= 3
	
	For ll_Linha = 1 To UpperBound(ps_texto)
		If Not LenA(ps_texto[ll_Linha]) > 0 Then Continue
			
		//ls_texto = Char(27) + Char(15) + Left(ps_texto[ll_Linha],60) + Char(27) + Char(18) + Char(13) + Char(10)
		If (PDV.ivs_Tipo_Venda = "TR" or sitef.is_Tipo_Venda = "TRNCENTRE" or &
			PDV.ivs_Tipo_Venda = "FC" or sitef.is_Tipo_Venda = "FC" or &
			PDV.ivs_Tipo_Venda = "VL" or sitef.is_Tipo_Venda = "VL") And ps_Tipo = "05" Then			
			//ls_Aux = CharA(27) + CharA(15) + MidA(ps_texto[ll_Linha], 1, 60) + CharA(27) + CharA(18)// + Char(13) + Char(10)
			ls_Aux = MidA(ps_texto[ll_Linha], 1, 60)
			ll_Loop = 61
			ls_texto = ls_Aux
			
			Do While ls_Aux <> ""
				If LenA(ps_texto[ll_Linha]) < ll_Loop Then Exit
				
				//ls_Aux = CharA(27) + CharA(15) + MidA(ps_texto[ll_Linha],ll_Loop, 60) + CharA(27) + CharA(18)// + Char(13) + Char(10)
				ls_Aux = MidA(ps_texto[ll_Linha],ll_Loop, 60)
				
				ls_texto += ls_Aux
				ll_Loop 	+= 60			
			Loop			
		Else
			ls_Aux = CharA(27) + CharA(15) + MidA(ps_texto[ll_Linha], 1, 60) + CharA(27) + CharA(18) + CharA(13) + CharA(10)
			//ls_Aux = MidA(ps_texto[ll_Linha], 1, 60)
		
			ll_Loop = 61
			ls_texto = ls_Aux
			
			Do While ls_Aux <> ""
				If LenA(ps_texto[ll_Linha]) < ll_Loop Then Exit
				
				ls_Aux = CharA(27) + CharA(15) + MidA(ps_texto[ll_Linha],ll_Loop, 60) + CharA(27) + CharA(18) + CharA(13) + CharA(10)
				//ls_Aux = MidA(ps_texto[ll_Linha],ll_Loop, 60)
				
				ls_texto += ls_Aux
				ll_Loop 	+= 60			
			Loop
		End If
		
		//ls_texto = ps_texto[ll_Linha]			
		
		If LenA(ls_texto) > 615 Then			
			ls_texto2 = ls_texto
			Do While LenA(Trim(ls_Texto2)) > 0
				ls_texto3 = LeftA(ls_texto2,615)
				ls_Log += 'Parte '+String(ll_Texto)+': ['+ls_texto3+'].~r'
				
				ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_UsaRelatorioGerencialMFD(ls_texto3),'Bematech_FI_UsaRelatorioGerencialMFD')			
				
				Trata_Retorno1:
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
						ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_UsaRelatorioGerencialMFD(This.of_normaliza_texto(ls_texto3)),'Bematech_FI_UsaRelatorioGerencialMFD')	
						
						If ll_Retorno = -1 Then
							gvo_aplicacao.of_grava_log('Erro ao imprimir a parte '+String(ll_Texto)+' do relat$$HEX1$$f300$$ENDHEX$$rio gerencial ['+ls_texto3+'].~rTexto '+ls_Log+'.')
							Return False	
						Else
							GoTo Trata_Retorno1
						End If
				End Choose
				
				ls_texto2 = MidA(ls_texto2, 616)	
				ll_Texto ++
			Loop
			
			If ll_Linha = UpperBound(ps_texto) Then Return True
		
		Else
			ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_UsaRelatorioGerencialMFD(ls_texto),'Bematech_FI_UsaRelatorioGerencialMFD')		
			
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
					ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_UsaRelatorioGerencialMFD(This.of_normaliza_texto(ls_texto)),'Bematech_FI_UsaRelatorioGerencialMFD')	
					
					If ll_Retorno = -1 Then
						gvo_aplicacao.of_grava_log('Erro ao imprimir relat$$HEX1$$f300$$ENDHEX$$rio gerencial ['+ls_texto+'].')
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

//If Not of_inicializa_relatorio_gerencial(ls_Relatorio,pdc_valor) Then Return False
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


//If Not This.of_imprime_relatorio_gerencial(ps_texto) Then Return False
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

public function boolean of_inicializa_cupom (string ps_cpf_cgc);If This.ivb_Modo_Teste Then Return True

Long ll_Sequencia,&
     ll_Retorno,&
     ll_Ecf

ivb_showerror = FALSE

Do While ll_Retorno <> 1 

	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_AbreCupomMFD(ps_cpf_cgc,"",""),'Bematech_FI_AbreCupomMFD')
	
	Choose Case ll_Retorno
		Case 1 						// Comando OK
	
			If of_Status_ECF() = -1 Then				
				If This.St3 = 33 Then		
					gvo_aplicacao.of_grava_log("Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente, fun$$HEX2$$e700e300$$ENDHEX$$o uo_bematech.of_inicializa_cupom().")
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cupom n$$HEX1$$e300$$ENDHEX$$o fiscal em aberto na ECF ser$$HEX1$$e100$$ENDHEX$$ cancelado automaticamente.",Exclamation!)
					If Not of_cancela_Recebimento_Nao_Fiscal() Then Return False					
					Return of_Inicializa_Cupom(ps_cpf_cgc)
				End If
				
				If This.St3 = 31 Or This.St3 = 82 Then
					If Not of_fecha_cupom_nao_fiscal() Then Return False
					Return of_Inicializa_Cupom(ps_cpf_cgc)					
				End If				
				If This.St3 = 2 Then //Erro desconhecido. Mas na MP4200 retorna com Relatorio Gerencial aberto, ent$$HEX1$$e300$$ENDHEX$$o aqui tento fechar RG aberto.
					If Not of_fecha_cupom_nao_fiscal() Then Return False
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

public function boolean of_gera_arquivo_cat52 (string ps_arquivo, date pdh_data_fiscal);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Row
String ls_Data

ls_Data = String(pdh_data_fiscal, "ddmmyyyy")

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_GeraRegistrosCAT52MFD(ps_Arquivo, ls_Data),'Bematech_FI_GeraRegistrosCAT52MFD')
	
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

public function boolean of_gera_arquivo_cat52 (string ps_arquivo, date pdh_data_fiscal, ref string ps_arquivo_destino);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Row
String ls_Data

ls_Data = String(pdh_data_fiscal, "ddmmyyyy")
ps_arquivo_destino = Space(512)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_GeraRegistrosCAT52MFDEx(ps_Arquivo, ls_Data, Ref ps_arquivo_destino),'Bematech_FI_GeraRegistrosCAT52MFDEx')
	
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

public function boolean of_fecha_recebimento_nao_fiscal (string ps_texto);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_FechaRecebimentoNaoFiscalMFD(ps_texto),'Bematech_FI_FechaRecebimentoNaoFiscalMFD')
	
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

public function boolean of_atualiza_dll_sign ();Boolean	lb_Sucesso 		= True

String   ls_Path_System
String	   ls_path_dll = 'c:\sistemas\dll\bematech'
String   ls_Validar[]
String   ls_Baixar[]

ls_Validar = {"sign_bema.dll"}
ls_Baixar  = {"sign_bema.zip"}

If gvo_Aplicacao.of_is64bits() Then
	ls_Path_System = 'C:\Windows\SysWOW64'
Else
	ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
End If	

dc_uo_api lo_api
lo_api = Create dc_uo_api

If FileExists(ls_Path_System + '\sign_bema.dll')  And lb_Sucesso Then
	
	If Not FileExists(ls_Path_dll) Then
		lo_Api.of_Create_Directory(ls_Path_dll)
	End If
	
	//Move para diretorio das dlls	
	If Not lo_api.of_move_file(ls_Path_System + '\sign_bema.dll', ls_Path_dll + '\sign_bema.dll', true, true) Then lb_Sucesso = False					
	
End If

If Not FileExists(ls_Path_dll + '\sign_bema.dll')  And lb_Sucesso Then

	lb_Sucesso = gf_Download_Matriz(ls_Validar, ls_Baixar, ls_Path_dll, "dll_bematech", True)	

End If

Destroy(lo_api)

If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)

Return lb_Sucesso
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

ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_RetornoAliquotas( Ref ls_aliquotas_cadastradas ),'Bematech_FI_RetornoAliquotas' )
	
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
			ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ProgramaAliquota( ls_aliquota, pl_tipo ),'Bematech_FI_ProgramaAliquota' )
				
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
		ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ProgramaAliquota( ls_aliquota, pl_tipo ),'Bematech_FI_ProgramaAliquota' )
			
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

public function boolean of_cancela_item (integer pl_item);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
String ls_item

ls_item = String(pl_item)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_CancelaItemGenerico(ls_item),'Bematech_FI_CancelaItemGenerico')
	
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

public function long of_verifica_retorno_ecf (long pl_retorno, string ps_funcao);String lvs_Msg = ''
Long ll_Retorno = -1

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
	Case -3
		lvs_Msg = "Al$$HEX1$$ed00$$ENDHEX$$quota n$$HEX1$$e300$$ENDHEX$$o programada!"
	Case -4
		lvs_Msg = "O arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o BemaFI32.ini n$$HEX1$$e300$$ENDHEX$$o foi encontrado no diret$$HEX1$$f300$$ENDHEX$$rio de sistema do Windows ou configurado incorretamente."
	Case -5
		lvs_Msg = "Erro ao abrir a porta de comunica$$HEX2$$e700e300$$ENDHEX$$o."
	Case -6
		lvs_Msg = "Impressora Desligada ou Desconectada." 
	Case -7
		lvs_Msg = "Banco N$$HEX1$$e300$$ENDHEX$$o Cadastrado no Arquivo BemaFI32.ini"
	Case -8
		lvs_Msg = "Erro ao criar ou gravar no arquivo STATUS.TXT ou RETORNO.TXT."
	Case -9
		lvs_Msg ='Time-out na leitura do cheque.'
	Case -24
		lvs_Msg = "Forma de pagamento n$$HEX1$$e300$$ENDHEX$$o programada."
	Case -25
		lvs_Msg = "Totalizador n$$HEX1$$e300$$ENDHEX$$o fiscal n$$HEX1$$e300$$ENDHEX$$o programado."
	Case -27
		ll_Retorno = This.of_Status_ECF()
	Case Else
		lvs_Msg = "Erro desconhecido para fun$$HEX2$$e700e300$$ENDHEX$$o "+ps_funcao+".~rC$$HEX1$$f300$$ENDHEX$$digo retorno da ECF "+String(pl_retorno)+"."
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
	lvs_Char = MidA(ps_texto,lvl_Char,1)
	If PosA(lvs_Ansi,lvs_Char) > 0 Then
		lvs_Retorno += MidA(ps_texto,lvl_Char,1)
	End If
Next

Return lvs_Retorno
end function

public function boolean of_data_hora_ecf (ref datetime pd_dataecf);If This.ivb_Modo_Teste Then Return True

String ls_Data
String ls_Hora
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Data = Space( 7 )
ls_Hora = Space( 7 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DataHoraImpressora(Ref ls_Data, Ref ls_Hora),'Bematech_FI_DataHoraImpressora')
	
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
	
	ls_Hora = MidA(ls_hora,01,02) + ":" + MidA(ls_hora,03,02) + ":" + MidA(ls_hora,5,02)
	
	pd_dataecf = DateTime(Date(ls_Data),Time(ls_Hora))
	
End If

Return lb_Sucesso
end function

public function boolean of_retorna_doc_aberto (ref long pl_doc);If This.ivb_Modo_Teste Then Return True

Integer li_Status
Long ll_Retorno

ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_StatusEstendidoMFD(Ref li_Status), 'Bematech_FI_StatusEstendidoMFD')

If ll_Retorno = 1 Then		
	if li_Status >= 128 then	
		li_Status = li_Status - 128	
	end if
	if li_Status >= 64 then	
		li_Status = li_Status - 64	
	end if
	if li_Status >= 32 then	
		li_Status = li_Status - 32	
	end if
	if li_Status >= 16 then	
		li_Status = li_Status - 16	
	end if
	if li_Status >= 8 then	
		li_Status = li_Status - 8	
	end if
	If li_Status >= 4 Then //RG
		li_Status = li_Status - 4
		pl_doc = 3
	End If		
	If li_Status >= 2 Then //CCD
		li_Status = li_Status - 2
		pl_doc = 2
	End If		
	If li_Status >= 1 Then //cupom n$$HEX1$$e300$$ENDHEX$$o fiscal
		li_Status = li_Status - 1
		pl_doc = 4
	End If
	
	If pl_doc = 3 Or pl_doc = 2 or pl_doc = 4 Then
		Return True
	End If
	
	If Not This.of_Verifica_Flags_Fiscais() Then Return False
	
	If This.ivl_Status = 1 or This.ivl_Status = 33 or This.ivl_Status = 35 or This.ivl_Status = 37 or This.ivl_Status = 39 Then
		pl_doc = 1
		Return True
	End If	
	If This.ivl_Status = 0 Or This.ivl_Status = 32 Then
		pl_doc = 0
		Return True
	End If	
Else
	Return False
End If

Return False


end function

public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final, string ps_arquivo);
If This.ivb_Modo_Teste Then Return True

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
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DownloadMFD(ls_Origem,ps_Tipo,ps_inicio,ps_final,'1'),'Bematech_FI_DownloadMFD')

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
	
		ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_FormatoDadosMFD(ls_Origem,ls_Destino,'0',ps_Tipo,ps_inicio,ps_final,'1'), 'Bematech_FI_FormatoDadosMFD')
		
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
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar arquivo " + ls_Destino ,StopSign!)
	gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar arquivo " + ls_Destino + ' uo_bematech - of_leitura_memoria_fita_detalhe')		
End If
	
Return False

end function

public function boolean of_gera_arquivo_mfd (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_caminho_mfd);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Row

FileDelete('C:\Download.MFD')
FileDelete('C:\Sistemas\CL\Arquivos\PAF-ECF\Download.MFD')

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ArquivoMFDPath(ps_origem,ps_endereco,ps_inicio,ps_final,ps_Tipo,'1',pl_tipo_geracao,PDV.ivs_ChavePublica,PDV.ivs_ChavePrivada,1),'Bematech_FI_ArquivoMFDPath')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			If FileExists('C:\Download.MFD') Then
				FileMove('C:\Download.MFD','C:\Sistemas\CL\Arquivos\PAF-ECF\Download.MFD')
			End If	
			ps_caminho_MFD = 'C:\Sistemas\CL\Arquivos\PAF-ECF\Download.MFD'
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

public function boolean of_gera_arquivo_cotepe_mensal (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_dir_mfd, boolean pb_gera_mfd, ref boolean pb_mfd_gerado);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_Row
String ls_arquivo_mfd

ls_arquivo_mfd = ps_dir_mfd + 'Download.MFD'

If pb_gera_mfd Then
	Filedelete(ls_arquivo_mfd)	
	//Gera binarios
	ll_retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DownloadMFD(ls_arquivo_mfd, '0', '','', '1'),'Bematech_FI_DownloadMFD')
	If ll_retorno <> 1 Then
		Return False
	End If	
	pb_mfd_gerado = True
Else
	pb_mfd_gerado = True	
End If

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ArquivoMFDPath(ls_arquivo_mfd,ps_endereco,ps_inicio,ps_final,ps_Tipo,'1',pl_tipo_geracao,PDV.ivs_ChavePublica,PDV.ivs_ChavePrivada,1),'Bematech_FI_ArquivoMFDPath')
	
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

public function boolean of_subtotal_cupom (ref string ps_subtotal);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_subtotal

ls_subtotal = Space( 15 )

SetPointer(HourGlass!)

Do While ll_Retry <= 3
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_SubTotal(Ref ls_subtotal), 'Bematech_FI_SubTotal')
	
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
Long ll_tipo_geracao
String ls_arquivo_mfd
String ls_tipo

ls_arquivo_mfd = ps_dir_mfd + 'Download.MFD'

Choose Case ps_tipo
	Case 'D'
		ls_tipo = '1'
	Case 'C'
		ls_tipo = '2'
	Case 'T'
		ls_tipo = '0'
End Choose

//0 = MF	1 = MFD	2 = TDM	3 = RZ	4 = RFD
Choose Case pl_tipo_geracao
	Case 0  //MF
		ll_tipo_geracao = 0
	Case 1 //MFD
		ll_tipo_geracao = 1
	case 3 //TDM
		ll_tipo_geracao = 2	
End Choose

//Gera binarios
ll_retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_DownloadMFD(ls_arquivo_mfd, ls_tipo, ps_inicio,ps_final, '1'),'Bematech_FI_DownloadMFD')
If ll_retorno <> 1 Then
	Return False
End If	

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(Bematech_FI_ArquivoMFDPath(ls_arquivo_mfd,ps_endereco,ps_inicio,ps_final,ps_Tipo,'1',ll_tipo_geracao,PDV.ivs_ChavePublica,PDV.ivs_ChavePrivada,1),'Bematech_FI_ArquivoMFDPath')
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			ps_arquivo_gerado = ls_arquivo_mfd
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

public function boolean of_verifica_arquivo_manutencao (ref boolean pb_existe_arquivo);String ls_Path_System
String ls_path_CL = 'C:\Sistemas\cl\exe'
String ls_path_RL = 'C:\Sistemas\rl\exe'
Boolean lb_existe
Boolean lb_sucesso = True
DateTime ldh_data_system
DateTime ldh_data_CL
DateTime ldh_data_RL

dc_uo_api lo_api
lo_api = Create dc_uo_api

If gvo_Aplicacao.of_is64bits() Then
	ls_Path_System = 'C:\Windows\SysWOW64'
Else
	ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
End If	

If FileExists(ls_Path_System + '\manutencao.xml') Then	
	ldh_data_system = lo_api.of_data_arquivo(ls_Path_System + '\manutencao.xml')
	lb_existe = True
End If

If FileExists(ls_path_RL + '\manutencao.xml') Then
	ldh_data_RL = lo_api.of_data_arquivo(ls_Path_RL + '\manutencao.xml')		
	lb_existe = True
End If
If FileExists(ls_path_CL + '\manutencao.xml') Then
	ldh_data_CL = lo_api.of_data_arquivo(ls_Path_CL + '\manutencao.xml')
	lb_existe = True
End If

If lb_existe Then	
	pb_existe_arquivo = True
	If (ldh_data_system > ldh_data_RL) And (ldh_data_system > ldh_data_CL) Then
		//move para pasta da aplicacao
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CL" Then				
			If Not lo_api.of_move_file(ls_Path_System + '\manutencao.xml', ls_Path_CL + '\manutencao.xml', true, true) Then lb_Sucesso = False
		End If
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" Then				
			If Not lo_api.of_move_file(ls_Path_System + '\manutencao.xml', ls_Path_RL + '\manutencao.xml', true, true) Then lb_Sucesso = False
		End If
	Else
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CL" Then	
			If ldh_data_RL > ldh_data_CL Then
				//copia do RL para pasta do CL
				FileDelete(ls_Path_CL + '\manutencao.xml')
				If Not lo_api.of_copy_file(ls_Path_RL + '\manutencao.xml', ls_Path_CL + '\manutencao.xml', true) Then lb_Sucesso = False
			End If
		End If
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" Then	
			If ldh_data_CL > ldh_data_RL Then
				//move do CL para pasta do RL
				FileDelete(ls_Path_RL + '\manutencao.xml')
				If Not lo_api.of_copy_file(ls_Path_CL + '\manutencao.xml', ls_Path_RL + '\manutencao.xml', true) Then lb_Sucesso = False										
			End If
		End If		
	End If
	//Exclui da pasta System
	If FileExists(ls_Path_System + '\manutencao.xml') Then
		FileDelete(ls_Path_System + '\manutencao.xml')
	End If	
Else
	pb_existe_arquivo = False
End If

Destroy(lo_api)

If lb_sucesso Then
	Return True
Else
	Return False
End If
end function

on uo_bematech.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_bematech.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_atualiza_dll_sign()
end event

