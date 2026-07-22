HA$PBExportHeader$uo_ge509_contratacao.sru
forward
global type uo_ge509_contratacao from nonvisualobject
end type
end forward

global type uo_ge509_contratacao from nonvisualobject
end type
global uo_ge509_contratacao uo_ge509_contratacao

type variables
string is_objeto
string is_url_interface = 'https://integracao.equilibriumsc.com/api/v1/pedidoContratacao'

string is_nm_cliente
string is_de_email
string is_id_oferta
string is_cpf_cliente
string is_nr_fone
string is_nr_endereco
string is_complemento
string is_logradouro
string is_bairro
string is_nr_pedido_ecommerce
string is_nr_nf
string is_serie_nf
string is_chave_nf

datetime idt_compra
datetime idt_emissao_nf

boolean ib_usa_pdv_java = false

uo_transacao_online ivo_Conecta_Odbc
dc_uo_transacao itr_Filial
dc_uo_odbc ivo_Odbc

string is_DataSource
string is_ODBC_Desenv

long il_cd_filial_pedido
long il_cd_filial_seller
long il_volume_nf
long il_Filial_Desenv
long il_nr_pedido

decimal idc_vl_total_nf
decimal idc_vl_total_itens_nf
end variables

forward prototypes
public function boolean of_conecta_filial (ref string ps_log)
public function boolean of_desconecta_filial ()
public function boolean of_busca_nota_fiscal (ref string ps_log)
public function boolean of_monta_json (ref string ps_json, ref string ps_log)
public function boolean of_grava_pedido (long pl_cd_filial, long pl_nr_pedido, string ps_id_pedido, string ps_url_rastreio, ref string ps_log)
public function boolean of_processa_contratacao (long pl_cd_filial, long pl_cd_seller, long pl_nr_pedido, string ps_id_oferta_cotacao, ref string ps_id_pedido, ref string ps_url_rastreio, ref string ps_log)
public function boolean of_retorno (string ps_json, string ps_tipo, ref string ps_id_pedido, ref string ps_url_rastreio, ref string ps_log)
end prototypes

public function boolean of_conecta_filial (ref string ps_log);String ls_Odbc

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
	ivo_Conecta_Odbc.of_inclui_odbc( il_cd_filial_seller )
	ls_Odbc = ivo_Odbc.of_Localiza( il_cd_filial_seller )
end if

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

if itr_Filial.of_Connect( ls_Odbc, gvo_aplicacao.is_ComputerName , false) = False Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(il_cd_filial_seller) 
	return false
end if

Return True
end function

public function boolean of_desconecta_filial ();if Not isvalid(itr_filial) Then return true

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

gvo_Aplicacao.ivs_DataSource = is_DataSource

return true
end function

public function boolean of_busca_nota_fiscal (ref string ps_log);
Try
	
	if this.ib_usa_pdv_java = false Then
	
		//Conecta na filial e busca os dados da nota fiscal.
		if Not this.of_conecta_filial( ref ps_log ) Then return false
		
		Select	 p.qt_volume,
			 nv.dh_emissao,
			 nv.vl_total_nf,
			 nv.nr_nf,
			 nvf.de_chave_acesso,
			 nv.de_serie,
			 nv.vl_total_produtos
		Into :il_volume_nf,
			:idt_emissao_nf,
			:idc_vl_total_nf,
			:is_nr_nf,
			:is_chave_nf,
			:is_serie_nf,
			:idc_vl_total_itens_nf
		From pedido_drogaexpress p
			inner join nf_venda nv on ( nv.nr_pedido_drogaexpress = p.nr_pedido_drogaexpress ) 
			left join nf_venda_nfe nvf on ( nvf.cd_filial = nv.cd_filial
												and nvf.nr_nf = nv.nr_nf
												and nvf.de_especie = nv.de_especie
												and nvf.de_serie = nv.de_serie )
		Where p.nr_pedido_ecommerce_site =:is_nr_pedido_ecommerce
			and p.id_plataforma_ecommerce = '2'
			and nv.dh_cancelamento is null
			and nv.dh_devolucao is null
			and nv.nr_nf_anexa is null
			limit 1
		Using itr_Filial;
		
		If itr_Filial.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_nota_fiscal. ' + 'Problemas ao consultar a tabela "pedido_drogaexpress/nf_venda": ' + itr_filial.sqlerrtext
			Return False
		End If
		
	Else
		
		Select top 1 p.qt_volume,
			 nv.dh_emissao,
			 nv.vl_total_nf,
			 nv.nr_nf,
			 nvf.de_chave_acesso,
			 nv.de_serie,
			 nv.vl_total_produtos
		Into :il_volume_nf,
			:idt_emissao_nf,
			:idc_vl_total_nf,
			:is_nr_nf,
			:is_chave_nf,
			:is_serie_nf,
			:idc_vl_total_itens_nf
		From pedido_ecommerce p
			inner join nf_venda nv on ( nv.nr_pedido_ecommerce = p.nr_pedido ) 
			left join nf_venda_nfe nvf on ( nvf.cd_filial = nv.cd_filial
												and nvf.nr_nf = nv.nr_nf
												and nvf.de_especie = nv.de_especie
												and nvf.de_serie = nv.de_serie )
		Where p.nr_pedido = :il_nr_pedido
			and p.cd_filial_ecommerce = :il_cd_filial_pedido
			and p.id_ecommerce = '2'
			and nv.dh_cancelamento is null
			and nv.dh_devolucao is null
			and nv.nr_nf_anexa is null
		Using SQLCA;
		
		If SQLCA.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_nota_fiscal. ' + 'Problemas ao consultar a tabela "pedido_ecommerce/nf_venda": ' + SQLCA.sqlerrtext
			Return False
		End If
		
	End if
	
	if isnull(is_chave_nf) or is_chave_nf = '' Then 
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_nota_fiscal. ' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a Chave de Acesso da Nota Fiscal.'
		return false
	end if

	if isnull(il_volume_nf) Then il_volume_nf = 1
	
Finally
	if this.ib_usa_pdv_java = false Then
		this.of_desconecta_filial( )
	End if
End Try

Return true
end function

public function boolean of_monta_json (ref string ps_json, ref string ps_log);	
ps_json = '{' 

ps_json += '"idOferta": ' + is_id_oferta + ', '
ps_json += '"nomeDestinatario": "' + is_nm_cliente + '", '
ps_json += '"emailDestinatario": "' + is_de_email + '", '
ps_json += '"telefoneDestinatario": "' + is_nr_fone + '", '
ps_json += '"cpfCnpjDestinatario": "' + is_cpf_cliente + '", '
ps_json += '"inscricaoEstadualDestinatario": "ISENTO", '
ps_json += '"numeroImovelEntrega": "' + is_nr_endereco + '", '
ps_json += '"logradouroDestinatario": "' + is_logradouro + '", '
ps_json += '"bairroDestinatario": "' + is_bairro + '", '
ps_json += '"complemento": "' + is_complemento + '", '
ps_json += '"pedidoExpedidor": "' + is_nr_pedido_ecommerce + '", '
ps_json += '"dataCompra": "' + string(idt_compra, 'yyyy-mm-dd') + 'T' + String(idt_compra, 'hh:mm:ss') + '", '
ps_json += '"previsaoEntrega": "", '
ps_json += '"canalVenda": "ECOMMERCE", '
ps_json += '"contratacaoAutomatica": true, '
ps_json += '"notasFiscais": ['
	
ps_json += '{'
ps_json += '"numero": "' + is_nr_nf + '", '
ps_json += '"serie": "' + is_serie_nf + '", '
ps_json += '"chave": "' + is_chave_nf + '", '
ps_json += '"volumes": ' + string(il_volume_nf) + ', '
ps_json += '"valorTotal": ' + gf_valor_com_ponto(idc_vl_total_nf) + ', '
ps_json += '"valorItens": ' + gf_valor_com_ponto(idc_vl_total_itens_nf) + ', '
ps_json += '"dataEmissao": "' + string(idt_emissao_nf, 'yyyy-mm-dd') + 'T' + String(idt_emissao_nf, 'hh:mm:ss') + '" '
ps_json += '}]'	
ps_json += '}'

if isnull(ps_json) or ps_json = '' Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel montar o arquivo JSON para a integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - Contrata$$HEX2$$e700e300$$ENDHEX$$o.'
	return false
end if

return true
end function

public function boolean of_grava_pedido (long pl_cd_filial, long pl_nr_pedido, string ps_id_pedido, string ps_url_rastreio, ref string ps_log);boolean lb_sucesso = false
dc_uo_transacao lo_SqlCa

Try

	//Usa uma nova conex$$HEX1$$e300$$ENDHEX$$o pra gravar o ID do pedido.
	lo_SqlCa	= create dc_uo_transacao
	lo_SqlCa.ivs_database = SQLCA.ivs_database
		
	If lo_SqlCa.of_Connect(SQLCA.of_get_datasource(), SQLCA.of_get_hostname() ) Then
	
		update pedido_ecommerce_auxiliar
		set id_pedido_equilibrium = :ps_id_pedido
		Where cd_filial_ecommerce = :pl_cd_filial
			and nr_pedido = :pl_nr_pedido
		Using lo_SqlCa;
					
		if lo_SqlCa.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ; Problemas ao atualizar registro na tabela "pedido_ecommerce_auxiliar": ' + lo_SqlCa.sqlerrtext
			return false
		end if
	
		update pedido_ecommerce
		set de_url_rastreio = :ps_url_rastreio
		Where cd_filial_ecommerce = :pl_cd_filial
			and nr_pedido = :pl_nr_pedido
		Using lo_SqlCa;
					
		if lo_SqlCa.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ; Problemas ao atualizar registro na tabela "pedido_ecommerce": ' + lo_SqlCa.sqlerrtext
			return false
		end if
	
		lo_SqlCa.of_Commit()
		
		lb_sucesso = True
		
	End If	 
	
Finally
	
	if lb_sucesso = false then
		lo_SqlCa.of_rollback( )
	end if
	
	lo_SqlCa.of_disconnect( )
	
	destroy(lo_SqlCa)
	
End Try

return true

end function

public function boolean of_processa_contratacao (long pl_cd_filial, long pl_cd_seller, long pl_nr_pedido, string ps_id_oferta_cotacao, ref string ps_id_pedido, ref string ps_url_rastreio, ref string ps_log);string ls_json
string ls_retorno
string ls_id_oferta
string ls_id_pedido
string ls_rastreio

long ll_cd_produto
long ll_linhas
long ll_for

uo_ge509_comum luo_comum
dc_uo_ds_base lds_pedido


try 

	luo_comum = create uo_ge509_comum

	//Desenvolvimento
	il_Filial_Desenv = luo_comum.of_desenvolvimento_filial_baixa_pedido()
	is_ODBC_Desenv = luo_comum.of_desenvolvimento_odbc_baixa_pedido()

	if il_filial_desenv > 0 Then
		il_cd_filial_pedido = il_filial_desenv
		il_cd_filial_seller = il_filial_desenv
	else
		il_cd_filial_pedido = pl_cd_filial
		il_cd_filial_seller = pl_cd_seller
	end if

	is_id_oferta = ps_id_oferta_cotacao
	il_nr_pedido = pl_nr_pedido
	
	if Not gf_retorna_loja_pdv_novo(il_cd_filial_seller, ref ib_usa_pdv_java, ref ps_log ) then return false

	lds_pedido = create dc_uo_ds_base
	
	if not lds_pedido.of_changedataobject( 'ds_ge509_pedido_contratacao' , false) Then
		ps_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_contratacao ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge509_pedido_contratacao'
		return false
	end if

	ll_linhas = lds_pedido.retrieve(  pl_cd_filial, pl_nr_pedido )

	if ll_linhas < 0 Then
		ps_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_contratacao ~n' + 'Problemas ao consultar a seguinte datawindow: ds_ge509_pedido_contratacao. ' + sqlca.is_lasterrortext
		return false
	end if
	
	for ll_for = 1 to ll_linhas
		
		is_nm_cliente = lds_pedido.object.nm_cliente[ll_for]
		is_de_email = lds_pedido.object.de_endereco_email[ll_for]
		
		is_cpf_cliente = lds_pedido.object.nr_cpf_cgc[ll_for]
		is_nr_fone = lds_pedido.object.nr_fone_ent[ll_for]
		is_nr_endereco = lds_pedido.object.nr_endereco_ent[ll_for]
		is_complemento = lds_pedido.object.de_complemento_ent[ll_for]
		is_logradouro = lds_pedido.object.de_endereco_ent[ll_for]
		is_bairro = lds_pedido.object.de_bairro_ent[ll_for]
		is_nr_pedido_ecommerce = lds_pedido.object.nr_pedido_ecommerce[ll_for]
		
		idt_compra = lds_pedido.object.dh_compra[ll_for]
		
		if isnull(is_complemento) Then is_complemento = ''
		if isnull(is_nr_endereco) Then is_nr_endereco = ''
		if isnull(is_logradouro) Then is_logradouro = ''
		if isnull(is_bairro) Then is_bairro = ''
		
		if Not this.of_busca_nota_fiscal( ref ps_log ) Then return false
		
		if Not this.of_monta_json( ref ls_json, ref ps_log ) Then return false
			
	next
	
	luo_comum.of_post(ls_json , is_url_interface, ls_retorno, ref ps_Log )
		
	if ps_Log <> '' and not isnull(ps_Log) Then
		//Busca no json de retorno do webservice o numero do pedido e o link de rastreio 
		If Not this.of_retorno( ps_Log, 'E', ref ls_id_pedido, ref ls_rastreio, ref ps_log ) Then return false
		ps_log = ''
	else
		//Busca no json de retorno do webservice o numero do pedido e o link de rastreio 
		If Not this.of_retorno( ls_retorno, 'A', ref ls_id_pedido, ref ls_rastreio, ref ps_log ) Then return false
	
	end if
	
	//Atualiza a tabela de pedido ecommerce com o ID do pedido da Equilibrium
	If Not this.of_grava_pedido( pl_Cd_filial, pl_nr_pedido, ls_id_pedido, ls_rastreio, ref ps_log ) Then return false
	
	ps_id_pedido = ls_id_pedido
	ps_url_rastreio = ls_rastreio
	
Finally
		
	if ps_log <> '' and not isnull(ps_log) Then
		ps_log = 'Equilibrium: of_processa_contratacao - ' + ps_log
	end if
		
	destroy(lds_pedido)
	destroy(luo_comum)
	
End try

return true
end function

public function boolean of_retorno (string ps_json, string ps_tipo, ref string ps_id_pedido, ref string ps_url_rastreio, ref string ps_log);string ls_mensagem

uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 
	
if ps_tipo = 'E'	Then
	ls_mensagem = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'title')
	
	if pos(ls_mensagem, 'Pedido informado j$$HEX1$$e100$$ENDHEX$$ contratado') = 0 Then 
		ps_log = ps_json
		return false
	else
		ps_id_pedido = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'idPedido\')
		ps_url_rastreio = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'rastreio\')
		
		//Tira o primeiro e o ultimo caracter:
		ps_url_rastreio = Mid(ps_url_rastreio, 2, len(ps_url_rastreio) - 2)
		
	end if
	
else
	
	ps_id_pedido = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'idPedido')
	
	ps_url_rastreio = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'rastreio')
	
ENd if

return true
end function

on uo_ge509_contratacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge509_contratacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - ' + 'Objeto: ' + this.classname() + ' - '
end event

