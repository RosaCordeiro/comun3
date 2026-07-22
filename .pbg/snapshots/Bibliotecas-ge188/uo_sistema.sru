HA$PBExportHeader$uo_sistema.sru
forward
global type uo_sistema from nonvisualobject
end type
end forward

global type uo_sistema from nonvisualobject
end type
global uo_sistema uo_sistema

type variables
String Codigo
String Descricao

Boolean Localizado = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_filtro)
private function boolean of_localiza_codigo (string ps_filtro)
private function boolean of_localiza_generica (string ps_filtro)
end prototypes

public subroutine of_inicializa ();SetNull(Codigo)
SetNull(Descricao)

Localizado = False
end subroutine

public function boolean of_localiza (string ps_filtro);If Len(Trim(ps_filtro))=2 Then
	If This.Of_localiza_codigo( ps_filtro) Then
		Return Localizado
	End If
End If

Return This.Of_Localiza_Generica(ps_filtro)
end function

private function boolean of_localiza_codigo (string ps_filtro);Select cd_sistema,
		 nm_sistema
Into 	:Codigo,
		:Descricao
From sistema
Where cd_sistema = :ps_filtro
Using SQLCa;

Localizado = (SQLCa.SQLCode = 0)

If SQLCa.SQLCode = -1 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao localizar a sistema.~r'+SQLCa.SQLErrText,StopSign!)
End If

Return Localizado
end function

private function boolean of_localiza_generica (string ps_filtro);String lvs_Sistema

OpenWithParm(w_ge188_selecao_sistema,ps_filtro)

lvs_Sistema = Message.StringParm

If lvs_Sistema = '' Then
	This.Of_Inicializa( )
Else
	This.Of_localiza_codigo(lvs_Sistema)
End if

Return Localizado
end function

on uo_sistema.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_sistema.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

