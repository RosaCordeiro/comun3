HA$PBExportHeader$uo_portador.sru
forward
global type uo_portador from nonvisualobject
end type
end forward

global type uo_portador from nonvisualobject
end type
global uo_portador uo_portador

type variables
Boolean Localizado

Long cd_portador

String de_portador
end variables

forward prototypes
public subroutine of_localiza_codigo (long al_parametro)
public subroutine of_localiza_portador (string as_parametro)
public subroutine of_localiza_generica (string as_parametro)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_codigo (long al_parametro);Select cd_portador,
		 de_portador
Into :cd_portador,
	  :de_portador
From portador
Where cd_portador = :al_parametro
and   	 id_situacao = 'A'
Using SqlCa;

Choose Case SqlCa.SqlCode
		Case 0 
			Localizado = True
		Case 100
			Localizado = False
		Case -1
			SqlCa.of_MsgDbError("Sele$$HEX2$$e700e300$$ENDHEX$$o do Portador")
			Localizado = False
End Choose 

	 

end subroutine

public subroutine of_localiza_portador (string as_parametro);String lvs_Parametro

lvs_Parametro = Trim(as_parametro)

// Verifica se foi informado algum par$$HEX1$$e200$$ENDHEX$$metro
If LenA(lvs_Parametro) > 0  Then
	
	// Verifica se o par$$HEX1$$e200$$ENDHEX$$metro $$HEX1$$e900$$ENDHEX$$ num$$HEX1$$e900$$ENDHEX$$rico
	If Isnumber(lvs_Parametro) Then
		
		This.of_Localiza_Codigo(Long(lvs_Parametro))
		
		// Verifica se encontrou algum par$$HEX1$$e200$$ENDHEX$$metro
		If Not Localizado Then
			This.of_Localiza_Generica(lvs_Parametro)
		End IF
		
	Else
		// Localiza com par$$HEX1$$e200$$ENDHEX$$metro
		This.of_Localiza_Generica(lvs_Parametro)
	End If
	
Else
	
	// Localiza sem par$$HEX1$$e200$$ENDHEX$$metro
	This.of_Localiza_Generica("")
End IF



end subroutine

public subroutine of_localiza_generica (string as_parametro);Long lvl_Portador

OpenWithParm(w_ge078_selecao_portador,as_parametro)

lvl_Portador = Message.DoubleParm

If Not IsNull(lvl_Portador) Then
	This.of_Localiza_Codigo(lvl_Portador)
Else
	Localizado = False
End If







end subroutine

public subroutine of_inicializa ();SetNull(Cd_Portador)
De_Portador = ""
end subroutine

on uo_portador.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_portador.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

