HA$PBExportHeader$uo_fabricante.sru
forward
global type uo_fabricante from nonvisualobject
end type
end forward

global type uo_fabricante from nonvisualobject
end type
global uo_fabricante uo_fabricante

type variables
Boolean Localizado

Long cd_fabricante
String nm_razao_social = "", &
          nr_cgc, &
          ivs_Parametro_Selecao
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_fabricante (string ps_parametro)
public subroutine of_localiza_codigo (long pl_fabricante)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);Long lvl_Fabricante

This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm(w_ge087_Selecao_Fabricante, This)

lvl_Fabricante = Long(Message.StringParm)

If Not IsNull(lvl_Fabricante) Then
	of_Localiza_Codigo(lvl_Fabricante)
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();SetNull(Cd_Fabricante)
Nm_Razao_Social = ""
Nr_Cgc = ""
end subroutine

public subroutine of_localiza_fabricante (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do cliente
		of_Localiza_Codigo(Long(ps_Parametro))

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

public subroutine of_localiza_codigo (long pl_fabricante);Long lvl_Fabricante

Select f.cd_fabricante,
       f.nm_razao_social,
		 f.nr_cgc 
 Into :Cd_Fabricante,
	   :Nm_Razao_Social,
      :nr_cgc
 From fabricante f
Where f.cd_fabricante = :pl_fabricante;

Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True
		
	Case 100
		Localizado = False
		
	Case -1
		Localizado = False
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Fabricante")
End Choose
end subroutine

on uo_fabricante.create
TriggerEvent( this, "constructor" )
end on

on uo_fabricante.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;This.of_Inicializa()
end event

