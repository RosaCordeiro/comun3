HA$PBExportHeader$uo_ge493_wsunimed.sru
forward
global type uo_ge493_wsunimed from nonvisualobject
end type
end forward

global type uo_ge493_wsunimed from nonvisualobject
end type
global uo_ge493_wsunimed uo_ge493_wsunimed

type variables
String ivs_Tab = ""
String ivs_Enter = ''
String ivs_Erro_Log
String ivs_login	= 'clamed976'
String ivs_senha = 'clamed976'
Long ivs_cod_prestador = 1003577
end variables

forward prototypes
public function string of_abre_tag (string ps_tag, long pl_identacao)
public function string of_identa (string ps_registro, long pl_tabulacao)
public function string of_elemento (string ps_tag, string ps_string, long pl_identacao)
public function string of_elemento_vazio (string ps_tag, string ps_string, long pl_identacao)
public function string of_fecha_tag (string ps_tag, long pl_identacao)
public function boolean of_monta_xml (string ps_cartao, string ps_nome, ref string ps_xml)
public function boolean of_valor_retornado (string ps_xml, string ps_procura, ref string ps_retorno, integer pi_inicio)
public function boolean of_valor_retornado (string ps_xml, string ps_procura, ref string ps_retorno)
public function boolean of_envia_ws (string ps_cartao, string ps_nome, ref string ps_retorno, ref string ps_erro, ref long pl_erro)
end prototypes

public function string of_abre_tag (string ps_tag, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + ">", pl_identacao) + ivs_Enter

Return lvs_Retorno
end function

public function string of_identa (string ps_registro, long pl_tabulacao);Long lvl_Linha

For lvl_Linha = 1 To pl_Tabulacao
	ps_Registro = ivs_Tab + ps_Registro
Next

Return ps_Registro
end function

public function string of_elemento (string ps_tag, string ps_string, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + ">" + ps_String + "</" + ps_Tag + ">", pl_identacao) + ivs_Enter

Return lvs_Retorno
end function

public function string of_elemento_vazio (string ps_tag, string ps_string, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + "/>", pl_identacao) + ivs_Enter

Return lvs_Retorno
end function

public function string of_fecha_tag (string ps_tag, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("</" + ps_Tag + ">", pl_identacao) + ivs_Enter

Return lvs_Retorno
end function

public function boolean of_monta_xml (string ps_cartao, string ps_nome, ref string ps_xml);String ls_registro, &
		ls_transacao, &
		ls_senha
Integer li_Arquivo
DateTime ldh_data

ldh_data = gf_getserverdate()

If LeftA( gvo_Aplicacao.is_ComputerName, 4 ) <> String( gvo_Parametro.Cd_Filial, "0000" ) Then
	//Matriz
	ls_transacao = String(ldh_data,'yymmdd') + String(ldh_data,'hhmmss')
Else
	ls_transacao = String( gvo_parametro.cd_filial ) + RightA( gvo_aplicacao.is_ComputerName , 2 )	 + String(ldh_data,'hhmmss')
End If

ls_senha = gf_captura_hash(ivs_senha)
If IsNull(ps_nome) or Trim(ps_nome) = '' Then //Para testes com cartao digitado.
	ps_nome = ' '
End If

ls_Registro = '<?xml version="1.0"?>' + ivs_Enter 													+ &
				This.of_abre_tag('S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"', 1)	+ &
				This.of_abre_tag('S:Body', 2) 																+ &
				This.of_abre_tag('pedidoElegibilidadeWS xmlns:ns2="http://www.w3.org/2000/09/xmldsig#" xmlns="http://www.ans.gov.br/padroes/tiss/schemas"', 3) + &
				This.of_abre_tag('cabecalho', 4) 															+ &
				This.of_abre_tag('identificacaoTransacao', 5) 											+ &
				This.of_Elemento('tipoTransacao', 'VERIFICA_ELEGIBILIDADE', 6)					+ &
				This.of_Elemento('sequencialTransacao', ls_transacao, 6)							+ &
				This.of_Elemento('dataRegistroTransacao', String(ldh_data,'yyyy-mm-dd') , 6)	+ &				
				This.of_Elemento('horaRegistroTransacao', String(ldh_data,'hh:mm:ss'), 6)	+ &
				This.of_fecha_tag('identificacaoTransacao', 5) 											+ &
				This.of_abre_tag('origem', 5) 																+ &
				This.of_abre_tag('identificacaoPrestador', 6) 											+ &
				This.of_Elemento('codigoPrestadorNaOperadora', String(ivs_cod_prestador), 7)+ &
				This.of_fecha_tag('identificacaoPrestador', 6) 											+ &
				This.of_fecha_tag('origem', 5) 																+ &
				This.of_abre_tag('destino', 5) 																+ &
				This.of_Elemento('registroANS', '355691', 6) 											+ &
				This.of_fecha_tag('destino', 5) 																+ &
				This.of_Elemento('Padrao', '3.03.03', 6)													+ &
				This.of_abre_tag('loginSenhaPrestador', 5) 												+ &
				This.of_Elemento('loginPrestador', ivs_login, 6)											+ &
				This.of_Elemento('senhaPrestador', ls_senha, 6)										+ &
				This.of_fecha_tag('loginSenhaPrestador', 5) 											+ &
				This.of_fecha_tag('cabecalho', 4) 															+ &
				This.of_abre_tag('pedidoElegibilidade', 4) 												+ &
				This.of_abre_tag('dadosPrestador', 5) 													+ &
				This.of_Elemento('codigoPrestadorNaOperadora', String(ivs_cod_prestador) , 6)+ &
				This.of_Elemento('nomeContratado', 'CIA LATINO AMERICANA DE MEDICAMENTOS', 6)+ &				
				This.of_fecha_tag('dadosPrestador', 5) 													+ &
				This.of_Elemento('numeroCarteira', ps_cartao, 5)										+ &
				This.of_Elemento('nomeBeneficiario', ps_nome, 5)									+ &
				This.of_fecha_tag('pedidoElegibilidade', 4) 												+ &
				This.of_Elemento_Vazio('hash', '', 5)														+ &
				This.of_fecha_tag('pedidoElegibilidadeWS', 3) 											+ &
				This.of_fecha_tag('S:Body', 2) 																+ &
				This.of_fecha_tag('S:Envelope', 1);

ps_xml = ls_registro

//TESTE
If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF", "CPD","") = 'SIM' Then
	FileDelete('c:/sistemas/cl/arquivos/testeunimed.xml')
	li_Arquivo  = FileOpen('c:/sistemas/cl/arquivos/testeunimed.xml' , TextMode!, Write!, LockReadWrite!, Replace! )
	
	Long ll_Write
	
	ll_Write = FileWriteEx( li_Arquivo, ls_Registro )
	
	FileClose(li_arquivo)
End if

Return True
end function

public function boolean of_valor_retornado (string ps_xml, string ps_procura, ref string ps_retorno, integer pi_inicio);Long ll_Pos
Long ll_Pos_De
Long ll_Pos_Ate

ll_Pos = PosA( Upper(ps_Xml), Upper(ps_Procura), pi_Inicio )

If ll_Pos = 0 Then
	ps_Retorno = ""
Else
	ll_Pos_De	= ll_Pos + LenA( ps_Procura ) +1
	ll_Pos_Ate	= PosA( ps_Xml, '<', ll_Pos_De ) - ll_Pos_De
	
	ps_Retorno = MidA( ps_Xml, ll_Pos_De, ll_Pos_Ate )
End If

ps_Retorno = Trim( ps_Retorno )

Return True
end function

public function boolean of_valor_retornado (string ps_xml, string ps_procura, ref string ps_retorno);Return This.of_Valor_Retornado( ps_XML, ps_Procura, ref ps_Retorno, 1 )
end function

public function boolean of_envia_ws (string ps_cartao, string ps_nome, ref string ps_retorno, ref string ps_erro, ref long pl_erro);String ls_status_text, ls_XML, ls_Xml_Retorno, ls_resposta, ls_cod_erro, ls_erro

long   ll_status_code
integer li_arquivo

OleObject lo_xmlhttp

Try

	Try		
		This.of_monta_xml( ps_cartao, ps_nome, ref ls_XML )
		
		lo_xmlhttp = CREATE oleobject
		lo_xmlhttp.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
		
		lo_xmlhttp.open ("POST", "https://wstiss.unimedsc.com.br/WSTiss3/http/v3_03_03/tissVerificaElegibilidade", False)
		
		lo_xmlhttp.SetTimeOuts(5000,5000,30000,120000)
		lo_xmlhttp.SetAutomationTimeout(120000)
		
		lo_xmlhttp.setRequestHeader("Content-Type", "text/xml")		
		lo_xmlhttp.send(ls_XML)		
		
		//Pega a resposta do web service
		ls_status_text = lo_xmlhttp.StatusText
		ll_status_code = lo_xmlhttp.Status		
		
		if ll_status_code >= 300 then 
			ivs_Erro_Log = "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro:" +String(ll_status_code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro:" + ls_status_text			
			pl_erro = ll_status_code
		else
			//Pega o retorno do web service
			ls_Xml_Retorno = lo_xmlhttp.ResponseText
			
			//TESTE
			If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF", "CPD","") = 'SIM' Then
				FileDelete('c:/sistemas/cl/arquivos/testeunimed_retorno.xml')
				li_Arquivo  = FileOpen('c:/sistemas/cl/arquivos/testeunimed_retorno.xml' , TextMode!, Write!, LockReadWrite!, Replace! )
				
				Long ll_Write
				
				ll_Write = FileWriteEx( li_Arquivo, ls_Xml_Retorno )
				
				FileClose(li_arquivo)
			End if			
		end if
		
		//Disconecta
		lo_xmlhttp.DisconnectObject()
		
		If Not IsNull(ls_Xml_Retorno) And Trim(ls_Xml_Retorno) > '' Then
			This.of_Valor_Retornado( Lower( ls_Xml_Retorno ), 'respostaSolicitacao'		, ref ls_resposta )  //Resposta OK
			If Trim(Upper(ls_resposta)) = 'S' Or Trim(Upper(ls_resposta)) = 'N' Then
				ps_retorno = Upper(ls_resposta)
				Return True
			End If
			This.of_Valor_Retornado( Lower( ls_Xml_Retorno ), 'codigoGlosa'		, ref ls_cod_erro ) //Erro
			If Not IsNull(ls_cod_erro) And Trim(ls_cod_erro) > '' Then
				This.of_Valor_Retornado( Lower( ls_Xml_Retorno ), 'descricaoGlosa', ref ls_erro ) //Erro
				ps_retorno = ls_cod_erro
				ps_erro = ls_erro
				Return False
			End If
			This.of_Valor_Retornado( Lower( ls_Xml_Retorno ), 'faultcode', ref ls_cod_erro ) //Erro
			If Not IsNull(ls_cod_erro) And Trim(ls_cod_erro) > '' Then
				This.of_Valor_Retornado( Lower( ls_Xml_Retorno ), 'faultstring', ref ls_erro ) //Erro
				ps_retorno = ls_cod_erro
				ps_erro = ls_erro				
				Return False
			End If
			//ps_retorno = ls_resposta
			ps_erro = 'Retorno WebService n$$HEX1$$e300$$ENDHEX$$o esperado.'
			Return False			
		Else
			ps_retorno = ls_resposta
			ps_erro = ivs_Erro_Log
			Return False	
		End If
		
	Catch (RuntimeError rte2)
		ps_retorno = ls_resposta
		pl_erro = 404
		ps_erro = "Ocorreu erro na conex$$HEX1$$e300$$ENDHEX$$o Web Service. Erro: " + rte2.getMessage()
		Return False	
	Finally
		Destroy(lo_xmlhttp)
	End Try

Catch (RuntimeError rte)
	ivs_Erro_Log = "Ocorreu erro ao enviar o arquivo para o Web Service. Erro: " + rte.getMessage()
	Return False
End Try

Return True
end function

on uo_ge493_wsunimed.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge493_wsunimed.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

