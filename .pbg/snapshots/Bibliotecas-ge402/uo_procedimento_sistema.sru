HA$PBExportHeader$uo_procedimento_sistema.sru
forward
global type uo_procedimento_sistema from nonvisualobject
end type
end forward

global type uo_procedimento_sistema from nonvisualobject
end type
global uo_procedimento_sistema uo_procedimento_sistema

type variables
String	Cd_Procedimento
String De_Procedimento
String Id_Tipo_Procedimento
String Id_Situacao

Boolean Localizado = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (string ps_codigo)
private function boolean of_localiza_generica (string ps_parametro, string ps_sistema)
public function boolean of_localiza (string ps_parametro, string ps_sistema)
public function boolean of_localiza (string ps_parametro)
end prototypes

public subroutine of_inicializa ();SetNull( Cd_Procedimento )
SetNull( De_Procedimento )
SetNull( Id_Situacao )
SetNull( Id_Tipo_Procedimento )

Localizado = False
end subroutine

public function boolean of_localiza_codigo (string ps_codigo);//Localiza os valores no banco
SELECT cd_procedimento, de_procedimento, id_tipo_procedimento, id_situacao
Into  :Cd_Procedimento, :De_Procedimento, :Id_Tipo_Procedimento, :Id_Situacao
From procedimento
Where cd_procedimento = :ps_codigo
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

private function boolean of_localiza_generica (string ps_parametro, string ps_sistema);OpenWithParm(w_ge402_selecao_procedimento, ps_parametro+";"+ps_sistema)

If Not IsNull(Message.StringParm) and (Message.StringParm<>"") Then
	This.of_Localiza_Codigo( Message.StringParm )
Else
	This.Of_Inicializa( )
End If

Return Localizado

end function

public function boolean of_localiza (string ps_parametro, string ps_sistema);This.Of_Localiza_Codigo( ps_parametro )

If Not Localizado Then
	This.Of_Localiza_Generica( ps_parametro, ps_sistema )
End If

Return Localizado
end function

public function boolean of_localiza (string ps_parametro);Return This.Of_Localiza(ps_parametro, "")
end function

on uo_procedimento_sistema.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_procedimento_sistema.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

