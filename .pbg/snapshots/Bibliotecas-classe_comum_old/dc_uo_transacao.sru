HA$PBExportHeader$dc_uo_transacao.sru
forward
global type dc_uo_transacao from transaction
end type
end forward

global type dc_uo_transacao from transaction
end type
global dc_uo_transacao dc_uo_transacao

type variables
Private String ivs_Erro_Saida_Padrao = 'MESSAGEBOX'

string ivs_database
String ivs_Usuario = ""
		 
String is_LastErrorText	= ''
Integer ii_LastErrorCode
			
Boolean StandAlone			= False		
Boolean Exibe_Notificacao	= True
Boolean Banco_Producao		= True

dc_uo_dbError ivo_dbError
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
public function string of_dbms_name ()
public subroutine of_pg_elimina_conexoes_inativas ()
public subroutine of_set_application_name (string ps_name)
public subroutine of_end_transaction ()
public function boolean of_connect (string ps_datasource, string ps_hostname, boolean pb_mensagem)
public function string of_get_erro_saida_padrao ()
public subroutine of_set_erro_saida_padrao (string ps_valor)
public function decimal of_get_sybase_pc_log_in_use ()
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
	If Exibe_Notificacao Then This.of_MsgdbError()
End If

Return lvi_Retorno
end function

public subroutine of_setdatabase (string ps_database);This.ivs_DataBase = ps_DataBase
end subroutine

public function boolean of_connect (string ps_datasource, string ps_hostname);Return Of_Connect(ps_datasource,ps_hostname,True)
end function

public function boolean of_connect (string ps_arquivo_ini);String	lvs_DataSource, &
		lvs_HostName, &
		lvs_Ini
		
lvs_Ini = "c:\sistemas\vv\exe\verifica_versao.ini" // Ini padr$$HEX1$$e300$$ENDHEX$$o para conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados

// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia do arquivo INI
If Not FileExists( lvs_Ini ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o " + lvs_Ini + " n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign! )
	Return False
End If

// Procura pela chave com o c$$HEX1$$f300$$ENDHEX$$digo do sistema, se encontrar, utiliza os valores da chave, sen$$HEX1$$e300$$ENDHEX$$o, usa os valores da chave database
ivs_DataBase	= ProfileString( lvs_Ini, gvo_Aplicacao.ivo_Seguranca.Cd_Sistema, "DataBase", "" )
lvs_DataSource	= ProfileString( lvs_Ini, gvo_Aplicacao.ivo_Seguranca.Cd_Sistema, "DataSource", "" )

If ivs_DataBase = "" Then
	ivs_DataBase	= ProfileString( lvs_Ini, "DataBase", "DataBase", "" )
	lvs_DataSource	= ProfileString( lvs_Ini, "DataBase", "DataSource", "" )
End If

If IsValid(gvo_Aplicacao) Then
	lvs_HostName   = gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + "_" + gvo_Aplicacao.of_UserId()
Else
	lvs_HostName   = ProfileString( lvs_Ini, "DataBase", "HostName", "" )
End If

Return This.of_Connect( lvs_DataSource, lvs_HostName )
end function

public function integer of_commit ();If gvo_Aplicacao.of_Get_Alerta_Commit_Producao( ) Then 
	gvo_Aplicacao.of_Set_Alerta_Commit_Producao( (MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Voc$$HEX1$$ea00$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ comitando uma transa$$HEX2$$e700e300$$ENDHEX$$o em ambiente de produ$$HEX2$$e700e300$$ENDHEX$$o.~r~nDeseja prosseguir?',Exclamation!,YesNo!,2)=2) )
	If gvo_Aplicacao.of_Get_Alerta_Commit_Producao( ) Then 
		RollBack Using This;
		Return This.SqlCode
	End If
End If

Commit Using This;

If This.SqlCode = -1 Then
	If Exibe_Notificacao Then This.of_MsgdbError()
End If

Return This.SqlCode
end function

public function integer of_rollback ();RollBack Using This;

If This.SqlCode = -1 Then
	If Exibe_Notificacao Then This.of_MsgdbError()
End If

Return This.SqlCode
end function

public subroutine of_logdberror (integer pi_arquivo, string ps_parametro);String lvs_Mensagem

If Not IsValid(ivo_dbError) Then ivo_dbError = Create dc_uo_dbError
This.ivo_dbError.of_Set_Erro_Saida_Padrao( This.of_Get_Erro_Saida_Padrao( ) )

If This.SqlCode = -1 Then
	lvs_Mensagem = "C$$HEX1$$f300$$ENDHEX$$digo:  " + String(This.SqldbCode) + "~r" + &
						"Descri$$HEX2$$e700e300$$ENDHEX$$o:" + This.SqlErrText
Else
	lvs_Mensagem = ""					
End If
					
ivo_dbError.ivl_SqldbCode	= This.SqldbCode
ivo_dbError.ivs_SqlErrText	= This.SqlErrText
ivo_dbError.ivs_DataBase	= This.ivs_DataBase
ivo_dbError.ivs_Mensagem	= lvs_Mensagem
ivo_dbError.ivs_Parametro	= ps_Parametro

ivo_dbError.of_Log_Erro(pi_Arquivo)

// Trata se ocorreu algum problema durante a transa$$HEX2$$e700e300$$ENDHEX$$o(-85) e 
// perdeu a conex$$HEX1$$e300$$ENDHEX$$o(-308)
If This.SqldbCode = -85 or This.SqldbCode = -308 Then
	Halt Close
End If
end subroutine

public subroutine of_msgdberror (long pl_sqldbcode, string ps_sqlerrtext, string ps_parametro);String lvs_Mensagem

If Not IsValid(ivo_dbError) Then ivo_dbError = Create dc_uo_dbError
This.ivo_dbError.of_Set_Erro_Saida_Padrao( This.of_Get_Erro_Saida_Padrao( ) )

If Trim(ps_Parametro) <> "" Then
	lvs_Mensagem = "Ocorreu um erro de base de dados.~r~n~r~n~r~n" + &
						"Par$$HEX1$$e200$$ENDHEX$$metro: " + ps_Parametro + "~r~n~r~n" + &
						"C$$HEX1$$f300$$ENDHEX$$digo:  " + String(This.ii_LastErrorCode) + "~r~n~r~n" + &
						"Descri$$HEX2$$e700e300$$ENDHEX$$o:~r~n" + This.is_LastErrorText
Else
	lvs_Mensagem = "Ocorreu um erro de base de dados.~r~n~r~n~r~n" + &
						"C$$HEX1$$f300$$ENDHEX$$digo:  " + String(This.ii_LastErrorCode) + "~r~n~r~n" + &
						"Descri$$HEX2$$e700e300$$ENDHEX$$o:~r~n" + This.is_LastErrorText
End If

If Not IsNull(pl_SqldbCode) Then
	ivo_dbError.ivl_SqldbCode = pl_SqldbCode
Else
	ivo_dbError.ivl_SqldbCode = This.SqldbCode		
End If

If Not IsNull(ps_SqlErrText) Then
	ivo_dbError.ivs_SqlErrText = ps_SqlErrText
Else
	//lvo_dbError.ivs_SqlErrText = This.SqlErrText
	ivo_dbError.ivs_SqlErrText = This.is_LastErrorText
End If

ivo_dbError.ivs_DataBase  = This.ivs_DataBase
ivo_dbError.ivs_Mensagem  = lvs_Mensagem
ivo_dbError.ivs_Parametro = ps_Parametro

ivo_dbError.of_Trata_Erro()
end subroutine

public function string of_dbms_name ();String ls_Dbms

ls_Dbms = Upper( This.SqlReturnData )

If PosA( ls_Dbms, 'POSTGRESQL' ) > 0 Then
	Return 'POSTGRESQL'
End If

If ls_Dbms = 'ADAPTIVE SERVER ANYWHERE' Then
	Return 'ANYWHERE'
End If

Return ''
end function

public subroutine of_pg_elimina_conexoes_inativas ();/* Fun$$HEX2$$e700e300$$ENDHEX$$o para eliminar as conex$$HEX1$$f500$$ENDHEX$$es ap$$HEX1$$f300$$ENDHEX$$s 90 minutos de inatividade
 * Autor: Fernando Lu$$HEX1$$ed00$$ENDHEX$$s Cambiaghi
 * Data 17/03/2015
 * Alterado em 21/08/2015 por Fernando Lu$$HEX1$$ed00$$ENDHEX$$s Cambiaghi
 * 		- N$$HEX1$$e300$$ENDHEX$$o elimina mais as conex$$HEX1$$f500$$ENDHEX$$es dos sistemas ConsultaPre$$HEX1$$e700$$ENDHEX$$o, Caixa e NFe,
 		pois estes sistemas n$$HEX1$$e300$$ENDHEX$$o deixam transa$$HEX2$$e700e300$$ENDHEX$$o aberta quando n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o em uso.
		- Somente o sistema TL ir$$HEX1$$e100$$ENDHEX$$ eliminar as conex$$HEX1$$f500$$ENDHEX$$es
 */


/* Conforme combinado em reuni$$HEX1$$e300$$ENDHEX$$o dia 08/02/2016, as conex$$HEX1$$f500$$ENDHEX$$es n$$HEX1$$e300$$ENDHEX$$o devem mais ser desconectadas do banco */
Return
/***********/

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> 'TL' Then
	Return
End If

Boolean  lb_Kill

If This.of_dbms_name( ) = 'POSTGRESQL' Then	
	SELECT pg_terminate_backend(pid)
		 INTO :lb_Kill
	  FROM pg_stat_activity
	WHERE datname like 'bd%'
		AND application_name NOT LIKE 'CP%'
		AND application_name NOT LIKE 'CL%'
		AND application_name NOT LIKE 'NF%'
		AND pid <> pg_backend_pid()
		AND ( state = 'idle' or state = 'idle in transaction' )
		AND dbo.diffdate( 'minute', state_change, current_timestamp ) > 90
	 USING This;
End If
end subroutine

public subroutine of_set_application_name (string ps_name);String ls_SetConfig

If This.of_IsConnected() Then
	If This.of_Dbms_Name() = 'POSTGRESQL' Then
		Select set_app_name(:ps_name)
		Into :ls_SetConfig
		From parametro
		Where id_parametro = '1'
		Using This;
		
		If This.SqlCode = -1 Then
			This.of_MsgDbError( )
		End If
	End If
End If
end subroutine

public subroutine of_end_transaction ();Choose Case This.of_DBMS_Name( )
	Case 'POSTGRESQL'
		Execute Immediate "end transaction;"
		Using This;
		
	Case 'ANYWHERE'
		This.of_RollBack( )
		
	Case Else
		//
End Choose
	
end subroutine

public function boolean of_connect (string ps_datasource, string ps_hostname, boolean pb_mensagem);Try
	uo_conexao_bd lo_Conexao // classe_conexao.pbd
	lo_Conexao = Create uo_conexao_bd
	
	Return lo_Conexao.of_Connect( ps_datasource, ps_hostname, pb_mensagem, This )
	
Catch( runtimeerror ru )
	MessageBox( "Runtimeerror", ru.getMessage( ) + '~rdc_uo_transacao.of_connect(string,string,boolean)' )
Finally
	Destroy lo_Conexao
End Try
end function

public function string of_get_erro_saida_padrao ();Return This.ivs_Erro_Saida_Padrao
end function

public subroutine of_set_erro_saida_padrao (string ps_valor);ps_Valor = Upper( ps_Valor )

Choose Case ps_Valor
	Case 'MESSAGEBOX'
		// OK
		
	Case 'LOG'
		// OK
		
	Case Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sa$$HEX1$$ed00$$ENDHEX$$da de erro '" + ps_Valor + "' n$$HEX1$$e300$$ENDHEX$$o previsto em dc_uo_dberror.of_set_erro_saida_padrao( string )", StopSign! )
		ps_Valor = 'MESSAGEBOX'
		
End Choose

This.ivs_Erro_Saida_Padrao = ps_Valor
end subroutine

public function decimal of_get_sybase_pc_log_in_use ();Decimal ldc_Pc_Usado

SELECT  COALESCE( 100 * (1 - 1.0 * lct_admin('logsegment_freepages',d.dbid) / sum(case when u.segmap in (4, 7) then u.size end)), 0 ) as pc_log_used
INTO :ldc_Pc_Usado
FROM master..sysdatabases d, master..sysusages u
WHERE u.dbid = d.dbid  and d.status != 256
    AND db_name(d.dbid) = :this.database
GROUP BY d.dbid
USING SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		This.of_RollBack( )
		This.of_msgDbError( )
End Choose

Return Round( ldc_Pc_Usado, 2 )
end function

on dc_uo_transacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_transacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;ii_LastErrorCode	= Code // Argumento
is_LastErrorText	= SqlErrorText
end event

