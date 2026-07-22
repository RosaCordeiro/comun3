HA$PBExportHeader$uo_ge041_nf_manip.sru
forward
global type uo_ge041_nf_manip from nonvisualobject
end type
end forward

global type uo_ge041_nf_manip from nonvisualobject
end type
global uo_ge041_nf_manip uo_ge041_nf_manip

type variables
Long filial
Long nf

String especie
String serie
end variables

on uo_ge041_nf_manip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge041_nf_manip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

