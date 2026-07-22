HA$PBExportHeader$uo_sitef_retaguarda.sru
forward
global type uo_sitef_retaguarda from nonvisualobject
end type
end forward

global type uo_sitef_retaguarda from nonvisualobject
end type
global uo_sitef_retaguarda uo_sitef_retaguarda

type prototypes
FUNCTION Long ObtemVersao(Ref String VersaoCliSiTef,Ref String VersaoCliSiTefI) library "c:\client\CliSiTef32I.dll" alias for "ObtemVersao;Ansi";

FUNCTION Long ConfiguraIntSiTefInterativo( Ref String pServidor, Ref String pLoja, Ref String pTerminal, String Reservado) Library "c:\client\CliSiTef32I.dll" alias for "ConfiguraIntSiTefInterativo;Ansi";

FUNCTION Long IniciaFuncaoSiTefInterativo(Long pModalidade, String pValor,String pCupom, String pDataFiscal, String pHorario, String pOperador, String pRestricoes) Library "c:\client\CliSiTef32I.dll" alias for "IniciaFuncaoSiTefInterativo;Ansi";

FUNCTION Long ContinuaFuncaoSiTefInterativo(Ref Long pComando, Ref Long pTipoCampo, Ref Integer pTamMin ,Ref Integer pTamMax ,Ref Char Buffer[0 to 20000],Long TamBuffer,Long Continua) Library "c:\client\CliSiTef32I.dll" alias for "ContinuaFuncaoSiTefInterativo;Ansi";

FUNCTION Long ConfiguraIntSiTefInterativoA(Ref String Resultado, String pEnderecoIP, String pCodigoLoja, String pNumeroTerminal, String Reservado) Library "c:\client\CliSiTef32I.dll" alias for "ConfiguraIntSiTefInterativoA;Ansi";

FUNCTION Long ContinuaFuncaoSiTefInterativoA(Ref String  Resultado, Ref String pComando,Ref String pTipoCampo, Ref String pTamMin ,Ref String pTamMax ,Ref String Buffer,Long TamBuffer,Long Continua) Library "c:\client\CliSiTef32I.dll" alias for "ContinuaFuncaoSiTefInterativoA;Ansi";

FUNCTION Long FinalizaTransacaoSiTefInterativo (Integer Confirma, String CupomFiscal, String Data, String Horario) library "c:\client\CliSiTef32I.dll" alias for "FinalizaTransacaoSiTefInterativo;Ansi";

FUNCTION Long LeCartaoDireto( String pMensagem, Ref String pTrilha1, Ref String pTrilha2) library "c:\client\CliSiTef32I.dll" alias for "LeCartaoDireto;Ansi";

FUNCTION Long InterrompeLeCartaoDireto() library "c:\client\CliSiTef32I.dll";

FUNCTION Long LeCartaoDiretoEx( String pMensagem, Ref String pTrilha1, Ref String pTrilha2, Long TimeOut, Long TestaCancela ) library "c:\client\CliSiTef32I.dll" alias for "LeCartaoDiretoEx;Ansi";

FUNCTION Long LeCartaoInterativo(String pMensagem) library "c:\client\CliSiTef32I.dll" alias for "LeCartaoInterativo;Ansi";

FUNCTION Long LeSenhaInterativo( Ref String pParametros ) library "c:\client\CliSiTef32I.dll" alias for "LeSenhaInterativo;Ansi";

FUNCTION Long LeSenhaDireto(Ref String pParametros,Ref String pSenha) library "c:\client\CliSiTef32I.dll" alias for "LeSenhaDireto;Ansi";

FUNCTION Long VerificaPresencaPinPad() library "c:\client\CliSiTef32I.dll";

FUNCTION Long ValidaCampoCodigoEmBarras(Ref String pDados, Ref String pTipo) library "c:\client\CliSiTef32I.dll" alias for "ValidaCampoCodigoEmBarras;Ansi";

FUNCTION Long LeSimNaoPinPad(String pMensagem) library "c:\client\CliSiTef32I.dll" alias for "LeSimNaoPinPad;Ansi";

FUNCTION Long ObtemQuantidadeTransacoesPendentes(String pData, String pCupom) library "c:\client\CliSiTef32I.dll" alias for "ObtemQuantidadeTransacoesPendentes;Ansi";

// COMUNICA$$HEX2$$c700c200$$ENDHEX$$O DIRETA

FUNCTION Long EnviaRecebeSiTefDireto(Long RedeDestino, Long FuncaoSiTef, Long OffsetCartao, Char DadosTx[], Long TamDadosTx, Ref Char DadosRx[0 To 10000], Ref Long TamMaxDadosRx, Ref Long CodigoResposta, Ref Long TempoEsperaRx, String pCupom, String pDataFiscal, String pHorario, String pOperador, Long TipoOperacao) Library "c:\client\CliSiTef32I.dll" alias for "EnviaRecebeSiTefDireto;Ansi";

FUNCTION Long ForneceParametroEnviaRecebeSiTefDireto(Long IndiceParametro, String Parametro, Long ParametroCartao, Long Delimitador) Library "c:\client\CliSiTef32I.dll" alias for "ForneceParametroEnviaRecebeSiTefDireto;Ansi";

FUNCTION Long ExecutaEnviaRecebeSiTefDireto(Long RedeDestino, Long FuncaoSiTef, Ref Long CodigoResposta, Long TempoEsperaRx, String pCupom, String pDataFiscal, String pHorario, String pOperador, Long TipoTransacao) Library "c:\client\CliSiTef32I.dll" alias for "ExecutaEnviaRecebeSiTefDireto;Ansi";

FUNCTION Long ObtemRetornoEnviaRecebeSiTefDireto(Ref String CodigoServico, Ref Char DadosServico[1 To 20000], Ref Long TamMaxServico)  Library "c:\client\CliSiTef32I.dll" alias for "ObtemRetornoEnviaRecebeSiTefDireto;Ansi";

SUBROUTINE ObtemRetornoEnviaRecebeSiTefDiretoA(Ref String Resultado, Ref Char CodigoServico,  Ref Char DadosServico[0 To 10000], Ref Long TamMaxServico) ALIAS FOR "ObtemRetornoEnviaRecebeSiTefDiretoA;Ansi" Library "c:\client\CliSiTef32I.dll" ;
end prototypes

type variables
dc_uo_ds_base ds_servico

//uo_edm_sitef           EdmCard

LONG     cd_funcao
LONG     nr_pdv
LONG     nr_ecf
LONG     id_Status
LONG     qt_parcelas
LONG     nr_parcelas_maximo
LONG     nr_cupom
Long     tipo_campo

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

STRING msg_cliente
STRING msg_operador

STRING cd_modalidade
STRING cd_forma_pagamento
STRING de_modalidade
STRING cd_autorizadora
STRING cd_bandeira
STRING de_bandeira
STRING cd_estabelecimento
STRING nr_nsu_sitef
STRING nr_nsu_host
STRING nr_autorizacao
STRING nr_cartao
STRING nr_bin_cartao
STRING de_via_cliente
STRING de_via_caixa

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

STRING nr_vidalink_autorizacao
STRING nr_vidalink_cnpj
STRING de_vidalink_plano

//Recupera dados do cart$$HEX1$$e300$$ENDHEX$$o caso seja Disque
String nr_cartao_disque
String dh_validade_cartao_disque
String cd_seguranca_cartao_disque

LONG     nr_vidalink_produtos

BOOLEAN Impressao = False
BOOLEAN CompraSaque = False

//Valida$$HEX2$$e700e300$$ENDHEX$$o para forma de pagamento de recarga
BOOLEAN Recarga = False
BOOLEAN Recebimento = False

DATETIME dt_transacao
DATETIME dt_predatado

INTEGER nr_vias_comprovante_tef
INTEGER nr_controle_caixa

DECIMAL {2} vl_transacao
DECIMAL {2} vl_total_transacao
DECIMAL {2} vl_total_pbm
DECIMAL {2} vl_saque
DECIMAL {2} vl_parcela_minima
end variables

forward prototypes
public function boolean of_leitura_senha (string aparametros)
public function boolean of_leitura_senha_direto (string aparametros, ref string asenha)
public function boolean of_verifica_pinpad ()
public function boolean of_inicia_comunicacao ()
public function boolean of_restricao_funcao (string ps_tipo, ref string ps_restricao)
public function boolean of_transacao_cancelamento ()
public function boolean of_reimpressao_ultimo_comprovante ()
public function boolean of_transacao_gerencial ()
public function boolean of_transacao_pre_autorizacao (decimal avalor, long acupomfiscal, datetime adata, string aoperador)
public function boolean of_transacao_captura_pre_autorizacao ()
public function boolean of_solicita_autorizacao ()
public function boolean of_forma_pagamento_recarga (ref string ps_opcao)
public function boolean of_verifica_versao_dll ()
public function boolean of_mensagem_operador (string ps_mensagem)
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
public function boolean of_sitef_direto_servicod (String ps_Dados)
public function boolean of_cancela_pinpad ()
public function long of_sitef_direto_executa (long rededestino, long funcaositef, ref long codigoresposta, long tempoexperarx, string cupom, string datafiscal, string horario, string operador, long tipooperacao)
public function boolean of_versao_dll ()
public function boolean of_valida_parcela_minima (long pl_campo, string ps_parcela)
public function boolean of_valida_valor_saque (long pl_campo, string ps_saque)
public function boolean of_inclui_cartao_comprovante_prevenda (string acaixa, long acontrole_caixa, long aecf, long acupom)
public function boolean of_sequencial_comprovante_prevenda (string acaixa, long acontrole_caixa, ref long asequencial)
public function boolean of_verifica_dll ()
public function boolean of_valor_parcela_minima ()
public function boolean of_parcela_minima (string ps_bandeira)
public function long of_envia_recebe_direto (long rededestino, long funcaositef, long offsetcartao, string dadostx, ref string dadosrx, ref long codigoresposta, ref long tempoexperarx, string cupom, string datafiscal, string horario, string operador, long tipooperacao)
public function boolean of_continua_impressao_comprovante ()
public function boolean of_mensagem_operador (string ps_mensagem, boolean pb_cancelar)
public function integer of_oculta_dados_cartao ()
public subroutine of_valida_bandeira_produto (ref string ps_bandeira)
public function boolean of_transacao_recarga (datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_localiza_cupom_fiscal (long afuncao, datetime adata, long aecf, long acupom, ref long afilial, ref long adoc, ref string aespecie, ref string aserie)
public function boolean of_localiza_cupom_fiscal (datetime adata, long aecf, long acupom)
public function boolean of_habilita_compra_saque ()
public function boolean of_transacao_pagamento_edm (decimal avalor, long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_transacao_prevenda (decimal avalor, long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_sitef_direto_retorno ()
public function boolean of_transacao_pagamento (string atransacao, decimal avalor, long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa)
public function boolean of_configura_automatico ()
public function boolean of_transacao_cancelamento_credito_debito (datetime adata, string aoperador)
public function boolean of_transacao_administrativa (datetime adata, string aoperador, long aecf, string acaixa, long acontrole_caixa)
public function boolean of_transacao_consulta_cheque ()
public function boolean of_finaliza_transacao_prevenda ()
public function boolean of_configura ()
public function boolean of_registra_impressao_comprovante ()
public function boolean of_sequencial_comprovante_caixa (string acaixa, long acontrole_caixa, ref long asequencial)
public function boolean of_inicializa ()
public function boolean of_inicia_funcao_tef ()
public function boolean of_reimpressao_comprovante_especifico ()
public function boolean of_cancela_transacao (boolean pb_mostra_resumo)
public function long of_verifica_transacao_pendente_servidor ()
public function boolean of_registra_prevenda ()
public function boolean of_inclui_cartao_comprovante_venda (string acaixa, long acontrole_caixa, long aecf, long acupom)
public function boolean of_cancela_transacao ()
public function boolean of_biblioteca ()
public function boolean of_registra_transacao_tef_pendente ()
public function boolean of_finaliza_transacao ()
public function boolean of_impressao_comprovante ()
public function boolean of_transacao_pendente (long pl_ecf)
public function boolean of_inicializa_comprovante_tef (boolean pb_erro)
public function boolean of_controla_interacao_dll ()
public subroutine of_controle_arquivos_log ()
public function boolean of_lanca_comprovante_caixa ()
public function boolean of_transacao_tef (long afuncao)
public function boolean of_transacao_tef (long afuncao, string arestricao)
public function boolean of_confirma_transacao ()
public function boolean of_confirma_transacao (boolean pb_mostra_resumo)
public function boolean of_busca_bandeira (string ps_tipo_cartao, long pl_codigo, long pl_administradora, ref string ps_nome_bandeira)
end prototypes

public function boolean of_leitura_senha (string aparametros);
Long ll_Retorno

ll_Retorno = LeSenhaInterativo(aParametros)

Choose Case ll_Retorno
	Case 0
		Return True
End Choose

Return False

end function

public function boolean of_leitura_senha_direto (string aparametros, ref string asenha);
Long ll_Retorno

ll_Retorno = LeSenhaDireto(aParametros,Ref aSenha)

Choose Case ll_Retorno
	Case 0
		Return True
End Choose

Return False
end function

public function boolean of_verifica_pinpad ();
Long ll_Retorno

ll_Retorno = VerificaPresencaPinPad() 

Choose Case ll_Retorno
	Case -1	
		MessageBox('uo_sitef_retaguarda','Biblioteca de comunica$$HEX2$$e700e300$$ENDHEX$$o com o PINPAD n$$HEX1$$e300$$ENDHEX$$o foi localizada.',StopSign!)
	Case 0
		MessageBox('uo_sitef_retaguarda','N$$HEX1$$e300$$ENDHEX$$o existe PINPAD conectado !',Exclamation!)
	Case 1
		MessageBox('uo_sitef_retaguarda','PINPAD conectado !')
		Return True
End Choose		

Return False
		
	
		
end function

public function boolean of_inicia_comunicacao ();
Integer li_Retorno

String ls_Resultado
String ls_Log

Open(w_ge112_aguarde)
w_ge112_aguarde.wf_mensagem("Conectando Servidor SITEF ...")

SetPointer(HourGlass!)

li_Retorno = ConfiguraIntSitefInterativo(Ref This.nr_servidor_tef,This.id_empresa_tef,This.de_terminal_tef,'000000')

Close(w_ge112_aguarde)

Choose Case li_Retorno
	Case 0		
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

public function boolean of_restricao_funcao (string ps_tipo, ref string ps_restricao);
dc_uo_ds_base ds_restricao
ds_restricao = Create dc_uo_ds_base

If Not ds_restricao.of_ChangeDataObject('dw_ge112_restricao_tef_filial') Then Return False

ds_restricao.Retrieve(ps_tipo)

Long ll_Row

If ds_restricao.RowCount() > 0 Then 
	
	ps_restricao = '['
	
	For ll_row = 1 To ds_restricao.RowCount()
		
		ps_restricao += String(ds_restricao.object.cd_modalidade[ll_row],'00') + ';'
				
	Next	
	
	ps_restricao += ']'
		
End If

Destroy(ds_restricao)

Return True

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
This.dt_transacao = DateTime(Date(adata),Now())
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
Integer li_TamMax = 10

ls_Parametro = String(30,'00000')+';'+String(li_TamMin,'00000')+';'+String(li_TamMax,'00000')+';N$$HEX1$$fa00$$ENDHEX$$mero da Autoriza$$HEX2$$e700e300$$ENDHEX$$o'

//Solicita n$$HEX1$$fa00$$ENDHEX$$mero da autoriza$$HEX2$$e700e300$$ENDHEX$$o
OpenWithParm(w_ge112_coleta_campo,ls_Parametro)

ls_Parametro = Message.StringParm

If ls_Parametro = "CANCELAR" Then Return False

//This.nr_vidalink_autorizacao = Trim(ls_Parametro)

Return True

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
//Long   ll_Retorno
//
//String ls_CliSitef  = Space(64)
//String ls_CliSitefI = Space(64)
//
//ll_Retorno = ObtemVersao(ls_CliSitef, ls_CliSitefI)
//
//If ll_Retorno <> 0 Then 
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao verificar vers$$HEX1$$e300$$ENDHEX$$o da CliSitef.",StopSign!)
//	Return False
//End If
//
//If lower('1.01.c.094.61') <> ls_CliSitef Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Vers$$HEX1$$e300$$ENDHEX$$o CliSitef.dll " + ls_CliSitef + " desatualizada. Favor contactar suporte.",Exclamation!)
//End If
//
//If lower('1.01.a.55') <> ls_CliSitefI Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Vers$$HEX1$$e300$$ENDHEX$$o CliSitef.dll " + ls_CliSitefI + " desatualizada. Favor contactar suporte.",Exclamation!)
//End If

Return True

end function

public function boolean of_mensagem_operador (string ps_mensagem);Return of_Mensagem_Operador(ps_mensagem,False)
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

		OpenWithParm(w_ge112_selecao_menu,ls_Menu)
		
		Yield()
		
		ls_opcao = Message.StringParm
	
		Choose Case ls_opcao
			Case "CANCELAR","VOLTAR"
				Return False
			Case Else
				
//				This.TrnCentre.Cd_Operadora = Trim(ls_Opcao)
//				This.TrnCentre.De_Operadora = Mid(ls_Menu,Pos(ls_Menu,Trim(ls_Opcao))+4,20)
				Return True
				
		End Choose
		
	Case "p" ; Return True
		
End Choose

Return False
end function

public function boolean of_leitura_cartao_interativo (ref string ps_digitado, ref string ps_trilha1, ref string ps_trilha2);
Long ll_Retorno
Long ll_Reservado

ll_Reservado = 0

ll_Retorno = LeCartaoInterativo("Insira ou passe o cartao")

Choose Case ll_Retorno
	Case 0
		Return True
	Case 13
		MessageBox("Sitef","Leitura cancelada pelo Operador.",Exclamation!)
	Case Else
		MessageBox("Sitef","(8) Erro ao executar a leitura do cart$$HEX1$$e300$$ENDHEX$$o.",StopSign!)
End Choose

Return False
end function

public function boolean of_leitura_cartao ();
String ls_Trilha1 = Space(128)
String ls_Trilha2 = Space(64)

Long ll_Retorno

If VerificaPresencaPinPad() = 1 Then  // Existe Pinpad conectado

	Do While True

		ll_Retorno = LeCartaoDireto('Insira ou passe o cartao', ls_Trilha1, ls_Trilha2 )
		
	//	ll_Retorno = LeCartaoDiretoEx('Insira ou passe o cartao', ls_Trilha1, ls_Trilha2, 0, of_Testa_Cancelamento_PinPad() )
		
		Choose Case ll_Retorno
			Case 0
				
				This.Id_Cartao_Digitado = False
				This.de_Cartao_Trilha1 = ls_Trilha1
				This.de_Cartao_Trilha2 = ls_Trilha2
							
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

OpenWithParm(w_ge112_leitura_cartao,ps_Titulo)

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

If Not This.id_Cartao_Digitado Then
	ls_LeituraCartao  = '1'
Else
	ls_LeituraCartao = '2'
End If	

pl_Indice ++

If Not of_Sitef_Direto_Parametro(pl_Indice,ls_LeituraCartao,0,0) = 0 Then Return False

If This.id_Cartao_Digitado Then
	
	ls_Cartao = This.de_Cartao_Digitado
	
	pl_Indice ++
	
	If Not of_Sitef_Direto_Parametro(pl_Indice,ls_Cartao,1,0) = 0 Then Return False
	
Else
	
	ls_Trilha1 = This.de_Cartao_Trilha1
	ls_Trilha2 = This.de_Cartao_Trilha2
	
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

public function boolean of_verifica_dll ();Return True

Boolean	lb_Sucesso 		= True
Boolean	lb_Existe 		= False

String	ls_Path 	 		= 'C:\Client'
String   ls_Path_System

String 	ls_Versao
String	ls_Valor
String	ls_Error

String	ls_CliSitef[]

Long 	 	ll_Row
Long 	 	ll_File

Open(w_Aguarde_1)

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

ls_CliSitef[1] = 'CliSiTef32.dll'
ls_CliSitef[2] = 'CliSiTef32I.dll'
ls_CliSitef[3] = 'libseppemv.dll'

lb_Existe = FileExists(ls_Path + '\' + ls_CliSitef[1] ) And &
				FileExists(ls_Path + '\' + ls_CliSitef[2] ) And &
				FileExists(ls_Path + '\' + ls_CliSitef[3] ) And &
				FileExists(ls_Path + '\' + 'Versao-CliSitef-' + ls_Versao + '.txt' )
				
If Not lb_Existe Then
	
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
			
			lo_Ftp.of_Ftp_Set_Dir('dll_tl')
			
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
								
		w_Aguarde_1.Title = "Verificando Atualiza$$HEX2$$e700e300$$ENDHEX$$o CliSitef ..."
		
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
		
		dc_uo_zip lo_Zip
		lo_Zip = Create dc_uo_zip
		
		If lb_Sucesso Then
			
			w_Aguarde_1.Title = "Atualizando CliSitef ... "
	
			If lo_Ftp.of_Conecta_Ftp("Verifica Versao", ls_Valor, "pdv2", "pdv2") Then
				
				lo_Ftp.of_Ftp_Set_Dir('dll_clisitef')
				
				If Not lo_Ftp.of_Ftp_GetFile("clisitef.zip", ls_Path + "\clisitef.zip") Then
					
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao atualizar CliSitef")
					
					lb_Sucesso = False
					
				Else
					
					lo_Zip.of_UnZip_Origem(ls_Path + '\clisitef.zip')
					lo_Zip.of_UnZip_Destino(ls_Path + '\')
					
					ls_Error = lo_Zip.of_UnZip(True)
					
					If ls_Error <> "" Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Error, StopSign!)
					Else
						lb_Sucesso = True
					End If
	
				End If
				
			End If
			
		End If
		
		If IsValid(lo_Zip) Then Destroy(lo_Zip)
		
		If lb_Sucesso Then
			
			 ll_File = FileOpen(ls_Path + '\' + 'Versao-CliSitef-' + ls_Versao + '.txt',linemode!,Write!,Shared!,Replace!)
			 
			 If ll_File = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao atualizar " + ls_Versao + '\' + 'Versao-CliSitef-' + ls_Valor + '.txt')
				lb_Sucesso = False
			End If
			
			FileWrite(ll_File,String(Today(), "dd/mm/yyyy hh:mm:ss"))
			
			FileClose(ll_File)
			
		End If
		
	End If	
	
End If

If IsValid(lo_Ftp) Then Destroy lo_Ftp

If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)

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

public function boolean of_parcela_minima (string ps_bandeira);Boolean lb_Sucesso = False

String ls_Parametro

Long 		ll_Tabela

Decimal{2} ldc_Parcela_Minima

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

lb_Sucesso = lvo_Parametro.of_Localiza_Parametro("VL_PARCELA_MINIMA_TEF", ref ls_Parametro)

Destroy(lvo_Parametro)

If lb_Sucesso Then
	ldc_Parcela_Minima = Dec(ls_Parametro)
Else
	ldc_Parcela_Minima = 000.00
End If

SetNull(ll_Tabela)

Select count(*) Into :ll_Tabela
From sys.systable
Where table_name in ('bandeira_sitef','parametros_venda_tef')
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Verificando tabela bandeira_sitef")
	Return False
End If

If ll_Tabela = 2 Then
	
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
				
Else

	This.vl_parcela_minima = ldc_Parcela_Minima
	
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
												Ref ll_TamDadosRx,&
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

public function boolean of_continua_impressao_comprovante ();String  ls_Resposta

Boolean lb_Retorno

//Open(w_cl008_erro_impressao_comprovante)

ls_Resposta = Message.StringParm

If ls_Resposta = "1" Then
	MessageBox("Impressora Fiscal","Verifique se a impressora est$$HEX1$$e100$$ENDHEX$$ pronta para reimprimir e tecle <ENTER>.",Exclamation!)
	lb_Retorno = True
Else
	lb_Retorno = False
End If

Return lb_Retorno

end function

public function boolean of_mensagem_operador (string ps_mensagem, boolean pb_cancelar);
If Not IsValid(w_ge112_aguarde) Then
	Open(w_ge112_aguarde)
	w_ge112_aguarde.mle_1.text = ps_mensagem
Else
	If w_ge112_aguarde.mle_1.text <> ps_mensagem Then w_ge112_aguarde.mle_1.text = ps_mensagem
End If

If pb_cancelar Then
	
	If Not w_ge112_aguarde.cb_cancelar.Enabled Then
		w_ge112_aguarde.cb_cancelar.Enabled = True
		w_ge112_aguarde.Height              = 690
		w_ge112_aguarde.cb_cancelar.SetFocus()
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

public function boolean of_transacao_recarga (datetime adata, string aoperador, string acaixa, long acontrole_caixa);
Boolean  lb_Sucesso

Long     ll_ecf 
Long     ll_cupomfiscal

String   ls_funcao = "RC" 																		   // Transacao recarga
String   ls_restricao

ls_Restricao = "[61]"

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
This.cd_funcao    	  = 300
This.nr_cupom     	  = ll_CupomFiscal
This.nr_ecf       	  = ll_Ecf
This.dt_transacao 	  = DateTime(Date(adata),Now())
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

Return lb_Sucesso
end function

public function boolean of_localiza_cupom_fiscal (long afuncao, datetime adata, long aecf, long acupom, ref long afilial, ref long adoc, ref string aespecie, ref string aserie);Long     ll_sequencial

DateTime ldt_Movimento

If afuncao = 300 Then
	SetNull(afilial)
	SetNull(adoc)
	SetNull(aespecie)
	SetNull(aserie)
	Return True	
End If

ldt_Movimento = DateTime(Date(adata))
	
Select cd_filial,nr_nf,de_especie,de_serie
  Into :afilial,:adoc,:aespecie,:aserie
From nf_venda
Where dh_movimentacao_caixa = :ldt_Movimento
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

ldt_Movimento = DateTime(Date(adata))
	
Select cd_filial
  Into :ll_Filial
From nf_venda
Where dh_movimentacao_caixa = :ldt_Movimento
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
String  ls_funcao = "PC" 														            // Transacao pagamento
	
String  ls_restricao = ""

Boolean lb_Sucesso = False

If Not This.of_Restricao_Funcao(ls_funcao,Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

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

public function boolean of_sitef_direto_retorno ();Long 	 	ll_TamMaxServico
Long 	 	ll_Retorno
Long 	 	ll_Ind

String  	ls_DadosSitef
String   ls_Resultado

String 	ls_CodigoServico

Char   	ls_DadosServico[1 To 20000]

SetPointer(HourGlass!)

If Not ds_Servico.of_ChangeDataObject("dw_ge112_servico_sitef_direto") Then Return False

ds_servico.Reset()

Do While True
	
	ls_CodigoServico = Space(01)
	
	ll_TamMaxServico = 0
	
	ll_Retorno = ObtemRetornoEnviaRecebeSiTefDireto(Ref ls_CodigoServico,&
																	Ref ls_DadosServico,&
																	Ref ll_TamMaxServico)

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

public function boolean of_transacao_pagamento (string atransacao, decimal avalor, long aecf, long acupomfiscal, datetime adata, string aoperador, string acaixa, long acontrole_caixa);
String  ls_funcao = "PC" 														            // Transacao pagamento
	
String  ls_restricao = ""

Boolean lb_Sucesso = False

If Not This.of_Restricao_Funcao(ls_funcao,Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

Choose Case atransacao
	Case "CA" // D$$HEX1$$e900$$ENDHEX$$bito
		This.cd_funcao = 2
	Case "CP" // Cr$$HEX1$$e900$$ENDHEX$$dito
		This.cd_funcao = 3
	Case Else
		This.cd_funcao = 000000
End choose

This.nr_ecf            = aecf
This.nr_cupom          = acupomfiscal
This.dt_transacao      = DateTime(Date(adata),Now())
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

public function boolean of_configura_automatico ();Long lvl_Filial
String lvs_Rede

String lvs_empresa
String lvs_terminal
String lvs_terminalcli
String lvs_config

lvl_Filial 		= gvo_Parametro.of_Filial()

lvs_Empresa		= String(lvl_Filial, "00000000")
lvs_terminal	= "SW" + String(lvl_Filial, "0000") + RightA(gvo_Aplicacao.of_ComputerName(), 2)

If gf_rede_filial(Ref lvs_Rede) Then
	lvs_terminalcli = lvs_Rede + String(lvl_Filial, "0000") + RightA(gvo_Aplicacao.of_ComputerName(), 2)
Else
	lvs_terminalcli = lvs_terminal
End If


lvs_config = "c:\client\Cliente.ini"
SetProfileString(lvs_config,"CLIENTSITEF","Terminal", lvs_terminal)	
SetProfileString(lvs_config,"CLIENTSITEF","Empresa", lvs_Empresa)

lvs_config = "c:\client\clientsitef.ini"
SetProfileString(lvs_config,"CLIENTSITEF","Terminal", lvs_terminal)	
SetProfileString(lvs_config,"CLIENTSITEF","TerminalCliSitef", lvs_terminalcli)
SetProfileString(lvs_config,"CLIENTSITEF","Empresa", lvs_Empresa)

Return True
end function

public function boolean of_transacao_cancelamento_credito_debito (datetime adata, string aoperador);
Boolean  lb_Sucesso

Long     ll_ecf 
Long     ll_cupomfiscal

String   ls_funcao = "RC" 																		// Transacao recarga
String   ls_restricao

If Not This.of_Restricao_Funcao(ls_funcao,Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
This.cd_funcao    = 200
This.nr_cupom     = ll_CupomFiscal
This.dt_transacao = DateTime(Date(adata),Now())
This.vl_transacao = 000.00
This.de_operador  = aoperador
This.de_restricao = ls_restricao

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
		
End If

Return lb_Sucesso
end function

public function boolean of_transacao_administrativa (datetime adata, string aoperador, long aecf, string acaixa, long acontrole_caixa);
Boolean  lb_Sucesso

Long     ll_ecf 
Long     ll_cupomfiscal

String   ls_funcao    = "OF" 														// Transacao Administrativa
String   ls_restricao = ""

If Not PDV.of_dados_impressora(Ref ll_cupomfiscal, Ref ll_ecf) Then Return False

//Par$$HEX1$$e200$$ENDHEX$$metros para confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
This.cd_funcao    		= 110
This.nr_cupom     		= ll_CupomFiscal
This.nr_ecf       		= aecf
This.dt_transacao 		= DateTime(Date(adata),Now())
This.vl_transacao 		= 000.00
This.de_operador  		= aoperador
This.de_restricao 		= ls_restricao
This.cd_caixa          	= acaixa
This.nr_controle_caixa 	= acontrole_caixa

If This.of_Inicia_Funcao_Tef() Then

	lb_Sucesso = This.of_Controla_Interacao_dll()
	
	If lb_Sucesso Then
		lb_Sucesso = This.of_Finaliza_Transacao()
	End If
		
End If

Return lb_Sucesso
end function

public function boolean of_transacao_consulta_cheque ();
Boolean lb_Sucesso

String  ls_Restricao
String  ls_Funcao = "CC"

If Not This.of_Restricao_Funcao(ls_funcao,Ref ls_restricao) Then Return False	// Verifica restri$$HEX2$$e700f500$$ENDHEX$$es da filial

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

public function boolean of_configura ();
//Controla Hist$$HEX1$$f300$$ENDHEX$$rico de arquivos de Log mantendo somente $$HEX1$$fa00$$ENDHEX$$ltima semana
of_Controle_Arquivos_Log()

//Testa localiza$$HEX2$$e700e300$$ENDHEX$$o das bibliotecas de integra$$HEX2$$e700e300$$ENDHEX$$o
If Not This.of_Verifica_dll() Then Return False

of_configura_automatico()

String ls_empresa
String ls_terminal
String ls_servidor
String ls_captura
String ls_config

ls_config = "c:\client\clientsitef.ini"

ls_terminal = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Sitef_Terminal","")

If IsNull(ls_terminal) Or Trim(ls_terminal) = "" Then
	ls_terminal = ProfileString(ls_config,"CLIENTSITEF","TerminalCliSitef","none")	
	SetProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Sitef_Terminal", ls_terminal)
End If

ls_servidor = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Sitef_IP","")

If IsNull(ls_servidor) Or Trim(ls_servidor) = "" Then
	ls_servidor = ProfileString(ls_config,"CLIENTSITEF","End_TCP","none")
	SetProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Sitef_IP", ls_servidor)
End If

ls_empresa  = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Sitef_Empresa","")

If IsNull(ls_empresa) Or Trim(ls_empresa) = "" Then
	ls_empresa  = ProfileString(ls_config,"CLIENTSITEF","Empresa","none")	
	SetProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Sitef_Empresa", ls_empresa)
End If



ls_captura  = ProfileString(ls_config,"CLIENTSITEF","Captura","none")

If IsNull(ls_empresa) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existe identifica$$HEX2$$e700e300$$ENDHEX$$o da empresa no arquivo " + ls_config ,StopSign!)
	This.id_tef_ativo = "N"
	Return False
End If

If IsNull(ls_terminal) or Trim(ls_terminal) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existe identifica$$HEX2$$e700e300$$ENDHEX$$o do terminal CliSitef no arquivo " + ls_config ,StopSign!)
	This.id_tef_ativo = "N"
	Return False
End If

If IsNull(ls_Servidor) or Trim(ls_Servidor) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existe identifica$$HEX2$$e700e300$$ENDHEX$$o do Servidor TEF no arquivo " + ls_config ,StopSign!)
	This.id_tef_ativo = "N"
	Return False
End If

If ls_captura = '1' Then 
	ls_captura = 'S'
Else
	ls_captura = 'N'
End If	

This.de_terminal_tef         = ls_terminal
This.id_empresa_tef          = ls_empresa
This.nr_servidor_tef         = ls_servidor
This.nr_vias_comprovante_tef = 1
This.id_captura_transacao    = ls_captura

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

public function boolean of_inicializa ();
Impressao = False
CompraSaque = False

SetNull(is_Tipo_Venda)

SetNull(cd_Rede)
SetNull(id_Status)
SetNull(cd_funcao)
SetNull(msg_cliente)
SetNull(msg_operador)
SetNull(cd_forma_pagamento)
SetNull(cd_modalidade)
SetNull(de_modalidade)
SetNull(dt_transacao)
SetNull(cd_autorizadora)
SetNull(cd_bandeira)
SetNull(de_bandeira)
SetNull(nr_nsu_sitef)
SetNull(nr_nsu_host)
SetNull(nr_autorizacao)
SetNull(nr_cartao)
SetNull(nr_bin_cartao)
SetNull(de_via_cliente)
SetNull(de_via_caixa)
SetNull(dt_transacao)
SetNull(de_operadora)
SetNull(nr_celular)
SetNull(cd_estabelecimento)

SetNull(dt_predatado)

SetNull(nr_vidalink_autorizacao)
SetNull(nr_vidalink_cnpj)
SetNull(de_vidalink_plano)

SetNull(nr_cupom)
SetNull(nr_nsu_sitef)
SetNull(nr_nsu_host)
SetNull(nr_cupom)

SetNull(nr_cartao_disque)
SetNull(dh_validade_cartao_disque)
SetNull(cd_seguranca_cartao_disque)

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

nr_vidalink_produtos = 000

//This.EdmCard.of_Inicializa()

If Not This.of_Habilita_Compra_Saque() Then Return False

Return True
end function

public function boolean of_inicia_funcao_tef ();SetPointer(HourGlass!)

//Inicia Transacao TEF
This.id_Status = IniciaFuncaoSitefInterativo(This.cd_funcao,String(This.vl_transacao,'000000.00') , String(This.nr_cupom,'00000000') , String(This.dt_transacao,'yyyymmdd'),String(This.dt_transacao,'hhmmss'),This.de_operador,This.de_restricao)

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Inicializando nova transa$$HEX2$$e700e300$$ENDHEX$$o TEF:" + &
														" Fun$$HEX2$$e700e300$$ENDHEX$$o: [" + String(This.cd_funcao) + "]" + &
														" Valor: ["  + String(This.vl_transacao,'000000.00') + "]" + &
														" Cupom: ["  + String(This.nr_cupom,'00000000') + "]" + &
														" Data: ["   + String(This.dt_transacao,'dd/mm/yyyy hh:mm:ss') + "]" + &
														" Operador: [" + This.de_operador + "]" + &
														" Status: [" + String(This.id_Status) + "]")

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
		
End Choose

Return False
end function

public function boolean of_reimpressao_comprovante_especifico ();Boolean lb_Sucesso

lb_Sucesso = This.of_Transacao_Tef(113)

//This.of_Transacao_Pendente()

Return lb_Sucesso
end function

public function boolean of_cancela_transacao (boolean pb_mostra_resumo);
String ls_Cupom
String ls_Data
String ls_Hora

Long   ll_Registros

ls_Cupom = String(This.nr_cupom,'00000000')
ls_Data  = String(This.dt_transacao,'yyyymmdd')
ls_Hora  = String(Time(This.dt_transacao),'hhmmss')

//N$$HEX1$$e300$$ENDHEX$$o envia cancelamento para transa$$HEX2$$e700e300$$ENDHEX$$o de reimpress$$HEX1$$e300$$ENDHEX$$o $$HEX1$$fa00$$ENDHEX$$ltimo comprovante
If This.cd_funcao <> 114 Then

	FinalizaTransacaoSitefInterativo(0, Ref ls_Cupom, Ref ls_Data, Ref ls_Hora)
	
	If of_Verifica_Transacao_Pendente_Servidor() = 0 Then
	
		String ls_Chave
		
		ls_Chave = String(This.nr_ecf,'000') + String(This.nr_cupom,'00000000')
			
		If pb_Mostra_Resumo Then OpenWithParm(w_ge112_transacao_pendente,ls_Chave)
	
	Else
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Transa$$HEX2$$e700f500$$ENDHEX$$es pendentes Servidor TEF. N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o TEF pendente: " + ls_Chave)
		Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"Transa$$HEX2$$e700f500$$ENDHEX$$es pendentes Servidor TEF. N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o TEF pendente: " + ls_Chave)
		Return False
	End If	
		
End If

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Transa$$HEX2$$e700e300$$ENDHEX$$o CANCELADA com sucesso. Cupom [" + ls_Cupom + "]")
	
Update cartao_comprovante_venda
Set id_cancelamento_Sitef = 'S'
Where cd_caixa          = :This.cd_caixa
  and nr_controle_caixa = :This.nr_controle_caixa
  and nr_ecf            = :This.nr_ecf
  and nr_coo_ecf        = :This.nr_cupom
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o do comprovante cart$$HEX1$$e300$$ENDHEX$$o venda: " + Sqlca.SqlErrText)
	Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o do comprovante cart$$HEX1$$e300$$ENDHEX$$o venda.")
	Return False
End If

ll_Registros += Sqlca.SqlnRows

If ll_Registros = 0 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o comprovante cart$$HEX1$$e300$$ENDHEX$$o venda. Fun$$HEX2$$e700e300$$ENDHEX$$o:" + String(This.cd_Funcao) + ' ECF [' + String(This.nr_ecf) + '] Cupom : [' + String(This.nr_cupom) + ']' )
End If
	
Delete From transacao_tef
Where nr_ecf      = :This.nr_ecf
  and nr_coo_ecf  = :This.nr_cupom
Using Sqlca;

If Sqlca.Sqlcode = -1 Then	
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o controle de transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
	Sqlca.of_MsgDbError(gvo_Aplicacao.ivi_log,"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o controle de transa$$HEX2$$e700e300$$ENDHEX$$o TEF.")
	Return False
End If	

ll_Registros += Sqlca.SqlnRows

If ll_Registros > 0 Then Sqlca.of_Commit()

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

If Not lds_comprovante.of_ChangeDataObject('dw_ge112_transacao_tef') Then
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
	
//	If ls_autorizadora = This.EdmCard.cd_Rede Then Continue

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
					ls_bandeira = 'VISA R'
				ElseIf Upper(Trim(ls_bandeira)) = 'VISA ELECTRON' Then
					ls_bandeira = 'VISA ELECTRON R'
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
				ll_Registro ++		
			End If
			
		End If	
		
	End If	
		
Next

Destroy(lds_comprovante)

If lb_Sucesso Then
	If ll_Registro > 0 Then
		Sqlca.of_Commit()
	End If
Else
	Sqlca.of_RollBack()
End If	

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

public function boolean of_cancela_transacao ();Return This.of_Cancela_Transacao(True)
end function

public function boolean of_biblioteca ();
If Not FileExists('CliSiTef32I.dll') Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Biblioteca de integra$$HEX2$$e700e300$$ENDHEX$$o com SITEF n$$HEX1$$e300$$ENDHEX$$o encontrada.",StopSign!)
	
	Return False

End If

Return True
end function

public function boolean of_registra_transacao_tef_pendente ();
If Not This.impressao and This.cd_funcao <> 300 Then Return True

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

If Not IsNull(This.nr_Cartao) Then
	ls_Cartao = This.nr_Cartao
Else
	ls_Cartao = This.nr_Bin_Cartao
End If	

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
		dt_predatado)  
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
		 :This.dt_transacao,
		 :ls_cartao,
		 :This.qt_parcelas,
		 :This.de_via_caixa,
		 :This.de_via_cliente,
		 :This.cd_estabelecimento,
		 :This.nr_celular,
		 :This.cd_caixa,
		 :This.nr_controle_caixa,
		 'P',
		 :This.dt_predatado)
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

public function boolean of_finaliza_transacao ();Boolean lb_Sucesso, &
		  lb_Comprovante

//N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ necessidade de impress$$HEX1$$e300$$ENDHEX$$o e confirma$$HEX2$$e700e300$$ENDHEX$$o		  
If Not This.Impressao Then Return True

//Efetua o lan$$HEX1$$e700$$ENDHEX$$amento de todos
//This.of_lanca_comprovante_caixa()

//Transa$$HEX2$$e700e300$$ENDHEX$$o com impress$$HEX1$$e300$$ENDHEX$$o de comprovante
If This.Impressao Then

	//Imprime comprovante da Transa$$HEX2$$e700e300$$ENDHEX$$o
	lb_Comprovante = This.of_impressao_comprovante()

	If lb_Comprovante Then		
		//Efetua o lan$$HEX1$$e700$$ENDHEX$$amento de todos
		This.of_lanca_comprovante_caixa()
		
		//Confirma a terceira perna da transa$$HEX2$$e700e300$$ENDHEX$$o
		This.of_confirma_transacao()		
		
		lb_Sucesso = True
											
	Else

		//Cancela transa$$HEX2$$e700e300$$ENDHEX$$o
		This.of_cancela_Transacao()
				
		lb_Sucesso = False
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de reter o comprovante da venda TEF, pois a transa$$HEX2$$e700e300$$ENDHEX$$o foi cancelada.",Exclamation!)
		
	End If
			
End If
		
Return lb_Sucesso
end function

public function boolean of_impressao_comprovante ();
String  ls_Linha,&
        ls_Comprovante,&
        ls_Resposta
	
Long    	ll_Row	
Long    	ll_Byte
Long    	ll_Via

Boolean lb_Impressao ,&
		  lb_Abertura  ,&
        lb_Tentar
		
dc_uo_ds_base lds_comprovante
lds_comprovante = Create dc_uo_ds_base

If Not lds_comprovante.of_ChangeDataObject('dw_ge112_transacao_tef') Then Return False

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas com cupom fiscal impresso que precisam ser confirmadas
lds_comprovante.of_RestoreSqlOriginal()
lds_comprovante.of_AppendWhere("id_situacao <> 'C' and nr_ecf = " + String(This.nr_ecf) + " and nr_coo_ecf = " + String(This.nr_cupom) + " and (cd_forma_pagamento in ('01', '02', '03') Or cd_funcao in (300,110,594))")

lds_comprovante.Retrieve()

For ll_Row = 1 To lds_comprovante.RowCount()
	ls_comprovante = ''

	//For ll_Row = 1 To lds_comprovante.RowCount()
		
		If Not IsNull(lds_comprovante.object.de_via_cliente[ll_Row]) Then
			ls_Comprovante += lds_comprovante.object.de_via_cliente[ll_Row]
			If This.cd_funcao = 300 Then
				ls_Comprovante += CharA(10) + "											"
				ls_Comprovante += CharA(10) + " - - - - - - - - - - - - - - recorte - - 8< - -"
				ls_Comprovante += CharA(10) + "                                 " + CharA(10)
				ls_Comprovante += lds_comprovante.object.de_via_cliente[ll_Row]
			End If	
		End If
		
	//Next
				  
	lb_Impressao = True
	
	If IsNull(ls_Comprovante) Then ls_Comprovante = ""
	
	//For ll_Row = 1 To lds_comprovante.RowCount()
	
		If Not IsNull(lds_comprovante.object.de_via_caixa[ll_Row]) Then
			
			If ls_Comprovante <> "" Then
				ls_Comprovante += CharA(10) + "											"
				ls_Comprovante += CharA(10) + " - - - - - - - - - - - - - - recorte - - 8< - -"
				ls_Comprovante += CharA(10) + "                                 " + CharA(10)
			End If	
		
			ls_Comprovante += lds_comprovante.object.de_via_caixa[ll_Row]
			
			ls_Comprovante += CharA(10) + "											"
			ls_Comprovante += CharA(10) + "                                 " + CharA(10)
		
		End If
		
	//Next	
	
	If IsNull(ls_Comprovante) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Comprovante n$$HEX1$$e300$$ENDHEX$$o foi retornado para impress$$HEX1$$e300$$ENDHEX$$o.",Exclamation!)
		Return False
	End If
	
	This.vl_Transacao 		= lds_comprovante.object.vl_transacao			[ll_Row]
	This.cd_forma_pagamento = lds_comprovante.object.cd_forma_pagamento	[ll_Row]
	
	//Voucher GoodCard - Muda para credito
	If This.cd_forma_pagamento = '03' Then This.cd_forma_pagamento = '02'
	
	lb_Impressao = True
	
	Do While True
		
//		If IsValid(w_cl002_processando) Then CLOSE(w_cl002_processando)
		If IsValid(w_ge112_aguarde) Then CLOSE(w_ge112_aguarde)
		 
		IF NOT lb_Impressao THEN
			 
			IF Of_Continua_Impressao_Comprovante() THEN
				lb_Tentar = TRUE
			ELSE
				RETURN FALSE
			END IF
			 
			IF NOT PDV.of_Fecha_Comprovante_Tef() THEN CONTINUE
			 
			lb_Impressao = TRUE
			 
		END IF
		 
		IF NOT of_inicializa_comprovante_tef(lb_Tentar) THEN
			lb_Impressao = FALSE
			EXIT
		END IF
		 
		ll_Via = 1
	 
		Do While ll_Via <= This.nr_vias_comprovante_tef
			
			ls_Linha = ''
			 
			For ll_Byte = 1 TO LenA(ls_Comprovante)
				
				If MidA(ls_Comprovante,ll_Byte,1) = CharA(10) Then
					If Not IsNull(ls_Linha) and Trim(ls_Linha) <> "" Then
						If Not PDV.of_texto_nao_fiscal_tef(ls_Linha) Then 
							lb_Impressao = False
							Exit
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
			
				If Not PDV.of_texto_nao_fiscal_tef(ls_Linha) Then lb_Impressao = False
				
				ls_Linha = ""
				
			End If
			 
		Loop
	 
		If Not lb_Impressao Then Continue
		 
		If Not PDV.of_Fecha_Comprovante_Tef() Then
			lb_Impressao = False
			Continue
		End If
		 
		If Not PDV.Of_Aguarda_Execucao_Comando_Tef() Then
			lb_Impressao = False
			Continue
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
 
//If IsValid(w_cl002_processando) Then CLOSE(w_cl002_processando)

If lb_Impressao Then	of_Registra_Impressao_Comprovante()
 
Return lb_Impressao
end function

public function boolean of_transacao_pendente (long pl_ecf);String ls_Situacao 

dc_uo_ds_base lds_pendencia
lds_pendencia = Create dc_uo_ds_base

If Not lds_pendencia.of_ChangeDataObject('dw_ge112_transacao_tef') Then Return False

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas com cupom fiscal impresso que precisam ser confirmadas
lds_pendencia.of_RestoreSqlOriginal()
lds_pendencia.of_AppendWhere("nr_ecf = " + String(pl_ecf) + " and id_situacao <> 'E'")

lds_pendencia.Retrieve()

If lds_pendencia.RowCount() > 0 Then
	
	Do While lds_pendencia.RowCount() > 0
		
		ls_Situacao            = lds_pendencia.object.id_situacao 		[1]
		 	
		This.cd_funcao         = lds_pendencia.object.cd_funcao   		[1]
		This.nr_ecf            = lds_pendencia.object.nr_ecf      		[1]
		This.nr_cupom          = lds_pendencia.object.nr_coo_ecf  		[1]
		This.dt_transacao      = lds_pendencia.object.dt_transacao		[1]
		This.cd_caixa          = lds_pendencia.object.cd_caixa         [1]
		This.nr_controle_caixa = lds_pendencia.object.nr_controle_caixa[1]
				
		Choose Case This.Cd_Funcao
			Case 240,300								// Recarga Celular
				This.of_Cancela_Transacao(True)
			Case 542										
				This.of_Cancela_Transacao(True)				
				
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
		
		lds_pendencia.Retrieve()
		
	Loop
	
End If

This.of_Inicializa()

If IsValid(lds_pendencia) Then Destroy(lds_pendencia)

Return True
end function

public function boolean of_inicializa_comprovante_tef (boolean pb_erro);Boolean lvb_Retorno = False

Boolean lb_abertura
Boolean lb_abertura_nao_Fiscal = False

String  lvs_Recebimento,&
        lvs_Mensagem,&
		  lvs_Pagto
		  
Decimal {2} lvdc_Valor

Long    ll_Parcelas

Choose Case This.cd_funcao
	Case 240
		
		If Not IsNull(This.cd_forma_pagamento) Then
			
			Choose Case This.cd_forma_pagamento
				Case '98'				//Dinheiro
					lvs_Pagto = '01'
				Case '00'				//Cheque
					lvs_Pagto = '02'				
				Case '02'				//Credito
					lvs_Pagto = '04'
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
				lvs_Pagto = '04'
			Case '01'				//Debito
				lvs_Pagto = '05'
		End Choose
		
		If lvs_Pagto = '01' Then lb_abertura_nao_Fiscal = True
		
		lvs_Recebimento = '01'
		lvs_Mensagem    = 'TEF'
		
	Case 300 	
		
		lvs_Recebimento = '02'
		lvs_Mensagem    = 'RECARGA CELULAR ONLINE'
		
		Choose Case This.cd_forma_pagamento
			Case '98'				//Dinheiro
				lvs_Pagto = '01'
			Case '00'				//Cheque
				lvs_Pagto = '02'				
			Case '02'				//Credito
				lvs_Pagto = '04'
			Case '01'				//Debito
				lvs_Pagto = '05'
			End Choose
			
	Case Else
		
		lvs_Recebimento = '01'
		lvs_Mensagem    = 'TEF'
		//n$$HEX1$$e300$$ENDHEX$$o tinha
		lb_abertura_nao_Fiscal = True		
		
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
					lvs_Pagto = '04'
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

//If pb_erro or lb_abertura_nao_Fiscal or This.cd_funcao = 300 or This.cd_funcao = 110 or (This.vl_transacao < This.vl_total_transacao) or This.vl_total_pbm > 0 Then
If pb_erro or lb_abertura_nao_Fiscal or This.cd_funcao = 300 or This.cd_funcao = 110 Then
	If lvs_Pagto = '01' Then lvs_Pagto = '04' // Cartao Credito
	lb_abertura = PDV.of_inicializa_comprovante_tef_nao_fiscal(lvs_Recebimento,lvs_Mensagem,lvs_Pagto,lvdc_Valor)
Else
	lb_abertura = PDV.of_inicializa_comprovante_tef(lvs_Recebimento,lvs_Mensagem,lvs_Pagto,lvdc_Valor,This.qt_Parcelas, String(This.nr_Cupom))
End If

If lb_Abertura Then
	Open(w_ge112_aguarde)
	w_ge112_aguarde.wf_mensagem('IMPRIMINDO COMPROVANTE TEF')
//	w_cl002_processando.mle_1.text  = "IMPRIMINDO COMPROVANTE TEF"
//	w_cl002_processando.st_msg.text = This.msg_operador
	lvb_Retorno = TRUE
Else
	MessageBox("TEF","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir cupom fiscal n$$HEX1$$e300$$ENDHEX$$o-vinculado, para impress$$HEX1$$e300$$ENDHEX$$o do comprovante TEF.",StopSign!)
END IF

Return lvb_Retorno
end function

public function boolean of_controla_interacao_dll ();/*
* Fun$$HEX2$$e700e300$$ENDHEX$$o   : M$$HEX1$$f300$$ENDHEX$$dulo Central integra$$HEX2$$e700e300$$ENDHEX$$o CliSiTef32.dll
* Data     : 25/07/2006
* Objetivo : Controla solicita$$HEX2$$e700f500$$ENDHEX$$es do Servidor SITEF atr$$HEX1$$e100$$ENDHEX$$ves da CliSiTef32.dll
*/

Char    ls_Buffer[0 to 20000]

String  ls_log
String  ls_Parametro
String  ls_Opcao
String  ls_Titulo_Menu
String  ls_Mensagem
String  ls_Titulo

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

String lvs_Teste

ll_ProximoComando = 0
ll_TipoCampo      = 0

li_TamanhoMinimo  = 0
li_TamanhoMaximo  = 0

ll_Continua = 0

This.qt_parcelas = 0

Do
	
	SetPointer(HourGlass!)
					
	This.id_Status = ContinuaFuncaoSiTefInterativo(ll_ProximoComando, ll_TipoCampo, li_TamanhoMinimo , li_TamanhoMaximo , ls_Buffer, UpperBound(ls_Buffer), ll_Continua)
			
	//Fecha Janela de Mensagem para o Operador
	If IsValid(w_ge112_aguarde) Then
		If ll_ProximoComando <> 11 and &
		   ll_ProximoComando <> 12 and &
			ll_ProximoComando <> 13 and &
			ll_ProximoComando <> 23 Then
			Close(w_ge112_aguarde)
		Else
			If w_ge112_aguarde.ivb_Cancelar Then ll_Continua = -1
		End If
	End If	

	Yield()
					
	If This.id_Status = 10000 Then 		// Sucesso na execu$$HEX2$$e700e300$$ENDHEX$$o da fun$$HEX2$$e700e300$$ENDHEX$$o inicial
			
		Choose Case ll_ProximoComando
			Case 0								// Armazenar Valor devolvido
																			
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
						
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Buffer,Question!,YesNo!,1) = 1 Then
					ll_Continua = 0
					ls_Buffer   = '0'
				Else
					ll_Continua = 0
					ls_Buffer   = '1'
				End If
			Case 21 								// Cria menu din$$HEX1$$e200$$ENDHEX$$micamente para sele$$HEX2$$e700e300$$ENDHEX$$o Operador
				
				ls_opcao = ls_Buffer
														
				If This.Recarga Then
					ls_Parametro = "S;" + String(LenA(ls_opcao),'0000')+';'+ls_opcao+ls_Titulo_Menu
				Else
					ls_Parametro = String(LenA(ls_opcao),'0000')+';'+ls_opcao+ls_Titulo_Menu
				End If
				

				OpenWithParm(w_ge112_selecao_menu,ls_Parametro)
				
				Yield()
				
				ls_opcao = Message.StringParm
				
				Choose Case ls_opcao
					Case "CANCELAR"
						ll_Continua = -1
					Case "VOLTAR"
						ll_Continua = 1
						Continue
					Case Else
						
						ls_Buffer   = Trim(ls_opcao)
						ll_Continua = 0
				End Choose
				
			Case 22 							// Aguarda confirma$$HEX2$$e700e300$$ENDHEX$$o do Operador

				If Not This.cd_Funcao = 590 Or LeftA(Trim(ls_Buffer), 15) <> "Nao existe tela" Then
					OpenWithParm(w_ge112_mostra_mensagem,ls_Buffer)
				
					Yield()
				End If				 
									
			Case 23 							// Aguarda confirma$$HEX2$$e700e300$$ENDHEX$$o [dig.senha ou leitura cart$$HEX1$$e300$$ENDHEX$$o]
				
				Yield()
				
				If Not of_Mensagem_Operador(This.msg_operador,True) Then
					ll_Continua = -1
				End If	
				
			Case 30 							// Coleta String						
			
					
				String ls_Recarga
				
				ls_Parametro = String(ll_ProximoComando,'00000')+';'+String(li_TamanhoMinimo,'00000')+';'+String(li_TamanhoMaximo,'00000')
				
				If This.cd_funcao = 300 and Not IsNull(This.de_operadora) Then
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
				End If
				
				Do While True
					
					This.Tipo_Campo = ll_TipoCampo
					OpenWithParm(w_ge112_coleta_campo_string,ls_Parametro)
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
							If ll_TipoCampo = 512 Then
								This.id_Cartao_Digitado = True
								This.de_Cartao_Digitado = ls_opcao
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
				
				If ll_Continua = 1 Then Continue
				
			Case 34 	// Coleta Num$$HEX1$$e900$$ENDHEX$$rico									
			

				//Compra e Saque
				If ll_TipoCampo = 130 and ( Not This.CompraSaque or This.cd_funcao = 300 or This.Vl_Transacao < 20.00 ) Then
					ls_Buffer   = '0'
					ll_Continua = 0
					Continue
				End If
				
				ls_Titulo = ls_Buffer
				
				If ll_TipoCampo = 130 Then
					ls_Titulo += CharA(10) + "Somente valor m$$HEX1$$fa00$$ENDHEX$$ltiplo de R$ 5,00 - M$$HEX1$$e100$$ENDHEX$$ximo R$ 100,00"
				End If
			
				ls_Parametro = String(ll_ProximoComando,'00000')+';'+String(li_TamanhoMinimo,'00000')+';'+String(li_TamanhoMaximo,'00000')+';'+ls_Titulo
				
				Do While True	
		
					OpenWithParm(w_ge112_coleta_campo_numerico,ls_Parametro)
					
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
			Case 100
				This.cd_forma_pagamento = MidA(ls_Buffer,01,02)
				This.cd_modalidade      = MidA(ls_Buffer,03,02)
			Case 101
				This.de_modalidade = Upper(Trim(ls_Buffer))
			Case 105
			Case 121
				This.impressao       = True
				This.de_via_cliente  = ls_Buffer
			Case 122
				This.impressao       = True							
				This.de_via_caixa    = ls_Buffer
			Case 130
				This.vl_saque        = Dec(ls_Buffer)
			Case 131			
								
				This.cd_autorizadora = Trim(ls_Buffer)
				
			Case 132
				
				This.cd_bandeira     = Trim(ls_Buffer)	

				//Processo para GETNETLAC. N$$HEX1$$e300$$ENDHEX$$o retorna nome da bandeira, ent$$HEX1$$e300$$ENDHEX$$o usamos o codigo do tef para gravar na bandiera certa.
				If Long(This.cd_autorizadora) = 181 Then
					If This.cd_forma_pagamento = '01' or This.cd_forma_pagamento = '02' Then
						of_busca_bandeira(This.cd_forma_pagamento,Long(This.cd_bandeira),Long(This.cd_autorizadora),This.de_bandeira)					
					End If
				End If		
				
				//Processo para Permitir apenas cart$$HEX1$$e300$$ENDHEX$$o AMEX pela Cielo.
				//Se mais cart$$HEX1$$f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o aceitos pela Cielo, RETIRAR essa verifica$$HEX2$$e700e300$$ENDHEX$$o.
				If Long(This.cd_autorizadora) = 125 Then				
					If Long(This.cd_bandeira) <> 4 And Long(This.cd_bandeira) <> 10013 Then					
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o aceito em nossa Rede!",Exclamation!)
						ll_Continua = -1
						Continue
					End If
				End If								
				
				If Not This.of_Parcela_Minima(This.cd_bandeira) Then Continue
				
			Case 133
				If IsNull(This.nr_nsu_sitef) Then
					This.nr_nsu_sitef = Trim(ls_Buffer)
				End If
			Case 134
				This.nr_nsu_host     = Trim(ls_Buffer)
			Case 135
				This.nr_autorizacao  = Trim(ls_Buffer)
			Case 136
				This.nr_bin_cartao   = Trim(ls_Buffer)							
			Case 146
				This.vl_transacao    = Dec(ls_Buffer)
			Case 156
				If Long(This.cd_autorizadora) <> 181 Then	This.de_bandeira     = Trim(ls_Buffer)
			Case 157
				This.cd_estabelecimento = Trim(ls_Buffer)
			Case 140,505,511
				This.qt_parcelas     = Long(ls_Buffer)
			Case 177, 178 //Campo complementar
			Case 506 //Cart$$HEX1$$e300$$ENDHEX$$o Banrisul D$$HEX1$$e900$$ENDHEX$$bito - Pr$$HEX1$$e900$$ENDHEX$$-Datado
				This.dt_predatado		= DateTime(Date(MidA(ls_Buffer,1,2) + "/" + MidA(ls_Buffer,3,2) + "/" + MidA(ls_Buffer,5,4)))
			Case 512
				This.nr_cartao       = Trim(ls_Buffer)				
			Case 590
				This.de_operadora    = Trim(ls_Buffer)
			Case 592
				This.nr_celular      = ls_Buffer
			Case 591
				This.vl_transacao    	= Dec(ls_Buffer)/100
				This.vl_total_transacao = This.vl_transacao
			Case 4018 //Valor a receber da Loja
				
		End Choose
		
		If Not IsNull( This.nr_nsu_host) Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Transa$$HEX2$$e700e300$$ENDHEX$$o TEF em curso. Transacao: [" + String(This.nr_autorizacao) + "] NSU: [" + String(This.nr_nsu_host) + "]")
		End If
		
	End If
		
Loop Until This.id_Status <> 10000

Long ll_Pos

ll_Pos = PosA(This.de_via_cliente, This.nr_cartao)
	
If ll_Pos > 0 Then
	This.de_via_cliente = MidA(This.de_via_cliente, 1, ll_Pos + 5) + "******" + &
								 MidA(This.de_via_cliente, ll_Pos + 12, 4) + MidA(This.de_via_cliente, ll_Pos + 22)
	
	This.de_via_caixa = MidA(This.de_via_caixa, 1, ll_Pos + 5) + "******" + &
							  MidA(This.de_via_caixa, ll_Pos + 12, 4) + MidA(This.de_via_caixa, ll_Pos + 22)
								 
	This.nr_cartao    = MidA(This.nr_cartao, 1, 6)
Else
	//n$$HEX1$$e300$$ENDHEX$$o tem no original
	This.nr_cartao    = This.nr_bin_cartao	
End If


If IsValid(w_ge112_aguarde) Then Close(w_ge112_aguarde)

//w_cl002_venda.wf_msg('')
//n$$HEX1$$e300$$ENDHEX$$o existia
//w_ge112_aguarde.wf_mensagem('')

//Verifica N$$HEX1$$fa00$$ENDHEX$$mero de Transa$$HEX2$$e700f500$$ENDHEX$$es Pendentes
ll_Pendentes = of_Verifica_Transacao_Pendente_Servidor()

If This.id_Status = 0 Then
	
	//Registra Transa$$HEX2$$e700e300$$ENDHEX$$o se necess$$HEX1$$e100$$ENDHEX$$rio para confirma$$HEX2$$e700e300$$ENDHEX$$o ou cancelamento
	If Not This.of_registra_transacao_tef_pendente() Then
		This.of_Cancela_Transacao(False)
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Transa$$HEX2$$e700e300$$ENDHEX$$o TEF cancelada. Transacao: [" + String(This.nr_autorizacao) + "] NSU: [" + String(This.nr_nsu_host) + "]")
		lb_Sucesso = False		
	Else
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Transa$$HEX2$$e700e300$$ENDHEX$$o TEF registrada. Transacao: [" + String(This.nr_autorizacao) + "] NSU: [" + String(This.nr_nsu_host) + "]")
		lb_Sucesso = True
	End If
		
	//Pagamento Cart$$HEX1$$e300$$ENDHEX$$o Cr$$HEX1$$e900$$ENDHEX$$dito ou D$$HEX1$$e900$$ENDHEX$$bito
/*	If This.TrnCentre.Id_Status <> "00" and ( This.cd_funcao = 2 or This.cd_funcao = 3 ) Then
		If ll_Pendentes > 1 Then
			This.of_Cancela_Transacao(False)
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Transa$$HEX2$$e700e300$$ENDHEX$$o TEF cancelada. Transacao: [" + String(This.nr_autorizacao) + "] NSU: [" + String(This.nr_nsu_host) + "]")
			lb_Sucesso = False
		End If
	End If*/
	
Else

//	If This.TrnCentre.Id_Status <> "00" and ll_Pendentes >= 1 Then
		This.of_registra_transacao_tef_pendente()
		This.of_Cancela_Transacao(False)
//	End If
	
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Transa$$HEX2$$e700e300$$ENDHEX$$o TEF cancelada. Transacao: [" + String(This.nr_autorizacao) + "] NSU: [" + String(This.nr_nsu_host) + "]")
	
	This.vl_total_transacao -= This.vl_transacao
	SetNull(This.dt_predatado)
	lb_Sucesso = False
	
End If

If Not lb_Sucesso Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Erro na execu$$HEX2$$e700e300$$ENDHEX$$o da fun$$HEX2$$e700e300$$ENDHEX$$o SITEF. Fun$$HEX2$$e700e300$$ENDHEX$$o: " + String(This.cd_Funcao) + "~rStatus: " + String(This.id_Status) + "~rBuffer: " + Trim(ls_Buffer))
End If

Return lb_Sucesso
end function

public subroutine of_controle_arquivos_log ();Long   ll_Row
 
String ls_Arquivos[]
String ls_Arquivo
String ls_Path = 'c:\client'

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

public function boolean of_lanca_comprovante_caixa ();
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
DateTime	ldt_predatado

Decimal  ldc_valor
Decimal  ldc_saque
Decimal  ldc_transacao

Long     ll_sequencial
Long     ll_row

dc_uo_ds_base lds_comprovante
lds_comprovante = Create dc_uo_ds_base

If Not lds_comprovante.of_ChangeDataObject('dw_ge112_transacao_tef') Then
	Destroy(lds_comprovante)
	Return False
End If

//Transa$$HEX2$$e700f500$$ENDHEX$$es aprovadas com cupom fiscal impresso que precisam ser confirmadas
lds_comprovante.of_AppendWhere("cd_forma_pagamento in ('01','02','03') and nr_ecf = " + String(This.nr_ecf) + " and nr_coo_ecf = " + String(This.nr_cupom) )

lds_comprovante.Retrieve()

If lds_comprovante.RowCount() = 0 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Sem comprovante a ser impresso ECF [" + String(PDV.ecf,'000') + "] Cupom [" + String(This.nr_cupom,'00000000')+"]")
	Return True
End If

For ll_Row = 1 To lds_comprovante.RowCount()
	 
	ls_autorizadora    = lds_comprovante.object.cd_autorizadora   [ll_Row] 
	
//	If ls_autorizadora = This.EdmCard.cd_Rede Then Continue

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
	ldt_predatado		 = lds_comprovante.object.dt_predatado		  [ll_Row]
	
	SetNull(ll_filial)
	SetNull(ll_doc)
	SetNull(ls_especie)
	SetNull(ls_serie)
	
	ls_cartao = LeftA(ls_cartao,6)
	
	//If ls_autorizadora = '00010' Then
	If Upper(Trim(ls_bandeira)) = 'TNEXX' Then
		ls_nsu_sitef = lds_comprovante.object.nr_nsu_sitef[ll_Row]
	Else
		ls_nsu_sitef = ls_nsu
	End If
		
	SetNull(ll_Sequencial)
	
	If This.of_Inclui_Cartao_Comprovante_Venda(ls_caixa, ll_controle_caixa, ll_ecf, ll_Cupom) Then
			
		If This.of_Sequencial_Comprovante_Caixa(ls_caixa, ll_controle_caixa, Ref ll_sequencial) Then
			
			If This.of_Localiza_Cupom_Fiscal(ll_funcao, ldt_data_transacao, ll_ecf, Ref ll_cupom, Ref ll_filial, Ref ll_doc, Ref ls_especie, Ref ls_serie ) Then
			
				ldc_transacao      = ldc_valor + ldc_saque
			
				ls_estabelecimento = MidA(ls_estabelecimento,2,10)
				
				ls_nsu		       = String(Long(ls_nsu),'000000')
				ls_nsu_sitef       = String(Long(ls_nsu_sitef),'000000')
				
				//Acerto para conciliacao HIPERCARD, depois que trocou a administradora somente o nsu_sitef
				//$$HEX1$$e900$$ENDHEX$$ a informacao que pode ser usada para encontrar os registros no arquivo que eles enviam.
				If Upper(Trim(ls_bandeira)) = 'HIPERCARD' Then
					ls_nsu = lds_comprovante.object.nr_nsu_sitef[ll_Row]
					ls_nsu = String(Long(ls_nsu),'000000')
				End If								
				
				This.of_valida_bandeira_produto(Ref ls_bandeira)
				
				//Acerto para vendas do cartao VISA e VISA ELECTRON autorizadas pela autorizadora 00005 - REDECARD
				If ls_Autorizadora = '00005' Then
					If Upper(Trim(ls_bandeira)) = 'VISA' Then
						ls_bandeira = 'VISA R'
					ElseIf Upper(Trim(ls_bandeira)) = 'VISA ELECTRON' Then
						ls_bandeira = 'VISA ELECTRON R'
					ElseIf Upper(Trim(ls_bandeira)) = 'HIPERCARD' Then
						ls_bandeira = 'HIPERCARD R'
					End IF					
					
					// Backup
//					If Upper(Trim(ls_bandeira)) = 'VISA' Or Upper(Trim(ls_bandeira)) = 'VISA ELECTRON' Then
//						String lvs_Aux
//						Select cd_estabelecimento
//						  Into :lvs_Aux
//						  From cartao_estabelecimento
//						 Where cd_administradora = 1
//						 Using SQLCa;
//						 
//						 If SQLCa.SQLCode = -1 Then
//								SQLCa.of_MsgDBError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo de estabelecimento VISA")
//						 ElseIF  SQLCa.SQLCode = 0 Then
//								ls_estabelecimento = lvs_Aux
//						 End If
//					End If
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
					  id_pre_venda,
					  dh_predatado)
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
						 'N',
						 :ldt_predatado)
				Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Lan$$HEX1$$e700$$ENDHEX$$amento do Comprovante Caixa")
					Sqlca.of_MsgDbError('Grava$$HEX2$$e700e300$$ENDHEX$$o do comprovante do cart$$HEX1$$e300$$ENDHEX$$o.')
					lb_Sucesso = False
					Exit
				Else
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Comprovante Caixa Lan$$HEX1$$e700$$ENDHEX$$ado. ECF [" + String(ll_ecf) + "], COO [" + String(ll_cupom) + "], SEQ [" + String(ll_sequencial) + "], NSU [" + ls_nsu + "]")
					ll_Registro ++		
				End If
				
			End If	
			
		End If	
		
	End If	
		
Next

Destroy(lds_comprovante)

If lb_Sucesso Then
	If ll_Registro > 0 Then
		Sqlca.of_Commit()
	End If
Else
	Sqlca.of_RollBack()
End If	

Return lb_Sucesso
end function

public function boolean of_transacao_tef (long afuncao);
Return This.of_Transacao_Tef(afuncao,'')
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
This.dt_transacao = DateTime(Today(),Now())
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
			
			This.of_Confirma_Transacao()
								
			lb_Sucesso = True
			
		Else
			
			This.of_Cancela_Transacao()
												
			lb_Sucesso = False
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de reter o comprovante da venda TEF, pois a transa$$HEX2$$e700e300$$ENDHEX$$o foi cancelada.",Exclamation!)
			
		End If
				
	End If
		
End If

Return lb_Sucesso
end function

public function boolean of_confirma_transacao ();
Return This.of_Confirma_Transacao(False)
end function

public function boolean of_confirma_transacao (boolean pb_mostra_resumo);
String ls_Cupom
String ls_Data
String ls_Hora

Long   ll_Registros

ls_Cupom = String(This.nr_cupom,'00000000')
ls_Data  = String(This.dt_transacao,'yyyymmdd')
ls_Hora  = String(Time(This.dt_transacao),'hhmmss')

//N$$HEX1$$e300$$ENDHEX$$o envia confirma$$HEX2$$e700e300$$ENDHEX$$o para transa$$HEX2$$e700e300$$ENDHEX$$o de reimpress$$HEX1$$e300$$ENDHEX$$o $$HEX1$$fa00$$ENDHEX$$ltimo comprovante
If This.cd_funcao <> 114 Then

	FinalizaTransacaoSitefInterativo(1, Ref ls_Cupom , Ref ls_Data , Ref ls_Hora )
	
	If pb_mostra_resumo Then
		
		String ls_Chave
		
		ls_Chave = String(This.nr_ecf,'000') + String(This.nr_cupom,'00000000')
		
		If pb_Mostra_Resumo Then OpenWithParm(w_ge112_transacao_confirmada,ls_Chave)
		
	End If
	
End If

//Inclus$$HEX1$$e300$$ENDHEX$$o do parametro cd_funcao not in (240,542, 592,593(TRNCentre New)) - Para imprimir os comprovante dos PBM como Relat$$HEX1$$f300$$ENDHEX$$rios Gerenciais

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Transa$$HEX2$$e700e300$$ENDHEX$$o efetuada com sucesso. Cupom [" + ls_Cupom + "]")

Delete From transacao_tef
Where nr_ecf     = :This.nr_ecf
  and nr_coo_ecf = :This.nr_cupom
  and cd_funcao not in (2,3)
  and cd_funcao not in (240, 542, 592, 593)
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Exclus$$HEX1$$e300$$ENDHEX$$o do registro da transa$$HEX2$$e700e300$$ENDHEX$$o TEF: " + Sqlca.SqlErrText)
	Return False
End If

ll_Registros += Sqlca.SqlnRows

Delete From transacao_tef
Where nr_ecf     = :This.nr_ecf
  and nr_coo_ecf = :This.nr_cupom
  and ( cd_funcao = 2 or cd_funcao = 3 )
  and Exists ( Select *
					  From cartao_comprovante_venda
					 Where cd_caixa 			 = :This.cd_caixa
						and nr_controle_caixa = :This.nr_controle_caixa
						and nr_ecf            = :This.nr_ecf
						and nr_coo_ecf        = :This.nr_cupom )
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Exclus$$HEX1$$e300$$ENDHEX$$o do registro da transa$$HEX2$$e700e300$$ENDHEX$$o TEF: " + Sqlca.SqlErrText)
	Return False
End If

ll_Registros += Sqlca.SqlnRows

Delete From transacao_tef
Where nr_ecf     		 = :This.nr_ecf
  and nr_coo_ecf		 = :This.nr_cupom
  and cd_autorizadora = '00019'
  and ( cd_funcao = 2 or cd_funcao = 3 )
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log,"Exclus$$HEX1$$e300$$ENDHEX$$o do registro da transa$$HEX2$$e700e300$$ENDHEX$$o TEF: " + Sqlca.SqlErrText)
	Return False
End If

ll_Registros += Sqlca.SqlnRows

If ll_Registros > 0 Then Sqlca.of_Commit()

Return True
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
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar bandeira do cart$$HEX1$$e300$$ENDHEX$$o.",StopSign!)
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

on uo_sitef_retaguarda.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_sitef_retaguarda.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;

ds_Servico    = Create dc_uo_ds_base

end event

event destructor;

Destroy(ds_servico)
end event

