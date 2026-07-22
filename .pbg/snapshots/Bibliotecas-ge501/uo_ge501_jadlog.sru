HA$PBExportHeader$uo_ge501_jadlog.sru
forward
global type uo_ge501_jadlog from nonvisualobject
end type
end forward

global type uo_ge501_jadlog from nonvisualobject
end type
global uo_ge501_jadlog uo_ge501_jadlog

type variables
String is_objeto
String is_DataSource

String is_id_ecommerce

String is_usuario
String is_senha
String is_token
String is_url
String is_cd_centro_custo
String is_cd_unidade

String is_nr_pedido_ecommerce
String is_nr_pedido_drogaexpress
String is_conteudo
String is_tp_coleta

String is_codigo_jadlog
String is_codigo_rastreio

String is_remetente_cidade
String is_remetente_nome
String is_remetente_cnpj
String is_remetente_bairro
String is_remetente_endereco
String is_remetente_numero
String is_remetente_uf
String is_remetente_cep
String is_remetente_inscricao_estadual

String is_dest_nome
String is_dest_endereco
String is_dest_numero
String is_dest_compl
String is_dest_bairro
String is_dest_cidade
String is_dest_uf
String is_dest_cpf
String is_dest_cep
String is_dest_fone
String is_dest_email

String is_nf_cte
String is_nf_nr_doc
String is_nf_serie
String is_nf_valor
String is_nf_cfop
String is_nf_tp_documento

String is_volume_identificador[]

Decimal idc_peso_tot
Decimal idc_valor
Decimal idc_nf_valor
Decimal idc_volume_peso[]

Long il_cd_filial
Long il_cd_filial_ecommerce
Long il_nr_pedido_erp
Long il_cd_tipo_entrega
Long il_cd_modalidade

Long il_volume_altura[]
Long il_volume_comp[]
Long il_volume_largura[]
Long il_volume_codigo[]
Long il_nr_volumes

Boolean ib_usa_pdv_java=false

uo_transacao_online ivo_Conecta_Odbc
dc_uo_transacao itr_Filial
dc_uo_odbc ivo_Odbc

string is_ODBC_Desenv

uo_ge073_json iuo_json

end variables

forward prototypes
public function boolean of_carrega_parametros (ref string ps_log)
public function boolean of_envia_webservice (string ps_json, string ps_metodo, ref string ps_retorno, ref string ps_log)
public function boolean of_carrega_remetente (ref string ps_log)
public function boolean of_carrega_nota_fiscal (ref string ps_log)
public function boolean of_conecta_filial (ref string ps_log)
public function boolean of_desconecta_filial ()
public function boolean of_carrega_destinatario (ref string ps_log)
public function boolean of_carrega_volumes (ref string ps_log)
public function boolean of_cancelar (string ps_nr_pedido, ref string ps_log)
public function boolean of_monta_json_incluir (ref string ps_retorno, ref string ps_log)
public function boolean of_executar (string ps_tipo_acao, long pl_cd_filial, long pl_nr_pedido, ref string ps_log)
public function boolean of_retorno_incluir (string ps_json, ref string ps_log)
public function boolean of_carrega_dados_pedido (ref string ps_log)
public function boolean of_consulta_rastreio (string ps_codigo, ref dc_uo_ds_base pds_retorno, ref string ps_log)
public function boolean of_atualiza_pedido_ecommerce (string ps_codigo_jadlog, ref string ps_log)
public function boolean of_executar (string ps_tipo_acao, long pl_cd_filial, long pl_nr_pedido, ref dc_uo_ds_base pds_rastreio, ref string ps_log)
end prototypes

public function boolean of_carrega_parametros (ref string ps_log);
Try 
	
	select cd_tipo_entrega
	into :il_cd_tipo_entrega
	from tipo_entrega_ecommerce
	where id_tipo_entrega = 'JAD'
	and id_situacao = 'A';
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao consultar a tabela tipo_entrega_ecommerce: ' + sqlca.sqlerrtext
		return false
	End if
	
	if il_cd_tipo_entrega = 0 or isnull(il_cd_tipo_entrega) Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o tipo de entrega JADLOG ativo no banco de dados.'
		return false
	end if
	
	Select de_url,
			de_usuario,
			de_senha,
			cd_token_integracao,
			cd_centro_custo,
			de_reid,
			id_tipo_servico
	into :is_url,
			:is_usuario,
			:is_Senha,
			:is_token,
			:is_cd_centro_custo,
			:is_cd_unidade,
			:is_tp_coleta
	from ecommerce_hub_transp
	Where id_ecommerce = :is_id_ecommerce
		and cd_filial_hub = :il_cd_filial
		and cd_tipo_entrega = :il_cd_tipo_entrega;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao consultar a tabela ecommerce_hub_transp: ' + sqlca.sqlerrtext
		return false
	End if
	
	if isnull(is_url) or is_url = '' Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a URL de conex$$HEX1$$e300$$ENDHEX$$o com a Jadlog [Filial:' + string(il_cd_filial) + ' ].'
		return false
	end if
	if isnull(is_usuario) or is_usuario = '' Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o usu$$HEX1$$e100$$ENDHEX$$rio de conex$$HEX1$$e300$$ENDHEX$$o com a Jadlog [Filial:' + string(il_cd_filial) + ' ].'
		return false
	end if
	if isnull(is_Senha) or is_Senha = '' Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a senha de conex$$HEX1$$e300$$ENDHEX$$o com a Jadlog [Filial:' + string(il_cd_filial) + ' ].'
		return false
	end if
	if isnull(is_token) or is_token = '' Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o Token de conex$$HEX1$$e300$$ENDHEX$$o com a Jadlog [Filial:' + string(il_cd_filial) + ' ].'
		return false
	end if
	if isnull(is_cd_centro_custo) or is_cd_centro_custo = '' Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o Centro de Custo para conex$$HEX1$$e300$$ENDHEX$$o com a Jadlog [Filial:' + string(il_cd_filial) + ' ].'
		return false
	end if
	if isnull(is_cd_unidade) or is_cd_unidade = '' Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o c$$HEX1$$f300$$ENDHEX$$digo da unidade (de_reid) para conex$$HEX1$$e300$$ENDHEX$$o com a Jadlog [Filial:' + string(il_cd_filial) + ' ].'
		return false
	end if
	
	if isnull(is_tp_coleta) or is_tp_coleta = '' Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o tipo da coleta (id_tipo_servico) [Filial:' + string(il_cd_filial) + ' ].'
		return false
	ENd if
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_parametros - ' + ps_log
	
End Try

return true
end function

public function boolean of_envia_webservice (string ps_json, string ps_metodo, ref string ps_retorno, ref string ps_log);
Try
	
	Long ll_status_code
	String ls_status_text
	string ls_xml
		
	OleObject lole_SrvHTTP	
		
	IF Not IsValid(lole_SrvHTTP) THEN
		
		lole_SrvHTTP = CREATE oleobject
		lole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		
	End If
	
	lole_SrvHTTP.open ('POST', is_url + ps_metodo, false) 
	
	if Not IsValid(lole_SrvHTTP) THEN Return false
	
	lole_SrvHTTP.setRequestHeader("Content-Type", "application/json") 
	lole_SrvHTTP.setRequestHeader("Authorization", "Bearer " + is_token) 
	
	
	lole_SrvHTTP.send(ps_json) 
		
	//Get response 
	ls_status_text = lole_SrvHTTP.StatusText 
	ll_status_code = lole_SrvHTTP.Status 
	
	ps_retorno = String( lole_SrvHTTP.ResponseText )
	
	Choose Case ll_status_code
		
		Case 200
			//Tudo certo
			ps_log = ''
		
		Case 500
			//Erro - Tratamento de erro
			
			ps_log = ps_retorno
			
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
	
	if isvalid( lole_SrvHTTP ) then destroy( lole_SrvHTTP )
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_envia_webservice - ' + ps_log
	
ENd Try

return true

end function

public function boolean of_carrega_remetente (ref string ps_log);long ll_nr_endereco
String ls_id_sistema_novo

Try
	
	select f.nm_razao_social, 
			f.nr_cgc, 
			f.nr_cep,
			f.de_endereco,
			f.de_bairro,
			c.cd_unidade_federacao,
			c.nm_cidade,
			f.nr_endereco,
			f.id_sistema_novo,
			f.nr_inscricao_estadual
	into :is_remetente_nome, 
			:is_remetente_cnpj, 
			:is_remetente_cep,
			:is_remetente_endereco,
			:is_remetente_bairro,
			:is_remetente_uf,
			:is_remetente_cidade,
			:ll_nr_endereco,
			:ls_id_sistema_novo,
			:is_remetente_inscricao_estadual
	from filial f
			inner join cidade c on c.cd_cidade = f.cd_cidade
	where f.cd_filial = :il_cd_filial;

	if sqlca.sqlcode = -1 then 
		ps_log = 'Problemas ao consultar a tabela "filial": ' + sqlca.sqlerrtext
		return false
	end if

	if ls_id_sistema_novo = 'S' Then
		ib_usa_pdv_java = True
	Else
		ib_usa_pdv_java = False
	End if

	is_remetente_numero = string( ll_nr_endereco )
	
	if is_remetente_cnpj = '' or isnull(is_remetente_cnpj) Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o CNPJ da seguinte filial: ' + string(il_cd_filial) + '. '
		return false
	end if
	
	if is_remetente_cep = '' or isnull(is_remetente_cep) Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o CEP da seguinte filial: ' + string(il_cd_filial)
		return false
	end if
	
	if is_remetente_inscricao_estadual = '' or isnull(is_remetente_inscricao_estadual) Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o n$$HEX1$$fa00$$ENDHEX$$mero da inscri$$HEX2$$e700e300$$ENDHEX$$o estadual da seguinte filial: ' + string(il_cd_filial)
		return false
	end if
	
	is_remetente_inscricao_estadual = gf_replace(is_remetente_inscricao_estadual, '.', '',0)
	is_remetente_inscricao_estadual = gf_replace(is_remetente_inscricao_estadual, '-', '',0)
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_remetente - ' + ps_log 
	
ENd Try

return true
end function

public function boolean of_carrega_nota_fiscal (ref string ps_log);String ls_especie


Try
	
	if this.ib_usa_pdv_java = false Then
	
		//Conecta na filial e busca os dados da nota fiscal.
		if Not this.of_conecta_filial( ref ps_log ) Then return false
		
		Select	 p.qt_volume,
			 nv.vl_total_nf,
			 nv.nr_nf,
			 nvf.de_chave_acesso,
			 nv.de_serie,
			 nv.de_especie
		Into :il_nr_volumes,
			:idc_nf_valor,
			:is_nf_nr_doc,
			:is_nf_cte,
			:is_nf_serie,
			:ls_especie
		From pedido_drogaexpress p
			inner join nf_venda nv on ( nv.nr_pedido_drogaexpress = p.nr_pedido_drogaexpress ) 
			left join nf_venda_nfe nvf on ( nvf.cd_filial = nv.cd_filial
												and nvf.nr_nf = nv.nr_nf
												and nvf.de_especie = nv.de_especie
												and nvf.de_serie = nv.de_serie )
		Where p.nr_pedido_drogaexpress =:is_nr_pedido_drogaexpress
			and p.id_plataforma_ecommerce = :is_id_ecommerce
			and nv.dh_cancelamento is null
			and nv.dh_devolucao is null
			and nv.nr_nf_anexa is null
			limit 1
		Using itr_Filial;
		
		If itr_Filial.SqlCode = -1 Then
			ps_log = 'Problemas ao consultar a tabela "pedido_drogaexpress/nf_venda": ' + itr_filial.sqlerrtext
			Return False
		End If
		
//	Else
//		
//		Select top 1 p.qt_volume,
//			 nv.dh_emissao,
//			 nv.vl_total_nf,
//			 nv.nr_nf,
//			 nvf.de_chave_acesso,
//			 nv.de_serie,
//			 nv.vl_total_produtos
//		Into :il_volume_nf,
//			:idt_emissao_nf,
//			:idc_vl_total_nf,
//			:is_nr_nf,
//			:is_chave_nf,
//			:is_serie_nf,
//			:idc_vl_total_itens_nf
//		From pedido_ecommerce p
//			inner join nf_venda nv on ( nv.nr_pedido_ecommerce = p.nr_pedido ) 
//			left join nf_venda_nfe nvf on ( nvf.cd_filial = nv.cd_filial
//												and nvf.nr_nf = nv.nr_nf
//												and nvf.de_especie = nv.de_especie
//												and nvf.de_serie = nv.de_serie )
//		Where p.nr_pedido = :il_nr_pedido
//			and p.cd_filial_ecommerce = :il_cd_filial_pedido
//			and p.id_ecommerce = '2'
//			and nv.dh_cancelamento is null
//			and nv.dh_devolucao is null
//			and nv.nr_nf_anexa is null
//		Using SQLCA;
//		
//		If SQLCA.SqlCode = -1 Then
//			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_nota_fiscal. ' + 'Problemas ao consultar a tabela "pedido_ecommerce/nf_venda": ' + SQLCA.sqlerrtext
//			Return False
//		End If
		
	End if
	
	Choose Case ls_especie
		Case 'NFE'
			is_nf_tp_documento = '2'
	End Choose
	
	if isnull(il_nr_volumes) Then il_nr_volumes = 1
	
	if isnull(is_nf_cte) or is_nf_cte = '' Then 
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a Chave de Acesso da Nota Fiscal.'
		return false
	end if
	
Finally
	if this.ib_usa_pdv_java = false Then
		this.of_desconecta_filial( )
	End if
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_nota_fiscal - ' + ps_log
	
End Try

Return true
end function

public function boolean of_conecta_filial (ref string ps_log);String ls_Odbc

Try

	is_DataSource = gvo_Aplicacao.ivs_DataSource
	
	//
	if not isvalid(ivo_Odbc) then
		ivo_Odbc = Create dc_uo_odbc
	end if
	
	if not isvalid(itr_Filial) Then 
		itr_Filial	= Create dc_uo_Transacao
		itr_Filial.ivs_DataBase = 'ANYWHERE'
	end if
	
	if not isvalid(ivo_Conecta_Odbc) Then
		ivo_Conecta_Odbc = Create uo_transacao_online
	end if
	
	//Conectar na base da filial
	If Not IsNull(is_ODBC_Desenv) and Trim(is_ODBC_Desenv) <> ''  Then
		ls_Odbc =  is_ODBC_Desenv
	else
		ivo_Conecta_Odbc.of_inclui_odbc( il_cd_filial )
		ls_Odbc = ivo_Odbc.of_Localiza( il_cd_filial )
	end if
	
	If itr_Filial.of_IsConnected( ) Then
		itr_Filial.of_Disconnect( )
	End If
	
	if itr_Filial.of_Connect( ls_Odbc, gvo_aplicacao.is_ComputerName , false) = False Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string( il_cd_filial ) 
		return false
	end if

Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = is_objeto + ' - of_conecta_filial - ' + ps_log
	
ENd try

Return True
end function

public function boolean of_desconecta_filial ();if Not isvalid(itr_filial) Then return true

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

gvo_Aplicacao.ivs_DataSource = is_DataSource

return true
end function

public function boolean of_carrega_destinatario (ref string ps_log);long ll_nr_endereco

Try
	
	select nm_cliente, 
			nr_cpf_cgc , 
			de_endereco_ent, 
			nr_endereco_ent, 
			de_complemento_ent, 
			de_bairro_ent, 
			de_cidade_ent, 
			cd_uf_ent, 
			nr_cep_ent, 
			nr_fone_ent, 
			de_endereco_email,
			vl_subtotal,
			nr_pedido_ecommerce
	into :is_dest_nome, 
			:is_dest_cpf, 
			:is_dest_endereco,
			:is_dest_numero,
			:is_dest_compl,
			:is_dest_bairro,
			:is_dest_cidade,
			:is_dest_uf,
			:is_dest_cep,
			:is_dest_fone,
			:is_dest_email,
			:idc_valor,
			:is_nr_pedido_ecommerce
	from pedido_ecommerce p
	where p.cd_filial_ecommerce = :il_cd_filial_ecommerce
		and p.nr_pedido = :il_nr_pedido_erp;

	if sqlca.sqlcode = -1 then 
		ps_log = 'Problemas ao consultar a tabela "pedido_ecommerce": ' + sqlca.sqlerrtext
		return false
	end if

//	is_dest_numero = string( ll_nr_endereco )

	if isnull(is_dest_nome) then is_dest_nome = ''
	if isnull(is_dest_cpf) then is_dest_cpf = ''
	if isnull(is_dest_endereco) then is_dest_endereco = ''
	if isnull(is_dest_bairro) then is_dest_bairro = ''
	if isnull(is_dest_cidade) then is_dest_cidade = ''
	if isnull(is_dest_uf) then is_dest_uf = ''
	if isnull(is_dest_cep) then is_dest_cep = ''
	if isnull(is_dest_fone) then is_dest_fone = ''
	if isnull(is_dest_email) then is_dest_email = ''
	if isnull(is_dest_compl) then is_dest_compl = ''
	
	is_dest_compl = mid(is_dest_compl,1,40)
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_destinatario - ' + ps_log 
	
ENd Try

return true
end function

public function boolean of_carrega_volumes (ref string ps_log);Long ll_linhas
Long ll_for
Long ll_qt_pedida
Long ll_altura, ll_largura, ll_comprimento, ll_peso
Long ll_altura_tot, ll_largura_tot, ll_comprimento_tot, ll_peso_tot

dc_uo_ds_base lds_produtos

Try

	lds_produtos = create dc_uo_ds_base
	
	lds_produtos.of_changedataobject( 'ds_ge501_pedido_loja_produto' )
	
	ll_linhas = lds_produtos.retrieve( this.il_Cd_filial_ecommerce, this.il_nr_pedido_erp )
	
	if ll_linhas < 0 Then
		ps_log = 'Problemas ao carrega informa$$HEX1$$e700$$ENDHEX$$oes de volume: ' + sqlca.is_lasterrortext
		return false
	end if
	
	ll_altura_tot = 0
	ll_largura_tot = 0
	ll_comprimento_tot = 0
	ll_peso_tot = 0
	
	//Soma as dimensoes de todos os produtos:
	for ll_for = 1 to ll_linhas
		
		ll_qt_pedida = lds_produtos.object.qt_pedida[ll_for]
		
		ll_altura = lds_produtos.object.qt_altura_cm[ll_for] * ll_qt_pedida
		ll_largura = lds_produtos.object.qt_largura_cm[ll_for] * ll_qt_pedida
		ll_comprimento = lds_produtos.object.qt_profundidade_cm[ll_for] * ll_qt_pedida
		ll_peso = lds_produtos.object.qt_peso_grama[ll_for] * ll_qt_pedida
		
		if isnull(ll_altura) Then ll_altura = 0
		if isnull(ll_largura) Then ll_largura = 0
		if isnull(ll_comprimento) Then ll_comprimento = 0
		if isnull(ll_peso) Then ll_peso = 0
		
		ll_altura_tot += ll_altura
		ll_largura_tot += ll_largura
		ll_comprimento_tot += ll_comprimento
		ll_peso_tot += ll_peso
		
	Next

	if ll_altura_tot = 0 then ll_altura_tot = 1
	if ll_largura_tot = 0 then ll_largura_tot = 1
	if ll_comprimento_tot = 0 then ll_comprimento_tot = 1
	if ll_peso_tot = 0 then ll_peso_tot = 1

	for ll_for = 1 to il_nr_volumes
		
		this.is_volume_identificador[ll_for] = string(ll_for)
		
		this.il_volume_altura[ll_for] = long(ll_altura_tot/il_nr_volumes)
		this.il_volume_largura[ll_for] = long(ll_largura_tot/il_nr_volumes)
		this.il_volume_comp[ll_for] = long(ll_comprimento_tot/il_nr_volumes)
		
		//Transforma para Kg:
		this.idc_volume_peso[ll_for] = ll_peso_tot/1000
		
		this.idc_volume_peso[ll_for] = Round(this.idc_volume_peso[ll_for]/il_nr_volumes,1)
		
		if this.il_volume_altura[ll_for] > 999 then this.il_volume_altura[ll_for]  = 999
		if this.il_volume_largura[ll_for] > 999 then this.il_volume_largura[ll_for] = 999
		if this.il_volume_comp[ll_for] > 999 then this.il_volume_comp[ll_for] = 999
		if this.idc_volume_peso[ll_for] > 999 then this.idc_volume_peso[ll_for] = 999
		
	Next

Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = is_objeto  + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_volumes - ' + ps_log
	
ENd Try

return true
end function

public function boolean of_cancelar (string ps_nr_pedido, ref string ps_log);string ls_id_interface = '/pedido/cancelar'
string ls_json
string ls_retorno
string ls_status
string ls_json_erro
string ls_descricao
string ls_detalhe

Try
	
	if isnull(ps_nr_pedido) or ps_nr_pedido = '' then
		ps_log = 'Erro ao cancelar pedido Jadlog: C$$HEX1$$f300$$ENDHEX$$digo do pedido n$$HEX1$$e300$$ENDHEX$$o informado.'
		return false
	end if
	
	ls_json = '{"codigo": "' + ps_nr_pedido + '"}'
	
	If Not this.of_envia_webservice( ls_json, ls_id_interface, ref ls_retorno, ref ps_log ) Then return false
	
	ls_status = iuo_json.of_busca_conteudo_campo_vtex( ls_retorno, 'status')
	
	If ls_status = 'Cancelamento realizado com sucesso!' Then
		//Pedido cancelado, tudo ok.
		return true
	Else
		//Erro no cancelamento, retorno o erro:
		iuo_json.of_divide_grupo_json_tag_vtex(ref ls_retorno, 'erro', ref ls_json_erro, '}')

		ls_descricao = iuo_json.of_busca_conteudo_campo_vtex( ls_json_erro, 'descricao')
		ls_detalhe = iuo_json.of_busca_conteudo_campo_vtex( ls_json_erro, 'detalhe')
		
		ps_log = 'Erro ao cancelar pedido Jadlog: ' + ls_descricao + ' - ' + ls_detalhe
		return false
	ENd if

Finally
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_cancelar - ' + ps_log 
End Try

return true
end function

public function boolean of_monta_json_incluir (ref string ps_retorno, ref string ps_log);string ls_json

Try

	if isnull(is_nf_cfop) Then is_nf_cfop = ''

	ls_json = '{'
	
	ls_json += '"conteudo": "' + is_conteudo + '", '
	ls_json += '"pedido": ["'+ is_nr_pedido_ecommerce + '"], '
	ls_json += '"totPeso": ' + gf_valor_com_ponto( idc_peso_tot) + ', '
	ls_json += '"totValor": ' + gf_valor_com_ponto( idc_valor) + ', '
	ls_json += '"modalidade": ' + string (il_cd_modalidade) + ', '
	ls_json += '"contaCorrente": "' + is_cd_centro_custo + '", '
	ls_json += '"cdUnidadeOri": "' + is_cd_unidade + '", '
	ls_json += '"tpColeta": "' + is_tp_coleta + '", '
	ls_json += '"nrContrato": null, '
	ls_json += '"servico": 0, '
	ls_json += '"tipoFrete": 0, '
	ls_json += '"obs": "", '
	ls_json += '"cdUnidadeDes": null, '
	ls_json += '"cdPickupOri": null, '
	ls_json += '"cdPickupDes": null, '
	ls_json += '"shipmentId": null, '
	ls_json += '"vlColeta": null, '
	
	
	//REMETENTE
	ls_json += '"rem": {'
	ls_json += '"nome": "' + is_remetente_nome + '", '
	ls_json += '"cnpjCpf": "' + is_remetente_cnpj + '", '
	ls_json += '"ie": "' + is_remetente_inscricao_estadual + '", '
	ls_json += '"endereco": "'+ is_remetente_endereco + '", '
	ls_json += '"bairro": "' + is_remetente_bairro + '", '
	ls_json += '"cidade": "' + is_remetente_cidade + '", '
	ls_json += '"uf": "' + is_remetente_uf + '", '
	ls_json += '"cep": "' + is_remetente_cep + '" '
	ls_json += '}, '
	
	//DESTINATARIO
	ls_json += '"des": {' 
	ls_json += '"nome": "' + is_dest_nome + '", '
	ls_json += '"cnpjCpf": "' + is_dest_cpf + '", '
	ls_json += '"endereco": "' + is_dest_endereco + '", '
	ls_json += '"numero": "' + is_dest_numero + '", '
	ls_json += '"compl": "' + is_dest_compl + '", '
	ls_json += '"bairro": "' + is_dest_bairro + '", '
	ls_json += '"cidade": "' + is_dest_cidade + '", '
	ls_json += '"uf": "' + is_dest_uf + '", '
	ls_json += '"cep": "' + is_dest_cep + '", '
	ls_json += '"fone": "' + is_dest_fone + '", '
	ls_json += '"cel": "' + is_dest_fone + '", '
	ls_json += '"email": "' + is_dest_email + '" '
	ls_json += '}, '
	
	//NOTA FISCAL
	ls_json += '"dfe": [{'
	ls_json += '"danfeCte": "' + is_nf_cte + '", '
	ls_json += '"nrDoc": "' + is_nf_nr_doc + '", '
	ls_json += '"serie": "' + is_nf_serie + '", '
	ls_json += '"valor": ' + gf_valor_com_ponto( idc_nf_valor ) + ', '
	ls_json += '"cfop": "' + is_nf_cfop + '", '
	ls_json += '"tpDocumento": ' + is_nf_tp_documento 
	ls_json += '}], '
	
	//VOLUMES
	ls_json += '"volume": [{'
	ls_json += '"altura": ' + String( il_volume_altura[1] ) + ', '
	ls_json += '"comprimento": ' + String( il_volume_comp[1] ) + ', '
	ls_json += '"largura": ' + String( il_volume_largura[1] ) + ', '
	ls_json += '"peso": ' + gf_valor_com_ponto( idc_volume_peso[1] ) + ', '
	ls_json += '"identificador": "' + is_volume_identificador[1] + '" '
	ls_json += '}] '
	
	ls_json += '}'
	
	if ls_json = '' or isnull(ls_json) Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel montar o JSON de envio do pedido para Jadlog.'
		return false
	ENd if

	ps_retorno = ls_json

Finally
	
	if ps_log<>'' and not isnull(ps_log) Then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_monta_json_pedido - ' + ps_log
	
End Try

return true



end function

public function boolean of_executar (string ps_tipo_acao, long pl_cd_filial, long pl_nr_pedido, ref string ps_log);dc_uo_ds_base lds_datastore

return this.of_executar( ps_tipo_acao, pl_cd_filial, pl_nr_pedido, ref lds_datastore, ref ps_log)
end function

public function boolean of_retorno_incluir (string ps_json, ref string ps_log);String ls_codigo
String ls_id
String ls_status
String ls_json_erro
String ls_descricao
String ls_detalhe

Try 
	
	//ls_id = iuo_json.of_busca_conteudo_campo_vtex( ps_json, 'shipmentId')
	ls_status = iuo_json.of_busca_conteudo_campo_vtex( ps_json, 'status')
	
	if ls_status = 'Solicitacao inserida com sucesso.' Then
		
		//{"codigo":"227029687","shipmentId":"11052300000000","status":"Solicitacao inserida com sucesso."}
		is_codigo_jadlog = iuo_json.of_busca_conteudo_campo_vtex( ps_json, 'codigo')
		is_codigo_rastreio = iuo_json.of_busca_conteudo_campo_vtex( ps_json, 'shipmentId')
		
		if isnull(is_codigo_jadlog) or is_codigo_jadlog = '' Then
			ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o c$$HEX1$$f300$$ENDHEX$$digo Jadlog criado para o pedido.'
			return false
		ENd if
		
		return true
		
	ELse
		
		//Erro na inclusao do pedido:
		iuo_json.of_divide_grupo_json_tag_vtex(ref ps_json, 'erro', ref ls_json_erro, '}')

		ls_descricao = iuo_json.of_busca_conteudo_campo_vtex( ls_json_erro, 'descricao')
		ls_detalhe = iuo_json.of_busca_conteudo_campo_vtex( ls_json_erro, 'detalhe')
		
		if isnull(ls_descricao) Then ls_descricao = ''
		if isnull(ls_detalhe) Then ls_detalhe = ''
		
		ps_log = 'Erro ao incluir pedido Jadlog: ' + ls_descricao + ' - ' + ls_detalhe
		return false	
		
	ENd if
	
CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_retorno_incluir - ' + ps_log
	
End Try

return true
end function

public function boolean of_carrega_dados_pedido (ref string ps_log);

try
	
	select pe.cd_filial, pe.nr_pedido_ecommerce, pe.id_ecommerce, pe.nr_pedido_drogaexpress, pa.id_pedido_equilibrium
	into :il_cd_filial, :is_nr_pedido_ecommerce, :is_id_ecommerce, :is_nr_pedido_drogaexpress, :is_codigo_jadlog
	from pedido_ecommerce pe
		inner join pedido_ecommerce_auxiliar pa on pa.cd_filial_ecommerce = pe.cd_filial_ecommerce
															and pa.nr_pedido = pe.nr_pedido
	where pe.cd_filial_ecommerce = :il_cd_filial_ecommerce
		and pe.nr_pedido = :il_nr_pedido_erp;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao consultar a tabela pedido_ecommerce: ' + sqlca.sqlerrtext
			return false
		ENd if
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_pedido - ' + ps_log
	
End Try

return true
end function

public function boolean of_consulta_rastreio (string ps_codigo, ref dc_uo_ds_base pds_retorno, ref string ps_log);string ls_id_interface = '/tracking/consultar'
string ls_json
string ls_retorno
string ls_json_eventos, ls_json_erro
string ls_descricao
string ls_erro
string ls_data
string ls_status
string ls_unidade
datetime ldh_status

Try
	
	pds_retorno.reset()
	
	ls_json = '{"consulta": [ { "codigo":"' + ps_codigo + '"} ]}'
	
	If Not this.of_envia_webservice( ls_json, ls_id_interface, ref ls_retorno, ref ps_log ) Then return false
	
	ls_erro = iuo_json.of_busca_conteudo_campo_vtex( ls_retorno, 'error')
	
	If ls_erro <> '' and not isnull(ls_erro) and ls_erro <> 'NULO'  Then
		//Pedido com erro
		//Erro no cancelamento, retorno o erro:
		iuo_json.of_divide_grupo_json_tag_vtex(ref ls_retorno, 'error', ref ls_json_erro, '}')

		ls_descricao = iuo_json.of_busca_conteudo_campo_vtex( ls_json_erro, 'descricao')
		
		ps_log = 'Erro ao consultar codigo de rastreio: codigo[' + ps_codigo + '] - ' + ls_descricao
		return false
	Else
		
		iuo_json.of_divide_grupo_json_tag_vtex(ref ls_retorno, 'eventos', ref ls_json_eventos, ']')

		Do While iuo_json.of_divide_grupo_json_completo(Ref ls_json_eventos, Ref ls_retorno,'{') 
			
			ls_data = iuo_json.of_busca_conteudo_campo_vtex( ls_retorno, 'data')
			ls_status = iuo_json.of_busca_conteudo_campo_vtex( ls_retorno, 'status')
			ls_unidade = iuo_json.of_busca_conteudo_campo_vtex( ls_retorno, 'unidade')
		
			ldh_status = Datetime(date( left(ls_data,10) ), time( mid(ls_data, 12, 10) ) )
		
			pds_retorno.insertrow(1)
			
			pds_retorno.object.dh_status[1] = ldh_status
			pds_retorno.object.de_status[1] = ls_status
			pds_retorno.object.de_local[1] = ls_unidade

		Loop
		
		return True
	ENd if

Finally
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_rastreio - ' + ps_log 
End Try

return true
end function

public function boolean of_atualiza_pedido_ecommerce (string ps_codigo_jadlog, ref string ps_log);boolean lb_sucesso = false

Try

	Update pedido_ecommerce_auxiliar
	set id_pedido_equilibrium = :ps_codigo_jadlog
	where cd_filial_ecommerce = :il_cd_filial_ecommerce
		and nr_pedido = :il_nr_pedido_erp;
		
	If sqlca.sqlcode = -1 then
		ps_log = 'Erro ao atualizar tabela pedido_ecommerce_auxiliar: ' + sqlca.sqlerrtext
		return false
	ENd if
	
	lb_sucesso = True
	
CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false
	
Finally
	
	if lb_sucesso = True Then
		if Not gf_ge501_commit(SQLCA) then return false
	Else
		if Not gf_ge501_rollback(SQLCA) then return false
	End if
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido_ecommerce - ' + ps_log
	
	
	
End Try



return true
end function

public function boolean of_executar (string ps_tipo_acao, long pl_cd_filial, long pl_nr_pedido, ref dc_uo_ds_base pds_rastreio, ref string ps_log);String ls_json
string ls_retorno

Try

	if not isvalid(iuo_json) Then iuo_json = create uo_ge073_json

	il_cd_filial_ecommerce = pl_cd_filial
	il_nr_pedido_erp = pl_nr_pedido

	if Not this.of_carrega_dados_pedido( ref ps_log ) then return false

	If Not this.of_carrega_parametros( ref ps_log ) then return false
	
	Choose Case upper(ps_tipo_acao)
		
		Case 'RASTREIO'
			
			If Not this.of_consulta_rastreio( is_codigo_jadlog, ref pds_rastreio, ref ps_log ) Then return false
		
		Case 'CANCELAR'
			
			If not this.of_cancelar( is_codigo_jadlog, ref ps_log ) Then return false
			
		CAse 'INCLUIR'
			
			is_conteudo = 'PRODUTOS FARM$$HEX1$$c100$$ENDHEX$$CIA'
			il_cd_modalidade = 3
			
			If Not this.of_carrega_remetente( ref ps_log ) then return false
			
			If Not this.of_carrega_destinatario( ref ps_log ) then return false

			If Not this.of_carrega_nota_fiscal( ref ps_log ) then return false
			
			If Not this.of_carrega_volumes( ref ps_log ) then return false
			
			If Not this.of_monta_json_incluir( ref ls_json, ref ps_log ) then return false
			
			if Not this.of_envia_webservice( ls_json, '/pedido/incluir', ref ls_retorno, ref ps_log ) then return false
			
			if Not this.of_retorno_incluir( ls_retorno, ref ps_log ) Then return false
			
			If Not this.of_atualiza_pedido_ecommerce( is_codigo_jadlog, ref ps_log ) Then return false
			
		CAse Else
			
	ENd CHoose

Finally
	
End Try

return true
end function

on uo_ge501_jadlog.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_jadlog.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname( )
end event

