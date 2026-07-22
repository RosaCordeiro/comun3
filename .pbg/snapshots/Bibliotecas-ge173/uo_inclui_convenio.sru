HA$PBExportHeader$uo_inclui_convenio.sru
forward
global type uo_inclui_convenio from nonvisualobject
end type
end forward

global type uo_inclui_convenio from nonvisualobject
end type
global uo_inclui_convenio uo_inclui_convenio

type variables
long ivl_convenio[]
end variables

on uo_inclui_convenio.create
TriggerEvent( this, "constructor" )
end on

on uo_inclui_convenio.destroy
TriggerEvent( this, "destructor" )
end on

