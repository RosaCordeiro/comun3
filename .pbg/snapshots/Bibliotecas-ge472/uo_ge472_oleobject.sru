HA$PBExportHeader$uo_ge472_oleobject.sru
forward
global type uo_ge472_oleobject from oleobject
end type
end forward

global type uo_ge472_oleobject from oleobject
end type
global uo_ge472_oleobject uo_ge472_oleobject

type variables
Private: 
	String ivs_Log_Source 		= ""
	String ivs_Log_Description	= ""
end variables

forward prototypes
public subroutine of_limpa_log ()
public subroutine of_get_log (ref string ps_source, ref string ps_descricao)
end prototypes

public subroutine of_limpa_log ();ivs_Log_Source 		= ""
ivs_Log_Description	= ""
end subroutine

public subroutine of_get_log (ref string ps_source, ref string ps_descricao);ps_source 		= ivs_Log_Source
ps_descricao	= ivs_Log_Description
end subroutine

on uo_ge472_oleobject.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge472_oleobject.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event externalexception;ivs_Log_Source 		= Source
ivs_Log_Description	= Description

//Grava log arquivo texto da aplica$$HEX2$$e700e300$$ENDHEX$$o
gvo_aplicacao.of_Grava_Log( This.ClassName()+" External Exception~r~nResult Code: "+String(ResultCode)+ &
									"~r~nException Code: "+String(ExceptionCode)+"~r~nSource: "+Source+"~r~nDescription:" +Description+ &
									IIF(IsNull(HelpFile), "", "~r~nHelp File: "+HelpFile)+"~r~nHelp Context: "+String(HelpContext))
end event

event error;ivs_Log_Source 		= ErrorObject
ivs_Log_Description	= ErrorScript

//Grava log arquivo texto da aplica$$HEX2$$e700e300$$ENDHEX$$o
gvo_aplicacao.of_grava_log("OleObject External Exception: ~rObject: " +ErrorObject+"~rScript: "+ErrorScript+"~rLine: "+String(ErrorLine))
end event

