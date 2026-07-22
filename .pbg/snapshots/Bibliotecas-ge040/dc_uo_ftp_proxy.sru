HA$PBExportHeader$dc_uo_ftp_proxy.sru
forward
global type dc_uo_ftp_proxy from nonvisualobject
end type
type win32_find_dataa from structure within dc_uo_ftp_proxy
end type
end forward

type win32_find_dataa from structure
	unsignedlong		dwfileattributes
	filetime		ftcreationtime
	filetime		ftlastaccesstime
	filetime		ftlastwritetime
	unsignedlong		nfilesizehigh
	unsignedlong		nfilesizelow
	unsignedlong		dwreserved0
	unsignedlong		dwreserved1
	character		cfilename[260]
	character		calternatefilename[14]
end type

global type dc_uo_ftp_proxy from nonvisualobject
end type
global dc_uo_ftp_proxy dc_uo_ftp_proxy

type prototypes
function long InternetOpenA(string lpszAgent, long dwAccessType, string lpszProxyName, string lpszProxyBypass, long dwFlags )&
library "wininet.dll" alias for "InternetOpenA;Ansi"
function long InternetConnectA(long hInternet, string lpszServerName, int nServerPort, string lpszUsername, &
string lpszPassword, long dwService, long dwFlags, long dwContext) library "wininet.dll" alias for "InternetConnectA;Ansi"
Function Boolean FtpSetCurrentDirectoryA (long hFtpSession, string lpszDirectory) library "wininet.dll" alias for "FtpSetCurrentDirectoryA;Ansi"
Function boolean FtpCreateDirectoryA(Long hConnect, string lpszDirectory) library 'wininet.dll' alias for "FtpCreateDirectoryA;Ansi";
Function boolean FtpPutFileA(long hConnect, string lpszLocalFile, string lpszNewRemoteFile, long dwFlags, &
long dwContext) library "wininet.dll" alias for "FtpPutFileA;Ansi"
Function boolean FtpGetFileA(long hConnect, string lpszRemoteFile, string lpszNewFile, boolean fFailIfExists, &
long dwFlagsAndAttributes, long dwFlags, long dwContext) library 'wininet.dll' alias for "FtpGetFileA;Ansi"
Function boolean FtpRenameFileA(Long hConnect, string lpszExisting, string lpszNew) library 'wininet.dll' alias for "FtpRenameFileA;Ansi";
Function boolean FtpDeleteFileA(Long hConnect, string lpszFileName) library 'wininet.dll' alias for "FtpDeleteFileA;Ansi";
Function long InternetCloseHandle(long hInet) library "wininet.dll"
Function long FtpFindFirstFileA (Long hFtpSession , string lpszSearchFile, ref WIN32_FIND_DATAA lpFindFileData , long dwFlags, long dwContent) library "wininet.dll" alias for "FtpFindFirstFileA;Ansi"
Function boolean InternetFindNextFileA (Long hFind, ref WIN32_FIND_DATAA lpvFindData) library "wininet.dll" alias for "InternetFindNextFileA;Ansi"
Function long FtpGetFileSize(long hFtpSession, long lpszRemoteFile)  library "wininet.dll"
Function long FtpOpenFileA(long hFtpSession, string sFileName, long lAccess, long lFlags, long lContext) library "wininet.dll" alias for "FtpOpenFileA;Ansi"

Function boolean FtpCommandA(long hConnect,boolean fExpectResponse, &
    long dwFlags,string lpszCommand, long dwContext, ref long phFtpCommand) library "wininet.dll" alias for "FtpCommandA;Ansi"
end prototypes

type variables
Constant Public long INTERNET_DEFAULT_FTP_PORT = 21, &
INTERNET_SERVICE_FTP = 1, &
FTP_TRANSFER_TYPE_ASCII = 1, &
FTP_TRANSFER_TYPE_BINARY = 2, &
GENERIC_READ = 2147483648, &
API_FALSE = 0,&
INTERNET_FLAG_PASSIVE = 134217728

Constant String USUARIO_DOWNLOAD_VERSAO_MATRIZ	= "versao"
Constant String SENHA_DOWNLOAD_VERSAO_MATRIZ		= "versao"

Public ProtectedWrite long uol_Hnd_open, uol_Hnd_Conexao
Public ProtectedWrite string uos_servidor, uos_dir_atual, uos_usuario, uos_aplicacao, uos_ftp_dir
Private string uos_senha

String ivs_msg, &
          ivs_Local_Dir = 'c:\temp\'

dc_uo_api ivo_api
end variables

forward prototypes
public function long of_desconecta_ftp ()
public function long of_ftp_set_dir (string p_dir)
public function integer of_ftp_lista_arquivos (string p_filter, ref string p_arquivos[], ref string p_diretorios[])
public function long of_ftp_getdir (string ps_diretorio)
public function boolean of_ftp_getfile (string p_remoto, string p_local)
public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha)
public function integer of_ftp_lista_arquivos (string p_filter, ref string p_arquivos[])
public function boolean of_ftp_putfile (string p_arquivo_local, string p_arquivo_ftp)
public function boolean of_ftp_deletefile (string p_arquivo)
public function boolean of_ftp_cria_dir (string p_dir)
public function boolean of_ftp_getfile (string p_remoto, string p_local, ref string ps_msg)
public function integer of_ftp_fileopen (string ps_arquivo)
public function boolean of_ftp_execute (string ps_arquivo)
public function boolean of_ftp_putfile (string p_arquivo_local, string p_arquivo_ftp, ref string ps_mensagem)
public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha, ref string ps_msg)
public function boolean of_ftp_deletefile (string p_arquivo, ref string ps_mensagem)
public function boolean of_ftp_getfile (string p_remoto, string p_local, ref string ps_msg, string ps_asc_bin)
public function long of_ftp_set_dir (string p_dir, ref string ps_msg)
public function boolean of_ftp_cria_dir (string p_dir, ref STRING ps_mensagem)
public function boolean of_ftp_renamefile (string ps_nome_de, string ps_nome_para, ref string ps_mensagem)
public function boolean of_ftp_putfile (string p_arquivo_local, string p_arquivo_ftp, ref string ps_mensagem, boolean ab_transferencia_binaria)
public function long of_ftp_get_filesize (string ps_arquivo, long pl_len)
public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha, ref string ps_msg, string p_usuario_proxy, string p_senha_proxy)
end prototypes

public function long of_desconecta_ftp ();internetclosehandle( uol_hnd_conexao)
internetclosehandle( uol_hnd_open )

uos_usuario = ''
uos_senha = ''
uos_servidor = ''
uos_aplicacao = ''
uos_dir_atual = ''
uol_hnd_conexao = 0
uol_hnd_open = 0
return 1
end function

public function long of_ftp_set_dir (string p_dir);if not FtpSetCurrentDirectoryA ( uol_hnd_conexao , p_dir ) then
	ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a pasta ' + p_dir + '!'
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_msg)
	return -1
end if

//Altera a propriedade uos_ftp_dir (Pasta corrente)
long vll_pos
if p_dir = '\' then
	uos_ftp_dir = ''
elseif p_dir = '..' and uos_ftp_dir <> '' then
	do while PosA(uos_ftp_dir, '\', vll_pos + 1) > 0
		vll_pos = PosA(uos_ftp_dir, '\', vll_pos + 1)
	loop
	if vll_pos > 0 then
		uos_ftp_dir = LeftA(uos_ftp_dir , vll_pos - 1)
	else
		uos_ftp_dir = ''
	end if
else
	uos_ftp_dir += '\' + p_dir
end if
////////////////////
return 1
end function

public function integer of_ftp_lista_arquivos (string p_filter, ref string p_arquivos[], ref string p_diretorios[]);// DESCRI$$HEX2$$c700c300$$ENDHEX$$O:
// * Lista os arquivos existentes no FTP
//
// ARGUMENTOS DE ENTRADA:
// * sfilter : Filtro utilizado para diret$$HEX1$$f300$$ENDHEX$$rios
// * p_arquivos : Lista de arquivos retornados
//
// RETORNO:
// * 1 : Sucesso
// * -1 : Erro
// * 0 : Registro n$$HEX1$$e300$$ENDHEX$$o encontrado
//
// OBSERVA$$HEX2$$c700c300$$ENDHEX$$O:
// * Lista dos atributos retornados para arquivos
// Public Const FILE_ATTRIBUTE_READONLY = &H1
// Public Const FILE_ATTRIBUTE_HIDDEN = &H2
// Public Const FILE_ATTRIBUTE_SYSTEM = &H4
// Public Const FILE_ATTRIBUTE_DIRECTORY = &H10
// Public Const FILE_ATTRIBUTE_ARCHIVE = &H20
// Public Const FILE_ATTRIBUTE_NORMAL = &H80
// Public Const FILE_ATTRIBUTE_TEMPORARY = &H100
// Public Const FILE_ATTRIBUTE_COMPRESSED = &H800
// Public Const FILE_ATTRIBUTE_OFFLINE = &H1000
//
// CRIADO POR :
// 12/12/2006 - Thiago Campos Pereira
// ALTERADO POR :
//
//========================================================================

long VLLhandleFind, VLLRet, VLLItem, lvl_Filtro_Atributo
string vlsAux
WIN32_FIND_DATAA VLstrData

//Procura primeiro arquivo no FTP
VLLhandleFind = FtpFindFirstFileA(uol_hnd_conexao, p_Filter, VLstrData, 0, 0)

//Se n$$HEX1$$e300$$ENDHEX$$o encontrar arquivos, sai da fun$$HEX2$$e700e300$$ENDHEX$$o
If VLLhandleFind = 0 then return 1

//Se encontrou arquivo, realizar loop preenchendo vetor com diret$$HEX1$$f300$$ENDHEX$$rios
do
	//Verificar se $$HEX1$$e900$$ENDHEX$$ arquivo e se n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ diretorno
	lvl_Filtro_Atributo = VLstrData.dwfileattributes
	if mod(VLstrData.dwfileattributes , 128) = 0 then
	//Se for arquivo, armazena nome do arquivo
		vlsAux = ''
		for VLLItem = 1 to upperbound(VLstrData.cfilename)
			//No momento que encontrar o caracter 0, quer dizer que $$HEX1$$e900$$ENDHEX$$ o final do nome do diret$$HEX1$$f300$$ENDHEX$$rio
			if AscA(VLstrData.cfilename[VLLItem]) = 0 then
				p_arquivos[upperbound(p_arquivos) + 1] = vlsAux
				//MessageBox("", p_arquivos[upperbound(p_arquivos)])
				exit
			else
				vlsAux = vlsAux + VLstrData.cfilename[VLLItem]
			end if
		next
	Else
	//Se for diret$$HEX1$$f300$$ENDHEX$$rio, armazena nome do diret$$HEX1$$f300$$ENDHEX$$rio
		vlsAux = ''
		for VLLItem = 1 to upperbound(VLstrData.cfilename)
			//No momento que encontrar o caracter 0, quer dizer que $$HEX1$$e900$$ENDHEX$$ o final do nome do diret$$HEX1$$f300$$ENDHEX$$rio
			if AscA(VLstrData.cfilename[VLLItem]) = 0 then
				p_diretorios[upperbound(p_diretorios) + 1] = vlsAux
				//MessageBox("", p_diretorios[upperbound(p_diretorios)])
				exit
			else
				vlsAux = vlsAux + VLstrData.cfilename[VLLItem]
			end if
		next		
	end if

	//Procura pr$$HEX1$$f300$$ENDHEX$$ximo diret$$HEX1$$f300$$ENDHEX$$rio
	if not InternetFindNextFileA(VLLhandleFind, VLstrData) then
		VLLhandleFind = 0
	end if
loop while VLLhandleFind > 0

return 1
end function

public function long of_ftp_getdir (string ps_diretorio);Long lvl_Arquivo, &
	  lvl_Diretorio, &
	  lvl_SubDiretorio

String lvs_Arquivos[]     , &
		 lvs_Diretorios[]   , &
		 lvs_Subdiretorios[], &
		 lvs_Local_Dir_Aux

This.of_Ftp_Set_Dir(ps_Diretorio)

lvs_Local_Dir_Aux = ivs_Local_Dir

ivs_Local_Dir += ps_Diretorio

ivo_Api.of_Create_Directory(ivs_Local_Dir)

This.of_Ftp_Lista_Arquivos("", ref lvs_Arquivos, Ref lvs_Diretorios)

If UpperBound(lvs_Diretorios) > 0 Then
	For lvl_Diretorio = 1 To UpperBound(lvs_Diretorios)
		This.of_Ftp_GetDir(lvs_Diretorios[lvl_Diretorio])
	Next
End If

For lvl_Arquivo = 1 To UpperBound(lvs_Arquivos)
	This.of_Ftp_GetFile(lvs_Arquivos[lvl_Arquivo], ivs_Local_Dir + lvs_Arquivos[lvl_Arquivo])
Next

ivs_Local_Dir = lvs_Local_Dir_Aux

Return 1
end function

public function boolean of_ftp_getfile (string p_remoto, string p_local);if not of_Ftp_GetFile(p_remoto , p_local, ref ivs_Msg) then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_msg, StopSign!)
	return False
end if

return True
end function

public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha);If Not of_Conecta_Ftp(p_aplicacao, p_servername, p_usuario, p_senha, ref ivs_Msg) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_Msg)
	Return False
End If

Return True
end function

public function integer of_ftp_lista_arquivos (string p_filter, ref string p_arquivos[]);// DESCRI$$HEX2$$c700c300$$ENDHEX$$O:
// * Lista os arquivos existentes no FTP
//
// ARGUMENTOS DE ENTRADA:
// * sfilter : Filtro utilizado para diret$$HEX1$$f300$$ENDHEX$$rios
// * p_arquivos : Lista de arquivos retornados
//
// RETORNO:
// * 1 : Sucesso
// * -1 : Erro
// * 0 : Registro n$$HEX1$$e300$$ENDHEX$$o encontrado
//
// OBSERVA$$HEX2$$c700c300$$ENDHEX$$O:
// * Lista dos atributos retornados para arquivos
// Public Const FILE_ATTRIBUTE_READONLY = &H1
// Public Const FILE_ATTRIBUTE_HIDDEN = &H2
// Public Const FILE_ATTRIBUTE_SYSTEM = &H4
// Public Const FILE_ATTRIBUTE_DIRECTORY = &H10
// Public Const FILE_ATTRIBUTE_ARCHIVE = &H20
// Public Const FILE_ATTRIBUTE_NORMAL = &H80
// Public Const FILE_ATTRIBUTE_TEMPORARY = &H100
// Public Const FILE_ATTRIBUTE_COMPRESSED = &H800
// Public Const FILE_ATTRIBUTE_OFFLINE = &H1000
//
// CRIADO POR :
// 12/12/2006 - Thiago Campos Pereira
// ALTERADO POR :
//
//========================================================================

long VLLhandleFind, VLLRet, VLLItem, lvl_Filtro_Atributo
string vlsAux
WIN32_FIND_DATAA VLstrData

//Procura primeiro arquivo no FTP
VLLhandleFind = FtpFindFirstFileA(uol_hnd_conexao, p_Filter, VLstrData, 0, 0)

//Se n$$HEX1$$e300$$ENDHEX$$o encontrar arquivos, sai da fun$$HEX2$$e700e300$$ENDHEX$$o
If VLLhandleFind = 0 then return 1

//Se encontrou arquivo, realizar loop preenchendo vetor com diret$$HEX1$$f300$$ENDHEX$$rios
do
	//Verificar se $$HEX1$$e900$$ENDHEX$$ arquivo e se n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ diretorno
	lvl_Filtro_Atributo = VLstrData.dwfileattributes
	if mod(VLstrData.dwfileattributes , 128) = 0 then
	//Se for arquivo, armazena nome do arquivo
		vlsAux = ''
		for VLLItem = 1 to upperbound(VLstrData.cfilename)
			//No momento que encontrar o caracter 0, quer dizer que $$HEX1$$e900$$ENDHEX$$ o final do nome do diret$$HEX1$$f300$$ENDHEX$$rio
			if AscA(VLstrData.cfilename[VLLItem]) = 0 then
				p_arquivos[upperbound(p_arquivos) + 1] = vlsAux
				//MessageBox("", p_arquivos[upperbound(p_arquivos)])
				exit
			else
				vlsAux = vlsAux + VLstrData.cfilename[VLLItem]
			end if
		next
	End if

	//Procura pr$$HEX1$$f300$$ENDHEX$$ximo diret$$HEX1$$f300$$ENDHEX$$rio
	if not InternetFindNextFileA(VLLhandleFind, VLstrData) then
		VLLhandleFind = 0
	end if
loop while VLLhandleFind > 0

return 1
end function

public function boolean of_ftp_putfile (string p_arquivo_local, string p_arquivo_ftp);String lvs_Mensagem

if not of_Ftp_PutFile(p_arquivo_local, p_arquivo_ftp, ref lvs_Mensagem) then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, StopSign!)
	return False
end if

return True
end function

public function boolean of_ftp_deletefile (string p_arquivo);If Not FTPDeleteFileA(uol_hnd_conexao, p_arquivo) then
	ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel excluir o arquivo ' + uos_ftp_dir + '\'+ p_arquivo + '!'
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_msg)
	Return False
End If

return True
end function

public function boolean of_ftp_cria_dir (string p_dir);if not this.ftpcreatedirectorya( uol_hnd_conexao , p_dir ) then
	ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi criar a pasta ' + p_dir + '!'
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_msg)
	return False
end if

return True
end function

public function boolean of_ftp_getfile (string p_remoto, string p_local, ref string ps_msg);if not FtpGetFileA(uol_hnd_conexao, p_remoto , p_local, false, 0, 1, 0) then
	ps_MSG = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel fazer o download do arquivo ~r ftp://' + uos_servidor + '/' + &
			  MidA(uos_ftp_dir, 2) + '/' + p_remoto + '~r para ' + p_local + ' via FTP!'
			  
	FileDelete(p_local)
	return False
end if

return True
end function

public function integer of_ftp_fileopen (string ps_arquivo);Return FtpOpenFileA(uol_Hnd_Conexao, ps_Arquivo, GENERIC_READ, FTP_TRANSFER_TYPE_BINARY, 0)
//Return FtpOpenFileA(uol_Hnd_Conexao, ps_Arquivo, GENERIC_READ, FTP_TRANSFER_TYPE_ASCII, 0)
end function

public function boolean of_ftp_execute (string ps_arquivo);Long ll_Test
Boolean lb_Result

lb_Result = FtpCommandA(uol_hnd_conexao, False, FTP_TRANSFER_TYPE_ASCII,'ls', 0,ref ll_Test) 

Return True
end function

public function boolean of_ftp_putfile (string p_arquivo_local, string p_arquivo_ftp, ref string ps_mensagem);if not ftpputfilea( uol_hnd_conexao, p_arquivo_local, p_arquivo_ftp, ftp_transfer_type_ascii, 0) then
	ivs_msg = 'Erro ao transferir arquivo ' + p_arquivo_local + ' via FTP!'
	ps_mensagem = ivs_msg
	return False
end if

return True
end function

public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha, ref string ps_msg);String ls_Nulo

SetNull(ls_Nulo)

If Not of_Conecta_Ftp(p_aplicacao, p_servername, p_usuario, p_senha, ref ps_msg, ls_Nulo, ls_Nulo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_Msg)
	Return False
End If

Return True



end function

public function boolean of_ftp_deletefile (string p_arquivo, ref string ps_mensagem);If Not FTPDeleteFileA(uol_hnd_conexao, p_arquivo) then
	ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel excluir o arquivo ' + uos_ftp_dir + '\'+ p_arquivo
	ps_Mensagem = ivs_msg 
	Return False
End If

return True
end function

public function boolean of_ftp_getfile (string p_remoto, string p_local, ref string ps_msg, string ps_asc_bin);Long lvl_Flag

If Upper(ps_ASC_BIN) = 'ASC' Then
	lvl_Flag = FTP_TRANSFER_TYPE_ASCII
Else
	lvl_Flag = FTP_TRANSFER_TYPE_BINARY
End If

if not FtpGetFileA(uol_hnd_conexao, p_remoto , p_local, false, 0, lvl_Flag, 0) then
	ps_MSG = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel fazer o download do arquivo ~r ftp://' + uos_servidor + '/' + &
			  MidA(uos_ftp_dir, 2) + '/' + p_remoto + '~r para ' + p_local + ' via FTP!'
			  
	FileDelete(p_local)
	return False
end if

return True
end function

public function long of_ftp_set_dir (string p_dir, ref string ps_msg);if not FtpSetCurrentDirectoryA ( uol_hnd_conexao , p_dir ) then
	ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a pasta ' + p_dir + '!'
	ps_msg = ivs_msg
	return -1
end if

//Altera a propriedade uos_ftp_dir (Pasta corrente)
long vll_pos
if p_dir = '\' then
	uos_ftp_dir = ''
elseif p_dir = '..' and uos_ftp_dir <> '' then
	do while PosA(uos_ftp_dir, '\', vll_pos + 1) > 0
		vll_pos = PosA(uos_ftp_dir, '\', vll_pos + 1)
	loop
	if vll_pos > 0 then
		uos_ftp_dir = LeftA(uos_ftp_dir , vll_pos - 1)
	else
		uos_ftp_dir = ''
	end if
else
	uos_ftp_dir += '\' + p_dir
end if

//ps_Msg = uos_ftp_dir
////////////////////
return 1
end function

public function boolean of_ftp_cria_dir (string p_dir, ref STRING ps_mensagem);if not this.ftpcreatedirectorya( uol_hnd_conexao , p_dir ) then
	ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi criar a pasta ' + p_dir + '!'
	ps_mensagem = ivs_msg
	return False
end if

return True
end function

public function boolean of_ftp_renamefile (string ps_nome_de, string ps_nome_para, ref string ps_mensagem);//BOOL FtpRenameFile(
//  __in  HINTERNET hConnect,
//  __in  LPCTSTR lpszExisting,
//  __in  LPCTSTR lpszNew
//);
//

if not ftprenamefilea ( uol_hnd_conexao, ps_nome_de, ps_nome_para) then
	ivs_msg = "Erro ao renomear o arquivo de '" + ps_nome_de +  "' para '" + ps_nome_para + "' na $$HEX1$$e100$$ENDHEX$$rea FTP!"
	ps_mensagem = ivs_msg
	return False
end if

Return True
end function

public function boolean of_ftp_putfile (string p_arquivo_local, string p_arquivo_ftp, ref string ps_mensagem, boolean ab_transferencia_binaria);Long lvl_ASC_BIN

If ab_transferencia_binaria Then
	lvl_ASC_BIN = FTP_TRANSFER_TYPE_BINARY
Else
	lvl_ASC_BIN = FTP_TRANSFER_TYPE_ASCII
End If

if not ftpputfilea( uol_hnd_conexao, p_arquivo_local, p_arquivo_ftp,lvl_ASC_BIN, 0) then
	ivs_msg = 'Erro ao transferir arquivo ' + p_arquivo_local + ' via FTP!'
	ps_mensagem = ivs_msg
	return False
end if

return True
end function

public function long of_ftp_get_filesize (string ps_arquivo, long pl_len);long ll_X
//ll_X = FtpGetFileSize( ps_arquivo, ref pl_len )
Return ll_X
end function

public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha, ref string ps_msg, string p_usuario_proxy, string p_senha_proxy);/*----------------------------------------------------------------------------------*/
/* FAZ A CONEX$$HEX1$$c300$$ENDHEX$$O COM O SERVIDOR PARA TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA VIA FTP */
/* PAR$$HEX1$$c200$$ENDHEX$$METROS: p_aplicacao: Nome da aplica$$HEX2$$e700e300$$ENDHEX$$o
p_servername: 'ftp.zzzzz.com.br' ou endere$$HEX1$$e700$$ENDHEX$$o IP Ex.: '255.255.255.255'
p_usuario e p_senha*/

Long ll_Tipo_Acesso

uos_servidor = p_servername
uos_usuario= p_usuario
uos_senha = p_senha
uos_aplicacao = p_aplicacao
uos_ftp_dir = ''

// Esta altera$$HEX2$$e700e300$$ENDHEX$$o foi realizada para atender a conex$$HEX1$$e300$$ENDHEX$$o SFTP.
If (Not IsNull(p_usuario_proxy) and Trim(p_usuario_proxy) <> '') and (Not IsNull(p_senha_proxy) and Trim(p_senha_proxy) <> '') Then
	//INTERNET_OPEN_TYPE_PROXY
	ll_Tipo_Acesso = 3
Else
	SetNull(p_usuario_proxy)
	SetNull(p_senha_proxy)
	//INTERNET_OPEN_TYPE_DIRECT = 1
	ll_Tipo_Acesso = 1
End If

uol_hnd_open = internetopena(uos_aplicacao , ll_Tipo_Acesso, p_usuario_proxy, p_senha_proxy, 0)

if uol_hnd_open = 0 or isnull(uol_hnd_open) then
	ps_msg = "Erro ao abrir a conex$$HEX1$$e300$$ENDHEX$$o com o servidor ftp: " + p_servername + ". Fun$$HEX2$$e700e300$$ENDHEX$$o API InternetOpen"
	return False
end if

uol_hnd_conexao = internetconnecta( uol_hnd_open, uos_servidor, 0, uos_usuario, uos_senha, 1, 0, 0)

if uol_hnd_conexao = 0 or isnull(uol_hnd_conexao) then
	ps_msg = "Erro ao abrir a conex$$HEX1$$e300$$ENDHEX$$o com o servidor ftp: " + p_servername + ". Fun$$HEX2$$e700e300$$ENDHEX$$o API InternetConnect"
	internetclosehandle( uol_hnd_open)
	return False
end if

return True
end function

on dc_uo_ftp_proxy.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_ftp_proxy.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_api = Create dc_uo_api
end event

event destructor;Destroy(ivo_Api)
end event

