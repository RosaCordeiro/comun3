HA$PBExportHeader$uo_ge570_dados_obrigatorios.sru
forward
global type uo_ge570_dados_obrigatorios from nonvisualobject
end type
end forward

global type uo_ge570_dados_obrigatorios from nonvisualobject
end type
global uo_ge570_dados_obrigatorios uo_ge570_dados_obrigatorios

type variables
String nm_Pescritor
String uf_Prescritor
String id_Tipo_Registro
String nr_Registro

String nr_Fone_Fixo
String nr_fone_celular
String de_email
String nr_cpf

String nr_cartao_industria

Date dh_nascimento
end variables

on uo_ge570_dados_obrigatorios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge570_dados_obrigatorios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

