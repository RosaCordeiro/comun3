HA$PBExportHeader$uo_ge536_dermaclub_comum.sru
forward
global type uo_ge536_dermaclub_comum from nonvisualobject
end type
end forward

global type uo_ge536_dermaclub_comum from nonvisualobject
end type
global uo_ge536_dermaclub_comum uo_ge536_dermaclub_comum

type prototypes
FUNCTION long GetCurrentProcessId()  LIBRARY "kernel32.dll" 
end prototypes

type variables
Long il_cd_produto
Long il_Status_Code
Long il_Seq_Consulta

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
String is_x_api_key

String is_Url_Status_Servico
String is_Url_Envio
String is_Url_Retorno

String is_CNPJ_Login

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
public function boolean of_busca_url (string as_operacao, ref string as_url, ref string as_erro)
public function boolean of_consulta_parametro_geral (string as_cd_parametro, ref string as_vl_parametro, ref string as_erro)
public function boolean of_valida_resposta (string as_cd_resposta, ref string as_de_resposta)
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
	
Try	
	
	IF Not IsValid(iole_SrvHTTP) THEN
		
		iole_SrvHTTP = CREATE oleobject
		//iole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		//iole_SrvHTTP.ConnectToNewObject("WinHTTP.WinHTTPRequest.5.1")
		//alguns win7 n$$HEX1$$e300$$ENDHEX$$o funcionava com serverxmlhttp, por isso foi trocado
		iole_SrvHTTP.ConnectToNewObject("MSXML2.XMLHTTP.6.0")
		iole_Send = CREATE oleobject
		iole_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")
		
	End If
	
	iole_SrvHTTP.open (ps_metodo, ls_url_local, false) 
	
	iole_SrvHTTP.SetRequestHeader("content-type", "application/json")
	
	if is_x_api_key <> '' and not isnull(is_x_api_key) Then
		iole_SrvHTTP.setRequestHeader("x-api-key", is_x_api_key)
	End If
	
	if is_token <> '' and not isnull(is_token) Then		
		iole_SrvHTTP.SetRequestHeader("token", is_token)
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
			
			ps_retorno = ''
			ps_log = ls_status_text
			
			return false
		
		else
			
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

//ls_id_interface = 'api/v1/oauth/token'

If Not This.of_Consulta_Parametro_Geral("ID_LOGIN_DERMACLUB", Ref is_usuario, ps_Log) Then Return False

If Not This.of_Consulta_Parametro_Geral("ID_PWD_DERMACLUB", Ref is_senha, ps_Log) Then Return False

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

public function boolean of_busca_url (string as_operacao, ref string as_url, ref string as_erro);String ls_Endereco_URL_1
String ls_Endereco_URL_2
String ls_URL_Autorizador
String ls_Vl_Parametro
String ls_Cd_Parametro

Try

	uo_parametro_geral lo_Parametro_Geral	
	lo_Parametro_Geral = Create uo_parametro_geral
	
	as_url = ""
	as_erro = ""
	
	lo_Parametro_Geral.ib_mostra_mensagem = False
	
	//Captura a primeira parte do endere$$HEX1$$e700$$ENDHEX$$o para conectar na URL
	If Not This.of_Consulta_Parametro_Geral("DE_ENDERECO_URL_DERMACLUB_1", Ref ls_Endereco_URL_1, Ref as_Erro) Then
		as_Erro = lo_Parametro_Geral.is_mensagem_log
		Return False
	End If	
	
	//Captura a segunda parte do endere$$HEX1$$e700$$ENDHEX$$o para conectar na URL
	If Not This.of_Consulta_Parametro_Geral("DE_ENDERECO_URL_DERMACLUB_2", Ref ls_Endereco_URL_2, Ref as_Erro) Then
		as_Erro = lo_Parametro_Geral.is_mensagem_log
		Return False
	End If	

	//Captura a parte do autorizador na URL
	If Not This.of_Consulta_Parametro_Geral("ID_URL_DERMACLUB", Ref ls_URL_Autorizador, Ref as_Erro) Then
		as_Erro = lo_Parametro_Geral.is_mensagem_log
		Return False
	End If	
	
	If Not This.of_Consulta_Parametro_Geral("ID_API_KEY_DERMACLUB", Ref is_x_api_key, Ref as_Erro) Then
		as_Erro = lo_Parametro_Geral.is_mensagem_log
		Return False
	End If	
	
	If Not This.of_Consulta_Parametro_Geral("NR_CNPJ_LOGIN_DERMACLUB", Ref ls_Vl_Parametro, Ref as_Erro) Then
		as_Erro = lo_Parametro_Geral.is_mensagem_log
		Return False
	End If
	
	This.is_CNPJ_Login = ls_Vl_Parametro
	
	If as_Operacao <> "ENVIAR" Then	
		If Not This.of_Consulta_Parametro_Geral("NR_SEQUENCIAL_CONSULTA_DERMACLUB", Ref ls_Vl_Parametro, Ref as_Erro) Then
			as_Erro = lo_Parametro_Geral.is_mensagem_log
			Return False
		End If
		
		il_Seq_Consulta = Long(ls_Vl_Parametro)
		
		//Proximo sequencial
		il_Seq_Consulta++
	End If
	
	Choose Case Upper(as_Operacao)
		Case "ENTRAR"			
			ls_Cd_Parametro = "ID_URL_DERMACLUB_ENTRAR"
			
		Case "CONSULTAR"			
			ls_Cd_Parametro = "ID_URL_DERMACLUB_CONSULTAR"
			
		Case "ENVIAR"
			ls_Cd_Parametro = "ID_URL_DERMACLUB_ENVIO_INFORMACAO"
	End Choose
	
	If Not This.of_Consulta_Parametro_Geral(ls_Cd_Parametro, Ref ls_Vl_Parametro, Ref as_Erro) Then
		as_Erro = lo_Parametro_Geral.is_mensagem_log
		Return False
	End If
	
	as_url = ls_Endereco_URL_1 + ls_Endereco_URL_2 + ls_URL_Autorizador + ls_Vl_Parametro
	
	Return True
	
Catch (RunTimeError lo_error)
	as_Erro = lo_error.GetMessage()
	Return False
	
Finally
	If IsValid(lo_Parametro_Geral) Then Destroy(lo_Parametro_Geral)
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

public function boolean of_valida_resposta (string as_cd_resposta, ref string as_de_resposta);Choose Case as_cd_resposta
	Case '00'
		Return True	
	Case 'C0'
		as_De_Resposta = "Canal de venda inv$$HEX1$$e100$$ENDHEX$$lido."
	Case 'E0'
		as_De_Resposta = "Par$$HEX1$$e200$$ENDHEX$$metros mandat$$HEX1$$f300$$ENDHEX$$rios ausentes ou inv$$HEX1$$e100$$ENDHEX$$lidos."
	Case 'P0'
		as_De_Resposta = "Meio de pagamento inv$$HEX1$$e100$$ENDHEX$$lido."
	Case 'S0'
		as_De_Resposta = "Identifica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o encontrada na base(Dermaclub)."
	Case 'S1'
		as_De_Resposta = "S$$HEX1$$f300$$ENDHEX$$cio inativo."
	Case 'S2'
		as_De_Resposta = "Transa$$HEX2$$e700e300$$ENDHEX$$o indefinida."
	Case 'S3'
		as_De_Resposta = "Documento inexistente."
	Case 'S4'
		as_De_Resposta = "Transa$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ efetuada anteriormente."
	Case 'S5'
		as_De_Resposta = "CPF inv$$HEX1$$e100$$ENDHEX$$lido."
	Case 'S6'
		as_De_Resposta = "Transa$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ cancelada."
	Case 'S7'
		as_De_Resposta = "Transa$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ aprovada."
	Case 'V2'
		as_De_Resposta = "C$$HEX1$$f300$$ENDHEX$$digo de estabelecimento indefinido."		
	Case 'V3'
		as_De_Resposta = "CGC / CNPJ inv$$HEX1$$e100$$ENDHEX$$lido."
	Case 'T0'
		as_De_Resposta = "Vers$$HEX1$$e300$$ENDHEX$$o da tabela desatualizada."		
	Case Else
		as_De_Resposta = "C$$HEX1$$f300$$ENDHEX$$digo de Resposta Desconhecido."
End Choose

Return False
end function

on uo_ge536_dermaclub_comum.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge536_dermaclub_comum.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

