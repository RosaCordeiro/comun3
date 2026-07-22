HA$PBExportHeader$uo_atributos_titulo.sru
forward
global type uo_atributos_titulo from nonvisualobject
end type
end forward

global type uo_atributos_titulo from nonvisualobject
end type
global uo_atributos_titulo uo_atributos_titulo

type variables
String ivs_numero
Decimal{2} ivdc_juros, ivdc_desconto, ivdc_pago, &
ivdc_despesa_cobranca
end variables

on uo_atributos_titulo.create
TriggerEvent( this, "constructor" )
end on

on uo_atributos_titulo.destroy
TriggerEvent( this, "destructor" )
end on

