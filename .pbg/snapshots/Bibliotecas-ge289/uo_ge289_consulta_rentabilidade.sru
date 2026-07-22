HA$PBExportHeader$uo_ge289_consulta_rentabilidade.sru
forward
global type uo_ge289_consulta_rentabilidade from nonvisualobject
end type
end forward

global type uo_ge289_consulta_rentabilidade from nonvisualobject
end type
global uo_ge289_consulta_rentabilidade uo_ge289_consulta_rentabilidade

type variables
Boolean localizada

Long cd_consulta

String de_consulta
end variables

forward prototypes
public subroutine of_localiza (string ps_parametro)
public subroutine of_localiza_codigo (long pl_codigo)
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da filial
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizada Then

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

public subroutine of_localiza_codigo (long pl_codigo);Select cd_consulta,
		 de_consulta
  Into :cd_consulta,
  		 :de_consulta
  From consulta_rentabilidade
 Where cd_consulta = :pl_Codigo
 Using SqlCa;
 
Choose Case SqlCa.SqlCode 
	Case -1
		Sqlca.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da consulta de rentabilidade.")
		Localizada = False
	Case 100
		Localizada = False
	Case Else
		Localizada = True
End Choose
end subroutine

public subroutine of_localiza_generica (string ps_parametro);STRING lvs_Descricao

OpenWithParm(w_ge289_selecao_consulta_rentabilidade, ps_Parametro)

lvs_Descricao = Message.StringParm

If Not IsNull(lvs_Descricao) Then
	of_Localiza_Codigo(Long(lvs_Descricao))
Else
	Localizada = False
End If
end subroutine

public subroutine of_inicializa ();
end subroutine

on uo_ge289_consulta_rentabilidade.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge289_consulta_rentabilidade.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;SetNull(cd_consulta)
De_Consulta = ""
end event

