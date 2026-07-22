HA$PBExportHeader$uo_imposto_sap.sru
forward
global type uo_imposto_sap from nonvisualobject
end type
end forward

global type uo_imposto_sap from nonvisualobject
end type
global uo_imposto_sap uo_imposto_sap

type variables
String	Cd_Imposto
String	De_Imposto
String	Id_Entrada_Saida

Boolean Localizado = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_generica (string ps_parametro)
public function boolean of_localiza_codigo (string ps_imposto_sap)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Imposto)
SetNull(De_Imposto)
SetNull(Id_Entrada_Saida)

Localizado = False
end subroutine

public function boolean of_localiza (string ps_parametro);If Len(Trim(ps_parametro)) <= 4 Then
	This.Of_Localiza_Codigo( ps_parametro )
End If

If Not Localizado Then
	This.Of_localiza_Generica(ps_parametro)
End If

Return Localizado
end function

public function boolean of_localiza_generica (string ps_parametro);String lvs_Retorno

OpenWithParm(w_ge021_selecao_imposto_sap, ps_parametro) 

lvs_Retorno = Message.StringParm

If Not IsNull(lvs_Retorno) and (Len(Trim(lvs_Retorno))<=4) and lvs_Retorno<>"" Then
	This.Of_Localiza_Codigo( lvs_Retorno )
Else
	This.Of_Inicializa( )
End If

Return Localizado
end function

public function boolean of_localiza_codigo (string ps_imposto_sap);This.Of_Inicializa()

Select cd_imposto, de_imposto, id_entrada_saida
Into :Cd_Imposto, :De_Imposto, :Id_Entrada_Saida
from imposto_sap
Where cd_imposto = :ps_imposto_sap
Using SQLCa;

Localizado = (SQLCa.SQLCode = 0)
If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o imposto (IVA) SAP." )
End If

Return Localizado
end function

on uo_imposto_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_imposto_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

