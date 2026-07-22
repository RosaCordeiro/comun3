HA$PBExportHeader$uo_ge355_concorrente.sru
forward
global type uo_ge355_concorrente from nonvisualobject
end type
end forward

global type uo_ge355_concorrente from nonvisualobject
end type
global uo_ge355_concorrente uo_ge355_concorrente

type variables
Boolean Localizado

Long Cd_Concorrente

String is_Parametro
String Nm_Concorrente
String Id_Situacao
String Id_Nacional

//Busca de concorrentes locais
Long il_Filial_Retrieve
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (long al_concorrente)
public subroutine of_localiza_concorrente (string ps_parametro)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String ls_Concorrente

This.is_Parametro = ps_Parametro

OpenWithParm(w_ge355_selecao_concorrente, This)

ls_Concorrente = Message.StringParm

If Not IsNull(ls_Concorrente) Then
	of_Localiza_Codigo(Long(ls_Concorrente))
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();Localizado = False

SetNull(Cd_Concorrente)

SetNull(Nm_Concorrente)
SetNull(Id_Situacao)
SetNull(Id_Nacional)
SetNull(il_Filial_Retrieve)
end subroutine

public subroutine of_localiza_codigo (long al_concorrente);Select	cd_concorrente,
		nm_concorrente,
		id_situacao,
		id_nacional
Into	:Cd_Concorrente,
		:Nm_Concorrente,
		:Id_Situacao,
		:Id_Nacional
From concorrente
Where cd_concorrente = :al_concorrente
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True
	Case 100
		Localizado = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do concorrente. " + SqlCa.SqlErrText, StopSign!)
		Localizado = False
End Choose
end subroutine

public subroutine of_localiza_concorrente (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then
		
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo
		of_Localiza_Codigo(Long(ps_Parametro))
	
		If Not Localizado Then
			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")			
		End If

	Else
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome
		of_Localiza_Generica(ps_Parametro)
	End If
	
Else	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

on uo_ge355_concorrente.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge355_concorrente.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

