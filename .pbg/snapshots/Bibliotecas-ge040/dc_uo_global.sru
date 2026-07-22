HA$PBExportHeader$dc_uo_global.sru
forward
global type dc_uo_global from nonvisualobject
end type
end forward

global type dc_uo_global from nonvisualobject
end type
global dc_uo_global dc_uo_global

on dc_uo_global.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_global.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

