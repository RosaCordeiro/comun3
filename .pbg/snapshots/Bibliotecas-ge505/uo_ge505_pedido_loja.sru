HA$PBExportHeader$uo_ge505_pedido_loja.sru
forward
global type uo_ge505_pedido_loja from nonvisualobject
end type
end forward

global type uo_ge505_pedido_loja from nonvisualobject
end type
global uo_ge505_pedido_loja uo_ge505_pedido_loja

type variables
CONSTANT INTEGER CD_MENSAGEM_EMAIL_EQUIPE_TI_DESENV		= 98 // c$$HEX1$$f300$$ENDHEX$$digo na tabela mensagem_email_sistema
CONSTANT INTEGER CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA	= 109 // c$$HEX1$$f300$$ENDHEX$$digo na tabela mensagem_email_sistema
CONSTANT STRING CD_DISTRIBUIDORA_ESTOQUE_CENTRAL			= '053404705'


uo_transacao_online ivo_Conecta_Odbc
dc_uo_transacao itr_Filial
dc_uo_odbc ivo_Odbc

string is_datasource

string is_objeto
string is_id_ecommerce = '3' //Ifood
string is_rede_filial
String is_ODBC_Desenv

long il_cd_tipo = 9
long il_cd_filial
long il_Filial_Desenv
long il_cd_mensagem_email = 240

Boolean ib_Desenv = False

dc_uo_ds_base ids_pedidos

//****************************

string is_nr_cpf

//****************************

Datetime idh_compra

Long il_cd_filial_pedido
Long il_nr_pedido
Long il_id_pagamento

Decimal idc_total
Decimal idc_frete
Decimal idc_valecompra
Decimal idc_Produtos_Calculado
Decimal idc_desconto
Decimal idc_subtotal

String is_id_cpf_nf
String is_forma_pagto
String is_observacao 
String is_endereco_ent 
String is_referencia_ent 
String is_bairro_ent
String is_cep_ent
String is_fone_ent 
String is_nome_ent
String is_bandeira_cartao
String is_transportadora 
String is_numero_ent
String is_nr_cartao_credito
String is_cd_cliente_clube
String is_cidade_ent
String is_comprovante_cartao
String is_autorizacao_cartao
String is_estabelecimento
String is_bloqueto
String is_cupom_desconto
String is_complemento_ent
String is_fone_contato_ent
String is_uf_ent 
String is_via_pbm
String is_email
String is_nr_pedido_filial
String is_id_situacao

integer ii_parcelas

end variables

forward prototypes
public subroutine of_limpa_variaveis ()
public function boolean of_grava_pedido (string ps_nr_pedido, ref string ps_log)
public function boolean of_desconecta_filial ()
public function boolean of_conecta_filial (ref string ps_log)
public function boolean of_grava_produto (ref string ps_log)
public function boolean of_grava_cartao_comp_venda (ref string ps_log)
public function boolean of_atualiza_pedido (ref string ps_log)
public function boolean of_forma_pagamento (long pl_id_pagamento, ref string ps_log)
public function boolean of_saldo_produto_reservado (long pl_cd_produto, ref long pl_qt_saldo_pendente, ref string ps_log)
public function boolean of_saldo_disponivel_distrib (long pl_cd_produto, string ps_distribuidora, string ps_chamada, ref decimal pdc_fator_conversao, ref long pl_qt_saldo, ref string ps_log)
public function boolean of_processa_pedido_empurrado (long pl_cd_produto, long pl_qtde, ref string ps_log)
public function boolean of_grava_pedido_empurrado (long pl_cd_produto, long pl_qtde, string ps_distribuidora, decimal pdc_fator_conversao, long pl_saldo_falta, ref string ps_log)
public function boolean of_busca_filial_site (ref long pl_cd_filial, ref string ps_log, string ps_pedido)
public function boolean of_verifica_cliente_clube (ref string ps_log)
public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, long pl_cd_filial)
public function boolean of_processa_atualizacao_pedido ()
end prototypes

public subroutine of_limpa_variaveis ();setnull(is_nr_cpf)

setnull(il_cd_filial_pedido)
setnull(il_nr_pedido)

setnull(idc_total)
setnull(idc_frete) 
setnull(idc_valecompra)

setnull(is_id_cpf_nf)
setnull(is_forma_pagto) 
setnull(is_observacao) 
setnull(is_endereco_ent) 
setnull(is_referencia_ent) 
setnull(is_bairro_ent) 
setnull(is_cep_ent) 
setnull(is_fone_ent) 
setnull(is_nome_ent)
setnull(is_bandeira_cartao) 
setnull(is_transportadora) 
setnull(is_numero_ent) 
setnull(is_nr_cartao_credito) 
setnull(is_cd_cliente_clube) 
setnull(is_cidade_ent) 
setnull(is_comprovante_cartao)
setnull(is_autorizacao_cartao) 
setnull(is_estabelecimento)
setnull(is_bloqueto) 
setnull(is_cupom_desconto) 
setnull(is_complemento_ent) 
setnull(is_fone_contato_ent)
setnull(is_uf_ent) 
setnull(is_via_pbm) 
setnull(is_email)
setnull(idc_Produtos_Calculado)
setnull(ii_parcelas)
setnull(is_nr_pedido_filial)
setnull(idc_desconto)
setnull(idc_subtotal)
setnull(idh_compra)

end subroutine

public function boolean of_grava_pedido (string ps_nr_pedido, ref string ps_log);Decimal ldc_Pc_Desconto

DateTime ldt_Movimentacao

String ls_Hora,&
	   	ls_Venda_Clube,&
	   	ls_Mensagem,&
	   	ls_Pedido,&
	   	ls_Endereco,&
	   	ls_Nulo,&
	   	ls_Pedido_Inicial,&	   	
		ls_Observacao, ls_nr_Pedido_inicial, ls_tipo_vale

Long ll_Sequencial, ll_existe

Integer li_Pos

// Se j$$HEX1$$e100$$ENDHEX$$ existe pedido drogaexpress com o mesmo nr_pedido_ecommerce, n$$HEX1$$e300$$ENDHEX$$o inclui e retorna false
SELECT count(*)
INTO :ll_existe
FROM pedido_drogaexpress
WHERE nr_pedido_ecommerce = :il_nr_pedido
	AND cd_filial_ecommerce 	= :il_cd_filial
USING itr_filial;

If itr_filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Problemas ao consultar a tabela "pedido_drogaexpress": ~n'  + itr_filial.sqlerrtext
	return false
end if

//If ll_existe > 0 Then
//	ps_log = 'Problemas ao consultar a tabela "pedido_drogaexpress": ~n'  + itr_filial.sqlerrtext
//	return false
//end if

SetNull(ls_Nulo)

ldt_Movimentacao = gf_GetServerDate()

ls_Hora = String(Hour( time(ldt_Movimentacao) ), "00")

ls_Endereco = RightTrim(Mid(is_Endereco_Ent, 1, 50)) + ", " + is_numero_ent

//N$$HEX1$$e300$$ENDHEX$$o pontuar no clube DC. Existe pontua$$HEX2$$e700e300$$ENDHEX$$o exclusiva para o farmagora.
ls_Venda_Clube = "N"

//// Localiza o pr$$HEX1$$f300$$ENDHEX$$ximo pedido do Disque Entrega

If Not gf_proximo_pedido_drogaexpress(il_cd_filial_pedido, ref is_nr_pedido_filial, ref ps_log) Then return false

//// Cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito
//If is_forma_pagto = 'CP' Then
//	If IsNull(is_Comprovante_Cartao) Then
//		ps_log = "O comprovante do cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito do pedido eCommerce '" + String(il_nr_Pedido) + "' n$$HEX1$$e300$$ENDHEX$$o foi informado. "
//		return false
//	End If
//	
//	If IsNull(is_Autorizacao_Cartao) Then
//		ps_log = "A autoriza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito do pedido eCommerce '" + String(il_nr_Pedido) + "' n$$HEX1$$e300$$ENDHEX$$o foi informada. "
//		return false
//	End If
//End If

// Observa$$HEX2$$e700e300$$ENDHEX$$o pedido
ls_Observacao = Mid(trim(is_Observacao), 1, 200)
is_nr_cartao_credito = Mid(trim(is_nr_cartao_credito), 1, 19)
is_cd_cliente_clube = Mid(trim(is_cd_cliente_clube), 1, 11)
ls_Endereco = Mid(trim(ls_Endereco), 1, 60)
is_Referencia_Ent = Mid(trim(is_Referencia_Ent), 1, 150)
is_Bairro_Ent = Mid(trim(is_Bairro_Ent), 1, 20)
is_Fone_Ent = Mid(trim(is_Fone_Ent), 1, 20)
is_Nome_Ent = Mid(trim(is_Nome_Ent), 1, 60)
is_Bandeira_Cartao = Mid(trim(is_Bandeira_Cartao), 1, 40)
is_Transportadora = Mid(trim(is_Transportadora), 1, 30)
is_Cidade_Ent = Mid(trim(is_Cidade_Ent), 1, 30)
is_comprovante_cartao = Mid(trim(is_comprovante_cartao), 1, 20)
is_autorizacao_cartao = Mid(trim(is_autorizacao_cartao), 1, 10)
is_Estabelecimento = Mid(trim(is_Estabelecimento), 1, 10)
is_Bloqueto = Mid(trim(is_Bloqueto), 1, 10)
is_Cupom_Desconto = Mid(trim(is_Cupom_Desconto), 1, 10)
is_complemento_ent = Mid(trim(is_complemento_ent), 1, 40)
is_fone_contato_ent = Mid(trim(is_fone_contato_ent), 1, 20)
is_numero_ent = Mid(trim(is_numero_ent), 1, 6)

ldc_Pc_Desconto = 0

If idc_ValeCompra > 0 Then
	ldc_Pc_Desconto = Round( ( idc_ValeCompra / idc_Total ) * 100, 2 )
	
	ls_tipo_vale = 'C'
	
End If

INSERT INTO pedido_drogaexpress  
	 (  nr_pedido_drogaexpress,   
		cd_filial,   
		dh_emissao,   
		hr_emissao,   
		cd_cliente_drogaexpress,   
		vl_total_produtos,   
		pc_desconto,   
		vl_total_pedido,   
		vl_taxa_entrega,   
		vl_cobrar,   
		vl_pago,   
		id_situacao,   
		cd_tipo_venda,   
		cd_forma_pagamento,   
		nr_matricula_vendedor,   
		nr_matricula_operador,   
		de_especie_doc_fiscal,   
		nr_cartao_credito,    
		cd_cliente,      
		de_observacao,      
		de_endereco_entrega,   
		de_referencia_entrega,   
		de_bairro_entrega,   
		nr_telefone_entrega,   
		id_venda_clube,     
		nr_cpf_cheque,   
		nr_pedido_ecommerce,
		nm_cliente_entrega,
		nr_cep_entrega,
		nr_parcelas_pagamento,
		nm_administradora_cartao,
		nm_transportadora,
		nm_cidade_entrega,
		cd_uf_entrega,
		nr_comprovante_cartao_credito,
		nr_autorizacao_cartao_credito,
		cd_estabelecimento_cartao_credito,
		nr_boleto_bancario,
		nr_vale_compra,
		vl_vale_compra,
		de_complemento_endereco,
		nr_telefone_contato,
		cd_filial_ecommerce,
		nr_endereco_entrega ,
		id_tipo_vale,
		de_via_pbm,
		id_rede_ecommerce,
		de_endereco_email,
		nr_pedido_ecommerce_site,
		cd_convenio,
		cd_conveniado,
		cd_condicao_convenio,
		id_plataforma_ecommerce,
		id_cpf_nf,
		dh_compra)  
Values( :is_nr_pedido_filial,			//nr_pedido_drogaexpress,   
		:il_cd_filial_pedido,			//cd_filial,   
		:ldt_Movimentacao,				//dh_emissao,   
		:ls_Hora,							//hr_emissao,   
		'999999',							//cd_cliente_drogaexpress,   
		0,										//vl_total_produtos,   
		:ldc_Pc_Desconto,					//pc_desconto,   
		:idc_Total,							//vl_total_pedido,   
		:idc_Frete,							//tevl_taxa_entrega,   
		0,										//vl_cobrar,   
		0,										//vl_pago,   
		:is_id_situacao,					//id_situacao,   
		'CV',									//cd_tipo_venda,   
		'CV',									//cd_forma_pagamento,   
		'14330',								//nr_matricula_vendedor,   
		'14330',								//nr_matricula_operador,   
		'CF',									//de_especie_doc_fiscal,   
		:is_nr_cartao_credito ,			//nr_cartao_credito,   
		:is_cd_cliente_clube,			//cd_cliente,   
		:ls_Observacao,					//de_observacao,   
		:ls_Endereco,						//de_endereco_entrega,   
		:is_Referencia_Ent,				//de_referencia_entrega,   
		:is_Bairro_Ent,					//de_bairro_entrega,   
		:is_Fone_Ent,						//nr_telefone_entrega,   
		:ls_Venda_Clube,					//id_venda_clube,   
		:is_nr_cpf,							//nr_cpf_cheque,   
		:il_nr_Pedido,						//nr_pedido_ecommerce,
		:is_Nome_Ent,						//nm_cliente_entrega,
		:is_Cep_Ent,						//nr_cep_entrega,
		:ii_Parcelas,						//nr_parcelas_pagamento,
		:is_Bandeira_Cartao,         	// nm_administradora_cartao
		:is_Transportadora,				// nm_transportadora
		:is_Cidade_Ent,					// nm_cidade_entrega
		:is_UF_Ent,							// cd_uf_entrega
		:is_comprovante_cartao,			// nr_comprovante_cartao_credito,
		:is_autorizacao_cartao,			// nr_autorizacao_cartao_credito
		:is_Estabelecimento,				// cd_estabelecimento_cartao_credito
		:is_Bloqueto,						// nr_boleto_bancario
		:is_Cupom_Desconto,				// nr_vale_compra
		0,										// vl_vale_compra
		:is_Complemento_Ent,				// de_complemento_endereco
		:is_Fone_Contato_Ent,			// nr_telefone_contato
		:il_cd_filial,						//cd_filial_ecommerce
		:is_numero_ent,					//nr_endereco_entrega
		:ls_tipo_vale,                //id_tipo_vale
		:is_Via_PBM,						// de_via_pbm
		:is_Rede_Filial,
		:is_Email,
		:ps_nr_pedido,
		54329,
		'1',
		110,
		:is_id_ecommerce,
		:is_id_cpf_nf,
		:idh_compra)
using itr_filial;	

if itr_filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Problemas ao inserir registro na tabela "pedido_drogaexpress": ~n' + itr_filial.sqlerrtext
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

public function boolean of_conecta_filial (ref string ps_log);String ls_Odbc

is_DataSource = gvo_Aplicacao.ivs_DataSource

//gvb_Auto = True

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
	ivo_Conecta_Odbc.of_inclui_odbc( il_cd_filial_pedido )
	ls_Odbc = ivo_Odbc.of_Localiza( il_cd_filial_pedido )
end if

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

if itr_Filial.of_Connect( ls_Odbc, gvo_aplicacao.is_ComputerName , false) = False Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(il_cd_filial_pedido) 
	return false
end if

gvo_Aplicacao.ivs_DataSource = is_DataSource

Return True
end function

public function boolean of_grava_produto (ref string ps_log);Decimal 	ldc_Perc_Desconto,&
			ldc_Preco_Praticado,&
			ldc_Preco_Liquido, ldc_preco
			
String ls_descricao
long ll_linhas, ll_for, ll_qtde, ll_requisicao_manip, ll_cd_produto, ll_sequencial

dc_uo_ds_base lds_dados

lds_dados = create dc_uo_ds_base
lds_dados.of_changedataobject( 'ds_ge505_pedido_loja_produto')

ll_linhas = lds_dados.retrieve(il_cd_filial, il_nr_pedido )

if ll_linhas < 0 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext
	return false
end if

idc_Produtos_Calculado = 0

for ll_for = 1 to ll_linhas

	ldc_Preco_Liquido = lds_dados.object.vl_preco_promocao[ll_for]
	ldc_preco = lds_dados.object.vl_preco[ll_for]
	ll_qtde = lds_dados.object.qt_pedida[ll_for]
	ll_requisicao_manip = lds_dados.object.nr_requisicao_manip[ll_for]
	ll_cd_produto = lds_dados.object.cd_produto[ll_for]
	ll_sequencial = lds_dados.object.nr_sequencial[ll_for]
	ls_descricao = lds_dados.object.nm_produto[ll_for]
	
	// Se o pre$$HEX1$$e700$$ENDHEX$$o liquido for zerado o desconto vai ser de 100% e vai dar erro
	If ldc_Preco_Liquido > 0.00 Then
		ldc_Perc_Desconto = Round((((ldc_preco - ldc_Preco_Liquido) / ldc_preco) * 100), 4)
	Else
		ldc_Perc_Desconto = 0.00
	End If

	ldc_Preco_Praticado = Round( (ldc_preco * ((100 - ldc_Perc_Desconto) / 100) ),2)

	If ldc_Preco_Praticado <> ldc_Preco_Liquido Then
		ps_log = "Pre$$HEX1$$e700$$ENDHEX$$o calculado '" + String(ldc_Preco_Praticado) + "' diferente do pre$$HEX1$$e700$$ENDHEX$$o vendido '" + String(ldc_Preco_Liquido) +"."
		Return False
	End If

	idc_Produtos_Calculado = idc_Produtos_Calculado + Round((ldc_Preco_Praticado * ll_qtde), 2)

	//
	//If ll_cd_produto <> ivo_produto.cd_produto_manipulado Or Not IsNull( ll_requisicao_manip )  Then
	//	SetNull( as_descricao )
	//End If
	
	INSERT INTO produto_pedido_drogaexpress  
		 ( nr_pedido_drogaexpress,   
			cd_produto,
			nr_sequencial,
			qt_pedida,   
			vl_preco_tabela,   
			pc_desconto_tabela,   
			vl_preco_praticado,   
			id_alteracao_preco,   
			id_restricao_convenio,   
			vl_preco_tabela_liquido,   
			qt_pontos_clube,
			nr_requisicao_manip,
			de_produto)  
	VALUES (:is_nr_pedido_filial,					//nr_pedido_drogaexpress,   
			:ll_cd_produto,						//cd_produto,   
			:ll_sequencial, 					//nr_sequencial
			:ll_Qtde,							//qt_pedida,   
			:ldc_preco,						//vl_preco_tabela,   
			:ldc_Perc_Desconto,			//pc_desconto_tabela,   
			:ldc_Preco_Praticado,		//vl_preco_praticado,   
			'N',								//id_alteracao_preco,   
			'N',								//id_restricao_convenio,   
			:ldc_Preco_Praticado,		//vl_preco_tabela_liquido,   
			null,								//qt_pontos_clube                        ?????????
			:ll_requisicao_manip,	//nr_requisicao_manip
			:ls_descricao)				//de_produto usado para produto manipulado acabado - sem requisicao
	Using itr_filial;
			
	if itr_filial.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao inserir registro na tabela "produto_pedido_drogaexpress": ~n' + itr_filial.sqlerrtext
		return false
	end if
	
//	If Not this.of_processa_pedido_empurrado( ll_cd_produto, ll_Qtde, ref ps_log ) Then return false
		
Next
	
Return True
end function

public function boolean of_grava_cartao_comp_venda (ref string ps_log);DateTime ldt_Movimentacao
Date ldt_Atual

String ls_Mensagem	, &
		ls_Cd_Caixa	, &
		ls_de_historico
String ls_Documento

Integer li_nr_controle_caixa	, &
		  li_nr_sequencial			, &
		  li_nr_lancamento		, &
		  li_Achou

Long ll_Pedido_Ecommerce
Long ll_Lancamento_caixa
Long ll_existe

Decimal {2} ldc_Total

Try

	ldc_Total = idc_Total
	
	ls_Documento = String(il_nr_pedido)
	
//	If ivb_Pedido_Pendente Then //Se est$$HEX1$$e100$$ENDHEX$$ gravando um pedido que j$$HEX1$$e100$$ENDHEX$$ tinha sido baixado como pendente, j$$HEX1$$e100$$ENDHEX$$ existe comprovante
//		This.of_Grava_Arquivo( "[OK] Saiu da fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_cartao_comprovante_venda ( ivb_Pedido_Pendente = True )", False )
//		Return True
//	End If
	
	// Grava somente Cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito
	If (is_Forma_Pagto	<> 'CP' ) Then
		Return True
	End If
	
	If ii_Parcelas < 1 Then
		ps_log = 'Quantidade de parcelas do cart$$HEX1$$e300$$ENDHEX$$o [' + String( ii_Parcelas ) + '] inv$$HEX1$$e100$$ENDHEX$$lida.'
		Return False
	End If
	
	ldt_Movimentacao	= gf_GetServerDate( )
	ldt_Atual				= Date( ldt_Movimentacao )
	ls_Cd_Caixa			= String( il_cd_filial_pedido, "0000" ) + "00"
	
	SELECT MAX( nr_controle_caixa )
	  INTO :li_nr_controle_caixa 
	  FROM controle_caixa
	 WHERE cd_caixa = :ls_Cd_Caixa
		AND dh_movimentacao_caixa = :ldt_Atual
		AND dh_conferencia is null	
	Using itr_filial;
	
	If itr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_cartao_comp_venda ~n' + 'Problemas ao consultar a tabela "controle_caixa": ~n' + itr_filial.sqlerrtext
		Return False
	End If
	
	If IsNull(li_nr_controle_caixa) or li_nr_controle_caixa <=0  Then
		//This.of_Grava_Arquivo( "[ERRO] Sem caixa geral aberto " + lvs_Cd_Caixa + " Pedido " + as_Pedido , True )
		ps_log = "Sem caixa geral aberto " + ls_Cd_Caixa + " Pedido " + string(il_nr_pedido) 
		Return False
	End If

//	This.of_Grava_Arquivo( "[OK] Localiza$$HEX2$$e700e300$$ENDHEX$$o do max(nr_controle_caixa) da controle_caixa (cd_caixa, nr_controle_caixa) (" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + ")." , False )
	
	SELECT MAX(nr_sequencial)
	  INTO :li_nr_sequencial
	  FROM cartao_comprovante_venda
	 WHERE cd_caixa = :ls_Cd_Caixa
		AND nr_controle_caixa	= :li_nr_controle_caixa
	USING itr_filial;
	
	If itr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_cartao_comp_venda ~n' + 'Problemas ao consultar a tabela "cartao_comprovante_venda": ~n' + itr_filial.sqlerrtext
		Return False
	End If
	
	If IsNull(li_nr_sequencial) or li_nr_sequencial <= 0 Then
		li_nr_sequencial = 1
	else
		li_nr_sequencial++
	End If
	
//	This.of_Grava_Arquivo( "[OK] Localiza$$HEX2$$e700e300$$ENDHEX$$o do max(nr_sequencial) da cartao_comprovante_venda (cd_caixa, nr_controle_caixa, nr_sequencial) (" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + ", " + String( lvi_nr_sequencial ) + ")." , False )
	
	is_comprovante_cartao	= Mid(trim(is_comprovante_cartao), 1, 20)
	is_autorizacao_cartao	= Mid(trim(is_autorizacao_cartao), 1, 10)
	is_Estabelecimento		= Mid(trim(is_Estabelecimento), 1, 10)
	is_Bandeira_Cartao		= Mid(trim(is_Bandeira_Cartao), 1, 40)
	

	//Verifica$$HEX2$$e700e300$$ENDHEX$$o para n$$HEX1$$e300$$ENDHEX$$o inserir comprovante duplicado
	SELECT Count(*)
	INTO :ll_existe
	FROM cartao_comprovante_venda
	WHERE cd_caixa = :ls_cd_caixa
		AND nr_autorizacao = :is_autorizacao_cartao
		AND nr_nsu = :is_comprovante_cartao
		AND vl_venda = :ldc_Total
		AND cd_filial = :il_cd_filial_pedido
		AND cd_estabelecimento = :is_Estabelecimento
		AND qt_parcelas = :ii_Parcelas
		AND id_cancelamento = 'N'
	 USING itr_filial;
	 
	If itr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_cartao_comp_venda ~n' + 'Problemas ao consultar a tabela "cartao_comprovante_venda": ~n' + itr_filial.sqlerrtext
		Return False
	End If
	 
	If ll_existe > 0 Then
	 	return true
	end if
			
	If ldc_Total = 0.00 Then
		ps_log = 'Valor do cartao_comprovante_venda est$$HEX1$$e100$$ENDHEX$$ igual a 0.'
		Return False
	End If
	
	ll_Pedido_Ecommerce = il_nr_pedido	
	
//	is_comprovante_cartao = Mid(trim(is_comprovante_cartao), 7)
	
	INSERT INTO cartao_comprovante_venda (
		cd_caixa,
		nr_controle_caixa,
		nr_sequencial,
		nm_produto,
		nr_cartao,
		nr_autorizacao,
		nr_nsu,
		dh_venda,
		vl_venda,
		qt_parcelas,
		id_captura,
		id_cancelamento,
		cd_filial,
		nr_nf,
		de_especie,
		de_serie,
		cd_estabelecimento,
		nr_lancamento_caixa,
		dh_exportacao,
		id_parcelamento,
		vl_saque,
		nr_ecf,
		nr_coo_ecf,
		id_cancelamento_sitef,
		id_pre_venda,
		dh_predatado,
		nr_pedido_ecommerce)
	VALUES (:ls_cd_caixa,
		:li_nr_controle_caixa,
		:li_nr_sequencial,
		:is_Bandeira_Cartao,		//nm_produto
		:is_nr_cartao_credito,				//nr_cartao
		:is_autorizacao_cartao, 	//nr_autorizacao
		:is_comprovante_cartao, 	//nr_nsu
		:ldt_Movimentacao, 			//dh_venda
		:ldc_Total, 						//vl_venda
		:ii_Parcelas, 					//qt_parcelas
		'T', 								//id_captura
		'N', 								//id_cancelamento
		:il_cd_filial_pedido, 				//cd_filial 
		null, 								//nr_nf
		null, 								//de_especie
		null, 								//de_serie
		:is_Estabelecimento,			//cd_estabelecimento
		null, 								//nr_lancamento_caixa
		null,						 		//dh_exportacao
		  'L', 								//id_parcelamento
		0,									//vl_saque
		null, 								//nr_ecf
		null, 								//nr_coo_ecf
		null, 								//id_cancelamento_sitef 
		'N', 								//id_pre_venda 
		null, 								//dh_predatado
		:ll_Pedido_Ecommerce 		//nr_pedido_ecommerce
	)
	Using itr_filial;	
	
	If itr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_cartao_comp_venda ~n' + 'Problemas ao inserir registro na tabela "cartao_comprovante_venda": ~n' + itr_filial.sqlerrtext
		Return False
	End If
		
	select nr_lancamento_caixa
		into :ll_Lancamento_caixa
	from cartao_comprovante_venda 
	where cd_caixa = :ls_cd_caixa
		and nr_controle_caixa = :li_nr_controle_caixa
		and nr_sequencial = :li_nr_sequencial
	Using itr_filial;
	
	If itr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_cartao_comp_venda ~n' + 'Problemas ao consultar a tabela "cartao_comprovante_venda": ~n' + itr_filial.sqlerrtext
		Return False
	End If
	
	If Not IsNull( ll_Lancamento_caixa ) And ll_Lancamento_caixa > 0 Then
		
		Update lancamento_caixa 
			set nr_documento = :ls_Documento
			where  cd_caixa = :ls_cd_caixa
				and nr_controle_caixa = :li_nr_controle_caixa
				and nr_lancamento = :ll_Lancamento_caixa
		Using itr_filial;
		
		If itr_filial.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_cartao_comp_venda ~n' + 'Problemas ao atualizar a tabela "lancamento_caixa": ~n' + itr_filial.sqlerrtext
			Return False
		End If
		
	End If
				
	
	SELECT MAX(nr_lancamento)
		INTO :li_nr_lancamento
	  FROM lancamento_caixa
	 WHERE cd_caixa				= :ls_Cd_Caixa
		 AND nr_controle_caixa	= :li_nr_controle_caixa
	Using itr_filial;
	
	If itr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_cartao_comp_venda ~n' + 'Problemas ao consultar a tabela "lancamento_caixa": ~n' + itr_filial.sqlerrtext
		Return False
	End If
	
	If IsNull(li_nr_lancamento) or li_nr_lancamento <= 0 Then
		li_nr_lancamento = 1
	else
		li_nr_lancamento++
	End If
	
	ls_de_historico = 'REF. PED :' + String(il_nr_pedido) + ' - ECOMMERCE'
	
	INSERT INTO lancamento_caixa (
		cd_caixa,
		nr_controle_caixa,
		nr_lancamento,
		cd_conta_fluxo_caixa,
		dh_lancamento,
		vl_lancamento,
		de_historico,
		nr_recibo_cobranca,
		id_sumarizacao,
		id_estorno,
		dh_exportacao,
		nr_documento,
		cd_filial_transferencia)
	VALUES (:ls_cd_caixa,
		:li_nr_controle_caixa,
		:li_nr_lancamento,
		'205', 						//cd_conta_fluxo_caixa
		:ldt_Movimentacao, 	//dh_lancamento 
		:ldc_Total, 				//vl_lancamento
		:ls_de_historico,		//de_historico
		null, 						//nr_recibo_cobranca
		null, 						//id_sumarizacao
		'N', 						//id_estorno
		null, 						//dh_exportacao
		:ls_Documento,				//nr_documento 
		null  						//cd_filial_transferencia
	)
	Using itr_filial;	
	
	If itr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_cartao_comp_venda ~n' + 'Problemas ao inserir registro na tabela "lancamento_caixa": ~n' + itr_filial.sqlerrtext
		Return False
	End If

Finally
	
End Try

return true
end function

public function boolean of_atualiza_pedido (ref string ps_log);String lvs_Mensagem

Decimal 	ldc_Perc_Desconto
	
If idc_Produtos_Calculado = 0 Then
	ps_log = is_objeto + ' Pedido sem produto'
	Return False
End If

ldc_Perc_Desconto = Round(((idc_Desconto / idc_Subtotal) * 100), 2)

If ldc_Perc_Desconto < 0 or isnull(ldc_perc_desconto) Then ldc_Perc_Desconto = 0.00
 
//Aualiza na Filial
update pedido_drogaexpress
Set vl_total_produtos = :idc_Produtos_Calculado, 
	 pc_desconto 		= :ldc_Perc_Desconto, 
	 vl_desconto 		= :idc_Desconto,
	 vl_total_pedido    = :idc_Total
Where nr_pedido_drogaexpress = :is_nr_pedido_filial
Using itr_filial;

If itr_filial.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido ~n' + 'Problemas ao atualizar a tabela "pedido_drogaexpress": ~n' + itr_filial.sqlerrtext
	Return False
End If

//Atualiza na Matriz
Update pedido_ecommerce
	Set nr_pedido_drogaexpress = :is_nr_pedido_filial,
		 id_situacao = :is_id_situacao,
		 nr_cep_ent = :is_CEP_Ent
Where cd_filial_ecommerce =:il_cd_filial
	AND nr_pedido =:il_nr_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido ~n' + 'Problemas ao atualizar a tabela "pedido_ecommerce": ~n' + SqlCa.sqlerrtext
	Return False
End If

Return True
end function

public function boolean of_forma_pagamento (long pl_id_pagamento, ref string ps_log);
Choose Case pl_id_pagamento

//	Case 'RESGATE' 
//		is_Tipo_Vale				= lvs_Nulo
//		is_Cupom_Desconto 		= '1'
//		//idc_ValeCompra 			= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_Parcelas, 'ValorParcela'),'.',',',0))
		
	Case 3, 12, 19 //'BOLETO BANC$$HEX1$$c100$$ENDHEX$$RIO'

		is_Forma_Pagto = 'DI'
		
	Case 6, 7, 8, 24 // Cartao de cr$$HEX1$$e900$$ENDHEX$$dito

		is_Forma_Pagto = 'CP'
	
	Case Else
		ps_log = 'Tipo de pagamento n$$HEX1$$e300$$ENDHEX$$o previsto: ' + string(pl_id_pagamento)
		Return False

End Choose
		

Return True

end function

public function boolean of_saldo_produto_reservado (long pl_cd_produto, ref long pl_qt_saldo_pendente, ref string ps_log);long ll_saldo

TRY
	
	SELECT COALESCE( SUM( pep.qt_pedida ), 0 )
	INTO :ll_saldo
	FROM pedido_ecommerce pe
		INNER JOIN pedido_ecommerce_produto pep
			ON pep.nr_pedido = pe.nr_pedido
	WHERE pe.dh_compra >= (select DATEADD (day , -30 , dh_movimentacao ) from parametro where id_parametro = '1')
	AND pe.cd_filial			= :il_cd_filial_pedido
	AND pe.id_situacao	in ('A')
	AND pe.nr_pedido_ecommerce is not null
	AND pep.cd_produto	= :pl_cd_Produto
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_produto_reservado ~n' + 'Problemas ao consultar o saldo pendente do produto: ~n' + sqlca.sqlerrtext
		Return False		
	End If
	
	pl_qt_Saldo_Pendente = ll_saldo
	
FINALLY
	
	If IsNull( pl_qt_Saldo_Pendente ) Then pl_qt_Saldo_Pendente = 0
	
END TRY

Return True
end function

public function boolean of_saldo_disponivel_distrib (long pl_cd_produto, string ps_distribuidora, string ps_chamada, ref decimal pdc_fator_conversao, ref long pl_qt_saldo, ref string ps_log);/* Argumento ps_chamada: SALDO (Quando est$$HEX1$$e100$$ENDHEX$$ enviando saldo para a Vannon) ou PEDIDO (Quando est$$HEX1$$e100$$ENDHEX$$ relizando pedido empurrado ) 
*/

Long ll_Sobra_Fracionada_Disponivel = 0
Long ll_Saldo								= 0
Long ll_Retorno 							= -1
Long ll_Qt_Empurrada 					= 0
Long ll_Qt_Empurrada_Fracionada 	= 0

Try
			
	If ps_Distribuidora <> CD_DISTRIBUIDORA_ESTOQUE_CENTRAL Then
		
		uo_filial lo_Filial
		lo_Filial = Create uo_filial
		
		lo_Filial.of_Localiza_Filial(String(il_cd_filial_pedido))
		
		If Not lo_Filial.Localizada Then Return false
		
		If Upper( ps_Chamada ) = 'SALDO' Then	
			
			Select COALESCE( d.qt_estoque_disponivel , 0 ), 
					 COALESCE( g.vl_fator_conversao, 1 )
				INTO	:ll_Saldo,
						:pdc_Fator_Conversao
				From distribuidora_produto d
				Inner join fornecedor f
					on f.cd_fornecedor = d.cd_distribuidora
				Inner join filial_distribuidora fd
					on fd.cd_distribuidora = d.cd_distribuidora
				Inner join produto_geral g
					on g.cd_produto = d.cd_produto
				Where fd.cd_filial = :il_cd_filial_pedido
					and d.cd_produto = :pl_cd_Produto
					and d.cd_distribuidora	= :ps_Distribuidora
					and d.cd_unidade_federacao = :lo_Filial.Cd_Unidade_Federacao
					and coalesce(f.id_atende_pedido_ecommerce, 'N') = 'S'
					and coalesce(f.id_situacao, 'A') = 'A'
					and fd.id_situacao = 'A'
					and d.id_situacao = 'A'
					and d.qt_estoque_disponivel > 0
					and coalesce(d.id_estoque_maior_10dias, 'N') = 'S'
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_disponivel_distrib ~n' + 'Problemas ao consultar a tabela "distribuidora_produto"[2]: ~n' + sqlca.sqlerrtext
					return false
				end if
			
		Else // If Upper( ps_Chamada ) <> 'SALDO'
			
			Select COALESCE( d.qt_estoque_disponivel , 0 ), 
					 COALESCE( g.vl_fator_conversao, 1 )
				INTO	:ll_Saldo,
						:pdc_Fator_Conversao
				From distribuidora_produto d
				Inner join fornecedor f
					on f.cd_fornecedor = d.cd_distribuidora
				Inner join filial_distribuidora fd
					on fd.cd_distribuidora = d.cd_distribuidora
				Inner join produto_geral g
					on g.cd_produto = d.cd_produto
				Where  fd.cd_filial = :il_cd_filial_pedido
					and d.cd_produto = :pl_cd_Produto
					and d.cd_distribuidora	= :ps_Distribuidora
					and d.cd_unidade_federacao = :lo_Filial.Cd_Unidade_Federacao
					and coalesce(f.id_atende_pedido_ecommerce, 'N') = 'S'
					and coalesce(f.id_situacao, 'A') = 'A'
					and fd.id_situacao = 'A'
					and d.id_situacao = 'A'
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_disponivel_distrib ~n' + 'Problemas ao consultar a tabela "distribuidora_produto"[2]: ~n' + sqlca.sqlerrtext
					return false
				end if
				
		End If			
				
	Else
		//CD
		
		SELECT	dbo.saldo_atual_estoque_central( :il_cd_filial_pedido, :pl_cd_produto, 'S'),
					COALESCE( g.vl_fator_conversao, 1 ) as vl_fator_conversao
			INTO	:ll_Saldo,
					:pdc_Fator_Conversao
		  FROM vw_saldo_atual_produto s
				INNER JOIN produto_geral g
					ON g.cd_produto = s.cd_produto
		WHERE s.cd_filial = :il_cd_filial_pedido
			AND s.cd_produto = :pl_cd_produto
		Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_disponivel_distrib ~n' + 'Problemas ao consultar a view "vw_saldo_atual_produto": ~n' + sqlca.sqlerrtext
			return false
		end if
	
	End If
	
//	//Verifica qtde empurrada


	//Qtde empurrada distribuidora
	SELECT	COALESCE( SUM( prd.qt_empurrada ), 0 ) as qt_empurrada, 
				COALESCE( SUM( prd.qt_empurrada_fracionada ), 0 ) as qt_empurrada_fracionada 
		INTO :ll_Qt_Empurrada, :ll_Qt_Empurrada_Fracionada
	FROM pedido_empurrado p
		INNER JOIN pedido_empurrado_produto prd
			ON prd.cd_filial = p.cd_filial
			AND prd.nr_pedido_empurrado	= p.nr_pedido_empurrado
		WHERE prd.cd_produto = :pl_cd_produto
			AND COALESCE( p.cd_distribuidora, '053404705' ) = :ps_Distribuidora
			AND p.id_tipo_pedido = 'F' // Farmagora
			AND p.id_situacao = 'C' //Colocado
	USING SqlCa;
			
	If SqlCa.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_disponivel_distrib ~n' + 'Problemas ao consultar a tabela "pedido_empurrado": ~n' + sqlca.sqlerrtext
		return false
	end if
	
	If ps_Distribuidora = CD_DISTRIBUIDORA_ESTOQUE_CENTRAL Then
		ll_Saldo = ll_Saldo + ll_Qt_Empurrada 
	End If
	
	If ll_Qt_Empurrada_Fracionada = 0 Then
		ll_Retorno = ll_Saldo * pdc_Fator_Conversao
		pl_qt_saldo = ll_retorno
		
		return true
	End If

	ll_Saldo = ll_Saldo - ll_Qt_Empurrada	
	
	If ll_Saldo < 0 Then ll_Saldo = 0
	
	If pdc_Fator_Conversao = 1 Then
		ll_Retorno = ll_Saldo
		pl_qt_saldo = ll_retorno
		
		Return true
	End If
			
	ll_Sobra_Fracionada_Disponivel = ( ll_Qt_Empurrada_Fracionada - ( pdc_Fator_Conversao * ll_Qt_Empurrada ) ) * -1
	
	ll_Retorno = ( ll_Saldo * pdc_Fator_Conversao ) + ll_Sobra_Fracionada_Disponivel
	
	pl_qt_saldo = ll_retorno
	
	return true
	
Finally
	If ll_Retorno >= 0 Then
		//This.of_Grava_Arquivo( "[OK] Consulta saldo_atual do produto " + String( pl_Produto ) + " da distribuidora " + ps_Distribuidora + ". Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_disponivel_distribuidora. Quantidade Retornada: " + String( ll_Saldo ) + " * " + String( pdc_Fator_Conversao ) + " | ps_chamada: " + ps_Chamada, FALSE )
	End If
End Try

return true
end function

public function boolean of_processa_pedido_empurrado (long pl_cd_produto, long pl_qtde, ref string ps_log);Integer li_nr_ordem

Long ll_Total_Pedida, ll_Saldo_Filial
Long ll_Saldo, ll_Saldo_Distribuidora
Long ll_Qt_Empurrada, ll_Saldo_Falta
Long ll_Row, ll_Linhas

String ls_Distribuidora

Decimal ldc_Fator_Conversao

dc_uo_ds_base lds_Ordem_Distribuidora

//Produto manip
IF pl_cd_produto = 684431 Then
	Return true
End If

lds_Ordem_Distribuidora = create dc_uo_ds_base
lds_Ordem_Distribuidora.of_changedataobject( 'ds_ge505_ordem_distribuidora_produto')

If Not of_saldo_produto_reservado(pl_cd_produto, Ref ll_Total_Pedida, ref ps_log) Then
	Return false
End If

//------------PRIMEIRO Verifica saldo filial ---------
SELECT	COALESCE( s.qt_saldo_final, 0 ) AS qt_saldo_final
	INTO	:ll_Saldo_Filial
  FROM vw_saldo_atual_produto s
WHERE s.cd_filial	= :il_cd_filial_pedido
	AND s.cd_produto = :pl_cd_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido_empurrado ~n' + 'Problemas ao consultar a view "vw_saldo_atual_produto": ~n' + sqlca.sqlerrtext
	Return false
End If
//
////of_Grava_Arquivo( "Produto / Saldo Filial / Total Pedida / Qt_Pedido: " + String( pl_produto ) + " / " + String(ll_Saldo_Filial) + " / " + String( ll_Total_Pedida ) + " / " + String(ai_qtde_pedido_ecommerce), False )
//
////ll_Saldo_Filial negativo = saldo da loja - qtde de pedido em aberto j$$HEX1$$e100$$ENDHEX$$ cadastrado 
IF ll_Saldo_Filial < ll_Total_Pedida Then
	//Saldo falta $$HEX1$$e900$$ENDHEX$$ quantida do pedido em atualizacao
	ll_Saldo_Falta = pl_qtde
Else
	ll_Saldo_Filial =  ll_Saldo_Filial - ll_Total_Pedida - pl_qtde
		
	If ll_Saldo_Filial >= 0 Then
		Return true //a loja possui saldo disponivel para atender o ped Ecommerce
	End If
	
	ll_Saldo_Falta = ll_Saldo_Filial * -1	
End If

ll_Linhas = lds_Ordem_Distribuidora.Retrieve( il_cd_filial_pedido, pl_cd_produto )

If ll_Linhas < 0 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido_empurrado ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext
	Return false
End If

For ll_Row = 1 TO ll_Linhas
	
	ls_Distribuidora = lds_Ordem_Distribuidora.Object.cd_distribuidora [ ll_Row ]  
		
	//ll_saldo_Distribuidora considera a quantidade dos pedidos empurrados em aberto
	If Not this.of_saldo_disponivel_distrib( pl_cd_produto, ls_Distribuidora, 'PEDIDO', ref ldc_Fator_Conversao, ref ll_saldo, ref ps_log ) Then return false
	
//	of_Grava_Arquivo( "Produto / Dist./ Saldo Dist. / Tot Falta: " + String( pl_produto ) + " / " + ls_Distribuidora + " / " + String( ll_Saldo ) + " / " + String(ll_Saldo_Falta), False )
	
	If ll_saldo < 0 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido_empurrado ~n' + 'Saldo negativo na distribuidora /' + ls_Distribuidora + '/ produto: ' +  String(pl_cd_produto)
		Return false
	End If
	
	If ll_saldo >= ll_Saldo_Falta Then
		ll_saldo = ll_Saldo_Falta	
	End If
	
	//Empurra pedido
	If ll_Saldo > 0 Then
		If Not this.of_grava_pedido_empurrado( pl_cd_produto, pl_qtde, ls_distribuidora, ldc_fator_conversao, ll_saldo, ref ps_log ) Then return false
	End If

	ll_Saldo_Falta = ll_Saldo_Falta - ll_Saldo
	
	//Pedido total atendido 
	If ll_Saldo_Falta = 0 Then
		Exit
	End If
	
Next

return true
end function

public function boolean of_grava_pedido_empurrado (long pl_cd_produto, long pl_qtde, string ps_distribuidora, decimal pdc_fator_conversao, long pl_saldo_falta, ref string ps_log);Long ll_Numero_Pedido					= 0
Long ll_Qt_a_Empurrar_Fracionada	= 0
Long ll_Qt_a_Empurrar_Caixa 			= 0
Long ll_Qt_Empurrada_Fracionada 	= 0

String ls_Saldo_Exclusivo_CD
String ls_Situacao

DateTime ldh_Parametro

Try
	ls_Saldo_Exclusivo_CD = IIF( ps_Distribuidora = "053404705", "S", "N" )
	
	ldh_Parametro = gvo_Parametro.of_Dh_Movimentacao( )
	
	ls_Situacao = 'C' // COLOCADO
	
	// Deixa como CANCELADO caso esteja sendo realizados testes de desenvolvimento
	If Not IsNull(il_Filial_Desenv) Then ls_Situacao = 'X' 
		
	//Verifica QTDE a empurrar
	ll_Qt_a_Empurrar_Fracionada 	= pl_Saldo_Falta	//quantidade fracionada
	ll_Qt_a_Empurrar_Caixa			= Ceiling( pl_Saldo_Falta /  pdc_fator_conversao ) // Calcula a quantidade de caixa fechada

	// Verifica se h$$HEX1$$e100$$ENDHEX$$ pedido colocado para incluir produto
	SELECT TOP 1 nr_pedido_empurrado
	INTO :ll_Numero_Pedido
	FROM pedido_empurrado
	WHERE cd_filial = :il_cd_filial_pedido
	AND Coalesce(cd_distribuidora,'053404705') = :ps_Distribuidora	//Distribuidora
	AND id_tipo_pedido	= 'F' // Farmagora
	AND id_situacao = 'C'// Colocado
	ORDER BY nr_pedido_empurrado DESC
	USING SqlCa;

	Choose Case SqlCa.SqlCode
		Case -1
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_empurrar_pedido ~n' + 'Problemas ao consultar a tabela "pedido_empurrado": ~n' + sqlca.sqlerrtext
			Return false
			
		Case 0
			
			// Verifica se existe o produto no pedido
			SELECT COALESCE( qt_empurrada_fracionada, 0 )
			INTO :ll_Qt_Empurrada_Fracionada
			FROM pedido_empurrado_produto
			WHERE cd_filial = :il_cd_filial_pedido
			AND nr_pedido_empurrado = :ll_Numero_Pedido
			AND cd_produto = :pl_cd_Produto
			USING SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case -1
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_empurrar_pedido ~n' + 'Problemas ao consultar a tabela "pedido_empurrado_produto": ~n' + sqlca.sqlerrtext
					Return false
					
				Case 0 //Existe produto Pedido
					
					UPDATE pedido_empurrado_produto
					SET qt_empurrada = COALESCE(qt_empurrada,0) + :ll_Qt_a_Empurrar_Caixa,
						  qt_empurrada_fracionada = COALESCE(qt_empurrada_fracionada,0) + :ll_Qt_a_Empurrar_Fracionada
					WHERE cd_filial = :il_cd_filial_pedido
					AND nr_pedido_empurrado = :ll_Numero_Pedido
					AND cd_produto = :pl_cd_produto
					USING SqlCa;
					
					if sqlca.sqlcode = -1 then
						ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_empurrar_pedido ~n' + 'Problemas ao atualizar a tabela "pedido_empurrado_produto": ~n' + sqlca.sqlerrtext
						Return false
					end if
					
				Case 100 //N$$HEX1$$e300$$ENDHEX$$o existe produto pedido
									
					INSERT INTO pedido_empurrado_produto
					(   cd_filial,
						nr_pedido_empurrado,
						cd_produto,
						qt_empurrada,
						qt_faturada,
						id_situacao,
						qt_empurrada_fracionada)
					VALUES (:il_cd_filial_pedido, //cd_filial
								:ll_Numero_Pedido,	//nr_pedido_empurrado
								:pl_cd_produto, // cd_produto
								:ll_Qt_a_Empurrar_Caixa, // qt_empurrada
								0, // qt_faturada
								:ls_Situacao,
								:ll_Qt_a_Empurrar_Fracionada
								)
					USING SqlCa;
				
					if sqlca.sqlcode = -1 then
						ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_empurrar_pedido ~n' + 'Problemas ao inserir registro na tabela "pedido_empurrado_produto": ~n' + sqlca.sqlerrtext
						Return false
					end if

			End Choose // SELECT COALESCE( qt_empurrada, 0 )
		
		Case 100 // N$$HEX1$$e300$$ENDHEX$$o existe pedido colocado
			
			SELECT COALESCE( MAX( nr_pedido_empurrado ), 0 ) + 1
			INTO :ll_Numero_Pedido
			FROM pedido_empurrado
			WHERE cd_filial = :il_cd_filial_pedido
			USING SqlCa;
			
			if sqlca.sqlcode = -1 then
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_empurrar_pedido ~n' + 'Problemas ao consultar a tabela "pedido_empurrado": ~n' + sqlca.sqlerrtext
				Return false
			end if
			
			INSERT INTO pedido_empurrado (
				cd_filial,
				nr_pedido_empurrado,
				dh_emissao,
				id_processado,
				id_tipo_pedido,
				id_situacao,
				id_reserva_saldo_cd,
				dh_inclusao,
				nr_matricula_inclusao,
				dh_cancelamento,
				nr_matricula_cancelamento,
				cd_distribuidora)
			VALUES (
					:il_cd_filial_pedido, //cd_filial
					:ll_Numero_Pedido,	//nr_pedido_empurrado
					:ldh_Parametro, //dh_emissao
					'N', // id_processado
					'F', // id_tipo_pedido = FARMAGORA
					:ls_Situacao,
					:ls_Saldo_Exclusivo_CD, // id_reserva_saldo_cd
					getdate( ), // dh_inclusao
					'14330', // nr_matricula_inclusao
					Null, // dh_cancelamento
					Null, // nr_matricula_cancelamento
					:ps_Distribuidora
				)
			Using SqlCa;
		
			if sqlca.sqlcode = -1 then
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_empurrar_pedido ~n' + 'Problemas ao inserir registro na tabela "pedido_empurrado": ~n' + sqlca.sqlerrtext
				Return false
			end if
		
			INSERT INTO pedido_empurrado_produto
				(   cd_filial,
					nr_pedido_empurrado,
					cd_produto,
					qt_empurrada,
					qt_faturada,
					id_situacao,
					qt_empurrada_fracionada)
				VALUES (:il_cd_filial_pedido, //cd_filial
							:ll_Numero_Pedido,	//nr_pedido_empurrado
							:pl_cd_produto, // cd_produto
							:ll_Qt_a_Empurrar_Caixa,	// qt_empurrada
							0, // qt_faturada
							:ls_Situacao,
							:ll_Qt_a_Empurrar_Fracionada 
						)
				Using SqlCa;
			
			if sqlca.sqlcode = -1 then
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_empurrar_pedido ~n' + 'Problemas ao inserir registro na tabela "pedido_empurrado_produto": ~n' + sqlca.sqlerrtext
				Return false
			end if
					
	End Choose // SELECT TOP 1 nr_pedido_empurrado
	
	//This.of_Grava_Arquivo( "[OK] Pedido empurrado: " + String( ll_Numero_Pedido ) + " | Produto: " + String( pl_produto ) + " | Qtdes empurradas (caixa, fracionada): (" + String( ll_Qt_a_Empurrar_Caixa ) + ", " + String( ll_Qt_a_Empurrar_Fracionada ) + ")" , FALSE )

	 UPDATE pedido_ecommerce_produto
		SET qt_pedida_empurrada = COALESCE(qt_pedida_empurrada,0) + :ll_Qt_a_Empurrar_Fracionada
	WHERE cd_filial_ecommerce 	= :il_cd_filial
		AND nr_pedido = :il_nr_pedido
		AND cd_produto = :pl_cd_produto
	 USING SqlCa;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_empurrar_pedido ~n' + 'Problemas ao atualizar a tabela "pedido_ecommerce_produto": ~n' + sqlca.sqlerrtext
		Return false
	Else
		//This.is_Mensagem_Email_Pedido_Empurrado += "~rProduto: " + String( pl_Produto ) + "~rQtde.: " + String( pl_Saldo_Falta )
	End If
	
Finally
	//
End Try

return true
end function

public function boolean of_busca_filial_site (ref long pl_cd_filial, ref string ps_log, string ps_pedido);long ll_cd_filial_conexao

select top 1 ei.cd_filial_pedido
into :ll_cd_filial_conexao
	from ecommerce_log el
		 inner join ecommerce_log_item ei on ( ei.cd_filial = el.cd_filial and ei.nr_atualizacao = el.nr_atualizacao )
	where ei.nr_pedido_ecommerce = :ps_pedido
	and el.dh_inclusao >= dateadd(dd, -3, getdate())
	and ei.cd_filial_pedido > 0
	order by dh_inclusao desc;
				
if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial_site. ' + 'Problemas ao consultar a tabela "ecommerce_log_item" : ' + sqlca.sqlerrtext
	return false
end if
					
pl_cd_filial = ll_cd_filial_conexao
					
return true
end function

public function boolean of_verifica_cliente_clube (ref string ps_log);
if isnull(is_nr_cpf) or is_nr_cpf = '' then return true

Select cd_cliente
Into :is_cd_cliente_clube
From cliente
Where nr_cpf_cgc =:is_nr_cpf
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
	Case 100
	Case -1
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_cliente_clube. ' + 'Problemas ao consultar a tabela "cliente" : ' + sqlca.sqlerrtext
		Return False
End Choose

Return True
end function

public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, long pl_cd_filial);String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_nr_pedido
String ls_retorno
String ls_id_registro_log

long ll_linhas
Long ll_for
Long ll_Seq_Log
Long ll_existe
Long ll_cd_filial_ant
Long ll_cd_filial_site

boolean lb_sucesso=false
boolean lb_pedido

DateTime ldt_inicio, ldt_termino
DateTime ldh_log_inicio
DateTime ldh_Data_Nula

uo_ge505_comum luo_comum

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

is_rede_filial = ps_rede_filial

try 
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	il_cd_filial = pl_cd_filial
	
	Open(w_Ge501_Aguarde)
	
	w_Ge501_Aguarde.Title = "Ifood - Enviando Pedido (Matriz -> Loja)"

	luo_comum = create uo_ge505_comum
	ids_pedidos = create dc_uo_ds_base
	
	setnull(ls_id_registro_log)
	luo_comum.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )
	
	//Desenvolvimento
	il_Filial_Desenv 	= luo_comum.of_desenvolvimento_filial_baixa_pedido()
	is_ODBC_Desenv 	= luo_comum.of_desenvolvimento_odbc_baixa_pedido()
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	
	if Not luo_comum.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede_filial, is_id_ecommerce, ref ls_log ) Then return false
	
	if not ids_pedidos.of_changedataobject( 'ds_ge505_pedido_loja' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_loja'
		return false
	end if

	ll_linhas = ids_pedidos.retrieve(is_id_ecommerce, ps_rede_filial, pl_cd_filial)

	If ll_Linhas > 0 Then
		luo_comum.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		this.of_limpa_variaveis( )
		
		luo_comum.of_limpa_variaveis( )
		
		ls_nr_pedido = ids_pedidos.object.nr_pedido_ecommerce[ll_for]
		
		If Not IsNull(il_Filial_Desenv) Then
			il_cd_filial_pedido = il_Filial_Desenv
			if Not this.of_busca_filial_site( ref ll_cd_filial_site, ref ls_log, ls_nr_pedido ) Then return false 
		Else
			il_cd_filial_pedido = ids_pedidos.object.cd_filial[ll_for]
			ll_cd_filial_site = il_cd_filial_pedido
			
			If ll_cd_filial_site = 454 Then ll_cd_filial_site = 986
		End If
		
		w_Ge501_Aguarde.Title = "Ifood - Enviando Pedido (Matriz -> Loja) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = "Pedido: " + ls_nr_pedido + " - Filial:" + String(il_cd_filial_pedido)
		
		idc_total 					= ids_pedidos.object.vl_total				[ll_for]
		idc_frete 				= ids_pedidos.object.vl_frete				[ll_for]
		idc_Desconto			= ids_pedidos.object.vl_desconto			[ll_for]
		idc_Subtotal				=  idc_total - idc_frete + idc_Desconto
		
		is_nr_cpf = ids_pedidos.object.nr_cpf_cgc[ll_for]
				
		 //Verifica se o cliente tem cadastro no clube
		If Not of_Verifica_Cliente_Clube(Ref ls_Log) Then 
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO Loja Ifood', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
			luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
			//Return false
		End If
		
		is_observacao = ids_pedidos.object.de_observacao[ll_for]
		is_id_situacao = ids_pedidos.object.id_situacao[ll_for]
		is_endereco_ent 		= ids_pedidos.object.de_endereco_ent		[ll_for]
		is_referencia_ent 		= ids_pedidos.object.de_referencia_ent		[ll_for]
		is_complemento_ent 	= ids_pedidos.object.de_complemento_ent	[ll_for]
		is_bairro_ent 			= ids_pedidos.object.de_bairro_ent			[ll_for]
		is_cep_ent 				= ids_pedidos.object.nr_cep_ent				[ll_for]
		is_cidade_ent 			= ids_pedidos.object.de_cidade_ent			[ll_for]
		is_uf_ent 				= ids_pedidos.object.cd_uf_ent					[ll_for]
		is_numero_ent 			= ids_pedidos.object.nr_endereco_ent		[ll_for]
		is_fone_ent 				= ids_pedidos.object.nr_fone_ent				[ll_for]
		idh_compra = ids_pedidos.object.dh_compra[ll_for]
		il_nr_pedido 	= ids_pedidos.object.nr_pedido			[ll_for]
		is_nome_ent 	= ids_pedidos.object.nm_cliente_ent		[ll_for]
		is_email			= ids_pedidos.object.de_endereco_email[ll_for]
		is_transportadora = ids_pedidos.object.nm_transportadora[ll_for]
		
		is_id_cpf_nf 	= ids_pedidos.object.id_cpf_nf[ll_for]
		
		luo_comum.is_nr_pedido_ecommerce = ls_nr_pedido
		luo_comum.il_cd_filial_pedido 			= il_cd_filial_pedido
				
		If Not this.of_desconecta_filial( ) Then Return false
		
		If Not this.of_conecta_filial( ref ls_log ) Then 
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO Loja Ifood', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
			luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
			//Return false
		End If
		
		//Verifica se o pedido j$$HEX1$$e100$$ENDHEX$$ existe no banco de dados.
		if Not gf_valida_pedido_ecommerce(itr_Filial, ls_nr_pedido, is_id_ecommerce, True, ref ls_log ) Then
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO Loja Ifood', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
			luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		lb_pedido = False
	
		//Grava o pedido
		if this.of_grava_pedido( ls_nr_pedido, ref ls_log ) Then
			if this.of_grava_produto( ref ls_log ) Then 
				if this.of_atualiza_pedido( ref ls_log ) Then
					lb_pedido = True
				end If
			End If
		End If
		
		If Not lb_pedido Then
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO Loja Ifood', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
			luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			sqlca.of_RollBack( )
			itr_filial.of_rollback( )
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End If
					
		itr_filial.of_commit( )
		sqlca.of_commit( )
		
		if Not luo_comum.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
	next
			
	If Not this.of_desconecta_filial( ) Then Return false
			
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_situacao = 'E'
		
		sqlca.of_rollback( )
		itr_filial.of_rollback( )
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not luo_comum.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
		
	this.of_desconecta_filial( )
	
	luo_comum.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )
	
	destroy(ids_pedidos)
	destroy(luo_comum)
	
	destroy(ivo_Conecta_Odbc)
	destroy(itr_Filial)
	destroy(ivo_Odbc)
	
	Close(w_Ge501_Aguarde)
	
End try

return true
end function

public function boolean of_processa_atualizacao_pedido ();long ll_cd_filial, ll_for, ll_linhas
string ls_rede_filial

dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base

if not lds_filiais.of_changedataobject( 'ds_ge505_pedido_loja_filial' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge505_pedido_loja_filial')
	return false
end if
	
ll_linhas = lds_filiais.retrieve( is_id_ecommerce )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if


for ll_for = 1 to ll_linhas
	
	ll_cd_filial = lds_filiais.object.cd_filial[ll_for]
	ls_rede_filial = lds_filiais.object.id_rede_filial[ll_for]
	
	this.of_processa_atualizacao_pedido( ls_rede_filial, ll_cd_filial )
	
next


destroy(lds_filiais)

Return True
end function

on uo_ge505_pedido_loja.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge505_pedido_loja.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

