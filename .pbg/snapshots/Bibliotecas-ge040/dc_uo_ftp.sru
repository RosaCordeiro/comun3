HA$PBExportHeader$dc_uo_ftp.sru
forward
global type dc_uo_ftp from nonvisualobject
end type
type win32_find_dataa from structure within dc_uo_ftp
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

global type dc_uo_ftp from nonvisualobject
end type
global dc_uo_ftp dc_uo_ftp

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
Function boolean FtpDeleteFile ( ulong hConnect, string lpszFileName	) Library "wininet.dll" Alias For "FtpDeleteFileW;Ansi"
Function long InternetCloseHandle(long hInet) library "wininet.dll"
Function long FtpFindFirstFileA (Long hFtpSession , string lpszSearchFile, ref WIN32_FIND_DATAA lpFindFileData , long dwFlags, long dwContent) library "wininet.dll" alias for "FtpFindFirstFileA;Ansi"
Function boolean InternetFindNextFileA (Long hFind, ref WIN32_FIND_DATAA lpvFindData) library "wininet.dll" alias for "InternetFindNextFileA;Ansi"
Function long FtpGetFileSize(long hFtpSession, long lpszRemoteFile)  library "wininet.dll"
Function long FtpOpenFileA(long hFtpSession, string sFileName, long lAccess, long lFlags, long lContext) library "wininet.dll" alias for "FtpOpenFileA;Ansi"
Function boolean FtpSetCurrentDirectory ( &
	ulong hConnect, &
	string lpszDirectory &
) Library "wininet.dll" Alias For "FtpSetCurrentDirectoryW;Ansi"

Function boolean FtpCommandA(long hConnect,boolean fExpectResponse, &
    long dwFlags,string lpszCommand, long dwContext, ref long phFtpCommand) library "wininet.dll" alias for "FtpCommandA;Ansi"
	 
Function boolean FileTimeToSystemTime ( &
	Ref FILETIME lpFileTime, &
	Ref SYSTEMTIME lpSystemTime &
	) Library "kernel32.dll" Alias For "FileTimeToSystemTime"
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
public function long of_ftp_getdir (string ps_diretorio)
public function boolean of_ftp_getfile (string p_remoto, string p_local)
public function boolean of_ftp_putfile (string p_arquivo_local, string p_arquivo_ftp)
public function boolean of_ftp_deletefile (string p_arquivo)
public function boolean of_ftp_cria_dir (string p_dir)
public function boolean of_ftp_getfile (string p_remoto, string p_local, ref string ps_msg)
public function integer of_ftp_fileopen (string ps_arquivo)
public function boolean of_ftp_execute (string ps_arquivo)
public function boolean of_ftp_putfile (string p_arquivo_local, string p_arquivo_ftp, ref string ps_mensagem)
public function boolean of_ftp_deletefile (string p_arquivo, ref string ps_mensagem)
public function boolean of_ftp_getfile (string p_remoto, string p_local, ref string ps_msg, string ps_asc_bin)
public function long of_ftp_set_dir (string p_dir, ref string ps_msg)
public function boolean of_ftp_cria_dir (string p_dir, ref string ps_mensagem)
public function boolean of_ftp_renamefile (string ps_nome_de, string ps_nome_para, ref string ps_mensagem)
public function boolean of_ftp_putfile (string p_arquivo_local, string p_arquivo_ftp, ref string ps_mensagem, boolean ab_transferencia_binaria)
public function long of_ftp_get_filesize (string ps_arquivo, long pl_len)
public function long of_ftp_set_dir_raiz ()
public function boolean of_checkbit (long al_number, unsignedinteger ai_bit)
public function datetime of_filedatetime (filetime astr_filetime)
public function integer of_ftp_lista_arquivos (string ps_filter, ref string ps_arquivos[], ref string ps_diretorios[])
public function integer of_ftp_lista_arquivos (string ps_filter, ref string ps_arquivos[])
public function integer of_ftp_lista_arquivos (string ps_filter, ref s_ftpdirlist pstr_dirlist[])
public function string of_getfiledescription (string as_filename)
public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha, ref string ps_msg)
public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha)
public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha, string p_porta_ftp, ref string ps_msg)
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

public function long of_ftp_set_dir (string p_dir);If not FtpSetCurrentDirectoryA ( uol_hnd_conexao , p_dir ) then
	//ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a pasta ' + p_dir + '!'
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_msg)
	Return -1
End if

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

public function boolean of_ftp_putfile (string p_arquivo_local, string p_arquivo_ftp);String lvs_Mensagem

if not of_Ftp_PutFile(p_arquivo_local, p_arquivo_ftp, ref lvs_Mensagem) then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, StopSign!)
	return False
end if

return True
end function

public function boolean of_ftp_deletefile (string p_arquivo);If Not FTPDeleteFileA(uol_hnd_conexao, p_arquivo) then
	//Tentativa 2
	If Not FTPDeleteFile(uol_hnd_conexao, p_arquivo) then
		ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel excluir o arquivo ' + uos_ftp_dir + '\'+ p_arquivo + '!'
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_msg)
		Return False
	End If
End If

return True
end function

public function boolean of_ftp_cria_dir (string p_dir);if not this.ftpcreatedirectorya( uol_hnd_conexao , p_dir ) then
	ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel criar a pasta ' + p_dir + '!'
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

public function boolean of_ftp_deletefile (string p_arquivo, ref string ps_mensagem);If Not FTPDeleteFileA(uol_hnd_conexao, p_arquivo) then
	//Tentativa 2
	If Not FTPDeleteFile(uol_hnd_conexao, p_arquivo) then
		ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel excluir o arquivo ' + uos_ftp_dir + '\'+ p_arquivo
		ps_Mensagem = ivs_msg 
		Return False
	End If
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

public function boolean of_ftp_cria_dir (string p_dir, ref string ps_mensagem);if not this.ftpcreatedirectorya( uol_hnd_conexao , p_dir ) then
	ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel criar a pasta ' + p_dir + '!'
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

public function long of_ftp_set_dir_raiz ();String ls_Dir = '/'

If not FtpSetCurrentDirectoryA ( uol_hnd_conexao , ls_Dir ) then
	ivs_msg = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o diret$$HEX1$$f300$$ENDHEX$$rio raiz'
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_msg)
	return -1
end if

uos_ftp_dir = ls_Dir

////////////////////
return 1
end function

public function boolean of_checkbit (long al_number, unsignedinteger ai_bit);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Checkbit
//
// PURPOSE:    This function determines if a certain bit is on or off within
//					the number.
//
// ARGUMENTS:  al_number	- Number to check bits
//             ai_bit		- Bit number ( starting at 1 )
//
// RETURN:		True = On, False = Off
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 22/04/2005	RolandS		Initial Coding
// 24/07/2017 	Marlon		Adapta$$HEX2$$e700e300$$ENDHEX$$o PB12.0 Clamed
// -----------------------------------------------------------------------------

If Int(Mod(al_number / (2 ^(ai_bit - 1)), 2)) > 0 Then
	Return True
End If

Return False

end function

public function datetime of_filedatetime (filetime astr_filetime);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_FileDateTime
//
// PURPOSE:    This function converts a file datetime to a PB datetime.
//
// ARGUMENTS:  astr_filetime	- filetime structure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/22/2009	RolandS		Initial Coding
// 24/07/2017 	Marlon		Adapta$$HEX2$$e700e300$$ENDHEX$$o PB12.0 Clamed
// -----------------------------------------------------------------------------

DateTime ldt_filedate
SYSTEMTIME lstr_systime
String ls_time
Date ld_fdate
Time lt_ftime

SetNull(ldt_filedate)

If Not FileTimeToSystemTime(astr_FileTime, &
			lstr_systime) Then Return ldt_filedate

ld_fdate = Date(lstr_systime.wYear, &
					lstr_systime.wMonth, lstr_systime.wDay)

ls_time = String(lstr_systime.wHour) + ":" + &
			 String(lstr_systime.wMinute) + ":" + &
			 String(lstr_systime.wSecond)

lt_ftime = Time(ls_Time)

ldt_filedate = DateTime(ld_fdate, lt_ftime)

Return ldt_filedate
end function

public function integer of_ftp_lista_arquivos (string ps_filter, ref string ps_arquivos[], ref string ps_diretorios[]);// DESCRI$$HEX2$$c700c300$$ENDHEX$$O:
// * Lista os arquivos existentes no FTP
//
// ARGUMENTOS DE ENTRADA:
// * sfilter : Filtro utilizado para diret$$HEX1$$f300$$ENDHEX$$rios
// * ps_arquivos : Lista de arquivos retornados
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
VLLhandleFind = FtpFindFirstFileA(uol_hnd_conexao, ps_Filter, VLstrData, 0, 0)

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
				ps_arquivos[upperbound(ps_arquivos) + 1] = vlsAux
				//MessageBox("", ps_arquivos[upperbound(ps_arquivos)])
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
				ps_diretorios[upperbound(ps_diretorios) + 1] = vlsAux
				//MessageBox("", ps_diretorios[upperbound(ps_diretorios)])
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

public function integer of_ftp_lista_arquivos (string ps_filter, ref string ps_arquivos[]);// DESCRI$$HEX2$$c700c300$$ENDHEX$$O:
// * Lista os arquivos existentes no FTP
//
// ARGUMENTOS DE ENTRADA:
// * sfilter : Filtro utilizado para diret$$HEX1$$f300$$ENDHEX$$rios
// * ps_arquivos : Lista de arquivos retornados
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
VLLhandleFind = FtpFindFirstFileA(uol_hnd_conexao, ps_Filter, VLstrData, 0, 0)

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
				ps_arquivos[upperbound(ps_arquivos) + 1] = vlsAux
				//MessageBox("", ps_arquivos[upperbound(ps_arquivos)])
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

public function integer of_ftp_lista_arquivos (string ps_filter, ref s_ftpdirlist pstr_dirlist[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_wininet.of_Ftp_Directory
//
// PURPOSE:    This function returns a structure containing a list of files
//					and subdirectories on the FTP server.
//
// ARGUMENTS:  pstr_dirlist	- By ref structure of files/dirs
//
// RETURN:		Number of directory entries found
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/22/2009	RolandS		Initial Coding
// 24/07/2017 	Marlon		Adapta$$HEX2$$e700e300$$ENDHEX$$o PB12.0 Clamed
// -----------------------------------------------------------------------------

WIN32_FIND_DATAA lstr_FindData
ulong		lul_hFind
Integer	li_file
Boolean	lb_morefiles = True

//Localiza primeiro arquivo
lul_hFind = FtpFindFirstFileA(uol_Hnd_Conexao, ps_filter, lstr_FindData, 0, 0)

If lul_hFind = 0 Then Return 0

DO WHILE lb_morefiles
	li_file = li_file + 1
	// Recupera nome arquivo
	pstr_dirlist[li_file].s_FileName = String(lstr_FindData.cfilename)
	pstr_dirlist[li_file].s_AltFileName = String(lstr_FindData.calternatefilename)
	If Trim(pstr_dirlist[li_file].s_AltFileName) = "" Then
		pstr_dirlist[li_file].s_AltFileName = pstr_dirlist[li_file].s_FileName
	End If
	// Determina se o objeto $$HEX1$$e900$$ENDHEX$$ um subdiret$$HEX1$$f300$$ENDHEX$$rio
	pstr_dirlist[li_file].b_subdir = of_checkbit(lstr_FindData.dwFileAttributes, 5)
	// Propriedades Data/Hora arquivo
	pstr_dirlist[li_file].dt_CreationTime	= This.of_FileDateTime(lstr_FindData.ftCreationTime)
	pstr_dirlist[li_file].dt_LastAccessTime	= This.of_FileDateTime(lstr_FindData.ftLastAccessTime)
	pstr_dirlist[li_file].dt_LastWriteTime	= This.of_FileDateTime(lstr_FindData.ftLastWriteTime)
	// Retorna tamanho do arquivo
	pstr_dirlist[li_file].db_FileSize = (lstr_FindData.nFileSizeHigh * (2.0 ^ 32)) + lstr_FindData.nFileSizeLow
	// Retorna atributos do arquivo
	pstr_dirlist[li_file].ul_Attributes = lstr_FindData.dwFileAttributes
	// Procura pr$$HEX1$$f300$$ENDHEX$$ximo arquivo
	lb_morefiles = InternetFindNextFileA(lul_hFind, lstr_FindData)
LOOP

// close out directory handle
//InternetCloseHandle(lul_hFind)

Return UpperBound(pstr_dirlist[])
end function

public function string of_getfiledescription (string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     u_listview.of_GetFileDescription
//
// PURPOSE:    This function returns the file type description.
//
// ARGUMENTS:  as_filename		- The name of the file
//
//	RETURN:		File Description
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 04/20/2012	RolandS		Initial coding
// -----------------------------------------------------------------------------
//
//Constant Long SHGFI_ICON = 256 
//Constant Long SHGFI_DISPLAYNAME = 512
//Constant Long SHGFI_TYPENAME = 1024
//SHFILEINFO lstr_SFI
String ls_typename, ls_extn, ls_regkey, ls_regvalue
//Long ll_rc, ll_pos
//
//ll_pos = LastPos(as_filename, ".")
//ls_extn = Mid(as_filename, ll_pos + 1)
//
//ll_rc = SHGetFileInfo(as_filename, 0, lstr_SFI, 352, SHGFI_TYPENAME)
//If ll_rc = 1 Then
//	ls_typename = String(lstr_SFI.szTypeName)
//End If
//
//If ls_typename = "" Then
//	ls_regkey = "HKEY_CLASSES_ROOT\." + ls_extn
//	RegistryGet(ls_regkey, "", RegString!, ls_regvalue)
//	If ls_regvalue <> "" Then
//		ls_regkey = "HKEY_CLASSES_ROOT\" + ls_regvalue
//		RegistryGet(ls_regkey, "", RegString!, ls_typename)
//	End If
//End If
//
//If ls_typename = "" Then
//	ls_typename = Upper(ls_extn) + " File"
//End If
//
Return ls_typename
end function

public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha, ref string ps_msg);If Not of_Conecta_Ftp(p_aplicacao, p_servername, p_usuario, p_senha, '0', ref ps_msg) Then
	ivs_Msg=ps_msg
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_Msg)
	Return False
End If

Return True
end function

public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha);If Not of_Conecta_Ftp(p_aplicacao, p_servername, p_usuario, p_senha, ref ivs_Msg) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_Msg)
	Return False
End If

Return True
end function

public function boolean of_conecta_ftp (string p_aplicacao, string p_servername, string p_usuario, string p_senha, string p_porta_ftp, ref string ps_msg);/*----------------------------------------------------------------------------------*/
/* FAZ A CONEX$$HEX1$$c300$$ENDHEX$$O COM O SERVIDOR PARA TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA VIA FTP */
/* PAR$$HEX1$$c200$$ENDHEX$$METROS: p_aplicacao: Nome da aplica$$HEX2$$e700e300$$ENDHEX$$o
p_servername: 'ftp.zzzzz.com.br' ou endere$$HEX1$$e700$$ENDHEX$$o IP Ex.: '255.255.255.255'
p_usuario e p_senha*/

string vlsnulo
long ll_porta

setnull(vlsnulo)
uos_servidor = p_servername
uos_usuario= p_usuario
uos_senha = p_senha
uos_aplicacao = p_aplicacao
uos_ftp_dir = ''

uol_hnd_open = internetopena(uos_aplicacao , 1, vlsnulo, vlsnulo, 0)
if uol_hnd_open = 0 or isnull(uol_hnd_open) then
	ps_msg = "Erro ao abrir a conex$$HEX1$$e300$$ENDHEX$$o com o servidor ftp: " + p_servername + ". Fun$$HEX2$$e700e300$$ENDHEX$$o API InternetOpen. ~r~r" + &
				"1) Feche o sistema, abra novamente e tente refazer a a$$HEX2$$e700e300$$ENDHEX$$o solicitada. ~r~r" + &
				"2) Cheque a conex$$HEX1$$e300$$ENDHEX$$o com a internet. ~r~r" + &
				"3) Aguarde alguns minutos at$$HEX1$$e900$$ENDHEX$$ reestabelecer a conex$$HEX1$$e300$$ENDHEX$$o com o FTP. ~r~r" + &
				"4) Acesso via navegador o endere$$HEX1$$e700$$ENDHEX$$o: " + p_servername + " ap$$HEX1$$f300$$ENDHEX$$s isso entre em contato com a TI reportando o problema."
	return False
end if

If Pos(lower(uos_servidor), 'ftp://') > 0 Then
	uos_servidor = gf_replace(lower(uos_servidor), 'ftp://', '', 0)
End If
	
If IsNull(p_porta_ftp) or trim(p_porta_ftp)=''  Then
    ll_porta = 0 
Else 
	ll_porta = long(p_porta_ftp)				
End If

uol_hnd_conexao = internetconnecta( uol_hnd_open, uos_servidor, ll_porta, uos_usuario, uos_senha, 1, INTERNET_FLAG_PASSIVE, 0)

if uol_hnd_conexao = 0 or isnull(uol_hnd_conexao) then
	ps_msg = "Erro ao abrir a conex$$HEX1$$e300$$ENDHEX$$o com o servidor ftp: " + p_servername + ". Fun$$HEX2$$e700e300$$ENDHEX$$o API InternetConnect"
	internetclosehandle( uol_hnd_open)
	return False
end if

return True
end function

on dc_uo_ftp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_ftp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_api = Create dc_uo_api
end event

event destructor;Destroy(ivo_Api)
end event

