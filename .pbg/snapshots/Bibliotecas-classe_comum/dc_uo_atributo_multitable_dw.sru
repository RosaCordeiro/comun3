HA$PBExportHeader$dc_uo_atributo_multitable_dw.sru
forward
global type dc_uo_atributo_multitable_dw from nonvisualobject
end type
end forward

global type dc_uo_atributo_multitable_dw from nonvisualobject
end type
global dc_uo_atributo_multitable_dw dc_uo_atributo_multitable_dw

type variables
string ivs_tabela, &
         ivs_chave[], &
         ivs_coluna[]

integer ivi_whereoption

boolean ivb_keyupdateinplace
end variables

on dc_uo_atributo_multitable_dw.create
TriggerEvent( this, "constructor" )
end on

on dc_uo_atributo_multitable_dw.destroy
TriggerEvent( this, "destructor" )
end on

