HA$PBExportHeader$uo_messagebox.sru
forward
global type uo_messagebox from nonvisualobject
end type
end forward

global type uo_messagebox from nonvisualobject
end type
global uo_messagebox uo_messagebox

type variables
String titulo
String texto

Integer retorno

Integer default

Button botao

Icon icone
end variables

on uo_messagebox.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_messagebox.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

