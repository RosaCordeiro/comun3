HA$PBExportHeader$dc_uo_api.sru
forward
global type dc_uo_api from nonvisualobject
end type
type process_information from structure within dc_uo_api
end type
type startupinfo from structure within dc_uo_api
end type
type shellexecuteinfo from structure within dc_uo_api
end type
type str_systemtime from structure within dc_uo_api
end type
type icmp_echo_reply from structure within dc_uo_api
end type
type hostent from structure within dc_uo_api
end type
type str_systemtimestructure from structure within dc_uo_api
end type
type str_ipaddrrow from structure within dc_uo_api
end type
type str_ipaddrtable from structure within dc_uo_api
end type
type str_ipnetrow from structure within dc_uo_api
end type
type str_ipnettable from structure within dc_uo_api
end type
type str_ipnettable1 from structure within dc_uo_api
end type
type str_mac from structure within dc_uo_api
end type
type shfileinfo from structure within dc_uo_api
end type
end forward

type process_information from structure
	long		hprocess
	long		hthread
	long		dwprocessid
	long		dwthreadid
end type

type startupinfo from structure
	long		cb
	string		lpreserved
	string		lpdesktop
	string		lptitle
	long		dwx
	long		dwy
	long		dwxsize
	long		dwysize
	long		dwxcountchars
	long		dwycountchars
	long		dwfillattribute
	long		dwflags
	long		wshowwindow
	long		cbreserved2
	long		lpreserved2
	long		hstdinput
	long		hstdoutput
	long		hstderror
end type

type shellexecuteinfo from structure
	long		cbsize
	long		fmask
	long		hwnd
	string		lpverb
	string		lpfile
	string		lpparameters
	string		lpdirectory
	long		nshow
	long		hinstapp
	long		lpidlist
	string		lpclass
	long		hkeyclass
	long		hicon
	long		hmonitor
	long		hprocess
end type

type str_systemtime from structure
	uint year
	uint month
	uint dayweek
	uint day
	uint hour
	uint min
	uint sec
	uint millsec
end type

type icmp_echo_reply from structure
	unsignedlong		address
	unsignedlong		status
	unsignedlong		roundtriptime
	unsignedlong		datasize
	unsignedlong		reserved[3]
	character		data[]
end type

type hostent from structure
	unsignedlong		h_name
	unsignedlong		h_aliases
	integer		h_addrtype
	integer		h_length
	unsignedlong		h_addr_list
end type

type str_ipaddrrow from structure
	long		addr
	long		interface
	long		m
	long		b
	long		as
	integer		u1
	integer		u2
end type

type str_ipaddrtable from structure
	long		numentries
	str_ipaddrrow		table[6]
end type

type str_ipnetrow from structure
	long		index
	long		physaddrlen
	character		bphysaddr[8]
	long		addr
	long		iptype
end type

type str_ipnettable from structure
	long		numentries
	str_ipnetrow		table[255]
end type

type str_ipnettable1 from structure
	long		numentries
	long		asd
end type

type str_mac from structure
	character		mac[8]
end type

type shfileinfo from structure
	long		hicon
	long		iicon
	long		dwattributes
	character		szdisplayname[260]
	character		sztypename[80]
end type

global type dc_uo_api from nonvisualobject
end type
global dc_uo_api dc_uo_api

type prototypes
// Instala fonte no sistema operacional
Function int AddFontResourceW( string lpFileName ) library "gdi32.dll"

Subroutine Sleep (ulong dwMilliseconds) Library "Kernel32.DLL"
FUNCTION long SetLocalTime(ref str_systemtime lpSystemTime ) LIBRARY "kernel32.dll"

//Informacoes do computador
Function boolean GetUserNameA(ref string  lpBuffer, ref ulong nSize) library "Advapi32.dll" alias for "GetUserNameA;Ansi"
Function boolean GetComputerNameA(ref string  lpBuffer, ref ulong nSize) library "kernel32.dll" alias for "GetComputerNameA;Ansi"

FUNCTION ulong 	 CreateFileA(string Arquivo,unsignedlong dwDesiredAccess, unsignedlong dwShareMode, long lpSecurityAttributes, unsignedlong dwCreationDistribution, unsignedlong dwFlagsAndAttributes, unsignedlong hTemplateFile) library "Kernel32.dll" alias for "CreateFileA;Ansi"
FUNCTION boolean CreateDirectoryA(string lpPathName,int lpSecurityAttributes)library "Kernel32.dll" alias for "CreateDirectoryA;Ansi"
FUNCTION boolean RemoveDirectoryA( ref string lpPathName )LIBRARY "kernel32.dll" alias for "RemoveDirectoryA;Ansi" 
FUNCTION boolean MoveFileA(string lpExistingFileName,string lpNewFileName)library "Kernel32.dll" alias for "MoveFileA;Ansi"
FUNCTION boolean CopyFileA(ref string cfrom, ref string cto, boolean flag) LIBRARY "Kernel32.dll" alias for "CopyFileA;Ansi"
FUNCTION boolean DeleteFileA(ref string filename) LIBRARY "Kernel32.dll" alias for "DeleteFileA;Ansi" 
FUNCTION boolean Beep(long freq,long dur) LIBRARY "Kernel32.dll"
FUNCTION boolean CloseWindow(ulong w_handle) LIBRARY "User32.dll"
FUNCTION boolean SetActiveWindow(ulong w_handle) LIBRARY "User32.dll"
FUNCTION ulong 	 GetActiveWindow() LIBRARY "User32.dll"
FUNCTION ulong 	 GetForegroundWindow() LIBRARY "User32.dll"
FUNCTION ulong 	 FindWindowA(ulong classname,string windowname) LIBRARY "User32.dll" alias for "FindWindowA;Ansi"
FUNCTION ulong 	 FindWindow(ref string  classname, ref string windowname)  LIBRARY "user32.dll" ALIAS FOR "FindWindowA;Ansi"
FUNCTION boolean BringWindowToTop(ulong w_handle) LIBRARY "User32.dll"
FUNCTION boolean UpdateWindow(ulong w_handle) LIBRARY "User32.dll"
FUNCTION boolean ShowWindow(ulong w_handle, integer nCmdSow) LIBRARY "User32.dll"
FUNCTION boolean SetForegroundWindow( ulong hWnd ) LIBRARY "USER32.DLL"
FUNCTION boolean GetFileTime (ulong hFile, ref FILETIME lpCreationTime, ref FILETIME lpLastAccessTime, ref FILETIME lpLastWriteTime) Library "KERNEL32.DLL" alias for "GetFileTime;Ansi"
FUNCTION boolean GetComputerName (ref string  lpBuffer, ref ulong nSize) Library "KERNEL32.DLL" alias for "GetComputerName;Ansi"
FUNCTION ulong     FindFirstFile (string lpFileName, ref WIN32_FIND_DATAA lpFindFileData) Library "KERNEL32.DLL" Alias for "FindFirstFileA;Ansi"
FUNCTION boolean FileTimeToSystemTime (ref FILETIME lpFileTime, ref SYSTEMTIME lpSystemTime) Library "KERNEL32.DLL" alias for "FileTimeToSystemTime;Ansi"
FUNCTION boolean FileTimeToLocalFileTime (ref FILETIME lpFileTime, ref FILETIME lpLocalFileTime) Library "KERNEL32.DLL" alias for "FileTimeToLocalFileTime;Ansi"
FUNCTION long 	 ShellExecute( long hwnd,  string lpOperation,  string lpFile, string lpParameters,  string lpDirectory, integer nShowCmd ) LIBRARY "SHELL32"  alias for "ShellExecuteA;Ansi"
FUNCTION int 		 GetModuleFileNameA(ulong hinstModule, REF string lpszPath,ulong cchPath) LIBRARY "kernel32"  alias for "GetModuleFileNameA;Ansi"
FUNCTION long 	 GetCurrentProcessId()  LIBRARY "kernel32.dll" alias for "GetCurrentProcessId;Ansi"

FUNCTION Boolean CreateProcess (String lpApplicationName, String lpCommandLine, long lpProcessAttributes, long lpThreadAttributes, Boolean bInheritHandles, long dwCreationFlags, long lpEnvironment, String lpCurrentDirectory, STARTUPINFO lpStartupInfo, Ref PROCESS_INFORMATION lpProcessInformation) Library "kernel32.dll" Alias For "CreateProcessW;Ansi"	
FUNCTION long 	 WaitForSingleObject(long hHandle, long dwMilliseconds) Library "kernel32.dll"
FUNCTION Boolean CloseHandle(long hObject) Library "kernel32.dll"
FUNCTION Boolean GetExitCodeProcess(long hProcess, Ref long lpExitCode) Library "kernel32.dll"
FUNCTION Boolean TerminateProcess(long hProcess, long uExitCode) Library "kernel32.dll"
FUNCTION Boolean ShellExecuteEx(Ref SHELLEXECUTEINFO lpExecInfo) Library "shell32.dll" Alias For "ShellExecuteExW"
FUNCTION Long 	 ExpandEnvironmentStrings (String lpSrc,Ref String lpDst, Long nSize) Library "kernel32.dll" Alias For "ExpandEnvironmentStringsW"

FUNCTION integer WSACleanup ()  Library "wsock32.dll"  
FUNCTION integer WSAAsyncSelect (uint socket, uint Wnd, uint wMsg, long lEvent) Library "wsock32.dll"  
FUNCTION integer WSACancelBlockingCall () Library "wsock32.dll"  
FUNCTION integer WSAGetLastError () Library "wsock32.dll"  
FUNCTION integer WSAStartup (uint wVersionRequested, ref wsadata lpWSAData) Library "wsock32.dll" alias for "WSAStartup;Ansi"  

FUNCTION long gethostname (Ref string hostname,long HostLen) Library "wsock32.dll" alias for "gethostname;Ansi"  
FUNCTION long gethostbyname (Ref string hostname) Library "wsock32.dll" alias for "gethostbyname;Ansi" 
FUNCTION string GetHost(string lpszhost, ref blob lpszaddress ) library "pbws32.dll" alias for "GetHost;Ansi" 

//Tocar som
FUNCTION boolean sndPlaySoundA (string SoundName, int Flags) LIBRARY "WINMM.DLL" alias for "sndPlaySoundA;Ansi"
FUNCTION uint waveOutGetNumDevs () LIBRARY "WINMM.DLL"

//Gerar MD5 de arquivo
FUNCTION Long md5FromFile(String cNomeArquivo, Ref String cMD5) LIBRARY "c:\sistemas\dll\bematech\sign_bema.dll" alias for "md5FromFile;Ansi";

//Resolu$$HEX2$$e700e300$$ENDHEX$$o Monitor
FUNCTION int GetSystemMetrics(int indexnum) LIBRARY "user32.dll"

// Captura os millisegundos desde a ultima inicializacao do so
FUNCTION Long GetTickCount( )  Library "kernel32.dll"
FUNCTION LongLong GetTickCount64( )  Library "kernel32.dll"

//Ping
//Function integer WSAGetLastError() Library "ws2_32.dll"  
Function ulong inet_addr (string cp ) Library "ws2_32.dll" Alias for "inet_addr;Ansi"
Function ulong IcmpCreateFile ( ) Library "icmp.dll"
Function long IcmpSendEcho (ulong IcmpHandle, ulong DestinationAddress, string RequestData, long RequestSize, long RequestOptions, Ref icmp_echo_reply ReplyBuffer, long ReplySize, long Timeout ) Library "icmp.dll" Alias for "IcmpSendEcho"
Function long IcmpCloseHandle (ulong IcmpHandle) Library "icmp.dll"
Subroutine CopyMemoryIP (	Ref hostent Destination, ulong Source, long Length) Library  "kernel32.dll" Alias For "RtlMoveMemory"
Subroutine CopyMemoryIP (	Ref blob Destination, ulong Source, long Length) Library  "kernel32.dll" Alias For "RtlMoveMemory"
Subroutine CopyMemoryIP (	Ref ulong Destination, ulong Source, 	long Length	) Library  "kernel32.dll" Alias For "RtlMoveMemory"

// Capturar MAC address
FUNCTION long GetIpAddrTable( ref str_ipaddrtable llll, ref long addr_len, boolean ip_sort ) LIBRARY "iphlpapi.dll" alias for "GetIpAddrTable;Ansi"
FUNCTION LONG GetIpNetTable( ref str_ipnettable llll, ref long addr_len, boolean ip_sort ) LIBRARY "iphlpapi.dll" alias for "GetIpNetTable;Ansi"	
FUNCTION LONG DeleteIpNetEntry( ref str_ipnetrow ip ) LIBRARY "iphlpapi.dll" alias for "DeleteIpNetEntry;Ansi"	
FUNCTION LONG FlushIpNetTable(long ip) LIBRARY "iphlpapi.dll"
FUNCTION LONG SendARP( long ip, long ipsur, ref str_mac str, ref long len) LIBRARY "iphlpapi.dll" alias for "SendARP;Ansi"

Function ulong SHGetFileInfo ( &
	string pszPath, &
	long dwFileAttributes, &
	Ref SHFILEINFO psfi, &
	long cbFileInfo, &
	long uFlags &
	) Library "shell32.dll" Alias For "SHGetFileInfoW;Ansi"
end prototypes

type variables
Private:
uo_windows_version ivo_SO
end variables

forward prototypes
public function boolean of_delete_file (string ps_arquivo)
public subroutine of_som_alerta ()
public subroutine of_som_erro ()
public function boolean of_ativa_janela (window pw_janela)
public function boolean of_move_file (string ps_nome_origem, string ps_nome_destino)
public function boolean of_maximiza_janela (window pw_janela)
public function boolean of_verifica_janela_ativa (string ps_titulo)
public subroutine of_nome_computador (ref string ps_computador)
public function boolean of_copy_file (string ps_nome_origem, string ps_nome_destino, boolean pb_sobrescrever, boolean pb_mensagem)
public function boolean of_copy_file (string ps_nome_origem, string ps_nome_destino, boolean pb_sobrescrever)
public function datetime of_data_arquivo (string ps_arquivo)
public function boolean of_create_directory (string ps_arquivo)
public function boolean of_remove_directory (string ps_arquivo)
public function boolean of_maximiza_janela (string ps_janela)
public function string of_get_ip_number ()
public function boolean of_move_file (string ps_nome_origem, string ps_nome_destino, ref string ps_mensagem)
public function boolean of_move_file (string ps_nome_origem, string ps_nome_destino, boolean pb_sobrepor)
public function boolean of_rename_file (string ps_nome_antigo, string ps_nome_novo, boolean pb_sobrepor)
public function boolean of_rename_file (string ps_nome_antigo, string ps_nome_novo)
public function boolean of_unzip (string ps_origem, string ps_destino)
public function boolean of_delete_file (string ps_arquivo, boolean pb_mensagem)
public function long of_alerta_sonoro (string ps_file)
public function boolean of_move_file (string ps_nome_origem, string ps_nome_destino, boolean pb_sobrepor, boolean pb_mensagem)
public function boolean of_md5fromfile (string ps_arquivo, ref string ps_hash)
public function boolean of_shell_execute (string ps_arquivo, string ps_parametros)
public function string of_application_path ()
public function boolean of_shell_execute (string ps_arquivo, string ps_parametros, string ps_diretorio)
public function long of_retorna_janela_ativa ()
public function boolean of_unzip (string ps_origem, string ps_destino, boolean pb_sobrepor)
public function long of_alerta_sonoro2 (string ps_file)
public function boolean of_minimiza_janela (string ps_janela)
public function string of_get_diretorio_ghostscript ()
public function boolean of_run_and_wait (string ps_aplicacao, string ps_parametros, integer pl_timeout)
public function boolean of_addprinter (string ps_infname, string ps_drvname, string ps_ptrname)
public function boolean of_printer_pdf_installed ()
public function boolean of_ping (string as_ipaddress)
public function string of_getip_host (string as_hostname)
public function boolean of_unzip (string ps_origem, string ps_destino, boolean pb_sobrepor, boolean pb_manter_estrutura)
public function boolean of_set_system_datetime (datetime pdh_data)
public function string of_uptime ()
public function string of_long2hex (long al_number, integer ai_digit)
public function string of_getmac ()
public function string of_get_user_name ()
public function long of_get_idprocess ()
public function string of_get_host ()
public function string of_get_filedescription (string ps_arquivo)
public function string of_get_mac ()
public subroutine of_find_window ()
public function unsignedinteger of_find_window (string ps_classe, string ps_nome)
public function boolean of_fecha_aplicacao (string ps_classe, string ps_nome)
public subroutine of_kill_process (string ps_processo)
end prototypes

public function boolean of_delete_file (string ps_arquivo);Return of_Delete_File(ps_arquivo, True)
end function

public subroutine of_som_alerta ();
//Alerta
Beep(500,20)

end subroutine

public subroutine of_som_erro ();
//Alerta
Beep(500,20)

end subroutine

public function boolean of_ativa_janela (window pw_janela);Long lvl_Handle

lvl_Handle = Handle(pw_janela)

If ShowWindow(lvl_Handle,5) Then
	If BringWindowToTop(lvl_Handle) Then
		If SetActiveWindow(lvl_Handle) Then
			If SetForegroundWindow(lvl_Handle) Then				
				If UpdateWindow(lvl_Handle) Then
					Return True
				End If
			End If	
		End If
	End If
End If

Return False
end function

public function boolean of_move_file (string ps_nome_origem, string ps_nome_destino);// PARAMETROS
// ps_nome_origem  = Nome Arquivo Origem
// ps_nome_destino = Nome Arquivo Destino

BOOLEAN lvb_Retorno

lvb_Retorno = MoveFileA(ps_nome_origem,ps_nome_destino)

	IF NOT lvb_Retorno THEN
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao mover arquivo " + ps_nome_origem + " para " + ps_nome_destino , StopSign!)
	END IF	
RETURN lvb_Retorno
end function

public function boolean of_maximiza_janela (window pw_janela);Long    lvl_Handle
Boolean lvb_Status

lvl_Handle = Handle(pw_janela)

lvb_Status = SetActiveWindow(lvl_Handle)

If Not lvb_Status Then Return False

SetActiveWindow(lvl_Handle)
BringWindowToTop(lvl_Handle)

lvb_Status = ShowWindow(lvl_Handle,4)

Return lvb_Status
end function

public function boolean of_verifica_janela_ativa (string ps_titulo);INTEGER lvi_Retorno

lvi_Retorno = FindWindowA(0, ps_titulo)

If lvi_Retorno > 0 Then	Return True

Return False

end function

public subroutine of_nome_computador (ref string ps_computador);STRING  lvs_Nome   
ULONG   lvl_Buffer = 255

lvs_Nome = SPACE(lvl_Buffer)

If GetComputerName(Ref lvs_Nome,Ref lvl_Buffer) Then
	ps_computador = lvs_Nome
Else
	ps_computador = ''
End If

end subroutine

public function boolean of_copy_file (string ps_nome_origem, string ps_nome_destino, boolean pb_sobrescrever, boolean pb_mensagem);// PARAMETROS
// ps_nome_origem  = Nome Arquivo Origem
// ps_nome_destino = Nome Arquivo Destino
// pb_sobrescrever = Flag (FALSE) Subscreve j$$HEX1$$e100$$ENDHEX$$ existente

BOOLEAN lvb_Retorno 

lvb_Retorno = CopyFileA(ps_nome_origem,ps_nome_destino,pb_sobrescrever)

IF NOT lvb_Retorno THEN
	If pb_Mensagem and (Not gvb_Auto) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao copiar arquivo " + ps_nome_origem + " para " + ps_nome_destino , StopSign!)
	Else
		gvo_aplicacao.Of_Grava_log(This.ClassName()+".of_copy_file(): Erro ao copiar arquivo " + ps_nome_origem + " para " + ps_nome_destino)
	End If
END IF	

RETURN lvb_Retorno
end function

public function boolean of_copy_file (string ps_nome_origem, string ps_nome_destino, boolean pb_sobrescrever);Return  of_Copy_File(ps_nome_origem, ps_nome_destino, pb_sobrescrever, True)
end function

public function datetime of_data_arquivo (string ps_arquivo);//Retorna a data de um arquivo - (Data modificado)

DateTime lvdt_Arquivo

WIN32_Find_DataA	lfd_lpFindFileData, lfd_lpFindFileData_Local
SystemTime	lst_lpSystemTime

FindFirstFile (ps_Arquivo, lfd_lpFindFileData)
FileTimeToLocalFileTime(lfd_lpFindFileData.ftlastwritetime, lfd_lpFindFileData_Local.ftlastwritetime)

If FileTimeToSystemTime (lfd_lpFindFileData_Local.ftlastwritetime, lst_lpSystemTime) then
	lvdt_Arquivo = datetime(date(lst_lpSystemTime.wyear, &
		lst_lpSystemTime.wmonth, lst_lpSystemTime.wday),time(lst_lpSystemTime.whour, &
		lst_lpSystemTime.wminute, lst_lpSystemTime.wsecond))
End If

Return lvdt_Arquivo
end function

public function boolean of_create_directory (string ps_arquivo);// PARAMETROS
// ps_arquivo  = Nome Arquivo

BOOLEAN lvb_Retorno

//If Security_Attributes is NULL Then
//End If
	
lvb_Retorno = CreateDirectoryA(ps_arquivo,0)

//IF NOT lvb_Retorno THEN
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio " + ps_arquivo, StopSign!)
//END IF	

RETURN lvb_Retorno
end function

public function boolean of_remove_directory (string ps_arquivo);// PARAMETROS
// ps_arquivo  = Nome Arquivo
// n$$HEX1$$e300$$ENDHEX$$o pode haver arquivos no diret$$HEX1$$f300$$ENDHEX$$rio

BOOLEAN lvb_Retorno

lvb_Retorno = RemoveDirectoryA(ps_arquivo)

//IF NOT lvb_Retorno THEN
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao remover o diret$$HEX1$$f300$$ENDHEX$$rio " + ps_arquivo, StopSign!)
//END IF	

RETURN lvb_Retorno
end function

public function boolean of_maximiza_janela (string ps_janela);
Ulong   lvl_Handle

Boolean lvb_Retorno

lvl_Handle = FindWindowA(0,ps_janela)

SetActiveWindow(lvl_Handle)
BringWindowToTop(lvl_Handle)

lvb_Retorno = ShowWindow(lvl_Handle,4)

Return lvb_Retorno




end function

public function string of_get_ip_number ();wsadata	WSAData
string	ls_HostName = space(128)
string	ls_IpAddress
int		li_version = 257
blob{4} 	lb_hostaddress 
String ls_errmsg
Blob lblb_ipaddr
hostent lstr_host
ULong lul_ptr, lul_ipaddr

Try
	If FileExists("pbws32.dll") Then
	
		/* Then, create a session, based on the winsock version. This version number consists of two part, a major and minor release number, both represented in a byte. So, version 1.1 gives us an integer version of 257 ( 256 + 1 ) */
		IF wsastartup ( li_version, WSAData ) = 0 THEN
		/* the wsadata structure contains several information. The description element tells us the winsock version */
			//messagebox("Winsock Version", l_WSAData.description )
		/* Now, let's find out what the hostname is of the current machine we're working on */
			IF gethostname ( ls_HostName, LenA(ls_HostName) ) < 0 THEN
				messagebox("Erro ao verificar GetHostName",WSAGetLastError())
			ELSE
		/* With the hostname, call the DLL function and map the IP-address pointers to a PB blob variable, with a length of 4 bytes. This is done because the internal structure contains 4 pointers, each pointer point to one of the parts of the IP-address. An IP-address namely, consists of 4 bytes */
			//	Messagebox("Hostname", ls_HostName)
				GetHost(ls_HostName, lb_HostAddress)
		/* Convert the pointers to scalars, and concatenate them to one string, the IP-address */
				ls_IpAddress = string(AscA(string(blobmid(lb_HostAddress,1,1),EncodingANSI!))) + "."
				ls_IpAddress += string(AscA(string(blobmid(lb_HostAddress,2,1),EncodingANSI!))) + "."
				ls_IpAddress += string(AscA(string(blobmid(lb_HostAddress,3,1),EncodingANSI!))) + "."
				ls_IpAddress += string(AscA(string(blobmid(lb_HostAddress,4,1),EncodingANSI!)))
				
	
				//Messagebox("Ip Address", ls_IpAddress )
			END IF
		/* We're finished, clean up the mess we made */
			WSACleanup()
		ELSE
			messagebox("GetHostName",WSAGetLastError())
		END IF 
	Else
		gethostname ( ls_HostName, LenA(ls_HostName) )
		// get information about host
		lul_ptr = gethostbyname(ls_HostName)
		
		If lul_ptr > 0 Then
			// copy structure to local structure
			CopyMemoryIP(lstr_host, lul_ptr, 16)
			// get memory address where ipaddress is located
			CopyMemoryIP(lul_ipaddr, lstr_host.h_addr_list, 4)
			// copy ipaddress to local blob
			lblb_ipaddr = Blob(Space(4),EncodingAnsi!)
			CopyMemoryIP(lblb_ipaddr, lul_ipaddr, 4)
			// convert blob to string ip address
			ls_ipaddress  = String(AscA(String(BlobMid(lblb_ipaddr,1,1),EncodingAnsi!)),"##0") + "."
			ls_ipaddress += String(AscA(String(BlobMid(lblb_ipaddr,2,1),EncodingAnsi!)),"##0") + "."
			ls_ipaddress += String(AscA(String(BlobMid(lblb_ipaddr,3,1),EncodingAnsi!)),"##0") + "."
			ls_ipaddress += String(AscA(String(BlobMid(lblb_ipaddr,4,1),EncodingAnsi!)),"##0")
		End If
	END IF
Catch( Exception Ex )
	MessageBox( "Exception", Ex.getMessage( ), StopSign! )
	
Finally
	If IsNull(ls_IpAddress) Then ls_IpAddress = ""
End Try

Return ls_IpAddress
end function

public function boolean of_move_file (string ps_nome_origem, string ps_nome_destino, ref string ps_mensagem);// PARAMETROS
// ps_nome_origem  = Nome Arquivo Origem
// ps_nome_destino = Nome Arquivo Destino

BOOLEAN lvb_Retorno

lvb_Retorno = MoveFileA(ps_nome_origem,ps_nome_destino)

	IF NOT lvb_Retorno THEN
		ps_mensagem = "Erro ao mover arquivo " + ps_nome_origem + " para " + ps_nome_destino
	END IF

RETURN lvb_Retorno
end function

public function boolean of_move_file (string ps_nome_origem, string ps_nome_destino, boolean pb_sobrepor);// PARAMETROS
// ps_nome_origem  = Nome Arquivo Origem
// ps_nome_destino = Nome Arquivo Destino

BOOLEAN lvb_Retorno = True

If pb_Sobrepor Then
	lvb_Retorno = of_Delete_File(ps_nome_destino)
	
	If Not lvb_Retorno Then
		Return lvb_Retorno
	End If
End If

lvb_Retorno = MoveFileA(ps_nome_origem, ps_nome_destino)

	IF NOT lvb_Retorno THEN
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao mover arquivo " + ps_nome_origem + " para " + ps_nome_destino , StopSign!)
	END IF	

RETURN lvb_Retorno
end function

public function boolean of_rename_file (string ps_nome_antigo, string ps_nome_novo, boolean pb_sobrepor);BOOLEAN lvb_Retorno = True

If pb_Sobrepor Then
	lvb_Retorno = of_Delete_File(ps_nome_novo)
	
	If Not lvb_Retorno Then
		Return lvb_Retorno
	End If
End If

lvb_Retorno = MoveFileA(ps_nome_antigo,ps_nome_novo)

IF NOT lvb_Retorno THEN
	If Not gvb_Auto Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao renomear arquivo : " + ps_nome_antigo + " para " + ps_nome_novo , StopSign!) 
	Else
		gvo_aplicacao.Of_Grava_log(This.ClassName()+".of_rename_file(): Erro ao renomear arquivo : " + ps_nome_antigo + " para " + ps_nome_novo)
	End If
END IF	

RETURN lvb_Retorno
end function

public function boolean of_rename_file (string ps_nome_antigo, string ps_nome_novo);BOOLEAN lvb_Retorno = True

lvb_Retorno = MoveFileA(ps_nome_antigo,ps_nome_novo)

IF NOT lvb_Retorno THEN
	If Not gvb_Auto Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao renomear arquivo : " + ps_nome_antigo + " para " + ps_nome_novo , StopSign!) 
	Else
		gvo_aplicacao.Of_Grava_log(This.ClassName()+".of_rename_file(): Erro ao renomear arquivo : " + ps_nome_antigo + " para " + ps_nome_novo)
	End If
END IF	

RETURN lvb_Retorno
end function

public function boolean of_unzip (string ps_origem, string ps_destino);Return This.of_UnZip( ps_Origem, ps_Destino, TRUE )


end function

public function boolean of_delete_file (string ps_arquivo, boolean pb_mensagem);BOOLEAN lvb_Retorno = True

If FileExists(ps_arquivo) Then

	lvb_Retorno = DeleteFileA(ps_arquivo)
	If Not lvb_Retorno Then
		If pb_mensagem and (Not gvb_Auto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao deletar arquivo " + ps_arquivo , StopSign!)	
		Else
			gvo_aplicacao.Of_Grava_log(This.ClassName()+".of_delete_file(): Erro ao deletar arquivo " + ps_arquivo)
		End If
	End If
	
	gf_delay(1)
		
End If	

RETURN lvb_Retorno
end function

public function long of_alerta_sonoro (string ps_file);uint lui_numdevs

lui_numdevs = WaveOutGetNumDevs() 

IF lui_numdevs > 0 THEN 
	sndPlaySoundA(ps_file, 1)
	RETURN 1
ELSE
	RETURN -1
END IF
end function

public function boolean of_move_file (string ps_nome_origem, string ps_nome_destino, boolean pb_sobrepor, boolean pb_mensagem);// PARAMETROS
// ps_nome_origem  = Nome Arquivo Origem
// ps_nome_destino = Nome Arquivo Destino

BOOLEAN lvb_Retorno = True

If pb_Sobrepor Then
	lvb_Retorno = of_Delete_File(ps_nome_destino, pb_Mensagem)
	
	If Not lvb_Retorno Then
		Return lvb_Retorno
	End If
End If

lvb_Retorno = MoveFileA(ps_nome_origem, ps_nome_destino)

	IF NOT lvb_Retorno THEN
		If pb_Mensagem and (not gvb_Auto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao mover arquivo " + ps_nome_origem + " para " + ps_nome_destino , StopSign!)
		Else
			gvo_aplicacao.Of_Grava_log(This.ClassName()+".of_move_file(): Erro ao mover arquivo : " + ps_nome_origem + " para " + ps_nome_destino)
		End If	
	END IF	

RETURN lvb_Retorno
end function

public function boolean of_md5fromfile (string ps_arquivo, ref string ps_hash);//Necessita dll da bematech
Long ll_Retorno

If Not FileExists( ps_Arquivo ) Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', "Arquivo '" + ps_Arquivo + "' n$$HEX1$$e300$$ENDHEX$$o localizado para gerar MD5" )
	Return False
End If

ps_Hash		= Space( 33 )
ll_Retorno	= md5FromFile( ps_Arquivo, Ref ps_Hash )

If ll_Retorno = 1 Then
	Return True
End If

Return False
end function

public function boolean of_shell_execute (string ps_arquivo, string ps_parametros);ShellExecute(Handle(This), 'open', ps_arquivo, ps_parametros, '', 1);

Return True
end function

public function string of_application_path ();string lvs_Path
unsignedlong lul_handle

lvs_Path = Space(1024)

lul_handle = Handle(GetApplication())
GetModuleFilenameA(lul_handle, lvs_Path, 1024)

Return lvs_Path
end function

public function boolean of_shell_execute (string ps_arquivo, string ps_parametros, string ps_diretorio);ShellExecute(Handle(This), 'open', ps_arquivo, ps_parametros, ps_diretorio, 1);

Return True
end function

public function long of_retorna_janela_ativa ();//Fun$$HEX2$$e700e300$$ENDHEX$$o para retornar o codigo(handle) da janela ativa no windows.
Long ll_Retorno

ll_Retorno = GetForegroundWindow()

Return ll_Retorno

end function

public function boolean of_unzip (string ps_origem, string ps_destino, boolean pb_sobrepor);Boolean lb_sucesso = True

String lvs_Error

dc_uo_zip lvo_Zip
lvo_Zip = Create dc_uo_zip

lvo_Zip.of_UnZip_Origem(ps_Origem)
lvo_Zip.of_UnZip_Destino(ps_Destino)
lvs_Error = lvo_Zip.of_UnZip( pb_Sobrepor )

If lvs_Error <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Error, StopSign!)
	lb_sucesso = False
End If
	
Destroy lvo_Zip

Return lb_Sucesso


end function

public function long of_alerta_sonoro2 (string ps_file);uint lui_numdevs

//lui_numdevs = WaveOutGetNumDevs() 

lui_numdevs = 1

IF lui_numdevs > 0 THEN 
	If sndPlaySoundA(ps_file, 1) Then
		RETURN 1
	Else
		RETURN -1
	End If
ELSE
	RETURN -1
END IF
end function

public function boolean of_minimiza_janela (string ps_janela);Ulong   lvl_Handle

Boolean lvb_Retorno = True

lvl_Handle = FindWindowA( 0, ps_janela )

CloseWindow( lvl_Handle )

Return lvb_Retorno




end function

public function string of_get_diretorio_ghostscript ();//window lw_1
ListBox lb_emp

String lvs_Dir[]
String lvs_Diretorio = ''

Long lvl_Aux

//Diret$$HEX1$$f300$$ENDHEX$$rios poss$$HEX1$$ed00$$ENDHEX$$veis para instala$$HEX2$$e700e300$$ENDHEX$$o padr$$HEX1$$e300$$ENDHEX$$o do programa
lvs_Dir = {'C:\Program Files\','C:\Arquivos de Programas\','C:\Program Files (x86)\','C:\Arquivos de Programas (x86)\'}

Open( w_aguarde )
w_aguarde.Visible = False
w_aguarde.OpenUserObject(lb_emp)

For  lvl_Aux = 1 To UpperBound(lvs_Dir) 
	//Diret$$HEX1$$f300$$ENDHEX$$rio Existe?
	If DirectoryExists(lvs_Dir[lvl_Aux]+'gs\') Then 
		//Listagem de subdiret$$HEX1$$f300$$ENDHEX$$rios foi conclu$$HEX1$$ed00$$ENDHEX$$da?
		If lb_emp.DirList(lvs_Dir[lvl_Aux]+'gs\',16) Then
			//Retornou items?
			If lb_emp.TotalItems()>1 Then 											// Considera o segundo item da lista pois o primeiro $$HEX1$$e900$$ENDHEX$$ [..]
				lvs_Diretorio = lvs_Dir[lvl_Aux]+'gs\'+Mid(lb_emp.Text(2),2)	// Retira o primeiro caracter (Sempre um colchete)
				lvs_Diretorio = Mid(lvs_Diretorio,1,Len(lvs_Diretorio)-1)+'\' 		// Retira o $$HEX1$$fa00$$ENDHEX$$ltimo caracter (Sempre um colchete)
				Exit
			End If
		End If
	End If
Next

If lvs_Diretorio = '' Then
	For  lvl_Aux = 1 To UpperBound(lvs_Dir) 
		//Diret$$HEX1$$f300$$ENDHEX$$rio Existe?
		If DirectoryExists(lvs_Dir[lvl_Aux]+'GPLGS\') Then 
			lvs_Diretorio = lvs_Dir[lvl_Aux]+'GPLGS\'	
			Exit
		End If
	Next
End If

w_aguarde.CloseUserObject(lb_emp)
Close(w_aguarde)

Return lvs_Diretorio
end function

public function boolean of_run_and_wait (string ps_aplicacao, string ps_parametros, integer pl_timeout);CONSTANT long INFINITE				= -1
CONSTANT long WAIT_ABANDONED	= 128
CONSTANT long WAIT_COMPLETE	= 0
CONSTANT long WAIT_OBJECT_0		= 0
CONSTANT long WAIT_TIMEOUT		= 258

CONSTANT long SW_HIDE						= 0
CONSTANT long SW_SHOWNORMAL			= 1
CONSTANT long SW_NORMAL					= 1
CONSTANT long SW_SHOWMINIMIZED		= 2
CONSTANT long SW_SHOWMAXIMIZED		= 3
CONSTANT long SW_MAXIMIZE				= 3
CONSTANT long SW_SHOWNOACTIVATE	= 4
CONSTANT long SW_SHOW						= 5
CONSTANT long SW_MINIMIZE					= 6
CONSTANT long SW_SHOWMINNOACTIVE	= 7
CONSTANT long SW_SHOWNA					= 8
CONSTANT long SW_RESTORE					= 9
CONSTANT long SW_SHOWDEFAULT			= 10
CONSTANT long SW_FORCEMINIMIZE		= 11
CONSTANT long SW_MAX						= 11

CONSTANT long STARTF_USESHOWWINDOW		= 1
CONSTANT long STARTF_USESIZE					= 2
CONSTANT long STARTF_USEPOSITION				= 4
CONSTANT long STARTF_USECOUNTCHARS		= 8
CONSTANT long STARTF_USEFILLATTRIBUTE		= 16
CONSTANT long STARTF_RUNFULLSCREEN			= 32
CONSTANT long STARTF_FORCEONFEEDBACK		= 64
CONSTANT long STARTF_FORCEOFFFEEDBACK	= 128
CONSTANT long STARTF_USESTDHANDLES			= 256
CONSTANT long STARTF_USEHOTKEY				= 512

CONSTANT long CREATE_DEFAULT_ERROR_MODE	= 67108864
CONSTANT long CREATE_FORCEDOS						= 8192
CONSTANT long CREATE_NEW_CONSOLE				= 16
CONSTANT long CREATE_NEW_PROCESS_GROUP		= 512
CONSTANT long CREATE_NO_WINDOW					= 134217728
CONSTANT long CREATE_SEPARATE_WOW_VDM		= 2048
CONSTANT long CREATE_SHARED_WOW_VDM		= 4096
CONSTANT long CREATE_SUSPENDED					= 4
CONSTANT long CREATE_UNICODE_ENVIRONMENT	= 1024
CONSTANT long DEBUG_PROCESS							= 1
CONSTANT long DEBUG_ONLY_THIS_PROCESS			= 2
CONSTANT long DETACHED_PROCESS					= 8

CONSTANT long HIGH_PRIORITY_CLASS			= 128
CONSTANT long IDLE_PRIORITY_CLASS			= 64
CONSTANT long NORMAL_PRIORITY_CLASS	= 32
CONSTANT long REALTIME_PRIORITY_CLASS	= 256

STARTUPINFO lstr_si
PROCESS_INFORMATION lstr_pi
Long lvl_null
Long lvl_CreationFlags
Long lvl_ExitCode
Long lvl_msecs

String lvs_null

// Inicializa Argumentos
SetNull(lvl_null)
SetNull(lvs_null)
lstr_si.cb = 72
lstr_si.dwFlags = STARTF_USESHOWWINDOW
lstr_si.wShowWindow = SW_HIDE
lvl_CreationFlags = CREATE_NEW_CONSOLE + NORMAL_PRIORITY_CLASS

// Cria o processo
If CreateProcess(ps_aplicacao,ps_parametros, lvl_null, &
			lvl_null, False, lvl_CreationFlags, lvl_null, &
			lvs_null, lstr_si, lstr_pi) Then
	// Espera o processo ser completado?
	If pl_timeout > 0 Then
		// Espera at$$HEX1$$e900$$ENDHEX$$ o tempo terminar em milissegundos
		lvl_ExitCode = WaitForSingleObject(lstr_pi.hProcess, pl_timeout)
		// Encerrado processo por tempo excedido
		If lvl_ExitCode = WAIT_TIMEOUT Then
			TerminateProcess(lstr_pi.hProcess, -1)
			lvl_ExitCode = WAIT_TIMEOUT
		Else
			// Verifica t$$HEX1$$e900$$ENDHEX$$rmino
			GetExitCodeProcess(lstr_pi.hProcess, lvl_ExitCode)
		End If
	Else
		// Espera at$$HEX1$$e900$$ENDHEX$$ o processo terminar
		WaitForSingleObject(lstr_pi.hProcess, INFINITE)
		// Verifica sa$$HEX1$$ed00$$ENDHEX$$da objeto
		GetExitCodeProcess(lstr_pi.hProcess, lvl_ExitCode)
	End If
	// Fechar processo e threads
	CloseHandle(lstr_pi.hProcess)
	CloseHandle(lstr_pi.hThread)
Else
	// Falha
	lvl_ExitCode = -1
End If

Return (lvl_ExitCode <> -1)

Return True
end function

public function boolean of_addprinter (string ps_infname, string ps_drvname, string ps_ptrname);String lvs_cmdline

lvs_cmdline = "rundll32.exe printui.dll,PrintUIEntry /if /f ~"" + ps_infname + "~"" + &
					" /r ~"file:~" /m ~"" + ps_drvname + "~" /b ~"" + ps_ptrname + "~""

gf_run(lvs_cmdline, 0, True)

Return True

end function

public function boolean of_printer_pdf_installed ();Long lvl_rc
Long lvl_printerCount
Long lvl_x 

string lvs_printers[] 

lvl_rc = RegistryValues("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices", lvs_printers) 
If lvl_rc > 0 then 
	lvl_printerCount = UpperBound(lvs_printers) 
	For lvl_x = 1 to lvl_printerCount 
		If lvs_printers[lvl_x] = 'Sybase DataWindow PS' Then Return True
	Next 
End If 

Return False
end function

public function boolean of_ping (string as_ipaddress);// -----------------------------------------------------------------------------
// FUNCTION:	n_ping.of_Ping
//
// PURPOSE:		This function performs a 'ping' against the
//					server at the specified IP address.
//
// ARGUMENTS:	as_ipaddress	- IP address of the server
//					as_echomsg		- The text to send to server
//
// RETURN:		True = Success, False = Failed
//
// DATE			PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	--------		-----------------------------------------------------
// 03/23/2004	RolandS		Initial coding
// by http://www.topwizprogramming.com/freecode_ping.html
// -----------------------------------------------------------------------------

ULong lul_address, lul_handle
Long ll_rc, ll_size
String ls_reply
String ls_echomsg = 'abcdefg'
icmp_echo_reply lstr_reply
Integer li_TimeOut = 10000

If (IsNull(as_ipaddress))or(Trim(as_ipaddress)='') then Return False

lul_address = inet_addr(as_ipaddress)
If lul_address > 0 Then
	lstr_reply.Data[Len(ls_echomsg)] = ""
	lul_handle = IcmpCreateFile()
	ll_size = Len(ls_echomsg) * 2
	ll_rc = IcmpSendEcho(lul_handle, lul_address, &
						ls_echomsg, ll_size, 0, &
						lstr_reply, 28 + ll_size, li_TimeOut)
	IcmpCloseHandle(lul_handle)
	If ll_rc <> 0 Then
		If lstr_reply.Status = 0 Then
			ls_reply = String(lstr_reply.Data)
			If ls_reply = ls_echomsg Then
				Return True
			End If
		End If
	End If
Else
	MessageBox('Erro','Endere$$HEX1$$e700$$ENDHEX$$o IP inv$$HEX1$$e100$$ENDHEX$$lido', StopSign!)
End If

Return False
end function

public function string of_getip_host (string as_hostname);// -----------------------------------------------------------------------------
// FUNCTION:	n_ping.of_GetIPAddress
//
// PURPOSE:		This function finds the IP address for the
//					specified host name.
//
// ARGUMENTS:	as_hostname	- host name of a server
//
// RETURN:		IP Address
//
// DATE			PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	--------		-----------------------------------------------------
// 03/23/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_ipaddress = ''
String ls_errmsg
Blob lblb_ipaddr
hostent lstr_host
ULong lul_ptr, lul_ipaddr

// get information about host
lul_ptr = gethostbyname(as_hostname)

If lul_ptr > 0 Then
	// copy structure to local structure
		CopyMemoryIP(lstr_host, lul_ptr, 16)
	// get memory address where ipaddress is located
	CopyMemoryIP(lul_ipaddr, lstr_host.h_addr_list, 4)
	// copy ipaddress to local blob
	lblb_ipaddr = Blob(Space(4),EncodingAnsi!)
	CopyMemoryIP(lblb_ipaddr, lul_ipaddr, 4)
	// convert blob to string ip address
	ls_ipaddress  = String(AscA(String(BlobMid(lblb_ipaddr,1,1),EncodingAnsi!)),"##0") + "."
	ls_ipaddress += String(AscA(String(BlobMid(lblb_ipaddr,2,1),EncodingAnsi!)),"##0") + "."
	ls_ipaddress += String(AscA(String(BlobMid(lblb_ipaddr,3,1),EncodingAnsi!)),"##0") + "."
	ls_ipaddress += String(AscA(String(BlobMid(lblb_ipaddr,4,1),EncodingAnsi!)),"##0")
End If

Return ls_ipaddress
end function

public function boolean of_unzip (string ps_origem, string ps_destino, boolean pb_sobrepor, boolean pb_manter_estrutura);//pb_manter_estrutura = se o zip possui diretorios, serve para descompatar com a estrutura original.

Boolean lb_sucesso = True

String lvs_Error

dc_uo_zip lvo_Zip
lvo_Zip = Create dc_uo_zip

lvo_Zip.of_UnZip_Origem(ps_Origem)
lvo_Zip.of_UnZip_Destino(ps_Destino)
lvs_Error = lvo_Zip.of_UnZip( pb_Sobrepor, pb_manter_estrutura )

If lvs_Error <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Error, StopSign!)
	lb_sucesso = False
End If
	
Destroy lvo_Zip

Return lb_Sucesso


end function

public function boolean of_set_system_datetime (datetime pdh_data);Date	lvdt_Data
Time	lvtm_Hora

str_systemtime lstr_systemtime

lvdt_Data		= Date(pdh_data)
lvtm_Hora	= Time(pdh_data)

lstr_systemtime.year			= Year(lvdt_Data)
lstr_systemtime.month		= Month(lvdt_Data)
lstr_systemtime.dayweek	= 0     // not used
lstr_systemtime.day      		= Day(lvdt_Data)
lstr_systemtime.hour     		= Hour(lvtm_Hora)     
lstr_systemtime.min     		= Minute(lvtm_Hora)     
lstr_systemtime.sec      		= Second(lvtm_Hora)     
lstr_systemtime.millsec  		= Long(String(pdh_data,'FFF'))

Return SetLocalTime(lstr_systemtime) = 1
end function

public function string of_uptime ();/* Fernando Lu$$HEX1$$ed00$$ENDHEX$$s Cambiaghi - 29/07/2016
 * Retorna o tempo desde o ultimo boot do sistema operacional no formado Nd Nh Nmin onde:
 * N = numero, d = dias, h = horas, min = minutos
*/
LongLong ll_Milisegundos64

Long ll_Milisegundos
Long ll_Dias
Long ll_Horas
Long ll_Minutos

String ls_Retorno

Try
	ll_Milisegundos = GetTickCount( )
	
	ll_Minutos	= Mod( ( ll_Milisegundos / 60000 ), 60 )
	ll_Horas		= Mod( ( ll_Milisegundos / 3600000 ), 24 )
	ll_Dias		= ( ll_Milisegundos / 86400000 )
	
	If ll_Dias < 0 Then
		ll_Milisegundos64 = GetTickCount64( )
		
		ll_Minutos	= Mod( ( ll_Milisegundos64 / 60000 ), 60 )
		ll_Horas		= Mod( ( ll_Milisegundos64 / 3600000 ), 24 )
		ll_Dias		= ( ll_Milisegundos64 / 86400000 )
	End If
	
	If ll_Dias < 0 Then
		ls_Retorno = "Erro"
	Else
		ls_Retorno = String( ll_Dias ) + "d " + String( ll_Horas, "00" ) + "h " + String( ll_Minutos, "00" ) + "min"
	End If
	
	Return ls_Retorno
Catch( RuntimeError ru )
	//
Finally
	//
End Try
end function

public function string of_long2hex (long al_number, integer ai_digit);long ll_temp0, ll_temp1
char lc_ret

IF ai_digit > 0 THEN
   ll_temp0 = abs(al_number / (16 ^ (ai_digit - 1)))
   ll_temp1 = ll_temp0 * (16 ^ (ai_digit - 1))
   IF ll_temp0 > 9 THEN
      lc_ret = char(ll_temp0 + 55)
   ELSE
      lc_ret = char(ll_temp0 + 48)
   END IF
   RETURN lc_ret + &
          of_long2hex(al_number - ll_temp1 , ai_digit - 1)
END IF
RETURN ""
end function

public function string of_getmac ();////////////////////////////////////////////////////////////////
// 				Create by Sandy         				          //
// 				27 August 2007             				          //
////////////////////////////////////////////////////////////////
// Esta fun$$HEX2$$e700e300$$ENDHEX$$o retorna problema para alguns MACs	 //
// considere a possibilidade de utilizar a fun$$HEX2$$e700e300$$ENDHEX$$o		 //
// of_get_Mac() deste objeto								 //
////////////////////////////////////////////////////////////////
str_ipnettable lstr_table 
str_mac 			lstr_mac
long 				ll_buffer 
boolean 			lb_type
long 				ll_len
long 				ll_type, ll_inetaddr, ll_row
string 			ls_ip
string 			ls_mac = ""
Integer 			lvi_OS_Version
string 			lvs_version
string 			lvs_edition
string 			lvs_csd

ivo_SO.of_GetOSVersion(lvi_OS_Version, lvs_version, lvs_edition, lvs_csd)

ls_mac = This.Of_Get_Mac( )

Return Upper(Trim(ls_mac))
end function

public function string of_get_user_name ();string 	ls_name
ulong		lul_size = 255
boolean	lb_rc

ls_name = space(lul_size)

lb_rc = GetUserNameA( ls_name, lul_size)

if not lb_rc THEN
	return ""
else
	return ls_name
end if
end function

public function long of_get_idprocess ();long ll_pid

ll_pid = GetCurrentProcessId() 

Return ll_pid


end function

public function string of_get_host ();ulong 	lul_size = 16 // MAX_COMPUTERNAME_LENGTH + 1

boolean	lb_rc

String lvs_Host

lvs_Host = space(lul_size)

lb_rc = GetComputerNameA( lvs_Host, lul_size)

If Not lb_rc Then
	lvs_Host = "ERRO_NM_PDV_" + String( Now(), "mmss" )
	lvs_Host = ""
End If

If lvs_Host = "" Then gethostname ( ref lvs_Host, LenA(lvs_Host) )

Return lvs_Host
end function

public function string of_get_filedescription (string ps_arquivo);// -----------------------------------------------------------------------------
// SCRIPT:     of_GetFileDescription
//
// PURPOSE:    This function returns the file type description.
//
// ARGUMENTS:  ps_arquivo		- The name of the file
//
//	RETURN:		File Description
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 20/04/2012	RolandS		Initial coding
// 24/07/2017	Marlon		Adapta$$HEX2$$e700e300$$ENDHEX$$o PB12.0 Clamed
// -----------------------------------------------------------------------------

Constant Long SHGFI_ICON = 256 
Constant Long SHGFI_DISPLAYNAME = 512
Constant Long SHGFI_TYPENAME = 1024
SHFILEINFO lstr_SFI
String ls_typename, ls_extn, ls_regkey, ls_regvalue
Long ll_rc, ll_pos

ll_pos = LastPos(ps_arquivo, ".")
ls_extn = Mid(ps_arquivo, ll_pos + 1)

ll_rc = SHGetFileInfo(ps_arquivo, 0, lstr_SFI, 352, SHGFI_TYPENAME)
If ll_rc = 1 Then
	ls_typename = String(lstr_SFI.szTypeName)
End If

If ls_typename = "" Then
	ls_regkey = "HKEY_CLASSES_ROOT\." + ls_extn
	RegistryGet(ls_regkey, "", RegString!, ls_regvalue)
	If ls_regvalue <> "" Then
		ls_regkey = "HKEY_CLASSES_ROOT\" + ls_regvalue
		RegistryGet(ls_regkey, "", RegString!, ls_typename)
	End If
End If

If ls_typename = "" Then
	ls_typename = Upper(ls_extn) + " File"
End If

Return ls_typename
end function

public function string of_get_mac ();OLEObject ole_wsh
Any la_usb[]
string ls_Mac

 ole_wsh = CREATE OLEObject
 ole_wsh.ConnectToNewObject("MSScriptControl.ScriptControl")
 ole_wsh.Language = "vbscript"
 ole_wsh.AddCode('Function rtnMACAddresses()~r~n' &
 + 'MACAddressList = "" ~r~n'  &
 + 'strComputer = "."~r~n'  &
 + 'Set objWMIService = '  &
 + '   GetObject("winmgmts:{impersonationLevel=impersonate}!\\" _~r~n' &
 + '& strComputer & "\root\cimv2")~r~n' &
 + 'Set colItems = ' &
 + '  objWMIService.ExecQuery("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled = ~'TRUE~'")~r~n' &
 + 'For Each objItem in colItems~r~n' &
 + 'if MACAddressList<>"" then MACAddressList = MACAddressList & " | " ~r~n' &
 + 'MACAddressList = MACAddressList & objItem.MACAddress  ~r~n' &
 + 'Next~r~n' &
 + 'rtnMACAddresses = MACAddressList~r~n' &
 + 'End Function')
 
 ls_Mac = ole_wsh.Eval("rtnMACAddresses")
 ole_wsh.DisconnectObject()
 DESTROY ole_wsh

If Pos(ls_Mac,"|") > 0 Then
	ls_Mac = Mid(ls_Mac, 1, Pos(ls_Mac,"|")-1)
End If

Return ls_Mac
end function

public subroutine of_find_window ();
end subroutine

public function unsignedinteger of_find_window (string ps_classe, string ps_nome);///////////////////////////////////////////////////////////////////////
//   of_find_window: Retorna o Handle de uma aplica$$HEX2$$e700e300$$ENDHEX$$o	//
//////////////////////////////////////////////////////////////////////
//	Exemplo:																//
//		ps_nome = "Untitled - Notepad"							//
//		ps_classe= "Notepad"											//
//////////////////////////////////////////////////////////////////////

Return FindWindow(ps_classe, ps_nome)
	
end function

public function boolean of_fecha_aplicacao (string ps_classe, string ps_nome);ulong hWnd

hWnd = This.Of_Find_Window( ps_classe, ps_nome)

IF NOT IsNull(hWnd) THEN
    // WM_CLOSE = &H10
    Send(hWnd, 16, 0, 0)
	 
	Return True
Else
	Return False
END IF
end function

public subroutine of_kill_process (string ps_processo);OleObject wsh

wsh = CREATE OleObject
wsh.ConnectToNewObject( "MSScriptControl.ScriptControl" )
wsh.language = "vbscript"
wsh.AddCode('function terminateproc() ~n ' + &
					 'strComputer = "." ~n ' + &
					 'Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2") ~n ' + &
					 'Set colItems = objWMIService.ExecQuery("Select * from Win32_Process where ProcessId = ' + ps_processo + '") ~n ' + &
					 'For Each objItem in colItems ~n ' + &
					 '     objItem.Terminate ~n ' + &
					 'Next ~n ' + &
					 'end function ~n ' )
wsh.executestatement('terminateproc()')
wsh.DisconnectObject()

DESTROY wsh
end subroutine

on dc_uo_api.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_api.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

