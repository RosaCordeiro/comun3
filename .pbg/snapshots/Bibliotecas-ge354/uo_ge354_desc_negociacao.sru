HA$PBExportHeader$uo_ge354_desc_negociacao.sru
forward
global type uo_ge354_desc_negociacao from nonvisualobject
end type
end forward

global type uo_ge354_desc_negociacao from nonvisualobject
end type
global uo_ge354_desc_negociacao uo_ge354_desc_negociacao

type variables
Boolean Localizada

DateTime Dh_Inicio
DateTime Dh_Termino
DateTime Dh_Inclusao

Decimal Pc_Desconto_Maximo
Decimal Pc_Rentabilidade_Minima

Long Cd_Negociacao
Long Cd_Tipo

String is_Parametro

String Nm_Negociacao
String Nr_Matricula_Inclusao
String Nr_Matricula_Alteracao
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_negociacao (string ps_parametro)
public subroutine of_localiza_codigo (long al_negociacao)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String ls_Negociacao

This.is_Parametro = ps_Parametro

OpenWithParm(w_ge354_selecao_desc_negociacao, This)

ls_Negociacao = Message.StringParm

If Not IsNull(ls_Negociacao) Then
	of_Localiza_Codigo(Long(ls_Negociacao))
Else
	Localizada = False
End If
end subroutine

public subroutine of_inicializa ();Localizada = False

SetNull(Dh_Inicio)
SetNull(Dh_Termino)
SetNull(Dh_Inclusao)

SetNull(Pc_Desconto_Maximo)
SetNull(Pc_Rentabilidade_Minima)

SetNull(Cd_Negociacao)
SetNull(Cd_Tipo)

SetNull(Nm_Negociacao)
SetNull(Nr_Matricula_Inclusao)
SetNull(Nr_Matricula_Alteracao)
end subroutine

public subroutine of_localiza_negociacao (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then
		
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo
		of_Localiza_Codigo(Long(ps_Parametro))
	
		If Not Localizada Then				
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

public subroutine of_localiza_codigo (long al_negociacao);Select	cd_negociacao,
		nm_negociacao,
		dh_inicio,
		dh_termino,
		cd_tipo,
		pc_desconto_maximo,
		pc_rentabilidade_minima,
		nr_matricula_inclusao,
		dh_inclusao,
		nr_matricula_alteracao
Into	:Cd_Negociacao,
		:Nm_Negociacao,
		:Dh_Inicio,
		:Dh_Termino,
		:Cd_Tipo,
		:Pc_Desconto_Maximo,
		:Pc_Rentabilidade_Minima,
		:Nr_Matricula_Inclusao,
		:Dh_Inclusao,
		:Nr_Matricula_Alteracao
From negociacao
Where cd_negociacao = :al_negociacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizada = True
	Case 100
		Localizada = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do desconto de negocia$$HEX2$$e700e300$$ENDHEX$$o. " + SqlCa.SqlErrText, StopSign!)
		Localizada = False
End Choose
end subroutine

on uo_ge354_desc_negociacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge354_desc_negociacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

