HA$PBExportHeader$uo_conexao_bd.sru
forward
global type uo_conexao_bd from nonvisualobject
end type
end forward

global type uo_conexao_bd from nonvisualobject
end type
global uo_conexao_bd uo_conexao_bd

type variables
String ivs_database
String ivs_senha	= ""

Boolean StandAlone			= False		
Boolean Exibe_Notificacao	= True
Boolean Banco_Producao		= True
end variables

forward prototypes
public function boolean of_connect (string ps_datasource, string ps_hostname, boolean pb_mensagem, dc_uo_transacao ptr_tran)
end prototypes

public function boolean of_connect (string ps_datasource, string ps_hostname, boolean pb_mensagem, dc_uo_transacao ptr_tran);String ls_SetConfig
String ls_Alter
String ls_Aux
String ls_Schema
String ls_DBMS_Driver

ptr_Tran.StandAlone		= False
ptr_Tran.Banco_Producao	= True
ls_DBMS_Driver				= ptr_Tran.Of_Get_DBMS_Driver()

Choose Case Upper(ptr_Tran.ivs_DataBase)
	Case "SYBASE"
		ptr_Tran.DBMS			= IIF(ls_DBMS_Driver<>"",ls_DBMS_Driver, "SYC Sybase System 10/11")
		ptr_Tran.Database		= ps_DataSource
		ptr_Tran.AutoCommit	= False
		ptr_Tran.dbParm		= "CharSet='roman8', DateTimeAllowed='Yes', Release='11', Host='" + ps_HostName + &
		                   "', AppName='" + ps_HostName + "', CommitOnDisconnect='No'"		
		
		If Upper(ps_DataSource) = "CENTRAL_DES" Then
			ptr_Tran.Banco_Producao = False
			gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
			ptr_Tran.ServerName = "SybaseCentral"			
			ptr_Tran.LogId      = "Desenvolvimento"
			ptr_Tran.LogPass    = "desenv"
		ElseIf Upper(ps_DataSource) = "CENTRAL" Then
			ptr_Tran.ServerName = "SybaseCentral"			
			ptr_Tran.LogId      = "sistemas"
			ptr_Tran.LogPass    = "PrdSyb2023K@a"
		ElseIf Upper(ps_DataSource) = "HISTORICO_2024" Then
			ptr_Tran.ServerName = "SybaseCentral"			
			ptr_Tran.LogId      = "sistemas"
			ptr_Tran.LogPass    = "PrdSyb2023K@a"
		ElseIf Upper(ps_DataSource) = "XML" Then
			ptr_Tran.Banco_Producao = False
			gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
			ptr_Tran.ServerName = "SybaseCentral"			
			ptr_Tran.LogId      = "sistemas"
			ptr_Tran.LogPass    = "PrdSyb2023K"
		ElseIf Upper(ps_DataSource) = "HOMOLOGA" Then
			ptr_Tran.Banco_Producao = False
			gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
			ptr_Tran.ServerName = "SybaseHomologa"			
			ptr_Tran.LogId      = "sistemas"
			ptr_Tran.LogPass    = "HmgSyb2023K@a"
		ElseIf Upper(ps_DataSource) = "CENTRAL_QA" Then
			ptr_Tran.Banco_Producao = False
			gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
			ptr_Tran.ServerName = "SybaseHomologa"			
			ptr_Tran.LogId      = "sistemas"
			ptr_Tran.LogPass    = "HmgSyb2023K@a"
		ElseIf Upper(ps_DataSource) = "HOMOLOGA_NOVO" Then
			ptr_Tran.Banco_Producao = False
			ptr_Tran.Database = 'homologa'
			gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
			ptr_Tran.ServerName = "SybaseCentral_Novo"			
			ptr_Tran.LogId      = "sistemas"
			ptr_Tran.LogPass    = "HmgSyb2023K@a"
		ElseIf Upper(ps_DataSource) = "HOMOLOGA_16K" Then
			ptr_Tran.Banco_Producao = False
			ptr_Tran.Database = 'central'
			gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
			ptr_Tran.ServerName = "Homologa_16K"			
			ptr_Tran.LogId      = "sistemas"
			ptr_Tran.LogPass    = "PrdSyb2023K@a"
		End If
		
	Case "POSTGRESQL_JAVA"	
		//ptr_tran.ivs_Usuario	= "DEV-DBA"
		//This.ivs_Senha			= "f4xlPH66=Ket"		
		//ptr_tran.ivs_Usuario	= "central"
		//This.ivs_Senha			= "SaDBAdmin$0638"
		ptr_tran.ivs_Usuario	= "transf"
		This.ivs_Senha			= "tR4n$f@6790"
					
		ptr_Tran.DBMS       = "ODBC"
		ptr_Tran.AutoCommit = False
		ptr_Tran.dbParm     = "ConnectString='UID=" + ptr_tran.ivs_Usuario + ";PWD=" + This.ivs_Senha + ";DSN=" + ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + &
		                   "CommitOnDisconnect='No'"
		ptr_Tran.DataBase   = ps_DataSource
		
	Case "ANYWHERE", "POSTGRESQL"
		ptr_tran.ivs_Usuario	= "sistemas"
		This.ivs_Senha			= "xedxgeRJb2XMs59rXeP9N2bJnMf3"
		//This.ivs_Usuario = "dbo"
		//This.ivs_Senha = "teste"
			
		ptr_Tran.DBMS       = "ODBC"
		ptr_Tran.AutoCommit = False
		ptr_Tran.dbParm     = "ConnectString='UID=" + ptr_tran.ivs_Usuario + ";PWD=" + This.ivs_Senha + ";DSN=" + ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + &
		                   "CommitOnDisconnect='No'"
		ptr_Tran.DataBase   = ps_DataSource
		
	Case "MYSQL"
		If Upper(ps_DataSource) = "SERVICEDESK" Or Upper(ps_DataSource) = "SERVICEDESK_PRODUCAO" Then
			ptr_tran.ivs_Usuario = "usr-syb"
			This.ivs_Senha = "PiVkzNQxyxg35iHD"
		Else
			If ptr_tran.ivs_Usuario = "" Then ptr_tran.ivs_Usuario = "gambiarra"
			If This.ivs_Senha   = "" Then ivs_Senha = "admin"
		End If
		
		ptr_Tran.DBMS       = "ODBC"
		ptr_Tran.AutoCommit = False
		ptr_Tran.dbParm     = "ConnectString='UID=" + ptr_tran.ivs_Usuario + ";PWD=" + This.ivs_Senha + ";DSN=" + &
		                  ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + "CommitOnDisconnect='No'"		
		ptr_Tran.DataBase   = ps_DataSource
		
	Case "MYSQL_PP"
		If ptr_tran.ivs_Usuario = "" Then ptr_tran.ivs_Usuario = "precopop_site"
		If This.ivs_Senha   = "" Then ivs_Senha = "Ic@gA5r{b1nP"
		
		ptr_Tran.LogPass     	= ivs_Senha
		ptr_Tran.DBMS      	= "ODBC"
		ptr_Tran.AutoCommit = False
		ptr_Tran.dbParm     	= "ConnectString='UID=" + ptr_tran.ivs_Usuario + ";DSN=" + &
                 						ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + "CommitOnDisconnect='No'"		
//		ptr_Tran.dbParm     = "ConnectString='UID=" + ptr_tran.ivs_Usuario + ";PWD=" + This.ivs_Senha + ";DSN=" + &
//		                  ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + "CommitOnDisconnect='No'"		
		ptr_Tran.DataBase   = ps_DataSource		
		
	Case "MYSQL_RH"
		ls_Aux = 'DE_DB_SENHA_'+Upper(ps_DataSource)
		If IsNull(ivs_Senha) or Trim(ivs_Senha)='' Then
			Select vl_parametro
			InTo :ivs_Senha
			From parametro_geral
			Where cd_parametro = :ls_Aux
			Using SQLCa;
			
			If SQLCa.SQLCode<>0 Then
				If pb_mensagem and Exibe_Notificacao Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_Aux + "' n$$HEX1$$e300$$ENDHEX$$o encontrado na tabela parametro_geral. '" + ps_DataSource + "'", StopSign!)
				Return False
			End If
		End If
		
		ptr_Tran.DBMS       		= "ODBC"
		ptr_Tran.AutoCommit 	= False
		ptr_Tran.dbParm     		= "ConnectString='UID=" + ptr_tran.ivs_Usuario + ";PWD=" + This.ivs_Senha + ";DSN=" + &
		                  			  		ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + "CommitOnDisconnect='No'"		
		ptr_Tran.DataBase   		= ps_DataSource
		
	Case "MYSQL_CLAMED"
		
		If ptr_tran.ivs_Usuario = "" Then ptr_tran.ivs_Usuario = "clamed"
		If This.ivs_Senha   = "" Then ivs_Senha = "N!c9At}KSPU("
		
		ptr_Tran.LogPass     	= ivs_Senha
		ptr_Tran.DBMS      	= "ODBC"
		ptr_Tran.AutoCommit = False
		ptr_Tran.dbParm     	= "ConnectString='UID=" + ptr_tran.ivs_Usuario + ";DSN=" + &
                 						ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + "CommitOnDisconnect='No'"		
		ptr_Tran.DataBase   = ps_DataSource		
		
	Case "FIREBIRD"
		If ptr_tran.ivs_Usuario = "" Then ptr_tran.ivs_Usuario = "SYSDBA"
		If This.ivs_Senha   = "" Then ivs_Senha   = "masterkey"
		
		ptr_Tran.DBMS       = "ODBC"
		ptr_Tran.AutoCommit = False
		ptr_Tran.dbParm     = "ConnectString='UID=" + ptr_tran.ivs_Usuario + ";PWD=" + This.ivs_Senha + ";DSN=" + &
		                  ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + "CommitOnDisconnect='Yes'"
		ptr_Tran.DataBase   = ps_DataSource
		
	Case "ORACLE_RH"		
		ls_Aux = 'DE_DB_SENHA_'+Upper(ps_DataSource)
		If IsNull(ivs_Senha) or Trim(ivs_Senha)='' Then
			Select vl_parametro
			InTo :ivs_Senha
			From parametro_geral
			Where cd_parametro = :ls_Aux
			Using SQLCa;
			
			If SQLCa.SQLCode<>0 Then
				If pb_mensagem and Exibe_Notificacao Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_Aux + "' n$$HEX1$$e300$$ENDHEX$$o encontrado na tabela parametro_geral. '" + ps_DataSource + "'", StopSign!)
				Return False
			End If
		End If
		
		ptr_tran.ivs_Usuario		= Lower(ps_DataSource)
		ptr_Tran.ServerName 	= "10.0.3.2:1521/vetorh"
		ptr_Tran.DBMS 			= "O10 Oracle10g (10.1.0)"		
		ptr_Tran.LogId				= ptr_tran.ivs_Usuario
		ptr_Tran.LogPass    		= ivs_Senha		
		ptr_Tran.autocommit 		= False

	Case "ORACLE_DM"
		Choose Case Upper(ps_DataSource)
			Case "CL_DADMOVGATI"
				ptr_tran.ivs_Usuario	= "CL_DADMOVGATI"
				ivs_Senha				= "CL_DADMOVGATI"
		
			Case "CL_DADMOVGATI_HOMOLOG"
				ptr_tran.ivs_Usuario	= "CL_DADMOVGATI_HOMOLOG"
				ivs_Senha   				= "homolog"
				ptr_Tran.Banco_Producao = False
				gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
		End Choose
		
		ptr_Tran.ServerName 	= "10.0.3.2:1521/orcl"
		ptr_Tran.DBMS 			= "O10 Oracle10g (10.1.0)"		
		ptr_Tran.LogId			= ptr_tran.ivs_Usuario
		ptr_Tran.LogPass    	= ivs_Senha		
		ptr_Tran.autocommit 	= False				
	
	Case "MULT" //Conex$$HEX1$$e300$$ENDHEX$$o Mult			
		ls_Aux = 'DE_DB_SENHA_'+Upper(ps_DataSource)
		If IsNull(ivs_Senha) or Trim(ivs_Senha)='' Then
			Select vl_parametro
			InTo :ivs_Senha
			From parametro_geral
			Where cd_parametro = :ls_Aux
			Using SQLCa;
			
			If SQLCa.SQLCode<>0 Then
				If pb_mensagem and Exibe_Notificacao Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_Aux + "' n$$HEX1$$e300$$ENDHEX$$o encontrado na tabela parametro_geral. '" + ps_DataSource + "'", StopSign!)
				Return False
			End If
		End If
		
		Choose Case Upper(ps_DataSource)
			Case "CLAMPROD", "QUIMIDROL"
				ptr_Tran.ServerName 	= "dbprod"			
				ptr_Tran.ServerName 	= "10.0.0.30:1521/"+ptr_Tran.ServerName
			Case "CLAMTESTE", "QUIMIDROLTESTE"
				gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
				ptr_Tran.Banco_Producao = False
				ptr_Tran.ServerName 		= "dbteste"		
				ptr_Tran.ServerName 		= "SRV-ORA01:1522/"+ptr_Tran.ServerName
				//ptr_Tran.ServerName 		= "MX-ORA01:1522/"+ptr_Tran.ServerName
		End Choose
		
		ptr_tran.ivs_Usuario 	= Lower(ps_DataSource)		
		ptr_Tran.DBMS 			= "O10 Oracle10g (10.1.0)"		
		ptr_Tran.LogId			= ptr_tran.ivs_Usuario
		ptr_Tran.LogPass    	= ivs_Senha		
		ptr_Tran.autocommit 	= False		
		
	Case "MULT_LIMPA" //Conex$$HEX1$$e300$$ENDHEX$$o Mult base limpa despois de algum expurgo de dados.
		ls_Aux = 'DE_DB_SENHA_'+Upper(ps_DataSource)
		If IsNull(ivs_Senha) or Trim(ivs_Senha)='' Then
			Select vl_parametro
			InTo :ivs_Senha
			From parametro_geral
			Where cd_parametro = :ls_Aux
			Using SQLCa;
			
			If SQLCa.SQLCode<>0 Then
				If pb_mensagem and Exibe_Notificacao Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_Aux + "' n$$HEX1$$e300$$ENDHEX$$o encontrado na tabela parametro_geral. '" + ps_DataSource + "'", StopSign!)
				Return False
			End If
		End If
		
		Choose Case Upper(ps_DataSource)
			Case "CLAMPROD", "QUIMIDROL"
				ptr_Tran.ServerName 	= "dbproj_mult_m3"			
				ptr_Tran.ServerName 	= "SRV-ORA01:1522/"+ptr_Tran.ServerName
			/*Case "CLAMTESTE", "QUIMIDROLTESTE"
				gvo_Aplicacao.of_Set_Alerta_Commit_Producao( False )
				ptr_Tran.Banco_Producao = False
				ptr_Tran.ServerName 		= "dbteste"		
				ptr_Tran.ServerName 		= "SRV-ORA01:1522/"+ptr_Tran.ServerName
				//ptr_Tran.ServerName 		= "MX-ORA01:1522/"+ptr_Tran.ServerName
			*/
		End Choose
		
		ptr_tran.ivs_Usuario 	= Lower(ps_DataSource)		
		ptr_Tran.DBMS 			= "O10 Oracle10g (10.1.0)"		
		ptr_Tran.LogId			= ptr_tran.ivs_Usuario
		ptr_Tran.LogPass    	= "M3_proj_clamprod"
		ptr_Tran.autocommit 	= False						
		
	Case "SPACEMAN" 
		if ptr_tran.ivs_Usuario  = "" Then ptr_tran.ivs_Usuario = 'spaceman_user'
		If This.ivs_Senha    = "" Then ivs_Senha   = 'SPACEMAN'		
		ptr_Tran.DBMS = 'ODBC'
		ptr_Tran.autocommit = False
		ptr_Tran.dbparm ="ConnectString='UID=" + ptr_tran.ivs_Usuario + ";PWD=" + This.ivs_Senha + ";DSN=" + &
								ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + "CommitOnDisconnect='No'"
		ptr_Tran.DataBase   = ps_DataSource
		
	Case "ACCESS"	
		
		// Profile 0000_loja_access
		ptr_Tran.DBMS = "ODBC"
		ptr_Tran.AutoCommit = False
		ptr_Tran.DBParm = "ConnectString='DSN=" + ps_DataSource + "'"
		ptr_Tran.DataBase   = ps_DataSource
		
		ptr_Tran.StandAlone = True
	
	Case 'DADOSINTEGRA'
		
		ptr_tran.ivs_Usuario	= "usr-dadosintegra"
		This.ivs_Senha			= "V8mideQU!res"
					
		ptr_Tran.DBMS       = "ODBC"
		ptr_Tran.AutoCommit = False
		ptr_Tran.dbParm     = "ConnectString='UID=" + ptr_tran.ivs_Usuario + ";PWD=" + This.ivs_Senha + ";DSN=" + ps_DataSource + "', SqlCache=0, DisableBind=1" + "', " + &
		                   "CommitOnDisconnect='No'"
		ptr_Tran.DataBase   = ps_DataSource
	
	Case Else
		If pb_mensagem and Exibe_Notificacao Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Banco de dados '" + ptr_Tran.ivs_DataBase + "' n$$HEX1$$e300$$ENDHEX$$o especificado. '" + ps_DataSource + "'", StopSign!)
		Return False
End Choose

Try
	Connect Using ptr_Tran;
CATCH (RunTimeError lve_Erro)
Finally
//	This.ivs_Usuario = ""
//	This.ivs_Senha = ""
	ptr_Tran.dbParm = ""

	//Return False
END TRY

If ptr_Tran.SqlCode = -1 Then
	If pb_mensagem and Exibe_Notificacao Then ptr_Tran.of_MsgdbError("Conex$$HEX1$$e300$$ENDHEX$$o com o Banco de Dados")
	
	Return False
Else
	
	If ptr_Tran.of_Dbms_Name() = 'POSTGRESQL' Then
		If Upper(ptr_Tran.ivs_DataBase) <> 'POSTGRESQL_JAVA' and Upper(ptr_Tran.ivs_DataBase) <> 'DADOSINTEGRA' Then
			select coalesce(vl_parametro,'S')
			Into :ls_Aux
			from parametro_loja
			where cd_parametro = 'ID_BASE_PRODUCAO'
			Using ptr_Tran;
			
			If ptr_Tran.SQLCode = 0 Then
				ptr_Tran.Banco_Producao = Not(ls_Aux = "N")
			End If
	
			If gvo_Aplicacao.of_Get_Alerta_Commit_Producao( ) Then
				gvo_Aplicacao.of_Set_Alerta_Commit_Producao( ptr_Tran.Banco_Producao )
			End If		
		End If
		
		//Schama padrao do postgres + PB12 
		ls_Schema = 'dbo'
		
		If Upper(ptr_Tran.ivs_DataBase) = 'POSTGRESQL_JAVA' Then
			ls_Schema = 'legado'
		Elseif Upper(ptr_Tran.ivs_DataBase) = 'DADOSINTEGRA' Then
			ls_Schema = 'public'
		End If
		
		/* Configura o Schema da conex$$HEX1$$e300$$ENDHEX$$o atual */
		ls_Alter = "SET search_path TO " + ls_Schema + ";"
		Execute Immediate :ls_Alter Using ptr_Tran;
		/**********/

		/* Atribui o nome da aplica$$HEX2$$e700e300$$ENDHEX$$o no banco de dados da conex$$HEX1$$e300$$ENDHEX$$o atual */
		ls_Alter = "SELECT * FROM  set_app_name( '"  + ps_HostName + "' );"
		Execute Immediate :ls_Alter Using ptr_Tran;
		
		ptr_Tran.of_Pg_Elimina_Conexoes_Inativas( )
		
		If Upper(ptr_Tran.ivs_DataBase) <> 'POSTGRESQL_JAVA' and Upper(ptr_Tran.ivs_DataBase) <> 'DADOSINTEGRA' Then
			ptr_Tran.ivs_Database				= 'POSTGRESQL'
		End If
		
		gvo_Aplicacao.ivs_Database			= 'POSTGRESQL'
		
		/* Captura o nome do banco de dados da conex$$HEX1$$e300$$ENDHEX$$o atual e atribui para gvo_Aplicacao.ivs_Datasource */
		DECLARE nm_database PROCEDURE FOR current_database ()
		Using ptr_Tran;
		Execute nm_database;		
		Fetch nm_database Into :gvo_Aplicacao.ivs_Datasource;		
		Close nm_database;
		/*************/

	End If
	
 	If (ptr_Tran.DBMS = "O10 Oracle10g (10.1.0)") Then		
		ls_Alter = "Alter Session Set nls_language='BRAZILIAN PORTUGUESE'"
		Execute Immediate :ls_Alter Using ptr_Tran;		
		ls_Alter = "Alter Session Set NLS_TERRITORY = 'BRAZIL'"
		Execute Immediate :ls_Alter Using ptr_Tran;		
		ls_Alter = "Alter Session Set NLS_NUMERIC_CHARACTERS='.,'"
		Execute Immediate :ls_Alter Using ptr_Tran;		
	End If
	
	Return True
End If
end function

on uo_conexao_bd.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_conexao_bd.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

