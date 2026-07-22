HA$PBExportHeader$uo_ge217_parametro_proc_sistema.sru
forward
global type uo_ge217_parametro_proc_sistema from nonvisualobject
end type
end forward

global type uo_ge217_parametro_proc_sistema from nonvisualobject
end type
global uo_ge217_parametro_proc_sistema uo_ge217_parametro_proc_sistema

type variables
String ivs_Sistema, &
          ivs_Procedimento, &
          ivs_Nome
          
end variables

on uo_ge217_parametro_proc_sistema.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge217_parametro_proc_sistema.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

