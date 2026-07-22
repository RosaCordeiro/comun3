HA$PBExportHeader$uo_parametro_selecao_condicao_venda_cv.sru
forward
global type uo_parametro_selecao_condicao_venda_cv from nonvisualobject
end type
end forward

global type uo_parametro_selecao_condicao_venda_cv from nonvisualobject
end type
global uo_parametro_selecao_condicao_venda_cv uo_parametro_selecao_condicao_venda_cv

type variables
Long ivl_Convenio

Integer ivi_Condicao_Venda

String   ivs_Nome

String is_Somente_Ativas
          
end variables

on uo_parametro_selecao_condicao_venda_cv.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametro_selecao_condicao_venda_cv.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

