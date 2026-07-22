HA$PBExportHeader$uo_conta_sap.sru
forward
global type uo_conta_sap from nonvisualobject
end type
end forward

global type uo_conta_sap from nonvisualobject
end type
global uo_conta_sap uo_conta_sap

type variables
Boolean Localizada

String de_conta_sap
String cd_conta_sap, id_ativo

end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_generica (string ps_parametro)
public function boolean of_localiza_codigo (string ps_codigo)
public function boolean of_localiza (string ps_parametro)
end prototypes

public subroutine of_inicializa ();cd_conta_sap = ""
de_conta_sap = ""
id_ativo = ""

Localizada = False
end subroutine

public function boolean of_localiza_generica (string ps_parametro);String lvs_conta

OpenWithParm(w_ge187_selecao_conta_sap, ps_Parametro)

lvs_conta = Message.StringParm

If Not IsNull(lvs_conta) Then
	This.of_Localiza_Codigo(lvs_conta)
Else
	Localizada = False
End If

Return This.Localizada
end function

public function boolean of_localiza_codigo (string ps_codigo);Select cd_conta_sap,
		 de_conta_sap,
		 id_ativo
Into	:cd_conta_sap,
		:de_conta_sap,
		:id_ativo
From conta_sap
Where cd_conta_sap = :ps_codigo
Using SqlCa;
						 
Choose Case SqlCa.SqlCode
	Case 0
		Localizada = True
	Case 100
		Localizada = False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Conta SAP")
		Localizada = False
End Choose

Return This.Localizada
end function

public function boolean of_localiza (string ps_parametro);This.Of_Inicializa()

If LenA(ps_Parametro) = 8 Then			
	This.of_Localiza_Codigo(ps_Parametro)
End If

If Not This.Localizada Then
	This.of_Localiza_Generica(ps_Parametro)		
End If	

Return This.Localizada
end function

on uo_conta_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_conta_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

