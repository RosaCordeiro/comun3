HA$PBExportHeader$uo_sitef.sru
forward
global type uo_sitef from nonvisualobject
end type
end forward

global type uo_sitef from nonvisualobject
end type
global uo_sitef uo_sitef

type prototypes
FUNCTION Long ObtemVersao(Ref String VersaoCliSiTef,Ref String VersaoCliSiTefI) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ObtemVersao;Ansi";

FUNCTION Long ConfiguraIntSiTefInterativo( Ref String pServidor, Ref String pLoja, Ref String pTerminal, String Reservado) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ConfiguraIntSiTefInterativo;Ansi";

FUNCTION Long ConfiguraIntSiTefInterativoEx( Ref String pServidor, Ref String pLoja, Ref String pTerminal, String Reservado, String ParAdicionais) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ConfiguraIntSiTefInterativoEx;Ansi";

FUNCTION Long IniciaFuncaoSiTefInterativo(Long pModalidade, String pValor,String pCupom, String pDataFiscal, String pHorario, String pOperador, String pRestricoes) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "IniciaFuncaoSiTefInterativo;Ansi";

FUNCTION Long ContinuaFuncaoSiTefInterativo(Ref Long pComando, Ref Long pTipoCampo, Ref Integer pTamMin ,Ref Integer pTamMax ,Ref Char Buffer[0 to 20000],Long TamBuffer,Long Continua) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ContinuaFuncaoSiTefInterativo;Ansi";

FUNCTION Long ConfiguraIntSiTefInterativoA(Ref String Resultado, String pEnderecoIP, String pCodigoLoja, String pNumeroTerminal, String Reservado) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ConfiguraIntSiTefInterativoA;Ansi";

FUNCTION Long ContinuaFuncaoSiTefInterativoA(Ref String  Resultado, Ref String pComando,Ref String pTipoCampo, Ref String pTamMin ,Ref String pTamMax ,Ref String Buffer,Long TamBuffer,Long Continua) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ContinuaFuncaoSiTefInterativoA;Ansi";

FUNCTION Long FinalizaTransacaoSiTefInterativo (Integer Confirma, String CupomFiscal, String Data, String Horario) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "FinalizaTransacaoSiTefInterativo;Ansi";

FUNCTION Long FinalizaFuncaoSiTefInterativo (Integer Confirma, String CupomFiscal, String Data, String Horario, String ParamAdic) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "FinalizaFuncaoSiTefInterativo;Ansi";

FUNCTION Long LeCartaoDireto( String pMensagem, Ref String pTrilha1, Ref String pTrilha2) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "LeCartaoDireto;Ansi";

FUNCTION Long InterrompeLeCartaoDireto() library "c:\sistemas\dll\sitef\CliSiTef32I.dll";

FUNCTION Long LeCartaoDiretoEx( String pMensagem, Ref String pTrilha1, Ref String pTrilha2, Long TimeOut, Long TestaCancela ) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "LeCartaoDiretoEx;Ansi";

FUNCTION Long LeCartaoInterativo(String pMensagem) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "LeCartaoInterativo;Ansi";

FUNCTION Long LeSenhaInterativo( String pParametros ) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "LeSenhaInterativo;Ansi";

FUNCTION Long LeSenhaDireto( String pParametros, Ref String pSenha) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "LeSenhaDireto;Ansi";

FUNCTION Long VerificaPresencaPinPad() library "c:\sistemas\dll\sitef\CliSiTef32I.dll";

FUNCTION Long ValidaCampoCodigoEmBarras(Ref String pDados, Ref String pTipo) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ValidaCampoCodigoEmBarras;Ansi";

FUNCTION Long LeSimNaoPinPad(String pMensagem) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "LeSimNaoPinPad;Ansi";

FUNCTION Long ObtemQuantidadeTransacoesPendentes(String pData, String pCupom) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ObtemQuantidadeTransacoesPendentes;Ansi";

FUNCTION Long LeCartaoDiretoSeguro( String pMensagem, Ref String pTipoCampoTrilha1, Ref String pTrilha1, Ref String pTipoCampoTrilha2, Ref String pTrilha2, Integer pTimeout , Integer TestaCancelamento) library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "LeCartaoDiretoSeguro;Ansi";

/// TRANSA$$HEX2$$c700c200$$ENDHEX$$O VIDALINK

FUNCTION Long IniciaFuncaoSiTefInterativoConsultaVidalink(String pAutorizacao, String pProduto, String pCupom, String pDataFiscal, String pHorario, String pOperador) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "IniciaFuncaoSiTefInterativoConsultaVidalink;Ansi";

FUNCTION Long InformaProdutoVendaVidalink (Integer pIndiceProduto, String pProduto, Integer pQuantidade, String pValorVenda) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "InformaProdutoVendaVidalink;Ansi";

FUNCTION Long IniciaFuncaoSiTefInterativoVendaVidalink(String pAutorizacao, Integer pNumeroProdutos, String pCuponFiscal, String pDataFiscal, String pHorario, String pOperador) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "IniciaFuncaoSiTefInterativoVendaVidalink;Ansi";

FUNCTION Long InformaProdutoCancelamentoVidalink(Integer pIndiceProduto, String pCodigoProduto, Integer pQuantidade) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "InformaProdutoCancelamentoVidalink;Ansi";

FUNCTION Long IniciaFuncaoSiTefInterativoCancelamentoVidalink (Integer pParcialTotal, Integer pNumeroProdutos, String pCuponFiscalOriginal, String pDataFiscalOriginal, String pNumeroDocumentoOriginal, String pNumeroTerminalOriginal, String pCuponFiscal, String pDataFiscal, String pHorario, String pOperador) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "IniciaFuncaoSiTefInterativoCancelamentoVidalink;Ansi";

// COMUNICA$$HEX2$$c700c200$$ENDHEX$$O DIRETA

FUNCTION Long EnviaRecebeSiTefDireto(Long RedeDestino, Long FuncaoSiTef, Long OffsetCartao, Char DadosTx[], Long TamDadosTx, Ref Char DadosRx[0 To 10000], Long TamMaxDadosRx, Ref Long CodigoResposta, Ref Long TempoEsperaRx, String pCupom, String pDataFiscal, String pHorario, String pOperador, Long TipoOperacao) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "EnviaRecebeSiTefDireto;Ansi";

FUNCTION Long ForneceParametroEnviaRecebeSiTefDireto(Long IndiceParametro, String Parametro, Long ParametroCartao, Long Delimitador) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ForneceParametroEnviaRecebeSiTefDireto;Ansi";

FUNCTION Long ExecutaEnviaRecebeSiTefDireto(Long RedeDestino, Long FuncaoSiTef, Ref Long CodigoResposta, Long TempoEsperaRx, String pCupom, String pDataFiscal, String pHorario, String pOperador, Long TipoTransacao) Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ExecutaEnviaRecebeSiTefDireto;Ansi";

FUNCTION Long ObtemRetornoEnviaRecebeSiTefDireto(Ref String CodigoServico, Ref Char DadosServico[1 To 20000], Long TamMaxServico)  Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ObtemRetornoEnviaRecebeSiTefDireto;Ansi";

SUBROUTINE ObtemRetornoEnviaRecebeSiTefDiretoA(Ref String Resultado, Ref Char CodigoServico,  Ref Char DadosServico[0 To 10000], Long TamMaxServico) ALIAS FOR "ObtemRetornoEnviaRecebeSiTefDiretoA;Ansi" Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" ;

FUNCTION Long ObtemInformacoesPinPad(Ref String InfoPinPad)  Library "c:\sistemas\dll\sitef\CliSiTef32I.dll" alias for "ObtemInformacoesPinPad;Ansi";
end prototypes

type variables
Constant String CHAVE_TUICCS 	= '61833EA0A1A736923158713C9E1FB1BD914F1483B1039E85AB4EF151A2C78D738329AE912A27ACEA4B8E3B4744C9E52280D5DA671FA5248AB03304A51101E3404A0B010149E251B003F04E294FDE225AF5792A60CDE586EC258714F1F0B04D3E2C16A2A3FF4B4A661C50E8AA85158F73E1D036C2D4264C498F449412E09EF6C3DC931E596B54FFBE5ABE1150960374503DFDE35D33D80B11E11BE7941F47E372FADC5BE5D821C77E52B436319631DD9B7FF51A04C8F2B7AFF6B47AF444D0937C471CB43052F3CE60200AE86DE1A36A1450FA967514AAFFFAF3F1C07355D4BE3AC70DF10EDE183229714F0D90A3559A0D8811D1BE0BFEE69B2F4BD1B9EC28745956721F'
Constant String BIN_TUICCS 		= '005187'

dc_uo_ds_base ds_servico
dc_uo_ds_base ds_Autorizacao
dc_uo_ds_base ds_cancelamento

uo_TrnCentre_Sitef TrnCentre
uo_Vidalink_Sitef     Vidalink
uo_ePharma_Sitef   ePharma
uo_edm_sitef           EdmCard
uo_PharmaSystem pharmaSystem
uo_Funcional_Card Funcional

LONG     cd_funcao
LONG     cd_funcao_principal
LONG     cd_funcao_pgto
LONG     nr_pdv
LONG     nr_ecf
LONG     id_Status
LONG     qt_parcelas
LONG     nr_parcelas_maximo
LONG     nr_cupom
Long     tipo_campo
Long 		qt_Produtos
Long 		qt_Enviados
LONG		qt_parcelas_gen
Long		nr_nf

//Grava o tipo de venda (TRN, PHARMA SYS, VL, CC, CD)
STRING is_Tipo_Venda

STRING cd_Rede
STRING id_pinpad
STRING nr_porta_pinpad
STRING id_tef_ativo
STRING id_captura_transacao
STRING nr_servidor_tef
STRING id_empresa_tef
STRING de_terminal_tef
STRING id_venda_trncentre
STRING id_venda_vidalink
STRING de_senha_capturada
STRING de_dado_captura_pinpad
STRING cd_tipo_cpatura_pinpad
STRING de_tam_mim_captura
STRING de_tam_max_captura

STRING msg_cliente
STRING msg_operador

STRING cd_modalidade
STRING cd_forma_pagamento
STRING cd_forma_pagamento_original
STRING de_modalidade
STRING cd_autorizadora
STRING cd_bandeira
STRING de_bandeira
STRING cd_estabelecimento
STRING nr_nsu_sitef
STRING nr_nsu_host
STRING nr_nsu_gift_recarga
STRING nr_autorizacao
STRING nr_cartao
STRING nr_cartao_gift
STRING nr_bin_cartao
STRING de_via_cliente
STRING de_via_caixa
STRING de_bandeira_gen
STRING nr_cpf_cgc
STRING de_texto_nao_fiscal
STRING nr_versao_dll
STRING nr_identificador_pgto
STRING cd_autorizadora_recarga
STRING de_produto_gift //Usado venda PIN gift.
STRING cd_ean_gift //Usado venda PIN gift.

// Leitura Cart$$HEX1$$e300$$ENDHEX$$o Magn$$HEX1$$e900$$ENDHEX$$tico

BOOLEAN id_Cartao_Digitado
STRING de_Cartao_Digitado
STRING de_Cartao_Trilha1
STRING de_Cartao_Trilha2

STRING cd_caixa

STRING de_operador
STRING de_restricao
STRING de_operadora
STRING nr_celular
STRING de_vendedor

STRING nr_vidalink_autorizacao
STRING nr_vidalink_cnpj
STRING de_vidalink_plano
STRING de_cancelamento

//Recupera dados do cart$$HEX1$$e300$$ENDHEX$$o caso seja Disque
String nr_cartao_disque
String dh_validade_cartao_disque
String cd_seguranca_cartao_disque

LONG     nr_vidalink_produtos

BOOLEAN Impressao = False
BOOLEAN CompraSaque = False
BOOLEAN id_transacao_interrompida = False

//Valida$$HEX2$$e700e300$$ENDHEX$$o para forma de pagamento de recarga
BOOLEAN Recarga = False
BOOLEAN Recebimento = False
BOOLEAN Gerencial = False
BOOLEAN Comprovante_Nao_Fiscal = True
BOOLEAN Retaguarda = False
BOOLEAN ib_NFCE = FALSE

BOOLEAN ConsultaBin = False
BOOLEAN Iniciou_Erro = False
BOOLEAN SolicitacaoSenha = False
BOOLEAN Pendente = False
BOOLEAN id_venda_pin
BOOLEAN id_permite_cancelar_gift = False
BOOLEAN id_pgto_carteira_digital  //Usado nas transa$$HEX2$$e700f500$$ENDHEX$$es Gift Card e Recarga celular

DATETIME dt_transacao
DATETIME dt_predatado
DATETIME dt_operacao_tef

INTEGER nr_vias_comprovante_tef
INTEGER nr_controle_caixa

DECIMAL {2} vl_transacao
DECIMAL {2} vl_total_transacao
DECIMAL {2} vl_total_pbm
DECIMAL {2} vl_saque
DECIMAL {2} vl_parcela_minima

STRING 	is_Historico
STRING 	is_Recibo
STRING	is_matricula_operador
STRING	is_rede_filial
LONG		il_cd_conta_fluxo_caixa_recarga

//Variaveis CARTEIRA DIGITAL
DECIMAL {2} vl_aprovado_carteira
DECIMAL {2} vl_desconto_carteira
STRING cd_carteira_digital_tef
STRING nm_carteira_ditital
STRING qr_code_estabelecimento
STRING is_msg_cliente
STRING nr_nsu
STRING cd_instituicao_financeira
STRING nr_nsu_fepas //NSU_HOST de CATEIRA DITITAL (ITI)
STRING cd_autorizacao_carteira
STRING cd_tipo_uso_cd

//Convenio
String is_Identificacao_Conveniado //CPF ou Matricula

String is_nova_data_parcelamento


end variables

forward prototypes
public function boolean of_leitura_senha (string aparametros)
public function boolean of_leitura_senha_direto (string aparametros, ref string asenha)
public function boolean of_verifica_pinpad ()
public function boolean of_transacao_cancelamento ()
public function boolean of_reimpressao_ultimo_comprovante ()
public function boolean of_transacao_gerencial ()
public function boolean of_transacao_pre_autorizacao (decimal avalor, long acupomfiscal, datetime adata, string aoperador)
public function boolean of_transacao_captura_pre_autorizacao ()
public function boolean of_solicita_autorizacao ()
public function boolean of_informa_produto_venda_vidalink (long pl_indice, string ps_produto, long pl_quantidade, decimal pdc_valor)
public function boolean of_forma_pagamento_recarga (ref string ps_opcao)
public function boolean of_verifica_versao_dll ()
public function boolean of_transacao_registra_produto_vidalink (long aindice, string aproduto, long aquantidade, string avalor)
public function boolean of_mensagem_operador (string ps_mensagem)
public function boolean of_transacao_consulta_vidalink (datetime adata, string aoperador)
public function long of_sitef_direto_parametro (long indice, string parametro, long parametrocartao, long delimitador)
public function boolean of_sitef_direto_servicox (string ps_dados)
public function boolean of_leitura_cartao_interativo (ref string ps_digitado, ref string ps_trilha1, ref string ps_trilha2)
public function boolean of_leitura_cartao ()
public function boolean of_leitura_cartao (string ps_titulo)
public function boolean of_parametros_leitura_cartao (ref long pl_indice)
public function boolean of_sitef_direto_servicoa (string ps_dados)
public function boolean of_sitef_direto_servicon (string ps_dados)
public function boolean of_sitef_direto_servicoh (string ps_dados)
public function boolean of_sitef_direto_servico ()
public function boolean of_trncentre_parametro_produto (long pl_indice)
public function boolean of_sitef_direto_servicod (String ps_Dados)
public function boolean of_cancela_pinpad ()
public function boolean of_epharma_consulta_autorizacao (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_vidalink_autorizacao (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_epharma_parametro_produto (long pl_indice)
public function boolean of_edm_abertura_venda ()
public function long of_sitef_direto_executa (long rededestino, long funcaositef, ref long codigoresposta, long tempoexperarx, string cupom, string datafiscal, string horario, string operador, long tipooperacao)
public function boolean of_versao_dll ()
public function boolean of_valida_parcela_minima (long pl_campo, string ps_parcela)
public function boolean of_valida_valor_saque (long pl_campo, string ps_saque)
public function boolean of_sequencial_comprovante_prevenda (string acaixa, long acontrole_caixa, ref long asequencial)
public function boolean of_verifica_dll ()
public function boolean of_valor_parcela_minima ()
public function long of_envia_recebe_direto (long rededestino, long funcaositef, long offsetcartao, string dadostx, ref string dadosrx, ref long codigoresposta, ref long tempoexperarx, string cupom, string datafiscal, string horario, string operador, long tipooperacao)
public function boolean of_mensagem_operador (string ps_mensagem, boolean pb_cancelar)
public function integer of_oculta_dados_cartao ()
public subroutine of_valida_bandeira_produto (ref string ps_bandeira)
public function boolean of_localiza_cupom_fiscal (long afuncao, datetime adata, long aecf, long acupom, ref long afilial, ref long adoc, ref string aespecie, ref string aserie)
public function boolean of_localiza_cupom_fiscal (datetime adata, long aecf, long acupom)
public function boolean of_habilita_compra_saque ()
public function boolean of_transacao_pagamento_edm (decimal avalor, long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_transacao_prevenda (decimal avalor, long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_sitef_direto_retorno ()
public function boolean of_transacao_pharmasystem_autorizacao (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_configura_automatico ()
public function boolean of_transacao_cancelamento_credito_debito (datetime adata, string aoperador)
public function boolean of_transacao_consulta_cheque ()
public function boolean of_finaliza_transacao_prevenda ()
public function boolean of_configura ()
public function boolean of_registra_impressao_comprovante ()
public function boolean of_trncentre_abertura_venda ()
public function boolean of_sequencial_comprovante_caixa (string acaixa, long acontrole_caixa, ref long asequencial)
public function long of_verifica_transacao_pendente_servidor ()
public function boolean of_trncentre_autorizacao (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_inclui_cartao_comprovante_venda (string acaixa, long acontrole_caixa, long aecf, long acupom)
public subroutine of_controle_arquivos_log ()
public function boolean of_transacao_tef (long afuncao)
public function boolean of_inicia_funcao_tef ()
public function boolean of_transacao_tef (long afuncao, string arestricao)
public function boolean of_transacao_trncentre_abertura ()
public function boolean of_transacao_trncentre_new (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_trncentre_cancela_autorizacao ()
public function boolean of_trncentre_cancelar_venda (datetime adata, string aoperador, long aecf, string acaixa, long acontrole_caixa)
public function boolean of_reimpressao_comprovante_especifico ()
public function boolean of_impressao_cancelamento_pbm ()
public function boolean of_trncentre_carga_tabela ()
public function boolean of_trncentre_carga_tabela_operadora ()
public function boolean of_registra_prevenda ()
public function boolean of_funcional_consulta_autorizacao ()
public function boolean of_cancela_transacao ()
public function boolean of_cancela_transacao (boolean pb_mostra_resumo)
public function boolean of_confirma_transacao ()
public function boolean of_confirma_transacao (boolean pb_mostra_resumo)
public function boolean of_inicia_comunicacao ()
public function boolean of_inclui_cartao_comprovante_prevenda (string acaixa, long acontrole_caixa, long aecf, long acupom)
public function boolean of_inicializa_comprovante_tef (boolean pb_erro)
public function boolean of_transacao_administrativa (datetime adata, string aoperador, long aecf, string acaixa, long acontrole_caixa)
public function boolean of_continua_impressao_comprovante_new ()
public function boolean of_lanca_comprovante_caixa ()
public function boolean of_busca_bandeira (string ps_tipo_cartao, long pl_codigo, long pl_administradora, ref string ps_nome_bandeira)
public function boolean of_inicializa ()
public function boolean of_transacao_pagamento (string atransacao, decimal avalor, long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function string of_mensagem_produto ()
public function boolean of_continua_impressao_comprovante ()
public function boolean of_dados_produtos_venda (long pl_produto, long pl_grupo_produto, string ps_descricao, string ps_barras, long pl_quantidade, decimal pdc_preco_praticado, decimal pdc_desconto, decimal pdc_desconto_padrao, string ps_prescrito)
public function boolean of_impressao_comprovante ()
public function boolean of_parcela_minima (string ps_bandeira)
public function boolean of_pergunta_tentativa (boolean pvb_abrindo, boolean pvb_gerencial)
public function boolean of_registra_transacao_tef_pendente ()
public function boolean of_restricao_funcao (string ps_tipo, ref string ps_restricao)
public function boolean of_biblioteca ()
public function boolean of_controla_interacao_dll ()
public subroutine of_verifica_bin_generico (string ps_bin)
public function boolean of_impressao_comprovante_bkp ()
public function boolean of_funcional_cancelar_venda (datetime adata, string aoperador, long aecf, string acaixa, long acontrole_caixa)
public function boolean of_funcional_finaliza_venda (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_transacao_funcional_tef (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_localiza_nfce (datetime adata, string ps_serie, string ps_especie, long pl_nfce)
public function boolean of_localiza_nfce (long afuncao, datetime adata, long aecf, long anf, ref long afilial, ref long adoc, ref string aespecie, ref string aserie)
public function boolean of_epharma_autorizacao (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa, string ps_tipo_venda)
public function boolean of_trncentre_autorizacao_new (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa, string ps_tipo_venda)
public function boolean of_cancela_transacao (boolean pb_nfce, long pl_nr_nf, boolean pb_mostra_resumo)
public function boolean of_transacao_pendente_caixa (string ps_caixa, long pl_nf, string ps_especie, string ps_serie, boolean pb_nfce)
public function boolean of_transacao_pendente (long pl_ecf, string ps_caixa)
public function boolean of_finaliza_transacao (boolean pb_nfce, long pl_nr_nf)
public function boolean of_vidalink_dados_produto (long pl_indice, string ps_produto, long pl_quantidade, decimal pdc_valor)
public function boolean of_transacao_venda_vidalink (long aprodutos, string ps_tipo)
public function boolean of_captura_senha (string ps_senha)
public function boolean of_verifica_pinpad_sem_msg ()
public function boolean of_restricao_funcao (string ps_tipo[], ref string ps_restricao)
public function boolean of_monta_parcelas_cartao (ref string ps_parcelas)
public function long of_confirmacao_pinpad (string ps_mensagem)
public function boolean of_trncentre_dados_produto_autorizacao (long pl_produto, long pl_grupo_produto, string ps_descricao, string ps_barras, long pl_quantidade, decimal pdc_preco_bruto, decimal pdc_desconto, decimal pdc_desconto_padrao, long pl_sequencial)
public function boolean of_teste_conexao_bd ()
public function boolean of_atualiza_inf_pinpad (string ps_caixa)
public function boolean of_lanca_recarga_celular_filial ()
public function boolean of_confirmacao_pinpad (string ps_mensagem, ref integer pi_retorno_pinpad)
public function boolean of_transacao_giftcard (datetime adata, string aoperador, string acaixa, long acontrole_caixa, string atipo, string apgto)
public function boolean of_transacao_recarga (datetime adata, string aoperador, string acaixa, long acontrole_caixa, string apgto)
public function boolean of_lanca_venda_giftcard ()
public function boolean of_retorna_carteiras (ref string ps_carteiras)
public function boolean of_retorna_cartao_produto (string ps_autorizadora, string ps_cod_bandeira, string ps_bandeira, ref string ps_cartao_produto)
public function boolean of_busca_cnpj (string ps_autorizadora, string ps_produto, string ps_cod_bandeira, ref string ps_cnpj, ref long pl_bandeira_sefaz)
public function boolean of_transacao_saque_pix (decimal avalorsaque, datetime adata, string aoperador, string acaixa, long acontrole_caixa, string avendedor)
public function boolean of_lanca_movimento_pix (string ps_tipo, string ps_caixa_lancamento, long pl_controle_lancamento, string ps_caixa_transacao, long pl_sequencial_cartao, long pl_sequencial_caixa)
public function boolean of_captura_dados_pinpad (decimal avalorsaque, string aoperador, string acaixa, long acontrole_caixa, string avendedor, string acodigocaptura, string atamanhomin, string atamanhomax)
public function boolean of_captura_pinblock (string as_identificacao_conveniado)
public function boolean of_transacao_cartao_presente_saldo (long aecf, long acupomfiscal, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_transacao_cartao_presente_estorno (string as_cartao, string as_nsu, decimal adc_valor, date adt_movimento, string as_operador, string as_caixa, long al_controle_caixa, long al_ecf, long al_cupom)
end prototypes

public function boolean of_leitura_senha (string aparametros);
Long ll_Retorno

ll_Retorno = LeSenhaInterativo(aParametros)

Choose Case ll_Retorno
	Case 0
		//lb_Sucesso = This.of_Controla_Interacao_dll()
		Return True
End Choose

Return False
end function

public function boolean of_leitura_senha_direto (string aparametros, ref string asenha);
Long ll_Retorno

asenha = Space(20)

ll_Retorno = LeSenhaDireto(aParametros,Ref aSenha)

gvo_Aplicacao.of_Grava_Log( "uo_sitef - of_leitura_senha_direto - Retorno fun$$HEX2$$e700e300$$ENDHEX$$o TEF: " + String(ll_retorno))	

Choose Case ll_Retorno
	Case 0
		Return True
End Choose

Return False
end function

public function boolean of_verifica_pinpad ();Long ll_Retorno

ll_Retorno = VerificaPresencaPinPad() 

Choose Case ll_Retorno
	Case -1	
		MessageBox('Sitef','Biblioteca de comunica$$HEX2$$e700e300$$ENDHEX$$o com o PINPAD n$$HEX1$$e300$$ENDHEX$$o foi localizada.',StopSign!)
	Case 0
		MessageBox('Sitef','N$$HEX1$$e300$$ENDHEX$$o existe PINPAD conectado !',Exclamation!)
	Case 1
//		MessageBox('Sitef','PINPAD conectado !')
		Return True
End Choose		

Return False
end function

public function boolean of_transacao_cancelamento ();Boolean lb_Sucesso

lb_Sucesso = This.of_Transacao_Tef(200)

//This.of_Transacao_Pendente()

Return lb_Sucesso
end function

public function boolean of_reimpressao_ultimo_comprovante ();Boolean lb_Sucesso

lb_Sucesso = This.of_Transacao_Tef(114)

//This.of_Transacao_Pendente()

Return lb_Sucesso
end function

public function boolean of_transacao_gerencial ();
Return This.of_Transacao_Tef(110)
end function

public function boolean of_transacao_pre_autorizacao (decimal avalor, long acupomfiscal, datetime adata, string aoperador);
// Transacao pr$$HEX1$$e900$$ENDHEX$$-autoriza$$HEX2$$e700e300$$ENDHEX$$o
	
Boolean lb_Sucesso = False

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
This.cd_funcao    = 116
This.nr_cupom     = acupomfiscal
This.dt_transacao = gf_getserverdate()
This.vl_transacao = avalor
This.de_operador  = aoperador
This.de_restricao = ''

If This.of_Inicia_Funcao_Tef() Then
	lb_Sucesso = This.of_Controla_Interacao_dll()
End If

Return lb_Sucesso
end function

public function boolean of_transacao_captura_pre_autorizacao ();Boolean lb_Sucesso

lb_Sucesso = This.of_Transacao_Tef(115)

//This.of_Transacao_Pendente()

Return lb_Sucesso
end function

public function boolean of_solicita_autorizacao ();String ls_Parametro

Integer li_TamMin = 0
Integer li_TamMax = 12

ls_Parametro = String(30,'00000')+';'+String(li_TamMin,'00000')+';'+String(li_TamMax,'00000')+';N$$HEX1$$fa00$$ENDHEX$$mero da Autoriza$$HEX2$$e700e300$$ENDHEX$$o'

//Solicita n$$HEX1$$fa00$$ENDHEX$$mero da autoriza$$HEX2$$e700e300$$ENDHEX$$o
OpenWithParm(w_ge084_coleta_campo,ls_Parametro)

ls_Parametro = Message.StringParm

If ls_Parametro = "CANCELAR" Then Return False

This.nr_vidalink_autorizacao = Trim(ls_Parametro)

Return True

end function

public function boolean of_informa_produto_venda_vidalink (long pl_indice, string ps_produto, long pl_quantidade, decimal pdc_valor);
String ls_Valor

ls_Valor = String(pdc_valor)

If InformaProdutoVendaVidalink(pl_indice,ps_produto,pl_quantidade,ls_Valor) = 0 Then Return True

Return False
end function

public function boolean of_forma_pagamento_recarga (ref string ps_opcao);
If This.cd_funcao <> 300 Then Return True

If IsNull(This.de_operadora) or Upper(This.de_operadora) <> "CLARO" Then Return True

String ls_Temp
String ls_Forma

Long ll_Pos
Long ll_Byte

ll_Pos = PosA(Upper(ps_opcao),"CREDITO") + PosA(Upper(ps_opcao),"DEBITO")

If ll_Pos = 0 Then Return True

ll_Byte = 1

Do
	
	ll_Pos = PosA(ps_opcao,';',ll_Byte)
	
	If ll_Pos > 0 Then
		If PosA(MidA(Upper(ps_opcao),ll_Byte,ll_Pos),"CREDITO") + PosA(MidA(Upper(ps_opcao),ll_Byte,ll_Pos),"DEBITO") = 0 Then
	 		ls_Temp += MidA(ps_opcao,ll_Byte,ll_Pos)
		End If
		ll_Byte  = ll_Pos + 1
	Else
		ll_Byte ++
	End If	
	
Loop Until ll_Byte > LenA(ps_opcao)

ps_opcao = ls_temp

Return True
end function

public function boolean of_verifica_versao_dll ();
Long   ll_Retorno

String ls_CliSitef  = Space(64)
String ls_CliSitefI = Space(64)

ll_Retorno = ObtemVersao(ls_CliSitef, ls_CliSitefI)

If ll_Retorno <> 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao verificar vers$$HEX1$$e300$$ENDHEX$$o da CliSitef.",StopSign!)
	Return False
End If

This.nr_versao_dll = ls_CliSitef

//If lower('1.01.c.094.61') <> ls_CliSitef Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Vers$$HEX1$$e300$$ENDHEX$$o CliSitef.dll " + ls_CliSitef + " desatualizada. Favor contactar suporte.",Exclamation!)
//End If
//
//If lower('1.01.a.55') <> ls_CliSitefI Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Vers$$HEX1$$e300$$ENDHEX$$o CliSitef.dll " + ls_CliSitefI + " desatualizada. Favor contactar suporte.",Exclamation!)
//End If

Return True

end function

public function boolean of_transacao_registra_produto_vidalink (long aindice, string aproduto, long aquantidade, string avalor);
Boolean lb_Sucesso = False

This.id_Status = InformaProdutoVendaVidalink(aindice,&
                                             aproduto,&
															aquantidade,&
															avalor)

Choose Case This.id_Status
	Case 0
		MessageBox("Sitef","(0) Negada pelo autorizador.",Exclamation!)
	Case -1
		MessageBox("Sitef","(-1) M$$HEX1$$f300$$ENDHEX$$dulo n$$HEX1$$e300$$ENDHEX$$o inicializado.",StopSign!)
	Case -2
		MessageBox("Sitef","(-2) Opera$$HEX2$$e700e300$$ENDHEX$$o cancelada pelo operador.",Exclamation!)
	Case -3
		MessageBox("Sitef","(-3) Modalidade inv$$HEX1$$e100$$ENDHEX$$lida.",StopSign!)
	Case -4
		MessageBox("Sitef","(-4) Falta de mem$$HEX1$$f300$$ENDHEX$$ria para rodar a fun$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!)
	Case -5
		MessageBox("Sitef","(-5) Sem comunica$$HEX2$$e700e300$$ENDHEX$$o com o Sitef.",StopSign!)		
	Case 10000
		lb_Sucesso = True
End Choose

Return lb_Sucesso
end function

public function boolean of_mensagem_operador (string ps_mensagem);Return of_Mensagem_Operador(ps_mensagem,False)
end function

public function boolean of_transacao_consulta_vidalink (datetime adata, string aoperador);MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desabilitada Fun$$HEX2$$e700e300$$ENDHEX$$o of_transacao_consulta_vidalink()",Exclamation!)

Return False

//Long    ll_CupomFiscal
//Long    ll_Ecf
//
//Boolean lb_Sucesso = False
//
//If Not ds_vidalink.of_ChangeDataObject("dw_ge084_autorizacao_vidalink") Then Return False
//
//If Not This.of_Solicita_Autorizacao() Then Return False
//
//If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False
//
//ds_vidalink.Reset()
//
////Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
//This.nr_cupom     = ll_CupomFiscal
//This.nr_ecf       = ll_Ecf
//This.dt_transacao = DateTime(Date(adata),Now())
//This.vl_transacao = 000.00
//This.de_operador  = aoperador
//This.de_restricao = ''
//
//This.id_Status = IniciaFuncaoSitefInterativoConsultaVidalink(This.nr_Vidalink_Autorizacao,'0', String(This.nr_cupom,'00000000') , String(This.dt_transacao,'yyyymmdd') , String(This.dt_transacao,'hhmmss') , aoperador)
//
//Choose Case This.id_Status
//	Case 0
//		MessageBox("Sitef","(0) Negada pelo autorizador.",Exclamation!)
//	Case -1
//		MessageBox("Sitef","(-1) M$$HEX1$$f300$$ENDHEX$$dulo n$$HEX1$$e300$$ENDHEX$$o inicializado.",StopSign!)
//	Case -2
//		MessageBox("Sitef","(-2) Opera$$HEX2$$e700e300$$ENDHEX$$o cancelada pelo operador.",Exclamation!)
//	Case -3
//		MessageBox("Sitef","(-3) Modalidade inv$$HEX1$$e100$$ENDHEX$$lida.",StopSign!)
//	Case -4
//		MessageBox("Sitef","(-4) Falta de mem$$HEX1$$f300$$ENDHEX$$ria para rodar a fun$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!)
//	Case -5
//		MessageBox("Sitef","(-5) Sem comunica$$HEX2$$e700e300$$ENDHEX$$o com o Sitef.",StopSign!)
//	Case 10000
//
//		lb_Sucesso = This.of_Controla_Interacao_dll()
//		
//		If lb_Sucesso Then
//			
////			lb_Sucesso = of_Registra_Transacao_Vidalink()
//			
////			If Not lb_Sucesso Then This.of_Cancela_Transacao()
//
//		End If
//
//End Choose

//Return lb_Sucesso
end function

public function long of_sitef_direto_parametro (long indice, string parametro, long parametrocartao, long delimitador);
Long ll_Retorno 

SetPointer(HourGlass!)

ll_Retorno = ForneceParametroEnviaRecebeSiTefDireto(Indice,&
																	 Parametro,&
																	 ParametroCartao,&
																	 Delimitador)
																	 
If ll_Retorno < 0 Then
	MessageBox("Sitef Comunica$$HEX2$$e700e300$$ENDHEX$$o Direta","Erro ao fornecer par$$HEX1$$e200$$ENDHEX$$metro para Transa$$HEX2$$e700e300$$ENDHEX$$o Sitef Direto. $$HEX1$$cd00$$ENDHEX$$ndice " + String(Indice) + ' par$$HEX1$$e200$$ENDHEX$$metro: ' + Parametro ,StopSign!)
End If	

Return ll_Retorno
end function

public function boolean of_sitef_direto_servicox (string ps_dados);
String ls_Tipo

ls_Tipo = MidA(ps_Dados,1,1)

Choose Case ls_Tipo

	Case "o"								// Carga Operadoras - TRNCentre
		
		String ls_Menu
		String ls_Opcao

		Long   ll_Operadora
					
		For ll_Operadora = 1 To Long(MidA(ps_Dados,2,2))
			
 			ls_Menu += MidA(ps_Dados, -19 + (ll_Operadora * 23 ) ,3) + ':' + MidA(ps_Dados, -16 + (ll_Operadora * 23 ) ,20) + ';'
			 			
		Next
		
		ls_Menu = String(LenA(ls_Menu),'0000')+';'+ls_Menu+"TRNCentre - Sele$$HEX2$$e700e300$$ENDHEX$$o de Operadora"

		OpenWithParm(w_ge084_selecao_menu,ls_Menu)
		
		Yield()
		
		ls_opcao = Message.StringParm
	
		Choose Case ls_opcao
			Case "CANCELAR","VOLTAR"
				Return False
			Case Else
				
				This.TrnCentre.Cd_Operadora = Trim(ls_Opcao)
				This.TrnCentre.De_Operadora = MidA(ls_Menu,PosA(ls_Menu,Trim(ls_Opcao))+4,20)
				Return True
				
		End Choose
		
	Case "p" ; Return True
		
End Choose

Return False
end function

public function boolean of_leitura_cartao_interativo (ref string ps_digitado, ref string ps_trilha1, ref string ps_trilha2);
Long ll_Retorno
Long ll_Reservado
String ls_trilha1
String ls_trilha2
String ls_tipo1
String ls_tipo2

ll_Reservado = 0

ls_trilha1 		= Space(128)
ls_trilha2			= Space(80)
ls_tipo1			= Space(12)
ls_tipo2			= Space(12)

//ll_Retorno = LeCartaoDireto("Passe o cartao", Ref ls_trilha1, Ref ls_trilha2)
ll_Retorno = LeCartaoDiretoSeguro("Passe o cartao", Ref ls_tipo1, Ref ls_trilha1, Ref ls_tipo2, Ref ls_trilha2, 0, 0)

Choose Case ll_Retorno
	Case 0
		ps_trilha1 = ls_trilha1
		ps_trilha2 = ls_trilha2
		Return True
	Case 13
		MessageBox("Sitef","Leitura cancelada pelo Operador.",Exclamation!)
	Case Else
		MessageBox("Sitef","Erro ao executar a leitura do cart$$HEX1$$e300$$ENDHEX$$o.",StopSign!)
End Choose

Return False
end function

public function boolean of_leitura_cartao ();
String ls_Trilha1 = Space(128)
String ls_Trilha2 = Space(80)
String ls_tipo1 = Space(12)
String ls_tipo2 = Space(12)
Long ll_reservado = 0
Long ll_Retorno

If VerificaPresencaPinPad() = 1 Then  // Existe Pinpad conectado

	Do While True

		//ll_Retorno = LeCartaoDireto('Insira ou passe o cartao', ls_Trilha1, ls_Trilha2 )
		ll_Retorno = LeCartaoDiretoSeguro('Insira ou passe o cartao', Ref ls_tipo1, Ref ls_trilha1, Ref ls_tipo2, Ref ls_trilha2, 0, 0)			
		
		Choose Case ll_Retorno
			Case 0
				
				Sitef.Id_Cartao_Digitado = False
				Sitef.de_Cartao_Trilha1 = ls_Trilha1
				Sitef.de_Cartao_Trilha2 = ls_Trilha2
							
				Return True
			Case 13				
				Return False
				
			Case 41
				If MessageBox("Sitef","(41) Erro na leitura do cart$$HEX1$$e300$$ENDHEX$$o. Deseja repetir o procedimento ?",Question!,YesNo!,1) = 2 Then Return False
				
			Case Else
				MessageBox("Sitef","(8) Erro ao executar a leitura do cart$$HEX1$$e300$$ENDHEX$$o.",StopSign!)
		End Choose
		
	Loop
	
Else	
	MessageBox("Sitef","Pinpad n$$HEX1$$e300$$ENDHEX$$o foi detectado. Verifique se o mesmo encontra-se corretamente ligado.",Exclamation!)			
End If	

Return False
end function

public function boolean of_leitura_cartao (string ps_titulo);String ls_retorno

OpenWithParm(w_ge084_leitura_cartao,ps_Titulo)

ls_Retorno = Message.StringParm

If ls_Retorno = 'CANCELAR' Then Return False

Return True
end function

public function boolean of_parametros_leitura_cartao (ref long pl_indice);
String ls_LeituraCartao

String ls_Cartao
String ls_Trilha1
String ls_Trilha2

Long   ll_Delimitador = 0

If Not Sitef.id_Cartao_Digitado Then
	ls_LeituraCartao  = '1'
Else
	ls_LeituraCartao = '2'
End If	

pl_Indice ++

If Not of_Sitef_Direto_Parametro(pl_Indice,ls_LeituraCartao,0,0) = 0 Then Return False

If Sitef.id_Cartao_Digitado Then
	
	ls_Cartao = Sitef.de_Cartao_Digitado
	
	pl_Indice ++
	
	If Not of_Sitef_Direto_Parametro(pl_Indice,ls_Cartao,1,0) = 0 Then Return False
	
Else
	
	ls_Trilha1 = Sitef.de_Cartao_Trilha1
	ls_Trilha2 = Sitef.de_Cartao_Trilha2
	
	pl_Indice ++
	
	If Not IsNull(ls_Trilha1) and Trim(ls_Trilha1) <> '' Then ll_Delimitador = 4
	
	If Not of_Sitef_Direto_Parametro(pl_Indice,ls_Trilha2,1,ll_Delimitador) = 0 Then Return False
	
	If Not IsNull(ls_Trilha1) and Trim(ls_Trilha1) <> '' Then
		
		pl_Indice ++

		If Not of_Sitef_Direto_Parametro(pl_Indice,ls_Trilha1,1,0) = 0 Then Return False
		
	End If	

End If	

Return True
end function

public function boolean of_sitef_direto_servicoa (string ps_dados);
Return True

end function

public function boolean of_sitef_direto_servicon (string ps_dados);
Return True

end function

public function boolean of_sitef_direto_servicoh (string ps_dados);
String ls_Status

Boolean lb_Sucesso = False

ls_Status = MidA(ps_Dados,01,02)

Choose Case ls_Status
	Case "00"
		lb_Sucesso = True
	Case "SC"
		If MessageBox("Sitef Comunica$$HEX2$$e700e300$$ENDHEX$$o Direta","Confirma autoriza$$HEX2$$e700e300$$ENDHEX$$o da Transa$$HEX2$$e700e300$$ENDHEX$$o ?",Question!,YesNo!,2) <> 1 Then 
			lb_Sucesso = False
		Else
			lb_Sucesso = True
		End If			
	Case Else
		MessageBox("Sitef Comunica$$HEX2$$e700e300$$ENDHEX$$o Direta","Transa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o autorizada (" +  ls_Status + ")" ,Exclamation!)
		lb_Sucesso = False

End Choose

Return lb_Sucesso


end function

public function boolean of_sitef_direto_servico ();
Long ll_Servico
Long ll_Tamanho

String ls_Servico
String ls_Dados

If ds_Servico.RowCount() = 0 Then Return False

For ll_Servico = 1 To ds_Servico.RowCount()
	
	SetPointer(HourGlass!)

	ls_Servico = ds_Servico.object.id_servico[ll_Servico]
	ls_Dados   = ds_Servico.object.de_dados  [ll_Servico]
	ll_Tamanho = ds_Servico.object.nr_tamanho[ll_Servico]
	
	Choose Case ls_Servico
		Case 'A'
			If Not of_Sitef_Direto_ServicoA(ls_Dados) Then Return False
		Case 'D'	
			If Not of_Sitef_Direto_ServicoD(ls_Dados) Then Return False
		Case 'H'
			If Not of_Sitef_Direto_ServicoH(ls_Dados) Then Return False
		Case 'N'
			If Not of_Sitef_Direto_ServicoN(ls_Dados) Then Return False
		Case 'X'
			If Not of_Sitef_Direto_ServicoX(ls_Dados) Then Return False
	End Choose
	
Next

Return True
end function

public function boolean of_trncentre_parametro_produto (long pl_indice);
String ls_Barras
String ls_Quantidade
String ls_Preco

Long 	 ll_Row

For ll_Row = 1 To This.TrnCentre.ds_Autorizacao.RowCount()
		
	If This.TrnCentre.ds_Autorizacao.object.id_Erro[ll_Row] <> '00' Then Continue
	
	ls_barras     = LeftA(This.TrnCentre.ds_Autorizacao.object.de_codigo_barras[ll_Row]+Space(13),13)
	
	ls_quantidade = String(This.TrnCentre.ds_Autorizacao.object.qt_vendida[ll_Row],'000')
	
	pl_Indice ++
		
	//Codigo Barras Produto
	If of_Sitef_Direto_Parametro(pl_Indice,ls_barras,0,0) <> 0 Then Return False
	
	pl_Indice ++
	
	//Tipo Embalagem
	If of_Sitef_Direto_Parametro(pl_Indice,'U',0,0) <> 0 Then Return False
	
	pl_Indice ++
	
	//Quantidade Item
	If of_Sitef_Direto_Parametro(pl_Indice,ls_quantidade,0,0) <> 0 Then Return False
	
	ls_Preco = TrnCentre.of_Formata_Preco(This.TrnCentre.ds_Autorizacao.object.vl_preco_bruto[ll_Row],07)
	
	pl_Indice ++
	
	//Preco Bruto
	If of_Sitef_Direto_Parametro(pl_Indice,ls_Preco,0,0) <> 0 Then Return False
		
	ls_Preco = TrnCentre.of_Formata_Preco(This.TrnCentre.ds_Autorizacao.object.vl_preco_liquido[ll_Row],07)
	
	pl_Indice ++
	
	//Preco Liquido
	If of_Sitef_Direto_Parametro(pl_Indice,ls_Preco,0,0) <> 0 Then Return False
	
	ls_Preco = TrnCentre.of_Formata_Preco(This.TrnCentre.ds_Autorizacao.object.vl_preco_farmacia[ll_Row],07)
	
	pl_Indice ++
	
	//Preco Loja
	If of_Sitef_Direto_Parametro(pl_Indice,ls_Preco,0,0) <> 0 Then Return False
	
	ls_Preco = TrnCentre.of_Formata_Preco(This.TrnCentre.ds_Autorizacao.object.pc_desconto[ll_Row],05)
	
	pl_Indice ++
	
	//Desconto Produto
	If of_Sitef_Direto_Parametro(pl_Indice,ls_Preco,0,0) <> 0 Then Return False
	
	pl_Indice ++
	
	//Carga Complementar Produto
	If of_Sitef_Direto_Parametro(pl_Indice,Space(16),0,0) <> 0 Then Return False
		
Next	

If Not IsNull(Sitef.nr_Nsu_Sitef) Then
	
	pl_Indice ++
	
	//NSU Abertura de Venda TRNCentre
	If of_Sitef_Direto_Parametro(pl_Indice,'UNSU:'+Sitef.nr_Nsu_Sitef,0,0) <> 0 Then Return False

End If

Return True
end function

public function boolean of_sitef_direto_servicod (String ps_Dados);
If Not IsNull(ps_Dados) and Trim(ps_Dados) <> '' Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ps_Dados)

Return True
end function

public function boolean of_cancela_pinpad ();
Long ll_Retorno

ll_Retorno = InterrompeLeCartaoDireto()

If ll_Retorno = 0 Then Return True

Return False
end function

public function boolean of_epharma_consulta_autorizacao (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
If Not This.ePharma.of_Consulta_Autorizacao() Then Return False

Return True
end function

public function boolean of_vidalink_autorizacao (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
Long    ll_CodigoResposta
Long    ll_Indice
Long	  ll_Row
Long	  ll_cupomfiscal, ll_ecf

String  ls_Status

Boolean lb_Sucesso

If Not This.of_Solicita_Autorizacao() Then Return False

This.nr_cupom     = acupomfiscal
This.nr_ecf       = aecf
This.dt_transacao = gf_getserverdate()
This.vl_transacao = 000.00
This.de_operador  = aoperador
This.de_restricao = ''
This.cd_caixa          = acaixa
This.nr_controle_caixa = acontrole_caixa

is_Tipo_Venda = "VL"

This.id_Status = IniciaFuncaoSitefInterativoConsultaVidalink(This.nr_Vidalink_Autorizacao,'1', String(This.nr_cupom,'00000000') , String(This.dt_transacao,'yyyymmdd') , String(This.dt_transacao,'hhmmss') , aoperador)

Choose Case This.id_Status
	Case 0
		MessageBox("Sitef","(0) Negada pelo autorizador.",Exclamation!)
	Case -1
		MessageBox("Sitef","(-1) M$$HEX1$$f300$$ENDHEX$$dulo n$$HEX1$$e300$$ENDHEX$$o inicializado.",StopSign!)
	Case -2
		MessageBox("Sitef","(-2) Opera$$HEX2$$e700e300$$ENDHEX$$o cancelada pelo operador.",Exclamation!)
	Case -3
		MessageBox("Sitef","(-3) Modalidade inv$$HEX1$$e100$$ENDHEX$$lida.",StopSign!)
	Case -4
		MessageBox("Sitef","(-4) Falta de mem$$HEX1$$f300$$ENDHEX$$ria para rodar a fun$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!)
	Case -5
		MessageBox("Sitef","(-5) Sem comunica$$HEX2$$e700e300$$ENDHEX$$o com o Sitef.",StopSign!)
	Case 10000

		lb_Sucesso = This.of_Controla_Interacao_dll()		

End Choose

Return lb_Sucesso
end function

public function boolean of_epharma_parametro_produto (long pl_indice);
String ls_Barras
String ls_Quantidade
String ls_Preco

Long 	 ll_Row

pl_Indice ++

//Quantidade de Produtos
If of_Sitef_Direto_Parametro(pl_Indice,String(This.ePharma.ds_Autorizacao.RowCount(),'00'),0,0) <> 0 Then Return False

For ll_Row = 1 To This.ePharma.ds_Autorizacao.RowCount()
		
	ls_barras     = LeftA(This.ePharma.ds_Autorizacao.object.de_codigo_barras[ll_Row]+Space(13),13)
	
	ls_quantidade = String(This.ePharma.ds_Autorizacao.object.qt_autorizada[ll_Row],'00')
	
	pl_Indice ++
		
	//Codigo Barras Produto
	If of_Sitef_Direto_Parametro(pl_Indice,ls_barras,0,0) <> 0 Then Return False
	
	pl_Indice ++
	
	//Quantidade Item
	If of_Sitef_Direto_Parametro(pl_Indice,ls_quantidade,0,0) <> 0 Then Return False
		
Next

Return True
end function

public function boolean of_edm_abertura_venda ();
Long  ll_Retorno
Long  ll_CodigoResposta
Long  ll_Indice

String ls_Titulo
String ls_LeituraCartao = '1'
String ls_Cartao
String ls_Trilha1
String ls_Trilha2

ls_Titulo = 'EDMCard'

If Not of_Leitura_Cartao(ls_Titulo) Then Return False

This.TrnCentre.nr_Cartao = LeftA(Sitef.de_Cartao_Trilha2,PosA(Sitef.de_Cartao_Trilha2,'=')-1)

ll_Indice ++

//Transa$$HEX2$$e700e300$$ENDHEX$$o EDM
If of_Sitef_Direto_Parametro(ll_Indice,'56',0,0) = 0 Then
	
	ll_Indice ++

	//Envia Par$$HEX1$$e200$$ENDHEX$$metros da Leitura do Cart$$HEX1$$e300$$ENDHEX$$o
	If of_Parametros_Leitura_Cartao(Ref ll_Indice) Then
		
		ll_Indice ++
				
		//Indicador de Continua$$HEX2$$e700e300$$ENDHEX$$o
		If of_Sitef_Direto_Parametro(ll_Indice,'0',0,0) = 0 Then
					
			//Executa Solicita$$HEX2$$e700e300$$ENDHEX$$o ao Sitef 
			If of_Sitef_Direto_Executa(19, 240, Ref ll_CodigoResposta, 30, '', '', '', '', 1) = 0 Then
			
				//Obtem Retorno Sitef
				If Not of_Sitef_Direto_Retorno() Then Return False
				
				//Tratamento Retornos TRNCentre
				Return This.TrnCentre.of_Retorno_Abertura(ds_Servico)
											
			End If	
			
		End If	

	End If	
							
End If	
																										
Return False
end function

public function long of_sitef_direto_executa (long rededestino, long funcaositef, ref long codigoresposta, long tempoexperarx, string cupom, string datafiscal, string horario, string operador, long tipooperacao);Long ll_Retorno

SetPointer(HourGlass!)

ll_Retorno = ExecutaEnviaRecebeSiTefDireto(RedeDestino,&
														 FuncaoSitef,&
														 Ref CodigoResposta,&
														 TempoExperaRx,&
														 Cupom,& 
														 DataFiscal,&
														 Horario,&
														 Operador,&
														 TipoOperacao)
														 												
If ll_Retorno < 0 and ll_Retorno <> -500 Then
	MessageBox("Sitef Comunica$$HEX2$$e700e300$$ENDHEX$$o Direta","Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o com Servidor Sitef (" + String(FuncaoSitef) + ")",StopSign!)
Else
	If ll_Retorno = -500 Then
		MessageBox("Sitef Comunica$$HEX2$$e700e300$$ENDHEX$$o Direta","Espa$$HEX1$$e700$$ENDHEX$$o insuficiente para retornar os dados da Fun$$HEX2$$e700e300$$ENDHEX$$o Sitef (" + String(FuncaoSitef) + ")",StopSign!)
	End If
End If
																							
Return ll_Retorno
end function

public function boolean of_versao_dll ();Long   ll_Retorno

String ls_CliSitef  = Space(64)
String ls_CliSitefI = Space(64)

ll_Retorno = ObtemVersao(ls_CliSitef, ls_CliSitefI)

If ll_Retorno <> 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao verificar vers$$HEX1$$e300$$ENDHEX$$o da CliSitef.dll",StopSign!)
	Return False
End If

Return True
end function

public function boolean of_valida_parcela_minima (long pl_campo, string ps_parcela);If pl_campo <> 505 Then Return True

If This.Vl_Parcela_Minima = 000.00 Then Return True

Long ll_Parcelas

Decimal {2} ldc_Parcela

ll_Parcelas = Long(ps_parcela)

If ll_Parcelas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de parcelas inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
	Return False
End If	

If ll_Parcelas = 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o n$$HEX1$$fa00$$ENDHEX$$mero de parcelas.", Exclamation!)
	Return False
End If

If This.nr_parcelas_maximo > 0 Then
	
	If ll_Parcelas > This.nr_parcelas_maximo Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de parcelas ultrapassa limite (" + String(This.nr_parcelas_maximo) + ")", Exclamation!)
		Return False
	End If

End If

If This.qt_parcelas_gen > 0 Then

	If ll_Parcelas > This.qt_parcelas_gen Then
		If qt_parcelas_gen = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permite parcelamento, somente cr$$HEX1$$e900$$ENDHEX$$dito $$HEX1$$e000$$ENDHEX$$ vista!", Exclamation!)				
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de parcelas ultrapassa limite (" + String(This.qt_parcelas_gen) + ")", Exclamation!)
		End If
		Return False
	End If	
	
End If

ldc_Parcela = Round( This.Vl_Transacao / ll_Parcelas , 2 )

If This.vl_Parcela_Minima <> 0 Then

	If  ldc_Parcela < This.vl_Parcela_Minima Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor da parcela R$ " + String(ldc_Parcela,'###,##0.00') + " menor que o valor m$$HEX1$$ed00$$ENDHEX$$nimo R$ " + String(This.vl_Parcela_Minima,'###,##0.00') , Exclamation!)
		Return False
	End If
	
End If	

Return True
end function

public function boolean of_valida_valor_saque (long pl_campo, string ps_saque);If pl_campo <> 130 Then Return True

Decimal {2} ldc_Saque

ldc_Saque = Dec(ps_saque)

If Mod(ldc_Saque,5) = 0 Then Return True

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor para saque inv$$HEX1$$e100$$ENDHEX$$lido. Somente valor m$$HEX1$$fa00$$ENDHEX$$ltiplo de R$ 5,00",Exclamation!) 

Return False
end function

public function boolean of_sequencial_comprovante_prevenda (string acaixa, long acontrole_caixa, ref long asequencial);Long ll_sequencial

Select max(nr_sequencial) Into :asequencial
From cartao_comprovante_prevenda
Where cd_caixa          = :acaixa
  and nr_controle_caixa = :acontrole_caixa
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Sequencial comprovante de cart$$HEX1$$e300$$ENDHEX$$o.')
	Return False
End If	

If IsNull(asequencial) Then asequencial = 0

asequencial ++

Return True
end function

public function boolean of_verifica_dll ();//Return True

Boolean	lb_Sucesso 		= True
Boolean	lb_Existe 		= False

String	ls_Path 	 		= 'C:\sistemas\dll\sitef'
String   ls_Path_System

String 	ls_Versao
String	ls_Valor
String	ls_Error
String ls_versao_compara

String	ls_CliSitef[]

Long 	 	ll_Row
Long 	 	ll_File
Long 		ll_posP

//Open(w_Aguarde_1)

Select vl_parametro
  Into :ls_Versao
  from parametro_loja
 Where cd_parametro = 'NR_VERSAO_CLISITEF'
 Using SqlCa;
 
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_LogDbError(gvo_Aplicacao.ivi_Log)
		Return False
		
	Case 100
		gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi encontrado o par$$HEX1$$e200$$ENDHEX$$metro 'NR_VERSAO_CLISITEF' na tabela par$$HEX1$$e200$$ENDHEX$$metro_loja")
		Return False
		
	Case 0

		If IsNull(ls_Versao) or Trim(ls_Versao) = "" or Trim(ls_Versao) = '/' Then Return True
		
End Choose

If Not This.of_verifica_versao_dll( ) Then Return False

/***/
uo_Parametro_PDV lo_Parametro_PDV
lo_Parametro_PDV = Create uo_Parametro_PDV
lo_Parametro_PDV.of_atualiza_parametro( 'NR_VERSAO_CLISITEF', Trim(This.nr_versao_dll),True)
Destroy lo_Parametro_PDV
/***/

ll_posP = Pos(Upper(Trim(This.nr_versao_dll)), "P")
If ll_posP > 0 Then
	ls_versao_compara = LeftA(This.nr_versao_dll, ll_posP - 1)

	If Trim(ls_versao) <> Trim(ls_versao_compara) Then
	
	End If
End If

//ls_CliSitef[1] = 'CliSiTef32I.dll'
////ls_CliSitef[2] = 'CliSiTef32.dll'
////ls_CliSitef[3] = 'libseppemv.dll'
//
//lb_Existe = FileExists(ls_Path + '\' + ls_CliSitef[1] ) And &
//				FileExists(ls_Path + '\' + 'Versao-CliSitef-' + ls_Versao + '.txt' )
//				
////lb_Existe = FileExists(ls_Path + '\' + ls_CliSitef[1] ) And &
////				FileExists(ls_Path + '\' + ls_CliSitef[2] ) And &
////				FileExists(ls_Path + '\' + ls_CliSitef[3] ) And &
////				FileExists(ls_Path + '\' + 'Versao-CliSitef-' + ls_Versao + '.txt' )	
//										
//If Not lb_Existe Then
//	
//	dc_uo_ftp lo_Ftp
//	lo_Ftp = Create dc_uo_ftp
//	
//	Select vl_parametro
//	Into :ls_Valor
//	from parametro_loja
//	Where cd_parametro = 'DE_SERVIDOR_DOWNLOAD_VERSAO_MATRIZ'
//	Using SqlCa;
// 
//	Choose Case SqlCa.SqlCode
//	Case -1
//		SqlCa.of_LogDbError(gvo_Aplicacao.ivi_Log)
//		lb_Sucesso = False
//		
//	Case 100
//		gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi encontrado o par$$HEX1$$e200$$ENDHEX$$metro 'DE_SERVIDOR_DOWNLOAD_VERSAO_MATRIZ' na tabela par$$HEX1$$e200$$ENDHEX$$metro_loja")
//		lb_Sucesso = False
//		
//	Case 0
//		lb_Sucesso = True
//	End Choose	
//	
//	If lb_Sucesso Then
//				
//		If lo_Ftp.of_Conecta_Ftp("Verifica Versao", ls_Valor, "pdv2", "pdv2") Then
//			
//			lo_Ftp.of_Ftp_Set_Dir('dll')
//			
//			If Not FileExists(ls_Path_System + '\' + "AZIP32.DLL") Then
//				
//				lb_Sucesso = False
//				
//				w_Aguarde_1.Title = "Atualizando driver ... " + "azip32.dll"
//				
//				ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
//			
//				If lo_Ftp.of_Ftp_GetFile('AZIP32.DLL', ls_Path_System + '\' + "AZIP32.DLL") Then
//					lb_Sucesso = True				
//				End If
//				
//			End If
//			
//			If Not FileExists(ls_Path_System + '\' + "aunzip32.dll") And lb_Sucesso Then
//				
//				lb_Sucesso = False
//				
//				w_Aguarde_1.Title = "Atualizando driver ... " + "aunzip32.dll"
//			
//				If lo_Ftp.of_Ftp_GetFile('aunzip32.dll', ls_Path_System + '\' + "aunzip32.dll") Then
//					lb_Sucesso = True
//				End If
//				
//			End If
//					
//		End If
//								
//		w_Aguarde_1.Title = "Verificando Atualiza$$HEX2$$e700e300$$ENDHEX$$o CliSitef ..."
//		
//		Select vl_parametro
//		  Into :ls_Valor
//		  from parametro_loja
//		 Where cd_parametro = 'DE_SERVIDOR_DOWNLOAD_VERSAO_MATRIZ'
//		 Using SqlCa;
//		 
//		Choose Case SqlCa.SqlCode
//			Case -1
//				SqlCa.of_LogDbError(gvo_Aplicacao.ivi_Log)
//				lb_Sucesso = False
//				
//			Case 100
//				gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi encontrado o par$$HEX1$$e200$$ENDHEX$$metro 'DE_SERVIDOR_DOWNLOAD_VERSAO_MATRIZ' na tabela par$$HEX1$$e200$$ENDHEX$$metro_loja")
//				lb_Sucesso = False
//				
//			Case 0
//				lb_Sucesso = True
//		End Choose
//		
//		dc_uo_zip lo_Zip
//		lo_Zip = Create dc_uo_zip
//		
//		If lb_Sucesso Then
//			
//			w_Aguarde_1.Title = "Atualizando CliSitef ... "
//	
//			If lo_Ftp.of_Conecta_Ftp("Verifica Versao", ls_Valor, "pdv2", "pdv2") Then
//				
//				lo_Ftp.of_Ftp_Set_Dir('dll_clisitef')
//				
//				If Not lo_Ftp.of_Ftp_GetFile("clisitef.zip", ls_Path + "\clisitef.zip") Then
//					
//					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao atualizar CliSitef")
//					
//					lb_Sucesso = False
//					
//				Else
//					
//					lo_Zip.of_UnZip_Origem(ls_Path + '\clisitef.zip')
//					lo_Zip.of_UnZip_Destino(ls_Path + '\')
//					
//					ls_Error = lo_Zip.of_UnZip(True)
//					
//					If ls_Error <> "" Then
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Error, StopSign!)
//					Else
//						lb_Sucesso = True
//					End If
//	
//				End If
//				
//			End If
//			
//		End If
//		
//		If IsValid(lo_Zip) Then Destroy(lo_Zip)
//		
//		If lb_Sucesso Then
//			
//			 ll_File = FileOpen(ls_Path + '\' + 'Versao-CliSitef-' + ls_Versao + '.txt',linemode!,Write!,Shared!,Replace!)
//			 
//			 If ll_File = -1 Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao atualizar " + ls_Versao + '\' + 'Versao-CliSitef-' + ls_Valor + '.txt')
//				lb_Sucesso = False
//			End If
//			
//			FileWrite(ll_File,String(Today(), "dd/mm/yyyy hh:mm:ss"))
//			
//			FileClose(ll_File)
//			
//		End If
//		
//	End If	
//Else
//	//dlls n$$HEX1$$e300$$ENDHEX$$o precisam mais estar na pasta na vers$$HEX1$$e300$$ENDHEX$$o 6.XXX
//	If Trim(LeftA(This.nr_versao_dll,1)) >= '6' Then	
//		ls_CliSitef[1] = 'CliSiTef32.dll'
//		ls_CliSitef[2] = 'libemv.dll'
//		ls_CliSitef[3] = 'libseppemv.dll'	
//		
//		lb_Existe = FileExists(ls_Path + '\' + ls_CliSitef[1] ) And &
//						FileExists(ls_Path + '\' + ls_CliSitef[2] ) And &
//						FileExists(ls_Path + '\' + ls_CliSitef[3] )
//	
//		If lb_Existe Then
//			FileDelete(ls_Path + '\' + ls_CliSitef[1])
//			FileDelete(ls_Path + '\' + ls_CliSitef[2])
//			FileDelete(ls_Path + '\' + ls_CliSitef[3])		
//		End If	
//	End If
//End If

//If IsValid(lo_Ftp) Then Destroy lo_Ftp

//If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)

Return lb_Sucesso
end function

public function boolean of_valor_parcela_minima ();Boolean	lb_Sucesso = False

String	ls_Parametro

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

lb_Sucesso = lvo_Parametro.of_Localiza_Parametro("VL_PARCELA_MINIMA_TEF", ref ls_Parametro)

Destroy(lvo_Parametro)

If Upper(ls_Parametro) = 'S' Then
	This.CompraSaque = True
Else
	This.CompraSaque = False
End If
	
Return lb_Sucesso
end function

public function long of_envia_recebe_direto (long rededestino, long funcaositef, long offsetcartao, string dadostx, ref string dadosrx, ref long codigoresposta, ref long tempoexperarx, string cupom, string datafiscal, string horario, string operador, long tipooperacao);Long ll_Pos
Long ll_Retorno
Long ll_TamDadosRx

Char lc_DadosTx[]
Char lc_DadosRx[0 To 10000]

String ls_Retorno

//of_DadosTx(DadosTx, Ref lc_DadosTx)

ll_Retorno = EnviaRecebeSiTefDireto(RedeDestino,&
												FuncaoSitef,&
												OffsetCartao,&
												lc_DadosTx,&
												UpperBound(lc_DadosTx),&
												Ref lc_DadosRx,&
												ll_TamDadosRx,&
												Ref CodigoResposta,&
												Ref TempoExperaRx,&									
												Cupom,& 
												DataFiscal,&
												Horario,&
												Operador,&
												TipoOperacao)
												
If ll_Retorno < 0 and ll_Retorno <> -500 Then
	MessageBox("Sitef Comunica$$HEX2$$e700e300$$ENDHEX$$o Direta","Erro de comunica$$HEX2$$e700e300$$ENDHEX$$o com Servidor Sitef (" + String(FuncaoSitef) + ")",StopSign!)
Else
	If CodigoResposta = 255 Then
		MessageBox("Sitef Comunica$$HEX2$$e700e300$$ENDHEX$$o Direta","Par$$HEX1$$e200$$ENDHEX$$mentro inv$$HEX1$$e100$$ENDHEX$$lido Rede Destino " + String(RedeDestino) +  " para fun$$HEX2$$e700e300$$ENDHEX$$o (" + String(FuncaoSitef) + ")",StopSign!)		
	Elseif ll_Retorno = -500 Then
		MessageBox("Sitef Comunica$$HEX2$$e700e300$$ENDHEX$$o Direta","Espa$$HEX1$$e700$$ENDHEX$$o insuficiente para retornar os dados da Fun$$HEX2$$e700e300$$ENDHEX$$o Sitef (" + String(FuncaoSitef) + ")",StopSign!)
	End If
End If

For ll_Pos = 0 To UpperBound(lc_DadosRx)
	
	If Not IsNull(lc_DadosRx[ll_Pos]) Then
		ls_Retorno += String(lc_DadosRx[ll_Pos])
	Else
		ls_Retorno += ' '
	End If
	
Next	
																							
Return ll_Retorno
end function

public function boolean of_mensagem_operador (string ps_mensagem, boolean pb_cancelar);
If Not IsValid(w_ge084_aguarde) Then
	Open(w_ge084_aguarde)
	w_ge084_aguarde.mle_1.text = ps_mensagem
Else
	If w_ge084_aguarde.mle_1.text <> ps_mensagem Then w_ge084_aguarde.mle_1.text = ps_mensagem
End If

If pb_cancelar Then
	
	If Not w_ge084_aguarde.cb_cancelar.Enabled Then
		w_ge084_aguarde.cb_cancelar.Enabled = True
		w_ge084_aguarde.Height              = 690
		w_ge084_aguarde.cb_cancelar.SetFocus()
	End If
	
End If
	
Return True
				
end function

public function integer of_oculta_dados_cartao ();Return 1
end function

public subroutine of_valida_bandeira_produto (ref string ps_bandeira);String ls_temp
String ls_produto

ps_bandeira = Trim(ps_bandeira)

Select nm_produto Into :ls_produto
From cartao_produto
Where nm_produto = :ps_bandeira
Using Sqlca;

Choose Case Sqlca.Sqlcode 
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar bandeira do cart$$HEX1$$e300$$ENDHEX$$o na tabela cartao_produto",StopSign!)
	Case 100
		
		Select nm_produto Into :ls_produto
		  From bandeira_comprovante_tef
		Where nm_bandeira = :ps_bandeira
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar bandeira do cart$$HEX1$$e300$$ENDHEX$$o na tabela bandeira_comprovante_tef",StopSign!)
		End If

		If Not IsNull(ls_produto) and Trim(ls_produto) <> '' Then
			ps_bandeira = ls_produto
		End If
				
End Choose

end subroutine

public function boolean of_localiza_cupom_fiscal (long afuncao, datetime adata, long aecf, long acupom, ref long afilial, ref long adoc, ref string aespecie, ref string aserie);Long     ll_sequencial

DateTime ldt_Movimento

If afuncao = 300 or afuncao = 301 or afuncao = 124 &
 or afuncao = 261 Or afuncao = 264 Or afuncao = 265 Or afuncao = 269 Or afuncao = 275 or afuncao = 276 Then
	SetNull(afilial)
	SetNull(adoc)
	SetNull(aespecie)
	SetNull(aserie)
	Return True	
End If

ldt_Movimento = DateTime(RelativeDate(date(adata),-2))
//ldt_Movimento = DateTime(Date(adata))
	
Select cd_filial,nr_nf,de_especie,de_serie
  Into :afilial,:adoc,:aespecie,:aserie
From nf_venda
Where dh_movimentacao_caixa >= :ldt_Movimento
  and nr_ecf        			 = :aecf
  and nr_operacao_ecf 	    = :acupom
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,'Localiza$$HEX2$$e700e300$$ENDHEX$$o do Cupom Fiscal. Data:' + String(ldt_Movimento,'dd/mm/yyyy') + ' ECF:' + String(aecf,'000') + 'COO:' + String(acupom,'00000000') )
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o da Cupom Fiscal.')
	Return False
End If
		
If Sqlca.Sqlcode = 100 Then
	SetNull(afilial)
	SetNull(adoc)
	SetNull(aespecie)
	SetNull(aserie)	
End If
	
Return True
end function

public function boolean of_localiza_cupom_fiscal (datetime adata, long aecf, long acupom);Long     ll_sequencial

Long ll_Filial

DateTime ldt_Movimento

//ldt_Movimento = DateTime(Date(adata))
ldt_Movimento = DateTime(RelativeDate(date(adata),-2))
	
Select cd_filial
  Into :ll_Filial
From nf_venda
Where dh_movimentacao_caixa >= :ldt_Movimento
  and nr_ecf        			 = :aecf
  and nr_operacao_ecf 	    = :acupom
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,'Localiza$$HEX2$$e700e300$$ENDHEX$$o do Cupom Fiscal. Data:' + String(ldt_Movimento,'dd/mm/yyyy') + ' ECF:' + String(aecf,'000') + 'COO:' + String(acupom,'00000000') )
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o da Cupom Fiscal.')
	Return False
End If
		
If Sqlca.Sqlcode = 100 Then
	Return False
End If
	
Return True
end function

public function boolean of_habilita_compra_saque ();Boolean lb_Sucesso = False

String ls_Parametro

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

lb_Sucesso = lvo_Parametro.of_Localiza_Parametro("ID_COMPRA_SAQUE_TEF", ref ls_Parametro)

Destroy(lvo_Parametro)

If Upper(ls_Parametro) = 'S' Then
	This.CompraSaque = True
Else
	This.CompraSaque = False
End If

This.vl_saque = 000.00

Return lb_Sucesso

end function

public function boolean of_transacao_pagamento_edm (decimal avalor, long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
String  ls_restricao = "[27;28]"

Boolean lb_Sucesso = False

//Cart$$HEX1$$e300$$ENDHEX$$o de Cr$$HEX1$$e900$$ENDHEX$$dito
This.cd_funcao = 3

This.nr_ecf            = aecf
This.nr_cupom          = acupomfiscal
This.dt_transacao      = DateTime(Date(adata),Now())
This.vl_transacao      = avalor
This.vl_total_transacao= avalor
This.de_operador       = aoperador
This.de_restricao      = ls_restricao
This.cd_caixa          = acaixa
This.nr_controle_caixa = acontrole_caixa

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
	
End If 

Return lb_Sucesso
end function

public function boolean of_transacao_prevenda (decimal avalor, long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
String  ls_funcao[] 														            // Transacao pagamento
	
String  ls_restricao = ""

Boolean lb_Sucesso = False

ls_funcao[1] = "PC"

If Not This.of_Restricao_Funcao(ls_funcao[],Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

This.cd_funcao 		  = 000000
This.nr_ecf            = aecf
This.nr_cupom          = acupomfiscal
This.dt_transacao      = DateTime(Date(adata),Now())
This.vl_transacao      = avalor
This.vl_total_transacao= avalor
This.de_operador       = aoperador

This.de_restricao      = ls_restricao
This.cd_caixa          = acaixa
This.nr_controle_caixa = acontrole_caixa

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
	
End If 

Return lb_Sucesso
end function

public function boolean of_sitef_direto_retorno ();Long 		ll_TamMaxServico
Long 	 	ll_Retorno
Long 	 	ll_Ind

String  	ls_DadosSitef
String   ls_Resultado

String 	ls_CodigoServico

Char   	ls_DadosServico[1 To 20000]

SetPointer(HourGlass!)

If Not ds_Servico.of_ChangeDataObject("dw_ge084_servico_sitef_direto") Then Return False

ds_servico.Reset()

Do While True
	
	ls_CodigoServico = Space(01)
	
	ll_TamMaxServico = 2000
	
	ll_Retorno = ObtemRetornoEnviaRecebeSiTefDireto(Ref ls_CodigoServico,&
																	Ref ls_DadosServico,&
																	ll_TamMaxServico)

	If ll_Retorno < 0 and ll_Retorno <> -501 and ll_Retorno <> -500 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Fun$$HEX2$$e700e300$$ENDHEX$$o 'ObtemRetornoEnviaRecebeSiTefDireto'~n~n" + &
		      					"Retorno: " + String(ll_Retorno) + "~n~n" + &
		                     "Servi$$HEX1$$e700$$ENDHEX$$o:" + ls_CodigoServico + "~n" + &
									"Dados:" + String(ls_DadosServico) + "~n" + & 
									"Tamanho:" + String(ll_TamMaxServico),StopSign!)
		Return False
	End If	
	
	If ll_Retorno = -500 Then 
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Fun$$HEX2$$e700e300$$ENDHEX$$o 'ObtemRetornoEnviaRecebeSiTefDireto'~n~n" + &
		      												 "Retorno: " + String(ll_Retorno) + "~n~n" + &
		                    								 "Servi$$HEX1$$e700$$ENDHEX$$o:" + ls_CodigoServico + "~n" + &
																 "Dados:" + String(ls_DadosServico) + "~n" + & 
																 "Tamanho:" + String(ll_TamMaxServico))
//		Exit																 
	End If
																	
	If ll_Retorno = -501 Then Exit
		
	ll_Ind = ds_Servico.InsertRow(0)
	
	ls_DadosSitef = String(ls_DadosServico)
	
	ds_Servico.object.id_servico[ll_ind] = Upper(ls_CodigoServico)
	ds_Servico.object.de_dados  [ll_ind] = ls_DadosSitef
	ds_Servico.object.nr_tamanho[ll_ind] = ll_TamMaxServico
	
Loop

If ds_Servico.RowCount() = 0 Then 
	MessageBox("Sitef Comunica$$HEX2$$e700e300$$ENDHEX$$o Direta","Nenhum Servi$$HEX1$$e700$$ENDHEX$$o retornado.",Exclamation!)		
	Return False
End If	

Return True
end function

public function boolean of_transacao_pharmasystem_autorizacao (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
String  ls_funcao = "PC" 														            // Transacao Pre-Autorizacao PharmaSystem
	
String  ls_restricao = ""

Boolean lb_Sucesso = False

If Not of_Verifica_Dll() Then Return False

This.cd_funcao 			= 542
This.nr_ecf            	= aecf
This.nr_cupom          	= acupomfiscal
This.dt_transacao      	= DateTime(Date(adata),Now())
This.vl_transacao      	= 000.00
This.de_operador       	= aoperador
This.de_restricao      	= ls_restricao
This.cd_caixa          	= acaixa
This.nr_controle_caixa 	= acontrole_caixa

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
	
	If lb_Sucesso Then This.PharmaSystem.Id_Status = String(This.Id_Status,'00')
	
End If 

Return lb_Sucesso
end function

public function boolean of_configura_automatico ();Integer li_FileNum

Long lvl_Filial
String lvs_Rede

String lvs_empresa
String lvs_terminal
String lvs_terminalcli
String lvs_config

lvl_Filial	= gvo_Parametro.of_Filial()

lvs_Empresa	= String(lvl_Filial, "00000000")
lvs_terminal		= "SW" + String(lvl_Filial, "0000") + RightA(gvo_Aplicacao.is_ComputerName, 2)

If gf_rede_filial(Ref lvs_Rede) Then
	lvs_terminalcli = lvs_Rede + String(lvl_Filial, "0000") + RightA(gvo_Aplicacao.is_ComputerName, 2)
Else
	lvs_terminalcli = lvs_terminal
End If

lvs_config = "c:\client\Cliente.ini"
SetProfileString(lvs_config,"CLIENTSITEF","Terminal", lvs_terminal)	
SetProfileString(lvs_config,"CLIENTSITEF","Empresa", lvs_Empresa)

lvs_config = "c:\client\clientsitef.ini"

If Not FileExists( lvs_Config ) Then
	li_FileNum = FileOpen(lvs_Config, LineMode!, Write!, LockWrite!, Replace! )
	FileClose( li_FileNum )
End If

SetProfileString(lvs_config,"CLIENTSITEF","Terminal", lvs_terminal)	
SetProfileString(lvs_config,"CLIENTSITEF","TerminalCliSitef", lvs_terminalcli)
SetProfileString(lvs_config,"CLIENTSITEF","Empresa", lvs_Empresa)

Return True
end function

public function boolean of_transacao_cancelamento_credito_debito (datetime adata, string aoperador);
Boolean  lb_Sucesso

Long     ll_ecf 
Long     ll_cupomfiscal

String   ls_funcao[]  																		// Transacao recarga
String   ls_restricao

ls_funcao[1] = "RC"
ls_funcao[2] = "RPC"

If Not This.of_Restricao_Funcao(ls_funcao[],Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
This.cd_funcao    = 200
This.nr_cupom     = ll_CupomFiscal
This.dt_transacao = gf_getserverdate()
This.vl_transacao = 000.00
This.de_operador  = aoperador
This.de_restricao = ls_restricao

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
		
End If

Return lb_Sucesso
end function

public function boolean of_transacao_consulta_cheque ();
Boolean lb_Sucesso

String  ls_Restricao
String  ls_Funcao[]

ls_funcao[1] = "CC"

If Not This.of_Restricao_Funcao(ls_funcao[],Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

is_Tipo_Venda = "CHEQUE"

lb_Sucesso = This.of_Transacao_Tef(1 , ls_restricao)

SetNull(is_Tipo_Venda)

//This.of_Transacao_Pendente()

Return lb_Sucesso
end function

public function boolean of_finaliza_transacao_prevenda ();Boolean lb_Sucesso, &
		  lb_Comprovante

//N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ necessidade de impress$$HEX1$$e300$$ENDHEX$$o e confirma$$HEX2$$e700e300$$ENDHEX$$o
If Not This.Impressao Then Return True

lb_Sucesso = This.of_Registra_PreVenda()

If lb_Sucesso Then

	//Transa$$HEX2$$e700e300$$ENDHEX$$o com impress$$HEX1$$e300$$ENDHEX$$o de comprovante
	If This.Impressao Then
	
		//Imprime comprovante da Transa$$HEX2$$e700e300$$ENDHEX$$o
		lb_Comprovante = This.of_impressao_comprovante()
	
		If lb_Comprovante Then
					
			//Confirma a terceira perna da transa$$HEX2$$e700e300$$ENDHEX$$o
			This.of_Confirma_Transacao()
			
			lb_Sucesso = True
												
		Else
	
			//Cancela transa$$HEX2$$e700e300$$ENDHEX$$o
			This.of_Cancela_Transacao()
					
			lb_Sucesso = False
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de reter o comprovante da venda TEF, pois a transa$$HEX2$$e700e300$$ENDHEX$$o foi cancelada.",Exclamation!)
			
		End If
				
	End If
		
End If		

Return lb_Sucesso
end function

public function boolean of_configura ();String ls_Parametro
String ls_empresa
String ls_terminal
String ls_servidor
String ls_captura
String ls_config
String ls_rede
String ls_FunctionName = '~ruo_sitef.of_configura( )'
String ls_vidalink
String ls_transacoes
String ls_pix
String ls_cancela_gift, ls_cancela_gift_ini
String ls_conf_gift
String ls_aut_estendido

//Controla Hist$$HEX1$$f300$$ENDHEX$$rico de arquivos de Log mantendo somente $$HEX1$$fa00$$ENDHEX$$ltima semana
This.of_Controle_Arquivos_Log()

//Testa localiza$$HEX2$$e700e300$$ENDHEX$$o das bibliotecas de integra$$HEX2$$e700e300$$ENDHEX$$o
If Not This.of_Verifica_dll() Then Return False

Select vl_parametro
 Into :ls_Parametro
from parametro_loja
Where cd_parametro = 'ID_BASE_PRODUCAO'
Using SQLCa;

Choose Case SqlCa.SqlCode
		
	Case 0
		//Achou
	
	Case 100
		ls_Parametro = 'S'
		
	Case -1
		ls_Parametro = 'S'
	
End Choose

uo_Parametro_Filial lo_Parametro_Filial
lo_Parametro_Filial = Create uo_Parametro_Filial

gf_rede_filial(Ref ls_rede)

If Not lo_Parametro_Filial.of_Localiza_Parametro( 'DE_SERVIDOR_SITEF', Ref ls_Servidor ) Then
	Destroy lo_Parametro_Filial
	Return False
End If

lo_Parametro_Filial.of_Localiza_Parametro("ID_CANCELAMENTO_GIFTCARD", ref ls_cancela_gift, False)
If IsNull( ls_cancela_gift ) or Trim( ls_cancela_gift ) = "" Or Trim(Upper(ls_cancela_gift)) = 'N' Then //N$$HEX1$$e300$$ENDHEX$$o permite usar menu cancelamento gift
	This.id_permite_cancelar_gift = False
ElseIf Trim(Upper(ls_cancela_gift)) = 'S' Then //Permite usar menu cancelamento gift
	This.id_permite_cancelar_gift = True
End If

Destroy lo_Parametro_Filial

ls_terminal	= ProfileString( gvo_Aplicacao.ivs_Arquivo_INI, "SITEF", "Sitef_Terminal", "" )

If IsNull( ls_terminal ) Or Trim( ls_terminal ) = "" Then
	ls_terminal  = ls_rede + String( gvo_parametro.cd_filial, "0000") + RightA( gvo_aplicacao.is_ComputerName , 2 )
	SetProfileString( gvo_Aplicacao.ivs_Arquivo_INI, "SITEF", "Sitef_Terminal", ls_terminal )
Else
	If Not IsNumber(Right(ls_terminal,6)) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Informa$$HEX2$$e700e300$$ENDHEX$$o de Terminal [TEF] n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurada corretamente!" + ls_FunctionName, StopSign! )
		This.id_tef_ativo = "N"
		Return False		
	End If
End If

ls_empresa = ProfileString( gvo_Aplicacao.ivs_Arquivo_INI, "SITEF", "Sitef_Empresa", "" )

If ( IsNull( ls_empresa ) Or Trim( ls_empresa ) = "" ) And Upper( LeftA( Trim( gvo_aplicacao.is_ComputerName ), 3 ) ) <> 'INF' Then
	ls_empresa  = String( gvo_parametro.cd_filial, "00000000" )
	SetProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "SITEF", "Sitef_Empresa", ls_empresa)	
End If

If IsNull( ls_empresa ) or Trim( ls_empresa ) = "" Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Informa$$HEX2$$e700e300$$ENDHEX$$o de empresa [TEF] n$$HEX1$$e300$$ENDHEX$$o econtrada." + ls_FunctionName, StopSign! )
	This.id_tef_ativo = "N"
	Return False
End If

If IsNull(ls_Servidor) or Trim(ls_Servidor) = "" Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe IP do Servidor TEF no par$$HEX1$$e200$$ENDHEX$$metro da loja." + ls_FunctionName, StopSign! )
	This.id_tef_ativo = "N"
	Return False
End If

ls_vidalink = ProfileString( 'c:\sistemas\dll\sitef\clisitef.ini', "vidalink", "versao", "" )

If IsNull( ls_vidalink ) or Trim( ls_vidalink ) = "" Then
	If SetProfileString( 'c:\sistemas\dll\sitef\clisitef.ini', "vidalink", "versao", "3" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para alterar o arquivo c:\sistemas\dll\sitef\clisitef.ini." + ls_FunctionName, StopSign! )
		This.id_tef_ativo = "N"
		Return False		
	End If
Else
	If Trim( ls_vidalink ) <> "3" Then	
		If SetProfileString( 'c:\sistemas\dll\sitef\clisitef.ini', "vidalink", "versao", "3" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para alterar o arquivo c:\sistemas\dll\sitef\clisitef.ini." + ls_FunctionName, StopSign! )
			This.id_tef_ativo = "N"
			Return False		
		End If		
	End If
End If

ls_transacoes = ProfileString( 'c:\sistemas\dll\sitef\clisitef.ini', "Geral", "TransacoesAdicionaisHabilitadas", "" )
If PosA(ls_transacoes,'29') = 0 Then
	ls_transacoes = ls_transacoes + ';29'
	If SetProfileString( 'c:\sistemas\dll\sitef\clisitef.ini', "Geral", "TransacoesAdicionaisHabilitadas", ls_transacoes ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para alterar o arquivo c:\sistemas\dll\sitef\clisitef.ini." + ls_FunctionName, StopSign! )
		This.id_tef_ativo = "N"
		Return False		
	End If	
End If
ls_transacoes = ProfileString( 'c:\sistemas\dll\sitef\clisitef.ini', "Geral", "TransacoesAdicionaisHabilitadas", "" )
If PosA(ls_transacoes,';7') = 0 Then //Carteira Digital
	ls_transacoes = ls_transacoes + ';7;8'
	If SetProfileString( 'c:\sistemas\dll\sitef\clisitef.ini', "Geral", "TransacoesAdicionaisHabilitadas", ls_transacoes ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para alterar o arquivo c:\sistemas\dll\sitef\clisitef.ini." + ls_FunctionName, StopSign! )
		This.id_tef_ativo = "N"
		Return False		
	End If	
End If

ls_aut_estendido = ProfileString( 'c:\sistemas\dll\sitef\clisitef.ini', "Geral", "PermiteDevolucaoCodigoAutorizacaoEstendido", "" )
If Trim( ls_aut_estendido ) <> "1" Then	//Retorno cod. autoriza$$HEX2$$e700e300$$ENDHEX$$o Carteira Digital
	If SetProfileString( "c:\sistemas\dll\sitef\clisitef.ini", "Geral", "PermiteDevolucaoCodigoAutorizacaoEstendido", "1" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para alterar o arquivo c:\sistemas\dll\sitef\clisitef.ini." + ls_FunctionName, StopSign! )
		This.id_tef_ativo = "N"
		Return False		
	End If
End If

ls_pix = ProfileString( 'c:\sistemas\dll\sitef\clisitef.ini', "CarteirasDigitais", "CarteirasHabilitadas", "" )
If Not IsNull( ls_pix ) And Trim( ls_pix ) <> "" Then
	If SetProfileString( 'c:\sistemas\dll\sitef\clisitef.ini', "CarteirasDigitais", "CarteirasHabilitadas", "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para alterar o arquivo c:\sistemas\dll\sitef\clisitef.ini." + ls_FunctionName, StopSign! )
		This.id_tef_ativo = "N"
		Return False		
	End If	
End If

ls_conf_gift = ProfileString( "c:\sistemas\dll\sitef\clisitef.ini", "Gift", "NovasTransacoesGift", "" )

If IsNull( ls_conf_gift ) or Trim( ls_conf_gift ) = "" Then  //Ativa$$HEX2$$e700e300$$ENDHEX$$o GIFT.
	If SetProfileString( "c:\sistemas\dll\sitef\clisitef.ini", "Gift", "NovasTransacoesGift", "1" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para alterar o arquivo c:\sistemas\dll\sitef\clisitef.ini." + ls_FunctionName, StopSign! )
		This.id_tef_ativo = "N"
		Return False		
	End If
	If SetProfileString( "c:\sistemas\dll\sitef\clisitef.ini", "Geral", "PermiteTrnCartaoGift", "1" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para alterar o arquivo c:\sistemas\dll\sitef\clisitef.ini." + ls_FunctionName, StopSign! )
		This.id_tef_ativo = "N"
		Return False
	End If	
Else
	If Trim( ls_conf_gift ) <> "1" Then	
		If SetProfileString( "c:\sistemas\dll\sitef\clisitef.ini", "Gift", "NovasTransacoesGift", "1" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para alterar o arquivo c:\sistemas\dll\sitef\clisitef.ini." + ls_FunctionName, StopSign! )
			This.id_tef_ativo = "N"
			Return False		
		End If
		If SetProfileString( "c:\sistemas\dll\sitef\clisitef.ini", "Geral", "PermiteTrnCartaoGift", "1" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para alterar o arquivo c:\sistemas\dll\sitef\clisitef.ini." + ls_FunctionName, StopSign! )
			This.id_tef_ativo = "N"
			Return False
		End If			
	End If
End If

This.de_terminal_tef				= ls_terminal
This.id_empresa_tef				= ls_empresa
This.nr_servidor_tef				= ls_servidor
This.nr_vias_comprovante_tef	= 1

gf_rede_filial(Ref Is_rede_filial)
Choose Case is_rede_filial
	Case 'DC'
		is_msg_cliente = 'Prezado Cliente:<{|}>A Drogaria Catarinense agradece a sua prefer$$HEX1$$ea00$$ENDHEX$$ncia.'
	Case 'PP'
		is_msg_cliente = 'Prezado Cliente:<{|}>A Farm$$HEX1$$e100$$ENDHEX$$cia Pre$$HEX1$$e700$$ENDHEX$$o Popular agradece a sua prefer$$HEX1$$ea00$$ENDHEX$$ncia.'
	Case 'MP'
		is_msg_cliente = 'Prezado Cliente:<{|}>A Drogaria Catarinense agradece a sua prefer$$HEX1$$ea00$$ENDHEX$$ncia.'
	Case 'FA'
		is_msg_cliente = 'Prezado Cliente:<{|}>A Farmagora agradece a sua prefer$$HEX1$$ea00$$ENDHEX$$ncia.'
	Case 'PF'
		is_msg_cliente = 'Prezado Cliente:<{|}>A Proformula agradece a sua prefer$$HEX1$$ea00$$ENDHEX$$ncia.'
End Choose

Return True
end function

public function boolean of_registra_impressao_comprovante ();
Boolean lb_Sucesso = False

Update transacao_tef
Set id_situacao = 'I'
Where nr_ecf     = :This.nr_ecf
  and nr_coo_ecf = :This.nr_cupom
Using Sqlca;

Choose Case Sqlca.Sqlcode 
	Case 0
		
		If Sqlca.SqlnRows > 0 Then
			Sqlca.of_Commit()
			lb_Sucesso = True
		Else
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Erro ao registrar impress$$HEX1$$e300$$ENDHEX$$o do comprovante TEF. ECF [" + String(PDV.ecf,'000') + "] Cupom [" + String(This.nr_cupom,'00000000')+"]")
			Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"Erro ao registrar impress$$HEX1$$e300$$ENDHEX$$o do comprovante TEF. ECF [" + String(PDV.ecf,'000') + "] Cupom [" + String(This.nr_cupom,'00000000')+"]")
		End If	
		
	Case 100
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Erro ao registrar impress$$HEX1$$e300$$ENDHEX$$o do comprovante TEF. ECF [" + String(PDV.ecf,'000') + "] Cupom [" + String(This.nr_cupom,'00000000')+"]")
		Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"Erro ao registrar impress$$HEX1$$e300$$ENDHEX$$o do comprovante TEF. ECF [" + String(PDV.ecf,'000') + "] Cupom [" + String(This.nr_cupom,'00000000')+"]")
		
	Case -1	
		Sqlca.of_RollBack()
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Erro ao atualizar transacao_tef.")		
		Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"Erro ao atualizar transacao_tef." + Sqlca.SqlErrText)		
		
End Choose		

Return lb_Sucesso
end function

public function boolean of_trncentre_abertura_venda ();
Long  ll_Retorno
Long  ll_CodigoResposta
Long  ll_Indice

String ls_Titulo
String ls_LeituraCartao = '1'
String ls_Cartao
String ls_Trilha1
String ls_Trilha2

ls_Titulo = Trim(Sitef.TrnCentre.de_Operadora) + ' (' + Sitef.TrnCentre.Cd_Operadora + ')'

If Not of_Leitura_Cartao(ls_Titulo) Then Return False

This.TrnCentre.nr_Cartao = LeftA(Sitef.de_Cartao_Trilha2,PosA(Sitef.de_Cartao_Trilha2,'=')-1)

ll_Indice ++

//Transa$$HEX2$$e700e300$$ENDHEX$$o TRNCentre (SevenPDV)
If of_Sitef_Direto_Parametro(ll_Indice,'41',0,0) = 0 Then

	ll_Indice ++

	//Carga de Tabelas Operadora Espec$$HEX1$$ed00$$ENDHEX$$fica
	If of_Sitef_Direto_Parametro(ll_Indice,'7',0,0) = 0 Then
		
		ll_Indice ++
		
		//Operadora da Carga
		If of_Sitef_Direto_Parametro(ll_Indice,This.TrnCentre.Cd_Operadora,0,0) = 0 Then
					
			//Envia Par$$HEX1$$e200$$ENDHEX$$metros da Leitura do Cart$$HEX1$$e300$$ENDHEX$$o
			If of_Parametros_Leitura_Cartao(Ref ll_Indice) Then
				
				ll_Indice ++
				
				//Indicador de Continua$$HEX2$$e700e300$$ENDHEX$$o
				If of_Sitef_Direto_Parametro(ll_Indice,'1',0,0) = 0 Then
					
						If Not IsNull(Sitef.TrnCentre.de_Complemento) Then						
						End If	
					
						ll_Indice ++
					
						//Executa Solicita$$HEX2$$e700e300$$ENDHEX$$o ao Sitef
						If of_Sitef_Direto_Executa(99, 240, Ref ll_CodigoResposta, 30, '', '', '', '', 1) = 0 Then
						
							//Obtem Retorno Sitef
							If Not of_Sitef_Direto_Retorno() Then Return False
							
							//Tratamento Retornos TRNCentre
							Return This.TrnCentre.of_Retorno_Abertura(ds_Servico)
														
						End If	
													
					End If	
				
			End If	
							
		End If	
		
	End If
	
End If	
																										
Return False
end function

public function boolean of_sequencial_comprovante_caixa (string acaixa, long acontrole_caixa, ref long asequencial);Long ll_sequencial

Select max(nr_sequencial) Into :asequencial
From cartao_comprovante_venda
Where cd_caixa          = :acaixa
  and nr_controle_caixa = :acontrole_caixa
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, 'Sequencial comprovante de cart$$HEX1$$e300$$ENDHEX$$o. Caixa: [' + acaixa + '] Controle: [' + String(acontrole_caixa) + ']')
	Sqlca.of_MsgDbError('Sequencial comprovante de cart$$HEX1$$e300$$ENDHEX$$o.')
	Return False
End If	

If IsNull(asequencial) Then asequencial = 0

asequencial ++

Return True
end function

public function long of_verifica_transacao_pendente_servidor ();String ls_Cupom
String ls_Data

Long   ll_Transacao

ls_Cupom = String(This.nr_cupom,'00000000')
ls_Data  = String(This.dt_transacao,'yyyymmdd')

ll_Transacao = ObtemQuantidadeTransacoesPendentes(ls_Data, ls_Cupom)

Return ll_Transacao


end function

public function boolean of_trncentre_autorizacao (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
Long    ll_CodigoResposta
Long    ll_Indice
Long	  ll_Row

String  ls_Status

Boolean lb_Sucesso

This.cd_Funcao         = 240
This.nr_ecf            = aecf
This.nr_cupom          = acupomfiscal
This.dt_transacao      = gf_getserverdate()
This.vl_transacao      = 000.00
This.de_operador       = aoperador
This.de_restricao      = ''
This.cd_caixa          = acaixa
This.nr_controle_caixa = acontrole_caixa

If This.TrnCentre.ds_Autorizacao.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ produtos para efetuar consulta de autoriza$$HEX2$$e700e300$$ENDHEX$$o.",Exclamation!)
	Return False
End If	

If This.TrnCentre.ds_Autorizacao.RowCount() > 10 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de produtos excede limite para consultas (limite m$$HEX1$$e100$$ENDHEX$$ximo de 10 produtos).",Exclamation!)
	Return False
End If	

If IsNull(This.TrnCentre.nr_Cartao) Then
	If Not of_Leitura_Cartao( Trim(Sitef.TrnCentre.de_Operadora) + ' (' + Sitef.TrnCentre.Cd_Operadora + ')') Then Return False
	This.TrnCentre.nr_Cartao = LeftA(Sitef.de_Cartao_Trilha2,PosA(Sitef.de_Cartao_Trilha2,'=')-1)
End If	

ll_Indice = 1

Open(W_ge084_Aguarde)
w_ge084_Aguarde.wf_Mensagem("Efetuando Autoriza$$HEX2$$e700e300$$ENDHEX$$o TRNCentre")

//Transa$$HEX2$$e700e300$$ENDHEX$$o TRNCentre (SevenPDV)
If of_Sitef_Direto_Parametro(ll_Indice,'41',0,0) = 0 Then

	ll_Indice ++

	//Consulta autoriza$$HEX2$$e700e300$$ENDHEX$$o com produto
	If of_Sitef_Direto_Parametro(ll_Indice,'5',0,0) = 0 Then
		
		ll_Indice ++
		
		//Operadora da Carga
		If of_Sitef_Direto_Parametro(ll_Indice,This.TrnCentre.Cd_Operadora,0,0) = 0 Then
			
			ll_Indice ++
					
			//Envia Par$$HEX1$$e200$$ENDHEX$$metros da Leitura do Cart$$HEX1$$e300$$ENDHEX$$o
			If of_Parametros_Leitura_Cartao(Ref ll_Indice) Then
									
				ll_Indice ++
				
				// Indicador de Continua$$HEX2$$e700e300$$ENDHEX$$o - Um Bloco somente, com no m$$HEX1$$e100$$ENDHEX$$ximo 10 produtos.
				If of_Sitef_Direto_Parametro(ll_Indice,'0',0,0) = 0 Then
					
					ll_Indice ++
					
					//Dados Carga Complementar
					If of_Sitef_Direto_Parametro(ll_Indice,'0',0,0) = 0 Then
						
						ll_Indice ++
					
						//Quantidade de Produtos Consultados
						If of_Sitef_Direto_Parametro(ll_Indice,String(This.TrnCentre.ds_Autorizacao.RowCount()),0,0) = 0 Then
			
							//Dados dos Produtos										
							If of_TrnCentre_Parametro_Produto(ll_Indice) Then
								
								ll_Indice ++
														
								//Executa Solicita$$HEX2$$e700e300$$ENDHEX$$o de Consulta Produtos
								If of_Sitef_Direto_Executa(99, This.Cd_Funcao, Ref ll_CodigoResposta, 60, String(This.nr_Cupom,'00000000'), String(This.dt_Transacao,'yyyymmdd'), String(This.dt_Transacao,'hhmmss'), '', 1) = 0 Then
								
									//Obtem Retorno Sitef
									If of_Sitef_Direto_Retorno() Then
									
										If Sitef.TrnCentre.of_Retorno_Autorizacao(ds_Servico) Then
										
											If Sitef.TrnCentre.Id_Status = '00' Then
												
												//Registra Transa$$HEX2$$e700e300$$ENDHEX$$o se necess$$HEX1$$e100$$ENDHEX$$rio para confirma$$HEX2$$e700e300$$ENDHEX$$o ou cancelamento
												If Not This.of_registra_transacao_tef_pendente() Then
													This.of_Cancela_Transacao(False)
													lb_Sucesso = False
												Else
													lb_Sucesso = True
												End If
												
											End If	
											
										End If	
										
									Else
										lb_Sucesso = False
										
									End If	
															
								End If
								
							End If	
							
						End If	
							
					End If													
						
				End If	
			
			End If	
							
		End If	
		
	End If
	
End If	

If IsValid(w_ge084_Aguarde) Then Close(w_ge084_Aguarde)

Return lb_Sucesso
end function

public function boolean of_inclui_cartao_comprovante_venda (string acaixa, long acontrole_caixa, long aecf, long acupom);Long ll_sequencial

//Select nr_sequencial Into :ll_sequencial
Select max(nr_sequencial) Into :ll_sequencial
From cartao_comprovante_venda
Where cd_caixa          = :acaixa
  and nr_controle_caixa = :acontrole_caixa
  and nr_ecf				= :aecf
  and nr_coo_ecf			= :acupom
Using Sqlca;

Choose Case Sqlca.Sqlcode
	Case -1
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Comprovante. Caixa:" + acaixa + " Controle: " + String(acontrole_caixa) + " ECF:" + String(aecf) + " Cupom:" + String(acupom) )
		Sqlca.of_MsgDbError('Sequencial comprovante de cart$$HEX1$$e300$$ENDHEX$$o.')
		Return False
	Case 0
		//Implementado para multiforma de pagamento
		Return True
	Case 100
		Return True
End Choose


end function

public subroutine of_controle_arquivos_log ();Long   ll_Row
 
String ls_Arquivos[]
String ls_Arquivo
String ls_Path = 'c:\sistemas\dll\sitef'

gf_Dir_List(ls_Path,'CliSitef*.log',0, Ref ls_Arquivos[] )

For ll_Row = 1 To UpperBound(ls_Arquivos)
	
	ls_Arquivo = ls_Arquivos[ll_Row]
	
	//Exclui arquivos antigos (mantem somente ultima semana)
	If Long(MidA(ls_Arquivo,10,8)) <= Long(String(RelativeDate(Today(),-8),'yyyymmdd')) Then
		ls_Arquivo = ls_Path + '\' + ls_Arquivo
		FileDelete(ls_Arquivo)
	End If	
	
Next

end subroutine

public function boolean of_transacao_tef (long afuncao);
Return This.of_Transacao_Tef(afuncao,'')
end function

public function boolean of_inicia_funcao_tef ();SetPointer(HourGlass!)

Long ll_Pendentes
String ls_carteiras

If This.cd_funcao = 122 Then
	//Carrega somente carteiras ativas no central.
	If Not This.of_retorna_carteiras( ref ls_carteiras ) Then Return False
	If Not IsNull(ls_carteiras) and Trim(ls_carteiras) <> "" Then
		//This.de_restricao += ";{CarteirasDigitaisHabilitadas=027160110024;027100600012}"
		This.de_restricao += ";{CarteirasDigitaisHabilitadas=" + ls_carteiras + "}"
	End If
End If

//Inicia Transacao TEF
This.id_Status = IniciaFuncaoSitefInterativo(This.cd_funcao,String(This.vl_transacao,'000000.00') , String(This.nr_cupom,'00000000') , String(This.dt_transacao,'yyyymmdd'),String(This.dt_transacao,'hhmmss'),This.de_operador,This.de_restricao)

gvo_Aplicacao.of_Grava_Log("uo_sitef - of_confirma_transacao - Inicializando nova transa$$HEX2$$e700e300$$ENDHEX$$o TEF:" + &
														" Fun$$HEX2$$e700e300$$ENDHEX$$o: [" + String(This.cd_funcao) + "]" + &
														" Valor: ["  + String(This.vl_transacao,'000000.00') + "]" + &
														" Cupom: ["  + String(This.nr_cupom,'00000000') + "]" + &
														" Data: ["   + String(This.dt_transacao,'dd/mm/yyyy hh:mm:ss') + "]" + &
														" Operador: [" + This.de_operador + "]" + &
														" Status: [" + String(This.id_Status) + "]" + &
														" Restri$$HEX2$$e700f500$$ENDHEX$$es : " + This.de_restricao)

Choose Case This.id_Status
	Case 10000
		Return True
	Case 0
		MessageBox("Sitef","(0) Negada pelo autorizador.",Exclamation!)
	Case -1
		MessageBox("Sitef","(-1) M$$HEX1$$f300$$ENDHEX$$dulo n$$HEX1$$e300$$ENDHEX$$o inicializado.",StopSign!)
	Case -2
		MessageBox("Sitef","(-2) Opera$$HEX2$$e700e300$$ENDHEX$$o cancelada pelo operador.",Exclamation!)
	Case -3
		MessageBox("Sitef","(-3) Modalidade inv$$HEX1$$e100$$ENDHEX$$lida.",StopSign!)
	Case -4
		MessageBox("Sitef","(-4) Falta de mem$$HEX1$$f300$$ENDHEX$$ria para rodar a fun$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!)
	Case -5
		MessageBox("Sitef","(-5) Sem comunica$$HEX2$$e700e300$$ENDHEX$$o com o Sitef.",StopSign!)		
	Case -6
		MessageBox("Sitef","(-6) Opera$$HEX2$$e700e300$$ENDHEX$$o cancelada pelo operador.",StopSign!)
	Case -12
		//Erro na execu$$HEX2$$e700e300$$ENDHEX$$o da rotina iterativa. Provavelmente o processo iterativo anterior n$$HEX1$$e300$$ENDHEX$$o foi finalizado at$$HEX1$$e900$$ENDHEX$$ o final (enquanto o retorno for igual a 10000).
		ll_Pendentes = This.of_Verifica_Transacao_Pendente_Servidor()		
		If ( ll_pendentes >= 1 ) And ( Trim(LeftA(This.nr_versao_dll,1)) >= '5' ) Then
			If Not IsNull(This.nr_identificador_pgto) And Trim(This.nr_identificador_pgto) <> '' Then				
				This.id_transacao_interrompida = True
				This.of_Cancela_Transacao(False)
				MessageBox("Sitef","(-12) Opera$$HEX2$$e700e300$$ENDHEX$$o anterior foi interrompida, tente novamente.",StopSign!)
			End If
		End If
		
End Choose

Return False
end function

public function boolean of_transacao_tef (long afuncao, string arestricao);
Boolean  lb_Sucesso = False

Long     ll_ecf 
Long     ll_cupomfiscal

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

ll_cupomfiscal ++

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
This.cd_funcao    = afuncao
This.nr_cupom     = ll_cupomfiscal
This.dt_transacao = gf_getserverdate()
This.vl_transacao = 000.00
This.de_operador  = ''
This.de_restricao = arestricao

If This.of_Inicia_Funcao_Tef() Then
	lb_Sucesso = This.of_Controla_Interacao_dll()
End If	

If lb_Sucesso Then

	//Transa$$HEX2$$e700e300$$ENDHEX$$o com impress$$HEX1$$e300$$ENDHEX$$o de comprovante
	If This.Impressao Then
		
		Boolean lb_Comprovante
	
		//Imprime comprovante da Transa$$HEX2$$e700e300$$ENDHEX$$o
		lb_Comprovante = This.of_impressao_comprovante()
	
		If lb_Comprovante Then
			
			SITEF.of_Confirma_Transacao()
								
			lb_Sucesso = True
			
		Else
			
			SITEF.of_Cancela_Transacao()
												
			lb_Sucesso = False
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de reter o comprovante da venda TEF, pois a transa$$HEX2$$e700e300$$ENDHEX$$o foi cancelada.",Exclamation!)
			
		End If
				
	End If
		
End If

Return lb_Sucesso
end function

public function boolean of_transacao_trncentre_abertura ();
Sitef.TrnCentre.of_Inicializa()

If Not of_TrnCentre_Carga_Tabela() Then Return False

If Not of_TrnCentre_Carga_Tabela_Operadora() Then Return False

Return of_TrnCentre_Abertura_Venda()

end function

public function boolean of_transacao_trncentre_new (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
String  ls_restricao = ""

Boolean lb_Sucesso = False

If Not of_Verifica_Dll() Then Return False

This.cd_funcao 			= 590
This.nr_ecf            	= aecf
This.nr_cupom          	= acupomfiscal
This.dt_transacao      	= gf_getserverdate()
This.vl_transacao      	= 000.00
This.de_operador       	= aoperador
This.de_restricao      	= ls_restricao
This.cd_caixa          	= acaixa
This.nr_controle_caixa 	= acontrole_caixa
This.TRNCentre.ivl_Enviados = 0

is_Tipo_Venda = "TRNCENTRE"

If This.of_Inicia_Funcao_Tef() Then
	//Carga das operadoras
	lb_Sucesso = This.of_Controla_Interacao_dll()
	
	If lb_Sucesso Then
		//Carrega Autoriza$$HEX2$$e700e300$$ENDHEX$$o / Cart$$HEX1$$e300$$ENDHEX$$o 
		This.cd_funcao = 591
				
		If This.of_Inicia_Funcao_Tef() Then
			lb_Sucesso = This.of_Controla_Interacao_dll()
		End If
		
	End If 
	
	If lb_Sucesso Then This.TRNCentre.Id_Status = String(This.Id_Status,'00')
	
End If 

SetNull(is_Tipo_Venda)

Return lb_Sucesso
end function

public function boolean of_trncentre_cancela_autorizacao ();Long ll_Indice
Long ll_CodigoResposta

ll_Indice = 1

//Transa$$HEX2$$e700e300$$ENDHEX$$o TRNCentre (SevenPDV)
If of_Sitef_Direto_Parametro(ll_Indice,'41',0,0) = 0 Then

	ll_Indice ++

	//Transa$$HEX2$$e700e300$$ENDHEX$$o de Cancelamento
	If of_Sitef_Direto_Parametro(ll_Indice,'131',0,0) = 0 Then
		
		ll_Indice ++
		
		String ls_data
		
		//Operadora da Carga
		If of_Sitef_Direto_Parametro(ll_Indice,ls_data,0,0) = 0 Then
			
			ll_Indice ++
			
			String ls_Nsu
					
			//Operadora da Carga
			If of_Sitef_Direto_Parametro(ll_Indice,ls_nsu,0,0) = 0 Then
									
				ll_Indice ++
				
				String ls_Rede
				
				//Operadora da Carga
				If of_Sitef_Direto_Parametro(ll_Indice,ls_Rede,0,0) = 0 Then
								
					//Executa Solicita$$HEX2$$e700e300$$ENDHEX$$o de Consulta Produtos
					If of_Sitef_Direto_Executa(99, 240, Ref ll_CodigoResposta, 60, '', '', '', '', 1) = 0 Then
					
						//Obtem Retorno Sitef
						If Not of_Sitef_Direto_Retorno() Then Return False
									
							If of_Sitef_Direto_Servico() Then 
								
								Return True
								
							End If																
						
						End If	
				
				End If
			
			End If	
							
		End If	
		
	End If
	
End If	

Return False
end function

public function boolean of_trncentre_cancelar_venda (datetime adata, string aoperador, long aecf, string acaixa, long acontrole_caixa);
Boolean  lb_Sucesso

Long     ll_ecf 
Long     ll_cupomfiscal

String   ls_funcao[] 																		// Transacao recarga
String   ls_restricao

ls_funcao[1] = "RC"
ls_funcao[2] = "RPC"

If Not This.of_Restricao_Funcao(ls_funcao[],Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
This.cd_funcao    = 590
This.nr_cupom     = ll_CupomFiscal
This.dt_transacao = gf_getserverdate()
This.vl_transacao = 000.00
This.de_operador  = aoperador
This.de_restricao = ls_restricao
This.nr_ecf       		= aecf
This.cd_caixa          	= acaixa
This.nr_controle_caixa 	= acontrole_caixa

is_Tipo_Venda = "TRNCENTRE"

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
	
	If lb_Sucesso Then
		//Carrega Autoriza$$HEX2$$e700e300$$ENDHEX$$o / Cart$$HEX1$$e300$$ENDHEX$$o 
		This.cd_funcao = 594
		
		If This.of_Inicia_Funcao_Tef() Then
			lb_Sucesso = This.of_Controla_Interacao_dll()
			
			If lb_Sucesso Then
				lb_Sucesso = This.of_Finaliza_Transacao(This.ib_NFCE, This.nr_nf)
			End If			
		End If
		
	End If 
End If

Return lb_Sucesso
end function

public function boolean of_reimpressao_comprovante_especifico ();Boolean lb_Sucesso

lb_Sucesso = This.of_Transacao_Tef(113)

//This.of_Transacao_Pendente()

Return lb_Sucesso
end function

public function boolean of_impressao_cancelamento_pbm ();String  ls_Linha,&
        ls_Comprovante,&
        ls_Resposta,&
		  ls_texto,&
		  ls_Gerencial[]
	
Long    ll_Row	
Long    ll_Byte
Long    ll_Via
Long	  ll_Idx
Long	  ll_Tentativas

Boolean lb_Impressao ,&
		  lb_Abertura  ,&
        lb_Tentar
		
Decimal {2} lvdc_Valor = 0.01

lb_impressao = False

dc_uo_ds_base lds_3
lds_3 = Create dc_uo_ds_base

If Not lds_3.of_ChangeDataObject('ds_ge084_transacao_tef') Then Return False

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas com cupom fiscal impresso que precisam ser confirmadas
lds_3.of_RestoreSqlOriginal()
lds_3.of_AppendWhere("id_situacao <> 'C' and nr_ecf = " + String(SITEF.nr_ecf) + " and nr_coo_ecf = " + String(Sitef.nr_cupom) + " and cd_funcao in (594,562)")

lds_3.Retrieve()

ls_comprovante = ''
ls_texto 		= ''
ll_Idx			= 1

lb_Impressao = True	

For ll_Row = 1 To lds_3.RowCount()
	If Not IsNull(lds_3.object.de_via_cliente[ll_Row]) Then
		ls_Comprovante += lds_3.object.de_via_cliente[ll_Row]
		If Sitef.cd_funcao = 300 Or  Sitef.cd_funcao = 301 Then
			ls_Comprovante += CharA(10) + "											"
//			ls_Comprovante += Char(10) + " - - - - - - - - - - - - - - recorte - - 8< - -"
			ls_Comprovante += CharA(10) + "                                 " + CharA(10)
			ls_Comprovante += lds_3.object.de_via_cliente[ll_Row]
		End If	
		ls_Gerencial[ll_Idx] = lds_3.object.de_via_cliente[ll_Row]
		ll_Idx++		
	End If

	If Not IsNull(lds_3.object.de_via_caixa[ll_Row]) Then
		
		If ls_Comprovante <> "" Then
			ls_Comprovante += CharA(10) + "											"
//			ls_Comprovante += Char(10) + " - - - - - - - - - - - - - - recorte - - 8< - -"
			ls_Comprovante += CharA(10) + "                                 " + CharA(10)
			ls_texto += CharA(10) + "											"
			ls_texto += CharA(10) + "                                 " + CharA(10)
		End If	
	
		ls_Comprovante += lds_3.object.de_via_caixa[ll_Row]
		ls_texto += lds_3.object.de_via_caixa[ll_Row]
		
		ls_Comprovante += CharA(10) + "											"
		ls_Comprovante += CharA(10) + "                                 " + CharA(10)
		
		ls_texto += CharA(10) + "											"
		ls_texto += CharA(10) + "                                 " + CharA(10)
		
		ls_Gerencial[ll_Idx] = ls_texto
		ll_Idx++		
	
	End If		
	
	If IsNull(ls_Comprovante) Then
		Return False
	End If


	This.vl_Transacao 		= lds_3.object.vl_transacao			[ll_Row]
	This.cd_forma_pagamento = lds_3.object.cd_forma_pagamento	[ll_Row]	

Next

If ls_Comprovante <> '' And Not IsNull(ls_Comprovante) Then	
	If Not pdv.of_emite_comprovante("VIA PBM", ls_Gerencial, lvdc_Valor) Then 
		Return False
	Else
		lb_Impressao = True	
	End If 
End If
 
 If IsValid( lds_3 ) Then Destroy lds_3
 GarbageCollect()
 
Return lb_Impressao
end function

public function boolean of_trncentre_carga_tabela ();
Long  ll_Retorno
Long  ll_CodigoResposta

This.TrnCentre.of_Inicializa()

//Transa$$HEX2$$e700e300$$ENDHEX$$o TRNCentre (SevenPDV)
If of_Sitef_Direto_Parametro(1,'41',0,0) = 0 Then

	//Carga de Tabelas
	If of_Sitef_Direto_Parametro(2,'1',0,0) = 0 Then
	

		//Executa Solicita$$HEX2$$e700e300$$ENDHEX$$o ao Sitef
		If of_Sitef_Direto_Executa(99, 240, Ref ll_CodigoResposta, 30, '', '', '', '', 0) = 0 Then
		
			If ll_CodigoResposta = 0 Then
			
				//Obtem Retorno Sitef
				If Not of_Sitef_Direto_Retorno() Then Return False
				
				Return This.TrnCentre.of_Retorno_Carga_Tabela(ds_Servico)
				
			End If
			
		End If	
		
	End If
	
End If	
																										
Return False
end function

public function boolean of_trncentre_carga_tabela_operadora ();
Long  ll_Retorno
Long  ll_CodigoResposta

//Transa$$HEX2$$e700e300$$ENDHEX$$o TRNCentre (SevenPDV)
If of_Sitef_Direto_Parametro(1,'41',0,0) = 0 Then

	//Carga de Tabelas Operadora Espec$$HEX1$$ed00$$ENDHEX$$fica
	If of_Sitef_Direto_Parametro(2,'2',0,0) = 0 Then
		
		//Operadora da Carga
		If of_Sitef_Direto_Parametro(3,This.TrnCentre.cd_Operadora,0,0) = 0 Then
	
			//Executa Solicita$$HEX2$$e700e300$$ENDHEX$$o ao Sitef
			If of_Sitef_Direto_Executa(99, 240, Ref ll_CodigoResposta, 60, '', '', '', '', 0) = 0 Then
			
				If ll_CodigoResposta = 255 Then Return True
			
				//Obtem Retorno Sitef
				Return Sitef.TrnCentre.of_Retorno_Carga_Tabela_Operadora(ds_Servico)
								
			End If	
			
		End If	
		
	End If
	
End If	
																										
Return False
end function

public function boolean of_registra_prevenda ();
Boolean  lb_Sucesso  = True

String   ls_nsu
String   ls_nsu_sitef
String   ls_bandeira
String   ls_cartao
String   ls_estabelecimento
String   ls_caixa
String   ls_especie
String   ls_serie
String 	ls_autorizadora

Long     ll_Funcao
Long     ll_Transacao
Long     ll_parcelas
Long     ll_controle_caixa
Long     ll_filial
Long     ll_doc
Long     ll_registro
Long     ll_ecf
Long     ll_cupom
	
Datetime ldt_data_transacao
DateTime ldt_data

Decimal  ldc_valor
Decimal  ldc_saque
Decimal  ldc_transacao

Long     ll_sequencial
Long     ll_row

dc_uo_ds_base lds_comprovante
lds_comprovante = Create dc_uo_ds_base

If Not lds_comprovante.of_ChangeDataObject('ds_ge084_transacao_tef') Then
	Destroy(lds_comprovante)
	Return False
End If

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas com cupom fiscal impresso que precisam ser confirmadas
lds_comprovante.of_AppendWhere("cd_forma_pagamento in ('01','02') and nr_ecf = " + String(This.nr_ecf) + " and nr_coo_ecf = " + String(This.nr_cupom) )

lds_comprovante.Retrieve()

If lds_comprovante.RowCount() = 0 Then 
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Sem comprovante a ser impresso ECF [" + String(PDV.ecf,'000') + "] Cupom [" + String(This.nr_cupom,'00000000')+"]")
	Return True
End If	

For ll_Row = 1 To lds_comprovante.RowCount()
	
	ls_autorizadora    = lds_comprovante.object.cd_autorizadora   [ll_Row] 
	
	If ls_autorizadora = This.EdmCard.cd_Rede Then Continue

	ll_funcao          = lds_comprovante.object.cd_funcao         [ll_Row]
	ll_ecf             = lds_comprovante.object.nr_ecf            [ll_Row]
	ll_cupom           = lds_comprovante.object.nr_coo_ecf 		  [ll_Row]
	ll_transacao       = lds_comprovante.object.nr_transacao		  [ll_Row]
	ls_nsu             = lds_comprovante.object.nr_nsu_host       [ll_Row]
	ls_bandeira        = lds_comprovante.object.de_bandeira       [ll_Row]
	ldt_data_transacao = lds_comprovante.object.dt_transacao      [ll_Row]
	ll_parcelas        = lds_comprovante.object.qt_parcelas       [ll_Row]
	ldc_valor          = lds_comprovante.object.vl_transacao      [ll_Row]
	ldc_saque          = lds_comprovante.object.vl_saque          [ll_Row]
	ls_cartao          = lds_comprovante.object.nr_cartao         [ll_Row]
	ls_estabelecimento = lds_comprovante.object.cd_estabelecimento[ll_Row]
	ls_caixa           = lds_comprovante.object.cd_caixa          [ll_Row]
	ll_controle_caixa  = lds_comprovante.object.nr_controle_caixa [ll_Row]
			
	SetNull(ll_filial)
	SetNull(ll_doc)
	SetNull(ls_especie)
	SetNull(ls_serie)
		
	SetNull(ll_Sequencial)
	
	If Upper(Trim(ls_bandeira)) = 'TNEXX' Then
		ls_nsu_sitef = lds_comprovante.object.nr_nsu_sitef[ll_Row]
	Else
		ls_nsu_sitef = ls_nsu
	End If
	
	If This.of_Inclui_Cartao_Comprovante_Venda(ls_caixa, ll_controle_caixa, ll_ecf, ll_Cupom) Then
			
		If This.of_Sequencial_Comprovante_Caixa(ls_caixa, ll_controle_caixa, Ref ll_sequencial) Then			
		
			ldc_transacao      = ldc_valor + ldc_saque
		
			ls_estabelecimento = MidA(ls_estabelecimento,2,10)
			
			ls_nsu		       = String(Long(ls_nsu),'000000')
			
			This.of_valida_bandeira_produto(Ref ls_bandeira)
			
			//Acerto para vendas do cartao VISA e VISA ELECTRON autorizadas pela autorizadora 00005 - REDECARD
			If ls_Autorizadora = '00005' Then
				If Upper(Trim(ls_bandeira)) = 'VISA' Then
					ls_bandeira = 'VISA CREDITO - REDE'
				ElseIf Upper(Trim(ls_bandeira)) = 'VISA ELECTRON' Then
					ls_bandeira = 'VISA DEBITO - REDE'
				ElseIf Upper(Trim(ls_bandeira)) = 'VISA ELECTRON NA' Then					
					ls_bandeira = 'VISA DEBITO - REDE'															
				ElseIf Upper(Trim(ls_bandeira)) = 'HIPERCARD' Then
					ls_bandeira = 'HIPERCARD - REDE'
				ElseIf Upper(Trim(ls_bandeira)) = 'MASTERCARD' Then
					ls_bandeira = 'MASTERCARD CREDITO - REDE'
				ElseIf Upper(Trim(ls_bandeira)) = 'MAESTRO' Then
					ls_bandeira = 'MASTERCARD DEBITO - REDE'
				End IF									
			End If
			
			If Long(ls_Autorizadora) <> 5 and Long(ls_Autorizadora) <> 181 Then
				If Upper(Trim(ls_bandeira)) = 'SOFTNEX' Then
					ls_bandeira = 'ROM CARD'
				ElseIf Upper(Trim(ls_bandeira)) = 'PARATI' Then
					ls_bandeira = 'SENFF'
				ElseIf Upper(Trim(ls_bandeira)) = 'MAXICRED' Then
					ls_bandeira = 'MAXICRED/AGEMED'
				ElseIf Upper(Trim(ls_bandeira)) = 'SODEXHO' Then
					ls_bandeira = 'UNICK'
				End IF
			End If							
					
			Insert Into cartao_comprovante_venda
				( cd_caixa,
				  nr_controle_caixa,
				  cd_filial,
				  nr_nf,
				  de_especie,
				  de_serie,
				  nr_sequencial,
				  nm_produto,
				  nr_cartao,
				  nr_autorizacao,
				  nr_nsu,
				  dh_venda,
				  vl_venda,
				  vl_saque,
				  qt_parcelas,
				  id_captura,
				  id_cancelamento,
				  cd_estabelecimento,
				  id_parcelamento,
				  nr_ecf,
				  nr_coo_ecf,
				  id_pre_venda)
			Values(:ls_caixa,
					 :ll_controle_caixa,
					 :ll_filial,
					 :ll_doc,
					 :ls_especie,
					 :ls_serie,   
					 :ll_sequencial,
					 :ls_bandeira,
					 :ls_cartao,
					 :ls_nsu,
					 :ls_nsu_sitef,
					 :ldt_data_transacao,
					 :ldc_transacao,
					 :ldc_saque,
					 :ll_parcelas,
					 'T',
					 'N',
					 :ls_estabelecimento,
					 'L',
					 :ll_ecf,
					 :ll_cupom,
					 'S')
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Lan$$HEX1$$e700$$ENDHEX$$amento do Comprovante Caixa")
				Sqlca.of_MsgDbError('Grava$$HEX2$$e700e300$$ENDHEX$$o do comprovante do cart$$HEX1$$e300$$ENDHEX$$o.')
				lb_Sucesso = False
				Exit
			Else
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Comprovante Caixa Lan$$HEX1$$e700$$ENDHEX$$ado PREVENDA. ECF [" + String(ll_ecf) + "], COO [" + String(ll_cupom) + "], SEQ [" + String(ll_sequencial) + "], NSU [" + ls_nsu + "]")								
				ll_Registro ++		
			End If
			
		End If	
		
	End If	
		
Next

Destroy(lds_comprovante)
GarbageCollect()

If lb_Sucesso Then
	If ll_Registro > 0 Then
		Sqlca.of_Commit()
	End If
Else
	Sqlca.of_RollBack()
End If	

Return lb_Sucesso
end function

public function boolean of_funcional_consulta_autorizacao ();If Not This.Funcional.of_Ini_Correto() Then Return False

If Not This.Funcional.of_carrega_autorizacao() Then Return False

Return True
end function

public function boolean of_cancela_transacao ();Return This.of_Cancela_Transacao(True)
end function

public function boolean of_cancela_transacao (boolean pb_mostra_resumo);//Cancelamento $$HEX1$$e900$$ENDHEX$$ enviado para o TEF, mesmo sem conex$$HEX1$$e300$$ENDHEX$$o com o banco.
//Pois se a mesma transacao for tentada novamente, somente uma ser$$HEX1$$e100$$ENDHEX$$ confirmada.
String ls_Cupom
String ls_Data
String ls_Hora
String	 ls_Retorno
//e-mail log
String ls_funcao
String ls_ecf
String ls_caixa
String ls_controle
String ls_nsu_sitef
String ls_nsu_host
String ls_autorizacao
String ls_Chave

Long   ll_Registros
Long   ll_Retorno
Long   ll_transacoes_pendentes

ls_Cupom = String(This.nr_cupom,'00000000')
ls_Data  = String(This.dt_transacao,'yyyymmdd')
ls_Hora  = String(Time(This.dt_transacao),'hhmmss')

//N$$HEX1$$e300$$ENDHEX$$o envia cancelamento para transa$$HEX2$$e700e300$$ENDHEX$$o de reimpress$$HEX1$$e300$$ENDHEX$$o $$HEX1$$fa00$$ENDHEX$$ltimo comprovante
If This.cd_funcao <> 114 Then

	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_confirma_transacao - Vai enviar o CANCELAMENTO para o TEF. Cupom [" + ls_Cupom + "]" + &
										  " ls_cupom: " + ls_Cupom + " ls_data: " + ls_data + " ls_hora: " + ls_hora)

	If This.id_transacao_interrompida Then
		ll_Retorno = FinalizaFuncaoSiTefInterativo(0, ls_Cupom , ls_Data , ls_Hora,  '{NumeroPagamentoCupom='+This.nr_identificador_pgto+'}')		
	Else
		ll_Retorno = FinalizaFuncaoSiTefInterativo(0, ls_Cupom , ls_Data , ls_Hora,  '')
	End If
	
	If IsNull(ll_retorno) Then
		ls_Retorno = 'NULO'
	Else
		ls_Retorno = String(ll_Retorno)
	End If	
	
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_confirma_transacao - Passou pelo cancelamento do TEF. Cupom [" + ls_Cupom + "] ls_retorno: "+ ls_Retorno + &
										  " ls_cupom: " + ls_Cupom + " ls_data: " + ls_data + " ls_hora: " + ls_hora)										  
End If
											  
If This.of_teste_conexao_bd() Then // Verifica se tem conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados para ent$$HEX1$$e300$$ENDHEX$$o cancelar no TEF.											  
	//N$$HEX1$$e300$$ENDHEX$$o envia cancelamento para transa$$HEX2$$e700e300$$ENDHEX$$o de reimpress$$HEX1$$e300$$ENDHEX$$o $$HEX1$$fa00$$ENDHEX$$ltimo comprovante
	If This.cd_funcao <> 114 Then		
		ll_transacoes_pendentes = of_Verifica_Transacao_Pendente_Servidor()
		
		ds_Cancelamento = Create dc_uo_ds_base				
		If Not ds_Cancelamento.of_ChangeDataObject('dw_ge084_transacao_tef') Then Return False		

		ds_Cancelamento.of_RestoreSqlOriginal()
		ds_Cancelamento.of_AppendWhere("nr_ecf = " + String(This.nr_ecf) + " and nr_coo_ecf = " + ls_Cupom)		
		ds_Cancelamento.Retrieve()											
		
		If ll_transacoes_pendentes = 0 Then		
			If This.ib_NFCE Then
				If Not IsNull(This.nr_nf) And This.nr_nf > 0  Then	
					Update cartao_comprovante_venda
					Set id_cancelamento_Sitef = 'S'
					Where cd_caixa          = :This.cd_caixa
					  and nr_controle_caixa = :This.nr_controle_caixa
					  and nr_nf            = :This.nr_nf
					Using Sqlca;
				End If
			Else
				Update cartao_comprovante_venda
				Set id_cancelamento_Sitef = 'S'
				Where cd_caixa          = :This.cd_caixa
				  and nr_controle_caixa = :This.nr_controle_caixa
				  and nr_ecf            = :This.nr_ecf
				  and nr_coo_ecf        = :This.nr_cupom
				Using Sqlca;
			End If
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()	
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o do comprovante cart$$HEX1$$e300$$ENDHEX$$o venda.")
				Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o do comprovante cart$$HEX1$$e300$$ENDHEX$$o venda.")
				Return False
			End If
			
			ll_Registros += Sqlca.SqlnRows
			
			If ll_Registros = 0 Then
				gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o comprovante cart$$HEX1$$e300$$ENDHEX$$o venda. Fun$$HEX2$$e700e300$$ENDHEX$$o:" + String(This.cd_Funcao) + ' ECF [' + String(This.nr_ecf) + '] Cupom : [' + String(This.nr_cupom) + ']' )
			End If		
	
//			ds_Cancelamento = Create dc_uo_ds_base
//			
//			If Not ds_Cancelamento.of_ChangeDataObject('dw_ge084_transacao_tef') Then Return False		
//	
//			ds_Cancelamento.of_RestoreSqlOriginal()
//			ds_Cancelamento.of_AppendWhere("nr_ecf = " + String(This.nr_ecf) + " and nr_coo_ecf = " + ls_Cupom)		
//			ds_Cancelamento.Retrieve()
						
			Delete From transacao_tef
			Where nr_ecf      = :This.nr_ecf
			  and nr_coo_ecf  = :This.nr_cupom
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()		
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o controle de transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
				Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o controle de transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
				Return False
			End If	
			
			ll_Registros += Sqlca.SqlnRows
			
			If ll_Registros > 0 Then Sqlca.of_Commit()
			
			ls_Chave = String(This.nr_ecf,'000') + String(This.nr_cupom,'00000000')
				
			If pb_Mostra_Resumo Then OpenWithParm(w_ge084_transacao_pendente,'CANCELA')
			
			Destroy(ds_cancelamento)
		
		Else
			If ll_transacoes_pendentes = -13 Then //Retorno do TEF que n$$HEX1$$e300$$ENDHEX$$o encontrou transa$$HEX2$$e700e300$$ENDHEX$$o pendente, mas precisa ser excluido a transacao do banco
				Delete From transacao_tef
				Where nr_ecf      = :This.nr_ecf
				  and nr_coo_ecf  = :This.nr_cupom
				Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_RollBack()		
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o controle de transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
					Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o controle de transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
					Return False
				End If	
				
				ls_Chave = String(This.nr_ecf,'000') + String(This.nr_cupom,'00000000')											  
			End If
			If This.cd_funcao = 300 Or This.cd_funcao = 301 Then	//Recarga - tem que excluir as pendentes porque n$$HEX1$$e300$$ENDHEX$$o gravou nada no banco.

				Delete From transacao_tef
				Where nr_ecf      = :This.nr_ecf
				  and nr_coo_ecf  = :This.nr_cupom
				Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_RollBack()		
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o controle de transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
					Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o controle de transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
					Return False
				End If	
				
				ls_Chave = String(This.nr_ecf,'000') + String(This.nr_cupom,'00000000')				
			End If
			
			ll_Registros += Sqlca.SqlnRows				
			If ll_Registros > 0 Then Sqlca.of_Commit()
			
			If Not This.id_transacao_interrompida And This.cd_funcao <> 300 And This.cd_funcao <> 301 And ll_transacoes_pendentes <> -13 Then
				gvo_Aplicacao.of_Grava_Log("Transa$$HEX2$$e700f500$$ENDHEX$$es pendentes Servidor TEF. N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o TEF pendente: " + ls_Chave)		
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700f500$$ENDHEX$$es pendentes Servidor TEF. N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o TEF pendente: " + ls_Chave + "~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_sitef - of_Cancela_transacao()", Exclamation!)
				Return False
			Else				
				This.id_transacao_interrompida = False
				If pb_Mostra_Resumo Then OpenWithParm(w_ge084_transacao_pendente,'CANCELA')
			End If
			Destroy(ds_cancelamento)			
		End If		
	End If
	
//	If This.Pendente Then
//		If IsNull(This.cd_funcao) Then
//			ls_funcao = 'NULO'
//		Else
//			ls_funcao = String(This.cd_funcao)
//		End If	
//		If IsNull(This.nr_ecf) Then
//			ls_ecf = 'NULO'
//		Else
//			ls_ecf = String(This.nr_ecf)
//		End If
//		If IsNull(This.cd_caixa) Then
//			ls_caixa = 'NULO'
//		Else
//			ls_caixa = This.cd_caixa
//		End If
//		If IsNull(This.nr_controle_caixa) Then
//			ls_controle = 'NULO'
//		Else
//			ls_controle = String(This.nr_controle_caixa)
//		End If
//		If IsNull(This.nr_nsu_sitef) Then
//			ls_nsu_sitef = 'NULO'
//		Else
//			ls_nsu_sitef = This.nr_nsu_sitef
//		End If
//		If IsNull(This.nr_nsu_host) Then
//			ls_nsu_host = 'NULO'
//		Else
//			ls_nsu_host = This.nr_nsu_host
//		End If
//		If IsNull(This.nr_autorizacao) Then
//			ls_autorizacao = 'NULO'
//		Else
//			ls_autorizacao = This.nr_autorizacao
//		End If
//	
//		gf_ge202_envia_email_log(63,'LOG CAIXA CANCELA TRANSACAO TEF PENDENTE - LOJA(' + String(gvo_parametro.cd_filial) +')', &
//											' Fun$$HEX2$$e700e300$$ENDHEX$$o: ' + ls_funcao + ' Cupom: ' + ls_cupom + ' Data Hora: ' +ls_data + ' ' + ls_hora + '<br />' +&
//											' ECF: ' + ls_ecf + ' CAIXA: ' + ls_caixa + ' CONTROLE: ' + ls_controle + '<br />' +&
//											' NSU_SITEF: ' + ls_nsu_sitef + ' NSU_HOST: ' + ls_nsu_host + ' Autorizacao: ' + ls_autorizacao + '<br />' +&
//											' Retorno do CANCELAMENTO no TEF: ' + ls_retorno)									
//	End If

Else
	gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar(cancelar) o comprovante cart$$HEX1$$e300$$ENDHEX$$o venda - SEM CONEX$$HEX1$$c300$$ENDHEX$$O com o Banco de dados. Fun$$HEX2$$e700e300$$ENDHEX$$o:" + String(This.cd_Funcao) + ' ECF [' + String(This.nr_ecf) + '] Cupom : [' + String(This.nr_cupom) + ']' )
	Return False	
End If

Return True
end function

public function boolean of_confirma_transacao ();
Return This.of_Confirma_Transacao(False)
end function

public function boolean of_confirma_transacao (boolean pb_mostra_resumo);
String ls_Cupom
String ls_Data
String ls_Hora
String ls_Retorno
//e-mail log
String ls_funcao
String ls_ecf
String ls_caixa
String ls_controle
String ls_nsu_sitef
String ls_nsu_host
String ls_autorizacao

Long   ll_Registros
Long   ll_Retorno

ls_Cupom = String(This.nr_cupom,'00000000')
ls_Data  = String(This.dt_transacao,'yyyymmdd')
ls_Hora  = String(Time(This.dt_transacao),'hhmmss')

If This.of_teste_conexao_bd() Then // Verifica se tem conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados para ent$$HEX1$$e300$$ENDHEX$$o confirmar no TEF.

	//N$$HEX1$$e300$$ENDHEX$$o envia confirma$$HEX2$$e700e300$$ENDHEX$$o para transa$$HEX2$$e700e300$$ENDHEX$$o de reimpress$$HEX1$$e300$$ENDHEX$$o $$HEX1$$fa00$$ENDHEX$$ltimo comprovante
	If This.cd_funcao <> 114 Then
	
		gvo_Aplicacao.of_Grava_Log("uo_sitef - of_confirma_transacao - Vai enviar a confirma$$HEX2$$e700e300$$ENDHEX$$o para o TEF. Cupom [" + ls_Cupom + "]" + &
											  " ls_cupom: " + ls_Cupom + " ls_data: " + ls_data + " ls_hora: " + ls_hora)
											  
		ll_Retorno = FinalizaFuncaoSiTefInterativo(1, ls_Cupom , ls_Data , ls_Hora,  '')		
		
		gvo_Aplicacao.of_Grava_Log("uo_sitef - of_confirma_transacao - Passou pela confirma$$HEX2$$e700e300$$ENDHEX$$o do TEF. Cupom [" + ls_Cupom + "] ls_retorno: "+ ls_Retorno + &
											  " ls_cupom: " + ls_Cupom + " ls_data: " + ls_data + " ls_hora: " + ls_hora)	
		
		If pb_mostra_resumo Then
			
			String ls_Chave
			
			ls_Chave = String(This.nr_ecf,'000') + String(This.nr_cupom,'00000000')
			
			If pb_Mostra_Resumo Then OpenWithParm(w_ge084_transacao_confirmada,ls_Chave)
			
		End If
	
	End If
	
	//Inclus$$HEX1$$e300$$ENDHEX$$o do parametro cd_funcao not in (240,542, 592 e 593(TRNCentre New), 561 e 562(Funcional Car TEF))
	//- Para imprimir os comprovante dos PBM como Relat$$HEX1$$f300$$ENDHEX$$rios Gerenciais
	
	If IsNull(ll_retorno) Then
		ls_Retorno = 'NULO'
	Else
		ls_Retorno = String(ll_Retorno)
	End If
	
	//gvo_Aplicacao.of_Grava_Log("uo_sitef - of_confirma_transacao - Transa$$HEX2$$e700e300$$ENDHEX$$o efetuada com sucesso. Cupom [" + ls_Cupom + "] ls_retorno: "+ ls_Retorno + &
	//									  " ls_cupom: " + ls_Cupom + " ls_data: " + ls_data + " ls_hora: " + ls_hora)
	
//	If This.Pendente Then
//	If IsNull(This.cd_funcao) Then
//		ls_funcao = 'NULO'
//	Else
//		ls_funcao = String(This.cd_funcao)
//	End If
//	If IsNull(This.nr_ecf) Then
//		ls_ecf = 'NULO'
//	Else
//		ls_ecf = String(This.nr_ecf)
//	End If
//	If IsNull(This.cd_caixa) Then
//		ls_caixa = 'NULO'
//	Else
//		ls_caixa = This.cd_caixa
//	End If
//	If IsNull(This.nr_controle_caixa) Then
//		ls_controle = 'NULO'
//	Else
//		ls_controle = String(This.nr_controle_caixa)
//	End If
//	If IsNull(This.nr_nsu_sitef) Then
//		ls_nsu_sitef = 'NULO'
//	Else
//		ls_nsu_sitef = This.nr_nsu_sitef
//	End If
//	If IsNull(This.nr_nsu_host) Then
//		ls_nsu_host = 'NULO'
//	Else
//		ls_nsu_host = This.nr_nsu_host
//	End If
//	If IsNull(This.nr_autorizacao) Then
//		ls_autorizacao = 'NULO'
//	Else
//		ls_autorizacao = This.nr_autorizacao
//	End If
//	
//	gf_ge202_envia_email_log(63,'LOG CAIXA CONFIRMA TRANSACAO TEF PENDENTE - LOJA(' + String(gvo_parametro.cd_filial) +')', &
//										' Fun$$HEX2$$e700e300$$ENDHEX$$o: ' + ls_funcao + ' Cupom: ' + ls_cupom + ' Data Hora: ' +ls_data + ' ' + ls_hora + '<br />' +&
//										' ECF: ' + ls_ecf + ' CAIXA: ' + ls_caixa + ' CONTROLE: ' + ls_controle + '<br />' +&
//										' NSU_SITEF: ' + ls_nsu_sitef + ' NSU_HOST: ' + ls_nsu_host + ' Autorizacao: ' + ls_autorizacao + '<br />' +&
//										' Retorno da CONFIRMA$$HEX2$$c700c300$$ENDHEX$$O no TEF: ' + ls_retorno)									
//	End If
	
	Delete From transacao_tef
	Where nr_ecf     = :This.nr_ecf
	and nr_coo_ecf = :This.nr_cupom
	and cd_funcao not in (2,3,122)
	and cd_funcao not in (240, 542, 592, 593, 561, 562)
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Exclus$$HEX1$$e300$$ENDHEX$$o do registro da transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
	Return False
	End If
	
	ll_Registros += Sqlca.SqlnRows
	
	Delete From transacao_tef
	Where nr_ecf     = :This.nr_ecf
	and nr_coo_ecf = :This.nr_cupom
	and ( cd_funcao = 2 or cd_funcao = 3 or cd_funcao = 122 )
	and Exists ( Select *
					  From cartao_comprovante_venda
					 Where cd_caixa 			 = :This.cd_caixa
						and nr_controle_caixa = :This.nr_controle_caixa
						and nr_ecf            = :This.nr_ecf
						and nr_coo_ecf        = :This.nr_cupom )
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Exclus$$HEX1$$e300$$ENDHEX$$o do registro da transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
	Return False
	End If
	
	ll_Registros += Sqlca.SqlnRows
	
	Delete From transacao_tef
	Where nr_ecf     		 = :This.nr_ecf
	and nr_coo_ecf		 = :This.nr_cupom
	and cd_autorizadora = '00019'
	and ( cd_funcao = 2 or cd_funcao = 3 or cd_funcao = 122 Or cd_funcao = 15 )
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Exclus$$HEX1$$e300$$ENDHEX$$o do registro da transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
	Return False
	End If
	
	ll_Registros += Sqlca.SqlnRows
	
	If ll_Registros > 0 Then Sqlca.of_Commit()
Else
	gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar(confirmar) o comprovante cart$$HEX1$$e300$$ENDHEX$$o venda - SEM CONEX$$HEX1$$c300$$ENDHEX$$O com o Banco de dados. Fun$$HEX2$$e700e300$$ENDHEX$$o:" + String(This.cd_Funcao) + ' ECF [' + String(This.nr_ecf) + '] Cupom : [' + String(This.nr_cupom) + ']' )
	Return False	
End If 

Return True
end function

public function boolean of_inicia_comunicacao ();
Integer li_Retorno

String ls_Resultado
String ls_Log
String ls_cnpj
String ls_parametro_ad

Open(w_ge084_aguarde)
w_ge084_aguarde.wf_mensagem("Conectando Servidor SITEF ...")

SetPointer(HourGlass!)

//Parametros adicionais - Chamado: 449080
ls_cnpj = gvo_parametro.nr_cgc
ls_parametro_ad = '[ParmsClient=1='+ ls_cnpj +';2=84683481000177]'

//li_Retorno = ConfiguraIntSitefInterativo(Ref This.nr_servidor_tef,This.id_empresa_tef,This.de_terminal_tef,'000000')
li_Retorno = ConfiguraIntSitefInterativoEx(Ref This.nr_servidor_tef,This.id_empresa_tef,This.de_terminal_tef,'000000', ls_parametro_ad)

Close(w_ge084_aguarde)

Choose Case li_Retorno
	Case 0		
		This.id_Status = 0
		This.of_verifica_versao_dll()
		Return True		
	Case 1
		MessageBox("Sitef","(1) Endere$$HEX1$$e700$$ENDHEX$$o IP inv$$HEX1$$e100$$ENDHEX$$lido ou n$$HEX1$$e300$$ENDHEX$$o resolvido.",StopSign!)
	Case 2
		MessageBox("Sitef","(2) C$$HEX1$$f300$$ENDHEX$$digo da loja inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
	Case 3
		MessageBox("Sitef","(3) C$$HEX1$$f300$$ENDHEX$$digo do terminal inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
	Case 6
		MessageBox("Sitef","(6) Erro na inicializa$$HEX2$$e700e300$$ENDHEX$$o TCP/IP.",StopSign!)
	Case 7
		MessageBox("Sitef","(7) Falta de mem$$HEX1$$f300$$ENDHEX$$ria.",StopSign!)
	Case 8
		MessageBox("Sitef","(8) N$$HEX1$$e300$$ENDHEX$$o encontrou a biblioteca CliSitef ou problemas.",StopSign!)
	Case 10
		MessageBox("Sitef","(10) Pinpad n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ devidamente configurado no arquivo CliSiTef.ini",StopSign!)		
End Choose

Return False
end function

public function boolean of_inclui_cartao_comprovante_prevenda (string acaixa, long acontrole_caixa, long aecf, long acupom);Long ll_sequencial

Select nr_sequencial Into :ll_sequencial
From cartao_comprovante_prevenda
Where cd_caixa          = :acaixa
  and nr_controle_caixa = :acontrole_caixa
  and nr_ecf				= :aecf
  and nr_coo_ecf			= :acupom
Using Sqlca;

Choose Case Sqlca.Sqlcode
	Case -1
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Comprovante. Caixa:" + acaixa + " Controle: " + String(acontrole_caixa) + " ECF:" + String(aecf) + "Cupom:" + String(acupom) )
		Sqlca.of_MsgDbError('Sequencial comprovante de cart$$HEX1$$e300$$ENDHEX$$o.')
		Return False
	Case 0
		Return False
	Case 100
		Return True
End Choose


end function

public function boolean of_inicializa_comprovante_tef (boolean pb_erro);Boolean lvb_Retorno = False

Boolean lb_abertura
Boolean lb_abertura_nao_Fiscal 	= False
Boolean lb_Cartao_Presente 		= False

String  lvs_Recebimento,&
        lvs_Mensagem,&
		  lvs_Pagto
		  
Decimal {2} lvdc_Valor

Long    ll_Parcelas
Long	  ll_funcao

If Not IsNull(This.cd_funcao_principal) And This.cd_funcao_principal > 0 Then
	ll_funcao = This.cd_funcao_principal
Else
	ll_funcao = This.cd_funcao
End If

Choose Case ll_funcao
	Case 240
		
		If Not IsNull(This.cd_forma_pagamento) Then
			
			Choose Case This.cd_forma_pagamento
				Case '98'				//Dinheiro
					lvs_Pagto = '01'
				Case '00'				//Cheque
					lvs_Pagto = '02'				
				Case '02'				//Credito
					If This.cd_forma_pagamento_original = '03' Then  //Voucher - finalizar em cartao debito, pois a venda foi finalizada em cart$$HEX1$$e300$$ENDHEX$$o debito.
						lvs_Pagto = '05'
					Else
						lvs_Pagto = '04'
					End If
				Case '01'				//Debito
					lvs_Pagto = '05'
			End Choose
			
		Else
			lvs_Pagto = '10'
		End If	
		
		If lvs_Pagto = '01' Then lb_abertura_nao_Fiscal = True
		
		lvs_Recebimento = '01'
		lvs_Mensagem    = 'TEF'
		
	Case 542
		
		Choose Case This.cd_forma_pagamento
			Case '98'				//Dinheiro
				lvs_Pagto = '01'
			Case '00'				//Cheque
				lvs_Pagto = '02'				
			Case '02'				//Credito
				If This.cd_forma_pagamento_original = '03' Then  //Voucher - finalizar em cartao debito, pois a venda foi finalizada em cart$$HEX1$$e300$$ENDHEX$$o debito.
					lvs_Pagto = '05'
				Else
					lvs_Pagto = '04'
				End If
			Case '01'				//Debito
				lvs_Pagto = '05'
		End Choose
		
		If lvs_Pagto = '01' Then lb_abertura_nao_Fiscal = True
		
		lvs_Recebimento = '01'
		lvs_Mensagem    = 'TEF'
		
	Case 300,301,261,264,265,269,275,276 	
		
		lvs_Recebimento = '02'
		If ll_funcao = 300 Or ll_funcao = 301 Then
			lvs_Mensagem    = 'RECARGA CELULAR ONLINE'
		Else
			lvs_Mensagem    = 'VENDA GIFTCARD'			
		End If
		
		Choose Case This.cd_forma_pagamento
			Case '98'				//Dinheiro
				lvs_Pagto = '01'
			Case '00'				//Cheque
				lvs_Pagto = '02'				
			Case '02'				//Credito
				If This.cd_forma_pagamento_original = '03' Then  //Voucher - finalizar em cartao debito, pois a venda foi finalizada em cart$$HEX1$$e300$$ENDHEX$$o debito.
					lvs_Pagto = '05'
				Else
					lvs_Pagto = '04'
				End If
			Case '01'				//Debito
				lvs_Pagto = '05'
			Case '99'
				Choose Case This.cd_funcao_pgto 
					Case 2
						lvs_Pagto = '05'
					Case 3
						lvs_Pagto = '04'
					Case 122
						lvs_Pagto = '05'
					Case Else
						lvs_Pagto = '01'
				End Choose
			End Choose
			
	Case 124  //PIX SAQUE
		
		lvs_Pagto = '01' //Dinheiro
			
		If lvs_Pagto = '01' Then lb_abertura_nao_Fiscal = True
		
		lvs_Recebimento = '01'
		lvs_Mensagem    = 'SAQUE PIX - OPERADOR: ' + This.de_operador + ' CAIXA: ' + This.cd_caixa
			
	Case Else
		
		lvs_Recebimento = '01'
		lvs_Mensagem    = 'TEF'
			
		If This.cd_autorizadora = '00019' Then
			lvs_Pagto = '06'
		Else
			//lvs_Pagto = '04'
			
			//---- Novo
			Choose Case This.cd_forma_pagamento
				Case '98'				//Dinheiro
					lvs_Pagto = '01'
				Case '00'				//Cheque
					lvs_Pagto = '02'	
				Case '02'				//Credito
					If This.cd_forma_pagamento_original = '03' Then  //Voucher - finalizar em cartao debito, pois a venda foi finalizada em cart$$HEX1$$e300$$ENDHEX$$o debito.
						lvs_Pagto = '05'
					Else
						lvs_Pagto = '04'
					End If
				Case '01'				//Debito
					lvs_Pagto = '05'
				Case Else
					lvs_Pagto = '04'
			End Choose
			
		End If	
End Choose

//Valor da transa$$HEX2$$e700e300$$ENDHEX$$o em multiformas de pagamento - Antigo, imprimi todos os cartao e um comprovente
//lvdc_Valor = This.vl_total_transacao

//Imprimi os cartao em comproventes separados - 17/05/2011
lvdc_Valor = This.vl_transacao

// imprimir
//If This.Epharma.vl_pago_avista > 0 Then
//	lvdc_Valor = This.epharma.vl_pago_avista
//ElseIf This.TRNCentre.vl_Total_Nota > 0 Then
//	lvdc_Valor = This.TRNCentre.vl_Total_Nota
//ElseIf This.PharmaSystem.vl_Total_Nota > 0 Then
//	lvdc_Valor = This.PharmaSystem.vl_Total_Nota
//End If

//If This.vl_total_pbm > 0 Then
//	lvdc_Valor = This.vl_total_pbm
//End If

//Essa linha foi implementada para corrigir bugs do Client
If lvdc_Valor = 000.00 Then lvdc_Valor = 0.01

//If lvs_Mensagem = 'VENDA GIFTCARD' Then
//	If gf_cartao_presente_clamed(This.nr_cartao) Then
//		lb_Cartao_Presente = True
//	End If
//End If

//If pb_erro or lb_abertura_nao_Fiscal or ll_funcao = 300 or ll_funcao = 110 or (This.vl_transacao < This.vl_total_transacao) or This.vl_total_pbm > 0 Then
If pb_erro or lb_abertura_nao_Fiscal or ll_funcao = 300 or ll_funcao = 301 or ll_funcao = 261 or ll_funcao = 264 or ll_funcao = 265 or ll_funcao = 269  &
	or ll_funcao = 110 or ll_funcao = 594 or ll_funcao = 562 or ll_funcao = 275 or ll_funcao = 276 or ll_funcao = 124 or ll_funcao = 152 or This.Retaguarda = True Or lb_Cartao_Presente = True Then
	//If lvs_Pagto = '01' Then lvs_Pagto = '04' // Cartao Credito   - Retirado para gravar recarga em dinheiro e a impressao do comprovante ser em relatorio gerencial
	If Not Gerencial Then
		If Retaguarda Then
			lvs_Mensagem = This.de_texto_nao_fiscal
		End If		
		Comprovante_Nao_Fiscal = PDV.of_inicializa_comprovante_nao_fiscal(lvs_Recebimento,lvs_Mensagem,lvs_Pagto,lvdc_Valor)		
		If Comprovante_Nao_Fiscal Then
			If lvs_Pagto = '01' Then
				lb_abertura = PDV.of_inicializa_relatorio_gerencial('01',lvdc_Valor)
				Gerencial = True				
			Else						
				lb_abertura = PDV.of_inicializa_comprovante_tef(lvs_Recebimento,lvs_Mensagem,lvs_Pagto,lvdc_Valor,This.qt_Parcelas, '')
			End If
		End If
	Else
		lb_abertura = PDV.of_inicializa_relatorio_gerencial('01',lvdc_Valor)
	End If
Else
	If Not Gerencial Then //Reimpressao em Relatorio Gerencial
		lb_abertura = PDV.of_inicializa_comprovante_tef(lvs_Recebimento,lvs_Mensagem,lvs_Pagto,lvdc_Valor,This.qt_Parcelas, String(This.nr_Cupom))
	Else
		lb_abertura = PDV.of_inicializa_relatorio_gerencial('01',lvdc_Valor)
	End If
End If

If lb_Abertura Then	
	Open(w_ge084_processando)
	w_ge084_processando.mle_1.Text = 'IMPRIMINDO COMPROVANTE TEF'
	w_ge084_processando.st_msg.text = This.msg_operador	
	lvb_Retorno = TRUE
Else
	This.Iniciou_Erro = PDV.ivb_Iniciou_Erro
	MessageBox("TEF","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir cupom fiscal n$$HEX1$$e300$$ENDHEX$$o-vinculado, para impress$$HEX1$$e300$$ENDHEX$$o do comprovante TEF.",StopSign!)
END IF

Return lvb_Retorno
end function

public function boolean of_transacao_administrativa (datetime adata, string aoperador, long aecf, string acaixa, long acontrole_caixa);
Boolean  lb_Sucesso

Long     ll_ecf 
Long     ll_cupomfiscal

String   ls_funcao    = "OF" 														// Transacao Administrativa
String   ls_restricao = "[3556]"

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
This.cd_funcao    		= 110
This.nr_cupom     		= ll_CupomFiscal
This.nr_ecf       		= aecf
This.dt_transacao 		= gf_getserverdate()
This.vl_transacao 		= 000.00
This.de_operador  		= aoperador
This.de_restricao 		= ls_restricao
This.cd_caixa          	= acaixa
This.nr_controle_caixa 	= acontrole_caixa

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
	
	If lb_Sucesso Then
		Gerencial = True		
		lb_Sucesso = This.of_Finaliza_Transacao(This.ib_NFCE, This.nr_nf)
	End If
		
End If

Return lb_Sucesso
end function

public function boolean of_continua_impressao_comprovante_new ();String  ls_Resposta

Boolean lb_Retorno

Open(w_ge084_erro_impressao_comprovante)

ls_Resposta = Message.StringParm

If ls_Resposta = "1" Then
	lb_Retorno = True
Else
	lb_Retorno = False
End If

Return lb_Retorno
end function

public function boolean of_lanca_comprovante_caixa ();Boolean  lb_Sucesso  = True

String   ls_nsu
String   ls_nsu_sitef
String   ls_bandeira
String   ls_cod_bandeira
String   ls_cartao
String   ls_estabelecimento
String   ls_caixa
String   ls_especie
String   ls_serie
String   ls_autorizadora
String   ls_Captura = "T"
String   ls_pgto
String   ls_psp_cd
String   ls_aut_cd
String   ls_uso_cd
String	   ls_cartao_produto
String	   ls_caixa_geral
String	   ls_caixa_saque
String	   ls_autorizacao_tef

Long     ll_Funcao
Long     ll_Funcao_Original
Long     ll_Transacao
Long     ll_parcelas
Long     ll_controle_caixa
Long     ll_filial
Long     ll_doc
Long     ll_registro
Long     ll_ecf
Long     ll_cupom
Long	   ll_Achou
Long	   ll_controle_geral
Long	   ll_seq_caixa
	
Datetime ldt_data_transacao
DateTime ldt_data
DateTime	ldt_predatado

Decimal  ldc_valor
Decimal  ldc_saque
Decimal  ldc_transacao

Long     ll_sequencial
Long     ll_row


//Fun$$HEX2$$e700e300$$ENDHEX$$o de consulta saldo Cart$$HEX1$$e300$$ENDHEX$$o Presente (Gift)
//N$$HEX1$$e300$$ENDHEX$$o grava comprovante
//Passa na fun$$HEX2$$e700e300$$ENDHEX$$o apenas p/ imprimir o comprovante do saldo para o cliente
//Fun$$HEX2$$e700e300$$ENDHEX$$o 15 $$HEX1$$e900$$ENDHEX$$ a da venda tamb$$HEX1$$e900$$ENDHEX$$m n$$HEX1$$e300$$ENDHEX$$o grava comprovante
If This.cd_funcao = 152 Or  This.cd_funcao = 15 Then
	Return True
End If

dc_uo_ds_base lds_2
lds_2 = Create dc_uo_ds_base

If Not lds_2.of_ChangeDataObject('ds_ge084_transacao_tef') Then
	Destroy(lds_2)
	Return False
End If

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas com cupom fiscal impresso que precisam ser confirmadas
lds_2.of_AppendWhere("cd_forma_pagamento in ('01','02','03') and nr_ecf = " + String(This.nr_ecf) + " and nr_coo_ecf = " + String(This.nr_cupom) )

lds_2.Retrieve()

If lds_2.RowCount() = 0 Then
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_lanca_comprovante_caixa - Sem comprovante a ser gravado ECF [" + String(PDV.ecf,'000') + "] Cupom [" + String(This.nr_cupom,'00000000')+"]")
	
	Choose Case This.cd_funcao
		Case 300,301 
			// Rafael Machado - Star-IT - INI - Chamado 436707 - 15/Jan/2019		
			If Not of_lanca_recarga_celular_filial() then
				Sqlca.of_RollBack()
				of_cancela_transacao(ib_nfce, nr_nf, True)
				lb_Sucesso = False
			else
				ll_Registro ++
			end if
		Case 261,264,265,269,275,276
			If Not of_lanca_venda_giftcard() then
				Sqlca.of_RollBack()
				of_cancela_transacao(ib_nfce, nr_nf, True)
				lb_Sucesso = False
			else
				ll_Registro ++
			end if			
		Case else
			Return True
	End Choose
Else
	//Para lan$$HEX1$$e700$$ENDHEX$$ar Recarga ou Venda Gift no caixa, quando pagamento em cartao ou PIX
	If (Not IsNull(This.cd_funcao_principal) And This.cd_funcao_principal > 0) Then
		ll_funcao_original = This.cd_funcao_principal
	Else
		ll_funcao_original = This.cd_funcao
	End If	
End If

For ll_Row = 1 To lds_2.RowCount()
	 
	ls_autorizadora    = lds_2.object.cd_autorizadora   [ll_Row] 
	
	If ls_autorizadora = This.EdmCard.cd_Rede Then Continue

	ll_funcao          = lds_2.object.cd_funcao         [ll_Row]
	ll_ecf             = lds_2.object.nr_ecf            [ll_Row]
	ll_cupom           = lds_2.object.nr_coo_ecf 		  [ll_Row]
	ll_transacao       = lds_2.object.nr_transacao		  [ll_Row]
	ls_nsu             = lds_2.object.nr_nsu_host       [ll_Row]
	ls_bandeira        = lds_2.object.de_bandeira       [ll_Row]
	ldt_data_transacao = lds_2.object.dt_transacao      [ll_Row]
	ll_parcelas        = lds_2.object.qt_parcelas       [ll_Row]
	ldc_valor          = lds_2.object.vl_transacao      [ll_Row]
	ldc_saque          = lds_2.object.vl_saque          [ll_Row]
	ls_cartao          = lds_2.object.nr_cartao         [ll_Row]
	ls_estabelecimento = lds_2.object.cd_estabelecimento[ll_Row]
	ls_caixa           = lds_2.object.cd_caixa          [ll_Row]
	ll_controle_caixa  = lds_2.object.nr_controle_caixa [ll_Row]
	ldt_predatado		 = lds_2.object.dt_predatado		  [ll_Row]
	ls_cod_bandeira = lds_2.object.cd_bandeira       [ll_Row]
	ls_pgto			 = lds_2.object.cd_forma_pagamento       [ll_Row]
	ls_psp_cd		 = lds_2.object.cd_psp_recebedor       [ll_Row]	
	ls_aut_cd		 = LeftA(lds_2.object.cd_autorizacao_cd       [ll_Row],50)
	ls_uso_cd		 = lds_2.object.id_tipo_uso_cd       [ll_Row]
	ls_autorizacao_tef = lds_2.object.nr_autorizacao   [ll_Row] 
	
	//Fun$$HEX2$$e700e300$$ENDHEX$$o de consulta saldo Cart$$HEX1$$e300$$ENDHEX$$o Presente (Gift)
	//N$$HEX1$$e300$$ENDHEX$$o grava comprovante
	//Passa na fun$$HEX2$$e700e300$$ENDHEX$$o apenas p/ imprimir o comprovante do saldo para o cliente
	//Fun$$HEX2$$e700e300$$ENDHEX$$o 15 $$HEX1$$e900$$ENDHEX$$ a da venda tamb$$HEX1$$e900$$ENDHEX$$m n$$HEX1$$e300$$ENDHEX$$o grava comprovante
	If ll_funcao = 152 Or  ll_funcao = 15 Then
		Continue
	End If	
	
	SetNull(ll_filial)
	SetNull(ll_doc)
	SetNull(ls_especie)
	SetNull(ls_serie)
	
	ls_cartao = LeftA(ls_cartao,6)
	ls_autorizacao_tef = LeftA(ls_autorizacao_tef,6)
	//carteira digital n$$HEX1$$e300$$ENDHEX$$o retorna valor nesse campo usa o do nsu
	If IsNull(ls_autorizacao_tef) Then ls_autorizacao_tef = LeftA( String( LongLong( ls_nsu ) ), 6 )
	
	//If ls_autorizadora = '00010' Then
//	If Upper(Trim(ls_bandeira)) = 'TNEXX' Then
//		ls_nsu_sitef = lds_2.object.nr_nsu_sitef[ll_Row]
//	Else
		ls_nsu_sitef = ls_nsu
//	End If
		
	SetNull(ll_Sequencial)
	
	If ll_funcao = 124 Then //busca caixa e controle do geral para fazer o lan$$HEX1$$e700$$ENDHEX$$amento.	
		ls_caixa_saque = ls_caixa
		If Not gvo_controle_caixa.of_caixa_geral_movimento(gvo_parametro.cd_filial, Ref ls_caixa_geral, Ref ll_controle_geral) Then
			Return False
		Else
			ls_caixa = ls_caixa_geral
			ll_controle_caixa = ll_controle_geral
		End If
	End If
	
	If This.of_Inclui_Cartao_Comprovante_Venda(ls_caixa, ll_controle_caixa, ll_ecf, ll_Cupom) Then
			
		If This.of_Sequencial_Comprovante_Caixa(ls_caixa, ll_controle_caixa, Ref ll_sequencial) Then

			If This.ib_NFCE And This.nr_nf >= 0 Then				
				If Not This.of_Localiza_NFCe(ll_funcao_original, ldt_data_transacao, ll_ecf, This.nr_nf, Ref ll_filial, Ref ll_doc, Ref ls_especie, Ref ls_serie ) Then
					Return False
				End If
			Else			
				If Not This.of_Localiza_Cupom_Fiscal(ll_funcao_original, ldt_data_transacao, ll_ecf, Ref ll_cupom, Ref ll_filial, Ref ll_doc, Ref ls_especie, Ref ls_serie ) Then
					Return False
				End If
			End If

			If (ll_funcao_original <> 300 And ll_funcao_original <> 301 And ll_funcao_original <> 124 &
			    And ll_funcao_original <> 261 And ll_funcao_original <> 264 And ll_funcao_original <> 265 And ll_funcao_original <> 269 And ll_funcao_original <> 275 And ll_funcao_original <> 276) &
			   And This.Retaguarda = False Then
				If (IsNull(ll_Doc) Or ll_Doc = 0) And (IsNull(ls_Especie) Or ls_Especie = "") And (IsNull(ls_Serie) Or ls_Serie = "") Then
					ls_Bandeira = ls_Bandeira + " (S/NF)"
					ls_Captura = "E"
				End If
			End If
			
			ldc_transacao      = ldc_valor + ldc_saque
		
			ls_estabelecimento = MidA(ls_estabelecimento,2,10)
			
			ls_nsu		= LeftA( String( LongLong( ls_nsu ) ), 6 )
			ls_nsu_sitef	= String( LongLong( ls_nsu_sitef) )
			
			//Acerto para conciliacao HIPERCARD, depois que trocou a administradora somente o nsu_sitef
			//$$HEX1$$e900$$ENDHEX$$ a informacao que pode ser usada para encontrar os registros no arquivo que eles enviam.
			//If Upper(Trim(ls_bandeira)) = 'HIPERCARD' Then
			If Long(ls_cod_bandeira) = 12 Then
				ls_nsu = lds_2.object.nr_nsu_sitef[ll_Row]
				ls_nsu =  LeftA( String( Long( ls_nsu ) ), 6 )
			End If				
			
//			This.of_valida_bandeira_produto(Ref ls_bandeira)

			This.of_retorna_cartao_produto(ls_Autorizadora, ls_cod_bandeira, Upper(Trim(ls_bandeira)),Ref ls_cartao_produto)
			
			//CARTEIRA DIGITAL
			If ll_funcao = 122 Then
				Choose Case Trim(ls_cod_bandeira)
					Case '60110024'
						ls_bandeira = 'CARTEIRA DIGITAL PIX'
					Case '00600012'
						ls_bandeira = 'CARTEIRA DIGITAL PICPAY'						
					Case '00290006'
						If ls_uso_cd = 'D' Then
							ls_bandeira = 'CARTEIRA DIGITAL PIX'
						Else
							ls_bandeira = 'CARTEIRA MERCADO PAGO'
						End If
					Case '00650013'
						ls_bandeira = 'CARTEIRA DIGITAL PAGSEGURO'
					Case '00760023'
						ls_bandeira = 'CARTEIRA DIGITAL AME'
					Case Else
						ls_bandeira = 'CARTEIRA DIGITAL N$$HEX1$$c300$$ENDHEX$$O CADASTRADA'
				End Choose
				ls_cartao_produto = ls_bandeira
			End If
			If ll_funcao = 124 Then //PIX SAQUE
				ls_cartao_produto = 'SAQUE PIX'
			End If
	
			// Rafael Machado - Star-IT - INI - Chamado 436707 - 15/Jan/2019
			If ll_funcao_original = 300 Or ll_funcao_original = 301 then
				If Not of_lanca_recarga_celular_filial() then
					Sqlca.of_RollBack()
					of_cancela_transacao(ib_nfce, nr_nf, True)
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento Recarga Celular Filial : " + cd_caixa + " controle : " + String(nr_controle_caixa) )
					lb_Sucesso = False
				End If
			End if
			// Lan$$HEX1$$e700$$ENDHEX$$amento venda_cartao_gift
			If ll_funcao_original = 261 Or ll_funcao_original = 264 Or ll_funcao_original = 265 Or ll_funcao_original = 269 Or ll_funcao_original = 275 Or ll_funcao_original = 276  Then
				//This.cd_forma_pagamento = ls_pgto
				If Not of_lanca_venda_giftcard() then
					Sqlca.of_RollBack()
					of_cancela_transacao(ib_nfce, nr_nf, True)
					lb_Sucesso = False
				End If
			End If
	
			Select Count(*)
				Into :ll_Achou
			From cartao_comprovante_venda
			Where cd_filial = :ll_filial
				And cd_caixa = :ls_caixa
				And nr_controle_caixa = :ll_controle_caixa
				And nr_nsu = :ls_nsu_sitef
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Consulta Lan$$HEX1$$e700$$ENDHEX$$amento do Comprovante Caixa")
				Sqlca.of_MsgDbError('Consulta do comprovante do cart$$HEX1$$e300$$ENDHEX$$o.')
				lb_Sucesso = False
			End If
	
			If ll_Achou > 0 Then
				gvo_Aplicacao.of_Grava_Log("uo_sitef - of_lanca_comprovante_caixa - Comprovante em duplicidade, n$$HEX1$$e300$$ENDHEX$$o foi gravado novamente. ECF [" + String(ll_ecf) + "], COO [" + String(ll_cupom) + "], SEQ [" + String(ll_sequencial) + "], NSU [" + ls_nsu + "]")
				ll_Registro ++				
			Else
				
				Insert Into cartao_comprovante_venda
					( cd_caixa,
					  nr_controle_caixa,
					  cd_filial,
					  nr_nf,
					  de_especie,
					  de_serie,
					  nr_sequencial,
					  nm_produto,
					  nr_cartao,
					  nr_autorizacao,
					  nr_nsu,
					  dh_venda,
					  vl_venda,
					  vl_saque,
					  qt_parcelas,
					  id_captura,
					  id_cancelamento,
					  cd_estabelecimento,
					  id_parcelamento,
					  nr_ecf,
					  nr_coo_ecf,
					  id_pre_venda,
					  dh_predatado,
					  cd_psp_recebedor,
					  cd_autorizacao_cd,
					  id_tipo_uso_cd)
				Values(:ls_caixa,
						 :ll_controle_caixa,
						 :ll_filial,
						 :ll_doc,
						 :ls_especie,
						 :ls_serie,   
						 :ll_sequencial,
						 :ls_cartao_produto,
						 :ls_cartao,
						 :ls_autorizacao_tef,
						 :ls_nsu_sitef,
						 :ldt_data_transacao,
						 :ldc_transacao,
						 :ldc_saque,
						 :ll_parcelas,
						 :ls_Captura,
						 'N',
						 :ls_estabelecimento,
						 'L',
						 :ll_ecf,
						 :ll_cupom,
						 'N',
						 :ldt_predatado,
						 :ls_psp_cd,
						 :ls_aut_cd,
						 :ls_uso_cd)
				Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Lan$$HEX1$$e700$$ENDHEX$$amento do Comprovante Caixa")
					Sqlca.of_MsgDbError('Grava$$HEX2$$e700e300$$ENDHEX$$o do comprovante do cart$$HEX1$$e300$$ENDHEX$$o.')
					lb_Sucesso = False
					Exit
				Else
					gvo_Aplicacao.of_Grava_Log("uo_sitef - of_lanca_comprovante_caixa - Comprovante Caixa Gravado. ECF [" + String(ll_ecf) + "], COO [" + String(ll_cupom) + "], SEQ [" + String(ll_sequencial) + "], NSU [" + ls_nsu + "]")
					ll_Registro ++		
				End If
			End If
		End If		
	End If	
	
	// Rafael Machado - Star-IT - INI - Chamado 436707 - 15/Jan/2019
	If ll_funcao_original = 300 Or ll_funcao_original = 301 then
		//Atualiza sequencial da recarga_celular_filial com sequencial gerado no cartao_comprovante_venda
		Update recarga_celular_filial
			set nr_sequencial_cartao = :ll_sequencial
		 where nr_nsu = :nr_nsu_gift_recarga
		 and dh_movimentacao = :This.dt_transacao
		 Using Sqlca;
		
		if sqlca.sqlcode = -1 then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Recarga Celular Filial")
			Sqlca.of_MsgDbError('Grava$$HEX2$$e700e300$$ENDHEX$$o recarga celular.')		
			lb_Sucesso = False
		end if
	End if
	// Rafael Machado - Star-IT - FIM - Chamado 436707	
	
	If ll_funcao_original = 261 Or ll_funcao_original = 264 Or ll_funcao_original = 265 Or ll_funcao_original = 269 Or ll_funcao_original = 275 Or ll_funcao_original = 276 Then
		//Atualiza sequencial da venda_cartao_gift com sequencial gerado no cartao_comprovante_venda
		Update venda_cartao_gift
			set nr_sequencial_cartao_pagto = :ll_sequencial
		 where nr_nsu = :nr_nsu_gift_recarga
		 and dh_movimentacao = :This.dt_transacao
		 Using Sqlca;
		
		if sqlca.sqlcode = -1 then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Venda Giftcard Filial")
			Sqlca.of_MsgDbError('Atualiza$$HEX2$$e700e300$$ENDHEX$$o venda GiftCard.')		
			lb_Sucesso = False
		end if
	End if
	
	//Lan$$HEX1$$e700$$ENDHEX$$amento SAQUE PIX
	If ll_funcao_original = 124 Then
		Select nr_lancamento_caixa
			Into :ll_seq_caixa
		From cartao_comprovante_venda
		Where cd_caixa = :ls_caixa
			And nr_controle_caixa = :ll_controle_caixa
			And nr_sequencial = :ll_sequencial
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Consulta Seq Caixa Lan$$HEX1$$e700$$ENDHEX$$amento do Comprovante Caixa")
			Sqlca.of_MsgDbError('Consulta do Seq caixa comprovante do cart$$HEX1$$e300$$ENDHEX$$o.')
			lb_Sucesso = False
		Else
			If Not of_lanca_movimento_pix('S', ls_caixa, ll_controle_caixa, 	ls_caixa_saque, ll_sequencial, ll_seq_caixa ) then
				Sqlca.of_RollBack()
				of_cancela_transacao(ib_nfce, nr_nf, True)
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento Saque PIX : " + cd_caixa + " controle : " + String(nr_controle_caixa) )
				lb_Sucesso = False
			End If
		End If
	End if
	
Next

Destroy(lds_2)
GarbageCollect()

If lb_Sucesso Then
	If ll_Registro > 0 Then
		Sqlca.of_Commit()
	End If
Else
	Sqlca.of_RollBack()
End If	

Return lb_Sucesso
end function

public function boolean of_busca_bandeira (string ps_tipo_cartao, long pl_codigo, long pl_administradora, ref string ps_nome_bandeira);String ls_Tipo
String ls_Parametro_Mail

If ps_Tipo_Cartao = '01' Then
	ls_Tipo = 'D'
Else
	ls_Tipo = 'C'
End If

uo_transacao_remota lo_SD
lo_SD = Create uo_transacao_remota

If ls_Tipo = 'C' Then
	Select nm_produto Into :ps_nome_bandeira
	From cartao_produto
	Where cd_tipo_credito = :pl_codigo
	 And	cd_administradora_tef = :pl_administradora
	Using Sqlca;
	
	Choose Case Sqlca.Sqlcode 
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar bandeira do cart$$HEX1$$e300$$ENDHEX$$o.",StopSign!)
		Case 100
			//Nao encontrou o produto cadastrado, vai usar o GENERICO da Administradora
			Select nm_produto Into :ps_nome_bandeira
			From cartao_produto
			Where cd_tipo_credito = 0
			 And	cd_administradora_tef = :pl_administradora
			Using Sqlca;
			
			Choose Case Sqlca.Sqlcode 
				Case -1
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar bandeira do cart$$HEX1$$e300$$ENDHEX$$o.",StopSign!)
				Case 100
					//Nao encontrou o generico da Administradora vai gravar os codigos para nao perder a venda.					
					ps_nome_bandeira = "Adm.:" + String(pl_administradora) + " Tipo:" + ls_Tipo + ' - ' + String(pl_codigo) 
					
					ls_Parametro_Mail = 'filial=' + string( gvo_parametro.cd_filial ) + '&adm= ' + ps_nome_bandeira					
					lo_SD.of_Executa_Rotina_Intranet( 'email_cartao_inexistente', ls_Parametro_Mail )
					Destroy lo_SD
					
					Return True			
				Case 0
					Return True
			End Choose
			
		Case 0
			Return True		
					
	End Choose
Else
	Select nm_produto Into :ps_nome_bandeira
	From cartao_produto
	Where cd_tipo_debito = :pl_codigo
	 And	cd_administradora_tef = :pl_administradora
	Using Sqlca;
	
	Choose Case Sqlca.Sqlcode 
		Case -1
			SqlCa.of_MsgDbError( "Erro ao localizar bandeira do cart$$HEX1$$e300$$ENDHEX$$o." )
		Case 100
			//Nao encontrou o produto cadastrado, vai usar o GENERICO da Administradora
			Select nm_produto Into :ps_nome_bandeira
			From cartao_produto
			Where cd_tipo_debito = 0
			 And	cd_administradora_tef = :pl_administradora
			Using Sqlca;
			
			Choose Case Sqlca.Sqlcode 
				Case -1
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar bandeira do cart$$HEX1$$e300$$ENDHEX$$o.",StopSign!)
				Case 100
					//Nao encontrou o generico da Administradora vai gravar os codigos para nao perder a venda.
					ps_nome_bandeira = "Adm.:" + String(pl_administradora) + " Tipo:" + ls_Tipo + ' - ' + String(pl_codigo) 
					
					ls_Parametro_Mail = 'filial=' + string( gvo_parametro.cd_filial ) + '&adm= ' + ps_nome_bandeira					
					lo_SD.of_Executa_Rotina_Intranet( 'email_cartao_inexistente', ls_Parametro_Mail )
					Destroy lo_SD
					
					Return True			
				Case 0
					Return True
			End Choose
		Case 0
			Return True		
					
	End Choose
End If

Return False
end function

public function boolean of_inicializa ();
Impressao = False
CompraSaque = False
Gerencial = False
Comprovante_Nao_Fiscal = True
Retaguarda = False
ConsultaBin = False
Iniciou_Erro = False
SolicitacaoSenha = False
Pendente = False
id_transacao_interrompida = False
id_venda_pin = False
id_pgto_carteira_digital = False

SetNull(is_Tipo_Venda)

SetNull(cd_Rede)
SetNull(id_Status)
SetNull(cd_funcao)
SetNull(cd_funcao_principal)
SetNull(msg_cliente)
SetNull(msg_operador)
SetNull(cd_forma_pagamento)
SetNull(cd_forma_pagamento_original)
SetNull(cd_funcao_pgto)
SetNull(cd_modalidade)
SetNull(de_modalidade)
SetNull(dt_transacao)
SetNull(cd_autorizadora)
SetNull(cd_autorizadora_recarga)
SetNull(cd_bandeira)
SetNull(de_bandeira)
SetNull(nr_nsu_sitef)
SetNull(nr_nsu_host)
SetNull(nr_nsu_gift_recarga)
SetNull(nr_autorizacao)
SetNull(nr_cartao)
SetNull(nr_cartao_gift)
SetNull(nr_bin_cartao)
SetNull(de_via_cliente)
SetNull(de_via_caixa)
SetNull(dt_transacao)
SetNull(de_operadora)
SetNull(nr_celular)
SetNull(cd_estabelecimento)
SetNull(de_bandeira_gen)
Setnull(nr_cpf_cgc)
Setnull(de_senha_capturada)
Setnull(nr_identificador_pgto)
Setnull(nr_nsu_fepas)
Setnull(de_produto_gift)
Setnull(cd_ean_gift)
Setnull(cd_autorizacao_carteira)
Setnull(cd_instituicao_financeira)
Setnull(cd_tipo_uso_cd)
Setnull(de_vendedor)
Setnull(de_dado_captura_pinpad)
Setnull(cd_tipo_cpatura_pinpad)
Setnull(de_tam_mim_captura)
Setnull(de_tam_max_captura)

SetNull(dt_predatado)

SetNull(nr_vidalink_autorizacao)
SetNull(nr_vidalink_cnpj)
SetNull(de_vidalink_plano)
SetNull(de_cancelamento)

SetNull(nr_cupom)
SetNull(nr_nsu_sitef)
SetNull(nr_nsu_host)
SetNull(nr_cupom)

SetNull(nr_cartao_disque)
SetNull(dh_validade_cartao_disque)
SetNull(cd_seguranca_cartao_disque)
SetNull(de_texto_nao_fiscal)

//Dados Leitura Cart$$HEX1$$f500$$ENDHEX$$es
id_Cartao_Digitado = False
SetNull(de_Cartao_Digitado)
SetNull(de_Cartao_Trilha1)
SetNull(de_Cartao_Trilha2)

vl_transacao 		 = 000.00
vl_total_transacao = 000.00
vl_total_pbm		 = 000.00
vl_saque     		 = 000.00
qt_parcelas  		 = 0
nr_parcelas_maximo = 0
vl_parcela_minima  = 000.00
qt_Produtos = 0
qt_Enviados = 0
qt_parcelas_gen = 0
nr_nf = 0

nr_vidalink_produtos = 000

//CardSE
vl_aprovado_carteira		= 000.00
vl_desconto_carteira		= 000.00
SetNull(cd_carteira_digital_tef)
SetNull(nm_carteira_ditital)
SetNull(qr_code_estabelecimento)

//Objetos de Controles PBM
This.TrnCentre.of_Inicializa()
This.Vidalink.of_Inicializa()
This.ePharma.of_Inicializa()
This.EdmCard.of_Inicializa()
This.PharmaSystem.of_Inicializa()
This.Funcional.of_Inicializa()

If Not This.of_Habilita_Compra_Saque() Then Return False

Return True
end function

public function boolean of_transacao_pagamento (string atransacao, decimal avalor, long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
String  ls_funcao[] 														            // Transacao pagamento
	
String  ls_restricao = ""

Boolean lb_Sucesso = False

ls_funcao[1] = "PC"
ls_funcao[2] = "RPC"

If Not This.of_Restricao_Funcao(ls_funcao[],Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

//Incluido na restricao da funcao para em cartoes goodcard credito N$$HEX1$$c300$$ENDHEX$$O pedir informacoes de receita/CRM/UF
//ls_restricao += ";{InibePBM=1}"

Choose Case atransacao
	Case "CA" // D$$HEX1$$e900$$ENDHEX$$bito
		This.cd_funcao = 2
	Case "CP" // Cr$$HEX1$$e900$$ENDHEX$$dito
		This.cd_funcao = 3
	Case "CD" // Carteira Digital
		This.cd_funcao = 122
	Case "GC" // Cartao presente Gift Card
		This.cd_funcao = 15
	Case Else
		This.cd_funcao = 000000
End choose

This.nr_ecf            = aecf
If Not This.ib_NFCE Then
	This.nr_cupom          = acupomfiscal
Else
	If IsNull(This.nr_cupom) Or This.nr_cupom = 0 Then
		This.nr_cupom          = acupomfiscal		
	End If
End If
This.dt_transacao      = gf_getserverdate()
This.vl_transacao      = avalor
This.vl_total_transacao +=	avalor
This.de_operador       = aoperador
This.de_restricao      = ls_restricao
This.cd_caixa          = acaixa
This.nr_controle_caixa = acontrole_caixa

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
Else
	This.vl_total_transacao -=	avalor
End If 

Return lb_Sucesso
end function

public function string of_mensagem_produto ();String ls_Retorno

Decimal {2} ldc_Preco_Bruto
Decimal {2} ldc_Preco_Liquido

This.qt_Enviados ++

ldc_Preco_Liquido = This.ds_autorizacao.object.vl_preco_liquido [This.qt_Enviados]

//Esse layout de envio de produtos $$HEX1$$e900$$ENDHEX$$ para a GOODCARD
//Se precisarmos enviar em outro layout, tentar tratar por bandeira, This.cd_bandeira
//A goodcard tem era para ser 10015 mas esta vindo com cod. 50000

// Descricao; codigo_barras; qtd; valor unit.; qtd prescrita; prescrito na receita

ls_Retorno = This.ds_autorizacao.object.nm_produto[This.qt_Enviados] + ";" + &				 
				 This.ds_autorizacao.object.de_codigo_barras[This.qt_Enviados] + ";" + &
				 String(This.ds_autorizacao.object.qt_vendida[This.qt_Enviados],'000') + ";" + &
				 LeftA(String(ldc_Preco_Liquido,'####0.00'),LenA(String(ldc_Preco_Liquido,'####0.00'))-3) + RightA(String(ldc_Preco_Liquido,'####0.00'),2) + ";" + &
				 String(This.ds_autorizacao.object.qt_prescrita[This.qt_Enviados],'000') + ";" + &				 
				 This.ds_autorizacao.object.id_registro_prescritor[This.qt_Enviados]
				 
Return ls_Retorno
end function

public function boolean of_continua_impressao_comprovante ();String  ls_Resposta

Boolean lb_Retorno

Open(w_ge084_erro_impressao_comprovante)

ls_Resposta = Message.StringParm

If ls_Resposta = "1" Then
	MessageBox("Impressora Fiscal","Verifique se a impressora est$$HEX1$$e100$$ENDHEX$$ pronta para reimprimir e tecle <ENTER>.",Exclamation!)
	lb_Retorno = True
Else
	lb_Retorno = False
End If

Return lb_Retorno

end function

public function boolean of_dados_produtos_venda (long pl_produto, long pl_grupo_produto, string ps_descricao, string ps_barras, long pl_quantidade, decimal pdc_preco_praticado, decimal pdc_desconto, decimal pdc_desconto_padrao, string ps_prescrito);Long ll_Row
Long ll_Find

Long ll_Quantidade

Decimal {2} ldc_Preco

String ls_nome_produto

If IsNull(pl_Produto) or pl_Produto = 0 Then Return True

ll_Row = This.ds_autorizacao.InsertRow(0)

ldc_Preco = pdc_preco_praticado
ls_nome_produto = MidA(ps_descricao,1,40)

This.ds_autorizacao.object.cd_produto 				[ll_Row] = pl_produto
This.ds_autorizacao.object.cd_grupo_produto		[ll_Row] = pl_grupo_produto
This.ds_autorizacao.object.nm_produto 				[ll_Row] = ls_nome_produto
This.ds_autorizacao.object.de_codigo_barras		[ll_Row] = ps_barras
This.ds_autorizacao.object.qt_vendida		 		[ll_Row] = pl_quantidade
This.ds_autorizacao.object.vl_preco_bruto	 		[ll_Row] = pdc_preco_praticado
This.ds_autorizacao.object.vl_preco_liquido  	[ll_Row] = ldc_Preco
This.ds_autorizacao.object.vl_preco_farmacia 	[ll_Row] = ldc_Preco
This.ds_autorizacao.object.pc_desconto    		[ll_Row] = pdc_desconto
This.ds_autorizacao.object.pc_desconto_padrao	[ll_Row] = pdc_desconto_padrao	
This.ds_autorizacao.object.id_registro_prescritor[ll_Row] = ps_prescrito

If ps_prescrito = 'S' Then	This.ds_autorizacao.object.qt_prescrita[ll_Row] = pl_quantidade 			

Return True
end function

public function boolean of_impressao_comprovante ();
String  ls_Linha,&
        ls_Comprovante,&
        ls_Resposta
	
Long    	ll_Row	
Long    	ll_Byte
Long    	ll_Via
Long 		ll_funcao

Boolean lb_Impressao ,&
		  lb_Abertura  ,&
        	lb_Tentar,&
		lb_Pergunta, &
		lb_sem_via_caixa
		
If Not IsNull(This.cd_funcao_principal) And This.cd_funcao_principal > 0 Then
	ll_funcao = This.cd_funcao_principal
Else
	ll_funcao = This.cd_funcao
End If

dc_uo_ds_base lds_comprovante
lds_comprovante = Create dc_uo_ds_base

If Not lds_comprovante.of_ChangeDataObject('ds_ge084_transacao_tef') Then Return False

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas com cupom fiscal impresso que precisam ser confirmadas
lds_comprovante.of_RestoreSqlOriginal()
lds_comprovante.of_AppendWhere("id_situacao <> 'C' and nr_ecf = " + String(This.nr_ecf) + " and nr_coo_ecf = " + String(This.nr_cupom) + " and (cd_forma_pagamento in ('01', '02', '03', '15') Or cd_funcao in (300,301,110,122,261,264,265,269,275,276,124,213))")

lds_comprovante.Retrieve()

Reinicia_impressao:
ll_Row = 0

For ll_Row = 1 To lds_comprovante.RowCount()
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_impressao_comprovante - Inicio processo de impress$$HEX1$$e300$$ENDHEX$$o TEF.")
	ls_comprovante = ''
	lb_sem_via_caixa = False

	//For ll_Row = 1 To lds_comprovante.RowCount()
		
		If Not IsNull(lds_comprovante.object.de_via_cliente[ll_Row]) Then
			ls_Comprovante += lds_comprovante.object.de_via_cliente[ll_Row]
		End If
		
	//Next
				  
	lb_Impressao = True
	
	If IsNull(ls_Comprovante) Then ls_Comprovante = ""
	
	//For ll_Row = 1 To lds_comprovante.RowCount()
	
		If Not IsNull(lds_comprovante.object.de_via_caixa[ll_Row]) Then
			
			If ls_Comprovante <> "" Then
				ls_Comprovante += CharA(10) + "											"
				If IsNull(PDV.ivs_Tipo_Venda) Or PDV.ivs_Tipo_Venda <> "TR" Then								
					ls_Comprovante += CharA(10) + " - - - - - - - - - - - - - - recorte - - 8< - -"
				End If 
				ls_Comprovante += CharA(10) + "                                 " + CharA(10)
			End If	
		
			ls_Comprovante += lds_comprovante.object.de_via_caixa[ll_Row]
			
			ls_Comprovante += CharA(10) + "											"
			ls_Comprovante += CharA(10) + "                                 " + CharA(10)
		Else
			lb_sem_via_caixa	= true				
		End If
		
	//Next	
	
	If IsNull(ls_Comprovante) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Comprovante n$$HEX1$$e300$$ENDHEX$$o foi retornado para impress$$HEX1$$e300$$ENDHEX$$o.",Exclamation!)
		Return False
	End If
	
	This.vl_Transacao 			= lds_comprovante.object.vl_transacao				[ll_Row]
	This.cd_forma_pagamento 	= lds_comprovante.object.cd_forma_pagamento	[ll_Row]
	This.cd_funcao 				= lds_comprovante.object.cd_funcao					[ll_Row]
	
	//Voucher GoodCard - Muda para credito
	If This.cd_forma_pagamento = '03' Then 
		This.cd_forma_pagamento_original = This.cd_forma_pagamento
		This.cd_forma_pagamento = '02'		
	End If
	If lds_comprovante.object.cd_funcao	[ll_Row] = 122 Then //Carteira Digital - considera como debito
		This.cd_forma_pagamento_original = This.cd_forma_pagamento	
		This.cd_forma_pagamento = '01'
	End If	
	
	lb_Impressao = True
	
	Do While True
		
		If IsValid(w_ge084_processando) Then CLOSE(w_ge084_processando)
		
		If Not Gerencial Then		
			IF NOT of_inicializa_comprovante_tef(lb_Tentar) THEN
				If (ll_funcao = 300 Or ll_funcao = 301 Or ll_funcao = 261 Or ll_funcao = 264 Or ll_funcao = 265 Or ll_funcao = 269 Or ll_funcao = 275 Or ll_funcao = 276 Or ll_funcao = 124 Or ll_Funcao = 15) &
					And Not Comprovante_Nao_Fiscal Then Return False				
			Tenta_Iniciar:	
				If This.Iniciou_Erro Then
					lb_Pergunta = False
				Else
					lb_Pergunta = True
				End If
				If Not of_pergunta_tentativa(lb_Pergunta,Gerencial) Then				
					If ll_funcao = 110 And PosA(Trim(Upper(This.de_cancelamento)), "CANCELAMENTO") > 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700e300$$ENDHEX$$o TEF efetuada. Favor re-imprimir $$HEX1$$fa00$$ENDHEX$$ltimo comprovante.",Exclamation!)
						Exit
					Else
						RETURN FALSE				
					End If
				Else
					If Not of_inicializa_comprovante_tef(lb_Tentar) Then Goto Tenta_Iniciar	
				End If
			END IF 
		Else
			//If ll_Row = 1 Then
				IF NOT of_inicializa_comprovante_tef(lb_Tentar) THEN
					If (ll_funcao = 300 Or ll_funcao = 301 Or ll_funcao = 261 Or ll_funcao = 264 Or ll_funcao = 265 Or ll_funcao = 269 Or ll_funcao = 275 Or ll_funcao = 276 Or ll_funcao = 124 Or ll_funcao = 213) & 
						And Not Comprovante_Nao_Fiscal Then Return False					
				Tenta_Iniciar2:			
					If Not of_pergunta_tentativa(true,Gerencial) Then				
						If ll_funcao = 110 And PosA(Trim(Upper(This.de_cancelamento)), "CANCELAMENTO") > 0 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700e300$$ENDHEX$$o TEF efetuada. Favor re-imprimir $$HEX1$$fa00$$ENDHEX$$ltimo comprovante.",Exclamation!)							
							Exit
						Else
							RETURN FALSE				
						End If
					Else
						If Not of_inicializa_comprovante_tef(lb_Tentar) Then Goto Tenta_Iniciar2	
					End If
				END IF 	
			//End If
		End If		
	 
		ll_Via = 1
	 
		Do While ll_Via <= This.nr_vias_comprovante_tef
			
			ls_Linha = ''
			 
			For ll_Byte = 1 TO LenA(ls_Comprovante)			
				
				If MidA(ls_Comprovante,ll_Byte,1) = CharA(10) Then
					If Not IsNull(ls_Linha) and Trim(ls_Linha) <> "" Then
						//Verificacao se $$HEX1$$e900$$ENDHEX$$ impressao em Relatorio gerencial ou comprovante tef.
						If Not Gerencial Then
							If Not PDV.of_texto_nao_fiscal_tef(ls_Linha) Then 
								If Not of_pergunta_tentativa(False,Gerencial) Then				
									If ll_funcao = 110 And PosA(Trim(Upper(This.de_cancelamento)), "CANCELAMENTO") > 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700e300$$ENDHEX$$o TEF efetuada. Favor re-imprimir $$HEX1$$fa00$$ENDHEX$$ltimo comprovante.",Exclamation!)
										Exit
									Else
										RETURN FALSE							
									End If
								Else
									Goto Reinicia_impressao
								End If
							End If
						Else
							If Not PDV.of_texto_relatorio_gerencial(ls_Linha) Then 
								If Not of_pergunta_tentativa(False,Gerencial) Then				
									If ll_funcao = 110 And PosA(Trim(Upper(This.de_cancelamento)), "CANCELAMENTO") > 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700e300$$ENDHEX$$o TEF efetuada. Favor re-imprimir $$HEX1$$fa00$$ENDHEX$$ltimo comprovante.",Exclamation!)										
										Exit
									Else
										RETURN FALSE							
									End If					
								Else
									Goto Reinicia_impressao
								End If
							End If							
						End If
					End If
					ls_Linha = ''
					Continue
				End If				
				
				If Not lb_Impressao Then Exit
	
				ls_Linha += MidA(ls_Comprovante,ll_Byte,1)
				 
			Next
			
			ll_Via ++
			
			If Not lb_Impressao Then Exit
			
			If ll_Via <= This.nr_vias_comprovante_tef Then
			
				ls_Linha = "- - - - - - - - - - (" + String(ll_Via,'00') + " via) - - - - - - - - -"
				
				If Not Gerencial Then			
					If Not PDV.of_texto_nao_fiscal_tef(ls_Linha) Then lb_Impressao = False
				Else
					If Not PDV.of_texto_relatorio_gerencial(ls_Linha) Then lb_Impressao = False
				End If
								
				ls_Linha = ""
				
			End If
			 
		Loop
	 
		If Not lb_Impressao Then Continue	

		If Not Gerencial Then 
			If Not PDV.of_Fecha_Comprovante_Tef() Then
				Gerencial = True
				Goto Reinicia_impressao				
//				lb_Impressao = False
//				Continue
			End If
			//Se for recarga ou venda Gift, com pagamento diferente de dinheiro, o comprovante tef do pagamento $$HEX1$$e900$$ENDHEX$$ impresso num gerencial.
			If (ll_funcao = 300 Or ll_funcao = 301 Or ll_funcao = 261 Or ll_funcao = 264 Or ll_funcao = 265 Or ll_funcao = 269 Or ll_funcao = 275 Or ll_funcao = 276 Or ll_funcao = 124  Or ll_funcao = 213) &
				And lds_comprovante.RowCount() > 1 Then
				Gerencial = True
			End If
		Else
			If ll_Row = lds_comprovante.RowCount()  Then
				If Not PDV.of_Fecha_Relatorio_Gerencial(True) Then					
					lb_Impressao = False
					Continue
				End If
			ElseIf lb_sem_via_caixa  Then //GIFT PIN - s$$HEX1$$f300$$ENDHEX$$ tem a via do cliente.
				If Not PDV.of_Fecha_Relatorio_Gerencial(True) Then					
					lb_Impressao = False
					Continue
				End If				
			End If
		End If
		 
		Exit
		 
	Loop
Next 

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas de PBMs - Lucian 17/05/2011
lds_comprovante.of_RestoreSqlOriginal()
lds_comprovante.of_AppendWhere("id_situacao <> 'C' and nr_ecf = " + String(This.nr_ecf) + " and nr_coo_ecf = " + String(This.nr_cupom))// + " and cd_forma_pagamento is Null")

lds_comprovante.Retrieve()

If lds_comprovante.RowCount() > 0 Then
	lb_Impressao = TRUE
End If
 
If IsValid(w_ge084_processando) Then CLOSE(w_ge084_processando)

If lb_Impressao Then	of_Registra_Impressao_Comprovante()

//Cancelamento TRN New
If ls_Comprovante = "" Then
	If Not of_Impressao_Cancelamento_Pbm() Then
		lb_Impressao = False
	End If
End If

If lb_Impressao Then
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_impressao_comprovante - Final do processo de impress$$HEX1$$e300$$ENDHEX$$o TEF - Impress$$HEX1$$e300$$ENDHEX$$o OK.")
Else
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_impressao_comprovante - Final do processo de impress$$HEX1$$e300$$ENDHEX$$o TEF - Impress$$HEX1$$e300$$ENDHEX$$o ERRO.")	
End If
 
Return lb_Impressao
end function

public function boolean of_parcela_minima (string ps_bandeira);Boolean lb_Sucesso = False

String ls_Parametro

Long 		ll_Tabela

Decimal{2} ldc_Parcela_Minima

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

lb_Sucesso = lvo_Parametro.of_Localiza_Parametro("VL_PARCELA_MINIMA_TEF", ref ls_Parametro)
lb_Sucesso = lvo_Parametro.of_Localiza_Parametro("DT_INICIO_NOVO_PARCELAMENTO_TEF", ref is_nova_data_parcelamento, false)

//buscar a data do novo parcelamento

Destroy(lvo_Parametro)

If lb_Sucesso Then
	ldc_Parcela_Minima = Dec(ls_Parametro)
Else
	ldc_Parcela_Minima = 000.00
End If

//SetNull(ll_Tabela)
//
//Select count(*) Into :ll_Tabela
//From sys.systable
//Where table_name in ('bandeira_sitef','parametros_venda_tef')
//Using Sqlca;
//
//If Sqlca.Sqlcode = -1 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Verificando tabela bandeira_sitef")
//	Return False
//End If
//
//If ll_Tabela = 2 Then
	
	Select nr_parcelas,
	       vl_parcela_minima
   Into :This.nr_parcelas_maximo,
	     :This.vl_parcela_minima
	From parametros_venda_tef
	Where cd_bandeira = :ps_bandeira
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Verificando tabela bandeira_sitef")
		Return False
	End If
	
	If IsNull(This.nr_parcelas_maximo) Then This.nr_parcelas_maximo = 0
	
	If IsNull(This.vl_parcela_minima) Then This.vl_parcela_minima = 0
	
	If This.vl_parcela_minima = 000.00 Then
		This.vl_parcela_minima = ldc_Parcela_Minima
	End If
				
//Else

//	This.vl_parcela_minima = ldc_Parcela_Minima
	
//End If

Return lb_Sucesso
end function

public function boolean of_pergunta_tentativa (boolean pvb_abrindo, boolean pvb_gerencial);Boolean lb_Fechou_Comp
Long ll_doc

lb_Fechou_Comp = False

Do While lb_Fechou_Comp = False
	If of_continua_impressao_comprovante_new() Then
//	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Impressora n$$HEX1$$e300$$ENDHEX$$o responde. Deseja Tentar Novamente ?", Question!,YesNo!, 1) = 1 Then
		If pvb_Abrindo Then
			If PDV.of_retorna_doc_aberto(Ref ll_doc) Then
				Choose Case ll_doc
					Case 0
						lb_Fechou_Comp = True
						Gerencial = True
						Return True			
					Case 2
						If Not PDV.of_fecha_comprovante_tef_nao_finalizado() Then 					
							Continue			
						Else
							lb_Fechou_Comp = True
							Gerencial = True
							Return True			
						End If	
					Case 3
						If Not PDV.of_fecha_relatorio_gerencial(False) Then 
							Continue			
						Else
							lb_Fechou_Comp = True			
							Gerencial = True					
							Return True			
						End If
					Case Else
						Return False					
				End Choose
			Else
				Return False
			End If
		Else
			If not pvb_Gerencial Then
				If Not PDV.of_fecha_comprovante_tef_nao_finalizado() Then 					
					Continue			
				Else
					lb_Fechou_Comp = True
					Gerencial = True
					Return True			
				End If
			Else
				If Not PDV.of_fecha_relatorio_gerencial(False) Then 
					Continue			
				Else
					lb_Fechou_Comp = True			
					Gerencial = True					
					Return True			
				End If
			End If				
		End If
	Else
		lb_Fechou_Comp = True
		Return False
	End If
Loop
end function

public function boolean of_registra_transacao_tef_pendente ();String ls_cnpj_credenciadora
String ls_log_nsu_sitef, ls_log_nsu_host, ls_log_vl_transcao, ls_log_vl_CARDSE,ls_log_nsu_fepas,&
		ls_log_forma_pagamento, ls_log_bin, ls_log_cartao_dig, ls_log_autorizacao,ls_log_produto_tef,&
		ls_log_cd_modalidade, ls_log_de_modalidade, ls_log_cd_bandeira, ls_log_de_bandeira, ls_log_celular,&
		ls_log_autoricacao_cd, ls_log_uso_cd, ls_log_psp_cd, ls_log_cartaogift, ls_log_cod_carteira, ls_log_autorizadora
String ls_id_uso_cd
String ls_cpd
Long ll_bandeira_sefaz

If Not This.impressao Then
	If This.cd_funcao <> 300 And This.cd_funcao <> 301 And This.cd_funcao <> 261 And This.cd_funcao <> 264 And This.cd_funcao <> 265 And +&
	   This.cd_funcao <> 269 And This.cd_funcao <> 275 And This.cd_funcao <> 276 And This.cd_funcao <> 124 and This.cd_funcao <> 213 Then 
		Return True
	End If
End If

If This.SolicitacaoSenha Then Return True

If This.cd_funcao = 789 Or This.cd_funcao = 423 Then Return True //captura dados aberto pinpad

If This.is_Tipo_Venda = 'VL' and IsNull(This.cd_funcao) Then Return True //Somente consulta autorizacoa Vidalink, nao grava transacao.

Boolean lb_Sucesso

String  ls_cartao

Long    ll_Transacao

//Registra Transa$$HEX2$$e700e300$$ENDHEX$$o com status "A" (Autorizada)

Select Count(*) Into :ll_Transacao
From transacao_tef
Where nr_ecf     = :This.nr_ecf
  and nr_coo_ecf = :This.nr_cupom
Using Sqlca; 

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Erro ao verificar Sequencial de Transa$$HEX2$$e700f500$$ENDHEX$$es TEF: " + Sqlca.SqlErrText)
	Return False
End If

If IsNull(ll_Transacao) Then ll_Transacao = 0

ll_Transacao ++

If This.qt_parcelas = 0 Then This.qt_Parcelas = 1
//***LOG****
If IsNull( This.nr_nsu_host )					Then ls_log_nsu_host	= '' 			Else ls_log_nsu_host = This.nr_nsu_host
If IsNull( This.nr_nsu_sitef )					Then ls_log_nsu_sitef	= '' 			Else ls_log_nsu_sitef = This.nr_nsu_sitef
If IsNull( This.vl_transacao )					Then ls_log_vl_transcao	= 'NULO' Else ls_log_vl_transcao = String(This.vl_transacao, '0.00')
If IsNull( This.vl_aprovado_carteira )		Then ls_log_vl_CARDSE	= 'NULO' Else ls_log_vl_CARDSE = String(This.vl_aprovado_carteira, '0.00')
If IsNull( This.cd_forma_pagamento )		Then ls_log_forma_pagamento	= '' Else ls_log_forma_pagamento = This.cd_forma_pagamento
If IsNull( This.nr_Bin_Cartao )				Then ls_log_bin	= '' 				Else ls_log_bin = This.nr_Bin_Cartao
If IsNull( This.nr_Cartao )					Then ls_log_cartao_dig	= '' 		Else ls_log_cartao_dig = This.nr_Cartao
If IsNull( This.cd_modalidade )				Then ls_log_cd_modalidade	= ''	Else ls_log_cd_modalidade = This.cd_modalidade
If IsNull( This.de_modalidade )				Then ls_log_de_modalidade	= ''	Else ls_log_de_modalidade = This.de_modalidade
If IsNull( This.cd_bandeira )					Then ls_log_cd_bandeira	= ''		Else ls_log_cd_bandeira = This.cd_bandeira
If IsNull( This.de_bandeira )					Then ls_log_de_bandeira	= ''	Else ls_log_de_bandeira = This.de_bandeira
If IsNull( This.nr_celular )					Then ls_log_celular	= ''			Else ls_log_celular = This.nr_celular
If IsNull( This.nr_nsu_fepas )				Then ls_log_nsu_fepas	= '' 		Else ls_log_nsu_fepas = This.nr_nsu_fepas
If IsNull( This.de_produto_gift )				Then ls_log_produto_tef	= '' 		Else ls_log_produto_tef = This.de_produto_gift
If IsNull( This.nr_cartao_gift)				Then ls_log_cartaogift	= '' 		Else ls_log_cartaogift = This.nr_cartao_gift
If IsNull( This.cd_instituicao_financeira )	Then ls_log_psp_cd	= '' 			Else ls_log_psp_cd = This.cd_instituicao_financeira
If IsNull( This.cd_autorizacao_carteira )	Then ls_log_autoricacao_cd	= '' 	Else ls_log_autoricacao_cd = This.cd_autorizacao_carteira
If IsNull( This.cd_tipo_uso_cd )				Then ls_log_uso_cd	= '' 			Else ls_log_uso_cd = This.cd_tipo_uso_cd
If IsNull( This.cd_carteira_digital_tef )	Then ls_log_cod_carteira = ''		Else ls_log_cod_carteira = This.cd_carteira_digital_tef
If IsNull( This.cd_autorizadora)				Then ls_log_autorizadora = ''		Else ls_log_autorizadora = This.cd_autorizadora

//FIM
If This.cd_funcao = 122 Or This.cd_funcao = 124 Then //CARTEIRA DIGITAL
	gvo_Aplicacao.of_Grava_Log( "uo_sitef - or_registra_transacao_tef_pendente - Transa$$HEX2$$e700e300$$ENDHEX$$o CARTEIRA DIGITAL NsuTEF: " + This.nr_nsu_sitef + " NsuHOST: " + This.nr_nsu_host + " NsuFEPAS: " + This.nr_nsu_fepas + " Nome Bandeira: " + This.de_bandeira + " Valor transacao: " + String(This.vl_transacao, '0.00') + " Valor CardSE: " + String(This.vl_aprovado_carteira, '0.00'))
	ls_cartao = '000000'
	If This.cd_forma_pagamento = '99' Then //Transforma forma de pagamento em cartao debito
		This.cd_forma_pagamento = '01'		
	End If
	
//	If This.vl_aprovado_carteira > 0 Then //colocado controle na func$$HEX1$$e300$$ENDHEX$$o of_controla_interacao_dll
//		This.vl_transacao = This.vl_aprovado_carteira
//	End If

	This.nr_nsu_host = This.nr_nsu_fepas
	Choose Case This.cd_tipo_uso_cd //Retornos conforme manula da dll
		Case '01' //credito
			ls_id_uso_cd = 'C'
		Case '02' //debito
			ls_id_uso_cd = 'D'
		Case '04' //pre-pago
			ls_id_uso_cd = 'D'  //???
		Case '09' //N$$HEX1$$e300$$ENDHEX$$o definido	
			ls_id_uso_cd = 'D'  //???
		Case Else
			If This.cd_funcao = 124 Then //PIX SAQUE
				ls_id_uso_cd = 'D'
			Else
				ls_id_uso_cd = 'S'	//????
			End If
		//F= Fundo Emergencial
		//S= Saldo Conta
		//D= D$$HEX1$$e900$$ENDHEX$$bito - PIX - no caso de MercadoPago
		//C= Cr$$HEX1$$e900$$ENDHEX$$dito			
	End Choose
	//Para carteira digital, gravo o codigo da carteira no campo de bandeira, para depois usar na grava$$HEX2$$e700e300$$ENDHEX$$o do comprovante.
	This.cd_bandeira = This.cd_carteira_digital_tef
Else
	ls_Cartao = This.nr_Bin_Cartao
	
	If This.cd_funcao = 301 Then //Recarga sem pagamento vinculado n$$HEX1$$e300$$ENDHEX$$o retorna essas informa$$HEX2$$e700f500$$ENDHEX$$es na rotina da dll
		This.cd_forma_pagamento = '99'
		This.cd_modalidade = '99'
	End If
End If
	
If IsNull(This.nr_Autorizacao) and Not IsNull(This.PharmaSystem.nr_Autorizacao) Then
	This.nr_Autorizacao = This.PharmaSystem.nr_Autorizacao
End If	

If IsNull(This.nr_Autorizacao) and Not IsNull(This.Vidalink.nr_Autorizacao) Then
	This.nr_Autorizacao = This.Vidalink.nr_Autorizacao
End If

If IsNull( This.nr_Autorizacao )	Then ls_log_autorizacao	= '' Else ls_log_autorizacao = This.nr_Autorizacao

If This.cd_funcao = 2 or This.cd_funcao = 3 Then
	This.of_busca_cnpj(This.cd_autorizadora, This.de_bandeira, This.cd_bandeira, Ref ls_cnpj_credenciadora, Ref ll_bandeira_sefaz)	
End If

gvo_Aplicacao.of_Grava_Log( "Grava$$HEX2$$e700e300$$ENDHEX$$o Transa$$HEX2$$e700e300$$ENDHEX$$o TEF Pendente [ uo_sitef(ge084)-of_registra_transacao_tef_pendente ]. Fun$$HEX2$$e700e300$$ENDHEX$$o [" + String(This.cd_funcao) + "]" + & 
									", Autorizadora [" + ls_log_autorizadora + "]" + &
									", NSUSitef [" + ls_log_nsu_sitef + "]" + &
									", NSUHOST [" + ls_log_nsu_host + "]" + &
									", Valor [" + ls_log_vl_transcao + "]" + &
									", ValorAprovadoITI [" + ls_log_vl_CARDSE + "]" + &
									", FormaPgto [" + ls_log_forma_pagamento + "]" + &
									", BINCartao [" + ls_log_bin + "]" + &
									", CartaoDig [" + ls_log_cartao_dig + "]" + &
									", Autoriazacao [" + ls_log_autorizacao + "]" + &
									", CdModalidade [" + ls_log_cd_modalidade + "]" + &
									", DeModalidade [" + ls_log_de_modalidade + "]" + &
									", CdBandeira [" + ls_log_cd_bandeira + "]" + &
									", DeBandeira [" + ls_log_de_bandeira + "]" + &									
									", Celular [" + ls_log_celular + "]" + &
									", Parcelas [" + String( This.qt_Parcelas ) + "]" + &
									", ProdutoTEF [" + ls_log_produto_tef + "]" + &
									", GiftCard [" + ls_log_cartaogift + "]" + &
									", AutorizacaoCAD [" + ls_log_autoricacao_cd + "]" + &
									", PSP_CAD [" + ls_log_psp_cd + "]" + &
									", IdUso_CAD [" + ls_log_uso_cd + "]" + &
									", Codigo_CAD [" + ls_log_cod_carteira + "]")

Insert into transacao_tef  
	 ( nr_ecf,   	 
		nr_coo_ecf, 
		nr_transacao,
		cd_funcao,
		nr_nsu_sitef,   	   
		nr_nsu_host,   
		nr_autorizacao,
		cd_modalidade,   
		de_modalidade,   
		cd_forma_pagamento,   
		cd_autorizadora,   
		cd_bandeira,   
		de_bandeira,
		vl_transacao,
		vl_saque,
		dt_transacao,	   
		nr_cartao,
		qt_parcelas,
		de_via_caixa,
		de_via_cliente,
		cd_estabelecimento,
		nr_celular,
		cd_caixa,
		nr_controle_caixa,
		id_situacao,
		dt_predatado,
		nr_cnpj_credenciadora,
		cd_psp_recebedor,
		cd_autorizacao_cd,
		id_tipo_uso_cd,
		cd_bandeira_sefaz)  
Values(:This.nr_ecf,   
		 :This.nr_cupom,
		 :ll_Transacao,
		 :This.cd_funcao,
		 :This.nr_nsu_sitef,   	   
		 :This.nr_nsu_host,   
		 :This.nr_autorizacao,	   
		 :This.cd_modalidade,   
		 :This.de_modalidade,
		 :This.cd_forma_pagamento,   
		 :This.cd_autorizadora,   
		 :This.cd_bandeira,   
		 :This.de_bandeira,
		 :This.vl_transacao,
		 :This.vl_saque,
//		 :This.dt_transacao,
		 :This.dt_operacao_tef,
		 :ls_cartao,
		 :This.qt_parcelas,
		 :This.de_via_caixa,
		 :This.de_via_cliente,
		 :This.cd_estabelecimento,
		 :This.nr_celular,
		 :This.cd_caixa,
		 :This.nr_controle_caixa,
		 'P',
		 :This.dt_predatado,
		 :ls_cnpj_credenciadora,
		 :This.cd_instituicao_financeira,
		 :This.cd_autorizacao_carteira,
		 :ls_id_uso_cd,
		 :ll_bandeira_sefaz)
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"Erro ao atualizar tabela transacao_tef.")
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Erro ao atualizar tabela transacao_tef.")
	lb_Sucesso = False
Else
	lb_Sucesso = True
End If

If lb_Sucesso Then
	Sqlca.of_Commit()
Else
	Sqlca.of_RollBack()
End If

SetNull(This.dt_predatado)
	
Return lb_Sucesso
end function

public function boolean of_restricao_funcao (string ps_tipo, ref string ps_restricao);
dc_uo_ds_base ds_restricao
ds_restricao = Create dc_uo_ds_base

If Not ds_restricao.of_ChangeDataObject('dw_ge084_restricao_tef_filial') Then Return False

ds_restricao.Retrieve(ps_tipo)

Long ll_Row

If ds_restricao.RowCount() > 0 Then 
	
	ps_restricao = '['
	
	For ll_row = 1 To ds_restricao.RowCount()
		If ps_tipo = 'RC' Then
			//Se for recarga, seleciona somente transa$$HEX2$$e700f500$$ENDHEX$$es n$$HEX1$$e300$$ENDHEX$$o permitidas.
			If String(ds_restricao.object.id_ativo[ll_row]) = 'I' Then			
				ps_restricao += String(ds_restricao.object.cd_modalidade[ll_row],'00') + ';'
			End If
		Else
			ps_restricao += String(ds_restricao.object.cd_modalidade[ll_row],'00') + ';'			
		End If
		
	Next	
	
	ps_restricao += ']'
		
End If

Destroy(ds_restricao)
GarbageCollect()

Return True

end function

public function boolean of_biblioteca ();
If Not FileExists('CliSiTef32I.dll') Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Biblioteca de integra$$HEX2$$e700e300$$ENDHEX$$o com SITEF n$$HEX1$$e300$$ENDHEX$$o encontrada.",StopSign!)
	
	Return False

End If

Return True
end function

public function boolean of_controla_interacao_dll ();/*
* Fun$$HEX2$$e700e300$$ENDHEX$$o   : M$$HEX1$$f300$$ENDHEX$$dulo Central integra$$HEX2$$e700e300$$ENDHEX$$o CliSiTef32I.dll
* Data     : 25/07/2006
* Objetivo : Controla solicita$$HEX2$$e700f500$$ENDHEX$$es do Servidor SITEF atr$$HEX1$$e100$$ENDHEX$$ves da CliSiTef32I.dll
*/

String ls_Teste

Char    ls_Buffer[0 to 20000]

String  ls_log
String  ls_Parametro
String  ls_Opcao
String  ls_Titulo_Menu
String  ls_Mensagem
String  ls_Titulo
String  ls_data
String  ls_hora
String  ls_texto_parcelas
String  ls_autorizadora
String  ls_bandeira
String ls_Produto_Cartao_Gift

Integer li_TamanhoMinimo
Integer li_TamanhoMaximo

Long    ll_ComandoAnterior
Long    ll_ProximoComando
Long    ll_TipoCampo
Long    ll_Pendentes

Long    ll_Continua

//Vari$$HEX1$$e100$$ENDHEX$$veis Exclusivas Vidalink

Long    ll_Indice

Boolean lb_Sucesso
Boolean lb_Edm = False
Boolean lb_Inibe_Pergunta = False

String lvs_Teste

ll_ProximoComando = 0
ll_TipoCampo      = 0

li_TamanhoMinimo  = 0
li_TamanhoMaximo  = 0

ll_Continua = 0

This.qt_parcelas = 0
This.qt_parcelas_gen = 0
SetNull(This.de_bandeira_gen)
This.ConsultaBin = False
ls_bandeira = ''

SetNull( This.nr_nsu_fepas )
SetNull( This.cd_instituicao_financeira )
SetNull( This.cd_autorizacao_carteira )
SetNull( This.cd_tipo_uso_cd )
SetNull( This.cd_carteira_digital_tef )

Do
	
	SetPointer(HourGlass!)
	
	//gvo_Aplicacao.of_grava_log( "INICIO INTERACAO TEF **************")			
					
	This.id_Status = ContinuaFuncaoSiTefInterativo(Ref ll_ProximoComando, Ref ll_TipoCampo, li_TamanhoMinimo , li_TamanhoMaximo , ls_Buffer, UpperBound(ls_Buffer), ll_Continua)
		
	//Fecha Janela de Mensagem para o Operador
	If IsValid(w_ge084_aguarde) Then
		If ll_ProximoComando <> 11 and &
		   ll_ProximoComando <> 12 and &
			ll_ProximoComando <> 13 and &
			ll_ProximoComando <> 23 Then
			Close(w_ge084_aguarde)
		Else
			If w_ge084_aguarde.ivb_Cancelar Then ll_Continua = -1
		End If
	End If	

	Yield()
					
	If This.id_Status = 10000 Then 		// Sucesso na execu$$HEX2$$e700e300$$ENDHEX$$o da fun$$HEX2$$e700e300$$ENDHEX$$o inicial
					
		//gvo_Aplicacao.of_grava_log( "ll_ProximoComando: " +String(ll_ProximoComando) + " - Funcao: " +String(This.cd_funcao) + " - Tipo_campo: " +String(ll_TipoCampo))			
					
		Choose Case ll_ProximoComando				
			Case 0								// Armazenar Valor devolvido
				If ll_TipoCampo = 504 Then
					ll_TipoCampo = ll_TipoCampo
				End If
																			
			Case 1,3 							// Mensagem para operador
				
				This.msg_operador = Trim(ls_Buffer)
				
				of_Mensagem_Operador(This.msg_operador)
				
			Case 2,3 							// Mensagem para cliente
				
				This.msg_cliente  = Trim(ls_Buffer)
				
				of_Mensagem_Operador(This.msg_cliente)
				
			Case 4								// T$$HEX1$$ed00$$ENDHEX$$tulo para o Menu din$$HEX1$$e200$$ENDHEX$$mico
				
				ls_Titulo_Menu    = ls_Buffer

			Case 11								// Remove Mensagem Operador
				
				SetNull(This.msg_operador)
				
			Case 12								// Remove Mensagem Cliente
				
				SetNull(This.msg_cliente)
				
			Case 13								// Remove Mensagem Cliente e Operador
								
				SetNull(This.msg_operador)
				SetNull(This.msg_cliente)
		
			Case 20 								// Confirma Sim ou N$$HEX1$$e300$$ENDHEX$$o

				SetPointer(Arrow!)
				
				If Trim(This.nr_bin_cartao) = '639664' And (ll_TipoCampo = 507 or ll_TipoCampo = 509) Then
					//Conforme chamado 149521, para cart$$HEX1$$f500$$ENDHEX$$es banrisul na pergunta "Primeira Parcela a Vista?", o sistema vai responder automaticamente N$$HEX1$$c300$$ENDHEX$$O.
					//Para pergutna "M$$HEX1$$ea00$$ENDHEX$$s Fechado?" o sistema vai responder automaticamene SIM.
					If ll_TipoCampo = 507 Then
						ll_Continua = 0
						ls_Buffer   = '1'
					End If
					
					If ll_TipoCampo = 509 Then
						ll_Continua = 0
						ls_Buffer   = '0'
					End If
				Else						
					If ll_TipoCampo = 1022 Then //Altera$$HEX2$$e700e300$$ENDHEX$$o para UtilCard - Troca a pergunta Compra de Medicamento(PBM) por Compra com Receita? Chamado 217909
						ls_buffer = 'Compra com Receita?'
					End If					
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Buffer,Question!,YesNo!,1) = 1 Then
						ll_Continua = 0
						ls_Buffer   = '0'
					Else
						ll_Continua = 0
						ls_Buffer   = '1'
					End If
				End If		
				
			Case 21 								// Cria menu din$$HEX1$$e200$$ENDHEX$$micamente para sele$$HEX2$$e700e300$$ENDHEX$$o Operador
				
				ls_opcao = ls_Buffer
														
				If This.Recarga Then
					ls_Parametro = "S;" + String(LenA(ls_opcao),'0000')+';'+ls_opcao+ls_Titulo_Menu
				Else
					ls_Parametro = String(LenA(ls_opcao),'0000')+';'+ls_opcao+ls_Titulo_Menu
				End If
				
				//Para funcional card n$$HEX1$$e300$$ENDHEX$$o precisa pedir o cartao do cliente
				//aqui vamos omitir a pergunta ao usuario e passar como digitado				
				If (This.cd_funcao = 560 or This.cd_funcao = 561 or This.cd_funcao = 562) Then
					If Pos(ls_Parametro, "Selecione o tipo do cartao") > 0 Then
						lb_Inibe_Pergunta = True
						ls_opcao = '2'
					End If
				End If
				
				//Transa$$HEX2$$e700f500$$ENDHEX$$es GiftCard, inibe informar mais cart$$HEX1$$f500$$ENDHEX$$es gift na mesma transa$$HEX2$$e700e300$$ENDHEX$$o
				If (This.cd_funcao = 261 or This.cd_funcao = 264 or This.cd_funcao = 265 or This.cd_funcao = 269) Then
					If Pos(Upper(ls_Parametro), "FINALIZAR LEITURA E IR PARA PAGAMENTO") > 0 Then
						lb_Inibe_Pergunta = True
						ls_opcao = '4'
					End If
					//Transa$$HEX2$$e700f500$$ENDHEX$$es GiftCard, inibe informar meio de pagamento, j$$HEX1$$e100$$ENDHEX$$ foi solicitado no inicio.
					If (This.cd_funcao = 261 or This.cd_funcao = 265) And (Pos(Upper(ls_Parametro), "CARTAO DE DEBITO") > 0) Then
						lb_Inibe_Pergunta = True
						ls_opcao = '1'
					End If
					//Inibe pergunta se cart$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ digitado/magnetico, pois alguns gifts tem tarja magnetica, e quando a leitura ocorre pela tarja, n$$HEX1$$e300$$ENDHEX$$o conseguimos capturar o numero completo do cod. de barras.
					If This.cd_funcao = 264 or This.cd_funcao = 265 Then
						If Pos(Upper(ls_Parametro), "1:MAGNETICO;2:LEITURA VIA CODIGO DE BARRAS;3:DIGITADO") > 0 And lb_Inibe_Pergunta = False Then
							lb_Inibe_Pergunta = True
							ls_opcao = '3'							
						End If
						If Pos(Upper(ls_Parametro), "1:MAGNETICO;2:DIGITADO;") > 0 And lb_Inibe_Pergunta = False Then
							lb_Inibe_Pergunta = True
							ls_opcao = '2'							
						End If						
					End If
				End If
				//SAQUE PIX, inibe pergunta sobre carteira digital, usa opa$$HEX2$$e700e300$$ENDHEX$$o 1.
				If This.cd_funcao = 124 Then
					If Pos(Upper(ls_Parametro), "1:BANCO24HORAS;2:PIX SAQUE;") > 0 And lb_Inibe_Pergunta = False Then
						lb_Inibe_Pergunta = True
						ls_opcao = '1'							
					End If
				End If				
				//CARTAO PRESENTE, inibe pergunta sobre carteira digital, usa opa$$HEX2$$e700e300$$ENDHEX$$o 2.
				If This.cd_funcao = 15 Then
					If Pos(Upper(ls_Parametro), "1:MAGNETICO;2:DIGITADO") > 0 And lb_Inibe_Pergunta = False Then
						lb_Inibe_Pergunta = True
						ls_opcao = '2'							
					End If
				End If	
							
				If This.cd_funcao = 213 Then //Cancela venda cartao presente
					If Pos(Upper(ls_Parametro), "1:MAGNETICO;2:DIGITADO") > 0 And lb_Inibe_Pergunta = False Then
						lb_Inibe_Pergunta = True
						ls_opcao = '2'	
						ls_Buffer = This.nr_cartao_gift
					End If
					
					Choose Case ll_tipoCampo
						Case	3029
							ls_Buffer = This.nr_cartao_gift
							Continue
						Case 3344
							ls_Buffer = This.nr_cartao_gift
							Continue
					End Choose
					
				End If							
				
				
				If not lb_Inibe_Pergunta Then
					OpenWithParm(w_ge084_selecao_menu,ls_Parametro)
					
					Yield()
					
					ls_opcao = Message.StringParm
				End If
				lb_Inibe_Pergunta = False
				
				Choose Case ls_opcao
					Case "CANCELAR"
						ll_Continua = -1
					Case "VOLTAR"
						ll_Continua = 1
						Continue
					Case Else
						If This.is_Tipo_Venda = "TRNCENTRE" Then
							If Trim(This.TRNCentre.de_Operadora) = "" Or IsNull(This.TRNCentre.de_Operadora) Then
								Long ll_Pos1, ll_Pos2
								ll_Pos1 = PosA(ls_Parametro, ";" + ls_opcao + ":")
								ll_Pos2 = ll_Pos1 + 3 + PosA(MidA(ls_Parametro, ll_Pos1 + 3), ";")
								
								This.TRNCentre.de_Operadora = Trim(MidA(ls_Parametro, ll_Pos1 + 3, ll_Pos2 - ll_Pos1 - 4))
							End If
						End If
						
						ls_Buffer   = Trim(ls_opcao)
						ll_Continua = 0
				End Choose
				If is_Tipo_Venda = "TRNCENTRE" Then
					If LenA(ls_opcao) = 52 Then
						Sitef.id_Cartao_Digitado = True
					End If
				End If
				
			Case 22 							// Aguarda confirma$$HEX2$$e700e300$$ENDHEX$$o do Operador

				If Not This.cd_Funcao = 590 Or LeftA(Trim(ls_Buffer), 15) <> "Nao existe tela" Then
					OpenWithParm(w_ge084_mostra_mensagem,ls_Buffer)
				
					Yield()
				End If				 
									
			Case 23 							// Aguarda confirma$$HEX2$$e700e300$$ENDHEX$$o [dig.senha ou leitura cart$$HEX1$$e300$$ENDHEX$$o]	
				
				Yield()
				
				If Not of_Mensagem_Operador(This.msg_operador,True) Then
					ll_Continua = -1
				End If
				
			Case 29 				//Coleta String sem interven$$HEX2$$e700e300$$ENDHEX$$o operador
				If ll_tipoCampo = 2967 Then  //codigo dado operador
					ls_Buffer = This.cd_tipo_cpatura_pinpad
					Continue										
				End If				
				If ll_tipoCampo = 2968 Then  //tamanho minimo
					ls_Buffer = This.de_tam_mim_captura
					Continue										
				End If				
				If ll_tipoCampo = 2969 Then  //tamanho maximo
					ls_Buffer = This.de_tam_max_captura
					Continue										
				End If				
				If ll_tipoCampo = 2970 Then  //tempo maximo
					ls_Buffer = '0'
					Continue										
				End If										
				
				If ll_tipoCampo = 4153 Then  //CODIGO PSP PIX
				End If				
				If ll_tipoCampo = 4154 Then  //SOLICITAO PAGADOR - pergunta no app
				End If					
				
				If ll_tipoCampo = 4156 Then  //mensagem cliente PIX
					ls_Buffer = This.is_msg_cliente
					Continue					
				End If
				
				//TUICCS
				If ll_tipoCampo = 512 Then  //identificacao
					//ls_Buffer = '00518750805505034'
					//bin: 005187 + CPF ou Cd_conveniado	
					ls_Buffer = This.BIN_TUICCS + is_Identificacao_Conveniado
					Continue										
				End If							
				If ll_tipoCampo = 2606 Then  //tempo maximo
					ls_Buffer = '90'
					Continue										
				End If							
				If ll_tipoCampo = 2607 Then  //cripotografia
					ls_Buffer = '2'
					Continue										
				End If
				If ll_tipoCampo = 2609 Then  //chave tuiccs
					ls_Buffer = CHAVE_TUICCS
					Continue										
				End If								
			
			Case 30 							// Coleta String
						
				If This.cd_funcao = 213 Then
					Choose Case ll_TipoCampo
						Case 512 //Buffer: Forneca o numero do cartao
							ls_Opcao = String(This.nr_cartao_gift )
						Case 515	 //Data transacao
							ls_Opcao = String(This.dt_transacao, 'DDMMYYYY')
						Case 516 //Buffer: Forneca o numero do documento a ser cancelado
							ls_Opcao = String(This.nr_nsu_sitef )
					End Choose
					
					ls_Buffer   = Trim(ls_opcao)
					Continue
				End If					
						
						
				//Controle de Produtos PharmaSystem
				If ll_TipoCampo = 1012 Then
					
					If This.PharmaSystem.ivl_Enviados <> This.PharmaSystem.ivl_Produtos Then
													
						ls_Buffer = This.PharmaSystem.of_Mensagem_Produto()
					
						ll_Continua = 10000
						Continue

					End If		
					
					
					//If This.TRNCentre.ivl_Enviados <> This.TRNCentre.ivl_Produtos Then
					If This.TRNCentre.ds_Autorizacao.RowCount() > 0 Then
						
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", This.TRNCentre.ivl_Enviados)
						
						ls_Buffer = This.TRNCentre.of_Mensagem_Produto(ll_TipoCampo)
					
						Continue
						
					End If
					
				
					If This.Funcional.ds_Autorizacao.RowCount() > 0 Then					
						
						ls_Buffer = This.Funcional.of_Mensagem_Produto(ll_TipoCampo)
					
						Continue
						
					End If
				
				
					ls_Buffer   = ''
					ll_Continua = 0
					Continue
					
				End If				

				If ll_TipoCampo = 1025 Then
					//Controle de Produtos EdmCard					
					If This.EdmCard.ivl_Enviados <> This.EdmCard.ivl_Produtos Then									
						lb_Edm = True
						ls_Buffer = This.EdmCard.of_Mensagem_Produto()
					
						ll_Continua = 10000
						Continue
					Else		
						If lb_Edm Then
							ls_Buffer = ''
							ll_Continua = 0
							Continue			
						Else							
							//Monta lista de produtos quando necess$$HEX1$$e100$$ENDHEX$$rio(cart$$HEX1$$f500$$ENDHEX$$es PBM(goodcard))
							This.qt_Produtos = This.ds_Autorizacao.RowCount()
							If This.qt_Produtos <> This.qt_Enviados Then						
								ls_Buffer = This.of_Mensagem_Produto()
							
								ll_Continua = 10000
								Continue							
							Else
								ls_Buffer = ''
								ll_Continua = 0
								This.qt_Enviados = 0
								Continue			
							End If
						End If
					End If
				End If
				
				//Autoriza$$HEX2$$e700e300$$ENDHEX$$o PharmaSystem / TRNCentre
				If ll_TipoCampo = 1030 Then
					
					If This.PharmaSystem.ivl_Produtos > 0 Then													
						ls_Buffer   = ''
						ll_Continua = 0
						Continue
					End If	
					
					If Trim(This.TRNCentre.nr_Autorizacao) <> "" And Not IsNull(This.TRNCentre.nr_Autorizacao) Then
						ls_Buffer   = This.TRNCentre.nr_Autorizacao
						ll_Continua = 0
						Continue
					End If

					If Trim(This.Funcional.nr_Autorizacao) <> "" And Not IsNull(This.Funcional.nr_Autorizacao) Then
						ls_Buffer   = This.Funcional.nr_Autorizacao
						ll_Continua = 0
						Continue
					End If	
					
					If Trim(This.Vidalink.nr_Autorizacao) <> "" And Not IsNull(This.Vidalink.nr_Autorizacao) Then
						ls_Buffer   = This.Vidalink.nr_Autorizacao
						ll_Continua = 0
						Continue
					End If				
					
				End If
				
				//Fun$$HEX2$$e700e300$$ENDHEX$$o TRNCentre
				If This.TRNCentre.ds_Autorizacao.RowCount() > 0 Then
					If ll_TipoCampo = 1013 Or ll_TipoCampo = 4008 Or ll_TipoCampo = 4015 Then
						ls_Buffer = This.TRNCentre.of_Mensagem_Produto(ll_TipoCampo)
					
						Continue
					End If
				End If
				//Fim das Fun$$HEX2$$e700f500$$ENDHEX$$es TRNCentre
				If This.Funcional.ds_Autorizacao.RowCount() > 0 Then
					If ll_TipoCampo = 1013 Or ll_TipoCampo = 4008 Or ll_TipoCampo = 4015 Then
						ls_Buffer = This.Funcional.of_Mensagem_Produto(ll_TipoCampo)
					
						Continue
					End If
				End If							
				
				String ls_Recarga
				
				ls_Parametro = String(ll_ProximoComando,'00000')+';'+String(li_TamanhoMinimo,'00000')+';'+String(li_TamanhoMaximo,'00000')
				
				If (This.cd_funcao = 300 Or This.cd_funcao = 301) and Not IsNull(This.de_operadora) Then
					ls_Recarga = LeftA(This.de_operadora + FillA(' ',50),50)
				Else
					
					If ll_TipoCampo = 505 Then

						ls_Recarga = "Parcela m$$HEX1$$ed00$$ENDHEX$$nima R$ " + String(This.vl_parcela_minima,'###,##0.00')
						
						If This.nr_Parcelas_Maximo > 0 Then
							ls_Recarga += " em at$$HEX1$$e900$$ENDHEX$$ " + String(This.nr_Parcelas_Maximo) + " parcelas "
						End If
						
						ls_Recarga = LeftA( ls_Recarga + Space(50) , 50)						
						
					Else
						ls_Recarga = Space(50)
					End If

				End If

				ls_Parametro += ';' + ls_Recarga + ';' + ls_Buffer
				
				If ll_TipoCampo = 500 Then				
					If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("TRANSACAO ADMINISTRATIVA TEF",Ref ls_Opcao) Then
						ls_opcao = "CANCELAR"
						ll_Continua = -1
						Continue
					End If
					
					Choose Case ls_opcao
						Case "CANCELAR"
							ll_Continua = -1
							Exit
						Case "VOLTAR"
							ll_Continua = 1
							Exit
						Case Else
								Continue
					End Choose															
					
				Else
				
					Do While True
						
						This.Tipo_Campo = ll_TipoCampo
						
						//Para funcional card n$$HEX1$$e300$$ENDHEX$$o precisa pedir o cartao do cliente
						//aqui vamos passar o cartao com todos os digitos 0(zero)
						If (This.cd_funcao = 560 or This.cd_funcao = 561 or This.cd_funcao = 562 ) Then
							If Pos(ls_Parametro, "Forneca o numero do cartao") > 0 Then
								lb_Inibe_Pergunta = True
							End If
						End If
						
						If lb_Inibe_Pergunta Then
							ls_opcao = "00000000000000000"
						Else
							If This.Tipo_Campo = 505 Then
								If This.of_monta_parcelas_cartao(Ref ls_Texto_parcelas) Then
									OpenWithParm(w_ge084_selecao_menu,ls_texto_parcelas)
									
									Yield()
									
									ls_opcao = Message.StringParm									
								Else
									ls_opcao = 'VOLTAR'
								End If								
							Else								
								OpenWithParm(w_ge084_coleta_campo_string,ls_Parametro)
								Yield()
			
								ls_opcao = Message.StringParm
							End If
						End If
						lb_Inibe_Pergunta = False
						
						Choose Case ls_opcao
							Case "CANCELAR"
								ll_Continua = -1
								Exit
							Case "VOLTAR"
								ll_Continua = 1
								Exit
							Case Else
																
								If ll_TipoCampo = 512 Then									
									This.id_Cartao_Digitado = True
									This.de_Cartao_Digitado = ls_opcao
									If This.cd_funcao = 261 or This.cd_funcao = 264 or This.cd_funcao = 265 or This.cd_funcao = 269 or This.cd_funcao = 275 or This.cd_funcao = 276 Then
										This.nr_cartao_gift = Trim(ls_opcao)
									End If									
								End If
								
								If ll_TipoCampo <> 505 or of_Valida_Parcela_Minima(ll_TipoCampo,ls_opcao) Then
									ls_Buffer   = Trim(ls_opcao)
									ll_Continua = 0
									Exit
								Else
									Continue
								End If
						End Choose
	
					Loop
					
				End If
								
				If ll_Continua = 1 Then Continue
				
			Case 34 	// Coleta Num$$HEX1$$e900$$ENDHEX$$rico
					
				If This.cd_funcao = 213 Then
					Choose Case ll_TipoCampo
						Case 146 //Buffer: Forneca o valor da transacao a ser cancelada
							ls_Buffer = String(This.vl_transacao )
							Continue
					End Choose	
				End If
					
					
				//Fun$$HEX2$$e700e300$$ENDHEX$$o TRNCentre
				If This.TRNCentre.ds_Autorizacao.RowCount() > 0 Then
					If ll_TipoCampo = 4016 Or ll_TipoCampo = 4017 Or ll_TipoCampo = 4018 Then
						ls_Buffer = This.TRNCentre.of_Mensagem_Produto(ll_TipoCampo)
					
						Continue
					End If
				End If
				//Fim das Fun$$HEX2$$e700f500$$ENDHEX$$es TRNCentre

				If This.Funcional.ds_Autorizacao.RowCount() > 0 Then
					If ll_TipoCampo = 4016 Or ll_TipoCampo = 4017 Or ll_TipoCampo = 4018 Then
						ls_Buffer = This.Funcional.of_Mensagem_Produto(ll_TipoCampo)
					
						Continue
					End If
				End If
				
				//Compra e Saque
				If ll_TipoCampo = 130 and ( Not This.CompraSaque or This.cd_funcao = 300 or This.cd_funcao = 301 or This.Vl_Transacao < 20.00 ) Then
					ls_Buffer   = '0'
					ll_Continua = 0
					Continue
				End If
				
				If ll_TipoCampo = 2064 and (This.cd_funcao = 261 or This.cd_funcao = 264 or This.cd_funcao = 265 or This.cd_funcao = 269 ) Then
					ls_Buffer   = String(This.vl_transacao)
					ll_Continua = 0
					Continue
				End If
								
				ls_Titulo = ls_Buffer
				
				If ll_TipoCampo = 130 Then
					ls_Titulo += CharA(10) + "Somente valor m$$HEX1$$fa00$$ENDHEX$$ltiplo de R$ 5,00 - M$$HEX1$$e100$$ENDHEX$$ximo R$ 100,00"
				End If
			
				ls_Parametro = String(ll_ProximoComando,'00000')+';'+String(li_TamanhoMinimo,'00000')+';'+String(li_TamanhoMaximo,'00000')+';'+ls_Titulo
				
				Do While True	
		
					OpenWithParm(w_ge084_coleta_campo_numerico,ls_Parametro)
					
					Yield()
								
					ls_opcao = Message.StringParm
				
					Choose Case ls_opcao
						Case "CANCELAR"
							ll_Continua = -1
							Exit
						Case "VOLTAR"
							ll_Continua = 1
							Exit
						Case Else
							If ll_TipoCampo <> 130 or of_Valida_Valor_Saque(ll_TipoCampo,ls_Opcao) Then
								ls_Buffer   = Trim(ls_opcao)
								ll_Continua = 0
								Exit
							Else
								Continue
							End If
					End Choose
					
				Loop
				
				If ll_Continua = 1 Then Continue

			Case 31
																		
		End Choose
	
		ll_ComandoAnterior = ll_ProximoComando
		
		If ll_TipoCampo >= 1000 Then
			ll_TipoCampo = ll_TipoCampo
		End If
		
		lvs_Teste = Trim(ls_Buffer)
			
		Choose Case ll_TipoCampo
			Case -1
				Continue
			Case 2
				If This.is_Tipo_Venda = "VL" and IsNull(This.cd_funcao) Then //Vidalink - n$$HEX1$$e300$$ENDHEX$$o passo um codigo de fun$$HEX2$$e700e300$$ENDHEX$$o, por isso tem que buscar do TEF.
					This.cd_funcao = Long(Trim(ls_Buffer))
				End If				
			Case 100
				If This.cd_funcao = 261 Then 
					//Fun$$HEX2$$e700e300$$ENDHEX$$o de recarga sempre traz 01 quando informa dinheiro, mas para o tef 01 $$HEX1$$e900$$ENDHEX$$ d$$HEX1$$e900$$ENDHEX$$bito
					This.cd_forma_pagamento = '98'
				ElseIf This.cd_funcao = 264 Or This.cd_funcao = 275 Or This.cd_funcao = 276 Then
					This.cd_forma_pagamento = '99'
				Else
					This.cd_forma_pagamento = MidA(ls_Buffer,01,02)
				End If
				This.cd_modalidade      = MidA(ls_Buffer,03,02)
			Case 101
				This.de_modalidade = Upper(Trim(ls_Buffer))
			Case 105
				ls_data = MidA(ls_Buffer,7,2)+"/"+MidA(ls_Buffer,5,2)+"/"+MidA(ls_Buffer,1,4)
				ls_hora = MidA(ls_Buffer,9,2)+":"+MidA(ls_Buffer,11,2)+":"+MidA(ls_Buffer,13,2)	
				This.dt_operacao_tef = DateTime(Date(ls_Data),Time(ls_Hora))				
			Case 106
				This.cd_carteira_digital_tef = Upper(Trim(ls_Buffer))
			Case 107
				This.nm_carteira_ditital = Upper(Trim(ls_Buffer))		
			Case 108  //BANDEIRA
				lvs_Teste = Trim(ls_Buffer)
			Case 109 // VALOR PRODUTO
				lvs_Teste = Trim(ls_Buffer)
			Case 111
				This.de_cancelamento = ls_Buffer				
			Case 121
				This.impressao       = True
				This.de_via_cliente  = ls_Buffer
			Case 122
				This.impressao       = True							
				This.de_via_caixa    = ls_Buffer
			Case 130
				This.vl_saque        = Dec(ls_Buffer)
			Case 131
				
				If Not Retaguarda Then				
					If This.cd_Funcao <> 110 Then
						If IsNull(This.EdmCard.id_Status) Then
							If Trim(ls_Buffer) = This.EdmCard.cd_Rede Then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o EDMCARD somente para pagamento na modalidade [conv$$HEX1$$ea00$$ENDHEX$$nio].",Exclamation!)
								ll_Continua = -1
								Continue
							End If
						Else
							If Trim(ls_Buffer) <> This.EdmCard.cd_Rede Then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Modalidade de venda exclusiva para pagamento com cart$$HEX1$$e300$$ENDHEX$$o EDMCARD.",Exclamation!)
								ll_Continua = -1
								Continue
							End If					
						End If	
					End If	
				End If
								
				This.cd_autorizadora = Trim(ls_Buffer)				
			Case 132
				
				This.cd_bandeira     = Trim(ls_Buffer)	
				
				//Processo para GETNETLAC. N$$HEX1$$e300$$ENDHEX$$o retorna nome da bandeira, ent$$HEX1$$e300$$ENDHEX$$o usamos o codigo do tef para gravar na bandiera certa.
				If Long(This.cd_autorizadora) = 181 Then
					If This.cd_forma_pagamento = '01' or This.cd_forma_pagamento = '02' Then
						of_busca_bandeira(This.cd_forma_pagamento,Long(This.cd_bandeira),Long(This.cd_autorizadora),This.de_bandeira)					
					End If
				End If	

				//Processo para Permitir apenas cart$$HEX1$$e300$$ENDHEX$$o AMEX, ELO DEBITO E CREDITO pela Cielo
				//Se mais cart$$HEX1$$f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o aceitos pela Cielo, RETIRAR essa verifica$$HEX2$$e700e300$$ENDHEX$$o.
				//O codigo 10013 $$HEX1$$e900$$ENDHEX$$ o retorno no nosso servidor tef para cart$$HEX1$$f500$$ENDHEX$$es ELO, 31 e 20032 s$$HEX1$$e300$$ENDHEX$$o os retornados no TEF da Software Express.
//				If Long(This.cd_autorizadora) = 125 Then				
//					If Long(This.cd_bandeira) <> 4 And Long(This.cd_bandeira) <> 10013  And  Long(This.cd_bandeira) <> 31 And Long(This.cd_bandeira) <> 20032 Then
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o aceito em nossa Rede!",Exclamation!)
//						ll_Continua = -1
//						Continue
//					End If
//				End If				
				
				If Not This.of_Parcela_Minima(This.cd_bandeira) Then Continue
				
			Case 133
				If IsNull(This.nr_nsu_sitef) Then
					This.nr_nsu_sitef = Trim(ls_Buffer)					
				End If
				If This.cd_funcao = 261 or This.cd_funcao = 264 or This.cd_funcao = 265 or &
				   This.cd_funcao = 269 or This.cd_funcao = 275 or This.cd_funcao = 276 Then
				//gift
					This.nr_nsu_gift_recarga =  Trim(ls_Buffer)
				End If
			Case 134
				//This.nr_nsu_host     = Trim(ls_Buffer)
				This.nr_nsu_host = RightA(Trim(ls_Buffer), 12)
				If This.cd_funcao = 300 or This.cd_funcao = 301 Then
				//recarga
					This.nr_nsu_gift_recarga =  Trim(ls_Buffer)
				End If				
			Case 135
				If This.cd_funcao = 122 Or This.cd_funcao = 124 Then //Na carteira digital PIX e Mercado Pago, o retorno $$HEX1$$e900$$ENDHEX$$ um texto longo e foi criado novo campo para receber.
					This.cd_autorizacao_carteira = Trim(ls_Buffer)
				Else
					This.nr_autorizacao  = Trim(ls_Buffer)
				End If				
			Case 136
				This.nr_bin_cartao   = Trim(ls_Buffer)							
				This.of_verifica_bin_generico(This.nr_bin_cartao)		
				
				//Verifica se o cartao gift $$HEX1$$e900$$ENDHEX$$ marca propria da rede
				If This.cd_funcao = 15 Then
					//ls_BIN = LeftA(This.nr_cartao_gift,6)
					ls_Produto_Cartao_Gift = Mid(This.nr_cartao, 7, 3)
					If Not gf_cartao_presente_clamed( This.nr_bin_cartao, ls_Produto_Cartao_Gift ) Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cart$$HEX1$$e300$$ENDHEX$$o informado n$$HEX1$$e300$$ENDHEX$$o faz parte do Cart$$HEX1$$e300$$ENDHEX$$o Presente " + gvo_parametro.id_rede_filial, Exclamation!)
						ll_Continua = -1
						Exit
					End If
				End If
				
			Case 146
				This.vl_transacao    = Dec(ls_Buffer)
			Case 148				
				This.vl_aprovado_carteira = Dec(ls_Buffer)/100
				If This.id_empresa_tef = '00000000' Then //simulador sempre retonar 0,10
					This.vl_aprovado_carteira = This.vl_transacao
				End If
				//Por enquanto n$$HEX1$$e300$$ENDHEX$$o trabalhamos com desconto em venda no uso da carteira, se o valor aprovador for diferente, n$$HEX1$$e300$$ENDHEX$$o permite prosseguir
				If This.vl_aprovado_carteira < This.vl_transacao then 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valo aprovado pela Carteira difere do valor da Transa$$HEX2$$e700e300$$ENDHEX$$o. Opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida!",Exclamation!)
					ll_Continua = -1
					Continue					
				End If
			Case 151				
				lvs_Teste =  Trim(ls_Buffer)
			Case 153	
				This.de_senha_capturada =  Trim(ls_Buffer)				
				This.SolicitacaoSenha = True
			Case 156
				If IsNull(This.de_bandeira_gen) Or Trim(This.de_bandeira_gen) = '' Then
					If Long(This.cd_autorizadora) <> 181 Then	This.de_bandeira     = Trim(ls_Buffer)
				Else
					This.de_bandeira = This.de_bandeira_gen
				End If	
			Case 157
				This.cd_estabelecimento = Trim(ls_Buffer)
			Case 161
				This.nr_identificador_pgto = Trim(ls_Buffer)
//			Case 140,505,511 - No manual do TEF 140 $$HEX1$$e900$$ENDHEX$$ a data de vencimento da parcela, por isso foi retirado
			Case 505,511				
				This.qt_parcelas     = Long(ls_Buffer)
			Case 177, 178 //Campo complementar
			Case 200
				This.PharmaSystem.vl_Saldo    = Dec(ls_Buffer)
			Case 502 //Casos onde $$HEX1$$e900$$ENDHEX$$ PBM vendido por CPF/CGC
				This.nr_cpf_cgc = Trim(ls_Buffer)		
			Case 504 // Taxa de Servi$$HEX1$$e700$$ENDHEX$$o
				This.msg_cliente  = Trim(ls_Buffer)
				
				of_Mensagem_Operador(This.msg_cliente)
				
				lb_Inibe_Pergunta = True		
				
				Yield()
				
				Continue
				
			Case 503 // CNPJ
				lvs_Teste = Trim(ls_Buffer)				
			Case 506 //Cart$$HEX1$$e300$$ENDHEX$$o Banrisul D$$HEX1$$e900$$ENDHEX$$bito - Pr$$HEX1$$e900$$ENDHEX$$-Datado
				This.dt_predatado		= DateTime(Date(MidA(ls_Buffer,1,2) + "/" + MidA(ls_Buffer,3,2) + "/" + MidA(ls_Buffer,5,4)))
			Case 512
				This.nr_cartao       = Trim(ls_Buffer)
			Case 522 // TELEFONE CLIENTE
				lvs_Teste = Trim(ls_Buffer)
			Case 545 // TIPO PRODUTO CARTERIA DIGITAL
				This.cd_tipo_uso_cd = Trim(ls_Buffer)
			Case 546 // TIPO VOUCHER CARTEIRA DIGITAL
				lvs_Teste = Trim(ls_Buffer)				
			Case 584
				This.qr_code_estabelecimento = Trim(ls_Buffer)
			Case 585 // TOKEN APP
				lvs_Teste = Trim(ls_Buffer)
			Case 589 // codigo operadora celular
				lvs_Teste = Trim(ls_Buffer)								
			Case 590
				This.de_operadora    = Trim(ls_Buffer)
			Case 592
				This.nr_celular      = ls_Buffer
			Case 591
				This.vl_transacao    	= Dec(ls_Buffer)/100
				This.vl_total_transacao = This.vl_transacao
			Case 599
				This.cd_autorizadora_recarga = Trim(ls_Buffer)
			Case 601				
				If This.cd_funcao = 261 or This.cd_funcao = 264 or This.cd_funcao = 275 or This.cd_funcao = 276 Then
					This.vl_transacao    	= Dec(ls_Buffer)
					This.vl_total_transacao = This.vl_transacao
				End If				
			Case 624 // COD. BARRAS APP
				lvs_Teste = Trim(ls_Buffer)
			Case 723 // IDENTIFICACAO CLIENTE
				lvs_Teste = Trim(ls_Buffer)
			Case 740 // QRCODE cliente
				lvs_Teste = Trim(ls_Buffer)
			Case 1010 // Vidalink - Qtdade total
				//Por enquanto n$$HEX1$$e300$$ENDHEX$$o usamos.
			Case 1011 // Vidalink - Indice medicamento
				//Por enquanto n$$HEX1$$e300$$ENDHEX$$o usamos.				
			Case 1012 // TRNCentre - Pharmasystem - Funcional
				If Not IsNull(This.is_Tipo_Venda) And This.is_Tipo_Venda = "TRNCENTRE" Then
					This.TRNCentre.of_Retorno_Produto(Trim(ls_Buffer))
				Else
					If This.is_Tipo_Venda = "FC" Then
						This.Funcional.of_Retorno_Produto(Trim(ls_Buffer))
					Else
						If This.is_Tipo_Venda = "VL" Then
							This.Vidalink.of_Retorno_Produto(Trim(ls_Buffer))							
						Else
							This.PharmaSystem.of_Retorno_Produto(Trim(ls_Buffer))
						End If
					End If
				End If
			Case 1013 // Quantidade Aut. =  TRNCentre - Pharmasystem - Funcional 
				If Not IsNull(This.is_Tipo_Venda) And This.is_Tipo_Venda = "TRNCENTRE" Then
					This.TRNCentre.of_Retorno_Produto_Quantidade(Long(ls_Buffer))
				Else
					If This.is_Tipo_Venda = "FC" Then
						This.Funcional.of_Retorno_Produto_Quantidade(Long(ls_Buffer))
					Else
						If This.is_Tipo_Venda = "VL" Then
							This.Vidalink.of_Retorno_Produto_Quantidade(Long(ls_Buffer))
						Else						
							This.PharmaSystem.of_Retorno_Produto_Quantidade(Long(ls_Buffer))
						End If
					End If
				End If				
			Case 1014 // Pre$$HEX1$$e700$$ENDHEX$$o PBM produto
				If This.is_Tipo_Venda = "FC" Then
					This.Funcional.of_Retorno_Produto_Preco_PBM(ls_Buffer)
				Else
					If This.is_Tipo_Venda = "VL" Then
						This.Vidalink.of_Retorno_Produto_Preco_PBM(ls_Buffer)
					End If					
				End If
			Case 1015 
				If This.is_Tipo_Venda = "VL" Then
					//This.Vidalink.of_Retorno_Produto_Preco_Avista(ls_Buffer)
				End If				
			Case 1016
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.of_Retorno_Produto_Preco_liquido(ls_Buffer)
				End If	
			Case 1017
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.of_Retorno_Produto_reembolso(ls_Buffer)
				End If													
			Case 1018
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.of_Retorno_Produto_reposicao(ls_Buffer)
				End If				
			Case 1019
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.of_Retorno_Produto_Subsidio(ls_Buffer)
				End If					
			Case 1020
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.cd_cnpj_convenio = Trim(ls_Buffer)
				End If									
			Case 1021
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.nr_comprovante = Trim(ls_Buffer)					
					//This.Vidalink.cd_plano = Trim(ls_Buffer)
				End If
			Case 1025
				If This.cd_funcao = 275 Or This.cd_funcao = 276 Then
					This.de_produto_gift = Trim(Upper(ls_Buffer))
				End If
			Case 1026 //EAN giftcard
				lvs_teste    	= ls_Buffer						
			Case 1028 //vl transacao giftcard
				This.vl_transacao    	= Dec(ls_Buffer)
				If This.cd_funcao = 275 Or This.cd_funcao = 276 Then
					//Venda PIN, confirma$$HEX2$$e700e300$$ENDHEX$$o de valor pelo operador. Existem produtos que n$$HEX1$$e300$$ENDHEX$$o trazem o valor na descri$$HEX2$$e700e300$$ENDHEX$$o
					//e n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o retornados em campos de intera$$HEX2$$e700e300$$ENDHEX$$o com o operador.
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Valor da Transa$$HEX2$$e700e300$$ENDHEX$$o R$ ' +String(This.vl_transacao, '0.00') + '~nProsseguir com Venda PIN?',Question!,YesNo!,1) = 2 Then
						ll_Continua = -1
						Continue
					End If					
				End If
			Case 1030 // TRNCentre - Pharmasystem - Funcional
				If Not IsNull(This.is_Tipo_Venda) And This.is_Tipo_Venda = "TRNCENTRE" Then
					This.TRNCentre.nr_Autorizacao = Trim(ls_Buffer)
				Else
					If This.is_Tipo_Venda = "FC" Then
						This.Funcional.nr_autorizacao = Trim(ls_Buffer)
					Else
						If This.is_Tipo_Venda = "VL" Then
							This.Vidalink.nr_autorizacao = Trim(ls_Buffer)
						Else
							This.PharmaSystem.nr_Autorizacao = Trim(ls_Buffer)
						End If
					End If
				End If
			Case 1033
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.of_Retorno_Produto_Preco_Avista(ls_Buffer)
				End If								
			Case 1034
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.de_teste = Trim(ls_Buffer)
				End If
			Case 1035
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.of_Retorno_Produto_pc_reposicao(ls_Buffer)
				End If				
			Case 1036
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.of_Retorno_Produto_pc_comissao(ls_Buffer)
				End If									
			Case 1037
				If This.is_Tipo_Venda = "VL" Then
					//This.Vidalink.nr_comprovante = Trim(ls_Buffer)
				End If								
			Case 1038
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.cd_conveniado = Trim(ls_Buffer)
				End If				
			Case 1039
				If This.is_Tipo_Venda = "VL" Then
					This.Vidalink.nm_conveniado = Trim(ls_Buffer)
				Else				
					This.PharmaSystem.nm_Conveniado  = Trim(ls_Buffer)				
				End If				
			Case 1044 // Preco praticado PBM
				If This.is_Tipo_Venda = "FC" Then
					This.Funcional.of_Retorno_Produto_preco_praticado(ls_Buffer)
				End If
			Case 1045 // TRNCentre - Pharmasystem - Funcional
				If Not IsNull(This.is_Tipo_Venda) And This.is_Tipo_Venda = "TRNCENTRE" Then
					This.TRNCentre.of_Retorno_Produto_Status(ls_Buffer)
				Else
					If This.is_Tipo_Venda = "FC" Then
						This.Funcional.of_Retorno_Produto_Status(ls_Buffer)
					Else															
						This.PharmaSystem.of_Retorno_Produto_Status(ls_Buffer)
					End If
				End If
			Case 1039
				This.PharmaSystem.nm_Conveniado  = Trim(ls_Buffer)				
			Case 1080 //cod fornecedor giftcard
				lvs_teste    	= ls_Buffer				
			Case 1160 //produto com valor face giftcard
				lvs_teste    	= ls_Buffer								
			Case 2982 // EAN VENDA PIN
				This.cd_ean_gift = Trim(ls_Buffer)
			Case 2971 // CAPTURA DADO ABERTO PINPAD
				This.de_dado_captura_pinpad = Trim(ls_Buffer)					
			Case 2972 // CONVENIO CARTEIRA DIGITAL
				lvs_Teste = Trim(ls_Buffer)	
			Case 3339
				If This.cd_funcao = 110 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Utilize a op$$HEX2$$e700e300$$ENDHEX$$o GIFTCARD tela principal do caixa!",Exclamation!)
					ll_Continua = -1
					Continue				
				End If
			Case 3345
				If This.cd_funcao = 110 And This.id_permite_cancelar_gift = False Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida!",Exclamation!)
					ll_Continua = -1
					Continue
				End If				
			Case 4004 //Total PBM
				If This.is_Tipo_Venda = "FC" Then
					This.Funcional.of_Retorno_autorizacao_Total(ls_Buffer)
				Else
					This.PharmaSystem.of_Retorno_Produto_Preco_Bruto(ls_Buffer)
				End If
			Case 4005  //Total a vista PBM
				If This.is_Tipo_Venda = "FC" Then
					This.Funcional.of_Retorno_autorizacao_total_avista(ls_Buffer)
				End If								
			Case 4006 //Total cartao PBM (total pago pelo convenio)
				If This.is_Tipo_Venda = "FC" Then
					This.Funcional.of_Retorno_autorizacao_total_cartao(ls_Buffer)
				End If				
			Case 4008 // TRNCentre - Pharmasystem - Funcional
				If Not IsNull(This.is_Tipo_Venda) And This.is_Tipo_Venda = "TRNCENTRE" Then			
					This.TRNCentre.of_Retorno_Produto_Desconto(ls_Buffer)
				Else
					If This.is_Tipo_Venda = "FC" Then
						This.Funcional.of_Retorno_Produto_Desconto(ls_Buffer)
					Else																				
						This.PharmaSystem.of_Retorno_Produto_Desconto(ls_Buffer)
					End If
				End If
			Case 4014 //Dados Complementares Coletados TRNCentre
				If This.cd_Funcao = 590 Then
					This.TRNCentre.de_Dados_Complementares = Trim(ls_Buffer)
				Else
					If Not IsNull(This.TRNCentre.de_Dados_Complementares) Then
						ls_Buffer = This.TRNCentre.de_Dados_Complementares
					End If
				End If	
			Case 4016 //Pre$$HEX1$$e700$$ENDHEX$$o Bruto - PBM
				If Not IsNull(This.is_Tipo_Venda) And This.is_Tipo_Venda = "TRNCENTRE" Then				
					This.TRNCentre.of_Retorno_Produto_Preco_Bruto(ls_Buffer)
				Else
					This.Funcional.of_Retorno_Produto_Preco_Bruto(ls_Buffer)					
				End If				
			Case 4017 //Pre$$HEX1$$e700$$ENDHEX$$o Liquido - PBM
				If Not IsNull(This.is_Tipo_Venda) And This.is_Tipo_Venda = "TRNCENTRE" Then			
					This.TRNCentre.of_Retorno_Produto_Preco_Liquido(ls_Buffer)
				Else
					If This.is_Tipo_Venda = "FC" Then
						This.Funcional.of_Retorno_Produto_Preco_Liquido(ls_Buffer)
					Else																									
						This.PharmaSystem.of_Retorno_Produto_Preco_Liquido(ls_Buffer)
					End If
				End If
			Case 4018 //Valor a receber da Loja
				If Not IsNull(This.is_Tipo_Venda) And This.is_Tipo_Venda = "TRNCENTRE" Then			
					This.TRNCentre.of_Retorno_Produto_Valor_Subsidio(ls_Buffer)
				End If				
				If Not IsNull(This.is_Tipo_Venda) And This.is_Tipo_Venda = "FC" Then
					This.Funcional.of_Retorno_Produto_Valor_Subsidio(ls_Buffer)
				End If				
			Case 4023
				This.PharmaSystem.nm_Operadora   = Trim(ls_Buffer)
			Case 4024
				If This.is_Tipo_Venda = "FC" Then
					This.Funcional.de_operadora		= Trim(ls_Buffer)
				Else					
					This.PharmaSystem.nm_Empresa     = Trim(ls_Buffer)
				End If				
			Case 4025
				This.PharmaSystem.qt_Dependentes = Long(ls_Buffer)
			Case 4026
				This.PharmaSystem.cd_Dependente  = Trim(ls_Buffer)
			Case 4027
				This.PharmaSystem.nm_Dependente  = Trim(ls_Buffer)
			Case 4028				
				This.PharmaSystem.of_Retorno_Produto_Valor_Receber(ls_Buffer)
			Case 4029 //Valor total desconto transacao
				If This.is_Tipo_Venda = "FC" Then				
					This.Funcional.of_retorno_autorizacao_desconto(ls_Buffer)
				End If
				This.vl_desconto_carteira = Dec(ls_Buffer)/100
			Case 4031 //C$$HEX1$$f300$$ENDHEX$$digo da Operadora Selecionada TRNCentre
				If This.cd_Funcao = 590 Then
					This.TRNCentre.Cd_Operadora = Trim(ls_Buffer)
				Else
					If Not IsNull(This.TRNCentre.Cd_Operadora) Then
						ls_Buffer = This.TRNCentre.Cd_Operadora
					End If
				End If
				If This.is_Tipo_Venda = "FC" Then 
					This.Funcional.Cd_Operadora = Trim(ls_Buffer)
				End If
			Case 4058 // VALOR PRODUTO APROVADO
				lvs_Teste = Trim(ls_Buffer)				
			Case 4077 //NSU_FEPAS - nsu_host da carteira digital (ITI)
				This.nr_nsu_fepas = RightA(Trim(ls_Buffer), 12)
			Case 4128 // MENSAGEM RODAPE
				lvs_Teste = Trim(ls_Buffer)
			Case 4153//codigo PSP carteira digital
				This.cd_instituicao_financeira = Trim(ls_Buffer)
			Case Else
				ll_ProximoComando = ll_ProximoComando
				
		End Choose
		
		If Not IsNull( This.nr_nsu_host) Then
			If IsNull(This.cd_autorizadora) Then 
				ls_autorizadora = ''
			Else
				ls_autorizadora = This.cd_autorizadora
			End If
			If IsNull( This.de_bandeira ) Then
				ls_bandeira = ''
			Else
				ls_bandeira = This.de_bandeira
			End If
			gvo_Aplicacao.of_Grava_Log("uo_sitef - of_controla_interacao_dll - Transa$$HEX2$$e700e300$$ENDHEX$$o TEF em curso. Transacao: [" + String(This.nr_autorizacao) + "] NSU: [" + String(This.nr_nsu_host) + "] Autorizadora: [" + ls_autorizadora + "] Bandeira: [" + ls_bandeira + "]"  )
		End If
		
	End If
		
Loop Until This.id_Status <> 10000

//gvo_Aplicacao.of_grava_log( "TERMINO INTERACAO TEF **************")			

Long ll_Pos

ll_Pos = PosA(This.de_via_cliente, This.nr_cartao)
	
If ll_Pos > 0 Then
	This.de_via_cliente = MidA(This.de_via_cliente, 1, ll_Pos + 5) + "******" + &
								 MidA(This.de_via_cliente, ll_Pos + 12, 4) + MidA(This.de_via_cliente, ll_Pos + 22)
	
	This.de_via_caixa = MidA(This.de_via_caixa, 1, ll_Pos + 5) + "******" + &
							  MidA(This.de_via_caixa, ll_Pos + 12, 4) + MidA(This.de_via_caixa, ll_Pos + 22)
								 
	This.nr_cartao    = MidA(This.nr_cartao, 1, 6)
Else
	If Retaguarda Then 
		This.nr_cartao    = This.nr_bin_cartao	
	Else
		//Transaca$$HEX1$$e700$$ENDHEX$$oes de cartao com funcional n$$HEX1$$e300$$ENDHEX$$o gravava o nr cartao correto.
		If This.Funcional.ds_Autorizacao.RowCount() > 0 Then					
			If This.cd_Funcao = 1 Or This.cd_Funcao = 2 Or This.cd_Funcao = 3 Then			
				This.nr_cartao    = This.nr_bin_cartao	
			End If
		End If
	End If
End If

If IsValid(w_ge084_aguarde) Then Close(w_ge084_aguarde)

//Verifica N$$HEX1$$fa00$$ENDHEX$$mero de Transa$$HEX2$$e700f500$$ENDHEX$$es Pendentes
ll_Pendentes = of_Verifica_Transacao_Pendente_Servidor()
If IsNull(ll_Pendentes) Then	ll_Pendentes = 0

If IsNull( This.de_bandeira ) Then
	ls_bandeira = ''
Else
	ls_bandeira = This.de_bandeira
End If

gvo_Aplicacao.of_Grava_Log("uo_sitef - of_controla_interacao_dll - Saida da intera$$HEX2$$e700e300$$ENDHEX$$o da dll. Id_status: ["+ String(This.id_Status) +"] " + "Pendentes TEF: " + String(ll_Pendentes) + " Bandeira: [" + ls_Bandeira + "]")

If This.id_Status = 0 Then
	
	//Registra Transa$$HEX2$$e700e300$$ENDHEX$$o se necess$$HEX1$$e100$$ENDHEX$$rio para confirma$$HEX2$$e700e300$$ENDHEX$$o ou cancelamento
	If Not This.of_registra_transacao_tef_pendente() Then
		This.of_Cancela_Transacao(False)
		gvo_Aplicacao.of_Grava_Log("uo_sitef - of_controla_interacao_dll - Transa$$HEX2$$e700e300$$ENDHEX$$o TEF cancelada. Transacao: [" + String(This.nr_autorizacao) + "] NSU: [" + String(This.nr_nsu_host) + "]")
		lb_Sucesso = False		
	Else
		gvo_Aplicacao.of_Grava_Log("uo_sitef - of_controla_interacao_dll - Transa$$HEX2$$e700e300$$ENDHEX$$o TEF registrada. Transacao: [" + String(This.nr_autorizacao) + "] NSU: [" + String(This.nr_nsu_host) + "]")
		lb_Sucesso = True
	End If

	//A funcao TRN 592(sem pre-aut.) sempre traz -100 no status, mesmo a operacao estando Ok
	//Neste caso verificamos tamb$$HEX1$$e900$$ENDHEX$$m a mensagem do operador, nos casos abaixo a operacao esta OK.
	//Aqui acerto o status do TRN.
//	If This.cd_funcao = 592 And (This.msg_operador = "Transacao OK" or This.msg_operador = "W809-Desc especial p/altera remova total" or This.msg_operador = "W809-Venda c/ desconto especial prossiga") Then	
	If This.cd_funcao = 592 And (This.msg_operador = "Transacao OK" or PosA(Trim(This.msg_operador), "W809-", 1) > 0) Then
		This.TrnCentre.Id_Status = "00"
	End If
		
	//Pagamento Cart$$HEX1$$e300$$ENDHEX$$o Cr$$HEX1$$e900$$ENDHEX$$dito ou D$$HEX1$$e900$$ENDHEX$$bito
	If This.TrnCentre.Id_Status <> "00" and ( This.cd_funcao = 2 or This.cd_funcao = 3 ) Then
		If ll_Pendentes > 1 Then
			This.of_Cancela_Transacao(False)
			gvo_Aplicacao.of_Grava_Log("uo_sitef - of_controla_interacao_dll - Transa$$HEX2$$e700e300$$ENDHEX$$o TEF cancelada. Transacao: [" + String(This.nr_autorizacao) + "] NSU: [" + String(This.nr_nsu_host) + "]")
			lb_Sucesso = False
		End If
	End If
	
Else

	If This.TrnCentre.Id_Status <> "00" and ll_Pendentes >= 1 Then
		This.of_registra_transacao_tef_pendente()
		This.of_Cancela_Transacao(False)
	End If
	
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_controla_interacao_dll - Transa$$HEX2$$e700e300$$ENDHEX$$o TEF cancelada. Transacao: [" + String(This.nr_autorizacao) + "] NSU: [" + String(This.nr_nsu_host) + "]")
	
	This.vl_total_transacao -= This.vl_transacao
	SetNull(This.dt_predatado)
	lb_Sucesso = False
	
	 //Acerto TRNCentre - Est$$HEX1$$e100$$ENDHEX$$ OK, por$$HEX1$$e900$$ENDHEX$$m, o status $$HEX1$$e900$$ENDHEX$$ negativo
	If This.cd_Funcao = 590 Then
		If Not IsNull(This.TRNCentre.Cd_Operadora) Then
			lb_Sucesso = True
		End If
	ElseIf This.cd_Funcao = 591 Then
		If PosA(Trim(ls_Buffer), "W603-", 1) > 0 Then
		//If Trim(ls_Buffer) = "W603-Selecione produtos" Then
			lb_Sucesso = True
		End If
//	ElseIf This.cd_Funcao = 593 Then
//		If Pos(Trim(ls_Buffer), "W599-", 1) > 0 Then
//			lb_Sucesso = True
//		End If
	End If	
	
End If

If Not lb_Sucesso Then
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_controla_interacao_dll - Erro na execu$$HEX2$$e700e300$$ENDHEX$$o da fun$$HEX2$$e700e300$$ENDHEX$$o SITEF. Fun$$HEX2$$e700e300$$ENDHEX$$o: " + String(This.cd_Funcao) + "~rStatus: " + String(This.id_Status) + "~rBuffer: " + Trim(ls_Buffer))
End If

Return lb_Sucesso
end function

public subroutine of_verifica_bin_generico (string ps_bin);If This.ConsultaBin Then Return

Long 	ll_Parcelas_Gen
String	ls_Bandeira_Gen, ls_BIN

ls_BIN = ps_bin

Select qt_parcelas, nm_produto
  Into :ll_Parcelas_Gen, :ls_Bandeira_Gen
From bins_genericos
Where nr_cartao = Cast(:ls_BIN As VarChar)
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,'Localiza$$HEX2$$e700e300$$ENDHEX$$o do Bin Generico:' + ps_bin)
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o da Bin Generico.')
End If
		
If Sqlca.Sqlcode = 0 Then
	This.de_bandeira_gen = Trim(ls_Bandeira_Gen)
	This.qt_parcelas_gen = ll_Parcelas_Gen
End If

This.ConsultaBin = True

Return
end subroutine

public function boolean of_impressao_comprovante_bkp ();String	ls_Linha,&
		ls_Comprovante,&
		ls_Resposta, &
		ls_Where
	
Long    	ll_Row	
Long    	ll_Byte
Long    	ll_Via
Long		ll_Retrieve

Boolean	lb_Impressao ,&
			lb_Abertura  ,&
			lb_Tentar
		
dc_uo_ds_base lds_1
lds_1 = Create dc_uo_ds_base

If Not lds_1.of_ChangeDataObject('dw_ge084_transacao_tef') Then 
	Destroy lds_1
	Return False
End If
//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas com cupom fiscal impresso que precisam ser confirmadas
//lds_1.of_RestoreSqlOriginal()
ls_Where = "id_situacao <> 'C' and nr_ecf = " + String(This.nr_ecf) + " and nr_coo_ecf = " + String(This.nr_cupom) + " and (cd_forma_pagamento in ('01', '02', '03') Or cd_funcao in (300,110))"
lds_1.of_AppendWhere( ls_Where )

ll_Retrieve = lds_1.Retrieve()

Reinicia_impressao:
ll_Row = 0

For ll_Row = 1 To lds_1.RowCount()
	ls_comprovante = ''

	//For ll_Row = 1 To lds_1.RowCount()
		
		If Not IsNull(lds_1.object.de_via_cliente[ll_Row]) Then
			ls_Comprovante += lds_1.object.de_via_cliente[ll_Row]
			If This.cd_funcao = 300 Then
				ls_Comprovante += CharA(10) + "											"
				If IsNull(PDV.ivs_Tipo_Venda) Or PDV.ivs_Tipo_Venda <> "TR" Then				
					ls_Comprovante += CharA(10) + " - - - - - - - - - - - - - - recorte - - 8< - -"
				End If
				ls_Comprovante += CharA(10) + "                                 " + CharA(10)
				ls_Comprovante += lds_1.object.de_via_cliente[ll_Row]
			End If	
		End If
		
	//Next
				  
	lb_Impressao = True
	
	If IsNull(ls_Comprovante) Then ls_Comprovante = ""
	
	//For ll_Row = 1 To lds_1.RowCount()
	
		If Not IsNull(lds_1.object.de_via_caixa[ll_Row]) Then
			
			If ls_Comprovante <> "" Then
				ls_Comprovante += CharA(10) + "											"
				If IsNull(PDV.ivs_Tipo_Venda) Or PDV.ivs_Tipo_Venda <> "TR" Then								
					ls_Comprovante += CharA(10) + " - - - - - - - - - - - - - - recorte - - 8< - -"
				End If 
				ls_Comprovante += CharA(10) + "                                 " + CharA(10)
			End If	
		
			ls_Comprovante += lds_1.object.de_via_caixa[ll_Row]
			
			ls_Comprovante += CharA(10) + "											"
			ls_Comprovante += CharA(10) + "                                 " + CharA(10)
		
		End If
		
	//Next	
	
	If IsNull(ls_Comprovante) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Comprovante n$$HEX1$$e300$$ENDHEX$$o foi retornado para impress$$HEX1$$e300$$ENDHEX$$o.",Exclamation!)
		Return False
	End If
	
	This.vl_Transacao 		= lds_1.object.vl_transacao			[ll_Row]
	This.cd_forma_pagamento = lds_1.object.cd_forma_pagamento	[ll_Row]
	
	//Voucher GoodCard - Muda para credito
	If This.cd_forma_pagamento = '03' Then This.cd_forma_pagamento = '02'
	
	lb_Impressao = True
	
	Do While True
		
		If IsValid(w_ge084_processando) Then CLOSE(w_ge084_processando)
		 
/*		IF NOT lb_Impressao THEN
			 
			IF Of_Continua_Impressao_Comprovante() THEN
				lb_Tentar = TRUE
			ELSE
				RETURN FALSE
			END IF
			 
			IF NOT PDV.of_Fecha_Comprovante_Tef() THEN CONTINUE
			 
			lb_Impressao = TRUE
			 
		END IF
		 
		IF NOT of_inicializa_comprovante_tef(lb_Tentar) THEN
			If This.cd_funcao = 300 Then Return False //Recarga, senao saiu comprovante cancela transacao.
			lb_Impressao = FALSE
			EXIT
		END IF   */
		
		If Not Gerencial Then		
			IF NOT of_inicializa_comprovante_tef(lb_Tentar) THEN
				If This.cd_funcao = 300 And Not Comprovante_Nao_Fiscal Then Return False				
			Tenta_Iniciar:			
				If Not of_pergunta_tentativa(true,Gerencial) Then				
					If This.cd_funcao = 110 And PosA(Trim(Upper(This.de_cancelamento)), "CANCELAMENTO") > 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700e300$$ENDHEX$$o TEF efetuada. Favor re-imprimir $$HEX1$$fa00$$ENDHEX$$ltimo comprovante.",Exclamation!)
						Exit
					Else
						RETURN FALSE				
					End If
				Else
					If Not of_inicializa_comprovante_tef(lb_Tentar) Then Goto Tenta_Iniciar	
				End If
			END IF 
		Else
			If ll_Row = 1 Then
				IF NOT of_inicializa_comprovante_tef(lb_Tentar) THEN
					If This.cd_funcao = 300 And Not Comprovante_Nao_Fiscal Then Return False					
				Tenta_Iniciar2:			
					If Not of_pergunta_tentativa(true,Gerencial) Then				
						If This.cd_funcao = 110 And PosA(Trim(Upper(This.de_cancelamento)), "CANCELAMENTO") > 0 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700e300$$ENDHEX$$o TEF efetuada. Favor re-imprimir $$HEX1$$fa00$$ENDHEX$$ltimo comprovante.",Exclamation!)							
							Exit
						Else
							RETURN FALSE				
						End If
					Else
						If Not of_inicializa_comprovante_tef(lb_Tentar) Then Goto Tenta_Iniciar2	
					End If
				END IF 	
			End If
		End If		
	 
		ll_Via = 1
	 
		Do While ll_Via <= This.nr_vias_comprovante_tef
			
			ls_Linha = ''
			 
			For ll_Byte = 1 TO LenA(ls_Comprovante)
				
/*				If Mid(ls_Comprovante,ll_Byte,1) = Char(10) Then
					If Not IsNull(ls_Linha) and Trim(ls_Linha) <> "" Then
						If Not PDV.of_texto_nao_fiscal_tef(ls_Linha) Then 
							lb_Impressao = False
							Exit
						End If
					End If
					ls_Linha = ''
					Continue
				End If	*/
				
				If MidA(ls_Comprovante,ll_Byte,1) = CharA(10) Then
					If Not IsNull(ls_Linha) and Trim(ls_Linha) <> "" Then
						//Verificacao se $$HEX1$$e900$$ENDHEX$$ impressao em Relatorio gerencial ou comprovante tef.
						If Not Gerencial Then
							If Not PDV.of_texto_nao_fiscal_tef(ls_Linha) Then 
								If Not of_pergunta_tentativa(False,Gerencial) Then				
									If This.cd_funcao = 110 And PosA(Trim(Upper(This.de_cancelamento)), "CANCELAMENTO") > 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700e300$$ENDHEX$$o TEF efetuada. Favor re-imprimir $$HEX1$$fa00$$ENDHEX$$ltimo comprovante.",Exclamation!)
										Exit
									Else
										RETURN FALSE							
									End If
								Else
									Goto Reinicia_impressao
								End If
							End If
						Else
							If Not PDV.of_texto_relatorio_gerencial(ls_Linha) Then 
								If Not of_pergunta_tentativa(False,Gerencial) Then				
									If This.cd_funcao = 110 And PosA(Trim(Upper(This.de_cancelamento)), "CANCELAMENTO") > 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700e300$$ENDHEX$$o TEF efetuada. Favor re-imprimir $$HEX1$$fa00$$ENDHEX$$ltimo comprovante.",Exclamation!)										
										Exit
									Else
										RETURN FALSE							
									End If					
								Else
									Goto Reinicia_impressao
								End If
							End If							
						End If
					End If
					ls_Linha = ''
					Continue
				End If				
				
				If Not lb_Impressao Then Exit
	
				ls_Linha += MidA(ls_Comprovante,ll_Byte,1)
				 
			Next
			
			ll_Via ++
			
			If Not lb_Impressao Then Exit
			
			If ll_Via <= This.nr_vias_comprovante_tef Then
			
				ls_Linha = "- - - - - - - - - - (" + String(ll_Via,'00') + " via) - - - - - - - - -"
				
				If Not Gerencial Then			
					If Not PDV.of_texto_nao_fiscal_tef(ls_Linha) Then lb_Impressao = False
				Else
					If Not PDV.of_texto_relatorio_gerencial(ls_Linha) Then lb_Impressao = False
				End If
								
				ls_Linha = ""
				
			End If
			 
		Loop
	 
		If Not lb_Impressao Then Continue	

		If Not Gerencial Then 
			If Not PDV.of_Fecha_Comprovante_Tef() Then
				Gerencial = True
				Goto Reinicia_impressao				
//				lb_Impressao = False
//				Continue
			End If
		Else
			If ll_Row = lds_1.RowCount() Then
				If Not PDV.of_Fecha_Relatorio_Gerencial(True) Then					
					lb_Impressao = False
					Continue
				End If			
			End If
		End If
		 
		//****Retirado 28/02/2013 **** s$$HEX1$$f300$$ENDHEX$$ checa ao status da impressora, nao $$HEX1$$e900$$ENDHEX$$ mais necess$$HEX1$$e100$$ENDHEX$$rio. 
//		If Not PDV.Of_Aguarda_Execucao_Comando_Tef() Then
//			lb_Impressao = False
//			Continue
//			Gerencial = True
//			Goto Reinicia_impressao			
//		End If
		 
		Exit
		 
	Loop
Next 

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas de PBMs - Lucian 17/05/2011
//If Not lds_1.of_ChangeDataObject('ds_ge084_transacao_tef') Then Return False

lds_1.of_RestoreSqlOriginal()
lds_1.Reset()
ls_Where  = "id_situacao <> 'C' and nr_ecf = " + String( This.nr_ecf ) + " and nr_coo_ecf = " + String( This.nr_cupom )
lds_1.of_AppendWhere( ls_Where )

ll_Retrieve = lds_1.Retrieve()

If lds_1.RowCount() > 0 Then
	lb_Impressao = TRUE
End If

If IsValid(w_ge084_processando) Then CLOSE(w_ge084_processando)


If lb_Impressao Then	of_Registra_Impressao_Comprovante()

If IsValid( lds_1 ) Then Destroy lds_1
GarbageCollect()

//Cancelamento TRN New
If ls_Comprovante = "" Then
	If Not of_Impressao_Cancelamento_Pbm() Then
		lb_Impressao = False
	End If
End If

Return lb_Impressao
end function

public function boolean of_funcional_cancelar_venda (datetime adata, string aoperador, long aecf, string acaixa, long acontrole_caixa);
Boolean  lb_Sucesso

Long     ll_ecf 
Long     ll_cupomfiscal
String   ls_restricao

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
This.cd_funcao    = 562
This.nr_cupom     = ll_CupomFiscal
This.dt_transacao = gf_getserverdate()
This.vl_transacao = 000.00
This.de_operador  = aoperador
This.de_restricao = ls_restricao
This.nr_ecf       		= aecf
This.cd_caixa          	= acaixa
This.nr_controle_caixa 	= acontrole_caixa

is_Tipo_Venda = "FC"

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
	
	If lb_Sucesso Then
		lb_Sucesso = This.of_Finaliza_Transacao(This.ib_NFCE, This.nr_nf)
	End If 
End If

Return lb_Sucesso
end function

public function boolean of_funcional_finaliza_venda (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
Long    ll_CodigoResposta
Long	  ll_Row

String  ls_Status
String  ls_teste1
String  ls_teste2

Boolean lb_Sucesso

If Trim(This.Funcional.nr_Autorizacao) <> "" And Not IsNull(This.Funcional.nr_Autorizacao) Then
	This.cd_Funcao = 561
Else
	//Sem pr$$HEX1$$e900$$ENDHEX$$-autoriza$$HEX2$$e700e300$$ENDHEX$$o
	Return False
End If

This.nr_ecf            = aecf
This.nr_cupom          = acupomfiscal
This.dt_transacao      = gf_getserverdate()
This.vl_transacao      = 000.00
This.de_operador       = aoperador
This.de_restricao      = ''
This.cd_caixa          = acaixa
This.nr_controle_caixa = acontrole_caixa


If This.Funcional.ds_Autorizacao.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ produtos para efetuar consulta de autoriza$$HEX2$$e700e300$$ENDHEX$$o.",Exclamation!)
	Return False
End If	

is_Tipo_Venda = "FC"

Open(W_ge084_Aguarde)
w_ge084_Aguarde.wf_Mensagem("Efetuando Autoriza$$HEX2$$e700e300$$ENDHEX$$o Funcional Card")



ls_teste1 = String(Funcional.ivl_enviados)
ls_teste2 = String(Funcional.ds_autorizacao.rowcount())

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
	
	ls_teste1 = String(Funcional.ivl_enviados)
	ls_teste2 = String(Funcional.ds_autorizacao.rowcount())		
	
	If not lb_Sucesso and Funcional.ivl_enviados > 0 Then			
		This.Funcional.ivl_enviados --
	End If
	If lb_Sucesso Then
		Funcional.nr_nsu_host = This.nr_nsu_host
	End If
	
End If

SetNull(is_Tipo_Venda)

If IsValid(w_ge084_Aguarde) Then Close(w_ge084_Aguarde)

Return lb_Sucesso
end function

public function boolean of_transacao_funcional_tef (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
String  ls_restricao = ""

Boolean lb_Sucesso = False

If Not of_Verifica_Dll() Then Return False

This.cd_funcao 			= 560
This.nr_ecf            	= aecf
This.nr_cupom          	= acupomfiscal
This.dt_transacao      	= gf_getserverdate()
This.vl_transacao      	= 000.00
This.de_operador       	= aoperador
This.de_restricao      	= ls_restricao
This.cd_caixa          	= acaixa
This.nr_controle_caixa 	= acontrole_caixa
This.Funcional.ivl_Enviados = 0

This.is_Tipo_Venda = "FC"

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()	
	
	If lb_Sucesso Then This.Funcional.Id_Status = String(This.Id_Status,'00')
	
End If 

SetNull(is_Tipo_Venda)

Return lb_Sucesso
end function

public function boolean of_localiza_nfce (datetime adata, string ps_serie, string ps_especie, long pl_nfce);Long     ll_sequencial

Long ll_Filial

DateTime ldt_Movimento

//ldt_Movimento = DateTime(Date(adata))
ldt_Movimento = DateTime(RelativeDate(date(adata),-2))
	
Select cd_filial
  Into :ll_Filial
From nf_venda
Where dh_movimentacao_caixa >= :ldt_Movimento
  and de_especie        			 = :ps_especie
  and de_serie						 = :ps_serie
  and nr_nf					 	    = :pl_nfce
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,'Localiza$$HEX2$$e700e300$$ENDHEX$$o da Nota Fiscal. Data:' + String(ldt_Movimento,'dd/mm/yyyy') + ' Especie:' + ps_especie + 'Serie:' + ps_serie + ' NF:' + String(pl_nfce))
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o da Nota Fiscal.')
	Return False
End If
		
If Sqlca.Sqlcode = 100 Then
	Return False
End If
	
Return True
end function

public function boolean of_localiza_nfce (long afuncao, datetime adata, long aecf, long anf, ref long afilial, ref long adoc, ref string aespecie, ref string aserie);Long     ll_sequencial

DateTime ldt_Movimento

If afuncao = 300 Or afuncao = 301 or afuncao = 124 &
 or afuncao = 261 Or afuncao = 264 Or afuncao = 265 Or afuncao = 269 Or afuncao = 275 Or afuncao = 276 Then
	SetNull(afilial)
	SetNull(adoc)
	SetNull(aespecie)
	SetNull(aserie)
	Return True	
End If

ldt_Movimento = DateTime(RelativeDate(date(adata),-2))
//ldt_Movimento = DateTime(Date(adata))
	
Select cd_filial,nr_nf,de_especie,de_serie
  Into :afilial,:adoc,:aespecie,:aserie
From nf_venda
Where dh_movimentacao_caixa >= :ldt_Movimento
  and nr_ecf        			 = :aecf
  and nr_nf 	    				 = :anf
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,'Localiza$$HEX2$$e700e300$$ENDHEX$$o do Cupom Fiscal. Data:' + String(ldt_Movimento,'dd/mm/yyyy') + ' ECF:' + String(aecf,'000') + 'NF:' + String(anf,'00000000') )
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o da Cupom Fiscal.')
	Return False
End If
		
If Sqlca.Sqlcode = 100 Then
	SetNull(afilial)
	SetNull(adoc)
	SetNull(aespecie)
	SetNull(aserie)	
End If
	
Return True
end function

public function boolean of_epharma_autorizacao (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa, string ps_tipo_venda);
Long    ll_CodigoResposta
Long    ll_Indice
Long	  ll_Row

String  ls_Status

Boolean lb_Sucesso

This.cd_Funcao         = 240
This.nr_ecf            = aecf
This.nr_cupom          = acupomfiscal

If ps_tipo_venda = 'CF' Then
	This.nr_cupom = acupomfiscal
Else
	This.nr_cupom = Long(RightA(This.ePharma.nr_Autorizacao,6))
End If			

This.dt_transacao      = gf_getserverdate()
This.vl_transacao      = 000.00
This.de_operador       = aoperador
This.de_restricao      = ''
This.cd_caixa          = acaixa
This.nr_controle_caixa = acontrole_caixa

If This.ePharma.ds_Autorizacao.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ produtos para efetuar consulta de autoriza$$HEX2$$e700e300$$ENDHEX$$o.",Exclamation!)
	Return False
End If	

If This.ePharma.ds_Autorizacao.RowCount() > 10 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de produtos excede limite para consultas (limite m$$HEX1$$e100$$ENDHEX$$ximo de 10 produtos).",Exclamation!)
	Return False
End If	

Open(W_ge084_Aguarde)
w_ge084_Aguarde.wf_Mensagem("Efetuando Autoriza$$HEX2$$e700e300$$ENDHEX$$o e-Pharma")

ll_Indice = 1

//Transa$$HEX2$$e700e300$$ENDHEX$$o e-Pharma
If of_Sitef_Direto_Parametro(ll_Indice,'27',0,0) = 0 Then

	ll_Indice ++

	//Consulta autoriza$$HEX2$$e700e300$$ENDHEX$$o com produto
	If of_Sitef_Direto_Parametro(ll_Indice,'2',0,0) = 0 Then
					
		ll_Indice ++
		
		//Autoriza$$HEX2$$e700e300$$ENDHEX$$o ePharma
		If of_Sitef_Direto_Parametro(ll_Indice,This.ePharma.nr_Autorizacao,0,0) = 0 Then
			
			ll_Indice ++
			
			//Cupom
			If of_Sitef_Direto_Parametro(ll_Indice,String(This.nr_Cupom,'00000000'),0,0) = 0 Then
					
				//Dados dos Produtos
				If of_ePharma_Parametro_Produto(ll_Indice) Then
									
					ll_Indice ++
											
					//Executa Solicita$$HEX2$$e700e300$$ENDHEX$$o de Consulta Produtos
					If of_Sitef_Direto_Executa(62, This.Cd_Funcao, Ref ll_CodigoResposta, 60, String(This.nr_Cupom,'00000000'), String(This.dt_Transacao,'yyyymmdd'), String(This.dt_Transacao,'hhmmss'), '', 1) = 0 Then
//					If of_Sitef_Direto_Executa(62, This.Cd_Funcao, Ref ll_CodigoResposta, 60, String(This.nr_Cupom,'00000000'), String(This.dt_Transacao,'yyyymmdd'), String(This.dt_Transacao,'hhmmss'), This.de_operador, 1) = 0 Then						
					
						//Obtem Retorno Sitef
						If of_Sitef_Direto_Retorno() Then
						
							If Sitef.ePharma.of_Retorno_Autorizacao(ds_Servico) Then
							
								If Sitef.ePharma.Id_Status = '00' Then
									
									//Registra Transa$$HEX2$$e700e300$$ENDHEX$$o se necess$$HEX1$$e100$$ENDHEX$$rio para confirma$$HEX2$$e700e300$$ENDHEX$$o ou cancelamento
									If Not This.of_registra_transacao_tef_pendente() Then
										This.of_Cancela_Transacao(False)
										lb_Sucesso = False
									Else
										lb_Sucesso = True
									End If
									
								End If	
								
							End If	
															
						End If			
						
					End If
					
				End If	

			End If
			
		End If	
		
	End If
	
End If	

If IsValid(w_ge084_Aguarde) Then Close(w_ge084_Aguarde)

Return lb_Sucesso
end function

public function boolean of_trncentre_autorizacao_new (long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa, string ps_tipo_venda);
Long    ll_CodigoResposta
Long	  ll_Row

String  ls_Status
String  ls_teste1
String  ls_teste2
Long ll_cupom

Boolean lb_Sucesso

If Trim(This.TRNCentre.nr_Autorizacao) <> "" And Not IsNull(This.TRNCentre.nr_Autorizacao) Then
//If Dec(This.TRNCentre.nr_Autorizacao) > 0 And Not IsNull(This.TRNCentre.nr_Autorizacao) Then
	//Com pr$$HEX1$$e900$$ENDHEX$$-autoriza$$HEX2$$e700e300$$ENDHEX$$o
	This.cd_Funcao = 593
Else
	//Sem pr$$HEX1$$e900$$ENDHEX$$-autoriza$$HEX2$$e700e300$$ENDHEX$$o
	This.cd_Funcao = 592
End If

If ps_tipo_venda = 'CF' Then
	ll_cupom = acupomfiscal
Else
	ll_cupom = Long(RightA(This.TRNCentre.nr_Autorizacao,6))
End If			
This.nr_ecf            = aecf
This.nr_cupom          = ll_cupom //acupomfiscal
This.dt_transacao      = gf_getserverdate()
This.vl_transacao      = 000.00
This.de_operador       = aoperador
This.de_restricao      = ''
This.cd_caixa          = acaixa
This.nr_controle_caixa = acontrole_caixa


If This.TrnCentre.ds_Autorizacao.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ produtos para efetuar consulta de autoriza$$HEX2$$e700e300$$ENDHEX$$o.",Exclamation!)
	Return False
End If	

/*If This.TrnCentre.ds_Autorizacao.RowCount() > 10 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de produtos excede limite para consultas (limite m$$HEX1$$e100$$ENDHEX$$ximo de 10 produtos).",Exclamation!)
	Return False
End If	*/

is_Tipo_Venda = "TRNCENTRE"

Open(W_ge084_Aguarde)
w_ge084_Aguarde.wf_Mensagem("Efetuando Autoriza$$HEX2$$e700e300$$ENDHEX$$o TRNCentre")

//Do While This.trnCentre.ivl_enviados < This.trnCentre.ds_autorizacao.rowcount() 

	ls_teste1 = String(trnCentre.ivl_enviados)
	ls_teste2 = String(trnCentre.ds_autorizacao.rowcount())
	
	If This.of_Inicia_Funcao_Tef() Then
		//Carga das operadoras
		lb_Sucesso = This.of_Controla_Interacao_dll()
		
		ls_teste1 = String(trnCentre.ivl_enviados)
		ls_teste2 = String(trnCentre.ds_autorizacao.rowcount())		
		
		If not lb_Sucesso and trnCentre.ivl_enviados > 0 Then			
			This.trnCentre.ivl_enviados --
		End If 
		
	End If

//Loop

SetNull(is_Tipo_Venda)

If IsValid(w_ge084_Aguarde) Then Close(w_ge084_Aguarde)

Return lb_Sucesso
end function

public function boolean of_cancela_transacao (boolean pb_nfce, long pl_nr_nf, boolean pb_mostra_resumo);This.ib_NFCE 	= pb_nfce
If IsNull(pl_nr_nf) Then
	This.nr_nf		= 0
Else
	This.nr_nf		= pl_nr_nf	
End If

Return This.of_Cancela_Transacao(pb_mostra_resumo)
end function

public function boolean of_transacao_pendente_caixa (string ps_caixa, long pl_nf, string ps_especie, string ps_serie, boolean pb_nfce);String ls_Situacao 

Long ll_Coo, ll_ecf

dc_uo_ds_base lds_Transacao_Pendente_Caixa
lds_Transacao_Pendente_Caixa = Create dc_uo_ds_base

If Not lds_Transacao_Pendente_Caixa.of_ChangeDataObject('ds_ge084_transacao_tef') Then Return False

This.ib_NFCE = pb_NFCE

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas com cupom fiscal impresso que precisam ser confirmadas
lds_Transacao_Pendente_Caixa.of_RestoreSqlOriginal()
lds_Transacao_Pendente_Caixa.of_AppendWhere("cd_caixa = '" + ps_caixa + "' and id_situacao <> 'E'")

lds_Transacao_Pendente_Caixa.Retrieve()

If lds_Transacao_Pendente_Caixa.RowCount() = 0 Then
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_transacao_pendente_caixa - Nenhuma transacao tef pendente foi localizada")
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_transacao_pendente_caixa - Chamada da funcao of_Cancela_Transacao( False ) ")
	//Garante que nenhuma transacao fique 'pendente' no TEF caso ocorra algum problema no pdv antes da gravacao na transacao_tef
	
	PDV.of_dados_impressora( Ref ll_Coo, Ref ll_ecf )
	
	This.nr_ecf            	= ll_ecf
	This.nr_cupom          	= ll_Coo
	This.dt_transacao     	= gf_GetServerDate()
	
	This.of_Cancela_Transacao( False )
Else 
	
	Do While lds_Transacao_Pendente_Caixa.RowCount() > 0
		
		ls_Situacao            = lds_Transacao_Pendente_Caixa.object.id_situacao 		[1]
		 	
		This.cd_funcao         = lds_Transacao_Pendente_Caixa.object.cd_funcao   		[1]
		This.nr_ecf            = lds_Transacao_Pendente_Caixa.object.nr_ecf      		[1]
		This.nr_cupom          = lds_Transacao_Pendente_Caixa.object.nr_coo_ecf  		[1]
		This.dt_transacao      = lds_Transacao_Pendente_Caixa.object.dt_transacao		[1]
		This.cd_caixa          = lds_Transacao_Pendente_Caixa.object.cd_caixa         [1]
		This.nr_controle_caixa = lds_Transacao_Pendente_Caixa.object.nr_controle_caixa[1]
		
		This.nr_nsu_sitef 		= lds_Transacao_Pendente_Caixa.object.nr_nsu_sitef		[1]
		This.nr_nsu_host		= lds_Transacao_Pendente_Caixa.object.nr_nsu_host		[1]
		This.nr_autorizacao	= lds_Transacao_Pendente_Caixa.object.nr_autorizacao	[1]
		
		Choose Case This.Cd_Funcao
			Case 240,300,301,261,264,265,269,275,276,124					// Recarga Celular e Gift Card e saque
				This.of_Cancela_Transacao(True)
			Case 542,594,592,593,561,562
				This.of_Cancela_Transacao(True)				
			Case 152
				This.of_Cancela_Transacao(False) //Consulta saldo cartao presente marca pr$$HEX1$$f300$$ENDHEX$$pria				
				
			Case Else
//				If This.of_Localiza_Cupom_Fiscal(This.dt_transacao, This.nr_ecf, This.nr_cupom) Then			
				If This.of_Localiza_nfce(This.dt_transacao, ps_especie, ps_serie, pl_nf) Then
					//Efetua o lan$$HEX1$$e700$$ENDHEX$$amento de todos
					If This.of_lanca_comprovante_caixa() Then
						This.of_Confirma_Transacao(True)
					Else					
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lan$$HEX1$$e700$$ENDHEX$$amento do comprovante do cart$$HEX1$$e300$$ENDHEX$$o. O lan$$HEX1$$e700$$ENDHEX$$amento dever$$HEX1$$e100$$ENDHEX$$ ser realizado manualmente.",Exclamation!)
						Return False
					End If
				Else
					This.of_Cancela_Transacao(True)
				End If
								
		End Choose
		
		lds_Transacao_Pendente_Caixa.Retrieve()
		
	Loop
	
End If

This.of_Inicializa()

If IsValid(lds_Transacao_Pendente_Caixa) Then Destroy lds_Transacao_Pendente_Caixa
GarbageCollect()

Return True
end function

public function boolean of_transacao_pendente (long pl_ecf, string ps_caixa);String ls_Situacao 

Long ll_Coo, ll_ecf

dc_uo_ds_base lds_Transacao_Pendente
lds_Transacao_Pendente = Create dc_uo_ds_base

If Not lds_Transacao_Pendente.of_ChangeDataObject('ds_ge084_transacao_tef') Then Return False

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas com cupom fiscal impresso que precisam ser confirmadas
lds_Transacao_Pendente.of_RestoreSqlOriginal()
lds_Transacao_Pendente.of_AppendWhere("nr_ecf = " + String(pl_ecf) + " and cd_caixa = '" + ps_caixa + "' and id_situacao <> 'E'")

lds_Transacao_Pendente.Retrieve()

If lds_Transacao_Pendente.RowCount() = 0 Then
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_transacao_pendente - Nenhuma transacao tef pendente foi localizada")
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_transacao_pendente - chamada da funcao of_Cancela_Transacao( False ) ")
	//Garante que nenhuma transacao fique 'pendente' no TEF caso ocorra algum problema no pdv antes da gravacao na transacao_tef
	
	PDV.of_dados_impressora( Ref ll_Coo, Ref ll_ecf )
	
	This.nr_ecf            	= ll_ecf
	This.nr_cupom          	= ll_Coo
	This.dt_transacao     	= gf_GetServerDate()
	
	This.of_Cancela_Transacao( False )
Else 
	
	Do While lds_Transacao_Pendente.RowCount() > 0
		
		ls_Situacao            = lds_Transacao_Pendente.object.id_situacao 		[1]
		 	
		This.cd_funcao         	= lds_Transacao_Pendente.object.cd_funcao   		[1]
		This.nr_ecf            	= lds_Transacao_Pendente.object.nr_ecf      		[1]
		This.nr_cupom          = lds_Transacao_Pendente.object.nr_coo_ecf  		[1]
		This.dt_transacao      = lds_Transacao_Pendente.object.dt_transacao		[1]
		This.cd_caixa          	= lds_Transacao_Pendente.object.cd_caixa         [1]
		This.nr_controle_caixa = lds_Transacao_Pendente.object.nr_controle_caixa[1]
				
		This.nr_nsu_sitef 		= lds_Transacao_Pendente.object.nr_nsu_sitef		[1]
		This.nr_nsu_host		= lds_Transacao_Pendente.object.nr_nsu_host		[1]
		This.nr_autorizacao	= lds_Transacao_Pendente.object.nr_autorizacao	[1]		
		
		Choose Case This.Cd_Funcao
			Case 240,300,301,261,264,265,269,275,276,124							// Recarga Celular e Gift e saque pix
				This.of_Cancela_Transacao(True)
			Case 542,594,592,593,561,562
				This.of_Cancela_Transacao(True)			
			Case 152
				This.of_Cancela_Transacao(False) //Consulta saldo cartao presente marca pr$$HEX1$$f300$$ENDHEX$$pria
				
			Case Else
				If This.of_Localiza_Cupom_Fiscal(This.dt_transacao, This.nr_ecf, This.nr_cupom) Then			
					//Efetua o lan$$HEX1$$e700$$ENDHEX$$amento de todos
					If This.of_lanca_comprovante_caixa() Then
						This.of_Confirma_Transacao(True)
					Else					
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lan$$HEX1$$e700$$ENDHEX$$amento do comprovante do cart$$HEX1$$e300$$ENDHEX$$o. O lan$$HEX1$$e700$$ENDHEX$$amento dever$$HEX1$$e100$$ENDHEX$$ ser realizado manualmente.",Exclamation!)
						Return False
					End If
				Else
					This.of_Cancela_Transacao(True)
				End If
								
		End Choose
		
		lds_Transacao_Pendente.Retrieve()
		
	Loop
	
End If

This.of_Inicializa()

//If IsValid(lds_Transacao_Pendente) Then Destroy lds_Transacao_Pendente
//GarbageCollect()

Return True
end function

public function boolean of_finaliza_transacao (boolean pb_nfce, long pl_nr_nf);Boolean lb_Sucesso, &
		  lb_Comprovante
		  
This.ib_NFCE 	= pb_nfce
This.nr_nf		= pl_nr_nf

//N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ necessidade de impress$$HEX1$$e300$$ENDHEX$$o e confirma$$HEX2$$e700e300$$ENDHEX$$o		  
If Not This.Impressao Then Return True

If This.cd_funcao = 789 Or This.cd_funcao = 423 Then Return True //captura senha pinpad(senha convenio)

//Efetua o lan$$HEX1$$e700$$ENDHEX$$amento de todos
//This.of_lanca_comprovante_caixa()

//Transa$$HEX2$$e700e300$$ENDHEX$$o com impress$$HEX1$$e300$$ENDHEX$$o de comprovante
If This.Impressao Then

	//Imprime comprovante da Transa$$HEX2$$e700e300$$ENDHEX$$o
	lb_Comprovante = This.of_impressao_comprovante()

	If lb_Comprovante Then		
		//Efetua o lan$$HEX1$$e700$$ENDHEX$$amento de todos
		
		If (PDV.ivs_Tipo_Venda = "TR" And (This.cd_funcao = 592 or This.cd_funcao = 593)) Or &
		   (PDV.ivs_Tipo_Venda = "VL" And This.cd_funcao = 240) Then
			lb_Sucesso = True			
		Else			
			This.of_lanca_comprovante_caixa()
			
			//Confirma a terceira perna da transa$$HEX2$$e700e300$$ENDHEX$$o
			This.of_confirma_transacao()		
		End If
		
		lb_Sucesso = True
											
	Else

		//Cancela transa$$HEX2$$e700e300$$ENDHEX$$o
		This.of_cancela_Transacao()
				
		lb_Sucesso = False
		
//		If This.cd_funcao = 300 Then //Recarga
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi efetuada. Favor reter o Cupom." + &
//										" Fa$$HEX1$$e700$$ENDHEX$$a o ESTORNO do lan$$HEX1$$e700$$ENDHEX$$amento da RECARGA no caixa!",Exclamation!)
//		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi efetuada. Favor reter o Cupom.",Exclamation!)
//		End If
		
	End If
			
End If
		
Return lb_Sucesso
end function

public function boolean of_vidalink_dados_produto (long pl_indice, string ps_produto, long pl_quantidade, decimal pdc_valor);String 	ls_valor

Boolean lb_Sucesso = False

ls_valor = LeftA(String(pdc_valor,'####0.00'),LenA(String(pdc_valor,'####0.00'))-3) + RightA(String(pdc_valor,'####0.00'),2)

This.id_Status = InformaProdutoVendaVidalink(pl_indice, ps_produto, pl_quantidade, ls_valor)

Choose Case This.id_Status
	Case 0
		lb_Sucesso = True
End Choose

Return lb_Sucesso
end function

public function boolean of_transacao_venda_vidalink (long aprodutos, string ps_tipo);//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desabilitada Fun$$HEX2$$e700e300$$ENDHEX$$o of_transacao_consulta_vidalink()",Exclamation!)

//Return False

Boolean lb_Sucesso = False

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
//This.de_restricao = ''
If ps_tipo <> 'CF' Then
	This.nr_cupom = Long(RightA(This.nr_Vidalink_Autorizacao,6))
End If			

This.id_Status = IniciaFuncaoSiTefInterativoVendaVidalink(This.nr_Vidalink_Autorizacao, aprodutos, String(This.nr_cupom,'00000000') , String(This.dt_transacao,'yyyymmdd') , String(This.dt_transacao,'hhmmss'), This.de_operador)

Choose Case This.id_Status
	Case 0
		MessageBox("Sitef","(0) Negada pelo autorizador.",Exclamation!)
	Case -1
		MessageBox("Sitef","(-1) M$$HEX1$$f300$$ENDHEX$$dulo n$$HEX1$$e300$$ENDHEX$$o inicializado.",StopSign!)
	Case -2
		MessageBox("Sitef","(-2) Opera$$HEX2$$e700e300$$ENDHEX$$o cancelada pelo operador.",Exclamation!)
	Case -3
		MessageBox("Sitef","(-3) Modalidade inv$$HEX1$$e100$$ENDHEX$$lida.",StopSign!)
	Case -4
		MessageBox("Sitef","(-4) Falta de mem$$HEX1$$f300$$ENDHEX$$ria para rodar a fun$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!)
	Case -5
		MessageBox("Sitef","(-5) Sem comunica$$HEX2$$e700e300$$ENDHEX$$o com o Sitef.",StopSign!)		
	Case 10000

		lb_Sucesso = This.of_Controla_Interacao_dll()	
		
		If lb_Sucesso Then 
			This.Vidalink.Id_Status = String(This.Id_Status,'00')
			This.Vidalink.nr_autorizacao = This.nr_vidalink_autorizacao
		End If

End Choose

Return lb_Sucesso
end function

public function boolean of_captura_senha (string ps_senha);Boolean lb_Sucesso
String ls_senha

ls_senha = Space(20)

//This.id_Status = ObtemSenha("digite", Ref ls_senha)
//This.id_Status = LeSenhaDireto(This.ChaveAbertura, Ref ls_senha)

Choose Case This.id_Status
	Case 0
//		MessageBox("Sitef","(0) Negada pelo autorizador.",Exclamation!)
		ps_senha = Trim(ls_senha)
	Case 10000

//		lb_Sucesso = This.of_Controla_Interacao_dll()	
//		
//		If lb_Sucesso Then
//			ps_senha = This.de_senha_capturada
//		End If

End Choose

Return lb_Sucesso

end function

public function boolean of_verifica_pinpad_sem_msg ();
Long ll_Retorno

ll_Retorno = VerificaPresencaPinPad() 

Choose Case ll_Retorno
	Case -1	
		//MessageBox('uo_Sitef','Biblioteca de comunica$$HEX2$$e700e300$$ENDHEX$$o com o PINPAD n$$HEX1$$e300$$ENDHEX$$o foi localizada.',StopSign!)
		Return False
	Case 0
		//MessageBox('uo_Sitef','N$$HEX1$$e300$$ENDHEX$$o existe PINPAD conectado !',Exclamation!)
		Return False
	Case 1
		//MessageBox('uo_Sitef','PINPAD conectado !')
		Return True
End Choose		

Return False
		
	
		
end function

public function boolean of_restricao_funcao (string ps_tipo[], ref string ps_restricao);
dc_uo_ds_base ds_restricao
ds_restricao = Create dc_uo_ds_base

If Not ds_restricao.of_ChangeDataObject('dw_ge084_restricao_tef_filial') Then Return False

ds_restricao.Retrieve(ps_tipo)

Long ll_Row
Long ll_find

If ds_restricao.RowCount() > 0 Then 
	
	ps_restricao = '['
	
	For ll_row = 1 To ds_restricao.RowCount()

		If ps_tipo[1] = 'RC' Then
			//Se for recarga, seleciona somente transa$$HEX2$$e700f500$$ENDHEX$$es n$$HEX1$$e300$$ENDHEX$$o permitidas.
			If String(ds_restricao.object.id_ativo[ll_row]) = 'I' Then			
				ps_restricao += String(ds_restricao.object.cd_modalidade[ll_row],'00') + ';'
			End If
		Else
			ps_restricao += String(ds_restricao.object.cd_modalidade[ll_row],'00') + ';'			
		End If
		
	Next	
	
	ps_restricao += ']'
		
End If

Destroy(ds_restricao)
GarbageCollect()

Return True

end function

public function boolean of_monta_parcelas_cartao (ref string ps_parcelas);//Fun$$HEX2$$e700e300$$ENDHEX$$o para montar a string com as op$$HEX2$$e700f500$$ENDHEX$$es de parcelamento que ser$$HEX1$$e100$$ENDHEX$$ mostrada ao operador.
//O texto $$HEX1$$e900$$ENDHEX$$ montado desta forma, seguindo o padr$$HEX1$$e300$$ENDHEX$$o TEF, para usar mesma janela de sele$$HEX2$$e700e300$$ENDHEX$$o.
Long 		ll_max_parcelas = 6
Long 		ll_num_parcela_real
Long		ll_num_parcela_calc
Long		ll_cont
Long		ll_tamanho
Long		ll_pos
String 	ls_texto //0044;1:2 x R$ 15,00;2:3 x R$ 10,00;3:3 x R$ 7,50;SELECAO PARCELAMENTO CARTAO
String 	ls_valor
Decimal {3} ldc_valor_parcela = 0.000
Decimal {2} ldc_valor

ll_num_parcela_real = Abs(This.Vl_Transacao / This.vl_parcela_minima)

If ll_num_parcela_real <= 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor da transa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permite parcelamento, somente cr$$HEX1$$e900$$ENDHEX$$dito $$HEX1$$e000$$ENDHEX$$ vista!",Exclamation!)	
	Return False
End If

If IsDate(This.is_nova_data_parcelamento) Then
	If Date(Today()) >= Date(This.is_nova_data_parcelamento)  Then
		ll_max_parcelas = 5
	End If
End If

If This.qt_parcelas_gen > 0 Then //Controle para car$$HEX1$$f500$$ENDHEX$$es conv$$HEX1$$ea00$$ENDHEX$$nio
	If This.qt_parcelas_gen = 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permite parcelamento, somente cr$$HEX1$$e900$$ENDHEX$$dito $$HEX1$$e000$$ENDHEX$$ vista!", Exclamation!)				
		Return False			
	Else
		ll_max_parcelas 	= This.qt_parcelas_gen
		
		Do While ldc_valor_parcela < This.vl_parcela_minima
			ll_num_parcela_calc = ll_num_parcela_real
			ldc_valor_parcela = This.Vl_Transacao / ll_num_parcela_calc
			ll_num_parcela_real -= 1				
		Loop
		
		If ll_num_parcela_calc > ll_max_parcelas Then
			ll_num_parcela_calc = ll_max_parcelas
		End If			
		
		For ll_cont = 2 To ll_num_parcela_calc
			ldc_valor_parcela = This.Vl_Transacao / ll_cont
			ll_pos = PosA(String(ldc_valor_parcela,'###,###0.000'),',')
			ls_valor = Trim(LeftA(String(ldc_valor_parcela,'###,###0.000'), ll_pos + 2 ) )	
			ldc_valor = Dec(ls_valor)
			ls_texto += String(ll_cont) +':'+ String(ll_cont) +' x de R$ ' + String(ldc_valor,'###,##0.00') +';'
		Next		

	End If
Else
	If ll_num_parcela_real > ll_max_parcelas Then
		ll_num_parcela_calc = ll_max_parcelas
	Else
		Do While ldc_valor_parcela < This.vl_parcela_minima
			ll_num_parcela_calc = ll_num_parcela_real
			ldc_valor_parcela = This.Vl_Transacao / ll_num_parcela_calc
			ll_num_parcela_real -= 1				
		Loop
	End If
	
	For ll_cont = 2 To ll_num_parcela_calc
		ldc_valor_parcela = This.Vl_Transacao / ll_cont
		ll_pos = PosA(String(ldc_valor_parcela,'###,###0.000'),',')
		ls_valor = Trim(LeftA(String(ldc_valor_parcela,'###,###0.000'), ll_pos + 2 ) )	
		ldc_valor = Dec(ls_valor)
		ls_texto += String(ll_cont) +':'+ String(ll_cont) +' x de R$ ' + String(ldc_valor,'###,##0.00') +';'
	Next
End If

ll_tamanho = LenA(ls_texto)

ls_texto = String(ll_tamanho,'0000') +';'+ ls_texto

ls_texto += 'SELECAO PARCELAMENTO CARTAO'

ps_parcelas = ls_texto

Return True
end function

public function long of_confirmacao_pinpad (string ps_mensagem);Long ll_Retorno

If Not This.of_verifica_pinpad() Then Return 0

Open(w_ge084_Aguarde)
w_ge084_Aguarde.wf_Mensagem("Solicite confirma$$HEX2$$e700e300$$ENDHEX$$o do cliente no PinPad.")

ll_Retorno = LeSimNaoPinPad(ps_mensagem)

If IsValid(w_ge084_Aguarde) Then Close(w_ge084_Aguarde)	

Return ll_Retorno
end function

public function boolean of_trncentre_dados_produto_autorizacao (long pl_produto, long pl_grupo_produto, string ps_descricao, string ps_barras, long pl_quantidade, decimal pdc_preco_bruto, decimal pdc_desconto, decimal pdc_desconto_padrao, long pl_sequencial);	
Long ll_Row
Long ll_Find

Long ll_Quantidade

Decimal {2} ldc_Preco

If IsNull(pl_Produto) or pl_Produto = 0 Then Return True

ll_find = This.TrnCentre.ds_autorizacao.Find('cd_produto = ' + String(pl_produto) ,1, This.TrnCentre.ds_autorizacao.RowCount())

If ll_find > 0 Then
	
	ll_Quantidade  = This.TrnCentre.ds_autorizacao.object.qt_vendida[ll_find]
	ll_Quantidade += pl_quantidade
	
	TrnCentre.ds_autorizacao.object.qt_vendida[ll_find] = ll_Quantidade 

ElseIf ll_find = 0 Then

	ll_Row = This.TrnCentre.ds_autorizacao.InsertRow(0)
	
	//Preco Liquido Calculado
	ldc_Preco = Truncate( pdc_preco_bruto * ( 1 - ( pdc_desconto / 100 ) ) ,2 )
	
	TrnCentre.ds_autorizacao.object.cd_produto 			[ll_Row] = pl_produto
	TrnCentre.ds_autorizacao.object.cd_grupo_produto	[ll_Row] = pl_grupo_produto
	TrnCentre.ds_autorizacao.object.nm_produto 			[ll_Row] = ps_descricao
	TrnCentre.ds_autorizacao.object.de_codigo_barras	[ll_Row] = ps_barras
	TrnCentre.ds_autorizacao.object.qt_vendida		 	[ll_Row] = pl_quantidade
	TrnCentre.ds_autorizacao.object.vl_preco_bruto	 	[ll_Row] = pdc_preco_bruto
	TrnCentre.ds_autorizacao.object.vl_preco_liquido  	[ll_Row] = ldc_Preco
	TrnCentre.ds_autorizacao.object.vl_preco_farmacia 	[ll_Row] = ldc_Preco
	TrnCentre.ds_autorizacao.object.pc_desconto    		[ll_Row] = pdc_desconto
	TrnCentre.ds_autorizacao.object.pc_desconto_padrao	[ll_Row] = pdc_desconto_padrao
	TrnCentre.ds_autorizacao.object.nr_sequencial    		[ll_Row] = pl_sequencial	
	
Else
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find",StopSign!)
	
	Return False
	
End If	

Return True
end function

public function boolean of_teste_conexao_bd ();DateTime ldh_movimentacao

Select dh_movimentacao Into :ldh_movimentacao
From parametro 
Where id_parametro = '1'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Return False
Else
	Return True
End If
end function

public function boolean of_atualiza_inf_pinpad (string ps_caixa);

Long ll_Retorno, &
	   ll_tamanho, &
	   ll_tipo, &
	   ll_filial
String ls_dados,&
		 ls_Fabricante,&
		 ls_Modelo,&
		 ls_versao_esp,&
		 ls_versao_sb,&
		 ls_versao_apl,&
		 ls_serie,&
		 ls_tipo, &
		 ls_aux, &
		 ls_caixa
		 
Boolean lb_continua = True
DateTime ldt_ultimo_acesso, &
			 ldt_data_hora

		 
ll_Retorno = VerificaPresencaPinPad() 

/*Exemplo de retorno
01006GERTEC02010PPC900;3MB030190077_0071_0080_0106040041.0605013001.23 100820060160450805232030714

Dois caracteres indicam a informa$$HEX2$$e700e300$$ENDHEX$$o: 01 para o Nome do fabricante,02 para o Modelo / vers$$HEX1$$e300$$ENDHEX$$o do hardware,03 para a Vers$$HEX1$$e300$$ENDHEX$$o do software b$$HEX1$$e100$$ENDHEX$$sico/firmware,04 Vers$$HEX1$$e300$$ENDHEX$$o da especifica$$HEX2$$e700e300$$ENDHEX$$o compartilhada05 para a Vers$$HEX1$$e300$$ENDHEX$$o da aplica$$HEX2$$e700e300$$ENDHEX$$o b$$HEX1$$e100$$ENDHEX$$sica,06 para o N$$HEX1$$fa00$$ENDHEX$$mero de s$$HEX1$$e900$$ENDHEX$$rie.
3 caracteres num$$HEX1$$e900$$ENDHEX$$ricos que indicam o tamanho em caracteres da informa$$HEX2$$e700e300$$ENDHEX$$o

01006GERTEC = 01 - tipo / 006 - tamanho / GERTEC - informa$$HEX2$$e700e300$$ENDHEX$$o de fabricante.
*/

If ll_Retorno = 1 Then //conectou com o pinpad
	//Vai fazer as leituras do PinPad
	ls_dados = Space(256)	
	ll_Retorno = ObtemInformacoesPinPad(Ref ls_dados) 

	If ll_Retorno = 0 Then
		If Not IsNull(ls_dados) And Trim(ls_dados) > '' Then
			ls_aux = Trim(ls_dados)
			Do While Trim(ls_aux) > ''
				ll_tipo = Long(MidA(ls_aux,0,2))				
				ll_tamanho = Long(MidA(ls_aux,3,3))
				Choose Case ll_tipo 
					Case 1
						ls_Fabricante = Trim(MidA(ls_aux,6,ll_tamanho))
					Case 2
						ls_Modelo = Trim(MidA(ls_aux,6,ll_tamanho))
					Case 3
						ls_versao_sb = Trim(MidA(ls_aux,6,ll_tamanho))						
					Case 4
						ls_versao_esp = Trim(MidA(ls_aux,6,ll_tamanho))						
					Case 5
						ls_versao_apl = Trim(MidA(ls_aux,6,ll_tamanho))
					Case 6
						ls_serie = Trim(MidA(ls_aux,6,ll_tamanho))
					Case Else
						ls_aux = ''
						lb_continua = False
				End Choose
								
				ls_aux = MidA(ls_aux, 5 + ll_tamanho + 1)		
			Loop
		End If		
		//A fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o retornou erro mas tamb$$HEX1$$e900$$ENDHEX$$m n$$HEX1$$e300$$ENDHEX$$o retornou as informa$$HEX2$$e700f500$$ENDHEX$$es.
	End If
	
	If lb_continua Then
		ls_modelo = Trim(LeftA(ls_modelo,15))
		ll_filial = gvo_parametro.cd_filial
		ldt_data_hora = gf_getserverdate()
		
		select dh_ultima_utilizacao, cd_caixa
		  into :ldt_ultimo_acesso, :ls_caixa
		  from controle_pinpad 
		where cd_filial = :ll_filial
			and nr_serie = :ls_serie
			and de_marca = :ls_Fabricante
			and de_modelo = :ls_modelo
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0 //Econtrou, vai verificar necessidade de update
				If Date(ldt_data_hora) > Date(ldt_ultimo_acesso) Then								
					
					gvo_Aplicacao.of_Grava_Log("uo_sitef - of_atualiza_inf_pinpad - Valores Pinpad: " + Trim(ls_dados))
					
					Update controle_pinpad
					Set nr_versao_sb = :ls_versao_sb,
					      nr_versao_especificacao = :ls_versao_esp,
						  nr_versao_aplic_basica = :ls_versao_apl,
						  cd_caixa = :ps_caixa,
						  dh_ultima_utilizacao = :ldt_data_hora						  
					where cd_filial = :ll_filial
						and nr_serie = :ls_serie
						and de_marca = :ls_Fabricante
						and de_modelo = :ls_modelo;
					  
					If SqlCa.SqlCode = -1 Then
						SqlCa.of_RollBack( )
						SqlCa.of_MsgDbError( "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do controle pinpad." )
						SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log, "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do controle pinpad" )
						Return False
					Else
						SqlCa.of_Commit( )						
					End If
				Else
					If ls_caixa <> ps_caixa Then
						
						gvo_Aplicacao.of_Grava_Log("uo_sitef - of_atualiza_inf_pinpad - Valores Pinpad: " + Trim(ls_dados))						
						
						Update controle_pinpad
						Set nr_versao_sb = :ls_versao_sb,
							nr_versao_especificacao = :ls_versao_esp,
							  nr_versao_aplic_basica = :ls_versao_apl,
							  cd_caixa = :ps_caixa,
							  dh_ultima_utilizacao = :ldt_data_hora						  
						where cd_filial = :ll_filial
							and nr_serie = :ls_serie
							and de_marca = :ls_Fabricante
							and de_modelo = :ls_modelo;
						  
						If SqlCa.SqlCode = -1 Then
							SqlCa.of_RollBack( )
							SqlCa.of_MsgDbError( "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do controle pinpad." )
							SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log, "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do controle pinpad" )
							Return False
						Else
							SqlCa.of_Commit( )						
						End If						
					End If
				End If
				
			Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou, vai inserir
				gvo_Aplicacao.of_Grava_Log("uo_sitef - of_atualiza_inf_pinpad - Valores Pinpad: " + Trim(ls_dados))				
				
				Insert Into controle_pinpad
					( cd_filial,
					  nr_serie,
					  de_marca,
					  de_modelo,
					  nr_versao_sb,					  
					  nr_versao_especificacao,
					  nr_versao_aplic_basica,
					  cd_caixa,
					  dh_ultima_utilizacao)
				Values(:ll_filial,
						 :ls_serie,
						 :ls_fabricante,
						 :ls_modelo,
						 :ls_versao_sb,
						 :ls_versao_esp,   
						 :ls_versao_apl,
						 :ps_caixa,
						 :ldt_data_hora)
				Using Sqlca;	

				If Sqlca.Sqlcode = -1 Then
					SqlCa.of_RollBack( )
					SqlCa.of_MsgDbError( "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do controle pinpad." )
					SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log, "Erro na Inclus$$HEX1$$e300$$ENDHEX$$o do controle pinpad" )
					Return False
				Else
					SqlCa.of_Commit( )
				End If
			Case -1
				SqlCa.of_RollBack( )
				SqlCa.of_MsgDbError( "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle pinpad." )
				SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log, "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle pinpad." )
				Return False
		End Choose					
		
	End If	
End If

Return True
end function

public function boolean of_lanca_recarga_celular_filial ();// Rafael Machado - Star-IT - 15/Jan/2019
// Fun$$HEX2$$e700e300$$ENDHEX$$o criada para atender o chamado 436707
Boolean  lb_Sucesso  = True
Long     ll_filial
Long     ll_nr_lancamento_caixa
String   ls_forma_pagamento
String   ls_operadora

ll_nr_lancamento_caixa = gvo_controle_caixa.of_Proximo_Lancamento_Caixa(cd_Caixa, nr_controle_caixa)

If Not gvo_controle_caixa.of_insere_lancamento_caixa(cd_caixa, nr_controle_caixa, il_cd_conta_fluxo_caixa_recarga, dt_transacao, vl_transacao, is_Historico, is_Recibo) Then
	Sqlca.of_RollBack()
	of_cancela_transacao(ib_nfce, nr_nf, True)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento Recarga Celular Filial : " + cd_caixa + " controle : " + String(nr_controle_caixa) )
	lb_Sucesso = False
End If

if cd_forma_pagamento = '01' then ls_forma_pagamento = 'CA'
if cd_forma_pagamento = '02' then ls_forma_pagamento = 'CP'
if cd_forma_pagamento = '98' then ls_forma_pagamento = 'DI'
if This.cd_funcao_pgto = 122 then   ls_forma_pagamento = 'CD'

ls_operadora = Upper(This.de_operadora)

Choose Case Upper(Trim(SITEF.de_operadora))
	Case "CLARO"
		il_cd_conta_fluxo_caixa_recarga = 21
	Case "BRASIL TELECOM"
		il_cd_conta_fluxo_caixa_recarga = 14
	Case "TIM"
		il_cd_conta_fluxo_caixa_recarga = 41
	Case "VIVO"
		il_cd_conta_fluxo_caixa_recarga = 15
	Case "OI"
		il_cd_conta_fluxo_caixa_recarga = 31
	Case Else
		il_cd_conta_fluxo_caixa_recarga = 21
End Choose

ll_filial = gvo_parametro.cd_filial

INSERT INTO recarga_celular_filial
		(cd_filial,					dh_movimentacao,		  dh_lancamento,			cd_forma_pagamento,	nr_nsu,
		nr_celular,				de_operadora,				  cd_operadora_celular,	vl_recarga,					cd_caixa,
		nr_controle_caixa,		nr_lancamento_caixa,		  nr_matricula_operador)
VALUES 
		(:ll_filial,					:dt_transacao,			 	  :dt_transacao,				:ls_forma_pagamento,	:nr_nsu_gift_recarga,
		:nr_celular,				:ls_operadora,				  :il_cd_conta_fluxo_caixa_recarga,	:vl_transacao,	:cd_caixa,
		:nr_controle_caixa,	:ll_nr_lancamento_caixa,  :is_matricula_operador) 
USING Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Recarga Celular Filial")
	Sqlca.of_MsgDbError('Grava$$HEX2$$e700e300$$ENDHEX$$o recarga celular.')			
	lb_Sucesso = False
Else
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_lanca_recarga_celular_filial - Recarga Celular Filial. Filial [" + String(ll_filial) + "], Nr. Celular [" + String(nr_celular) + "], NSU [" + nr_nsu_sitef + "]")
End If				

Return lb_Sucesso
end function

public function boolean of_confirmacao_pinpad (string ps_mensagem, ref integer pi_retorno_pinpad);Long ll_Retorno

SetNull(pi_retorno_pinpad)

If Not This.of_verifica_pinpad_sem_msg() Then 
	Return False
End If

Open(w_ge084_Aguarde)
w_ge084_Aguarde.wf_Mensagem("Solicite confirma$$HEX2$$e700e300$$ENDHEX$$o do cliente no PinPad.")

ll_Retorno = LeSimNaoPinPad(ps_mensagem)

If IsValid(w_ge084_Aguarde) Then Close(w_ge084_Aguarde)	

pi_retorno_pinpad = ll_Retorno

Return True
end function

public function boolean of_transacao_giftcard (datetime adata, string aoperador, string acaixa, long acontrole_caixa, string atipo, string apgto);
Boolean  lb_Sucesso
Boolean 	lb_transacao_pagamento //quando a transa$$HEX2$$e700e300$$ENDHEX$$o de pagamento $$HEX1$$e900$$ENDHEX$$ chamado separadamente

Long	ll_ecf 
Long	ll_cupomfiscal

String ls_funcao[]
String   ls_restricao
String ls_texto_aviso

//00042 = EPAY GIFT -- codigo autorizadora 

ls_funcao[1] = 'RC'
ls_funcao[2] = "RPC"

If Not This.of_verifica_pinpad() Then Return False

If Not This.of_Restricao_Funcao(ls_funcao[],Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

//ls_Restricao = "[61;63]"

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

This.nr_cupom     	  = ll_CupomFiscal
This.nr_ecf       	  = ll_Ecf
This.dt_transacao 	  = gf_getserverdate()
This.vl_transacao      = 000.00
This.de_operador       = aoperador
This.de_restricao      = ls_restricao
This.cd_caixa          = acaixa
This.nr_controle_caixa = acontrole_caixa

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
If atipo = '1' Then 
	If  apgto = '1' Then //Venda cartao
		This.cd_funcao		= 265 //Venda cart$$HEX1$$e300$$ENDHEX$$o	 dinheiro
	Else
		This.cd_funcao 	= 264//Venda cart$$HEX1$$e300$$ENDHEX$$o  outra forma pgto
		lb_transacao_pagamento = True
	End If
	//ls_restricao += ";{ProdutoComValorFace=-1}"	
End If

If atipo = '2' Then// VENDA PIN
//	This.cd_funcao    	= 276
	This.cd_funcao    	= 275	
	This.id_venda_pin	= True
	If apgto <> '1' Then
		lb_transacao_pagamento = True
	End If
End If

ls_restricao += ";{ProdutoComValorFace=-1}"

If apgto = '2' Then
	This.cd_funcao_pgto = 2 //debito
	ls_texto_aviso = 'CART$$HEX1$$c300$$ENDHEX$$O D$$HEX1$$c900$$ENDHEX$$BITO'
End If		
If apgto = '3' Then
	This.cd_funcao_pgto = 3 //credito
	ls_texto_aviso = 'CART$$HEX1$$c300$$ENDHEX$$O CR$$HEX1$$c900$$ENDHEX$$DITO'
End If
If apgto = '4' Then
	This.cd_funcao_pgto = 122 //Carteiras digitais
	This.id_pgto_carteira_digital = True
	ls_texto_aviso = 'CARTEIRA DIGITAL'
End If

If This.of_Inicia_Funcao_Tef() Then
	//This.Recarga = True
	lb_Sucesso = This.of_Controla_Interacao_dll()
	//This.Recarga = False		
End If

If lb_sucesso And lb_transacao_pagamento Then //Quando a transacao precisa registrar o pagamento separado.
	
	MessageBox("AVISO", 'Agora ser$$HEX1$$e300$$ENDHEX$$o solicitados os dados para pagamento com ' + ls_texto_aviso + ' da transa$$HEX2$$e700e300$$ENDHEX$$o!', Information!) 
	
	This.cd_funcao_principal = This.cd_funcao
	This.cd_funcao = This.cd_funcao_pgto
	This.dt_transacao 	  = gf_getserverdate()
	If This.of_Inicia_Funcao_Tef() Then		
		//This.Recarga = True
		lb_Sucesso = This.of_Controla_Interacao_dll()
		//This.Recarga = False		
	End If		
End If

Return lb_Sucesso
end function

public function boolean of_transacao_recarga (datetime adata, string aoperador, string acaixa, long acontrole_caixa, string apgto);
Boolean  lb_Sucesso
Boolean	lb_transacao_pagamento

Long	ll_ecf 
Long	ll_cupomfiscal

//String   ls_funcao = 'RC' 																		   // Transacao recarga
String ls_funcao[]
String   ls_restricao
String ls_texto_aviso

ls_funcao[1] = 'RC'
ls_funcao[2] = "RPC"

If Not This.of_verifica_pinpad() Then Return False

If Not This.of_Restricao_Funcao(ls_funcao[],Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

//ls_Restricao = "[61;63]"

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

//###PARA QUANDO FOR RECARGA PELA EPAY####
If apgto = '1' Then 
	This.cd_funcao		= 300 //Recarga pgto dinheiro ou cart$$HEX1$$e300$$ENDHEX$$o	
Else
	This.cd_funcao 	= 301 // transa$$HEX2$$e700e300$$ENDHEX$$o recarga pagamento separado.
	lb_transacao_pagamento = True
End If

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
//This.cd_funcao		= 300
This.nr_cupom     	  = ll_CupomFiscal
This.nr_ecf       	  = ll_Ecf
This.dt_transacao 	  = gf_getserverdate()
This.vl_transacao      = 000.00
This.de_operador       = aoperador
This.de_restricao      = ls_restricao
This.cd_caixa          = acaixa
This.nr_controle_caixa = acontrole_caixa

If This.of_Inicia_Funcao_Tef() Then
	This.Recarga = True
	lb_Sucesso = This.of_Controla_Interacao_dll()
	This.Recarga = False		
End If

If apgto = '2' Then
	This.cd_funcao_pgto = 122 //Carteiras digitais
	This.id_pgto_carteira_digital = True
	ls_texto_aviso = 'CARTEIRA DIGITAL'	
End If

If lb_sucesso And lb_transacao_pagamento Then //Quando a transacao precisa registrar o pagamento separado.

	MessageBox("AVISO", 'Agora ser$$HEX1$$e300$$ENDHEX$$o solicitados os dados para pagamento com ' + ls_texto_aviso + ' da transa$$HEX2$$e700e300$$ENDHEX$$o!', Information!)
	
	This.cd_funcao_principal = This.cd_funcao
	This.cd_funcao = This.cd_funcao_pgto
	This.dt_transacao 	  = gf_getserverdate()
	If This.of_Inicia_Funcao_Tef() Then		
		//This.Recarga = True
		lb_Sucesso = This.of_Controla_Interacao_dll()
		//This.Recarga = False		
	End If		
End If

Return lb_Sucesso
end function

public function boolean of_lanca_venda_giftcard ();//Grava lan$$HEX1$$e700$$ENDHEX$$amento de caixa da venda GIFTCARD
Boolean  lb_Sucesso  = True
Long     ll_filial
Long     ll_nr_lancamento_caixa
Long 	   ll_cartao
Long	   ll_cartao_tef
String   ls_forma_pagamento
String	   ls_produto_tef
String   ls_pin
String   ls_BIN
String   ls_funcao
String	   ls_produto_email
String    ls_nulo[]
String   ls_tipo_comissao

ll_filial = gvo_parametro.cd_filial

ll_nr_lancamento_caixa = gvo_controle_caixa.of_Proximo_Lancamento_Caixa(cd_Caixa, nr_controle_caixa)

If Not gvo_controle_caixa.of_insere_lancamento_caixa(cd_caixa, nr_controle_caixa, il_cd_conta_fluxo_caixa_recarga, dt_transacao, vl_transacao, is_Historico, is_Recibo) Then
	Sqlca.of_RollBack()
	of_cancela_transacao(ib_nfce, nr_nf, True)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento Gift Card Filial : " + cd_caixa + " controle : " + String(nr_controle_caixa) )
	lb_Sucesso = False
End If

Choose Case This.cd_funcao_pgto 
	Case 2
		ls_forma_pagamento = 'CA'
	Case 3
		ls_forma_pagamento = 'CP'
	Case 122
		ls_forma_pagamento = 'CD'
	Case Else
		ls_forma_pagamento = 'DI'
End Choose

//if cd_forma_pagamento = '01' then ls_forma_pagamento = 'CA'
//if cd_forma_pagamento = '02' then ls_forma_pagamento = 'CP'
//if cd_forma_pagamento = '98' then ls_forma_pagamento = 'DI'
//If id_pgto_carteira_digital  then ls_forma_pagamento = 'CD'

If Not This.id_venda_pin Then	
	ls_pin = 'N'
	ls_tipo_comissao = 'P'
	
	If LenA(This.nr_cartao_gift) = 13 Then //Leitura pelo EAN do cart$$HEX1$$e300$$ENDHEX$$o.	
		Select cd_cartao
		  Into :ll_cartao
		From cartao_gift
		Where id_venda_pin = 'N'
		and nr_ean_cartao = :This.nr_cartao_gift
		Using Sqlca;
	
	Else //Leitura pelo numero do cart$$HEX1$$e300$$ENDHEX$$o
		ls_BIN = LeftA(This.nr_cartao_gift,6)
		//Primeiro tento procurar pelas 2 posi$$HEX2$$e700f500$$ENDHEX$$es (bin + 2 digitos), sen$$HEX1$$e300$$ENDHEX$$o tenta com 3 (bin + 3 digitos)
		ll_cartao_tef =  Long(MidA(This.nr_cartao_gift,7,2))	
		
		Select cd_cartao
		  Into :ll_cartao
		From cartao_gift
		Where id_venda_pin = 'N'
		and nr_bin = :ls_BIN
		and cd_produto_cartao = :ll_cartao_tef
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o cod Cartao Gift.')
			Return False
		End If
		
		If Sqlca.Sqlcode = 100 Then
			ll_cartao_tef =  Long(MidA(This.nr_cartao_gift,7,3))	
			
			Select cd_cartao
			  Into :ll_cartao
			From cartao_gift
			Where id_venda_pin = 'N'
			and nr_bin = :ls_BIN
			and cd_produto_cartao = :ll_cartao_tef
			Using Sqlca;				
		End If
	End If
	
	If IsNull(This.nr_cartao_gift) Or Trim(This.nr_cartao_gift) = '' Then
		ls_produto_email = 'NULO'
	Else
		ls_produto_email = This.nr_cartao_gift
	End If
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_lanca_venda_giftcard - Busca GiftCard. Filial [" + String(ll_filial) + "], NSU [" + nr_nsu_gift_recarga + "], Produto ["+ ls_produto_email + "]")			
	
Else
	ls_pin = 'S'
	ls_tipo_comissao = 'D'
	//pegar o texto TEF
	ls_produto_tef = This.de_produto_gift
	
	If IsNull(This.cd_ean_gift) Or Trim(cd_ean_gift) = '' Then
	
		Select cd_cartao
		  Into :ll_cartao
		From cartao_gift
		Where id_venda_pin = 'S'
		and de_texto_tef = :ls_produto_tef
		Using Sqlca;		
		
		ls_produto_tef = LeftA(ls_produto_tef,40)
		
	Else
		
		Select cd_cartao
		  Into :ll_cartao
		From cartao_gift
		Where id_venda_pin = 'S'
		and nr_ean_cartao = :This.cd_ean_gift
		Using Sqlca;	
		
	End If
	If IsNull(ls_produto_tef) Or Trim(ls_produto_tef) = '' Then
		ls_produto_email = 'NULO'
	Else
		ls_produto_email = ls_produto_tef
	End If
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_lanca_venda_giftcard - Busca GiftCard. Filial [" + String(ll_filial) + "], NSU [" + nr_nsu_gift_recarga + "], Produto [" + ls_produto_email + "]")			
	
End If

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o cod Cartao Gift.')
	Return False
End If
		
If Sqlca.Sqlcode = 100 Then
	//se n$$HEX1$$e300$$ENDHEX$$o encontrou o cartao no cadastro, inclui como "generico" para n$$HEX1$$e300$$ENDHEX$$o perder a venda.
	If Not This.id_venda_pin Then
		ll_cartao = 1
		ls_funcao = 'Gift Cart$$HEX1$$e300$$ENDHEX$$o Fis$$HEX1$$ed00$$ENDHEX$$co'
	Else
		ll_cartao = 2
		ls_funcao = 'Gift Venda PIN'
		If IsNull(This.cd_ean_gift) Or Trim(cd_ean_gift) = '' Then
			ls_produto_email = ls_produto_tef
		Else
			ls_produto_email = 'EAN= ' + This.cd_ean_gift
		End If
	End If
	
	//Envio de e-mail para informar produto gift n$$HEX1$$e300$$ENDHEX$$o cadastrado
	gf_ge202_envia_email_log(243,'VENDA GIFT - PRODUTO SEM CADASTRO - FILIAL(' + String(gvo_parametro.cd_filial) +')', &
											' Filial: '+ String(gvo_parametro.cd_filial) +' - Fun$$HEX2$$e700e300$$ENDHEX$$o: ' + ls_funcao + ' - Produto ou Cart$$HEX1$$e300$$ENDHEX$$o: ' + ls_produto_email +  '<br />' +&
											' Data Hora: ' + String(dt_transacao, 'dd/mm/yyyy hh:mm:ss') + ' - CAIXA: ' + This.cd_caixa + ' - CONTROLE: ' + String(nr_controle_caixa) + '<br />' +&
											' NSU_SITEF: ' + This.nr_nsu_gift_recarga )			
End If

INSERT INTO venda_cartao_gift
		(cd_filial,					cd_cartao,	 nr_cartao, 		
		dh_movimentacao,		  dh_lancamento,			cd_forma_pagamento,	nr_nsu,
		vl_transacao,					cd_caixa, id_tipo_comissao,
		nr_controle_caixa,		nr_lancamento_caixa,		  nr_matricula_operador, id_venda_pin, de_produto_tef)
VALUES 
		(:ll_filial,					:ll_cartao,					:This.nr_cartao_gift,	
		:dt_transacao,			 	  :dt_transacao,				:ls_forma_pagamento,	:This.nr_nsu_gift_recarga,
		:vl_transacao,	:cd_caixa, :ls_tipo_comissao,
		:nr_controle_caixa,	:ll_nr_lancamento_caixa,  :is_matricula_operador, :ls_pin, :ls_produto_tef) 
USING Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Venda GiftCard")
	Sqlca.of_MsgDbError('Grava$$HEX2$$e700e300$$ENDHEX$$o Venda GiftCard.')			
	lb_Sucesso = False
Else
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_lanca_venda_giftcard - Venda GiftCard. Filial [" + String(ll_filial) + "], VendaPIN [" + ls_pin + "], NSU [" + nr_nsu_gift_recarga + "]")
End If				

Return lb_Sucesso
end function

public function boolean of_retorna_carteiras (ref string ps_carteiras);Long ll_row

dc_uo_ds_base lds_carteiras
lds_carteiras = Create dc_uo_ds_base

If Not lds_carteiras.of_ChangeDataObject('ds_ge084_carteira_digital') Then Return False

lds_carteiras.of_RestoreSqlOriginal()
lds_carteiras.Retrieve()

For ll_row = 1 TO lds_carteiras.RowCount()
	If lds_carteiras.object.id_situacao[ll_row] = 'A' Then
		If Not Isnull(ps_carteiras) And Trim(ps_carteiras) <> '' Then
			ps_carteiras += ';' + lds_carteiras.object.nr_codigo_tef[ll_row]
		Else
			ps_carteiras = lds_carteiras.object.nr_codigo_tef[ll_row] 
		End If
	End If
Next

Return True
end function

public function boolean of_retorna_cartao_produto (string ps_autorizadora, string ps_cod_bandeira, string ps_bandeira, ref string ps_cartao_produto);Long ll_adm
Long ll_bandeira

ll_adm 		= Long(ps_autorizadora)
ll_bandeira 	= Long(ps_cod_bandeira)

Select nm_produto Into :ps_cartao_produto
From cartao_produto
Where cd_administradora_tef = :ll_adm
And cd_bandeira = :ll_bandeira
Limit 1
Using Sqlca;

Choose Case Sqlca.Sqlcode 
	Case -1
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Busca cartao_produto.")
	Case 100
		ps_cartao_produto = ps_bandeira
						
End Choose

Return True
end function

public function boolean of_busca_cnpj (string ps_autorizadora, string ps_produto, string ps_cod_bandeira, ref string ps_cnpj, ref long pl_bandeira_sefaz);String ls_bandeira
String ls_cnpj
Long ll_adm
Long ll_bandeira_sefaz,ll_bandeira

ls_bandeira = Upper(Trim(ps_produto))

ll_adm 		= Long(ps_autorizadora)
ll_bandeira 	= Long(ps_cod_bandeira)

Select nr_cnpj_credenciadora,cd_bandeira_sefaz Into :ls_cnpj,:ll_bandeira_sefaz
From cartao_produto
Where cd_administradora_tef = :ll_adm
And cd_bandeira = :ll_bandeira
Limit 1
Using Sqlca;

Choose Case Sqlca.Sqlcode 
	Case -1
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Erro ao buscar CNPJ credenciadora TEF: " + Sqlca.SqlErrText)
		Return False
	Case 100
		pl_bandeira_sefaz = 99
		//				
End Choose

ps_cnpj = ls_cnpj
If IsNull(ll_bandeira_sefaz) Or ll_bandeira_sefaz = 0 Then
	pl_bandeira_sefaz = 99
Else
	pl_bandeira_sefaz = ll_bandeira_sefaz
End If

//This.of_valida_bandeira_produto(Ref ls_bandeira)

//If Long(ps_Autorizadora) = 5 Then
//	If Upper(Trim(ls_bandeira)) = 'VISA' Then
//		ls_bandeira = 'VISA CREDITO - REDE'
//	ElseIf Upper(Trim(ls_bandeira)) = 'VISA ELECTRON' Then
//		ls_bandeira = 'VISA DEBITO - REDE'
//	ElseIf Upper(Trim(ls_bandeira)) = 'VISA ELECTRON NA' Then					
//		ls_bandeira = 'VISA DEBITO - REDE'												
//	ElseIf Upper(Trim(ls_bandeira)) = 'HIPERCARD' Then
//		ls_bandeira = 'HIPERCARD - REDE'
//	ElseIf Upper(Trim(ls_bandeira)) = 'MASTERCARD' Then
//		ls_bandeira = 'MASTERCARD CREDITO - REDE'
//	ElseIf Upper(Trim(ls_bandeira)) = 'MAESTRO' Then
//		ls_bandeira = 'MASTERCARD DEBITO - REDE'
//	ElseIf Upper(Trim(ls_bandeira)) = 'ELO CREDITO' Then
//		ls_bandeira = 'ELO CREDITO - REDE'
//	ElseIf Upper(Trim(ls_bandeira)) = 'ELO DEBITO' Then
//		ls_bandeira = 'ELO DEBITO - REDE'
//	ElseIf Upper(Trim(ls_bandeira)) = 'AMEX' Then				
//		ls_bandeira = 'AMEX REDE'
//	ElseIf Upper(Trim(ls_bandeira)) = 'CARDSE' Then
//		ls_bandeira = 'CARTEIRA DIGITAL PIX'
//	End IF					
//End If	
//
//If Long(ps_Autorizadora) <> 5 and Long(ps_Autorizadora) <> 181 Then
//	If Upper(Trim(ls_bandeira)) = 'SOFTNEX' Then
//		ls_bandeira = 'ROM CARD'
//	ElseIf Upper(Trim(ls_bandeira)) = 'PARATI' Then
//		ls_bandeira = 'SENFF'
//	ElseIf Upper(Trim(ls_bandeira)) = 'MAXICRED' Then
//		ls_bandeira = 'MAXICRED/AGEMED'
//	ElseIf Upper(Trim(ls_bandeira)) = 'SODEXHO' Then
//		ls_bandeira = 'UNICK'
//	ElseIf Upper(Trim(ls_bandeira)) = 'CONDUCTOR' Then
//		ls_bandeira = 'CALCARD'	
//	End If
//End If
//
//Select nr_cnpj_credenciadora Into :ls_cnpj
//From cartao_produto
//Where nm_produto  = :ls_bandeira
//Using Sqlca; 
//
//If Sqlca.Sqlcode = -1 Then
//	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Erro ao buscar CNPJ credenciadora TEF: " + Sqlca.SqlErrText)
//	Return False
//End If

Return True

end function

public function boolean of_transacao_saque_pix (decimal avalorsaque, datetime adata, string aoperador, string acaixa, long acontrole_caixa, string avendedor);
Boolean  lb_Sucesso

Long	ll_ecf 
Long	ll_cupomfiscal

//String   ls_funcao = 'RC' 																		   // Transacao recarga
String ls_funcao[]
String   ls_restricao
String ls_texto_aviso

ls_funcao[1] = 'RC'
ls_funcao[2] = "RPC"

If Not This.of_verifica_pinpad() Then Return False

If Not This.of_Restricao_Funcao(ls_funcao[],Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
This.cd_funcao				= 124
This.nr_cupom     	  		= ll_CupomFiscal
This.nr_ecf       	  		= ll_Ecf
This.dt_transacao 	  		= gf_getserverdate()
This.vl_transacao      		= avalorsaque
This.de_operador       	= aoperador
This.de_vendedor 			= avendedor
This.de_restricao      		= ls_restricao
This.cd_caixa				= acaixa
This.nr_controle_caixa	= acontrole_caixa

If This.of_Inicia_Funcao_Tef() Then
//	This.Recarga = True
	lb_Sucesso = This.of_Controla_Interacao_dll()
//	This.Recarga = False		
End If

Return lb_Sucesso
end function

public function boolean of_lanca_movimento_pix (string ps_tipo, string ps_caixa_lancamento, long pl_controle_lancamento, string ps_caixa_transacao, long pl_sequencial_cartao, long pl_sequencial_caixa);Boolean  lb_Sucesso  = True
Long     ll_filial
Long     ll_nr_lancamento_caixa
String   ls_forma_pagamento
String   ls_operadora


ll_filial = gvo_parametro.cd_filial

INSERT INTO movimento_pix
		(cd_filial,					cd_tipo, 						dh_movimentacao,		  dh_lancamento,		nr_nsu,
		cd_caixa_lancamento,  nr_controle_caixa,		nr_lancamento_caixa,		  nr_matricula_operador,
		nr_matricula_vendedor,   vl_transacao,    cd_caixa_transacao, nr_sequencial_comprovante)
VALUES 
		(:ll_filial,					:ps_tipo,                       :dt_transacao,			 	  :dt_transacao,				:nr_nsu_sitef,
		:ps_caixa_lancamento,		:pl_controle_lancamento,  :pl_sequencial_caixa,	 :de_operador,
		:de_vendedor,   :vl_transacao,	:ps_caixa_transacao, :pl_sequencial_cartao) 
USING Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Movimento pix")
	Sqlca.of_MsgDbError('Grava$$HEX2$$e700e300$$ENDHEX$$o Movimento pix.')			
	lb_Sucesso = False
Else
	gvo_Aplicacao.of_Grava_Log("uo_sitef - of_lanca_movimento_pix - Movimento SAQUE PIX. Filial [" + String(ll_filial) + "], NSU [" + nr_nsu_sitef + "]")
End If				

Return lb_Sucesso
end function

public function boolean of_captura_dados_pinpad (decimal avalorsaque, string aoperador, string acaixa, long acontrole_caixa, string avendedor, string acodigocaptura, string atamanhomin, string atamanhomax);
Boolean  lb_Sucesso
Boolean	lb_outra_funcao = false

Long	ll_ecf 
Long	ll_cupomfiscal

String ls_funcao[]
String   ls_restricao
String ls_texto_aviso

If Not This.of_verifica_pinpad() Then Return False

If Not This.of_Restricao_Funcao(ls_funcao[],Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

If Not IsNull(This.cd_funcao) And This.cd_funcao > 0 Then
	This.cd_funcao_principal = This.cd_funcao
	lb_outra_funcao = True
End If

This.cd_funcao				= 789
//This.nr_cupom     	  		= 1
//This.nr_ecf       	  		= 1
This.dt_transacao 	  		= gf_getserverdate()
This.vl_transacao      		= 0
This.de_operador       	= aoperador
This.de_vendedor 			= avendedor
This.de_restricao      		= ls_restricao
This.cd_caixa				= acaixa
This.nr_controle_caixa	= acontrole_caixa
This.cd_tipo_cpatura_pinpad = acodigocaptura
This.de_tam_mim_captura = atamanhomin
This.de_tam_max_captura = atamanhomax

SetNull(This.de_dado_captura_pinpad)

If This.of_Inicia_Funcao_Tef() Then
	lb_Sucesso = This.of_Controla_Interacao_dll()
End If

If lb_outra_funcao Then
	This.cd_funcao	= This.cd_funcao_principal
	SetNull(This.cd_funcao_principal)
End If

Return lb_Sucesso
end function

public function boolean of_captura_pinblock (string as_identificacao_conveniado);
Boolean  lb_Sucesso
Boolean	lb_outra_funcao = false

Long	ll_ecf 
Long	ll_cupomfiscal

String ls_funcao[]
String   ls_restricao
String ls_texto_aviso
long ll_retorno 
String ls_1
String ls_2

If Not This.of_verifica_pinpad() Then Return False
If Not This.of_Restricao_Funcao(ls_funcao[],Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

If Not IsNull(This.cd_funcao) And This.cd_funcao > 0 Then
	This.cd_funcao_principal = This.cd_funcao
	lb_outra_funcao = True
End If

This.cd_funcao							= 423
This.dt_transacao 	  					= gf_getserverdate()
This.is_Identificacao_Conveniado 	= Trim(as_Identificacao_Conveniado)

//retira os caracteres
This.is_Identificacao_Conveniado = gf_retira_caracteres_especiais( This.is_Identificacao_Conveniado )
This.is_Identificacao_Conveniado = gf_replace(This.is_Identificacao_Conveniado, ".", "", 0)
This.is_Identificacao_Conveniado = gf_replace(This.is_Identificacao_Conveniado, " ", "", 0)
//Max de 19 caracteres
//BIN_TUICCS + Cod Conveniado ou Cpf
//005187 + 13 dig
If LenA(This.is_Identificacao_Conveniado) > 13 Then
	This.is_Identificacao_Conveniado = MidA(This.is_Identificacao_Conveniado, 1, 13)
End If


//This.nr_cupom     	  				= 1
//This.nr_ecf       	  					= 1
//This.vl_transacao      					= 0
//This.de_operador       				= aoperador
//This.de_vendedor 						= avendedor
//This.de_restricao      					= ls_restricao
//This.cd_caixa							= acaixa
//This.nr_controle_caixa				= acontrole_caixa
//This.cd_tipo_cpatura_pinpad 		= acodigocaptura
//This.de_tam_mim_captura 			= atamanhomin
//This.de_tam_max_captura 			= atamanhomax

SetNull(This.de_dado_captura_pinpad)

If This.of_Inicia_Funcao_Tef() Then
	lb_Sucesso = This.of_Controla_Interacao_dll()
End If

If lb_outra_funcao Then
	This.cd_funcao	= This.cd_funcao_principal
	SetNull(This.cd_funcao_principal)
End If

This.SolicitacaoSenha = False

Return lb_Sucesso
end function

public function boolean of_transacao_cartao_presente_saldo (long aecf, long acupomfiscal, string aoperador, string acaixa, long acontrole_caixa);
Boolean  lb_Sucesso
Boolean 	lb_transacao_pagamento //quando a transa$$HEX2$$e700e300$$ENDHEX$$o de pagamento $$HEX1$$e900$$ENDHEX$$ chamado separadamente

Long	ll_ecf 
Long	ll_cupomfiscal

String ls_funcao[]
String   ls_restricao
String ls_texto_aviso

//If Not This.of_verifica_pinpad() Then Return False

//If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

This.cd_funcao				= 152 //Consulta saldo Giftcard
This.nr_cupom     	  		= acupomfiscal
This.nr_ecf       	  		= aecf
This.dt_transacao 	  		= gf_getserverdate()
This.vl_transacao     		= 000.00
This.de_operador       	= aoperador
This.de_restricao       	= ls_restricao
This.cd_caixa          		= acaixa
This.nr_controle_caixa 	= acontrole_caixa
This.Gerencial				= True

If This.of_Inicia_Funcao_Tef() Then
	//This.Recarga = True
	lb_Sucesso = This.of_Controla_Interacao_dll()
	//This.Recarga = False		
	If lb_Sucesso Then
		lb_Sucesso = This.of_Finaliza_Transacao(This.ib_NFCE, This.nr_nf)
	End If 
End If

Return lb_Sucesso
end function

public function boolean of_transacao_cartao_presente_estorno (string as_cartao, string as_nsu, decimal adc_valor, date adt_movimento, string as_operador, string as_caixa, long al_controle_caixa, long al_ecf, long al_cupom);
Boolean  lb_Sucesso
Boolean 	lb_transacao_pagamento //quando a transa$$HEX2$$e700e300$$ENDHEX$$o de pagamento $$HEX1$$e900$$ENDHEX$$ chamado separadamente

Long	ll_ecf 
Long	ll_cupomfiscal

String ls_funcao[]
String   ls_restricao
String ls_texto_aviso

This.cd_funcao				= 213 //Cancelamento venda Giftcard
This.dt_transacao 	  		= DateTime(adt_movimento)
This.vl_transacao     		= adc_valor
This.nr_nsu_sitef 			= as_NSU
This.nr_cartao_gift 		= as_cartao
This.Impressao				= True

This.nr_cupom     	  		= al_cupom
This.nr_ecf       	  		= al_ecf
This.de_operador       	= as_operador
This.cd_caixa          		= as_caixa
This.nr_controle_caixa 	= al_controle_caixa

If This.of_Inicia_Funcao_Tef() Then
	//This.Recarga = True
	lb_Sucesso = This.of_Controla_Interacao_dll()
	//This.Recarga = False		
	If lb_Sucesso Then
		lb_Sucesso = This.of_Finaliza_Transacao(This.ib_NFCE, This.nr_nf)
	End If 
End If

Return lb_Sucesso
end function

on uo_sitef.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_sitef.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ePharma       = Create uo_ePharma_Sitef
TrnCentre     = Create uo_TrnCentre_Sitef
Vidalink      = Create uo_Vidalink_Sitef
EdmCard       = Create uo_edm_Sitef
PharmaSystem  = Create uo_PharmaSystem
Funcional	  = Create uo_Funcional_Card

ds_Servico    = Create dc_uo_ds_base
ds_autorizacao = Create dc_uo_ds_base
end event

event destructor;
Destroy(ePharma)
Destroy(TrnCentre)
Destroy(Vidalink)
Destroy(PharmaSystem)
Destroy(Funcional)

Destroy(ds_servico)
Destroy(ds_autorizacao)
end event

