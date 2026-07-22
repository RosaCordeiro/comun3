HA$PBExportHeader$uo_ge509_comum_consulta_remedio.sru
forward
global type uo_ge509_comum_consulta_remedio from uo_ge516_comum_ecommerce
end type
end forward

global type uo_ge509_comum_consulta_remedio from uo_ge516_comum_ecommerce
end type
global uo_ge509_comum_consulta_remedio uo_ge509_comum_consulta_remedio

type variables
string is_senha
end variables

forward prototypes
public function boolean of_comunicacao_api_configurar (ref string ps_log)
public function boolean of_gerar_token (ref string ps_log)
end prototypes

public function boolean of_comunicacao_api_configurar (ref string ps_log);if is_id_ecommerce <> '6' Then
	iole_SrvHTTP.SetRequestHeader("content-type", "application/json")
ENd if

Choose Case is_id_ecommerce
	Case '5'
		iole_SrvHTTP.SetRequestHeader("Authorization", this.is_token )
	Case '6'
		
		if this.is_token <> '' and not isnull(this.is_token) then
			iole_SrvHTTP.SetRequestHeader("content-type", "application/json")
			iole_SrvHTTP.SetRequestHeader("Authorization",'bearer ' + this.is_token )
		Else
			iole_SrvHTTP.SetRequestHeader("content-type", "application/x-www-form-urlencoded")
		ENd if
		
End Choose

return true
end function

public function boolean of_gerar_token (ref string ps_log);string ls_json
string ls_id_interface
string ls_retorno
uo_ge073_json luo_json

luo_json = create uo_ge073_json

is_senha = is_token
setnull(is_token)

ls_id_interface = '/oauth2/token'

ls_json = 'grant_type=client_credentials'
ls_json += '&scope=partner_all'
ls_json += '&client_id=' + is_chave
ls_json += '&client_secret=' + is_senha
			 
Try			 

	this.ib_utiliza_retorno= true

	If Not this.of_post( ls_json, ls_id_interface, ref ls_retorno, ref ps_log ) Then return false

	if ps_log <> '' and not isnull(ps_log) Then return false
	
	//access_token
	is_token = luo_json.of_busca_conteudo_campo( ls_retorno, 'access_token')

Finally

		this.ib_utiliza_retorno= false

	destroy(luo_json)

End Try

return true
end function

on uo_ge509_comum_consulta_remedio.create
call super::create
end on

on uo_ge509_comum_consulta_remedio.destroy
call super::destroy
end on

