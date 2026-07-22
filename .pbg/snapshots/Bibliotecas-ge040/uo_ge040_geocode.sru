HA$PBExportHeader$uo_ge040_geocode.sru
$PBExportComments$Userobject to perform network Ping
forward
global type uo_ge040_geocode from nonvisualobject
end type
end forward

global type uo_ge040_geocode from nonvisualobject
end type
global uo_ge040_geocode uo_ge040_geocode

type variables
String	is_nm_cidade,&
		is_uf,&
		is_longitude,&
		is_latitude,&
		is_bairro,&
		is_cep,&
		is_logradouro

uo_ge073_json	io_Json

Boolean ib_cep_unico
		
String	is_Url_Producao
		
String is_token_site = '204c5715f7234cb7a1b9ce29c0647a86'
//token usado para fazer a consulta no site https://opencagedata.com/
//dados do cadastro no site
//user wagner.frasseto@clamed.com.br
//pw: clamed@321
		

end variables

forward prototypes
private function boolean of_processa_retorno (string as_json, ref string as_erro)
public function boolean of_envia_solicitacao (string as_metodo, string as_url, string as_json_envio, string as_parametros, boolean ab_utiliza_parametros, ref string as_json_retorno, ref string as_erro)
public subroutine of_inicializa ()
public function boolean of_dados_endereco (string as_endereco, boolean ab_limitar_busca, ref string as_json, ref string as_erro)
end prototypes

private function boolean of_processa_retorno (string as_json, ref string as_erro);
String	ls_Parte_Json,&
		ls_Parte_Erro,&
		ls_Valido,&
		ls_Json_Campo,&
		ls_Entidade,&
		ls_Campo,&
		ls_Exibicao,&
		ls_Existe_Produto_Programa,&
		ls_Json_Temp,&
		ls_Parte_Patologia,&
		ls_Campos_Beneficiario
		
Long	ll_Qt_Retorno

String ls_Code, ls_Msg_Retorno, ls_Parte_GeoCod

Try
		as_Erro = ""	

		//Verifica Status
		ls_Json_Temp = as_json
		io_Json.of_divide_grupo_json_tag(ls_Json_Temp, 'status', Ref ls_Parte_Json,'}')
		If Pos(ls_Parte_Json, "code") < 1 Then
			as_Erro = "Erro ao verificar o Retorno do WebService"
			Return False
		End If
		ls_Code 				= Upper(io_Json.of_busca_conteudo_campo(ls_Parte_Json, 'code'))
		ls_Msg_Retorno 	= Upper(io_Json.of_busca_conteudo_campo(ls_Parte_Json, 'message'))
		
		Choose Case ls_Code
			Case '200' 
				// ok
			Case '400'
				//Solicita$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida (solicita$$HEX2$$e700e300$$ENDHEX$$o incorreta; um par$$HEX1$$e200$$ENDHEX$$metro obrigat$$HEX1$$f300$$ENDHEX$$rio em falta; coordenadas inv$$HEX1$$e100$$ENDHEX$$lidas; vers$$HEX1$$e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida; formato inv$$HEX1$$e100$$ENDHEX$$lido)
				as_Erro = 'Solicita$$HEX2$$e700e300$$ENDHEX$$o incorreta.~r' + ls_Msg_Retorno

			Case '401'
				//Incapaz de autenticar - chave API ausente, inv$$HEX1$$e100$$ENDHEX$$lida ou desconhecida
				as_Erro = 'Chave de autentica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida.~r' + ls_Msg_Retorno
				
			Case '402'
				//Solicita$$HEX2$$e700e300$$ENDHEX$$o v$$HEX1$$e100$$ENDHEX$$lida, mas cota excedida (pagamento necess$$HEX1$$e100$$ENDHEX$$rio)
				 //Cota 2.500 consultas/dia
				as_Erro = 'Cota excedida para consulta.~r' + ls_Msg_Retorno
			
			Case Else
				//Erro no WebService
				as_Erro = ls_Msg_Retorno
		End Choose
		
		If ls_Msg_Retorno <> 'OK' Then
			Return False
		End If
		
		ll_Qt_Retorno 		= Long( Upper(io_Json.of_busca_conteudo_campo(as_json, 'total_results')) )
		
		If ll_Qt_Retorno = 0 Then
			//MessageBox("", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o encontrada para calcular a distancia entre o endere$$HEX1$$e700$$ENDHEX$$o do cliente e a filial.")
			Return False
		End If
		
		If ll_Qt_Retorno > 1 Then
			//
		End If
				
		//components
		ls_Json_Temp = as_json
		io_Json.of_divide_grupo_json_tag(ls_Json_Temp, 'components', Ref ls_Parte_Json,'confidence')
		io_Json.of_divide_grupo_json_tag(ls_Json_Temp, 'geometry', Ref ls_Parte_GeoCod,'}')		

		If Pos(ls_Parte_Json, "ISO") < 1 Then
			as_Erro = "Erro ao verificar o Retorno do WebService"
			Return False
		End If
		is_latitude		= Upper(io_Json.of_busca_conteudo_campo(ls_Parte_GeoCod, 'lat'))
		is_longitude		= Upper(io_Json.of_busca_conteudo_campo(ls_Parte_GeoCod, 'lng'))
		
		If PosA( ls_Parte_Json, 'road' ) > 0 Then
			is_logradouro	= Upper(io_Json.of_busca_conteudo_campo_vtex(ls_Parte_Json, 'road'))
		End If
		If PosA( ls_Parte_Json, 'state_code' ) > 0 Then
			is_uf				= Upper(io_Json.of_busca_conteudo_campo(ls_Parte_Json, 'state_code'))
		End If
		If PosA( ls_Parte_Json, 'suburb' ) > 0 Then
			is_bairro			= Upper(io_Json.of_busca_conteudo_campo(ls_Parte_Json, 'suburb'))
		End IF
		If PosA( ls_Parte_Json, 'postcode' ) > 0 Then
			is_cep			= Upper(io_Json.of_busca_conteudo_campo(ls_Parte_Json, 'postcode'))
		End If
		
Catch (RuntimeError rte)
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_retorno, objeto uo_ge040_geocode. Erro: " + rte.getMessage()
	Return False
End Try

Return True
end function

public function boolean of_envia_solicitacao (string as_metodo, string as_url, string as_json_envio, string as_parametros, boolean ab_utiliza_parametros, ref string as_json_retorno, ref string as_erro);String		ls_Status_Text

long   ll_Status_Code

OleObject	lo_Http,&
				lo_Send

Try

	Try
		lo_Http = CREATE oleobject
		lo_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
		
		lo_Send = CREATE oleobject
		lo_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")
		
		lo_Http.open (as_Metodo, as_Url, False)
		
		lo_Http.SetTimeOuts(5000,5000,30000,120000)
		lo_Http.SetAutomationTimeout(120000)
		lo_Http.SetRequestHeader( "Content-Type", "application/json")
		lo_Http.SetOption(2,'13056') 
		//lo_Http.SetRequestHeader("Authorization", "key=" + is_token_site) 
				
		If as_Metodo = "POST" Then
			lo_Http.send(as_Json_Envio)
		Else
			lo_Http.send(lo_Send)
		End If
		
		//Pega a resposta do web service
		ls_Status_Text = lo_Http.StatusText
		ll_Status_Code = lo_Http.Status
	
		If ll_Status_Code > 200 Then
			as_Erro = "Erro no retorno do Web Service.~r~nC$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ "~r~nDescri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
			Return False
		Else
		//Pega o retorno do web service
			as_Json_Retorno = lo_Http.ResponseText
		End If
	Finally
		//Disconecta		
		IF IsValid(lo_HTTP) THEN 
			lo_Http.DisconnectObject()
			Destroy lo_Http 
		end if
		
		IF IsValid(lo_Send) THEN 
			lo_Send.DisconnectObject()
			Destroy lo_Send 
		end if

	End Try

Catch (RuntimeError rte)
	as_Erro = "Ocorreu erro ao enviar o arquivo para o Web Service. Erro: " + rte.getMessage()
	Return False
End Try

Return True
end function

public subroutine of_inicializa ();SetNull(is_nm_cidade)
SetNull(is_uf)
SetNull(is_longitude)
SetNull(is_latitude)
SetNull(is_bairro)
SetNull(is_cep)
SetNull(is_logradouro)

ib_cep_unico = false
end subroutine

public function boolean of_dados_endereco (string as_endereco, boolean ab_limitar_busca, ref string as_json, ref string as_erro);String	ls_Url,&
		ls_json_retorno
		
String ls_min_confidence
		
Boolean	lb_Sucesso	= False

Try
	Open(w_Aguarde)
	w_Aguarde.Title = "Buscando informa$$HEX2$$e700f500$$ENDHEX$$es do Endere$$HEX1$$e700$$ENDHEX$$o..."
	w_Aguarde.uo_Progress.of_SetMax(2)
	w_Aguarde.uo_Progress.of_SetProgress(1)

	Try
		This.of_inicializa( )
		
		//Se existir endere$$HEX1$$e700$$ENDHEX$$o limita a busca em um raio de 1km
		If ab_limitar_busca Then
			ls_min_confidence = '&min_confidence=8'
		Else
			ls_min_confidence =''
		End If
		
		ls_Url	= is_Url_Producao + "q=" + as_endereco + '&key='+is_token_site+'&countrycode=BR&limit=1' + ls_min_confidence
		
		If This.of_Envia_solicitacao("GET", ls_Url, "", "", False, Ref ls_Json_Retorno, Ref as_Erro) Then		
			If This.of_Processa_Retorno(ls_Json_Retorno,  Ref as_Erro) Then
				as_json = ls_Json_Retorno
				lb_Sucesso = True
			End If
		End If
		
		Return lb_Sucesso
		
	Catch (RuntimeError rte)
		as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_dados_endereco, objeto uo_ge040_geocode. Erro: " + rte.getMessage()
		Return False
	End Try
Finally
	Close(W_Aguarde)
End Try


end function

on uo_ge040_geocode.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge040_geocode.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Json = Create uo_ge073_json

is_Url_Producao		= "http://api.opencagedata.com/geocode/v1/json?"

end event

event destructor;Destroy(io_Json)
end event

