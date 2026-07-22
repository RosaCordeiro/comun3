HA$PBExportHeader$uo_ge501_pedido_loja.sru
forward
global type uo_ge501_pedido_loja from nonvisualobject
end type
end forward

global type uo_ge501_pedido_loja from nonvisualobject
end type
global uo_ge501_pedido_loja uo_ge501_pedido_loja

type variables
CONSTANT INTEGER CD_MENSAGEM_EMAIL_EQUIPE_TI_DESENV		= 98 // c$$HEX1$$f300$$ENDHEX$$digo na tabela mensagem_email_sistema
CONSTANT INTEGER CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA	= 109 // c$$HEX1$$f300$$ENDHEX$$digo na tabela mensagem_email_sistema
CONSTANT STRING CD_DISTRIBUIDORA_ESTOQUE_CENTRAL			= '053404705'
CONSTANT STRING NM_TRANPORTADORA_TOTAL_EXPRESS			= 'TOTAL EXPRESS'

dc_uo_ds_base ids_filiais_sem_conexao

uo_ge501_comum iuo_comum_vtex

string is_datasource

String is_de_descricao_filial_retirada
string is_objeto
string is_id_ecommerce = '2' //VTEX
String is_ODBC_Desenv
String is_pedido_debug
String is_exige_nfse

long il_cd_tipo = 9
long il_cd_filial
Long il_Filial_Desenv
Long il_Filial_Ecommerce

Boolean ib_Desenv = False

dc_uo_ds_base ids_pedidos
dc_uo_ds_base ids_produtos

//****************************

string is_nr_cpf

//****************************

Datetime idh_compra
Datetime idh_validade_entrega_cotacao
Datetime idh_estimativa_entrega

Long il_cd_filial_pedido
Long il_nr_pedido
Long il_id_pagamento
Long il_nr_vending_machine
Long il_cd_cidade
Long il_nr_sequencial_reserva
Long il_cd_filial_retirada
Long il_cd_convenio
Long il_cd_condicao_convenio

Decimal idc_total
Decimal idc_frete
Decimal idc_valecompra
Decimal idc_Produtos_Calculado
Decimal idc_desconto
Decimal idc_subtotal
Decimal idc_acrescimo_pagamento

String is_id_interface = 'api/oms/pvt/orders/'

String is_cd_conveniado
String is_cd_tipo_pagamento
String is_id_cotacao
String is_forma_pagto
String is_observacao 
String is_endereco_ent 
String is_referencia_ent 
String is_bairro_ent
String is_cep_ent
String is_fone_ent 
String is_nome_ent
String is_nome
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
String is_nr_psp_recebedor
String is_cd_autorizacao_cd
String is_id_tipo_uso_cd
String is_id_tipo_entrega
String is_nr_nsu
String is_nm_transportadora_ecommerce
String is_tipo_pedido
String is_nr_cpf_pbm

integer ii_parcelas

end variables

forward prototypes
public function boolean of_processa_atualizacao_pedido (string ps_rede_filial)
public subroutine of_limpa_variaveis ()
public function boolean of_desconecta_filial ()
public function boolean of_conecta_filial (ref string ps_log)
public function boolean of_atualiza_pedido (ref string ps_log)
public function boolean of_forma_pagamento (long pl_id_pagamento, ref string ps_log)
public function boolean of_busca_filial_site (ref long pl_cd_filial, ref string ps_log, string ps_pedido)
public function boolean of_verifica_cliente_clube (ref string ps_log)
public function boolean of_valida_status_pedido (string ps_nr_pedido, string ps_json)
public function boolean of_grava_receita (ref string ps_log)
public function boolean of_grava_produto (ref string ps_log, boolean pb_filial_hub)
public function boolean of_grava_pedido (string ps_nr_pedido, ref string ps_log, string ps_rede)
public function boolean of_valida_receita (ref string ps_log)
public function boolean of_grava_reserva (boolean pb_filial_hub, ref string ps_log)
public function boolean of_grava_comp_venda (ref string ps_log)
public function boolean of_saldo_produto_reservado (long pl_cd_filial, long pl_nr_pedido, long pl_cd_produto, ref long pl_qt_saldo_pendente, ref string ps_log)
public function boolean of_saldo_disponivel_distrib (long pl_cd_filial, long pl_cd_produto, string ps_distribuidora, string ps_chamada, ref decimal pdc_fator_conversao, ref long pl_qt_saldo, ref string ps_log)
public function boolean of_processa_pedido_empurrado (long pl_cd_filial, long pl_cd_filial_ecommerce, long pl_nr_pedido, long pl_cd_produto, long pl_qtde, ref string ps_log)
public function boolean of_entrega_cotacao (long pl_cd_filial, long pl_nr_pedido, string ps_id_tipo_entrega, ref string ps_id_cotacao, ref string ps_nm_transportadora, ref datetime pdh_validade, ref string ps_log)
public function boolean of_grava_pagamento (ref string ps_log)
public function boolean of_verifica_situacao_filial (long pl_cd_filial, ref string ps_id_situacao, ref string ps_log)
public function boolean of_grava_comp_venda (dc_uo_transacao ptr_filial, string ps_id_situacao, long pl_nr_pedido, long pl_cd_filial, decimal pdc_vl_total, integer pi_parcelas, string ps_estabelecimento, string ps_bandeira, string ps_nr_nsu, string ps_nr_autorizacao, string ps_cd_autorizacao_cd, string ps_nr_cartao, string ps_nr_psp_recebedor, string ps_id_tipo_uso_cd, string ps_cd_forma_pagto, ref string ps_log)
public function boolean of_busca_saldo_cd (long pl_cd_filial, long pl_cd_produto, ref long pl_qt_saldo, ref string ps_log)
public function boolean of_grava_pedido_urgente (long pl_cd_filial, long pl_cd_produto, long pl_qt_pedida, long pl_qt_saldo_cd, long pl_cd_filial_ecommerce, long pl_nr_pedido, ref string ps_log)
public function boolean of_verifica_usa_pedido_urgente (long pl_cd_filial, ref boolean pb_usa_pedido_urgente, ref string ps_log)
public function boolean of_grava_delivery (ref string ps_log)
public function boolean of_grava_pedido_empurrado_prod (long pl_cd_filial, long pl_nr_pedido, long pl_cd_produto, long pl_qtde, string ps_situacao, string ps_matricula, long pl_cd_motivo, boolean pb_pedido_urgente, ref string ps_log)
public function boolean of_processa_pedido_empurrado (long pl_cd_produto, long pl_qtde, ref string ps_log)
public function boolean of_grava_pedido_empurrado (long pl_cd_filial, long pl_cd_filial_ecommerce, long pl_nr_pedido, long pl_cd_produto, long pl_saldo_falta, boolean pb_pedido_urgente, ref string ps_log)
end prototypes

public function boolean of_processa_atualizacao_pedido (string ps_rede_filial);String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_nr_pedido
String ls_retorno
String ls_Interface
String ls_log_bkp
String ls_id_registro_log
String ls_Rede_Retrieve
String ls_id_situacao_filial

long ll_linhas
Long ll_for
Long ll_Seq_Log
Long ll_existe
Long ll_cd_filial_ant
Long ll_Seller
Long ll_Filial_Erro_Conexao

boolean lb_sucesso=false
boolean lb_pedido
datetime ldt_inicio, ldt_termino, ldh_log_inicio

DateTime ldh_Data_Nula, ldh_data_validacao

SetNull(ll_Filial_Erro_Conexao)

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

//Manipula$$HEX2$$e700e300$$ENDHEX$$o, faz a pesquisa pela MP e retorna para DC pois a venda de manipulado ocorre na DC
If ps_rede_filial = 'MP' Then
	ls_Rede_Retrieve 	= 'MP'
	ps_rede_filial 		= 'DC'
Else
	ls_Rede_Retrieve = ps_rede_filial
End If

try 
	Open(w_Ge501_Aguarde)
	
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	w_Ge501_Aguarde.Title = "Vtex - Enviando Pedido (Matriz -> Loja)"

	iuo_comum_vtex = create uo_ge501_comum
	ids_pedidos = create dc_uo_ds_base
	ids_produtos = create dc_uo_ds_base
	ids_filiais_sem_conexao = create dc_uo_ds_base
	
	//Desenvolvimento
	il_Filial_Desenv 	= iuo_comum_vtex.of_desenvolvimento_filial_baixa_pedido()
	is_ODBC_Desenv 	= iuo_comum_vtex.of_desenvolvimento_odbc_baixa_pedido()
	
	this.iuo_comum_vtex.is_odbc_desenv = is_ODBC_Desenv
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not iuo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref il_cd_filial, ref ls_Log ) Then return false
	
	setnull(ls_id_registro_log)
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )
	
	if not ids_pedidos.of_changedataobject( 'ds_ge501_pedido_loja' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_loja'
		return false
	end if

	if not ids_produtos.of_changedataobject( 'ds_ge501_pedido_loja_produto' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_loja_produto'
		return false
	end if
	
	if Not ids_filiais_sem_conexao.of_changedataobject( 'ds_ge501_filiais_ecommerce') then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_ecommerce'
		return false
	end if
	
	ll_linhas = ids_pedidos.retrieve(ls_Rede_Retrieve)

	If ll_Linhas > 0 Then
		iuo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not iuo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		ls_log = ''
		
		this.of_limpa_variaveis( )
		
		ls_id_situacao_filial = ''
		
		iuo_comum_vtex.of_limpa_variaveis( )
		
		ls_nr_pedido 	= ids_pedidos.object.nr_pedido_ecommerce[ll_for]
		ll_Seller			= ids_pedidos.object.cd_seller					[ll_for]
						
		If Not IsNull(il_Filial_Desenv) Then
			ib_Desenv = True // nao atualiza a VTEX
			il_cd_filial_pedido = il_Filial_Desenv
			//if Not this.of_busca_filial_site( ref ll_Seller, ref ls_log, ls_nr_pedido ) Then return false 
		Else
			il_cd_filial_pedido 	= ids_pedidos.object.cd_filial[ll_for]
			
		End If
		
		If IsNull(ll_Seller) Then
			ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi localizado o seller no pedido: ' + ls_nr_pedido
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End If
		
		il_Filial_Ecommerce = ids_pedidos.object.cd_filial_ecommerce[ll_for]
		
		w_Ge501_Aguarde.Title = "Vtex - Enviando Pedido (Matriz -> Loja) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = "Pedido: " + ls_nr_pedido + " - Filial:" + String(il_cd_filial_pedido) + ' ['+ps_rede_filial + ']'
		
		If not IsNull(is_pedido_debug) and Trim(is_pedido_debug) <> '' Then
			If ls_nr_pedido <> is_pedido_debug Then
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
			
		is_id_situacao			= ids_pedidos.object.id_situacao			[ll_for]
			
		is_tipo_pedido			= ids_pedidos.object.id_tipo_pedido		[ll_for]	
		idc_total 					= ids_pedidos.object.vl_total				[ll_for]
		idc_frete 				= ids_pedidos.object.vl_frete				[ll_for]
		is_nr_cartao_credito 	= ids_pedidos.object.nr_cartao_credito	[ll_for]
		idc_Desconto			= ids_pedidos.object.vl_desconto			[ll_for]
		idc_Subtotal				=  idc_total - idc_frete + idc_Desconto
		is_nr_cpf 				= ids_pedidos.object.nr_cpf_cgc[ll_for]
			
		 //Verifica se o cliente tem cadastro no clube
		If Not of_Verifica_Cliente_Clube(Ref ls_Log) Then Return False
		
		is_observacao = ids_pedidos.object.de_observacao[ll_for]
		
		is_endereco_ent 		= ids_pedidos.object.de_endereco_ent		[ll_for]
		is_referencia_ent 		= ids_pedidos.object.de_referencia_ent		[ll_for]
		is_complemento_ent 	= ids_pedidos.object.de_complemento_ent	[ll_for]
		is_bairro_ent 			= ids_pedidos.object.de_bairro_ent			[ll_for]
		is_cep_ent 				= ids_pedidos.object.nr_cep_ent				[ll_for]
		is_cidade_ent 			= ids_pedidos.object.de_cidade_ent			[ll_for]
		is_uf_ent 				= ids_pedidos.object.cd_uf_ent					[ll_for]
		is_numero_ent 			= ids_pedidos.object.nr_endereco_ent		[ll_for]
		is_fone_ent 				= ids_pedidos.object.nr_fone_ent				[ll_for]
		il_cd_cidade 			= ids_pedidos.object.cd_cidade				[ll_for]
		il_nr_pedido 	= ids_pedidos.object.nr_pedido			[ll_for]
		is_nome_ent 	= ids_pedidos.object.nm_cliente_ent		[ll_for]
		is_nome		 	= ids_pedidos.object.nm_cliente			[ll_for]
		is_email			= ids_pedidos.object.de_endereco_email[ll_for]
		
		ii_parcelas 				= ids_pedidos.object.nr_parcelas[ll_for]
		is_bandeira_cartao 	= ids_pedidos.object.nm_administradora_cartao	[ll_for]
		is_transportadora 		= ids_pedidos.object.nm_transportadora				[ll_for]
		is_estabelecimento 	= ids_pedidos.object.cd_estabelecimento_cartao	[ll_for]
		is_bloqueto 				= ids_pedidos.object.nr_boleto_bancario				[ll_for]
		il_id_pagamento 		= ids_pedidos.object.id_pagamento					[ll_for]
		is_Forma_Pagto 		= ids_pedidos.object.cd_forma_pagamento			[ll_for]
		idh_compra		 		= ids_pedidos.object.dh_compra						[ll_for]
		is_exige_nfse			= ids_pedidos.object.id_exige_nfse					[ll_for]
		il_nr_vending_machine= ids_pedidos.object.nr_vending_machine			[ll_for]
		is_id_tipo_entrega		= ids_pedidos.object.id_tipo_entrega					[ll_for]		
		is_nr_cpf_pbm			= ids_pedidos.object.nr_cpf_pbm						[ll_for]		
		
		iuo_comum_vtex.is_nr_pedido_ecommerce = ls_nr_pedido
		iuo_comum_vtex.il_cd_filial_pedido 			= il_cd_filial_pedido
				
		is_comprovante_cartao 	= ids_pedidos.object.nr_comprovante_cartao_credito	[ll_for]
		is_autorizacao_cartao 	= ids_pedidos.object.nr_autorizacao_cartao_credito	[ll_for]		
		is_nr_psp_recebedor 		= ids_pedidos.object.nr_psp_recebedor					[ll_for]		
		is_cd_autorizacao_cd 	= ids_pedidos.object.cd_autorizacao_cd					[ll_for]		
		is_id_tipo_uso_cd 			= ids_pedidos.object.id_tipo_uso_cd						[ll_for]		
		is_nr_nsu 					= ids_pedidos.object.nr_nsu_host							[ll_for]
		is_cd_tipo_pagamento	= ids_pedidos.object.cd_tipo_pagamento				[ll_for]
		idc_acrescimo_pagamento = ids_pedidos.object.vl_acrescimo						[ll_for]
		il_cd_filial_retirada = ids_pedidos.object.cd_filial_retirada							[ll_for]
		idh_estimativa_entrega = ids_pedidos.object.dh_estimativa_entrega				[ll_for]
		is_de_descricao_filial_retirada = ids_pedidos.object.de_descricao_filial_retirada[ll_for]
		
		il_cd_convenio = ids_pedidos.object.cd_convenio[ll_for]
		il_cd_condicao_convenio  = ids_pedidos.object.cd_condicao_convenio[ll_for]
		is_cd_conveniado  = ids_pedidos.object.cd_conveniado[ll_for]

		if is_cd_tipo_pagamento = 'PIX' or is_cd_tipo_pagamento = 'PICPAY ECOMMERCE' Then is_autorizacao_cartao = '0'
		
		if is_cd_tipo_pagamento = 'PIX ECOMMERCE' Then
			is_nr_nsu = gf_replace(is_nr_nsu, ' ','',0)
			is_nr_nsu = gf_replace(is_nr_nsu, '*','',0)
		End if
		
		//If Not this.of_forma_pagamento( il_id_pagamento, ref ls_log ) Then return false
		
		If Not IsNull(ll_Filial_Erro_Conexao) Then
			If ll_Filial_Erro_Conexao = il_cd_filial_pedido Then
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
		
		//Verifica se a integracao com a filial est$$HEX1$$e100$$ENDHEX$$ ativa:
		this.of_verifica_situacao_filial( il_cd_filial_pedido, ref ls_id_situacao_filial, ref ls_Log )
		
		if ls_log <> '' and not isnull(ls_log) then
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		if ls_id_situacao_filial <> 'A' Then
			ls_log = 'A filial ' + string(il_cd_filial_pedido) + ' est$$HEX1$$e100$$ENDHEX$$ inativa para a integra$$HEX2$$e700e300$$ENDHEX$$o com a VTEX.'
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		if ll_cd_filial_ant <> il_cd_filial_pedido or isnull(ll_cd_filial_ant) Then
			If Not this.of_desconecta_filial( ) Then Return false
			
			If Not this.of_conecta_filial( ref ls_log ) Then 
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				ll_Filial_Erro_Conexao  = il_cd_filial_pedido
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
				//Return false
			End If
			
			ll_cd_filial_ant = il_cd_filial_pedido
		else
			
			//Verifica se a filial esta na lista das filiais sem conexao:
			if ids_filiais_sem_conexao.find('cd_filial = ' + string(il_cd_filial_pedido), 1, ids_filiais_sem_conexao.rowcount()) > 0 Then
				ls_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(il_cd_filial_pedido) 
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				ll_Filial_Erro_Conexao  = il_cd_filial_pedido
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
		end if
		
		SetNull(ll_Filial_Erro_Conexao)
		
		lb_pedido = False
	
		//Verifica se o pedido j$$HEX1$$e100$$ENDHEX$$ existe no banco de dados.
		if Not gf_valida_pedido_ecommerce_rede(iuo_comum_vtex.itr_filial, ls_nr_pedido, is_id_ecommerce, ps_rede_filial, True, ref ls_log ) Then
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End if
		
		If Not iuo_comum_vtex.of_filial_hub(il_cd_filial_pedido, ref ls_log) Then Return False
		
		if is_id_situacao = 'A' and ib_desenv = false Then 
			if Not this.of_entrega_cotacao(il_filial_ecommerce, il_nr_pedido, is_id_tipo_entrega, ref is_id_cotacao, ref is_nm_transportadora_ecommerce, ref idh_validade_entrega_cotacao, ref ls_log ) Then
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
		end if
		
		//Carrega parametro se a filial usa saldo virtual:
		iuo_comum_vtex.of_verifica_usa_saldo_virtual( is_id_ecommerce, ps_rede_filial, ll_Seller,  ref ls_log ) 
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			
			If Not gf_ge501_RollBack(SQLCA) Then Return False
			If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
			
			Continue
		end if
		
		//Grava o pedido
		if this.of_grava_pedido( ls_nr_pedido, ref ls_log, ls_Rede_Retrieve ) Then
			if this.of_grava_produto( ref ls_log,  iuo_comum_vtex.ib_filial_hub) Then 
				if this.of_grava_pagamento( ref ls_log ) Then
					if this.of_grava_reserva( iuo_comum_vtex.ib_filial_hub, ref ls_log ) Then
						if this.of_atualiza_pedido( ref ls_log ) Then
							if this.of_grava_receita( ref ls_log ) Then
								lb_pedido = True
							End if
						End if
					End if
				End If
			End If
		End If
		
		// Grava somente quando for pagamento com Carteira Digital (PIX), ou quando for pedido Gototem, ou Convenio.
		If lb_pedido = True and is_forma_pagto <> 'MF' and (is_cd_tipo_pagamento = 'PIX' or is_cd_tipo_pagamento = 'PIX ECOMMERCE' or is_tipo_pedido = 'GTM' or is_cd_tipo_pagamento = 'PICPAY ECOMMERCE' or is_tipo_pedido = 'MGZ' or is_tipo_pedido = 'MMD') Then
			if Not this.of_grava_comp_venda( ref ls_log ) Then
				lb_pedido = false
			end if
		end if
		
//		if is_id_tipo_entrega = 'MOT' and ( is_id_situacao = 'A' ) then
//			
//			if Not this.of_grava_delivery( ref ls_log ) Then return false
//			
//		ENd if
		
		If Not lb_pedido Then
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_log = ''
			
			If Not gf_ge501_RollBack(SQLCA) Then Return False
			If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
			
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End If
		
		// G - pagamento pendente
		If Not ib_Desenv and is_id_situacao <> 'G' Then
			
			//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
			iuo_comum_vtex.of_parametros_ecommerce_filial( ll_Seller, ps_rede_filial, is_id_ecommerce, ref ls_log )
			
			If ls_Log <> '' and not isnull(ls_Log) Then
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				
				If Not gf_ge501_RollBack(SQLCA) Then Return False
				If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
				
				Continue
			end if
			
			If is_tipo_pedido = 'MGZ' Then
				ls_Interface = is_id_interface + 'MGZ-MGZ-LU-' + ls_nr_pedido + '/start-handling'
			Elseif is_Forma_Pagto = 'CV' Then
				ls_Interface = is_id_interface + 'CNV-' + ls_nr_pedido + '/start-handling'
			Else
				ls_Interface = is_id_interface + is_tipo_pedido + '-' + ls_nr_pedido + '/start-handling'
			End If
						
			//HANDLING para o site
			iuo_comum_vtex.of_post( '', ls_Interface , ref ls_retorno, ref ls_log ) 		
			
			If ls_Log <> '' and not isnull(ls_Log) Then
				If Pos(ls_log, 'Order status should be ready-for-handling',1) > 0 Then
					
					ls_log_bkp = ls_log
					ls_log = ''
					
					//Busca as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido no Ecommerce.
					If is_tipo_pedido = 'MGZ' Then
						iuo_comum_vtex.of_get( 'api/oms/pvt/orders/MGZ-MGZ-LU-' +  + ls_nr_pedido, ref ls_retorno, ref ls_log )
					Elseif is_Forma_Pagto = 'CV' Then
						iuo_comum_vtex.of_get( 'api/oms/pvt/orders/CNV-' +  + ls_nr_pedido, ref ls_retorno, ref ls_log )
					else
						iuo_comum_vtex.of_get( 'api/oms/pvt/orders/' + is_tipo_pedido + '-' + ls_nr_pedido, ref ls_retorno, ref ls_log )
					end if
					
					If ls_Log = '' or isnull(ls_Log) Then
						//Verifica o status. Se tiver Handling, ignora o log de erro e segue o processo
						if this.of_valida_status_pedido( ls_nr_pedido, ls_retorno ) = True Then
							ls_log = ''
						else
							
							ls_log = 'Aguardando atualiza$$HEX2$$e700e300$$ENDHEX$$o do status do pedido no seller da VTEX.'
							
						end if
					end if
				end if
			end if	
						
			If ls_Log <> '' and not isnull(ls_Log) Then
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				
				//sqlca.of_RollBack( )
				//itr_filial.of_rollback( )
				
				If Not gf_ge501_RollBack(SQLCA) Then Return False
				If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
				
				Continue
			end if
		End If
					
		//itr_filial.of_commit( )
		//sqlca.of_commit( )
		
		If Not gf_ge501_commit(iuo_comum_vtex.itr_filial) Then Return False
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		if Not iuo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
	next
			
	If Not this.of_desconecta_filial( ) Then Return false
			
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_Situacao = 'E'
		
		//sqlca.of_rollback( )
		//itr_filial.of_rollback( )
		
		gf_ge501_RollBack(SQLCA)
		gf_ge501_RollBack(iuo_comum_vtex.itr_filial)
		
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
			// Marca o log como processado
			If Not iuo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
	
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )
	
	this.of_desconecta_filial( )
		
	destroy(ids_pedidos)
	destroy(iuo_comum_vtex)
	
	Close(w_Ge501_Aguarde)
	
End try

return true
end function

public subroutine of_limpa_variaveis ();
ids_produtos.reset()

setnull(idh_validade_entrega_cotacao)
setnull(is_nr_cpf)
setnull( il_cd_convenio )
setnull( il_cd_condicao_convenio )
setnull( is_cd_conveniado )
setnull(il_cd_filial_pedido)
setnull(il_nr_pedido)
setnull (is_de_descricao_filial_retirada )
setnull(il_nr_sequencial_reserva)
setnull(il_Filial_Ecommerce)
setnull(idh_estimativa_entrega)
setnull(il_cd_filial_retirada)
setnull(idc_total)
setnull(idc_frete) 
setnull(idc_valecompra)

setnull( idc_acrescimo_pagamento )
setnull( is_tipo_pedido )
setnull( is_cd_tipo_pagamento )
setnull( is_nm_transportadora_ecommerce )
setnull( is_id_cotacao )
setnull( is_id_tipo_entrega ) 
setnull( is_nr_psp_recebedor )
setnull( is_cd_autorizacao_cd )
setnull( is_id_tipo_uso_cd )
setnull( is_nome )
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
setnull(il_nr_vending_machine)
setnull(il_cd_cidade)

end subroutine

public function boolean of_desconecta_filial ();return this.iuo_comum_vtex.of_desconecta_filial( )
end function

public function boolean of_conecta_filial (ref string ps_log);if not isvalid(iuo_comum_vtex) then
	iuo_comum_vtex = create uo_ge501_comum
ENd if

//Primeiro Verifica se a filial esta na lista das filiais sem conexao:
if isvalid(ids_filiais_sem_conexao) Then
	if ids_filiais_sem_conexao.find('cd_filial = ' + string(il_cd_filial_pedido), 1, ids_filiais_sem_conexao.rowcount()) > 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(il_cd_filial_pedido) 
		return false
	end if
End if

If Not this.iuo_comum_vtex.of_conecta_filial( il_cd_filial_pedido, ref ps_log) then

	//Adiciona filial na lista de filiais com problema de conexao:
	if ids_filiais_sem_conexao.find('cd_filial = ' + string(il_cd_filial_pedido), 1, ids_filiais_sem_conexao.rowcount()) = 0 Then
		ids_filiais_sem_conexao.insertrow(1)
		ids_filiais_sem_conexao.object.cd_filial[1] = il_cd_filial_pedido
	End if
	
	return false
end if

Return True
end function

public function boolean of_atualiza_pedido (ref string ps_log);String lvs_Mensagem

Decimal 	ldc_Perc_Desconto
	
If idc_Produtos_Calculado = 0 Then
	ldc_perc_desconto = 100
//	ps_log = is_objeto + ' Pedido sem produto'
//	Return False

else

	ldc_Perc_Desconto = Round(((idc_Desconto / idc_Subtotal) * 100), 2)

	
End If

If ldc_Perc_Desconto < 0 or isnull(ldc_perc_desconto) Then ldc_Perc_Desconto = 0.00
 
//Aualiza na Filial
update pedido_drogaexpress
Set vl_total_produtos = :idc_Produtos_Calculado, 
	 pc_desconto 		= :ldc_Perc_Desconto, 
	 vl_desconto 		= :idc_Desconto,
	 vl_total_pedido    = :idc_Total,
	 nr_sequencial_cliente_caixa = :il_nr_sequencial_reserva
Where nr_pedido_drogaexpress = :is_nr_pedido_filial
Using iuo_comum_vtex.itr_filial;

If iuo_comum_vtex.itr_filial.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido ~n' + 'Problemas ao atualizar a tabela "pedido_drogaexpress": ~n' + iuo_comum_vtex.itr_filial.sqlerrtext
	Return False
End If

//Atualiza na Matriz
Update pedido_ecommerce
	Set nr_pedido_drogaexpress 	= :is_nr_pedido_filial,
		 id_situacao = :is_id_situacao,
		 nr_cep_ent = :is_CEP_Ent,
		 nr_sequencial_cliente_caixa = :il_nr_sequencial_reserva
Where cd_filial_ecommerce =:il_Filial_Ecommerce
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

public function boolean of_verifica_cliente_clube (ref string ps_log);Select cd_cliente
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

public function boolean of_valida_status_pedido (string ps_nr_pedido, string ps_json);string ls_status
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

public function boolean of_grava_receita (ref string ps_log);long ll_for, ll_linhas

long ll_cd_produto
long ll_nr_sequencial
long ll_existe

string ls_nm_cliente 
string ls_sexo 
string ls_de_endereco 
string ls_nr_endereco
string ls_de_complemento
string ls_de_bairro
string ls_nm_cidade
string ls_nr_cep
string ls_cd_uf
string ls_nr_doc
string ls_orgao
string ls_nr_fone
string ls_nr_token

datetime ldh_nascimento 

dc_uo_ds_base lds_dados

lds_dados = create dc_uo_ds_base
lds_dados.of_changedataobject( 'ds_ge501_pedido_loja_receita')

ll_linhas = lds_dados.retrieve(il_Filial_Ecommerce, il_nr_pedido )

if ll_linhas < 0 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_receita ~n' + 'Problemas ao consultar a datawindow "ds_ge501_pedido_loja_receita".'
	return false
end if			
			
//N$$HEX1$$e300$$ENDHEX$$o possui receita
if ll_linhas = 0 then return true

for ll_for = 1 to ll_linhas
	
	ll_existe = 0
	
	ll_cd_produto = lds_dados.object.cd_produto[ll_for]
	ll_nr_sequencial = lds_dados.object.nr_sequencial[ll_for]
	ls_nm_cliente = lds_dados.object.nm_cliente[ll_for]
	ldh_nascimento = lds_dados.object.dh_nascimento[ll_for]
	ls_sexo = lds_dados.object.id_sexo[ll_for]
	ls_de_endereco = lds_dados.object.de_endereco[ll_for]
	ls_nr_endereco = lds_dados.object.nr_endereco[ll_for]
	ls_de_complemento = lds_dados.object.de_complemento[ll_for]
	ls_de_bairro = lds_dados.object.de_bairro[ll_for]
	ls_nm_cidade = lds_dados.object.nm_cidade[ll_for]
	ls_nr_cep = lds_dados.object.nr_cep[ll_for]
	ls_cd_uf = lds_dados.object.cd_unidade_federacao[ll_for]
	ls_nr_doc = lds_dados.object.nr_doc_identificacao[ll_for]
	ls_orgao = lds_dados.object.de_orgao_emissor_rg[ll_for]
	ls_nr_fone = lds_dados.object.nr_fone[ll_for]
	ls_nr_token = lds_dados.object.nr_token[ll_for]
	
	Select Count(*)
	into :ll_existe
	from produto_pedido_droga_receita
	where nr_pedido_drogaexpress = :is_nr_pedido_filial
	and cd_produto = :ll_cd_produto
	and nr_sequencial = :ll_nr_sequencial
	Using iuo_comum_vtex.itr_filial; 
	
	if iuo_comum_vtex.itr_filial.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_receita ~n' + 'Problemas ao consultar registro na tabela "produto_pedido_droga_receita": ~n' + iuo_comum_vtex.itr_filial.sqlerrtext
		return false
	end if		
	
	if ll_existe = 0 or isnull(ll_existe) Then
		Insert into produto_pedido_droga_receita(nr_pedido_drogaexpress,   
															cd_produto,   
															nr_sequencial,   
															nm_cliente,   
															dh_nascimento,   
															id_sexo,   
															de_endereco,   
															nr_endereco,   
															de_complemento,   
															de_bairro,   
															nm_cidade,   
															nr_cep,   
															cd_unidade_federacao,   
															nr_doc_identificacao,   
															de_orgao_emissor_rg,   
															nr_fone,   
															nr_token ) 
	
	Values( :is_nr_pedido_filial,
				:ll_cd_produto,
				:ll_nr_sequencial,
				:ls_nm_cliente,
				:ldh_nascimento,
				:ls_sexo,
				:ls_de_endereco,
				:ls_nr_endereco,
				:ls_de_complemento,
				:ls_de_bairro,
				:ls_nm_cidade,
				:ls_nr_cep,
				:ls_cd_uf,
				:ls_nr_doc,
				:ls_orgao,
				:ls_nr_fone,
				:ls_nr_token)
		Using iuo_comum_vtex.itr_filial;
				
	if iuo_comum_vtex.itr_filial.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_receita ~n' + 'Problemas ao inserir registro na tabela "produto_pedido_droga_receita": ~n' + iuo_comum_vtex.itr_filial.sqlerrtext
		return false
	end if			
			
	End if
next

if Not this.of_valida_receita( ref ps_log ) then return false

return true
end function

public function boolean of_grava_produto (ref string ps_log, boolean pb_filial_hub);Decimal 	ldc_Perc_Desconto,&
			ldc_Preco_Praticado,&
			ldc_Preco_Liquido, ldc_preco, &
			ldc_vl_preco_maximo_pbm, ldc_vl_reposicao_pbm
String ls_descricao
long ll_linhas, ll_for, ll_qtde, ll_requisicao_manip, ll_cd_produto, ll_sequencial, ll_cd_pbm, ll_Qtde_total, ll_cd_produto_ant

String ls_id_campanha_exclusiva_pbm
String ls_nr_campanha_pbm
String ls_id_usa_desconto_pbm
String ls_cd_conveniado_pbm
String ls_cd_produto_regra_pbm
String ls_nr_autorizacao_pbm

ll_linhas = ids_produtos.retrieve(il_Filial_Ecommerce, il_nr_pedido )

if ll_linhas < 0 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext
	return false
end if

idc_Produtos_Calculado = 0
ll_cd_produto_ant = 0

for ll_for = 1 to ll_linhas
	ll_Qtde_total = 0
	
	ldc_Preco_Liquido	 	= ids_produtos.object.vl_preco_promocao	[ll_for]
	ldc_preco 				= ids_produtos.object.vl_preco					[ll_for]
	ll_qtde 					= ids_produtos.object.qt_pedida				[ll_for]
	ll_requisicao_manip 	= ids_produtos.object.nr_requisicao_manip[ll_for]
	ll_cd_produto 			= ids_produtos.object.cd_produto				[ll_for]
	ll_sequencial 			= ids_produtos.object.nr_sequencial			[ll_for]
	ls_descricao 			= ids_produtos.object.nm_produto			[ll_for]
	ldc_Perc_Desconto 	= ids_produtos.object.pc_desconto			[ll_for]
	ls_id_campanha_exclusiva_pbm = ids_produtos.object.id_campanha_exclusiva_pbm [ll_for]
	ls_nr_campanha_pbm = ids_produtos.object.nr_campanha_pbm	[ll_for]
	ls_id_usa_desconto_pbm = ids_produtos.object.id_usa_desconto_pbm[ll_for]
	ll_cd_pbm				= ids_produtos.object.cd_pbm					[ll_for]
	ls_cd_conveniado_pbm	= ids_produtos.object.cd_conveniado_pbm[ll_for]
	ls_nr_autorizacao_pbm	= ids_produtos.object.nr_autorizacao_pbm[ll_for]
	ls_cd_produto_regra_pbm = ids_produtos.object.cd_produto_regra_pbm[ll_for]
	ldc_vl_preco_maximo_pbm = ids_produtos.object.vl_preco_maximo_pbm[ll_for]
	ldc_vl_reposicao_pbm = ids_produtos.object.vl_reposicao_pbm[ll_for]
	
   If IsNull(ldc_Perc_Desconto) Then ldc_Perc_Desconto = 0.00

	ldc_Preco_Praticado = Round( (ldc_preco * ((100 - ldc_Perc_Desconto) / 100) ),2)
	
	//If ldc_Preco_Praticado = 0.01 Then ldc_Preco_Praticado = 0.00

	If (ldc_Preco_Praticado <> ldc_Preco_Liquido) Then
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
			de_produto,
			qt_faturada,
			id_campanha_exclusiva_pbm,
			nr_campanha_pbm,
			cd_pbm,
			id_usa_desconto_pbm,
			cd_conveniado_pbm,
			nr_autorizacao_pbm,
			cd_produto_regra_pbm,
			vl_preco_maximo_pbm,
			vl_reposicao_pbm)
	VALUES (:is_nr_pedido_filial,					//nr_pedido_drogaexpress,   
			:ll_cd_produto,						//cd_produto,   
			:ll_sequencial, 					//nr_sequencial
			:ll_Qtde,							//qt_pedida,   
			:ldc_preco,						//vl_preco_tabela,   
			:ldc_Perc_Desconto,			//pc_desconto_tabela,   
			:ldc_Preco_Liquido,		//vl_preco_praticado,   
			'N',								//id_alteracao_preco,   
			'N',								//id_restricao_convenio,   
			:ldc_Preco_Liquido,		//vl_preco_tabela_liquido,   
			null,								//qt_pontos_clube                        ?????????
			:ll_requisicao_manip,	//nr_requisicao_manip
			:ls_descricao,
			0,			//de_produto usado para produto manipulado acabado - sem requisicao
			:ls_id_campanha_exclusiva_pbm,
			:ls_nr_campanha_pbm,
			:ll_cd_pbm,
			:ls_id_usa_desconto_pbm,
			:ls_cd_conveniado_pbm,
			:ls_nr_autorizacao_pbm,
			:ls_cd_produto_regra_pbm,
			:ldc_vl_preco_maximo_pbm,
			:ldc_vl_reposicao_pbm)
	Using iuo_comum_vtex.itr_filial;
			
	if iuo_comum_vtex.itr_filial.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao inserir registro na tabela "produto_pedido_drogaexpress": ~n' + iuo_comum_vtex.itr_filial.sqlerrtext
		return false
	end if
			
	// S$$HEX1$$f300$$ENDHEX$$ vai gerar pedido empurrado para filiais hub ou para filiais que usam saldo virtual do estoque central:
	If (pb_filial_hub = True or iuo_comum_vtex.ib_usa_saldo_virtual = True) and is_id_situacao = 'A' and ll_cd_produto <> ll_cd_produto_ant Then
		
		//Somo a quantidade pedida total do produto, para caso houver mais de uma linha no pedido com o mesmo produto.
		Select sum(qt_pedida)
		into :ll_Qtde_total
		from pedido_ecommerce_produto
		where cd_filial_ecommerce = :il_Filial_Ecommerce
		and nr_pedido = :il_nr_pedido
		and cd_produto = :ll_cd_produto
		Using SQLCA;
		
		if SQLCA.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produto ~n' + 'Problemas ao consultar a tabela "pedido_ecommerce_produto": ~n' + SQLCA.sqlerrtext
			return false
		end if
		
		If Not this.of_processa_pedido_empurrado( ll_cd_produto, ll_Qtde_total, ref ps_log ) Then return false
	End If
		
	if ll_cd_produto_ant = 0 or ll_cd_produto <> ll_cd_produto_ant Then
		ll_cd_produto_ant = ll_cd_produto
	ENd if		
		
Next
	
Return True
end function

public function boolean of_grava_pedido (string ps_nr_pedido, ref string ps_log, string ps_rede);Decimal ldc_Pc_Desconto

DateTime ldt_Movimentacao

String ls_Hora,&
	   	ls_Venda_Clube,&
	   	ls_Mensagem,&
	   	ls_Pedido,&
	   	ls_Endereco,&
	   	ls_Nulo,&
	   	ls_Pedido_Inicial,&	   	
		ls_Observacao, ls_nr_Pedido_inicial, ls_tipo_vale, ls_Achou, ls_cd_tipo_venda, ls_cd_conveniado

Long ll_Sequencial, ll_existe, ll_cd_convenio, ll_cd_condicao_conv

Integer li_Pos

// Se j$$HEX1$$e100$$ENDHEX$$ existe pedido drogaexpress com o mesmo nr_pedido_ecommerce, n$$HEX1$$e300$$ENDHEX$$o inclui e retorna false
SELECT count(*)
INTO :ll_existe
FROM pedido_drogaexpress
WHERE nr_pedido_ecommerce = :il_nr_pedido
	AND cd_filial_ecommerce 	= :il_Filial_Ecommerce
USING iuo_comum_vtex.itr_filial;

If iuo_comum_vtex.itr_filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Problemas ao consultar a tabela "pedido_drogaexpress": ~n'  + iuo_comum_vtex.itr_filial.sqlerrtext
	return false
end if

//If ll_existe > 0 Then
//	ps_log = 'Problemas ao consultar a tabela "pedido_drogaexpress": ~n'  + itr_filial.sqlerrtext
//	return false
//end if

SetNull(ls_Nulo)

ldt_Movimentacao = gf_GetServerDate()

ls_Hora = String(Hour( time(ldt_Movimentacao) ), "00")

//ls_Endereco = RightTrim(Mid(is_Endereco_Ent, 1, 50)) + ", " + is_numero_ent

ls_Endereco = is_Endereco_Ent

//N$$HEX1$$e300$$ENDHEX$$o pontuar no clube DC. Existe pontua$$HEX2$$e700e300$$ENDHEX$$o exclusiva para o farmagora.
ls_Venda_Clube = "N"

//// Localiza o pr$$HEX1$$f300$$ENDHEX$$ximo pedido do Disque Entrega

if Not gf_proximo_pedido_drogaexpress(il_cd_filial_pedido, ref is_nr_pedido_filial, ref ps_log) then return false

if is_id_situacao <> 'G' and is_tipo_pedido = 'SLR' Then
	// Cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito
	If is_forma_pagto = 'CP' Then
		If IsNull(is_Comprovante_Cartao) Then
			ps_log = "O comprovante do cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito do pedido eCommerce '" + String(il_nr_Pedido) + "' n$$HEX1$$e300$$ENDHEX$$o foi informado. "
			return false
		End If
		
		If IsNull(is_Autorizacao_Cartao) Then
			ps_log = "A autoriza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito do pedido eCommerce '" + String(il_nr_Pedido) + "' n$$HEX1$$e300$$ENDHEX$$o foi informada. "
			return false
		End If
	End If
end if

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
is_complemento_ent = Mid(trim(is_complemento_ent), 1, 40)
is_fone_contato_ent = Mid(trim(is_fone_contato_ent), 1, 20)
is_numero_ent = Mid(trim(is_numero_ent), 1, 6)

ldc_Pc_Desconto = 0

If idc_ValeCompra > 0 Then
	ldc_Pc_Desconto = Round( ( idc_ValeCompra / idc_Total ) * 100, 2 )
	
	ls_tipo_vale = 'C'
	
End If

if is_id_ecommerce = '5' Then //Consulta Remedios
	ls_cd_tipo_venda = 'CV'
	is_Forma_Pagto = 'CV'
	ll_cd_condicao_conv = 110
	
	ls_cd_conveniado = '54708'
	ll_cd_convenio = 54708
	
Elseif is_forma_pagto = 'CV' then
	
	ls_cd_tipo_venda = 'CV'
	ll_cd_convenio = il_cd_convenio
	ll_cd_condicao_conv = il_cd_condicao_convenio
	ls_cd_conveniado = is_cd_conveniado	
	
Else
	ls_cd_tipo_venda = 'AV'
	setnull( ll_cd_convenio )
	setnull( ll_cd_condicao_conv )
	setnull( ls_cd_conveniado )
ENd if

Select cd_cliente
Into :ls_Achou
From cliente_drogaexpress
Where cd_cliente_drogaexpress = '999999'
using iuo_comum_vtex.itr_filial;	

if iuo_comum_vtex.itr_filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Problemas ao consultar o cliente_drogaexpress": ~n' + iuo_comum_vtex.itr_filial.sqlerrtext
	return false
end if

If  iuo_comum_vtex.itr_filial.sqlcode = 100 Then
	
	INSERT INTO cliente_drogaexpress  ( cd_cliente_drogaexpress,   
													  nm_cliente,   
													  de_endereco,   
													  de_referencia,   
													  de_bairro,   
													  nr_cep )  
  	VALUES ( '999999',   'CLIENTE ECOMMERCE',   '***',   '***', '***',  '89201400' )
	Using iuo_comum_vtex.itr_filial;
	
	if iuo_comum_vtex.itr_filial.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Problemas ao incluir o cliente_drogaexpress": ~n' + iuo_comum_vtex.itr_filial.sqlerrtext
		return false
	end if
End If

If is_exige_nfse  = 'S' Then

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
			nm_cliente_cheque,
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
			id_plataforma_ecommerce,
			dh_compra,
			id_exige_nfse,
			nr_vending_machine,
			cd_cidade_entrega,
			id_cpf_nf,
			cd_psp_recebedor,
			cd_autorizacao_cd,
			id_tipo_uso_cd,
			nm_transportadora_ecommerce,
			id_tipo_pedido,
			nr_cpf_pbm,
			dh_validade_cotacao_entrega,
			cd_convenio,
			cd_conveniado,
			cd_condicao_convenio,
			vl_acrescimo,
			cd_filial_retirada,
			dh_estimativa_entrega,
			de_descricao_filial_retirada)
	Values( :is_nr_pedido_filial,							//nr_pedido_drogaexpress,   
			:il_cd_filial_pedido,					//cd_filial,   
			:ldt_Movimentacao,				//dh_emissao,   
			:ls_Hora,							//hr_emissao,   
			'999999',								//cd_cliente_drogaexpress,   
			0,										//vl_total_produtos,   
			:ldc_Pc_Desconto,					//pc_desconto,   
			:idc_Total,							//vl_total_pedido,   
			:idc_Frete,							//tevl_taxa_entrega,   
			0,										//vl_cobrar,   
			0,										//vl_pago,   
			:is_id_situacao,						//id_situacao,   
			:ls_cd_tipo_venda,					//cd_tipo_venda,   
			:is_Forma_Pagto,		//cd_forma_pagamento,   
			'14330',								//nr_matricula_vendedor,   
			'14330',								//nr_matricula_operador,   
			'CF',									//de_especie_doc_fiscal,   
			:is_nr_cartao_credito ,					//nr_cartao_credito,   
			:is_cd_cliente_clube,				//cd_cliente,   
			:ls_Observacao,					//de_observacao,   
			:ls_Endereco,						//de_endereco_entrega,   
			:is_Referencia_Ent,				//de_referencia_entrega,   
			:is_Bairro_Ent,					//de_bairro_entrega,   
			:is_Fone_Ent,						//nr_telefone_entrega,   
			:ls_Venda_Clube,					//id_venda_clube,   
			:is_nr_cpf,						//nr_cpf_cheque,   
			:is_nome,
			:il_nr_Pedido,							//nr_pedido_ecommerce,
			:is_Nome_Ent,						//nm_cliente_entrega,
			:is_Cep_Ent,						//nr_cep_entrega,
			:ii_Parcelas,						//nr_parcelas_pagamento,
			:is_Bandeira_Cartao,         	// nm_administradora_cartao
			:is_Transportadora,				// nm_transportadora
			:is_Cidade_Ent,					// nm_cidade_entrega
			:is_UF_Ent,							// cd_uf_entrega
			:is_comprovante_cartao,		// nr_comprovante_cartao_credito,
			:is_autorizacao_cartao,			// nr_autorizacao_cartao_credito
			:is_Estabelecimento,				// cd_estabelecimento_cartao_credito
			:is_Bloqueto,						// nr_boleto_bancario
			0,										// vl_vale_compra
			:is_Complemento_Ent,			// de_complemento_endereco
			:is_Fone_Contato_Ent,			// nr_telefone_contato
			:il_Filial_Ecommerce,							//cd_filial_ecommerce
			:is_numero_ent,					//nr_endereco_entrega
			:ls_tipo_vale,                        //id_tipo_vale
			:is_Via_PBM,						// de_via_pbm
			:ps_rede,
			:is_Email,
			:ps_nr_pedido,
			'2',
			:idh_compra,
			:is_exige_nfse,
			:il_nr_vending_machine,
			:il_cd_cidade,
			'S',
			:is_nr_psp_recebedor,
			:is_cd_autorizacao_cd,
			:is_id_tipo_uso_cd,
			:is_nm_transportadora_ecommerce,
			:is_tipo_pedido,
			:is_nr_cpf_pbm,
			:idh_validade_entrega_cotacao,
			:ll_cd_convenio,
			:ls_cd_conveniado,
			:ll_cd_condicao_conv,
			:idc_acrescimo_pagamento,
			:il_cd_filial_retirada,
			:idh_estimativa_entrega,
			:is_de_descricao_filial_retirada)
	using iuo_comum_vtex.itr_filial;	

Else
	
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
		nm_cliente_cheque,
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
		id_plataforma_ecommerce,
		dh_compra,
		nr_vending_machine,
		cd_cidade_entrega,
		id_cpf_nf,
		cd_psp_recebedor,
		cd_autorizacao_cd,
		id_tipo_uso_cd,
		nm_transportadora_ecommerce,
		id_tipo_pedido,
		nr_cpf_pbm,
		dh_validade_cotacao_entrega,
		cd_convenio,
		cd_conveniado,
		cd_condicao_convenio,
		vl_acrescimo,
		cd_filial_retirada,
		dh_estimativa_entrega,
		de_descricao_filial_retirada)
	Values( :is_nr_pedido_filial,							//nr_pedido_drogaexpress,   
			:il_cd_filial_pedido,					//cd_filial,   
			:ldt_Movimentacao,				//dh_emissao,   
			:ls_Hora,							//hr_emissao,   
			'999999',								//cd_cliente_drogaexpress,   
			0,										//vl_total_produtos,   
			:ldc_Pc_Desconto,					//pc_desconto,   
			:idc_Total,							//vl_total_pedido,   
			:idc_Frete,							//tevl_taxa_entrega,   
			0,										//vl_cobrar,   
			0,										//vl_pago,   
			:is_id_situacao,						//id_situacao,   
			:ls_cd_tipo_venda,					//cd_tipo_venda,   
			:is_Forma_Pagto,		//cd_forma_pagamento,   
			'14330',								//nr_matricula_vendedor,   
			'14330',								//nr_matricula_operador,   
			'CF',									//de_especie_doc_fiscal,   
			:is_nr_cartao_credito ,					//nr_cartao_credito,   
			:is_cd_cliente_clube,				//cd_cliente,   
			:ls_Observacao,					//de_observacao,   
			:ls_Endereco,						//de_endereco_entrega,   
			:is_Referencia_Ent,				//de_referencia_entrega,   
			:is_Bairro_Ent,					//de_bairro_entrega,   
			:is_Fone_Ent,						//nr_telefone_entrega,   
			:ls_Venda_Clube,					//id_venda_clube,   
			:is_nr_cpf,						//nr_cpf_cheque,   
			:is_nome,
			:il_nr_Pedido,							//nr_pedido_ecommerce,
			:is_Nome_Ent,						//nm_cliente_entrega,
			:is_Cep_Ent,						//nr_cep_entrega,
			:ii_Parcelas,						//nr_parcelas_pagamento,
			:is_Bandeira_Cartao,         	// nm_administradora_cartao
			:is_Transportadora,				// nm_transportadora
			:is_Cidade_Ent,					// nm_cidade_entrega
			:is_UF_Ent,							// cd_uf_entrega
			:is_comprovante_cartao,		// nr_comprovante_cartao_credito,
			:is_autorizacao_cartao,			// nr_autorizacao_cartao_credito
			:is_Estabelecimento,				// cd_estabelecimento_cartao_credito
			:is_Bloqueto,						// nr_boleto_bancario
			0,										// vl_vale_compra
			:is_Complemento_Ent,			// de_complemento_endereco
			:is_Fone_Contato_Ent,			// nr_telefone_contato
			:il_Filial_Ecommerce,							//cd_filial_ecommerce
			:is_numero_ent,					//nr_endereco_entrega
			:ls_tipo_vale,                        //id_tipo_vale
			:is_Via_PBM,						// de_via_pbm
			:ps_rede,
			:is_Email,
			:ps_nr_pedido,
			'2',
			:idh_compra,
			:il_nr_vending_machine,
			:il_cd_cidade,
			'S',
			:is_nr_psp_recebedor,
			:is_cd_autorizacao_cd,
			:is_id_tipo_uso_cd ,
			:is_nm_transportadora_ecommerce,
			:is_tipo_pedido,
			:is_nr_cpf_pbm,
			:idh_validade_entrega_cotacao,
			:ll_cd_convenio,
			:ls_cd_conveniado,
			:ll_cd_condicao_conv,
			:idc_acrescimo_pagamento,
			:il_cd_filial_retirada,
			:idh_estimativa_entrega,
			:is_de_descricao_filial_retirada)
	using iuo_comum_vtex.itr_filial;	
	
End If

if iuo_comum_vtex.itr_filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Problemas ao inserir registro na tabela "pedido_drogaexpress": ~n' + iuo_comum_vtex.itr_filial.sqlerrtext
	return false
end if

Return True
end function

public function boolean of_valida_receita (ref string ps_log);long ll_existe

select count(*)
into :ll_existe
from produto_pedido_droga_receita
where nr_pedido_drogaexpress = :is_nr_pedido_filial
Using iuo_comum_vtex.itr_filial;

if iuo_comum_vtex.itr_filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_receita ; Problemas ao consultar a tabela "produto_pedido_droga_receita": ' + iuo_comum_vtex.itr_filial.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar os dados da receita no banco da loja.'
	return false
end if

return true
end function

public function boolean of_grava_reserva (boolean pb_filial_hub, ref string ps_log);String ls_Nome, ls_Matricula, ls_Tipo_Cliente_Caixa

Long ll_Nr_Sequencial, ll_Linhas, ll_row
Long ll_Produto, ll_Qtde

//N$$HEX1$$e300$$ENDHEX$$o gravar reserva se for filial HUB
//if pb_filial_hub = True then return true

//Somente gravar reserva se o tipo de entrega for Retirada em loja/Motoboby/armario inteligente/biker delivery:
if is_id_tipo_entrega = 'MOT' or is_id_tipo_entrega = 'RET' or is_id_tipo_entrega = 'ARM'  or is_id_tipo_entrega = 'BID' Then

	if isnull(is_id_situacao) Then is_id_situacao = ''
	if isnull(il_id_pagamento) Then il_id_pagamento = 0
	
	ls_Nome						= 'PED. ECOMMERCE'
	ls_Matricula 				= '14330'
	ls_Tipo_Cliente_Caixa 	= 'R'
	
	select nextval('dbo.cliente_caixa_nr_sequencial_seq')
	Into :ll_Nr_Sequencial
	From parametro
	where id_parametro = '1'
	Using iuo_comum_vtex.itr_Filial;
	
	If IsNull(ll_Nr_Sequencial) or ll_nr_sequencial = 0 Then ll_Nr_Sequencial = 1
	
	If iuo_comum_vtex.itr_Filial.SQLCode = -1 Then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_reserva ; Problemas ao localizar o sequencial da cliente_caixa: ' + iuo_comum_vtex.itr_Filial.sqlerrtext 
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
		Using iuo_comum_vtex.itr_Filial;
	
	If iuo_comum_vtex.itr_Filial.SQLCode = -1 Then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_reserva ; Problemas ao incluir registro na "cliente_caixa": ' + iuo_comum_vtex.itr_Filial.sqlerrtext 
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
		) Using iuo_comum_vtex.itr_Filial;
		
		If iuo_comum_vtex.itr_Filial.SQLCode = -1 Then
			ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_reserva ; Problemas ao incluir registro na "cliente_caixa_produto": ' + iuo_comum_vtex.itr_Filial.sqlerrtext 
			Return False
		End IF
		
	Next
	
	il_nr_sequencial_reserva = ll_Nr_Sequencial

End if

Return True
end function

public function boolean of_grava_comp_venda (ref string ps_log);//A fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_comp_venda tamb$$HEX1$$e900$$ENDHEX$$m $$HEX1$$e900$$ENDHEX$$ chamado no objeto uo_ge501_pedido_ecommerce

return this.of_grava_comp_venda(iuo_comum_vtex.itr_filial, is_id_situacao, il_nr_pedido, il_cd_filial_pedido, idc_total, ii_parcelas, is_estabelecimento, is_bandeira_cartao, is_nr_nsu, is_autorizacao_cartao, is_cd_autorizacao_cd, is_nr_cartao_credito, is_nr_psp_recebedor, is_id_tipo_uso_cd, is_forma_pagto, ref ps_log)

end function

public function boolean of_saldo_produto_reservado (long pl_cd_filial, long pl_nr_pedido, long pl_cd_produto, ref long pl_qt_saldo_pendente, ref string ps_log);long ll_saldo,ll_saldo_pedidos

TRY
	
	// PEGA SOMENTE OS PEDIDOS QUE AINDA N$$HEX1$$c300$$ENDHEX$$O FORAM EXPORTADOS PARA A LOJA
	SELECT COALESCE( SUM( pep.qt_pedida ), 0 )
	INTO :ll_saldo
	FROM pedido_ecommerce pe
		INNER JOIN pedido_ecommerce_produto pep
			ON pep.nr_pedido = pe.nr_pedido
	WHERE pe.dh_compra >= (select DATEADD (day , -30 , dh_movimentacao ) from parametro where id_parametro = '1')
	AND pe.cd_filial			= :pl_cd_filial
	AND pe.nr_pedido		<> :pl_nr_pedido
	AND pe.id_situacao	in ('A','G')
	AND pe.nr_pedido_ecommerce is not null
	AND pep.cd_produto	= :pl_cd_Produto
	AND pe.nr_pedido_drogaexpress is null // PEDIDOS AINDA N$$HEX1$$c300$$ENDHEX$$O EXPORTADOS
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_produto_reservado ~n' + 'Problemas ao consultar o saldo pendente do produto: ~n' + sqlca.sqlerrtext
		Return False		
	End If
	
	if isnull(ll_saldo) then ll_saldo = 0
	
	//Verificar se h$$HEX1$$e100$$ENDHEX$$ pedidos gerados ap$$HEX1$$f300$$ENDHEX$$s a ultima atualizacao de saldo da filial:
	select COALESCE( sum(pp.qt_pedida), 0 )
	into :ll_saldo_pedidos
	from pedido_ecommerce pe
		inner join pedido_ecommerce_produto pp on pp.cd_filial_ecommerce = pe.cd_filial_ecommerce and pp.nr_pedido = pe.nr_pedido 
		inner join filial f on f.cd_filial = pe.cd_filial 
		inner join ecommerce_rede_filial er on er.id_ecommerce = pe.id_ecommerce and er.id_rede_filial = f.id_rede_filial and er.cd_filial = f.cd_filial 
	where pe.cd_filial = :pl_cd_filial
	and pe.dh_compra > er.dh_busca_saldo_loja 
	and pp.cd_produto = :pl_cd_Produto
	and pe.nr_pedido_drogaexpress is not null
	and pe.nr_pedido <> :pl_nr_pedido;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_produto_reservado ~n' + 'Problemas ao consultar o saldo pendente do produto(2): ~n' + sqlca.sqlerrtext
		Return False		
	End If
	
	if isnull(ll_saldo_pedidos) then ll_saldo_pedidos = 0
	
	pl_qt_Saldo_Pendente = ll_saldo + ll_saldo_pedidos
	
FINALLY
	
	If IsNull( pl_qt_Saldo_Pendente ) Then pl_qt_Saldo_Pendente = 0
	
END TRY

Return True
end function

public function boolean of_saldo_disponivel_distrib (long pl_cd_filial, long pl_cd_produto, string ps_distribuidora, string ps_chamada, ref decimal pdc_fator_conversao, ref long pl_qt_saldo, ref string ps_log);/* Argumento ps_chamada: SALDO (Quando est$$HEX1$$e100$$ENDHEX$$ enviando saldo para a Vannon) ou PEDIDO (Quando est$$HEX1$$e100$$ENDHEX$$ relizando pedido empurrado ) 
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
		
		lo_Filial.of_Localiza_Filial(String(pl_cd_filial))
		
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
				Where fd.cd_filial = :pl_cd_filial
					and d.cd_produto = :pl_cd_Produto
					and d.cd_distribuidora	= :ps_Distribuidora
					and d.cd_unidade_federacao = :lo_Filial.Cd_Unidade_Federacao
					and coalesce(f.id_atende_pedido_ecommerce, 'N') = 'S'
					and coalesce(f.id_situacao, 'A') = 'A'
					and fd.id_situacao = 'A'
					and d.id_situacao = 'A'
					//and d.qt_estoque_disponivel > 0
					//and coalesce(d.id_estoque_maior_10dias, 'N') = 'S'
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
				Where  fd.cd_filial = :pl_cd_filial
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
		
		SELECT	dbo.saldo_atual_estoque_central( :pl_cd_filial, :pl_cd_produto, 'S'),
					COALESCE( g.vl_fator_conversao, 1 ) as vl_fator_conversao
			INTO	:ll_Saldo,
					:pdc_Fator_Conversao
		  FROM vw_saldo_atual_produto s
				INNER JOIN produto_geral g
					ON g.cd_produto = s.cd_produto
		WHERE s.cd_filial = :pl_cd_filial
			AND s.cd_produto = :pl_cd_produto
		Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_disponivel_distrib ~n' + 'Problemas ao consultar a view "vw_saldo_atual_produto": ~n' + sqlca.sqlerrtext
			return false
		end if
	
	End If
	
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

public function boolean of_processa_pedido_empurrado (long pl_cd_filial, long pl_cd_filial_ecommerce, long pl_nr_pedido, long pl_cd_produto, long pl_qtde, ref string ps_log);//****************************************************************************************************//
//of_processa_pedido_empurrado
//****************************************************************************************************//
//Objetivo:
//****************************************************************************************************//
//-> Verificar se a loja possui saldo suficiente para atender a quantidade solicitada para o produto.
// Se a loja nao possuir saldo suficiente para atender, chama processo para gravar o pedido empurrado.
//****************************************************************************************************//
//Parametros: 
//****************************************************************************************************//
//pl_cd_filial - Codigo da Filial que ir$$HEX1$$e100$$ENDHEX$$ atender o pedido
//pl_cd_filial_ecommerce - C$$HEX1$$f300$$ENDHEX$$digo filial da chave do pedido ecommerce
//pl_nr_pedido - N$$HEX1$$fa00$$ENDHEX$$mero do pedido ecommerce
//pl_cd_produto - c$$HEX1$$f300$$ENDHEX$$digo do produto solicitado
//pl_qtde - quantidade solicitada do produto
//ps_log - retorna descricao do erro ocorrido (Refer$$HEX1$$ea00$$ENDHEX$$ncia)
//****************************************************************************************************//

Long ll_Total_Pedida, ll_Saldo_Filial
Long ll_Saldo
Long ll_Qt_Empurrada, ll_Saldo_Falta
Long ll_Row, ll_Linhas
Long ll_Qtde_Pedente
Long ll_qtde_prod_pedida_total
Long ll_qt_saldo_cd

Boolean lb_usa_pedido_urgente = false

String ls_Distribuidora
String ls_parametro
Long ll_cd_filial_hub
Date ldh_Data_Atual

Try

	ldh_Data_Atual = Date(gf_GetServerDate())
	
	//Produto manip
	IF pl_cd_produto = 684431 Then
		Return true
	End If
	
	// qt_saldo_final => aqui considera o saldo da loja menos (reserva + pedidos pendentes
		Select coalesce(ep.qt_saldo_filial, 0)  - coalesce(ep.qt_saldo_pendente, 0) - coalesce(ep.qt_saldo_transferencia, 0) - coalesce(ep.qt_saldo_prestes, 0) + coalesce(ep.qt_saldo_virtual, 0), 
				COALESCE(er.cd_filial_hub,0)
		INTO	:ll_Saldo_Filial, :ll_cd_filial_hub		
	From ecommerce_prd_filial ep
		inner join ecommerce_rede_filial er on er.id_ecommerce = ep.id_ecommerce and er.id_rede_filial = ep.id_rede_filial and er.cd_filial = ep.cd_filial 
	Where ep.id_ecommerce = '2'
		and ep.cd_filial 			= :pl_cd_filial
		and ep.cd_produto 		= :pl_cd_produto
		and ep.id_rede_filial 	in (select id_rede_filial from filial where cd_filial =:pl_cd_filial)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = 'Problemas ao consultar a tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
		Return false
	End If
	
	If ll_Saldo_Filial < 0 Then ll_Saldo_Filial = 0
	
	// Pega a quantidade dos produtos dos pedidos que n$$HEX1$$e300$$ENDHEX$$o foram exportados para a loja
	If Not of_saldo_produto_reservado(pl_cd_filial, pl_nr_pedido, pl_cd_produto, Ref ll_Qtde_Pedente, ref ps_log) Then Return false
	
	ll_Saldo_Filial =  ll_Saldo_Filial - ll_Qtde_Pedente - pl_qtde
	
	If ll_Saldo_Filial >= 0 Then
		Return true //a loja possui saldo disponivel para atender o ped Ecommerce
	End If
	
	ll_Saldo_Falta = ll_Saldo_Filial * -1	
	
	if ll_Saldo_Falta > pl_qtde then
		ll_Saldo_Falta = pl_qtde
	End if
	
	if ll_saldo_falta > 0 Then
		
		if Not this.of_verifica_usa_pedido_urgente( pl_cd_filial, ref lb_usa_pedido_urgente, ref ps_log) then return false
		
		if lb_usa_pedido_urgente = True Then
			
			//Verifica se tem saldo no estoque central:
			If Not this.of_busca_saldo_cd( pl_cd_filial, pl_cd_produto, ref ll_qt_saldo_cd, ref ps_log) then return false
			
			if ll_cd_filial_hub = 0 or ll_qt_saldo_cd >= ll_saldo_falta Then
				//Fazer o pedido Urgente pro estoque central:
				If Not this.of_grava_pedido_empurrado(pl_cd_filial, pl_cd_filial_ecommerce, pl_nr_pedido, pl_cd_produto, ll_Saldo_Falta, true, ref ps_log ) Then return false
	
			Else 
				//Se nao tiver saldo no estoque central, gravar pedido empurrado: Somente se for filial HUB
				If Not this.of_grava_pedido_empurrado(pl_cd_filial, pl_cd_filial_ecommerce, pl_nr_pedido, pl_cd_produto, ll_Saldo_Falta, False, ref ps_log ) Then return false
			End if
			
		ELse
			
			//gravar pedido empurrado:
			If Not this.of_grava_pedido_empurrado(pl_cd_filial, pl_cd_filial_ecommerce, pl_nr_pedido, pl_cd_produto, ll_Saldo_Falta, False, ref ps_log ) Then return false
			
		End if
	ENd if

Finally
	
	if ps_log <> '' and not isnull(ps_log) then
		 ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_empurrado ~n' + ps_log
	End if
	
ENd Try

return true
end function

public function boolean of_entrega_cotacao (long pl_cd_filial, long pl_nr_pedido, string ps_id_tipo_entrega, ref string ps_id_cotacao, ref string ps_nm_transportadora, ref datetime pdh_validade, ref string ps_log);string ls_id_oferta, ls_nm_transportadora, ls_id_tipo_entrega_equilibrium
datetime ldh_validade

uo_ge509_cotacao luo_cotacao

//Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - Cotacao

Try

	if ( ps_id_tipo_entrega = 'EXP' or ps_id_tipo_entrega = 'ECM' ) Then

		Select x1.cd_oferta, x1.nm_transportadora
		into :ls_id_oferta, :ls_nm_transportadora
		from pedido_ecommerce_entrega x1
		where x1.cd_filial_ecommerce = :pl_Cd_filial
		and x1.nr_pedido = :pl_nr_pedido
		and x1.nr_sequencial = (Select max(x2.nr_sequencial) from pedido_ecommerce_entrega x2 where x2.cd_filial_ecommerce = :pl_Cd_filial and x2.nr_pedido = :pl_nr_pedido);
	
		if sqlca.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_entrega_cotacao ; Problemas ao consultar a tabela "pedido_ecommerce_entrega": ' + sqlca.sqlerrtext
			return false
		end if
	
		//Cria uma nova cota$$HEX2$$e700e300$$ENDHEX$$o se ainda n$$HEX1$$e300$$ENDHEX$$o existe:
		if ls_id_oferta = '' or isnull(ls_id_oferta) Then
			
			luo_cotacao = create uo_ge509_cotacao
			
			if ps_id_tipo_entrega = 'EXP' Then
				//Expressa
				ls_id_tipo_entrega_equilibrium = '2'
			else
				//Economica
				ls_id_tipo_entrega_equilibrium = '1'
			End if
			
			//Cria nova cota$$HEX2$$e700e300$$ENDHEX$$o
			if Not luo_cotacao.of_processa_cotacao( pl_Cd_filial, pl_nr_pedido, ls_id_tipo_entrega_equilibrium, ref ls_id_oferta, ref ls_nm_transportadora, ref ldh_validade, ref ps_log ) Then return false
		
		end if
		
		ps_id_cotacao = ls_id_oferta
		ps_nm_transportadora = ls_nm_transportadora
		pdh_validade = ldh_validade
	ENd if

Finally
	if isvalid(luo_cotacao) Then destroy(luo_cotacao)
end Try

return true
end function

public function boolean of_grava_pagamento (ref string ps_log);long ll_for
long ll_linhas
long ll_nr_sequencial=0
long ll_nr_parcelas

decimal{2} ldc_vl_forma_pagamento

String ls_nr_comp_cartao_credito
String ls_nr_autorizacao_cartao_credito
String ls_nm_administradora_cartao
String ls_cd_estabelecimento_cartao
String ls_nr_cartao_credito
String ls_cd_forma_pagamento

dc_uo_ds_base lds_dados

lds_dados = create dc_uo_ds_base

lds_dados.of_changedataobject( 'ds_ge501_pedido_loja_pagamento' )

ll_linhas = lds_dados.retrieve(il_filial_ecommerce, il_nr_pedido)

//Somente prosseguir se houver mais de 1 forma de pagamento
if ll_linhas < 2 then return true

is_forma_pagto = 'MF'

	Update pedido_drogaexpress
	set cd_forma_pagamento = 'MF', 
		nr_cartao_credito = null, 
		nm_administradora_cartao = null,
		nr_comprovante_cartao_credito = null,
		nr_autorizacao_cartao_credito = null,
		cd_estabelecimento_cartao_credito = null
	where nr_pedido_drogaexpress = :is_nr_pedido_filial
	Using iuo_comum_vtex.itr_filial;

if iuo_comum_vtex.itr_filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pagamento ~n' + 'Problemas ao atualizar tabela pedido_drogaexpress": ~n' + iuo_comum_vtex.itr_filial.sqlerrtext
	return false
end if

for ll_for = 1 to ll_linhas
	
	ll_nr_sequencial++
	
	ldc_vl_forma_pagamento = lds_dados.object.vl_forma_pagamento[ll_for]
	ll_nr_parcelas = lds_dados.object.nr_parcelas[ll_for]
	ls_nr_comp_cartao_credito = lds_dados.object.nr_comprovante_cartao_credito[ll_for]
	ls_nr_autorizacao_cartao_credito = lds_dados.object.nr_autorizacao_cartao_credito[ll_for]
	ls_nm_administradora_cartao = lds_dados.object.nm_administradora_cartao[ll_for]
	ls_cd_estabelecimento_cartao = lds_dados.object.cd_estabelecimento_cartao[ll_for]
	ls_nr_cartao_credito = lds_dados.object.nr_cartao_credito[ll_for]
	ls_cd_forma_pagamento = lds_dados.object.cd_forma_pagamento[ll_for]
	
	ls_nr_cartao_credito = Mid(trim(ls_nr_cartao_credito), 1, 19)
	ls_nm_administradora_cartao = Mid(trim(ls_nm_administradora_cartao), 1, 40)
	ls_nr_comp_cartao_credito = Mid(trim(ls_nr_comp_cartao_credito), 1, 20)
	ls_nr_autorizacao_cartao_credito = Mid(trim(ls_nr_autorizacao_cartao_credito), 1, 10)
	ls_cd_estabelecimento_cartao = Mid(trim(ls_cd_estabelecimento_cartao), 1, 10)

	insert into pedido_drogaexpress_pagamento( nr_pedido_drogaexpress, 
															nr_sequencial, 
															cd_forma_pagamento, 
															nr_cartao_credito, 
															nm_administradora_cartao,
															nr_parcelas,
															nr_autorizacao,
															nr_comprovante_nsu,
															cd_estabelecimento_tef,
															vl_pagamento)
	values ( :is_nr_pedido_filial,
				:ll_nr_sequencial,
				:ls_cd_forma_pagamento,
				:ls_nr_cartao_credito,
				:ls_nm_administradora_cartao,
				:ll_nr_parcelas,
				:ls_nr_autorizacao_cartao_credito,
				:ls_nr_comp_cartao_credito,
				:ls_cd_estabelecimento_cartao,
				:ldc_vl_forma_pagamento)
	Using iuo_comum_vtex.itr_filial;
	
	if iuo_comum_vtex.itr_filial.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pagamento ~n' + 'Problemas ao incluir na pedido_drogaexpress_pagamento": ~n' + iuo_comum_vtex.itr_filial.sqlerrtext
		return false
	end if
	
	// Grava adiantamento quando for pagamento: PIX/PICPAY, ou quando for pedido Gototem, ou pedido Magazine Luiza.	
	If ls_cd_forma_pagamento = 'PIX' or ls_cd_forma_pagamento = 'PIX ECOMMERCE' or is_tipo_pedido = 'GTM' or is_tipo_pedido = 'MGZ' or ls_cd_forma_pagamento = 'PICPAY ECOMMERCE' Then
		If Not this.of_grava_comp_venda(iuo_comum_vtex.itr_filial, is_id_situacao, il_nr_pedido, il_cd_filial_pedido, ldc_vl_forma_pagamento, ll_nr_parcelas, ls_cd_estabelecimento_cartao, ls_nm_administradora_cartao, ls_nr_comp_cartao_credito, ls_nr_autorizacao_cartao_credito, is_cd_autorizacao_cd, ls_nr_cartao_credito, is_nr_psp_recebedor, is_id_tipo_uso_cd,is_forma_pagto, ref ps_log) then return false
	end if
	
Next	
	
return true
end function

public function boolean of_verifica_situacao_filial (long pl_cd_filial, ref string ps_id_situacao, ref string ps_log);string ls_id_situacao

select top 1 id_situacao
into :ls_id_situacao
from ecommerce_rede_filial
where id_ecommerce = :is_id_ecommerce
and cd_filial = :pl_cd_filial
order by id_situacao;

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela ecommerce_rede_filial: ' + sqlca.sqlerrtext
	return false
End if

ps_id_situacao = ls_id_situacao

return true
end function

public function boolean of_grava_comp_venda (dc_uo_transacao ptr_filial, string ps_id_situacao, long pl_nr_pedido, long pl_cd_filial, decimal pdc_vl_total, integer pi_parcelas, string ps_estabelecimento, string ps_bandeira, string ps_nr_nsu, string ps_nr_autorizacao, string ps_cd_autorizacao_cd, string ps_nr_cartao, string ps_nr_psp_recebedor, string ps_id_tipo_uso_cd, string ps_cd_forma_pagto, ref string ps_log);DateTime ldt_Movimentacao
Date ldt_Atual

String ls_Mensagem	, &
		ls_Cd_Caixa	, &
		ls_de_historico
String ls_Documento
String ls_nr_autorizacao
String ls_cd_conta

Integer li_nr_controle_caixa	, &
		  li_nr_sequencial			, &
		  li_nr_lancamento		, &
		  li_Achou

Long ll_Pedido_Ecommerce
Long ll_Lancamento_caixa
Long ll_existe

Decimal {2} ldc_Total

//A fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_comp_venda tamb$$HEX1$$e900$$ENDHEX$$m $$HEX1$$e900$$ENDHEX$$ chamado no objeto uo_ge501_pedido_ecommerce

Try

	//Somente se o pedido foi aprovado
	if ps_id_situacao <> 'A' then return true

	ldc_Total = pdc_vl_total
	
	ls_Documento = String(pl_nr_pedido)
	
	If pi_Parcelas < 1 Then
		ps_log = 'Quantidade de parcelas do cart$$HEX1$$e300$$ENDHEX$$o [' + String( pi_Parcelas ) + '] inv$$HEX1$$e100$$ENDHEX$$lida.'
		Return False
	End If
	
	if ps_cd_forma_pagto = 'CV' then
		ls_cd_conta = '205'
	Else
		ls_cd_conta = '205'
	ENd if
	
	ldt_Movimentacao	= gf_GetServerDate( )
	ldt_Atual				= Date( ldt_Movimentacao )
	ls_Cd_Caixa			= String( pl_cd_filial, "0000" ) + "00"
	
	SELECT MAX( nr_controle_caixa )
	  INTO :li_nr_controle_caixa 
	  FROM controle_caixa
	 WHERE cd_caixa = :ls_Cd_Caixa
		AND dh_movimentacao_caixa = :ldt_Atual
		AND dh_conferencia is null	
	Using ptr_filial;
	
	If ptr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_comp_venda ~n' + 'Problemas ao consultar a tabela "controle_caixa": ~n' + ptr_filial.sqlerrtext
		Return False
	End If
	
	If IsNull(li_nr_controle_caixa) or li_nr_controle_caixa <=0  Then
		ps_log = "Sem caixa geral aberto " + ls_Cd_Caixa + " Pedido " + string(pl_nr_pedido) 
		Return False
	End If

	SELECT MAX(nr_sequencial)
	  INTO :li_nr_sequencial
	  FROM cartao_comprovante_venda
	 WHERE cd_caixa = :ls_Cd_Caixa
		AND nr_controle_caixa	= :li_nr_controle_caixa
	USING ptr_filial;
	
	If ptr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_comp_venda ~n' + 'Problemas ao consultar a tabela "cartao_comprovante_venda": ~n' + ptr_filial.sqlerrtext
		Return False
	End If
	
	If IsNull(li_nr_sequencial) or li_nr_sequencial <= 0 Then
		li_nr_sequencial = 1
	else
		li_nr_sequencial++
	End If
	
	ps_Estabelecimento		= Mid(trim(ps_Estabelecimento), 1, 10)
	ps_Bandeira		= Mid(trim(ps_Bandeira), 1, 40)

	//Verifica$$HEX2$$e700e300$$ENDHEX$$o para n$$HEX1$$e300$$ENDHEX$$o inserir comprovante duplicado
	SELECT Count(*)
	INTO :ll_existe
	FROM cartao_comprovante_venda
	WHERE cd_caixa = :ls_cd_caixa
		AND cd_autorizacao_cd = :ps_cd_autorizacao_cd
		AND nr_nsu = :ps_nr_nsu
		AND vl_venda = :ldc_Total
		AND cd_filial = :pl_cd_filial
		AND cd_estabelecimento = :ps_Estabelecimento
		AND qt_parcelas = :pi_Parcelas
		AND id_cancelamento = 'N'
		AND nr_autorizacao = :ps_nr_autorizacao
	 USING ptr_filial;
	 
	If ptr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_comp_venda ~n' + 'Problemas ao consultar a tabela "cartao_comprovante_venda": ~n' + ptr_filial.sqlerrtext
		Return False
	End If
	 
	If ll_existe > 0 Then
	 	return true
	end if
			
	If ldc_Total = 0.00 Then
		ps_log = 'Valor do cartao_comprovante_venda est$$HEX1$$e100$$ENDHEX$$ igual a 0.'
		Return False
	End If
	
	ll_Pedido_Ecommerce = pl_nr_pedido	
	
	INSERT INTO cartao_comprovante_venda (
		cd_caixa,
		nr_controle_caixa,
		nr_sequencial,
		nm_produto,
		nr_cartao,
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
		nr_pedido_ecommerce,
		cd_psp_recebedor,
		cd_autorizacao_cd,
		id_tipo_uso_cd, 
		nr_autorizacao)
	VALUES (:ls_cd_caixa,
		:li_nr_controle_caixa,
		:li_nr_sequencial,
		:ps_bandeira,		//nm_produto
		:ps_nr_cartao,				//nr_cartao
		:ps_nr_nsu, 	//nr_nsu
		:ldt_Movimentacao, 			//dh_venda
		:ldc_Total, 						//vl_venda
		:pi_Parcelas, 					//qt_parcelas
		'T', 								//id_captura
		'N', 								//id_cancelamento
		:pl_Cd_filial, 				//cd_filial 
		null, 								//nr_nf
		null, 								//de_especie
		null, 								//de_serie
		:ps_Estabelecimento,			//cd_estabelecimento
		null, 								//nr_lancamento_caixa
		null,						 		//dh_exportacao
		  'L', 								//id_parcelamento
		0,									//vl_saque
		null, 								//nr_ecf
		null, 								//nr_coo_ecf
		null, 								//id_cancelamento_sitef 
		'N', 								//id_pre_venda 
		null, 								//dh_predatado
		:ll_Pedido_Ecommerce, 		//nr_pedido_ecommerce
		:ps_nr_psp_recebedor,
		:ps_cd_autorizacao_cd,
		:ps_id_tipo_uso_cd,
		:ps_nr_autorizacao
	)
	Using ptr_filial;	
	
	If ptr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_comp_venda ~n' + 'Problemas ao inserir registro na tabela "cartao_comprovante_venda": ~n' + ptr_filial.sqlerrtext
		Return False
	End If
		
	select nr_lancamento_caixa
		into :ll_Lancamento_caixa
	from cartao_comprovante_venda 
	where cd_caixa = :ls_cd_caixa
		and nr_controle_caixa = :li_nr_controle_caixa
		and nr_sequencial = :li_nr_sequencial
	Using ptr_filial;
	
	If ptr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_comp_venda ~n' + 'Problemas ao consultar a tabela "cartao_comprovante_venda": ~n' + ptr_filial.sqlerrtext
		Return False
	End If
	
	If Not IsNull( ll_Lancamento_caixa ) And ll_Lancamento_caixa > 0 Then
		
		Update lancamento_caixa 
			set nr_documento = :ls_Documento
			where  cd_caixa = :ls_cd_caixa
				and nr_controle_caixa = :li_nr_controle_caixa
				and nr_lancamento = :ll_Lancamento_caixa
		Using ptr_filial;
		
		If ptr_filial.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_comp_venda ~n' + 'Problemas ao atualizar a tabela "lancamento_caixa": ~n' + ptr_filial.sqlerrtext
			Return False
		End If
		
	End If
				
	
	SELECT MAX(nr_lancamento)
		INTO :li_nr_lancamento
	  FROM lancamento_caixa
	 WHERE cd_caixa				= :ls_Cd_Caixa
		 AND nr_controle_caixa	= :li_nr_controle_caixa
	Using ptr_filial;
	
	If ptr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_comp_venda ~n' + 'Problemas ao consultar a tabela "lancamento_caixa": ~n' + ptr_filial.sqlerrtext
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
		:ls_cd_conta, 			//cd_conta_fluxo_caixa
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
	Using ptr_filial;	
	
	If ptr_filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_comp_venda ~n' + 'Problemas ao inserir registro na tabela "lancamento_caixa": ~n' + ptr_filial.sqlerrtext
		Return False
	End If

Finally
	
End Try

return true
end function

public function boolean of_busca_saldo_cd (long pl_cd_filial, long pl_cd_produto, ref long pl_qt_saldo, ref string ps_log);long ll_qt_saldo

//SELECT	dbo.saldo_atual_estoque_central( :pl_cd_filial, pg.cd_produto, 'S'),
//		COALESCE( pg.vl_fator_conversao, 1 ) as vl_fator_conversao
//into :ll_qt_saldo, :ll_fator
//FROM produto_geral pg 
//WHERE pg.cd_produto = :pl_cd_produto
//    and exists (select * from ecommerce_distrib ec
//	 			  where ec.id_ecommerce 	= '2'
//					 and ec.cd_distribuidora 	= '053404705'
//					 and ec.cd_filial 			= :pl_cd_filial
//					 and ec.dh_inicio_saldo <= cast(getdate() as date)
//					 and ec.dh_termino_saldo >= cast(getdate() as date))
//Using SqlCa;


select coalesce(qt_saldo,0)
into :ll_qt_saldo
from saldo_produto_ecommerce
where cd_filial_ecommerce = 534
and cd_filial = 534
and cd_produto = :pl_cd_produto;

if sqlca.sqlcode = -1 then
	ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_saldo_cd ~n' + 'Problemas ao consultar a fun$$HEX2$$e700e300$$ENDHEX$$o "saldo_produto_ecommerce": ~n' + sqlca.sqlerrtext
	return false
end if

pl_qt_saldo = ll_qt_saldo

If IsNull(pl_qt_saldo) Then pl_qt_saldo = 0

return true
end function

public function boolean of_grava_pedido_urgente (long pl_cd_filial, long pl_cd_produto, long pl_qt_pedida, long pl_qt_saldo_cd, long pl_cd_filial_ecommerce, long pl_nr_pedido, ref string ps_log);
Long ll_nr_pedido_filial
Long ll_nr_pedido_distribuidora
Long ll_existe

Decimal{2} ldc_custo_medio, ldc_vl_total_pedido

String ls_erro
String ls_cd_origem_produto

Date ldt_dh_emissao

uo_produto lvo_Produto

Try
	
	
//	select nr_pedido_distribuidora
//	into :ll_nr_pedido_distribuidora
//	from pedido_distribuidora
//	where cd_filial = :pl_cd_filial
//	and id_situacao = 'N'
//	and id_tipo_pedido = '5';
//	
//	if sqlca.SqlCode = -1 then
//		ps_log = 'Erro ao consultar tabela pedido_distribuidora: ' + sqlca.sqlerrtext
//		return false
//	end if
//	
//	if ll_nr_pedido_distribuidora = 0 or isnull(ll_nr_pedido_distribuidora) then
	
	if not gf_ge040_proximo_pedido_distribuidora(ll_nr_pedido_distribuidora, ps_log) then return false

	ldt_dh_emissao	= Date(gf_getserverdate())

	select coalesce(max(nr_pedido_filial), 0)
	  into :ll_nr_pedido_filial
	  from pedido_filial
	 where cd_filial = :pl_cd_filial
	using sqlca;

	if sqlca.SqlCode = -1 then
		ps_log = 'Erro ao consultar tabela pedido_filial: ' + sqlca.sqlerrtext
		return false
	end if

	insert into pedido_distribuidora  
				 (cd_filial,
				  nr_pedido_distribuidora,   
				  dh_emissao,
				  vl_total_pedido,
				  id_situacao,
				  nr_pedido_filial,   
				  cd_distribuidora,  
				  pc_juros_diario,   
				  nr_rodada,    
				  id_pedido_almoxarifado,   
				  id_tipo_pedido,   
				  pc_desconto_financeiro,  
				  cd_condicao_pagamento)  
	  VALUES ( :pl_cd_filial, 						//cd_filial
				  :ll_nr_pedido_distribuidora, 	//nr_pedido_distribuidora
				  :ldt_dh_emissao, 					//dh_emissao
				  0, 										//vl_tota
				  'N', 									//id_situacao
				  :ll_nr_pedido_filial,				//nr_pedido_filial
				  '053404705', 						//cd_distribuidora
				  0,   									//pc_juros_diario
				  0,   									//nr_rodada
				  'N',   								//id_pedido_almoxarifado
				  '5',   								//id_tipo_pedido
				  0,   									//pc_desconto_financeiro
				  0)   									//cd_condicao_pagamento
	using sqlca;

	if sqlca.SqlCode = -1 then
		ps_log = 'Erro ao inserir na tabela pedido_distribuidora: ' + sqlca.sqlerrtext
		return false
	end if
	
	lvo_Produto = create uo_produto
	
	lvo_Produto.of_localiza_codigo_interno(pl_cd_produto)
	
	if not lvo_Produto.Localizado then
		ps_log = 'Produto n$$HEX1$$e300$$ENDHEX$$o localizado.'
		return false
	end if
			
	ldc_custo_medio	= lvo_Produto.of_custo_medio()
	
	ldc_vl_total_pedido = ldc_custo_medio * pl_qt_pedida
	
	insert into pedido_distribuidora_produto  
			 (cd_filial,   
			  nr_pedido_distribuidora,   
			  cd_produto,   
			  qt_pedida,   
			  qt_atendida,   
			  qt_faturada,   
			  vl_preco_unitario,   
			  id_situacao,   
			  qt_separada,     
			  vl_preco,   
			  pc_desconto,      
			  vl_icms_st,   
			  nr_dias_pagamento,      
			  pc_repasse_icms,     
			  qt_embalagem_padrao_distrib,      
			  qt_estoque_disponivel_distrib)  
	values (:pl_cd_filial,   					//cd_filial
			  :ll_nr_pedido_distribuidora,   //nr_pedido_distribuidora
			  :pl_cd_produto,   					//cd_produto
			  :pl_qt_pedida,   					//qt_pedida
			  :pl_qt_pedida,   					//qt_atendida
			  0,   									//qt_faturada
			  :ldc_custo_medio,   				//vl_preco_unitario
			  'C',   								//id_situacao
			  :pl_qt_pedida,   					//qt_separada
			  :ldc_custo_medio,   				//vl_preco
			  0,   									//pc_desconto
			  0,   									//vl_icms_st
			  0,   									//nr_dias_pagamento
			  0,   									//pc_repasse_icms
			  1,   									//qt_embalagem_padrao_distrib
			  :pl_qt_saldo_cd   					//qt_estoque_disponivel_distrib
			  )
		using sqlca;

		if sqlca.SqlCode = -1 then
			ps_log = 'Erro ao inserir na tabela pedido_distribuidora_produto: ' + sqlca.sqlerrtext
			return false
		end if
		
		ls_cd_origem_produto = lvo_produto.cd_origem_produto
			
		insert into pedido_distribuidora_prd_item  
				 (cd_filial,   
				  nr_pedido_distribuidora,   
				  cd_produto,   
				  nr_sequencial,   
				  cd_origem_produto,   
				  qt_atendida )  
		values (:pl_cd_filial,   					//cd_filial
				  :ll_nr_pedido_distribuidora,   //nr_pedido_distribuidora
				  :pl_cd_produto,   					//cd_produto
				  10,									//nr_sequencial
				  :ls_cd_origem_produto,   		//cd_origem_produto
				  :pl_qt_pedida)						//qt_atendida
		using sqlca;
	//
		if sqlca.SqlCode = -1 then
			ps_log = 'Erro ao inserir na tabela pedido_distribuidora_prd_item: ' + sqlca.sqlerrtext
			return false
		end if
		
		update pedido_distribuidora
			set vl_total_pedido	= :ldc_vl_total_pedido,
				id_situacao = 'P'
		 where nr_pedido_distribuidora = :ll_nr_pedido_distribuidora 
		 and cd_filial	= :pl_cd_filial
		using sqlca;

		if sqlca.SqlCode = -1 then
			ps_log = 'Erro ao atualizar tabela pedido_distribuidora: ' + sqlca.sqlerrtext
			return false
		end if
	
		//Vincula o urgente ao pedido_ecommerce:
		Update pedido_ecommerce_produto
		set nr_pedido_empurrado = :ll_nr_pedido_distribuidora, 
			qt_pedida_empurrada = :pl_qt_pedida
		where cd_filial_ecommerce = :pl_cd_filial_ecommerce
			and nr_pedido = :pl_nr_pedido
			and cd_produto = :pl_Cd_Produto;
	
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao atualizar registro na tabela "pedido_ecommerce_produto": ~n' + sqlca.sqlerrtext
			Return false
		end if
	
Finally
	if ps_log <> '' and not isnull(ps_log) then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido_urgente; ' + ps_log
	
ENd Try


return true
end function

public function boolean of_verifica_usa_pedido_urgente (long pl_cd_filial, ref boolean pb_usa_pedido_urgente, ref string ps_log);string ls_vl_parametro

long ll_ini, ll_fim
long ll_cd_filial

Select vl_parametro
into :ls_vl_parametro
from parametro_geral
where cd_parametro = 'CD_FILIAL_PED_DIS_ECOMMERCE';

pb_usa_pedido_urgente = false

if ls_vl_parametro = '0' then
	//Todas filiais usam:
	pb_usa_pedido_urgente = True
	
Elseif ls_vl_parametro = '' or isnull(ls_vl_parametro) then
	//Nenhuma filial usa:
	pb_usa_pedido_urgente = false
	
Else
	
	ll_ini = 1
	
	Do
		
		ll_fim = pos(ls_vl_parametro,';',ll_ini)
		
		if ll_fim > 0 then
			ll_Cd_filial = long( mid( ls_vl_parametro, ll_ini, ll_fim - 1) ) 
			ll_ini = ll_fim + 1
			
		else
			ll_Cd_filial = long( mid( ls_vl_parametro, ll_ini) ) 
		ENd if
		
		if ll_Cd_filial = pl_Cd_filial then 
			pb_usa_pedido_urgente = True
			Exit
		ENd if
		
	Loop While ll_fim > 0
	
End if

return true
end function

public function boolean of_grava_delivery (ref string ps_log);insert into pedido_ecommerce_delivery(nr_pedido, cd_filial_ecommerce, id_situacao, dh_inclusao, nr_tentativa)
	values (:il_nr_pedido, :il_Filial_Ecommerce, 'A', getdate(), 0 );
	
if sqlca.sqlcode = -1 Then
	ps_log = 'Problemas ao inserir registro na tabela pedido_ecommerce_delivery: ' + sqlca.sqlerrtext
	return false
ENd if
	
return true
end function

public function boolean of_grava_pedido_empurrado_prod (long pl_cd_filial, long pl_nr_pedido, long pl_cd_produto, long pl_qtde, string ps_situacao, string ps_matricula, long pl_cd_motivo, boolean pb_pedido_urgente, ref string ps_log);long ll_qt_aprovada 

ll_qt_aprovada = pl_qtde


INSERT INTO pedido_empurrado_produto
					(   cd_filial,
						nr_pedido_empurrado,
						cd_produto,
						qt_empurrada,
						qt_faturada,
						qt_aprovada,
						id_situacao,
						nr_matricula_inclusao,
						cd_motivo_empurrado,
						id_ecommerce
						)
	VALUES (:pl_cd_filial, //cd_filial
				:pl_nr_pedido,	//nr_pedido_empurrado
				:pl_cd_produto, // cd_produto
				:pl_qtde, // qt_empurrada
				0, // qt_faturada
				:ll_qt_aprovada,
				:ps_Situacao, //id_situacao
				:ps_matricula, //nr_matricula_inclusao
				:pl_cd_motivo, //cd_motivo_empurrado
				'S' //Id_ecommerce
				)
	USING SqlCa;
			
if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao inserir registro na tabela "pedido_empurrado_produto": ~n' + sqlca.sqlerrtext
	Return false
end if
	
return true
end function

public function boolean of_processa_pedido_empurrado (long pl_cd_produto, long pl_qtde, ref string ps_log);return this.of_processa_pedido_empurrado( il_cd_filial_pedido, il_filial_ecommerce, il_nr_pedido, pl_cd_produto, pl_qtde, ref ps_log )

end function

public function boolean of_grava_pedido_empurrado (long pl_cd_filial, long pl_cd_filial_ecommerce, long pl_nr_pedido, long pl_cd_produto, long pl_saldo_falta, boolean pb_pedido_urgente, ref string ps_log);//****************************************************************************************************//
//of_grava_pedido_empurrado
//****************************************************************************************************//
//Objetivo:
//****************************************************************************************************//
//-> Gravar os registros nas tabelas do processo de pedido empurrado: pedido_empurrado e pedido_empurrado_produto
//****************************************************************************************************//
//Parametros: 
//****************************************************************************************************//
//pl_cd_filial - Codigo da Filial que ir$$HEX1$$e100$$ENDHEX$$ atender o pedido
//pl_cd_filial_ecommerce - C$$HEX1$$f300$$ENDHEX$$digo filial da chave do pedido ecommerce
//pl_nr_pedido - N$$HEX1$$fa00$$ENDHEX$$mero do pedido ecommerce
//pl_cd_produto - c$$HEX1$$f300$$ENDHEX$$digo do produto solicitado
//pl_saldo_falta - quantidade a ser empurrada
//ps_log - retorna descricao do erro ocorrido (Refer$$HEX1$$ea00$$ENDHEX$$ncia)
//****************************************************************************************************//

Long ll_Numero_Pedido					= 0
Long ll_Qt_a_Empurrar					= 0
Long ll_existe
Long ll_cd_motivo
Long ll_vl_fator_conversao

String ls_Situacao
String ls_situacao_produto
String ls_matricula
String ls_cd_motivo
String ls_id_tipo_pedido
String ls_id_reserva_saldo
String ls_cd_distribuidora

DateTime ldh_Parametro

Try	
	
	ldh_Parametro = gvo_Parametro.of_Dh_Movimentacao( )

	ls_Situacao = 'C' // COLOCADO
	ls_matricula = '14330'
	ll_cd_motivo = 12
	
	if pb_pedido_urgente = True Then
		
		ls_id_tipo_pedido = 'U' 
		ls_id_reserva_saldo = 'S'
		ls_cd_distribuidora = '053404705'
	Else
		
		ls_id_tipo_pedido = 'E' 
		ls_id_reserva_saldo = 'N'
		setnull(ls_cd_distribuidora)
	ENd if
	
	// Deixa como CANCELADO caso esteja sendo realizados testes de desenvolvimento
	If Not IsNull(il_Filial_Desenv) and il_Filial_Desenv <> 0 Then ls_Situacao = 'X' 
		
	//QTDE a empurrar
	ll_Qt_a_Empurrar = pl_Saldo_Falta

	select coalesce(vl_fator_conversao,1) 
	into :ll_vl_fator_conversao
	from produto_geral 
	where cd_produto = :pl_cd_produto;

	If SqlCa.SqlCode = -1 then
		ps_log = 'Problemas ao consultar a tabela "produto_geral": ~n' + sqlca.sqlerrtext
		Return false
	ENd if

	//Verifica fator conversao:
	if ll_vl_fator_conversao > 0 Then
		
		//Se a divisao nao for exata, pego somente o numero inteiro e acrescento mais 1 unidade.
		If mod(ll_Qt_a_Empurrar, ll_vl_fator_conversao) > 0 Then
			
			ll_Qt_a_Empurrar = Truncate(ll_Qt_a_Empurrar/ll_vl_fator_conversao, 0) + 1
			
		Else
			ll_Qt_a_Empurrar = ll_Qt_a_Empurrar/ll_vl_fator_conversao
		ENd if
		
	ENd if

	if pb_pedido_urgente = True Then
		ll_Numero_Pedido = 0
	Else
		
		// Verifica se h$$HEX1$$e100$$ENDHEX$$ pedido colocado para incluir produto
		SELECT TOP 1 p1.nr_pedido_empurrado
		INTO :ll_Numero_Pedido
		FROM pedido_empurrado p1
		WHERE p1.cd_filial = :pl_cd_filial
		AND p1.id_tipo_pedido = :ls_id_tipo_pedido
		AND p1.id_situacao = :ls_situacao 
		AND p1.id_processado = 'N'
		ORDER BY p1.nr_pedido_empurrado DESC
		USING SqlCa;
	
		If SqlCa.SqlCode = -1 then
			ps_log = 'Problemas ao consultar a tabela "pedido_empurrado": ~n' + sqlca.sqlerrtext
			Return false
		ENd if
		
	ENd if
	
	if ll_Numero_Pedido > 0 Then
		//Existe pedido colocado, usar esse pedido:
			
			// Verifica se existe o produto no pedido
			SELECT id_situacao
			INTO :ls_situacao_produto
			FROM pedido_empurrado_produto
			WHERE cd_filial = :pl_cd_filial
			AND nr_pedido_empurrado = :ll_Numero_Pedido
			AND cd_produto = :pl_cd_Produto
			USING SqlCa;
			
			If SqlCa.SqlCode = -1 then
				ps_log = 'Problemas ao consultar a tabela "pedido_empurrado_produto": ~n' + sqlca.sqlerrtext
				Return false
			ENd if
			
			if ls_situacao_produto = '' or isnull(ls_situacao_produto) Then
				ll_existe = 0
			Else
				ll_existe = 1
			ENd if
			
			If ll_existe > 0 Then
				
				if ls_situacao_produto = 'X' Then
					//J$$HEX1$$e100$$ENDHEX$$ existe, mas o registro est$$HEX1$$e100$$ENDHEX$$ cancelado: Exclui e insere um novo Colocado
					
					Delete from pedido_empurrado_produto
					WHERE cd_filial = :pl_cd_filial
						AND nr_pedido_empurrado = :ll_Numero_Pedido
						AND cd_produto = :pl_cd_Produto
						USING SqlCa; 
					
					If SqlCa.SqlCode = -1 then
						ps_log = 'Problemas ao excluir registro da tabela "pedido_empurrado_produto": ~n' + sqlca.sqlerrtext
						Return false
					ENd if
					
					//Faz Insert:
					if Not this.of_grava_pedido_empurrado_prod( pl_cd_filial, ll_numero_pedido, pl_cd_produto, ll_qt_a_empurrar, ls_situacao, ls_matricula, ll_cd_motivo, false, ref ps_log) then return true
				
				ELse			
					//J$$HEX1$$e100$$ENDHEX$$ existe, entao faz UPDATE:
				
					UPDATE pedido_empurrado_produto
						SET qt_empurrada = COALESCE(qt_empurrada,0) + :ll_Qt_a_Empurrar,
							qt_aprovada = COALESCE(qt_aprovada,0) + :ll_Qt_a_Empurrar
						WHERE cd_filial = :pl_cd_filial
						AND nr_pedido_empurrado = :ll_Numero_Pedido
						AND cd_produto = :pl_cd_produto
						USING SqlCa;
						
						if sqlca.sqlcode = -1 then
							ps_log = 'Problemas ao atualizar a tabela "pedido_empurrado_produto": ~n' + sqlca.sqlerrtext
							Return false
						end if
				
				End if
				
			Else			
				//Nao existe, entao faz INSERT:
				
				if Not this.of_grava_pedido_empurrado_prod( pl_cd_filial, ll_numero_pedido, pl_cd_produto, ll_qt_a_empurrar, ls_situacao, ls_matricula, ll_cd_motivo, false, ref ps_log) then return true
							
			ENd if
			
		Else
			//Nao existe pedido colocado, insere um novo:
			
			SELECT COALESCE( MAX( nr_pedido_empurrado ), 0 ) + 1
			INTO :ll_Numero_Pedido
			FROM pedido_empurrado
			WHERE cd_filial = :pl_cd_filial
			USING SqlCa;
			
			if sqlca.sqlcode = -1 then
				ps_log = 'Problemas ao consultar a tabela "pedido_empurrado": ~n' + sqlca.sqlerrtext
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
				cd_distribuidora)
			VALUES (
					:pl_cd_filial, //cd_filial
					:ll_Numero_Pedido,	//nr_pedido_empurrado
					:ldh_Parametro, //dh_emissao
					'N', // id_processado
					:ls_id_tipo_pedido, // id_tipo_pedido
					:ls_Situacao,
					:ls_id_reserva_saldo, // id_reserva_saldo_cd
					getdate( ), // dh_inclusao
					:ls_matricula, // nr_matricula_inclusao
					:ls_cd_distribuidora
				)
			Using SqlCa;
		
			if sqlca.sqlcode = -1 then
				ps_log = 'Problemas ao inserir registro na tabela "pedido_empurrado": ~n' + sqlca.sqlerrtext
				Return false
			end if
			
			//Insert:
			if ls_id_tipo_pedido = 'U' Then
				if Not this.of_grava_pedido_empurrado_prod( pl_cd_filial, ll_numero_pedido, pl_cd_produto, ll_qt_a_empurrar, ls_situacao, ls_matricula, ll_cd_motivo, True, ref ps_log) then return true	
			Else
				if Not this.of_grava_pedido_empurrado_prod( pl_cd_filial, ll_numero_pedido, pl_cd_produto, ll_qt_a_empurrar, ls_situacao, ls_matricula, ll_cd_motivo, False, ref ps_log) then return true
			ENd if
			
		ENd if
	
	//Vincula o pedido_empurado ao pedido_ecommerce:
	Update pedido_ecommerce_produto
	set nr_pedido_empurrado = :ll_Numero_Pedido, 
		qt_pedida_empurrada = :ll_qt_a_empurrar
	where cd_filial_ecommerce = :pl_cd_filial_ecommerce
		and nr_pedido = :pl_nr_pedido
		and cd_produto = :pl_Cd_Produto;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao atualizar registro na tabela "pedido_ecommerce_produto": ~n' + sqlca.sqlerrtext
		Return false
	end if
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) then
		 ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido_empurrado ~n' + ps_log
	End if
	
End Try

return true
end function

on uo_ge501_pedido_loja.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_pedido_loja.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'

SetNull(is_pedido_debug)
SetNull(il_Filial_Desenv)
end event

