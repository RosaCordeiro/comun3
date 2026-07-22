HA$PBExportHeader$uo_ge064_webservice_epharma.sru
forward
global type uo_ge064_webservice_epharma from nonvisualobject
end type
end forward

global type uo_ge064_webservice_epharma from nonvisualobject
end type
global uo_ge064_webservice_epharma uo_ge064_webservice_epharma

type variables
String is_Http_WebService

soapconnection ivo_SoapConnection

ge064_wsconcentradorsoap ipr_epharma

String ivs_Arquivo_Xml
String ivs_Enter = ''
String ivs_Tab = ""

end variables

forward prototypes
public function boolean of_autorizacao ()
public function boolean of_inicializacao (string as_cnpj, string as_nsu, string as_terminal, string as_id_loja, ref string as_xml)
public function boolean of_envia_arquivo (string as_xml_envio, ref string as_xml_retorno, ref string as_erro_log)
public function boolean of_proxy_create ()
public subroutine of_proxy_destroy ()
public function boolean of_enviar (string ps_xml, ref string ps_retorno)
public function string of_abre_tag (string ps_tag, long pl_identacao)
public function string of_identa (string ps_registro, long pl_tabulacao)
public function string of_fecha_tag (string ps_tag, long pl_identacao)
public function string of_elemento (string ps_tag, string ps_string, long pl_identacao)
end prototypes

public function boolean of_autorizacao ();Return True
end function

public function boolean of_inicializacao (string as_cnpj, string as_nsu, string as_terminal, string as_id_loja, ref string as_xml);String ls_XML
String ls_data

//Desen
as_CNPJ = '84683481003273'
as_id_Loja = '493'
as_terminal = '93946'
//ls_data		= 'MMDDhhmmss'
ls_data		= '0530162020'

as_xml = '<![CDATA[<?xml version="1.0" encoding="iso-8859-1"?><Epharma xmlns="http://xsd.epharma.com.br/autorizador"><Transacao>0820</Transacao><CNPJLojaTerminal>84683481003273</CNPJLojaTerminal><Data>0530165021</Data><NSUPos>000017</NSUPos><CodigoTerminal>93946</CodigoTerminal><CodigoFarmacia>493</CodigoFarmacia></Epharma>]]>'

//as_xml = '<?xml version="1.0" encoding="iso-8859-1"?>' 					+ &
//			'<Epharma xmlns="http://xsd.epharma.com.br/autorizador">' + &
//			"<Transacao>0820</Transacao>"  									+ &
//			"<CNPJLojaTerminal>" + as_cnpj + "</CNPJLojaTerminal>"  	+ &
//			"<Data>" + ls_data + "</Data>"  										+ &
//			"<NSUPos>" + as_nsu + "</NSUPos>"  								+ &
//			"<CodigoTerminal>" + as_terminal + "</CodigoTerminal>"  	+ &
//			"<CodigoFarmacia>" + as_id_loja + "</CodigoFarmacia>"  	+ &
//			"</Epharma>"

Return True

end function

public function boolean of_envia_arquivo (string as_xml_envio, ref string as_xml_retorno, ref string as_erro_log);String		ls_status_text

long   ll_status_code

OleObject lo_xmlhttp

Try

	Try
		lo_xmlhttp = CREATE oleobject
		lo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.4.0")
		
		lo_xmlhttp.open ("POST", "http://wshomolo.pbms.com.br:8010/WsConcentrador.asmx?WSDL", False)
		
		//lo_xmlhttp.setRequestHeader("Content-Type", "text/xml") 
		lo_xmlhttp.setRequestHeader("nmLogin", "84683481003273" ) 
		lo_xmlhttp.setRequestHeader("senha", "12345") 
		lo_xmlhttp.setRequestHeader("nmServico", "WsAutorizador") 
		lo_xmlhttp.setRequestHeader( "versao", "2.0") 	
//		
		tHIS.of_inicializacao('','','','' , Ref as_Xml_Envio )
		
		//as_Xml_Envio = '<b></a>'
		
		lo_xmlhttp.send(as_Xml_Envio)
		
		//Pega a resposta do web service
		ls_status_text = lo_xmlhttp.StatusText
		ll_status_code = lo_xmlhttp.Status
		
	
		if ll_status_code >= 300 then
			as_Erro_Log = "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro:" +String(ll_status_code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro:" + ls_status_text
		else
		//Pega o retorno do web service
			as_Xml_Retorno = lo_xmlhttp.ResponseText
		end if
	
		//Disconecta
		lo_xmlhttp.DisconnectObject()
	Finally
		Destroy(lo_xmlhttp)
	End Try

Catch (RuntimeError rte)
	as_Erro_Log = "Ocorreu erro ao enviar o arquivo para o Web Service. Erro: " + rte.getMessage()
	Return False
End Try

Return True
end function

public function boolean of_proxy_create ();long ll_retorno //Vari$$HEX1$$e100$$ENDHEX$$vel de retorno do m$$HEX1$$e900$$ENDHEX$$todo createinstance 

ivo_SoapConnection = create soapconnection

ipr_epharma	= create ge064_wsconcentradorsoap
ll_retorno = ivo_SoapConnection.CreateInstance( ipr_epharma, 'ge064_wsconcentradorsoap' )

If ll_retorno <> 0 Then 
	Messagebox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel criar a inst$$HEX1$$e200$$ENDHEX$$ncia do objeto de conex$$HEX1$$e300$$ENDHEX$$o com a e-Pharma. Erro:' + String( ll_Retorno ) + '~r' + &
								   'Tente novamente mais tarde, persistindo o problema, abra um chamado no Service Desk.', StopSign!)
	Return False
End If

Return True
end function

public subroutine of_proxy_destroy ();If IsValid( ivo_SoapConnection ) Then Destroy ivo_SoapConnection
end subroutine

public function boolean of_enviar (string ps_xml, ref string ps_retorno);Boolean lb_Sucesso = True

Integer li_FileNum
Integer li_Bytes

String ls_Retorno
String ls_XML_envio
String ls_Arquivo

ls_Arquivo	= 'C:\Util\EPharma\WebService\envio.xml'
If Not FileExists( ls_Arquivo ) Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Arquivo ' + ls_Arquivo + ' n$$HEX1$$e300$$ENDHEX$$o localizado.', StopSign! )
	Return False
End If

li_FileNum	= FileOpen( ls_Arquivo, StreamMode! )

If li_FileNum = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao abrir o arquivo para leitura ' + ls_Arquivo + '.', StopSign! )
	Return False
End If

li_Bytes	= FileRead( li_FileNum, ls_XML_envio )

FileClose( li_FileNum )

If li_Bytes = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao ler o conte$$HEX1$$fa00$$ENDHEX$$do do arquivo ' + ls_Arquivo + '.', StopSign! )
	Return False
End If

If Not This.of_Proxy_Create() Then
	Return False
End If

Try
	ps_Retorno = ipr_epharma.ws_execute(ls_xml_envio)	
	
Catch ( SoapException e ) // Soap
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na conex$$HEX1$$e300$$ENDHEX$$o com o Sefaz~r~r' + e.getMessage(), StopSign! )		
		
Finally // Soap
	This.of_Proxy_Destroy()
	Return lb_Sucesso
End Try
end function

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

public function string of_fecha_tag (string ps_tag, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("</" + ps_Tag + ">", pl_identacao) + ivs_Enter

Return lvs_Retorno
end function

public function string of_elemento (string ps_tag, string ps_string, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + ">" + ps_String + "</" + ps_Tag + ">", pl_identacao) + ivs_Enter

Return lvs_Retorno
end function

on uo_ge064_webservice_epharma.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge064_webservice_epharma.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_Http_WebService	= "http://wshomolo.pbms.com.br:8010/WsConcentrador.asmx?WSDL"
end event

