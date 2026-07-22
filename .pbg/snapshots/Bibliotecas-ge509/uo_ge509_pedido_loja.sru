HA$PBExportHeader$uo_ge509_pedido_loja.sru
forward
global type uo_ge509_pedido_loja from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge509_pedido_loja from uo_ge516_comum_interface_ecommerce
boolean ib_grava_log_historico = true
string is_id_ecommerce = "5"
long il_cd_tipo = 9
string is_datastore_dados = "ds_ge509_pedido_loja"
string is_objeto_comum = "uo_ge509_comum_consulta_remedio"
long il_cd_mensagem_email = 289
string is_mensagem_email_1 = "PEDIDO - LOJA"
end type
global uo_ge509_pedido_loja uo_ge509_pedido_loja

type variables
string is_nr_pedido_ecommerce
String is_de_endereco_entrega   
String is_de_referencia_entrega   
String is_de_bairro_entrega   
String is_nr_telefone_entrega
String is_nr_cpf   
String is_nm_cliente
String is_nm_cliente_entrega
String is_nr_cep
String is_nm_transportadora
String is_nm_cidade_entrega
String is_cd_uf_entrega
String is_de_complemento_endereco
String is_nr_telefone_contato
String is_nr_endereco_entrega
String is_de_email
String is_cd_conveniado
String is_nr_pedido_filial
String is_id_tipo_entrega
String is_id_situacao

Long il_cd_filial_ecommerce
Long il_cd_convenio
Long il_cd_condicao_convenio
Long il_nr_pedido
Long il_nr_sequencial_reserva
Long il_cd_cidade_entrega
Long il_cd_filial_ant

decimal{2} idc_vl_Total, idc_Produtos_Calculado, idc_vl_frete

Datetime idh_compra

dc_uo_ds_base ids_produtos
end variables

forward prototypes
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
public function boolean of_grava_pedido (ref string ps_log)
public function boolean of_grava_produto (ref string ps_log)
public function boolean of_atualiza_pedido (ref string ps_log)
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
public function boolean of_grava_reserva (ref string ps_log)
public subroutine of_limpa_variaveis ()
public function boolean of_aprovar_pedido (ref string ps_log)
public subroutine of_configurar_parametros ()
end prototypes

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);
w_Aguarde_3.title = 'CONSULTA REMEDIOS - PEDIDO LOJA'

pl_linhas = ids_dados.retrieve( is_id_ecommerce, is_rede_filial, il_filial_disque )

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
//
SetNull(ls_Nulo)

ldt_Movimentacao = gf_GetServerDate()

ls_Hora = String(Hour( time(ldt_Movimentacao) ), "00")

//N$$HEX1$$e300$$ENDHEX$$o pontuar no clube DC. Existe pontua$$HEX2$$e700e300$$ENDHEX$$o exclusiva para o farmagora.
ls_Venda_Clube = "N"

// Observa$$HEX2$$e700e300$$ENDHEX$$o pedido
is_de_endereco_entrega = Mid(trim(is_de_endereco_entrega), 1, 60)
is_de_referencia_entrega = Mid(trim(is_de_referencia_entrega), 1, 150)
is_de_bairro_entrega = Mid(trim(is_de_bairro_entrega), 1, 20)
is_nr_telefone_entrega = Mid(trim(is_nr_telefone_entrega), 1, 20)
is_nm_cliente_entrega = Mid(trim(is_nm_cliente_entrega), 1, 60)
is_nm_transportadora = Mid(trim(is_nm_transportadora), 1, 30)
is_nm_cidade_entrega = Mid(trim(is_nm_cidade_entrega), 1, 30)
is_de_complemento_endereco = Mid(trim(is_de_complemento_endereco), 1, 40)
is_nr_telefone_contato = Mid(trim(is_nr_telefone_contato), 1, 20)
is_nr_endereco_entrega = Mid(trim(is_nr_endereco_entrega), 1, 6)

//// Localiza o pr$$HEX1$$f300$$ENDHEX$$ximo pedido do Disque Entrega
If Not gf_proximo_pedido_drogaexpress(il_filial_disque, ref is_nr_pedido_filial, ref ps_log) Then return false

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
		id_venda_clube,      
		nr_pedido_ecommerce,
		cd_filial_ecommerce,
		id_rede_ecommerce,
		nr_pedido_ecommerce_site,
		id_plataforma_ecommerce,
		pc_desconto,
		vl_vale_compra,
		vl_taxa_entrega,
		dh_compra,
		de_endereco_entrega,   
		de_referencia_entrega,   
		de_bairro_entrega,   
		nr_telefone_entrega,
		nr_cpf_cheque,   
		nm_cliente_cheque,
		nm_cliente_entrega,
		nr_cep_entrega,
		nm_transportadora,
		nm_cidade_entrega,
		cd_uf_entrega,
		de_complemento_endereco,
		nr_telefone_contato,
		nr_endereco_entrega,
		de_endereco_email,
		cd_cidade_entrega,
		cd_convenio,
		cd_conveniado,
		cd_condicao_convenio)
Values( :is_nr_pedido_filial,							//nr_pedido_drogaexpress,   
		:il_filial_disque,					//cd_filial,   
		:ldt_Movimentacao,				//dh_emissao,   
		:ls_Hora,							//hr_emissao,   
		'999999',								//cd_cliente_drogaexpress,   
		0,										//vl_total_produtos,   
		:idc_vl_Total,							//vl_total_pedido,    
		0,										//vl_cobrar,   
		0,										//vl_pago,   
		'A',									//id_situacao,   
		'CV',									//cd_tipo_venda,   
		'CV',		//cd_forma_pagamento,   
		'14330',								//nr_matricula_vendedor,   
		'14330',								//nr_matricula_operador,   
		'CF',									//de_especie_doc_fiscal,        
		'N',					//id_venda_clube,     
		:il_nr_Pedido,							//nr_pedido_ecommerce,
		:il_cd_filial_ecommerce,							//cd_filial_ecommerce
		:is_Rede_Filial,
		:is_nr_pedido_ecommerce,
		:is_id_ecommerce,
		0,
		0,
		:idc_vl_frete,
		:idh_compra,
		:is_de_endereco_entrega,   
		:is_de_referencia_entrega,   
		:is_de_bairro_entrega,   
		:is_nr_telefone_entrega,
		:is_nr_cpf,   
		:is_nm_cliente,
		:is_nm_cliente_entrega,
		:is_nr_cep,
		:is_nm_transportadora,
		:is_nm_cidade_entrega,
		:is_cd_uf_entrega,
		:is_de_complemento_endereco,
		:is_nr_telefone_contato,
		:is_nr_endereco_entrega,
		:is_de_email,
		:il_cd_cidade_entrega,
		:il_cd_convenio,
		:is_cd_conveniado,
		:il_cd_condicao_convenio)
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
long ll_linhas, ll_for, ll_qtde, ll_cd_produto, ll_sequencial

if not isvalid(ids_produtos) Then 
	ids_produtos = Create dc_uo_ds_base
	ids_produtos.of_changedataobject( 'ds_ge509_pedido_loja_produto')
ENd if

ll_linhas = ids_produtos.retrieve(il_cd_filial_ecommerce, il_nr_pedido )

if ll_linhas < 0 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext
	return false
end if

idc_Produtos_Calculado = 0

for ll_for = 1 to ll_linhas

	ldc_Preco_Liquido = ids_produtos.object.vl_preco_promocao[ll_for]
	ldc_preco = ids_produtos.object.vl_preco[ll_for]
	ll_qtde = ids_produtos.object.qt_pedida[ll_for]
	ll_cd_produto = ids_produtos.object.cd_produto[ll_for]
	ll_sequencial = ids_produtos.object.nr_sequencial[ll_for]
	ls_descricao = ids_produtos.object.nm_produto[ll_for]
	ldc_Perc_Desconto = ids_produtos.object.pc_desconto[ll_for]
	
//	// Se o pre$$HEX1$$e700$$ENDHEX$$o liquido for zerado o desconto vai ser de 100% 
//	If ldc_Preco_Liquido > 0.00 Then
//		ldc_Perc_Desconto = Round((((ldc_preco - ldc_Preco_Liquido) / ldc_preco) * 100), 4)
//	Else
//		ldc_Perc_Desconto = 100.00
//	End If

	ldc_Preco_Praticado = ldc_Preco_Liquido

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
			:ls_descricao)				//de_produto usado para produto manipulado acabado - sem requisicao
	Using itr_filial;
			
	if itr_filial.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao inserir registro na tabela "produto_pedido_drogaexpress": ~n' + itr_filial.sqlerrtext
		return false
	end if
		
Next
	
Return True
end function

public function boolean of_atualiza_pedido (ref string ps_log);String lvs_Mensagem
Decimal 	ldc_Perc_Desconto
	
If idc_Produtos_Calculado < 0 Then
	ps_log = is_objeto + ' Pedido sem produto'
	Return False
End If
 
//Aualiza na Filial
update pedido_drogaexpress
Set vl_total_produtos = :idc_Produtos_Calculado, 
	 vl_total_pedido    = :idc_vl_Total,
	 nr_sequencial_cliente_caixa = :il_nr_sequencial_reserva
Where nr_pedido_drogaexpress = :is_nr_pedido_filial
Using itr_filial;

If itr_filial.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido ~n' + 'Problemas ao atualizar a tabela "pedido_drogaexpress": ~n' + itr_filial.sqlerrtext
	Return False
End If

//Atualiza na Matriz
Update pedido_ecommerce
	Set nr_pedido_drogaexpress = :is_nr_pedido_filial,
		 id_situacao = 'A',
		 nr_sequencial_cliente_caixa = :il_nr_sequencial_reserva
Where cd_filial_ecommerce =:il_cd_filial_ecommerce
	AND nr_pedido =:il_nr_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido ~n' + 'Problemas ao atualizar a tabela "pedido_ecommerce": ~n' + SqlCa.sqlerrtext
	Return False
End If

Return True
end function

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);boolean lb_sucesso = false
string ls_rede

il_cd_filial_ecommerce = ids_dados.object.cd_filial_ecommerce[pl_linha]
il_cd_filial = ids_dados.object.cd_filial[pl_linha]
is_nr_pedido_ecommerce = ids_dados.object.nr_pedido_ecommerce[pl_linha]
idc_vl_total = ids_dados.object.vl_total[pl_linha]
il_nr_pedido = ids_dados.object.nr_pedido[pl_linha]
is_Rede_Filial = ids_dados.object.id_rede_ecommerce[pl_linha]
idh_compra = ids_dados.object.dh_compra[pl_linha]

is_id_situacao = ids_dados.object.id_situacao[pl_linha]
is_id_tipo_entrega = ids_dados.object.id_tipo_entrega[pl_linha]

is_de_endereco_entrega = ids_dados.object.de_endereco_ent[pl_linha]
is_de_referencia_entrega = ids_dados.object.de_referencia_ent[pl_linha]
is_de_bairro_entrega = ids_dados.object.de_bairro_ent[pl_linha]
is_nr_telefone_entrega = ids_dados.object.nr_fone_ent[pl_linha]
is_nr_cpf = ids_dados.object.nr_cpf_cgc[pl_linha]
is_nm_cliente = ids_dados.object.nm_cliente[pl_linha]
is_nm_cliente_entrega = ids_dados.object.nm_cliente_ent[pl_linha]
is_nr_cep = ids_dados.object.nr_cep_ent[pl_linha]
is_nm_transportadora = ids_dados.object.nm_transportadora[pl_linha]
is_nm_cidade_entrega = ids_dados.object.de_cidade_ent[pl_linha]
is_cd_uf_entrega = ids_dados.object.cd_uf_ent[pl_linha]
is_de_complemento_endereco = ids_dados.object.de_complemento_ent[pl_linha]
is_nr_telefone_contato= ids_dados.object.nr_fone_contato_ent[pl_linha]
is_nr_endereco_entrega = ids_dados.object.nr_endereco_ent[pl_linha]
is_de_email = ids_dados.object.de_endereco_email[pl_linha]
il_cd_cidade_entrega = ids_dados.object.cd_cidade[pl_linha]
idc_vl_frete = ids_dados.object.vl_frete[pl_linha]

il_filial_disque = il_cd_filial

w_Aguarde_3.wf_settext('Filial: ' + string(il_cd_filial) + ' (' + is_rede_filial + ')' , 1)
w_Aguarde_3.wf_settext('Pedido: ' + is_nr_pedido_ecommerce + ' (' + string(pl_linha) + ' de ' + string(ids_dados.rowcount()) + ')' , 2)

//if this.is_ped

il_cd_convenio = 54708
is_cd_conveniado = '54708'
il_cd_condicao_convenio = 110

//Preenche email de log
is_mensagem_email_2 = 'Pedido: ' + is_nr_pedido_ecommerce

iuo_comum.is_rede_ecommerce = ls_rede

iuo_comum.is_nr_pedido_ecommerce = is_nr_pedido_ecommerce
iuo_comum.il_cd_filial_pedido = il_cd_filial

if is_pedido_debug <> '' and not isnull(is_pedido_debug) then
	if is_pedido_debug <> is_nr_pedido_ecommerce then
		Return true
	ENd if	
ENd if
	
//Conecta na filial
if Not this.of_conecta_filial( ref ps_log ) then return false
	
//Verifica se o pedido j$$HEX1$$e100$$ENDHEX$$ existe no banco de dados.
if gf_valida_pedido_ecommerce(itr_filial, is_nr_pedido_ecommerce, is_id_ecommerce, True, ref ps_log ) Then

	//Grava o pedido na filial
	if this.of_grava_pedido( ref ps_log ) then 
		//Grava os produtos na filial
		If this.of_grava_produto( ref ps_log ) then
			//Faz reserva dos produtos
			If this.of_grava_reserva( ref ps_log ) Then
				//Atualiza o pedido na matriz/filial
				If this.of_atualiza_pedido( ref ps_log ) then
					//Aprovar o pedido na plataforma ecommerce
					//If this.of_aprovar_pedido( ref ps_log ) then
						lb_sucesso = True
					//end if
				end if
			end if
		end if
	end if
	
end if

return lb_sucesso
end function

public function boolean of_grava_reserva (ref string ps_log);String ls_Nome, ls_Matricula, ls_Tipo_Cliente_Caixa

Long ll_Nr_Sequencial, ll_Linhas, ll_row
Long ll_Produto, ll_Qtde

//Somente gravar reserva se o tipo de entrega for Retirada em loja/Motoboby/armario inteligente/biker delivery/UBER:
if is_id_tipo_entrega = 'MOT' or is_id_tipo_entrega = 'RET' or is_id_tipo_entrega = 'ARM'  or is_id_tipo_entrega = 'BID' or is_id_tipo_entrega = 'UBE' Then

	if isnull(is_id_situacao) Then is_id_situacao = ''
	
	ls_Nome						= 'PED. ECOMMERCE'
	ls_Matricula 				= '14330'
	ls_Tipo_Cliente_Caixa 	= 'R'
	
	select nextval('dbo.cliente_caixa_nr_sequencial_seq')
	Into :ll_Nr_Sequencial
	From parametro
	where id_parametro = '1'
	Using itr_Filial;
	
	If IsNull(ll_Nr_Sequencial) or ll_nr_sequencial = 0 Then ll_Nr_Sequencial = 1
	
	If itr_Filial.SQLCode = -1 Then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_reserva ; Problemas ao localizar o sequencial da cliente_caixa: ' + itr_Filial.sqlerrtext 
		Return False
	End IF
	
	Insert Into cliente_caixa(
			nr_sequencial,
			nr_ficha,
			nm_cliente,
			nr_matricula_vendedor,
			id_situacao,
			dh_movimentacao,
			id_tipo,
			dh_inicio_reserva,
			dh_termino_reserva,
			id_avisou_cliente_reserva
			)
		 Values(	
					:ll_Nr_Sequencial,
					 0,
					:ls_Nome,
					:ls_Matricula,
					'R',
					dbo.uf_dh_Parametro(),
					:ls_Tipo_Cliente_Caixa,
					dbo.uf_dh_Parametro(),
					dbo.uf_dh_Parametro() + interval '10 days' ,
					'S'
				 )
		Using itr_Filial;
	
	If itr_Filial.SQLCode = -1 Then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_reserva ; Problemas ao incluir registro na "cliente_caixa": ' + itr_Filial.sqlerrtext 
		Return False
	End IF
	
	ll_Linhas = ids_produtos.RowCount()
	
	For ll_Row = 1 To ll_Linhas 
		
		ll_Produto 		= ids_produtos.Object.cd_produto[ ll_Row ]
		ll_Qtde			= ids_produtos.Object.qt_pedida[ ll_Row ]
		
		Insert into cliente_caixa_produto(
			cd_filial,
			nr_sequencial_cliente_caixa,
			nr_sequencial,
			cd_produto,
			qt_produto,
			id_situacao
		)Values(
			dbo.uf_Filial_Parametro(),
			:ll_Nr_Sequencial,
			:ll_row,
			:ll_Produto,
			:ll_Qtde,
			'R'
		) Using itr_Filial;
		
		If itr_Filial.SQLCode = -1 Then
			ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_reserva ; Problemas ao incluir registro na "cliente_caixa_produto": ' + itr_Filial.sqlerrtext 
			Return False
		End IF
		
	Next
	
	il_nr_sequencial_reserva = ll_Nr_Sequencial

End if

Return True
end function

public subroutine of_limpa_variaveis ();setnull(il_cd_filial)
setnull(is_nr_pedido_ecommerce)
setnull(idc_vl_total)
setnull(il_nr_pedido)
setnull(is_Rede_Filial)
setnull(idh_compra)
setnull(il_cd_filial_ecommerce)
setnull(is_de_endereco_entrega)
setnull(is_de_referencia_entrega)
setnull(is_de_bairro_entrega)
setnull(is_nr_telefone_entrega)
setnull(is_nr_cpf)
setnull(is_nm_cliente)
setnull(is_nm_cliente_entrega)
setnull(is_nr_cep)
setnull(is_nm_transportadora)
setnull(is_nm_cidade_entrega)
setnull(is_cd_uf_entrega)
setnull(is_de_complemento_endereco)
setnull(is_nr_telefone_contato)
setnull(is_nr_endereco_entrega)
setnull(is_de_email)
setnull(il_cd_cidade_entrega)

setnull(il_cd_convenio)
setnull(is_cd_conveniado)
setnull(il_cd_condicao_convenio)

setnull(is_id_tipo_entrega)
setnull(is_id_situacao)
setnull(il_nr_sequencial_reserva)
setnull(idc_Produtos_Calculado)
setnull(idc_vl_frete)
end subroutine

public function boolean of_aprovar_pedido (ref string ps_log);string ls_retorno

Try

	if ib_modo_desenv = True then return true

	Choose Case is_id_ecommerce
		Case '5' //Consulta remedios
	
			//iuo_comum.of_patch( '', '/api/v1/store/orders/' + is_nr_pedido_ecommerce + '/approve', ref ls_retorno, ref ps_log )
			
		Case '6' //Farmacias app
			
			iuo_comum.of_put( '', '/order/' + is_nr_pedido_ecommerce + '/received', ref ls_retorno, ref ps_log )
			
			
	End Choose

	if ps_log <> '' and not isnull(ps_log) then return false

Finally
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_aprovar_pedido; ' + ps_log
	
End Try

return true
end function

public subroutine of_configurar_parametros ();Choose Case is_id_ecommerce
	Case '5'
		
		il_Cd_mensagem_email = 289
		
	Case '6'
		
		il_Cd_mensagem_email = 288
		
ENd Choose
	
end subroutine

on uo_ge509_pedido_loja.create
call super::create
end on

on uo_ge509_pedido_loja.destroy
call super::destroy
end on

