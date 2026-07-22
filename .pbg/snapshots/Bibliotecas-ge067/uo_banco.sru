HA$PBExportHeader$uo_banco.sru
forward
global type uo_banco from nonvisualobject
end type
end forward

global type uo_banco from nonvisualobject
end type
global uo_banco uo_banco

type variables
Boolean Localizado

String cd_banco,&
          nm_banco,&
          ivs_parametro_selecao
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_banco (string ps_parametro)
public subroutine of_localiza_codigo (string pl_banco)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);STRING lvs_Banco

This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm(w_ge067_selecao_banco, This)

lvs_Banco = Message.StringParm

If Not IsNull(lvs_Banco) Then
	of_Localiza_Codigo(lvs_Banco)
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();cd_banco = ""
Nm_banco = ""

end subroutine

public subroutine of_localiza_banco (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da filial
		of_Localiza_Codigo(ps_Parametro)

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
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

public subroutine of_localiza_codigo (string pl_banco);String lvs_Regional

Select cd_banco,
       nm_banco
Into :cd_banco,
     :nm_banco
From banco
Where cd_banco = :pl_banco;

If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	Localizado = True		
End If
end subroutine

on uo_banco.create
TriggerEvent( this, "constructor" )
end on

on uo_banco.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetNull(This.Cd_Banco)

This.of_Inicializa()
end event

