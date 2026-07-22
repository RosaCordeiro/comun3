HA$PBExportHeader$uo_ge536_dermaclub_loja.sru
forward
global type uo_ge536_dermaclub_loja from nonvisualobject
end type
end forward

global type uo_ge536_dermaclub_loja from nonvisualobject
end type
global uo_ge536_dermaclub_loja uo_ge536_dermaclub_loja

type prototypes
FUNCTION long GetCurrentProcessId()  LIBRARY "kernel32.dll" 
end prototypes

type variables
uo_ge040_json io_Json

str_ge536_projeto st_projeto
str_ge536_campanha st_campanha
str_ge536_produto st_produto
str_ge536_uf st_uf
str_ge536_quantidades st_qtd
str_ge536_kit st_kit
str_ge536_limites st_limites

Boolean ib_possui_cadastro

Long il_cd_produto
Long il_Status_Code
Long il_Seq_Consulta
Long il_NSU_transacao

//usada somente para facilitar no entendimento no envio do email
String is_Json_Com_Erro

String is_usuario
String is_senha
String is_url
String is_chave
String is_token
String is_id_interface
String is_url_master_data
String is_id_metodo_api
String is_json
String is_cd_ean
String is_projeto
String is_sessao_consulta
String is_msg_cupom
String is_cnpj_ecommerce
String is_api_key

String is_Url_Status_Servico
String is_Url_Envio
String is_Url_Retorno

String is_CNPJ_Login
String is_arquivo_log
String is_diretorio_log

Any ia_Null

OleObject iole_SrvHTTP, iole_Send
end variables

forward prototypes
public function boolean of_post (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
private function boolean of_comunicacao_api (string ps_metodo, string ps_json, ref string ps_retorno, ref string ps_log)
public function boolean of_put (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
public subroutine of_limpa_variaveis ()
public function string of_tratar_erro (string ps_mensagem)
public function boolean of_delete (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function boolean of_get (string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function decimal of_decimal (long pl_valor)
public function boolean of_del (string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function boolean of_patch (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function boolean of_gera_token (ref string ps_log)
public function boolean of_tratar_retorno (string ps_json, boolean pb_erro, ref string ps_retorno, ref string ps_log)
public function boolean of_envia_email (string as_mensagem)
public function boolean of_envia_servidor (string as_metodo, string as_url, string as_json_envio, string as_autenticacao_key, boolean ab_utiliza_api_key, boolean ab_utiliza_origem, ref string as_json_retorno, ref string as_erro)
public function boolean of_consulta_parametro_geral (string as_cd_parametro, ref string as_vl_parametro, ref string as_erro)
public function boolean of_carrega_url (ref string as_erro)
public function boolean of_carrega_dados_json (string as_json_retorno, ref string as_erro)
public function boolean of_valida_resposta (string ps_resposta)
public function boolean of_carrega_cliente (any aa_cliente[], ref string as_erro)
public function boolean of_carrega_campanha (any aa_campanha[], string as_caminho, ref string as_erro)
public function boolean of_carrega_limites (any aa_limites[], string as_caminho, ref string as_erro)
public subroutine of_limpa_estrutura ()
public function boolean of_grava_log (string ps_mensagem)
public function boolean of_carrega_produto (any aa_produto[], string as_caminho, long al_campanha, ref string as_erro)
public function boolean of_carrega_quantidades (any aa_quantidade[], string as_caminho, string as_codigo_produto, long al_campanha, ref string as_erro)
public function boolean of_consulta_cliente (string ps_cliente, string ps_sessao, string ps_cnpj, string ps_canal_venda, ref string ps_erro)
public function boolean of_consulta_identificacao (string ps_documento, string ps_sessao, string ps_canal_venda, string ps_cnpj, ref string ps_json_retorno, ref string ps_erro)
public function boolean of_envia_venda (string ps_sessao, long pl_filial, long pl_nota, string ps_especie, string ps_serie, string ps_pagamento, string ps_cnpj, ref string ps_json_retorno, ref string ps_erro)
public function boolean of_envia_email_estabelecimento (string as_mensagem)
public function boolean of_verifica_campanha_ativa (long al_filial, ref long al_campanha, ref string as_erro)
public function boolean of_verifica_produto_repetido (long pl_filial, long pl_nota, string ps_especie, string ps_serie, ref boolean pb_produto_repetido)
public function boolean of_registra_desconto (string ps_sessao, long pl_filial, long pl_nota, string ps_especie, string ps_serie, string ps_pagamento, string ps_cnpj, ref string ps_json_retorno, ref string ps_erro, boolean pb_produto_repetido)
end prototypes

public function boolean of_post (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'POST'

return of_comunicacao_api('POST', ps_json, ref ps_retorno, ref ps_log)
end function

private function boolean of_comunicacao_api (string ps_metodo, string ps_json, ref string ps_retorno, ref string ps_log);Long ll_status_code
String ls_url_local
String ls_status_text
String ls_Retorno_Api
any la_result

//Adiciona $$HEX1$$e000$$ENDHEX$$ url qual interface est$$HEX1$$e100$$ENDHEX$$ sendo utilizada
ls_url_local = is_url + is_id_interface
	
SetNull(is_Json_Com_Erro)

Try	
	
	IF Not IsValid(iole_SrvHTTP) THEN
		
		iole_SrvHTTP = CREATE oleobject
		//iole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		//alguns win7 n$$HEX1$$e300$$ENDHEX$$o funcionava com serverxmlhttp, por isso foi trocado
		iole_SrvHTTP.ConnectToNewObject("MSXML2.XMLHTTP.6.0")
		//iole_SrvHTTP.ConnectToNewObject("WinHTTP.WinHTTPRequest.5.1")
		iole_Send = CREATE oleobject
		iole_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")
		
	End If
	
	iole_SrvHTTP.open (ps_metodo, ls_url_local, false) 
	
	iole_SrvHTTP.SetRequestHeader("content-type", "application/json")
	
	if is_token <> '' and not isnull(is_token) Then		
		iole_SrvHTTP.SetRequestHeader("token", is_token)
	end if	
	if is_api_key <> '' and not isnull(is_api_key) Then		
		iole_SrvHTTP.SetRequestHeader("x-api-key", is_api_key)
	end if	
	
	// Trust the SSL Certificate - IGNORA OS ERROS DE CERTIFICADO
	//iole_SrvHTTP.setOption(2,'13056') 
	
	// MOSTRAR O VALOR SETADO NA OPCAO 2
	//la_result = iole_SrvHTTP.getOption(2)
		
	IF IsValid(iole_SrvHTTP) THEN
		
		TRY
			If IsNull( ps_Json ) Then ps_Json = ''
			
			If(ps_metodo = 'GET') Then
				iole_SrvHTTP.Send(iole_Send)
			Else
				iole_SrvHTTP.send(ps_json) 
			End If
			
		CATCH (RuntimeError e) 
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel se conectar com o webservice. ~nErro: ' + e.getMessage()
			Return false
		END TRY 
		
		ll_status_code = iole_SrvHTTP.readyState 
		IF ll_status_code <> 4 THEN
			iole_SrvHTTP.DisconnectObject() 
			Destroy iole_SrvHTTP 
			
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: readyState = ' + String(ll_status_code)
			Return false
			
		End If
		
		//Get response 
		ls_status_text = iole_SrvHTTP.StatusText 
		ll_status_code = iole_SrvHTTP.Status 
		
		ls_Retorno_Api = String( iole_SrvHTTP.ResponseText )
		
		if ll_status_code = 200 Then
	
			If(ps_metodo = 'GET') Then
			
				ps_retorno = ls_retorno_api
			else
				//ps_retorno = ls_retorno_api
				if Not this.of_tratar_retorno( ls_retorno_api, false, ref ps_retorno, ref ps_log) Then Return false
				
				if upper(ps_retorno) = 'FALSE' Then
//					if Not this.of_tratar_retorno( ls_retorno_api, True, ref ps_retorno, ref ps_log) Then Return false
//					ps_log = ps_retorno
					ps_log = ls_retorno_api
					ps_retorno = ''
				end if
				
			end if
		
		elseif ll_status_code = 401 Then
			is_Json_Com_Erro = ps_json
			ps_retorno = ''
			ps_log = ls_status_text
			
			return false
		
		else
			is_Json_Com_Erro = ps_json
			ps_retorno = ''
			if Not this.of_tratar_retorno( ls_retorno_api, True, ref ps_retorno, ref ps_log) Then Return false
			ps_log = ps_retorno
			Return false
			
		end if
		
	End If
	
Finally	
	
	IF IsValid(iole_SrvHTTP) THEN 
		iole_SrvHTTP.DisconnectObject()
		Destroy iole_SrvHTTP 
	end if
	
	IF IsValid(iole_Send) THEN 
		iole_Send.DisconnectObject()
		Destroy iole_Send 
	end if

End Try

Return true



end function

public function boolean of_put (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'PUT'

return of_comunicacao_api('PUT', ps_json, ref ps_retorno, ref ps_log)
end function

public subroutine of_limpa_variaveis ();setnull( il_cd_produto)
setnull( is_id_metodo_api)
setnull( is_json)
setnull( is_cd_ean)
setnull( is_sessao_consulta)
setnull( il_NSU_transacao)
setnull( is_msg_cupom)
end subroutine

public function string of_tratar_erro (string ps_mensagem);string ls_retorno

if match(upper(ps_mensagem),'BRAND NOT FOUND') Then
	ls_retorno = 'Marca n$$HEX1$$e300$$ENDHEX$$o cadastrada no site'
elseIf ps_mensagem = 'Brand already created with this Id' Then
	ls_retorno = 'Marca j$$HEX1$$e100$$ENDHEX$$ criada com este ID'
ElseIf Pos(ps_mensagem, 'There is already a product created with the same RefId for the Product') > 0 Then
	ls_retorno = 'Produto j$$HEX1$$e100$$ENDHEX$$ foi criado no site'	
else
	ls_retorno = ps_mensagem
end if


return ls_retorno
end function

public function boolean of_delete (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'DELETE'

return of_comunicacao_api('DELETE', ps_json, ref ps_retorno, ref ps_log)
end function

public function boolean of_get (string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'GET'

return of_comunicacao_api('GET', '', ref ps_retorno, ref ps_log)
end function

public function decimal of_decimal (long pl_valor);long ll_len
string ls_ret, ls_numero

ls_numero = string(pl_valor)
ll_len = len(ls_numero)

ls_ret = mid( ls_numero, 1, ll_len - 2) + ',' + right( ls_numero, 2 )

return dec(ls_ret)
end function

public function boolean of_del (string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'DEL'

return of_comunicacao_api('DEL', '', ref ps_retorno, ref ps_log)
end function

public function boolean of_patch (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'PATCH'

return of_comunicacao_api('PATCH', ps_json, ref ps_retorno, ref ps_log)
end function

public function boolean of_gera_token (ref string ps_log);string ls_json
string ls_id_interface
string ls_retorno
uo_ge073_json luo_json

luo_json = create uo_ge073_json

ls_id_interface = 'entrar'

ls_json = "{" + &
			 '"Login": "' + is_usuario + '", ' + &
			 '"Senha": "' + is_senha + '"' + &
			 "}"
			 
Try			 

	If Not this.of_post( ls_json, ls_id_interface, ref ls_retorno, ref ps_log ) Then return false

	//access_token
	is_token = luo_json.of_busca_conteudo_campo( ls_retorno, 'access_token')

Finally

	destroy(luo_json)

End Try

return true
end function

public function boolean of_tratar_retorno (string ps_json, boolean pb_erro, ref string ps_retorno, ref string ps_log);string ls_erro, ls_json_restante
long ll_pos, ll_pos_fim
uo_ge073_json luo_json


luo_json = create uo_ge073_json

if pb_erro = True Then
	
	luo_json.of_divide_grupo_json_tag_vtex(ref ps_json, 'error', ref ls_erro , '}')
	
	ps_retorno = luo_json.of_busca_conteudo_campo( ls_erro, 'error_description')
	
	if ps_retorno = '' or isnull(ps_retorno) Then
		
		ll_pos = pos(ps_json, "<div id='message'>",1)
		
		if ll_pos > 0 Then
			ll_pos_fim = pos(ps_json, "</div>", ll_pos) 
			
			ps_retorno = Mid(ps_json, ll_pos, ll_pos_fim - ll_pos)
		end if
		
		if ps_retorno = '' or isnull(ps_retorno) Then
			ps_retorno = ps_json
		end if
		
	end if
	
else

	if match( ps_json, 'success') = True Then
		ps_retorno = luo_json.of_busca_conteudo_campo( ps_json, 'success')
	else
		
		ps_retorno =ps_json
		
	end if
	
end if

destroy(luo_json)

return true
end function

public function boolean of_envia_email (string as_mensagem);String	ls_Msg
s_email lst_Email					

ls_Msg =	"Aten$$HEX2$$e700e300$$ENDHEX$$o,<br><br>" +&
			"Descri$$HEX2$$e700e300$$ENDHEX$$o: "+as_mensagem+"<br>"	

lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

If Not gf_ge202_envia_email_padrao(255, lst_Email)	Then
	Return False
End If
			
Return True
end function

public function boolean of_envia_servidor (string as_metodo, string as_url, string as_json_envio, string as_autenticacao_key, boolean ab_utiliza_api_key, boolean ab_utiliza_origem, ref string as_json_retorno, ref string as_erro);String ls_Status_Text

OleObject	lo_Http,&
				lo_Send
				
Long		li_rc1,&
			li_rc2, &
			ll_Status_Code			

Try
	Try
		lo_Send	= CREATE oleobject
		lo_Http	= CREATE oleobject
		lo_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")		
		lo_Http.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		lo_Http.open (as_Metodo, as_Url, False)  
		lo_Http.SetRequestHeader( "Content-Type", "application/json")
		
		//If ab_Utiliza_Api_Key Then
		//	lo_Http.setRequestHeader("api_key", as_Autenticacao_Key)
		///End If
		
		// Trust the SSL Certificate 
		//lo_Http.setOption(2,'13056') 
		
		If as_Metodo = "POST" Then
			lo_Http.send(as_Json_Envio)
		Else
			lo_Http.send(lo_Send)
		End If
		
		//Pega a resposta do web service
		ls_Status_Text 	= lo_Http.StatusText
		ll_Status_Code 	= lo_Http.Status
		as_json_retorno = lo_Http.ResponseText
		
		If ll_Status_Code > 201 Then
			as_Erro = "SmartPicking: Erro no retorno Servi$$HEX1$$e700$$ENDHEX$$o-Descri$$HEX2$$e700e300$$ENDHEX$$o : " + String(as_json_retorno)
			Return False
		Else					
			Return True 
		End If
		
	Finally
		//Disconecta
		lo_Http.DisconnectObject()		
		Destroy(lo_Http)
		Destroy(lo_Send)
	End Try

Catch (RuntimeError rte)
	as_Json_Retorno = lo_Http.ResponseText
	as_Erro = "SmartPicking: Erro retorno do Servi$$HEX1$$e700$$ENDHEX$$o-Codigo do Erro: " +String(ll_Status_Code)+ "~r~nDescri$$HEX2$$e700e300$$ENDHEX$$o Erro: " + String(ls_Status_Text)
	Return False	
End Try
end function

public function boolean of_consulta_parametro_geral (string as_cd_parametro, ref string as_vl_parametro, ref string as_erro);Try

	uo_parametro_geral lo_Parametro_Geral	
	lo_Parametro_Geral = Create uo_parametro_geral
	
	lo_Parametro_Geral.ib_mostra_mensagem = False
	
	as_Vl_Parametro = ""
	
	If Not lo_Parametro_Geral.of_Localiza_Parametro(as_Cd_Parametro, Ref as_Vl_Parametro) Then
		as_Erro = lo_Parametro_Geral.is_mensagem_log
		Return False
	End If
	
	If IsNull(as_Vl_Parametro) Or as_Vl_Parametro = "" Then
		as_Erro = "Parametro_geral '" + as_Cd_Parametro + "' nulo ou branco"
		Return False
	End If
	
	Return True
	
Catch (RunTimeError lo_error)
	as_Erro = lo_error.GetMessage()
	Return False
	
Finally
	If IsValid(lo_Parametro_Geral) Then Destroy(lo_Parametro_Geral)
End Try
end function

public function boolean of_carrega_url (ref string as_erro);String ls_producao
String ls_login
String ls_pwd
String ls_projeto
String ls_cnpj
String ls_apiKey

Try
	
	io_Json = Create uo_ge040_json	
	
	uo_Parametro_Filial lo_Parametro
	lo_Parametro = Create uo_Parametro_Filial
	
	as_erro = ""	
	
	lo_Parametro.of_Localiza_Parametro("ID_BASE_PRODUCAO", ref ls_producao, False)
	If ls_producao = 'N' Then //usa link homologacao
		is_url = 'http://api-autorizadorzeushml-v3.trackingsales.com.br/api/autorizador-v3/'
	Else
		is_url = 'https://gateway.zicardapi.com.br/trackingsales/v03/autorizador/'
	End If
	
	//Se estiver sendo executado pelo sistema Exporta$$HEX2$$e700e300$$ENDHEX$$o, as vari$$HEX1$$e100$$ENDHEX$$veis is_usuario, is_senha e is_projeto ser$$HEX1$$e300$$ENDHEX$$o atribu$$HEX1$$ed00$$ENDHEX$$das na fun$$HEX2$$e700e300$$ENDHEX$$o uo_ge536_dermaclub_envio_info.of_envia_venda
	If IsNull(is_usuario) Or is_usuario = "" Then
		lo_Parametro.of_Localiza_Parametro("ID_LOGIN_DERMACLUB", ref ls_login, False)
		If Not IsNull(ls_login) And Trim(ls_login) <> '' Then
			is_usuario = ls_login
		Else
			as_Erro = 'Par$$HEX1$$e200$$ENDHEX$$metro de login n$$HEX1$$e300$$ENDHEX$$o definido.'
			Return False		
		End If
	End If

	If IsNull(is_senha) Or is_senha = "" Then
		lo_Parametro.of_Localiza_Parametro("ID_PWD_DERMACLUB", ref ls_pwd, False)
		If Not IsNull(ls_pwd) And Trim(ls_pwd) <> '' Then
			is_senha = ls_pwd
		Else
			as_Erro = 'Par$$HEX1$$e200$$ENDHEX$$metro de senha n$$HEX1$$e300$$ENDHEX$$o definido.'
			Return False		
		End If
	End If
	
	If IsNull(is_projeto) Or is_projeto = "" Then
		lo_Parametro.of_Localiza_Parametro("CD_PROJETO_DERMACLUB", ref ls_projeto, False)
		If Not IsNull(ls_projeto) And Trim(ls_projeto) <> '' Then
			is_projeto = ls_projeto
		Else
			as_Erro = 'Par$$HEX1$$e200$$ENDHEX$$metro id_projeto n$$HEX1$$e300$$ENDHEX$$o definido.'
			Return False		
		End If		
	End If
	
	If IsNull(is_cnpj_ecommerce) Or is_cnpj_ecommerce = "" Then
		lo_Parametro.of_Localiza_Parametro("NR_CNPJ_ECOMMERCE_DERMACLUB", ref ls_cnpj, False)
		If Not IsNull(ls_cnpj) And Trim(ls_cnpj) <> '' Then
			is_cnpj_ecommerce = ls_cnpj
		Else
			as_Erro = 'Par$$HEX1$$e200$$ENDHEX$$metro Cnpj ecommerce n$$HEX1$$e300$$ENDHEX$$o definido.'
			Return False		
		End If		
	End If	

	If IsNull(is_api_key) Or is_api_key = "" Then
		lo_Parametro.of_Localiza_Parametro("ID_API_KEY_DERMACLUB", ref ls_apikey, False)
		If Not IsNull(ls_apikey) And Trim(ls_apikey) <> '' Then
			is_api_key = ls_apikey
		Else
			as_Erro = 'Par$$HEX1$$e200$$ENDHEX$$metro api_key n$$HEX1$$e300$$ENDHEX$$o definido.'
			Return False		
		End If		
	End If	
	
	Return True
	
Catch (RunTimeError lo_error)
	as_Erro = lo_error.GetMessage()
	Return False
	
Finally
	If IsValid(lo_Parametro) Then Destroy(lo_Parametro)
End Try
end function

public function boolean of_carrega_dados_json (string as_json_retorno, ref string as_erro);Any la_Data

String ls_Error

Try
	
	SetNull(ia_Null)

	ls_Error = io_json.parse(as_Json_Retorno)
	
	//check for parse error
	If ls_error <> "" then
		as_Erro = "Parse error: " + ls_Error
		Return False
	End if
	
	//In$$HEX1$$ed00$$ENDHEX$$cio
	If Not io_json.retrieve("nsuHost", Ref la_Data) Then
		as_Erro = "Retrieve grupo 'nsuHost' (null)"
		Return False
	End If
	This.il_nsu_transacao = la_Data
	
	la_Data = ia_Null
	
	If Not io_json.retrieve("codigoResposta", Ref la_Data) Then
		as_Erro = "Retrieve grupo 'codigoResposta' (null)"
		Return False
	End If
	
	If Not This.of_valida_resposta( String(la_Data) ) Then
		as_Erro = "Cod. da Resposta com erro"
		Return False
	End If
			
	la_Data = ia_Null

	If is_id_interface = 'identificacao/consultar' Then	
		If Not io_json.retrieve("credenciaisStatus", Ref la_Data) Then
			as_Erro = "Retrieve grupo 'projetos' (null)"
			Return False
		End If
		
		If Not This.of_Carrega_Cliente(la_Data, Ref as_Erro) Then Return False
	End If
	If is_id_interface = 'descontos/registrar' Then
		//Carregar mensagem cupom
		If Not io_json.retrieve("msgPromocional", Ref la_Data) Then
			as_Erro = "Retrieve grupo 'projetos' (null)"
			Return False
		End If
		
		This.is_msg_cupom = la_Data
	End If
	
	Return True
	
Catch (RunTimeError lo_error)
	as_Erro = lo_error.GetMessage()
	Return False
	
Finally
	
End Try
end function

public function boolean of_valida_resposta (string ps_resposta);String ls_Msg

Choose Case ps_resposta
	Case '00'
		Return True	
	Case 'C0'
		ls_Msg = "Canal de venda inv$$HEX1$$e100$$ENDHEX$$lido."
	Case 'E0'
		ls_Msg = "Par$$HEX1$$e200$$ENDHEX$$metros mandat$$HEX1$$f300$$ENDHEX$$rios ausentes ou inv$$HEX1$$e100$$ENDHEX$$lidos."
	Case 'P0'
		ls_Msg = "Meio de pagamento inv$$HEX1$$e100$$ENDHEX$$lido."
	Case 'S0'
		ls_Msg = "Identifica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o encontrada na base(Dermaclub)."
	Case 'S1'
		ls_Msg = "S$$HEX1$$f300$$ENDHEX$$cio inativo."
	Case 'S2'
		ls_Msg = "Transa$$HEX2$$e700e300$$ENDHEX$$o indefinida."
	Case 'S3'
		ls_Msg = "Documento inexistente."
	Case 'S4'
		ls_Msg = "Transa$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ efetuada anteriormente."
	Case 'S5'
		ls_Msg = "CPF inv$$HEX1$$e100$$ENDHEX$$lido."
	Case 'S6'
		ls_Msg = "Transa$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ cancelada."
	Case 'S7'
		ls_Msg = "Transa$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ aprovada."
	Case 'V2'
		ls_Msg = "C$$HEX1$$f300$$ENDHEX$$digo de estabelecimento indefinido."
		this.of_envia_email_estabelecimento(ls_Msg)
	Case 'V3'
		ls_Msg = "CGC / CNPJ inv$$HEX1$$e100$$ENDHEX$$lido."
	Case 'T0'
		ls_Msg = "Vers$$HEX1$$e300$$ENDHEX$$o da tabela desatualizada."		
	Case Else
		ls_Msg = "C$$HEX1$$f300$$ENDHEX$$digo de Resposta Desconhecido."
End Choose

If Trim(ls_Msg)<>'' Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg,StopSign!)
	//gvo_aplicacao.of_grava_log(ls_Msg)
	Return False
End If
end function

public function boolean of_carrega_cliente (any aa_cliente[], ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas

ll_Linhas = UpperBound(aa_Cliente)

//Projeto
For ll_Linha = 1 To ll_Linhas

	If Not io_json.retrieve("credenciaisStatus/1/idStatus", Ref la_Data) Then
		as_Erro = "Retrieve tag idStatus (null)"
		Return False
	End If
	
	If Long(la_Data) <> 1 Then 
		//N$$HEX1$$e300$$ENDHEX$$o prossegue com os carregamos
		//Alimentar variavel que o cliente possui cadastro dermaclub
		This.ib_possui_cadastro = False
		Return True		
		//as_Erro = "idProjeto " + String(la_Data) + " inv$$HEX1$$e100$$ENDHEX$$lido. Ser$$HEX1$$e100$$ENDHEX$$ aceito somente o projeto 1033"
		//Return False
	End If	
	This.ib_possui_cadastro = True		
	
	la_Data = ia_Null
	
	If Not io_json.retrieve("credenciaisStatus/1/campanhas", Ref la_Data) Then
		as_Erro = "Retrieve tag campanha (null)"
		Return False
	End If
	
	If Not This.of_Carrega_campanha(la_Data, "credenciaisStatus/1/campanhas/", Ref as_Erro) Then Return False	

	la_Data = ia_Null
	
	If Not io_json.retrieve("credenciaisStatus/1/limites", Ref la_Data) Then
		as_Erro = "Retrieve tag limites (null)"
		Return False
	End If
	
	If Not This.of_Carrega_Limites(la_Data, "credenciaisStatus/1/limites/", Ref as_Erro) Then Return False
Next

Return True
end function

public function boolean of_carrega_campanha (any aa_campanha[], string as_caminho, ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas

ll_Linhas = UpperBound(aa_Campanha)

//Campanha
For ll_Linha = 1 To ll_Linhas

	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/idCampanha", Ref la_Data) Then
		as_Erro = "Retrieve tag idCampanha (null)"
		Return False
	End If
	
	st_Campanha.Idcampanha[ll_Linha] = Long(la_Data)
	
	la_Data = ia_Null
		
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/url", Ref la_Data) Then
		as_Erro = "Retrieve tag url (null)"
		Return False
	End If
	
	st_Campanha.Url[ll_Linha] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/telefone", Ref la_Data) Then
		as_Erro = "Retrieve tag telefone (null)"
		Return False
	End If
	
	st_Campanha.Telefone[ll_Linha] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/produtos", Ref la_Data) Then
		as_Erro = "Retrieve tag produtos (null)"
		Return False
	End If
	
	If Not This.of_Carrega_Produto(la_Data, as_Caminho + String(ll_Linha) + "/produtos/", st_Campanha.Idcampanha[ll_Linha], Ref as_Erro) Then Return False
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/kits", Ref la_Data) Then
		as_Erro = "Retrieve tag kits (null)"
		Return False
	End If
	
//	If Not This.of_Carrega_Kit(la_Data, as_Caminho + "1/kits/", Ref as_Erro) Then Return False	
Next

Return True
end function

public function boolean of_carrega_limites (any aa_limites[], string as_caminho, ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas

ll_Linhas = UpperBound(aa_Limites)

//Produto
For ll_Linha = 1 To ll_Linhas

	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/codigoProduto", Ref la_Data) Then
		as_Erro = "Retrieve tag codigoProduto (null)"
		Return False
	End If
	
	st_Limites.Codigoproduto[ll_Linha] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/produto", Ref la_Data) Then
		as_Erro = "Retrieve tag produto (null)"
		Return False
	End If
	
	st_Limites.Produto[ll_Linha] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/tipoProduto", Ref la_Data) Then
		as_Erro = "Retrieve tag tipoProduto (null)"
		Return False
	End If
	
	st_Limites.TipoProduto[ll_Linha] = Long(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/quantidade", Ref la_Data) Then
		as_Erro = "Retrieve tag quantidade (null)"
		Return False
	End If
	
	st_Limites.Quantidade[ll_Linha] = Dec(la_Data)	
Next

Return True
end function

public subroutine of_limpa_estrutura ();str_ge536_campanha st_campanha_nula
str_ge536_produto st_produto_nulo
str_ge536_uf st_uf_nula
str_ge536_quantidades st_qtd_nula
str_ge536_kit st_kit_nula
str_ge536_limites st_limites_nula

st_campanha = st_campanha_nula
st_produto = st_produto_nulo
st_uf = st_uf_nula
st_qtd = st_qtd_nula
st_kit = st_kit_nula
st_limites = st_limites_nula
end subroutine

public function boolean of_grava_log (string ps_mensagem);Integer li_Log
//Criar diret$$HEX1$$f300$$ENDHEX$$rio

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "CL" Then
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "RL" Then 
		Return True
	End If
End If

dc_uo_api lo_api
lo_api = Create dc_uo_api

lo_api.of_create_directory(This.is_diretorio_log)

Destroy(lo_api)	

If Not gf_abre_log(Ref li_Log, This.is_arquivo_log) Then
	Return False
End If

If Not gf_grava_log (li_Log, ps_mensagem) Then
	Return False
End If

If li_Log = 0 Then Return True

If FileClose(li_Log) = -1 Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no fechamento do arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o '" + This.ivs_Arquivo_LOG + "'.", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_carrega_produto (any aa_produto[], string as_caminho, long al_campanha, ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas

ll_Linhas = UpperBound(aa_Produto)

//Produto
For ll_Linha = 1 To ll_Linhas
	st_Produto.IdCampanha[ll_Linha] = al_campanha

	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/codigoProduto", Ref la_Data) Then
		as_Erro = "Retrieve tag codigoProduto (null)"
		Return False
	End If
	
	st_Produto.Codigoproduto[ll_Linha] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/produto", Ref la_Data) Then
		as_Erro = "Retrieve tag produto (null)"
		Return False
	End If
	
	st_Produto.Produto[ll_Linha] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/tipoProduto", Ref la_Data) Then
		as_Erro = "Retrieve tag tipoProduto (null)"
		Return False
	End If
	
	st_Produto.TipoProduto[ll_Linha] = Long(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/desconto", Ref la_Data) Then
		as_Erro = "Retrieve tag desconto (null)"
		Return False
	End If
	
	st_Produto.Desconto[ll_Linha] = Dec(la_Data)
	
	la_Data = ia_Null
	
	//NA CONSULTA DO CLIENTE N$$HEX1$$c300$$ENDHEX$$O RETORNA PONTO.
//	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/ponto", Ref la_Data) Then
//		as_Erro = "Retrieve tag ponto (null)"
//		Return False
//	End If
//	
//	st_Produto.Ponto[ll_Linha] = Dec(la_Data)
//	
//	la_Data = ia_Null
		
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/tipoDesconto", Ref la_Data) Then
		as_Erro = "Retrieve tag tipoDesconto (null)"
		Return False
	End If
	
	st_Produto.TipoDesconto[ll_Linha] = String(la_Data)
	
	la_Data = ia_Null
		
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/quantidades", Ref la_Data) Then
		as_Erro = "Retrieve tag quantidades (null)"
		Return False
	End If	
	
	If Not This.of_Carrega_Quantidades(la_Data, as_Caminho + String(ll_Linha) + "/quantidades/", st_Produto.Codigoproduto[ll_Linha], al_campanha, Ref as_Erro) Then Return False
	
Next

Return True
end function

public function boolean of_carrega_quantidades (any aa_quantidade[], string as_caminho, string as_codigo_produto, long al_campanha, ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas
Long ll_Linha_Qtd

ll_Linhas = UpperBound(aa_Quantidade)

//Produto
For ll_Linha = 1 To ll_Linhas
	
	ll_Linha_Qtd = UpperBound(st_Qtd.CodigoProduto) + 1
	
	st_Qtd.IdCampanha[ll_Linha_Qtd] = al_campanha
	
	st_Qtd.Codigoproduto[ll_Linha_Qtd] = as_Codigo_Produto

	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/quantidade", Ref la_Data) Then
		as_Erro = "Retrieve tag quantidade (null)"
		Return False
	End If
	
	st_Qtd.Quantidade[ll_Linha_Qtd] = Long(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/operador", Ref la_Data) Then
		as_Erro = "Retrieve tag operador (null)"
		Return False
	End If
	
	st_Qtd.Operador[ll_Linha_Qtd] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/desconto", Ref la_Data) Then
		as_Erro = "Retrieve tag desconto (null)"
		Return False
	End If
	
	st_Qtd.Desconto[ll_Linha_Qtd] = Double(la_Data)
	
	la_Data = ia_Null
Next

Return True
end function

public function boolean of_consulta_cliente (string ps_cliente, string ps_sessao, string ps_cnpj, string ps_canal_venda, ref string ps_erro);String ls_json_retorno
String ls_log_cadastro = 'N$$HEX1$$c300$$ENDHEX$$O'

This.ib_possui_cadastro = False
SetNull(This.is_sessao_consulta)
SetNull(This.il_NSU_transacao)
SetNull(This.is_msg_cupom)
This.of_limpa_estrutura( )

This.of_grava_log( 'Consulta Cliente - ' + ps_cliente )

// Carrega Informa$$HEX2$$e700e300$$ENDHEX$$o URL 
If Not This.of_carrega_url( Ref ps_Erro ) Then
	This.of_grava_log( 'Consulta Cliente - erro of_carrega_url(): ' + ps_erro )
	Return False
End If

If Not This.of_Gera_Token(Ref ps_Erro) Then
	This.of_grava_log( 'Consulta Cliente - erro of_gera_token(): ' + ps_erro )
	Return False
End If

If Not This.of_consulta_identificacao( ps_cliente, ps_sessao, ps_canal_venda, ps_cnpj, ref ls_json_retorno, ref ps_erro ) Then
	This.of_grava_log( 'Consulta Cliente - erro of_consulta_identificacao(): ' + ps_erro )
	Return False
End If		

//Carrega os valores do json e atribui para as estruturas
If Not This.of_Carrega_Dados_Json(ls_Json_Retorno, Ref ps_Erro) Then
	This.of_grava_log( 'Consulta Cliente - erro of_Carrega_Dados_Json(): ' + ps_erro )
	Return False
End If

If This.ib_possui_cadastro Then ls_log_cadastro = 'SIM'


This.of_grava_log( 'Consulta Cliente - ' + ps_cliente + ' Sucesso - Possui cadastro ' +  ls_log_cadastro + ' - Sess$$HEX1$$e300$$ENDHEX$$o: ' + This.is_sessao_consulta)

Return True
end function

public function boolean of_consulta_identificacao (string ps_documento, string ps_sessao, string ps_canal_venda, string ps_cnpj, ref string ps_json_retorno, ref string ps_erro);String ls_Json_Envio
String ls_Terminal
String ls_interface
String ls_digitos
String ls_Controle_Interno
String ls_sessao
Long ll_tamanho, ll_digito
Long ll_sequencial
DateTime ldh_data_seq

SetNull(ps_Json_Retorno)

ls_interface = 'identificacao/consultar'

ldh_data_seq = gf_getserverdate()  //Data hora abertura tela
ll_tamanho = LenA(Trim(gvo_aplicacao.of_ComputerName()))
ls_digitos    = Mid(Trim(gvo_aplicacao.of_ComputerName()), ll_tamanho - 1 )
If IsNumber (ls_digitos) Then
	ll_digito = Long(ls_digitos)
	ls_Controle_Interno	= String(ldh_data_seq, 'YYSSHHMMDD') + ls_digitos	
Else
	ls_Controle_Interno	= String(ldh_data_seq, 'YYSSHHMMDD')
End If
This.is_sessao_consulta = ps_sessao + String(ldh_data_seq, 'YYSSHHMM')
					 
ls_Json_Envio = "{" + &
					 '"cnpj": ' + ps_cnpj + ', ' + &
					 '"idTerminal": "' + gvo_aplicacao.of_ComputerName() + '", ' + &
					 '"nsuReq": ' + ls_Controle_Interno + ',' + &
					 '"numSessao": "' + This.is_sessao_consulta + '", ' + &
					 '"credenciais": [{' + &
										'"identificacao": "' + ps_documento + '",' + &
										'"idProjeto": ' + is_projeto + ',' + &
										'"tipoCaptura": 1 ' + &
										 "}]," + &
					 '"canalVenda": "' + ps_canal_venda + '",' + &
					 '"itensCupom": [],' + &
					 '"cargaTabela": 0' +&
					"}"
					 
	
If Not This.of_post( ls_json_Envio, ls_interface, ref ps_Json_Retorno, ref ps_Erro ) Then Return False

Return True
end function

public function boolean of_envia_venda (string ps_sessao, long pl_filial, long pl_nota, string ps_especie, string ps_serie, string ps_pagamento, string ps_cnpj, ref string ps_json_retorno, ref string ps_erro);Boolean lb_Produto_Repetido
String ls_json_retorno
SetNull(This.il_NSU_transacao)
SetNull(This.is_msg_cupom)
SetNull(ls_json_retorno)

This.of_grava_log( 'Inico Envia Venda NF: ' + String(pl_nota) )

//Verifica se existe produto repetido
If Not This.of_verifica_produto_repetido(pl_filial, pl_nota, ps_especie, ps_serie, Ref lb_Produto_Repetido) Then
	This.of_grava_log( 'Erro ao verificar produto repetido' )
	ps_erro = 'Erro ao verificar produto repetido | Filial:'+string(pl_filial)+' NF:'+ String(pl_nota)+' Serie:'+ps_serie+' Especie:'+ps_especie
	Return False
End If

If Not This.of_registra_desconto(ps_sessao, pl_filial, pl_nota, ps_especie, ps_serie, ps_pagamento, ps_cnpj, ref ls_json_retorno, ref ps_erro, lb_Produto_Repetido) Then
	This.of_grava_log( 'Envia Venda - erro of_registra_desconto(): ' + ps_erro )
	If IsNull(is_Json_Com_Erro) Then is_Json_Com_Erro = ''
	ps_erro = ps_erro + ' | Erro no objeto dermaclub_loja : of_registra_desconto | Filial:'+string(pl_filial)+' NF:'+ String(pl_nota)+' Serie:'+ps_serie+' Especie:'+ps_especie +  ' Json:'+is_Json_Com_Erro
	Return False
End If		

//Carrega os valores do json e atribui para as estruturas
If Not This.of_Carrega_Dados_Json(ls_Json_Retorno, Ref ps_Erro) Then
	This.of_grava_log( 'Envia Venda - erro of_Carrega_Dados_Json(): ' + ps_erro )
	ps_erro = ps_erro + ' | Erro no objeto dermaclub_loja : of_Carrega_Dados_Json | Filial:'+string(pl_filial)+' NF:'+ String(pl_nota)+' Serie:'+ps_serie+' Especie:'+ps_especie+ ' Json:'+is_Json_Com_Erro
	Return False
End If

This.of_grava_log( 'Fim Envia Venda NF: ' + String(pl_nota) + ' - Sucesso - NSU: ' + String(This.il_nsu_transacao) )

Return True
end function

public function boolean of_envia_email_estabelecimento (string as_mensagem);String	ls_Msg
s_email lst_Email					

ls_Msg =	"Aten$$HEX2$$e700e300$$ENDHEX$$o,<br><br>" +&
			"Descri$$HEX2$$e700e300$$ENDHEX$$o: "+as_mensagem+"<br>"	

lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

If Not gf_ge202_envia_email_padrao(270, lst_Email)	Then
	Return False
End If
			
Return True
end function

public function boolean of_verifica_campanha_ativa (long al_filial, ref long al_campanha, ref string as_erro);al_Campanha = 0

Select top 1 coalesce(c.nr_campanha, 0)
	Into :al_Campanha
From dermaclub_campanha c
Where (c.cd_uf in (select y.cd_unidade_federacao
						from filial x
							inner join cidade y
								on y.cd_cidade = x.cd_cidade
						where x.cd_filial = :al_Filial)) or (c.cd_uf is null)
Order by c.nr_campanha desc
Using SqlCa;

If SqlCa.SqlCode = - 1 Then
	as_Erro = "Erro ao localizar a campanha ativa para a filial " + String(al_Filial) + ". " + SqlCa.SqlErrText
	Return False				
End If

Return True
end function

public function boolean of_verifica_produto_repetido (long pl_filial, long pl_nota, string ps_especie, string ps_serie, ref boolean pb_produto_repetido);Long ll_Linha

Boolean lb_Produto_Repete = False

Long ll_Qtd_Repetida

SELECT 	count(v.cd_produto) as qt_linha_por_produto 
Into :ll_Qtd_Repetida
FROM venda_dermaclub_produto v
WHERE cd_filial =  :pl_filial
	AND nr_nf =:pl_nota
	AND de_especie = :ps_especie
	AND de_serie= :ps_serie   
Group by v.cd_produto
Having count(v.cd_produto) > 1
Using SqlCa;

If SqlCa.SqlCode = - 1 Then
	Return False				
End If

If ll_Qtd_Repetida > 1 And Not IsNull(ll_Qtd_Repetida) Then
	lb_Produto_Repete = True
End If

pb_produto_repetido = lb_Produto_Repete

Return True

end function

public function boolean of_registra_desconto (string ps_sessao, long pl_filial, long pl_nota, string ps_especie, string ps_serie, string ps_pagamento, string ps_cnpj, ref string ps_json_retorno, ref string ps_erro, boolean pb_produto_repetido);String ls_Json_Envio
String ls_Terminal
String ls_interface
String ls_digitos
String ls_Controle_Interno
String ls_sessao
String ls_data_registro
Long ll_tamanho, ll_digito, ll_row
Long ll_sequencial
DateTime ldh_data
String ls_itens
Long ll_tipo_produto
Long ll_Campanha_Ativa = 0
String ls_Produtos_Venda
String ls_Preco_Unitario, ls_Desconto_Unitario

SetNull(ps_Json_Retorno)
SetNull(ls_Produtos_Venda)

ls_interface = 'descontos/registrar'

dc_uo_ds_Base lvds_itens_venda
lvds_itens_venda = Create dc_uo_ds_Base

If pb_produto_repetido Then
	If Not lvds_itens_venda.of_ChangeDataObject("ds_ge536_itens_venda_duo") Then
		Destroy(lvds_itens_venda)
		Return False
	End If
Else
	If Not lvds_itens_venda.of_ChangeDataObject("ds_ge536_itens_venda") Then
		Destroy(lvds_itens_venda)
		Return False
	End If
End If
lvds_itens_venda.of_RestoreSqlOriginal()
lvds_itens_venda.Retrieve(pl_filial,pl_nota,ps_especie,ps_serie)

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "CL" Then
	If Not This.of_Verifica_Campanha_Ativa(pl_Filial, Ref ll_Campanha_Ativa, Ref ps_Erro) Then Return False
End If

For ll_row = 1 TO lvds_itens_venda.RowCount()
	If lvds_itens_venda.Object.vl_desconto_dermaclub[ll_row] = 0 Then
		ll_tipo_produto = 0
	Else
		If lvds_itens_venda.Object.id_dermaclub[ll_row] = 'S' Then
			ll_tipo_produto = 0
		Else
			ll_tipo_produto = 90
		End If
	End If
	
	//Para contornar o probelma das vendas ecommer com campanha inativa
	If ll_Campanha_Ativa > 0 Then
		lvds_itens_venda.Object.nr_campanha[ll_row] = ll_Campanha_Ativa
	End If
	
	
	If ll_row = 1 Then
		ls_Preco_Unitario = gf_valor_com_ponto( lvds_itens_venda.Object.vl_preco_unitario[ll_row] )
		ls_itens =    "{" + &
						'"idCampanha": ' + String(lvds_itens_venda.Object.nr_campanha[ll_row])  +',' + &
						'"tipoProduto": ' + String(ll_tipo_produto) + ',' + &
						'"codigoProduto": "' + lvds_itens_venda.Object.de_codigo_barras[ll_row] + '",' + &
						'"precoUnitario": ' + ls_Preco_Unitario + ', ' 
						
		If pb_produto_repetido Then
			ls_Desconto_Unitario = gf_valor_com_ponto( truncate((lvds_itens_venda.Object.vl_total_desconto[ll_row] / lvds_itens_venda.Object.qt_vendida[ll_row]), 2) )
			ls_itens = ls_itens + '"descUnitario": ' + ls_Desconto_Unitario + ', ' 
		Else
			ls_Desconto_Unitario = gf_valor_com_ponto( lvds_itens_venda.Object.vl_preco_unitario[ll_row] - lvds_itens_venda.Object.vl_praticado[ll_row] ) 
			ls_itens = ls_itens + '"descUnitario": ' + ls_Desconto_Unitario + ', ' 
		End If
		
		ls_itens = ls_itens + '"descTotal": 0,' + &
						'"qtdeVendida": ' + String(lvds_itens_venda.Object.qt_vendida[ll_row]) + &
						"}"		
	Else
		ls_Preco_Unitario = gf_valor_com_ponto( lvds_itens_venda.Object.vl_preco_unitario[ll_row] )
		ls_itens = ls_itens + ",{" + &
						'"idCampanha": ' + String(lvds_itens_venda.Object.nr_campanha[ll_row])  +',' + &
						'"tipoProduto": ' + String(ll_tipo_produto) + ',' + &
						'"codigoProduto": "' + lvds_itens_venda.Object.de_codigo_barras[ll_row] + '",' + &
						'"precoUnitario": ' + ls_Preco_Unitario + ', ' 
		
		If pb_produto_repetido Then
			ls_Desconto_Unitario =  gf_valor_com_ponto( truncate((lvds_itens_venda.Object.vl_total_desconto[ll_row] / lvds_itens_venda.Object.qt_vendida[ll_row]), 2) )
			ls_itens = ls_itens + '"descUnitario": ' + ls_Desconto_Unitario + ', ' 
		Else
			ls_Desconto_Unitario = gf_valor_com_ponto( lvds_itens_venda.Object.vl_preco_unitario[ll_row] - lvds_itens_venda.Object.vl_praticado[ll_row] )
			ls_itens = ls_itens + '"descUnitario": ' + ls_Desconto_Unitario + ', ' 
		End If
		
		ls_itens = ls_itens + '"descTotal": 0,' + &
						'"qtdeVendida": ' + String(lvds_itens_venda.Object.qt_vendida[ll_row]) + &
						"}"
	End If			
	
	If Long(ls_Preco_Unitario) > 0 And Trim(ls_Preco_Unitario) = Trim(ls_Desconto_Unitario) Then
		ps_erro = 'Pre$$HEX1$$e700$$ENDHEX$$o Unit$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o pode ser igual ao Desconto Unit$$HEX1$$e100$$ENDHEX$$rio. ' + 'Produto:'+string(lvds_itens_venda.Object.cd_produto[ll_row]) + ' Pre$$HEX1$$e700$$ENDHEX$$o Un.:' + ls_Preco_Unitario + '; Desc. Un.:' + ls_Desconto_Unitario
		Return False
	End If
	
Next

Destroy (lvds_itens_venda)

ldh_data = gf_getserverdate()  //Data hora abertura tela
ll_tamanho = LenA(Trim(gvo_aplicacao.of_ComputerName()))
ls_digitos    = Mid(Trim(gvo_aplicacao.of_ComputerName()), ll_tamanho - 1 )
If IsNumber (ls_digitos) Then
	ll_digito = Long(ls_digitos)
	ls_Controle_Interno	= String(ldh_data, 'YYSSHHMMDD') + ls_digitos	
Else
	ls_Controle_Interno	= String(ldh_data, 'YYSSHHMMDD')
End If

ls_data_registro  = String(ldh_data,'YYYY-mm-dd"T"HH:mm:ss.fff')
					 
ls_Json_Envio = "{" + &
					 '"cnpj": ' + ps_cnpj + ', ' + &
					 '"idTerminal": "' + gvo_aplicacao.of_ComputerName() + '", ' + &
					 '"nsuReq": ' + ls_Controle_Interno + ',' + &
					 '"numSessao": "' + ps_sessao + '", ' + &
					 '"numCupom":  "' + string(pl_nota) + '",' +&
					 '"codigoFinalizacao": "00", ' + &
					 '"bin": null, ' + &
					 '"descontoFinanceiro": 0, ' + &
					 '"dataHora": "' + ls_data_registro +'", ' + &
					 '"itensDescontos": [' + ls_itens + & 
					 "]," + &
					 '"formaPagamento": "' + ps_pagamento + '", ' +&
  					 '"valorCashback": 0, ' + &
					 '"cartoes": null' + &
					"}"

If Not This.of_post( ls_json_Envio, ls_interface, ref ps_Json_Retorno, ref ps_Erro ) Then Return False

Return True
end function

on uo_ge536_dermaclub_loja.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge536_dermaclub_loja.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;	If IsValid(io_Json) Then Destroy(io_Json)
end event

event constructor;This.is_arquivo_log = 'c:\Sistemas\' + gvo_Aplicacao.ivo_Seguranca.Cd_Sistema  + '\Arquivos\dermaclub.log'
This.is_diretorio_log = 'c:\Sistemas\' + gvo_Aplicacao.ivo_Seguranca.Cd_Sistema  + '\Arquivos'
end event

