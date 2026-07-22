HA$PBExportHeader$w_ge108_reserva_produto.srw
forward
global type w_ge108_reserva_produto from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge108_reserva_produto
end type
type cb_antecipado from commandbutton within w_ge108_reserva_produto
end type
type gb_2 from groupbox within w_ge108_reserva_produto
end type
end forward

global type w_ge108_reserva_produto from dc_w_response_ok_cancela
integer width = 2825
integer height = 1592
string title = "GE0108 - Reserva de Produto"
dw_2 dw_2
cb_antecipado cb_antecipado
gb_2 gb_2
end type
global w_ge108_reserva_produto w_ge108_reserva_produto

type variables
uo_Produto io_Produto

uo_Cliente io_Cliente

uo_ge108_reserva_produtos 	io_Reserva
uo_parametro_filial				io_parametro

Boolean ib_check = True
Boolean ib_Permite_Venda_Sem_Saldo = False
end variables

forward prototypes
public function boolean wf_carrega_produtos ()
public function boolean wf_telefone_ok (ref string ps_fone_contato)
public function integer wf_realiza_pagamento (string as_tipo_pagamento)
public function boolean wf_grava_reserva_matriz (string as_situacao_cabecalho)
end prototypes

public function boolean wf_carrega_produtos ();Long ll_Row, ll_Linhas, ll_Insert
Long ll_Produto, ll_Qtde, ll_Filial_transf

String ls_Matricula_Transf, ls_Id_reservado, ls_Marcado
String ls_Descricao

Integer li_Sequencial

//Pedido Empurrado
Long ll_Pedido_Empurrado
Long ll_Mix_Produto
Long ll_Qtde_Minima

Try
	ll_Linhas = io_Reserva.ds_produtos.RowCount()

	For ll_Row = 1  To ll_Linhas
		ll_Produto			= io_Reserva.ds_produtos.Object.cd_produto	[ ll_Row ]
		ls_Id_reservado 	= io_Reserva.ds_produtos.Object.id_reservado	[ ll_Row ]
		
		If IsNull( ll_Produto ) Then Continue
		
		ll_Qtde					= io_Reserva.ds_produtos.Object.qt_orcada							[ ll_Row ]
		ls_Descricao				= io_Reserva.ds_produtos.Object.de_produto							[ ll_Row ]
		li_Sequencial			= io_Reserva.ds_produtos.Object.nr_seq_cliente_caixa_prd			[ ll_Row ]
		ll_Filial_transf			= io_Reserva.ds_produtos.Object.cd_filial_reserva					[ ll_Row ]
		ls_Matricula_Transf 	= io_Reserva.ds_produtos.Object.nr_matric_atendente_reserva	[ ll_Row ]
		ll_Pedido_Empurrado	= io_Reserva.ds_produtos.Object.nr_pedido_empurrado				[ ll_Row ]
		ll_Mix_Produto			= io_Reserva.ds_produtos.Object.cd_mix_produto						[ ll_Row ]
		ll_Qtde_Minima			= io_Reserva.ds_produtos.Object.qt_minima_aprovacao				[ ll_Row ]
		
		ll_Insert = dw_2.InsertRow(0)
		
		ls_Marcado = IIF( ls_Id_reservado = 'S', 'S', 'N')
		
		dw_2.Object.cd_produto							[ ll_Insert ] = ll_Produto
		dw_2.Object.de_produto							[ ll_Insert ] = ls_Descricao
		dw_2.Object.qt_produto							[ ll_Insert ] = ll_Qtde
		dw_2.Object.qt_reservada_ped_empurrado	[ ll_Insert ] = ll_Qtde		
		dw_2.Object.id_selecao							[ ll_Insert ] = ls_Marcado
		dw_2.Object.nr_sequencial						[ ll_Insert ] = li_Sequencial
		dw_2.Object.cd_filial_transferencia			[ ll_Insert ] = ll_Filial_transf
		dw_2.Object.nr_matricula_transferencia		[ ll_Insert ] = ls_Matricula_Transf
		dw_2.Object.nr_pedido_empurrado			[ ll_Insert ] = ll_Pedido_Empurrado
		dw_2.Object.cd_mix_produto					[ ll_Insert ] = ll_Mix_Produto
		dw_2.Object.qt_minima_aprovacao			[ ll_Insert ] = ll_Qtde_Minima
		
		dw_2.Object.vl_preco_unitario					[ ll_Insert ] = io_Reserva.ds_produtos.Object.vl_preco_unitario		[ ll_Row ]
		dw_2.Object.qt_saldo_atual						[ ll_Insert ] = io_Reserva.ds_produtos.Object.qt_estoque				[ ll_Row ]
		
	Next
	
	If ll_Insert > 0 Then dw_2.Event ue_Pos( 1, 'qt_produto' )	

Catch ( RuntimeError e )	
	MessageBox("Erro", e.GetMessage() )
	
Finally
	Return True
End Try
end function

public function boolean wf_telefone_ok (ref string ps_fone_contato);String ls_DDD, ls_Fone

dw_1.AcceptText()
	
ls_DDD			= Trim( dw_1.Object.nr_ddd					[ 1 ] )
ls_Fone			= Trim( dw_1.Object.nr_fone_contato		[ 1 ] )

If IsNull( ls_DDD ) or ls_DDD = "" Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o DDD do telefone.", Exclamation! )
	dw_1.Event ue_Pos(1,"nr_ddd")
	Return False
End If

If LenA( ls_DDD ) < 2 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o DDD do telefone corretamente.", Exclamation! )
	dw_1.Event ue_Pos(1,"nr_ddd")
	Return False
End If

If IsNull( ls_Fone ) Or ls_Fone = "" Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o n$$HEX1$$fa00$$ENDHEX$$mero do telefone.", Exclamation! )
	dw_1.Event ue_Pos(1,"nr_fone_contato")
	Return False
End If

// Telefone preenchido deve ter o DDD preenchido corretamente, e o telefone deve ter no m$$HEX1$$ed00$$ENDHEX$$nimo 9 d$$HEX1$$ed00$$ENDHEX$$gitos sem incluir o DDD no mesmo campo
If LenA( ls_Fone ) < 8 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero do telefone informado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ valido.", Exclamation! )
	dw_1.Event ue_Pos(1,"nr_fone_contato")
	Return False
End If

If ls_DDD = LeftA( ls_Fone, 2 ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o preencha o DDD no mesmo campo do n$$HEX1$$fa00$$ENDHEX$$mero do telefone.", Exclamation! )
	dw_1.Event ue_Pos(1,"nr_fone_contato")
	Return False
End If

ps_fone_contato =  "(" +ls_DDD + ") " + ls_Fone

Return True

 
end function

public function integer wf_realiza_pagamento (string as_tipo_pagamento);Boolean lb_Duas_Vias

Date ldt_Inicio, ldt_Termino
String ls_Fone = ""
String ls_Responsavel
String ls_Selecao
String ls_Situacao, ls_Situacao_Aux
String ls_Matricula_Transf
String ls_Retorno_Impressora
String ls_Situacao_Cabecalho

Integer li_Dias, li_Sequencial_PRD, li_Find, li_Retorno

Long ll_Row, ll_Linhas
Long ll_Produto
Long ll_Qtde
Long ll_Sequencial_Cliente_Caixa
Long ll_Filial_Transf
Long ll_Count
Long ll_saldo_atual
Long ll_Qtde_reservada
Long ll_Pedido_Empurrado

Long ll_Saldo_CD
Long ll_Aux //SOmente para buscar o retorno da matriz (nao utilizado)

Decimal ldc_preco_unitario


Try
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	ll_Linhas 		= dw_2.RowCount()
	
 	If dw_2.Find( "id_selecao = 'S'", 1, ll_Linhas ) <= 0 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto marcado para cadastro da reserva." )
		Return -1
	End If
	
	li_Find = dw_2.Find( "qt_produto <= 0 and id_selecao = 'S'", 1, ll_Linhas )
	
	If li_Find > 0 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto com quantidade ZERO." )
		dw_2.Event ue_Pos( li_Find, "qt_produto" )
		Return -1
	End If	
	
	If as_tipo_pagamento = 'PA' Then
		If Not This.ib_permite_venda_sem_saldo Then
			li_Find = dw_2.Find( "id_selecao = 'S' and qt_saldo_atual <= 0", 1, ll_Linhas )
			
			If li_Find > 0 Then
				ll_Produto = dw_2.Object.cd_produto[li_Find]
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido realizar Pagamento Antecipado para produtos com saldo Zero.~r~rProduto: " +String(ll_Produto), Exclamation!)
				dw_2.Event ue_Pos( li_Find, "qt_produto" )
				Return -1
			End If			
		End If
	End If
		
	ldt_Inicio						= dw_1.Object.dh_inicio					[ 1 ]
	ldt_Termino					= dw_1.Object.dh_termino				[ 1 ]
	ls_Responsavel 			= dw_1.Object.nm_retirada				[ 1 ]
	li_Dias						= dw_1.Object.nr_dias_recorrencia 	[ 1 ]
	ls_Situacao_Cabecalho	= 'R'
	
	If Not wf_Telefone_OK( Ref ls_Fone )	Then Return -1

	If li_Dias = 0 Then SetNull( li_Dias ) 
	
	If IsNull( ls_Responsavel ) Or Trim(ls_Responsavel) = "" Then
		SetNull(ls_Responsavel)
	End If
	
	//Para os casos de transferencia entre filial a data de t$$HEX1$$e900$$ENDHEX$$rmino ter$$HEX1$$e100$$ENDHEX$$ 20 dias - Definido no PosOPEN()
	//A situa$$HEX2$$e700e300$$ENDHEX$$o da reserva ficar$$HEX1$$e100$$ENDHEX$$ com o Status T = "AGUARDANDO TRANSFERENCIA"
	If dw_2.Find( "not isNull(cd_filial_transferencia)", 1, ll_Linhas ) > 0 Then
		ls_Situacao_Cabecalho 	= 'T'
	End If
	
	io_Reserva.is_Situacao_Reserva = ls_Situacao_Cabecalho
	
	update cliente_caixa 
		Set nr_matricula_vendedor			= :io_Reserva.is_Vendedor,
			cd_cliente							= :io_Cliente.Cd_cliente,
			nm_cliente							= :io_Cliente.Nm_Cliente,	
			id_situacao							= :ls_Situacao_Cabecalho,
			id_tipo								= 'R',
			dh_inicio_reserva					= :ldt_Inicio,
			dh_termino_reserva				= :ldt_Termino,
			nr_fone_recado_reserva			= :ls_Fone,
			nm_recado_reserva				= :ls_Responsavel,
			nr_dias_reserva_recorrencia	= :li_Dias,
			id_avisou_cliente_reserva		= 'S'
	Where nr_sequencial 						= :io_Reserva.il_sequencial_cliente_caixa
		Using SqlCa;
		
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback( )
		SqlCa.of_MsgDbError("Erro ao gravar a reserva para o cliente.")
		Return -1
	Else
		
		ls_Situacao_Aux = ls_Situacao
		
		For ll_Row = 1 To ll_Linhas 
			ll_Pedido_Empurrado		= dw_2.Object.nr_Pedido_Empurrado			[ ll_Row ]
			ll_Produto 					= dw_2.Object.cd_produto							[ ll_Row ]
			ll_Qtde						= dw_2.Object.qt_produto							[ ll_Row ]
			ll_Qtde_reservada			= dw_2.Object.qt_reservada_ped_empurrado	[ ll_Row ] //Qtde pedido empurrado j$$HEX1$$e100$$ENDHEX$$ contabilizada na pr$$HEX1$$e900$$ENDHEX$$-reserva
			ls_Selecao 					= dw_2.Object.id_selecao							[ ll_Row ]
			li_Sequencial_PRD			= dw_2.Object.nr_sequencial						[ ll_Row ]	
			ll_Filial_Transf				= dw_2.Object.cd_filial_transferencia				[ ll_Row ]	
			ls_Matricula_Transf		= dw_2.Object.nr_matricula_transferencia		[ ll_Row ]
			ldc_preco_unitario			= dw_2.Object.vl_preco_unitario					[ ll_Row ]
			ll_saldo_atual				= dw_2.Object.qt_saldo_atual						[ ll_Row ]
						
			If ls_Selecao <> 'S' Then
				ls_Situacao = 'X'
			ElseIf IsNull( ll_Filial_Transf ) Then
				ls_Situacao = 'R'
			Else
				ls_Situacao = 'T'
			End If
			
			//Somente produto selecionado
			//Verifica quantidade na matriz para o pedido_urgente caso tenha alterado a quantidade
			If  ll_Filial_Transf = 534 And ls_Selecao = 'S' Then
				If Not io_Reserva.of_verifica_informacoes_matriz( ll_Produto, ll_Qtde, Ref ll_Aux, Ref ll_Saldo_CD, Ref ll_Aux, Ref ll_Aux) Then
					SqlCa.of_Rollback( )
					Exit
				End If
				
				//saldo cd + qtde reservada enteriormente Sit. Pendente
				If ll_Qtde > ( ll_Saldo_CD + ll_Qtde_reservada ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O Perini pode atender apenas " + String(ll_Qtde_reservada) + " UN do produto: " +String(ll_Produto) )
					dw_2.Object.qt_produto[ ll_Row ] = ll_Qtde_reservada
					dw_2.AcceptText()
					Return -1
				End If

			End If
			
			select count( cd_produto )
				Into :ll_Count
			from cliente_caixa_produto
			where cd_filial 								= :gvo_Parametro.Cd_Filial
				and nr_sequencial_cliente_caixa 	= :io_Reserva.il_sequencial_cliente_caixa
				and nr_sequencial						= :li_Sequencial_PRD
			Using SqlCa;			
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback( )
				SqlCa.of_MsgDbError("Erro ao localizar o produto reservado. Produto: " + String(ll_Produto))
				Return -1
			End If 
			
			If ll_Count > 0 Then
			
				update cliente_caixa_produto
					Set qt_produto						= :ll_Qtde,
						id_situacao						= :ls_Situacao,
						cd_filial_transferencia 		= :ll_Filial_Transf ,
						nr_matricula_transferencia 	= :ls_Matricula_Transf,
						nr_pedido_empurrado		= :ll_Pedido_Empurrado
				Where cd_filial								= :gvo_Parametro.Cd_Filial
					and nr_sequencial_cliente_caixa 	= :io_Reserva.il_sequencial_cliente_caixa
					and nr_sequencial						= :li_Sequencial_PRD
				Using SqlCa;
				
			Else
				
				Insert Into cliente_caixa_produto(
					cd_filial,
					nr_sequencial_cliente_caixa,
					nr_sequencial,
					cd_produto,
					qt_produto,
					id_situacao,
					cd_filial_transferencia,
					nr_matricula_transferencia,
					vl_preco_unitario,
					qt_saldo_atual,
					nr_pedido_empurrado)
				Values(
					:gvo_Parametro.Cd_Filial,
					:io_Reserva.il_sequencial_cliente_caixa,
					:li_Sequencial_PRD,
					:ll_Produto,
					:ll_Qtde,
					:ls_Situacao,
					:ll_Filial_Transf ,
					:ls_Matricula_Transf,
					:ldc_preco_unitario,
					:ll_saldo_atual,
					:ll_Pedido_Empurrado)
				Using SqlCa;
			End If
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback( )
				SqlCa.of_MsgDbError("Erro ao gravar os produtos da reserva para o cliente. Produto: " + String(ll_Produto))
				Return -1
			End If
			
		Next
		
	End If
	
	io_Reserva.ds_produtos.Reset()
	
	If Not io_Reserva.ds_produtos.Of_ChangeDataObject("dw_ge108_lista_reserva") Then
		SqlCa.of_Rollback( )
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao no evento Of_ChangeDataObject , ds dw_ge108_lista_reserva.")		
		Return -1
	End If
	
	If dw_2.RowsCopy(1, dw_2.RowCount(), Primary!, io_Reserva.ds_produtos, 1, Primary!) < 0 Then
		SqlCa.of_Rollback( )
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao copiar a dw_2 para a ds.")
		Return -1
	End if
	
	SqlCa.of_Commit();
	
	//Grava Informa$$HEX1$$e700$$ENDHEX$$oes matriz
	wf_grava_reserva_matriz( ls_Situacao_Cabecalho )
	
	//Finaliza o pedido empurrado na matriz
	io_Reserva.of_Finaliza_Pedido_Empurrado_Matriz(  )
	
	Open(w_ge108_impressao_etiqueta_reserva)
	
	ls_Retorno_Impressora = Message.StringParm
	
	Choose Case ls_Retorno_Impressora
		Case 'TERMICA'
			//A mensagem 
			io_Reserva.of_imprime_reserva(io_Reserva.il_sequencial_cliente_caixa, as_tipo_pagamento, True)
			
			If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja imprimir mais uma via?", Question!, YesNo!, 1 ) = 1 Then
				io_Reserva.of_imprime_reserva(io_Reserva.il_sequencial_cliente_caixa, as_tipo_pagamento, False)
			End If
			
		Case 'LASER'			
			Open(w_Aguarde)
			w_Aguarde.Title = "Imprimindo a etiqueta da reserva, aguarde..."
			dc_uo_ds_base lds
			lds = Create dc_uo_ds_base
			
			If Not lds.of_changeDataObject( "dw_rl076_etiqueta_composite" ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_changeDataObject, dw_rl076_etiqueta_composite." )
				Return -1
			End If
			
			lb_Duas_Vias = False
			
			If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja imprimir duas vias?", Question!, YesNo!, 1 ) = 1 Then
				lb_Duas_Vias = True
				li_Retorno = lds.Retrieve( io_Reserva.il_sequencial_cliente_caixa, io_Reserva.il_sequencial_cliente_caixa, 0, 0, 0, 0 )
			Else
				li_Retorno = lds.Retrieve( io_Reserva.il_sequencial_cliente_caixa, 0, 0, 0, 0, 0 )
			End If

			If li_Retorno < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve." )
				Return -1
			End If
			
			If li_Retorno > 0 Then
				//Pagamento Antecipado
				If as_tipo_pagamento = 'PA' Then
					//Somente para aparecer o campo "PAGO"
					lds.Object.dw_1.Object.nr_nf[ 1 ] = 1234
					
					If lb_Duas_Vias Then
						lds.Object.dw_2.Object.nr_nf[ 1 ] = 1234
					End If
				End If
				
				OPEN(w_ge033_prepara_impressora)
				lds.print( )		
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o para impress$$HEX1$$e300$$ENDHEX$$o." )
			End If
		
			If IsValid( lds ) Then Destroy lds 
			Close(w_Aguarde)
			
		Case 'X'
			//N$$HEX1$$e300$$ENDHEX$$o imprimir
			
	End Choose
	
	If as_Tipo_Pagamento = "PR" Then as_Tipo_Pagamento = "OK"
	
	io_Reserva.is_Retorno = as_Tipo_Pagamento
	
	CloseWithReturn( This, io_Reserva )
		
Catch (RuntimeError e)
		SqlCa.of_Rollback( )
		Messagebox("ERRO", e.GetMessage( ), StopSign! )
		Return -1
Finally
	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
End Try







end function

public function boolean wf_grava_reserva_matriz (string as_situacao_cabecalho);Long ll_Row, ll_Linhas
Long ll_Registros
Long ll_Produto, ll_Qtde, ll_Filial_Transf

Integer li_Sequencial_PRD, li_Retorno

String ls_Valores_Insert, ls_Selecao, ls_Retorno

String ls_Tabela, ls_Set, ls_Where

Date ldt_Inicio, ldt_Termino

Try

	dw_1.AcceptText()
	dw_2.AcceptText()
	
	ll_Linhas = dw_2.RowCount()
	
	ldt_Inicio 		= dw_1.Object.dh_Inicio			[ 1 ] 
	ldt_Termino 	= dw_1.Object.dh_Termino 	[ 1 ] 
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gravando dados da reserva na matriz, aguarde..."
	
	uo_transacao_remota lo_distribuido
	lo_distribuido = create uo_transacao_remota
	
	lo_distribuido.of_BancoProducao( )
	lo_distribuido.of_Define_Variaveis( True )

	lo_distribuido.of_executa_rotina( '0006', { "select count(nr_sequencial) retorno from cliente_caixa where cd_filial = " + String( gvo_Parametro.cd_filial ) + " and nr_sequencial = " + String( io_Reserva.il_sequencial_cliente_caixa ) } )	
	lo_distribuido.of_Retorno( 'retorno', Ref ls_Retorno ) 
	
	If lo_distribuido.of_Erro_Execucao( ) Or lo_distribuido.of_Erro_Conexao( ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o sequencial da cliente_caixa na matriz.~rFun$$HEX2$$e700e300$$ENDHEX$$o: wf_grava_reserva_matriz().", StopSign! )
		Return False
	End If
	
	li_Retorno = Integer( ls_Retorno )
	
	//Insert
	If li_Retorno = 0 Then
		ls_Valores_Insert = String( gvo_Parametro.Cd_Filial ) + ', ' + String( io_Reserva.il_sequencial_cliente_caixa ) + ", 0, '" + as_situacao_cabecalho + "', '" + String( ldt_Inicio, "YYYYMMDD") + "', 'R', '" + String( ldt_Inicio, "YYYYMMDD") + "', '" + String(ldt_Termino, "YYYYMMDD") + "' , 'S', '" + io_Reserva.is_Vendedor + "'"
		lo_distribuido.of_insert_registro( 'cliente_caixa', 'cd_filial, nr_sequencial, nr_ficha, id_situacao, dh_movimentacao, id_tipo, dh_inicio_reserva, dh_termino_reserva, id_avisou_cliente_reserva, nr_matricula_vendedor', ls_Valores_Insert, ll_Registros )		
	Else
		//Update
		ls_Tabela 	= 'cliente_caixa'
		ls_Set 		= "id_situacao = '" + as_situacao_cabecalho + "', id_tipo = 'R', dh_inicio_reserva = '" + String( ldt_Inicio, "YYYYMMDD") + "', dh_termino_reserva = '" +  String( ldt_Termino, "YYYYMMDD") + "', id_avisou_cliente_reserva = 'S' "
		ls_Where 	= "cd_filial = " + String( gvo_Parametro.Cd_Filial ) + " and nr_sequencial = " + String(  io_Reserva.il_sequencial_cliente_caixa ) 
	
		lo_Distribuido.of_update_registro( ls_Tabela, ls_Set, ls_Where, Ref ll_Registros )
	End If
	
	If lo_distribuido.of_Erro_Execucao( ) Or lo_Distribuido.of_erro_conexao( ) Then
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar os dados da reserva na matriz.~r~rAs informa$$HEX2$$e700f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o enviadas pelo sistema troca_dados." , Exclamation! )
		Return False
	End If
	
	
	For ll_Row = 1 To ll_Linhas
		li_Retorno 					= 0
		ll_Produto 					= dw_2.Object.cd_produto						[ ll_Row ]
		ll_Qtde						= dw_2.Object.qt_produto						[ ll_Row ]
		ls_Selecao 					= dw_2.Object.id_selecao						[ ll_Row ]
		li_Sequencial_PRD			= dw_2.Object.nr_sequencial					[ ll_Row ]	
		ll_Filial_Transf				= dw_2.Object.cd_filial_transferencia			[ ll_Row ]	
		ls_Selecao					= dw_2.Object.id_selecao						[ ll_Row ]
		
		If Not IsNull( ll_Filial_Transf ) Or ls_Selecao = 'N'  Then
			Continue
		End If
		
		lo_distribuido.of_executa_rotina( '0006', { "select count(nr_sequencial) retorno from cliente_caixa_produto where cd_filial = " + String( gvo_Parametro.cd_filial ) + " and nr_sequencial_cliente_caixa = " + String( io_Reserva.il_sequencial_cliente_caixa ) + " + and nr_sequencial = " + String( li_Sequencial_PRD ) } )
		lo_distribuido.of_Retorno( 'retorno', Ref ls_Retorno ) 
	
		li_Retorno = Integer( ls_Retorno )
		
		If li_Retorno = 0 Then
			ls_Valores_Insert = String( gvo_Parametro.Cd_Filial ) + ', ' + String( io_Reserva.il_sequencial_cliente_caixa ) + ', ' + String(li_Sequencial_PRD) + ', ' + String( ll_Produto) + ', ' + String( ll_Qtde) + ", 'R'" 
			lo_distribuido.of_insert_registro( 'cliente_caixa_produto', 'cd_filial, nr_sequencial_cliente_caixa, nr_sequencial, cd_produto, qt_produto, id_situacao ', ls_Valores_Insert, ll_Registros )
		Else
			//Update
			ls_Tabela 	= 'cliente_caixa_produto'
			ls_Set 		= "qt_produto = " + String( ll_Qtde ) + ", id_situacao = 'R'"
			ls_Where 	= "cd_filial = " + String( gvo_Parametro.Cd_Filial ) + " and nr_sequencial_cliente_caixa = " + String(  io_Reserva.il_sequencial_cliente_caixa ) 
		
			lo_Distribuido.of_update_registro( ls_Tabela, ls_Set, ls_Where, Ref ll_Registros )
		End If
		
		If lo_distribuido.of_Erro_Execucao( ) Or lo_Distribuido.of_erro_conexao( ) Then
			Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar os produtos da reserva na matriz.~r~rAs informa$$HEX2$$e700f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o enviadas pelo sistema troca_dados.", StopSign! )
			Return False
		End If	
			
	Next
	
	Return True
	
Finally
	If IsValid( lo_distribuido ) Then Destroy lo_distribuido	
	Close( w_Aguarde )
End Try

end function

on w_ge108_reserva_produto.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_antecipado=create cb_antecipado
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_antecipado
this.Control[iCurrent+3]=this.gb_2
end on

on w_ge108_reserva_produto.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_antecipado)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;String ls_DDD, ls_Telefone

Date ldt_Parametro

io_Produto 		= Create uo_Produto 
io_Cliente		= Create uo_Cliente
io_parametro 	= Create uo_parametro_filial

io_parametro.of_localiza_parametro( 'ID_PERMITE_VENDA_SEM_SALDO', ref ib_Permite_Venda_Sem_Saldo )

ldt_Parametro = Date(gvo_Parametro.dh_movimentacao)

If Not IsNull( io_Reserva.is_Cliente ) Then
	io_Cliente.of_localiza_codigo( io_Reserva.is_Cliente )
	
	If io_Cliente.Localizado Then
		dw_1.Object.Nm_Cliente			[ 1 ] = io_Cliente.Nm_Cliente
		dw_1.Object.Cd_Cliente			[ 1 ] = io_Cliente.Cd_Cliente
	
		// Utiliza o telefone que estiver cadastrado no cliente, podendo ser residencial, celular ou comercial, nesta ordem
		If Not IsNull( io_Cliente.nr_fone ) And Trim( io_Cliente.nr_fone ) <> "" Then
			ls_DDD =  io_Cliente.nr_ddd_fone
			ls_Telefone = io_Cliente.nr_fone
		Else
			If Not IsNull( io_Cliente.nr_fone_celular ) And Trim( io_Cliente.nr_fone_celular ) <> "" Then
				ls_DDD =  io_Cliente.nr_ddd_celular
				ls_Telefone = io_Cliente.nr_fone_celular
			Else
				If Not IsNull( io_Cliente.nr_fone_comercial ) And Trim( io_Cliente.nr_fone_comercial ) <> "" Then
					ls_DDD =  io_Cliente.nr_ddd_comercial
					ls_Telefone = io_Cliente.nr_fone_comercial
				End If
			End If
		End If
					
		dw_1.Object.nr_ddd				[ 1 ] = ls_DDD
		dw_1.Object.nr_fone_contato	[ 1 ] = ls_Telefone
	End If
End If

pb_Help.Visible = True

//Insere Produtos na dw_2
wf_carrega_produtos()

//Inicio Reserva
dw_1.Object.Dh_Inicio		[ 1 ] = ldt_Parametro

//Termino Reserva
//Verifica se existe filial de trans. informada para alterar o periodo da vigencia.
If dw_2.find("Not IsNull(cd_filial_transferencia)", 1, dw_2.RowCount() ) > 0 Then
	dw_1.Object.Dh_Termino	[ 1 ] = RelativeDate( ldt_Parametro, 23 )
Else
	dw_1.Object.Dh_Termino	[ 1 ] = RelativeDate( ldt_Parametro, 3 )
End If









end event

event close;call super::close;If IsValid( io_Produto ) 		Then Destroy io_Produto
If IsValid( io_Cliente ) 		Then Destroy io_Cliente
If IsValid( io_parametro ) 	Then Destroy io_parametro

end event

event ue_preopen;call super::ue_preopen;io_Reserva = Message.PowerObjectParm
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_reserva_produto
integer x = 27
integer y = 1356
end type

event pb_help::clicked;call super::clicked;wf_Help( "Reserva de Produto (GE108)" )
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_reserva_produto
integer width = 2761
integer height = 348
string text = "Cliente"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_reserva_produto
integer x = 41
integer y = 76
integer width = 2720
integer height = 252
string dataobject = "dw_ge108_selecao_reserva"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_reserva_produto
integer x = 1513
integer y = 1372
integer width = 754
string text = "Pagamento na &retirada"
boolean default = false
end type

event cb_ok::clicked;//Pagamento na retirada
//Finaliza a reserva e fecha a tela

If io_Reserva.is_cobre_preco = 'S' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem produtos negociados via Cobre Pre$$HEX1$$e700$$ENDHEX$$o.~r~rNecess$$HEX1$$e100$$ENDHEX$$rio pagamento antecipado.", Exclamation!)
	Return -1
End If

wf_Realiza_Pagamento( "PR" )

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_reserva_produto
integer x = 2459
integer y = 1372
integer width = 325
end type

event cb_cancelar::clicked;//OverRide

String ls_Null

SetNull( ls_Null )
io_Reserva.is_Retorno = ls_Null

CloseWithReturn(Parent, io_Reserva)
end event

type dw_2 from dc_uo_dw_base within w_ge108_reserva_produto
integer x = 69
integer y = 436
integer width = 2693
integer height = 892
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_lista_reserva"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

event doubleclicked;call super::doubleclicked;//String ls_Marcacao
//
//Integer li_Row
//		  
//If dwo.Name = "id_selecionar" Then
//	If ib_Check Then
//		ls_Marcacao = 'N'
//	Else
//		ls_Marcacao = 'S'
//	End If
//		
//	ib_Check = ( ls_Marcacao = 'S' )
//	
//	For li_Row = 1 To This.RowCount()
//		This.Object.id_selecao[ li_Row ] = ls_Marcacao
//	Next
//End If
end event

event editchanged;call super::editchanged;Long ll_Qtde

If Not IsNull( This.Object.nr_pedido_empurrado[ row ] ) And  This.Object.nr_pedido_empurrado[ row ] > 0 Then
	ll_Qtde = This.Object.qt_produto[ row ] 
	This.Object.qt_produto[ row ] = ll_Qtde
	Return -1
End If
end event

type cb_antecipado from commandbutton within w_ge108_reserva_produto
integer x = 576
integer y = 1372
integer width = 754
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Pagamento &antecipado"
end type

event clicked;//Pagamento Antecipado
//Finaliza a reserva e cadastra uma cesta


wf_Realiza_Pagamento( "PA" )


end event

type gb_2 from groupbox within w_ge108_reserva_produto
integer x = 18
integer y = 368
integer width = 2766
integer height = 980
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos da Reserva"
borderstyle borderstyle = styleraised!
end type

