HA$PBExportHeader$uo_distribuidoras.sru
forward
global type uo_distribuidoras from nonvisualobject
end type
end forward

global type uo_distribuidoras from nonvisualobject
end type
global uo_distribuidoras uo_distribuidoras

type variables
String ivs_Distribuidoras
end variables

forward prototypes
public subroutine of_localiza_distribuidoras ()
end prototypes

public subroutine of_localiza_distribuidoras ();ivs_Distribuidoras = ""

OpenWithParm(w_lista_distribuidora, This)

ivs_Distribuidoras = Message.StringParm



end subroutine

on uo_distribuidoras.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_distribuidoras.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

