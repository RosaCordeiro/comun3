HA$PBExportHeader$uo_selecao_filiais.sru
forward
global type uo_selecao_filiais from nonvisualobject
end type
end forward

global type uo_selecao_filiais from nonvisualobject
end type
global uo_selecao_filiais uo_selecao_filiais

type variables
Long cd_filial[]

String nm_fantasia[]

boolean ivb_lista_regiao
end variables

on uo_selecao_filiais.create
TriggerEvent( this, "constructor" )
end on

on uo_selecao_filiais.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;ivb_Lista_Regiao = True
end event

