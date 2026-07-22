HA$PBExportHeader$uo_ge501_correios.sru
forward
global type uo_ge501_correios from nonvisualobject
end type
end forward

global type uo_ge501_correios from nonvisualobject
end type
global uo_ge501_correios uo_ge501_correios

type variables
string is_objeto
string is_usuario = '8468348100'
string is_senha = 'LVGTOHQ24A'
string is_usuario_cws = 'clamedfarma'
string is_senha_cws = 'xLLL4gUuzQhAbJjCjkERVcJR9TM7VGkPfrPamspH'
string is_url[] = { 'https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl', + &
						'https://apps3.correios.com.br/areletronico/v1/ars/eventos' }

OleObject iole_xml

dc_uo_ds_base ids_rastreio
end variables

forward prototypes
public function boolean of_consulta_cep (string ps_cep, ref boolean pb_valido, ref string ps_log)
public function boolean of_envia_webservice (integer pi_tipo_envio, string ps_xml, ref string ps_retorno, ref string ps_log)
public function boolean of_consulta_rastreio (string ps_objeto, ref string ps_rastreio, ref string ps_log)
public function boolean of_pedido_processa_rastreio (long pl_cd_filial, long pl_nr_pedido, ref string ps_log)
public function boolean of_xml_carregar (string ps_xml, ref string ps_log)
public function boolean of_xml_get (string ps_campo, ref string ps_retorno, ref string ps_log)
public function boolean of_pedido_grava_rastreio (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, string ps_rastreio, ref boolean pb_novo_rastreio, ref string ps_log)
end prototypes

public function boolean of_consulta_cep (string ps_cep, ref boolean pb_valido, ref string ps_log);string ls_retorno
string ls_xml 
string ls_cep_retorno
//oleobject lole_node

Try
	
	ls_xml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cli="http://cliente.bean.master.sigep.bsb.correios.com.br/">' + &
	'   <soapenv:Header/>' + &
	'   <soapenv:Body>' + &
	'      <cli:consultaCEP> ' + &
	'         <cep>' + ps_cep + '</cep>' + &
	'      </cli:consultaCEP>' + &
	'   </soapenv:Body>' + &
	'</soapenv:Envelope>' 
	
	if Not this.of_envia_webservice(1, ls_xml, ref ls_retorno, ref ps_log) then return false

	if ls_retorno = '' or isnull(ls_retorno) Then
		
		pb_valido = false
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel validar o cep [' + ps_cep + '].'
	ELse
		
		if Not this.of_xml_carregar( ls_retorno, ref ps_log ) then return false
		
		oleobject lole_node 
				
		lole_node = iole_xml.SelectSingleNode('//return/cep')
		
		ls_cep_retorno = String (lole_node.text)
		if ls_cep_retorno = ps_cep Then
			pb_valido = true
		else
			pb_valido = false
			ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel validar o cep [' + ps_cep + '].'
		End if
		
	End if

CATCH (runtimeerror er)   
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel validar o CEP [' + ps_cep + ']: ' + er.GetMessage()
	pb_valido = false
	return false
Finally
	if isvalid(lole_node) then destroy(lole_node)
	
End Try

return true
end function

public function boolean of_envia_webservice (integer pi_tipo_envio, string ps_xml, ref string ps_retorno, ref string ps_log);

Try
	
	Long ll_status_code
	String ls_status_text
	string ls_xml, ls_tipo
		
	OleObject lole_SrvHTTP, lole_retorno	
		
	IF Not IsValid(lole_SrvHTTP) THEN
		
		lole_SrvHTTP = CREATE oleobject
		lole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		
	End If
	
	IF Not IsValid(lole_retorno) THEN
		lole_retorno = CREATE oleobject
		lole_retorno.ConnectToNewObject("Msxml2.DOMDocument.6.0")
	End if
	
	Choose Case pi_tipo_envio
		Case 1
			lole_SrvHTTP.open ('POST', is_url[pi_tipo_envio] , false, is_usuario, is_senha) 
			ls_tipo = "text/xml"
			
		Case 2 //Rastreio - Correios Web Service
			lole_SrvHTTP.open ('POST', is_url[pi_tipo_envio] , false, this.is_usuario_cws, this.is_senha_cws )
			ls_tipo = "application/json"
			
		Case ELse
			ls_tipo = "text/xml"
			lole_SrvHTTP.open ('POST', is_url[pi_tipo_envio] , false )
	End Choose
	
	if Not IsValid(lole_SrvHTTP) THEN Return false
	
	lole_SrvHTTP.setRequestHeader("Content-Type", ls_tipo) 
	
	lole_SrvHTTP.send(ps_xml) 
		
	//Get response 
	ls_status_text = lole_SrvHTTP.StatusText 
	ll_status_code = lole_SrvHTTP.Status 
	
	ps_retorno = String( lole_SrvHTTP.ResponseText )
	
	if pi_tipo_envio = 1 then
		if Not lole_retorno.loadXML(ps_retorno) then
			ps_log = string(lole_retorno.parseError.reason) 
			return false
		end if

		lole_retorno.async = false
	ENd if
	
	Choose Case ll_status_code
		
		Case 200
			//Tudo certo
			ps_log = ''
		
		Case 500
			//Erro - Tratamento de erro
			
			if pi_tipo_envio = 1 Then //Consulta CEP
		
				oleobject lole_node 
				
				lole_node = lole_retorno.SelectSingleNode('//faultstring')
				
				ps_log = String (lole_node.text)
				
			Elseif pi_tipo_envio = 2 Then //Rastreio
				
				ps_log = ps_retorno
			ENd if
			
			ps_retorno = ''
			
		Case Else
			
			ps_retorno = ''
			ps_log = ls_status_text
			return false
			
	End Choose
	
CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false
	
Finally
	
	
ENd Try


return true
end function

public function boolean of_consulta_rastreio (string ps_objeto, ref string ps_rastreio, ref string ps_log);string ls_json
string ls_objeto

Try

	//https://apps3.correios.com.br/areletronico/v1/ars/eventos

	ls_json = '{"objetos": [" ' + ps_objeto + '"]}'

	if Not this.of_envia_webservice(2, ls_json, ref ps_rastreio, ref ps_log ) then return false

CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false
End Try

return true
end function

public function boolean of_pedido_processa_rastreio (long pl_cd_filial, long pl_nr_pedido, ref string ps_log);string ls_objeto
string ls_rastreio

long ll_linhas, ll_for
long ll_nr_sequencial
boolean lb_sucesso
boolean lb_novo_rastreio = false

dc_uo_ds_base lds_entrega

oleobject lole_node 

Try

	lds_entrega = create dc_uo_ds_base
	
	lds_entrega.of_changedataobject( 'ds_ge501_pedido_ecommerce_entrega' )
	
	ll_linhas = lds_entrega.retrieve( pl_cd_filial, pl_nr_pedido )
	
	for ll_for = 1 to ll_linhas
		
		ll_nr_sequencial = lds_entrega.getitemNumber(ll_for, 'nr_sequencial')
		ls_objeto = lds_entrega.getitemString(ll_for, 'de_objeto')
		
		if Not this.of_consulta_rastreio( ls_objeto, ref ls_rastreio, ref ps_log ) then return false
		
		if not this.of_pedido_grava_rastreio( pl_cd_filial, pl_nr_pedido, ll_nr_sequencial, ls_rastreio, ref lb_novo_rastreio, ref ps_log ) then return false
		
		if lb_novo_rastreio = True Then
			
			Update pedido_ecommerce_entrega
			set id_comunicacao_pendente = 'S'
			where cd_filial_ecommerce = :pl_cd_filial
				and nr_pedido = :pl_nr_pedido
				and nr_sequencial = :ll_nr_sequencial;
				
			if sqlca.sqlcode = -1 then
				ps_log = 'Problemas ao inserir registro na tabela pedido_ecommerce_entrega_rast: ' + sqlca.sqlerrtext
				return false
			ENd if
				
		End if
		
	next

	lb_sucesso = True
	
CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false
	
Finally 
	
	if lb_sucesso = True then
		Sqlca.of_commit()
	ELse
		sqlca.of_rollback( )
	ENd if
End Try

return true
end function

public function boolean of_xml_carregar (string ps_xml, ref string ps_log);Try
	
	IF Not IsValid(iole_xml) THEN
		iole_xml = CREATE oleobject
		iole_xml.ConnectToNewObject("Msxml2.DOMDocument.6.0")
	End if
	
	if Not iole_xml.loadXML(ps_xml) then
		ps_log = string(iole_xml.parseError.reason) 
		return false
	end if
	
	iole_xml.async = false
	
CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false
End Try

return true
end function

public function boolean of_xml_get (string ps_campo, ref string ps_retorno, ref string ps_log);string ls_teste1, ls_teste2
long ll_total, ll_for

String ls_tipo, ls_status, ls_data, ls_hora, ls_descricao, ls_local, ls_cidade, ls_uf

Try
	
	oleobject lole_node, lole_tipo, lole_status, lole_data, lole_hora, lole_descricao, lole_local, lole_cidade, lole_uf
				
	//lole_node = iole_xml.SelectSingleNode('//' + ps_campo )
	lole_node = iole_xml.documentElement.SelectNodes('//' + ps_campo )
	
//	lole_tipo = iole_xml.getElementsByTagName('tipo')
//	lole_status = iole_xml.getElementsByTagName('status')
//	lole_data = iole_xml.getElementsByTagName('data')
//	lole_hora = iole_xml.getElementsByTagName('hora')
//	lole_descricao = iole_xml.getElementsByTagName('descricao')
//	lole_local = iole_xml.getElementsByTagName('local')
//	lole_cidade = iole_xml.getElementsByTagName('cidade')
//	lole_uf = iole_xml.getElementsByTagName('uf')
	
	ll_total = long(lole_node.length) - 1
	
	for ll_for = 0 to ll_total
		
		ls_tipo = String(lole_node.item(ll_for).childNodes.item(0).text)
		ls_status = String(lole_node.item(ll_for).childNodes.item(1).text)
		ls_data = String(lole_node.item(ll_for).childNodes.item(2).text)
		ls_hora = String(lole_node.item(ll_for).childNodes.item(3).text)
		ls_descricao = String(lole_node.item(ll_for).childNodes.item(4).text)
		ls_local = String(lole_node.item(ll_for).childNodes.item(5).text)
		ls_cidade = String(lole_node.item(ll_for).childNodes.item(7).text)
		ls_uf = String(lole_node.item(ll_for).childNodes.item(8).text)

	next
	
CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false
Finally
	if isvalid(lole_node) then destroy(lole_node)
End Try

return true
end function

public function boolean of_pedido_grava_rastreio (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, string ps_rastreio, ref boolean pb_novo_rastreio, ref string ps_log);string ls_retorno
string ls_info_rastreio

String ls_tipo, ls_status, ls_data, ls_descricao, ls_local, ls_cidade, ls_uf
long ll_total, ll_for, ll_for2, ll_total2
long ll_nr_sequencial
long ll_existe

datetime ldh_status
boolean lb_sucesso= false

uo_ge073_json luo_json

Try
	
	luo_json = create uo_ge073_json
	
	luo_json.of_divide_grupo_json_tag_vtex(ref ps_rastreio, 'eventos', ref ls_info_rastreio, '"tipo"')
	
	Do While luo_json.of_divide_grupo_json_completo(Ref ls_info_rastreio, Ref ls_retorno,'{')
	
	
		ls_tipo = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'tipoEvento')
		ls_status = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'statusEvento')
		ls_descricao = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'descricaoEvento')
		ls_data = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'dataEvento')
		ls_local = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'nomeUnidade')
		ls_cidade = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'municipio')
		ls_uf = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'uf')
	
		ldh_status = Datetime( ls_data )
		
		if len(ls_status) = 1 then ls_status = '0' + ls_status
		
		ll_existe = 0
		
		select count(*)
		into :ll_existe
		from pedido_ecommerce_entrega_rast
		where cd_filial_ecommerce = :pl_cd_filial
			and nr_pedido = :pl_nr_pedido
			and nr_sequencial = :pl_nr_sequencial
			and dh_status = :ldh_status
			and id_tipo_status = :ls_tipo
			and cd_status = :ls_status;
			
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao consultar a tabela pedido_ecommerce_entrega_rast: ' + sqlca.sqlerrtext
			return false
		ENd if	
		
		if isnull(ll_existe) then ll_existe = 0
		
		if ll_existe > 0 Then Continue
		
		Select max(nr_sequencial_rast)
		into :ll_nr_sequencial
		from pedido_ecommerce_entrega_rast
		where cd_filial_ecommerce = :pl_cd_filial
			and nr_pedido = :pl_nr_pedido
			and nr_sequencial = :pl_nr_sequencial;
			
		if ll_nr_sequencial = 0 or isnull(ll_nr_sequencial) Then
			ll_nr_sequencial = 1
		Else
			ll_nr_sequencial++
		ENd if
		
		insert into pedido_ecommerce_entrega_rast (cd_filial_ecommerce, 
																	nr_pedido, 
																	nr_sequencial, 
																	nr_sequencial_rast,
																	id_tipo_status, 
																	cd_status, 
																	de_status,
																	dh_status,
																	dh_inclusao,
																	de_local,
																	cd_uf,
																	de_cidade)
			Values (:pl_cd_filial,
						:pl_nr_pedido,
						:pl_nr_sequencial,
						:ll_nr_sequencial,
						:ls_tipo,
						:ls_status,
						:ls_descricao,
						:ldh_status,
						getdate(),
						:ls_local,
						:ls_uf,
						:ls_cidade);
						

			if sqlca.sqlcode = -1 then
				ps_log = 'Problemas ao inserir registro na tabela pedido_ecommerce_entrega_rast: ' + sqlca.sqlerrtext
				return false
			ENd if
			
			pb_novo_rastreio = True
			
	Loop
	
	lb_sucesso = true
	
CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false 
Finally
	
End Try

return true
end function

on uo_ge501_correios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_correios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname( )
end event

event destructor;IF IsValid(iole_xml) THEN 
	iole_xml.DisconnectObject()
	Destroy iole_xml 
end if
end event

