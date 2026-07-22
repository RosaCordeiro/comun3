HA$PBExportHeader$uo_transacao_online.sru
forward
global type uo_transacao_online from nonvisualobject
end type
end forward

global type uo_transacao_online from nonvisualobject
end type
global uo_transacao_online uo_transacao_online

type variables
dc_uo_ds_base ivds_transferencia

dc_uo_transacao ivtr_trans_destino

dc_uo_odbc ivo_Odbc

Boolean	ivs_Inclui_Exclui_Odbc

String is_Base_Producao = 'S'
end variables

forward prototypes
public function boolean of_lote (long pl_origem, long pl_nota, string ps_especie, string ps_serie)
public function boolean of_grava_direto_destino (long pl_origem, long pl_nota, string ps_especie, string ps_serie, long pl_filial_destino)
public function boolean of_connect (long pl_filial)
public function boolean of_nota (long pl_origem, long pl_nota, string ps_especie, string ps_serie, long pl_filial_destino)
public function boolean of_item (long pl_origem, long pl_nota, string ps_especie, string ps_serie, long pl_filial_destino)
public function boolean of_conecta_filial_destino (long pl_filial_destino)
public subroutine of_nf_transferencia_online ()
public function boolean of_inclui_odbc (long pl_filial)
public function boolean of_grava_nf_transferencia_online (string ps_origem, string ps_nota, string ps_especie, string ps_serie, string ps_destino, boolean pb_gravou_destino)
public subroutine of_disconnect_destino ()
end prototypes

public function boolean of_lote (long pl_origem, long pl_nota, string ps_especie, string ps_serie);String lvs_Lote, &
		 lvs_Chave_Log

Long lvl_Natureza, &
	  lvl_Produto, &
	  lvl_Qtde, &
	  lvl_Achou, &
	  lvl_Linha, &
	  lvl_Rows, &
	  lvl_Produto_Aux = 0
	  
Date ldt_Fabricacao, ldt_Validade
	  
If Not ivds_transferencia.of_ChangeDataObject('ds_ge096_item_nf_transferencia_lote') Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Erro ao carregar o datastore ds_ge096_item_nf_transferencia_lote', StopSign!)
	Return False
End If

ivds_transferencia.Reset()
lvl_Rows = ivds_transferencia.Retrieve(pl_Origem, pl_Nota, ps_Especie, ps_Serie)

lvs_Chave_Log = "ITEM_NF_TRANSFERENCIA_LOTE (" + String(pl_Origem) + " : " + String(pl_Nota) + " : " + ps_Especie + " : " + ps_Serie + ")"

If lvl_Rows < 0 Then		
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia. Chave: ' + lvs_Chave_Log, StopSign!)
	Return False		
End If

If lvl_Rows > 0 Then
	
	For lvl_Linha=1 To lvl_Rows
		//			 
		lvl_Natureza 	= ivds_transferencia.Object.cd_natureza_operacao	[lvl_Linha]
		lvl_Produto  	 	= ivds_transferencia.Object.cd_produto			      	[lvl_Linha]
		lvs_Lote		 	= ivds_transferencia.Object.nr_lote				      	[lvl_Linha]
		lvl_Qtde       	= ivds_transferencia.Object.qt_lote		 	          	[lvl_Linha]
		ldt_Fabricacao	= ivds_transferencia.Object.dt_Fabricacao		 	 	[lvl_Linha]
		ldt_Validade		= ivds_transferencia.Object.dt_validade			 	 	[lvl_Linha] 
		
		If lvl_Produto <> lvl_Produto_Aux Then
			lvl_Produto_Aux = lvl_Produto
			
		  Delete
			 From item_nf_transferencia_lote
			Where cd_filial_origem     = :pl_Origem
			  and nr_nf                      = :pl_Nota
			  and de_especie              = :ps_Especie
			  and de_serie                  = :ps_Serie
			  and cd_natureza_operacao = :lvl_Natureza
			  and cd_produto              = :lvl_Produto
			Using ivtr_trans_destino;
						
			If ivtr_trans_destino.SqlCode = -1 Then
				ivtr_trans_destino.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o")
				Return False
			End If
			
		End If
		
		Insert Into item_nf_transferencia_lote(cd_filial_origem,   
													  nr_nf,   
													  de_especie,   
													  de_serie,   
													  cd_natureza_operacao,   
													  cd_produto,   
													  nr_lote,
													  qt_lote,
													  dt_fabricacao,
													  dt_validade)  
		Values (:pl_Origem,   
				  :pl_Nota,   
				  :ps_Especie,   
				  :ps_Serie,   
				  :lvl_Natureza,   
				  :lvl_Produto,   
				  :lvs_Lote,
				  :lvl_Qtde,
				  :ldt_fabricacao,
				  :ldt_validade)
		Using ivtr_trans_destino;

		If ivtr_trans_destino.SqlCode = -1 Then
			ivtr_trans_destino.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o")
			Return False
		End If				
		
	Next
	
End If

Return True
end function

public function boolean of_grava_direto_destino (long pl_origem, long pl_nota, string ps_especie, string ps_serie, long pl_filial_destino);Boolean lvb_Sucesso = False

//Parametro para realiza$$HEX2$$e700e300$$ENDHEX$$o de teste no desenvolvimento - parametro_loja: ID_BASE_PRODUCAO (S,N)
String ls_Parametro

If is_Base_Producao = 'N'  Then
	Return of_Grava_Nf_Transferencia_Online( String(pl_Origem), String(pl_Nota), ps_Especie, ps_Serie, String(pl_filial_destino), False )
End If

w_Aguarde.Title = "Realizando conex$$HEX1$$e300$$ENDHEX$$o com a filial de destino, aguarde..."
Yield()
If ivo_Odbc.of_Localiza_Parametro_Odbc(pl_filial_destino) Then
	Yield()
	If ivo_Odbc.of_Grava_Regedit_Odbc(pl_filial_destino) Then
		Yield()
		If This.of_Connect(pl_filial_destino) Then
			Yield()
			w_Aguarde.Title = "Gravando dados do cabe$$HEX1$$e700$$ENDHEX$$alho da nota, aguarde..."
			If of_Nota(pl_Origem, pl_Nota, ps_Especie, ps_Serie, pl_filial_destino) Then
				Yield()
				w_Aguarde.Title = "Gravando dados dos itens da nota, aguarde..."
				If of_Item(pl_Origem, pl_Nota, ps_Especie, ps_Serie, pl_filial_destino) Then
					Yield()
					w_Aguarde.Title = "Gravando dados dos lotes dos itens da nota, aguarde..."
					If of_Lote(pl_Origem, pl_Nota, ps_Especie, ps_Serie) Then
						ivtr_trans_destino.of_Commit()
						lvb_Sucesso = True
					End If //Lote
				End If //Item
			End If //Nota
		Else
			lvb_Sucesso = of_Grava_Nf_Transferencia_Online(String(pl_Origem), String(pl_Nota), ps_Especie, ps_Serie, String(pl_filial_destino), False)
		End If //Conex$$HEX1$$e300$$ENDHEX$$o
	End If //Registro	
End If //Parametro

ivo_Odbc.of_Deleta_Regedit_Odbc( pl_filial_destino )

Return lvb_Sucesso
end function

public function boolean of_connect (long pl_filial);String lvs_Odbc_Destino

lvs_Odbc_Destino = String(pl_Filial, "0000")

If ivtr_Trans_Destino.of_isConnected() Then ivtr_Trans_Destino.of_Disconnect()

If Not ivo_Odbc.of_Connect(lvs_Odbc_Destino, 'dbo', 'teste') Then
	Return False
End If

/* Fernando Cambiaghi - 13/09/2016
 * O hostname ( tl_importacao ) $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio para que a trigger da nf_transferencia no destino n$$HEX1$$e300$$ENDHEX$$o grave log_exportacao
 * A verifica$$HEX2$$e700e300$$ENDHEX$$o do nome do hostname $$HEX1$$e900$$ENDHEX$$ feita na fun$$HEX2$$e700e300$$ENDHEX$$o do banco de dados uf_gera_log_exportacao( )
 */
If ivo_Odbc.ivs_Pdv_Java = 'S' Then
	ivtr_Trans_Destino.ivs_DataBase = 'POSTGRESQL_JAVA'
Else
	ivtr_Trans_Destino.ivs_DataBase = 'POSTGRESQL'
End If

If Not ivtr_Trans_Destino.of_Connect(lvs_Odbc_Destino, 'tl_importacao') Then	Return False

Return True
end function

public function boolean of_nota (long pl_origem, long pl_nota, string ps_especie, string ps_serie, long pl_filial_destino);String lvs_Produto_Vencido, &
		 lvs_Operador       , &
		 lvs_Cancelamento   , &
		 lvs_Cd_Distribuidora, &
		 lvs_Chave_Log

Long lvl_Pedido_Distribuidora, &
	  lvl_Nsu, &
	  lvl_Achou, &
	  lvl_Rows, &
	  lvl_Remanejamento,&
	  lvl_Total_Itens
	  
	  
Decimal lvdc_Base_ICMS , &
		  lvdc_Valor_ICMS, &
		  lvdc_Base_ST   , &
		  lvdc_Valor_ST  , &
		  lvdc_Total_Produtos, &
		  lvdc_Total_NF

DateTime lvdt_Emissao    , &
	  		lvdt_Caixa      , &
	  		lvdt_Recebimento, &
	  		lvdt_Cancelamento, &
			lvdh_Mov_Caixa	, &
			lvdt_Parametro_Destino

If Not ivds_transferencia.of_ChangeDataObject('ds_ge096_nf_transferencia') Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Erro ao carregar o datastore ds_ge096_nf_transferencia', StopSign!)
	Return False		
End If

lvs_Chave_Log = "NF_TRANSFERENCIA (" + String(pl_Origem) + " : " + String(pl_Nota) + " : " + ps_Especie + " : " + ps_Serie + ")"

ivds_transferencia.Reset()

If ivds_transferencia.Retrieve(pl_Origem, pl_Nota, ps_Especie, ps_Serie) < 1 Then		
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia. Chave: ' + lvs_Chave_Log, StopSign!)
	Return False	
End If

//			 
lvdt_Emissao             	= ivds_transferencia.Object.dh_emissao				   		[1]
lvdh_Mov_Caixa           	= DateTime(ivds_transferencia.Object.dh_movimentacao_caixa [1])
lvdc_Base_ICMS           	= ivds_transferencia.Object.vl_bc_icms				   	   	[1]
lvdc_Valor_ICMS          	= ivds_transferencia.Object.vl_icms				      		[1]
lvdc_Base_ST             	= ivds_transferencia.Object.vl_bc_icms_st		      		[1]
lvdc_Valor_ST            	= ivds_transferencia.Object.vl_icms_st			      		[1]
lvdc_Total_Produtos      	= ivds_transferencia.Object.vl_total_produtos	      		[1]
lvdc_Total_NF            	= ivds_transferencia.Object.vl_total_nf		     	   		[1]
lvs_Operador             	= ivds_transferencia.Object.nr_matricula_operador    	[1]
lvs_Produto_Vencido      	= ivds_transferencia.Object.id_produto_vencido		   	[1]
lvdt_Recebimento         	= DateTime(ivds_transferencia.Object.dh_recebimento	[1])
lvdt_Cancelamento        	= DateTime(ivds_transferencia.Object.dh_cancelamento	[1])
lvs_Cancelamento         	= ivds_transferencia.Object.nr_matricula_cancelamento	[1]
lvs_Cd_Distribuidora     	= ivds_transferencia.Object.cd_distribuidora	      		[1]
lvl_Pedido_Distribuidora 	= ivds_transferencia.Object.nr_pedido_distribuidora  		[1]
lvl_Nsu					    	= ivds_transferencia.Object.nr_nsu						   	[1]	
lvl_Remanejamento		= ivds_transferencia.Object.cd_remanejamento		   	[1]	
lvl_Total_Itens				= ivds_transferencia.Object.nr_itens						   	[1]	
//Postgres do sistema Java n$$HEX1$$e300$$ENDHEX$$o possui essa tabela no Schema 'legado'
If ivo_Odbc.ivs_pdv_java <> 'S' Then
	Select dh_movimentacao
		Into :lvdt_Parametro_Destino
	  From parametro
	Where id_parametro = '1'
	  Using ivtr_trans_destino;
	  
	Choose Case ivtr_trans_destino.SqlCode
		Case 0
			If lvdh_Mov_Caixa > lvdt_Parametro_Destino Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi pss$$HEX1$$ed00$$ENDHEX$$vel gravar a transferencia na filial de destino, ' + &
												'pois a data da nota fiscal $$HEX1$$e900$$ENDHEX$$ maior que a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o da filial de destino.~r~r' + &
												'Filial destino: ' + String(pl_Filial_Destino) + ' :: Nota: ' + String(pl_Nota), StopSign! )
				Return False
												
			End If
			
		Case 100
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o da filial de destino.~r~r' + &
											'Filial destino: ' + String(pl_Filial_Destino) + ' :: Nota: ' + String(pl_Nota), StopSign! )
			Return False
			
		Case -1
			ivtr_trans_destino.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o - Chave: " + lvs_Chave_Log)
			Return False
			
	End Choose
End If

//Retirado do update a coluna dh_recebimento pois $$HEX1$$e900$$ENDHEX$$ utilizada no controle de saldo pendente na filial destino.
//Ao receber o malote na intranet essa coluna $$HEX1$$e900$$ENDHEX$$ atualizada na filial destino

Select nr_nf 
  Into :lvl_Achou
 From nf_transferencia
Where cd_filial_origem 	= :pl_Origem
	 and nr_nf         	 	= :pl_Nota
	 and de_especie     	= :ps_Especie
	 and de_serie       		= :ps_Serie
 Using ivtr_trans_destino;
		
Choose Case ivtr_trans_destino.SqlCode
	Case 0
			Update nf_transferencia
			Set cd_filial_destino         		= :pl_Filial_Destino,
				 dh_emissao                		= :lvdt_Emissao,
				 dh_movimentacao_caixa	= :lvdh_Mov_Caixa,
				 vl_bc_icms                		= :lvdc_Base_ICMS,
				 vl_icms                   			= :lvdc_Valor_ICMS,
				 vl_bc_icms_st             		= :lvdc_Base_ST,
				 vl_icms_st                		= :lvdc_Valor_ST,
				 vl_total_produtos         		= :lvdc_Total_Produtos,
				 vl_total_nf               			= :lvdc_Total_NF,
				 nr_matricula_operador     	= :lvs_Operador,
				 id_produto_vencido        	= :lvs_Produto_Vencido,
				 cd_distribuidora          		= :lvs_Cd_Distribuidora,
				 nr_pedido_distribuidora  	= :lvl_Pedido_Distribuidora,
				 nr_nsu                    			= :lvl_Nsu,
				 cd_remanejamento			= :lvl_Remanejamento,
				 nr_itens							= :lvl_Total_Itens
			Where cd_filial_origem 	= :pl_Origem
			  and nr_nf            		= :pl_Nota
			  and de_especie       		= :ps_Especie
			  and de_serie         		= :ps_Serie						  
			Using ivtr_trans_destino;
			
			If ivtr_trans_destino.SqlCode = -1 Then
				ivtr_trans_destino.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o - Chave: " + lvs_Chave_Log)
				Return False
			End If				
		
	Case 100
			Insert Into nf_transferencia (cd_filial_origem,   
													nr_nf,   
													de_especie,   
													de_serie,   
													cd_filial_destino,   
													dh_emissao,   
													dh_movimentacao_caixa,   
													vl_bc_icms,   
													vl_icms,   
													vl_bc_icms_st,   
													vl_icms_st,   
													vl_total_produtos,   
													vl_total_nf,   
													nr_matricula_operador,   
													id_produto_vencido,   
													dh_cancelamento,   
													nr_matricula_cancelamento,   
													cd_distribuidora,
													nr_pedido_distribuidora,
													nr_nsu,
													cd_remanejamento,
													nr_itens)
			Values (:pl_Origem,   
					  :pl_Nota,   
					  :ps_Especie,   
					  :ps_Serie,   
					  :pl_Filial_Destino,   
					  :lvdt_Emissao,   
					  :lvdh_Mov_Caixa,   
					  :lvdc_Base_ICMS,   
					  :lvdc_Valor_ICMS,   
					  :lvdc_Base_ST,   
					  :lvdc_Valor_ST,   
					  :lvdc_Total_Produtos,   
					  :lvdc_Total_NF,   
					  :lvs_Operador,   
					  :lvs_Produto_Vencido,
					  null,  //:lvdt_Cancelamento,
					  null, //:lvs_Cancelamento,
					  :lvs_Cd_Distribuidora,
					  :lvl_Pedido_Distribuidora,
					  :lvl_Nsu,
					  :lvl_Remanejamento,
					  :lvl_Total_Itens)
			Using ivtr_trans_destino;
	
			If ivtr_trans_destino.SqlCode = -1 Then
				ivtr_trans_destino.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o - Chave: " + lvs_Chave_Log)
				Return False
			End If				
		
	Case -1
		ivtr_trans_destino.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o - Chave: " + lvs_Chave_Log)
		Return False
		
End Choose		
//	

Return True
end function

public function boolean of_item (long pl_origem, long pl_nota, string ps_especie, string ps_serie, long pl_filial_destino);String lvs_Chave_Log

Long  lvl_Achou, &
	  lvl_Linha, &
	  lvl_Rows

//Campos
Long lvl_cd_filial_origem
Long lvl_nr_nf
String lvs_de_especie
String lvs_de_serie
Long lvl_cd_natureza_operacao
Long lvl_cd_produto
Long lvl_cd_filial_destino
String lvs_cd_situacao_tributaria
Long lvl_qt_transferida
Decimal{2} lvdc_vl_custo_unitario
Decimal{2} lvdc_pc_icms
Decimal{2} lvdc_vl_custo_gerencial
Decimal{2} lvdc_vl_bc_icms_st
Decimal{2} lvdc_vl_icms_st
Decimal{2} lvdc_vl_bc_icms
Decimal{2} lvdc_vl_icms
Decimal{2} lvdc_pc_icms_st
Decimal{4} lvdc_pc_reducao_base_st
String lvs_cd_cst_origem
String lvs_cd_cst_tributacao
Long lvl_cd_mensagem_fiscal
Decimal{4} lvdc_vl_bc_icms_antecipacao 
Decimal{2} lvdc_pc_mva_icms_antecipacao
Decimal{2} lvdc_pc_icms_antecipacao
Decimal{4} lvdc_vl_icms_antecipacao
Decimal{4} lvdc_vl_bc_icms_st_origem
Decimal{2} lvdc_pc_icms_st_origem
Decimal{4} lvdc_vl_icms_st_origem
String lvs_de_chave_acesso_origem
Long lvl_nr_sequencial
Decimal{2} lvdc_vl_bc_icms_st_retido
Decimal{2} lvdc_vl_icms_st_retido
Decimal{2} lvdc_pc_st_retido
Decimal{2} lvdc_vl_icms_retido
String lvs_cd_beneficio
Decimal{2} lvdc_vl_icms_operacao
Decimal{4} lvdc_pc_icms_diferido
Decimal{2} lvdc_vl_icms_diferido

If Not ivds_transferencia.of_ChangeDataObject('ds_ge096_item_nf_transferencia') Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Erro ao carregar o datastore ds_ge096_item_nf_transferencia', StopSign!)
	Return False
End If

ivds_transferencia.Reset()
lvl_Rows = ivds_transferencia.Retrieve(pl_Origem, pl_Nota, ps_Especie, ps_Serie)

lvs_Chave_Log = "ITEM_NF_TRANSFERENCIA (" + String(pl_Origem) + " : " + String(pl_Nota) + " : " + ps_Especie + " : " + ps_Serie + ")"

If lvl_Rows < 0 Then		
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es dos itens da nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia. Chave: ' + lvs_Chave_Log)
	Return False		
End If

For lvl_Linha=1 To lvl_Rows	
	lvl_cd_filial_origem					= ivds_transferencia.Object.cd_filial_origem				[lvl_Linha]
	lvl_nr_nf           						= ivds_transferencia.Object.nr_nf								[lvl_Linha]
	lvs_de_especie							= ivds_transferencia.Object.de_especie						[lvl_Linha]
	lvs_de_serie								= ivds_transferencia.Object.de_serie							[lvl_Linha]
	lvl_cd_natureza_operacao			= ivds_transferencia.Object.cd_natureza_operacao		[lvl_Linha]
	lvl_cd_produto            				= ivds_transferencia.Object.cd_produto						[lvl_Linha]
	lvl_cd_filial_destino					= ivds_transferencia.Object.cd_filial_destino				[lvl_Linha]
	lvs_cd_situacao_tributaria			= ivds_transferencia.Object.cd_situacao_tributaria		[lvl_Linha]
	lvl_qt_transferida            			= ivds_transferencia.Object.qt_transferida					[lvl_Linha]
	lvdc_vl_custo_unitario					= ivds_transferencia.Object.vl_custo_unitario				[lvl_Linha]
	lvdc_pc_icms           					= ivds_transferencia.Object.pc_icms							[lvl_Linha]
	lvdc_vl_custo_gerencial				= ivds_transferencia.Object.vl_custo_gerencial				[lvl_Linha]
	lvdc_vl_bc_icms_st           			= ivds_transferencia.Object.vl_bc_icms_st					[lvl_Linha]
	lvdc_vl_icms_st           				= ivds_transferencia.Object.vl_icms_st						[lvl_Linha]
	lvdc_vl_bc_icms           				= ivds_transferencia.Object.vl_bc_icms						[lvl_Linha]
	lvdc_vl_icms           					= ivds_transferencia.Object.vl_icms							[lvl_Linha]
	lvdc_pc_icms_st           				= ivds_transferencia.Object.pc_icms_st						[lvl_Linha]
	lvdc_pc_reducao_base_st			= ivds_transferencia.Object.pc_reducao_base_st			[lvl_Linha]
	lvs_cd_cst_origem           			= ivds_transferencia.Object.cd_cst_origem					[lvl_Linha]
	lvs_cd_cst_tributacao           		= ivds_transferencia.Object.cd_cst_tributacao				[lvl_Linha]
	lvl_cd_mensagem_fiscal           	= ivds_transferencia.Object.cd_mensagem_fiscal			[lvl_Linha]
	lvdc_vl_bc_icms_antecipacao		= ivds_transferencia.Object.vl_bc_icms_antecipacao		[lvl_Linha]
	lvdc_pc_mva_icms_antecipacao	= ivds_transferencia.Object.pc_mva_icms_antecipacao	[lvl_Linha]
	lvdc_pc_icms_antecipacao           	= ivds_transferencia.Object.pc_icms_antecipacao			[lvl_Linha]
	lvdc_vl_icms_antecipacao           	= ivds_transferencia.Object.vl_icms_antecipacao			[lvl_Linha]
	lvdc_vl_bc_icms_st_origem          	= ivds_transferencia.Object.vl_bc_icms_st_origem		[lvl_Linha]
	lvdc_pc_icms_st_origem           	= ivds_transferencia.Object.pc_icms_st_origem			[lvl_Linha]
	lvdc_vl_icms_st_origem				= ivds_transferencia.Object.vl_icms_st_origem				[lvl_Linha]
	lvs_de_chave_acesso_origem		= ivds_transferencia.Object.de_chave_acesso_origem	[lvl_Linha]
	lvl_nr_sequencial           				= ivds_transferencia.Object.nr_sequencial					[lvl_Linha]
	lvdc_vl_bc_icms_st_retido           	= ivds_transferencia.Object.vl_bc_icms_st_retido			[lvl_Linha]
	lvdc_vl_icms_st_retido				= ivds_transferencia.Object.vl_icms_st_retido				[lvl_Linha]
	lvdc_pc_st_retido       				= ivds_transferencia.Object.pc_st_retido						[lvl_Linha]
	lvdc_vl_icms_retido           			= ivds_transferencia.Object.vl_icms_retido					[lvl_Linha]
	lvs_cd_beneficio           				= ivds_transferencia.Object.cd_beneficio						[lvl_Linha]
	lvdc_vl_icms_operacao   		        	= ivds_transferencia.Object.vl_icms_operacao				[lvl_Linha]
	lvdc_pc_icms_diferido		           	= ivds_transferencia.Object.pc_icms_diferido				[lvl_Linha]
	lvdc_vl_icms_diferido 			     	= ivds_transferencia.Object.vl_icms_diferido				[lvl_Linha]

	
	Select nr_nf Into :lvl_Achou
	From item_nf_transferencia
	Where cd_filial_origem			= :lvl_cd_filial_origem
	  and nr_nf							= :lvl_nr_nf
	  and de_especie					= :lvs_de_especie
	  and de_serie						= :lvs_de_serie
	  and cd_natureza_operacao	= :lvl_cd_natureza_operacao
	  and cd_produto           			= :lvl_cd_produto
	Using ivtr_trans_destino;
				
	Choose Case ivtr_trans_destino.SqlCode
		Case 0
			
		Case 100		
			If lvdc_vl_custo_gerencial = 0 Then SetNull(lvdc_vl_custo_gerencial)
			
			Insert Into item_nf_transferencia (cd_filial_origem,
														 nr_nf,
														 de_especie,
														 de_serie,
														 cd_natureza_operacao,
														 cd_produto,
														 cd_filial_destino,
														 cd_situacao_tributaria,
														 qt_transferida,
														 vl_custo_unitario,
														 pc_icms,
														 vl_custo_gerencial,
														 vl_bc_icms_st,
														 vl_icms_st,
														 vl_bc_icms,
														 vl_icms,
														 pc_icms_st,
														 pc_reducao_base_st,
														 cd_cst_origem,
														 cd_cst_tributacao,
														 cd_mensagem_fiscal,
														 vl_bc_icms_antecipacao,
														 pc_mva_icms_antecipacao,
														 pc_icms_antecipacao,
														 vl_icms_antecipacao,
														 vl_bc_icms_st_origem,
														 pc_icms_st_origem,
														 vl_icms_st_origem,
														 de_chave_acesso_origem,
														 nr_sequencial,
														 vl_bc_icms_st_retido,
														 vl_icms_st_retido,
														 pc_st_retido,
														 vl_icms_retido,
														 cd_beneficio,
														 vl_icms_operacao,
														 pc_icms_diferido,
														 vl_icms_diferido)  
			Values (:lvl_cd_filial_origem,
						:lvl_nr_nf,
						:lvs_de_especie,
						:lvs_de_serie,
						:lvl_cd_natureza_operacao,
						:lvl_cd_produto,
						:lvl_cd_filial_destino,
						:lvs_cd_situacao_tributaria,
						:lvl_qt_transferida,
						:lvdc_vl_custo_unitario,
						:lvdc_pc_icms,
						:lvdc_vl_custo_gerencial,
						:lvdc_vl_bc_icms_st,
						:lvdc_vl_icms_st,
						:lvdc_vl_bc_icms,
						:lvdc_vl_icms,
						:lvdc_pc_icms_st,
						:lvdc_pc_reducao_base_st,
						:lvs_cd_cst_origem,
						:lvs_cd_cst_tributacao,
						:lvl_cd_mensagem_fiscal,
						:lvdc_vl_bc_icms_antecipacao ,
						:lvdc_pc_mva_icms_antecipacao,
						:lvdc_pc_icms_antecipacao,
						:lvdc_vl_icms_antecipacao,
						:lvdc_vl_bc_icms_st_origem,
						:lvdc_pc_icms_st_origem,
						:lvdc_vl_icms_st_origem,
						:lvs_de_chave_acesso_origem,
						:lvl_nr_sequencial,
						:lvdc_vl_bc_icms_st_retido,
						:lvdc_vl_icms_st_retido,
						:lvdc_pc_st_retido,
						:lvdc_vl_icms_retido,
						:lvs_cd_beneficio,
						:lvdc_vl_icms_operacao,
						:lvdc_pc_icms_diferido,
						:lvdc_vl_icms_diferido)
			Using ivtr_trans_destino;
	
			If ivtr_trans_destino.SqlCode = -1 Then
				ivtr_trans_destino.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o - Chave: " + lvs_Chave_Log)
				Return False
			End If				
		Case -1
			ivtr_trans_destino.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o - Chave: " + lvs_Chave_Log)
			Return False
	End Choose		
	//	
Next

Return True
end function

public function boolean of_conecta_filial_destino (long pl_filial_destino);Boolean lvb_Sucesso = True

lvb_Sucesso = This.of_Inclui_Odbc( pl_Filial_Destino )

If lvb_Sucesso Then
	If This.of_Connect( pl_Filial_Destino ) Then
		lvb_Sucesso = True
	Else //of_connect
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao conectar na filial de Destino.", StopSign!)
		lvb_Sucesso = False
	End If //of_connect
End If

If This.ivs_Inclui_Exclui_Odbc Then
	ivo_Odbc.of_Deleta_Regedit_Odbc(pl_filial_destino)
End If

Return lvb_Sucesso
end function

public subroutine of_nf_transferencia_online ();Boolean lb_Sucesso	= True
Boolean lb_Executa

Long 	ll_Origem
Long 	ll_Destino
Long 	ll_Nota
Long	ll_Row
Long	ll_Filial
Long	ll_Filial_Matriz
Long	ll_Achou

gf_Filiais_Parametro( ref ll_Filial, ref ll_Filial_Matriz )

String ls_Especie
String ls_Serie
String ls_Argumentos
String ls_Operador
String ls_PDV_NOVO

Open( w_Aguarde )
w_Aguarde.Title = "Realizando transfer$$HEX1$$ea00$$ENDHEX$$ncia online, aguarde..."
Yield()

//Parametro para realiza$$HEX2$$e700e300$$ENDHEX$$o de teste no desenvolvimento - parametro_loja: ID_BASE_PRODUCAO (S,N)
 Select Coalesce( vl_parametro, 'S' )
    Into :is_Base_Producao
  From parametro_loja
Where cd_parametro = 'ID_BASE_PRODUCAO'
  Using SqlCa;

dc_uo_ds_base lds_Transferencia	
lds_Transferencia = Create dc_uo_ds_base
	
If lds_Transferencia.of_ChangeDataObject("ds_ge096_transferencia_online") Then
	
	w_Aguarde.Title = "Recuperado informa$$HEX2$$e700f500$$ENDHEX$$es da nota fiscal, aguarde..."
	Yield()
	lds_Transferencia.Retrieve()
		
	If lds_Transferencia.RowCount() > 0 Then
		
		uo_transacao_remota lo_SD
		lo_SD = Create uo_transacao_remota
			
		For ll_Row = 1 To lds_Transferencia.RowCount()
			lb_Executa		= True
			
			ll_Origem	= lds_Transferencia.Object.cd_filial_origem				[ll_Row]
			ll_Nota    		= lds_Transferencia.Object.nr_nf							[ll_Row]
			ls_Especie	= lds_Transferencia.Object.de_especie					[ll_Row]
			ls_Serie		= lds_Transferencia.Object.de_serie						[ll_Row]
			ll_Destino	= lds_Transferencia.Object.cd_filial_destino				[ll_Row]
			ls_Operador	= lds_Transferencia.Object.Nr_Matricula_Operador	[ll_Row]
			
			ls_argumentos =	"cd_filial_origem="	+ String( ll_Origem )	+ &
									"&cd_filial_destino="	+ String( ll_Destino )	+ &
									"&nr_nf="				+ String( ll_Nota )		+ &
									"&de_serie="			+ ls_Serie 				+ &
									"&de_especie="		+ ls_Especie 			+ &
									"&nr_matricula="		+ ls_Operador
									
			If is_Base_Producao = 'S' Then
				lo_SD.of_Executa_Rotina_Intranet( 'registra_saida_transferencia', ls_argumentos )
			Else
				lo_SD.of_Executa_Rotina_Intranet( 'registra_saida_transferencia', ls_argumentos, False )
			End If
			
			/* Gambiarra - 07/07/2014
			 * Se a filial destino for o CD, n$$HEX1$$e300$$ENDHEX$$o grava no destino, mas d$$HEX1$$e100$$ENDHEX$$ update na nf_transferencia_online */
			If ll_Destino = ll_Filial_Matriz Then
				lb_Executa = True
			Else			
				Select cd_filial, COALESCE(id_pdv_java, 'N')
				  Into :ll_Achou, :ls_PDV_NOVO
				  From parametro_odbc
				 Where cd_filial = :ll_Destino
				 Using SqlCa;
				 
				Choose Case SqlCa.SqlCode
					Case -1
						SqlCa.of_MsgDbError("LOCALIZA$$HEX2$$c700c300$$ENDHEX$$O DO PAR$$HEX1$$c200$$ENDHEX$$METRO_ODBC")
						Continue
						
					Case 100
						lb_Executa = of_Grava_Nf_Transferencia_Online( String(ll_Origem), String(ll_Nota), ls_Especie, ls_Serie, String(ll_Destino), False )
						
					Case 0
						//Vai gravar tambem na matriz
						If (ls_PDV_Novo = 'S') Then
							of_Grava_Nf_Transferencia_Online( String(ll_Origem), String(ll_Nota), ls_Especie, ls_Serie, String(ll_Destino), False )
						End If
						
						lb_Executa = of_Grava_Direto_Destino( ll_Origem, ll_Nota, ls_Especie, ls_Serie, ll_Destino )
						
				End Choose
			End If
			
			If lb_Executa Then
				
				Update nf_transferencia_online
				Set dh_transferencia		= GetDate()
				Where cd_filial_origem	= :ll_Origem
				  and nr_nf					= :ll_Nota
				  and de_especie			= :ls_Especie
				  and de_serie				= :ls_Serie
				Using Sqlca;
				
				If Sqlca.SqlCode = -1 Then
					Sqlca.of_RollBack()
					ivtr_trans_destino.of_RollBack()
					Sqlca.of_MsgDbError("UPDATE TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA ONLINE")
					lb_Sucesso = False
					Exit
				Else
					Sqlca.of_Commit()
				End If	
			Else
				lb_Sucesso = False
			End If						
		Next
		
		Destroy lo_SD
	End If	
Else
	lb_Sucesso = False
End If

w_Aguarde.Title = "Desconectando da filial de destino, aguarde..."
Yield()

Destroy(lds_Transferencia)
If ivtr_Trans_Destino.of_isConnected() Then ivtr_Trans_Destino.of_Disconnect()

Close( w_Aguarde )

If lb_Sucesso Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Transmiss$$HEX1$$e300$$ENDHEX$$o realizada com sucesso!")
Else	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro durante a transmiss$$HEX1$$e300$$ENDHEX$$o.", StopSign! )
End If
end subroutine

public function boolean of_inclui_odbc (long pl_filial);Boolean lvb_Sucesso = False

If Not This.ivs_Inclui_Exclui_Odbc Then
	Return True
End If

If ivo_Odbc.of_Localiza_Parametro_Odbc( pl_Filial ) Then
	If ivo_Odbc.of_Grava_Regedit_Odbc( pl_Filial ) Then
		lvb_Sucesso = True
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_grava_nf_transferencia_online (string ps_origem, string ps_nota, string ps_especie, string ps_serie, string ps_destino, boolean pb_gravou_destino);Boolean lvb_Sucesso = False

Long 	 lvl_Filial
Long	 lvl_Row

String lvs_Documento
String lvs_Tabela

// Comentado, pois gravar$$HEX1$$e100$$ENDHEX$$ no banco de homologa$$HEX2$$e700e300$$ENDHEX$$o
//If is_Base_Producao = 'N'  Then
//	Return True
//End If

lvs_Documento = ps_origem + "/" + ps_nota + "/" + ps_especie + "/" + ps_serie

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvs_Tabela	 = "nf_transferencia_online"		

If lvo_Conexao.of_Executa_Rotina("0019",{ps_origem, ps_nota, "'" + ps_especie + "'", "'" + ps_serie + "'"}) Then
	
	If lvo_Conexao.of_Linhas() > 0 Then
		String lvs_Set
		String lvs_Where
		
		If pb_Gravou_Destino Then
			lvs_Set = "dh_transferencia = getdate(),"
		Else
			lvs_Set = "dh_transferencia = null,"
		End If
		
		lvs_Set		+= "dh_atualizacao   = getdate()"
		
		lvs_Where	 = " cd_filial_origem = " + ps_origem 
		lvs_Where	+= " and nr_nf			= "  + ps_nota
		lvs_Where	+=	" and de_especie	= '" + ps_especie + "'"
		lvs_Where	+= " and de_serie		= '" + ps_serie	+ "'"
		
		lvb_Sucesso = lvo_Conexao.of_Update_Registro( lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row )
				
	ElseIf lvo_Conexao.of_Linhas() = 0 Then
		String lvs_Colunas
		String lvs_Values
				
		lvs_Colunas = "cd_filial_origem, nr_nf, de_especie, de_serie, cd_filial_destino, dh_atualizacao, dh_transferencia"
				
		lvs_Values	  = ps_origem			+ ","
		lvs_Values	 += ps_nota 			+ ","
		lvs_Values	 += "'" + ps_especie	+ "',"
		lvs_Values	 += "'" + ps_serie	+ "',"
		lvs_Values	 += ps_destino			+ ","
		lvs_Values	 += "getdate()"			+ ","
		
		If pb_Gravou_Destino Then
			lvs_Values	 += "getdate()"
		Else
			lvs_Values	 += "null"
		End If
		
		lvb_Sucesso = lvo_Conexao.of_Insert_Registro( lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row )
		
	End If
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Verifica$$HEX2$$e700e300$$ENDHEX$$o da Transfer$$HEX1$$ea00$$ENDHEX$$ncia online '" + lvs_Documento + "'.", StopSign!)
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public subroutine of_disconnect_destino ();If ivtr_Trans_Destino.of_isConnected() Then ivtr_Trans_Destino.of_Disconnect()
end subroutine

on uo_transacao_online.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_transacao_online.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivtr_trans_destino 	= Create dc_uo_Transacao
ivo_odbc 			= Create dc_uo_odbc
ivds_transferencia = Create dc_uo_ds_base

This.ivs_Inclui_Exclui_Odbc=False

If ProfileString( gvo_Aplicacao.ivs_Arquivo_INI , "Desenvolvimento", "Inclui_Exclui_ODBC", "S" ) = "S" Then
	This.ivs_Inclui_Exclui_Odbc=True
End If
end event

event destructor;Destroy ivds_transferencia
Destroy ivo_odbc

Destroy ivtr_trans_destino
end event

