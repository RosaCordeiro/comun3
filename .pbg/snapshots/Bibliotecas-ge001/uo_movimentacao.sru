HA$PBExportHeader$uo_movimentacao.sru
forward
global type uo_movimentacao from nonvisualobject
end type
end forward

global type uo_movimentacao from nonvisualobject
end type
global uo_movimentacao uo_movimentacao

forward prototypes
public function boolean of_insere_movimentacao ()
end prototypes

public function boolean of_insere_movimentacao ();return true
end function

on uo_movimentacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_movimentacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

