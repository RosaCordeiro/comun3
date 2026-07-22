HA$PBExportHeader$uo_ge472_webservice.sru
forward
global type uo_ge472_webservice from nonvisualobject
end type
end forward

global type uo_ge472_webservice from nonvisualobject
end type
global uo_ge472_webservice uo_ge472_webservice

type variables
Protected:
String Ambiente
String Grava_XML = "E" // S=SIM, N=N$$HEX1$$c300$$ENDHEX$$O, E=SOMENTE EM ERROS
String	Usuario
String	Path_Arquivos

Private:
String	Senha
String OleWSType = ""

uo_parametro_geral	ivo_parametro
dc_uo_encript			ivo_Encript
end variables

forward prototypes
private function boolean of_carrega_parametros ()
private function boolean of_salva_arquivo (string ps_conteudo, string ps_arquivo, ref string ps_erro)
public function boolean of_inicializa (string as_ambiente, string as_path_arquivos)
public function boolean of_set_grava_xml (string ps_grava_xml)
private function boolean of_set_path_arquivos (string ps_path)
public function boolean of_envia_webservice (string ps_url, long pl_lote, string ps_xml_envio, ref string ps_xml_retorno, ref string ps_erro)
public function string of_get_nome_arquivo (long pl_lote, string ps_tipo)
end prototypes

private function boolean of_carrega_parametros ();String lvs_Valor

If Not ivo_parametro.of_Localiza_Parametro("NM_USUARIO_PO", ref lvs_Valor) Then Return False
Usuario = lvs_Valor

If Not ivo_parametro.of_Localiza_Parametro("DE_SENHA_USUARIO_PO", ref lvs_Valor) Then Return False
Senha = ivo_Encript.Of_Decripta( lvs_Valor, "CAR", True)

If IsNull(Path_Arquivos) or (Trim(Path_Arquivos)="") Then	Path_Arquivos = gvo_aplicacao.ivs_path_arquivos


OleWSType	= ProfileString(gvo_aplicacao.ivs_arquivo_ini,"WS", "OleTipo", "Msxml2.ServerXMLHTTP.6.0")

Return True
end function

private function boolean of_salva_arquivo (string ps_conteudo, string ps_arquivo, ref string ps_erro);Long lvl_file

Try
	If IsNull(ps_arquivo) or (Trim(ps_arquivo)="") Then 
		ps_erro = "Imposs$$HEX1$$ed00$$ENDHEX$$vel gravar arquivo nome do arquivo nulo ou vazio"
		Return False
	End If
	
	// open the file for write
	lvl_file = FileOpen( ps_arquivo, TextMode!, Write!, LockReadWrite!, Replace! )
	
	//$$HEX1$$c900$$ENDHEX$$ um XML de interface
	If Pos(lower(ps_conteudo), "<soap") > 0 Then
		If Pos(ps_conteudo, "<?xml") <= 0 Then ps_conteudo = '<?xml version="1.0" encoding="ISO-8859-1"?>'+ps_conteudo
	End If
	
	// write to the file
	FileWriteEx( lvl_file, ps_conteudo )
	
	// close the file
	FileClose( lvl_file )

Catch (RuntimeError lvo_rte)
	ps_erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_rte.RoutineName+"().~r"+lvo_rte.GetMessage()
	gvo_aplicacao.of_grava_log(":~r"+ps_erro)
	Return False

Finally
	//
End Try

Return True
end function

public function boolean of_inicializa (string as_ambiente, string as_path_arquivos);Ambiente 		= as_ambiente

If Not This.of_Set_Path_Arquivos(as_path_arquivos) Then Return False
If Not This.of_Carrega_Parametros() Then Return False

Return True
end function

public function boolean of_set_grava_xml (string ps_grava_xml);Grava_XML = ps_grava_xml

Return True
end function

private function boolean of_set_path_arquivos (string ps_path);If IsNull(ps_path) or (ps_path="") Then Return False

If Not DirectoryExists(ps_path) Then CreateDirectory( ps_path )

If Not DirectoryExists(ps_path) Then Return False

Path_Arquivos = ps_path
end function

public function boolean of_envia_webservice (string ps_url, long pl_lote, string ps_xml_envio, ref string ps_xml_retorno, ref string ps_erro);String lvs_Status_Text
String lvs_Arquivo
String lvs_Erro
String lvs_Erro_Source
String lvs_Erro_Descricao

Long   lvl_Status_Code

Integer lvi_Status

uo_ge472_oleobject lvo_Xml_Http

Try
	ps_erro = ""
	ps_xml_retorno = ""
	
	If ps_URL = "" or IsNull(ps_URL) Then
		ps_erro = "URL n$$HEX1$$e300$$ENDHEX$$o definida para o ambiente "+Ambiente+" na tabela parametro_sap."
		Return False
	End If
	
	//Create OleObject
	lvo_Xml_Http = CREATE uo_ge472_oleobject		
	//Cria o Tipo de OleObject
	lvi_Status = lvo_Xml_Http.ConnectToNewObject( OleWSType )
	//Trata erro cria$$HEX2$$e700e300$$ENDHEX$$o
	Choose Case lvi_Status
		Case -1  
			ps_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+".of_envia_webservice():~rErro na rotina lvo_Xml_Http.ConnectToNewObject(): Invalid Call - the argument is the Object property of a control."
		Case -2 
			ps_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+".of_envia_webservice():~rErro na rotina lvo_Xml_Http.ConnectToNewObject(): IClass name not found."
		Case -3  
			ps_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+".of_envia_webservice():~rErro na rotina lvo_Xml_Http.ConnectToNewObject(): Object could not be created."
		Case -4  
			ps_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+".of_envia_webservice():~rErro na rotina lvo_Xml_Http.ConnectToNewObject(): Could not connect to object."
		Case -9  
			ps_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+".of_envia_webservice():~rErro na rotina lvo_Xml_Http.ConnectToNewObject(): Other error."
		Case -15  
			ps_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+".of_envia_webservice():~rErro na rotina lvo_Xml_Http.ConnectToNewObject(): COM+ is not loaded on this computer."
		Case -16  
			ps_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+".of_envia_webservice():~rErro na rotina lvo_Xml_Http.ConnectToNewObject(): Invalid Call: this function not applicable."
	End Choose
	//Verifica Erro
	If Not (lvi_Status = 0) Then Return False
	
	//Abre a conex$$HEX1$$e300$$ENDHEX$$o com o WebService
	lvo_Xml_Http.Open("POST", ps_URL, False, Usuario, Senha)
	
	//Seta Timeouts no OleObject
	lvo_Xml_Http.SetTimeOuts(20000,20000,20000,20000)
	lvo_Xml_Http.SetAutomationTimeout(30000)
	//Seta tipo de arquivo enviado
	lvo_Xml_Http.SetRequestHeader("Content-Type", "text/xml") 
	//Envia requisi$$HEX2$$e700e300$$ENDHEX$$o
	lvo_Xml_Http.Of_Limpa_Log( )
	lvo_Xml_Http.Send(ps_Xml_Envio)	
	
	//Captura log external exception OleObject
	lvo_Xml_Http.Of_Get_Log(ref lvs_Erro_Source, ref lvs_Erro_Descricao)
	If Trim(lvs_Erro_Descricao)<>"" Then
		ps_erro = "External Exception no OleObject: Source: "+lvs_Erro_Source+"~rDescription: "+lvs_Erro_Descricao
		Return False
	End If

	//Pega a resposta do web service
	lvs_Status_Text = lvo_Xml_Http.StatusText
	lvl_Status_Code = lvo_Xml_Http.Status		
	//Pega o retorno do web service
	ps_Xml_Retorno = String(lvo_Xml_Http.ResponseText)
	//Adiciona o encoding caso n$$HEX1$$e300$$ENDHEX$$o exista, para permitir visualizar no browser XMLs com caracter especial
	If Pos(ps_Xml_Retorno, "<?xml") <= 0 Then ps_Xml_Retorno = '<?xml version="1.0" encoding="ISO-8859-1"?>'+ps_Xml_Retorno

	If lvl_Status_Code >= 300 Or lvl_Status_Code = 0 Then
		ps_Erro = "Erro no retorno do Web Service. ~r"+ &
					 " ~rC$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(lvl_Status_Code) + &
					 " ~rDescri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + lvs_Status_Text
		Return False
	End If

Catch (RuntimeError lvo_Error)
	ps_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Error.RoutineName+"(): ~r~nErro: "+lvo_Error.GetMessage()
	
	//Captura log external exception OleObject
	If IsValid(lvo_Xml_Http) Then
		lvo_Xml_Http.Of_Get_Log(ref lvs_Erro_Source, ref lvs_Erro_Descricao)
		If Trim(lvs_Erro_Descricao)<>"" Then
			ps_erro += "~r~nSource: "+lvs_Erro_Source+" ~r~nDescription: "+lvs_Erro_Descricao
		End If
	End If
		
	Return False

Finally
	//Desconecta
	if IsValid(lvo_Xml_Http) Then lvo_Xml_Http.DisconnectObject()
	
	If (Grava_XML = "S") or (Grava_XML = "E" and Not(IsNull(ps_Erro))  and (Trim(ps_Erro)<>"")) Then
		lvs_Arquivo = This.of_Get_Nome_Arquivo(pl_lote, "ENV")
		If Not This.Of_Salva_Arquivo( ps_xml_envio, lvs_Arquivo, lvs_Erro) Then ps_erro += IIF(ps_erro<>"", "~r", "")
		
		lvs_Arquivo = This.of_Get_Nome_Arquivo(pl_lote, "RET")
		If Not This.Of_Salva_Arquivo( ps_Xml_Retorno, lvs_Arquivo, lvs_Erro) Then ps_erro += IIF(ps_erro<>"", "~r", "")
	End If
	
	GarbageCollect()
	
	Destroy(lvo_Xml_Http)
End Try


Return True
end function

public function string of_get_nome_arquivo (long pl_lote, string ps_tipo);String lvs_Arquivo

If IsNull(ps_tipo) Then ps_tipo = ""

lvs_Arquivo = Path_Arquivos+"\"+Ambiente
If Not DirectoryExists(lvs_Arquivo) Then CreateDirectory(lvs_Arquivo)

lvs_Arquivo += "\"
If Not IsNull(pl_lote) and (pl_lote > 0) Then lvs_Arquivo += "Lote_"+String(pl_lote, "000000000")+"_"
lvs_Arquivo += String(Today(), "YYYYMMDD_HHMMSS")+"_"+ps_tipo+".XML"

Return lvs_Arquivo
end function

on uo_ge472_webservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge472_webservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_parametro	= Create uo_parametro_geral
ivo_Encript		= Create dc_uo_encript		

ivo_parametro.ib_mostra_mensagem = False
end event

event destructor;Destroy( ivo_parametro )
Destroy( ivo_Encript )
end event

