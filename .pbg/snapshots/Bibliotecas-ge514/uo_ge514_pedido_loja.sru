HA$PBExportHeader$uo_ge514_pedido_loja.sru
forward
global type uo_ge514_pedido_loja from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge514_pedido_loja from uo_ge516_comum_interface_ecommerce
string is_id_ecommerce = "4"
long il_cd_tipo = 9
string is_datastore_dados = "ds_ge514_pedido_loja"
string is_objeto_comum = "uo_ge514_comum_vmpay"
boolean ib_log_individual = true
long il_cd_mensagem_email = 222
string is_mensagem_email_1 = "PEDIDO - LOJA"
end type
global uo_ge514_pedido_loja uo_ge514_pedido_loja

type variables
Long il_nr_Pedido
long il_id_pagamento
long il_maquina

decimal idc_Total
decimal idc_Produtos_Calculado

Integer ii_Parcelas

string is_nr_pedido_filial
String is_nr_pedido_ecommerce
String is_nr_cartao_credito
String is_Bandeira_Cartao
String is_comprovante_cartao
String is_autorizacao_cartao
String is_Estabelecimento
String is_id_cpf_nf
String is_Forma_Pagto

Datetime idh_compra
end variables

forward prototypes
public function boolean of_atualiza_pedido (ref string ps_log)
public function boolean of_grava_cartao_comp_venda (ref string ps_log)
public function boolean of_grava_pedido (ref string ps_log)
public function boolean of_grava_produto (ref string ps_log)
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
end prototypes

public function boolean of_atualiza_pedido (ref string ps_log);String lvs_Mensagem
Decimal 	ldc_Perc_Desconto
	
If idc_Produtos_Calculado = 0 Then
	ps_log = is_objeto + ' Pedido sem produto'
	Return False
End If
 
//Aualiza na Filial
update pedido_drogaexpress
Set vl_total_produtos = :idc_Produtos_Calculado, 
	 vl_total_pedido    = :idc_Total
Where nr_pedido_drogaexpress = :is_nr_pedido_filial
Using itr_filial;

If itr_filial.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido ~n' + 'Problemas ao atualizar a tabela "pedido_drogaexpress": ~n' + itr_filial.sqlerrtext
	Return False
End If

//Atualiza na Matriz
Update pedido_ecommerce
	Set nr_pedido_drogaexpress 	= :is_nr_pedido_filial,
		 id_situacao = 'A'
Where cd_filial_ecommerce =:il_cd_filial
	AND nr_pedido =:il_nr_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido ~n' + 'Problemas ao atualizar a tabela "pedido_ecommerce": ~n' + SqlCa.sqlerrtext
	Return False
End If

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

Decimal {2} ldc_Total

Try

	ldc_Total = idc_Total
	
	ls_Documento = String(il_nr_pedido)
	
	If ii_Parcelas < 1 Then
		ps_log = 'Quantidade de parcelas do cart$$HEX1$$e300$$ENDHEX$$o [' + String( ii_Parcelas ) + '] inv$$HEX1$$e100$$ENDHEX$$lida.'
		Return False
	End If
	
	ldt_Movimentacao	= gf_GetServerDate( )
	ldt_Atual				= Date( ldt_Movimentacao )
	ls_Cd_Caixa			= String( il_filial_disque, "0000" ) + "00"
	
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
		ps_log = "Sem caixa geral aberto " + ls_Cd_Caixa + " Pedido " + string(il_nr_pedido) 
		Return False
	End If

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
	
	is_comprovante_cartao	= Mid(trim(is_comprovante_cartao), 1, 20) // NSU
	is_autorizacao_cartao		= Mid(trim(is_autorizacao_cartao), 1, 10)
	
	is_Estabelecimento		= Mid(trim(is_Estabelecimento), 1, 10)
	is_Bandeira_Cartao		= Mid(trim(is_Bandeira_Cartao), 1, 40)
	is_nr_cartao_credito 		= '0000000000000'
			
	If ldc_Total = 0.00 Then
		ps_log = 'Valor do cartao_comprovante_venda est$$HEX1$$e100$$ENDHEX$$ igual a 0.'
		Return False
	End If
	
	ll_Pedido_Ecommerce = il_nr_pedido	
	
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
		'0', 	//nr_autorizacao
		:is_comprovante_cartao, 	//nr_nsu
		:ldt_Movimentacao, 			//dh_venda
		:ldc_Total, 						//vl_venda
		:ii_Parcelas, 					//qt_parcelas
		'T', 								//id_captura
		'N', 								//id_cancelamento
		:il_filial_disque, 				//cd_filial 
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
	
	ls_de_historico = 'REF. PED:' + String(il_nr_pedido) + ' - VM'
	
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
		'256', 						//cd_conta_fluxo_caixa
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

public function boolean of_grava_pedido (ref string ps_log);Decimal ldc_Pc_Desconto

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

SetNull(ls_Nulo)

ldt_Movimentacao = gf_GetServerDate()

ls_Hora = String(Hour( time(ldt_Movimentacao) ), "00")

//N$$HEX1$$e300$$ENDHEX$$o pontuar no clube DC. Existe pontua$$HEX2$$e700e300$$ENDHEX$$o exclusiva para o farmagora.
ls_Venda_Clube = "N"

//// Localiza o pr$$HEX1$$f300$$ENDHEX$$ximo pedido do Disque Entrega

If Not gf_proximo_pedido_drogaexpress(il_filial_disque, ref is_nr_pedido_filial, ref ps_log) Then return false

is_nr_cartao_credito = Mid(trim(is_nr_cartao_credito), 1, 19)
is_Bandeira_Cartao = Mid(trim(is_Bandeira_Cartao), 1, 40)

is_comprovante_cartao = Mid(trim(is_comprovante_cartao), 1, 20)
is_autorizacao_cartao = Mid(trim(is_autorizacao_cartao), 1, 10)
is_Estabelecimento = Mid(trim(is_Estabelecimento), 1, 10)

INSERT INTO pedido_drogaexpress  
	 (  nr_pedido_drogaexpress,   
		cd_filial,   
		dh_emissao,   
		hr_emissao,     
		cd_cliente_drogaexpress,
		vl_total_produtos,     
		vl_total_pedido,     
		vl_cobrar,   
		vl_pago,   
		id_situacao,   
		cd_tipo_venda,   
		cd_forma_pagamento,   
		nr_matricula_vendedor,   
		nr_matricula_operador,   
		de_especie_doc_fiscal,   
		nr_cartao_credito,       
		id_venda_clube,      
		nr_pedido_ecommerce,
		nr_parcelas_pagamento,
		nm_administradora_cartao,
		nr_comprovante_cartao_credito,
		nr_autorizacao_cartao_credito,
		cd_estabelecimento_cartao_credito,
		cd_filial_ecommerce,
		id_rede_ecommerce,
		nr_pedido_ecommerce_site,
		id_plataforma_ecommerce,
		pc_desconto,
		vl_vale_compra,
		vl_taxa_entrega,
		nr_vending_machine,
		dh_compra)  
Values( :is_nr_pedido_filial,							//nr_pedido_drogaexpress,   
		:il_filial_disque,					//cd_filial,   
		:ldt_Movimentacao,				//dh_emissao,   
		:ls_Hora,							//hr_emissao,   
		'999999',								//cd_cliente_drogaexpress,   
		0,										//vl_total_produtos,   
		:idc_Total,							//vl_total_pedido,    
		0,										//vl_cobrar,   
		0,										//vl_pago,   
		'A',									//id_situacao,   
		'AV',									//cd_tipo_venda,   
		:is_Forma_Pagto,		//cd_forma_pagamento,   
		'14330',								//nr_matricula_vendedor,   
		'14330',								//nr_matricula_operador,   
		'CF',									//de_especie_doc_fiscal,   
		:is_nr_cartao_credito ,					//nr_cartao_credito,       
		:ls_Venda_Clube,					//id_venda_clube,     
		:il_nr_Pedido,							//nr_pedido_ecommerce,
		:ii_Parcelas,						//nr_parcelas_pagamento,
		:is_Bandeira_Cartao,         	// nm_administradora_cartao
		:is_comprovante_cartao,		// nr_comprovante_cartao_credito,
		:is_autorizacao_cartao,			// nr_autorizacao_cartao_credito
		:is_Estabelecimento,				// cd_estabelecimento_cartao_credito
		:il_cd_filial,							//cd_filial_ecommerce
		:is_Rede_Filial,
		:is_nr_pedido_ecommerce,
		:is_id_ecommerce,
		0,
		0,
		0,
		:il_maquina,
		:idh_compra)
using itr_filial;	

if itr_filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Problemas ao inserir registro na tabela "pedido_drogaexpress": ~n' + itr_filial.sqlerrtext
	return false
end if

Return True
end function

public function boolean of_grava_produto (ref string ps_log);Decimal 	ldc_Perc_Desconto,&
			ldc_Preco_Praticado,&
			ldc_Preco_Liquido, ldc_preco
			
String ls_descricao
long ll_linhas, ll_for, ll_qtde, ll_requisicao_manip, ll_cd_produto, ll_sequencial

dc_uo_ds_base lds_produtos

lds_produtos = create dc_uo_ds_base
lds_produtos.of_changedataobject( 'ds_ge514_pedido_loja_produto')

ll_linhas = lds_produtos.retrieve(il_cd_filial, il_nr_pedido )

if ll_linhas < 0 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext
	return false
end if

idc_Produtos_Calculado = 0

for ll_for = 1 to ll_linhas

	ldc_Preco_Liquido = lds_produtos.object.vl_preco_promocao[ll_for]
	ldc_preco = lds_produtos.object.vl_preco[ll_for]
	ll_qtde = lds_produtos.object.qt_pedida[ll_for]
	ll_requisicao_manip = lds_produtos.object.nr_requisicao_manip[ll_for]
	ll_cd_produto = lds_produtos.object.cd_produto[ll_for]
	ll_sequencial = lds_produtos.object.nr_sequencial[ll_for]
	ls_descricao = lds_produtos.object.nm_produto[ll_for]
	
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
		
Next
	
Return True
end function

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);pl_linhas = ids_dados.retrieve( is_id_ecommerce )

return true
end function

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);boolean lb_sucesso = false
string ls_rede

il_cd_filial 						= ids_dados.object.cd_filial[pl_linha]
is_nr_pedido_ecommerce 	= ids_dados.object.nr_pedido_ecommerce[pl_linha]
idc_total 							= ids_dados.object.vl_total[pl_linha]
is_nr_cartao_credito 			= ids_dados.object.nr_cartao_credito[pl_linha]
il_nr_pedido 					= ids_dados.object.nr_pedido[pl_linha]
ii_parcelas 						= ids_dados.object.nr_parcelas[pl_linha]
is_bandeira_cartao 			= ids_dados.object.nm_administradora_cartao[pl_linha]
is_estabelecimento 			= ids_dados.object.cd_estabelecimento_cartao[pl_linha]
il_id_pagamento 				= ids_dados.object.id_pagamento[pl_linha]
il_maquina 						= ids_dados.object.nr_vending_machine[pl_linha]
ls_rede 							= ids_dados.object.id_rede_filial[pl_linha]
is_Rede_Filial 					= ids_dados.object.id_rede_filial[pl_linha]
idh_compra 					= ids_dados.object.dh_compra[pl_linha]

is_Forma_Pagto 			= ids_dados.object.cd_forma_pagamento[pl_linha]
is_comprovante_cartao 	= ids_dados.object.nr_comprovante_cartao_credito[pl_linha] // NSU
is_autorizacao_cartao 	= ids_dados.object.nr_autorizacao_cartao_credito[pl_linha]

//Preenche email de log
is_mensagem_email_2 = 'Pedido: ' + is_nr_pedido_ecommerce

iuo_comum.is_rede_ecommerce = ls_rede

iuo_comum.is_nr_pedido_ecommerce = is_nr_pedido_ecommerce
iuo_comum.il_cd_filial_pedido = il_cd_filial

if il_Filial_Desenv > 0 then
 	il_filial_disque = il_filial_desenv	
else
	il_filial_disque = il_cd_filial
end if

//Desconecta da filial
if Not this.of_desconecta_filial( ) then return false

//Conecta na filial
if this.of_conecta_filial( ref ps_log ) then
	
	//Verifica se o pedido j$$HEX1$$e100$$ENDHEX$$ existe no banco de dados.
	if gf_valida_pedido_ecommerce(itr_filial, is_nr_pedido_ecommerce, is_id_ecommerce, True, ref ps_log ) Then
	
		//Grava o pedido na filial
		if this.of_grava_pedido( ref ps_log ) then 
			//Grava os produtos na filial
			If this.of_grava_produto( ref ps_log ) then
				//Atualiza o pedido na matriz
				If this.of_atualiza_pedido( ref ps_log ) then
					//Grava comprovante cart$$HEX1$$e300$$ENDHEX$$o
					If this.of_grava_cartao_comp_venda( ref ps_log ) then
						lb_sucesso = True
					end if
				end if
			end if
		end if
	end if
end if

return lb_sucesso
end function

on uo_ge514_pedido_loja.create
call super::create
end on

on uo_ge514_pedido_loja.destroy
call super::destroy
end on

