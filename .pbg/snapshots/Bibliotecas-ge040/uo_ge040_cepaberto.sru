HA$PBExportHeader$uo_ge040_cepaberto.sru
$PBExportComments$Userobject to perform network Ping
forward
global type uo_ge040_cepaberto from nonvisualobject
end type
end forward

global type uo_ge040_cepaberto from nonvisualobject
end type
global uo_ge040_cepaberto uo_ge040_cepaberto

type variables
String	is_ibge,&
		is_nm_cidade,&
		is_ddd,&
		is_uf,&
		is_altitude,&
		is_longitude,&
		is_latitude,&
		is_bairro,&
		is_complemento, &
		is_cep,&
		is_logradouro

uo_ge073_json	io_Json

uo_internetresult result

Boolean ib_cep_unico

String	is_Jason_Elegibilidade,&
		is_Jason_Cadastro,&
		is_Jason_Retorno_Cadastro
		
String	is_Url_Producao,&
		is_Url_Homologacao
		
String is_token_site = 'faea10add5aff6994492dd10a73759e5'  
//token usado para fazer a consulta no site cepaberto.com
//dados do cadastro no site
//admocir.silva@clamed.com.br
//senha: clamed171819
		

end variables

forward prototypes
public function boolean of_dados_cep (string as_cep, ref string as_retorno, ref string as_erro)
private function boolean of_processa_retorno (string as_json, ref string as_erro)
public function boolean of_envia_solicitacao (string as_metodo, string as_url, string as_json_envio, string as_parametros, boolean ab_utiliza_parametros, ref string as_json_retorno, ref string as_erro)
public subroutine of_inicializa ()
end prototypes

public function boolean of_dados_cep (string as_cep, ref string as_retorno, ref string as_erro);String	ls_Url,&
		ls_json_retorno
		
Boolean	lb_Sucesso	= False

Try
	Open(w_Aguarde)
	w_Aguarde.Title = "Buscando informa$$HEX2$$e700f500$$ENDHEX$$es do CEP..."
	w_Aguarde.uo_Progress.of_SetMax(2)
	w_Aguarde.uo_Progress.of_SetProgress(1)

	Try
		This.of_inicializa( )
		//89202350
		//69350000
		
		ls_Url	= is_Url_Producao + "cep?cep="+as_cep
		
		If This.of_Envia_solicitacao("GET", ls_Url, "", "", False, Ref ls_Json_Retorno, Ref as_Erro) Then
			
			is_Jason_Elegibilidade	= ls_Json_Retorno
			
			If This.of_Processa_Retorno(ls_Json_Retorno,  Ref as_Erro) Then
				lb_Sucesso = True
			End If
		End If
		
	Catch (RuntimeError rte)
		as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_avalia_elegibilidade, objeto uo_rl152_cadastro_unico_funcional. Erro: " + rte.getMessage()
		Return False
	End Try
Finally
	Close(W_Aguarde)
End Try

Return lb_Sucesso
end function

private function boolean of_processa_retorno (string as_json, ref string as_erro);
//{"cidade": {"ibge": "3550308", "nome": "S$$HEX1$$e300$$ENDHEX$$o Paulo", "ddd": 11}, "estado": {"sigla": "SP"}, "altitude": 760.0, "longitude": "-46.636", "bairro": "S$$HEX1$$e900$$ENDHEX$$", "complemento": "- lado $$HEX1$$ed00$$ENDHEX$$mpar", "cep": "01001000", "logradouro": "Pra$$HEX1$$e700$$ENDHEX$$a da S$$HEX1$$e900$$ENDHEX$$", "latitude": "-23.5479099981"}


String	ls_Parte_Json,&
		ls_Parte_Erro,&
		ls_Valido,&
		ls_Json_Campo,&
		ls_Entidade,&
		ls_Campo,&
		ls_Exibicao,&
		ls_Existe_Produto_Programa,&
		ls_Json_Temp,&
		ls_Parte_Patologia,&
		ls_Campos_Beneficiario
		
Long	ll_Index,&
		ll_Linha_Patologia

Try
	as_Erro = ""	
	
//	ls_Valido = Upper(io_Json.of_busca_conteudo_campo(as_Json, 'IsValid'))
//	
//	If ls_Valido = "TRUE" Then		
		
		is_uf				= Upper(io_Json.of_busca_conteudo_campo(as_Json, 'sigla'))
		is_altitude		= Upper(io_Json.of_busca_conteudo_campo(as_Json, 'altitude'))
		is_longitude		= Upper(io_Json.of_busca_conteudo_campo(as_Json, 'longitude'))
		is_latitude		= Upper(io_Json.of_busca_conteudo_campo(as_Json, 'latitude'))
		is_cep			= Upper(io_Json.of_busca_conteudo_campo(as_Json, 'cep'))
		If  PosA( as_Json , 'bairro', 1 ) > 0 Then //Sem informacao de bairro indica que $$HEX1$$e900$$ENDHEX$$ cep unico por cidade.
			is_bairro			= Upper(io_Json.of_busca_conteudo_campo(as_Json, 'bairro'))
			is_complemento= Upper(io_Json.of_busca_conteudo_campo(as_Json, 'complemento'))
			is_logradouro	= Upper(io_Json.of_busca_conteudo_campo(as_Json, 'logradouro'))
			ib_cep_unico = True
		End If
		io_Json.of_divide_grupo_json_tag(as_Json, 'cidade', Ref ls_Parte_Json,'},')
		is_nm_cidade	= Upper(io_Json.of_busca_conteudo_campo(ls_Parte_Json, 'nome'))
		is_ibge			= Upper(io_Json.of_busca_conteudo_campo(ls_Parte_Json, 'ibge'))
		is_ddd			= Upper(io_Json.of_busca_conteudo_campo(ls_Parte_Json, 'ddd'))			
		
//	End If
		
//		//Verifica a Origem
//		ls_Json_Temp = as_json
//		io_Json.of_divide_grupo_json_tag(ls_Json_Temp, 'OrigensPermitidas', Ref ls_Parte_Json,']')
//		If Pos(ls_Parte_Json, "5") < 1 Then
//			as_Erro = "O cadastro desse produto n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido a partir de um PDV."
//			Return False
//		End If
//
//		//Benefici$$HEX1$$e100$$ENDHEX$$rio
//		If ls_Campos_Beneficiario <> "" Then
//			ls_Json_Temp = as_json
//			io_Json.of_divide_grupo_json_tag(ls_Json_Temp, 'CamposBeneficiario', Ref ls_Parte_Json,'],')
//		
//			Do While io_Json.of_divide_grupo_json_completo(ls_Parte_Json, Ref ls_Json_Campo,'{')
//				ls_Exibicao =  io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Exibicao')
//				
//				If ls_Exibicao = "3" Then
//					ll_Index = UpperBound(ast_Elegibilidade) + 1
//					
//					ast_Elegibilidade[ll_Index].id_entidade	= io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Entidade')
//					ast_Elegibilidade[ll_Index].de_campo		= io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Campo')
//				End If
//			Loop
//		End If
//		
//		//Paciente
//		ls_Json_Temp = as_json
//		io_Json.of_divide_grupo_json_tag(ls_Json_Temp, 'CamposPaciente', Ref ls_Parte_Json,'],')
//	
//		Do While io_Json.of_divide_grupo_json_completo(ls_Parte_Json, Ref ls_Json_Campo,'{')
//			ls_Exibicao =  io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Exibicao')
//			
//			If ls_Exibicao = "3" Then
//				ll_Index = UpperBound(ast_Elegibilidade) + 1
//				
//				ast_Elegibilidade[ll_Index].id_entidade	= io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Entidade')
//				ast_Elegibilidade[ll_Index].de_campo		= io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Campo')
//			End If
//		Loop
//		
//		//Produto
//		ls_Json_Temp = as_json
//		io_Json.of_divide_grupo_json_tag(ls_Json_Temp, 'CamposProduto', Ref ls_Parte_Json,'],')
//	
//		Do While io_Json.of_divide_grupo_json_completo(ls_Parte_Json, Ref ls_Json_Campo,'{')
//			ls_Exibicao =  io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Exibicao')
//			
//			If ls_Exibicao = "3" Then
//				ll_Index = UpperBound(ast_Elegibilidade) + 1
//				
//				ast_Elegibilidade[ll_Index].id_entidade	= io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Entidade')
//				ast_Elegibilidade[ll_Index].de_campo		= io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Campo')
//				
//				If Upper(ast_Elegibilidade[ll_Index].de_campo) = "CODIGOPATOLOGIA" Then
//					
//					ist_Patologia[] = lst_Patologia_Clear
//						
//					ls_Parte_Patologia	= ls_Json_Campo
//					
//					Do While io_Json.of_divide_grupo_json_completo(ls_Parte_Patologia, Ref ls_Json_Campo,'{')
//					 	ll_Linha_Patologia	= UpperBound(ist_Patologia) + 1
//						 
//						ist_Patologia[ll_Linha_Patologia].texto	= io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Texto')
//						ist_Patologia[ll_Linha_Patologia].valor	= io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Valor')
//					Loop
//				End If
//			End If
//		Loop
//		
//		//Pacientes j$$HEX1$$e100$$ENDHEX$$ cadastrados
//		ist_Pacientes[] = lst_Pacientes_Clear
//		
//		ls_Json_Temp = as_json
//		io_Json.of_divide_grupo_json_tag(ls_Json_Temp, 'Pacientes', Ref ls_Parte_Json,']')
//	
//		Do While io_Json.of_divide_grupo_json_completo(ls_Parte_Json, Ref ls_Json_Campo,'{')
//			ll_Index = UpperBound(ist_Pacientes) + 1
//			
//			ist_Pacientes[ll_Index].codigopaciente	= io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'CodigoPaciente')
//			ist_Pacientes[ll_Index].nome				= Upper(io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Nome'))
//			ist_Pacientes[ll_Index].nascimento			= Date(io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Nascimento'))
//			ist_Pacientes[ll_Index].sexo					= Upper(io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Sexo'))
//			ist_Pacientes[ll_Index].titular				= Upper(io_Json.of_busca_conteudo_campo(ls_Json_Campo, 'Titular'))
//		Loop
//		
//	Else
//		
//		io_Json.of_divide_grupo_json_tag(as_Json, 'Errors', Ref ls_Parte_Json,']')
//		
//		Do While io_Json.of_divide_grupo_json_completo(ls_Parte_Json, Ref ls_Parte_Erro,'{')
//			 If as_Erro = "" Then
//				as_Erro	= io_Json.of_busca_conteudo_campo(ls_Parte_Erro, 'StatusCode')
//				as_Erro	= as_Erro +" - "+io_Json.of_busca_conteudo_campo(ls_Parte_Erro, 'Message')+" "
//			Else
//				as_Erro	= as_Erro +"~r~n"+ io_Json.of_busca_conteudo_campo(ls_Parte_Erro, 'StatusCode')
//				as_Erro	= as_Erro +" - "+ io_Json.of_busca_conteudo_campo(ls_Parte_Erro, 'Message')+" "
//			End If
//		Loop
//		
//		Return False
//		
//	End If

Catch (RuntimeError rte)
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_avalia_elegibilidade_processa_retorno, objeto uo_rl152_cadastro_unico_funcional. Erro: " + rte.getMessage()
	Return False
End Try

Return True
end function

public function boolean of_envia_solicitacao (string as_metodo, string as_url, string as_json_envio, string as_parametros, boolean ab_utiliza_parametros, ref string as_json_retorno, ref string as_erro);String		ls_Status_Text

long   ll_Status_Code

OleObject	lo_Http,&
				lo_Send

Try

	Try
//		lo_Send	= CREATE oleobject
//		lo_Http	= CREATE oleobject
//		
//		lo_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")
//		lo_Http.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
//		
//		lo_Http.open (as_Metodo, as_Url, False)
//		
//		lo_Http.SetRequestHeader( "Content-Type", "application/json")
//				
//		lo_Http.SetRequestHeader("Authorization", "Token token=" + is_token_site) 
//				
//		If as_Metodo = "POST" Then
//			lo_Http.send(as_Json_Envio)
//		Else
//			lo_Http.send(lo_Send)
//		End If

		lo_Http = CREATE oleobject
		lo_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
		
		lo_Http.open (as_Metodo, as_Url, False)
		
		lo_Http.SetTimeOuts(5000,5000,30000,120000)
		lo_Http.SetAutomationTimeout(120000)
		
		lo_Http.SetRequestHeader( "Content-Type", "application/json")
		lo_Http.SetRequestHeader("Authorization", "Token token=" + is_token_site) 
				
		If as_Metodo = "POST" Then
			lo_Http.send(as_Json_Envio)
		Else
			lo_Http.send(lo_Send)
		End If
		
		//Pega a resposta do web service
		ls_Status_Text = lo_Http.StatusText
		ll_Status_Code = lo_Http.Status
	
		If ll_Status_Code > 200 Then
			as_Erro = "Erro no retorno do Web Service.~r~nC$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ "~r~nDescri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
			Return False
		Else
		//Pega o retorno do web service
			as_Json_Retorno = lo_Http.ResponseText
		End If
	Finally
		//Disconecta
		lo_Http.DisconnectObject()
		
		Destroy(lo_Http)
		Destroy(lo_Send)
	End Try

Catch (RuntimeError rte)
	as_Erro = "Ocorreu erro ao enviar o arquivo para o Web Service. Erro: " + rte.getMessage()
	Return False
End Try

Return True
end function

public subroutine of_inicializa ();SetNull(is_ibge)
SetNull(is_nm_cidade)
SetNull(is_ddd)
SetNull(is_uf)
SetNull(is_altitude)
SetNull(is_longitude)
SetNull(is_latitude)
SetNull(is_bairro)
SetNull(is_complemento)
SetNull(is_cep)
SetNull(is_logradouro)

ib_cep_unico = false
end subroutine

on uo_ge040_cepaberto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge040_cepaberto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Json = Create uo_ge073_json

is_Url_Producao		= "https://www.cepaberto.com/api/v3/"

end event

event destructor;Destroy(io_Json)
end event

