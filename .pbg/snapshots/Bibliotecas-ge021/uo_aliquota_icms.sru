HA$PBExportHeader$uo_aliquota_icms.sru
forward
global type uo_aliquota_icms from nonvisualobject
end type
end forward

global type uo_aliquota_icms from nonvisualobject
end type
global uo_aliquota_icms uo_aliquota_icms

type variables
Decimal ivdc_Aliquota, &
              ivdc_Base_Calculo, &
              ivdc_Valor


end variables

on uo_aliquota_icms.create
TriggerEvent( this, "constructor" )
end on

on uo_aliquota_icms.destroy
TriggerEvent( this, "destructor" )
end on

