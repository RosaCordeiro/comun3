HA$PBExportHeader$uo_mensagem_email.sru
forward
global type uo_mensagem_email from nonvisualobject
end type
end forward

global type uo_mensagem_email from nonvisualobject
end type
global uo_mensagem_email uo_mensagem_email

type variables
Boolean Localizado = False

Long Cd_Mensagem
String De_Assunto
String De_Mensagem
String De_Sistema

end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_codigo (long pl_codigo)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Mensagem)
SetNull(De_Mensagem)
SetNull(De_Sistema)
SetNull(De_Assunto)

Localizado = False
end subroutine

public function boolean of_localiza (string ps_parametro);This.Of_inicializa( )

If IsNumber(ps_parametro) Then
	This.Of_Localiza_Codigo(Long(ps_parametro))
End If

If Not Localizado Then
	OpenWithParm(w_ge202_selecao_mensagem_email,ps_parametro)
	
	ps_parametro = Message.StringParm
	If ps_parametro<>'' Then
		This.Of_Localiza_Codigo(Long(ps_parametro))
	End If
End If

Return Localizado
end function

public function boolean of_localiza_codigo (long pl_codigo);select cd_mensagem,
		cd_sistema,
		upper(coalesce(de_assunto,de_observacao)),
		de_mensagem
Into 	:Cd_Mensagem,
		:De_Sistema,
		:De_Assunto,
		:De_Mensagem
From mensagem_email_sistema
Where cd_mensagem = :pl_codigo
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_msgdberror('Localiza$$HEX2$$e700e300$$ENDHEX$$o mensagem email sistema.')
End if

Localizado = (SQLCa.SQLCode = 0)

Return Localizado
end function

on uo_mensagem_email.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_mensagem_email.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

