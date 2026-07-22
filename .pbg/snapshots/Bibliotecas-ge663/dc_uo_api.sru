HA$PBExportHeader$dc_uo_api.sru
forward
global type dc_uo_api from nonvisualobject
end type
end forward

global type dc_uo_api from nonvisualobject
end type
global dc_uo_api dc_uo_api

type variables
String	is_de_url_api_sftp

string	ivs_path,&
         ivs_endereco,&
         ivs_usuario,&
         ivs_senha,&
         ivs_diretorio_fal,&
         ivs_diretorio_blq,&
         ivs_diretorio_nfc,&
         ivs_diretorio_ped,&
         ivs_diretorio_pre,&
         ivs_versao_layout,&
         ivs_arquivo_pedido_stacruz,&
         ivs_arquivo_compactado,&
         ivs_erro,&
			ivs_nome_arquivo,&
			ivs_tipo_arquivo,&
			ivs_porta_ftp, &
			is_id_forma_comunicacao_arquivo	= 'FTP',&
			is_format = 'ZIP'
		

PRIVATE Long	il_bytes_to_read = 601440
end variables

forward prototypes
public function boolean of_busca_arquivo (string ps_dir_arquivo, string ps_nm_arquivo, string ps_servidor, string ps_usuario, string ps_senha, integer pl_porta, ref string ps_log)
public function boolean of_move_arquivo (string ps_dir_destino, string ps_nm_arquivo, string ps_servidor, string ps_usuario, string ps_senha, integer pl_porta, ref string ps_log)
public function boolean of_verifica_arquivo (string ps_nm_arquivo, string ps_servidor, string ps_usuario, string ps_senha, integer pl_porta, ref string ps_log)
public subroutine _documentacao ()
public function boolean of_exclui_arquivo (string ps_nm_arquivo, string ps_servidor, string ps_usuario, string ps_senha, integer pl_porta, ref string ps_log)
public function boolean of_enviar_arquivo (string ps_dir_arquivo, string ps_nm_arquivo, string ps_servidor, string ps_usuario, string ps_senha, long al_porta, ref string ps_log)
public function boolean of_get_file (string ps_path_local, string ps_path_remoto, string ps_servidor, string ps_usuario, string ps_senha, integer pl_porta, ref string ps_log)
public function boolean of_deleta_arquivo_api (string ps_servidor, string ps_usuario, string ps_senha, long al_porta, string ps_dir, string ps_filename, ref string ps_log)
public function boolean of_listar_arquivos_api (string ps_servidor, string ps_usuario, string ps_senha, long al_porta, string ps_dir, string ps_extensao, ref string ps_retorno_api, ref string ps_log)
public function boolean of_buscar_arquivo_api (string ps_servidor, string ps_usuario, string ps_senha, long al_porta, string ps_dir, string ps_filename, string ps_local_download, ref string ps_log)
public subroutine of_set_bytes_to_read (long al_bytes_to_read)
public function boolean of_enviar_arquivo_api (string ps_dir_file, string ps_servidor, string ps_usuario, string ps_senha, long al_porta, string ps_dir, string ps_filename, ref string ps_log)
public subroutine of_set_file_extension (string as_file_to_read)
end prototypes

public function boolean of_busca_arquivo (string ps_dir_arquivo, string ps_nm_arquivo, string ps_servidor, string ps_usuario, string ps_senha, integer pl_porta, ref string ps_log);String ls_log,ls_usuario,ls_senha, ls_server, ls_dir_local, ls_arquivo
integer li_err,li_err2, li_err3
oleobject lo_SessionOptions, lo_Session

TRY
    lo_SessionOptions = create oleobject
    li_err = lo_SessionOptions.connecttonewobject("WinSCP.SessionOptions")
	
	if li_err <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
    lo_sessionOptions.Protocol = 0
    lo_SessionOptions.HostName = ps_servidor
    lo_SessionOptions.UserName = ps_usuario
    lo_SessionOptions.Password = ps_senha
    lo_SessionOptions.PortNumber = pl_porta
  	lo_SessionOptions.GiveUpSecurityAndAcceptAnySshHostKey = true


    lo_Session = create oleobject
    li_err2 = lo_Session.connecttonewobject("WinSCP.Session")

	//lo_Session.DebugLogPath = 'C:\temp\__log\log.txt'
	
	if li_err2 <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
    if lo_Session.Opened then
   		lo_Session.Abort()
    end if

   lo_Session.Open(lo_SessionOptions)
	
	if Not lo_Session.Opened then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir uma conex$$HEX1$$e300$$ENDHEX$$o com o servidor: ' + ps_servidor
		return false
	end if
	
	li_err3 = integer( lo_Session.getfiles(ps_nm_arquivo, ps_dir_arquivo, false) )
	
	if li_err3 <> 0 Then
		ps_log = 'Falha ao buscar o arquivo do servidor: ' + ps_servidor
		return false
	end if
	
	lo_Session.Close()
	
	
CATCH (OLERuntimeError exRuntime)
    ps_log = exRuntime.getmessage()
END TRY

return true

end function

public function boolean of_move_arquivo (string ps_dir_destino, string ps_nm_arquivo, string ps_servidor, string ps_usuario, string ps_senha, integer pl_porta, ref string ps_log);String ls_log,ls_usuario,ls_senha, ls_server, ls_dir_local, ls_arquivo
integer li_err,li_err2, li_err3
oleobject lo_SessionOptions, lo_Session

TRY
    lo_SessionOptions = create oleobject
    li_err = lo_SessionOptions.connecttonewobject("WinSCP.SessionOptions")
	
	if li_err <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
    lo_sessionOptions.Protocol = 0
    lo_SessionOptions.HostName = ps_servidor
    lo_SessionOptions.UserName = ps_usuario
    lo_SessionOptions.Password = ps_senha
    lo_SessionOptions.PortNumber = pl_porta
  	lo_SessionOptions.GiveUpSecurityAndAcceptAnySshHostKey = true


    lo_Session = create oleobject
    li_err2 = lo_Session.connecttonewobject("WinSCP.Session")
	
	if li_err2 <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
    if lo_Session.Opened then
   		lo_Session.Abort()
    end if

   lo_Session.Open(lo_SessionOptions)
	
	if Not lo_Session.Opened then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir uma conex$$HEX1$$e300$$ENDHEX$$o com o servidor: ' + ps_servidor
		return false
	end if
	
	li_err3 = integer( lo_Session.MoveFile(ps_nm_arquivo, ps_dir_destino) )
	
	if li_err3 <> 0 Then
		ps_log = 'Falha ao buscar o arquivo do servidor: ' + ps_servidor
		return false
	end if
	
	lo_Session.Close()
	
	
CATCH (OLERuntimeError exRuntime)
    ps_log = exRuntime.getmessage()
END TRY

return true

end function

public function boolean of_verifica_arquivo (string ps_nm_arquivo, string ps_servidor, string ps_usuario, string ps_senha, integer pl_porta, ref string ps_log);String ls_log,ls_usuario,ls_senha, ls_server, ls_dir_local, ls_arquivo
integer li_err,li_err2, li_err3
oleobject lo_SessionOptions, lo_Session

TRY
    lo_SessionOptions = create oleobject
    li_err = lo_SessionOptions.connecttonewobject("WinSCP.SessionOptions")
	
	if li_err <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
    lo_sessionOptions.Protocol = 0
    lo_SessionOptions.HostName = ps_servidor
    lo_SessionOptions.UserName = ps_usuario
    lo_SessionOptions.Password = ps_senha
    lo_SessionOptions.PortNumber = pl_porta
  	lo_SessionOptions.GiveUpSecurityAndAcceptAnySshHostKey = true


    lo_Session = create oleobject
    li_err2 = lo_Session.connecttonewobject("WinSCP.Session")
	
	if li_err2 <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
    if lo_Session.Opened then
   		lo_Session.Abort()
    end if

   lo_Session.Open(lo_SessionOptions)
	
	if Not lo_Session.Opened then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir uma conex$$HEX1$$e300$$ENDHEX$$o com o servidor: ' + ps_servidor
		return false
	end if
	
	If Not lo_Session.FileExists(ps_nm_arquivo)  Then	
		ps_log = 'Arquivo n$$HEX1$$e300$$ENDHEX$$o existe no servidor: ' + ps_servidor + ' Arquivo: ' + ps_nm_arquivo
		return false
	end if
	
	lo_Session.Close()
	
	
CATCH (OLERuntimeError exRuntime)
    ps_log = exRuntime.getmessage()
END TRY

return true

end function

public subroutine _documentacao ();/*
  Objetivo:  faz conex$$HEX1$$f500$$ENDHEX$$es com servi$$HEX1$$e700$$ENDHEX$$os SFTP
  Para funcionar precisa da WinSCPnet.dll 
  
  Dll precisar estar registrada no computador que for usar as fun$$HEX2$$e700f500$$ENDHEX$$es.
  
  -	Copiar a Dll para o diret$$HEX1$$f300$$ENDHEX$$rio c:\Windows\System32
 -  Registrar a DLL. Para isso devemos abrir o cmd (como administrador) e digitar a seguinte linha de comando:

%WINDIR%\Microsoft.NET\Framework\v4.0.30319\RegAsm.exe WinSCPnet.dll /codebase /tlb:WinSCPnet32.tlb
%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\RegAsm.exe WinSCPnet.dll /codebase /tlb:WinSCPnet64.tlb

Manual interno completo no S:\Projetos\IQVA

Site oficial da dll com todos os m$$HEX1$$e900$$ENDHEX$$todos  https://winscp.net/eng/docs/library_session#methods

*/


/*
Fun$$HEX2$$e700f500$$ENDHEX$$es que terminam com api s$$HEX1$$e300$$ENDHEX$$o fun$$HEX2$$e700f500$$ENDHEX$$es que dependem do retorno da API para funiconar.
Todos os processos de conex$$HEX1$$e300$$ENDHEX$$o via SFTP
*/
end subroutine

public function boolean of_exclui_arquivo (string ps_nm_arquivo, string ps_servidor, string ps_usuario, string ps_senha, integer pl_porta, ref string ps_log);String ls_log,ls_usuario,ls_senha, ls_server, ls_dir_local, ls_arquivo
integer li_err,li_err2, li_err3
oleobject lo_SessionOptions, lo_Session

TRY
    lo_SessionOptions = create oleobject
    li_err = lo_SessionOptions.connecttonewobject("WinSCP.SessionOptions")
	
	if li_err <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
    lo_sessionOptions.Protocol = 0
    lo_SessionOptions.HostName = ps_servidor
    lo_SessionOptions.UserName = ps_usuario
    lo_SessionOptions.Password = ps_senha
    lo_SessionOptions.PortNumber = pl_porta
  	lo_SessionOptions.GiveUpSecurityAndAcceptAnySshHostKey = true


    lo_Session = create oleobject
    li_err2 = lo_Session.connecttonewobject("WinSCP.Session")
	
	if li_err2 <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
    if lo_Session.Opened then
   		lo_Session.Abort()
    end if

   lo_Session.Open(lo_SessionOptions)
	
	if Not lo_Session.Opened then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir uma conex$$HEX1$$e300$$ENDHEX$$o com o servidor: ' + ps_servidor
		return false
	end if
	
	li_err3 = integer( lo_Session.RemoveFile(ps_nm_arquivo) )
	
	if li_err3 <> 0 Then
		ps_log = 'Falha ao buscar o arquivo do servidor: ' + ps_servidor
		return false
	end if
	
	lo_Session.Close()
	
	
CATCH (OLERuntimeError exRuntime)
    ps_log = exRuntime.getmessage()
END TRY

return true

end function

public function boolean of_enviar_arquivo (string ps_dir_arquivo, string ps_nm_arquivo, string ps_servidor, string ps_usuario, string ps_senha, long al_porta, ref string ps_log);String ls_log,ls_usuario,ls_senha, ls_server, ls_dir_local, ls_arquivo
integer li_err,li_err2, li_err3, li_err1, li_err4 , li_err5
oleobject lo_SessionOptions, lo_Session , lo_TRSessionOptions , lo_TREventArgs, lo_FilePermitions


TRY
    lo_SessionOptions = create oleobject
    li_err = lo_SessionOptions.connecttonewobject("WinSCP.SessionOptions")
	 
    lo_TRSessionOptions = create oleobject
    li_err1 = lo_TRSessionOptions.connecttonewobject("WinSCP.TransferOptions") 
	

    lo_TREventArgs = create oleobject	 
    li_err4 = lo_TREventArgs.connecttonewobject("WinSCP.TransferEventArgs")  
	 
	lo_FilePermitions = create oleobject	 
     li_err4 = lo_FilePermitions.connecttonewobject("WinSCP.FilePermissions")  
	  
	lo_FilePermitions.Text = "rwxrwxrwx"
	lo_TRSessionOptions.FilePermissions =lo_FilePermitions
	

	
	if li_err <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
    lo_sessionOptions.Protocol = 0
    lo_SessionOptions.HostName =ps_servidor
    lo_SessionOptions.UserName =ps_usuario
    lo_SessionOptions.Password = ps_senha
	 lo_SessionOptions.PortNumber = 22

	 
	
//	If al_porta  = 22 Then     
//		lo_SessionOptions.PortNumber = al_porta
//	Else
//		lo_SessionOptions.PortNumber = 8222
//	End If 
	
 //   lo_SessionOptions.GiveUpSecurityAndAcceptAnySshHostKey = True
	lo_SessionOptions.SshHostKeyPolicy.GiveUpSecurityAndAcceptAny = True 
///	lo_SessionOptions.GiveUpSecurityAndAcceptAny = True 

    lo_Session = create oleobject
    li_err2 = lo_Session.connecttonewobject("WinSCP.Session")
	
	if li_err2 <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
    if lo_Session.Opened then
   		lo_Session.Abort()
    end if

   lo_Session.Open(lo_SessionOptions)
	
	if Not lo_Session.Opened then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir uma conex$$HEX1$$e300$$ENDHEX$$o com o servidor: ' + ps_servidor
		return false
	end if
	


	ps_nm_arquivo = "/custom/ORDERS/"
	ps_dir_arquivo  = "C:\OPENTEXT\ORD60409075010034_221110598.TXT"
	
	lo_TREventArgs =    ( lo_Session.PutFileToDirectory(ps_dir_arquivo,ps_nm_arquivo, False,  lo_TRSessionOptions )) 
	//li_err3 = integer( lo_Session.putfiles(ps_dir_arquivo, ps_nm_arquivo, false) )
	
	if li_err3 <> 0 Then
		ps_log = 'Falha ao enviar arquivo para o servidor: ' + ps_servidor
		return false
	end if
	
	lo_Session.Close()
	
	
CATCH (OLERuntimeError exRuntime)
    ps_log = exRuntime.getmessage()
END TRY

return true

end function

public function boolean of_get_file (string ps_path_local, string ps_path_remoto, string ps_servidor, string ps_usuario, string ps_senha, integer pl_porta, ref string ps_log);String ls_log,ls_usuario,ls_senha, ls_server, ls_dir_local, ls_arquivo
integer li_err,li_err2, li_err3, li_err4
Boolean lb_remove
oleobject lo_SessionOptions, lo_Session, lo_TransferOptions

TRY
	lb_Remove = False
	lo_SessionOptions = create oleobject
	li_err = lo_SessionOptions.connecttonewobject("WinSCP.SessionOptions")
	
	if li_err <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
	lo_sessionOptions.Protocol = 0
	lo_SessionOptions.HostName = ps_servidor
	lo_SessionOptions.UserName = ps_usuario
	lo_SessionOptions.Password = ps_senha
	lo_SessionOptions.PortNumber = pl_porta
	lo_SessionOptions.GiveUpSecurityAndAcceptAnySshHostKey = true
	
	lo_Session = create oleobject
	li_err2 = lo_Session.connecttonewobject("WinSCP.Session")
		
	if li_err2 <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
	
	if lo_Session.Opened then
		lo_Session.Abort()
	end if
	
	//lo_Session.DebugLogPath = 'C:\temp\__log\log.txt'
	lo_Session.Open(lo_SessionOptions)
	
	if Not lo_Session.Opened then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir uma conex$$HEX1$$e300$$ENDHEX$$o com o servidor: ' + ps_servidor
		return false
	end if
	
	lo_transferOptions = create oleobject
	li_err3 = lo_transferOptions.connecttonewobject("WinSCP.TransferOptions")
	
	if li_err3 <> 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reconhecer a biblioteca WinSCPnet.dll.'
		return false
	end if
		
	li_err4 = integer( lo_Session.getfiles(ps_path_remoto, ps_path_local, lb_remove, lo_transferOptions) )
	
	if li_err4 <> 0 Then
		ps_log = 'Falha ao buscar o arquivo do servidor: ' + ps_servidor
		return false
	end if
	
	lo_Session.Close()
	Return True
	
CATCH (OLERuntimeError exRuntime)
    ps_log = exRuntime.getmessage()
	 
Finally
	If IsValid(lo_transferOptions) 	Then Destroy lo_transferOptions
	If IsValid(lo_SessionOptions)	Then Destroy lo_SessionOptions
	If IsValid(lo_Session) 				Then Destroy lo_Session
END TRY

end function

public function boolean of_deleta_arquivo_api (string ps_servidor, string ps_usuario, string ps_senha, long al_porta, string ps_dir, string ps_filename, ref string ps_log);Blob 			lblob_data, lblob_file
Integer 		li_FileNum, li_arq, li_ret
Long 			ll_Status_Code
String 		ls_file, ls_boundary, ls_formdata, ls_Status_Text, ls_content_type, ls_guid, ls_MimeType, ls_retorno_api
Boolean		lb_Sucesso = True

OleObject 	lo_Xml_Http


Try
	lo_Xml_Http = CREATE oleobject		
	lo_Xml_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
	
	//Ajuste do timeout do objeto "Msxml2.ServerXMLHTTP.6.0" para 90 segundos (90000 milissegundos)
	lo_Xml_Http.setTimeouts(90000, 90000, 90000, 90000)
	
	lo_Xml_Http.open ("DELETE", is_de_url_api_sftp + '/deletaArquivoRetorno?host='+ps_servidor+'&username='+ps_usuario+'&password='+ps_senha+'&port='+String(al_porta)+'&path='+ps_dir + '&filename=' + ps_filename, False)
	lo_Xml_Http.send()	

	ls_Status_Text = lo_Xml_Http.StatusText
	ll_Status_Code = lo_Xml_Http.Status
	
	If ll_Status_Code >= 300 Or ll_Status_Code = 0 Then
		ps_log	= "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
		lb_Sucesso = 	False
		Return False
	Else
		ls_retorno_api = String(lo_Xml_Http.ResponseText)
	End If
Catch (RuntimeError lo_rte2)
	ps_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_Envia_WebService', objeto 'uo_ge470_sap'. Erro: "+lo_rte2.GetMessage()
	
	lo_Xml_Http.DisconnectObject()
	
	GarbageCollect()
	
	Destroy(lo_Xml_Http)
	
	Return False
Finally
	if IsValid(lo_Xml_Http) then
		lo_Xml_Http.DisconnectObject()	
		
		Destroy(lo_Xml_Http)
	end if
	
	GarbageCollect()
	
	If lb_Sucesso Then
		Return True
	End If
		
End Try
end function

public function boolean of_listar_arquivos_api (string ps_servidor, string ps_usuario, string ps_senha, long al_porta, string ps_dir, string ps_extensao, ref string ps_retorno_api, ref string ps_log);Blob 			lblob_data, lblob_file
Integer 		li_FileNum
Long 			ll_Status_Code
String 		ls_file, ls_boundary, ls_formdata, ls_Status_Text, ls_content_type, ls_guid, ls_MimeType
Boolean		lb_Sucesso = True

OleObject 	lo_Xml_Http


Try
	lo_Xml_Http = CREATE oleobject		
	lo_Xml_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
	
	//Ajuste do timeout do objeto "Msxml2.ServerXMLHTTP.6.0" para 90 segundos (90000 milissegundos)
	lo_Xml_Http.setTimeouts(90000, 90000, 90000, 90000)
	
	lo_Xml_Http.open ("GET", is_de_url_api_sftp + '/listaArquivosRetorno?host='+ps_servidor+'&username='+ps_usuario+'&password='+ps_senha+'&port='+String(al_porta)+'&path='+ps_dir+ '&fileExtension=' + ps_extensao, False)
	lo_Xml_Http.send()	
	ls_Status_Text = lo_Xml_Http.StatusText
	ll_Status_Code = lo_Xml_Http.Status
	
	If ll_Status_Code >= 300 Or ll_Status_Code = 0 Then
		ps_log	= "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
		lb_Sucesso = 	False
		Return False
	Else
		ps_retorno_api = String(lo_Xml_Http.ResponseText)
	End If
Catch (RuntimeError lo_rte2)
	ps_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_Envia_WebService', objeto 'uo_ge470_sap'. Erro: "+lo_rte2.GetMessage()
	
	lo_Xml_Http.DisconnectObject()
	
	GarbageCollect()
	
	Destroy(lo_Xml_Http)
	
	Return False
Finally
	if IsValid(lo_Xml_Http) then
		lo_Xml_Http.DisconnectObject()	
		
		Destroy(lo_Xml_Http)
	end if
	
	GarbageCollect()
	
	If lb_Sucesso Then
		Return True
	End If	
	
End Try
end function

public function boolean of_buscar_arquivo_api (string ps_servidor, string ps_usuario, string ps_senha, long al_porta, string ps_dir, string ps_filename, string ps_local_download, ref string ps_log);Blob 			lblob_file
Integer 		li_FileNum, li_arq
Long 			ll_Status_Code, ll_ret
String 		ls_file, ls_boundary, ls_formdata, ls_Status_Text, ls_content_type, ls_guid, ls_MimeType, ls_retorno_api
Boolean		lb_Sucesso = True
OleObject 	lo_Xml_Http


Try
	lo_Xml_Http = CREATE oleobject		
	lo_Xml_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
	
	//Ajuste do timeout do objeto "Msxml2.ServerXMLHTTP.6.0" para 90 segundos (90000 milissegundos)
	lo_Xml_Http.setTimeouts(90000, 90000, 90000, 90000)
	
	lo_Xml_Http.open ("GET", is_de_url_api_sftp + '/buscaRetorno?host='+ps_servidor+'&username='+ps_usuario+'&password='+ps_senha+'&port='+String(al_porta)+'&path='+ps_dir+ '&filename=' + ps_filename, False)
	lo_Xml_Http.send()	

	ls_Status_Text = lo_Xml_Http.StatusText
	ll_Status_Code = lo_Xml_Http.Status
	
	// Retono da API. 500 - API n$$HEX1$$e300$$ENDHEX$$o conseguiu conectar no SFTP e 201- Conex$$HEX1$$e300$$ENDHEX$$o realizada com sucesso
	If ll_Status_Code >= 300 Or ll_Status_Code = 0 Then
		ps_log	= "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
		lb_Sucesso = 	False
		Return False
	Else
		lblob_file = Blob(lo_Xml_Http.ResponseBody)
		if trim(ps_local_download) <> '' and not IsNull(ps_local_download) then
			If FileExists (ps_local_download) Then
				FileDelete (ps_local_download)
			End If
	
			li_FileNum = FileOpen(ps_local_download, StreamMode!, Write!, LockWrite!, Replace!, EncodingAnsi!)	
			If li_FileNum = -1 Then
				ps_log = "Erro ao abrir o arquivo " + ps_local_download
				Return False
			End If
			
			ll_ret = FileWriteEx(li_FileNum, lblob_file)
		
			If IsNull(ll_ret) or ll_ret <= 0 Then
				ps_log = "Erro ao fazer o download do arquivo " + ps_filename
				FileClose(li_FileNum)
				lb_Sucesso = 	False
				Return False
			End If
			
			FileClose(li_FileNum)
		end if
	End If
Catch (RuntimeError lo_rte2)
	ps_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_Envia_WebService', objeto 'uo_ge470_sap'. Erro: "+lo_rte2.GetMessage()
	
	lo_Xml_Http.DisconnectObject()
	
	GarbageCollect()
	
	Destroy(lo_Xml_Http)
	
	Return False
Finally
	if IsValid(lo_Xml_Http) then
		lo_Xml_Http.DisconnectObject()
		
		Destroy(lo_Xml_Http)
	End if
	
	GarbageCollect()
	
	If lb_Sucesso Then
		Return True
	End If
	
End Try
end function

public subroutine of_set_bytes_to_read (long al_bytes_to_read);il_bytes_to_read = al_bytes_to_read
end subroutine

public function boolean of_enviar_arquivo_api (string ps_dir_file, string ps_servidor, string ps_usuario, string ps_senha, long al_porta, string ps_dir, string ps_filename, ref string ps_log);Blob 			lblob_data, lblob_file, lblob_files[]
Integer 		li_FileNum, li_count
Long 			ll_Status_Code, ll_file, ll_bytes_to_read, ll_bytes_read, ll_for, ll_total_items, ll_linha
String 		ls_file, ls_boundary, ls_formdata, ls_Status_Text, as_Xml_Retorno, ls_content_type, ls_guid, ls_MimeType, ls_filenames[]
Boolean		lb_Sucesso = True

OleObject 	lo_Xml_Http, lole_object, lole_files
ListBox		llb_temp
Window 		lw_temp

Try
	Open(lw_temp)
	lw_temp.openUserObject( llb_temp )

	llb_temp.DirList( ps_dir_file + '*.'+lower(is_format) , 0)

	//Passa pelos arquivos, gerando lista no array
	li_count = llb_temp.TotalItems()

	If li_count > 0 Then	
		For ll_linha = 1 To li_count
			// Pega o nome do arquivo	
			ls_file = llb_temp.Text( ll_linha )
			
			li_FileNum = FileOpen(ls_file, StreamMode!)
		
			if li_FileNum < 1 then
				ps_log	= "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir o arquivo: " + ls_file
				Return False
			end if
			
			ll_file = FileLength(ls_file)
		
			// Definir o tamanho de cada parte (por exemplo, 10KB)
			
			ll_bytes_to_read = il_bytes_to_read
			
			FileReadEx(li_FileNum, lblob_file, ll_bytes_to_read)
			
			lblob_files[ll_linha] = lblob_file
			ls_filenames[ll_linha] = ls_file
			
			ll_bytes_read = ll_bytes_read + ll_bytes_to_read
			
			FileClose(li_FileNum)
		Next
	End If
	
	Destroy lole_object
	Destroy lole_files
	
	// Formatar o GUID
	ls_guid = String(Integer(Rand(65535)), "00000#") + "-" + &
				 String(Integer(Rand(65535)), "0000#") + "-" + &
				 String(Integer(Rand(65535)), "0000#") + "-" + &
				 String(Integer(Rand(65535)), "0000#")
			 
	ls_boundary = "$$$Boundary$$$" 
	
	ls_MimeType = 'application/'+lower(is_format)

	ls_content_type = "multipart/form-data; boundary=" + ls_BOUNDARY

	for ll_for = 1 to UpperBound(lblob_files)
		lo_Xml_Http = CREATE oleobject		
		lo_Xml_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
		
		//Ajuste do timeout do objeto "Msxml2.ServerXMLHTTP.6.0" para 90 segundos (90000 milissegundos)
		lo_Xml_Http.setTimeouts(90000, 90000, 90000, 90000)
		
		//ps_senha = gf_url_encode(ps_senha)
		
		lo_Xml_Http.open ("POST", is_de_url_api_sftp + '/enviaSFTP?host='+ps_servidor+'&username='+ps_usuario+'&password='+ps_senha+'&port='+string(al_porta)+'&path=' + ps_dir, False)
		lo_Xml_Http.setRequestHeader("Content-Type", ls_content_type) 
		
		lblob_data = blob ("--"  + ls_BOUNDARY + "~r~n" + &
                'Content-Disposition: form-data; name="file"; filename="' + ls_filenames[ll_for] + '"' + &
                "~r~nContent-Type: " + ls_mimetype + "~r~n~r~n", EncodingUTF8!) + &
                lblob_files[ll_for] + blob ("~r~n--"  + ls_BOUNDARY + "--~r~n", EncodingUTF8!)

		lo_Xml_Http.send(lblob_data)	
	
		ls_Status_Text = lo_Xml_Http.StatusText
		ll_Status_Code = lo_Xml_Http.Status		
		as_Xml_Retorno = String(lo_Xml_Http.ResponseText)
		
		If ll_Status_Code >= 300 Or ll_Status_Code = 0 Then
			ps_log	= "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
			destroy lo_Xml_Http
			lb_Sucesso = 	False
			Return False
		Else
			as_Xml_Retorno = String(lo_Xml_Http.ResponseText)
		End If
		
		lo_Xml_Http.DisconnectObject()
		
		destroy lo_Xml_Http
	next
Catch (RuntimeError lo_rte2)
	ps_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_Envia_WebService', objeto 'uo_ge470_sap'. Erro: "+lo_rte2.GetMessage()
	
	lo_Xml_Http.DisconnectObject()
	
	GarbageCollect()
	
	Destroy(lo_Xml_Http)
	
	Return False
Finally
	Close(lw_temp)
	Destroy(lw_temp)
	
	if IsValid(lo_Xml_Http) then
		lo_Xml_Http.DisconnectObject()	
		
		Destroy(lo_Xml_Http)
	end if
	
	GarbageCollect()
	
	If lb_Sucesso Then
		Return True
	End If
	
End Try
end function

public subroutine of_set_file_extension (string as_file_to_read);is_format = as_file_to_read
end subroutine

on dc_uo_api.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_api.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//Busca o registro da API para envios SFTP
select vl_parametro
  into :is_de_url_api_sftp
  from parametro_geral
 where cd_parametro = 'DE_URL_API_SFTP';
 
if not IsNull(is_de_url_api_sftp) then
	is_de_url_api_sftp = 'http://' + is_de_url_api_sftp
end if
end event

