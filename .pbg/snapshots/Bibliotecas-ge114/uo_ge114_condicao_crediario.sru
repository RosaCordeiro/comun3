HA$PBExportHeader$uo_ge114_condicao_crediario.sru
forward
global type uo_ge114_condicao_crediario from nonvisualobject
end type
end forward

global type uo_ge114_condicao_crediario from nonvisualobject
end type
global uo_ge114_condicao_crediario uo_ge114_condicao_crediario

type variables
DateTime dh_movimentacao

decimal {2} idc_valor_total
decimal {2} vl_total_venda
decimal {2} vl_entrada_crediario
decimal {2} pc_entrada_crediario

String de_condicao_crediario

Long cd_condicao_crediario
Long nr_parcela_crediario

String retorno

 uo_Pedido_DrogaExpress ivo_Pedido
end variables
on uo_ge114_condicao_crediario.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge114_condicao_crediario.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

