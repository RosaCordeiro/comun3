HA$PBExportHeader$uo_epson.sru
forward
global type uo_epson from nonvisualobject
end type
end forward

global type uo_epson from nonvisualobject
end type
global uo_epson uo_epson

type prototypes
FUNCTION Long EPSON_RelatorioFiscal_Abrir_Dia () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_RelatorioFiscal_Abrir_Dia;Ansi';
FUNCTION Long EPSON_Obter_Estado_Impressora (ref string sDados) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Estado_Impressora;Ansi';

//Grupo Porta
FUNCTION Long EPSON_Serial_Abrir_Porta ( long lVelocidade, integer iPorta ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Serial_Abrir_Porta;Ansi';
FUNCTION Long EPSON_Serial_Abrir_Fechar_Porta_CMD ( long lVelocidade, integer iPorta ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Serial_Abrir_Fechar_Porta_CMD;Ansi';
FUNCTION Long EPSON_Serial_Abrir_PortaAD (ref string sVelocidade, ref string sPorta ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Serial_Abrir_PortaAD;Ansi';
FUNCTION Long EPSON_Serial_Abrir_PortaEX() LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Serial_Abrir_PortaEX;Ansi';
FUNCTION Long EPSON_Serial_Fechar_Porta() LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Serial_Fechar_Porta;Ansi';
FUNCTION Long EPSON_Serial_Obter_Estado_Com() LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Serial_Obter_Estado_Com;Ansi';
//Grupo Cupom Fiscal
FUNCTION Long EPSON_Fiscal_Abrir_Cupom ( string sCPFCNPJ, String sNome, String sEndereco1, String sEndereco2, long lPosicao ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Abrir_Cupom;Ansi';
FUNCTION Long EPSON_Fiscal_Vender_Item ( string sCodigo, String sDescricao, String sQuantidade, Long lCasasQtd, String sUnidade, String sPreco, Long lCasasPreco, String sAliquota, Long lLinhas ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Vender_Item;Ansi';
FUNCTION Long EPSON_Fiscal_Vender_Item_AD ( string sCodigo, String sDescricao, String sQuantidade, Long lCasasQtd, String sUnidade, String sPreco, Long lCasasPreco, String sAliquota, Long lLinhas, Long lArrenda, Long lFabricacao ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Vender_Item_AD;Ansi';
FUNCTION Long EPSON_Fiscal_Obter_SubTotal ( Ref string sSubTotal ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Obter_SubTotal;Ansi';
FUNCTION Long EPSON_Fiscal_Pagamento ( string sPagamento, String sValor, Long lCasasDec, String sDescricao1, String sDescricao2 ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Pagamento;Ansi';
FUNCTION Long EPSON_Fiscal_Desconto_Acrescimo_Item ( string sDesconto, Long lCasasDec, Boolean bTipoDesc, Boolean bTipoPerc ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Desconto_Acrescimo_Item;Ansi';
FUNCTION Long EPSON_Fiscal_Desconto_Acrescimo_ItemEX ( String sItem, String sDesconto, Long lCasasDec, Boolean bTipoDesc, Boolean bTipoPerc ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Desconto_Acrescimo_ItemEX;Ansi';
FUNCTION Long EPSON_Fiscal_Desconto_Acrescimo_Subtotal ( String sDesconto, Long lCasasDec, Boolean bTipoDesc, Boolean bTipoPerc ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Desconto_Acrescimo_Subtotal;Ansi';
FUNCTION Long EPSON_Fiscal_Cancelar_Cupom() LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Cancelar_Cupom;Ansi';
FUNCTION Long EPSON_Fiscal_Cancelar_Item ( String sItem ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Cancelar_Item;Ansi';
FUNCTION Long EPSON_Fiscal_Cancelar_Ultimo_Item() LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Cancelar_Cupom;Ansi';
FUNCTION Long EPSON_Fiscal_Cancelar_Desconto_Acrescimo_Item( Boolean bAcrescDesc) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Cancelar_Desconto_Acrescimo_Item;Ansi';
FUNCTION Long EPSON_Fiscal_Cancelar_Desconto_Acrescimo_ItemEX( String sItem, Boolean bAcrescDesc) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Cancelar_Desconto_Acrescimo_ItemEX;Ansi';
FUNCTION Long EPSON_Fiscal_Cancelar_Acrescimo_Desconto_Subtotal( Boolean bAcrescDesc) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Cancelar_Acrescimo_Desconto_Subtotal;Ansi';
FUNCTION Long EPSON_Fiscal_Imprimir_Mensagem( String sLinha1, String sLinha2, String sLinha3, String sLinha4, &
																     String sLinha5, String sLinha6, String sLinha7, String sLinha8 ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Imprimir_Mensagem;Ansi';
FUNCTION Long EPSON_Fiscal_Imprimir_MensagemEX( String sMsg ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Imprimir_MensagemEX;Ansi';
FUNCTION Long EPSON_Fiscal_Configurar_Codigo_Barras_Mensagem( Long lLinha, Long lTipo, Long lAltura, Long lLargura, Long lPosicao, Long lLegenda) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Configurar_Codigo_Barras_Mensagem;Ansi';
FUNCTION Long EPSON_Fiscal_Fechar_Cupom( Boolean bCorta, Boolean bReImprime ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Fiscal_Fechar_Cupom;Ansi';
//Grupo comprovante n$$HEX1$$e300$$ENDHEX$$o fiscal
FUNCTION Long EPSON_NaoFiscal_Abrir_Comprovante ( String sCPFCNPJ, String sNome, String sEndereco1, String sEndereco2, long lPosicao ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Abrir_Comprovante;Ansi';
FUNCTION Long EPSON_NaoFiscal_Vender_Item ( String sOperacao, String sValor, Long lCasasDec ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Vender_Item;Ansi';
FUNCTION Long EPSON_NaoFiscal_Desconto_Acrescimo_Item ( String sDesconto, Long lCasasDec, Boolean bTipoDesc, Boolean bTipoPerc ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Desconto_Acrescimo_Item;Ansi';
FUNCTION Long EPSON_NaoFiscal_Desconto_Acrescimo_ItemEX ( String sItem, String sDesconto, Long lCasasDec, Boolean bTipoDesc, Boolean bTipoPerc ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Desconto_Acrescimo_ItemEX;Ansi';
FUNCTION Long EPSON_NaoFiscal_Desconto_Acrescimo_Subtotal ( String sDesconto, Long lCasasDec, Boolean bTipoDesc, Boolean bTipoPerc ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Desconto_Acrescimo_Subtotal;Ansi';
FUNCTION Long EPSON_NaoFiscal_Pagamento ( String sPagamento, String sValor, Long lCasasDec, String sLinha1, String sLinha2 ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Pagamento;Ansi';
FUNCTION Long EPSON_NaoFiscal_Cancelar_Item ( String sItem ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Cancelar_Item;Ansi';
FUNCTION Long EPSON_NaoFiscal_Cancelar_Ultimo_Item () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Cancelar_Ultimo_Item;Ansi';
FUNCTION Long EPSON_NaoFiscal_Cancelar_Desconto_Acrescimo_Item ( Boolean bTipo ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Cancelar_Desconto_Acrescimo_Item;Ansi';
FUNCTION Long EPSON_NaoFiscal_Cancelar_Desconto_Acrescimo_ItemEX ( String sItem, Boolean bTipo ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Cancelar_Desconto_Acrescimo_ItemEX;Ansi';
FUNCTION Long EPSON_NaoFiscal_Cancelar_Desconto_Acrescimo_Subtotal ( Boolean bTipo ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Cancelar_Desconto_Acrescimo_Subtotal;Ansi';
FUNCTION Long EPSON_NaoFiscal_Cancelar_Comprovante () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Cancelar_Comprovante;Ansi';
FUNCTION Long EPSON_NaoFiscal_Fechar_Comprovante ( Boolean bCortar ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Fechar_Comprovante;Ansi';
FUNCTION Long EPSON_NaoFiscal_Abrir_CCD ( String sPagamento, String sValor, Long lCasasDec, String sParcelas ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Abrir_CCD;Ansi';
FUNCTION Long EPSON_NaoFiscal_Abrir_Relatorio_Gerencial ( String sRelatorio ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Abrir_Relatorio_Gerencial;Ansi';
FUNCTION Long EPSON_NaoFiscal_Imprimir_LinhaEX ( String sTexto ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Imprimir_LinhaEX;Ansi';
FUNCTION Long EPSON_NaoFiscal_Imprimir_Linha ( String sLinha ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Imprimir_Linha;Ansi';
FUNCTION Long EPSON_NaoFiscal_Fechar_CCD ( Boolean bCortar ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Fechar_CCD;Ansi';
FUNCTION Long EPSON_NaoFiscal_Fechar_Relatorio_Gerencial ( Boolean bCortar ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Fechar_Relatorio_Gerencial;Ansi';
FUNCTION Long EPSON_NaoFiscal_Cancelar_CCD ( String sPagamento, String sValor, Long lCasaDec, String sParcelas, String sCOO ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Cancelar_CCD;Ansi';
FUNCTION Long EPSON_NaoFiscal_Cancelar_Pagamento ( String sPagamentoCanc, String sPagamentoAdd, String sValor, Long lCasaDec ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Cancelar_Pagamento;Ansi';
FUNCTION Long EPSON_NaoFiscal_Nova_Via_CCD () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Nova_Via_CCD;Ansi';
FUNCTION Long EPSON_NaoFiscal_Reimprimir_CCD () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Reimprimir_CCD;Ansi';
FUNCTION Long EPSON_NaoFiscal_Sangria ( String sValor, Long sCasasDec ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Sangria;Ansi';
FUNCTION Long EPSON_NaoFiscal_Fundo_Troco ( String sValor, Long sCasasDec ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Fundo_Troco;Ansi';
FUNCTION Long EPSON_NaoFiscal_Imprimir_Codigo_Barras ( Long lTipo, Long lAltura, Long lLargura, Long lPosicao, Long lCaracter, String sCodigo ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Imprimir_Codigo_Barras;Ansi';
FUNCTION Long EPSON_NaoFiscal_Obter_SubTotal ( Ref String sValor ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_NaoFiscal_Obter_SubTotal;Ansi';
//Grupo Relatorios ECF
FUNCTION Long EPSON_RelatorioFiscal_LeituraX () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_RelatorioFiscal_LeituraX;Ansi';
FUNCTION Long EPSON_RelatorioFiscal_RZ ( String sData, String sHora, Long lVerao, Ref String sCRZ ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_RelatorioFiscal_RZ;Ansi';
FUNCTION Long EPSON_RelatorioFiscal_RZEX ( Long lVerao ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_RelatorioFiscal_RZEX;Ansi';
FUNCTION Long EPSON_RelatorioFiscal_Leitura_MF ( String sInicio, String sFim, Long lTipo, String sDadosMF, String sArquivo, Ref Long lBytes, Ref Long lTamBytes ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_RelatorioFiscal_Leitura_MF;Ansi';
FUNCTION Long EPSON_RelatorioFiscal_Salvar_LeituraX ( String sArquivo ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_RelatorioFiscal_Salvar_LeituraX;Ansi';
FUNCTION Long EPSON_RelatorioFiscal_Abrir_Jornada () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_RelatorioFiscal_Abrir_Jornada;Ansi';
//Grupo informa$$HEX2$$e700f500$$ENDHEX$$es ECF
FUNCTION Long EPSON_Obter_Dados_Usuario ( Ref String sDados ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Dados_Usuario;Ansi';
FUNCTION Long EPSON_Obter_Tabela_Aliquotas ( Ref String sAliquotas ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Tabela_Aliquotas;Ansi';
FUNCTION Long EPSON_Obter_Tabela_Aliquotas_Cupom ( Ref String sAliquotas, Ref String sICMS, Ref String sISS ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Tabela_Aliquotas_Cupom;Ansi';
FUNCTION Long EPSON_Obter_Tabela_Pagamentos ( Ref String sPagamentos ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Tabela_Pagamentos;Ansi';
FUNCTION Long EPSON_Obter_Tabela_NaoFiscais ( Ref String sTotalizadores ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Tabela_NaoFiscais;Ansi';
FUNCTION Long EPSON_Obter_Tabela_Relatorios_Gerenciais ( Ref String sGerenciais ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Tabela_Relatorios_Gerenciais;Ansi';
FUNCTION Long EPSON_Obter_Total_Cancelado ( Ref String sCancelado ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Total_Cancelado;Ansi';
FUNCTION Long EPSON_Obter_Total_Aliquotas ( Ref String sTotalAliq ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Total_Aliquotas;Ansi';
FUNCTION Long EPSON_Obter_Total_Bruto ( Ref String sTotalBruto ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Total_Bruto;Ansi';
FUNCTION Long EPSON_Obter_Total_Descontos ( Ref String sTotalDesconto ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Total_Descontos;Ansi';
FUNCTION Long EPSON_Obter_Total_Acrescimos ( Ref String sTotalAcresc ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Total_Acrescimos;Ansi';
FUNCTION Long EPSON_Obter_Total_Troco ( Ref String sTotalTroco ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Total_Troco;Ansi';
FUNCTION Long EPSON_Obter_Venda_Liquida_ICMS ( Ref String sTotalLiqICMS ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Venda_Liquida_ICMS;Ansi';
FUNCTION Long EPSON_Obter_Total_ICMS ( Ref String sTotalICMS ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Total_ICMS;Ansi';
FUNCTION Long EPSON_Obter_Dados_Impressora ( Ref String sDados ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Dados_Impressora;Ansi';
FUNCTION Long EPSON_Obter_Cliche_Usuario ( Ref String sDados ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Cliche_Usuario;Ansi';
FUNCTION Long EPSON_Obter_Data_Hora_Jornada ( Ref String sDataHoraFiscal ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Data_Hora_Jornada;Ansi';
FUNCTION Long EPSON_Obter_Numero_ECF_Loja ( Ref String sECF ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Numero_ECF_Loja;Ansi';
FUNCTION Long EPSON_Obter_Hora_Relogio ( Ref String sDataHora ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Hora_Relogio;Ansi';
FUNCTION Long EPSON_Obter_Contadores ( Ref String sContadores ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Contadores;Ansi';
FUNCTION Long EPSON_Obter_Estado_ImpressoraEX ( Ref String sEstadoECF, Ref String sFiscal, Ref String sRetorno, Ref String sErro ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Estado_ImpressoraEX;Ansi';
FUNCTION Long EPSON_Obter_GT ( Ref String sGT ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_GT;Ansi';
FUNCTION Long EPSON_Obter_Dados_Jornada ( Ref String sJornada ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Dados_Jornada;Ansi';
FUNCTION Long EPSON_Obter_Operador ( Ref String sOperador ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Operador;Ansi';
FUNCTION Long EPSON_Obter_Numero_Ultimo_Item ( Ref String sItem ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Numero_Ultimo_Item;Ansi';
FUNCTION Long EPSON_Obter_Estado_Cupom ( Ref String sEstadoCupom ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Estado_Cupom;Ansi';
FUNCTION Long EPSON_Obter_Informacao_Ultimo_Documento ( Ref String sInformacao ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Informacao_Ultimo_Documento;Ansi';
FUNCTION Long EPSON_Obter_Estado_Memoria_Fiscal ( Ref String sMemoria ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Estado_Memoria_Fiscal;Ansi';
FUNCTION Long EPSON_Obter_Estado_MFD ( Ref String sMFD ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Estado_MFD;Ansi';
FUNCTION Long EPSON_Obter_Venda_Bruta ( Ref String sBrutaAtual, Ref String sBrutaAnterior ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Venda_Bruta;Ansi';
FUNCTION Long EPSON_Obter_Mensagem_Erro ( String sCodErro, Ref String sMsgErro ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Mensagem_Erro;Ansi';
FUNCTION Long EPSON_Obter_Dados_MF_MFD ( String sInicio, String sFIm, Long lTipo, Long lEspelho, Long lTipoAto, Long lSintegra, String sArquivo ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Dados_MF_MFD;Ansi';
FUNCTION Long EPSON_Obter_Dados_Arquivos_MF_MFD ( String sInicio, String sFIm, Long lTipo, Long lEspelho, Long lTipoAto, Long lSintegra, String sArquivo, String sArquivoMF, String sArquivoMFD ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Dados_Arquivos_MF_MFD;Ansi';
FUNCTION Long EPSON_Obter_Dados_MF_MFD_Progresso ( String sInicio, String sFIm, Long lTipo, Long lEspelho, Long lTipoAto, Long lSintegra, String sArquivo, Ref String sProgresso ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Dados_MF_MFD_Progresso;Ansi';
FUNCTION Long EPSON_Obter_Versao_DLL ( Ref String sVersao ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Versao_DLL;Ansi';
FUNCTION Long EPSON_Obter_Total_JornadaEX ( String sICMSISS, String sCRZ, Ref String sJornada ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Total_JornadaEX;Ansi';
FUNCTION Long EPSON_Obter_Dados_Ultima_RZ ( Ref String sDados ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Dados_Ultima_RZ;Ansi';
FUNCTION Long EPSON_Obter_Arquivos_Binarios ( String sInicio, String sFIm, Long lTipo, String sArquivoMF, String sArquivoMFD ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Arquivos_Binarios;Ansi';
FUNCTION Long EPSON_Obter_Arquivo_Binario_MF ( String sArquivo ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Arquivo_Binario_MF;Ansi';
FUNCTION Long EPSON_Obter_Arquivo_Binario_MFD ( String sArquivo ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Arquivo_Binario_MFD;Ansi';
FUNCTION Long EPSON_Obter_Versao_SWBasicoEX ( Ref String sVersao, Ref String sData, Ref String sHora ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Versao_SWBasicoEX;Ansi';
FUNCTION Long EPSON_Obter_Codigo_Nacional_ECF ( Ref String sCodigo, Ref String sNomeArquivo ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Codigo_Nacional_ECF;Ansi';
FUNCTION Long EPSON_Obter_Numero_Usuario ( Ref String sNumeroUsuario ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Numero_Usuario;Ansi';
FUNCTION Long EPSON_Obter_Log_Comandos ( Ref String sLog, Ref String sBytes ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Log_Comandos;Ansi';
FUNCTION Long EPSON_Obter_Linhas_Impressas_RG ( Ref String sLinhas ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Linhas_Impressas_RG;Ansi';
FUNCTION Long EPSON_Obter_Linhas_Impressas ( Ref String sLinhas ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Obter_Linhas_Impressas;Ansi';
//Grupo configura$$HEX2$$e700e300$$ENDHEX$$o ECF
FUNCTION Long EPSON_Config_Aliquota ( String sValorAliquota, Boolean bTipo ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Aliquota;Ansi';
FUNCTION Long EPSON_Config_Relatorio_Gerencial ( String sRelatorio ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Relatorio_Gerencial;Ansi';
FUNCTION Long EPSON_Config_Forma_Pagamento ( Boolean bTipoVinculo, String sNumero, String sDesc ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Forma_Pagamento;Ansi';
FUNCTION Long EPSON_Config_Forma_PagamentoEX ( Boolean bTipoVinculo, String sDesc ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Forma_PagamentoEX;Ansi';
FUNCTION Long EPSON_Config_Totalizador_NaoFiscal ( String sDesc, Ref Long lTotalizador ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Totalizador_NaoFiscal;Ansi';
FUNCTION Long EPSON_Config_Horario_Verao () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Horario_Verao;Ansi';
FUNCTION Long EPSON_Config_Espaco_Entre_Documentos ( String sNumeroLinhas ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Espaco_Entre_Documentos;Ansi';
FUNCTION Long EPSON_Config_Espaco_Entre_Linhas ( String sEspacoLinhas ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Espaco_Entre_Linhas;Ansi';
FUNCTION Long EPSON_Config_Operador ( String sNomeOperador ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Operador;Ansi';
FUNCTION Long EPSON_Config_Corte_Papel ( Boolean bCorte ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Corte_Papel;Ansi';
FUNCTION Long EPSON_Config_Dados_Sintegra ( String sRazaoSocial, String sRua, String sNumero, String sComp, String sBairro, String sMun, String sCEP, String sUF, String sFaz, String sFone, String sContato ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Dados_Sintegra;Ansi';
FUNCTION Long EPSON_Config_Habilita_PAFECF_Auto ( Long lHabilita ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Habilita_PAFECF_Auto;Ansi';
FUNCTION Long EPSON_Config_Dados_PAFECF ( String sCNPJ, String sIE, String sIM, String sNome, String sNomePAF, String sVersaoPAF, String sMD5, String sVerER ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Dados_PAFECF;Ansi';
FUNCTION Long EPSON_Config_Mensagem_Aplicacao ( String sLinha1, String sLinha2 ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Mensagem_Aplicacao;Ansi';
FUNCTION Long EPSON_Config_Mensagem_Aplicacao_Auto ( String sLinha1, String sLinha2 ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Mensagem_Aplicacao_Auto;Ansi';
FUNCTION Long EPSON_Config_Habilita_EAD ( Boolean bStatusHabilitaEAD ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Config_Habilita_EAD;Ansi';
//Grupo impressora
FUNCTION Long EPSON_Impressora_Abrir_Gaveta () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Impressora_Abrir_Gaveta;Ansi';
FUNCTION Long EPSON_Impressora_Cortar_Papel () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Impressora_Cortar_Papel;Ansi';
FUNCTION Long EPSON_Impressora_Avancar_Papel () LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Impressora_Avancar_Papel;Ansi';
FUNCTION Long EPSON_Sys_Bloquear_Entradas ( Boolean bBloqueia ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Sys_Bloquear_Entradas;Ansi';
FUNCTION Long EPSON_Sys_Log ( String sCaminho, Long lAcao ) LIBRARY 'C:\sistemas\dll\epson\InterfaceEpson.dll' alias for 'EPSON_Sys_Log;Ansi';
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
BOOLEAN ivb_cupom_aberto = FALSE

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
STRING ivs_Velocidade_Porta

DATETIME dh_SWBasico
DATETIME dh_ultima_venda

DECIMAL pc_Livre_mfd
end variables

forward prototypes
public function boolean of_abreporta ()
public function boolean of_porta_comunicacao ()
public function boolean of_leiturax ()
public function long of_verifica_retorno_ecf (long pl_retorno, string ps_funcao, boolean pb_mostra_aviso)
public function boolean of_abertura_dia ()
public function boolean of_abre_gaveta ()
public function boolean of_atualiza_cadastro_ecf ()
public function boolean of_nr_ecf (ref long pl_ecf)
public function boolean of_numero_serie ()
public function boolean of_atualiza_drivers ()
public function boolean of_atualiza_numero_seriemfd ()
public function boolean of_atualiza_venda_bruta ()
public function string of_encripta (string ps_texto)
public function boolean of_grande_total (ref decimal pdc_venda)
public function boolean of_cancela_cupom ()
public function boolean of_cancela_item (integer pl_item)
public function boolean of_cancela_item_anterior ()
public function boolean of_cancela_recebimento_nao_fiscal ()
public function boolean of_data_ultimo_documento (ref datetime pd_data)
public function boolean of_contador_operacao_nao_fiscal (ref long pl_contador)
public function boolean of_codigo_barras (integer pl_tipo, string ps_codigo, string ps_tamanho)
public function boolean of_conecta_impressora ()
public function boolean of_configuracoes ()
public function boolean of_contador_credito_debito (ref long pl_contador)
public function boolean of_contador_cupom_fiscal (ref long pl_contador)
public function boolean of_contador_relatorio_gerencial (ref long pl_contador)
public function boolean of_dados_impressora (ref long pl_sequencial, ref long pl_ecf)
public function boolean of_nr_cupom (ref long pl_sequencial)
public function boolean of_data_hora_ecf (ref datetime pdt_data)
public function boolean of_horaecf (ref string ps_hora)
public function boolean of_dataecf (ref date pd_dataecf)
public function boolean of_data_hora_usuario_software_basico ()
public function boolean of_data_ultima_reducaoz (ref date pdt_data)
public function boolean of_datafiscal (ref date pd_datafiscal)
public function boolean of_desconto_cupom (string ps_texto, decimal pd_valor)
public function boolean of_desconto_item (long pl_item, decimal pdc_desconto, decimal pdc_valor)
public function datetime of_dh_movimentacao ()
public function boolean of_efetua_recebimento_nao_fiscal (string ps_tipo, string ps_valor)
public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor)
public function boolean of_verifica_problemas_impressora ()
public function boolean of_impressora_online ()
public function boolean of_verifica_cupons_pendentes ()
public subroutine of_msg_cupom_aberto ()
public function boolean of_fecha_comprovante_tef ()
public function boolean of_fecha_relatorio_gerencial ()
public function boolean of_verifica_data_movimentacao ()
public function boolean of_sangria_caixa (decimal pdc_valor)
public function boolean of_suprimento_caixa (decimal pdc_valor)
public function boolean of_inicializa_relatorio_gerencial (string ps_relatorio, decimal pdc_valor)
public function boolean of_pergunta_tentativa (boolean pvb_abrindo)
public function boolean of_imprime_relatorio_gerencial (string ps_texto[], string ps_tipo)
public function string of_normaliza_texto (string ps_texto)
public function boolean of_fecha_cupom (string ps_msg[], boolean pb_repete, string ps_indicadores[6, 2], string ps_vinculado)
public function boolean of_fecha_cupom_nao_fiscal ()
public function string of_formata_valor_pafecf (decimal pdc_valor, long pl_inteiro, long pl_decimal)
public function boolean of_grava_log_ecf ()
public function boolean of_grava_mapa_resumo (date pdh_data)
public function string of_indicador_aliquota (decimal pd_aliquota, string ps_tributacao_icms)
public function boolean of_inicializa_comprovante_nao_fiscal (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor)
public function string of_meio_pagamento (string ps_pagamento)
public function boolean of_inicializa_recebimento_nao_fiscal ()
public function boolean of_registra_documento_ecf (string ps_documento, string ps_totalizador, decimal pdc_valor)
public function boolean of_fecha_recebimento_nao_fiscal (string ps_texto)
public function boolean of_inicializa_comprovante_tef (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor, string ps_cupom)
public function boolean of_registra_documento_ecf (string ps_documento, decimal pdc_valor)
public function boolean of_inicializa_comprovante_tef_nao_fiscal (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor)
public function boolean of_inicializa_cupom (string ps_cpf_cgc)
public function boolean of_marca_modelo_tipo ()
public function boolean of_percentual_livre_mfd ()
public function boolean of_pergunta_impressora_offline ()
public function boolean of_permite_cancelamento_cupom ()
public function boolean of_recebimento_nao_fiscal (string ps_tipo, string ps_valor)
public function boolean of_reducaoz ()
public function boolean of_registra_documento_ecf (string ps_documento)
public function boolean of_registra_item_vendido (string ps_produto, long pl_qtde, decimal pdc_precounit, decimal pdc_precotot, string ps_descricao, decimal pdc_aliquota, string ps_complemento, string ps_tributacao_icms)
public function boolean of_texto_nao_fiscal_tef (string ps_texto)
public function boolean of_totaliza_cupom (string ps_tipo[], decimal pd_valor[])
public function boolean of_valor_pago_ultimo_cupom (decimal pdc_valor)
public function boolean of_venda_bruta (ref decimal pdc_venda)
public function boolean of_verifica_drivers ()
public function boolean of_verifica_ultimo_mapa_resumo ()
public function boolean of_verifica_venda_bruta_diaria ()
public function string of_desencripta (string ps_texto)
public function string of_centraliza_texto (string ps_texto)
public function boolean of_texto_relatorio_gerencial (string ps_texto)
public function boolean of_mapa_resumo (ref s_ge039_mapa_resumo ps_mapa_resumo)
public function boolean of_programa_aliquota (boolean pb_automatico, decimal pdc_aliquota, long pl_tipo, boolean pb_mostra_mensagem)
public function boolean of_leitura_memoria_fiscal (string ps_inicio, string ps_final, boolean pb_arquivo, string ps_tipo)
public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final)
public function boolean of_retorna_doc_aberto (ref long pl_doc)
public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final, string ps_arquivo)
public function boolean of_gera_arquivo_mfd (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_caminho_mfd)
public function boolean of_gera_arquivo_cotepe_mensal (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, string ps_dir_mfd, boolean pb_gera_mfd, ref boolean pb_mfd_gerado)
public function boolean of_subtotal_cupom (ref string ps_subtotal)
public function boolean of_gera_arquivos_ecf (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_espelhos, long pl_tipo_geracao, string ps_dir_mfd, ref string ps_arquivo_gerado)
public function boolean of_totaliza_recebimento_nao_fiscal (string ps_pagamento, string ps_valor, string ps_descricao)
end prototypes

public function boolean of_abreporta ();If This.ivb_modo_teste or This.ivb_Porta_Aberta 	Then Return True

//of_Porta_Comunicacao()
long ll_Retorno
String ls_velocidade
String ls_porta

ls_velocidade = Space(7)
ls_porta = Space(2)

ll_retorno = of_Verifica_Retorno_ECF(EPSON_Serial_Abrir_PortaAD(Ref ls_velocidade, Ref ls_porta), 'EPSON_Serial_Abrir_PortaAD', False)

If ll_retorno <> 1 Then Return False

This.ivb_Porta_Aberta = True
If IsValid(PDV) Then
	PDV.ivb_Porta_Aberta = True
	
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
	
End If

If Not This.of_Numero_Serie()           				Then Return False

If Not This.of_Conecta_Impressora()     				Then Return False

//If Not This.of_Impressora_online() 						Then Return False

//This.of_Configuracoes()

//If Not This.of_Verifica_Venda_Bruta_Diaria()			Then Return False

//If This.ivb_ReducaoZ Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A ECF conectada est$$HEX1$$e100$$ENDHEX$$ configurada para gerar Redu$$HEX2$$e700e300$$ENDHEX$$oZ automaticamente." + &
//	           "~n~nO PDV poder$$HEX1$$e100$$ENDHEX$$ ser utilizado normalmente para emiss$$HEX1$$e300$$ENDHEX$$o de cupons fiscais, por$$HEX1$$e900$$ENDHEX$$m $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio" + &
//				  " contactar imediatamente suporte.",Exclamation!)
//End If	

Return True
end function

public function boolean of_porta_comunicacao ();String lvs_INI,&
       lvs_Porta
//
//lvs_INI  = gvo_Aplicacao.ivs_Arquivo_INI
//
//// Verifica se o caminho dos arquivos de ajuda est$$HEX1$$e300$$ENDHEX$$o especificados no INI
//lvs_Porta = ProfileString(lvs_INI, "ECF", "Porta","")
//
//If Not IsNumber(lvs_Porta) Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de configura$$HEX2$$e700e300$$ENDHEX$$o : " + lvs_INI + '~n~nN$$HEX1$$e300$$ENDHEX$$o possui par$$HEX1$$e200$$ENDHEX$$metros~n~n[ECF]~nPorta=', StopSign! )
//	Return False
//End If
//
//This.Porta = Long(lvs_Porta)

String ls_Porta		 
Long ll_Retorno

ls_Porta             = Space(2)
ivs_Velocidade_Porta = Space(6)

ll_Retorno = EPSON_Serial_Abrir_PortaAD(ref ivs_Velocidade_Porta , ref ls_Porta )
This.Porta = Long(ls_Porta)

Return True
end function

public function boolean of_leiturax ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Tentativas = 0
DateTime ldt_data

This.of_data_hora_ecf(Ref ldt_Data)

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)
	ll_Retorno = This.of_verifica_retorno_ecf(EPSON_RelatorioFiscal_LeituraX(), 'EPSON_RelatorioFiscal_LeituraX', True)
	ll_Tentativas++
Loop

If ll_Retorno = 1 Then
	PDV.of_atualiza_primeira_venda_ecf(This.ECF, ldt_data, True)	
	Return True
Else
	Return False
End If
end function

public function long of_verifica_retorno_ecf (long pl_retorno, string ps_funcao, boolean pb_mostra_aviso);String ls_Msg = ''
String ls_EstadoImpressora
String ls_EstadoFiscal
String ls_comando
String ls_erro

Long ll_Retorno = -1
Long ll_Ret
Long ll_cont

//For  ll_cont = 1 to 17
//	ls_EstadoImpressora [ll_cont] = Space(1)
//Next
//ll_cont = 0
//For  ll_cont = 1 to 17
//	ls_EstadoFiscal [ll_cont] = Space(1)
//Next
//ll_cont=0
//For  ll_cont = 1 to 5
//	ls_EstadoFiscal [ll_cont] = Space(1)
//Next
//

ls_EstadoImpressora 	= Space(17)
ls_EstadoFiscal 		= Space(17)
ls_Comando 			= Space(5)
ls_Erro 					= Space(101)

ll_Ret = EPSON_Obter_Estado_ImpressoraEX(Ref ls_EstadoImpressora, Ref ls_EstadoFiscal, Ref ls_Comando, Ref ls_Erro)

Choose Case ll_ret
	Case 0
		If pl_retorno = 0 Then //Sucesso
			//ll_Retorno = 1
			If MidA(ls_EstadoImpressora,16,1) = '1' And pb_mostra_aviso Then
				MessageBox("Impressora Fiscal", "Papel Acabando!")
			End If
			
			Return 1
		Else
			//ECF
			If MidA(ls_EstadoImpressora,1,1) = '1' Then
				ls_msg += 'Impressora OFF line. '
			End If			
			If MidA(ls_EstadoImpressora,2,1) = '1' Then
				ls_msg += 'Erro de impress$$HEX1$$e300$$ENDHEX$$o. '
			End If
			If MidA(ls_EstadoImpressora,15,1) = '1' Then
				ls_msg += 'Sem Papel. '
			End If
			If MidA(ls_EstadoImpressora,16,1) = '1' Then
				//Papel acabando
			End If
			//Fiscal
			If MidA(ls_EstadoFiscal,4,1) = '1' Then
				ls_msg += 'Impressora em interven$$HEX2$$e700e300$$ENDHEX$$o tecnica. '
			End If			
			If MidA(ls_EstadoFiscal,5,1) = '0' And MidA(ls_EstadoFiscal,6,1) = '1' Then
				ls_msg += 'Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal em esgotamento. '
			End If
			If MidA(ls_EstadoFiscal,5,1) = '1' And MidA(ls_EstadoFiscal,6,1) = '0' Then
				ls_msg += 'Mem$$HEX1$$e100$$ENDHEX$$ria Cheia. '
			End If
			If MidA(ls_EstadoFiscal,5,1) = '1' And MidA(ls_EstadoFiscal,6,1) = '1' Then
				ls_msg += 'Erro na mem$$HEX1$$f300$$ENDHEX$$ria. '
			End If			
			If MidA(ls_EstadoFiscal,9,1) = '0' Then
				ls_msg += 'Per$$HEX1$$ed00$$ENDHEX$$odo de venda fechado. '
			End If
			If MidA(ls_EstadoFiscal,13,1) = '0' And MidA(ls_EstadoFiscal,14,1) = '0' And MidA(ls_EstadoFiscal,15,1) = '0' And MidA(ls_EstadoFiscal,16,1) = '1' Then
				//cupom fiscal aberto
			End If
			
			If ls_Comando <> '0000' Then
				ls_msg += 'Erro: ' + ls_comando + ' Descri$$HEX2$$e700e300$$ENDHEX$$o: ' + ls_erro
			End If
					
			
		End If
	Case Else
		ls_Msg = "Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o com o ECF. "+ps_funcao
End Choose

If Trim(ls_Msg)<>'' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg,StopSign!)
	gvo_aplicacao.of_grava_log(ls_Msg)
End If

Return ll_Retorno
end function

public function boolean of_abertura_dia ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

Return True
 

end function

public function boolean of_abre_gaveta ();Long ll_Retorno

ll_Retorno = This.of_verifica_retorno_ecf(EPSON_Impressora_Abrir_Gaveta(), 'EPSON_Impressora_Abrir_Gaveta', False)

If ll_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_atualiza_cadastro_ecf ();STRING ls_Marca, &
		 ls_Modelo, &
		 ls_Tipo, &
		 ls_CPD, &
		 ls_Serie, &
		 ls_cniie

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
				  dh_referencia_arquivo_mfd)
		Values (:This.ECF,
				  :ls_Serie,   
				  'L',   
				  :ls_marca,   
				  :ls_modelo,
				  :This.nr_Serie_MFD,
				  :This.de_Tipo,
				  :ldt_data_ecf)
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
			(Trim(ls_Tipo) = '' Or IsNull(ls_Tipo)) Then
			
			ls_Marca = LeftA(This.de_marca,15)
			ls_modelo = LeftA(This.de_modelo,15)			
	
			Update impressora_fiscal
			Set de_fabricante = :This.de_Marca,
				 de_modelo		= :This.de_Modelo,
				 de_tipo			= :This.de_Tipo
			Where nr_ecf 		= :This.Ecf	 
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				gvo_aplicacao.of_grava_log("Erro ao atualizar Marca/Modelo/Tipo ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_daruma.of_atualiza_cadastro_ecf()."+SQLCA.SQLErrText)	
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

public function boolean of_nr_ecf (ref long pl_ecf);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Caixa
String ls_Cupom

SetPointer(HourGlass!)

ls_Caixa = Space(8)

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Numero_ECF_Loja(Ref ls_Caixa),'EPSON_Obter_Numero_ECF_Loja', False)
		
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			ls_Caixa = MidA(ls_Caixa,1,3)			
			pl_ecf = Long(ls_Caixa)
			
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

public function boolean of_numero_serie ();Long ll_Retorno

String ls_Serie_MFD, ls_Serie, ls_dados
Long ll_Tentativas = 0

If Not This.of_nr_ecf(Ref This.ECF) Then Return False

ls_dados = Space(109)
	
ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Impressora(Ref ls_dados),'EPSON_Obter_Dados_Impressora', False)
	
Choose Case ll_Retorno
	Case 1 				// Comando OK
		This.nr_serie = Trim(LeftA(ls_Dados,20))
		This.nr_serie_MFD = Trim(LeftA(ls_Dados,20))
		This.de_modelo = Trim(MidA(ls_Dados,73,20))
		This.de_marca = Trim(MidA(ls_dados,56,16))
		This.de_Tipo = Trim(MidA(ls_dados,94,7))
		This.nr_versao_swbasico = Trim(MidA(ls_dados,101,8))
		Return True
	Case Else
		Return False
End Choose

end function

public function boolean of_atualiza_drivers ();
Boolean	lb_Sucesso 		= True
Boolean	lb_Existe 		= False

String	ls_Path_System
String	ls_Path
String ls_Error
String	ls_Path_dll = 'C:\sistemas\dll\epson'

String	ls_Versao
String	ls_Valor
String ls_Baixar[]
String ls_Validar[]
String ls_arquivos[]
String ls_arquivo

Long ll_arquivo
Long ll_File

ls_Validar = {"INTERFACEEPSON.DLL"}
ls_Baixar  = {'epson.zip'}

If gvo_Aplicacao.of_is64bits() Then
	ls_Path_System = 'C:\Windows\SysWOW64'
Else
	ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
End If	

dc_uo_api lo_api
lo_api = Create dc_uo_api

If FileExists(ls_Path_System + "\InterfaceEpson.dll")  And lb_Sucesso Then
	
	If Not FileExists(ls_Path_dll) Then
		lo_Api.of_Create_Directory(ls_Path_dll)
	End If	
	//Move para diretorio das dlls	
	If Not lo_api.of_move_file(ls_Path_System + '\InterfaceEpson.dll', ls_Path_dll + '\InterfaceEpson.dll', true, true) Then lb_Sucesso = False
	
End If
	
If Not FileExists(ls_Path_dll + "\InterfaceEpson.dll") And lb_Sucesso Then			
	lb_Sucesso = gf_Download_Matriz(ls_Validar, ls_Baixar, ls_Path_dll, "dll_epson", True)
End If

destroy(lo_api)

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
	Sqlca.of_MsgDbError('Data Ultima Venda ECF no sistema.')
	gvo_aplicacao.of_grava_log("Erro ao localizar data $$HEX1$$fa00$$ENDHEX$$ltima venda ECF no sistema, fun$$HEX2$$e700e300$$ENDHEX$$o uo_epson.of_atualiza_numero_seriemfd()."+Sqlca.SQLErrText)	
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
	gvo_aplicacao.of_grava_log("Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_epson.of_atualiza_numero_seriemfd()."+Sqlca.SQLErrText)		
Else			
	Sqlca.of_Commit()
	lvb_Sucesso = True
End If	

Return lvb_Sucesso
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

public function boolean of_grande_total (ref decimal pdc_venda);If This.ivb_Modo_Teste Then Return True

String ls_Valor
Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Valor = Space(19)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_GT(Ref ls_Valor),'ECF_GrandeTotal', False)
	
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

public function boolean of_cancela_cupom ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

 ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Fiscal_Cancelar_Cupom(),'EPSON_Fiscal_Cancelar_Cupom', true)

If ll_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_cancela_item (integer pl_item);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
String ls_item

ls_item = String(pl_item)
	
ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Fiscal_Cancelar_Item(ls_item),'EPSON_Fiscal_Cancelar_Item', false)
	
If ll_retorno = 1 Then
	This.of_Atualiza_Venda_Bruta()
Else
	Return False
End If
end function

public function boolean of_cancela_item_anterior ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
	
ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Fiscal_Cancelar_Ultimo_Item(),'EPSON_Fiscal_Cancelar_Ultimo_Item', false)
	
If ll_retorno = 1 Then
	This.of_Atualiza_Venda_Bruta()
	Return True
Else
	Return False
End If
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

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Cancelar_Comprovante(), 'EPSON_NaoFiscal_Cancelar_Comprovante', True)

If ll_Retorno = 1 Then
	lb_Sucesso = True
	
	Update documento_ecf
	Set id_estorno = 'S'
	Where dh_movimento = :ldh_Emissao
	  and nr_ecf       = :This.ECF
	  and nr_gnf       = :ll_gnf
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_RollBack()
		Sqlca.of_MsgDbError('Estorno de recebimento n$$HEX1$$e300$$ENDHEX$$o fiscal')
		gvo_aplicacao.of_grava_log("Erro no estorno de recebimento n$$HEX1$$e300$$ENDHEX$$o fiscal, fun$$HEX2$$e700e300$$ENDHEX$$o uo_epson.of_cancela_recebimento_nao_fiscal()."+SQLCA.SQLErrText)	
	Else
		Sqlca.of_Commit()
	End If	
End If
					
If IsValid(w_Janela_Aguarde) Then Close(w_Janela_Aguarde)

SetPointer(HourGlass!)

Return lb_Sucesso
end function

public function boolean of_data_ultimo_documento (ref datetime pd_data);If This.ivb_Modo_Teste Then Return True

String ls_dados

Long   ll_Retorno
Boolean lb_sucesso

ls_dados = Space(31)

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Informacao_Ultimo_Documento(Ref ls_Dados),'EPSON_Obter_Informacao_Ultimo_Documento', false)

Choose Case ll_Retorno
	Case 1 				// Comando OK
		lb_Sucesso = True
	Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose

If lb_Sucesso Then
	pd_data = DateTime(Date(MidA(ls_Dados,3,2)+"/"+MidA(ls_Dados,5,2)+"/"+MidA(ls_Dados,7,4)), &
				 Time(MidA(ls_Dados,11,2)+":"+MidA(ls_Dados,13,2)+":"+MidA(ls_Dados,15,2)))
	Return True
End If
end function

public function boolean of_contador_operacao_nao_fiscal (ref long pl_contador);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

String ls_Contadores

ls_Contadores = Space(85)

SetPointer(HourGlass!)

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Contadores(Ref ls_Contadores),'EPSON_Obter_Contadores', false)
	
If  ll_Retorno = 1 Then
	pl_contador = Long(MidA(ls_Contadores,1,6))
	Return True
Else
	Return False
End If
end function

public function boolean of_codigo_barras (integer pl_tipo, string ps_codigo, string ps_tamanho);Long ll_Retorno
String ls_codigo

ls_Codigo = ps_codigo
ll_retorno =	This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Imprimir_Codigo_Barras(2,50,3,2,0,ps_codigo),'EPSON_NaoFiscal_Imprimir_Linha', False)

If ll_Retorno = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_conecta_impressora ();
This.ivs_grava_log = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF" , "Log" , "")

If This.ivs_grava_log = "SIM" Then
 	EPSON_Sys_Log('C:\Sistemas\CL\Arquivos', 1)
Else
 	EPSON_Sys_Log('C:\Sistemas\CL\Arquivos', 0)
End If


Return True
end function

public function boolean of_configuracoes ();If This.ivb_Modo_Teste Then Return True

Return True
end function

public function boolean of_contador_credito_debito (ref long pl_contador);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

String ls_Contadores

ls_Contadores = Space(85)

SetPointer(HourGlass!)

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Contadores(Ref ls_Contadores),'EPSON_Obter_Contadores', false)
	
If  ll_Retorno = 1 Then
	pl_contador = Long(MidA(ls_Contadores,25,6))
	Return True
Else
	Return False
End If
end function

public function boolean of_contador_cupom_fiscal (ref long pl_contador);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

String ls_Contadores

ls_Contadores = Space(85)

SetPointer(HourGlass!)

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Contadores(Ref ls_Contadores),'EPSON_Obter_Contadores', false)
	
If  ll_Retorno = 1 Then
	pl_contador = Long(MidA(ls_Contadores,43,6))
	Return True
Else
	Return False
End If
end function

public function boolean of_contador_relatorio_gerencial (ref long pl_contador);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

String ls_Contadores

ls_Contadores = Space(85)

SetPointer(HourGlass!)

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Contadores(Ref ls_Contadores),'EPSON_Obter_Contadores', false)
	
If  ll_Retorno = 1 Then
	pl_contador = Long(MidA(ls_Contadores,37,6))
	Return True
Else
	Return False
End If
end function

public function boolean of_dados_impressora (ref long pl_sequencial, ref long pl_ecf);If Not of_nr_ecf(Ref pl_ecf) Then Return False

If Not of_nr_cupom(Ref pl_sequencial) Then Return False

Return True
end function

public function boolean of_nr_cupom (ref long pl_sequencial);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

String ls_Cupom

SetPointer(HourGlass!)

ls_Cupom = Space( 85 )

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Contadores(Ref ls_cupom),'EPSON_Obter_Contadores', false)
	
If ll_Retorno = 1 Then
	pl_sequencial = Long(MidA(ls_cupom,1,6))	
	Return True
Else
	Return False
End If
end function

public function boolean of_data_hora_ecf (ref datetime pdt_data);Date ld_DataEcf
String ls_Hora, ls_Data

If Not This.Of_HoraEcf(Ref ls_Hora)          Then Return False

If Not This.of_dataecf(Ref ld_dataecf)       Then Return False

ls_Data = String(ld_DataEcf)

pdt_Data = DateTime(Date(ls_Data),Time(ls_Hora))

Return True
end function

public function boolean of_horaecf (ref string ps_hora);If This.ivb_Modo_Teste Then Return True

String ls_Hora

Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Hora = Space(15)

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Hora_Relogio(Ref ls_Hora),'EPSON_Obter_Hora_Relogio', False)
	
If ll_Retorno = 1 Then
	lb_Sucesso = True
End If

If lb_Sucesso Then

	ps_hora = MidA(ls_Hora,9,2)+":"+MidA(ls_Hora,11,2)+":"+MidA(ls_Hora,13,2)

End If

Return lb_Sucesso
end function

public function boolean of_dataecf (ref date pd_dataecf);If This.ivb_Modo_Teste Then Return True

String ls_Data

Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Data = Space(15)

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Hora_Relogio(Ref ls_data),'EPSON_Obter_Hora_Relogio', False)
	
If ll_Retorno = 1 Then
	lb_Sucesso = True
End If

If lb_Sucesso Then

	ls_Data = MidA(ls_Data,1,2)+"/"+MidA(ls_Data,3,2)+"/"+MidA(ls_Data,5,4)
	
	pd_dataecf = Date(ls_Data)

End If

Return lb_Sucesso
end function

public function boolean of_data_hora_usuario_software_basico ();If This.ivb_Modo_Teste Then Return True

String ls_HoraSWBasico
String ls_DataSWBasico
String ls_MFAdicional = 'N'
String ls_Versao
String ls_cniie

Long   ll_Retorno

Boolean lb_Sucesso = False

ls_horaSWBasico = Space(7)
ls_dataSWBasico = Space(9)
ls_Versao  = Space(9)
	
ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Versao_SWBasicoEX(Ref ls_versao, Ref ls_DataSWBasico, Ref ls_horaSWBasico),'EPSON_Obter_Versao_SWBasicoEX', False)
	
Choose Case ll_Retorno
	Case 1 				// Comando OK		
			
		This.id_MFAdicional = ls_MFAdicional
		ls_DataSWBasico = MidA(ls_DataSWBasico,1,2)+"/"+MidA(ls_DataSWBasico,3,2)+"/"+MidA(ls_DataSWBasico,5,4)	
		ls_horaSWBasico = MidA(ls_horaSWBasico,01,02) + ":" + MidA(ls_horaSWBasico,03,02) + ":" + MidA(ls_horaSWBasico,5,02)				
		This.dh_SWBasico    = DateTime(Date(ls_DataSWBasico),Time(ls_HoraSWBasico))
		ls_versao = Trim(LeftA(ls_Versao + Space(10),9))
		This.nr_Versao_SWBasico = gf_replace(ls_versao, '.', '', 0)
		
		Choose Case This.nr_Versao_SWBasico
			Case '010201'
				ls_cniie = '151104'
			Case '010100'
				ls_cniie = '151100'
		End Choose		

		Update impressora_fiscal
		Set id_mfadicional = :This.id_MFAdicional,
			 dh_swbasico    = :This.dh_SWBasico,
			 nr_versao_swbasico = :This.nr_Versao_SWBasico,
			 cd_identificacao_nacional = :ls_cniie
		Where nr_ecf = :This.Ecf
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_RollBack()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF.~n~n Erro: " + Sqlca.SqlErrText,Exclamation!)
			gvo_aplicacao.of_grava_log("Erro ao salvar informa$$HEX2$$e700f500$$ENDHEX$$es da ECF, fun$$HEX2$$e700e300$$ENDHEX$$o uo_epson.of_data_hora_usuario_software_basico()."+Sqlca.SQLErrText)	
			lb_Sucesso = False
		Else			
			Sqlca.of_Commit()
			lb_Sucesso = True
		End If	
		
	Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
		Return False
End Choose
	

Return lb_Sucesso
end function

public function boolean of_data_ultima_reducaoz (ref date pdt_data);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

String	ls_Data, &
		ls_Retorno_Reducao	 

ls_Retorno_Reducao = Space(1168)

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Ultima_RZ(Ref ls_Retorno_Reducao), 'EPSON_Obter_Dados_Ultima_RZ', False)

If ll_retorno = 1 Then
	ls_Data = MidA(ls_Retorno_Reducao,1,8)
		
	ls_Data = MidA(ls_Data,1,2)+"/"+MidA(ls_Data,3,2)+"/"+MidA(ls_Data,5,4)
		
	pdt_data = Date(ls_Data)
	Return True
Else
	Return False
End If


end function

public function boolean of_datafiscal (ref date pd_datafiscal);If This.ivb_Modo_Teste Then Return True

String ls_DataMovimento
String ls_Ano

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_DataMovimento = Space( 15 )

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Data_Hora_Jornada(Ref ls_DataMovimento),'EPSON_Obter_Data_Hora_Jornada', False)
	
If ll_Retorno = 1 Then
	ls_DataMovimento = LeftA(ls_DataMovimento,8)	
	lb_Sucesso = True
Else
	Return False
End If

If lb_Sucesso Then
	ls_DataMovimento = MidA(ls_DataMovimento,1,2)+"/"+MidA(ls_DataMovimento,3,2)+"/"+MidA(ls_DataMovimento,5,4)

	pd_datafiscal = Date(ls_DataMovimento)
End If

Return lb_Sucesso
end function

public function boolean of_desconto_cupom (string ps_texto, decimal pd_valor);If This.ivb_Modo_Teste Then Return True

String ls_valor

Long ll_Retry
Long ll_Retorno

If pd_valor > 0 Then
	ls_valor = String(pd_valor)
	
	ls_valor	= gf_replace(ls_valor,',','',0)
		
	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Fiscal_Desconto_Acrescimo_Subtotal(ls_valor,2,True,False),'EPSON_Fiscal_Desconto_Acrescimo_Subtotal', False)
		
	If ll_Retorno = 1 Then
		Return True
	Else
		Return False
	End If
Else
	Return True
End If
end function

public function boolean of_desconto_item (long pl_item, decimal pdc_desconto, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

String ls_valor

Long ll_Retry
Long ll_Retorno

ls_valor = String(pdc_valor)

ls_valor	= gf_replace(ls_valor,',','',0)

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Fiscal_Desconto_Acrescimo_ItemEX(String(pl_item,'000'),ls_valor,2,True,False),'EPSON_Fiscal_Desconto_Acrescimo_ItemEX', False)
	 	
If ll_Retorno = 1 Then
	//of_Status_ECF()	
	This.of_Atualiza_Venda_Bruta()
	Return True
Else			
	Return False
End If
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

public function boolean of_efetua_recebimento_nao_fiscal (string ps_tipo, string ps_valor);If This.ivb_Modo_Teste Then Return True

String ls_valor
Long    ll_Retorno

ls_valor	= gf_replace(ps_valor,',','',0)
If Trim(ps_tipo) = '02' Then  //Na epson 02 $$HEX1$$e900$$ENDHEX$$ sangria
	ps_tipo = '04'
End If
If Trim(ps_tipo) = '01' Then  //Na epson 01 $$HEX1$$e900$$ENDHEX$$ suprimento
	ps_tipo = '03'
End If

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Vender_Item(ps_tipo,ls_valor,2),'EPSON_NaoFiscal_Vender_Item', False)

If ll_Retorno = 1 Then				// Comando OK
	Return True
Else
	Return False
End If

end function

public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long    ll_linha

String  ls_Relatorio
String  ls_Texto

If Not Of_Verifica_Problemas_Impressora() Then Return False

Choose Case ps_titulo
	Case "VIA CONVENIO"
		ls_Relatorio = "2"
	Case "VIA RECIBO"
		ls_Relatorio = "3"
	Case "VIA CREDIARIO"
		ls_Relatorio = "4"
	Case "VIA PBM"
		ls_Relatorio = "5"
	Case "VIA CLUBE"	
		ls_Relatorio = "6"
	Case "RELATORIO GERAL"
		ls_Relatorio = "1"
	Case Else
		ls_Relatorio = "1"
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
	
	If This.ivs_Status = '0' Then		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Impressora Fiscal Bloqueada. Redu$$HEX2$$e700e300$$ENDHEX$$o Z j$$HEX1$$e100$$ENDHEX$$ efetuada.",StopSign!)
		Return False
	End If	
	
	If Sqlca.ivs_DataBase <> "ACCESS" Then
	
		// VerIfica se a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ igual a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o do parametro
		If Not of_verifica_data_movimentacao() Then Return False
		
		This.of_Verifica_Ultimo_Mapa_Resumo()
	
	End If
		
//	of_Verifica_Flags_Fiscais()
	
//	If ivs_Status = "008" Then
//	If ivl_Status = 8 or ivl_Status = 12 Then		
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Impressora Fiscal Bloqueada. Redu$$HEX2$$e700e300$$ENDHEX$$o Z j$$HEX1$$e100$$ENDHEX$$ efetuada.",StopSign!)
//
//	End If
	
	Exit
	
Loop

Return True
end function

public function boolean of_impressora_online ();If This.ivb_Modo_Teste Then Return True

Boolean lb_Sucesso

Long    ll_Retorno

Do While ll_Retorno <> 1
	
	ll_Retorno = This.of_verifica_retorno_ecf(EPSON_Serial_Obter_Estado_Com(),'EPSON_Serial_Obter_Estado_Com', False)

	Choose Case ll_Retorno
		Case 1
			lb_Sucesso = True
		Case Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!)
			Return False
	End Choose
	
Loop

Return lb_Sucesso
end function

public function boolean of_verifica_cupons_pendentes ();String ls_EstadoImpressora
String ls_EstadoFiscal
String ls_comando
String ls_erro
String ls_situacao
String ls_status

Long ll_Ret

ls_EstadoImpressora 	= Space(17)
ls_EstadoFiscal 		= Space(17)
ls_Comando 			= Space(5)
ls_Erro 					= Space(101)

ll_Ret = This.of_verifica_retorno_ecf(EPSON_Obter_Estado_ImpressoraEX(Ref ls_EstadoImpressora, Ref ls_EstadoFiscal, Ref ls_Comando, Ref ls_Erro), 'EPSON_Obter_Estado_ImpressoraEX', False)

If ll_Ret = 1 Then
	ls_situacao = Trim(RightA(ls_EstadoFiscal,4))
	This.ivs_status = MidA(ls_EstadoFiscal,9,1)	
	
	If ls_situacao = '0000' Then Return True  //Nada aberto na ECF
	
	If ls_situacao = '0001' Then  //Cupom fiscal aberto
		This.ivb_cupom_aberto = True
		
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
		
		This.ivb_cupom_aberto = False		
		
		Return True
	End If	
	If ls_situacao = '0010' Then
		//cancelar CCD
		If Not This.of_fecha_comprovante_tef() Then Return False
	End If
	If ls_situacao = '0100' Then
		//Fechar RG
		If Not This.of_fecha_relatorio_gerencial() Then Return False
	End If
	If ls_situacao = '1000' Then
		//cancelar comprovante nao-fiscal
		If Not This.of_cancela_recebimento_nao_fiscal() Then Return False
	End If
Else
	Return False
End If
	
Return True
end function

public subroutine of_msg_cupom_aberto ();//
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","                               CUPOM FISCAL N$$HEX1$$c300$$ENDHEX$$O ENCERRADO~r~r" + &
										"O $$HEX1$$da00$$ENDHEX$$ltimo cupom fiscal impresso n$$HEX1$$e300$$ENDHEX$$o foi finalizado corretamente. " + &
										"O Sistema ir$$HEX1$$e100$$ENDHEX$$ cancel$$HEX1$$e100$$ENDHEX$$-lo automaticamente na impressora fiscal.",Information!)
end subroutine

public function boolean of_fecha_comprovante_tef ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Fechar_CCD(True),'EPSON_NaoFiscal_Fechar_CCD', True)
	
If ll_Retorno = 1 Then
	Return True
Else	
	Return False
End If

end function

public function boolean of_fecha_relatorio_gerencial ();If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

If This.ivb_Cod_Barras Then
	This.of_codigo_barras(0,This.ivs_Cod_Barras,'1')	
End If

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Fechar_Relatorio_Gerencial(True),'EPSON_NaoFiscal_Fechar_Relatorio_Gerencial', True)
	
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

public function boolean of_sangria_caixa (decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
String ls_valor

ls_valor = String(pdc_valor)
ls_valor = gf_replace(ls_valor,',','',0)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Sangria(ls_valor,2),'EPSON_NaoFiscal_Sangria', True)
	
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

public function boolean of_suprimento_caixa (decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
DateTime ldt_data
String ls_valor

This.of_data_hora_ecf(Ref ldt_Data)

ls_valor = String(pdc_valor)
ls_valor = gf_replace(ls_valor,',','',0)

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Fundo_Troco(ls_valor,2),'EPSON_NaoFiscal_Fundo_Troco', True)
	
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

public function boolean of_inicializa_relatorio_gerencial (string ps_relatorio, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno = 0
Long ll_Tentativas = 0
String ls_relatorio

If ps_relatorio = '01' Then  //Para comprovantes de recarga.
	ls_Relatorio = '03'
Else
	ls_Relatorio = ps_Relatorio
End If

Do While ll_Tentativas < 3 And ll_Retorno <> 1
	If ll_Tentativas > 0 Then gf_Delay(2)

	ll_Retorno = This.of_verifica_retorno_ecf(EPSON_NaoFiscal_Abrir_Relatorio_Gerencial(ls_relatorio), 'EPSON_NaoFiscal_Abrir_Relatorio_Gerencial', False)
	
	ll_Tentativas++
Loop

If ll_retorno = 1 Then 
	Return True
Else
	Return False
End If
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
				
		ls_Texto = ps_texto[ll_Linha]			
		
			ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Imprimir_LinhaEX(ls_texto),'EPSON_NaoFiscal_Imprimir_LinhaEX', False)
			
			Trata_Retorno2:
			Choose Case ll_Retorno
				Case 1 				// Comando OK
					If ll_Linha = UpperBound(ps_texto) Then Return True
				Case 0 				// Erro ao executar comando
					Return False					
				Case 100 			// Impressora ocupada
					Return False
				Case -1 				// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
					//Se houver retorno de fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido ser$$HEX1$$e100$$ENDHEX$$ enviado o texto novamente permitindo apenas os caracteres ANSI
					ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Imprimir_LinhaEX(This.Of_Normaliza_Texto(ls_texto)),'EPSON_NaoFiscal_Imprimir_LinhaEX', False)
					
					If ll_Retorno = -1 Then
						gvo_aplicacao.of_grava_log('Falha ao imprimir relat$$HEX1$$f300$$ENDHEX$$rio gerencial ['+ls_texto+'].')
						Return False
					Else
						GoTo Trata_Retorno2
					End If
			End Choose	

	Next
			
	gf_Delay(3)
	ll_Retry ++
//Loop

Return False
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

public function boolean of_fecha_cupom (string ps_msg[], boolean pb_repete, string ps_indicadores[6, 2], string ps_vinculado);If This.ivb_Modo_Teste Then Return True

Long   ll_ind
Long   ll_Retorno
Long	 ll_retorno_msg
Long ll_Tentativas = 0

String ls_msg   = ''
String ls_linha = ''

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

ll_retorno_msg = This.of_verifica_retorno_ecf(EPSON_Fiscal_Imprimir_MensagemEX(ls_msg), 'EPSON_Fiscal_Imprimir_MensagemEX', False)
If ll_retorno_msg = 1 Then	
	//Limpa msg aplicacao do cupom
	ll_retorno_msg = This.of_verifica_retorno_ecf(EPSON_Config_Mensagem_Aplicacao('MD5: ' + This.ivs_MD5_CL,''), 'EPSON_Config_Mensagem_Aplicacao', False)	
	
	If ll_retorno_msg = 1 Then		
		Do While ll_Tentativas < 3 And ll_Retorno <> 1
			If ll_Tentativas > 0 Then gf_Delay(2)
			ll_Retorno = This.of_Verifica_Retorno_Ecf(EPSON_Fiscal_Fechar_Cupom(True,False),'EPSON_Fiscal_Fechar_Cupom', True)
			ll_Tentativas++
		Loop
		
		If ll_retorno = 1 Then Return True
	End If
		
Else
	Return False
End If

end function

public function boolean of_fecha_cupom_nao_fiscal ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Fechar_Comprovante(True),'EPSON_NaoFiscal_Fechar_Comprovante', True)

Choose Case ll_Retorno
	Case 1 				// Comando OK
		Return True
	Case Else
		Return False		
End Choose
end function

public function string of_formata_valor_pafecf (decimal pdc_valor, long pl_inteiro, long pl_decimal);
String 	ls_Valor

If IsNull(pdc_Valor) Then pdc_Valor = 000.00

ls_Valor = FillA('0', pl_inteiro + pl_decimal) + MidA( String(pdc_valor) , 1, LenA(String(pdc_valor)) -3 ) + RightA(String(pdc_valor),2)

ls_Valor = RightA( ls_Valor, pl_inteiro + pl_decimal )

Return ls_Valor
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

If Not of_totaliza_recebimento_nao_fiscal(ls_pagamento,String(pdc_valor),ps_descricao) Then Return False

If Not of_fecha_recebimento_nao_fiscal(ps_descricao) Then Return False

Return True
end function

public function string of_meio_pagamento (string ps_pagamento);String ls_FormasPagto[]

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
end function

public function boolean of_inicializa_recebimento_nao_fiscal ();If This.ivb_Modo_Teste Then Return True

Long ll_Sequencia,&
     ll_Retorno,&
     ll_Ecf

ivb_showerror = FALSE

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Abrir_Comprovante("","","","",0),'EPSON_NaoFiscal_Abrir_Comprovante', False)

If ll_retorno = 1 Then
	Return True
else
	Return False
End If
	

end function

public function boolean of_registra_documento_ecf (string ps_documento, string ps_totalizador, decimal pdc_valor);Long ll_coo
Long ll_gnf
Long ll_grg
Long ll_cdc
Long ll_ccf

Datetime ldh_Movimento
Datetime ldh_Final

String ls_Hash

//If pdc_valor = 000.00 Then Return True

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

public function boolean of_fecha_recebimento_nao_fiscal (string ps_texto);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Fechar_Comprovante(true),'EPSON_NaoFiscal_Fechar_Comprovante', true)
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case Else
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return True
end function

public function boolean of_inicializa_comprovante_tef (string ps_pagamento, string ps_descricao, string ps_recebimento, decimal pdc_valor, string ps_cupom);If This.ivb_Modo_Teste Then Return True

Long  ll_Retry
Long  ll_Retorno

String ls_Pagamento
String ls_Valor 
String ls_Cupom

ls_Valor = String(pdc_Valor)
ls_Cupom = ps_cupom

//Retorna descri$$HEX2$$e700e300$$ENDHEX$$o do meio de pagamento
ls_Pagamento = of_meio_pagamento(ps_pagamento)
ls_valor = gf_replace(ls_valor,',','',0)

Do While ll_Retry <= 3

	 ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Abrir_CCD(ls_Pagamento,ls_Valor,2,'1'),'EPSON_NaoFiscal_Abrir_CCD', False)
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			of_Registra_documento_ecf('CC',pdc_valor)
			
			Return True
			
		Case Else
			Return False
		
	End Choose
	
	ll_Retry ++

Loop

Return False
end function

public function boolean of_registra_documento_ecf (string ps_documento, decimal pdc_valor);
String ls_Nulo

SetNull(ls_Nulo)

Return of_Registra_Documento_ecf(ps_documento,ls_Nulo,pdc_valor)
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

If Not of_totaliza_recebimento_nao_fiscal(ps_tipo_pagamento,String(pdc_valor),"") Then Return False

If Not of_fecha_recebimento_nao_fiscal(String(pdc_valor)) Then Return False

If Not of_inicializa_comprovante_tef(ps_tipo_pagamento,ps_descricao,ps_tipo_pagamento,pdc_valor, '') Then Return False

Return True
end function

public function boolean of_inicializa_cupom (string ps_cpf_cgc);If This.ivb_Modo_Teste Then Return True

Long ll_Sequencia,&
     ll_Retorno,&
     ll_Ecf

ivb_showerror = FALSE

Do While ll_Retorno <> 1 

	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Fiscal_Abrir_Cupom(ps_cpf_cgc,"","","",0),'EPSON_Fiscal_Abrir_Cupom', False)
	
	Choose Case ll_Retorno
		Case 1 						// Comando OK
			Return True	
		Case Else
			Return False			
	End Choose
	
Loop
end function

public function boolean of_marca_modelo_tipo ();If This.ivb_Modo_Teste Then Return True

String ls_Marca
String ls_Modelo
String ls_Tipo
String ls_dados

Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_dados		= Space( 109 )

Do While ll_Retry <= 3 and Not lb_Sucesso
	
   ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Impressora(Ref ls_dados),'EPSON_Obter_Dados_Impressora', False)
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			
			This.de_Marca 	= Trim(MidA(ls_dados,56,17))
			This.de_Modelo = Trim(MidA(ls_dados,73,22))
			This.de_Tipo 	= Trim(MidA(ls_dados,95,6))	
			
			lb_Sucesso = True			
		Case Else			// Retorno da Fun$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return lb_Sucesso
end function

public function boolean of_percentual_livre_mfd ();//Na epson n$$HEX1$$e300$$ENDHEX$$o tem fun$$HEX2$$e700e300$$ENDHEX$$o que traz o percentual livre da MFD, o numero total de redu$$HEX2$$e700e300$$ENDHEX$$o da ECF $$HEX1$$e900$$ENDHEX$$ 3650, assim $$HEX1$$e900$$ENDHEX$$ lido a quantidade faltante da ECF e feito o percentual.
If This.ivb_Modo_Teste Then Return True

String ls_Dados

Long ll_Retorno
Long ll_Tentativas = 0
Long ll_total_redz = 3650
Long ll_usado

Boolean lb_Sucesso = False

ls_Dados = Space( 67 )

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Jornada(Ref ls_Dados),'EPSON_Obter_Dados_Jornada', false)
	
If  ll_Retorno = 1 Then
	ll_usado = Long(Trim(MidA(ls_Dados, 47,6)))
	
	This.pc_Livre_MFD = Dec((ll_usado / ll_total_redz) * 100)

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
Else
	Return False
End If

Return lb_Sucesso

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

public function boolean of_permite_cancelamento_cupom ();String ls_Informacao
String ls_cupom_atual
String ls_tipo

If This.ivb_Modo_Teste Then Return True

If This.ivb_cupom_aberto Then Return True

Long ll_Retorno
Long ll_Tentativas = 0

ls_cupom_atual = Space(57)
ls_informacao = Space(31)
//L$$HEX1$$ea00$$ENDHEX$$ estado cupom atual
ll_retorno = This.of_verifica_retorno_ecf(EPSON_Obter_Estado_Cupom(Ref ls_cupom_atual), 'EPSON_Obter_Estado_Cupom', False)

If ll_retorno = 1 Then
	If LeftA(ls_cupom_atual,2) = '00' Then
		//Se cupom fechado
		ll_retorno = This.of_verifica_retorno_ecf(EPSON_Obter_Informacao_Ultimo_Documento(Ref ls_informacao), 'EPSON_Obter_Informacao_Ultimo_Documento', False)
		
		If ll_retorno = 1 Then
			ls_tipo = LeftA(ls_informacao,2)
			
			If ls_tipo = '01' Then Return True
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o cancelamento do documento impresso.",Exclamation!)
		End If	
	Else
		Return True
	End If
Else
	Return False
End If

Return False
end function

public function boolean of_recebimento_nao_fiscal (string ps_tipo, string ps_valor);If This.ivb_Modo_Teste Then Return True

Integer li_File
String  ls_msg

Long    ll_Retry
Long    ll_Retorno

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Vender_Item(ps_tipo,ps_valor,2),'EPSON_NaoFiscal_Vender_Item', False)

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case Else
			Return False
	End Choose
	
	ll_Retry ++
	
Loop

Return True
end function

public function boolean of_reducaoz ();If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Ecf
Long ll_dif

String ls_data
String ls_hora
String ls_Arquivo
String ls_contadorrz
String ls_hora_ecf
String ls_data_h_atual
String ls_data_h_ecf

Date ldt_DataFiscal
Date ldt_ReducaoZ
Date ldt_dataatual
DateTime ldt_ultima_venda

Boolean lb_sucesso
Boolean lb_blocox

ls_data = String(Day(Today()),'00')+"/"+String(Month(Today()),'00')+"/"+RightA(String(Year(Today()),'0000'),2)
ls_hora = String(Now(),"hh:mm:ss")

uo_Menu_Fiscal lvo_Menu

SetPointer(HourGlass!)

If Not of_Nr_Ecf(ref ll_Ecf) Then Return False

If Not This.of_Numero_Serie() Then Return False

If Not This.of_Marca_Modelo_Tipo()		Then Return False

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
	
	ls_data = String(Today(), "ddmmyyyy")
	ls_hora = String(Now(),"hhmmss")
	
	//Busca hora da ecf e compara para fazer o acerto de at$$HEX1$$e900$$ENDHEX$$ 5 minutos na redu$$HEX2$$e700e300$$ENDHEX$$o z
	If This.of_horaecf(Ref ls_hora_ecf) Then		
		This.of_dataecf(Ref ldt_dataatual)
		
		ls_data_h_atual = ls_data + ' ' + ls_hora
		ls_data_h_ecf = String(ldt_dataatual) + ' ' + ls_hora_ecf			

		Select CAST( extract( epoch from p.tempo ) - extract( epoch from tempo2 ) AS INTEGER ) as diferenca
				 Into :ll_dif
		from ( SELECT CAST( CAST( :ls_data_h_ecf AS VARCHAR ) AS TIMESTAMPTZ )	AS tempo,
							CAST( getdate( ) AS TIMESTAMPTZ ) 									AS tempo2
					FROM parametro WHERE 1 = 1 ) p
		Using SqlCa;
		
		If SqlCa.SqlCode = 0 Then
			If ll_dif <= 295 And ll_dif >= -295 Then
				//Passo a hora atual, a diferen$$HEX1$$e700$$ENDHEX$$a est$$HEX1$$e100$$ENDHEX$$ entre 5 minutos a mais ou a menos.
				ls_hora = ls_hora
			Else
				If ll_dif <= 295 Then
					//coloca 5 minutos da hora da ecf
					ls_hora = String(RelativeTime(Time(ls_hora_ecf), 295),"hhmmss")
				End If
				If ll_dif >= 295 Then
					//tira 5 minutos da hora da ecf
					ls_hora = String(RelativeTime(Time(ls_hora_ecf), -295),"hhmmss")
				End If			
			End If						
		End If
	End If		
	
	ls_contadorrz = Space(4)
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_RelatorioFiscal_RZ(ls_data, ls_hora, 2, Ref ls_contadorrz),'EPSON_RelatorioFiscal_RZ', True)
	//ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_RelatorioFiscal_RZ('', '', 2, Ref ls_contadorrz),'EPSON_RelatorioFiscal_RZ', True)
	If ll_Retorno = 1 Then
		If Not pdv.of_verifica_aliquotas() Then //Busca as aliquotas no banco e se necess$$HEX1$$e100$$ENDHEX$$rio inclui na ECF.
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Problemas na verifica$$HEX2$$e700e300$$ENDHEX$$o de aliquotas da ECF.")
		End If		
		
	Else
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Erro no retorno: " + String(ll_Retorno) + " ECF: " + String(This.ECF) + " ao gravar Mapa Resumo.")
		Return False
	End If
	
	This.of_Data_Hora_Usuario_Software_Basico()

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

//PDV.of_gera_cotepe_mensal(ll_ECF, ldt_DataFiscal)  Comentado at$$HEX1$$e900$$ENDHEX$$ resovermos com a Epson o problema de travamento na gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo.

If lb_sucesso Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Mapa Resumo gravado com sucesso !")

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

public function boolean of_registra_documento_ecf (string ps_documento);String ls_Nulo

Decimal ldc_Nulo

SetNull(ls_Nulo)
SetNull(ldc_Nulo)

Return of_Registra_Documento_ecf(ps_documento,ls_Nulo,ldc_Nulo)
end function

public function boolean of_registra_item_vendido (string ps_produto, long pl_qtde, decimal pdc_precounit, decimal pdc_precotot, string ps_descricao, decimal pdc_aliquota, string ps_complemento, string ps_tributacao_icms);If This.ivb_Modo_Teste Then Return True

String	lvs_qtd,&
      	lvs_precounit,&
	   	lvs_precotot,&
	   	lvs_comando,&
	   	lvs_desconto,&
	   	lvs_trib

Long 		ll_Retorno,&
			ll_Retorno2

lvs_trib = This.of_Indicador_Aliquota(pdc_Aliquota,ps_tributacao_icms)

//ps_descricao = LeftA(Trim(ps_descricao),24)

lvs_qtd			= String(pl_qtde)
lvs_precounit	= String(pdc_precounit)
lvs_precotot		= String(pdc_precotot)
lvs_desconto  	= String(pdc_precotot - (pdc_precounit*pl_qtde))

lvs_precounit	= gf_replace(lvs_precounit,',','',0)

ll_Retorno = This.of_verifica_retorno_ecf(EPSON_Fiscal_Vender_Item_AD(trim(ps_produto), ps_descricao, lvs_qtd, 0, "un", lvs_precounit, 2, lvs_trib, 2, 1, 1), 'EPSON_Fiscal_Vender_Item_AD', False)

If ll_Retorno = 1 Then
	This.of_Atualiza_Venda_Bruta()
	If pdc_precotot - (pdc_precounit*pl_qtde) > 0 Then
		lvs_desconto	= gf_replace(lvs_desconto,',','',0)
		ll_Retorno2 = This.of_verifica_retorno_ecf(EPSON_Fiscal_Desconto_Acrescimo_Item(lvs_desconto, 2, True, False), 'EPSON_Fiscal_Desconto_Acrescimo_Item', False)
		
		If ll_retorno2 <> 1 Then Return False		
		
	End If	
	
	Return True
Else 
	Return False
End If
	
Return False
end function

public function boolean of_texto_nao_fiscal_tef (string ps_texto);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_St1

Do While ll_Retry <= 3
	
//	If PosA( Upper( SqlCa.SqlReturnData ) , 'POSTGRESQL' ) = 0 Then				
//		ps_texto = CharA(16) + CharA(67) + ps_texto + CharA(13) + CharA(10)
//	Else
//		ps_texto = CharA(16) + CharA(67) + ps_texto
//	End If
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Imprimir_LinhaEX(ps_texto),'EPSON_NaoFiscal_Imprimir_LinhaEX', False)
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
//			If of_Status_ECF() = -1 Then Return False
//			
//			If (This.St1 = 0) Or (This.St1 = 64) Then					
//				Return True
//			Else
//				ll_st1 = This.St1
//				
//				If ll_St1 >= 128 Then                 // sem papel
//					Return False
//				End If
//			End If		
			Return True						
		Case Else
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False

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

	ls_valor = gf_replace(ls_valor,',','',0)
	Do While ll_Retry <= 3
	
    	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Fiscal_Pagamento(ls_Pagto,ls_valor,2,'',''),'EPSON_Fiscal_Pagamento', False)
	
		Choose Case ll_Retorno
			Case 1 				// Comando OK
				Exit
			Case Else
				Return False
		End Choose
		
		ll_Retry ++
		
	Loop

Next

Return True
end function

public function boolean of_valor_pago_ultimo_cupom (decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno

String ls_Valor
String ls_dados

SetPointer(HourGlass!)

ls_dados = Space(31)

Do While ll_Retry <= 3
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Informacao_Ultimo_Documento(Ref ls_dados),'EPSON_Obter_Informacao_Ultimo_Documento', False)
			
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			ls_valor = RightA(ls_dados,14)
			Return True
		Case Else
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False


end function

public function boolean of_venda_bruta (ref decimal pdc_venda);If This.ivb_Modo_Teste Then Return True

String ls_Valor
String ls_valor_anterior
Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Valor = Space(15)
ls_valor_anterior = Space(15)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Venda_Bruta(Ref ls_Valor, Ref ls_valor_anterior),'EPSON_Obter_Venda_Bruta', False)
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			lb_Sucesso = True
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

public function boolean of_verifica_drivers ();Return This.of_Atualiza_Drivers()
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
	gvo_aplicacao.of_grava_log("Erro ao verificar $$HEX1$$fa00$$ENDHEX$$ltima data de movimenta$$HEX2$$e700e300$$ENDHEX$$o, fun$$HEX2$$e700e300$$ENDHEX$$o uo_epson.of_verifica_ultimo_mapa_resumo()." +Sqlca.SQLErrText)	
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
	gvo_aplicacao.of_grava_log("Erro ao verificar $$HEX1$$fa00$$ENDHEX$$ltimo mapa resumo registrado, fun$$HEX2$$e700e300$$ENDHEX$$o uo_epson.of_verifica_ultimo_mapa_resumo()." +Sqlca.SQLErrText)	
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

public function string of_centraliza_texto (string ps_texto);String ls_texto

ls_texto = Space(Int(COLUNAS - LenA(Trim(ps_texto)))/2) + Trim(ps_texto)
ls_texto = ls_texto + Space(COLUNAS - LenA(ls_texto))

Return ls_texto

end function

public function boolean of_texto_relatorio_gerencial (string ps_texto);If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_St1

Do While ll_Retry <= 3
	
//	If PosA( Upper( SqlCa.SqlReturnData ) , 'POSTGRESQL' ) = 0 Then				
//		ps_texto = CharA(16) + CharA(67) + ps_texto + CharA(13) + CharA(10)
//	Else
//		ps_texto = CharA(16) + CharA(67) + ps_texto
//	End If
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Imprimir_LinhaEX(ps_texto),'EPSON_NaoFiscal_Imprimir_LinhaEX', False)
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
//			If of_Status_ECF() = -1 Then Return False
//			
//			If (This.St1 = 0) Or (This.St1 = 64) Then					
//				Return True
//			Else
//				ll_st1 = This.St1
//				
//				If ll_St1 >= 128 Then                 // sem papel
//					Return False
//				End If
//			End If		
			Return True						
		Case Else
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False

end function

public function boolean of_mapa_resumo (ref s_ge039_mapa_resumo ps_mapa_resumo);If This.ivb_Modo_Teste Then Return True

Decimal{2} ldc_gt_inicial
Decimal{2} ldc_gt_final
Decimal{2} ldc_vl_aliquota
Decimal{2} ldc_vl_diario

String  ls_Dados = Space(1168)
String  ls_DadosAliquotas
String  ls_dados_jornada = Space(602)
String  ls_Aliquota

Long ll_contador_aliquota = 129
Long ll_linha
Long ll_Retorno
Long ll_Tentativas = 0

If Not This.of_Nr_Ecf(ref This.ECF) Then Return False

ll_Retorno = This.of_verifica_retorno_ecf(EPSON_Obter_Dados_Ultima_RZ(Ref ls_dados), 'EPSON_Obter_Dados_Ultima_RZ', False)

If ll_Retorno = 1 Then
//	ll_Retorno = This.of_verifica_retorno_ecf(EPSON_Obter_Tabela_Aliquotas(Ref ls_DadosAliquotas), 'EPSON_Obter_Tabela_Aliquotas', False)
	
//	If ll_Retorno <> 1 Then Return False

Else
	Return False
End If

ps_mapa_resumo.reducoes           		= LONG(MidA(ls_Dados,27,06))

ll_Retorno = This.of_verifica_retorno_ecf(EPSON_Obter_Total_JornadaEX('T', String(ps_mapa_resumo.reducoes), Ref ls_dados_jornada), 'EPSON_Obter_Total_JornadaEX', False)

If ll_Retorno <> 1 Then Return False

ps_mapa_resumo.ecf           				= This.ECF

ldc_gt_final                           = DEC(MidA(ls_Dados_jornada, 279, 17))/100
ldc_vl_diario						   = DEC(MidA(ls_Dados_jornada, 17, 14))/100
ldc_gt_inicial                         = ldc_gt_final - ldc_vl_diario

ps_mapa_resumo.vlst          				= DEC(MidA(ls_Dados_jornada,31,13))/100
ps_mapa_resumo.isento        				= DEC(MidA(ls_Dados_jornada,44,13))/100
ps_mapa_resumo.vl_nao_incidencia			= DEC(MidA(ls_Dados_jornada,57,13))/100

//ps_mapa_resumo.qt_cupom_cancelado 		= LONG(MidA(ls_Dados,985,04))
ps_mapa_resumo.qt_reinicio_z 		 		= LONG(MidA(ls_Dados_jornada,11,06))
ps_mapa_resumo.operacao           		= LONG(MidA(ls_Dados,21,06))
ps_mapa_resumo.grande_total  				= DEC(MidA(ls_Dados,87,18))/100

//a partir do 296 no ls_dados_jornada
ls_DadosAliquotas = MidA(ls_Dados_jornada,296)
Do While Trim(ls_DadosAliquotas) > ''
	ll_linha += 1
	ls_Aliquota = LeftA(ls_DadosAliquotas,17)
	If Trim(ls_Aliquota) = '' Then
		ls_Aliquota = Trim(ls_DadosAliquotas)
		ls_DadosAliquotas = ''
	Else
		ldc_vl_aliquota = DEC(MidA(ls_aliquota,5,13))/100
		ps_mapa_resumo.str_aliquota[ll_linha].aliquota	 = Long(Dec(LeftA(ls_Aliquota,4)) / 100)
		ps_mapa_resumo.str_aliquota[ll_linha].valor		 = ldc_vl_aliquota	
		ls_DadosAliquotas = Trim(MidA(ls_DadosAliquotas,18))		
		Continue
	End If	
Loop

ps_mapa_resumo.vl_isento_iss 			= 0	//DEC(MidA(ls_Dados,465,14))/100 
ps_mapa_resumo.vl_nao_incidencia_iss	= 0	//DEC(MidA(ls_Dados,493,14))/100
ps_mapa_resumo.vl_st_iss 					= 0	//DEC(MidA(ls_Dados,437,14))/100

ps_mapa_resumo.descontos     				= DEC(MidA(ls_Dados,156,17))/100
ps_mapa_resumo.vl_desconto_iss			= DEC(MidA(ls_Dados,173,17))/100
ps_mapa_resumo.vl_acrescimo				= DEC(MidA(ls_Dados,207,17))/100
ps_mapa_resumo.vl_acrescimo_iss			= DEC(MidA(ls_Dados,224,17))/100
ps_mapa_resumo.cancelamentos 				= DEC(MidA(ls_Dados,105,17))/100
ps_mapa_resumo.vl_cancelamento_iss		= DEC(MidA(ls_Dados,122,17))/100

ps_mapa_resumo.liquido       		      = ( ldc_gt_final - ldc_gt_inicial ) - ( ps_mapa_resumo.cancelamentos + ps_mapa_resumo.descontos )

Return True
end function

public function boolean of_programa_aliquota (boolean pb_automatico, decimal pdc_aliquota, long pl_tipo, boolean pb_mostra_mensagem);//Fun$$HEX2$$e700e300$$ENDHEX$$o para programar aliquotas na ECF - 18/02/2106
//pb_automatico - Se True $$HEX1$$e900$$ENDHEX$$ o processo automatico na abertura do sistema.
//pdc_aliquota $$HEX1$$e900$$ENDHEX$$ o precentual da aliquota a ser cadastrada.
//pl_tipo = 0 para ICMS e 1 para ISS
//A fun$$HEX2$$e700e300$$ENDHEX$$o antes, verifica se a aliquota j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrada.

If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
Long ll_Pos
String ls_aliquota
String ls_aliquotas_cadastradas
Boolean lb_tipo
Long ll_row
Decimal {2} ldc_pc_icms, ldc_pc_f

//Busca aliquotas cadastradas na ECF
ls_aliquotas_cadastradas = Space(553)

ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Tabela_Aliquotas( Ref ls_aliquotas_cadastradas ),'EPSON_Obter_Tabela_Aliquotas', False )
	
Choose Case ll_Retorno
	Case 1 				// Comando OK	
		
	Case Else 				// Erro ao executar comando
		Return False
End Choose

If pl_tipo = 0 Then
	lb_tipo = False
Else
	lb_tipo = True
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
		ll_Pos = PosA(ls_aliquotas_cadastradas, ls_aliquota)
		
		If ll_pos = 0 Then //N$$HEX1$$e300$$ENDHEX$$o econtrou, vai cadastrar.
			ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Config_Aliquota( ls_aliquota, lb_tipo ),'EPSON_Config_Aliquota', False )
				
			Choose Case ll_Retorno
				Case 1 				// Comando OK
					Continue
				Case Else
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
		ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Config_Aliquota( ls_aliquota, lb_tipo ),'EPSON_Config_Aliquota', False )
			
		Choose Case ll_Retorno
			Case 1 				// Comando OK
				Return True
			Case Else
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

public function boolean of_leitura_memoria_fiscal (string ps_inicio, string ps_final, boolean pb_arquivo, string ps_tipo);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_tipox
Long ll_tipoy
Long ll_tipo_impressao
Long ll_bytes
Long ll_buffer
Date ldt_Inicial, ldt_Final
String lvs_Parametro
String ls_dadosmf
Boolean lb_data

//pb_Arquivo 	- Salvar em arquivo ou na impressora
//ps_Tipo		- Tipo da leitura (C - Completa | S - Simplificada)
//pb_Data		- Gerar por Data ou Redu$$HEX2$$e700e300$$ENDHEX$$o

ls_dadosmf = Space(1024)

If IsDate(ps_inicio) Then
	lb_data 		= True
	ldt_Inicial 	= Date(ps_Inicio)
	ldt_Final		= Date(ps_Final)
	lvs_Parametro = String(ldt_Inicial,'ddmmyyyy')
	ps_inicio = lvs_Parametro
	lvs_Parametro = String(ldt_Final,'ddmmyyyy')
	ps_Final = lvs_Parametro	
End If

If ps_tipo = "C" Then
	If lb_Data Then
		ll_tipox = 1
	Else
		ll_tipox = 0
	End If
Else
	If lb_Data Then
		ll_tipox = 3
	Else
		ll_tipox = 2
	End If
//	regAlterarValor_Daruma('ECF\LMFCompleta', '0')
End If

If pb_arquivo Then
	ll_tipoy = 16
Else
	ll_tipoy = 4
End If

ll_tipo_impressao = ll_tipox + ll_tipoy

Do While ll_Retry <= 3
	
	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_RelatorioFiscal_Leitura_MF(ps_inicio, ps_final, ll_tipo_impressao, ls_dadosmf, '', Ref ll_bytes, Ref ll_buffer),'EPSON_RelatorioFiscal_Leitura_MF', False)	

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Return True
		Case Else
			Return False
	End Choose
	
	ll_Retry ++

Loop

Return False

end function

public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final);//Na EPSON, se a leitura for solicitada em um per$$HEX1$$ed00$$ENDHEX$$odo antes do ECF estiver em opera$$HEX2$$e700e300$$ENDHEX$$o, o processo trava, segundo a pr$$HEX1$$f300$$ENDHEX$$pria EPSON $$HEX1$$e900$$ENDHEX$$ um comportamento normal.
//Exemplo, se o ECF come$$HEX1$$e700$$ENDHEX$$ou inicou a operar em 15/12 e tento gerar uma leitura de 01/12 at$$HEX1$$e900$$ENDHEX$$ 31/12, pode ocorrer travamento.
//Tamb$$HEX1$$e900$$ENDHEX$$m n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ gerado espelho de movimento que o dia ainda est$$HEX1$$e100$$ENDHEX$$ aberto.

If This.ivb_Modo_Teste Then Return True

Boolean lb_Retorno

String ls_Versao
String ls_File = 'C:\Sistemas\CL\Arquivos\PAF-ECF\leitura-memoria-fita-detalhe.txt'
String ls_File_temp = 'c:\epson\espelho'
String ls_MF  = 'c:\epson\bin_MF.bin'
String ls_MFD = 'c:\epson\bin_MFD.bin'
String ls_Tipo
String ls_Nome_Arquivo
String ls_Inicio
String ls_Final

Date ldh_Data
Long ll_Retorno
Long ll_tipo
Long ll_Coo

FileDelete(ls_File_temp + '_ESP.txt')
FileDelete(ls_File)

ll_retorno = This.of_Verifica_Retorno_ECF(EPSON_Config_Habilita_EAD(False),'EPSON_Config_Habilita_EAD', False)

If ll_retorno = 1 Then
	
	ll_retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Arquivo_Binario_MFD(ls_MFD),'EPSON_Obter_Arquivo_Binario_MFD', False)
	
	If ll_retorno = 1 Then
		ll_retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Arquivo_Binario_MF(ls_MF),'EPSON_Obter_Arquivo_Binario_MF', False)
	End If
	
	If ll_retorno = 1 Then
		If ps_Tipo = "1" Then
			ldh_Data = Date(ps_Inicio)
			ls_Inicio = String(ldh_Data,'DDMMYYYY')
			ldh_Data = Date(ps_Final)
			ls_Final = String(ldh_Data,'DDMMYYYY')
			ll_tipo = 0		
			
			ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Arquivos_MF_MFD(ls_inicio, ls_final, ll_tipo, 255, 0, 0, ls_File_temp, ls_MF, ls_MFD),'EPSON_Obter_Dados_Arquivos_MF_MFD', False)			
		Else
			ll_tipo = 2
			ll_coo = Long(ps_Inicio)
			ls_inicio = String(ll_coo,'00000000')
			ll_coo = Long(ps_final)
			ls_final = String(ll_coo,'00000000')			
			
			ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Arquivos_MF_MFD(ls_inicio, ls_final, ll_tipo, 255, 0, 0, ls_File_temp, ls_MF, ls_MFD),'EPSON_Obter_Dados_Arquivos_MF_MFD', False)		
		End If
		
		If ll_Retorno = 1 Then
		
			dc_uo_api lvo_Api
			lvo_api = Create dc_uo_api
					
			If Not lvo_Api.of_Move_File(ls_File_temp + '_ESP.txt',ls_File,True) Then
				gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel mover arquivo espelho MFD para "+ls_File+", fun$$HEX2$$e700e300$$ENDHEX$$o uo_epson.of_leitura_memoria_fita_detalhe().")			
				lb_Retorno = False
			Else
				lb_retorno = True
			End If	
			
			Destroy(lvo_Api)
		
		End If	
	Else
		Return False
	End If
Else
	Return False
End If

Return lb_Retorno

end function

public function boolean of_retorna_doc_aberto (ref long pl_doc);If This.ivb_Modo_Teste Then Return True

String ls_EstadoImpressora
String ls_EstadoFiscal
String ls_comando
String ls_erro
String ls_situacao

Long ll_Ret

ls_EstadoImpressora 	= Space(17)
ls_EstadoFiscal 		= Space(17)
ls_Comando 			= Space(5)
ls_Erro 					= Space(101)

ll_Ret = This.of_verifica_retorno_ecf(EPSON_Obter_Estado_ImpressoraEX(Ref ls_EstadoImpressora, Ref ls_EstadoFiscal, Ref ls_Comando, Ref ls_Erro), 'EPSON_Obter_Estado_ImpressoraEX', False)

If ll_Ret = 1 Then
	ls_situacao = Trim(RightA(ls_EstadoFiscal,4))
	
	If ls_situacao = '0000' Then 
		pl_doc = 0
		Return True  //Nada aberto na ECF
	End If
	If ls_situacao = '0001' Then  //Cupom fiscal aberto
		pl_doc = 1		
		Return True
	End If
	If ls_situacao = '0010' Then //CCD
		pl_doc = 2
		Return True		
	End If	
	If ls_situacao = '0100' Then //RG
		pl_doc = 3
		Return True	
	End If
	If ls_situacao = '1000' Then //cupom n$$HEX1$$e300$$ENDHEX$$o fiscal
		pl_doc = 4
		Return True
	End If
Else
	Return False
End If


end function

public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final, string ps_arquivo);//Na EPSON, se a leitura for solicitada em um per$$HEX1$$ed00$$ENDHEX$$odo antes do ECF estiver em opera$$HEX2$$e700e300$$ENDHEX$$o, o processo trava, segundo a pr$$HEX1$$f300$$ENDHEX$$pria EPSON $$HEX1$$e900$$ENDHEX$$ um comportamento normal.
//Exemplo, se o ECF come$$HEX1$$e700$$ENDHEX$$ou inicou a operar em 15/12 e tento gerar uma leitura de 01/12 at$$HEX1$$e900$$ENDHEX$$ 31/12, pode ocorrer travamento.
//Tamb$$HEX1$$e900$$ENDHEX$$m n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ gerado espelho de movimento que o dia ainda est$$HEX1$$e100$$ENDHEX$$ aberto.

If This.ivb_Modo_Teste Then Return True

Boolean lb_Retorno

String ls_Versao
String ls_File
String ls_File_temp = 'c:\epson\espelho'
String ls_MF  = 'c:\epson\bin_MF.bin'
String ls_MFD = 'c:\epson\bin_MFD.bin'
String ls_Tipo
String ls_Nome_Arquivo
String ls_Inicio
String ls_Final

Date ldh_Data
Long ll_Retorno
Long ll_tipo
Long ll_Coo

ls_file = 'C:\Sistemas\RL\Arquivos\MFD\' + ps_arquivo

dc_uo_api lo_api
lo_api = Create dc_uo_api
lo_api.of_create_directory('C:\Sistemas\RL\Arquivos\MFD')
Destroy(lo_api)

FileDelete(ls_File_temp + '_ESP.txt')
FileDelete(ls_File)

ll_retorno = This.of_Verifica_Retorno_ECF(EPSON_Config_Habilita_EAD(False),'EPSON_Config_Habilita_EAD', False)

If ll_retorno = 1 Then
	
	ll_retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Arquivo_Binario_MFD(ls_MFD),'EPSON_Obter_Arquivo_Binario_MFD', False)
	
	If ll_retorno = 1 Then
		ll_retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Arquivo_Binario_MF(ls_MF),'EPSON_Obter_Arquivo_Binario_MF', False)
	End If
	
	If ll_retorno = 1 Then
		If ps_Tipo = "1" Then
//			ldh_Data = Date(ps_Inicio)
//			ls_Inicio = String(ldh_Data,'DDMMYYYY')
//			ldh_Data = Date(ps_Final)
//			ls_Final = String(ldh_Data,'DDMMYYYY')
			ll_tipo = 0		
			
			ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Arquivos_MF_MFD(ps_inicio, ps_final, ll_tipo, 255, 0, 0, ls_file_temp, ls_MF, ls_MFD),'EPSON_Obter_Dados_Arquivos_MF_MFD', False)			
		Else
			ll_tipo = 2
			ll_coo = Long(ps_Inicio)
			ls_inicio = String(ll_coo,'00000000')
			ll_coo = Long(ps_final)
			ls_final = String(ll_coo,'00000000')			
			
			ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Arquivos_MF_MFD(ls_inicio, ls_final, ll_tipo, 255, 0, 0, ls_file_temp, ls_MF, ls_MFD),'EPSON_Obter_Dados_Arquivos_MF_MFD', False)		
		End If
		
		If ll_Retorno = 1 Then
		
			dc_uo_api lvo_Api
			lvo_api = Create dc_uo_api
					
			If Not lvo_Api.of_Move_File(ls_File_temp+'_ESP.txt',ls_File,True) Then
				gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel mover arquivo espelho MFD para "+ls_File+", fun$$HEX2$$e700e300$$ENDHEX$$o uo_epson.of_leitura_memoria_fita_detalhe().")			
				lb_Retorno = False
			Else
				lb_retorno = True
			End If	
			
			Destroy(lvo_Api)
		
		End If	
	Else
		Return False
	End If
Else
	Return False
End If

Return lb_Retorno

end function

public function boolean of_gera_arquivo_mfd (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_caminho_mfd);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_tipo
Long ll_tipo_mf
Long ll_pos
String ls_arquivo_retorno
String ls_arquivo_mf, ls_arquivo_mfd
//FileDelete('C:\Download.MFD')
//FileDelete('C:\Sistemas\CL\Arquivos\PAF-ECF\Download.MFD')

If pl_tipo_geracao = 0 Then //MF
	ll_tipo_mf = 21
End If

If pl_tipo_geracao = 1 Then //MFD
	ll_tipo_mf = 22
End If	

ll_pos = PosA(ps_endereco, '.txt')
ls_arquivo_retorno = MidA(ps_endereco, 1, ll_Pos - 1)

Choose Case ps_tipo
	Case 'D'
		ll_tipo = 0
	Case 'Z'
		ll_tipo = 1
	Case 'C'
		ll_tipo = 2
End Choose

ls_arquivo_mf = 'C:\Sistemas\CL\Arquivos\PAF-ECF\Download.MF'
ls_arquivo_mfd = 'C:\Sistemas\CL\Arquivos\PAF-ECF\Download.MFD'
Filedelete(ls_arquivo_mf)
Filedelete(ls_arquivo_mfd)

//Gera binarios
ll_retorno = This.of_verifica_retorno_ecf(EPSON_Obter_Arquivos_Binarios(ps_inicio, ps_final, ll_tipo, ls_arquivo_mf, ls_arquivo_mfd),'EPSON_Obter_Arquivos_Binarios', false)
If ll_retorno <> 1 Then
	Return False
End If	

//ll_retorno = This.of_Verifica_Retorno_ECF(EPSON_Config_Dados_PAFECF( '84683481000177', '250.330.539', '', 'CLAMED',  'SISTEMA DE CAIXA', '15.20', 'LSAFJLK24349234090', '0205'),'EPSON_Config_Dados_PAFECF', false)

Do While ll_Retry <= 3	
															//EPSON_Obter_Dados_Arquivos_MF_MFD
	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Arquivos_MF_MFD(ps_inicio,ps_final,ll_tipo, 0, ll_tipo_mf, 0, ls_arquivo_retorno,ls_arquivo_mf,ls_arquivo_mfd),'EPSON_Obter_Dados_MF_MFD', false)
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			//If FileExists('C:\Download.MFD') Then
			//	FileMove('C:\Download.MFD','C:\Sistemas\CL\Arquivos\PAF-ECF\Download.MFD')
			//End If	
			If FileExists(ls_arquivo_retorno+'_CTP.txt') Then
				FileCopy(ls_arquivo_retorno+'_CTP.txt',ps_endereco,False)
				Filedelete(ls_arquivo_retorno+'_CTP.txt')				
			End If
			If pl_tipo_geracao = 0 Then ps_caminho_MFD = ls_arquivo_mf
			If pl_tipo_geracao = 1 Then ps_caminho_MFD = ls_arquivo_mfd
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

public function boolean of_gera_arquivo_cotepe_mensal (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, string ps_dir_mfd, boolean pb_gera_mfd, ref boolean pb_mfd_gerado);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_tipo
Long ll_tipo_mf
Long ll_pos
String ls_arquivo_retorno
String ls_arquivo_mf, ls_arquivo_mfd

If pl_tipo_geracao = 0 Then //MF
	ll_tipo_mf = 21
End If

If pl_tipo_geracao = 1 Then //MFD
	ll_tipo_mf = 22
End If	

ll_pos = PosA(ps_endereco, '.txt')
ls_arquivo_retorno = MidA(ps_endereco, 1, ll_Pos - 1)

Choose Case ps_tipo
	Case 'D'
		ll_tipo = 0
	Case 'Z'
		ll_tipo = 1
	Case 'C'
		ll_tipo = 2
End Choose

ls_arquivo_mf = ps_dir_mfd + 'Download.MF'
ls_arquivo_mfd = ps_dir_mfd + 'Download.MFD'

If pb_gera_mfd Then
	Filedelete(ls_arquivo_mf)
	Filedelete(ls_arquivo_mfd)
	
	//Gera binarios
	ll_retorno = This.of_verifica_retorno_ecf(EPSON_Obter_Arquivos_Binarios('', '', 3, ls_arquivo_mf, ls_arquivo_mfd),'EPSON_Obter_Arquivos_Binarios', false)
	If ll_retorno <> 1 Then
		Return False
	End If	
	pb_mfd_gerado = True
Else
	pb_mfd_gerado = True	
End If

Do While ll_Retry <= 3	

	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Arquivos_MF_MFD(ps_inicio,ps_final,ll_tipo, 0, ll_tipo_mf, 0, ls_arquivo_retorno,ls_arquivo_mf,ls_arquivo_mfd),'EPSON_Obter_Dados_Arquivos_MF_MFD', false)
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			If FileExists(ls_arquivo_retorno+'_CTP.txt') Then
				FileCopy(ls_arquivo_retorno+'_CTP.txt',ps_endereco,False)
				Filedelete(ls_arquivo_retorno+'_CTP.txt')				
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

public function boolean of_subtotal_cupom (ref string ps_subtotal);If This.ivb_Modo_Teste Then Return True

String ls_Valor
Long   ll_Retry
Long   ll_Retorno

Boolean lb_Sucesso = False

ls_Valor = Space(13)

Do While ll_Retry <= 3 and Not lb_Sucesso
	
    ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Fiscal_Obter_SubTotal(Ref ls_Valor),'EPSON_Fiscal_Obter_SubTotal', False)
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			ps_subtotal = Trim(ls_valor)
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

public function boolean of_gera_arquivos_ecf (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_espelhos, long pl_tipo_geracao, string ps_dir_mfd, ref string ps_arquivo_gerado);
If This.ivb_Modo_Teste Then Return True

Long ll_Retry
Long ll_Retorno
Long ll_tipo
Long ll_tipo_mf
Long ll_pos
Long ll_espelho
String ls_arquivo_retorno
String ls_arquivo_mf, ls_arquivo_mfd

//Tipo gera$$HEX2$$e700e300$$ENDHEX$$o
/*
0 - N$$HEX1$$e300$$ENDHEX$$o gera ATO/COTEPE
1 $$HEX1$$1320$$ENDHEX$$ MF, ATO/COTEPE 17/04 da Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal.
2 $$HEX1$$1320$$ENDHEX$$ MFD, (Cupom Mania $$HEX1$$1320$$ENDHEX$$ RJ) ATO/COTEPE 17/04 da Mem$$HEX1$$f300$$ENDHEX$$ria Fita Detalhe.
3 $$HEX1$$1320$$ENDHEX$$ TDM, (CAT52) ATO/COTEPE 17/04 de Todas as mem$$HEX1$$f300$$ENDHEX$$rias.
9 $$HEX1$$1320$$ENDHEX$$ MF, ATO/COTEPE 17/04 da Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal mais arquivo de registros do PAF-ECF.
10 $$HEX1$$1320$$ENDHEX$$ MFD, ATO/COTEPE 17/04 da Mem$$HEX1$$f300$$ENDHEX$$ria Fita Detalhe mais arquivo de registros do PAF-ECF.
11 $$HEX1$$1320$$ENDHEX$$ TDM, (CAT52)ATO/COTEPE 17/04 de Todas as mem$$HEX1$$f300$$ENDHEX$$rias.
21 $$HEX1$$1320$$ENDHEX$$ MF, ATO/COTEPE 17/04 da Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal Vers$$HEX1$$e300$$ENDHEX$$o 2.0.
22 $$HEX1$$1320$$ENDHEX$$ MFD, ATO/COTEPE 17/04 da Mem$$HEX1$$f300$$ENDHEX$$ria Fita Detalhe Vers$$HEX1$$e300$$ENDHEX$$o 2.0.
23 $$HEX1$$1320$$ENDHEX$$ TDM, ATO/COTEPE 17/04 de Todas as mem$$HEX1$$f300$$ENDHEX$$rias Vers$$HEX1$$e300$$ENDHEX$$o 2.0.
mais arquivo de registros do PAF-ECF.
33 $$HEX1$$1320$$ENDHEX$$ TDM, BLOCO X e ATO/COTEPE 17/04 de Todas as mem$$HEX1$$f300$$ENDHEX$$rias Vers$$HEX1$$e300$$ENDHEX$$o 2.0.
*/

Choose Case pl_tipo_geracao
	Case 0
		ll_tipo_mf = 21		
	Case 1
		ll_tipo_mf = 22		
	Case 3
		ll_tipo_mf = 23			
End Choose

ll_pos = PosA(ps_endereco, '.txt')
ls_arquivo_retorno = MidA(ps_endereco, 1, ll_Pos - 1)

//Tipos arquivo MFD:  0 = Data   /  1 = RDZ   /  2 = COO   /   3 = Total
Choose Case ps_tipo
	Case 'D'
		ll_tipo = 0
	Case 'Z'
		ll_tipo = 1
	Case 'C'
		ll_tipo = 2
	Case 'T'
		ll_tipo = 3
End Choose

//Tipos Espelhos = pl_espelhos
/*
0 $$HEX1$$1320$$ENDHEX$$ N$$HEX1$$e300$$ENDHEX$$o gerar espelhos
1 $$HEX1$$1320$$ENDHEX$$ CF, 2 $$HEX1$$1320$$ENDHEX$$ RZ, 4 $$HEX1$$1320$$ENDHEX$$ LMF, 8 $$HEX1$$1320$$ENDHEX$$ LX, 16 $$HEX1$$1320$$ENDHEX$$ RG, 32 $$HEX1$$1320$$ENDHEX$$ CCD, 64 $$HEX1$$1320$$ENDHEX$$ NF, 128 - CNF
255 $$HEX1$$1320$$ENDHEX$$ Gerar todos os espelhos
256 $$HEX1$$1320$$ENDHEX$$ Gerar XML de cupom fiscal
*/

ls_arquivo_mf = ps_dir_mfd + 'Download.MF'
ls_arquivo_mfd = ps_dir_mfd + 'Download.MFD'

Filedelete(ls_arquivo_mf)
Filedelete(ls_arquivo_mfd)

//Gera binarios
ll_retorno = This.of_verifica_retorno_ecf(EPSON_Obter_Arquivos_Binarios(ps_inicio, ps_final, ll_tipo, ls_arquivo_mf, ls_arquivo_mfd),'EPSON_Obter_Arquivos_Binarios', false)
If ll_retorno <> 1 Then
	Return False
End If	

Do While ll_Retry <= 3	

	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_Obter_Dados_Arquivos_MF_MFD(ps_inicio,ps_final,ll_tipo, pl_espelhos, ll_tipo_mf, 0, ls_arquivo_retorno,ls_arquivo_mf,ls_arquivo_mfd),'EPSON_Obter_Dados_Arquivos_MF_MFD', false)
	
	Choose Case ll_Retorno
		Case 1 				// Comando OK
			If FileExists(ls_arquivo_retorno+'_CTP.txt') Then
				FileCopy(ls_arquivo_retorno+'_CTP.txt',ps_endereco,False)
				Filedelete(ls_arquivo_retorno+'_CTP.txt')				
			End If
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

public function boolean of_totaliza_recebimento_nao_fiscal (string ps_pagamento, string ps_valor, string ps_descricao);If This.ivb_Modo_Teste Then Return True

Long    ll_Retry
Long    ll_Retorno
String ls_valor

ls_valor	= gf_replace(ps_valor,',','',0)

Do While ll_Retry <= 3

	ll_Retorno = This.of_Verifica_Retorno_ECF(EPSON_NaoFiscal_Pagamento(ps_pagamento, ls_valor, 2, ps_descricao, ""),'EPSON_NaoFiscal_Pagamento', False)

	Choose Case ll_Retorno
		Case 1 				// Comando OK
			Exit
		Case Else 				// Erro ao executar comando
			Return False
	End Choose
	
	ll_Retry ++
	
Loop

Return True
end function

on uo_epson.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_epson.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;EPSON_Serial_Fechar_Porta()
end event

