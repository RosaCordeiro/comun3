HA$PBExportHeader$uo_ge059_exclusao_nf_compra.sru
forward
global type uo_ge059_exclusao_nf_compra from nonvisualobject
end type
end forward

global type uo_ge059_exclusao_nf_compra from nonvisualobject
end type
global uo_ge059_exclusao_nf_compra uo_ge059_exclusao_nf_compra

forward prototypes
public function boolean of_exclui_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, datetime adh_data_caixa, decimal adc_total_nf, integer ai_log, string as_chave_log)
public function boolean of_exclui_nota_fiscal (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, integer ai_log, string as_chave_log)
public function boolean of_exclui_item_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natope, long al_produto, integer ai_log, string as_chave_log)
public function boolean of_exclui_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, integer ai_log, string as_chave_log)
public function boolean of_atualiza_resumo_movimento (datetime adh_data_caixa, decimal adc_valor, integer ai_log, string as_chave_log)
public function boolean of_exclui_titulo_pagar (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, integer ai_log, string as_chave_log)
public function boolean of_exclui_movimento_estoque (string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_qtde, integer ai_log, string as_chave_log, ref boolean ab_possui_movimento)
public function boolean of_atualiza_saldo_produto (long al_produto, datetime adh_data, long al_qtde, integer ai_log, string as_chave_log, boolean ab_possui_estoque)
public function boolean of_exclui_nf_compra_old (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, datetime adh_data_caixa, decimal adc_total_nf, integer ai_log, string as_chave_log)
public function boolean of_exclui_item_nf_compra_lote (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natope, long al_produto, integer ai_log, string as_chave_log)
public function boolean of_exclui_movimento_estoque_item (string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_qtde, integer ai_log, string as_chave_log, ref boolean ab_possui_movimento)
public function boolean of_exclui_item_nf_compra_prd (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, integer ai_log, string as_chave_log)
end prototypes

public function boolean of_exclui_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, datetime adh_data_caixa, decimal adc_total_nf, integer ai_log, string as_chave_log);Boolean lvb_Sucesso = False,&
	    lvb_Possui_Movimento = False

Long lvl_Total, &
     lvl_Contador, &
	  lvl_NatOpe, &
	  lvl_Produto, &
	  lvl_Qtde

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
If Not lvds_1.of_ChangeDataObject("dw_ge059_item_nf_compra") Then Return False

lvl_Total = lvds_1.Retrieve(al_Filial, as_Fornecedor, al_NF, as_Especie, as_Serie)

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvl_NatOpe  	= lvds_1.Object.Cd_Natureza_Operacao	[lvl_Contador]
		lvl_Produto 	= lvds_1.Object.Cd_Produto          		[lvl_Contador]
		lvl_Qtde    	= lvds_1.Object.Qt_Faturada         		[lvl_Contador]

		lvb_Sucesso = False
		
		If This.of_Exclui_Item_NF_Compra_Prd( al_Filial, &
															as_Fornecedor, &
															al_NF, &
															as_Especie, &
															as_Serie, &
															lvl_Produto, &
															ai_Log, &
															as_Chave_Log) Then 
		
			If This.of_Exclui_Item_NF_Compra_Lote(al_Filial, &
														as_Fornecedor, &
														al_NF, &
														as_Especie, &
														as_Serie, &
														lvl_NatOpe, &
														lvl_Produto, &
														ai_Log, &
														as_Chave_Log) Then 
			
				If This.of_Exclui_Item_NF_Compra(al_Filial, &
															as_Fornecedor, &
															al_NF, &
															as_Especie, &
															as_Serie, &
															lvl_NatOpe, &
															lvl_Produto, &
															ai_Log, &
															as_Chave_Log) Then 
													 
					If This.of_Exclui_Movimento_Estoque(as_Fornecedor, &
																	al_NF, &
																	as_Especie, &
																	as_Serie, &
																	lvl_Produto, &
																	adh_Data_Caixa, &
																	lvl_Qtde, &
																	ai_Log, &
																	as_Chave_Log,&
																	Ref lvb_Possui_Movimento) Then 
		
						If This.of_Atualiza_Saldo_Produto(lvl_Produto, &
																	 adh_Data_Caixa, &
																	 lvl_Qtde, &
																	 ai_Log, &
																	 as_Chave_Log,&
																	 lvb_Possui_Movimento) Then
															  
							lvb_Sucesso = True								  
						End If
					End If
				End If
			End If
		End If
		
		If Not lvb_Sucesso Then Exit
	Next
	
	If lvb_Sucesso Then
		lvb_Sucesso = False

		If This.of_Exclui_Titulo_Pagar(al_Filial, &
											    as_Fornecedor, &
											    al_NF, &
											    as_Especie, &
											    as_Serie, &
											    ai_Log, &
											    as_Chave_Log) Then
		
			If This.of_Exclui_NF_Compra(al_Filial, &
												 as_Fornecedor, &
												 al_NF, &
												 as_Especie, &
												 as_Serie, &
												 ai_Log, &
												 as_Chave_Log) Then
										  
				If This.of_Atualiza_Resumo_Movimento(adh_Data_Caixa, &
																 adc_Total_NF, &
																 ai_Log, &
																 as_Chave_Log) Then
														  
					lvb_Sucesso = True
				End If
			End If		
		End If
	End If
Else
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Produtos da Nota Fiscal n$$HEX1$$e300$$ENDHEX$$o Localizados para Exclus$$HEX1$$e300$$ENDHEX$$o")	
End If

Return lvb_Sucesso
end function

public function boolean of_exclui_nota_fiscal (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, integer ai_log, string as_chave_log);Boolean lvb_Sucesso = False

DateTime lvdh_Data_Caixa

Decimal lvdc_Total_NF

Select dh_movimentacao_caixa,
       vl_total_nf
Into :lvdh_Data_Caixa,
     :lvdc_Total_NF
From nf_compra
Where cd_filial     = :al_Filial
  and cd_fornecedor = :as_Fornecedor
  and nr_nf         = :al_NF
  and de_especie    = :as_Especie
  and de_serie      = :as_Serie
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = This.of_Exclui_NF_Compra(al_Filial, &
															as_Fornecedor, &
															al_NF, &
															as_Especie, &
															as_Serie, &
															lvdh_Data_Caixa, &
															lvdc_Total_NF, &
															ai_Log, &
															as_Chave_Log)
	Case 100
		//SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Nota Fiscal n$$HEX1$$e300$$ENDHEX$$o Localizada para Exclus$$HEX1$$e300$$ENDHEX$$o")	
	Case -1
		SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o da Nota Fiscal para Exclus$$HEX1$$e300$$ENDHEX$$o")	
End Choose

Return lvb_Sucesso
end function

public function boolean of_exclui_item_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natope, long al_produto, integer ai_log, string as_chave_log);Delete From item_nf_compra
Where cd_filial            = :al_Filial
  and cd_fornecedor        = :as_Fornecedor
  and nr_nf                = :al_NF
  and de_especie           = :as_Especie
  and de_serie             = :as_Serie
  and cd_natureza_operacao = :al_NatOpe
  and cd_produto           = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "'")
	Return False
Else
	Return True
End If
end function

public function boolean of_exclui_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, integer ai_log, string as_chave_log);Delete From nf_compra
Where cd_filial     = :al_Filial
  and cd_fornecedor = :as_Fornecedor
  and nr_nf         = :al_NF
  and de_especie    = :as_Especie
  and de_serie      = :as_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o da Nota Fiscal de Compra")
	Return False
Else
	Return True
End If
end function

public function boolean of_atualiza_resumo_movimento (datetime adh_data_caixa, decimal adc_valor, integer ai_log, string as_chave_log);Update resumo_movimento_estoque
Set vl_compra = vl_compra - :adc_Valor
Where dh_resumo = :adh_Data_Caixa
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o - Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Resumo de Movimenta$$HEX2$$e700e300$$ENDHEX$$o")
	Return False
Else
	Return True
End If
end function

public function boolean of_exclui_titulo_pagar (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, integer ai_log, string as_chave_log);Delete From titulo_pagar
Where cd_filial     = :al_Filial
  and cd_fornecedor = :as_Fornecedor
  and nr_nf         = :al_NF
  and de_especie    = :as_Especie
  and de_serie      = :as_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o dos T$$HEX1$$ed00$$ENDHEX$$tulos a Pagar")
	Return False
Else
	Return True
End If
end function

public function boolean of_exclui_movimento_estoque (string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_qtde, integer ai_log, string as_chave_log, ref boolean ab_possui_movimento);Boolean lvb_Sucesso = False

Long lvl_Movimento, &
     lvl_Qtde
	 
ab_Possui_Movimento = False
	  
Select nr_movimento_estoque,
       qt_movimento
Into :lvl_Movimento,
     :lvl_Qtde
From movimento_estoque
Where cd_produto        = :al_Produto
  and dh_movimento      = :adh_Data_Caixa
  and nr_nf             = :al_NF
  and de_especie        = :as_Especie
  and de_serie          = :as_Serie
  and cd_fornecedor     = :as_Fornecedor
  and cd_tipo_movimento = 3
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Qtde = al_Qtde Then
			Delete From movimento_estoque
			Where cd_produto           = :al_Produto
			  and dh_movimento         = :adh_Data_Caixa
			  and nr_movimento_estoque = :lvl_Movimento
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Estoque do Produto '" + String(al_Produto) + "'")
			Else
				ab_Possui_Movimento = True
				lvb_Sucesso 		= True
			End If
		Else
			SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Movimento de Estoque do Produto '" + String(al_Produto) + "' $$HEX1$$e900$$ENDHEX$$ Diferente da Nota Fiscal para Exclus$$HEX1$$e300$$ENDHEX$$o")
		End If
	Case 100
		//SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Movimento de Estoque do Produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o Localizado para Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = True
	Case -1
		SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Movimento de Estoque do Produto '" + String(al_Produto) + "' para Exclus$$HEX1$$e300$$ENDHEX$$o")
End Choose

Return lvb_Sucesso
end function

public function boolean of_atualiza_saldo_produto (long al_produto, datetime adh_data, long al_qtde, integer ai_log, string as_chave_log, boolean ab_possui_estoque);Return True // Foi criada a trigger td_movimento_estoque que atualiza o saldo diretamente pelo banco de dados quando h$$HEX1$$e100$$ENDHEX$$ exlus$$HEX1$$e300$$ENDHEX$$o de movimento_estoque

//Date lvdt_Saldo
//
//lvdt_Saldo = Date("01/" + String(adh_Data, "mm/yyyy"))
//
//If ab_Possui_Estoque Then
//
//	Update saldo_produto
//	Set qt_saldo_final = qt_saldo_final - :al_Qtde
//	Where cd_produto  = :al_Produto
//	  and dh_saldo   >= :lvdt_Saldo
//	Using SqlCa;
//	
//	If SqlCa.SqlCode = -1 Then
//		SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o - Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo do Produto '" + String(al_Produto) + "'")
//		Return False
//	Else
//		Return True
//	End If
//Else
//	Return True
//End If
end function

public function boolean of_exclui_nf_compra_old (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, datetime adh_data_caixa, decimal adc_total_nf, integer ai_log, string as_chave_log);Boolean lvb_Sucesso = False,&
	    lvb_Possui_Movimento = False

Long lvl_Total, &
     lvl_Contador, &
	  lvl_NatOpe, &
	  lvl_Produto, &
	  lvl_Qtde

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
If Not lvds_1.of_ChangeDataObject("dw_ge059_item_nf_compra") Then Return False

lvl_Total = lvds_1.Retrieve(al_Filial, as_Fornecedor, al_NF, as_Especie, as_Serie)

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvl_NatOpe  = lvds_1.Object.Cd_Natureza_Operacao[lvl_Contador]
		lvl_Produto = lvds_1.Object.Cd_Produto          [lvl_Contador]
		lvl_Qtde    = lvds_1.Object.Qt_Faturada         [lvl_Contador]

		lvb_Sucesso = False
		
		If This.of_Exclui_Item_NF_Compra(al_Filial, &
												   as_Fornecedor, &
												   al_NF, &
												   as_Especie, &
												   as_Serie, &
												   lvl_NatOpe, &
												   lvl_Produto, &
													ai_Log, &
													as_Chave_Log) Then 
											 
			If This.of_Exclui_Movimento_Estoque(as_Fornecedor, &
														   al_NF, &
														   as_Especie, &
														   as_Serie, &
														   lvl_Produto, &
														   adh_Data_Caixa, &
														   lvl_Qtde, &
														   ai_Log, &
														   as_Chave_Log,&
														   Ref lvb_Possui_Movimento) Then 

				If This.of_Atualiza_Saldo_Produto(lvl_Produto, &
															 adh_Data_Caixa, &
															 lvl_Qtde, &
															 ai_Log, &
															 as_Chave_Log,&
															 lvb_Possui_Movimento) Then
													  
					lvb_Sucesso = True								  
				End If
			End If
		End If
		
		If Not lvb_Sucesso Then Exit
	Next
	
	If lvb_Sucesso Then
		lvb_Sucesso = False

		If This.of_Exclui_Titulo_Pagar(al_Filial, &
											    as_Fornecedor, &
											    al_NF, &
											    as_Especie, &
											    as_Serie, &
											    ai_Log, &
											    as_Chave_Log) Then
		
			If This.of_Exclui_NF_Compra(al_Filial, &
												 as_Fornecedor, &
												 al_NF, &
												 as_Especie, &
												 as_Serie, &
												 ai_Log, &
												 as_Chave_Log) Then
										  
				If This.of_Atualiza_Resumo_Movimento(adh_Data_Caixa, &
																 adc_Total_NF, &
																 ai_Log, &
																 as_Chave_Log) Then
														  
					lvb_Sucesso = True
				End If
			End If		
		End If
	End If
Else
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Produtos da Nota Fiscal n$$HEX1$$e300$$ENDHEX$$o Localizados para Exclus$$HEX1$$e300$$ENDHEX$$o")	
End If

Return lvb_Sucesso
end function

public function boolean of_exclui_item_nf_compra_lote (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natope, long al_produto, integer ai_log, string as_chave_log);Delete From item_nf_compra_lote
Where cd_filial            = :al_Filial
  and cd_fornecedor        = :as_Fornecedor
  and nr_nf                = :al_NF
  and de_especie           = :as_Especie
  and de_serie             = :as_Serie
  and cd_natureza_operacao = :al_NatOpe
  and cd_produto           = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "'")
	Return False
Else
	Return True
End If
end function

public function boolean of_exclui_movimento_estoque_item (string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_qtde, integer ai_log, string as_chave_log, ref boolean ab_possui_movimento);Boolean lvb_Sucesso = False

Long lvl_Movimento, &
     lvl_Qtde
	 
ab_Possui_Movimento = False
	  
Select max(nr_movimento_estoque)
Into :lvl_Movimento
From movimento_estoque
Where cd_produto        = :al_Produto
  and dh_movimento      = :adh_Data_Caixa
  and nr_nf             = :al_NF
  and de_especie        = :as_Especie
  and de_serie          = :as_Serie
  and cd_fornecedor     = :as_Fornecedor
  and cd_tipo_movimento = 3
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Select qt_movimento
		Into :lvl_Qtde
		From movimento_estoque
		Where nr_movimento_estoque =:lvl_Movimento
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Movimento de Estoque do Produto '" + String(al_Produto) + "'")
			Return False
		End If
			
		If lvl_Qtde = al_Qtde Then
			Delete From movimento_estoque
			Where cd_produto           = :al_Produto
			  and dh_movimento         = :adh_Data_Caixa
			  and nr_movimento_estoque = :lvl_Movimento
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Estoque do Produto '" + String(al_Produto) + "'")
			Else
				ab_Possui_Movimento = True
				lvb_Sucesso 		= True
			End If
		Else
			SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Movimento de Estoque do Produto '" + String(al_Produto) + "' $$HEX1$$e900$$ENDHEX$$ Diferente da Nota Fiscal para Exclus$$HEX1$$e300$$ENDHEX$$o")
		End If
	Case 100
		//SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Movimento de Estoque do Produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o Localizado para Exclus$$HEX1$$e300$$ENDHEX$$o")
		lvb_Sucesso = True
	Case -1
		SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Movimento de Estoque do Produto '" + String(al_Produto) + "' para Exclus$$HEX1$$e300$$ENDHEX$$o")
End Choose

Return lvb_Sucesso
end function

public function boolean of_exclui_item_nf_compra_prd (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, integer ai_log, string as_chave_log);Delete From item_nf_compra_prd
Where cd_filial            		= :al_Filial
  and cd_fornecedor        	= :as_Fornecedor
  and nr_nf                		= :al_NF
  and de_especie           		= :as_Especie
  and de_serie             		= :as_Serie
  and cd_produto           			= :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "'")
	Return False
Else
	Return True
End If
end function

on uo_ge059_exclusao_nf_compra.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge059_exclusao_nf_compra.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

