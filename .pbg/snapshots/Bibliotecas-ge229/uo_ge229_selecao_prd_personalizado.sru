HA$PBExportHeader$uo_ge229_selecao_prd_personalizado.sru
forward
global type uo_ge229_selecao_prd_personalizado from nonvisualobject
end type
end forward

global type uo_ge229_selecao_prd_personalizado from nonvisualobject
end type
global uo_ge229_selecao_prd_personalizado uo_ge229_selecao_prd_personalizado

type variables
String ivs_Consulta

Long ivl_Filiais[]

dc_uo_ds_base ivds_Selecao, &
                          ivds_Selecao_Produto, &
                          ivds_Selecao_Filial
			

String ivs_TabPage_Selecionadas
								  
//ArrayList
String ivs_Grupo[]
String ivs_SubGrupo[]
String ivs_Categoria[]
String ivs_SubCategoria[]
String ivs_Mix[]
String ivs_Produto[]

Boolean ivb_Insere_Array = False
end variables

on uo_ge229_selecao_prd_personalizado.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge229_selecao_prd_personalizado.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivds_Selecao_Produto = Create dc_uo_ds_base
ivds_Selecao_Filial  = Create dc_uo_ds_base
end event

event destructor;Destroy(ivds_Selecao_Produto)
Destroy(ivds_Selecao_Filial)
end event

