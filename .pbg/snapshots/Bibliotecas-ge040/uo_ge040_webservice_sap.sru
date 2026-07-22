HA$PBExportHeader$uo_ge040_webservice_sap.sru
forward
global type uo_ge040_webservice_sap from nonvisualobject
end type
end forward

global type uo_ge040_webservice_sap from nonvisualobject
end type
global uo_ge040_webservice_sap uo_ge040_webservice_sap

forward prototypes
public function boolean of_envia_webservice (string ps_url, string ps_xml_envio, ref string ps_xml_retorno, ref string ps_log)
end prototypes

public function boolean of_envia_webservice (string ps_url, string ps_xml_envio, ref string ps_xml_retorno, ref string ps_log);String		ls_Status_Text

long   ll_Status_Code, ll_retorno

OleObject lo_Xml_Http

String	ls_Usuario,&
		ls_Senha

Try
	Try
		
		ls_Usuario = 'PO_INTEGRACAO';
		ls_Senha = 'P0_INTEGRACAO$';
		
		lo_Xml_Http = CREATE oleobject		
		lo_Xml_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")

		lo_Xml_Http.open ("POST", ps_URL, False, ls_usuario, ls_Senha)
		
		lo_Xml_Http.SetTimeOuts(5000,5000,30000,120000)
		lo_Xml_Http.SetAutomationTimeout(120000)

		lo_Xml_Http.setRequestHeader("Content-Type", "text/xml") 

		lo_Xml_Http.send(ps_Xml_Envio)	

		//Pega a resposta do web service
		ls_Status_Text = lo_Xml_Http.StatusText
		ll_Status_Code = lo_Xml_Http.Status		
	
		If ll_Status_Code >= 300 Or ll_Status_Code = 0 Then
			ps_log = "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
			Return False
		Else
			//Pega o retorno do web service
			ps_Xml_Retorno = String(lo_Xml_Http.ResponseText)
		End If
	Catch (RuntimeError lo_rte2)
		ps_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_Envia_WebService', objeto 'uo_ge470_sap'. Erro: "+lo_rte2.GetMessage()
		Return False
	Finally
		//Disconecta
		lo_Xml_Http.DisconnectObject()
		
		GarbageCollect()
		
		Destroy(lo_Xml_Http)
	End Try

Catch (RuntimeError lo_rte)
	ps_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_Envia_WebService', objeto 'uo_ge470_sap'. Erro: "+lo_rte.GetMessage()
	Return False
End Try

Return True
end function

on uo_ge040_webservice_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge040_webservice_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

