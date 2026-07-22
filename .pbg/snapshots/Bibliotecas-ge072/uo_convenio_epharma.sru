HA$PBExportHeader$uo_convenio_epharma.sru
forward
global type uo_convenio_epharma from nonvisualobject
end type
end forward

global type uo_convenio_epharma from nonvisualobject
end type
global uo_convenio_epharma uo_convenio_epharma

type variables
Boolean localizado

Long cd_convenio
       
String nm_convenio 


end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_convenio (string ps_parametro)
public subroutine of_localiza_codigo (long pl_convenio)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);Long lvl_Convenio

OpenWithParm(w_ge072_Selecao_Convenio, ps_Parametro)

lvl_Convenio = Message.DoubleParm

If Not IsNull(lvl_Convenio) Then
	of_Localiza_Codigo(lvl_Convenio)
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();SetNull(cd_convenio)

Nm_Convenio = ""

end subroutine

public subroutine of_localiza_convenio (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = Len(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do conv$$HEX1$$ea00$$ENDHEX$$nio
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do conv$$HEX1$$ea00$$ENDHEX$$nio
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_localiza_codigo (long pl_convenio);Select cd_convenio,
       nm_convenio
Into :cd_convenio,
     :nm_convenio
From convenio_epharma
Where cd_convenio = :pl_convenio
  and id_situacao = 'A';
  
Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True		
	Case 100
		Localizado = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio." + SqlCa.SqlErrText, StopSign!)
		Localizado = False
End Choose
end subroutine

on uo_convenio_epharma.create
TriggerEvent( this, "constructor" )
end on

on uo_convenio_epharma.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetNull(Cd_Convenio)
Nm_Convenio = ""
end event

