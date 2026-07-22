HA$PBExportHeader$uo_ge256_conferencia_pedido.sru
forward
global type uo_ge256_conferencia_pedido from nonvisualobject
end type
end forward

global type uo_ge256_conferencia_pedido from nonvisualobject
end type
global uo_ge256_conferencia_pedido uo_ge256_conferencia_pedido

type variables
Boolean	ib_Verifica_Trigger = True
Long 		il_filial, il_pedido, il_volume
Integer 	ii_log
String 	is_somente_controlado, is_chave_log, is_erro, is_nr_matricula_conferente
end variables

forward prototypes
public function boolean of_processa_atualizacao (long al_filial, long al_pedido, long al_volume, ref string as_mensagem)
public function boolean of_parametro ()
public function boolean of_situacao_pedido ()
public function boolean of_insere_lote (long al_produto, string as_endereco, string as_lote, long al_qtde)
public function boolean of_lote_produtos_nao_controlados ()
public function boolean of_insere_lote_pedido ()
public function boolean of_grava_log (string as_mensagem, boolean ab_envia_email)
public function boolean of_grava_movimento_flow_rack (string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qtde, long al_sequencial)
public function boolean of_movimento_saida_flowrack (string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qtde, long al_sequencial, long al_filial, ref string as_erro)
public function boolean of_consiste_dados ()
public function boolean of_atualiza_situacao_mov_estoque ()
public function boolean of_atualiza_pedido_distribuidora_prd_lot (long al_produto, long al_qtde, string as_lote, ref string as_erro)
public function boolean of_pedido_almoxarifado (long al_filial, long al_pedido, ref boolean ab_pedido_almoxarifado)
public function boolean of_atualiza_situacao_pedido_almoxarifado (long al_filial, long al_pedido, boolean ab_pedido_almoxarifado)
public function boolean of_atualiza_qtde_separada_pedido_almoxar (long al_filial, long al_pedido, long al_volume, boolean lb_pedido_almoxarifado)
public function boolean of_valida_qt_movimentada (long al_filial, long al_pedido, long al_volume, long al_produto, long al_qt_total_movimentada, ref string as_erro)
public function boolean of_proximo_sequencial (long al_produto, string as_lote, string as_endereco, ref long al_sequencial, ref string as_erro)
public function boolean of_valida_qtde_separada (long al_filial, long al_pedido, long al_volume, boolean ab_pedido_almoxarifado)
public function boolean of_processa_atualizacao (long al_filial, long al_pedido, long al_volume, boolean ab_conferencia_finalizada, ref string as_mensagem)
public function boolean of_processa ()
end prototypes

public function boolean of_processa_atualizacao (long al_filial, long al_pedido, long al_volume, ref string as_mensagem);return of_processa_atualizacao(al_filial, al_pedido, al_volume, false, REF as_mensagem)
end function

public function boolean of_parametro ();Select cd_parametro
Into :is_somente_controlado
from wms_parametro
where cd_parametro = 'ID_SOMENTE_CONTROLADO'
  and vl_parametro = 'S'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_Grava_log ("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_parametro: "+ SqlCa.SqlErrText, True)
	Return False
End If

Return True
end function

public function boolean of_situacao_pedido ();Long ll_Volume

Boolean lb_Somente_Ativas

// 19/11/2014 - Sergio
// A Expedi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o quer que finalize o pedido automaticamente.
Return True

//If is_somente_controlado = 'S' Then Return True
//
//Select Top 1 nr_volume
//Into :ll_Volume
//From wms_lista_separacao
//Where cd_filial = :il_Filial
//	and nr_pedido_distribuidora = :il_Pedido
//	and (id_atualizacao_mov_estoque = 'N' or dh_termino_conferencia is null)
//	and dh_cancelamento is null
//Using SqlCa;
//
//Choose Case Sqlca.Sqlcode
//	Case -1	
//		This.of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_situacao_pedido: "+ SqlCa.SqlErrText, True	)
//		Return False
//		
//	Case 0
//		Return True
//		
//	Case 100
//		
//		If Not gf_wms_somente_esteiras_ativas(ref lb_Somente_Ativas) Then
//			Return False
//		End If
//		
//		If lb_Somente_Ativas Then
//			Update pedido_distribuidora
//			Set id_situacao = "T"
//			Where  cd_filial = :il_Filial
//				and nr_pedido_distribuidora = :il_Pedido
//			Using SqlCa;
//			
//			If Sqlca.Sqlcode = -1 Then
//				This.of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_situacao_pedido: "+ SqlCa.SqlErrText, True)
//				Return False
//			End If
//		End If
//		
//End Choose
//
//Return True
end function

public function boolean of_insere_lote (long al_produto, string as_endereco, string as_lote, long al_qtde);String ls_Achou

Select nr_lote
Into :ls_Achou
From wms_lista_separacao_prd_lote
Where cd_filial 							= :il_Filial
  	and nr_pedido_distribuidora		= :il_Pedido
	and nr_volume						= :il_volume
  	and cd_produto						= :al_produto
	and cd_endereco_localizacao 	= :as_endereco
  	and nr_lote							= :as_Lote
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		
		  UPDATE wms_lista_separacao_prd_lote  
     		SET   qt_lote =   qt_lote +  :al_Qtde
		  Where	cd_filial							= :il_Filial
		  	 and	nr_pedido_distribuidora 	= :il_Pedido
			 and 	nr_volume						= :il_volume	
			 and 	cd_produto 					= :al_Produto
			 and 	cd_endereco_localizacao 	= :as_endereco
			 and	nr_lote							= :as_Lote
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			is_erro += '~n~r' + "Erro ao atualizar o lote do produto '" + String(al_Produto) + "': "+Sqlca.sqlErrText
			This.of_Grava_Log(is_erro, True)
			Return False
		End If
		
	Case 100
		
		INSERT INTO wms_lista_separacao_prd_lote (	cd_filial, 
																			nr_pedido_distribuidora,  
																			nr_volume,
																			cd_produto,
																			cd_endereco_localizacao,
																			nr_lote, 
																			qt_lote )  
		VALUES (:il_Filial, 
					:il_Pedido, 
					:il_volume,
					:al_Produto, 
					:as_endereco,
					:as_Lote, 
					:al_Qtde)
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			is_erro += '~n~r' + "Erro ao inserir o lote do produto '" + String(al_Produto) + "': "+Sqlca.sqlErrText
			This.of_Grava_Log(is_erro, True)
			Return False
		End If

	Case -1
		is_erro += '~n~r' + "Erro ao localizar o lote do produto '" + String(al_Produto) + "': "+Sqlca.sqlErrText
		This.of_Grava_Log(is_erro, True)
		Return False
End Choose

Return True
end function

public function boolean of_lote_produtos_nao_controlados ();Long ll_Produto, ll_Qt_Separada, ll_Linha, ll_Linhas
Long ll_Qt_Lote, ll_Linha_Lote, ll_Qt_Temp, ll_Linhas_Lote
String ls_Controlado, ls_Lote, ls_Endereco_Saida
dc_uo_ds_base lds
dc_uo_ds_base lds_Lista

Try
	
	lds 						= Create dc_uo_ds_base
	lds_Lista 				= Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge256_lista_lote_nao_controlados") Then
		is_erro = "Erro ao criar a 'ds_ge256_lista_lote_nao_controlados'"
		This.of_Grava_Log(is_erro, True)
		Return False
	End If
		
	If Not lds_Lista.of_ChangeDataObject("ds_ge256_lista_produtos_pedido") Then
		is_erro = "Erro ao criar a 'ds_ge256_lista_produtos_pedido'"
		This.of_Grava_Log(is_erro, True)
		Return False
	End If
	
	ll_Linhas = lds_Lista.Retrieve(il_Filial, il_Pedido, il_Volume)
	
	If ll_Linhas > 0 Then
	
		For ll_Linha = 1 to ll_Linhas
			
			ll_Produto				= lds_Lista.Object.cd_produto[ll_Linha]	
			ls_Endereco_Saida 	= lds_Lista.Object.cd_endereco[ll_Linha]	
			
			If ll_Produto = 698531 then
				 ll_Produto = 698531
			End If
			
			If ll_Produto = 686995 then
				 ll_Produto = 686995
			End If
			
			If ll_Produto = 718249 then
				 ll_Produto = 718249
			End If
			
			ls_Controlado = lds_Lista.Object.id_controlado[ll_Linha]	
			
			If ls_Controlado <> 'S' Then	

				ll_Qt_Separada		= lds_Lista.Object.qt_separada[ll_linha]

				//Recupera os lotes dos produtos no FlowRack					
				ll_Linhas_Lote = lds.Retrieve(ll_Produto, ls_Endereco_Saida)
				
				If (ll_Linhas_Lote < 0) or IsNull(ll_Linhas_Lote) Then
					is_erro = "Erro no retrieve dos lotes dos produtos n$$HEX1$$e300$$ENDHEX$$o controlados."
					This.of_Grava_Log(is_erro, True)
					Return False
				End If
				
				If ll_Linhas_Lote > 0 Then
					
					For ll_Linha_Lote = 1 To ll_Linhas_Lote
						
						ls_Lote					= lds.Object.nr_lote[ll_Linha_Lote]
						ll_Qt_Lote 				= lds.Object.qt_saldo[ll_Linha_Lote]
					
						If ll_Qt_Separada <= ll_Qt_Lote Then
							ll_Qt_Temp = ll_Qt_Separada						
						Else
							ll_Qt_Temp = ll_Qt_Lote					
						End If
											 
						If Not of_Insere_Lote(ll_Produto, ls_Endereco_Saida, ls_Lote, ll_Qt_Temp) Then
							Return False	
						End If
											
						ll_Qt_Separada = ll_Qt_Separada - ll_Qt_Temp
						
						// Inicio Sergio - Sab dia 11/10/2104
						// Se a quantidade de lotes n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o suficientes para suprir a quantidade separada.
						If ll_Qt_Separada > 0 and ll_Linha_Lote = ll_Linhas_Lote Then
							is_erro = "Produto '" + String(ll_Produto) + "' sem lote suficiente."
							This.of_Grava_Log(is_erro, True)
							
							If Not of_Insere_Lote(ll_Produto, ls_Endereco_Saida, "LOTE CONF", ll_Qt_Separada) Then
								Return False
							End If
							
							ll_Qt_Separada = 0
						End If
						// Fim Sergio
						
						If ll_Qt_Separada = 0 Then Exit
						
					Next
					
				Else
					ls_Lote 			= "LOTE CONF"
					ll_Qt_Lote 		= lds_Lista.Object.qt_separada[ll_Linha]	
					ll_Qt_Temp 	= ll_Qt_Separada
					is_erro = "Produto '" + String(ll_Produto) + "' sem lote suficiente."
					This.of_Grava_Log(is_erro, True)
					
					If Not of_Insere_Lote(ll_Produto, ls_Endereco_Saida, ls_Lote, ll_Qt_Temp) Then
						Return False	
					End If
				End If
				
			End If
			
		Next
	Else
		is_erro = "Erro ao listar ou nenhum produto foi localizado no pedido."
		This.of_Grava_Log(is_erro, True)
		Return False
	End If
Finally
	Destroy(lds_Lista)
	Destroy(lds)
End Try

Return True
end function

public function boolean of_insere_lote_pedido ();Long 	ll_linha,&
		ll_Linhas,&
		ll_Produto,&
		ll_Qtde,&
		ll_Qt_Cx_Padrao,&
		ll_Sequencial,&
		ll_Saldo,&
		ll_Linha_2,&
		ll_Linhas_2,&
		ll_Qt_Lote,&
		ll_Qt_Total_Movimentada,&
		ll_Produto_Anterior
		
String 	ls_Lote,&
			ls_lote_Select,&
			ls_Endereco,&
			ls_Erro
			
Date ldh_Validade

dc_uo_ds_base lds
dc_uo_ds_base lds_Lotes_Endereco

Try
	
	lds = Create dc_uo_ds_base
	lds_Lotes_Endereco = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge256_lista_lote_finalizar") Then
		is_erro = "Erro ao criar a 'ds_ge256_lista_lote_finalizar'"
		This.of_Grava_Log(is_erro, True)
		Return False		
	End If
	
	If Not lds_Lotes_Endereco.of_ChangeDataObject("ds_ge256_lista_lote_endereco") Then
		is_erro = "Erro ao criar a 'ds_ge256_lista_lote_endereco'"
		This.of_Grava_Log(is_erro, True)
		Return False		
	End If
	
	ll_Linhas = lds.Retrieve(il_Filial, il_pedido, il_volume)
	
	If (ll_Linhas < 0) or IsNull(ll_Linhas) Then
		is_erro = "Erro no retrieve da fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_lote_pedido'."
		This.of_Grava_Log(is_erro, True)
		Return False
	End If
	
	For ll_Linha = 1 To ll_Linhas
		
		ll_Produto 			= lds.Object.cd_produto[ll_Linha]
		ls_Lote				= lds.Object.nr_lote[ll_Linha]
		ll_Qtde				= lds.Object.qt_lote[ll_Linha]
		ls_Endereco			= lds.Object.cd_endereco_localizacao[ll_Linha]
		
		If ll_Produto <> ll_Produto_Anterior Then
			ll_Qt_Total_Movimentada = 0
		End If
		
		If ll_Produto = 698531 then
			 ll_Produto = 698531
		End If
		
		If ll_Produto = 686995 then
			 ll_Produto = 686995
		End If
		
		If ll_Produto = 718249 then
			 ll_Produto = 718249
		End If
		
		
//		Select 	qt_caixa_padrao,
//					nr_sequencial,
//					dh_validade
//		Into		:ll_Qt_Cx_Padrao,
//					:ll_Sequencial,
//					:ldh_Validade
//		From wms_localizacao
//		Where cd_endereco = :ls_Endereco
//			and cd_produto = :ll_Produto
//			and nr_lote = :ls_Lote
//		Using SqlCa;	
//		
//		Choose Case SqlCa.Sqlcode
//			Case 100
//				ll_Qt_Cx_Padrao 	= 1
//				ll_Sequencial 		= 1
//				ldh_Validade 		= Date(gf_GetServerDate())
//				is_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto '"+String(ll_Produto)+"', lote '"+string(ls_Lote)+"' no endere$$HEX1$$e700$$ENDHEX$$o '"+ls_Endereco+"'."
//				This.of_Grava_Log(is_erro, True)
//			Case -1
//				is_erro = "Erro ao localizar o produto no endere$$HEX1$$e700$$ENDHEX$$o. Produto '"+String(ll_Produto)+"', lote '"+string(ls_Lote)+"' no endere$$HEX1$$e700$$ENDHEX$$o '"+ls_Endereco+"': ~r"+Sqlca.sqlErrText
//				This.of_Grava_Log(is_erro, True)
//				Return False
//		End Choose	
		
		ll_Linhas_2 = lds_Lotes_Endereco.Retrieve(ls_Endereco, ll_Produto, ls_Lote)
		
		If ll_Linhas_2 < 0 Then
			is_erro = "Erro no retrieve da ds_ge256_lista_lote_endereco."
			This.of_Grava_Log(is_erro, True)
			Return False
		End If
		
		If ll_Linhas_2 = 0 Then
			
			If not of_Proximo_Sequencial(ll_Produto, ls_Lote, ls_Endereco, Ref ll_Sequencial, Ref is_erro) Then
				SqlCa.of_Rollback()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_erro)															
				Return False
			End If
			
			ll_Qt_Cx_Padrao 	= 1
			//ll_Sequencial 		= 1
			ldh_Validade 		=  gf_primeiro_dia_mes(Date(gf_GetServerDate()))
			is_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto '"+String(ll_Produto)+"', lote '"+string(ls_Lote)+"' no endere$$HEX1$$e700$$ENDHEX$$o '"+ls_Endereco+"'."
			This.of_Grava_Log(is_erro, True)
			
			If Not of_atualiza_pedido_distribuidora_prd_lot(ll_Produto, ll_Qtde, ls_Lote, Ref ls_erro) Then
				SqlCa.of_Rollback()
				This.of_Grava_Log(ls_erro, True)																
				is_erro += ls_Erro
				Return False
			End If
			
			If Not This.of_movimento_saida_flowrack(	ls_Endereco,&
															ll_Produto,&
															ll_Qt_Cx_Padrao,&
															ls_Lote,&
															ldh_Validade,&
															ll_Qtde,&
															ll_Sequencial,&
															il_Filial,&
															Ref is_erro) Then
				is_erro = "Erro no movimento de sa$$HEX1$$ed00$$ENDHEX$$da do flow rack: " + is_erro
				This.of_Grava_Log(is_erro, True)																
				Return False
			End If		
			
			ll_Qt_Total_Movimentada += ll_Qtde
			
		Else
			For ll_Linha_2 = 1 To ll_Linhas_2
				ll_Qt_Lote 			=	lds_Lotes_Endereco.Object.qt_saldo[ll_Linha_2]
				ll_Sequencial		=	lds_Lotes_Endereco.Object.nr_sequencial[ll_Linha_2]
				ll_Qt_Cx_Padrao	=	lds_Lotes_Endereco.Object.qt_caixa_padrao[ll_Linha_2]
				ldh_Validade		=	Date(lds_Lotes_Endereco.Object.dh_validade[ll_Linha_2])
				
				If ll_Qt_Lote >= ll_Qtde Then
					
					If Not of_atualiza_pedido_distribuidora_prd_lot(ll_Produto, ll_Qtde, ls_Lote, Ref is_erro) Then
						SqlCa.of_Rollback()
						This.of_Grava_Log(is_erro, True)																
						Return False
					End If
					
					If Not This.of_movimento_saida_flowrack(	ls_Endereco,&
																	ll_Produto,&
																	ll_Qt_Cx_Padrao,&
																	ls_Lote,&
																	ldh_Validade,&
																	ll_Qtde,&
																	ll_Sequencial,&
																	il_Filial,&
																	Ref is_erro) Then
						is_erro = "Erro no movimento de sa$$HEX1$$ed00$$ENDHEX$$da do flow rack: "+is_erro
						This.of_Grava_Log(is_erro, True)																
						Return False
					End If
					
					ll_Qt_Total_Movimentada += ll_Qtde
					
					Exit
					
				Else

					If (ll_Linha_2 = ll_Linhas_2) and (ll_Qtde > ll_Qt_Lote) Then
						ll_Qt_Lote = ll_Qtde
					End If
					
					If Not of_atualiza_pedido_distribuidora_prd_lot(ll_Produto, ll_Qt_Lote, ls_Lote, Ref is_erro) Then
						SqlCa.of_Rollback()
						This.of_Grava_Log(is_erro, True)																
						Return False
					End If
					
					If Not This.of_movimento_saida_flowrack(	ls_Endereco,&
																	ll_Produto,&
																	ll_Qt_Cx_Padrao,&
																	ls_Lote,&
																	ldh_Validade,&
																	ll_Qt_Lote,&
																	ll_Sequencial,&
																	il_Filial,&
																	Ref is_erro) Then
						is_erro = "Erro no movimento de sa$$HEX1$$ed00$$ENDHEX$$da do flow rack: " + is_erro
						This.of_Grava_Log(is_erro, True)
						Return False
					End If
					
					ll_Qt_Total_Movimentada += ll_Qt_Lote
					
					ll_Qtde = ll_Qtde - ll_Qt_Lote
					
					If ll_Qtde = 0 Then Exit										
					
				End If		
				
			Next
		End If
		
		If Not of_Valida_Qt_Movimentada(il_Filial, il_pedido, il_volume, ll_Produto, ll_Qt_Total_Movimentada, Ref is_erro) Then
			SqlCa.of_Rollback()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_erro)															
			Return False
		End If	
		
		ll_Produto_Anterior = ll_Produto
		
//		Select nr_lote
//		Into :ls_lote_Select
//		From pedido_distribuidora_prd_lote
//		Where cd_filial 						= :il_Filial
//		and nr_pedido_distribuidora 	= :il_Pedido
//		and cd_produto 					= :ll_Produto
//		and nr_lote 							= :ls_Lote
//		Using SqlCa;
//						
//		Choose Case SqlCa.Sqlcode
//			Case 0
//				
//				  UPDATE pedido_distribuidora_prd_lote  
//					SET   qt_lote =   qt_lote +  :ll_Qtde
//				  Where	cd_filial						= :il_Filial
//					 and 	nr_pedido_distribuidora 	= :il_Pedido
//					 and 	cd_produto 					= :ll_Produto
//					 and	nr_lote						= :ls_Lote
//				Using SqlCa;
//				
//				If SqlCa.SqlCode = - 1 Then
//					is_erro = "Erro ao atualizar o lote: "+Sqlca.sqlErrText
//					This.of_Grava_Log(is_erro, True)
//					SqlCa.of_Rollback()
//					Return False
//				End If
//				
//			Case 100
//				
//				INSERT INTO pedido_distribuidora_prd_lote(
//								cd_filial, 
//								nr_pedido_distribuidora,  
//								cd_produto,
//								nr_lote, 
//								qt_lote )  
//				VALUES ( 	:il_Filial, 
//								:il_Pedido, 
//								:ll_Produto, 
//								:ls_Lote, 
//								:ll_Qtde)
//				Using SqlCa;
//				
//				If SqlCa.SqlCode = - 1 Then
//					is_erro = "Erro ao inserir o lote do produto '" + String(ll_Produto) + "': "+Sqlca.sqlErrText
//					This.of_Grava_Log(is_erro, True)
//					SqlCa.of_Rollback()					
//					Return False
//				End If
//			
//			Case -1
//				is_erro = "Erro ao localizar o lote: "+Sqlca.sqlErrText
//				This.of_Grava_Log(is_erro, True)
//				Return False
//		End Choose
		
//		//Movimento de saida do flowRack
//		If Not This.of_movimento_saida_flowrack(	ls_Endereco,&
//														ll_Produto,&
//														ll_Qt_Cx_Padrao,&
//														ls_Lote,&
//														ldh_Validade,&
//														ll_Qtde,&
//														ll_Sequencial,&
//														il_Filial,&
//														Ref is_erro) Then
//			is_erro = "Erro no movimento de sa$$HEX1$$ed00$$ENDHEX$$da do flow rack: "+is_erro
//			This.of_Grava_Log(is_erro, True)
//			Return False
//		End If				
	Next
	
Finally
	Destroy(lds)
	Destroy(lds_Lotes_Endereco)
End Try

Return True
end function

public function boolean of_grava_log (string as_mensagem, boolean ab_envia_email);String ls_Anexo[]
String ls_Mensagem_Email
String ls_Mensagem_Log

If ab_envia_email Then
	ls_Mensagem_Email = is_chave_log
	If Not gf_ge202_envia_email_automatico(5, "Log Confer$$HEX1$$ea00$$ENDHEX$$ncia volumes", ls_Mensagem_Email +"<br><br>"+as_Mensagem, ls_Anexo) Then
		Return False
	End If
End If

//as_Mensagem = String(Today(), "dd/mm/yyyy") + String(Now(), 'hh:mm:ss') + " - " +  is_chave_log + " - " + ls_Mensagem_Log 
//
//If FileWrite (ii_log, as_Mensagem) = -1 Then
//	Return False
//End If


Return True
end function

public function boolean of_grava_movimento_flow_rack (string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qtde, long al_sequencial);String ls_Matricula
ls_Matricula = gvo_aplicacao.ivo_seguranca.nr_Matricula


Insert into wms_movimentacao(
			cd_endereco_entrada,
			nr_sequencial_entrada,
			cd_endereco_saida,
			nr_sequencial_saida,
			cd_produto,
			qt_caixa_padrao,
			nr_lote,
			dh_validade,
			qt_movimento,
			id_tipo_movimento,
			dh_movimentacao,
			nr_matricula_responsavel,
			cd_filial,
			cd_fornecedor,
			nr_nf,
			de_especie,
			de_serie)
Values(	NULL,
			NULL,
			:as_endereco_saida,
			:al_sequencial,
			:al_Produto,
			:al_Cx_Padrao,
			:as_Lote,
			:adh_Validade,
			:al_qtde,
			'P',
			GetDate(),
			:ls_Matricula,
			:il_Filial,
			NULL,
			NULL,
			NULL,
			NULL)
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	This.of_Grava_Log("Erro ao inserir dados na tabela 'wms_movimentacao': "+SqlCa.SQLErrText, True)
	Return False
End If

Return True
end function

public function boolean of_movimento_saida_flowrack (string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qtde, long al_sequencial, long al_filial, ref string as_erro);String ls_Matricula


if not IsNull(is_nr_matricula_conferente) then
	ls_Matricula	= is_nr_matricula_conferente
else
	ls_Matricula 	= gvo_aplicacao.ivo_seguranca.nr_Matricula
end if

Insert into wms_movimentacao(
			cd_endereco_entrada,
			nr_sequencial_entrada,
			cd_endereco_saida,
			nr_sequencial_saida,
			cd_produto,
			qt_caixa_padrao,
			nr_lote,
			dh_validade,
			qt_movimento,
			id_tipo_movimento,
			dh_movimentacao,
			nr_matricula_responsavel,
			cd_filial,
			cd_fornecedor,
			nr_nf,
			de_especie,
			de_serie)
Values(	NULL,
			NULL,
			:as_endereco_saida,
			:al_sequencial,
			:al_Produto,
			:al_Cx_Padrao,
			:as_Lote,
			:adh_Validade,
			:al_qtde,
			'P',
			GetDate(),
			:ls_Matricula,
			:al_Filial,
			NULL,
			NULL,
			NULL,
			NULL)
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao inserir dados na tabela 'wms_movimentacao': "+SqlCa.SQLErrText
	Return False
End If

Return True
end function

public function boolean of_consiste_dados ();Long 	ll_Linhas,&
		ll_Linha,&
		ll_Qt_Lote_Select,&
		ll_Filial,&
		ll_Pedido,&
		ll_Volume,&
		ll_Produto,&
		ll_Qt_Separada
		
Boolean lb_Divergencia

dc_uo_ds_base  lds_Lista

is_Erro        = ''
lb_Divergencia = False

Try
	lds_Lista 				= Create dc_uo_ds_base
	
	If Not lds_Lista.of_ChangeDataObject("ds_ge256_lista_produtos_pedido") Then
		is_Erro = "Erro ao criar a 'ds_ge256_lista_produtos_pedido'"
		This.of_Grava_Log(is_erro, True)
		Return False
	End If
	
	ll_Linhas = lds_Lista.Retrieve(il_Filial, il_Pedido, il_Volume)
	

	For ll_Linha = 1 To ll_Linhas
		
		ll_Filial				= lds_Lista.Object.cd_filial[ll_Linha]
		ll_Pedido				= lds_Lista.Object.nr_pedido_distribuidora[ll_Linha]
		ll_Volume			= lds_Lista.Object.nr_volume[ll_Linha]
		ll_Produto			= lds_Lista.Object.cd_produto[ll_Linha]
		ll_Qt_Separada 	= lds_Lista.Object.qt_separada[ll_Linha]
		
		If IsNull(ll_Produto) Then Continue
		
		//Select isnull(sum(qt_lote), 0)
		Select coalesce(sum((	CASE 
										WHEN qt_lote < 0 then qt_lote * -1
										ELSE qt_lote
										End)), 0)
		Into :ll_Qt_Lote_Select
		From wms_lista_separacao_prd_lote
		Where cd_filial 							=:ll_Filial
			and nr_pedido_distribuidora		=:ll_Pedido
			and nr_volume						=:ll_Volume
			and cd_produto						=:ll_Produto
		Using SqlCa;	
		
		Choose Case Sqlca.Sqlcode
			Case -1	
				is_Erro = "Erro na  fun$$HEX2$$e700e300$$ENDHEX$$o wf_consiste_dados: "+SqlCa.SqlErrText
				This.of_Grava_Log(is_erro, True)
				Return False
		End Choose
		
		If ll_Qt_Lote_Select <> ll_Qt_Separada Then
			lb_Divergencia = True
			If is_Erro = '' Then
				is_Erro  = "Diverg$$HEX1$$ea00$$ENDHEX$$ncias~r"+ "Produto "+String(ll_Produto)+" Qtde. Separada: "+String(ll_Qt_Separada)+" Qtde. salva: "+String(ll_Qt_Lote_Select)
			Else
				is_Erro += "~r"+ "Produto "+String(ll_Produto)+" Qtde. Separada: "+String(ll_Qt_Separada)+" Qtde. salva: "+String(ll_Qt_Lote_Select)
			End If
		End If
	Next
	
	If lb_Divergencia Then
		This.of_Grava_Log (is_Erro, True)
		Return False
	Else
		Return True
	End If

Finally
	Destroy(lds_Lista)
End Try
end function

public function boolean of_atualiza_situacao_mov_estoque ();String ls_Atualizacao

DateTime ldt_Atualizacao, ldt_Cancelamento

Select 
	id_atualizacao_mov_estoque, 
	dh_atualizacao_mov_estoque,
	dh_cancelamento
Into 
	:ls_Atualizacao, 
	:ldt_Atualizacao,
	:ldt_Cancelamento
From 
	wms_lista_separacao
Where 
	cd_filial 							= :il_filial
  	and nr_pedido_distribuidora 	= :il_pedido
  	and nr_volume 						= :il_volume
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(ldt_Cancelamento) Then
			is_erro = 'O volume ' + String(il_volume) + ' do pedido ' + String(il_pedido) + ' da filial ' + String(il_filial) + ' est$$HEX1$$e100$$ENDHEX$$ cancelado. Favor verificar.'
			This.of_Grava_Log (is_erro, True)
			Return False
		ElseIf ls_Atualizacao = 'S' Then
			is_erro = 'A lista de separa$$HEX2$$e700e300$$ENDHEX$$o (Picking) n$$HEX1$$e300$$ENDHEX$$o J$$HEX1$$c100$$ENDHEX$$ FOI ATUALIZADA.'
			This.of_Grava_Log (is_erro, True)
			Return False
		Else
			Update 
				wms_lista_separacao
			Set 
				id_atualizacao_mov_estoque = 'S', 
				dh_atualizacao_mov_estoque = getdate()
			From 
				wms_lista_separacao
			Where 
				cd_filial 							= :il_filial
				and nr_pedido_distribuidora 	= :il_pedido
				and nr_volume 						= :il_volume
				and dh_cancelamento 				is null
			Using SqlCa;
			
			Choose Case SqlCa.Sqlcode 
				Case -1 
					is_erro = "Erro - Atualiza$$HEX2$$e700e300$$ENDHEX$$o do movimento estoque 'WMS'." +&
								 " Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge256_conferencia_mov_estoque.of_atualizacao_situacao_mov_estoque '"+SqlCa.SqlErrText + "'."
					This.of_Grava_Log(is_erro, True)
					Return False	
				Case 100
					is_erro = 'N$$HEX1$$e300$$ENDHEX$$o encontrado registros para atualiza$$HEX2$$e700e300$$ENDHEX$$o do volume ' + String(il_volume) + ' do pedido ' + String(il_pedido) + ' da filial ' + String(il_filial) + '. Talvez esteja cancelado, favor verificar.'
					This.of_Grava_Log(is_erro, True)
					Return False	
			End Choose
		End If
		
	Case 100
		is_erro = 'A lista de separa$$HEX2$$e700e300$$ENDHEX$$o (Picking) n$$HEX1$$e300$$ENDHEX$$o foi localizada.'
		This.of_Grava_Log(is_erro, True)
		Return False
	Case -1
		is_erro = "Erro - Localiza$$HEX2$$e700e300$$ENDHEX$$o da atualiza$$HEX2$$e700e300$$ENDHEX$$o do movimento estoque 'WMS'." +&
					 " Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge256_conferencia_mov_estoque.of_atualizacao_situacao_mov_estoque '"+SqlCa.SqlErrText + "'."
		This.of_Grava_Log(is_erro, True)
		Return False
End Choose

Return True
end function

public function boolean of_atualiza_pedido_distribuidora_prd_lot (long al_produto, long al_qtde, string as_lote, ref string as_erro);String ls_lote_Select

Integer li_Retorno

If ib_Verifica_Trigger Then
	li_Retorno = gf_wms_verifica_trigger()
	If li_Retorno = -1 Then Return False
	If li_Retorno > 0 Then Return True
End If

Select nr_lote
Into :ls_lote_Select
From pedido_distribuidora_prd_lote
Where cd_filial 						= :il_Filial
and nr_pedido_distribuidora 	= :il_Pedido
and cd_produto 					= :al_Produto
and nr_lote 							= :as_Lote
Using SqlCa;
				
Choose Case SqlCa.Sqlcode
	Case 0
		
		  UPDATE pedido_distribuidora_prd_lote  
			SET   qt_lote =   qt_lote +  :al_Qtde
		  Where	cd_filial						= :il_Filial
			 and 	nr_pedido_distribuidora 	= :il_Pedido
			 and 	cd_produto 					= :al_Produto
			 and	nr_lote						= :as_Lote
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			as_Erro = "Erro ao atualizar o lote: "+Sqlca.sqlErrText
			Return False
		End If
		
	Case 100
		
		INSERT INTO pedido_distribuidora_prd_lote(
						cd_filial, 
						nr_pedido_distribuidora,  
						cd_produto,
						nr_lote, 
						qt_lote )  
		VALUES ( 	:il_Filial, 
						:il_Pedido, 
						:al_Produto, 
						:as_Lote, 
						:al_Qtde)
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			as_Erro = "Erro ao inserir o lote do produto '" + String(al_Produto) + "': "+Sqlca.sqlErrText					
			Return False
		End If
	
	Case -1
		as_Erro = "Erro ao localizar o lote: "+Sqlca.sqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_pedido_almoxarifado (long al_filial, long al_pedido, ref boolean ab_pedido_almoxarifado);Long ll_Qtde

ab_pedido_almoxarifado = False

Select count(*)
Into :ll_Qtde
From pedido_distribuidora
Where cd_filial 							= :al_Filial
	And nr_pedido_distribuidora 	= :al_Pedido
	And id_pedido_almoxarifado 	= 'S'
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	is_erro = "Erro ao verificar se $$HEX1$$e900$$ENDHEX$$ pedido de almoxarifado': "+SqlCa.SQLErrText
	This.of_Grava_Log(is_erro, True)
	Return False
End If

If ll_Qtde > 0 Then
	ab_pedido_almoxarifado = True
End If

Return True
end function

public function boolean of_atualiza_situacao_pedido_almoxarifado (long al_filial, long al_pedido, boolean ab_pedido_almoxarifado);Long ll_Volume

Boolean lb_Pedido_Almoxarifado_Novo

If ab_Pedido_Almoxarifado Then
	
	If Not gf_Pedido_Almoxarifado_Novo(al_Filial, Ref lb_Pedido_Almoxarifado_Novo, Ref is_erro) Then
		This.of_Grava_Log(is_erro, True)
		Return False
	End If
	
	If lb_Pedido_Almoxarifado_Novo Then
		Return True
	End If
	
	Select Top 1 nr_volume
	Into :ll_Volume
	From wms_lista_separacao
	Where cd_filial = :il_Filial
		and nr_pedido_distribuidora = :il_Pedido
		and (id_atualizacao_mov_estoque = 'N' or dh_termino_conferencia is null)
		and dh_cancelamento is null
	Using SqlCa;
	
	Choose Case Sqlca.Sqlcode
		Case -1
			is_erro = "Erro ao verificar se todos os volumes fora conferidos: "+ SqlCa.SqlErrText
			This.of_Grava_Log(is_erro, True	)
			Return False
			
		Case 0
			Return True
			
		Case 100
			
			Update pedido_almoxarifado
			Set id_situacao 	= 'T'
			Where cd_filial 		= :al_Filial
				And nr_pedido 	in (Select nr_pedido_almoxarifado
										From pedido_distribuidora_almox
										Where cd_filial 							= :al_Filial
										And nr_pedido_distribuidora 	= :al_Pedido)
			Using SqlCa;	
				
			If  SqlCa.SqlCode = -1 Then
				is_erro = "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido almoxarifado': "+SqlCa.SQLErrText
				This.of_Grava_Log(is_erro, True)
				Return False
			End If		
	End Choose

End If

Return True
end function

public function boolean of_atualiza_qtde_separada_pedido_almoxar (long al_filial, long al_pedido, long al_volume, boolean lb_pedido_almoxarifado);dc_uo_ds_base 	lds,&
						lds_Ped_Almox

Long 	ll_Linha,&
		ll_Linhas,&
		ll_produto,&
		ll_Pedido_Almoxarifado,&
		ll_Qtde_Separada,&
		ll_Linha_Almox,&
		ll_Linhas_Almox,&
		ll_Qtde_Atendida_Almox,&
		ll_Qtde_Atualizar
	

If lb_Pedido_Almoxarifado Then
	
	Try
		lds = Create dc_uo_ds_base
		
		lds_Ped_Almox = Create dc_uo_ds_base
	
		If Not lds.of_ChangeDataObject("ds_ge256_lista_produtos_pedido") Then
			Return False
		End If
		
		If Not lds_Ped_Almox.of_ChangeDataObject("ds_ge256_lista_pedidos_almoxarifado") Then
			Return False
		End If
		
		ll_Linhas = lds.Retrieve(al_Filial, al_Pedido, al_Volume)
		
		For ll_Linha = 1 To ll_Linhas
			
			ll_Produto 			= lds.Object.cd_produto		[ll_Linha]
			ll_Qtde_Separada	= lds.Object.qt_separada	[ll_Linha]
			
			ll_Linhas_Almox = lds_Ped_Almox.Retrieve(al_Filial, al_Pedido, ll_Produto)
			
			For ll_Linha_Almox = 1 To ll_Linhas_Almox
				
				ll_Pedido_Almoxarifado = lds_Ped_Almox.Object.nr_pedido_almoxarifado[ll_Linha_Almox]
				
				Select qt_atendida
				Into :ll_Qtde_Atendida_Almox
				From pedido_almoxarifado_produto
				Where cd_filial 			= :al_Filial
					And nr_pedido 		= :ll_Pedido_Almoxarifado
					And cd_produto 	= :ll_Produto
				Using SqlCa;	
				
				Choose Case SqlCa.SqlCode
					Case 100
//						is_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado a qtde atendida do pedido almoxarifado da filial "+String(al_Filial)+&
//									 " Pedido Almox "+String(ll_Pedido_Almoxarifado)+" Produto "+String(ll_Produto)+": "+SqlCa.SQLErrText
//						This.of_Grava_Log(is_erro, True)
//						Return False
						Continue
					Case -1 
						is_erro = "Erro ao localizado a qtde atendida do pedido almoxarifado da filial "+String(al_Filial)+&
									 " Pedido Almox "+String(ll_Pedido_Almoxarifado)+" Produto "+String(ll_Produto)+": "+SqlCa.SQLErrText
						This.of_Grava_Log(is_erro, True)
						Return False
				End Choose
				
				If ll_Qtde_Separada > ll_Qtde_Atendida_Almox Then
					ll_Qtde_Atualizar = ll_Qtde_Atendida_Almox
				Else
					ll_Qtde_Atualizar = ll_Qtde_Separada
				End If
				
				ll_Qtde_Separada = ll_Qtde_Separada - ll_Qtde_Atualizar
				
				If ll_Qtde_Separada < 0 Then 
					ll_Qtde_Separada = 0
				End If
			
				Update pedido_almoxarifado_produto
				Set qt_separada = coalesce(qt_separada, 0) + :ll_Qtde_Atualizar
				Where cd_filial 			= :al_Filial
					And nr_pedido 		= :ll_Pedido_Almoxarifado
					And cd_produto 	= :ll_produto
				Using SqlCa;	
				
				If SqlCa.SqlCode = -1 Then
					is_erro = "Erro ao atualizar a qtde separada do pedido almoxarifado da filial "+String(al_Filial)+&
								 " Pedido Almox "+String(ll_Pedido_Almoxarifado)+" Produto "+String(ll_Produto)+": "+SqlCa.SQLErrText
					This.of_Grava_Log(is_erro, True)
					Return False
				End If
			Next
		Next
		
	Finally
		Destroy(lds)
		Destroy(lds_Ped_Almox)
	End Try
	
End If

Return True
end function

public function boolean of_valida_qt_movimentada (long al_filial, long al_pedido, long al_volume, long al_produto, long al_qt_total_movimentada, ref string as_erro);Long ll_Qt_Pedida

select qt_pedida * qt_caixa_padrao 
Into :ll_Qt_Pedida
from wms_lista_separacao_produto
where	cd_filial						= :al_Filial
	and	nr_pedido_distribuidora	= :al_pedido
	and	nr_volume					= :al_volume
	and	cd_produto					= :al_Produto
Using SqlCa;

Choose Case Sqlca.Sqlcode
	Case -1	
		as_Erro = "Erro ao localizar a quantidade pedida na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_qt_movimentada': "+ SqlCa.SqlErrText
		Return False
		
	Case 0
		If al_qt_total_movimentada > ll_Qt_Pedida Then
			as_Erro = "Quantidade movimentada ("+String(al_qt_total_movimentada)+") do produto "+String(al_Produto)+" $$HEX1$$e900$$ENDHEX$$ maior do que a quantidade pedida ("+String(ll_Qt_Pedida)+")."
			Return False
		End If
		
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizada a quantidade pedida do produto "+String(al_Produto)+" na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_qt_movimentada'."
		Return False
		
End Choose

Return True
end function

public function boolean of_proximo_sequencial (long al_produto, string as_lote, string as_endereco, ref long al_sequencial, ref string as_erro);
select nr_sequencial
Into :al_Sequencial
From wms_localizacao
where cd_endereco	= :as_endereco
	and cd_produto		= :al_produto
	and nr_lote			= :as_lote
Using SqlCa;	

Choose Case Sqlca.Sqlcode
	Case -1	
		as_Erro = "Erro ao localizar o sequencial do produto "+String(al_Produto)+" no endere$$HEX1$$e700$$ENDHEX$$o "+as_Endereco+": "+ SqlCa.SqlErrText
		Return False
		
	Case 0
		Return True
		
	Case 100
		select coalesce(max(nr_sequencial), 0) + 1
		Into :al_Sequencial
		From wms_localizacao
		where cd_endereco	= :as_endereco
		Using SqlCa;
		
		If Sqlca.Sqlcode = -1 Then
			as_Erro = "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial no endere$$HEX1$$e700$$ENDHEX$$o "+as_Endereco+": "+ SqlCa.SqlErrText
			Return False
		End If
				
End Choose

Return True
end function

public function boolean of_valida_qtde_separada (long al_filial, long al_pedido, long al_volume, boolean ab_pedido_almoxarifado);String	ls_Parametro

Long ll_Produto

If ab_Pedido_Almoxarifado Then
	
	Select vl_parametro
	Into :ls_Parametro
	From wms_parametro
	Where cd_parametro = 'ID_VALIDA_QT_SEPARADA_CONFERENCIA'
	Using SqlCa;
	
	Choose Case Sqlca.Sqlcode
		Case -1	
			is_erro = "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro 'ID_VALIDA_QT_SEPARADA_CONFERENCIA': "+ SqlCa.SqlErrText
			SqlCa.of_Rollback()
			MessageBox("Erro", is_erro)
			Return False
			
		Case 0
			If ls_Parametro = "S" Then
				select top 1 cd_produto
				Into :ll_Produto
				from wms_lista_separacao_produto
				where cd_filial 						= :al_filial
					and nr_pedido_distribuidora	= :al_pedido
					and nr_volume					= :al_volume
					and (coalesce(qt_pedida, 0) * coalesce(qt_caixa_padrao, 0)) > (coalesce(qt_separada, 0) + coalesce(qt_divergencia, 0))
				Using SqlCa;	
				
				Choose Case Sqlca.Sqlcode
					Case -1	
						is_erro = "Erro ao verificar se a quantidade separada $$HEX1$$e900$$ENDHEX$$ diferente da quantidade pedida: "+ SqlCa.SqlErrText
						SqlCa.of_Rollback()
						MessageBox("Erro", is_erro)
						Return False
						
					Case 0
						is_erro = "A quantidade separada est$$HEX1$$e100$$ENDHEX$$ diferente da quantidade pedida. Produto "+String(ll_Produto)+"."
						SqlCa.of_Rollback()
						MessageBox("Erro", is_erro)
						Return False
						
				End Choose
				
			End If			
			
	End Choose

End If
	
Return True
end function

public function boolean of_processa_atualizacao (long al_filial, long al_pedido, long al_volume, boolean ab_conferencia_finalizada, ref string as_mensagem);Integer	ll_tentativa
Long ll_Linha, ll_Linhas, ll_Pedidos
Boolean 	lb_Sucesso,&
			lb_Pedido_Almoxarifado
String ls_Chave_Log, ls_MSG

try
	SetPointer(HourGlass!)
	Open(w_Aguarde)
	w_Aguarde.Title = 'Atualizando o movimento do pedido conferido...'
	
	If Not This.of_Parametro() Then
		as_mensagem = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_parametro' do objeto 'uo_ge256_conferencia_pedido'"
		Return False
	End if
	
	If SqlCa.SqlCode = -1 Then
		ls_MSG =	"Erro - Localiza$$HEX2$$e700e300$$ENDHEX$$o dos pedidos n$$HEX1$$e300$$ENDHEX$$o atualizados 'WMS'." +&
								" Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge256_conferencia_mov_estoque.of_processa_atualizacao '"+SqlCa.SqlErrText + "'."
		This.of_Grava_Log(ls_MSG, True)
		as_Mensagem = "O processo de confer$$HEX1$$ea00$$ENDHEX$$ncia est$$HEX1$$e100$$ENDHEX$$ sendo alocado por outro usu$$HEX1$$e100$$ENDHEX$$rio.~rTente finalizar a confer$$HEX1$$ea00$$ENDHEX$$ncia novamente."
		Return False	
	End If

	dc_uo_ds_base lds 
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge256_lista_pedidos") Then
		as_mensagem = "Erro no ChangeDataObject da 'ds_ge256_lista_pedidos'"
		Return False
	End If
	
	If Not IsNull(al_Filial) and Not IsNull(al_Pedido) and Not IsNull(al_Volume) Then
		lds.of_AppendWhere("cd_filial = " + String(al_Filial) + " and nr_pedido_distribuidora = " +&
														   String(al_Pedido) + " and nr_volume = " + String(al_Volume))
	End If
	
	if ab_conferencia_finalizada then
		lds.of_AppendWhere(" dh_termino_conferencia is not null")
	end if
	
	ll_Linhas  = lds.Retrieve()
	lb_Sucesso = False
	
	Choose case ll_Linhas
		case is > 0
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			For ll_Linha = 1 To ll_Linhas
				lb_Sucesso  = False
				il_Filial 						= lds.Object.cd_filial						[ll_Linha]
				il_Pedido 						= lds.Object.nr_pedido_distribuidora	[ll_Linha]
				il_Volume						= lds.Object.nr_volume						[ll_Linha]
				is_nr_matricula_conferente	= lds.Object.nr_matricula_conferente	[ll_Linha]
				
				is_erro      = ''
				is_chave_log = "Filial: " + String(il_Filial, "0000") + " Ped.: " + String(il_Pedido) +  " Volume: " + String(il_Volume)
				
				This.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio Confer$$HEX1$$ea00$$ENDHEX$$ncia", False)
				
				If This.of_atualiza_situacao_mov_estoque() Then
					If This.of_lote_produtos_nao_controlados() Then
						//Se conferiu todos os volumes muda a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido
						If This.of_situacao_pedido() Then
							If This.of_Insere_Lote_Pedido() Then
								If This.of_Consiste_Dados() Then
									If This.of_Pedido_Almoxarifado(al_Filial, al_Pedido, Ref lb_Pedido_Almoxarifado) Then
										If This.of_Atualiza_Situacao_Pedido_Almoxarifado(al_Filial, al_Pedido, lb_Pedido_Almoxarifado) Then
											If This.of_Atualiza_Qtde_Separada_Pedido_Almoxar(al_Filial, al_Pedido, al_volume, lb_Pedido_Almoxarifado) Then
												If This.of_Valida_Qtde_Separada(al_Filial, al_Pedido, al_volume, lb_Pedido_Almoxarifado) Then
													lb_Sucesso = True
												End If
											End If
										End If
									End If
								End If
							End If
						End If
					End If
				End If
				
				If lb_Sucesso Then
					SqlCa.of_Commit()
					This.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino Confer$$HEX1$$ea00$$ENDHEX$$ncia" +  is_chave_log, False)
				Else
					SqlCa.of_Rollback()
					as_Mensagem = 'Ocorreu um erro e n$$HEX1$$e300$$ENDHEX$$o foi finalizada a confer$$HEX1$$ea00$$ENDHEX$$ncia do volume'
					If is_erro <> '' then
						as_Mensagem += ':~n~n~r' + is_erro
					End if
				End If
				
				w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			Next
			
		case is < 0
			as_Mensagem = "Erro na leitura da lista de pedidos da 'ds_ge256_lista_pedidos': " + SQLCA.SQLErrText
			SqlCa.of_Rollback()
			
		case 0
			SqlCa.of_Rollback()
			as_Mensagem = 'Filial ' + Iif (IsNull (al_Filial), '?', String (al_Filial)) + &
							  ' / pedido ' + Iif (IsNull (al_Pedido), '?', String (al_Pedido)) + &
							  ' / volume = ' + Iif (IsNull (al_Volume), '?', String (al_Volume)) + &
							  ' n$$HEX1$$e300$$ENDHEX$$o encontrados para confer$$HEX1$$ea00$$ENDHEX$$ncia na lista de separa$$HEX2$$e700e300$$ENDHEX$$o!'
	End choose
		
finally
	Destroy(lds)
	Close(w_Aguarde)
	SetPointer(Arrow!)
	//FileClose(ii_log)
end try

Return lb_Sucesso
end function

public function boolean of_processa ();Long		ll_nr_pedido, ll_filial, ll_volume
String	ls_mensagem


SetNull(ll_nr_pedido)
SetNull(ll_filial)
SetNull(ll_volume)

Return This.of_processa_atualizacao(ll_filial, ll_nr_pedido, ll_volume, True, REF ls_mensagem)
end function

on uo_ge256_conferencia_pedido.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge256_conferencia_pedido.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

