HA$PBExportHeader$uo_atributo_fiscal_item_nf.sru
forward
global type uo_atributo_fiscal_item_nf from nonvisualobject
end type
end forward

global type uo_atributo_fiscal_item_nf from nonvisualobject
end type
global uo_atributo_fiscal_item_nf uo_atributo_fiscal_item_nf

type variables
Boolean Localizado

String Cd_Situacao_Tributaria
String Cd_CST_Tributacao
String Cd_Tributacao_ICMS

Long Cd_Natureza_Operacao

Decimal Pc_ICMS
end variables

on uo_atributo_fiscal_item_nf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_atributo_fiscal_item_nf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

