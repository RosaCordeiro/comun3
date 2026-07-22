HA$PBExportHeader$uo_texto_paf2.sru
forward
global type uo_texto_paf2 from uo_texto_paf
end type
end forward

global type uo_texto_paf2 from uo_texto_paf
integer width = 814
integer height = 112
end type
global uo_texto_paf2 uo_texto_paf2

on uo_texto_paf2.create
call super::create
end on

on uo_texto_paf2.destroy
call super::destroy
end on

type st_msg_menu from uo_texto_paf`st_msg_menu within uo_texto_paf2
integer y = 0
integer width = 814
integer height = 108
end type

