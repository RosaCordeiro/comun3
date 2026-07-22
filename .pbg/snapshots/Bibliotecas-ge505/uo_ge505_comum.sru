HA$PBExportHeader$uo_ge505_comum.sru
forward
global type uo_ge505_comum from nonvisualobject
end type
end forward

global type uo_ge505_comum from nonvisualobject
end type
global uo_ge505_comum uo_ge505_comum

type prototypes
FUNCTION long GetCurrentProcessId()  LIBRARY "kernel32.dll" 
end prototypes

type variables
String is_usuario
String is_senha

string is_Rede_Ecommerce
string is_url, is_chave, is_token, is_id_interface, is_url_master_data
String is_IdLoja
String is_id_ecommerce = '3'
String is_de_marca
String is_id_visible
String is_id_metodo_api
String is_json
String is_cd_ean
String is_situacao_ecommerce_rede
String is_nr_pedido_ecommerce

//long il_nr_atualizacao
long il_cd_marca
long il_cd_produto
long il_cd_departamento
long il_cd_categoria
long il_cd_filial_preco
long il_qt_item_enviado_site
long il_cd_filial_pedido

decimal idc_qt_largura
decimal idc_qt_altura
decimal idc_qt_profundidade
decimal idc_qt_peso
decimal idc_qt_saldo
decimal idc_vl_preco
decimal idc_pc_desconto

OleObject iole_SrvHTTP, iole_Send

dc_uo_transacao iuo_SqlCa_log
end variables

forward prototypes
public function boolean of_busca_filial_ecommerce (string ps_rede_ecommerce, ref long pl_cd_filial, ref string ps_log)
public function boolean of_parametros_ecommerce (string ps_id_ecommerce, string ps_id_rede, ref long pl_cd_filial, ref string ps_log)
public function boolean of_altera_situacao_log_ecommerce (string ps_situacao, string ps_tabela, long pl_cd_filial, string ps_chave, ref string ps_log)
public function string of_formata_descricao (long pl_tipo, string ps_descricao)
public function boolean of_post (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
private function boolean of_comunicacao_api (string ps_metodo, string ps_json, ref string ps_retorno, ref string ps_log)
public function boolean of_put (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
public subroutine of_limpa_variaveis ()
public function string of_tratar_erro (string ps_mensagem)
public function boolean of_grava_log (long pl_filial, long pl_cd_tipo, string ps_chave, string ps_situacao, string ps_mensagem, datetime pdt_inicio, datetime pdt_termino, ref string ps_log, ref long pl_nr_seq_log)
public function boolean of_abre_conexao_log (ref string ps_log)
public function boolean of_fecha_conexao_log ()
public function boolean of_parametros_ecommerce_filial (long pl_cd_filial, string ps_id_rede, string ps_id_ecommerce, ref string ps_log)
public function boolean of_delete (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function boolean of_altera_situacao_log_ecommerce (string ps_situacao, long pl_nr_atualizacao, ref string ps_log)
public function boolean of_altera_situacao_log_ecommerce (string ps_situacao, string ps_tabela, long pl_cd_filial, string ps_chave, long pl_nr_atualizacao, ref string ps_log)
public function boolean of_get (string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function decimal of_decimal (long pl_valor)
public function boolean of_comunicacao_api_master_data (string ps_entidade, string ps_filtro, ref string ps_retorno, ref string ps_log)
public function boolean of_situacao_ecommerce (ref string ps_situacao, ref string ps_log)
public function boolean of_atualiza_ecommerce_log (long pl_filial, long pl_seq_log, string ps_situacao, string ps_mensagem, datetime pdt_termino, ref string ps_log)
public function boolean of_comunicacao_api_imagens_produtos (string ps_id_interface, string ps_sku, ref string ps_retorno, ref string ps_log)
public function long of_desenvolvimento_filial_baixa_pedido ()
public function string of_desenvolvimento_odbc_baixa_pedido ()
public function boolean of_grava_log_item (long pl_filial, long pl_nr_atualizacao, ref string ps_log, string ps_retorno_site)
public function boolean of_del (string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function boolean of_patch (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log)
public function boolean of_gera_token (ref string ps_log)
public subroutine of_envia_email_cancelamento (long pl_mensagem, long pl_nr_pedido, string ps_nr_pedido_ecommerce, string ps_nr_pedido_ifood, long pl_cd_filial, decimal pdc_valor)
public function boolean of_grava_log_historico (ref string ps_id_registro, long pl_cd_filial, long pl_cd_tipo_log, datetime pdh_inicio, datetime pdh_fim, string ps_id_situacao, long pl_nr_atualizacao, ref string ps_log)
public subroutine of_envia_email (long pl_mensagem, string ps_interface, long pl_controle, string ps_log, string ps_chave)
public function boolean of_tratar_retorno (string ps_json, boolean pb_erro, ref string ps_retorno, ref string ps_log)
end prototypes

public function boolean of_busca_filial_ecommerce (string ps_rede_ecommerce, ref long pl_cd_filial, ref string ps_log);Select cd_filial_ecommerce
	into :pl_cd_filial
	from ecommerce_rede
	where id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :ps_rede_ecommerce;
	
if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial_ecommerce ~n' + 'Problemas ao consultar a tabela "ECOMMERCE_REDE": ~n' + sqlca.sqlerrtext
	return false
end if
	
if pl_cd_filial = 0 or isnull(pl_cd_filial) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a filial ecommerce vinculada a seguinte rede: ' + ps_rede_ecommerce
	return false
end if
	
is_Rede_Ecommerce = ps_rede_ecommerce

return true
end function

public function boolean of_parametros_ecommerce (string ps_id_ecommerce, string ps_id_rede, ref long pl_cd_filial, ref string ps_log);
If (SqlCa.Database = 'central') Then

	Select cd_url_integracao, cd_chave_integracao, cd_token_integracao, cd_filial_ecommerce, cd_filial_preco, cd_url_master_data, id_situacao
	into :is_url, :is_usuario, :is_senha, :pl_cd_filial, :il_cd_filial_preco, :is_url_master_data, :is_situacao_ecommerce_rede
	from ecommerce_rede
	where id_ecommerce = :ps_id_ecommerce
	and id_rede_filial = :ps_id_rede;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_parametros_ecommerce ~n' + 'Problemas ao consultar a tabela "ECOMMERCE_REDE": ~n' + sqlca.sqlerrtext
		return false
	end if

elseif (SqlCa.Database <> 'central') Then
	
	Select cd_url_integracao_homologa, cd_chave_integracao_homologa, cd_token_integracao_homologa, cd_filial_ecommerce, cd_filial_preco, id_situacao, cd_url_master_data_homologa
	into :is_url, :is_usuario, :is_senha, :pl_cd_filial, :il_cd_filial_preco, :is_situacao_ecommerce_rede, :is_url_master_data
	from ecommerce_rede
	where id_ecommerce = :ps_id_ecommerce
	and id_rede_filial = :ps_id_rede;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_parametros_ecommerce ~n' + 'Problemas ao consultar a tabela "ECOMMERCE_REDE": ~n' + sqlca.sqlerrtext
		return false
	end if
	
end if

If isnull(is_url) or is_url = '' Then
	ps_log = 'A URL de integra$$HEX2$$e700e300$$ENDHEX$$o com o IFOOD n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurada no seguinte ambiente: ' + SqlCa.Database
	return false
end if

If isnull(is_usuario) or is_usuario = '' Then
	ps_log = 'A Chave de integra$$HEX2$$e700e300$$ENDHEX$$o com o IFOOD n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurada no seguinte ambiente: ' + SqlCa.Database
	return false
end if

If isnull(is_senha) or is_senha = '' Then
	ps_log = 'O Token de integra$$HEX2$$e700e300$$ENDHEX$$o com o IFOOD n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurada no seguinte ambiente: ' + SqlCa.Database
	return false
end if

if isnull(pl_cd_filial) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a filial ecommerce vinculada a seguinte rede: ' + ps_id_rede
	return false
end if

If isnull(is_situacao_ecommerce_rede) or is_situacao_ecommerce_rede = '' or is_situacao_ecommerce_rede = 'I' Then
	ps_log = 'O ecommerce da rede [' + ps_id_rede + '] est$$HEX1$$e100$$ENDHEX$$ inativo no seguinte ambiente: ' + SqlCa.Database
	return false
end if	

	
is_Rede_Ecommerce = ps_id_rede

return true
end function

public function boolean of_altera_situacao_log_ecommerce (string ps_situacao, string ps_tabela, long pl_cd_filial, string ps_chave, ref string ps_log);return of_altera_situacao_log_ecommerce(ps_situacao, ps_tabela, pl_cd_filial, ps_chave, 0, ref ps_log)
end function

public function string of_formata_descricao (long pl_tipo, string ps_descricao);string ls_resultado

Choose Case pl_tipo
	Case 1
		ls_resultado = wordcap(ps_descricao)
	Case 2
		ls_resultado = wordcap(ps_descricao)
		ls_resultado = gf_replace(ls_resultado, ' ', '-', 0)
	Case 3
		ls_resultado = lower(ps_descricao)
End Choose

return ls_resultado
end function

public function boolean of_post (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'POST'

return of_comunicacao_api('POST', ps_json, ref ps_retorno, ref ps_log)
end function

private function boolean of_comunicacao_api (string ps_metodo, string ps_json, ref string ps_retorno, ref string ps_log);Long ll_status_code
String ls_url_local
String ls_status_text
String ls_Retorno_Api
any la_result

//Adiciona $$HEX1$$e000$$ENDHEX$$ url qual interface est$$HEX1$$e100$$ENDHEX$$ sendo utilizada
ls_url_local = is_url + is_id_interface
	
Try	
	
	IF Not IsValid(iole_SrvHTTP) THEN
		
		iole_SrvHTTP = CREATE oleobject
		iole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		//iole_SrvHTTP.ConnectToNewObject("WinHTTP.WinHTTPRequest.5.1")
		iole_Send = CREATE oleobject
		iole_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")
		
	End If
	
	iole_SrvHTTP.open (ps_metodo, ls_url_local, false) 
	
	iole_SrvHTTP.SetRequestHeader("content-type", "application/json")
	
	if is_token <> '' and not isnull(is_token) Then
		iole_SrvHTTP.SetRequestHeader("authorization", "bearer " + is_token )
	end if
	
	// Trust the SSL Certificate - IGNORA OS ERROS DE CERTIFICADO
	iole_SrvHTTP.setOption(2,'13056') 
	
	// MOSTRAR O VALOR SETADO NA OPCAO 2
	//la_result = iole_SrvHTTP.getOption(2)
		
	IF IsValid(iole_SrvHTTP) THEN
		
		TRY
			If IsNull( ps_Json ) Then ps_Json = ''
			
			If(ps_metodo = 'GET') Then
				iole_SrvHTTP.Send(iole_Send)
			Else
				iole_SrvHTTP.send(ps_json) 
			End If
			
		CATCH (RuntimeError e) 
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel se conectar com o webservice. ~nErro: ' + e.getMessage()
			Return false
		END TRY 
		
		ll_status_code = iole_SrvHTTP.readyState 
		IF ll_status_code <> 4 THEN
			iole_SrvHTTP.DisconnectObject() 
			Destroy iole_SrvHTTP 
			
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: readyState = ' + String(ll_status_code)
			Return false
			
		End If
		
		//Get response 
		ls_status_text = iole_SrvHTTP.StatusText 
		ll_status_code = iole_SrvHTTP.Status 
		
		ls_Retorno_Api = String( iole_SrvHTTP.ResponseText )
		
		if ll_status_code = 200 Then
	
			If(ps_metodo = 'GET') Then
			
				ps_retorno = ls_retorno_api
			else
				//ps_retorno = ls_retorno_api
				if Not this.of_tratar_retorno( ls_retorno_api, false, ref ps_retorno, ref ps_log) Then Return false
				
				if upper(ps_retorno) = 'FALSE' Then
//					if Not this.of_tratar_retorno( ls_retorno_api, True, ref ps_retorno, ref ps_log) Then Return false
//					ps_log = ps_retorno
					ps_log = ls_retorno_api
					ps_retorno = ''
				end if
				
			end if
		
		elseif ll_status_code = 401 Then
			
			ps_retorno = ''
			ps_log = ls_status_text
			
			return false
		
		else
			
			ps_retorno = ''
			if Not this.of_tratar_retorno( ls_retorno_api, True, ref ps_retorno, ref ps_log) Then Return false
			ps_log = ps_retorno
			Return false
			
		end if
		
	End If
	
Finally	
	
	IF IsValid(iole_SrvHTTP) THEN 
		iole_SrvHTTP.DisconnectObject()
		Destroy iole_SrvHTTP 
	end if
	
	IF IsValid(iole_Send) THEN 
		iole_Send.DisconnectObject()
		Destroy iole_Send 
	end if

End Try

Return true



end function

public function boolean of_put (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'PUT'

return of_comunicacao_api('PUT', ps_json, ref ps_retorno, ref ps_log)
end function

public subroutine of_limpa_variaveis ();//setnull( il_nr_atualizacao)
setnull( il_cd_marca)
setnull( is_de_marca)
setnull( il_cd_produto)
setnull( is_id_metodo_api)
setnull( il_cd_departamento)
setnull( il_cd_categoria)
setnull( is_id_visible)
setnull( idc_qt_largura)
setnull( idc_qt_altura)
setnull( idc_qt_profundidade)
setnull( idc_qt_peso)
setnull( idc_qt_saldo)
setnull( idc_vl_preco)
setnull( idc_pc_desconto)
setnull( is_json)
setnull( is_cd_ean)
end subroutine

public function string of_tratar_erro (string ps_mensagem);string ls_retorno

if match(upper(ps_mensagem),'BRAND NOT FOUND') Then
	ls_retorno = 'Marca n$$HEX1$$e300$$ENDHEX$$o cadastrada no site'
elseIf ps_mensagem = 'Brand already created with this Id' Then
	ls_retorno = 'Marca j$$HEX1$$e100$$ENDHEX$$ criada com este ID'
ElseIf Pos(ps_mensagem, 'There is already a product created with the same RefId for the Product') > 0 Then
	ls_retorno = 'Produto j$$HEX1$$e100$$ENDHEX$$ foi criado no site'	
else
	ls_retorno = ps_mensagem
end if


return ls_retorno
end function

public function boolean of_grava_log (long pl_filial, long pl_cd_tipo, string ps_chave, string ps_situacao, string ps_mensagem, datetime pdt_inicio, datetime pdt_termino, ref string ps_log, ref long pl_nr_seq_log);string ls_erro
boolean lb_sucesso = false

Try
	
	SetNull(pl_nr_seq_log)
	
	//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
	if Not of_abre_conexao_log(ref ps_log) Then return false
	
	Declare sp_log Procedure for sp_log_export_ecom_prox_seq
	@proximo_sequencial_retorno  = :pl_nr_seq_log OUTPUT,
	@mensagem_retorno = :ls_erro OUTPUT
	USING iuo_SqlCa_log;
			
	Execute sp_log;
	
	If iuo_SqlCa_log.sqlcode = -1 then 
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log ~n' + 'Erro ao executar a procedure "sp_log_export_ecom_prox_seq": ~n' + iuo_SqlCa_log.sqlerrtext 
		return false
	end if
	
	Fetch sp_log Into :pl_nr_seq_log, :ls_erro;

	Close sp_log;
	
	if ls_erro <> '' and not isnull(ls_erro) Then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log ~n' + 'Erro ao executar a procedure "sp_log_export_ecom_prox_seq": ~n' + ls_erro
		return false
	end if
	
	ps_mensagem = gf_replace(ps_mensagem, '"', '', 0)
	
	if trim(ps_mensagem) = '' Then setnull(ps_mensagem)
	
	insert into ecommerce_log(cd_filial, nr_atualizacao, id_ecommerce, id_rede_filial, cd_tipo, cd_chave, dh_inclusao, dh_inicio_envio, dh_termino_envio, id_situacao, de_mensagem, qt_item_enviado_site)
		values(:pl_filial, :pl_nr_seq_log, :is_id_ecommerce, :is_rede_ecommerce, :pl_cd_tipo, :ps_chave, getdate(), :pdt_inicio, :pdt_termino, :ps_situacao, :ps_mensagem, :il_qt_item_enviado_site)
		Using iuo_SqlCa_log;
		
	If iuo_SqlCa_log.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log ~n' + 'Erro ao inserir registro na tabela "ecommerce_log": ' + iuo_SqlCa_log.sqlerrtext 
		return false
	end if
	
	lb_sucesso = True
	
Finally
	
	if lb_sucesso = True Then
		iuo_SqlCa_log.of_commit( )
	else
		iuo_SqlCa_log.of_rollback( )
	end if
	
End Try

return true
end function

public function boolean of_abre_conexao_log (ref string ps_log);
//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
if Not isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log = create dc_uo_transacao
	iuo_SqlCa_log.ivs_database = "SYBASE"
end if

if Not iuo_SqlCa_log.of_isconnected() Then

	If Not iuo_SqlCa_log.of_Connect(gvo_Aplicacao.ivs_DataSource, 'GE505 - Interface IFOOD') Then
		ps_log =  'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_abre_conexao_log ~n' + "Erro ao conectar no Sybase."
		Return False
	End If
	
end if

return true
end function

public function boolean of_fecha_conexao_log ();
//Fecha conex$$HEX1$$e300$$ENDHEX$$o usada para gerar log.
if isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log.of_disconnect( )
	destroy(iuo_SqlCa_log)
end if

return true
end function

public function boolean of_parametros_ecommerce_filial (long pl_cd_filial, string ps_id_rede, string ps_id_ecommerce, ref string ps_log);

If (SqlCa.Database = 'central') Then

	Select cd_url_integracao, cd_chave_integracao, cd_token_integracao, id_situacao, cd_warehouseid
	into :is_url, :is_usuario, :is_senha, :is_situacao_ecommerce_rede, :is_IdLoja
	from ecommerce_rede_filial
	where id_ecommerce = :ps_id_ecommerce
	and id_rede_filial = :ps_id_rede
	and cd_filial= :pl_cd_filial;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_parametros_ecommerce_filial ~n' + 'Problemas ao consultar a tabela "ECOMMERCE_REDE": ~n' + sqlca.sqlerrtext
		return false
	end if

elseif (SqlCa.Database <> 'central') Then
	
	Select cd_url_integracao_homologa, cd_chave_integracao_homologa, cd_token_integracao_homologa,  id_situacao, cd_warehouseid
	into :is_url, :is_usuario, :is_senha, :is_situacao_ecommerce_rede, :is_IdLoja
	from ecommerce_rede_filial
	where id_ecommerce = :ps_id_ecommerce
	and id_rede_filial = :ps_id_rede
	and cd_filial= :pl_cd_filial;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_parametros_ecommerce_filial ~n' + 'Problemas ao consultar a tabela "ECOMMERCE_REDE": ~n' + sqlca.sqlerrtext
		return false
	end if
	
end if

If isnull(is_situacao_ecommerce_rede) or is_situacao_ecommerce_rede = '' or is_situacao_ecommerce_rede = 'I' Then
	ps_log = 'A filial [' + string(pl_cd_filial) + '] est$$HEX1$$e100$$ENDHEX$$ inativa no ecommerce no seguinte ambiente: ' + SqlCa.Database
	return false
end if

If isnull(is_url) or is_url = '' Then
	ps_log = 'A URL de integra$$HEX2$$e700e300$$ENDHEX$$o com o IFOOD n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurado no seguinte ambiente: ' + SqlCa.Database
	return false
end if


If isnull(is_usuario) or is_usuario = '' Then
	ps_log = 'O usu$$HEX1$$e100$$ENDHEX$$rio de integra$$HEX2$$e700e300$$ENDHEX$$o da filial ' + string(pl_cd_filial) + ' com o IFOOD n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurado no seguinte ambiente: ' + SqlCa.Database
	return false
end if	
	
If isnull(is_senha) or is_senha = '' Then
	ps_log = 'A senha de integra$$HEX2$$e700e300$$ENDHEX$$o da filial ' + string(pl_cd_filial) + ' com o IFOOD n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurado no seguinte ambiente: ' + SqlCa.Database
	return false
end if		
	
If isnull(is_IdLoja) or is_IdLoja = '' Then
	ps_log = 'O c$$HEX1$$f300$$ENDHEX$$digo da loja ' + string(pl_cd_filial) + ' no IFOOD (IdLoja) n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurado no seguinte ambiente: ' + SqlCa.Database
	return false
end if 	
	
is_Rede_Ecommerce = ps_id_rede

return true
end function

public function boolean of_delete (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'DELETE'

return of_comunicacao_api('DELETE', ps_json, ref ps_retorno, ref ps_log)
end function

public function boolean of_altera_situacao_log_ecommerce (string ps_situacao, long pl_nr_atualizacao, ref string ps_log);return of_altera_situacao_log_ecommerce(ps_situacao, '', 0, '', pl_nr_atualizacao, ref ps_log)
end function

public function boolean of_altera_situacao_log_ecommerce (string ps_situacao, string ps_tabela, long pl_cd_filial, string ps_chave, long pl_nr_atualizacao, ref string ps_log);if ps_chave = '' then setnull(ps_chave)

If ps_situacao = 'P' Then

		Update log_exportacao_ecommerce
		Set id_processado = :ps_Situacao
		Where id_processado = 'N'
		  and nm_tabela = :ps_Tabela
			and cd_filial_ecommerce = :pl_cd_filial
			and id_ecommerce = :is_id_ecommerce
			and (:ps_chave is null or de_chave = :ps_chave)
		Using SqlCa;

	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~n' + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_altera_situacao ' +  '~nProblemas ao atualizar a tabela "log_exportacao_ecommerce": ~n' + sqlca.sqlerrtext
		return false
	end if
	
	SqlCa.of_Commit();

Elseif ps_situacao = 'S' then
	
	if pl_nr_atualizacao > 0 Then
		
		Update log_exportacao_ecommerce
			Set id_processado = :ps_situacao
			Where id_processado = 'P'
			  and nr_atualizacao = :pl_nr_atualizacao
			  Using SQLCA;
		
	else
	
		Update log_exportacao_ecommerce
			Set id_processado = :ps_situacao
			Where id_processado = 'P'
			  and nm_tabela = :ps_tabela
			  and cd_filial_ecommerce = :pl_cd_filial
			  and de_chave = :ps_chave
			  and id_ecommerce = :is_id_ecommerce
			 Using SqlCa;
	
	end if
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname( ) + '~n' + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_altera_situacao ' +  '~nProblemas ao atualizar a tabela "log_exportacao_ecommerce": ~n' + sqlca.sqlerrtext
		return false
	end if

End if

return true
end function

public function boolean of_get (string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'GET'

return of_comunicacao_api('GET', '', ref ps_retorno, ref ps_log)
end function

public function decimal of_decimal (long pl_valor);long ll_len
string ls_ret, ls_numero

ls_numero = string(pl_valor)
ll_len = len(ls_numero)

ls_ret = mid( ls_numero, 1, ll_len - 2) + ',' + right( ls_numero, 2 )

return dec(ls_ret)
end function

public function boolean of_comunicacao_api_master_data (string ps_entidade, string ps_filtro, ref string ps_retorno, ref string ps_log);Long ll_status_code
String ls_url_local
String ls_status_text
String ls_Retorno_Api

//Adiciona $$HEX1$$e000$$ENDHEX$$ url qual interface est$$HEX1$$e100$$ENDHEX$$ sendo utilizada
ls_url_local = is_url_master_data + "/" + ps_Entidade + "/" + ps_filtro
	
Try	
	
	IF Not IsValid(iole_SrvHTTP) THEN
		
		iole_SrvHTTP = CREATE oleobject
		iole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		
		iole_Send = CREATE oleobject
		iole_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")
		
	End If
	
	iole_SrvHTTP.open ("GET", ls_url_local, false) 
	
	iole_SrvHTTP.SetRequestHeader("accept", "application/vnd.vtex.ds.v10+json")
	iole_SrvHTTP.SetRequestHeader("content-type", "application/json")
	iole_SrvHTTP.SetRequestHeader("x-vtex-api-appkey", is_chave)
	iole_SrvHTTP.setRequestHeader("x-vtex-api-apptoken", is_token) 
	
	// Trust the SSL Certificate 
	iole_SrvHTTP.setOption(2,'13056') 
	
	IF IsValid(iole_SrvHTTP) THEN
		
		TRY
			iole_SrvHTTP.Send(iole_Send)
			
		CATCH (RuntimeError e) 
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: ' + e.getMessage()
			Return false
		END TRY 
		
		ll_status_code = iole_SrvHTTP.readyState 
		IF iole_SrvHTTP.readyState <> 4 THEN
			iole_SrvHTTP.DisconnectObject() 
			Destroy iole_SrvHTTP 
			
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: readyState = ' + String(ll_status_code)
			Return false
			
		End If
		
		//Get response 
		ls_status_text = iole_SrvHTTP.StatusText 
		ll_status_code = iole_SrvHTTP.Status 
		
		ls_Retorno_Api = String( iole_SrvHTTP.ResponseText )
		
		if UPPER(ls_status_text) = 'OK' Then
			ps_retorno = ls_retorno_api
		else
			ps_retorno = ''
			//ps_log = of_tratar_erro(ls_Retorno_Api)
			ps_log = ls_Retorno_Api
			Return True
			
		end if
		
	End If
	
Finally	
	
	IF IsValid(iole_SrvHTTP) THEN 
		iole_SrvHTTP.DisconnectObject()
		Destroy iole_SrvHTTP 
	end if
	
	IF IsValid(iole_Send) THEN 
		iole_Send.DisconnectObject()
		Destroy iole_Send 
	end if

End Try

Return True
end function

public function boolean of_situacao_ecommerce (ref string ps_situacao, ref string ps_log);string ls_retorno

select id_situacao
into :ls_retorno
from ecommerce
where id_ecommerce = :is_id_ecommerce;

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_situacao_ecommerce ~n' + 'Problemas ao consultar a tabela "ecommerce": ~n' + sqlca.sqlerrtext
	return false
end if

ps_situacao = ls_retorno

return true
end function

public function boolean of_atualiza_ecommerce_log (long pl_filial, long pl_seq_log, string ps_situacao, string ps_mensagem, datetime pdt_termino, ref string ps_log);boolean lb_sucesso = false

Try
	//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
	if Not this.of_abre_conexao_log( ref ps_log ) Then return false
	
	UPDATE ecommerce_log  
  	SET id_situacao =:ps_situacao, de_mensagem =:ps_mensagem, dh_termino_envio =:pdt_termino
	Where cd_filial 			= :pl_filial
   	    and nr_atualizacao	= :pl_seq_log
   	Using iuo_SqlCa_log;
			
	If iuo_SqlCa_log.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log ~n' + 'Erro ao inserir registro na tabela "ecommerce_log": ' + iuo_SqlCa_log.sqlerrtext 
		return false
	end if
	
	lb_sucesso = True	
Finally
	
	if lb_sucesso Then
		iuo_SqlCa_log.of_commit( )
	else
		iuo_SqlCa_log.of_rollback( )
	end if
	
End Try

return lb_sucesso
end function

public function boolean of_comunicacao_api_imagens_produtos (string ps_id_interface, string ps_sku, ref string ps_retorno, ref string ps_log);Long ll_status_code
String ls_url_local
String ls_status_text
String ls_Retorno_Api

//Adiciona $$HEX1$$e000$$ENDHEX$$ url qual interface est$$HEX1$$e100$$ENDHEX$$ sendo utilizada
ls_url_local = is_url + ps_id_interface + ps_sku
	
Try	
	
	IF Not IsValid(iole_SrvHTTP) THEN
		
		iole_SrvHTTP = CREATE oleobject
		iole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		
		iole_Send = CREATE oleobject
		iole_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")
		
	End If
	
	iole_SrvHTTP.open ("GET", ls_url_local, false) 
	
	iole_SrvHTTP.SetRequestHeader("accept", "application/vnd.vtex.ds.v10+json")
	iole_SrvHTTP.SetRequestHeader("content-type", "application/json")
	iole_SrvHTTP.SetRequestHeader("x-vtex-api-appkey", is_chave)
	iole_SrvHTTP.setRequestHeader("x-vtex-api-apptoken", is_token) 
	
	// Trust the SSL Certificate 
	iole_SrvHTTP.setOption(2,'13056') 
	
	IF IsValid(iole_SrvHTTP) THEN
		
		TRY
			iole_SrvHTTP.Send(iole_Send)
			
		CATCH (RuntimeError e) 
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: ' + e.getMessage()
			Return false
		END TRY 
		
		ll_status_code = iole_SrvHTTP.readyState 
		IF iole_SrvHTTP.readyState <> 4 THEN
			iole_SrvHTTP.DisconnectObject() 
			Destroy iole_SrvHTTP 
			
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: readyState = ' + String(ll_status_code)
			Return false
			
		End If
		
		//Get response 
		ls_status_text = iole_SrvHTTP.StatusText 
		ll_status_code = iole_SrvHTTP.Status 
		
		ls_Retorno_Api = String( iole_SrvHTTP.ResponseText )
		
		if UPPER(ls_status_text) = 'OK' Then
			ps_retorno = ls_retorno_api
		else
			ps_retorno = ''
			//ps_log = of_tratar_erro(ls_Retorno_Api)
			ps_log = ls_Retorno_Api
			Return True
			
		end if
		
	End If
	
Finally	
	
	IF IsValid(iole_SrvHTTP) THEN 
		iole_SrvHTTP.DisconnectObject()
		Destroy iole_SrvHTTP 
	end if
	
	IF IsValid(iole_Send) THEN 
		iole_Send.DisconnectObject()
		Destroy iole_Send 
	end if

End Try

Return True
end function

public function long of_desenvolvimento_filial_baixa_pedido ();Long  ll_Retorno
String ls_Parametro 

ls_Parametro = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'ECOMMERCE', 'Filial_Baixa_Pedido', "")

If Not IsNull(ls_Parametro) and Trim(ls_Parametro) <> ''  Then
	ll_Retorno =  Long(ls_Parametro)
Else
	SetNull(ll_Retorno)
End If

Return ll_Retorno





end function

public function string of_desenvolvimento_odbc_baixa_pedido ();String ls_Parametro 

ls_Parametro = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'ECOMMERCE', 'ODBC_Baixa_Pedido', "")

If Trim(ls_Parametro) = ''  Then SetNull(ls_Parametro)

Return ls_Parametro





end function

public function boolean of_grava_log_item (long pl_filial, long pl_nr_atualizacao, ref string ps_log, string ps_retorno_site);long ll_nr_item
string ls_erro
string ls_erro_usuario
boolean lb_sucesso = false

Try

	if Not this.of_abre_conexao_log( ref ps_log ) Then return false

	if pl_nr_atualizacao = 0 or isnull(pl_nr_atualizacao) Then
		ps_log =  'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log_item ~n' + "N$$HEX1$$e300$$ENDHEX$$o foi encontrado registro da tabela ecommerce_log (nr_atualizacao)."
		return false
	end if
	
	ps_retorno_site = gf_replace(ps_retorno_site, '"', '', 0)
	
	ls_erro_usuario = of_tratar_erro(ps_retorno_site)
	
	Select max(nr_item)
	into :ll_nr_item
	from ecommerce_log_item
	where nr_atualizacao = :pl_nr_atualizacao
	USING iuo_SqlCa_log;
	
	If iuo_SqlCa_log.sqlcode = -1 then 
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log_item ~n' + 'Erro ao consultar a tabela "ecommerce_log_item": ~n' + iuo_SqlCa_log.sqlerrtext 
		return false
	end if
	
	If trim(ps_retorno_site) = '' Then setnull(ps_retorno_site)
	If trim(ls_erro_usuario) = '' Then setnull(ls_erro_usuario)
	
	if isnull(ll_nr_item) or ll_nr_item = 0 Then
		ll_nr_item = 1
	else
		ll_nr_item++
	end if
	
	 insert into ecommerce_log_item(cd_filial, 	 
	 											nr_atualizacao, 	 											
         										nr_item,   
												cd_marca,   
												de_marca,   
												cd_produto,   
												id_metodo_api,   
												cd_departamento,   
												cd_categoria,   
												id_visible,   
												qt_largura_cm,   
												qt_altura_cm,   
												qt_profundidade_cm,   
												qt_peso_grama,   
												qt_saldo,   
												vl_preco,   
												pc_desconto,   
												de_json,
												de_retorno_site,
												de_retorno_usuario,
												de_codigo_barras, 
												nr_pedido_ecommerce,
												cd_filial_pedido)
	    Values( :pl_filial,
		 			:pl_nr_atualizacao,
		 			:ll_nr_item,
					 :il_cd_marca,
					 :is_de_marca,
					 :il_cd_produto,
					 :is_id_metodo_api,
					 :il_cd_departamento,
					 :il_cd_categoria,
					 :is_id_visible,
					 :idc_qt_largura,
					 :idc_qt_altura,
					 :idc_qt_profundidade,
					 :idc_qt_peso,
					 :idc_qt_saldo,
					 :idc_vl_preco,
					 :idc_pc_desconto,
					 :is_json,
					 :ps_retorno_site,
					 :ls_erro_usuario,
					 :is_cd_ean,
					 :is_nr_pedido_ecommerce,
					 :il_cd_filial_pedido)
		USING iuo_SqlCa_log;
		
	If iuo_SqlCa_log.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log_item ~n' + 'Erro ao inserir registro na tabela "ecommerce_log_item": ' + iuo_SqlCa_log.sqlerrtext 
		return false
	end if
	
	lb_sucesso = True
	
Finally
	
	if isvalid(iuo_SqlCa_log) and iuo_SqlCa_log.of_isconnected( ) Then
		if lb_sucesso = True Then
			iuo_SqlCa_log.of_commit( )
		else
			iuo_SqlCa_log.of_rollback( )
		end if
	
	end if
	
End Try

return true
end function

public function boolean of_del (string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'DEL'

return of_comunicacao_api('DEL', '', ref ps_retorno, ref ps_log)
end function

public function boolean of_patch (string ps_json, string ps_id_interface, ref string ps_retorno, ref string ps_log);is_id_interface = ps_id_interface
this.is_id_metodo_api = 'PATCH'

return of_comunicacao_api('PATCH', ps_json, ref ps_retorno, ref ps_log)
end function

public function boolean of_gera_token (ref string ps_log);string ls_json
string ls_id_interface
string ls_retorno
uo_ge073_json luo_json

luo_json = create uo_ge073_json

ls_id_interface = 'api/v1/oauth/token'


ls_json = "{" + &
			 '"client_id": "' + is_usuario + '", ' + &
			 '"client_secret": "' + is_senha + '"' + &
			 "}"
			 
Try			 

	If Not this.of_post( ls_json, ls_id_interface, ref ls_retorno, ref ps_log ) Then return false

	//access_token
	is_token = luo_json.of_busca_conteudo_campo( ls_retorno, 'access_token')

Finally

	destroy(luo_json)

End Try

return true
end function

public subroutine of_envia_email_cancelamento (long pl_mensagem, long pl_nr_pedido, string ps_nr_pedido_ecommerce, string ps_nr_pedido_ifood, long pl_cd_filial, decimal pdc_valor);String lvs_Assunto
String lvs_Mensagem
String ls_ds_filial

select nm_fantasia
into :ls_ds_filial
from filial
where cd_filial = :pl_cd_filial
Using sqlca;

ls_ds_filial = string(pl_cd_filial) + ' - ' + ls_ds_filial

lvs_Mensagem =	'O processo de integra$$HEX2$$e700e300$$ENDHEX$$o identificou que houve um cancelamento de pedido no IFOOD. <br><br>'+ &
						'Pedido: <b>' + string(pl_nr_pedido) +'</b><br>' + &
						'Pedido SMR: <b>' + ps_nr_pedido_ecommerce +'</b><br>' + &
						'Pedido IFOOD: <b>' + ps_nr_pedido_ifood +'</b><br>' + &
						'Filial: <b>' + ls_ds_filial +'</b><br>' + &
						'Valor: <b>' + string(pdc_valor) 
						
gf_ge202_envia_email_automatico_filial(	pl_mensagem	, & 	
												''						, &    	
												lvs_Mensagem		, & 
												{''}, pl_cd_filial)			
end subroutine

public function boolean of_grava_log_historico (ref string ps_id_registro, long pl_cd_filial, long pl_cd_tipo_log, datetime pdh_inicio, datetime pdh_fim, string ps_id_situacao, long pl_nr_atualizacao, ref string ps_log);boolean lb_sucesso = false
long ll_existe
long ll_pos
long ll_processid
string ls_processo

boolean lb_usa_interface_kill = false

Try
		
	//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
	if Not of_abre_conexao_log(ref ps_log) Then return false
	
	if ps_id_registro = '' or isnull(ps_id_registro) Then
//			
			ll_processid = GetCurrentProcessId()
			ls_processo = string(ll_processid)
				
	
		Select Newid(1)
		into :ps_id_registro
		from parametro
		using iuo_SqlCa_log;
	
		insert into ecommerce_log_historico( nr_id,
															cd_filial,   
															cd_tipo_log,   
															dh_inicio,     
															id_situacao,   
															nr_atualizacao_log,
															de_processo,
															id_ecommerce,
															de_host)
		Values( :ps_id_registro,
					:pl_cd_filial,
					:pl_cd_tipo_log,
					:pdh_inicio,
					:ps_id_situacao,
					0,
					:ls_processo,
					:is_id_ecommerce,
					:gvo_aplicacao.is_ComputerName)
		Using iuo_SqlCa_log;
		
		If iuo_SqlCa_log.sqlcode = -1 then
			ps_log = 'Objeto: ' + this.classname() + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log_historico; ' + 'Erro ao inserir registro na tabela "ecommerce_log_historico": ' + iuo_SqlCa_log.sqlerrtext 
			return false
		end if
		
	Else
		
		update ecommerce_log_historico
		set dh_termino = :pdh_fim,
			id_situacao = :ps_id_situacao,
			nr_atualizacao_log = :pl_nr_atualizacao
		where nr_id = :ps_id_registro
		Using iuo_SqlCa_log;
	
		If iuo_SqlCa_log.sqlcode = -1 then
			ps_log = 'Objeto: ' + this.classname() + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log_historico; ' + 'Erro ao atualizar a tabela "ecommerce_log_historico": ' + iuo_SqlCa_log.sqlerrtext 
			return false
		end if
	
		Select count(*)
		into :ll_existe
		from ecommerce_log_resumo
		where cd_filial = :pl_cd_filial
			and cd_tipo_log = :pl_cd_tipo_log
			and id_ecommerce = :is_id_ecommerce;
		
		If iuo_SqlCa_log.sqlcode = -1 then
			ps_log = 'Objeto: ' + this.classname() + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log_historico; ' + 'Erro ao consultar a tabela "ecommerce_log_historico": ' + iuo_SqlCa_log.sqlerrtext 
			return false
		end if
		
		if ll_existe = 0 or isnull(ll_existe) Then
			
			Insert into ecommerce_log_resumo( cd_filial,   
															cd_tipo_log,   
															dh_inicio,   
															dh_termino,   
															id_situacao,   
															nr_atualizacao_log,
															id_ecommerce)
			Values( :pl_cd_filial,
						:pl_cd_tipo_log,
						:pdh_inicio,
						:pdh_fim,
						:ps_id_situacao,
						:pl_nr_atualizacao,
						:is_id_ecommerce)
			Using iuo_SqlCa_log;
		
			If iuo_SqlCa_log.sqlcode = -1 then
				ps_log = 'Objeto: ' + this.classname() + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log_historico; ' + 'Erro ao inserir registro na tabela "ecommerce_log_historico": ' + iuo_SqlCa_log.sqlerrtext 
				return false
			end if
		
		else
			
			Update ecommerce_log_resumo
			set dh_inicio = :pdh_inicio, 
				dh_termino = :pdh_fim,
				id_situacao = :ps_id_situacao,
				nr_atualizacao_log = :pl_nr_atualizacao
			Where cd_filial = :pl_cd_filial
				and cd_tipo_log = :pl_cd_tipo_log
				and id_ecommerce = :is_id_ecommerce
			Using iuo_SqlCa_log;
			
			If iuo_SqlCa_log.sqlcode = -1 then
				ps_log = 'Objeto: ' + this.classname() + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log_historico; ' + 'Erro ao atualizar a tabela "ecommerce_log_resumo": ' + iuo_SqlCa_log.sqlerrtext 
				return false
			end if
			
		end if
		
	end if
	
	lb_sucesso = True
	
Finally
	
	if lb_sucesso = True Then
		If Not gf_ge501_commit(iuo_SqlCa_log) Then Return False
	else
		If Not gf_ge501_Rollback(iuo_SqlCa_log) Then Return False
	end if

End Try

return true
end function

public subroutine of_envia_email (long pl_mensagem, string ps_interface, long pl_controle, string ps_log, string ps_chave);String lvs_Assunto
String lvs_Mensagem, lvs_mensagem_log
String ls_erro
Long ll_existe
Date ldt_data
boolean lb_erro = false

lvs_Mensagem =	'Houveram problemas na integra$$HEX2$$e700e300$$ENDHEX$$o com o IFOOD. <br>'+ &
						'Interface: <b>' + ps_interface+'</b><br>' + &
						'N$$HEX1$$ba00$$ENDHEX$$ Atualiza$$HEX2$$e700e300$$ENDHEX$$o: <b>'	 + String(pl_controle) + '</b><br>' +&					
						 ps_log

lvs_mensagem_log = 'Plataforma: IFOOD ; Interface: ' + ps_interface + '; Msg: ' + ps_log						
						
this.of_abre_conexao_log( ref ls_erro )				
						
ldt_data = date(gf_getserverdate())

Try

	lvs_mensagem_log = mid(lvs_mensagem_log, 1, 250)

	Select Count(*)
	into :ll_existe
	from ecommerce_envio_email
	where de_chave = :ps_chave
	and de_mensagem = :lvs_mensagem_log
	and dh_envio = :ldt_data
	Using iuo_SqlCa_log;
	
	if iuo_SqlCa_log.sqlcode = -1 then
		lb_erro = true
		ls_erro = iuo_SqlCa_log.sqlerrtext
	Else
		
		if ll_existe > 0 Then return 
		
		Insert into ecommerce_envio_email (de_chave, de_mensagem, dh_envio)
		values( :ps_chave, :lvs_mensagem_log, :ldt_data)
		Using iuo_SqlCa_log;
		
		if iuo_SqlCa_log.sqlcode = -1 then
			lb_erro = true
			ls_erro = iuo_SqlCa_log.sqlerrtext
		else
			If Not gf_ge501_commit(iuo_SqlCa_log) Then Return
		end if
	end if

	gf_ge202_envia_email_automatico(	pl_mensagem	, & 	
													''						, &    	
													lvs_Mensagem		, & 
													{''})		

Finally
	
	if lb_erro = true then
		If Not gf_ge501_rollback(iuo_SqlCa_log) Then Return
		
		ls_erro ='Objeto: ' + this.classname() + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_envia_email; Erro: ' + ls_erro
		gf_ge202_envia_email_automatico(	pl_mensagem	, & 	
														''						, &    	
														ls_erro, & 
														{''})	
	end if
End Try
	
end subroutine

public function boolean of_tratar_retorno (string ps_json, boolean pb_erro, ref string ps_retorno, ref string ps_log);string ls_erro, ls_json_restante
long ll_pos, ll_pos_fim
uo_ge073_json luo_json


luo_json = create uo_ge073_json

if pb_erro = True Then
	
	luo_json.of_divide_grupo_json_tag_vtex(ref ps_json, 'error', ref ls_erro , '}')
	
	ps_retorno = luo_json.of_busca_conteudo_campo( ls_erro, 'error_description')
	
	if ps_retorno = '' or isnull(ps_retorno) Then
		
		ll_pos = pos(ps_json, "<div id='message'>",1)
		
		if ll_pos > 0 Then
			ll_pos_fim = pos(ps_json, "</div>", ll_pos) 
			
			ps_retorno = Mid(ps_json, ll_pos, ll_pos_fim - ll_pos)
		end if
		
		if ps_retorno = '' or isnull(ps_retorno) Then
			ps_retorno = ps_json
		end if
		
	end if
	
else

	if match( ps_json, 'success') = True Then
		ps_retorno = luo_json.of_busca_conteudo_campo( ps_json, 'success')
	else
		
		ps_retorno =ps_json
		
	end if
	
end if

destroy(luo_json)

return true
end function

on uo_ge505_comum.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge505_comum.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;this.of_fecha_conexao_log( )
end event

