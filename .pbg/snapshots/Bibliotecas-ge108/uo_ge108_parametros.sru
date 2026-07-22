HA$PBExportHeader$uo_ge108_parametros.sru
forward
global type uo_ge108_parametros from nonvisualobject
end type
end forward

global type uo_ge108_parametros from nonvisualobject
end type
global uo_ge108_parametros uo_ge108_parametros

type variables
Long Filial
Long Produto
Long Qtde_Solicitada
Long Pedido_Empurrado
Long Mix_Produto
Long Qtde_Minima_Aprovacao

//
String Matricula_Resp_Reserva
String Matricula_Vendedor

String Cliente

String Retorno

Boolean Habilita_Botao_Reserva_GE107 = False


//Nao realizado o changedataobject
dc_uo_ds_base ids

end variables

on uo_ge108_parametros.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge108_parametros.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.ids = Create dc_uo_ds_base
end event

event destructor;If IsValid( ids ) Then Destroy ids
end event

