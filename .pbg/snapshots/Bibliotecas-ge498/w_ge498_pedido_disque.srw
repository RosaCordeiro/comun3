HA$PBExportHeader$w_ge498_pedido_disque.srw
forward
global type w_ge498_pedido_disque from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge498_pedido_disque
end type
type dw_3 from dc_uo_dw_base within w_ge498_pedido_disque
end type
type gb_entrega from groupbox within w_ge498_pedido_disque
end type
type gb_2 from groupbox within w_ge498_pedido_disque
end type
type dw_4 from dc_uo_dw_base within w_ge498_pedido_disque
end type
type dw_5 from dc_uo_dw_base within w_ge498_pedido_disque
end type
type cb_incluir_pagamento from commandbutton within w_ge498_pedido_disque
end type
type dw_6 from dc_uo_dw_base within w_ge498_pedido_disque
end type
type gb_pagamento from groupbox within w_ge498_pedido_disque
end type
type gb_3 from groupbox within w_ge498_pedido_disque
end type
type datastore_1 from datastore within w_ge498_pedido_disque
end type
end forward

global type w_ge498_pedido_disque from dc_w_response_ok_cancela
integer width = 3483
integer height = 2228
string title = "GE498 - Pedido Disque Entrega"
event ue_atualiza_total_pedido ( )
dw_2 dw_2
dw_3 dw_3
gb_entrega gb_entrega
gb_2 gb_2
dw_4 dw_4
dw_5 dw_5
cb_incluir_pagamento cb_incluir_pagamento
dw_6 dw_6
gb_pagamento gb_pagamento
gb_3 gb_3
datastore_1 datastore_1
end type
global w_ge498_pedido_disque w_ge498_pedido_disque

type variables
uo_parametro_filial	io_parametro 	//GE036
uo_cliente				io_cliente 		//GE002
uo_convenio				io_convenio 		// GE004
uo_produto				io_produto 		//GE001

uo_condicao_venda_convenio			io_condicao_convenio // GE006
uo_ge498_pedido_disque_entrega 	io_pedido
uo_ge099_endereco						io_Endereco 
uo_cidade 									io_Cidade 				//GE008

str_cupom_desconto_pos_venda istr_cupom_desconto[]

long ivl_produto_busca_facil

string is_utiliza_lista_tecnica
String is_Tipo_Venda
String is_Texto_Endereco = "Digite aqui o cep ou o endere$$HEX1$$e700$$ENDHEX$$o e pressione [Enter]"

Boolean ib_negociacao_cliente 			= False
Boolean ib_Qtde_Alterada_F2 			= False
Boolean ib_Permite_Pagar_Dif_avista = True

Decimal{2} idc_Total_Pedido	 						= 0.00
Decimal{2} idc_Vl_Pedido_Minimo_Isento_Frete 	= 0.00
Decimal{2} idc_Vl_Parcela_Minima_Tef				= 0.00

Decimal{2} idc_Saldo_Disponivel_Credito 	= 0.00 //Saldo disponivel efetivo
Decimal{2} idc_Limite_Credito_Cliente		= 0.00 //Com 20% de tolerancia
Decimal{2} idc_Credito_Utilizado				= 0.00 //Credito utilizado no pedido para calculo total do pagamento
end variables

forward prototypes
public function boolean wf_localiza_produto ()
public function boolean wf_preco_desconto_produto ()
public subroutine wf_localiza_endereco ()
public function boolean wf_informar_vale_desconto ()
public function long wf_verifica_qtde_item_pedida (long pl_produto)
public subroutine wf_alteracao_preco ()
protected function boolean wf_processa_descontos_vinculados_produto (long pl_row, decimal pdc_desconto, long pl_promocao, boolean pb_somente_vinculo, long pl_produto_venda, long pl_produto_vinculo, decimal pdc_preco_unitario, string ps_tipo_inclusao, string ps_tipo_replicacao, boolean pb_cancela_item, long pl_qtd_vinculo, long pl_qtdade, long pl_codigo_desconto_progressivo)
public function boolean wf_processa_descontos_vinculados (long al_produto)
public function boolean wf_verifica_qt_vinculo ()
public subroutine wf_localiza_manipulado ()
public function boolean wf_verifica_restricao_convenio (ref decimal adc_pc_desc_convenio)
public subroutine wf_atualiza_forma_pagamento ()
public function boolean wf_limite_credito_cliente (decimal pl_valor_compra)
public function boolean wf_cliente_bloqueado ()
public function boolean wf_titulos_vencidos_cliente ()
public function boolean wf_venda_crediario ()
public function boolean wf_bloqueio_titulos_cliente_clube ()
public function boolean wf_insere_itens_dw1 ()
public function boolean wf_desconto_padrao (integer ai_linha, ref decimal adc_desconto, ref decimal adc_desconto_tabela)
public function boolean wf_verifica_qtde_desconto_campanha_pos (long al_produto, integer ai_linha, ref decimal adc_pc_desconto, ref long al_campanha, ref string as_vale_desconto)
public function boolean wf_qtde_maxima_permitida_vale_desconto (long al_produto, long al_campanha, ref long al_qt_maxima)
public function boolean wf_consiste_finalizacao_pedido ()
public function boolean wf_pedido_minimo_isento_frete ()
public function boolean wf_valor_frete (string as_cep, ref decimal adc_vl_frete, ref decimal adc_frete_calculado)
public function boolean wf_busca_limite_cliente (ref decimal adc_limite, ref decimal adc_saldo_disponivel)
public function boolean wf_limite_conveniado_liberado (decimal pdc_valor, ref decimal pdc_valor_ultrapassado)
public function boolean wf_produto_liberado_convenio (long al_produto)
public function boolean wf_consiste_produto_convenio (long pl_grupo, long pl_produto)
public function boolean wf_bloqueio_grupo_produto_convenio (long pl_grupo, long pl_produto)
public function boolean wf_contrato_desconto_saude ()
public function boolean wf_processa_desconto_convenio (long pl_cd_produto, ref string ps_log)
public function boolean wf_carrega_pedido ()
end prototypes

event ue_atualiza_total_pedido();Decimal {2}  ldc_Total_produtos, ldc_Pagto_Dinheiro, ldc_Total_Multiplos_Pagamento, ldc_Frete_Calculado
Decimal {2}  ldc_Frete, ldc_Pago, ldc_vl_Pagar_aVista, ldc_Vl_convenio, ldc_Total_Pedido

Decimal{2} ldc_valor_ultrapassado, ldc_pc_Convenio

Boolean lb_dif_avista

dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()
dw_5.AcceptText()

ldc_Pago 							= 0.00
idc_Credito_Utilizado		 		= 0.00
ldc_Vl_convenio				 	= 0.00


If dw_1.RowCount() > 0 Then
	ldc_Total_produtos	= dw_1.GetItemDecimal(dw_1.RowCount(), "cp_total_produtos")
	If IsNull(ldc_Total_produtos) Then ldc_Total_produtos = 0.00
End If

If dw_2.RowCount() > 0 Then
	If dw_2.Object.id_alterar_frete[1] = 'S'  Or  idc_Vl_Pedido_Minimo_Isento_Frete = 0 Then
		ldc_Frete	= dw_2.GetItemDecimal(dw_2.RowCount(), "vl_frete")
	Else
		If ldc_Total_produtos >= idc_Vl_Pedido_Minimo_Isento_Frete Then
			ldc_Frete = 0.00
		Else
			ldc_Frete	= dw_2.GetItemDecimal(dw_2.RowCount(), "vl_frete_calculado")
		End If
		
		dw_2.Object.vl_frete				[1] = ldc_Frete
		dw_2.acceptText()
	
	End If
End If

//Total Pedido
ldc_Total_Pedido = ldc_Total_produtos + ldc_Frete

//Atualiza Limite Utilizado
If io_Pedido.id_tipo_venda <> 'AV' Then
	If io_Pedido.id_tipo_venda = 'CV' Then
		ldc_pc_convenio = 100 -  io_Pedido.io_condicao_convenio.pc_avista 
			
		//Verifica o % a ser pago a vista na condi$$HEX2$$e700e300$$ENDHEX$$o do convenio.
		If io_Pedido.io_condicao_convenio.pc_avista > 0 Then
			ldc_Vl_convenio = Round(ldc_Total_Pedido * (ldc_pc_convenio / 100) ,2)	
			
			ldc_vl_Pagar_aVista =  ldc_Total_Pedido - ldc_Vl_convenio
			
			If idc_Saldo_Disponivel_Credito < ldc_Vl_convenio Then
				//Dif somar no pagamento a vista 
				idc_Credito_Utilizado	= idc_Saldo_Disponivel_Credito
				ldc_vl_Pagar_aVista 	= ldc_vl_Pagar_aVista + ( ldc_Vl_convenio - idc_Saldo_Disponivel_Credito)
			Else
				idc_Credito_Utilizado = ldc_Vl_convenio
			End If

		Else
			If io_Pedido.io_condicao_convenio.vl_subsidio > 0 Then
				If idc_Limite_Credito_Cliente < ldc_Total_Pedido Then
					idc_Credito_Utilizado = idc_Saldo_Disponivel_Credito
					ldc_vl_Pagar_aVista = ldc_Total_Pedido - io_Pedido.io_condicao_convenio.vl_subsidio
				Else
					idc_Credito_Utilizado = ldc_Total_Pedido
				End If
			Else
				//limite utilizado em outras compras + compra atual
				If ((idc_Limite_Credito_Cliente - idc_Saldo_Disponivel_Credito) + ldc_Total_Pedido ) <= idc_Limite_Credito_Cliente Then				
					ldc_vl_Pagar_aVista = 0
				Else
					idc_Credito_Utilizado = idc_Saldo_Disponivel_Credito
					ldc_vl_Pagar_aVista = ldc_Total_Pedido - idc_Saldo_Disponivel_Credito
				End If
			End If
		End If
		
		If idc_Credito_Utilizado < 0 Then idc_Credito_Utilizado = 0
		
		If Not ib_Permite_Pagar_Dif_avista  And ldc_vl_Pagar_aVista > 0 Then
			dw_3.Object.credito_cliente_t.Text 	= 'O Conv$$HEX1$$ea00$$ENDHEX$$nio n$$HEX1$$e300$$ENDHEX$$o permite pagamento $$HEX1$$e000$$ENDHEX$$ Vista'
			dw_3.Object.pagto_avista_t.Text 		= ''
		Else
			If ldc_vl_Pagar_aVista > 0 Then
				dw_3.Object.credito_cliente_t.Text 	= "Cr$$HEX1$$e900$$ENDHEX$$dito utilizado neste pedido: R$ " + String(idc_Credito_Utilizado,'#,##0.00')
				dw_3.Object.pagto_avista_t.Text		= "Valor a ser pago $$HEX1$$e000$$ENDHEX$$ Vista: R$ " + String(ldc_vl_Pagar_aVista,'#,##0.00')
			Else 
				dw_3.Object.credito_cliente_t.Text 	= ''
				dw_3.Object.pagto_avista_t.Text		= ''
			End If
		End If
			
		
	Else //tipo venda <> 'CV'
		If idc_Limite_Credito_Cliente < ldc_Total_Pedido  Then
			idc_Credito_Utilizado = idc_Saldo_Disponivel_Credito
			ldc_vl_Pagar_aVista = ldc_Total_Pedido - idc_Credito_Utilizado
			dw_3.Object.credito_cliente_t.Text 	= "Cr$$HEX1$$e900$$ENDHEX$$dito utilizado neste pedido: R$ " + String(idc_Credito_Utilizado,'#,##0.00')
			dw_3.Object.pagto_avista_t.Text		= "Valor a ser pago $$HEX1$$e000$$ENDHEX$$ Vista: R$ " + String(ldc_vl_Pagar_aVista,'#,##0.00')
		Else
			idc_Credito_Utilizado = ldc_Total_Pedido
			dw_3.Object.credito_cliente_t.Text 	= ''
			dw_3.Object.pagto_avista_t.Text		= ''
		End If
	End If
	
	//Atualiza dw_3
	//dw_3.Object.credito_cliente_t.Text = "Cr$$HEX1$$e900$$ENDHEX$$dito utilizado neste pedido: R$ " + String(idc_Credito_Utilizado,'#,##0.00')
End If

If dw_5.RowCount() > 0 Then
	ldc_Pagto_Dinheiro					= dw_5.GetItemDecimal(dw_5.RowCount(), "cp_total_dinheiro")
	ldc_Total_Multiplos_Pagamento 	= dw_5.GetItemDecimal(dw_5.RowCount(), 'cp_total_multiplos_pagto' )		
	If IsNull(ldc_Pagto_Dinheiro) 					Then ldc_Pagto_Dinheiro = 0.00
	If IsNull(ldc_Total_Multiplos_Pagamento)	 	Then ldc_Total_Multiplos_Pagamento = 0
End If

//Pagamento em dinheiro gerar troco
//Outros tipos de venda com pagamento parcial ex clube prazo com pagto em dinheiro gerar troco
//A var ldc_Credito_Utilizado ser$$HEX1$$e100$$ENDHEX$$ zero para tipo_venda = AV
If ldc_Pagto_Dinheiro > 0  Then
	ldc_Pago = ldc_Total_Multiplos_Pagamento + idc_Credito_Utilizado
End If

dw_4.Object.vl_total_pedido	[1] = ldc_Total_produtos + ldc_Frete
dw_4.Object.vl_pago				[1] = ldc_Pago
end event

public function boolean wf_localiza_produto ();
Integer li_Retorno

Long	ll_row,&
		ll_qtdade,&
		ll_tipo_produto_fiscal,&
		ll_Pos_exame,&
		ll_Pos_pbm
			
String  ls_Produto,&
		  ls_Manipulado,&
		  ls_Grupo, &
		  ls_Retorno, &
		  ls_alteracao_preco, &
		  ls_tipo_operacao

String ls_Usuario		  
		  
Decimal {2} lvdc_Pc_Desconto = 000.00, &
 	         lvdc_preco_formula, &
			ldc_Fator_Conversao, &
			ldc_saldo, &
			ldc_pc_desconto
			
Decimal  ldc_pc_red_bc_icms_efetivo, &
			ldc_bc_icms_efetivo, &
			ldc_pc_icms_efetivo, &
			ldc_vl_icms_efetivo
			
Boolean lb_produto_exame
 		 
ll_Row = dw_1.GetRow()

// Se n$$HEX1$$e300$$ENDHEX$$o for a $$HEX1$$fa00$$ENDHEX$$ltima linha, ent$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o de Quantidade
If ll_row <> dw_1.RowCount() Then
	dw_1.Event ue_Pos( dw_1.RowCount(), "de_produto")
	Return False
End If

dw_1.AcceptText()

ls_Produto = Trim(dw_1.Object.De_Produto[ll_row])

io_produto.of_inicializa()
io_produto.of_Localiza_Produto(ls_Produto)

If Not io_produto.Localizado Then
	Return False
End If

ldc_Fator_Conversao 	= io_produto.vl_fator_conversao

//Venda possui negocia$$HEX2$$e700e300$$ENDHEX$$o **************** COBRE PRE$$HEX1$$c700$$ENDHEX$$O
If ib_negociacao_cliente Then
End If

If Not wf_consiste_produto_convenio(io_produto.cd_grupo_produto,io_produto.cd_produto) Then
	Return False
End If

//Calcula pre$$HEX1$$e700$$ENDHEX$$o e desconto do produto
If Not wf_preco_desconto_produto() Then
	Return False
End If

dw_1.Object.cd_filial 										[ll_row] = gvo_parametro.Cd_Filial
dw_1.Object.Cd_Produto					       			[ll_row] = io_produto.Cd_Produto
dw_1.Object.nr_sequencial								[ll_row] = ll_row
dw_1.Object.De_Produto									[ll_row] = String(io_produto.cd_produto,'000000') + ' : ' + io_produto.ivs_Descricao_Apresentacao_venda + ' : ' + io_produto.Cd_Unidade_Medida_venda
dw_1.Object.nr_etiqueta_prestes						[ll_row] = io_produto.nr_etiqueta_preste

If io_produto.cd_produto = io_produto.cd_produto_manipulado Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + io_produto.de_apresentacao_venda + " n$$HEX1$$e300$$ENDHEX$$o pode ser selecionado.")
	Return False
End If

ib_Qtde_Alterada_F2 = False
Return True
end function

public function boolean wf_preco_desconto_produto ();String      ls_alteracao_preco,&
		 	 ls_desconto_negociavel,&
			 ls_Grupo,&
			 ls_taxa_frete, &
			 ls_retorno, &
			 ls_etiqueta, &
			 ls_tipo_alteracao_preco
String ls_Null
				     
Long	ll_find,&
         ll_row,&
		ll_find_brinde,&
		ll_pos_exame

Decimal  {2} ldc_desconto,&
				ldc_desconto_tabela,&
				ldc_desconto_negociavel,&
				ldc_desconto_padrao,&
				ldc_preco_unitario,&
				ldc_preco_alterado,&
				ldc_preco_praticado,&
				ldc_calculo_desconto,&
				ldc_preco_frete,&
				ldc_desconto_prestes, &
				ldc_desconto_plano_saude, &
				ldc_desconto_padrao_melhor, &
				ldc_custo, &
				ldc_praticado_permitido				
				
Decimal{2} ldc_desconto_f5, ldc_preco_f5

Boolean lb_aplica_prestes = True  //controle para n$$HEX1$$e300$$ENDHEX$$o aplicar desconto etiqueta se houver negocia$$HEX2$$e700e300$$ENDHEX$$o/altera$$HEX2$$e700e300$$ENDHEX$$o pre$$HEX1$$e700$$ENDHEX$$o(F5)/ ou F3
Boolean lb_Frete_disque //Usado para saber se $$HEX1$$e900$$ENDHEX$$ produto frete e disque entrega ativo.
Boolean lb_produto_exame
				
SetNull(ls_Null)				
				
ldc_desconto        					= 000.00
ldc_desconto_f5      				= 000.00
ldc_preco_f5		  				= 000.00
ldc_desconto_tabela 				= 000.00
ldc_preco_unitario  				= 000.00
ldc_calculo_desconto				= 000.00
ldc_desconto_prestes				= 000.00
ldc_desconto_padrao_melhor 	= 000.00

dw_1.Accepttext( )

ll_row = dw_1.GetRow()	 

ldc_preco_unitario   	= io_produto.Of_Preco_Venda_Filial()

If Not wf_desconto_padrao(ll_row, Ref ldc_desconto_padrao, Ref ldc_Desconto_Tabela ) Then
	Return False
End If
		  
ls_alteracao_preco     	= dw_1.object.id_alteracao_preco 		[ll_row]
ls_desconto_negociavel 	= dw_1.object.desconto_negociavel		[ll_row] //S/N
ls_tipo_alteracao_preco	= dw_1.object.id_tipo_desconto 			[ll_row]

If ls_alteracao_preco = 'S' And lb_produto_exame = True Then //n$$HEX1$$e300$$ENDHEX$$o deve ser aplicado nenhum desconto ao produto
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida a altera$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o deste produto.",Information!)
	Return False
End If

//Se for produto Frete e Manipula$$HEX2$$e700e300$$ENDHEX$$o
//Busca o valor do frete do FCerta
//If (io_produto.cd_produto = io_produto.cd_produto_frete) Then
//	Open(w_ge119_romaneio_taxa_entrega)	
//	ls_Retorno = Message.StringParm
//		
//	If Trim(gf_captura_valor(ls_retorno, '|', 1, false)) = 'OK' Then
//		ldc_preco_padrao			= Dec(Trim(gf_captura_valor(ls_retorno, '|', 2, false)))
//		ldc_preco_unitario			= Dec(Trim(gf_captura_valor(ls_retorno, '|', 2, false)))
//		ldc_desconto_padrao		= 0.00
//		ldc_desconto_padrao_melhor = 0.00
//		ls_alteracao_preco		= 'N'
//		ls_desconto_negociavel 	= 'N'
//	Else
//		Return False
//	End If	
//End If

ll_find = dw_1.find("cd_produto = " + String(io_produto.cd_produto),1, ll_row - 1)

// *****ATENCAO*****
//PRODUTO MANIPULADO, FEITO PARA PODER VENDER CORRETAMENTE MAIS DE UM MANIPULADO EM VENDA COM ALTERACAO DE PRE$$HEX1$$c700$$ENDHEX$$O
If io_produto.cd_produto = io_produto.cd_produto_manipulado and ll_find >= 1 Then
	ll_find = 0
End If	
//### TESTE venda com pre$$HEX1$$e700$$ENDHEX$$os diferentes ###
ll_find = 0

Choose Case ll_find
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find de localiza$$HEX2$$e700e300$$ENDHEX$$o de produtos.",StopSign!)
		Return False
		
	Case 0	// Produto novo na dw_1
		//
		ldc_desconto = ldc_desconto_padrao
					
		//Nas Manipulacoes e Pro-Formula busca o pre$$HEX1$$e700$$ENDHEX$$o do produto frete do parametro e nao aplica desconto
		If (gvo_Parametro.id_rede_filial = "MP" or gvo_Parametro.id_rede_filial = "PF") And &
			io_produto.cd_produto_frete = io_produto.cd_produto Then
			
			uo_parametro_filial lvo_Parametro
			lvo_Parametro = Create uo_Parametro_Filial
			lvo_Parametro.of_Localiza_Parametro('VL_TAXA_DISQUE_ENTREGA', ref ls_taxa_frete, False)				
			Destroy lvo_Parametro				
			
			//Se o parametro estiver definido corretamente e existir, usa o valor do parametro
			//senao usar$$HEX1$$e100$$ENDHEX$$ o pre$$HEX1$$e700$$ENDHEX$$o que est$$HEX1$$e100$$ENDHEX$$ no produto e sen$$HEX1$$e300$$ENDHEX$$o estiver definido para buscar o frete do Fcerta
			
			If IsNumber(ls_taxa_frete) And Dec(ls_taxa_frete) > 0 Then
				ldc_preco_frete 	= Dec(ls_taxa_frete)
				ldc_preco_unitario = ldc_preco_frete
				dw_1.Object.id_alteracao_preco   [ll_Row] = "N"
			End If							
		End If
				
		If io_Pedido.id_tipo_venda <> "TR" and io_Pedido.id_tipo_venda <> "PS" Then
			If ldc_desconto_prestes > ldc_desconto_tabela And lb_aplica_prestes = True Then
				ldc_desconto_tabela 									= ldc_desconto_prestes
				ls_alteracao_preco									= 'S'
				ls_tipo_alteracao_preco 								= 'PVE'
			End If
		End If
		
		//ldc_desconto 			= ldc_desconto_padrao
		ldc_preco_praticado 	= round(ldc_preco_unitario * ((100 - ldc_desconto) / 100), 2)	 //Preco praticado
		
		dw_1.object.vl_preco_unitario	 		[ll_row] = ldc_preco_unitario	
		dw_1.object.pc_desconto				[ll_row] = ldc_desconto
		dw_1.object.vl_preco_praticado 		[ll_row] = ldc_preco_praticado					
		dw_1.object.id_alteracao_preco 		[ll_row] = ls_alteracao_preco
		dw_1.object.pc_desconto_tabela 		[ll_row] = ldc_Desconto_Tabela //Atribui o desconto tabela/ filial / fixo 
		dw_1.object.id_tipo_desconto			[ll_row] = ls_tipo_alteracao_preco


	Case Else
		
		If ls_alteracao_preco = "S" Then
			If dw_1.object.pc_desconto[ll_row] = 0 Then
				//Tratamento para quando ocorre altera$$HEX2$$e700e300$$ENDHEX$$o por pre$$HEX1$$e700$$ENDHEX$$o e n$$HEX1$$e300$$ENDHEX$$o percentual
				ldc_preco_alterado = dw_1.object.vl_preco_unitario[ll_row]
				If ldc_preco_alterado > 0 Then
					ldc_desconto =  Round( ( ( ldc_preco_unitario - ldc_preco_alterado) / ldc_preco_unitario ) * 100 ,2)				
					dw_1.object.pc_desconto[ll_row] = ldc_desconto
				End If
			End If
			If dw_1.object.pc_desconto[ll_row] <> dw_1.object.pc_desconto[ll_find] Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel conceder descontos diferenciados para o mesmo produto.",Exclamation!)
				Return False
			End If
		End If
		
		If ls_alteracao_preco = "N" And ls_desconto_negociavel = "N" Then
			If dw_1.Object.id_alteracao_preco [ll_find] = "S" or dw_1.Object.desconto_negociavel[ll_find] = "S" Then									
				If dw_1.object.pc_desconto[ll_row] <> dw_1.object.pc_desconto[ll_find] Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel conceder descontos diferenciados para o mesmo produto.",Exclamation!)
					Return False
				End If
				ls_etiqueta = dw_1.Object.nr_etiqueta_preste[ll_find]
				If (Not IsNull(ls_etiqueta) and Trim(ls_etiqueta) <> '') Then
					//Tratamento para quando j$$HEX1$$e100$$ENDHEX$$ possui produto com etiqueta prestes
					If ldc_desconto_prestes > 0 Then //Se o produto atual tamb$$HEX1$$e900$$ENDHEX$$m for com etiqueta
						If ldc_desconto_prestes <> dw_1.object.pc_desconto_tabela[ll_find] Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel conceder descontos diferenciados para o mesmo produto.",Exclamation!)
							Return False
						End If
					Else
						If ldc_desconto_padrao <> dw_1.object.pc_desconto_tabela[ll_find] Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel conceder descontos diferenciados para o mesmo produto.",Exclamation!)
							Return False
						End If						
					End If
				End If
			End If
		End If
		
		//Etiqueta prestes selecionada com produto j$$HEX1$$e100$$ENDHEX$$ informado sem ser pela etiqueta.
		If ldc_desconto_prestes > 0 And (IsNull(ls_etiqueta) Or Trim(ls_etiqueta) = '')  Then 
			If ( ldc_desconto_prestes <> dw_1.object.pc_desconto_tabela[ll_find] ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel conceder descontos diferenciados para o mesmo produto.",Exclamation!)
				Return False
			End If
			If ( ldc_desconto_prestes <> dw_1.object.pc_desconto[ll_find] ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel conceder descontos diferenciados para o mesmo produto.",Exclamation!)
				Return False
			End If						
		End If					
		
		
		dw_1.object.id_alteracao_preco 	[ll_row] = dw_1.Object.id_alteracao_preco 		[ll_find]
		dw_1.object.desconto_negociavel	[ll_row] = dw_1.Object.desconto_negociavel	[ll_find]
		dw_1.object.vl_preco_praticado 	[ll_row] = dw_1.Object.vl_preco_praticado 		[ll_find]
		dw_1.object.vl_preco_unitario  	[ll_row] = dw_1.Object.vl_preco_unitario  		[ll_find]
		dw_1.object.pc_desconto_tabela 	[ll_row] = dw_1.Object.pc_desconto_tabela 	[ll_find]
		dw_1.object.pc_desconto       	 	[ll_row] = dw_1.Object.pc_desconto        		[ll_find]

End Choose


Return True
end function

public subroutine wf_localiza_endereco ();String lvs_Cep

Long ll_Cidade_Informada

Decimal	ldc_Vl_Frete, ldc_Frete_Calculado

dw_2.AcceptText()

lvs_Cep 					= trim(dw_2.Object.Localizacao_Endereco[1])
ll_Cidade_Informada 	= dw_2.Object.Cd_Cidade[1]

If IsNull( ll_Cidade_Informada ) Or ll_Cidade_Informada = 0 Then ll_Cidade_Informada = gvo_Parametro.Cd_Cidade

io_Endereco.ivl_Cidade_Informada = ll_Cidade_Informada

//Se o usu$$HEX1$$e100$$ENDHEX$$rio informou hifen na pesquisa o sistema retira pra fazer a consulta
lvs_Cep = gf_ge099_Remove_Hifen_Cep(lvs_Cep)
io_Endereco.of_Localiza_endereco(lvs_Cep)

If io_Endereco.Localizado Then
	dw_2.Object.id_alterar_frete [1] = 'N'
	SetNull( io_Pedido.nr_matric_alteracao_frete )

	io_Cidade.of_Localiza_Cidade(String(io_Endereco.Cd_Cidade))

	dw_2.Object.de_complemento	[1] = ''
	dw_2.Object.nr_cep				[1] = io_Endereco.nr_cep
	
	If wf_Valor_Frete(io_Endereco.nr_cep, Ref ldc_Vl_Frete, Ref ldc_Frete_Calculado) Then
		dw_2.Object.vl_frete				[1] = ldc_Vl_Frete
		dw_2.Object.vl_frete_calculado	[1] = ldc_Frete_Calculado
	Else
		dw_2.Object.vl_frete				[1] = 0.00
		dw_2.Object.vl_frete_calculado	[1] = 0.00
	End If
	
	If IsNull(io_Endereco.de_endereco) Then
		dw_2.SetTabOrder('nm_cidade', 20)
		dw_2.SetTabOrder('cd_unidade_federacao', 0)
		dw_2.SetTabOrder('de_endereco', 40)
		dw_2.SetTabOrder('nr_cep', 0)
		dw_2.SetTabOrder('nr_telefone', 50)
		dw_2.SetTabOrder('de_bairro', 60)
		dw_2.SetTabOrder('nr_endereco',70)
		dw_2.SetTabOrder('de_complemento', 80)
		
		dw_2.Modify('nm_cidade.background.color="16777215"')
		dw_2.Modify('de_endereco.background.color="16777215"')
		dw_2.Modify('de_bairro.background.color="16777215"')
		
		dw_2.Event ue_pos(1, 'nm_cidade')		
	Else
		dw_2.SetTabOrder('nm_cidade', 0)
		dw_2.SetTabOrder('cd_unidade_federacao', 0)
		dw_2.SetTabOrder('de_endereco', 0)
		dw_2.SetTabOrder('nr_cep', 0)
		dw_2.SetTabOrder('nr_telefone', 20)
		dw_2.SetTabOrder('de_bairro', 0)
		dw_2.SetTabOrder('nr_endereco', 30)
		dw_2.SetTabOrder('de_complemento', 40)
		
		dw_2.Modify('nm_cidade.background.color="67108864"')
		dw_2.Modify('de_endereco.background.color="67108864"')
		dw_2.Modify('de_bairro.background.color="67108864"')
		
		dw_2.Object.nm_cidade					[1] = io_Endereco.Nm_cidade
		dw_2.Object.cd_cidade					[1] = io_Endereco.cd_cidade
		dw_2.Object.de_endereco				[1] = io_Endereco.de_endereco
		dw_2.Object.cd_unidade_federacao	[1] = io_Endereco.cd_unidade_federacao
		dw_2.Object.de_bairro					[1] = MidA(io_Endereco.de_bairro, 1, 20)
		
		//dw_2.Event ue_pos(1, 'de_complemento')
	End If
	
	// Se o campo bairro for maior que 20 pega bairro abreviado <> ''.		
	If LenA(io_Endereco.de_bairro) > 20 Then		
		If io_Endereco.de_bairro_abreviado <> "" and Not IsNull(io_Endereco.de_bairro_abreviado) Then
			dw_2.Object.de_bairro[1] = MidA(io_Endereco.de_bairro_abreviado, 1, 20)
		End If
	End If	
	
	// Se campo endereco for > 40 pega endereco abreviado que tem 36 caracteres.
	If LenA(io_Endereco.de_endereco) > 40 Then
		dw_2.Object.de_endereco[1] = io_Endereco.de_endereco_abreviado
	End If
	
Else
	dw_2.Event ue_pos(1, 'localizacao_endereco')
End If

dw_2.Object.Localizacao_Endereco[1] = is_Texto_Endereco
dw_2.AcceptText()
end subroutine

public function boolean wf_informar_vale_desconto ();Boolean lb_contratos = False
Boolean lb_Retorno

Long ll_Linhas, ll_row, ll_Produto, ll_campanha_Vale, ll_Null

Integer li_Row

String ls_Rede
String ls_Retorno
String ls_Vale_desconto, ls_Null, ls_Cobre_Preco

Decimal ldc_Desc_Vale, ldc_desconto, ldc_preco_unitario

SetNull(ll_Null)
SetNull(ls_Null)

Choose Case io_Pedido.id_tipo_venda
	Case "TR","CR","FC","EP","VL","PS", "CV"
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o liberada para essa modalidade.",Exclamation!)
		Return False
End Choose

//If dw_1.RowCount() > 0 Then
//	If Not IsNull( dw_1.Object.cd_produto[1] )  Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O vale desconto deve ser informado antes de qualquer produto!",Exclamation!)
//		Return False			
//	End If
//End If
//
If IsNull( io_Pedido.cd_cliente ) Then
	MessageBox( "Informa$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio ter um cliente identificado." ,Exclamation! )
	Return False		
End If

//Ge039
str_cupom_desconto_pos_venda lst_parametro_Retorno

Open( w_ge039_informar_vale_desconto )

lst_parametro_Retorno = Message.powerobjectparm

If IsNull( lst_parametro_Retorno ) Then
	Return False
End If

ll_Linhas  = UpperBound( istr_cupom_desconto[] )
ll_Linhas++

istr_cupom_desconto[ ll_Linhas ].nr_campanha 		= lst_parametro_Retorno.nr_campanha
istr_cupom_desconto[ ll_Linhas ].nr_vale_desconto	= lst_parametro_Retorno.nr_vale_desconto
istr_cupom_desconto[ ll_Linhas ].pc_desconto			= lst_parametro_Retorno.pc_desconto
istr_cupom_desconto[ ll_Linhas ].de_vale_desconto	= lst_parametro_Retorno.de_vale_desconto

For li_Row = 1 To dw_1.RowCount()
	ll_Produto	 		= dw_1.Object.cd_produto		[li_Row]
	ldc_desconto 		= dw_1.Object.pc_desconto		[li_Row]  
	ls_Cobre_Preco 	= dw_1.Object.id_cobre_preco	[li_Row]  
	ldc_preco_unitario = dw_1.Object.vl_preco_unitario	[li_Row]  
	
	//io_Produto.of_Localiza_Codigo_Interno(ll_Produto)
	
	If Not This.wf_verifica_qtde_desconto_campanha_pos( ll_Produto, li_Row,  Ref ldc_Desc_Vale, Ref ll_campanha_Vale, Ref ls_Vale_desconto) Then
		Return False
	End If
	
	//Verifica se desconto vale $$HEX1$$e900$$ENDHEX$$ maior que o desconto calculado
	If ldc_Desc_Vale > ldc_desconto Then
		dw_1.Object.cd_promocao_sos		[li_Row] = ll_Null
		dw_1.Object.pc_desconto			[li_Row] = ldc_Desc_Vale
		dw_1.Object.vl_preco_praticado	[li_Row] = Round(ldc_preco_unitario * ((100 - ldc_Desc_Vale) / 100), 2)
	
		//Atribui se realmente o % desconto do vale desconto for maior que todos os demais descontos
		//Caso contrario recebe null
		dw_1.Object.nr_vale_desconto[dw_1.getRow()] = ls_Vale_Desconto
	End If
		
Next


Return True
end function

public function long wf_verifica_qtde_item_pedida (long pl_produto);Integer li_Row, li_Qtde
	  
dw_1.AcceptText()	  

li_Qtde  = 0

For li_row = 1 TO dw_1.RowCount()
	If dw_1.Object.cd_produto[li_Row] = pl_produto Then
		li_Qtde += dw_1.object.qt_pedida[ li_Row ]
	End If
Next	

Return li_Qtde



end function

public subroutine wf_alteracao_preco ();If io_Pedido.id_tipo_venda = "TR" or io_Pedido.id_tipo_venda = "PS" Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o liberada para transa$$HEX2$$e700f500$$ENDHEX$$es TRNCentre.",Exclamation!)
	Return
End If	

String  ls_matricula
String  ls_Retorno
String  ls_Grupo
String  ls_Tipo
String  ls_retorno_preco
String  ls_Tipo_preco
String	  ls_Alteracao_Preco = 'N'
String  ls_Cobre_Preco

Decimal {2} ldc_desconto, ldc_desconto_Preste
Decimal {2} ldc_preco_unitario
Decimal {2} ldc_Preco_f5, ldc_desconto_f5, ldc_preco_praticado

Long    ll_row

SetNull(ls_Grupo)

dw_1.AcceptText()

ll_row = dw_1.GetRow()

If dw_1.object.id_tipo_desconto [ll_row] <> 'N' Then
	Return
End If

ls_Cobre_Preco = dw_1.object.id_cobre_preco [ll_row] 

If ls_Cobre_Preco = 'S' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Produto negociado via Cobre Preco n$$HEX1$$e300$$ENDHEX$$o permite altera$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o.', Exclamation!)	
	Return
End If

//If (ls_tipo_alteracao_preco = 'FRT') Then 
//	If (io_produto.cd_produto <> io_produto.cd_produto_frete) And (io_produto.cd_produto <> io_produto.cd_produto_formula) Then 	
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Motivo de altera$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitido para o produto informado.",Exclamation!)
//		Return False
//	End if
//End If
	
If Not gvo_Aplicacao.ivo_seguranca.of_libera_acesso_procedimento("ALTERACAO_PRECO_VENDA",ls_matricula) Then Return

If io_Produto.of_Verifica_Promocao_Vencimento() Then	

	Open(w_ge506_selecao_promocao_vencidos)
	
	ls_Retorno = Message.StringParm
	
Else	
	ls_Retorno = "ALTERACAOPRECO"
End If

Choose Case ls_Retorno
	Case "CANCELAR" 
		Return 
		
	Case "ALTERACAOPRECO"
		
		Open(w_ge506_motivo_desconto)	

		ls_retorno_preco = Message.StringParm
		
		ls_Tipo_preco = Trim(gf_captura_valor(ls_retorno_preco, '|', 1, false))
		
		If ls_Tipo_preco = 'V' Then			
			ldc_Preco_f5    = Dec(Trim(gf_captura_valor(ls_retorno_preco, '|', 2, false)))
		Else
			ldc_desconto_f5 = Round(Dec(Trim(gf_captura_valor(ls_retorno_preco, '|', 2, false))), 2)
		End If
		ls_tipo = Trim(gf_captura_valor(ls_retorno_preco, '|', 3, false))
					
	Case Else
	
		ls_Grupo     				= MidA(Message.StringParm,1,1)			
		ldc_desconto_Preste 	= Dec(MidA(Message.StringParm,2))
		ls_Tipo      				= 'PVE'
					
End Choose

If ldc_preco_f5 > 000.00 Or ldc_desconto_f5 > 000.00 Or ldc_desconto_Preste > 000.00 Then
	
	//Compara valores j$$HEX1$$e100$$ENDHEX$$ informados na dw_1
	ldc_preco_unitario		= dw_1.object.vl_preco_unitario	[ll_row]
	ldc_desconto			= dw_1.object.pc_desconto      	[ll_row]
	ldc_preco_praticado	= dw_1.object.vl_preco_praticado [ll_row]
	
	If ldc_preco_f5 > ldc_preco_unitario Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pre$$HEX1$$e700$$ENDHEX$$o informado R$ " + String(ldc_preco_f5,"###,###,##0.00") + " n$$HEX1$$e300$$ENDHEX$$o pode ser maior que o pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio R$ " + String(ldc_preco_unitario,"###,###,##0.00") ,Exclamation!)
		Return
	End If
	
	If ldc_preco_f5 > 0 And ( ldc_preco_f5 < ldc_preco_unitario ) Then
		//Calcula o desconto que deve ser aplicado sobre o pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio, para que o 
		//pre$$HEX1$$e700$$ENDHEX$$o praticado seja igual ao pre$$HEX1$$e700$$ENDHEX$$o informado.
		ldc_desconto_f5 	=  Round( ( ( ldc_preco_unitario - ldc_preco_f5) / ldc_preco_unitario ) * 100 ,2)
	End If	
	
	If ldc_desconto_f5 > ldc_desconto Then
		ldc_desconto 			= ldc_desconto_f5
		ldc_preco_praticado 	= round(ldc_preco_unitario * ((100 - ldc_desconto) / 100), 2)	 //Preco praticado
		ls_Alteracao_Preco 	= 'S'
	End If	
	
	If ldc_desconto_Preste > ldc_desconto Then
		ldc_desconto = ldc_desconto_Preste
	End If
	
	//Verirficar esse cod.
	If Not IsNull(io_produto.cd_promocao_sos)  Then
		If ls_Tipo <> 'PVE' And ls_Tipo <> 'F5' And ls_Tipo <> 'NEG'  Then
			dw_1.Object.cd_promocao_sos[ll_row] = io_produto.cd_promocao_sos
		End If
	End If
		
	dw_1.object.id_alteracao_preco 		[ll_row] = ls_Alteracao_Preco
	dw_1.object.desconto_negociavel		[ll_row] = "N"
	dw_1.object.vl_preco_unitario  		[ll_row] = ldc_preco_unitario
	dw_1.object.pc_desconto		  		[ll_row] = ldc_desconto
	dw_1.object.vl_preco_praticado  		[ll_row] = ldc_preco_praticado
	dw_1.object.id_tipo_desconto			[ll_row] = ls_Tipo
	
	If Not IsNull(ls_Grupo) Then
		dw_1.object.cd_grupo[ll_row] = ls_Grupo
	End If	
	
	io_Pedido.nr_matric_alteracao_preco = ls_matricula

End If

Return
end subroutine

protected function boolean wf_processa_descontos_vinculados_produto (long pl_row, decimal pdc_desconto, long pl_promocao, boolean pb_somente_vinculo, long pl_produto_venda, long pl_produto_vinculo, decimal pdc_preco_unitario, string ps_tipo_inclusao, string ps_tipo_replicacao, boolean pb_cancela_item, long pl_qtd_vinculo, long pl_qtdade, long pl_codigo_desconto_progressivo);Long ll_row_inclusao
Long ll_status
Long ll_qtd_vinc
Long ll_find_promocao
Long ll_find_produto
Long ll_qtd_disp

Decimal {2} ldc_preco_desconto
Decimal {2} ldc_preco_unitario
Decimal {2} ldc_desconto_vinculo
Decimal {2} ldc_desconto_vinculo_clube
Decimal  ldc_pc_red_bc_icms_efetivo, &
			ldc_bc_icms_efetivo, &
			ldc_pc_icms_efetivo, &
			ldc_vl_icms_efetivo

Boolean lb_vinculo_na_promocao = False

If ps_tipo_replicacao = 'T' Then
	If Not pb_somente_vinculo Then	
		ll_find_produto = -1
		//Processa produto venda
		Do while ll_find_produto <> 0
			If pl_codigo_desconto_progressivo > 0 Then
				ll_find_produto  = dw_1.Find ("cd_produto = " + STRING( pl_produto_venda ) + &
															 " and cancelado <> 'S' " + &
															 " and id_alteracao_preco <> 'S'", ll_find_produto + 1 ,dw_1.RowCount())
			Else
				ll_find_produto  = dw_1.Find ("cd_produto = " + STRING( pl_produto_venda ) + &
															 " and cancelado <> 'S' and qt_usada_promocao_vinculada < qt_vendida" + &
															 " and id_alteracao_preco <> 'S'", ll_find_produto + 1 ,dw_1.RowCount())				
			End If															
			If ll_find_produto < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Altera$$HEX2$$e700e300$$ENDHEX$$o Itens tipo T.",StopSign!)
				Return False						
			ElseIf 	ll_find_produto > 0 Then			
				ldc_preco_unitario = dw_1.Object.vl_preco_unitario[ll_find_produto]
				ldc_preco_desconto   = round(ldc_preco_unitario * ((100 - pdc_desconto) / 100),2)
				If ldc_preco_desconto <= 0 Then
					ldc_preco_desconto = 0.01
				End If
				If ldc_preco_desconto >= dw_1.Object.vl_preco_praticado[ll_find_produto] Then
					Continue
				End If			
						
				If Not pdv.of_cancela_item(ll_find_produto) Then Return False								
				
				dw_1.Object.cancelado [ll_find_produto] = "S"
				dw_1.Object.nr_matricula_cancelamento_item [ll_find_produto] = '14330'	
			
				ll_row_inclusao = dw_1.RowCount()
				
				dw_1.Object.cd_filial 										[ll_row_inclusao] = dw_1.Object.cd_filial 									[ll_find_produto]
				dw_1.Object.nr_nf 										[ll_row_inclusao] = dw_1.Object.nr_nf 										[ll_find_produto]
				dw_1.Object.de_especie 								[ll_row_inclusao] = dw_1.Object.de_especie 								[ll_find_produto]
				dw_1.Object.de_serie 									[ll_row_inclusao] = dw_1.Object.de_serie 									[ll_find_produto]
				dw_1.Object.cd_produto 								[ll_row_inclusao] = dw_1.Object.cd_produto 								[ll_find_produto]			
				dw_1.Object.qt_vendida 								[ll_row_inclusao] = dw_1.Object.qt_vendida 								[ll_find_produto]
				dw_1.Object.vl_preco_unitario 						[ll_row_inclusao] = dw_1.Object.vl_preco_unitario 						[ll_find_produto]
				dw_1.Object.pc_comissao_extra 						[ll_row_inclusao] = dw_1.Object.pc_comissao_extra 					[ll_find_produto]
				dw_1.Object.pc_comissao_normal 					[ll_row_inclusao] = dw_1.Object.pc_comissao_normal 					[ll_find_produto]			
				dw_1.Object.cd_grupo 									[ll_row_inclusao] = dw_1.Object.cd_grupo 									[ll_find_produto]			
				dw_1.Object.de_produto 								[ll_row_inclusao] = dw_1.Object.de_produto 								[ll_find_produto]							
				dw_1.Object.cd_unidade_medida_venda 			[ll_row_inclusao] = dw_1.Object.cd_unidade_medida_venda 			[ll_find_produto]								
				dw_1.Object.id_restricao_convenio 					[ll_row_inclusao] = dw_1.Object.id_restricao_convenio 					[ll_find_produto]
				dw_1.Object.preco_produto_item_ja_alterado		[ll_row_inclusao] = dw_1.Object.preco_produto_item_ja_alterado 	[ll_find_produto]
				dw_1.Object.vl_preco_praticado 						[ll_row_inclusao] = ldc_preco_desconto	
				dw_1.Object.id_alteracao_desconto 					[ll_row_inclusao] = dw_1.Object.id_alteracao_desconto 				[ll_find_produto]
				dw_1.Object.id_desconto_produto_ja_concedido	[ll_row_inclusao] = dw_1.Object.id_desconto_produto_ja_concedido	[ll_find_produto]
				dw_1.Object.vl_preco_tabela 							[ll_row_inclusao] = ldc_preco_desconto//dw_1.Object.vl_preco_tabela 							[ll_find_produto]
				dw_1.Object.pc_desconto_tabela 						[ll_row_inclusao] = pdc_desconto
				dw_1.Object.pc_desconto_padrao 					[ll_row_inclusao] = dw_1.Object.pc_desconto_padrao 					[ll_find_produto]
				dw_1.Object.cd_promocao_sos 						[ll_row_inclusao] = pl_promocao
				dw_1.Object.nr_lote_prestes 							[ll_row_inclusao] = dw_1.Object.nr_lote_prestes 							[ll_find_produto]								
				dw_1.Object.nr_mes_vencimento 						[ll_row_inclusao] = dw_1.Object.nr_mes_vencimento 					[ll_find_produto]
				dw_1.Object.nr_ano_vencimento 						[ll_row_inclusao] = dw_1.Object.nr_ano_vencimento 					[ll_find_produto]
				dw_1.Object.id_modo_venda 							[ll_row_inclusao] = dw_1.Object.id_modo_venda 							[ll_find_produto]
				dw_1.Object.nr_etiqueta_preste 						[ll_row_inclusao] = dw_1.Object.nr_etiqueta_preste 						[ll_find_produto]
				dw_1.Object.id_usado_promocao_vinculada 		[ll_row_inclusao] = 'S'
				If pl_codigo_desconto_progressivo > 0 Then
					dw_1.Object.qt_usada_promocao_vinculada 	[ll_row_inclusao] = 0
				Else
					dw_1.Object.qt_usada_promocao_vinculada 	[ll_row_inclusao] = dw_1.Object.qt_vendida 								[ll_find_produto]
				End If
				//dw_1.Object.id_tipo_alteracao_preco					[ll_row_inclusao] = dw_1.Object.id_tipo_alteracao_preco				[ll_find_produto]	
				dw_1.Object.desconto_negociavel						[ll_row_inclusao] = dw_1.Object.desconto_negociavel					[ll_find_produto]			
				dw_1.Object.nr_campanha	 							[ll_row_inclusao] = dw_1.Object.nr_campanha 							[ll_find_produto]
				dw_1.Object.cd_tipo_icms								[ll_row_inclusao] = dw_1.Object.cd_tipo_icms								[ll_find_produto]				
				dw_1.Object.cd_beneficio								[ll_row_inclusao] = dw_1.Object.cd_beneficio								[ll_find_produto]										
				dw_1.Object.cd_tributacao_icms						[ll_row_inclusao] = dw_1.Object.cd_tributacao_icms						[ll_find_produto]										
								
//				ll_status = pdv_imprime_item(ll_row_inclusao)
							
			End If
		Loop	
		
		//Altera infroma$$HEX2$$e700e300$$ENDHEX$$o no produto vinculo, se o vinculo n$$HEX1$$e300$$ENDHEX$$o for produto de venda da promocao
		Select pc_desconto, pc_desconto_clube Into :ldc_desconto_vinculo, :ldc_desconto_vinculo_clube
		From promocao_sos_produto
		Where cd_promocao_sos = :pl_promocao
		and cd_produto = :pl_produto_vinculo
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				lb_vinculo_na_promocao = true			
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o para produto Vinculo." + SqlCa.SqlErrText, StopSign!)
				Return False
		End Choose
		
		If Not lb_vinculo_na_promocao Then	
			ll_find_promocao = 0			
			ll_find_promocao  = dw_1.Find ("cd_produto = " + STRING( pl_produto_vinculo ) + &
														 " and cancelado <> 'S' and id_usado_promocao_vinculada <> 'S'" + &
														 " and qt_usada_promocao_vinculada < qt_vendida", ll_find_promocao + 1 ,dw_1.RowCount())			
			If ll_find_promocao < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Remo$$HEX2$$e700e300$$ENDHEX$$o vinculos.",StopSign!)
				Return False						
			ElseIf 	ll_find_promocao > 0 Then
				dw_1.Object.id_usado_promocao_vinculada [ll_find_promocao] = 'S'
			End If		
		End If
	Else
		//Verifica se produto vinculo tamb$$HEX1$$e900$$ENDHEX$$m est$$HEX1$$e100$$ENDHEX$$ na promo$$HEX2$$e700e300$$ENDHEX$$o como produto venda, se estiver aplica o desconto em todos os produtos vinculo da venda tamb$$HEX1$$e900$$ENDHEX$$m e marca como usado.			
		lb_vinculo_na_promocao = False
		
		Select pc_desconto, pc_desconto_clube Into :ldc_desconto_vinculo, :ldc_desconto_vinculo_clube
		From promocao_sos_produto
		Where cd_promocao_sos = :pl_promocao
		and cd_produto = :pl_produto_vinculo
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				lb_vinculo_na_promocao = true
				ll_find_produto = -1
				Do while ll_find_produto <> 0
					ll_find_produto  = dw_1.Find ("cd_produto = " + STRING( pl_produto_vinculo ) + &
																 " and cancelado <> 'S' and qt_usada_promocao_vinculada < qt_vendida" + &
																 " and id_alteracao_preco <> 'S'", ll_find_produto + 1 ,dw_1.RowCount())			
					If ll_find_produto < 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Altera$$HEX2$$e700e300$$ENDHEX$$o Itens tipo T vinculo.",StopSign!)
						Return False						
					ElseIf 	ll_find_produto > 0 Then			
						ldc_preco_unitario = dw_1.Object.vl_preco_unitario[ll_find_produto]
						ldc_preco_desconto   = round(ldc_preco_unitario * ((100 - pdc_desconto) / 100),2)
						If ldc_preco_desconto <= 0 Then
							ldc_preco_desconto = 0.01
						End If
						If ldc_preco_desconto >= dw_1.Object.vl_preco_praticado[ll_find_produto] Then
							Continue
						End If			
								
						If Not pdv.of_cancela_item(ll_find_produto) Then Return False								
						dw_1.Object.cancelado [ll_find_produto] = "S"
						dw_1.Object.nr_matricula_cancelamento_item [ll_find_produto] = '14330'	
					
						ll_row_inclusao = dw_1.RowCount()
						
						dw_1.Object.cd_filial 										[ll_row_inclusao] = dw_1.Object.cd_filial 									[ll_find_produto]
						dw_1.Object.nr_nf 										[ll_row_inclusao] = dw_1.Object.nr_nf 										[ll_find_produto]
						dw_1.Object.de_especie 								[ll_row_inclusao] = dw_1.Object.de_especie 								[ll_find_produto]
						dw_1.Object.de_serie 									[ll_row_inclusao] = dw_1.Object.de_serie 									[ll_find_produto]
						dw_1.Object.cd_natureza_operacao 					[ll_row_inclusao] = dw_1.Object.cd_natureza_operacao 				[ll_find_produto]								
						dw_1.Object.cd_produto 								[ll_row_inclusao] = dw_1.Object.cd_produto 								[ll_find_produto]
						dw_1.Object.cd_situacao_tributaria 					[ll_row_inclusao] = dw_1.Object.cd_situacao_tributaria 					[ll_find_produto]
						dw_1.Object.qt_vendida 									[ll_row_inclusao] = dw_1.Object.qt_vendida 								[ll_find_produto]
						dw_1.Object.vl_preco_unitario 							[ll_row_inclusao] = dw_1.Object.vl_preco_unitario 						[ll_find_produto]
						dw_1.Object.pc_icms 									[ll_row_inclusao] = dw_1.Object.pc_icms 									[ll_find_produto]								
						dw_1.Object.pc_comissao_extra 						[ll_row_inclusao] = dw_1.Object.pc_comissao_extra 					[ll_find_produto]
						dw_1.Object.pc_comissao_normal 					[ll_row_inclusao] = dw_1.Object.pc_comissao_normal 					[ll_find_produto]
						dw_1.Object.qt_pontos_clube 							[ll_row_inclusao] = dw_1.Object.qt_pontos_clube 						[ll_find_produto]
						dw_1.Object.cd_grupo 									[ll_row_inclusao] = dw_1.Object.cd_grupo 									[ll_find_produto]
						dw_1.Object.cd_grupo_produto 						[ll_row_inclusao] = dw_1.Object.cd_grupo_produto 						[ll_find_produto]
						dw_1.Object.de_produto 								[ll_row_inclusao] = dw_1.Object.de_produto 								[ll_find_produto]								
						dw_1.Object.de_apresentacao_venda 				[ll_row_inclusao] = dw_1.Object.de_apresentacao_venda 				[ll_find_produto]
						dw_1.Object.cd_unidade_medida_venda 			[ll_row_inclusao] = dw_1.Object.cd_unidade_medida_venda 			[ll_find_produto]								
						dw_1.Object.id_restricao_convenio 					[ll_row_inclusao] = dw_1.Object.id_restricao_convenio 					[ll_find_produto]
						dw_1.Object.de_produto_apresentacao_venda		[ll_row_inclusao] = dw_1.Object.de_produto_apresentacao_venda 	[ll_find_produto]
						dw_1.Object.de_codigo_barras 						[ll_row_inclusao] = dw_1.Object.de_codigo_barras 						[ll_find_produto]								
						dw_1.Object.preco_produto_item_ja_alterado		[ll_row_inclusao] = dw_1.Object.preco_produto_item_ja_alterado 	[ll_find_produto]
						dw_1.Object.vl_preco_praticado 						[ll_row_inclusao] = ldc_preco_desconto	
						dw_1.Object.id_comissionado 							[ll_row_inclusao] = dw_1.Object.id_comissionado 						[ll_find_produto]								
						dw_1.Object.cd_grupo_psico 							[ll_row_inclusao] = dw_1.Object.cd_grupo_psico 							[ll_find_produto]								
						dw_1.Object.cd_subcategoria 							[ll_row_inclusao] = dw_1.Object.cd_subcategoria 						[ll_find_produto]																
						dw_1.Object.id_preco_contrato 						[ll_row_inclusao] = dw_1.Object.id_preco_contrato 						[ll_find_produto]
						dw_1.Object.id_alteracao_desconto 					[ll_row_inclusao] = dw_1.Object.id_alteracao_desconto 				[ll_find_produto]
						dw_1.Object.id_desconto_produto_ja_concedido	[ll_row_inclusao] = dw_1.Object.id_desconto_produto_ja_concedido	[ll_find_produto]
						dw_1.Object.vl_preco_tabela 							[ll_row_inclusao] = ldc_preco_desconto//dw_1.Object.vl_preco_tabela 							[ll_find_produto]
						dw_1.Object.vl_preco_venda_maximo 				[ll_row_inclusao] = dw_1.Object.vl_preco_venda_maximo 				[ll_find_produto]
						dw_1.Object.pc_desconto_tabela 						[ll_row_inclusao] = pdc_desconto
						dw_1.Object.pc_desconto_padrao 					[ll_row_inclusao] = dw_1.Object.pc_desconto_padrao 					[ll_find_produto]
						dw_1.Object.vl_ponto_clube 							[ll_row_inclusao] = dw_1.Object.vl_ponto_clube 							[ll_find_produto]
						dw_1.Object.qt_pontuacao_parcelado 				[ll_row_inclusao] = dw_1.Object.qt_pontuacao_parcelado 				[ll_find_produto]
						dw_1.Object.qt_pontuacao_avista 					[ll_row_inclusao] = dw_1.Object.qt_pontuacao_avista 					[ll_find_produto]								
						dw_1.Object.nr_nsr_receita 							[ll_row_inclusao] = dw_1.Object.nr_nsr_receita 							[ll_find_produto]
						dw_1.Object.cd_uf_prescritor 							[ll_row_inclusao] = dw_1.Object.cd_uf_prescritor 						[ll_find_produto]								
						dw_1.Object.nr_registro_prescritor 					[ll_row_inclusao] = dw_1.Object.nr_registro_prescritor 					[ll_find_produto]	
						dw_1.Object.id_registro_prescritor 					[ll_row_inclusao] = dw_1.Object.id_registro_prescritor 					[ll_find_produto]									
						dw_1.Object.id_produto_substituido 					[ll_row_inclusao] = dw_1.Object.id_produto_substituido 				[ll_find_produto]
						dw_1.Object.vl_fator_conversao 						[ll_row_inclusao] = dw_1.Object.vl_fator_conversao 						[ll_find_produto]
						dw_1.Object.pc_imposto_cupom 						[ll_row_inclusao] = dw_1.Object.pc_imposto_cupom 					[ll_find_produto]
						dw_1.Object.cd_promocao_sos 						[ll_row_inclusao] = pl_promocao
						dw_1.Object.nr_lote_prestes 							[ll_row_inclusao] = dw_1.Object.nr_lote_prestes 							[ll_find_produto]								
						dw_1.Object.nr_mes_vencimento 						[ll_row_inclusao] = dw_1.Object.nr_mes_vencimento 					[ll_find_produto]
						dw_1.Object.nr_ano_vencimento 						[ll_row_inclusao] = dw_1.Object.nr_ano_vencimento 					[ll_find_produto]
						dw_1.Object.cd_cst_origem 							[ll_row_inclusao] = dw_1.Object.cd_cst_origem 							[ll_find_produto]
						dw_1.Object.cd_cst_tributacao 						[ll_row_inclusao] = dw_1.Object.cd_cst_tributacao 						[ll_find_produto]
						dw_1.Object.nr_classificacao_fiscal 					[ll_row_inclusao] = dw_1.Object.nr_classificacao_fiscal 					[ll_find_produto]
						dw_1.Object.id_pis_cofins 								[ll_row_inclusao] = dw_1.Object.id_pis_cofins 							[ll_find_produto]								
						dw_1.Object.dh_prescricao 							[ll_row_inclusao] = dw_1.Object.dh_prescricao 							[ll_find_produto]								
						dw_1.Object.id_uso_prolongado 						[ll_row_inclusao] = dw_1.Object.id_uso_prolongado 						[ll_find_produto]
						dw_1.Object.id_modo_venda 							[ll_row_inclusao] = dw_1.Object.id_modo_venda 							[ll_find_produto]
						dw_1.Object.nr_etiqueta_preste 						[ll_row_inclusao] = dw_1.Object.nr_etiqueta_preste 						[ll_find_produto]
						dw_1.Object.nr_sequencial 								[ll_row_inclusao] = ll_row_inclusao
						dw_1.Object.cd_cest 										[ll_row_inclusao] = dw_1.Object.cd_cest 									[ll_find_produto]
						dw_1.Object.id_usado_promocao_vinculada 		[ll_row_inclusao] = 'S'
						dw_1.Object.qt_usada_promocao_vinculada 		[ll_row_inclusao] = dw_1.Object.qt_vendida 								[ll_find_produto]
						//dw_1.Object.id_tipo_alteracao_preco					[ll_row_inclusao] = dw_1.Object.id_tipo_alteracao_preco				[ll_find_produto]	
						dw_1.Object.desconto_negociavel						[ll_row_inclusao] = dw_1.Object.desconto_negociavel					[ll_find_produto]			
						dw_1.Object.nr_campanha	 							[ll_row_inclusao] = dw_1.Object.nr_campanha 							[ll_find_produto]								
						dw_1.Object.cd_tipo_icms								[ll_row_inclusao] = dw_1.Object.cd_tipo_icms								[ll_find_produto]												
						
						dw_1.Object.cd_beneficio								[ll_row_inclusao] = dw_1.Object.cd_beneficio								[ll_find_produto]										
						dw_1.Object.cd_tributacao_icms						[ll_row_inclusao] = dw_1.Object.cd_tributacao_icms						[ll_find_produto]										
						
//						ll_status = pdv_imprime_item(ll_row_inclusao)
						
					End If
				Loop
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o para produto Vinculo." + SqlCa.SqlErrText, StopSign!)
				Return False
		End Choose
		
		If Not lb_vinculo_na_promocao Then	
			//Processa somente vinculo
			ll_find_promocao  = dw_1.Find ("cd_produto = " + STRING( pl_produto_vinculo ) + &
														 " and cancelado <> 'S' and id_usado_promocao_vinculada <> 'S'" + &
														 " and qt_usada_promocao_vinculada < qt_vendida", ll_find_promocao + 1 ,dw_1.RowCount())			
			If ll_find_promocao < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Remo$$HEX2$$e700e300$$ENDHEX$$o vinculos.",StopSign!)
				Return False						
			ElseIf 	ll_find_promocao > 0 Then
				dw_1.Object.id_usado_promocao_vinculada [ll_find_promocao] = 'S'
			End If			
		End If
	End If			
Else	
	If pb_cancela_item Then
		If dw_1.Object.cancelado [pl_row] = 'S' Then
			Return True
		End If
		
		If Not pdv.of_cancela_item(pl_row) Then Return False								
		dw_1.Object.cancelado [pl_row] = "S"
		dw_1.Object.nr_matricula_cancelamento_item [pl_row] = '14330'
	End If
	
	ll_row_inclusao = dw_1.RowCount()
	
	dw_1.Object.cd_filial 										[ll_row_inclusao] = dw_1.Object.cd_filial 									[pl_row]
	dw_1.Object.nr_nf 										[ll_row_inclusao] = dw_1.Object.nr_nf 										[pl_row]
	dw_1.Object.de_especie 								[ll_row_inclusao] = dw_1.Object.de_especie 								[pl_row]
	dw_1.Object.de_serie 									[ll_row_inclusao] = dw_1.Object.de_serie 									[pl_row]
	dw_1.Object.cd_natureza_operacao 					[ll_row_inclusao] = dw_1.Object.cd_natureza_operacao 				[pl_row]								
	dw_1.Object.cd_produto 								[ll_row_inclusao] = dw_1.Object.cd_produto 								[pl_row]
	dw_1.Object.cd_situacao_tributaria 					[ll_row_inclusao] = dw_1.Object.cd_situacao_tributaria 					[pl_row]
	dw_1.Object.qt_vendida 								[ll_row_inclusao] = pl_qtdade
	dw_1.Object.vl_preco_unitario 						[ll_row_inclusao] = dw_1.Object.vl_preco_unitario 						[pl_row]
	dw_1.Object.pc_icms 									[ll_row_inclusao] = dw_1.Object.pc_icms 									[pl_row]								
	dw_1.Object.pc_comissao_extra 						[ll_row_inclusao] = dw_1.Object.pc_comissao_extra 					[pl_row]
	dw_1.Object.pc_comissao_normal 					[ll_row_inclusao] = dw_1.Object.pc_comissao_normal 					[pl_row]
	dw_1.Object.qt_pontos_clube 							[ll_row_inclusao] = dw_1.Object.qt_pontos_clube 						[pl_row]
	dw_1.Object.cd_grupo 									[ll_row_inclusao] = dw_1.Object.cd_grupo 									[pl_row]
	dw_1.Object.cd_grupo_produto 						[ll_row_inclusao] = dw_1.Object.cd_grupo_produto 						[pl_row]
	dw_1.Object.de_produto 								[ll_row_inclusao] = dw_1.Object.de_produto 								[pl_row]								
	dw_1.Object.de_apresentacao_venda 				[ll_row_inclusao] = dw_1.Object.de_apresentacao_venda 				[pl_row]
	dw_1.Object.cd_unidade_medida_venda 			[ll_row_inclusao] = dw_1.Object.cd_unidade_medida_venda 			[pl_row]								
	dw_1.Object.id_restricao_convenio 					[ll_row_inclusao] = dw_1.Object.id_restricao_convenio 					[pl_row]
	dw_1.Object.de_produto_apresentacao_venda		[ll_row_inclusao] = dw_1.Object.de_produto_apresentacao_venda 	[pl_row]
	dw_1.Object.de_codigo_barras 						[ll_row_inclusao] = dw_1.Object.de_codigo_barras 						[pl_row]								
	dw_1.Object.preco_produto_item_ja_alterado		[ll_row_inclusao] = dw_1.Object.preco_produto_item_ja_alterado 	[pl_row]
	If ps_tipo_inclusao = 'V' Then
		ldc_preco_desconto   = round(pdc_preco_unitario * ((100 - pdc_desconto) / 100),2)
		If ldc_preco_desconto <= 0 Then
			ldc_preco_desconto = 0.01
		End If
		dw_1.Object.vl_preco_praticado 					[ll_row_inclusao] = ldc_preco_desconto
	Else
		dw_1.Object.vl_preco_praticado 					[ll_row_inclusao] = dw_1.Object.vl_preco_praticado						[pl_row]
	End If
	dw_1.Object.id_comissionado 							[ll_row_inclusao] = dw_1.Object.id_comissionado 						[pl_row]								
	dw_1.Object.cd_grupo_psico 							[ll_row_inclusao] = dw_1.Object.cd_grupo_psico 							[pl_row]								
	dw_1.Object.cd_subcategoria 							[ll_row_inclusao] = dw_1.Object.cd_subcategoria 						[pl_row]																
	dw_1.Object.id_preco_contrato 						[ll_row_inclusao] = dw_1.Object.id_preco_contrato 						[pl_row]
	dw_1.Object.id_alteracao_desconto 					[ll_row_inclusao] = dw_1.Object.id_alteracao_desconto 				[pl_row]
	dw_1.Object.id_desconto_produto_ja_concedido	[ll_row_inclusao] = dw_1.Object.id_desconto_produto_ja_concedido	[pl_row]
	If ps_tipo_inclusao = 'V' Then		
		dw_1.Object.vl_preco_tabela 						[ll_row_inclusao] = ldc_preco_desconto
	Else
		dw_1.Object.vl_preco_tabela 						[ll_row_inclusao] = dw_1.Object.vl_preco_tabela 							[pl_row]		
	End If
	dw_1.Object.vl_preco_venda_maximo 				[ll_row_inclusao] = dw_1.Object.vl_preco_venda_maximo 				[pl_row]
	If ps_tipo_inclusao = 'V' Then
		dw_1.Object.pc_desconto_tabela 					[ll_row_inclusao] = pdc_desconto
	Else
		dw_1.Object.pc_desconto_tabela 					[ll_row_inclusao] = dw_1.Object.pc_desconto_tabela 					[pl_row]
	End If
	dw_1.Object.pc_desconto_padrao 					[ll_row_inclusao] = dw_1.Object.pc_desconto_padrao 					[pl_row]
	dw_1.Object.vl_ponto_clube 							[ll_row_inclusao] = dw_1.Object.vl_ponto_clube 							[pl_row]
	dw_1.Object.qt_pontuacao_parcelado 				[ll_row_inclusao] = dw_1.Object.qt_pontuacao_parcelado 				[pl_row]
	dw_1.Object.qt_pontuacao_avista 					[ll_row_inclusao] = dw_1.Object.qt_pontuacao_avista 					[pl_row]								
	dw_1.Object.nr_nsr_receita 							[ll_row_inclusao] = dw_1.Object.nr_nsr_receita 							[pl_row]
	dw_1.Object.cd_uf_prescritor 							[ll_row_inclusao] = dw_1.Object.cd_uf_prescritor 						[pl_row]								
	dw_1.Object.nr_registro_prescritor 					[ll_row_inclusao] = dw_1.Object.nr_registro_prescritor 					[pl_row]	
	dw_1.Object.id_registro_prescritor 					[ll_row_inclusao] = dw_1.Object.id_registro_prescritor 					[pl_row]									
	dw_1.Object.id_produto_substituido 					[ll_row_inclusao] = dw_1.Object.id_produto_substituido 				[pl_row]
	dw_1.Object.vl_fator_conversao 						[ll_row_inclusao] = dw_1.Object.vl_fator_conversao 						[pl_row]
	dw_1.Object.pc_imposto_cupom 						[ll_row_inclusao] = dw_1.Object.pc_imposto_cupom 					[pl_row]
	If ps_tipo_inclusao = 'V' Then
		dw_1.Object.cd_promocao_sos 					[ll_row_inclusao] = pl_promocao
	Else
		dw_1.Object.cd_promocao_sos 					[ll_row_inclusao] = dw_1.Object.cd_promocao_sos 						[pl_row]
	End If	
	dw_1.Object.nr_campanha	 							[ll_row_inclusao] = dw_1.Object.nr_campanha 							[pl_row]
	dw_1.Object.nr_lote_prestes 							[ll_row_inclusao] = dw_1.Object.nr_lote_prestes 							[pl_row]
	dw_1.Object.nr_mes_vencimento 						[ll_row_inclusao] = dw_1.Object.nr_mes_vencimento 					[pl_row]
	dw_1.Object.nr_ano_vencimento 						[ll_row_inclusao] = dw_1.Object.nr_ano_vencimento 					[pl_row]
	dw_1.Object.cd_cst_origem 							[ll_row_inclusao] = dw_1.Object.cd_cst_origem 							[pl_row]
	dw_1.Object.cd_cst_tributacao 						[ll_row_inclusao] = dw_1.Object.cd_cst_tributacao 						[pl_row]
	dw_1.Object.nr_classificacao_fiscal 					[ll_row_inclusao] = dw_1.Object.nr_classificacao_fiscal 					[pl_row]
	dw_1.Object.id_pis_cofins 								[ll_row_inclusao] = dw_1.Object.id_pis_cofins 							[pl_row]								
	dw_1.Object.dh_prescricao 							[ll_row_inclusao] = dw_1.Object.dh_prescricao 							[pl_row]								
	dw_1.Object.id_uso_prolongado 						[ll_row_inclusao] = dw_1.Object.id_uso_prolongado 						[pl_row]
	dw_1.Object.id_modo_venda 							[ll_row_inclusao] = dw_1.Object.id_modo_venda 							[pl_row]
	dw_1.Object.nr_etiqueta_preste 						[ll_row_inclusao] = dw_1.Object.nr_etiqueta_preste 						[pl_row]
	dw_1.Object.nr_sequencial 								[ll_row_inclusao] = ll_row_inclusao
	dw_1.Object.cd_cest 										[ll_row_inclusao] = dw_1.Object.cd_cest 									[pl_row]
	dw_1.Object.desconto_negociavel						[ll_row_inclusao] = dw_1.Object.desconto_negociavel					[pl_row]			
	If ps_tipo_inclusao = 'V' Then	
		dw_1.Object.id_usado_promocao_vinculada 	[ll_row_inclusao] = 'S'
		dw_1.Object.qt_usada_promocao_vinculada 	[ll_row_inclusao] = pl_qtdade
	Else
		dw_1.Object.id_tipo_alteracao_preco				[ll_row_inclusao] = dw_1.Object.id_tipo_alteracao_preco				[pl_row]			
		dw_1.Object.id_alteracao_preco					[ll_row_inclusao] = dw_1.Object.id_alteracao_preco						[pl_row]
		dw_1.Object.pc_desconto							[ll_row_inclusao] = dw_1.Object.pc_desconto								[pl_row]		
		dw_1.Object.id_usado_promocao_vinculada 	[ll_row_inclusao] = 'N'
		dw_1.Object.qt_usada_promocao_vinculada 	[ll_row_inclusao] = dw_1.Object.qt_usada_promocao_vinculada 		[pl_row]
		dw_1.Object.cd_convenio_saude				 	[ll_row_inclusao] = dw_1.Object.cd_convenio_saude				 		[pl_row]
		dw_1.Object.nr_contrato							[ll_row_inclusao] = dw_1.Object.nr_contrato								[pl_row]				
	End If
	dw_1.Object.cd_tipo_icms								[ll_row_inclusao] = dw_1.Object.cd_tipo_icms								[pl_row]
	
	dw_1.Object.cd_beneficio								[ll_row_inclusao] = dw_1.Object.cd_beneficio								[pl_row]										
	dw_1.Object.cd_tributacao_icms						[ll_row_inclusao] = dw_1.Object.cd_tributacao_icms						[pl_row]										
	
//	ll_status = pdv_imprime_item(ll_row_inclusao)
		
	If ps_tipo_inclusao = 'V' Then
		//Altera informa$$HEX2$$e700e300$$ENDHEX$$o de uso em promo$$HEX2$$e700e300$$ENDHEX$$o nos produtos vinculos
		ll_qtd_vinc = pl_qtd_vinculo
		ll_find_promocao = 0
		Do while ll_qtd_vinc > 0
			ll_find_promocao  = dw_1.Find ("cd_produto = " + STRING( pl_produto_vinculo ) + &
														 " and cancelado <> 'S' and qt_usada_promocao_vinculada < qt_vendida", ll_find_promocao + 1 ,dw_1.RowCount())			
			If ll_find_promocao < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Remo$$HEX2$$e700e300$$ENDHEX$$o vinculos.",StopSign!)
				Return False						
			ElseIf 	ll_find_promocao > 0 Then
				ll_qtd_disp = dw_1.Object.qt_vendida[ll_find_promocao] - dw_1.Object.qt_usada_promocao_vinculada[ll_find_promocao]								
				If ll_qtd_disp >= ll_qtd_vinc Then
					dw_1.Object.id_usado_promocao_vinculada [ll_find_promocao] = 'S'
					dw_1.Object.qt_usada_promocao_vinculada [ll_find_promocao] = dw_1.Object.qt_usada_promocao_vinculada [ll_find_promocao] + ll_qtd_vinc
					ll_qtd_vinc = 0
				Else
					dw_1.Object.id_usado_promocao_vinculada [ll_find_promocao] = 'S'									
					dw_1.Object.qt_usada_promocao_vinculada [ll_find_promocao] = dw_1.Object.qt_usada_promocao_vinculada [ll_find_promocao] + ll_qtd_disp
					ll_qtd_vinc = ll_qtd_vinc - ll_qtd_disp 
				End If
			ElseIf ll_find_promocao = 0 Then
				ll_qtd_vinc = 0				
			End If
		Loop	
	End If
End If

Return True
end function

public function boolean wf_processa_descontos_vinculados (long al_produto);Long ll_row
Long ll_row_promocao
Long ll_linhas
Long ll_find_produto
Long ll_find_atendida
Long ll_produto_venda
Long ll_promocao
Long ll_qtd_vendida
Long ll_qtd_vendida_vinculo
Long ll_nr_vinculo
Long ll_linha_excluir
Long ll_pos
Long ll_find_promocao
Long ll_row_atendidas
Long ll_promocao_anterior
Long ll_seq_melhor_promocao
Long ll_cod_melhor_promocao
Long ll_qtd_vinc
Long ll_qtd_disp
Long ll_dif_qtdade
Long ll_qtd_vinculo_t
Long ll_vinculo_anterior
long ll_linha_nova
long ll_qtd_acumulado = 0
long ll_qtd_vinculo_find
long ll_row_vinculo
long ll_promocao_nao_atendida
long ll_vinculo_nao_atendido
long ll_qtd_usada_outro_produto
//
Long ll_Linhas_promocao
Long ll_Row_Vinculos
Long ll_Promocao_Sos

String ls_Tipo_Replicacao


String ls_tipo_anterior

Decimal {2} ldc_desconto_promocao
Decimal {2} ldc_preco_desconto
Decimal {2} ldc_preco_unitario
Decimal {2} ldc_seq_desconto
Decimal {2} ldc_melhor_desconto
Decimal {2} ldc_desc_atual

Boolean lb_pulo
Boolean lb_clube = False
Boolean lb_incluir = False
Boolean lb_vinculo_T_atendido = False
Boolean lb_mesmo_promo_vinculo = False
Boolean lb_vinculo_atendido = True


Choose Case io_pedido.id_tipo_venda
	Case "TR","FC","EP","VL","PS"
		//Vendas PBM n$$HEX1$$e300$$ENDHEX$$o dispara o processo vinculado.
		Return True
End Choose

Try

	If Not IsNull(io_Pedido.cd_cliente) Then
		lb_clube = True
	End If
	
	//Lista das promocoes atendidas
	dc_uo_ds_base lvds_promocoes_atendidas
	lvds_promocoes_atendidas = Create dc_uo_ds_base		
	lvds_promocoes_atendidas.of_ChangeDataObject("ds_ge498_promocoes_produto")
	
	//Lista com todas as possiveis promocoes para o produto vendido
	dc_uo_ds_Base lvds_promocao
	lvds_promocao = Create dc_uo_ds_Base
	If Not lvds_promocao.of_ChangeDataObject("ds_ge498_promocoes_produto") Then
		Destroy(lvds_promocao)
		Return False
	End If
	
	//Lista com todas as possiveis promocoes para o produto vendido
	dc_uo_ds_Base lvds_promocao_Vinculo
	lvds_promocao_Vinculo = Create dc_uo_ds_Base
	If Not lvds_promocao_Vinculo.of_ChangeDataObject("ds_ge498_promocao_vinculo") Then
		Destroy(lvds_promocao_Vinculo)
		Return False
	End If
	
	ll_Linhas_promocao = lvds_promocao.Retrieve( al_Produto )
	
	Choose Case ll_Linhas_Promocao
		Case Is < 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve ds_ge498_promocoes_produto. Produto: " +String(al_Produto) )
			Return False
		Case 0 
			Return True
	End Choose
	
	ll_qtd_vendida = wf_Verifica_qtde_item_pedida( al_produto )
	
	//Varre dw_1 
	DO 
		ll_Find_Promocao = lvds_promocao.Find("cd_produto_venda",1, lvds_promocao.RowCount() )
		
		Choose Case ll_Find_Promocao
			Case is < 0 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Find lvds_promocao.")
			Case 0 
				Continue
		End Choose
		
		ls_Tipo_Replicacao 	= lvds_promocao.Object.id_tipo_replicacao[ ll_Find_Promocao ]
		ll_Promocao_Sos		= lvds_promocao.Object.cd_promocao_sos[ ll_Find_Promocao ]
		
		ll_Row_Vinculos = lvds_promocao_Vinculo.Retrieve( ll_Promocao_Sos )
		
		For ll_Row_Vinculos = 1 To ll_Row_Vinculos
		
		
		
		Next
		
		
		
		
		
	LOOP WHILE ll_Row <= dw_1.RowCount()	 //Varre dw_1 
	
			
	Return True
	
Finally
	If IsValid(lvds_promocao) 					Then Destroy(lvds_promocao)
	If IsValid(lvds_promocoes_atendidas) 	Then Destroy(lvds_promocoes_atendidas)
End Try
end function

public function boolean wf_verifica_qt_vinculo ();
Return False
end function

public subroutine wf_localiza_manipulado ();//		//Verifica$$HEX2$$e700e300$$ENDHEX$$o de manipulados vendidos pelo Funcional Card
//		If ivo_venda.id_tipo_venda = 'FC' Then			
//			OpenWithParm (w_cl014_registro_produto_manipulado, ivo_venda.ivo_Pedido.nr_pedido_drogaexpress)
//			
//			ls_Manipulado = Message.StringParm
//			
//			If Not IsNull(ls_Manipulado) Then
//				
////				li_Retorno = wf_existe_registro_manipulado(MidA(ls_Manipulado,1,10))
//				
//				If li_Retorno = -1 Then
////					dw_1.Event ClearRow(ll_Row)
//					Return False
//				ElseIf li_Retorno > 0 Then 
//					Continue
//				End If				
//					
//				dw_1.Object.nr_registro_manipulado        	[ll_row] = Long(MidA(ls_Manipulado,1,10))
//				//***Parte referente a dll FCerta***
//				dw_1.Object.vl_bruto_req_manip		      		[ll_row] = Dec(MidA(ls_Manipulado,31,10))
//				dw_1.Object.vl_desc_req_manip		      		[ll_row] = Dec(MidA(ls_Manipulado,41,10))
//				dw_1.Object.vl_liq_req_manip		      			[ll_row] = Dec(MidA(ls_Manipulado,51,10))
//				dw_1.Object.vl_sinal_req_manip		      		[ll_row] = Dec(MidA(ls_Manipulado,61,10))
//				dw_1.Object.vl_saldo_req_manip		      		[ll_row] = Dec(MidA(ls_Manipulado,71,10))
//				dw_1.Object.cd_filial_fcerta				      		[ll_row] = Long(MidA(ls_Manipulado,81,4))
//				dw_1.Object.id_modo_venda			      		[ll_row] = MidA(ls_Manipulado,85,1)
//				If dw_1.Object.vl_bruto_req_manip[ll_row] > 0 Then //Se zerado, indica erro de comunica$$HEX2$$e700e300$$ENDHEX$$o
////					ivo_venda.ib_possui_manipulado 								   = True				
//				End If
//				//******
//				dw_1.object.desconto_sos                  	[ll_row] = "N"			
//				dw_1.Object.de_produto_apresentacao_venda 	[ll_row] = 	String(io_produto.cd_produto,'000000') + ' ' + io_produto.ivs_descricao_apresentacao_venda + " REGISTRO " + &
//																								String(dw_1.Object.nr_registro_manipulado [ll_row])			
//				
//				Exit
//				
//			Else
////				dw_1.Event ClearRow(ll_Row)
//				Return False
//			End If
//		Else
//			//Open (w_cl014_registro_produto_manipulado)
////			OpenWithParm ( w_cl014_registro_produto_manipulado, ivo_venda.ivo_Pedido.nr_pedido_drogaexpress )
//			
//			ls_Manipulado = Message.StringParm
//	
//			If Not IsNull(ls_Manipulado) Then
//				
//				li_Retorno = wf_existe_registro_manipulado(MidA(ls_Manipulado,1,10))
//												
//				If li_Retorno = -1 Then
//					dw_1.Event ClearRow(ll_Row)
//					Return False
//				ElseIf li_Retorno > 0 Then 
//					Continue
//				End If
//				
//								
//				ls_alteracao_preco     = dw_1.object.id_alteracao_preco [ll_row]				
//				dw_1.Object.nr_registro_manipulado        		[ll_row] = Long(MidA(ls_Manipulado,1,10))
//				dw_1.Object.qt_vendida                    			[ll_row] = Long(MidA(ls_Manipulado,11,10))
//				If ls_alteracao_preco = 'S' Then // Alterado pre$$HEX1$$e700$$ENDHEX$$o do produto pelo F5
//					Decimal {2} ldc_preco_alterado, ldc_preco_unitario, ldc_desconto
//					
//					ldc_preco_alterado = dw_1.object.vl_preco_unitario[ll_row]
//					ldc_desconto = 		dw_1.object.pc_desconto[ll_row]					
//					If Dec(MidA(ls_Manipulado,31,10)) = 0 Then //Erro de comunicacao com o FCerta
//						ldc_preco_unitario = Dec(MidA(ls_Manipulado,21,10))
//					Else
//						ldc_preco_unitario = Dec(MidA(ls_Manipulado,31,10))
//					End If			
//					
//					If ldc_preco_alterado > ldc_preco_unitario Then
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pre$$HEX1$$e700$$ENDHEX$$o informado R$ " + String(ldc_preco_alterado,"###,###,##0.00") + " n$$HEX1$$e300$$ENDHEX$$o pode ser maior que o pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio R$ " + String(ldc_preco_unitario,"###,###,##0.00") ,Exclamation!)
//						dw_1.Event ClearRow(ll_Row)						
//						Return False
//					ElseIf ldc_desconto > 000.00 and ldc_preco_alterado = 000.00 Then
//						dw_1.object.vl_preco_unitario		[ll_row] = ldc_preco_unitario
//						dw_1.object.pc_desconto			[ll_row] = ldc_desconto						
//						dw_1.object.pc_desconto_tabela 	[ll_row] = ldc_desconto
//						dw_1.Object.vl_preco_praticado	[ll_row] = wf_calcula_preco_praticado(ll_row)
//						dw_1.Object.vl_preco_Tabela   	[ll_row] = dw_1.Object.vl_preco_praticado	[ll_row]
//					ElseIf ldc_preco_alterado < ldc_preco_unitario Then
//						dw_1.object.vl_preco_unitario		[ll_row] = ldc_preco_unitario
//						ldc_desconto =  Round( ( ( ldc_preco_unitario - ldc_preco_alterado) / ldc_preco_unitario ) * 100 ,2)						
//						dw_1.object.pc_desconto			[ll_row] = ldc_desconto
//						dw_1.object.pc_desconto_tabela 	[ll_row] = ldc_desconto
//						dw_1.Object.vl_preco_praticado	[ll_row] = wf_calcula_preco_praticado(ll_row)
//						dw_1.Object.vl_preco_Tabela   	[ll_row] = dw_1.Object.vl_preco_praticado	[ll_row]						
//					Else
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pre$$HEX1$$e700$$ENDHEX$$o informado $$HEX1$$e900$$ENDHEX$$ igual ao da Requisi$$HEX2$$e700e300$$ENDHEX$$o.",Exclamation!)
//						dw_1.Event ClearRow(ll_Row)												
//						Return False
//					End If
//				Else				
//					If Dec(MidA(ls_Manipulado,31,10)) = 0 Then //Erro de comunicacao com o FCerta
//						dw_1.Object.vl_preco_unitario 	       		[ll_row] = Dec(MidA(ls_Manipulado,21,10))
//					Else
//						dw_1.Object.vl_preco_unitario 	        		[ll_row] = Dec(MidA(ls_Manipulado,31,10))
//					End If					
//					dw_1.Object.vl_preco_praticado		      		[ll_row] = 000.00 //Dec(Mid(ls_Manipulado,51,10)) 
//					dw_1.Object.vl_preco_praticado		      		[ll_row] = wf_calcula_preco_praticado(ll_row)
//					dw_1.Object.vl_preco_Tabela               			[ll_row] = Dec(MidA(ls_Manipulado,21,10))
//				End If				
//				dw_1.Object.vl_bruto_req_manip		      		[ll_row] = Dec(MidA(ls_Manipulado,31,10))
//				dw_1.Object.vl_desc_req_manip		      		[ll_row] = Dec(MidA(ls_Manipulado,41,10))
//				dw_1.Object.vl_liq_req_manip		      			[ll_row] = Dec(MidA(ls_Manipulado,51,10))
//				dw_1.Object.vl_sinal_req_manip		      		[ll_row] = Dec(MidA(ls_Manipulado,61,10))
//				dw_1.Object.vl_saldo_req_manip		      		[ll_row] = Dec(MidA(ls_Manipulado,71,10))
//				dw_1.Object.cd_filial_fcerta				      		[ll_row] = Long(MidA(ls_Manipulado,81,4))
//				dw_1.object.desconto_sos							[ll_row] = "N"			
//				dw_1.Object.de_produto_apresentacao_venda	[ll_row] = 	String(io_produto.cd_produto,'000000') + ' ' + io_produto.ivs_descricao_apresentacao_venda + " REGISTRO " + &
//																								String(dw_1.Object.nr_registro_manipulado [ll_row])
//				dw_1.Object.id_modo_venda			      		[ll_row] = MidA(ls_Manipulado,85,1)																								
//				If dw_1.Object.vl_bruto_req_manip[ll_row] > 0 Then //Se zerado, indica erro de comunica$$HEX2$$e700e300$$ENDHEX$$o
//					ivo_venda.ib_possui_manipulado = True				
//				End If
//	
//				Exit				
//			Else
//				dw_1.Event ClearRow(ll_Row)
//				Return False
//			End If
//		End If
//		
//	Loop
//
end subroutine

public function boolean wf_verifica_restricao_convenio (ref decimal adc_pc_desc_convenio);Boolean lb_Aplica_Desconto_Convenio = True

Long ll_Produto

Try
	If Not IsNull(io_Pedido.cd_condicao_convenio) Then
		
		/****** TESTE DE RESTRICOES *******/
		If io_Pedido.id_restricao_produto <> "N" Then
			Select cd_produto 
			Into :ll_Produto
			From restricao_convenio_produto
			Where cd_convenio				= :io_Pedido.cd_convenio
				And cd_condicao_convenio	= :io_Pedido.cd_condicao_convenio
				And cd_produto				= :io_Produto.cd_Produto
			Using SqlCa;
			
			Choose Case Sqlca.SQLCode
				Case -1
					SqlCa.of_RollBack( )
					Sqlca.of_MsgDBError("Restri$$HEX2$$e700e300$$ENDHEX$$o produto convenio.")
					Return False
				
				Case 100
					If io_Pedido.id_restricao_produto = "S" Then 
						lb_Aplica_Desconto_Convenio = False
					End If
			
				Case Else
					If io_Pedido.id_restricao_produto = "E" Then
						lb_Aplica_Desconto_Convenio = False
					End If
			End Choose
		End If
		
		If io_Pedido.id_restricao_grupo <> "N" And lb_Aplica_Desconto_Convenio Then	
			Select cd_grupo_produto 
			Into :ll_Produto
			From restricao_convenio_grupo
			Where cd_convenio				= :io_Pedido.cd_convenio
				And cd_condicao_convenio	= :io_Pedido.cd_condicao_convenio
				And cd_grupo_produto		= :io_Produto.cd_Grupo_Produto
			Using SqlCa;
		
			Choose Case Sqlca.SQLCode
				Case -1
					SqlCa.of_RollBack( )
					Sqlca.of_MsgDBError("Restri$$HEX2$$e700e300$$ENDHEX$$o grupo convenio.")
					Return False
						
				Case 100
					If io_Pedido.id_restricao_produto = "S" Then 
						lb_Aplica_Desconto_Convenio = False
					End If
			
				Case Else
					If io_Pedido.id_restricao_produto = "E" Then
						lb_Aplica_Desconto_Convenio = False
					End If
			End Choose	
		End If
		/*************/
		
		If lb_Aplica_Desconto_Convenio Then
			//adc_pc_desc_convenio =  io_Pedido.pc_desconto_minimo_convenio
			
			adc_pc_desc_convenio = -100.00
			
			If io_Pedido.id_considera_desconto = 'S' Then
				adc_pc_desc_convenio = io_Produto.of_desconto_convenio( io_Pedido.cd_convenio , io_Pedido.pc_desconto_minimo_convenio )
			End If
			
	//		If adc_pc_desc_convenio < ldc_Desconto_Produto_Prestes Then
	//			adc_pc_desc_convenio = ldc_Desconto_Produto_Prestes
	//		End If
	//		
	//		If  adc_pc_desc_convenio < ldc_Desconto_Produto Then
	//			adc_pc_desc_convenio = ldc_Desconto_Produto_Prestes
	//		End If
		End If
	End If // io_condicao_convenio.localizado
	
	Return True
Finally
	SqlCa.of_end_transaction( )	
End Try
end function

public subroutine wf_atualiza_forma_pagamento ();Decimal{2} ldc_Total_Pedido, ldc_Vl_Pago_aVista

dw_3.modify ( 'cd_condicao_crediario.Background.Color=134217750' )
dw_3.modify ( 'nr_parcelas_clube.Background.Color=134217750' )

dw_3.SettabOrder('cd_condicao_crediario', 0)
dw_3.SettabOrder('nr_parcelas_clube', 0)

dw_3.Object.credito_cliente_t.Text = ''
dw_3.Object.pagto_avista_t.Text = ''

Choose Case io_Pedido.id_Tipo_Venda
	Case 'AV'
//		dw_3.Modify("id_forma_pagamento.Values='SELECIONE A FORMA DE PAGTO	XX/DINHEIRO	DI/CART$$HEX1$$c300$$ENDHEX$$O CR$$HEX1$$c900$$ENDHEX$$DITO	CP/CART$$HEX1$$c300$$ENDHEX$$O D$$HEX1$$c900$$ENDHEX$$BITO	CA/'")
//		dw_3.SettabOrder('id_forma_pagamento', 10)
		
	Case 'CV'					
		dw_3.Object.de_convenio 				[1]	 = io_Pedido.nm_convenio
		dw_3.Object.de_condicao_convenio	[1]	 = io_Pedido.nm_condicao_convenio
		
	Case 'CR'
		dw_3.modify ( 'cd_condicao_crediario.Background.Color=16777215' )
		dw_3.SettabOrder('cd_condicao_crediario', 10)
		dw_3.Object.cd_condicao_crediario	[1]	 = 0 //Selecione a condicao
		dw_3.Object.condicao_t.Text			 = 'Credi$$HEX1$$e100$$ENDHEX$$rio:'
		dw_3.Object.cd_condicao_crediario.Visible 	= 1
		dw_3.Object.nr_parcelas_clube.Visible 		= 0
		
		
	Case 'CC'
		dw_3.modify ( 'nr_parcelas_clube.Background.Color=16777215' )
		dw_3.SettabOrder('nr_parcelas_clube', 10)
		dw_3.Object.nr_parcelas_clube 	[1] = 0 
		dw_3.Object.condicao_t.Text			 = 'Parcelas Clube:'
		dw_3.Object.cd_condicao_crediario.Visible 	= 0
		dw_3.Object.nr_parcelas_clube.Visible 		= 1
		
	Case	Else 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tipo de venda n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		
End Choose

dw_3.AcceptText()
	
end subroutine

public function boolean wf_limite_credito_cliente (decimal pl_valor_compra);
Boolean lb_Sucesso

//Consultas remota matriz
uo_cliente_central lvo_cliente_central
lvo_cliente_central = Create uo_cliente_central //GE077

lb_Sucesso = lvo_cliente_central.of_consulta_limite_credito_cliente(io_Pedido.cd_cliente, pl_valor_compra)

If lb_Sucesso Then
	io_Pedido.nr_matric_liberacao_restricao = lvo_cliente_central.nr_matric_liberacao_restricao
End If

Destroy(lvo_cliente_central)

Return lb_Sucesso
end function

public function boolean wf_cliente_bloqueado ();Boolean lvb_Bloqueado

String ls_dependente

lvb_Bloqueado = io_Cliente.of_Verifica_Bloqueio_Matriz(	  io_Pedido.Cd_Cliente, &
																 		  io_Pedido.cd_cliente_dependente, &
																 		  io_Pedido.Id_Tipo_Venda, &
																 		  ref io_Pedido.nr_matric_liberacao_bloqueio)

Return lvb_Bloqueado
end function

public function boolean wf_titulos_vencidos_cliente ();String  ls_Retorno

Long    ll_linhas

Boolean lb_Retorno = True

Try
	dc_uo_ds_base lds_titulos
	lds_titulos = Create dc_uo_ds_base
	lds_titulos.of_ChangeDataObject("dw_cl003_bloqueio_titulos_vencidos")
	
	ll_linhas = lds_titulos.Retrieve(Today(), io_Pedido.cd_cliente)
	
	If ll_linhas > 0 Then
	
	//	OpenWithParm(w_cl003_bloqueio_titulos_vencidos, lds_titulos)
			
		ls_Retorno = Message.StringParm
		
		If IsNull(ls_Retorno) Then
			
			lb_Retorno = False
			
		ElseIf ls_Retorno = "AVISTA" Then
	
			io_Pedido.id_tipo_venda = "AV"
			
			io_Pedido.cd_cliente            = ''
			io_Pedido.nm_cliente            = ''
			io_Pedido.cd_cliente_dependente = ''
				
			lb_Retorno = True
		Else
			
			io_Pedido.nr_matric_liberacao_bloqueio = ls_Retorno
			
			lb_Retorno = True	
		End If
			
	End If
	
	Return lb_Retorno
Finally
	If IsValid(lds_titulos) Then Destroy lds_titulos 
End Try
end function

public function boolean wf_venda_crediario ();Return True
end function

public function boolean wf_bloqueio_titulos_cliente_clube ();Integer li_ate20dias, li_superior20dias

String ls_Matricula

SELECT (SELECt Count(nr_titulo) FROM titulo_receber  WHERE cd_cliente = :io_Pedido.cd_cliente AND dh_vencimento < getdate() AND id_situacao = 'A' AND dbo.diffdate('day', dh_vencimento,getdate()) <=20),
		(SELECt Count(nr_titulo) FROM titulo_receber  WHERE cd_cliente = :io_Pedido.cd_cliente AND dh_vencimento < getdate()  AND id_situacao = 'A' AND dbo.diffdate('day', dh_vencimento,getdate()) > 20)
	Into :li_ate20dias,
		  :li_superior20dias
FROM parametro
	WHERE id_parametro = '1'
USING SqlCa;

If Sqlca.SqlCode = -1 Then
	Sqlca.of_Rollback()
	Sqlca.of_MsgDbError("Erro ao localizar os titulos em aberto. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_bloqueio_titulos_cliente_clube")
	Return False
End If

If li_superior20dias > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Existe(m) t$$HEX1$$ed00$$ENDHEX$$tulo(s) vencido(s) com mais de vinte dias de atraso.~n~n" + &
	                     "Libera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida.",Exclamation!)
	Return False
End If

If li_ate20dias > 0 Then
	If Not gvo_aplicacao.ivo_seguranca.of_libera_acesso_procedimento ("LIBERACAO_TITULO_VENCIDO",Ref ls_Matricula) Then
		Return False
	End If
	
	io_Pedido.nr_matric_liberacao_bloqueio = ls_Matricula
End If
		
Return True
end function

public function boolean wf_insere_itens_dw1 ();Integer li_Total, li_row, li_linha_Insert

Decimal ldc_Desconto_Cobre_Preco, ldc_preco_unitario

li_Total = io_Pedido.ids_Itens.RowCount()

dw_1.Reset()

For li_row = 1 To li_Total
	li_linha_Insert = dw_1.InsertRow(0)
	dw_1.Event ue_Pos( li_linha_Insert, "de_produto")
	dw_1.Object.de_produto			[ li_linha_Insert ] = String(io_Pedido.ids_Itens.Object.cd_produto	[li_Row])
	dw_1.Object.id_cobre_preco	[ li_linha_Insert ] = io_Pedido.ids_Itens.Object.id_cobre_preco		[li_Row]
	dw_1.Object.id_reservado		[ li_linha_Insert ] = io_Pedido.ids_Itens.Object.id_reservado		[li_Row]
	dw_1.Object.qt_pedida			[ li_linha_Insert ] = io_Pedido.ids_Itens.Object.qt_pedida			[li_Row]
	
	If Not wf_Localiza_Produto() Then
		dw_1.deleterow(li_linha_Insert)
		Continue
		//Return False		
	End If
	
	If io_Pedido.ids_itens.Object.id_cobre_preco [li_row] = 'S' Then
		ldc_preco_unitario				= io_Pedido.ids_Itens.Object.vl_preco_unitario					[li_Row]
		ldc_Desconto_Cobre_Preco	= io_Pedido.ids_Itens.Object.pc_desconto_cobre_preco		[li_Row]
		
		If IsNull(ldc_preco_unitario)				Then ldc_preco_unitario 				= 0.00
		If IsNull(ldc_Desconto_Cobre_Preco) 	Then ldc_Desconto_Cobre_Preco 	= 0.00
		
		dw_1.Object.pc_desconto			[li_linha_Insert] = ldc_Desconto_Cobre_Preco
		dw_1.Object.vl_preco_praticado	[li_linha_Insert] = Round(ldc_preco_unitario * ((100 - ldc_Desconto_Cobre_Preco) / 100), 2)
	End If
	
	dw_1.Event ue_Pos( li_linha_Insert, 'qt_pedida' )
Next

dw_1.AcceptText()

Return True

end function

public function boolean wf_desconto_padrao (integer ai_linha, ref decimal adc_desconto, ref decimal adc_desconto_tabela);Decimal {2} ldc_desconto,&
				ldc_desconto_filial,&
				ldc_desconto_clube,&
				ldc_desconto_convenio, &
				ldc_desconto_campanha,&
				ldc_Desconto_Campanha_Vale
				
Decimal{2} ldc_desconto_plano_saude, ldc_desconto_plano_aux
			
Long ll_Promocao, ll_Nr_Campanha_Vale, ll_pos_exame
Long ll_promocao_sos_clube, ll_Contrato, ll_Convenio_Saude

Integer ll_row

String ls_Vale_Desconto, ls_Null

SetNull(ls_Null)

ldc_desconto         				= 000.00
ldc_desconto_convenio 			= 000.00
ldc_desconto_filial   				= 000.00
ldc_desconto_clube    			= 000.00
ldc_desconto_campanha 		= 000.00
ldc_Desconto_Campanha_Vale	= 000.00

// Venda Conv$$HEX1$$ea00$$ENDHEX$$nio
If io_Pedido.id_Tipo_Venda = "CV" Then	
	ldc_desconto_convenio = -100.00
			
	If io_Pedido.id_considera_desconto = 'S' Then
		ldc_desconto_convenio = io_Produto.of_desconto_convenio( io_Pedido.cd_convenio , io_Pedido.io_condicao_convenio.pc_desconto_minimo )
	End If
	
//	If Not wf_Verifica_Restricao_Convenio(Ref ldc_desconto_convenio) Then 
//		Return False
//	End If
End If

//Desconto plano de saude
If Not IsNull(This.io_Pedido.nr_cartao_saude) and Trim(This.io_Pedido.nr_cartao_saude) <> '' Then
	For ll_row = 1 to This.io_Pedido.ids_contratos_bin.rowcount( )
		ll_Convenio_Saude	=  This.io_Pedido.ids_contratos_bin.object.cd_convenio		[ll_row]
		ll_Contrato			  	=  This.io_Pedido.ids_contratos_bin.object.nr_contrato		[ll_row]					
		
		ldc_desconto_plano_aux = io_Produto.of_desconto_contrato_convenio(ll_Convenio_Saude, ll_contrato)
		If ldc_desconto_plano_aux > ldc_desconto_plano_saude Then
			ldc_desconto_plano_saude 	= ldc_desconto_plano_aux
		End If	
		ldc_desconto_plano_aux = 000.00
	Next
	
	If ldc_desconto_plano_saude > 0 Then
		dw_1.Object.cd_convenio_saude	[ai_linha] = ll_Convenio_Saude
		dw_1.Object.nr_contrato 			[ai_linha] = ll_Contrato
		If ldc_desconto_plano_saude > ldc_Desconto_Convenio Then
			ldc_Desconto_Convenio = ldc_desconto_plano_saude
		End If
	End If
End If	

//Somente localiza desconto para clube se houver necessidade e se n$$HEX1$$e300$$ENDHEX$$o for venda crediario.
//Localiza desconto Clube
If Not IsNull(io_pedido.cd_cliente) Then
	ldc_desconto_clube 		= io_produto.Of_Desconto_Clube()
	ldc_desconto_campanha = io_produto.Of_Desconto_Campanha(io_pedido.cd_cliente)	
	
	If ldc_desconto_clube > 0 Then
		ll_promocao_sos_clube = io_produto.cd_promocao_sos
	End If
Else
	ldc_desconto_clube		= 000.00
	ldc_desconto_campanha = 000.00
End If

//Retorna por referencia com desconto Tabela
ldc_desconto_filial = io_produto.Of_Desconto_Filial()

If ldc_desconto_clube > ldc_desconto_filial Then
	ldc_desconto = ldc_desconto_clube
	io_produto.cd_promocao_sos	= ll_promocao_sos_clube
Else
	ldc_desconto = ldc_desconto_filial
End If

If ldc_desconto_convenio > ldc_desconto Then
	ldc_desconto = ldc_desconto_convenio
End If

//Compara o melhor desconto entre (vale desconto) e campanha normal
If Not wf_verifica_qtde_desconto_campanha_pos(io_produto.cd_produto, ai_Linha, Ref ldc_Desconto_Campanha_Vale, Ref ll_Nr_Campanha_Vale, Ref ls_Vale_Desconto) Then
	adc_desconto = ldc_Desconto_Campanha_Vale
	Return False
End If

If ldc_Desconto_Campanha_Vale > ldc_desconto_campanha Then
	ldc_desconto_campanha 	= ldc_Desconto_Campanha_Vale
	io_produto.nr_campanha 	= ll_Nr_Campanha_Vale   //Atribui a campanha do vale desconto 
Else
	ls_Vale_Desconto = ls_Null
End If

//Verifica se desconto campanha $$HEX1$$e900$$ENDHEX$$ maior que desconto calculado
If ldc_desconto_campanha > ldc_desconto Then
	ldc_desconto = ldc_desconto_campanha
	SetNull(io_produto.cd_promocao_sos)		
Else
	SetNull(io_produto.nr_campanha)	
	ls_Vale_Desconto = ls_Null
End If


//Atribui se realmente o % desconto do vale desconto for maior que todos os demais descontos
//Caso contrario recebe null
dw_1.Object.nr_vale_desconto[ ai_linha ] = ls_Vale_Desconto

//Retorna como referencia
adc_desconto 			= ldc_desconto
adc_desconto_tabela 	= ldc_desconto_filial

Return True
end function

public function boolean wf_verifica_qtde_desconto_campanha_pos (long al_produto, integer ai_linha, ref decimal adc_pc_desconto, ref long al_campanha, ref string as_vale_desconto);
Long ll_Qt_Vendida, ll_Total

String ls_Vale

Long li_Row, ll_Qt_Maxima, ll_Campanha

Decimal ldc_PC_Desconto

ldc_PC_Desconto = -100.00
adc_Pc_Desconto = -100.00
SetNull(as_Vale_Desconto)
SetNull(al_campanha)

ll_Qt_Vendida 		= wf_Verifica_qtde_Item_pedida( al_Produto )

ll_Total = UPPERBOUND( istr_cupom_desconto )

For li_Row = 1 To ll_Total
	SetNull( ll_qt_maxima )
	SetNull( ll_Campanha )		
	
	ll_Campanha 		= istr_cupom_desconto[ li_Row ].nr_campanha
	ldc_PC_Desconto 	= istr_cupom_desconto[ li_Row ].pc_desconto
	ls_Vale				= istr_cupom_desconto[ li_Row ].de_Vale_Desconto
	
	If Not wf_qtde_maxima_permitida_vale_desconto( al_Produto, ll_Campanha, Ref ll_qt_maxima ) Then
		adc_Pc_Desconto = -100.00
		SetNull(al_campanha)
		Return False
	End If
	
	//Produto nao existe na campanha
	If IsNull(ll_qt_maxima) Then	
		adc_Pc_Desconto = -100.00
		SetNull(al_campanha)
		Continue
	End If
			
	If 	ll_qt_maxima > 0 Then
		
		//Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ esta na dw_1 com a quantidade maxima do cupom atendida
		If dw_1.Find("cd_produto = " + String(al_produto) + " and nr_campanha_vale_desc = " + String(ll_Campanha) + " and qt_pedida = " + String(ll_qt_maxima), 1, dw_1.RowCount()) > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Quantidade vendida superior a m$$HEX1$$e100$$ENDHEX$$xima permitida do produto " + String( al_Produto ) + " para o cupom desconto informado.~r~rO % de desconto n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ aplicado.")
			adc_Pc_Desconto = -100.00
			SetNull(al_campanha)
			Return True
		Else
					
			//Quantidade da dw_item j$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ superior a m$$HEX1$$e100$$ENDHEX$$xima permitida
			//Zera o Desconto do vale para o produto
			If ll_Qt_Vendida > ll_qt_maxima Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Quantidade vendida superior a m$$HEX1$$e100$$ENDHEX$$xima permitida do produto " + String( al_Produto ) + " para o cupom desconto informado.~r~rO % de desconto ser$$HEX1$$e100$$ENDHEX$$ aplicado em " +String( ll_qt_maxima ) + " un.")
				dw_1.Object.qt_pedida[ai_Linha] = ll_qt_maxima
				dw_1.event itemchanged( ai_Linha, dw_1.Object.qt_pedida, String(ll_qt_maxima))
								
				//Retorna o PC desconto da campanha
				dw_1.Object.nr_campanha_vale_desc[ ai_linha ] = ll_Campanha
				al_campanha 		= ll_Campanha
				adc_Pc_Desconto  = ldc_PC_Desconto
				as_Vale_Desconto	= ls_Vale
				Return True
			Else	
				//Retorna o PC desconto da campanha
				dw_1.Object.nr_campanha_vale_desc[ ai_linha ] = ll_Campanha
				al_campanha 		= ll_Campanha
				adc_Pc_Desconto  = ldc_PC_Desconto
				as_Vale_Desconto	= ls_Vale
				Return True
			End If
		End If //find		
		
	Else
		//Sem limite de quantidade 
		//Retorna o PC desconto da campanha
		dw_1.Object.nr_campanha_vale_desc	[ai_linha] = ll_Campanha
		al_campanha 		= ll_Campanha
		adc_Pc_Desconto  = ldc_PC_Desconto
		as_Vale_Desconto	= ls_Vale
		Return True
	End If
				
Next

Return True

end function

public function boolean wf_qtde_maxima_permitida_vale_desconto (long al_produto, long al_campanha, ref long al_qt_maxima);Integer li_qt_maxima

SetNull(al_qt_maxima)

Select COALESCE(qt_maxima_venda,0)
	into :li_qt_maxima
from campanha_produto 
	where nr_campanha 	= :al_campanha
		and cd_produto 	= :al_produto
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar a quantidade m$$HEX1$$e100$$ENDHEX$$xima permitida do produto: " + String(al_Produto) + " na campanha: " +String(al_campanha) )
		Return False
	Case 100
		SetNull(li_qt_maxima)	
	Case 0
		If li_qt_maxima < 0  Then li_qt_maxima = 0
End Choose

al_qt_maxima = li_qt_maxima
end function

public function boolean wf_consiste_finalizacao_pedido ();Boolean lb_dif_avista

Decimal ldc_Total_Pedido
Decimal ldc_Total_Multiplos_Pagamento
Decimal ldc_vl_Minimo_Parcela
Decimal ldc_Vl_Pago_aVista
Decimal ld_Vl_Credito
Decimal ldc_Total_Frete

Decimal lvdc_valor_ultrapassado
Decimal lvdc_valor_convenio
Decimal lvdc_pc_convenio

Integer li_Parcelas_Clube
Integer li_Condicao_Crediario, li_Null, li_Linhas

DataWindowChild ldw_Child

SetNull(li_Null)

dw_4.AcceptText()
dw_5.AcceptText()

ldc_Total_Pedido 						= dw_4.GetItemDecimal(1, 'vl_total_pedido' )		
ldc_Total_Multiplos_Pagamento 	= dw_5.GetItemDecimal(1, 'cp_total_multiplos_pagto' )		
ldc_Total_Frete							= dw_2.GetItemDecimal(1, 'vl_frete' )		

ldc_Vl_Pago_aVista = 0.00

Choose Case io_Pedido.id_Tipo_Venda
	Case 'AV'
		If ldc_Total_Multiplos_Pagamento < ldc_Total_Pedido Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Total de pagamentos inferior ao valor total do pedido.", Exclamation!)
			Return False
		End If
		
		li_Linhas = dw_5.RowCount()
		
		If li_Linhas = 1 Then
			io_Pedido.cd_forma_pagamento = dw_5.Object.cd_forma_pagamento[1]
		ElseIf li_Linhas > 1 Then
			io_Pedido.cd_forma_pagamento = 'MF'
		End If
		
		io_Pedido.idc_vl_pago = ldc_Total_Multiplos_Pagamento
		
		//OK
	Case 'CV'
//		ivo_venda.vl_total_venda = ivo_venda.vl_total_produtos - ( ivo_venda.vl_desconto_unimed_desconto + ivo_venda.vl_desconto_convenio_desconto )
			
		lvdc_pc_convenio = 100 -  io_Pedido.io_condicao_convenio.pc_avista 
		
		// O valor pago pela empresa deve ser maior que o valor pago a vista
		If io_Pedido.io_condicao_convenio.pc_avista > 0 Then
			//Se existe percentual a vista a ser pago
			lvdc_valor_convenio = Round(ldc_Total_Pedido  * (lvdc_pc_convenio / 100) ,2)			
												 
			ldc_Vl_Pago_aVista = ldc_Total_Pedido - lvdc_valor_convenio
			
		Else
			If io_Pedido.io_condicao_convenio.vl_subsidio > 0 Then
				If io_Pedido.io_condicao_convenio.vl_subsidio > ldc_Total_Pedido Then
					ldc_Vl_Pago_aVista = 0
				Else
					ldc_Vl_Pago_aVista = ldc_Total_Pedido - io_Pedido.io_condicao_convenio.vl_subsidio
				End If
			Else
				ldc_Vl_Pago_aVista = 0
			End If			
		End If
		
//		// Verifica o limite de compras do conveniado			
		If Not wf_limite_conveniado_liberado(ldc_Total_Pedido - ldc_Vl_Pago_aVista, Ref lvdc_valor_ultrapassado) Then			
			ldc_Vl_Pago_aVista += lvdc_valor_ultrapassado	
		End If
		
		If ldc_Vl_Pago_aVista > 0 Then
			If ldc_Total_Multiplos_Pagamento = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Limite insuficiente de cr$$HEX1$$e900$$ENDHEX$$dito ou existe restri$$HEX2$$e700e300$$ENDHEX$$o no pagamento.~r~rO cliente ter$$HEX1$$e100$$ENDHEX$$ que pagar R$ " + String( ldc_Vl_Pago_aVista ) + " $$HEX1$$e000$$ENDHEX$$ vista.", Exclamation!)
					Return False
			End If
			
			If ldc_Total_Multiplos_Pagamento < ldc_Vl_Pago_aVista Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor informado insuficiente para o pagamento $$HEX1$$e000$$ENDHEX$$ vista.", exclamation!)
				Return False
			End If
		End If	
		
		io_Pedido.idc_valor_pago_avista = ldc_Vl_Pago_aVista
		
	Case 'CR'	
		li_Condicao_Crediario = dw_3.Object.cd_condicao_crediario [ 1 ]
			
		If IsNull(li_Condicao_Crediario) Or li_Condicao_Crediario = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a condi$$HEX2$$e700e300$$ENDHEX$$o do credi$$HEX1$$e100$$ENDHEX$$rio.", Exclamation!)
			Return False
		End If
		
		io_Pedido.cd_condicao_crediario = li_Condicao_Crediario
				
		If Not wf_limite_credito_cliente( ldc_Total_Pedido ) Then Return False
		
		//ok
	Case 'CC'
		//Valor limite disponivel 		
		If ldc_Total_Pedido > idc_Limite_Credito_Cliente Then
			If idc_Limite_Credito_Cliente > 0 Then
				ld_Vl_Credito = idc_Limite_Credito_Cliente
			End If
			
			ldc_Vl_Pago_aVista = ldc_Total_Pedido - idc_Limite_Credito_Cliente
		Else
			ld_Vl_Credito = ldc_Total_Pedido
		End If			
		
		li_Parcelas_Clube = dw_3.Object.nr_parcelas_clube[1]
		
		If IsNull( li_Parcelas_Clube ) Or li_Parcelas_Clube = 0  Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione o n$$HEX1$$fa00$$ENDHEX$$mero de parcelas do Clube Prazo.", Exclamation!)
			dw_3.Event ue_Pos(1, 'nr_parcelas_clube')
			Return False
		End If
		
		If dw_3.GetChild('nr_parcelas_clube', ldw_Child) = 1 Then
			ldc_vl_Minimo_Parcela = ldw_Child.GetItemDecimal(ldw_Child.GetRow(),'vl_minimo')
		End If
		
		If (ld_Vl_Credito / li_Parcelas_Clube ) < ldc_vl_Minimo_Parcela Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor m$$HEX1$$ed00$$ENDHEX$$nimo da parcela n$$HEX1$$e300$$ENDHEX$$o atingido. (R$ " + String(ldc_vl_Minimo_Parcela, "#,##0.00") + ")", Exclamation!)
			Return False
		End If
		
		//Verifica novamente o limite do cliente e solicita a matricula de liberacao
		If Not wf_limite_credito_cliente( ld_Vl_Credito ) Then 
			Return False
		End If
			
		If Not wf_bloqueio_titulos_cliente_clube() Then 
			Return False
		End If
			
		If wf_Cliente_Bloqueado() Then 
			Return False
		End If
		
		If ldc_Vl_Pago_aVista > 0 Then
			If ldc_Total_Multiplos_Pagamento = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Limite insuficiente de cr$$HEX1$$e900$$ENDHEX$$dito ou existe restri$$HEX2$$e700e300$$ENDHEX$$o no pagamento.~r~rO cliente ter$$HEX1$$e100$$ENDHEX$$ que pagar R$ " + String( ldc_Vl_Pago_aVista ) + " $$HEX1$$e000$$ENDHEX$$ vista.", Exclamation!)
					Return False
			End If
			
			If ldc_Total_Multiplos_Pagamento < ldc_Vl_Pago_aVista Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor informado insuficiente para o pagamento $$HEX1$$e000$$ENDHEX$$ vista.", exclamation!)
				Return False
			End If
		End If	
		
		If (ld_Vl_Credito + ldc_Total_Multiplos_Pagamento + ldc_Vl_Pago_aVista) < ldc_Total_Pedido Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Total de pagamentos inferior ao valor total do pedido.", Exclamation!)
			Return False
		End If
		
		io_Pedido.idc_valor_pago_avista		= ldc_Vl_Pago_aVista
		io_Pedido.nr_parcelas_clube_prazo  	= li_Parcelas_Clube

End Choose

Return True
end function

public function boolean wf_pedido_minimo_isento_frete ();String ls_Parametro

select coalesce(vl_parametro, '0.00')
into :ls_Parametro
from parametro_loja
where cd_parametro = 'VL_PEDIDO_MINIMO_ISENTO_FRETE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		idc_Vl_Pedido_Minimo_Isento_Frete 			= Dec(ls_Parametro)
		dw_2.Object.vl_parametro_frete_gratis[1] 	= idc_Vl_Pedido_Minimo_Isento_Frete
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o valor m$$HEX1$$ed00$$ENDHEX$$nimo para frete gr$$HEX1$$e100$$ENDHEX$$tis.")
		Return False
	Case -1
		MessageBox("Erro", "Erro ao localizar o valor m$$HEX1$$ed00$$ENDHEX$$nimo para frete gr$$HEX1$$e100$$ENDHEX$$tis: "+ SqlCa.SqlErrText)
		Return False
End Choose

Return True
end function

public function boolean wf_valor_frete (string as_cep, ref decimal adc_vl_frete, ref decimal adc_frete_calculado);Decimal	ldc_Vl_Frete,&
			ldc_Vl_Parametro,&
			ldc_Total_produtos

Long	ll_Produto_Frete

Try					
	adc_vl_frete 			= 0.00	
	adc_frete_calculado 	= 0.00
		
	//Localiza o valor do frete definido no bairro
	select coalesce(max(b.vl_frete), 0)
	into :ldc_Vl_Frete
	from ect_logradouro a
	inner join ect_bairro b on b.nr_bairro = a.nr_bairro
	where a.nr_cep = :as_CEP
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If ldc_Vl_Frete > 0 Then
				adc_vl_frete = ldc_Vl_Frete
				Return True
			Else
				//Localiza preco frete pela localidade. Sombrio nao possui ruas logradouros, apenas um bairro, um cep padrao
				select coalesce(max(b.vl_frete), 0) 
					into :ldc_Vl_Frete
					from ect_localidade a
					inner join ect_bairro b 
							on b.nr_localidade = a.nr_localidade 
				where a.nr_cep = :as_CEP
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgDbError("Erro ao localizar o valor do frete na ect_localidade. "+ SqlCa.SqlErrText)
					Return False
				End If
				
				If ldc_Vl_Frete > 0 Then
					adc_vl_frete = ldc_Vl_Frete
					Return True
				End If			
			End If
		Case -1
			SqlCa.of_MsgDbError("Erro ao localizar o valor do frete. "+ SqlCa.SqlErrText)
			Return False
	End Choose
	
	//Localiza o valor do frete no produto FRETE
	uo_ge108_produto	 lo_produto
	lo_produto = Create uo_ge108_produto
	
	ll_Produto_Frete = lo_produto.cd_produto_frete
	
	If Not lo_produto.of_localiza_codigo_interno( ll_Produto_Frete) Then
		MessageBox("Erro", "Erro ao localizar o produto 'FRETE'")
		Return False
	End If
	
	adc_vl_frete	= lo_produto.of_preco_venda_filial( )

	Return True
Finally
	If dw_1.RowCount() > 0 Then
		ldc_Total_produtos	= dw_1.GetItemDecimal(dw_1.RowCount(), "cp_total_produtos")
		If IsNull(ldc_Total_produtos) Then ldc_Total_produtos = 0.00
	End If
	
	adc_frete_calculado = adc_vl_frete
	
	//Se o total do pedido for maior ou igual ao valor definido no par$$HEX1$$e200$$ENDHEX$$metro, o frete $$HEX1$$e900$$ENDHEX$$ gr$$HEX1$$e100$$ENDHEX$$tis
	If ldc_Total_produtos >= idc_Vl_Pedido_Minimo_Isento_Frete Then
		adc_vl_frete = 0.00
	End If

	If IsValid(lo_produto) Then Destroy(lo_produto)
End Try
end function

public function boolean wf_busca_limite_cliente (ref decimal adc_limite, ref decimal adc_saldo_disponivel);
Boolean lb_Sucesso

//Consultas remota matriz
uo_cliente_central lvo_cliente_central
lvo_cliente_central = Create uo_cliente_central

lb_Sucesso = lvo_cliente_central.of_retorna_limite_cliente(io_Pedido.cd_cliente, Ref adc_limite)

adc_saldo_disponivel = lvo_cliente_central.vl_Limite_Credito_Saldo

Destroy(lvo_cliente_central)

Return lb_Sucesso
end function

public function boolean wf_limite_conveniado_liberado (decimal pdc_valor, ref decimal pdc_valor_ultrapassado);Boolean lvb_Retorno = True
Boolean lb_Mostra_Mensagem = False
Boolean lb_aVista

uo_Conveniado lvo_Conveniado
lvo_Conveniado = Create uo_Conveniado

//lvb_Retorno = lvo_Conveniado.of_Limite_Conveniado_Liberado_Matriz(io_Pedido.io_convenio.cd_convenio, &
//																		 	  			io_Pedido.io_conveniado.cd_conveniado, &
//																		     			io_Pedido.io_condicao_convenio.cd_condicao_convenio, &
//																						lb_Mostra_Mensagem, &
//																		     			Ref pdc_Valor, &
//																						Ref pdc_Valor_ultrapassado, &
//																						Ref lb_aVista)																	
//
////A fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o exibir$$HEX1$$e100$$ENDHEX$$ a mensagem se permite somar o valor ultrapassado no valor pago a vista
////E a variavel lb_aVista vir$$HEX1$$e100$$ENDHEX$$ como False
////Apenas o convenio CLAMED n$$HEX1$$e300$$ENDHEX$$o PERMITE pagamento a vista
//ib_Permite_Pagar_Dif_avista = (io_Pedido.io_convenio.cd_convenio <> 50805)
//
//This.idc_Saldo_Disponivel_Credito 	= lvo_Conveniado.idc_limite_saldo_disponivel
//This.idc_Limite_Credito_Cliente			= lvo_Conveniado.idc_limite_credito

Destroy(lvo_Conveniado)
																  
Return lvb_Retorno
end function

public function boolean wf_produto_liberado_convenio (long al_produto);Boolean lb_Retorno = False

String ls_Produto_Liberado, &
		 ls_Produto_Parte
		 
Long ll_Pos

Try
	uo_Parametro_Filial lvo_Parametro
	lvo_Parametro = Create uo_Parametro_Filial
		
	If lvo_Parametro.of_Localiza_Parametro("ID_LIVRE_RESTRICAO_CONV", ref ls_Produto_Liberado, False) Then
		If Not IsNull(ls_Produto_Liberado) And Trim(ls_Produto_Liberado) <> '' Then			
			ll_Pos = PosA(ls_Produto_Liberado, ",")
			If ll_Pos = 0 Then			
				If Long(ls_Produto_Liberado) = al_produto Then
					Return True
				End If
			Else
				
				Do While Trim(ls_Produto_Liberado) <> ''
					ll_Pos = PosA(ls_Produto_Liberado, ",")
					
					If ll_Pos = 0 Then
						ls_Produto_Parte = ls_Produto_Liberado
						ls_Produto_Liberado = ''
					Else
						ls_Produto_Parte = LeftA(ls_Produto_Liberado,ll_pos - 1)
					End If
					
					If Not IsNull(ls_Produto_Parte) And Trim(ls_Produto_Parte) <> '' Then
						If Long(ls_Produto_Parte) = al_produto Then				
							Return True
						Else
							ls_Produto_Liberado = MidA(ls_Produto_Liberado, ll_Pos + 1)
						End If
					Else
						exit
					End If				
					
				Loop						
				
			End If			
		End If
	End If			
	
	Return lb_Retorno
	
Finally
	If IsValid(lvo_Parametro) Then Destroy(lvo_Parametro)		
End Try

end function

public function boolean wf_consiste_produto_convenio (long pl_grupo, long pl_produto);String ls_Matricula	 

If io_Pedido.id_tipo_venda = "CV" Then
	
	If io_Pedido.io_Conveniado.id_obedece_restricao = "N" Then Return True
	
	If wf_produto_liberado_convenio(pl_produto) Then Return True
	
	If wf_bloqueio_grupo_produto_convenio(pl_grupo, pl_produto) Then
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto " + String(pl_produto)  + " possui restri$$HEX2$$e700e300$$ENDHEX$$o de venda para o conv$$HEX1$$ea00$$ENDHEX$$nio e condi$$HEX2$$e700e300$$ENDHEX$$o de venda selecionados.~r~rDeseja liberar?", Question!, YesNo!, 1) = 1 Then
			If Not gvo_aplicacao.ivo_seguranca.of_libera_acesso_procedimento ("LIBERACAO_RESTRICAO_CONVENIO", ls_Matricula) Then Return False
		Else
			Return False
		End If
			
		io_Pedido.nr_matric_liberacao_restricao =  ls_Matricula

		// Marca item, indicando que foi liberado restri$$HEX2$$e700e300$$ENDHEX$$o para este produto
		//dw_1.Object.id_restricao_convenio_liberada [dw_itens.GetRow()] = "S"

	End If
	
End If

Return True

end function

public function boolean wf_bloqueio_grupo_produto_convenio (long pl_grupo, long pl_produto);
Long  lvl_produto,&
      lvl_grupo

If io_Pedido.id_restricao_produto <> "N" Then

	Select cd_produto 
	  Into :lvl_produto
	  From restricao_convenio_produto
	 Where cd_convenio			= :io_Pedido.cd_convenio and
	       cd_condicao_convenio 	= :io_Pedido.cd_condicao_convenio and
			 cd_produto  			= :pl_produto;

	Choose Case Sqlca.SQLCode
		Case -1
			Sqlca.of_MsgDBError("Restri$$HEX2$$e700e300$$ENDHEX$$o produto convenio.")
			Return True
		Case 100
			If io_Pedido.id_restricao_produto = "S" Then Return True

		Case Else
			If io_Pedido.id_restricao_produto = "E" Then Return True
	End Choose

End If

If io_Pedido.id_restricao_grupo <> "N" Then

	Select cd_grupo_produto 
	  Into :lvl_grupo
	  From restricao_convenio_grupo
  	 Where cd_convenio 			= :io_Pedido.cd_convenio and
	       cd_condicao_convenio 	= :io_Pedido.cd_condicao_convenio and
			 cd_grupo_produto  	= :pl_grupo;

	Choose Case Sqlca.Sqlcode
		Case -1
			Sqlca.of_MsgDBError("Restri$$HEX2$$e700e300$$ENDHEX$$o grupo conv$$HEX1$$ea00$$ENDHEX$$nio.")
			Return True
		Case 100
			If io_Pedido.id_restricao_grupo = "S" Then Return True
		Case Else
			If io_Pedido.id_restricao_grupo = "E" Then Return True
	End Choose

End If

Return False
end function

public function boolean wf_contrato_desconto_saude ();Long ll_convenio

Return io_convenio.of_verifica_contrato(io_Pedido.nr_cartao_saude , ref ll_convenio, ref io_Pedido.ids_Contratos_Bin)
	
end function

public function boolean wf_processa_desconto_convenio (long pl_cd_produto, ref string ps_log);long ll_for
long ll_linhas

//Produto_liberado_convenio
	


return true
end function

public function boolean wf_carrega_pedido ();
//Carrega os produtos
dw_1.of_appendwhere( 'cd_filial = ' + string(io_pedido.cd_filial) )
dw_1.of_appendwhere( 'nr_pedido_disque = ' + string(io_pedido.nr_pedido) )

dw_1.retrieve()
      
//Carrega dados de entrega
dw_2.retrieve( io_pedido.cd_filial, io_pedido.nr_pedido )

//Carrega dados de pagamento
dw_5.of_appendwhere( 'cd_filial = ' + string(io_pedido.cd_filial) )
dw_5.of_appendwhere( 'nr_pedido_disque = ' + string(io_pedido.nr_pedido) )
dw_5.retrieve()

dw_6.Object.de_dados_adicionais[1] = dw_2.object.de_dados_adicionais[1]

io_pedido.id_tipo_venda = dw_2.object.id_tipo_venda[1]

if io_pedido.id_tipo_venda = 'CV' Then
	
	dw_3.insertrow(1)
	
	//dw_3.
	
end if

return true
end function

on w_ge498_pedido_disque.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.gb_entrega=create gb_entrega
this.gb_2=create gb_2
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cb_incluir_pagamento=create cb_incluir_pagamento
this.dw_6=create dw_6
this.gb_pagamento=create gb_pagamento
this.gb_3=create gb_3
this.datastore_1=create datastore_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.gb_entrega
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.dw_5
this.Control[iCurrent+7]=this.cb_incluir_pagamento
this.Control[iCurrent+8]=this.dw_6
this.Control[iCurrent+9]=this.gb_pagamento
this.Control[iCurrent+10]=this.gb_3
end on

on w_ge498_pedido_disque.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.gb_entrega)
destroy(this.gb_2)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cb_incluir_pagamento)
destroy(this.dw_6)
destroy(this.gb_pagamento)
destroy(this.gb_3)
destroy(this.datastore_1)
end on

event open;call super::open;io_parametro 				= Create uo_parametro_filial
io_Convenio 				= Create uo_Convenio
io_condicao_convenio 	= Create uo_condicao_venda_convenio
io_Cliente 					= Create uo_Cliente
io_produto 					= Create uo_produto
io_Endereco					= Create uo_ge099_endereco
io_Cidade					= Create uo_Cidade

io_pedido = Message.PowerObjectParm

io_Cliente.of_Inicializa()

wf_centraliza_janela()

io_parametro.of_localiza_parametro( 'ID_UTILIZA_LISTA_TECNICA', ref is_utiliza_lista_tecnica)
end event

event close;call super::close;If IsValid( io_parametro ) 			Then Destroy io_parametro
If IsValid( io_Cliente ) 				Then Destroy io_Cliente
If IsValid( io_Convenio ) 				Then Destroy io_Convenio
If IsValid( io_condicao_convenio )	Then Destroy io_condicao_convenio
If IsValid( io_pedido ) 				Then Destroy io_pedido
If IsValid( io_produto )  				Then Destroy io_produto
If IsValid( io_Endereco) 				Then Destroy io_Endereco
If IsValid( io_Cidade ) 				Then Destroy io_Cidade

end event

event ue_postopen;call super::ue_postopen;Decimal{2} ldc_Vl_Frete, ldc_Total_produtos, ldc_Frete_Calculado
Decimal lvdc_valor_ultrapassado

String ls_Null

//Carrega Contratos Desconto Sa$$HEX1$$fa00$$ENDHEX$$de
This.wf_contrato_desconto_saude()

This.Setredraw( False )

//Altera$$HEX2$$e700e300$$ENDHEX$$o de pedido
if io_pedido.nr_pedido > 0 then
	
	this.wf_carrega_pedido( )
	
//Pedido Novo	
else
	
	dw_2.Event ue_AddRow()
	dw_3.Event ue_AddRow()
	dw_4.Event ue_AddRow()
	dw_5.Event ue_AddRow()
	dw_6.Event ue_AddRow()
	dw_5.Reset()	
	
	wf_insere_itens_dw1()
	
	If dw_1.RowCount() = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto dispon$$HEX1$$ed00$$ENDHEX$$vel no pedido disque entrega.", Exclamation!)
		CloseWithReturn(This, ls_Null)
		Return	
	End If
	
//	  SELECT cd_cliente,
//		(CASE WHEN c.nm_social is not null THEN c.nm_social ELSE c.nm_cliente END) as nm_cliente,
//         nr_cpf_cgc,   
//         d.nm_cidade,   
//         d.cd_unidade_federacao,   
//         de_endereco,   
//         de_bairro,   
//         nr_cep,   
//		nr_ddd_celular || '-' || nr_celular as nr_telefone,   
//         c.cd_cidade,   
//         nr_endereco,
//		Cast('' as varchar(200)) as de_complemento,
//		space(60) as localizacao_endereco,
//		cast(0.00 as decimal(6,2)) vl_frete,
//		cast(0.00 as decimal(6,2)) vl_parametro_frete_gratis
//    FROM cliente c
//	INNER JOIN cidade d
//		on d.cd_cidade = c.cd_cidade
//WHERE c.cd_cliente = :cliente
	
	io_cliente.of_localiza_cliente( io_pedido.cd_cliente )
	
	dw_2.object.cd_cliente[1] = io_cliente.cd_cliente
	
	if io_cliente.nm_social = '' or isnull(io_cliente.nm_social) Then
		dw_2.object.nm_cliente[1] = io_cliente.nm_cliente
	else
		dw_2.object.nm_cliente[1] = io_cliente.nm_social
	end if
	
	dw_2.object.nr_cpf_cgc[1] = io_cliente.nr_cpf_cgc
	dw_2.object.nm_cidade[1] = io_cliente.nm_cidade
	dw_2.object.de_bairro[1] = io_cliente.de_bairro
	dw_2.object.de_endereco[1] = io_cliente.de_endereco
	dw_2.object.cd_unidade_federacao[1] = io_cliente.cd_unidade_federacao
	dw_2.object.nr_cep[1] = io_cliente.nr_cep
	dw_2.object.nr_endereco[1] = io_cliente.nr_endereco
	dw_2.object.nr_telefone[1] = io_cliente.nr_ddd_celular + '-' + io_cliente.nr_fone_celular
	//dw_2.object.de_complemento_endereco[1] = io_cliente.de
	
	dw_2.Object.Localizacao_Endereco[1] = is_Texto_Endereco
	
	If Not wf_Pedido_Minimo_Isento_Frete() Then
		CloseWithReturn(This, ls_Null)
		Return	
	End If
		
	If wf_Valor_Frete(dw_2.Object.nr_cep[1] , Ref ldc_Vl_Frete, Ref ldc_Frete_Calculado) Then
		dw_2.Object.vl_frete_calculado	[1] = ldc_Frete_Calculado
		dw_2.Object.vl_frete				[1] = ldc_Vl_Frete
	Else
		dw_2.Object.vl_frete				[1] = 0.00
		dw_2.Object.vl_frete_calculado	[1] = 0.00
	End If
	
end if

//Atualiza Forma Pagamento
wf_Atualiza_Forma_Pagamento()

This.event ue_atualiza_total_pedido( )

SetNull(ls_Null)

//Limite credito cliente
Choose Case io_Pedido.id_Tipo_Venda
	Case 'CC', 'CR'
		wf_busca_limite_cliente(Ref idc_Limite_Credito_Cliente, Ref idc_Saldo_Disponivel_Credito)
	Case 'CV'
		//Carrega as var idc_Limite_Credito_Cliente, Ref idc_Saldo_Disponivel_Credito dentro da funcao
		//Busca primeiramento o limite do conveniado
		wf_limite_conveniado_liberado(0, Ref lvdc_valor_ultrapassado)
End Choose

This.Setredraw( True )

//cd cliente
//io_Pedido.cd_Cliente = '05631000169'
//io_Pedido.cd_Cliente = '05340003460'

dw_6.Event ue_Pos(1, 'de_dados_adicionais')


end event

event key;call super::key;if key = KeyF7! Then
	wf_informar_vale_desconto()
	Event ue_atualiza_total_pedido()
end if
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge498_pedido_disque
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge498_pedido_disque
integer width = 3406
integer height = 612
string text = "Produtos"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge498_pedido_disque
integer x = 37
integer y = 56
integer width = 3378
integer height = 544
string dataobject = "dw_ge498_lista_produtos"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection( )
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;If RowCount() > 0 Then
	If IsNull(Object.cd_produto[RowCount()]) Then			
		Return -1
	End If
End If

Return 1
end event

event dw_1::ue_key;call super::ue_key;Long lvl_Produto, &
     lvl_Linha,   &
	 lvl_Saldo
	 
Decimal lvdc_Desconto

String ls_Matricula_Negociacao

Choose Case Key
	Case KeyEnter!
		Choose Case GetColumnName()
			Case "de_produto"
				If Not wf_localiza_produto() Then Return -1
				Parent.Event ue_atualiza_total_pedido()
				This.Event ue_Pos(This.GetRow(),'qt_pedida' )				
				
			Case "qt_pedida"	
				Event ue_AddRow()
				Parent.Event ue_atualiza_total_pedido()
		End Choose


	Case KeyF5!
		wf_alteracao_preco() 	
		Parent.Event ue_atualiza_total_pedido()

	Case KeyF6!
	 	lvl_Produto = This.Object.cd_produto[This.GetRow()]
		 
		If Not IsNull(lvl_Produto) Then
			
			SetNull(ivl_Produto_Busca_Facil)
			
			If is_utiliza_lista_tecnica = 'S' Then
				OpenWithParm(w_ge001_Busca_Facil_Lista_Tecnica, lvl_Produto)
			Else
				OpenWithParm(w_ge001_Busca_Facil, lvl_Produto)
			End If
			
			ivl_Produto_Busca_Facil = Message.DoubleParm
			
			If Not IsNull(ivl_Produto_Busca_Facil) and ivl_Produto_Busca_Facil > 0 Then
//				wf_Inclui_Produto()
			End If 
		End If
		
	
	Case KeyF7!
		wf_informar_vale_desconto()
		Parent.Event ue_atualiza_total_pedido()
				
End Choose

SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case 'qt_pedida'
		Parent.Event ue_atualiza_total_pedido()
End Choose
	
end event

event dw_1::editchanged;call super::editchanged;Long ll_Qtde, ll_campanha, ll_qt_maxima

Decimal ldc_pc_desconto

String ls_vale_desconto

Long ll_Produto, ll_Campanha_Vale

Choose Case dwo.Name
	Case 'qt_pedida'
		ll_Qtde			 		= This.Object.qt_pedida						[ Row ]
		ll_Produto 				= This.Object.cd_produto					[ Row ]
		ll_Campanha_Vale 	= This.Object.nr_campanha_vale_desc	[ Row ]
		
		If Not wf_qtde_maxima_permitida_vale_desconto( ll_Produto, ll_Campanha_Vale, Ref ll_qt_maxima ) Then
			Return 1
		End If
		
		If ll_qt_maxima > 0 Then
			If Long(Data) > ll_qt_maxima Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Quantidade vendida superior a m$$HEX1$$e100$$ENDHEX$$xima permitida do produto " + String( ll_Produto ) + " para o cupom desconto informado.")
				This.Object.qt_pedida	 [ Row ] = ll_Qtde
				Return 1
			End If
		End If

		Parent.Event ue_atualiza_total_pedido()
End Choose
	
end event

event dw_1::buttonclicked;call super::buttonclicked;if dwo.name = 'b_excluir' Then
	
	deleterow(row)
	
	Parent.Event ue_atualiza_total_pedido()
	
end if
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge498_pedido_disque
integer x = 2610
integer y = 2028
integer width = 498
string text = "&Finalizar Pedido"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;String ls_Forma_Pagamento
String ls_Dados_Adicionais

Integer li_Condicao

Try
	dw_1.AcceptText()
	dw_2.AcceptText()
	dw_3.AcceptText()
	dw_4.AcceptText()
	dw_5.AcceptText()
	dw_6.AcceptText()
	
	If IsNull(dw_2.Object.nr_cep[1]) Or Trim(dw_2.Object.nr_cep[1] ) ='' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o endere$$HEX1$$e700$$ENDHEX$$o de entrega.", Exclamation!)
		Return -1
	End If
	
	ls_Dados_Adicionais = dw_6.Object.de_dados_adicionais[1]
	If Trim(ls_Dados_Adicionais) = '' Then SetNull(ls_Dados_Adicionais)
	
	If Not wf_consiste_finalizacao_pedido( ) Then 
		Return -1
	End If
	
//	io_Pedido
	

	io_Pedido.cd_cliente = dw_2.object.cd_cliente[1]
//	io_Pedido.nr_matric_alteracao_frete,
//	io_Pedido.nr_matric_alteracao_preco,
//	io_Pedido.cd_conveniado,
//	io_Pedido.nr_matric_liberacao_bloqueio,
//	io_Pedido.nr_matric_liberacao_Restricao,
//	io_Pedido.nr_cartao_saude, 
//	io_Pedido.dh_entrega_marcada,   
	io_Pedido.de_endereco_entrega = dw_2.object.de_endereco[1]
//	io_Pedido.de_referencia_entrega,   
	io_Pedido.de_bairro_entrega =dw_2.object.de_bairro[1]
	io_Pedido.nr_telefone_entrega = dw_2.object.nr_telefone[1]
	io_Pedido.nm_cliente_entrega = dw_2.object.nm_cliente[1]
	io_Pedido.nr_cep_entrega = dw_2.object.nr_cep[1] 
	io_Pedido.nm_cidade_entrega = dw_2.object.nm_cidade[1] 
	io_Pedido.cd_uf_entrega = dw_2.object.cd_unidade_federacao[1]
	io_Pedido.de_complemento_endereco = dw_2.object.de_complemento[1]
	io_Pedido.nr_endereco_entrega = dw_2.object.nr_endereco[1]
	
	io_Pedido.idc_total_produtos 	= dw_1.GetItemDecimal(dw_1.RowCount(), "cp_total_produtos")
	io_Pedido.idc_frete				= dw_2.GetItemDecimal(dw_2.RowCount(), "vl_frete")
	io_Pedido.idc_frete_calculado	= dw_2.GetItemDecimal(dw_2.RowCount(), "vl_frete_calculado")
	io_Pedido.idc_pc_desconto		= 0.00
	io_Pedido.idc_total_pedido		= dw_4.GetItemDecimal(dw_4.RowCount(), "vl_total_pedido")
	io_Pedido.idc_vl_pago			= dw_4.GetItemDecimal(dw_4.RowCount(), "vl_pago")
	
	io_Pedido.idc_vl_cobrar 				= 0.00
		
	io_Pedido.id_situacao					= 'A'	
	io_Pedido.nr_matricula_operador	= '505059'
	io_Pedido.nr_matricula_vendedor	= '505059'
	
	io_Pedido.de_dados_adicionais = ls_Dados_Adicionais
	
	//Reset ds_itens
	io_Pedido.ids_Itens.Reset()
	
	//Reset ds_formas_pagamento
	io_Pedido.ids_pagamento.Reset()
	
	//transporta os itens do pedido para tratamentos no objeto
	If dw_1.RowsCopy(1, dw_1.RowCount(), Primary!, io_Pedido.ids_Itens, 1, Primary!) < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao copiar os itens para o objeto do pedido.")
		Return -1
	End If
	
	//transporta as formas de pagamento para tratamento no objeto se houver
	If dw_5.RowCount() > 0 Then
		If dw_5.RowsCopy(1, dw_5.RowCount(), Primary!, io_Pedido.ids_pagamento, 1, Primary!) < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao copiar as formas de pagamento para o objeto do pedido.")
			Return -1
		End If
	End If
	
	If Not io_Pedido.of_Grava_pedido( ) Then
		Return -1
	End If	
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pedido inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso.")
	
	CloseWithReturn(Parent, 'OK')
Finally	
	
End Try
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge498_pedido_disque
integer x = 3122
integer y = 2028
string text = "&Voltar"
end type

type dw_2 from dc_uo_dw_base within w_ge498_pedido_disque
integer x = 78
integer y = 704
integer width = 3296
integer height = 528
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge498_dados_entrega"
end type

event ue_key;call super::ue_key;
If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
	
		Case "localizacao_endereco"
			If Upper(Trim(This.GetText())) = Upper(is_Texto_Endereco) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_Texto_Endereco, StopSign!)
				Return -1
			End If
						
			wf_localiza_endereco()
			Parent.Event ue_atualiza_total_pedido()
			
	End Choose
End If

if key = KeyF7! Then
	wf_informar_vale_desconto()
	Event ue_atualiza_total_pedido()
end if
end event

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case 'id_alterar_frete'
		If Data = 'S' Then			
			If Not gvo_Aplicacao.ivo_Seguranca.of_libera_acesso_procedimento( "ALTERACAO_PRECO_FRETE", Ref io_Pedido.nr_matric_alteracao_frete) Then 
				This.Object.id_alterar_frete[1] = 'N'
				Return 1
			End If
			
			This.settaborder( 'vl_frete', 60)
			This.Event ue_Pos(1, 'vl_frete')		
		Else 
			This.settaborder( 'vl_frete', 0)
			This.Object.vl_frete[1] = This.Object.vl_frete_calculado[1] 
			SetNull( io_Pedido.nr_matric_alteracao_frete )
		End If
End Choose
end event

event editchanged;call super::editchanged;If dwo.Name = 'vl_frete' Then
	Parent.event ue_atualiza_total_pedido( )
End If
end event

event itemfocuschanged;call super::itemfocuschanged;
if dwo.name = 'localizacao_endereco' then
	Object.Localizacao_Endereco[1] = ''
else
	Object.Localizacao_Endereco[1] = is_Texto_Endereco
end if
end event

type dw_3 from dc_uo_dw_base within w_ge498_pedido_disque
integer x = 37
integer y = 1340
integer width = 1723
integer height = 408
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge498_forma_pagamento"
end type

event itemchanged;call super::itemchanged;//Integer  li_Parcelas, ll_Null
//Decimal ldc_Vl_Parcela, ldc_Frete, ldc_Total_Pedido
//
//SetNull(ll_Null)
//
//Choose Case Lower(dwo.Name) 
//	Case "id_forma_pagamento"
//		This.Object.st_Valor_Parcela.Text = ''
//		
//		This.Object.nr_parcelas_cartao[ Row ] = ll_Null
//		
//		If Data = 'CP' Then
//			This.Object.nr_parcelas_cartao[Row] = 1
//			This.Event ue_Pos(1, 'nr_parcelas_cartao')
//			This.Event itemchanged( row, This.Object.nr_parcelas_cartao, '1' )
//			This.acceptText()
//		End If
//		
//	Case "nr_parcelas_cartao"
//		dw_2.AcceptText()
//		dw_4.AcceptText()
//		
//		This.Object.st_Valor_Parcela.Text = ""
//		
//		If Not IsNull(Data) and Trim(Data) <> "" Then			
//			li_Parcelas 			= Integer(Data)
//			ldc_Frete				= dw_2.object.vl_frete			[1]
//			ldc_Total_Pedido	= dw_4.Object.vl_total_pedido	[1]
//			
//			If IsNull(ldc_Frete) 			Then ldc_Frete 			= 0
//			If IsNull(ldc_Total_Pedido) 	Then ldc_Total_Pedido 	= 0
//
//			ldc_Vl_Parcela =  Round(( ldc_Total_Pedido + ldc_Frete) / li_Parcelas, 2 )
//			
//			If li_Parcelas > 1 Then			
//				If ldc_Vl_Parcela < idc_Vl_Parcela_Minima_Tef Then
//					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor m$$HEX1$$ed00$$ENDHEX$$nimo da parcela n$$HEX1$$e300$$ENDHEX$$o atingido. ( R$ " +String( idc_Vl_Parcela_Minima_Tef, '#,##0.00' ) + ' )' )
//					This.Object.nr_parcelas_cartao[ Row ] = 1
//					This.Object.st_Valor_Parcela.Text = String(1) + "x de R$ " + String(ldc_Total_Pedido + ldc_Frete,  '#,##0.00' ) + ' sem juros'
//					Return 1
//				End If
//			End If
//			
//			This.Object.st_Valor_Parcela.Text = String(li_parcelas) + "x de R$ " + String( ldc_Vl_Parcela,  '#,##0.00' ) + ' sem juros'
//		End If
//End Choose
end event

event ue_key;call super::ue_key;if key = KeyF7! Then
	wf_informar_vale_desconto()
	Event ue_atualiza_total_pedido()
end if
end event

type gb_entrega from groupbox within w_ge498_pedido_disque
integer x = 27
integer y = 632
integer width = 3401
integer height = 628
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Dados de Entrega"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge498_pedido_disque
integer x = 18
integer y = 1272
integer width = 1774
integer height = 860
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Dados de Pagamento"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within w_ge498_pedido_disque
integer x = 1810
integer y = 1344
integer width = 1595
integer height = 268
integer taborder = 20
string dataobject = "dw_ge498_total_pedido"
end type

event ue_key;call super::ue_key;if key = KeyF7! Then
	wf_informar_vale_desconto()
	Event ue_atualiza_total_pedido()
end if
end event

type dw_5 from dc_uo_dw_base within w_ge498_pedido_disque
integer x = 46
integer y = 1840
integer width = 1714
integer height = 272
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge498_multiplas_formas_pagamento"
boolean vscrollbar = true
end type

event clicked;call super::clicked;Integer li_Row
If dwo.Name = 'cb_excluir_pagto' Then
	li_Row = dw_5.getRow()
	dw_5.deleterow(li_Row)
	Parent.event ue_atualiza_total_pedido( )
End If
end event

event ue_key;call super::ue_key;if key = KeyF7! Then
	wf_informar_vale_desconto()
	Event ue_atualiza_total_pedido()
end if
end event

type cb_incluir_pagamento from commandbutton within w_ge498_pedido_disque
integer x = 50
integer y = 1704
integer width = 690
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Incluir Pagamento"
end type

event clicked;String ls_Retorno, ls_Forma_Pagto, ls_descricao

Integer li_Row, li_Parcelas_Cartao

Decimal{2} ldc_Valor_Pago, ldc_Total_Multiplos_Pagamento, ldc_Total_Pedido, ldc_Vl_Pago_aVista

dw_4.AcceptText()
dw_5.AcceptText()

ldc_Total_Multiplos_Pagamento 	= dw_5.GetItemDecimal(1, 'cp_total_multiplos_pagto' )	
ldc_Total_Pedido						= dw_4.GetItemDecimal(1, 'vl_total_pedido' )	

If ldc_Total_Multiplos_Pagamento + idc_Credito_Utilizado >= ldc_Total_Pedido Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor total do pedido j$$HEX1$$e100$$ENDHEX$$ atendido.", Exclamation!)
	Return -1
End If

If io_Pedido.id_tipo_venda = 'CV' And Not ib_Permite_Pagar_Dif_avista Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O conv$$HEX1$$ea00$$ENDHEX$$nio selecionado n$$HEX1$$e300$$ENDHEX$$o permite pagamento $$HEX1$$e000$$ENDHEX$$ Vista.", Exclamation!)
	Return -1
End If

openWithParm(w_ge498_adicionar_pagamento, io_Pedido.id_tipo_venda)

ls_Retorno 				= Message.StringParm
ls_Forma_Pagto 		= Mid(ls_Retorno, 1,2)
li_Parcelas_Cartao 	= Integer(Mid(ls_Retorno, 3,1))
ldc_Valor_Pago			= Dec(Mid(ls_Retorno, 4))

If IsNull(ls_Retorno) Then
	Return -1
End If

Choose Case ls_Forma_Pagto
	Case 'DI'
		ls_descricao = 'DINHEIRO'
		SetNull(li_Parcelas_Cartao)
	Case 'CP'
		ls_descricao = 'CR$$HEX1$$c900$$ENDHEX$$DITO'
		If ldc_Valor_Pago > (ldc_Total_Pedido - ldc_Total_Multiplos_Pagamento) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor do pagamento " + ls_descricao + " superior ao valor total do pedido.~rInforme apenas R$ " +String(ldc_Total_Pedido - ldc_Total_Multiplos_Pagamento, '#,##0.00'))
			Return -1
		End If	
		
	Case 'CA'
		ls_descricao = 'D$$HEX1$$c900$$ENDHEX$$BITO'
		If ldc_Valor_Pago > (ldc_Total_Pedido - ldc_Total_Multiplos_Pagamento) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor do pagamento " + ls_descricao + " superior ao valor total do pedido.~rInforme apenas R$ " +String(ldc_Total_Pedido - ldc_Total_Multiplos_Pagamento, '#,##0.00'))
			Return -1
		End If
		SetNull(li_Parcelas_Cartao)
				
	Case Else
		ls_descricao = 'N$$HEX1$$c300$$ENDHEX$$O PREVISTO'
		Return -1
End Choose

//Convenio/Clube Prazo/Crediario
If io_Pedido.id_tipo_venda <> 'AV' Then
	If ls_Forma_Pagto <> 'DI' Then
		ldc_Vl_Pago_aVista = ldc_Total_Pedido - idc_Credito_Utilizado - ldc_Total_Multiplos_Pagamento
	
		If ldc_Vl_Pago_aVista > 0 Then
			If  ldc_Valor_Pago > ldc_Vl_Pago_aVista Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor do pagamento " + ls_descricao + " superior ao valor a ser pago $$HEX1$$e000$$ENDHEX$$ vista.~rInforme apenas R$ " +String(ldc_Vl_Pago_aVista, '##,##0.00'))
				Return -1				
			End If
		End If
	End If
End If

li_Row = dw_5.InsertRow(0)
dw_5.Object.cd_forma_pagamento	[li_Row] = ls_Forma_Pagto
dw_5.Object.de_forma_pagamento	[li_Row] = ls_descricao
dw_5.Object.vl_pagamento				[li_Row] = ldc_Valor_Pago
dw_5.Object.nr_parcelas_cartao		[li_Row] = li_Parcelas_Cartao
dw_5.Object.nr_sequencial				[li_Row] = li_Row


Parent.event ue_atualiza_total_pedido( )



end event

type dw_6 from dc_uo_dw_base within w_ge498_pedido_disque
integer x = 1833
integer y = 1700
integer width = 1577
integer height = 260
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge498_dados_adicionais"
end type

event ue_key;call super::ue_key;if key = KeyF7! Then
	wf_informar_vale_desconto()
	Event ue_atualiza_total_pedido()
end if
end event

type gb_pagamento from groupbox within w_ge498_pedido_disque
integer x = 1801
integer y = 1276
integer width = 1632
integer height = 348
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Finalizar Pedido"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_ge498_pedido_disque
integer x = 1801
integer y = 1636
integer width = 1632
integer height = 352
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Observa$$HEX2$$e700f500$$ENDHEX$$es"
borderstyle borderstyle = styleraised!
end type

type datastore_1 from datastore within w_ge498_pedido_disque descriptor "pb_nvo" = "true" 
end type

on datastore_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on datastore_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

