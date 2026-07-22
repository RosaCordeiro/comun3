HA$PBExportHeader$uo_ge514_pedido_baixa.sru
forward
global type uo_ge514_pedido_baixa from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge514_pedido_baixa from uo_ge516_comum_interface_ecommerce
string is_id_ecommerce = "4"
string is_id_interface = "/api/v1/cashless_transactions"
long il_cd_tipo = 8
string is_datastore_dados = "ds_ge514_pedido_baixa"
string is_objeto_comum = "uo_ge514_comum_vmpay"
boolean ib_log_individual = true
long il_cd_mensagem_email = 222
string is_mensagem_email_1 = "PEDIDO - BAIXA"
end type
global uo_ge514_pedido_baixa uo_ge514_pedido_baixa

type variables
dc_uo_ds_base ids_produtos

Datetime idt_compra
Datetime idt_atualizacao

string is_nr_pedido_ecommerce
string is_maquina
string is_nr_nsu
string is_tipo_pagamento_site
string is_forma_pagto
string is_cod_barra
string is_de_produto

string is_tipo_pgto
string is_Estabelecimento 
string is_Bandeira_Cartao
string is_rede_cartao


long il_cd_produto
long il_nr_pedido
long il_pagamento
long il_Sequencial_Item
long il_qt_quantidade
long il_nr_maquina

Decimal{2} idc_vl_venda

end variables

forward prototypes
public function boolean of_busca_filial (string ps_maquina, ref long pl_cd_filial, ref string ps_rede, ref string ps_log)
public function boolean of_busca_forma_pagamento (ref string ps_log)
public function boolean of_grava_pagamento (ref string ps_log)
public function boolean of_grava_pedido (ref string ps_log)
public function boolean of_grava_produto (ref string ps_log)
public function boolean of_valida_produto (ref string ps_log)
public function boolean of_verifica_existe_pedido (ref boolean pb_existe_pedido, ref string ps_log)
public function boolean of_carrega_produtos (ref string ps_log)
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
end prototypes

public function boolean of_busca_filial (string ps_maquina, ref long pl_cd_filial, ref string ps_rede, ref string ps_log);long ll_cd_filial
string ls_rede_filial

select nr_vending_machine, cd_filial
into :il_nr_maquina, :ll_cd_filial
from vending_machine
where nr_patrimonio = :ps_maquina
and id_situacao = 'A';

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial; Problemas ao consultar a tabela "vending_machine": ' + sqlca.sqlerrtext
	return false
end if

if il_nr_maquina = 0 or isnull(il_nr_maquina) Then
	ps_log = 'M$$HEX1$$e100$$ENDHEX$$quina n$$HEX1$$e300$$ENDHEX$$o cadastrada no sistema: ' + ps_maquina
	return true
end if

if ll_cd_filial = 0 or isnull(ll_cd_filial) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar uma filial vinculada a seguinte m$$HEX1$$e100$$ENDHEX$$quina: ' + ps_maquina
	return true
end if

Select id_rede_filial
into :ls_rede_filial
from filial
where cd_filial = :ll_cd_filial
Using SQLCA;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial; Problemas ao consultar a tabela "filial": ' + sqlca.sqlerrtext
	return false
end if

pl_cd_filial = ll_cd_filial
ps_rede = ls_rede_filial

return true
end function

public function boolean of_busca_forma_pagamento (ref string ps_log);String ls_id_situacao
long ll_cd_administradora

Choose Case is_rede_cartao
	Case 'PAGSEGURO'
		ll_cd_administradora = 302
	Case 'REDE'
		ll_cd_administradora = 5
	Case 'CIELO'	
		ll_cd_administradora = 125
	Case Else
		ps_log = 'Rede do cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada: [' + is_rede_cartao + ']'
		return false
End Choose

SELECT	t.cd_pagamento,   
			t.id_pagamento,   
			t.cd_estabelecimento,   
			t.nm_administradora_cartao,   
			t.id_situacao  
Into 	:is_tipo_pgto, 
		:il_Pagamento, 
		:is_Estabelecimento, 
		:is_Bandeira_Cartao, 
		:ls_id_situacao
 FROM tipo_pagamento_ecommerce t
where t.nm_tipo_pagamento_site =  :is_tipo_pagamento_site
	and t.cd_forma_pagamento = :is_forma_pagto
	and t.cd_administradora_tef = :ll_cd_administradora
	and (t.id_ecommerce is null or t.id_ecommerce = :is_id_ecommerce);

Choose Case SqlCa.SqlCode
	Case 0
		
		if ls_id_situacao = 'I' Then
			ps_log = 'Forma de pagamento com situa$$HEX2$$e700e300$$ENDHEX$$o inativa: ' + is_tipo_pagamento_site + '(' + is_forma_pagto + ')'
		end if
	
	Case 100
		ps_Log = 'Forma de pagamento n$$HEX1$$e300$$ENDHEX$$o localizada :' + is_tipo_pagamento_site + '(' + is_forma_pagto + ')'
	Case -1
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_forma_pagamento. ' + 'Problemas ao consultar a tabela "tipo_pagamento_ecommerce": ' + sqlca.sqlerrtext
		return false
End Choose

return true
end function

public function boolean of_grava_pagamento (ref string ps_log);
//Insert Pedido Ecommerce Auxiliar
Insert Into pedido_ecommerce_auxiliar( cd_filial_ecommerce, 
														nr_pedido, 
														nm_administradora_cartao, 
														cd_estabelecimento_cartao, 
														id_rede_ecommerce,
														nr_comprovante_cartao_credito, 
														dh_confirmacao_faturamento)
	Values( :il_Filial_Disque, 
				:il_nr_pedido, 
				:is_Bandeira_Cartao, 
				:is_Estabelecimento, 
				:is_rede_filial,
				:is_nr_nsu,
				:idt_compra)
Using SqlCa;
			
if SqlCa.sqlcode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pagamento ~n' + 'Problemas ao inserir registro na tabela "pedido_ecommerce_auxiliar":~n' + SqlCa.sqlerrtext
	return false
end if

return true
end function

public function boolean of_grava_pedido (ref string ps_log);long ll_existe
long ll_nr_pedido

string ls_erro

Declare sp_pedido Procedure for sp_proximo_pedido_ecommerce
	@proximo_sequencial_retorno  = :ll_nr_pedido OUTPUT,
	@mensagem_retorno = :ls_erro OUTPUT
USING SQLCA;
			
Execute sp_pedido;

If SQLCA.sqlcode = -1 then 
	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao executar a procedure "sp_proximo_pedido_ecommerce": ~n' + SQLCA.sqlerrtext 
	return false
end if

Fetch sp_pedido Into :ll_nr_pedido, :ls_erro;

Close sp_pedido;

if ls_erro <> '' and not isnull(ls_erro) Then
	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao executar a procedure "sp_proximo_pedido_ecommerce": ~n' + ls_erro
	return false
end if

il_nr_pedido = ll_nr_pedido

INSERT INTO pedido_ecommerce  
		 ( cd_filial_ecommerce,
		   nr_pedido,   
		   nr_pedido_ecommerce,
		   dh_compra,   
		   dh_atualizacao,   
		   id_situacao,       
		   vl_subtotal, 
			vl_embalagem,
			vl_frete,
			vl_desconto,
			vl_valecompra,
		   vl_total,   
		   nr_parcelas,
   		   vl_indexador,
		   cd_boleto_parcelado,
		   cd_tipo_pagamento,   
		   cd_forma_pagamento,   
		   cd_filial,
		   dh_inclusao,
		   id_pagamento,
			 id_ecommerce,
			 nr_vending_machine)  
VALUES ( :il_Filial_Disque,
		   :ll_nr_pedido,
		   :is_nr_pedido_ecommerce,
		   :idt_compra,
			getdate(),
		   'A',
		   :idc_vl_venda,
			0,
			0,
			0,
			0,
		   :idc_vl_venda,
		   1,	
			0,
			0,
		   :is_tipo_pagamento_site,	
		   :is_forma_pagto,				
		   :il_Filial_Disque,	
		   getdate(),	
		   :il_Pagamento,	
		   :is_id_ecommerce,
			:il_nr_maquina)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao inserir registro na tabela "pedido_ecommerce": ~n' + SqlCa.sqlerrtext 
	return false
end if
	
return true
end function

public function boolean of_grava_produto (ref string ps_log);long ll_qtde_produto
string ls_produto_ecommerce

il_Sequencial_Item++
		
ls_produto_ecommerce = string(il_cd_produto)		
ll_qtde_produto = il_qt_quantidade		
		
INSERT INTO pedido_ecommerce_produto  
	 (  cd_filial_ecommerce,
		nr_pedido,   
		cd_produto_ecommerce, 
		nr_sequencial,
		qt_pedida,   
		nm_produto,   
		cd_produto,   
		vl_preco,   			 		// Pre$$HEX1$$e700$$ENDHEX$$o venda sem o desconto
		vl_preco_promocao,     	// Pre$$HEX1$$e700$$ENDHEX$$o liquido j$$HEX1$$e100$$ENDHEX$$ com o desconto
		dh_inicio_promocao,   
		dh_termino_promocao,
		vl_desconto,
		pc_desconto)  
VALUES( :il_Filial_Disque,
			:il_nr_pedido,   
			:ls_produto_ecommerce,   
			:il_Sequencial_Item,
			:ll_qtde_produto,
			:is_de_produto,   
			:il_cd_Produto,   
			:idc_vl_venda,   
			:idc_vl_venda,   
			null,   
			null,
			0,
			0)
Using SqlCa;
//
if SqlCa.sqlcode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao inserir registro na tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
end if

return true
end function

public function boolean of_valida_produto (ref string ps_log);long ll_existe

Select count(*)
into :ll_existe
from produto_geral
where cd_produto = :il_cd_produto
Using SQLCA;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_produto; Problemas ao consultar a tabela "produto_geral": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) Then
	ps_log = 'O seguinte produto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ cadastrado no sistema: ' + string(il_cd_produto) 
	return true
end if

ll_existe = 0

Select  Count(*)
into :ll_existe
from codigo_barras_produto
Where cd_produto = :il_cd_produto
and de_codigo_barras = :is_cod_barra
Using SQLCA;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_produto; Problemas ao consultar a tabela "codigo_barras_produto": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) Then
	ps_log = 'O seguinte c$$HEX1$$f300$$ENDHEX$$digo de barras n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ vinculado ao produto [' + string(il_cd_produto) + ']: ' + is_cod_barra
	return true
end if


return true
end function

public function boolean of_verifica_existe_pedido (ref boolean pb_existe_pedido, ref string ps_log);long ll_existe

select Count(*)
into :ll_existe
from pedido_ecommerce
where id_ecommerce = :is_id_ecommerce
and nr_pedido_ecommerce = :is_nr_pedido_ecommerce
and cd_filial_ecommerce = :il_Filial_Disque;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_existe_pedido ~nProblemas ao consultar a tabela "pedido_ecommerce": ~n' + sqlca.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) Then
	pb_existe_pedido = False
else
	pb_existe_pedido = True
end if

return true
end function

public function boolean of_carrega_produtos (ref string ps_log);long ll_for, ll_linhas

//Deixa somente os produtos da venda
ids_produtos.setfilter('id_venda = "' + is_nr_pedido_ecommerce + '"')
ids_produtos.filter()

ll_linhas = ids_produtos.rowcount( )

il_Sequencial_Item = 0

for ll_for = 1 to ll_linhas

	il_cd_produto = ids_produtos.object.cd_produto[ll_for]
	is_de_produto = ids_produtos.object.de_produto[ll_for]
	is_cod_barra = ids_produtos.object.cd_cod_barra[ll_for]
	
	If Not this.of_valida_produto(ref ps_log) Then return false
	
	if ps_log <> '' and not isnull(ps_log) Then
		return true
	end if
	
	If Not this.of_grava_produto( ref ps_log ) then return false
	
next

return true
end function

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);long ll_linha

string ls_retorno
string ls_info_vendas
string ls_info_produtos
string ls_info_maquina
string ls_info_pagamento
string ls_info_rede
string ls_json_restante
string ls_info_cartao
string ls_id_venda
string ls_maquina
string ls_vl_venda
string ls_cd_produto
string ls_cod_barra
string ls_quantidade
string ls_forma_pagamento
string ls_nr_nsu
string ls_de_produto
string ls_data_compra
string ls_tipo_cartao
string ls_rede_cartao

datetime ldh_compra
datetime ldh_inicio
datetime ldh_fim
datetime ldt_filtro

uo_ge073_json luo_gera_json

//1) Conecta na VMPAY
//2) Busca todas as vendas
//3) Carrega as vendas na datastore ids_dados
//4) Carrega os produtos na datastore ids_produtos

Try

	luo_gera_json = Create uo_ge073_json 
	ids_produtos = create dc_uo_ds_base
	ids_produtos.of_changedataobject('ds_ge514_pedido_baixa_produto')
	
	ldt_filtro = gf_getserverdate()
	
	//Baixar as vendas dos ultimos 3 dias 
	ldh_inicio = Datetime( relativedate( date(ldt_filtro), -3), Time('00:00:00') )
	ldh_fim = Datetime( date(ldt_filtro), Time('23:59:59') )
	
//	ldh_inicio = Datetime( date('26/11/2020'), Time('00:00:00') )
//	ldh_fim = Datetime( date('27/11/2020'), Time('23:59:59') )
//	
	iuo_comum.of_set_url_parametros('&start_date=' + String(ldh_inicio, 'dd/mm/yyyy hh:mm:ss') + '&end_date=' + string(ldh_fim, 'dd/mm/yyyy hh:mm:ss') )
	
	if Not iuo_comum.of_get( is_id_interface, ref ls_retorno, ref ps_log) then return false
	
	Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_info_vendas,'{') 
	
		ls_json_restante = ls_info_vendas
	
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'machine', ref ls_info_maquina, '}')
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'good', ref ls_info_produtos, '}')
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'eft_authorizer', ref ls_info_rede, '}')
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'eft_card_brand', ref ls_info_pagamento, '}')
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'eft_card_type', ref ls_info_cartao, '}')
		
		ls_id_venda = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'id')
		
		ls_data_compra = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'occurred_at')
		ldh_compra = Datetime(Date(ls_data_compra) , Time( Mid(ls_data_compra,12,8) ) )
		
		ls_vl_venda = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'transaction_value')
		ls_nr_nsu = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'request_number')				
		ls_quantidade = '1'		
				
		ls_maquina = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_maquina, 'asset_number')
		
		ls_rede_cartao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_rede, 'name')
		ls_rede_cartao = Upper(ls_rede_cartao)
		
		ls_forma_pagamento = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pagamento, 'name')
		ls_forma_pagamento = Upper(ls_forma_pagamento)
		
		ls_tipo_cartao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cartao, 'name')
		ls_tipo_cartao = Upper(ls_tipo_cartao)
		
		Choose Case ls_tipo_cartao
			Case 'D$$HEX1$$c900$$ENDHEX$$BITO'
				ls_tipo_cartao = 'CA'
			Case 'CR$$HEX1$$c900$$ENDHEX$$DITO'
				ls_tipo_cartao = 'CP'
			CAse Else
				ls_tipo_cartao = ''
		End Choose
		
		//Transaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
		Select dateadd( HOUR, -3, :ldh_compra )
		Into :ldh_compra
		From parametro;
	
		
		ll_linha = ids_dados.insertrow(0)
		
		ids_dados.object.id_venda[ll_linha] = ls_id_venda
		ids_dados.object.id_maquina[ll_linha] = ls_maquina
		ids_dados.object.vl_venda[ll_linha] = iuo_comum.of_decimal( ls_vl_venda )
		ids_dados.object.nr_nsu[ll_linha] = ls_nr_nsu
		ids_dados.object.cd_tp_pagamento[ll_linha] = ls_forma_pagamento
		ids_dados.object.qt_quantidade[ll_linha] = long(ls_quantidade)
		ids_dados.object.dt_compra[ll_linha] = ldh_compra
		ids_dados.object.cd_forma_pagamento[ll_linha] = ls_tipo_cartao 
		ids_dados.object.de_rede_cartao[ll_linha] = ls_rede_cartao 
		
		//Informa$$HEX2$$e700f500$$ENDHEX$$es do Produto
		ls_cd_produto = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_produtos, 'upc_code')
		ls_cod_barra = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_produtos, 'barcode')
		ls_de_produto = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_produtos, 'name')
		
		ll_linha = ids_produtos.insertrow(0)
		
		ids_produtos.object.id_venda[ll_linha] = ls_id_venda
		ids_produtos.object.cd_produto[ll_linha] = long(ls_cd_produto)
		ids_produtos.object.cd_cod_barra[ll_linha] = ls_cod_barra
		ids_produtos.object.de_produto[ll_linha] = ls_de_produto
	Loop
	
Finally
	
	pl_linhas = ids_dados.rowcount()
	
	destroy(luo_gera_json)
	
// {
//        "id": 65977037,
//        "occurred_at": "2020-07-31T18:35:28.000Z",
//        "client_id": null,
//        "location_id": 12545,
//        "machine_id": 15687,
//        "installation_id": 22532,
//        "planogram_item_id": 14646459,
//        "eft_provider_id": 2,
//        "eft_authorizer_id": 4,
//        "eft_card_brand_id": 21,
//        "eft_card_type_id": 2,
//        "good_id": 44232,
//        "coil": "13",
//        "transaction_value": 4.1,
//        "request_number": "003069800",
//        "kind": "TEF pinpad",
//        "remote_credit": false,
//        "location": {
//            "client_id": 28368,
//            "name": "Pr$$HEX1$$e900$$ENDHEX$$dio CLAMED"
//        },
//        "machine": {
//            "machine_model_id": 126,
//            "asset_number": "563-01"
//        },
//        "good": {
//            "type": "Product",
//            "category_id": 4239,
//            "manufacturer_id": 7089,
//            "name": "MASCARA FACIAL ANATOMICA ADULTO : C/1 TAM G TECIDO",
//            "upc_code": "737873",
//            "barcode": "8999903750971"
//        },
//        "eft_provider": {
//            "name": "SiTef"
//        },
//        "eft_authorizer": {
//            "name": "Rede"
//        },
//        "eft_card_brand": {
//            "name": "Visa"
//        },
//        "eft_card_type": {
//            "name": "D$$HEX1$$e900$$ENDHEX$$bito"
//        },
//        "cpf": ""
//    }	
	
	
	
End Try

Return true
end function

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);boolean lb_existe_pedido
	
is_nr_pedido_ecommerce = ids_dados.object.id_venda[pl_linha]
is_maquina = ids_dados.object.id_maquina[pl_linha]
idc_vl_venda = ids_dados.object.vl_venda[pl_linha]
is_nr_nsu = ids_dados.object.nr_nsu[pl_linha]
is_tipo_pagamento_site = ids_dados.object.cd_tp_pagamento[pl_linha]
idt_compra = ids_dados.object.dt_compra[pl_linha]
il_qt_quantidade = ids_dados.object.qt_quantidade[pl_linha]
is_forma_pagto = ids_dados.object.cd_forma_pagamento[pl_linha]
is_rede_cartao = ids_dados.object.de_rede_cartao[pl_linha]

//Preenche email de log
is_mensagem_email_2 = 'Pedido: ' + is_nr_pedido_ecommerce

If Not this.of_busca_filial( is_maquina, ref il_cd_filial, ref is_rede_filial, ref ps_log ) then return false

if ps_log <> '' and not isnull(ps_log) Then return false

il_filial_disque = il_cd_filial

iuo_comum.is_rede_ecommerce = is_rede_filial
iuo_comum.il_cd_filial_pedido = il_cd_filial
iuo_comum.is_nr_pedido_ecommerce = is_nr_pedido_ecommerce

if Not this.of_verifica_existe_pedido( ref lb_existe_pedido, ref ps_log ) then return false

//Pedido j$$HEX1$$e100$$ENDHEX$$ baixado. Passa para o pr$$HEX1$$f300$$ENDHEX$$ximo.
if lb_existe_pedido = True then 
	pb_gerar_log = false
	return true
else
	pb_gerar_log = true
end if

If Not this.of_busca_forma_pagamento( ref ps_log ) Then return false

if ps_log <> '' and not isnull(ps_log) Then return false

If Not this.of_grava_pedido( ref ps_log ) Then Return false

if Not this.of_grava_pagamento( ref ps_log ) Then Return false

If Not this.of_carrega_produtos( ref ps_log ) Then Return false

if ps_log <> '' and not isnull(ps_log) Then return false

Return true
end function

on uo_ge514_pedido_baixa.create
call super::create
end on

on uo_ge514_pedido_baixa.destroy
call super::destroy
end on

