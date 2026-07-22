HA$PBExportHeader$w_ge572_processa.srw
forward
global type w_ge572_processa from dc_w_response
end type
end forward

global type w_ge572_processa from dc_w_response
string title = "GE572 - Atualizando Cart$$HEX1$$e300$$ENDHEX$$o Sa$$HEX1$$fa00$$ENDHEX$$de"
boolean controlmenu = false
end type
global w_ge572_processa w_ge572_processa

on w_ge572_processa.create
call super::create
end on

on w_ge572_processa.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;uo_ge572_cartao_saude lo
lo = Create uo_ge572_cartao_saude
lo.of_atualiza_cartao_saude( False )
If IsValid(lo) Then Destroy lo

Close(This)
end event

type pb_help from dc_w_response`pb_help within w_ge572_processa
end type

