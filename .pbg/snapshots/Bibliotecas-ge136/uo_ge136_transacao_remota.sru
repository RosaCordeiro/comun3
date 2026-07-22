HA$PBExportHeader$uo_ge136_transacao_remota.sru
$PBExportComments$Objeto de transa$$HEX2$$e700e300$$ENDHEX$$o para conex$$HEX1$$e300$$ENDHEX$$o com banco de dados remoto via ODBC
forward
global type uo_ge136_transacao_remota from dc_uo_transacao
end type
end forward

global type uo_ge136_transacao_remota from dc_uo_transacao
end type
global uo_ge136_transacao_remota uo_ge136_transacao_remota

type variables
dc_uo_Odbc ivo_Odbc // Dever ser criado e destru$$HEX1$$ed00$$ENDHEX$$do em cada fun$$HEX2$$e700e300$$ENDHEX$$o que for utilizado

// Se n$$HEX1$$e300$$ENDHEX$$o puder apresentar mensagem de erro na of_Test_Connect(), mudar para False fora da classe
Boolean 	ivb_Mostra_Msg_Erro = True 
String 	ivs_Msg_Erro
end variables

forward prototypes
public subroutine of_set_username (string ps_username)
public function string of_get_username ()
public function string of_get_datasource ()
public function boolean of_valida_dados_conexao ()
public function boolean of_test_connect (ref string ps_erro)
public function boolean of_test_connect ()
public subroutine of_set_datasource (string ps_sgdb, string ps_datasource)
public function boolean of_connect (string ps_datasource, string ps_hostname)
public function boolean of_localiza_parametro_odbc (long pl_filial, ref string ps_mensagem)
public function string of_localiza_datasource_filial (long pl_filial)
public function boolean of_cria_odbc_mysql ()
public function boolean of_deleta_odbc (string ps_datasourcename)
public function boolean of_cria_odbc_filial (long pl_filial)
end prototypes

public subroutine of_set_username (string ps_username);This.ivs_Usuario = ps_Username
end subroutine

public function string of_get_username ();Return This.ivs_Usuario
end function

public function string of_get_datasource ();Return This.ivs_DataSource
end function

public function boolean of_valida_dados_conexao ();String ls_Usuario
String ls_Senha

If Trim( This.ivs_DataBase ) = "" Or IsNull( This.ivs_DataBase ) Then	Return False

Return True
end function

public function boolean of_test_connect (ref string ps_erro);Boolean lb_Retorno = True

String ls_Local_Erro = "~r~ruo_ge136_transacao_remota.of_test_connect( ref string )"

Try
	If Not This.of_Valida_Dados_Conexao( ) Then
		ps_Erro = "Os dados de conex$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foram definidos." + ls_Local_Erro
		Return False
	End If
	
	SetNull( ps_Erro )
	
	ivo_ODBC = Create dc_uo_odbc
	
	lb_Retorno = ivo_ODBC.of_Connect( This.of_Get_DataSource( ), 'teste_conexao', 'teste_conexao' )
	If Not lb_Retorno and (Upper(ivs_DataSource) = 'SERVICEDESK') then
		lb_Retorno = ivo_ODBC.of_Connect( This.of_Get_DataSource( ), 'usr-syb', 'PiVkzNQxyxg35iHD' )
	End If
	
	If Not lb_Retorno Then
		ps_Erro = "Erro no teste de conex$$HEX1$$e300$$ENDHEX$$o com o DataSource " + This.of_Get_DataSource( ) + ls_Local_Erro
		Return False
	End If
	
Catch( Exception ex )
	ps_Erro = ex.GetMessage( ) + ls_Local_Erro
	Return False
	
Finally
	Destroy ivo_ODBC
	
End Try
end function

public function boolean of_test_connect ();Boolean lb_Retorno

lb_Retorno = This.of_Test_Connect( ref ivs_Msg_Erro )

If Not lb_Retorno And ivb_Mostra_Msg_Erro Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_Msg_Erro )
End If

Return lb_Retorno
end function

public subroutine of_set_datasource (string ps_sgdb, string ps_datasource);/* Argumentos
	- ps_SGDB: Nome do SGDB [ POSTGRESQL | ANYWHERE | MYSQL | FIREBIRD | ... ]
	- ps_DataSourceName: Nome da fonte de dados
*/

This.ivs_DataBase		= ps_SGDB
This.ivs_DataSource	= ps_DataSource
end subroutine

public function boolean of_connect (string ps_datasource, string ps_hostname);Boolean lb_Retorno

If Not This.of_Test_Connect( ) Then Return False

If IsNull( ps_DataSource ) Or ps_DataSource = "" Then
	ps_DataSource = This.of_Get_DataSource( )
End If

lb_Retorno = SUPER::of_Connect( ps_DataSource, ps_HostName )

This.of_End_Transaction( )

Return lb_Retorno
end function

public function boolean of_localiza_parametro_odbc (long pl_filial, ref string ps_mensagem);Try
	ivo_ODBC = Create dc_uo_odbc
	Return ivo_ODBC.of_Localiza_Parametro_Odbc( pl_Filial, Ref ps_Mensagem )
	
Finally
	Destroy ivo_ODBC
	
End Try
end function

public function string of_localiza_datasource_filial (long pl_filial);Try
	ivo_ODBC = Create dc_uo_odbc
	Return ivo_ODBC.of_Localiza( pl_Filial )
	
Finally
	Destroy ivo_ODBC
	
End Try
end function

public function boolean of_cria_odbc_mysql ();Try
	ivo_ODBC = Create dc_uo_odbc
	Return ivo_ODBC.of_Grava_Regedit_ODBC_Mysql( )
	
Finally
	Destroy ivo_ODBC
	
End Try
end function

public function boolean of_deleta_odbc (string ps_datasourcename);Try
	ivo_ODBC = Create dc_uo_odbc
	Return ivo_ODBC.of_Deleta_Regedit_ODBC( ps_DataSourceName )
	
Finally
	Destroy ivo_ODBC
	
End Try
end function

public function boolean of_cria_odbc_filial (long pl_filial);Boolean lvb_Sucesso = False

Try
	ivo_ODBC = Create dc_uo_odbc	
	If ivo_Odbc.of_Localiza_Parametro_Odbc( pl_Filial ) Then
		If ivo_Odbc.of_Grava_Regedit_Odbc( pl_Filial ) Then
			lvb_Sucesso = True
		End If
	End If
	
	Return lvb_Sucesso
	
Finally
	Destroy ivo_ODBC
End Try
end function

on uo_ge136_transacao_remota.create
call super::create
end on

on uo_ge136_transacao_remota.destroy
call super::destroy
end on

event destructor;call super::destructor;If This.of_IsConnected( ) Then This.of_DisConnect( )
end event

