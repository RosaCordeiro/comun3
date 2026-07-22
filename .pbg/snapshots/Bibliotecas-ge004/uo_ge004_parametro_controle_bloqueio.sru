HA$PBExportHeader$uo_ge004_parametro_controle_bloqueio.sru
forward
global type uo_ge004_parametro_controle_bloqueio from nonvisualobject
end type
end forward

global type uo_ge004_parametro_controle_bloqueio from nonvisualobject
end type
global uo_ge004_parametro_controle_bloqueio uo_ge004_parametro_controle_bloqueio

type variables
DataStore ivds_1

String  ivs_banco
end variables

on uo_ge004_parametro_controle_bloqueio.create
TriggerEvent( this, "constructor" )
end on

on uo_ge004_parametro_controle_bloqueio.destroy
TriggerEvent( this, "destructor" )
end on

