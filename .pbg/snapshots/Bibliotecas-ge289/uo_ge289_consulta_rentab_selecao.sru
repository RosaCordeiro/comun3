HA$PBExportHeader$uo_ge289_consulta_rentab_selecao.sru
forward
global type uo_ge289_consulta_rentab_selecao from nonvisualobject
end type
end forward

global type uo_ge289_consulta_rentab_selecao from nonvisualobject
end type
global uo_ge289_consulta_rentab_selecao uo_ge289_consulta_rentab_selecao

type variables
String ivs_Consulta

Long ivl_Filiais[]

dc_uo_ds_base ivds_Selecao, &
                          ivds_Selecao_Produto, &
                          ivds_Selecao_Filial
end variables

on uo_ge289_consulta_rentab_selecao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge289_consulta_rentab_selecao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivds_Selecao_Produto = Create dc_uo_ds_base
ivds_Selecao_Filial  = Create dc_uo_ds_base
end event

event destructor;Destroy(ivds_Selecao_Produto)
Destroy(ivds_Selecao_Filial)
end event

