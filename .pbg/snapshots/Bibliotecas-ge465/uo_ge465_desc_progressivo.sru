HA$PBExportHeader$uo_ge465_desc_progressivo.sru
forward
global type uo_ge465_desc_progressivo from nonvisualobject
end type
end forward

global type uo_ge465_desc_progressivo from nonvisualobject
end type
global uo_ge465_desc_progressivo uo_ge465_desc_progressivo

type variables
Boolean Localizada


Long Cd_Desconto

String is_Parametro,&
		 Id_Situacao
		 
String De_Desconto

end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_negociacao (string ps_parametro)
public subroutine of_localiza_codigo (long al_negociacao)
public function string of_localiza_descricao (long al_desconto)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String ls_Desconto

This.is_Parametro = ps_Parametro

OpenWithParm(w_ge465_selecao_desc_progressivo, This)

ls_Desconto = Message.StringParm

If Not IsNull(ls_Desconto) Then
	of_Localiza_Codigo(Long(ls_Desconto))
Else
	Localizada = False
End If
end subroutine

public subroutine of_inicializa ();Localizada = False
SetNull(Cd_Desconto)
SetNull(De_Desconto)

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

public subroutine of_localiza_codigo (long al_negociacao);select cd_desconto, de_desconto
Into	:Cd_Desconto,
		:De_Desconto		
from desconto_progressivo
where cd_desconto = :al_negociacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizada = True
	Case 100
		Localizada = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do desconto de progressivo. " + SqlCa.SqlErrText, StopSign!)
		Localizada = False
End Choose
end subroutine

public function string of_localiza_descricao (long al_desconto);String ls_Desconto

select   de_desconto  
Into      :ls_Desconto 
From   desconto_progressivo  
where cd_desconto =:al_desconto
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do desconto de progressivo. " + SqlCa.SqlErrText, StopSign!)
		Localizada = False
End Choose


Return ls_Desconto

end function

on uo_ge465_desc_progressivo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge465_desc_progressivo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

