HA$PBExportHeader$uo_cidade.sru
forward
global type uo_cidade from nonvisualobject
end type
end forward

global type uo_cidade from nonvisualobject
end type
global uo_cidade uo_cidade

type variables
boolean localizada

long cd_cidade, &
	   nr_localidade_ect

string nm_cidade, &
         cd_unidade_federacao,&
         cd_cidade_ibge

string ivs_parametro_selecao

        


end variables

forward prototypes
public subroutine of_localiza_cidade (string ps_parametro)
public subroutine of_localiza_codigo (long pl_cidade)
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_cidade (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da cidade
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizada Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome da cidade
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_localiza_codigo (long pl_cidade);Select cd_cidade,
       nm_cidade,
		 cd_unidade_federacao,
		 cd_cidade_ibge,
		 nr_localidade_ect
Into :Cd_Cidade,
     :Nm_Cidade,
	  :Cd_Unidade_Federacao,
	  :cd_cidade_ibge,
	  :Nr_Localidade_Ect
From cidade
Where cd_cidade = :pl_Cidade
Using SqlCa;

If SqlCa.SqlCode = 100 Then
	Localizada = False
Else
	Localizada = True
End If
end subroutine

public subroutine of_localiza_generica (string ps_parametro);String lvs_Cidade

This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm(w_ge008_Selecao_Cidade, This)

lvs_Cidade = Message.StringParm

If Not IsNull(lvs_Cidade) Then
	of_Localiza_Codigo(Long(lvs_Cidade))
Else
	Localizada = False
End If
end subroutine

public subroutine of_inicializa ();SetNull(Cd_Cidade)
SetNull(Nr_Localidade_Ect)
Nm_Cidade = ""
Cd_Unidade_Federacao = ""
end subroutine

on uo_cidade.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cidade.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

