HA$PBExportHeader$uo_ge514_comum_vmpay.sru
forward
global type uo_ge514_comum_vmpay from uo_ge516_comum_ecommerce
end type
end forward

global type uo_ge514_comum_vmpay from uo_ge516_comum_ecommerce
end type
global uo_ge514_comum_vmpay uo_ge514_comum_vmpay

forward prototypes
public function boolean of_comunicacao_api_url (ref string ps_url, ref string ps_log)
public function boolean of_comunicacao_api_configurar (ref string ps_log)
end prototypes

public function boolean of_comunicacao_api_url (ref string ps_url, ref string ps_log);ps_url = ps_url + '?access_token=' + is_token

if is_parametros_url <> '' and not isnull(is_parametros_url) then
	ps_url += is_parametros_url
end if

return true
end function

public function boolean of_comunicacao_api_configurar (ref string ps_log);iole_SrvHTTP.SetRequestHeader("content-type", "application/json")

return true
end function

on uo_ge514_comum_vmpay.create
call super::create
end on

on uo_ge514_comum_vmpay.destroy
call super::destroy
end on

