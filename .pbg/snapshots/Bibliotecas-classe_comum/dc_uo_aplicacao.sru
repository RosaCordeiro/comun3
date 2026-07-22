HA$PBExportHeader$dc_uo_aplicacao.sru
forward
global type dc_uo_aplicacao from nonvisualobject
end type
end forward

global type dc_uo_aplicacao from nonvisualobject
event ue_open ( string ps_commandline )
event ue_exit ( )
event ue_idle ( )
end type
global dc_uo_aplicacao dc_uo_aplicacao

type prototypes
FUNCTION uint FindWindowA (long classname, string windowname) LIBRARY "user32.dll" alias for "FindWindowA;Ansi"
FUNCTION long GetWindowText(long hwnd, ref string lpString, long aint) LIBRARY "user32.dll" alias for "GetWindowTextA;Ansi"
FUNCTION long GetWindow(long hwnd, long aint) LIBRARY "user32.dll" alias for "GetWindow;Ansi"
FUNCTION long EnumWindows( long wndenmprc, long lParam) LIBRARY "user32.dll" alias for "EnumWindows;Ansi"
FUNCTION int GetModuleFileNameA(ulong hinstModule, REF string lpszPath, ulong cchPath) LIBRARY "kernel32"  alias for "GetModuleFileNameA;Ansi"

// User/computer information
Function boolean GetUserNameA(ref string  lpBuffer, ref ulong nSize) library "Advapi32.dll" alias for "GetUserNameA;Ansi"
function boolean GetComputerNameA(ref string  lpBuffer, ref ulong nSize) library "kernel32.dll" alias for "GetComputerNameA;Ansi"
function uint GetSystemDirectory(ref string lpBuffer,uint uSize) Library "kernel32.dll" Alias for "GetSystemDirectoryA;Ansi"
Subroutine GlobalMemoryStatus (Ref str_memorystatus astr_memorystatus) Library "KERNEL32.DLL" alias for "GlobalMemoryStatusEx" // Informa$$HEX2$$e700f500$$ENDHEX$$es sobre mem$$HEX1$$f300$$ENDHEX$$ria

SUBROUTINE ZeroMemory( REF structure lpVoid, ulong dwSizeofStruct ) LIBRARY "kernel32" ALIAS FOR "RtlZeroMemory"
FUNCTION boolean GetDiskFreeSpaceExA( string lpDirName, REF ULARGE_INTEGER lpFreeBytesToCaller, REF ULARGE_INTEGER lpTotalBytes, REF ULARGE_INTEGER lpTotalFreeBytes ) LIBRARY "kernel32.dll"

Function long SHGetFolderPath ( long hwndOwner, long nFolder, long hToken, long dwFlags, Ref string pszPath ) Library "shell32.dll" alias For "SHGetFolderPathW"

//Resolu$$HEX2$$e700e300$$ENDHEX$$o Monitor
FUNCTION int GetSystemMetrics(int indexnum) LIBRARY "user32.dll"
//Alterar posicao do cursor do mouse
FUNCTION boolean SetCursorPos(int cx, int cy)  LIBRARY "User32.dll"

//Descobrir se o SO $$HEX1$$e900$$ENDHEX$$ 64bits
FUNCTION long IsWow64Process(long hwnd, ref  boolean Wow64Process) LIBRARY "KERNEL32.DLL" alias for "IsWow64Process"
FUNCTION long GetCurrentProcess()  LIBRARY "KERNEL32.DLL" alias for "GetCurrentProcess"

end prototypes

type variables
Constant String REGEDIT_VERSOES_SISTEMAS_CLAMED = "HKEY_CURRENT_USER\SOFTWARE\DrogariaCatarinense\Versoes"

application	iapp_aplicacao
environment	ienv_ambiente

string ivs_Titulo, & 
		ivs_Versao, &
		ivs_Arquivo_INI, &
		ivs_Arquivo_LOG, &
		ivs_DataBase, &
		ivs_DataSource, &
		ivs_Path_Arquivos, &
		ivs_Janela_Ativa, &
		ivs_Path_Manual, &
		ivs_Path_Sistema, &
		ivs_CommandLine, &
		ivs_dado_extra_microhelp
		
String ivs_Servidor_BD = ""
String is_ComputerName = ""

integer ivi_log
Long	il_cd_filial
date ivdt_Data_Versao

DateTime idh_Primeiro_Alerta_Versao_Nova

dc_uo_seguranca	ivo_seguranca
uo_log_alteracao	ivo_historico		//GE321

dc_w_mdi ivw_mdi

boolean ivb_unica_execucao

boolean ib_log_aberto = false

Boolean ivb_Permite_Senha_Digitada = True // False = Obriga biometria

boolean ivb_aplicacao_padrao

boolean ivb_conectar_banco

Boolean ivb_Usa_Biometria = False
Boolean ivb_Usa_Aux_Visual = False

Boolean ivb_Abre_W_Inicial = True

Boolean ivb_Usa_Timer_Out = False

String ivs_tipo_log = 'TXT'

Boolean ivb_Forca_End_Transaction = False

Boolean ib_Selecionou_Scanner = False
Boolean ivb_mult_base_limpa = False

Integer ivi_Timer_Idle = 0

Boolean ivb_Acessou_ECF = False

String ivs_procedimento_sistema //Utilizada na tela dc_w_sort_dw

//Controla telas response abertas
Window 	 ivw_Windows[]
Protected:
DataStore ivds_Telas
String is_ODBC_Conexao_Direta

Boolean ivb_Usa_Menu = True

Boolean ivb_Alerta_Commit_Producao = False

String ivs_Tarefa = ""
end variables

forward prototypes
public function boolean of_formato_data ()
public function boolean of_appisrunning ()
public function boolean of_appisrunning (string ps_window)
public function boolean of_abre_log ()
public function boolean of_fecha_log ()
public function boolean of_grava_log (string ps_mensagem)
public function string of_getfromini (string ps_secao, string ps_chave)
public function boolean of_connect ()
public function string of_computername ()
public function string of_userid ()
public subroutine of_exclui_log_vazio (string ps_arquivo)
public function string of_get_system_directory ()
public subroutine of_registra_versao_bd ()
public function string of_get_program_files_directory ()
public function string of_application_path ()
public function string of_getprofiledirectory (string as_folder)
public function boolean of_retorna_resolucao_monitor (ref integer pl_width, ref integer pl_height)
public function boolean of_is64bits ()
public function integer of_retorna_janelas ()
public subroutine of_remove_tela (string ps_tela)
public subroutine of_insere_tela (string ps_tela)
public subroutine of_set_idle (integer pi_segudos)
public subroutine of_insere_response (window pw_window)
public subroutine of_remove_response (window pw_window)
public function boolean of_tela_aberta (string ps_titulo)
public subroutine of_get_disk_space (character ps_letra_unidade, ref decimal pdc_espaco_livre)
public function boolean of_set_posicao_mouse (long pl_x, long pl_y)
public function boolean of_controla_informacoes_pdv ()
public function datetime of_data_criacao_arquivo (string as_filename)
public subroutine of_registra_versao_bd (ref dc_uo_transacao lo_tran)
public function boolean of_get_app_usa_menu ()
public subroutine of_set_app_usa_menu (boolean pb_usa_menu)
public function boolean of_get_alerta_commit_producao ()
public subroutine of_set_alerta_commit_producao (boolean pb_alerta_commit_producao)
public subroutine of_atualiza_vv ()
public subroutine of_atualiza_vv (ref dc_uo_transacao po_tran)
public subroutine of_set_tarefa (readonly string ps_tarefa)
public subroutine of_set_odbc_conexao_direta (string as_odbc)
public function string of_get_odbc_conexao_direta ()
public subroutine of_set_tarefa_ex (readonly string ps_tarefa, string ps_opcao)
public function boolean of_grava_log_json (string ps_mensagem, string ps_nivel_log)
public function string of_json_value (string as_value)
public function boolean of_grava_log_json (string ps_mensagem)
public function boolean of_grava_log_txt (string ps_mensagem)
public function boolean of_grava_log (string ps_mensagem, string ps_nivel_log)
public subroutine of_setmicrohelp ()
public function string of_getfromini (string ps_secao, string ps_chave, boolean ab_mostra_mensagem)
end prototypes

event ue_open(string ps_commandline);Boolean lvb_Sucesso = False
String lvs_Biometria, ls_ini_filial

this.ivs_commandline = ps_commandline

// Verifica se o sistema j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ sendo executado na esta$$HEX2$$e700e300$$ENDHEX$$o
If This.ivb_Unica_Execucao Then
	If This.of_AppIsRunning() Then	
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta aplica$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ sendo executada nesta esta$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
		This.Event ue_Exit()
	End If
End If

// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia do arquivo INI
If Not FileExists(ivs_Arquivo_INI) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o '" + ivs_Arquivo_INI + "' n$$HEX1$$e300$$ENDHEX$$o localizado.~rdc_uo_aplicacao.ue_open( string )", StopSign!)
	This.Event ue_Exit()
End If

//Chamado 286906
lvs_Biometria	= ProfileString(ivs_Arquivo_INI, "Seguran$$HEX1$$e700$$ENDHEX$$a", "Usa_Biometria", "N")
If lvs_Biometria	= "S" Then ivb_Usa_Biometria	= True

// Atribui valores para a conex$$HEX1$$e300$$ENDHEX$$o com o Banco de Dados
ivs_Path_Arquivos = This.of_GetFromINI("Diretorio", "Diretorio")

ls_ini_filial = this.of_getfromini('Analise', 'filial', false)

if ls_ini_filial = 'TODAS' then
	il_cd_filial	= 9999
elseif IsNull(ls_ini_filial) or Trim(ls_ini_filial) = '' then
	il_cd_filial 	= 534
elseif IsNumber(ls_ini_filial) then
	il_cd_filial	= Long(ls_ini_filial)
else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Configura$$HEX2$$e700e300$$ENDHEX$$o de filial no Indevida.', StopSign!)
	This.Event ue_Exit()	
end if

// Abre a janela de exibi$$HEX2$$e700e300$$ENDHEX$$o da aplica$$HEX2$$e700e300$$ENDHEX$$o
If ivb_Abre_W_Inicial Then
	Open(dc_w_Inicial)
End If

If Not This.ivb_Conectar_Banco Then 
	lvb_Sucesso = True
Else
	lvb_Sucesso = This.of_Connect()
End If

If lvb_Sucesso Then
	// Abre a janela principal da aplica$$HEX2$$e700e300$$ENDHEX$$o
	If ivb_Aplicacao_Padrao Then Open(dc_w_MDI)
	
	// Fecha a janela de exibi$$HEX2$$e700e300$$ENDHEX$$o da aplica$$HEX2$$e700e300$$ENDHEX$$o
	If ivb_Abre_W_Inicial Then
		Close(dc_w_Inicial)
	End If
	
	if ivs_tipo_log = 'TXT' then
		If Not This.of_Abre_Log() Then This.Event ue_Exit()
	end if
	
	// Verifica se h$$HEX1$$e100$$ENDHEX$$ necessidade de efetuar o login e chama a fun$$HEX2$$e700e300$$ENDHEX$$o
	If ivo_Seguranca.ivb_LogIn Then
		
		If gvo_Aplicacao.ivb_Usa_Biometria Then
			uo_GE040_Leitor_Biometrico lvo_Biometria
			lvo_Biometria = Create uo_GE040_Leitor_Biometrico
			lvo_Biometria.of_Inicializa( )
			lvo_Biometria.of_Permite_Senha_Digitada( )
			This.ivb_Permite_Senha_Digitada = lvo_Biometria.ib_Permite_Senha_Digitada
			Destroy lvo_Biometria
		End If

		ivo_Seguranca.of_LogIn_Sistema()
		
		If Not ivo_Seguranca.ivb_LogIn_Sucesso Then 
			This.Event ue_Exit()	
		Else
			This.of_SetMicroHelp()
		End If
	End If
Else
	This.Event ue_Exit()
End If

This.of_Atualiza_VV( )

// Forca a atualizacao da sistema_pdv para sistemas especificos
If ivo_Seguranca.cd_Sistema = 'TL' Or ivo_Seguranca.cd_Sistema = 'BL' Then
	This.of_Registra_Versao_Bd( )
End If
//

If lvb_Sucesso and Upper(ivs_DataSource) <> 'TEF' Then
	If ivo_Seguranca.ivb_LogIn Or &
		( gvb_Auto = False And ( ( ivo_Seguranca.cd_Sistema = 'VV' ) Or ( ivo_Seguranca.cd_Sistema = 'TD' ) ) ) Then
		
		This.of_Controla_Informacoes_PDV( )
		
		of_Registra_Versao_Bd()
	End If
End If
end event

event ue_exit();dc_w_MDI lvw_MDI

lvw_MDI = ivw_MDI

This.of_Fecha_Log()

//Disconecta do Banco
If IsValid(SQLCa) Then
	If SQLCa.of_IsConnected() Then
		SQLCa.of_Disconnect()
	End If
End If

If IsValid(lvw_MDI) Then
	Close(lvw_MDI)
Else
	Halt Close
End If
end event

event ue_idle();Long lvl_Linha

Window lw_Window

//A gvo_aplicacao est$$HEX1$$e100$$ENDHEX$$ instanciada
If IsValid(gvo_Aplicacao) Then
	//Utiliza o controle de inatividade
	If This.ivb_Usa_Timer_Out Then
		 //Verifica janelas com altera$$HEX2$$e700f500$$ENDHEX$$es pendentes
		If This.of_retorna_janelas()=0 Then
			//Est$$HEX1$$e100$$ENDHEX$$ conectado ao banco de dados
			If SQLCa.of_IsConnected() Then
				//Desbilita controle do PowerBuilder de inatividade
				Idle(0)
				//Fecha as telas Filhas (Sheet)
				If IsValid(dc_w_mdi) Then
					Do
						//Retorna tela filha ativa
						lw_Window = dc_w_mdi.GetActiveSheet( )
						//Verifica se $$HEX1$$e900$$ENDHEX$$ uma tela v$$HEX1$$e100$$ENDHEX$$lida
						If IsValid(lw_Window) Then
							//fecha a tela
							Close(lw_Window)
						Else
							//Se n$$HEX1$$e300$$ENDHEX$$o houve mais telas v$$HEX1$$e100$$ENDHEX$$lidas sai do Loop
							Exit	
						End If
					Loop While True
				End If
				//Fecha as telas Response
				For lvl_Linha = 1 to UpperBound(ivw_Windows)
					If IsValid(ivw_Windows[ lvl_Linha ]) Then
						Close( ivw_Windows[ lvl_Linha ] )
					End If
				Next
				
				//Defaz altera$$HEX2$$e700f500$$ENDHEX$$es pendentes
				SQLCa.Of_Rollback()
				//Disconecta do banco de dados padr$$HEX1$$e300$$ENDHEX$$o da aplica$$HEX2$$e700e300$$ENDHEX$$o
				SQLCa.of_Disconnect()
				
				//Abre tela de login
				If ivo_Seguranca.ivb_LogIn Then
					This.ivo_seguranca.Of_Login_Sistema()
					If Not This.ivo_Seguranca.ivb_LogIn_Sucesso Then 
						This.Event ue_Exit()	
					End If
				Else
					This.Event ue_Exit()	
				End If
			End If
		End If
	End if
End If

end event

public function boolean of_formato_data ();SetPointer(HourGlass!)

String lvs_valor_registro
Integer lvi_retorno

// Verifica se o registro do Windows est$$HEX1$$e100$$ENDHEX$$ setado para ano com 4 d$$HEX1$$ed00$$ENDHEX$$gitos

lvi_retorno = RegistryGet("HKEY_CURRENT_USER\Control Panel\International",  &
	"sShortDate", RegString!, lvs_valor_registro)
If lvi_retorno = -1 Then
	lvs_valor_registro = "Erro ao determinar se seu computador est$$HEX1$$e100$$ENDHEX$$ configurado para " + &
	                     "trabalhar com o ano 2000. Por favor, acerte as configura$$HEX2$$e700f500$$ENDHEX$$es no " + &
								"'Painel de Controle'"
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_valor_registro, StopSign!, Ok!)
	Return False
End If

If RightA(lvs_valor_registro, 4) <> "yyyy" Then
	lvs_valor_registro = "Seu computador n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurado para trabalhar com datas " + &
	                     "para o ano 2000. Por favor, acerte as configura$$HEX2$$e700f500$$ENDHEX$$es no 'Painel" + &
								" de Controle'"
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_valor_registro, StopSign!, Ok!)
	Return False
End If

Return True
end function

public function boolean of_appisrunning ();String lvs_Window

lvs_Window = iapp_Aplicacao.DisplayName

Return This.of_AppIsRunning(lvs_Window)
end function

public function boolean of_appisrunning (string ps_window);uint lvi_Val

lvi_Val = FindWindowA(0, ps_Window)

If lvi_Val > 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_abre_log ();Integer li_Tentativas = 0
Integer li_Status
Long ll_Length

String lvs_File_New

//Verifica o tamanho do arquivo de log, se for muito grande, renomeia e abre outro (se n$$HEX1$$e300$$ENDHEX$$o estiver em uso)
If FileExists(This.ivs_Arquivo_LOG) Then
	//Pega o tamanho do arquivo
	ll_Length = FileLength(This.ivs_Arquivo_LOG)
	//Se o arquivo de log atual tiver mais de 5MB
	If ll_Length >= 5242880 then
		//Obt$$HEX1$$e900$$ENDHEX$$m nome de arquivo renomeado
		lvs_File_New = Mid(This.ivs_Arquivo_LOG, 1, Len(This.ivs_Arquivo_LOG) - 4) + "_bkp_"+String(Today(), "YYYYMMDD_HHMMSS")+".log"
		//Tenta Mover
		li_Status = FileMove(This.ivs_Arquivo_LOG, lvs_File_New)
	End If
End If

// Se der erro, tenta realizar a abertura do log por at$$HEX1$$e900$$ENDHEX$$ 3 vezes antes de retornar FALSE
Do 	
	li_Tentativas++
		
	This.ivi_LOG = FileOpen( This.ivs_Arquivo_LOG, LineMode!, Write!, Shared!, Append! )
	
	ib_log_aberto = true
	
	If This.ivi_LOG = -1 Then gf_Delay( 2 )
	
	If li_Tentativas >= 3 Then Exit
	
Loop While ( This.ivi_LOG = -1 )
//

If This.ivi_LOG = -1 Then
	If Not gvb_Auto Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o : " + This.ivs_Arquivo_LOG + ".", StopSign! )
	End If

	Return False
End If

Return True
end function

public function boolean of_fecha_log ();If ivi_LOG = 0 Then Return True

If FileClose(ivi_LOG) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no fechamento do arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o '" + This.ivs_Arquivo_LOG + "'.", StopSign!)
	Return False
Else
	This.ivi_LOG = 0
	Return True
End If
end function

public function boolean of_grava_log (string ps_mensagem);if not ib_log_aberto then
	of_abre_log()
end if

return of_grava_log(ps_mensagem, 'INFO')
end function

public function string of_getfromini (string ps_secao, string ps_chave);Return this.of_getfromini(ps_secao, ps_chave, true)
end function

public function boolean of_connect ();String lvs_DataSource, &
		 lvs_DataBase, &
		 lvs_HostName, &
		 lvs_Selecao_BD, &
		 lvs_Ini
		 
String ls_Seleciona_Odbc

Boolean lvb_Retorno = False

	Try
	
	If Pos(Upper(gvo_Aplicacao.of_UserId()), "COLETOR_55") > 0 Then
		lvs_Ini = "c:\sistemas\usuarios\WS_coletor_55\exe\wms.ini"
	Else
		lvs_Ini = "c:\sistemas\vv\exe\verifica_versao.ini" // Ini padr$$HEX1$$e300$$ENDHEX$$o para conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados
	End If
	
	// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia do arquivo INI
	If Not FileExists( lvs_Ini ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o " + lvs_Ini + " n$$HEX1$$e300$$ENDHEX$$o localizado.~rdc_uo_aplicacao.of_connect( )", StopSign! )
		Return False
	End If
	
	// Procura pela chave com o c$$HEX1$$f300$$ENDHEX$$digo do sistema, se encontrar, utiliza os valores da chave, sen$$HEX1$$e300$$ENDHEX$$o, usa os valores da chave database
	lvs_DataBase	= ProfileString( lvs_Ini, gvo_Aplicacao.ivo_Seguranca.Cd_Sistema, "DataBase", "" )
	lvs_DataSource	= ProfileString( lvs_Ini, gvo_Aplicacao.ivo_Seguranca.Cd_Sistema, "DataSource", "" )
	lvs_Selecao_BD	= ProfileString( lvs_Ini, gvo_Aplicacao.ivo_Seguranca.Cd_Sistema, "Seleciona_BD", "N" )
	
	If lvs_DataBase = "" Then
		lvs_DataBase	= Trim( ProfileString( lvs_Ini, "DataBase", "DataBase", "" ) )
		lvs_DataSource	= Trim( ProfileString( lvs_Ini, "DataBase", "DataSource", "" ) )
		lvs_Selecao_BD	= Trim( ProfileString( lvs_Ini, "DataBase", "Seleciona_BD", "N" ) )
	End If
	
	If IsNull(gvb_Auto) Then gvb_Auto = False
	If ( lvs_DataSource='' Or lvs_Selecao_BD = 'S' ) and ( ivo_Seguranca.Cd_Sistema <> 'VV' ) and (not(gvb_Auto)) Then
		Choose Case Upper(lvs_DataBase)
			Case 'SYBASE'
				OpenWithParm( w_selecao_bd, Upper(lvs_DataBase))
				This.ivs_DataSource = Message.StringParm
			
			Case 'ANYWHERE', 'POSTGRESQL'
				IF Not IsNull(is_ODBC_Conexao_Direta) And Trim(This.is_ODBC_Conexao_Direta) <> '' Then
					This.ivs_DataSource = This.is_ODBC_Conexao_Direta
				Else
					OpenWithParm( w_selecao_filial_odbc, '' )
					This.ivs_DataSource = Message.StringParm
				End If
		End Choose

		lvs_DataSource = This.ivs_DataSource
	End If
	
	If Trim( lvs_DataBase ) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"Valor n$$HEX1$$e300$$ENDHEX$$o especificado no arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o.~r~r" + &
										 "Arquivo : " + lvs_Ini + "~r" + &
										 "Se$$HEX2$$e700e300$$ENDHEX$$o : Database" + "~r" + &
										 "Chave : DataBase.", StopSign!)
		Return False
	End If

	lvs_HostName   = ivo_Seguranca.Cd_Sistema + "_" + This.of_UserId()+IIF(gvo_Aplicacao.ivs_Tarefa<>"", "_"+gvo_Aplicacao.ivs_Tarefa, "")
	
	SqlCa.of_SetDataBase(lvs_DataBase)
	
	// Coloca o nome da conex$$HEX1$$e300$$ENDHEX$$o no t$$HEX1$$ed00$$ENDHEX$$tulo da janela
	This.ivs_DataBase   = lvs_DataBase
	This.ivs_DataSource = lvs_DataSource
	
	This.of_SetMicroHelp()
	//iapp_Aplicacao.DisplayName = iapp_Aplicacao.DisplayName + " (" + lvs_DataBase + " - " + lvs_DataSource + ")"
	
	// Faz a conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados especificado
	lvb_Retorno = SqlCa.of_Connect(lvs_DataSource, lvs_HostName)
	
	If Upper(SQLCa.ivs_DataBase) = "ANYWHERE" or Upper(SQLCa.ivs_DataBase) ="POSTGRESQL" Then
		//2017.07.28 - Inserido por problema com separador decimal ap$$HEX1$$f300$$ENDHEX$$s abertura OLEObject em banco PostGreeSQL
		If Not Pos(SQLCa.DbParm,"DecimalSeparator") > 0 Then SQLCa.DbParm += "DecimalSeparator=','"
	End If
	
	Return lvb_Retorno
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ), StopSign! )
End Try
end function

public function string of_computername ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetComputerName
//
//	Access:  public
//
//	Arguments: none
//	
//
//	Returns:  string - computer name
//	
//
//	Description:  Return the the computer name the user is using
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX1$$a900$$ENDHEX$$ 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ulong 	lul_size = 16 // MAX_COMPUTERNAME_LENGTH + 1

boolean	lb_rc

This.is_ComputerName = space(lul_size)

lb_rc = GetComputerNameA( This.is_ComputerName, lul_size)

If Not lb_rc Then
	This.is_ComputerName = "ERRO_NM_PDV_" + String( Now(), "mmss" )
	This.is_ComputerName = ""
End If

Return This.is_ComputerName

end function

public function string of_userid ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetUserID
//
//	Access:  public
//
//	Arguments: none
//
//
//	Returns:  string  - user id/name
//	
//
//	Description:  Return the user id/name currently logged into a network
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX1$$a900$$ENDHEX$$ 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string 	ls_name
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

public subroutine of_exclui_log_vazio (string ps_arquivo);// Se o arquivo de log estiver vazio, exclui o arquivo
If FileExists(ps_Arquivo) Then
	If FileLength(ps_Arquivo) = 0 Then		
		FileDelete(ps_Arquivo)
	End If
End If
end subroutine

public function string of_get_system_directory ();If This.of_is64bits() Then
	Return 'C:\Windows\SysWOW64'
End If

string ls_PathName,ls_Command
ulong ll_RequiredBufferSize
ls_PathName = Space(255)
ll_RequiredBufferSize = GetSystemDirectory(ref ls_PathName,255)

Return ls_PathName
end function

public subroutine of_registra_versao_bd ();Long ll_Filial
Long ll_Filial_Matriz

String lvs_Ini = "c:\sistemas\vv\exe\verifica_versao.ini" // Ini padr$$HEX1$$e300$$ENDHEX$$o para conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados
String lvs_DataBase
String lvs_DataSource
String lvs_HostName

If Not gf_filiais_parametro( Ref  ll_Filial, Ref ll_Filial_Matriz ) Then Return

lvs_HostName = ivo_Seguranca.Cd_Sistema + "_" + This.of_UserId( )

If Not FileExists( lvs_Ini ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o " + lvs_Ini + " n$$HEX1$$e300$$ENDHEX$$o localizado. ~rFun$$HEX2$$e700e300$$ENDHEX$$o: dc_uo_aplicacao.of_registra_versao_bd( )", StopSign! )
	Return
End If

// Procura pela chave com o c$$HEX1$$f300$$ENDHEX$$digo do sistema, se encontrar, utiliza os valores da chave, sen$$HEX1$$e300$$ENDHEX$$o, usa os valores da chave database
lvs_DataBase	= Upper( ProfileString( lvs_Ini, "DataBase", "DataBase", "" ) )
lvs_DataSource	= ProfileString( lvs_Ini, "DataBase", "DataSource", "" )

If ll_Filial <> ll_Filial_Matriz And lvs_DataBase <> 'POSTGRESQL' Then
	dc_uo_transacao lo_tran
	lo_tran = create dc_uo_transacao

	lo_tran.of_SetDataBase( lvs_DataBase )
	
	If lo_tran.of_IsConnected( ) Then lo_tran.of_Disconnect( ) // Desconecta para conectar ao banco de dados definido no .ini do VV
	lo_tran.of_Connect( lvs_DataSource, lvs_HostName )
	
	This.of_registra_versao_bd( Ref lo_tran )
	
	If lo_Tran.of_Isconnected( ) Then lo_Tran.of_Disconnect( )
	Destroy lo_Tran
Else
	This.of_registra_versao_bd( Ref SqlCa )
End If

Return
end subroutine

public function string of_get_program_files_directory ();Constant Long CSIDL_PERSONAL = 5 // current user My Documents  
Constant Long CSIDL_APPDATA = 26 // current user Application Data  
Constant Long CSIDL_LOCAL_APPDATA = 28 // local settings Application Data  
Constant Long CSIDL_COMMON_DOCUMENTS = 46 // all users My Documents  
Constant Long CSIDL_COMMON_APPDATA = 35 // all users Application Data
Constant Long CSIDL_PROGRAM_FILES = 38 // Pasta dos arquivos de programas

string ls_path  
ulong lul_handle, lul_rc, lul_hToken  
  
ls_path = Space(256)  
lul_handle = Handle(This)  
SetNull(lul_hToken)  

lul_rc = SHGetFolderPath(lul_handle, CSIDL_PROGRAM_FILES, lul_hToken, 0, ref ls_path)  
  
RETURN ls_path // path
end function

public function string of_application_path ();string lvs_Path
unsignedlong lul_handle

lvs_Path = Space(1024)

lul_handle = Handle(GetApplication())
GetModuleFileNameA(lul_handle, lvs_Path, 1024)

Return lvs_Path
end function

public function string of_getprofiledirectory (string as_folder);// Argumento: Nome do diret$$HEX1$$f300$$ENDHEX$$rio para retornar o caminho

// AllUsersDesktop
// AllUsersStartMenu
// AllUsersPrograms
// AllUsersStartup
// Desktop
// Favorites
// MyDocuments
// Programs
// Recent
// SendTo
// StartMenu
// Startup

OleObject ws
OleObject loo_shortcut

String ls_Retorno

ws = Create OleObject
ws.ConnectToNewObject("WScript.Shell")

ls_Retorno = ws.SpecialFolders( as_Folder )

Destroy ws

Return ls_Retorno
end function

public function boolean of_retorna_resolucao_monitor (ref integer pl_width, ref integer pl_height);pl_Width	= GetSystemMetrics(0)
pl_Height	= GetSystemMetrics(1)

Return ((pl_Width > 0)and(pl_Height > 0))
end function

public function boolean of_is64bits ();uo_windows_version lo_SO

Return ( lo_SO.of_GetOSBits() = 64 )
end function

public function integer of_retorna_janelas ();//Retorna o n$$HEX1$$fa00$$ENDHEX$$mero de telas em altera$$HEX2$$e700e300$$ENDHEX$$o, que foram registradas pelo controle de inatividade
Return ivds_telas.RowCount()
end function

public subroutine of_remove_tela (string ps_tela);//Remove a tela do controle de telas em altera$$HEX2$$e700e300$$ENDHEX$$o
Long lvl_Find

If IsValid(ivds_Telas) Then
	lvl_Find = ivds_Telas.Find("nm_tela='"+ps_tela+"'",1,ivds_Telas.RowCount())
	
	If lvl_Find > 0 Then
		ivds_Telas.DeleteRow(lvl_Find)
	End If
End If

end subroutine

public subroutine of_insere_tela (string ps_tela);//Insere tela no controle de telas abertas com altera$$HEX2$$e700e300$$ENDHEX$$o pendentes
//Para impedir o fechamento por inatividade
Long lvl_Linha

lvl_Linha = ivds_Telas.InsertRow(0)

ivds_Telas.Object.nm_tela [lvl_Linha] = ps_tela
end subroutine

public subroutine of_set_idle (integer pi_segudos);ivb_Usa_Timer_Out = (pi_segudos > 0)
ivi_Timer_Idle = pi_segudos
Idle(ivi_Timer_Idle)
end subroutine

public subroutine of_insere_response (window pw_window);//Insere a tela no controle de telas response abertas
ivw_Windows[UpperBound(ivw_Windows)+1] = pw_window
end subroutine

public subroutine of_remove_response (window pw_window);//Remove a response do controle de responses abertas
Window 	lvw_Windows[]
Long lvl_Linha

//Copia todas as window, exceto a que ser$$HEX1$$e100$$ENDHEX$$ removida, para um novo array
For lvl_Linha = 1 To UpperBound(ivw_Windows)
	If ivw_Windows[lvl_Linha] <> pw_window Then
		lvw_Windows[UpperBound(lvw_Windows)+1] = ivw_Windows[lvl_Linha]
	End If
Next

//Limpa o array
SetNull(lvw_Windows)

//Copia as telas ainda abertas para o array de controle
For lvl_Linha = 1 To UpperBound(lvw_Windows)
	ivw_Windows[UpperBound(ivw_Windows)+1] = lvw_Windows[lvl_Linha]
Next
end subroutine

public function boolean of_tela_aberta (string ps_titulo);//Retorna verdadeiro se a tela estiver aberta na aplica$$HEX2$$e700e300$$ENDHEX$$o
Long lvl_Find

If IsValid( ivds_Telas ) Then
	lvl_Find = ivds_Telas.Find( "nm_tela='" + ps_Titulo + "'", 1, ivds_Telas.RowCount( ) )
	
	If lvl_Find > 0 Then
		Return True
	End If
End If

Return False
end function

public subroutine of_get_disk_space (character ps_letra_unidade, ref decimal pdc_espaco_livre);Integer li_ChangeDirectory

ULARGE_INTEGER lli_caller
ULARGE_INTEGER lli_total
ULARGE_INTEGER lli_free 
Double ld_capacity 

String ls_Disk
SetNull( ls_Disk )

li_ChangeDirectory = ChangeDirectory( ps_Letra_Unidade + ":\\" )

ZeroMemory( lli_caller, 8 ) 
ZeroMemory( lli_total, 8 ) 
ZeroMemory( lli_free, 8 ) 
GetDiskFreeSpaceExA( ls_Disk, lli_caller, lli_total, lli_free ) 

// Livre
IF lli_free.Highpart > 0 THEN 
	ld_capacity = ( Double( lli_free.Highpart ) * 4294967295 ) + lli_free.LowPart 
ELSE 
	ld_capacity = lli_free.LowPart 
END IF 

// format for display 
Double mBytes, gBytes
String ls_Capacity

pdc_espaco_livre	= Round( ld_capacity / Double( 1048576 ), 2 )
//gBytes	= Round( ld_capacity / Double( 1073741824 ), 2 )					
end subroutine

public function boolean of_set_posicao_mouse (long pl_x, long pl_y);Return SetCursorPos(pl_X,pl_Y)
end function

public function boolean of_controla_informacoes_pdv ();String ls_Mac_Parametro
String ls_Mac_Computador

Long ll_Filial
Long ll_Filial_Matriz

Try
	uo_parametro_pdv lo_Parametro_PDV
	lo_Parametro_PDV = Create uo_parametro_pdv
	
	dc_uo_Api lo_APi
	lo_Api = Create dc_uo_Api
	
	ls_Mac_Parametro		= lo_Parametro_PDV.of_Get_Mac_Address( )
	ls_Mac_Computador	= lo_Api.of_GetMac( )
	
	Choose Case gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
		Case 'VV'
			If ls_Mac_Parametro <> ls_Mac_Computador Then
				If lo_Parametro_PDV.of_Limpa_Informacoes_PDV( ) Then
					SqlCa.of_Commit( )
				End If
			End If
			
		Case Else
			//
	End Choose
		
	If lo_Parametro_PDV.of_Grava_Informacoes_PDV( ) Then
		SqlCa.of_Commit( )
		Return True
	Else
		SqlCa.of_RollBack( )
		Return False
	End If
	
Catch( RuntimeError ru )
	//
Finally
	If IsValid( lo_Api ) 					Then Destroy lo_Api
	If IsValid( lo_Parametro_PDV ) Then Destroy lo_Parametro_PDV
End Try

end function

public function datetime of_data_criacao_arquivo (string as_filename);String ls_test, ls_path, ls_file
DateTime ldt_retorno
OLEObject obj_shell, obj_folder, obj_item

Try
	SetNull(ldt_retorno)
	
	obj_shell = CREATE OLEObject
	obj_shell.ConnectToNewObject( 'shell.application' )
	
	ls_path = Left( as_filename, LastPos( as_filename, "\" ) )
	ls_file = Mid( as_filename, LastPos( as_filename, "\" ) + 1 )
	
	 obj_folder = obj_shell.NameSpace( ls_path )
	 
	 IF IsValid( obj_folder ) THEN
		  obj_item = obj_folder.ParseName( ls_file )
		  
		  IF IsValid( obj_item ) THEN
				ls_test = obj_folder.GetDetailsOf( obj_item, 3 )			
				ldt_retorno = DateTime( ls_test )
		  END IF
	 END IF

Finally
	If IsValid( obj_shell ) 		Then DESTROY obj_shell
	If IsValid( obj_folder ) 	Then DESTROY obj_folder
	If IsValid( obj_item ) 		Then DESTROY obj_item
	
	Return ldt_retorno
	
End Try
end function

public subroutine of_registra_versao_bd (ref dc_uo_transacao lo_tran);Decimal ldc_Espaco_Livre_C
Decimal ldc_Espaco_Livre_D

String ls_Achou
String ls_Pdv
String ls_Windows
String lvs_Ini = "c:\sistemas\vv\exe\verifica_versao.ini" // Ini padr$$HEX1$$e300$$ENDHEX$$o para conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados
String lvs_DataBase
String lvs_DataSource
String lvs_HostName

DateTime lvdh_Versao

ls_Pdv = is_ComputerName

String ls_Versao
String ls_version
String ls_edition
String ls_csd
Integer li_OS_Version

uo_windows_version lo_SO
lo_SO.of_GetOSVersion( Ref li_OS_Version, Ref ls_version, Ref ls_edition, Ref ls_csd )

ls_Windows = UPPER( ls_version + " " + ls_edition )

gvo_Aplicacao.of_get_disk_space( 'c', Ref ldc_Espaco_Livre_C )
gvo_Aplicacao.of_get_disk_space( 'd', Ref ldc_Espaco_Livre_D )

str_memorystatus l_str
l_str.ul_length = 64
GlobalMemoryStatus(Ref l_str)

// Divis$$HEX1$$e300$$ENDHEX$$o feita por 1024 e novamente por 1024 por estar em bytes
ls_Windows += " - MEM. RAM: " + String( Truncate( l_str.ll_TotalPhys / 1048576, 0 ) , "####" ) + "M"

gvb_Erro_Validar_Versao = False

Select nr_versao
  Into :ls_Achou
  From sistema_pdv
 Where cd_filial			= dbo.uf_filial_parametro( )
	And cd_sistema	= :ivo_Seguranca.Cd_Sistema
	And nm_pdv			= :ls_Pdv
 Using lo_Tran; 
	 
Choose Case lo_Tran.SqlCode
	Case 100
		Insert	 Into sistema_pdv
				 (cd_filial,
				 cd_sistema,
				  nm_pdv, 
				  nr_versao, 
				  dh_versao, 
				  dh_ultimo_acesso,
				  de_versao_windows,
				  vl_espaco_livre_mb_c,
				  vl_espaco_livre_mb_d )
		 Values(dbo.uf_filial_parametro( ),
				  :ivo_Seguranca.Cd_Sistema,
				  :ls_Pdv, 
				  :ivs_Versao,
				  :ivdt_Data_Versao,
				  getdate(),
				  :ls_Windows,
				  :ldc_Espaco_Livre_C,
				  :ldc_Espaco_Livre_D )
		  Using lo_Tran;
		
		If lo_Tran.SqlCode = -1 Then
			gvb_Erro_Validar_Versao = True
			lo_Tran.of_MsgDbError()
			lo_Tran.of_RollBack()
		End If

	Case 0		
		Update sistema_pdv
			Set	dh_versao		   			= :ivdt_Data_Versao,
					nr_versao					= :ivs_Versao,
					dh_ultimo_acesso 			= getdate(),
					de_versao_windows		= :ls_Windows,
					vl_espaco_livre_mb_c		= :ldc_Espaco_Livre_C,
					vl_espaco_livre_mb_d	= :ldc_Espaco_Livre_D
		 Where cd_filial			= dbo.uf_filial_parametro( )
			And cd_sistema	= :ivo_Seguranca.Cd_Sistema
			And nm_pdv			= :ls_Pdv
		 Using lo_Tran;
			 
		If lo_Tran.SqlCode = -1 Then
			gvb_Erro_Validar_Versao = True
			lo_Tran.of_RollBack()
			lo_Tran.of_MsgDbError( "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da tabela sistema_pdv - gvo_Aplicacao.of_Registra_Versao_BD()" )
		End If
		
	Case -1
		lo_Tran.of_RollBack( )
		lo_Tran.of_MsgDbError( "gvo_Aplicacao.of_Registra_Versao_BD( )" )
End Choose
	
lo_Tran.of_Commit( )

Return
end subroutine

public function boolean of_get_app_usa_menu ();Return This.ivb_Usa_Menu
end function

public subroutine of_set_app_usa_menu (boolean pb_usa_menu);This.ivb_Usa_Menu = pb_usa_menu
end subroutine

public function boolean of_get_alerta_commit_producao ();Return This.ivb_Alerta_Commit_Producao
end function

public subroutine of_set_alerta_commit_producao (boolean pb_alerta_commit_producao);This.ivb_Alerta_Commit_Producao = pb_Alerta_Commit_Producao
end subroutine

public subroutine of_atualiza_vv ();Long ll_Filial
Long ll_Filial_Matriz

String lvs_Ini = "c:\sistemas\vv\exe\verifica_versao.ini" // Ini padr$$HEX1$$e300$$ENDHEX$$o para conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados
String lvs_DataBase
String lvs_DataSource
String lvs_HostName

If Not gf_filiais_parametro( Ref  ll_Filial, Ref ll_Filial_Matriz ) Then Return

lvs_HostName = ivo_Seguranca.Cd_Sistema + "_" + This.of_UserId( )

If Not FileExists( lvs_Ini ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o " + lvs_Ini + " n$$HEX1$$e300$$ENDHEX$$o localizado. ~rFun$$HEX2$$e700e300$$ENDHEX$$o: dc_uo_aplicacao.of_registra_versao_bd( )", StopSign! )
	Return
End If

// Procura pela chave com o c$$HEX1$$f300$$ENDHEX$$digo do sistema, se encontrar, utiliza os valores da chave, sen$$HEX1$$e300$$ENDHEX$$o, usa os valores da chave database
lvs_DataBase	= Upper( ProfileString( lvs_Ini, "DataBase", "DataBase", "" ) )
lvs_DataSource	= ProfileString( lvs_Ini, "DataBase", "DataSource", "" )

If ll_Filial <> ll_Filial_Matriz And lvs_DataBase <> 'POSTGRESQL' Then
	dc_uo_transacao lo_tran
	lo_tran = create dc_uo_transacao

	lo_tran.of_SetDataBase( lvs_DataBase )
	
	If lo_tran.of_IsConnected( ) Then lo_tran.of_Disconnect( ) // Desconecta para conectar ao banco de dados definido no .ini do VV
	lo_tran.of_Connect( lvs_DataSource, lvs_HostName )
	
	This.of_Atualiza_VV( Ref lo_tran )
	
	If lo_Tran.of_Isconnected( ) Then lo_Tran.of_Disconnect( )
	Destroy lo_Tran
Else
	This.of_Atualiza_VV( Ref SqlCa )
End If
end subroutine

public subroutine of_atualiza_vv (ref dc_uo_transacao po_tran);String ls_Versao
String ls_Versao_Aux
String ls_Arquivos[]											// Lista de arquivos antigos do sistema VV para exclus$$HEX1$$e300$$ENDHEX$$o
String ls_Caminho_Sistema_Executando = ''
String ls_Caminho_Sistema_VV = 'c:\sistemas\vv\exe'	// Caminho do sistema
String ls_Error													// Mensagem de erro retornada pelo descompactador
String ls_Extencao
String ls_Zip
String ls_PDV
String ls_Versao_Registro
//
DateTime ldh_Data_Arquivo
//
Integer lvi_Linha
Integer li_Tentativa
//
Long ll_Filial_Parametro
Long ll_Filial_Matriz

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'VV' Then Return

ls_Caminho_Sistema_Executando = "c:\sistemas\" + gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + "\exe\"

If Not DirectoryExists ( ls_Caminho_Sistema_Executando ) Then Return

gf_Dir_List( ls_Caminho_Sistema_Executando, "VV*.zip", 0+1, Ref ls_Arquivos )

If UpperBound( ls_Arquivos ) = 0 Then Return

ls_Zip				= ls_Arquivos[ 1 ]

ls_Versao		= gf_Replace( ls_Zip, 'VV', '', 0 ) // VV146.zip -> 146.zip
ls_Versao_Aux	= gf_Replace( ls_Versao, '.zip', '', 0 ) // 146.zip -> 146
ls_Versao		= RightA( ls_Versao_Aux, 2 ) // 146 -> 46
ls_Versao		= gf_Replace( ls_Versao_Aux, ls_Versao, '', 0 ) + '.' + ls_Versao // 1.46

 SELECT nr_versao
	INTO :ls_Versao_Registro
	FROM sistema_pdv
WHERE cd_sistema	= 'VV'
	AND nm_pdv		= :This.is_ComputerName
USING po_Tran;

Choose Case po_Tran.SqlCode
	Case -1
		po_Tran.of_MsgDbError( "gvo_aplicacao.of_atualiza_vv()" )
		Return
		
	Case 100
		ls_Versao_Registro = '0.00'

	Case 0
		If Trim( ls_Versao_Registro ) = "" Or IsNull( ls_Versao_Registro ) Then
			ls_Versao_Registro = '0.00'
		End If
End Choose

If ls_Versao_Registro >= ls_Versao Then
	FileDelete( ls_Caminho_Sistema_Executando + ls_Zip )
	Return
End If

If IsNull( ls_Zip ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Vari$$HEX1$$e100$$ENDHEX$$vel ls_Zip est$$HEX1$$e100$$ENDHEX$$ com valor NULL. gvo_aplicacao.of_atualiza_vv()~r~rIMPORTANTE, informar o departamento TI - DESENVOLVIMENTO", StopSign! )
	Return
End If

If Not FileExists( ls_Caminho_Sistema_Executando + ls_Zip ) Then Return // Verifica se existe vers$$HEX1$$e300$$ENDHEX$$o do VV para atualizar. O zip da vers$$HEX1$$e300$$ENDHEX$$o deve ser compactado dentro do RLXXX.zip

Try
	gf_TaskKill( 'vv' )
	gf_Delay( 1 )
	gf_Filiais_Parametro( Ref ll_Filial_Parametro, Ref ll_Filial_Matriz )
	ls_PDV = gvo_Aplicacao.is_ComputerName
	
	SetPointer(HourGlass!)
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando sistema 'VERIFICA VERS$$HEX1$$c300$$ENDHEX$$O " + ls_Versao + "', por favor aguarde..."
	
	dc_uo_zip lo_Zip
	lo_Zip = Create dc_uo_zip

	gf_Dir_List( ls_Caminho_Sistema_VV, "*.*", 0+1, Ref ls_Arquivos )
		
	For lvi_Linha = 1 To Upperbound( ls_Arquivos )
		ls_Extencao = RightA( ls_Arquivos[lvi_Linha], 3 )
		
		If ls_Extencao = 'pbd' Or ls_Extencao = 'ver' Or ls_Extencao = 'exe' Or ls_Extencao = 'zip' Then	
			If Not FileDelete( ls_Caminho_Sistema_VV + "\" + ls_Arquivos[ lvi_Linha ] ) Then
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir arquivo '" + ls_Caminho_Sistema_VV + "\" + ls_Arquivos[ lvi_Linha ] + "'. gvo_aplicacao.of_atualiza_vv()~r~rIMPORTANTE, informar o departamento TI - DESENVOLVIMENTO", StopSign! )
				Halt Close
				Return
			End If		
		End If
		
		Yield()
	Next

	// Trecho para resolver problema de permissao de acesso do AD, que demora a excluir os executaveis
	dc_uo_api lo_api
	lo_api = create dc_uo_api
	ldh_Data_Arquivo = lo_api.of_data_arquivo( ls_Caminho_Sistema_VV + "\vv.exe" )
	
	li_Tentativa = 1
	Do While Date( ldh_Data_Arquivo ) <> Date( '01/01/1900' )
		open(w_aguarde)
		w_Aguarde.Title = "Excluindo execut$$HEX1$$e100$$ENDHEX$$vel do sistema 'VERIFICA VERS$$HEX1$$c300$$ENDHEX$$O', tentativa " + String( li_Tentativa ) + ", aguarde..."
		ldh_Data_Arquivo = lo_api.of_data_arquivo( ls_Caminho_Sistema_VV + "\vv.exe" )
		gf_delay(6)
		li_Tentativa++
	Loop	
	if isvalid( lo_api ) then destroy lo_api
	if isvalid(w_aguarde) then close(w_aguarde)
	// FIM - Trecho para resolver problema de permissao de acesso do AD, que demora a excluir os executaveis	
	
	lo_Zip.of_UnZip_Origem( ls_Caminho_Sistema_Executando + ls_Zip )
	lo_Zip.of_UnZip_Destino( ls_Caminho_Sistema_VV + '\' )
	ls_Error = lo_Zip.of_UnZip( True )
				
	If ls_Error <> "" Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Error, StopSign! )
		Return
	End If
	
	// S$$HEX1$$f300$$ENDHEX$$ atualiza a tabela sistema/sistema_pdv se for PDV de filial
	If String( ll_Filial_Parametro, "0000" ) = LeftA( ls_PDV, 4 ) Then	
		 UPDATE sistema
			 SET	nr_versao		= :ls_Versao,
					dh_versao		= getdate(),
					dh_atualizacao	= getdate()
		  WHERE cd_sistema = 'VV'
			USING po_Tran;
		 
		If po_Tran.SqlCode = -1 Then
			po_Tran.of_RollBack()
			po_Tran.of_MsgDbError( "gvo_aplicacao.of_atualiza_vv()" )
			Return
		End If
		
		 SELECT nr_versao
			INTO :ls_Versao_Aux
		   FROM sistema_pdv
		WHERE cd_sistema	= 'VV'
		  	AND nm_pdv		= :ls_PDV
		USING po_Tran;
		
		Choose Case po_Tran.SqlCode
			Case -1
				po_Tran.of_MsgDbError( "gvo_aplicacao.of_atualiza_vv()" )
				Return
				
			Case 100
				INSERT
				  INTO sistema_pdv ( cd_sistema, nm_pdv, nr_versao, dh_versao, dh_atualizacao, dh_ultimo_acesso )
				  VALUES ( 'VV', :ls_PDV, :ls_Versao, getdate(), getdate(), getdate() )
				  USING po_Tran;
				  
			Case 0		
				 UPDATE sistema_pdv
					 SET	nr_versao		= :ls_Versao,
							dh_versao		= getdate(),
							dh_atualizacao	= getdate(),
							dh_ultimo_acesso = getdate( )
				  WHERE cd_sistema	= 'VV'
					  AND nm_pdv		= :ls_PDV
					USING po_Tran;
		End Choose
		 
		If po_Tran.SqlCode = -1 Then
			po_Tran.of_RollBack()
			po_Tran.of_MsgDbError( "application.af_atualiza_vv()" )
			Return
		End If
		
		po_Tran.of_Commit( )
	End If
	
	FileDelete( ls_Caminho_Sistema_Executando + ls_Zip )
	
Catch( Exception Ex )
	MessageBox( "Exception", ex.getMessage( ), StopSign! )
	
Finally
	If IsValid( lo_Zip ) Then Destroy lo_Zip
	If IsValid( w_Aguarde ) Then Close( w_Aguarde )
	SetPointer( Arrow! )
End Try

Return
end subroutine

public subroutine of_set_tarefa (readonly string ps_tarefa);String lvs_Tarefa

//Recebe na vari$$HEX1$$e100$$ENDHEX$$vel local o valor do par$$HEX1$$e200$$ENDHEX$$metro
lvs_Tarefa = ps_tarefa
//Caso o primeiro caracter seja "/" ir$$HEX1$$e100$$ENDHEX$$ remover
If Mid(lvs_Tarefa, 1 , 1) = '/' Then lvs_Tarefa = Mid(lvs_Tarefa, 2)
//Pega apenas 4 caracteres
lvs_Tarefa = Mid(lvs_Tarefa, 1, 4)
//Remove espa$$HEX1$$e700$$ENDHEX$$os no in$$HEX1$$ed00$$ENDHEX$$cio e final
lvs_Tarefa = Trim(lvs_Tarefa)
//Remove contrabarras
lvs_Tarefa = gf_replace(lvs_Tarefa, '/', '', 0)
//Remove barras
lvs_Tarefa = gf_replace(lvs_Tarefa, '\', '', 0)

//Atribui a vari$$HEX1$$e100$$ENDHEX$$vel da classe para utilizar na conex$$HEX1$$e300$$ENDHEX$$o ao BD
This.ivs_Tarefa = lvs_Tarefa
end subroutine

public subroutine of_set_odbc_conexao_direta (string as_odbc);is_ODBC_Conexao_Direta = as_odbc
end subroutine

public function string of_get_odbc_conexao_direta ();Return This.is_ODBC_Conexao_Direta
end function

public subroutine of_set_tarefa_ex (readonly string ps_tarefa, string ps_opcao);String lvs_Tarefa

//Recebe na vari$$HEX1$$e100$$ENDHEX$$vel local o valor do par$$HEX1$$e200$$ENDHEX$$metro
lvs_Tarefa = ps_tarefa
//Caso o primeiro caracter seja "/" ir$$HEX1$$e100$$ENDHEX$$ remover
If Mid(lvs_Tarefa, 1 , 1) = '/' Then lvs_Tarefa = Mid(lvs_Tarefa, 2)
//Pega apenas 4 caracteres
lvs_Tarefa = Mid(lvs_Tarefa, 1, 4)
//Remove espa$$HEX1$$e700$$ENDHEX$$os no in$$HEX1$$ed00$$ENDHEX$$cio e final
lvs_Tarefa = Trim(lvs_Tarefa)
////Remove contrabarras
lvs_Tarefa = gf_replace(lvs_Tarefa, '/', '', 0)
////Remove barras
lvs_Tarefa = gf_replace(lvs_Tarefa, '\', '', 0)
//
lvs_Tarefa = lvs_Tarefa + ps_opcao
//
////Remove contrabarras
lvs_Tarefa = gf_replace(lvs_Tarefa, '/', '_', 0)
////Remove barras
lvs_Tarefa = gf_replace(lvs_Tarefa, '\', '_', 0)

//Atribui a vari$$HEX1$$e100$$ENDHEX$$vel da classe para utilizar na conex$$HEX1$$e300$$ENDHEX$$o ao BD
This.ivs_Tarefa = lvs_Tarefa
end subroutine

public function boolean of_grava_log_json (string ps_mensagem, string ps_nivel_log);Integer lvi_Status
Integer li_Tentativas

String ls_ip
String ls_sistema
String ls_host
String ls_matricula
String ls_computer
String ls_versao
String ls_json
Boolean lvb_Abre_Log = False
Boolean lvb_Retorno 	 = False

If This.ivi_LOG = 0 Then
	lvb_Abre_Log = This.of_Abre_Log()
	
	If Not lvb_Abre_Log Then
		Return False
	End If
End If
						
ls_ip = this.ivo_seguranca.of_get_is_ip()
ls_sistema = this.ivo_seguranca.cd_sistema
ls_host = this.ivo_seguranca.of_get_is_host()
ls_matricula = this.ivo_seguranca.of_get_nr_matricula_persiste()
ls_computer = this.is_computername
ls_versao = this.ivs_versao

ls_json = &
    "{" + &
		 '"timestamp":' +  gf_grava_log_json_form_dt(datetime(today(), now())) + "," + &
		 '"nivel":' + of_json_value(ps_nivel_log)    + "," + &
		 '"ip":' + of_json_value(ls_ip)    + "," + &
		 '"host":' + of_json_value(ls_host)              + "," + &
		 '"sistema":' + of_json_value(ls_sistema)            + "," + &
		'"versao":' + of_json_value(ls_versao)  + "," + &          
		 '"user":' + of_json_value(ls_matricula)      + "," + &
		 '"computer":' + of_json_value(ls_computer)                      + "," + &
		 '"message":' + of_json_value(ps_Mensagem) + &
    "}"
	 
// Se der erro, tenta realizar a grava$$HEX2$$e700e300$$ENDHEX$$o do log por at$$HEX1$$e900$$ENDHEX$$ 3 vezes antes de retornar FALSE
li_Tentativas = 0
Do 
	li_Tentativas++
	lvi_Status = FileWrite( This.ivi_LOG, ls_json )	
	
	If lvi_Status <> LenA( ls_json ) Then gf_Delay( 2 )
	
Loop While ( lvi_Status <> LenA( ls_json ) Or li_Tentativas >= 3 )
//

If lvi_Status <> LenA( ls_json ) Then
	If Not gvb_Auto Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o.~r" + ls_json, StopSign! )
	End If
Else
	lvb_Retorno = True
End If

If lvb_Abre_Log Then
	lvb_Retorno = This.of_Fecha_Log( )
End If

Return lvb_Retorno
end function

public function string of_json_value (string as_value);// Retorna "null" se estiver vazio ou NULL, sen$$HEX1$$e300$$ENDHEX$$o retorna valor entre aspas, escapado
IF IsNull(as_value) OR Trim(as_value) = "" THEN
    RETURN "null"
END IF

// Escapar aspas e barras
string ls_aux
ls_aux = gf_Replace(as_value, "\", "\\", 0)      // barra invertida
ls_aux = gf_Replace(ls_aux, '"', '\"', 0)        // aspas dupla

RETURN '"' + ls_aux + '"'
end function

public function boolean of_grava_log_json (string ps_mensagem);return of_grava_log_json(ps_mensagem, 'INFO')
end function

public function boolean of_grava_log_txt (string ps_mensagem);Integer lvi_Status
Integer li_Tentativas

String lvs_Mensagem 

Boolean lvb_Abre_Log = False
Boolean lvb_Retorno 	 = False

If This.ivi_LOG = 0 Then
	lvb_Abre_Log = This.of_Abre_Log()
	
	If Not lvb_Abre_Log Then // Erro na abertura do log
		Return False
	End If
End If

lvs_Mensagem =	String(Today(), "dd/mm/yyyy") + " " + &
						String(Now(), "hh:mm:ss") + " " + ps_Mensagem
	
// Se der erro, tenta realizar a grava$$HEX2$$e700e300$$ENDHEX$$o do log por at$$HEX1$$e900$$ENDHEX$$ 3 vezes antes de retornar FALSE
li_Tentativas = 0
Do 
	li_Tentativas++
	lvi_Status = FileWrite( This.ivi_LOG, lvs_Mensagem )	
	
	If lvi_Status <> LenA( lvs_Mensagem ) Then gf_Delay( 2 )
	
Loop While ( lvi_Status <> LenA( lvs_Mensagem ) Or li_Tentativas >= 3 )
//

If lvi_Status <> LenA( lvs_Mensagem ) Then
	If Not gvb_Auto Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o.~r" + lvs_Mensagem, StopSign! )
	End If
Else
	lvb_Retorno = True
End If

If lvb_Abre_Log Then
	lvb_Retorno = This.of_Fecha_Log( )
End If

Return lvb_Retorno
end function

public function boolean of_grava_log (string ps_mensagem, string ps_nivel_log);if ivs_tipo_log = 'TXT' then
	return this.of_grava_log_txt(ps_mensagem)
else
	return this.of_grava_log_json(ps_mensagem, ps_nivel_log)
end if
end function

public subroutine of_setmicrohelp ();String lvs_Help, &
       lvs_ComputerName, &
		 lvs_UserId

If This.ivb_Aplicacao_Padrao Then
	If Trim(ivo_Seguranca.Nr_Matricula) <> "" Then
		lvs_Help = "Usu$$HEX1$$e100$$ENDHEX$$rio: " + Trim(ivo_Seguranca.Nm_Usuario) + " (" + String(ivo_Seguranca.Nr_Matricula) + ")"
	End If
	
	If Trim(lvs_Help) <> "" Then lvs_Help += "   ||   "
	
	If Trim(This.ivs_DataBase) <> "" Then
		//lvs_Help += "Banco de Dados: " + Upper(This.ivs_DataBase) + " - " + Upper(This.ivs_DataSource)
		lvs_Help += "BD: " + Upper(This.ivs_DataSource) + This.ivs_Servidor_BD
	End If
	
	If Trim(lvs_Help) <> "" Then lvs_Help += "   ||   "
	
	lvs_ComputerName = This.is_ComputerName
	lvs_UserId       = This.of_UserId()
	
	If Trim(lvs_ComputerName) <> "" Then
		lvs_Help += "Computador: " + Upper(Trim(lvs_ComputerName))
	End If
	
	If Trim(lvs_UserId) <> "" Then
		lvs_Help += " - " + Upper(Trim(lvs_UserId))
	End If
	
	if Trim(ivs_dado_extra_microhelp) <> "" Then
		If Trim(lvs_Help) <> "" Then lvs_Help += "   ||   "
		lvs_Help += Upper(Trim(ivs_dado_extra_microhelp))
	End If
	
	iapp_Aplicacao.MicroHelpDefault = lvs_Help
	
	If IsValid(dc_w_MDI) Then
		dc_w_MDI.SetMicroHelp(lvs_Help)
	End If
End If
end subroutine

public function string of_getfromini (string ps_secao, string ps_chave, boolean ab_mostra_mensagem);String lvs_Valor

lvs_Valor = ProfileString(ivs_Arquivo_INI, ps_Secao, ps_Chave, "")

If Trim(lvs_Valor) = "" and ab_mostra_mensagem Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor n$$HEX1$$e300$$ENDHEX$$o especificado no arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o.~r~r" + &
	                      "Arquivo : " + ivs_Arquivo_INI + "~r" + &
								 "Se$$HEX2$$e700e300$$ENDHEX$$o : " + ps_Secao + "~r" + &
								 "Chave : " + ps_Chave + ".", StopSign!)
End If

Return lvs_Valor
end function

on dc_uo_aplicacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_aplicacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/* Controle de alerta para commit em base de produ$$HEX2$$e700e300$$ENDHEX$$o executando a aplica$$HEX2$$e700e300$$ENDHEX$$o por dentro do PB */
This.ivb_Alerta_Commit_Producao = False

#IF DEFINED DEBUG Then 
	This.ivb_Alerta_Commit_Producao = True
#End If
/****/

// Indica se a aplica$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser executada mais de uma vez na mesma esta$$HEX2$$e700e300$$ENDHEX$$o
This.ivb_Unica_Execucao = True

iapp_Aplicacao = GetApplication()

ivo_historico = Create uo_log_alteracao

GetEnvironment(ienv_Ambiente)

If Not of_Formato_Data() Then Halt

// Coloca valor padr$$HEX1$$e300$$ENDHEX$$o de MicroHelp
iapp_Aplicacao.MicroHelpDefault = "Pronto..."

// Cria o objeto de gerenciamento da seguran$$HEX1$$e700$$ENDHEX$$a do sistema
ivo_Seguranca = Create dc_uo_Seguranca

//Telas Ativas
ivds_Telas = Create datastore
ivds_Telas.DataObject = 'ds_telas'

This.ivb_Aplicacao_Padrao = True

This.ivb_Conectar_Banco = True

This.ivb_Usa_Biometria = False

SetNull( This.idh_Primeiro_Alerta_Versao_Nova )

If Not DirectoryExists("C:\Sistemas\DLL") Then CreateDirectory("C:\Sistemas\DLL")

//Captura o nome da computador para evitar a chamada da fun$$HEX2$$e700e300$$ENDHEX$$o em v$$HEX1$$e100$$ENDHEX$$rios pontos do sistema
This.of_ComputerName( )
end event

event destructor;If IsValid(ivds_Telas) Then Destroy(ivds_Telas)
If IsValid(ivo_historico) Then Destroy(ivo_historico)

If IsValid( This.ivo_Seguranca ) Then
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CL' Or gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'RL' Then
		If IsValid(SQLCa) Then
			If SQLCa.of_IsConnected() Then
				SQLCa.of_Disconnect()
			End If
		End If
	End If
End If
end event

