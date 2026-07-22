HA$PBExportHeader$uo_ge108_mensagem_campanha.sru
forward
global type uo_ge108_mensagem_campanha from nonvisualobject
end type
end forward

global type uo_ge108_mensagem_campanha from nonvisualobject
end type
global uo_ge108_mensagem_campanha uo_ge108_mensagem_campanha

type variables
uo_produto io_produto
uo_cliente io_cliente

String is_Codigo_Mensagem
String is_Titulo_Mensagem
String is_Texto_Mensagem
String is_Tipo_Campanha

Long il_Codigo_Campanha

dc_uo_ds_base ids_produtos_campanha
end variables

on uo_ge108_mensagem_campanha.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge108_mensagem_campanha.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_produtos_campanha = Create dc_uo_ds_base
end event

event destructor;Destroy(ids_produtos_campanha)
end event

