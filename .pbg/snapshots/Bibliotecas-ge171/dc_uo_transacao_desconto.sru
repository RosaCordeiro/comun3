HA$PBExportHeader$dc_uo_transacao_desconto.sru
forward
global type dc_uo_transacao_desconto from transaction
end type
end forward

global type dc_uo_transacao_desconto from transaction
end type
global dc_uo_transacao_desconto dc_uo_transacao_desconto

type variables
string ivs_database, &
         ivs_usuario = "", &
         ivs_senha = ""
end variables

forward prototypes
public subroutine of_msgdberror ()
public subroutine of_logdberror (integer pi_Arquivo)
public subroutine of_msgdberror (long pl_sqldbcode, string ps_sqlerrtext)
public subroutine of_msgdberror (string ps_mensagem)
public function boolean of_isconnected ()
public function integer of_disconnect ()
public subroutine of_setdatabase (string ps_database)
public function boolean of_connect (string ps_datasource, string ps_hostname)
public function boolean of_connect (string ps_arquivo_ini)
public function integer of_commit ()
public function integer of_rollback ()
public subroutine of_logdberror (integer pi_arquivo, string ps_parametro)
public subroutine of_msgdberror (long pl_sqldbcode, string ps_sqlerrtext, string ps_parametro)
end prototypes

public subroutine of_msgdberror ();String lvs_Nulo

Long lvl_Nulo

SetNull(lvl_Nulo)
SetNull(lvs_Nulo)

This.of_MsgdbError(lvl_Nulo, lvs_Nulo, "")
end subroutine

public subroutine of_logdberror (integer pi_Arquivo);This.of_LogdbError(pi_Arquivo, "")
end subroutine

public subroutine of_msgdberror (long pl_sqldbcode, string ps_sqlerrtext);This.of_MsgdbError(pl_SqldbCode, ps_SqlErrText, "")
end subroutine

public subroutine of_msgdberror (string ps_mensagem);String lvs_Nulo

Long lvl_Nulo

SetNull(lvl_Nulo)
SetNull(lvs_Nulo)

This.of_MsgdbError(lvl_Nulo, lvs_Nulo, ps_Mensagem)
end subroutine

public function boolean of_isconnected ();If This.dbHandle() = 0 Then
	Return False
Else
	Return True
End If
end function

public function integer of_disconnect ();Integer lvi_Retorno

Disconnect Using This;

lvi_Retorno = This.SqlCode

If lvi_Retorno = -1 Then
	This.of_MsgdbError()
End If

Return lvi_Retorno
end function

public subroutine of_setdatabase (string ps_database);This.ivs_DataBase = ps_DataBase
end subroutine

public function boolean of_connect (string ps_datasource, string ps_hostname);Choose Case Upper(This.ivs_DataBase)
	Case "SYBASE"
		This.DBMS       = "SYC Sybase System 10/11"
		This.Database   = ps_DataSource
		This.AutoCommit = True
		This.dbParm     = "CharSet='roman8', DateTimeAllowed='Yes', Release='11', Host='" + ps_HostName + &
		                   "', AppName='" + ps_HostName + "', CommitOnDisconnect='No'"		
		
		If Upper(ps_DataSource) = "CENTRAL_DES" Then
			gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
			This.ServerName = "SybaseCentral"			
			This.LogId      = "Desenvolvimento"
			This.LogPass    = "desenv"
		ElseIf Upper(ps_DataSource) = "CENTRAL" Then
			This.ServerName = "SybaseCentral"			
			This.LogId      = "sistemas"
			This.LogPass    = "PrdSyb2023K@a"
		ElseIf Upper(ps_DataSource) = "HOMOLOGACAO" Then
			gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
			This.ServerName = "SybaseHomologa"			
			This.LogId      = "sistemas"
			This.LogPass    = "HmgSyb2023K@a"
		End If
		
	Case "ANYWHERE"
		This.DBMS       = "ODBC"
		This.AutoCommit = False
		This.dbParm     = "ConnectString='UID=dbo;PWD=teste;DSN=" + ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + &
		                   "CommitOnDisconnect='No'"		
		This.DataBase   = ps_DataSource
		
	Case "MYSQL"
		If This.ivs_Usuario = "" Then ivs_Usuario = "root"
		If This.ivs_Senha   = "" Then ivs_Usuario = "admin"
		
		This.DBMS       = "ODBC"
		This.AutoCommit = False
		This.dbParm     = "ConnectString='UID=" + This.ivs_Usuario + ";PWD=" + This.ivs_Senha + ";DSN=" + &
		                  ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + "CommitOnDisconnect='No'"		
		This.DataBase   = ps_DataSource
								 
	Case "AS/400"
		This.DBMS   = "ODBC"
		This.dbParm = "ConnectString =~'UID=DROGARIA;PWD=DROGARIA;DSN=" + ps_DataSource + "~'"
		
	Case "SQLSERVER"
		String lvs_DLL1, &
	   		 lvs_DLL2, &
	   		 lvs_Path
	   
		Integer lvi_Retorno
		
		If FileExists("C:\WINNT") Then
			lvs_Path = "C:\WINNT"
		Else
			lvs_Path = "C:\WINDOWS"
		End If
		
		// Estes arquivos s$$HEX1$$e300$$ENDHEX$$o necess$$HEX1$$e100$$ENDHEX$$rios para conectar ao banco do RH
		lvs_DLL1 = Upper(lvs_Path + "\system32\ntwdblib.dll")
		lvs_DLL2 = Upper(lvs_Path + "\system32\pbmss60.dll")
		
		If Not FileExists(lvs_DLL1) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo DLL '" + lvs_DLL1 + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado'.", StopSign!)
			Return False
		End If
		
		If Not FileExists(lvs_DLL2) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo DLL '" + lvs_DLL2 + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado'.", StopSign!)
			Return False
		End If
		
		// Profile RH
		This.DBMS       = "MSS Microsoft SQL Server 6.5"
		This.Database   = "dbsenior"
		This.LogPass    = "gambiarra"
		This.ServerName = "cia-05\clamed"
		This.LogId      = "intranet"
		This.AutoCommit = False
		
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Banco de dados '" + This.ivs_DataBase + "' n$$HEX1$$e300$$ENDHEX$$o especificado. '" + ps_DataSource + "'", StopSign!)
		Return False
End Choose

Connect Using This;

If This.SqlCode = -1 Then
	If Upper(This.ivs_DataBase) = "ANYWHERE" Then
		If This.SqldbCode = -102 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A conex$$HEX1$$e300$$ENDHEX$$o '" + ps_DataSource + "' excedeu o n$$HEX1$$fa00$$ENDHEX$$mero de usu$$HEX1$$e100$$ENDHEX$$rios permitido para acesso ao sistema.", StopSign!)
		Else	
			This.of_MsgdbError("Conex$$HEX1$$e300$$ENDHEX$$o com o Banco de Dados")
		End If
	Else
		This.of_MsgdbError("Conex$$HEX1$$e300$$ENDHEX$$o com o Banco de Dados")
	End If
	
	Return False
Else
	Return True
End If
end function

public function boolean of_connect (string ps_arquivo_ini);String lvs_DataSource, &
		 lvs_HostName

// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia do arquivo INI
If Not FileExists(ps_Arquivo_INI) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o " + ps_Arquivo_INI + " n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Return False
End If

// Atribui valores para a conex$$HEX1$$e300$$ENDHEX$$o com o Banco de Dados
ivs_DataBase   = ProfileString(ps_Arquivo_INI, "DataBase", "DataBase", "")
lvs_DataSource = ProfileString(ps_Arquivo_INI, "DataBase", "DataSource", "")
//lvs_HostName   = ProfileString(ps_Arquivo_INI, "DataBase", "HostName", "")
If IsValid(gvo_Aplicacao) Then
	lvs_HostName   = gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + "_" + gvo_Aplicacao.of_UserId()
Else
	lvs_HostName   = ProfileString(ps_Arquivo_INI, "DataBase", "HostName", "")
End If

Return This.of_Connect(lvs_DataSource, lvs_HostName)
end function

public function integer of_commit ();Commit Using This;

If This.SqlCode = -1 Then
	This.of_MsgdbError()
End If

Return This.SqlCode
end function

public function integer of_rollback ();RollBack Using This;

If This.SqlCode = -1 Then
	This.of_MsgdbError()
End If

Return This.SqlCode
end function

public subroutine of_logdberror (integer pi_arquivo, string ps_parametro);String lvs_Mensagem

dc_uo_dbError lvo_dbError
lvo_dbError = Create dc_uo_dbError

If This.SqlCode = -1 Then
	lvs_Mensagem = "C$$HEX1$$f300$$ENDHEX$$digo:  " + String(This.SqldbCode) + "~r" + &
						"Descri$$HEX2$$e700e300$$ENDHEX$$o:" + This.SqlErrText
Else
	lvs_Mensagem = ""					
End If
					
lvo_dbError.ivl_SqldbCode  = This.SqldbCode
lvo_dbError.ivs_SqlErrText = This.SqlErrText
lvo_dbError.ivs_DataBase   = This.ivs_DataBase
lvo_dbError.ivs_Mensagem   = lvs_Mensagem
lvo_dbError.ivs_Parametro  = ps_Parametro

lvo_dbError.of_Log_Erro(pi_Arquivo)

// Trata se ocorreu algum problema durante a transa$$HEX2$$e700e300$$ENDHEX$$o(-85) e 
// perdeu a conex$$HEX1$$e300$$ENDHEX$$o(-308)
If This.SqldbCode = -85 or This.SqldbCode = -308 Then
	Halt Close
End If

Destroy(lvo_dbError)
end subroutine

public subroutine of_msgdberror (long pl_sqldbcode, string ps_sqlerrtext, string ps_parametro);String lvs_Mensagem

dc_uo_dbError lvo_dbError
lvo_dbError = Create dc_uo_dbError

If Trim(ps_Parametro) <> "" Then
	lvs_Mensagem = "Ocorreu um erro de base de dados.~r~n~r~n~r~n" + &
						"Par$$HEX1$$e200$$ENDHEX$$metro: " + ps_Parametro + "~r~n~r~n" + &
						"C$$HEX1$$f300$$ENDHEX$$digo:  " + String(This.SqldbCode) + "~r~n~r~n" + &
						"Descri$$HEX2$$e700e300$$ENDHEX$$o:~r~n" + This.SqlErrText
Else
	lvs_Mensagem = "Ocorreu um erro de base de dados.~r~n~r~n~r~n" + &
						"C$$HEX1$$f300$$ENDHEX$$digo:  " + String(This.SqldbCode) + "~r~n~r~n" + &
						"Descri$$HEX2$$e700e300$$ENDHEX$$o:~r~n" + This.SqlErrText
End If

If Not IsNull(pl_SqldbCode) Then
	lvo_dbError.ivl_SqldbCode = pl_SqldbCode
Else
	lvo_dbError.ivl_SqldbCode = This.SqldbCode		
End If

If Not IsNull(ps_SqlErrText) Then
	lvo_dbError.ivs_SqlErrText = ps_SqlErrText
Else
	lvo_dbError.ivs_SqlErrText = This.SqlErrText
End If

lvo_dbError.ivs_DataBase  = This.ivs_DataBase
lvo_dbError.ivs_Mensagem  = lvs_Mensagem
lvo_dbError.ivs_Parametro = ps_Parametro

lvo_dbError.of_Trata_Erro()

Destroy(lvo_dbError)
end subroutine

on dc_uo_transacao_desconto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_transacao_desconto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

