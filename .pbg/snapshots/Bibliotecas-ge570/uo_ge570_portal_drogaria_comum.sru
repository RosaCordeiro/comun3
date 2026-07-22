HA$PBExportHeader$uo_ge570_portal_drogaria_comum.sru
forward
global type uo_ge570_portal_drogaria_comum from nonvisualobject
end type
end forward

global type uo_ge570_portal_drogaria_comum from nonvisualobject
end type
global uo_ge570_portal_drogaria_comum uo_ge570_portal_drogaria_comum

type variables
Private String is_OleServer, is_OleSend

Boolean ib_Grava_Log_Json = False

Long il_cd_produto
Long il_Status_Code
Long il_Seq_Consulta

String is_usuario
String is_senha
String is_url
String is_chave
String is_token	
String is_token_APICentral	//Java
String is_url_APICentral 		//Java
String is_json
String is_cd_ean

String is_CNPJ_Login
String is_Table_ID
String is_Cliente_ID

uo_ge073_json io_Json_Token

OleObject iole_SrvHTTP, iole_Send
end variables

forward prototypes
public function boolean of_comunicacao_api (string ps_metodo, string ps_json, ref string ps_retorno, ref string ps_log)
public function boolean of_gera_token (ref string as_erro)
public function boolean of_post (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function boolean of_envia_email (string as_mensagem)
public function boolean of_setoleobject ()
public function boolean of_verifica_url_integracao (string as_parametro, ref string as_erro)
public function boolean of_get (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function boolean of_verifica_parametro (string as_parametro, ref string as_valor_parametro, ref string as_erro)
public function boolean of_produto_pbm_portal_drogaria (long pl_produto, ref boolean ab_produto_portal, ref boolean ab_informa_cartao, ref boolean ab_informa_cpf)
end prototypes

public function boolean of_comunicacao_api (string ps_metodo, string ps_json, ref string ps_retorno, ref string ps_log);Long ll_status_code
String ls_url_local
String ls_status_text
String ls_Retorno_Api
any la_result
	
String ls_OleObject

Integer li_Ret

Try
	
	If ib_Grava_Log_Json Then
		gvo_Aplicacao.of_grava_log( "*** INTEGRA$$HEX2$$c700c300$$ENDHEX$$O PORTAL DROGARIA***")
		gvo_Aplicacao.of_grava_log( "* of_comunicacao_api" )
		gvo_Aplicacao.of_grava_log( "JSON: " + ps_json )
		gvo_Aplicacao.of_grava_log( "Metodo: " + ps_metodo )
		gvo_Aplicacao.of_grava_log( "is_OleServer: " + is_OleServer )
		gvo_Aplicacao.of_grava_log( "is_OleSend: " + is_OleSend )
	End If	
			
	IF Not IsValid(iole_SrvHTTP) THEN
					
		iole_SrvHTTP = CREATE oleobject
		iole_SrvHTTP.ConnectToNewObject( is_OleServer )
		iole_Send = CREATE oleobject
		iole_Send.ConnectToNewObject( is_OleSend )
		
	End If
	
	//Adiciona $$HEX1$$e000$$ENDHEX$$ url qual interface est$$HEX1$$e100$$ENDHEX$$ sendo utilizada
	ls_url_local = IIF( ps_metodo = 'GET', is_url_APICentral, is_url )
	
	iole_SrvHTTP.open (ps_metodo, ls_url_local, false) 
	
	If(ps_metodo = 'GET') Then
		iole_SrvHTTP.SetRequestHeader("cdfilial", "2")
		iole_SrvHTTP.SetRequestHeader("token", This.is_token_apicentral )
	Else
		iole_SrvHTTP.SetRequestHeader("content-type", "application/json")
	
		if is_token <> '' and not isnull(is_token) Then		
			iole_SrvHTTP.SetRequestHeader("Authorization", "bearer " + This.is_token)
			iole_SrvHTTP.SetRequestHeader("Version", '1')
		end if
		
	End IF	
	
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
		
		ls_Retorno_Api = String( Trim(iole_SrvHTTP.ResponseText) )	
		
		If ib_Grava_Log_Json Then
			gvo_Aplicacao.of_grava_log( "INTEGRACAO PORTAL DROGARIA - StatusText: " + ls_status_text )
			gvo_Aplicacao.of_grava_log( "INTEGRACAO PORTAL DROGARIA - StatusCode: " + String(ll_status_code) )
			//Na matriz gera a carga de tabela, $$HEX1$$e900$$ENDHEX$$ muito grande p/ gravar no log
			If gvo_Aplicacao.ivo_seguranca.cd_sistema = "RL" Or gvo_Aplicacao.ivo_seguranca.cd_sistema = "CL" Then
				gvo_Aplicacao.of_grava_log( "INTEGRACAO PORTAL DROGARIA - Retorno API: " + ls_Retorno_Api )
			End If
		End If	
		
		If ll_status_code = 200 Then //Conseguiu Conectar
		
			ps_retorno = ls_retorno_api
					
		Elseif ll_status_code = 401 Then
			
//			IF Upper(ls_status_text) = 'UNAUTHORIZED' Then
//				//Chamada Recursiva para gerar novamente o Token
//				This.of_gera_token( Ref ps_Log) 
//				Return This.of_comunicacao_api( ps_metodo, ps_json, Ref ps_retorno, Ref ps_log)		
//			End If
			
			ps_retorno = ''
			ps_log = ls_status_text
			
			return false	
		Else		
			ps_retorno = ''
			//if Not this.of_tratar_retorno( ls_retorno_api, True, ref ps_retorno, ref ps_log) Then Return false
			ps_log = ps_retorno
			Return false
		End If
		
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

public function boolean of_gera_token (ref string as_erro);
/*
O metodo gera token utiliza um api desenvolvida em Java para realizar a buscar do Token do portal da Drogaria
Loja --> API Central --> Token Portal Drogaria
*/

String ls_JsonRetorno
Integer li_Count = 0

//Rodar novamente por causa do balanceamento de carga pgPool
DO
	If li_Count > 3 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o Token de acesso na Matriz.", Exclamation!)
		as_erro = "TOKEN / Table_ID n$$HEX1$$e300$$ENDHEX$$o identificado."
		Return False
	End If

	If Not This.of_get( "TOKEN API CENTRAL - JAVA URL: "+ This.is_url_apicentral , "",  Ref ls_JsonRetorno, ref as_erro) Then
		Return False
	End If

	This.is_token 		= io_json_Token.of_busca_conteudo_campo_vtex(ls_JsonRetorno, 'accessKey')
	This.is_Table_ID	= io_json_Token.of_busca_conteudo_campo_vtex(ls_JsonRetorno, 'idTables')
	
	li_Count++
LOOP WHILE IsNull(This.is_token) Or Trim(This.is_token) = ''

If This.is_token = "" Or This.is_Table_ID = "" Then
	as_erro = "TOKEN / Table_ID n$$HEX1$$e300$$ENDHEX$$o identificado."
	Return False
End If

Return True


/**********************
Realizar a chamada do TOKEN na Matriz
Receber o c$$HEX1$$f300$$ENDHEX$$digo do Table_ID da Matriz

io_Comum.is_Url='https://api-mng.interplayers.com.br/varejo40/transaction/anula'	
If Not io_Comum.of_post( ls_json_Envio, "", ref as_Json_Retorno, ref as_Erro ) Then Return False
*/

//This.is_token	 	= "Fm_OXwlSm1S4nXZabATLgadtpTenPbfObpFpb6LSRPZBYFpYfmOngW3GtGKJzLICGNSPst9eq6eT9jKKxlVCGC3RHzsWScvAvZmDtBNSptNbe92oeson741HnTA2R5rJPierjpdD1Vr3FMolj-5zTSzzLn4yZ6NU19BIuNs5NPkKhj6cmFPTtMaL1lc9Er9rAa2vxM2d68UgAGanGpi62VCl-JQaV9ZchRJZ4UYq6hXR_gN46RtoXWKk4Umy0uVsr2JuerkwAoexujVkIGBedA"
//This.is_table_id		= "35303732-3232-3530-3037-393933333134"
//
//Return True



/*******************************	WebService JAVA
String		ls_Status_Text
String ls_Ret
long   ll_Status_Code

String ls_Body
Blob lb_Args
String ls_Retorno_Api

OleObject	lo_Http,&
				lo_Send

Try
	
	IF Not IsValid(iole_SrvHTTP) THEN
		
		iole_SrvHTTP = CREATE oleobject
		iole_SrvHTTP.ConnectToNewObject("MSXML2.XMLHTTP.6.0")
		iole_Send = CREATE oleobject
		iole_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")
		
	End If
	
	iole_SrvHTTP.open ('GET', 'http://172.18.15.175:8080/rest/cliente/v1.0/get-by-cpfcnpj?nrCpfCnpj=4490526997', false) 
	iole_SrvHTTP.SetRequestHeader("cdFilial", "2")
	iole_SrvHTTP.SetRequestHeader("token", "c729165f-397b-4062-84d0-841e496d8a09")
		
	IF IsValid(iole_SrvHTTP) THEN
		
		TRY

			iole_SrvHTTP.Send(iole_Send)
			
		CATCH (RuntimeError e) 
			as_Erro = "Ocorreu erro ao enviar o arquivo para o Web Service. Erro: " + e.getMessage()
			Return false
		END TRY 
		
		ll_status_code = iole_SrvHTTP.readyState 
		IF ll_status_code <> 4 THEN
			iole_SrvHTTP.DisconnectObject() 
			Destroy iole_SrvHTTP 
			
			Return false
			
		End If
		
		//Get response 
		ls_status_text = iole_SrvHTTP.StatusText 
		ll_status_code = iole_SrvHTTP.Status 
		
		ls_Retorno_Api = String( Trim(iole_SrvHTTP.ResponseText) )	
		
		uo_ge073_json lo_Json
		lo_Json = Create uo_ge073_json
		
		This.is_token 		= lo_json.of_busca_conteudo_campo_vtex(ls_Retorno_Api, 'accessKey')
		This.is_Table_ID	= lo_json.of_busca_conteudo_campo_vtex(ls_Retorno_Api, 'idTables')
	End If

Catch (RuntimeError rte)
	as_Erro = "Ocorreu erro ao enviar o arquivo para o Web Service. Erro: " + rte.getMessage()
	Return False
Finally
	If IsValid(lo_Json) Then Destroy lo_Json
End Try

Return True
*/



end function

public function boolean of_post (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log);return of_comunicacao_api('POST', ps_json, ref ps_retorno, ref ps_log)
end function

public function boolean of_envia_email (string as_mensagem);String	ls_Msg
String ls_filial

ls_Msg =	"Aten$$HEX2$$e700e300$$ENDHEX$$o,<br><br>" +&
			"Descri$$HEX2$$e700e300$$ENDHEX$$o: "+as_mensagem+"<br>"	

If ib_Grava_Log_Json Then
	gvo_Aplicacao.of_grava_log( "INTEGRA$$HEX2$$c700c300$$ENDHEX$$O PORTAL DROGARIA - MSG Email: " + ls_Msg )
End If

If Not IsNull(gvo_Parametro.Cd_Filial) Then 
	ls_Filial = String( gvo_Parametro.Cd_Filial )
Else
	ls_Filial = ''
End If

gf_ge202_envia_email_log (63, "INTEGRA$$HEX2$$c700c300$$ENDHEX$$O PORTAL DROGARIA - " + ls_Filial , ls_Msg, True, False)

Return True
end function

public function boolean of_setoleobject ();String ls_OleObject

Integer li_Ret

ls_OleObject = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI , "Webservice", "OleTipoServer", "")
If ls_OleObject = ""  Then
	//Se n$$HEX1$$e300$$ENDHEX$$o foi definido o Objeto de conex$$HEX1$$e300$$ENDHEX$$o com o WebService seta o padr$$HEX1$$e300$$ENDHEX$$o MSXML2.XMLHTTP.6.0
	If gvo_Aplicacao.ivo_seguranca.cd_sistema = "RL" Or gvo_Aplicacao.ivo_seguranca.cd_sistema = "CL" Then
		
		li_Ret = SetProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Webservice", "OleTipoServer", "MSXML2.XMLHTTP.6.0")
		If li_Ret < 0 Then
			gvo_Aplicacao.of_grava_log( "GE570_Portal Drogaria: Erro ao setar o objeto OleTipo no .ini" )
		End If
	End If
	
	//Seta o Ole default
	ls_OleObject = "MSXML2.XMLHTTP.6.0"
End If
//
This.is_OleServer = ls_OleObject


//Set OleObject m$$HEX1$$e900$$ENDHEX$$todo GET
ls_OleObject = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI , "Webservice", "OleTipoSend", "")
If ls_OleObject = ""  Then
	//Se n$$HEX1$$e300$$ENDHEX$$o foi definido o Objeto de conex$$HEX1$$e300$$ENDHEX$$o com o WebService seta o padr$$HEX1$$e300$$ENDHEX$$o Msxml2.DOMDocument.6.0
	If gvo_Aplicacao.ivo_seguranca.cd_sistema = "RL" Or gvo_Aplicacao.ivo_seguranca.cd_sistema = "CL" Then
	
		li_Ret = SetProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Webservice", "OleTipoSend", "Msxml2.DOMDocument.6.0")
		If li_Ret < 0 Then
			gvo_Aplicacao.of_grava_log( "GE570_Portal Drogaria: Erro ao setar o objeto OleTipoSend no .ini" )
		End If
	End If
	
	//Seta o OleSend default
	ls_OleObject = "Msxml2.DOMDocument.6.0"
End If
//
This.is_OleSend = ls_OleObject

Return True
end function

public function boolean of_verifica_url_integracao (string as_parametro, ref string as_erro);String ls_url

select vl_parametro  
Into :ls_url
from parametro_interplayer
where cd_parametro = :as_parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1 
		as_erro = "Erro ao localizar a URL do parametro " + as_parametro + " - " + SqlCa.sqlerrtext
		Return False
	Case 100
		as_erro = "Erro ao localizar a URL do parametro " + as_parametro
		Return False		
	Case 0
		This.is_URL = ls_url
End Choose

Return True

end function

public function boolean of_get (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log);return of_comunicacao_api('GET', ps_Json, ref ps_retorno, ref ps_log)
end function

public function boolean of_verifica_parametro (string as_parametro, ref string as_valor_parametro, ref string as_erro);String ls_Aux

as_valor_parametro = ""

select vl_parametro  
Into :ls_Aux
from parametro_interplayer
where cd_parametro = :as_parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1 
		as_erro = "Erro ao localizar o parametro " + as_parametro + " - " + SqlCa.sqlerrtext
		Return False
	Case 100
		as_erro = "Erro ao localizar o parametro " + as_parametro
		Return False		
	Case 0
		as_valor_parametro = ls_Aux
End Choose

Return True

end function

public function boolean of_produto_pbm_portal_drogaria (long pl_produto, ref boolean ab_produto_portal, ref boolean ab_informa_cartao, ref boolean ab_informa_cpf);Integer li_Contador_Prd, li_Contador_Cartao, li_Contador_Cpf

Long ll_PBM

String ls_utiliza_Cartao
String ls_utiliza_CPF

ll_PBM = 175

ab_Produto_Portal 	= False
ab_Informa_Cartao 	= False

Select id_utiliza_Cartao_Consumidor, id_utiliza_cpf
 into :ls_utiliza_Cartao, :ls_utiliza_CPF
 from pbm_produto 
 where cd_pbm 	= :ll_PBM
 and cd_produto 	= :pl_produto
Using sqlCa;
 
 Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Fun$$HEX2$$e700e300$$ENDHEX$$o: of_produto_pbm_portal_drogaria() - Erro ao localizar o produto " +String(pl_Produto) + " no PBM do Portal Drogaria")		
		Return False	
		
	Case 100
		li_Contador_Prd		= 0
		li_Contador_Cartao	= 0
		li_Contador_Cpf		= 0
	Case 0
		li_Contador_Prd++ //Produto Portal Drogaria
		
		If ls_utiliza_Cartao = 'M' Then
			li_Contador_Cartao++ //Produto Necessita do Cartao da Industria
		End If
		
		If ls_utiliza_CPF = 'M' Then
			li_Contador_Cpf++ //Produto Necessita do Cartao da Industria
		End If
End Choose

ab_Produto_Portal		= ( li_Contador_Prd 		> 0 ) 
ab_informa_cartao 	= ( li_Contador_Cartao 	> 0 )
ab_informa_CPF	 	= ( li_Contador_Cpf 		> 0 )

Return True






end function

on uo_ge570_portal_drogaria_comum.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge570_portal_drogaria_comum.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;String ls_URL_TOKEN_API, ls_TOKEN_API, ls_Erro
String ls_parametro

Long ll_Filial_Parametro
Long ll_Filial_Matriz

//Verifica qual OleObject o pdv dever$$HEX1$$e100$$ENDHEX$$ utilizar
This.of_setoleobject( )

//URL Token Central
If Not This.of_verifica_Parametro('URL_APICENTRAL', Ref ls_URL_TOKEN_API, Ref ls_Erro) Then
 	Return -1
End If

If Not This.of_verifica_Parametro('TOKEN_APICENTRAL', Ref ls_TOKEN_API, Ref ls_Erro) Then
 	Return -1
End If

If Not This.of_verifica_parametro( 'CLIENT_ID', Ref is_Cliente_ID,  Ref ls_Erro ) Then
 	Return -1
End If

gf_Filiais_Parametro( ref ll_Filial_Parametro, ref ll_Filial_Matriz )

If ll_Filial_Parametro <> ll_Filial_Matriz Then
	uo_parametro_filial lo_parametro
	lo_Parametro = Create uo_parametro_filial
	lo_Parametro.of_localiza_parametro( "ID_GRAVA_LOG_JSON_PORTAL_DROGARIA", Ref ib_Grava_Log_Json )
	Destroy lo_Parametro
Else
	select vl_parametro
	into :ls_parametro
	from parametro_geral
	where cd_parametro = 'ID_GRAVA_LOG_JSON_PORTAL_DROGARIA'
	using SqlCa;	
	
	ib_Grava_Log_Json = (ls_parametro='S')
End If

This.is_url_APICentral 	= ls_URL_TOKEN_API
This.is_token_apicentral 	= ls_TOKEN_API

io_Json_Token = Create uo_ge073_json
end event

event destructor;If IsValid(io_Json_Token) Then Destroy io_Json_Token
end event

