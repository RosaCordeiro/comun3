HA$PBExportHeader$uo_prestador_servico.sru
forward
global type uo_prestador_servico from nonvisualobject
end type
end forward

global type uo_prestador_servico from nonvisualobject
end type
global uo_prestador_servico uo_prestador_servico

type variables
Boolean Localizado

Long cd_prestador

String nm_prestador

          
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_prestador (string ps_parametro)
public subroutine of_localiza_codigo (long pl_prestador)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Prestador)
nm_Prestador = ""

end subroutine

public subroutine of_localiza_generica (string ps_parametro);Long lvl_Prestador

OpenWithParm(w_ge088_selecao_prestador_servico, ps_Parametro)

lvl_Prestador = Message.DoubleParm	

If Not IsNull(lvl_Prestador) Then
	of_Localiza_Codigo(lvl_Prestador)
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_prestador (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da prestador
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do prestador
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_localiza_codigo (long pl_prestador);Select cd_prestador,
       nm_prestador
Into :cd_prestador,
     :nm_prestador
From prestador_servico_clube
Where cd_prestador = :pl_Prestador;

Choose Case SqlCa.SqlCode 
	Case -1
		Sqlca.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o prestador de servi$$HEX1$$e700$$ENDHEX$$o do clube.")
		Localizado = False
	Case 100
		Localizado = False
	Case Else
		Localizado = True
End Choose
end subroutine

on uo_prestador_servico.create
TriggerEvent( this, "constructor" )
end on

on uo_prestador_servico.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetNull(This.Cd_Prestador)

This.of_Inicializa()
end event

