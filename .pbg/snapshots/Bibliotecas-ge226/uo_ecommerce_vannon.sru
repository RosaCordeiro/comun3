HA$PBExportHeader$uo_ecommerce_vannon.sru
forward
global type uo_ecommerce_vannon from nonvisualobject
end type
end forward

global type uo_ecommerce_vannon from nonvisualobject
end type
global uo_ecommerce_vannon uo_ecommerce_vannon

type prototypes

end prototypes

type variables
CONSTANT INTEGER CD_MENSAGEM_EMAIL_EQUIPE_TI_DESENV		= 98 // c$$HEX1$$f300$$ENDHEX$$digo na tabela mensagem_email_sistema
CONSTANT INTEGER CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA	= 109 // c$$HEX1$$f300$$ENDHEX$$digo na tabela mensagem_email_sistema
CONSTANT STRING CD_DISTRIBUIDORA_ESTOQUE_CENTRAL			= '053404705'
CONSTANT STRING NM_TRANPORTADORA_TOTAL_EXPRESS			= 'TOTAL EXPRESS'
//

STRING is_Lista_Sites[] = { 'FA' }

CONSTANT LONG FILIAL_SITE_FA 	= 809
CONSTANT LONG FILIAL_SITE_DC 	= 986
CONSTANT LONG FILIAL_SITE_MP 	= 355

LONG il_Filial_Site_Em_Atualizacao

STRING is_Rede_Ecommerce = ''

//
dc_uo_transacao Destino
dc_uo_odbc ivo_Odbc
dc_uo_ds_base ivds_Categoria

uo_produto ivo_produto
uo_cliente ivo_cliente
uo_ge073_gera_xml ivo_gera_xml
uo_ge073_json ivo_gera_json

OleObject iole_SrvHTTP, iole_Send

Boolean ivb_pedido_pendente 		= False
Boolean ivb_Log_Pedidos_Aberto 	= False
Boolean ivb_Ambiente_Teste

Integer ivi_Produtos_Incluidos,&
			  ivi_Produtos_Sku_Incluidos,&
			  ivi_Produtos_Praca_Incluidos,&
           	  ivi_Produtos_Alterados, &
			  ivi_Produtos_Sku_Alterados, &
			  ivi_Produtos_Praca_Alterados, &
		     ivi_Marcas_Incluidas, &
		     ivi_Marcas_Alteradas, &
		     ivi_Pedidos_Atualizados, &
		     ivi_Categorias_Incluidas, &
		     ivi_Log

Integer ivi_Prazo_Entrega, ivi_Parcelas,&
	       ivi_Boleto_Parcelado, ivl_Pagamento, ivi_Nr_Integracoes

Long ivl_filial_ecommerce, &
		ivl_filial_ecommerce_sp, &
		ivl_filial_ecommerce_preco, &
	   ivl_filial_disque, &
	   ivl_marca
		
Long ivl_Filial_Ecommerce_Preco_MP

//Long ivl_Filial_Site 			= 809
//Long ivl_Filial_Site_Vannon 	= 809

Long   ivl_Pedido,&
          ivl_Cliente, &
		 ivl_cd_categoria_pai

Decimal ivdc_Largura,&
		ivdc_Altura,&
		ivdc_Profundidade

Decimal {2} ivdc_SubTotal, ivdc_Embalagem, ivdc_Frete, ivdc_Desconto,&
              ivdc_ValeCompra, ivdc_Total, ivdc_Entrada, ivdc_Parcela, ivdc_Indexador,&
		     ivdc_valor_real_pedido, ivdc_produtos_calculado
		
Decimal{3} ivdc_Peso

String ivs_xml_marca_insert	 					= '', &
		 ivs_xml_marca_update 						= '', & 
		 ivs_xml_produto_insert 						= '', & 
		 ivs_xml_produto_update 					= '', &
		 ivs_xml_produto_sku_insert 				= '', & 
		 ivs_xml_produto_sku_update 				= '', &
		 ivs_xml_produto_praca_insert 				= '', & 
		 ivs_xml_produto_praca_update 			= '', &
		 ivs_xml_produto_update_parcial 			= '', &
		 ivs_xml_produto_sku_update_parcial 	= '', &
		 ivs_xml_produto_praca_update_parcial 	= '', &
		 ivs_filiais_ecommerce_Estoque, &
		 ivs_json_captura_pedido, &
		 ivs_Retorno_Api

String ivs_cartao_credito, ivs_autorizacao_cartao, ivs_comprovante_cartao, &
		ivs_Bandeira_Cartao, ivs_Bloqueto, ivs_Forma_Pagto_Droga, ivs_Vale_Compra, ivs_Filial_Retirada

String	ivs_Situacao, ivs_Nome, ivs_Email, ivs_CPF_CGC, ivs_IE, ivs_Fisica_Juridica, ivs_Contato, ivs_Endereco,&
		ivs_Numero, ivs_Complemento, ivs_Bairro, ivs_Cidade, ivs_UF, ivs_CEP, ivs_Pais, ivs_Fone, ivs_Fone_Contato,&
		ivs_Nome_Ent, ivs_Endereco_Ent, ivs_Numero_Ent, ivs_Complemento_Ent, ivs_Bairro_Ent, ivs_Cidade_Ent,&
		ivs_UF_Ent, ivs_CEP_Ent, ivs_Referencia_Ent, ivs_Pais_Ent, ivs_Fone_Ent, ivs_Fone_Contato_Ent,&
	    ivs_Observacao, ivs_Tipo_Frete, ivs_Transportadora, ivs_Regiao, ivs_Tipo_Pgto, ivs_Forma_Pagto, ivs_Origem,&
		ivs_Cupom_Desconto, ivs_Tipo_Vale, ivs_Promocao, ivs_Sexo, ivs_Tipo_Cliente, ivs_Cliente_Clube,&
        	ivs_Fisica_Juridica_Clube, ivs_Estabelecimento, ivs_mensagem_trans_cartao, ivs_de_Categoria, ivds_De_Marca, &				
		ivds_De_Sac, ivds_De_Atendimento, ivds_De_Razao_Social, ivs_Cd_Cliente, ivs_Via_PBM

String ivs_Cep_Substituicao
String is_Mensagem_Email_Pedido_Empurrado

Date	ivdt_DataNascimento,&
	       ivdt_Vencimento_Boleto

DateTime 	ivdt_Compra,&
				ivdt_Atualizacao
	
//Ordem em que os pedidos dever$$HEX1$$e300$$ENDHEX$$o ser empurrados para as distribuidora
dc_uo_ds_base ids_Ordem_Distribuidora


end variables

forward prototypes
public function boolean of_atualiza_saldo ()
public function boolean of_atualiza_categoria_ecommerce ()
public function string of_observacao_pedido ()
public function boolean of_autorizacao_comprovante_cartao (string as_forma_pgto, string as_administradora)
public function boolean of_abre_arquivo (string as_nome)
public function boolean of_atualiza_pedido_drogaexpress (string as_pedido)
public function boolean of_grava_arquivo (string as_mensagem, boolean ab_envia_email)
public function boolean of_atualiza_pedido_ecommerce (string as_pedido_drogaexpress)
public function boolean of_conecta_banco_filial_destino (long al_filial_destino)
protected function boolean of_envia_xml_departamentos (string ps_cd_categoria, string ps_de_categoria, string ps_cd_categoria_pai, string ps_acao)
public function boolean of_existe_promocao_farmagora_produto (ref boolean ab_existe_produto)
public function boolean of_grava_pedido ()
public function boolean of_grava_pedido_drogaexpress (ref string as_pedido)
public function boolean of_produto_ecommerce_promocao (long al_produto, ref boolean ab_produto_promocao)
public function boolean of_proximo_pedido_drogaexpress (long pl_filial, ref long al_sequencial)
public function boolean of_valida_informacoes (long al_produto, ref integer ai_categoria, ref boolean ab_continua)
public function boolean of_verifica_cliente ()
public function boolean of_forma_pagamento (string ps_retorno_pedido)
public function boolean of_atualiza_log_exportacao (string as_situacao, string as_tabela)
public function boolean of_atualiza_log_exportacao (string as_situacao, string as_tabela, string as_produto)
public function integer of_existe_produto_site (long pl_cd_produto)
public function boolean of_importa_status_pedidos ()
public function boolean of_importa_pedidos (long pl_pedido)
public function boolean of_atualiza_marcas ()
public function integer of_existe_marca_site (long pl_cd_marca)
public function boolean of_atualiza_marca_site (long pl_cd_marca, string ps_acao)
public function boolean of_verifica_conexao ()
public function boolean of_atualiza_dados_cliente ()
public function boolean of_importa_cadastro_cliente ()
public function boolean of_grava_cliente_farmagora (string ps_cpf_cgc)
public function boolean of_atualiza_produtos (long pl_produto)
public function boolean of_grava_cartao_comprovante_venda (string as_pedido)
public function boolean of_grava_pedido_pendente ()
public function boolean of_proximo_nr_lancamento (string as_caixa, long al_controle, ref long al_nr_lancamento)
public function boolean of_cancela_cartao_comprovante (string ps_autorizacao_cartao, string ps_comprovante_cartao, string ps_cd_estabelecimento, long pl_pedido_ecommerce)
public function boolean of_reserva_etiqueta_correio (long pl_pedido, string ps_nm_transportadora)
public function string of_filial_ecommerce (string ps_parametro)
public subroutine of_fecha_comunicacao_api ()
public function integer of_comunicacao_api (string ps_json, string ps_metodo, string ps_tipo_integracao)
public function boolean of_abre_comunicacao_api (string ps_metodo, string ps_tipo_integracao)
public function long of_saldo_produto (datastore ads, long pl_produto, long pl_filial)
public function boolean of_envia_produto_praca (long pl_cd_produto, long pl_estoque, decimal pdc_preco, decimal pdc_preco_promocao, string ps_acao, boolean pb_atualiza_preco, string ps_inicio_promocao, string ps_termino_promocao, long pl_filial, boolean pb_disponivel)
private function boolean of_atualiza_produto_site (long pl_cd_produto, string ps_acao, boolean pb_disponivel)
public function integer of_envia_grupo_produto ()
public function boolean of_envia_marcas (string ps_cd_marca, string ps_de_marca, string ps_de_sac, string ps_de_atendimento, string ps_de_razao_social, string ps_acao, boolean pb_integra_xml)
public function boolean of_envia_email (integer ai_codigo_mensagem, string as_assunto, string as_mensagem)
public function boolean of_grava_arquivo (string as_mensagem, boolean ab_envia_email, integer ai_codigo_email)
public function string of_formata_fonte_vermelha (string ps_texto)
public function boolean of_valida_endereco ()
public function boolean of_pedido_possui_inconsistencia ()
public function boolean of_valida_transportadora ()
public function boolean of_valida_cartao_credito ()
public function string of_status_pagamento_vannon (string ps_sigla)
public function boolean of_exclui_pedido_pendente (long pl_pedido)
public function boolean of_cancela_reserva_produto_perini (integer pi_filial, long pl_pedido)
public function boolean of_importa_produtos_pedido (long al_pedido, string as_retorno, string as_pedido_drogaexpress, boolean ab_pedido_pendente)
public subroutine of_marca_capturado ()
public function boolean of_valida_valores_pedido ()
public function boolean of_saldo_produto_reservado (integer pi_filial, long pl_produto, ref long pl_saldo_pendente)
public function integer of_consulta_qtde_pedido_empurrado (integer pi_filial, long pl_produto, string ps_distribuidora, ref long pl_qt_empurrada, ref long pl_qt_fracionada)
protected function integer of_grava_pedido_empurrado (integer pi_filial, long pl_produto, integer pi_qtde, string ps_distribuidora, decimal pdc_fator_conversao, long pl_saldo_falta)
public function boolean of_importa_status_pedido_etotal (long al_pedido_ecommerce, string as_status)
private function long of_saldo_disponivel_distribuidora (integer pi_filial, long pl_produto, string ps_distribuidora, string ps_chamada, ref decimal pdc_fator_conversao)
public function boolean of_atualiza_saldo (string as_rede_ecommerce)
public function boolean of_importa_status_pedidos (string as_rede_ecommerce)
public function boolean of_importa_pedidos (long pl_pedido, string ps_cep, string as_rede_ecommerce)
public function boolean of_atualiza_produtos (long pl_produto, string as_rede_ecommerce)
public function boolean of_carrega_saldo (long al_produto, ref dc_uo_ds_base ads_saldo)
public subroutine of_verifica_filial_site_atualizacao (string as_rede_ecommerce)
public function date of_data_inicio_9_digito ()
protected function boolean of_atualiza_status_pedido (long pl_pedido, string ps_status, string ps_cd_rastreamento, date ptd_compra)
public function boolean of_atualiza_pedido_pendente (long pl_pedido, string ps_cep)
public function integer of_processa_reserva_ped_empurrado (integer pi_filial, long pl_produto, integer ai_qtde_pedido_ecommerce)
public function boolean of_grava_produto_pedido_drogaexpress (string as_pedido, long al_produto, integer ai_qtde, decimal adc_preco, decimal adc_preco_promo, long al_sequencial, long al_requisicao_manip, string as_descricao, ref string as_mensagem, decimal adc_preco_total)
protected function boolean of_grava_produto_pedido (long al_pedido, string as_produto_ecommerce, integer ai_qtde, string as_produto, long al_produto, long al_categoria, string as_fornecedor, string as_cor, string as_tamanho, string as_estilo, string as_aro, decimal adc_peso, decimal adc_cubagem, decimal adc_preco, decimal adc_preco_promo, date adt_inicio_promo, date adt_termino_promo, string as_pedido_drogaexpress, decimal adc_preco_total, long al_sequencial, long al_requisicao_manip, string as_descricao)
protected function boolean of_envia_produtos (long pl_cd_produto, string ps_de_descricao_internet, string ps_de_principal_internet, boolean pb_situacao, decimal pdc_peso, decimal pdc_altura, decimal pdc_largura, decimal pdc_comprimento, string ps_acao, ref string ps_codigo_barras, string ps_id_lei_generico, string ps_cd_grupo_produto, string ps_de_registro_ms, string ps_subgrupo_produto, string ps_cod_produto_sap)
end prototypes

public function boolean of_atualiza_saldo ();Long ll_Row
Long ll_Filiais

//Atualiza o saldo em todos os sites
For ll_Row = 1 TO UPPERBOUND( This.is_Lista_Sites[] )
	This.of_Atualiza_Saldo( This.is_Lista_Sites[ ll_Row ] )
NEXT

Return True
end function

public function boolean of_atualiza_categoria_ecommerce ();
//FUN$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O CONVERTIDA PARA VANNON. ELES AINDA N$$HEX1$$c300$$ENDHEX$$O POSSUEM INTEGRA$$HEX2$$c700c300$$ENDHEX$$O DE CATEGORIAS

Boolean	lvb_Sucesso = True, &
			lvb_Retorno
	 
Integer	lvi_Cd_Categoria, &
			lvi_Cd_Categoria_Pai, &
			lvi_Categorias_Incluidas, &
			lvi_Categorias_Excluidas

Long	lvl_Linhas, &
		lvl_Linha
		
	
String	lvs_Chave, &
		lvs_De_Categoria

If Not of_verifica_conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o liberada no Desenvolvimento.", StopSign!)
	Return False
End If

dc_uo_ds_base lvds_Categoria

lvds_Categoria = Create dc_uo_ds_base 

//// Faz atualizacao pelo log_exportacao_ecommerce
If Not lvds_Categoria.of_ChangeDataObject("ds_ge226_lista_categoria_ecommerce") Then
	Destroy(lvds_Categoria)
	Return False
End If

// Atualiza os registros para pendentes
If Not This.of_Atualiza_Log_Exportacao("P", 'CATEGORIA_ECOMMERCE') Then
	Destroy(ivds_Categoria)
	Return False
End If

If Not This.of_Abre_Arquivo("categoria_ecommerce") Then
	Destroy(lvds_Categoria)	
	Return False
End If

If Not This.of_Grava_Arquivo("In$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o.", False) Then
	FileClose(ivi_Log)
	Destroy(lvds_Categoria)
	Return False
End If

If lvds_Categoria.Retrieve() = -1 Then
	This.of_Grava_Arquivo("Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da categoria.", True) 
	
	FileClose(ivi_Log)
		
	Destroy(lvds_Categoria)
	Return False
End If

SetPointer(HourGlass!)

Open(w_aguarde_2)

w_aguarde_2.Title = "Atualizando as categorias do eCommerce..."

lvl_Linhas = lvds_Categoria.RowCount()

If lvl_Linhas > 0 Then

		w_aguarde_2.uo_Progress.of_SetMax(lvl_Linhas)
		
		For lvl_Linha = 1 To lvl_Linhas
			
			// Atualiza$$HEX2$$e700e300$$ENDHEX$$o pela categoria_ecommerce
			lvi_Cd_Categoria	= lvds_Categoria.Object.cd_categoria[lvl_Linha]
			lvs_De_Categoria	= lvds_Categoria.Object.de_categoria[lvl_Linha]
			lvi_Cd_Categoria_Pai	= lvds_Categoria.Object.cd_categoria_pai[lvl_Linha]
											
			lvb_Sucesso = This.of_envia_xml_departamentos(String(lvi_Cd_Categoria), lvs_De_Categoria, String(lvi_Cd_Categoria_Pai), 'insert')
			
			w_aguarde_2.uo_Progress.of_SetProgress(lvl_Linha)

		Next
				
		If lvb_Sucesso Then
			// Atualiza os registros para processados
			If Not This.of_Atualiza_Log_Exportacao("S", 'CATEGORIA_ECOMMERCE') Then
				lvb_Sucesso = False
			End If
		End If
		
	End If
	
	This.of_Grava_Arquivo("Total de categorias incluidas: " + String(ivi_Categorias_Incluidas), False)

Destroy(lvds_Categoria)

This.of_Grava_Arquivo("Termino da atualiza$$HEX2$$e700e300$$ENDHEX$$o.", False)

FileClose(ivi_Log)

Close(w_aguarde_2)

SetPointer(Arrow!)

Return True
end function

public function string of_observacao_pedido ();String lvs_Observacao, lvs_Obs

Integer lvi_Pos, lvi_Linha

//Observa$$HEX2$$e700e300$$ENDHEX$$o
//teste dkdfkdfdfdfd teste<br />teste2<br />teste3<br /><br /><br /><br /><br />
// 7

lvs_Observacao = ivs_Observacao

For lvi_Linha = 1 To 7
	
	lvi_Pos = Pos(lvs_Observacao, "<br />")
	
	lvs_Obs = lvs_Obs + Mid(lvs_Observacao, 1, lvi_Pos -1)
	
	lvs_Observacao = Mid(lvs_Observacao, lvi_Pos + 6)
		
Next

Return lvs_Obs
end function

public function boolean of_autorizacao_comprovante_cartao (string as_forma_pgto, string as_administradora);//REDECARD
//VISA
//COMPR:250999023    VALOR:       270,90
//ESTAB:028503996 CIA LATINO AMERICANA M
//26.11.12-15:45:48 TERM:PV118021/578685
//NUMERO PARCELAS : 03
//CARTAO: xxxxxxxxxxxx8112     VAL:07/14
//AUTORIZACAO: 009605
//RECONHECO E PAGAREI A DIVIDA
//AQUI REPRESENTADA

//HIPERCARD
//
//COMPROVANTE DE OPERACAO
//
//HIPERCARD - 606282******1377 - 01/16
//
//384017419402001
//
//PDV = 87800000     NSU = 576805  ONL-X
//26/11/2012  14:54:38  AUTORIZ.=  38009
//VENDA CREDITO FIN. LOJA EM 2 PARCELAS
//
//VALOR VENDA:           150,60
//
//
//RECONHECO E PAGAREI IMPORTANCIA ACIMA

Long lvl_Pos

If as_Forma_pgto = 'CP' Then
	
	If as_administradora = 'HIPERCARD' Then
		
		lvl_Pos = Pos(ivs_mensagem_trans_cartao, "NSU =")
		
		If lvl_Pos > 0 Then
			ivs_Comprovante_Cartao = Mid(ivs_mensagem_trans_cartao, lvl_Pos + 6, 6) + '  *'
		End If
		
		lvl_Pos = Pos(ivs_mensagem_trans_cartao, "AUTORIZ.=")
		
		If lvl_Pos > 0 Then
			ivs_autorizacao_cartao = Mid(ivs_mensagem_trans_cartao,lvl_Pos + 11, 5)
		End If
		
	Else
		
		lvl_Pos = Pos(ivs_mensagem_trans_cartao, "COMPR:")
		
		If lvl_Pos > 0 Then
			ivs_Comprovante_Cartao = Mid(ivs_mensagem_trans_cartao, lvl_Pos + 6, 9) + '  *'
		End If
		
		lvl_Pos = Pos(ivs_mensagem_trans_cartao, "AUTORIZACAO:")
		
		If lvl_Pos > 0 Then
			ivs_autorizacao_cartao = Mid(ivs_mensagem_trans_cartao,lvl_Pos + 13, 6)
		End If
						
	End If
	
End If

Return True

end function

public function boolean of_abre_arquivo (string as_nome);String lvs_Path
String ls_Arquivo

Integer li_Tentativas = 0

Date ldt_Parametro, ldt_log_anterior

ldt_Parametro 			= Date( gf_getServerDate() )
ldt_log_anterior 		= RelativeDate( ldt_Parametro, -1)
lvs_Path 					= ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "" )

ls_Arquivo 				= as_nome + '_' + This.is_Rede_Ecommerce + '_' + String(ldt_log_anterior, 'ddmmyyyy') + '.log'

//Move o log_anterior para o BKP
If FileExists( lvs_Path + ls_Arquivo ) Then
	fileMove( lvs_Path + ls_Arquivo, lvs_Path + 'BKP\' + ls_Arquivo )
End If 

//Novo arquivo do dia atual
ls_Arquivo 		= as_nome + '_' + This.is_Rede_Ecommerce + '_' + String(ldt_Parametro, 'ddmmyyyy') + '.log'

// Se der erro, tenta realizar a abertura do log por at$$HEX1$$e900$$ENDHEX$$ 3 vezes antes de retornar FALSE
Do 
	li_Tentativas++
	This.ivi_LOG = FileOpen( lvs_Path + ls_Arquivo, LineMode!, Write!, Shared!, Append! )
	
	If This.ivi_LOG = -1 Then gf_Delay( 2 )
	
	If li_Tentativas >= 3 Then Exit
	
Loop While ( This.ivi_LOG = -1 )
//

If This.ivi_LOG = -1 Then
	If Not gvb_Auto Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo de log '" + ls_Arquivo + "'.", StopSign! )
	End If

	Return False
End If

Return True
//
end function

public function boolean of_atualiza_pedido_drogaexpress (string as_pedido);String lvs_Mensagem

Decimal 	lvdc_Perc_Desconto
	
If ivdc_Produtos_Calculado = 0 Then
	lvs_Mensagem = "[ERRO] Atualiza$$HEX2$$e700e300$$ENDHEX$$o do pedido : nr_pedido_drogaexpress = '" + as_Pedido + "' | . nr_pedido_ecommerce = " + String( ivl_Pedido ) + " Sem produto."
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
End If

lvdc_Perc_Desconto = Round(((ivdc_Desconto / ivdc_Subtotal) * 100), 2)

If lvdc_Perc_Desconto < 0 Then lvdc_Perc_Desconto = 0.00
 
update pedido_drogaexpress
Set vl_total_produtos = :ivdc_Produtos_Calculado, 
	 pc_desconto 		= :lvdc_Perc_Desconto, 
	 vl_desconto 		= :ivdc_Desconto,
	 vl_total_pedido    = :ivdc_Total
Where nr_pedido_drogaexpress = :as_pedido
Using Destino;

If Destino.SqlCode = -1 Then
	lvs_Mensagem = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do pedido DrogExpress '" + as_Pedido + "'. " + Destino.SqlErrText
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
End If

Return True
end function

public function boolean of_grava_arquivo (string as_mensagem, boolean ab_envia_email);Return This.of_Grava_Arquivo( as_mensagem, ab_envia_email, CD_MENSAGEM_EMAIL_EQUIPE_TI_DESENV ) // 98 envia somente a area de TI
end function

public function boolean of_atualiza_pedido_ecommerce (string as_pedido_drogaexpress);String lvs_Mensagem

/*------------------------
ivs_CEP_Ent
O CEP Entrega sera atualizado para resolver o caso de pedido gravado como a situacao PENDENTE
e sera importado como CEP inconsistente
---------------------------*/

Update pedido_ecommerce
	Set nr_pedido_drogaexpress 	= :as_Pedido_DrogaExpress,
		 id_situacao						= 'A',
		 nr_cep_ent						= :ivs_CEP_Ent
Where cd_filial_ecommerce 	=:il_Filial_Site_Em_Atualizacao
	AND nr_pedido 					=:ivl_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	lvs_Mensagem += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do pedido no eCommerce no Sybase '" + String(ivl_Pedido) + "'. " + SqlCa.SqlErrText
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
End If

Return True
end function

public function boolean of_conecta_banco_filial_destino (long al_filial_destino);String lvs_Odbc_Destino
		 
// Se estiver conectado desconecta
If Destino.of_isConnected() Then Destino.of_Disconnect()

If This.ivb_Ambiente_Teste Then
	lvs_Odbc_Destino = '0000_Loja'
Else
	ivo_Odbc.of_Atualiza_Odbcs( String(al_Filial_destino) )

	lvs_Odbc_Destino = ivo_Odbc.of_Localiza(al_Filial_destino)
	
	Destino.of_Set_Erro_Saida_Padrao( 'LOG' )
	
End If

// Testa a conexao com o banco de dados da loja
If Not ivo_ODBC.of_Connect( lvs_ODBC_Destino, 'teste_conexao', 'teste_conexao' ) Then
	// Grava mensagem de erro no log e n$$HEX1$$e300$$ENDHEX$$o continua o processo
	This.of_Grava_Arquivo( "[ERRO] Teste de conex$$HEX1$$e300$$ENDHEX$$o com a filial: " + String(al_Filial_Destino) + '~rGE226.uo_ecommerce_vannon.of_conecta_banco_filial_destino(long)', True )
	Return False
End If

If Not Destino.of_Connect( lvs_Odbc_Destino, "TDC_" + gvo_Aplicacao.of_UserId( ) ) Then
	// Grava mensagem de erro no log e n$$HEX1$$e300$$ENDHEX$$o continua o processo
	This.of_Grava_Arquivo( "[ERRO] Conex$$HEX1$$e300$$ENDHEX$$o com a filial: " + String(al_Filial_Destino) + '~rGE226.uo_ecommerce_vannon.of_conecta_banco_filial_destino(long)', True )
	Return False
End If

Return True
end function

protected function boolean of_envia_xml_departamentos (string ps_cd_categoria, string ps_de_categoria, string ps_cd_categoria_pai, string ps_acao);
String lvs_Registro, &
          lvs_Arquivo_Xml, &
		 lvs_cabecalho, &
		 lvs_texto_xml, &
		 lvs_retorno

//If Not of_Proxy_Create('ENVIO') Then Return false

//of_abre_tag(tag,  tabula$$HEX2$$e700e300$$ENDHEX$$o, grava_arquivo?) - Cria a abertura da tag e grava no arquivo
lvs_texto_xml  = ivo_gera_xml.of_abre_tag('?xml version="1.0" encoding="iso-8859-1"?', 0, False)
lvs_texto_xml  += ivo_gera_xml.of_abre_tag('ws_integracao xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"',0,False)
	//of_elemento(tag, string conte$$HEX1$$fa00$$ENDHEX$$do, tabula$$HEX2$$e700e300$$ENDHEX$$o) - Cria a tag completa e grava no arquivo
	//lvs_texto_xml += ivo_gera_xml.of_elemento('chave', ivs_Chave_Webservice, 1,False)
	lvs_texto_xml += ivo_gera_xml.of_elemento('acao', ps_acao, 1,False) // insert ou update
	lvs_texto_xml += ivo_gera_xml.of_elemento('modulo', 'departamento', 1,False)
	
	//of_abre_tag(tag,  tabula$$HEX2$$e700e300$$ENDHEX$$o) - Cria a abertura da tag e grava no arquivo
	lvs_texto_xml += ivo_gera_xml.of_abre_tag('departamento pk="idDepartamento"', 1,False)
		lvs_texto_xml += ivo_gera_xml.of_elemento('idDepartamento', ps_cd_categoria, 2,False)
		lvs_texto_xml += ivo_gera_xml.of_elemento('nome', ps_de_categoria, 2,False)
		lvs_texto_xml += ivo_gera_xml.of_elemento('descricao', ps_de_categoria, 2,False)

		If(IsNull(ps_cd_categoria_pai) or trim(ps_cd_categoria_pai) = '' or ps_cd_categoria_pai = '0') Then
			lvs_texto_xml += ivo_gera_xml.of_elemento('nivel', '1', 2,False)
		Else
			lvs_texto_xml += ivo_gera_xml.of_elemento('nivel', '2', 2,False)
			lvs_texto_xml += ivo_gera_xml.of_elemento('idDepartamentoNivel1', ps_cd_categoria_pai, 2,False)
			//ivo_gera_xml.of_elemento('idDepartamentoNivel2', 'nosso_cd_departamento', 2) Atualmente n$$HEX1$$e300$$ENDHEX$$o temos mais de 2 n$$HEX1$$ed00$$ENDHEX$$veis
		End If
		
	lvs_texto_xml += ivo_gera_xml.of_fecha_tag('departamento', 1,False)

lvs_texto_xml += ivo_gera_xml.of_fecha_tag('ws_integracao', 1,False)

//Return of_integra_xml(lvs_texto_xml, Long(ps_cd_categoria), 'departamentoadd')
Return True


end function

public function boolean of_existe_promocao_farmagora_produto (ref boolean ab_existe_produto);Long lvl_Produtos

String lvs_Mensagem

Select count(*)
Into :lvl_Produtos
From	promocao_sos a, 
		promocao_sos_filial f,
	  	promocao_sos_produto b,
	  	parametro p
Where a.id_tipo_promocao 	= 'F'
  and a.id_situacao      		= 'L'
  and a.dh_inicio 				<= p.dh_movimentacao and (a.dh_termino >= p.dh_movimentacao or a.dh_termino is null)
  and b.cd_promocao_sos 	= a.cd_promocao_sos
  and f.cd_promocao_sos	= a.cd_promocao_sos
  and b.cd_produto      		= :ivo_produto.cd_produto
  and f.cd_filial				 	= :il_Filial_Site_Em_Atualizacao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	lvs_Mensagem += "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na tabela promocao_sos_produto '" + String(ivo_produto.cd_produto) + "'. " + SqlCa.SqlErrText
	This.of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
Else
	If lvl_Produtos > 0 Then
		ab_Existe_Produto = True
	Else
		ab_Existe_Produto = False
	End If
End If

Return True
end function

public function boolean of_grava_pedido ();Long ll_Achou

//Decimal {2} lvdc_Total
//String ls_Situacao = 'A'

//O valor Total esta sendo enviado no campo TOTAL j$$HEX1$$e100$$ENDHEX$$ com o desconto aplicado
//lvdc_Total = ivdc_Total - ivdc_Desconto - ivdc_ValeCompra

SELECT nr_pedido
INTO :ll_Achou
FROM pedido_ecommerce
WHERE nr_pedido 					= :ivl_pedido
	and cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
USING SQLCA;

Choose Case SqlCa.SqlCode
	Case -1
		This.of_Grava_Arquivo( "[ERRO] Localiza$$HEX2$$e700e300$$ENDHEX$$o da pedido_ecommerce '" + String(ivl_Pedido) + "'. " + SqlCa.SqlErrText + " | of_grava_pedido( )", True )
		Return False
		
	Case 0
		This.of_Grava_Arquivo( "[ALERTA] Numero do pedido j$$HEX1$$e100$$ENDHEX$$ existe na tabela pedido_ecommerce '" + String(ivl_Pedido) + "'. Inclus$$HEX1$$e300$$ENDHEX$$o ignorada, processo continua. | of_grava_pedido( )", False )
		Return True
		
	Case 100
		//
End Choose

//Chmado: 	417902
// Mudan$$HEX1$$e700$$ENDHEX$$a para gravar a situacao PENDENTE
// E excluir a funcionalidade da tabela pedido_ecommerce_pendente
// Sempre gravar o pedido na tabela pedido_ecommerce. 
// Situa$$HEX2$$e700f500$$ENDHEX$$es: AGA e NAA gravar com situa$$HEX2$$e700e300$$ENDHEX$$o 'P' Pendente

INSERT INTO pedido_ecommerce  
		 ( cd_filial_ecommerce,
		   nr_pedido,   
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
			 nr_boleto_bancario)  
VALUES ( :il_Filial_Site_Em_Atualizacao, 	//cd_filial_ecommerce
		   :ivl_pedido, 		      			//nr_pedido,   
		   :ivdt_compra, 					//dh_compra,   
		   :ivdt_atualizacao,				//dh_atualizacao,   
		   :ivs_Situacao,					//id_situacao,   
		   :ivl_cliente, 						//cd_cliente,   
		   :ivs_nome,						//nm_cliente,   
		   :ivs_email,						//de_endereco_email,   
		   :ivs_cpf_cgc,						//nr_cpf_cgc,   
		   :ivs_ie,								//nr_inscricao_estadual,   
		   :ivs_fisica_juridica, 				//id_fisica_juridica,   
		   :ivs_sexo,							//id_sexo,   
		   :ivdt_DataNascimento,			//dh_nascimento,   
		   :ivs_contato,						//nm_contato,   
		   :ivs_endereco,					//de_endereco,   
		   :ivs_numero,						//nr_endereco,   
		   :ivs_complemento,				//de_complemento,   
		   :ivs_bairro,						//de_bairro,   
		   :ivs_cidade,						//de_cidade,   
		   :ivs_uf,							//cd_uf,   
		   :ivs_cep,							//nr_cep,   
		   :ivs_pais,							//de_pais,   
		   :ivs_fone,							//nr_fone,   
		   :ivs_fone_contato,				//nr_fone_contato,   
		   :ivs_nome_ent,					//nm_cliente_ent,   
		   :ivs_endereco_ent,				//de_endereco_ent,   
		   :ivs_numero_ent,				//nr_endereco_ent,   
		   :ivs_complemento_ent,		//de_complemento_ent,   
		   :ivs_bairro_ent,					//de_bairro_ent,   
		   :ivs_cidade_ent,					//de_cidade_ent,   
		   :ivs_uf_ent,						//cd_uf_ent,   
		   :ivs_cep_ent,						//nr_cep_ent,   
		   :ivs_referencia_ent,			//de_referencia_ent,   
		   :ivs_pais_ent,					//de_pais_ent,   
		   :ivs_fone_ent,					//nr_fone_ent,   
		   :ivs_fone_contato_ent,			//nr_fone_contato_ent,   
		   :ivs_observacao,				//de_observacao,   
		   :ivs_tipo_frete,					//id_tipo_frete,   
		   :ivs_transportadora,			//nm_transportadora,   
		   :ivi_prazo_entrega,				//nr_prazo_entrega,   
		   :ivs_regiao,						//nm_regiao_entrega,   
		   :ivdc_subtotal,					//vl_subtotal,   
		   :ivdc_embalagem,				//vl_embalagem,   
		   :ivdc_frete,						//vl_frete,   
		   :ivdc_desconto,					//vl_desconto,   
		   :ivdc_valecompra,				//vl_valecompra,   
		   :ivdc_Total,						//vl_total,   
		   :ivi_parcelas,						//nr_parcelas,   
		   null,								//vl_entrada,   
		   null,								//vl_parcela,   
		   :ivdc_indexador,					//vl_indexador,   
		   :ivi_boleto_parcelado,			//cd_boleto_parcelado,   
		   :ivs_tipo_pgto,					//cd_tipo_pagamento,   
		   :ivs_forma_pagto,				//cd_forma_pagamento,   
		   :ivs_origem,						//cd_origem,   
		   :ivs_cupom_desconto,			//cd_cupom_desconto,   
		   :ivs_promocao,					//de_promocao
		   :ivl_Filial_Disque,				//cd_filial
		   null, 								//nr_pedido_drogaexpress
		   getdate(),							//dh_inclusao
		   :ivl_Pagamento,					//id_pagamento	
		   :ivs_Bloqueto 	)				//nr_boleto_bancario) -
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o da pedido_ecommerce '" + String(ivl_Pedido) + "'. " + SqlCa.SqlErrText + " | of_grava_pedido( )",  True )
	Return False
End If

ivs_comprovante_cartao	= Mid(trim(ivs_comprovante_cartao), 1, 20)
ivs_autorizacao_cartao	= Mid(trim(ivs_autorizacao_cartao), 1, 10)
ivs_Estabelecimento		= Mid(trim(ivs_Estabelecimento), 1, 10)
ivs_Bandeira_Cartao		= Mid(trim(ivs_Bandeira_Cartao), 1, 40)

//Insert Pedido Ecommerce Auxiliar
Insert Into pedido_ecommerce_auxiliar( cd_filial_ecommerce, nr_pedido, nr_comprovante_cartao_credito, nr_autorizacao_cartao_credito, nm_administradora_cartao, cd_estabelecimento_cartao, id_rede_ecommerce )
	Values( :il_Filial_Site_Em_Atualizacao, :ivl_pedido, :ivs_comprovante_cartao, :ivs_autorizacao_cartao, :ivs_Bandeira_Cartao, :ivs_Estabelecimento, :is_Rede_Ecommerce )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o da pedido_ecommerce_auxiliar '" + String(ivl_Pedido) + "'. " + SqlCa.SqlErrText + " | of_grava_pedido( )",  True )
	Return False
End If

This.of_Grava_Arquivo( "[OK] Inclus$$HEX1$$e300$$ENDHEX$$o da pedido_ecommerce '" + String(ivl_Pedido) + "'. | of_grava_pedido( )", False )

Return True
	
end function

public function boolean of_grava_pedido_drogaexpress (ref string as_pedido);Decimal ldc_Pc_Desconto

DateTime lvdt_Movimentacao

String	lvs_Hora,&
	   	lvs_Venda_Clube,&
	   	lvs_Mensagem,&
	   	lvs_Pedido,&
	   	lvs_Endereco,&
	   	lvs_Nulo,&
	   	lvs_Pedido_Inicial,&	   	
		lvs_Observacao

Long lvl_Sequencial

Integer lvi_Pos

// Se j$$HEX1$$e100$$ENDHEX$$ existe pedido drogaexpress com o mesmo nr_pedido_ecommerce, n$$HEX1$$e300$$ENDHEX$$o inclui e retorna false
SELECT nr_pedido_drogaexpress
INTO :as_pedido
FROM pedido_drogaexpress
WHERE nr_pedido_ecommerce = :ivl_Pedido
	AND cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
USING Destino;

Choose Case Destino.SqlCode
	Case -1
		This.of_Grava_Arquivo( "[ERRO] PEDIDO: " + String( ivl_Pedido ) + "~uo_ecommerce_vannon.of_grava_pedido_drogaexpress( string ) Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido_drogaexpress.nr_pedido_ecommerce." + Destino.SqlErrText, True )
		Return False
		
	Case 0
		This.of_Grava_Arquivo( "[ALERTA] PEDIDO: " + String( ivl_Pedido ) + "~r uo_ecommerce_vannon.of_grava_pedido_drogaexpress( string ) Pedido drogaexpess j$$HEX1$$e100$$ENDHEX$$ existe para pedido ecommerce. Inclus$$HEX1$$e300$$ENDHEX$$o ignorada, processo continua", False )
		Return True
				
End Choose
///

lvs_Hora = String(Hour(Now()), "00")

SetNull(lvs_Nulo)

lvdt_Movimentacao = gf_GetServerDate()

//If (ivl_Filial_Disque = 790 or ivl_Filial_Disque = 149) Then
//	lvs_Endereco = RightTrim(Mid(ivs_Endereco_Ent, 1, 50)) 
//Else
	lvs_Endereco = RightTrim(Mid(ivs_Endereco_Ent, 1, 50)) + ", " + ivs_numero_ent
//End If

// S$$HEX1$$f300$$ENDHEX$$ vai pontuar se o cliente estiver cadastrado no clube e for pessoa F$$HEX1$$ed00$$ENDHEX$$sica
//If Not IsNull(ivs_Cliente_Clube) and ivs_Fisica_Juridica_Clube = "F" Then
//	lvs_Venda_Clube = "S"
//Else
//	lvs_Venda_Clube = "N"
//End If

//N$$HEX1$$e300$$ENDHEX$$o pontuar no clube DC. Existe pontua$$HEX2$$e700e300$$ENDHEX$$o exclusiva para o farmagora.
lvs_Venda_Clube = "N"

//of_Autorizacao_Comprovante_Cartao(ivs_Forma_Pagto_Droga, ivs_Bandeira_Cartao)

// Localiza o pr$$HEX1$$f300$$ENDHEX$$ximo pedido do Disque Entrega
If of_Proximo_Pedido_DrogaExpress(ivl_Filial_Disque, Ref lvl_Sequencial) Then
	If lvl_Sequencial > 0 Then
		lvs_Pedido 	= String(ivl_Filial_Disque, "0000") + String(lvl_Sequencial, "0000000")
		as_Pedido 	= String(ivl_Filial_Disque, "0000") + String(lvl_Sequencial + 1, "0000000")		
	Else
		lvs_Pedido 			= String(ivl_Filial_Disque, "0000") + String(1, "0000000")
		lvs_Pedido_Inicial 	= String(ivl_Filial_Disque, "0000") + String(1, "0000000")		
	End If
Else
	Return False
End If

// Cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito
If ivs_Forma_Pagto_Droga = 'CP' Then
	If IsNull(ivs_Comprovante_Cartao) Then
		lvs_Mensagem = "O comprovante do cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito do pedido eCommerce '" + String(ivl_Pedido) + "' n$$HEX1$$e300$$ENDHEX$$o foi informado. "
		of_Grava_Arquivo(lvs_Mensagem, False)
		ivs_Comprovante_Cartao = '0'
	End If
	
	If IsNull(ivs_Autorizacao_Cartao) Then
		lvs_Mensagem = "A autoriza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito do pedido eCommerce '" + String(ivl_Pedido) + "' n$$HEX1$$e300$$ENDHEX$$o foi informada. "
		of_Grava_Arquivo(lvs_Mensagem, False)
		ivs_Autorizacao_Cartao = '0'
	End If
End If

// Observa$$HEX2$$e700e300$$ENDHEX$$o pedido
//lvs_Observacao = of_Observacao_Pedido()
lvs_Observacao 			= Mid(trim(ivs_Observacao), 1, 200)

ivs_cartao_credito 		= Mid(trim(ivs_cartao_credito), 1, 19)
ivs_Cliente_Clube 			= Mid(trim(ivs_Cliente_Clube), 1, 11)
lvs_Endereco 				= Mid(trim(lvs_Endereco), 1, 60)
ivs_Referencia_Ent 		= Mid(trim(ivs_Referencia_Ent), 1, 150)
ivs_Bairro_Ent 				= Mid(trim(ivs_Bairro_Ent), 1, 20)
ivs_Fone_Ent 				= Mid(trim(ivs_Fone_Ent), 1, 20)
ivs_Nome_Ent 				= Mid(trim(ivs_Nome_Ent), 1, 60)
ivs_Bandeira_Cartao	 	= Mid(trim(ivs_Bandeira_Cartao), 1, 40)
ivs_Transportadora 		= Mid(trim(ivs_Transportadora), 1, 30)
ivs_Cidade_Ent 			= Mid(trim(ivs_Cidade_Ent), 1, 30)
ivs_comprovante_cartao 	= Mid(trim(ivs_comprovante_cartao), 1, 20)
ivs_autorizacao_cartao 	= Mid(trim(ivs_autorizacao_cartao), 1, 10)
ivs_Estabelecimento 		= Mid(trim(ivs_Estabelecimento), 1, 10)
ivs_Bloqueto 				= Mid(trim(ivs_Bloqueto), 1, 10)
ivs_Cupom_Desconto 		= Mid(trim(ivs_Cupom_Desconto), 1, 10)
ivs_complemento_ent	 	= Mid(trim(ivs_complemento_ent), 1, 40)
ivs_fone_contato_ent 		= Mid(trim(ivs_fone_contato_ent), 1, 20)
ivs_numero_ent 			= Mid(trim(ivs_numero_ent), 1, 6)

ldc_Pc_Desconto = 0

If ivdc_ValeCompra > 0 Then
	ldc_Pc_Desconto = Round( ( ivdc_ValeCompra / ivdc_Total ) * 100, 2 )
End If

If lvs_Pedido <> lvs_Pedido_Inicial  Then

	// Grava o complemento e o telefone de contato
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
			dh_validade_cartao,   
			cd_convenio,   
			cd_conveniado,   
			cd_dependente_conveniado,   
			cd_cliente,   
			cd_dependente_cliente,   
			cd_condicao_convenio,   
			cd_condicao_crediario,   
			dh_entrega_marcada,   
			de_observacao,   
			nr_matric_alteracao_preco,   
			nr_matric_liberacao_bloqueio,   
			nr_matric_liberacao_restricao,   
			nr_pedido_antigo,   
			nr_matricula_cancelamento,   
			de_endereco_entrega,   
			de_referencia_entrega,   
			de_bairro_entrega,   
			nr_telefone_entrega,   
			dh_atualizacao_pedido,   
			vl_total_tabela,   
			cd_seguranca_cartao,   
			id_venda_clube,   
			cd_cliente_dependente,   
			nr_cartao_clube,   
			qt_pontos_clube,   
			nm_cartao_credito,   
			nm_cliente_cartao,   
			nm_cliente_cheque,   
			nr_cpf_cheque,   
			id_alteracao,
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
			de_endereco_email)  
	Select :as_Pedido,							//nr_pedido_drogaexpress,   
			:ivl_Filial_Disque,					//cd_filial,   
			:lvdt_Movimentacao,				//dh_emissao,   
			:lvs_Hora,							//hr_emissao,   
			'999999',								//cd_cliente_drogaexpress,   
			0,										//vl_total_produtos,   
			:ldc_Pc_Desconto,					//pc_desconto,   
			:ivdc_Total,							//vl_total_pedido,   
			:ivdc_Frete,							//tevl_taxa_entrega,   
			0,										//vl_cobrar,   
			0,										//vl_pago,   
			'A',									//id_situacao,   
			'AV',									//cd_tipo_venda,   
			:ivs_Forma_Pagto_Droga,		//cd_forma_pagamento,   
			'14330',								//nr_matricula_vendedor,   
			'14330',								//nr_matricula_operador,   
			'CF',									//de_especie_doc_fiscal,   
		  :ivs_cartao_credito ,					//nr_cartao_credito,   
			null,									//dh_validade_cartao,   
			null,									//cd_convenio,   
			null,									//cd_conveniado,   
			null,									//cd_dependente_conveniado,   
			:ivs_Cliente_Clube,				//cd_cliente,   
			null,									//cd_dependente_cliente,   
			null,									//cd_condicao_convenio,   
			null,									//cd_condicao_crediario,   
			null,									//dh_entrega_marcada,   
			:lvs_Observacao,					//de_observacao,   
			null,									//nr_matric_alteracao_preco,   
			null,									//nr_matric_liberacao_bloqueio,   
			null,									//nr_matric_liberacao_restricao,   
			null,									//nr_pedido_antigo,   
			null,									//nr_matricula_cancelamento,   
			:lvs_Endereco,						//de_endereco_entrega,   
			:ivs_Referencia_Ent,				//de_referencia_entrega,   
			:ivs_Bairro_Ent,					//de_bairro_entrega,   
			:ivs_Fone_Ent,						//nr_telefone_entrega,   
			null,									//dh_atualizacao_pedido,   
			null,									//vl_total_tabela,   
			null,									//cd_seguranca_cartao,   
			:lvs_Venda_Clube,					//id_venda_clube,   
			null,									//cd_cliente_dependente,   
			null,									//nr_cartao_clube,   
			null,									//qt_pontos_clube,   
			null,									//nm_cartao_credito,   
			null,									//nm_cliente_cartao,   
			null,									//nm_cliente_cheque,   
			:ivs_CPF_CGC,						//nr_cpf_cheque,   
			null,									//id_alteracao,
			:ivl_Pedido,							//nr_pedido_ecommerce,
			:ivs_Nome_Ent,						//nm_cliente_entrega,
			:ivs_Cep_Ent,						//nr_cep_entrega,
			:ivi_Parcelas,						//nr_parcelas_pagamento,
			:ivs_Bandeira_Cartao,         	// nm_administradora_cartao
			:ivs_Transportadora,				// nm_transportadora
			:ivs_Cidade_Ent,					// nm_cidade_entrega
			:ivs_UF_Ent,							// cd_uf_entrega
			:ivs_comprovante_cartao,		// nr_comprovante_cartao_credito,
			:ivs_autorizacao_cartao,			// nr_autorizacao_cartao_credito
			:ivs_Estabelecimento,				// cd_estabelecimento_cartao_credito
			:ivs_Bloqueto,						// nr_boleto_bancario
			:ivs_Cupom_Desconto,			// nr_vale_compra
			0,										// vl_vale_compra
			:ivs_Complemento_Ent,			// de_complemento_endereco
			:ivs_Fone_Contato_Ent,			// nr_telefone_contato
			:il_Filial_Site_Em_Atualizacao,	//cd_filial_ecommerce
			:ivs_numero_ent,					//nr_endereco_entrega
			:ivs_Tipo_Vale,                        //id_tipo_vale
			:ivs_Via_PBM,						// de_via_pbm
			:is_Rede_Ecommerce,
			:ivs_Email
	From pedido_drogaexpress
	Having Max(nr_pedido_drogaexpress) = :lvs_Pedido
	Using Destino;

Else

	// Complemento, telefone de contato
	INSERT INTO pedido_drogaexpress  
		 ( nr_pedido_drogaexpress,   
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
			dh_validade_cartao,   
			cd_convenio,   
			cd_conveniado,   
			cd_dependente_conveniado,   
			cd_cliente,   
			cd_dependente_cliente,   
			cd_condicao_convenio,   
			cd_condicao_crediario,   
			dh_entrega_marcada,   
			de_observacao,   
			nr_matric_alteracao_preco,   
			nr_matric_liberacao_bloqueio,   
			nr_matric_liberacao_restricao,   
			nr_pedido_antigo,   
			nr_matricula_cancelamento,   
			de_endereco_entrega,   
			de_referencia_entrega,   
			de_bairro_entrega,   
			nr_telefone_entrega,   
			dh_atualizacao_pedido,   
			vl_total_tabela,   
			cd_seguranca_cartao,   
			id_venda_clube,   
			cd_cliente_dependente,   
			nr_cartao_clube,   
			qt_pontos_clube,   
			nm_cartao_credito,   
			nm_cliente_cartao,   
			nm_cliente_cheque,   
			nr_cpf_cheque,   
			id_alteracao,
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
			nr_endereco_entrega,
			id_tipo_vale,
			id_rede_ecommerce,
			de_endereco_email
			)  
	Values (:lvs_Pedido,						// nr_pedido_drogaexpress,   
			:ivl_Filial_Disque,					// cd_filial,   
			:lvdt_Movimentacao,				// dh_emissao,   
			:lvs_Hora,							// hr_emissao,   
			'999999',								// cd_cliente_drogaexpress,   
			0,										// vl_total_produtos,   
			:ldc_Pc_Desconto,					// pc_desconto,   
			:ivdc_Total,							// vl_total_pedido,   
			:ivdc_Frete,							// vl_taxa_entrega,   
			0,										// vl_cobrar,   
			0,										// vl_pago,   
			'A',									// id_situacao,   
			'AV',									// cd_tipo_venda,   
			:ivs_Forma_Pagto_Droga,		// cd_forma_pagamento,   
			'14330',								// nr_matricula_vendedor,   
			'14330',								// nr_matricula_operador,   
			'CF',									// de_especie_doc_fiscal,   
			:ivs_cartao_credito,				// nr_cartao_credito,   
			null,									// dh_validade_cartao,   
			null,									// cd_convenio,   
			null,									// cd_conveniado,   
			null,									// cd_dependente_conveniado,   
			:ivs_Cliente_Clube,				// cd_cliente,   
			null,									// cd_dependente_cliente,   
			null,									// cd_condicao_convenio,   
			null,									// cd_condicao_crediario,   
			null,									// dh_entrega_marcada,   
			:lvs_Observacao,					// de_observacao,   
			null,									// nr_matric_alteracao_preco,   
			null,									// nr_matric_liberacao_bloqueio,   
			null,									// nr_matric_liberacao_restricao,   
			null,									// nr_pedido_antigo,   
			null,									// nr_matricula_cancelamento,   
			:lvs_Endereco,						// de_endereco_entrega,   
			:ivs_Referencia_Ent,				// de_referencia_entrega,   
			:ivs_Bairro_Ent,					// de_bairro_entrega,   
			:ivs_Fone_Ent,						// nr_telefone_entrega,   
			null,									// dh_atualizacao_pedido,   
			null,									// vl_total_tabela,   
			null,									// cd_seguranca_cartao,   
			:lvs_Venda_Clube,					// id_venda_clube,   
			null,									// cd_cliente_dependente,   
			null,									// nr_cartao_clube,   
			null,									// qt_pontos_clube,   
			null,									// nm_cartao_credito,   
			null,									// nm_cliente_cartao,   
			null,									// nm_cliente_cheque,   
			:ivs_CPF_CGC,						// nr_cpf_cheque,   
			null,									// id_alteracao,
			:ivl_Pedido,							// nr_pedido_ecommerce,
			:ivs_Nome_Ent,						// nm_cliente_entrega,
			:ivs_Cep_Ent,						// nr_cep_entrega
			:ivi_Parcelas,						// nr_parcelas_pagamento,
			:ivs_Bandeira_Cartao,		 	// nm_administradora_cartao
			:ivs_Transportadora,				// nm_transportadora
			:ivs_Cidade_Ent,					// nm_cidade_entrega
			:ivs_UF_Ent,							// cd_uf_entrega
			:ivs_comprovante_cartao,		// nr_comprovante_cartao_credito,
			:ivs_autorizacao_cartao,			// nr_autorizacao_cartao_credito
			:ivs_Estabelecimento,				// cd_estabelecimento_cartao_credito
			:ivs_Bloqueto,						// nr_boleto_bancario
			:ivs_Cupom_Desconto,				// nr_vale_compra
			0,										// vl_vale_compra			
			:ivs_complemento_ent,			//de_complemento_endereco,
			:ivs_fone_contato_ent,   			//nr_telefone_contato
			:il_Filial_Site_Em_Atualizacao, //cd_filial_ecommerce
			:ivs_numero_ent,					//nr_endereco_entrega
			:ivs_Tipo_Vale,                        //id_tipo_vale
			:is_Rede_Ecommerce,			//id_rede_ecommerce
			:ivs_Email
			)
	Using Destino;	
		
	as_Pedido = lvs_Pedido
	
End If
	   
If Destino.SqlCode = -1 Then
	lvs_Mensagem = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do pedido DrogExpress '" + as_Pedido + "'. " + Destino.SqlErrText
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
End If

If Destino.SQLNRows <> 1 Then
	lvs_Mensagem = "O pedido DrogExpress j$$HEX1$$e100$$ENDHEX$$ foi utilizado '" + as_Pedido + "'.  Importe os pedidos novamente."
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
End If

Return True
end function

public function boolean of_produto_ecommerce_promocao (long al_produto, ref boolean ab_produto_promocao);String lvs_Mensagem

Long lvl_Produto

Select p.cd_produto
Into :lvl_Produto
From produto_ecommerce_promocao p, parametro r
Where p.cd_produto =:al_Produto
	and p.dh_inicio <= r.dh_movimentacao
	and (p.dh_termino >= r.dh_movimentacao or p.dh_termino is null)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0 
		ab_Produto_Promocao = True
	Case 100
		ab_Produto_Promocao = False
	Case -1 
		lvs_Mensagem += "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na tabela produto_ecommerce_promocao '" + String(al_Produto) + "'. " + SqlCa.SqlErrText
		This.of_Grava_Arquivo(lvs_Mensagem, True)
		Return False
End Choose

Return True
end function

public function boolean of_proximo_pedido_drogaexpress (long pl_filial, ref long al_sequencial);String lvs_Pedido,&
	   lvs_Mensagem

Select max(nr_pedido_drogaexpress) Into :lvs_Pedido
From pedido_drogaexpress
Using Destino;

Choose Case Destino.SqlCode
	Case 0
		If Not IsNull(lvs_Pedido) Then
			al_Sequencial = Long(Right(lvs_Pedido, 7))
		Else
			al_Sequencial = 0
		End If
	Case 100
		al_Sequencial = 0
	Case -1
		lvs_Mensagem = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo pedido DrogaExpress da filial '" + String(ivl_Filial_Disque) + "'. " + Destino.SqlErrText
		of_Grava_Arquivo(lvs_Mensagem, True)
		Return False
End Choose

Return True
end function

public function boolean of_valida_informacoes (long al_produto, ref integer ai_categoria, ref boolean ab_continua);Boolean lvb_Sucesso = True

ab_Continua = True

String lvs_Mensagem 

lvs_Mensagem = String (al_Produto, "000000") + " - "

// Desenvolvimento
// Tirar o max
/*
Select max(cd_categoria)
Into :ai_Categoria
From categoria_ecommerce_produto
Where cd_produto 	= :al_Produto
  and id_principal 	= 'S'
Using sqlca;

Choose Case SqlCa.Sqlcode 
	Case -1
		lvs_Mensagem += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da categoria do produto '" + String(al_Produto) + "'. " + sqlca.SqlErrText
		lvb_Sucesso = False
End Choose

If IsNull(ai_Categoria) Then
	lvs_Mensagem += "Sem categoria(s)."
	lvb_Sucesso = True //Ainda n$$HEX1$$e300$$ENDHEX$$o existe integra$$HEX2$$e700e300$$ENDHEX$$o de categorias na Vannon
End If

If lvb_Sucesso Then
	Select de_categoria, cd_categoria_pai
	Into :ivs_de_Categoria, :ivl_cd_categoria_pai
	From categoria_ecommerce
	Where cd_categoria 	= :ai_Categoria
	Using sqlca;
	
	Choose Case SqlCa.Sqlcode 
		Case 100
			lvs_Mensagem += "Informa$$HEX2$$e700f500$$ENDHEX$$es da categoria n$$HEX1$$e300$$ENDHEX$$o localizadas para o produto'" + String(al_Produto) + "'. " + sqlca.SqlErrText
			lvb_Sucesso = True //Ainda n$$HEX1$$e300$$ENDHEX$$o existe integra$$HEX2$$e700e300$$ENDHEX$$o de categorias na Vannon
		Case -1
			lvs_Mensagem += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX1$$f500$$ENDHEX$$es da categoria '" + String(ai_Categoria) + "'. " + sqlca.SqlErrText
			lvb_Sucesso = False
	End Choose	
End If
*/

Select qt_largura_cm, qt_altura_cm, qt_profundidade_cm, qt_peso_grama, cd_marca_ecommerce
Into :ivdc_Largura, :ivdc_Altura, :ivdc_Profundidade, :ivdc_Peso, :ivl_marca
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		
		If IsNull(ivdc_Largura) or ivdc_Largura <= 0 Then
			lvs_Mensagem += "Sem largura."	
			ivdc_Largura = 0
		End If
		
		If IsNull(ivdc_Altura) or ivdc_Altura <= 0 Then
			lvs_Mensagem += "Sem altura."	
			ivdc_Altura = 0
		End If
		
		If IsNull(ivdc_Profundidade) or ivdc_Profundidade <= 0 Then
			lvs_Mensagem += "Sem profundidade."	
			ivdc_Profundidade = 0
		End If
		
		If IsNull(ivdc_Peso) or ivdc_Peso <= 0 Then
			lvs_Mensagem += "Sem peso."
			ivdc_Peso = 0
		End If			
		
		ivds_de_sac = '' 
		ivds_de_atendimento = '' 
		ivds_De_Razao_Social = '' 
		
		If IsNull(ivl_marca) or ivl_marca <= 0 or ivl_marca = 0 Then
			ivl_Marca = 2410 //Marca tempor$$HEX1$$e100$$ENDHEX$$ria para todos os produtos
			ivds_de_marca = 'OUTROS' 
		Else
			Select de_marca
				Into :ivds_de_marca
			  From marca_ecommerce
			Where cd_marca = :ivl_marca	
			Using SqlCa;

			If (SqlCa.SqlCode <> 0) Then			
				lvs_Mensagem += "Marca n$$HEX1$$e300$$ENDHEX$$o localizada." + SqlCa.SqlErrText
			End If			
		End If
End Choose

If Len(lvs_Mensagem) > 9 Then
	// Grava mensagem de erro no log e n$$HEX1$$e300$$ENDHEX$$o continua o processo
	This.of_Grava_Arquivo(lvs_Mensagem, False)
	
	ab_Continua = False
End If

Return True
end function

public function boolean of_verifica_cliente ();Boolean lvb_Sucesso = True

String lvs_Mensagem

ivs_CPF_CGC = gf_tira_mascara_cpf(ivs_CPF_CGC)

// Se for CNPJ
If Len(ivs_CPF_CGC) > 11 Then
	ivs_CPF_CGC = gf_tira_mascara_CNPJ(ivs_CPF_CGC)
End If

Select cd_cliente, id_tipo_cliente, id_fisica_juridica
Into :ivs_Cliente_Clube, :ivs_Tipo_Cliente, :ivs_Fisica_Juridica_Clube
From cliente
Where nr_cpf_cgc =:ivs_CPF_CGC
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
	Case 100
	Case -1
		lvs_Mensagem += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do cliente CPF: '" + ivs_CPF_CGC + "'. " + SqlCa.SqlErrText
		lvb_Sucesso = False
End Choose

If Not lvb_Sucesso Then
	of_Grava_Arquivo(lvs_Mensagem, True)
End If

Return lvb_Sucesso
end function

public function boolean of_forma_pagamento (string ps_retorno_pedido);String	lvs_Nulo,&
		lvs_Parcelas

SetNull(lvs_Nulo)

ivs_Bloqueto   				= lvs_Nulo
ivs_Bandeira_Cartao 		= lvs_Nulo
ivs_Estabelecimento		= lvs_Nulo

/* Para liberar cart$$HEX1$$e300$$ENDHEX$$o, tratar o retorno da integra$$HEX2$$e700e300$$ENDHEX$$o no case abaixo, conforme as essas regras:
	---
	ivs_Bandeira_Cartao: Deve ser igual ao cadastrado na tabela cartao_produto, pois retornar$$HEX1$$e100$$ENDHEX$$ a conta 'SELECT cd_conta_fluxo_caixa FROM cartao_produto WHERE nm_produto = :ivs_Bandeira_Cartao
	ivs_Estabelecimento: Para cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ utilizada, pode ser colocado '1025022146'
	ivl_Pagamento: N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ utilizada, pode ser colocado 6
	---
	Ap$$HEX1$$f300$$ENDHEX$$s importar, conferir na filial:
		SELECT * FROM lancamento_caixa WHERE dh_lancamento >= 'dh_lancamento' AND de_historico LIKE '%nr_pedido%';
			- Dever$$HEX1$$e100$$ENDHEX$$ existir a conta de adiantamento (205) e a conta retornada na cartao_produto. Se o pedido estiver faturado, dever$$HEX1$$e100$$ENDHEX$$ existir o estorno da conta 205.
		SELECT * FROM cartao_comprovante_venda WHERE dh_venda >= 'dh_venda' AND nr_nsu LIKE '%nr_nsu%';
			- Dever$$HEX1$$e100$$ENDHEX$$ retornar o comprovante do cartao
	---
	Para exportar para a matriz, preencher cartao_comprovante_venda.dh_exportacao
	Ap$$HEX1$$f300$$ENDHEX$$s importar no TC, conferir no central
		SELECT * FROM lancamento_caixa WHERE dh_lancamento >= 'dh_lancamento' AND de_historico LIKE '%nr_pedido%';
			- Dever$$HEX1$$e100$$ENDHEX$$ existir a conta de adiantamento (205) e a conta retornada na cartao_produto. Se o pedido estiver faturado, dever$$HEX1$$e100$$ENDHEX$$ existir o estorno da conta 205.
		SELECT * FROM cartao_comprovante_operacao WHERE cd_caixa = 'cd_caixa' AND dh_operacao >= 'dh_operacao' AND vl_operacao = vl_operacao;
			- Dever$$HEX1$$e100$$ENDHEX$$ retornar o comprovante do cartao		
*/

Do While ivo_gera_json.of_divide_grupo_json_tag(Ref ps_retorno_pedido, 'PedidoPagamentos', Ref lvs_Parcelas,']') 
	
	ivs_Tipo_Pgto 				= UPPER(ivo_gera_json.of_busca_conteudo_campo(lvs_Parcelas, 'Nome'))
	ivs_Forma_Pagto 			= UPPER(ivo_gera_json.of_busca_conteudo_campo(lvs_Parcelas, 'Nome'))
	
	Choose Case ivs_Tipo_Pgto		
		Case 'RESGATE' 
			ivs_Tipo_Vale				= lvs_Nulo
			ivs_Cupom_Desconto 		= '1'
			ivdc_ValeCompra 			= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_Parcelas, 'ValorParcela'),'.',',',0))
			
		Case 'BOLETO BRADESCO', 'BOLETO BRADESCO REGISTRADO' //'BOLETO BANC$$HEX1$$c100$$ENDHEX$$RIO'
			ivl_Pagamento 				= 3
			ivs_Forma_Pagto_Droga	= 'DI'
			ivs_Bloqueto					= String(ivo_gera_json.of_busca_conteudo_campo(lvs_Parcelas, 'NossoNumero'))
			If IsNull(ivs_Bloqueto) or ivs_Bloqueto = '' Then
				This.of_Grava_Arquivo( "[ERRO] Pedido sem informa$$HEX2$$e700f500$$ENDHEX$$es do Boleto: '" + String(ivl_Pedido) + "'.", True )
				Return False
			End If
			
		Case 'ELO' // Cart$$HEX1$$e700$$ENDHEX$$ai de cr$$HEX1$$e900$$ENDHEX$$dito elo
			ivl_Pagamento 				= 6
			ivs_Forma_Pagto_Droga	= 'CP'
			ivs_Bandeira_Cartao 		= 'ELO CREDITO - REDE'
			ivs_Estabelecimento   	= '1025022146'	
					
		Case 'VISA' //'CART$$HEX1$$c300$$ENDHEX$$O DE CR$$HEX1$$c900$$ENDHEX$$DITO VISA'
			ivl_Pagamento 				= 6
			ivs_Forma_Pagto_Droga	= 'CP'
			ivs_Bandeira_Cartao 		= 'VISA CREDITO - REDE'
			ivs_Estabelecimento   	= '1025022146'					
			
		Case 'MASTERCARD' //'CART$$HEX1$$c300$$ENDHEX$$O DE CR$$HEX1$$c900$$ENDHEX$$DITO MASTERCARD'
			ivl_Pagamento 				= 7
			ivs_Forma_Pagto_Droga	= 'CP'
			ivs_Bandeira_Cartao 		= 'REDECARD'
			ivs_Estabelecimento   	= '028824580'
		
		Case 'DINNERS', 'DINERS' //'CART$$HEX1$$c300$$ENDHEX$$O DE CR$$HEX1$$c900$$ENDHEX$$DITO DINERS CLUB'
			ivl_Pagamento 				= 8
			ivs_Forma_Pagto_Droga	= 'CP'
			ivs_Bandeira_Cartao 		= 'REDECARD'
			ivs_Estabelecimento   	= '028824580'
		
		Case 'TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA BRADESCO' //'TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA ELETR$$HEX1$$d400$$ENDHEX$$NICA BRADESCO'
			ivl_Pagamento 				= 12
			ivs_Forma_Pagto_Droga	= 'DI'
			ivs_Bloqueto					= String(ivl_Pedido)		
			
		Case 'TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA ITA$$HEX1$$da00$$ENDHEX$$' //'ITAU SHOPLINE'  
			ivl_Pagamento 				= 19
			ivs_Forma_Pagto_Droga	= 'DI'
			ivs_Bloqueto					= String(ivl_Pedido)
			
		Case 'HIPERCARD' //'CART$$HEX1$$c300$$ENDHEX$$O DE CR$$HEX1$$c900$$ENDHEX$$DITO HIPERCARD'
			ivl_Pagamento 				= 24
			ivs_Forma_Pagto_Droga	= 'CP'
			ivs_Bandeira_Cartao 		= 'HIPERCARD - REDE'
			ivs_Estabelecimento   	= '384017419402001'
		
		Case '	AMEX', 'AMERICAN EXPRESS' //'CART$$HEX1$$c300$$ENDHEX$$O DE CR$$HEX1$$c900$$ENDHEX$$DITO Amex
			ivl_Pagamento 				= 6
			ivs_Forma_Pagto_Droga	= 'CP'
			ivs_Bandeira_Cartao 		= 'AMEX REDE'
			ivs_Estabelecimento   	= '028824580'
			
		Case Else
			If IsNull( ivs_Tipo_Pgto ) Then ivs_Tipo_Pgto = ''
			This.of_Grava_Arquivo( "[ERRO] Forma de pagamento '" + ivs_Tipo_Pgto + "' n$$HEX1$$e300$$ENDHEX$$o prevista '" + String(ivl_Pagamento) + "'. Pedido: " + String(ivl_Pedido), True )
			Return False
	
	End Choose
		
Loop	

Return True

end function

public function boolean of_atualiza_log_exportacao (string as_situacao, string as_tabela);// Marca como pendentes
If as_Situacao = 'P' Then
	Update log_exportacao_ecommerce
	Set id_processado   = :as_Situacao
	Where id_processado = 'N'
	  and nm_tabela				= :as_Tabela
      and cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
      and id_ecommerce = '1'
	Using SqlCa;
	
	// Faz o comit no final do processo
	If SqlCa.SqlCode <> -1 Then
		This.of_Grava_Arquivo("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o '" + as_Situacao + "' do log_exportacao_ecommerce." + SqlCa.SqlErrText, True)	
		Return False
	End If
	Return True
End If

// Marca como j$$HEX1$$e100$$ENDHEX$$ processados
If as_Situacao = 'S' Then
	Update log_exportacao_ecommerce
	Set id_processado   = :as_Situacao
	Where id_processado = 'P'
	  and nm_tabela				= :as_Tabela
	  and cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
	  and id_ecommerce = '1'
    Using SqlCa; 
End If

If SqlCa.SqlCode = -1 Then
	// Faz o comit no final do processo
	This.of_Grava_Arquivo("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o '" + as_Situacao + "' do log_exportacao_ecommerce." + SqlCa.SqlErrText, True)	
	Return False
End If

Return True
end function

public function boolean of_atualiza_log_exportacao (string as_situacao, string as_tabela, string as_produto);// Marca como pendentes
If as_Situacao = 'P' Then
	Update log_exportacao_ecommerce
	Set id_processado   = :as_Situacao
	Where id_processado = 'N'
	  and nm_tabela		= :as_Tabela
      and cd_filial_ecommerce = :il_Filial_Site_Em_Atualizacao
	  and id_ecommerce = '1'
	Using SqlCa;
	
	// Faz o comit no final do processo
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Arquivo("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o '" + as_Situacao + "' do log_exportacao_ecommerce." + SqlCa.SqlErrText, True)
		Return False
	Else
		SqlCa.of_Commit();
	End If
	
	Return True
End If

// Marca como j$$HEX1$$e100$$ENDHEX$$ processados
If as_Situacao = 'S' Then
	
	Update log_exportacao_ecommerce
	Set id_processado   = :as_Situacao
	Where id_processado 		= 'P'
	  and nm_tabela				= :as_Tabela
	  and cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
	  and de_chave 				= :as_Produto
 	  and id_ecommerce = '1'
    Using SqlCa;
	 
	// Faz o comit no final do processo
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Arquivo("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o '" + as_Situacao + "' do log_exportacao_ecommerce." + SqlCa.SqlErrText, True)
		Return False
	End If
		 
End If

Return True
end function

public function integer of_existe_produto_site (long pl_cd_produto);Integer li_Sucesso

String ls_Filtro
String ls_Id_Retorno_Api
String ls_Estoque_Vannon

Try
	ls_Filtro = "CodigoExterno eq '" + String( pl_Cd_Produto ) + "'"
	
	If Not This.of_Abre_Comunicacao_Api( 'GET', "produto?$filter=" + ls_Filtro ) Then Return -1	
	If This.of_Comunicacao_Api( '', 'GET',"produto?$filter=" + ls_Filtro ) < 1 Then Return -1
			
	ls_Id_Retorno_Api		= Trim( This.ivo_Gera_Json.of_Busca_Conteudo_Campo( This.ivs_Retorno_Api, 'CodigoExterno' ) )	
	ls_Estoque_Vannon	= Trim( This.ivo_gera_json.of_Busca_Conteudo_Campo( This.ivs_Retorno_Api, 'Estoque') )
	 
	If ls_Id_Retorno_Api = "" Or This.ivs_Retorno_Api = '[]' Then
		Return 0
	End If
	
	Return 1
	
Catch( RuntimeError ru )
	This.of_Grava_Arquivo( "[ERRO] GE121.uo_ecommerce_vannon.of_existe_produto_site( long )<br />" + ru.getMessage( ), True )
	Return -1
	
Finally
	This.of_Fecha_Comunicacao_Api( )
	
End Try
end function

public function boolean of_importa_status_pedidos ();Long ll_Row

For ll_Row = 1 TO UPPERBOUND( This.is_Lista_Sites[] )
	This.of_Importa_Status_Pedidos( This.is_Lista_Sites[ ll_Row ] )
NEXT

Return True
end function

public function boolean of_importa_pedidos (long pl_pedido);Long ll_Row

String ls_Nulo
SetNull(ls_Nulo)

For ll_Row = 1 TO UPPERBOUND( This.is_Lista_Sites[] )
	This.of_Importa_Pedidos( pl_Pedido, ls_Nulo, This.is_Lista_Sites[ ll_Row ] )
NEXT

Return True
end function

public function boolean of_atualiza_marcas ();Boolean 	lvb_Sucesso = True, &
			lvb_integra_xml = False

Integer 	lvi_Retorno

Long 	lvl_Linhas,&
	 	lvl_Linha,&
	 	lvl_Marca
		 
String	lvs_acao,&
		lvs_De_Marca, &
		lvs_De_Sac, &
		lvs_De_Atendimento, &
		lvs_De_Razao_Social

If Not of_verifica_conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o liberada no Desenvolvimento.", StopSign!)
	//Return False
End If

ivi_Marcas_Alteradas = 0
ivi_Marcas_Incluidas = 0

gvs_eCommerce = 'S'
	
Try
	// Abre o arquivo de log
	If Not This.of_Abre_Arquivo("ecommerce_marcas") Then Return False

	// Grava no log o in$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o
	If Not This.of_Grava_Arquivo( "[OK] GE226.uo_ecommerce_vannon.of_atualiza_marcas( ) | In$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o.", False ) Then Return False
	
	dc_uo_ds_base ivds_Marca
	ivds_Marca = Create dc_uo_ds_base
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde_2)
	w_Aguarde_2.Title = "Atualizando as marcas do eCommerce ..."
	
	lvb_Sucesso = False
	
	// Faz atualizacao pelo log_exportacao_ecommerce
	If Not ivds_Marca.of_ChangeDataObject("ds_ge226_lista_marca_log") Then
		This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_marcas( ) | ChangeDataObject( ds_ge226_lista_marca_log )", True )
		Return False
	End If
	
	// Atualiza os registros para pendentes
	If Not This.of_Atualiza_Log_Exportacao( "P", 'MARCA_PRODUTO', '' ) Then Return False // Tratamento de erro dentro da fun$$HEX2$$e700e300$$ENDHEX$$o
			
	If ivds_Marca.Retrieve( il_Filial_Site_Em_Atualizacao ) = -1 Then
		This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_marcas( ) | Retrieve", True )
		Return False
	End If
	
	lvl_Linhas = ivds_Marca.RowCount()
	
	If lvl_Linhas = 0 Then
		This.of_Grava_Arquivo( "[OK] GE226.uo_ecommerce_vannon.of_atualiza_marcas( ) | Nenhuma marca foi localizada para ser atualizada", False )
		Return True
	End If
		
	w_Aguarde_2.uo_Progress.of_SetMax(lvl_Linhas)
	
	For lvl_Linha = 1 To lvl_Linhas
	
		Yield()
		
		// Atualiza$$HEX2$$e700e300$$ENDHEX$$o pelo log_exportacao_ecommerce
		lvl_Marca = Long(ivds_Marca.Object.de_chave[lvl_Linha])
		
		w_Aguarde_2.Title = "Atualizando as marcas do eCommerce ... '"  + string(lvl_Linha) + "' de '" + string(lvl_Linhas) + "'"
		
		Select	 de_marca
		  Into :lvs_De_Marca
		From marca_ecommerce
		Where cd_marca = :lvl_Marca
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case -1
				This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_marcas( ) | " + SqlCa.sqlerrtext, True )
				Return False
				
			Case 100
				This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_marcas( ) | de_marca n$$HEX1$$e300$$ENDHEX$$o localizada para cd_marca = " + String( lvl_Marca ), True )
				
			Case 0
				//
		End Choose
			
		lvs_De_Sac = ''
		lvs_De_Atendimento = ''
		lvs_De_Razao_Social = ''
		
		lvi_Retorno =  of_existe_marca_site(lvl_Marca)
			
		Choose Case lvi_Retorno
			Case -1
				Exit
			Case 0
				lvs_acao = 'insert'
			Case Else
				lvs_acao = 'update'
		End Choose
	
		lvb_Sucesso = False
		
		lvb_integra_xml = True
		
		If This.of_atualiza_marca_site(lvl_Marca, lvs_acao) Then
			// Atualiza os registros para processados
			If This.of_Atualiza_Log_Exportacao("S", 'MARCA_PRODUTO', String(lvl_Marca) ) Then
				lvb_Sucesso = This.of_envia_marcas(String(lvl_Marca), lvs_De_Marca, lvs_De_Sac, lvs_De_Atendimento, &
																	  lvs_De_Razao_Social, lvs_acao, lvb_integra_xml)
			End If	
		End If
			
		If lvb_integra_xml  Then		
			If lvb_Sucesso Then
				SqlCa.of_Commit()
			Else
				SqlCa.of_RollBack()
			End If
		End If
			
		lvb_integra_xml = False
		w_Aguarde_2.uo_Progress.of_SetProgress(lvl_Linha)
	Next		
		
	This.of_Grava_Arquivo("Total de marcas atualizadas: " 	+ String(ivi_Marcas_Alteradas), False )
	This.of_Grava_Arquivo("Total de marcas incluidas: " 		+ String(ivi_Marcas_Incluidas),  False )
		
	// Grava o t$$HEX1$$e900$$ENDHEX$$rmino da atualiza$$HEX2$$e700e300$$ENDHEX$$o no arquivo de log
	This.of_Grava_Arquivo("Termino da atualiza$$HEX2$$e700e300$$ENDHEX$$o Marcas. Rede: " + This.is_Rede_Ecommerce, False)
	
	Return True

Finally
	If IsValid( ivds_Marca ) Then Destroy( ivds_Marca )
	FileClose(ivi_Log)	
	If IsValid( w_Aguarde_2 ) Then Close( w_Aguarde_2 )
	SetPointer(Arrow!)	
	gvs_eCommerce = 'N'
End Try

end function

public function integer of_existe_marca_site (long pl_cd_marca);Long lvl_Marca_Ecommerce
String lvs_Mensagem

Select cd_marca
   Into :lvl_Marca_Ecommerce
  From marca_produto_ecommerce
Where cd_marca =:pl_cd_marca
    And cd_filial_ecommerce =:il_Filial_Site_Em_Atualizacao 
	and id_ecommerce = '1'
 Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return 1
	Case 100
		Return 0
	Case -1
		lvs_Mensagem = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da marca_produto_ecommerce '" + String(pl_cd_marca) + ". " + SqlCa.SqlErrText
		of_Grava_Arquivo(lvs_Mensagem, True)
		Return -1
End Choose

Return 0

end function

public function boolean of_atualiza_marca_site (long pl_cd_marca, string ps_acao);DateTime lvdt_Data_Servidor

String lvs_Mensagem

lvdt_Data_Servidor = gf_Getserverdate()

If (ps_acao = "insert") Then
	INSERT INTO marca_produto_ecommerce (cd_marca, cd_filial_ecommerce, dh_atualizacao_site, id_ecommerce) 
	  VALUES  (:pl_cd_marca, :il_Filial_Site_Em_Atualizacao, :lvdt_Data_Servidor, '1') 					
	Using SqlCa;
Else
	UPDATE marca_produto_ecommerce 
	      SET dh_atualizacao_site = :lvdt_Data_Servidor 
	 WHERE cd_marca 				= :pl_cd_marca
	 	 AND cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
		 AND id_ecommerce 			= '1'
	Using SqlCa;
End If
			
If SqlCa.SqlCode = -1 Then
	lvs_Mensagem = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da marca_ecommerce_atualizacao '" + String(pl_cd_marca) + ". Filial Site: " +String( il_Filial_Site_Em_Atualizacao ) + ". " + SqlCa.SqlErrText
	of_Grava_Arquivo(lvs_Mensagem, True) 
	Return False
End If
			
Return True

end function

public function boolean of_verifica_conexao ();Return  True

String lvs_DataSource

// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia do arquivo INI
If FileExists(gvo_Aplicacao.ivs_Arquivo_INI) Then
	// Atribui valores para a conex$$HEX1$$e300$$ENDHEX$$o com o Banco de Dados
	lvs_DataSource = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "DataBase", "DataSource", "")
	
	If upper(lvs_DataSource) = 'CENTRAL'  Then
		Return  True
	Else
		gvo_Aplicacao.of_Grava_Log(  "Verifica$$HEX2$$e700e300$$ENDHEX$$o da Conex$$HEX1$$e300$$ENDHEX$$o com o Banco de Dados CENTRAL (BENS/SPACEMAN) - '" +&
		                                            "Banco diferente do esperado CENTRAL. '" )
	End If
Else
	gvo_Aplicacao.of_Grava_Log(  "Verifica$$HEX2$$e700e300$$ENDHEX$$o da Conex$$HEX1$$e300$$ENDHEX$$o com o Banco de Dados CENTRAL (BENS/SPACEMAN) - '" +&
                                                 "Arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o " + gvo_Aplicacao.ivs_Arquivo_INI + " n$$HEX1$$e300$$ENDHEX$$o localizado. '" )
End If

Return False

end function

public function boolean of_atualiza_dados_cliente ();Boolean 	lvb_Sucesso = False,&
			lvb_Disque_Entrega

Long 	lvl_Linhas,&
	 	lvl_Linha,&
	 	lvl_Filial_Disque_Anterior

String	lvs_Pedido_DrogaExpress,&
	   	lvs_Parametro,&
	   	lvs_Nulo, &
		lvs_retorno_cliente, & 
		lvs_conteudo_arquivo, &
		lvs_frete, &
		lvs_Mensagem, &
		lvs_filtro_pedido[], &
		lvs_valor_filtro[]		

If Not of_verifica_conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o liberada no Desenvolvimento.", StopSign!)
	Return False
End If

SetNull(lvs_Nulo)

// Abre o arquivo de log
If Not This.of_Abre_Arquivo("ecommerce_clientes") Then
	Return False
End If

// Grava no log o in$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o
If Not This.of_Grava_Arquivo("In$$HEX1$$ed00$$ENDHEX$$cio da importa$$HEX2$$e700e300$$ENDHEX$$o.", False) Then
	FileClose(ivi_Log)
	Return False
End If

gvs_eCommerce = 'S'

SetPointer(HourGlass!)

Open(w_Aguarde_2)

w_Aguarde_2.Title = "Importando os pedidos eCommerce..."

//lvs_filtro_pedido[1] = 'statusPedido'  //Pedidos aprovados
//lvs_valor_filtro[1] = '8'
//
//lvs_filtro_pedido[2] = 'dataInicial'  //Pedidos ainda n$$HEX1$$e300$$ENDHEX$$o integrados
//lvs_valor_filtro[2] = '2013/08/01'
//
//lvs_filtro_pedido[3] = 'dataFinal'  //Pedidos ainda n$$HEX1$$e300$$ENDHEX$$o integrados
//lvs_valor_filtro[3] = '2013/08/19'

lvs_filtro_pedido[1] = 'dataCadastroInicial'  //Pedidos aprovados
lvs_valor_filtro[1] = '2013-01-07'

lvs_filtro_pedido[2] = 'dataCadastroFinal'  //Pedidos ainda n$$HEX1$$e300$$ENDHEX$$o integrados
lvs_valor_filtro[2] = '2013-31-08'

//lvs_conteudo_arquivo = of_retorno_xml_cliente(lvs_filtro_pedido[], lvs_valor_filtro[]) 

//This.of_Grava_Arquivo(lvs_conteudo_arquivo, false)
//Repete enquanto encontrar a tag pedido no arquivo.
Do While ivo_gera_xml.of_divide_grupo_tag(Ref lvs_conteudo_arquivo, 'cliente', Ref lvs_retorno_cliente) 
	lvb_Sucesso = True	 
	ivl_Cliente 					= Long(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'idCliente'))	 
	
	w_Aguarde_2.Title = "Importando o cliente do eCommerce '" + String(ivl_Cliente) + "'..."	   
	
	 ivs_nome 					= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'nome'))
	 ivs_email 					= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'email'))
	 ivs_Fone_Ent 				= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'telefone1')
	 ivs_Fone_Contato_Ent 	= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'telefone2')
 	 ivs_Sexo 					= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'sexo'))
	  ivs_Cidade_Ent 			= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'cidade'))
	 ivs_UF_Ent 					= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'estado')

	 ivdt_DataNascimento		= Date(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'dataNascimento_dataCriacao'))
 	 
//	  ivs_cpf_cgc                   = String(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'cpf'))
//	 ivs_Endereco_Ent 		= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'endereco'))
//	 ivs_Numero_Ent 			= String(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'numero'))
//	 ivs_Complemento_Ent	= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'complemento'))
//	 ivs_Bairro_Ent 				= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'bairro'))
//	 ivs_Cidade_Ent 			= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'cidade'))
//	 ivs_UF_Ent 					= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'estado')
//	 ivs_CEP_Ent 				= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'cep')
//	 ivs_Pais_Ent 				= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'pais'))
//	 ivs_Fone_Ent 				= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'telefone1')
//	 ivs_Fone_Contato_Ent 	= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'telefone2')
	 
	 This.of_Grava_Arquivo(ivs_nome + '|' + ivs_Email + '|'+ ivs_Fone_Contato_Ent +  '|' + ivs_Fone_Ent +'|'  + ivs_Sexo +'|'  + ivs_Cidade_Ent +'|'  + ivs_UF_Ent  , False)
	 
	 // Verifica se o cliente tem cadastro  no clube
	 /*If of_Verifica_Cliente() Then		
		
		Update pedido_ecommerce
		Set id_sexo = :ivs_Sexo, 
			dh_nascimento = :ivdt_DataNascimento, 
			de_endereco = :ivs_Endereco_Ent, 
			nr_endereco = :ivs_Numero_Ent, 
			de_complemento = :ivs_Complemento_Ent, 
			de_bairro = :ivs_Bairro_Ent, 
			de_cidade = :ivs_Cidade_Ent, 
			cd_uf = :ivs_UF_Ent, 
			nr_cep = :ivs_CEP_Ent, 
			de_pais = :ivs_Pais_Ent,
			nr_fone = :ivs_Fone_Ent, 
			nr_fone_contato =:ivs_Fone_Contato_Ent 
		Where nr_pedido =:ivl_Pedido
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			lvs_Mensagem += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do pedido no eCommerce no Sybase '" + String(ivl_Pedido) + "'. " + SqlCa.SqlErrText
			lvb_Sucesso = false
		End If
			 
		 // Faz um comit por pedido, pois se houver um pedido com problema n$$HEX1$$e300$$ENDHEX$$o para o processo por completo
		 If lvb_Sucesso Then
			SqlCa.of_Commit();
			This.of_Grava_Arquivo("Pedido atualizado com sucesso: "+String(ivl_Pedido), False)			
		 Else
			SqlCa.of_RollBack();
			This.of_Grava_Arquivo(lvs_Mensagem+String(ivl_Pedido), False)		
		 End If
		 
	 End If // Cadastro cliente clube
	 */
	 
	 //w_Aguarde_2.uo_Progress.of_SetProgress(lvl_Linha)
	 Yield()
//Next
Loop

// Grava o t$$HEX1$$e900$$ENDHEX$$rmino da atualiza$$HEX2$$e700e300$$ENDHEX$$o no arquivo de log
This.of_Grava_Arquivo("T$$HEX1$$e900$$ENDHEX$$rmino da importa$$HEX2$$e700e300$$ENDHEX$$o.", False)

FileClose(ivi_Log)

Close(w_Aguarde_2)

SetPointer(Arrow!)

gvs_eCommerce = 'N'

Return True


end function

public function boolean of_importa_cadastro_cliente ();Boolean 	lvb_Sucesso = False,&
			lvb_Disque_Entrega

Long 	lvl_Linhas,&
	 	lvl_Linha,&
	 	lvl_Filial_Disque_Anterior, l_ind

String	lvs_Pedido_DrogaExpress,&
	   	lvs_Parametro,&
	   	lvs_Nulo, &
		lvs_retorno_cliente, & 
		lvs_conteudo_arquivo, &
		lvs_frete, &
		lvs_Mensagem, &
		lvs_filtro_pedido[], &
		lvs_valor_filtro[]
		
	String lvs_dataNascimento_dataCriacao, lvs_sexo, lvs_tipoPessoa, lvs_cpf, lvs_cnpj, lvs_rg, lvs_inscricaoEstadual, lvs_Email, &
				lvs_razaoSocial, lvs_nomeFantasia, lvs_nomeDoContatoNaEmpresa, lvs_telefone1, lvs_telefone2, lvs_cep, lvs_endereco, lvs_numero, &
				lvs_complemento, lvs_bairro, lvs_cidade, lvs_estado, lvs_pais, lvs_tipo, lvs_referencia, lvs_retorno
		
//uo_troca_dados_comum lvo_comum
//lvo_comum =  Create uo_troca_dados_comum 

If Not of_verifica_conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o liberada no Desenvolvimento.", StopSign!)
	Return False
End If

SetNull(lvs_Nulo)

// Abre o arquivo de log
If Not This.of_Abre_Arquivo("ecommerce_clientes") Then
	Return False
End If

// Grava no log o in$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o
If Not This.of_Grava_Arquivo("In$$HEX1$$ed00$$ENDHEX$$cio da importa$$HEX2$$e700e300$$ENDHEX$$o.", False) Then
	FileClose(ivi_Log)
	Return False
End If

gvs_eCommerce = 'S'

SetPointer(HourGlass!)

Open(w_Aguarde_2)

w_Aguarde_2.Title = "Importando os clientes eCommerce..."

//lvs_filtro_pedido[1] = 'dataCadastroInicial'  //Pedidos ainda n$$HEX1$$e300$$ENDHEX$$o integrados
//lvs_valor_filtro[1] = '2013/06/10'

//lvs_filtro_pedido[2] = 'dataCadastroFinal'  //Pedidos ainda n$$HEX1$$e300$$ENDHEX$$o integrados
//lvs_valor_filtro[2] = '2013/06/11'

//lvs_filtro_pedido[1] = 'idCliente'  //Pedidos ainda n$$HEX1$$e300$$ENDHEX$$o integrados
//lvs_valor_filtro[1] = '1'
//
//lvs_filtro_pedido[2] = 'idCliente'  //Pedidos ainda n$$HEX1$$e300$$ENDHEX$$o integrados
//lvs_valor_filtro[2] = '2'
//
//lvs_filtro_pedido[3] = 'idCliente'  //Pedidos ainda n$$HEX1$$e300$$ENDHEX$$o integrados
//lvs_valor_filtro[3] = '3'

//If Not of_Proxy_Create('RETORNO') Then Return false
	
//for l_ind = 1180001 to 1184375
for l_ind = 1184375 to 1198224

lvs_filtro_pedido[1] = 'idCliente'  //Pedidos ainda n$$HEX1$$e300$$ENDHEX$$o integrados
lvs_valor_filtro[1] = String(l_ind)
//lvs_retorno = of_retorno_xml_cliente(lvs_filtro_pedido[], lvs_valor_filtro[], Ref lvs_conteudo_arquivo) 

//Repete enquanto encontrar a tag pedido no arquivo.
Do While ivo_gera_xml.of_divide_grupo_tag(Ref lvs_conteudo_arquivo, 'cliente', Ref lvs_retorno_cliente) 
	lvb_Sucesso = True
	 
	ivl_Cliente 					= Long(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'idCliente'))
	w_Aguarde_2.Title 	= "Importando o cliente do eCommerce '" + String(ivl_Cliente) + "'..."	 
	 
	ivs_Nome						= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'nome'))
	lvs_dataNascimento_dataCriacao = ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'dataNascimento_dataCriacao')
	lvs_sexo						= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'sexo')
	lvs_tipoPessoa				= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'tipoPessoa')
	lvs_cpf							= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'cpf')
	lvs_cnpj							= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'cnpj')
	lvs_rg								= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'rg')
	lvs_inscricaoEstadual = ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'inscricaoEstadual')
	lvs_Email						= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'email')
	lvs_razaoSocial			= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'razaoSocial')
	lvs_nomeFantasia		= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'nomeFantasia')
	lvs_nomeDoContatoNaEmpresa = ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'nomeDoContatoNaEmpresa')
	lvs_telefone1				= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'telefone1')
	lvs_telefone2				= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'telefone2')
	lvs_cep							= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'cep')
	lvs_endereco				= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'endereco')
	lvs_numero					= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'numero')
	lvs_complemento		= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'complemento')
	lvs_bairro						= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'bairro')
	lvs_cidade						= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'cidade')
	lvs_estado					= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'estado')
	lvs_pais							= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'pais')
	lvs_tipo							= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'tipo')
	lvs_referencia				= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'referencia')
	 
	 lvs_Mensagem = String(ivl_Cliente) + '|' + &
	 								 	ivs_Nome + '|' + &
										lvs_dataNascimento_dataCriacao + '|' + &
										lvs_sexo + '|' + &
										lvs_tipoPessoa + '|' + &
										lvs_cpf + '|' + &
										lvs_cnpj + '|' + &
										lvs_rg + '|' + &
										lvs_inscricaoEstadual + '|' + &
										lvs_Email + '|' + &
										lvs_razaoSocial + '|' + &
										lvs_nomeFantasia + '|' + &
										lvs_nomeDoContatoNaEmpresa + '|' + &
										lvs_telefone1 + '|' + &
										lvs_telefone2 + '|' + &
										lvs_cep + '|' + &
										lvs_endereco + '|' + &
										lvs_numero + '|' + &
										lvs_complemento + '|' + &
										lvs_bairro + '|' + &
										lvs_cidade + '|' + &
										lvs_estado + '|' + &
										lvs_pais + '|' + &
										lvs_tipo + '|' + &
										lvs_referencia 

	 This.of_Grava_Arquivo(lvs_Mensagem, False)		
		
	 Yield()

Loop

next

// Grava o t$$HEX1$$e900$$ENDHEX$$rmino da atualiza$$HEX2$$e700e300$$ENDHEX$$o no arquivo de log
This.of_Grava_Arquivo("T$$HEX1$$e900$$ENDHEX$$rmino da importa$$HEX2$$e700e300$$ENDHEX$$o.", False)

FileClose(ivi_Log)

Close(w_Aguarde_2)

SetPointer(Arrow!)

gvs_eCommerce = 'N'

Return True


end function

public function boolean of_grava_cliente_farmagora (string ps_cpf_cgc);Boolean 	lvb_Sucesso = False

Long 	lvl_Cd_Filial, &
	    lvl_Cd_Cidade

Integer lvi_Pos
		  
Date lvdt_DataNascimento

String lvs_retorno_cliente, &	
		lvs_cpf_cgc, &
		lvs_Tipo_Cliente, &
		lvs_Sexo, &
		lvs_Endereco, &
		lvs_Numero, &
		lvs_Complemento, &
		lvs_Bairro, &
		lvs_Cidade, &
		lvs_UF, &
		lvs_CEP, &
		lvs_Pais, &
		lvs_Email, &
		lvs_Tipo_Pessoa, &
		lvs_Nm_Cliente, &
		lvs_Rg, &
		lvs_Razao_Social, &
		lvs_Inscricao_Estadual, &
		lvs_Tipo_Residencia, &
		lvs_Telefone1, &
		lvs_DDD_Fone, &
		lvs_Fone_Residencial, &
		lvs_Telefone2, &
		lvs_DDD_Celular, &
		lvs_Celular, &
		lvs_Matricula
	
	//Busca dados do cliente cadastrado no site
//     lvs_retorno_cliente 		= of_retorno_xml_cliente('cpf_cnpj', String(ps_cpf_cgc))  Ver Fun$$HEX2$$e700e300$$ENDHEX$$o no objeto da Webstorm

	lvs_Tipo_Cliente 			= 'RC'
	lvs_Sexo 					= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'sexo'))
	lvdt_DataNascimento		= Date(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'dataNascimento_dataCriacao'))	 
	lvs_Endereco 				= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'endereco'))
	lvs_Numero 					= String(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'numero'))
	lvs_Complemento 			= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'complemento'))
	lvs_Bairro 					= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'bairro'))
	lvs_Cidade 					= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'cidade'))
	lvs_UF 						= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'estado') 
	lvs_CEP 						= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'cep')
	lvs_Pais 						= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'pais'))
	lvs_Telefone1 				= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'telefone1')
	lvs_Telefone2	 			= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'telefone2')
	lvs_Email			 			= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'email')
	lvs_Tipo_Pessoa	 		= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'tipoPessoa'))
	lvs_Nm_Cliente	 			= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'nome'))
	lvs_Rg				 		= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'rg')
	lvs_Razao_Social 			= Upper(ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'razaoSocial'))
	lvs_Inscricao_Estadual 	= ivo_gera_xml.of_busca_conteudo_tag(lvs_retorno_cliente, 'inscricaoEstadual')
	
	If(lvs_Tipo_Pessoa = 'JURIDICA' Or lvs_Tipo_Pessoa = 'JURID$$HEX1$$cd00$$ENDHEX$$CA') Then
		lvs_Tipo_Pessoa = 'J'
	Else
		lvs_Tipo_Pessoa = 'F'
	End If	
	
 Select cd_cidade
    Into :lvl_Cd_Cidade
  From cidade
Where nm_cidade = :lvs_Cidade
  Using SqlCa;

If SqlCa.SqlCode = 100 Then
	Return False
End If

lvi_Pos = Pos(lvs_Telefone1, "(")	
lvs_DDD_Fone = Mid(lvs_Telefone1, lvi_Pos +1, 2)
lvi_Pos = Pos(lvs_Telefone1, ")")	
lvs_Fone_Residencial = Mid(lvs_Telefone1, lvi_Pos +1)
lvi_Pos 	= Pos( lvs_Fone_Residencial, "-")
lvs_Fone_Residencial = Mid(lvs_Fone_Residencial, 1, lvi_Pos -1) + Mid(lvs_Fone_Residencial, lvi_Pos +1)

lvi_Pos = Pos(lvs_Telefone2, "(")	
lvs_DDD_Celular = Mid(lvs_Telefone2, lvi_Pos +1, 2)
lvi_Pos = Pos(lvs_Telefone2, ")")	
lvs_Celular = Mid(lvs_Telefone2, lvi_Pos +1)
lvi_Pos 	= Pos( lvs_Celular, "-")
lvs_Celular = Mid(lvs_Celular, 1, lvi_Pos -1) + Mid(lvs_Celular, lvi_Pos +1)


lvl_Cd_Filial = 809
lvs_Matricula = '999999'

If Not ivo_Cliente.of_Proximo_Codigo(809, Ref ivs_cd_cliente, True) Then
	Return False
End If

Insert into cliente
					(cd_cliente, 
					id_tipo_cliente, 
					id_fisica_juridica, 
					nm_cliente, 
					nm_razao_social, 
					nr_cpf_cgc, 
					nr_inscricao_estadual, 
					nr_rg, 
					dh_nascimento, 
					id_sexo, 
					cd_cidade, 
					de_endereco, 
					nr_endereco, 
					de_complemento, 
					de_bairro, 
					nr_cep, 
					de_endereco_email, 
					nr_ddd_fone_residencial, 
					nr_fone_residencial, 
					nr_ddd_celular, 
					nr_celular, 
					cd_filial_inclusao, 
					nr_matricula_inclusao, 
					dh_inclusao, 
					cd_filial_atualizacao, 
					nr_matricula_atualizacao,
					dh_atualizacao)
		  Values (:ivs_cd_cliente, 
					:lvs_Tipo_Cliente, 
					:lvs_Tipo_Pessoa, 
					:lvs_Nm_Cliente, 
					:lvs_Razao_Social, 
					:ps_cpf_cgc, 
					:lvs_Inscricao_Estadual, 
					:lvs_Rg, 
					:lvdt_DataNascimento, 
					:lvs_Sexo, 	
					:lvl_cd_cidade, 
					:lvs_Endereco, 
					:lvs_Numero, 
					:lvs_Complemento, 
					:lvs_Bairro, 
					:lvs_CEP, 	
					:lvs_Email, 
					:lvs_DDD_Fone, 
					:lvs_Fone_Residencial, 
					:lvs_DDD_Celular, 
					:lvs_Celular, 	
					:lvl_Cd_Filial, 
					:lvs_Matricula, 
					getdate(), 
					:lvl_Cd_Filial, 
					:lvs_Matricula, 
					getdate()
					)
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				Return false
			End If	

Return True

end function

public function boolean of_atualiza_produtos (long pl_produto);Integer li_Row

For li_Row = 1 TO UPPERBOUND( This.is_Lista_Sites[] )
	This.of_Atualiza_Produtos( pl_produto, This.is_Lista_Sites[ li_Row ] )
NEXT

Return True
end function

public function boolean of_grava_cartao_comprovante_venda (string as_pedido);DateTime lvdt_Movimentacao
Date lvdt_Atual

String	lvs_Mensagem	, &
		lvs_Cd_Caixa	, &
		lvs_de_historico

Integer lvi_nr_controle_caixa	, &
		  lvi_nr_sequencial			, &
		  lvi_nr_lancamento		, &
		  li_Achou

Long ll_Pedido_Ecommerce
Long ll_Lancamento_caixa

Decimal {2} lvdc_Total

Try
	This.of_Grava_Arquivo( '[OK] [PEDIDO: ' + as_Pedido + "] In$$HEX1$$ed00$$ENDHEX$$cio da fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_cartao_comprovante_venda(string)", False )
	
	// o Vale compra est$$HEX1$$e100$$ENDHEX$$ vindo no campo "Desconto" do XML
//	If (ivdc_ValeCompra > 0) Then	
//		lvdc_Total = ivdc_Total - ivdc_ValeCompra
//	Else
//		lvdc_Total = ivdc_Total
//	End If

	lvdc_Total = ivdc_Total
	
	If ivb_Pedido_Pendente Then //Se est$$HEX1$$e100$$ENDHEX$$ gravando um pedido que j$$HEX1$$e100$$ENDHEX$$ tinha sido baixado como pendente, j$$HEX1$$e100$$ENDHEX$$ existe comprovante
		This.of_Grava_Arquivo( "[OK] Saiu da fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_cartao_comprovante_venda ( ivb_Pedido_Pendente = True )", False )
		Return True
	End If
	
	// Grava somente Cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito
	If (ivs_Forma_Pagto_Droga	<> 'CP' ) Then
		Return True
	End If
	
	If ivi_Parcelas < 1 Then
		This.of_Grava_Arquivo( "[OK] Quantidade de parcelas do cart$$HEX1$$e300$$ENDHEX$$o '" + String( ivi_Parcelas ) + "' inv$$HEX1$$e100$$ENDHEX$$lida.", False )
		Return False
	End If
	
	lvdt_Movimentacao	= gf_GetServerDate( )
	lvdt_Atual				= Date( lvdt_Movimentacao )
	lvs_Cd_Caixa			= String( ivl_Filial_Disque, "0000" ) + "00"
	
	SELECT MAX( nr_controle_caixa )
	  INTO :lvi_nr_controle_caixa 
	  FROM controle_caixa
	 WHERE cd_caixa						= :lvs_Cd_Caixa
		AND dh_movimentacao_caixa	= :lvdt_Atual
		AND dh_conferencia is null	
	Using Destino;
	
	If Destino.SqlCode <> 0 Then
		This.of_Grava_Arquivo( "[ERRO] Localiza$$HEX2$$e700e300$$ENDHEX$$o do max(nr_controle_caixa) da controle_caixa " + lvs_Cd_Caixa + " Pedido " + as_Pedido + ". " + Destino.SqlErrText, True )
		Return False
	End If
	
	If IsNull(lvi_nr_controle_caixa) or lvi_nr_controle_caixa <=0  Then
		This.of_Grava_Arquivo( "[ERRO] Sem caixa geral aberto " + lvs_Cd_Caixa + " Pedido " + as_Pedido , True )
		Return False
	End If

	This.of_Grava_Arquivo( "[OK] Localiza$$HEX2$$e700e300$$ENDHEX$$o do max(nr_controle_caixa) da controle_caixa (cd_caixa, nr_controle_caixa) (" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + ")." , False )
	
	SELECT MAX(nr_sequencial)
	  INTO :lvi_nr_sequencial
	  FROM cartao_comprovante_venda
	 WHERE cd_caixa					= :lvs_Cd_Caixa
		AND nr_controle_caixa		= :lvi_nr_controle_caixa
	USING Destino;
	
	If (Destino.SqlCode <> 0) Then
		This.of_Grava_Arquivo( "[ERRO] Localiza$$HEX2$$e700e300$$ENDHEX$$o do max(nr_sequencial) da cartao_comprovante_venda. Controle " + String(lvi_nr_controle_caixa) + " Caixa " + lvs_Cd_Caixa + ". " + Destino.SqlErrText, True )
		Return False
	End If
	
	If IsNull(lvi_nr_sequencial) or lvi_nr_sequencial <= 0 Then
		lvi_nr_sequencial = 0
	End If
	
	This.of_Grava_Arquivo( "[OK] Localiza$$HEX2$$e700e300$$ENDHEX$$o do max(nr_sequencial) da cartao_comprovante_venda (cd_caixa, nr_controle_caixa, nr_sequencial) (" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + ", " + String( lvi_nr_sequencial ) + ")." , False )
	
	lvi_nr_sequencial			= lvi_nr_sequencial + 1
	ivs_comprovante_cartao	= Mid(trim(ivs_comprovante_cartao), 1, 20)
	ivs_autorizacao_cartao	= Mid(trim(ivs_autorizacao_cartao), 1, 10)
	ivs_Estabelecimento		= Mid(trim(ivs_Estabelecimento), 1, 10)
	ivs_Bandeira_Cartao		= Mid(trim(ivs_Bandeira_Cartao), 1, 40)
	
	/*****************************************************************
	EM raz$$HEX1$$e300$$ENDHEX$$o do chamado 	417902 j$$HEX1$$e100$$ENDHEX$$ existe um registro na tabela pedido_ecommerce_auxiliar ao gravar o comprovante venda
	******************************************************************
	//Insert pedido_ecommerce_auxiliar (MATRIZ)
	ll_Pedido_Ecommerce = Long( as_Pedido ) 
	
	Select 1
	INTO :li_Achou
	FROM pedido_ecommerce_auxiliar
	WHERE cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
		AND nr_pedido 					= :ll_Pedido_Ecommerce
	USING SqlCa;

	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Arquivo( "[ERRO] Consula pedido_ecommerce_auxiliar (cd_filial_ecommerce, nr_pedido ) - (" + String(ivl_filial_ecommerce) + ", " + as_Pedido + ")." + Destino.SqlErrText, True )
		Return False
	End If	
	
	If SqlCa.SqlCode = 100 Then
		INSERT INTO pedido_ecommerce_auxiliar(
			cd_filial_ecommerce,
			nr_pedido,
			nr_comprovante_cartao_credito,
			nr_autorizacao_cartao_credito)
		Values(
			:il_Filial_Site_Em_Atualizacao,
			:ll_Pedido_Ecommerce,
			:ivs_comprovante_cartao,
			:ivs_autorizacao_cartao			
		)
		Using SqlCa;
		
		If (SqlCa.SqlCode <> 0) Then
			This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o do comprovante cartao, pedido_ecommerce_auxiliar (cd_filial_ecommerce, nr_pedido, nr_comprovante_cartao_credito, nr_autorizacao_cartao_credito) " + &
											"(" + String(il_Filial_Site_Em_Atualizacao) + ", " + as_Pedido + ", " + ivs_comprovante_cartao + ", " + ivs_autorizacao_cartao + "). " + SqlCa.SqlErrText, True )
			Return False
		End If
	End If
	**************************************/

	If as_Pedido = '129471940' Then
		as_Pedido = as_Pedido
	End If
	
	This.of_Grava_Arquivo( "[OK] Vari$$HEX1$$e100$$ENDHEX$$veis (lvi_nr_sequencial, ivs_comprovante_cartao, ivs_autorizacao_cartao, ivs_Estabelecimento, ivs_Bandeira_Cartao) " + &
									"(" + String( lvi_nr_sequencial ) + ", " + ivs_comprovante_cartao + ", " + ivs_autorizacao_cartao + ", " + ivs_Estabelecimento + ", " + ivs_Bandeira_Cartao + ")." , False )
	
	//Verifica$$HEX2$$e700e300$$ENDHEX$$o para n$$HEX1$$e300$$ENDHEX$$o inserir comprovante duplicado
	SELECT 1
	INTO :li_Achou
	FROM cartao_comprovante_venda
	WHERE cd_caixa				= :lvs_cd_caixa
		AND nr_autorizacao		= :ivs_autorizacao_cartao
		AND nr_nsu					= :ivs_comprovante_cartao
		AND vl_venda				= :lvdc_Total
		AND cd_filial					= :ivl_Filial_Disque
		AND cd_estabelecimento = :ivs_Estabelecimento
		AND qt_parcelas 			= :ivi_Parcelas
		AND id_cancelamento 	= 'N'
	 USING Destino;
	 
	Choose Case Destino.SqlCode
		Case -1 // Erro
			This.of_Grava_Arquivo( "[ERRO] Localiza$$HEX2$$e700e300$$ENDHEX$$o do cartao_comprovante_venda na verifica$$HEX2$$e700e300$$ENDHEX$$o para impedir inclus$$HEX1$$e300$$ENDHEX$$o de duplicado." + Destino.SqlErrText, True )
			Return False
			
		Case 0 // Encontrou, retorna TRUE para continuar sem incluir comprovante nem lan$$HEX1$$e700$$ENDHEX$$amento
			This.of_Grava_Arquivo( "[OK] REGISTRO J$$HEX1$$c100$$ENDHEX$$ EXISTE : Localiza$$HEX2$$e700e300$$ENDHEX$$o do cartao_comprovante_venda na verifica$$HEX2$$e700e300$$ENDHEX$$o para impedir inclus$$HEX1$$e300$$ENDHEX$$o de duplicado.", False )
			
		Case 100 // N$$HEX1$$e300$$ENDHEX$$o achou
			
			If lvdc_Total = 0.00 Then
				This.of_Grava_Arquivo( "[ERRO] [PEDIDO: " + as_Pedido + "] vl_venda da cartao_comprovante_venda est$$HEX1$$e100$$ENDHEX$$ igual a 0.00.", True )
				Return False
			End If
			
			ll_Pedido_Ecommerce = Long( as_Pedido ) 	
			
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
			VALUES (:lvs_cd_caixa,
				:lvi_nr_controle_caixa,
				:lvi_nr_sequencial,
				:ivs_Bandeira_Cartao,		//nm_produto
				'0000000000000',				//nr_cartao
				:ivs_autorizacao_cartao, 	//nr_autorizacao
				:ivs_comprovante_cartao, 	//nr_nsu
				:lvdt_Movimentacao, 			//dh_venda
				:lvdc_Total, 						//vl_venda
				:ivi_Parcelas, 					//qt_parcelas
				'T', 								//id_captura
				'N', 								//id_cancelamento
				:ivl_Filial_Disque, 				//cd_filial 
				null, 								//nr_nf
				null, 								//de_especie
				null, 								//de_serie
				:ivs_Estabelecimento,			//cd_estabelecimento
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
			Using Destino;	
			
			If (Destino.SqlCode <> 0) Then
				This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o do cartao_comprovante_venda (cd_caixa, nr_controle_caixa, nr_sequencial, nr_nsu, vl_venda) " + &
												"(" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + ", " + String( lvi_nr_sequencial ) + ", " + ivs_comprovante_cartao + ", " + String(lvdc_Total) + "). " + Destino.SqlErrText, True )
				Return False
			End If
			
			This.of_Grava_Arquivo( "[OK] Inclus$$HEX1$$e300$$ENDHEX$$o do cartao_comprovante_venda (cd_caixa, nr_controle_caixa, nr_sequencial, nr_nsu, vl_venda) " + &
											"(" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + ", " + String( lvi_nr_sequencial ) + ", " + ivs_comprovante_cartao + ", " + String(lvdc_Total) + ").", False )
			
			select nr_lancamento_caixa
				into :ll_Lancamento_caixa
			from cartao_comprovante_venda 
			where cd_caixa 			= :lvs_cd_caixa
			and nr_controle_caixa 	= :lvi_nr_controle_caixa
			and nr_sequencial 		= :lvi_nr_sequencial
			Using Destino;
			
			If (Destino.SqlCode <> 0) Then
				This.of_Grava_Arquivo( "[ERRO] Localiza$$HEX2$$e700e300$$ENDHEX$$o do nr_lancamento_caixa (cd_caixa, nr_controle_caixa) (" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + "). " + Destino.SqlErrText, True )
				Return False
			End If
			
			If Not IsNull( ll_Lancamento_caixa ) And ll_Lancamento_caixa > 0 Then
				Update lancamento_caixa set nr_documento = :as_Pedido
					where  cd_caixa 					= :lvs_cd_caixa
						and nr_controle_caixa 		= :lvi_nr_controle_caixa
						and nr_lancamento 			= :ll_Lancamento_caixa
				Using Destino;
				
				If (Destino.SqlCode <> 0) Then
					This.of_Grava_Arquivo( "[ERRO] Update nr_documento = :nr_pedido_ecommerce, lancamento_caixa (cd_caixa, nr_controle_caixa) (" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + "). " + Destino.SqlErrText, True )
					Return False
				End If
			End If
						
			
			SELECT MAX(nr_lancamento)
			   INTO :lvi_nr_lancamento
			  FROM lancamento_caixa
			 WHERE cd_caixa				= :lvs_Cd_Caixa
				 AND nr_controle_caixa	= :lvi_nr_controle_caixa
			Using Destino;
			
			If (Destino.SqlCode <> 0) Then
				This.of_Grava_Arquivo( "[ERRO] Localiza$$HEX2$$e700e300$$ENDHEX$$o do max(nr_lancamento) da lancamento_caixa (cd_caixa, nr_controle_caixa) (" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + "). " + Destino.SqlErrText, True )
				Return False
			End If
			
			If IsNull(lvi_nr_lancamento) or lvi_nr_lancamento <= 0 Then
				lvi_nr_lancamento = 0
			End If
			
			lvi_nr_lancamento = lvi_nr_lancamento + 1
	
			This.of_Grava_Arquivo( "[OK] Localiza$$HEX2$$e700e300$$ENDHEX$$o do max(nr_lancamento) da lancamento_caixa (cd_caixa, nr_controle_caixa, nr_lancamento) (" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + ", " + String( lvi_nr_lancamento ) + "). ", False )
			
			lvs_de_historico = 'REF. PED :' + as_Pedido + ' - ECOMMERCE'
			
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
			VALUES (:lvs_cd_caixa,
				:lvi_nr_controle_caixa,
				:lvi_nr_lancamento,
				'205', 						//cd_conta_fluxo_caixa
				:lvdt_Movimentacao, 	//dh_lancamento 
				:lvdc_Total, 				//vl_lancamento
				:lvs_de_historico,		//de_historico
				null, 						//nr_recibo_cobranca
				null, 						//id_sumarizacao
				'N', 						//id_estorno
				null, 						//dh_exportacao
				:as_Pedido,				//nr_documento 
				null  						//cd_filial_transferencia
			)
			Using Destino;	
			
			If Destino.SqlCode <> 0 Then
				This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o do lancamento_caixa (cd_caixa, nr_controle_caixa, nr_lancamento) (" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + ", " + String( lvi_nr_lancamento ) + "). " + Destino.SqlErrText, True )
				Return False
			End If
			
			This.of_Grava_Arquivo( "[OK] Inclus$$HEX1$$e300$$ENDHEX$$o do lancamento_caixa (cd_caixa, nr_controle_caixa, nr_lancamento) (" + lvs_Cd_Caixa + ", " + String( lvi_nr_controle_caixa ) + ", " + String( lvi_nr_lancamento ) + ").", False )
	
	End Choose
	//
	
	This.of_Grava_Arquivo( "[OK] T$$HEX1$$e900$$ENDHEX$$rmino da fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_cartao_comprovante_venda(string)", False )
	
	Return True
	
Catch( RuntimeError ru )
	This.of_Grava_Arquivo( ru.getMessage( ), True )
	
Finally
	//
End Try
end function

public function boolean of_grava_pedido_pendente ();Boolean lvb_Sucesso = True

Long ll_Achou

String lvs_Mensagem

SELECT nr_pedido
INTO :ll_Achou
FROM pedido_ecommerce_pendente
WHERE cd_filial_ecommerce	= :il_Filial_Site_Em_Atualizacao
AND nr_pedido						= :ivl_pedido
USING SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o localiza$$HEX2$$e700e300$$ENDHEX$$o da pedido_ecommerce_pendente '" + String(ivl_Pedido) + "'. " + SqlCa.SqlErrText + " | of_grava_pedido_pendente( )", True )
		Return False
		
	Case 0
		This.of_Grava_Arquivo( "[ALERTA] PEDIDO: " + String(ivl_Pedido) + " j$$HEX1$$e100$$ENDHEX$$ existe em pedido_ecommerce_pendente. Processo continua. | of_grava_pedido_pendente( )", False )
		Return True
		
End Choose

INSERT INTO pedido_ecommerce_pendente
		 ( cd_filial_ecommerce,
		   nr_pedido,   
		   dh_atualizacao,   
		   id_status,
		   nm_administradora_cartao ,
		   nr_comprovante_cartao,
		   nr_autorizacao_cartao,
		   cd_estabelecimento_cartao,
		   cd_filial
		)  
VALUES ( :il_Filial_Site_Em_Atualizacao,	//cd_filial_ecommerce
			:ivl_pedido, 		      				//nr_pedido, 
			getdate(),							//dh_atualizacao,
			:ivs_situacao, 				    		//id_status,
			:ivs_Bandeira_Cartao,			//nm_administradora_cartao ,
			:ivs_comprovante_cartao,		//nr_comprovante_cartao,
			:ivs_autorizacao_cartao,			//nr_autorizacao_cartao,
			:ivs_Estabelecimento,				//cd_estabelecimento_cartao
			:ivl_Filial_Disque					//cd_filial
		   ) 
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o da pedido_ecommerce_pendente '" + String(ivl_Pedido) + "'. " + SqlCa.SqlErrText + " | of_grava_pedido_pendente( )", True )
	Return False
End If

If SqlCa.SQLNRows <> 1 Then
	This.of_Grava_Arquivo( "[ALERTA] O pedido j$$HEX1$$e100$$ENDHEX$$ foi gravado em pedido_ecommerce_pendente '" + String(ivl_Pedido) + "' | of_grava_pedido_pendente( )", True )
	Return False
End If

This.of_Grava_Arquivo( "[OK] Inclus$$HEX1$$e300$$ENDHEX$$o da pedido_ecommerce_pendente '" + String(ivl_Pedido) + "' | of_grava_pedido_pendente( )", False )

Return True
	
end function

public function boolean of_proximo_nr_lancamento (string as_caixa, long al_controle, ref long al_nr_lancamento);String lvs_Mensagem

SELECT MAX(nr_lancamento)
  INTO :al_nr_lancamento
  FROM lancamento_caixa
 WHERE cd_caixa = :as_Caixa
   AND nr_controle_caixa = :al_Controle
Using Destino;

Choose Case Destino.SqlCode
	Case 0
		If IsNull(al_nr_lancamento) Then al_nr_lancamento = 0
		al_nr_lancamento ++
	Case 100
		al_nr_lancamento = 1
	Case -1
		lvs_Mensagem = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo lan$$HEX1$$e700$$ENDHEX$$amento." + Destino.SqlErrText
		of_Grava_Arquivo(lvs_Mensagem, True)
		Return False
End Choose

Return True
end function

public function boolean of_cancela_cartao_comprovante (string ps_autorizacao_cartao, string ps_comprovante_cartao, string ps_cd_estabelecimento, long pl_pedido_ecommerce);
Date lvdt_Parametro, lvdt_Atual

Datetime lvdt_Movimentacao, lvdt_emissao

Decimal {2} lvdc_total_pedido

String lvs_Historico, &
		 lvs_Caixa, &
	     lvs_Caixa_Incluir, &
		 lvs_Mensagem, &
		 lvs_Operador, &
		 lvs_Cancelado, &
		 lvs_cd_forma_pagamento, &
		 lvs_de_historico

String ls_Pedido_Ecommerce

Long lvl_Linha, &
	  lvl_Comprovante, &
	  lvl_Lancamento_Estornar, &
	  lvl_Lancamento_Incluir, &
	  lvl_Nr_Lancamento, &
	  lvl_Controle, &
	  lvl_Controle_Incluir, &
	  lvl_nr_sequencial
	
 Select cd_caixa, nr_controle_caixa, nr_sequencial, nr_lancamento_caixa, id_cancelamento, vl_venda
    Into :lvs_Caixa, :lvl_Controle, :lvl_nr_sequencial, :lvl_Lancamento_Estornar, :lvs_Cancelado, :lvdc_total_pedido
   from cartao_comprovante_venda
Where nr_autorizacao = :ps_autorizacao_cartao
    and nr_nsu 			 = :ps_comprovante_cartao
    and cd_estabelecimento = :ps_cd_estabelecimento
	and id_cancelamento = 'N'
Using Destino;

If Destino.SqlCode = 100 Then
	lvs_Mensagem = "Comprovante n$$HEX1$$e300$$ENDHEX$$o localizado para o Pedido " + String(pl_pedido_ecommerce) 
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
End If

If Destino.SqlCode <> 0 Then
	lvs_Mensagem = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do Comprovante do Cart$$HEX1$$e300$$ENDHEX$$o. Pedido " + String(pl_pedido_ecommerce) + ". " + Destino.SqlErrText
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
End If

// Grava lan$$HEX1$$e700$$ENDHEX$$amento de estorno na conta de adiantamento
lvdt_Atual = Date(gf_GetServerDate())

SELECT MAX(nr_controle_caixa)
  INTO :lvl_Controle_Incluir
  FROM controle_caixa
 WHERE cd_caixa = :lvs_Caixa
   AND dh_conferencia IS NULL
	AND dh_movimentacao_caixa = :lvdt_Atual
Using Destino;

If (Destino.SqlCode <> 0) Then
	lvs_Mensagem = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do caixa aberto. Pedido " + String(pl_pedido_ecommerce) + ". " + Destino.SqlErrText
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
End If

If lvl_Controle_Incluir <=0 or IsNull(lvl_Controle_Incluir) Then
	lvs_Mensagem = "Nenhum caixa aberto encontrado."
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
End If

If Not of_proximo_nr_lancamento(lvs_Caixa, lvl_Controle_Incluir, Ref lvl_nr_lancamento ) Then
	Return False
End If

lvs_de_historico = 'REF. PED :' + String(pl_pedido_ecommerce) + ' - ECOMMERCE'
lvdt_Movimentacao = gf_GetServerDate()

ls_Pedido_Ecommerce = String( pl_pedido_ecommerce )

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
VALUES (:lvs_caixa,
	:lvl_Controle_Incluir,
	:lvl_nr_lancamento,
	'205', 						//cd_conta_fluxo_caixa
	:lvdt_Movimentacao, 	//dh_lancamento 
	:lvdc_total_pedido, 	//vl_lancamento
	:lvs_de_historico,		//de_historico
	null, 						//nr_recibo_cobranca
	null, 						//id_sumarizacao
	'S', 						//id_estorno
	null, 						//dh_exportacao
	 :ls_Pedido_Ecommerce, 						//nr_documento 
	null  						//cd_filial_transferencia
)
Using Destino;	

If Destino.SqlCode <> 0 Then
	lvs_Mensagem = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o inclus$$HEX1$$e300$$ENDHEX$$o do estorno do adiantamento. Pedido " + String(pl_pedido_ecommerce) + ". " + Destino.SqlErrText
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
End If

If lvs_Cancelado = 'S' Then
	Return True
End If

// Cancela o comprovante do cart$$HEX1$$e300$$ENDHEX$$o

Select dh_movimentacao Into :lvdt_Parametro
From parametro
Using Destino;

Update cartao_comprovante_venda
Set id_cancelamento = 'S',
	 dh_exportacao   = :lvdt_Parametro
Where cd_caixa          = :lvs_Caixa
  and nr_controle_caixa = :lvl_Controle
  and nr_sequencial     = :lvl_Nr_Sequencial
Using Destino;

If Destino.SqlCode = -1 Then
	lvs_Mensagem = "Erro no cancelamento do Comprovante do Cart$$HEX1$$e300$$ENDHEX$$o. Pedido " + String(pl_pedido_ecommerce) + ". " + Destino.SqlErrText
	of_Grava_Arquivo(lvs_Mensagem, True)
	Return False
Else
	// Estorna o lan$$HEX1$$e700$$ENDHEX$$amento de caixa se houver
	Update lancamento_caixa
	Set id_estorno    = 'X',
		 dh_exportacao = :lvdt_Parametro
	Where cd_caixa          = :lvs_Caixa
	  and nr_controle_caixa = :lvl_Controle
	  and nr_lancamento     = :lvl_Lancamento_Estornar
	Using Destino;

	If Destino.SqlCode = -1 Then
		lvs_Mensagem = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do Lan$$HEX1$$e700$$ENDHEX$$amento Estornado. Pedido " + String(pl_pedido_ecommerce) + ". " + Destino.SqlErrText
	     of_Grava_Arquivo(lvs_Mensagem, True)
		Return False
	Else				
		If Not of_proximo_nr_lancamento(lvs_Caixa, lvl_Controle_Incluir, Ref lvl_Lancamento_Incluir ) Then
			Return False
		End If
		
		Insert Into lancamento_caixa (cd_caixa,   
												nr_controle_caixa,   
												nr_lancamento,   
												cd_conta_fluxo_caixa,   
												dh_lancamento,   
												vl_lancamento,   
												de_historico,   
												nr_recibo_cobranca,
												id_sumarizacao,
												id_estorno,
												cd_caixa_origem,
												nr_controle_caixa_origem,
												nr_lancamento_origem,
												nr_documento)  
		Select :lvs_Caixa,
				 :lvl_Controle_Incluir,
				 :lvl_Lancamento_Incluir,
				 cd_conta_fluxo_caixa,
				 dh_lancamento,
				 vl_lancamento,
				 de_historico,
				 null,
				 null,
				 'S',
				 :lvs_Caixa,
				 :lvl_Controle,
				 :lvl_Lancamento_Estornar,
				 :ls_Pedido_Ecommerce
		From lancamento_caixa
		Where cd_caixa          = :lvs_Caixa
		  and nr_controle_caixa = :lvl_Controle
		  and nr_lancamento     = :lvl_Lancamento_Estornar
		Using Destino;
		
		If Destino.SqlCode = -1 Then
			lvs_Mensagem = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do Lan$$HEX1$$e700$$ENDHEX$$amento de Estorno. Pedido " + String(pl_pedido_ecommerce) + ". " + Destino.SqlErrText
	    		of_Grava_Arquivo(lvs_Mensagem, True)
			Return False
		End If
	End If
End If

Return True
end function

public function boolean of_reserva_etiqueta_correio (long pl_pedido, string ps_nm_transportadora);
String lvs_Nr_Etiqueta

Long lvl_Cd_Seq_Etiqueta

Long lvl_Id_Servico

If ps_Nm_Transportadora = NM_TRANPORTADORA_TOTAL_EXPRESS Then Return True

// Consulta o id_servico, que eh utilizado na reserva de etiquetas
If Trim( ps_Nm_Transportadora ) = '' Then
	SELECT nm_transportadora
	INTO :ps_Nm_Transportadora
	FROM pedido_ecommerce
	WHERE cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
		AND nr_pedido 					= :pl_Pedido
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		of_Grava_Arquivo( "[ERRO] Pedido: " + String(pl_Pedido) + " | Consulta nm_transportadora em pedido_ecommerce. " + SqlCa.SqlErrText, True )
		Return False
	End If
End If


SELECT id_servico
INTO :lvl_Id_Servico
FROM ecommerce_servico_postagem
WHERE de_servico = :ps_Nm_Transportadora
USING SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		of_Grava_Arquivo( "[ERRO] Pedido: " + String(pl_Pedido) + " | Consulta id_servico em ecommerce_servico_postagem. " + SqlCa.SqlErrText, True )
		Return False
		
	Case 100
		of_Grava_Arquivo( "[ERRO] Pedido: " + String(pl_Pedido) + " | Nao foi localizado id_servico em ecommerce_servico_postagem para de_servico = '" + ps_Nm_Transportadora + "'.", True )
		Return False
		
End Choose
//

/*
If ps_Nm_Transportadora = 'SEDEX' Then
	lvl_Id_Servico = 109810 //E-SEDEX STANDARD	
Else
	If ps_Nm_Transportadora = 'ESEDEX' Then
		lvl_Id_Servico = 104672 //E-SEDEX STANDARD	
	Else
		lvl_Id_Servico = 109819 //PAC
	End If
End If
*/

SELECT nr_etiqueta_com_dig
   INTO :lvs_Nr_Etiqueta
    FROM ecommerce_reserva_etiqueta
  WHERE nr_pedido = :pl_Pedido
   USING sqlCa;
	
If SqlCa.SqlCode = 0 Then
 	of_Grava_Arquivo( "[ALERTA] Pedido: " + String(pl_Pedido) + " | j$$HEX1$$e100$$ENDHEX$$ possui etiqueta reservada", True )
	Return True
End If

SELECT	TOP 1 cd_seq_etiqueta,
			nr_etiqueta_com_dig
	INTO 	:lvl_Cd_Seq_Etiqueta,
			:lvs_Nr_Etiqueta
    FROM ecommerce_reserva_etiqueta
  WHERE nr_pedido IS NULL
      AND id_servico =:lvl_Id_Servico
ORDER BY cd_seq_etiqueta ASC;	
	
If SqlCa.SqlCode = -1 Then
 	of_Grava_Arquivo( "[ERRO] Pedido: " + String(pl_Pedido) + " | reserva de etiquetas do correio. | " + SqlCa.SqlErrText, True )
	Return False
End If						

If lvl_Cd_Seq_Etiqueta <=0 Then
 	of_Grava_Arquivo( "[ERRO] Pedido: " + String(pl_Pedido) + " | N$$HEX1$$e300$$ENDHEX$$o foi encontrada etiqueta dispon$$HEX1$$ed00$$ENDHEX$$vel para o pedido.", True )
	Return False
End If

If lvl_Cd_Seq_Etiqueta = 211003 Then
	lvl_Cd_Seq_Etiqueta = lvl_Cd_Seq_Etiqueta
End if

UPDATE ecommerce_reserva_etiqueta
	   SET nr_pedido 									= :pl_Pedido,
			cd_filial_ecommerce						= :il_Filial_Site_Em_Atualizacao
   WHERE cd_seq_etiqueta 							= :lvl_Cd_Seq_Etiqueta
	 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
 	of_Grava_Arquivo( "[ERRO] Pedido: " + String(pl_Pedido) + " | reserva de etiquetas do correio. | " + SqlCa.SqlErrText, True )
	Return False
End If	

UPDATE pedido_ecommerce
	   SET de_codigo_rastreamento_correio 	= :lvs_Nr_Etiqueta
   WHERE cd_filial_ecommerce 					= :il_Filial_Site_Em_Atualizacao
	  AND  nr_pedido 								= :pl_Pedido
	 Using SqlCa;
	 
If SqlCa.SqlCode = -1 Then
 	of_Grava_Arquivo( "[ERRO] Pedido: " + String(pl_Pedido) + " | reserva de etiquetas do correio. | " + SqlCa.SqlErrText, True )
	Return False
End If

Return True

end function

public function string of_filial_ecommerce (string ps_parametro);String lvs_Filial

Select vl_parametro
Into :lvs_Filial
From parametro_geral
Where cd_parametro = :ps_parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		Return '790'
	Case -1
		SqlCa.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial eCommerce na PARAMETRO_GERAL')
		Return '0'
End Choose

Return lvs_Filial

		




end function

public subroutine of_fecha_comunicacao_api ();
IF IsValid(iole_SrvHTTP) THEN 	Destroy iole_SrvHTTP 
end subroutine

public function integer of_comunicacao_api (string ps_json, string ps_metodo, string ps_tipo_integracao);/*
Return 1 - Sucesso
Return 0 - Erro, vai para a pr$$HEX1$$f300$$ENDHEX$$xima atualiza$$HEX2$$e700e300$$ENDHEX$$o
Return -1 - Erro, cancela todas as atualiza$$HEX2$$e700f500$$ENDHEX$$es
*/

string ls_post_url, &
			ls_postid_pswd, &
			ls_status_text
			
String ls_Mensagem_Response_Text
String ls_Codigo_Mensagem_Response_Text

Long  ll_status_code			

//DESENVOLVIMENTO*********************************************
//If ivb_Ambiente_Teste Then
//	Return 1
//End If

IF IsValid(iole_SrvHTTP) THEN
	
	TRY
		If IsNull( ps_Json ) Then ps_Json = ''
		
		This.of_Grava_Arquivo('[OK] ps_metodo: ' + ps_metodo + ' | ps_tipo_integracao: ' + ps_tipo_integracao + ' | ps_Json: ' + ps_Json + ' | of_comunicacao_api( string, string, string)', False)
		
		If(ps_metodo = 'GET') Then
		 	iole_SrvHTTP.Send(iole_Send)
		Else
			iole_SrvHTTP.send(ps_json) 
		End If
		
	CATCH (RuntimeError e) 
		This.of_Grava_Arquivo('[ERRO] Send. Rotina: ' + ps_tipo_integracao + '. ' + e.getMessage(), True)
		Return 0 
	END TRY 
	
	ll_status_code = iole_SrvHTTP.readyState 
	IF iole_SrvHTTP.readyState <> 4 THEN
		iole_SrvHTTP.DisconnectObject() 
		Destroy iole_SrvHTTP 
		
		This.of_Grava_Arquivo( '[ERRO] ReadyState. Rotina: ' + String(ll_status_code) + " | of_comunicacao_api( string, string, string)", True )
		Return -1
	End If
	
	//Get response 
	ls_status_text = iole_SrvHTTP.StatusText 
	ll_status_code = iole_SrvHTTP.Status 
	
	ivs_Retorno_Api = String( iole_SrvHTTP.ResponseText )
	
	//Check HTTP Response code for errors 
	If ll_status_code >= 300 Then
		
		ls_Mensagem_Response_Text				= ivo_gera_json.of_busca_conteudo_campo ( ivs_Retorno_Api, 'Mensagem' )
		ls_Codigo_Mensagem_Response_Text	= ivo_gera_json.of_busca_conteudo_campo ( ivs_Retorno_Api, 'CodigoMensagem' )
		
		If ls_Codigo_Mensagem_Response_Text = 'NaoEncontrado' Then
			ls_Codigo_Mensagem_Response_Text = ls_Codigo_Mensagem_Response_Text
		End If
		
		If ls_Mensagem_Response_Text = "Pedido n$$HEX1$$e300$$ENDHEX$$o encontrado(a)." Then
			ls_Mensagem_Response_Text = This.of_Formata_Fonte_Vermelha( "Pedido n$$HEX1$$fa00$$ENDHEX$$mero " + ivo_gera_json.of_busca_conteudo_campo ( ps_Json, 'NumeroPedido' ) + " n$$HEX1$$e300$$ENDHEX$$o encontrado na Vannon." )
			
			This.of_Grava_Arquivo( '[ERRO] ' + ls_Mensagem_Response_Text + '~r~rPar$$HEX1$$e200$$ENDHEX$$metros integra$$HEX2$$e700e300$$ENDHEX$$o: ' + ps_Json + '~r~rRetorno integra$$HEX2$$e700e300$$ENDHEX$$o: ' + ivs_Retorno_Api, True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
		Else
			This.of_Grava_Arquivo('[ERRO] Status. Rotina: ' + String(ll_status_code) +' - '+ ivs_Retorno_Api, True)
		End If
				
		Return 0
	End If
End If

Return 1



end function

public function boolean of_abre_comunicacao_api (string ps_metodo, string ps_tipo_integracao);string ls_post_url, &
			ls_postid_pswd, &
			ls_status_text, &
			ls_response_text

Long  ll_status_code

This.of_Grava_Arquivo('[OK] Envio:' + ps_tipo_integracao + ' | Metodo:' + ps_metodo + ' | of_abre_comunicacao_api(string, string)', False)

Choose Case is_Rede_Ecommerce	
	Case 'FA'
		ls_post_url		= 'https://integracao.farmagora.com.br/'+ps_tipo_integracao
		ls_postid_pswd	= '42MDCTIOZ8'
		
		// ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o
//		ls_post_url		= 'http://http://integracaofarmagora.vannonline.com.br//'+ps_tipo_integracao
//		ls_postid_pswd	= '42MDCTIOZ8'
		
		// ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o SAP
//		ls_post_url = 'http://integracaosapmkt.vannonecommerce.com.br/'+ps_tipo_integracao
//		ls_postid_pswd	= '42MDCTIOZ8'
		
	Case 'DC'
		//Producao
//		ls_post_url		= 'http://integracao.drogariacatarinense.com.br/'+ps_tipo_integracao
//		ls_postid_pswd	= '42MDCTIOZ8'	
		
		ls_post_url		= 'http://integracaocatarinense.vannonecommerce.com.br/'+ps_tipo_integracao
		ls_postid_pswd	= '42MDCTIOZ8'	
				
	Case 'MP'
		ls_post_url		= 'http://integracaomanipulacaocatarinense.vannonecommerce.com.br/'+ps_tipo_integracao
		ls_postid_pswd	= 'LLQ3Q92J2Q'
		
		//ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o
//		ls_post_url		= 'http://integracao.vfarma.vannonline.com.br/'+ps_tipo_integracao
//		ls_postid_pswd	= '42MDCTIOZ8'
	
End Choose

IF Not IsValid(iole_SrvHTTP) THEN
	iole_SrvHTTP = CREATE oleobject 		
	iole_Send = CREATE oleobject	
	iole_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")	
	iole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")	

	//iole_SrvHTTP.setTimeouts(5000,6000,10000,10000)
	This.of_Grava_arquivo( "[INFO] Realizando conex$$HEX1$$e300$$ENDHEX$$o com " + ls_post_url, False )
	If IsValid( w_Aguarde ) Then w_Aguarde.Title = "Realizando conex$$HEX1$$e300$$ENDHEX$$o com " + ls_post_url
	Yield( )
	
	iole_SrvHTTP.open (ps_metodo, ls_post_url, false) 
	iole_SrvHTTP.setRequestHeader("AUTHORIZATION", "ApiKey dan: " + ls_postid_pswd) 
	iole_SrvHTTP.SetRequestHeader( "Content-Type", "application/json")
	
	// Trust the SSL Certificate 
	iole_SrvHTTP.setOption(2,'13056') 
	
End If


Return True



end function

public function long of_saldo_produto (datastore ads, long pl_produto, long pl_filial);Long lvl_Find,&
	 lvl_Saldo
Long lvl_Saldo_Reservado
Long ll_Linhas, ll_Row

String ls_distribuidora

Decimal ldc_fator_conversao
	 
lvl_Find = ads.Find("cd_produto = " + String (pl_Produto) + " and cd_filial = " + String(pl_filial) , 1, ads.RowCount())

If lvl_Find = -1 Then
	This.of_Grava_Arquivo("Erro ao localizar o saldo do produto "+String (pl_Produto)+".", True)
	Return 0
End If

If lvl_Find > 0 Then
	lvl_Saldo = ads.Object.qt_saldo_final[lvl_Find]
Else
	lvl_Saldo = 0	
End If

This.of_saldo_produto_reservado( pl_Filial, pl_Produto, Ref lvl_Saldo_Reservado )

If pl_Filial <> 454 Then
	lvl_Saldo = lvl_Saldo - lvl_Saldo_Reservado
Else
	ll_Linhas = ids_Ordem_Distribuidora.Retrieve( pl_filial, pl_produto  )

	If ll_Linhas < 0 Then
		of_Grava_Arquivo( "[ERRO] Pedido: " + String( ivl_Pedido ) + " | Retrieve ordem distribuidora " + String( pl_Produto ) + ". " + SqlCa.SqlErrText, True )
		Return -1
	End If
	
	For ll_Row = 1 TO ll_Linhas
		ls_Distribuidora = ids_Ordem_Distribuidora.Object.cd_distribuidora [ ll_Row ]  

		lvl_Saldo +=This.of_saldo_disponivel_distribuidora( pl_filial, pl_produto, ls_Distribuidora, 'SALDO', Ref ldc_fator_conversao)
	Next
	   
	lvl_Saldo = lvl_Saldo - lvl_Saldo_Reservado
End If // If pl_Filial <> 454

If lvl_Saldo < 0 Then lvl_Saldo = 0

Return lvl_Saldo

end function

public function boolean of_envia_produto_praca (long pl_cd_produto, long pl_estoque, decimal pdc_preco, decimal pdc_preco_promocao, string ps_acao, boolean pb_atualiza_preco, string ps_inicio_promocao, string ps_termino_promocao, long pl_filial, boolean pb_disponivel);
Boolean lvb_Integracao = True

Decimal lvdc_Perc_Desconto, lvdc_preco_promocao

String lvs_json_produto_praca

If pdc_preco_promocao <= 0 Then
	pdc_preco_promocao = pdc_preco
End If

//Tratamento DC
//O saldo da filial 454 ser$$HEX1$$e100$$ENDHEX$$ utilizado na FILIAL_SITE_DC
If This.is_Rede_ecommerce = 'DC' And pl_Filial = 454 Then
	pl_Filial = FILIAL_SITE_DC
End If

lvs_json_produto_praca  = '{"CodigoProdutoSku": "'+ String(pl_cd_produto) + '", '
lvs_json_produto_praca  += '"CodigoPraca": "'+ String(pl_filial, '000') + '", '

If pb_Atualiza_Preco Then
	lvs_json_produto_praca  += '"Ativo": '+ String(pb_Disponivel) + ', '
	lvs_json_produto_praca  += '"Promocao": false, ' // Nunca habilita promocao no backoffice
//	If pb_Atualiza_Preco And pdc_preco_promocao > 0.00 And pdc_preco_promocao < pdc_preco Then
//		lvs_json_produto_praca  += '"Promocao": true, '
//	Else
//		lvs_json_produto_praca  += '"Promocao": false, '
//	End If
End If


lvs_json_produto_praca  += '"Estoque": ' + String(pl_estoque) + ', '
lvs_json_produto_praca  += '"EstoqueMinimo": 0, '
lvs_json_produto_praca  += '"PrazoPostagem": 6 '

If pb_Atualiza_Preco Then
	If pdc_preco_promocao > 0.00 Then
		lvdc_Perc_Desconto = Round((((pdc_preco - pdc_preco_promocao) / pdc_preco) * 100), 2)
		lvdc_preco_promocao = pdc_preco_promocao
	Else
		lvdc_Perc_Desconto = 0.00
		lvdc_preco_promocao = pdc_preco
	End If
	
	If Date(ps_termino_promocao) >= Date('01/01/2100') Then
		ps_termino_promocao = '2030-12-31'
	End If
	
	lvs_json_produto_praca  += ', "Desconto":  '+ gf_replace(String(lvdc_Perc_Desconto), ',' , '.' ,0) + ' , '
	//lvs_json_produto_praca  += '"InicioPromocao": "' + ps_inicio_promocao + '", '
	//lvs_json_produto_praca  += '"FimPromocao": "' + ps_termino_promocao + '", '
	//lvs_json_produto_praca  += '"PrecoPromocaoDe": '+ gf_replace(String(pdc_preco), ',' , '.' ,0) + ' , '
	//lvs_json_produto_praca  += '"PrecoPromocaoPor": '+ gf_replace(String(lvdc_preco_promocao), ',' , '.' ,0) + ' , '
	lvs_json_produto_praca  += '"PrecoDe": '+ gf_replace(String(pdc_preco), ',' , '.' ,0) + ' , '
	lvs_json_produto_praca  += '"PrecoPor": '+ gf_replace(String(lvdc_preco_promocao), ',' , '.' ,0) 	
End If

lvs_json_produto_praca  += ' },'

//Agrupa v$$HEX1$$e100$$ENDHEX$$rios produtos
If(ps_acao = 'insert') Then
	ivs_xml_produto_praca_insert +=  lvs_json_produto_praca
Else
	If pb_Atualiza_Preco Then
		ivs_xml_produto_praca_update +=  lvs_json_produto_praca
	Else
		ivs_xml_produto_praca_update_parcial +=  lvs_json_produto_praca
	End If
End If

Return lvb_Integracao

end function

private function boolean of_atualiza_produto_site (long pl_cd_produto, string ps_acao, boolean pb_disponivel);
DateTime lvdt_Data_Servidor

String lvs_Mensagem, lvs_Id_Disponivel_Site

Integer li_Count

If (pb_Disponivel = false) Then
	lvs_Id_Disponivel_Site = 'N'
Else
	lvs_Id_Disponivel_Site= 'S'
End If

select count(cd_produto)
	into :li_Count
	from produto_ecommerce_atualizacao
		where cd_filial_ecommerce = :il_Filial_Site_Em_Atualizacao
			and cd_produto				= :pl_cd_produto
			and id_ecommerce  = '1'
		Using SqlCa;

If SqlCa.SqlCode = -1 Then
	lvs_Mensagem = "Erro na consulta produto_ecommerce_atualizacao '" + String(pl_cd_produto) + ". " + SqlCa.SqlErrText
	of_Grava_Arquivo(lvs_Mensagem, True) 
	Return False
End If	

If li_Count > 0 Then
	UPDATE produto_ecommerce_atualizacao 
		SET id_disponivel_site 		= :lvs_Id_Disponivel_Site 
	 WHERE cd_produto				= :pl_cd_produto
		  AND cd_filial_ecommerce	= :il_Filial_Site_Em_Atualizacao	
		  and id_ecommerce  = '1'
	Using SqlCa;
	
Else
	lvdt_Data_Servidor = gf_Getserverdate()
	
	INSERT INTO produto_ecommerce_atualizacao (cd_produto, cd_filial_ecommerce, id_disponivel_site, dh_inclusao_site, id_ecommerce) 
		  VALUES  (:pl_cd_produto, :il_Filial_Site_Em_Atualizacao, :lvs_Id_Disponivel_Site, :lvdt_Data_Servidor, '1') 
	Using SqlCa;
		
End If
			
If SqlCa.SqlCode = -1 Then
	lvs_Mensagem = "Erro na inclusao/atualizacao do produto_ecommerce_atualizacao '" + String(pl_cd_produto) + ". " + SqlCa.SqlErrText
	of_Grava_Arquivo(lvs_Mensagem, True) 
	Return False
End If
			
Return True
end function

public function integer of_envia_grupo_produto ();Integer lvb_Integracao = 1

//------------- INSERT - POST --------------------#
If ivs_xml_produto_insert <> '' Then
	ivs_xml_produto_insert = '[' + ivs_xml_produto_insert  + ']'
	If of_abre_comunicacao_api('POST','produto') Then		
			lvb_Integracao = of_comunicacao_api(ivs_xml_produto_insert,'POST','produto')	
			If lvb_Integracao = 1 Then
				ivi_Produtos_Incluidos ++
			End If
		of_fecha_comunicacao_api()
	End If
End If	
ivs_xml_produto_insert = ''
	
If lvb_Integracao <> -1 and ivs_xml_produto_sku_insert <> '' Then
	ivs_xml_produto_sku_insert = '[' + ivs_xml_produto_sku_insert  + ']'
	If of_abre_comunicacao_api('POST','sku') Then
		lvb_Integracao = of_comunicacao_api(ivs_xml_produto_sku_insert,'POST','sku')
		If lvb_Integracao = 1 Then
			ivi_Produtos_Sku_Incluidos ++
		End If
		of_fecha_comunicacao_api()
	End If
End If
ivs_xml_produto_sku_insert = ''
	
If lvb_Integracao <> -1 and ivs_xml_produto_praca_insert <> '' Then
	ivs_xml_produto_praca_insert = '[' + ivs_xml_produto_praca_insert  + ']'
	If of_abre_comunicacao_api('POST','produtopraca') Then
			//of_Grava_Arquivo('Pra$$HEX1$$e700$$ENDHEX$$a:' + ivs_xml_produto_praca_insert , False)
			lvb_Integracao = of_comunicacao_api(ivs_xml_produto_praca_insert,'POST','produtopraca')			
			If lvb_Integracao = 1 Then
				ivi_Produtos_Praca_Incluidos ++
			End If
			of_fecha_comunicacao_api()
	End If
End If
ivs_xml_produto_praca_insert = ''

//------------- UPDATE TOTAL - PUT--------------------#
If lvb_Integracao <> -1  and ivs_xml_produto_update <> '' Then
	ivs_xml_produto_update = '[' + ivs_xml_produto_update  + ']'
	If of_abre_comunicacao_api('PATCH','produto') Then
			lvb_Integracao = of_comunicacao_api(ivs_xml_produto_update,'PATCH','produto')	
			If lvb_Integracao = 1 Then
				ivi_Produtos_Alterados ++
			End If
			of_fecha_comunicacao_api()		
	End If
End If	
ivs_xml_produto_update = ''

If lvb_Integracao <> -1 and ivs_xml_produto_sku_update <> '' Then
	ivs_xml_produto_sku_update = '[' + ivs_xml_produto_sku_update  + ']'
	If of_abre_comunicacao_api('PUT','sku') Then			
			lvb_Integracao = of_comunicacao_api(ivs_xml_produto_sku_update,'PUT','sku')			
			If lvb_Integracao = 1 Then
				ivi_Produtos_Sku_Alterados ++
			End If
			of_fecha_comunicacao_api()
	End If
End If
ivs_xml_produto_sku_update = ''
		
If lvb_Integracao <> -1 and ivs_xml_produto_praca_update <> '' Then
	
	ivs_xml_produto_praca_update = '[' + ivs_xml_produto_praca_update  + ']'
	If of_abre_comunicacao_api('PUT','produtopraca') Then
			lvb_Integracao = of_comunicacao_api(ivs_xml_produto_praca_update,'PUT','produtopraca')
			If lvb_Integracao = 1 Then
				ivi_Produtos_Praca_Alterados ++
			End If
			of_fecha_comunicacao_api()
	End If
End If
ivs_xml_produto_praca_update = ''

//------------- UPDATE PARCIAL - PATCH--------------------#
If lvb_Integracao <> -1  and ivs_xml_produto_praca_update_parcial <> '' Then
	ivs_xml_produto_praca_update_parcial = '[' + ivs_xml_produto_praca_update_parcial  + ']'
	If lvb_Integracao <> -1  Then
		If of_abre_comunicacao_api('PATCH','produtopraca') Then
				lvb_Integracao = of_comunicacao_api(ivs_xml_produto_praca_update_parcial,'PATCH','produtopraca')	
				If lvb_Integracao = 1 Then
					ivi_Produtos_Praca_Alterados ++
				End If
				of_fecha_comunicacao_api()
		End If
	End If
End If
ivs_xml_produto_praca_update_parcial = ''
	
Return lvb_Integracao
end function

public function boolean of_envia_marcas (string ps_cd_marca, string ps_de_marca, string ps_de_sac, string ps_de_atendimento, string ps_de_razao_social, string ps_acao, boolean pb_integra_xml);
Boolean lvb_Retorno = True

String	 lvs_texto_xml, &
		 	 lvs_retorno_api

Integer lvi_Retorno

If IsNull(ps_de_sac) Then
	ps_de_sac = ''
End If
If IsNull(ps_de_atendimento) Then
	ps_de_atendimento = ''
End If
If IsNull(ps_de_razao_social) Then
	ps_de_razao_social = ''
End If

lvs_texto_xml  = '[ { "Ativo": true, "CodigoExterno": "'+ps_cd_marca+'", "Nome": "'+ps_de_marca+'" } ]'

//Agrupa v$$HEX1$$e100$$ENDHEX$$rias marcas
If(ps_acao = 'insert') Then
	ivs_xml_marca_insert +=  lvs_texto_xml
Else
	ivs_xml_marca_update += lvs_texto_xml
End If

If pb_integra_xml Then
	If ivs_xml_marca_insert <> '' Then		
		lvb_Retorno = of_abre_comunicacao_api('POST','marca')
		lvi_Retorno = of_comunicacao_api(ivs_xml_marca_insert,'POST','marca')
		of_fecha_comunicacao_api()
		ivs_xml_marca_insert = ''
	End If
	
	If lvb_Retorno and ivs_xml_marca_update <> '' Then		
		lvb_Retorno = of_abre_comunicacao_api('PUT','marca')
		lvi_Retorno = of_comunicacao_api(ivs_xml_marca_update,'PUT','marca')
		of_fecha_comunicacao_api()
		ivs_xml_marca_update = ''	
	End If
End If

Return lvb_Retorno


end function

public function boolean of_envia_email (integer ai_codigo_mensagem, string as_assunto, string as_mensagem);String ls_Usuario

DateTime ldh_Server

ldh_Server = gf_GetServerDate( )

// S$$HEX1$$f300$$ENDHEX$$ envia email durante o hor$$HEX1$$e100$$ENDHEX$$rio de expediente
If ai_Codigo_Mensagem = CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA Then
	// Se n$$HEX1$$e300$$ENDHEX$$o for entre segunda e sexta inclusive, n$$HEX1$$e300$$ENDHEX$$o envia
	If DayNumber( Date( ldh_Server ) ) < 2 Or DayNumber( Date( ldh_Server ) ) > 6 Then Return True
	
	// Se n$$HEX1$$e300$$ENDHEX$$o for entre 8 e 18 horas inclusive, n$$HEX1$$e300$$ENDHEX$$o envia
	If Hour( Time( ldh_Server ) ) < 8 Or Hour( Time( ldh_Server ) ) > 18 Then Return True
End If
//

ls_Usuario = gvo_Aplicacao.of_UserId( )

If IsNull( ls_Usuario ) Then ls_Usuario = 'N/I'


as_Mensagem += '<br /><br /><br />Computador: ' + gvo_Aplicacao.is_ComputerName + ' | Usu$$HEX1$$e100$$ENDHEX$$rio: ' + ls_Usuario
as_Mensagem += '<br />Data/Hora: ' + String( Today( ), "dd/mm/yyyy" ) + " " + String( Now( ), "hh:mm:ss" )

Return gf_ge202_envia_email_automatico(	ai_codigo_mensagem, &
														as_Assunto, &
														as_Mensagem )
			
end function

public function boolean of_grava_arquivo (string as_mensagem, boolean ab_envia_email, integer ai_codigo_email);String lvs_Mensagem

Integer lvi_Write

If ab_Envia_Email Then
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'EC' Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", as_Mensagem, StopSign! )
	End If
End If

lvs_Mensagem = "REDE E-commerce: " + This.is_rede_ecommerce + " - " + String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + &
               " - " + as_Mensagem

lvi_Write = FileWrite(ivi_Log, lvs_Mensagem)

If lvi_Write = Len(lvs_Mensagem) Then
	
	If ab_envia_email Then
		This.of_envia_email( ai_Codigo_Email, "ECOMMERCE", gf_Replace( lvs_Mensagem, '~r', '<br />', 0 ) )
	End If
	
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de LOG.", StopSign!)
	Return False
End If
end function

public function string of_formata_fonte_vermelha (string ps_texto);Return '<font color="#ff0000">' + ps_Texto + "</font>"
end function

public function boolean of_valida_endereco ();Boolean lb_Retorno = False

Long ll_Sucesso

String ls_SqlCa_Erro_Saida_Padrao

String ls_Mensagem
String ls_Mensagem_Aux
String ls_UF_Clamed
String ls_Cep_ECT

ls_Mensagem = "Valida$$HEX2$$e700e300$$ENDHEX$$o de endere$$HEX1$$e700$$ENDHEX$$o.~r~r"
ls_Mensagem += "Pedido: " + String( ivl_Pedido ) + '~r'
ls_Mensagem += "Cep Vannon: " + ivs_CEP_Ent + '~r'

If Not gf_Valida_Informacoes_Cliente( ivs_Bairro, 3, ref ls_Mensagem_Aux ) Then
	ls_Mensagem += This.of_Formata_Fonte_Vermelha( "~rBairro do cliente informado no pedido n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido: " + ivs_Bairro + '~r' )
End If

If Not gf_Valida_Informacoes_Cliente( ivs_Bairro_Ent, 3, ref ls_Mensagem_Aux ) Then
	ls_Mensagem += This.of_Formata_Fonte_Vermelha( "~rBairro de entrega informado no pedido n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido: " + ivs_Bairro_Ent + '~r' )
End If

// Envia email sobre erro no bairro
If PosA( ls_Mensagem, "Bairro" ) > 0 Then
	This.of_Grava_Arquivo(	ls_Mensagem + "~r~rCorrija a informa$$HEX2$$e700e300$$ENDHEX$$o na Vannon para que o pedido seja importado.", True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
	Return False
End If

If Not IsNull( ivs_Cep_Substituicao ) And Trim( ivs_Cep_Substituicao ) <> "" Then
	ls_Mensagem += "Cep Informado:" + This.of_Formata_Fonte_Vermelha( ivs_Cep_Substituicao ) + '~r'
End If

ls_Mensagem += "UF Vannon: " + String( ivs_UF_Ent ) + '~r~r'
	
If ivs_Cep_Substituicao = ivs_CEP_Ent Then // Conforme chamado 222787, quando houver importa$$HEX2$$e700e300$$ENDHEX$$o com preenchimento de CEP na tela, ignora as valida$$HEX2$$e700f500$$ENDHEX$$es
	This.of_Grava_Arquivo( ls_Mensagem + This.of_Formata_Fonte_Vermelha( "Pedido importado com substitui$$HEX2$$e700e300$$ENDHEX$$o de CEP." ), True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
	Return True
End If

Try
	ls_SqlCa_Erro_Saida_Padrao = SqlCa.of_Get_Erro_Saida_Padrao( ) // Armazena para restaurar na saida da funcao
	SqlCa.of_Set_Erro_Saida_Padrao( 'LOG' )
	
	// Para n$$HEX1$$e300$$ENDHEX$$o tornar ls_mensagem NULL
	If IsNull( ivs_CEP_Ent ) Then	ivs_CEP_Ent = ''
	If IsNull( ivs_UF_Ent ) Then		ivs_UF_Ent = ''
	
	If LenA( ivs_CEP_Ent ) <> 8 Then
		This.of_Grava_Arquivo( ls_Mensagem + This.of_Formata_Fonte_Vermelha( "Cep retornado na integra$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o possui tamanho correto." ), True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
		Return False
	End If
	
	If LenA( ivs_UF_Ent ) <> 2 Then
		This.of_Grava_Arquivo( ls_Mensagem +  This.of_Formata_Fonte_Vermelha( "UF retornado na integra$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o possui tamanho correto." ), True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
		Return False
	End If
	
	// Se for RETIRAR NA LOJA, valida UF de entrega contra UF da filial, sen$$HEX1$$e300$$ENDHEX$$o, valida UF de entrega contra UF do CEP de entrega cadastrado em nossa base de dados
	If This.ivs_Transportadora = 'RETIRAR NA LOJA' Then
		SELECT cd_uf
		INTO :ls_UF_Clamed
		FROM vw_filial
		WHERE cd_filial = :ivl_Filial_Disque
		USING SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			This.of_Grava_Arquivo( ls_Mensagem +  This.of_Formata_Fonte_Vermelha( "Localiza$$HEX2$$e700e300$$ENDHEX$$o do CEP em vw_endereco." ), True )
			Return False
		End If
		
		If ls_Uf_Clamed <> ivs_UF_Ent Then
			This.of_Grava_Arquivo( ls_Mensagem +  This.of_Formata_Fonte_Vermelha( "UF retornada na integra$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ diferente da UF (" + ls_UF_Clamed + ") da filial escolhida para retirada do pedido." ), True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
			Return False
		End If
		
		lb_Retorno = True
	End If
	
	SELECT DISTINCT cd_uf
	INTO :ls_UF_Clamed
	FROM vw_endereco
	WHERE nr_cep = :ivs_CEP_Ent
	USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If ls_Uf_Clamed <> ivs_UF_Ent Then
				This.of_Grava_Arquivo( ls_Mensagem +  This.of_Formata_Fonte_Vermelha( "UF retornada na integra$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ diferente da UF (" + ls_UF_Clamed + ") encontrada em nossa base de dados." ), True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
				Return False
			End If
			
		Case 100
			SELECT DISTINCT cd_uf
			INTO :ls_UF_Clamed
			FROM ect_localidade
			WHERE nr_cep = :ivs_CEP_Ent
			USING SqlCa;
					
			Choose Case SqlCa.SqlCode
				Case 0
					If ls_Uf_Clamed <> ivs_UF_Ent Then
						This.of_Grava_Arquivo(	ls_Mensagem +  This.of_Formata_Fonte_Vermelha( "UF retornada na integra$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ diferente da UF (" + ls_UF_Clamed + ") encontrada em nossa base de dados." + &
														"~r~rPor ser RETIRADA NA LOJA, o pedido foi importado, mas $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio revisar o cadastro."), True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
						Return lb_Retorno
					End If
					
				Case 100
					If lb_Retorno Then // Retirada na loja, alerta sobre problema no cep mas retorna true para importar o pedido
						This.of_Grava_Arquivo(	ls_Mensagem +  This.of_Formata_Fonte_Vermelha( "CEP retornado na integra$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o encontrado em nossa base de dados." + &
														"~r~rPor ser RETIRADA NA LOJA, o pedido foi importado, mas $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio revisar o cadastro." ), True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
					Else
						// pesquisa pelo sigepweb
						Blob lb_args
						Long ll_length
						String ls_headers
						String ls_Argumentos
						uo_internetresult result
						result = create uo_internetresult
						inet intranet
						intranet = create inet
						
						ls_Argumentos = "ambiente=producao&argumento=buscaUFPorCep&cep=" + ivs_CEP_Ent
						lb_args	= blob( ls_Argumentos, EncodingANSI! )
						ll_length 	= Len(lb_args)
						ls_headers = "Content-Type: " + &
										 "application/x-www-form-urlencoded~n" + &
										 "Content-Length: " + String( ll_length ) + "~n~n"
						
						ll_Sucesso = intranet.PostURL( "http://10.0.0.16/_inc/sigep/v2/SigepWeb.class.php",lb_args,ls_headers, result )						
						
						If ll_Sucesso <> 1 Then
							Choose Case ll_Sucesso
								Case -1 
									ls_Mensagem = 'General error'			
								Case -2
									ls_Mensagem = 'Invalid URL'			
								Case -4
									ls_Mensagem = 'Cannot connect to the Internet'			
								Case -6
									ls_Mensagem = 'Internet request failed'			
							End Choose
						End If
						
						ls_Cep_ECT = result.is_data
						ls_Cep_ECT = Mid( ls_Cep_ECT, Pos( ls_Cep_ECT, '<buscaUFPorCepRetorno>' ) + 22, 2 )
						
						destroy intranet
						destroy result
						
						If ls_Cep_ECT = ivs_UF_Ent Then
							Return True
						End If
						
						ls_Mensagem = ls_Mensagem + This.of_Formata_Fonte_Vermelha( "CEP retornado na integra$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o encontrado em nossa base de dados." )
						ls_Mensagem += "~r~rVerifique qual $$HEX1$$e900$$ENDHEX$$ o CEP correto para ent$$HEX1$$e300$$ENDHEX$$o importar o pedido pela tela de Importa$$HEX2$$e700e300$$ENDHEX$$o de Pedido, preenchendo o CEP correto na tela."
						This.of_Grava_Arquivo( ls_Mensagem, True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
					End If
					
					Return lb_Retorno
					
				Case -1
					This.of_Grava_Arquivo( ls_Mensagem +  This.of_Formata_Fonte_Vermelha( "Localiza$$HEX2$$e700e300$$ENDHEX$$o do CEP em vw_endereco." ), True )
					Return lb_Retorno
			End Choose
			
		Case -1
			This.of_Grava_Arquivo( ls_Mensagem +  This.of_Formata_Fonte_Vermelha( "Localiza$$HEX2$$e700e300$$ENDHEX$$o do CEP em vw_endereco." ), True )
			Return lb_Retorno
	End Choose
	
	Return True
	
Catch( RuntimeError ru )
	This.of_Grava_Arquivo( "GE121 - uo_ecommerce_vannon.of_valida_endereco( long, string, string )<br />" + ru.getMessage( ), True )
	Return False
	
Finally
	 SqlCa.of_Set_Erro_Saida_Padrao( ls_SqlCa_Erro_Saida_Padrao ) // Restaura a saida padrao de erros do SqlCa
End Try
end function

public function boolean of_pedido_possui_inconsistencia ();// Retorna True quando possui alguma inconsistencia

If Not This.of_Valida_Endereco( ) Then
	Return True
End If

If Not This.of_Valida_Transportadora( ) Then
	Return True
End If

Return False
end function

public function boolean of_valida_transportadora ();String ls_Mensagem

ls_Mensagem = "Valida$$HEX2$$e700e300$$ENDHEX$$o de modalidade de entrega.~r~r"
ls_Mensagem += "Pedido: " + String( ivl_Pedido ) + '~r~r'

If This.ivs_Transportadora = "" Then
	This.of_Grava_Arquivo( ls_Mensagem +  This.of_Formata_Fonte_Vermelha( "Modalidade de entrega n$$HEX1$$e300$$ENDHEX$$o informada no pedido." ), True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
	Return False
End If

Return True
end function

public function boolean of_valida_cartao_credito ();String ls_Mensagem

ls_Mensagem = "Valida$$HEX2$$e700e300$$ENDHEX$$o do pagamento com cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito.~r~r"
ls_Mensagem += "Pedido: " + String( ivl_Pedido ) + '~r'
ls_Mensagem += "Status do pagamento: " + This.of_status_pagamento_vannon( ivs_Situacao ) + '~r~r'

If Trim( This.ivs_Autorizacao_Cartao ) = "" Or IsNull( This.ivs_Autorizacao_Cartao ) Then
	This.of_Grava_Arquivo( ls_Mensagem +  This.of_Formata_Fonte_Vermelha( "NSU n$$HEX1$$e300$$ENDHEX$$o localizado na integra$$HEX2$$e700e300$$ENDHEX$$o." ), True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
	Return False
End If

Return True
end function

public function string of_status_pagamento_vannon (string ps_sigla);Choose Case Trim( Upper( ps_Sigla ) )
	Case 'PCO'
		Return "Aprovado - Pagamento confirmado"

	Case 'PCB'
		Return "Aprovado - Pagamento confirmado Boleto"
			
	Case 'AGA'
		Return "Em an$$HEX1$$e100$$ENDHEX$$lise - AGA - Aguardando Aprova$$HEX2$$e700e300$$ENDHEX$$o"
	
	Case 'NAA' 
		Return "N$$HEX1$$e300$$ENDHEX$$o autorizado Antifraude (Clearsale)"
		
	Case Else
		Return "Status '" + ps_Sigla + "' n$$HEX1$$e300$$ENDHEX$$o previsto."
		
End Choose
end function

public function boolean of_exclui_pedido_pendente (long pl_pedido);
//****************************Funcao nao utilizada****************************
Return True



DELETE FROM pedido_ecommerce_pendente
WHERE nr_pedido = :pl_Pedido
USING SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_Grava_Arquivo( "[ERRO] [PEDIDO: " + String( pl_pedido ) + "] Exclus$$HEX1$$e300$$ENDHEX$$o do pedido_ecommerce_pendente. " + SqlCa.SqlErrText, True )
	Return False
End If

DELETE 
FROM pedido_ecommerce_pendente_prd
WHERE nr_pedido = :pl_pedido
USING SqlCa;
	
If SqlCa.SqlCode = -1 Then
	This.of_Grava_Arquivo( "[ERRO] [PEDIDO: " + String( pl_pedido ) + "] Exclus$$HEX1$$e300$$ENDHEX$$o do pedido_ecommerce_pendente_prd. " + SqlCa.SqlErrText, True )
	Return False
End If
	
SqlCa.of_Commit() ;
This.of_Grava_Arquivo( "[OK] [PEDIDO: " + String( pl_pedido ) + "] Pedido pendente exclu$$HEX1$$ed00$$ENDHEX$$do com sucesso.", False ) 

Return True
end function

public function boolean of_cancela_reserva_produto_perini (integer pi_filial, long pl_pedido);// pl_pedido = nr_pedido_ecommerce

Long lvl_Cd_Filial
Long ll_Produto
Long ll_Qtde_Pedida
Long ll_Nova_Linha
Long ll_Pedido_Empurrado

Try
	SELECT MAX( nr_pedido_empurrado )
	INTO :ll_Pedido_Empurrado
	FROM pedido_empurrado
	WHERE cd_filial			= :pi_filial
	AND id_tipo_pedido	= 'F'
	AND id_situacao		= 'C'
	USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			This.of_Grava_Arquivo( "[ERRO] PEDIDO: " + String( pl_pedido ) + " Localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido_empurrado com situacao COLOCADO.~r" + SqlCa.SqlErrText , True )
			Return False
			
		Case 100
			Return True
	End Choose
	
	DECLARE l_cursor CURSOR FOR 
	SELECT	cd_produto,
				qt_pedida_empurrada
	FROM pedido_ecommerce_produto
	WHERE nr_pedido = :pl_Pedido
	USING SqlCa;
	
	OPEN l_cursor;
	
	FETCH l_cursor
		INTO	:ll_Produto,
				:ll_Qtde_Pedida;
				
	DO WHILE SQLCA.sqlcode = 0
		
		UPDATE pedido_empurrado_produto
		SET qt_empurrada = qt_empurrada - :ll_Qtde_Pedida
		WHERE cd_filial					= :pi_filial
		AND nr_pedido_empurrado 	= :ll_Pedido_Empurrado
		AND cd_produto				= :ll_Produto
		USING SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			This.of_Grava_Arquivo( "[ERRO] PEDIDO: " + String( pl_pedido ) + " Atualiza$$HEX2$$e700e300$$ENDHEX$$o do pedido_empurrado_produto.~r" + SqlCa.SqlErrText , True )
			Return False
		End If
		
		DELETE FROM pedido_empurrado_produto
		WHERE cd_filial					= :pi_filial
		AND nr_pedido_empurrado 	= :ll_Pedido_Empurrado
		AND cd_produto				= :ll_Produto
		AND qt_empurrada			< 1
		USING SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			This.of_Grava_Arquivo( "[ERRO] PEDIDO: " + String( pl_pedido ) + " Exclus$$HEX1$$e300$$ENDHEX$$o do pedido_empurrado_produto com qt_empurrada = 0.~r" + SqlCa.SqlErrText , True )
			Return False
		End If
		
		FETCH l_cursor
			INTO	:ll_Produto,
					:ll_Qtde_Pedida;
	LOOP
	
	CLOSE l_cursor;
	
	SELECT COUNT( * )
	INTO :ll_Qtde_Pedida
	FROM pedido_empurrado_produto
	WHERE cd_filial						= :pi_filial
		AND nr_pedido_empurrado 	= :ll_Pedido_Empurrado
	USING SqlCa;
		
	Choose Case SqlCa.SqlCode
		Case -1
			This.of_Grava_Arquivo( "[ERRO] PEDIDO EMPURRADO: " + String( ll_Pedido_Empurrado ) + " COUNT( * ) do pedido_empurrado_produto.~r" + SqlCa.SqlErrText , True )
			Return False
			
		Case 0
			If ll_Qtde_Pedida = 0 Then // Pedido sem produto, exclui o pedido
				DELETE FROM pedido_empurrado
				WHERE cd_filial						= :pi_filial
					AND nr_pedido_empurrado 	= :ll_Pedido_Empurrado
				 USING SqlCa;
				 
				If SqlCa.SqlCode = -1 Then
					This.of_Grava_Arquivo( "[ERRO] PEDIDO EMPURRADO: " + String( ll_Pedido_Empurrado ) + " Exclus$$HEX1$$e300$$ENDHEX$$o do pedido_empurrado sem produtos.~r" + SqlCa.SqlErrText , True )
					Return False
				Else
					This.of_Grava_Arquivo( "[NOT$$HEX1$$cd00$$ENDHEX$$CIA] PEDIDO EMPURRADO: " + String( ll_Pedido_Empurrado ) + " Exclus$$HEX1$$e300$$ENDHEX$$o do pedido_empurrado sem produtos.~r" + SqlCa.SqlErrText , True )
				End If				 
			End If
	End Choose
	
	Return True
	
Catch( RuntimeError ru )
	This.of_Grava_Arquivo( "GE226 - uo_ecommerce_vannon.of_cancela_reserva_produto_perini( integer, long )~r" + ru.getMessage( ), True )
	Return False
	
Finally
	CLOSE l_cursor;
End Try
	
end function

public function boolean of_importa_produtos_pedido (long al_pedido, string as_retorno, string as_pedido_drogaexpress, boolean ab_pedido_pendente);Date lvdt_Inicio_Promocao, lvdt_Termino_Promocao

Decimal{2} lvdc_Peso, lvdc_Cubagem, lvdc_Preco, lvdc_Preco_Promo, lvdc_Preco_Total
Decimal{2} ldc_Desconto_PBM

Long lvl_Produto, lvl_Categoria, ll_Achou, ll_Requisicao_Manip, ll_sequencial

Integer lvi_Qtde

String lvs_Produto_Ecommerce, lvs_Produto, lvs_Fornecedor, lvs_Cor, lvs_Tamanho, lvs_Estilo, lvs_Aro, lvs_pedido_produto, lvs_produtos, lvs_Mensagem

Try
	This.is_Mensagem_Email_Pedido_Empurrado = ""
	
	ivo_gera_json.of_divide_grupo_json_tag(Ref as_retorno, 'PedidoProdutoSku', Ref lvs_pedido_produto,']') 
	
	Do While ivo_gera_json.of_divide_grupo_json_completo(Ref lvs_pedido_produto, Ref lvs_produtos,'{') 
		SetNull(ll_Requisicao_Manip)
		
		ll_sequencial++
		
		lvs_Produto_Ecommerce	= TRIM(ivo_gera_json.of_busca_conteudo_campo(lvs_produtos, 'CodigoProdutoSku'))
		lvi_Qtde						= Integer(ivo_gera_json.of_busca_conteudo_campo(lvs_produtos, 'Quantidade'))
		lvl_produto					= Long(ivo_gera_json.of_busca_conteudo_campo(lvs_produtos, 'CodigoProdutoSku'))
		
		If lvi_Qtde <= 0 Then
			This.of_Grava_Arquivo( "[ERRO] Quantidade '" + String( lvi_Qtde ) + "' inv$$HEX1$$e100$$ENDHEX$$lida para o produto '" + String( lvl_produto ) + "'.", True )
		End If
		
		ivo_Produto.of_Localiza_Codigo_Interno( lvl_Produto )
		
  	 	If This.is_rede_ecommerce = 'MP' Then
			lvs_Produto = Upper( ivo_gera_json.of_busca_conteudo_campo( lvs_produtos, 'Nome') )
			
			If Mid(lvs_Produto_Ecommerce, 1, 2) = 'FC' Then	
				lvl_produto	= 684431 //Produto Manipulado
				lvs_Produto	= "(" + lvs_Produto_Ecommerce + ") " + lvs_Produto
			Else

				If PosA(lvs_Produto, 'OR$$HEX1$$c700$$ENDHEX$$AMENTO' ) > 0  OR PosA(lvs_Produto, 'ORCAMENTO' ) > 0 Or  PosA(lvs_Produto, 'REQUISICAO' ) > 0 Then
					If Not ivo_Produto.Localizado Then
						ll_Requisicao_Manip 	= Long( lvs_Produto_Ecommerce )
						lvl_Produto 				= 684431 //Produto Manipulado
					End If
				Else
					If Not ivo_Produto.Localizado Then
						This.of_Grava_Arquivo( "[ERRO] Produto n$$HEX1$$e300$$ENDHEX$$o localizado." + lvs_Produto , False)
						Return False
					Else
						lvs_Produto	= ivo_Produto.de_descricao_internet
					End If
				End If
			End If
		Else //Demais Redes
			If Not ivo_Produto.Localizado Then
				This.of_Grava_Arquivo( "[ERRO] Produto n$$HEX1$$e300$$ENDHEX$$o localizado." + lvs_Produto , False)
				Return False
			Else 
				lvs_Produto	= ivo_Produto.de_descricao_internet
			End If
		End If
			
		lvl_Categoria			= 0
		lvs_Fornecedor			= '0'
		lvdc_Preco				= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_produtos, 'ValorReal'),'.',',',0)) 		//valorReal
		lvdc_Preco_Promo		= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_produtos, 'ValorProduto'),'.',',',0)) 	//valorUnitario
		
		ldc_Desconto_PBM = 0.00
		If ivo_gera_json.of_existe_campo( lvs_produtos, "PorcentagemDescontoPBM" ) Then
			ldc_Desconto_PBM = Dec( gf_replace( ivo_gera_json.of_busca_conteudo_campo( lvs_produtos, 'PorcentagemDescontoPBM' ), '.', ',', 0) ) //DescontoPBM
		End If				
		
		If IsNull( ldc_Desconto_PBM ) Then ldc_Desconto_PBM = 0.00
		
		lvdc_Preco_Promo = ( ( 100 - ldc_Desconto_PBM ) / 100 ) * lvdc_Preco_Promo
		
		If lvdc_Preco = 0 Then
			This.of_Grava_Arquivo( "[ERRO] PEDIDO: " + String( This.ivl_Pedido ) + " Valor do produto " + String(lvl_produto) + " est$$HEX1$$e100$$ENDHEX$$ 0 para o pedido " + String(al_Pedido), True )
			Return False
		End If
		
		If lvdc_Preco_Promo > lvdc_Preco Then
			lvdc_Preco_Promo = 0
		End If
		
		lvdc_Preco_Total = lvdc_Preco //Dec(ivo_gera_json.of_busca_conteudo_campo(lvs_produtos, 'total'))
		
		If Not of_Grava_Produto_Pedido(al_Pedido, lvs_Produto_Ecommerce, lvi_Qtde, lvs_Produto,&
									 lvl_produto, lvl_Categoria, lvs_Fornecedor, lvs_Cor,&
									 lvs_Tamanho, lvs_Estilo, lvs_Aro, lvdc_Peso, lvdc_Cubagem,&
									 lvdc_Preco, lvdc_Preco_Promo, lvdt_Inicio_Promocao,&
									 lvdt_Termino_Promocao, as_Pedido_DrogaExpress,&
									 lvdc_Preco_Total, ll_sequencial, ll_Requisicao_Manip, lvs_Produto  ) Then
			 Return False
		 
		End If
	Loop
	
	If This.is_Mensagem_Email_Pedido_Empurrado <> "" Then
		This.of_Grava_Arquivo( "[OK] Foi realizado um pedido automaticamente para o CD para atender a um pedido Farmagora com pagamento APROVADO.~r~rFilial: " + &
										String( This.ivl_Filial_Disque ) + "~rPedido Farmagora: " + String( This.ivl_Pedido ) + " de " + String( This.ivdt_Compra, "dd/mm/yyyy hh:mm:ss" ) + This.is_Mensagem_Email_Pedido_Empurrado, False )
	End If

	Return True
Finally
	
End Try
end function

public subroutine of_marca_capturado ();ivs_json_captura_pedido = '[{"NumeroPedido": "53886017"},{"NumeroPedido": "33761019"},{"NumeroPedido": "64567864"},{"NumeroPedido": "23073339"},{"NumeroPedido": "00702136"}]'

//Marcar no site os pedidos que j$$HEX1$$e100$$ENDHEX$$ foram integrados pelo ERP.
If Not This.ivb_Ambiente_Teste Then // Se for ambiente de teste, n$$HEX1$$e300$$ENDHEX$$o atualiza o site
	//ivs_json_captura_pedido= '['+ ivs_json_captura_pedido +']'
		
	Try		
		If This.of_abre_comunicacao_api('POST','pedidocaptura') Then
			This.of_comunicacao_api(ivs_json_captura_pedido,'POST','pedidocaptura')	
		End If
			
	Finally		
		This.of_fecha_comunicacao_api( )
	End Try
End If
end subroutine

public function boolean of_valida_valores_pedido ();Decimal ldc_Total_Produtos

Try	
	ldc_Total_Produtos = (ivdc_Produtos_Calculado - ivdc_ValeCompra) + ivdc_Frete
	
	Return True
Catch( runtimeerror ru )
Finally
End Try
end function

public function boolean of_saldo_produto_reservado (integer pi_filial, long pl_produto, ref long pl_saldo_pendente);TRY
	SELECT COALESCE( SUM( pep.qt_pedida ), 0 )
	INTO :pl_Saldo_Pendente
	FROM pedido_ecommerce pe
		INNER JOIN pedido_ecommerce_produto pep
			ON pep.nr_pedido = pe.nr_pedido
	WHERE pe.dh_compra >= (select DATEADD (day , -30 , dh_movimentacao ) from parametro where id_parametro = '1')
	AND pe.cd_filial			= :pi_Filial
	AND pe.nr_pedido		> 999999
	AND pe.id_situacao	in ('P','A')
	AND pep.cd_produto	= :pl_Produto
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Arquivo( "[ERRO] Localiza$$HEX2$$e700e300$$ENDHEX$$o da saldo pendente do produto '" + String( pl_Produto ) + "'. " + SqlCa.SqlErrText + " | of_saldo_produto_reservado( )", True )
		Return False		
	End If
	
	Return True
	
FINALLY
	If IsNull( pl_Saldo_Pendente ) Then pl_Saldo_Pendente = 0
END TRY
end function

public function integer of_consulta_qtde_pedido_empurrado (integer pi_filial, long pl_produto, string ps_distribuidora, ref long pl_qt_empurrada, ref long pl_qt_fracionada);
//Qtde empurrada distribuidora
SELECT	COALESCE( SUM( prd.qt_empurrada ), 0 ) as qt_empurrada, 
			COALESCE( SUM( prd.qt_empurrada_fracionada ), 0 ) as qt_empurrada_fracionada 
	INTO :pl_qt_empurrada, :pl_qt_fracionada
FROM pedido_empurrado p
	INNER JOIN pedido_empurrado_produto prd
		ON prd.cd_filial						= p.cd_filial
		AND prd.nr_pedido_empurrado	= p.nr_pedido_empurrado
	WHERE prd.cd_produto										= :pl_produto
		AND COALESCE( p.cd_distribuidora, '053404705' )	= :ps_Distribuidora
		AND p.id_tipo_pedido	= 'F' // Farmagora
		AND p.id_situacao		= 'C' //Colocado
USING SqlCa;
		
If SqlCa.SqlCode = -1 Then
	This.of_Grava_Arquivo( "[ERRO] Pedido: " + String( ivl_Pedido ) + " | Consulta da quantidade reservada da distribuidora " + ps_Distribuidora + " do produto " + String( pl_Produto ) + ". Funcao: of_consulta_qtde_pedido_empurrado() " + SqlCa.SqlErrText, True )
	Return -1
End If

//CD_DISTRIBUIDORA_ESTOQUE_CENTRAL = '053404705'
//If ps_Distribuidora = CD_DISTRIBUIDORA_ESTOQUE_CENTRAL Then
//	pl_qt_empurrada 	= 0	
//End If 

Return 1
end function

protected function integer of_grava_pedido_empurrado (integer pi_filial, long pl_produto, integer pi_qtde, string ps_distribuidora, decimal pdc_fator_conversao, long pl_saldo_falta);/* Fun$$HEX2$$e700e300$$ENDHEX$$o para fazer pedido empurrado para o CD e Distribuidoras quando n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ saldo suficiente na filial para atender aos pedidos em abertos
	Fernando Lu$$HEX1$$ed00$$ENDHEX$$s Cambiaghi
	
	Alterado por: Wagner Frasseto
	Data: 29/09/2017
	
	Retorno 1: True, 
			  -1: False
*/

Long ll_Numero_Pedido					= 0
Long ll_Qt_a_Empurrar_Fracionada	= 0
Long ll_Qt_a_Empurrar_Caixa 			= 0
Long ll_Qt_Empurrada_Fracionada 	= 0


String ls_Saldo_Exclusivo_CD

DateTime ldh_Parametro

Try
	ls_Saldo_Exclusivo_CD = IIF( ps_Distribuidora = "053404705", "S", "N" )
	
	ldh_Parametro = gvo_Parametro.of_Dh_Movimentacao( )
		
	//Verifica QTDE a empurrar
	ll_Qt_a_Empurrar_Fracionada 	= pl_Saldo_Falta	//quantidade fracionada
	ll_Qt_a_Empurrar_Caixa			= Ceiling( pl_Saldo_Falta /  pdc_fator_conversao ) // Calcula a quantidade de caixa fechada

	// Verifica se h$$HEX1$$e100$$ENDHEX$$ pedido colocado para incluir produto
	SELECT TOP 1 nr_pedido_empurrado
	INTO :ll_Numero_Pedido
	FROM pedido_empurrado
	WHERE cd_filial 										= :pi_filial
	AND Coalesce(cd_distribuidora,'053404705')  	= :ps_Distribuidora	//Distribuidora
	AND id_tipo_pedido									= 'F' 						// Farmagora
	AND id_situacao										= 'C' 						// Colocado
	ORDER BY nr_pedido_empurrado DESC
	USING SqlCa;

	Choose Case SqlCa.SqlCode
		Case -1
			of_Grava_Arquivo( "[ERRO] Consulta da quantidade reservada na distribuidora " +ps_Distribuidora+ " do produto " + String( pl_Produto ) + ". " + SqlCa.SqlErrText, True )
			Return -1
			
		Case 0
			// Verifica se existe o produto no pedido
			SELECT  COALESCE( qt_empurrada_fracionada, 0 )
			INTO 	:ll_Qt_Empurrada_Fracionada
			FROM pedido_empurrado_produto
			WHERE cd_filial					= :pi_filial
			AND nr_pedido_empurrado	= :ll_Numero_Pedido
			AND cd_produto				= :pl_Produto
			USING SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case -1
					of_Grava_Arquivo( "[ERRO] Consulta da quantidade reservada na distribuidora " +ps_Distribuidora+ " do produto " + String( pl_Produto ) + ". " + SqlCa.SqlErrText, True )
					Return -1
					
				Case 0 //Existe produto Pedido
					
					UPDATE pedido_empurrado_produto
					SET qt_empurrada 					= COALESCE(qt_empurrada,0) 				+ :ll_Qt_a_Empurrar_Caixa,
							qt_empurrada_fracionada 	= COALESCE(qt_empurrada_fracionada,0)  + :ll_Qt_a_Empurrar_Fracionada
					WHERE cd_filial					= :pi_filial
					AND nr_pedido_empurrado	= :ll_Numero_Pedido
					AND cd_produto				= :pl_produto
					USING SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						This.of_Grava_Arquivo( "[ERRO] Atualiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade reservada na distribuidora " +ps_Distribuidora+ "  do produto " + String( pl_Produto ) + " para o pedido_empurrado j$$HEX1$$e100$$ENDHEX$$ existente n$$HEX1$$fa00$$ENDHEX$$mero " + String( ll_Numero_Pedido ) + ".~r" + SqlCa.SqlErrText, True )
						Return -1
					End If
					
				Case 100 //N$$HEX1$$e300$$ENDHEX$$o existe produto pedido
									
					INSERT INTO pedido_empurrado_produto
					(   cd_filial,
						nr_pedido_empurrado,
						cd_produto,
						qt_empurrada,
						qt_faturada,
						id_situacao,
						qt_empurrada_fracionada)
					VALUES (:pi_Filial,					//cd_filial
								:ll_Numero_Pedido,	//nr_pedido_empurrado
								:pl_produto, 			// cd_produto
								:ll_Qt_a_Empurrar_Caixa, // qt_empurrada
								0,							// qt_faturada
								'C',						// id_situacao
								:ll_Qt_a_Empurrar_Fracionada
						)
				USING SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o quantidade reservada na distribuidora " +ps_Distribuidora+ "  do produto " + String( pl_Produto ) + " para o pedido_empurrado j$$HEX1$$e100$$ENDHEX$$ existente n$$HEX1$$fa00$$ENDHEX$$mero " + String( ll_Numero_Pedido ) + ".~r" + SqlCa.SqlErrText, True )
					Return -1
				End If

			End Choose // SELECT COALESCE( qt_empurrada, 0 )
		
		Case 100 // N$$HEX1$$e300$$ENDHEX$$o existe pedido colocado		
			SELECT COALESCE( MAX( nr_pedido_empurrado ), 0 ) + 1
			INTO :ll_Numero_Pedido
			FROM pedido_empurrado
			WHERE cd_filial	= :pi_Filial
			USING SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				of_Grava_Arquivo( "[ERRO] Captura do pr$$HEX1$$f300$$ENDHEX$$ximo n$$HEX1$$fa00$$ENDHEX$$mero de pedido_empurrado. " + SqlCa.SqlErrText, True )
				Return -1
			End If
			
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
					:pi_Filial,					//cd_filial
					:ll_Numero_Pedido,	//nr_pedido_empurrado
					:ldh_Parametro,		//dh_emissao
					'N', 			// id_processado
					'F', 			// id_tipo_pedido = FARMAGORA
					'C', 			// id_situacao
					:ls_Saldo_Exclusivo_CD, 			// id_reserva_saldo_cd
					getdate( ), 	// dh_inclusao
					'14330',		// nr_matricula_inclusao
					Null,			// dh_cancelamento
					Null,			// nr_matricula_cancelamento
					:ps_Distribuidora
				)
			Using SqlCa;
		
			If SqlCa.SqlCode = -1 Then
				This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo pedido_empurrado.~r" + SqlCa.SqlErrText, True )
				Return -1
			End If
		
			INSERT INTO pedido_empurrado_produto
				(   cd_filial,
					nr_pedido_empurrado,
					cd_produto,
					qt_empurrada,
					qt_faturada,
					id_situacao,
					qt_empurrada_fracionada)
				VALUES (:pi_Filial,					//cd_filial
							:ll_Numero_Pedido,	//nr_pedido_empurrado
							:pl_produto, 			// cd_produto
							:ll_Qt_a_Empurrar_Caixa,			// qt_empurrada
							0,							// qt_faturada
							'C',							// id_situacao
							:ll_Qt_a_Empurrar_Fracionada 
					)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o do produto " + String( pl_produto ) + " pedido_empurrado n$$HEX1$$fa00$$ENDHEX$$mero " + String( ll_Numero_Pedido ) + ".~r" + SqlCa.SqlErrText, True )
				Return -1
			End If
					
	End Choose // SELECT TOP 1 nr_pedido_empurrado
	
	This.of_Grava_Arquivo( "[OK] Pedido empurrado: " + String( ll_Numero_Pedido ) + " | Produto: " + String( pl_produto ) + " | Qtdes empurradas (caixa, fracionada): (" + String( ll_Qt_a_Empurrar_Caixa ) + ", " + String( ll_Qt_a_Empurrar_Fracionada ) + ")" , FALSE )
	
	//ll_Qt_a_Empurrar_Fracionada = ll_Qt_a_Empurrar_Fracionada - ll_Qt_Empurrada_Fracionada

	 UPDATE pedido_ecommerce_produto
		SET qt_pedida_empurrada = COALESCE(qt_pedida_empurrada,0) + :ll_Qt_a_Empurrar_Fracionada
	WHERE cd_filial_ecommerce 	= :This.il_filial_site_em_atualizacao 
		AND nr_pedido					= :This.ivl_Pedido
		AND cd_produto				= :pl_Produto
	 USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Arquivo( "[ERRO] Atualiza$$HEX2$$e700e300$$ENDHEX$$o da qt_pedida_empurrada do produto " + String( pl_produto ) + ".~r" + SqlCa.SqlErrText, True )
		Return -1
	Else
		This.is_Mensagem_Email_Pedido_Empurrado += "~rProduto: " + String( pl_Produto ) + "~rQtde.: " + String( pl_Saldo_Falta )
	End If
	
	Return 1
	
Finally
	//
End Try
end function

public function boolean of_importa_status_pedido_etotal (long al_pedido_ecommerce, string as_status);/* total_express_rastreamento.cd_status
		 0 	= ARQUIVO RECEBIDO NA TOTAL EXPRESS
		 1 	= ENTREGUE
		83 = COLETA REALIZADA
		84 = COLETA REALIZADA C/ N$$HEX1$$c300$$ENDHEX$$O CONFORMIDADE
*/
Integer li_Status
Integer li_Achou_Nota
Integer li_Linhas_Atualizadas = 0
Integer li_Qt_Volumes

String ls_Mensagem

Date ldt_Compra

ls_Mensagem = ""

TRY
	If Trim( as_Status ) = '' Then
		// Abre o arquivo de log
		If Not This.of_Abre_Arquivo("status_pedido_ecommerce") Then
			Return False
		End If
		
		If Not This.of_Conecta_Banco_Filial_Destino( 454 ) Then //Conecta na filial
			Return False
		End If
	End If
	
	uo_ge226_total_express lo_total_express
	
	If ( as_Status = 'A' OR as_Status = 'F' ) Then

		SELECT COUNT(*)
		INTO :li_Achou_Nota
		FROM nf_venda
		WHERE coalesce(cd_filial_ecommerce, 809) = :il_Filial_Site_Em_Atualizacao
			and nr_pedido_ecommerce in (SELECT nr_pedido FROM pedido_ecommerce
																		WHERE cd_filial_ecommerce  = :il_Filial_Site_Em_Atualizacao
																		    AND nr_pedido  			  = :al_pedido_ecommerce)								
		USING SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case -1
				ls_Mensagem = "Consulta nota fiscal. " + SqlCa.SqlErrText
				SqlCa.of_RollBack( )
				Return False
				
			Case 0
				If li_Achou_Nota > 0 Then
					SELECT	qt_volume
					INTO :li_Qt_Volumes
					FROM pedido_drogaexpress
					WHERE nr_pedido_ecommerce = :al_pedido_ecommerce
						AND cd_filial_ecommerce	 = :il_Filial_Site_Em_Atualizacao
					USING Destino;
				 
					If Destino.SqlCode = -1 Then
						Destino.of_End_Transaction( )
						ls_Mensagem = " Localiza$$HEX2$$e700e300$$ENDHEX$$o da pedido_drogaexpress.qt_volume '. " + Destino.SqlErrText		
						Return False
					End If
					
					UPDATE pedido_ecommerce
					SET qt_volume = :li_Qt_Volumes
					WHERE nr_pedido 					= :al_pedido_ecommerce
						AND cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
					USING SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						SqlCa.of_RollBack( )
						ls_Mensagem = " Atualiza$$HEX2$$e700e300$$ENDHEX$$o da pedido_ecommerce.qt_volume '. " + Destino.SqlErrText
						Return False 
					End If
					
					lo_total_express = create uo_ge226_total_express
					If Not lo_total_express.of_registra_coleta_e_total( il_Filial_Site_Em_Atualizacao, al_pedido_ecommerce, true, ref ls_Mensagem ) Then
						Return False
					End If
				Else
					Return True
				End If
		End Choose
		
	End If // ( as_Status = 'A' OR as_Status = 'F' )
	
	li_Status = -1

	SELECT COALESCE( cd_status, -1 )
	INTO :li_Status
	FROM total_express_rastreamento
	WHERE cd_filial_ecommerce = :il_Filial_Site_Em_Atualizacao
	AND nr_pedido_ecommerce  = :al_pedido_ecommerce
	AND cd_status IN (0,1,83,84)
	AND nr_sequencial = ( SELECT COALESCE( MAX( nr_sequencial ), 0 ) 	
									FROM total_express_rastreamento 
									WHERE cd_filial_ecommerce = :il_Filial_Site_Em_Atualizacao
									AND nr_pedido_ecommerce = :al_pedido_ecommerce
									AND cd_status IN (0,1,83,84) )	
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Mensagem = "Consulta do pedido na tabela total_express_rastreamento: " + SqlCa.SqlErrText
		SqlCa.of_RollBack( )
		Return False
	End If
	
	Choose Case li_Status
		Case -1
			//ls_Mensagem = "Nenhum status encontrado."
			ls_Mensagem = ""
			SqlCa.of_RollBack( )
			Return False
			
		Case 0 // ARQUIVO RECEBIDO
			as_status = 'C'
			
			UPDATE pedido_ecommerce
			 SET id_situacao = :as_status
			WHERE cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
			AND nr_pedido 						= :al_pedido_ecommerce
			AND id_situacao 					<> :as_status
			USING SqlCa;
			
			li_Linhas_Atualizadas = SqlCa.SqlNrows
			
		Case 1 // ENTREGUE
			as_status = 'E'
			
			UPDATE pedido_ecommerce
			SET	id_situacao = :as_status,
					dh_entrega = getdate( )
			WHERE cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
			AND nr_pedido 						= :al_pedido_ecommerce
			AND id_situacao 					<> :as_status
			USING SqlCa;
			
			li_Linhas_Atualizadas = SqlCa.SqlNrows
			
		Case 83, 84 // COLETA REALIZADA
			as_status = 'M'
			
			UPDATE pedido_ecommerce
			SET	id_situacao = :as_status,
					dh_embarque = getdate( )
			WHERE cd_filial_ecommerce 	= :il_Filial_Site_Em_Atualizacao
			AND nr_pedido 						= :al_pedido_ecommerce
			AND id_situacao 					<> :as_status
			USING SqlCa;
			
			li_Linhas_Atualizadas = SqlCa.SqlNrows
	End Choose			
	
	If SqlCa.SqlCode = -1 Then
		ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o de pedido_ecommerce.id_situacao = " + as_status + " : " + SqlCa.SqlErrText
		SqlCa.of_RollBack( )
		Return False
	End If
	
	If li_Linhas_Atualizadas > 0 Then
		
		SELECT Cast(dh_compra as Date)
		INTO :ldt_Compra
		FROM pedido_ecommerce
		 WHERE cd_filial_ecommerce 	 = :il_Filial_Site_Em_Atualizacao
		 	AND nr_pedido					 = :al_pedido_ecommerce
		USING SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Mensagem = "localiza$$HEX2$$e700e300$$ENDHEX$$o da data do pedido = " + as_status + " : " + SqlCa.SqlErrText
			Return False
		End If
		
		UPDATE pedido_drogaexpress
		SET	id_situacao = :as_status
		WHERE nr_pedido_ecommerce = :al_pedido_ecommerce
		AND cd_filial_ecommerce		= :il_Filial_Site_Em_Atualizacao
		AND id_situacao <> :as_status
		USING Destino;
		
		If Destino.SqlCode = -1 Then
			ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o de pedido_drogaexpress.id_situacao = " + as_status + " : " + Destino.SqlErrText
			SqlCa.of_RollBack( )
			Return False
		End If
		
		Choose Case as_status
			Case 'M'
				This.of_Atualiza_Status_Pedido( al_pedido_ecommerce, 'POS', "", ldt_Compra )
			Case 'E'
				This.of_Atualiza_Status_Pedido( al_pedido_ecommerce, 'ENT', "", ldt_Compra )
		End Choose
	End If
	
CATCH( runtimeerror ru )
	ls_Mensagem = ru.getMessage( )
	Return False
	
FINALLY
	If ls_Mensagem <> "" Then
		Destino.of_RollBack( )
		SqlCa.of_RollBack( )
		This.of_Grava_Arquivo("[ERRO] PEDIDO: " + String( al_pedido_ecommerce ) + " | " + ls_Mensagem + " | of_importa_status_pedido_etotal(long,string)", False )
	Else
		If Destino.of_Commit( ) <> -1 Then
			SqlCa.of_Commit( )
		End If
	End If
	
	If IsValid( lo_total_express ) Then	destroy lo_total_express	
END TRY

Return True
end function

private function long of_saldo_disponivel_distribuidora (integer pi_filial, long pl_produto, string ps_distribuidora, string ps_chamada, ref decimal pdc_fator_conversao);/* Argumento ps_chamada: SALDO (Quando est$$HEX1$$e100$$ENDHEX$$ enviando saldo para a Vannon) ou PEDIDO (Quando est$$HEX1$$e100$$ENDHEX$$ relizando pedido empurrado ) 
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
		
		lo_Filial.of_Localiza_Filial(String(pi_Filial))
		
		If Not lo_Filial.Localizada Then Return -1
		
		If Upper( ps_Chamada ) = 'SALDO' Then	
			Select   		COALESCE( d.qt_estoque_disponivel , 0 ), 
							COALESCE( g.vl_fator_conversao, 1 )
				INTO	:ll_Saldo,
						:pdc_Fator_Conversao
				From distribuidora_produto d
				Inner join fornecedor f
					on f.cd_fornecedor = d.cd_distribuidora
				Inner join filial_distribuidora fd
					on fd.cd_distribuidora = d.cd_distribuidora
				Inner join produto_geral g
					on g.cd_produto 		= d.cd_produto
				Where  fd.cd_filial 			= :pi_Filial
					and d.cd_produto	 		= :pl_Produto
					and d.cd_distribuidora	= :ps_Distribuidora
					and d.cd_unidade_federacao = :lo_Filial.Cd_Unidade_Federacao
					and coalesce(f.id_atende_pedido_ecommerce, 'N') 	= 'S'
					and coalesce(f.id_situacao, 'A') 							= 'A'
					and fd.id_situacao 											= 'A'
					and d.id_situacao												= 'A'
					and d.qt_estoque_disponivel 								> 0
					and coalesce(d.id_estoque_maior_10dias, 'N') 			= 'S'
			Using SqlCa;
			
		Else // If Upper( ps_Chamada ) <> 'SALDO'
			
			Select   		COALESCE( d.qt_estoque_disponivel , 0 ), 
							COALESCE( g.vl_fator_conversao, 1 )
				INTO	:ll_Saldo,
						:pdc_Fator_Conversao
				From distribuidora_produto d
				Inner join fornecedor f
					on f.cd_fornecedor = d.cd_distribuidora
				Inner join filial_distribuidora fd
					on fd.cd_distribuidora = d.cd_distribuidora
				Inner join produto_geral g
					on g.cd_produto 		= d.cd_produto
				Where  fd.cd_filial 			= :pi_Filial
					and d.cd_produto	 		= :pl_Produto
					and d.cd_distribuidora	= :ps_Distribuidora
					and d.cd_unidade_federacao = :lo_Filial.Cd_Unidade_Federacao
					and coalesce(f.id_atende_pedido_ecommerce, 'N') 	= 'S'
					and coalesce(f.id_situacao, 'A') 							= 'A'
					and fd.id_situacao 											= 'A'
					and d.id_situacao												= 'A'
				Using SqlCa;
		End If			
				
	Else
		//CD
		
		SELECT	dbo.saldo_atual_estoque_central( :pi_filial, :pl_produto, 'S'),
					COALESCE( g.vl_fator_conversao, 1 ) as vl_fator_conversao
			INTO	:ll_Saldo,
					:pdc_Fator_Conversao
		  FROM vw_saldo_atual_produto s
				INNER JOIN produto_geral g
					ON g.cd_produto = s.cd_produto
		WHERE s.cd_filial		= :pi_filial
			AND s.cd_produto	= :pl_produto
		Using SqlCa;
	
	End If
	
	If SqlCa.SqlCode = -1 Then
		of_Grava_Arquivo( "[ERRO] Consulta saldo_atual do produto " + String( pl_Produto ) + " da distribuidora " + ps_Distribuidora + ". Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_disponivel_distribuidora, " + SqlCa.SqlErrText, True )
		Return ll_Retorno
	End If
	
	//Verifica qtde empurrada
	If This.of_consulta_qtde_pedido_empurrado(pi_filial, pl_produto, ps_Distribuidora, ref ll_Qt_Empurrada, ref ll_Qt_Empurrada_Fracionada ) < 0 Then
		Return ll_Retorno
	End If
	
	
	If ps_Distribuidora = CD_DISTRIBUIDORA_ESTOQUE_CENTRAL Then
		ll_Saldo = ll_Saldo + ll_Qt_Empurrada //por causa da fun$$HEX2$$e700e300$$ENDHEX$$o of_consulta_qtde_pedido_empurrado
	End If
	
	If ll_Qt_Empurrada_Fracionada = 0 Then
		ll_Retorno = ll_Saldo * pdc_Fator_Conversao
		Return ll_Retorno
	End If

	ll_Saldo = ll_Saldo - ll_Qt_Empurrada	
	
	If ll_Saldo < 0 Then ll_Saldo = 0
	
	If pdc_Fator_Conversao = 1 Then
		ll_Retorno = ll_Saldo
		Return ll_Retorno
	End If
			
	ll_Sobra_Fracionada_Disponivel = ( ll_Qt_Empurrada_Fracionada - ( pdc_Fator_Conversao * ll_Qt_Empurrada ) ) * -1
	
	ll_Retorno = ( ll_Saldo * pdc_Fator_Conversao ) + ll_Sobra_Fracionada_Disponivel
	
	Return ll_Retorno
	
Finally
	If ll_Retorno >= 0 Then
		This.of_Grava_Arquivo( "[OK] Consulta saldo_atual do produto " + String( pl_Produto ) + " da distribuidora " + ps_Distribuidora + ". Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_disponivel_distribuidora. Quantidade Retornada: " + String( ll_Saldo ) + " * " + String( pdc_Fator_Conversao ) + " | ps_chamada: " + ps_Chamada, FALSE )
	End If
End Try
end function

public function boolean of_atualiza_saldo (string as_rede_ecommerce);Long 	lvl_Linhas,&
	 	lvl_Linha,&
	 	lvl_Produto,&
	 	lvl_Saldo_Filial,&
		lvl_Contador_Integra, &		
		lvl_Filiais, &
		lvl_Filial, &
		lvl_Cont_Filial
		
Long ll_Null
Long ll_Qt_Saldo_Ant

String ls_In
	 
Integer lvi_Retorno
	
Try	
	//Verica a filial site que esta em atualiza$$HEX2$$e700e300$$ENDHEX$$o
	This.of_verifica_filial_site_atualizacao( as_Rede_Ecommerce )
		
	If Not of_verifica_conexao() Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o liberada no Desenvolvimento.", StopSign! )
		//Return False
	End If
		
	SetNull( ll_Null )
	ivi_Produtos_Alterados = 0
	
	dc_uo_ds_base lvds_Filiais_Saldo
	dc_uo_ds_base lvds_Produto_Ecommerce
	dc_uo_ds_base lvds_Saldo
	
	lvds_Filiais_Saldo	 			= Create dc_uo_ds_base
	lvds_Produto_Ecommerce 	= Create dc_uo_ds_base
	lvds_Saldo	 					= Create dc_uo_ds_base
	
	// Abre o arquivo de log
	If Not This.of_Abre_Arquivo("ecommerce_saldo") Then Return False
	
	gvs_eCommerce = 'S'

	Open( w_aguarde_2 )
	w_aguarde_2.Title = "Atualizando o Saldo dos Produtos do Ecommerce..."
	
	If Not lvds_Produto_Ecommerce.of_ChangeDataObject("ds_ge226_lista_produto_ecommerce_atualizacao") Then
		This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_saldo( ) | ChangeDataObject( ds_ge226_lista_produto_ecommerce_atualizacao )", True )
		Return False
	End If
	
	If Not lvds_Filiais_Saldo.of_ChangeDataObject("ds_ge226_lista_filiais_ecommerce") Then
		This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_saldo( ) | ChangeDataObject( ds_ge226_lista_filiais_ecommerce )", True )
		Return False
	End If

	 //DESENVOLVIMENTO
//	#IF DEFINED DEBUG THEN
//		lvds_Produto_Ecommerce.of_AppendWhere("cd_produto in ( " +String(733894) +" ) ")
//	#END IF
	
	If lvds_Produto_Ecommerce.Retrieve( il_Filial_Site_Em_Atualizacao ) < 0 Then	
		This.of_Grava_Arquivo("[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_saldo() | Recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es dos produtos.", True )
		Return False
	End If
	
	// Grava no log o in$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o
	If Not This.of_Grava_Arquivo("In$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o. Rede: " + This.is_Rede_Ecommerce, False) Then Return False
	
	SetPointer(HourGlass!)
	
	lvl_Linhas = lvds_Produto_Ecommerce.RowCount()
	
	If lvl_Linhas > 0 Then
		
		w_aguarde_2.Title = "eCommerce (Atualiza$$HEX2$$e700e300$$ENDHEX$$o de SALDO) - Carregando o SALDO das lojas..."
		
		// Carrega o saldo de Todos dos produtos das filiais
		If This.of_Carrega_Saldo( ll_Null, Ref lvds_Saldo) Then
										
			w_aguarde_2.uo_Progress.of_SetMax( lvl_Linhas )
						
//			//Na atualiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do site DC deve carregar tamb$$HEX1$$e900$$ENDHEX$$m o estoque da 454
			If This.is_Rede_Ecommerce = 'DC' Then
				lvds_Filiais_Saldo.of_appendwhere( "id_rede in ('DC', 'FA')")
			Else
				lvds_Filiais_Saldo.of_appendwhere( "id_rede = '" + This.is_Rede_Ecommerce  + "'")
			End If
			
			If lvds_Filiais_Saldo.Retrieve( ) = -1 Then
				This.of_Grava_Arquivo("[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_saldo() | Recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es lvds_Filiais_Saldo.", True )
			End If

			lvl_Filiais = lvds_Filiais_Saldo.RowCount()
			
			For lvl_Linha = 1 To lvl_Linhas				
				lvl_Produto	= Long(lvds_Produto_Ecommerce.Object.cd_produto[lvl_Linha])			
				
				w_aguarde_2.Title = "eCommerce (Atualiza$$HEX2$$e700e300$$ENDHEX$$o de SALDO) - Produto '" + String(lvl_Produto) + "' ..."	
				
				//lvl_Contador_Integra++
				
				For lvl_Cont_Filial = 1 To lvl_Filiais
					lvl_Filial	= lvds_Filiais_Saldo.Object.cd_filial[lvl_Cont_Filial]
					
					If lvl_Filial = 454 Then
						lvl_Filial = lvl_Filial
					End If
					
					//Recupera saldo das filiais mais saldo das distribuidoras
					lvl_Saldo_Filial	= This.of_Saldo_Produto( lvds_Saldo, lvl_Produto, lvl_Filial )
					
					//Verifca saldo_produto_ecommerce
					//Se houve altera$$HEX2$$e700e300$$ENDHEX$$o do saldo em estoque atualiza o site					
					Select Coalesce(qt_saldo, 0 )
						INTO :ll_Qt_Saldo_Ant
					from saldo_produto_ecommerce
						where cd_filial_ecommerce	= :il_Filial_Site_Em_Atualizacao
							and cd_filial 				= :lvl_Filial
							and cd_produto		 		= :lvl_Produto
						Using SqlCa;
					
					Choose Case SqlCa.SqlCode
						Case -1
							This.of_Grava_Arquivo("Erro ao localizar o saldo do produto ecommerce.", False)
							Continue
							
						Case 100
							Insert into saldo_produto_ecommerce(cd_filial_ecommerce, cd_filial, cd_produto, qt_saldo, dh_atualizacao) 
								Values( :il_Filial_Site_Em_Atualizacao, :lvl_Filial, :lvl_Produto, :lvl_Saldo_Filial, getdate() )
								Using SqlCa;
								
								If SqlCa.SqlCode = -1 Then
									SqlCa.of_Rollback()
									This.of_Grava_Arquivo("Erro insert saldo_produto_ecommerce. " + String(lvl_FIlial) + "-"+ String(lvl_Produto) , False)
									Continue
								End If
								
								This.of_envia_produto_praca(lvl_Produto,  lvl_Saldo_Filial, 0, 0, 'update', False, '', '', lvl_Filial, false)
								
								lvl_Contador_Integra++
						Case 0 
							//Atualiza saldo completo para:
							//FA todos os dias
							//Domingo para todas as redes
							//DC somente saldos diferentes
							If This.is_Rede_Ecommerce = 'FA' OR ( This.is_Rede_Ecommerce <> 'FA' AND ll_Qt_Saldo_Ant <> lvl_Saldo_Filial) Then
								Update saldo_produto_ecommerce 
									Set qt_saldo 					= :lvl_Saldo_Filial, dh_atualizacao = getdate()
									Where cd_filial_ecommerce = :il_Filial_Site_Em_Atualizacao
										and cd_filial 				= :lvl_Filial
										and cd_produto	 			= :lvl_Produto
									Using SqlCa;
									
									If SqlCa.SqlCode = -1 Then
										SqlCa.of_Rollback()
										This.of_Grava_Arquivo("Erro update saldo_produto_ecommerce. " + String(lvl_FIlial) + "-"+ String(lvl_Produto) , False)
										Continue
									End If
									
								This.of_envia_produto_praca(lvl_Produto,  lvl_Saldo_Filial, 0, 0, 'update', False, '', '', lvl_Filial,false)
								
								lvl_Contador_Integra++
							End If
					End Choose
					
					If lvl_Contador_Integra >= 150 Then
						SqlCa.of_Commit()
						lvi_Retorno = of_envia_grupo_produto()
						lvl_Contador_Integra = 0
					End If
					
				Next 

//				If lvl_Contador_Integra >= 6 Then
//					SqlCa.of_Commit()
//					lvi_Retorno = of_envia_grupo_produto()
//					lvl_Contador_Integra = 0
//				End If
				
				w_aguarde_2.uo_Progress.of_SetProgress( lvl_Linha )
				
				Yield ( )			
			Next		
			
			//Garante que o $$HEX1$$fa00$$ENDHEX$$ltimo grupo de produtos ser$$HEX1$$e100$$ENDHEX$$ atualizado
			lvi_Retorno = of_envia_grupo_produto()
			SqlCa.of_Commit()
					
		End If
	Else
		This.of_Grava_Arquivo("Nenhum produto foi localizado para ser atualizado.", False)
	End If
	
	// Grava a quantidade dos produtos atualizados
	This.of_Grava_Arquivo("Total de produtos atualizados: " + String(ivi_Produtos_Alterados) , False)
	
	// Grava o t$$HEX1$$e900$$ENDHEX$$rmino da atualiza$$HEX2$$e700e300$$ENDHEX$$o no arquivo de log
	This.of_Grava_Arquivo("Termino da atualiza$$HEX2$$e700e300$$ENDHEX$$o. Rede: "  + This.is_Rede_Ecommerce, False)
	
	Return True

Finally
	If IsValid( lvds_Produto_Ecommerce )	Then Destroy lvds_Produto_Ecommerce
	If IsValid( lvds_Saldo ) 					Then Destroy lvds_Saldo
	If IsValid( lvds_Filiais_Saldo ) 			Then Destroy lvds_Filiais_Saldo
	
	FileClose( ivi_Log )	
	SetPointer( Arrow! )
	
	If IsValid( w_aguarde_2 ) Then Close( w_aguarde_2 )
	gvs_eCommerce = 'N'
End Try
end function

public function boolean of_importa_status_pedidos (string as_rede_ecommerce);Boolean lvb_Sucesso 				= True
Boolean lvb_Atualiza_Status 	= False
Boolean lvb_Sucesso_Etiqueta
	 
Integer li_Qt_Volumes, li_Qt_Pendente_faturamento

Date ldt_Compra

Long	lvl_Linhas, &
		lvl_Linha, &		
		lvl_Nr_Pedido, &
		lvl_Filial_Anterior, &
		lvl_Filial

Long ll_NF_Servico

String	 lvs_Id_Situacao, &
		 lvs_Situacao, &
		 lvs_Mensagem, &
		 lvs_Cd_Rastreamento, &
		 lvs_Nm_Transportadora, &
		 lvs_Pedido_Drogaexpress, &
		 lvs_Situacao_Loja, &
		 lvs_Set_Update, &
		 lvs_Update

String ls_Contem_Manipulado, ls_uf_Entrega

Try
	This.of_verifica_filial_site_atualizacao( as_Rede_Ecommerce )
		
	uo_ge226_total_express lo_total_express
	dc_uo_ds_base 			lvds_Status_Pedido
	
	lvds_Status_Pedido = Create dc_uo_ds_base 
	
	// Faz atualizacao pelo log_exportacao_ecommerce
	If Not lvds_Status_Pedido.of_ChangeDataObject("ds_ge226_lista_status_pedido") Then
		Return False
	End If
		
	// Abre o arquivo de log
	If Not This.of_Abre_Arquivo("status_pedido_ecommerce") Then
		Return False
	End If
	
	// Grava no log o in$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o
	If Not This.of_Grava_Arquivo("In$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o. REDE: " + This.is_Rede_Ecommerce , False) Then
		Return False
	End If
	
	//desenv
//	#IF DEFINED DEBUG THEN
//		lvds_Status_Pedido.of_AppendWhere( "p.nr_pedido = 499426864",  1)
//		lvds_Status_Pedido.of_AppendWhere( "p.nr_pedido = 499426864",  2)
//		lvds_Status_Pedido.of_AppendWhere( "p.nr_pedido = 499426864",  3)
//	#END IF

	If lvds_Status_Pedido.Retrieve( il_Filial_Site_Em_Atualizacao ) = -1 Then
		This.of_Grava_Arquivo( "[ERRO] Recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido. ds_ge226_lista_status_pedido", True ) 
		Return False
	End If
	
	This.of_Grava_Arquivo( '[OK] Retrieve da ds_ge226_lista_status_pedido com ' + String( lvds_Status_Pedido.RowCount() ) + ' linhas retornadas', False )
		
	SetPointer(HourGlass!)
	
	Open(w_aguarde_2)
	
	w_aguarde_2.Title = "Atualizando os pedidos do eCommerce..."
	
	IF as_Rede_Ecommerce = 'FA' Then
		Try
			lo_total_express = create uo_ge226_total_express
//			DateTime ltd_data_Rastreio
//			ltd_data_Rastreio = DateTime( '2020/08/12' )
		
			If Not lo_total_express.of_rastrear_pedido( DateTime( Today( ) ) , true, ref lvs_Mensagem ) Then
				This.of_Grava_Arquivo( "[ERRO] " + lvs_Mensagem + " | of_importa_status_pedidos()", True ) 
			End If	
		Catch( runtimeerror ru1)
			This.of_Grava_Arquivo( "[ERRO] " + ru1.getMessage( ) + " | of_importa_status_pedidos()", True ) 
		Finally
			If IsValid( lo_total_express ) Then Destroy lo_total_express	
		End Try
	End If
		
	lvl_Linhas = lvds_Status_Pedido.RowCount()
	
	If lvl_Linhas > 0 Then
		w_aguarde_2.uo_Progress.of_SetMax( lvl_Linhas ) 	 	
		
		For lvl_Linha = 1 To lvl_Linhas
			lvs_Mensagem			= ""
			lvb_Sucesso_Etiqueta	= True
			
			w_aguarde_2.Title 	= "Atualizando os pedidos do eCommerce " + String( lvl_Linha ) + " de " + String( lvl_Linhas ) + "..."
			lvb_Atualiza_Status 	= False
			
			lvl_Nr_Pedido					= lvds_Status_Pedido.Object.nr_pedido						[ lvl_Linha ]
			lvs_Id_Situacao					= lvds_Status_Pedido.Object.id_situacao						[ lvl_Linha ]
			lvl_Filial							= lvds_Status_Pedido.Object.cd_filial							[ lvl_Linha ]
			lvs_Pedido_Drogaexpress	= lvds_Status_Pedido.Object.nr_pedido_drogaexpress	[ lvl_Linha ]		
			lvs_Nm_Transportadora		= lvds_Status_Pedido.Object.Nm_Transportadora			[ lvl_Linha ]
			ldt_Compra						= Date(lvds_Status_Pedido.Object.dh_compra				[ lvl_Linha ])
			lvs_Cd_Rastreamento 		= ''
			ll_NF_Servico					= lvds_Status_Pedido.Object.nr_nf_servico					[ lvl_Linha ]
			ls_UF_Entrega					= lvds_Status_Pedido.Object.cd_uf							[ lvl_Linha ]
			
			This.of_Grava_Arquivo( "PEDIDO: " + String( lvl_Nr_Pedido ) + " - Inicio | of_importa_status_pedidos()", False )
								
			If lvl_Filial <> lvl_Filial_Anterior Then		
				If Not of_Conecta_Banco_Filial_Destino( lvl_Filial ) Then // Conecta na filial do Disque Entrega
					Continue
				End If
				lvl_Filial_Anterior = lvl_Filial
			Else
				If Not Destino.of_isConnected() Then
					If as_rede_ecommerce = 'FA' Then
						Exit
					Else
						Continue
					End If
				End If
			End If
			
			If ( lvs_Nm_Transportadora = NM_TRANPORTADORA_TOTAL_EXPRESS ) Then
				If lvl_Nr_Pedido = 192354828 Then
					lvl_Nr_Pedido = lvl_Nr_Pedido
				End If
				
				If Not This.of_Importa_Status_Pedido_eTotal( lvl_Nr_Pedido, lvs_Id_Situacao ) Then
					Continue
				End If
				
				Choose Case lvs_Id_Situacao
					Case 'A'; Continue
					Case 'C'; lvs_Situacao 		= 'SPP'
					Case 'E'; lvs_Situacao 		= 'ENT'
					Case 'M', 'R'; lvs_Situacao 	= 'POS'
						
					Case Else
						//
				End Choose
				
				// Implementacao de todo o controle dentro da funcao
				lvb_Sucesso = This.of_Atualiza_Status_Pedido( lvl_Nr_Pedido, lvs_Situacao, lvs_Cd_Rastreamento,  ldt_Compra)
				
				This.of_Grava_Arquivo( "PEDIDO: " + String( lvl_Nr_Pedido ) + " - termino status etotal | of_importa_status_pedidos()", False )
				
				If lvb_Sucesso And ( lvs_Id_Situacao = 'E' Or lvs_Id_Situacao = 'X' ) Then
					UPDATE total_express_rastreamento
						SET dh_atualizacao_ecommerce 	= getdate( )
						WHERE cd_filial_ecommerce		= :il_Filial_Site_Em_Atualizacao
						AND nr_pedido_ecommerce			= :lvl_Nr_Pedido
						AND dh_atualizacao_ecommerce 	IS NULL
					USING SQLCA;
					
					Choose Case SqlCa.SqlCode
						Case -1
							This.of_Grava_Arquivo( "[ERRO] PEDIDO: " + String( lvl_Nr_Pedido ) + " Atualiza$$HEX2$$e700e300$$ENDHEX$$o do status do total_express_rastreamentodh_atualizacao_ecommerce. " + SqlCa.SqlErrText + " | of_importa_status_pedidos()", True )
							SqlCa.of_RollBack( )
							
						Case Else
							SqlCa.of_Commit( )
					End Choose
					This.of_Grava_Arquivo( "Update total_express_rastreamento | of_importa_status_pedidos()", False )
				End If
				
				Continue				
			End If // lvs_Nm_Transportadora = NM_TRANPORTADORA_TOTAL_EXPRESS
			
			If lvs_Id_Situacao = 'M' or lvs_Id_Situacao = 'R' Then
				lvs_Situacao				= 'POS' //POSTADO - 12 Embarcado
				lvb_Atualiza_Status	= True
				lvs_Set_Update			= "  dh_embarque = getdate(), id_situacao = '" + lvs_Id_Situacao + "' "
				lvs_Cd_Rastreamento	= lvds_Status_Pedido.Object.de_Codigo_Rastreamento_Correio[lvl_Linha]
			End If
			
			If lvs_Id_Situacao = 'E'  Then
				lvs_Situacao 			= 'ENT' //13 Entregue
				lvb_Atualiza_Status 	= True
				lvs_Set_Update 		= "  dh_entrega = getdate() ";	
				lvs_Cd_Rastreamento	= lvds_Status_Pedido.Object.de_Codigo_Rastreamento_Correio[lvl_Linha]
			End If
					 
			If lvs_Id_Situacao = 'F'  Then
				lvb_Atualiza_Status = True
				
				If Mid(lvs_Nm_Transportadora, 1, 15) = 'RETIRAR NA LOJA' Or Mid(lvs_Nm_Transportadora, 1, 19) = 'ARM$$HEX1$$c100$$ENDHEX$$RIO INTELIGENTE' Then
					lvs_Situacao = 'DPR' //Dispon$$HEX1$$ed00$$ENDHEX$$vel para Entrega
					lvs_Id_Situacao = 'D'
				Else
					lvs_Situacao = 'SPP' //Separado para postagem - 11 Faturado
				End If				
				
				lvs_Set_Update = " dh_faturado = getdate(), id_situacao = '" + lvs_Id_Situacao + "' ";			
			End If
									
			If lvs_Id_Situacao = 'A'  Then
				Select	 p.id_situacao,
						 p.qt_volume,
						 (select count(cd_produto) from produto_pedido_drogaexpress x where x.nr_pedido_drogaexpress = p.nr_pedido_drogaexpress and COALESCE(qt_faturada,0) < qt_pedida),
						 (Case when(select count(cd_produto) from produto_pedido_drogaexpress x where x.nr_pedido_drogaexpress = p.nr_pedido_drogaexpress and cd_produto = 684431) > 0 then 'S' else 'N' end)
					Into	:lvs_Situacao_Loja,
						:li_Qt_Volumes,
						:li_Qt_Pendente_faturamento,
						:ls_Contem_Manipulado
				 From pedido_drogaexpress p
				 Where p.nr_pedido_drogaexpress =:lvs_Pedido_Drogaexpress
				 Using Destino;
				 
				 If Destino.SqlCode = -1 Then
					This.of_Grava_Arquivo( "[ERRO] PEDIDO: " + String( lvl_Nr_Pedido ) + " Atualiza$$HEX2$$e700e300$$ENDHEX$$o do status do pedido_drogaexpress '" + lvs_Pedido_Drogaexpress + "'. " + Destino.SqlErrText + " | of_importa_status_pedidos()", True )
					Return False
				 End If
				 
				 //Manipulacao
				 If il_Filial_Site_Em_Atualizacao = 355  Then
					If lvs_Situacao_Loja <> 'F' And lvs_Situacao_Loja <> 'L' Then
						Continue
					End If
					
					If li_Qt_Pendente_faturamento > 0 Then
						Continue
					End if			
										
					If ls_uf_Entrega <> 'SC' Then
						If ls_Contem_Manipulado = 'S' Then
							If Not IsNull( ll_nf_Servico ) Then
								lvs_Situacao_Loja 	= 'F'
							Else
								Continue
							End If
						Else
							lvs_Situacao_Loja 	= 'F'
						End If
					Else
						lvs_Situacao_Loja 	= 'F'
					End If
				 End If
				 
				 //Para quando sistema de caixa n$$HEX1$$e300$$ENDHEX$$o consegue comunica$$HEX2$$e700e300$$ENDHEX$$o para atualizar o pedido para F.
				 If lvs_Situacao_Loja	= 'F' Then
					lvb_Atualiza_Status = True
					lvs_Id_Situacao = 'F'
					
					If Mid(lvs_Nm_Transportadora, 1, 15) = 'RETIRAR NA LOJA' Or Mid(lvs_Nm_Transportadora, 1, 19) = 'ARM$$HEX1$$c100$$ENDHEX$$RIO INTELIGENTE' Then
						lvs_Situacao = 'DPR' //Dispon$$HEX1$$ed00$$ENDHEX$$vel para Entrega
						lvs_Id_Situacao = 'D'
					Else
						lvs_Situacao = 'SPP' //Separado para postagem - 11 Faturado
					End If	
				
					lvs_Set_Update = " dh_faturado = getdate(), id_situacao = '" + lvs_Id_Situacao + "' ";
					
					If Not IsNull( li_Qt_Volumes ) Then
						lvs_Set_Update += ", qt_volume = " + String( li_Qt_Volumes ) + " "
					End If
					
				 Else
					continue
				 End If
			End If
			
			If lvs_Id_Situacao = 'C' Then lvs_Situacao = 'SPP' // Comunicado a transportadora -> Separado para postagem
			
			This.of_Grava_Arquivo( "Atualiza status pedido apos lvs_Id_Situacao = A | of_importa_status_pedidos()", False )
			
			lvb_Atualiza_Status = True
			
			Choose Case lvs_Nm_Transportadora
				Case 'MOTOBOY' //O status de pedidos com entrega por Motoboy ser$$HEX1$$e100$$ENDHEX$$ atualizado somente para POSTADO - POS e ENTREGUE
					If lvs_Id_Situacao <> "M" And lvs_Id_Situacao <> "E" Then
						lvb_Atualiza_Status = False 
						lvb_Sucesso = True
					End If
					
				Case 'ARM$$HEX1$$c100$$ENDHEX$$RIO INTELIGENTE' //O status de pedidos com entrega por ARM$$HEX1$$c100$$ENDHEX$$RIO INTELIGENTE ser$$HEX1$$e100$$ENDHEX$$ atualizado somente para ENTREGUE e DISPONIVEL para RETIRADA
					If lvs_Id_Situacao <> "E"  AND lvs_Id_Situacao <> 'D' Then
						lvb_Atualiza_Status = False 
						lvb_Sucesso = True
					End If
			End Choose
			
			If lvb_Atualiza_Status Then
				lvb_Sucesso = This.of_Atualiza_Status_Pedido( lvl_Nr_Pedido, lvs_Situacao, lvs_Cd_Rastreamento, ldt_Compra )
			End If
			
			//O status de pedidos com entrega por Motoboy ser$$HEX1$$e100$$ENDHEX$$ atualizado somente para POSTADO - POS e ENTREGUE
//			If (lvs_Nm_Transportadora <> "MOTOBOY" ) Or ( lvs_Nm_Transportadora = "MOTOBOY" And ( lvs_Id_Situacao = "M" Or lvs_Id_Situacao = "E")) OR &
//				( Mid(lvs_Nm_Transportadora, 1, 19) = 'ARM$$HEX1$$c100$$ENDHEX$$RIO INTELIGENTE' And lvs_Id_Situacao = "E" ) Then
//					lvb_Sucesso = This.of_Atualiza_Status_Pedido( lvl_Nr_Pedido, lvs_Situacao, lvs_Cd_Rastreamento, ldt_Compra )
//			End If
			
			This.of_Grava_Arquivo( "Retorno funcao atualiza status pedido apos lvs_Id_Situacao = A | of_importa_status_pedidos()", False )
			
			// Veio o retorno de sucesso da atualiza$$HEX2$$e700e300$$ENDHEX$$o no WebService
			If lvb_Sucesso Then
				//Para atualizar na tela do Retaguarda/Disque
				update pedido_drogaexpress
					 Set id_situacao = :lvs_Id_Situacao
				Where nr_pedido_drogaexpress = :lvs_Pedido_Drogaexpress
				  Using Destino;
	
				If Destino.SqlCode = -1 Then
					This.of_Grava_Arquivo( "[ERRO] PEDIDO: " + String( lvl_Nr_Pedido ) + " Atualiza$$HEX2$$e700e300$$ENDHEX$$o do status do pedido DrogExpress '" + lvs_Pedido_Drogaexpress + "'. " + Destino.SqlErrText + " | of_importa_status_pedidos()", True )
				Else
					If lvs_Situacao = 'SPP' Then //Separado para postagem
						If lvs_Nm_Transportadora = 'ESEDEX' Then lvs_Nm_Transportadora = 'SEDEX'
						
						If (lvs_Nm_Transportadora = 'SEDEX') OR (lvs_Nm_Transportadora = 'PAC') Then
							lvb_Sucesso_Etiqueta = This.of_reserva_etiqueta_correio(lvl_Nr_Pedido, lvs_Nm_Transportadora) 
						End If
					End If
					
					This.of_Grava_Arquivo( "Antes Execute Immediate  | of_importa_status_pedidos()", False )
					
					lvs_Update = "UPDATE pedido_ecommerce  SET " + lvs_Set_Update + " WHERE cd_filial_ecommerce = " + String( il_Filial_Site_Em_Atualizacao ) + " AND nr_pedido = " + String( lvl_Nr_Pedido )
					Execute Immediate :lvs_Update Using SqlCa;
					
					This.of_Grava_Arquivo( "Apos Execute Immediate  | of_importa_status_pedidos()", False )
					
					If SqlCa.SqlCode = -1 Then
						This.of_Grava_Arquivo( "[ERRO] Atualiza$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + String( lvl_Nr_Pedido ) + ". " + SqlCa.SqlErrText, True )
						Destino.of_Rollback();
					Else
						ivi_Pedidos_Atualizados ++
						SqlCa.of_Commit();
						Destino.of_Commit();
					End If
				End If
				
				
			End If
	
			w_aguarde_2.uo_Progress.of_SetProgress(lvl_Linha)
			Yield()		
		Next
			
	End If
		
	This.of_Grava_Arquivo("[OK] Total de pedidos atualizados: "   + String(ivi_Pedidos_Atualizados), False)		// Grava a quantidade das categorias incluidas
	This.of_Grava_Arquivo("[OK] Termino da atualiza$$HEX2$$e700e300$$ENDHEX$$o. Rede: " + is_Rede_Ecommerce, False) 				 	// Grava o t$$HEX1$$e900$$ENDHEX$$rmino da atualiza$$HEX2$$e700e300$$ENDHEX$$o no arquivo de log
	
	Return True
	
Finally
	If IsValid( lvds_Status_Pedido ) Then Destroy lvds_Status_Pedido
	FileClose(ivi_Log)
	Close(w_aguarde_2)
	SetPointer(Arrow!)
End Try
end function

public function boolean of_importa_pedidos (long pl_pedido, string ps_cep, string as_rede_ecommerce);Boolean 	lvb_Sucesso = False

Long 	lvl_Filial_Disque_Anterior,&
		lvl_Filtro, &
		lvl_Sucesso, &
		lvl_Pos

String	lvs_Pedido_DrogaExpress,&
		lvs_Nulo, &
		lvs_retorno_pedido, &
		lvs_retorno_pedido_entrega, &
		lvs_retorno_pedido_status, &
		lvs_retorno_cliente, & 
		lvs_retorno_parcelas, & 
		lvs_retorno_pbm, &
		lvs_conteudo_arquivo, &
		lvs_conteudo_parcelas, &
		lvs_sobra_pedido_entrega, &
		lvs_sobra_pedido_status, &
		lvs_sobra_cliente, &
		lvs_sobra_pbm, &
		lvs_filtro_pedido,&
		lvs_Pedido_Vannon, &
		ls_Sobrenome, &
		ls_Pedidos_Retorno_API

Decimal ldc_Pagto
Integer li_NumParcela

String ls_Parcela
String ls_Situacao

long ll_AUX
Date ldt_pedido_Aux

Try
	This.of_verifica_filial_site_atualizacao( as_Rede_ecommerce )
	
	If Not of_verifica_conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o liberada no Desenvolvimento.", StopSign!)
		//Return False
	End If
	
	SetNull(lvs_Nulo)
	gvs_eCommerce 			= 'S'
	ivs_json_captura_pedido = ''
	
	If Trim(ps_cep) = '' Then ps_cep = lvs_Nulo	
	
	// Abre o arquivo de log
	If Not This.ivb_Log_Pedidos_Aberto Then
		If Not This.of_Abre_Arquivo("ecommerce_pedidos") Then
			Return False
		Else
			 This.ivb_Log_Pedidos_Aberto = True
		End If
	End If
	
	// Atribui$$HEX2$$e700e300$$ENDHEX$$o de valor tempor$$HEX1$$e100$$ENDHEX$$rio, para grava$$HEX2$$e700e300$$ENDHEX$$o de log
	If IsNull( pl_Pedido ) Then
		lvs_Pedido_Vannon = 'NULL'
	Else
		lvs_Pedido_Vannon = String( pl_Pedido )
	End If
	
	// Grava no log o in$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o
	If Not This.of_Grava_Arquivo( '[OK] [PEDIDO: ' + lvs_Pedido_Vannon + "] In$$HEX1$$ed00$$ENDHEX$$cio da fun$$HEX2$$e700e300$$ENDHEX$$o of_importa_pedidos(long, string, long)", False ) Then
		FileClose( ivi_Log )
		Return False
	End If
		
	If  Not ivb_Pedido_Pendente Then
		//Atualiza pedidos pendentes que possam ter mudado de situa$$HEX2$$e700e300$$ENDHEX$$o
		of_atualiza_pedido_pendente( pl_Pedido, ps_Cep ) 
		 
		// Limpa a atribui$$HEX2$$e700e300$$ENDHEX$$o feita para grava$$HEX2$$e700e300$$ENDHEX$$o do log
		SetNull( lvs_Pedido_Vannon )
		
		If Not IsNull( pl_Pedido ) Then
			select id_situacao 
				into :ls_Situacao
				from pedido_ecommerce
			Where cd_filial_ecommerce 	=:il_Filial_Site_Em_Atualizacao
				AND nr_pedido 					=:pl_Pedido
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				This.of_Grava_Arquivo( "[ERRO] localizacao da situacao pedido_ecommerce apos a of_atualiza_pedido_pendente. Pedido: '" + String(pl_Pedido) + "' .~r of_importa_pedidos", True )
				Return False
			End If 
			
			//Pedido j$$HEX1$$e100$$ENDHEX$$ importado em uma chamada recursiva da of_importa_pedidos dentro da funcao of_atualiza_pedido_pendente
			If Trim(ls_Situacao) <> "" And ls_Situacao <> 'P' Then
				Return True
			End If
			
		End If
		
		SetPointer(HourGlass!)
			
		Open(w_Aguarde_2)
		w_Aguarde_2.Title = "Importando os pedidos eCommerce..."
	End if
	
	lvl_Filtro = 1
	
	Do While lvl_Filtro < 5
		
		If IsNull(pl_pedido) Then
			Choose Case lvl_filtro
				Case 1 
					lvs_filtro_pedido = "PedidoStatus/CodigoExterno eq 'PCO'" // Aprovado - Pagamento confirmado
				Case 2
					lvs_filtro_pedido = "PedidoStatus/CodigoExterno eq 'PCB'" // Aprovado - Pagamento confirmado Boleto
				Case 3
					lvs_filtro_pedido = "PedidoStatus/CodigoExterno eq 'AGA'" //Em an$$HEX1$$e100$$ENDHEX$$lise - AGA - Aguardando Aprova$$HEX2$$e700e300$$ENDHEX$$o
				Case 4
					lvs_filtro_pedido = "PedidoStatus/CodigoExterno eq 'NAA'" //'NAA'" // N$$HEX1$$e300$$ENDHEX$$o autorizado Antifraude (Clearsale)*/
	
			End Choose	
			lvl_Filtro ++
	
			lvs_filtro_pedido += " and Integracao ne 'I'"  //Pedidos ainda n$$HEX1$$e300$$ENDHEX$$o integrados
	
			//lvs_Pedido_Vannon = '84323537' //84323537
			//lvs_filtro_pedido = "NumeroPedido eq '" + lvs_Pedido_Vannon + "'"
		Else
			If as_Rede_ecommerce = 'FA' And Date(Today()) < This.of_Data_inicio_9_digito() Then
				lvs_Pedido_Vannon = Mid(String(pl_Pedido), 2, 8)
			Else
				lvs_Pedido_Vannon = String(pl_Pedido)
			End If
			
			lvs_filtro_pedido = "NumeroPedido eq '" + lvs_Pedido_Vannon + "'"
			lvl_Filtro = 5
		End If
		
		If of_abre_comunicacao_api('GET',"pedido?$filter=" + lvs_filtro_pedido) Then			
			lvl_Sucesso = of_comunicacao_api('','GET',"pedido?$filter=" + lvs_filtro_pedido)
		Else
			lvl_Sucesso = -1
		End If
		
		of_fecha_comunicacao_api()
			
		If lvl_Sucesso < 1 Then
			lvb_Sucesso = False
			Continue // Erro na comunica$$HEX2$$e700e300$$ENDHEX$$o com a Vannon
		End If
		
		//Repete para cada pedido do
		ls_Pedidos_Retorno_API = ivs_Retorno_Api
		Do While ivo_gera_json.of_divide_grupo_json_completo(Ref ls_Pedidos_Retorno_API, Ref lvs_retorno_pedido,'{') 
			
			lvs_sobra_pedido_entrega 	= lvs_retorno_pedido
			lvs_sobra_pedido_status 	= lvs_retorno_pedido
			lvs_sobra_cliente 				= lvs_retorno_pedido
			lvs_sobra_pbm 				= lvs_retorno_pedido
			
			ivo_gera_json.of_divide_grupo_json_tag(Ref lvs_sobra_pedido_entrega, 'PedidoEntrega', Ref lvs_retorno_pedido_entrega,'}') 
			ivo_gera_json.of_divide_grupo_json_tag(Ref lvs_sobra_pedido_status, 'PedidoStatus', Ref lvs_retorno_pedido_status,'}') 
			ivo_gera_json.of_divide_grupo_json_tag(ref lvs_sobra_cliente, 'Cliente', Ref lvs_retorno_cliente,'}') 
			ivo_gera_json.of_divide_grupo_json_tag(ref lvs_sobra_pbm, 'Pbm', Ref lvs_retorno_pbm,'}') 
			
			lvb_Sucesso = False
			
			ivs_Cliente_Clube 			= lvs_Nulo
			ivs_cartao_credito			= lvs_Nulo
			ivs_autorizacao_cartao	= lvs_Nulo
			ivs_comprovante_cartao	= lvs_Nulo
			ivs_Estabelecimento		= lvs_Nulo
			ivs_Tipo_Vale				= lvs_Nulo
			ivs_Cupom_Desconto		= lvs_Nulo
			ivdc_ValeCompra 			= 0
			
			SetNull( ivs_Via_PBM )
			If ivo_gera_json.of_existe_campo( lvs_retorno_pbm, "Comprovante" ) Then
				ivs_Via_PBM = ivo_gera_json.of_busca_conteudo_campo( lvs_retorno_pbm, 'Comprovante' )
			End If
			
			lvs_Pedido_Vannon		= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'NumeroPedido') //9 posicoes com zeros $$HEX1$$e000$$ENDHEX$$ esquerda
						
			If Len(lvs_Pedido_Vannon) = 9 Then
				ivl_Pedido = Long(lvs_Pedido_Vannon)				
			Else
			 	//ivl_Pedido  = Long('4' + lvs_Pedido_Vannon) // Para que a numera$$HEX2$$e700e300$$ENDHEX$$o Vannon n$$HEX1$$e300$$ENDHEX$$o coincida com uma numera$$HEX2$$e700e300$$ENDHEX$$o antiga Webstorm
				 This.of_Grava_Arquivo(  '[Erro] Numeracao invalida: ' + lvs_Pedido_Vannon , True )
				Continue 
			End If
			
			ivdt_Compra 				= Datetime(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'DataPedido'),'T',' ',0))			 
			 ivdt_Atualizacao			= Datetime(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'DataPedido'),'T',' ',0))
			 ivs_Situacao 				= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_status, 'CodigoExterno') 
			 ivl_Cliente 					= Long(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'ClienteId'))
	
			 ivs_Nome 					= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Nome'))
			 ls_Sobrenome				= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Sobrenome'))
			 ivs_Nome					+= ls_Sobrenome
			 
			 ivs_Email 					= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Email')
			 ivs_CPF_CGC 				= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'CpfCnpj')
			 ivs_CPF_CGC 				= RightA('00000000000' + ivs_CPF_CGC, 11)
			
				//Tratamento pedido duplicado ____________________________________
			 If Date(ivdt_Compra) >= Date('20190130') and This.is_Rede_Ecommerce = 'FA' Then
		 
				select Cast(dh_compra as date) 
					into :ldt_pedido_Aux
				from pedido_ecommerce 
				where nr_pedido = :ivl_Pedido
					and cd_filial_ecommerce = 809
				 Using SqlCa;
				 
				 If SqlCa.SqlCode = -1 Then
					This.of_Grava_Arquivo(  '[Erro] consulta data pedido antigo: ' + String(ivl_Pedido) , True )
					Continue
				End If
				
				If  SqlCa.SqlCode = 0 Then
					If Date(ivdt_Compra) <> ldt_pedido_Aux Then
						This.of_Grava_Arquivo(  '[Erro] Pedido duplicado digito 1: ' + String(ivl_Pedido) + ' Data select ' + String(ldt_Pedido_Aux) + ' - Data xml ' + String(ivdt_Compra) , True )
						Continue
					End If
				End If
			End If
			
			 If ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'tipoPessoa') = 'Juridica' Then
				ivs_IE 					= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'InscricaoEstadual')
				ivs_Fisica_Juridica 	= 'J'
			 Else
				ivs_IE 					= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'RG')
				ivs_Fisica_Juridica 	= 'F'
			 End If
	
			 ivs_Sexo 					= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Sexo'))
			 ivdt_DataNascimento		= Date(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'DataNascimento'))
			 
			 ivs_Endereco 				= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Endereco'))
			 ivs_Numero 				= String(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Numero'))
			 ivs_Complemento 		= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Complemento'))
			 ivs_Bairro 					= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, '"Bairro"'))
			 ivs_Cidade 					= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, '"Cidade"')) // Com aspas pois a palavra Cidade pode fazer parte do endere$$HEX1$$e700$$ENDHEX$$o Ex: Rua Cidade das $$HEX1$$c100$$ENDHEX$$guas
			 ivs_UF 						= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, '"Estado"') 
			 ivs_CEP 						= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Cep')
			 ivs_CEP 						= RightA('00000000' + ivs_CEP, 8)
			 ivs_Pais 						= 'BRASIL' 
			 ivs_Fone 					= '(' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'TelefoneDDD') + ')' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Telefone"') 
			 ivs_Fone_Contato 		= '(' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'CelularDDD') + ')' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Celular"') 
			 
			 ivs_Contato 				= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Responsavel'))
			 //ivs_Nome_Ent 				= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Destinatario'))
			 //If Trim( ivs_Nome_Ent ) = "" Then ivs_Nome_Ent = ivs_Nome
			 ivs_Nome_Ent 				= ivs_Nome // Chamado 241639
			 
			 ivs_Endereco_Ent 		= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Endereco'))
			 ivs_Numero_Ent 			= String(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Numero'))
			 ivs_Complemento_Ent	= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Complemento'))
			 ivs_Bairro_Ent 				= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, '"Bairro"'))
			 ivs_Cidade_Ent 			= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, '"Cidade"'))
			 ivs_UF_Ent 					= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, '"Estado"')
			 
			 ivs_Referencia_Ent 		= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Referencia')
			 ivs_CEP_Ent 				= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Cep')
			 ivs_CEP_Ent 				= RightA('00000000' + ivs_CEP_Ent, 8)
			 ivs_Pais_Ent 				= 'BRASIL' 
			 ivs_Fone_Ent 				= '(' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'TelefoneDDD') + ')' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'Telefone"') 
			 ivs_Fone_Contato_Ent 	= '(' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'CelularDDD') + ')' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Celular"') 
	//		 ivs_Tipo_Frete 			= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'idFrete')
			 ivs_Transportadora 		= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'ModalidadeEntrega'))   
			 ivi_Prazo_Entrega 		= Long(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'PrazoEntrega')) // dias
			 ivs_Regiao 					= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'CodigoPraca')
			 ivs_Filial_Retirada			= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'CodigoPraca')
			 ivdc_Embalagem 			= 0	 
			 ivdc_Frete 					= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'Frete'),'.',',',0))
			 ivdc_Desconto 				= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'Desconto'),'.',',',0))
			 ivdc_Total 					= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'Total'),'.',',',0))
			 ivdc_Subtotal 				= ivdc_Total - ivdc_Frete + ivdc_Desconto
			 ivdc_Indexador 			= 0
			 ivi_Boleto_Parcelado 		= 0
			 ivs_Observacao 			= ''
			 
			 //Tratamento DC
			 //Se a praca retornada for FILIAL_SITE_DC o pedido_drogaexpress deve gravado na 454.
			IF Long(ivs_Filial_Retirada) = FILIAL_SITE_DC Then
				ivs_Filial_Retirada = String(454)
				ivs_Regiao = ivs_Filial_Retirada
			End If
				 
			ivdc_ValeCompra 			= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'DescontoCupom'),'.',',',0))
			If ivdc_ValeCompra > 0 Then
			
				// Temporario pelo problema de erro nos valores na vannon quando h$$HEX1$$e100$$ENDHEX$$ vale
				This.of_Grava_Arquivo( "Pedido '" + String(ivl_Pedido) + "' cont$$HEX1$$e900$$ENDHEX$$m vale compra.~r~r" + ivs_Retorno_Api, True )
				//Continue
				//
				
				 ivs_Tipo_Vale   			= 'C'
				 ivs_Cupom_Desconto		= '1'
				 
				 //ivdc_Desconto				= ivdc_Desconto - ivdc_ValeCompra
				 //ivdc_Total					= ivdc_Total + ivdc_ValeCompra
				 //ivdc_Subtotal				= ivdc_Total //- ivdc_Frete + ivdc_Desconto + ivdc_ValeCompra
			End If

			//Bloqueio Valor pago a menor que o valor total
			ldc_Pagto 		= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'ValorParcela'),'.',',',0))
			ls_Parcela 		= Upper(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'NumeroParcela'),'.',',',0))
			
			If ls_Parcela = "NULL" Then
				li_NumParcela = 1
			Else
				li_NumParcela = Integer( ls_Parcela )
			End If
				
			ldc_Pagto = Round( ldc_Pagto * li_NumParcela, 2 )
			
			If Abs( ( ivdc_Total - ldc_Pagto ) ) > ( li_NumParcela / 100 ) Then
				This.of_Grava_Arquivo( "~rPedido: " + String(ivl_Pedido) + "~r~r Diverg$$HEX1$$ea00$$ENDHEX$$ncia entre o valor do pagamento e o valor do pedido.~rPedido: R$ " + String( ivdc_Total ) + "~rPagamento: R$ " + String( ldc_Pagto ) + &
												"~r~rRegra: A diferen$$HEX1$$e700$$ENDHEX$$a entre o valor do pedido e do pagamento, n$$HEX1$$e300$$ENDHEX$$o pode ser superior ao n$$HEX1$$fa00$$ENDHEX$$mero de parcelas representado em centavos (" + String( li_NumParcela/100 ) + ").", &
												True, CD_MENSAGEM_EMAIL_EQUIPE_FARMAGORA )
				Continue
			End If
			 
			If Mid(ivs_Transportadora, 1, 16) = 'RETIRADA NA LOJA' or Mid(ivs_Transportadora, 1, 15) = 'RETIRAR EM LOJA' Then
				ivs_Observacao = 'Retirada por '+ Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'NomeRetirarLoja')) &
				+ ' CPF: '+ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'CpfRetirarLoja')
			End If
			lvs_conteudo_parcelas = lvs_retorno_pedido
			// Percorrer todas as parcelas, a $$HEX1$$fa00$$ENDHEX$$ltima corresponte a quantidade de parcelas
			//Do While ivo_gera_json.of_divide_grupo_json_tag(Ref lvs_conteudo_parcelas, 'PedidoPagamentos', Ref lvs_retorno_parcelas,'}') 
			ivi_Parcelas 				= Integer(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'NumeroParcela')) // Conte$$HEX1$$fa00$$ENDHEX$$do da tag
			//Loop
			
			//Carrega dados de pagamento
			If Not of_Forma_Pagamento(lvs_retorno_pedido) Then
				Continue
			End If
			
			ivs_Origem 				= ''
	
			If (ivs_Forma_Pagto_Droga	= 'CP') Then
				ivo_gera_json.of_divide_grupo_json_tag(Ref lvs_conteudo_parcelas, 'PedidoPagamentos', Ref lvs_retorno_parcelas,'}')
				ivs_cartao_credito		 	= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'NumeroBinCartao')
				ivs_autorizacao_cartao	= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'Nsu')
				ivs_comprovante_cartao	= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'Comprovante') + ' *'
				
				If Not This.of_Valida_Cartao_Credito( ) Then // NSU
					Continue
				End If
				
				lvl_Pos = Pos(lvs_retorno_parcelas, "ESTAB:")		
				If lvl_Pos > 0 Then
					ivs_Estabelecimento = Mid(lvs_retorno_parcelas, lvl_Pos + 6, 9)
				End If
				
			Else
				
				 //DESENVOLVIMENTO
	//			#IF DEFINED DEBUG THEN
	//				ivs_Situacao = 'PCO'
	//			#END IF
				
				If ivs_Situacao <> 'PCO' and ivs_Situacao <> 'PCB' Then //Aprovado
					Continue
				End If
			End If
	
			If Mid(trim(ivs_Transportadora), 1, 3) = "PAC" Then
				ivs_Transportadora = "PAC"
			End If
			
			If Mid(trim(ivs_Transportadora), 1, 5) = "SEDEX" Then
				ivs_Transportadora = "SEDEX"
			End If
			
			// Novo esquema de defini$$HEX2$$e700e300$$ENDHEX$$o da filial de acordo com a pra$$HEX1$$e700$$ENDHEX$$a retornada na integra$$HEX2$$e700e300$$ENDHEX$$o
			ivl_Filial_Disque = Long(ivs_Filial_Retirada)
	
			If IsNumber(ivs_Filial_Retirada) And ( Mid(trim(ivs_Transportadora), 1, 16) = 'RETIRADA NA LOJA' Or Mid(ivs_Transportadora, 1, 15) = 'RETIRAR EM LOJA' ) Then
				ivs_Transportadora = 'RETIRAR NA LOJA'
			End If
			
			If IsNumber(ivs_Filial_Retirada) And ( Mid(trim(ivs_Transportadora), 1, 19) = 'ARM$$HEX1$$c100$$ENDHEX$$RIO INTELIGENTE' ) Then
				ivs_Transportadora = 'ARM$$HEX1$$c100$$ENDHEX$$RIO INTELIGENTE'
			End If
		
			 If ivb_Ambiente_Teste Then
				ivl_Filial_Disque = 563
			 End If
			 
			 //Verifica se o cliente tem cadastro no clube
			 If Not of_Verifica_Cliente() Then
				Yield()
				Continue
			 End If
				
			 // Se a filial for igual da anterior n$$HEX1$$e300$$ENDHEX$$o conecta novamente
			 If ivl_Filial_Disque <> lvl_Filial_Disque_Anterior Then
				 If Not of_Conecta_Banco_Filial_Destino(ivl_Filial_Disque) Then
					If (ivb_Pedido_Pendente) Then
						Return False
					Else
						If This.is_Rede_Ecommerce = 'FA' Then
							Exit
						Else
							Continue
						End If
					End If
				 End If	
				 
				 lvl_Filial_Disque_Anterior = ivl_Filial_Disque
			 Else
				If Not Destino.of_isConnected() Then
					If This.is_Rede_Ecommerce = 'FA' Then
						Exit
					Else
						Continue
					End If
				End If
			 End If
			 
			 ivdc_Produtos_Calculado = 0
			
			 //DESENVOLVIMENTO
//			#IF DEFINED DEBUG THEN
//				ivs_Situacao = 'PCO'
//			#END IF
			
			 If ivs_Situacao <> 'PCO' and ivs_Situacao <> 'PCB' Then //N$$HEX1$$e300$$ENDHEX$$o Aprovado
				Choose Case ivs_situacao
					Case 'NAA' //Nao Autorizado Antifraude
						ivs_situacao = 'C'
					Case 'AGA' //Em An$$HEX1$$e100$$ENDHEX$$lise
						//ivs_situacao = 'E'
						ivs_situacao = 'P'
				End Choose
				
				If ivs_situacao = 'C' or ivs_situacao = 'P' Then
					If This.of_Grava_Pedido() Then //Situa$$HEX2$$e700e300$$ENDHEX$$o P - PENDENTE
						//N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio incluir pedido_ecommerce_produto com situa$$HEX2$$e700e300$$ENDHEX$$o 'C' ou 'P'
						//Quando mudar a situa$$HEX2$$e700e300$$ENDHEX$$o para PCO(pagamento Confirmado) os itens ser$$HEX1$$e300$$ENDHEX$$o importados no processo normal.
						If This.of_Grava_Cartao_Comprovante_Venda(String(ivl_pedido)) Then
							lvb_Sucesso = True
						End If
					End If
					
//					If This.of_Grava_Pedido_Pendente() Then
//						If This.of_Importa_Produtos_Pedido(ivl_Pedido, lvs_retorno_pedido, lvs_Pedido_DrogaExpress, True) Then
//							If This.of_Grava_Cartao_Comprovante_Venda(String(ivl_pedido)) Then
//								lvb_Sucesso = True
//							End If
//						End If
//					End If
				End If
				
			 Else //Aprovado
				
				If Not IsNull( ps_Cep ) Then // As atribui$$HEX2$$e700f500$$ENDHEX$$es dentro do IF abaixo s$$HEX1$$e300$$ENDHEX$$o necess$$HEX1$$e100$$ENDHEX$$rias para a fun$$HEX2$$e700e300$$ENDHEX$$o of_valida_endereco
					ivs_CEP_Ent				= ps_Cep // Importa$$HEX2$$e700e300$$ENDHEX$$o pela tela w_ge226_importa_pedido com preenchimento de CEP, quando houver inconsist$$HEX1$$ea00$$ENDHEX$$ncia no CEP retornado pela integra$$HEX2$$e700e300$$ENDHEX$$o					
					ivs_Cep_Substituicao	= ps_Cep
				End If
				
				If This.of_Pedido_Possui_Inconsistencia( ) Then
					If (ivb_Pedido_Pendente) Then
						Return False
					Else
						Continue
					End If
				End If
				
				 //Grava o pedido eCommerce no Sybase		
				 If of_Grava_Pedido() Then
					 // Grava o pedido do Disque Entrega
					 If of_Grava_Pedido_DrogaExpress(Ref lvs_Pedido_DrogaExpress) Then
						If of_Grava_Cartao_Comprovante_Venda(String(ivl_pedido)) Then
							 // Gra os produtos no pedido eCommerce(Sybase) e no pedido disque entrega
							 If of_Importa_Produtos_Pedido(ivl_Pedido, lvs_retorno_pedido, lvs_Pedido_DrogaExpress, False) Then
								// Atualiza o total de produtos e o desconto
								 If of_Atualiza_Pedido_DrogaExpress(lvs_Pedido_DrogaExpress) Then
									 // Coloca o n$$HEX1$$fa00$$ENDHEX$$mero do pedido drogaexpress no pedido eCommerce do Sybase e Atualiza Pedido Pendente 
									 //Atualiza o cep caso tenha sido alterado na importacao
									 If of_Atualiza_Pedido_Ecommerce(lvs_Pedido_DrogaExpress) Then
										 lvb_Sucesso = True
									 End If
								End If 
							 End If
						End If
					 End If
				 End If
			 End If // If ivs_Situacao <> 'PCO' and ivs_Situacao <> 'PCB'
			 
			 // Faz um commit por pedido, se houver um pedido com problema n$$HEX1$$e300$$ENDHEX$$o para o processo por completo
			 If lvb_Sucesso Then
				SqlCa.of_Commit();
				Destino.of_Commit();
				ivs_json_captura_pedido = '[{"NumeroPedido": "'+ lvs_Pedido_Vannon + '"}]'
				
				//Marcar no site os pedidos que j$$HEX1$$e100$$ENDHEX$$ foram integrados pelo ERP.
				If Not This.ivb_Ambiente_Teste Then // Se for ambiente de teste, n$$HEX1$$e300$$ENDHEX$$o atualiza o site
					//ivs_json_captura_pedido= '['+ ivs_json_captura_pedido +']'
						
					Try		
						If Not This.of_abre_comunicacao_api('POST','pedidocaptura') Then
							lvl_Sucesso = -1
						Else
							lvl_Sucesso = This.of_comunicacao_api(ivs_json_captura_pedido,'POST','pedidocaptura')	
						End If
							
					Finally
						This.of_fecha_comunicacao_api( )
						
						If lvl_Sucesso = 1 Then				
							This.of_Grava_Arquivo(  '[OK] ivs_json_captura_pedido: ' +  ivs_json_captura_pedido, False )
						Else
							This.of_Grava_Arquivo( '[ERRO] ivs_json_captura_pedido: ' +  ivs_json_captura_pedido, True )
						End If
					End Try
					
				End If
				
				This.of_Grava_Arquivo( "[OK] Pedido inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso: " +String(ivl_Pedido) + " | ivs_json_captura_pedido: = " + ivs_json_captura_pedido, False )	
			 Else
				SqlCa.of_RollBack();
				Destino.of_RollBack();
			 End If
				 
			 Yield()
		
		Loop //While tag pedido
	
	Loop //While filtro situa$$HEX2$$e700e300$$ENDHEX$$o
		
	Return True
	
Finally
	If This.ivb_Log_Pedidos_Aberto And Not ivb_Pedido_Pendente Then
		This.of_Grava_Arquivo( "[OK] T$$HEX1$$e900$$ENDHEX$$rmino da importa$$HEX2$$e700e300$$ENDHEX$$o | of_importa_pedidos(long, string).~r", False )
		FileClose( This.ivi_Log )
		This.ivb_Log_Pedidos_Aberto = False
	End If
	
	If Not ivb_Pedido_Pendente Then
		Close(w_Aguarde_2)
		SetPointer(Arrow!)
		gvs_eCommerce = 'N'
	End If
End Try
end function

public function boolean of_atualiza_produtos (long pl_produto, string as_rede_ecommerce);Boolean 	lvb_Continua_Processo = True,&
			lvb_Produto_Promocao,&
			lvb_Existe_Promocao_Produto,&
			lvb_Atualiza_Preco, &
			lvb_Disponivel

Integer 	lvi_Categoria,&
			lvi_Retorno

Long 	lvl_Linhas,&
	 	lvl_Linha,&
	 	lvl_Produto,&
	 	lvl_Estoque,&	 	
		lvl_Contador, &
		lvl_Cont_Filial, &
		lvl_Filiais, &
		lvl_Filial

String	lvs_Descricao,&
	   	lvs_Descricao_Principal,&
	   	lvs_Mensagem,&
	   	lvs_Situacao,&
	   	lvs_Ecommerce,&	   	
	   	lvs_Psico,&
		lvs_acao,&
		lvs_Inicio_Promocao,&
		lvs_Termino_Promocao, &
		lvs_De_Codigo_Barras, &
		lvs_Id_Lei_Generico, &
		lvs_Grupo_Produto, &
		lvs_SubGrupo_Produto, &
		lvs_De_Registro_Ms

String lvs_Cod_Produto_SAP, ls_Disponivel_Site	   
		
Decimal 	lvdc_Preco,&
			lvdc_Desconto,&
			lvdc_Desconto_Filial, &
			lvdc_Desconto_Ecommerce, &
			lvdc_Preco_Promocao,&
			lvdc_Nulo

Decimal ldc_Desconto_Clube

DateTime	lvdt_Inicio_Promocao,&
				lvdt_Termino_Promocao

Double lvdc_Peso

Long ll_Filial_Preco

Integer li_Max_Atualizacao

Try
	This.of_verifica_filial_site_atualizacao( as_Rede_Ecommerce )
		
	//Atualizacao Marcas
	This.of_Atualiza_Marcas( )
	
	If Not of_verifica_conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o liberada no Desenvolvimento.", StopSign!)
		//Return False
	End If
	
	dc_uo_ds_base lvds_Produto
	dc_uo_ds_base lvds_Saldo
	dc_uo_ds_base lvds_Filiais_Saldo
	
	SetNull(lvdc_Nulo)
	
	ivi_Produtos_Alterados 			= 0
	ivi_Produtos_Sku_Alterados 	= 0
	ivi_Produtos_Praca_Alterados 	= 0
	ivi_Produtos_Incluidos 			= 0
	ivi_Produtos_Sku_Incluidos 		= 0
	ivi_Produtos_Praca_Incluidos	= 0
	
	gvs_eCommerce = 'S'
	
	lvds_Produto		= Create dc_uo_ds_base
	lvds_Saldo			= Create dc_uo_ds_base
	lvds_Filiais_Saldo	= Create dc_uo_ds_base
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde_2)
	w_Aguarde_2.Title = "Atualizando os produtos do eCommerce ..."
	
	// Abre o arquivo de log
	If Not This.of_Abre_Arquivo("ecommerce_produtos") Then Return False
		
	// Grava no log o in$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o
	If Not This.of_Grava_Arquivo( "In$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o. Rede: " + This.is_Rede_Ecommerce, False ) Then Return False
	
	// Faz atualizacao pelo log_exportacao_ecommerce
	//If Not lvds_Produto.of_ChangeDataObject("ds_ge226_lista_produto_log_desenv") Then //produto_geral
	If Not lvds_Produto.of_ChangeDataObject( "ds_ge226_lista_produto_log" ) Then
		This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_produtos( long ) | ChangeDataObject( ds_ge226_lista_produto_log )", True )
		Return False
	End If
		
	// Atualiza os registros para pendentes
	If Not This.of_Atualiza_Log_Exportacao( "P", 'PRODUTO_GERAL', '' ) Then Return False // Tratamento de erro na fun$$HEX2$$e700e300$$ENDHEX$$o
	
	If Not IsNull( pl_Produto ) Then
		lvds_Produto.of_AppendWhere("de_chave = '" + String( pl_Produto ) + "'" )
		//lvds_Produto.of_AppendWhere("cd_produto in (730942 ) " )			
	End If
			
	If lvds_Produto.Retrieve( il_Filial_Site_Em_Atualizacao ) = -1 Then
		This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_produtos( long ) | lvds_Produto.Retrieve( il_Filial_Site_Em_Atualizacao )", True )
		Return False
	End If
				
	lvl_Linhas = lvds_Produto.RowCount()
	
	If lvl_Linhas = 0 Then Return True
		
	w_Aguarde_2.Title = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o de produto Ecommerce: 'carregando o saldo das filiais' ..."
		
	If Not This.of_Carrega_Saldo( pl_Produto, Ref lvds_Saldo ) Then Return False
	
	w_Aguarde_2.Title = "Atualizando os produtos do eCommerce ..."
						
	w_Aguarde_2.uo_Progress.of_SetMax( lvl_Linhas )

	
	//Atualizacao DC
	//A cada 3 produtos x 48 filiais s$$HEX1$$e300$$ENDHEX$$o enviados ao webservice da vannon
	If This.il_filial_site_em_atualizacao = 986 Then
		li_MAx_Atualizacao = 3
	Else
		li_MAx_Atualizacao = 10
	End If
		
	For lvl_Linha = 1 To lvl_Linhas
						
		Yield()

		// Atualiza$$HEX2$$e700e300$$ENDHEX$$o pelo log_exportacao_ecommerce
		lvl_Produto = Long(lvds_Produto.Object.de_chave[lvl_Linha])

		w_Aguarde_2.Title = "Atualizando os produtos do eCommerce ... '"  + string(lvl_Linha) + "' de '" + string(lvl_Linhas) + "'"
			
		ivo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)

		If Not ivo_Produto.Localizado Then Continue

		lvl_Contador++ 

		lvs_Descricao				= ivo_Produto.de_descricao_internet
		lvs_Descricao_Principal 	= ivo_Produto.de_principal_internet
		lvdc_Peso					= ivo_Produto.qt_peso_grama			
		lvs_Situacao					= ivo_Produto.id_situacao
		lvs_De_Codigo_Barras	= ivo_Produto.de_codigo_barras			
		lvs_Grupo_Produto			= Mid(ivo_Produto.cd_subcategoria, 1, 1)
		lvs_SubGrupo_Produto	= Mid(ivo_Produto.cd_subcategoria, 1, 3)
		lvs_Id_Lei_Generico 		= ivo_Produto.id_lei_generico
		lvs_De_Registro_Ms		= ivo_Produto.de_registro_ms
		lvs_Cod_Produto_SAP		= MidA(ivo_Produto.cd_produto_sap, 1, 10)
		
		If IsNull(lvs_Cod_Produto_SAP) Then lvs_Cod_Produto_SAP = ""
		
		//Verifica Produto Liberado Ecommerce
		Choose Case as_Rede_Ecommerce
			Case 'FA'; lvs_Ecommerce = ivo_Produto.id_liberado_ecommerce
			Case 'DC'; lvs_Ecommerce = ivo_Produto.id_liberado_ecommerce_DC
			Case 'MP'; lvs_Ecommerce = ivo_Produto.id_liberado_ecommerce_MP
		End Choose
		
		// Para n$$HEX1$$e300$$ENDHEX$$o deixar a descri$$HEX2$$e700e300$$ENDHEX$$o detalhada em branco vai ser utilizado a descri$$HEX2$$e700e300$$ENDHEX$$o da internet
		If IsNull(lvs_Descricao_Principal) or lvs_Descricao_Principal = "" Then
			lvs_Descricao_Principal = lvs_Descricao
		End If
									
		If IsNull(lvs_Ecommerce) Then lvs_Ecommerce = 'N'
		
		//Filial Pre$$HEX1$$e700$$ENDHEX$$o
		Choose Case This.is_Rede_Ecommerce
			Case 'DC';  	ll_Filial_Preco = ivl_Filial_Ecommerce 				//790
			Case 'FA';	ll_Filial_preco = ivl_Filial_Ecommerce_Preco 		//454
			Case 'MP';   ll_Filial_preco = ivl_Filial_Ecommerce_Preco_MP 	//786
		End Choose	 
			
		If lvs_Situacao = 'A' and lvs_Ecommerce = 'S' Then

			// N$$HEX1$$e300$$ENDHEX$$o pode ser psico 	// N$$HEX1$$e300$$ENDHEX$$o pode ser geladeira		// N$$HEX1$$e300$$ENDHEX$$o pode ser produto de almoxarifado
					
			lvs_Psico	=	ivo_Produto.cd_grupo_psico
			If Isnull(lvs_Psico) and  Mid(ivo_Produto.de_produto, 1, 2) <> 'ZZ' and lvs_Grupo_Produto <> '5' Then
				// Verifica categoria, altura, largura, profundidade e peso
				If Not of_Valida_Informacoes(lvl_Produto, Ref lvi_Categoria, Ref lvb_Continua_Processo) Then
					// Atualiza os registros para processados e continua
					If This.of_Atualiza_Log_Exportacao("S", 'PRODUTO_GERAL', String(lvl_Produto) ) Then
						SqlCa.of_Commit();
						Continue
					Else
						SqlCa.of_RollBack();
						Exit
					End If
				Else
					If Not lvb_Continua_Processo Then
						// Indisponivel no site
						lvb_Disponivel = false
					Else
						// Disponivel no site
						lvb_Disponivel = true
					End If
				End If
			Else
				// Indisponivel no site
				lvb_Disponivel = false
			End If
		Else // If lvs_Situacao = 'A' and lvs_Ecommerce = 'S' Then
			
			// Indisponivel no site
			If Not of_Valida_Informacoes(lvl_Produto, Ref lvi_Categoria, Ref lvb_Continua_Processo) Then
				// Atualiza os registros para processados e continua
				If This.of_Atualiza_Log_Exportacao("S", 'PRODUTO_GERAL', String(lvl_Produto) ) Then
					SqlCa.of_Commit();
					Continue
				Else
					SqlCa.of_RollBack();
					Exit
				End If
			Else
				lvb_Disponivel = false
			End If
		End If
		
		//lvi_Retorno =  This.of_Existe_Produto_Site( lvl_Produto )
		
		select COALESCE( id_disponivel_site, 'N' ) 
		into   :ls_Disponivel_Site
		from produto_ecommerce_atualizacao
			where cd_filial_ecommerce = :il_Filial_Site_Em_Atualizacao
				and cd_produto				= :lvl_Produto
				and id_ecommerce  		= '1'
			Using SqlCa;
		
		Choose Case SqlCa.SqlCOde
			Case -1
				This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_produtos | erro ao localizar produto_ecommerce_atualizacao. Prd: " + String(lvl_Produto), True )
				Exit
			Case 100
				lvs_acao = 'insert'
			Case 0
				If ls_Disponivel_Site = 'S' Then
					lvs_acao = 'update'
				Else
					lvs_acao = 'insert'
				End If
		End Choose

		//N$$HEX1$$e300$$ENDHEX$$o inserir produto indispon$$HEX1$$ed00$$ENDHEX$$vel. Caso o produto j$$HEX1$$e100$$ENDHEX$$ exista no site, fazer o update para indispon$$HEX1$$ed00$$ENDHEX$$vel.
		If lvs_acao = 'insert' and lvb_Disponivel = false Then				
			// Atualiza os registros para processados
			If This.of_Atualiza_Log_Exportacao("S", 'PRODUTO_GERAL', String(lvl_Produto) ) Then
				SqlCa.of_Commit();
				Continue
			Else
				SqlCa.of_RollBack();
				Exit
			End If
		End If
			
		If This.of_atualiza_produto_site(lvl_Produto, lvs_acao, lvb_Disponivel) Then
			// Atualiza os registros para processados
			If This.of_Atualiza_Log_Exportacao("S", 'PRODUTO_GERAL', String(lvl_Produto) ) Then
				This.of_envia_produtos(lvl_Produto, lvs_Descricao, lvs_Descricao_Principal, lvb_Disponivel, &
															ivdc_Peso, ivdc_Altura, ivdc_Largura, ivdc_Profundidade, &
															lvs_acao, lvs_De_Codigo_Barras, lvs_Id_Lei_Generico, lvs_Grupo_Produto, &
															lvs_De_Registro_Ms, lvs_SubGrupo_Produto, lvs_Cod_Produto_SAP)
			End If	
		End If
			
		// O sistema ir$$HEX1$$e100$$ENDHEX$$ verificar se o produto est$$HEX1$$e100$$ENDHEX$$ em alguma promo$$HEX2$$e700e300$$ENDHEX$$o exclusiva do FARMAGORA, ou promo$$HEX2$$e700e300$$ENDHEX$$o normal.
		// Se sim, ir$$HEX1$$e100$$ENDHEX$$ utilizar o percentual de desconto maior.
		If Not This.of_Existe_Promocao_Farmagora_Produto(Ref lvb_Existe_Promocao_Produto) Then
			Exit
		End If
				
		lvdc_Desconto_Ecommerce 	= 0
		lvdc_Desconto_Filial 			= 0
		lvdc_Desconto 					= 0				
		ldc_Desconto_Clube			= 0
				
		lvdc_Desconto_Filial = ivo_Produto.of_Desconto_Filial( ll_Filial_preco )
		
		//Tratamento desconto clube DC
		If This.is_Rede_Ecommerce = 'DC' Then
			ldc_Desconto_Clube = ivo_Produto.of_desconto_clube_filial( ll_Filial_preco )
			
			If ldc_Desconto_Clube > lvdc_Desconto_Filial Then
				lvdc_Desconto_Filial = ldc_Desconto_Clube
			End If
		End If
		
		//Promo$$HEX2$$e700e300$$ENDHEX$$o especifica para o ecommerce
		If lvb_Existe_Promocao_Produto Then
			lvdc_Desconto_Ecommerce = ivo_Produto.of_Desconto_Filial( il_Filial_Site_Em_Atualizacao, 'F' )		
			
			If ( lvdc_Desconto_Ecommerce > 0 ) and ( lvdc_Desconto_Ecommerce >= lvdc_Desconto_Filial ) Then
				lvdc_Desconto = lvdc_Desconto_Ecommerce
			Else
				If (lvdc_Desconto_Filial > 0) Then
					// Chama fun$$HEX2$$e700e300$$ENDHEX$$o novamente para recarregar o ivo_Produto.cd_promocao_sos
					lvdc_Desconto = ivo_Produto.Of_Desconto_Filial( ll_Filial_preco )
				End If 
			End If
		Else
			If (lvdc_Desconto_Filial > 0) Then
				lvdc_Desconto = lvdc_Desconto_Filial
			End If
		End If				
		
		lvdc_Preco	= ivo_Produto.of_Preco_Venda_Filial_Matriz( ll_Filial_preco )
		
		If lvdc_Desconto > 0 Then
			lvdc_Preco_Promocao= Round(lvdc_Preco - (lvdc_Preco * (lvdc_Desconto / 100)), 2)
		Else
			lvdc_Preco_Promocao= 0
		End If

		lvs_Inicio_Promocao		= '0' //Para apagar o per$$HEX1$$ed00$$ENDHEX$$odo de promo$$HEX2$$e700e300$$ENDHEX$$o caso exista.
		lvs_Termino_Promocao	= '0'
		
		// Se exite promo$$HEX2$$e700e300$$ENDHEX$$o
		If Not IsNull(ivo_Produto.cd_promocao_sos) Then
			If Not ivo_Produto.of_Periodo_Promocao_SOS(Ref lvdt_Inicio_Promocao, Ref lvdt_Termino_Promocao) Then
				Exit
			End If
			
			If IsNull(lvdt_Termino_Promocao) Then
				lvdt_Termino_Promocao = DateTime( RelativeDate ( Today( ), 365 ) )
			End If
				
			lvs_Inicio_Promocao 		= String(lvdt_Inicio_Promocao , 'yyyy-mm-dd')
			lvs_Termino_Promocao 	= String(lvdt_Termino_Promocao , 'yyyy-mm-dd')
		Else
			// Se o desconto fixo for maior ou igual da promo$$HEX1$$e700$$ENDHEX$$ao SOS ou se o produto possuir somente o desconto fixo
			// o pre$$HEX1$$e700$$ENDHEX$$o vai liquido para o site porque nao tem periodo
			If lvdc_Desconto > 0.00 Then
				lvdc_Preco					= lvdc_Preco_Promocao
				lvdc_Preco_Promocao		= 0
			End If
		End If
		
		// Se o produto estiver cadastrado em alguma promo$$HEX2$$e700e300$$ENDHEX$$o no firstclass este deve estar relacionado
		// na tabela produto_ecommerce_promocao para n$$HEX1$$e300$$ENDHEX$$o sobrepor os descontos durante as atualiza$$HEX2$$e700f500$$ENDHEX$$es
//		If Not of_Produto_Ecommerce_Promocao(lvl_Produto, Ref lvb_Produto_Promocao) Then
//			Exit
//		End If
				
//		If lvb_Produto_Promocao and lvs_acao = 'update' Then //or lvdc_Preco_Promocao = 0.00 Then
//			lvb_Atualiza_Preco = False
//		End If				
		
		lvb_Atualiza_Preco = True	
		
		If Not lvds_Filiais_Saldo.of_ChangeDataObject("ds_ge226_lista_filiais_ecommerce") Then
			This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_produtos( long ) | lvds_Filiais_Saldo.of_ChangeDataObject( 'ds_ge226_lista_filiais_ecommerce' )", True )
			Exit
		End If
		
		If This.is_Rede_Ecommerce = 'MP' Then
			lvds_Filiais_Saldo.InsertRow(0)
			lvds_Filiais_Saldo.Object.cd_filial[1] = 786
		Else
			//Na atualiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do site DC deve carregar tamb$$HEX1$$e900$$ENDHEX$$m o estoque da 454
			If This.is_Rede_Ecommerce = 'DC' Then
				lvds_Filiais_Saldo.of_appendwhere( "id_rede in ('DC', 'FA')")
			Else
				lvds_Filiais_Saldo.of_appendwhere( "id_rede = '" + This.is_Rede_Ecommerce + "'")
			End If
			
			If lvds_Filiais_Saldo.Retrieve() = -1 Then
				This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_produtos( long ) | lvds_Filiais_Saldo.Retrieve() = -1", True )
				Exit
			End If
			
		End If
		
		lvl_Filiais = lvds_Filiais_Saldo.RowCount()
		
		If lvl_Linhas > 0 Then
			
			For lvl_Cont_Filial = 1 To lvl_Filiais
				lvl_Filial		= lvds_Filiais_Saldo.Object.cd_filial[lvl_Cont_Filial]
				lvl_Estoque	= This.of_Saldo_Produto(lvds_Saldo, lvl_Produto, lvl_Filial)
				
				If lvl_Estoque < 0 Then
					lvl_Estoque = 0
				End If
				
				//Monta XML
				This.of_envia_produto_praca(lvl_Produto,  lvl_Estoque, lvdc_Preco, lvdc_Preco_Promocao, lvs_acao, lvb_Atualiza_Preco, lvs_Inicio_Promocao, lvs_Termino_Promocao, lvl_Filial, lvb_Disponivel)
			Next 
		End If
				
		//Conecta com o Webservice a cada 10 e no $$HEX1$$fa00$$ENDHEX$$ltimo produto
		If lvl_Contador >= li_MAx_Atualizacao or lvl_Contador = lvl_Linhas Then
			lvl_Contador = 0
			
			lvi_Retorno = This.of_envia_grupo_produto()
			
			If lvi_Retorno = 1 Then
				SqlCa.of_Commit()
			Else	
				SqlCa.of_RollBack()
				
				If lvi_Retorno = -1 Then
					Exit
				End If					
			End If
		End If
		
		w_Aguarde_2.uo_Progress.of_SetProgress( lvl_Linha )
		Yield()
		
	Next //For produtos
		
	If lvi_Retorno <> -1 Then
		//Garante que o $$HEX1$$fa00$$ENDHEX$$ltimo grupo de produtos ser$$HEX1$$e100$$ENDHEX$$ atualizado
		lvi_Retorno = This.of_envia_grupo_produto()
	
		If lvi_Retorno = 1 Then
			SqlCa.of_Commit()
		Else	
			SqlCa.of_RollBack()
		End If			
	End If
	
	If lvl_Linhas > 0 Then
		// Grava a quantidade dos produtos atualizados e inclu$$HEX1$$ed00$$ENDHEX$$dos
		This.of_Grava_Arquivo("Total de produtos atualizados: " 		+ String(ivi_Produtos_Alterados), False )
		This.of_Grava_Arquivo("Total de produtos SKU atualizados: "	+ String(ivi_Produtos_Sku_Alterados), False )
		This.of_Grava_Arquivo("Total de produtos Pra$$HEX1$$e700$$ENDHEX$$a atualizados: "	+ String(ivi_Produtos_Praca_Alterados), False )
		This.of_Grava_Arquivo("Total de produtos inclu$$HEX1$$ed00$$ENDHEX$$dos: "			+ String(ivi_Produtos_Incluidos), False)
		This.of_Grava_Arquivo("Total de produtos Sku inclu$$HEX1$$ed00$$ENDHEX$$dos: "		+ String(ivi_Produtos_Sku_Incluidos), False)
		This.of_Grava_Arquivo("Total de produtos Pra$$HEX1$$e700$$ENDHEX$$a inclu$$HEX1$$ed00$$ENDHEX$$dos: " 	+ String(ivi_Produtos_Praca_Incluidos), False)
		
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'EC' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Total de produtos atualizados: " + String(ivi_Produtos_Alterados) + " Inclu$$HEX1$$ed00$$ENDHEX$$dos: " + String(ivi_Produtos_Incluidos))
		End If
	Else
		This.of_Grava_Arquivo("Nenhum produto foi localizado para ser atualizado.", False)
		
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'EC' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto foi localizado para ser atualizado.")
		End If
	End If
	
	// Grava o t$$HEX1$$e900$$ENDHEX$$rmino da atualiza$$HEX2$$e700e300$$ENDHEX$$o no arquivo de log
	This.of_Grava_Arquivo("Termino da atualiza$$HEX2$$e700e300$$ENDHEX$$o. Rede: " + This.is_Rede_Ecommerce, False)
	
	Return True
	
Catch( runtimeerror ru )
	This.of_Grava_Arquivo( "[ERRO] GE226.uo_ecommerce_vannon.of_atualiza_produtos( long ) | " + ru.getMessage( ), True )
	
Finally
	If IsValid( lvds_Produto )			Then	Destroy lvds_Produto
	If IsValid( lvds_Saldo )			Then 	Destroy lvds_Saldo
	If IsValid( lvds_Filiais_Saldo )	Then	Destroy lvds_Filiais_Saldo
	If IsValid( w_Aguarde_2 )		Then	Close( w_Aguarde_2 )
	
	FileClose( ivi_Log )
	
	SetPointer(Arrow!)
	
	gvs_eCommerce = 'N'
End Try

end function

public function boolean of_carrega_saldo (long al_produto, ref dc_uo_ds_base ads_saldo);Long lvl_Cd_Filial
Long lvl_Produto
Long lvl_Qt_Produto
Long lvl_Nova_Linha

String ls_In

Try
	If Not ads_Saldo.of_ChangeDataObject( "ds_ge226_saldo_produto_v" ) Then
		Return False
	End If
	
	//SELECT ANTERIOR ********************
//	SELECT	v.cd_filial,
//					v.cd_produto,
//					v.qt_saldo_final - dbo.uf_saldo_produto_pendente( v.cd_filial, v.cd_produto )
//		FROM vw_saldo_atual_produto v
//		WHERE ( v.qt_saldo_final > 0 ) 
//		AND v.cd_filial in ( select cd_filial from vw_filial f where f.cd_filial = v.cd_filial 
//																		  and f.id_rede in ('FA', 'DC' ) )
	
	ls_In = is_Rede_Ecommerce
	
	If This.is_Rede_Ecommerce = 'DC' Then
		ls_In = "FA"
	End If
	
	//Para TODOS os Produtos
	IF ISNULL( al_Produto ) Then
			
			If is_Rede_Ecommerce = 'MP' Then
				
				DECLARE lcu_cursor_mp CURSOR FOR	
					SELECT	v.cd_filial,
								v.cd_produto,
								v.qt_saldo_final - dbo.uf_saldo_produto_pendente( v.cd_filial, v.cd_produto )
					FROM vw_saldo_atual_produto v
					WHERE v.qt_saldo_final 	>= 0 
					AND v.cd_filial 				= 786
					AND Exists (SELECT * FROM produto_geral a
											  WHERE a.id_liberado_ecommerce_mp = 'S'
												 AND a.cd_produto = v.cd_produto )
					
					USING SqlCa;
				
				OPEN lcu_cursor_mp;
				
				FETCH lcu_cursor_mp
					INTO	:lvl_Cd_Filial,
							:lvl_Produto,
							:lvl_Qt_Produto;
							
				If SQLCA.sqlcode <> 0 Then
					This.of_Grava_Arquivo( "[OK] N$$HEX1$$e300$$ENDHEX$$o existem produtos com saldo maior que zero. Sqlcode: " + string( SQLCA.sqlcode ), False )
					Return False
				End If
					
				DO WHILE SQLCA.sqlcode = 0	
						lvl_Nova_linha = ads_saldo.InsertRow(0)
						
						ads_saldo.Object.cd_produto		[lvl_Nova_Linha] = lvl_Produto
						ads_saldo.Object.qt_saldo_final	[lvl_Nova_Linha] = lvl_Qt_Produto
						ads_saldo.Object.cd_filial			[lvl_Nova_Linha] = lvl_Cd_Filial
						
					FETCH lcu_cursor_mp
						INTO	:lvl_Cd_Filial,
								:lvl_Produto,
								:lvl_Qt_Produto;
				LOOP
				
			Else
				DECLARE lcu_cursor CURSOR FOR	
					SELECT	v.cd_filial,
								v.cd_produto,
								v.qt_saldo_final - dbo.uf_saldo_produto_pendente( v.cd_filial, v.cd_produto )
					FROM vw_saldo_atual_produto v
					WHERE ( v.qt_saldo_final >= 0 )
					AND v.cd_produto in (select cd_produto from produto_geral where (id_liberado_ecommerce ='S' Or id_liberado_ecommerce_dc = 'S'))
					AND v.cd_filial in (  select cd_filial from parametro_loja where cd_parametro = 'ID_LOJA_ECOMMERCE' AND vl_parametro = 'S' )
					AND v.cd_filial in ( select cd_filial from vw_filial f where f.id_rede in ( :This.is_Rede_Ecommerce, :ls_In ) )	
					USING SqlCa;
				
				OPEN lcu_cursor;
				
				FETCH lcu_cursor
					INTO	:lvl_Cd_Filial,
							:lvl_Produto,
							:lvl_Qt_Produto;
							
				If SQLCA.sqlcode <> 0 Then
					This.of_Grava_Arquivo( "[OK] N$$HEX1$$e300$$ENDHEX$$o existem produtos com saldo maior que zero. Sqlcode: " + string( SQLCA.sqlcode ), False )
					Return False
				End If
					
				DO WHILE SQLCA.sqlcode = 0	
						lvl_Nova_linha = ads_saldo.InsertRow(0)
						
						ads_saldo.Object.cd_produto		[lvl_Nova_Linha] = lvl_Produto
						ads_saldo.Object.qt_saldo_final	[lvl_Nova_Linha] = lvl_Qt_Produto
						ads_saldo.Object.cd_filial			[lvl_Nova_Linha] = lvl_Cd_Filial
						
					FETCH lcu_cursor
						INTO	:lvl_Cd_Filial,
								:lvl_Produto,
								:lvl_Qt_Produto;
				LOOP
				
			END IF //REDE MANIP
	ELSE
			
		DECLARE lcu_cursor_prd CURSOR FOR	
			SELECT	v.cd_filial,
						v.cd_produto,
						v.qt_saldo_final - dbo.uf_saldo_produto_pendente( v.cd_filial, v.cd_produto )
			FROM vw_saldo_atual_produto v
			WHERE v.qt_saldo_final >= 0
			AND v.cd_produto	= :al_Produto
			AND v.cd_filial in (  select cd_filial from parametro_loja where cd_parametro = 'ID_LOJA_ECOMMERCE' AND vl_parametro = 'S' )
			AND v.cd_filial in ( select cd_filial from vw_filial f where f.id_rede in ( :This.is_Rede_Ecommerce, :ls_In ) )																	  														  
			USING SqlCa;
		
		OPEN lcu_cursor_prd;
		
		FETCH lcu_cursor_prd
			INTO	:lvl_Cd_Filial,
					:lvl_Produto,
					:lvl_Qt_Produto;
					
		If SQLCA.sqlcode <> 0 Then
			This.of_Grava_Arquivo( "[OK] N$$HEX1$$e300$$ENDHEX$$o existem produtos com saldo maior que zero. Sqlcode: " + string( SQLCA.sqlcode ), False )
			Return True
		End If
			
		DO WHILE SQLCA.sqlcode = 0	
				lvl_Nova_linha = ads_saldo.InsertRow(0)
				
				ads_saldo.Object.cd_produto		[lvl_Nova_Linha] = lvl_Produto
				ads_saldo.Object.qt_saldo_final	[lvl_Nova_Linha] = lvl_Qt_Produto
				ads_saldo.Object.cd_filial			[lvl_Nova_Linha] = lvl_Cd_Filial
				
			FETCH lcu_cursor_prd
				INTO	:lvl_Cd_Filial,
						:lvl_Produto,
						:lvl_Qt_Produto;
		LOOP	
		
	END IF
	
	Return True
	
Catch( RuntimeError ru )
	This.of_Grava_Arquivo( "[ERRO] GE121 - uo_ecommerce_vannon.of_carrega_saldo( ref datastore )<br />" + ru.getMessage( ), True )
	Return False
	
Finally
	CLOSE lcu_cursor;
	CLOSE lcu_cursor_prd;
	CLOSE lcu_cursor_mp;
End Try

end function

public subroutine of_verifica_filial_site_atualizacao (string as_rede_ecommerce);This.is_Rede_Ecommerce = as_rede_ecommerce

Choose Case This.is_Rede_Ecommerce
	Case 'DC';	This.il_Filial_Site_Em_Atualizacao 	= FILIAL_SITE_DC
	Case 'FA'; 	This.il_Filial_Site_Em_Atualizacao 	= FILIAL_SITE_FA
	Case 'MP';	This.il_Filial_Site_Em_Atualizacao 	= FILIAL_SITE_MP
End Choose
end subroutine

public function date of_data_inicio_9_digito ();String ls_valor

select vl_parametro
	into :ls_valor
	from parametro_geral
	where cd_parametro = 'DH_INICIO_9_DIGITOS_VANNON'
using sqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro na localizacao do parametro_geral DH_INICIO_9_DIGITOS_VANNON")
End If

Return Date(ls_valor)

end function

protected function boolean of_atualiza_status_pedido (long pl_pedido, string ps_status, string ps_cd_rastreamento, date ptd_compra);/* Altera status do pedido no site. 
CAR Carrinho; ACP Auardando confirma$$HEX2$$e700e300$$ENDHEX$$o de pagamento;
CAN Cancelado; ENT Entregue; POS Postado; 
SPP Separado para Postagem; PCO Pagamento Confirmado; 
PNA Pagamento n$$HEX1$$e300$$ENDHEX$$o autorizado; PCB Pagamento Confirmado Boleto; 
PAN Pedido em an$$HEX1$$e100$$ENDHEX$$lise; AGA Aguardando aprova$$HEX2$$e700e300$$ENDHEX$$o; NAA N$$HEX1$$e300$$ENDHEX$$o autorizado Antifraude */

Choose Case ps_Status
	Case 'AGA', 'NAA', 'PCB', 'PCO', 'ACP', 'CAN', 'CAR', 'ENT', 'PAN', 'PNA', 'POS', 'SPP', 'DPR'
		//
	Case Else
		This.of_Grava_Arquivo( "[ERRO] PEDIDO: " + String(pl_Pedido) + " | Status n$$HEX1$$e300$$ENDHEX$$o previsto para atualiza$$HEX2$$e700e300$$ENDHEX$$o na Vannon (" + ps_Status + ") | of_atualiza_status_pedido( )", True )
		Return False
End Choose

Long ll_Nota

String lvs_json_status_pedido, &  
			 lvs_json_rastreamento, &
			 lvs_retorno, &
			 lvs_Pedido_Vannon
String ls_PBM

Long lvl_Integracao

If ivi_Log = 0 Then
	If Not This.of_Abre_Arquivo("ecommerce_status_pedido") Then Return False
End If

If is_Rede_Ecommerce = 'FA' And ptd_compra < This.of_Data_Inicio_9_digito() Then
	lvs_Pedido_Vannon = Mid(String(pl_pedido), 2, 8)
Else
	lvs_Pedido_Vannon = String(pl_pedido)
End If

lvs_json_status_pedido  = '[{"NumeroPedido":  "'+ lvs_Pedido_Vannon + '",'

/*
Select COALESCE( p.de_via_pbm, '' ),
		 n.nr_nf
INTO	:ls_PBM,
		:ll_Nota
FROM pedido_drogaexpress p
		INNER JOIN nf_venda n
			ON n.nr_pedido_ecommerce = p.nr_pedido_ecommerce
WHERE p.nr_pedido_ecommerce = :pl_Pedido
USING Destino;

Choose Case Destino.SqlCode
	Case -1
		This.of_Grava_Arquivo( "[ERRO] Localiza$$HEX2$$e700e300$$ENDHEX$$o da nota fiscal de pedido com PBM na pedido_drogaexpress. nr_pedido_ecommerce: '" + String( ivl_Pedido ) + "'. " + Destino.SqlErrText + " | of_atualiza_status_pedido( )", True )
		
	Case 100
		// N$$HEX1$$e300$$ENDHEX$$o achou
		
	Case 0
		If ls_PBM <> '' Then
			lvs_json_status_pedido  += '"CupomFiscal": "' + String( ll_Nota ) + '",' 
		End If
End Choose
*/
lvs_json_status_pedido  += '"CodigoExternoStatus": "' + ps_status + '" }]' 

If of_abre_comunicacao_api('POST','pedidostatus') Then		
	lvl_Integracao = of_comunicacao_api(lvs_json_status_pedido,'POST','pedidostatus')	
	of_fecha_comunicacao_api()
End If

If Not IsNull(ps_cd_rastreamento) and ps_cd_rastreamento <> '' Then
	lvs_json_rastreamento  = '[{"NumeroPedido":  "'+ lvs_Pedido_Vannon + '",'
	lvs_json_rastreamento  += '"Rastreamento": "' + ps_cd_rastreamento + '" }]' 
	
	If of_abre_comunicacao_api('POST','pedidorastreamento') Then		
		lvl_Integracao = of_comunicacao_api(lvs_json_rastreamento,'POST','pedidorastreamento')	
		of_fecha_comunicacao_api()
	End If
End If

If lvl_Integracao = 1 Then
	This.of_Grava_Arquivo( lvs_json_status_pedido + ' ' + lvs_json_rastreamento, False )
	Return True
Else
	Return False
End If


end function

public function boolean of_atualiza_pedido_pendente (long pl_pedido, string ps_cep);Long	lvl_Linhas, &
		lvl_Linha, &
		lvl_Nr_Pedido, &
		lvl_Filial, &
		lvl_Filial_Anterior, &
		lvl_Sucesso

Long ll_Cliente 		

Integer lvi_Pedidos_Aprovados 		= 0
Integer lvi_Pedidos_Cancelados 	= 0
Integer li_Count 						= 0

String	 lvs_Situacao, &
		 lvs_Retorno_Pedido, &
		 lvs_Autorizacao_Cartao, &
		 lvs_Comprovante_Cartao, &
		 lvs_Bandeira_Cartao,  &
		 lvs_Estabelecimento, &
		 lvs_Filtro_Pedido, &
		 lvs_retorno_pedido_status, &
		 lvs_Pedido_Vannon

String lvs_retorno_cliente, lvs_retorno_pedido_entrega	
String ls_Nome, ls_Sobrenome, ls_Email, ls_CPF_CGC, ls_Sexo, ls_Fone, ls_Fone_Contato, ls_IE, ls_Fisica_Juridica		
String ls_Endereco, ls_Numero, ls_Complemento, ls_Bairro, ls_Cidade, ls_UF, ls_CEP
String ls_Pedidos_Retorno_API
String ls_Sobra_Pedido_Status, ls_Sobra_Cliente, ls_Sobra_Pedido_Entrega
String ls_Status

Decimal ldc_Frete, ldc_Total

Date ldt_DataNascimento	
Date ldt_Atualizacao
 	
If ivb_Ambiente_Teste Then
	Return True
End If	  	 
	 
Try
	dc_uo_ds_base lvds_Status_Pedido
	
	lvds_Status_Pedido = Create dc_uo_ds_base 
	
	If Not of_verifica_conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o liberada no Desenvolvimento.", StopSign!)
		//Return False
	End If
	
	/*
	Quando n$$HEX1$$e300$$ENDHEX$$o houver mais pedidos na tabela pedido_ecommerce_pendente
	-Alterar o sql ds_ge226_lista_pedido_pendente_nova
	-Alterar a fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_pedido_pendente para desconsiderar os dados do cliente e a inclus$$HEX1$$e300$$ENDHEX$$o de um pedido cancelado(realizados anteriormante para a integra$$HEX2$$e700e300$$ENDHEX$$o do SAP)
	*/
	
	If Not lvds_Status_Pedido.of_ChangeDataObject("ds_ge226_lista_pedido_pendente_nova") Then
		Return False
	End If
	
	//Incluido no SQL ds_ge226_lista_pedido_pendente_nova
	//lvds_Status_Pedido.of_AppendWhere("nr_pedido > 399999") //Somente pedidos Vannon
	
	If Not IsNull( pl_Pedido ) Then
		lvds_Status_Pedido.of_AppendWhere("nr_pedido = " + String( pl_Pedido ), 1 ) 
		lvds_Status_Pedido.of_AppendWhere("p.nr_pedido = " + String( pl_Pedido ), 2 ) 
	End If
	
	//Grava no log o in$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o
	If Not This.of_Grava_Arquivo("[OK] In$$HEX1$$ed00$$ENDHEX$$cio da atualiza$$HEX2$$e700e300$$ENDHEX$$o | of_atualiza_pedido_pendente(long)", False) Then
		Return False
	End If
	
	If lvds_Status_Pedido.Retrieve( il_Filial_Site_Em_Atualizacao ) = -1 Then
		This.of_Grava_Arquivo("[ERRO] Recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido.", True)
		Return False
	End If
	
	SetPointer(HourGlass!)
	
	Open(w_aguarde_2)
	
	w_aguarde_2.Title = "Atualizando os pedidos pendentes do eCommerce..."
	
	lvl_Linhas = lvds_Status_Pedido.RowCount()
	w_aguarde_2.uo_Progress.of_SetMax(lvl_Linhas)
	
	This.of_Grava_Arquivo( "[OK] Quantidade pedidos pendentes: " + String( lvl_Linhas ) + " | of_atualiza_pedido_pendente(long)", False )
	
	If lvl_Linhas > 0 Then
		//Controla tamb$$HEX1$$e900$$ENDHEX$$m a quantidade dos pedidos empurrados
		ivb_Pedido_Pendente = True
			
		For lvl_Linha = 1 To lvl_Linhas
			lvl_Nr_Pedido					= lvds_Status_Pedido.Object.nr_pedido							[lvl_Linha]
			lvl_Filial							= lvds_Status_Pedido.Object.cd_filial								[lvl_Linha] //Desenvolvimento 563
			lvs_Estabelecimento			= lvds_Status_Pedido.Object.cd_estabelecimento_cartao	[lvl_Linha]
			lvs_Bandeira_Cartao			= lvds_Status_Pedido.Object.nm_administradora_cartao		[lvl_Linha]
			lvs_Comprovante_Cartao 	= lvds_Status_Pedido.Object.nr_comprovante_cartao			[lvl_Linha]
			lvs_Autorizacao_Cartao		= lvds_Status_Pedido.Object.nr_autorizacao_cartao			[lvl_Linha]	
			ls_Status							= lvds_Status_Pedido.Object.id_status							[lvl_Linha]	
			ldt_Atualizacao					= Date(lvds_Status_Pedido.Object.dh_atualizacao				[lvl_Linha])
			
			If is_Rede_Ecommerce = "FA" And ldt_Atualizacao < This.of_Data_Inicio_9_digito() Then
				lvs_Pedido_Vannon = Mid(String(lvl_Nr_Pedido), 2, 8)
			Else
				lvs_Pedido_Vannon = String(lvl_Nr_Pedido)
			End If
			
			lvs_Filtro_Pedido = "NumeroPedido eq '" +lvs_Pedido_Vannon + "'"
			
			If of_abre_comunicacao_api('GET',"pedido?$filter=" + lvs_Filtro_Pedido) Then
				lvl_Sucesso = of_comunicacao_api('','GET',"pedido?$filter=" + lvs_Filtro_Pedido)
			End If
			
			of_fecha_comunicacao_api()
			
			If lvl_Sucesso = -1 Then 
				Return False // Erro na comunica$$HEX2$$e700e300$$ENDHEX$$o com a Vannon
			End If
			
			ls_Pedidos_Retorno_API = ivs_Retorno_Api
			ivo_gera_json.of_divide_grupo_json_completo(Ref ls_Pedidos_Retorno_API, Ref lvs_retorno_pedido,'{') 
			
			ls_Sobra_Pedido_Status 		= lvs_retorno_pedido
			ls_Sobra_Cliente				= lvs_retorno_pedido
			ls_Sobra_Pedido_Entrega	= lvs_retorno_pedido
			
			ivo_gera_json.of_divide_grupo_json_tag(Ref ls_Sobra_Pedido_Status, 'PedidoStatus', Ref lvs_retorno_pedido_status,'}') 
			ivo_gera_json.of_divide_grupo_json_tag(ref ls_Sobra_Cliente, 'Cliente', Ref lvs_retorno_cliente,'}') 
			ivo_gera_json.of_divide_grupo_json_tag(ref ls_Sobra_Pedido_Entrega, 'PedidoEntrega', Ref lvs_retorno_pedido_entrega,'}') 
			
			ldc_Frete 					= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'Frete'),'.',',',0))
			ldc_Total 					= Dec(gf_replace(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido, 'Total'),'.',',',0))
			
			lvs_Situacao			= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_status, 'CodigoExterno') 
			ivs_Retorno_Api	= ''
	
			If lvs_Situacao = 'PNA' Or lvs_Situacao = 'NAA' Or lvs_Situacao = 'CAN' Then //PNA - Pagamento N$$HEX1$$e300$$ENDHEX$$o Autorizado / CAN - Cancelado / NAA - N$$HEX1$$e300$$ENDHEX$$o autorizado AF
				
				If lvl_Filial <> lvl_Filial_Anterior Then
					 // Conecta na filial do Disque Entrega
					 If Not of_Conecta_Banco_Filial_Destino(lvl_Filial) Then
						Return False
					 End If	
					 
					 lvl_Filial_Anterior = lvl_Filial
				End If
				 
				If This.of_cancela_cartao_comprovante(lvs_Autorizacao_Cartao, lvs_Comprovante_Cartao, lvs_Estabelecimento, lvl_Nr_Pedido) Then
					
					//dados do cliente para gravar um pedido ecommerce cancelado antes de excluir da pendente
					ll_Cliente 				= Long(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'ClienteId'))
					ls_Nome 					= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Nome'))
					ls_Sobrenome			= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Sobrenome'))
		 			ls_Nome					+= ls_Sobrenome
					ls_Email 					= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Email')
					ls_CPF_CGC 			= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'CpfCnpj')
					ls_CPF_CGC 			= RightA('00000000000' + ls_CPF_CGC, 11)
					ls_Sexo 					= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Sexo'))
					ldt_DataNascimento	= Date(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'DataNascimento'))
					ls_Fone 					= '(' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'TelefoneDDD') + ')' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Telefone"') 
					ls_Fone_Contato 		= '(' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'CelularDDD') + ')' + ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'Celular"') 
					
					ls_Endereco 			= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Endereco'))
					ls_Numero 				= String(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Numero'))
					ls_Complemento 		= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Complemento'))
					ls_Bairro 				= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, '"Bairro"'))
					ls_Cidade 				= Upper(ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, '"Cidade"')) // Com aspas pois a palavra Cidade pode fazer parte do endere$$HEX1$$e700$$ENDHEX$$o Ex: Rua Cidade das $$HEX1$$c100$$ENDHEX$$guas
					ls_UF 						= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, '"Estado"') 
					ls_CEP 					= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_pedido_entrega, 'Cep')
					ls_CEP 					= RightA('00000000' + ls_CEP, 8)
					
					If LenA(ls_CPF_CGC) > 11 Then
						ls_IE 	= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'InscricaoEstadual')
						ls_Fisica_Juridica 	= 'J'
					Else
						ls_IE	= ivo_gera_json.of_busca_conteudo_campo(lvs_retorno_cliente, 'RG')
						ls_Fisica_Juridica 	= 'F'
					End If
					
					//Carrega dados de pagamento
					If Not of_Forma_Pagamento(lvs_retorno_pedido) Then
						Continue
					End If
										
					Select count(nr_pedido)
						Into :li_Count 
					From pedido_ecommerce
					Where cd_filial_ecommerce = :il_Filial_Site_Em_Atualizacao
						and nr_pedido 				= :lvl_Nr_Pedido  
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						This.of_Grava_Arquivo( "[ERRO] select do pedido ecommerce. of_Atualiza_pedido_pendente(), Pedido " + String(lvl_Nr_Pedido) , False ) 
					End If
					
					If li_Count > 0 Then
						//Se j$$HEX1$$e100$$ENDHEX$$ existir um pedido na pedido_ecommerce 
						//Apenas Update no campo id_situacao
						//Os demais foram inclu$$HEX1$$ed00$$ENDHEX$$dos na funcao of_grava_pedido() com situacao 'AGA' e 'ACP'
						Update pedido_ecommerce Set id_situacao = 'X'
							Where  cd_filial_ecommerce	= :il_Filial_Site_Em_Atualizacao
								AND nr_pedido 					= :lvl_Nr_Pedido
								AND cd_filial						= :lvl_Filial
						Using SqlCa;
						
					Else	
						INSERT INTO pedido_ecommerce ( cd_filial_ecommerce, nr_pedido, dh_compra, dh_atualizacao, id_situacao, cd_cliente, nm_cliente, de_endereco_email, 
										nr_cpf_cgc, nr_inscricao_estadual, id_fisica_juridica, id_sexo, dh_nascimento, de_endereco, nr_endereco, de_bairro, de_cidade, cd_uf, nr_cep, nr_fone, 
										nr_fone_contato, cd_filial, dh_inclusao, cd_forma_pagamento, vl_frete, vl_total, id_pagamento ) 
							Select p.cd_filial_ecommerce, p.nr_pedido, p.dh_atualizacao, p.dh_atualizacao, 'X', :ll_cliente, :ls_nome, :ls_email, 
										:ls_cpf_cgc, :ls_IE, :ls_Fisica_Juridica, :ls_sexo, :ldt_DataNascimento, :ls_endereco, :ls_numero, :ls_bairro, :ls_cidade, :ls_UF, :ls_CEP, :ls_Fone,
										:ls_Fone_Contato, p.cd_filial, getdate(), :ivs_Forma_Pagto, :ldc_Frete, :ldc_Total, :ivl_Pagamento						
							FROM pedido_ecommerce_pendente p
							WHERE p.nr_pedido 	= :lvl_Nr_Pedido
								AND p.cd_filial		= :lvl_Filial
						Using SQLCa;
						
					End If
					
					If SqlCa.SqlCode = -1 Then
						This.of_Grava_Arquivo( "[ERRO] Inclusao/atualizacao do pedido ecommerce cancelado. of_Atualiza_pedido_pendente(), Pedido " + String(lvl_Nr_Pedido) , False ) 
					End If
				
					If This.of_Exclui_Pedido_Pendente( lvl_Nr_Pedido ) Then
						Destino.of_Commit();
						This.of_Grava_Arquivo( "[OK] Pedido cancelado com sucesso " + String(lvl_Nr_Pedido) , False ) 
					Else
						Return False
					End If
				End If
				lvi_Pedidos_Cancelados++			
			Else
				//Aprovado - Baixar pedido na loja
				If lvs_Situacao = 'PCO' Then
					//O CEP ser$$HEX1$$e100$$ENDHEX$$ tratado na funcao of_Importa_Pedidos
					If of_Importa_Pedidos(lvl_Nr_Pedido, ps_cep, This.is_Rede_Ecommerce ) Then
//						If Not This.of_Exclui_Pedido_Pendente( lvl_Nr_Pedido ) Then Return False
					End If		
					lvi_Pedidos_Aprovados++			
				End If
			End If		
	
			w_aguarde_2.uo_Progress.of_SetProgress(lvl_Linha)
			Yield()
		Next
		
		ivb_Pedido_Pendente = False
	
		SqlCa.of_Commit();
	End If
	
	Return True
	
Catch( RuntimeError ru )
	This.of_Grava_Arquivo( "[ERRO] GE121 - uo_ecommerce_vannon.of_atualiza_pedido_pendente( ref datastore )<br />" + ru.getMessage( ), True )
	Return False

Finally
	This.of_Grava_Arquivo("[OK] Total de pedidos aprovados: " + String(lvi_Pedidos_Aprovados), False)
	This.of_Grava_Arquivo("[OK] Total de pedidos cancelados: " + String(lvi_Pedidos_Cancelados), False)
	
	// Grava o t$$HEX1$$e900$$ENDHEX$$rmino da atualiza$$HEX2$$e700e300$$ENDHEX$$o no arquivo de log
	This.of_Grava_Arquivo("[OK] Termino da atualiza$$HEX2$$e700e300$$ENDHEX$$o | of_atualiza_pedido_pendente(long)", False)
	If IsValid( lvds_Status_Pedido ) Then Destroy lvds_Status_Pedido
	If IsValid( w_aguarde_2 ) Then Close( w_aguarde_2 )
	SetPointer( Arrow! )
End Try
end function

public function integer of_processa_reserva_ped_empurrado (integer pi_filial, long pl_produto, integer ai_qtde_pedido_ecommerce);Integer nr_ordem

Long ll_Total_Pedida, ll_Saldo_Filial
Long ll_Saldo, ll_Saldo_Distribuidora
Long ll_Qt_Empurrada, ll_Saldo_Falta
Long ll_Row, ll_Linhas

String ls_Distribuidora

Decimal ldc_Fator_Conversao

//Produto manip
IF pl_produto = 684431 Then
	Return 1
End If

If Not of_saldo_produto_reservado(pi_filial, pl_produto, Ref ll_Total_Pedida) Then
	Return -1
End If

//N$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o gravados os itens dos pedidos pendentes
//If ivb_Pedido_Pendente Then
//	ll_Total_Pedida = ll_Total_Pedida + ai_qtde_pedido_farmagora
//End If

//ll_Total_Pedida = ll_Total_Pedida + ai_qtde_pedido_ecommerce

//------------PRIMEIRO Verifica saldo filial ---------
SELECT	COALESCE( s.qt_saldo_final, 0 ) AS qt_saldo_final
	INTO	:ll_Saldo_Filial
  FROM vw_saldo_atual_produto s
WHERE s.cd_filial		= :pi_filial
	AND s.cd_produto	= :pl_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	of_Grava_Arquivo( "[ERRO] Consulta saldo_atual do produto " + String( pl_Produto ) + ". " + SqlCa.SqlErrText, True )
	Return -1
End If

of_Grava_Arquivo( "Produto / Saldo Filial / Total Pedida / Qt_Pedido: " + String( pl_produto ) + " / " + String(ll_Saldo_Filial) + " / " + String( ll_Total_Pedida ) + " / " + String(ai_qtde_pedido_ecommerce), False )

//ll_Saldo_Filial negativo = saldo da loja - qtde de pedido em aberto j$$HEX1$$e100$$ENDHEX$$ cadastrado 
IF ll_Saldo_Filial < ll_Total_Pedida Then
	//Saldo falta $$HEX1$$e900$$ENDHEX$$ quantida do pedido em atualizacao
	ll_Saldo_Falta = ai_qtde_pedido_ecommerce
Else
	ll_Saldo_Filial =  ll_Saldo_Filial - ll_Total_Pedida - ai_qtde_pedido_ecommerce
		
	If ll_Saldo_Filial >= 0 Then
		Return 1 //a loja possui saldo disponivel para atender o ped Ecommerce
	End If
	
	ll_Saldo_Falta = ll_Saldo_Filial * -1	
End If

ll_Linhas = ids_Ordem_Distribuidora.Retrieve( pi_filial, pl_produto  )

If ll_Linhas < 0 Then
	of_Grava_Arquivo( "[ERRO] Retrieve ordem distribuidora " + String( pl_Produto ) + ". " + SqlCa.SqlErrText, True )
	Return -1
End If

For ll_Row = 1 TO ll_Linhas
	ls_Distribuidora = ids_Ordem_Distribuidora.Object.cd_distribuidora [ ll_Row ]  
		
	//ll_saldo_Distribuidora considera a quantidade dos pedidos empurrados em aberto
	ll_Saldo = This.of_saldo_disponivel_distribuidora( pi_filial, pl_produto, ls_distribuidora, 'PEDIDO', Ref ldc_Fator_Conversao )
	
	of_Grava_Arquivo( "Produto / Dist./ Saldo Dist. / Tot Falta: " + String( pl_produto ) + " / " + ls_Distribuidora + " / " + String( ll_Saldo ) + " / " + String(ll_Saldo_Falta), False )
	
	If ll_saldo < 0 Then
		Return -1
	End If
	
	If ll_saldo >= ll_Saldo_Falta Then
		ll_saldo = ll_Saldo_Falta	
	End If
	
	//Empurra pedido
	If ll_Saldo > 0 Then
		This.of_grava_pedido_empurrado( pi_filial, pl_produto, ai_qtde_pedido_ecommerce, ls_Distribuidora,  ldc_Fator_Conversao, ll_saldo )
	End If

	ll_Saldo_Falta = ll_Saldo_Falta - ll_Saldo
	
	//Pedido total atendido 
	If ll_Saldo_Falta = 0 Then
		Exit
	End If
	
Next

Return 1
end function

public function boolean of_grava_produto_pedido_drogaexpress (string as_pedido, long al_produto, integer ai_qtde, decimal adc_preco, decimal adc_preco_promo, long al_sequencial, long al_requisicao_manip, string as_descricao, ref string as_mensagem, decimal adc_preco_total);Decimal 	lvdc_Perc_Desconto,&
			lvdc_Preco_Praticado,&
			lvdc_Preco_Liquido
			
String ls_Achou

//adc_preco_total -> ped_pvtotal (pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido j$$HEX1$$e100$$ENDHEX$$ considerando os descontos na base do ecommerce)
//lvdc_Preco_Liquido = Round((adc_preco_total / ai_qtde),2)

// adc_Preco_promocao -> o pre$$HEX1$$e700$$ENDHEX$$o do produto se o mesmo estiver em alguma promocao
lvdc_Preco_Liquido = adc_preco_promo

// adc_preco -> ped_pvreal (pre$$HEX1$$e700$$ENDHEX$$o real sem nehum desconto na base do ecommerce)

// Se o pre$$HEX1$$e700$$ENDHEX$$o liquido for zerado o desconto vai ser de 100% e vai dar erro
If al_produto = 705812 then
	al_produto = al_produto
end if

If lvdc_Preco_Liquido > 0.00 Then
	lvdc_Perc_Desconto = Round((((adc_Preco - lvdc_Preco_Liquido) / adc_Preco) * 100), 4)
Else
	lvdc_Perc_Desconto = 0.00
End If

lvdc_Preco_Praticado = Round( (adc_Preco * ((100 - lvdc_Perc_Desconto) / 100) ),2)

If lvdc_Preco_Praticado <> lvdc_Preco_Liquido Then
	This.of_Grava_Arquivo( "[ERRO] Pre$$HEX1$$e700$$ENDHEX$$o calculado '" + String(lvdc_Preco_Praticado) + "' diferente do pre$$HEX1$$e700$$ENDHEX$$o vendido '" + String(lvdc_Preco_Liquido) + "' no pedido DrogExpress '" + as_Pedido + "'.", True )
	Return False
End If

ivdc_Produtos_Calculado = ivdc_Produtos_Calculado + Round((lvdc_Preco_Praticado * ai_Qtde), 2)

// A valida$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ nesta parte do c$$HEX1$$f300$$ENDHEX$$digo para que o c$$HEX1$$e100$$ENDHEX$$lculo dos pre$$HEX1$$e700$$ENDHEX$$os seja realizado pelo trecho acima
IF Not IsNull( al_requisicao_manip ) Then
	SELECT nr_pedido_drogaexpress
	INTO :ls_Achou
	FROM produto_pedido_drogaexpress
	WHERE nr_pedido_drogaexpress	= :as_Pedido
	AND cd_produto						= :al_Produto
	AND nr_requisicao_manip			= :al_requisicao_manip
	USING Destino;
ELSE
	SELECT nr_pedido_drogaexpress
	INTO :ls_Achou
	FROM produto_pedido_drogaexpress
	WHERE nr_pedido_drogaexpress	= :as_Pedido
	AND cd_produto						= :al_Produto
	AND cd_produto 						<> 684431
	USING Destino;
END IF

Choose Case Destino.SqlCode
	Case -1
		This.of_Grava_Arquivo( "[ERRO] Localiza$$HEX2$$e700e300$$ENDHEX$$o da produto_pedido_drogaexpress ( nr_pedido, cd_produto ) = ( " + String( as_Pedido ) + ", " + String( al_Produto ) + " ) ." + Destino.SqlErrText, True )
		Return False
		
	Case 0
		This.of_Grava_Arquivo( "[ALERTA] Produto j$$HEX1$$e100$$ENDHEX$$ existe na produto_pedido_drogaexpress ( nr_pedido, cd_produto ) = ( " + as_Pedido + ", " + String( al_Produto ) + " ). Inclus$$HEX1$$e300$$ENDHEX$$o ignorada, processo continua.", False )
		Return True
End Choose
/***************/

If al_Produto <> ivo_produto.cd_produto_manipulado Or Not IsNull( al_requisicao_manip )  Then
	SetNull( as_descricao )
End If

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
VALUES (:as_Pedido,					//nr_pedido_drogaexpress,   
		:al_Produto,						//cd_produto,   
		:al_sequencial, 					//nr_sequencial
		:ai_Qtde,							//qt_pedida,   
		:adc_preco,						//vl_preco_tabela,   
		:lvdc_Perc_Desconto,			//pc_desconto_tabela,   
		:lvdc_Preco_Praticado,		//vl_preco_praticado,   
		'N',								//id_alteracao_preco,   
		'N',								//id_restricao_convenio,   
		:lvdc_Preco_Praticado,		//vl_preco_tabela_liquido,   
		null,								//qt_pontos_clube                        ?????????
		:al_requisicao_manip,	//nr_requisicao_manip
		:as_descricao)				//de_produto usado para produto manipulado acabado - sem requisicao
Using Destino;
		
If Destino.SqlCode = -1 Then
	as_Mensagem += "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto '" + String(al_Produto) + "' no pedido DrogExpress '" + as_Pedido + "'. " + Destino.SqlErrText
	Return False
End If
	
Return True
end function

protected function boolean of_grava_produto_pedido (long al_pedido, string as_produto_ecommerce, integer ai_qtde, string as_produto, long al_produto, long al_categoria, string as_fornecedor, string as_cor, string as_tamanho, string as_estilo, string as_aro, decimal adc_peso, decimal adc_cubagem, decimal adc_preco, decimal adc_preco_promo, date adt_inicio_promo, date adt_termino_promo, string as_pedido_drogaexpress, decimal adc_preco_total, long al_sequencial, long al_requisicao_manip, string as_descricao);Long ll_Achou

String lvs_Mensagem

Try
	SELECT nr_pedido
	INTO :ll_Achou
	FROM pedido_ecommerce_produto
	WHERE cd_filial_ecommerce	= :il_Filial_Site_Em_Atualizacao
	AND nr_pedido						= :al_Pedido
	AND cd_produto_ecommerce	= :as_Produto_Ecommerce
	AND qt_pedida						= :ai_qtde
	AND cd_produto					= :al_Produto
	AND cd_produto					<> 684431
	USING SQLCA;
	
	Choose Case SqlCa.SqlCode
		Case -1
			This.of_Grava_Arquivo( "[ERRO] Localiza$$HEX2$$e700e300$$ENDHEX$$o da pedido_ecommerce_produto ( nr_pedido, cd_produto ) = ( " + String( al_Pedido ) + ", " + String( al_Produto ) + " ) ." + SqlCa.SqlErrText, True )
			Return False
			
		Case 0
			This.of_Grava_Arquivo( "[ALERTA] Produto j$$HEX1$$e100$$ENDHEX$$ existe na pedido_ecommerce_produto ( nr_pedido, cd_produto ) = ( " + String( al_Pedido ) + ", " + String( al_Produto ) + " ). Inclus$$HEX1$$e300$$ENDHEX$$o ignorada, processo continua.", False )
	
			Return of_Grava_Produto_Pedido_DrogaExpress( as_Pedido_DrogaExpress, al_Produto, ai_qtde, adc_Preco, adc_Preco_Promo, al_Sequencial,  al_requisicao_manip, as_descricao, Ref lvs_Mensagem, adc_preco_total )
			
		Case 100
			
			 //DESENVOLVIMENTO
//			#IF DEFINED DEBUG THEN
//				If al_Pedido = 137992478 Then
//					ai_qtde = 2
//				End If
//			#END IF
			
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
			VALUES( :il_Filial_Site_Em_Atualizacao,
						:al_Pedido,   
						:as_Produto_Ecommerce,   
						:al_sequencial,
						:ai_qtde,
						:as_Produto,   
						:al_Produto,   
						:as_Fornecedor,   
						:adc_Preco,   
						:adc_Preco_Promo,   
						null,   
						null,
						:al_requisicao_manip )
			Using SqlCa;
					
			If SqlCa.SqlCode = -1 Then
				This.of_Grava_Arquivo( "[ERRO] Inclus$$HEX1$$e300$$ENDHEX$$o da pedido_ecommerce_produto ( nr_pedido, cd_produto ) = ( " + String( al_Pedido ) + ", " + String( al_Produto ) + " ) ." + SqlCa.SqlErrText, True )
				Return False
			End If
			
			If Not of_Grava_Produto_Pedido_DrogaExpress(as_Pedido_DrogaExpress, al_Produto, ai_qtde, adc_Preco, adc_Preco_Promo,  al_Sequencial,  al_requisicao_manip, as_descricao, Ref lvs_Mensagem, adc_preco_total ) Then
				Return False
			End If
			
			If This.of_processa_reserva_ped_empurrado( This.ivl_filial_disque, al_Produto, ai_qtde ) < 0 Then
				Return False	
			End If
			
			Return True
			
	End Choose
	
Finally
	//
End Try
end function

protected function boolean of_envia_produtos (long pl_cd_produto, string ps_de_descricao_internet, string ps_de_principal_internet, boolean pb_situacao, decimal pdc_peso, decimal pdc_altura, decimal pdc_largura, decimal pdc_comprimento, string ps_acao, ref string ps_codigo_barras, string ps_id_lei_generico, string ps_cd_grupo_produto, string ps_de_registro_ms, string ps_subgrupo_produto, string ps_cod_produto_sap);
String lvs_de_palavra_chave, &
		 lvs_tipo_produto, &
		 lvs_json_produto, &
		 lvs_json_produto_sku, &
		 lvs_familia
		 
Boolean lvb_Integracao = True

Long lvl_Linha, &
 	   lvl_Qtd_Palavras
		 

Try

	dc_uo_ds_base lvds_Palavras_Chave
	lvds_Palavras_Chave = Create dc_uo_ds_base
	
	//----------- Sele$$HEX2$$e700e300$$ENDHEX$$o das palvaras chave do produto 
	If lvds_Palavras_Chave.of_ChangeDataObject("ds_ge226_palavras_chave_produto") Then
		lvds_Palavras_Chave.of_AppendWhere("cd_produto = " + String(pl_cd_produto))
		If lvds_Palavras_Chave.Retrieve(pl_cd_produto) <> -1 Then	
			lvl_Qtd_Palavras = lvds_Palavras_Chave.RowCount()	
		Else
			of_Grava_Arquivo('Erro no Retrieve da ds_ge226_palavras_chave_produto para o produto '+String(pl_cd_produto), False)
			Return False
		End If
	Else
		of_Grava_Arquivo('Erro no ChangeDataObject da ds_ge226_palavras_chave_produto para o produto '+String(pl_cd_produto), False)
		Return False
	End If
	
	lvs_de_palavra_chave = ''
	For lvl_Linha = 1 To lvl_Qtd_Palavras			
		lvs_de_palavra_chave += lvds_Palavras_Chave.Object.de_palavra_chave[lvl_Linha]						
	Next			
	
	If IsNull(ps_codigo_barras) Then
			ps_codigo_barras = ''		
	Else
			ps_codigo_barras = RightA('0000000000000' + ps_codigo_barras, 13)
	End If		
	
	If IsNull(ps_de_registro_ms) Then
			ps_de_registro_ms = ''
	End If		
	
	If ps_Cd_Grupo_Produto = '1' Then 
		lvs_tipo_produto = '1' //Medicamento 
		If ps_id_lei_generico = 'G' Then
				lvs_tipo_produto = '3' //Gen$$HEX1$$e900$$ENDHEX$$rico
		End If
		If ps_id_lei_generico = 'S' Then
				lvs_tipo_produto = '4' //Similar
		End If
		
		If ps_SubGrupo_Produto = '104' Then //Medicamentos RX = Tarjado
			lvs_familia = '7'	 //N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$
		Else
			If ps_id_lei_generico = 'G' Then
				lvs_familia = '3' //Gen$$HEX1$$e900$$ENDHEX$$rico Tarjado
			Else
				lvs_familia = '2' //Tarjado
			End If
		End if
	Else
		lvs_tipo_produto = '2' //Outro
		lvs_familia = '7' //N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$
	End If
	
	lvs_json_produto  = '{"CodigoMarca":  "'+ String(ivl_marca) + '",'
	lvs_json_produto  += '"CodigoProdutoTipo": ' + lvs_tipo_produto + ',' 
	lvs_json_produto  +=	'"CodigoProdutoControle": 3, '  /*1 Controlado 2 Controle Especial 3 N$$HEX1$$e300$$ENDHEX$$o H$$HEX1$$e100$$ENDHEX$$*/
	lvs_json_produto  +=	'"CodigoProdutoFamilia": ' + lvs_familia + ', '  
	lvs_json_produto  +=	'"Ativo": '+String(pb_Situacao)+', '  
	lvs_json_produto  += '"PreVenda": false,' 
	lvs_json_produto  += '"Lancamento": false,' 
	lvs_json_produto  += '"CodigoExterno":  "'+ String(pl_cd_produto) + '",'  
	//lvs_json_produto  += '"DataPreVenda": "", ' 
	//lvs_json_produto  += '"DataLancamentoInicial": "", '
	//lvs_json_produto  += '"DataLancamentoFinal": "", '
	lvs_json_produto  += '"NomeProduto": "'+ ivo_gera_xml.of_substitui_caracteres(ps_de_descricao_internet)+'",'
	lvs_json_produto  += '"PalavraChave": "'+lvs_de_palavra_chave+'",'
	lvs_json_produto  += '"IdProdutoSap": "'+ ps_Cod_Produto_Sap+'",'
	lvs_json_produto  += '"DescricaoCurta": "'+ivo_gera_xml.of_substitui_caracteres(ps_de_descricao_internet)+'"} ,'
	//lvs_json_produto  += '"ArquivoBula": "", '
	//lvs_json_produto  += '"CurvaAbc": "", '
	//lvs_json_produto  += '"UrlVideo": ""} '
	
	pdc_altura 			= int(pdc_altura)
	pdc_largura 		= int(pdc_largura)
	pdc_comprimento 	= int(pdc_comprimento)
	
	lvs_json_produto_sku = '{"CodigoProduto": "'+ String(pl_cd_produto) + '",'
	lvs_json_produto_sku += '"Brinde": false,'
	lvs_json_produto_sku += '"CodigoExterno": "'+ String(pl_cd_produto) + '", '
	lvs_json_produto_sku += '"CodigoBarras": "'+ps_codigo_barras+'", '
	lvs_json_produto_sku += '"Peso": ' + gf_replace(String(pdc_peso), ',' , '.' ,0) +','
	lvs_json_produto_sku += '"Altura": '+gf_replace(String(pdc_altura), ',' , '.' ,0)+ ','
	lvs_json_produto_sku += '"Largura": '+gf_replace(String(pdc_largura), ',' , '.' ,0)+','
	lvs_json_produto_sku += '"Profundidade": '+gf_replace(String(pdc_comprimento), ',' , '.' ,0)+','
	lvs_json_produto_sku += '"Nome": "'+ ivo_gera_xml.of_substitui_caracteres(ps_de_descricao_internet)+'",'
	lvs_json_produto_sku += '"IdProdutoSap": "'+ ps_Cod_Produto_Sap+'",'
	lvs_json_produto_sku += '"CodigoMS": "' + ps_de_registro_ms + '" } ,'
	
	of_Grava_Arquivo("Incluido: " + String(pl_cd_produto), False)
	
	//Agrupa v$$HEX1$$e100$$ENDHEX$$rios produtos
	If(ps_acao = 'insert') Then
		ivs_xml_produto_insert +=  lvs_json_produto
		ivs_xml_produto_sku_insert +=  lvs_json_produto_sku
	Else
			ivs_xml_produto_update += lvs_json_produto
			ivs_xml_produto_sku_update +=  lvs_json_produto_sku
	End If
	
	Return lvb_Integracao
	
Finally
	If IsValid( lvds_Palavras_Chave ) Then Destroy lvds_Palavras_Chave	
End Try

end function

on uo_ecommerce_vannon.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ecommerce_vannon.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_Produto 	   	= Create uo_Produto

ivo_Cliente 	   	= Create uo_Cliente

Destino 			= Create dc_uo_transacao

Destino.of_SetDataBase('postgresql')

ivo_Odbc = Create dc_uo_odbc

ivo_gera_xml  = Create uo_ge073_gera_xml 
ivo_gera_json = Create uo_ge073_json 

ivl_Filial_Ecommerce					= Long(This.of_Filial_Ecommerce('CD_FILIAL_ECOMMERCE'))
ivl_Filial_Ecommerce_SP				= Long(This.of_Filial_Ecommerce('CD_FILIAL_ECOMMERCE_SP'))
ivl_filial_ecommerce_Preco			= Long(This.of_Filial_Ecommerce('CD_FILIAL_ECOMMERCE_PRECO'))
ivl_Filial_Ecommerce_Preco_MP 	= Long(This.of_Filial_Ecommerce('CD_FILIAL_ECOMMERCE_PRECO_MP'))
ivs_filiais_ecommerce_Estoque	= This.of_Filial_Ecommerce('CD_FILIAIS_ECOMMERCE_ESTOQUE')

ivi_Log = 0

//Odem distribuuidora_pedido_empurrado
ids_Ordem_Distribuidora = Create dc_uo_ds_base
If Not ids_Ordem_Distribuidora.of_ChangeDataObject("ds_ge226_ordem_distribuidora_produto") Then
	//MsgErro
End If

ivb_Ambiente_Teste = ( SqlCa.Database <> 'central' )
end event

event destructor;If IsValid( ivo_Produto ) 					Then Destroy( ivo_Produto )
If IsValid( ivo_Cliente ) 					Then Destroy( ivo_Cliente )
If IsValid( Destino ) 						Then Destroy( Destino )
If IsValid( ivo_Odbc ) 						Then Destroy( ivo_Odbc )
If IsValid( ivo_gera_xml ) 				Then Destroy( ivo_gera_xml )
If IsValid( ids_Ordem_Distribuidora )  Then Destroy( ids_Ordem_Distribuidora )
end event

