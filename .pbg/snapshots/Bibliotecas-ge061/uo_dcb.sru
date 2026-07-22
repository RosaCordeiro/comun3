HA$PBExportHeader$uo_dcb.sru
forward
global type uo_dcb from nonvisualobject
end type
end forward

global type uo_dcb from nonvisualobject
end type
global uo_dcb uo_dcb

type variables
string cd_dcb, &
          de_dcb
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_generica (string as_parametro)
public function boolean of_localiza_codigo (string as_codigo)
public function boolean of_localiza (string as_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_DCB)
De_DCB = ""

end subroutine

public function boolean of_localiza_generica (string as_parametro);String lvs_Codigo

OpenWithParm(w_ge061_Selecao_DCB, as_Parametro)

lvs_Codigo = Message.StringParm

If Not IsNull(lvs_Codigo) Then
	Return This.of_Localiza_Codigo(lvs_Codigo)
Else
	Return False
End If
end function

public function boolean of_localiza_codigo (string as_codigo);Select cd_dcb,
       de_dcb
Into :cd_dcb,
	  :de_dcb
From dcb_produto
Where cd_dcb = :as_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		Return False
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do DCB")
		Return False
End Choose
end function

public function boolean of_localiza (string as_parametro);If LenA(as_Parametro) > 0 Then
	If IsNumber(as_Parametro) Then
		If Not This.of_Localiza_Codigo(as_Parametro) Then
			Return This.of_Localiza_Generica("")
		Else
			Return True
		End If
	Else
		Return This.of_Localiza_Generica(as_Parametro)
	End If
Else
	Return This.of_Localiza_Generica("")
End If
end function

on uo_dcb.create
TriggerEvent( this, "constructor" )
end on

on uo_dcb.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;This.of_Inicializa()
end event

