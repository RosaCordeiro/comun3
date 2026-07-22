HA$PBExportHeader$uo_ge108_reserva_produtos.sru
forward
global type uo_ge108_reserva_produtos from nonvisualobject
end type
end forward

global type uo_ge108_reserva_produtos from nonvisualobject
end type
global uo_ge108_reserva_produtos uo_ge108_reserva_produtos

type variables
Long il_Produtos		[]
Long il_Qtdes			[]
Long il_Seq				[]
Long il_Filial_transf	[]

String is_Cliente
String is_Vendedor

String is_Retorno

Long il_Sequencial_Cliente_caixa

String is_Cobre_Preco = 'N'
String is_Situacao_Reserva

Boolean ib_Disque_Entrega = False

dc_uo_ds_base ds_produtos
end variables
forward prototypes
public function integer of_verifica_pendencia (boolean pb_abre_lista)
public function boolean of_finaliza_pedido_empurrado_matriz ()
public function boolean of_verifica_informacoes_matriz (long al_produto, long al_qtde_solicitada, ref long al_nr_pedido, ref long al_qtde_cd, ref long al_qt_minima, ref long al_mix_produto)
public function boolean of_situacao_pedido_matriz (long al_pedido, ref string as_situacao)
public function boolean of_atualiza_ped_urgente_matriz (long al_nr_pedido, string as_situacao, long al_produto, long al_qtde_empurrada, string as_matricula)
public function boolean of_imprime_reserva (long pl_sequencial, string al_tipo_pagamento, boolean pb_msg)
public function boolean of_atualiza_ped_urgente_matriz (long al_nr_pedido, string as_situacao, long al_produto, long al_qtde_empurrada)
public function boolean of_grava_ped_urgente_matriz (long al_nr_pedido, string as_vendedor, long al_produto, long al_qtde_empurrada, string as_nr_cpf)
public function boolean of_busca_data_inicio_sap (ref date pdt_data, ref string ps_log)
public function boolean of_busca_ambiente (ref string ps_ambiente, ref string ps_log)
public function boolean of_verifica_geracao_pedido_matriz (ref string as_log)
end prototypes

public function integer of_verifica_pendencia (boolean pb_abre_lista);//Verifica se existe Reservas pendentes
Long ll_Retorno

String ls_msg = "Local: uo_ge108_reserva_produtos.of_verifica_pendencia()"

Try
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_changedataobject( "dw_ge108_lista_reserva_pendente" ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_changeDataObject. " + ls_msg)
		Return -1
	End If
	
	ll_Retorno = lds.Retrieve()
	
	If IsValid( lds ) Then Destroy lds
	
	If ll_Retorno < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve." + ls_msg )
		Return -1
	End If
	
	If ll_Retorno > 0 And pb_Abre_Lista Then
		Open( w_ge108_reserva_pendente )
	End If
	
	Return ll_Retorno
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r"  + ls_msg, StopSign! )

Finally
	Destroy lds
End Try
end function

public function boolean of_finaliza_pedido_empurrado_matriz ();Long ll_Find, ll_Row, ll_Linhas

Long ll_Pedido_Empurrado, ll_Qtde_Pedida, ll_Qtde_Minima_Aprovacao
Long ll_Mix_Produto, ll_Produto, ll_filial_Transferencia

String ls_Situacao, ls_Mensagem

Decimal ldc_Qtde_Fracionada

Integer li_Posicao, li_Aux


ll_Linhas = This.ds_Produtos.RowCount()

ll_Find = This.ds_produtos.Find( "cd_filial_transferencia = 534", 0,  ll_Linhas )

//Retorna True, pois nao h$$HEX1$$e100$$ENDHEX$$ reserva para o CD
If ll_Find = 0 Then Return True

Try
	
	uo_Produto lo_Produto
	lo_Produto = Create uo_Produto
	
	For ll_Row = 1 To ll_Linhas
		ll_filial_Transferencia =  This.ds_Produtos.Object.cd_filial_transferencia [ ll_Row ]
		
		If IsNull( ll_filial_Transferencia ) Or ( ll_filial_Transferencia <> 534 ) Then
			Continue
		End If
			
		ll_Pedido_Empurrado			= This.ds_Produtos.Object.nr_Pedido_Empurrado	[ ll_Row ]
		ll_Mix_Produto					= This.ds_Produtos.Object.cd_mix_produto			[ ll_Row ]		 
		ll_Qtde_Pedida					= This.ds_Produtos.Object.qt_produto				[ ll_Row ]				
		ll_Qtde_Minima_Aprovacao	= This.ds_Produtos.Object.qt_minima_aprovacao	[ ll_Row ]
		ll_Produto						= This.ds_Produtos.Object.cd_produto				[ ll_Row ]
		
		lo_Produto.of_Localiza_codigo_interno( ll_Produto )
			
		If lo_Produto.vl_fator_conversao > 1 Then
			ldc_Qtde_Fracionada = Round( ll_Qtde_Pedida / lo_Produto.vl_fator_conversao, 2 )
			
			li_Posicao = PosA( String(ldc_Qtde_Fracionada), ',' )
			
			li_Aux = Integer( Mid( String( ldc_Qtde_Fracionada ), li_Posicao + 1))
			
			If li_Aux > 0 then li_Aux = 1 
				
			ll_Qtde_Pedida = Int(ldc_Qtde_Fracionada + li_Aux)
			
		End If	
		
		If This.ds_Produtos.Object.id_selecao [ ll_Row ] = "N" Or ll_Qtde_Pedida = 0 Then
			ls_Situacao = 'X'
		Else
			If ll_Mix_Produto = 20 Or ( ll_Qtde_Pedida > ll_Qtde_Minima_Aprovacao ) Then
				ls_Situacao = "B"
			Else
				ls_Situacao = "C"
			End If
		End If
		
		If Not This.of_Atualiza_Ped_Urgente_Matriz( ll_Pedido_Empurrado, ls_Situacao, ll_Produto, ll_Qtde_Pedida) Then		
			Return False
		End If
		
		//Envia e-mail GC
		If ls_Situacao = "B" Then
			ls_Mensagem = "<font color='red' face='verdana' size='4'>Aten$$HEX2$$e700e300$$ENDHEX$$o</font><br /><br />"
			ls_Mensagem += "O produto necessita de aprova$$HEX2$$e700e300$$ENDHEX$$o para ser faturado.<br /><br />"
			ls_Mensagem += "Pedido: " + String( ll_Pedido_Empurrado ) + "<br />"
			ls_Mensagem += "Produto: " + String(lo_Produto.Cd_Produto) + " - " + lo_Produto.ivs_descricao_apresentacao_venda + "<br />"
			ls_Mensagem += "Qtde Pedida: " + String(ll_Qtde_Pedida) + "<br />"
			ls_Mensagem += "Fator Convers$$HEX1$$e300$$ENDHEX$$o: " + String( lo_Produto.vl_fator_conversao, "#,##0" ) + "<br />" 
			ls_Mensagem += "Mix Produto: " + String( ll_Mix_Produto )
			
			gf_ge202_envia_email_log (151, "Aprova$$HEX2$$e700e300$$ENDHEX$$o de Pedido Urgente - Filial " + String( gvo_Parametro.Cd_Filial  ) , ls_Mensagem, True, False)
			
		End If
		
	Next
	
Finally
	If IsValid( lo_Produto ) Then Destroy lo_Produto
End try

Return True
end function

public function boolean of_verifica_informacoes_matriz (long al_produto, long al_qtde_solicitada, ref long al_nr_pedido, ref long al_qtde_cd, ref long al_qt_minima, ref long al_mix_produto);String ls_Retorno, ls_log, ls_url, ls_ambiente
Boolean lb_Sucesso = False
long ll_qt_pendente
Date ldt_inicio_sap, ldt_atual

Try
	SetNull(al_nr_pedido)
	SetNull(al_qtde_cd)
	SetNull(al_qt_minima)
	SetNull(al_mix_produto)
	
	uo_ge108_consulta_estoque_sap luo_saldo_sap
	luo_saldo_sap = Create uo_ge108_consulta_estoque_sap
	
	uo_Transacao_Remota lo_Conexao
	lo_Conexao = Create uo_Transacao_Remota
	
	lo_Conexao.of_BancoProducao( )
	lo_Conexao.of_Define_Variaveis( True )	
	
	If not this.of_busca_ambiente( ref ls_ambiente, ref ls_log ) Then return false
	
	//lo_Conexao.of_executa_rotina( '0143',{ String( gvo_Parametro.cd_filial ) , String( al_produto ) } )
	lo_Conexao.of_executa_rotina( '0145',{ String( gvo_Parametro.cd_filial ) , String( al_produto ), 'CD_URL_CONSULTA_ESTOQUE', ls_ambiente } )
	lo_Conexao.of_retorno_dados(Ref ls_Retorno)
	
	If lo_Conexao.of_Erro_Execucao( ) Or lo_Conexao.of_Erro_Conexao( ) Then
	 	gvo_Aplicacao.of_grava_log( "RESERVA CD - Erro ao localizar o saldo no cd. Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_verifica_informacoes_matriz()" ) 
		
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o saldo no cd.~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_verifica_informacoes_matriz()", StopSign! )
		Return False
	End If
	
	lb_Sucesso = lo_Conexao.of_Retorno( 'nr_ultimo_seq', 		Ref al_nr_pedido )  	And &
					  lo_Conexao.of_Retorno( 'qt_prod_cd', 			Ref al_qtde_cd ) 		And &
					  lo_Conexao.of_Retorno( 'qt_minima', 			Ref al_qt_minima )	And &
					  lo_Conexao.of_Retorno( 'cd_mix_produto', 	Ref al_mix_produto ) And &
					  lo_Conexao.of_Retorno( 'de_url', 				Ref ls_url )			    And &
					  lo_Conexao.of_Retorno( 'qt_pendente', 		Ref ll_qt_pendente )  
	
	If Not lb_Sucesso Then
		gvo_Aplicacao.of_grava_log( "RESERVA CD - Erro ao localizar os dados na matriz. Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_verifica_informacoes_matriz()" ) 
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os dados na matriz.~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_verifica_informacoes_matriz() ")
		Return False
	End If
	
	ldt_atual = Date(gf_getserverdate())
	
	if Not of_busca_data_inicio_sap(ref ldt_inicio_sap, ref ls_log) Then
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
		Return false
	end if
	
	if  date(ldt_inicio_sap) <> date('01/01/1900') and (ldt_atual >= ldt_inicio_sap) then
	
		if Not	luo_saldo_sap.of_consulta_estoque( gvo_Parametro.cd_filial, al_produto, ls_url, ref al_qtde_cd, ref ls_log )Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os dados na matriz. ~n Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_verifica_informacoes_matriz() ~n " + ls_log)
			Return False
		End If
		
		if ll_qt_pendente > 0 Then
			al_qtde_cd = al_qtde_cd - ll_qt_pendente
		end if
		
	End if
	
	If al_qtde_cd < 0 Then al_qtde_cd = 0
	
//	If al_qtde_cd <= 0 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto " + String( al_produto ) + " n$$HEX1$$e300$$ENDHEX$$o possui saldo no CD.", Exclamation!)
//		Return False
//	End If
	
Finally
	If IsValid( lo_Conexao ) Then Destroy lo_Conexao
	destroy(luo_saldo_sap)
End Try
end function

public function boolean of_situacao_pedido_matriz (long al_pedido, ref string as_situacao);String ls_Retorno

Boolean lb_Sucesso = False

Try
	SetNull(as_Situacao)
	
	uo_Transacao_Remota lo_Conexao
	lo_Conexao = Create uo_Transacao_Remota
	
	lo_Conexao.of_BancoProducao( )
	lo_Conexao.of_Define_Variaveis( True )
	
	lo_Conexao.of_executa_rotina( '0006', { "select id_situacao from pedido_empurrado where cd_filial = " + String( gvo_Parametro.cd_filial ) + " and nr_pedido_empurrado = " + String( al_Pedido ) } )
	lo_Conexao.of_retorno_dados(Ref ls_Retorno)
	
	If lo_Conexao.of_Erro_Execucao( ) Or lo_Conexao.of_Erro_Conexao( ) Then
		gvo_Aplicacao.of_grava_log( 'RESERVA CD - Erro ao localizar o saldo no cd. Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_situacao_pedido_matriz()' )
		
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o saldo no cd.~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_situacao_pedido_matriz().", StopSign! )
		Return False
	End If
	
	lb_Sucesso = lo_Conexao.of_Retorno( 'id_situacao', 	Ref as_Situacao ) 
	
	If Not lb_Sucesso Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os dados na matriz.~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_situacao_pedido_matriz().")
		Return False
	End If
	
	If IsNull( as_Situacao ) Or Trim(as_Situacao) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido na matriz.~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_situacao_pedido_matriz().")
		Return False
	End If
	
Finally
	If IsValid( lo_Conexao ) Then Destroy lo_Conexao
End Try
end function

public function boolean of_atualiza_ped_urgente_matriz (long al_nr_pedido, string as_situacao, long al_produto, long al_qtde_empurrada, string as_matricula);String ls_Where, ls_Tabela, ls_Set
String ls_Situacao_Matriz

Long ll_Produto
Long ll_Registros
Long ll_Qtde_Aprovada

String ls_Erro
String ls_Email_Erro

Try
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando pedido urgente na matriz, aguarde..."
	
	uo_transacao_remota lo_distribuido
	lo_distribuido = create uo_transacao_remota
	
	lo_distribuido.of_BancoProducao( )
	lo_distribuido.of_Define_Variaveis( True )
	
	//Pedido empurrado
	ls_Tabela 	= "pedido_empurrado"
	
	If as_situacao = 'X' Then
		
		This.of_situacao_pedido_matriz( al_nr_pedido, Ref ls_Situacao_Matriz )
		
		//Colocado // Cancelado //Pendente
		If ls_Situacao_Matriz <> 'C' And ls_Situacao_Matriz <> 'X' And ls_Situacao_Matriz <> 'P' Then
			gvo_Aplicacao.of_grava_log( "RESERVA CD - O pedido " +String(al_nr_Pedido) + " teve a Situa$$HEX2$$e700e300$$ENDHEX$$o alterada na matriz e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser cancelado. Apenas a reserva foi cancelada." )
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido " +String(al_nr_Pedido) + " teve a Situa$$HEX2$$e700e300$$ENDHEX$$o alterada na matriz e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser cancelado.~r~rApenas a reserva foi cancelada.", Exclamation!)
			Return False
		End If
		
		If Not IsNull(as_matricula) And Trim(as_matricula) <> "" Then
			ls_Set 		= "id_situacao = '" + as_situacao + "', dh_cancelamento = getdate(), nr_matricula_cancelamento = '" + as_matricula + "'"
		Else
 			ls_Set 		= "id_situacao = '" + as_situacao + "', dh_cancelamento = getdate(), nr_matricula_cancelamento = nr_matricula_inclusao"
		End If
	Else
		ls_Set 		= "id_situacao = '" + as_situacao + "', dh_inclusao = getdate() "
	End If
	
 	ls_Where 	= "cd_filial = " + String( gvo_Parametro.Cd_Filial ) + " and nr_pedido_empurrado = " + String( al_nr_pedido )
	
	lo_distribuido.of_update_registro( ls_Tabela, ls_Set, ls_Where, Ref ll_Registros, Ref ls_Erro )
			
	If lo_distribuido.of_Erro_Execucao( ) Or lo_Distribuido.of_erro_conexao( ) Or Trim(ls_Erro) <> "" Then
		gvo_Aplicacao.of_grava_log( "RESERVA CD - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o pedido urgente na matriz. Erro na conex$$HEX1$$e300$$ENDHEX$$o do distribuido (pedido_empurrado). Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ped_urgente_matriz(). Pedido:" + String(al_nr_pedido))
		
		ls_Email_Erro = "Pedido Empurrado: " + String( al_nr_pedido ) +&
							 " Filial: " +  String( gvo_Parametro.Cd_Filial  )	 +&
							 " Erro: N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o pedido urgente na matriz. Erro na conex$$HEX1$$e300$$ENDHEX$$o do distribuido (pedido_empurrado). Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ped_urgente_matriz() " + ls_Erro
		
		gf_ge202_envia_email_log (63, "RESERVA CD ( Pedido Urgente ) " + String( gvo_Parametro.Cd_Filial  ) , ls_Email_Erro, True, False)
	
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o pedido urgente na matriz.~r~rErro na conex$$HEX1$$e300$$ENDHEX$$o do distribuido (pedido_empurrado).~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ped_urgente_matriz()" , StopSign! )
		Return False
	End If
	
	//Pedido empurrado Produto	
	ls_Tabela 	= 'pedido_empurrado_produto'
	ls_Set 		= "id_situacao = '" + as_situacao + "', qt_empurrada = " + String( al_qtde_empurrada ) + ", qt_aprovada = " + IIF( as_situacao = "B", '0', String(al_qtde_empurrada) ) 
 	ls_Where 	= "cd_filial = " + String( gvo_Parametro.Cd_Filial ) + " and nr_pedido_empurrado = " + String( al_nr_pedido ) + " and cd_produto = " + String( al_produto )
	
	lo_Distribuido.of_update_registro( ls_Tabela, ls_Set, ls_Where, Ref ll_Registros )
	
	If lo_distribuido.of_Erro_Execucao( ) Or lo_Distribuido.of_erro_conexao( ) Then
		gvo_Aplicacao.of_grava_log( "RESERVA CD - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o pedido urgente na matriz. Erro na conex$$HEX1$$e300$$ENDHEX$$o do distribuido (pedido_empurrado_produto). Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ped_urgente_matriz()")
		
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o pedido urgente na matriz.~r~rErro na conex$$HEX1$$e300$$ENDHEX$$o do distribuido (pedido_empurrado_produto).~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ped_urgente_matriz()" , StopSign! )
		Return False
	End If	
				
	Return True
	
Finally
	If IsValid( lo_distribuido ) Then Destroy lo_distribuido	
	Close( w_Aguarde )
End Try

end function

public function boolean of_imprime_reserva (long pl_sequencial, string al_tipo_pagamento, boolean pb_msg);Boolean lb_Sucesso

Long ll_Retorno, ll_Nr_NF
Long ll_Row
String  ls_Texto, ls_dados[], ls_fil, ls_usu
Integer i, li_retorno

LongLong ll_Job

String ls_Impressora_Padrao
String ls_Fabricante, ls_Nm_Impressora
String ls_Ini

Try

	ls_Impressora_Padrao = PrintGetPrinter()	
	ls_Impressora_Padrao=left(ls_Impressora_Padrao, pos(ls_Impressora_Padrao, "~t") -1)
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_changeDataObject( "dw_rl076_etiquetas_termica" ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_changeDataObject.")
		Return False
	End If
	
	ll_Retorno = lds.Retrieve( pl_sequencial )
	
	If ll_Retorno < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve." )
		Return False
	End If
	
	If ll_Retorno = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o para impress$$HEX1$$e300$$ENDHEX$$o." )
		Return False
	End If
	
	ls_Ini = gvo_Aplicacao.ivs_Arquivo_INI
	If IsNull(ls_INI) Or Trim(ls_INI) = "" Then
		Return True
	End If
			
	// Verifica se o caminho dos arquivos de ajuda est$$HEX1$$e300$$ENDHEX$$o especificados no INI
	ls_Fabricante			= ProfileString(ls_INI, "ECF" , "Modelo","")
	ls_Nm_Impressora 	= ProfileString(ls_INI, "ECF" , "NomeImpressora" , "")
	
	If ls_Fabricante = 'NFCE' Or ls_Fabricante = "SAT" Then		
		If IsNull(ls_Nm_Impressora) Or Trim(ls_Nm_Impressora) = '' Then
			 Messagebox("NFC-e","Nome da Impressora NFC-e n$$HEX1$$e300$$ENDHEX$$o definida no INI do Retaguarda!"+&
								" Avise o SAF.", StopSign!)
			 Return False
		End If
		
		If al_tipo_pagamento = 'PA' Then
			//Apenas para mostrar o campo PAGO
			lds.Object.nr_nf [1] = 1234
		End If
		
		li_retorno = PrintSetPrinter ( ls_Nm_Impressora )			
		If li_retorno <> 1 Then
			gvo_Aplicacao.of_grava_log( "Erro ao setar a impressora NFCE para imprimir os consentimentos do cliente.")
			Return False
		End If
		
		ll_Job = PrintOPen()
		PrintDataWindow (ll_Job, lds)
		li_retorno = PrintClose(ll_Job)
			
		If li_Retorno <> 1 Then
			gvo_Aplicacao.of_grava_log( "Erro no evento PrintClose(). Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_imprime_reserva()")
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento PrintClose(). Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_imprime_reserva()",StopSign!)
			Return False
		End If
		
		lb_Sucesso = (li_Retorno = 1)
				
		//Volta a impressora default
		li_retorno = PrintSetPrinter ( ls_Impressora_Padrao )			
		If li_retorno <> 1 Then
			gvo_Aplicacao.of_grava_log( "Erro ao setar a impressora padrao.")
		End If
		
	Else
//		//Impressora fiscal
		If pb_msg Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio que somente o sistema de Retaguarda esteja operando agora. Portanto feche todas as " + &
										"janelas do caixa que eventualmente estejam ativas.",Exclamation!)
		End If
	
		If Not IsValid (PDV ) Then
			PDV = Create uo_pdv
		End If	
		If Not IsValid (SITEF ) Then //Tem que criar pois $$HEX1$$e900$$ENDHEX$$ usado na Bematech.
			SITEF = Create uo_sitef
		End If			
				
		For ll_Row = 1 To lds.RowCount()
			If IsNull(lds.Object.filial_transferencia[ll_row]) Then
				ls_fil = ""
			Else
				ls_fil = lds.Object.filial_transferencia[ll_row]
			End If
			If IsNull(lds.Object.usuario_transferencia[ll_row]) Then
				ls_usu = ""
			Else
				ls_usu = lds.Object.usuario_transferencia[ll_row]
			End If
						
			If ll_Row = 1 Then //Monta cabe$$HEX1$$e700$$ENDHEX$$alho
				ll_Nr_NF = lds.Object.nr_nf [ll_row]
			
				i++; ls_dados[ i ] = PDV.of_Centraliza_Texto("Reserva de Produtos para Cliente")			
				i++; ls_dados[ i ] = Space(48)	
				//Pagamento Antecipado
				If al_tipo_pagamento = 'PA' Or ( Not isNull( ll_Nr_NF) And ll_Nr_NF > 0 ) Then
					i++; ls_dados[ i ] = PDV.of_Centraliza_Texto ('--------------------')
					i++; ls_dados[ i ] = PDV.of_Centraliza_Texto ('-       PAGO       -')
					i++; ls_dados[ i ] = PDV.of_Centraliza_Texto ('--------------------')
				End If
				i++; ls_Dados[ i ] = "Nr Reserva: "  + String( pl_Sequencial ) + "   Data: " + String( lds.Object.dh_movimentacao[ll_row], "dd/mm/yyyy" )
				i++; ls_Dados[ i ] = "Nome: "  + lds.Object.nm_cliente[ll_row]
				i++; ls_Dados[ i ] = "Contato: "  + lds.Object.nr_fone_recado_reserva[ll_row] + "     CPF: " + lds.Object.nr_cpf_cgc[ll_row]
				i++; ls_Dados[ i ] = "Vendedor: " + lds.Object.vendedor[ll_row]
				i++; ls_Dados[ i ] = "Entrou em contato com o cliente? SIM (    ) / N$$HEX1$$c300$$ENDHEX$$O (   )"
				i++; ls_Dados[ i ] = Space(48)
				i++; ls_dados[ i ] = PDV.of_Centraliza_Texto("Lista de Produtos")
				i++; ls_Dados[ i ] = Space(48)			
				//Produtos
				i++; ls_dados[ i ]  = "Produto: " + String(lds.Object.cd_produto[ll_row]) + " - " + lds.Object.de_produto[ll_row]
				i++; ls_dados[ i ]  = "Qtde.: " + String(lds.Object.qt_produto[ll_row]) + "     Filial Transf.: " + ls_fil
				i++; ls_dados[ i ]  = "              Resp. Transf.: " + ls_usu
			Else
				//Produtos
				i++; ls_dados[ i ]  = FillA('-',48)
				i++; ls_dados[ i ]  = "Produto: " + String(lds.Object.cd_produto[ll_row]) + " - " + lds.Object.de_produto[ll_row]
				i++; ls_dados[ i ]  = "Qtde.: " + String(lds.Object.qt_produto[ll_row]) + "     Filial Transf.: " + ls_fil
				i++; ls_dados[ i ]  = "              Resp. Transf.: " + ls_usu			
			End If				
		Next
		i++; ls_dados[ i ] = Space(48)
		PDV.of_emite_comprovante("", ls_Dados[] )
		PDV.of_fechaporta()			
		
	End If 
	
	Return True
	
Finally
	If IsValid( lds ) 		Then Destroy lds
	If IsValid( PDV ) 	Then Destroy PDV
	If IsValid( SITEF ) 	Then Destroy SITEF
End Try
end function

public function boolean of_atualiza_ped_urgente_matriz (long al_nr_pedido, string as_situacao, long al_produto, long al_qtde_empurrada);String ls_Matricula

SetNull(ls_Matricula)

Return This.of_atualiza_ped_urgente_matriz( al_nr_pedido, as_situacao, al_produto, al_qtde_empurrada, ls_Matricula )
end function

public function boolean of_grava_ped_urgente_matriz (long al_nr_pedido, string as_vendedor, long al_produto, long al_qtde_empurrada, string as_nr_cpf);String ls_Valores_Insert, ls_Tabela, ls_Colunas

Long ll_Produto
Long ll_Registros
Long ll_Qtde_Aprovada

Try	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gravando pedido urgente na matriz, aguarde..."
	
	uo_transacao_remota lo_distribuido
	lo_distribuido = create uo_transacao_remota
	
	lo_distribuido.of_BancoProducao( )
	lo_distribuido.of_Define_Variaveis( True )
	
	//Pedido empurrado
	ls_Tabela = 'pedido_empurrado'
	
	ls_Colunas = 'cd_filial, nr_pedido_empurrado, dh_emissao, id_processado, id_situacao, id_tipo_pedido, id_reserva_saldo_cd, dh_inclusao, nr_matricula_inclusao, cd_distribuidora, nr_cpf_cliente, nr_pedido_sap'
	
 	ls_Valores_Insert	=	String( gvo_Parametro.Cd_Filial ) + ", " + &
						String( al_nr_pedido ) + ", " + &
						"'" + String( gvo_Parametro.of_dh_movimentacao( ), "YYYY/MM/DD" ) + "', " + &
						"'N', 'P', 'U', 'S', getdate(), " + &
						"'" + as_vendedor + "', '053404705'," + &
						"'" + as_nr_cpf + "', -1"
	
//1019
//'1000000020002'
//4
//14236095068
//
//7
//15188595850
	
	lo_distribuido.of_insert_registro( ls_Tabela, ls_Colunas, ls_Valores_Insert, Ref ll_Registros )
	
	If lo_distribuido.of_Erro_Execucao( ) Or lo_Distribuido.of_erro_conexao( ) Then
		gvo_Aplicacao.of_grava_log( 'RESERVA CD - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel realizar a pr$$HEX1$$e900$$ENDHEX$$-reserva do produto na matriz. Erro na conex$$HEX1$$e300$$ENDHEX$$o do distribuido (pedido_empurrado). Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_grava_ped_urgente_matriz()' )
		
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel realizar a pr$$HEX1$$e900$$ENDHEX$$-reserva do produto na matriz.~r~rErro na conex$$HEX1$$e300$$ENDHEX$$o do distribuido (pedido_empurrado).~rFun$$HEX2$$e700e300$$ENDHEX$$o: wf_grava_ped_urgente_matriz()" , StopSign! )
		Return False
	End If
	
	
	//Pedido empurrado Produto	
	ls_Tabela = 'pedido_empurrado_produto'
	
	ls_Colunas = 'cd_filial, nr_pedido_empurrado, cd_produto, qt_empurrada, qt_faturada, id_situacao, qt_aprovada'
	
 	ls_Valores_Insert	=	String( gvo_Parametro.Cd_Filial ) + ", " + &
						String( al_nr_pedido ) + ", " + &
						String( al_produto ) + ", " + &
						String( al_qtde_empurrada ) + ", 0, 'P', " + &
						String( ll_Qtde_Aprovada )
	
	lo_distribuido.of_insert_registro( ls_Tabela, ls_Colunas, ls_Valores_Insert, Ref ll_Registros )	
	
	If lo_distribuido.of_Erro_Execucao( ) Or lo_Distribuido.of_erro_conexao( ) Then
		gvo_Aplicacao.of_grava_log( 'RESERVA CD - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel realizar a pr$$HEX1$$e900$$ENDHEX$$-reserva do produto na matriz. Erro na conex$$HEX1$$e300$$ENDHEX$$o do distribuido (pedido_empurrado_produto). Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_grava_ped_urgente_matriz()' )
				
		lo_distribuido.of_delete_registro( "pedido_empurrado", "cd_filial = " + String( gvo_Parametro.Cd_Filial ) + " and nr_pedido_empurrado = " + String( al_nr_pedido ), Ref ll_Registros )
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel realizar a pr$$HEX1$$e900$$ENDHEX$$-reserva do produto na matriz.~r~rErro na conex$$HEX1$$e300$$ENDHEX$$o do distribuido (pedido_empurrado_produto).~rFun$$HEX2$$e700e300$$ENDHEX$$o: wf_grava_ped_urgente_matriz()" , StopSign! )
		Return False
	End If	
				
	Return True
	
Finally
	If IsValid( lo_distribuido ) Then Destroy lo_distribuido	
	Close( w_Aguarde )
End Try

end function

public function boolean of_busca_data_inicio_sap (ref date pdt_data, ref string ps_log);string ls_data

Select vl_parametro
into :ls_data
from parametro_loja
where cd_parametro = 'DH_INICIO_CD_SAP';

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela "dh_inicio_cd_sap": ' + sqlca.sqlerrtext
	return false
end if

pdt_data = date(ls_data)

return true
end function

public function boolean of_busca_ambiente (ref string ps_ambiente, ref string ps_log);string ls_base

Select vl_parametro
into :ls_base
from parametro_loja
where cd_parametro = 'ID_BASE_PRODUCAO';

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela "parametro_loja": ' + sqlca.sqlerrtext
	return false
end if

if ls_base = 'S' then
	ps_ambiente = 'PRD'
else
	ps_ambiente = 'DEV'
end if

return true
end function

public function boolean of_verifica_geracao_pedido_matriz (ref string as_log);String ls_Retorno,&
		ls_Situacao,&
		ls_Sql

Boolean lb_Sucesso = False

uo_Transacao_Remota lo_Conexao

DateTime	ldt_Iniciao_Geracao,&
				ldt_Termino_Geracao
				
String ls_Dt_Atual

Try
	lo_Conexao = Create uo_Transacao_Remota
	
	SetNull(ls_Situacao)
	SetNull(ldt_Iniciao_Geracao)
	SetNull(ldt_Termino_Geracao)
	ls_Dt_Atual =  String(gf_GetServerDate(), "YYYYMMDD")
	
	ls_Sql =	"select	CONVERT(CHAR(30), dh_inicio_geracao, 140)  as 'dh_inicio_geracao', "+&
				"			CONVERT(CHAR(30), dh_termino_geracao, 140) as 'dh_termino_geracao' "+&
				"from controle_geracao_pedido "+&
				"where dh_pedido = '"+ls_Dt_Atual+"' "+&
				"and id_multitask_logistica = 'S'"
	
	lo_Conexao.of_BancoProducao( )
	lo_Conexao.of_Define_Variaveis( True )
	
	lo_Conexao.of_executa_rotina( '0006', {ls_Sql } )
	lo_Conexao.of_retorno_dados(Ref ls_Retorno)
	
	If lo_Conexao.of_Erro_Execucao() Or lo_Conexao.of_Erro_Conexao() Then
		as_Log = "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.~r~rN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel verificar se est$$HEX1$$e100$$ENDHEX$$ sendo gerado os pedidos na matriz."
		Return False
	Else
		If lo_Conexao.of_Linhas() > 0 Then
			If lo_Conexao.of_Retorno('dh_inicio_geracao', Ref ldt_Iniciao_Geracao) Then
				If lo_Conexao.of_Retorno('dh_termino_geracao', Ref ldt_Termino_Geracao) Then
					lb_Sucesso = True
				End If
			End If			
		Else
			//Se n$$HEX1$$e300$$ENDHEX$$o localizaou nenhuma linha, n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ sendo gerado pedido
			Return True	
		End If
	End if
	
	If lb_Sucesso Then
		If (Not IsNull(ldt_Iniciao_Geracao) And IsNull(ldt_Termino_Geracao)) Then
			as_Log =	"N$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser inserido pedido urgente no momento.~r~r"+&
						"Est$$HEX1$$e100$$ENDHEX$$ sendo executado a gera$$HEX2$$e700e300$$ENDHEX$$o de pedidos na matriz.~r"+&
						"In$$HEX1$$ed00$$ENDHEX$$cio da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido: "+String(ldt_Iniciao_Geracao, 'DD/MM/YYYY HH:MM:SS')+"~r"+&
						"O per$$HEX1$$ed00$$ENDHEX$$odo de gera$$HEX2$$e700e300$$ENDHEX$$o do pedido $$HEX1$$e900$$ENDHEX$$ de aproximadamente 2 horas."
			Return False
		End If
	Else
		as_Log = "Erro ao localizar os dados na matriz.~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge108_reserva_produtos.of_verifica_geracao_pedido_matriz()."
		Return False
	End If
	
Finally
	If IsValid( lo_Conexao ) Then Destroy lo_Conexao
End Try

Return True
end function

on uo_ge108_reserva_produtos.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge108_reserva_produtos.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ds_produtos = Create dc_uo_ds_base

If Not This.ds_produtos.of_ChangeDataObject( "dw_ge108_produtos" ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro of_ChangeDataObject. Evento Constructor()")
	Return -1
End If
end event

event destructor;If IsValid( ds_produtos ) Then Destroy ds_produtos
end event

