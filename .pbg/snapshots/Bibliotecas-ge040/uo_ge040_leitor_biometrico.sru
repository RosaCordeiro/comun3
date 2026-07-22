HA$PBExportHeader$uo_ge040_leitor_biometrico.sru
forward
global type uo_ge040_leitor_biometrico from nonvisualobject
end type
end forward

global type uo_ge040_leitor_biometrico from nonvisualobject
end type
global uo_ge040_leitor_biometrico uo_ge040_leitor_biometrico

type prototypes

end prototypes

type variables
CONSTANT Int	SECURELEVEL = 5 // Indica o n$$HEX1$$ed00$$ENDHEX$$vel de seguran$$HEX1$$e700$$ENDHEX$$a definido para o reconhecimento de impress$$HEX1$$f500$$ENDHEX$$es digitais. Os valores variam de 1 (menor) a 9 (maior). O padr$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ 5 (normal).

CONSTANT Long	DefaultTimeOut										= 10000 // Dez Segundos
CONSTANT Long	NBioAPIERROR_NONE								= 0
CONSTANT Long	NBioAPIERROR_USER_CANCEL					= 513
CONSTANT Long	NBioAPIERROR_CAPTURE_TIMEOUT			= 515
CONSTANT Long	NBioAPIERROR_DEVICE_LOST_DEVICE		= 267
CONSTANT Long	NBioAPIERROR_DEVICE_OPEN_FAIL			= 257
CONSTANT Long	NBIOAPIERROR_DEVICE_ALREADY_OPENED	= 4
CONSTANT Long	NBioAPIERROR_INVALID_DEVICE_ID			= 258

CONSTANT Long	NBioAPI_FIR_PURPOSE_VERIFY							= 1
CONSTANT Long	NBioAPI_DEVICE_ID_NONE								= 0
CONSTANT Long	NBioAPI_DEVICE_ID_FDP02_0							= 1
CONSTANT Long	NBioAPI_DEVICE_ID_FDU01_0							= 2
CONSTANT Long	NBioAPI_DEVICE_ID_AUTO_DETECT   				= 255
CONSTANT Long	NBioAPIERROR_INDEXSEARCH_DUPLICATED_ID	= 1287
CONSTANT Long	NBioAPI_WINDOW_STYLE_INVISIBLE					=	1
CONSTANT Long	NBioAPI_WINDOW_STYLE_NO_WELCOME 			= 262144

dc_uo_ds_base ivds_Digital

OleObject	ivo_Leitor
OleObject	ivo_Device
OleObject	ivo_Extraction
OleObject	ivo_IndexSearch
OleObject	ivo_Result

Boolean ib_Permite_Senha_Digitada = True

Long ivl_Tamanho_Instalador = 6344892

Long ivl_Retorno_Identificacao = 0

String ivs_Instalador = 'biometria.zip'
String ivs_Skin = 'NBSP2ptbr.dll'

Long il_Filial_Parametro
Long il_Filial_Matriz
end variables

forward prototypes
public function boolean of_inicializa ()
public function boolean of_permite_cadastro (string ps_identificado)
public function boolean of_cadastra (string ps_identificado)
public function boolean of_existe_digital_cadastrada (string ps_identificado)
public function boolean of_dedos_cadastrados (string ps_identificado, ref string ps_mensagem)
public function integer of_identifica (string ps_identificado)
public function boolean of_verifica_drivers ()
public function boolean of_dedo_cadastro_existe (string ps_identificado, string ps_dedo)
public function integer of_digital_cadastro_existe (string ps_identificado, string ps_captura)
public function boolean of_usuario_isento_filial (string ps_matricula)
public function boolean of_usuario_isento (string ps_matricula)
public function boolean of_finaliza_ponto ()
public function boolean of_procura_digital ()
public function boolean of_permite_senha_digitada ()
end prototypes

public function boolean of_inicializa ();Boolean lb_Sucesso = False
Boolean lb_Regista_Parametro_PDV = False

String ls_Msg_Retorno

Integer li_Retorno

uo_parametro_pdv lo_Pdv

Try
	If Not This.of_Verifica_Drivers() Then Return False
	
	ivo_Leitor = Create OleObject
	
	li_Retorno = ivo_Leitor.ConnectToNewObject( 'NBioBSPCOM.NBioBSP' )
	
	If li_Retorno = 0 Then
		ivo_Device						= ivo_Leitor.Device
		ivo_Extraction					= ivo_Leitor.Extraction
		ivo_IndexSearch				= ivo_Leitor.IndexSearch
		ivo_Extraction.CancelMsg	= "Deseja realmente cancelar o processo de cadastro?"
		
		ivo_Leitor.SetSkinResource( ivs_Skin )
		
		ivo_Extraction.DefaultTimeOut		= DefaultTimeOut // Tempo de espera para a leitura da digital ser conclu$$HEX1$$ed00$$ENDHEX$$da
		ivo_Extraction.MaxFingerForEnroll	= 1
		ivo_Extraction.WindowOption[NBioAPI_WINDOW_STYLE_NO_WELCOME] = True
		
		ivo_Device.Open( NBioAPI_DEVICE_ID_AUTO_DETECT )	
		
		Choose Case ivo_Device.ErrorCode
			Case NBioAPIERROR_NONE
				lb_Regista_Parametro_PDV = True
				Return True
				
			Case NBioAPIERROR_DEVICE_OPEN_FAIL
				//MessageBox( 'Falha no aparelho biom$$HEX1$$e900$$ENDHEX$$trico!', 'Erro na abertura da conex$$HEX1$$e300$$ENDHEX$$o com o leitor.' )
				
			Case NBioAPIERROR_INVALID_DEVICE_ID
				// Erro que ocorre ao registrar a dll e n$$HEX1$$e300$$ENDHEX$$o houver leitor conectado
	
			Case Else
				ls_Msg_Retorno = String( ivo_Device.ErrorDescription ) + " (" + String( ivo_Device.ErrorCode ) + ") "
				MessageBox( 'Falha no aparelho biom$$HEX1$$e900$$ENDHEX$$trico!', ls_Msg_Retorno )
		End Choose
		
		If IsValid( ivo_Leitor ) Then
			ivo_Leitor.DisconnectObject()
			Destroy ivo_Leitor
		End If
		
		If IsValid( ivo_Device ) Then 			Destroy ivo_Device
		If IsValid( ivo_Extraction ) Then		Destroy ivo_Extraction
		If IsValid( ivo_IndexSearch ) Then		Destroy ivo_IndexSearch
		
	End If
	
	Return lb_Sucesso

Catch( RuntimeError ru1 )
	MessageBox( "RuntimeError", ru1.getMessage( ) + "~r~uo_ge040_leitor_biometrico.of_inicializa( )", StopSign! )
	
Finally
	Try
		lo_Pdv = Create uo_parametro_pdv
		
		If il_Filial_Parametro <> il_Filial_Matriz Then
			If lb_Regista_Parametro_PDV Then
				lo_Pdv.of_Grava_Usa_Leitor_Biometrico( 'S' )
			Else
				lo_Pdv.of_Grava_Usa_Leitor_Biometrico( 'N' )
			End If
		End If
		
	Catch( RuntimeError ru )
		MessageBox( "RuntimeError", ru.getMessage( ) + "~r~uo_ge040_leitor_biometrico.of_inicializa( )", StopSign! )
		Return False
		
	Finally
		If IsValid(lo_Pdv) Then Destroy lo_Pdv
	End Try

End Try
end function

public function boolean of_permite_cadastro (string ps_identificado);Long ll_Linhas

String ls_Dedos_Cadastrados

ivds_Digital.of_AppendWhere( "i.nr_cpf = '" + ps_Identificado + "'" )
ll_Linhas	=	ivds_Digital.Retrieve()
ivds_Digital.of_RestoreSqlOriginal()

If ll_Linhas < 0 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', ivds_Digital.ivo_dbError.of_Msg_Anywhere(), StopSign! )
	Return False
End If

If ll_Linhas > 0 Then
	This.of_Dedos_Cadastrados( ps_Identificado, ref ls_Dedos_Cadastrados )
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Usu$$HEX1$$e100$$ENDHEX$$rio j$$HEX1$$e100$$ENDHEX$$ possui cadastro biom$$HEX1$$e900$$ENDHEX$$trico.~r~rO dedo cadastrado para este usu$$HEX1$$e100$$ENDHEX$$rio $$HEX1$$e900$$ENDHEX$$ o ' + ls_Dedos_Cadastrados )
	Return False
End If

Return True
end function

public function boolean of_cadastra (string ps_identificado);If Not of_Permite_Cadastro( ps_Identificado ) Then Return False

If Not of_Inicializa() Then Return False

String ls_Captura
String ls_Dedo

Long ll_Count
Long ll_Filial
Long ll_Filial_Matriz

/* Caso queira habilitar dedos espec$$HEX1$$ed00$$ENDHEX$$ficos. True desabilita o dedo.
 * 0 = Polegar direito, 9 = Mindinho esquerdo
 */
//ivo_Extraction.DisableFingerForEnroll[0] = False
//ivo_Extraction.DisableFingerForEnroll[1] = True
//ivo_Extraction.DisableFingerForEnroll[2] = True
//ivo_Extraction.DisableFingerForEnroll[3] = True
//ivo_Extraction.DisableFingerForEnroll[4] = True
//ivo_Extraction.DisableFingerForEnroll[5] = True
//ivo_Extraction.DisableFingerForEnroll[6] = True
//ivo_Extraction.DisableFingerForEnroll[7] = True
//ivo_Extraction.DisableFingerForEnroll[8] = True
//ivo_Extraction.DisableFingerForEnroll[9] = False

ivo_Extraction.Enroll(1, 0)
ivo_Device.Close( NBioAPI_DEVICE_ID_AUTO_DETECT )
		
Choose Case ivo_Extraction.ErrorCode
	Case NBioAPIERROR_NONE	
		ls_Captura = String( ivo_Extraction.TextEncodeFIR )
		
		ivo_IndexSearch.AddFIR(ls_Captura, 0)
		
		If ivo_IndexSearch.ErrorCode = NBioAPIERROR_NONE Then
			If ivo_IndexSearch.Count > 2 Then
				If MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Efetue o cadastro de apenas um dedo de cada vez. Deseja refazer o cadastro?', Question!, YesNo! ) = 1 Then
					Return This.of_Cadastra( ps_Identificado )
				Else
					Return False
				End If
			End If
			
			For ll_Count = 1 To ivo_IndexSearch.Count				
				ivo_Result	= ivo_IndexSearch.Item[ ll_Count ]
				ls_Dedo		= String( ivo_Result.FingerID -1 )
			Next
		End If
		
		ivo_IndexSearch.RemoveData( 0, ivo_Result.FingerID, 0 )
		ivo_IndexSearch.RemoveData( 0, ivo_Result.FingerID, 1 )
					
		If of_Digital_Cadastro_Existe( ps_Identificado,  ls_Captura ) = 0 Then
			If of_Dedo_Cadastro_Existe( ps_Identificado, ls_Dedo ) Then
				If MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Dedo j$$HEX1$$e100$$ENDHEX$$ cadastrado, deseja cadastrar outro dedo?', Question!, YesNo! ) = 1 Then
					Return This.of_Cadastra( ps_Identificado )
				Else
					Return False
				End If
			Else
				
				gf_filiais_parametro( ref ll_Filial, ref ll_Filial_Matriz )
				
				Insert 
					Into identificacao_biometrica
						( nr_cpf, id_dedo, de_impressao_digital, cd_filial_atualizacao )
					Values ( :ps_Identificado, :ls_Dedo, :ls_Captura, :ll_Filial )
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case -1
						SqlCa.of_RollBack()
						SqlCa.of_MsgDbError("CADASTRO DA IMPRESS$$HEX1$$c300$$ENDHEX$$O DIGITAL")
						Return False
						
					Case Else
						SqlCa.of_Commit()
						Return True
				End Choose
			End If
		Else
			If MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Dedo j$$HEX1$$e100$$ENDHEX$$ cadastrado, deseja cadastrar outro dedo?', Question!, YesNo! ) = 1 Then
				Return This.of_Cadastra( ps_Identificado )
			Else
				Return False
			End If
		End If
		
		Case NBioAPIERROR_USER_CANCEL
				Return False
			
		Case NBioAPIERROR_CAPTURE_TIMEOUT
			If MessageBox( 'Falha na extra$$HEX2$$e700e300$$ENDHEX$$o da biometria !', 'Tempo excedido, tentar novamente?', Question!, YesNo! ) = 1 Then
				Return This.of_Cadastra( ps_Identificado )
			Else
				Return False
			End If
			
		Case NBioAPIERROR_DEVICE_LOST_DEVICE
			If MessageBox( 'Falha na extra$$HEX2$$e700e300$$ENDHEX$$o da biometria !', 'A conex$$HEX1$$e300$$ENDHEX$$o com o leitor foi perdida, tentar novamente?', Question!, YesNo! ) = 1 Then
				Open( w_Aguarde )
				w_Aguarde.Title = "Reiniciando leitor biom$$HEX1$$e900$$ENDHEX$$trico, aguarde..."
				Sleep( 3 )
				Close( w_Aguarde )
				Return This.of_Cadastra( ps_Identificado )
			End If
			
		Case Else
			MessageBox( 'Erro de leitura!', String( ivo_Extraction.ErrorDescription ) )
			Return False

End Choose
end function

public function boolean of_existe_digital_cadastrada (string ps_identificado);Long ll_Linhas

If ps_Identificado = '0' Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "CPF n$$HEX1$$e300$$ENDHEX$$o cadastrado." )
	Return False
End If

ivds_Digital.of_AppendWhere( "i.nr_cpf = '" + ps_Identificado + "'" )
ll_Linhas	=	ivds_Digital.Retrieve()
ivds_Digital.of_RestoreSqlOriginal()

If ll_Linhas < 0 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', ivds_Digital.ivo_dbError.of_Msg_Anywhere(), StopSign! )
	Return False
End If

If ll_Linhas > 0 Then 
	Return True
End If

Return False
end function

public function boolean of_dedos_cadastrados (string ps_identificado, ref string ps_mensagem);Long ll_Linha
Long ll_Linhas

Integer li_Id_Retorno

String ls_Digital_Banco
String ls_Msg_Retorno
String	ls_Dedos = ''

ivds_Digital.of_AppendWhere( "i.nr_cpf = '" + ps_Identificado + "'" )
ll_Linhas	=	ivds_Digital.Retrieve()
ivds_Digital.of_RestoreSqlOriginal()

If ll_Linhas < 0 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', ivds_Digital.ivo_dbError.of_Msg_Anywhere(), StopSign! )
	Return False
End If

For ll_Linha = 1 To ll_Linhas
	ls_Dedos	+= ivds_Digital.Object.Nm_Dedo[ ll_Linha ] + ", "
Next

ps_Mensagem = MidA( ls_Dedos, 1, LenA( ls_Dedos ) -2 )

Return True
end function

public function integer of_identifica (string ps_identificado);If Not of_Inicializa() Then Return -1

//ivo_Extraction.WindowStyle = NBioAPI_WINDOW_STYLE_INVISIBLE
//ivo_Extraction.FingerWnd	= Handle( pp_Image )

Boolean lb_Leu = False

Long ll_Linha
Long ll_Linhas
Long ll_Controle_Loop = 0

Integer li_Id_Retorno

String ls_Digital_Banco
String ls_Msg_Retorno

ivds_Digital.of_AppendWhere( "i.nr_cpf = '" + ps_Identificado + "'" )
ll_Linhas	=	ivds_Digital.Retrieve()
ivds_Digital.of_RestoreSqlOriginal()

If ll_Linhas < 0 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', ivds_Digital.ivo_dbError.of_Msg_Anywhere(), StopSign! )
	Return -1
End If

For ll_Linha = 1 To ll_Linhas
	SetNull( ls_Digital_Banco )
	ls_Digital_Banco	= Trim( ivds_Digital.Object.De_Impressao_Digital[ ll_Linha ] )
	
	ivo_IndexSearch.AddFIR( ls_Digital_Banco, ll_Linha )
	
	If ivo_IndexSearch.ErrorCode <> NBioAPIError_None Then 
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao gravar os dados na mem$$HEX1$$f300$$ENDHEX$$ria do leitor AddFIR' )
		Return -1
	End If
Next

Do While Not lb_Leu
	Yield()
	ivo_Extraction.Capture( NBioAPI_FIR_PURPOSE_VERIFY )
	
	ivl_Retorno_Identificacao	 = ivo_Extraction.ErrorCode
	Choose Case ivl_Retorno_Identificacao
			
		Case NBioAPIERROR_NONE
			lb_Leu = True
			ivo_Device.Close( NBioAPI_DEVICE_ID_AUTO_DETECT )
			ls_Msg_Retorno = ivo_Extraction.TextEncodeFIR
			ivo_IndexSearch.IdentifyUser( ls_Msg_Retorno, SECURELEVEL )
			li_Id_Retorno = ivo_IndexSearch.UserID
			
			If ivo_IndexSearch.ErrorCode <> NBioAPIERROR_NONE then 
				//MessageBox('Funcionario n$$HEX1$$e300$$ENDHEX$$o identificado !', '') 
				Return 0
			Else 
				//MessageBox('Funcionario identificado com sucesso', '')
				Return 1
			End If
			
		Case NBioAPIERROR_USER_CANCEL
			//If MessageBox( 'Falha na extra$$HEX2$$e700e300$$ENDHEX$$o da biometria!', 'Cancelado pelo usu$$HEX1$$e100$$ENDHEX$$rio, tentar novamente?', Question!, YesNo! ) = 2 Then
				lb_Leu = True
			//End If
			//
			
		Case NBioAPIERROR_CAPTURE_TIMEOUT
			If MessageBox( 'Falha na extra$$HEX2$$e700e300$$ENDHEX$$o da biometria!', 'Tempo excedido, tentar novamente?', Question!, YesNo! ) = 2 Then
				lb_Leu = True
			End If
			
		Case NBioAPIERROR_DEVICE_LOST_DEVICE
			If MessageBox( 'Falha na extra$$HEX2$$e700e300$$ENDHEX$$o da biometria!', 'A conex$$HEX1$$e300$$ENDHEX$$o com o leitor foi perdida, tentar novamente?', Question!, YesNo! ) = 2 Then
				lb_Leu = True
			End If
			
		Case NBIOAPIERROR_DEVICE_ALREADY_OPENED
			// Verifica se o captura ponto est$$HEX1$$e100$$ENDHEX$$ em execu$$HEX2$$e700e300$$ENDHEX$$o
			If Not This.of_Finaliza_Ponto( )	Then
				lb_Leu = True
			End If

		Case Else
			If MessageBox('Falha na extra$$HEX2$$e700e300$$ENDHEX$$o da biometria!', 'Ocorreu um erro na tentativa de leitura da digital, tentar novamente?', Question!, YesNo! ) = 2 Then
				lb_Leu = True
			End If
			
	End Choose
	
	If Not lb_Leu Then
		Open( w_Aguarde )
		w_Aguarde.Title = "Reiniciando leitor biom$$HEX1$$e900$$ENDHEX$$trico, aguarde..."

		Sleep( 2 )
		Close( w_Aguarde )
		
		Yield()
	End If
Loop

Return -1
end function

public function boolean of_verifica_drivers ();Long ll_FileLength
Long ll_Arquivo

String ls_Valor
String ls_Error
String ls_Diretorio
String ls_Arquivos[]

ls_Diretorio = "c:\sistemas\biometria"

If FileExists( "C:\Sistemas\" + gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + "\Exe\" + ivs_Instalador ) Then	
	If Not DirectoryExists ( ls_Diretorio ) Then
		CreateDirectory ( ls_Diretorio )
	End If
	
	gf_dir_list( ls_Diretorio, "*.*", 0+2+4, ref ls_Arquivos[] )
	
	For ll_Arquivo = 1 To UpperBound( ls_Arquivos )
		FileDelete( ls_Diretorio + "\" + ls_Arquivos[ ll_Arquivo ] )
	Next
	
	dc_uo_Api lo_Api
	lo_Api = Create dc_uo_Api 
	 
	 If lo_api.of_unzip( "C:\Sistemas\RL\Exe\" + ivs_Instalador, ls_Diretorio ) Then
		lo_api.of_Delete_File( "C:\Sistemas\RL\Exe\" + ivs_Instalador, False )
	 End If
	 
	 Destroy lo_Api

	If FileExists ( gvo_Aplicacao.of_Get_System_Directory() + "\" + "NBioBSPCOM.dll" ) Then
		FileDelete ( gvo_Aplicacao.of_Get_System_Directory() + "\" + 'NBioBSPCOM.dll' )
	End If
	
	If FileExists ( gvo_Aplicacao.of_Get_System_Directory() + "\" + "NBioBSP.dll" ) Then
		FileDelete ( gvo_Aplicacao.of_Get_System_Directory() + "\" + 'NBioBSP.dll' )
	End If
	
	If FileExists ( gvo_Aplicacao.of_Get_System_Directory() + "\" + ivs_Skin ) Then
		FileDelete ( gvo_Aplicacao.of_Get_System_Directory() + "\" + ivs_Skin )
	End If
		
	// Dll da antiga Skin
	If FileExists( gvo_Aplicacao.of_Get_System_Directory() + "\" + 'NBSP2.dll' ) Then
		FileDelete ( gvo_Aplicacao.of_Get_System_Directory() + "\" + 'NBSP2.dll' )
	End If
	//
	gf_Run( ls_Diretorio + '\install.exe' )
	
	If Not FileExists( gvo_Aplicacao.of_Get_System_Directory() + "\" + 'NBioBSP.dll' ) Then
		FileMove (  ls_Diretorio + '\NBioBSP.dll', gvo_Aplicacao.of_Get_System_Directory() + "\" + 'NBioBSP.dll' )
	End If
	
	If Not FileExists( gvo_Aplicacao.of_Get_System_Directory() + "\" + 'NBioBSPCOM.dll' ) Then
		FileMove (  ls_Diretorio + '\NBioBSPCOM.dll', gvo_Aplicacao.of_Get_System_Directory() + "\" + 'NBioBSPCOM.dll' )
	End If
	
	If Not FileExists( gvo_Aplicacao.of_Get_System_Directory() + "\" + ivs_Skin ) Then
		FileMove (  ls_Diretorio + '\' + ivs_Skin, gvo_Aplicacao.of_Get_System_Directory() + "\" + ivs_Skin )
	End If
	
	If FileExists( gvo_Aplicacao.of_Get_System_Directory() + "\" + 'NBioBSPCOM.dll' ) Then
		Run( "regsvr32.exe NBioBSPCOM.dll /s" )
	End If
	
	gf_Run( ls_Diretorio + '\vcredist_x86.exe /q /norestart' )
	
End If

Return True
end function

public function boolean of_dedo_cadastro_existe (string ps_identificado, string ps_dedo);Long ll_Linhas

ivds_Digital.of_AppendWhere( "i.nr_cpf = '" + ps_Identificado + "' and id_dedo = '" + ps_Dedo + "'" )

ll_Linhas	=	ivds_Digital.Retrieve()

ivds_Digital.of_RestoreSqlOriginal() 

If ll_Linhas < 0 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', ivds_Digital.ivo_dbError.of_Msg_Anywhere(), StopSign! )
	Return True
End If

If ll_Linhas > 0 Then 
	Return True
End If

Return False
end function

public function integer of_digital_cadastro_existe (string ps_identificado, string ps_captura);Long	ll_Linha, &
		ll_Linhas
		
String ls_Digital_Banco
String ls_Cpf_Identificado
String ls_Parametro

/* Para os casos onde o colaborador nao consegue cadastrar a digital, mensagem de que digital j$$HEX1$$e100$$ENDHEX$$ existe no cadastro */
Try
	uo_parametro_pdv lo_PDV // classe_comum.pbl
	lo_PDV = Create uo_parametro_pdv
	If lo_PDV.of_Localiza_parametro( 'ID_IGNORA_VERIFICACAO_DIGITAL_CADASTRADA', Ref ls_Parametro, False ) Then
		If ls_Parametro = 'S' Then Return 0
	End If
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_ge040_leitor_biometrico.of_digital_cadastro_existe( string, string)", StopSign! )
Finally
	If IsValid( lo_PDV ) Then Destroy lo_PDV
End Try
/** *** **/

ll_Linhas	=	ivds_Digital.Retrieve()

If ll_Linhas = 0 Then
	Return 0
End If

For ll_Linha = 1 To ll_Linhas
	SetNull( ls_Digital_Banco )
	ls_Digital_Banco = ivds_Digital.Object.De_Impressao_Digital[ ll_Linha ]
	
	ivo_IndexSearch.AddFIR( ls_Digital_Banco, ll_Linha )
	
	Choose Case ivo_IndexSearch.ErrorCode
		Case NBioAPIError_None
			// Continua
			
		Case NBioAPIERROR_INDEXSEARCH_DUPLICATED_ID
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "ID j$$HEX1$$e100$$ENDHEX$$ inserido na mem$$HEX1$$f300$$ENDHEX$$ria do leitor biom$$HEX1$$e900$$ENDHEX$$trico.", StopSign! )
	End Choose
Next

Open( w_Aguarde )
w_Aguarde.Title = "Verificando se a digital existe no cadastro, aguarde..."
ivo_IndexSearch.IdentifyUser( ps_Captura, SECURELEVEL )
Close( w_Aguarde )

If ivo_IndexSearch.ErrorCode <> NBioAPIERROR_NONE then
	Return 0
Else
	ll_Linha = ivo_IndexSearch.UserID
	ls_Cpf_Identificado = ivds_Digital.Object.Nr_Cpf[ ll_Linha ]
	gvo_Aplicacao.of_Grava_Log( "[CONFLITO DE DIGITAL] Procurado: " + ps_Identificado + " :: Encontrado: " + ls_Cpf_Identificado )
	Return 1
End If
end function

public function boolean of_usuario_isento_filial (string ps_matricula);String ls_Achou

ps_Matricula = '%,' + ps_Matricula + '%'

Select DISTINCT cd_parametro
   Into :ls_Achou
  From parametro_loja
Where cd_parametro like 'NR_MATRICULA_SEM_BIOMETRIA%'
    And vl_parametro like :ps_Matricula
 Using SqlCa;
 
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError( "uo_ge040_leitor_biometrico.of_usuario_isento_filial( )" )
		
	Case 0
		Return True
		
	Case 100
		
End Choose

Return False
end function

public function boolean of_usuario_isento (string ps_matricula);/* Verifica se $$HEX1$$e900$$ENDHEX$$ sistema de filial ou matriz
*	Se for filial, procura matr$$HEX1$$ed00$$ENDHEX$$cula na tabela parametro_loja, e encontrando, isenta o usu$$HEX1$$e100$$ENDHEX$$rio da identifica$$HEX2$$e700e300$$ENDHEX$$o biometrica
*  parametro NR_MATRICULA_SEM_BIOMETRIA%
*  SEMPRE INICIAR O VALOR DO PARAMETRO COM , (v$$HEX1$$ed00$$ENDHEX$$rgula)
*/

Long ll_Filial_Parametro
Long ll_Filial_Matriz

gf_Filiais_Parametro( ref ll_Filial_Parametro, ref ll_Filial_Matriz )

If ll_Filial_Parametro <> ll_Filial_Matriz Then
	Return of_Usuario_Isento_Filial( ps_Matricula )
Else
	Return False
End If
end function

public function boolean of_finaliza_ponto ();// Verifica se o captura ponto est$$HEX1$$e100$$ENDHEX$$ em execu$$HEX2$$e700e300$$ENDHEX$$o
If gvo_Aplicacao.of_AppIsRunning( "Senior | Gest$$HEX1$$e300$$ENDHEX$$o de Pessoas - Captura Ponto Portaria 373 - Vers$$HEX1$$e300$$ENDHEX$$o: 5.6.1.4" ) &
	Or gvo_Aplicacao.of_AppIsRunning( "Senior | Gest$$HEX1$$e300$$ENDHEX$$o de Pessoas - Captura Ponto" ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Minimize o programa captura Ponto e tente novamente.", StopSign! )
	
	dc_uo_Api lo_Api
	lo_Api = Create dc_uo_Api
	lo_Api.of_Maximiza_Janela( "Senior | Gest$$HEX1$$e300$$ENDHEX$$o de Pessoas - Captura Ponto" )
	Destroy lo_Api

	Return False
End If
	
Return True
end function

public function boolean of_procura_digital ();If Not of_Inicializa() Then Return False

Long ll_Linha
Long ll_Linhas
Long ll_Cpf

String ls_Cpf
String ls_Digital
String ls_Matricula
String ls_Nome

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

lvds_1.of_ChangeDataObject( "ds_ge040_digitais_cadastradas" )
ll_Linhas = lvds_1.Retrieve( )

For ll_Linha = 1 To ll_Linhas
	ls_Cpf = lvds_1.Object.Nr_Cpf[ ll_Linha ]
	ls_Digital = lvds_1.Object.De_Impressao_Digital[ ll_Linha ]
	ivo_IndexSearch.AddFIR( ls_Digital, ll_Linha )
	
	If ivo_Extraction.ErrorCode <> NBioAPIERROR_NONE Then
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Falha ao adicionar digital'  )
		Return False
	End If

Next

ivo_Extraction.Capture( NBioAPI_FIR_PURPOSE_VERIFY )

ivl_Retorno_Identificacao	 = ivo_Extraction.ErrorCode
Choose Case ivl_Retorno_Identificacao
		
	Case NBioAPIERROR_NONE
		ivo_Device.Close( NBioAPI_DEVICE_ID_AUTO_DETECT )
		ls_Digital = ivo_Extraction.TextEncodeFIR
		ivo_IndexSearch.IdentifyUser( ls_Digital, SECURELEVEL )
		ll_Linha = ivo_IndexSearch.UserID
		
	End Choose
	
If ll_Linha = 0 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Digital n$$HEX1$$e300$$ENDHEX$$o localizada no leitor biom$$HEX1$$e900$$ENDHEX$$trico." )
Else
	ls_Cpf = lvds_1.Object.Nr_Cpf[ ll_Linha ]	
	
	Select nr_matricula, nm_usuario
	Into :ls_Matricula, :ls_Nome
	From usuario
	Where nr_cpf = :ls_Cpf
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o",	"Digital cadastrada para o usu$$HEX1$$e100$$ENDHEX$$rio " + ls_Nome + &
											" (" + ls_Matricula  + " - " + ls_Cpf + ")" )
			Return True
		
		Case 100
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o localizado." )
			Return False
			
		Case -1
			SqlCa.of_MsgDbError()
			Return False
			
	End Choose	

End If

Return True
end function

public function boolean of_permite_senha_digitada ();String ls_Valor

String ls_Permite_Senha_Digitada_PDV

This.ib_Permite_Senha_Digitada = False

Try
	If il_Filial_Parametro = il_Filial_Matriz Then
		This.ib_Permite_Senha_Digitada = True
		Return True
	End If	
	
	uo_parametro_pdv lo_PDV
	lo_PDV = Create uo_parametro_pdv
	
	ls_Permite_Senha_Digitada_PDV = lo_PDV.of_get_permite_senha_digitada( )
	
	Choose Case ls_Permite_Senha_Digitada_PDV
		Case 'S' 
			//Chamado: 285107
			//Retorno = True, permite acessar o sistema com senha digitada, sobrepondo a regra da parametro_loja, por$$HEX1$$e900$$ENDHEX$$m, se houver leitor biom$$HEX1$$e900$$ENDHEX$$trico conectado, solicita biometria.
			This.ib_Permite_Senha_Digitada = ( Not This.of_Inicializa() )
			
		Case 'N'
			This.ib_Permite_Senha_Digitada = False
			
		Case Else
			Select vl_parametro
				Into :ls_Valor
			 From parametro_loja
			Where cd_parametro = 'ID_PERMITE_LOGIN_SENHA_DIGITADA'
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case -1
					SqlCa.of_MsgDbError( )
					Return False
					
				Case 0	
					This.ib_Permite_Senha_Digitada = ( ls_Valor = 'S' )
					
				Case 100	
					This.ib_Permite_Senha_Digitada = True
			End Choose
		
	End Choose
	
	Return True
Catch( RuntimeError ru )

Finally
	If IsValid(lo_PDV) Then Destroy lo_PDV
End Try
end function

on uo_ge040_leitor_biometrico.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge040_leitor_biometrico.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
If gvo_Aplicacao.ivb_Usa_Biometria Then
	If SqlCa.of_isconnected( ) Then
		ivds_Digital = Create dc_uo_ds_base
		
		ivds_Digital.of_ChangeDataObject('ds_ge040_digitais_cadastradas')
		
		gf_Filiais_Parametro( ref il_Filial_Parametro, ref il_Filial_Matriz )
	End if
End If
end event

event destructor;If IsValid( ivds_Digital ) 			Then Destroy ivds_Digital
If IsValid( ivo_Device ) 			Then Destroy ivo_Device
If IsValid( ivo_Extraction ) 		Then Destroy ivo_Extraction
If IsValid( ivo_IndexSearch ) 	Then Destroy ivo_IndexSearch
If IsValid( ivo_Leitor ) 			Then Destroy ivo_Leitor
end event

