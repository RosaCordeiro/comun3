HA$PBExportHeader$dc_uo_conexao.sru
forward
global type dc_uo_conexao from connection
end type
end forward

global type dc_uo_conexao from connection
end type
global dc_uo_conexao dc_uo_conexao

forward prototypes
public function boolean of_connecttoserver (string as_driver, string as_local, string as_aplicacao, string as_usuario, string as_senha, string as_string)
public function boolean of_remotestopconnection (string as_client)
end prototypes

public function boolean of_connecttoserver (string as_driver, string as_local, string as_aplicacao, string as_usuario, string as_senha, string as_string);Long lvl_Retorno

This.Driver        = as_Driver
This.Location      = as_Local
This.Application   = as_Aplicacao
This.UserId        = as_Usuario
This.PassWord      = as_Senha
This.ConnectString = as_String

lvl_Retorno = This.ConnectToServer()

If lvl_Retorno <> 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor.~r~r" + &
	                      "C$$HEX1$$f300$$ENDHEX$$digo: '" + String(lvl_Retorno) + "'~r~r" + &
								 "Driver: '" + as_Driver + "'~r" + &
								 "Endereco: '" + as_Local + "'~r" + &
								 "Porta: '" + as_Aplicacao + "'", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_remotestopconnection (string as_client);Long lvl_Retorno

lvl_Retorno = This.RemoteStopConnection(as_Client)

If lvl_Retorno <> 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na desconex$$HEX1$$e300$$ENDHEX$$o do cliente '" + as_Client + "'.", StopSign!)
	Return False
End If

Return True
end function

on dc_uo_conexao.create
call connection::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_conexao.destroy
call connection::destroy
TriggerEvent( this, "destructor" )
end on

event error;//String lvs_Mensagem
//
//lvs_Mensagem = "Ocorreu um erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor remoto.~r"
//
//If Not IsNull(ErrorNumber) Then
//	lvs_Mensagem += "~rN$$HEX1$$fa00$$ENDHEX$$mero: '" + String(ErrorNumber) + "'"
//End If
//
//If Not IsNull(ErrorText) Then
//	lvs_Mensagem += "~rMensagem: '" + ErrorText + "'"
//End If
//
//If Not IsNull(ErrorObject) Then
//	lvs_Mensagem += "~rObjeto: '" + ErrorObject + "'"
//End If
//
//If Not IsNull(ErrorScript) Then
//	lvs_Mensagem += "~rScript: '" + ErrorScript + "'"
//End If
//
//If Not IsNull(ErrorLine) Then
//	lvs_Mensagem += "~rLinha: '"  + String(ErrorLine) + "'"
//End If
//
//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, StopSign!)
//
Action = ExceptionSubstituteReturnValue!
end event

