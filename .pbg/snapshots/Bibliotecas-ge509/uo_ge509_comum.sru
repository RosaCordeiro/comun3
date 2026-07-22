HA$PBExportHeader$uo_ge509_comum.sru
forward
global type uo_ge509_comum from nonvisualobject
end type
end forward

global type uo_ge509_comum from nonvisualobject
end type
global uo_ge509_comum uo_ge509_comum

type variables

String is_objeto
string is_url, is_chave, is_token, is_id_interface
String is_id_metodo_api
String is_json

OleObject iole_SrvHTTP, iole_Send

end variables

forward prototypes
public function boolean of_post (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
private function boolean of_comunicacao_api (string ps_metodo, string ps_json, ref string ps_retorno, ref string ps_log)
public function boolean of_put (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function boolean of_tratar_retorno (string ps_json, ref string ps_retorno, ref string ps_log)
public function string of_tratar_erro (string ps_mensagem)
public function boolean of_get (string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function decimal of_decimal (long pl_valor)
public function long of_desenvolvimento_filial_baixa_pedido ()
public function string of_desenvolvimento_odbc_baixa_pedido ()
public function boolean of_carrega_parametro (ref string ps_log)
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
	
	If Not this.of_carrega_parametro( ref ps_log ) Then return false
	
	IF Not IsValid(iole_SrvHTTP) THEN
		
		iole_SrvHTTP = CREATE oleobject
		iole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		//iole_SrvHTTP.ConnectToNewObject("WinHTTP.WinHTTPRequest.5.1")
		iole_Send = CREATE oleobject
		iole_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")
		
	End If
	
	iole_SrvHTTP.open (ps_metodo, ls_url_local, false) 
	
	iole_SrvHTTP.SetRequestHeader("content-type", "application/json")
	iole_SrvHTTP.SetRequestHeader("token", is_token)
	
	// Trust the SSL Certificate - IGNORA OS ERROS DE CERTIFICADO
	iole_SrvHTTP.setOption(2,'13056') 
	
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
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: ' + e.getMessage()
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
				if Not this.of_tratar_retorno( ls_retorno_api, ref ps_retorno, ref ps_log) Then Return false
				
				if upper(ps_retorno) = 'FALSE' Then
					if ls_Retorno_Api = '' or isnull(ls_Retorno_Api) Then
						ls_Retorno_Api = 'Erro no retorno do webservice: Sucesso = FALSE'
					end if
					ps_log = ls_retorno_api
					ps_retorno = ''
				end if
				
			end if
		
		elseif ll_status_code = 401 Then
			
			ps_retorno = ''
			if ls_status_text = '' or isnull(ls_status_text) Then
				ls_status_text = 'Erro no retorno do webservice: Erro 401'
			end if
			
			ps_log = ls_status_text
			
			return false
		
		else
			
			ps_retorno = ''
			
			if ls_Retorno_Api = '' or isnull(ls_Retorno_Api) Then
				ls_Retorno_Api = 'Erro no retorno do webservice: Erro ' + string(ll_status_code)
			end if
			
			ps_log = ls_Retorno_Api
			Return True
			
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

public function boolean of_tratar_retorno (string ps_json, ref string ps_retorno, ref string ps_log);uo_ge073_json luo_json

luo_json = create uo_ge073_json

if match( ps_json, 'success') = True Then
	ps_retorno = luo_json.of_busca_conteudo_campo( ps_json, 'success')
else
	ps_retorno = ps_json
end if

destroy(luo_json)

return true
end function

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

public function long of_desenvolvimento_filial_baixa_pedido ();Long  ll_Retorno
String ls_Parametro 

ls_Parametro = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'ECOMMERCE', 'Filial_Baixa_Pedido', "")

If Not IsNull(ls_Parametro) and Trim(ls_Parametro) <> ''  Then
	ll_Retorno =  Long(ls_Parametro)
Else
	SetNull(ll_Retorno)
End If

Return ll_Retorno





end function

public function string of_desenvolvimento_odbc_baixa_pedido ();String ls_Parametro 

ls_Parametro = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'ECOMMERCE', 'ODBC_Baixa_Pedido', "")

If Trim(ls_Parametro) = ''  Then SetNull(ls_Parametro)

Return ls_Parametro

end function

public function boolean of_carrega_parametro (ref string ps_log);
If (SqlCa.Database = 'central') Then
	
	select vl_parametro
	into :is_token
	from parametro_geral
	where cd_parametro = 'CD_TOKEN_EQUILIBRIUM_PRODUCAO';
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_parametro ; Problemas ao consultar a tabela "parametro_geral": ' + sqlca.sqlerrtext
		return false
	end if

else
	
	select vl_parametro
	into :is_token
	from parametro_geral
	where cd_parametro = 'CD_TOKEN_EQUILIBRIUM_HOMOLOGACAO';
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_parametro ; Problemas ao consultar a tabela "parametro_geral": ' + sqlca.sqlerrtext
		return false
	end if
	
end if

if is_token = '' or isnull(is_token) Then
	ps_log = is_objeto + 'O Token de comunica$$HEX2$$e700e300$$ENDHEX$$o com a interface Equilibrium n$$HEX1$$e300$$ENDHEX$$o foi encontrado.'
	return false
end if

return true

end function

on uo_ge509_comum.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge509_comum.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - Objeto: ' + this.classname( ) + ' ; '
end event

