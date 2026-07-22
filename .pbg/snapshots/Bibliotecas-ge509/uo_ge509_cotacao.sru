HA$PBExportHeader$uo_ge509_cotacao.sru
forward
global type uo_ge509_cotacao from nonvisualobject
end type
end forward

global type uo_ge509_cotacao from nonvisualobject
end type
global uo_ge509_cotacao uo_ge509_cotacao

type variables
string is_objeto
string is_url_interface = 'https://integracao.equilibriumsc.com/api/v1/pedidoCotacao'

long il_cd_produto
long il_quantidade
long il_cd_filial
long il_cd_filial_loja
long il_nr_pedido
long il_nr_dias_entrega

decimal idc_altura
decimal idc_largura
decimal idc_comprimento
decimal idc_peso
decimal idc_preco
decimal idc_valor

datetime idh_validade

string is_tipo_pessoa
string is_cep_cliente
string is_id_oferta
string is_nm_transportadora
string is_cnpj
string is_cd_transportadora
string is_cgc_filial
string is_cep_filial
string is_descricao_internet
string is_tipo_produto
string is_tipo_entrega


end variables

forward prototypes
public function boolean of_monta_json (string ps_tipo, ref string ps_json, ref string ps_log)
public function boolean of_busca_dados_filial (long pl_cd_filial, ref string ps_log)
public function boolean of_grava_oferta (ref string ps_log)
public function boolean of_retorno (string ps_json, ref string ps_log)
public function boolean of_processa_cotacao (long pl_cd_filial, long pl_nr_pedido, string ps_tipo_entrega, ref string ps_id_oferta_cotacao, ref string ps_nm_transportadora, ref datetime pdh_validade, ref string ps_log)
end prototypes

public function boolean of_monta_json (string ps_tipo, ref string ps_json, ref string ps_log);//is_cep_cliente = '88131400'
//is_cep_filial = '88130301'
//is_cgc_filial = '84683481007503'

if ps_tipo = 'CAB' then
	
	ps_json = '{' 
	
	ps_json += '"cotacao": false, '
	
	ps_json += '"expedidorCnpj": "' + is_cgc_filial + '", '
	
	ps_json += '"expedidorCep": "' + is_cep_filial + '", '
	ps_json += '"tipoPessoa": ' + is_tipo_pessoa + ', '
	ps_json += '"tipoPedido": 1, '
	ps_json += '"destinoCep": "' + is_cep_cliente + '", '
	ps_json += '"canalVenda": "ECOMMERCE", '
	ps_json += '"filtro": ' + is_tipo_entrega + ','
	ps_json += '"formaPagamento": 1, '
	ps_json += '"volumes": [ '

Else

	ps_json += '{'
	ps_json += '"tipo": ' + is_tipo_produto + ', '
	ps_json += '"sku": "' + string(il_cd_produto) + '", '
	ps_json += '"descricao": "' + is_descricao_internet + '", '
	ps_json += '"quantidade": ' + string(il_quantidade) + ', '
	ps_json += '"altura": ' + gf_valor_com_ponto(idc_altura) + ', '
	ps_json += '"largura": ' + gf_valor_com_ponto(idc_largura) + ', '
	ps_json += '"comprimento": ' + gf_valor_com_ponto(idc_comprimento) + ', '
	ps_json += '"peso": ' + gf_valor_com_ponto(idc_peso) + ', '
	ps_json += '"valor": ' + gf_valor_com_ponto(idc_preco) + ', '
	
	ps_json += '"volumesProduto": 1' 
	
	ps_json += '}'	
	
end if


if isnull(ps_json) or ps_json = '' Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel montar o arquivo JSON para a integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - Cota$$HEX2$$e700e300$$ENDHEX$$o.'
	return false
end if

return true
end function

public function boolean of_busca_dados_filial (long pl_cd_filial, ref string ps_log);boolean lb_retorno = true

select nr_cgc, nr_cep
into :is_cgc_filial, :is_cep_filial
from filial
where cd_filial = :pl_cd_filial;

if sqlca.sqlcode = -1 then 
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_dados_filial ; Problemas ao consultar a tabela "filial": ' + sqlca.sqlerrtext
	return false
end if

ps_log = ''

if is_cgc_filial = '' or isnull(is_cgc_filial) Then
	ps_log += 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o CNPJ da seguinte filial: ' + string(pl_cd_filial) + '. '
	lb_retorno = false
end if

if is_cep_filial = '' or isnull(is_cep_filial) Then
	ps_log += 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o CEP da seguinte filial: ' + string(pl_cd_filial)
	lb_retorno = false
end if

return lb_retorno
end function

public function boolean of_grava_oferta (ref string ps_log);long ll_sequencial
boolean lb_sucesso = false
dc_uo_transacao lo_SqlCa

Try

	//Usa uma nova conex$$HEX1$$e300$$ENDHEX$$o pra gravar a cota$$HEX2$$e700e300$$ENDHEX$$o.
	lo_SqlCa	= create dc_uo_transacao
	lo_SqlCa.ivs_database = SQLCA.ivs_database
		
	If lo_SqlCa.of_Connect(SQLCA.of_get_datasource(), SQLCA.of_get_hostname() ) Then
	
		Select max(nr_sequencial)
		into :ll_sequencial
		from pedido_ecommerce_entrega
		where cd_filial_ecommerce = :il_cd_filial
		and nr_pedido = :il_nr_pedido
		Using lo_SqlCa;
		
		if lo_SqlCa.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_oferta ; Problemas ao consultar a tabela "pedido_ecommerce_entrega": ' + lo_SqlCa.sqlerrtext
			return false
		end if
		
		if ll_sequencial = 0 or isnull(ll_sequencial) Then
			ll_sequencial = 1
		else
			ll_sequencial ++
		end if
		
		Insert into pedido_ecommerce_entrega( cd_filial_ecommerce,
																nr_pedido,
																nr_sequencial,
																cd_oferta,
																nm_transportadora,
																nr_cnpj,
																vl_entrega,
																nr_dias_entrega,
																dh_validade,
																cd_transportadora)
		values( :il_cd_filial,
					:il_nr_pedido,
					:ll_sequencial,
					:is_id_oferta,
					:is_nm_transportadora,
					:is_cnpj,
					:idc_valor,
					:il_nr_dias_entrega,
					:idh_validade,
					:is_cd_transportadora)
		Using lo_SqlCa;
					
		if lo_SqlCa.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_oferta ; Problemas ao inserir registro na tabela "pedido_ecommerce_entrega": ' + lo_SqlCa.sqlerrtext
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

public function boolean of_retorno (string ps_json, ref string ps_log);

uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 

is_id_oferta = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'idOferta')
is_nm_transportadora = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'transportadora')
is_cnpj = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'cnpj')
idc_valor = dec( gf_replace(luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'valor'), '.',',',0) )
il_nr_dias_entrega = long(luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'prazoEntrega'))
idh_validade = datetime(date(luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'validade')), time('00:00'))
is_cd_transportadora = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'codigoTransportadora')


//[
//    {
//        "idOferta": 12438,
//        "transportadora": "FM TRANSPORTES E SERVICOS",
//        "cnpj": "17296825000106",
//        "valor": 13.09,
//        "prazoEntrega": 7,
//        "validade": "19/05/2020",
//        "codigoTransportadora": "938429114"


return true
end function

public function boolean of_processa_cotacao (long pl_cd_filial, long pl_nr_pedido, string ps_tipo_entrega, ref string ps_id_oferta_cotacao, ref string ps_nm_transportadora, ref datetime pdh_validade, ref string ps_log);string ls_log
string ls_json
string ls_retorno
string ls_id_oferta

long ll_cd_produto
long ll_linhas
long ll_for

decimal ldc_preco_soma = 0, ldc_preco_total

uo_ge509_comum luo_comum
dc_uo_ds_base lds_pedido


try 

	is_tipo_entrega = ps_tipo_entrega

	luo_comum = create uo_ge509_comum
	lds_pedido = create dc_uo_ds_base
	
	if not lds_pedido.of_changedataobject( 'ds_ge509_pedido_cotacao' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_cotacao ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge509_pedido_cotacao'
		return false
	end if

	ll_linhas = lds_pedido.retrieve(  pl_cd_filial, pl_nr_pedido )

	if ll_linhas < 0 Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_cotacao ~nProblemas ao consultar a datawindow: ds_ge509_pedido_cotacao - ' + sqlca.is_lasterrortext
		return false
	end if
	
	for ll_for = 1 to ll_linhas
	
		il_cd_filial_loja =  lds_pedido.object.cd_filial[ll_for]
	
		if Not this.of_busca_dados_filial( il_cd_filial_loja, ref ps_log ) Then return false
	
		is_tipo_pessoa = lds_pedido.object.id_fisica_juridica[ll_for]
		is_cep_cliente = lds_pedido.object.nr_cep_ent[ll_for]
		
		il_cd_produto = lds_pedido.object.cd_produto[ll_for]
		is_descricao_internet = lds_pedido.object.de_descricao_internet[ll_for]
		il_quantidade = lds_pedido.object.qt_pedida[ll_for]
		
		idc_altura = lds_pedido.object.qt_altura_cm[ll_for]
		idc_largura = lds_pedido.object.qt_largura_cm[ll_for]
		idc_comprimento = lds_pedido.object.qt_profundidade_cm[ll_for]
		idc_peso = lds_pedido.object.qt_peso_grama[ll_for]
		idc_preco = lds_pedido.object.vl_preco[ll_for]
		
		ldc_preco_total = lds_pedido.object.vl_total_calculado[ll_for]
		
		if idc_preco = 0 Then
			idc_preco = 0.01
		else
			ldc_preco_soma = ldc_preco_soma + (idc_preco * il_quantidade)
		end if
		
		is_tipo_produto = lds_pedido.object.id_tipo_produto[ll_for]
		
		if is_tipo_produto = '1' Then
			//Medicamento
			is_tipo_produto = '123'
		else
			//Perfumaria
			is_tipo_produto = '1234'
		end if
		
		if is_tipo_pessoa = 'F' Then
			is_tipo_pessoa = '1'
		else
			is_tipo_pessoa = '2'
		end if
		
		//Converte a unidade de medida para metros
		idc_altura = (idc_altura / 100)
		idc_largura = (idc_largura / 100)
		idc_comprimento = (idc_comprimento / 100)
		
		//Validar minimo de 1 cm
		if idc_altura < 0.01 then
			idc_altura = 0.01
		end if
		
		if idc_largura < 0.01 then
			idc_largura = 0.01
		end if
		
		if idc_comprimento < 0.01 then
			idc_comprimento = 0.01
		end if
		
		if idc_peso < 0.01 then
			idc_peso = 0.01
		end if
		
		if ll_for = 1 Then
			//Monta o cabecalho
			if Not this.of_monta_json( 'CAB', ref ls_json, ref ps_log ) Then return false
			
		end if
		
		if ll_for > 1 Then
			//Separa os produtos por virgula
			ls_json += ','
		end if
		
		//Adiciona o produto
		if Not this.of_monta_json( 'PRD', ref ls_json, ref ps_log ) Then return false
			
	next
	
	ls_json += ']}'
	
	//Valida$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o
	if ldc_preco_soma <> ldc_preco_total Then
		ps_log =  is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_cotacao ; ' + 'O valor total do pedido [' + string(ldc_preco_total) + '] $$HEX1$$e900$$ENDHEX$$ diferente da soma do pre$$HEX1$$e700$$ENDHEX$$o dos produtos [' + string(ldc_preco_soma) + '].'
		return false
	end if
	
	luo_comum.of_post(ls_json , is_url_interface, ls_retorno, ref ls_log )
		
	if ls_log <> '' and not isnull(ls_log) Then
		ps_log = ls_log
		return false
	end if
	
	il_cd_filial = pl_cd_filial
	il_nr_pedido = pl_nr_pedido
	
	if Not this.of_retorno( ls_retorno, ref ps_log ) Then return false
	
	If Not this.of_grava_oferta( ref ps_log ) Then return false
	
	ps_id_oferta_cotacao = is_id_oferta
	ps_nm_transportadora = is_nm_transportadora
	pdh_validade = idh_validade
	
Finally
		
	if ps_log <> '' and not isnull(ps_log) Then
		ps_log = 'Equilibrium: of_processa_cotacao - ' + ps_log
	end if	
		
	destroy(lds_pedido)
	destroy(luo_comum)
	
End try

return true
end function

on uo_ge509_cotacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge509_cotacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - ' +  'Objeto: ' + this.classname() + ' - '
end event

