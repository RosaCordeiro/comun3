HA$PBExportHeader$uo_ge501_pedido_ecommerce.sru
forward
global type uo_ge501_pedido_ecommerce from nonvisualobject
end type
end forward

global type uo_ge501_pedido_ecommerce from nonvisualobject
end type
global uo_ge501_pedido_ecommerce uo_ge501_pedido_ecommerce

type variables

uo_ge501_comum iuo_comum_vtex

uo_ge073_json iuo_gera_json

dc_uo_ds_base ids_produtos_pbm
dc_uo_ds_base ids_promocoes
dc_uo_ds_base ids_produto_promo
dc_uo_ds_base ids_filiais_sem_conexao

boolean ib_cadastra
boolean ib_usa_receita = false
boolean ib_endereco_valido= True
boolean ib_existe_produto_manipulado = False
boolean ib_afiliado = false
boolean ib_filial_hub = false
boolean ib_usa_pdv_java = false
boolean ib_desenv = false

string is_ODBC_Desenv
string is_datasource

string is_id_interface = 'api/oms/pvt/orders/'
string is_id_interface_pbm = '_v/clamed/order/'
string is_id_interface_convenio = '_v/accords/order/'

string is_id_afiliado
string is_cd_conveniado
string is_id_promocao_ecommerce
string is_de_promocao_ecommerce
string is_cd_cupom_desconto
string is_de_descricao_filial_retirada
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_rede_filial
String is_pedido_debug
String is_tipo_manipulado
String is_Exige_NFSE
String is_chave_conector
String is_token_conector
String is_url_conector
String is_de_adquirente
String is_conector_pagamento
String is_nsu_host
String is_nr_psp_recebedor
String is_nr_autorizacao_pix
String is_id_tipo_uso_cd
String is_situacao_erp
String is_id_usa_campanha_exclusiva_pbm
String is_nr_campanha_pbm
String is_id_usa_desconto_pbm
String is_nr_cpf_pbm
String is_cd_conveniado_pbm
String is_nr_autorizacao_pbm
String is_cd_produto_regra_pbm
String is_motivo_cancel
String is_id_tipo_pedido

String is_tipo_pagamento_site_2
String is_comprovante_cartao_2 
String is_autorizacao_cartao_2
String is_Bandeira_Cartao_2
String is_Estabelecimento_2
String is_cartao_credito_2
String is_id_transacao_conector_2
String	is_conector_pagamento_2
String is_de_adquirente_2
String is_nr_autorizacao_pix_2
String is_nsu_host_2
String is_forma_pagto_2
String is_tipo_pagto_2

Datetime idt_aut_pagamento_2
Datetime idt_estimativa_entrega

long il_cd_filial_retirada
long il_cd_tipo = 8
long il_cd_filial
long il_cd_filial_ant
long il_produto_manipulado = 684431
long il_ecommerce_alterada
long il_filial_hub
long il_filial_seller
long il_nr_vending_machine
long il_cd_cidade_entrega
long il_cd_pbm
long il_cd_convenio
long il_cd_condicao_convenio

dc_uo_ds_base ids_pedidos

Datetime idt_compra
Datetime idt_atualizacao
Datetime idt_DataNascimento
Datetime idt_aut_pagamento
Datetime idt_vencimento_reserva

String is_receita_rua
String is_receita_cidade
String is_receita_estado
String is_receita_bairro
String is_receita_numero
String is_receita_telefone
String is_receita_data
String is_receita_sexo
String is_receita_token
String is_receita_id
String is_receita_nm_arquivo
String is_receita_nm_cliente
String is_receita_orgao
String is_receita_nr_doc
String is_id_pedido_site
String is_user_id
String is_canal_compra
String is_sequencial
String is_tipo_vale
String is_Situacao
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
String is_cidade_ibge
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
String is_id_transacao_conector
String is_cd_warehouseid

Long il_cliente 
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
Integer ii_parcelas_2
Integer ii_boleto_parcelado

Decimal idc_subtotal
Decimal idc_embalagem
Decimal idc_frete
Decimal idc_desconto
Decimal idc_valecompra
Decimal idc_Total
Decimal idc_indexador
Decimal idc_Preco
Decimal idc_Preco_Promo
Decimal idc_desconto_prd
Decimal idc_Desconto_Validacao
Decimal idc_acrescimo_pagamento
Decimal idc_acrescimo
Decimal idc_acrescimo_prd
Decimal idc_vl_preco_maximo_pbm
Decimal idc_vl_reposicao_pbm
Decimal idc_vl_forma_pagamento
Decimal idc_vl_forma_pagamento_2

end variables

forward prototypes
public subroutine of_limpa_variaveis ()
public function boolean of_atualiza_baixa (string ps_id_rede, string ps_nr_pedido, ref string ps_log)
public function boolean of_grava_pedido (string ps_nr_pedido, ref string ps_log)
public subroutine of_limpa_variaveis_produto ()
public function boolean of_carrega_produtos (string ps_json, ref string ps_log)
public function boolean of_busca_transportadora (string ps_valor, ref string ps_log)
public function boolean of_atualiza_pedido (string ps_nr_pedido, ref string ps_log)
public function boolean of_conecta_filial (ref string ps_log)
public function boolean of_desconecta_filial ()
public function boolean of_grava_produto (ref string ps_log)
public function boolean of_busca_nsu (string ps_json, ref string ps_log, ref string ps_nsu, ref string ps_autorizacao)
public function boolean of_carrega_nsu (ref string ps_log)
public function boolean of_carrega_pedido (string ps_json, ref string ps_log, long pl_pedido_erp, long pl_seq_log)
public function boolean of_carrega_dados_cliente (string ps_json, ref string ps_log, long pl_seq_log)
public function boolean of_carrega_receita (ref string ps_log)
public function boolean of_executa_upload_receita (ref string ps_log)
public function boolean of_valida_endereco (ref string ps_mensagem_email, ref string ps_log)
public function boolean of_verifica_codigo_produto (string ps_refid, ref string ps_log)
public function boolean of_valida_pedido (ref string ps_log, string ps_rede)
public function boolean of_filial_ecommerce (string ps_log)
public function boolean of_busca_endereco_filial (ref string ps_cd_uf, ref string ps_bairro, ref string ps_log)
public function boolean of_busca_filial (string ps_id_filial, ref string ps_log, string ps_name_seller)
public function boolean of_busca_vending_machine (string ps_cep, ref long pl_nr_vm, ref string ps_log)
public function boolean of_valida_status_pedido (string ps_json)
public function boolean of_busca_nsu_esitef (string ps_tipo, string ps_id_transacao, ref string ps_nsu_host, ref string ps_id_autorizacao, ref datetime pdh_autorizacao, ref string ps_log)
public function boolean of_processa_atualizacao_pedido (string ps_rede_filial)
public function boolean of_carrega_pagamento_gototem (string ps_json, ref string ps_log)
public function boolean of_grava_pagamento (long pl_cd_filial, long pl_nr_pedido, ref string ps_log)
public function boolean of_grava_pagamento (ref string ps_log)
public function boolean of_carrega_dados_reserva (long pl_cd_filial, string ps_rede_filial, string ps_nr_pedido, ref string ps_log)
public function boolean of_verifica_pedido_empurrado (ref string ps_log)
public function boolean of_carrega_pbm (ref string ps_log)
public function boolean of_carrega_produto_receita (ref string ps_json)
public function boolean of_busca_produto_ecommerce (long pl_cd_produto, ref string ps_cd_produto_ecommerce, ref string ps_log)
public function boolean of_carrega_produto_pedido (string ps_json, long pl_qtde_kit, ref string ps_log)
public subroutine of_ajusta_horario (ref datetime pdt_data)
public function boolean of_consulta_pedido_magalu (string ps_nr_pedido, ref string ps_retorno, ref string ps_log)
public function boolean of_carrega_pagamento_magalu (string ps_json, ref string ps_log)
public function boolean of_iniciar_manuseio (string ps_rede_filial, long pl_cd_filial, string ps_nr_pedido, ref string ps_log)
public function boolean of_carrega_pagamento (string ps_json, ref string ps_log)
public function boolean of_carrega_pagamento_transacao (ref string ps_tipo_pagamento, ref string ps_log)
public function boolean of_busca_forma_pagamento (string ps_de_adquirente, string ps_tipo_pagamento, string ps_forma_pagamento, ref string ps_cd_pagamento, ref string ps_cd_forma_pagamento, ref long pl_id_pagamento, ref string ps_cd_estabelecimento, ref string ps_nm_administradora_cartao, ref string ps_id_tipo_uso_cd, ref string ps_log)
public function boolean of_carrega_pagamento_cartao (string ps_info_pagamento, ref string ps_log)
public function boolean of_busca_descricao_filial_retirada (string ps_info_entrega, ref string ps_descricao_retirada, ref string ps_log)
public function boolean of_grava_promocao (ref string ps_log)
public function boolean of_carrega_promocao (string ps_info_promocoes, ref string ps_log)
public function boolean of_grava_produto_promocao (ref string ps_log)
public function boolean of_carrega_produto_desconto (string ps_json, ref decimal pdc_pc_desconto, ref decimal pdc_vl_desconto, ref decimal pdc_vl_acrescimo, ref string ps_log)
public function boolean of_carrega_convenio (ref string ps_log)
public function boolean of_busca_cidade_cep (string ps_cep, string ps_cd_uf, ref string ps_nm_cidade, ref string ps_log)
public function boolean of_grava_delivery (ref string ps_log)
public function boolean of_busca_descricao_cidade (long pl_cd_cidade, ref string ps_ds_cidade, ref string ps_log)
public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, string ps_id_afiliado, long pl_cd_filial)
public function boolean of_carrega_pagamento_memed (ref string ps_log)
end prototypes

public subroutine of_limpa_variaveis ();
ib_filial_hub = false

ids_produtos_pbm.reset()
ids_promocoes.reset()
ids_produto_promo.reset()

setnull( il_cd_convenio )
setnull( il_cd_condicao_convenio )
setnull( is_cd_conveniado )
setnull( is_id_promocao_ecommerce )
setnull( is_de_promocao_ecommerce )
setnull( is_cd_cupom_desconto )
setnull( idt_compra )
setnull( idt_atualizacao )
setnull( idt_DataNascimento )
setnull( idt_estimativa_entrega )
setnull( is_de_descricao_filial_retirada )
setnull( il_cd_filial_retirada )
setnull( idc_acrescimo_pagamento )
setnull( is_id_tipo_pedido )
setnull( is_cd_conveniado_pbm )
setnull( is_nr_autorizacao_pbm )
setnull( is_cd_produto_regra_pbm )
setnull( is_motivo_cancel )
setnull( is_nr_cpf_pbm )
setnull( idt_vencimento_reserva )
setnull( is_cd_warehouseid )
setnull( is_id_tipo_uso_cd )
setnull( is_nr_autorizacao_pix )
setnull( is_nr_psp_recebedor )
setnull( is_nsu_host )
setnull( idt_aut_pagamento )
setnull( is_conector_pagamento )
setnull( is_de_adquirente) 
setnull( is_url_conector )
setnull( is_chave_conector )
setnull( is_token_conector )
setnull( is_id_transacao_conector )
setnull( il_nr_pedido )
setnull( is_user_id )
setnull( is_canal_compra )
setnull( is_sequencial)
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
setnull(il_cd_cidade_entrega)
setnull( is_fone_ent )
setnull( is_fone_contato_ent )
setnull( is_observacao )
setnull( is_tipo_frete ) // id_tipo_frete
setnull( is_transportadora_site )
setnull( is_regiao ) //nm_regiao_entrega
setnull( is_tipo_pgto )
setnull( is_forma_pagto )
setnull( is_origem )
setnull( is_promocao )
setnull( is_Bloqueto )
setnull( is_referencia )
setnull( is_cd_transacao )
setnull(is_pedido_ecommerce)

setnull( il_cliente ) // cd_cliente
setnull( il_Pagamento )

setnull( ii_prazo_entrega ) // nr_prazo_entrega
setnull( ii_parcelas )
setnull( ii_boleto_parcelado )

setnull( idc_subtotal )
setnull( idc_embalagem )
setnull( idc_frete )
setnull( idc_desconto )
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
setnull(il_nr_vending_machine)

idc_Desconto_Validacao = 0

ib_cadastra = True
ib_endereco_valido = true

//Vl_embalagem
idc_embalagem = 0

//vl_desconto
idc_desconto = 0

//vl_valecompra
idc_valecompra = 0

ib_existe_produto_manipulado = False

setnull( idc_vl_forma_pagamento )
setnull( idc_vl_forma_pagamento_2 )
setnull( ii_parcelas_2 )
setnull( is_comprovante_cartao_2 )
setnull( is_autorizacao_cartao_2 )
setnull( is_Bandeira_Cartao_2 )
setnull( is_Estabelecimento_2 )
setnull( is_cartao_credito_2 )
setnull( is_nsu_host_2 )
setnull( is_forma_pagto_2 )
setnull( is_tipo_pagto_2 )
setnull( is_tipo_pagamento_site_2 )
setnull( is_id_transacao_conector_2 )
setnull( is_conector_pagamento_2 )
setnull( is_de_adquirente_2 )
setnull( is_nr_autorizacao_pix_2 )
setnull( idt_aut_pagamento_2 )

if ib_afiliado = false then
	SetNull(il_ecommerce_alterada)
	setnull( il_filial_seller)
	SetNull(il_filial_hub)
end if

end subroutine

public function boolean of_atualiza_baixa (string ps_id_rede, string ps_nr_pedido, ref string ps_log);Update pedido_ecommerce_baixa
set dh_importacao = getdate(), de_observacao =:is_observacao_baixa, id_tipo_pedido = :is_id_tipo_pedido
where id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :ps_id_rede
	and nr_pedido_ecommerce = :ps_nr_pedido;
	
if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_baixa ~n' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce_baixa": ' + sqlca.sqlerrtext
	return false
end if

return true
end function

public function boolean of_grava_pedido (string ps_nr_pedido, ref string ps_log);Decimal ldc_Desconto

long ll_existe
long ll_nr_pedido
Long ll_Filial

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

ldc_Desconto = 0.00
idc_subtotal = idc_subtotal - idc_desconto + idc_acrescimo
idc_desconto = 0.00

if isnull(idc_frete) then idc_frete = 0

if ib_endereco_valido = false Then
	is_situacao = 'I'
end if

INSERT INTO pedido_ecommerce  
		 ( cd_filial_ecommerce,
		   nr_pedido,   
		   nr_pedido_ecommerce,
		   dh_compra,   
		   dh_atualizacao,   
		   id_situacao,   
		   cd_cliente,   
		   nm_cliente,   
		   de_endereco_email,   
		   nr_cpf_cgc,   
		   nr_inscricao_estadual,   
		   id_fisica_juridica,   
		   id_sexo,   
		   dh_nascimento,   
		   nm_contato,   
		   de_endereco,   
		   nr_endereco,   
		   de_complemento,   
		   de_bairro,   
		   de_cidade,   
		   cd_uf,   
		   nr_cep,   
		   de_pais,   
		   nr_fone,   
		   nr_fone_contato,   
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
		   nr_fone_ent,   
		   nr_fone_contato_ent,   
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
			 id_ecommerce,
			 id_usuario_vtex,
			 de_canal_compra_vtex,
			 nr_vending_machine)  
VALUES ( :il_ecommerce_alterada, 	//cd_filial_ecommerce
		   :ll_nr_pedido, 		      			//nr_pedido,  
		   :ps_nr_pedido,
		   :idt_compra, 					//dh_compra,   
		   :idt_atualizacao,				//dh_atualizacao,   
		   :is_Situacao,					//id_situacao,   
		   :il_cliente, 						//cd_cliente,   
		   :is_nome,						//nm_cliente,   
		   :is_email,						//de_endereco_email,   
		   :is_cpf_cgc,						//nr_cpf_cgc,   
		   :is_ie,								//nr_inscricao_estadual,   
		   :is_fisica_juridica, 				//id_fisica_juridica,   
		   :is_sexo,							//id_sexo,   
		   :idt_DataNascimento,			//dh_nascimento,   
		   :is_contato,						//nm_contato,   
		   null,					//de_endereco,   
		   null,						//nr_endereco,   
		   null,				//de_complemento,   
		   null,						//de_bairro,   
		   null,						//de_cidade,   
		   null,							//cd_uf,   
		   null,							//nr_cep,   
		   null,							//de_pais,   
		   :is_fone,							//nr_fone,   
		   :is_fone_contato,				//nr_fone_contato,   
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
		   :is_fone_ent,					//nr_fone_ent,   
		   :is_fone_contato_ent,			//nr_fone_contato_ent,   
		   :is_observacao,				//de_observacao,   
		   :is_tipo_frete,					//id_tipo_frete,   
		   :is_de_transportadora,			//nm_transportadora,   
		   :il_cd_tipo_entrega,
		   :ii_prazo_entrega,				//nr_prazo_entrega,   
		   :is_regiao,						//nm_regiao_entrega,   
		   :idc_subtotal,					//vl_subtotal,   
		   :idc_embalagem,				//vl_embalagem,   
		   :idc_frete,						//vl_frete,   
		   :ldc_Desconto,					//vl_desconto,   
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
		   :is_cd_cupom_desconto,		//cd_cupom_desconto,   
		   :is_promocao,					//de_promocao
		   :il_Filial_Hub,				//cd_filial
		   null, 								//nr_pedido_drogaexpress
		   getdate(),							//dh_inclusao
		   :il_Pagamento,					//id_pagamento	
		   :is_Bloqueto,				//nr_boleto_bancario) -
			:is_sequencial,
			:is_id_ecommerce,
			:is_user_id,
			:is_canal_compra,
			:il_nr_vending_machine)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao inserir registro na tabela "pedido_ecommerce": ~n' + SqlCa.sqlerrtext 
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
																cd_cidade)
Values ( :il_ecommerce_alterada, :ll_nr_pedido, 1,
			:is_endereco, :is_numero, :is_complemento, :is_bairro, :is_cidade, :is_uf, :is_cep, :is_pais, :is_referencia, :il_cd_cidade_entrega);
	
If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao inserir registro na tabela "pedido_ecommerce_endereco"[1]: ~n' + SqlCa.sqlerrtext 
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
																de_observacao, 
																cd_cidade )
Values ( :il_ecommerce_alterada, :ll_nr_pedido, 2,
			:is_endereco_ent, :is_numero_ent, :is_complemento_ent, :is_bairro_ent, :is_cidade_ent, :is_uf_ent, :is_cep_ent, :is_pais_ent, :is_referencia_ent, :is_observacao, :il_cd_cidade_entrega);	
	
If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao inserir registro na tabela "pedido_ecommerce_endereco"[2]: ~n' + SqlCa.sqlerrtext 
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
setnull( idc_desconto_prd )
setnull( is_receita_nm_arquivo )
setnull( is_receita_orgao )
setnull( is_receita_nr_doc )
setnull( is_receita_nm_cliente )
setnull( is_receita_telefone )
setnull( is_receita_data )
setnull( is_receita_sexo )
setnull( is_receita_rua )
setnull( is_receita_cidade )
setnull( is_receita_estado )
setnull( is_receita_bairro )
setnull( is_receita_numero )
setnull(is_tipo_manipulado)
setnull( is_receita_token )
setnull( is_de_promocao_ecommerce )
setnull( is_id_promocao_ecommerce )

end subroutine

public function boolean of_carrega_produtos (string ps_json, ref string ps_log);String ls_info_itens

iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ps_json, 'items', ref ls_info_itens, 'marketplaceItems')

If Not This.of_carrega_produto_pedido( ls_info_itens, 0, ref ps_log ) Then return false

return true
end function

public function boolean of_busca_transportadora (string ps_valor, ref string ps_log);string ls_id_situacao
string ls_Disque, ls_id_motoboy_ecommerce, ls_cd_prestador

ps_valor = Upper(ps_valor)

If ps_valor = 'CORREIO PAC' Then ps_valor = 'CORREIOS PAC'

Select cd_tipo_entrega, de_tipo_entrega, de_tipo_entrega_site, id_situacao, id_tipo_entrega, id_exige_nfse
into :il_cd_tipo_entrega, :is_de_transportadora, :is_transportadora_site, :ls_id_situacao, :is_id_tipo_entrega, :is_Exige_NFSE
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

If (is_id_tipo_entrega = 'MOT' ) and il_filial_hub <> 454 Then
			
	Select coalesce(vl_parametro, 'N')
	Into :ls_id_motoboy_ecommerce
	from parametro_loja
	where cd_filial = :il_filial_hub
	  and cd_parametro = 'ID_MOTOBOY_ECOMMERCE'
    Using SqlCa;
	
	if sqlca.sqlcode = -1 then 
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_transportadora. ' + 'Problemas ao consultar a tabela "parametro_loja": ' + sqlca.sqlerrtext
		return false
	end if		
	
	if ls_id_motoboy_ecommerce = 'S' then
	
		select vl_parametro
			into :ls_cd_prestador
			from parametro_loja
			where cd_filial = :il_filial_hub
			and cd_parametro = 'CD_PRESTADOR_SERVICO_DISQUE_ENTREGA';
	
		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_transportadora. ' + 'Problemas ao consultar a tabela "parametro_loja": ' + sqlca.sqlerrtext
			return false
		end if
	
		if isnull(ls_cd_prestador) or ls_cd_prestador = '' then
			ps_log = 'O Prestador de servi$$HEX1$$e700$$ENDHEX$$os para entregas MOTOBOY n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurado para esta filial - ' + iif(IsNull(il_Filial_Hub), '', String(il_Filial_Hub))
			return false
		End If
	
	Elseif isnull(ls_id_motoboy_ecommerce) or ls_id_motoboy_ecommerce <> 'S' then
			
		Select coalesce(vl_parametro, 'N')
		Into :ls_Disque
		from parametro_loja
		where cd_filial = :il_filial_hub
		  and cd_parametro = 'ID_DISQUE_ENTREGA'
		 Using SqlCa;
		
		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_transportadora. ' + 'Problemas ao consultar a tabela "parametro_loja": ' + sqlca.sqlerrtext
			return false
		end if
	
		If (ls_Disque <> 'S') or sqlca.sqlcode = 100  Then
			ps_log = 'O servi$$HEX1$$e700$$ENDHEX$$o de disque entrega n$$HEX1$$e300$$ENDHEX$$o esta ativo para esta filial - ' + iif(IsNull(il_Filial_Hub), '', String(il_Filial_Hub))
			return false
		End If
		
	ENd if
	
End If

return true
end function

public function boolean of_atualiza_pedido (string ps_nr_pedido, ref string ps_log);string ls_id_situacao_loja
string ls_matricula_alteracao
string ls_id_situacao_loja_novo
string ls_id_cotacao
string ls_nm_transportadora
string ls_id_situacao_atual
string ls_nr_pedido_drogaexpress

boolean lb_pagamento_aprovado = false
boolean lb_iniciar_manuseio = True

datetime ldh_validade
datetime ldh_cancelamento

uo_ge501_pedido_loja luo_pedido_loja

// Somente se o pedido estiver CANCELADO no site
if is_Situacao <> 'X' and is_situacao <> 'A' Then Return true

if is_situacao = 'X' Then
	ls_matricula_alteracao = '14330'
	
	ldh_cancelamento = gf_getserverdate()
	
else
	setnull(ls_matricula_alteracao)
	setnull(ldh_cancelamento)
end if

if is_situacao = 'A' then lb_pagamento_aprovado = True

If Not iuo_comum_vtex.of_verifica_usa_saldo_virtual( is_id_ecommerce, is_rede_filial, il_filial_hub, ref ps_log) then return false

if ib_usa_pdv_java = True Then

	select id_situacao
	into :ls_id_situacao_atual
	from pedido_ecommerce
	where nr_pedido_ecommerce = :ps_nr_pedido
			and cd_filial_ecommerce = :il_ecommerce_alterada
		Using SQLCA; 
		
	if SQLCA.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao consultar registro na tabela "pedido_ecommerce": ' + SQLCA.sqlerrtext
		return false
	end if
	
	//Somente prosseguir se o pedido ainda estiver aberto.
	if ls_id_situacao_atual <> 'G' and ls_id_situacao_atual <> 'A' then
		if is_situacao = 'X' then
			ps_log = 'O pedido n$$HEX1$$e300$$ENDHEX$$o pode ser cancelado. Situa$$HEX2$$e700e300$$ENDHEX$$o do pedido na loja: ' + ls_id_situacao_atual
		End if
		return true
	end if
		
	//Quando pagamento foi aprovado, verificar se precisa gerar pedido empurrado.
	if (ib_filial_hub = True or iuo_comum_vtex.ib_usa_saldo_virtual = True) and lb_pagamento_aprovado = True and ls_id_situacao_atual = 'G' Then
		If Not this.of_verifica_pedido_empurrado( ref ps_log ) then return false
	end if
	
	//Se o endere$$HEX2$$e700f500$$ENDHEX$$ estiver inv$$HEX1$$e100$$ENDHEX$$lido a situa$$HEX2$$e700e300$$ENDHEX$$o tem que mudar (apenas na central) para "I".
	if ib_endereco_valido = false and is_situacao = 'A' Then	
		//Situa$$HEX2$$e700e300$$ENDHEX$$o na central muda para I (Endere$$HEX1$$e700$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido)
		is_situacao = 'I' 
	end if
	
	if ls_id_situacao_atual = 'G' or is_situacao = 'I' or is_situacao = 'X' then
	
		Update pedido_ecommerce
		set id_situacao = :is_situacao , nr_matric_alteracao_situacao = :ls_matricula_alteracao, dh_cancelamento = :ldh_cancelamento
		where nr_pedido_ecommerce = :ps_nr_pedido
			and cd_filial_ecommerce = :il_ecommerce_alterada
			Using SQLCA;
	
		if SQLCA.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce": ' + SQLCA.sqlerrtext
			return false
		end if
	
		if is_situacao = 'X' then
			
			Update pedido_ecommerce_auxiliar
					set de_motivo_cancelamento_pedido = :is_motivo_cancel
				where cd_filial_ecommerce = :il_ecommerce_alterada
					and nr_pedido = :il_nr_pedido
				Using SqlCa;
		
				If SqlCa.SqlCode = -1 Then
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce_auxiliar": ' + SQLCA.sqlerrtext
					return false
				end if
			
		End if
	
	ENd if
	
	if ls_id_situacao_atual = 'G' and lb_pagamento_aprovado = True Then
		
		//Atualiza as informa$$HEX2$$e700f500$$ENDHEX$$es de pagamento
		If Not this.of_grava_pagamento( il_ecommerce_alterada, il_nr_pedido, ref ps_log ) Then return false
	
		if lb_iniciar_manuseio = True Then
			If Not this.of_iniciar_manuseio( is_rede_filial , il_filial_seller, ps_nr_pedido, ref ps_log) Then return false
		end if
	
		if this.is_id_tipo_entrega = 'MOT' Then
			if Not this.of_grava_delivery( ref ps_log ) then return false
		End if
	
	elseif is_situacao = 'X' then
		is_observacao_baixa = 'PEDIDO CANCELADO NO SITE'
	end if
	
Else

	ls_id_situacao_loja_novo = is_situacao
	
	//Se o pedido estiver com situa$$HEX2$$e700e300$$ENDHEX$$o cancelado no site.
	
	If Not this.of_desconecta_filial( ) Then Return false
	If Not this.of_conecta_filial( ref ps_log ) Then Return false
	
	Select id_situacao, nr_pedido_drogaexpress
	into :ls_id_situacao_loja, :ls_nr_pedido_drogaexpress
	from pedido_drogaexpress
	where nr_pedido_ecommerce_site = :ps_nr_pedido
	and id_situacao <> 'X'
	Using iuo_comum_vtex.itr_filial;
	
	if iuo_comum_vtex.itr_filial.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao consultar a tabela "pedido_drogaexpress": ' + iuo_comum_vtex.itr_filial.sqlerrtext
		return false
	end if
	
	//Se o endere$$HEX2$$e700f500$$ENDHEX$$ estiver inv$$HEX1$$e100$$ENDHEX$$lido a situa$$HEX2$$e700e300$$ENDHEX$$o tem que mudar (apenas na central) para "I".
	if ib_endereco_valido = false and is_situacao = 'A' Then
		
		//Situa$$HEX2$$e700e300$$ENDHEX$$o na central muda para I (Endere$$HEX1$$e700$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido)
		is_situacao = 'I' 
		
		//Situa$$HEX2$$e700e300$$ENDHEX$$o na loja deve permancer a mesma
		ls_id_situacao_loja_novo = ls_id_situacao_loja
		
	else
		ls_id_situacao_loja_novo = is_situacao
	end if

	// Se n$$HEX1$$e300$$ENDHEX$$o existir o pedido na loja, apenas atualiza na matriz
	If iuo_comum_vtex.itr_filial.SqlCode = 100  Then
	
		Update pedido_ecommerce
		set id_situacao = :is_situacao , nr_matric_alteracao_situacao = :ls_matricula_alteracao
		where nr_pedido_ecommerce = :ps_nr_pedido
			and cd_filial_ecommerce = :il_ecommerce_alterada
			Using SQLCA;
	
		if SQLCA.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce": ' + SQLCA.sqlerrtext
			return false
		end if
		
		if lb_pagamento_aprovado = True Then
			
			//Atualiza as informa$$HEX2$$e700f500$$ENDHEX$$es de pagamento
			If Not this.of_grava_pagamento( il_ecommerce_alterada, il_nr_pedido, ref ps_log ) Then return false
		
		elseif is_situacao = 'X' then
			is_observacao_baixa = 'PEDIDO CANCELADO NO SITE'
			
			Update pedido_ecommerce_entrega
					set id_situacao = 'X'
				where cd_filial_ecommerce = :il_ecommerce_alterada
					and nr_pedido = :il_nr_pedido
					and id_situacao = 'A'
				Using SqlCa;
		
				If SqlCa.SqlCode = -1 Then
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce_entrega": ' + SQLCA.sqlerrtext
					return false
				end if
			
			Update pedido_ecommerce_auxiliar
					set de_motivo_cancelamento_pedido = :is_motivo_cancel
				where cd_filial_ecommerce = :il_ecommerce_alterada
					and nr_pedido = :il_nr_pedido
				Using SqlCa;
		
				If SqlCa.SqlCode = -1 Then
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce_auxiliar": ' + SQLCA.sqlerrtext
					return false
				end if
			
		end if
		
	Else
	
		Choose case ls_id_situacao_loja
			
			//Se a situa$$HEX2$$e700e300$$ENDHEX$$o na loja for Aprovado/Pagamento Pendente: Atualiza o pedido na loja e na matriz
			Case 'A', 'G'
				
				if lb_pagamento_aprovado = True then
					//Se estava como pagamento pendente tem que atualizar as informa$$HEX2$$e700f500$$ENDHEX$$es do cart$$HEX1$$e300$$ENDHEX$$o
					
					//Atualiza as informa$$HEX2$$e700f500$$ENDHEX$$es de pagamento
					If Not this.of_grava_pagamento( il_ecommerce_alterada, il_nr_pedido, ref ps_log ) Then return false
					
				End if
				
				if ls_id_situacao_loja = 'G' and lb_pagamento_aprovado = True then
					setnull(ls_nm_transportadora)
					
					If is_Situacao = 'A' and ( is_id_tipo_entrega = 'EXP' or is_id_tipo_entrega = 'ECM' ) Then
						
						luo_pedido_loja = create uo_ge501_pedido_loja
						if Not luo_pedido_loja.of_entrega_cotacao( il_ecommerce_alterada, il_nr_pedido, is_id_tipo_entrega, ref ls_id_cotacao, ref ls_nm_transportadora, ref ldh_validade, ref ps_log) Then
							destroy(luo_pedido_loja)
							return false
						end if
						
						destroy(luo_pedido_loja)
					end if
					
					//Quando pagamento foi aprovado, verificar se precisa gerar pedido empurrado.
					if ib_filial_hub = True or iuo_comum_vtex.ib_usa_saldo_virtual = True Then
						If Not this.of_verifica_pedido_empurrado( ref ps_log ) then return false
					end if
					
					if this.is_id_tipo_entrega = 'MOT' Then
						if Not this.of_grava_delivery( ref ps_log ) then return false
					End if
					
					///Se estava como pagamento pendente tem que atualizar as informa$$HEX2$$e700f500$$ENDHEX$$es do cart$$HEX1$$e300$$ENDHEX$$o
					if this.idc_vl_forma_pagamento_2 > 0 then
						
						//Se possuir duas formas de pagamento, tem que atualizar na tabela pedido_drogaexpress_pagamento:
						
						//Atualiza para a primeira forma de pagamento:
						update pedido_drogaexpress_pagamento
						set nr_comprovante_nsu = :this.is_comprovante_cartao,
							nr_autorizacao = :this.is_autorizacao_cartao
						where nr_pedido_drogaexpress = :ls_nr_pedido_drogaexpress
						and nr_cartao_credito = :this.is_cartao_credito
						and vl_pagamento = :this.idc_vl_forma_pagamento
						Using iuo_comum_vtex.itr_filial;
						
						if iuo_comum_vtex.itr_filial.sqlcode = -1 then
							ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao consultar a tabela "pedido_drogaexpress_pagamento(1)": ' + iuo_comum_vtex.itr_filial.sqlerrtext
							return false
						end if
						
						//Atualiza para a segunda forma de pagamento:
						update pedido_drogaexpress_pagamento
						set nr_comprovante_nsu = :this.is_comprovante_cartao_2 ,
							nr_autorizacao = :this.is_autorizacao_cartao_2
						where nr_pedido_drogaexpress = :ls_nr_pedido_drogaexpress
						and nr_cartao_credito = :this.is_cartao_credito_2
						and vl_pagamento = :this.idc_vl_forma_pagamento_2
						Using iuo_comum_vtex.itr_filial;
						
						if iuo_comum_vtex.itr_filial.sqlcode = -1 then
							ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar a tabela "pedido_drogaexpress_pagamento(2)": ' + iuo_comum_vtex.itr_filial.sqlerrtext
							return false
						end if
						
						//Atualiza o pedido:
						Update pedido_drogaexpress
						set id_situacao = :ls_id_situacao_loja_novo, nr_matricula_cancelamento = :ls_matricula_alteracao, dh_emissao = now(),
							nm_transportadora_ecommerce = :ls_nm_transportadora,
							dh_validade_cotacao_entrega = :ldh_validade
						where nr_pedido_ecommerce_site = :ps_nr_pedido
						and id_situacao <> 'X'
						Using iuo_comum_vtex.itr_filial;
					
						if iuo_comum_vtex.itr_filial.sqlcode = -1 then
							ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar a tabela "pedido_drogaexpress(1)": ' + iuo_comum_vtex.itr_filial.sqlerrtext
							return false
						end if
						
						
					Else
						//Se possui apenas uma forma de pagamento, atualizar direto na tabela pedido_drogaexpress:
						
						//Atualiza o pedido com as infos de pagamento:
						Update pedido_drogaexpress
						set id_situacao = :ls_id_situacao_loja_novo, nr_matricula_cancelamento = :ls_matricula_alteracao, dh_emissao = now(),
							nr_comprovante_cartao_credito = :is_comprovante_cartao,  nr_autorizacao_cartao_credito = :is_autorizacao_cartao, nm_administradora_cartao = :is_Bandeira_Cartao,
							nm_transportadora_ecommerce = :ls_nm_transportadora,
							dh_validade_cotacao_entrega = :ldh_validade
						where nr_pedido_ecommerce_site = :ps_nr_pedido
						and id_situacao <> 'X'
						Using iuo_comum_vtex.itr_filial;
					
						if iuo_comum_vtex.itr_filial.sqlcode = -1 then
							ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar a tabela "pedido_drogaexpress(2)": ' + iuo_comum_vtex.itr_filial.sqlerrtext
							return false
						end if
					
					ENd if
				
				
					//Grava comprovante de venda na loja quando forma de pagamento = carteira digital (PIX), ou pedidos de afiliado (Gototem/MEMED), ou Convenio:
					if ib_usa_pdv_java = false and ( is_tipo_pgto = 'PIX' or is_tipo_pgto = 'PIX ECOMMERCE' or ib_afiliado = True or is_tipo_pgto = 'PICPAY ECOMMERCE' or is_forma_pagto = 'CV' or is_id_tipo_pedido = 'MGZ') Then
						
						if is_tipo_pgto = 'PIX ECOMMERCE' Then
							is_nsu_host = gf_replace(is_nsu_host, ' ','',0)
						end if
						
						luo_pedido_loja = create uo_ge501_pedido_loja
						
						if Not	luo_pedido_loja.of_grava_comp_venda(iuo_comum_vtex.itr_filial, ls_id_situacao_loja_novo, il_nr_pedido, il_filial_hub, idc_vl_forma_pagamento, ii_parcelas, is_Estabelecimento, is_Bandeira_Cartao, is_nsu_host, is_autorizacao_cartao, is_nr_autorizacao_pix, is_cartao_credito, is_nr_psp_recebedor, is_id_tipo_uso_cd, is_forma_pagto, ref ps_log) then 
							Destroy(luo_pedido_loja)
							return false
						end if
						
						if this.idc_vl_forma_pagamento_2 > 0 then
							
							if Not	luo_pedido_loja.of_grava_comp_venda(iuo_comum_vtex.itr_filial, ls_id_situacao_loja_novo, il_nr_pedido, il_filial_hub, idc_vl_forma_pagamento_2, this.ii_parcelas_2 , this.is_estabelecimento_2, is_Bandeira_Cartao_2, is_nsu_host_2, is_autorizacao_cartao_2, is_nr_autorizacao_pix_2, is_cartao_credito_2, is_nr_psp_recebedor, is_id_tipo_uso_cd,is_forma_pagto_2, ref ps_log) then 
								Destroy(luo_pedido_loja)
								return false
							end if
						End if
						
						Destroy(luo_pedido_loja)
						
					end if
				
				
				else
					
					Update pedido_drogaexpress
					set id_situacao = :ls_id_situacao_loja_novo, nr_matricula_cancelamento = :ls_matricula_alteracao
					where nr_pedido_ecommerce_site = :ps_nr_pedido
					and id_situacao <> 'X'
					Using iuo_comum_vtex.itr_filial;
			
					if iuo_comum_vtex.itr_filial.sqlcode = -1 then
						ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao consultar a tabela "pedido_drogaexpress": ' + iuo_comum_vtex.itr_filial.sqlerrtext
						return false
					end if
			
				end if
	
				Update pedido_ecommerce
				set id_situacao = :is_situacao, nr_matric_alteracao_situacao = :ls_matricula_alteracao, dh_cancelamento = :ldh_cancelamento
				where nr_pedido_ecommerce = :ps_nr_pedido
					and cd_filial_ecommerce = :il_ecommerce_alterada
					Using SQLCA;
		
				if SQLCA.sqlcode = -1 then
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce": ' + SQLCA.sqlerrtext
					return false
				end if
				
				if is_situacao = 'X' then
					is_observacao_baixa = 'PEDIDO CANCELADO NO SITE'
					
						Update pedido_ecommerce_entrega
						set id_situacao = 'X'
					where cd_filial_ecommerce = :il_ecommerce_alterada
						and nr_pedido = :il_nr_pedido
						and id_situacao = 'A'
					Using SqlCa;
			
					If SqlCa.SqlCode = -1 Then
						ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce_entrega": ' + SQLCA.sqlerrtext
						return false
					end if
					
					Update pedido_ecommerce_auxiliar
					set de_motivo_cancelamento_pedido = :is_motivo_cancel
					where cd_filial_ecommerce = :il_ecommerce_alterada
						and nr_pedido = :il_nr_pedido
					Using SqlCa;
			
					If SqlCa.SqlCode = -1 Then
						ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce_auxiliar": ' + SQLCA.sqlerrtext
						return false
					end if
					
				end if
				
				if lb_pagamento_aprovado = True then
					
					if lb_iniciar_manuseio = True Then
						If Not this.of_iniciar_manuseio( is_rede_filial , il_filial_seller, ps_nr_pedido, ref ps_log) Then return false
					end if
					
				end if
				
			Case 'F','E','D'
				
				ps_log = 'O pedido n$$HEX1$$e300$$ENDHEX$$o pode ser cancelado. Situa$$HEX2$$e700e300$$ENDHEX$$o do pedido na loja: ' + ls_id_situacao_loja
				return true
		
		End Choose
		
	ENd if
	
End If

return true
end function

public function boolean of_conecta_filial (ref string ps_log);String ls_Odbc
string ls_ip
boolean lb_ret

//Primeiro Verifica se a filial esta na lista das filiais sem conexao:
if ids_filiais_sem_conexao.find('cd_filial = ' + string(il_filial_hub), 1, ids_filiais_sem_conexao.rowcount()) > 0 Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(il_filial_hub) 
	return false
end if

if Not iuo_comum_vtex.of_conecta_filial( il_filial_hub,ref ps_log) then
	
	iif(IsNull(il_filial_hub), 0, il_filial_hub)
	
	//Adiciona filial na lista de filiais com problema de conexao:
	if ids_filiais_sem_conexao.find('cd_filial = ' + string(il_filial_hub), 1, ids_filiais_sem_conexao.rowcount()) = 0 Then
		ids_filiais_sem_conexao.insertrow(1)
		ids_filiais_sem_conexao.object.cd_filial[1] = il_filial_hub
	End if
	
	return false
end if

Return True
end function

public function boolean of_desconecta_filial ();return iuo_comum_vtex.of_desconecta_filial( )
end function

public function boolean of_grava_produto (ref string ps_log);Long ll_Sequencial
String ls_id_sexo
Datetime ldh_nascimento

Decimal{5} ldc_Desc_Unit

Decimal ldc_PC_Desconto, ldc_Valor_Desconto
		
If IsNull(idc_desconto_prd) Then idc_desconto_prd = 0.00 

ldc_Desc_Unit = round(idc_desconto_prd  / il_qtde_produto, 5)
idc_Preco_Promo = Round(idc_Preco_Promo - ldc_Desc_Unit,2)
ldc_PC_Desconto = round((1 - (idc_Preco_Promo/idc_Preco)) * 100, 4)

ldc_Valor_Desconto = idc_Preco - idc_Preco_Promo
///\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
//"price": 13260,  -->> idc_Preco_Promo (O produto j$$HEX1$$e100$$ENDHEX$$ possui um desconto. Por isso fa$$HEX1$$e700$$ENDHEX$$o o calculo acima para pegar tamb$$HEX1$$e900$$ENDHEX$$m esse desconto.)
//"listPrice": 14189,  -->> idc_preco
//"manualPrice": null,
//"priceTags": [
//	 {
//		  "name": "discount@price-24f16a9e-941e-4f23-8305-f86702e87705#c228aa38-c2aa-4f2c-80af-7a6e02eb4676",
//		  "value": -1326,  -->> idc_desconto_prd (desconto adicional)
//		  "isPercentual": false,
//		  "identifier": "24f16a9e-941e-4f23-8305-f86702e87705",
//		  "rawValue": -13.26,
//		  "rate": null,
//		  "jurisCode": null,
//		  "jurisType": null,
//		  "jurisName": null
//	 }
//],

//Soma os descontos
idc_Desconto_Validacao = idc_Desconto_Validacao + ldc_Valor_Desconto

if isnull(idc_vl_preco_maximo_pbm) then idc_vl_preco_maximo_pbm = 0
if isnull(idc_vl_reposicao_pbm) then idc_vl_reposicao_pbm = 0

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
		nr_requisicao_manip,
		vl_desconto,
		pc_desconto,
		id_campanha_exclusiva_pbm,
		nr_campanha_pbm,
		cd_pbm,
		id_usa_desconto_pbm,
		cd_conveniado_pbm,
		nr_autorizacao_pbm,
		cd_produto_regra_pbm,
		vl_preco_maximo_pbm,
		vl_reposicao_pbm)
VALUES( :il_ecommerce_alterada,
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
			:il_requisicao_manip,
			:ldc_Valor_Desconto,
			:ldc_PC_Desconto,
			:is_id_usa_campanha_exclusiva_pbm,
			:is_nr_campanha_pbm,
			:il_cd_pbm,
			:is_id_usa_desconto_pbm,
			:is_cd_conveniado_pbm,
			:is_nr_autorizacao_pbm,
			:is_cd_produto_regra_pbm,
			:idc_vl_preco_maximo_pbm,
			:idc_vl_reposicao_pbm)
Using SqlCa;

if SqlCa.sqlcode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao inserir registro na tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
end if

if ib_usa_receita = True Then
	
	if upper(is_receita_sexo) = "MASCULINO" Then	
		ls_id_sexo = 'M' 
	Elseif upper(is_receita_sexo) = "FEMININO" Then
		ls_id_sexo = 'F'
	else
		setnull(ls_id_sexo)
	end if	
		
	ldh_nascimento = datetime(Date(is_receita_data),time('00:00'))	
		
	insert into pedido_ecommerce_prd_receita( cd_filial_ecommerce,   
         														nr_pedido,   
         														cd_produto_ecommerce,   
																nr_sequencial,   
																nm_cliente,   
																id_sexo,   
																dh_nascimento,
																nr_token,
																de_endereco,
																nr_fone,
																de_orgao_emissor_rg,
																nr_doc_identificacao,
																nr_endereco,
																de_bairro,
																nm_cidade,
																cd_unidade_federacao)
	Values(:il_ecommerce_alterada,
				:il_nr_pedido,
				:is_cd_produto_ecommerce,
				:il_sequencial_item,
				:is_receita_nm_cliente,
				:ls_id_sexo,
				:ldh_nascimento,
				:is_receita_token,
				:is_receita_rua,
				:is_receita_telefone,
				:is_receita_orgao,
				:is_receita_nr_doc,
				:is_receita_numero,
				:is_receita_bairro,
				:is_receita_cidade,
				:is_receita_estado);
																  
	if SqlCa.sqlcode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao inserir registro na tabela "pedido_ecommerce_prd_receita":~n' + SqlCa.sqlerrtext
		return false
	end if
	
end if

return true
end function

public function boolean of_busca_nsu (string ps_json, ref string ps_log, ref string ps_nsu, ref string ps_autorizacao);long ll_pos1, ll_pos2, ll_pos3

ll_pos1 = 0
ll_pos1 = pos( ps_json, "authorizationConnectorResponse" )

//Busca o NSU
ll_pos2 = pos( ps_json, 'hostUSN\":\"' , ll_pos1 )

ll_pos3 = pos( ps_json, '\' , ll_pos2 + 13 )

if ll_pos1 = 0 or ll_pos2 = 0 or ll_pos3 = 0 Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o c$$HEX1$$f300$$ENDHEX$$digo NSU [hostUSN].'
	return false
end if

ps_nsu = Trim(Mid( ps_json, ll_pos2 + 12, ll_pos3 - ll_pos2 - 12 ))

ll_pos2 = 0
ll_pos3 = 0

///"authorizationNumber\":\"071408\"
//Busca a autoriza$$HEX2$$e700e300$$ENDHEX$$o
ll_pos2 = pos( ps_json, 'authorizationNumber\":\"' , ll_pos1 )

ll_pos3 = pos( ps_json, '\' , ll_pos2 + 25 )

if ll_pos1 = 0 or ll_pos2 = 0 or ll_pos3 = 0 Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o n$$HEX1$$fa00$$ENDHEX$$mero da autoriza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o [authorizationNumber].'
	return false
end if

ps_autorizacao = Mid( ps_json, ll_pos2 + 24, ll_pos3 - ll_pos2 - 24 )

return true
end function

public function boolean of_carrega_nsu (ref string ps_log);String ls_retorno
long ll_pos
datetime ldh_data 

uo_ge501_comum luo_comum_vtex

try 

	luo_comum_vtex = create uo_ge501_comum
			
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial( il_filial_seller, is_rede_filial, is_id_ecommerce, ref ps_log ) then return false
	luo_comum_vtex.is_url = gf_replace(luo_comum_vtex.is_url, 'myvtex.com', 'vtexpayments.com.br', 0 )

	//Acessa o site para buscar as informa$$HEX2$$e700f500$$ENDHEX$$es de pagamento da transacao
	luo_comum_vtex.of_get( gf_replace( "/api/pvt/transactions/XXX/payments", 'XXX', is_cd_transacao, 0 ) , ref ls_retorno, ref ps_log )
			
	If ps_log <> '' and not isnull(ps_log) Then Return False
	
	//Verifica se est$$HEX1$$e100$$ENDHEX$$ usando Conector ESITEF
	ll_pos = pos( ls_retorno, '"connector":"ESITEF"')

	if ll_pos > 0 Then
		
		this.is_url_conector = luo_comum_vtex.is_url_conector
		this.is_chave_conector = luo_comum_vtex.is_chave_conector
		this.is_token_conector = luo_comum_vtex.is_token_conector
		
		//Se utilizar conector ESITEF:
		if Not this.of_busca_nsu_esitef( 'P', is_id_transacao_conector, ref is_comprovante_cartao, ref is_autorizacao_cartao, ref ldh_data,  ref ps_log) Then return false
	else
		If Not This.of_busca_nsu(ls_retorno, ps_log, is_comprovante_cartao, is_autorizacao_cartao) Then Return False
	end if
		
	If IsNull(is_autorizacao_cartao) or Not IsNumber(is_autorizacao_cartao) Then
		ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero da autoriza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi informado ou $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido [authorizationNumber]."
		Return False
	End If
							
	If IsNull(is_comprovante_cartao) or Not IsNumber(is_comprovante_cartao) Then
		ps_log = "Comprovante do cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi informado ou $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido [hostUSN]."
		Return False
	End If
	
	If Len(is_comprovante_cartao) > 12 Then
		ps_log = "Comprovante do cart$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior que o esperado 12 [hostUSN]."
		Return False
	End If		

Finally
	destroy(luo_comum_vtex)
End try

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
String ls_info_marketing_data
String ls_info_conector
String ls_info_promocoes
String ls_de_bairro_filial
String ls_cd_uf_filial
String ls_Name_Seller
String ls_aux
String ls_grupo_pagamento
String ls_json_magalu
String ls_tipo_entrega

decimal ldc_valor_pagamento

long ll_row
long ll_inicio
long ll_pagamento

uo_ge501_comum luo_comum
uo_ge073_json luo_gera_json

Try

	luo_gera_json = Create uo_ge073_json 
	luo_comum = Create uo_ge501_comum
	
	ls_json_restante = ps_json
	
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'totals', ref ls_info_valores, ']')
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'clientProfileData', ref ls_info_cliente, '}')
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'marketingData', ref ls_info_marketing_data, '}')
	
	ls_json_restante = ps_json
	
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'rateAndBenefitsIdentifiers', ref ls_info_promocoes, ']')
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'shippingData', ref ls_info_endereco, ']')
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'logisticsInfo', ref ls_info_entrega, '"selectedAddresses"')
	
	if ib_afiliado = True Then
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'openTextField', ref ls_info_pagamento, '}')
	else
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'paymentData', ref ls_info_pagamento, 'packageAttachment')
	end if

	//Informa$$HEX2$$e700f500$$ENDHEX$$es referente ao conector de pagamento
	ls_aux = ls_info_pagamento
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_aux, 'connectorResponses', ref ls_info_conector, '}')
	
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'sellers', ref ls_info_loja, ']')
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'invoiceData', ref ls_info_endereco_nota, ']')
	
	ls_info_valores = ls_info_valores + '}'
	
	if ib_afiliado = false Then
	
		//cd_filial
		ls_valor = ''
		ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_loja, 'id')
		
		ls_Name_Seller = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_loja, 'name')
		
		if Not this.of_busca_filial( ls_valor, ref ps_log, ls_Name_Seller ) then return false
		
	end if
	
	//nr_pedido_ecommerce_seq
	ls_valor = ''
	ls_valor =  luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'sequence')
	is_sequencial = ls_valor
	
	is_id_pedido_site = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'orderFormId')
	
	//Dh_compra , Dh_atualizacao
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'creationDate')
	idt_compra =  Datetime( date(ls_valor), time( mid( ls_valor, 12, 5) ) )
	
	//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
	of_ajusta_horario(ref idt_compra)
	
	idt_atualizacao = idt_compra
	
	//Id_situacao
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'status')
	
	// Acontece quando o pedido fica incompleto no site
	If Trim(ls_valor) = '' or IsNull(ls_valor) Then
		//ps_log = 'Pedido criado de forma incompleta na VTEX. N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido .'
		
		is_observacao_baixa = 'PEDIDO INCOMPLETO'
		
		ib_cadastra = False
		Return True
	End If
	
	Choose Case ls_valor
		Case 'payment-pending'
			is_situacao = 'G'
			
		Case 'payment-approved'
			is_situacao = 'A'
			
		Case 'canceled', 'cancel'
			is_situacao = 'X'
			
		Case 'ready-for-handling', 'handling', 'waiting-seller-handling' //"Pronto para o manuseio"
			is_situacao = 'A'
		
		Case Else
			
			// Execu$$HEX2$$e700e300$$ENDHEX$$o em desenvolvimento
			If Not IsNull(is_ODBC_Desenv)  Then
				is_situacao = 'A'
			Else
				is_situacao = 'I'
				ps_log = 'Situa$$HEX2$$e700e300$$ENDHEX$$o do pedido n$$HEX1$$e300$$ENDHEX$$o mapeada: ' + ls_valor
				return false
			End If
			
	End Choose
	
	// Execu$$HEX2$$e700e300$$ENDHEX$$o em desenvolvimento
	If Not IsNull(is_ODBC_Desenv) and is_situacao <> 'G' Then
		is_situacao = 'A'
	End If
	
//	If ( is_situacao = 'G' and il_filial_hub <> 149 ) Then
//		is_observacao_baixa = 'PEDIDO COM PAGAMENTO PENDENTE'
//		ib_cadastra = False
//		Return True
//	end if
	
	// Se n$$HEX1$$e300$$ENDHEX$$o existir no ERP e tiver como canceladono site, continua mas n$$HEX1$$e300$$ENDHEX$$o grava
	// apenas muda para processado
	// ou existi no ERP mas no site j$$HEX1$$e100$$ENDHEX$$ esta faturado
	//Ou Esta cancelado no ERP e veio cmo cancelado do Site
	If (is_situacao_erp = 'X' and  is_situacao = 'X') or ( (IsNull(pl_pedido_erp) and is_situacao = 'X') or  is_situacao = 'F' ) Then
		
		If is_situacao_erp = 'X' then
			is_observacao_baixa = 'PEDIDO J$$HEX1$$c100$$ENDHEX$$ CANCELADO NO ERP'
		ElseIf is_situacao = 'X' Then
			is_observacao_baixa = 'PEDIDO CANCELADO NO SITE'
		Else
			is_observacao_baixa = 'PEDIDO JA CONSTA COMO FATURADO NO SITE'
		End If
		
		ib_cadastra = False
		Return True
	End If
	
	if is_situacao = 'X' Then
		
		is_motivo_cancel = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'cancelReason')
		if is_motivo_cancel = '' Then setnull(is_motivo_cancel)
		
	ENd if
	
	//****** Cliente ******//
	//********************//
	is_userProfileId = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'userProfileId')
	
	//nm_cliente
	is_nome 			= Upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'firstName') + ' ' + luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'lastName'))
	is_nome = gf_retira_acentos(is_nome)
	is_nome = gf_remove_caracteres_especiais(is_nome)	
		
	//nr_cpf_cgc
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'documentType')
	
	If upper(ls_valor) = 'CPF' Then
		ls_valor = ''
		ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'document')
		
		is_cpf_cgc = ls_valor
		is_fisica_juridica = 'F'
	
	elseif upper(ls_valor) = 'CNPJ' Then
		
		ls_valor = ''
		ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'corporateDocument')
		
		is_cpf_cgc = ls_valor
		is_fisica_juridica = 'J'
		
	elseif ls_valor <> '' and not isnull(ls_valor) Then
		ps_log = 'Tipo de documento do cliente n$$HEX1$$e300$$ENDHEX$$o esperado: ' + ls_valor
		return false
	end if
	
	//nr_inscricao_estadual
	is_ie = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'stateInscription')
	 
	//nr_fone
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'phone')
	
	if len(ls_valor) > 12 and left(ls_valor,2) = '55' Then
		ls_valor = mid(ls_valor, 3, 100)
	ENd if
	
	if left(ls_valor,3) = '+55' Then
		ls_valor = mid(ls_valor, 4, 100)
		// (47)984021346
		ls_valor = '(' + Mid(ls_valor, 1,2) + ')' + mid(ls_valor, 3, 100)
	end if
	
	is_fone = ls_valor 
	
	if gf_valida_telefone(is_fone) = false Then
		setnull(is_fone_ent)
	Else
		is_fone_ent = is_fone
	ENd if
	
	//nr_fone_contato
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'corporatePhone')
	
	if len(ls_valor) > 12 and left(ls_valor,2) = '55' Then
		ls_valor = mid(ls_valor, 3, 100)
	ENd if
	
	if left(ls_valor,3) = '+55' Then
		ls_valor = mid(ls_valor, 4, 100)
		// (47)984021346
		ls_valor = '(' + Mid(ls_valor, 1,2) + ')' + mid(ls_valor, 3, 100)
	end if
	
	is_fone_contato 		= ls_valor  
	
	if gf_valida_telefone(is_fone) = false Then
		setnull(is_fone_contato_ent)
	Else
		is_fone_contato_ent = is_fone_contato
	ENd if
	
	//id_usuario_vtex 
	is_user_id = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cliente, 'userProfileId')
	
	//de_canal_compra_vtex 
	is_canal_compra = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_marketing_data, 'utmSource')
	
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_entrega, 'deliveryCompany')
	
	//nm_transportadora
	if Not this.of_busca_transportadora( ls_valor, ref ps_log) Then return false
	
	ls_tipo_entrega = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_entrega, 'selectedSla')
	ls_tipo_entrega = upper(ls_tipo_entrega)
	
	//Prazo de entrega
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_entrega, 'shippingEstimate')
	ls_valor = mid(ls_valor,1,2)
	
	if not isnumber(ls_valor) Then
		ls_valor = mid(ls_valor,1,1)
		if not isnumber(ls_valor) Then	
			ls_valor = '0'
		End if
	ENd if
	
	ii_prazo_entrega = long(ls_valor)
	
	//Data estimada de entrega
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_entrega, 'shippingEstimateDate')
	
	if ls_valor = '' or isnull(ls_valor) then
		setnull(idt_estimativa_entrega)
	Else
		idt_estimativa_entrega = Datetime( date(ls_valor), time( mid( ls_valor, 12, 5) ) )
		
		if ls_tipo_entrega <> 'AGENDADA' then
			//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
			of_ajusta_horario(ref idt_estimativa_entrega)
		End if
	ENd if
	
	ls_valor = ''
	
	is_nome_ent = Upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'receiverName'))
	is_nome_ent = gf_retira_acentos(is_nome_ent)
	is_nome_ent = gf_remove_caracteres_especiais(is_nome_ent)
	
	If IsNull(is_nome_ent) or Trim(is_nome_ent) = '' or is_id_tipo_entrega <> 'RET' Then
		is_nome_ent = is_nome 
	End If
	
	if Not this.of_busca_descricao_filial_retirada( ls_info_entrega, ref is_de_descricao_filial_retirada, ref ps_log) then return false
	
	if is_de_descricao_filial_retirada = '' then setnull(is_de_descricao_filial_retirada)
	
	//****** Endere$$HEX1$$e700$$ENDHEX$$o ******//
	//********************//
	//Quando for retirada em loja:
	if is_id_tipo_entrega = 'RET' Then
		
		If Not this.of_busca_endereco_filial(ref ls_cd_uf_filial, ref ls_de_bairro_filial, ref ps_log ) Then return false
		
		//De_observacao
		//receiverName
		is_Observacao 		= 'Retirada por: '+ Upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'receiverName'))
		
		// S$$HEX1$$f300$$ENDHEX$$ pega se existir os dados da nota (invoice)
		If IsNull(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco_nota, 'street')) or &
			Isnull(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco_nota, 'postalCode')) or &
			pos(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco_nota, 'postalCode'), '**',1 ) > 0 or &
			IsNull(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco_nota, 'neighborhood')) or &
			Isnull(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco_nota, 'city')) or &
			IsNull(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco_nota, 'state')) Then
			ps_log = "Tipo de entrega [Retirada em Loja] exige os dados da nota fiscal.~r~r"  +  "*** O PEDIDO FOI INTEGRADO COM OS DADOS DA LOJA ***"

			ps_log = ''
		Else
			ls_info_endereco 	= ls_info_endereco_nota
		End If
	end if
	
	//de_endereco
	is_endereco 		= upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'street'))
	is_endereco_ent 	= is_endereco
	
	If IsNull(is_endereco) or Trim(is_endereco) = '' Then
		ps_log = 'Endere$$HEX1$$e700$$ENDHEX$$o de entrega:  Endere$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi informado [street].'
		return false
	End If
	
	//nr_endereco
	is_numero 		= luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'number')
	is_numero_ent 	= is_numero
	
	If is_id_tipo_entrega = 'RET' Then
		
		If IsNull(is_numero) Then
			is_numero = '0'
			is_numero_ent = '0'
		End If
		
	End If
	
	//de_complemento
	is_complemento 		= upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'complement'))
	is_complemento = left(is_complemento,60)
	is_complemento_ent 	= is_complemento
	
	//de_referencia_ent
	is_referencia  		= upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'reference'))
	is_referencia = left(is_referencia,60)
	is_referencia_ent 	= is_referencia
	
	//de_bairro
	is_bairro 		= upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'neighborhood'))
	is_bairro_ent 	= is_bairro
	
	If ( IsNull(is_bairro) or Trim(is_bairro) = '' ) and is_id_tipo_entrega = 'RET' Then
		
		ps_log = 'Endere$$HEX1$$e700$$ENDHEX$$o de entrega: Bairro n$$HEX1$$e300$$ENDHEX$$o foi informado [neighborhood].'
		
		luo_comum.of_envia_email(211, 'PEDIDO - [' + is_rede_filial + ']', pl_seq_log, 'Pedido: '  + is_pedido_ecommerce + ' - ' +  ps_log, is_pedido_ecommerce)
		ps_log = ''
		
		is_bairro = ls_de_bairro_filial
		is_bairro_ent = ls_de_bairro_filial
	end if
	
	If IsNull(is_bairro) or Trim(is_bairro) = '' Then
		ps_log = 'Endere$$HEX1$$e700$$ENDHEX$$o de entrega: Bairro n$$HEX1$$e300$$ENDHEX$$o foi informado [neighborhood].'
		return false
	End If
		
	//nr_cep
	is_cep = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'postalCode')
	is_cep = gf_replace( is_cep, '-', '', 0 )
	is_cep_ent = is_cep
	
	//cd_uf
	is_uf = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'state')
	
	If (IsNull(is_uf) or Trim(is_uf) = '' ) and Not IsNull(is_cep) Then
		
		ps_log = 'Endere$$HEX1$$e700$$ENDHEX$$o de entrega: UF n$$HEX1$$e300$$ENDHEX$$o foi informada [state].'
		
		// Apenas faz o envio do e-mail, pois esta solu$$HEX2$$e700e300$$ENDHEX$$o dever$$HEX1$$e100$$ENDHEX$$ ser tempor$$HEX1$$e100$$ENDHEX$$ria
		luo_comum.of_envia_email(211, 'PEDIDO - [' + is_rede_filial + ']', pl_seq_log, 'Pedido: '  + is_pedido_ecommerce + ' - ' +  ps_log, is_pedido_ecommerce)
		ps_log = ''
		
		select top 1 cd_uf 
		Into :is_uf		
		from ect_logradouro
		where nr_cep = :is_cep
		Using SqlCa;
		
		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_pedido. ' + 'Problemas ao consultar a tabela "ect_logradouro": ' + sqlca.sqlerrtext
			return false
		end if
		
	End If
		
	// Se mesmo assim n$$HEX1$$e300$$ENDHEX$$o achar, e for retirada em loja, ent$$HEX1$$e300$$ENDHEX$$o pegar a uf da loja	
	if ( isnull(is_uf) or is_uf = '' ) and is_id_tipo_entrega = 'RET' Then
		is_uf = ls_cd_uf_filial	
	end if
		
	is_uf_ent = is_uf
	
	If IsNull(is_uf) or Trim(is_uf) = '' Then
		ps_log = 'Endere$$HEX1$$e700$$ENDHEX$$o de entrega:  UF n$$HEX1$$e300$$ENDHEX$$o foi informada [state].'
		return false
	End If
	
	//de_cidade
	
	if Not this.of_busca_cidade_cep( is_cep, is_uf, ref is_cidade, ref ps_log) then return false
	
	if is_cidade = '' or isnull(is_cidade) then
		is_cidade = upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'city'))
	End if
	is_cidade_ent = is_cidade
	
	If IsNull(is_cidade) or Trim(is_cidade) = '' Then
		ps_log = 'Endere$$HEX1$$e700$$ENDHEX$$o de entrega:  Cidade n$$HEX1$$e300$$ENDHEX$$o foi informada [city].'
		return false
	End If
	
	gf_retorna_cidade(is_cep, is_cidade, is_uf, ref il_cd_cidade_entrega, ref is_cidade_ibge, ref ps_log )	
	
	if il_cd_cidade_entrega > 0 and is_id_tipo_entrega = 'RET' then
		if Not this.of_busca_descricao_cidade( il_cd_cidade_entrega, ref is_cidade, ref ps_log ) then return false
		
		is_cidade_ent = is_cidade
	ENd if
	
	//de_pais
	is_pais = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_endereco, 'country')
	
	is_pais = iif(IsNull(is_pais), 'BRA', is_pais)
	
	is_pais_ent = is_pais
				
	//***************** Valores
	
	Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_info_valores, Ref ls_retorno,'{') 
		
		ls_valor_tag = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'id')
		ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'value')
		
		Choose Case ls_valor_tag
			Case 'Items'
	
				idc_subtotal = dec(ls_valor)
				idc_subtotal = luo_comum.of_decimal( idc_subtotal )
				
			Case 'Discounts'
				
				if pos(ls_valor,'-') > 0 and len(ls_valor) = 2 then
					
					ls_valor = '-0,0' + String( long(ls_valor) * -1)
					idc_desconto = dec(ls_valor)
				Else
					
					idc_desconto = dec(ls_valor)
					idc_desconto = luo_comum.of_decimal( idc_desconto )
					
				ENd if
				
				if idc_desconto > 0 Then //Acrescimo
					idc_acrescimo = idc_desconto
					idc_desconto = 0
				else //Desconto
					idc_desconto = idc_desconto * -1
					idc_acrescimo = 0
				end if
					
				////idc_desconto = iif(idc_desconto < 0, idc_desconto  * (-1), idc_desconto)
												
			Case 'Shipping'
				
				idc_frete = dec(ls_valor)
				idc_frete = luo_comum.of_decimal( idc_frete )
				
				if isnull(idc_frete) then idc_frete = 0
				
		End Choose
		
	Loop
	
	//vl_total
	ls_valor = ''
	ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'value')
		
	idc_Total = dec(ls_valor)
	idc_Total = luo_comum.of_decimal( idc_Total )
	
	//vl_indexador
	idc_indexador = 0
	
	//cd_boleto_parcelado
	ii_boleto_parcelado = 0
	
	//****************************
	// PAGAMENTO -INICIO
	//****************************
	
	If is_situacao <> 'X'  then
		
		if not this.of_carrega_pagamento( ls_info_pagamento, ref ps_log ) then return false
		
	end if
	//****************************
	// PAGAMENTO - FIM
	//****************************

	//Quando for Arm$$HEX1$$e100$$ENDHEX$$rio Inteligente buscar a vending machine vinculada
	if is_id_tipo_entrega = 'ARM' Then
		if Not this.of_busca_vending_machine( is_cep, ref il_nr_vending_machine, ref ps_log) then return false
	end if
	
	if Not this.of_carrega_promocao( ls_info_promocoes, ref ps_log ) then return false

Finally
	
	destroy(luo_gera_json)
	destroy(luo_comum)
	
End Try

return true
end function

public function boolean of_carrega_dados_cliente (string ps_json, ref string ps_log, long pl_seq_log);string ls_valor

uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 

ls_valor = ''
ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'email')
is_email = ls_valor

ls_valor = ''
ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'gender')
is_sexo = ls_valor

If Not Isnull(is_sexo) and Upper(is_sexo) <> 'MALE' and Upper(is_sexo) <> 'FEMININE' and Upper(is_sexo) <> 'FEMALE'  and Upper(is_sexo) <> 'F' and Upper(is_sexo) <> 'M' Then
	ps_log = 'Sexo do cliente n$$HEX1$$e300$$ENDHEX$$o mapeado: ' + is_sexo
	
	uo_ge501_comum luo_comum_vtex1 
	luo_comum_vtex1 = Create uo_ge501_comum
	luo_comum_vtex1.of_envia_email(211, 'PEDIDO - [' + is_rede_filial + ']', pl_seq_log, 'Pedido: '  + is_pedido_ecommerce + ' - ' +  ps_log, is_pedido_ecommerce)
	Destroy luo_comum_vtex1
	ps_log = ''
	SetNull(is_sexo)
End If

Choose Case Upper(is_sexo)
	Case 'MALE', 'M'
		is_sexo = 'M'
		
	Case 'FEMININE', 'FEMALE', 'F'
		is_sexo = 'F'
	Case ''
		SetNull(is_sexo)
	Case Else
		
		If IsNull(is_sexo) Then
			// Consultar o ultimo pedido com SEXO ou do cadastro de cliente 
			//ps_log = 'Sexo do cliente n$$HEX1$$e300$$ENDHEX$$o informado.'
			
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
			
		Else
			ps_log = 'Sexo do cliente n$$HEX1$$e300$$ENDHEX$$o mapeado: ' + is_sexo
			return false
		End If
		
end Choose

ls_valor = ''
ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'birthDate')
idt_DataNascimento = datetime(date(ls_valor), time('00:00'))

If IsNull(idt_DataNascimento) Then
			
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
	
end if
	
destroy(	luo_gera_json )
	
return true
end function

public function boolean of_carrega_receita (ref string ps_log);string ls_url_padrao
string ls_url_masterdata
string ls_retorno
string ls_log
string ls_json_restante
long ll_existe
boolean lb_receita_nula = false

uo_ge073_json luo_gera_json 

ls_url_padrao = iuo_comum_vtex.is_url 

//Busca informa$$HEX2$$e700f500$$ENDHEX$$es adicionais da receita (Master data)
iuo_comum_vtex.is_url = iuo_comum_vtex.is_url_master_data

ls_url_masterdata = 'api/dataentities/RM/search?_fields=_all&_where=numeroPedido=' + is_id_pedido_site

iuo_comum_vtex.of_get( ls_url_masterdata , ref ls_retorno, ref ps_log )

if ps_log <> '' and not isnull(ps_log) Then return false

iuo_comum_vtex.is_url = ls_url_padrao

luo_gera_json = Create uo_ge073_json 

Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_json_restante,'{') 
	
	ll_existe = 0
	
	is_receita_id = luo_gera_json.of_busca_conteudo_campo_vtex(ls_json_restante, 'id')
	is_receita_nm_arquivo = luo_gera_json.of_busca_conteudo_campo_vtex(ls_json_restante, 'receita')
	
	if is_receita_nm_arquivo = '' or isnull(is_receita_nm_arquivo) or is_receita_id = '' or isnull(is_receita_id) Then
		lb_receita_nula = True
		ls_log = 'Problemas ao carregar a receita. N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel econtrar os dados da receita no masterdata da VTEX.*** O PEDIDO FOI INTEGRADO SEM OS DADOS DA RECEITA ***'
		Exit
	end if
	
	Select count(*)
	into :ll_existe
	from pedido_ecommerce_prd_rec_img
	where cd_filial_ecommerce = :il_ecommerce_alterada
	and nr_pedido = :il_nr_pedido
	and cd_produto = :il_cd_produto
	and id_receita = :is_receita_id;
	
	if SqlCa.sqlcode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_receita ~n' + 'Problemas ao consultar a tabela "pedido_ecommerce_prd_rec_img":~n' + SqlCa.sqlerrtext
			return false
		end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
	
		Insert into pedido_ecommerce_prd_rec_img(cd_filial_ecommerce,
																		nr_pedido,
																		cd_produto,
																		id_receita,
																		nm_arquivo_receita)
			values( :il_ecommerce_alterada,
						:il_nr_pedido,
						:il_cd_produto,
						:is_receita_id,
						:is_receita_nm_arquivo);
		
		if SqlCa.sqlcode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_receita ~n' + 'Problemas ao inserir registro na tabela "pedido_ecommerce_prd_rec_img":~n' + SqlCa.sqlerrtext
			return false
		end if
	end if
	
Loop

if lb_receita_nula = True Then
	iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + is_rede_filial + ']', 0, 'Pedido: '  + is_pedido_ecommerce + ' - ' +  ls_Log, is_pedido_ecommerce )
end if

return true
end function

public function boolean of_executa_upload_receita (ref string ps_log);long ll_for
long ll_linhas
long ll_cd_filial
long ll_cd_produto
long ll_nr_pedido
long ll_length
long ll_erro

blob lb_args, lb_retorno

string ls_retorno
string ls_argumentos
string ls_headers
string ls_id_receita
string ls_nm_arquivo
string ls_nm_cliente
string ls_cpf_cgc
string ls_url_padrao
string ls_url_envio
boolean lb_erro=false

OleObject loo_xmlhttp

dc_uo_ds_base lds_dados

Try

	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("WinHTTP.WinHTTPRequest.5.1")
	
	lds_dados = create dc_uo_ds_base
	lds_dados.of_changedataobject( 'ds_ge501_pedido_ecommerce_rec')
	
	// DESENVOLVIMENTO 
	//'https://wssync.clamed.com.br:8091/sync.php?'

	//PRODUCAO
	//'https://wssync.clamed.com.br:8090/sync.php?'
	
	ls_url_padrao = 'https://wssync.clamed.com.br:8090/sync.php?'
	
	//https://wssync.clamed.com.br:8091/sync.php?hash=42dd24a1-3955-11eb-82ac-0a7d25835bcd&nmArquivo=Receita%20QRcode2%20(1).pdf&nrCpfCnpj=075.086.739-64&nmCliente=Rodrigo%20widmann&idRede=PP

	ll_linhas = lds_dados.retrieve()
	
	for ll_for = 1 to ll_linhas
		
		ll_cd_filial = lds_dados.object.cd_filial_ecommerce[ll_for]
		ll_nr_pedido = lds_dados.object.nr_pedido[ll_for]
		ll_cd_produto = lds_dados.object.cd_produto[ll_for]
		ls_id_receita = lds_dados.object.id_receita[ll_for]
		ls_nm_arquivo = lds_dados.object.nm_arquivo_receita[ll_for]
		ls_nm_cliente = lds_dados.object.nm_cliente[ll_for]
		ls_cpf_cgc = lds_dados.object.nr_cpf_cgc[ll_for]
		
		if isnull(ls_nm_arquivo) Then
			ls_nm_arquivo = ''
		else
			ls_nm_arquivo = gf_replace(ls_nm_arquivo, ' ' , '%20', 0)
		end if
		
		if isnull(ls_nm_cliente) Then
			ls_nm_cliente = ''
		else
			ls_nm_cliente = gf_replace(ls_nm_cliente, ' ' , '%20', 0)
		end if
		
		ls_argumentos = 'hash=' + ls_id_receita + '&nmArquivo=' + ls_nm_arquivo + '&nrCpfCnpj=' + ls_cpf_cgc + '&nmCliente=' + ls_nm_cliente + '&idRede=' + is_rede_filial + '&nrPedido=' + string(ll_nr_pedido)
		
		//ls_url_envio = ls_url_padrao + 'hash=' + ls_id_receita + '&nmArquivo=' + ls_nm_arquivo + '&nrCpfCnpj=' + ls_cpf_cgc + '&nmCliente=' + ls_nm_cliente
		
		loo_xmlhttp.open ("GET",ls_url_padrao + ls_argumentos, false)
		loo_xmlhttp.send()
		
		ls_retorno = upper(loo_xmlhttp.ResponseText)
		
		if isnull(ls_retorno) Then ls_retorno = ''
		
		If ls_retorno <> '"PDF CADASTRADO COM SUCESSO"'  Then
			ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_executa_upload_receita ~n' + ' - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel fazer o upload da receita.' 
			return false
		end if

		Update pedido_ecommerce_prd_rec_img
		set dh_receita_integrada = getdate()
		where cd_filial_ecommerce = :ll_cd_filial
			and nr_pedido = :ll_nr_pedido
			and cd_produto = :ll_cd_produto
			and id_receita = :ls_id_receita;
		
		If SqlCa.SqlCode = -1 Then
			ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_executa_upload_receita ~n' + 'Erro ao atualizar registro na tabela "pedido_ecommerce_prd_rec_img": ~n' + SqlCa.sqlerrtext 
			return false
		end if
		
	next

Finally 
	
	loo_xmlhttp.DisconnectObject()
	
	Destroy(loo_xmlhttp)
	Destroy(lds_dados)
End Try

return true
end function

public function boolean of_valida_endereco (ref string ps_mensagem_email, ref string ps_log);Boolean lb_Retorno = False
boolean lb_valido

Long ll_Sucesso

String ls_Mensagem
String ls_Mensagem_Aux
String ls_UF_Clamed
String ls_Cep_ECT

Try
	
	if gvo_Aplicacao.ivs_DataSource <> 'central' Then 
		ib_endereco_valido = True
		return true
	end if
	
	ls_Mensagem = ''
	
	If Not gf_Valida_Informacoes_Cliente( is_bairro_ent, 3, ref ls_Mensagem_Aux ) Then
		ls_Mensagem += "Bairro inv$$HEX1$$e100$$ENDHEX$$lido [" + is_bairro_ent + "]"
	End If
	
//	if len(is_bairro_ent) > 20 Then
//		ls_Mensagem += "O Bairro informado deve possuir no m$$HEX1$$e100$$ENDHEX$$ximo 20 caracteres: [" + is_bairro_ent + "]"
//	End if
	
	If LenA( is_cep_ent ) <> 8 Then
		ls_Mensagem += "CEP inv$$HEX1$$e100$$ENDHEX$$lido [" + is_cep_ent + "]"
	End If
	
	If LenA( is_uf_ent ) <> 2 Then
		ls_Mensagem += "UF inv$$HEX1$$e100$$ENDHEX$$lida [" + is_uf_ent + "]"
	End If
	
	if isnull(is_numero_ent) or is_numero_ent = '' or (Not isnumber(is_numero_ent) and upper(is_numero_ent) <> 'SN' and upper(is_numero_ent) <> 'S/N') Then
		if isnull(is_numero_ent) Then is_numero_ent = ''
		ls_Mensagem += "N$$HEX1$$fa00$$ENDHEX$$mero inv$$HEX1$$e100$$ENDHEX$$lido [" + is_numero_ent + "]"
	end if
	
	if ls_Mensagem <> '' then
		return false
	end if
	
	SELECT DISTINCT cd_uf
	INTO :ls_UF_Clamed
	FROM vw_endereco
	WHERE nr_cep = :is_cep_ent
	USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_endereco; Problemas ao consultar a tabela "vw_endereco": ' + sqlca.sqlerrtext
			return false	
			
		Case 0
			If ls_Uf_Clamed <> is_uf_ent Then
				if isnull(ls_Uf_Clamed) Then ls_Uf_Clamed = ''
				ls_Mensagem += "A UF [" + is_uf_ent + "] informada n$$HEX1$$e300$$ENDHEX$$o condiz com a UF [" + ls_Uf_Clamed + "] relacionada ao CEP [" + is_cep_ent + "]." 
				Return False
			End If
			
		Case 100
			SELECT DISTINCT cd_uf
			INTO :ls_UF_Clamed
			FROM ect_localidade
			WHERE nr_cep = :is_cep_ent
			USING SqlCa;
					
			Choose Case SqlCa.SqlCode
				Case -1
					ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_endereco; Problemas ao consultar a tabela "ect_localidade": ' + sqlca.sqlerrtext
					return false	
					
				Case 0
					If ls_Uf_Clamed <> is_uf_ent Then
						if isnull(ls_Uf_Clamed) Then ls_Uf_Clamed = ''
						ls_Mensagem += "A UF [" + is_uf_ent + "] informada n$$HEX1$$e300$$ENDHEX$$o condiz com a UF [" + ls_Uf_Clamed + "] relacionada ao CEP [" + is_cep_ent + "]." 
						Return false
					End If
					
				Case 100

					uo_ge501_correios luo_correios
					
					luo_correios = create uo_ge501_correios
					
					if Not luo_correios.of_consulta_cep( is_cep_ent, ref lb_valido, ref ps_log) then return false

					if lb_valido = false Then
						ls_Mensagem += "Consulta CEP [" + is_cep_ent + "] : " + ps_log 
						ps_log = ''
						return false
					end if
					
			End Choose
			
	End Choose
	
	Return True
	
Catch( RuntimeError ru )
	ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_endereco; Problemas ao validar endere$$HEX1$$e700$$ENDHEX$$o: ' + ru.getMessage( )
	Return False
	
Finally
	
	if ls_mensagem <> '' and not isnull(ls_mensagem) Then
		ib_endereco_valido = false
		ps_mensagem_email = "Valida$$HEX2$$e700e300$$ENDHEX$$o de endere$$HEX1$$e700$$ENDHEX$$o: " + ls_mensagem
	else
		ib_endereco_valido = True
	end if
	
End Try
end function

public function boolean of_verifica_codigo_produto (string ps_refid, ref string ps_log);String ls_Manipulado

// PROCURA PELO C$$HEX1$$d300$$ENDHEX$$DIGO ECOMMERCE
Select cd_produto, coalesce(id_manipulado, 'N')
into :il_cd_Produto, :ls_Manipulado
from ecommerce_prd
where id_ecommerce 			= :is_id_ecommerce
    and id_rede_filial 				= :is_rede_filial
    and cd_produto_ecommerce	= :is_cd_Produto_Ecommerce
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Manipulado = 'S' Then 	
			il_cd_Produto = il_produto_manipulado
			// Neste caso o nome j$$HEX1$$e100$$ENDHEX$$ esta formatado confome exemplo, (OR253601) NOME DO CLIENTE
			is_tipo_manipulado = ''
		End If
		
	Case 100
		
		If Pos(ps_refid, 'FC')  > 0 Then
			// FC6502 refID(para os produtos normais seria o c$$HEX1$$f300$$ENDHEX$$digo do sybase), o objetivo $$HEX1$$e900$$ENDHEX$$ descer junto com o nome do produto o , exemplo, (FC6502) Spray de Gymena 10% Aroma Baunilha
			is_tipo_manipulado = '(' + ps_refid + ') '
			il_cd_Produto = il_produto_manipulado
		Else
			// Neste caso o nome j$$HEX1$$e100$$ENDHEX$$ esta formatado confome exemplo, (OR253601) NOME DO CLIENTE
			is_tipo_manipulado = ''
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_codigo_produto ~n' + 'Produto eCommerce n$$HEX1$$e300$$ENDHEX$$o localizado ' + is_cd_Produto_Ecommerce
			return false
		End If
		
	Case -1
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_codigo_produto ~n' + 'Problemas ao consultar a tabela "ecommerce_prd": ~n'  + sqlca.sqlerrtext
		return false
End Choose
	
return true

end function

public function boolean of_valida_pedido (ref string ps_log, string ps_rede);Decimal ldc_Tot_Prd_Calc
Decimal ldc_Tot_Desc, ldc_diferenca
Decimal ldc_vl_preco, ldc_vl_preco_promocao, ldc_vl_desconto, ldc_pc_desconto

string ls_produto, ls_nm_produto

Long ll_Produto_Pedido
Long ll_qt_pedida
Long ll_Achou
Long ll_sequencial, ll_sequencial_novo

Select coalesce(sum(round(qt_pedida * vl_preco_promocao, 2)), 0) 
Into :ldc_Tot_Prd_Calc
From pedido_ecommerce_produto
where cd_filial_ecommerce = :il_ecommerce_alterada
  and nr_pedido = :il_nr_pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
End If

If ((idc_subtotal + idc_embalagem + idc_frete) - idc_desconto - idc_valecompra) <> idc_Total Then
	ps_log = is_objeto + 'O total do pedido calculado est$$HEX1$$e100$$ENDHEX$$ diferente do informado no pedido.'
	return false
End If

if isnull(this.idc_vl_forma_pagamento_2) then this.idc_vl_forma_pagamento_2 = 0

if idc_Total <> (this.idc_vl_forma_pagamento + this.idc_vl_forma_pagamento_2) then
	ps_log = is_objeto + 'O total do pagamento calculado est$$HEX1$$e100$$ENDHEX$$ diferente do valor total do pedido.'
	return false
End if

ldc_diferenca = idc_subtotal - ldc_Tot_Prd_Calc

if ldc_diferenca <> 0 and ldc_diferenca < 0.5 and ldc_diferenca > -0.5 Then
	
	select top 1 cd_produto_ecommerce, nr_sequencial, qt_pedida, vl_preco, vl_preco_promocao, vl_desconto, pc_desconto, nm_produto
	into :ls_produto, :ll_sequencial, :ll_qt_pedida, :ldc_vl_preco, :ldc_vl_preco_promocao, :ldc_vl_desconto, :ldc_pc_desconto, :ls_nm_produto
	from pedido_ecommerce_produto
	where cd_filial_ecommerce = :il_ecommerce_alterada
	  and nr_pedido = :il_nr_pedido
	  and vl_preco_promocao > 0.1
	  order by qt_pedida
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
		return false
	End If
	
	if ll_sequencial = 0 or isnull(ll_sequencial) then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar um produto para aplicar a diferen$$HEX1$$e700$$ENDHEX$$a de pre$$HEX1$$e700$$ENDHEX$$o.'
		return false
	End If
	
	if ldc_diferenca > 0 Then
		
		ldc_vl_desconto = ldc_vl_desconto - ldc_diferenca
		if ll_qt_pedida = 1 Then
			idc_Desconto_Validacao = idc_Desconto_Validacao - ldc_diferenca
		else
			idc_Desconto_Validacao = idc_Desconto_Validacao + ldc_vl_desconto
		End if
				
		ldc_vl_preco_promocao = ldc_vl_preco_promocao + ldc_diferenca
	
	ELse
		
		ldc_diferenca = ldc_diferenca * -1
		
		ldc_vl_desconto = ldc_vl_desconto + ldc_diferenca
		if ll_qt_pedida = 1 Then
			idc_Desconto_Validacao = idc_Desconto_Validacao + ldc_diferenca
		Else
			idc_Desconto_Validacao = idc_Desconto_Validacao + ldc_vl_desconto
		End if
		
		ldc_vl_preco_promocao = ldc_vl_preco_promocao - ldc_diferenca
				
	ENd if
	
	ldc_pc_desconto = round((1 - (ldc_vl_preco_promocao/ldc_vl_preco)) * 100, 4)

	if ll_qt_pedida = 1 Then
		
			update pedido_ecommerce_produto
			set vl_preco_promocao = :ldc_vl_preco_promocao , vl_desconto = :ldc_vl_desconto, pc_desconto = :ldc_pc_desconto
			where cd_filial_ecommerce = :il_ecommerce_alterada
			  and nr_pedido = :il_nr_pedido
			  and cd_produto_ecommerce = :ls_produto
			  and nr_sequencial = :ll_sequencial;
	
		If SqlCa.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao atualizar registro da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
			return false
		End If
		
	Else

		select max(nr_sequencial)
		into :ll_sequencial_novo
		from pedido_ecommerce_produto
		where cd_filial_ecommerce = :il_ecommerce_alterada
			  and nr_pedido = :il_nr_pedido;

		If SqlCa.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar registro da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
			return false
		End If
		
		if isnull(ll_sequencial_novo) Then ll_sequencial_novo = 0
		
		ll_sequencial_novo++
		
		INSERT INTO pedido_ecommerce_produto  
		 (  cd_filial_ecommerce,
			nr_pedido,   
			cd_produto_ecommerce,
			nm_produto,
			nr_sequencial,
			qt_pedida,   
			cd_produto,   
			vl_preco,   			 		
			vl_preco_promocao,
			nr_requisicao_manip,
			vl_desconto,
			pc_desconto,
			id_campanha_exclusiva_pbm,
			nr_campanha_pbm,
			cd_pbm,
			id_usa_desconto_pbm,
			cd_conveniado_pbm,
			nr_autorizacao_pbm,
			cd_produto_regra_pbm,
			vl_preco_maximo_pbm,
			vl_reposicao_pbm)
			Select  cd_filial_ecommerce,
			nr_pedido,   
			cd_produto_ecommerce, 
			:ls_nm_produto,
			:ll_sequencial_novo,
			1,   
			cd_produto,   
			vl_preco,   			 		
			:ldc_vl_preco_promocao,
			nr_requisicao_manip,
			:ldc_vl_desconto,
			:ldc_pc_desconto,
			id_campanha_exclusiva_pbm,
			nr_campanha_pbm,
			cd_pbm,
			id_usa_desconto_pbm,
			cd_conveniado_pbm,
			nr_autorizacao_pbm,
			cd_produto_regra_pbm,
			vl_preco_maximo_pbm,
			vl_reposicao_pbm
			from pedido_ecommerce_produto
		Where  cd_filial_ecommerce = :il_ecommerce_alterada
		  and nr_pedido = :il_nr_pedido
		  and nr_sequencial = :ll_sequencial ;
	
		If SqlCa.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao inserir registro da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
			return false
		End If
		
		update pedido_ecommerce_produto
			set qt_pedida = qt_pedida - 1
			where cd_filial_ecommerce = :il_ecommerce_alterada
			  and nr_pedido = :il_nr_pedido
			  and cd_produto_ecommerce = :ls_produto
			  and nr_sequencial = :ll_sequencial;
	
		If SqlCa.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao atualizar registro da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
			return false
		End If
		
	End if
	
	Select coalesce(sum(round(qt_pedida * vl_preco_promocao, 2)), 0) 
	Into :ldc_Tot_Prd_Calc
	From pedido_ecommerce_produto
	where cd_filial_ecommerce = :il_ecommerce_alterada
	  and nr_pedido = :il_nr_pedido
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
		return false
	End If
	
	ldc_diferenca = idc_subtotal - ldc_Tot_Prd_Calc
	
ENd if

if ldc_diferenca < 0 then ldc_diferenca = ldc_diferenca * -1

If ldc_diferenca > 0 Then
	ps_log = is_objeto + 'O total de produtos calculado est$$HEX1$$e100$$ENDHEX$$ diferente do SUBTOTAL informado no pedido.'
	return false
End If

// valida desconto
Select sum(coalesce(vl_desconto, 0))
Into :ldc_Tot_Desc
From pedido_ecommerce_produto
where cd_filial_ecommerce = :il_ecommerce_alterada
  and nr_pedido = :il_nr_pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores da tabela - desc "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
End If

If idc_Desconto_Validacao <> ldc_Tot_Desc Then
	ps_log = is_objeto + 'A soma dos descontos dos produtos esta diferente do informado no pedido.'
	return false
End If
// valida desconto

select top 1 p.cd_produto 
Into :ll_Produto_Pedido
from pedido_ecommerce_produto p
where p.cd_filial_ecommerce 	= :il_ecommerce_alterada
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

If ll_Produto_Pedido <> il_produto_manipulado Then
	If Not IsNull(ll_Produto_Pedido) and ll_Produto_Pedido > 0 Then
		ps_log = is_objeto +  'O produto ' + String(ll_Produto_Pedido) + ' inserido no pedido n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela "ecommerce_prd".'
		Return False
	End If
End if

select top 1 p.cd_produto 
Into :ll_Produto_Pedido
from pedido_ecommerce_produto p
inner join ecommerce_prd pr
	on  pr.id_ecommerce = :is_id_ecommerce
	and pr.id_rede_filial = :ps_rede
	and pr.cd_produto = p.cd_produto
where p.cd_filial_ecommerce = :il_ecommerce_alterada
  and p.nr_pedido = :il_nr_pedido
  and p.cd_produto_ecommerce <> p.cd_produto_ecommerce
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores para validar os produtos (2) da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
End If

If ll_Produto_Pedido <> il_produto_manipulado Then
	If Not IsNull(ll_Produto_Pedido) and ll_Produto_Pedido > 0 Then
		ps_log = is_objeto +  'O produto ' + String(ll_Produto_Pedido) + ' inserido no pedido est$$HEX1$$e100$$ENDHEX$$ com o c$$HEX1$$f300$$ENDHEX$$digo do produto no ecommerce diferente "ecommerce_prd".'
		Return False
	End If
End If

ll_Achou = 0

select count(*)
Into :ll_Achou
from pedido_ecommerce_produto p
where p.cd_filial_ecommerce = :il_ecommerce_alterada
  and p.nr_pedido = :il_nr_pedido
  and p.vl_preco_promocao = 0.01
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar a tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
End If	

If ll_Achou > 0 Then
	ps_log = 'Valor do produto inv$$HEX1$$e100$$ENDHEX$$lido: 0,01.'
	Return False
End If

// Se contiver produto manipulado e exigir nota de servi$$HEX1$$e700$$ENDHEX$$o, em um mesmo pedido n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ haver produto manipulado e de dispensa$$HEX2$$e700e300$$ENDHEX$$o.
If ib_existe_produto_manipulado and is_Exige_NFSE= 'S' Then
	
	select count(*)
	Into :ll_Achou
	from pedido_ecommerce_produto p
	where p.cd_filial_ecommerce = :il_ecommerce_alterada
	  and p.nr_pedido = :il_nr_pedido
	  and p.cd_produto <> :il_produto_manipulado
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar produtos de dispensa$$HEX2$$e700e300$$ENDHEX$$o "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
		return false
	End If	
	
	If ll_Achou > 0 Then
		ps_log = 'Pedido com MANIPULADO n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ conter produto de DISPENSA$$HEX2$$c700c300$$ENDHEX$$O (caso exiga nota de servi$$HEX1$$e700$$ENDHEX$$o), regra financeira.'
		Return False
	End If
	
End If

Return True
end function

public function boolean of_filial_ecommerce (string ps_log);String ls_Rede

// Tratar manipulado
ls_Rede = is_rede_filial

Select cd_filial_ecommerce
Into :il_ecommerce_alterada
From ecommerce_hub_rede
where id_ecommerce = '2'
  and cd_filial_hub = :il_filial_hub
  and id_rede_filial = :is_rede_filial
  Using SqlCa;
  
  Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		// Neste caso a cd_filial_ecommerce fica o que retorno do par$$HEX1$$e200$$ENDHEX$$metro
		il_ecommerce_alterada = il_cd_filial
	Case -1
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_filial_ecommerce ~n' + 'Problemas ao consultar a tabela "ecommerce_hub_rede": ~n'  + sqlca.sqlerrtext
		return false
End Choose


return true
end function

public function boolean of_busca_endereco_filial (ref string ps_cd_uf, ref string ps_bairro, ref string ps_log);string ls_cd_uf, ls_bairro

select c.cd_unidade_federacao, f.de_bairro
into :ls_cd_uf, :ls_bairro
from filial f
	inner join cidade c on (c.cd_cidade = f.cd_cidade)
where cd_filial = :il_Filial_Hub
Using SQLCA;

if sqlca.sqlcode = -1 then 
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_endereco_filial ; Problemas ao consultar a tabela "filial": ' + sqlca.sqlerrtext
	return false
end if

ps_cd_uf = ls_cd_uf
ps_bairro = ls_bairro

return true
end function

public function boolean of_busca_filial (string ps_id_filial, ref string ps_log, string ps_name_seller);long ll_cd_filial_hub
string ls_situacao

if is_id_tipo_pedido = 'MGZ' Then
	if pos( ps_id_filial, 'magalu', 1) > 0 Then
		ps_id_filial = gf_replace( ps_id_filial, 'magalu', '',0 )
	End if
End if
	
if isnull(ps_id_filial) then ps_id_filial = 'NULO'	

if is_rede_filial <> 'FA' Then
	
	select coalesce(cd_filial_hub, cd_filial), cd_filial, cd_filial_hub, id_situacao
	into :il_filial_hub, :il_filial_seller, :ll_cd_filial_hub, :ls_situacao
	from ecommerce_rede_filial
	where id_ecommerce = :is_id_ecommerce
	   and cd_url_integracao like '%' + :ps_id_filial + '.%'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial [1] ~n' + 'Filial n$$HEX1$$e300$$ENDHEX$$o localizada [' + ps_id_filial + '].'
			return false
		Case -1
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial [1] ~n' + 'Problemas ao consultar a tabela "ecommerce_rede_filial" [' + ps_id_filial + ']: ~n'  + sqlca.sqlerrtext
			return false
	End Choose
	
Else
	
	If ps_id_filial = '1' and ps_name_seller = 'FARMAGORA.' Then
		
		Select coalesce(cd_filial_hub, cd_filial), cd_filial, cd_filial_hub, id_situacao
		into :il_filial_hub, :il_filial_seller, :ll_cd_filial_hub, :ls_situacao
		from ecommerce_rede_filial
		where id_ecommerce = :is_id_ecommerce
			and cd_url_integracao = 'https://farmagora.myvtex.com/'
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
			Case 100
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial [2] ~n' + 'Filial n$$HEX1$$e300$$ENDHEX$$o localizada.'
				return false
			Case -1
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial [1] ~n' + 'Problemas ao consultar a tabela "ecommerce_rede_filial": ~n'  + sqlca.sqlerrtext
				return false
		End Choose
		
	Else
		
		Select coalesce(cd_filial_hub, cd_filial), cd_filial, cd_filial_hub, id_situacao
		into :il_filial_hub, :il_filial_seller, :ll_cd_filial_hub, :ls_situacao
		from ecommerce_rede_filial
		where id_ecommerce = :is_id_ecommerce
			and cd_url_integracao like '%' + :ps_id_filial + '.%'
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
			Case 100
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial [3] ~n' + 'Filial n$$HEX1$$e300$$ENDHEX$$o localizada.'
				return false
			Case -1
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial [1] ~n' + 'Problemas ao consultar a tabela "ecommerce_rede_filial": ~n'  + sqlca.sqlerrtext
				return false
		End Choose
		
	End If	
	
End If

if ll_cd_filial_hub > 0 and not isnull(ll_cd_filial_hub) Then
	ib_filial_hub = true
else
	ib_filial_hub = false
end if

if ls_situacao = 'I' Then
	ps_log = 'A filial ' + string (il_filial_seller) + ' est$$HEX1$$e100$$ENDHEX$$ inativa para a integra$$HEX2$$e700e300$$ENDHEX$$o com a VTEX.'
	return false
ENd if

//nm_regiao_entrega
is_regiao = String(il_filial_hub)

If Not IsNull(il_Filial_Desenv) Then 	il_filial_hub = il_Filial_Desenv

// Verifica a filial ecommerce conforme a filial HUB
If Not This.of_filial_ecommerce(ref ps_log) Then Return False

return true

end function

public function boolean of_busca_vending_machine (string ps_cep, ref long pl_nr_vm, ref string ps_log);long ll_nr_vm

select nr_vending_machine
into :ll_nr_vm
from vending_machine
where nr_cep = :ps_cep
and id_situacao = 'A';

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_vending_machine; Problemas ao consultar a tabela "vending_machine": ' + sqlca.sqlerrtext
	return false
end if

if ll_nr_vm = 0 then setnull(ll_nr_vm)

//if isnull(ll_nr_vm)  then
//	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar uma vending machine vinculada ao CEP [' + ps_cep + '].'
//	return false
//end if

pl_nr_vm = ll_nr_vm

return true
end function

public function boolean of_valida_status_pedido (string ps_json);string ls_status
uo_ge073_json luo_gera_json

Try

	luo_gera_json = Create uo_ge073_json 
	
	ls_status = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'status')
	
	if ls_status = 'handling' Then
		return True
	else
		return False
	end if

Finally
	Destroy(luo_gera_json)
End Try
end function

public function boolean of_busca_nsu_esitef (string ps_tipo, string ps_id_transacao, ref string ps_nsu_host, ref string ps_id_autorizacao, ref datetime pdh_autorizacao, ref string ps_log);string ls_url
string ls_usuario
string ls_chave
string ls_info_pag
string ls_retorno
string ls_host_usn
string ls_autorizacao
string ls_data_autorizacao
datetime ldt_data

uo_ge501_comum luo_comum_vtex
uo_ge073_json luo_gera_json

//Fun$$HEX2$$e700e300$$ENDHEX$$o criada para buscar o NSU_HOST quando o conector for ESITEF:

try 
	
	If isnull(is_url_conector) or is_url_conector = '' Then
		ps_log = 'A URL de integra$$HEX2$$e700e300$$ENDHEX$$o com a E-SITEF n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurada.'
		return false
	end if

	If isnull(is_chave_conector) or is_chave_conector = '' Then
		ps_log = 'A Chave de integra$$HEX2$$e700e300$$ENDHEX$$o com a E-SITEF n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurada.'
		return false
	end if

	If isnull(is_token_conector) or is_token_conector = '' Then
		ps_log = 'O Token de integra$$HEX2$$e700e300$$ENDHEX$$o com a E-SITEF n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurado.'
		return false
	end if	
	
	if ps_id_transacao = '' or isnull(ps_id_transacao) Then
		ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_nsu_esitef - C$$HEX1$$f300$$ENDHEX$$digo da transa$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido ou n$$HEX1$$e300$$ENDHEX$$o informado.'
		return false
	end if
	
	luo_comum_vtex = create uo_ge501_comum
	luo_gera_json = Create uo_ge073_json 
	
	luo_comum_vtex.is_tipo_comunicacao = 'ESITEF'
//	luo_comum_vtex.is_url = 'https://esitef-ec.softwareexpress.com.br/e-sitef/'
//	luo_comum_vtex.is_chave_conector = 'EACB4E536EB509C2B33106403ACC629542051EB6CDA20B22DC3E0B1C5C077C29'
//	luo_comum_vtex.is_token_conector = '84683481003869A'
	
	luo_comum_vtex.is_url = is_url_conector
	luo_comum_vtex.is_chave_conector = is_chave_conector
	luo_comum_vtex.is_token_conector = is_token_conector
	
	luo_comum_vtex.of_get( 'api/v1/transactions/' + ps_id_transacao, ref ls_retorno, ref ps_log )
	
	If ps_log <> '' and not isnull(ps_log) Then 
		 ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_nsu_esitef - ' + ps_log
		Return False
	end if
	
	If ps_tipo = 'C' Then
		//Captura
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_retorno, 'capture', ref ls_info_pag, '}')
		
		ls_host_usn = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pag, 'host_usn')
		ls_host_usn = trim(ls_host_usn)
		
		ls_data_autorizacao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pag, 'authorizer_date')

		ldt_data =  Datetime( date(ls_data_autorizacao), time( mid( ls_data_autorizacao, 12, 5) ) )

		//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
		of_ajusta_horario(ref ldt_data)

	Elseif ps_tipo = 'PIX' Then
		
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_retorno, 'payment', ref ls_info_pag, '}')
		
		ls_host_usn = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pag, 'host_usn')
		ls_host_usn = trim(ls_host_usn)
		
		is_nr_psp_recebedor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pag, 'pix_psp')
		is_nr_psp_recebedor = trim(is_nr_psp_recebedor)
		
		ls_autorizacao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pag, 'authorization_number')
		ls_autorizacao = trim(ls_autorizacao)
		
		ls_data_autorizacao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pag, 'authorizer_date')

		ldt_data =  Datetime( date(ls_data_autorizacao), time( mid( ls_data_autorizacao, 12, 5) ) )
		//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
		of_ajusta_horario(ref ldt_data)
		
	Else
		//Pr$$HEX1$$e900$$ENDHEX$$-captura
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_retorno, 'pre_authorization', ref ls_info_pag, '}')
		
		ls_host_usn = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pag, 'host_usn')
		ls_host_usn = trim(ls_host_usn)
		
		ls_autorizacao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pag, 'authorization_number')
		ls_autorizacao = trim(ls_autorizacao)
	End if
	
	ps_nsu_host = ls_host_usn
	ps_id_autorizacao = ls_autorizacao
	pdh_autorizacao = ldt_data
	
Finally
	Destroy(luo_comum_vtex)
	Destroy(luo_gera_json)
End Try

return true
end function

public function boolean of_processa_atualizacao_pedido (string ps_rede_filial);return this.of_processa_atualizacao_pedido( ps_rede_filial, '', 0)
end function

public function boolean of_carrega_pagamento_gototem (string ps_json, ref string ps_log);long ll_inicio, ll_fim
string ls_tag
string ls_nsu, ls_autorizacao, ls_tipo_cartao, ls_cartao, ls_data
string ls_nr_cartao_ini, ls_nr_cartao_fim, ls_parcelas, ls_adquirente
double ll_teste

//openTextField

//Autextref = NSU Host
//ReqNum => CodigoAutorizacao
//cardtype = 1 credito, 2 debito

ls_tag = '"autextref\":\"'
ll_inicio = pos(ps_json, ls_tag,1)

if ll_inicio > 0 Then
	
	ll_inicio = ll_inicio + len(ls_tag)
	
	ll_fim = pos(ps_json, '\', ll_inicio)
	ls_nsu = Trim( Mid( ps_json, ll_inicio, ll_fim - ll_inicio) )
	
end if

ls_tag = '"cardName\":\"'
ll_inicio = pos(ps_json, ls_tag,1)

if ll_inicio > 0 Then
	
	ll_inicio = ll_inicio + len(ls_tag)
	
	ll_fim = pos(ps_json, '\', ll_inicio)
	ls_cartao = Trim( Mid( ps_json, ll_inicio, ll_fim - ll_inicio) )

end if

ls_tag = '"cardType\":\"'
ll_inicio = pos(ps_json, ls_tag,1)

if ll_inicio > 0 Then
	
	ll_inicio = ll_inicio + len(ls_tag)
	
	ll_fim = pos(ps_json, '\', ll_inicio)
	ls_tipo_cartao = Trim( Mid( ps_json, ll_inicio, ll_fim - ll_inicio) )

end if

ls_tag = '"dateTime\":\"'
ll_inicio = pos(ps_json, ls_tag,1)

if ll_inicio > 0 Then
	
	ll_inicio = ll_inicio + len(ls_tag)
	
	ll_fim = pos(ps_json, '\', ll_inicio)
	ls_data = Trim( Mid( ps_json, ll_inicio, ll_fim - ll_inicio) )

end if

ls_tag = '"firstDigits\":\"'
ll_inicio = pos(ps_json, ls_tag,1)

if ll_inicio > 0 Then
	
	ll_inicio = ll_inicio + len(ls_tag)
	
	ll_fim = pos(ps_json, '\', ll_inicio)
	ls_nr_cartao_ini = Trim( Mid( ps_json, ll_inicio, ll_fim - ll_inicio) )

end if

ls_tag = '"lastDigits\":\"'
ll_inicio = pos(ps_json, ls_tag,1)

if ll_inicio > 0 Then
	
	ll_inicio = ll_inicio + len(ls_tag)
	
	ll_fim = pos(ps_json, '\', ll_inicio)
	ls_nr_cartao_fim = Trim( Mid( ps_json, ll_inicio, ll_fim - ll_inicio) )

end if

ls_tag = '"installments\":\"'
ll_inicio = pos(ps_json, ls_tag,1)

if ll_inicio > 0 Then
	
	ll_inicio = ll_inicio + len(ls_tag)
	
	ll_fim = pos(ps_json, '\', ll_inicio)
	ls_parcelas = Trim( Mid( ps_json, ll_inicio, ll_fim - ll_inicio) )

end if

ls_tag = '"reqNum\":\"'
ll_inicio = pos(ps_json, ls_tag,1)

if ll_inicio > 0 Then
	
	ll_inicio = ll_inicio + len(ls_tag)
	
	ll_fim = pos(ps_json, '\', ll_inicio)
	ls_autorizacao = Trim( Mid( ps_json, ll_inicio, ll_fim - ll_inicio) )

end if

ls_tag = '"viaClient\":\"'
ll_inicio = pos(ps_json, ls_tag,1)

if ll_inicio > 0 Then
	
	ll_inicio = ll_inicio + len(ls_tag)
	
	ll_fim = pos(ps_json, '\', ll_inicio)
	ls_adquirente = Trim( Mid( ps_json, ll_inicio, ll_fim - ll_inicio) )

end if

if ls_adquirente = 'PAGSEGURO' Then
	ls_autorizacao = gf_Tira_Zero_Esquerda(ls_autorizacao)
	ls_nsu = gf_Tira_Zero_Esquerda(ls_nsu)
end if

if left(ls_autorizacao,3) = '000' then ls_autorizacao = mid(ls_autorizacao,4)

if left(ls_nsu,3) = '000' then ls_nsu = mid(ls_nsu,4)

ls_nsu = ls_nsu + ' *'

is_tipo_pagamento_site = Upper(ls_cartao)
is_autorizacao_cartao = ls_autorizacao
is_comprovante_cartao = ls_nsu
is_nsu_host = ls_nsu
ii_parcelas = long(ls_parcelas)
is_cartao_credito = ls_nr_cartao_ini + 'XXXXXX' + ls_nr_cartao_fim
is_de_adquirente = ls_adquirente

is_de_adquirente = Upper(is_de_adquirente)

if is_de_adquirente = 'REDE' Then
	is_de_adquirente = 'REDECARD'
	
elseif is_de_adquirente = 'CIELO' Then
	is_de_adquirente = upper('Cielo e-Commerce')
	
elseif is_de_adquirente = 'PAGBANK' Then	
	is_de_adquirente = 'PAGSEGURO'
end if

if ls_tipo_cartao = '1' then
	is_forma_pagto = 'CP'
else
	is_forma_pagto = 'CA'
end if
		
return true
end function

public function boolean of_grava_pagamento (long pl_cd_filial, long pl_nr_pedido, ref string ps_log);String ls_Exige_NFSE
String ls_Rede

if is_de_adquirente = 'PICPAY' then
	
	is_autorizacao_cartao = String(il_nr_pedido)
	is_comprovante_cartao = String(il_nr_pedido)
	is_nsu_host = String(il_nr_pedido)
	
End if

if is_de_adquirente_2 = 'PICPAY' then
	
	is_autorizacao_cartao_2 = String(il_nr_pedido)
	is_comprovante_cartao_2 = String(il_nr_pedido)
	is_nsu_host_2 = String(il_nr_pedido)
	
End if

If pl_cd_filial > 0 and pl_nr_pedido > 0 Then
	//Atualiza$$HEX2$$e700e300$$ENDHEX$$o/Update
	
	Update pedido_ecommerce_auxiliar
				set nr_comprovante_cartao_credito = :is_comprovante_cartao,  
					nr_autorizacao_cartao_credito = :is_autorizacao_cartao, 
					nm_administradora_cartao = :is_Bandeira_Cartao, 
					cd_estabelecimento_cartao = :is_Estabelecimento,
					nr_nsu_host = :is_nsu_host, 
					dh_confirmacao_faturamento = :idt_aut_pagamento,
					nr_psp_recebedor = :is_nr_psp_recebedor,
					cd_autorizacao_cd = :is_nr_autorizacao_pix,
					id_tipo_uso_cd = :is_id_tipo_uso_cd,
					vl_forma_pagamento = :idc_vl_forma_pagamento,
					vl_forma_pagamento_2 = :idc_vl_forma_pagamento_2,
					nr_parcelas_2 = :ii_parcelas_2,
					nr_comp_cartao_credito_2 = :is_comprovante_cartao_2,
					nr_autoriz_cartao_credito_2 = :is_autorizacao_cartao_2,
					nm_administradora_cartao_2 = :is_Bandeira_Cartao_2,
					cd_estabelecimento_cartao_2 = :is_Estabelecimento_2,
					nr_cartao_credito_2 = :is_cartao_credito_2,
					nr_nsu_host_2 = :is_nsu_host_2,
					cd_forma_pagamento_2 = :is_forma_pagto_2,
					cd_tipo_pagamento_2 = :is_tipo_pagto_2,
					dh_estimativa_entrega = :idt_estimativa_entrega
				where nr_pedido = :pl_nr_pedido
					and cd_filial_ecommerce = :pl_cd_filial
					Using SQLCA;	
					
	if SQLCA.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pagamento. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce_auxiliar": ' + SQLCA.sqlerrtext
		return false
	end if
	
	
else
	//Insert
	
	// NOTA FISCAL DE SERVICO
	ls_Exige_NFSE = 'N'
	
	If ib_existe_produto_manipulado Then
		ls_Exige_NFSE 	= is_Exige_NFSE
		ls_Rede 			= 'MP'
	Else
		ls_Rede = is_rede_filial
	End If
	
	//Insert Pedido Ecommerce Auxiliar
	Insert Into pedido_ecommerce_auxiliar( cd_filial_ecommerce, 
															nr_pedido, 
															nr_comprovante_cartao_credito, 
															nr_autorizacao_cartao_credito, 
															nm_administradora_cartao, 
															cd_estabelecimento_cartao, 
															id_rede_ecommerce, 
															nr_cartao_credito,
															de_codigo_transacao,
															id_pedido_site,
															id_exige_nfse,
															cd_seller,
															id_tipo_pedido,
															nr_nsu_host,
															dh_confirmacao_faturamento,
															nr_psp_recebedor,
															cd_autorizacao_cd,
															id_tipo_uso_cd, 
															nr_cpf_pbm,
															dh_validade_reserva_site,
															vl_acrescimo,
															vl_forma_pagamento,
															vl_forma_pagamento_2,
															nr_parcelas_2,
															nr_comp_cartao_credito_2,
															nr_autoriz_cartao_credito_2,
															nm_administradora_cartao_2,
															cd_estabelecimento_cartao_2,
															nr_cartao_credito_2,
															nr_nsu_host_2,
															cd_forma_pagamento_2,
															cd_tipo_pagamento_2,
															cd_filial_retirada,
															dh_estimativa_entrega,
															de_descricao_filial_retirada,
															cd_convenio,
															cd_condicao_convenio,
															cd_conveniado
															)
		Values( :il_ecommerce_alterada, 
					:il_nr_pedido, 
					:is_comprovante_cartao, 
					:is_autorizacao_cartao, 
					:is_Bandeira_Cartao, 
					:is_Estabelecimento, 
					:ls_Rede, 
					:is_cartao_credito,
					:is_cd_transacao,
					:is_id_pedido_site,
					:ls_Exige_NFSE,
					:il_filial_seller,
					:is_id_tipo_pedido,
					:is_nsu_host,
					:idt_aut_pagamento,
					:is_nr_psp_recebedor,
					:is_nr_autorizacao_pix,
					:is_id_tipo_uso_cd,
					:is_nr_cpf_pbm,
					:idt_vencimento_reserva,
					:idc_acrescimo_pagamento,
					:idc_vl_forma_pagamento,
					:idc_vl_forma_pagamento_2,
					:ii_parcelas_2,
					:is_comprovante_cartao_2,
					:is_autorizacao_cartao_2,
					:is_Bandeira_Cartao_2,
					:is_Estabelecimento_2,
					:is_cartao_credito_2,
					:is_nsu_host_2,
					:is_forma_pagto_2,
					:is_tipo_pagto_2,
					:il_cd_filial_retirada,
					:idt_estimativa_entrega,
					:is_de_descricao_filial_retirada,
					:il_cd_convenio,
					:il_cd_condicao_convenio,
					:is_cd_conveniado)
	Using SqlCa;
				
	if SqlCa.sqlcode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pagamento ~n' + 'Problemas ao inserir registro na tabela "pedido_ecommerce_auxiliar":~n' + SqlCa.sqlerrtext
		return false
	end if
	
ENd if

return true
end function

public function boolean of_grava_pagamento (ref string ps_log);return this.of_grava_pagamento( 0, 0, ref ps_log )
end function

public function boolean of_carrega_dados_reserva (long pl_cd_filial, string ps_rede_filial, string ps_nr_pedido, ref string ps_log);string ls_Interface
string ls_retorno
string ls_data

uo_ge073_json luo_gera_json
uo_ge501_comum luo_comum_vtex

if ib_afiliado = True then return true

Try

	luo_gera_json = Create uo_ge073_json 
	
	luo_comum_vtex = create uo_ge501_comum
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede_filial, is_id_ecommerce, ref ps_log ) Then return false
	
	ls_interface = 'api/logistics/pvt/inventory/reservations/'
	
	if is_forma_pagto = 'CV' Then
		ls_Interface = ls_interface + 'CNV-' + ps_nr_pedido
	Else
		ls_Interface =  ls_interface + is_id_tipo_pedido + '-' + ps_nr_pedido
	End If
				
	if Not luo_comum_vtex.of_get( ls_interface, ref ls_retorno, ref ps_log ) Then return false
	
	if Not isnull(ps_log) and ps_log <> '' then return false
	
	ls_data = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'MaximumConfirmationDateUtc')
	
	idt_vencimento_reserva = Datetime( date(ls_data), time( mid( ls_data, 12, 5) ) )
		
	//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
	Select dateadd( HOUR, -3, :idt_vencimento_reserva)
	Into :idt_vencimento_reserva
	From parametro;
		
Finally		
	
	destroy(luo_comum_vtex)
	destroy(luo_gera_json)
	
End Try
		
return true
end function

public function boolean of_verifica_pedido_empurrado (ref string ps_log);String ls_descricao
long ll_linhas, ll_for, ll_qtde, ll_cd_produto, ll_existe, ll_Qtde_total, ll_cd_produto_ant
dc_uo_ds_base lds_produtos
uo_ge501_pedido_loja luo_pedido_loja

//Somente executar se a situacao for A ou I, e a filial for HUB ou utilizar saldo virtual:
if (is_situacao <> 'A' and is_situacao <> 'I') or ( ib_filial_hub = false and iuo_comum_vtex.ib_usa_saldo_virtual = false ) Then return true

Try

	//Verifica se j$$HEX1$$e100$$ENDHEX$$ foi geradao pedido empurrado
	 Select count(*) 
	 	into :ll_existe
		 from pedido_ecommerce_produto
	WHERE cd_filial_ecommerce = :il_ecommerce_alterada
		AND nr_pedido = :il_nr_pedido
		and coalesce(qt_pedida_empurrada,0) > 0
	 USING SqlCa;

	If SqlCa.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_pedido_empurrado ~n' + 'Problemas ao consultar a tabela "pedido_ecommerce_produto": ~n' + sqlca.sqlerrtext
		Return false
	End If
	
	if ll_existe > 0 Then return true
	
	lds_produtos = create dc_uo_ds_base
	
	luo_pedido_loja = create uo_ge501_pedido_loja
	
	if not lds_produtos.of_changedataobject( 'ds_ge501_pedido_loja_produto' , false) Then
		ps_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_pedido_empurrado ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_loja_produto'
		return false
	end if
	
	ll_linhas = lds_produtos.retrieve(il_ecommerce_alterada, il_nr_pedido )
	
	if ll_linhas < 0 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext
		return false
	end if
	
	ll_cd_produto_ant = 0
	
	for ll_for = 1 to ll_linhas
		
		ll_Qtde_total = 0
		ll_qtde = lds_produtos.object.qt_pedida [ll_for]
		ll_cd_produto = lds_produtos.object.cd_produto [ll_for]
		
		if ll_cd_produto <> ll_cd_produto_ant Then
			//Somo a quantidade pedida total do produto, para caso houver mais de uma linha no pedido com o mesmo produto.
			Select sum(qt_pedida)
			into :ll_Qtde_total
			from pedido_ecommerce_produto
			where cd_filial_ecommerce = :il_ecommerce_alterada
			and nr_pedido = :il_nr_pedido
			and cd_produto = :ll_cd_produto
			Using SQLCA;
			
			if SQLCA.sqlcode = -1 then
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_pedido_empurrado ~n' + 'Problemas ao consultar a tabela "pedido_ecommerce_produto": ~n' + SQLCA.sqlerrtext
				return false
			end if
			
			If Not luo_pedido_loja.of_processa_pedido_empurrado( il_Filial_Hub, il_ecommerce_alterada, il_nr_pedido, ll_cd_produto, ll_Qtde_total, ref ps_log ) Then return false
			
		ENd if
		
		if ll_cd_produto_ant = 0 or ll_cd_produto <> ll_cd_produto_ant Then
			ll_cd_produto_ant = ll_cd_produto
		ENd if		
		
	Next
	
Finally
	if isvalid(luo_pedido_loja) then destroy(luo_pedido_loja)
	if isvalid(lds_produtos) then destroy(lds_produtos)
	
End Try

return true	
end function

public function boolean of_carrega_pbm (ref string ps_log);string ls_retorno
string ls_json_restante
string ls_ean
string ls_id_campanha
string ls_id_campanha_exclusiva
string ls_id_pbm
string ls_id_usa_desconto_pbm
string ls_nr_cpf_pbm
string ls_cd_convenio_pbm
string ls_nr_autorizacao
string ls_cd_programa, ls_nm_programa
string ls_Cd_conveniado
string ls_vl_preco_max
string ls_vl_rep

long ll_cd_produto
long ll_cd_pbm
long ll_linha

decimal{2} ldc_vl_preco_maximo
decimal{2} ldc_vl_reposicao


//Busca as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido no Ecommerce.

if ib_afiliado = True Then return true

Try

	If Not iuo_comum_vtex.of_get( is_id_interface_pbm + is_pedido_ecommerce , ref ls_retorno, ref ps_log ) Then return false
			
	uo_ge073_json luo_gera_json
	
	luo_gera_json = Create uo_ge073_json 
	
	ls_json_restante = ls_retorno
	
	Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_json_restante, Ref ls_retorno,'{') 
	
		setnull(ls_ean)
		setnull(ls_id_campanha)
		setnull(ls_id_campanha_exclusiva)
		setnull(ls_id_usa_desconto_pbm)
		setnull(ls_id_pbm)
		setnull(ls_nr_cpf_pbm)
		setnull(ls_cd_programa)
		setnull(ls_nm_programa)
		setnull(ls_cd_convenio_pbm)
		setnull(ls_nr_autorizacao)
		setnull(ls_Cd_conveniado)
		setnull(ldc_vl_preco_maximo)
		setnull(ldc_vl_reposicao)
		setnull(ls_vl_preco_max)
		setnull(ls_vl_rep)
		
		ls_id_pbm = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'idPBM')
	
		Choose Case Upper(ls_id_pbm)
			Case 'DERMACLUB'
				ll_cd_pbm = 54567
				
			Case 	'FUNCIONAL'
				ll_cd_pbm = 52349
				
			CAse 'EPHARMA'
				ll_cd_pbm = 52718
				
			Case Else
				ps_log = 'O tipo de PBM n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurado: ' + ls_id_pbm
				return false
					
		End Choose
	
		ls_ean = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'ean')
		ls_id_campanha = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'idCampanha')
		ls_id_campanha_exclusiva = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'idCampanhaExclusiva')
		ls_id_usa_desconto_pbm = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'idDescontoPBM')
		ls_id_pbm = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'idPBM')
		ls_nr_cpf_pbm = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'cpf')
		
		ls_cd_programa = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'programCode')
		ls_nm_programa = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'programName')
		ls_cd_convenio_pbm = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'cd_convenio_pbm')
		
		if ll_cd_pbm = 52718 Then
			ls_nr_autorizacao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'authorizationId')
		Else
			ls_nr_autorizacao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'authorizationNumber')
		End if
		
		ls_vl_preco_max = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'storeMaximumPrice')
		ls_vl_preco_max = gf_replace(ls_vl_preco_max, '.', ',', 0)
		ldc_vl_preco_maximo = dec( ls_vl_preco_max )
		
		ls_vl_rep = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'retailTransferValue')
		ls_vl_rep = gf_replace(ls_vl_rep, '.', ',', 0)
		ldc_vl_reposicao = dec( ls_vl_rep )
		
		select top 1 cd_produto
		into :ll_cd_produto
		from codigo_barras_produto
		where de_codigo_barras = :ls_ean;
		
		if Upper(ls_id_campanha_exclusiva) = "TRUE" then
			ls_id_campanha_exclusiva = 'S'
		else
			ls_id_campanha_exclusiva = 'N'
		end if
		
		if Upper(ls_id_usa_desconto_pbm) = "TRUE" then
			ls_id_usa_desconto_pbm = 'S'
		else
			ls_id_usa_desconto_pbm = 'N'
		end if
		
		if ll_cd_produto = 0 or isnull(ll_cd_produto) Then
			ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar um produto vinculado ao seguinte EAN: ' + ls_ean
			return false
		ENd if
		
		//Se for Funcional Card, exigir o numero de autorizacao:
		If ll_cd_pbm = 52349 or ll_cd_pbm = 52718 Then
			
			if ls_id_usa_desconto_pbm = 'S' and ( isnull(ls_nr_autorizacao) or ls_nr_autorizacao = '') Then
				ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o n$$HEX1$$fa00$$ENDHEX$$mero de autoriza$$HEX2$$e700e300$$ENDHEX$$o.'
				return false
			End if
		ENd if
		
		if ls_cd_programa <> '' and not isnull(ls_cd_programa) Then
			
			if ll_cd_pbm = 52718 Then
				
				Select cd_conveniado
				into :ls_cd_conveniado
				from conveniado
				where cd_convenio = :ll_cd_pbm
				and cd_conveniado = :ls_cd_programa;
				
				if sqlca.sqlcode = -1 then
					ps_log = 'Problemas ao consultar a tabela conveniado: ' + sqlca.sqlerrtext
					return false
				end if
				
				if ls_cd_conveniado = '' or isnull(ls_cd_conveniado) Then
					ls_cd_conveniado = '28'
				End if
				
			Else
			
				select cd_conveniado
				into :ls_Cd_conveniado
				from conveniado_pbm
				where cd_convenio = :ll_cd_pbm
				and cd_conveniado_pbm = :ls_cd_programa;
				
				if sqlca.sqlcode = -1 then
					ps_log = 'Problemas ao consultar a tabela conveniado_pbm: ' + sqlca.sqlerrtext
					return false
				end if
				
			ENd if
			
			if ls_Cd_conveniado = '' or isnull(ls_Cd_conveniado) Then
				ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar um conveniado vinculado ao seguinte programa: ' + ls_cd_programa + ' - ' + ls_nm_programa + '[PBM = ' + ls_id_pbm + ']'
				return false
			ENd if
			
		ENd if
		
		if isnull(ldc_vl_reposicao) then ldc_vl_reposicao = 0
		if isnull(ldc_vl_preco_maximo) then ldc_vl_preco_maximo = 0
		
		ll_linha = ids_produtos_pbm.insertrow(0)
		
		ids_Produtos_pbm.object.cd_produto[ll_linha] = ll_cd_produto
		ids_Produtos_pbm.object.nr_campanha[ll_linha] = ls_id_campanha
		ids_Produtos_pbm.object.cd_pbm[ll_linha] = ll_cd_pbm
		ids_Produtos_pbm.object.id_campanha_exclusiva[ll_linha] = ls_id_campanha_exclusiva
		ids_Produtos_pbm.object.id_usa_desconto_pbm[ll_linha] = ls_id_usa_desconto_pbm
		ids_Produtos_pbm.object.de_codigo_barras[ll_linha] = ls_ean
		ids_Produtos_pbm.object.nr_cpf[ll_linha] = ls_nr_cpf_pbm
		ids_Produtos_pbm.object.cd_convenio_pbm[ll_linha] = ls_cd_convenio_pbm
		ids_Produtos_pbm.object.cd_conveniado[ll_linha] = ls_cd_conveniado
		ids_Produtos_pbm.object.nr_autorizacao[ll_linha] = ls_nr_autorizacao
		ids_Produtos_pbm.object.vl_preco_maximo[ll_linha] = ldc_vl_preco_maximo
		ids_Produtos_pbm.object.vl_reposicao[ll_linha] = ldc_vl_reposicao
		
	//	setnull(is_id_usa_campanha_exclusiva_pbm)
	//	setnull(is_nr_campanha_pbm)
	//	setnull(il_cd_pbm)
	//	setnull(is_id_usa_desconto_pbm)
		
	Loop

Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_pbm - ' + ps_log

End Try

return true
end function

public function boolean of_carrega_produto_receita (ref string ps_json);string ls_info_receita
string ls_dados_receita
string ls_tipo_receita

uo_ge073_json luo_gera_json

luo_gera_json = create uo_ge073_json

luo_gera_json.of_divide_grupo_json_tag_vtex(ref ps_json, 'attachments', ref ls_info_receita, '],"quantity"')
	
Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_info_receita, Ref ls_dados_receita,'{')
	
	ls_tipo_receita = luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'name')
	is_receita_token = luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Dados da Receita')
	
	if ls_tipo_receita = 'Receita psicotropico' Then
		
		is_receita_orgao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Org$$HEX1$$e300$$ENDHEX$$o Emissor')
		is_receita_nr_doc = luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'RG do comprador')
		is_receita_nm_cliente = upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Nome do comprador'))
		is_receita_telefone = luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Telefone')
		
		is_receita_rua = upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Rua'))
		is_receita_numero = luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'N$$HEX1$$fa00$$ENDHEX$$mero')
		is_receita_estado = upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Estado'))
		is_receita_cidade = upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Cidade'))
		is_receita_bairro = upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Bairro'))
		ib_usa_receita = True
		
	elseif ls_tipo_receita = 'Receita Antibiotico' then
	
		 is_receita_nm_cliente = upper(luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Nome que esta na receita'))
		 is_receita_data = luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Data de Nascimento do Paciente')
		 is_receita_sexo = luo_gera_json.of_busca_conteudo_campo_vtex(ls_dados_receita, 'Sexo do Paciente')
		 ib_usa_receita = True
		 
	else
		ib_usa_receita = False
	end if
	 
Loop
	
return true
end function

public function boolean of_busca_produto_ecommerce (long pl_cd_produto, ref string ps_cd_produto_ecommerce, ref string ps_log);string ls_cod_prod

select cd_produto_ecommerce
into :ls_cod_prod
from ecommerce_prd
where id_ecommerce = :is_id_ecommerce
and id_rede_filial = :is_rede_filial
and cd_produto = :pl_cd_produto;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_produto_ecommerce - Problemas ao consultar a tabela ecommerce_prd: ' + sqlca.sqlerrtext
	return false
end if

ps_cd_produto_ecommerce = ls_cod_prod

return true
end function

public function boolean of_carrega_produto_pedido (string ps_json, long pl_qtde_kit, ref string ps_log);string ls_retorno
string ls_info_kit
string ls_valor
string ls_aux
string ls_aux_kit
string ls_refId

long ll_find
long ll_qtde_produto_kit

boolean lb_kit = false

decimal{2} ldc_pc_desconto
decimal{2} ldc_Acrescimo_Unitario

Try

	Do While iuo_gera_json.of_divide_grupo_json_completo(Ref ps_json, Ref ls_retorno,'{') 
		
		this.of_limpa_variaveis_produto( )
		
		ls_refId = ''
		ldc_pc_desconto=0
		ldc_Acrescimo_Unitario=0
		ll_qtde_produto_kit = 0
		
		
		//Busca as informa$$HEX2$$e700f500$$ENDHEX$$es de pre$$HEX1$$e700$$ENDHEX$$o/desconto
		ls_aux = ls_retorno
		ls_aux_kit = ls_retorno
		idc_desconto_prd = 0
		idc_acrescimo_prd = 0
		
		//Busca informa$$HEX2$$e700f500$$ENDHEX$$es de receita
		ib_usa_receita = false
		
		//Verificar se o item $$HEX1$$e900$$ENDHEX$$ um Kit:
		iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_aux_kit, 'components', ref ls_info_kit, '}],"bundleItems"')
		
		if ls_info_kit = '' or isnull(ls_info_kit) Then
			lb_kit = false
			
		else
			lb_kit = true
			
			ls_valor = ''
			ls_valor =  iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'quantity')
			ll_qtde_produto_kit = long(ls_valor)
			
			If IsNull(ll_qtde_produto_kit) or ll_qtde_produto_kit = 0 Then
				ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi informado a quantidade de itens referente ao kit.'
				Return False
			End IF
			
		ENd if
		
		if lb_kit = True Then
			
			//Se o produto for um Kit, chama a funcao de forma recursiva para carregar os itens do kit:
			if Not this.of_carrega_produto_pedido( ls_info_kit, ll_qtde_produto_kit, ref ps_log ) then return false
			
			//Quando item for kit nao deve prosseguir, passa para o proximo item:
			Continue
			
		ENd if
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ uma receita vinculada ao produto:
		If Not this.of_carrega_produto_receita( ref ls_aux ) then return false
		
		// Nome do produto para gravar no manipulado
		ls_valor = ''
		ls_valor = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_aux, 'name')
		is_nm_Produto = ls_valor
		
		If IsNull(ls_valor) or trim(ls_valor) = '' Then
			ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [name].'
			Return False
		End IF	
		
		ls_refId = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'refId')
		
		If IsNull(ls_refId) or trim(ls_refId) = '' Then
			ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [refId].'
			Return False
		End IF
		
		ls_valor = ''
		ls_valor = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'productId')
		is_cd_produto_ecommerce = ls_valor
		
		If IsNull(is_cd_produto_ecommerce) or trim(is_cd_produto_ecommerce) = '' Then
			
			If Not this.of_busca_produto_ecommerce( long(ls_refId), ref is_cd_produto_ecommerce, ref ps_log ) Then return false
		
			If IsNull(is_cd_produto_ecommerce) or trim(is_cd_produto_ecommerce) = '' Then
				ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [productId].'
				Return False
			ENd if
		End IF
		
		// Carrega o c$$HEX1$$f300$$ENDHEX$$digo do produto
		If Not of_verifica_codigo_produto(ls_refId, Ref ps_Log) Then Return False
		
		//Carrega os descontos:
		if Not this.of_carrega_produto_desconto( ls_aux, ref ldc_pc_desconto, ref idc_desconto_prd, ref idc_acrescimo_prd, ref ps_log) Then return false
		
		if isnull(idc_desconto_prd) Then idc_desconto_prd = 0
		if isnull(idc_acrescimo_prd) Then idc_acrescimo_prd = 0
		if isnull(ldc_pc_desconto) Then ldc_pc_desconto = 0
		
		// Manipulado
		If il_cd_Produto = il_produto_manipulado Then
			is_nm_Produto 	= is_tipo_manipulado + Upper(is_nm_Produto)
			ib_existe_produto_manipulado	= True
		Else
			SetNull(is_nm_Produto)
		End If
			
		ls_valor = ''
		ls_valor = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'quantity')
		il_qtde_produto = long(ls_valor)
		
		//Se o produto est$$HEX1$$e100$$ENDHEX$$ dentro de um kit, multiplica a quantidade do produto pela quantidade do kit:
		if pl_qtde_kit > 0 and not isnull(pl_qtde_kit) Then
			il_qtde_produto = il_qtde_produto * pl_qtde_kit
			idc_desconto_prd = idc_desconto_prd * pl_qtde_kit
		End if
		
		If idc_acrescimo_prd> 0 Then
			ldc_Acrescimo_Unitario = round(idc_acrescimo_prd / il_qtde_produto, 2)
		End If
		
		If IsNull(ls_valor) or trim(ls_valor) = '' Then
			ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [quantity].'
			Return False
		End IF
		
		ls_valor = ''
		ls_valor = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'listPrice')
		idc_preco = iuo_comum_vtex.of_decimal( long(ls_valor) )
		
//		If IsNull(ls_valor) or trim(ls_valor) = '' Then
//			ps_log = is_objeto +  'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [listPrice].'
//			Return False
//		End IF
		
		ls_valor = ''
		ls_valor = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'price')
		
		If IsNull(ls_valor) or trim(ls_valor) = '' Then
			ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi informado o valor da tag [price].'
			Return False
		End IF
		
		If Len(ls_valor) > 1 Then
			idc_preco_promo = iuo_comum_vtex.of_decimal( long(ls_valor) )
		Else
			idc_preco_promo = dec('0,0' + ls_valor)
		End If
		
		if idc_preco = 0 or isnull(idc_preco) Then idc_preco = idc_preco_promo
		
		//Se o total de descontos for superior ao valor do produto, usa o valor do produto para evitar ficar negativo.
		if idc_desconto_prd >  (idc_preco_promo*il_qtde_produto) Then
			idc_desconto_prd = idc_preco_promo*il_qtde_produto
		End if
		
		if ldc_pc_desconto > 100 then
			ldc_pc_desconto = 100
		End if
		
		//Aplica o desconto percentual
		if ldc_pc_desconto > 0 then
			idc_desconto_prd += idc_preco_promo * (ldc_pc_desconto/100)
		end if
		
		idc_preco_promo = idc_preco_promo + ldc_Acrescimo_Unitario
		
		if idc_preco_promo > idc_preco Then
			idc_preco = idc_preco_promo
		End if
		
		//Informa$$HEX2$$e700f500$$ENDHEX$$es PBM	  
		
		ll_find = ids_produtos_pbm.find('cd_produto = ' + string(il_cd_Produto), 1, ids_produtos_pbm.rowcount() )
		
		if ll_find > 0 Then
		
			is_id_usa_campanha_exclusiva_pbm = ids_produtos_pbm.object.id_campanha_exclusiva[ll_find]
			is_nr_campanha_pbm = ids_produtos_pbm.object.nr_campanha[ll_find]
			il_cd_pbm = ids_produtos_pbm.object.cd_pbm[ll_find]
			is_id_usa_desconto_pbm = ids_produtos_pbm.object.id_usa_desconto_pbm[ll_find]
			
			is_cd_conveniado_pbm =  ids_produtos_pbm.object.cd_conveniado[ll_find]
			is_nr_autorizacao_pbm = ids_produtos_pbm.object.nr_autorizacao[ll_find]
			is_cd_produto_regra_pbm = ids_produtos_pbm.object.cd_convenio_pbm[ll_find]
			
			idc_vl_preco_maximo_pbm = ids_produtos_pbm.object.vl_preco_maximo[ll_find]
			idc_vl_reposicao_pbm = ids_produtos_pbm.object.vl_reposicao[ll_find]
			
			//CPF usado para Desconto PBM ser$$HEX1$$e100$$ENDHEX$$ gravado na tabela pedido_ecommerce_auxiliar
			is_nr_cpf_pbm = ids_produtos_pbm.object.nr_cpf[ll_find]
			
			If IsNull(is_nr_cpf_pbm) or trim(is_nr_cpf_pbm) = '' Then
				is_nr_cpf_pbm = is_cpf_cgc
			End IF
			
			If IsNull(is_nr_cpf_pbm) or trim(is_nr_cpf_pbm) = '' Then
				ps_log = 'CPF para uso do PBM n$$HEX1$$e300$$ENDHEX$$o encontrado.'
				Return False
			End IF
			
		else
			setnull(is_id_usa_campanha_exclusiva_pbm)
			setnull(is_nr_campanha_pbm)
			setnull(il_cd_pbm)
			setnull(is_id_usa_desconto_pbm)
			setnull(is_cd_conveniado_pbm)
			setnull(is_nr_autorizacao_pbm)
			setnull(is_cd_produto_regra_pbm)
			setnull(idc_vl_reposicao_pbm)
			setnull(idc_vl_preco_maximo_pbm)
			
			if is_nr_cpf_pbm = '' or isnull(is_nr_cpf_pbm) Then
				setnull(is_nr_cpf_pbm)
			end if
		end if 
		  
		setnull(is_cd_Fornecedor)
		setnull(il_requisicao_manip)
		
		if Not this.of_grava_produto(ref ps_log) Then return false
		
		if ib_usa_receita = True Then
			
			if Not this.of_carrega_receita(ref ps_log) Then return false
			
		end if
		
	Loop

Finally
	if ps_log <> '' and not isnull(ps_log) Then
		ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_produto_pedido - ' + ps_log
	ENd if
End Try

return true
end function

public subroutine of_ajusta_horario (ref datetime pdt_data);//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
	Select dateadd( HOUR, -3, :pdt_data )
	Into :pdt_data
	From parametro;
end subroutine

public function boolean of_consulta_pedido_magalu (string ps_nr_pedido, ref string ps_retorno, ref string ps_log);
string ls_usuario = 'precopopularapi'
string ls_senha = 'xci5Rt3hefbCY7Qdx6vv'
string ls_url = 'https://in.integracommerce.com.br/api/order/'
string ls_status_text
string ls_Retorno_Api
string ls_token

long ll_status_code

oleobject lole_SrvHTTP, lole_Send

Try

	ps_nr_pedido = mid(ps_nr_pedido, 1, len(ps_nr_pedido) - 3)

	ls_url = ls_url + 'LU-' + ps_nr_pedido

	if not isvalid(iuo_comum_vtex) then iuo_comum_vtex = create uo_ge501_comum

	//Gerar Token de acesso 
	if Not iuo_comum_vtex.of_gerar_token_magalu( ref ls_token, ref ps_log) then return false

	if isnull(ls_token) or ls_token = '' then
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_consulta_pedido_magalu; N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar o token de acesso a API da Magazine Luiza.'
		return false
	End if

	//ls_token = 'eyJraWQiOiI2VERTaF9XcHp0VldSZG9DVlZ6emZyZng5OFFQTERUZ1lWSzlBQmdmZUxZIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJodHRwczovL2F1dG9zZWctaWRwLmx1aXphbGFicy5jb20vIiwiaWF0IjoxNjg4NTc3MjIzLCJqdGkiOiJkZTRmYWYzZi03NTU1LTQxNzctYjlkNi03MDUwODkxZTc0MzciLCJhdWQiOlsicHVibGljIl0sInNjb3BlIjoiYXBpaW46YWxsIG9wZW5pZCIsImF6cCI6Ikh6dWJJUVhhZEg0SGJrNEZqRG5KbXVHdzd0eTQta0wtWVc5bC03SGxPTG8iLCJhbXIiOlsia2NiMmIiXSwiZXhwIjoxNjg4NTg0NDI0LCJwaWQiOiJhYjM3MzMxYS1hYTE5LTQyNDgtYjlkMC1lNDNlOGZkNDNmODAiLCJ0ZW5hbnQiOiJHRU5QVUIuN2Y4M2ZhYmMtNmI1Yi00MDVkLThiOGMtZDk1ODA2N2I3ODJhIiwiZW1haWwiOiJsZW9uYXJkby5yb2Jha293c2tpQGNsYW1lZC5jb20uYnIiLCJzdWIiOiI4NzRkNWViMi0xYjY2LTQwYWUtOWQ2Ni05MWEyOTE2NjVlMzMifQ.hGshcH8koGUZY3VNocDpeJuc--BqVWeQDz6KjTBo6O3o0NpyT2PlqSsriJJo0vEWKzdfWiDH-tPjCukew2WrKkrF0rj1jNvIbw8jvfQ7IKmONcZnHGyX32jYaEdW4hxVc6NyL72iEE4K-02ZPMkDj_zn56aWShccBAYCWvl9R6I'

	lole_SrvHTTP = CREATE oleobject
	lole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
	
	lole_Send = CREATE oleobject
	lole_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")

	lole_SrvHTTP.open ('GET', ls_url, false, ls_usuario, ls_senha ) 
	
	if Not IsValid(lole_SrvHTTP) THEN Return false
	
	lole_SrvHTTP.SetRequestHeader("content-type", "application/json")
	lole_SrvHTTP.setRequestHeader("Authorization", 'Bearer ' + ls_token)
	lole_SrvHTTP.setOption(2,'13056') 

	lole_SrvHTTP.Send(lole_Send)
	
	//Get response 
	ls_status_text = lole_SrvHTTP.StatusText 
	ll_status_code = lole_SrvHTTP.Status 
	
	ls_Retorno_Api = String( lole_SrvHTTP.ResponseText )
	
	if ll_status_code <> 200 then
		
		ps_log = ls_status_text
		return false
	Else
		
		ps_retorno = ls_retorno_api
		
	End if

CATCH (RuntimeError e) 
	ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_consulta_pedido_magalu ~nErro: ' + e.getMessage()
	Return false	
	
Finally
	
End Try

return true
end function

public function boolean of_carrega_pagamento_magalu (string ps_json, ref string ps_log);string ls_json_restante
string ls_info_pagamento
string ls_forma_pagamento[]
string ls_id_pedido
string ls_id_pedido_magalu
string ls_retorno
string ls_valor_taxa

long ll_nr_pagamento=0

decimal{2} ldc_vl_pagamento[]

integer li_nr_parcelas[]

uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 

ls_json_restante = ps_json

ls_id_pedido = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'Id')
ls_id_pedido_magalu = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'IdOrder')
ls_valor_taxa = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'TotalTax')

luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'Payments', ref ls_retorno, ']')

Do While iuo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_info_pagamento,'{') 

	ll_nr_pagamento++

	ls_forma_pagamento[ll_nr_pagamento] = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pagamento, 'Name')
	li_nr_parcelas[ll_nr_pagamento] = long(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pagamento, 'Installments'))
	ldc_vl_pagamento[ll_nr_pagamento] = dec(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_pagamento, 'Amount'))
	ldc_vl_pagamento[ll_nr_pagamento] = iuo_comum_vtex.of_decimal( ldc_vl_pagamento[ll_nr_pagamento] )
	
	Choose Case ls_forma_pagamento[ll_nr_pagamento]
		Case 'bank_slip'
			ls_forma_pagamento[ll_nr_pagamento] = 'BOLETO'
		Case 'credit_card'
			ls_forma_pagamento[ll_nr_pagamento] = 'CREDITO'
		Case 'account_balance'
			ls_forma_pagamento[ll_nr_pagamento] = 'CARTEIRA DIGITAL'
	End Choose
	
Loop	

if ll_nr_pagamento > 2 then
	ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero de formas de pagamento n$$HEX1$$e300$$ENDHEX$$o esperado: " + string(ll_nr_pagamento)
	Return False
End if	

idc_acrescimo_pagamento = dec(ls_valor_taxa)
//idc_acrescimo_pagamento = iuo_comum_vtex.of_decimal( idc_acrescimo_pagamento )

if isnull(idc_acrescimo_pagamento) then idc_acrescimo_pagamento = 0	
	
is_tipo_pagamento_site = 'MAGALU ' + upper(ls_forma_pagamento[1])
is_de_adquirente = 'MAGALU'
ii_parcelas = li_nr_parcelas[1]
is_nr_autorizacao_pix = ls_id_pedido_magalu
is_nsu_host = ls_id_pedido
is_comprovante_cartao = ls_id_pedido
is_cartao_credito = '000000'
idc_vl_forma_pagamento = ldc_vl_pagamento[1]

is_autorizacao_cartao = mid(ls_id_pedido,1,6)
idt_aut_pagamento = idt_compra

if ll_nr_pagamento = 2 then
	
	this.is_tipo_pagamento_site_2 = 'MAGALU ' + upper(ls_forma_pagamento[2])
	this.is_de_adquirente_2 = 'MAGALU'
	this.ii_parcelas_2 = li_nr_parcelas[2]
	this.is_nr_autorizacao_pix_2 = ls_id_pedido_magalu
	this.is_nsu_host_2 = ls_id_pedido
	this.is_comprovante_cartao_2 = ls_id_pedido
	this.is_cartao_credito_2 = '000000'
	this.idc_vl_forma_pagamento_2 = ldc_vl_pagamento[2]
	
	this.is_autorizacao_cartao_2 = mid(ls_id_pedido,1,6)
	this.idt_aut_pagamento_2 = idt_compra
	
end if

return true
end function

public function boolean of_iniciar_manuseio (string ps_rede_filial, long pl_cd_filial, string ps_nr_pedido, ref string ps_log);string ls_Interface
string ls_retorno
string ls_log_bkp
string ls_origem

datetime ldh_data_validacao

uo_ge501_comum luo_comum_vtex

luo_comum_vtex = create uo_ge501_comum

//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
if Not luo_comum_vtex.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede_filial, is_id_ecommerce, ref ps_log ) Then return false

if is_id_tipo_pedido = 'MGZ' Then
	ls_origem = 'MGZ-MGZ-LU-'
Elseif is_forma_pagto = 'CV' Then
	ls_origem = 'CNV'
Else
	ls_origem = is_id_tipo_pedido + '-'
ENd if

ls_Interface = is_id_interface + ls_origem + ps_nr_pedido + '/start-handling'
			
//HANDLING para o site
luo_comum_vtex.of_post( '', ls_Interface , ref ls_retorno, ref ps_log ) 		

If ps_Log <> '' and not isnull(ps_Log) Then
	If Pos(ps_log, 'Order status should be ready-for-handling',1) > 0 Then
		
		ls_log_bkp = ps_log
		ps_log = ''
		
		//Busca as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido no Ecommerce.
		luo_comum_vtex.of_get( 'api/oms/pvt/orders/' + ls_origem + ps_nr_pedido, ref ls_retorno, ref ps_log )

		If ps_Log = '' or isnull(ps_Log) Then

			//Verifica o status. Se tiver Handling, ignora o log de erro e segue o processo
			if this.of_valida_status_pedido( ls_retorno ) = True Then
				ps_log = ''
			else
				
				ps_log = 'Aguardando atualiza$$HEX2$$e700e300$$ENDHEX$$o do status do pedido no seller da VTEX.'
				
			end if
		end if
	end if
end if

destroy(luo_comum_vtex)

if Not isnull(ps_log) and ps_log <> '' then 
	return false
else
	return true
end if
end function

public function boolean of_carrega_pagamento (string ps_json, ref string ps_log);String ls_json_magalu
String ls_grupo_pagamento
String ls_info_pagamento
String ls_retorno
String ls_tipo_pagamento_site[]
String ls_cartao_credito[]

long ll_nr_pagamento = 0
long ll_for

integer li_parcelas[]

Decimal{2} ldc_vl_forma_pagamento[]
Decimal{2} ldc_valor_total_pagamento=0
Decimal{2} ldc_valor_diferenca

Try
	
	If is_id_tipo_pedido = 'MGZ' then
		//Se for Pedido Magalu
		If Not this.of_consulta_pedido_magalu( is_pedido_ecommerce, ref ls_json_magalu, ref ps_log) then return false
		
		If Not this.of_carrega_pagamento_magalu( ls_json_magalu, ref ps_log) then return false

		if not this.of_busca_forma_pagamento( is_de_adquirente, is_tipo_pagamento_site, is_forma_pagto, ref is_tipo_pgto, ref is_forma_pagto, ref il_Pagamento, ref is_Estabelecimento, ref is_Bandeira_Cartao, ref is_id_tipo_uso_cd, ref ps_log) then return false
		
		//Segunda forma de pagamento:
		if this.idc_vl_forma_pagamento_2 > 0 then
			if not this.of_busca_forma_pagamento( is_de_adquirente_2, is_tipo_pagamento_site_2, is_forma_pagto_2, ref is_tipo_pagto_2, ref is_forma_pagto_2, ref il_Pagamento, ref is_Estabelecimento_2, ref is_Bandeira_Cartao_2, ref is_id_tipo_uso_cd, ref ps_log) then return false
		End if
		
		//Ajustar diferen$$HEX1$$e700$$ENDHEX$$a de 1 centavo que as vezes acontece nos pedidos magalu:
		if isnull(this.idc_vl_forma_pagamento_2) then this.idc_vl_forma_pagamento_2 = 0

		ldc_valor_diferenca = idc_Total - (this.idc_vl_forma_pagamento + this.idc_vl_forma_pagamento_2)
		
		if ldc_valor_diferenca >= -0.05 and ldc_valor_diferenca <= 0.05 Then
		
			if ldc_valor_diferenca > 0 then
				this.idc_vl_forma_pagamento = this.idc_vl_forma_pagamento + ldc_valor_diferenca 	
			End if
			if ldc_valor_diferenca < 0 then
				ldc_valor_diferenca = ldc_valor_diferenca * -1
				this.idc_vl_forma_pagamento = this.idc_vl_forma_pagamento - ldc_valor_diferenca	
			End if
			
		End if
		
	Elseif ib_afiliado = True and is_id_afiliado = 'GTM' Then //GOTOTEM
		//Se for pedido GoTotem
		if not this.of_carrega_pagamento_gototem( ps_json, ref ps_log ) Then return false
		
		if not this.of_busca_forma_pagamento( is_de_adquirente, is_tipo_pagamento_site, is_forma_pagto, ref is_tipo_pgto, ref is_forma_pagto, ref il_Pagamento, ref is_Estabelecimento, ref is_Bandeira_Cartao, ref is_id_tipo_uso_cd, ref ps_log) then return false
	
	Elseif ib_afiliado = True and is_id_afiliado = 'MMD' Then //MEMED
	
		if not this.of_carrega_pagamento_memed( ref ps_log) then return false
		
		if not this.of_busca_forma_pagamento( is_de_adquirente, is_tipo_pagamento_site, is_forma_pagto, ref is_tipo_pgto, ref is_forma_pagto, ref il_Pagamento, ref is_Estabelecimento, ref is_Bandeira_Cartao, ref is_id_tipo_uso_cd, ref ps_log) then return false
	
	else
		
		//C$$HEX1$$f300$$ENDHEX$$digo da transacao
		is_cd_transacao = iuo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'transactionId')
				
		iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ps_json, 'payments', ref ls_info_pagamento, '}]')
		
		Do While iuo_gera_json.of_divide_grupo_json_completo(Ref ls_info_pagamento, Ref ls_retorno,'{') 
			
			ll_nr_pagamento++
			
			//cd_tipo_pagamento
			ls_tipo_pagamento_site[ll_nr_pagamento] = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'paymentSystemName')
			ls_tipo_pagamento_site[ll_nr_pagamento] = upper(ls_tipo_pagamento_site[ll_nr_pagamento])
			
			ls_grupo_pagamento = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'group')
			
			if isnull(ls_grupo_pagamento) then ls_grupo_pagamento = ''
			
			ldc_vl_forma_pagamento[ll_nr_pagamento] =  iuo_comum_vtex.of_decimal( dec(iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'value')) )
			
			Choose Case upper(ls_grupo_pagamento)
					
				Case 'CONVENIOSCLAMED' //Convenio
					
					ls_tipo_pagamento_site[ll_nr_pagamento] = 'CONVENIOS CLAMED'
					
					//nr_parcelas
					li_parcelas[ll_nr_pagamento] = long(iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'installments'))
					
				Case 'INSTANTPAYMENT', 'PICPAY' // PIX/PICPAY
				
					li_parcelas[ll_nr_pagamento] = 1
					ls_cartao_credito[ll_nr_pagamento] = '000000'
					
					If Not of_carrega_pagamento_transacao(ref ls_tipo_pagamento_site[ll_nr_pagamento], ref ps_log) Then return false
			
				Case 'CREDITCARD' //Indica que $$HEX1$$e900$$ENDHEX$$ um pagamento por cart$$HEX1$$e300$$ENDHEX$$o de credito
			
					//Cartao credito
					ls_cartao_credito[ll_nr_pagamento] = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'firstDigits') +&
														'XXXXXX' + iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'lastDigits')
						
					//nr_parcelas
					li_parcelas[ll_nr_pagamento] = long(iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'installments'))
				
					If Not of_carrega_pagamento_transacao(ref ls_tipo_pagamento_site[ll_nr_pagamento], ref ps_log) Then return false
				
				Case 'BANKINVOICE' //Indica pagamento por boleto
				
					// N$$HEX1$$fa00$$ENDHEX$$mero do boleto
					is_Bloqueto  = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'tid')
					li_parcelas[ll_nr_pagamento] = 1
					ls_cartao_credito[ll_nr_pagamento] = '000000'
					
					If IsNull(is_Bloqueto) or Trim(is_Bloqueto) = '' Then
						ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero do boleto n$$HEX1$$e300$$ENDHEX$$o foi informado."
						Return False
					End If
					
				CAse Else
					ps_log = 'Forma de pagamento n$$HEX1$$e300$$ENDHEX$$o foi localizada: ' + ls_grupo_pagamento
					return false
					
			End Choose
			
			ldc_valor_total_pagamento +=  ldc_vl_forma_pagamento[ll_nr_pagamento] 
		
		Loop
		
		if ll_nr_pagamento > 2 then
			ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero de formas de pagamento n$$HEX1$$e300$$ENDHEX$$o esperado: " + string(ll_nr_pagamento)
			Return False
		End if
		
		if ldc_valor_total_pagamento <> idc_total Then
			ps_log = 'Valor do pagamento [' + string(ldc_valor_total_pagamento) + '] diferente do valor total do pedido [' + String(idc_total) + '].'
			return false
		end if
	
		if  upperbound(ldc_vl_forma_pagamento) > 0 then
	
			for ll_for = 1 to ll_nr_pagamento
				
				if upperbound(ls_tipo_pagamento_site) > ll_for - 1 then
					if ll_for = 1 then
						is_tipo_pagamento_site = ls_tipo_pagamento_site[ll_for]
					Else
						is_tipo_pagamento_site_2 = ls_tipo_pagamento_site[ll_for]
					End if
				ENd if
				
				if upperbound(li_parcelas) > ll_for - 1 then
					if ll_for = 1 then
						ii_parcelas = li_parcelas[ll_for]	
					else
						ii_parcelas_2 = li_parcelas[ll_for]	
					End if
				ENd if
				
				if upperbound(ls_cartao_credito) > ll_for - 1 then
					if ll_for = 1 then
						is_cartao_credito = ls_cartao_credito[ll_for]
					else
						is_cartao_credito_2 = ls_cartao_credito[ll_for]
					End if
				End if
				
				if upperbound(ldc_vl_forma_pagamento) > ll_for - 1 then
					if ll_for = 1 then
						idc_vl_forma_pagamento = ldc_vl_forma_pagamento[ll_for]
					else
						idc_vl_forma_pagamento_2 = ldc_vl_forma_pagamento[ll_for]
					ENd if
				End if
				
				if ll_for = 1 then
					if not this.of_busca_forma_pagamento( is_de_adquirente, is_tipo_pagamento_site, is_forma_pagto, ref is_tipo_pgto, ref is_forma_pagto, ref il_Pagamento, ref is_Estabelecimento, ref is_Bandeira_Cartao, ref is_id_tipo_uso_cd, ref ps_log) then return false
				Else 
					if not this.of_busca_forma_pagamento( is_de_adquirente_2, is_tipo_pagamento_site_2, is_forma_pagto_2, ref is_tipo_pagto_2, ref is_forma_pagto_2, ref il_Pagamento, ref is_Estabelecimento_2, ref is_Bandeira_Cartao_2, ref is_id_tipo_uso_cd, ref ps_log) then return false
				ENd if
			
			Next
	
		Else
			ps_log = 'Pedido sem forma de pagamento.'
			return false
		ENd if
	
	End if
		
Finally
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_pagamento; ' + ps_log
	
End Try

return true
end function

public function boolean of_carrega_pagamento_transacao (ref string ps_tipo_pagamento, ref string ps_log);String ls_retorno, ls_info_conector, ls_tag, ls_aux, ls_data, ls_info_pix, ls_info_transacao

String ls_id_transacao_conector[]
String ls_conector_pagamento[]
String ls_de_adquirente[]
String ls_nr_autorizacao_pix[]
String ls_autorizacao_cartao[]
String ls_comprovante_cartao[]
String ls_nsu_host[]

long ll_pos, ll_inicio, ll_fim, ll_nr_transacao = 0
datetime ldh_data 

datetime ldt_aut_pagamento[]

uo_ge501_comum luo_comum_vtex

try 

	luo_comum_vtex = create uo_ge501_comum
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial( il_filial_seller, is_rede_filial, is_id_ecommerce, ref ps_log ) then return false
	luo_comum_vtex.is_url = gf_replace(luo_comum_vtex.is_url, 'myvtex.com', 'vtexpayments.com.br', 0 )

	//Acessa o site para buscar as informa$$HEX2$$e700f500$$ENDHEX$$es de pagamento da transacao
	luo_comum_vtex.of_get( gf_replace( "/api/pvt/transactions/XXX/payments", 'XXX', is_cd_transacao, 0 ) , ref ls_retorno, ref ps_log )
			
	If ps_log <> '' and not isnull(ps_log) Then Return False
	
	Do While iuo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_info_transacao,'{') 
		
		ll_nr_transacao++
		
		ls_id_transacao_conector[ll_nr_transacao] = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_transacao, 'tid')
		
		ls_conector_pagamento[ll_nr_transacao] = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_transacao, 'connector')
	
		Choose Case upper(ls_conector_pagamento[ll_nr_transacao])
			Case  'ESITEF' 
			
				if isnull(ls_id_transacao_conector[ll_nr_transacao]) or ls_id_transacao_conector[ll_nr_transacao] = '' Then
					ls_de_adquirente[ll_nr_transacao] = 'Cielo e-Commerce'
				else
					//ConnectorResponses
					iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_info_transacao, 'ConnectorResponses', ref ls_info_conector, '}')
						
					ls_de_adquirente[ll_nr_transacao] = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_conector, 'acquirer')
					ls_de_adquirente[ll_nr_transacao] = Upper(ls_de_adquirente[ll_nr_transacao])
					
					if is_situacao = 'A' Then //Somente se o pagamento foi aprovado
					
						this.is_url_conector = luo_comum_vtex.is_url_conector
						this.is_chave_conector = luo_comum_vtex.is_chave_conector
						this.is_token_conector = luo_comum_vtex.is_token_conector
					
						//Se utilizar conector ESITEF:
						if ls_de_adquirente[ll_nr_transacao] = 'CARDSE' and upper(ps_tipo_pagamento) = 'PIX' Then
							
							if Not this.of_busca_nsu_esitef( 'PIX', ls_id_transacao_conector[ll_nr_transacao], ref ls_comprovante_cartao[ll_nr_transacao], ref ls_nr_autorizacao_pix[ll_nr_transacao], ref ldt_aut_pagamento[ll_nr_transacao],  ref ps_log) Then return false
							
							ls_nsu_host[ll_nr_transacao] = ls_comprovante_cartao[ll_nr_transacao]
							ls_autorizacao_cartao[ll_nr_transacao] = '0'
							
						else
							if Not this.of_busca_nsu_esitef( 'P', ls_id_transacao_conector[ll_nr_transacao], ref ls_comprovante_cartao[ll_nr_transacao], ref ls_autorizacao_cartao[ll_nr_transacao], ref ldh_data,  ref ps_log) Then return false
						end if
					end if
				end if
			
			Case 'SITEF'
					
				if is_situacao = 'G' Then
					ls_de_adquirente[ll_nr_transacao] = 'Cielo e-Commerce'
				elseif is_situacao <> 'X' Then
					
					ls_aux = ls_info_transacao		
					iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_aux, 'authorizationConnectorResponse', ref ls_info_conector, '}')		
							
					ls_tag = '"acquirer\":'
					ll_inicio = pos(ls_info_conector, ls_tag,1)
					
					if ll_inicio > 0 Then
						
						ll_inicio = ll_inicio + len(ls_tag)
						
						ll_fim = pos(ls_info_conector, ',', ll_inicio)
						ls_de_adquirente[ll_nr_transacao] = Trim( Mid( ls_info_conector, ll_inicio, ll_fim - ll_inicio) )
						
						if ls_de_adquirente[ll_nr_transacao] = '5' then
							ls_de_adquirente[ll_nr_transacao] = 'REDECARD'
						Elseif ls_de_adquirente[ll_nr_transacao] = '201' Then
							ls_de_adquirente[ll_nr_transacao] = 'Cielo e-Commerce'
						end if
						
					end if
				end if
				
				if is_situacao = 'A' Then //Somente se o pagamento foi aprovado
					If Not This.of_busca_nsu(ls_info_transacao, ps_log, ls_comprovante_cartao[ll_nr_transacao], ls_autorizacao_cartao[ll_nr_transacao]) Then Return False
				end if
				
			Case 'MERCADOPAGOV2' //PIX Mercado Pago
				
				ps_tipo_pagamento = 'PIX ECOMMERCE'
				ls_de_adquirente[ll_nr_transacao] = 'CARDSE'
				
				ls_data = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_transacao, 'authorizationDate')
				ldt_aut_pagamento[ll_nr_transacao] =  Datetime( date(ls_data), time( mid( ls_data, 12, 5) ) )
				
				//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
				of_ajusta_horario(ref ldt_aut_pagamento[ll_nr_transacao])
				
				//ConnectorResponses
				ls_aux = ls_info_transacao
				iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_aux, 'ConnectorResponses', ref ls_info_conector, '}')
				
				ls_nr_autorizacao_pix[ll_nr_transacao] =  iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_conector, 'authId')
				
				ls_nr_autorizacao_pix[ll_nr_transacao] = mid(ls_nr_autorizacao_pix[ll_nr_transacao],1,11)
				
				iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_info_transacao, 'fields', ref ls_info_pix, '"sheets"')
	
				Do While iuo_gera_json.of_divide_grupo_json_completo(Ref ls_info_pix, Ref ls_aux,'{') 
					if iuo_gera_json.of_busca_conteudo_campo_vtex(ls_aux, 'name') = 'sequence' Then
						ls_autorizacao_cartao[ll_nr_transacao] = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_aux, 'value')
						ls_autorizacao_cartao[ll_nr_transacao] = mid(ls_autorizacao_cartao[ll_nr_transacao], 1, len(ls_autorizacao_cartao[ll_nr_transacao]) - 2)
						Exit
					end if
				Loop
				
				ls_nsu_host[ll_nr_transacao] = mid(ls_nr_autorizacao_pix[ll_nr_transacao],1,11)
				ls_comprovante_cartao[ll_nr_transacao] = ls_autorizacao_cartao[ll_nr_transacao]
				
			Case 'PICPAY'	
				
				ps_tipo_pagamento = 'PICPAY'
				ls_de_adquirente[ll_nr_transacao] = 'PICPAY'
				
				ls_data = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_transacao, 'authorizationDate')
				ldt_aut_pagamento[ll_nr_transacao] =  Datetime( date(ls_data), time( mid( ls_data, 12, 5) ) )
				
				//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
				of_ajusta_horario(ref ldt_aut_pagamento[ll_nr_transacao])
				
				//ConnectorResponses
				ls_aux = ls_info_transacao
				iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_aux, 'ConnectorResponses', ref ls_info_conector, '}')
				
				//Os campos comprovante/autorizacao/NSU devem passar a conter a informacao do nr_pedido.
				//Essa alteracao $$HEX1$$e900$$ENDHEX$$ feita na of_grava_pagamento, pois aqui nesse momento o nr_pedido ainda nao foi gerado.
				ls_nsu_host[ll_nr_transacao] =  iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_conector, 'nsu')
				
				ls_autorizacao_cartao[ll_nr_transacao] = mid(ls_nsu_host[ll_nr_transacao],1,6)
				ls_comprovante_cartao[ll_nr_transacao] = mid(ls_nsu_host[ll_nr_transacao],1,10)
				ls_nr_autorizacao_pix[ll_nr_transacao] = ls_nsu_host[ll_nr_transacao]
									
				ls_nsu_host[ll_nr_transacao] = mid(ls_nsu_host[ll_nr_transacao],1,10)
				
			Case Else
				if isnull(ls_conector_pagamento[ll_nr_transacao]) Then ls_conector_pagamento[ll_nr_transacao] = ''
				ps_log = 'N$$HEX1$$e300$$ENDHEX$$o poss$$HEX1$$ed00$$ENDHEX$$vel identificar o conector de pagamento: ' + ls_conector_pagamento[ll_nr_transacao]
				return false
		End Choose
		
		if is_situacao <> 'X' and ( ls_de_adquirente[ll_nr_transacao] = '' or isnull(ls_de_adquirente[ll_nr_transacao]) or pos(ls_de_adquirente[ll_nr_transacao], 'NULL',1) > 0 ) Then
			ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar o adquirente."
			Return False
		end if
		
		if is_situacao = 'A' Then //Somente se pagamento aprovado	
		
			IF Upper(ps_tipo_pagamento) = 'PIX' or Upper(ps_tipo_pagamento) = 'PIX ECOMMERCE' or Upper(ps_tipo_pagamento) = 'PICPAY' Then
				
				If IsNull(ls_nr_autorizacao_pix[ll_nr_transacao]) or ls_nr_autorizacao_pix[ll_nr_transacao] = '' Then
					ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero da autoriza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o encontrado ou $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido [authorizationNumber]."
					Return False
				End If	
				
	//			If IsNull(is_nr_psp_recebedor) or is_nr_psp_recebedor = '' Then
	//				ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero PSP recebedor PIX n$$HEX1$$e300$$ENDHEX$$o encontrado ou $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido [pix_psp]."
	//				Return False
	//			End If	
				
				If IsNull(ls_nsu_host[ll_nr_transacao]) Then
					ps_log = "C$$HEX1$$f300$$ENDHEX$$digo NSU inv$$HEX1$$e100$$ENDHEX$$lido [hostUSN]."
					Return False
				end if
				
				If IsNull(ls_autorizacao_cartao[ll_nr_transacao]) Then
					ps_log = "C$$HEX1$$f300$$ENDHEX$$digo de autoriza$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido [sequence]."
					Return False
				end if
				
				if isnull(ldt_aut_pagamento[ll_nr_transacao]) or Date(ldt_aut_pagamento[ll_nr_transacao]) = Date('01/01/1900') Then
					ps_log = "Data de autoriza$$HEX2$$e700e300$$ENDHEX$$o do pagamento inv$$HEX1$$e100$$ENDHEX$$lida [authorizationDate]."
					Return False
				end if
				
				ls_nsu_host[ll_nr_transacao] = ls_nsu_host[ll_nr_transacao] + ' *' 
				
			else
				
				If IsNull(ls_autorizacao_cartao[ll_nr_transacao]) or ls_autorizacao_cartao[ll_nr_transacao] = '' Then
					ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero da autoriza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi informado ou $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido [authorizationNumber]."
					Return False
				End If	
				
				If IsNull(ls_comprovante_cartao[ll_nr_transacao]) or Not IsNumber(ls_comprovante_cartao[ll_nr_transacao]) Then
					ps_log = "Comprovante do cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi informado ou $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido [hostUSN]."
					Return False
				End If
				
				If Len(ls_comprovante_cartao[ll_nr_transacao]) > 12 Then
					ps_log = "Comprovante do cart$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior que o esperado 12 [hostUSN]."
					Return False
				End If		
				
			end if
		
			ls_comprovante_cartao[ll_nr_transacao] = ls_comprovante_cartao[ll_nr_transacao] + ' *'
			
		end if
		
		if upperbound(ls_id_transacao_conector) < ll_nr_transacao then setnull(ls_id_transacao_conector[ll_nr_transacao])
		if upperbound(ls_conector_pagamento) < ll_nr_transacao then setnull(ls_conector_pagamento[ll_nr_transacao])
		if upperbound(ls_de_adquirente) < ll_nr_transacao then setnull(ls_de_adquirente[ll_nr_transacao])
		if upperbound(ls_nr_autorizacao_pix) < ll_nr_transacao then setnull(ls_nr_autorizacao_pix[ll_nr_transacao])
		if upperbound(ls_autorizacao_cartao) < ll_nr_transacao then setnull(ls_autorizacao_cartao[ll_nr_transacao])
		if upperbound(ls_comprovante_cartao) < ll_nr_transacao then setnull(ls_comprovante_cartao[ll_nr_transacao])
		if upperbound(ls_nsu_host) < ll_nr_transacao then setnull(ls_nsu_host[ll_nr_transacao])
		if upperbound(ldt_aut_pagamento) < ll_nr_transacao then setnull(ldt_aut_pagamento[ll_nr_transacao])
		
	Loop

	if ll_nr_transacao > 2 then
		ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero de formas de pagamento n$$HEX1$$e300$$ENDHEX$$o esperado: " + string(ll_nr_transacao)
		Return False
	End if

	is_id_transacao_conector = ls_id_transacao_conector[1]
	is_conector_pagamento = ls_conector_pagamento[1]
	is_de_adquirente = ls_de_adquirente[1]
	is_nr_autorizacao_pix = ls_nr_autorizacao_pix[1]
	is_autorizacao_cartao = ls_autorizacao_cartao[1]
	is_comprovante_cartao = ls_comprovante_cartao[1]
	is_nsu_host = ls_nsu_host[1]
	idt_aut_pagamento = ldt_aut_pagamento[1]

	if ll_nr_transacao = 2 then
		
		is_id_transacao_conector_2 = ls_id_transacao_conector[2]
		is_conector_pagamento_2 = ls_conector_pagamento[2]
		is_de_adquirente_2 = ls_de_adquirente[2]
		is_nr_autorizacao_pix_2 = ls_nr_autorizacao_pix[2]
		is_autorizacao_cartao_2 = ls_autorizacao_cartao[2]
		is_comprovante_cartao_2 = ls_comprovante_cartao[2]
		is_nsu_host_2 = ls_nsu_host[2]
		idt_aut_pagamento_2 = ldt_aut_pagamento[2]
		
	End if

Finally
	destroy(luo_comum_vtex)
End try

Return True
end function

public function boolean of_busca_forma_pagamento (string ps_de_adquirente, string ps_tipo_pagamento, string ps_forma_pagamento, ref string ps_cd_pagamento, ref string ps_cd_forma_pagamento, ref long pl_id_pagamento, ref string ps_cd_estabelecimento, ref string ps_nm_administradora_cartao, ref string ps_id_tipo_uso_cd, ref string ps_log);String ls_id_situacao
long ll_cd_adm_tef

Choose Case Upper(ps_de_adquirente)
	Case 'CIELO E-COMMERCE'
		ll_cd_adm_tef = 125
	Case 'REDECARD'
		ll_cd_adm_tef = 5
	Case 'CARDSE'
		ll_cd_adm_tef = 271
	Case 'PAGSEGURO'	
		ll_cd_adm_tef = 302
	Case  'PICPAY'
		ll_cd_adm_tef = 271
End Choose

if ll_cd_adm_tef > 0 Then

	if ib_afiliado = True Then
		
		select te.cd_pagamento,   
				te.cd_forma_pagamento,   
				te.id_pagamento,   
				te.cd_estabelecimento,   
				Coalesce(cp.nm_produto, te.nm_administradora_cartao),   
				te.id_situacao,
				te.id_tipo_uso_cd
	Into 	:ps_cd_pagamento, 
			:ps_cd_forma_pagamento, 
			:pl_id_pagamento, 
			:ps_cd_estabelecimento, 
			:ps_nm_administradora_cartao, 
			:ls_id_situacao,
			:ps_id_tipo_uso_cd
	from tipo_pagamento_ecommerce te
		 left join cartao_produto cp on (cp.cd_bandeira = te.cd_bandeira and te.cd_administradora_tef = cp.cd_administradora_tef )
	where te.nm_tipo_pagamento_site =  :ps_tipo_pagamento 
		and te.cd_forma_pagamento = :ps_forma_pagamento 
		and te.cd_administradora_tef = :ll_cd_adm_tef;
		
		
	else

		select 	te.cd_pagamento,   
					te.cd_forma_pagamento,   
					te.id_pagamento,   
					te.cd_estabelecimento,   
					Coalesce(cp.nm_produto, te.nm_administradora_cartao),   
					te.id_situacao,
					te.id_tipo_uso_cd
		Into 	:ps_cd_pagamento, 
				:ps_cd_forma_pagamento, 
				:pl_id_pagamento, 
				:ps_cd_estabelecimento, 
				:ps_nm_administradora_cartao, 
				:ls_id_situacao,
				:ps_id_tipo_uso_cd
		from tipo_pagamento_ecommerce te
			 left join cartao_produto cp on (cp.cd_bandeira = te.cd_bandeira and te.cd_administradora_tef = cp.cd_administradora_tef )
		where te.nm_tipo_pagamento_site =  :ps_tipo_pagamento 
			and ( te.id_ecommerce is null or te.id_ecommerce = :is_id_ecommerce ) 
			and te.cd_administradora_tef = :ll_cd_adm_tef;
		
	end if
	
else //Se n$$HEX1$$e300$$ENDHEX$$o for cart$$HEX1$$e300$$ENDHEX$$o
		
	select te.cd_pagamento,   
			te.cd_forma_pagamento,   
			te.id_pagamento,   
			te.cd_estabelecimento,   
			te.nm_administradora_cartao, 
			te.id_situacao,
			te.id_tipo_uso_cd
	Into 	:ps_cd_pagamento, 
			:ps_cd_forma_pagamento, 
			:pl_id_pagamento, 
			:ps_cd_estabelecimento, 
			:ps_nm_administradora_cartao, 
			:ls_id_situacao,
			:ps_id_tipo_uso_cd
	from tipo_pagamento_ecommerce te	
	where te.nm_tipo_pagamento_site =  :ps_tipo_pagamento 
		and ( te.id_ecommerce is null or te.id_ecommerce = :is_id_ecommerce )  ;	
		
end if

Choose Case SqlCa.SqlCode
	Case 0
		
		if ls_id_situacao = 'I' Then
			ps_log = 'Forma de pagamento com situa$$HEX2$$e700e300$$ENDHEX$$o inativa: ' + ps_tipo_pagamento
			return false
		end if
	
	Case 100
		ps_Log = 'Forma de pagamento n$$HEX1$$e300$$ENDHEX$$o localizada :' + ps_tipo_pagamento
		Return False
	Case -1
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_forma_pagamento. ' + 'Problemas ao consultar a tabela "tipo_pagamento_ecommerce": ' + sqlca.sqlerrtext
		return false
End Choose
		

Return True

end function

public function boolean of_carrega_pagamento_cartao (string ps_info_pagamento, ref string ps_log);String ls_retorno, ls_info_conector, ls_tag, ls_aux, ls_data, ls_info_pix, ls_info_transacao

String ls_id_transacao_conector[]
String ls_conector_pagamento[]
String ls_de_adquirente[]
String ls_nr_autorizacao_pix[]
String ls_autorizacao_cartao[]
String ls_comprovante_cartao[]
String ls_nsu_host[]

long ll_pos, ll_inicio, ll_fim, ll_nr_transacao = 0

datetime ldh_data 
datetime ldt_aut_pagamento[]

uo_ge501_comum luo_comum_vtex

try 
	
	luo_comum_vtex = create uo_ge501_comum
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial( il_filial_seller, is_rede_filial, is_id_ecommerce, ref ps_log ) then return false
	luo_comum_vtex.is_url = gf_replace(luo_comum_vtex.is_url, 'myvtex.com', 'vtexpayments.com.br', 0 )

	//Acessa o site para buscar as informa$$HEX2$$e700f500$$ENDHEX$$es de pagamento da transacao
	luo_comum_vtex.of_get( gf_replace( "/api/pvt/transactions/XXX/payments", 'XXX', is_cd_transacao, 0 ) , ref ls_retorno, ref ps_log )
			
	If ps_log <> '' and not isnull(ps_log) Then Return False
	
	Do While iuo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_info_transacao,'{') 
		
		ll_nr_transacao++
		
		ls_id_transacao_conector[ll_nr_transacao] = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_transacao, 'tid')
		
		ls_conector_pagamento[ll_nr_transacao] = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_transacao, 'connector')
		
		Choose Case upper(ls_conector_pagamento[ll_nr_transacao])
			Case  'ESITEF' 
			
				if isnull(ls_id_transacao_conector[ll_nr_transacao]) or ls_id_transacao_conector[ll_nr_transacao] = '' Then
					ls_de_adquirente[ll_nr_transacao] = 'Cielo e-Commerce'
				else
					//ConnectorResponses
					iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_info_transacao, 'ConnectorResponses', ref ls_info_conector, '}')
						
					ls_de_adquirente[ll_nr_transacao] = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_conector, 'acquirer')
					ls_de_adquirente[ll_nr_transacao] = Upper(ls_de_adquirente[ll_nr_transacao])
					
					if is_situacao = 'A' Then //Somente se o pagamento foi aprovado
					
						this.is_url_conector = luo_comum_vtex.is_url_conector
						this.is_chave_conector = luo_comum_vtex.is_chave_conector
						this.is_token_conector = luo_comum_vtex.is_token_conector
					
						//Se utilizar conector ESITEF:
						if ls_de_adquirente[ll_nr_transacao] = 'CARDSE' and upper(is_tipo_pagamento_site) = 'PIX' Then
							
							if Not this.of_busca_nsu_esitef( 'PIX', ls_id_transacao_conector[ll_nr_transacao], ref ls_comprovante_cartao[ll_nr_transacao], ref ls_nr_autorizacao_pix[ll_nr_transacao], ref ldt_aut_pagamento[ll_nr_transacao],  ref ps_log) Then return false
							
							ls_nsu_host[ll_nr_transacao] = ls_comprovante_cartao[ll_nr_transacao]
							ls_autorizacao_cartao[ll_nr_transacao] = '0'
							
						else
							if Not this.of_busca_nsu_esitef( 'P', ls_id_transacao_conector[ll_nr_transacao], ref ls_comprovante_cartao[ll_nr_transacao], ref ls_autorizacao_cartao[ll_nr_transacao], ref ldh_data,  ref ps_log) Then return false
						end if
					end if
				end if
			
			Case 'SITEF'
					
				if is_situacao = 'G' Then
					ls_de_adquirente[ll_nr_transacao] = 'Cielo e-Commerce'
				elseif is_situacao <> 'X' Then
					
					ls_aux = ls_info_transacao		
					iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_aux, 'authorizationConnectorResponse', ref ls_info_conector, '}')		
							
					ls_tag = '"acquirer\":'
					ll_inicio = pos(ls_info_conector, ls_tag,1)
					
					if ll_inicio > 0 Then
						
						ll_inicio = ll_inicio + len(ls_tag)
						
						ll_fim = pos(ls_info_conector, ',', ll_inicio)
						ls_de_adquirente[ll_nr_transacao] = Trim( Mid( ls_info_conector, ll_inicio, ll_fim - ll_inicio) )
						
						if ls_de_adquirente[ll_nr_transacao] = '5' then
							ls_de_adquirente[ll_nr_transacao] = 'REDECARD'
						Elseif ls_de_adquirente[ll_nr_transacao] = '201' Then
							ls_de_adquirente[ll_nr_transacao] = 'Cielo e-Commerce'
						end if
						
					end if
				end if
				
				if is_situacao = 'A' Then //Somente se o pagamento foi aprovado
					If Not This.of_busca_nsu(ls_info_transacao, ps_log, ls_comprovante_cartao[ll_nr_transacao], ls_autorizacao_cartao[ll_nr_transacao]) Then Return False
				end if
				
			Case 'MERCADOPAGOV2' //PIX Mercado Pago
				
				is_tipo_pagamento_site = 'PIX ECOMMERCE'
				ls_de_adquirente[ll_nr_transacao] = 'CARDSE'
				
				ls_data = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_transacao, 'authorizationDate')
				ldt_aut_pagamento[ll_nr_transacao] =  Datetime( date(ls_data), time( mid( ls_data, 12, 5) ) )
				
				//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
				of_ajusta_horario(ref ldt_aut_pagamento[ll_nr_transacao])
				
				//ConnectorResponses
				ls_aux = ls_info_transacao
				iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_aux, 'ConnectorResponses', ref ls_info_conector, '}')
				
				ls_nr_autorizacao_pix[ll_nr_transacao] =  iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_conector, 'authId')
	
				iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_info_transacao, 'fields', ref ls_info_pix, '"sheets"')
	
				Do While iuo_gera_json.of_divide_grupo_json_completo(Ref ls_info_pix, Ref ls_aux,'{') 
					if iuo_gera_json.of_busca_conteudo_campo_vtex(ls_aux, 'name') = 'sequence' Then
						ls_autorizacao_cartao[ll_nr_transacao] = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_aux, 'value')
						ls_autorizacao_cartao[ll_nr_transacao] = mid(ls_autorizacao_cartao[ll_nr_transacao], 1, len(ls_autorizacao_cartao[ll_nr_transacao]) - 2)
						Exit
					end if
				Loop
				
				ls_nsu_host[ll_nr_transacao] = ls_nr_autorizacao_pix[ll_nr_transacao]
				ls_comprovante_cartao[ll_nr_transacao] = ls_autorizacao_cartao[ll_nr_transacao]
				
			Case 'PICPAY'	
				
				is_tipo_pagamento_site = 'PICPAY'
				ls_de_adquirente[ll_nr_transacao] = 'PICPAY'
				
				ls_data = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_transacao, 'authorizationDate')
				ldt_aut_pagamento[ll_nr_transacao] =  Datetime( date(ls_data), time( mid( ls_data, 12, 5) ) )
				
				//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
				of_ajusta_horario(ref ldt_aut_pagamento[ll_nr_transacao])
				
				//ConnectorResponses
				ls_aux = ls_info_transacao
				iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_aux, 'ConnectorResponses', ref ls_info_conector, '}')
				
				//is_nr_autorizacao_pix =  luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_conector, 'authId')
				ls_nsu_host[ll_nr_transacao] =  iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_conector, 'nsu')
				
				ls_autorizacao_cartao[ll_nr_transacao] = mid(ls_nsu_host[ll_nr_transacao],1,6)
				ls_comprovante_cartao[ll_nr_transacao] = mid(ls_nsu_host[ll_nr_transacao],1,20)
				ls_nr_autorizacao_pix[ll_nr_transacao] = ls_nsu_host[ll_nr_transacao]
				
			Case Else
				if isnull(ls_conector_pagamento[ll_nr_transacao]) Then ls_conector_pagamento[ll_nr_transacao] = ''
				ps_log = 'N$$HEX1$$e300$$ENDHEX$$o poss$$HEX1$$ed00$$ENDHEX$$vel identificar o conector de pagamento: ' + ls_conector_pagamento[ll_nr_transacao]
				return false
		End Choose
		
		if is_situacao <> 'X' and ( ls_de_adquirente[ll_nr_transacao] = '' or isnull(ls_de_adquirente[ll_nr_transacao]) or pos(ls_de_adquirente[ll_nr_transacao], 'NULL',1) > 0 ) Then
			ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar o adquirente."
			Return False
		end if
		
		if is_situacao = 'A' Then //Somente se pagamento aprovado	
		
			IF Upper(is_tipo_pagamento_site) = 'PIX' or Upper(is_tipo_pagamento_site) = 'PIX ECOMMERCE' or Upper(is_tipo_pagamento_site) = 'PICPAY' Then
				
				If IsNull(ls_nr_autorizacao_pix[ll_nr_transacao]) or ls_nr_autorizacao_pix[ll_nr_transacao] = '' Then
					ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero da autoriza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o encontrado ou $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido [authorizationNumber]."
					Return False
				End If	
				
	//			If IsNull(is_nr_psp_recebedor) or is_nr_psp_recebedor = '' Then
	//				ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero PSP recebedor PIX n$$HEX1$$e300$$ENDHEX$$o encontrado ou $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido [pix_psp]."
	//				Return False
	//			End If	
				
				If IsNull(ls_nsu_host[ll_nr_transacao]) or Not IsNumber(ls_nsu_host[ll_nr_transacao]) Then
					ps_log = "C$$HEX1$$f300$$ENDHEX$$digo NSU inv$$HEX1$$e100$$ENDHEX$$lido [hostUSN]."
					Return False
				end if
				
				If IsNull(ls_autorizacao_cartao[ll_nr_transacao]) Then
					ps_log = "C$$HEX1$$f300$$ENDHEX$$digo de autoriza$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido [sequence]."
					Return False
				end if
				
				if isnull(ldt_aut_pagamento[ll_nr_transacao]) or Date(ldt_aut_pagamento[ll_nr_transacao]) = Date('01/01/1900') Then
					ps_log = "Data de autoriza$$HEX2$$e700e300$$ENDHEX$$o do pagamento inv$$HEX1$$e100$$ENDHEX$$lida [authorizationDate]."
					Return False
				end if
				
				if Upper(is_tipo_pagamento_site) <> 'PICPAY' then
					ls_nsu_host[ll_nr_transacao] = ls_nsu_host[ll_nr_transacao] + ' *' 
				End if
				
			else
				
				If IsNull(ls_autorizacao_cartao[ll_nr_transacao]) or ls_autorizacao_cartao[ll_nr_transacao] = '' Then
					ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero da autoriza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi informado ou $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido [authorizationNumber]."
					Return False
				End If	
				
				If IsNull(ls_comprovante_cartao[ll_nr_transacao]) or Not IsNumber(ls_comprovante_cartao[ll_nr_transacao]) Then
					ps_log = "Comprovante do cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi informado ou $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido [hostUSN]."
					Return False
				End If
				
				If Len(ls_comprovante_cartao[ll_nr_transacao]) > 12 Then
					ps_log = "Comprovante do cart$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior que o esperado 12 [hostUSN]."
					Return False
				End If		
				
			end if
		
			ls_comprovante_cartao[ll_nr_transacao] = ls_comprovante_cartao[ll_nr_transacao] + ' *'
			
		end if
		
	Loop

	if ll_nr_transacao > 2 then
		ps_log = "N$$HEX1$$fa00$$ENDHEX$$mero de formas de pagamento n$$HEX1$$e300$$ENDHEX$$o esperado: " + string(ll_nr_transacao)
		Return False
	End if

	is_id_transacao_conector = ls_id_transacao_conector[1]
	is_conector_pagamento = ls_conector_pagamento[1]
	is_de_adquirente = ls_de_adquirente[1]
	is_nr_autorizacao_pix = ls_nr_autorizacao_pix[1]
	is_autorizacao_cartao = ls_autorizacao_cartao[1]
	is_comprovante_cartao = ls_comprovante_cartao[1]
	is_nsu_host = ls_nsu_host[1]
	idt_aut_pagamento = ldt_aut_pagamento[1]

	if ll_nr_transacao = 2 then
		
		is_id_transacao_conector_2 = ls_id_transacao_conector[2]
		is_conector_pagamento_2 = ls_conector_pagamento[2]
		is_de_adquirente_2 = ls_de_adquirente[2]
		is_nr_autorizacao_pix_2 = ls_nr_autorizacao_pix[2]
		is_autorizacao_cartao_2 = ls_autorizacao_cartao[2]
		is_comprovante_cartao_2 = ls_comprovante_cartao[2]
		is_nsu_host_2 = ls_nsu_host[2]
		idt_aut_pagamento_2 = ldt_aut_pagamento[2]
		
	End if

Finally
	destroy(luo_comum_vtex)
End try

Return True
end function

public function boolean of_busca_descricao_filial_retirada (string ps_info_entrega, ref string ps_descricao_retirada, ref string ps_log);string ls_json

iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ps_info_entrega, 'deliveryChannels', ref ls_json, '],"trackingHints"')

ps_descricao_retirada = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_json, 'friendlyName')

return true

end function

public function boolean of_grava_promocao (ref string ps_log);long ll_linhas
long ll_for
long ll_existe

string ls_cd_promocao
string ls_de_promocao

Try
	
	ll_linhas = ids_promocoes.rowcount()
	
	if ll_linhas = 0 then return true
	
	For ll_for = 1 to ll_linhas
		
		ls_cd_promocao = ids_promocoes.object.id_promocao_ecommerce[ll_for]		
		ls_de_promocao = ids_promocoes.object.nm_promocao_ecommerce[ll_for]	
		
		select count(*)
		into :ll_existe
		from pedido_ecommerce_promocao
		where cd_filial_ecommerce = :il_ecommerce_alterada
			and nr_pedido = :il_nr_pedido
			and id_promocao_ecommerce = :ls_cd_promocao;
		
		if sqlca.sqldbcode = -1 then
			ps_log = 'Erro ao consultar a tabela "pedido_ecommerce_promocao": ' + sqlca.sqlerrtext
			return false
		end if
		
		If ll_existe = 0 or isnull(ll_existe) then
			
			insert into pedido_ecommerce_promocao(cd_filial_ecommerce, nr_pedido, id_promocao_ecommerce, nm_promocao_ecommerce)
			values(:il_ecommerce_alterada, :il_nr_pedido, :ls_cd_promocao, :ls_de_promocao);
		
			if sqlca.sqldbcode = -1 then
				ps_log = 'Erro ao inserir registro na tabela "pedido_ecommerce_promocao": ' + sqlca.sqlerrtext
				return false
			end if
		
		ENd if
		
	Next
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) then
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_promocao; ' + ps_log
	End if
	
ENd Try

return true
end function

public function boolean of_carrega_promocao (string ps_info_promocoes, ref string ps_log);string ls_retorno
string ls_nm_promocao
string ls_codigo
string ls_info_cupom
string ls_cd_cupom

long ll_linha

Do While iuo_gera_json.of_divide_grupo_json_completo(Ref ps_info_promocoes, Ref ls_retorno,'{') 

	ls_codigo = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'id')
	ls_nm_promocao = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'name')
	
	//Busca informaoes de cupom:
	iuo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_retorno, 'matchedParameters', ref ls_info_cupom, '}')

	ls_cd_cupom = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_info_cupom, 'couponCode@Marketing')
	
	//Veriica se $$HEX1$$e900$$ENDHEX$$ cupom de desconto ou promocao:
	if ls_cd_cupom = '' or isnull(ls_cd_cupom) then
		
		//Se nao for cupom, $$HEX1$$e900$$ENDHEX$$ promocao.
		If ids_promocoes.find('id_promocao_ecommerce = "' + ls_codigo + '"', 1, ids_promocoes.rowcount() ) = 0 then
			
			ll_linha = ids_promocoes.insertrow(0)
			
			ids_promocoes.object.id_promocao_ecommerce[ll_linha] = ls_codigo
			ids_promocoes.object.nm_promocao_ecommerce[ll_linha] = ls_nm_promocao
			
		End if
	
	Else
		is_cd_cupom_Desconto = ls_cd_cupom
	ENd if
	
Loop

return true

end function

public function boolean of_grava_produto_promocao (ref string ps_log);long ll_linhas
long ll_for
long ll_cd_produto
long ll_existe

decimal{2} ldc_vl_desconto
decimal{4} ldc_pc_desconto

string ls_id_promocao_ecommerce

Try
	
	if ids_promocoes.rowcount( ) = 0 then return true
	
	ll_linhas = ids_produto_promo.rowcount( )
	
	if ll_linhas = 0 then return true
	
	for ll_for = 1 to ll_linhas
		
		ll_cd_produto = ids_produto_promo.object.cd_produto[ll_for]
		ls_id_promocao_ecommerce = ids_produto_promo.object.id_promocao_ecommerce[ll_for]
		ldc_vl_desconto = ids_produto_promo.object.vl_desconto[ll_for]
		ldc_pc_desconto = ids_produto_promo.object.pc_desconto[ll_for]
		
		select count(*)
		into :ll_existe
		from pedido_ecommerce_prd_promo
		where cd_filial_ecommerce = :this.il_ecommerce_alterada
			and nr_pedido = :this.il_nr_pedido
			and cd_produto = :ll_cd_produto
			and id_promocao_ecommerce = :ls_id_promocao_ecommerce;
			
		if sqlca.sqlcode = -1 then
			ps_log = 'Erro ao consultar a tabela "pedido_ecommerce_prd_promo": ' + sqlca.sqlerrtext
			return false
		ENd if
		
		if ll_existe = 0 or isnull(ll_existe) then
			
			Insert into pedido_ecommerce_prd_promo(cd_filial_ecommerce, nr_pedido, cd_produto, id_promocao_ecommerce, vl_desconto, pc_desconto)
			Values(:il_ecommerce_alterada, :il_nr_pedido, :ll_cd_produto, :ls_id_promocao_ecommerce, :ldc_vl_desconto, :ldc_pc_desconto);
			
			if sqlca.sqlcode = -1 then
				ps_log = 'Erro ao inserir registro na tabela "pedido_ecommerce_prd_promo": ' + sqlca.sqlerrtext
				return false
			End if
			
		End if
		
	Next
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) then
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto_promocao; ' + ps_log
	End if
	
End Try


return true
end function

public function boolean of_carrega_produto_desconto (string ps_json, ref decimal pdc_pc_desconto, ref decimal pdc_vl_desconto, ref decimal pdc_vl_acrescimo, ref string ps_log);string ls_info_desc
string ls_info_preco
string ls_tipo_desconto
string ls_valor
string ls_id_promocao

long ll_find
long ll_linha

decimal{2} ldc_vl_desconto_unitario
decimal{4} ldc_pc_desconto_unitario

uo_ge073_json luo_gera_json

luo_gera_json = create uo_ge073_json

Try

	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ps_json, 'priceTags', ref ls_info_preco, ']')
	
	Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_info_preco, Ref ls_info_desc,'{') 
		
		ldc_vl_desconto_unitario = 0
		ldc_pc_desconto_unitario = 0
		
		setnull(ls_id_promocao)
		
		//"name": "discount@price-273b072d-f080-4397-9ab1-54605082e4e8#b28bd53e-180e-4813-986f-4fcabee0b637",
		//tipo desconto
		ls_tipo_desconto = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_desc, 'name')
				
		If Not Isnull(ls_tipo_desconto) and trim(ls_tipo_desconto)  <> '' Then
			If Pos(ls_tipo_desconto, "DISCOUNT@MANUALPRICE") > 0 or Pos(ls_tipo_desconto, "discount@price") > 0  or Pos(ls_tipo_desconto, "DISCOUNT@MARKETPLACE") > 0 or Pos(ls_tipo_desconto, "DISCOUNT@SELLERPRICE") > 0 or Pos(ls_tipo_desconto, "DISCOUNT@GIFT") > 0 Then
				
				//Verifica se $$HEX1$$e900$$ENDHEX$$ percentual
				ls_valor = ''
				ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_desc, 'isPercentual')
				
				if Upper(ls_valor) = 'TRUE' then
					ls_valor = ''
					ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_desc, 'value')	
					ldc_pc_desconto_unitario = dec(ls_valor)
					
					pdc_pc_desconto += ldc_pc_desconto_unitario
					
				else
					//Desconto
					ls_valor = ''
					ls_valor = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_desc, 'value')
				
					If pos(ls_valor,'-') > 0 Then
						ls_valor = gf_replace( ls_valor, '-', '',0 )
						ldc_vl_desconto_unitario = iuo_comum_vtex.of_decimal( long(ls_valor) )
						
						pdc_vl_desconto += ldc_vl_desconto_unitario
						
					Else
						pdc_vl_acrescimo += iuo_comum_vtex.of_decimal( long(ls_valor) )
					End If
				End if			
				
				//Verifica se h$$HEX1$$e100$$ENDHEX$$ promo$$HEX2$$e700e300$$ENDHEX$$o vinculada ao produto:
				ls_id_promocao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_desc, 'identifier')
	
				if ls_id_promocao <> '' and not isnull(ls_id_promocao) then
	
					if ids_promocoes.find('id_promocao_ecommerce = "' + ls_id_promocao + '"', 1, ids_promocoes.rowcount( ) ) > 0 then
		
						ll_find = ids_produto_promo.find( 'cd_produto = ' + string(il_cd_produto) + ' and id_promocao_ecommerce = "' + ls_id_promocao + '"', 1, ids_produto_promo.rowcount())
						
						if ll_find = 0 then
							
							ll_linha = ids_produto_promo.insertrow(0)
							ids_produto_promo.object.cd_produto[ll_linha] = il_cd_produto
							ids_produto_promo.object.id_promocao_ecommerce[ll_linha] = ls_id_promocao
							ids_produto_promo.object.pc_desconto[ll_linha] = ldc_pc_desconto_unitario
							ids_produto_promo.object.vl_desconto[ll_linha] = ldc_vl_desconto_unitario
							
						Elseif ll_find < 0 then
							ps_log = 'Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ promo$$HEX2$$e700e300$$ENDHEX$$o vinculada ao produto ' +  string(il_cd_produto) + '.'
							return false
						End if
					ENd if
				ENd if
				
			End If
		End If
		
	Loop
		
Finally		
		
	if ps_log <> '' and not isnull(ps_log) then
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_produto_desconto; ' + ps_log
	ENd if
		
	Destroy(luo_gera_json)	
	
End Try
	
Return true
end function

public function boolean of_carrega_convenio (ref string ps_log);string ls_retorno
string ls_json_restante
string ls_cd_convenio
string ls_cd_conveniado
string ls_cd_condicao

long ll_existe

//Busca as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido referente a convenios:

if ib_afiliado = True Then return true

if is_forma_pagto <> 'CV' then return true

Try

	If Not iuo_comum_vtex.of_get( is_id_interface_convenio + is_pedido_ecommerce + '/user', ref ls_retorno, ref ps_log ) Then return false
	
	ls_cd_convenio = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'cd_convenio')
	
	if ls_cd_convenio = '' or isnull(ls_cd_convenio) then return true
	
	ls_cd_condicao = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'cd_condicao_convenio')
	ls_cd_conveniado = iuo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'cd_conveniado')
	
	if isnull(ls_cd_condicao) then ls_cd_condicao = ''
	if isnull(ls_cd_conveniado) then ls_cd_conveniado = ''
	
	if not isnumber(ls_cd_convenio) then
		ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo de conv$$HEX1$$ea00$$ENDHEX$$nio inv$$HEX1$$e100$$ENDHEX$$lido: ' + ls_cd_convenio
		return false
	ENd if
	
	if not isnumber(ls_cd_condicao) or ls_cd_condicao = '' then
		ps_log = 'Condi$$HEX2$$e700e300$$ENDHEX$$o de conv$$HEX1$$ea00$$ENDHEX$$nio inv$$HEX1$$e100$$ENDHEX$$lida ou n$$HEX1$$e300$$ENDHEX$$o informada: ' + ls_cd_condicao
		return false
	ENd if
	
	if ls_cd_conveniado = '' then
		ps_log = 'Conveniado n$$HEX1$$e300$$ENDHEX$$o informado.'
		return false
	ENd if
	
	il_cd_convenio = long(ls_cd_convenio)
	il_cd_condicao_convenio = long(ls_cd_condicao)
	is_cd_conveniado = ls_cd_conveniado
	
	select count(*) 
	into :ll_existe
	from convenio 
	where cd_convenio = :il_cd_convenio;
	
	if ll_existe = 0 or isnull(ll_existe) then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o conv$$HEX1$$ea00$$ENDHEX$$nio: ' + ls_cd_convenio
		return false
	ENd if
	
	ll_existe = 0
	
	select count(*) 
	into :ll_existe
	from conveniado
	where cd_convenio = :il_cd_convenio
		and cd_conveniado = :is_cd_conveniado;
	
	if ll_existe = 0 or isnull(ll_existe) then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o conveniado: ' + is_cd_conveniado
		return false
	ENd if

	ll_existe = 0

	select count(*)
	into :ll_existe
	from relacao_condicao_convenio 
	where cd_convenio = :il_Cd_convenio
	and cd_condicao_convenio = :il_cd_condicao_convenio
	and id_ativa = 'S';
	
	if ll_existe = 0 or isnull(ll_existe) then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a condi$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio: ' + ls_cd_condicao
		return false
	ENd if

Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = is_objeto + ' - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_convenio - ' + ps_log

End Try

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

public function boolean of_grava_delivery (ref string ps_log);
//return true

insert into pedido_ecommerce_delivery(nr_pedido, cd_filial_ecommerce, id_situacao, dh_inclusao, nr_tentativa)
	values (:il_nr_pedido, :il_ecommerce_alterada, 'A', getdate(), 0 );
	
if sqlca.sqlcode = -1 Then
	ps_log = 'Problemas ao inserir registro na tabela pedido_ecommerce_delivery: ' + sqlca.sqlerrtext
	return false
ENd if
	
return true
end function

public function boolean of_busca_descricao_cidade (long pl_cd_cidade, ref string ps_ds_cidade, ref string ps_log);string ls_ds_cidade

select nm_cidade 
into :ls_ds_cidade
from cidade 
where cd_cidade = :pl_cd_cidade;

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela cidade: ' + sqlca.sqlerrtext
	return false
End if

ps_ds_cidade = ls_ds_cidade

return true
end function

public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, string ps_id_afiliado, long pl_cd_filial);Boolean lb_Erro

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
String ls_msg_email
String ls_id_aplica_filtro

s_email lst_email

long ll_linhas
Long ll_for
Long ll_Seq_Log
Long ll_nr_pedido_erp

boolean lb_sucesso=false

datetime ldt_inicio, ldt_termino
Datetime ldh_importacao
DateTime ldh_Data_Nula
Datetime ldh_log_inicio

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

is_rede_filial = ps_rede_filial

try 

	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	is_id_afiliado = ps_id_afiliado
	
	//Valida codigo de afiliado
	If is_id_afiliado = '' or isnull(is_id_afiliado) then
		ib_afiliado = False
	Else
		
		Choose Case is_id_afiliado
			Case 'GTM', 'MMD'
				ib_afiliado = True
			Case Else	
				ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + 'C$$HEX1$$f300$$ENDHEX$$digo de afiliado n$$HEX1$$e300$$ENDHEX$$o mapeado: ' + is_id_afiliado
				return false
		End Choose
			
	ENd if
	
	Open(w_Ge501_Aguarde)
 
	iuo_gera_json = Create uo_ge073_json

	iuo_comum_vtex = create uo_ge501_comum
	ids_pedidos = create dc_uo_ds_base
	ids_produtos_pbm = create dc_uo_ds_base
	ids_filiais_sem_conexao = create dc_uo_ds_base
	ids_promocoes = create dc_uo_ds_base
	ids_produto_promo = create dc_uo_ds_base
	
	//Desenvolvimento
	is_ODBC_Desenv = iuo_comum_vtex.of_desenvolvimento_odbc_baixa_pedido()
	il_Filial_Desenv = iuo_comum_vtex.of_desenvolvimento_filial_baixa_pedido()
	
	iuo_comum_vtex.is_odbc_desenv = is_ODBC_Desenv
	
	if ib_afiliado = True then
		//Carrega os parametros da filial.
		if Not iuo_comum_vtex.of_parametros_ecommerce_filial( pl_cd_filial, is_rede_filial, is_id_ecommerce, ref ls_log ) Then return false
		il_cd_filial = pl_cd_filial
		il_ecommerce_alterada = il_cd_filial
		il_filial_seller = il_cd_filial
		
		if iuo_comum_vtex.il_cd_filial_hub > 0 then
			il_Filial_Hub = iuo_comum_vtex.il_cd_filial_hub
		Else
			il_Filial_Hub = il_cd_filial
		End if
		
	else
		//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
		if Not iuo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref il_cd_filial, ref ls_Log ) Then return false
	end if
	
	setnull(ls_id_registro_log)
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )
	
	if not ids_pedidos.of_changedataobject( 'ds_ge501_pedido_ecommerce' , false) Then
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

	if gvo_Aplicacao.ivs_DataSource <> 'central' then
		ib_desenv = True
	end if

	if Not ids_produtos_pbm.of_changedataobject( 'ds_ge501_produtos_pbm') then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_produtos_pbm'
		return false
	end if
	
	if Not ids_filiais_sem_conexao.of_changedataobject( 'ds_ge501_filiais_ecommerce') then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_ecommerce'
		return false
	end if
	
	if not ids_promocoes.of_changedataobject( 'ds_ge501_pedido_ecommerce_promocao' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_ecommerce_promocao'
		return false
	end if
	
	if not ids_produto_promo.of_changedataobject( 'ds_ge501_pedido_ecommerce_prd_promo' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_ecommerce_prd_promo'
		return false
	end if
	
	if ib_afiliado = True Then
		
		ids_pedidos.of_appendwhere_subquery( "pb.id_tipo_pedido = '" + is_id_afiliado + "'", 1)
		ids_pedidos.of_appendwhere_subquery( "pb.id_tipo_pedido = '" + is_id_afiliado + "'", 2)
		
	end if

	select vl_parametro
	into :ls_id_aplica_filtro
	from parametro_geral where cd_parametro = 'ID_INTERFACE_ECOMMERCE_BAIXA_FA';
	
	if ls_id_aplica_filtro = 'S' Then

		if ps_rede_filial = 'FA' Then
			ids_pedidos.of_appendwhere_subquery( " pe.nr_pedido is not null", 1)
			ids_pedidos.of_appendwhere_subquery( " pe.nr_pedido is not null", 2)
		End if
		
	ENd if

	ll_linhas = ids_pedidos.retrieve( is_id_ecommerce, ps_rede_filial )

	If ll_Linhas > 0 Then
		iuo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not iuo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		SetNull(ls_log)
		
		this.of_limpa_variaveis( )
		
		iuo_comum_vtex.of_limpa_variaveis( )
		
		ls_nr_pedido 			= Trim(ids_pedidos.object.nr_pedido_ecommerce[ll_for])
		ll_nr_pedido_erp 		= ids_pedidos.object.nr_pedido[ll_for]
		is_situacao_erp 		= ids_pedidos.object.id_situacao[ll_for]
		is_pedido_ecommerce = ls_nr_pedido
		ldh_importacao			= ids_pedidos.object.dh_importacao[ll_for]
		is_id_tipo_pedido = ids_pedidos.object.id_tipo_pedido[ll_for]
		
		il_nr_pedido = ll_nr_pedido_erp
		
		if isnull(is_id_tipo_pedido) Then is_id_tipo_pedido = 'SLR'
		
		If not IsNull(is_pedido_debug) and Trim(is_pedido_debug) <> '' Then
			If ls_nr_pedido <>  is_pedido_debug Then
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
		
		iuo_comum_vtex.is_nr_pedido_ecommerce = ls_nr_pedido
							
		w_Ge501_Aguarde.Title = "Vtex - Baixando Pedido (Site -> ERP) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = "Pedido: " + ls_nr_pedido + ' ['+ps_rede_filial + ']'

		//Busca as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido no Ecommerce.
		if ib_afiliado = True Then
			
			//Criado no afiliado (Gototem/MEMED)
			iuo_comum_vtex.of_get( is_id_interface + is_id_afiliado + '-' + ls_nr_pedido , ref ls_retorno, ref ls_log )
			
		else
			
			Choose Case is_id_tipo_pedido
				CAse 'MGZ' //Criado no Magazine Luiza
					iuo_comum_vtex.of_get( is_id_interface + 'MGZ-LU-' + ls_nr_pedido , ref ls_retorno, ref ls_log )
					
				Case Else
					iuo_comum_vtex.of_get( is_id_interface + ls_nr_pedido , ref ls_retorno, ref ls_log )
			End Choose
			
		end if
		
		iuo_comum_vtex.is_json = ls_retorno	
		
		if ls_log <> '' and not isnull(ls_log) Then
			iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce )
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Carrega informa$$HEX2$$e700f500$$ENDHEX$$es do pedido
		If Not this.of_carrega_pedido( ls_retorno, ref ls_log, ll_nr_pedido_erp, ll_Seq_Log) Then
			iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
			iuo_comum_vtex.il_cd_filial_pedido = il_Filial_Hub
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		gf_retorna_loja_pdv_novo(il_filial_hub, ref ib_usa_pdv_java, ref ls_log )
		if ls_log <> '' and not isnull(ls_log) Then
			
			If Not gf_ge501_RollBack(SQLCA) Then Return False
			
			iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		if (il_nr_pedido = 0 or isnull(il_nr_pedido)) and ib_afiliado = false and ( isnull(is_id_tipo_pedido) or is_id_tipo_pedido = 'SLR') then
	
			If Not this.of_carrega_dados_reserva( this.il_filial_seller , ps_rede_filial, ls_nr_pedido, ref ls_log ) Then
				iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
				iuo_comum_vtex.il_cd_filial_pedido = il_Filial_Hub
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			ENd if
			
			If Not this.of_carrega_pbm( ref ls_log ) Then
				iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
				iuo_comum_vtex.il_cd_filial_pedido = il_Filial_Hub
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			ENd if
		
			if is_forma_pagto = 'CV' Then
				If Not this.of_carrega_convenio( ref ls_log ) Then
					iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
					iuo_comum_vtex.il_cd_filial_pedido = il_Filial_Hub
					iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				ENd if
			ENd if
		
		End if
		
		// Pedido cancelado do SITE e n$$HEX1$$e300$$ENDHEX$$o existe no ERP/ ou Pedido Incompleto
		If Not ib_cadastra Then
			//Atualiza data de importa$$HEX2$$e700e300$$ENDHEX$$o
			
			if isnull(ldh_importacao)  Then
				this.of_atualiza_baixa( ps_rede_filial, ls_nr_pedido, ref ls_log ) 
				
				if ls_log <> '' and not isnull(ls_log) Then
				
					If Not gf_ge501_RollBack(SQLCA) Then Return False
					
					iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
					iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
				
				If Not gf_ge501_commit(SQLCA) Then Return False
			end if
			
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End If
		
		iuo_comum_vtex.il_cd_filial_pedido = il_Filial_Hub
		
		if ib_afiliado = False and (ll_nr_pedido_erp = 0 or isnull(ll_nr_pedido_erp)) Then
			
			if is_userProfileId <> '' and not isnull(is_userProfileId) Then
			
				ls_url_padrao = iuo_comum_vtex.is_url
			
				//Busca informa$$HEX2$$e700f500$$ENDHEX$$es adicionais do cliente (Master data)
				iuo_comum_vtex.is_url = iuo_comum_vtex.is_url_master_data
				
				ls_url_masterdata = 'api/dataentities/CL/search?_fields=_all&_where=userId=' + is_userProfileId
				
				iuo_comum_vtex.of_get( ls_url_masterdata , ref ls_retorno_cliente, ref ls_log )
			
				iuo_comum_vtex.is_url = ls_url_padrao
				
				if ls_log <> '' and not isnull(ls_log) Then
					iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
					iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
		
				If Not this.of_carrega_dados_cliente( ls_retorno_cliente, ref ls_log, ll_Seq_Log ) Then 
					iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
					iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
				
			end if
		end if
		
		if is_id_tipo_entrega <> 'RET' and is_situacao <> 'G' and  is_situacao <> 'X' Then
			this.of_valida_endereco( ref ls_msg_email, ref ls_log )
			
			if ls_log <> '' and not isnull(ls_log) Then
				iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
		end if
		
		//Se o pedido j$$HEX1$$e100$$ENDHEX$$ foi importado: Atualiza o pedido
		if ll_nr_pedido_erp > 0 Then
			//Atualiza o pedido
			this.of_atualiza_pedido(ls_nr_pedido, ref ls_log)
			
			if ls_log <> '' and not isnull(ls_log) Then
				
				if isvalid(iuo_comum_vtex.itr_filial) Then
					if iuo_comum_vtex.itr_filial.of_isconnected( ) Then
						If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
					end if
				end if
				
				If Not gf_ge501_RollBack(SQLCA) Then Return False
				
				iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			//
		else
			//Se o pedido ainda n$$HEX1$$e300$$ENDHEX$$o foi importado: Cria um novo pedido
			//Grava o pedido
			
			lb_Erro = True
			
			//Verifica se o n$$HEX1$$fa00$$ENDHEX$$mero do pedido j$$HEX1$$e100$$ENDHEX$$ existe.
			if Not gf_valida_pedido_ecommerce_rede(SQLCA, ls_nr_pedido, is_id_ecommerce, ps_rede_filial, False, ref ls_log ) Then
				iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
			if this.of_grava_pedido( ls_nr_pedido, ref ls_log ) Then 
				if this.of_grava_promocao( ref ls_log ) Then
					if  this.of_carrega_produtos( ls_retorno, ref ls_log ) Then
						if this.of_grava_produto_promocao( ref ls_log ) Then
							if this.of_grava_pagamento( ref ls_log ) Then
								If This.of_valida_pedido( ref ls_Log, ps_rede_filial) Then
									If this.of_executa_upload_receita( ref ls_log) Then
										lb_Erro = False
									End If
								End If
							End If
						ENd if
					End If
				End if
			End If		
			
			If lb_Erro Then
				iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
				
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				
				if isvalid(iuo_comum_vtex.itr_filial) Then
					if iuo_comum_vtex.itr_filial.of_isconnected( ) Then
						//itr_filial.of_rollback( )
						If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
					end if
				end if
				
				//sqlca.of_rollback( )
				If Not gf_ge501_RollBack(SQLCA) Then Return False
				
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
				Continue				
			End If
			
			if this.ib_usa_pdv_java = True and is_id_tipo_entrega = 'MOT' and ( is_situacao = 'A' or is_situacao = 'I') then
	
				if Not this.of_grava_delivery( ref ls_log) Then
					If Not gf_ge501_RollBack(SQLCA) Then Return False	
					iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
					iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
				
			End if
			
			if ib_usa_pdv_java = True and (is_situacao = 'A' or is_situacao = 'I' ) Then
			
				iuo_comum_vtex.of_verifica_usa_saldo_virtual( is_id_ecommerce, ps_rede_filial, il_Filial_Hub, ref ls_log)
			
				if ls_log <> '' and not isnull(ls_log) Then
					If Not gf_ge501_RollBack(SQLCA) Then Return False	
					iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
					iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
			
				this.of_verifica_pedido_empurrado( ref ls_log )
				
				if ls_log <> '' and not isnull(ls_log) Then
					If Not gf_ge501_RollBack(SQLCA) Then Return False	
					iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
					iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
				
				if ib_desenv = false Then
					
					this.of_iniciar_manuseio( is_rede_filial , il_filial_seller, ls_nr_pedido, ref ls_log) 
					
					if ls_log <> '' and not isnull(ls_log) Then
						If Not gf_ge501_RollBack(SQLCA) Then Return False	
						iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
						iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
						ls_Situacao = 'E'
						w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
						Continue
					end if
				end if
			
			end if
			
		end if
		
		//Atualiza data de importa$$HEX2$$e700e300$$ENDHEX$$o
		setnull(is_observacao_baixa)
		this.of_atualiza_baixa( ps_rede_filial, ls_nr_pedido, ref ls_log )
		
		if ls_log <> '' and not isnull(ls_log) Then
			If Not gf_ge501_RollBack(SQLCA) Then Return False	
			iuo_comum_vtex.of_envia_email(211, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, is_pedido_ecommerce)
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
				
		if isvalid(iuo_comum_vtex.itr_filial) Then
			if iuo_comum_vtex.itr_filial.of_isconnected( ) Then
				If Not gf_ge501_commit(iuo_comum_vtex.itr_filial) Then Return False
			end if
		end if
		
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		if Not iuo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		if ib_endereco_valido = False Then
			if il_Filial_Desenv > 0 Then
				iuo_comum_vtex.of_envia_email(232, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + '~r~n' + ls_msg_email, is_pedido_ecommerce)
			else
				lst_email.ps_to = {'atendimento@precopopular.com.br', 'atendimento@drogariacatarinense.com.br', 'sac@farmagora.com.br'}
				iuo_comum_vtex.of_envia_email(232, 'PEDIDO - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + '~r~n' + ls_msg_email, lst_email, is_pedido_ecommerce)
			end if
		end if
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
	next
			
	lb_sucesso = True
	
Finally
	
	if Not lb_sucesso then 
		
		ls_situacao = 'E'
		
		if isvalid(iuo_comum_vtex.itr_filial) Then
			if iuo_comum_vtex.itr_filial.of_isconnected( ) Then
				//itr_filial.of_rollback( )
				If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
			end if
		end if
	
		//sqlca.of_rollback( )
		gf_ge501_RollBack(SQLCA)
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not iuo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not iuo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not iuo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not iuo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			//Marca o log como processado
			If Not iuo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
			
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )
		
	this.of_desconecta_filial( )	
		
	destroy(ids_pedidos)
	destroy(iuo_comum_vtex)
	destroy(iuo_gera_json)
	
	Close(w_Ge501_Aguarde)
	
End try

return true
end function

public function boolean of_carrega_pagamento_memed (ref string ps_log);is_tipo_pagamento_site = 'MEMED CREDITO'
is_de_adquirente = 'MEMED'
ii_parcelas = 1
is_nr_autorizacao_pix = this.is_pedido_ecommerce

is_nsu_host = mid(string(il_nr_pedido),1,6)
is_comprovante_cartao = mid(string(il_nr_pedido),1,6)
is_cartao_credito = '000000'
idc_vl_forma_pagamento = this.idc_total

is_autorizacao_cartao = mid(string(il_nr_pedido),1,6)
idt_aut_pagamento = idt_compra

return true
end function

on uo_ge501_pedido_ecommerce.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_pedido_ecommerce.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'

SetNull(is_pedido_debug)
end event

