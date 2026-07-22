HA$PBExportHeader$uo_cargo_rh.sru
forward
global type uo_cargo_rh from nonvisualobject
end type
end forward

global type uo_cargo_rh from nonvisualobject
end type
global uo_cargo_rh uo_cargo_rh

type variables
String Cd_Cargo_RH
String De_Cargo_RH

Boolean Localizado = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (string ps_cargo)
public function boolean of_localiza (string ps_parametro)
private function boolean of_localiza_generica (string ps_parametro)
end prototypes

public subroutine of_inicializa ();SetNull( Cd_Cargo_RH )
SetNull( De_Cargo_RH )

Localizado = False
end subroutine

public function boolean of_localiza_codigo (string ps_cargo);String lvs_Cargo

//Insere zeros a esquerda para caso seja digitado o c$$HEX1$$f300$$ENDHEX$$digo do cargo diretamente no filtro 
lvs_Cargo = ps_cargo
Do While Len(lvs_Cargo) < 9
	lvs_Cargo = '0'+lvs_Cargo
Loop

//Localiza os valores no banco
SELECT cd_cargo_rh, de_cargo_rh
Into  :Cd_Cargo_RH, :De_Cargo_RH
From cargo_rh
Where cd_cargo_rh = :ps_cargo
	or cd_cargo_rh = :lvs_Cargo
Using SQLCa;

//Trata retorno
Choose Case SQLCa.SQLCode
	Case -1
		This.of_Inicializa()
	Case 0
		Localizado = True
	Case 100
		This.of_Inicializa()
End Choose
	  
Return Localizado
end function

public function boolean of_localiza (string ps_parametro);If IsNumber(ps_parametro) Then
	This.Of_Localiza_Codigo( ps_parametro )
End If

If Not Localizado Then
	This.Of_Localiza_Generica( ps_parametro )
End If

Return Localizado
end function

private function boolean of_localiza_generica (string ps_parametro);OpenWithParm(w_ge384_selecao_cargo_rh,ps_parametro)

If IsNumber(Message.StringParm) Then
	This.of_Localiza_Codigo( Message.StringParm )
Else
	This.Of_inicializa( )
End If

Return Localizado

end function

on uo_cargo_rh.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cargo_rh.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

