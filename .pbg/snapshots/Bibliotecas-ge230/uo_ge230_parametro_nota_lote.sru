HA$PBExportHeader$uo_ge230_parametro_nota_lote.sru
forward
global type uo_ge230_parametro_nota_lote from nonvisualobject
end type
end forward

global type uo_ge230_parametro_nota_lote from nonvisualobject
end type
global uo_ge230_parametro_nota_lote uo_ge230_parametro_nota_lote

type variables
boolean ivb_sucesso = false

long nr_nf,&
        cd_filial

string de_especie,&
         de_serie,&
         cd_fornecedor,&
         id_tipo_nota,&
         id_origem_nf
         



end variables

on uo_ge230_parametro_nota_lote.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge230_parametro_nota_lote.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

