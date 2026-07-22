HA$PBExportHeader$uo_aguarde_epharma.sru
forward
global type uo_aguarde_epharma from nonvisualobject
end type
end forward

global type uo_aguarde_epharma from nonvisualobject
end type
global uo_aguarde_epharma uo_aguarde_epharma

type variables
string ivs_arquivo, &
         ivs_mensagem,&
         ivs_arquivo_ENV, &
		ivs_arquivo_dep

integer ivi_limite

time ivt_limite
 
end variables

on uo_aguarde_epharma.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_aguarde_epharma.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

