HA$PBExportHeader$w_ge108_consulta_preco.srw
forward
global type w_ge108_consulta_preco from dc_w_sheet
end type
type dw_8 from dc_uo_dw_base within w_ge108_consulta_preco
end type
type dw_7 from dc_uo_dw_base within w_ge108_consulta_preco
end type
type dw_5 from dc_uo_dw_base within w_ge108_consulta_preco
end type
type dw_saveas from dc_uo_dw_base within w_ge108_consulta_preco
end type
type dw_atalhos from datawindow within w_ge108_consulta_preco
end type
type gb_7 from groupbox within w_ge108_consulta_preco
end type
type gb_4 from groupbox within w_ge108_consulta_preco
end type
type dw_2 from dc_uo_dw_base within w_ge108_consulta_preco
end type
type dw_3 from dc_uo_dw_base within w_ge108_consulta_preco
end type
type pb_1 from picturebutton within w_ge108_consulta_preco
end type
type gb_2 from groupbox within w_ge108_consulta_preco
end type
type gb_1 from groupbox within w_ge108_consulta_preco
end type
type gb_5 from groupbox within w_ge108_consulta_preco
end type
type dw_4 from dc_uo_dw_base within w_ge108_consulta_preco
end type
type dw_1 from dc_uo_dw_base within w_ge108_consulta_preco
end type
end forward

global type w_ge108_consulta_preco from dc_w_sheet
string accessiblename = "Atendimento ao Cliente (GE108)"
integer x = 215
integer y = 220
integer width = 3589
integer height = 1884
string title = "GE108 - Atendimento ao Cliente"
string menuname = "m_ge108_atendimento_cliente"
boolean maxbox = true
long backcolor = 80269524
string icon = "AppIcon!"
event ud_addrow ( )
event ue_estoque_outras_filiais ( )
event ue_reservar_produto ( )
event ue_buscar_reserva ( )
event ue_buscar_ultimo_cliente ( )
event ue_finalizar_reserva ( boolean ab_possui_disque )
event ue_calcular_pbm_clamed ( )
event ue_busca_facil ( )
event ue_chamar_senha ( )
event ue_cobre_preco ( )
event ue_captura_cartao_desconto ( )
event ue_cartao_desconto ( )
event ue_produto_favorito ( )
event type boolean ue_incluir_pedido_disque_entrega ( )
event ue_reimprimir_cupom_pre ( )
event ue_dermaclub ( )
dw_8 dw_8
dw_7 dw_7
dw_5 dw_5
dw_saveas dw_saveas
dw_atalhos dw_atalhos
gb_7 gb_7
gb_4 gb_4
dw_2 dw_2
dw_3 dw_3
pb_1 pb_1
gb_2 gb_2
gb_1 gb_1
gb_5 gb_5
dw_4 dw_4
dw_1 dw_1
end type
global w_ge108_consulta_preco w_ge108_consulta_preco

type variables
Boolean ib_Painel_Senha = False
Boolean ib_Conclusao_Atendimento_Pendente = False
Boolean ib_OBRIGA_INFORMAR_USUARIO_ATEND_GE108 = False

//Reserva de produto
//Utilizada para n$$HEX1$$e300$$ENDHEX$$o adicionar uma nova linha ao passar um produto prestes
//Evento ue_Buscar_Reserva muda o valor para True
Boolean ib_Reserva_Produto = False

Long il_Caixa

uo_ge108_produto		ivo_produto
uo_vendedor			ivo_vendedor
uo_parametro_filial	ivo_parametro
uo_cliente				ivo_cliente
uo_convenio				io_convenio // GE004
uo_produto				io_Produto_Geral

uo_rl154_parametros io_Cobre_Preco 

uo_condicao_venda_convenio io_condicao_convenio // GE006

uo_ge536_dermaclub_loja ivo_dermaclub

Decimal idc_Pontos_Cliente

Date idt_Nascimento

DateTime idh_Atualizacao_Fase_Cliente
DateTime idh_Solicitou_Atualizacao_Cliente

String is_Fase_Atualizacao_Cliente
String	is_Cliente_Possui_Campanha

Boolean ib_Produto_Vencido 					= False
Boolean ib_Produto_Informado 				= False
Boolean ib_Venda_pbm_clamed 				= False
Boolean ib_item_pbm_excluido 				= False
Boolean ib_Pedido_Disque_Entrega			= False
Boolean ib_Loja_Disque_Entrega				= False
Boolean ib_Venda_Dermaclub	 				= False
Boolean ib_Dermaclub_ativo						= False
Boolean ib_Venda_Portal_Drogaria			= False

Integer	ivi_dias_pedido_pendente
Integer	ivi_pedidos_ecommerce_pendente
Integer	ivi_Qtde_Itens_Reservados = 0

long ivl_produto_busca_facil
long il_Sequencial_Cliente_Caixa
Long il_seq_cliente_caixa_prd = 0

String is_cliente
String is_Matricula_Negociacao
String is_Vendedor_Negociacao
String is_Permite_Negociacao = 'N'   		//Teclas [Shift] + [END]
String is_Matricula_Vendedor
String is_Nm_Vendedor
String is_Mostra_Msg_Saldo_Zero = 'N' 	//Configurado no cadastro de parametro
String is_cpf_vendedor

String is_Situacao_Reserva_Disque_Entrega

dc_uo_ds_base ids_Negociacao
dc_uo_ds_base ids_Negociacao_Aux

dc_uo_ds_base ids_pbm_clamed
dc_uo_ds_base ids_contratos_bin
dc_uo_ds_base ids_Prd_Campanha_Cliente


uo_parametro_pdv io_parametro_pdv
OleObject iole_painel_senha
OleObject iole_painel_senha_2

srt_ge108_painel_senha istr_painel_senha
uo_ge108_reserva_produtos io_ge108_reserva_produtos

String is_Legenda_Menu_F9 = "Consulta Estoque Filiais	F9"
String is_Legenda_Menu_F6 = "Busca Facil	F6"

//Brinde
String is_brinde_ativo
Decimal {2} idc_brinde

String is_utiliza_lista_tecnica
String is_cartao_desconto
String is_Cartao_Industria_PBM
String is_CPF_Nao_Identificado

//Usado para aguardar a impress$$HEX1$$e300$$ENDHEX$$o de cupom pr$$HEX1$$e900$$ENDHEX$$ para evitar que a tecla END seja pressionada antes de terminar a impress$$HEX1$$e300$$ENDHEX$$o
Boolean ib_AGUARDAR_ATIVO  = False

//Usado para novas valida$$HEX2$$e700f500$$ENDHEX$$es LGPD
Constant String 	CPF 		= 'CPF',&
						NOME 	= 'NOME'
String is_forma_atendimento

end variables

forward prototypes
public subroutine wf_localiza_vendedor ()
public function long wf_saldo_produto (long pl_produto)
public function string wf_verifica_local_estocagem (long pl_produto)
public function string wf_verifica_situacao (long pl_produto)
public function boolean wf_comissao_extra (ref integer ai_contador, long al_linha)
public subroutine wf_inclui_produto ()
public subroutine wf_muda_figura ()
public subroutine wf_verifica_vidalink (long pl_produto, long pl_linha)
public function decimal wf_promocao_sos_farm_popular ()
public subroutine wf_verifica_pbm (long pl_produto, long pl_linha)
public subroutine wf_localiza_cliente ()
public subroutine wf_conclui_venda ()
public subroutine wf_cadastra_cliente ()
public subroutine wf_inicia_atendimento ()
public subroutine wf_atualiza_cliente (string ps_fase)
public subroutine wf_atualiza_cliente ()
public subroutine wf_localiza_dependente ()
public function boolean wf_verifica_fase_atualizacao (ref string ps_fase)
public function boolean wf_registra_produto_sem_saldo (integer pl_linha)
public function boolean wf_verifica_se_possui_cartao (string ps_cliente)
public function boolean wf_localiza_dados_distribuido ()
public function boolean wf_imprime_orcamento_judicial (boolean pb_imeditato)
public function boolean wf_existe_produto_orcamento (decimal pdc_desconto_produto)
public function integer wf_localiza_produto_prestes ()
public subroutine wf_drivers_painel_senha ()
public subroutine wf_driver_painel_senha ()
public function boolean wf_connecttonewobject (ref oleobject p_object, string ps_conexao)
public function boolean wf_negociacao_cliente ()
public function boolean wf_grava_negociacao_cliente (long al_sequencial)
public function decimal wf_pc_icms_produto ()
public function boolean wf_conclui_desistencia ()
public subroutine wf_inicializa_objetos ()
public function boolean wf_localiza_produto (string ps_parametro)
public function boolean wf_new_seq_cliente_caixa ()
public function integer wf_alerta_reserva_pendente ()
public subroutine wf_conclui_desistencia_ped_empurrado ()
public function boolean wf_calcula_pbm_clamed ()
protected function boolean wf_aplica_desconto_pbm_clamed (long pl_row, decimal pdc_desconto, long pl_promocao, boolean pb_somente_vinculo, long pl_produto_venda, long pl_produto_vinculo, decimal pdc_preco_unitario, string ps_tipo_inclusao, string ps_tipo_replicacao, boolean pb_altera_item, long pl_qtd_vinculo, long pl_qtdade)
public function boolean wf_conclui_pbm ()
public subroutine wf_localiza_convenio ()
public subroutine wf_localiza_condicao_conv ()
public subroutine wf_bloqueia_campos_convenio ()
public function decimal wf_localiza_desconto_produto (ref decimal adc_pc_desc_convenio)
public subroutine wf_altera_rotulo_end ()
public function boolean wf_cobre_preco ()
public subroutine wf_bloqueia_libera_campos_cliente ()
public function boolean wf_grava_cobre_preco ()
public function boolean wf_atualiza_cobre_preco ()
public function boolean wf_cliente_vendedor (string ps_matricula, string ps_cpf_cliente)
public subroutine wf_verifica_campanha_promocional ()
public function boolean wf_cobre_preco_produto_bloqueio (long al_produto)
public subroutine wf_verifica_pedido_ecommerce_pendente ()
public function boolean wf_verifica_caixa_nao_finalizado ()
public function boolean wf_novo_disque ()
public function boolean wf_cupom_pre_ja_emitido (string ps_cliente, ref boolean ab_imprimir)
public function decimal wf_desconto_campanha ()
public function boolean wf_imprime_pedido_disque_entrega (long al_roteiro_entrega)
public subroutine wf_conclui_venda (string ps_tipo_pagamento_reserva)
public function boolean wf_pdv_imprime_cupom_pre ()
public function boolean wf_verifica_coleta_lgpd_matriz (string ps_cliente, ref boolean pb_coletado)
public function boolean wf_gera_autorizacao_pbm ()
public function boolean wf_verifica_cupom_consumidor (ref string as_obrigada_cupom_consumidor)
public subroutine wf_localiza_cliente (boolean ab_ultimo_cliente_atendido)
public subroutine wf_consulta_desconto_portal_drogaria (ref boolean ab_produto_portal)
public subroutine wf_existe_produtos_pbm_portal_drogaria (ref boolean ab_pbm_portal_drogaria, ref boolean ab_informa_cartao, ref boolean ab_informa_cpf)
public subroutine wf_atualiza_cliente_caixa_produto (decimal adc_vl_frete)
end prototypes

event ud_addrow();dw_2.Event ue_AddRow()

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

event ue_estoque_outras_filiais();Long ll_Linha, &
     ll_Produto,&
	  ll_filial,&
	  ll_Qtde

String ls_Retorno
String ls_Matricula_Transf

Boolean lb_Produto_Ja_Reservado

dw_1.AcceptText()
dw_2.AcceptText()

Try

	ll_Linha = dw_2.GetRow()
	
	If ll_Linha > 0 Then
		ll_Produto   						= dw_2.Object.Cd_Produto		[ ll_Linha ]
		lb_Produto_Ja_Reservado	= ( dw_2.Object.Id_Reservado	[ ll_Linha ] = 'S' )
		ll_Qtde							= dw_2.Object.qt_orcada		[ ll_Linha ]
		
		If Not IsNull(ll_Produto) and ll_Produto > 0 Then			
			uo_ge108_parametros lo
			lo = Create uo_ge108_parametros
			
			lo.filial 									= dw_2.Object.cd_filial_reserva[ ll_Linha ] //
			lo.produto 								= ll_Produto
			lo.matricula_vendedor				= is_Matricula_Vendedor
			lo.Qtde_solicitada						= ll_Qtde
			lo.Cliente									= ivo_cliente.Cd_Cliente
			lo.Habilita_Botao_Reserva_GE107 	= True
				
			OpenWithParm( w_ge107_consulta_saldo_matriz_response , lo )
			
			//Retorno da tela
			lo = Message.PowerObjectParm
			
			If IsNull(lo.Retorno)  Then 
				Return 
			Else
				ll_Filial 					= lo.filial
				ls_Matricula_Transf 	= lo.matricula_resp_reserva
				
				If ( ll_Filial = 0 Or ll_Filial = gvo_Parametro.cd_Filial ) Then SetNull( ll_Filial )
				
				If ls_Matricula_Transf = "" 	Then SetNull( ls_Matricula_Transf )
					
				dw_2.Object.nr_pedido_empurrado			[ ll_Linha ] = lo.Pedido_Empurrado
				dw_2.Object.cd_mix_produto					[ ll_Linha ] = lo.mix_Produto
				dw_2.Object.qt_minima_aprovacao			[ ll_Linha ] = lo.Qtde_Minima_Aprovacao
							
				dw_2.Object.cd_filial_reserva					[ ll_Linha ] = ll_filial
				dw_2.Object.nr_matric_atendente_reserva	[ ll_Linha ] = ls_Matricula_Transf
				dw_2.Object.id_reservado						[ ll_Linha ] = "S"
				
				If Not lb_Produto_Ja_Reservado And dw_2.Object.id_reservado [ ll_Linha ] = 'S' Then 
					ivi_Qtde_Itens_Reservados++

					dw_1.SetTabOrder( "localizacao", 0 )
					dw_1.Modify("localizacao.background.color='134217750'") // Button Light Shadow
					dw_1.Modify("nr_cpf.background.color='134217750'")	
					dw_1.Modify("nm_dependente.background.color='134217750'")	
				End If
				wf_altera_rotulo_end()
			End If
			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o estoque em outras filiais.", Information!)
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o estoque em outras filiais.", Information!)
	End If
	
Finally
	If IsValid( lo ) Then Destroy lo
	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
End Try
end event

event ue_reservar_produto();Boolean lb_Produto_Ja_Reservado = False

Long ll_Linhas, ll_Filial, ll_Row
Long ll_Produto
Long ll_Pedido_Empurrado
Long ll_Pedido
Long ll_Qtde_Solicitada
Long ll_Find

String ls_Matricula
String ls_Parametro
String ls_Retorno
String ls_Matricula_Resp_Reserva

//Pode ser utilizado em novos menus
//w_ge107_consulta_saldo_matriz_response lvw
//OpenSheetWithParm(lvw, String(ll_Produto, "000000"), w_Frame, 0, Original!)
//OpenSheetWithParm(lvw, String(ll_Produto, "000000"), This, 0, Original! )
			
Try
	
	dw_1.AcceptText()
	dw_2.AcceptText()

	If IsNull( ivo_cliente.cd_Cliente ) Then
		MessageBox( "Reserva de produto", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio ter um cliente identificado.", Exclamation! )
		dw_1.Event ue_Pos( 1, 'localizacao' )
		Return
	End If
	
	ll_Linhas = dw_2.RowCount()
	
	If ll_Linhas > 0 Then
		ll_Row = dw_2.GetRow()

		ll_Produto 						= dw_2.Object.cd_produto							[ ll_Row ]
		
		io_produto_Geral.of_localiza_codigo_interno(ll_Produto)
		If Mid(io_produto_Geral.cd_subcategoria, 1,1) = '5' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido reservar produtos do Almoxarifado.", Exclamation!)
			Return
		End If		
		
		ll_Filial							= dw_2.Object.cd_filial_reserva					[ ll_Row ]
		ls_Matricula_Resp_Reserva 	= dw_2.Object.nr_matric_atendente_reserva	[ ll_Row ]
		ll_Pedido_Empurrado			= dw_2.Object.nr_pedido_empurrado			[ ll_Row ]
		ll_Qtde_Solicitada				= dw_2.Object.qt_orcada							[ ll_Row ]
		
		lb_Produto_Ja_Reservado = ( dw_2.Object.Id_Reservado[ ll_Row ] = 'S' )
						
		If IsNull( ll_Produto ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para reserv$$HEX1$$e100$$ENDHEX$$-lo.", Information!)
			Return
		End If		
		
		//Atendimento que foi usado ue_buscar_reserva
		If ib_Reserva_Produto Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este atendimento j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ vinculado $$HEX1$$e000$$ENDHEX$$ uma reserva.~rFinalize o antendimento antes de continuar.")
			Return
		End If
		
		If lb_Produto_Ja_Reservado And ll_Filial = 534 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ existe um pedido urgente pr$$HEX1$$e900$$ENDHEX$$-reservado para esse produto.", Information!)
			Return
		End If
								
		If IsNull(ll_Filial) 							Then ll_Filial 							= 0
		If IsNull(ls_Matricula_Resp_Reserva) 	Then ls_Matricula_Resp_Reserva 	= ""
		
		uo_ge108_parametros lo
		lo = Create uo_ge108_parametros
		
		lo.filial 							= ll_Filial
		lo.produto 						= ll_Produto
		lo.matricula_resp_reserva	= ls_Matricula_Resp_Reserva
		lo.matricula_vendedor		= is_Matricula_Vendedor
		lo.Pedido_Empurrado			= ll_Pedido_Empurrado
		lo.Qtde_solicitada				= ll_Qtde_Solicitada
		lo.Cliente							= ivo_cliente.cd_Cliente
		
		OpenWithParm( w_ge108_transferencia_para_reserva, lo )
		
		lo = Message.PowerObjectParm
		
		If IsNull(lo.Retorno)  Then 
			Return 
		Else
			ll_Filial 		= lo.filial
			ls_Matricula = lo.matricula_resp_reserva
			
			If ( ll_Filial = 0 Or ll_Filial = gvo_Parametro.cd_Filial ) Then SetNull( ll_Filial )
			
			If ls_Matricula 	= "" 	Then SetNull( ls_Matricula )
			
			//If Not lb_Produto_Ja_Reservado Then
			If Not IsNull(ll_Filial) Then 
				ll_Find = dw_2.Find( "cd_produto = " + String( ll_Produto ) + " and cd_filial_reserva = " + String(ll_Filial), 1, ll_Linhas )
				
				If ll_Find > 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto " + String( ll_Produto ) + " j$$HEX1$$e100$$ENDHEX$$ possui uma reserva da filial " +String( ll_Filial ) + ".", Exclamation!)
					Return
				End If
			End If
				
			dw_2.Object.cd_filial_reserva					[ ll_Row ] = ll_Filial
			dw_2.Object.nr_matric_atendente_reserva	[ ll_Row ] = ls_Matricula
			dw_2.Object.nr_pedido_empurrado			[ ll_Row ] = lo.Pedido_Empurrado
			dw_2.Object.cd_mix_produto					[ ll_Row ] = lo.mix_Produto
			dw_2.Object.qt_minima_aprovacao			[ ll_Row ] = lo.Qtde_Minima_Aprovacao
			
			dw_2.Object.id_reservado						[ ll_Row ] = 'S'
			
			If Not lb_Produto_Ja_Reservado Then ivi_Qtde_Itens_Reservados++
			
			wf_altera_rotulo_end()
			dw_1.SetTabOrder( "localizacao", 0 )
			dw_1.Modify("localizacao.background.color='134217750'") // Button Light Shadow
			dw_1.Modify("nr_cpf.background.color='134217750'")	
			dw_1.Modify("nm_dependente.background.color='134217750'")			
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para reserv$$HEX1$$e100$$ENDHEX$$-lo.", Information!)
	End If
Finally	
	If IsValid(lo) Then Destroy lo
	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
End Try


end event

event ue_buscar_reserva();Long ll_Linha, ll_Produto, ll_Qtde, ll_Linha_Nova, ll_Seq_Produto_Aux, ll_Prod_Anterior, ll_Find, ll_Filial_Transf

Integer li_Seq_Cliente_Caixa_Prd, li_Seq_Prd

String ls_cliente

Try

	dw_1.AcceptText()
	
	If IsNull( ivo_Cliente.Cd_Cliente ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um cliente.")
		dw_1.Event ue_Pos( 1, "localizacao" )
		Return
	End If
	
	//O cliente n$$HEX1$$e300$$ENDHEX$$o possui reservas
	If Not ivo_Cliente.of_possui_reserva_produto( ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O cliente n$$HEX1$$e300$$ENDHEX$$o possui reserva.", Information! )
		Return				
	End If	
	
	If dw_2.Find( "cd_filial_reserva=534", 1, dw_2.RowCount() ) > 0  Then
		MessageBox("Pedido Urgente", "Existem produtos pr$$HEX1$$e900$$ENDHEX$$-reservados para o cd.~rFinalize o atendimento antes de continuar.", Information!)
		Return
	End If	
	
	If dw_2.Find( "not isNull(cd_produto)", 1, dw_2.RowCount() ) > 0  Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os produtos listados ser$$HEX1$$e300$$ENDHEX$$o removidos. Deseja continuar?", Question!, YesNo!, 2) = 2 Then
			Return
		End If
	End If		
	
	//Atribui o sequencial dos itens da cliente_caixa_produto
	ll_Seq_Produto_Aux =  il_seq_cliente_caixa_prd
	
	OpenWithParm( w_ge108_consulta_reserva, ivo_Cliente.Cd_Cliente )
	
	If IsNull( Message.powerObjectParm ) Then
		//Volta o ultimo sequencial da cliente_caixa_produto
		//il_seq_cliente_caixa_prd = ll_Seq_Produto_Aux
		Return
	Else
		dw_2.Event ue_Reset()
	
		uo_ge108_reserva_produtos lo_Produtos
		lo_Produtos = Create uo_ge108_reserva_produtos
		
		lo_Produtos = Message.powerObjectParm
	End If
	
	ib_Reserva_Produto = True
	
	For ll_Linha = 1 To UpperBound( lo_Produtos.il_produtos[] )
		ll_Produto						= lo_Produtos.il_Produtos		[ ll_Linha ]
		ll_Qtde 							= lo_Produtos.il_Qtdes			[ ll_Linha ]
		li_Seq_Cliente_Caixa_Prd	= lo_Produtos.il_Seq				[ ll_Linha ]
		ll_Filial_Transf					= lo_Produtos.il_Filial_Transf	[ ll_Linha ]
		
		ll_Linha_Nova = dw_2.Event ue_AddRow()
		
		dw_2.Event ue_Pos(ll_Linha_Nova, "de_produto")
	
		wf_localiza_Produto( String( ll_Produto ) ) 
		
		dw_2.Event ue_Pos(ll_Linha_Nova, "qt_orcada")
	
		dw_2.Object.qt_orcada						[ ll_Linha_Nova ] = ll_Qtde
		dw_2.Object.nr_seq_cliente_caixa_prd	[ ll_Linha_Nova ] = li_Seq_Cliente_Caixa_Prd
		dw_2.Object.cd_filial_reserva				[ ll_Linha_Nova ] = ll_Filial_Transf
	
	Next
	
	//ib_Reserva_Produto = False
	
	dw_1.SetTabOrder( "localizacao", 0 )
	dw_1.Modify("localizacao.background.color='134217750'") // Button Light Shadow
	dw_1.Modify("nr_cpf.background.color='134217750'")	
	dw_1.Modify("nm_dependente.background.color='134217750'")
	
	Select  max( nr_sequencial )
		Into :li_Seq_Prd
	from cliente_caixa_produto
	where cd_filial 							= dbo.uf_filial_parametro()
	and	nr_sequencial_cliente_caixa	= :lo_Produtos.il_Sequencial_Cliente_caixa
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Msgdberror( "Erro ao localizar o max (nr_sequencial) cliente_caixa_produto" )
		Return
	End If
	
	//deleta o sequencial cliente_caixa inserido na abertura da tela
	delete from cliente_caixa where nr_sequencial = :il_Sequencial_Cliente_Caixa
	Using SqlCa;
	//
	SqlCa.of_Commit();
	
	//Atribui o sequencial da cliente_caixa que deu inicio a reserva para a finalizacao do atendimento(termino da reserva)
	il_Sequencial_Cliente_Caixa 	= lo_Produtos.il_Sequencial_Cliente_caixa
	is_Matricula_Vendedor			= lo_Produtos.is_vendedor
	
	If li_Seq_Prd > 0 Then il_seq_cliente_caixa_prd = li_Seq_Prd
	
Finally
	If IsValid( lo_Produtos ) Then Destroy lo_Produtos
	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
End Try



end event

event ue_buscar_ultimo_cliente();Boolean lb_Ultimo_Cliente_Atendido

String ls_Cliente

If Not IsNull( dw_1.Object.cd_cliente[ 1 ] ) Then 
	Return
End If

//Nenhum cliente cadastro ou atendido
If (Trim(gvs_Cliente_Cadastro) = "" Or IsNull( gvs_Cliente_Cadastro ) ) And (Trim(gvs_Ultimo_Cliente_Atendido) = "" Or IsNull( gvs_Ultimo_Cliente_Atendido ) ) Then
	Return
End If

//Busca primeiro o cliente cadastrado
//Se n$$HEX1$$e300$$ENDHEX$$o houver busca o ultimo cliente atendido
If Not IsNull(gvs_Cliente_Cadastro) And Trim(gvs_Cliente_Cadastro) <> ""Then
	ls_Cliente = gvs_Cliente_Cadastro
	gvs_Cliente_Cadastro = ''
	gvs_Ultimo_Cliente_Atendido = ls_Cliente
Else
	ls_Cliente = gvs_Ultimo_Cliente_Atendido
End If

dw_1.Object.localizacao[ 1 ] = ls_Cliente

//Na Busca pelo ultimo cliente passa como TRUE para pegar da var global a ultima forma de busca do cliente CPF/NOME
lb_Ultimo_Cliente_Atendido = TRUE
wf_Localiza_Cliente( lb_Ultimo_Cliente_Atendido )

If ivo_Cliente.Localizado Then

	If ivo_Cliente.of_possui_reserva_produto( ) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O cliente possui reserva(s). Deseja visualiz$$HEX1$$e100$$ENDHEX$$-la(s) ?", Question!, YesNo!, 1) = 1 Then  
			Event ue_buscar_reserva( )
		End If
	Else
		Return
	End If	
End If
end event

event ue_finalizar_reserva(boolean ab_possui_disque);Long ll_Linhas, ll_Filial, ll_Row
Long i, ll_Produto, li_Find_Dw2
Long ll_qtde_reserva, ll_Qtde_dw2
Long ll_Null

String  ls_Op
String ls_Null

Integer li_Retorno, li_Find
		
Try
	SetNull( ll_Null )
	SetNull( ls_Null )
	
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	If IsNull( ivo_cliente.cd_Cliente ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um cliente.")
		dw_1.Event ue_Pos( 1, "localizacao" )
		Return
	End If
	
	ll_Linhas = dw_2.RowCount()
	
	If ll_Linhas > 0 Then
		If dw_2.Find( "not isNull(cd_produto)", 1, ll_Linhas ) <= 0  Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para reserv$$HEX1$$e100$$ENDHEX$$-lo.", Information!)
			Return
		End If		
		
		ll_Row = dw_2.GetRow()
		
		uo_ge108_reserva_produtos lo_Reserva
		lo_Reserva = Create uo_ge108_reserva_produtos 
		
		lo_Reserva.is_vendedor 						= is_Matricula_Vendedor
		lo_Reserva.is_Cliente							= ivo_cliente.Cd_Cliente
		lo_Reserva.il_sequencial_cliente_caixa	= il_Sequencial_Cliente_Caixa
		
		//Reserva com negociacao devem ser realizadas somente via vale pago (no mesmo dia)
		If dw_2.Find( "id_cobre_preco = 'S'", 1, ll_Linhas ) > 0  Then
			lo_Reserva.is_Cobre_Preco = 'S'
		End If				
		
		//Vai a dw_2 atendimento
		li_Retorno = dw_2.RowsCopy(1, dw_2.RowCount(), Primary!, lo_Reserva.ds_produtos, 1, Primary!)
		
		If li_Retorno < 0 Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na fun$$HEX2$$e700e300$$ENDHEX$$o RowsCopy. Local: ue_reservar_produtos()")
			Return
		End If
		
		//Usado para informar que a reserva $$HEX1$$e900$$ENDHEX$$ com disque entrega, Neste caso desabilita o bot$$HEX1$$e300$$ENDHEX$$o pagamento antecipado.
		lo_Reserva.ib_disque_entrega = ab_Possui_Disque
		
		//Passa todos os produtos do atendimento para o cadastro da reserva
		OpenWithParm( w_ge108_reserva_produto, lo_Reserva )
			
		//Volta a lista de produtos da reserva, pode ser que os produtos da reserva tenham sofrido altera$$HEX2$$e700f500$$ENDHEX$$es
		If IsNull( lo_Reserva.is_Retorno ) Or Trim( lo_Reserva.is_Retorno ) = "" Then Return
		
		If lo_Reserva.is_Retorno = 'PA' Then
			If Not ab_possui_disque Then
				wf_Conclui_Venda( lo_Reserva.is_Retorno )
				Close(This)
				Return
			End If
		End If
		
		ls_Op = "FINALIZAR"
		
		If ab_possui_disque Then
			is_Situacao_Reserva_Disque_Entrega = lo_Reserva.is_situacao_reserva
			
			If lo_Reserva.is_Retorno = 'PA' Then
				is_Situacao_Reserva_Disque_Entrega = 'A'
			End If
		Else
			
			For i = 1 To ll_Linhas
				dw_2.Object.id_reservado						[ i ] = 'N'
				dw_2.Object.cd_filial_reserva					[ i ] = ll_Null
				dw_2.Object.nr_matric_atendente_reserva	[ i ] = ls_Null
				dw_2.Object.nr_pedido_empurrado			[ i ] = ll_Null
				dw_2.Object.cd_mix_produto					[ i ] = ll_Null
				dw_2.Object.qt_minima_aprovacao			[ i ] = ll_Null
				
				ll_Produto 	= dw_2.Object.cd_produto		[ i ] 
				ll_qtde_dw2	= dw_2.Object.qt_orcada		[ i ] 
				
				li_Find = lo_Reserva.ds_produtos.find( "cd_produto = " + String(ll_Produto), 1, lo_Reserva.ds_produtos.RowCount() )
			
				If li_Find > 0 Then			
					ll_qtde_reserva		= lo_Reserva.ds_Produtos.Object.qt_produto	[ li_find ]
					
					If (ll_qtde_dw2 - ll_qtde_reserva) > 0 Then 
						//dw_2.Object.id_reservado[ li_Find_Dw2 ] = 'N'
						dw_2.Object.qt_orcada [ i ] = ll_qtde_dw2 - ll_qtde_reserva
						ls_Op = "NOVACESTA"
						Continue
					End If
					
					If lo_Reserva.ds_Produtos.Object.id_selecao [ li_find ] = 'N' And ll_qtde_reserva > 0 Then
						ls_Op = "NOVACESTA"
					End If
					
				End If
			Next
			
		End If		
		
		ivi_Qtde_Itens_Reservados = 0
		dw_1.Object.end_t.Visible 	= True
		dw_1.Object.end_r_t.Visible	= False
		
		Choose Case ls_Op
			Case 'NOVACESTA'
				If wf_New_Seq_Cliente_Caixa() Then
					If Not ab_possui_disque Then
						wf_Conclui_Venda()
					End If
				End If
			Case 'FINALIZAR'
				This.ib_Conclusao_Atendimento_Pendente = False
				If Not ab_possui_disque Then
					Close(This)
				End If
		End Choose
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para reserv$$HEX1$$e100$$ENDHEX$$-lo.", Information!)
	End If
Finally
	If IsValid( lo_Reserva ) Then Destroy lo_Reserva	
End Try


end event

event ue_calcular_pbm_clamed();If ib_item_pbm_excluido Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Um produto calculado com desconto PBM Clamed foi removido.~r~rInicie um novo atendimento.", Exclamation!)
	Return
End If

If wf_calcula_pbm_clamed() Then
	If ib_Venda_pbm_clamed Then
		wf_altera_rotulo_end()
	End If
End If

SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
end event

event ue_busca_facil();Long lvl_Produto

If dw_2.RowCount( ) > 0 Then

	lvl_Produto = dw_2.Object.cd_produto[ dw_2.GetRow() ]
	 
	If Not IsNull(lvl_Produto) Then
		
		SetNull(ivl_Produto_Busca_Facil)
		
		if is_utiliza_lista_tecnica = 'S' Then
			OpenWithParm(w_ge001_Busca_Facil_lista_tecnica, lvl_Produto)
		else
			OpenWithParm(w_ge001_Busca_Facil, lvl_Produto)
		end if
		
		ivl_Produto_Busca_Facil = Message.DoubleParm
		
		If Not IsNull(ivl_Produto_Busca_Facil) and ivl_Produto_Busca_Facil > 0 Then
			wf_Inclui_Produto()
		End If 
	End If
	
End If

SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
end event

event ue_chamar_senha();If Not ivo_Cliente.Localizado And ib_Painel_Senha Then
	OpenWithParm( w_ge108_painel_senha, istr_Painel_Senha )
End If
end event

event ue_cobre_preco();If ib_Venda_pbm_clamed Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atendimento marcado como PBM Clamed, negocia$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida!", Exclamation! )
	Return
End If

If not gf_cpf_colaborador(ivo_Cliente.nr_cpf_cgc) Then
	wf_Cobre_Preco()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido colaborador Clamed utilizar o cobre pre$$HEX1$$e700$$ENDHEX$$o em benef$$HEX1$$ed00$$ENDHEX$$cio pr$$HEX1$$f300$$ENDHEX$$prio.",Exclamation!)
End If
	
	
SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
end event

event ue_cartao_desconto();//Captura cart$$HEX1$$e300$$ENDHEX$$o desconto plano de saude
Boolean lb_Retorno, lb_contratos
Boolean lb_Cartao_Valido

String ls_cartao,  ls_resposta, ls_erro, ls_Rede, ls_nome, ls_tipo_cartao, ls_convenios, ls_cliente

Long ll_convenio, ll_row, ll_erro
Long ll_Convenio_Contrato

If Not gf_rede_filial(Ref ls_Rede) Then
	Return
ElseIf (ls_Rede <> "DC" And ls_Rede <> "PP") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto Plano de Sa$$HEX1$$fa00$$ENDHEX$$de n$$HEX1$$e300$$ENDHEX$$o liberado para filiais dessa rede.",Exclamation!)
	Return
End If

If Not IsNull(This.is_cartao_desconto) And Trim(This.is_cartao_desconto) <> '' Then
	MessageBox("Informa$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o Desconto j$$HEX1$$e100$$ENDHEX$$ informado.",Information!)
	Return
Else
	If dw_2.RowCount() > 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o Desconto deve ser informado antes de qualquer produto!",Exclamation!)
		Return
	End If
	If dw_2.RowCount() = 1 And Not IsNull(dw_2.Object.cd_produto [1])  Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o Desconto deve ser informado antes de qualquer produto!",Exclamation!)
		Return
	End If	
	
	ls_cliente = ivo_cliente.cd_cliente
End If	

If Not IsValid(SITEF) Then
	SITEF = Create uo_sitef // GE084	
	If Not SITEF.of_configura() Then Return
	If Not SITEF.of_Inicia_Comunicacao() Then Return
End If

uo_pinpad lvo_pinpad
lvo_pinpad = Create uo_pinpad //GE074
lvo_pinpad.cd_cliente = ls_cliente //Passa o Cliente para o Objeto

lb_Retorno = lvo_pinpad.of_captura_cartao('CONTRATO')

If Not lb_Retorno Then 
	Destroy(lvo_pinpad)
	Destroy(Sitef)
	Return
End If
ls_cartao	= lvo_pinpad.Cartao
ls_Nome 	= lvo_pinpad.Nome
ls_tipo_cartao = lvo_pinpad.tipo_cartao_saude

Destroy(lvo_pinpad)
Destroy(Sitef)


uo_convenio lvo_convenio
lvo_convenio = Create uo_convenio

SetNull(ll_Convenio)

//Passa pela validacao do webservice
lb_Cartao_Valido = False
If Not lvo_Convenio.of_valida_cartao_desconto_saude( ll_convenio,  ls_tipo_cartao, ls_cartao, ls_nome, lb_Cartao_Valido, Ref ll_Convenio_Contrato ) Then
	SetNull(ls_cartao)
End If
//Atribui na venda os contratos ativbs antes do destroy do objeto uo_convenio
This.ids_contratos_bin = lvo_convenio.ids_contratos_bin

If IsValid(lvo_convenio) Then Destroy lvo_convenio
 
//Atribui a var local
This.is_cartao_desconto = ls_cartao

Return


/*
uo_Transacao_Remota lvo_Conexao

If ls_tipo_cartao = '1' Then
	//Cart$$HEX1$$e300$$ENDHEX$$o UNIMED
	If LenA(Trim(ls_cartao)) <> 17  Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cart$$HEX1$$e300$$ENDHEX$$o '" + ls_cartao + "' inv$$HEX1$$e100$$ENDHEX$$lido para desconto.", Exclamation!)				
		Return
	End If
	If LeftA(ls_cartao,4) = '0027' Then //Verifica se Cart$$HEX1$$e300$$ENDHEX$$o Unimed Joinville $$HEX1$$e900$$ENDHEX$$ de contratos da Clamed.
		lvo_Conexao = Create uo_Transacao_Remota	
	
		SetPointer(HourGlass!)		
		If Not lvo_Conexao.of_verifica_unimed_clamed(ls_Cartao) Then
			Destroy(lvo_Conexao)
			Return
		End if		
		Destroy(lvo_Conexao)
	End If

	lvo_convenio = Create uo_convenio
	
	If Not This.ids_contratos_bin.of_ChangeDataObject('ds_ge004_contratos_ativos') Then Return
	
	If lvo_convenio.of_verifica_contrato(ls_cartao, ref ll_convenio, ref This.ids_contratos_bin) Then		
		If This.ids_contratos_bin.rowcount( )  > 0 Then
			lb_contratos = True
			This.is_cartao_desconto = ls_cartao
		Else
			lb_contratos = False
		End If		
	End If
	
	Destroy(lvo_convenio)
Else
	//CLINIPAM
	If LenA(Trim(ls_cartao)) > 0 Then
		uo_Parametro_Filial lvo_Parametro
		lvo_Parametro = Create uo_Parametro_Filial

		lvo_Parametro.of_Localiza_Parametro('CD_CONVENIO_DESCONTO', ref ls_convenios, False)

		Destroy(lvo_Parametro)
		
		lvo_Conexao = Create uo_Transacao_Remota
		lvo_Conexao.of_BancoProducao()
		
		If lvo_Conexao.of_verifica_cartao_saude(ls_convenios,ls_Cartao, Ref ll_convenio) Then			
			lvo_convenio = Create uo_convenio
			
			If Not This.ids_contratos_bin.of_ChangeDataObject('ds_ge004_contratos_ativos_sem_cartao') Then Return
			
			If lvo_convenio.of_verifica_contrato_sem_cartao(ll_convenio, ref This.ids_contratos_bin) Then		
				If This.ids_contratos_bin.rowcount( )  > 0 Then
					lb_contratos = True					
					This.is_cartao_desconto = ls_cartao
				Else
					lb_contratos = False
				End If		
			End If
			
			Destroy(lvo_convenio)							
		Else
			Setnull(This.is_cartao_desconto)
			Destroy(lvo_conexao)
			Return
		End If	

		If IsValid(lvo_conexao) Then Destroy(lvo_conexao)		
	End If	
End If

If lb_contratos = True Then
	//Aqui consulta WEB service para ver se o cart$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativo.	
	If ls_tipo_cartao = '1' Then
		Try
			uo_ge493_wsunimed    lo_ws
			lo_ws = Create uo_ge493_wsunimed
			
			If lo_ws.of_envia_ws( ls_cartao, ls_nome, Ref ls_resposta, Ref ls_erro, Ref ll_Erro ) Then
				If ls_resposta = 'N' Then
					 Setnull(This.is_cartao_desconto)               
					 MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cart$$HEX1$$e300$$ENDHEX$$o '" + ls_cartao + "' n$$HEX1$$e300$$ENDHEX$$o existe ou n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativo na operadora.", Exclamation!)
					 Return
				End If
			Else
				If ll_erro = 404 Or ll_erro = 500 Then //erro de conex$$HEX1$$e300$$ENDHEX$$o ou erro interno do WebService   
					 MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na Consulta com a operadora. ~n" + &
																"Ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a confirma$$HEX2$$e700e300$$ENDHEX$$o de documentos com o cliente." , Information!)       
				Else
					 Setnull(This.is_cartao_desconto)               
					 MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro consulta: " + ls_resposta +' '+ ls_erro , Exclamation!)                       
					 Return
				End If               
			End If
		Finally
			If IsValid(lo_ws) Then Destroy(lo_ws)       
		End Try
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cart$$HEX1$$e300$$ENDHEX$$o '" + ls_cartao + "' sem contrato de desconto ativo.", Exclamation!)		
End If

Return
*/
end event

event ue_produto_favorito();Long ll_Linha, &
     ll_Produto

String ls_Retorno
String ls_Cliente

Boolean lb_Produto_Ja_Reservado

dw_1.AcceptText()
dw_2.AcceptText()

Try
	If IsNull( ivo_cliente.cd_Cliente ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um cliente.")
		dw_1.Event ue_Pos( 1, "localizacao" )
		Return
	End If
	
	ll_Linha = dw_2.GetRow()
	
	If ll_Linha > 0 Then
		If dw_2.Find( "not isNull(cd_produto)", 1, dw_2.RowCount() ) <= 0  Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para favoritar.", exclamation!)
			Return
		End If		
	
		ll_Produto  = dw_2.Object.Cd_Produto [ ll_Linha ]
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja favoritar o produto selecionado ?", Question!, YesNo!, 1 ) = 2 Then
			Return
		End If
				
		OpenWithParm( w_ge108_produto_favorito,  ivo_cliente.cd_Cliente + '|' + This.is_Matricula_Vendedor + '|' + String(ll_Produto) )
				
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para favoritar.", Information!)
	End If
	
Finally
	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
End Try
end event

event type boolean ue_incluir_pedido_disque_entrega();Long ll_Nr_Roteiro, ll_Linhas

String ls_Retorno

//Var temporaria
Boolean lb_Disque_3 = false

Try
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	If Not ib_Loja_Disque_Entrega Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A funcionalidade Disque Entrega n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel nesta filial.", Exclamation! )
		Return False		
	End If
		
	If IsNull( ivo_cliente.cd_Cliente ) Then
		MessageBox( "Pedido DISQUE ENTREGA", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio ter um cliente identificado.", Exclamation! )
		dw_1.Event ue_Pos( 1, 'localizacao' )
		Return False
	End If
	
	ll_Linhas = dw_2.RowCount()
	
	If ll_Linhas > 0 Then
//		If Not lb_Disque_3 Then
//			If ib_Reserva_Produto OR ( ivi_Qtde_Itens_Reservados > 0 ) Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedidos DISQUE ENTREGA n$$HEX1$$e300$$ENDHEX$$o podem ser refer$$HEX1$$ea00$$ENDHEX$$nciados com Reserva de Produto.", Exclamation!)
//				Return False	
//			End If
//		End If
		
		If dw_2.Find( "not isNull(cd_produto)", 1, ll_Linhas ) <= 0  Then
			MessageBox("Pedido DISQUE ENTREGA", "Selecione pelo menos um produto.", Exclamation!)
			Return False
		End If		
		
		If Not lb_Disque_3 Then
			If dw_2.Find( "id_cobre_preco='S'", 1, ll_Linhas ) > 0  Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido produtos negociados via Cobre Pre$$HEX1$$e700$$ENDHEX$$o nos Pedidos do Disque Entrega.", Exclamation!)
				Return False
			End If	
		End If
		
		If Messagebox("Pedido DISQUE ENTREGA", "Deseja incluir um pedido para o cliente selecionado com o(s) produto(s) da lista?", Question!, YesNo!, 1) = 2 Then
			Return False
		End If
		
		If lb_Disque_3 Then
			//Verifica Cobre Pre$$HEX1$$e700$$ENDHEX$$o e Reserva
			If dw_2.Find( "id_cobre_preco='S'" , 1, dw_2.RowCount() ) > 0 Then
				If wf_Grava_Cobre_Preco() Then
					If wf_atualiza_cobre_preco() Then
						//Verificar finaliza$$HEX2$$e700e300$$ENDHEX$$o de reserva
		//				If dw_2.Find( "id_reservado='S'" , 1, dw_2.RowCount() ) > 0 Then
		//					Event ue_finalizar_reserva()	
		//				End If
					End If
				End If
			End If
		End If
		
		ib_Pedido_Disque_Entrega = True
		
		If lb_Disque_3 Then
			If wf_Novo_Disque() Then
				This.ib_Conclusao_Atendimento_Pendente = False
				Close(This)
			End If
		Else
			
			If dw_2.Find( "id_reservado='S'" , 1, dw_2.RowCount() ) > 0 Then
				Event ue_finalizar_reserva(True)	
				ib_Reserva_Produto = True
			End If		
			
			wf_Conclui_Venda(  )
		End If
		
	End If
Finally
	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
End Try
end event

event ue_reimprimir_cupom_pre();Boolean lb_Cupom_Impresso

Try
	ib_AGUARDAR_ATIVO = True
	dw_1.AcceptText()
	
	If IsNull( ivo_Cliente.Cd_Cliente ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um cliente.")
		dw_1.Event ue_Pos( 1, "localizacao" )
		Return
	End If
	
	If gf_ge039_cupom_pre_venda( ivo_Cliente.Cd_Cliente, is_Matricula_Vendedor, Ref lb_Cupom_Impresso) Then
		If Not lb_Cupom_Impresso Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum cupom pr$$HEX1$$e900$$ENDHEX$$-venda dispon$$HEX1$$ed00$$ENDHEX$$vel para este cliente.")
		End If
	End If
	
Finally
	ib_AGUARDAR_ATIVO = False
End Try
end event

event ue_dermaclub();If Not ib_Dermaclub_ativo Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A funcionalidade Dermaclub n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel nesta filial.", Exclamation! )
	Return
End If
	
If IsNull( ivo_cliente.cd_Cliente ) Then
	MessageBox( "DERMACLUB", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio ter um cliente identificado.", Exclamation! )
	dw_1.Event ue_Pos( 1, 'localizacao' )
	Return
End If

If ib_Venda_Dermaclub Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atendimento j$$HEX1$$e100$$ENDHEX$$ marcado como Dermaclub.", Information! )
	Return
End If

If MessageBox("DERMACLUB",	"Informar no atendimento que o cliente possui cadastro Dermaclub?", Question!, YesNo! ) = 1 Then
	ib_Venda_Dermaclub = True
End If			

Return
end event

public subroutine wf_localiza_vendedor ();String lvs_Vendedor

dw_1.AcceptText()

lvs_Vendedor = dw_1.GetText()

ivo_Vendedor.of_localiza_vendedor(lvs_Vendedor)

If ivo_Vendedor.Localizado Then
	
	dw_1.Object.nm_vendedor				[1] = ivo_Vendedor.nm_usuario
	dw_1.Object.nr_matricula_vendedor	[1] = ivo_Vendedor.nr_matricula_vendedor
	
End If
end subroutine

public function long wf_saldo_produto (long pl_produto);Long lvl_Saldo
Long ll_Saldo_Pendente

Select qt_saldo_final Into :lvl_Saldo
from vw_saldo_atual_produto
where cd_produto = :pl_produto;

Choose Case SqlCa.SqlCode
	Case 0
		// Somente transferencias entre filiais tem o saldo j$$HEX1$$e100$$ENDHEX$$ somado
		SELECT COALESCE( SUM( qt_saldo ), 0 )
		INTO :ll_Saldo_Pendente
		FROM vw_saldo_produto_pendente
		WHERE cd_produto = :pl_Produto
		AND ( tipo_movimento = 'TRANSF. FILIAL' OR
				tipo_movimento = 'RESERVA CLIENTE' OR 
				tipo_movimento = 'RESERVA VEND. MACHINE' OR
				tipo_movimento = 'PEDIDO ECOMMERCE')
		USING SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError( "wf_saldo_produto( long )" )
		Else
			lvl_Saldo = ( lvl_Saldo - ll_Saldo_Pendente )
		End If
		
		Return lvl_Saldo

	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo do produto " + String(pl_Produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado.", Information!)
		Return 0
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do produto " + String(pl_Produto) + "." + SqlCa.SqlErrText, Information!)		
		Return 0		
End Choose
end function

public function string wf_verifica_local_estocagem (long pl_produto);String lvs_Local

Select local_estocagem.de_local_estocagem
Into :lvs_Local
From produto_loja,
     local_estocagem
where produto_loja.cd_local_estocagem = local_estocagem.cd_local_estocagem
  and produto_loja.cd_produto         = :pl_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto")		
	Case 100
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela de produto da loja.")
End Choose

Return lvs_Local
end function

public function string wf_verifica_situacao (long pl_produto);String lvs_Situacao

Select id_situacao
Into :lvs_Situacao
From produto_loja
where cd_produto = :pl_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto")	
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela de produto da loja.")
End Choose

Return lvs_Situacao
end function

public function boolean wf_comissao_extra (ref integer ai_contador, long al_linha);Boolean lvb_Sucesso = True

Integer lvi_Contador

Long lvl_Produto

String lvs_Indicador_Comissao
		
SetPointer(HourGlass!)

lvl_Produto = ivo_Produto.cd_produto

Select count(*) 
Into :lvi_Contador
From tipo_comissao_produto
Where cd_produto       =:lvl_Produto
and cd_tipo_comissao <> 3
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da comiss$$HEX1$$e300$$ENDHEX$$o extra do produto '" + String(lvl_Produto) + "'.")
	lvb_Sucesso = False
Else
	If lvi_Contador > 0 Then
		lvs_Indicador_Comissao = "*"
	Else
		lvs_Indicador_Comissao = ""
	End If
	
	dw_2.Object.id_comissionado[al_Linha] = lvs_Indicador_Comissao
End If
	
SetPointer(Arrow!)

Return lvb_Sucesso
end function

public subroutine wf_inclui_produto ();Long lvl_Linha

dw_2.SetFocus()

If Not IsNull(dw_2.Object.cd_produto[dw_2.RowCount()]) Then
	lvl_Linha = dw_2.Event ue_AddRow()
Else
	lvl_Linha = dw_2.RowCount()
End If

If lvl_Linha > 0 Then
	dw_2.SetRow(lvl_Linha)
	
	wf_Localiza_Produto(String(ivl_produto_busca_facil))
	SetNull(ivl_produto_busca_facil)
End If
end subroutine

public subroutine wf_muda_figura ();String lvs_Rede

If Not ivo_Parametro.of_Localiza_Parametro("ID_REDE_FILIAL", Ref lvs_Rede) Then Return

dw_5.Object.logo_dc.Visible     = 0
dw_5.Object.logo_alomed.Visible = 0
dw_5.Object.logo_pp.Visible 	= 0

Choose Case lvs_Rede
	Case 'AL' ; dw_5.Object.logo_alomed.Visible = 1
	Case 'DC' ; dw_5.Object.logo_dc.Visible     = 1
	Case 'PP' ; dw_5.Object.logo_pp.Visible 	= 1
	Case 'DP' ; dw_5.Object.logo_pp.Visible 	= 1
End Choose 



end subroutine

public subroutine wf_verifica_vidalink (long pl_produto, long pl_linha);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo do programa farm$$HEX1$$e100$$ENDHEX$$cia popular em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

String ls_Parametro

If ivo_Produto.Id_Farmacia_Popular = 'S' Then
	
	dw_2.Object.Id_Vidalink[pl_Linha] = 'S'
	
End If
end subroutine

public function decimal wf_promocao_sos_farm_popular ();Decimal lvdc_Desconto,&
		lvdc_Nulo

Long lvl_Promocao_SOS

String lvs_Parametro

SetNull(lvdc_Nulo)

lvdc_Desconto = lvdc_Nulo

Select vl_parametro
Into :lvs_Parametro
From parametro_loja
Where cd_parametro = 'CD_PROMOCAO_SOS_FARMACIA_POPULAR'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
				
		If IsNumber(lvs_Parametro) Then
			
			lvl_Promocao_SOS = Long(lvs_Parametro)
			
			Select pc_desconto
			Into :lvdc_Desconto
			From promocao_sos_produto
			Where cd_promocao_sos	= :lvl_Promocao_SOS
			  and cd_produto		= :ivo_Produto.cd_produto
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					If IsNull(lvdc_Desconto) or lvdc_Desconto <= 0 Then
						lvdc_Desconto = 0.00
					End If					
				Case 100
					lvdc_Desconto = 0.00
				Case -1
					SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do desconto da promo$$HEX2$$e700e300$$ENDHEX$$o sos '" + String(lvl_Promocao_SOS) + "'")
			End Choose
			
		End If
		
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e300$$ENDHEX$$metro loja 'CD_PROMOCAO_SOS_FARMACIA_POPULAR'")
End Choose

Return lvdc_Desconto
end function

public subroutine wf_verifica_pbm (long pl_produto, long pl_linha);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo de PBM em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

Long lvl_Count

//Select Count(pp.cd_pbm)
//  Into :lvl_Count
//  From pbm p, pbm_produto pp
// Where pp.cd_produto = :pl_produto
//   and pp.cd_pbm		= p.cd_pbm
//   and coalesce (p.id_tipo, '') <> 'D' 	
// Using SqlCa;
 
select sum(qtde) 
 Into :lvl_Count
	from(
	SELECT Count(pro.cd_pbm) as qtde
	FROM		pbm AS pbm
		INNER JOIN pbm_produto AS pro
			ON pro.cd_pbm = pbm.cd_pbm
		LEFT OUTER JOIN parametro_loja p
			ON cd_parametro = 'ID_INTEGRA_PORTAL_DROGARIA'
	WHERE	pro.cd_produto = :pl_produto
	and pbm.cd_convenio = 52568
	and (Case when p.vl_parametro = 'N' Then pbm.cd_pbm <> 175 Else pbm.cd_pbm = 175 end)
	
	Union all
	
	SELECT	Count(pro.cd_pbm) as qtde
	FROM		pbm AS pbm
		INNER JOIN pbm_produto AS pro
			ON pro.cd_pbm = pbm.cd_pbm
	WHERE	pro.cd_produto = :pl_produto
	and (pbm.cd_convenio is null Or pbm.cd_convenio <> '52568')
	and coalesce (pbm.id_tipo, '') <> 'D' 
) as x
Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs do produto '" + String(pl_Produto) + "'.")
	Return
End If

If lvl_Count > 0 Then
	dw_2.Object.Id_PBM[pl_Linha] = 'S'
End If

//Verifica se tem dermaclub
If ib_Dermaclub_ativo Then
	Select Count(pp.cd_pbm)
	  Into :lvl_Count
	  From pbm p, pbm_produto pp
	 Where pp.cd_produto = :pl_produto
		and pp.cd_pbm		= p.cd_pbm
		and p.id_tipo = 'D'
	 Using SqlCa;
	 
	 If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs Dermaclub do produto '" + String(pl_Produto) + "'.")
		Return
	End If
	
	If lvl_Count > 0 Then
		dw_2.Object.Id_dermaclub[pl_Linha] = 'S'
	End If
End if

end subroutine

public subroutine wf_localiza_cliente ();Boolean lb_Ultimo_Cliente = False

wf_localiza_Cliente( lb_Ultimo_Cliente )
end subroutine

public subroutine wf_conclui_venda ();String ls_Tipo_Pagamento_Reserva

SetNull(ls_Tipo_Pagamento_Reserva)

wf_conclui_venda( ls_Tipo_Pagamento_Reserva )
end subroutine

public subroutine wf_cadastra_cliente ();dw_1.AcceptText()

gvs_Cliente_Cadastro = dw_1.Object.Localizacao[1]

ivm_Menu.mf_Abre_Janela("w_rl001_cadastro_cliente_pf", True)


end subroutine

public subroutine wf_inicia_atendimento ();Integer li_Resposta_Acessar_Como

String ls_Descricao_Procedimento
String ls_Mensagem_Liberacao

ib_Venda_pbm_clamed 		= False
ib_item_pbm_excluido 		= False
ib_Pedido_Disque_Entrega 	= False
ib_Venda_Dermaclub	 		= False


SetNull(is_Situacao_Reserva_Disque_Entrega)
SetNull(idt_Nascimento)
SetNull(is_Cartao_Industria_PBM)

//Reset dw e objetos
wf_Inicializa_Objetos()

dw_1.SetTabOrder( "localizacao", 20 )
dw_1.Modify("localizacao.background.color='16777215'")
dw_1.Modify("nr_cpf.background.color='16777215'")
dw_1.Modify("nm_dependente.background.color='16777215'")

wf_alerta_reserva_pendente()
wf_Bloqueia_Campos_Convenio( )

dw_1.Event ue_Pos( 1, 'localizacao' )

//If gvo_Aplicacao.ivo_Seguranca.of_Get_Persiste_Usuario( ) And ( Not This.ib_OBRIGA_INFORMAR_USUARIO_ATEND_GE108 ) Then // Se estiver marcada a op$$HEX2$$e700e300$$ENDHEX$$o "Manter usu$$HEX1$$e100$$ENDHEX$$rio conectado", confirma se $$HEX1$$e900$$ENDHEX$$ o usu$$HEX1$$e100$$ENDHEX$$rio conectado
//
//	ls_Descricao_Procedimento	= gvo_Aplicacao.ivo_Seguranca.of_Get_Descricao_Procedimento()
//	ls_Mensagem_Liberacao		= ls_Descricao_Procedimento + "~r~r Acessar como " + Upper( gvo_Aplicacao.ivo_Seguranca.nm_Usuario ) + " ?"
//	
//	li_Resposta_Acessar_Como = MessageBox( "LIBERA$$HEX2$$c700c300$$ENDHEX$$O DE PROCEDIMENTO", ls_Mensagem_Liberacao, Question!, YesNoCancel!, 1 )
//Else // Caso contr$$HEX1$$e100$$ENDHEX$$rio, solicita matr$$HEX1$$ed00$$ENDHEX$$cula de quem vai realizar o atendimento
//	li_Resposta_Acessar_Como = 2
//End If
//
//Choose Case li_Resposta_Acessar_Como
//	Case 1
//		This.is_Matricula_Vendedor = gvo_Aplicacao.ivo_Seguranca.of_get_Nr_Matricula_Persiste( )
//		
//	Case 2
//		OpenWithParm( dc_w_identificacao_usuario, "W_GE108_INICIA_ATENDIMENTO_CLIENTE" )
//		
//		This.is_Matricula_Vendedor = Message.StringParm
//
//		If This.is_Matricula_Vendedor = 'CANCEL' Then
//			Close( This )
//			Return
//		End If
//		
//	Case 3
//		Close( This )
//		Return
//		
//End Choose

Select nr_cpf
   Into :is_cpf_vendedor
 From usuario				  u
Where u.nr_matricula = :This.is_Matricula_Vendedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		Close( This )		
		Return
		
	Case 100
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Matr$$HEX1$$ed00$$ENDHEX$$cula n$$HEX1$$e300$$ENDHEX$$o localizada no cadastro de usu$$HEX1$$e100$$ENDHEX$$rios desta filial.", StopSign! )
		Close( This )
		Return
End Choose

//Novo sequencial da cliente caixa
//Atribui este seq na variavel il_Sequencial_Cliente_Caixa
//Atribui o nome do vendedor na variavel is_Nm_Vendedor
If wf_New_Seq_Cliente_Caixa ( ) Then
	This.Title = "GE108 - Atendimento ao Cliente ( Atendente: " + is_Nm_Vendedor + " ) Abertura: " + String( now( ), "HH:MM:SS" )
	This.ib_Conclusao_Atendimento_Pendente = True
Else
	Close( This )
	Return
End If




end subroutine

public subroutine wf_atualiza_cliente (string ps_fase);String ls_Cpf

OpenWithParm(w_rl001_cadastro_cliente_pf_response, ivo_Cliente.Cd_Cliente + ps_Fase)

ls_Cpf = Message.StringParm

If Not IsNull(ls_Cpf) Or Trim(ls_Cpf) <> "" Then
	dw_1.Object.Localizacao[1] = ls_Cpf
	wf_Localiza_Cliente()
End If
end subroutine

public subroutine wf_atualiza_cliente ();String lvs_Fase_Atualizacao,&
		lvs_Mensagem

If IsNull( ivo_Cliente.Cd_Cliente ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio localizar um cliente para poder atualizar.", Information! )	
	Return
End If

If is_forma_atendimento = Nome Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Atualiza$$HEX2$$e700e300$$ENDHEX$$o de cadastro apenas quando cliente for identificado pelo CPF ou CNPJ.~r" +&
						"~rDeseja visualizar o contato do cliente?",Question!,YesNo!) = 1 Then
						
		lvs_Mensagem =  "Nome: " + ivo_Cliente.nm_cliente
						
		If  (not isNull(ivo_cliente.nr_ddd_fone) And  ivo_cliente.nr_ddd_fone <> '') And (not isNull(ivo_cliente.nr_fone) And  ivo_cliente.nr_fone <> '') Then
			lvs_Mensagem += "~rTelefone: (" + ivo_cliente.nr_ddd_fone + ") "		+ ivo_cliente.nr_fone
		End If
		
		If  (not isNull(ivo_cliente.nr_ddd_celular) And  ivo_cliente.nr_ddd_celular <> '') And (not isNull(ivo_cliente.nr_fone_celular) And  ivo_cliente.nr_fone_celular <> '') Then
			lvs_Mensagem += "~rCelular: (" + ivo_cliente.nr_ddd_celular + ") "		+ ivo_cliente.nr_fone_celular
		End If
						
		MessageBox("Dados do Cliente", lvs_Mensagem,Information!)
		
	End If
	Return
End If

If ivo_Cliente.Id_Fisica_Juridica <> 'F' Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A op$$HEX2$$e700e300$$ENDHEX$$o de atualiza$$HEX2$$e700e300$$ENDHEX$$o pelo atalho s$$HEX1$$f300$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel para clientes Pessoa F$$HEX1$$ed00$$ENDHEX$$sica.", Information! )	
	Return
End If

If ivo_Cliente.Id_Tipo_Cliente = 'CC' Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A op$$HEX2$$e700e300$$ENDHEX$$o de atualiza$$HEX2$$e700e300$$ENDHEX$$o pelo atalho n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel para clientes Prazo.", Information! )	
	Return
End If

If This.wf_Verifica_Fase_Atualizacao( ref lvs_Fase_Atualizacao ) Then
	If lvs_Fase_Atualizacao = 'N' Then lvs_Fase_Atualizacao = '1'
	wf_Atualiza_Cliente( lvs_Fase_Atualizacao )
End If
end subroutine

public subroutine wf_localiza_dependente ();String lvs_Localizacao

dw_1.AcceptText()

lvs_Localizacao = dw_1.Object.Nm_Dependente[1]

ivo_Cliente.of_Localiza_Cliente( lvs_Localizacao )

If Not IsNull( ivo_Cliente.Cd_Dependente ) Then
	dw_1.Object.Nm_Dependente	[1] = ivo_Cliente.Nm_Dependente
	dw_1.Object.Cd_Dependente	[1] = ivo_Cliente.Cd_Dependente
End If
end subroutine

public function boolean wf_verifica_fase_atualizacao (ref string ps_fase);If ivo_Cliente.Id_Tipo_Cliente = 'CC' Then Return False

If IsNull( ivo_Cliente.Cd_Cliente ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio localizar um cliente para poder verificar as atualiza$$HEX2$$e700f500$$ENDHEX$$es.", StopSign! )
	dw_1.Event ue_Pos( 1, 'localizacao' )
	Return False
End If

uo_Cliente_Central lvo_Cliente_Central // GE077
lvo_Cliente_Central = Create uo_Cliente_Central
lvo_Cliente_Central.of_Verifica_Fase_Atualizacao( ivo_Cliente.Cd_Cliente, ref ps_Fase )
Destroy lvo_Cliente_Central

If ps_Fase <> 'N' And ps_Fase <> '1' And ps_Fase <> '2' Then
	ps_Fase = '1'
End If

Return True
end function

public function boolean wf_registra_produto_sem_saldo (integer pl_linha);// N$$HEX1$$c300$$ENDHEX$$O PODE RETORNAR MENSAGEM PARA O USU$$HEX1$$c100$$ENDHEX$$RIO //

Long lvl_Consulta
Long lvl_Tipo
Long ll_Cd_Produto
Long ll_Saldo
Long ll_Saldo_Pendente

Decimal ldc_Preco_Unitario

DateTime lvdh_Movimento

String ls_Cliente

dw_2.AcceptText()

lvdh_Movimento 	= gvo_parametro.of_dh_movimentacao()
ll_Cd_Produto 	 	= dw_2.Object.Cd_Produto		[pl_linha]
ll_Saldo			 	= dw_2.Object.Qt_Estoque		[pl_linha]
ldc_Preco_Unitario	= dw_2.Object.vl_preco_final	[pl_linha]
ls_Cliente			= dw_1.Object.Cd_Cliente		[ 1 ]

If Not IsNull( ls_Cliente ) Then // Desconsidera saldo pendente reservado para o cliente identificado
	SELECT SUM( qt_saldo )
	INTO :ll_Saldo_Pendente
	FROM vw_saldo_produto_pendente
	WHERE cd_produto = :ll_Cd_Produto
	AND cd_fornecedor = :ls_Cliente
	USING SQLCA;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo pendente" )
		Return False
	End If
	
	If ll_Saldo_Pendente > 0 Then
		Return True
	End If
End If //

If ll_Saldo > 0 Or ivo_Produto.Id_Situacao <> 'A' Then
	Return True
End If

Select qt_consulta Into :lvl_Consulta
From produto_procurado_zerado
Where cd_filial							= :gvo_parametro.cd_filial
    and cd_produto						= :ll_Cd_Produto
    and dh_movimentacao			= :lvdh_Movimento
    and id_tipo							= 'F'
  Using Sqlca;
  
Choose Case SqlCa.SqlCode
	Case 0
		Update produto_procurado_zerado
		Set qt_consulta 		= qt_consulta + 1,
			id_exportado 		= 'S',
			vl_preco_unitario 	= :ldc_Preco_Unitario
		Where cd_filial					= :gvo_parametro.cd_filial
		    and cd_produto				= :ll_Cd_Produto
		    and dh_movimentacao	= :lvdh_Movimento
		    and id_tipo					= 'F'
			 Using Sqlca;
			 
		Case 100
			Insert 
			  Into produto_procurado_zerado (cd_filial,
														cd_produto,
														dh_movimentacao,
														id_tipo,
														qt_consulta,
														qt_recebida_outra_filial,
														qt_substituido_generico,
														id_exportado,
														vl_preco_unitario)
											
												Values (:gvo_parametro.cd_filial,
														  :ll_Cd_Produto,
														  :lvdh_Movimento,
														  'F',
														  1,
														  0,
														  0,
														  'S',
														  :ldc_Preco_Unitario)
		 Using Sqlca;
		 
	Case -1
		SqlCa.of_RollBack()
		Return False
End Choose

SqlCa.of_Commit()
Return True
end function

public function boolean wf_verifica_se_possui_cartao (string ps_cliente);Long ll_Cartao_Clube

String ls_Rede_Filial

Choose Case gvo_Parametro.id_rede_filial
	Case 'MP', 'DC', 'CP'
		ls_Rede_Filial = 'DC'
	Case Else
		ls_Rede_Filial = gvo_Parametro.id_rede_filial
End Choose

Select Count(*)
Into	:ll_Cartao_Clube
From cartao_clube ca
Where ca.cd_cliente = :ps_cliente
And	ca.dh_bloqueio Is Null
And	Coalesce(id_rede_cartao, 'DC') = :ls_Rede_Filial
Using SqlCa;

If (ls_Rede_Filial <> 'DC') And (ls_Rede_Filial <> 'PP') Then
	dw_1.Object.Cartao_Clube_t.Visible = False
	Return False
End If


//**********************
//Chamado: 280708
//Comentado por Wagner
//07/08/2017
//**********************
//If ll_Cartao_Clube = 0 Then
//	dw_1.Object.Cartao_Clube_t.Text = "[F11] Entregar cart$$HEX1$$e300$$ENDHEX$$o"
//	dw_1.Object.Cartao_Clube_t.Visible = True	
//Else
//	dw_1.Object.Cartao_Clube_t.Text = "          Possui cart$$HEX1$$e300$$ENDHEX$$o " + ls_Rede_Filial
//	dw_1.Object.Cartao_Clube_t.Visible = True
//End If

Return True
end function

public function boolean wf_localiza_dados_distribuido ();Boolean lb_Sucesso = False

uo_Transacao_Remota lo_Conexao
lo_Conexao = Create uo_Transacao_Remota

lo_Conexao.of_BancoProducao()

lo_Conexao.of_Define_Variaveis(True)
lo_Conexao.of_ConverteVirgula(True)

dw_1.Object.Qt_Pontos[ 1 ] = 0.00

lo_Conexao.of_Executa_Rotina("0051", {String( gvo_Parametro.Cd_Filial ), "'" + ivo_Cliente.Cd_Cliente + "'"})

If lo_Conexao.of_Erro_Execucao() Or lo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta dos dados do cliente na MATRIZ.")	
Else
	If lo_Conexao.of_Linhas() > 0 Then
		If lo_Conexao.of_Retorno( "qt_pontos",						Ref idc_Pontos_Cliente )						And &
			lo_Conexao.of_Retorno( "nr_fase_atualizacao",		Ref is_Fase_Atualizacao_Cliente )			And &
			lo_Conexao.of_Retorno( "dh_atualizacao_fase",		Ref idh_Atualizacao_Fase_Cliente )		And &		  	
			lo_Conexao.of_Retorno( "dh_solicitou_atualizacao",	Ref idh_Solicitou_Atualizacao_Cliente )	And &		  	
			lo_Conexao.of_Retorno( "existe_campanha",			Ref is_Cliente_Possui_Campanha ) Then
			
			If IsNull( idc_Pontos_Cliente ) Then idc_Pontos_Cliente = 0.00
			
			dw_1.Object.Qt_Pontos[ 1 ] = idc_Pontos_Cliente
			
			lb_Sucesso = True
		
		End If
	Else
		IF TRIM(is_Fase_Atualizacao_Cliente) = "" Or IsNull(is_Fase_Atualizacao_Cliente) Then is_Fase_Atualizacao_Cliente = 'N'
		lb_Sucesso = True
	End If
End If

Destroy lo_Conexao

Return lb_Sucesso
end function

public function boolean wf_imprime_orcamento_judicial (boolean pb_imeditato);Long lvl_ind
Long i
Long ll_Produto

Date dh_Movimento

Integer li_Dia
Integer li_Mes
Integer li_Ano
String	ls_Cliente
String ls_CPF
String ls_Subcategoria

li_Dia 		= Day(Date(gvo_Parametro.dh_movimentacao)) 
li_Mes	= Month(Date(gvo_Parametro.dh_movimentacao)) 
li_Ano		= Year(Date(gvo_Parametro.dh_movimentacao)) 

dw_1.AcceptText( )
dw_5.Reset()
dw_2.AcceptText()

If dw_2.RowCount() = 0 Then
	Return False
End If
// Se a $$HEX1$$fa00$$ENDHEX$$ltima linha for nula, exclui.
If IsNull(dw_2.Object.cd_produto [dw_2.RowCount()]) Then
	If dw_2.RowCount() = 1 Then
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
		Return False
	End If
	dw_2.DeleteRow(dw_2.RowCount())
End If

If dw_2.RowCount() = 0 Then
	Return False
End If

Choose Case gvo_Parametro.id_rede_filial
	Case 'DC'
		dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel_novo.png"
	Case 'PP'
		dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\logo_pp_rel.png"
	Case 'FA'
		dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\logo_fa_rel.png"
	Case 'PF'
		dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\logo_proformula_rel.png"
	Case 'MP'
		dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\logo_manipulacao_rel.png"
	Case 'CP'		
		dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\Logo_dc_plus_rel.png"		
End Choose

ls_Cliente 	= ivo_Cliente.nm_cliente
ls_CPF		= ivo_Cliente.nr_cpf_cgc

If LenA( ls_CPF ) = 14 Then //Pessoa Jurica
	ls_CPF		= 'CNPJ: ' + String(  ls_CPF   , "@@.@@@.@@@/@@@@-@@" )
Else
	ls_CPF		= 'CPF: ' + String(  ls_CPF   , "@@@.@@@.@@@-@@" )
End If

If io_Convenio.Localizado Then
	dw_5.Object.t_convenio_condicao.Text	= "Conv$$HEX1$$ea00$$ENDHEX$$nio: " + io_Convenio.nm_razao_social + " (" + String( io_Convenio.cd_convenio ) + ") | Condi$$HEX2$$e700e300$$ENDHEX$$o: " + &
															io_condicao_convenio.de_condicao_convenio + " (" + String( io_condicao_convenio.cd_condicao_convenio ) + ")"
Else
	dw_5.Object.t_convenio_condicao.Text = ""
End If

dw_5.Object.razao_social_t.Text	= gvo_Parametro.nm_razao_social
dw_5.Object.endereco_t.Text		= gvo_Parametro.de_endereco + ", " + String( gvo_Parametro.nr_endereco )
dw_5.Object.nr_telefone_t.Text	= gvo_Parametro.nr_ddd + ' ' + gvo_Parametro.nr_telefone
dw_5.Object.data_t.Text				= gvo_Parametro.nm_cidade_filial + ", " + String( li_Dia ) + " de " + gf_mes_extenso( li_Mes ) + " de " + String( li_Ano )  
dw_5.Object.vl_total_geral_t.Text	=  String( dw_2.GetItemDecimal(dw_2.RowCount(), "c_total"), "R$ #,##0.00")

dw_5.Object.cliente_t.Text			= "Cliente: " + ls_Cliente + ", " + ls_CPF

//Chamado: 1461064
//Choose Case gvo_Parametro.ivs_uf_filial
//	Case 'RS'
//		
//		
//	Case 'SC', 'PR', 'MS'
//		dw_5.Object.t_banco.Text				= "CEF $$HEX1$$1320$$ENDHEX$$ 104"
//		dw_5.Object.t_agencia.Text				= "Ag$$HEX1$$ea00$$ENDHEX$$ncia: 4265"
//		dw_5.Object.t_conta_corrente.Text	= "Conta Corrente: 900.520-7"
//
//	Case Else
//		dw_5.Object.t_banco.Text				= "Banco: "
//		dw_5.Object.t_agencia.Text				= "Ag$$HEX1$$ea00$$ENDHEX$$ncia: "
//		dw_5.Object.t_conta_corrente.Text	= "Conta Corrente: "		
//End Choose

dw_5.Object.t_banco.Text				= "BANRISUL $$HEX1$$1320$$ENDHEX$$ 041"
dw_5.Object.t_agencia.Text				= "Ag$$HEX1$$ea00$$ENDHEX$$ncia: 0243"
dw_5.Object.t_conta_corrente.Text	= "Conta Corrente: 06.000150.0-7"

For lvl_ind = 1 To dw_2.RowCount()
	i = dw_5.InsertRow(0)
	ll_Produto = dw_2.Object.cd_produto[ lvl_ind ]
	
	ivo_Produto.of_localiza_codigo_interno( ll_Produto )
	
	If ivo_Produto.Localizado Then
		If LeftA( ivo_produto.cd_subcategoria, 1 ) = '1' Then
		
			SELECT de_subcategoria
			INTO :ls_Subcategoria
			FROM vw_classificacao_produto
			WHERE cd_subcategoria = :ivo_produto.cd_subcategoria
			USING SQLCA;
			
			ls_Subcategoria = " (" + ls_Subcategoria + ")"
		Else
			ls_Subcategoria = ''
		End If
		
		dw_5.Object.de_substancia[ i ] = ls_Subcategoria
	End If
	
	dw_5.Object.qt_orcada			[ i ] = dw_2.Object.qt_orcada				[ lvl_ind ]
	dw_5.Object.de_produto			[ i ] = String( ll_Produto ) + "-" + dw_2.Object.de_produto	[ lvl_ind ] + ls_Subcategoria
	dw_5.Object.vl_unitario			[ i ] = dw_2.Object.vl_preco_final			[ lvl_ind ]
	dw_5.Object.vl_total				[ i ] = dw_2.Object.c_total_produto		[ lvl_ind ]
	
	If io_condicao_convenio.localizado Then
		If dw_2.Object.Pc_Desconto_Convenio[ lvl_ind ] > 0 Then
			dw_5.Object.vl_unitario	[ i ]	= dw_2.Object.Vl_Preco_Convenio		[ lvl_ind ]
			dw_5.Object.vl_total		[ i ]	= dw_2.Object.c_total_preco_convenio	[ lvl_ind ]
			dw_5.Object.vl_total_geral_t.Text	=  String( dw_2.GetItemDecimal(dw_2.RowCount(), "c_total_convenio"), "R$ #,##0.00")
		End If
	End If
	
	UPDATE cliente_caixa_produto
	SET id_orcamento_judicial = 'S'
	WHERE nr_sequencial_cliente_caixa = :il_Sequencial_Cliente_Caixa
	AND cd_produto = :ll_Produto
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack( )
		SqlCa.of_Msgdberror( )
	Else
		SqlCa.of_Commit( )
	End If
Next

If dw_5.RowCount() = 0 Then Return False
	
dw_5.GroupCalc()

dw_5.of_Print(pb_Imeditato)

Return True
end function

public function boolean wf_existe_produto_orcamento (decimal pdc_desconto_produto);Long ll_Find_Etiqueta_Prestes
Long lvl_find
Long ll_Qt_Orcada
Long ll_Filial_Reserva = 0

Integer li_Seq_Cliente_Caixa_Prd

String ls_Find_Filial_Reserva

dw_2.AcceptText( )

ll_Filial_Reserva = dw_2.Object.cd_Filial_Reserva[ dw_2.getRow( ) ]

If IsNull( ll_Filial_Reserva ) Then 
	ls_Find_Filial_Reserva = " IsNull( cd_filial_reserva ) "
Else
	ls_Find_Filial_Reserva = " cd_filial_reserva = " + String( ll_Filial_Reserva ) + " "
End If

lvl_find = dw_2.Find (	"cd_produto = "+String(ivo_produto.cd_produto) + " and pc_desconto_fixo = " + gf_Valor_Com_Ponto( pdc_desconto_produto ) + " and " + ls_Find_Filial_Reserva + " and id_cobre_preco = 'N'", &
							1,	dw_2.RowCount( ) )

If lvl_find = 0 Then Return False

If Not IsNull( ivo_Produto.Nr_Etiqueta_Preste ) Then
	ll_Find_Etiqueta_Prestes =	dw_2.Find (	"nr_etiqueta_prestes = '"+String( ivo_Produto.Nr_Etiqueta_Preste ) + "'", &
										1,	dw_2.RowCount( ) )
										
	If ll_Find_Etiqueta_Prestes > 0 Then
		MessageBox( "OPERA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA", "Etiqueta de produto prestes a vencer j$$HEX1$$e100$$ENDHEX$$ utilizada na consulta.~r~rO produto n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ adicionado novamente $$HEX1$$e000$$ENDHEX$$ lista.", Exclamation! )
		Return True
	End If
End If

dw_2.Object.qt_orcada [lvl_find] = dw_2.Object.qt_orcada [lvl_find] + 1

ll_Qt_Orcada = dw_2.Object.qt_orcada [lvl_find]
li_Seq_Cliente_Caixa_Prd = dw_2.Object.nr_seq_cliente_caixa_prd [lvl_find]

UPDATE cliente_caixa_produto
SET qt_produto = :ll_Qt_Orcada
WHERE cd_filial							= dbo.uf_filial_parametro( )
AND nr_sequencial_cliente_caixa	= :il_Sequencial_Cliente_Caixa
AND nr_sequencial						= :li_Seq_Cliente_Caixa_Prd
USING SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack( )
	SqlCa.of_MsgDbError( )
Else
	SqlCa.of_Commit( )
End If	

wf_Registra_Produto_Sem_Saldo(lvl_Find)

Return True
end function

public function integer wf_localiza_produto_prestes ();Long ll_Dias_Vencimento

Decimal ldc_Desconto

Long ll_Linha
Long ll_Prod
Long ll_Qtde_Com_Desconto

String ls_Etiquetas_Orcadas[ ]
String ls_Etiqueta
String ls_Mensagem

srt_mensagem_prestes lstr_mensagem_prestes

//If Not IsNull( ivo_Produto.Nr_Etiqueta_Preste ) Then Return 1

If Not IsNull( ivo_Produto.Nr_Etiqueta_Preste ) Then
	If ivo_Produto.id_Situacao_Preste <> 'A' Then // Etiqueta j$$HEX1$$e100$$ENDHEX$$ baixada
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Etiqueta de produto prestes j$$HEX1$$e100$$ENDHEX$$ baixada.", StopSign! )
		Return -1 //N$$HEX1$$e300$$ENDHEX$$o deixa selecionar o produto
	End If	
	Return 1
End If

ls_Etiquetas_Orcadas[ 1 ] = ''

For ll_Linha = 1 To dw_2.RowCount( )
	If Not IsNull( dw_2.Object.Nr_Etiqueta_Prestes[ ll_Linha ] ) Then
		ls_Etiquetas_Orcadas[ UpperBound( ls_Etiquetas_Orcadas ) + 1 ] = dw_2.Object.Nr_Etiqueta_Prestes[ ll_Linha ]
	End If
Next
	
setNull( ls_Etiqueta )

uo_ge108_Produto lo_Produto_Prestes
lo_Produto_Prestes = Create uo_ge108_Produto
lo_Produto_Prestes.Of_Localiza_Produto(String(ivo_Produto.Cd_Produto))

ldc_Desconto = lo_Produto_Prestes.Of_Desconto_prestes( 	True, &
																			True, &
																			ls_Etiquetas_Orcadas, &
																			ls_Etiqueta, &
																			ll_Prod, &
																			ll_Qtde_Com_Desconto)
																	
If Not IsNull( ls_Etiqueta ) Then

	lo_Produto_Prestes.of_Localiza_Produto( ls_Etiqueta )
		
	If lo_Produto_Prestes.id_Situacao_Preste = "A" Then
		If ll_Prod <> ivo_Produto.Cd_Produto Then
			lstr_mensagem_prestes.cd_backcolor = 65535 // YELLOW
			lstr_mensagem_prestes.de_titulo = 'Existe um produto de mesma formula$$HEX2$$e700e300$$ENDHEX$$o '
		Else
			lstr_mensagem_prestes.cd_backcolor = 12639424
			lstr_mensagem_prestes.de_titulo = 'Existe este produto '
		End If
		
		If ldc_Desconto > 0 Then
			lstr_mensagem_prestes.de_titulo += 'prestes a vencer'
			lstr_mensagem_prestes.desc_produto 	+= lo_Produto_Prestes.ivs_Descricao_Apresentacao_Venda
			lstr_mensagem_prestes.pc_Desconto 	= ldc_Desconto
			lstr_mensagem_prestes.vl_venda	 		= Round(lo_Produto_Prestes.of_Preco_Venda_Filial() * (1 - ldc_Desconto / 100),2)
			lstr_mensagem_prestes.dh_Validade 		= lo_Produto_Prestes.dh_Validade_Preste
			lstr_mensagem_prestes.qt_disponivel 	= ll_Qtde_Com_Desconto

			/* Produto com desconto, apresenta mensagem para vendedor oferecer ao cliente com desconto */
			OpenWithParm( w_ge108_mensagem_prestes, lstr_mensagem_prestes )
			If Not IsNull( Message.StringParm ) Then // SIM
				//This.Post wf_Localiza_Produto(ls_Etiqueta)
				wf_Localiza_Produto(ls_Etiqueta)
				Return 0
			End If
			
		Else
			ll_Dias_Vencimento = DaysAfter( Date( gvo_Parametro.of_Dh_Movimentacao( ) ), Date( lo_Produto_Prestes.dh_validade_preste ) )
			
			If ll_Dias_Vencimento <= 180 Then
				ls_Mensagem = lstr_mensagem_prestes.de_titulo + "em estoque com vencimento em " + String( lo_Produto_Prestes.dh_validade_preste, "mm/yyyy." )
				
				If lstr_mensagem_prestes.cd_backcolor = 65535 Then
					ls_Mensagem += "~r~rVerifique pelo Busca F$$HEX1$$e100$$ENDHEX$$cil [F6]."
				End If
				
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Exclamation! )
				
			End If
		End If
	End If
End If

If IsValid(lo_Produto_Prestes) Then Destroy lo_Produto_Prestes

Return 1

end function

public subroutine wf_drivers_painel_senha ();
end subroutine

public subroutine wf_driver_painel_senha ();Integer li_Arquivo

String ls_Bat = ''

If Not FileExists( 'c:\sistemas\rl\exe\painel_senha.zip' ) Then Return

Try	
	Open( w_Aguarde )
	w_Aguarde.Title = "Aguarde, atualizando DLL's do painel de senhas..."
	
	dc_uo_Api lo_Api
	lo_Api = Create dc_uo_Api
	
	If lo_api.of_unzip( 'c:\sistemas\rl\exe\painel_senha.zip', 'C:\Sistemas\DLL\Painel_Senha' ) Then
		lo_api.of_delete_file( 'c:\sistemas\rl\exe\painel_senha.zip', False )
	End If			
	
	Destroy(lo_Api)

	ls_Bat += 'set path="%path%";C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319' + Char(13) + Char(10)
	ls_Bat += 'cd \' + Char(13) + Char(10)
	ls_Bat += 'cd sistemas\dll\painel_senha' + Char(13) + Char(10)
	ls_Bat += 'regasm /tlb:LibMig.tlb LibMig.dll /codebase' + Char(13) + Char(10)
	ls_Bat += 'regasm /tlb:WyDriver.tlb WyDriver.dll /codebase'
	
	li_Arquivo = FileOpen( 'c:\sistemas\rl\arquivos\instala_painel_senha.bat',  StreamMode!, Write!, LockWrite!, Replace! )

	If li_Arquivo = -1 Then Return
	
	FileWrite( li_Arquivo, ls_Bat )
	FileClose( li_Arquivo )	
	
	gf_Run( 'c:\sistemas\rl\arquivos\instala_painel_senha.bat' )
Catch( RuntimeError ru )
	If IsValid( lo_Api ) Then Destroy lo_Api
	
	FileClose( li_Arquivo )	
	
	MessageBox( "RuntimeError", ru.getMessage( ) + 'wf_driver_painel_senha( )', StopSign! )
Finally
	Close( w_Aguarde )
End Try
end subroutine

public function boolean wf_connecttonewobject (ref oleobject p_object, string ps_conexao);Integer li_Retorno

String ls_Erro = ""

Try
	li_Retorno = p_object.ConnectToNewObject( ps_conexao )
	
	// Mensagens traduzidas a partir do help
	Choose Case li_Retorno
		Case 0
			Return True
		Case -1 
			ls_Erro = "Chamada inv$$HEX1$$e100$$ENDHEX$$lida: o argumento $$HEX1$$e900$$ENDHEX$$ a propriedade de objeto de um controle"
		Case -2
			ls_Erro = "Nome da classe n$$HEX1$$e300$$ENDHEX$$o encontrado"
		Case -3
			ls_Erro = "Objeto " + ps_conexao + " n$$HEX1$$e300$$ENDHEX$$o pode ser criado"
		Case -4
			ls_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar ao objeto"
		Case -9
			ls_Erro = "Outro erro"
		Case -15
			ls_Erro = "COM + n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ carregado neste computador"
		Case -16
			ls_Erro = "Chamada inv$$HEX1$$e100$$ENDHEX$$lida: esta fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o se aplica"
	End Choose
	
	Return False
	
Catch ( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + '~rFunction: wf_connecttonewobject( oleobject, ' + ps_conexao + ' )', StopSign! )
Finally
	If ls_Erro <> "" Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", 'A fun$$HEX2$$e700e300$$ENDHEX$$o ConnectToNewObject( ) retornou o seguinte erro: ' + ls_Erro, StopSign! )
	End If
End Try
end function

public function boolean wf_negociacao_cliente ();Long ll_Row
Long ll_Produto
Long ll_Linha_DS
Long ll_Linhas_Retorno

Decimal ldc_Preco_Final
Decimal ldc_Desconto

Try
	SetNull( is_Matricula_Negociacao )
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	If dw_2.RowCount() <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto selecionado.", Exclamation!)
		Return False
	Else
		If IsNull( dw_2.Object.cd_produto[1] ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto selecionado.", Exclamation!)
			Return False
		End If
	End If
		
	If Not ids_Negociacao_Aux.of_ChangeDataObject( "dw_ge108_lista_produto_negociacao" ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_Changedataobject. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_negociacao_cliente", Exclamation!)
		Return False
	End If
	
	If Not ids_Negociacao.of_ChangeDataObject( "dw_ge108_lista_produto_negociacao" ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_Changedataobject. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_negociacao_cliente", Exclamation!)
		Return False
	End If
		
	//Atribui os produtos da dw_2 para ids_Negociacao_Aux
	For ll_Row = 1 To dw_2.RowCount()
		ll_Produto = dw_2.Object.cd_produto[ ll_Row ]
		
		If IsNull(ll_Produto) Then Continue
		
		If dw_2.Object.id_pbm_clamed [ ll_Row ] = "S" Then Continue
		
		ll_Linha_DS = ids_Negociacao_Aux.InsertRow(0)
		ids_Negociacao_Aux.Object.cd_produto					[ ll_Linha_DS ] 	= ll_Produto
		ids_Negociacao_Aux.Object.de_produto					[ ll_Linha_DS ] 	= dw_2.Object.de_produto 			[ ll_Row ]
		ids_Negociacao_Aux.Object.qt_negociada				[ ll_Linha_DS ] 	= dw_2.Object.qt_orcada 			[ ll_Row ]
		ids_Negociacao_Aux.Object.vl_preco_unitario			[ ll_Linha_DS ] 	= dw_2.Object.vl_preco_unitario	[ ll_Row ] 
		ids_Negociacao_Aux.Object.pc_icms						[ ll_Linha_DS ] 	= dw_2.Object.pc_icms				[ ll_Row ] 
		ids_Negociacao_Aux.Object.vl_preco_tabela				[ ll_Linha_DS ]	= dw_2.Object.vl_preco_final		[ ll_Row ]
		ids_Negociacao_Aux.Object.vl_preco_liquido			[ ll_Linha_DS ] 	= Round( dw_2.Object.vl_preco_final	[ ll_Row ] * dw_2.Object.qt_orcada 			[ ll_Row ] , 2)
		ldc_Preco_Final																		= dw_2.Object.vl_preco_final		[ ll_Row ]
		ldc_Desconto																		= dw_2.Object.pc_desconto_fixo	[ ll_Row ]
				
		If ivo_cliente.Localizado Then
			If dw_2.Object.pc_desconto_clube [ ll_Row ] > ldc_Desconto Then
				ldc_Desconto 		= dw_2.Object.pc_desconto_clube 	[ ll_Row ]
				ldc_Preco_Final 	= dw_2.Object.vl_preco_clube			[ ll_Row ]
			End If
		End If
		
		ids_Negociacao_Aux.Object.pc_desconto_unitario		[ ll_Linha_DS ] = ldc_Desconto
		
		ids_Negociacao_Aux.Object.vl_preco_negociado		[ ll_Linha_DS ] = ldc_Preco_Final
		ids_Negociacao_Aux.Object.pc_desconto_negociado	[ ll_Linha_DS ] = ldc_Desconto
	Next
	
	If ids_Negociacao_Aux.RowCount() = 0 Then
		Return False
	End If
	
	ids_Negociacao_Aux.Object.nr_matricula_vendedor[ 1 ]  = is_Matricula_Vendedor

	OpenWithParm( w_ge108_negociacao, ids_Negociacao_Aux )		
		
	ids_Negociacao = Message.PowerObjectParm
	
	If IsNull( ids_Negociacao ) Or Not IsValid(ids_Negociacao) Then
		Return False
	End If
	
	ll_Linhas_Retorno = ids_Negociacao.RowCount()
	
	If ll_Linhas_Retorno <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto negociado. wf_negociacao_cliente", Exclamation!)
		Return False
	End If
	
	//A matricula foi atribuida apenas na primeira linha da ds de retorno
	is_Matricula_Negociacao 	= ids_Negociacao.Object.nr_matricula_negociacao	[ 1 ]  
	is_Vendedor_Negociacao 	= ids_Negociacao.Object.nr_matricula_vendedor		[ 1 ]  

	
	If IsNull( is_Matricula_Negociacao ) Or is_Matricula_Negociacao = '' Then
		Return False
	Else
		Return True		
	End If

Finally
	//If IsValid(  ids_Negociacao_Aux ) Then Destroy ids_Negociacao_Aux
End Try



end function

public function boolean wf_grava_negociacao_cliente (long al_sequencial);Long ll_Row
Long ll_Linhas
Long ll_Produto
Long ll_qtde
Long ll_Concorrente

Integer li_Count

Decimal ldc_Valor_UN
Decimal ldc_Desc_Negociado
Decimal ldc_Vl_Negociado
Decimal ldc_Vl_Concorrente
Decimal ldc_Desc_UN

String ls_Laboratorio
String ls_Outros_Concorrentes

If Not IsValid( ids_Negociacao ) Then Return False

ll_Linhas = ids_Negociacao.RowCount()

Select count(nr_sequencial) 
	into :li_Count
from negociacao_cliente
where cd_filial 			= :gvo_Parametro.Cd_Filial
	and nr_sequencial = :al_Sequencial
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar a negociacao cliente. seq. " + String(al_Sequencial))
	Return False
End If

If li_Count > 0 Then
	delete from negociacao_cliente
		where cd_filial 			= :gvo_Parametro.Cd_Filial
		and nr_sequencial 	= :al_Sequencial
		Using SqlCa;
End If

For ll_Row = 1 To ll_Linhas
	ldc_Valor_UN 			= 0.00
	ldc_Vl_Negociado		= 0.00
	ldc_Vl_Concorrente	= 0.00
	ldc_Desc_Negociado 	= 0.00
	ldc_Desc_UN			= 0.00
	
	ll_Produto 					= ids_Negociacao.Object.cd_produto					[ ll_Row ]
	ll_qtde						= ids_Negociacao.Object.qt_negociada				[ ll_Row ]
	ldc_Valor_UN				= ids_Negociacao.Object.vl_preco_unitario 			[ ll_Row ]
	ldc_Desc_Negociado		= ids_Negociacao.Object.pc_desconto_negociado	[ ll_Row ]
	ldc_Vl_Negociado			= ids_Negociacao.Object.vl_preco_negociado		[ ll_Row ]
	ll_Concorrente 				= ids_Negociacao.Object.cd_concorrente 			[ ll_Row ]
	ldc_Vl_Concorrente		= ids_Negociacao.Object.vl_preco_concorrente 	[ ll_Row ] 
	ls_Laboratorio 				= ids_Negociacao.Object.de_laboratorio	 			[ ll_Row ]
	ldc_Desc_UN				= ids_Negociacao.Object.pc_desconto_unitario		[ ll_Row ]
	
	INSERT INTO negociacao_cliente(
		cd_filial,
		nr_sequencial,
		cd_produto,
		vl_preco_unitario,
		qt_negociada,
		pc_desconto_negociado,
		vl_preco_negociado,
		cd_concorrente,
		vl_preco_concorrente,
		de_laboratorio,
		pc_desconto_unitario
	)VALUES(
		:gvo_Parametro.Cd_Filial,
		:al_Sequencial,
		:ll_Produto,
		:ldc_Valor_UN,
		:ll_qtde,
		:ldc_Desc_Negociado,
		:ldc_Vl_Negociado,
		:ll_Concorrente,
		:ldc_Vl_Concorrente,
		:ls_Laboratorio,
		:ldc_Desc_UN
	)Using SqlCA;
		
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback( )
		SqlCa.of_MsgDbError( "Erro inclus$$HEX1$$e300$$ENDHEX$$o produto " + String(ll_Produto) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_grava_negociacao_cliente" )
		Return False
	End If
	
Next

Return True




end function

public function decimal wf_pc_icms_produto ();Decimal ldc_PC_ICMS

ldc_PC_ICMS = 0.00

If This.ivo_Produto.cd_tributacao_icms <> '0' And This.ivo_Produto.cd_tributacao_icms <> '2' Then
	Return ldc_PC_ICMS	
End If

select Coalesce(t.pc_icms , 0.00)
	into :ldc_PC_ICMS
from produto_geral g
	left outer join  tipo_icms t
		on t.cd_tipo_icms 					= g.cd_tipo_icms
		and t.cd_unidade_federacao	= :gvo_Parametro.ivs_uf_filial
where g.cd_produto						= :This.ivo_Produto.cd_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdberror( "Erro ao localizar a al$$HEX1$$ed00$$ENDHEX$$quota ICMS do produto " + String( This.ivo_Produto.cd_Produto ) + "." )
End If

Return ldc_PC_ICMS


end function

public function boolean wf_conclui_desistencia ();String ls_matricula
String ls_motivo
String ls_cliente
String ls_nome
String ls_nome_Aux
String ls_Codigo_Dep
Long ll_controle
Long ll_Linhas
Boolean lb_registra_desistencia = False

dw_1.AcceptText()

lb_registra_desistencia = ( Not IsNull( dw_1.Object.cd_cliente[1] ) )

dw_2.AcceptText()

ll_Linhas = dw_2.RowCount()
If ll_Linhas > 0 Then
	If ll_Linhas = 1 Then
		If ib_Produto_Informado Then
			lb_registra_desistencia = True
		End If
	Else
		lb_registra_desistencia = True		
	End If
End If

If lb_registra_desistencia Then
	
	If ivi_Qtde_Itens_Reservados > 0 Then
		If MessageBox( "Cancelamento de reserva", "A reserva dos produtos pr$$HEX1$$e900$$ENDHEX$$-reservados ser$$HEX1$$e100$$ENDHEX$$ perdida.~r~rDeseja realmente cancelar a reserva?", Question!, YesNo!, 2 ) = 2 Then
			Return False
		End If
	End If

	OpenWithParm( w_ge108_desistencia, is_Nm_Vendedor )
	If Not IsNull( Message.StringParm ) Then // Selecionou alguma op$$HEX2$$e700e300$$ENDHEX$$o
		ls_motivo = 	Message.StringParm
		
		ls_Cliente	= ivo_Cliente.Cd_Cliente
		ls_Nome		= ivo_Cliente.Nm_Cliente
		
		If ls_Cliente = '' Then SetNull( ls_Cliente )
		If ls_Nome = '' Then setNull(ls_Nome)
		
		ls_Nome_Aux = ls_Nome
		ls_Nome 		= ls_Nome_Aux
		
		If Not IsNull( ivo_Cliente.Cd_Dependente ) Then
			ls_Codigo_Dep	= ivo_Cliente.Cd_Dependente
			ls_Nome			= ivo_Cliente.Nm_Dependente
		Else
			SetNull( ls_Codigo_Dep )
		End If
		
		//Cancela ped empurrado matriz
		wf_conclui_desistencia_ped_empurrado()
		
		If ivi_Qtde_Itens_Reservados > 0 Then
			Update cliente_caixa set
				cd_cliente 					= :ls_cliente,
				nm_cliente	 				= :ls_nome,
				cd_dependente 			= :ls_codigo_dep,
				de_motivo_desistencia 	= :ls_motivo,
				id_situacao 					= 'X'
			Where nr_sequencial 			= :il_Sequencial_Cliente_Caixa
				and id_tipo					= 'R'
			Using SqlCa;
		Else
			Update cliente_caixa set
				cd_cliente 					= :ls_cliente,
				nm_cliente	 				= :ls_nome,
				cd_dependente 			= :ls_codigo_dep,
				de_motivo_desistencia 	= :ls_motivo
			Where nr_sequencial 			= :il_Sequencial_Cliente_Caixa
			Using SqlCa;
		End If
			
		Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_RollBack()
				SqlCa.of_MsgDbError()
				
			Case Else		
				SqlCa.of_Commit()
				SetNull(il_Sequencial_Cliente_Caixa)
				This.ib_Conclusao_Atendimento_Pendente = False
				Close( This )
				Return True
		End Choose	
	End If

	Return False

Else
	This.ib_Conclusao_Atendimento_Pendente = False
	Return True
End If
end function

public subroutine wf_inicializa_objetos ();dw_1.Event ue_Reset()
dw_1.Object.Cartao_Clube_t.Visible = False
dw_2.Event ue_Reset()
dw_1.Event ue_AddRow()
dw_2.Event ue_AddRow()

ivo_Cliente.of_Inicializa()
ivo_Vendedor.of_Inicializa()
io_Convenio.of_Inicializa( )

SetNull(is_Matricula_Negociacao)
SetNull(is_Vendedor_Negociacao)

ids_Prd_Campanha_Cliente.Reset()
ids_Prd_Campanha_Cliente.of_restoresqloriginal( )

If IsValid( io_Cobre_Preco ) Then Destroy io_Cobre_Preco

io_Cobre_Preco = Create uo_rl154_parametros

end subroutine

public function boolean wf_localiza_produto (string ps_parametro);Integer lvi_Contador

Long	lvl_Linha, &
		lvl_Saldo, &
		lvl_Filial, &
		lvl_Saldo_Pendente
Long	ll_Seq_Cliente_Caixa_Produto = 1
Long ll_Count_Saldo_Pendente
Long ll_row
Long ll_convenio
Long ll_contrato

String	lvs_Produto, &
		lvs_Situacao, &
		lvs_Local, &
		lvs_Indicador_Comissao		

Decimal lvdc_Desconto_SOS
Decimal ldc_Desconto_Produto
Decimal ldc_Preco_Final
Decimal ldc_Desconto_Convenio
Decimal ldc_desconto_plano_saude
Decimal ldc_desconto_plano_aux
Decimal ldc_Desconto_Campanha

dw_2.AcceptText()

lvs_Produto = ps_parametro

ivo_Produto.is_window_selecao_generica = "w_ge001_selecao_produto_filial_atendimento"
ivo_Produto.ids_contratos_bin.reset( );
If This.ids_contratos_bin.rowcount( )  > 0 And Not IsNull(This.is_cartao_desconto) and Trim(This.is_cartao_desconto) <> '' Then
	If Not ivo_Produto.ids_contratos_bin.of_ChangeDataObject('ds_ge004_contratos_ativos') Then Return False
	ivo_Produto.nr_cartao_saude_desconto = This.is_cartao_desconto
	This.ids_contratos_bin.rowscopy( 1, This.ids_contratos_bin.RowCount(), Primary!, ivo_Produto.ids_contratos_bin, 1, Primary!)
End If
ivo_Produto.of_Localiza_Produto(lvs_Produto)

If ivo_Produto.Localizado Then
	
	wf_Alerta_Reserva_Pendente( )
		
	If This.wf_Localiza_Produto_Prestes( ) < 1 Then Return True
	
	lvl_Filial = gvo_Parametro.of_Filial()
	
	ldc_Desconto_Produto 		= This.wf_Localiza_Desconto_Produto( Ref ldc_Desconto_Convenio )
	ldc_Desconto_Campanha 	= This.wf_desconto_campanha()

	If ldc_Desconto_Campanha > ldc_Desconto_Produto Then
		ldc_Desconto_Produto = ldc_Desconto_Campanha
	End If
	
	If ldc_Desconto_Produto > ldc_Desconto_Convenio Then
		ldc_Desconto_Convenio = ldc_Desconto_Produto
	End If
	
	If This.ib_Produto_Vencido Then Return False
	
	If wf_Existe_Produto_Orcamento( ldc_Desconto_Produto ) Then
		dw_2.Object.De_Produto[dw_2.GetRow()] = ""
		dw_2.SetColumn("de_produto")
		Return False
	End If

	SELECT COUNT(*)
	INTO :ll_Count_Saldo_Pendente
	FROM vw_saldo_produto_pendente
	WHERE cd_produto = :ivo_Produto.cd_Produto
	USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError( )
			dw_2.Object.Id_Saldo_Pendente[dw_2.GetRow()] = 'N'
			
		Case 0
			If ll_Count_Saldo_Pendente = 0 Then
				dw_2.Object.Id_Saldo_Pendente[dw_2.GetRow()] = 'N'
			Else
				dw_2.Object.Id_Saldo_Pendente[dw_2.GetRow()] = 'S'
			End If
	End Choose
	

	lvl_Saldo   		 = wf_Saldo_Produto(ivo_Produto.Cd_Produto)	
	lvs_Situacao		 = wf_Verifica_Situacao(ivo_Produto.Cd_Produto)	
	lvs_Local   		 = wf_Verifica_Local_Estocagem(ivo_Produto.Cd_Produto)
	
	lvl_linha = dw_2.GetRow()
	
	//Promocao Vinculada
	If ivo_Produto.Of_Existe_Promocao_Vinculada() Then
		dw_2.Object.id_promocao_vinculada[ lvl_linha ] = 'S'
	Else
		dw_2.Object.id_promocao_vinculada[ lvl_linha ] = 'N'
	End If	
	
	//PBM Clamed
	If ivo_produto.of_possui_pbm_clamed() Then
		dw_2.Object.id_pbm_clamed[ lvl_linha ] = 'S'
	Else
		dw_2.Object.id_pbm_clamed[ lvl_linha ] = 'N'		
	End If
	
	//Promocao Progressiva
	If ivo_produto.of_possui_promocao_progressiva() Then
		dw_2.Object.id_promocao_progressiva[ lvl_linha ] = 'S'
	Else
		dw_2.Object.id_promocao_progressiva[ lvl_linha ] = 'N'		
	End If
	
	wf_Verifica_Vidalink(ivo_Produto.Cd_Produto, lvl_linha)
	wf_Verifica_Pbm(ivo_Produto.Cd_Produto, lvl_linha)
		
	lvdc_Desconto_SOS = ivo_Produto.of_Desconto_SOS()
	
	If lvdc_Desconto_SOS < 0 Then lvdc_Desconto_SOS = 0
			
	dw_2.SetReDraw(False)
	dw_2.Object.cd_produto [lvl_linha] = ivo_produto.cd_produto
	
	// Verifica se o produto tem comiss$$HEX1$$e300$$ENDHEX$$o extra
	If Not wf_Comissao_Extra(Ref lvi_Contador, lvl_Linha) Then Return False
	
	//Desconto plano de saude
	If This.ids_contratos_bin.rowcount( )  > 0 And Not IsNull(This.is_cartao_desconto) and Trim(This.is_cartao_desconto) <> '' Then
		For ll_row = 1 to This.ids_contratos_bin.rowcount( )
			ll_convenio = This.ids_contratos_bin.object.cd_convenio[ll_row]
			ll_contrato  = This.ids_contratos_bin.object.nr_contrato[ll_row]					
			ldc_desconto_plano_aux = ivo_Produto.of_desconto_contrato_convenio(ll_convenio, ll_contrato)	
			If ldc_desconto_plano_aux > ldc_desconto_plano_saude Then
				ldc_desconto_plano_saude 				= ldc_desconto_plano_aux
			End If	
			ldc_desconto_plano_aux = 000.00
		Next
		If ldc_desconto_plano_saude > 0 Then
			dw_2.Object.pc_desconto_plano_saude [lvl_linha] = ldc_desconto_plano_saude
			If ldc_desconto_plano_saude > ldc_Desconto_Convenio Then
				ldc_Desconto_Convenio = ldc_desconto_plano_saude
			End If
		End If
	End If	
	
	dw_2.Object.de_produto 				[lvl_linha] = ivo_produto.ivs_descricao_apresentacao_venda
	dw_2.Object.qt_orcada	   				[lvl_linha] = 1
	dw_2.Object.qt_estoque	   				[lvl_linha] = lvl_Saldo
	dw_2.Object.id_situacao					[lvl_linha] = lvs_Situacao
	dw_2.Object.local      					[lvl_linha] = "Local: " + lvs_Local
	dw_2.Object.vl_preco_unitario			[lvl_linha] = ivo_Produto.of_Preco_Venda_Filial( )
	dw_2.Object.pc_desconto_fixo			[lvl_linha] = ldc_Desconto_Produto
	dw_2.Object.pc_desconto_negociavel	[lvl_linha] = ivo_Produto.of_Desconto_Negociavel( )
	dw_2.Object.Pc_Desconto_SOS  		[lvl_linha] = lvdc_Desconto_SOS
	dw_2.Object.Pc_Desconto_Clube		[lvl_linha] = ivo_Produto.of_Desconto_Clube( )
	dw_2.Object.Pc_Desconto_Convenio	[lvl_linha] = ldc_Desconto_Convenio
	dw_2.Object.id_gratis_farm_popular	[lvl_linha] = ivo_Produto.id_gratis_farm_popular
	dw_2.Object.id_farmacia_popular		[lvl_linha] = ivo_Produto.id_farmacia_popular
	dw_2.Object.id_promover_venda		[lvl_linha] = ivo_Produto.id_promover_venda
	dw_2.Object.id_lei_generico			[lvl_linha] = ivo_Produto.id_lei_generico
	dw_2.Object.nr_etiqueta_prestes		[lvl_linha] = ivo_Produto.nr_etiqueta_preste
	dw_2.Object.pc_icms						[lvl_linha] = wf_PC_ICMS_Produto( )
	dw_2.Object.Id_Contem_Acucar		[lvl_linha] = ivo_Produto.Id_Contem_Acucar
	dw_2.Object.Id_Contem_Gluten		[lvl_linha] = ivo_Produto.Id_Contem_Gluten
	dw_2.Object.Id_Contem_Lactose		[lvl_linha] = ivo_Produto.Id_Contem_Lactose
	dw_2.Object.vl_reembolso_fpb			[lvl_linha] = ivo_Produto.vl_reembolso_fpb
	dw_2.Object.cd_grupo_psico			[lvl_linha] = ivo_produto.cd_grupo_psico
	dw_2.Object.de_codigo_barras			[lvl_linha] = ivo_produto.de_codigo_barras
		
	dw_2.Object.Pc_Desconto_SOS_Farm_Popular[lvl_linha] = wf_Promocao_SOS_Farm_Popular()
	
	wf_Registra_Produto_Sem_Saldo(lvl_Linha)
	
	dw_2.SetReDraw(True)

	//Se o produto possui PBM ou PBM Clamed ser$$HEX1$$e100$$ENDHEX$$ apresentada uma tela de alerta
	If dw_2.Object.id_PBM [lvl_linha] = 'S' OR dw_2.Object.id_pbm_clamed [ lvl_linha ] = 'S' Then
		OpenWithParm(w_ge108_mensagem_produto_pbm, "")
		If Message.StringParm = 'F5' Then
			dw_2.Event ue_Key( KeyF5!, 0 )
		End If
	End If

	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o

	ll_Seq_Cliente_Caixa_Produto = dw_2.Object.nr_seq_cliente_caixa_prd[ lvl_linha ]
	
	If Not ib_Reserva_Produto Then
		ldc_Preco_Final = dw_2.Object.vl_preco_final	[lvl_linha]
		
		INSERT INTO cliente_caixa_produto( cd_filial, nr_sequencial_cliente_caixa, nr_sequencial, cd_produto, qt_produto, id_situacao, vl_preco_unitario, qt_saldo_atual )
		VALUES ( dbo.uf_filial_parametro( ), :il_Sequencial_Cliente_Caixa, :ll_Seq_Cliente_Caixa_Produto, :ivo_produto.cd_produto, 1, 'X', :ldc_Preco_Final, :lvl_Saldo )
		USING SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack( )
			SqlCa.of_MsgDbError( )
		Else
			SqlCa.of_Commit( )
		End If	
	End If
	
	If IsNull( ivo_Produto.Nr_Etiqueta_Preste ) Then
		dw_2.SetColumn("qt_orcada")	
		dw_2.Event RowFocusChanged(lvl_linha)
	Else
		If Not ib_Reserva_Produto Then
			lvl_Linha = dw_2.Event ue_AddRow()
			dw_2.Event ue_Pos( dw_2.RowCount(), 'de_produto' )
		End If
	End If
	
	//Ao informar um produto e exclu$$HEX1$$ed00$$ENDHEX$$-lo em seguida ser$$HEX1$$e100$$ENDHEX$$ solicitado o motivo da desistencia no fechamento da tela.
	ib_Produto_Informado = True
	wf_bloqueia_campos_convenio( )
	
	//Mostra a mensagem da promo$$HEX2$$e700e300$$ENDHEX$$o BRINDE
	If Trim(Upper(This.is_brinde_ativo)) = 'S' Then
		dw_1.Object.t_alerta_reserva.Text = 'INFORME O CLIENTE DA PROMO$$HEX2$$c700c300$$ENDHEX$$O BRINDE - COMPRAS ACIMA DE R$ '+ String(This.idc_brinde, "##0.00") + ' GANHA UM BRINDE!'
		dw_1.Object.t_alerta_reserva.Background.Color = 32768
		dw_1.Object.t_alerta_reserva.tooltip.enabled = False
		dw_1.Object.t_alerta_reserva.visible = True
	End If
	
	Return True
	
Else
	dw_2.SetColumn("de_produto")
	Return False
End If
 
end function

public function boolean wf_new_seq_cliente_caixa ();Insert Into cliente_caixa(
	nr_ficha,
	nr_matricula_vendedor,
	id_situacao,
	dh_movimentacao	)
 Values(  0,
			:is_Matricula_Vendedor,
			'X',
			dbo.uf_dh_parametro( ) )
Using SqlCa;
	
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_RollBack()
		SqlCa.of_MsgDbError()
		Close(This)
		
	Case Else
		SELECT max( c.nr_sequencial ),
					u.nm_usuario
		INTO	:il_Sequencial_Cliente_Caixa,
				:is_Nm_Vendedor
		FROM cliente_caixa c
			INNER JOIN usuario u
				ON u.nr_matricula 		= c.nr_matricula_vendedor
		WHERE c.dh_movimentacao 	= dbo.uf_dh_parametro( )
		AND c.nr_matricula_vendedor 	= :is_Matricula_Vendedor
		GROUP BY u.nm_usuario
		USING SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_RollBack()
				SqlCa.of_MsgDbError()
				Close(This)
				
			Case 100
				MessageBox( This.Title, "N$$HEX1$$fa00$$ENDHEX$$mero sequencial da cliente_caixa n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign! )
				Close(This)
				
			Case 0
				SqlCa.of_Commit( )
				Return True
				
//				This.Title = "GE108 - Atendimento ao Cliente ( Atendente: " + is_Nm_Vendedor + " ) Abertura: " + String( now( ), "HH:MM:SS" )
//				This.ib_Conclusao_Atendimento_Pendente = True
		End Choose				
End Choose // Choose Case SqlCa.SqlCode
end function

public function integer wf_alerta_reserva_pendente ();Integer li_Retorno

li_Retorno = io_ge108_reserva_produtos.of_verifica_pendencia( False )

dw_1.Object.t_alerta_reserva.visible = ( li_Retorno > 0 )

Return li_Retorno
end function

public subroutine wf_conclui_desistencia_ped_empurrado ();//Reserva CD

Long ll_Linha , ll_Linhas
Long ll_Pedido, ll_Produto
Long ll_Filial_Transf

dw_2.AcceptText()

ll_Linhas = dw_2.RowCount()

For ll_Linha = 1 To ll_Linhas
	ll_Filial_Transf = dw_2.Object.cd_filial_reserva[ ll_Linha ]
	
	If ll_Filial_Transf = 534 Then
		ll_Pedido	 	= dw_2.Object.nr_pedido_empurrado	[ ll_Linha ]
		ll_Produto 	= dw_2.Object.cd_produto					[ ll_Linha ]
		
		If Not IsNull( ll_Pedido ) And ll_Pedido > 0 Then
			io_ge108_reserva_produtos.of_atualiza_ped_urgente_matriz( ll_Pedido, 'X', ll_Produto, 0)
		End If
	End If
Next
end subroutine

public function boolean wf_calcula_pbm_clamed ();Long ll_row, &
	ll_qtd_orcada, &
	ll_produto_venda, &
	ll_promocao, &
	ll_dif_qtdade, &
	ll_linhas, &
	ll_find_produto, &
	ll_qtd_vendida_vinculo, &
	ll_qtd_acumulado, &
	ll_qtd_vinculo_find, &
	ll_row_promocao, &
	ll_find_atendida, &
	ll_qtd_vinculo_t, &
	ll_find_promocao, &
	ll_vinculo_anterior, &
	ll_linha_nova, &
	ll_row_vinculo, &
	ll_promocao_nao_atendida, &
	ll_vinculo_nao_atendido, &
	ll_seq_melhor_promocao, &
	ll_promocao_anterior, &
	ll_row_atendidas, &
	ll_cod_melhor_promocao, &
	ll_qtd_usada_outro_produto, &
	ll_qtd_vinc, &
	ll_qtd_disp

Long ll_Filial_Reserva	, ll_Filial_Reserva_Anterior
		
String ls_tipo_anterior

Boolean lb_vinculo_T_atendido, &
		lb_incluir, &
		lb_vinculo_atendido, &
		lb_mesmo_promo_vinculo, &
		lb_clube
		
Decimal {2} ldc_desconto_promocao
Decimal {2} ldc_preco_desconto
Decimal {2} ldc_preco_unitario
Decimal {2} ldc_melhor_desconto
Decimal {2} ldc_seq_desconto

dw_2.AcceptText()

lb_clube = True

//Lista das promocoes atendidas
dc_uo_ds_base lvds_promocoes_atendidas
lvds_promocoes_atendidas = Create dc_uo_ds_base		
If Not lvds_promocoes_atendidas.of_ChangeDataObject("ds_ge108_promocoes_produto") Then
	If IsValid(lvds_promocoes_atendidas) Then Destroy(lvds_promocoes_atendidas)
	Return False
End If

//Lista com todas as possiveis promocoes para o produto vendido
dc_uo_ds_Base lvds_promocao
lvds_promocao = Create dc_uo_ds_Base
If Not lvds_promocao.of_ChangeDataObject("ds_ge108_promocoes_produto") Then
	If IsValid(lvds_promocao) 				Then Destroy(lvds_promocao)
	If IsValid(lvds_promocoes_atendidas) Then Destroy(lvds_promocoes_atendidas)
	Return False
End If

//Lista vinculos
dc_uo_ds_base lvds_vinculos
lvds_vinculos = Create dc_uo_ds_base		
If Not lvds_vinculos.of_ChangeDataObject("ds_ge108_promocoes_vinculo") Then
	If IsValid(lvds_vinculos) 					Then Destroy(lvds_vinculos)
	If IsValid(lvds_promocao) 				Then Destroy(lvds_promocao)
	If IsValid(lvds_promocoes_atendidas) Then Destroy(lvds_promocoes_atendidas)
	Return False
End If

//Inicia varredura dos produtos vendidos
For ll_row = 1 TO dw_2.RowCount()	
	lvds_promocoes_atendidas.Reset()
	lvds_promocao.Reset()
	lvds_vinculos.Reset()
	ll_qtd_orcada = 0
	ll_produto_venda = 0
	ll_promocao = 0
	ll_dif_qtdade = 0
	ls_tipo_anterior = ''
	lb_vinculo_T_atendido = False
	
	If IsNull(dw_2.Object.cd_produto[ll_row]) or Trim(String(dw_2.Object.cd_produto[ll_row])) = '' Then
		Continue
	End If	
	
	If dw_2.Object.cd_produto [ll_row] = ivo_produto.cd_produto_manipulado Then Continue //Produto Manipulado n$$HEX1$$e300$$ENDHEX$$o tem promo$$HEX2$$e700e300$$ENDHEX$$o vinculada
	
	If (dw_2.Object.id_usado_promocao_vinculada [ll_row] = "S") and +&
	   (dw_2.Object.qt_usada_promocao_vinculada [ll_row] = dw_2.Object.qt_orcada [ll_row] ) Then Continue //J$$HEX1$$e100$$ENDHEX$$ usado em alguma promocao vinculada
	
	//Lista promo$$HEX2$$e700f500$$ENDHEX$$es validas para o produto
	ll_Linhas = lvds_promocao.Retrieve( dw_2.Object.cd_produto[ll_row] )	
	
	If ll_Linhas > 0 Then
		//AQUI ter$$HEX1$$e100$$ENDHEX$$ que ser feito o WHILE.
		Do 
			If ll_Row > dw_2.RowCount( ) Then Exit
			
			lvds_promocoes_atendidas.Reset()
			lvds_vinculos.Reset()
			//Busca qtdade total vendida do produto que pode ser usada			
			ll_find_produto    = dw_2.Find ("cd_produto = " + STRING( dw_2.Object.cd_produto[ll_row] ) + " and qt_usada_promocao_vinculada < qt_orcada", 1 ,dw_2.RowCount())
			If ll_find_produto > 0 Then
				ll_Filial_Reserva_Anterior = dw_2.Object.cd_filial_reserva [ll_find_produto]
				ll_qtd_orcada = dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
			Else
				If ll_find_produto < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Or$$HEX1$$e700$$ENDHEX$$ada.",StopSign!)
					Return False
				Else
					ll_qtd_orcada = 0
					Continue  //N$$HEX1$$e300$$ENDHEX$$o tem qtdade suficiente
				End If				
			End If
			If (ll_find_produto + 1) <= dw_2.RowCount() Then
				Do While ll_find_produto > 0					
					ll_find_produto    = dw_2.Find ("cd_produto = " + STRING( dw_2.Object.cd_produto[ll_row] ) + " and qt_usada_promocao_vinculada < qt_orcada", ll_find_produto +1,dw_2.RowCount() +1)
													 
					If ll_find_produto > 0 Then
//						ll_Filial_Reserva = dw_2.Object.cd_filial_reserva [ll_find_produto]
//						IF IsNull(ll_Filial_Reserva) Then ll_Filial_Reserva = 0
						
//						If ll_Filial_Reserva_Anterior <> ll_Filial_Reserva Then 
//							ll_qtd_orcada = dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
//						Else
							ll_qtd_orcada += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
//						End If
					Else
						If ll_find_produto < 0 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Orcada.",StopSign!)
							Return False
						End If				
					End If		
				Loop
			End If
			//Fim da busca de qtdade.
			
			//Percorre lista de promo$$HEX2$$e700f500$$ENDHEX$$es
			For ll_row_promocao = 1 TO lvds_promocao.RowCount()
				ll_qtd_vendida_vinculo = 0
				ll_qtd_acumulado		 = 0
				ll_qtd_vinculo_find		 = 0
				//Verifica se for promocao do tipo UNICA e se j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ atendida na venda, n$$HEX1$$e300$$ENDHEX$$o utiliza novamente.
				If lvds_promocao.Object.id_tipo_replicacao[ll_row_promocao] = 'U' Then  //Promocao tipo U n$$HEX1$$e300$$ENDHEX$$o pode se repetir na venda
					ll_find_promocao    = dw_2.Find ("cd_promocao_sos = " + String(lvds_promocao.Object.cd_promocao_sos[ll_row_promocao] ), 1 ,dw_2.RowCount())
					If ll_find_promocao > 0 Then 
						ll_qtd_orcada = 0						
						Continue
					End If
					
					If ll_find_promocao < 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Remo$$HEX2$$e700e300$$ENDHEX$$o vinculos.",StopSign!)
						Return False						
					End If				
				End If			
				
				//######## PARTE NOVA 0 #########
				//Mesmo produto e promocao
				If ((ll_produto_venda = lvds_promocao.Object.cd_produto_venda[ll_row_promocao]) And +& 
					(ll_promocao = lvds_promocao.Object.cd_promocao_sos[ll_row_promocao])) Or (ll_promocao = 0)  Then 				
					//Busca qtdade total vendida do produto vinculo que ainda pode ser usada
					ll_produto_venda 	= lvds_promocao.Object.cd_produto_venda[ll_row_promocao]
					ll_promocao 		= lvds_promocao.Object.cd_promocao_sos[ll_row_promocao]
					ls_tipo_anterior		= lvds_promocao.Object.id_tipo_replicacao[ll_row_promocao]
					ll_vinculo_anterior = lvds_promocao.Object.nr_vinculo[ll_row_promocao]						
					
					If lvds_promocao.Object.id_tipo_replicacao[ll_row_promocao] <> 'T' Then
						If lvds_promocao.Object.cd_produto_venda[ll_row_promocao] <> lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] Then
							ll_find_produto    = dw_2.Find ("cd_produto = " + STRING( lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] ) + &
															 " and qt_usada_promocao_vinculada < qt_orcada", 1 ,dw_2.RowCount())
							If ll_find_produto > 0 Then
								ll_qtd_vendida_vinculo = dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
							Else
								If ll_find_produto = 0 Then
									Continue  //prossegue para proxima linha de promocao, pois essa produto vinculo n$$HEX1$$e300$$ENDHEX$$o tem na venda.
								Else
									MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Or$$HEX1$$e700$$ENDHEX$$ada vinculo.",StopSign!)
									Return False
								End If
							End If		
							Do While ll_find_produto > 0
								ll_find_produto    = dw_2.Find ("cd_produto = " + STRING( lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] ) + " and qt_usada_promocao_vinculada < qt_orcada", ll_find_produto +1, dw_2.RowCount() +1)
								
								If ll_find_produto > 0 Then
									ll_qtd_vendida_vinculo += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
								Else
									If ll_find_produto < 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Or$$HEX1$$e700$$ENDHEX$$ada vinculo2.",StopSign!)
										Return False
									End If									
								End If		
							Loop		
						Else
							ll_qtd_vendida_vinculo = ll_qtd_orcada
							//Produto venda igual a produto vinculo, em tipo de promocao diferente de T, n$$HEX1$$e300$$ENDHEX$$o deve ser considerado no total do vinculo
							ll_qtd_vendida_vinculo -= 1
						End If						
						
						If ll_qtd_vendida_vinculo > 0 Then		//Verifica se vinculo j$$HEX1$$e100$$ENDHEX$$ foi atingido na venda, sen$$HEX1$$e300$$ENDHEX$$o adiciona no atendidas.								
							ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + String (lvds_promocao.Object.cd_promocao_sos[ll_row_promocao]) +&
															" and cd_produto_venda = " + STRING( lvds_promocao.Object.cd_produto_venda[ll_row_promocao] ) + &							
															 " and nr_vinculo = " + String(lvds_promocao.Object.nr_vinculo[ll_row_promocao]), 1 ,lvds_promocoes_atendidas.RowCount())
							If ll_find_atendida > 0 Then
								ll_qtd_acumulado = lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]						
							Else
								If ll_find_atendida = 0 Then
									ll_qtd_acumulado = 0
								Else
									MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido.",StopSign!)
									Return False
								End If
							End If
							Do While ll_find_atendida > 0			
								If ll_find_atendida < lvds_promocoes_atendidas.RowCount() Then								
									ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + String (lvds_promocao.Object.cd_promocao_sos[ll_row_promocao]) +&
																	" and cd_produto_venda = " + STRING( lvds_promocao.Object.cd_produto_venda[ll_row_promocao] ) + &							
																	 " and nr_vinculo = " + String(lvds_promocao.Object.nr_vinculo[ll_row_promocao]), ll_find_atendida+1, lvds_promocoes_atendidas.RowCount())
									If ll_find_atendida > 0 Then
										ll_qtd_acumulado += lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]
									Else
										If ll_find_atendida < 0 Then
											MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido proximo.",StopSign!)
											Return False
										End If									
									End If		
								Else
									Exit
								End If									
							Loop
							
							If ll_qtd_acumulado < lvds_promocao.Object.qt_vinculo[ll_row_promocao] Then					
								ll_linha_nova = lvds_promocoes_atendidas.RowCount()+1
								lvds_promocao.RowsCopy(ll_row_promocao, ll_row_promocao, Primary!, lvds_promocoes_atendidas, lvds_promocoes_atendidas.RowCount()+1, Primary!)
								lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_linha_nova] = ll_qtd_vendida_vinculo													
							Else
								Continue  //Vinculo j$$HEX1$$e100$$ENDHEX$$ foi atingido
								//lb_vinculo_T_atendido = True
							End If
						Else
							ll_qtd_orcada = 0
							Continue  //Linha n$$HEX1$$e300$$ENDHEX$$o vai para o atendida pois o produto vinculo n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ na venda							
						End If
					Else
						//Promo$$HEX2$$e700e300$$ENDHEX$$o Tipo T					
						//Promocao do Tipo T, j$$HEX1$$e100$$ENDHEX$$ atendida anteriormente na venda, pode ser aplicado novamente o desconto
						ll_find_atendida  = dw_2.Find ("cd_promocao_sos = "+ String (lvds_promocao.Object.cd_promocao_sos[ll_row_promocao]) +&
																	" and cd_produto = " + STRING( lvds_promocao.Object.cd_produto_venda[ll_row_promocao] ), 1,dw_2.RowCount())
						If ll_find_atendida > 0 Then
							ll_linha_nova = lvds_promocoes_atendidas.RowCount()+1						
							lvds_promocao.RowsCopy(ll_row_promocao, ll_row_promocao, Primary!, lvds_promocoes_atendidas, lvds_promocoes_atendidas.RowCount()+1, Primary!)
							lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_linha_nova] = lvds_promocao.Object.qt_vinculo[ll_row_promocao]
							//lb_vinculo_T_atendido = True					
							Continue
						Else
							If ll_find_atendida < 0 Then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Exclus$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o atendidas tipo T.",StopSign!)
								Return False
							End If
						End If		
						
						If lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] <> lvds_promocao.Object.cd_produto_venda[ll_row_promocao] Then
							//Se o produto da venda $$HEX1$$e900$$ENDHEX$$ o mesmo do vinculo, n$$HEX1$$e300$$ENDHEX$$o preciso somar as qtdades, isso j$$HEX1$$e100$$ENDHEX$$ foi feito no inicio
							//basta incluir a linha da promo$$HEX2$$e700e300$$ENDHEX$$o nas atendidas.
							ll_find_produto    = dw_2.Find ("cd_produto = " + STRING( lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] ), 1 ,dw_2.RowCount())
							If ll_find_produto > 0 Then
								If dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto] > 0 Then
									//Se produto j$$HEX1$$e100$$ENDHEX$$ foi usado para outro produto da mesma promocao, considera a quantidade vendida
									If dw_2.Object.cd_promocao_sos[ll_find_produto] = lvds_promocao.Object.cd_promocao_sos[ll_row_promocao] Then
										ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto]
										lb_incluir = True
									Else
										If dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto] < dw_2.Object.qt_orcada[ll_find_produto] Then
											ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
											lb_incluir = True
										Else
											lb_incluir = False
										End If								
									End If
								Else								
									ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
									lb_incluir = True
								End If
							Else
								If ll_find_produto < 0 Then
									MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Vendida vinculoT.",StopSign!)
									Return False
								End If
							End If		
							Do While ll_find_produto > 0
								ll_find_produto    = dw_2.Find ("cd_produto = " + STRING( lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] ), ll_find_produto +1, dw_2.RowCount() +1)
								
								If ll_find_produto > 0 Then
									If dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto] > 0 Then
										//Se produto j$$HEX1$$e100$$ENDHEX$$ foi usado para outro produto da mesma promocao, considera a quantidade vendida
										If dw_2.Object.cd_promocao_sos[ll_find_produto] = lvds_promocao.Object.cd_promocao_sos[ll_row_promocao] Then
											ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto]
											lb_incluir = True
										Else
											If dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto] < dw_2.Object.qt_orcada[ll_find_produto] Then
												ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
												lb_incluir = True
											Else
												lb_incluir = False
											End If								
										End If
									Else								
										ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
										lb_incluir = True
									End If							
								Else
									If ll_find_produto < 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Vendida vinculoT2.",StopSign!)
										Return False
									End If									
								End If		
							Loop
						Else
							ll_qtd_vinculo_t = ll_qtd_orcada
							lb_incluir = True
						End If
						
						If lb_incluir Then
							ll_linha_nova = lvds_promocoes_atendidas.RowCount()+1												
							lvds_promocao.RowsCopy(ll_row_promocao, ll_row_promocao, Primary!, lvds_promocoes_atendidas, ll_linha_nova, Primary!)
							lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_linha_nova] = ll_qtd_vinculo_t
							lb_incluir = False
						End If
					End If				
				Else			
					//Mudou a promocao, verifica se todos os vinculos da promocao anterior foram atendidos				
					ll_Linhas = lvds_vinculos.Retrieve( ll_promocao )
	
					If ll_Linhas > 0 Then
						lb_vinculo_atendido = True
						For ll_row_vinculo = 1 TO lvds_Vinculos.RowCount()						
							ll_qtd_acumulado = 0
							ll_qtd_vinculo_find = 0
							If Not lb_vinculo_atendido Then
								Exit
							End If						
							If ll_row_vinculo = lvds_Vinculos.RowCount() Then //Ultima linha, verifica se o ultimo vinculo foi atendido
								ll_promocao_nao_atendida = lvds_Vinculos.Object.cd_promocao_sos[ll_row_vinculo]
								ll_vinculo_nao_atendido = lvds_Vinculos.Object.nr_vinculo[ll_row_vinculo]							
								
								ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + String (ll_promocao) +&
																" and cd_produto_venda = " + STRING( ll_produto_venda ) + &							
																 " and nr_vinculo = " + String(ll_vinculo_nao_atendido), 1 ,lvds_promocoes_atendidas.RowCount())
								If ll_find_atendida > 0 Then
									ll_qtd_acumulado = lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]
									ll_qtd_vinculo_find  = lvds_promocoes_atendidas.Object.qt_vinculo[ll_find_atendida]
								Else
									If ll_find_atendida = 0 Then
										lb_vinculo_atendido = False
										ll_qtd_orcada = 0
										Exit //se um dos vinculos n$$HEX1$$e300$$ENDHEX$$o foi atendido, sai para excluir do grid atendidas
									Else
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido.",StopSign!)
										Return False
									End If
								End If
								Do While ll_find_atendida > 0			
									If ll_find_atendida < lvds_promocoes_atendidas.RowCount() Then								
										ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + String (ll_promocao_nao_atendida) +&
																		 " and cd_produto_venda = " + STRING( ll_produto_venda ) + &															
																		 " and nr_vinculo = " + String(ll_vinculo_nao_atendido),ll_find_atendida+1 ,lvds_promocoes_atendidas.RowCount())
										If ll_find_atendida > 0 Then
											ll_qtd_acumulado += lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]
										Else
											If ll_find_atendida < 0 Then
												MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido proximo.",StopSign!)
												Return False
											End If									
										End If		
									Else
										Exit
									End If									
								Loop
								
								If ll_qtd_acumulado < ll_qtd_vinculo_find Then //Remove vinculo da atendida, pois a quantidade do vinculo n$$HEX1$$e300$$ENDHEX$$o foi atingida
									lb_vinculo_atendido = False
									ll_qtd_orcada = 0
								End If
							Else
								ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + STRING( lvds_Vinculos.Object.cd_promocao_sos[ll_row_vinculo] ) +&
																 " and cd_produto_venda = " + STRING( ll_produto_venda ) + &																						
																 " and nr_vinculo = " + String(lvds_Vinculos.Object.nr_vinculo[ll_row_vinculo]), 1 ,lvds_promocoes_atendidas.RowCount())
																 
								If ll_find_atendida > 0 Then
									ll_qtd_acumulado = lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]
									ll_qtd_vinculo_find  = lvds_promocoes_atendidas.Object.qt_vinculo[ll_find_atendida]
								Else
									If ll_find_atendida = 0 Then
										lb_vinculo_atendido = False
										ll_qtd_orcada = 0
										Exit //se um dos vinculos n$$HEX1$$e300$$ENDHEX$$o foi atendido, sai para excluir do grid atendidas
									Else
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido.",StopSign!)
										Return False
									End If
								End If		
								Do While ll_find_atendida > 0
									If ll_find_atendida < lvds_promocoes_atendidas.RowCount() Then															
										ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + STRING( lvds_Vinculos.Object.cd_promocao_sos[ll_row_vinculo] ) +&
																		 " and cd_produto_venda = " + STRING( ll_produto_venda ) + &																						
																		 " and nr_vinculo = " + String(lvds_Vinculos.Object.nr_vinculo[ll_row_vinculo]), ll_find_atendida+1, lvds_promocoes_atendidas.RowCount())
										If ll_find_atendida > 0 Then
											ll_qtd_acumulado += lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]
										Else
											If ll_find_atendida < 0 Then
												MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido proximo.",StopSign!)
												Return False
											End If									
										End If		
									Else
										Exit
									End If									
								Loop
								
								If ll_qtd_acumulado < ll_qtd_vinculo_find Then //Remove vinculo da atendida, pois a quantidade do vinculo n$$HEX1$$e300$$ENDHEX$$o foi atingida
									lb_vinculo_atendido = False
									ll_qtd_orcada = 0
								End If																						 
							End If
						Next
						
						If Not lb_vinculo_atendido Then //Remove promoca do grid de atendidas
							ll_find_atendida  = lvds_promocoes_atendidas.Find ("cd_promocao_sos = "+ String (ll_promocao) + &
																								" and cd_produto_venda = " + STRING( ll_produto_venda ), 1, lvds_promocoes_atendidas.RowCount())
							If ll_find_atendida > 0 Then
								lvds_promocoes_atendidas.DeleteRow(ll_find_atendida)						
							Else
								If ll_find_atendida < 0 Then
									MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Exclus$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o atendidas.",StopSign!)
									Return False
								End If
							End If
							Do While ll_find_atendida > 0
								ll_find_atendida  = lvds_promocoes_atendidas.Find ("cd_promocao_sos = "+ String (ll_promocao) + &
																									 " and cd_produto_venda = " + STRING( ll_produto_venda ), 1, lvds_promocoes_atendidas.RowCount())
								If ll_find_atendida > 0 Then
									lvds_promocoes_atendidas.DeleteRow(ll_find_atendida)
								Else
									If ll_find_atendida < 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Exclus$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o atendidas.",StopSign!)
										Return False
									End If									
								End If		
							Loop						
						End If							
					End If	
					lvds_vinculos.Reset()
					
					//Prossegue processo para inclus$$HEX1$$e300$$ENDHEX$$o no grid de atendidas				
					ls_tipo_anterior		= lvds_promocao.Object.id_tipo_replicacao[ll_row_promocao]
					ll_produto_venda 	= lvds_promocao.Object.cd_produto_venda[ll_row_promocao]
					ll_promocao 		= lvds_promocao.Object.cd_promocao_sos[ll_row_promocao]	
					ll_vinculo_anterior = lvds_promocao.Object.nr_vinculo[ll_row_promocao]				
					ll_qtd_vinculo_t 	= ll_qtd_orcada
					lb_mesmo_promo_vinculo = False
					lb_vinculo_atendido = True
					
					If lvds_promocao.Object.id_tipo_replicacao[ll_row_promocao] <> 'T' Then
						If lvds_promocao.Object.cd_produto_venda[ll_row_promocao] <> lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] Then
							ll_find_produto    = dw_2.Find ("cd_produto = " + STRING( lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] ) + &
															 " and qt_usada_promocao_vinculada < qt_orcada", 1 ,dw_2.RowCount())
							If ll_find_produto > 0 Then
								ll_qtd_vendida_vinculo += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
							Else
								If ll_find_produto = 0 Then
									Continue  //prossegue para proxima linha de promocao, pois essa produto vinculo n$$HEX1$$e300$$ENDHEX$$o tem na venda.
								Else
									MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Vendida vinculo.",StopSign!)
									Return False
								End If
							End If		
							Do While ll_find_produto > 0
								ll_find_produto    = dw_2.Find ("cd_produto = " + STRING( lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] ) + " and qt_usada_promocao_vinculada < qt_orcada", ll_find_produto +1,dw_2.RowCount() +1)
								
								If ll_find_produto > 0 Then
									ll_qtd_vendida_vinculo += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
								Else
									If ll_find_produto < 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Vendida vinculo2.",StopSign!)
										Return False
									End If									
								End If		
							Loop			
						Else
							ll_qtd_vendida_vinculo = ll_qtd_orcada
							//Produto venda igual a produto vinculo, em tipo de promocao diferente de T, n$$HEX1$$e300$$ENDHEX$$o deve ser considerado no total do vinculo
							ll_qtd_vendida_vinculo -= 1
						End If						
						
						If ll_qtd_vendida_vinculo > 0 Then		//Adiciona linha do produto vinculo no grid de atendidas.
						
							ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + String (lvds_promocao.Object.cd_promocao_sos[ll_row_promocao]) +&
															" and cd_produto_venda = " + STRING( lvds_promocao.Object.cd_produto_venda[ll_row_promocao] ) + &							
															 " and nr_vinculo = " + String(lvds_promocao.Object.nr_vinculo[ll_row_promocao]), 1 ,lvds_promocoes_atendidas.RowCount())
							If ll_find_atendida > 0 Then
								ll_qtd_acumulado = lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]						
							Else
								If ll_find_atendida = 0 Then
									ll_qtd_acumulado = 0
								Else
									MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido.",StopSign!)
									Return False
								End If
							End If
							Do While ll_find_atendida > 0			
								If ll_find_atendida < lvds_promocoes_atendidas.RowCount() Then								
									ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + String (lvds_promocao.Object.cd_promocao_sos[ll_row_promocao]) +&
																	" and cd_produto_venda = " + STRING( lvds_promocao.Object.cd_produto_venda[ll_row_promocao] ) + &							
																	 " and nr_vinculo = " + String(lvds_promocao.Object.nr_vinculo[ll_row_promocao]), ll_find_atendida+1, lvds_promocoes_atendidas.RowCount())
									If ll_find_atendida > 0 Then
										ll_qtd_acumulado += lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]
									Else
										If ll_find_atendida < 0 Then
											MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido proximo.",StopSign!)
											Return False
										End If									
									End If		
								Else
									Exit
								End If									
							Loop
							
							If ll_qtd_acumulado < lvds_promocao.Object.qt_vinculo[ll_row_promocao] Then					
								ll_linha_nova = lvds_promocoes_atendidas.RowCount()+1
								lvds_promocao.RowsCopy(ll_row_promocao, ll_row_promocao, Primary!, lvds_promocoes_atendidas, ll_linha_nova, Primary!)
								lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_linha_nova] = ll_qtd_vendida_vinculo													
							Else
								ll_qtd_orcada = 0														
								Continue  //Vinculo j$$HEX1$$e100$$ENDHEX$$ foi atingido
								//lb_vinculo_T_atendido = True
							End If
						Else
							ll_qtd_orcada = 0
							Continue  //Linha n$$HEX1$$e300$$ENDHEX$$o vai para o atendida pois o produto vinculo n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ na venda							
						End If
					Else
						//Promo$$HEX2$$e700e300$$ENDHEX$$o Tipo T
						ll_qtd_vinculo_t	 = 0
						lb_incluir = False
						//Promocao do Tipo T, j$$HEX1$$e100$$ENDHEX$$ atendida anteriormente na venda, pode ser aplicado novamente o desconto
						ll_find_atendida  = dw_2.Find ("cd_promocao_sos = "+ String (lvds_promocao.Object.cd_promocao_sos[ll_row_promocao]) +&
																	" and cd_produto = " + STRING( lvds_promocao.Object.cd_produto_venda[ll_row_promocao] ), 1,dw_2.RowCount())
						If ll_find_atendida > 0 Then
							ll_linha_nova = lvds_promocoes_atendidas.RowCount()+1						
							lvds_promocao.RowsCopy(ll_row_promocao, ll_row_promocao, Primary!, lvds_promocoes_atendidas, lvds_promocoes_atendidas.RowCount()+1, Primary!)
							lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_linha_nova] = lvds_promocao.Object.qt_vinculo[ll_row_promocao]
							//lb_vinculo_T_atendido = True
							Continue
						Else
							If ll_find_atendida < 0 Then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Exclus$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o atendidas tipo T.",StopSign!)
								Return False
							End If
						End If		
						
						If lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] <> lvds_promocao.Object.cd_produto_venda[ll_row_promocao] Then
							//Se o produto da venda $$HEX1$$e900$$ENDHEX$$ o mesmo do vinculo, n$$HEX1$$e300$$ENDHEX$$o preciso somar as qtdades, isso j$$HEX1$$e100$$ENDHEX$$ foi feito no inicio
							//basta incluir a linha da promo$$HEX2$$e700e300$$ENDHEX$$o nas atendidas.
							ll_find_produto    = dw_2.Find ("cd_produto = " + STRING( lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] ), 1 ,dw_2.RowCount())
							If ll_find_produto > 0 Then
								If dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto] > 0 Then
									//Se produto j$$HEX1$$e100$$ENDHEX$$ foi usado para outro produto da mesma promocao, considera a quantidade vendida
									If dw_2.Object.cd_promocao_sos[ll_find_produto] = lvds_promocao.Object.cd_promocao_sos[ll_row_promocao] Then
										ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto]
										lb_incluir = True
									Else
										If dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto] < dw_2.Object.qt_orcada[ll_find_produto] Then
											ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
											lb_incluir = True
										Else
											lb_incluir = False
										End If								
									End If
								Else								
									ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
									lb_incluir = True
								End If
							Else
								If ll_find_produto < 0 Then
									MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Vendida vinculoT.",StopSign!)
									Return False
								End If
							End If		
							Do While ll_find_produto > 0
								ll_find_produto    = dw_2.Find ("cd_produto = " + STRING( lvds_promocao.Object.cd_produto_vinculo[ll_row_promocao] ), ll_find_produto +1,dw_2.RowCount() +1)
								
								If ll_find_produto > 0 Then
									If dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto] > 0 Then
										//Se produto j$$HEX1$$e100$$ENDHEX$$ foi usado para outro produto da mesma promocao, considera a quantidade vendida
										If dw_2.Object.cd_promocao_sos[ll_find_produto] = lvds_promocao.Object.cd_promocao_sos[ll_row_promocao] Then
											ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto]
											lb_incluir = True
										Else
											If dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto] < dw_2.Object.qt_orcada[ll_find_produto] Then
												ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
												lb_incluir = True
											Else
												lb_incluir = False
											End If								
										End If
									Else								
										ll_qtd_vinculo_t  += dw_2.Object.qt_orcada[ll_find_produto] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_produto]
										lb_incluir = True
									End If							
								Else
									If ll_find_produto < 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Vendida vinculoT2.",StopSign!)
										Return False
									End If									
								End If		
							Loop
						Else
							ll_qtd_vinculo_t = ll_qtd_orcada
							lb_incluir = True
						End If
						
						If lb_incluir Then
							ll_linha_nova = lvds_promocoes_atendidas.RowCount()+1												
							lvds_promocao.RowsCopy(ll_row_promocao, ll_row_promocao, Primary!, lvds_promocoes_atendidas, lvds_promocoes_atendidas.RowCount()+1, Primary!)
							lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_linha_nova] = ll_qtd_vinculo_t
							lb_incluir = False
						End If					
					End If	
				End If
				//###### FIM PARTE NOVA 0 #########
			Next		
			//FIM 	Percorre lista de promo$$HEX2$$e700f500$$ENDHEX$$es
			
			//Verifica se a ultima promocao inclusa no grid foi atendida, se n$$HEX1$$e300$$ENDHEX$$o foi, exclui do grid.
			ll_Linhas = lvds_vinculos.Retrieve( ll_promocao )
			lb_vinculo_atendido = True
			
			If ll_Linhas > 0 Then
				For ll_row_vinculo = 1 TO lvds_Vinculos.RowCount()
					ll_qtd_acumulado = 0
					ll_qtd_vinculo_find = 0
					If Not lb_vinculo_atendido Then
						Exit
					End If
					If ll_row_vinculo = lvds_Vinculos.RowCount() Then //Ultima linha, verifica se o ultimo vinculo foi atendido
						ll_promocao_nao_atendida = lvds_Vinculos.Object.cd_promocao_sos[ll_row_vinculo]
						ll_vinculo_nao_atendido = lvds_Vinculos.Object.nr_vinculo[ll_row_vinculo]							
						
						If ll_qtd_orcada = 0 Then
							lb_vinculo_atendido = False
							Exit //se chegou aqui com qtd or$$HEX1$$e700$$ENDHEX$$ada zerada, indica que a quantidade or$$HEX1$$e700$$ENDHEX$$ada n$$HEX1$$e300$$ENDHEX$$o atende ao vinculo.
						End If							
						
						ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + String (ll_promocao_nao_atendida) +&
														" and cd_produto_venda = " + STRING( ll_produto_venda ) + &							
														 " and nr_vinculo = " + String(ll_vinculo_nao_atendido), 1 ,lvds_promocoes_atendidas.RowCount())
						If ll_find_atendida > 0 Then
							ll_qtd_acumulado = lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]
							ll_qtd_vinculo_find  = lvds_promocoes_atendidas.Object.qt_vinculo[ll_find_atendida]
						Else
							If ll_find_atendida = 0 Then
								lb_vinculo_atendido = False
								ll_qtd_orcada = 0
								Exit //se um dos vinculos n$$HEX1$$e300$$ENDHEX$$o foi atendido, sai para excluir do grid atendidas
							Else
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido.",StopSign!)
								Return False
							End If
						End If		
						Do While ll_find_atendida > 0			
							If ll_find_atendida < lvds_promocoes_atendidas.RowCount() Then						
								ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + String (ll_promocao_nao_atendida) +&
																 " and cd_produto_venda = " + STRING( ll_produto_venda ) + &															
																 " and nr_vinculo = " + String(ll_vinculo_nao_atendido),ll_find_atendida+1 ,lvds_promocoes_atendidas.RowCount())
								If ll_find_atendida > 0 Then
									ll_qtd_acumulado += lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]
								Else
									If ll_find_atendida < 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido proximo.",StopSign!)
										Return False
									End If									
								End If		
							Else
								Exit //ultima linha do grid atendidas
							End If
						Loop
						
						If ll_qtd_acumulado < ll_qtd_vinculo_find Then //Remove vinculo da atendida, pois a quantidade do vinculo n$$HEX1$$e300$$ENDHEX$$o foi atingida
							lb_vinculo_atendido = False
							ll_qtd_orcada = 0
						End If
					Else
						ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + STRING( lvds_Vinculos.Object.cd_promocao_sos[ll_row_vinculo] ) +&
														 " and cd_produto_venda = " + STRING( ll_produto_venda ) + &																						
														 " and nr_vinculo = " + String(lvds_Vinculos.Object.nr_vinculo[ll_row_vinculo]), 1 ,lvds_promocoes_atendidas.RowCount())
														 
						If ll_find_atendida > 0 Then
							ll_qtd_acumulado = lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]
							ll_qtd_vinculo_find  = lvds_promocoes_atendidas.Object.qt_vinculo[ll_find_atendida]
						Else
							If ll_find_atendida = 0 Then
								lb_vinculo_atendido = False
								ll_qtd_orcada = 0
								Exit //se um dos vinculos n$$HEX1$$e300$$ENDHEX$$o foi atendido, sai para excluir do grid atendidas
							Else
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido.",StopSign!)
								Return False
							End If
						End If
						Do While ll_find_atendida > 0					
							If ll_find_atendida < lvds_promocoes_atendidas.RowCount() Then
								ll_find_atendida    = lvds_promocoes_atendidas.Find ("cd_promocao_sos = " + STRING( lvds_Vinculos.Object.cd_promocao_sos[ll_row_vinculo] ) +&
																 " and cd_produto_venda = " + STRING( ll_produto_venda ) + &																						
																 " and nr_vinculo = " + String(lvds_Vinculos.Object.nr_vinculo[ll_row_vinculo]), ll_find_atendida+1, lvds_promocoes_atendidas.RowCount())
								If ll_find_atendida > 0 Then
									ll_qtd_acumulado += lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_find_atendida]
								Else
									If ll_find_atendida < 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Vinculo atendido proximo.",StopSign!)
										Return False
									End If									
								End If
							Else
								Exit
							End If
						Loop
						
						If ll_qtd_acumulado < ll_qtd_vinculo_find Then //Remove vinculo da atendida, pois a quantidade do vinculo n$$HEX1$$e300$$ENDHEX$$o foi atingida
							lb_vinculo_atendido = False
							ll_qtd_orcada = 0							
						End If																						 
					End If
				Next
				
				If Not lb_vinculo_atendido Then //Remove promoca do grid de atendidas
					ll_find_atendida  = lvds_promocoes_atendidas.Find ("cd_promocao_sos = "+ String (ll_promocao) + &
																						" and cd_produto_venda = " + STRING( ll_produto_venda ), 1, lvds_promocoes_atendidas.RowCount())
					If ll_find_atendida > 0 Then
						lvds_promocoes_atendidas.DeleteRow(ll_find_atendida)						
					Else
						If ll_find_atendida < 0 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Exclus$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o atendidas.",StopSign!)
							Return False
						End If
					End If
					Do While ll_find_atendida > 0
						ll_find_atendida  = lvds_promocoes_atendidas.Find ("cd_promocao_sos = "+ String (ll_promocao) + &
																							 " and cd_produto_venda = " + STRING( ll_produto_venda ), 1, lvds_promocoes_atendidas.RowCount())
						If ll_find_atendida > 0 Then
							lvds_promocoes_atendidas.DeleteRow(ll_find_atendida)
						Else
							If ll_find_atendida < 0 Then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Exclus$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o atendidas.",StopSign!)
								Return False
							End If									
						End If		
					Loop									
				End If							
			End If
			
			//Marca no grid de atendidas o melhor desconto
			If lvds_promocoes_atendidas.RowCount() >= 1 Then				
				ldc_preco_unitario = dw_2.Object.vl_preco_unitario [ll_row]
				ll_seq_melhor_promocao = 0
				ldc_melhor_desconto = 0
				ll_promocao_anterior = 0
				ll_vinculo_anterior = 0
				For ll_row_atendidas = 1 TO lvds_promocoes_atendidas.RowCount()
					If lb_clube Then
						If lvds_promocoes_atendidas.Object.pc_desconto_clube[ll_row_atendidas] < lvds_promocoes_atendidas.Object.pc_desconto[ll_row_atendidas] Then			
							ldc_desconto_promocao = lvds_promocoes_atendidas.Object.pc_desconto[ll_row_atendidas]
						Else
							ldc_desconto_promocao = lvds_promocoes_atendidas.Object.pc_desconto_clube[ll_row_atendidas]
						End If
					Else
						ldc_desconto_promocao = lvds_promocoes_atendidas.Object.pc_desconto[ll_row_atendidas]
					End If							
				
					ldc_preco_desconto   = round(ldc_preco_unitario * ((100 - ldc_desconto_promocao) / 100),2)
					//If lvds_promocoes_atendidas.Object.id_tipo_replicacao[ll_row_atendidas] <> 'T' Then //Comentado porque estava baixando o desconto no produto PBM clamed - 02/07/2019
						If ldc_preco_desconto >= dw_2.Object.vl_preco_final[ll_row] Then 
							ll_qtd_orcada = 0
							Continue  //Desconto atual melhor que o da promo$$HEX2$$e700e300$$ENDHEX$$o
						End If
					//End If
					
					ldc_seq_desconto = round(( ldc_preco_unitario -  (ldc_preco_unitario * ((100 - ldc_desconto_promocao) / 100)) ),2)					
					
					If ll_seq_melhor_promocao = 0 Then						
						ll_seq_melhor_promocao = ll_row_atendidas
						lvds_promocoes_atendidas.Object.id_utilizar[ll_row_atendidas] = 'S'
						ldc_melhor_desconto = ldc_seq_desconto
						ll_promocao_anterior = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas] 
						ll_cod_melhor_promocao = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas]
						ll_vinculo_anterior = lvds_promocoes_atendidas.Object.nr_vinculo[ll_row_atendidas]
					Else
						If (lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas] = ll_promocao_anterior) Then 
							ll_promocao_anterior = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas] 												
							lvds_promocoes_atendidas.Object.id_utilizar[ll_row_atendidas] = 'S'
							Continue
						Else					
							If ldc_seq_desconto > ldc_melhor_desconto Then
								lvds_promocoes_atendidas.Object.id_utilizar[ll_seq_melhor_promocao] = 'N'
														
								ll_find_promocao  = lvds_promocoes_atendidas.Find ("cd_promocao_sos = "+ String (ll_promocao_anterior) +&
																									" and nr_vinculo > " + String(ll_vinculo_anterior), 1 ,lvds_promocoes_atendidas.RowCount())				
								Do While ll_find_promocao > 0			
									lvds_promocoes_atendidas.Object.id_utilizar[ll_find_promocao] = 'N'
									
									ll_find_promocao  = lvds_promocoes_atendidas.Find ("cd_promocao_sos = "+ String (ll_promocao_anterior) +&
																										" and nr_vinculo > " + String(ll_vinculo_anterior), ll_find_promocao + 1,lvds_promocoes_atendidas.RowCount())				
																	 
								Loop
								
								ll_seq_melhor_promocao = ll_row_atendidas
								lvds_promocoes_atendidas.Object.id_utilizar[ll_row_atendidas] = 'S'
								ldc_melhor_desconto = ldc_seq_desconto
								ll_promocao_anterior = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas] 
								ll_cod_melhor_promocao = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas]
								ll_vinculo_anterior = lvds_promocoes_atendidas.Object.nr_vinculo[ll_row_atendidas]
							Else
								lvds_promocoes_atendidas.Object.id_utilizar[ll_row_atendidas] = 'N'
							End If										
						End If
					End If			
				Next
				//FIM da escolha de melhor desconto		
				
				//Vai aplicar o desconto e atualizar itens envolvidos.					
				ll_row_atendidas = 0
				ll_promocao = 0
				ll_vinculo_anterior = 0
				ll_promocao_anterior = 0
				ll_qtd_usada_outro_produto = 0
				
				For ll_row_atendidas = 1 TO lvds_promocoes_atendidas.RowCount()	
					If lvds_promocoes_atendidas.Object.id_utilizar[ll_row_atendidas] <> 'S' Then Continue			
	
					If lb_clube Then
						If lvds_promocoes_atendidas.Object.pc_desconto_clube[ll_row_atendidas] < lvds_promocoes_atendidas.Object.pc_desconto[ll_row_atendidas] Then			
							ldc_desconto_promocao = lvds_promocoes_atendidas.Object.pc_desconto[ll_row_atendidas]
						Else
							ldc_desconto_promocao = lvds_promocoes_atendidas.Object.pc_desconto_clube[ll_row_atendidas]
						End If
					Else
						ldc_desconto_promocao = lvds_promocoes_atendidas.Object.pc_desconto[ll_row_atendidas]					
					End If
					
					If lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas] <> ll_promocao_anterior Then //Mudou a promocao, o primeiro vinculo $$HEX1$$e900$$ENDHEX$$ onde o produto da venda $$HEX1$$e900$$ENDHEX$$ atualizado
					//If lvds_promocoes_atendidas.Object.nr_vinculo[ll_row_atendidas] = 1 Then //Quando o nr_vinculo for 1 $$HEX1$$e900$$ENDHEX$$ onde os produtos da venda devem ser atualizados
						ll_qtd_usada_outro_produto = 0
						ll_promocao_anterior = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas]																						
						If lvds_promocoes_atendidas.Object.id_tipo_replicacao[ll_row_atendidas] = 'T' Then //Tipo T aplica no produto venda e vinculo n$$HEX1$$e300$$ENDHEX$$o atualiza como usado.						
							If lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas] <> ll_promocao Then							
								If Not wf_aplica_desconto_pbm_clamed(ll_row, ldc_desconto_promocao, lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas], +&
																							 False, lvds_promocoes_atendidas.Object.cd_produto_venda[ll_row_atendidas], +&
																							 lvds_promocoes_atendidas.Object.cd_produto_vinculo[ll_row_atendidas], +&
																							 ldc_preco_unitario, '', lvds_promocoes_atendidas.Object.id_tipo_replicacao[ll_row_atendidas], +&
																							 False, lvds_promocoes_atendidas.Object.qt_vinculo[ll_row_atendidas], 0) Then Return False
																							 
								ll_promocao = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas]
								Exit
							Else
								If lvds_promocoes_atendidas.Object.cd_produto_vinculo[ll_row_atendidas] = lvds_promocoes_atendidas.Object.cd_produto_venda[ll_row_atendidas] Then
									//Quando produto venda e vinculo s$$HEX1$$e300$$ENDHEX$$o os mesmos, j$$HEX1$$e100$$ENDHEX$$ foi processado na primeira passada da promocao
									ll_promocao = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas]
									Continue
								Else
									//Produto vinculo, s$$HEX1$$f300$$ENDHEX$$ marca como usado em algum vinculo
									If Not wf_aplica_desconto_pbm_clamed(ll_row, ldc_desconto_promocao, lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas], +&
																								 True, lvds_promocoes_atendidas.Object.cd_produto_venda[ll_row_atendidas], +&
																								 lvds_promocoes_atendidas.Object.cd_produto_vinculo[ll_row_atendidas], +&
																								 ldc_preco_unitario, '', lvds_promocoes_atendidas.Object.id_tipo_replicacao[ll_row_atendidas], +&
																								 False, lvds_promocoes_atendidas.Object.qt_vinculo[ll_row_atendidas], 0) Then Return False								
									ll_promocao = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas]
									Continue
								End If							
							End If
						Else
							//Se o tipo de replica$$HEX2$$e700e300$$ENDHEX$$o for diferente de T, a quantidade a aplicar o desconto sempre ser$$HEX1$$e100$$ENDHEX$$ 1.
							If lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas] <> ll_promocao Then
								ll_promocao = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas]														
								If dw_2.Object.qt_orcada[ll_row] = 1 Then
									//Quantidade iguais, cancelar linha do grid e incluir novamente com o desconto							
									If Not wf_aplica_desconto_pbm_clamed(ll_row, ldc_desconto_promocao, lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas], +&
																								 False, lvds_promocoes_atendidas.Object.cd_produto_venda[ll_row_atendidas], +&
																								 lvds_promocoes_atendidas.Object.cd_produto_vinculo[ll_row_atendidas], +&
																								 ldc_preco_unitario, 'V', lvds_promocoes_atendidas.Object.id_tipo_replicacao[ll_row_atendidas], +&
																								 True, lvds_promocoes_atendidas.Object.qt_vinculo[ll_row_atendidas], 1) Then Return False					
								Else
									If dw_2.Object.qt_orcada[ll_row] > 1 Then
									//Cancelar linha da venda, incluir novamente com a qtdade do vinculo(1) aplicando desconto e
									//incluir nova linha no grid do produto sem o desconto da promo$$HEX2$$e700e300$$ENDHEX$$o com a qtdade da diferen$$HEX1$$e700$$ENDHEX$$a
										ll_dif_qtdade = dw_2.Object.qt_orcada[ll_row] - 1
										
	//									//Produto sem o desconto
										If Not wf_aplica_desconto_pbm_clamed(ll_row, 0.000, 0, False, lvds_promocoes_atendidas.Object.cd_produto_venda[ll_row_atendidas], +&
																									 lvds_promocoes_atendidas.Object.cd_produto_vinculo[ll_row_atendidas], +&
																									 ldc_preco_unitario, 'N', '', True, 0, ll_dif_qtdade) Then Return False
										
	//									//Inclui produto com desconto da promocao	
										If Not wf_aplica_desconto_pbm_clamed(ll_row, ldc_desconto_promocao, lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas], +&
																									 False, lvds_promocoes_atendidas.Object.cd_produto_venda[ll_row_atendidas], +&
																									 lvds_promocoes_atendidas.Object.cd_produto_vinculo[ll_row_atendidas], +&
																									 ldc_preco_unitario, 'V', lvds_promocoes_atendidas.Object.id_tipo_replicacao[ll_row_atendidas], +&
																									 False, lvds_promocoes_atendidas.Object.qt_vinculo[ll_row_atendidas], 1) Then Return False																								 
									End If						
								End If	
								
								If lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_row_atendidas] < lvds_promocoes_atendidas.Object.qt_vinculo[ll_row_atendidas] Then
									ll_qtd_usada_outro_produto = lvds_promocoes_atendidas.Object.qt_vinculo[ll_row_atendidas] - lvds_promocoes_atendidas.Object.qt_atendida_vinculo[ll_row_atendidas]
								Else
									ll_qtd_usada_outro_produto = 0
								End If							
							Else
								ll_promocao = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas]														
								//apenas altera a informa$$HEX2$$e700e300$$ENDHEX$$o de uso da promo$$HEX2$$e700e300$$ENDHEX$$o nos produtos vinculos.
								ll_qtd_vinc = lvds_promocoes_atendidas.Object.qt_vinculo[ll_row_atendidas]
								ll_find_promocao = 0
								Do while ll_qtd_vinc > 0
									ll_find_promocao  = dw_2.Find ("cd_produto = " + STRING( lvds_promocoes_atendidas.Object.cd_produto_vinculo[ll_row_atendidas] ) + &
																				 " and qt_usada_promocao_vinculada < qt_orcada", ll_find_promocao + 1 ,dw_2.RowCount())			
									If ll_find_promocao < 0 Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Remo$$HEX2$$e700e300$$ENDHEX$$o vinculos.",StopSign!)
										Return False						
									ElseIf 	ll_find_promocao > 0 Then
										ll_qtd_disp = dw_2.Object.qt_orcada[ll_find_promocao] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_promocao]								
										If ll_qtd_disp >= ll_qtd_vinc Then
											dw_2.Object.id_usado_promocao_vinculada [ll_find_promocao] = 'S'
											dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] = dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] + ll_qtd_vinc
											ll_qtd_vinc = 0
										Else
											dw_2.Object.id_usado_promocao_vinculada [ll_find_promocao] = 'S'									
											dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] = dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] + ll_qtd_disp
											ll_qtd_vinc = ll_qtd_vinc - ll_qtd_disp 
										End If
									ElseIf ll_find_promocao = 0 Then
										ll_qtd_vinc = 0
									End If
								Loop							
								
							End If
						End If
					Else //Quando possui mais de um vinculo, apenas altera a informa$$HEX2$$e700e300$$ENDHEX$$o de uso da promo$$HEX2$$e700e300$$ENDHEX$$o nos produtos vinculos.
						ll_promocao_anterior = lvds_promocoes_atendidas.Object.cd_promocao_sos[ll_row_atendidas]																							
						If ll_qtd_usada_outro_produto > 0 Then 
							ll_qtd_vinc = ll_qtd_usada_outro_produto
						Else
							ll_qtd_vinc = lvds_promocoes_atendidas.Object.qt_vinculo[ll_row_atendidas]
						End If
						ll_find_promocao = 0
						Do while ll_qtd_vinc > 0
							ll_find_promocao  = dw_2.Find ("cd_produto = " + STRING( lvds_promocoes_atendidas.Object.cd_produto_vinculo[ll_row_atendidas] ) + &
																		 " and qt_usada_promocao_vinculada < qt_orcada", ll_find_promocao + 1 ,dw_2.RowCount())			
							If ll_find_promocao < 0 Then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Remo$$HEX2$$e700e300$$ENDHEX$$o vinculos.",StopSign!)
								Return False						
							ElseIf 	ll_find_promocao > 0 Then
								ll_qtd_disp = dw_2.Object.qt_orcada[ll_find_promocao] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_promocao]								
								If ll_qtd_disp >= ll_qtd_vinc Then
									dw_2.Object.id_usado_promocao_vinculada [ll_find_promocao] = 'S'
									dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] = dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] + ll_qtd_vinc
									ll_qtd_vinc = 0
								Else
									dw_2.Object.id_usado_promocao_vinculada [ll_find_promocao] = 'S'									
									dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] = dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] + ll_qtd_disp
									ll_qtd_vinc = ll_qtd_vinc - ll_qtd_disp 
								End If						
							ElseIf ll_find_promocao = 0 Then
								ll_qtd_vinc = 0
								ll_qtd_usada_outro_produto = 0
							End If
						Loop					
						
					End If						
				Next
			End If		
		Loop While ll_qtd_orcada > 0
	End If
Next


If IsValid(lvds_promocao) 				Then Destroy(lvds_promocao)
If IsValid(lvds_promocoes_atendidas) Then Destroy(lvds_promocoes_atendidas)
If IsValid(lvds_vinculos) 					Then Destroy(lvds_vinculos)

////Verificar se cliente foi informado.
If IsNull( ivo_Cliente.Cd_Cliente ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente n$$HEX1$$e300$$ENDHEX$$o informado.~r~rBenef$$HEX1$$ed00$$ENDHEX$$cio exclusivo para Cliente Clube " + Gvo_Parametro.id_rede_filial + ".", Exclamation!)
	dw_1.Event ue_Pos( 1, "localizacao" )
	Return False
End If

Return True
end function

protected function boolean wf_aplica_desconto_pbm_clamed (long pl_row, decimal pdc_desconto, long pl_promocao, boolean pb_somente_vinculo, long pl_produto_venda, long pl_produto_vinculo, decimal pdc_preco_unitario, string ps_tipo_inclusao, string ps_tipo_replicacao, boolean pb_altera_item, long pl_qtd_vinculo, long pl_qtdade);Long ll_row_inclusao
Long ll_status
Long ll_qtd_vinc
Long ll_find_promocao
Long ll_find_produto
Long ll_qtd_disp
Long ll_qtd_t

Decimal {2} ldc_preco_desconto
Decimal {2} ldc_preco_unitario

String ls_Condicao_Find

Boolean lb_qtdade_alterada 					= False
Boolean lb_Mesmo_Produto_Com_Reserva 	= False

dw_2.AcceptText( )

TRY
	If Not ib_Venda_pbm_clamed Then
		ib_Venda_pbm_clamed = True
	End If
	
	//Verifica se j$$HEX1$$e100$$ENDHEX$$ tem linha do produto com o desconto
	ll_find_promocao = 0		
		
	ls_Condicao_Find = "cd_produto = " + STRING( pl_produto_venda ) + " and id_usado_promocao_vinculada = 'S' and cd_promocao_sos = " + String(pl_promocao) 
		
	If dw_2.Find("cd_produto = " + STRING( pl_produto_venda ) + " and Not IsNull(cd_filial_reserva)", 1, dw_2.RowCount()) > 0 Then
		ls_Condicao_Find += " and pc_desconto_fixo <> " + gf_valor_com_ponto(pdc_desconto)
		//Se Possuir reserva de filial e tipo ps_tipo_replicacao <> 'T' o desconto ser$$HEX1$$e100$$ENDHEX$$ no item e nao ser$$HEX1$$e100$$ENDHEX$$ adicionada uma nova linha
		If ps_tipo_replicacao <> 'T' Then lb_Mesmo_Produto_Com_Reserva = True
	End If		
	
	ll_find_promocao  = dw_2.Find (ls_Condicao_Find, ll_find_promocao + 1 ,dw_2.RowCount())		
	
	If ll_find_promocao < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Altera$$HEX2$$e700e300$$ENDHEX$$o Quantidade.",StopSign!)
		Return False		
	End If
		
	Choose Case ps_tipo_replicacao
		CASE 'T'  //TIPO TODOS
	
			//Altera percentual de desconto no produto da promocao
			If Not pb_somente_vinculo Then	
				ll_find_produto = -1
		
				If 	ll_find_promocao > 0 Then
					ll_qtd_t = dw_2.Object.qt_orcada[pl_row]
					dw_2.Object.qt_orcada 							[ll_find_promocao] = dw_2.Object.qt_orcada							[ll_find_promocao] + ll_qtd_t
					dw_2.Object.qt_usada_promocao_vinculada[ll_find_promocao] = dw_2.Object.qt_usada_promocao_vinculada[ll_find_promocao] + ll_qtd_t
					dw_2.Object.cd_promocao_sos					[ll_find_promocao] = pl_promocao
		
					lb_qtdade_alterada = True
				End If
				
				If Not lb_qtdade_alterada Then
					//Aplica do desconto no produto da promocao
					Do while ll_find_produto <> 0
						ll_find_produto  = dw_2.Find ("cd_produto = " + STRING( pl_produto_venda ) + &
																	 " and qt_usada_promocao_vinculada < qt_orcada", ll_find_produto + 1 ,dw_2.RowCount())			
						If ll_find_produto < 0 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Altera$$HEX2$$e700e300$$ENDHEX$$o Itens tipo T.",StopSign!)
							Return False						
						ElseIf 	ll_find_produto > 0 Then			
							ldc_preco_unitario = dw_2.Object.vl_preco_unitario[ll_find_produto]
							ldc_preco_desconto   = round(ldc_preco_unitario * ((100 - pdc_desconto) / 100),2)
							If ldc_preco_desconto <= 0 Then
								ldc_preco_desconto = 0.01
							End If
												
							dw_2.Object.pc_desconto_fixo	 						[ll_find_produto]	= pdc_desconto
							dw_2.Object.cd_promocao_sos 						[ll_find_produto]	= pl_promocao
							dw_2.Object.id_usado_promocao_vinculada 		[ll_find_produto]	= 'S'
							dw_2.Object.qt_usada_promocao_vinculada 		[ll_find_produto]	= dw_2.Object.qt_orcada	[ll_find_produto]
							dw_2.Object.id_tipo_pbm_clamed						[ll_find_produto]	= ps_tipo_replicacao
		
							If dw_2.RowCount() >= ll_find_produto Then
								Exit
							End If
						End If
					Loop
				Else
					If ll_find_promocao <> pl_row Then
						//exclui linha
						dw_2.DeleteRow(pl_row)
					End If
				End If		
		
				//Altera infroma$$HEX2$$e700e300$$ENDHEX$$o no produto vinculo
				If pl_produto_venda <> pl_produto_vinculo Then
					ll_find_promocao = 0			
					ll_find_promocao  = dw_2.Find ("cd_produto = " + STRING( pl_produto_vinculo ) + &
																 " and id_usado_promocao_vinculada <> 'S'" + &
																 " and qt_usada_promocao_vinculada < qt_orcada", ll_find_promocao + 1 ,dw_2.RowCount())			
					If ll_find_promocao < 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Remo$$HEX2$$e700e300$$ENDHEX$$o vinculos.",StopSign!)
						Return False						
					ElseIf 	ll_find_promocao > 0 Then
						dw_2.Object.id_usado_promocao_vinculada [ll_find_promocao] = 'S'
					End If		
				End If
			Else
		//		//Processa somente vinculo
				ll_find_promocao  = dw_2.Find ("cd_produto = " + STRING( pl_produto_vinculo ) + &
															 " and id_usado_promocao_vinculada <> 'S'" + &
															 " and qt_usada_promocao_vinculada < qt_orcada", ll_find_promocao + 1 ,dw_2.RowCount())			
				If ll_find_promocao < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Remo$$HEX2$$e700e300$$ENDHEX$$o vinculos.",StopSign!)
					Return False						
				ElseIf 	ll_find_promocao > 0 Then
					dw_2.Object.id_usado_promocao_vinculada	[ll_find_promocao] = 'S'
				End If			
			End If	
		
		CASE ELSE //PROMOCAO DO TIPO MULTIPLA, ETC...
		
			lb_qtdade_alterada = False
			//Altera quantidade do produto j$$HEX1$$e100$$ENDHEX$$ existente no grid
			If pb_altera_item Then
				If pl_produto_venda = pl_produto_vinculo And Not lb_Mesmo_Produto_Com_Reserva Then
					//Alterar a quantidade do item
					dw_2.Object.qt_orcada 									[pl_row] = pl_qtdade
				Else
					//Aplica desconto no produto da promocao
					//Verifica se j$$HEX1$$e100$$ENDHEX$$ tem linha do produto como desconto e altera quantidade
					If ll_find_promocao > 0 Then
						dw_2.Object.qt_orcada 								[ll_find_promocao] = dw_2.Object.qt_orcada							[ll_find_promocao] + pl_qtdade
						dw_2.Object.qt_usada_promocao_vinculada 	[ll_find_promocao] = dw_2.Object.qt_usada_promocao_vinculada[ll_find_promocao] + pl_qtdade			
						dw_2.Object.cd_promocao_sos						[ll_find_promocao] = pl_promocao
						lb_qtdade_alterada = True
					End If
					
					If Not lb_qtdade_alterada Then
						//Aplica do desconto no produto da promocao
						If pdc_desconto > 0 Then
							dw_2.Object.pc_desconto_fixo 						[pl_row] = pdc_desconto
							dw_2.Object.cd_promocao_sos						[pl_row] = pl_promocao
						End If
						dw_2.Object.id_usado_promocao_vinculada 	[pl_row] = 'S'
						dw_2.Object.qt_usada_promocao_vinculada 	[pl_row] = pl_qtdade
						If dw_2.Object.cd_produto[pl_row] = pl_produto_venda And pdc_desconto = 0 Then
							If (dw_2.Object.qt_orcada[pl_row] - pl_qtdade) <= 0 Then
								dw_2.DeleteRow(pl_row)
							Else
								dw_2.Object.qt_orcada[pl_row] = pl_qtdade
								dw_2.Object.id_usado_promocao_vinculada	[pl_row] = 'N'
								dw_2.Object.qt_usada_promocao_vinculada[pl_row] = 0						
							End If
						End If
					Else
						If pl_qtdade = dw_2.Object.qt_orcada[pl_row] Then
							//exclui linha
							dw_2.DeleteRow(pl_row)
						Else
							dw_2.Object.qt_orcada[pl_row] = dw_2.Object.qt_orcada[pl_row] - pl_qtdade
						End If
					End If
				End If		
			Else
				//Verifica se se j$$HEX1$$e100$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o tem o produto com o desconto aplicado, para alterar somente as quantidades
				ll_find_promocao = 0			
				ll_find_promocao  = dw_2.Find ("cd_produto = " + STRING( pl_produto_venda ) + &
															 " and id_usado_promocao_vinculada = 'S'" + &
															 " and qt_usada_promocao_vinculada = qt_orcada" + &
															 " and cd_promocao_sos = " + String(pl_promocao) , ll_find_promocao + 1 ,dw_2.RowCount())			
				If ll_find_promocao < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Altera$$HEX2$$e700e300$$ENDHEX$$o Quantidade.",StopSign!)
					Return False						
				ElseIf 	ll_find_promocao > 0 Then
					dw_2.Object.qt_orcada 								[ll_find_promocao] = dw_2.Object.qt_orcada							[ll_find_promocao] + pl_qtdade
					dw_2.Object.qt_usada_promocao_vinculada 	[ll_find_promocao] = dw_2.Object.qt_usada_promocao_vinculada[ll_find_promocao] + pl_qtdade			
					dw_2.Object.cd_promocao_sos						[ll_find_promocao] = pl_promocao
					lb_qtdade_alterada = True
				End If
				
				If Not lb_qtdade_alterada Then
					//Aqui $$HEX1$$e900$$ENDHEX$$ incluso a nova linha com o produto
					ll_row_inclusao = dw_2.RowCount()
					If Not IsNull(dw_2.Object.cd_produto[ll_row_inclusao]) Then
						ll_row_inclusao += 1 		
						Event ue_AddRow(dw_2)
						dw_2.SetRow(dw_2.RowCount())
						dw_2.ScrollToRow(dw_2.RowCount())
						dw_2.SetColumn("de_produto")	
					End If
					
					dw_2.Object.cd_produto 								[ll_row_inclusao] = dw_2.Object.cd_produto 								[pl_row]
					dw_2.Object.de_produto 								[ll_row_inclusao] = dw_2.Object.de_produto 								[pl_row]
					dw_2.Object.qt_orcada 									[ll_row_inclusao] = pl_qtdade		
					If ps_tipo_inclusao = 'V' Then
						dw_2.Object.pc_desconto_fixo 					[ll_row_inclusao] = pdc_desconto
					Else
						dw_2.Object.pc_desconto_fixo 					[ll_row_inclusao] = dw_2.Object.pc_desconto_fixo		 					[pl_row]
					End If
					dw_2.Object.vl_preco_unitario 							[ll_row_inclusao] = dw_2.Object.vl_preco_unitario 						[pl_row]
					dw_2.Object.qt_estoque				 					[ll_row_inclusao] = dw_2.Object.qt_estoque			 					[pl_row]		
					dw_2.Object.pc_desconto_negociavel					[ll_row_inclusao] = dw_2.Object.pc_desconto_negociavel				[pl_row]
					dw_2.Object.id_situacao									[ll_row_inclusao] = dw_2.Object.id_situacao								[pl_row]
					dw_2.Object.pc_desconto_sos							[ll_row_inclusao] = dw_2.Object.pc_desconto_sos						[pl_row]
					dw_2.Object.local											[ll_row_inclusao] = dw_2.Object.local										[pl_row]		
					dw_2.Object.pc_desconto_clube						[ll_row_inclusao] = dw_2.Object.pc_desconto_clube						[pl_row]
					dw_2.Object.id_comissionado							[ll_row_inclusao] = dw_2.Object.id_comissionado							[pl_row]
					dw_2.Object.id_vidalink									[ll_row_inclusao] = dw_2.Object.id_vidalink									[pl_row]
					dw_2.Object.pc_desconto_sos_farm_popular		[ll_row_inclusao] = dw_2.Object.pc_desconto_sos_farm_popular		[pl_row]
					dw_2.Object.id_gratis_farm_popular					[ll_row_inclusao] = dw_2.Object.id_gratis_farm_popular				[pl_row]
					dw_2.Object.id_pbm										[ll_row_inclusao] = dw_2.Object.id_pbm										[pl_row]
					dw_2.Object.id_farmacia_popular						[ll_row_inclusao] = dw_2.Object.id_farmacia_popular					[pl_row]
					dw_2.Object.id_promover_venda						[ll_row_inclusao] = dw_2.Object.id_promover_venda						[pl_row]
					dw_2.Object.id_lei_generico							[ll_row_inclusao] = dw_2.Object.id_lei_generico							[pl_row]
					dw_2.Object.nr_etiqueta_prestes						[ll_row_inclusao] = dw_2.Object.nr_etiqueta_prestes						[pl_row]
					dw_2.Object.id_promocao_vinculada					[ll_row_inclusao] = dw_2.Object.id_promocao_vinculada				[pl_row]		
					dw_2.Object.pc_icms										[ll_row_inclusao] = dw_2.Object.pc_icms									[pl_row]
					dw_2.Object.id_contem_acucar						[ll_row_inclusao] = dw_2.Object.id_contem_acucar						[pl_row]
					dw_2.Object.id_contem_gluten							[ll_row_inclusao] = dw_2.Object.id_contem_gluten						[pl_row]
					dw_2.Object.id_contem_lactose						[ll_row_inclusao] = dw_2.Object.id_contem_lactose						[pl_row]
					dw_2.Object.vl_reembolso_fpb							[ll_row_inclusao] = dw_2.Object.vl_reembolso_fpb						[pl_row]
					dw_2.Object.nr_seq_cliente_caixa_prd				[ll_row_inclusao] = dw_2.Object.nr_seq_cliente_caixa_prd				[pl_row]
					dw_2.Object.cd_filial_reserva							[ll_row_inclusao] = dw_2.Object.cd_filial_reserva							[pl_row]
					dw_2.Object.nr_matric_atendente_reserva			[ll_row_inclusao] = dw_2.Object.nr_matric_atendente_reserva		[pl_row]
					dw_2.Object.id_reservado								[ll_row_inclusao] = dw_2.Object.id_reservado								[pl_row]
					dw_2.Object.id_saldo_pendente						[ll_row_inclusao] = dw_2.Object.id_saldo_pendente						[pl_row]
					dw_2.Object.nr_pedido_empurrado					[ll_row_inclusao] = dw_2.Object.nr_pedido_empurrado					[pl_row]
					dw_2.Object.cd_mix_produto							[ll_row_inclusao] = dw_2.Object.cd_mix_produto							[pl_row]
					dw_2.Object.qt_minima_aprovacao					[ll_row_inclusao] = dw_2.Object.qt_minima_aprovacao					[pl_row]
					dw_2.Object.id_pbm_clamed							[ll_row_inclusao] = dw_2.Object.id_pbm_clamed							[pl_row]
					dw_2.Object.cd_grupo_psico							[ll_row_inclusao] = dw_2.Object.cd_grupo_psico							[pl_row]		
					If ps_tipo_inclusao = 'V' Then
						dw_2.Object.cd_promocao_sos 					[ll_row_inclusao] = pl_promocao
					Else
						dw_2.Object.cd_promocao_sos 					[ll_row_inclusao] = dw_2.Object.cd_promocao_sos 						[pl_row]
					End If	
					If ps_tipo_inclusao = 'V' Then	
						dw_2.Object.id_usado_promocao_vinculada 	[ll_row_inclusao] = 'S'
						dw_2.Object.qt_usada_promocao_vinculada 	[ll_row_inclusao] = pl_qtdade
					Else
						//dw_2.Object.id_alteracao_preco					[ll_row_inclusao] = dw_2.Object.id_alteracao_preco					[pl_row]
						dw_2.Object.pc_desconto							[ll_row_inclusao] = dw_2.Object.pc_desconto							[pl_row]		
						dw_2.Object.id_usado_promocao_vinculada 	[ll_row_inclusao] = 'N'
						dw_2.Object.qt_usada_promocao_vinculada 	[ll_row_inclusao] = dw_2.Object.qt_usada_promocao_vinculada 	[pl_row]
					End If		
				End If
			End If			
			
			If ps_tipo_inclusao = 'V' Then
				//Altera informa$$HEX2$$e700e300$$ENDHEX$$o de uso em promo$$HEX2$$e700e300$$ENDHEX$$o nos produtos vinculos
				ll_qtd_vinc = pl_qtd_vinculo
				ll_find_promocao = 0
				Do while ll_qtd_vinc > 0
					ll_find_promocao  = dw_2.Find ("cd_produto = " + STRING( pl_produto_vinculo ) + &
																 " and qt_usada_promocao_vinculada < qt_orcada", ll_find_promocao + 1 ,dw_2.RowCount())			
					If ll_find_promocao < 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Remo$$HEX2$$e700e300$$ENDHEX$$o vinculos.",StopSign!)
						Return False						
					ElseIf 	ll_find_promocao > 0 Then
						ll_qtd_disp = dw_2.Object.qt_orcada[ll_find_promocao] - dw_2.Object.qt_usada_promocao_vinculada[ll_find_promocao]								
						If ll_qtd_disp >= ll_qtd_vinc Then
							dw_2.Object.id_usado_promocao_vinculada		[ll_find_promocao] = 'S'
							dw_2.Object.qt_usada_promocao_vinculada	[ll_find_promocao] = dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] + ll_qtd_vinc
							dw_2.Object.cd_promocao_sos						[ll_find_promocao] = pl_promocao
							ll_qtd_vinc = 0
						Else
							dw_2.Object.id_usado_promocao_vinculada [ll_find_promocao] = 'S'									
							dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] = dw_2.Object.qt_usada_promocao_vinculada [ll_find_promocao] + ll_qtd_disp
							dw_2.Object.cd_promocao_sos					 [ll_find_promocao] = pl_promocao
							ll_qtd_vinc = ll_qtd_vinc - ll_qtd_disp 
						End If
					ElseIf ll_find_promocao = 0 Then
						ll_qtd_vinc = 0				
					End If
				Loop	
			End If
		
			Event ue_AddRow(dw_2)
			dw_2.SetRow(dw_2.RowCount())
			dw_2.ScrollToRow(dw_2.RowCount())
			dw_2.SetColumn("de_produto")		
			
		End Choose //Tipo PROMOCAO

		Return True
		
CATCH( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~rwf_aplica_desconto_pbm_clamed( )", StopSign! )
FINALLY
	dw_2.AcceptText( )
END TRY
end function

public function boolean wf_conclui_pbm ();Long ll_Produto, &
		ll_Linha_DS, &
		ll_row, &
		ll_find_produto

String ls_Retorno

Try
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	dc_uo_ds_base lds_pbm_Aux
	lds_pbm_Aux = Create dc_uo_ds_Base
	
	If IsNull( ivo_Cliente.Cd_Cliente ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente n$$HEX1$$e300$$ENDHEX$$o informado.~r~rBenef$$HEX1$$ed00$$ENDHEX$$cio exclusivo para Cliente Clube " + Gvo_Parametro.id_rede_filial + ".", Exclamation!)
		Return False
	End If	
	
	If dw_2.RowCount() <= 0 Then
		Return False
	Else
		If IsNull( dw_2.Object.cd_produto[1] ) Or (dw_2.Object.cd_produto[1] = 0) Then
			Return False
		End If
	End If
		
	If Not lds_pbm_Aux.of_ChangeDataObject( "dw_ge108_lista_produtos_pbm_clamed" ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_Changedataobject. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_conclui_pbm", Exclamation!)
		Return False
	End If
			
	//Atribui os produtos da dw_2 para lds_pbm_Aux
	For ll_Row = 1 To dw_2.RowCount()
		ll_Produto = dw_2.Object.cd_produto[ ll_Row ]
		
		If IsNull(ll_Produto) 																										Then Continue
		If dw_2.Object.id_pbm_clamed[ ll_Row ] <> 'S' 																	Then Continue
		//If IsNull(dw_2.Object.cd_promocao_sos [ll_Row]) Or dw_2.Object.cd_promocao_sos [ll_Row] = 0 	Then Continue
		If dw_2.Object.id_usado_promocao_vinculada[ ll_Row ] <> 'S' 												Then Continue
		
		ll_find_produto = lds_pbm_Aux.Find ("cd_produto = " + STRING( ll_produto ), 1 , lds_pbm_Aux.RowCount() )
		
		If ll_find_produto > 0 Then
			lds_pbm_Aux.Object.qt_produto [ ll_find_produto ] = lds_pbm_Aux.Object.qt_produto [ ll_find_produto ] + dw_2.Object.qt_orcada[ ll_row ]
			Continue
		Else
			If ll_find_produto < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find - Quantidade Or$$HEX1$$e700$$ENDHEX$$ada.",StopSign!)
				Return False
			End If				
		End If		
		
		ll_Linha_DS = lds_pbm_Aux.InsertRow(0)
		lds_pbm_Aux.Object.cd_filial 							[ ll_Linha_DS ] 	= gvo_parametro.cd_filial
		lds_pbm_Aux.Object.nr_sequencial_cliente_caixa	[ ll_Linha_DS ] 	= il_Sequencial_Cliente_Caixa
		lds_pbm_Aux.Object.cd_produto						[ ll_Linha_DS ] 	= ll_Produto
		lds_pbm_Aux.Object.de_produto						[ ll_Linha_DS ] 	= dw_2.Object.de_produto 						[ ll_Row ]
		lds_pbm_Aux.Object.qt_produto						[ ll_Linha_DS ] 	= dw_2.Object.qt_orcada 						[ ll_Row ]
		lds_pbm_Aux.Object.nr_sequencial					[ ll_Linha_DS ] 	= dw_2.Object.nr_seq_cliente_caixa_prd	[ ll_Row ]
		
		lds_pbm_Aux.Object.id_com_receita					[ ll_Linha_DS ] 	= dw_2.Object.id_com_receita					[ ll_Row ]
		lds_pbm_Aux.Object.id_registro_prescritor			[ ll_Linha_DS ] 	= dw_2.Object.id_registro_prescritor			[ ll_Row ]
		lds_pbm_Aux.Object.nr_registro_prescritor			[ ll_Linha_DS ] 	= dw_2.Object.nr_registro_prescritor			[ ll_Row ]
		lds_pbm_Aux.Object.cd_uf_prescritor					[ ll_Linha_DS ] 	= dw_2.Object.cd_uf_prescritor				[ ll_Row ]
		//
	Next
	
	If lds_pbm_Aux.RowCount() = 0 Then
		Return False
	End If
	
	OpenWithParm( w_ge108_pbm_clamed, lds_pbm_Aux )		
	
	uo_ge108_parametros lo_parametro
	
	lo_parametro = Message.PowerObjectParm
	
	If IsNull( lo_parametro.Retorno ) Then
		Return False
	End If
	
	If lo_parametro.Retorno = "OK" Then
		//Atribui os dados dos prescritores nos produtos da dw_2
		For ll_Row = 1 TO lo_parametro.ids.RowCount()
			ll_Produto = lo_parametro.ids.Object.cd_produto[ ll_Row ]
			
			ll_find_produto = dw_2.Find( "cd_produto = " + String( ll_Produto ) + " and id_usado_promocao_vinculada = 'S' ", 1, dw_2.RowCount() )
			
			If ll_find_produto > 0 Then	
				dw_2.Object.id_com_receita					[ ll_find_produto ] 	=  lo_parametro.ids.Object.id_com_receita					[ ll_Row ]
				dw_2.Object.id_registro_prescritor			[ ll_find_produto ] 	=  lo_parametro.ids.Object.id_registro_prescritor			[ ll_Row ]
				dw_2.Object.nr_registro_prescritor			[ ll_find_produto ] 	=  lo_parametro.ids.Object.nr_registro_prescritor			[ ll_Row ]
				dw_2.Object.cd_uf_prescritor					[ ll_find_produto ] 	=  lo_parametro.ids.Object.cd_uf_prescritor				[ ll_Row ]
			End If
			
		Next
	End If
	
	//Cliente caixa produto j$$HEX1$$e100$$ENDHEX$$ atualizado com as informa$$HEX1$$e700$$ENDHEX$$oes do prescritor
	Return ( lo_parametro.Retorno = "OK" )
	
Finally
	If IsValid(  lds_pbm_Aux ) Then Destroy lds_pbm_Aux
	If IsValid( lo_parametro ) Then Destroy lo_parametro
End Try

end function

public subroutine wf_localiza_convenio ();dw_1.AcceptText()

io_Convenio.of_Localiza_Convenio( dw_1.gettext( ) )

If io_Convenio.Localizado Then
	dw_1.Object.Nm_Convenio	[1] = io_Convenio.nm_Fantasia
	dw_1.Object.Cd_Convenio	[1] = io_Convenio.Cd_Convenio
	
	dw_1.Object.de_condicao_conv[ 1 ] = ""
	io_condicao_convenio.somente_ativas = true
	wf_Localiza_Condicao_Conv( )
End If
end subroutine

public subroutine wf_localiza_condicao_conv ();dw_1.AcceptText()

io_Condicao_Convenio.Somente_Ativas = True
io_Condicao_Convenio.of_Localiza_Condicao( io_Convenio.cd_Convenio, dw_1.Object.de_condicao_conv[ 1 ] )

If io_Condicao_Convenio.Localizado Then
	dw_1.Object.de_condicao_conv	[1] = io_Condicao_Convenio.de_condicao_convenio
	dw_1.Object.cd_Condicao_Conv	[1] = io_Condicao_Convenio.cd_condicao_convenio
Else
	io_Convenio.of_Inicializa( )
	dw_1.Object.Nm_Convenio	[1] = io_Convenio.nm_Fantasia
	dw_1.Object.Cd_Convenio	[1] = io_Convenio.Cd_Convenio
End If

//Atribui a condi$$HEX2$$e700e300$$ENDHEX$$o no objeto uo_ge108_produto para localizar os produtos aplicando o desconto do conv$$HEX1$$ea00$$ENDHEX$$nio
ivo_produto.il_convenio 							= io_condicao_convenio.cd_convenio
ivo_produto.il_condicao_convenio 				= io_condicao_convenio.cd_condicao_convenio

dw_2.Event ue_AddRow()
dw_2.Event ue_Pos( dw_2.RowCount(), 'de_produto' )	
end subroutine

public subroutine wf_bloqueia_campos_convenio ();Integer li_Find

li_Find = dw_2.Find( "not isnull(cd_produto)", 1, dw_2.RowCount( ) )

If li_Find > 0 Then
	dw_1.SetTabOrder( "nm_convenio", 0 )
	dw_1.Modify("nm_convenio.background.color='134217750'") // Button Light Shadow
	dw_1.Modify("cd_convenio.background.color='134217750'")
	dw_1.Modify("nm_convenio.Tooltip.Enabled=True")
	
	If io_Convenio.Localizado Then
		dw_1.Modify("nm_convenio.Tooltip.Tip= 'A troca de conv$$HEX1$$ea00$$ENDHEX$$nio $$HEX1$$e900$$ENDHEX$$ permitida somente quando n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum produto na consulta'")
	Else
		dw_1.Modify("nm_convenio.Tooltip.Tip= 'A sele$$HEX2$$e700e300$$ENDHEX$$o de conv$$HEX1$$ea00$$ENDHEX$$nio $$HEX1$$e900$$ENDHEX$$ permitida somente quando n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum produto na consulta'")
	End If
Else
	dw_1.SetTabOrder( "nm_convenio", 20 )
	dw_1.Modify("nm_convenio.background.color='16777215'")
	dw_1.Modify("cd_convenio.background.color='16777215'")
	dw_1.Modify("nm_convenio.Tooltip.Enabled=False")
End If
end subroutine

public function decimal wf_localiza_desconto_produto (ref decimal adc_pc_desc_convenio);Boolean lb_Aplica_Desconto_Convenio = True

Long ll_Produto

Decimal ldc_Desconto_Produto
Decimal ldc_Desconto_Produto_Prestes

adc_pc_desc_convenio			= 0
ldc_Desconto_Produto			= ivo_Produto.of_Desconto_Filial( )
ldc_Desconto_Produto_Prestes	= ivo_Produto.of_Desconto_Etiqueta_Preste( )

This.ib_Produto_Vencido = False

If Not IsNull( ivo_Produto.nr_Etiqueta_Preste ) And ldc_Desconto_Produto_Prestes = 0 Then
	If gf_Primeiro_Dia_Mes( Date( gvo_Parametro.of_Dh_Movimentacao( ) ) ) > gf_Primeiro_Dia_Mes( Date( ivo_Produto.dh_Validade_Preste ) ) Then
		This.ib_Produto_Vencido = True
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto vencido, venda n$$HEX1$$e300$$ENDHEX$$o permitida.", Exclamation! )
	End If
End If

If io_condicao_convenio.localizado Then
	/****** TESTE DE RESTRICOES *******/
	If io_condicao_convenio.id_restricao_produto <> "N" Then
		Select cd_produto 
		Into :ll_Produto
		From restricao_convenio_produto
		Where cd_convenio				= :io_condicao_convenio.cd_convenio
			And cd_condicao_convenio	= :io_condicao_convenio.cd_condicao_convenio
			And cd_produto				= :ivo_Produto.cd_Produto
		Using SqlCa;
		
		Choose Case Sqlca.SQLCode
			Case -1
				SqlCa.of_RollBack( )
				Sqlca.of_MsgDBError("Restri$$HEX2$$e700e300$$ENDHEX$$o produto convenio.")
				lb_Aplica_Desconto_Convenio = False
	
			Case 100
				If io_condicao_convenio.id_restricao_produto = "S" Then 
					lb_Aplica_Desconto_Convenio = False
				End If
		
			Case Else
				If io_condicao_convenio.id_restricao_produto = "E" Then
					lb_Aplica_Desconto_Convenio = False
				End If
		End Choose
	End If
	
	If io_condicao_convenio.id_restricao_grupo_produto <> "N" And lb_Aplica_Desconto_Convenio Then	
		Select cd_grupo_produto 
		Into :ll_Produto
		From restricao_convenio_grupo
		Where cd_convenio				= :io_condicao_convenio.cd_convenio
			And cd_condicao_convenio	= :io_condicao_convenio.cd_condicao_convenio
			And cd_grupo_produto		= :ivo_Produto.cd_Grupo_Produto
		Using SqlCa;
	
		Choose Case Sqlca.SQLCode
			Case -1
				SqlCa.of_RollBack( )
				Sqlca.of_MsgDBError("Restri$$HEX2$$e700e300$$ENDHEX$$o grupo convenio.")
				lb_Aplica_Desconto_Convenio = False
	
			Case 100
				If io_condicao_convenio.id_restricao_produto = "S" Then 
					lb_Aplica_Desconto_Convenio = False
				End If
		
			Case Else
				If io_condicao_convenio.id_restricao_produto = "E" Then
					lb_Aplica_Desconto_Convenio = False
				End If
		End Choose	
	End If
	/*************/
	
	
	If lb_Aplica_Desconto_Convenio Then
		adc_pc_desc_convenio = io_condicao_convenio.pc_desconto_minimo
		
		If io_condicao_convenio.id_considera_desc_produto = 'S' Then
			adc_pc_desc_convenio = ivo_Produto.of_desconto_convenio( io_condicao_convenio.cd_convenio , io_condicao_convenio.pc_desconto_minimo )
		End If
		
		If adc_pc_desc_convenio < ldc_Desconto_Produto_Prestes Then
			adc_pc_desc_convenio = ldc_Desconto_Produto_Prestes
		End If
		
		If  adc_pc_desc_convenio < ldc_Desconto_Produto Then
			adc_pc_desc_convenio = ldc_Desconto_Produto_Prestes
		End If
	End If
End If // io_condicao_convenio.localizado

If ldc_Desconto_Produto_Prestes > ldc_Desconto_Produto Then Return ldc_Desconto_Produto_Prestes

Return ldc_Desconto_Produto
end function

public subroutine wf_altera_rotulo_end ();If ivi_Qtde_Itens_Reservados > 0 Then
	dw_1.Object.end_t.Visible					= False
	dw_1.Object.end_r_t.Visible					= True
	dw_1.Object.end_pbm_clamed_t.Visible	= False
ElseIf ib_Venda_pbm_clamed And ivo_Cliente.Localizado Then
	dw_1.Object.end_t.Visible					= False
	dw_1.Object.end_r_t.Visible					= False
	dw_1.Object.end_pbm_clamed_t.Visible	= True
Else
	dw_1.Object.end_t.Visible					= True
	dw_1.Object.end_r_t.Visible					= False
	dw_1.Object.end_pbm_clamed_t.Visible	= False
End If

end subroutine

public function boolean wf_cobre_preco ();Long ll_Row
Long ll_Produto
Long ll_Linha_DS
Long ll_Linhas_Retorno

Decimal{2} ldc_Desconto_Negociado

String ls_CPF

Boolean lb_Pesquisado_Cobre_Preco



Try
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	lb_Pesquisado_Cobre_Preco = False
	
	If is_Permite_Negociacao <> 'S' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A funcionalidade Cobre Pre$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel nesta filial.",Exclamation!)
		Return False
	End If
		
	If dw_2.RowCount() <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto selecionado.", Exclamation!)
		Return False
	Else
		ll_Row = dw_2.getRow()
				
		ll_Produto = dw_2.Object.cd_produto[ ll_Row ]
		
		If IsNull( ll_Produto ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto selecionado.", Exclamation!)
			Return False
		End If
		
		// Fun$$HEX2$$e700e300$$ENDHEX$$o identifica se o produto esta bloqueado para Cobre Pre$$HEX1$$e700$$ENDHEX$$o
		If This.wf_cobre_preco_produto_bloqueio(ll_Produto) Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este Produto n$$HEX1$$e300$$ENDHEX$$o pode ser utilzado para funcionalidade do Cobre Pre$$HEX1$$e700$$ENDHEX$$o!", Exclamation!)
			Return False
		End If 
	End If
	
	ls_CPF = ivo_Cliente.nr_cpf_cgc
	
	//Zera variaveis de instancia
	io_Cobre_Preco.Retorno 					= ""
	io_Cobre_Preco.Produto_Retorno		= SetNull( io_Cobre_Preco.Produto_Retorno )
	io_Cobre_Preco.Desconto_Negociado = SetNull( io_Cobre_Preco.Desconto_Negociado )
	
	//Localizacao nos objetos de instancia
	io_Cobre_Preco.io_Produto.of_Localiza_Codigo_Interno( ll_Produto )
	io_Cobre_Preco.io_Cliente.of_Localiza_CPF( ls_CPF, False )
	
	//Carrega parametros
	io_Cobre_Preco.Sequencial_Cliente_Caixa 	= il_Sequencial_Cliente_Caixa
	io_Cobre_Preco.matricula_vendedor			= is_Matricula_Vendedor
	io_Cobre_Preco.Nm_Vendedor					= is_Nm_Vendedor	

	OpenWithParm( w_rl154_cobre_preco, io_Cobre_Preco )		

	io_Cobre_Preco = Message.PowerObjectParm
	
	If IsNull( io_Cobre_Preco ) Or Not IsValid(io_Cobre_Preco) Then
		Return False
	End If
	
	Choose Case Upper( io_Cobre_Preco.Retorno )
		Case "LIMITEEXCEDIDO"
			Return False
			
		Case "NENHUM" //Nenhum produto cobriu o preco do concorrente
			//Return False
			
		Case "OK"
			//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto ser$$HEX1$$e100$$ENDHEX$$ trocado pelo produto negociado")
			
			If ll_Produto <>  io_Cobre_Preco.Produto_Retorno Then	
				Long ll_Aux
				dw_2.DeleteRow( ll_Row )
				ll_Row = dw_2.Event ue_AddRow()
				If ll_Row < 0 Then
					//J$$HEX1$$e100$$ENDHEX$$ existe uma linha em branco da grid
					ll_Row = dw_2.Find( "IsNull(cd_produto)", 1, dw_2.RowCount() )
					
					If ll_Row > 0 Then
						il_seq_cliente_caixa_prd++
						dw_2.Event ue_Pos(ll_Row, "de_produto")
						dw_2.Object.nr_seq_cliente_caixa_prd	[ ll_Row ] 	= il_seq_cliente_caixa_prd
						dw_2.Object.Id_Saldo_Pendente			[ ll_Row ] 	= 'N'
						dw_atalhos.Object.st_mov_estoque.Text 				= 'Mov. Estoque'
					End If
				End If

				dw_2.Object.de_produto		[ ll_Row ] = String( io_Cobre_Preco.Produto_Retorno ) 
				wf_localiza_produto( String( io_Cobre_Preco.Produto_Retorno ) )
			End If
						
			dw_2.Object.id_cobre_preco							[ ll_Row ] = 'S'
			dw_2.Object.pc_desconto_fixo							[ ll_Row ] = io_Cobre_Preco.Desconto_Negociado
			dw_2.Object.nr_seq_negociacao_cliente_prd		[ ll_Row ] = io_Cobre_Preco.Seq_Negociacao_Cliente_Prd			
			
			//Bloqueia o cliente			
			wf_bloqueia_libera_campos_cliente()
	
	End Choose
	
	If IsNull( dw_1.Object.nr_cpf[ 1 ] ) Or Trim( dw_1.Object.nr_cpf[ 1 ] ) = "" Then
		
		If io_Cobre_Preco.io_Cliente.Localizado Then
			dw_1.Object.Localizacao[ 1 ] = io_Cobre_Preco.io_Cliente.nr_cpf_cgc

			lb_Pesquisado_Cobre_Preco = TRUE
			
			wf_Localiza_Cliente( lb_Pesquisado_Cobre_Preco )
		Else
			If Not IsNull( io_Cobre_Preco.cpf_nao_cadastrado ) And Trim(io_Cobre_Preco.cpf_nao_cadastrado) <> "" Then
				dw_1.Object.localizacao	[ 1 ] = "CLIENTE N$$HEX1$$c300$$ENDHEX$$O CADASTRADO"
				dw_1.Object.nr_cpf		[ 1 ] = io_Cobre_Preco.cpf_nao_cadastrado
				
				If Len( io_Cobre_Preco.cpf_nao_cadastrado ) = 11 Then
					dw_1.Object.Nr_Cpf.Width = 471
					dw_1.Object.Nr_Cpf.Editmask.Mask =  "###.###.###-##"
				Else
					dw_1.Object.Nr_Cpf.Width = 580
					dw_1.Object.Nr_Cpf.Editmask.Mask =  "##.###.###/####-##"
				End If
			End If
			
		End If
	End If
	
Finally
	//If IsValid(  ids_Negociacao_Aux ) Then Destroy ids_Negociacao_Aux
End Try



end function

public subroutine wf_bloqueia_libera_campos_cliente ();Integer li_Find

li_Find = dw_2.Find( "id_cobre_preco='S' Or id_reservado = 'S'", 1, dw_2.RowCount( ) )

If li_Find > 0 Then
	dw_1.SetTabOrder( "localizacao", 0 )
	dw_1.Modify("localizacao.background.color='134217750'") // Button Light Shadow
	dw_1.Modify("nr_cpf.background.color='134217750'")	
	dw_1.Modify("nm_dependente.background.color='134217750'")
Else
	dw_1.SetTabOrder( "localizacao", 20 )
	dw_1.Modify("localizacao.background.color='16777215'")
	dw_1.Modify("nr_cpf.background.color='16777215'")
	dw_1.Modify("nm_dependente.background.color='16777215'")
End If



end subroutine

public function boolean wf_grava_cobre_preco ();Long ll_Produto, ll_Find, ll_Seq_Prd, ll_Qt_orcada, ll_Row

String ls_Id_Cobre_Preco

Try
	//Matricula Vendedor
	//io_Parametros.Matricula_vendedor 			= is_Vendedor
	//io_Parametros.Cliente							= dw_1.Object.cd_Cliente 	[ 1 ] 
	//io_Parametros.Nome_Cliente					= dw_1.Object.nm_Cliente 	[ 1 ]
	//io_Parametros.Sequencial_Cliente_Caixa 	= il_Sequencial_Cliente_Caixa
	//
	If io_Cobre_Preco.ids.RowCount( ) > 0 Then
		
		dw_2.AcceptText()
		
		//Atribui as quantidades que foram orcadas
		For ll_Row = 1 To dw_2.RowCount()
			ll_Produto 				= dw_2.Object.cd_produto								[ ll_Row ] 
			ll_Seq_Prd				= dw_2.Object.nr_seq_negociacao_cliente_prd		[ ll_Row ]
			ll_Qt_orcada 			= dw_2.Object.qt_orcada								[ ll_Row ]
			ls_Id_Cobre_Preco 	= dw_2.Object.id_cobre_preco							[ ll_Row ]
			
			ll_Find = io_Cobre_Preco.ids.Find( "cd_produto = " + String( ll_Produto ) + " and nr_sequencial = " + String( ll_Seq_Prd ), 1, io_Cobre_Preco.ids.RowCount() )
			
			If ll_Find < 0  Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find, fun$$HEX2$$e700e300$$ENDHEX$$o: wf_grava_cobre_preco().")
				Return False
			End If
			
			If ll_Find > 0 Then
				io_Cobre_Preco.ids.Object.qt_negociada[ ll_Find ] = ll_Qt_orcada
				
				io_Cobre_Preco.ids.Object.id_marcado	[ ll_Find ] = IIF(ls_Id_Cobre_Preco='S', 'S', 'N')
			End If
			
		Next
		
		OpenWithParm( w_rl154_aprovacao, io_Cobre_Preco )
		
		//Retono
		io_Cobre_Preco = Message.PowerObjectParm
		
		If io_Cobre_Preco.Retorno = "VOLTAR" Then Return False
	End If
	
	Return True

Finally
	
End Try


end function

public function boolean wf_atualiza_cobre_preco ();Long ll_Row
Long ll_Linhas
Long ll_Produto
Long ll_Seq_Prd
Long ll_Find
Long ll_Qt_Produto

String ls_Situacao, ls_Marcado

Integer li_Count

If Not IsValid( io_Cobre_Preco.ids ) Then Return False

ll_Linhas = io_Cobre_Preco.ids.RowCount()

Select count(nr_sequencial) 
	into :li_Count
from negociacao_cliente
where cd_filial 								= :gvo_Parametro.Cd_Filial
	and nr_sequencial_cliente_caixa	= :io_Cobre_Preco.Sequencial_Cliente_Caixa
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o registro na tabela negociacao_cliente. seq. " + String(io_Cobre_Preco.Sequencial_Cliente_Caixa))
	Return False
End If

If li_Count = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum registro da negocia$$HEX2$$e700e300$$ENDHEX$$o foi criado na tela Cobre Pre$$HEX1$$e700$$ENDHEX$$o.", StopSign!)
	Return False
End If

For ll_Row = 1 To ll_Linhas
	ll_Produto 		= io_Cobre_Preco.ids.Object.cd_produto					[ ll_Row ]
	ls_Marcado		= io_Cobre_Preco.ids.Object.id_marcado				[ ll_Row ]
	ll_Seq_Prd		= io_Cobre_Preco.ids.Object.nr_sequencial				[ ll_Row ]
	ll_Qt_Produto 	= 1
	
	
	ls_Situacao = IIF( ls_Marcado = 'S', 'A', 'X' )
	
	If ls_Situacao = 'A' Then
		ll_Find = dw_2.Find( "cd_produto = " + String( ll_Produto ) + " and nr_seq_negociacao_cliente_prd = " + String( ll_Seq_Prd ), 1, dw_2.RowCount() )
		
		If ll_Find > 0 Then
			ll_Qt_Produto = dw_2.Object.qt_orcada[ ll_Find ]		
		End If

		//Situacao APROVADO	
		Update negociacao_cliente 
			Set id_situacao 							= :ls_Situacao,
				 qt_negociada							= :ll_Qt_Produto
			Where cd_filial 								= :gvo_Parametro.Cd_Filial 
				and nr_sequencial_cliente_caixa	= :io_Cobre_Preco.Sequencial_Cliente_Caixa
				and cd_produto 						= :ll_Produto
				and nr_sequencial			 			= :ll_Seq_Prd
			Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback( );
			SqlCa.of_MsgDbError( "Erro atualiza$$HEX2$$e700e300$$ENDHEX$$o produto " + String(ll_Produto) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_atualiza_cobre_preco()" )
			Return False
		End If
	End If	
Next

Return True




end function

public function boolean wf_cliente_vendedor (string ps_matricula, string ps_cpf_cliente);//Verifica se o cliente $$HEX1$$e900$$ENDHEX$$ o vendedor
String ls_cpf_vendedor

Select  nr_cpf
   Into  :ls_cpf_vendedor
 From usuario				  u
Where u.cd_filial = :gvo_parametro.cd_filial
   And u.nr_matricula = :ps_matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		Return False
		
	Case 100
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Matr$$HEX1$$ed00$$ENDHEX$$cula n$$HEX1$$e300$$ENDHEX$$o localizada no cadastro de vendedores desta filial.", StopSign! )
		Return False
End Choose

If Trim(ps_cpf_cliente) > '' And not IsNull(ps_cpf_cliente) Then
	If Trim(ps_cpf_cliente) = Trim(ls_cpf_vendedor) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Vendedor n$$HEX1$$e300$$ENDHEX$$o pode ser o cliente da venda.", StopSign! )
		Return False	
	Else
		Return True
	End If	
End If

Return True
end function

public subroutine wf_verifica_campanha_promocional ();String ls_Produto_Campanha
String ls_Nr_Mensagem
String ls_tipo_campanha

String ls_Codigo_Mensagem
String ls_Titulo_Mensagem
String ls_Texto_Mensagem

String ls_matric_campanha
String ls_Id_Aviso_Realizado

DateTime ldh_abriu_tela_campanha
DateTime ldh_fechou_tela_campanha

Long ll_Linha, ll_Campanha, ll_Produto_Campanha, ll_Saldo, ll_linha_grid

Try	
	// Realiza a busca das campanhas somente se na localiza$$HEX2$$e700e300$$ENDHEX$$o do cliente foi identificado que o mesmo possui alguma vigente	
//	If is_Cliente_Possui_Campanha <> 'S' Then 
//		Return
//	End If
	
	If Not IsNull(  dw_1.Object.cd_cliente[1] ) Then
		ids_Prd_Campanha_Cliente.Reset()
		ids_Prd_Campanha_Cliente.of_restoresqloriginal( )
			
		uo_Cliente_Central lo_Cliente_Central
		lo_Cliente_Central = Create uo_Cliente_Central
		
		//DS usada para localizar os descontos dos produtos na dw_2
		ids_Prd_Campanha_Cliente.of_AppendWhere(   "cf.cd_filial = " + String( gvo_Parametro.Cd_Filial ) )
		ids_Prd_Campanha_Cliente.of_AppendWhere(   "cc.cd_cliente = '" + ivo_Cliente.Cd_Cliente + "'" )
		
		If lo_Cliente_Central.of_Verifica_Mensagem_Campanha(	 ids_Prd_Campanha_Cliente ) Then
					
			If ids_Prd_Campanha_Cliente.RowCount() > 0 Then
				uo_ge108_mensagem_campanha lo_Mensagem
				lo_Mensagem = Create uo_ge108_mensagem_campanha
				
				If Not lo_mensagem.ids_produtos_campanha.of_ChangeDataObject('dw_ge108_lista_produtos_campanha') Then Return				
				
				For ll_Linha = 1 To ids_Prd_Campanha_Cliente.RowCount()
					ll_Campanha 			 	= ids_Prd_Campanha_Cliente.Object.Nr_Campanha					[ ll_Linha ]
					ll_Produto_Campanha		= ids_Prd_Campanha_Cliente.Object.Cd_Produto						[ ll_Linha ]
					ls_Produto_Campanha	= ids_Prd_Campanha_Cliente.Object.Desc_Produto					[ ll_Linha ]
					ls_Codigo_Mensagem		= ids_Prd_Campanha_Cliente.Object.Cd_Mensagem					[ ll_Linha ]
					ls_Titulo_Mensagem		= ids_Prd_Campanha_Cliente.Object.De_Titulo							[ ll_Linha ]
					ls_Texto_Mensagem		= ids_Prd_Campanha_Cliente.Object.De_Texto							[ ll_Linha ]
					ls_Nr_Mensagem			= ids_Prd_Campanha_Cliente.Object.Nr_Mensagem					[ ll_Linha ]
					ls_tipo_campanha			= UPPER(ids_Prd_Campanha_Cliente.Object.id_tipo_campanha	[ ll_Linha ])
					ls_Id_Aviso_Realizado	= ids_Prd_Campanha_Cliente.Object.id_aviso_realizado				[ ll_Linha ] //Tela verde j$$HEX1$$e100$$ENDHEX$$ apresentada ao cliente
					
					//Garantir que Campanha Cupom Pr$$HEX1$$e900$$ENDHEX$$ / P$$HEX1$$f300$$ENDHEX$$s e consentimentos n$$HEX1$$e300$$ENDHEX$$o apare$$HEX1$$e700$$ENDHEX$$am tamb$$HEX1$$e900$$ENDHEX$$m nas mensagens promocionais.
					If ls_tipo_campanha = 'CD' Or ls_tipo_campanha = 'CP' Or ls_tipo_campanha = 'CO' Or ls_tipo_campanha = 'AT' Or ls_Id_Aviso_Realizado = 'S' Then
						Continue
					End If
					
					If ls_Nr_Mensagem = '2' Then // N$$HEX1$$e300$$ENDHEX$$o tem produto, apenas mensagem
						lo_Mensagem.io_Cliente					= ivo_Cliente
						lo_Mensagem.is_Codigo_Mensagem	= ls_Codigo_Mensagem
						lo_Mensagem.is_Titulo_Mensagem	= ls_Titulo_Mensagem
						lo_Mensagem.is_Texto_Mensagem	= ls_Texto_Mensagem
						
						If Trim(ls_Titulo_Mensagem) = '' Or IsNull(ls_Titulo_Mensagem) Then
							Exit
						End If
						
						ldh_abriu_tela_campanha = gf_getserverdate()  //Data hora abertura tela
						OpenWithParm( w_ge108_Mensagem_Campanha_Cliente_2, lo_Mensagem )
						ldh_fechou_tela_campanha = gf_getserverdate() //Data hora fechou tela
												
						lo_Cliente_Central.of_Atualiza_Mensagem_Campanha(	ivo_Cliente.Cd_Cliente			, &																				
																								ll_Campanha						, &
																								is_Matricula_Vendedor, &
																								gvo_Parametro.Cd_Filial,&
																								ls_Tipo_Campanha,&
																								 LeftA( Message.StringParm, 2 ),&
																								 ldh_abriu_tela_campanha,&
																								 ldh_fechou_tela_campanha)	
						
						Exit //EXIT
					Else // Tem produto
						
						Select qt_saldo_final
							Into :ll_Saldo
						 From vw_saldo_atual_produto
						Where cd_produto = :ll_Produto_Campanha
							and qt_saldo_final > 0 
						  Using SqlCa;
						  
						Choose Case SqlCa.SqlCode
							Case -1
								SqlCa.of_MsgDbError( 'Campanha Cliente' )
																
							Case 100
								Continue
								
							Case 0									
								ivo_Produto.of_Localiza_Codigo_Interno( ll_Produto_Campanha )
								
								lo_Mensagem.io_Produto				= ivo_Produto
								lo_Mensagem.io_Cliente					= ivo_Cliente
								lo_Mensagem.is_Codigo_Mensagem	= ls_Codigo_Mensagem
								lo_Mensagem.is_Titulo_Mensagem	= ls_Titulo_Mensagem
								lo_Mensagem.is_Texto_Mensagem	= ls_Texto_Mensagem
								lo_Mensagem.is_tipo_campanha		= ls_tipo_campanha	
																	
								ll_linha_grid = lo_mensagem.ids_produtos_campanha.RowCount() + 1
								lo_mensagem.ids_produtos_campanha.InsertRow(ll_linha_grid)
								lo_mensagem.ids_produtos_campanha.Object.cd_produto[ll_linha_grid] = ll_Produto_Campanha
									
						End Choose // SqlCa.SqlCode
					
					End If
				Next
				
				If lo_mensagem.ids_produtos_campanha.RowCount() > 0 Then
					ldh_abriu_tela_campanha = gf_getserverdate()  //Data hora abertura tela
					OpenWithParm( w_ge108_Mensagem_Campanha_Cliente, lo_Mensagem )
					ldh_fechou_tela_campanha = gf_getserverdate() //Data hora fechou tela
					
					ls_matric_campanha =  MidA( Message.StringParm, 2 , (Pos(Message.StringParm, "|") - 2) )
						
					//ex-cliente - Melhor Pre$$HEX1$$e700$$ENDHEX$$o - Produto Interesse.		
					If ls_tipo_campanha = 'EX' Or ls_tipo_campanha = 'MB' Or ls_tipo_campanha = 'EX' Or ls_tipo_campanha = 'AP' Then 
						
						lo_Cliente_Central.of_Atualiza_Mensagem_Campanha(	ivo_Cliente.Cd_Cliente			, &																				
																								ll_Campanha						, &
																								ls_matric_campanha, &
																								gvo_Parametro.Cd_Filial,&
																								ls_Tipo_Campanha,&
																								 LeftA( Message.StringParm, 1 ),&
																								 ldh_abriu_tela_campanha,&
																								 ldh_fechou_tela_campanha)					
					
																						
					Else 
						lo_Cliente_Central.of_Atualiza_Mensagem_Campanha(	ivo_Cliente.Cd_Cliente			, &																				
																								ll_Campanha						, &
																								ls_matric_campanha, &
																								gvo_Parametro.Cd_Filial	)	
						
					End If
					
					If LeftA( Message.StringParm, 1 ) = 'S' Then
						dw_2.Event ue_AddRow()
						dw_2.Object.de_produto[ dw_2.GetRow() ] = MidA( Message.StringParm, (Pos(Message.StringParm, "|") + 1) )  //String( ll_Produto_Campanha )
						dw_2.Event ue_Key( KeyEnter!, 1 )
					End If
					
				End If
				
			End If // ids_Prd_Campanha_Cliente.RowCount() > 0
			
		End If // lo_Cliente_Central.of_Verifica_Mensagem_Campanha
	End If
	
Finally
	If IsValid(lo_Mensagem) 						Then Destroy lo_Mensagem
	If IsValid(lo_Cliente_Central) 				Then Destroy lo_Cliente_Central
End Try
end subroutine

public function boolean wf_cobre_preco_produto_bloqueio (long al_produto);Long 		ll_Qtd
Boolean 	lb_Bloqueia_Produto  = False

SELECT count(*)   
INTO :ll_Qtd
FROM bloqueio_cobre_preco
WHERE cd_produto = :al_produto	
USING SQLCA;
	
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError( "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do bloqueio cobre pre$$HEX1$$e700$$ENDHEX$$o produto")
	Return False
End If  

If ll_Qtd > 0 Then 
   lb_Bloqueia_Produto = True
End If 	
	
Return lb_Bloqueia_Produto	
end function

public subroutine wf_verifica_pedido_ecommerce_pendente ();Integer li_pedido_pendente
String ls_Dias

Date ldt_Limite, ldt_Parametro
Integer li_Count

ldt_Parametro = Date(gvo_parametro.dh_movimentacao)

select vl_parametro 
	into :ls_Dias
from parametro_loja where cd_parametro = 'NR_DIAS_LIMITE_PAUSA_ALERTA_PEDIDO_EC'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdberror("Erro ao localizar o limite de dias para a pausa do alerta de pedido pendente. ")
	Return
End If

If Trim(ls_Dias) = '' Or IsNull(ls_Dias) Then
	//Padr$$HEX1$$e300$$ENDHEX$$o caso n$$HEX1$$e300$$ENDHEX$$o seja informado no par$$HEX1$$e200$$ENDHEX$$metro
	ls_Dias = '2'
End If

ldt_Limite = RelativeDate( ldt_Parametro, - Integer(ls_Dias) )
	
Select count(nr_pedido_ecommerce)
   Into :li_pedido_pendente
From pedido_drogaexpress
inner join parametro p
	on p.id_parametro 	= '1'
Where id_situacao 		= 'A'
  and nr_pedido_ecommerce is not null
  and p.cd_filial <> 454
  and (dh_pausa_alerta is null OR Cast(dh_pausa_alerta as Date)< :ldt_Limite)
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos pedidos do eCommerce pendentes")
End If

SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o

Choose Case li_pedido_pendente
	Case 0
		//Return
	Case 1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe '" + String(li_pedido_pendente) + "' pedido do ECOMMERCE que ainda n$$HEX1$$e300$$ENDHEX$$o foi faturado.", Exclamation!)
	Case is > 1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem '" + String(li_pedido_pendente) + "' pedidos do ECOMMERCE que ainda n$$HEX1$$e300$$ENDHEX$$o foram faturados.", Exclamation!)
End Choose


end subroutine

public function boolean wf_verifica_caixa_nao_finalizado ();//Fazer esta valida$$HEX2$$e700e300$$ENDHEX$$o com a controle_caixa.dh_finaliza$$HEX2$$e700e300$$ENDHEX$$o = null e controle_caixa.dh_movimentacao_caixa seja de 1 a 10 dias anterior a dh_movimentacao do parametro

Date ldh_Parametro

Integer li_Count

ldh_Parametro = Date(gvo_Parametro.dh_movimentacao)

Select Count(*)
 Into :li_Count
from controle_caixa
where dh_conferencia is null
and dh_movimentacao_caixa BETWEEN ( dbo.adddate( 'day', -10, :ldh_Parametro) ) AND (dbo.adddate( 'day', -1, :ldh_Parametro))
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar os caixas abertos. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_verifica_caixa_nao_finalizado()")
	Return False
End If

SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o

If li_Count > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe caixa geral n$$HEX1$$e300$$ENDHEX$$o finalizadado em dias anteriores.", Exclamation!)
End If

Return True
end function

public function boolean wf_novo_disque ();Integer li_row

Long ll_Produto
long ll_cd_convenio

Try
	uo_ge498_pedido_disque_entrega lo_pedido
	lo_pedido = Create uo_ge498_pedido_disque_entrega
	
	lo_Pedido.cd_Cliente = dw_1.Object.cd_cliente[1]
	
	ll_cd_convenio = dw_1.object.cd_convenio[1]
	
	if ll_cd_convenio > 0 Then
	
		lo_pedido.nm_cliente = dw_1.object.nm_cliente[1]
		lo_pedido.nm_conveniado = dw_1.object.nm_cliente[1]
		lo_pedido.cd_convenio = ll_cd_convenio
		lo_pedido.nm_convenio = dw_1.object.nm_convenio[1]
		lo_pedido.cd_condicao_convenio = dw_1.object.cd_condicao_conv[1]
		lo_pedido.nm_condicao_convenio = dw_1.object.de_condicao_conv[1]
		
	end if
	
	OpenWithParm(w_ge498_tipo_venda_pedido, lo_pedido)

	lo_pedido = Message.PowerObjectParm
	
	If IsNull(lo_pedido.cd_cliente) Then Return False
	
	lo_pedido.ids_itens.Reset()
	
	For li_row = 1 To dw_2.RowCount()
		ll_Produto = dw_2.Object.cd_produto[ li_row]
		If IsNull( ll_Produto ) Then
			Continue
		End If
		
		lo_pedido.ids_itens.Object.cd_produto 					[li_row] = ll_Produto
		lo_pedido.ids_itens.Object.qt_pedida						[li_row] = dw_2.Object.qt_orcada				[li_row]
		lo_pedido.ids_itens.Object.vl_preco_unitario 			[li_row] = dw_2.Object.vl_preco_unitario	[li_row]	
		lo_pedido.ids_itens.Object.pc_desconto_cobre_preco	[li_row] = dw_2.Object.pc_desconto_fixo	[li_row]	
		lo_pedido.ids_itens.Object.id_cobre_preco 				[li_row] = dw_2.Object.id_cobre_preco		[li_row]		
		lo_pedido.ids_itens.Object.id_reservado 					[li_row] = dw_2.Object.id_reservado			[li_row]	
	Next
	
	//Cart$$HEX1$$e300$$ENDHEX$$o Sa$$HEX1$$fa00$$ENDHEX$$de
	lo_Pedido.nr_cartao_saude = is_cartao_desconto
		
	OpenWithParm(w_ge498_pedido_disque, lo_pedido)
	
	//Retorno NULL bot$$HEX1$$e300$$ENDHEX$$o VOLTAR
	//Retorno OK bot$$HEX1$$e300$$ENDHEX$$o FINALIZAR PEDIDO
	If IsNull(Message.StringParm) Then Return False
	
	Return True
Finally
	If IsValid(lo_pedido) Then Destroy lo_pedido
End Try
end function

public function boolean wf_cupom_pre_ja_emitido (string ps_cliente, ref boolean ab_imprimir);//Valida$$HEX2$$e700e300$$ENDHEX$$o para ser impresso apenas 1 cupom pr$$HEX1$$e900$$ENDHEX$$ por cliente no mesmo dia
//Caso o cliente queira novamente, acessar a fun$$HEX2$$e700e300$$ENDHEX$$o no menu Atendimento ao Cliente Reimprimir Cupom Pr$$HEX1$$e900$$ENDHEX$$ 

Integer li_Count

Date ldh_Parametro

//gvo_Aplicacao.of_grava_log( "Entrou na funcao wf_cupom_pre_ja_emitido")

ldh_Parametro = Date(gvo_Parametro.dh_movimentacao)

ab_imprimir = True

Select Count(cd_cliente)
 into :li_Count
from historico_cupom_prevenda
where cd_filial = :gvo_Parametro.Cd_Filial
	and cd_cliente = :ps_Cliente
	and Cast(dh_impressao as date) = :ldh_Parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback()
	SqlCa.of_msgDbError("Erro ao verificar o historico impress$$HEX1$$e300$$ENDHEX$$o cupom pr$$HEX1$$e900$$ENDHEX$$.")
	ab_imprimir = False
	Return False
End If

//Maior que zero n$$HEX1$$e300$$ENDHEX$$o imprimir
ab_imprimir = (li_Count=0)

//gvo_Aplicacao.of_grava_log( "Saiu da funcao wf_cupom_pre_ja_emitido.  li_Count=" +String(li_Count))

Return True

	
end function

public function decimal wf_desconto_campanha ();Decimal ldc_Desconto_campanha
String ls_Retorno

Integer li_Find

//Localiza somente cliente identificado
If Not ivo_Cliente.localizado Then
	Return 0.00
End If

If Not ivo_Produto.localizado Then
	Return 0.00
End If

li_Find = ids_Prd_Campanha_Cliente.Find( "cd_produto = " +String(ivo_Produto.cd_produto) + " and cd_cliente = '" + ivo_Cliente.cd_cliente + "'" , 1, ids_Prd_Campanha_Cliente.RowCount() )

If li_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find ids_Prd_Campanha_Cliente. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_desconto_campanha()", Exclamation!)
	Return 0.00
End If

If li_Find = 0 Then
	ldc_Desconto_campanha = 0.00
Else
	ls_Retorno = String( ids_Prd_Campanha_Cliente.Object.pc_desconto[ li_Find ] )
	
	ls_Retorno = gf_Replace(ls_Retorno,".",",",0)
	
	If ls_Retorno = '' Then
		ldc_Desconto_campanha = 0.00
	Else	
		ldc_Desconto_campanha = Dec(ls_Retorno)
	End If	
End If

Return ldc_Desconto_campanha
end function

public function boolean wf_imprime_pedido_disque_entrega (long al_roteiro_entrega);//String ls_Cpf_Cgc

Integer li_Linhas, li_Row

Long ll_Roteiro

Try
	
	dc_uo_ds_base lds_Impressao
	lds_Impressao = Create dc_uo_ds_base
	
	If Not lds_Impressao.of_changedataobject( 'dw_ge108_impressao_disque_entrega' ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_changedataobject dw_ge108_impressao_disque_entrega." )
		Return False
	End If
			
	If lds_Impressao.Retrieve( il_Sequencial_Cliente_Caixa ) > 0 Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pedido disque entrega inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso.~r~rDeseja imprimir a lista de separa$$HEX2$$e700e300$$ENDHEX$$o?", Question!, yesNo!, 1) = 1 Then
				
	//		ls_Cpf_Cgc 	= lds_Impressao.Object.nr_cpf_cgc	[ 1 ]
			
//			If LenA( ls_Cpf_Cgc ) > 11 Then
//				lds_Impressao.Object.nr_cpf_cgc.EditMask.mask = '##.###.###/####-##'
//			Else
//				lds_Impressao.Object.nr_cpf_cgc.EditMask.mask = '###.###.###-##'
//			End If	
			
			 lds_Impressao.Object.nr_cpf_cgc	[ 1 ] =  gf_mascara_cpf_cnpj(lds_Impressao.Object.nr_cpf_cgc	[ 1 ])
			
			dc_uo_ds_base ldc_Pagamento
			ldc_Pagamento = Create dc_uo_ds_base
			
			If Not ldc_Pagamento.of_changedataobject( 'dw_ge108_multiplas_formas_pagamento' ) Then
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_changedataobject dw_ge108_impressao_disque_entrega." )
				Return False
			End If	
			
			li_Linhas = ldc_Pagamento.Retrieve( al_roteiro_entrega )
			
			//Formas de Pagamento
			For li_Row = 1 To li_Linhas
				Choose Case li_Row
					Case 1
						lds_Impressao.Object.st_pagto_1.Text 			= ldc_Pagamento.describe("evaluate('lookupdisplay(de_pagamento)', 1)")
						lds_Impressao.Object.st_valor_1.Text 			= String(ldc_Pagamento.Object.vl_pagamento			[li_Row])
						lds_Impressao.Object.st_parcela_1.Text 		= String(ldc_Pagamento.Object.nr_parcelas_cartao	[li_Row]) + "x"
					Case 2
						lds_Impressao.Object.st_pagto_2.Text 			= ldc_Pagamento.describe("evaluate('lookupdisplay(de_pagamento)', 2)")
						lds_Impressao.Object.st_valor_2.Text 			= String(ldc_Pagamento.Object.vl_pagamento				[li_Row])
						lds_Impressao.Object.st_parcela_2.Text 		= String(ldc_Pagamento.Object.nr_parcelas_cartao		[li_Row]) + "x"
					Case 3
						lds_Impressao.Object.st_pagto_3.Text 			= ldc_Pagamento.describe("evaluate('lookupdisplay(de_pagamento)', 3)")
						lds_Impressao.Object.st_valor_3.Text 			= String(ldc_Pagamento.Object.vl_pagamento				[li_Row])
						lds_Impressao.Object.st_parcela_3.Text 		= String(ldc_Pagamento.Object.nr_parcelas_cartao		[li_Row]) + "x"
					Case 4
						lds_Impressao.Object.st_pagto_4.Text 			= ldc_Pagamento.describe("evaluate('lookupdisplay(de_pagamento)', 4)")
						lds_Impressao.Object.st_valor_4.Text 			= String(ldc_Pagamento.Object.vl_pagamento				[li_Row])
						lds_Impressao.Object.st_parcela_4.Text 		= String(ldc_Pagamento.Object.nr_parcelas_cartao		[li_Row]) + "x"
				End Choose
			Next
				
			lds_Impressao.of_print( True )
		End If
	End If
	
Finally
	If IsValid(lds_Impressao) Then Destroy lds_Impressao
	If IsValid(ldc_Pagamento) Then Destroy ldc_Pagamento
End Try
end function

public subroutine wf_conclui_venda (string ps_tipo_pagamento_reserva);Integer li_Mensagem
Integer li_Qtde_Cestas = 0

String	ls_ID_PBM_CLamed,&
		ls_CPF_CNPJ,&
		ls_Comando_Sql,&
		ls_Tipo_Cliente_Caixa,&
		ls_ID_dermaclub

String ls_Retorno_Disque
String ls_ID_Portal_Drogaria

Datetime ldt_Movimentacao

Long ll_linha_grid
Long ll_Roteiro_Entrega

Decimal	ldc_Vl_Frete_Disq_Entrega = 0.00

Long ll_Controle
Long ll_Campanha
Long ll_Produto_Campanha
Long ll_Saldo
Long ll_Linha

String ls_Parametro
String ls_Cliente
String ls_Nome
String ls_Nome_Aux
String ls_Matricula
String ls_Retorno
String ls_Codigo_Dep

String ls_Matric_Negociacao

String ls_Reserva_com_Disque_Entrega
String ls_Situacao_cliente_caixa

srt_parametros_disque_entrega lsrt_Par_Disq_Entr

dw_1.AcceptText()
dw_2.AcceptText()

//PBm Clamed
SetNull( ls_ID_PBM_CLamed )
SetNull( ls_ID_dermaclub )

SetNull(ls_Reserva_com_Disque_Entrega)

If dw_1.Object.localizacao[ 1 ] = "CLIENTE N$$HEX1$$c300$$ENDHEX$$O CADASTRADO" Then
	ls_CPF_CNPJ = dw_1.Object.nr_cpf [ 1 ]
Else
	ls_CPF_CNPJ = ivo_Cliente.nr_cpf_cgc
End If

If IsNull( dw_1.Object.cd_cliente[1] ) And IsNull( ls_CPF_CNPJ ) Then
	li_Mensagem = MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente n$$HEX1$$e300$$ENDHEX$$o foi informado, deseja realmente concluir o atendimento?", Question!, YesNo! )
	
	If li_Mensagem = 2 Then	
		SetNull(is_Matricula_Negociacao)
		SetNull(is_Vendedor_Negociacao)
		dw_1.Event ue_Pos( 1, 'localizacao' )
		Return
	End If
End If

If dw_2.Find("id_cobre_preco='S'", 1, dw_2.RowCount()) > 0 Then
	ls_Matric_Negociacao = io_Cobre_Preco.Matricula_Negociacao
Else
	SetNull(ls_Matric_Negociacao)
End If

ls_Cliente		= ivo_Cliente.Cd_Cliente
ls_Nome			= ivo_Cliente.Nm_Cliente

If ls_Cliente = '' Then SetNull( ls_Cliente )
If ls_Nome = '' Then setNull(ls_Nome)

If Not IsNull(dw_1.Object.localizacao[ 1 ]) And Trim(dw_1.Object.localizacao[ 1 ]) <> '' Then
	ls_Nome = dw_1.Object.localizacao[ 1 ]
End If

ls_Nome_Aux = ls_Nome

Do	
	SetNull(ls_Tipo_Cliente_Caixa)
	
	If Not IsNull( ls_Matric_Negociacao ) And Trim( ls_Matric_Negociacao ) <> '' Then
		ls_Nome = 'NEG' + io_Cobre_Preco.Matricula_Vendedor + '|' + ls_Nome
	Else
		If Not IsNull( is_Matricula_Vendedor ) And Trim(is_Matricula_Vendedor) <> '' Then
			If IsNull(ls_Nome_Aux) Then
				ls_Nome = is_Matricula_Vendedor + '|' 
			Else
				ls_Nome = is_Matricula_Vendedor + '|' + ls_Nome
			End If
		End If			
	End If
	
	OpenWithParm( w_rl001_controle_venda, ls_Nome )	
	ls_Retorno	=	Message.StringParm
	
	If IsNull(ls_Retorno) Then
		//Pagamento antecipado
		If ps_Tipo_Pagamento_Reserva = 'PA' Or ( ib_Pedido_Disque_Entrega And ib_Reserva_Produto ) Then
			DO
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o n$$HEX1$$fa00$$ENDHEX$$mero da cesta para finalizar o atendimento.", Information!)
				
				//Necess$$HEX1$$e100$$ENDHEX$$rio imnformar a cesta para finalizar o atendimento.		
				OpenWithParm( w_rl001_controle_venda, ls_Nome )	
				ls_Retorno	=	Message.StringParm

			LOOP WHILE IsNull( ls_Retorno )	
		End If
	End If		
		
	If IsNull( ls_Retorno ) And Not isNull( is_Matricula_Negociacao ) Then
		SetNull(is_Matricula_Negociacao)
		SetNull(is_Vendedor_Negociacao)
	End If
	
	If ib_Venda_pbm_clamed 		Then ls_ID_PBM_CLamed = "S"
	If ib_venda_dermaclub 			Then ls_ID_dermaclub = "S"
	If ib_Venda_Portal_Drogaria 	Then 
		ls_ID_Portal_Drogaria = "S"
		ls_CPF_CNPJ = is_CPF_Nao_Identificado
	Else
		SetNull(ls_ID_Portal_Drogaria)
		SetNull(idt_Nascimento)
		SetNull(is_Cartao_Industria_PBM)
		SetNull(is_CPF_Nao_Identificado)
	End If
	If Trim(ls_cliente) = '' Or IsNull(ls_cliente) Then SetNull(ls_ID_dermaclub)
	
	ls_Matricula =	Trim( Mid( ls_Retorno, 1, 6 ) )
	ll_Controle 	=	Long( Mid( ls_Retorno, 7 ) )
	
	ls_Nome 		= ls_Nome_Aux
	
	If Not IsNull( ivo_Cliente.Cd_Dependente ) Then
		ls_Codigo_Dep	= ivo_Cliente.Cd_Dependente
		ls_Nome			= ivo_Cliente.Nm_Dependente
	Else
		SetNull( ls_Codigo_Dep )
	End If
	
	If IsNull( ll_Controle ) Then
		If li_Qtde_Cestas > 0 Then
			This.ib_Conclusao_Atendimento_Pendente = False
			wf_Inicia_Atendimento()
		End If
		
		Exit
	End If
	
	If Not IsNull( ll_Controle ) Then	
		ls_Situacao_cliente_caixa = 'A'
				
		If ib_Painel_Senha Then
			If IsValid( iole_painel_senha ) Then iole_painel_senha.CloseCall( )
		End If
		
		If ib_Pedido_Disque_Entrega And ib_Reserva_Produto Then
			ls_Reserva_com_Disque_Entrega = 'S'
			ls_Situacao_cliente_caixa = is_Situacao_Reserva_Disque_Entrega
		End If
				
		//Grava na tabela roteiro_entrega os dados do pedido disque entrega
		If ib_Pedido_Disque_Entrega Then
			ls_Tipo_Cliente_Caixa = "D"
			
			lsrt_Par_Disq_Entr.cd_cliente						= ivo_cliente.cd_Cliente
			lsrt_Par_Disq_Entr.sequencial_cliente_caixa		= il_Sequencial_Cliente_Caixa
			lsrt_Par_Disq_Entr.nr_matricula_vendedor		= is_Matricula_Vendedor
//			lsrt_Par_Disq_Entr.vl_total_pedido					= dw_2.GetItemDecimal(dw_2.RowCount(), "c_total")
			lsrt_Par_Disq_Entr.vl_total_pedido					= dw_2.GetItemDecimal(dw_2.RowCount(), "c_total_clube")
			
			OpenWithParm( w_ge108_dados_disque_entrega, lsrt_Par_Disq_Entr )			
		
			SqlCa.of_End_Transaction( )
			
			ls_Retorno_Disque = Message.StringParm
			
			If IsNull( ls_Retorno_Disque  ) Then
				ib_Pedido_Disque_Entrega = False
				Exit
			End If		
				
			ldc_Vl_Frete_Disq_Entrega 	= Dec( Mid(ls_Retorno_Disque,1, PosA(ls_Retorno_Disque, "|") - 1) )
			ll_Roteiro_Entrega				= Long( Mid(ls_Retorno_Disque,PosA(ls_Retorno_Disque, "|") + 1) )		
		End If		
		
		If ib_Reserva_Produto OR ( ivi_Qtde_Itens_Reservados > 0 ) Then
			ls_Tipo_Cliente_Caixa = 'R'
			ib_Reserva_Produto = False
			ivi_Qtde_Itens_Reservados = 0
		End If
		
		If li_Qtde_Cestas = 0 Then
			wf_Atualiza_Cliente_Caixa_Produto( ldc_Vl_Frete_Disq_Entrega )
			
			/*,
				id_portal_drogaria			= :ls_ID_Portal_Drogaria
				dh_nascimento				= :idt_Nascimento
				nr_cartao_pbm				= :is_Cartao_Industria_PBM
			*/
						
			Update cliente_caixa set
				nr_ficha						= :ll_controle,
				cd_cliente					= :ls_cliente,
				nm_cliente					= :ls_nome,
				cd_dependente				= :ls_codigo_dep,
				nr_matricula_vendedor	= :ls_Matricula,
				id_situacao 					= :ls_Situacao_cliente_caixa,
				nr_matricula_negociacao	= :ls_Matric_Negociacao,
				id_pbm_clamed			= :ls_ID_PBM_CLamed,
				nr_cpf_cgc					= :ls_CPF_CNPJ,
				nr_cartao_desconto		= :This.is_cartao_desconto,
				id_tipo						= :ls_Tipo_Cliente_Caixa,
				id_dermaclub				= :ls_ID_dermaclub,
				id_portal_drogaria			= :ls_ID_Portal_Drogaria,
				dh_nascimento				= :idt_Nascimento,
				nr_cartao_pbm				= :is_Cartao_Industria_PBM,
				id_disque_entrega			= :ls_Reserva_com_Disque_Entrega
			Where nr_sequencial			= :il_Sequencial_Cliente_Caixa
			Using SqlCa;
		Else		
			
			/*	,
				id_portal_drogaria,
				dh_nascimento,
				nr_cartao_pbm
				,
	 			 :ls_ID_Portal_Drogaria,
				 :idt_Nascimento,
				 :is_Cartao_Industria_PBM	  
				 
				 //ls_Reserva_com_Disque_Entrega usado quando estiver disque entrega com Reserva de produto.
			*/
			
			
			Insert Into cliente_caixa(
				nr_ficha,
				cd_cliente,
				nm_cliente,
				cd_dependente,
				nr_matricula_vendedor,
				id_situacao,
				dh_movimentacao,
				nr_matricula_negociacao,
				id_pbm_clamed,
				nr_cpf_cgc,
				nr_cartao_desconto,
				id_tipo,
				id_dermaclub,
				id_portal_drogaria,
				dh_nascimento,
				nr_cartao_pbm,
				id_disque_entrega
				)
			 Values( :ll_Controle,
						 :ls_Cliente,
						 :ls_Nome,
						 :ls_Codigo_Dep,
						 :ls_Matricula,
						 :ls_Situacao_cliente_caixa,
						 dbo.uf_dh_Parametro(),
						 :ls_Matric_Negociacao,
						 :ls_ID_PBM_CLamed,
						 :ls_CPF_CNPJ,
						 :This.is_cartao_desconto,
						 :ls_Tipo_Cliente_Caixa,
						 :ls_ID_dermaclub,
						 :ls_ID_Portal_Drogaria,
						 :idt_Nascimento,
						 :is_Cartao_Industria_PBM,
						 :ls_Reserva_com_Disque_Entrega
						 )
			Using SqlCa;
		End If
			
		Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_RollBack()
				SqlCa.of_MsgDbError()
				Exit
				
			Case Else
				
				If ib_Pedido_Disque_Entrega Then					
					Update roteiro_entrega
						Set id_situacao = 'P'
						Where nr_sequencial_cliente_caixa = :This.il_sequencial_cliente_caixa
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						SqlCa.of_Rollback();
						SqlCa.of_MsgDbError("Errro ao atualizar a situacao do roteiro entrega. Seq: " + String(This.il_sequencial_cliente_caixa))
					End If
				End If					
			
				//	If IsNull( is_Matricula_Negociacao ) Then
				If dw_2.Find( "id_cobre_preco='S'" , 1, dw_2.RowCount() ) = 0 Then
					SqlCa.of_Commit()
					
					If ib_Pedido_Disque_Entrega Then	
						wf_Imprime_Pedido_Disque_Entrega(ll_roteiro_entrega)
						
						//Finaliza o atendimento
						ib_Pedido_Disque_Entrega = False
						SetNull( This.il_Sequencial_Cliente_Caixa )
						This.ib_Conclusao_Atendimento_Pendente = False
						Close( This )
						Return
					End If
					
					li_Qtde_Cestas++
				Else
		
					If wf_atualiza_cobre_preco() Then
						SqlCa.of_Commit()
						
						If ib_Pedido_Disque_Entrega Then	
							wf_Imprime_Pedido_Disque_Entrega(ll_roteiro_entrega)
							ib_Pedido_Disque_Entrega = False
						End If
					End If

//					If wf_grava_negociacao_cliente( This.il_Sequencial_Cliente_Caixa ) Then
//						SqlCa.of_Commit()
//					End If	
										
					SetNull( This.il_Sequencial_Cliente_Caixa )
					This.ib_Conclusao_Atendimento_Pendente = False
					Close( This )
					Return
				End If		
		End Choose

		SetNull( This.il_Sequencial_Cliente_Caixa )

		li_Mensagem = MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja cadastrar mais uma cesta para o mesmo cliente?", Question!, YesNo!, 2 )
		
		//Inicializa a cesta com o PBM Clamed
		ib_Venda_pbm_clamed 		= False
		ib_Venda_dermaclub 			= False
		ib_Venda_Portal_Drogaria 	= False
				
		If li_Mensagem = 2 Then
			This.ib_Conclusao_Atendimento_Pendente = False
			Close( This )
		End If	
	End If
	
Loop While li_Mensagem = 1
end subroutine

public function boolean wf_pdv_imprime_cupom_pre ();String ls_Valor, ls_Nome_PDV

ls_Nome_PDV = gvo_Aplicacao.is_computername

If Left( ls_Nome_PDV, 1) = 'C' Then
	//Perfil Desenvolvimento ou Marketing pode imprimir cupom pr$$HEX1$$e900$$ENDHEX$$ sem a verifica$$HEX2$$e700e300$$ENDHEX$$o do parametro loja
	If gvo_Aplicacao.ivo_seguranca.cd_perfil_usuario = 99 Or gvo_Aplicacao.ivo_seguranca.cd_perfil_usuario = 16 Then
		Return True
	End If
End If


//Desconsidera PDV_01
If Right(ls_Nome_PDV, 3) = '_01' Then
	Return False
End If

//Rede PP verifica se o PDV possui caixa
If gvo_Parametro.id_rede_filial = 'PP' Then
	If Not gf_is_pdv_Caixa() Then
		Return False
	End If
End If

//Demais rede o padr$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ sempre imprimir
//Olhar o parametro PDV ID_BLOQUEIA_IMPRESSAO_CUPOM_PRE
Select vl_parametro
   Into :ls_Valor
From parametro_pdv
Where cd_filial 			= :gvo_Parametro.cd_filial
 and nm_pdv 			= :ls_Nome_PDV
 and cd_parametro 	= 'ID_BLOQUEIA_IMPRESSAO_CUPOM_PRE'
 Using SqlCa;
 
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_msgdberror( "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro pdv: ID_BLOQUEIA_IMPRESSAO_CUPOM_PRE.")
		Return False
	Case 100
		//Se n$$HEX1$$e300$$ENDHEX$$o existir $$HEX1$$e900$$ENDHEX$$ porque pode imprimir
		//Criado dessa forma para n$$HEX1$$e300$$ENDHEX$$o alterar as lojas PP que j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e300$$ENDHEX$$o imprimindo cupom pr$$HEX1$$e900$$ENDHEX$$.
		Return True
End Choose

/*Valores:
N - IMPRIME
S - N$$HEX1$$c300$$ENDHEX$$O IMPRIME
*/

Return (ls_Valor='N')		
end function

public function boolean wf_verifica_coleta_lgpd_matriz (string ps_cliente, ref boolean pb_coletado);Boolean lb_Sucesso = False

Integer li_Qtde

String ls_Rede

Date ldt_Parametro

Try
	pb_Coletado		= False
	li_Qtde	 		= 0
	ls_Rede 			= gvo_Parametro.id_rede_filial
	ldt_Parametro 	= Date( gf_GetServerDate() )
		
	uo_Transacao_Remota lvo_Conexao
	lvo_Conexao = Create uo_Transacao_Remota
	
	lvo_Conexao.of_BancoProducao()
			
	lvo_Conexao.of_Define_Variaveis(True)
	
	//N$$HEX1$$e300$$ENDHEX$$o olha os registros do tipo atendimento telefonico
	 lvo_Conexao.of_Executa_Rotina('0006', {"select Count(h.cd_cliente) as qt_coleta from historico_coleta_consentimento h inner join filial f on f.cd_filial = h.cd_filial where h.cd_cliente='" +ps_Cliente+ "' and f.id_rede_filial = '" +ls_Rede+ "' and Cast(dh_abertura_tela as date) >= '" + String(ldt_Parametro, 'yyyy/mm/dd') + "' and (Coalesce(id_atendimento_telefonico,'N')= 'N' and Coalesce(id_cliente_titular,'N') = 'S') "} )

	
	If Not lvo_Conexao.of_Erro_Execucao() Then
		If lvo_Conexao.of_Linhas() > 0 Then
			If lvo_Conexao.of_Retorno( 'qt_coleta', Ref li_Qtde ) Then		
				lb_Sucesso = True
			End If
		End If
		
	End If
	
	pb_Coletado = (li_Qtde > 0)
	
	Return lb_Sucesso
Finally
	If IsValid(lvo_Conexao) Then Destroy lvo_Conexao
End Try

end function

public function boolean wf_gera_autorizacao_pbm ();/*
Fun$$HEX2$$e700e300$$ENDHEX$$o EM DESENVOLVIMENTO
*/


Boolean lb_Adiciona_Carrinho = False

String ls_Cartao_Programa
String ls_Cupom_Desconto
String ls_Null
String ls_Cod_Barras
String ls_Obriga_Cupom_Consumidor
String ls_Log
String ls_Adiciona_Carrinho

Long ll_Produto, ll_Qtde

Decimal{2} ldc_Preco_Bruto,  ldc_Preco_Liquido
Decimal{2} ldc_Pc_Desc_Loja

Integer li_Row, li_Linha_Insert, li_Find

Try

	SetNull(ls_Null)
	
	uo_ge570_portal_drogaria_balcao_atendimento io_Portal_Drogaria
	io_Portal_Drogaria = Create uo_ge570_portal_drogaria_balcao_atendimento
	
	uo_ge570_dados_obrigatorios lo_Dados_Obrigatorios
	lo_Dados_Obrigatorios = Create uo_ge570_dados_obrigatorios
	
//	If IsNUll(dw_1.Object.cd_cliente[1]) Or dw_1.Object.cd_cliente[1] = '' Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe um cliente")
//		Return False
//	End If
	
	wf_Verifica_Cupom_Consumidor(Ref ls_Obriga_Cupom_Consumidor) //S/N
	
	//Solicita os Dados Obrigatorios
	OpenWithParm(w_ge570_solicita_dados_obrigatorios, ivo_cliente.nr_cpf_cgc + '|'+ls_Obriga_Cupom_Consumidor)
	
	If IsNull( Message.Powerobjectparm ) Then
		Return False
	End If
	
	lo_Dados_Obrigatorios = Message.Powerobjectparm
	
	io_Portal_Drogaria.is_fone_celular					= lo_Dados_Obrigatorios.nr_fone_celular
	io_Portal_Drogaria.is_fone_fixo						= lo_Dados_Obrigatorios.nr_fone_fixo
	io_Portal_Drogaria.is_email							= lo_Dados_Obrigatorios.de_email
	io_Portal_Drogaria.is_nr_cartao_programa 		= lo_Dados_Obrigatorios.nr_cartao_industria
	
	io_Portal_Drogaria.is_cpf = ivo_cliente.nr_cpf_cgc
	
	For li_Row = 1 To dw_2.RowCount()
		ll_Produto 			= dw_2.Object.cd_produto			[li_Row]	
		ll_Qtde				= dw_2.Object.qt_orcada			[li_Row]
		ldc_Preco_Bruto 	= dw_2.Object.vl_preco_unitario 	[li_Row]
		ldc_Preco_Liquido 	= dw_2.Object.vl_preco_final	 	[li_Row]
		ls_Cod_Barras		= dw_2.Object.de_codigo_barras 	[li_Row]
		ldc_Pc_Desc_Loja	= dw_2.Object.pc_desconto_fixo	[li_Row]
		
		If IsNull( ll_Produto ) Then
			Continue
		End If
		
		//De acordo com o pessoal da interplayer $$HEX1$$e900$$ENDHEX$$ indicado verificar os produtos individulamente devido ao termo LGPD
		io_Portal_Drogaria.ids_produtos_atendimento.Reset()
		
		li_Linha_Insert = io_Portal_Drogaria.ids_produtos_atendimento.Insertrow( 0 )
		io_Portal_Drogaria.ids_produtos_atendimento.Object.cd_produto				[li_Linha_Insert] = ll_Produto
		io_Portal_Drogaria.ids_produtos_atendimento.Object.qt_produto				[li_Linha_Insert] = ll_Qtde
		io_Portal_Drogaria.ids_produtos_atendimento.Object.vl_preco_bruto			[li_Linha_Insert] = ldc_Preco_Bruto
		io_Portal_Drogaria.ids_produtos_atendimento.Object.vl_preco_liquido		[li_Linha_Insert] = ldc_Preco_Liquido
		io_Portal_Drogaria.ids_produtos_atendimento.Object.de_codigo_barras		[li_Linha_Insert] = ls_Cod_Barras	
		io_Portal_Drogaria.ids_produtos_atendimento.Object.pc_desconto_loja		[li_Linha_Insert] = ldc_Pc_Desc_Loja	
		
		lb_Adiciona_Carrinho = io_Portal_Drogaria.of_consulta_produto_cliente( ls_Cartao_Programa, ls_Cupom_Desconto, Ref ls_Log )

		dw_2.Object.id_carrinho_portal_drogaria 	[li_Row] = IIF(lb_Adiciona_Carrinho, 'S', 'N')
		dw_2.Object.de_log_api_portal_drogaria 	[li_Row] = ls_Log
	Next
	
	//Reset na ds
	io_Portal_Drogaria.ids_produtos_atendimento.Reset()
	
	//Processa todos os itens para finalizar o carrinho
	For li_Row = 1 To dw_2.RowCount()
		ll_Produto 				= dw_2.Object.cd_produto						[li_Row]	
		ll_Qtde					= dw_2.Object.qt_orcada						[li_Row]
		ldc_Preco_Bruto 		= dw_2.Object.vl_preco_unitario 				[li_Row]
		ldc_Preco_Liquido 		= dw_2.Object.vl_preco_final	 				[li_Row]
		ls_Cod_Barras			= dw_2.Object.de_codigo_barras 				[li_Row]
		ldc_Pc_Desc_Loja		= dw_2.Object.pc_desconto_fixo				[li_Row]
		ls_Adiciona_Carrinho 	= dw_2.Object.id_carrinho_portal_drogaria	[li_Row]
		ls_Log					= dw_2.Object.de_log_api_portal_drogaria 	[li_Row]
		
		If IsNull( ll_Produto ) 				Then Continue //Linha Vazia
		//If ls_Adiciona_Carrinho <> 'S' 	Then Continue //Produto que n$$HEX1$$e300$$ENDHEX$$o foi aceito pelo pbm Ex. Sem cadastro, limite de compra atingido
		
		li_Linha_Insert = io_Portal_Drogaria.ids_produtos_atendimento.Insertrow( 0 )
		io_Portal_Drogaria.ids_produtos_atendimento.Object.cd_produto				[li_Linha_Insert] = ll_Produto
		io_Portal_Drogaria.ids_produtos_atendimento.Object.qt_produto				[li_Linha_Insert] = ll_Qtde
		io_Portal_Drogaria.ids_produtos_atendimento.Object.vl_preco_bruto			[li_Linha_Insert] = ldc_Preco_Bruto
		io_Portal_Drogaria.ids_produtos_atendimento.Object.vl_preco_liquido		[li_Linha_Insert] = ldc_Preco_Liquido
		io_Portal_Drogaria.ids_produtos_atendimento.Object.de_codigo_barras		[li_Linha_Insert] = ls_Cod_Barras	
		io_Portal_Drogaria.ids_produtos_atendimento.Object.pc_desconto_loja		[li_Linha_Insert] = ldc_Pc_Desc_Loja	
		
		io_Portal_Drogaria.ids_produtos_atendimento.Object.id_envia_carrinho		[li_Linha_Insert] = ls_Adiciona_Carrinho	
		io_Portal_Drogaria.ids_produtos_atendimento.Object.de_log_api				[li_Linha_Insert] = ls_Log			
	Next
	
	io_Portal_Drogaria.il_Sequencial_Cliente_Caixa = il_Sequencial_Cliente_Caixa
	
	If io_Portal_Drogaria.of_finaliza_carrinho() Then
		//lo_checkout.is_nr_autorizacao = io_Portal_Drogaria.is_nr_autorizacao
		//lo_checkout.of_efetiva_transacao( )
	End If
	
	//io_Portal_Drogaria.of_processa_erro( '' )
		
	Return True

	
Catch (RunTimeError lo_error)
	MessageBox("Erro", "Erro ao gerar a autoriza$$HEX2$$e700e300$$ENDHEX$$o Portal Drogaria.~r~rLog Error " + lo_error.GetMessage())
	io_Portal_Drogaria.io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(io_Portal_Drogaria) 		Then Destroy io_Portal_Drogaria
	If IsValid(lo_dados_obrigatorios) 	Then Destroy lo_dados_obrigatorios
End Try

end function

public function boolean wf_verifica_cupom_consumidor (ref string as_obrigada_cupom_consumidor);//Fun$$HEX2$$e700e300$$ENDHEX$$o usado na integra$$HEX2$$e700e300$$ENDHEX$$o com o Portal Drogaria

Integer li_Row
String ls_Valor
Long ll_Produto

dw_2.AcceptText()

as_obrigada_cupom_consumidor = 'N'

For li_Row = 1 To dw_2.RowCount()
	ll_Produto = dw_2.Object.cd_produto	[li_Row]	
	
	If IsNull( ll_Produto ) Then
		Continue
	End If
	
	Select id_utiliza_cartao_consumidor
		Into:ls_Valor
	From pbm_produto
		Where cd_pbm 	 = 175
  		    and cd_produto = :ll_Produto
		Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1	
			SqlCa.of_msgdberror( "Erro ao localizar a tabela pbm_produto. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_verifica_cupom_consumidor()")
			gvo_Aplicacao.of_grava_log( "Erro ao localizar a tabela pbm_produto. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_verifica_cupom_consumidor(). " + SqlCa.sqlerrtext )
			Return False
		Case 100
			//Produto n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ pbm
			Continue
		Case 0
			If ls_Valor = 'M' Then //MANDAT$$HEX1$$d300$$ENDHEX$$RIO
				as_obrigada_cupom_consumidor = 'S'		
				Exit
			End If
	End Choose

Next

Return True
end function

public subroutine wf_localiza_cliente (boolean ab_ultimo_cliente_atendido);Boolean lb_Cpf_Valido
Boolean lb_Imprime_Desconto_PreVenda
Boolean lb_Cupom_Impresso
Boolean lvb_Atualizar_Consentimento 	= False
Boolean lb_Possui_Caixa 					= False
Boolean lb_Coleta_Realizada				= False

Long ll_Produto_Campanha
Long ll_Campanha
Long ll_Saldo
Long ll_Linha

String lvs_Localizacao
String lvs_Fase_Atualizacao
String ls_Produto_Campanha
String ls_Cpf
String ls_Cpf_Cnpj_Format
String ls_Retorno

dw_1.AcceptText()

//gvo_Aplicacao.of_grava_log( "--entrou na funcao wf_localiza_cliente")

lvs_Localizacao = Trim(dw_1.Object.localizacao[1])

If LenA( lvs_Localizacao ) = 11 And IsNumber( lvs_Localizacao ) Then
	ivo_Cliente.of_Localiza_Cpf( lvs_Localizacao )
	//Se o cliente foi pesquisado pela funcao Busca_Ultimo_Cliente
	//Deve atualizar com base na var Global gvs_Forma_Busca_Cliente
	If ab_ultimo_cliente_atendido Then
		is_forma_atendimento = gvs_Forma_Busca_Cliente
	Else
		is_forma_atendimento 		= CPF
		gvs_Forma_Busca_Cliente 	= CPF
	End If
Else		
	ivo_Cliente.of_Localiza_Cliente( lvs_Localizacao )
	is_forma_atendimento = NOME
	gvs_Forma_Busca_Cliente = NOME
End If

If ivo_Cliente.Localizado Then
	
	//gvo_Aplicacao.of_grava_log( "cliente localizado: " + ivo_Cliente.cd_cliente)
	
	If ivo_cliente.nr_cpf_cgc = is_cpf_vendedor Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Conforme Art. 6$$HEX1$$ba00$$ENDHEX$$ do Manual do Colaborador. ~n" + &
										"Cliente da venda n$$HEX1$$e300$$ENDHEX$$o pode ser o Vendedor.", Exclamation! )
		ivo_Cliente.of_Inicializa()		//Limpa dw_1		
		dw_1.Event ue_Pos( dw_1.GetRow(), 'localizacao' )	
		Return
	End If						
	
	If ivo_Cliente.Falecido Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente marcado como falecido", Exclamation!)
		ivo_Cliente.of_Inicializa()		//Limpa dw_1
	End If
		
	If ivo_Cliente.Id_Fisica_Juridica = 'F' Then
		ls_Cpf_Cnpj_Format = Mid(ivo_Cliente.Nr_Cpf_Cgc, 1,3) + "******" + Mid(ivo_Cliente.Nr_Cpf_Cgc, 10,2)
	Else
		ls_Cpf_Cnpj_Format = Mid(ivo_Cliente.Nr_Cpf_Cgc, 1,5) + "*******" + Mid(ivo_Cliente.Nr_Cpf_Cgc, 13,2)		
	End If
			
	dw_1.Object.Localizacao			[1] = ivo_Cliente.Nm_Cliente
	dw_1.Object.Cd_Cliente			[1] = ivo_Cliente.Cd_Cliente
	dw_1.Object.Id_Tipo				[1] = ivo_Cliente.Id_Tipo_Cliente
	dw_1.Object.Nr_Cpf				[1]	 = ls_Cpf_Cnpj_Format
	dw_1.Object.Nm_Dependente	[1] = ivo_Cliente.Nm_Dependente
	dw_1.Object.Cd_Dependente	[1] = ivo_Cliente.Cd_Dependente		
	
	//Retorna ap$$HEX1$$f300$$ENDHEX$$s limpar os campos da dw_1
	//N$$HEX1$$e300$$ENDHEX$$o deixa selecionar o cliente
	If ivo_Cliente.Falecido Then
		dw_1.Event ue_Pos( dw_1.GetRow(), 'localizacao' )	
		Return
	End If	
	
	//dw_1.Object.localizacao			[1] = ''
	
	//Usado no menu Buscar Ultimo Cliente
	gvs_Ultimo_Cliente_Atendido = ivo_Cliente.nr_cpf_cgc
	
	//Inicializa o cliente cadastrado
	gvs_Cliente_Cadastro = ''	
	
	If ivo_Cliente.Id_Fisica_Juridica = 'F' Then
		
		//CP = id_tipo_campanha = Cupom Pr$$HEX1$$e900$$ENDHEX$$
		//Importa da matriz 
		gf_ge039_importa_campanha_cliente(ivo_Cliente.Cd_Cliente, 'CP')
		
		//1 cupom pr$$HEX1$$e900$$ENDHEX$$ emitido por dia
		If Not wf_cupom_pre_ja_emitido(ivo_Cliente.cd_cliente, Ref lb_Imprime_Desconto_PreVenda) Then Return
		
		If lb_Imprime_Desconto_PreVenda Then
			//Clientes cadastrados no mesmo dia n$$HEX1$$e300$$ENDHEX$$o ter$$HEX1$$e300$$ENDHEX$$o impresso o desconto pre-venda
			If Date(ivo_Cliente.dh_inclusao) <> Date(gvo_Parametro.dh_movimentacao) Then								
				//Se o pdv estiver marcado p/ imprimir o cupom pre
				If wf_PDV_Imprime_Cupom_Pre() Then									 
					//Se houver erro na consulta com o distribuido, verificar tamb$$HEX1$$e900$$ENDHEX$$m na base local. 
					gf_ge039_cupom_pre_venda( ivo_Cliente.Cd_Cliente, is_Matricula_Vendedor, Ref lb_Cupom_Impresso)
				End If
			End If
		End If
						
		dw_1.Object.Nr_Cpf.Width = 465
	
		lb_Cpf_Valido = gf_nr_cpf_valido_sem_mensagem(ivo_Cliente.Nr_Cpf_Cgc)
	
		If wf_Localiza_Dados_Distribuido() Then
						
			//Verifica campanha promocional
			wf_Verifica_Campanha_Promocional()
			//gvo_Aplicacao.of_grava_log( "Passou pela funcao wf_Verifica_Campanha_Promocional")
			
			// Se for dependente, n$$HEX1$$e300$$ENDHEX$$o solicita atualiza$$HEX2$$e700e300$$ENDHEX$$o
			If IsNull( ivo_Cliente.Cd_Dependente ) Then

				// Verifica Campanha Atualiza$$HEX2$$e700e300$$ENDHEX$$o Cadastral
				If gf_Verifica_Campanha(ivo_Cliente.Cd_Cliente,  gvo_Parametro.cd_filial, Ref ll_Campanha  ) Then					
					OpenWithParm(w_rl001_cadastro_cliente_pf_campanha, ivo_Cliente.Cd_Cliente +  is_Fase_Atualizacao_Cliente +  String(ll_Campanha)  )					
				Else					
					If ( is_Fase_Atualizacao_Cliente <> 'N' And IsNull( idh_Atualizacao_Fase_Cliente ) ) Or lb_Cpf_Valido = False Then
						If ( ( Date( idh_Solicitou_Atualizacao_Cliente ) < Date( gvo_Parametro.of_Dh_Movimentacao() ) ) &
							Or IsNull( idh_Solicitou_Atualizacao_Cliente ) ) Or lb_Cpf_Valido = False Then
							
							If Not lb_Cpf_Valido Then is_Fase_Atualizacao_Cliente = '1'
							
							If is_Fase_Atualizacao_Cliente <> '3' Then
								If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cadastro deste cliente precisa ser atualizado.~r" + &
																	"Clique em Sim para atualizar agora ou clique em N$$HEX1$$e300$$ENDHEX$$o para atualizar mais tarde.", &
																	Question!, YesNo! ) = 1 Then
									OpenWithParm(w_rl001_cadastro_cliente_pf_response, ivo_Cliente.Cd_Cliente + is_Fase_Atualizacao_Cliente)
									
									ls_Cpf = Message.StringParm
		
									If Not IsNull(ls_Cpf) Or Trim(ls_Cpf) <> "" Then
										dw_1.Object.Localizacao[1] = ls_Cpf
										wf_Localiza_Cliente()
									End If
								Else
									uo_Cliente_Central lo_Cliente_Central
									lo_Cliente_Central = Create uo_Cliente_Central
									lo_Cliente_Central.of_Atualiza_Fase_Atualizacao( ivo_Cliente.Cd_Cliente, False )
									Destroy lo_Cliente_Central
								End If
								
							Else
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cadastro deste cliente precisa ser atualizado.~rVerifique o CEP correto para atualizar.")
								OpenWithParm(w_rl001_cadastro_cliente_pf_response, ivo_Cliente.Cd_Cliente + is_Fase_Atualizacao_Cliente)
										
								ls_Cpf = Message.StringParm
		
								If Not IsNull(ls_Cpf) Or Trim(ls_Cpf) <> "" Then
									dw_1.Object.Localizacao[1] = ls_Cpf
									wf_Localiza_Cliente()
								End If
							End If
						End If
						
					Else
						//LGPD
						//Verifica na base local se falta aceite nos tipos de aviso
						If Not gf_consentimento_pendente( ivo_Cliente.Cd_Cliente, gvo_Parametro.id_rede_filial, Ref lvb_Atualizar_Consentimento ) Then
							gvo_Aplicacao.of_grava_log( "GE108: wf_localiza_cliente(): Erro ao verificar os consentimentos pendentes no bd local. CLiente:" + ivo_Cliente.Cd_Cliente)
							Return
						End If
						
						If lvb_Atualizar_Consentimento Then
							
							//Verifica na matriz se o cliente ja realizou a coleta de consentimento em outra loja da mesma rede
							If Not wf_Verifica_Coleta_LGPD_Matriz( ivo_Cliente.Cd_Cliente, Ref lb_Coleta_Realizada ) Then
								gvo_Aplicacao.of_grava_log( "GE108: wf_localiza_cliente(): Erro ao verificar a coleta dos consentimentos via distribuido.")
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao verificar a coleta dos consentimentos via distribuido.")
							End If
							
							If Not lb_Coleta_Realizada Then
								If gf_Verifica_Campanha('CO', ivo_Cliente.Cd_Cliente,  gvo_Parametro.cd_filial, Ref ll_Campanha  ) Then					
																								
									//Vai solicitar a confirma$$HEX2$$e700e300$$ENDHEX$$o somente se for um pdv com pinpad instalado
									If gf_ge084_pinpad_localizado() Then
										OpenWithParm( w_ge548_consentimento, 'N' + ivo_Cliente.Cd_Cliente )
										ls_Retorno = Message.Stringparm
									End If
								End If
							End If	
						End If // lvb_Atualizar_Consentimento
						
					End If //Atualiza$$HEX2$$e700e300$$ENDHEX$$o por fase
					
				End If			
			End If	
		End If		
	Else
		dw_1.Object.Nr_Cpf.Width = 560
	End If	// If ivo_Cliente.Id_Fisica_Juridica = 'F' Then
	
	//******************************************************************* Deixar os 2 && para n$$HEX1$$e300$$ENDHEX$$o destacar a letra do atalho (ALT)
	dw_1.Object.gb_Cliente.Text = "Tipo Cliente: " + IIF( ivo_Cliente.ivs_tipo_cliente = "CC", "FIDELIDADE && PRAZO", 'FIDELIDADE' )
	
	dw_2.Event ue_AddRow()
	dw_1.Event ue_Pos( 1, 'nm_convenio' )	
End If

//gvo_Aplicacao.of_grava_log( "--Final da funcao wf_localiza_cliente")

end subroutine

public subroutine wf_consulta_desconto_portal_drogaria (ref boolean ab_produto_portal);String ls_Cod_Barras
String ls_Integra_API

Decimal ldc_Preco_Liquido, ldc_Preco_Bruto
Decimal ldc_Pc_Desc_Fixo

Integer li_Row, li_Linha_Insert, li_Existe

Long ll_Produto, ll_PBM_PORTAL

Try
	ab_produto_portal = False	
	
	//Verifica se a loja esta fazendo integracao com a API portal drogaria
	ivo_parametro.of_localiza_parametro( 'ID_INTEGRA_PORTAL_DROGARIA', ref ls_Integra_API)
	
	If ls_Integra_API <> 'S' Then
		Return
	End If
	
	ll_PBM_PORTAL = 175
	
	dw_2.AcceptText()
	
	li_Row = dw_2.GetRow()
	
	ll_Produto 			= dw_2.Object.cd_produto			[li_Row]	
	ldc_Preco_Bruto 	= dw_2.Object.vl_preco_unitario 	[li_Row]
	ldc_Preco_Liquido 	= dw_2.Object.vl_preco_final	 	[li_Row]
	ls_Cod_Barras		= dw_2.Object.de_codigo_barras 	[li_Row]
	ldc_Pc_Desc_Fixo	= dw_2.Object.pc_desconto_fixo 	[li_Row]
	
	If IsNull( ll_Produto ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto selecionado.",Exclamation!)
		Return
	End If
	
	If IsNull(ls_Cod_Barras) Or Trim(ls_Cod_Barras) = '' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto selecionado n$$HEX1$$e300$$ENDHEX$$o possui c$$HEX1$$f300$$ENDHEX$$digo de barras cadastrado.",Exclamation!)
		Return
	End If
	
	Select Count(cd_produto)
		into :li_Existe
		from pbm_produto
	where cd_pbm 			= :ll_PBM_PORTAL
		and cd_produto 	= :ll_Produto
		Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		gvo_aplicacao.of_grava_log( "Erro na localizacao do produto " + String (ll_Produto) + " na tabela pbm_produto, cd_pbm = " + String(ll_PBM_PORTAL))
		SqlCa.of_msgdberror( "Erro na localizacao do produto " + String (ll_Produto) + " na tabela pbm_produto, cd_pbm = " + String(ll_PBM_PORTAL))
		Return
	End If
	
	ab_Produto_Portal = (li_Existe > 0)
	
	If Not ab_Produto_Portal Then
		Return
	End If
	
	uo_ge570_portal_drogaria_balcao_atendimento lo_Consulta
	lo_Consulta = Create uo_ge570_portal_drogaria_balcao_atendimento
	
	//De acordo com o pessoal da interplayer $$HEX1$$e900$$ENDHEX$$ indicado verificar os produtos individulamente devido ao termo LGPD
	lo_Consulta.ids_produtos_atendimento.Reset()
	
	li_Linha_Insert = lo_Consulta.ids_produtos_atendimento.Insertrow( 0 )
	lo_Consulta.ids_produtos_atendimento.Object.cd_produto			[li_Linha_Insert] = ll_Produto
	lo_Consulta.ids_produtos_atendimento.Object.qt_produto			[li_Linha_Insert] = 1
	lo_Consulta.ids_produtos_atendimento.Object.vl_preco_bruto		[li_Linha_Insert] = ldc_Preco_Bruto
	lo_Consulta.ids_produtos_atendimento.Object.vl_preco_liquido		[li_Linha_Insert] = ldc_Preco_Liquido
	lo_Consulta.ids_produtos_atendimento.Object.de_codigo_barras	[li_Linha_Insert] = ls_Cod_Barras
	lo_Consulta.ids_produtos_atendimento.Object.pc_desconto_loja	[li_Linha_Insert] = ldc_Pc_Desc_Fixo
	
	lo_Consulta.of_consulta_produto( ls_Cod_Barras, ldc_Preco_Bruto, ldc_Preco_Liquido)
	
Finally
	If IsValid(lo_Consulta) Then Destroy lo_Consulta
End Try
end subroutine

public subroutine wf_existe_produtos_pbm_portal_drogaria (ref boolean ab_pbm_portal_drogaria, ref boolean ab_informa_cartao, ref boolean ab_informa_cpf);Integer li_Row, li_Linhas, li_Contador_Prd, li_Contador_Cartao, li_Contador_Cpf

Long ll_Produto

String ls_utiliza_Cartao, ls_utiliza_CPF
String ls_Vl_Parametro

ivo_parametro.of_localiza_parametro( "ID_INTEGRA_PORTAL_DROGARIA", ref ls_Vl_Parametro )

If ls_Vl_Parametro = 'N' Then
	ab_pbm_portal_drogaria = False
	ab_informa_cartao 		= False
	ab_informa_CPF			= False
	Return
End If

ab_pbm_portal_drogaria = False
ab_informa_cartao		= False
ab_informa_cpf				= False

li_Linhas = dw_2.RowCount()

If li_Linhas = 0 Then Return

li_Contador_Prd		= 0
li_Contador_Cartao	= 0
li_Contador_Cpf		= 0

For li_Row = 1 To li_Linhas
	ll_Produto = dw_2.Object.cd_produto[li_Row]
	
	If IsNull(ll_Produto) Then Continue
	
	Select id_utiliza_Cartao_Consumidor, id_utiliza_cpf
	 into :ls_utiliza_Cartao, :ls_utiliza_CPF
	 from pbm_produto 
	 where cd_pbm 	= 175
	 and cd_produto 	= :ll_Produto
	Using sqlCa;
	 
	 Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError("Fun$$HEX2$$e700e300$$ENDHEX$$o: of_produto_pbm_portal_drogaria() - Erro ao localizar o produto " +String(ll_Produto) + " no PBM do Portal Drogaria")		
			Return	
			
		Case 0
			li_Contador_Prd++ //Produto Portal Drogaria
			
			If ls_utiliza_Cartao = 'M' Then
				li_Contador_Cartao++ //Produto Necessita do Cartao da Industria
			End If
			
			If ls_utiliza_CPF = 'M' Then
				li_Contador_Cpf++ //Produto Necessita do Cartao da Industria
			End If
	End Choose
	
Next

ab_pbm_portal_drogaria = ( li_Contador_Prd 		> 0 )
ab_informa_cartao 		= ( li_Contador_Cartao 	> 0 )
ab_informa_CPF	 		= ( li_Contador_Cpf	 	> 0 )

Return

end subroutine

public subroutine wf_atualiza_cliente_caixa_produto (decimal adc_vl_frete);

//SOMENTE DISQUE ENTREGA
If Not ib_Pedido_Disque_Entrega Then
	Return
End If

Long ll_Produto_Frete
Long ll_Linha
Long ll_Linhas
Long ll_Filial_Transferencia

Integer li_Seq

String ls_Situacao

ll_Linhas = dw_2.RowCount( )

//Disque entrega com reserva, a situacao da reserva $$HEX1$$e900$$ENDHEX$$ gravada na ue_finalizar_reserva()
For ll_Linha = 1 To ll_Linhas
	li_Seq 						= dw_2.Object.nr_Seq_Cliente_Caixa_Prd	[ ll_Linha ]	
	ll_Filial_Transferencia	 	= dw_2.Object.cd_filial_reserva				[ ll_Linha ]	

	UPDATE cliente_caixa_produto
	SET id_situacao = 'A'
	WHERE cd_filial = dbo.uf_filial_parametro( )
	AND nr_sequencial_cliente_caixa 	= :il_Sequencial_Cliente_Caixa
	AND nr_sequencial 					= :li_Seq
	AND id_situacao 						not in ('T', 'R')
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError( )
		Exit
	End If
Next

If ib_Pedido_Disque_Entrega Then
	If adc_Vl_Frete > 0 Then //Insere o produto FRETE apenas se o valor de frete for maio que zero
		ll_Produto_Frete = ivo_produto.cd_produto_frete
	
		//Insere o produto frete na tabela cliente_caixa_produto)
		il_seq_cliente_caixa_prd++
		
		INSERT INTO cliente_caixa_produto( cd_filial, nr_sequencial_cliente_caixa, nr_sequencial, cd_produto, qt_produto, id_situacao, vl_preco_unitario, qt_saldo_atual )
		VALUES ( dbo.uf_filial_parametro( ), :il_Sequencial_Cliente_Caixa, :il_seq_cliente_caixa_prd, :ll_Produto_Frete , 1, 'A', :adc_Vl_Frete, 1 )
		USING SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack( )
			SqlCa.of_MsgDbError( "Erro ao inserir o produto Frete.")
		End If
	End If
End If
end subroutine

on w_ge108_consulta_preco.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_ge108_atendimento_cliente" then this.MenuID = create m_ge108_atendimento_cliente
this.dw_8=create dw_8
this.dw_7=create dw_7
this.dw_5=create dw_5
this.dw_saveas=create dw_saveas
this.dw_atalhos=create dw_atalhos
this.gb_7=create gb_7
this.gb_4=create gb_4
this.dw_2=create dw_2
this.dw_3=create dw_3
this.pb_1=create pb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_5=create gb_5
this.dw_4=create dw_4
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_8
this.Control[iCurrent+2]=this.dw_7
this.Control[iCurrent+3]=this.dw_5
this.Control[iCurrent+4]=this.dw_saveas
this.Control[iCurrent+5]=this.dw_atalhos
this.Control[iCurrent+6]=this.gb_7
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.dw_3
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_5
this.Control[iCurrent+14]=this.dw_4
this.Control[iCurrent+15]=this.dw_1
end on

on w_ge108_consulta_preco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_8)
destroy(this.dw_7)
destroy(this.dw_5)
destroy(this.dw_saveas)
destroy(this.dw_atalhos)
destroy(this.gb_7)
destroy(this.gb_4)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.pb_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_5)
destroy(this.dw_4)
destroy(this.dw_1)
end on

event close;call super::close;If IsValid(ivo_produto)   				Then Destroy(ivo_produto)
If IsValid(ivo_vendedor)  			Then Destroy(ivo_vendedor)
If IsValid(ivo_Parametro) 			Then Destroy(ivo_Parametro)
If IsValid(ivo_Cliente) 				Then Destroy( ivo_Cliente )
If IsValid(io_Convenio)				Then Destroy(io_Convenio)
If IsValid(io_condicao_convenio) 	Then Destroy(io_condicao_convenio)

If IsValid( ids_Negociacao ) 			Then Destroy ids_Negociacao 
If IsValid( ids_Negociacao_Aux ) 	Then Destroy ids_Negociacao_Aux
If IsValid( io_Cobre_Preco ) 		Then Destroy io_Cobre_Preco
If IsValid( ids_contratos_bin ) 		Then Destroy ids_contratos_bin
If Isvalid( ivo_dermaclub )			Then Destroy ivo_dermaclub
If Isvalid( io_Produto_Geral )		Then Destroy io_Produto_Geral

	
If IsValid( iole_painel_senha ) Then
	iole_painel_senha.DisconnectObject()
	Destroy iole_painel_senha 
End If

If IsValid( iole_painel_senha_2 ) Then
	iole_painel_senha_2.DisconnectObject()
	Destroy iole_painel_senha_2
End If

If IsValid( io_ge108_reserva_produtos ) Then Destroy io_ge108_reserva_produtos

//gvo_Aplicacao.of_grava_log( "Fechou a Tela F2")
end event

event ue_cancel;call super::ue_cancel;This.SetReDraw(False)

dw_5.Event ue_Cancel()

dw_7.Event ue_Cancel()
dw_8.Event ue_Cancel()
dw_1.Event ue_Cancel()
dw_2.Event ue_Cancel()
//dw_4.Event ue_Cancel()

This.SetReDraw(True)
end event

event ue_postopen;call super::ue_postopen;String ls_Valor, ls_Caixa
String ls_Vl_Parametro
Decimal ldc_Pc_Negociacao
String lvs_Verificacao_Datas
String lvs_valor_brinde

Try
	ivo_produto   = Create uo_ge108_produto
	ivo_Vendedor  = Create uo_vendedor // GE013
	ivo_parametro = Create uo_parametro_filial
	io_Produto_Geral = Create uo_produto
	ivo_Cliente = Create uo_Cliente
	ivo_Cliente.of_Inicializa()
	
	io_Convenio = Create uo_Convenio
	io_condicao_convenio = Create uo_condicao_venda_convenio
	ivo_dermaclub = Create uo_ge536_dermaclub_loja
	ids_contratos_bin = Create dc_uo_ds_base
	
	//io_Cobre_Preco = Create uo_rl154_parametros
	
	ivo_Produto.ivb_nao_liberado_filial = False
	
	dw_1.of_SetMenu(This.ivm_Menu)
	dw_2.of_SetMenu(This.ivm_Menu)
	
	dw_5.Visible  = False
	
	SetNull(ivl_Produto_Busca_Facil)
	
	//This.ivm_menu.m_Janela.m_20_menu_atedimento_cliente.Visible = True
	
	ivo_parametro.of_localiza_parametro( 'ID_UTILIZA_LISTA_TECNICA', ref is_utiliza_lista_tecnica)
	
	ivo_parametro.of_localiza_parametro( 'ID_DISQUE_ENTREGA', ref ib_Loja_Disque_Entrega )
	
	ivo_parametro.of_localiza_parametro( 'ID_DERMACLUB_ATIVO', ref ib_Dermaclub_ativo )
	
	//Verifica pedido ecommerce pendente
	Timer(180)
	
	dw_Atalhos.InsertRow(0)
	
	Try
		uo_parametro_filial lo_parametro // GE036
		lo_parametro = create uo_parametro_filial
		//lo_parametro.of_localiza_parametro( 'ID_OBRIGA_INFORMAR_USUARIO_ATEND_GE108', ref ls_Vl_Parametro, False )
		lo_parametro.of_localiza_parametro( 'ID_BRINDE_F3', ref is_brinde_ativo, False )
		lo_parametro.of_localiza_parametro( 'VL_CONTROLE_BRINDE', ref lvs_valor_brinde, False )
		
		//If IsNull( ls_Vl_Parametro ) Then ls_Vl_Parametro = 'N'
		
		//This.ib_OBRIGA_INFORMAR_USUARIO_ATEND_GE108 = ( ls_Vl_Parametro = 'S' )
		
		If Not IsNull(lvs_valor_brinde) And Trim(lvs_valor_brinde) <> '' Then
			If IsNumber(lvs_valor_brinde) And Dec(lvs_valor_brinde) > 0 Then
				idc_brinde = Dec(lvs_valor_brinde)
			Else
				is_brinde_ativo = 'N'
			End If
		Else
			is_brinde_ativo = 'N'
		End If		
		
	Catch( runtimeerror ru1 )
		MessageBox( "Runtimeerror", ru1.getMessage( ), StopSign! )
		
	Finally
		destroy lo_parametro
	End Try
	
	
	iole_painel_senha		= Create OleObject
	iole_painel_senha_2	= Create OleObject
	
	uo_parametro_filial lo
	lo = Create uo_parametro_filial
	lo.of_localiza_parametro( 'DE_SERVIDOR_PAINEL_SENHA', ref ls_Valor, False )
		
	If Not IsNull( ls_Valor ) And Trim( ls_Valor ) <> "" Then
		This.wf_Driver_painel_senha( )
		
		io_parametro_pdv  = Create uo_parametro_pdv	
		ls_Caixa = io_parametro_pdv.of_Get_Cd_Caixa( )
		
		If ls_Caixa <> '*' Then
			This.il_Caixa = Long( RightA( ls_Caixa, 2 ) )
		End If
	
		If wf_ConnectToNewObject( iole_painel_senha, 'LibMig.ServerMig' ) Then
			If wf_ConnectToNewObject( iole_painel_senha_2, 'LibMigCfg.MigCfg' ) Then
				This.ib_Painel_Senha = True
				
				iole_painel_senha._serverIp		= ls_Valor
				iole_painel_senha_2._serverIp	= ls_Valor
		
				istr_painel_senha.uo_painel_senha	= iole_painel_senha
				istr_painel_senha.uo_painel_senha_2	= iole_painel_senha_2
				istr_painel_senha.nr_caixa				= This.il_Caixa
				istr_painel_senha.uo_parametro_pdv	= io_parametro_pdv
			End If
		End If
	End If
	
Catch( RuntimeError ru )
	MessageBox( 'RuntimeError'	, ru.getMessage( ) )
Finally
	Destroy lo
End Try

dw_2.ivo_Controle_Menu.of_Incluir(True)
dw_2.ivo_Controle_Menu.of_Excluir(True)

dw_1.ivo_Controle_Menu.of_Incluir(True)
dw_2.ivm_menu.m_legendas.visible 						= True

//Comentado por Wagner
//dw_2.ivm_menu.m_atendimentoaocliente.visible 		= True
//dw_2.ivm_menu.m_atendimentoaocliente.Enabled		= True
//ivm_menu.m_atalhos.m_atalhos_f9.Text = is_Legenda_Menu_F9
//ivm_menu.m_atalhos.m_atalhos_f6.Text = is_Legenda_Menu_F6

This.ivm_Menu.ivb_Permite_Imprimir = True

dw_1.Event ue_Cancel()
dw_7.Event ue_AddRow()
dw_8.Event ue_AddRow()
dw_3.Event ue_AddRow()
//dw_4.Event ue_AddRow()
dw_2.Event ue_Cancel()

ivm_Menu.mf_Incluir(True)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

//Negociacao Cliente
SetNull(is_Matricula_Negociacao)
SetNull(is_Vendedor_Negociacao)
is_Permite_Negociacao = 'N'
If ivo_Parametro.of_localiza_parametro( 'ID_COBRE_PRECO', ref ls_Vl_Parametro , False) Then
	If ls_Vl_Parametro = 'S' Then
		is_Permite_Negociacao = 'S'			
	End If
End If

If is_Permite_Negociacao <> 'S' Then
	m_ge108_atendimento_cliente.m_ge108_atendimentoaocliente.m_cobrepreco.Visible 							= False	
	m_ge108_atendimento_cliente.m_ge108_atendimentoaocliente.m_cobrepreco.Enabled 							= False
	m_ge108_atendimento_cliente.m_ge108_atendimentoaocliente.m_cobrepreco.ToolbarItemVisible 			= False
	m_ge108_atendimento_cliente.m_ge108_atendimentoaocliente.m_20_menu_atedimento_cliente.Visible 	= False
End If

If Not ivo_Parametro.of_localiza_parametro( 'ID_MOSTRA_MSG_SALDO_ZERO_GE108', ref is_Mostra_Msg_Saldo_Zero , False) Then
	is_Mostra_Msg_Saldo_Zero = 'N'
End If

If Not gf_Data_Pdv_Correta( ref lvs_Verificacao_Datas ) Then
	If Long( String( now(), "hh" ) ) > 2 Then
		 MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Verificacao_Datas )
	End If
End If

If gvo_Parametro.id_rede_filial = 'DC' Or gvo_Parametro.id_rede_filial = 'MP' Or gvo_Parametro.id_rede_filial = 'CP' Then 
	dw_1.Object.qt_pontos_t.Visible	= True
	dw_1.Object.qt_Pontos.Visible		= True
End If
	
dw_1.Object.F3_t.Visible 			= True
dw_1.Object.INS_t.Visible			= True
dw_1.Object.END_t.Visible			= True
dw_1.Object.ESC_t.Visible			= True

//If is_Permite_Negociacao = 'S' Then dw_1.Object.negociar_t.Visible	= True

io_ge108_reserva_produtos = Create uo_ge108_reserva_produtos

//Campanhas do cliente	
ids_Prd_Campanha_Cliente = Create dc_uo_ds_base
If Not ids_Prd_Campanha_Cliente.of_ChangeDataObject( 'ds_ge108_consulta_campanha_cliente' ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no evento of_ChangeDataObject, ds_ge108_consulta_campanha_cliente.")
	Return
End If

dw_1.Event ue_Pos( 1, 'localizacao' )

wf_verifica_pedido_ecommerce_pendente()
wf_verifica_caixa_nao_finalizado()

wf_Inicia_Atendimento( )

SqlCa.of_End_Transaction( )

gvo_Aplicacao.of_grava_log( "Abriu a Tela F2")
end event

event ue_printimmediate;call super::ue_printimmediate;If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A impress$$HEX1$$e300$$ENDHEX$$o do or$$HEX1$$e700$$ENDHEX$$amento somente deve ser feita para fins judiciais.~rConfirma a impress$$HEX1$$e300$$ENDHEX$$o?", Question!, YesNo!, 2 ) = 1 Then
	wf_imprime_orcamento_judicial(True)
End If


end event

event ue_print;call super::ue_print;If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A impress$$HEX1$$e300$$ENDHEX$$o do or$$HEX1$$e700$$ENDHEX$$amento somente deve ser feita para fins judiciais.~rConfirma a impress$$HEX1$$e300$$ENDHEX$$o?", Question!, YesNo!, 2 ) = 1 Then
	wf_imprime_orcamento_judicial(False)
End If
end event

event closequery;call super::closequery;Long ll_Linhas
Boolean lb_registra_desistencia = False

//gvo_Aplicacao.of_grava_log( "entrou no closequery da Tela F2")

If Not This.ib_Conclusao_Atendimento_Pendente Then Return 0 // O $$HEX1$$fa00$$ENDHEX$$ltimo atendimento iniciado j$$HEX1$$e100$$ENDHEX$$ foi conclu$$HEX1$$ed00$$ENDHEX$$do

lb_registra_desistencia = ( Not IsNull( dw_1.Object.cd_cliente[ 1 ] ) )

dw_2.AcceptText()

ll_Linhas = dw_2.RowCount()
If ll_Linhas > 0 Then
	If ll_Linhas = 1 Then
		If ib_Produto_Informado Then
			lb_registra_desistencia = True
		End If
	Else
		lb_registra_desistencia = True		
	End If
End If

Try
	If lb_registra_desistencia Then
		This.Setfocus( )
		
		If Not wf_conclui_desistencia() Then 
			Return 1
		Else
			Return 0
		End If
	Else
		If Not IsNull(il_Sequencial_Cliente_Caixa) Then
			DELETE FROM cliente_caixa
			WHERE nr_sequencial = :il_Sequencial_Cliente_Caixa
			USING SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_RollBack( )
				SqlCa.of_MsgDbError( "Exclus$$HEX1$$e300$$ENDHEX$$o do  registro de atendimento." )
			Else
				SqlCa.of_Commit( )
			End If
		End If
	End If
Finally
	SqlCa.of_End_Transaction( )
End Try

end event

event ue_preopen;call super::ue_preopen;If Not ib_Solicitou_Liberacao_Procedimento_Base Then
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE108_INICIA_ATENDIMENTO_CLIENTE", ref This.is_Matricula_Vendedor) Then 
		This.il_Retorno = -1
		Return
	End If
End If

dw_1.Object.t_alerta_reserva.visible = False
end event

event timer;call super::timer;wf_verifica_pedido_ecommerce_pendente()

wf_verifica_caixa_nao_finalizado()
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge108_consulta_preco
integer x = 343
integer y = 1052
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge108_consulta_preco
integer y = 1128
end type

type dw_8 from dc_uo_dw_base within w_ge108_consulta_preco
integer x = 69
integer y = 1492
integer width = 1047
integer height = 76
integer taborder = 0
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_ge108_desconto_negociavel_nova"
end type

type dw_7 from dc_uo_dw_base within w_ge108_consulta_preco
integer x = 2459
integer y = 1492
integer width = 1042
integer height = 76
integer taborder = 0
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_ge108_desconto_negociavel_nova"
end type

type dw_5 from dc_uo_dw_base within w_ge108_consulta_preco
integer x = 2944
integer y = 172
integer height = 164
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_ge108_orcamento_judicial"
end type

event constructor;call super::constructor;ivi_Tipo_Cancelar = RESET

//logo_dw




end event

type dw_saveas from dc_uo_dw_base within w_ge108_consulta_preco
boolean visible = false
integer x = 503
integer y = 1120
integer width = 1774
integer height = 136
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_consulta_interna_saveas"
boolean border = true
end type

event ue_saveas;// OverRide
Long ll_Linha

This.Reset( )

For ll_Linha = 1 To dw_2.RowCount( )
	This.InsertRow( ll_Linha )
	
	This.Object.cd_Produto[ ll_Linha ] = dw_2.Object.cd_Produto[ ll_Linha ]
	This.Object.de_Produto[ ll_Linha ] = dw_2.Object.de_Produto[ ll_Linha ]
Next

SUPER::Event ue_SaveAs( )
end event

type dw_atalhos from datawindow within w_ge108_consulta_preco
integer x = 18
integer y = 1600
integer width = 3525
integer height = 88
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ge108_atalhos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within w_ge108_consulta_preco
integer x = 27
integer y = 1436
integer width = 1115
integer height = 152
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Desconto Clube"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within w_ge108_consulta_preco
integer x = 2414
integer y = 1436
integer width = 1111
integer height = 152
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "Desconto SOS"
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within w_ge108_consulta_preco
integer x = 37
integer y = 596
integer width = 3474
integer height = 824
integer taborder = 50
string dataobject = "dw_ge108_produtos"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;ivb_updateable     = False
ivb_Selecao_Linhas = True
ivi_Tipo_Cancelar  = ADDROW

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {	"cd_produto", "de_produto", "qt_orcada", "vl_preco_unitario", "pc_desconto_fixo",&
					"vl_preco_final", "c_total_produto", "qt_estoque",  "id_situacao", "local"}

lvs_Nome = {	"c$$HEX1$$f300$$ENDHEX$$digo", "descri$$HEX2$$e700e300$$ENDHEX$$o", "qtde or$$HEX1$$e700$$ENDHEX$$ada", "preco unit$$HEX1$$e100$$ENDHEX$$rio", "desconto", "pre$$HEX1$$e700$$ENDHEX$$o final", &
					"total", "qtde estoque", "situa$$HEX2$$e700e300$$ENDHEX$$o", "local"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection( )
end event

event editchanged;call super::editchanged;Long ll_Qtde
Long ll_Qtde_inf

If Not IsNull( This.Object.nr_etiqueta_prestes[ row ] ) Then
	This.Object.Qt_Orcada[ row ] = 1
	Return -1
End If

If Not IsNull( This.Object.nr_pedido_empurrado[ row ] ) Then
	ll_Qtde = This.Object.Qt_Orcada[ row ] 
	This.Object.Qt_Orcada[ row ] = ll_Qtde
	Return -1
End If

If This.Object.id_usado_promocao_vinculada[ row ] = 'S' Then
	ll_Qtde = This.Object.Qt_Orcada[ row ]
	If Not IsNull( This.Object.cd_promocao_sos[ row ] ) Then
		If This.Object.id_tipo_pbm_clamed[ row ] = 'T' Then
			If IsNumber( data ) Then
				ll_Qtde_inf = Long( data )
				If ll_Qtde_inf <= ll_Qtde Then
					This.Object.Qt_Orcada[ row ] = ll_Qtde		
					Return -1				
				Else
					This.Object.qt_usada_promocao_vinculada[ row ] = ll_Qtde_inf
				End If
			Else
				This.Object.Qt_Orcada[ row ] = ll_Qtde		
				Return -1							
			End If
		Else
			This.Object.Qt_Orcada[ row ] = ll_Qtde		
			Return -1
		End If
	Else
		If IsNumber( data ) Then
			ll_Qtde_inf = Long( data )
			If ll_Qtde_inf <= ll_Qtde Then
				This.Object.Qt_Orcada[ row ] = ll_Qtde		
				Return -1				
			End If
		Else
			This.Object.Qt_Orcada[ row ] = ll_Qtde		
			Return -1							
		End If	
	End If
End If
end event

event getfocus;call super::getfocus;ivm_Menu.mf_Classificar(True)
ivm_Menu.mf_Filtrar(True)
ivm_Menu.mf_Localizar(True)
ivm_Menu.mf_Excluir(True)
ivm_Menu.mf_Incluir(True)
ivm_Menu.mf_SalvarComo(True)
end event

event itemchanged;call super::itemchanged;Integer li_Seq

Choose Case dwo.Name
	Case "de_produto"
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then 
			Return 1
		End If
		
	Case "qt_orcada"
		li_Seq 	= This.Object.nr_seq_cliente_caixa_prd	[ This.getRow( ) ]
		
		UPDATE cliente_caixa_produto
			SET qt_produto = :Data
			WHERE cd_filial							= dbo.uf_filial_parametro( )
			AND nr_sequencial_cliente_caixa 	= :il_Sequencial_Cliente_Caixa
			AND nr_sequencial 					= :li_Seq
		USING SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack( )
			SqlCa.of_MsgDbError( )
		Else
			SqlCa.of_Commit( )
		End If	
End Choose
end event

event itemfocuschanged;call super::itemfocuschanged;Choose Case dwo.Name
	Case "de_produto" ; This.SelectText(1,40)
	Case "qt_orcada"  ; This.SelectText(1,3)
End Choose
end event

event losefocus;call super::losefocus;ivm_Menu.mf_Classificar(False)
ivm_Menu.mf_Filtrar(False)
ivm_Menu.mf_Localizar(False)
ivm_Menu.mf_SalvarComo(False)
ivm_Menu.mf_Cancelar(False)
end event

event rowfocuschanged;call super::rowfocuschanged;Boolean lvb_Visible,&
		lvb_Visible_Gratis

Decimal lvdc_Nulo,&
		lvdc_Preco_Final,&
		lvdc_Desconto_Farm_Pop,&
		lvdc_preco_fpb
		
SetNull(lvdc_Nulo)

String lvs_Nulo
SetNull(lvs_Nulo)

If CurrentRow > 0 Then
	dw_7.Object.Pc_Desconto	[1] = lvdc_Nulo
	dw_7.Object.Vl_Preco_Final	[1] = lvdc_Nulo
	dw_8.Object.Pc_Desconto	[1] = lvdc_Nulo
	dw_8.Object.Vl_Preco_Final	[1] = lvdc_Nulo
	dw_3.Object.Pc_Desconto	[1] = lvdc_Nulo
	dw_3.Object.Vl_Preco_Final	[1] = lvdc_Nulo
//	dw_4.Object.Pc_Desconto	[1] = lvdc_Nulo
//	dw_4.Object.Vl_Preco_Final	[1] = lvdc_Nulo
	
	If This.Object.Pc_Desconto_SOS[CurrentRow] > 0 Then
		dw_7.Object.Pc_Desconto	[1] = This.Object.Pc_Desconto_SOS	[CurrentRow]
		dw_7.Object.Vl_Preco_Final	[1] = This.Object.Vl_Preco_SOS		[CurrentRow]
	End If
	
	If This.Object.Pc_Desconto_Clube[CurrentRow] > 0 Then
		dw_8.Object.Pc_Desconto	[1] = This.Object.Pc_Desconto_Clube	[CurrentRow]
		dw_8.Object.Vl_Preco_Final	[1] = This.Object.Vl_Preco_Clube		[CurrentRow]
	End If
	
	//Desconto Convenio
	If io_condicao_convenio.localizado Then
		If This.Object.Pc_Desconto_Convenio[CurrentRow] > 0 Then
			If This.Object.Pc_Desconto_plano_saude[CurrentRow] > 0 And This.Object.Pc_Desconto_plano_saude[CurrentRow] > This.Object.Pc_Desconto_Convenio[CurrentRow] Then
				dw_3.Object.Pc_Desconto	[1] = This.Object.Pc_Desconto_plano_saude[CurrentRow]
				dw_3.Object.Vl_Preco_Final	[1] = This.Object.Vl_Preco_plano_saude		 [CurrentRow]
			Else
				dw_3.Object.Pc_Desconto	[1] = This.Object.Pc_Desconto_Convenio	[CurrentRow]
				dw_3.Object.Vl_Preco_Final	[1] = This.Object.Vl_Preco_Convenio			[CurrentRow]
			End If
		End If
	Else
		If This.Object.Pc_Desconto_plano_saude[CurrentRow] > 0 Then
			dw_3.Object.Pc_Desconto	[1] = This.Object.Pc_Desconto_plano_saude[CurrentRow]
			dw_3.Object.Vl_Preco_Final	[1] = This.Object.Vl_Preco_plano_saude		 [CurrentRow]
		End If
	End If
	
//	If This.Object.Pc_Desconto_plano_saude[CurrentRow] > 0 Then
//		dw_4.Object.Pc_Desconto	[1] = This.Object.Pc_Desconto_plano_saude[CurrentRow]
//		dw_4.Object.Vl_Preco_Final	[1] = This.Object.Vl_Preco_plano_saude		 [CurrentRow]
//	End If	
	
	// Tratamento Farm$$HEX1$$e100$$ENDHEX$$cia Popular do Brasil
	lvb_Visible 			= False
	lvb_Visible_Gratis 	= False
	
	This.Object.st_pmc_farm_popular.text 			= lvs_Nulo
	This.Object.st_preco_final_farm_popular.text 	= lvs_Nulo
	This.Object.st_preco_fpb.text 						= lvs_Nulo
	
	If Not IsNull(This.Object.id_vidalink[CurrentRow]) and This.Object.id_vidalink[CurrentRow] = 'S' Then
		
		If This.Object.pc_desconto_fixo[CurrentRow] > This.Object.Pc_Desconto_SOS_Farm_Popular[CurrentRow] Then
			lvdc_Desconto_Farm_Pop = This.Object.pc_desconto_fixo[CurrentRow]
		Else
			lvdc_Desconto_Farm_Pop = This.Object.Pc_Desconto_SOS_Farm_Popular[CurrentRow]
		End If

		lvb_Visible = True
		
		lvdc_Preco_Final = Round(This.Object.vl_preco_unitario[CurrentRow] * ((100 - lvdc_Desconto_Farm_Pop) / 100), 2)

		If This.Object.vl_reembolso_fpb[CurrentRow] > 0 Then
			If (This.Object.vl_preco_final[CurrentRow] * 0.9) >= This.Object.vl_reembolso_fpb[CurrentRow] Then
				lvdc_Preco_fpb = Round(This.Object.vl_preco_final[CurrentRow] - This.Object.vl_reembolso_fpb[CurrentRow], 2)
			Else
				lvdc_Preco_fpb = Round(This.Object.vl_preco_final[CurrentRow] * 0.1, 2)
			End If
		Else
			SetNull(lvdc_Preco_fpb)
		End If			
		
		This.Object.st_preco_final_farm_popular.text 	= String(lvdc_Preco_Final, "#,##0.00")
		This.Object.st_pmc_farm_popular.text 			= String(This.Object.vl_preco_unitario[CurrentRow], "#,##0.00")
		This.Object.st_preco_fpb.text 						= String(lvdc_Preco_fpb, "#,##0.00")
	
		If Not IsNull(This.Object.id_gratis_farm_popular[CurrentRow]) and This.Object.id_gratis_farm_popular[CurrentRow] = 'S' Then
			lvb_Visible_Gratis 	= True
		End If						
		
	End If
		
	This.Object.st_nome_pmc_farm_popular.Visible 			= lvb_Visible
	This.Object.st_nome_preco_final_farm_popular.Visible 	= lvb_Visible
	This.Object.bmp_vidalink2.Visible 								= lvb_Visible
	This.Object.st_gratis_farm_popular.Visible					= lvb_Visible_Gratis
	
	If Not IsNull(lvdc_Preco_fpb) Then
		This.Object.st_nome_preco_fpb.Visible 					= lvb_Visible	
		This.Object.st_preco_fpb.Visible 							= lvb_Visible	
	End If
	
	If This.Object.id_Saldo_Pendente[CurrentRow] = 'S' Then
		dw_atalhos.Object.st_mov_estoque.Text = 'Mov. Estoque / Saldo Pendente'
	Else
		dw_atalhos.Object.st_mov_estoque.Text = 'Mov. Estoque'
	End If
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If RowCount() > 0 Then
	If IsNull(Object.cd_produto [RowCount()]) Then 
		Return -1
	End If
End If

Return 1

end event

event ue_addrow;call super::ue_addrow;ivm_Menu.mf_Imprimir(True)
ivm_Menu.mf_Excluir(True)
ivm_Menu.mf_Classificar(True)
ivm_Menu.mf_Filtrar(True)
ivm_Menu.mf_Localizar(True)
ivm_Menu.mf_SalvarComo(True)

Enabled = True

If AncestorReturnValue >= 1 Then
	il_seq_cliente_caixa_prd++	
	dw_2.Object.nr_Seq_Cliente_Caixa_Prd[ dw_2.getRow( ) ] 	= il_seq_cliente_caixa_prd
	dw_2.Object.Id_Saldo_Pendente[ dw_2.getRow( ) ] 			= 'N'
	dw_atalhos.Object.st_mov_estoque.Text 						= 'Mov. Estoque'
End If

Return AncestorReturnValue
end event

event ue_predeleterow;call super::ue_predeleterow;Long ll_Pedido, ll_Produto
Long ll_Promocao
Long ll_Find

If This.RowCount( ) > 0 Then
	If This.Object.Id_Reservado[ This.getRow( ) ] = 'S' Then
		
		//Reserva CD
		If This.Object.cd_filial_reserva[ This.getRow( ) ] = 534 Then
			ll_Pedido	 	= This.Object.nr_pedido_empurrado	[ This.getRow( ) ]
			ll_Produto 	= This.Object.cd_produto				[ This.getRow( ) ]
			
			If Not IsNull( ll_Pedido ) And ll_Pedido > 0 Then
				If MessageBox( "Cancelamento de reserva", "O pedido urgente gerado para esse produto ser$$HEX1$$e100$$ENDHEX$$ perdido.~rProduto: " +String(ll_Produto)+ "~r~rDeseja continuar?", Question!, YesNo!, 2 ) = 2 Then
					Return False
				End If				
				io_ge108_reserva_produtos.of_atualiza_ped_urgente_matriz( ll_Pedido, 'X', ll_Produto, 0)
			End If
		End If
		
		ivi_Qtde_Itens_Reservados --		
	End If
			
	If AncestorReturnValue Then
	
		//PBM Clamed
		If This.Object.qt_usada_promocao_vinculada[ This.getRow( ) ] > 0 Then
			ll_Promocao = This.Object.Cd_Promocao_SOS[ This.getRow( ) ]
			
			ll_Find = This.Find( "cd_promocao_sos = " + String( ll_Promocao ), 1, This.RowCount( ) )
			Do While ll_Find > 0
				This.DeleteRow( ll_Find )				
				ll_Find = This.Find( "cd_promocao_sos = " + String( ll_Promocao ), 1, This.RowCount( ) )
			loop
			
				ib_item_pbm_excluido   = False				
				ib_Venda_pbm_clamed  = ( This.Find( "not isnull( cd_promocao_sos ) ", 1, This.RowCount( ) ) > 0 )
				
				wf_altera_rotulo_end()

			Return False
		End If
		
	End If
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If RowCount() = 0 Then
	ivm_Menu.mf_Excluir(False)
	ivm_Menu.mf_SalvarComo(False)
	Enabled = False	
	ib_Venda_pbm_clamed = False
	ib_item_pbm_excluido = False	
	
	dw_2.Event ue_Cancel()		

	If IsNull(This.Object.cd_produto[1]) Or This.Object.cd_produto[1] = 0 Then
		If Not IsNull(is_cartao_desconto) And Trim(is_cartao_desconto) <> '' And IsNull(dw_1.object.cd_cliente[1]) Then
			SetNull(is_cartao_desconto)
			ids_contratos_bin.reset()
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "As informa$$HEX2$$e700f500$$ENDHEX$$es do desconto de Plano de Sa$$HEX1$$fa00$$ENDHEX$$de foram limpas, se necess$$HEX1$$e100$$ENDHEX$$rio capture o cart$$HEX1$$e300$$ENDHEX$$o novamente.", Information! )
		End If
	End If
	
	This.SetFocus()
Else
	If RowCount() = 1 Then
		If IsNull(This.Object.cd_produto[1]) Or This.Object.cd_produto[1] = 0 Then
			ib_Venda_pbm_clamed = False
			ib_item_pbm_excluido = False
		End If
	End If
End If

If AncestorReturnValue Then

	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	
	wf_altera_rotulo_end( )
	
	If dw_2.Find( "id_cobre_preco='S'", 1, dw_2.RowCount( ) ) = 0 Then
		If IsValid( io_Cobre_Preco ) Then Destroy io_Cobre_Preco
		
		io_Cobre_Preco = Create uo_rl154_parametros
	End If
	
	If RowCount() = 1 Then
		This.Event RowFocusChanged( This.GetRow( ) )
	End If
End If

If Not ib_Reserva_Produto Then
	wf_Bloqueia_Campos_Convenio( )
	
	//Verifica Exclusao do produto cobre Preco
	wf_bloqueia_libera_campos_cliente()
End If

Return AncestorReturnValue

end event

event ue_key;Boolean lb_Existe_Prd_Portal_Drogaria =False
Boolean lb_Produto_Portal_Drogaria = False
Boolean lb_Informa_Cartao_Industria
Boolean lb_Informa_CPF


Long lvl_Produto, &
     lvl_Linha,   &
	 lvl_Saldo
	 
Decimal lvdc_Desconto

String ls_Matricula_Negociacao
String ls_Parametro
String ls_CPF
String ls_Cartao

/********************************
ALTERAR TAMB$$HEX1$$c900$$ENDHEX$$M ESTE EVENTO NA DW_1
********************************/

//Desconto Negociavel
//If keyFlags = 1 And Key = KeyEnd! Then
//	If is_Permite_Negociacao <> 'S' Then Return 1
//	
//	If ib_Venda_pbm_clamed Then
//		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atendimento marcado como PBM Clamed, negocia$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida!", Exclamation! )
//		Return 1
//	End If
//
//	ids_Negociacao_Aux 	= Create dc_uo_ds_base //Utilizada para passar os produtos da dw_2 para response de negociacao
//	ids_Negociacao 		= Create dc_uo_ds_base
//						
//	If wf_Negociacao_Cliente() Then
//		wf_Conclui_Venda()
//	Else
//		If wf_Grava_Negociacao_Cliente( il_Sequencial_Cliente_Caixa ) Then
//			SqlCa.of_Commit();
//		End If
//	End If
//
//	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
//	
//	Return 1
//
//End If


//Cobre Preco
//If keyFlags = 2 And Key = KeyF4! Then
//	If ib_Venda_pbm_clamed Then
//		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atendimento marcado como PBM Clamed, negocia$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida!", Exclamation! )
//		Return 1
//	End If
//	
//	wf_Cobre_Preco()
//		
//	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
//	
//	Return 1
//End If

Choose Case Key
	Case KeyEnter!
		Choose Case GetColumnName()
			Case "de_produto"
				wf_localiza_produto(This.GetText())
				lvl_Saldo = dw_2.Object.qt_estoque[dw_2.GetRow()]
				
				If lvl_Saldo <= 0 Then
					If is_Mostra_Msg_Saldo_Zero = 'S' Then
						MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto sem estoque dispon$$HEX1$$ed00$$ENDHEX$$vel.", Exclamation! )						
						//OpenWithParm(w_ge108_registro_falta_produtos,Long(dw_2.Object.cd_produto[dw_2.GetRow()]))				
					End If
				End If
				
			Case "qt_orcada"	
				Event ue_AddRow()
				SetRow(RowCount())
				ScrollToRow(RowCount())
				SetColumn("de_produto")
		End Choose
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyF11!
//		If ( dw_1.Object.Cartao_Clube_t.Text = "[F11] Entregar cart$$HEX1$$e300$$ENDHEX$$o" ) And ( ivo_Cliente.Localizado ) Then
//			OpenWithParm(w_rl088_entrega_cartao_clube, ivo_Cliente.Nr_Cpf_Cgc)
//			wf_Verifica_se_Possui_Cartao(ivo_Cliente.Cd_Cliente)
//		Else
//			If Not ivo_Cliente.Localizado And ib_Painel_Senha Then
//				OpenWithParm( w_ge108_painel_senha, istr_Painel_Senha )
//			End If
//		End If
//		
//		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyEnd!	
				
		If ib_AGUARDAR_ATIVO Then
			Return
		End If
		
		//Desenvolvimento
		//Gerar autoriza$$HEX2$$e700e300$$ENDHEX$$o e o cadastro do cliente no balcao de atendimento
		//wf_gera_autorizacao_pbm()
		
		If dw_2.Find( "id_pbm_clamed = 'S' and isnull( cd_promocao_sos )", 1, dw_2.Rowcount( ) ) > 0 Then
			If dw_2.Find( "id_pbm_clamed = 'S' and not isnull( cd_promocao_sos )", 1, dw_2.Rowcount( ) ) = 0 Then
				If MessageBox("PBM CLAMED",	"Existem produtos que n$$HEX1$$e300$$ENDHEX$$o concederam benef$$HEX1$$ed00$$ENDHEX$$cio do PBM CLAMED.~r" + &
														"Para calcular o benef$$HEX1$$ed00$$ENDHEX$$cio, informe a quantidade e pressione [SHIFT + C].~r~r" + &
														"Deseja voltar e calcular o benef$$HEX1$$ed00$$ENDHEX$$cio do PBM CLAMED ?", Question!, YesNo! ) = 1 Then
					Return -1
				End If
			End If
		End If
		
		ib_Venda_Dermaclub = False
		
		If ivo_Cliente.Localizado Then
			If dw_2.Find( " id_dermaclub = 'S' ", 1, dw_2.Rowcount( ) ) > 0 And	Not ib_Venda_Dermaclub And ib_Dermaclub_ativo Then
				//variavel que indica que foi marcado o cliente
//				If MessageBox("DERMACLUB",	"Existem produtos do programa DERMACLUB.~r~r" + &
//														"Cliente possui cadastro no programa?", Question!, YesNo! ) = 1 Then
				ib_Venda_Dermaclub = True
			End If
		End If		
				
		//Desenvimento
		//Checkout ativo, sem cadastro do cliente, apenas passam produtos no caixa
		ib_Venda_Portal_Drogaria = False	
		wf_Existe_Produtos_PBM_Portal_drogaria(Ref lb_Existe_Prd_Portal_Drogaria, Ref lb_Informa_Cartao_Industria, Ref lb_Informa_CPF)
		
		If lb_Existe_Prd_Portal_Drogaria Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem produtos do PBM Portal Drogaria.~r~rDeseja finalizar o atendimento e gerar a Autoriza$$HEX2$$e700e300$$ENDHEX$$o no Caixa?", Question!, YesNo!, 2) = 1 Then
				
				//Nao informou o CPF ou precisa informar o Cartao da Industria
				//If lb_Informa_Cartao_Industria Or ( lb_Informa_CPF And Not ivo_Cliente.Localizado ) Then
				//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alguns produtos na lista necessitam da identifica$$HEX2$$e700e300$$ENDHEX$$o do cliente.~r~rFavor informar o CPF e/ou o Cart$$HEX1$$e300$$ENDHEX$$o da Ind$$HEX1$$fa00$$ENDHEX$$stria.", Exclamation!)
					
					ls_CPF = ivo_Cliente.nr_cpf_cgc
					If IsNull(ls_CPF) Or Trim(ls_CPF) = ''	 Then  ls_CPF 	  = Space(11)
					If IsNull(ls_Cartao) 						 Then  ls_Cartao = ''	
					
					ls_Parametro = IIF(lb_Informa_Cartao_Industria,'S','N') + "|" + IIF(lb_Informa_CPF,'S','N') + '|' + ls_CPF + '|' + ls_Cartao						
						
					Try
						uo_ge570_dados_obrigatorios lo_Obrigatorios
						OpenWithParm( w_ge570_solicita_dados_obrigatorios, ls_Parametro )
						
						lo_Obrigatorios = Message.powerobjectparm
						
						If IsValid(lo_Obrigatorios) Then
							idt_Nascimento			   	= lo_Obrigatorios.dh_nascimento
					 		is_Cartao_Industria_PBM	= lo_Obrigatorios.nr_cartao_industria
   						     is_CPF_Nao_Identificado	= lo_Obrigatorios.nr_cpf
						Else
							Return -1
						End If						
					Finally
						If IsValid(lo_Obrigatorios) Then Destroy lo_Obrigatorios
					End Try				
				//End If //
				
				If ivo_Cliente.Localizado Then 
					idt_Nascimento = Date(ivo_Cliente.dh_nascimento)
				End If
					
				ib_Venda_Portal_Drogaria = True
			End If //MessageBox
		End If		
						
		If dw_2.Find( "id_cobre_preco='S'" , 1, dw_2.RowCount() ) > 0 Then
			If wf_Grava_Cobre_Preco() Then
				If dw_2.Find( "id_reservado='S'" , 1, dw_2.RowCount() ) > 0 Then
					Event ue_finalizar_reserva(False)	
				Else
					wf_Conclui_Venda()
				End If
			End If
		Elseif dw_2.Find( "id_reservado='S'" , 1, dw_2.RowCount() ) > 0 Then
			//Verifica se existe pbm clamed
			If ib_Venda_pbm_clamed Then
				If wf_conclui_pbm() Then
					Event ue_finalizar_reserva(False)	
				End If
			Else
				Event ue_finalizar_reserva(False)	
			End If
								
		ElseIf ib_Venda_pbm_clamed Then
			If wf_conclui_pbm() Then
				wf_Conclui_Venda()
			End If
			
		Else
			wf_Conclui_Venda()	
		End If
				
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyInsert!
		wf_Cadastra_Cliente()
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyF3!
		wf_Atualiza_Cliente()
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyEscape!
		wf_conclui_desistencia( )
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyF4!
		Open(w_ge107_consulta_posicao_desconto)
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
	
	Case KeyF8!
		lvl_Linha = This.GetRow()
		
		If lvl_Linha > 0 Then
			OpenWithParm( w_ge108_movimentacao_estoque, Long( dw_2.Object.cd_produto[ lvl_Linha ] ) )
		End If
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyF7!
		lvl_Linha = This.GetRow()
		
		If lvl_Linha > 0 Then
			lvl_Produto = This.Object.Cd_Produto[lvl_Linha]

			ivo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
			
			If ivo_Produto.Localizado Then
				If dw_2.Object.id_promocao_vinculada [ lvl_linha ] = 'S' or dw_2.Object.id_promocao_progressiva [ lvl_linha ] = 'S'Then
					lvdc_Desconto = dw_2.Object.pc_desconto_fixo[dw_2.GetRow()]
					If dw_2.Object.pc_desconto_sos[dw_2.GetRow()] > lvdc_Desconto Then lvdc_Desconto    		= dw_2.Object.pc_desconto_sos[dw_2.GetRow()]
					If dw_2.Object.pc_desconto_clube[dw_2.GetRow()] > lvdc_Desconto Then lvdc_Desconto 		= dw_2.Object.pc_desconto_clube[dw_2.GetRow()]
					If dw_2.Object.pc_desconto_convenio[dw_2.GetRow()] > lvdc_Desconto Then lvdc_Desconto 	= dw_2.Object.pc_desconto_convenio[dw_2.GetRow()]

					OpenWithParm( w_ge108_promocao_vinculada, String(lvdc_Desconto)+'|V|'+String(lvl_Produto) )
					
					dw_2.event ue_pos(lvl_Linha,"qt_orcada")
					
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(lvl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o possui nenhuma promo$$HEX2$$e700e300$$ENDHEX$$o vinculada.", Information!)
				End If
			End If		
		End If
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
			
	Case KeyF6!	
	Case KeyF5!
		//Desenvimento
		wf_consulta_desconto_portal_drogaria(Ref lb_Produto_Portal_Drogaria)
		
		If Not lb_Produto_Portal_Drogaria Then
					
			lvl_Linha = This.GetRow()
			
			If lvl_Linha > 0 Then
			
				lvl_Produto = This.Object.cd_produto[ lvl_Linha ]
				
				If Not IsNull(lvl_Produto) Then
					
					lvdc_Desconto = dw_2.Object.pc_desconto_fixo[dw_2.GetRow()]
					If dw_2.Object.pc_desconto_sos[dw_2.GetRow()] 		> lvdc_Desconto Then lvdc_Desconto    	= dw_2.Object.pc_desconto_sos[dw_2.GetRow()]
					If dw_2.Object.pc_desconto_clube[dw_2.GetRow()] 		> lvdc_Desconto Then lvdc_Desconto 	= dw_2.Object.pc_desconto_clube[dw_2.GetRow()]
					If dw_2.Object.pc_desconto_convenio[dw_2.GetRow()] 	> lvdc_Desconto Then lvdc_Desconto 	= dw_2.Object.pc_desconto_convenio[dw_2.GetRow()]				
					
					uo_ge108_produto lo_Prd
					lo_Prd = Create uo_ge108_produto
					
					lo_Prd.idc_desconto = lvdc_Desconto
					lo_Prd.of_localiza_codigo_interno( lvl_Produto )
					
					lo_Prd.of_consulta_regras_pbms_vidalink( )		
					
					If IsValid(lo_Prd) Then Destroy lo_Prd
					
					If Not ib_Venda_Dermaclub And ib_Dermaclub_ativo And dw_2.Object.id_dermaclub[dw_2.GetRow()] = 'S' Then
						If MessageBox("DERMACLUB",	"Produto faz parte do programa DERMACLUB.~r~r" + &
																"Cliente j$$HEX1$$e100$$ENDHEX$$ possui cadastro no programa?", Question!, YesNo! ) = 1 Then
							ib_Venda_Dermaclub = True
						End If						
					End If
					
				End If
				
			End If
		End If
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
End Choose
end event

event ue_reset;call super::ue_reset;il_seq_cliente_caixa_prd = 0
end event

event ue_saveas;//OverRide
dw_SaveAs.Event ue_SaveAs( )
end event

type dw_3 from dc_uo_dw_base within w_ge108_consulta_preco
integer x = 1275
integer y = 1492
integer width = 1038
integer height = 76
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge108_desconto_negociavel_nova"
end type

type pb_1 from picturebutton within w_ge108_consulta_preco
integer x = 2048
integer y = 320
integer width = 114
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\icon_search.PNG"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\icon_search.PNG"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Long ll_Convenio

dw_1.AcceptText()

ll_Convenio = dw_1.Object.cd_convenio [1]

If IsNull( ll_Convenio ) Or ll_Convenio = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar o Conv$$HEX1$$ea00$$ENDHEX$$nio.")
	dw_1.Event ue_Pos(1, "nm_convenio")
	Return -1
End If

uo_ajuda_convenio lo_ajuda
lo_ajuda = Create uo_ajuda_convenio

//GE0036 - uo_ajuda_convenio
lo_Ajuda.of_Manual_Atendimento( ll_Convenio )

If IsValid( lo_ajuda ) Then Destroy lo_ajuda



end event

type gb_2 from groupbox within w_ge108_consulta_preco
integer x = 23
integer y = 548
integer width = 3506
integer height = 884
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge108_consulta_preco
integer x = 1234
integer y = 1436
integer width = 1097
integer height = 152
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Desconto Conv$$HEX1$$ea00$$ENDHEX$$nio"
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within w_ge108_consulta_preco
boolean visible = false
integer x = 2688
integer y = 1540
integer width = 777
integer height = 152
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "Desconto Plano Sa$$HEX1$$fa00$$ENDHEX$$de"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within w_ge108_consulta_preco
boolean visible = false
integer x = 2706
integer y = 1596
integer width = 722
integer height = 76
integer taborder = 0
boolean enabled = false
string dataobject = "dw_ge108_desconto_negociavel_nova"
end type

type dw_1 from dc_uo_dw_base within w_ge108_consulta_preco
integer x = 41
integer y = 4
integer width = 3497
integer height = 544
string dataobject = "dw_ge108_cliente_selecionado"
end type

event constructor;call super::constructor;ivb_updateable    = False
ivi_Tipo_Cancelar = ADDROW

SqlCa.of_End_Transaction( )

This.of_SetColSelection(True)



end event

event getfocus;call super::getfocus;This.ivm_Menu.mf_Excluir(False)
This.ivm_Menu.mf_Incluir(False)


end event

event ue_key;call super::ue_key;Boolean lb_Existe_Prd_Portal_Drogaria, lb_Informa_Cartao_Industria, lb_Informa_CPF

String lvs_Coluna
String ls_CPF
String ls_Parametro
String ls_Cartao

dw_1.AcceptText()

lvs_Coluna = GetColumnName()

/********************************
ALTERAR TAMB$$HEX1$$c900$$ENDHEX$$M ESTE EVENTO NA DW_2
********************************/

//Desconto Negociavel
//If keyFlags = 1 And Key = KeyEnd! Then
//	If is_Permite_Negociacao <> 'S' Then Return 1 	
//
//	If ib_Venda_pbm_clamed Then
//		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atendimento marcado como PBM Clamed, negocia$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida!", Exclamation! )
//		Return 1
//	End If		
//
//	ids_Negociacao_Aux 	= Create dc_uo_ds_base //Utilizada para passar os produtos da dw_2 para response de negociacao
//	ids_Negociacao 		= Create dc_uo_ds_base
//						
//	If wf_Negociacao_Cliente() Then
//		wf_Conclui_Venda()
//	Else
//		If wf_Grava_Negociacao_Cliente( il_Sequencial_Cliente_Caixa ) Then
//			SqlCa.of_Commit();
//		End If
//	End If
//		
//	SqlCa.of_End_Transaction( )
//		
//	Return 1
//End If


//Cobre Preco
//If keyFlags = 1 And Key = KeyF4! Then
//	If ib_Venda_pbm_clamed Then
//		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atendimento marcado como PBM Clamed, negocia$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida!", Exclamation! )
//		Return 1
//	End If
//	
//	wf_Cobre_Preco()
//		
//	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
//	
//	Return 1
//End If


Choose Case key
		
	Case keyEnter!
		
		Try
			ib_AGUARDAR_ATIVO=True
			
			If lvs_Coluna = "nm_vendedor" Then
				wf_localiza_vendedor()
			End If
			
			If lvs_Coluna = "nm_convenio" Then
				wf_localiza_convenio()
			End If
			
			SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
			If lvs_Coluna = "localizacao" Then
				wf_localiza_cliente()
				If ivo_Cliente.Localizado Then
					
					wf_altera_rotulo_end()
				
					//O cliente possui reservas
					If ivo_Cliente.of_possui_reserva_produto( ) Then
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O cliente possui reserva(s). Deseja visualiz$$HEX1$$e100$$ENDHEX$$-la(s) ?", Question!, YesNo!, 1) = 1 Then  
							Event ue_buscar_reserva( )
						End If
					Else
						Return
					End If	
							
				End If	
			End If
			
			
		Finally
			ib_AGUARDAR_ATIVO=False
			SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		End Try
		
	Case KeyF11!
//		If ( dw_1.Object.Cartao_Clube_t.Text = "[F11] Entregar cart$$HEX1$$e300$$ENDHEX$$o" ) And ( ivo_Cliente.Localizado ) Then
//			OpenWithParm(w_rl088_entrega_cartao_clube, ivo_Cliente.Nr_Cpf_Cgc)
//			wf_Verifica_se_Possui_Cartao(ivo_Cliente.Cd_Cliente)
//		Else
//			If Not ivo_Cliente.Localizado And ib_Painel_Senha Then
//				OpenWithParm( w_ge108_painel_senha, istr_Painel_Senha )
//			End If
//		End If
//		
//		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o

	Case KeyEnd!
		If ib_AGUARDAR_ATIVO Then
			Return
		End If
		
		//Desenvolvimento
		//wf_gera_autorizacao_pbm()
		
		If dw_2.Find( "id_pbm_clamed = 'S' and isnull( cd_promocao_sos )", 1, dw_2.Rowcount( ) ) > 0 Then
			If dw_2.Find( "id_pbm_clamed = 'S' and not isnull( cd_promocao_sos )", 1, dw_2.Rowcount( ) ) = 0 Then
				If MessageBox("PBM CLAMED",	"Existem produtos que n$$HEX1$$e300$$ENDHEX$$o concederam benef$$HEX1$$ed00$$ENDHEX$$cio do PBM CLAMED.~r" + &
														"Para calcular o benef$$HEX1$$ed00$$ENDHEX$$cio, informe a quantidade e pressione [SHIFT + C].~r~r" + &
														"Deseja voltar e calcular o benef$$HEX1$$ed00$$ENDHEX$$cio do PBM CLAMED ?", Question!, YesNo! ) = 1 Then
					Return -1
				End If
			End If
		End If
		
		ib_Venda_Dermaclub = False
		
		If ivo_Cliente.Localizado Then
			If dw_2.Find( " id_dermaclub = 'S' ", 1, dw_2.Rowcount( ) ) > 0 And	Not ib_Venda_Dermaclub And ib_Dermaclub_ativo Then
				//variavel que indica que foi marcado o cliente
//				If MessageBox("DERMACLUB",	"Existem produtos do programa DERMACLUB.~r~r" + &
//														"Cliente possui cadastro no programa?", Question!, YesNo! ) = 1 Then
				ib_Venda_Dermaclub = True
			End If
		End If		
				
		ib_Venda_Portal_Drogaria = False	
		wf_Existe_Produtos_PBM_Portal_drogaria(Ref lb_Existe_Prd_Portal_Drogaria, Ref lb_Informa_Cartao_Industria, Ref lb_Informa_CPF)
		
		If lb_Existe_Prd_Portal_Drogaria Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem produtos do PBM Portal Drogaria.~r~rDeseja finalizar o atendimento e gerar a Autoriza$$HEX2$$e700e300$$ENDHEX$$o no Caixa?", Question!, YesNo!, 2) = 1 Then
		
				//Nao informou o CPF ou precisa informar o Cartao da Industria
//				If lb_Informa_Cartao_Industria Or ( lb_Informa_CPF And Not ivo_Cliente.Localizado ) Then
//					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alguns produtos na lista necessitam da identifica$$HEX2$$e700e300$$ENDHEX$$o do cliente.~r~rFavor informar o CPF e/ou o Cart$$HEX1$$e300$$ENDHEX$$o da Ind$$HEX1$$fa00$$ENDHEX$$stria.", Exclamation!)
					
					ls_CPF = ivo_Cliente.nr_cpf_cgc
					If IsNull(ls_CPF) 	 Then  ls_CPF = Space(11)
					If IsNull(ls_Cartao) Then  ls_Cartao = ''	
					
					ls_Parametro = IIF(lb_Informa_Cartao_Industria,'S','N') + "|" + IIF(lb_Informa_CPF,'S','N') + '|' + ls_CPF + '|' + ls_Cartao						
						
					Try
						uo_ge570_dados_obrigatorios lo_Obrigatorios
						OpenWithParm( w_ge570_solicita_dados_obrigatorios, ls_Parametro )
						
						lo_Obrigatorios = Message.powerobjectparm
						
						If IsValid(lo_Obrigatorios) Then
							idt_Nascimento			   	= lo_Obrigatorios.dh_nascimento
					 		is_Cartao_Industria_PBM	= lo_Obrigatorios.nr_cartao_industria
   						     is_CPF_Nao_Identificado	= lo_Obrigatorios.nr_cpf
						Else
							Return -1
						End If						
					Finally
						If IsValid(lo_Obrigatorios) Then Destroy lo_Obrigatorios
					End Try				
				//End If //
				
				If ivo_Cliente.Localizado Then 
					idt_Nascimento = Date(ivo_Cliente.dh_nascimento)
				End If
					
				ib_Venda_Portal_Drogaria = True
			End If //MessageBox
		End If			
						
		If dw_2.Find( "id_cobre_preco='S'" , 1, dw_2.RowCount() ) > 0 Then
			If wf_Grava_Cobre_Preco() Then
				If dw_2.Find( "id_reservado='S'" , 1, dw_2.RowCount() ) > 0 Then
					Event ue_finalizar_reserva(False)	
				Else
					wf_Conclui_Venda()
				End If
			End If
		Elseif dw_2.Find( "id_reservado='S'" , 1, dw_2.RowCount() ) > 0 Then
			//Verifica se existe pbm clamed
			If ib_Venda_pbm_clamed Then
				If wf_conclui_pbm() Then
					Event ue_finalizar_reserva(False)	
				End If
			Else
				Event ue_finalizar_reserva(False)	
			End If
								
		ElseIf ib_Venda_pbm_clamed Then
			If wf_conclui_pbm() Then
				wf_Conclui_Venda()
			End If
			
		Else
			wf_Conclui_Venda()	
		End If
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyInsert!
		wf_Cadastra_Cliente()
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyF3!
		wf_Atualiza_Cliente()
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyEscape!
		If wf_conclui_desistencia() Then
			Close( w_ge108_consulta_preco )
		End If
				
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
End Choose
end event

event doubleclicked;call super::doubleclicked;If dwo.Name = 't_alerta_reserva' Then
	If Long(This.Object.t_alerta_reserva.Background.Color) <> 32768 Then
		io_ge108_reserva_produtos.of_verifica_pendencia( True )
	End If
End If
end event

event itemchanged;call super::itemchanged;If dwo.Name = "localizacao" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Cliente.Nm_Cliente Then
			Return 1
		End If
	Else
		ivo_Cliente.of_Inicializa()
			
		This.Object.gb_Cliente.text 		= ""
		This.Object.Nr_Cpf			[1] = ivo_Cliente.Nr_Cpf_CGC
		This.Object.Cd_Cliente		[1] = ivo_Cliente.Cd_Cliente
		This.Object.Localizacao		[1] = ivo_Cliente.Nm_Cliente
		This.Object.Nm_Dependente[1] = ivo_Cliente.Nm_Dependente
		This.Object.Cd_Dependente	[1] = ivo_Cliente.Cd_Dependente
		
		wf_altera_rotulo_end()
	End If
End If

If dwo.Name = "nm_convenio" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Convenio.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Convenio.of_Inicializa()
		
		This.Object.Cd_Convenio		[1] = io_Convenio.Cd_Convenio
		This.Object.Nm_Convenio	[1] = io_Convenio.Nm_Fantasia
		
		io_condicao_convenio.of_inicializa( )
		dw_1.Object.de_condicao_conv	[1] = "NENHUM CONVENIO SELECIONADO"
		dw_1.Object.cd_Condicao_Conv	[1] = io_Condicao_Convenio.cd_condicao_convenio
		
		//Retira o desconto do convenio na localiza$$HEX2$$e700e300$$ENDHEX$$o dos produtos
		ivo_produto.il_convenio 							= io_condicao_convenio.cd_convenio
		ivo_produto.il_condicao_convenio 				= io_condicao_convenio.cd_condicao_convenio
	End If	
End If
end event

event editchanged;call super::editchanged;Choose Case dwo.Name
	Case "localizacao"
		If Data = "" Or IsNull(Data) Then
			ivo_Cliente.of_Inicializa()
			
			This.Object.gb_Cliente.text 		= ""
			
			This.Object.Nr_Cpf			[1] = ivo_Cliente.Nr_Cpf_CGC
			This.Object.Cd_Cliente		[1] = ivo_Cliente.Cd_Cliente
			This.Object.Localizacao		[1] = ""
			This.Object.Nm_Dependente[1] = ivo_Cliente.Nm_Dependente
			This.Object.Cd_Dependente	[1] = ivo_Cliente.Cd_Dependente
			This.Object.qt_pontos			[1] = 0
			
			wf_altera_rotulo_end()

			If Not IsNull(is_cartao_desconto) And Trim(is_cartao_desconto) <> '' Then
				SetNull(is_cartao_desconto)
				ids_contratos_bin.reset()
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "As informa$$HEX2$$e700f500$$ENDHEX$$es do desconto de Plano de Sa$$HEX1$$fa00$$ENDHEX$$de foram limpas, se necess$$HEX1$$e100$$ENDHEX$$rio capture o cart$$HEX1$$e300$$ENDHEX$$o novamente.", Information! )
			End If
			
			If ib_Venda_Dermaclub Then
				ib_Venda_Dermaclub	= False
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Devido a altera$$HEX2$$e700e300$$ENDHEX$$o do cliente do atendimento a informa$$HEX2$$e700e300$$ENDHEX$$o que participa do programa Dermaclub foi limpa. Se necess$$HEX1$$e100$$ENDHEX$$rio informe novamente.", Information! )
			End If
			
			Return 0
		End If	
		
		If Data <> ivo_Cliente.Nm_Cliente Then Return 1
		
End Choose
end event

