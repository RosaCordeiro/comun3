HA$PBExportHeader$uo_distribuicao_pedido.sru
forward
global type uo_distribuicao_pedido from nonvisualobject
end type
end forward

global type uo_distribuicao_pedido from nonvisualobject
end type
global uo_distribuicao_pedido uo_distribuicao_pedido

type variables
String ivs_distribuidora_estoque
String ivs_Versao_Layout
end variables

forward prototypes
public function boolean of_atualiza_sequencial_arquivo (long al_filial, string as_distribuidora, long al_sequencial)
public function boolean of_filial_distribuidora (long al_filial, string as_distribuidora, ref string as_filial_distribuidora, ref long al_sequencial)
public function boolean of_layout_pedido_estoque (long al_filial, long al_pedido, string as_distribuidora, dc_uo_ds_base ads_produto, ref string as_arquivo)
public subroutine of_localiza_distribuidora_estoque ()
public function boolean of_atualiza_pedido_atendido (long al_filial, long al_pedido_distribuidora, long al_pedido_filial, string as_situacao)
public function boolean of_verifica_pedido_promocao_distribuidor (long al_filial, long al_pedido, string as_distribuidora, ref string as_promocao_distribuidora, ref string as_prazo)
public function boolean of_verifica_pedido_enviado (long al_filial, long al_pedido_filial, ref boolean ab_existe)
public function boolean of_layout_pedido_padrao (long al_filial, long al_pedido, string as_distribuidora, dc_uo_ds_base ads_produto, ref string as_arquivo)
public function boolean of_versao_layout (string as_distribuidora, ref string as_versao)
public function boolean of_cgc_filial (long al_filial, ref string as_cgc)
public function boolean of_layout_pedido_padrao_new (long al_filial, long al_pedido, string as_distribuidora, dc_uo_ds_base ads_produto, ref string as_arquivo, string as_tipo_pedido)
public function boolean of_grava_arquivo_pedido (long al_filial, long al_pedido, string as_distribuidora, ref string as_arquivo, string as_tipo_pedido)
public subroutine of_decimal (decimal adc_valor, ref string as_valor)
public function boolean of_codigo_barras_produto (string as_distribuidora, long al_produto, long al_filial, ref string as_codigo_barras, ref string ads_preco_uni, ref string ads_desconto, ref string ads_repasse_icms)
public function boolean of_insere_log_exportacao (long al_filial, long al_pedido, string as_erro)
end prototypes

public function boolean of_atualiza_sequencial_arquivo (long al_filial, string as_distribuidora, long al_sequencial);String lvs_Mensagem

Update filial_distribuidora
Set nr_sequencial_arquivo = :al_Sequencial
Where cd_filial 	     = :al_Filial
  and cd_distribuidora = :as_Distribuidora
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial do arquivo na filial distribuidora.")
	Return False
Else
	SqlCa.of_Commit()
	Return True
End If
end function

public function boolean of_filial_distribuidora (long al_filial, string as_distribuidora, ref string as_filial_distribuidora, ref long al_sequencial);String lvs_Mensagem

Select cd_filial_distribuidora,
       nr_sequencial_arquivo
Into :as_Filial_Distribuidora,
     :al_Sequencial
From filial_distribuidora
Where cd_filial 	     = :al_Filial
  and cd_distribuidora = :as_Distribuidora
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(al_Sequencial) Then al_Sequencial = 0
		al_Sequencial ++
		
		If al_Sequencial = 100 Then al_Sequencial = 1
		
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial na distribuidora n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		Return False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo da filial na distribuidora.")
		Return False
End Choose
end function

public function boolean of_layout_pedido_estoque (long al_filial, long al_pedido, string as_distribuidora, dc_uo_ds_base ads_produto, ref string as_arquivo);Boolean lvb_Sucesso = False

String lvs_Registro, &
		 lvs_Chave, &
		 lvs_Mensagem, &
		 lvs_Path_Pedido

Long lvl_Contador, &
	  lvl_Qtde_Pedida, &
	  lvl_Produto

Integer lvi_Arquivo, &
        lvi_Write

lvs_Chave = "Grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo do pedido '" + &
            String(al_Pedido, "000000") + "' da filial '" + String(al_Filial, "0000") + "'.~r~r"
								
lvs_Path_Pedido = gvo_Aplicacao.of_GetFromINI("Diretorio", "Pedidos")

as_Arquivo = lvs_Path_Pedido + as_Distribuidora + "\" + &
             String(al_Filial, "N000") + String(al_Pedido, "0000") + ".ped"

lvi_Arquivo = FileOpen(as_Arquivo, LineMode!, Write!, LockWrite!, Replace!)

If lvi_Arquivo = -1 Then		
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na abertura do arquivo '" + as_Arquivo + "'.", StopSign!)
Else
	// Registro Cabe$$HEX1$$e700$$ENDHEX$$alho
	lvs_Registro = "1" + String(al_Filial, "000000") + &
	                     String(Today(), "dd/mm/yy") + &
								String(al_pedido, "000000")
																				
	lvi_Write = FileWrite(lvi_Arquivo, lvs_Registro)
	
	If lvi_Write = -1 Then		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro cabe$$HEX1$$e700$$ENDHEX$$alho do arquivo '" + as_Arquivo + "'.", StopSign!)
	Else
		lvb_Sucesso = True
		
		For lvl_Contador = 1 To ads_Produto.RowCount()
			lvl_Produto     = ads_Produto.Object.Cd_Produto[lvl_Contador]
			lvl_Qtde_Pedida = ads_Produto.Object.Qt_Pedida [lvl_Contador]
			
			// Registro Detalhe
			lvs_Registro = "2" + String(lvl_Produto, "000000") + &
			                     String(lvl_Qtde_Pedida, "000000")

			lvi_Write = FileWrite(lvi_Arquivo, lvs_Registro)
				
			If lvi_Write = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro detalhe do arquivo '" + as_Arquivo + "'.", StopSign!)
				lvb_Sucesso = False
				Exit
			End If				
		Next
	End If				
	
	FileClose(lvi_Arquivo)
	
	If Not lvb_Sucesso Then
		If Not FileDelete(as_Arquivo) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + as_Arquivo + "'.", StopSign!)
		End If
	End If
End If

Return lvb_Sucesso
end function

public subroutine of_localiza_distribuidora_estoque ();Select cd_distribuidora_estoque Into :This.ivs_Distribuidora_Estoque
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Distribuidora do estoque n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		SetNull(This.ivs_Distribuidora_Estoque)
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Distribuidora do Estoque")
		SetNull(This.ivs_Distribuidora_Estoque)
End Choose
end subroutine

public function boolean of_atualiza_pedido_atendido (long al_filial, long al_pedido_distribuidora, long al_pedido_filial, string as_situacao);Boolean lvb_Existe

String ls_Erro


Update pedido_distribuidora
Set id_situacao = :as_Situacao
Where cd_filial               = :al_Filial
  and nr_pedido_distribuidora = :al_Pedido_Distribuidora
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Situa$$HEX2$$e700e300$$ENDHEX$$o do Pedido Distribuidora")
	Return False
End If

If al_Filial = 534 Then
	If as_situacao = 'C' Then
			  If not of_insere_log_exportacao(al_Filial, al_Pedido_Distribuidora, ls_Erro) Then
					SqlCa.of_MsgdbError(ls_Erro)
			  End if
		 Else
			  SqlCa.of_MsgdbError(ls_Erro)
		 End if
End if


// Verifica se ainda existem pedidos distribuidora com situa$$HEX2$$e700e300$$ENDHEX$$o "enviado",
// ou seja, cujas faltas ainda n$$HEX1$$e300$$ENDHEX$$o foram atualizadas
If Not This.of_Verifica_Pedido_Enviado(al_Filial, &
													al_Pedido_Filial, &
													ref lvb_Existe) Then 
	Return False
End If
	
If Not lvb_Existe Then
	Update pedido_filial
	Set id_situacao = 'C',
		 nr_prioridade_distribuidora = nr_prioridade_distribuidora + 1
	Where cd_filial        = :al_Filial
	  and nr_pedido_filial = :al_Pedido_Filial
	  and id_situacao <> 'F'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Situa$$HEX2$$e700e300$$ENDHEX$$o do Pedido Filial")
		Return False
	End If		
End If

Return True
end function

public function boolean of_verifica_pedido_promocao_distribuidor (long al_filial, long al_pedido, string as_distribuidora, ref string as_promocao_distribuidora, ref string as_prazo);Boolean lvb_Sucesso = True

Select b.cd_promocao_distribuidora,
       b.nr_dias_pagamento
Into :as_Promocao_Distribuidora,
     :as_Prazo
From pedido_distribuidora a,
     promocao_distribuidora b
Where a.cd_filial                 = :al_Filial
  and a.nr_pedido_distribuidora   = :al_Pedido
  and a.cd_distribuidora          = :as_Distribuidora
  and a.cd_promocao_distribuidora = b.cd_promocao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Erro na Localiza$$HEX2$$e700e300$$ENDHEX$$o da Promo$$HEX2$$e700e300$$ENDHEX$$o Distribuidora")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean of_verifica_pedido_enviado (long al_filial, long al_pedido_filial, ref boolean ab_existe);Long lvl_Total

Select count(*) Into :lvl_Total
From pedido_distribuidora
Where cd_filial        = :al_Filial
  and nr_pedido_filial = :al_Pedido_Filial
  and id_situacao      = 'E'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia de Pedidos Enviados")
	Return False
End If

If IsNull(lvl_Total) Then lvl_Total = 0

If lvl_Total > 0 Then
	ab_Existe = True
Else
	ab_Existe = False
End If
		
Return True
end function

public function boolean of_layout_pedido_padrao (long al_filial, long al_pedido, string as_distribuidora, dc_uo_ds_base ads_produto, ref string as_arquivo);Boolean lvb_Sucesso = False

String lvs_Filial_Distribuidora, &
		 lvs_Registro, &
		 lvs_Chave, &
		 lvs_Mensagem, &
		 lvs_Produto_Distribuidora, &
		 lvs_Path_Pedido, &
		 lvs_Promocao_Distribuidora, &
		 lvs_Prazo

Long lvl_Sequencial, &
     lvl_Contador, &
	  lvl_Produto, &
	  lvl_Total_Produtos, &
	  lvl_Qtde_Pedida, &
	  lvl_Qtde_Total

Integer lvi_Arquivo, &
        lvi_Write

lvs_Chave = "Grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo do pedido '" + &
            String(al_Pedido, "00000") + "' da filial '" + String(al_Filial, "0000") + "'.~r~r"

If This.of_Filial_Distribuidora(al_Filial, &
                                as_Distribuidora, &
									     lvs_Filial_Distribuidora, &
									     lvl_Sequencial) Then
									
	lvs_Path_Pedido = gvo_Aplicacao.of_GetFromINI("Diretorio", "Pedidos")
	
	as_Arquivo = lvs_Path_Pedido + as_Distribuidora + "\" + &
	             lvs_Filial_Distribuidora + "_" + String(al_Pedido, "00000") + ".ped"
					 
	//If FileExists ( as_Arquivo ) Then Return True
	
	If FileExists( as_Arquivo ) Then
		If Not FileDelete( as_Arquivo ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + as_Arquivo + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_layout_pedido_padrao", StopSign!)
			Return False
		End If
	End If
		
	lvi_Arquivo = FileOpen(as_Arquivo, LineMode!, Write!, LockWrite!, Replace!)
	
	If lvi_Arquivo = -1 Then		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na abertura do arquivo '" + as_Arquivo + "'.", StopSign!)
	Else
		If Not of_Verifica_Pedido_Promocao_Distribuidor(al_filial, &
		   														   al_Pedido, &
																		as_Distribuidora, &
																		Ref lvs_Promocao_Distribuidora, &
																		Ref lvs_Prazo) Then Return False
		
		
		// Registro Cabe$$HEX1$$e700$$ENDHEX$$alho
		lvs_Registro = "1" + &
							"00001" + &
							"PED" + &
							as_Distribuidora + &
							LeftA(lvs_Filial_Distribuidora + Space(6), 6) + &
							String(al_Pedido, "00000")
		
		Choose Case as_Distribuidora
//			Case "053400519"
//				If IsNull(lvs_Prazo) Then lvs_Prazo = ""
//				If IsNull(lvs_Promocao_Distribuidora) Then lvs_Promocao_Distribuidora = ""
//									
//            lvs_Registro += LeftA(lvs_Promocao_Distribuidora + Space(10),10)
//				lvs_Registro += String(Long(lvs_Prazo), "000")
					
			Case "053404408"  // Pr$$HEX1$$f300$$ENDHEX$$-Farma ( nova distribuidora )
				
				lvs_Registro += LeftA(lvs_Promocao_Distribuidora + Space(10), 10)
		End Choose
		
		lvi_Write = FileWrite(lvi_Arquivo, lvs_Registro)
		
		If lvi_Write = -1 Then		
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro cabe$$HEX1$$e700$$ENDHEX$$alho do arquivo '" + as_Arquivo + "'.", StopSign!)
		Else
			lvb_Sucesso = True
			
			lvl_Total_Produtos = ads_Produto.RowCount()
			
			For lvl_Contador = 1 To lvl_Total_Produtos
				lvl_Produto               = ads_Produto.Object.Cd_Produto              [lvl_Contador]
				lvs_Produto_Distribuidora = ads_Produto.Object.Cd_Produto_Distribuidora[lvl_Contador]
				lvl_Qtde_Pedida           = ads_Produto.Object.Qt_Pedida               [lvl_Contador]
				
				lvl_Qtde_Total += lvl_Qtde_Pedida
				
				If LenA(lvs_Produto_Distribuidora) > 8 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo '" + lvs_Produto_Distribuidora + "' do produto '" + &
					                      String(lvl_Produto) + "' na distribuidora '" + as_Distribuidora + &
 											    "' inv$$HEX1$$e100$$ENDHEX$$lido.", Information!)
					lvb_Sucesso = False
					Exit
				End If
				
				lvs_Produto_Distribuidora = LeftA(lvs_Produto_Distribuidora + Space(8), 8)
				
				// Registro Detalhe
				lvs_Registro = "2" + &	
				               String(lvl_Contador + 1, "00000") + &
				               lvs_Produto_Distribuidora + &
									String(lvl_Qtde_Pedida, "00000") 
									 
				lvi_Write = FileWrite(lvi_Arquivo, lvs_Registro)
					
				If lvi_Write = -1 Then		
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro detalhe do arquivo '" + as_Arquivo + "'.", StopSign!)
					lvb_Sucesso = False
					Exit
				End If				
			Next
			
			If lvb_Sucesso Then
				// Registro Finalizador
				lvs_Registro = "3" + String(lvl_Total_Produtos + 2, "00000") + &
						 				   String(lvl_Total_Produtos, "00000") + &
											String(lvl_Qtde_Total, "0000000")
			
				lvi_Write = FileWrite(lvi_Arquivo, lvs_Registro)
				
				If lvi_Write = -1 Then		
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro finalizador do arquivo '" + as_Arquivo + "'.", StopSign!)
					lvb_Sucesso = False
				End If				
			End If
		End If				
		
		FileClose(lvi_Arquivo)
		
		If Not lvb_Sucesso Then
			If Not FileDelete(as_Arquivo) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + as_Arquivo + "'.", StopSign!)
			End If
		End If
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_versao_layout (string as_distribuidora, ref string as_versao);as_Versao = ""

Select nr_layout_pedido_eletronico
Into :as_Versao
From fornecedor
Where cd_fornecedor =:as_Distribuidora
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$fa00$$ENDHEX$$mero do layout do pedido eletr$$HEX1$$f400$$ENDHEX$$nico.")
	Return False
End If

Return True
end function

public function boolean of_cgc_filial (long al_filial, ref string as_cgc);Select nr_cgc
	Into :as_cgc
From filial
 Where cd_filial = :al_Filial
 Using SqlCa;
 
If SqlCa.SqlCode <> 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar o CGC da filial " + String( al_Filial ))
	Return False
End If

Return True
end function

public function boolean of_layout_pedido_padrao_new (long al_filial, long al_pedido, string as_distribuidora, dc_uo_ds_base ads_produto, ref string as_arquivo, string as_tipo_pedido);Boolean lvb_Sucesso = False

String lvs_Filial_Distribuidora, &
		 lvs_Registro, &
		 lvs_Chave, &
		 lvs_Produto_Distribuidora, &
		 lvs_Path_Pedido, &
		 lvs_Promocao_Distribuidora, &
		 lvs_Prazo, &
		 lvs_CGC, &
		 ls_Codigo_Barras, &
		 ls_Erro, &
		 ls_Preco_Uni, &
		 ls_Desconto, &
		 ls_Repasse_ICMS

Long lvl_Sequencial, &
     lvl_Contador, &
	  lvl_Produto, &
	  lvl_Total_Produtos, &
	  lvl_Qtde_Pedida, &
	  lvl_Qtde_Total
	  
Long ll_Layout

Integer lvi_Arquivo, &
        lvi_Write

If Not gf_ge071_Versao_Layout_Ped_Eletronico_Sap(as_Distribuidora, Ref ll_Layout, True, Ref ls_Erro) Then Return False

// Riomed
If as_Distribuidora = '053400534' Then
	lvs_Chave = "Grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo do pedido '" + &
            	 String(al_Pedido, "00000") + "' da filial '" + String(al_Filial, "0000") + "'.~r~r"
Else
	lvs_Chave = "Grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo do pedido '" + &
	             String(al_Pedido, "00000000") + "' da filial '" + String(al_Filial, "0000") + "'.~r~r"
End If

If This.of_Filial_Distribuidora(al_Filial, &
                                as_Distribuidora, &
									     Ref lvs_Filial_Distribuidora, &
									     Ref lvl_Sequencial) Then
									
	lvs_Path_Pedido = gvo_Aplicacao.of_GetFromINI("Diretorio", "Pedidos")
	
	If as_Distribuidora = '053400534' Then
		as_Arquivo = lvs_Path_Pedido + as_Distribuidora + "\" + &
	             	 lvs_Filial_Distribuidora + "_" + String(al_Pedido, "00000") + ".ped"
	Else
		as_Arquivo = lvs_Path_Pedido + as_Distribuidora + "\" + &
	             	 lvs_Filial_Distribuidora + "_" + String(al_Pedido, "00000000") + ".ped"
	End If
	
	//If FileExists ( as_Arquivo ) Then Return True
	
	If FileExists( as_Arquivo ) Then
		If Not FileDelete( as_Arquivo ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + as_Arquivo + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_layout_pedido_padrao_new", StopSign!)
			Return False
		End If
	End If
	
	lvi_Arquivo = FileOpen(as_Arquivo, LineMode!, Write!, LockWrite!, Replace!)
	
	If lvi_Arquivo = -1 Then		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na abertura do arquivo '" + as_Arquivo + "'.", StopSign!)
	Else
			// Registro Cabe$$HEX1$$e700$$ENDHEX$$alho
			lvs_Registro = "1" + &
							"00001" + &
							"PED" + &
							as_Distribuidora + &
							LeftA(lvs_Filial_Distribuidora + Space(6), 6)
															
			If ll_Layout >= 124 then
				lvs_Registro += String(al_Pedido, "0000000000")
			Else
				lvs_Registro += String(al_Pedido, "00000000")
			End If
		
			If as_Distribuidora = "053402679" Or as_Distribuidora = "053405798" Or as_Distribuidora = "053405365" Or as_Distribuidora = "053405859" or as_Distribuidora = "053402517" or as_Distribuidora = "053403680" or as_Distribuidora = "053400645" or &
				as_Distribuidora = "053405926" or as_Distribuidora = "053400534" or as_distribuidora = '053405966' or as_Distribuidora = "053405954" or as_Distribuidora = '053406094' or as_Distribuidora = "053405266" or as_Distribuidora = '053406139' Or &
				as_Distribuidora = "053406145" or as_Distribuidora = "053406147" or as_Distribuidora = "053406148" or as_Distribuidora = "053403312" Or as_Distribuidora = "053400519" Or as_Distribuidora = "053406093" Or as_Distribuidora = "053405356" Or &
				as_Distribuidora = "053405539" Or as_Distribuidora = "053405860" Or as_Distribuidora = "053406158" Or as_Distribuidora = "053406177" Or as_Distribuidora = "053400528" Or as_Distribuidora = "053405938" Or as_Distribuidora = "053405954" Or &
				as_Distribuidora = "053405988" Or as_Distribuidora = "053405383" Or as_Distribuidora = "053405889" Or as_Distribuidora = "053406200" Or as_Distribuidora = "053479655" Or as_Distribuidora = "053479585" Or as_Distribuidora = "053403680" Or &
				ll_Layout >= 123 Then
									
				If Not This.of_CGC_Filial( al_Filial, Ref lvs_CGC ) Then Return False
					
				lvs_Registro = lvs_Registro + Space(10) + lvs_CGC
					
				//Distribuidora Prati, Santa Cruz, Panpharma, Medicamental, Gauchafarma, Gen$$HEX1$$e900$$ENDHEX$$sio, Servimed j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e300$$ENDHEX$$o no novo layout (1.23)
				If as_Distribuidora = "053406145" or as_Distribuidora = "053406147" Or as_Distribuidora = "053406148"  or as_Distribuidora = "053403312" Or as_Distribuidora = "053400519" Or as_Distribuidora = "053406093" Or as_Distribuidora = "053405356" Or &
					as_Distribuidora = "053405539" Or as_Distribuidora = "053405860" Or as_Distribuidora = "053406158" Or as_Distribuidora = "053406177" Or as_Distribuidora = "053400528" Or as_Distribuidora = "053405938" Or as_Distribuidora = "053405954" Or &
					as_Distribuidora = "053405988" Or as_Distribuidora = "053405383" Or as_Distribuidora = "053405889" Or as_Distribuidora = "053406200" Or as_Distribuidora = "053479655" Or as_Distribuidora = "053479585" Or as_Distribuidora = "053403680" Or &
					ll_Layout >= 123 Then
					lvs_Registro = lvs_Registro + as_tipo_pedido
				End If
			End If
			
//		End If
		
		Choose Case as_Distribuidora
					
			Case "053404408"  // Pr$$HEX1$$f300$$ENDHEX$$-Farma (nova distribuidora)
				lvs_Registro += LeftA(lvs_Promocao_Distribuidora + Space(10), 10)
		End Choose
		
		lvi_Write = FileWrite(lvi_Arquivo, lvs_Registro)
		
		If lvi_Write = -1 Then		
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro cabe$$HEX1$$e700$$ENDHEX$$alho do arquivo '" + as_Arquivo + "'.", StopSign!)
		Else
			lvb_Sucesso = True
			
			lvl_Total_Produtos = ads_Produto.RowCount()
			
			For lvl_Contador = 1 To lvl_Total_Produtos
				lvl_Produto						= ads_Produto.Object.Cd_Produto              		[lvl_Contador]
				lvs_Produto_Distribuidora	= ads_Produto.Object.Cd_Produto_Distribuidora		[lvl_Contador]
				lvl_Qtde_Pedida				= ads_Produto.Object.Qt_Pedida              			[lvl_Contador]
				
				lvl_Qtde_Total += lvl_Qtde_Pedida
				
				If as_distribuidora = '053403680' and Mid(lvs_Produto_Distribuidora, 1,1) = 'M' Then
					lvs_Produto_Distribuidora = Mid(lvs_Produto_Distribuidora, 2) 
				End If
								
				If LenA(lvs_Produto_Distribuidora) > 8 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo '" + lvs_Produto_Distribuidora + "' do produto '" + &
					                      String(lvl_Produto) + "' na distribuidora '" + as_Distribuidora + &
 											    "' inv$$HEX1$$e100$$ENDHEX$$lido.", Information!)
					lvb_Sucesso = False
					Exit
				End If
				
				lvs_Produto_Distribuidora = LeftA(lvs_Produto_Distribuidora + Space(8), 8)
				
				// Registro Detalhe
				lvs_Registro = "2" + &
				               String(lvl_Contador + 1, "00000") + &
				               lvs_Produto_Distribuidora + &
									String(lvl_Qtde_Pedida, "00000")
									
				If as_Distribuidora = "053406145" or as_Distribuidora = "053406147" Or as_Distribuidora = "053406148" or as_Distribuidora = "053403312" Or as_Distribuidora = "053400519" Or as_Distribuidora = "053406093" Or as_Distribuidora = "053405356" Or &
					as_Distribuidora = "053405539" Or as_Distribuidora = "053405860" Or as_Distribuidora = "053406094" or as_Distribuidora = "053402679" or as_Distribuidora = "053402517" or as_Distribuidora = "053405798" Or as_Distribuidora = "053405365" Or &
					as_Distribuidora = "053406158" Or as_Distribuidora = "053406177" Or as_Distribuidora = "053400528" Or as_Distribuidora = "053405938" or as_Distribuidora = "053405954" Or as_Distribuidora = "053405988" Or as_Distribuidora = "053405383" Or &
					as_Distribuidora = "053405889" Or as_Distribuidora = "053406200" Or as_Distribuidora = "053479655" Or as_Distribuidora = "053479585" Or as_Distribuidora = "053403680" Or + &
					ll_Layout >= 123 Then
					
					If Not of_Codigo_Barras_Produto(as_Distribuidora, lvl_Produto, al_Filial, Ref ls_Codigo_Barras, Ref ls_Preco_Uni, Ref ls_Desconto, ls_Repasse_ICMS) Then Return False

					If ll_Layout <= 126 Or (ivs_Versao_Layout <= '1.27' And Not IsNull(ivs_Versao_Layout) And ivs_Versao_Layout <> "" ) Then
						lvs_Registro = lvs_Registro + MidA(String(ls_Codigo_Barras) + Space(13), 1, 13)
					Else
						lvs_Registro = lvs_Registro + MidA(String(ls_Codigo_Barras) + Space(20), 1, 20)
					End If
					
				End If
				
				If ll_Layout >= 124 Then
					lvs_Registro += RightA("000000000" + ls_Preco_Uni, 9) + RightA( "00000" + ls_Desconto, 5) + RightA("00000" + ls_Repasse_ICMS, 5)
				End If

				lvi_Write = FileWrite(lvi_Arquivo, lvs_Registro)
					
				If lvi_Write = -1 Then		
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro detalhe do arquivo '" + as_Arquivo + "'.", StopSign!)
					lvb_Sucesso = False
					Exit
				End If				
			Next

			If lvb_Sucesso Then
				// Registro Finalizador
				lvs_Registro = "3" + String(lvl_Total_Produtos + 2, "00000") + &
						 				   String(lvl_Total_Produtos, "00000") + &
											String(lvl_Qtde_Total, "0000000")
			
				lvi_Write = FileWrite(lvi_Arquivo, lvs_Registro)
				
				If lvi_Write = -1 Then		
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro finalizador do arquivo '" + as_Arquivo + "'.", StopSign!)
					lvb_Sucesso = False
				End If				
			End If
		End If				
		
		FileClose(lvi_Arquivo)
		
		If Not lvb_Sucesso Then
			If Not FileDelete(as_Arquivo) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Chave + "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + as_Arquivo + "'.", StopSign!)
			End If
		End If
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_grava_arquivo_pedido (long al_filial, long al_pedido, string as_distribuidora, ref string as_arquivo, string as_tipo_pedido);Boolean lvb_Sucesso = False

String lvs_Pedido,&
	   lvs_Versao_Layout, &
		lvs_Situacao

Long lvl_Total

dc_uo_ds_Base lvds_1

// 902727-17 - N$$HEX1$$e300$$ENDHEX$$o gerar arquivo PED para os pedidos rejeitados.
If as_Distribuidora <> This.ivs_Distribuidora_Estoque Then
	SELECT 	id_situacao
	INTO		:lvs_Situacao
	FROM		pedido_distribuidora
	WHERE	cd_filial 						= :al_Filial
		and 	nr_pedido_distribuidora	= :al_Pedido
		and	cd_distribuidora 			= :as_Distribuidora
	USING	SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao buscar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido da distribuidora para gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo PED. ~r~r" + SqlCa.SqlErrText, StopSign!)
		Return False
	End If	
	
	If lvs_Situacao = 'J' Then Return True
End If

lvds_1 = Create dc_uo_ds_Base
If as_Distribuidora <> This.ivs_Distribuidora_Estoque Then
	If Not lvds_1.of_ChangeDataObject("dw_ge071_produto_pedido_distribuidora") Then Return	False
	
	lvl_Total = lvds_1.Retrieve(al_Filial, al_Pedido, as_Distribuidora)
Else
	If Not lvds_1.of_ChangeDataObject("dw_ge071_produto_pedido_estoque") Then Return	False
	
	lvl_Total = lvds_1.Retrieve(al_Filial, al_Pedido)
End If

If lvl_Total > 0 Then
	If as_Distribuidora = This.ivs_Distribuidora_Estoque Then
		lvb_Sucesso = This.of_LayOut_Pedido_Estoque(al_Filial, al_Pedido, as_Distribuidora, lvds_1, as_Arquivo)
	Else		
				
		// Verifica a vers$$HEX1$$e300$$ENDHEX$$o do layout do pedido eletr$$HEX1$$f400$$ENDHEX$$nico
		If Not of_Versao_Layout(as_Distribuidora, Ref ivs_Versao_Layout) Then Return False
		
		//If lvs_Versao_Layout = "1.07" or lvs_Versao_Layout = "1.08"  Then
			
			// A StaCruz ainda esta no layout antigo
//			If as_Distribuidora = '053400519' or &
//			   as_Distribuidora = '053405354' or &
//			   as_Distribuidora = '053405356' or &
//			   as_Distribuidora = '053405404' or &
//			   as_Distribuidora = '053405539' or &
//			   as_Distribuidora = '053405860' Then
//				lvb_Sucesso = This.of_LayOut_Pedido_Padrao(al_Filial, al_Pedido, as_Distribuidora, lvds_1, as_Arquivo)
//			Else
				// N$$HEX1$$fa00$$ENDHEX$$mero do pedido aumentou de 5 para 8 posi$$HEX2$$e700f500$$ENDHEX$$es
				lvb_Sucesso = This.of_LayOut_Pedido_Padrao_New(al_Filial, al_Pedido, as_Distribuidora, lvds_1, as_Arquivo, as_tipo_pedido)
//			End If
			
		//Else
		//	lvb_Sucesso = This.of_LayOut_Pedido_Padrao(al_Filial, al_Pedido, as_Distribuidora, lvds_1, as_Arquivo)
		//End If
	End If
Else
	lvs_Pedido = "(" + String(al_Filial, "0000")   + "-" + &
                   String(al_Pedido, "000000") + "-" + &
				       as_Distribuidora + ")"
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos do pedido " + lvs_Pedido + " n$$HEX1$$e300$$ENDHEX$$o localizados.", StopSign!)
End If

Destroy(lvds_1)
Return lvb_Sucesso
end function

public subroutine of_decimal (decimal adc_valor, ref string as_valor);Long ll_Pos

String ls_Valor

ls_Valor = String(adc_valor)

ll_Pos = PosA(ls_Valor, ",", 1)

If ll_Pos > 0 Then
	as_Valor	= MidA(ls_Valor, 1, ll_Pos -1) + MidA(ls_Valor, ll_Pos + 1)
Else
	as_Valor = ""
End If
end subroutine

public function boolean of_codigo_barras_produto (string as_distribuidora, long al_produto, long al_filial, ref string as_codigo_barras, ref string ads_preco_uni, ref string ads_desconto, ref string ads_repasse_icms);Decimal ldc_Preco_Uni
Decimal ldc_Desconto
Decimal ldc_Repasse_ICMS

Select de_codigo_barras_arquivo_preco, IsNull(vl_preco_novo, vl_preco_atual) as vl_preco_utilizado, IsNull(pc_desconto_novo, pc_desconto_atual) as pc_desconto_utilizado, pc_repasse_icms
		//round( round( IsNull(vl_preco_novo, vl_preco_atual) * ((100 -  IsNull(pc_desconto_novo, pc_desconto_atual) ) / 100), 2) * (pc_repasse_icms / 100), 2)
	Into :as_Codigo_Barras, :ldc_Preco_Uni, :ldc_Desconto, :ldc_Repasse_ICMS
From distribuidora_produto
Where cd_distribuidora = :as_Distribuidora
	And cd_produto = :al_Produto
	And cd_unidade_federacao = (Select cd_uf From vw_filial Where cd_filial = :al_Filial)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		This.of_Decimal(ldc_Preco_Uni, Ref ads_Preco_Uni)
		This.of_Decimal(ldc_Desconto, Ref ads_Desconto)
		This.of_Decimal(ldc_Repasse_ICMS, Ref ads_Repasse_ICMS)
				
	Case 100
		as_Codigo_Barras = ""
		ads_Preco_Uni = ""
		ads_Desconto = ""
		ads_Repasse_ICMS = ""
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar o c$$HEX1$$f300$$ENDHEX$$digo de barras do produto '" + String(al_Produto) + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_codigo_barras_produto. " + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean of_insere_log_exportacao (long al_filial, long al_pedido, string as_erro);String		ls_Chave
String		ls_Ambiente_SAP
Long		ll_nr_atualizacao

Date		ldh_Exportacao
Datetime ldh_inclusao

If gvo_aplicacao.ivs_datasource = 'central' then
	ls_Ambiente_SAP =  'PRD'	
Else
	ls_Ambiente_SAP =  'S8Q'
End if

Declare sp_log Procedure for sp_log_exportacao_sap_prox_seq
 @proximo_sequencial_retorno  = :ll_nr_atualizacao OUTPUT,
 @mensagem_retorno = :as_erro OUTPUT
 USING SQLCA;

 Execute sp_log;

If sqlca.sqlcode = -1 then 
	Sqlca.of_MsgDbError('Erro ao executar a procedure "SP_LOG_EXPORTACAO_SAP_PROX_SEQ" (of_grava_log_exportacao): ')
	return false
end if

Fetch sp_log Into :ll_nr_atualizacao, :as_erro;

Close sp_log;

ldh_Exportacao = Date(gf_GetServerDate())
ldh_inclusao = gf_GetServerDate()

ls_Chave	= string(al_Filial) + '@#!' + string(al_Pedido)

Insert into log_exportacao_sap(nr_atualizacao,
		cd_empresa,
		cd_chave,
		id_tipo_nf,
		id_tipo_log,
		cd_filial,
		id_situacao_docto,
		id_status_integracao,
		dh_exportacao,
		cd_ambiente_sap,
		cd_tipo_documento,
		dh_inclusao
		)
	values(:ll_nr_atualizacao,
		1000,
		:ls_Chave,
		'ZPL',
		98,
		:al_Filial,
		'C',
		'C',
		:ldh_Exportacao,
		:ls_Ambiente_SAP,
		'ZPL',
		:ldh_inclusao
		)
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
	
		Case -1
			as_Erro	= "Erro ao inserir o pedido "+String(al_Pedido)+" na tabela log_exportacao_sap "+ SqlCa.SqlErrText
			SqlCa.of_Rollback()
			Return False
			
	End Choose

	Update pedido_distribuidora
	Set	dh_exportacao_sap = getdate(),
			id_exportacao_sap = 'C'
	Where cd_filial						= :al_Filial
	And	nr_pedido_distribuidora	= :al_Pedido
	Using SqlCa;	

	Choose Case SqlCa.SqlCode
	
		Case -1
			as_Erro	= "Erro ao atualizar dh_exportacao_sap e id_exportacao_sap na tabela pedido_distribuidora "+STRING(al_Filial)+"/"+STRING(al_Pedido)+"/"+STRING(ldh_exportacao)+"/"+ SqlCa.SqlErrText
			SqlCa.of_Rollback()
			Return False
	
		Case 0 
			SQLCA.of_Commit()
			
	End Choose	
			
Return true
end function

on uo_distribuicao_pedido.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_distribuicao_pedido.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Localiza_Distribuidora_Estoque()
end event

