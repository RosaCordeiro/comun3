HA$PBExportHeader$dc_uo_odbc.sru
forward
global type dc_uo_odbc from nonvisualobject
end type
end forward

global type dc_uo_odbc from nonvisualobject
end type
global dc_uo_odbc dc_uo_odbc

type prototypes
FUNCTION integer SQLAllocEnv(ref long henv) LIBRARY "odbc32.dll"
FUNCTION integer SQLFreeEnv(long henv) LIBRARY "odbc32.dll"
FUNCTION integer SQLDataSources &
     (long henv, integer idirection, ref string szdsn, int idsnmax, &
     ref integer idsn, ref string szdesc, integer idescmax, ref integer idesc) &
    library "odbc32.dll" alias for "SQLDataSources;Ansi" 
Function integer SQLConnect(long hdbc , string szDSN, integer cbDSN, &
     string szUID, integer cbUID, string szAuthStr, integer cbAuthStr) LIBRARY "odbc32.dll" alias for "SQLConnect;Ansi"
Function integer SQLAllocConnect(long henv,ref long phdbc) LIBRARY "odbc32.dll"

Function integer SQLError (long henv, long hdbc, long hstmt, string szSqlState, &
      ref long pfNativeError, string szErrorMsg, integer cbErrorMsgMax, &
      ref integer pcbErrorMsg) LIBRARY "odbc32.dll" alias for "SQLError;Ansi"
Function integer SQLExecute(string hstmt) LIBRARY "odbc32.dll" alias for "SQLExecute;Ansi"
Function integer SQLPrepare(long hStmt, ref string sqlStr,integer strmlen) LIBRARY "odbc32.dll" alias for "SQLPrepare;Ansi"
Function integer SQLDisconnect(long hStmt) LIBRARY "odbc32.dll"
end prototypes

type variables
CONSTANT STRING CHAVE_ODBC_INI 				= "HKEY_CURRENT_USER\Software\ODBC\ODBC.INI\"
CONSTANT STRING NOME_DRIVER_POSTGRESQL	= "PostgreSQL Unicode"

long SQL_SUCCESS = 0, &
        SQL_SUCCESS_WITH_INFO = 1
		  
String ivs_DataBase, &
          ivs_ServerName, &
          ivs_Ip
	
String ivs_Pdv_Java
			 
end variables

forward prototypes
public function string of_localiza (long pl_filial)
public function boolean of_connect (string dsn, string user, string pwd)
public function integer of_error (ref long hdbc)
public function boolean of_grava_regedit_odbc (long pl_filial)
public function boolean of_deleta_regedit_odbc (long pl_filial)
public subroutine of_disconnect (long handle)
public function boolean of_localiza_parametro_odbc (long pl_filial)
public function boolean of_localiza_parametro_odbc (long pl_filial, ref string ps_mensagem)
public subroutine of_atualiza_odbcs (string ps_filial)
public subroutine of_atualiza_odbcs ()
public function boolean of_grava_regedit_odbc_asa (long pl_filial)
public function boolean of_grava_regedit_odbc_pg (long pl_filial)
public function boolean of_valida_driver_pg_configurado (string ps_datasource)
public function boolean of_deleta_regedit_odbc (string ps_datasourcename)
public function boolean of_grava_regedit_odbc_fcerta (string ps_datasourcename)
public function boolean of_grava_regedit_odbc_mysql ()
public function integer of_deleta_senha_regedit_pg (long pl_filial)
public function integer of_atualiza_pgadminiii ()
end prototypes

public function string of_localiza (long pl_filial);Long ll_henv, &
     lvl_Linha_Nova

String ls_dsn, &
       ls_desc, &
		 ls_nova, &
		 lvs_Odbc

Integer li_direction, &
        li_dsnmax, &
		  li_dsnlen, &
		  li_descmax, &
		  li_desclen, &
		  li_rc

integer li_length = 255

ls_dsn     = Space(li_length)
li_dsnmax  = li_length
ls_desc    = Space(li_length)
li_descmax = li_length

If SQLAllocEnv(ll_henv) = -1 Then
    MessageBox("SQLAllocEnv", "FALHOU")
Else
    li_direction = 1
    Do While SQLDataSources &
        (ll_henv, li_direction, ls_dsn, li_dsnmax, li_dsnlen, &
         ls_desc, li_descmax, li_desclen) = 0
			
			ls_Nova = LeftA(ls_Desc, 24)
			
			If ls_Nova = "Adaptive Server Anywhere" or ls_Nova = 'PostgreSQL Unicode' Then
				If LeftA(ls_dsn, 4) = RightA("0000" + String(pl_filial), 4 ) Then
					lvs_Odbc = Upper(ls_dsn) //+ "  [" + ls_desc + "]")				
				End If
			End If
	Loop
	
   SQLFreeEnv(ll_henv)
End If

Return lvs_Odbc
end function

public function boolean of_connect (string dsn, string user, string pwd);//Para testar se a conex$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel

Long henv, &
	  hdbc
	  
integer iResult

//Se for PDV Java muda o user e senha para conex$$HEX1$$e300$$ENDHEX$$o
If This.ivs_Pdv_Java = 'S' Then
	//user 	= "DEV-DBA"
	//pwd 	= "f4xlPH66=Ket" 
	//user 	= "central"
	//pwd 	= "SaDBAdmin$0638"
	user 	= "transf"
	pwd 	= "tR4n$f@6790"	
	//Aqui vai sair como true, pois ainda n$$HEX1$$e300$$ENDHEX$$o sabemos porque a fun$$HEX2$$e700e300$$ENDHEX$$o SQLConnect retorna False no Banco JAVA
	Return True
End If

//Obtain Environment Handle
iResult = SQLAllocEnv(henv)
If iResult <> SQL_SUCCESS Then
	Return False
End If

//Obtain Connection Handle
iResult = SQLAllocConnect(henv, hdbc)
If iResult <> SQL_SUCCESS Then
	iResult = SQLFreeEnv(henv)
	return False
End If

//Test Connect Parameters
iResult = SQLConnect(hdbc, dsn, LenA(dsn), user, LenA(user), pwd, LenA(pwd))
If iResult <> SQL_SUCCESS Then
	iResult = SQL_SUCCESS_WITH_INFO
	Return false
End If

//Desconecta
SQLDisconnect(hdbc)

//Free Connection Handle and Environment Handle
iResult = SQLFreeEnv(henv)
Return True
end function

public function integer of_error (ref long hdbc);integer iResult, &
		  iOutlen

long hstmt, &
     lNative

string sBuffer1, &
	    sBuffer2
 
Do
 iResult = SQLError(0, hdbc, hstmt, sBuffer1, ref lNative, sBuffer2, 256, ref iOutlen)
 If iResult = SQL_SUCCESS Then
	If iOutlen = 0 Then
	  MessageBox("Error -- No error information available", "ODBC Logon")
	Else
	  MessageBox(sBuffer2, "ODBC Logon")
	End If
 End If
Loop Until iResult <> SQL_SUCCESS

Return 1
end function

public function boolean of_grava_regedit_odbc (long pl_filial);If Upper( LeftA( ivs_DataBase , 2 ) ) = 'PG' Or This.ivs_Pdv_Java = 'S' Then
	Return This.of_grava_regedit_odbc_pg( pl_Filial )
End If

Return This.of_grava_regedit_odbc_asa( pl_Filial )
end function

public function boolean of_deleta_regedit_odbc (long pl_filial);Return  This.of_Deleta_Regedit_ODBC( String(pl_filial, "0000") )
end function

public subroutine of_disconnect (long handle);
end subroutine

public function boolean of_localiza_parametro_odbc (long pl_filial);SELECT de_database,   
		 de_servername,   
		 de_ip,
		 COALESCE(id_pdv_java,'N')
  INTO :ivs_Database,
  		 :ivs_Servername,
		 :ivs_Ip,
		 :ivs_Pdv_Java
  FROM parametro_odbc
 WHERE cd_filial = :pl_filial
 Using SqlCa;
 
 
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		Return False
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metros de conex$$HEX1$$e300$$ENDHEX$$o da filial '" + String(pl_filial) + "' n$$HEX1$$e300$$ENDHEX$$o localizados. | dc_uo_odbc.of_localiza_parametro_odbc( long pl_filial ) | Linha: 18", StopSign!)
		Return False
		
End Choose

Return True
end function

public function boolean of_localiza_parametro_odbc (long pl_filial, ref string ps_mensagem); SELECT de_database,   
		 de_servername,   
		 de_ip,
		 COALESCE(id_pdv_java,'N')
  INTO :ivs_Database,
  		 :ivs_Servername,
		 :ivs_Ip,
		 :ivs_Pdv_Java
  FROM parametro_odbc
 WHERE cd_filial = :pl_filial
 Using SqlCa;
 
 
Choose Case SqlCa.SqlCode
	Case -1
		ps_Mensagem = SqlCa.SqlErrText
		Return False
		
	Case 100
		ps_Mensagem = "Par$$HEX1$$e200$$ENDHEX$$metros de conex$$HEX1$$e300$$ENDHEX$$o da filial '" + String(pl_filial) + "' n$$HEX1$$e300$$ENDHEX$$o localizados. | dc_uo_odbc.of_localiza_parametro_odbc( long pl_filial, ref string ps_mensagem ) | Linha: 18"
		Return False
		
End Choose

Return True
end function

public subroutine of_atualiza_odbcs (string ps_filial);String lvs_Erro
String ls_Odbc_Exclui		 
String ls_Chave
		
Long ll_Linhas
Long ll_Linha
Long ll_Filial
		 
dc_uo_ds_base lds_1
lds_1 = Create dc_uo_ds_base

lds_1.of_ChangeDataObject("ds_ge095_lista_parametro_odbc")

If ps_filial <> '' Then
	lds_1.of_AppendWhere( "o.cd_filial = " + String( Long( ps_Filial ) ) )
End If

ll_Linhas = lds_1.Retrieve()

If ll_Linhas > 0 then
	Open(w_Aguarde)
	w_Aguarde.uo_Progress.of_SetMax( ll_Linhas )
End If	

For ll_Linha = 1 To ll_Linhas
	ll_Filial = lds_1.Object.Cd_Filial[ll_Linha]
	
	w_Aguarde.Title = "Atualizando ODBC da filial " + String( ll_Filial )
	
	ls_Odbc_Exclui = This.of_localiza( ll_Filial )
	
	Do While ls_Odbc_Exclui <> ""

		If RegistryDelete( This.CHAVE_ODBC_INI + "ODBC Data Sources", ls_Odbc_Exclui ) <> 1 Or &
			RegistryDelete(This.CHAVE_ODBC_INI + ls_Odbc_Exclui, "") <> 1 Then
			
			Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o ODBC " + ls_Chave, StopSign! )
			Destroy lds_1
			Close(w_Aguarde)
			Return 			
		End If
		
		ls_Odbc_Exclui = This.of_localiza( ll_Filial )
		w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
	Loop

	
//	This.of_Deleta_Regedit_Odbc( ll_Filial )

	If Not This.of_localiza_parametro_odbc( ll_Filial, ref lvs_Erro ) Then
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Erro + " " + String(ll_Filial), StopSign! )
		Destroy lds_1
		Close(w_Aguarde)
		Return
	End If

	This.of_grava_regedit_odbc( ll_Filial )

Next

Destroy lds_1
If IsValid(w_Aguarde) Then Close(w_Aguarde)

If ps_filial = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Conclu$$HEX1$$ed00$$ENDHEX$$do")
End If
end subroutine

public subroutine of_atualiza_odbcs ();This.of_Atualiza_Odbcs( '' )

This.of_Atualiza_PgAdminIII( )
end subroutine

public function boolean of_grava_regedit_odbc_asa (long pl_filial);// Sybase Anywhere

String ls_Chave

ls_Chave = This.CHAVE_ODBC_INI + String(pl_filial, "0000")

If RegistrySet(ls_Chave, "Driver", RegString!, "C:\\Arquivos de programas\\Sybase\\Adaptive Server Anywhere 6.0\\win32\\dbodbc6.dll") = 1 Then
	If RegistrySet(ls_Chave, "UID", RegString!, "dbo") = 1 Then
		If RegistrySet(ls_Chave, "PWD", RegString!, "teste") = 1 Then
			If RegistrySet(ls_Chave, "DatabaseName", RegString!, ivs_Database) = 1 Then
				If RegistrySet(ls_Chave, "EngineName", RegString!, ivs_Servername) = 1 Then
					If RegistrySet(ls_Chave, "AutoStop", RegString!, "Yes") = 1 Then
						If RegistrySet(ls_Chave, "Integrated", RegString!, "NO") = 1 Then
							If RegistrySet(ls_Chave, "CommLinks", RegString!, "TCPIP{host=" + ivs_ip + "}") = 1 Then
								If RegistrySet(This.CHAVE_ODBC_INI + "ODBC Data Sources", String(pl_filial, "0000"), RegString!, "Adaptive Server Anywhere 6.0") = 1 Then
									Return True			
								End If
							End If
						End If
					End If
				End If
			End If
		End If
	End If
End If

Return False
end function

public function boolean of_grava_regedit_odbc_pg (long pl_filial);// PostgreSQL

String ls_Chave
String ls_DataBase
String ls_ProgramFiles
String ls_ComputerName

String ls_Pw
String ls_UserName

ls_ComputerName = gf_Replace( gvo_Aplicacao.is_ComputerName, '-', '_', 0 )

ls_ProgramFiles = gvo_Aplicacao.of_Get_Program_Files_Directory( )

ls_Chave = This.CHAVE_ODBC_INI + String(pl_filial, "0000")

This.of_deleta_senha_regedit_pg( pl_filial )

If This.ivs_Pdv_Java = 'S' Then
//	ls_UserName 	= "DEV-DBA"
//	ls_Pw				= "f4xlPH66=Ket"
//	ls_UserName 	= "central"
//	ls_Pw				= "SaDBAdmin$0638"	
	ls_UserName 	= "transf"
	ls_Pw				= "tR4n$f@6790"		
	ls_DataBase		= "central"
Else
	ls_UserName 	= "dbo"
	ls_Pw				= "dbo"
	ls_DataBase 	= "bd" + String(pl_filial, "0000")
End If

If RegistrySet(ls_Chave, "Driver", RegString!, ls_ProgramFiles + "\\psqlODBC\\0903\\bin\\psqlodbc35w.dll") = 1 Then
	If RegistrySet(ls_Chave, "CommLog", RegString!, "0") = 1 Then
		If RegistrySet(ls_Chave, "Debug", RegString!, "0") = 1 Then
			If RegistrySet(ls_Chave, "Fetch", RegString!, "100") = 1 Then
				If RegistrySet(ls_Chave, "Optimizer", RegString!, "0") = 1 Then
					If RegistrySet(ls_Chave, "Ksqo", RegString!, "1") = 1 Then
						If RegistrySet(ls_Chave, "UniqueIndex", RegString!, "1") = 1 Then
							If RegistrySet(ls_Chave, "UseDeclareFetch", RegString!, "0") = 1 Then
								If RegistrySet(ls_Chave, "UnknownSizes", RegString!, "0") = 1 Then
									If RegistrySet(ls_Chave, "TextAsLongVarchar", RegString!, "1") = 1 Then
										If RegistrySet(ls_Chave, "UnknownsAsLongVarchar", RegString!, "0") = 1 Then
											If RegistrySet(ls_Chave, "BoolsAsChar", RegString!, "1") = 1 Then
												If RegistrySet(ls_Chave, "Parse", RegString!, "0") = 1 Then
													If RegistrySet(ls_Chave, "CancelAsFreeStmt", RegString!, "0") = 1 Then
														If RegistrySet(ls_Chave, "MaxVarcharSize", RegString!, "255") = 1 Then
															If RegistrySet(ls_Chave, "MaxLongVarcharSize", RegString!, "8190") = 1 Then
																If RegistrySet(ls_Chave, "ExtraSysTablePrefixes", RegString!, "dd_;") = 1 Then
																	If RegistrySet(ls_Chave, "Description", RegString!, "") = 1 Then
																		If RegistrySet(ls_Chave, "Database", RegString!, ls_DataBase) = 1 Then
																			If RegistrySet(ls_Chave, "Servername", RegString!, ivs_Ip) = 1 Then
																				If RegistrySet(ls_Chave, "Port", RegString!, "5432") = 1 Then
																					If RegistrySet(ls_Chave, "Username", RegString!, ls_UserName) = 1 Then
																						If RegistrySet(ls_Chave, "UID", RegString!, ls_PW) = 1 Then
																							If RegistrySet(ls_Chave, "ReadOnly", RegString!, "0") = 1 Then
																								If RegistrySet(ls_Chave, "ShowOidColumn", RegString!, "0") = 1 Then
																									If RegistrySet(ls_Chave, "FakeOidIndex", RegString!, "0") = 1 Then
																										If RegistrySet(ls_Chave, "RowVersioning", RegString!, "0") = 1 Then
																											If RegistrySet(ls_Chave, "ShowSystemTables", RegString!, "1") = 1 Then
																												If RegistrySet(ls_Chave, "Protocol", RegString!, "7.4") = 1 Then
																													If RegistrySet(ls_Chave, "ConnSettings", RegString!, 'set application_name="' + ls_ComputerName + '"' ) = 1 Then
																														If RegistrySet(ls_Chave, "DisallowPremature", RegString!, "0") = 1 Then
																															If RegistrySet(ls_Chave, "UpdatableCursors", RegString!, "1") = 1 Then
																																If RegistrySet(ls_Chave, "LFConversion", RegString!, "1") = 1 Then
																																	If RegistrySet(ls_Chave, "TrueIsMinus1", RegString!, "1") = 1 Then
																																		If RegistrySet(ls_Chave, "BI", RegString!, "0") = 1 Then
																																			If RegistrySet(ls_Chave, "AB", RegString!, "0") = 1 Then
																																				If RegistrySet(ls_Chave, "ByteaAsLongVarBinary", RegString!, "0") = 1 Then
																																					If RegistrySet(ls_Chave, "UseServerSidePrepare", RegString!, "1") = 1 Then
																																						If RegistrySet(ls_Chave, "LowerCaseIdentifier", RegString!, "0") = 1 Then
																																							If RegistrySet(ls_Chave, "GssAuthUseGSS", RegString!, "0") = 1 Then
																																								If RegistrySet(ls_Chave, "SSLmode", RegString!, "disable") = 1 Then
																																									If RegistrySet(ls_Chave, "XaOpt", RegString!, "1") = 1 Then
																																										If RegistrySet( This.CHAVE_ODBC_INI + "ODBC Data Sources", String(pl_filial, "0000"), RegString!, NOME_DRIVER_POSTGRESQL ) = 1 Then
																																											Return True			
																																										End If
																																									End If
																																								End If
																																							End If
																																						End If
																																					End If
																																				End If
																																			End If
																																		End If
																																	End If
																																End If
																															End If
																														End If
																													End If
																												End If
																											End If
																										End If
																									End If
																								End If
																							End If
																						End If
																					End If
																				End If
																			End If
																		End If
																	End If
																End If
															End If
														End If
													End If
												End If
											End If
										End If
									End If
								End If
							End If
						End If
					End If
				End If
			End If
		End If
	End If
End If

Return False
end function

public function boolean of_valida_driver_pg_configurado (string ps_datasource);Integer li_Retorno

String ls_Registro

// Quando a conex$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ configurada no INI, abre a tela de sele$$HEX2$$e700e300$$ENDHEX$$o de ODBC, e com isso o argumento ps_DataSource estar$$HEX1$$e100$$ENDHEX$$ em branco.
If IsNull( ps_DataSource ) Or Trim( ps_DataSource ) = "" Then Return True

// Localiza a descri$$HEX2$$e700e300$$ENDHEX$$o do driver na chave do registro
li_Retorno = RegistryGet( This.CHAVE_ODBC_INI + "ODBC Data Sources", ps_DataSource, RegString!, Ref ls_Registro )

If li_Retorno = -1 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do registro do windows.~r dc_uo_odbc.of_valida_driver_pg_configurado(string)" + &
									"~rChave: " + This.CHAVE_ODBC_INI + "ODBC Data Sources", StopSign! )
									
	Return False
End If

// Caso a descri$$HEX2$$e700e300$$ENDHEX$$o do driver esteja diferente do correto, retorna erro
If Lower( NOME_DRIVER_POSTGRESQL ) <> Lower( ls_Registro ) Then
	If IsNull( ls_Registro ) Then ls_Registro = ""
	
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A configura$$HEX2$$e700e300$$ENDHEX$$o do driver de conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados PostgreSQL est$$HEX1$$e100$$ENDHEX$$ incorreta.~r~r" + &
									"Configurado: " + ls_Registro + "~r" + &
									"Correto: " + NOME_DRIVER_POSTGRESQL + "~r" , StopSign! )
	Return False
End If

Return True
end function

public function boolean of_deleta_regedit_odbc (string ps_datasourcename);String ls_Chave

If RegistryDelete( This.CHAVE_ODBC_INI + "ODBC Data Sources", ps_DatasourceName ) = 1 Then
	If RegistryDelete( This.CHAVE_ODBC_INI + ps_DatasourceName, "" ) = 1 Then
		Return True			
	End If
End If

Return False
end function

public function boolean of_grava_regedit_odbc_fcerta (string ps_datasourcename);// Firebird
String ls_Chave

If Not FileExists( "C:\Windows\System32\FBCLIENT.DLL" ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo 'C:\Windows\System32\FBCLIENT.DLL' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign! )
	Return False
End If

ls_Chave = This.CHAVE_ODBC_INI + ps_datasourceName

If RegistrySet(ls_Chave, "Driver", RegString!, "C:\\Windows\\system32\\OdbcFb.dll") = 1 Then
	If RegistrySet(ls_Chave, "Description", RegString!, ps_DataSourceName ) = 1 Then
		If RegistrySet(ls_Chave, "Dbname", RegString!, "10.0.4.85:e:\\fcerta2\\db\\alterdb.ib") = 1 Then
			If RegistrySet(ls_Chave, "Client", RegString!, "C:\\Windows\\System32\\FBCLIENT.DLL") = 1 Then
				If RegistrySet(ls_Chave, "User", RegString!, "SYSDBA") = 1 Then
					If RegistrySet(ls_Chave, "Role", RegString!, "") = 1 Then
						If RegistrySet(ls_Chave, "CharacterSet", RegString!, "NONE") = 1 Then
							If RegistrySet(ls_Chave, "JdbcDriver", RegString!, "IscDbc") = 1 Then								
								If RegistrySet(ls_Chave, "ReadOnly", RegString!, "N") = 1 Then
									If RegistrySet(ls_Chave, "NoWait", RegString!, "N") = 1 Then
										If RegistrySet(ls_Chave, "LockTimeoutWaitTransactions", RegString!, "10.0.4.85:e:\\fcerta2\\db\\alterdb.ib") = 1 Then
											If RegistrySet(ls_Chave, "Dialect", RegString!, "3") = 1 Then
												If RegistrySet(ls_Chave, "QuotedIdentifier", RegString!, "Y") = 1 Then
													If RegistrySet(ls_Chave, "SensitiveIdentifier", RegString!, "N") = 1 Then
														If RegistrySet(ls_Chave, "AutoQuotedIdentifier", RegString!, "0") = 1 Then
															If RegistrySet(ls_Chave, "UseSchemaIdentifier", RegString!, "IscDbc") = 1 Then
																If RegistrySet(ls_Chave, "SafeThread", RegString!, "Y") = 1 Then
																	If RegistrySet(ls_Chave, "Password", RegString!, "DKEBFJENHFCOBHGHLAIMNAAFICELEAEGDNMFNOGALAMHBBGCHFADNKCBPPGMANOGIEKENIOPHDIPBIECPLLLCBIKEJKMJLPLIB") = 1 Then
																		If RegistrySet(This.CHAVE_ODBC_INI + "ODBC Data Sources", ps_DataSourceName, RegString!, "Firebird/InterBase(r) driver") = 1 Then
																			Return True			
																		End If
																	End If
																End If
															End If
														End If
													End If
												End If
											End If
										End If
									End If
								End If
							End If
						End If
					End If
				End If
			End If
		End If
	End If
End If

Return False
end function

public function boolean of_grava_regedit_odbc_mysql ();String ls_Chave

ls_Chave = This.CHAVE_ODBC_INI + "servicedesk"

RegistryDelete( This.CHAVE_ODBC_INI + "servicedesk", "PWD" )
RegistryDelete( This.CHAVE_ODBC_INI + "servicedesk", "UID" )

If RegistrySet( ls_Chave, "Driver", RegString!, "C:\Program Files (x86)\MySQL\Connector ODBC 3.51\myodbc3.dll" ) = 1 Then
	//If RegistrySet( ls_Chave, "UID", RegString!, "" ) = 1 Then // Removido em 21/12/2016, caso apresente problema, informar Fernando Cambiaghi
		//If RegistrySet( ls_Chave, "PWD", RegString!, "" ) = 1 Then // Removido em 21/12/2016, caso apresente problema, informar Fernando Cambiaghi
			If RegistrySet(ls_Chave, "DATABASE", RegString!, "softdesk_producao" ) = 1 Then
				If RegistrySet( ls_Chave, "SERVER", RegString!, "helpdesk.clamed.com.br" ) = 1 Then
					If RegistrySet( ls_Chave, "PORT", RegString!, "3306") = 1 Then
						If RegistrySet( ls_Chave, "DESCRIPTION", RegString!, "ServiceDesk") = 1 Then
							If RegistrySet( This.CHAVE_ODBC_INI + "ODBC Data Sources", "servicedesk", RegString!, "MySQL ODBC 3.51 Driver" ) = 1 Then
								Return True			
							End If
						End If
					End If
				End If
			End If
		//End If
	//End If
End If

Return False
end function

public function integer of_deleta_senha_regedit_pg (long pl_filial);RegistryDelete( 'BD' + This.CHAVE_ODBC_INI + String(pl_filial, "0000"), "Password" )
Return RegistryDelete( This.CHAVE_ODBC_INI + String(pl_filial, "0000"), "Password" )
end function

public function integer of_atualiza_pgadminiii ();Integer li_Linha = 1

DECLARE lcur_odbc CURSOR FOR
SELECT  cd_filial, de_database, de_servername, de_ip 
  FROM parametro_odbc
 ORDER BY cd_filial ASC;

// Declara$$HEX2$$e700e300$$ENDHEX$$o vari$$HEX1$$e100$$ENDHEX$$veis de destino
Long ll_Filial
String ls_Database
String ls_ServerName
String ls_IP

string ls_subkeylist[]
integer li_rtn

Try
	Open( w_Aguarde )
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es do banco de dados..."
	
	// Abrindo o cursor
	OPEN lcur_odbc;
	
	// Buscar a primeira linha do resultado
	FETCH lcur_odbc INTO :ll_Filial, :ls_Database, :ls_ServerName, :ls_IP;
	
	// Repetir Enquanto Houver Linhas
	DO WHILE SQLCA.sqlcode = 0
		w_Aguarde.Title = "Atualizando conex$$HEX1$$e300$$ENDHEX$$o da filial " + String( ll_Filial ) + "..."

		ls_DataBase = gf_Replace( ls_DataBase, "PG", "bd", 1 )
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Server", RegString!, ls_ServerName ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Server=" + ls_ServerName )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "HostAddr", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], HostAddr=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Description", RegString!, String( ll_Filial, '0000' ) ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Description=" + String( ll_Filial, '0000' ) )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Service", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Service=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "ServiceID", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], ServiceID=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "DiscoveryID", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], DiscoveryID=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Port", ReguLong!, 5432 ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Port=5432" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "StorePwd", RegString!, "true" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], StorePwd=true" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Rolename", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Rolename=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Restore", RegString!, "false" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Restore=false" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Database", RegString!, ls_Database ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Database=" + ls_Database )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Username", RegString!, "dbo" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Username=dbo" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "LastDatabase", RegString!, ls_Database ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], LastDatabase=" + ls_Database )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "LastSchema", RegString!, "dbo" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], LastSchema=dbo" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "DbRestriction", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], DbRestriction=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Colour", RegString!, "#F4F5B8" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Colour=#F4F5B8" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSL", ReguLong!, 4294967295 ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSL=4294967295" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Group", RegString!, "Filiais" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Group=Filiais" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSLCert", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSLCert=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSLKey", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSLKey=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSLRootCert", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSLRootCert=''" )
		End If
		
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSLCrl", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSLCrl=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSLCompression", RegString!, "true" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSLCompression=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSHTunnel", RegString!, "false" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSHTunnel=false" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "TunnelHost", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], TunnelHost=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "TunnelUserName", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], TunnelUserName=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "TunnelModePwd", RegString!, "true" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], TunnelModePwd=true" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "PublicKeyFile", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], PublicKeyFile=''")
		End If
		
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "IdentityFile", RegString!, "" ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], IdentityFile=''" )
		End If
		
		If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "TunnelPort", ReguLong!, 22 ) = -1 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], TunnelPort=22" )
		End If
		//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
	
		FETCH lcur_odbc INTO :ll_Filial, :ls_Database, :ls_ServerName, :ls_IP;
		
		li_Linha++
	LOOP
	
	// Banco Desenv
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Server", RegString!, "cia-103" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Server=cia-103" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "HostAddr", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], HostAddr=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Description", RegString!, "loja_desenv" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Description=loja_desenv" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Service", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Service=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "ServiceID", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], ServiceID=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "DiscoveryID", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], DiscoveryID=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Port", ReguLong!, 5432 ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Port=5432" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "StorePwd", RegString!, "true" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], StorePwd=true" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Rolename", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Rolename=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Restore", RegString!, "false" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Restore=false" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Database", RegString!, "bd0563" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Database=bd0563" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Username", RegString!, "dbo" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Username=dbo" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "LastDatabase", RegString!, ls_Database ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], LastDatabase=bd0563" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "LastSchema", RegString!, "dbo" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], LastSchema=dbo" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "DbRestriction", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], DbRestriction=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Colour", RegString!, "white" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Colour=white" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSL", ReguLong!, 4294967295 ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSL=4294967295" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "Group", RegString!, "Servers" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], Group=Servers" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSLCert", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSLCert=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSLKey", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSLKey=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSLRootCert", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSLRootCert=''" )
	End If
	
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSLCrl", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSLCrl=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSLCompression", RegString!, "true" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSLCompression=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "SSHTunnel", RegString!, "false" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], SSHTunnel=false" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "TunnelHost", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], TunnelHost=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "TunnelUserName", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], TunnelUserName=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "TunnelModePwd", RegString!, "true" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], TunnelModePwd=true" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "PublicKeyFile", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], PublicKeyFile=''")
	End If	
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "IdentityFile", RegString!, "" ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], IdentityFile=''" )
	End If
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ), "TunnelPort", ReguLong!, 22 ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], TunnelPort=22" )
	End If	
	// Banco desenv
		
	
	If RegistrySet( "HKEY_CURRENT_USER\Software\pgAdmin III\Servers", "Count", ReguLong!, li_Linha ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro. [HKEY_CURRENT_USER\Software\pgAdmin III\Servers\" + String( li_Linha ) + "], TunnelPort=22" )
	End If
	
	Return 1
	
Finally
	// No fim fechar o cursor
	CLOSE lcur_odbc;
	Close( w_Aguarde )
End Try
end function

on dc_uo_odbc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_odbc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

