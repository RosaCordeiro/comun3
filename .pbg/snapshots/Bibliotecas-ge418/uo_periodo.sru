HA$PBExportHeader$uo_periodo.sru
forward
global type uo_periodo from nonvisualobject
end type
end forward

global type uo_periodo from nonvisualobject
end type
global uo_periodo uo_periodo

type variables
DateTime ivdt_inicio, ivdt_fim
end variables

on uo_periodo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_periodo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

