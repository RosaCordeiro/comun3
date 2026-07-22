HA$PBExportHeader$uo_ge473_pedido_central.sru
forward
global type uo_ge473_pedido_central from nonvisualobject
end type
end forward

global type uo_ge473_pedido_central from nonvisualobject
end type
global uo_ge473_pedido_central uo_ge473_pedido_central

type variables
String is_de_chave_acesso_sap
String is_de_chave_acesso
String  idt_hora

Boolean ib_Pedido_Novo = False

////status sempre vem como "C" - COLOCADO
/// Apenas vem o item cancelado.. se o pedido tem 3 itens .. e todos est$$HEX1$$e300$$ENDHEX$$o com X ent$$HEX1$$e300$$ENDHEX$$o cancela o pedido....


//***cabecalho da PEDIDO CENTRAL*****
Long il_nr_pedido_central
Long il_nr_pedido_central_proximo
Long il_pedido_distribuidora
Long il_qt_dias_suprimento 
Long il_cd_filial_legado 
Long il_cd_condicao_pagamento

Date idt_dh_cancelamento
Date idt_dh_emissao
Date idt_dh_pedido
Date idt_dh_previsao_entrega

String is_nr_pedido_sap
String is_cd_filial_sap
String is_cd_fornecedor_sap
String is_cd_fornecedor_legado
String is_de_mensagem_logistica_text
String is_de_observacao 
String is_de_transportadora 
String is_id_acordo_titulo
String is_id_programado
String is_id_situacao_pedido 
String is_id_modalidade_frete
String is_id_tipo_pedido
String is_nr_matricula_cadastramento
String is_nr_matricula_cancelamento
String is_id_excluir_produto

String is_id_farmacia_governo
String is_id_licitacao
String is_id_pbm

String is_cd_grupo_comprador_sap


//Decimal ide_qt_volumes
Decimal ide_vl_bc_icms
Decimal ide_pc_desconto 
Decimal ide_vl_total_pedido 


//***PEDIDO CENTRAL PRODUTO **************
Long il_cd_produto
Long  il_nr_item_pedido
Long il_nr_item
Long il_nr_sequencial
Long il_nr_embalagem_padrao
Long il_qt_recebida  = 0
Long il_qt_pedida

String is_status_item
String is_nr_item_sap
Decimal  ide_pc_desconto_financeiro
Decimal   ide_qt_pedida
Decimal  ide_pc_midia
Decimal{2}  ide_pc_repasse_icms
Decimal  ide_qt_estoque_momento
Decimal  ide_vl_preco_unitario
Decimal 	ide_pc_desconto_item
Long il_Qtd_Produtos
Long il_Qtd_Produtos_Cancelados
Long il_Qtd_Produtos_Atendidos
//*********************

// ****  MSG Logitica Prodto  ***********
String is_cd_centro_sap
String is_matricula_avisar
String is_cd_comprador
String is_cd_filial_sap_item_msg
String is_cd_produto_sap
String is_descricao_mensagem
String is_cancelado_msg_sap
Long il_cd_centro_legado
Long il_cd_filial_sap_item_msg
Long il_cd_mensagem
Long  il_qt_faturar
Long  il_prox_msg_logistica
Datetime idt_limite_validade
Decimal  ide_qt_faturar
Datetime idt_dh_exclusao

String is_id_retira_qtde_pendente_meta
String is_status


Long il_Tabela_Cabeca = 92
Long il_Tabela_Item     = 93
Long il_Tabela_Item_Msg = 94

Long il_nr_requisicao

boolean ib_execucao_simultanea=false
	
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_localiza_pedido_central (string ps_pedido_sap, ref string as_log)
public function boolean of_localiza_condicao_pgto (string ps_cond_pgto, ref long pl_cond_pgto, ref string as_log)
public function boolean of_localiza_proximo_sequencial_msg (ref long ps_prox_sequencial_msg, ref string as_log)
public function boolean of_atualiza_pedido_central (ref string as_log)
public function boolean of_processa_pedido_central (long al_controle, long al_tabela)
public function boolean of_atualiza_pedido_central_produto_msg (ref string as_log, long al_controle_pai)
public function boolean of_atualiza_pedido_central_produto (ref string as_log, long al_controle_pai)
public function boolean of_verifica_qtd_itens_cancelados (string ps_pedido_sap, ref string as_log)
public function boolean of_proximo_codigo_pedido_central (ref long al_pedido)
public function boolean of_verifica_qtd_itens_atendidos (string ps_pedido_sap, ref string as_log)
public function boolean of_atualiza_situacao_pedido_central (ref string as_log)
public function boolean of_valida_usuario (ref string as_log)
public function boolean of_valida_meta (ref string as_log)
public function boolean of_atualiza_pedido_distribuidora_prod (long al_pedido_central, long al_cd_filial, long al_produto, long al_qt_faturada, ref string as_erro)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
			 
	//***Cabe$$HEX1$$e700$$ENDHEX$$alho pedido_central *************
	SetNull(il_nr_pedido_central)
	SetNull(il_nr_pedido_central_proximo)
	SetNull(il_qt_dias_suprimento) 
	SetNull(ide_vl_bc_icms)
	SetNull(idt_dh_cancelamento)
	SetNull(idt_dh_emissao)
	SetNull(idt_dh_pedido)
	SetNull(idt_dh_previsao_entrega)
	SetNull(il_cd_condicao_pagamento)
	SetNull(il_pedido_distribuidora)
	SetNull(is_cd_filial_sap )
	SetNull(is_cd_fornecedor_sap)
	SetNull(is_de_mensagem_logistica_text)
	SetNull(is_de_observacao )
	SetNull(is_de_transportadora )
	SetNull(is_id_acordo_titulo)
	SetNull(is_id_programado)
	SetNull(is_id_situacao_pedido)
	SetNull(is_id_modalidade_frete)
	SetNull(is_id_tipo_pedido)
	SetNull(is_nr_matricula_cadastramento)
	SetNull(is_nr_matricula_cancelamento)
	SetNull(is_nr_pedido_sap)
	SetNull(ide_pc_desconto) 
	SetNull(ide_vl_total_pedido) 
	SetNull(idt_hora)	
	SetNull(is_id_farmacia_governo)
	SetNull(is_id_licitacao)
	SetNull(is_id_pbm)
	SetNull(is_cd_grupo_comprador_sap)
	
	//***itens da  pedido_central_produto **************
	SetNull(il_cd_produto)
	SetNull(ide_qt_pedida)
	SetNull(il_nr_embalagem_padrao)
	SetNull(is_nr_item_sap)
	SetNull(il_nr_item_pedido)
	SetNull(ide_pc_desconto_financeiro)
	SetNull(ide_pc_midia)
	SetNull(ide_pc_repasse_icms)
	SetNull(ide_qt_estoque_momento)
	SetNull(ide_vl_preco_unitario)
	SetNull(il_nr_item)
	SetNull(il_nr_sequencial)
	SetNull(il_qt_pedida)	
	SetNull(il_Qtd_Produtos)
	SetNull(il_Qtd_Produtos_Cancelados)
	SetNull(is_id_retira_qtde_pendente_meta)
	SetNull(is_status)

	
	//*****Mensagem Logistica Produto *******
	SetNull(is_cd_centro_sap)
	SetNull(il_cd_centro_legado)
	SetNull(is_cd_comprador)
	SetNull(is_cd_filial_sap)
	SetNull(il_cd_mensagem)
	SetNull(is_cd_produto_sap)
	SetNull(is_descricao_mensagem)
	SetNull(idt_limite_validade)
	SetNull(il_qt_faturar)	
	SetNull(ide_qt_faturar)	
	SetNull(is_cd_filial_sap_item_msg)
	SetNull(il_cd_filial_sap_item_msg)
	SetNull(is_matricula_avisar)	
	SetNull(il_prox_msg_logistica)
	SetNull(is_cancelado_msg_sap)
	SetNull(idt_dh_exclusao)
	SetNull(is_nr_matricula_cancelamento)
	
	//**********************
	il_Tabela_Cabeca = 92
	ib_execucao_simultanea = false

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as variaveis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface NF Compra - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_pedido_central.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela_Cabeca)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			if not ib_execucao_simultanea Then			
				uo_ge473_pedido_central   lo_pedido_central
				 
				Try
					lo_pedido_central	= Create uo_ge473_pedido_central
					lo_pedido_central.of_processa_pedido_central( lds.Object.nr_controle[ll_Linha],this.il_Tabela_Cabeca )
	
				Finally
					Destroy(lo_pedido_central)
				End Try
			end if
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface NF Compra - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_wms_nf_compra.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_localiza_pedido_central (string ps_pedido_sap, ref string as_log);If Trim(ps_pedido_sap) = "" or IsNull(ps_pedido_sap) Then
	as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o n$$HEX1$$fa00$$ENDHEX$$mero do pedido [nr_pedido_central]."
	Return False
End If

Select nr_pedido
Into	:il_nr_pedido_central
From pedido_central
Where nr_pedido_sap = :ps_pedido_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
		as_Log	= "Erro ao localizar o pedido SAP: " + SqlCa.SqlErrText
		Return False
End Choose

if not of_proximo_codigo_pedido_central(il_nr_pedido_central_proximo) then
	as_Log	= "Erro ao definir pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo do pedido."
	Return False
end if

Return True
end function

public function boolean of_localiza_condicao_pgto (string ps_cond_pgto, ref long pl_cond_pgto, ref string as_log);If Trim(ps_cond_pgto) = "" or IsNull(ps_cond_pgto) Then
	as_Log = "A condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento n$$HEX1$$e300$$ENDHEX$$o foi informada no pedido de compra do SAP. Favor verificar."
	Return False
End If

Select top 1 cd_chave_legado  
  Into :pl_cond_pgto
  From integracao_sap
 Where cd_tabela 		= 'CONDICAO_PAGAMENTO'
	And cd_chave_sap 	= :ps_cond_pgto
 Order by dh_inclusao desc 
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_Log	= "Pedido de Compras vindo do SAP tem uma condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento n$$HEX1$$e300$$ENDHEX$$o relacionada no legado. Favor cadastrar/relacionar a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento: " + ps_cond_pgto
		Return False
	Case -1
		as_Log	= "Erro ao localizar a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento Legado (" + ps_cond_pgto + "). Contate a TI. Erro: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_localiza_proximo_sequencial_msg (ref long ps_prox_sequencial_msg, ref string as_log);Select max(nr_sequencial) + 1 
Into :ps_prox_sequencial_msg
From pedido_central_prd_msg_logist
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
		as_Log	= "Erro ao localizar o proximo sequecial msg Logistica: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_atualiza_pedido_central (ref string as_log);if IsNull(ide_pc_desconto) then ide_pc_desconto = 0

// Localiza se Existe o Pedido
If il_nr_pedido_central > 0 Then 
	// Faz Altera$$HEX2$$e700e300$$ENDHEX$$o se Existe
	Update pedido_central
		Set cd_filial								= :il_cd_filial_legado,
			 cd_fornecedor						= :is_cd_fornecedor_legado,
			 dh_cancelamento					= :idt_dh_cancelamento,
			 dh_emissao						= :idt_dh_emissao,
			 dh_pedido							= :idt_dh_pedido,
			 dh_previsao_entrega				= :idt_dh_previsao_entrega,					
			 cd_condicao_pagamento		= :il_cd_condicao_pagamento,
			 qt_dias_suprimento				= :il_qt_dias_suprimento,
			 pc_desconto						= :ide_pc_desconto,
			 vl_total_pedido					= :ide_vl_total_pedido,
			 id_situacao							= :is_id_situacao_pedido,
			 id_programado					= :is_id_programado,
			 nr_matricula_cadastramento	= :is_nr_matricula_cadastramento,
			 de_mensagem_logistica_text	= :is_de_mensagem_logistica_text,
			 de_observacao					= :is_de_observacao,
			 de_transportadora				= :is_de_transportadora,
			 id_acordo_titulo					= :is_id_acordo_titulo,
			 id_tipo_frete						= :is_id_modalidade_frete,
			 nr_matricula_cancelamento	= :is_nr_matricula_cancelamento,
			 id_farmacia_governo				= :is_id_farmacia_governo,
			 id_licitacao							= :is_id_licitacao,
			 id_pbm								= :is_id_pbm,
			 id_ipi									= 'N',
			 nr_pedido_distribuidora			= :il_pedido_distribuidora
	 Where nr_pedido_sap = :is_nr_pedido_sap
	Using SqlCA;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao alterar registro na tabela 'pedido_central'. Pedido [" + is_nr_pedido_sap+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	End If		
Else
	ib_Pedido_Novo = True

	// Insere um novo pedido
	Insert into pedido_central(nr_pedido,						
										cd_filial,
										cd_fornecedor,
										dh_cancelamento,
										dh_emissao,
										dh_pedido,
										dh_previsao_entrega,						
										cd_condicao_pagamento,
										qt_dias_suprimento,
										pc_desconto,
										vl_total_pedido,									
										id_programado,
										nr_matricula_cadastramento,
										de_mensagem_logistica_text,
										de_observacao ,
										de_transportadora	,					
										id_acordo_titulo,
										id_tipo_frete,
										nr_pedido_sap,
										nr_matricula_cancelamento, 
										id_situacao, 
										id_rede,
										id_licitacao, 										
										id_farmacia_governo,
										id_pbm,
										id_ipi,
										nr_pedido_distribuidora)
							 values (:il_nr_pedido_central_proximo,					
										:il_cd_filial_legado,
									   :is_cd_fornecedor_legado,
										:idt_dh_cancelamento,
										:idt_dh_emissao,
										:idt_dh_pedido,
										:idt_dh_previsao_entrega,
										:il_cd_condicao_pagamento,
										:il_qt_dias_suprimento,
										:ide_pc_desconto,
										:ide_vl_total_pedido,						
										:is_id_programado,
										:is_nr_matricula_cadastramento,
										:is_de_mensagem_logistica_text,
										:is_de_observacao,
										:is_de_transportadora,
										:is_id_acordo_titulo,
										:is_id_modalidade_frete,
										:is_nr_pedido_sap,
										:is_nr_matricula_cancelamento,
										:is_id_situacao_pedido,
										'CIA',
										:is_id_licitacao,			
										:is_id_farmacia_governo,
										:is_id_pbm,
										'N',
										:il_pedido_distribuidora)
	Using SqlCA;			

	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao inserir registro na tabela 'pedido_central'. Pedido [" + is_nr_pedido_sap+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	End If
	
End If 

Return True
end function

public function boolean of_processa_pedido_central (long al_controle, long al_tabela);Boolean 	lb_Sucesso = False
Long 		ll_Atualizacao_Pend, ll_Linhas, ll_exists
String 	ls_Log, ls_Chave_Controle, lvs_dt_pedido, lvs_dt_cancelamento, lvs_dt_emissao, lvs_dt_prev_entrega


Try
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum

	Select de_chave_sap
	  Into :is_de_chave_acesso_sap
	  From interface_sap  i 
	 Where i.cd_tabela 	= :il_Tabela_Cabeca
	   and i.nr_controle = :al_controle
	Using SqlCa;	
	
	If SqlCa.sqlcode = -1 Then
		ls_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		If ll_Linhas = 1 Then
			is_id_tipo_pedido	= lo_Comum.ids_lista_registros.Object.id_tipo_pedido[1]	
			
			if is_id_tipo_pedido = 'ZSER' or is_id_tipo_pedido = 'ZATI' or is_id_tipo_pedido = 'ZSEC' or is_id_tipo_pedido = 'ZFRE' then
				//N$$HEX1$$e300$$ENDHEX$$o devemos levar em considera$$HEX2$$e700e300$$ENDHEX$$o
				lb_Sucesso = True
			else
				// Localiza Pedido SAP no Sybase
				is_nr_pedido_sap					= lo_Comum.ids_lista_registros.Object.nr_pedido_sap[1]	
				If not of_localiza_pedido_central (is_nr_pedido_sap ,   ref ls_log ) Then Return False
				
				// Fornecedor No Legado		
				If Not lo_Comum.of_localiza_codigo_fornecedor_legado(lo_Comum.ids_lista_registros.Object.cd_fornecedor[1] , ref is_cd_fornecedor_legado, ref ls_log) Then Return False
	
				// Campos Decimal 
				If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_desconto[1], 'PC_DESCONTO', ref ide_pc_desconto, ref ls_log) Then Return False
				If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_total_pedido[1], 'VL_TOTAL_PEDIDO', ref ide_vl_total_pedido, ref ls_log) Then Return False
							
				// Tratando Datas
				idt_dh_pedido				= Date(lo_Comum.ids_lista_registros.Object.dh_pedido[1])
				idt_dh_emissao				= Date(lo_Comum.ids_lista_registros.Object.dh_emissao[1])
				idt_dh_cancelamento		= Date(lo_Comum.ids_lista_registros.Object.dh_cancelamento[1])
				idt_dh_previsao_entrega	= Date(lo_Comum.ids_lista_registros.Object.dh_previsao_entrega[1])
	
				// Localiza Cond. Pagamento Legado
				If Not  of_localiza_condicao_pgto (lo_Comum.ids_lista_registros.Object.cd_condicao_pagamento[1] , ref il_cd_condicao_pagamento, ref ls_log) Then Return False
	
				// Localiza Filial no Legado
				is_cd_filial_sap  =    lo_Comum.ids_lista_registros.Object.cd_filial[1]  
				
				If Not lo_Comum.of_localiza_codigo_filial_legado( is_cd_filial_sap   ,   il_cd_filial_legado , ref ls_log    )   Then Return False		
	
				is_id_modalidade_frete 				= lo_Comum.ids_lista_registros.Object.id_tipo_frete[1]	   					
				is_de_mensagem_logistica_text	= lo_Comum.ids_lista_registros.Object.de_mensagem_logistica_text[1]	
				is_de_observacao 						= lo_Comum.ids_lista_registros.Object.de_observacao[1]	
				is_de_transportadora					= lo_Comum.ids_lista_registros.Object.de_transportadora[1]	
				is_id_acordo_titulo						= lo_Comum.ids_lista_registros.Object.id_acordo_titulo[1]	
				is_id_programado						= lo_Comum.ids_lista_registros.Object.id_programado[1]								
				is_cd_grupo_comprador_sap		= lo_Comum.ids_lista_registros.Object.cd_grupo_comprador[1]
				il_pedido_distribuidora				= Long(lo_Comum.ids_lista_registros.Object.nr_solicitacao[1])
				
				if IsNull(is_id_programado) then is_id_programado = 'N'
				
				//Localiza grupo de compradores no legado, retorna uma matricula.
				If Not lo_Comum.of_Localiza_Codigo_Comprador_Legado( is_cd_grupo_comprador_sap, Ref is_nr_matricula_cadastramento, Ref ls_log) Then Return False
				
				if not of_valida_usuario(ls_log) then return false
				if not of_valida_meta(ls_log) then return false
				
				is_nr_matricula_cancelamento	= lo_Comum.ids_lista_registros.Object.nr_matricula_cancelamento[1]	
				il_qt_dias_suprimento			= Long(lo_Comum.ids_lista_registros.Object.qt_dias_suprimento[1])	
				is_id_situacao_pedido			= lo_Comum.ids_lista_registros.Object.id_situacao[1]	
	
				If IsNull(is_id_situacao_pedido) Then 
					is_id_situacao_pedido = 'C'
				End If 
			
				/// Tipos De Pedido
				Choose Case is_id_tipo_pedido					
					Case 'ZPBM', 'ZPB'	//PBM
							is_id_pbm = 'S'
					Case 'ZPFG'    		//FARMACIA DO GOVERNO 
							is_id_farmacia_governo = 'S'
					Case 'ZLIC'      		//LICITA$$HEX2$$c700c300$$ENDHEX$$O
							is_id_licitacao  = 'S'
				End Choose				
							
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.wf_settext('PedidoCentral: ' + is_nr_pedido_sap , 3 )
				end if					

				// Cabe$$HEX1$$e700$$ENDHEX$$a do Pedido
				If This.of_Atualiza_pedido_central(Ref ls_Log ) Then
					// Itens do Pedido
					If This.of_Atualiza_pedido_central_produto(Ref ls_Log, al_controle) Then
						// Mensagens de Itens do Pedido 
						If This.of_Atualiza_pedido_central_produto_msg(Ref ls_Log, al_controle) Then
							lb_Sucesso	= True
						End If
					End If
				End If
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress_2.of_setprogress(1)
				end if	
			end if
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If		
	End If
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_wms_nf_compra], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_nota_fiscal]. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 179, ls_Log, False)
	End If	
	Destroy lo_Comum		
End Try	

Return True
end function

public function boolean of_atualiza_pedido_central_produto_msg (ref string as_log, long al_controle_pai);Datetime	ldt_inclusao
Long 		ll_Controle_filho, ll_Linha, ll_exists, ll_itens
String 	ls_Requisicao_Chave, ls_dt_validade_limite, ls_cd_produto_sap, ls_produto_ant

uo_ge473_comum lo_Comum

Try
	//Busca registro de mensagem de logistica
	Select Top 1 nr_controle, 
			 de_chave_sap
  	  Into :ll_Controle_filho, 
		 	 :ls_Requisicao_Chave
	  from interface_sap  i 
	 Where i.cd_tabela			= :il_Tabela_Item_Msg
		and i.nr_controle_pai 	= :al_controle_pai
	Using SqlCa;	

	Choose Case SqlCa.SqlCode
		Case	100
			//Caso n$$HEX1$$e300$$ENDHEX$$o exista mensagem de log$$HEX1$$ed00$$ENDHEX$$stica ent$$HEX1$$e300$$ENDHEX$$o continuar o processo fora da fun$$HEX2$$e700e300$$ENDHEX$$o
			Return True
		Case -1
			as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
			Return False
	End Choose

	If IsNull(ls_Requisicao_Chave) Or Trim(ls_Requisicao_Chave)="" Then
		as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso informada na INTERFACE_SAP do filho (lote) est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	Else
		If Trim(ls_Requisicao_Chave) <> Trim(is_nr_pedido_sap) Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da INTERFACE_SAP pai e filho (lote) est$$HEX1$$e300$$ENDHEX$$o diferentes."
			Return False
		End If
	End If
	
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then
		//Classifica a lista de msgs pelo c$$HEX1$$f300$$ENDHEX$$digo do produto para excluir as mensagens do produto j$$HEX1$$e100$$ENDHEX$$ gravadas na tabela antes de descarreg$$HEX1$$e100$$ENDHEX$$-las novamente
		
		lo_Comum.ids_lista_registros.SetSort ('cd_produto_sap ASC')
		lo_Comum.ids_lista_registros.Sort ()
		
		ll_itens = lo_Comum.ids_lista_registros.RowCount()
		
		For ll_Linha = 1 To ll_itens
			SetNull(ls_dt_validade_limite)
			SetNull(ide_qt_faturar)
			SetNull(il_cd_filial_sap_item_msg)
			
			ls_cd_produto_sap	= lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha]
			
			If ls_cd_produto_sap <> ls_produto_ant then
				
				/// Localiza Produto Legado
				If Not lo_Comum.of_localiza_codigo_produto_legado(ls_cd_produto_sap, Ref il_cd_produto, as_log) Then Return False
				
				//Exclui TODAS as mensagens do produto j$$HEX1$$e100$$ENDHEX$$ gravadas na tabela antes de descarreg$$HEX1$$e100$$ENDHEX$$-las novamente
				DELETE FROM pedido_central_prd_msg_logist  
						WHERE	nr_pedido   = :il_nr_pedido_central  
						  AND	cd_produto	= :il_cd_produto 
				Using SqlCA;
	
				If SQLCA.SqlCode = -1 Then
					as_Log	= "Erro ao apagar registro na tabela 'pedido_central_prd_msg_logist'. Pedido SAP/Produto ["+This.is_nr_pedido_sap + "/" +String( this.il_cd_produto) + "]. Erro: "+ SqlCa.SqlErrText
					Return False						
				End If
				
				ls_produto_ant = ls_cd_produto_sap
				
			End if
			
			// Valida$$HEX2$$e700e300$$ENDHEX$$o :  Chave de Pedido SAP
			If IsNull(lo_Comum.ids_lista_registros.Object.nr_pedido_sap[ll_Linha]) or Trim(lo_Comum.ids_lista_registros.Object.nr_pedido_sap[ll_Linha]) = "" Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da chave pedido sap est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida no filho.' 	
				Return False
			End If
			
			// Valida$$HEX2$$e700e300$$ENDHEX$$o :  Chave de Pedido SAP
			If Trim(is_nr_pedido_sap) <> Trim(lo_Comum.ids_lista_registros.Object.nr_pedido_sap[ll_Linha]) Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da chave de pedido sap pai e filho(item) est$$HEX1$$e300$$ENDHEX$$o diferentes.' 	
				Return False
			End If
			
			
			// Valida do Produto 
			If IsNull(il_cd_produto) or il_cd_produto <= 0  Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do produto [' + String(il_cd_produto) + '] da chave de acesso [' + is_de_chave_acesso +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
				Return False
			End If
					
			il_nr_item						= Long(lo_Comum.ids_lista_registros.Object.nr_item_sap[ll_Linha])
			is_cd_centro_sap  			= lo_Comum.ids_lista_registros.Object.cd_centro_sap[ll_Linha]
			is_cd_filial_sap_item_msg	= lo_Comum.ids_lista_registros.Object.cd_filial_sap[ll_Linha]
			is_cd_comprador   			= lo_Comum.ids_lista_registros.Object.cd_comprador[ll_Linha]    
			is_matricula_avisar 			= is_cd_comprador
			is_descricao_mensagem  		= lo_Comum.ids_lista_registros.Object.descricao_mensagem[ll_Linha]
			il_cd_mensagem  				= Long(lo_Comum.ids_lista_registros.Object.cd_mensagem[ll_Linha])
			is_cancelado_msg_sap			= lo_Comum.ids_lista_registros.Object.id_cancelado_msg_sap[ll_Linha]    

			If IsNull(il_cd_mensagem) or il_cd_mensagem <= 0 Then 
				//as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrando o c$$HEX1$$f300$$ENDHEX$$digo da Mensagem de Log$$HEX1$$ed00$$ENDHEX$$stica do produto [' + String(il_cd_produto) + '] do pedido [' + is_nr_pedido_sap +  ']. Favor verificar no SAP e tentar novamente.' 	 	
				//Return False
				Continue
			End If 
			
			If is_cancelado_msg_sap =	'S' Then 
				idt_dh_exclusao					= gf_getserverdate()
				is_nr_matricula_cancelamento 	= is_nr_matricula_cadastramento
			Else
				SetNull(idt_dh_exclusao) 
				SetNull(is_nr_matricula_cancelamento) 
			End If 

			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.qt_faturar[ll_linha], 'QT_FATURAR', ref ide_qt_faturar, ref as_log, true) Then Return False
			
			il_qt_faturar 		=  Long(ide_qt_faturar)			

			ls_dt_validade_limite 	= String(lo_Comum.ids_lista_registros.Object.dh_limite_validade[ll_Linha])
			
			If Not IsNull(ls_dt_validade_limite) and ls_dt_validade_limite <> '000000' Then 
				ls_dt_validade_limite	= MidA(ls_dt_validade_limite, 1,4)	+'-'+	MidA(ls_dt_validade_limite, 5,2)+'-01'
				
				If Not lo_Comum.of_date_time(ls_dt_validade_limite , 'DH_LIMITE_VALIDADE', ref idt_limite_validade, ref as_Log) Then Return False
			else
				SetNull(idt_limite_validade)
			End If 			
			
			If Not IsNull(is_cd_centro_sap) Then 
				If Not lo_Comum.of_localiza_codigo_filial_legado(is_cd_centro_sap, il_cd_centro_legado, ref as_log) Then Return False
			End If 
			
			If Not IsNull(	is_cd_filial_sap_item_msg) Then 
				If Not lo_Comum.of_localiza_codigo_filial_legado(is_cd_filial_sap_item_msg, il_cd_filial_sap_item_msg, ref as_log) Then Return False
			End If 		
			
			If IsNull(il_nr_item) or il_nr_item <= 0 Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do item do produto [' + String(il_cd_produto) + '] da chave de acesso [' + is_nr_pedido_sap +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
				Return False
			End If		
			
			// Proximo Numero Sequencial Msg: Caso Nova Msg
			If Not of_localiza_proximo_sequencial_msg(Ref il_prox_msg_logistica, Ref as_log ) Then Return False
			
			If Not ib_Pedido_Novo  Then 
				select top 1 1
				  into :ll_exists
				  from pedido_central_produto
				 where nr_pedido	= :il_nr_pedido_central
				 	and cd_produto	= :il_cd_produto
				using SQLCA;
				
				Choose Case SQLCA.SQLCode
					Case -1
						as_log	= 'Erro ao localizar o item do pedido central para a inser$$HEX2$$e700e300$$ENDHEX$$o da mensagem de log$$HEX1$$ed00$$ENDHEX$$stica (' + ls_cd_produto_sap + '). Erro: ' + SQLCA.SQLErrText
						Return False
					Case 100
						if is_cancelado_msg_sap = 'S' then
							Return True
						Else
							as_log	= 'Mensagem log$$HEX1$$ed00$$ENDHEX$$sica cadastrado para um produto que n$$HEX1$$e300$$ENDHEX$$o foi localizado dentro do pedido de compra vindo do SAP (' + ls_cd_produto_sap + ').'
							Return False
						End If
					Case 0
						// Inser$$HEX2$$e700e300$$ENDHEX$$o do Registro
						Insert Into pedido_central_prd_msg_logist(nr_sequencial,
																				nr_pedido,
																				cd_produto,
																				cd_mensagem,
																				cd_filial_envio,
																				qt_devolver,
																				nr_matricula_inclusao,
																				dh_limite_validade,
																				nr_matricula_avisar,
																				dh_inclusao,
																				dh_exclusao,
																				nr_matricula_exclusao)
																	 Values (:il_prox_msg_logistica,
																				:il_nr_pedido_central,
																				:il_cd_produto,
																				:il_cd_mensagem,
																				:il_cd_filial_sap_item_msg,
																				:il_qt_faturar,
																				:is_nr_matricula_cadastramento,
																				:idt_limite_validade,
																				:is_matricula_avisar,
																				getdate(),
																				:idt_dh_exclusao,
																				:is_nr_matricula_cancelamento)
						Using SqlCA;
					
						If SqlCa.SqlCode = -1 Then
							as_Log	= "Erro ao inserir registro na tabela 'pedido_central_prd_msg_logist'. Pedido/Produto ["+String(il_nr_pedido_central)+ "/" + String(il_cd_produto) + "]. Erro: "+ SqlCa.SqlErrText
							Return False
						End If
				End Choose
			Else
				select top 1 1
				  into :ll_exists
				  from pedido_central_produto
				 where nr_pedido	= :il_nr_pedido_central_proximo
				 	and cd_produto	= :il_cd_produto
				using SQLCA;
				
				Choose Case SQLCA.SQLCode
					Case -1
						as_log	= 'Erro ao localizar o item do pedido central para a inser$$HEX2$$e700e300$$ENDHEX$$o da mensagem de log$$HEX1$$ed00$$ENDHEX$$stica (' + ls_cd_produto_sap + '). Erro: ' + SQLCA.SQLErrText
						Return False
					Case 100
						if is_cancelado_msg_sap = 'S' then
							Return True
						else
							as_log	= 'Mensagem log$$HEX1$$ed00$$ENDHEX$$sica cadastrado para um produto que n$$HEX1$$e300$$ENDHEX$$o foi localizado dentro do pedido de compra vindo do SAP (' + ls_cd_produto_sap + ').'
							Return False
						end if
					Case 0
						// Inser$$HEX2$$e700e300$$ENDHEX$$o do Registro
						Insert into pedido_central_prd_msg_logist (nr_sequencial,
																				 nr_pedido,
																				 cd_produto,
																				 cd_mensagem,
																				 cd_filial_envio,
																				 qt_devolver,
																				 nr_matricula_inclusao,
																				 dh_limite_validade,
																				 nr_matricula_avisar,
																				 dh_inclusao,
																				 dh_exclusao,
																				 nr_matricula_exclusao)
															        Values (:il_prox_msg_logistica,
																				 :il_nr_pedido_central_proximo,
																				 :il_cd_produto,
																				 :il_cd_mensagem,
																				 :il_cd_filial_sap_item_msg,
																				 :il_qt_faturar,
																				 :is_nr_matricula_cadastramento,
																				 :idt_limite_validade,
																				 :is_matricula_avisar,
																				 getdate(),
																				 :idt_dh_exclusao,
																				 :is_nr_matricula_cancelamento)
						Using SqlCA;
						
						If SqlCa.SqlCode = -1 Then
							as_Log	= "Erro ao inserir registro na tabela 'nf_agendamento_ent_item_lote'. Chave de Acesso/Lote ["+This.is_de_chave_acesso + "/" + String(this.il_cd_produto) + "]. Erro: "+ SqlCa.SqlErrText
							Return False
						End If
				End Choose
			End If 
		Next	
	Else
		Return False				
	End If
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_pedido_central], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_pedido_central_produto_msg]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_atualiza_pedido_central_produto (ref string as_log, long al_controle_pai);Dec{2}	ldc_vl_total_pedido
Long 		ll_ProdutoExiste, ll_Controle_filho, ll_Linha, ll_ContaCancelado, ll_exists, ll_nr_pedido
String 	ls_Requisicao_Chave

uo_ge473_comum lo_Comum


SetNull(ll_ContaCancelado)

Try			
	Select nr_controle, 
			 de_chave_sap
	  Into :ll_Controle_filho, 
	  		 :ls_Requisicao_Chave
	  From interface_sap  i 
	 Where i.cd_tabela 			= :il_Tabela_Item 
		And i.nr_controle_pai 	= :al_controle_pai
	Using SqlCa;	

	If SQLCA.SQLCode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If IsNull(ls_Requisicao_Chave) Or Trim(ls_Requisicao_Chave)="" Then
		as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso informada na INTERFACE_SAP do filho est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	Else
		If Trim(ls_Requisicao_Chave) <> Trim(This.is_de_chave_acesso_sap ) Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da INTERFACE_SAP pai e filho est$$HEX1$$e300$$ENDHEX$$o diferentes."
			Return False
		End If
	End If
	
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()	
			
			SetNull(ll_ProdutoExiste)
			
			// Valida$$HEX2$$e700e300$$ENDHEX$$o :  Chave de Pedido SAP
			If IsNull(lo_Comum.ids_lista_registros.Object.nr_pedido_sap[ll_Linha]) or Trim(lo_Comum.ids_lista_registros.Object.nr_pedido_sap[ll_Linha]) = "" Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da chave pedido sap est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida no filho.' 	
				Return False
			End If
			
			// Valida$$HEX2$$e700e300$$ENDHEX$$o :  Chave de Pedido SAP
			If Trim(is_nr_pedido_sap) <> Trim(lo_Comum.ids_lista_registros.Object.nr_pedido_sap[ll_Linha]) Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da chave de pedido sap pai e filho(item) est$$HEX1$$e300$$ENDHEX$$o diferentes.' 	
				Return False
			End If
			
			// Quantidade Pedida
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.qt_pedida[ll_linha], 'QT_PEDIDA', ref ide_qt_pedida, ref as_log, true) Then Return False
			il_qt_pedida =  Long(ide_qt_pedida)
			If il_qt_pedida < 0 or IsNull(il_qt_pedida) Then 
				as_log = 'Quantidade Pedida Iv$$HEX1$$e100$$ENDHEX$$lida.N$$HEX1$$fa00$$ENDHEX$$mero do produto [' + String(il_cd_produto) + '] da chave de acesso [' + is_de_chave_acesso +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
				Return False
			End If 
			
			SetNull(is_id_retira_qtde_pendente_meta)
			
			is_status_item    		=  lo_Comum.ids_lista_registros.Object.id_cancelado_sap[ll_Linha]
			is_id_excluir_produto	=  lo_Comum.ids_lista_registros.Object.id_excluir_produto[ll_Linha]
			is_status					= 'C'
			
			if is_id_excluir_produto = 'S' then
				is_status = 'X'
			end if
			
			If is_status_item = 'S'  Then 	
				is_id_retira_qtde_pendente_meta = 'S'
			End If 
							
			il_nr_embalagem_padrao 	=  Long(lo_Comum.ids_lista_registros.Object.nr_embalagem_padrao[ll_Linha]) 
			
			If il_nr_embalagem_padrao<0 or IsNull(il_nr_embalagem_padrao) Then 
				as_log = 'Embalagem Padrao Iv$$HEX1$$e100$$ENDHEX$$lida.N$$HEX1$$fa00$$ENDHEX$$mero do produto [' + String(il_cd_produto) + '] da chave de acesso [' + is_de_chave_acesso +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
			End If 
			
			If Isnull(lo_Comum.ids_lista_registros.Object.cd_produto[ll_Linha]) Then Continue
			
			/// Localiza Produto Legado								
			If Not lo_Comum.of_localiza_codigo_produto_legado(lo_Comum.ids_lista_registros.Object.cd_produto[ll_Linha], il_cd_produto, as_log) Then Return False
			
			// Codigo do Produto 
			If IsNull(il_cd_produto) or il_cd_produto <= 0  Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do produto [' + String(il_cd_produto) + '] da chave de acesso [' + is_de_chave_acesso +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
				Return False
			End If
						
			// Trata Campos Decimais
			ide_pc_desconto_item			= 0
			ide_pc_repasse_icms			= 0
			ide_pc_desconto_financeiro	= 0
			ide_pc_midia					= 0
			ide_qt_estoque_momento		= 0
			ide_vl_preco_unitario		= 0
			
			If Not lo_Comum.of_decimal(gf_replace(String(lo_Comum.ids_lista_registros.Object.pc_desconto[ll_linha]), '-','',0),'PC_DESCONTO', ref ide_pc_desconto_item, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(gf_replace(String(lo_Comum.ids_lista_registros.Object.pc_repasse_icms[ll_linha]), '-','',0), 'PC_REPASSE_ICMS', ref ide_pc_repasse_icms, ref as_log, true) Then Return False
			/* O desconto financeiro n$$HEX1$$e300$$ENDHEX$$o faz parte dos calculos do SAP, sendo assim, n$$HEX1$$e300$$ENDHEX$$o pode ser considerado dentro do Sybase. Est$$HEX1$$e100$$ENDHEX$$ divergindo o calculo e tamb$$HEX1$$e900$$ENDHEX$$m validando de forma indevida em casos o qual o desconto $$HEX1$$e900$$ENDHEX$$ muito alto. */
			//If Not lo_Comum.of_decimal(gf_replace(String(lo_Comum.ids_lista_registros.Object.pc_desconto_financeiro[ll_linha]), '-','',0), 'PC_DESCONTO_FINANCEIRO', ref ide_pc_desconto_financeiro, ref as_log, true) Then Return False			
			If Not lo_Comum.of_decimal(gf_replace(String(lo_Comum.ids_lista_registros.Object.pc_midia[ll_linha]), '-','',0),'PC_MIDIA', ref ide_pc_midia, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.qt_estoque_momento[ll_linha], 'QT_ESTOQUE_MOMENTO', ref ide_qt_estoque_momento, ref as_log, true) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_preco_unitario[ll_linha], 'VL_PRECO_UNITARIO', ref ide_vl_preco_unitario, ref as_log, true) Then Return False
			
			ide_vl_preco_unitario	= Round(ide_vl_preco_unitario, 2)
			
			if IsNull(ide_pc_desconto_item) then ide_pc_desconto_item = 0
			
			ide_pc_desconto_item 	= Round(ide_pc_desconto_item, 2)
					
			// Valida Exist$$HEX1$$ea00$$ENDHEX$$ncia do item do Pedido
			Select 1
			  Into :ll_exists
			  From pedido_central
			 Where nr_pedido	= :il_nr_pedido_central
			Using SqlCA;
			
			Choose Case SQLCA.SQLCode
				Case 0
					ll_nr_pedido	= il_nr_pedido_central
				Case 100
					ll_nr_pedido	= il_nr_pedido_central_proximo
				Case -1
					as_Log	= "Erro ao localizar registro na tabela 'pedido_central'. " + String(il_nr_pedido_central) + ". Erro: "+ SqlCa.SqlErrText
					Return False
			End Choose
			
			// Valida Exist$$HEX1$$ea00$$ENDHEX$$ncia do item do Pedido
			Select cd_produto
			  Into :ll_ProdutoExiste
			  From pedido_central_produto   			
			 Where nr_pedido	= :ll_nr_pedido
				And cd_produto = :il_cd_produto
			Using SqlCA;
			
			Choose Case SqlCa.SqlCode
				Case 0												
					/// Altera os dados do Produto
					If ll_ProdutoExiste >0 Then 
						Update pedido_central_produto  
							Set id_situacao 						= :is_status,
								 pc_desconto 						= :ide_pc_desconto_item,
								 qt_estoque_momento				= :ide_qt_estoque_momento, 
								 qt_pedida    						= coalesce(:il_qt_pedida, 0),
								 vl_preco_unitario 				= :ide_vl_preco_unitario, 
								 nr_embalagem_padrao 			= :il_nr_embalagem_padrao,  
								 pc_midia    						= :ide_pc_midia, 
								 pc_repasse_icms 					= :ide_pc_repasse_icms, 
								 pc_desconto_financeiro 		= :ide_pc_desconto_financeiro,  
								 id_cancelado_sap   				= :is_status_item,
								 id_retira_qtde_pendente_meta = :is_id_retira_qtde_pendente_meta
						 Where nr_pedido	= :il_nr_pedido_central  
							And cd_produto	= :il_cd_produto
						Using SqlCA;
			
						If SqlCa.SqlCode = -1 Then
							as_Log	= "Erro ao atualizar registro na tabela 'pedido_central_produto'. Chave de Acesso/Produto ["+This.is_de_chave_acesso + "/" +String( this.il_cd_produto) + "]. Erro: "+ SqlCa.SqlErrText
							Return False						
						End If 
						
						if is_status_item = 'S' then
							Update pedido_central_produto  
								Set qt_recebida	= qt_pedida
							 Where nr_pedido	= :il_nr_pedido_central  
								And cd_produto	= :il_cd_produto
							Using SqlCA;
				
							If SqlCa.SqlCode = -1 Then
								as_Log	= "Erro ao atualizar registro na tabela 'pedido_central_produto' com a quantidade recebida total devido marca$$HEX2$$e700e300$$ENDHEX$$o no SAP. Chave de Acesso/Produto ["+This.is_de_chave_acesso + "/" +String( this.il_cd_produto) + "]. Erro: "+ SqlCa.SqlErrText
								Return False						
							End If

						end if
					End If 						
				Case	100		
					if is_id_excluir_produto = 'S' then continue
					
					If IsNull(ll_ProdutoExiste) Then 
						///  Insere o item no pedido
						Insert into pedido_central_produto (cd_produto,  
																		id_situacao,
																		nr_pedido,    
																		pc_desconto,
																		qt_estoque_momento,
																		qt_pedida,    
																		qt_recebida,
																		vl_preco_unitario,
																		nr_embalagem_padrao,
																		pc_midia,
																		pc_repasse_icms,
																		pc_desconto_financeiro, 
																		id_cancelado_sap,
																		id_retira_qtde_pendente_meta)
															 Values (:il_cd_produto,
																		:is_status,
																		:ll_nr_pedido,
																		:ide_pc_desconto_item,
																		:ide_qt_estoque_momento,
																		:il_qt_pedida,	
																		:il_qt_recebida,
																		:ide_vl_preco_unitario,
																		:il_nr_embalagem_padrao, 
																		:ide_pc_midia,
																		:ide_pc_repasse_icms,
																		:ide_pc_desconto_financeiro, 
																		:is_status_item,
																		:is_id_retira_qtde_pendente_meta) 	
						Using SqlCA;
									
						If SqlCa.SqlCode = -1 Then
							as_Log	= "Erro ao inserir registro na tabela 'pedido_central_produto'. Chave de Acesso/Produto ["+This.is_de_chave_acesso + "/" +String( this.il_cd_produto) + "]. Erro: "+ SqlCa.SqlErrText
							Return False
						End If				
					End If 
					
				Case -1
					as_Log	= "Erro ao localizar registro na tabela 'pedido_central'. Nota Fiscal [" + is_nr_pedido_sap+"]. Erro: "+ SqlCa.SqlErrText
					Return False
			End Choose
			
			
		Next
		
		//Atualiza o total do pedido
		/*ldc_vl_total_pedido	= 0
		
		select Round(sum(case when id_situacao <> 'X' then 
								 (qt_pedida * vl_preco_unitario) - 
								 ((coalesce(pc_desconto, 0)/100) * (qt_pedida * vl_preco_unitario)) - 
								 ((coalesce(pc_repasse_icms, 0)/100) * (qt_pedida * vl_preco_unitario)) + 
								 ((coalesce(pc_ipi, 0)/100) * (qt_pedida * vl_preco_unitario))
							  else 
								 0 
							  end), 2)
		  into :ldc_vl_total_pedido 
		  from dbo.pedido_central_produto 
		 where nr_pedido = :ll_nr_pedido
		using SQLCA;
		
		Choose Case SQLCA.SQLCode 
			Case -1
				as_Log	= "Erro ao localizar total de produto na tabela 'pedido_central_produto'. Nota Fiscal [" + is_nr_pedido_sap+"]. Erro: "+ SqlCa.SqlErrText
				Return False
			Case 100
				ldc_vl_total_pedido	= 0
		End Choose
		
		update pedido_central
			set vl_total_pedido	= :ldc_vl_total_pedido
		 where nr_pedido	= :ll_nr_pedido
		using SQLCA;
		
		if SQLCA.SQLCode = -1 then
			as_Log	= "Erro ao atualizar total do pedido na tabela 'pedido_central'. Nota Fiscal [" + is_nr_pedido_sap+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		end if*/
	Else
		Return False				
	End If
	
	if not of_atualiza_situacao_pedido_central(as_Log) then
		Return False
	end if	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_pedido_central, fun$$HEX2$$e700e300$$ENDHEX$$o [of_insere_pedido_central_item]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_verifica_qtd_itens_cancelados (string ps_pedido_sap, ref string as_log);If Trim(ps_pedido_sap) = "" or IsNull(ps_pedido_sap) Then
	as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o numero do pedido sap  [nr_pedido_sap]."
	Return False
End If

Select count(pcp.cd_produto),
       sum(Case When coalesce(id_cancelado_sap,'N') = 'S' and qt_recebida = 0  Then 1 Else 0 End ) as Qtd_Cancelado
  Into :il_Qtd_Produtos, 
 		 :il_Qtd_Produtos_Cancelados
  From pedido_central pc 
 Inner join pedido_central_produto pcp
    On pc.nr_pedido	= pcp.nr_pedido    
 Where pc.nr_pedido_sap = :ps_pedido_sap
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "Quantidade Produtos ou Qtd Cancelados n$$HEX1$$e300$$ENDHEX$$o foram localizado."
		Return False
	Case -1
		as_Log	= "Erro ao localizar a QtdProduto ou QtdCancelado no Legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True 
end function

public function boolean of_proximo_codigo_pedido_central (ref long al_pedido);Boolean lvb_Sucesso = True

uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral

If Not lvo_Parametro.of_Proximo_Sequencial("NR_ULTIMO_PEDIDO_CENTRAL", ref al_Pedido) Then
	lvb_Sucesso = False
End If

Destroy(lvo_Parametro)

Return lvb_Sucesso
end function

public function boolean of_verifica_qtd_itens_atendidos (string ps_pedido_sap, ref string as_log);If Trim(ps_pedido_sap) = "" or IsNull(ps_pedido_sap) Then
	as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o numero do pedido sap  [nr_pedido_sap]."
	Return False
End If

Select sum(Case When Coalesce(qt_recebida, 0) > 0 Then 1 Else 0 End) as qt_atendido
  Into :il_Qtd_Produtos_Atendidos
  From pedido_central  a 
 Inner join pedido_central_produto b
    on a.nr_pedido  = b.nr_pedido    
Where  a.nr_pedido_sap =:ps_pedido_sap
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		as_Log	= "Qtd Atendidos n$$HEX1$$e300$$ENDHEX$$o foram localizado."
		Return False
	Case -1
		as_Log	= "Erro ao localizar a Qtd Atendidos no Legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True 
end function

public function boolean of_atualiza_situacao_pedido_central (ref string as_log);If il_nr_pedido_central > 0 Then 
	If of_verifica_qtd_itens_cancelados(is_nr_pedido_sap, as_log) Then 	
		If il_Qtd_Produtos = il_Qtd_Produtos_Cancelados Then 
			Update pedido_central
				Set id_situacao  = 'X',
					 dh_cancelamento = getdate(),
					 nr_matricula_cancelamento =:is_nr_matricula_cancelamento 
			 Where nr_pedido_sap =:is_nr_pedido_sap
			Using	SQLCA;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao cancelar na tabela 'pedido_central'. Chave de Acesso/Produto ["+This.is_nr_pedido_sap + "/" +String( this.il_nr_pedido_central) + "]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
			Update pedido_distribuidora
				Set id_situacao = 'F'
			From pedido_distribuidora pd
			Join pedido_central pc
			  On pd.cd_filial = pc.cd_filial
			 And pd.nr_pedido_distribuidora	= pc.nr_pedido_distribuidora
			 And pd.cd_distribuidora				= pc.cd_fornecedor
			Where pc.nr_pedido_sap = :is_nr_pedido_sap
			And	pc.cd_filial			 = :il_cd_filial_legado
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao inserir registro na tabela 'pedido_distribuidora'. Pedido [" + is_nr_pedido_sap+"]. Erro: "+ SqlCa.SqlErrText
				SqlCa.of_Rollback()
				Return false
			End If	
			
		Else
			If of_verifica_qtd_itens_atendidos(is_nr_pedido_sap, as_log) Then
				If il_Qtd_Produtos_Atendidos > 0 Then
					Update pedido_central
						Set id_situacao  = 'A',
							 dh_cancelamento = null,
							 nr_matricula_cancelamento = null
					 Where nr_pedido_sap =:is_nr_pedido_sap
					Using	SQLCA;
					
					If SqlCa.SqlCode = -1 Then
						as_Log	= "Erro ao marcar como atendido a tabela 'pedido_central'. Chave de Acesso/Produto ["+This.is_nr_pedido_sap + "/" +String( this.il_nr_pedido_central) + "]. Erro: "+ SqlCa.SqlErrText
						Return False
					End If
					
					Update pedido_distribuidora
						Set id_situacao = 'F'
					From pedido_distribuidora pd
					Join pedido_central pc
					  On pd.cd_filial = pc.cd_filial
					 And pd.nr_pedido_distribuidora	= pc.nr_pedido_distribuidora
					 And pd.cd_distribuidora				= pc.cd_fornecedor
					Where pc.nr_pedido_sap = :is_nr_pedido_sap
					And	pc.cd_filial			 = :il_cd_filial_legado
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						as_Log	= "Erro ao inserir registro na tabela 'pedido_distribuidora'. Pedido [" + is_nr_pedido_sap+"]. Erro: "+ SqlCa.SqlErrText
						SqlCa.of_Rollback()
						Return false
					End If	

Return true	
					
					
					
				End If
			Else
				Return False
			End If
		End If
	Else
		Return False
	End If
	

End If 

Return True
end function

public function boolean of_valida_usuario (ref string as_log);Long	ll_exists


select 1
  into :ll_exists
  from usuario
 where nr_matricula	= :is_nr_matricula_cadastramento;
 
Choose Case SQLCA.SQLCode 
	Case -1
		as_Log  = "Erro ao localizar o usu$$HEX1$$e100$$ENDHEX$$rio " + is_nr_matricula_cadastramento + ". Erro: " + SQLCA.SQLErrText
		Return False
	Case 100
		as_Log	= 'A matr$$HEX1$$ed00$$ENDHEX$$cula ' + is_nr_matricula_cadastramento + ' associada ao comprador com c$$HEX1$$f300$$ENDHEX$$digo SAP ' + is_cd_grupo_comprador_sap + " n$$HEX1$$e300$$ENDHEX$$o foi localizada na tabela 'USUARIO'"
		Return False
End Choose

return true
end function

public function boolean of_valida_meta (ref string as_log);Date	ld_dh_meta
Long	ll_exists


ld_dh_meta	= gf_primeiro_dia_mes(idt_dh_emissao)

If is_nr_matricula_cadastramento = '14330' Then 
	Return True
End if

select 1
  into :ll_exists
  from meta_compra_comprador
 where dh_meta						= :ld_dh_meta
 	and nr_matricula_comprador	= :is_nr_matricula_cadastramento;
 
Choose Case SQLCA.SQLCode
	Case -1
		as_log = 'Erro ao buscar meta do comprador ' + is_nr_matricula_cadastramento + '. Erro: ' + SQLCA.SQLErrText
		Return False
	Case 100
		as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrada a meta do m$$HEX1$$ea00$$ENDHEX$$s ' + String(ld_dh_meta, 'dd/mm/yyyy') + &
					' para o comprador ' + is_nr_matricula_cadastramento + &
					' (c$$HEX1$$f300$$ENDHEX$$digo SAP ' + is_cd_grupo_comprador_sap + ')'
		Return False
End Choose

Return True
 
end function

public function boolean of_atualiza_pedido_distribuidora_prod (long al_pedido_central, long al_cd_filial, long al_produto, long al_qt_faturada, ref string as_erro);UPDATE pedido_distribuidora_produto
SET qt_faturada = :al_qt_faturada
FROM pedido_distribuidora_produto pdp
JOIN pedido_central pc
  ON pdp.cd_filial = pc.cd_filial
 AND pdp.nr_pedido_distribuidora = pc.nr_pedido_distribuidora
WHERE pc.nr_pedido = :al_pedido_central
  AND pdp.cd_produto = :al_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_erro	= "Erro ao inserir registro na tabela 'pedido_distribuidora_produto'. Pedido [" + string(al_pedido_central)+"]. Erro: "+ SqlCa.SqlErrText
	SqlCa.of_Rollback()
	Return false
End If	

Return true
end function

on uo_ge473_pedido_central.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_pedido_central.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

