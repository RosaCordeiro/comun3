HA$PBExportHeader$uo_tipo_numerario_sap.sru
forward
global type uo_tipo_numerario_sap from nonvisualobject
end type
end forward

global type uo_tipo_numerario_sap from nonvisualobject
end type
global uo_tipo_numerario_sap uo_tipo_numerario_sap

type variables
Boolean Localizado

String de_tipo_numerario_sap
String cd_tipo_numerario_sap, id_credito_debito, cd_conta_contabil_sap

end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_generica (string ps_parametro)
public function boolean of_localiza_codigo (string ps_codigo)
public function boolean of_localiza (string ps_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(cd_tipo_numerario_sap)
de_tipo_numerario_sap = ""
id_credito_debito = ""
cd_conta_contabil_sap = ""

Localizado = False
end subroutine

public function boolean of_localiza_generica (string ps_parametro);String lvs_conta

OpenWithParm(w_ge187_selecao_numerario_sap, ps_Parametro)

lvs_conta = Message.StringParm

If Not IsNull(lvs_conta) Then
	This.of_Localiza_Codigo(lvs_conta)
Else
	Localizado = False
End If

Return This.Localizado
end function

public function boolean of_localiza_codigo (string ps_codigo);
Select	 cd_tipo_numerario_sap,
		 de_tipo_numerario_sap,
		 id_credito_debito,
		 cd_conta_contabil_sap
Into	:cd_tipo_numerario_sap,
		:de_tipo_numerario_sap,
		:id_credito_debito,
		:cd_conta_contabil_sap
From tipo_numerario_sap
Where cd_tipo_numerario_sap = :ps_codigo
Using SqlCa;
						 
Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True
	Case 100
		Localizado = False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo de Numer$$HEX1$$e100$$ENDHEX$$rio SAP")
		Localizado = False
End Choose

Return This.Localizado
end function

public function boolean of_localiza (string ps_parametro);If LenA(ps_Parametro) = 4 Then			
	This.of_Localiza_Codigo(ps_Parametro)
End If

If Not This.Localizado Then
	This.of_Localiza_Generica(ps_Parametro)		
End If	

Return This.Localizado
end function

on uo_tipo_numerario_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tipo_numerario_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

