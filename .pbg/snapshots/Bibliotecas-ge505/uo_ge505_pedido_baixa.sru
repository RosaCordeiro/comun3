HA$PBExportHeader$uo_ge505_pedido_baixa.sru
forward
global type uo_ge505_pedido_baixa from nonvisualobject
end type
end forward

global type uo_ge505_pedido_baixa from nonvisualobject
end type
global uo_ge505_pedido_baixa uo_ge505_pedido_baixa

type variables
uo_transacao_online ivo_Conecta_Odbc
dc_uo_transacao itr_Filial
dc_uo_odbc ivo_Odbc

boolean ib_cadastra
boolean ib_usa_pdv_java = false

string is_pedido_debug = ''
string is_ODBC_Desenv
string is_datasource

string is_objeto
string is_id_ecommerce = '3' //IFOOD
string is_id_interface = 'api/v1/pedido/'
string is_rede_filial

long il_cd_mensagem_email = 240
long il_cd_tipo = 8
long il_cd_filial
long il_cd_filial_ant

dc_uo_ds_base ids_pedidos

Datetime idt_compra
Datetime idt_atualizacao
Datetime idt_DataNascimento
Datetime idt_agendamento

String is_id_cpf_nf
String is_tipo_vale
String is_Situacao
String is_Situacao_erp
String is_nome
String is_email
String is_cpf_cgc
String is_ie
String is_fisica_juridica
String is_sexo
String is_contato
String is_endereco
String is_numero
String is_complemento
String is_referencia
String is_bairro
String is_cidade
String is_uf
String is_cep
String is_pais
String is_fone
String is_fone_contato
String is_nome_ent
String is_endereco_ent
String is_numero_ent
String is_complemento_ent
String is_bairro_ent
String is_cidade_ent
String is_uf_ent
String is_cep_ent
String is_referencia_ent
String is_pais_ent
String is_fone_ent
String is_fone_contato_ent
String is_observacao
String is_tipo_frete
String is_transportadora_site
String is_regiao
String is_tipo_pgto
String is_forma_pagto
String is_origem	
String is_cupom_desconto
String is_promocao
String is_Bloqueto
String is_cd_Produto_Ecommerce
String is_nm_Produto
String is_cd_Fornecedor
String is_userProfileId
String is_comprovante_cartao
String is_autorizacao_cartao
String is_Bandeira_Cartao
String is_Estabelecimento
String is_cartao_credito
String is_id_tipo_entrega
String is_de_transportadora
String is_tipo_pagamento_site
String is_observacao_baixa
String is_cd_transacao
String is_pedido_ecommerce
String is_nr_pedido_ifood
String is_id_agendado

Long il_cliente 
Long il_Filial_Disque
Long il_Filial_Disque_Json
Long il_Pagamento
Long il_seq_produto
Long il_qtde_produto
Long il_cd_Produto
Long il_requisicao_manip
Long il_nr_pedido
Long il_Filial_Desenv
Long il_cd_tipo_entrega
Long il_Sequencial_Item

Integer ii_prazo_entrega
Integer ii_parcelas
Integer ii_boleto_parcelado

Decimal idc_subtotal
Decimal idc_embalagem
Decimal idc_frete
Decimal idc_valecompra
Decimal idc_Total
Decimal idc_indexador
Decimal idc_Preco
Decimal idc_Preco_Promo
Decimal idc_vl_conveniencia
Decimal idc_desconto

end variables

forward prototypes
public function boolean of_busca_valor (string ps_json, string ps_campo, ref long pl_inicio, ref string ps_valor)
public subroutine of_limpa_variaveis ()
public function boolean of_atualiza_baixa (string ps_id_rede, string ps_nr_pedido, ref string ps_log)
public function boolean of_grava_pedido (string ps_nr_pedido, ref string ps_log)
public subroutine of_limpa_variaveis_produto ()
public function boolean of_carrega_produtos (string ps_json, ref string ps_log)
public function boolean of_carrega_dados_cliente (string ps_json, ref string ps_log)
public function boolean of_busca_transportadora (string ps_valor, ref string ps_log)
public function boolean of_atualiza_pedido (string ps_nr_pedido, ref string ps_log)
public function boolean of_conecta_filial (ref string ps_log)
public function boolean of_desconecta_filial ()
public function boolean of_grava_produto (ref string ps_log)
public function boolean of_valida_pedido (ref string ps_log, string ps_rede)
public function boolean of_carrega_pedido (string ps_json, ref string ps_log, long pl_pedido_erp, long pl_seq_log)
public function boolean of_processa_atualizacao_pedido ()
public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, long pl_cd_filial, string ps_id_filial_ecommerce)
public function boolean of_busca_filial_ifood (long pl_cd_filial, ref string ps_id_loja, ref string ps_log)
public function boolean of_busca_cod_produto (string ps_cod_barra, ref long pl_cd_produto, ref string ps_log)
public function boolean of_busca_cidade_cep (string ps_cep, string ps_cd_uf, ref string ps_nm_cidade, ref string ps_log)
end prototypes

public function boolean of_busca_valor (string ps_json, string ps_campo, ref long pl_inicio, ref string ps_valor);Long ll_Pos_De
Long ll_Pos_Ate
Long ll_inicio
Long ll_row
Long ll_for

String ls_Valor
String ls_campo
String ls_resultado

ls_campo = ps_campo

ll_inicio = pl_inicio + 1

ls_campo = '"' + ls_campo + '"'

// Localiza a letra inicial do campo
ll_Pos_De = PosA( ps_Json , ls_campo, ll_inicio )
ll_inicio = ll_Pos_De

pl_inicio = ll_inicio

if ll_inicio = 0 Then
	return true
end if

// Localiza o separador de campo/valor (:) e retorna a posi$$HEX2$$e700e300$$ENDHEX$$o do proximo caracter
ll_Pos_De = PosA( ps_Json, ':', ll_Pos_De + 1 ) + 1

// Quebra a string Json retirando o nome do campo de seu inicio
ls_resultado = Trim( Mid( ps_Json, ll_Pos_De ) )

// Verifica se o valor do campo inicia com (") aspa dupla. Caso TRUE, o campo termina na ocorrencia de (",) aspa dupla seguida de virgula, caso FALSE, o campo termina na ocorrencia da (,) virgula
If LeftA( ls_resultado, 1 ) = '"' Then
	
	// Remove a aspa dupla inicial para (") para n$$HEX1$$e300$$ENDHEX$$o causar problema na procura de teminador de valor (",) quando o valor come$$HEX1$$e700$$ENDHEX$$a com (,)
	ls_resultado		= Mid( ls_resultado, 2 )
	ll_Pos_Ate	= PosA( ls_resultado, '",' )
Else
	ll_Pos_Ate = PosA( ls_resultado, ',' )
End If

// Quando for o $$HEX1$$fa00$$ENDHEX$$ltimo valor, considera a posicao de termino o final da string Json
If ll_Pos_Ate < 1 Then
	ll_Pos_Ate = LenA( ls_resultado ) - 1
Else
	ll_Pos_Ate = ll_Pos_Ate - 1
End If

// Captura o valor entre o primeiro caracter e o da posicao do delimitador
ls_Valor	= MidA( ls_resultado, 1, ll_Pos_Ate )

// Remove ENTER
ls_Valor	= gf_Replace( ls_Valor,char(13) + char(10),'',0 ) // ENTER

// Remove (") aspa dupla
ls_Valor = gf_Replace( ls_Valor,'"','',0 )

// Remove a chave de fechamento
ls_Valor = gf_Replace( ls_Valor,'}','',0 ) //Quando $$HEX1$$e900$$ENDHEX$$ o $$HEX1$$fa00$$ENDHEX$$ltimo campo do grupo n$$HEX1$$e300$$ENDHEX$$o tem ',' depois do campo, por isso vai at$$HEX1$$e900$$ENDHEX$$ a tag de fechamento '},'

// Remove o colchete de fechamento
ls_Valor	= gf_Replace( ls_Valor,']','',0 ) //Quando $$HEX1$$e900$$ENDHEX$$ o $$HEX1$$fa00$$ENDHEX$$ltimo campo do grupo n$$HEX1$$e300$$ENDHEX$$o tem ',' depois do campo, por isso vai at$$HEX1$$e900$$ENDHEX$$ a tag de fechamento '],'

// Remove espacos do inicio e do final
ls_Valor = Trim( ls_Valor )
	
ps_valor = ls_valor

return true
end function

public subroutine of_limpa_variaveis ();setnull( idt_compra )
setnull( idt_atualizacao )
setnull( idt_DataNascimento )
setnull(is_Situacao_erp)
setnull(il_nr_pedido)
setnull(idc_desconto)
setnull( is_id_cpf_nf )
setnull(is_nr_pedido_ifood)
setnull( is_cartao_credito )
setnull( is_tipo_vale )
setnull( is_Situacao )
setnull( is_nome )
setnull( is_email )
setnull( is_cpf_cgc )
setnull( is_ie )
setnull( is_fisica_juridica )
setnull( is_sexo )
setnull( is_contato ) // nm_contato
setnull( is_endereco )
setnull( is_numero )
setnull( is_complemento )
setnull( is_bairro )
setnull( is_cidade )
setnull( is_uf )
setnull( is_cep )
setnull( is_pais )
setnull( is_fone )
setnull( is_fone_contato )
setnull( is_nome_ent )
setnull( is_endereco_ent )
setnull( is_numero_ent )
setnull( is_complemento_ent )
setnull( is_bairro_ent )
setnull( is_cidade_ent )
setnull( is_uf_ent )
setnull( is_cep_ent )
setnull( is_referencia_ent )
setnull( is_pais_ent )
setnull( is_fone_ent )
setnull( is_fone_contato_ent )
setnull( is_observacao )
setnull( is_tipo_frete ) // id_tipo_frete
setnull( is_transportadora_site )
setnull( is_regiao ) //nm_regiao_entrega
setnull( is_tipo_pgto )
setnull( is_forma_pagto )
setnull( is_origem )
setnull( is_cupom_desconto )
setnull( is_promocao )
setnull( is_Bloqueto )
setnull( is_referencia )
setnull( is_cd_transacao )
setnull( is_pedido_ecommerce)

setnull( is_id_agendado )
setnull( idt_agendamento )

setnull( il_cliente ) // cd_cliente
setnull( il_Filial_Disque )
SetNull(il_Filial_Disque_Json)
setnull( il_Pagamento )

setnull( ii_prazo_entrega ) // nr_prazo_entrega
setnull( ii_parcelas )
setnull( ii_boleto_parcelado )

setnull( idc_subtotal )
setnull( idc_embalagem )
setnull( idc_frete )
setnull( idc_valecompra )
setnull( idc_Total )
setnull( idc_indexador )

setnull( is_comprovante_cartao )
setnull( is_autorizacao_cartao )
setnull( is_Bandeira_Cartao )
setnull( is_Estabelecimento )
setnull( is_tipo_pagamento_site )

setnull(is_observacao_baixa)

setnull( il_cd_tipo_entrega )
setnull( is_de_transportadora )
//setnull( is_id_entrega_correio )

ib_cadastra = True

//Vl_embalagem
idc_embalagem = 0

//vl_valecompra
idc_valecompra = 0

idc_vl_conveniencia = 0
end subroutine

public function boolean of_atualiza_baixa (string ps_id_rede, string ps_nr_pedido, ref string ps_log);Update pedido_ecommerce_baixa
set dh_importacao = getdate(), de_observacao =:is_observacao_baixa
where id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :ps_id_rede
	and nr_pedido_ecommerce = :ps_nr_pedido;
	
if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_baixa ~n' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce_baixa": ' + sqlca.sqlerrtext
	return false
end if

//

return true
end function

public function boolean of_grava_pedido (string ps_nr_pedido, ref string ps_log);long ll_existe
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
		   cd_cliente,   
		   nm_cliente,    
		   nr_cpf_cgc,   
		   nr_inscricao_estadual,   
		   id_fisica_juridica,   
		   id_sexo,      
		   de_endereco,   
		   nr_endereco,   
		   de_complemento,   
		   de_bairro,   
		   de_cidade,   
		   cd_uf,   
		   nr_cep,   
		   de_pais,   
		   nm_cliente_ent,   
		   de_endereco_ent,   
		   nr_endereco_ent,   
		   de_complemento_ent,   
		   de_bairro_ent,   
		   de_cidade_ent,   
		   cd_uf_ent,   
		   nr_cep_ent,   
		   de_referencia_ent,   
		   de_pais_ent,       
		   de_observacao,   
		   id_tipo_frete,   
		   nm_transportadora,   
		   cd_tipo_entrega,
		   nr_prazo_entrega,   
		   nm_regiao_entrega,   
		   vl_subtotal,   
		   vl_embalagem,   
		   vl_frete,   
		   vl_desconto,   
		   vl_valecompra,   
		   vl_total,   
		   nr_parcelas,   
		   vl_entrada,   
		   vl_parcela,   
		   vl_indexador,   
		   cd_boleto_parcelado,   
		   cd_tipo_pagamento,   
		   cd_forma_pagamento,   
		   cd_origem,   
		   cd_cupom_desconto,   
		   de_promocao,
		   cd_filial,
		   nr_pedido_drogaexpress,
		   dh_inclusao,
		   id_pagamento,
			 nr_boleto_bancario,
			 nr_pedido_ecommerce_seq,
			 id_ecommerce)  
VALUES ( :il_cd_filial, 	//cd_filial_ecommerce
		   :ll_nr_pedido, 		      			//nr_pedido,  
		   :ps_nr_pedido,
		   :idt_compra, 					//dh_compra,   
		   :idt_atualizacao,				//dh_atualizacao,   
		   :is_Situacao,					//id_situacao,   
		   :il_cliente, 						//cd_cliente,   
		   :is_nome,						//nm_cliente,     
		   :is_cpf_cgc,						//nr_cpf_cgc,   
		   :is_ie,								//nr_inscricao_estadual,   
		   :is_fisica_juridica, 				//id_fisica_juridica,   
		   :is_sexo,							//id_sexo,    
		   null,					//de_endereco,   
		   null,						//nr_endereco,   
		   null,				//de_complemento,   
		   null,						//de_bairro,   
		   null,						//de_cidade,   
		   null,							//cd_uf,   
		   null,							//nr_cep,   
		   null,							//de_pais,   
		   :is_nome_ent,					//nm_cliente_ent,   
		   :is_endereco,				//de_endereco_ent,   
		   :is_numero,				//nr_endereco_ent,   
		   :is_complemento,		//de_complemento_ent,   
		   :is_bairro,					//de_bairro_ent,   
		   :is_cidade,					//de_cidade_ent,   
		   :is_uf,						//cd_uf_ent,   
		   :is_cep,						//nr_cep_ent,   
		   :is_referencia,			//de_referencia_ent,   
		   :is_pais,					//de_pais_ent,     
		   :is_observacao,				//de_observacao,   
		   :is_tipo_frete,					//id_tipo_frete,   
		   :is_de_transportadora,			//nm_transportadora,   
		   :il_cd_tipo_entrega,
		   :ii_prazo_entrega,				//nr_prazo_entrega,   
		   :is_regiao,						//nm_regiao_entrega,   
		   :idc_subtotal,					//vl_subtotal,   
		   :idc_embalagem,				//vl_embalagem,   
		   :idc_frete,						//vl_frete,   
		   0,					//vl_desconto,   
		   :idc_valecompra,				//vl_valecompra,   
		   :idc_Total,						//vl_total,   
		   :ii_parcelas,						//nr_parcelas,   
		   null,								//vl_entrada,   
		   null,								//vl_parcela,   
		   :idc_indexador,					//vl_indexador,   
		   :ii_boleto_parcelado,			//cd_boleto_parcelado,   
		   :is_tipo_pgto,					//cd_tipo_pagamento,   
		   :is_forma_pagto,				//cd_forma_pagamento,   
		   :is_origem,						//cd_origem,   
		   :is_cupom_desconto,			//cd_cupom_desconto,   
		   :is_promocao,					//de_promocao
		   :il_Filial_Disque,				//cd_filial
		   null, 								//nr_pedido_drogaexpress
		   getdate(),							//dh_inclusao
		   :il_Pagamento,					//id_pagamento	
		   :is_Bloqueto,				//nr_boleto_bancario) -
			:is_nr_pedido_ifood,
			:is_id_ecommerce)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao inserir registro na tabela "pedido_ecommerce": ~n' + SqlCa.sqlerrtext 
	return false
end if

Insert into pedido_ecommerce_auxiliar(cd_filial_ecommerce, nr_pedido, id_cpf_nf, id_rede_ecommerce, id_agendado, dh_agendamento)
values(:il_cd_filial, :ll_nr_pedido, :is_id_cpf_nf, :is_rede_filial, :is_id_agendado , :idt_agendamento );
	
If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao inserir registro na tabela "pedido_ecommerce_auxiliar": ~n' + SqlCa.sqlerrtext 
	return false
end if			

Insert into pedido_ecommerce_endereco( cd_filial_ecommerce,   
															nr_pedido,   
															cd_tipo_endereco,   
															de_endereco,   
															nr_endereco,   
															de_complemento,   
															de_bairro,   
															de_cidade,   
															cd_uf,   
															nr_cep,   
															de_pais,
															de_referencia_ent)
Values ( :il_cd_filial, :ll_nr_pedido, 1,
			:is_endereco, :is_numero, :is_complemento, :is_bairro, :is_cidade, :is_uf, :is_cep, :is_pais, :is_referencia);
	
If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Aten$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao inserir registro na tabela "pedido_ecommerce_endereco"[1]: ~n' + SqlCa.sqlerrtext 
	return false
end if	
	
Insert into pedido_ecommerce_endereco( cd_filial_ecommerce,   
																nr_pedido,   
																cd_tipo_endereco,   
																de_endereco,   
																nr_endereco,   
																de_complemento,   
																de_bairro,   
																de_cidade,   
																cd_uf,   
																nr_cep,   
																de_pais,   
																de_referencia_ent,   
																de_observacao )
Values ( :il_cd_filial, :ll_nr_pedido, 2,
			:is_endereco_ent, :is_numero_ent, :is_complemento_ent, :is_bairro_ent, :is_cidade_ent, :is_uf_ent, :is_cep_ent, :is_pais_ent, :is_referencia_ent, :is_observacao);	
	
If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Aten$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao inserir registro na tabela "pedido_ecommerce_endereco"[2]: ~n' + SqlCa.sqlerrtext 
	return false
end if		
	
return true
end function

public subroutine of_limpa_variaveis_produto ();setnull(is_cd_Produto_Ecommerce)
setnull(il_qtde_produto)
setnull(is_nm_Produto)
setnull(il_cd_Produto)
setnull(is_cd_Fornecedor)
setnull(idc_Preco)
setnull(idc_Preco_Promo)
setnull(il_requisicao_manip)
end subroutine

public function boolean of_carrega_produtos (string ps_json, ref string ps_log);String ls_info_itens
String ls_json_restante
String ls_valor
String ls_valor_tag
String ls_retorno
String ls_indisponivel
String ls_desistencia
String ls_codigo_barra
decimal{2} ldc_valor

il_Sequencial_Item = 0

uo_ge505_comum luo_comum
uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 
luo_comum = Create uo_ge505_comum

ls_json_restante = ps_json

luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'items', ref ls_info_itens, 'pagamentos')

Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_info_itens, Ref ls_retorno,'{') 
	
	this.of_limpa_variaveis_produto( )
	ls_codigo_barra = ''
	
	//Se est$$HEX1$$e100$$ENDHEX$$ marcado como indispon$$HEX1$$ed00$$ENDHEX$$vel, ignora o produto e passa para o proximo. 
	ls_indisponivel = ''
	ls_indisponivel = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'indisponivel')
	
	if upper(ls_indisponivel) = 'TRUE' then
		Continue
	end if
	
	//Se est$$HEX1$$e100$$ENDHEX$$ marcado como desistencia, ignora o produto e passa para o proximo. 
	ls_desistencia = ''
	ls_desistencia = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'desistencia')
	
	if upper(ls_desistencia) = 'TRUE' then
		Continue
	end if
	
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'id')
	is_cd_produto_ecommerce = ls_valor
	
	If IsNull(ls_valor) or trim(ls_valor) = '' Then
		ps_log = is_objeto +  'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [id].'
		Return False
	End IF
	
	ls_codigo_barra = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'codigoBarra')
	
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'plu')
	il_cd_produto = long(ls_valor)
	
	If IsNull(ls_valor) or trim(ls_valor) = '' Then
		
		if Not this.of_busca_cod_produto(ls_codigo_barra , ref il_cd_produto, ref ps_log) Then return false
		
		if il_cd_produto = 0 or isnull(il_cd_produto) Then
		
			ps_log = is_objeto +  'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [plu].'
			Return False
		End if
	End IF
	
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'quantidade')
	
	ls_valor = gf_replace(ls_valor, '.', ',',0)
	ldc_valor = dec(ls_valor)
	
	il_qtde_produto = long(ldc_valor)
	
//	il_qtde_produto = long( luo_comum.of_decimal( long(ls_valor) ) )
	
	If IsNull(ls_valor) or trim(ls_valor) = '' Then
		ps_log = is_objeto +  'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [quantidade].'
		Return False
	End IF
	
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'valor')
	
	ls_valor = gf_replace(ls_valor, '.', ',',0)
	ldc_valor = dec(ls_valor)
	
	idc_preco = ldc_valor
	
	If IsNull(ls_valor) or trim(ls_valor) = '' Then
		ps_log = is_objeto +  'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [valor].'
		Return False
	End IF
	
	idc_preco_promo = idc_preco
	
//	If IsNull(ls_valor) or trim(ls_valor) = '' Then
//		ps_log = is_objeto +  'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [price].'
//		Return False
//	End IF
  
	setnull(is_nm_Produto)  
	setnull(is_cd_Fornecedor)
	setnull(il_requisicao_manip)
	
	if Not this.of_grava_produto(ref ps_log) Then return false
	
Loop

destroy(luo_gera_json)
destroy(luo_comum)

return true
end function

public function boolean of_carrega_dados_cliente (string ps_json, ref string ps_log);string ls_valor

uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 

ls_valor = ''
ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'email')
is_email = ls_valor

select top 1 id_sexo 
into :is_sexo
from pedido_ecommerce
where nr_cpf_cgc = :is_cpf_cgc
	and id_sexo is not null 
	and id_sexo <> ''
order by dh_compra desc;

If sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_cliente. ' + 'Problemas ao consultar a tabela "pedido_ecommerce": ' + sqlca.sqlerrtext
	return false
end if

if isnull(is_sexo) or is_sexo = '' Then

	select top 1 id_sexo 
	into :is_sexo
	from cliente
	where nr_cpf_cgc = :is_cpf_cgc;
	
	If sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_cliente. ' + 'Problemas ao consultar a tabela "cliente": ' + sqlca.sqlerrtext
		return false
	end if
	
end if
			
if is_sexo = '' or isnull(is_sexo) Then
	ps_log = 'Sexo do cliente n$$HEX1$$e300$$ENDHEX$$o mapeado: ' + is_sexo
	return false
End If
			
select top 1 dh_nascimento 
into :idt_DataNascimento
from pedido_ecommerce
where nr_cpf_cgc = :is_cpf_cgc
	and dh_nascimento is not null 
order by dh_compra desc;

If sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_cliente. ' + 'Problemas ao consultar a tabela "pedido_ecommerce": ' + sqlca.sqlerrtext
	return false
end if

if isnull(idt_DataNascimento) Then

	select top 1 dh_nascimento 
	into :idt_DataNascimento
	from cliente
	where nr_cpf_cgc = :is_cpf_cgc;
	
	If sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_cliente. ' + 'Problemas ao consultar a tabela "cliente": ' + sqlca.sqlerrtext
		return false
	end if
	
End If		
	
destroy(	luo_gera_json )
	
return true
end function

public function boolean of_busca_transportadora (string ps_valor, ref string ps_log);string ls_id_situacao

ps_valor = Upper(ps_valor)

Select cd_tipo_entrega, de_tipo_entrega, de_tipo_entrega_site, id_situacao, id_tipo_entrega
into :il_cd_tipo_entrega, :is_de_transportadora, :is_transportadora_site, :ls_id_situacao, :is_id_tipo_entrega
from tipo_entrega_ecommerce
where de_tipo_entrega_site = :ps_valor;

if sqlca.sqlcode = -1 then 
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_transportadora. ' + 'Problemas ao consultar a tabela "tipo_entrega_ecommerce": ' + sqlca.sqlerrtext
	return false
end if

if il_cd_tipo_entrega = 0 or isnull(il_cd_tipo_entrega) Then
	ps_log = 'Transportadora n$$HEX1$$e300$$ENDHEX$$o mapeada: ' + ps_valor
	return false
end if

if ls_id_situacao = 'I' Then
	ps_log = 'Transportadora com situa$$HEX2$$e700e300$$ENDHEX$$o inativa: ' + ps_valor
	return false
end if

return true
end function

public function boolean of_atualiza_pedido (string ps_nr_pedido, ref string ps_log);string ls_id_situacao_loja
uo_ge505_comum luo_comum

// Somente se o pedido estiver CANCELADO no site
if is_Situacao <> 'X' Then Return true

Try

	luo_comum = create uo_ge505_comum
	
	//Se o pedido estiver com situa$$HEX2$$e700e300$$ENDHEX$$o cancelado no site.
	
	if ib_usa_pdv_java = False then
		
		If Not this.of_desconecta_filial( ) Then Return false
		If Not this.of_conecta_filial( ref ps_log ) Then Return false
		
		Select id_situacao
		into :ls_id_situacao_loja
		from pedido_drogaexpress
		where nr_pedido_ecommerce_site = :ps_nr_pedido
		Using itr_filial;
		
		if itr_filial.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao consultar a tabela "pedido_drogaexpress": ' + itr_filial.sqlerrtext
			return false
		end if
		
		if isnull(ls_id_situacao_loja) then ls_id_situacao_loja = ''
		
		if ls_id_situacao_loja <> '' and ls_id_situacao_loja <> 'F' then
		
			Update pedido_drogaexpress
				set id_situacao = 'X'
				where nr_pedido_ecommerce_site = :ps_nr_pedido
				Using itr_filial;
			
			if itr_filial.sqlcode = -1 then
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao consultar a tabela "pedido_drogaexpress": ' + itr_filial.sqlerrtext
				return false
			end if
			
		ENd if
		
	else 
		ls_id_situacao_loja = is_Situacao_erp
		
	ENd if
	//cancela na matriz
	
	if ls_id_situacao_loja <> 'F' then
	
		Update pedido_ecommerce
		set id_situacao = 'X', dh_cancelamento = getdate()
		where nr_pedido_ecommerce = :ps_nr_pedido
			and cd_filial_ecommerce = :il_cd_filial
			Using SQLCA;
	
		if SQLCA.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce": ' + SQLCA.sqlerrtext
			return false
		end if
		
	END if
	
	is_observacao_baixa = 'PEDIDO CANCELADO NO SITE'
	
Finally
	
	Destroy(luo_comum)
	
End Try

return true
end function

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
	ivo_Conecta_Odbc.of_inclui_odbc( il_Filial_Disque )
	ls_Odbc = ivo_Odbc.of_Localiza( il_Filial_Disque )
end if

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

if itr_Filial.of_Connect( ls_Odbc, gvo_aplicacao.is_ComputerName , false) = False Then
	iif(IsNull(il_Filial_Disque), 0, il_Filial_Disque)
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(il_Filial_Disque) 
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

public function boolean of_grava_produto (ref string ps_log);Long ll_Sequencial

Select nr_sequencial
Into :ll_Sequencial
From pedido_ecommerce_produto
Where cd_filial_ecommerce 		= :il_cd_filial
    and nr_pedido					 	= :il_nr_pedido
    and cd_produto_ecommerce 	= :is_cd_Produto_Ecommerce
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		update pedido_ecommerce_produto
		set qt_pedida = qt_pedida + :il_qtde_produto
		Where cd_filial_ecommerce 		= :il_cd_filial
		   and nr_pedido					 	= :il_nr_pedido
		  and cd_produto_ecommerce 	= :is_cd_Produto_Ecommerce
		  and nr_sequencial = :ll_Sequencial
	    Using SqlCa;
		
		if SqlCa.sqlcode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao atualizar a qtde pedida na tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
			return false
		end if
		
	Case 100
		
		il_Sequencial_Item ++
		
		INSERT INTO pedido_ecommerce_produto  
				 (  cd_filial_ecommerce,
					nr_pedido,   
					cd_produto_ecommerce, 
					nr_sequencial,
					qt_pedida,   
					nm_produto,   
					cd_produto,   
					cd_fornecedor,   
					vl_preco,   			 		// Pre$$HEX1$$e700$$ENDHEX$$o venda sem o desconto
					vl_preco_promocao,     	// Pre$$HEX1$$e700$$ENDHEX$$o liquido j$$HEX1$$e100$$ENDHEX$$ com o desconto
					dh_inicio_promocao,   
					dh_termino_promocao,
					nr_requisicao_manip )  
			VALUES( :il_cd_filial,
						:il_nr_pedido,   
						:is_cd_Produto_Ecommerce,   
						:il_Sequencial_Item,
						:il_qtde_produto,
						:is_nm_Produto,   
						:il_cd_Produto,   
						:is_cd_Fornecedor,   
						:idc_Preco,   
						:idc_Preco_Promo,   
						null,   
						null,
						:il_requisicao_manip )
			Using SqlCa;
			
			if SqlCa.sqlcode = -1 Then
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao inserir registro na tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
				return false
			end if
		
	Case -1
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao consultar registro na tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
		return false
End Choose

return true
end function

public function boolean of_valida_pedido (ref string ps_log, string ps_rede);Decimal ldc_Tot_Prd_Calc
String ls_id_permite_frete
Long ll_Produto_Pedido

select vl_parametro
into :ls_id_permite_frete
from parametro_geral
where cd_parametro = 'ID_PERMITE_BAIXA_PED_IFOOD_FRETE'
Using SQLCA;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores da tabela "parametro_geral":~n' + SqlCa.sqlerrtext
	return false
End If

If ls_id_permite_frete = 'N' or isnull(ls_id_permite_frete) or ls_id_permite_frete = '' Then
	//Os pedidos do Ifood n$$HEX1$$e300$$ENDHEX$$o podem ter valor de frete.
	if idc_frete > 0 then
		ps_log = 'O pedido possui valor de frete informado: ' + string(idc_frete)
		return false
	end if
end if

Select coalesce(sum(round(qt_pedida * vl_preco_promocao, 2)), 0) 
Into :ldc_Tot_Prd_Calc
From pedido_ecommerce_produto
where cd_filial_ecommerce = :il_cd_filial
  and nr_pedido = :il_nr_pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
End If

//If ((idc_subtotal + idc_embalagem + idc_frete ) - idc_desconto - idc_valecompra) <> idc_Total Then
//	ps_log = is_objeto + 'O total do pedido calculado esta diferente do informado no pedido.'
//	return false
//End If

If ( idc_subtotal ) <> ( ldc_Tot_Prd_Calc ) Then
	
	//O valor do pedido deve ser sempre o valor da soma dos itens:
	Update pedido_ecommerce
	set vl_subtotal = :ldc_Tot_Prd_Calc,
		vl_total = :ldc_Tot_Prd_Calc
	where cd_filial_ecommerce = :il_cd_filial
 		 and nr_pedido = :il_nr_pedido
	Using SqlCa; 
	
	If SqlCa.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao atualizar a tabela "pedido_ecommerce":~n' + SqlCa.sqlerrtext
		return false
	End If
	
	//ps_log = is_objeto + 'O total de produtos calculado est$$HEX1$$e100$$ENDHEX$$ diferente do SUBTOTAL informado no pedido.'
	//return false
End If

select top 1 p.cd_produto 
Into :ll_Produto_Pedido
from pedido_ecommerce_produto p
where p.cd_filial_ecommerce 	= :il_cd_filial
  and p.nr_pedido 					= :il_nr_pedido
  and not exists (select 1 from ecommerce_prd pr
				  where pr.id_ecommerce = :is_id_ecommerce
					 and pr.id_rede_filial = :ps_rede
					 and pr.cd_produto = p.cd_produto)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores para validar os produtos da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
End If

If Not IsNull(ll_Produto_Pedido) and ll_Produto_Pedido > 0 Then
	ps_log = is_objeto +  'O produto ' + String(ll_Produto_Pedido) + ' inserido no pedido n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela "ecommerce_prd".'
	Return False
End If

select top 1 p.cd_produto 
Into :ll_Produto_Pedido
from pedido_ecommerce_produto p
inner join ecommerce_prd pr
	on  pr.id_ecommerce = :is_id_ecommerce
	and pr.id_rede_filial = :ps_rede
	and pr.cd_produto = p.cd_produto
where p.cd_filial_ecommerce = :il_cd_filial
  and p.nr_pedido = :il_nr_pedido
  and p.cd_produto_ecommerce <> p.cd_produto_ecommerce
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores para validar os produtos  (2) da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
End If

If Not IsNull(ll_Produto_Pedido) and ll_Produto_Pedido > 0 Then
	ps_log = is_objeto +  'O produto ' + String(ll_Produto_Pedido) + ' inserido no pedido est$$HEX1$$e100$$ENDHEX$$ com o c$$HEX1$$f300$$ENDHEX$$digo do produto no ecommerce diferente "ecommerce_prd".'
	Return False
End If

Return True
end function

public function boolean of_carrega_pedido (string ps_json, ref string ps_log, long pl_pedido_erp, long pl_seq_log);Boolean lb_Comp_Cartao 

String ls_state
String ls_handle
String ls_orderId
String ls_info_cliente
String ls_info_endereco
String ls_info_entrega
String ls_info_valores
String ls_info_pagamento
String ls_info_loja
String ls_json_restante
String ls_valor
String ls_valor_tag
String ls_retorno
String ls_info_endereco_nota
String ls_info_parceiro
String ls_retirada_loja
String ls_data_agendamento
String ls_hora_agendamento

decimal ldc_valor_pagamento

long ll_row
long ll_inicio

uo_ge505_comum luo_comum
uo_ge073_json luo_gera_json

Try

	luo_gera_json = Create uo_ge073_json 
	luo_comum = Create uo_ge505_comum
	
	ls_json_restante = ps_json
	
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'entrega')
	
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'parceiro', ref ls_info_parceiro, '}')
	
	//Se for uma entrega pega o endere$$HEX1$$e700$$ENDHEX$$o do cliente, sen$$HEX1$$e300$$ENDHEX$$o pega o endere$$HEX1$$e700$$ENDHEX$$o da loja
	if ls_valor = 'true' Then
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'enderecoEntrega', ref ls_info_endereco, '}')
	else
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'endereco', ref ls_info_endereco, '}')
	end if
	
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'loja', ref ls_info_loja, '}')
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'cliente', ref ls_info_cliente, '}')
	
	//Nr Pedido IFOOD
	is_nr_pedido_ifood = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_parceiro, 'codigoPedido')
	
	is_id_agendado = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_parceiro, 'agendado')
	
	if upper(is_id_agendado) = 'TRUE' Then
		is_id_agendado = 'S'
	Else
		is_id_agendado = 'N'
	End if
	
	if is_id_agendado = 'S' Then
	
		ls_data_agendamento = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'agendamentoDataFim')
		ls_hora_agendamento = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'agendamentoHoraFim')
		
		idt_agendamento =  Datetime( date(ls_data_agendamento), time( ls_hora_agendamento ) )
	Else
		setnull(idt_agendamento)
	ENd if
	
	//cd_filial
	//ls_valor = ''
	//ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'idLoja')
	//if Not this.of_busca_filial_ifood( ls_valor, ref il_Filial_Disque, ref ps_log ) then return false
	
	if il_filial_desenv > 0 Then
		
		il_Filial_Disque = il_filial_desenv
	Else
	
		il_Filial_Disque = il_cd_filial
	ENd if
	
	
	//Verifica se $$HEX1$$e900$$ENDHEX$$ retirada em loja:
	ls_retirada_loja = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'retirada')
	If Upper(ls_retirada_loja) = 'TRUE' Then
		ls_retirada_loja = 'S'
	Else
		ls_retirada_loja = 'N'
	End if
	
	//Verifica se exibe CPF/CNPJ na nota
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'cpfNaNota')
	if ls_valor = 'true' Then
		is_id_cpf_nf = 'S'
	else
		is_id_cpf_nf = 'N'
	end if
	
	//Dh_compra , Dh_atualizacao
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'dataHora')
	idt_compra =  Datetime( date(ls_valor), time( mid( ls_valor, 12, 5) ) )
	
//	//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
//	Select dateadd( HOUR, -3, :idt_compra )
//	Into :idt_compra
//	From parametro;
	
	idt_atualizacao = idt_compra
	
	//Id_situacao
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'status')
	
	Choose Case upper(ls_valor)
		Case 'ENT', 'ENP', 'FIN', 'RET', 'REP'
			is_situacao = 'A'
			
		Case 'CAN', 'DEV'
			is_situacao = 'X'
			
		Case Else
			is_situacao = 'I'
			ps_log = 'Situa$$HEX2$$e700e300$$ENDHEX$$o do pedido n$$HEX1$$e300$$ENDHEX$$o mapeada: ' + ls_valor
			return false
			
	End Choose
	
	//Baixar o pedido mesmo estando cancelado:
	If (IsNull(pl_pedido_erp) and is_situacao = 'X') Then
		
		is_observacao_baixa = 'PEDIDO CANCELADO NO SITE'
		
		//ib_cadastra = False
		//Return True
	End If
	
	//****** Cliente ******//
	//********************//
	//is_userProfileId = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'userProfileId')
	
	//nm_cliente
	is_nome = Upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'nome'))

	is_nome = gf_retira_acentos(is_nome)
	is_nome = gf_remove_caracteres_especiais(is_nome)

	
	if isnull(is_nome) then is_nome = ''
	
	if trim(is_nome) = '' then
		ps_log = 'Nome do cliente inv$$HEX1$$e100$$ENDHEX$$lido: ' + is_nome
		return false
	End if
	
	if pos(is_nome,'$$HEX1$$3804$$ENDHEX$$') > 0 or pos(is_nome, Upper('$$HEX1$$3804$$ENDHEX$$')) > 0 Then
		ps_log = 'Nome do cliente inv$$HEX1$$e100$$ENDHEX$$lido: ' + is_nome
		return false
	End if

	if pos(is_nome,'$$HEX1$$4f04$$ENDHEX$$') > 0 or pos(is_nome, Upper('$$HEX1$$4f04$$ENDHEX$$')) > 0 Then
		ps_log = 'Nome do cliente inv$$HEX1$$e100$$ENDHEX$$lido: ' + is_nome
		return false
	ENd if
	
	is_nome_ent = is_nome 
	
	//nr_cpf_cgc
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'tipo')
	
	if ls_valor = 'Juridica' Then
		is_fisica_juridica = 'J'
		
		is_cpf_cgc = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'cnpj')
	else
		is_fisica_juridica = 'F'
		
		is_cpf_cgc = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'cpf')
	end if
	
	//nr_fone
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'telefoneCelular')
	
	if left(ls_valor,3) = '+55' Then
		ls_valor = mid(ls_valor, 4, 100)
		// (47)984021346
		ls_valor = '(' + Mid(ls_valor, 1,2) + ')' + mid(ls_valor, 3, 100)
	end if
	
	is_fone = ls_valor 
	is_fone_ent = is_fone
	
	is_fone_contato 		= is_fone  
	is_fone_contato_ent 	= is_fone
	
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'email')
	is_email = ls_valor
	
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'genero')
	
	If Upper(ls_valor) = 'HOMEM' Then
		is_sexo = 'M'
	else
		is_sexo = 'F'
	end if
	
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'dataNascimento')
	idt_DataNascimento = Datetime( date(ls_valor), time( mid( ls_valor, 12, 5) ) )
	
	//de_endereco
	is_endereco 		= upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'logradouro'))
	is_endereco_ent 	= is_endereco
	
	//nr_endereco
	is_numero 		= luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'numero')
	is_numero_ent 	= is_numero
	
	If is_id_tipo_entrega = 'RET' Then
		
		If IsNull(is_numero) Then
			is_numero = '0'
			is_numero_ent = '0'
		End If
		
	End If
	
	//de_bairro
	is_bairro 		= upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'bairro'))
	is_bairro_ent 	= is_bairro
	
	//cd_uf
	is_uf 		= luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'uf')
	is_uf_ent	= is_uf
	
	//nr_cep
	is_cep = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'cep')
	is_cep = gf_replace( is_cep, '-', '', 0 )
	is_cep_ent = is_cep
	
	if Not this.of_busca_cidade_cep( is_cep, is_uf, ref is_cidade, ref ps_log) then return false
	
	if isnull(is_cidade) or is_cidade = '' then
		//de_cidade
		is_cidade = upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'cidade'))
	End if
	
	is_cidade_ent 	= is_cidade
	
	//de_pais
	is_pais = 'BRA'
	
	is_pais_ent = is_pais
				
	//***************** Valores
	
	ls_valor = ''
	idc_subtotal = dec(luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'valorCorrigido'))
	idc_subtotal = luo_comum.of_decimal( idc_subtotal )
	
//	ls_valor = ''
//	idc_frete = dec(luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'valorEntrega'))
//	idc_frete = luo_comum.of_decimal( idc_frete )
	
	idc_frete = 0
	
	//vl_total
	ls_valor = ''
	//ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'valorTotal')
		
//	idc_Total = dec(ls_valor)
//	idc_Total = luo_comum.of_decimal( idc_Total )
	
	idc_desconto = dec(luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'valorDesconto')) 
	idc_desconto = luo_comum.of_decimal( idc_desconto )
	
	if isnull(idc_desconto) Then idc_desconto = 0
	
	if idc_desconto > 0 then
		idc_subtotal = idc_subtotal + idc_desconto
	ENd if	
	
	idc_total = idc_subtotal
	
	idc_vl_conveniencia = dec(luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'valorConveniencia'))
	idc_vl_conveniencia = luo_comum.of_decimal( idc_vl_conveniencia )
	
	//vl_indexador
	idc_indexador = 0
	
	//cd_boleto_parcelado
	ii_boleto_parcelado = 0
	
	if ls_retirada_loja = 'S' Then
		//Usar o tipo de entrega RETIRADA EM LOJA para o ifood.
		If Not this.of_busca_transportadora( 'RETIRAR NA LOJA', ref ps_log) Then return false
	Else
		//Usar o tipo de entrega MOTOBOY para o ifood.
		If Not this.of_busca_transportadora( 'MOTOBOY', ref ps_log) Then return false
	End if

Finally
	
	destroy(luo_gera_json)
	destroy(luo_comum)
	
End Try

return true
end function

public function boolean of_processa_atualizacao_pedido ();string ls_Log, ls_rede, ls_id_filial
long ll_linhas, ll_cd_filial, ll_for
dc_uo_ds_base lds_filial


lds_filial = create dc_uo_ds_base
		
if not lds_filial.of_changedataobject( 'ds_ge505_pedido_baixa_filial' , false) Then
	ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge505_pedido_baixa_filial'
	return false
end if

ll_linhas = lds_filial.retrieve( is_id_ecommerce )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

for ll_for = 1 to ll_linhas
	
	ls_rede = lds_filial.object.id_rede_filial[ll_for]
	ll_cd_filial = lds_filial.object.cd_filial[ll_for]
	
	if Not this.of_busca_filial_ifood(ll_cd_filial , ref ls_id_filial, ref ls_log) Then return false
	
	if Not this.of_processa_atualizacao_pedido( ls_rede, ll_cd_filial, ls_id_filial ) Then return false
	
next

destroy(lds_filial)

return true
end function

public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, long pl_cd_filial, string ps_id_filial_ecommerce);Boolean lb_Erro

String ls_json
String ls_retorno
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_nr_pedido
String ls_url_masterdata
String ls_url_padrao
String ls_retorno_cliente
String ls_id_registro_log

long ll_linhas
Long ll_for
Long ll_Seq_Log
Long ll_nr_pedido_erp

boolean lb_sucesso=false

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

	luo_comum = create uo_ge505_comum
	ids_pedidos = create dc_uo_ds_base
	
	setnull(ls_id_registro_log)
	luo_comum.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )
	
	//Desenvolvimento
	is_ODBC_Desenv = luo_comum.of_desenvolvimento_odbc_baixa_pedido()
	il_Filial_Desenv = luo_comum.of_desenvolvimento_filial_baixa_pedido()
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	
	if Not luo_comum.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede_filial, is_id_ecommerce, ref ls_log ) Then return false
		
	if not ids_pedidos.of_changedataobject( 'ds_ge505_pedido_ecommerce' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_ecommerce'
		return false
	end if
	
	If (Not IsNull(is_ODBC_Desenv) or Not IsNull(il_Filial_Desenv)) and gvo_Aplicacao.ivs_DataSource = 'central' Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' No INI esta configurado FILIAL ou ODBC de desenvolvimento, no entanto esta gravando no BD CENTRAL.'
		return false
	End If
	
	If (IsNull(is_ODBC_Desenv) and IsNull(il_Filial_Desenv)) and gvo_Aplicacao.ivs_DataSource <> 'central' Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' No INI n$$HEX1$$e300$$ENDHEX$$o esta configurado FILIAL e ODBC de desenvolvimento, no entanto esta gravando no BD diferente do CENTRAL.'
		return false
	End If
	
	if Not gf_retorna_loja_pdv_novo(pl_cd_filial, ref ib_usa_pdv_java, ref ls_log ) then return false
		
	ll_linhas = ids_pedidos.retrieve( is_id_ecommerce, ps_rede_filial, ps_id_filial_ecommerce )

	If ll_Linhas > 0 Then
		luo_comum.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		SetNull(ls_log)
		
		this.of_limpa_variaveis( )
		
		luo_comum.of_limpa_variaveis( )
		
		ls_nr_pedido 			= ids_pedidos.object.nr_pedido_ecommerce[ll_for]
		ll_nr_pedido_erp 		= ids_pedidos.object.nr_pedido[ll_for]
		is_Situacao_erp 		= ids_pedidos.object.id_situacao[ll_for]
		is_pedido_ecommerce = ls_nr_pedido
		
		If not IsNull(is_pedido_debug) and Trim(is_pedido_debug) <> '' Then
			If is_pedido_ecommerce <>  is_pedido_debug Then
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
		
		luo_comum.is_nr_pedido_ecommerce = ls_nr_pedido
							
		w_Ge501_Aguarde.Title = "Ifood - Baixando Pedido (Site -> ERP) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = "Pedido: " + ls_nr_pedido

		//Gera o token pra conectar no webservice.		
		luo_comum.of_gera_token( ref ls_log ) 
		
		if ls_log <> '' and not isnull(ls_log) Then
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO Ifood', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
			luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if

		//Busca as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido no Ecommerce.
		luo_comum.of_get( is_id_interface + ls_nr_pedido , ref ls_retorno, ref ls_log )
		luo_comum.is_json = ls_retorno	
		
		if ls_log <> '' and not isnull(ls_log) Then
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO Ifood', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
			luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Carrega informa$$HEX2$$e700f500$$ENDHEX$$es do pedido
		If Not this.of_carrega_pedido( ls_retorno, ref ls_log, ll_nr_pedido_erp, ll_Seq_Log) Then
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
			luo_comum.il_cd_filial_pedido = il_Filial_Disque_Json
			luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Se o pedido j$$HEX1$$e100$$ENDHEX$$ tiver sido baixado , n$$HEX1$$e300$$ENDHEX$$o baixa novamente.
		if is_situacao = 'A' and ll_nr_pedido_erp > 0 Then
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		// Pedido cancelado do SITE e n$$HEX1$$e300$$ENDHEX$$o existe no ERP
		If Not ib_cadastra Then
			//Atualiza data de importa$$HEX2$$e700e300$$ENDHEX$$o
			If Not this.of_atualiza_baixa( ps_rede_filial, ls_nr_pedido, ref ls_log ) Then return false
			SQLCA.of_commit( )
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End If
		
		luo_comum.il_cd_filial_pedido = il_Filial_Disque_Json
		
		//Se o pedido j$$HEX1$$e100$$ENDHEX$$ foi importado: Atualiza o pedido
		if ll_nr_pedido_erp > 0 Then
			
			il_nr_pedido = ll_nr_pedido_erp
			
			//Atualiza o pedido
			this.of_atualiza_pedido(ls_nr_pedido, ref ls_log)
			
			if ls_log <> '' and not isnull(ls_log) Then
				luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
				luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			//
		else
			//Se o pedido ainda n$$HEX1$$e300$$ENDHEX$$o foi importado: Cria um novo pedido
			//Grava o pedido
			
			//Verifica se o pedido j$$HEX1$$e100$$ENDHEX$$ existe no banco de dados.
			if Not gf_valida_pedido_ecommerce(SQLCA, ls_nr_pedido, is_id_ecommerce, False, ref ls_log ) Then
				luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
				luo_comum.il_cd_filial_pedido = il_Filial_Disque_Json
				luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
			lb_Erro = True
			
			if this.of_grava_pedido( ls_nr_pedido, ref ls_log ) Then 
				if  this.of_carrega_produtos( ls_retorno, ref ls_log ) Then
						If This.of_valida_pedido( ref ls_Log, ps_rede_filial) Then
							lb_Erro = False
						End If
				End If
			End If		
			
			If lb_Erro Then
				luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
				
				if isvalid(itr_filial) Then
					if itr_filial.of_isconnected( ) Then
						itr_filial.of_rollback( )
					end if
				end if
				
				sqlca.of_rollback( )
				luo_comum.il_cd_filial_pedido = il_Filial_Disque_Json
				luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
				Continue
			End If
			
		end if
		
		//Atualiza data de importa$$HEX2$$e700e300$$ENDHEX$$o
		If Not this.of_atualiza_baixa( ps_rede_filial, ls_nr_pedido, ref ls_log ) Then
			
			if isvalid(itr_filial) Then
				if itr_filial.of_isconnected( ) Then
					itr_filial.of_rollback( )
				end if
			end if
				
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
			sqlca.of_rollback( )
			luo_comum.il_cd_filial_pedido = il_Filial_Disque_Json
			luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
			Continue
		end if
				
		if isvalid(itr_filial) Then
			if itr_filial.of_isconnected( ) Then
				itr_filial.of_commit( )
			end if
		end if
		
		SQLCA.of_commit( )
		
		if Not luo_comum.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
	next
			
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_situacao = 'E'
		
		if isvalid(itr_filial) Then
			if itr_filial.of_isconnected( ) Then
				itr_filial.of_rollback( )
			end if
		end if
	
		sqlca.of_rollback( )
		
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
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO Ifood', ll_Seq_Log, 'MSG: ' +  ls_Log, ls_nr_pedido)
		End If
	Else
		If ll_Linhas > 0 Then
			//Marca o log como processado
			If Not luo_comum.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
		
	this.of_desconecta_filial( )	
	
	luo_comum.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )
	
	destroy(ids_pedidos)
	destroy(luo_comum)
	
	Close(w_Ge501_Aguarde)
	
End try

return true
end function

public function boolean of_busca_filial_ifood (long pl_cd_filial, ref string ps_id_loja, ref string ps_log);

Select cd_warehouseid
into :ps_id_loja
from ecommerce_rede_filial
where id_ecommerce = :is_id_ecommerce
and cd_filial = :pl_cd_filial
and id_situacao = 'A';

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial_ifood ; Problemas ao consultar a tabela "ecommerce_rede_filial": ' + sqlca.sqlerrtext
	return false
end if

return true
end function

public function boolean of_busca_cod_produto (string ps_cod_barra, ref long pl_cd_produto, ref string ps_log);long ll_cd_produto


select  top 1 cd_produto
into :ll_cd_produto
from codigo_barras_produto 
where de_codigo_barras = :ps_cod_barra
order by id_principal desc;

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela codigo_barras_produto: ' + sqlca.sqlerrtext
	return false
end if

if ll_cd_produto = 0 then setnull(ll_cd_produto)

pl_cd_produto = ll_cd_produto

return true
end function

public function boolean of_busca_cidade_cep (string ps_cep, string ps_cd_uf, ref string ps_nm_cidade, ref string ps_log);string ls_nm_cidade

setnull(ls_nm_cidade)

SELECT distinct nm_cidade
	into :ls_nm_cidade
	FROM vw_endereco
	WHERE nr_cep = :ps_cep
	and cd_uf = :ps_cd_uf;
	
if sqlca.sqlcode = -1 then
	ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_cidade_cep; Problemas ao consultar a vw_endereco: ' + sqlca.sqlerrtext
	Return false
ENd if

ps_nm_cidade = ls_nm_cidade

return true
end function

on uo_ge505_pedido_baixa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge505_pedido_baixa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

