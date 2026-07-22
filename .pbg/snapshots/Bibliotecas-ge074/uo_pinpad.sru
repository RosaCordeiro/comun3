HA$PBExportHeader$uo_pinpad.sru
forward
global type uo_pinpad from nonvisualobject
end type
end forward

global type uo_pinpad from nonvisualobject
end type
global uo_pinpad uo_pinpad

type prototypes
FUNCTION String SESolicitaTrilha1_2( Ref String Status ) LIBRARY "c:\sistemas\dll\sitef\SitPin32.dll" alias for "SESolicitaTrilha1_2;Ansi"

FUNCTION String SEObtemTrilha1_2( Ref String Trilha1, Ref String Trilha2, Ref String Status ) LIBRARY "c:\sistemas\dll\sitef\SitPin32.dll" alias for "SEObtemTrilha1_2;Ansi"

FUNCTION String SEMsgPadrao( String Mensagem, String Status ) LIBRARY "c:\sistemas\dll\sitef\SitPin32.dll" alias for "SEMsgPadrao;Ansi"

FUNCTION String SESolicitaConf(String Mensagem, Ref String Status) LIBRARY "c:\sistemas\dll\sitef\SitPin32.dll" alias for "SESolicitaConf;Ansi"

FUNCTION String SEFinalizar() LIBRARY "c:\sistemas\dll\sitef\SitPin32.dll" alias for "SEFinalizar;Ansi"

//FUNCTION String SEObtemSenha( Ref String Senha , Ref String Status ) LIBRARY "c:\sistemas\dll\sitef\SitPin32.dll" alias for "SEObtemSenha;Ansi"

//FUNCTION String SESolicitaSenhaProprietaria( String ChaveSeguranca, String Mensagem , Ref String Status ) LIBRARY "c:\sistemas\dll\sitef\SitPin32.dll" alias for "SESolicitaSenhaProprietaria;Ansi"

FUNCTION String SEObtemSenhaClienteDireto( Ref String Senha , String SenhaPin , String ChaveSeguranca , String ChaveAbertura , Ref String Status ) LIBRARY "c:\sistemas\dll\sitef\mkseClamed.dll" alias for "SEObtemSenhaClienteDireto;Ansi"

FUNCTION String SEObtemChaveSeguranca( Ref String ChaveSeguranca, String BIN, String ChaveAbertura , Ref String Status ) LIBRARY "c:\sistemas\dll\sitef\mkseClamed.dll" alias for "SEObtemChaveSeguranca;Ansi"
end prototypes

type variables
//Protected String ChaveAbertura = 'a50b987992a3cc4aa234095138dc08e3' //dll antiga
Protected String ChaveAbertura = 'f28c80fcf337b387ad819da27120ac08' //dll Nova

//Protected String BIN = '96019630'
Protected String BIN = '003802' //dll nova

Boolean Instalado  = True
Boolean Leitura      = False
Boolean Digitacao = False
Boolean SenhaConfirmada = False
Boolean conveniado_senha_criptografada	= False
Boolean LiberacaoSenha 						= False
Boolean AlteracaoSenha 							= False
Boolean ib_Atualiza_Hash_Senha 				= False

String Trilha1
String Trilha2

String Cartao
String Bandeira
String Nome
String Tipo_cartao_saude

String Status
String Senha
String SenhaCapturada

String Retorno

String MatriculaLiberacao

String id_cartao_plano_saude_digitado

//Dados para identidicacao do sitef

String cd_conveniado
String nr_cpf_conveniado
String cd_cliente

String nr_cpf_cliente
end variables

forward prototypes
public function boolean of_verifica_arquivos ()
public function boolean of_leitura_cartao_magnetico ()
public function boolean of_captura_cartao_bandeira ()
public function boolean of_captura_cartao (string ps_bandeira)
public function boolean of_alteracao_senha (string ps_senha_atual)
public function boolean of_senha_pinpad (string ps_mensagem, ref string ps_senha)
public function boolean of_senha_aberta (string ps_mensagem, ref string ps_senha)
end prototypes

public function boolean of_verifica_arquivos ();String ls_path = 'c:\sistemas\dll\sitef'
String ls_path2 = 'c:\windows'
String ls_Path_System
String ls_driver
String ls_dll
String ls_arquivo

If Not FileExists(ls_path + '\SitPin32.dll') Then
	MessageBox("Configura$$HEX2$$e700e300$$ENDHEX$$o PinPad","Arquivo " + ls_path + "\SitPin32.dll n$$HEX1$$e300$$ENDHEX$$o encontrado.")
	Return False
End If	

If Not FileExists(ls_path2 + '\ppvisa.ini') Then
	MessageBox("Configura$$HEX2$$e700e300$$ENDHEX$$o PinPad","Arquivo " + ls_path2 + "\ppvisa.ini n$$HEX1$$e300$$ENDHEX$$o encontrado na pasta c:\windows.")
	Return False
Else
	If FileExists(ls_path + '\ppvisa.ini') Then
		FileDelete(ls_path + '\ppvisa.ini')
	End If	
End If	

If Not FileExists(ls_Path + '\mkseClamed.dll') Then
	MessageBox("Configura$$HEX2$$e700e300$$ENDHEX$$o PinPad","Arquivo " + ls_Path + "\mkseClamed.dll n$$HEX1$$e300$$ENDHEX$$o encontrado.")
	Return False
End If	

Return True
end function

public function boolean of_leitura_cartao_magnetico ();
String ls_trilha1
String ls_trilha2

String ls_Retorno

ls_trilha1 = FillA(' ',80)
ls_trilha2 = FillA(' ',40)

This.Leitura   = False
This.Digitacao = False

Do While True
	
	ls_Retorno = FillA(' ',02)
		
	Status = "ON"
		
	SEObtemTrilha1_2(Ref ls_trilha1, Ref ls_trilha2, Ref ls_Retorno)
	
	Status = "OFF"
		
	//Tecla CANC do pinpad pressionada
	Choose Case ls_Retorno
		Case "00"	

			//Leitura OK
			This.Trilha1 = ls_trilha1
			This.Trilha2 = ls_trilha2
		
			This.Leitura   = True
   			This.Digitacao = False
			   
	   		This.of_captura_cartao_bandeira()
			
			SetPointer(HourGlass!)
	
			SEMsgPadrao(" VOLTE SEMPRE ! ", Ref ls_Retorno)

			SetPointer(Arrow!)		
			
		Case "03"
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao inicializar pinpad. Tentar novamente ?",Question!,YesNo!,1) = 1 Then 
				Continue
			End If	

		Case "09"	
			//Opera$$HEX2$$e700e300$$ENDHEX$$o cancelada
			
		Case Else	
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao ler o cart$$HEX1$$e300$$ENDHEX$$o. Tentar novamente ?",Question!,YesNo!,1) = 1 Then 
				Continue
			End If	
		
	End Choose
	
	Exit
						
Loop

SEFinalizar()

If ls_Retorno <> "00" Then Return False

Return True
end function

public function boolean of_captura_cartao_bandeira ();
Choose Case Bandeira
	Case "UNIMED","CONTRATO"
		This.Cartao = LeftA(This.Trilha2,17)
		This.nome =  Trim(Upper(This.trilha1))
	Case "EMBRACO"
		This.Cartao = LeftA(This.Trilha2,19)
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Bandeira (" + This.Bandeira + ") n$$HEX1$$e300$$ENDHEX$$o habilitada.",Exclamation!)
		SetNull(This.Cartao)
		Return False
End Choose

Return True


end function

public function boolean of_captura_cartao (string ps_bandeira);
String ls_pinpad

//If Instalado Then 
//	If Not of_Verifica_Arquivos() Then Return False
//End If	

If Not of_Verifica_Arquivos() Then Return False

This.Bandeira = ps_bandeira

This.Instalado = Sitef.of_verifica_pinpad_sem_msg()

OpenWithParm(w_ge074_leitura_cartao_pinpad,This)

If Not Leitura and Not Digitacao Then Return False

If This.Digitacao Then
	
	//Essa implementa$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ devido a impress$$HEX1$$e300$$ENDHEX$$o externa do cart$$HEX1$$e300$$ENDHEX$$o ser diferente da tarja magn$$HEX1$$e900$$ENDHEX$$tica
	If This.Bandeira = "EMBRACO" Then
		This.Cartao = '9601' + Trim(This.Cartao)
	End If
	
End If

Return True


end function

public function boolean of_alteracao_senha (string ps_senha_atual);Boolean lb_Retorno

This.Senha = ps_senha_atual

This.AlteracaoSenha = True

//Senha padr$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o exige confirma$$HEX2$$e700e300$$ENDHEX$$o
If Not IsNull(This.Senha) Then
	gvo_Aplicacao.of_Grava_Log( "uo_pinpad - of_alteracao_senha - Vai entrar no processo de ALTERA$$HEX2$$c700c300$$ENDHEX$$O de senha." )

	OpenWithParm(w_ge074_solicita_senha,This)

	lb_Retorno = This.SenhaConfirmada
	
Else	
	lb_Retorno = True
End If	

If lb_Retorno Then
	
	lb_Retorno = False
	
	String ls_senha_nova
	
	gvo_Aplicacao.of_Grava_Log( "uo_pinpad - of_alteracao_senha - Vai entrar no processo de CADASTRAMENTO de senha." )	
	
	OpenWithParm(w_ge074_alteracao_senha,This)
	
	lb_Retorno = This.SenhaConfirmada
				
End If

Return lb_Retorno
end function

public function boolean of_senha_pinpad (string ps_mensagem, ref string ps_senha);String ls_Mensagem = 'Digite a senha :'
String ls_ChaveSeguranca
String ls_Retorno
String ls_SenhaCriptografada
String ls_Senha
String ls_Identificacao

Long ll_Senha_Validada

If IsNull(This.cd_cliente) Or Trim (This.cd_cliente) = '' Then
	If IsNull(This.nr_cpf_conveniado) Then
		ls_Identificacao = This.cd_conveniado
	Else
		ls_Identificacao = This.nr_cpf_conveniado
	End If
Else
	ls_Identificacao = This.cd_cliente
End If

If Sitef.of_captura_pinblock( ls_Identificacao ) Then
	//ps_senha  = Sitef.de_dado_captura_pinpad
	ps_senha  = Sitef.de_senha_capturada
	Return True
Else
	Return False
End If

/*
///Antigo
If Instalado Then 
	If Not of_Verifica_Arquivos() Then Return False
End If	

ls_ChaveSeguranca     	= FillA(' ',64)
ls_Retorno            		= FillA(' ',02)

This.SenhaConfirmada = False

SEObtemChaveSeguranca(Ref ls_ChaveSeguranca, This.BIN , ChaveAbertura , Ref ls_Retorno )

If ls_Retorno = "00" Then

	ls_Retorno        = FillA(' ',02)
	ls_ChaveSeguranca = LeftA(ls_ChaveSeguranca + FillA(' ',64), 64)
	
//	If Sitef.of_leitura_senha( ls_ChaveSeguranca ) Then		
	If Sitef.of_leitura_senha_direto( ls_ChaveSeguranca, ref ls_SenhaCriptografada ) Then	
		ls_retorno = "00"
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Processo cancelado ou problemas na rotina do Pinpad.",Exclamation!)
		Return False
	End If
	
	If ls_Retorno = "00" Then		
		ls_Senha   = space(20)
		ls_Retorno = space(02)
		ls_SenhaCriptografada = LeftA(ls_SenhaCriptografada + FillA(' ',20), 20)
			
 		SEObtemSenhaClienteDireto( Ref ls_Senha , ls_SenhaCriptografada , ls_ChaveSeguranca , ChaveAbertura , Ref ls_Retorno )
		   
		If ls_Retorno = "00" Then
				
			ps_Senha = Trim(MidA(ls_Senha,3))
			
			ll_Senha_Validada = LenA(ps_Senha)
			
			If ll_Senha_Validada = 4 Then		  
				This.SenhaCapturada  = ps_Senha								
			Else
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A senha deve conter 4 d$$HEX1$$ed00$$ENDHEX$$gitos.",Exclamation!)
				Return False
			End If
			
		End If
			
	End If
	
End If

This.Retorno = ls_Retorno

//SEFinalizar()

Choose Case This.Retorno
	Case "00"
		Return True
	Case "01"
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dll inv$$HEX1$$e100$$ENDHEX$$lida.",Exclamation!)
	Case "02"
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o aceito ou inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
	Case "03"
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Chave de cliente incorreta.",Exclamation!)
	Case "04"
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$digo de seguran$$HEX1$$e700$$ENDHEX$$a inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
	Case "05"
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Senha inv$$HEX1$$e100$$ENDHEX$$lida ou erro na captura.",Exclamation!)
	Case "09"	
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Precionada a tecla [CANCELA].",Exclamation!)
	Case "12"	
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pinpad sem comunica$$HEX2$$e700e300$$ENDHEX$$o ou desligado.",Exclamation!)		
End Choose

Return False
*/

end function

public function boolean of_senha_aberta (string ps_mensagem, ref string ps_senha);String ls_Mensagem = 'Digite a senha :'
String ls_ChaveSeguranca
String ls_Retorno
String ls_SenhaCriptografada
String ls_Senha

Long ll_Senha_Validada

//If Instalado Then 
//	If Not of_Verifica_Arquivos() Then Return False
//End If	
//
//ls_ChaveSeguranca     = FillA(' ',64)
//ls_Retorno            = FillA(' ',02)
//
//This.SenhaConfirmada = False

//	ls_Retorno        = FillA(' ',02)
//	ls_ChaveSeguranca = LeftA(ls_ChaveSeguranca + FillA(' ',64), 64)
//	
//	If Sitef.of_leitura_senha_direto( ls_ChaveSeguranca, ref ls_SenhaCriptografada ) Then	
//		ls_retorno = "00"
//	Else
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Processo cancelado ou problemas na rotina do Pinpad.",Exclamation!)
//		Return False
//	End If
	
//	If ls_Retorno = "00" Then		
//		ls_Senha   = space(20)
//		ls_Retorno = space(02)
//		ls_SenhaCriptografada = LeftA(ls_SenhaCriptografada + FillA(' ',20), 20)
//			
// 		SEObtemSenhaClienteDireto( Ref ls_Senha , ls_SenhaCriptografada , ls_ChaveSeguranca , ChaveAbertura , Ref ls_Retorno )
//		   
//		If ls_Retorno = "00" Then
//				
//			ps_Senha = Trim(MidA(ls_Senha,3))
//			
//			ll_Senha_Validada = LenA(ps_Senha)
//			
//			If ll_Senha_Validada = 4 Then		  
//				This.SenhaCapturada  = ps_Senha								
//			Else
//				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A senha deve conter 4 d$$HEX1$$ed00$$ENDHEX$$gitos.",Exclamation!)
//				Return False
//			End If
//			
//		End If
//			
//	End If

If Sitef.of_captura_dados_pinpad( 0, gvo_Aplicacao.ivo_Seguranca.nr_matricula, '00', 1, gvo_Aplicacao.ivo_Seguranca.nr_matricula, 'C', '4', '4' ) Then
	ps_senha  = Sitef.de_dado_captura_pinpad
	Return True
Else
	Return False
End If

Return False


end function

on uo_pinpad.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_pinpad.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

lvo_Parametro.of_Localiza_Parametro("ID_CARTAO_PLANO_SAUDE_DIGITADO", ref This.id_cartao_plano_saude_digitado, False)

Destroy(lvo_Parametro)
end event

