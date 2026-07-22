HA$PBExportHeader$uo_motivo_bloqueio.sru
forward
global type uo_motivo_bloqueio from nonvisualobject
end type
end forward

global type uo_motivo_bloqueio from nonvisualobject
end type
global uo_motivo_bloqueio uo_motivo_bloqueio

type variables
Boolean Localizado

String Cd_Motivo_Bloqueio, & 
          De_Motivo_Bloqueio

end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_codigo (string ps_motivo)
public subroutine of_localiza_motivo_bloqueio (string ps_parametro)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_generica (string ps_parametro);STRING lvs_Motivo_Bloqueio

OpenWithParm(w_ge007_Selecao_Motivo_Bloqueio, ps_Parametro)

lvs_Motivo_Bloqueio = Message.StringParm

If Not IsNull(lvs_Motivo_Bloqueio) Then
	of_Localiza_Codigo(lvs_Motivo_Bloqueio)
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_codigo (string ps_motivo);Select cd_motivo_bloqueio,
       de_motivo_bloqueio
Into :Cd_Motivo_Bloqueio,
     :De_Motivo_Bloqueio
From motivo_bloqueio
Where cd_motivo_bloqueio = :ps_Motivo;

If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	Localizado = True
End If
end subroutine

public subroutine of_localiza_motivo_bloqueio (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If LenA(Trim(ps_Parametro)) <= 3 Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da cidade
		of_Localiza_Codigo(ps_Parametro)

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica(ps_Parametro)
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_inicializa ();Localizado = False

SetNull( Cd_Motivo_Bloqueio )
SetNull( De_Motivo_Bloqueio )
end subroutine

on uo_motivo_bloqueio.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_motivo_bloqueio.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

