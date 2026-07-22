HA$PBExportHeader$uo_ge673_kafka.sru
forward
global type uo_ge673_kafka from nonvisualobject
end type
end forward

global type uo_ge673_kafka from nonvisualobject
end type
global uo_ge673_kafka uo_ge673_kafka

type variables
PRIVATE:
	String is_topico_controle_tarefas
	String	is_url_proxy_rest_kafka
	String is_user_proxy_rest_kafka
	String is_pass_proxy_rest_kafka
	String is_btoken_proxy_rest_kafka
	String is_modelo_auth_proxy_rest_kafka
	String is_cluster_proxy_rest_kafka
	CONSTANT Long il_proxy_default = 1
	CONSTANT Long il_kafka_timeout = 60000
	CONSTANT String is_param_topico_controle_tarefas = 'TOPICO_KAFKA_CONTROLE_TAREFAS'
end variables

forward prototypes
public function boolean uf_send (string as_topico, string as_json, ref string as_erro)
public function boolean of_load_topico_controle_tarefas ()
public function string of_get_topico_controle_tarefas ()
public function boolean of_inicia (long al_proxy)
end prototypes

public function boolean uf_send (string as_topico, string as_json, ref string as_erro);Any 	la_Code
Long   ll_status_code
String ls_status_text, ls_body, ls_url, ls_retorno, ls_status_code

OleObject lo_http

Try
	Try
		ls_url = is_url_proxy_rest_kafka
		
		ls_body = '{ "value": {"type": "JSON","data": ' + as_json + '}}'
		
		lo_http = CREATE oleobject        
		la_Code = lo_http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
		
		If la_Code = 0 Then
			Choose Case is_modelo_auth_proxy_rest_kafka
				Case 'USERPASS'
					lo_http.open ("POST", ls_url, False, is_user_proxy_rest_kafka, is_pass_proxy_rest_kafka)
				Case 'BEARERTOKEN'
					lo_http.open ("POST", ls_url, False)
					
					lo_http.setRequestHeader("Authorization", is_btoken_proxy_rest_kafka) 
			End Choose
			
			lo_http.SetTimeouts(5000,5000,30000,il_kafka_timeout)
			lo_http.SetAutomationTimeout(il_kafka_timeout)
			lo_http.setRequestHeader("Content-Type", "application/json") 
			lo_http.setOption(2, 13056)
			
			lo_http.send(ls_body)    
			
			ls_status_text = lo_http.StatusText
			ll_status_code = lo_http.Status        
			ls_retorno = String(lo_http.ResponseText)
			
			IF ll_status_code >= 300 OR ll_status_code = 0 THEN
				as_erro = "Erro Kafka REST. C$$HEX1$$f300$$ENDHEX$$digo: " + String(ll_status_code) + &
				 " Descri$$HEX2$$e700e300$$ENDHEX$$o: " + ls_status_text + &
				 " Retorno: " + ls_retorno
				RETURN FALSE
			END IF
		Else
			as_Erro = "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o do novo objeto de conex$$HEX1$$e300$$ENDHEX$$o Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(la_Code)
			Return False
		End If
	Catch (RuntimeError lo_rte2)
		ls_status_text = lo_http.StatusText
		ls_status_code = String(lo_http.Status)
		ls_retorno = String(lo_http.ResponseText)
		
		as_erro = "Erro ao enviar para Kafka: " + lo_rte2.GetMessage()
		
		If Trim(ls_status_text) <> '' and not IsNull(ls_status_text) then as_erro = as_erro + '~r~rStatusText: ' + ls_status_text
		If Trim(ls_status_code) <> '' and not IsNull(ls_status_code) then as_erro = as_erro + '~r~rStatusCode: ' + ls_status_code
		If Trim(ls_retorno) <> '' and not IsNull(ls_retorno) then as_erro = as_erro + '~r~rResponseText: ' + ls_retorno
		
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', as_erro)
		RETURN FALSE
	Finally
		lo_http.DisconnectObject()
		GarbageCollect()
		Destroy(lo_http)
	End Try
Catch (RuntimeError lo_rte)
	as_erro = "Erro geral Kafka: " + lo_rte.GetMessage()
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', as_erro)
	RETURN FALSE
End Try

RETURN TRUE
end function

public function boolean of_load_topico_controle_tarefas ();String	ls_param


ls_param = is_param_topico_controle_tarefas

SELECT
	vl_parametro
INTO 
	:is_topico_controle_tarefas
FROM 
	parametro_geral
WHERE
	cd_parametro = :ls_param;
	
Choose Case SQLCA.SQLCode
	Case -1, 100
		//SEM LOG
		Return False
	Case 0
		If IsNull(is_topico_controle_tarefas) or Trim(is_topico_controle_tarefas) = '' then
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro nulo ou vazio: ' + ls_param, StopSign!)
			RETURN FALSE
		end if
End Choose

Return True
end function

public function string of_get_topico_controle_tarefas ();Return is_topico_controle_tarefas
end function

public function boolean of_inicia (long al_proxy);String ls_url_proxy_rest_kafka_param, ls_user_proxy_rest_kafka_param, ls_pass_proxy_rest_kafka_param, ls_erro, &
	ls_btokenp1_proxy_rest_kafka_param, ls_btokenp2_proxy_rest_kafka_param, ls_btokenp3_proxy_rest_kafka_param, &
	ls_btokenp1_proxy_rest_kafka, ls_btokenp2_proxy_rest_kafka, ls_btokenp3_proxy_rest_kafka, &
	ls_modelo_auth_proxy_rest_kafka_param, ls_custer_proxy_rest_kafka_param


of_load_topico_controle_tarefas()
	
if IsNull(al_proxy) or al_proxy <= 0 then
	al_proxy = il_proxy_default
end if

IF al_proxy > 0 THEN
	ls_url_proxy_rest_kafka_param  = 'URL_PROXY_REST_KAFKA_'  + String(al_proxy)
	ls_user_proxy_rest_kafka_param = 'USER_PROXY_REST_KAFKA_' + String(al_proxy)
	ls_pass_proxy_rest_kafka_param = 'PASS_PROXY_REST_KAFKA_' + String(al_proxy)
	ls_btokenp1_proxy_rest_kafka_param	= 'BTOKENP1_PROXY_REST_KAFKA_' + String(al_proxy)
	ls_btokenp2_proxy_rest_kafka_param	= 'BTOKENP2_PROXY_REST_KAFKA_' + String(al_proxy)
	ls_btokenp3_proxy_rest_kafka_param	= 'BTOKENP3_PROXY_REST_KAFKA_' + String(al_proxy)
	ls_modelo_auth_proxy_rest_kafka_param = 'MODELO_AUTH_PROXY_REST_KAFKA_' + String(al_proxy)
	ls_custer_proxy_rest_kafka_param	= 'CLUSTER_PROXY_REST_KAFKA_' + String(al_proxy)
	
	//MODELO
	SELECT
		vl_parametro
	INTO
		:is_modelo_auth_proxy_rest_kafka
	FROM
		parametro_geral
	WHERE
		cd_parametro = :ls_modelo_auth_proxy_rest_kafka_param;
	
	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			ls_erro = SQLCA.SQLErrText
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro: ' + ls_modelo_auth_proxy_rest_kafka_param + &
				'. ~r~rErro: ' + ls_erro, StopSign!)
		RETURN FALSE
		
		CASE 100
			ls_erro = SQLCA.SQLErrText
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + ls_modelo_auth_proxy_rest_kafka_param, StopSign!)
			RETURN FALSE
			
		CASE 0
			If IsNull(is_modelo_auth_proxy_rest_kafka) or Trim(is_modelo_auth_proxy_rest_kafka) = '' Then
				SQLCA.of_rollback()
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro nulo ou vazio: ' + ls_modelo_auth_proxy_rest_kafka_param, StopSign!)
				RETURN FALSE
			End If
	END CHOOSE
	
	//CLUSTER
	SELECT
		vl_parametro
	INTO
		:is_cluster_proxy_rest_kafka
	FROM
		parametro_geral
	WHERE
		cd_parametro = :ls_custer_proxy_rest_kafka_param;
	
	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			ls_erro = SQLCA.SQLErrText
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro: ' + ls_custer_proxy_rest_kafka_param + &
				'. ~r~rErro: ' + ls_erro, StopSign!)
		RETURN FALSE
		
		CASE 100
			ls_erro = SQLCA.SQLErrText
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + ls_custer_proxy_rest_kafka_param, StopSign!)
			RETURN FALSE
			
		CASE 0
			If IsNull(is_cluster_proxy_rest_kafka) or Trim(is_cluster_proxy_rest_kafka) = '' Then
				SQLCA.of_rollback()
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro nulo ou vazio: ' + ls_custer_proxy_rest_kafka_param, StopSign!)
				RETURN FALSE
			End If
	END CHOOSE
	
	//URL
	SELECT
		vl_parametro
	INTO
		:is_url_proxy_rest_kafka
	FROM
		parametro_geral
	WHERE
		cd_parametro = :ls_url_proxy_rest_kafka_param;
	
	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			ls_erro = SQLCA.SQLErrText
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro: ' + ls_url_proxy_rest_kafka_param + &
				'. ~r~rErro: ' + ls_erro, StopSign!)
		RETURN FALSE
		
		CASE 100
			ls_erro = SQLCA.SQLErrText
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + ls_url_proxy_rest_kafka_param, StopSign!)
			RETURN FALSE
			
		CASE 0
			If IsNull(is_url_proxy_rest_kafka) or Trim(is_url_proxy_rest_kafka) = '' Then
				SQLCA.of_rollback()
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro nulo ou vazio: ' + ls_url_proxy_rest_kafka_param, StopSign!)
				RETURN FALSE
			End If
			
			is_url_proxy_rest_kafka	+= '/v3/clusters/' + is_cluster_proxy_rest_kafka + '/topics/' + is_topico_controle_tarefas + '/records'		
	END CHOOSE
	
	Choose Case is_modelo_auth_proxy_rest_kafka 
		Case 'USERPASS'
			//USER
			SELECT
				vl_parametro
			INTO
				:is_user_proxy_rest_kafka
			FROM
				parametro_geral
			WHERE
				cd_parametro = :ls_user_proxy_rest_kafka_param;
			
			CHOOSE CASE SQLCA.SQLCode
				CASE -1
					ls_erro = SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro: ' + ls_user_proxy_rest_kafka_param + &
						'. ~r~rErro: ' + ls_erro, StopSign!)
				RETURN FALSE
				
				CASE 100
					ls_erro = SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + ls_user_proxy_rest_kafka_param, StopSign!)
					RETURN FALSE
					
				CASE 0
					If IsNull(is_user_proxy_rest_kafka) or Trim(is_user_proxy_rest_kafka) = '' Then
						SQLCA.of_rollback()
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro nulo ou vazio: ' + ls_user_proxy_rest_kafka_param, StopSign!)
						RETURN FALSE
					End If				
			END CHOOSE
			
			//PASSWORD
			SELECT
				vl_parametro
			INTO
				:is_pass_proxy_rest_kafka
			FROM
				parametro_geral
			WHERE
				cd_parametro = :ls_pass_proxy_rest_kafka_param;
			
			CHOOSE CASE SQLCA.SQLCode
				CASE -1
					ls_erro = SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro: ' + ls_pass_proxy_rest_kafka_param + &
						'. ~r~rErro: ' + ls_erro, StopSign!)
				RETURN FALSE
				
				CASE 100
					ls_erro = SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + ls_pass_proxy_rest_kafka_param, StopSign!)
					RETURN FALSE
					
				CASE 0
					If IsNull(is_pass_proxy_rest_kafka) or Trim(is_pass_proxy_rest_kafka) = '' Then
						SQLCA.of_rollback()
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro nulo ou vazio: ' + ls_pass_proxy_rest_kafka_param, StopSign!)
						RETURN FALSE
					End If	
			END CHOOSE
		Case 'BEARERTOKEN'
			//TOKEN
			SELECT
				vl_parametro
			INTO
				:ls_btokenp1_proxy_rest_kafka
			FROM
				parametro_geral
			WHERE
				cd_parametro = :ls_btokenp1_proxy_rest_kafka_param;
			
			CHOOSE CASE SQLCA.SQLCode
				CASE -1
					ls_erro = SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro: ' + ls_btokenp1_proxy_rest_kafka_param + &
						'. ~r~rErro: ' + ls_erro, StopSign!)
					RETURN FALSE
				
				CASE 100
					ls_erro = SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + ls_btokenp1_proxy_rest_kafka_param, StopSign!)
					RETURN FALSE
					
				CASE 0
					If IsNull(ls_btokenp1_proxy_rest_kafka) or Trim(ls_btokenp1_proxy_rest_kafka) = '' Then
						SQLCA.of_rollback()
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro nulo ou vazio: ' + ls_btokenp1_proxy_rest_kafka_param, StopSign!)
						RETURN FALSE
					End If	
			END CHOOSE
			
			SELECT
				vl_parametro
			INTO
				:ls_btokenp2_proxy_rest_kafka
			FROM
				parametro_geral
			WHERE
				cd_parametro = :ls_btokenp2_proxy_rest_kafka_param;
			
			CHOOSE CASE SQLCA.SQLCode
				CASE -1
					ls_erro = SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro: ' + ls_btokenp2_proxy_rest_kafka_param + &
						'. ~r~rErro: ' + ls_erro, StopSign!)
					RETURN FALSE
				
				CASE 100
					ls_erro = SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + ls_btokenp2_proxy_rest_kafka_param, StopSign!)
					RETURN FALSE
					
				CASE 0
					If IsNull(ls_btokenp2_proxy_rest_kafka) or Trim(ls_btokenp2_proxy_rest_kafka) = '' Then
						SQLCA.of_rollback()
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro nulo ou vazio: ' + ls_btokenp2_proxy_rest_kafka_param, StopSign!)
						RETURN FALSE
					End If	
			END CHOOSE
			
			SELECT
				vl_parametro
			INTO
				:ls_btokenp3_proxy_rest_kafka
			FROM
				parametro_geral
			WHERE
				cd_parametro = :ls_btokenp3_proxy_rest_kafka_param;
			
			CHOOSE CASE SQLCA.SQLCode
				CASE -1
					ls_erro = SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro: ' + ls_btokenp3_proxy_rest_kafka_param + &
						'. ~r~rErro: ' + ls_erro, StopSign!)
					RETURN FALSE
				
				CASE 100
					ls_erro = SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o encontrado: ' + ls_btokenp3_proxy_rest_kafka_param, StopSign!)
					RETURN FALSE
					
				CASE 0
					If IsNull(ls_btokenp3_proxy_rest_kafka) or Trim(ls_btokenp3_proxy_rest_kafka) = '' Then
						SQLCA.of_rollback()
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro nulo ou vazio: ' + ls_btokenp3_proxy_rest_kafka_param, StopSign!)
						RETURN FALSE
					End If	
			END CHOOSE
			
			is_btoken_proxy_rest_kafka	= 'Bearer ' + ls_btokenp1_proxy_rest_kafka + '.' + ls_btokenp2_proxy_rest_kafka + '.' + ls_btokenp3_proxy_rest_kafka
	end choose
ELSE
	// N$$HEX1$$e300$$ENDHEX$$o informado
	RETURN FALSE
END IF
end function

on uo_ge673_kafka.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge673_kafka.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

