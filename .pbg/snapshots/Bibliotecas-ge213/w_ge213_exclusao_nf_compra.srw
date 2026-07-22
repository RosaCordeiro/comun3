HA$PBExportHeader$w_ge213_exclusao_nf_compra.srw
forward
global type w_ge213_exclusao_nf_compra from dc_w_selecao_lista_relatorio
end type
type cb_excluir from commandbutton within w_ge213_exclusao_nf_compra
end type
type cb_1 from commandbutton within w_ge213_exclusao_nf_compra
end type
type cb_planilha from commandbutton within w_ge213_exclusao_nf_compra
end type
end forward

global type w_ge213_exclusao_nf_compra from dc_w_selecao_lista_relatorio
string accessiblename = "Exclus$$HEX1$$e300$$ENDHEX$$o de Notas Fiscais de Compra (GE213)"
integer width = 3483
integer height = 1964
string title = "GE213 - Exclus$$HEX1$$e300$$ENDHEX$$o de Notas Fiscais de Compra"
cb_excluir cb_excluir
cb_1 cb_1
cb_planilha cb_planilha
end type
global w_ge213_exclusao_nf_compra w_ge213_exclusao_nf_compra

type variables
uo_fornecedor ivo_fornecedor

dc_uo_odbc ivo_odbc

dc_uo_transacao ivo_db_filial

dc_uo_transacao OracleMult

uo_usuario ivo_Usuario

uo_filial ivo_filial

Boolean ivb_Desenvolvimento
Boolean ib_Filial_Fechada = False
Boolean ivb_Check
Boolean lb_iniciado_operacao_sap = False

Date idt_data_inicio_operacao_wms

DateTime idh_Data_Caixa

Long il_Filial
Long il_Nr_NF
Long il_Linha_Planilha

String ivs_Operador
String ivs_Nf_Compra_Pendente
String ivs_Nome_Usuario
String is_Tipo = "N" //N - Exclus$$HEX1$$e300$$ENDHEX$$o Normal e P - Exclus$$HEX1$$e300$$ENDHEX$$o por Planilha
String is_Fornecedor
String is_Especie
String is_Serie
String is_Nome_Fantasia
String is_Chave_Log
String is_Filial
String is_Nr_NF
String is_Desconhecimento 

end variables

forward prototypes
public function boolean wf_exclui_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie)
public function boolean wf_atualiza_log_exportacao (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie)
public function boolean wf_atualiza_resumo_movimento (long al_filial, datetime adh_data_caixa, decimal adc_valor)
public function boolean wf_notas_selecionadas ()
public function boolean wf_exclui_titulo_pagar (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie)
public function boolean wf_exclui_controle_consignacao (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie)
public function boolean wf_exclui_item_nf_compra_lote (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natoperacao, long al_produto)
public function boolean wf_atualiza_situacao_pedido (long al_filial, long al_pedido)
public function boolean wf_conecta_banco_filial (long al_filial)
public function boolean wf_verfica_sngpc_filial (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie)
public function boolean wf_verifica_devolucao_compra_filial (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, ref string ps_nota_excluida)
public function boolean wf_exclui_log_exportacao_mult (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie)
public function boolean wf_exclui_movimento_estoque (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_faturada, long al_qtde_recebida)
public function boolean wf_atualiza_resumo_produto (long al_filial, long al_produto, datetime adh_data_caixa, long al_qtde_faturada, long al_qtde_recebida)
public function boolean wf_atualiza_saldo_produto (long al_filial, long al_produto, datetime adh_data, long al_qtde_faturada, long al_qtde_recebida)
public function boolean wf_verifica_exportacao_mult (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, ref boolean ab_nf_exportada)
public function boolean wf_envia_email (string as_assunto, string as_mensagem)
public function boolean wf_exclui_movimentos_estoque (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa)
public function boolean wf_exclui_movimento_wms_antigo (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_faturada, long al_qtde_recebida)
public function boolean wf_exclui_movimento (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_tipo)
public function boolean wf_exclui_movimento_wms (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa)
public function boolean wf_localiza_parametro_wms ()
public function boolean wf_processa_exclusao (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, datetime adh_data_caixa, decimal adc_total_nf, long al_pedido_distribuidora)
protected function boolean wf_exclui_item_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natope, long al_produto)
public function boolean wf_atualiza_resumo_pedido (date adt_pedido, string as_uf, string as_distribuidora, string as_fornecedor, decimal adc_valor, long al_qtde)
public function boolean wf_permite_exclusao_mult (string as_chave, ref boolean ab_exclusao, ref boolean ab_pagto)
public function boolean wf_atualiza_resumo_compra (datetime adt_movimentacao, long al_filial, long al_produto, long al_qtde, string as_fornecedor, decimal adc_total_produtos, decimal adc_descontos, decimal adc_preco_unitario, decimal adc_pc_desconto, decimal adc_icms_st, decimal adc_ipi, decimal adc_outras_despesas)
public function boolean wf_conecta_db_mult_old ()
public function boolean wf_le_dados_planilha (string as_arquivo)
public function long wf_valida_exclusao ()
public subroutine wf_insere_mensagem (string as_permite_excluir, string as_mensagem)
public function boolean wf_permissao_exclusao (string as_procedimento)
public function boolean wf_verifica_psico (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, boolean ab_desenvolvimento, string as_filial_java)
public function boolean wf_valida_nf_compra_filial_java (integer al_filial, string as_fornecedor, long al_nr_nf, string as_especie, string as_serie, ref string as_filial_java)
public function boolean wf_inclui_log_exclusao (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, datetime adt_movimento, decimal adc_valor, long al_pedido, string as_chave_acesso, string as_motivo, boolean ab_exportado_mult, string as_desconhecimento)
end prototypes

public function boolean wf_exclui_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie);String ls_Erro

If ivs_Nf_Compra_Pendente = "N" Then
	
	Delete From nf_compra
	Where cd_filial     = :al_Filial
	  and cd_fornecedor = :as_Fornecedor
	  and nr_nf         = :al_NF
	  and de_especie    = :as_Especie
	  and de_serie      = :as_Serie
	Using SqlCa;

Else

	Delete From nf_compra_pendente
	Where cd_filial     = :al_Filial
	  and cd_fornecedor = :as_Fornecedor
	  and nr_nf         = :al_NF
	  and de_especie    = :as_Especie
	  and de_serie      = :as_Serie
	Using SqlCa;
	
End If

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Exclus$$HEX1$$e300$$ENDHEX$$o da Nota Fiscal de Compra.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_atualiza_log_exportacao (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie);String lvs_Tabela
String ls_Erro

If ivs_Nf_Compra_Pendente = "N" Then
	lvs_Tabela = "NF_COMPRA"
Else
	lvs_Tabela = "NF_COMPRA_PENDENTE"	
End If 

Insert Into log_exportacao_filial (cd_filial_atualizacao,
           								  nm_tabela,
											  dh_atualizacao,
											  de_chave,
											  id_atualizacao)
Select :al_Filial,
      	:lvs_Tabela,
		 getdate(),
		 convert(char(4), :al_Filial) + '@#!' + :as_Fornecedor + '@#!' + convert(char(8), :al_NF) + '@#!' + :as_Especie + '@#!' + :as_Serie,
        'E'
From parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do LOG de Exporta$$HEX2$$e700e300$$ENDHEX$$o.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_atualiza_resumo_movimento (long al_filial, datetime adh_data_caixa, decimal adc_valor);String ls_Erro

If ivs_Nf_Compra_Pendente = "S" Then Return True

Update resumo_movimento_estoque
Set vl_compra = vl_compra - :adc_Valor
Where cd_filial = :al_Filial
  and dh_resumo = :adh_Data_Caixa
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Resumo de Movimenta$$HEX2$$e700e300$$ENDHEX$$o da filial.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_notas_selecionadas ();Long lvl_Linha
	  
lvl_Linha = dw_2.Find("id_excluir = 'S'", 1, dw_2.RowCount())

If lvl_Linha > 0 Then
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma nota fiscal para exclus$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
	Return False
End If
end function

public function boolean wf_exclui_titulo_pagar (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie);String ls_Erro

If ivs_Nf_Compra_Pendente = "N" Then
	
	Delete From titulo_pagar
	Where cd_filial     		= :al_Filial
	  and cd_fornecedor 	= :as_Fornecedor
	  and nr_nf         		= :al_NF
	  and de_especie    	= :as_Especie
	  and de_serie      		= :as_Serie
	Using SqlCa;
	
Else
	
	Delete From titulo_pagar_pendente
	Where cd_filial     		= :al_Filial
	  and cd_fornecedor 	= :as_Fornecedor
	  and nr_nf         		= :al_NF
	  and de_especie    	= :as_Especie
	  and de_serie      		= :as_Serie
	Using SqlCa;
	
End If	

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Exclus$$HEX1$$e300$$ENDHEX$$o dos T$$HEX1$$ed00$$ENDHEX$$tulos a Pagar.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_exclui_controle_consignacao (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie);Long lvl_Total

String ls_Erro

//Tabela n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais utilizada

//If ivs_Nf_Compra_Pendente = "S" Then Return True
//
//Select count(*) Into :lvl_Total 
//From controle_consignacao
//Where cd_filial     = :al_Filial
//  and cd_fornecedor = :as_Fornecedor
//  and nr_nf         = :al_NF
//  and de_especie    = :as_Especie
//  and de_serie      = :as_Serie
//  and qt_paga > 0
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//	Case 0
//		If IsNull(lvl_Total) Then lvl_Total = 0
//		
//		If lvl_Total > 0 Then
//			If is_Tipo = "N" Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Exclus$$HEX1$$e300$$ENDHEX$$o da nota fiscal n$$HEX1$$e300$$ENDHEX$$o permitida.~rExistem pagamentos efetuados referentes a produtos consignados.", StopSign!)
//			Else
//				wf_Insere_Mensagem("N", "Exclus$$HEX1$$e300$$ENDHEX$$o da nota fiscal n$$HEX1$$e300$$ENDHEX$$o permitida. Existem pagamentos efetuados referentes a produtos consignados.")
//			End If
//			
//			Return False
//		End If
//	Case 100
//	Case -1
//		ls_Erro = SqlCa.SqlErrText
//		SqlCa.of_Rollback();
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Verifica$$HEX2$$e700e300$$ENDHEX$$o do Controle de Consigna$$HEX2$$e700e300$$ENDHEX$$o.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
//		Return False
//End Choose
//
//Delete From controle_consignacao
//Where cd_filial     = :al_Filial
//  and cd_fornecedor = :as_Fornecedor
//  and nr_nf         = :al_NF
//  and de_especie    = :as_Especie
//  and de_serie      = :as_Serie
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	ls_Erro = SqlCa.SqlErrText
//	SqlCa.of_Rollback();
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Exclus$$HEX1$$e300$$ENDHEX$$o do Controle de Consigna$$HEX2$$e700e300$$ENDHEX$$o.~r" + is_Chave_Log + "~r." + ls_Erro, StopSign!)
//	Return False
//Else
//	Return True
//End If

Return True
end function

public function boolean wf_exclui_item_nf_compra_lote (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natoperacao, long al_produto);String ls_Erro

If ivs_Nf_Compra_Pendente = "N" Then
	
	Delete From produto_lote_nf_entrada
	Where cd_filial            					= :al_Filial
	  	and cd_fornecedor        			= :as_Fornecedor
	  	and nr_nf                					= :al_NF
	  	and de_especie           			= :as_Especie
	  	and de_serie             				= :as_Serie
	  	and cd_natureza_operacao 		= :al_NatOperacao
	  	and cd_produto           			= :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Exclus$$HEX1$$e300$$ENDHEX$$o do Lote da PRODUTO_LOTE_NF_ENTRADA.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
		Return False
	End If	
	
	Delete From item_nf_compra_lote
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_natureza_operacao = :al_NatOperacao
	  and cd_produto           = :al_Produto
	Using SqlCa;
	
Else	

	Delete From nf_compra_pendente_prd_lote
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_natureza_operacao = :al_NatOperacao
	  and cd_produto           = :al_Produto
	Using SqlCa;
	
End If	


If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Exclus$$HEX1$$e300$$ENDHEX$$o do Lote da Nota Fiscal de Compra.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_atualiza_situacao_pedido (long al_filial, long al_pedido);Long lvl_Achou

String ls_Erro

Select count(*) 
Into :lvl_Achou
From nf_compra 
Where cd_filial 			  			=:al_Filial
  and nr_pedido_distribuidora 	=:al_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as notas do pedido, 'nf_compra'.~r" + is_Chave_Log + "~r." + ls_Erro, StopSign!)
	Return False
Else
	
	If lvl_Achou = 0 Then
  		
		  //Procura na tabela nf_compra_pendente
		  
		  Select count(*) 
			Into :lvl_Achou
			From nf_compra_pendente 
			Where cd_filial 			  			=:al_Filial
			  and nr_pedido					=:al_Pedido
			Using SqlCa;
					  
		  	If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localiza$$HEX2$$e700e300$$ENDHEX$$o das notas do pedido, 'nf_compra_pendente'.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
				Return False
			Else
				If lvl_Achou = 0 Then
					
					// S$$HEX1$$f300$$ENDHEX$$ vai cancelar o pedido se n$$HEX1$$e300$$ENDHEX$$o tiver mais nenhuma nota fiscal de compra/compra_pendente	  
					
					Update pedido_distribuidora
					Set id_situacao = 'X'
					Where cd_filial 			  			=:al_Filial
					  and nr_pedido_distribuidora 	=:al_Pedido
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						ls_Erro = SqlCa.SqlErrText
						SqlCa.of_Rollback();
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido para 'X'.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
						Return False
					End If					
				End If
			End If
		 
	End If
End If

Return True
end function

public function boolean wf_conecta_banco_filial (long al_filial);String lvs_Odbc_Destino
		 
// Se estiver conectado desconecta
If ivo_DB_Filial.of_isConnected() Then ivo_DB_Filial.of_Disconnect()

If Not ivo_Odbc.of_localiza_parametro_odbc( al_Filial ) Then Return False

ivo_Odbc.of_grava_regedit_odbc( al_Filial )

ivo_DB_Filial.ivs_DataBase = "ANYWHERE"

lvs_Odbc_Destino = ivo_Odbc.of_Localiza(al_Filial)

If Not ivo_DB_Filial.of_Connect(lvs_Odbc_Destino, "RO") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao conectar ao banco de dados da Filial '" + String(al_Filial) + "'.")
	Return False
End If

Return True
end function

public function boolean wf_verfica_sngpc_filial (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie);DateTime lvdt_Movimentacao_Caixa,&
			 lvdt_Atualizacao_Estoque,&
			 lvdt_Ultimo_Movimento_Enviado,&
			 lvdt_Parametro

String lvs_Estoque_Automatico			 

String ls_Compra_Devolvida

//Se a filial est$$HEX1$$e100$$ENDHEX$$ fechada n$$HEX1$$e300$$ENDHEX$$o realiza as consultas abaixo, uma vez que n$$HEX1$$e300$$ENDHEX$$o tem como conectar o banco de dados da loja
If ib_Filial_Fechada Then Return True

Open(w_aguarde_2)

// Desenvolvimento
//return True

w_Aguarde_2.y = 1604

w_aguarde_2.Title = "Verificando SNPC da nota fiscal '" + String(al_Nota) + "' na filial '"  + String(al_Filial) + "' ..."
	
Select dh_movimentacao_caixa, id_estoque_automatico, dh_atualizacao_estoque
Into :lvdt_Movimentacao_Caixa, :lvs_Estoque_Automatico, :lvdt_Atualizacao_Estoque
From nf_compra
Where 	cd_filial			= :al_Filial
	and 	nr_nf				= :al_Nota
	and 	cd_fornecedor 	= :as_Fornecedor
	and 	de_especie		= :as_especie
	and 	de_serie			= :as_serie
	Using ivo_db_filial;
	
Choose Case ivo_db_filial.SqlCode
	Case 0
		
		If Isnull(lvs_Estoque_Automatico) Then lvs_Estoque_Automatico = 'S' 
		
		// Se n$$HEX1$$e300$$ENDHEX$$o for estoque automaticado
		If lvs_Estoque_Automatico = 'N' Then
			// Significa que o estoque ainda n$$HEX1$$e300$$ENDHEX$$o foi atualizado e neste caso a nota pode ser excluida
			If Isnull(lvdt_Atualizacao_Estoque) Then
				//ivo_DB_Filial.of_Disconnect()
				Close(w_aguarde_2)
				Return True
			Else
				// Se estoque j$$HEX1$$e100$$ENDHEX$$ foi atualizado
				lvdt_Parametro = lvdt_Atualizacao_Estoque
			End If
		Else
			// Estoque autom$$HEX1$$e100$$ENDHEX$$tico (entrada manual)
			lvdt_Parametro = 	lvdt_Movimentacao_Caixa
		End If
					
		Select max(dt_fim_movimento) 
		Into :lvdt_Ultimo_Movimento_Enviado
		From sngpc_historico_arquivo
		Using ivo_db_filial;
		
		Choose Case ivo_db_filial.SqlCode
			Case 0
				
				If Date(lvdt_Parametro) > Date(lvdt_Ultimo_Movimento_Enviado) or Isnull(lvdt_Ultimo_Movimento_Enviado) Then
					//ivo_DB_Filial.of_Disconnect()
					Close(w_aguarde_2)
					Return True
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A nota fiscal '" + String(al_Nota) + "' da filial '" + String(al_Filial) + "' possui PSICOTR$$HEX1$$d300$$ENDHEX$$PICOS e j$$HEX1$$e100$$ENDHEX$$ foi enviada ao SNGPC.", StopSign!)
					//ivo_DB_Filial.of_Disconnect()
					Close(w_aguarde_2)
					Return false
				End If
				
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localiza$$HEX2$$e700e300$$ENDHEX$$o hist$$HEX1$$f300$$ENDHEX$$rico do envio do arquivo do SNGPC da filial '" + String(al_Filial) + "'", StopSign!)
			Case -1
				ivo_db_filial.of_MsgDbError("Hist$$HEX1$$f300$$ENDHEX$$rico do envio do arquivo do SNGPC da filial '" + String(al_Filial) + "'")
		End Choose
		
	Case 100
		//Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A nota fiscal '" + String(al_Nota) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizada.", StopSign!)
		//ivo_DB_Filial.of_Disconnect()
		Close(w_aguarde_2)
		Return True
	Case -1
		ivo_db_filial.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da nota fiscal de compra '" + String(al_Nota) + "' da filial '" + String(al_Filial) + "'")
End Choose
	
Close(w_aguarde_2)

Return False
end function

public function boolean wf_verifica_devolucao_compra_filial (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, ref string ps_nota_excluida);boolean lb_Sucesso = True

Long ll_Retorno = 0

ps_nota_excluida = "N"

Select Count(*)
Into	:ll_Retorno
From nf_devolucao_compra
Where 	cd_fornecedor 			= :as_Fornecedor
	and 	nr_nf_compra			= :al_Nota
	and 	de_especie_compra 	= :as_especie
	and 	de_serie_compra		= :as_serie
	Using ivo_db_filial;
	
Choose Case ivo_db_filial.SqlCode
	Case 0
		
		If ll_Retorno > 0 Then
			ps_nota_excluida = "S"					
		End If			
		
	Case -1
		ivo_db_filial.of_MsgDbError("Filial: " + String(al_Filial) + " - Localiza$$HEX2$$e700e300$$ENDHEX$$o da nota fiscal de compra " + String(al_Nota) + " como refer$$HEX1$$ea00$$ENDHEX$$ncia na NF Dev. Compra.")
		lb_Sucesso = False
End Choose
	
Return lb_Sucesso
end function

public function boolean wf_exclui_log_exportacao_mult (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie);String ls_Erro

Delete from log_exportacao_mult
Where id_tipo_nf 	= 'CO'
and cd_filial 			= :al_filial
And cd_fornecedor 	= :as_fornecedor
And nr_nf 				= :al_nota
And de_especie 		= :as_especie
And de_serie 			= :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Exclus$$HEX1$$e300$$ENDHEX$$o do log exporta$$HEX2$$e700e300$$ENDHEX$$o Mult.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_exclui_movimento_estoque (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_faturada, long al_qtde_recebida);Boolean lvb_Sucesso = False

String lvs_Chave, &
		ls_Erro

Long lvl_Movimento, &
     	lvl_Qtde
//	  	lvl_Qtde_Divergente
		  
//ib_existe_movimento_filial_1 = False
	  
If ivs_Nf_Compra_Pendente = "S" Then	Return True  
	  
lvs_Chave = "(" + String(al_Filial) + "-" + as_Fornecedor + "-" + String(al_NF) + "-" + &
            as_Especie + "-" + as_Serie + "-" + String(al_Produto) + ")"

Select nr_movimento_estoque,
       qt_movimento
Into :lvl_Movimento,
     :lvl_Qtde
From movimento_estoque
Where cd_filial_movimento = :al_Filial
  and cd_produto          = :al_Produto
  and dh_movimento        = :adh_Data_Caixa
  and nr_nf               = :al_NF
  and de_especie          = :as_Especie
  and de_serie            = :as_Serie
  and cd_fornecedor       = :as_Fornecedor
  and cd_tipo_movimento in (3, 16)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Qtde = al_faturada Then
			Delete From movimento_estoque
			Where cd_filial_movimento  = :al_Filial
			  and cd_produto           = :al_Produto
			  and dh_movimento         = :adh_Data_Caixa
			  and nr_movimento_estoque = :lvl_Movimento
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Exclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Estoque.~r" + lvs_Chave + ".~r" + ls_Erro, StopSign!)
			Else
				lvb_Sucesso = True
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Movimento de estoque $$HEX1$$e900$$ENDHEX$$ diferente da nota fiscal. " + lvs_Chave, StopSign!)
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Movimento de estoque n$$HEX1$$e300$$ENDHEX$$o localizado. " + lvs_Chave, StopSign!)
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Movimento de Estoque.~r" + lvs_Chave + ".~r" + ls_Erro)
End Choose

//lvl_Qtde_Divergente = al_faturada - al_qtde_recebida
//
////Exclui a sa$$HEX1$$ed00$$ENDHEX$$da da filial 534
//If lvb_Sucesso and al_Filial = 534 Then
//	
//	lvb_Sucesso = False
//	
//	Select	nr_movimento_estoque,
//			 	qt_movimento
//	Into	:lvl_Movimento,
//		  	:lvl_Qtde
//	From movimento_estoque
//	Where cd_filial_movimento	= 534
//	  	and cd_produto          	= :al_Produto
//	  	and dh_movimento       	= :adh_Data_Caixa
//	  	and nr_nf               		= :al_NF
//	  	and de_especie          	= :as_Especie
//	  	and de_serie            		= :as_Serie
//	  	and cd_fornecedor       	= :as_Fornecedor
//	  	and cd_tipo_movimento in (17)
//	Using SqlCa;
//	
//	Choose Case SqlCa.SqlCode
//		Case 0
//			If lvl_Qtde = lvl_Qtde_Divergente Then
//				Delete From movimento_estoque
//				Where cd_filial_movimento  	= 534
//				  and cd_produto           		= :al_Produto
//				  and dh_movimento         	= :adh_Data_Caixa
//				  and nr_movimento_estoque	= :lvl_Movimento
//				Using SqlCa;
//				
//				If SqlCa.SqlCode = -1 Then
//					SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Estoque da filial 534 " + lvs_Chave)
//				Else
//					lvb_Sucesso = True
//				End If
//			Else
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Movimento de estoque $$HEX1$$e900$$ENDHEX$$ diferente da nota fiscal (Qtde Faturada - Qtde Recebida) Filial: 534. " + lvs_Chave, StopSign!)
//			End If
//		Case 100
//			//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Movimento de estoque n$$HEX1$$e300$$ENDHEX$$o localizado. " + lvs_Chave, StopSign!)
//			Return True
//		Case -1
//			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Movimento de Estoque " + lvs_Chave)
//	End Choose
//End If
//
////Exclui a entrada da filial 1
//If lvb_Sucesso and al_Filial = 534 Then
//	
//	lvb_Sucesso = False
//	
//	Select	nr_movimento_estoque,
//			 	qt_movimento
//	Into	:lvl_Movimento,
//		  	:lvl_Qtde
//	From movimento_estoque
//	Where cd_filial_movimento	= 1
//	  	and cd_produto          	= :al_Produto
//	  	and dh_movimento       	= :adh_Data_Caixa
//	  	and nr_nf               		= :al_NF
//	  	and de_especie          	= :as_Especie
//	  	and de_serie            		= :as_Serie
//	  	and cd_fornecedor       	= :as_Fornecedor
//	  	and cd_tipo_movimento in (18)
//	Using SqlCa;
//	
//	Choose Case SqlCa.SqlCode
//		Case 0
//			If lvl_Qtde = lvl_Qtde_Divergente Then
//				Delete From movimento_estoque
//				Where cd_filial_movimento  	= 1
//				  and cd_produto           		= :al_Produto
//				  and dh_movimento         	= :adh_Data_Caixa
//				  and nr_movimento_estoque	= :lvl_Movimento
//				Using SqlCa;
//				
//				If SqlCa.SqlCode = -1 Then
//					SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Estoque da filial 1 " + lvs_Chave)
//				Else
//					ib_existe_movimento_filial_1	= True
//					lvb_Sucesso 							= True
//				End If
//			Else
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Movimento de estoque $$HEX1$$e900$$ENDHEX$$ diferente da nota fiscal (Qtde Faturada - Qtde Recebida) Filial: 1. " + lvs_Chave, StopSign!)
//			End If
//		Case 100
//			//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Movimento de estoque n$$HEX1$$e300$$ENDHEX$$o localizado. " + lvs_Chave, StopSign!)
//			Return True
//		Case -1
//			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Movimento de Estoque " + lvs_Chave)
//	End Choose
//End If

Return lvb_Sucesso
end function

public function boolean wf_atualiza_resumo_produto (long al_filial, long al_produto, datetime adh_data_caixa, long al_qtde_faturada, long al_qtde_recebida);Boolean lb_Sucesso = False

Long ll_Qtde_Divergente, ll_Qtde_Faturada

If ivs_Nf_Compra_Pendente = "S" Then Return True

// Se for a filial 534 s$$HEX1$$f300$$ENDHEX$$ soma a quantidade recebida
//If al_Filial = 534 and ib_existe_movimento_filial_1 Then 
//	ll_Qtde_Faturada = al_qtde_recebida
//Else
//	ll_Qtde_Faturada = al_qtde_faturada
//End If

ll_Qtde_Faturada = al_qtde_faturada

Update resumo_movto_estq_prd
Set qt_compra = qt_compra - :ll_Qtde_Faturada
Where cd_filial  		= :al_Filial
  and cd_produto 	= :al_Produto
  and dh_resumo  	= :adh_Data_Caixa
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Resumo do Produto")
	Return False
Else
	lb_Sucesso = True
End If

//If lb_Sucesso and al_Filial = 534 and ib_existe_movimento_filial_1 Then
//	
//	lb_Sucesso = False
//	
//	ll_Qtde_Divergente = al_Qtde_Faturada - al_Qtde_Recebida
//	
//	Update resumo_movto_estq_prd
//	Set qt_compra = qt_compra - :ll_Qtde_Divergente
//	Where cd_filial  		= 1
//	  and cd_produto 	= :al_Produto
//	  and dh_resumo  	= :adh_Data_Caixa
//	Using SqlCa;
//	
//	If SqlCa.SqlCode = -1 Then
//		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Resumo do Produto")
//		Return False
//	Else
//		lb_Sucesso = True
//	End If
//End If

Return lb_Sucesso


end function

public function boolean wf_atualiza_saldo_produto (long al_filial, long al_produto, datetime adh_data, long al_qtde_faturada, long al_qtde_recebida);Boolean lb_Sucesso = False

Date lvdt_Saldo

String lvs_Chave

Long ll_Qtde_Divergente, ll_Qtde_Faturada

If ivs_Nf_Compra_Pendente = "S" Then Return True

lvdt_Saldo = Date("01/" + String(adh_Data, "mm/yyyy"))

lvs_Chave = "(" + String(al_Filial) + "-" + String(al_Produto) + "-" + String(lvdt_Saldo, "dd/mm/yyyy") + ")"

// Se for a filial 534 s$$HEX1$$f300$$ENDHEX$$ diminui a quantidade recebida
//If al_Filial = 534 and ib_existe_movimento_filial_1 Then 
//	ll_Qtde_Faturada = al_qtde_recebida
//Else
//	ll_Qtde_Faturada = al_qtde_faturada
//End If

ll_Qtde_Faturada = al_qtde_faturada

Update saldo_produto
Set qt_saldo_final = qt_saldo_final - :ll_Qtde_Faturada
Where cd_filial    = :al_Filial
  and cd_produto   = :al_Produto
  and dh_saldo    >= :lvdt_Saldo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo " + lvs_Chave)
Else
	lb_Sucesso = True
End If

// Altera o saldo da filial 1
//If lb_Sucesso and al_Filial = 534 and ib_existe_movimento_filial_1 Then
//	
//	lb_Sucesso = False
//	
//	ll_Qtde_Divergente = al_qtde_faturada - al_qtde_recebida
//	
//	Update saldo_produto
//	Set qt_saldo_final = qt_saldo_final - :ll_Qtde_Divergente
//	Where cd_filial    		= 1
//	  	and cd_produto   	= :al_Produto
//	  	and dh_saldo    		>= :lvdt_Saldo
//	Using SqlCa;
//
//	If SqlCa.SqlCode = -1 Then
//		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo " + lvs_Chave)
//	Else
//		lb_Sucesso = True
//	End If
//	
//End If

Return lb_Sucesso 
end function

public function boolean wf_verifica_exportacao_mult (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, ref boolean ab_nf_exportada);Long ll_Contador

String ls_Erro

ab_nf_exportada = False

Select count(*)
	Into :ll_Contador
from log_exportacao_mult
Where id_tipo_nf 	= 'CO'
and cd_filial 			= :al_filial
And cd_fornecedor 	= :as_fornecedor
And nr_nf 				= :al_nota
And de_especie 		= :as_especie
And de_serie 			= :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Exclus$$HEX1$$e300$$ENDHEX$$o do log exporta$$HEX2$$e700e300$$ENDHEX$$o Mult.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
	Return False
End If

If ll_Contador > 0 Then
	ab_nf_exportada = True
End If

Return True

end function

public function boolean wf_envia_email (string as_assunto, string as_mensagem);uo_smtp lo_smtp
lo_smtp = Create uo_smtp

String lvs_Msg

String ls_To[] = {"fiscal@clamed.com.br", "contasapagar@clamed.com.br"}

//String ls_To[] = {"wagner.frasseto@clamed.com.br"}

// N$$HEX1$$e300$$ENDHEX$$o ir$$HEX1$$e100$$ENDHEX$$ mais gravar na base MySQL que se tiver com True da erro nos usuarios onde n$$HEX1$$e300$$ENDHEX$$o tem o odbc do mysql...
lo_smtp.ib_grava_log_db = False

lvs_Msg = "<font face='verdana' size='1'>'Este $$HEX1$$e900$$ENDHEX$$ um email autom$$HEX1$$e100$$ENDHEX$$tico. Favor n$$HEX1$$e300$$ENDHEX$$o responder esta mensagem.'</font><br /><br />" + &
	"<font color='black' face='verdana' size='2'>" + as_Mensagem +"<p><p>"

lo_smtp.of_envia_email("CLAMED SISTEMAS", &
                                   "sistemas@clamed.com.br", &
                                   as_Assunto, &
                                   lvs_Msg, ls_To)    
											                                                                                   
Destroy lo_smtp

Return True
end function

public function boolean wf_exclui_movimentos_estoque (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa);If ivs_Nf_Compra_Pendente = "S" or al_Filial <> 534 Then	Return True  

If wf_exclui_movimento(534, as_Fornecedor, al_NF, as_Especie,&
													 as_Serie, al_Produto, adh_data_caixa, 17) Then
	If wf_exclui_movimento(	1, as_Fornecedor, al_NF, as_Especie,&
															as_Serie, al_Produto, adh_data_caixa, 18) Then
															
			If wf_exclui_movimento_wms(534, as_Fornecedor, al_NF, as_Especie,&
															as_Serie, al_Produto, adh_data_caixa) Then												
				Return True
			End If
	End If
End If

Return False


end function

public function boolean wf_exclui_movimento_wms_antigo (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_faturada, long al_qtde_recebida);Boolean lvb_Sucesso = False

String lvs_Chave, ls_Endereco_Localizacao

Long lvl_Movimento, &
     	lvl_Qtde,&
	  	lvl_Qtde_Divergente,&
		ll_Sequencial
	  
If ivs_Nf_Compra_Pendente = "S" or al_Filial <> 534 Then	Return True  

//If Not ib_existe_movimento_filial_1 Then Return True
	  
lvs_Chave = "(" + String(al_Filial) + "-" + as_Fornecedor + "-" + String(al_NF) + "-" + &
            as_Especie + "-" + as_Serie + "-" + String(al_Produto) + ")"

Select	nr_movimento,
       		qt_movimento,
			cd_endereco_localizacao,
			nr_sequencial_localizacao
Into	:lvl_Movimento,
     	:lvl_Qtde,
	  	:ls_Endereco_Localizacao,
		:ll_Sequencial  
From wms_movimento_estoque
Where cd_produto          		= :al_Produto
  and dh_movimento       		= :adh_Data_Caixa
  and nr_nf               			= :al_NF
  and de_especie          			= :as_Especie
  and de_serie           			= :as_Serie
  and cd_fornecedor       		= :as_Fornecedor
 // and cd_tipo_movimento in (5)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		lvl_Qtde_Divergente = al_faturada - al_qtde_recebida
		
		If lvl_Qtde = lvl_Qtde_Divergente Then
			
			Delete From wms_movimento_estoque
			Where	cd_produto      	= :al_Produto
			  	and 	dh_movimento 	= :adh_Data_Caixa
			  	and 	nr_movimento 	= :lvl_Movimento
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Estoque no WMS " + lvs_Chave)
			Else
				
				Update wms_localizacao
				Set qt_saldo = qt_saldo - :lvl_Qtde
				Where cd_endereco = :ls_Endereco_Localizacao
					and nr_sequencial = :ll_Sequencial
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do saldo no WMS '" + ls_Endereco_Localizacao + "' " + lvs_Chave)
				Else
					// Exclui a localiza$$HEX2$$e700e300$$ENDHEX$$o caso o saldo seja zerado
					Delete wms_localizacao
					Where cd_endereco = :ls_Endereco_Localizacao
						and nr_sequencial = :ll_Sequencial
						and qt_saldo 			<= 0
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o ao atualizar o saldo no WMS '" + ls_Endereco_Localizacao + "' " + lvs_Chave)
					Else
						lvb_Sucesso = True
					End If
				End IF
				
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Movimento de estoque $$HEX1$$e900$$ENDHEX$$ diferente da nota fiscal. " + lvs_Chave, StopSign!)
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Movimento de estoque n$$HEX1$$e300$$ENDHEX$$o localizado WMS. " + lvs_Chave, StopSign!)
		// Desenvolvimento
		//lvb_Sucesso = True
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Movimento de Estoque do WMS" + lvs_Chave)
End Choose

Return lvb_Sucesso
end function

public function boolean wf_exclui_movimento (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_tipo);Boolean lb_Sucesso = True

Long ll_Linhas, ll_Linha, ll_Movimento, ll_Qtde, ll_Qtde_Sinal, ll_Sequencial

Date ldt_Saldo

String ls_Chave, ls_Chave_Movto, ls_Endereco_Localizacao

If ivs_Nf_Compra_Pendente = "S" or al_Filial <> 534 Then	Return True  

ldt_Saldo = Date("01/" + String(adh_data_caixa, "mm/yyyy"))

ls_Chave_Movto = "(" + String(al_Filial) + "-" + String(al_Produto) + "-" + String(ldt_Saldo, "dd/mm/yyyy") + ")"

// Chamar duas vezes a mesma fun$$HEX2$$e700e300$$ENDHEX$$o
// 1 - Filial 534
// 2 - Filial 1

If al_tipo <> 17 and al_tipo <> 18 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de movimento n$$HEX1$$e300$$ENDHEX$$o previsto '" + String(al_tipo) +  "'.", StopSign!)
	Return False
End If

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("dw_ge213_lista_movimento") Then
	Destroy(lds)
	Return False
End If

ll_Linhas = lds.Retrieve(al_Filial, al_produto, adh_data_caixa, as_fornecedor, al_nf, as_especie, as_serie, al_tipo)

ls_Chave = "(" + String(al_Filial) + "-" + as_Fornecedor + "-" + String(al_NF) + "-" + &
            			as_Especie + "-" + as_Serie +  "-" + String(al_Produto) + ")"

If ll_Linhas > 0 Then
	
	For ll_Linha = 1 To ll_Linhas
		
		ll_Movimento = lds.Object.nr_movimento_estoque	[ll_Linha]
		ll_Qtde			= lds.Object.qt_movimento				[ll_Linha]
				
		Delete From movimento_estoque
		Where	nr_movimento_estoque	= :ll_Movimento
			and	cd_filial_movimento  		= :al_Filial
		  	and 	cd_produto           		= :al_Produto
		  	and 	dh_movimento         		= :adh_Data_Caixa
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Estoque da filial " + ls_Chave)
			lb_Sucesso = False
			Exit
		End If
		
		// Movimento de Sa$$HEX1$$ed00$$ENDHEX$$da
		If al_tipo = 17 Then
			ll_Qtde_Sinal =  ll_Qtde * (-1)
		Else
			ll_Qtde_Sinal =  ll_Qtde
		End If
			
		Update saldo_produto
		Set qt_saldo_final = qt_saldo_final - :ll_Qtde_Sinal
		Where cd_filial    		= :al_filial
			and cd_produto   	= :al_Produto
			and dh_saldo    		>= :ldt_Saldo
		Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo " + ls_Chave_Movto)
			lb_Sucesso = False
			Exit
		End If
				
	Next
	
ElseIf ll_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe movimento de estoque (FALTA OU AVARIA).  " + ls_Chave)
	//lb_Sucesso = False
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os movimentos de estoque.")
	lb_Sucesso = False
End If

Destroy(lds)

Return lb_Sucesso
end function

public function boolean wf_exclui_movimento_wms (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa);Boolean lb_Sucesso = True

Long ll_Linhas, ll_Linha, ll_Movimento, ll_Qtde, ll_Sequencial, ll_Achou

Date ldt_Saldo

DateTime ldt_Validade, ldt_Validade_Select

String ls_Chave, ls_Endereco_Localizacao, ls_Lote, ls_Lote_Select

If ivs_Nf_Compra_Pendente = "S" or al_Filial <> 534 Then	Return True  

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("dw_ge213_lista_movimento_wms") Then
	Destroy(lds)
	Return False
End If

ll_Linhas = lds.Retrieve(al_Filial, as_fornecedor, al_nf, as_especie, as_serie, al_Produto)

ls_Chave = "(" + String(al_Filial) + "-" + as_Fornecedor + "-" + String(al_NF) + "-" + &
            			as_Especie + "-" + as_Serie +  "-" + String(al_Produto) + ")"

If ll_Linhas > 0 Then
	
	For ll_Linha = 1 To ll_Linhas
		
		ll_Movimento 				= lds.Object.nr_movimento				[ll_Linha]
		ll_Qtde							= lds.Object.qt_movimento				[ll_Linha]
		ls_Lote							= lds.Object.nr_lote							[ll_Linha]	
		ldt_Validade 					= lds.Object.dh_validade					[ll_Linha]	
		ls_Endereco_Localizacao	= lds.Object.cd_endereco_localizacao	[ll_Linha]		
		ll_Sequencial					= lds.Object.nr_sequencial_localizacao	[ll_Linha]		

		Delete From wms_movimento_estoque
		Where	cd_produto      	= :al_Produto
			and 	dh_movimento 	= :adh_Data_Caixa
			and 	nr_movimento 	= :ll_Movimento
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Estoque no WMS " + ls_Chave)
			lb_Sucesso = False
			Exit
		Else
			
			Select nr_lote, dh_validade 
			Into :ls_Lote_Select, :ldt_Validade_Select
			From wms_localizacao
			Where cd_endereco = :ls_Endereco_Localizacao
				and nr_sequencial = :ll_Sequencial
			Using SqlCa;
			
			Choose Case Sqlca.SqlCode
				Case 0
					
					If ls_Lote_Select = ls_Lote and ldt_Validade_Select = ldt_Validade Then
						Update wms_localizacao
						Set qt_saldo = qt_saldo - :ll_Qtde
						Where cd_endereco = :ls_Endereco_Localizacao
							and nr_sequencial = :ll_Sequencial
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do saldo no WMS '" + ls_Endereco_Localizacao + "' " + ls_Chave)
							lb_Sucesso = False
							Exit
						Else
							// Exclui a localiza$$HEX2$$e700e300$$ENDHEX$$o caso o saldo seja zerado
							//Delete wms_localizacao
							
							Select Count(*)
								Into :ll_Achou
							From wms_localizacao
							Where cd_endereco = :ls_Endereco_Localizacao
								and nr_sequencial = :ll_Sequencial
								and qt_saldo 		<= 0
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
//								SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o ao atualizar o saldo no WMS '" + ls_Endereco_Localizacao + "' " + ls_Chave)
								SqlCa.of_MsgdbError("Consultar saldo zerado ou negativo no WMS '" + ls_Endereco_Localizacao + "' " + ls_Chave)
							Else
								lb_Sucesso = True
							End If
						End IF
					Else
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote e validade est$$HEX1$$e300$$ENDHEX$$o diferentes no WMS.  " + ls_Chave, StopSign!)
						lb_Sucesso = False
						Exit
					End If
					
				Case 100
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe movimento de estoque no WMS.  " + ls_Chave)
					lb_Sucesso = False
					Exit
				Case -1
					Sqlca.of_MsgDbError("Erro ao localizar a movimenta$$HEX2$$e700e300$$ENDHEX$$o no WMS.")
					lb_Sucesso = False
					Exit
			End Choose
					
		End If
				
	Next
			
ElseIf ll_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe movimento de estoque no WMS.  " + ls_Chave)
	lb_Sucesso = False
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os movimentos de estoque.", StopSign!)
	lb_Sucesso = False
End If

Destroy(lds)

Return lb_Sucesso
end function

public function boolean wf_localiza_parametro_wms ();String ls_Parametro

SetNull(idt_data_inicio_operacao_wms)

Select vl_parametro
Into :ls_Parametro
From wms_parametro
Where cd_parametro = 'DH_INICIO_OPERACAO_WMS'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If Not IsDate(ls_Parametro) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data para o in$$HEX1$$ed00$$ENDHEX$$cio da opera$$HEX2$$e700e300$$ENDHEX$$o do WMS $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
			Return False
		End If
		
		idt_data_inicio_operacao_wms = Date(ls_Parametro)		
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar o parametro do WMS.")
		Return False
End Choose

Return True

end function

public function boolean wf_processa_exclusao (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, datetime adh_data_caixa, decimal adc_total_nf, long al_pedido_distribuidora);Boolean lvb_Sucesso = False

String ls_Fornecedor, ls_Distribuidora, ls_Uf

Date ldt_Emissao_Ped

DateTime ldt_Movimentacao

Decimal ldc_Valor_Item, ldc_Total_Produtos,	ldc_Desconto ,ldc_Preco_Unit,ldc_PC_Desconto,ldc_ICMS_ST,ldc_IPI,	ldc_Outras_Desp, ldc_Fat_Conv, ldc_Custo_Ped

Decimal ldc_Valor_Resumo

Long lvl_Total, &
     lvl_Contador, &
	  lvl_NatOpe, &
	  lvl_Produto, &
	  lvl_Qtde,&
	  lvl_Qtde_Recebida,&
	  ll_Qtde_Item

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If ivs_Nf_Compra_Pendente = "N" Then
	If Not lvds_1.of_ChangeDataObject("dw_ge213_item_nf_compra") Then Return False
Else	
	If Not lvds_1.of_ChangeDataObject("dw_ge213_nf_compra_pendente_produto") Then Return False
End If	

Open(w_Aguarde)
w_Aguarde.Title = "Excluindo Notas Fiscais..."

lvl_Total = lvds_1.Retrieve(al_Filial, as_Fornecedor, al_NF, as_Especie, as_Serie)

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_NatOpe  			= lvds_1.Object.Cd_Natureza_Operacao	[lvl_Contador]
		lvl_Produto 			= lvds_1.Object.Cd_Produto          		[lvl_Contador]
		lvl_Qtde    			= lvds_1.Object.Qt_Faturada         		[lvl_Contador]
		lvl_Qtde_Recebida = lvds_1.Object.qt_recebida         		[lvl_Contador]
		
		ls_Distribuidora 	= lvds_1.Object.cd_Fornecedor         		[lvl_Contador]
		ls_Fornecedor		= lvds_1.Object.cd_Fornecedor_usual	[lvl_Contador]
		ldt_Emissao_Ped	=	Date(lvds_1.Object.dh_emissao[lvl_Contador])
		ldc_Valor_Item		= lvds_1.Object.vl_faturado_item			[lvl_Contador]
		ll_Qtde_Item		= lvds_1.Object.qt_faturada_item			[lvl_Contador]
		ls_Uf					= lvds_1.Object.cd_uf							[lvl_Contador]
		ldc_Fat_Conv		= lvds_1.Object.vl_fator_conversao		[lvl_Contador]
		ldc_Custo_Ped		= lvds_1.Object.vl_custo_pedido			[lvl_Contador]
				
		If ivs_Nf_Compra_Pendente = 'N' Then
			ldt_Movimentacao		= lvds_1.Object.dh_movimentacao_caixa	[lvl_Contador]
			ldc_Total_Produtos 	= lvds_1.Object.vl_total_produtos				[lvl_Contador]
			ldc_Desconto			= lvds_1.Object.vl_desconto						[lvl_Contador]
			ldc_Preco_Unit			= lvds_1.Object.vl_preco_unitario				[lvl_Contador]
			ldc_PC_Desconto		= lvds_1.Object.pc_desconto					[lvl_Contador]
			ldc_ICMS_ST			= lvds_1.Object.vl_icms_st						[lvl_Contador]
			ldc_IPI					= lvds_1.Object.vl_ipi								[lvl_Contador]
			ldc_Outras_Desp		= lvds_1.Object.vl_outras_despesas			[lvl_Contador]
						
			If Not wf_atualiza_resumo_compra(	ldt_Movimentacao, al_filial, lvl_produto, lvl_qtde,& 
															as_fornecedor, ldc_Total_Produtos, ldc_Desconto,&
															ldc_Preco_Unit, ldc_PC_Desconto, ldc_ICMS_ST, ldc_IPI, ldc_Outras_Desp) Then
				lvb_Sucesso = False
				Exit
			End If
		End If
		
		ldc_Valor_Resumo	=  round(ll_Qtde_Item * ldc_Custo_Ped, 2)
				
		If Not wf_atualiza_resumo_pedido(	ldt_Emissao_Ped, &
														ls_Uf, ls_Distribuidora, &
														ls_Fornecedor, &
														ldc_Valor_Resumo, &
														ll_Qtde_Item) Then
			lvb_Sucesso = False
			Exit
		End If
		
		lvb_Sucesso = False
		
		If wf_Exclui_Item_NF_Compra_Lote(al_Filial, &
										 as_Fornecedor, &
										 al_NF, &
										 as_Especie, &
										 as_Serie, &
										 lvl_NatOpe, &
										 lvl_Produto) Then
		
			If wf_Exclui_Item_NF_Compra(al_Filial, &
												 as_Fornecedor, &
												 al_NF, &
												 as_Especie, &
												 as_Serie, &
												 lvl_NatOpe, &
												 lvl_Produto) Then 
												 
				If wf_Exclui_Movimento_Estoque(al_Filial, &
														 as_Fornecedor, &
														 al_NF, &
														 as_Especie, &
														 as_Serie, &
														 lvl_Produto, &
														 adh_Data_Caixa, &
														 lvl_Qtde,&
														 lvl_Qtde_Recebida) Then 
														 
//					If wf_Exclui_Movimentos_Estoque(	al_Filial, &
//																 		as_Fornecedor, &
//																	 	al_NF, &
//																		as_Especie, &
//																		as_Serie, &
//																		lvl_Produto, &
//																		adh_Data_Caixa) Then
	
//						If wf_Atualiza_Resumo_Produto(al_Filial, &
//																		lvl_Produto, &
//																		adh_Data_Caixa, &
//																		lvl_Qtde,&
//																		lvl_Qtde_Recebida) Then
																											  
//							If wf_Atualiza_Saldo_Produto(al_Filial, &
//																  lvl_Produto, &
//																  adh_Data_Caixa, &
//																  lvl_Qtde,&
//																  lvl_Qtde_Recebida) Then
								lvb_Sucesso = True								  
//							End If // wf_Atualiza_Saldo_Produto
//						End If // wf_Atualiza_Resumo_Produto
					//End If // wf_Exclui_Movimento_WMS
				End If // wf_Exclui_Movimento_Estoque
			End If // wf_Exclui_Item_NF_Compra
		End If //wf_Exclui_Item_NF_Compra_Lote
				
		If Not lvb_Sucesso Then Exit
	
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	If lvb_Sucesso Then
		lvb_Sucesso = False

		If wf_Exclui_Titulo_Pagar(al_Filial, &
									     as_Fornecedor, &
									     al_NF, &
									     as_Especie, &
									     as_Serie) Then
										  
			If wf_Exclui_Controle_Consignacao(al_Filial, &
													    as_Fornecedor, &
													    al_NF, &
													    as_Especie, &
													    as_Serie) Then
		
				If wf_Exclui_NF_Compra(al_Filial, &
											  as_Fornecedor, &
											  al_NF, &
											  as_Especie, &
											  as_Serie) Then
											  
					If wf_Atualiza_Resumo_Movimento(al_Filial, &
															  adh_Data_Caixa, &
															  adc_Total_NF) Then
															  
						If wf_Atualiza_LOG_Exportacao(al_Filial, &
																as_Fornecedor, &
																al_NF, &
																as_Especie, &
																as_Serie) Then
																
							lvb_Sucesso = True
						End If		
					End If
				End If		
			End If
		End If
	End If
	
	If lvb_Sucesso Then
		If Not IsNull(al_Pedido_Distribuidora) Then
			// Atualiza a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido para 'X' => Cancelado
			If Not wf_Atualiza_Situacao_Pedido(al_Filial, al_Pedido_Distribuidora) Then
				lvb_Sucesso = False
			End If
		End If
	End If
	
//	If lvb_Sucesso Then
//		SqlCa.of_Commit()
//	Else
//		SqlCa.of_RollBack()
//	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem produtos na nota fiscal.", StopSign!)
End If

Close(w_Aguarde)
Return lvb_Sucesso
end function

protected function boolean wf_exclui_item_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natope, long al_produto);Boolean lvb_Sucesso  = True 

String ls_Erro

If ivs_Nf_Compra_Pendente = "N" Then

	Delete From item_nf_compra_prd
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_produto           = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "' da Nota Fiscal de Compra'.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
		lvb_Sucesso = False
	End If	
	
	Delete From item_nf_compra
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_natureza_operacao = :al_NatOpe
	  and cd_produto           = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "' da Nota Fiscal de Compra'.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
		lvb_Sucesso = False
	End If 	
	
Else	
	
	Delete From nf_compra_pendente_prd_item
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_produto           = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "' da Nota Fiscal de Compra'.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
		lvb_Sucesso = False
	End If 
			
	Delete From nf_compra_pendente_produto
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_natureza_operacao = :al_NatOpe
	  and cd_produto           = :al_Produto
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "' da Nota Fiscal de Compra'.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
		lvb_Sucesso = False
	End If 
End If

Return lvb_Sucesso
end function

public function boolean wf_atualiza_resumo_pedido (date adt_pedido, string as_uf, string as_distribuidora, string as_fornecedor, decimal adc_valor, long al_qtde);String ls_Achou, ls_MSG

If IsNull(adt_pedido) Then Return True

adc_valor	= adc_valor * (-1)
al_qtde		= al_qtde * (-1)

Select cd_uf
Into :ls_achou
From resumo_pedido_distribuidora
Where dh_pedido 			=:adt_pedido
  	and cd_uf				=:as_uf
	and cd_distribuidora	=:as_distribuidora
	and cd_fornecedor		=:as_fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Update resumo_pedido_distribuidora
		set vl_faturado = vl_faturado + :adc_valor, qt_faturada = qt_faturada  + :al_qtde
		where dh_pedido 			= :adt_pedido 
			and cd_uf				= :as_uf 
			and cd_distribuidora 	= :as_distribuidora 
			and cd_fornecedor 	= :as_fornecedor
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = SQLCA.SQLErrText
			SqlCa.of_RollBack();
			MessageBox("Erro", "Erro ao atualizar o resumo do pedido.~r" + is_Chave_Log + "'.~r" + ls_MSG, StopSign!)
			Return false
		End If
		
	Case 100
		
		INSERT INTO resumo_pedido_distribuidora ( dh_pedido, cd_uf, cd_distribuidora, cd_fornecedor,vl_pedido,qt_pedida,vl_faturado, qt_faturada )  
		values (:adt_pedido, :as_uf, :as_distribuidora, :as_fornecedor, 0.00, 0, :adc_valor, :al_qtde)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = SQLCA.SQLErrText
			SqlCa.of_RollBack();
			MessageBox("Erro", "Erro ao incluir o resumo do pedido.~r" + is_Chave_Log + ".~r" + ls_MSG, StopSign!)
			Return False
		End If
		
	Case -1
		ls_MSG = SQLCA.SQLErrText
		SqlCa.of_RollBack();
		MessageBox("Erro", "Erro ao localizar o resumo do pedido.~r" + is_Chave_Log + "'.~r" + ls_MSG, StopSign!)
		Return False
		
End Choose

Return True
end function

public function boolean wf_permite_exclusao_mult (string as_chave, ref boolean ab_exclusao, ref boolean ab_pagto);String ls_Id_Exclusao, ls_Id_Pagto

// Desenvolvimento
//ab_exclusao = True
//ab_pagto		= True
//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de descomentar a fun$$HEX2$$e700e300$$ENDHEX$$o.")
//Return True

select id_permite, id_pagto
Into :ls_Id_Exclusao, :ls_Id_Pagto
from vwpermiteexclusao 
where de_chave_acesso = :as_chave
Using ORACLEMULT;

Choose Case ORACLEMULT.SqlCode
	Case 0
		ab_exclusao = False
		ab_pagto		= False
		
		If ls_Id_Exclusao 	= 'S' 	Then ab_exclusao = True
		If ls_Id_Pagto		= 'S'	Then	ab_pagto = True
					
	Case 100
		// A nota n$$HEX1$$e300$$ENDHEX$$o existe na base da multi
		ab_exclusao = True
		ab_pagto		= True
	Case -1
		ORACLEMULT.of_msgdbError("Erro no select no BD Mult. " +  ORACLEMULT.SqlErrText)
		Return False
End Choose

return True
end function

public function boolean wf_atualiza_resumo_compra (datetime adt_movimentacao, long al_filial, long al_produto, long al_qtde, string as_fornecedor, decimal adc_total_produtos, decimal adc_descontos, decimal adc_preco_unitario, decimal adc_pc_desconto, decimal adc_icms_st, decimal adc_ipi, decimal adc_outras_despesas);Date ldt_Data_Convertida

String ls_Achou, ls_MSG

Decimal ldc_Preco_Liquido, ldc_valor_desc_prd, ldc_preco_liquid_res, ldc_impostos

decimal ldc_preco_liq_calc, ldc_impostos_calc 

Long ll_Qtde_Faturada

//	ldt_Movimentacao		= lvds_1.Object.dh_movimentacao_caixa	[lvl_Contador]
//			ldc_Total_Produtos 	= lvds_1.Object.vl_total_produtos				[lvl_Contador]
//			ldc_Desconto			= lvds_1.Object.vl_descontos					[lvl_Contador]
//			ldc_Preco_Unit			= lvds_1.Object.vl_preco_unitario				[lvl_Contador]
//			ldc_PC_Desconto		= lvds_1.Object.pc_desconto					[lvl_Contador]
//			ldc_ICMS_ST			= lvds_1.Object.vl_icms_st						[lvl_Contador]
//			ldc_IPI					= lvds_1.Object.vl_ipi								[lvl_Contador]
//			ldc_Outras_Desp		= lvds_1.Object.vl_outras_despesas			[lvl_Contador]

ldt_Data_Convertida = Date(String(adt_movimentacao, '01/mm/yyyy'))

ldc_Preco_Liquido =  round(adc_preco_unitario * ((100 - adc_pc_desconto) / 100), 2)
ldc_Valor_Desc_PRD = round(ldc_Preco_Liquido * (adc_descontos       / adc_total_produtos), 2)
ldc_Preco_Liquid_Res	= ldc_Preco_Liquido - ldc_Valor_Desc_PRD
ldc_Impostos 			= round(adc_icms_st + adc_outras_despesas + adc_ipi, 2)

ldc_preco_liq_calc	= ldc_Preco_Liquid_Res * (-1)
ldc_impostos_calc	= ldc_Impostos * (-1)
ll_Qtde_Faturada	= al_qtde * (-1)

ldc_preco_liq_calc = round(ldc_preco_liq_calc * al_qtde, 2)
ldc_impostos_calc	= round(ldc_impostos_calc * al_qtde, 2)

Select cd_fornecedor
Into :ls_achou
From resumo_produto_compra
Where dh_resumo 			=:ldt_Data_Convertida
  	and cd_filial					=:al_filial
	and cd_produto				=:al_produto
	and cd_fornecedor			=:as_fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		update resumo_produto_compra
		set qt_faturada 		= qt_faturada + :ll_Qtde_Faturada,
			vl_preco_liquido    = vl_preco_liquido + :ldc_preco_liq_calc,   
			vl_impostos			= vl_impostos + :ldc_impostos_calc 
		where dh_resumo  		= :ldt_Data_Convertida
		  and cd_filial  		= :al_filial
		  and cd_produto		= :al_produto
		  and cd_fornecedor 	= :as_fornecedor
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = SQLCA.SQLErrText
			SqlCa.of_RollBack();
			MessageBox("Erro", "Erro ao atualizar o resumo do pedido.~r" + is_Chave_Log + ".~r" + ls_MSG, StopSign!)
			Return false
		End If
		
	Case 100
				
		insert into resumo_produto_compra (dh_resumo,cd_filial,cd_produto,cd_fornecedor,qt_faturada,vl_preco_liquido,vl_impostos)
		values (:ldt_Data_Convertida,:al_Filial,:al_Produto,:as_fornecedor,:ll_Qtde_Faturada,:ldc_preco_liq_calc,:ldc_impostos_calc  )
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = SQLCA.SQLErrText
			SqlCa.of_RollBack();
			MessageBox("Erro", "Erro ao incluir o resumo do pedido.~r" + is_Chave_Log + "'.~r" + ls_MSG, StopSign!)
			Return False
		End If
		
	Case -1
		ls_MSG = SQLCA.SQLErrText
		SqlCa.of_RollBack();
		MessageBox("Erro", "Erro ao localizar o resumo de compra." + is_Chave_Log + ".~r" + ls_MSG, StopSign!)
		Return False
		
End Choose

Return True

end function

public function boolean wf_conecta_db_mult_old ();OracleMult.ivs_database = 'ORACLEMULT'

// Se estiver conectado desconecta
If OracleMult.of_isConnected() Then OracleMult.of_Disconnect()

If Not OracleMult.of_Connect("OracleMult", "RO") Then
	// Grava mensagem de erro no log e n$$HEX1$$e300$$ENDHEX$$o continua o processo
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao conectar ao banco de dados do OracleMult." )
	Return False
End If

Return True
end function

public function boolean wf_le_dados_planilha (string as_arquivo);Any la_Dado

Boolean lb_Achou = False

Long ll_Linha
Long ll_Linhas
Long ll_Filial
Long ll_Nr_NF

dw_1.AcceptText()

Try
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo a planilha..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			il_Linha_Planilha = 0
			is_Filial = ""
			is_Nr_NF = ""

			For ll_Linha = 1 To ll_Linhas

				// Filial 
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				If IsNull(la_Dado) Or Not IsNumber(String(la_Dado)) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial inv$$HEX1$$e100$$ENDHEX$$lida na linha: " + String(ll_Linha), StopSign!)
					Return False
				End If				
				ll_Filial = Long(la_Dado)
				
				// Nota 
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
				If IsNull(la_Dado) Or Not IsNumber(String(la_Dado)) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "NF inv$$HEX1$$e100$$ENDHEX$$lida na linha : " + String(ll_Linha), StopSign!)
					Return False
				End If
				ll_Nr_NF = Long(la_Dado)
				
				is_Filial += String(ll_Filial) + ","
				is_Nr_NF += String(ll_Nr_NF) + ","				
				
				il_Linha_Planilha++
			Next
			
			//Remove a $$HEX1$$fa00$$ENDHEX$$ltima v$$HEX1$$ed00$$ENDHEX$$rgula
			is_Filial = MidA(is_Filial, 1, LenA(is_Filial) -1)
			is_Nr_NF = MidA(is_Nr_NF, 1, LenA(is_Nr_NF) -1)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha est$$HEX1$$e100$$ENDHEX$$ em branco.")
			Return False
		End If
	End If
	
Finally
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
End Try
end function

public function long wf_valida_exclusao ();Boolean lvb_Sucesso = False, lvb_Desenvolvimento = False
Boolean lb_Exportada_Mult
Boolean lb_Exclusao, lb_Pagto	 
Boolean lb_operacao_sap_loja_iniciada = False  



Long 	lvl_Max, &
     	lvl_Contador, &
	 	lvl_Pedido_Distribuidora
	  
String	lvs_Excluir, &
		lvs_Chave_Acesso,&
		ls_Compra_Devolvida,&
		lvs_desconhecimento
				 
Date ldh_Movimento

Decimal lvdc_Total_NF

String ls_Exclusao_liberada
String ls_msg_email
String ls_Motivo
String ls_Nulo
String ls_Grupo_Psico
String ls_Filial_Java
String ls_Log 

SetPointer(HourGlass!)

SetNull(ls_Nulo)

lvl_Max = dw_2.RowCount()

If lvl_Max > 0 Then
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	If wf_Notas_Selecionadas() Then
		
		ls_Motivo = dw_1.Object.de_motivo[1]
		lvs_desconhecimento =   dw_1.Object.id_desconhecimento[1]  
		
		If IsNull( ls_Motivo ) Or Trim( ls_Motivo ) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o motivo da exclus$$HEX1$$e300$$ENDHEX$$o.")
			dw_1.Event ue_Pos(1,"de_motivo")
			Return -1
		End If
		
		If Len( ls_Motivo ) < 5 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe pelo menos 5 caract$$HEX1$$e900$$ENDHEX$$res.")
			dw_1.Event ue_Pos(1,"de_motivo")
			Return -1
		End If
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o das notas fiscais selecionadas ?", Question!, YesNo!, 2) = 1 Then
			
			ldh_Movimento = gf_Primeiro_Dia_Mes(Date(gvo_Parametro.of_dh_movimentacao()))
			
			For lvl_Contador = 1 To lvl_Max
				il_Filial      		 				= dw_2.Object.Cd_Filial              				[lvl_Contador]
				is_Nome_Fantasia				= dw_2.Object.Nm_Fantasia					[lvl_Contador]
				is_Fornecedor  	 				= dw_2.Object.Cd_Fornecedor          		[lvl_Contador]
				il_Nr_NF          		 			= dw_2.Object.Nr_NF                  				[lvl_Contador]
				is_Especie     		 			= dw_2.Object.De_Especie             			[lvl_Contador]
				is_Serie       		 			= dw_2.Object.De_Serie               			[lvl_Contador]
				idh_Data_Caixa 				= dw_2.Object.Dh_Movimentacao_Caixa		[lvl_Contador]
				lvdc_Total_NF   	    			= dw_2.Object.Vl_Total_NF            			[lvl_Contador]
				lvs_Excluir     		 			= dw_2.Object.Id_Excluir             				[lvl_Contador]
				lvl_Pedido_Distribuidora 		= dw_2.Object.nr_pedido_distribuidora		[lvl_Contador]
				lvs_Chave_Acesso		 		= dw_2.Object.de_chave_acesso				[lvl_Contador]	
				ivs_Nf_Compra_Pendente	= dw_2.Object.id_compra_pendente			[lvl_Contador]
				ls_Grupo_Psico					= dw_2.Object.Cd_Grupo_Psico				[lvl_Contador]
			
				If lvs_Excluir = "S" Then	
					
					Try
					
						If il_Filial = 534 and Date(idh_Data_Caixa) >= idt_data_inicio_operacao_wms and Not ivb_Desenvolvimento Then
							Continue
						End If
						
						is_Chave_Log = "Filial: " + String(il_Filial) + ", NF: " + String(il_Nr_NF) + ", Esp$$HEX1$$e900$$ENDHEX$$cie: " + is_Especie + ", S$$HEX1$$e900$$ENDHEX$$rie: " + is_Serie
						ls_msg_email = ""
						
						//Valida Filial no SAP
						If Not gf_verifica_inicio_operacao_sap_loja(il_Filial,&
																		 'DH_INICIO_OPERACAO_SAP',&
																		 ref lb_operacao_sap_loja_iniciada,&
																		 ref ls_Log) Then					
							Continue 							
						End If 						
						
						// N$$HEX1$$e300$$ENDHEX$$o deve ir adiante para Loja No SAP
						If lb_operacao_sap_loja_iniciada Then 
							wf_Insere_Mensagem("N", "NF N$$HEX1$$c300$$ENDHEX$$O poder$$HEX1$$e100$$ENDHEX$$ ser exclu$$HEX1$$ed00$$ENDHEX$$da. Motivo: Filial j$$HEX1$$e100$$ENDHEX$$ esta no SAP!")
							Continue 																		 
						End If 							
						
						//N$$HEX1$$e300$$ENDHEX$$o permite excluir nf_compra em filiais java
						If Not wf_Valida_Nf_Compra_Filial_Java(il_Filial, is_Fornecedor, il_Nr_NF, is_Especie, is_Serie, Ref ls_Filial_Java) Then
							Continue
						End If
						
						//Para garantir que filial Java exclua somente notas pendentes
						If ls_Filial_Java = "S" Then
							ivs_Nf_Compra_Pendente = "S"
						End If
						
						//Quando for filial java n$$HEX1$$e300$$ENDHEX$$o permite excluir nf_compra, apenas nf_compra_pendente
						If ls_Filial_Java <> "S" Then
							// Se a nota for do m$$HEX1$$ea00$$ENDHEX$$s anterior somente a equipe inform$$HEX1$$e100$$ENDHEX$$tica e coordenador de opera$$HEX2$$e700f500$$ENDHEX$$es do Compras poder$$HEX1$$e300$$ENDHEX$$o excluir
							If ivs_Nf_Compra_Pendente = 'N' and Date(idh_Data_Caixa) < ldh_Movimento Then
								If wf_permissao_exclusao("GE213_PERMITE_EXCLUIR_NF_COMPRA")	Then
									If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Voc$$HEX1$$ea00$$ENDHEX$$ esta prestes a excluir uma nota do m$$HEX1$$ea00$$ENDHEX$$s anterior, antes de continuar, certifique-se de que os fechamentos CONTABIL (MULT) e o INVENT$$HEX1$$c100$$ENDHEX$$RIO (SYBASE) ainda n$$HEX1$$e300$$ENDHEX$$o foram realizados. ~r~rDeseja continuar com a exclus$$HEX1$$e300$$ENDHEX$$o ?",Question!, YesNo!, 2) = 2 Then
										Continue
									End If	
								Else
									Continue
								End If
							End If
							
							//Se teve estoque atualizado e se tiver psico, somente o T.I. poder$$HEX1$$e100$$ENDHEX$$ excluir a NF
							If ivs_Nf_Compra_Pendente = "N" Then
								If Not IsNull(ls_Grupo_Psico) And ls_Grupo_Psico <> "" Then
									If Not wf_permissao_exclusao("GE213_EXCLUSAO_PSICO") Then Continue
								End If
							End If
							
							If ivs_Nf_Compra_Pendente = 'N' Then
								If is_Tipo = "N" Then
									If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A filial j$$HEX1$$e100$$ENDHEX$$ atualizou o estoque da NF no sistema. ~rDeseja excluir mesmo assim?', Question!, YesNo!, 2) = 2 Then Return -1
								End If
							End If
							
							lvb_Sucesso 			= False
							lb_Exportada_Mult 	= False
							
							If gvo_Aplicacao.ivs_DataSource = 'central' Then
							
								If Not wf_Verifica_Exportacao_mult(il_Filial, is_Fornecedor, il_Nr_NF, is_Especie, is_Serie, Ref lb_Exportada_Mult) Then Exit
								
								//O sistema EX limpa os logs dos ultimos 30 dias
								If ivs_Nf_Compra_Pendente = 'N' And Date(idh_Data_Caixa) < RelativeDate( date(gf_GetServerDate()),  -30)  Then lb_Exportada_Mult = True
													
								If lb_Exportada_Mult Then
									
									If Not gf_Conecta_Banco_Mult(OracleMult, 'CLAMPROD') Then Exit						
																							
									If Not wf_permite_exclusao_mult( lvs_Chave_Acesso, Ref lb_Exclusao, Ref lb_Pagto ) Then Exit
									
									If Not lb_Exclusao Then
										
										If lb_Pagto Then
											If is_Tipo = "N" Then
												MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A NF " + String(il_Nr_NF) + " N$$HEX1$$c300$$ENDHEX$$O poder$$HEX1$$e100$$ENDHEX$$ ser exclu$$HEX1$$ed00$$ENDHEX$$da.~r~r" + &
																"Motivo: Pagamento j$$HEX1$$e100$$ENDHEX$$ efetuado.",Exclamation!)
											Else
												wf_Insere_Mensagem("N", "NF N$$HEX1$$c300$$ENDHEX$$O poder$$HEX1$$e100$$ENDHEX$$ ser exclu$$HEX1$$ed00$$ENDHEX$$da. Motivo: Pagamento j$$HEX1$$e100$$ENDHEX$$ efetuado.")
											End If
											
										Else
											
											If is_Tipo = "N" Then
												MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A NF " + String(il_Nr_NF) + " N$$HEX1$$c300$$ENDHEX$$O poder$$HEX1$$e100$$ENDHEX$$ ser exclu$$HEX1$$ed00$$ENDHEX$$da.~r~r" + &
																"Motivo: Per$$HEX1$$ed00$$ENDHEX$$odo fiscal fechado. Solicitar a reabertura junto ao depto. fiscal.",Exclamation!)
											Else
												wf_Insere_Mensagem("N", "NF N$$HEX1$$c300$$ENDHEX$$O poder$$HEX1$$e100$$ENDHEX$$ ser exclu$$HEX1$$ed00$$ENDHEX$$da. Motivo: Per$$HEX1$$ed00$$ENDHEX$$odo fiscal fechado. Solicitar a reabertura junto ao depto. fiscal.")
											End If
										End If
										
										Continue
										
									End If
									
									ls_msg_email =  "Filial: " + String(il_Filial) 		+ "<br />" + &
														"Fornecedor: " + is_Fornecedor 	+ "<br />" + &
														"Nota: " + String(il_Nr_NF) 				+ "<br />" + &
														"Esp$$HEX1$$e900$$ENDHEX$$cie: " + is_Especie 			+ "<br />" + &
														"S$$HEX1$$e900$$ENDHEX$$rie: " + is_Serie 					+ "<br />" + &
														"Data Movimento: " + String(idh_Data_Caixa, 'DD/MM/YYYY')
													
									If ivo_Usuario.Localizado Then
										ls_msg_email += "<br />" + "Respons$$HEX1$$e100$$ENDHEX$$vel Exclus$$HEX1$$e300$$ENDHEX$$o: " + ivo_Usuario.Nm_Usuario
									End If
																			
								End If
							
							End If
														
							
							If il_Filial <> 534 And il_Filial <> 2 and gvo_Aplicacao.ivs_DataSource <> 'homologa'  and not lvb_Desenvolvimento Then							
								If Not ib_Filial_Fechada Then
															
									If wf_Conecta_Banco_Filial( il_Filial ) Then
									
										If wf_verifica_devolucao_compra_filial( il_Filial, is_Fornecedor, il_Nr_NF, is_Especie, is_Serie, Ref ls_Compra_Devolvida ) Then
											If ls_Compra_Devolvida = "S" Then
												If is_Tipo = "N" Then
													MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A nota fiscal '" + String(il_Nr_NF) + "' n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser exclu$$HEX1$$ed00$$ENDHEX$$da.~r" +&
																		"Motivo: Nota Fiscal de Devolu$$HEX2$$e700e300$$ENDHEX$$o emitida pela filial.~r~r" 	+&
																		".:: O que Fazer ::.~r"														+ &
																		"1 - Solicitar a filial o cancelamento da NF Dev. Compra.~r"	+&
																		"2 - Avisar o departamento de inform$$HEX1$$e100$$ENDHEX$$tica.",Exclamation!)
																		//"2 - Mudar a refer$$HEX1$$ea00$$ENDHEX$$ncia da NF Compra inserindo uma numera$$HEX2$$e700e300$$ENDHEX$$o antiga.
												Else
													wf_Insere_Mensagem("N", "NF n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser exclu$$HEX1$$ed00$$ENDHEX$$da. Motivo: Nota Fiscal de Devolu$$HEX2$$e700e300$$ENDHEX$$o emitida pela filial.")
												End If
												
												Continue
											End If
										End If						
									Else
										
										If Not gf_Verifica_Filial_Fechada(il_Filial, Ref ib_Filial_Fechada) Then Return -1
										
										//Se $$HEX1$$e900$$ENDHEX$$ uma filial ativa e que est$$HEX1$$e100$$ENDHEX$$ sem comunica$$HEX2$$e700e300$$ENDHEX$$o o sistema n$$HEX1$$e300$$ENDHEX$$o permite a exclus$$HEX1$$e300$$ENDHEX$$o, o usu$$HEX1$$e100$$ENDHEX$$rio ter$$HEX1$$e100$$ENDHEX$$ que aguardar a comunica$$HEX2$$e700e300$$ENDHEX$$o da loja retornar
										If Not ib_Filial_Fechada Then
											If is_Tipo = "N" Then
												MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial est$$HEX1$$e100$$ENDHEX$$ sem comunica$$HEX2$$e700e300$$ENDHEX$$o. Tente novamente mais tarde.")
											Else											
												wf_Insere_Mensagem("N", "Filial est$$HEX1$$e100$$ENDHEX$$ sem comunica$$HEX2$$e700e300$$ENDHEX$$o. Tente novamente mais tarde.")
											End If
											
											Continue
										Else
											If is_Tipo = "N" Then
												If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial est$$HEX1$$e100$$ENDHEX$$ sem comunica$$HEX2$$e700e300$$ENDHEX$$o e est$$HEX1$$e100$$ENDHEX$$ fechada temporariamente ou em definitivo." + &
																				"~rDeseja prosseguir com a exclus$$HEX1$$e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 2 Then Return -1
											Else
												wf_Insere_Mensagem("N", "Filial est$$HEX1$$e100$$ENDHEX$$ sem comunica$$HEX2$$e700e300$$ENDHEX$$o e est$$HEX1$$e100$$ENDHEX$$ fechada temporariamente ou em definitivo. Tente novamente mais tarde ou fa$$HEX1$$e700$$ENDHEX$$a a exclus$$HEX1$$e300$$ENDHEX$$o da nota manualmente.")
												Continue
											End If
										End If
									End If
								End If
							End If
						End If //If ls_Filial_Java <> "S" Then
						
						// Verifica se existe psico na nota
							
						// S$$HEX1$$e900$$ENDHEX$$rgio => 24/02/10
						// Coment$$HEX1$$e100$$ENDHEX$$rio: se a nota possuir psico ainda $$HEX1$$e900$$ENDHEX$$ possivel colocar mais um controle para deixar excluir somente
						// as notas em que o arquivo do SNGPC ainda n$$HEX1$$e300$$ENDHEX$$o foi enviado
						
						// A dh_movimentacao_caixa (entrada manual) ou dh_atualizacao_estoque (entrada automatica) n$$HEX1$$e300$$ENDHEX$$o podem ser menor
						// ou igual a max(dh_fim_movimento) da tabela SNGP_HISTORICO_ARQUIVO_FILIAL
						
						If wf_Verifica_Psico(il_Filial, is_Fornecedor, il_Nr_NF, is_Especie, is_Serie, lvb_Desenvolvimento, ls_Filial_Java) Then
							//Esta fun$$HEX2$$e700e300$$ENDHEX$$o tem que estar antes da wf_Processa_Exclusao. Porque a trigger verifica o registro dessa tabela na integra$$HEX2$$e700e300$$ENDHEX$$o com filiais com sistema JAVA
							If wf_Inclui_Log_Exclusao(il_Filial, is_Fornecedor, il_Nr_NF, is_Especie, is_Serie,&
															  idh_Data_Caixa, lvdc_Total_NF, lvl_Pedido_Distribuidora,&
 															  lvs_Chave_Acesso, ls_Motivo, lb_Exportada_Mult,lvs_desconhecimento) Then
								If wf_Processa_Exclusao(il_Filial, is_Fornecedor, il_Nr_NF, is_Especie, is_Serie, &
															idh_Data_Caixa, lvdc_Total_NF, lvl_Pedido_Distribuidora ) Then
									If wf_Exclui_Log_Exportacao_Mult(il_Filial, is_Fornecedor, il_Nr_NF, is_Especie, is_Serie) Then
										lvb_Sucesso = True
									End If
								End If
							End If
						End If
						
						If lvb_Sucesso Then
							SqlCa.of_Commit()
													
							//Envia um e-mail p/ os Deptos: FISCAL / CONTAS a PAGAR
							//wf_envia_email("Exclus$$HEX1$$e300$$ENDHEX$$o NF compra", ls_msg_email)
							If lb_Exportada_Mult Then gf_ge202_envia_email_automatico( 21, '', ls_msg_email, {''} )
						Else
							SqlCa.of_RollBack()
						End If
					
					Finally
						ivo_odbc.of_deleta_regedit_odbc( il_Filial )
						
						If ivo_DB_Filial.of_isConnected() Then ivo_DB_Filial.of_Disconnect()	
			
						If OracleMult.of_isConnected() Then OracleMult.of_Disconnect()
					End Try
			
				End If								
			Next
			
			//Se houverem notas que n$$HEX1$$e300$$ENDHEX$$o foram exclu$$HEX1$$ed00$$ENDHEX$$das, ser$$HEX1$$e300$$ENDHEX$$o listadas na tela response
			If dw_3.RowCount() > 0 Then
				OpenWithParm(w_ge213_notas_nao_excluidas, dw_3)
			End If
			
			cb_Planilha.Enabled = False
			dw_1.Object.Id_Planilha[1] = "N"
			dw_1.Object.Nm_Arquivo[1] = ls_Nulo
			
			If is_Tipo = "N" Then
				dw_2.Event ue_Retrieve()
			Else
				dw_2.Event ue_Reset()
				dw_3.Event ue_Reset()
			End If
			
			is_Tipo = "N"
		End If
	End If
End If

SetPointer(Arrow!)
end function

public subroutine wf_insere_mensagem (string as_permite_excluir, string as_mensagem);Long ll_Linha

ll_Linha = dw_3.InsertRow(0)

dw_3.Object.Cd_Filial							[ll_Linha] = il_Filial
dw_3.Object.Nm_Fantasia					[ll_Linha] = is_Nome_Fantasia
dw_3.Object.Nr_NF							[ll_Linha] = il_Nr_NF
dw_3.Object.De_Especie						[ll_Linha] = is_Especie
dw_3.Object.De_Serie						[ll_Linha] = is_Serie
dw_3.Object.Id_Permite_Excluir			[ll_Linha] = as_Permite_Excluir
dw_3.Object.Dh_Movimentacao_Caixa	[ll_Linha] = idh_Data_Caixa
dw_3.Object.De_Mensagem					[ll_Linha] = as_Mensagem
end subroutine

public function boolean wf_permissao_exclusao (string as_procedimento);String	ls_Erro
String ls_Mensagem
		
Long	ll_Qtde		

Select count(*)
Into	:ll_Qtde
From procedimento_sistema_usuario
Where	cd_sistema			= :gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
	And	cd_procedimento	= :as_Procedimento
	And	nr_matricula		= :gvo_aplicacao.ivo_seguranca.nr_matricula
Using SqlCA;	

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	MessageBox("Erro", "Erro ao verificar se o procedimento '" + ls_Mensagem + "' est$$HEX1$$e100$$ENDHEX$$ liberado para o usu$$HEX1$$e100$$ENDHEX$$rio.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
	Return False
End If

If ll_Qtde = 0 Then
	If as_Procedimento = "GE213_PERMITE_EXCLUIR_NF_COMPRA" Then
		ls_Mensagem = "Usu$$HEX1$$e100$$ENDHEX$$rio sem permiss$$HEX1$$e300$$ENDHEX$$o para excluir nota de m$$HEX1$$ea00$$ENDHEX$$s anterior"
	Else
		ls_Mensagem = "Somente o T.I. poder$$HEX1$$e100$$ENDHEX$$ excluir notas com estoque atualizado e que contenha produtos controlados."
	End If	
	
	If is_Tipo = "N" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Exclamation!)
	Else
		wf_Insere_Mensagem("N", ls_Mensagem)
	End If
	
	Return False
End If

Return True
end function

public function boolean wf_verifica_psico (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, boolean ab_desenvolvimento, string as_filial_java);Long lvl_Achou

String ls_Erro

If ab_desenvolvimento Then Return True

//Na filia java n$$HEX1$$e300$$ENDHEX$$o consulta lote porque n$$HEX1$$e300$$ENDHEX$$o pode excluir nota de compra, apena compra pendente
If as_Filial_Java = "S" Then
	Return True
End If

If ivs_Nf_Compra_Pendente = "N" Then
	Select count(*) 
	Into :lvl_Achou
	From item_nf_compra i, produto_geral p
	Where i.cd_filial		=:al_Filial
	  and i.cd_fornecedor =:as_Fornecedor
	  and i.nr_nf				=:al_Nota
	  and i.de_especie		=:as_Especie
	  and i.de_serie			=:as_Serie
	  and p.cd_produto	= i.cd_produto
	  and p.cd_grupo_psico  is not null
	  Using SqlCa;
Else
	Select count(*) 
	Into :lvl_Achou
	From nf_compra_pendente_produto i, produto_geral p
	Where i.cd_filial		=:al_Filial
	  and i.cd_fornecedor	=:as_Fornecedor
	  and i.nr_nf				=:al_Nota
	  and i.de_especie		=:as_Especie
	  and i.de_serie			=:as_Serie
	  and p.cd_produto	= i.cd_produto
	  and p.cd_grupo_psico  is not null	
	  Using SqlCa;
End If	


If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o de psicos na nota.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
	Return False
End If

// Desenvolvimento
//lvl_Achou = 0

If gvo_Aplicacao.ivs_DataSource = 'homologa'  Then
	lvl_Achou = 0
End If

If lvl_Achou > 0 Then
	If Not wf_Verfica_SNGPC_Filial(al_filial, as_fornecedor, al_nota, as_especie, as_serie) Then
		Return False
	End If
End If

Return True
end function

public function boolean wf_valida_nf_compra_filial_java (integer al_filial, string as_fornecedor, long al_nr_nf, string as_especie, string as_serie, ref string as_filial_java);Long ll_Qtde

String ls_Erro


select coalesce(id_pdv_java, 'N')
into :as_Filial_Java
from parametro_odbc
where cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.sqlcode			
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o forma localizadas as informa$$HEX2$$e700f500$$ENDHEX$$es para ver se a filial $$HEX1$$e900$$ENDHEX$$ Java.~r" + ls_Erro, StopSign!)
		SqlCa.of_Rollback();
		Return False
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se a filial $$HEX1$$e900$$ENDHEX$$ Java.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
		Return False
End Choose

If as_Filial_Java = "S" Then
	select count(*)
	into :ll_Qtde
	from nf_compra
	where	cd_filial 			= :al_Filial
		and	cd_fornecedor	= :as_Fornecedor
		and	nr_nf				= :al_Nr_Nf
		and	de_especie		= :as_Especie
		and	de_serie			= :as_Serie
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se nota ja foi importada na filial Java.~r" + is_Chave_Log + ".~r" + ls_Erro, StopSign!)
		Return False
	End If
	
	If ll_Qtde > 0 Then
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Notas importadas em filiais do PDV novo n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e300$$ENDHEX$$o ser exclu$$HEX1$$ed00$$ENDHEX$$das.~rOriente a filial a efetuar a devolu$$HEX2$$e700e300$$ENDHEX$$o.~r~r" + is_Chave_Log, StopSign!)
		Return False
	End If	
End If

Return True


end function

public function boolean wf_inclui_log_exclusao (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, datetime adt_movimento, decimal adc_valor, long al_pedido, string as_chave_acesso, string as_motivo, boolean ab_exportado_mult, string as_desconhecimento);Long ll_Seq

String ls_Mult
String ls_Erro

If Not gf_ge213_Seq_Log_Exc_Nf_Compra(al_Filial, as_Fornecedor, al_Nota, as_Especie, as_Serie, Ref ll_Seq) Then Return False

If (ab_exportado_mult) Then  
	ls_Mult = 'S'
Else
	ls_Mult = 'N'
End If

 INSERT INTO log_exclusao_nf_compra  ( cd_filial,   
													  cd_fornecedor,   
													  nr_nf,   
													  de_especie,   
													  de_serie,   
													  dh_movimentacao_caixa,   
													  vl_total_nf,   
													  nr_pedido_distribuidora,   
													  nr_matricula_solicitante,   
													  nr_matricula_responsavel,   
													  dh_exclusao,   
													  de_chave_acesso,   
													  de_motivo,
													  nr_sequencial,
													  id_nf_pendente,
													  id_exportada_mult,
													  id_desconhecimento )
  VALUES (	:al_filial,   
           		:as_fornecedor,   
           		:al_nota,   
           		:as_especie,   
           		:as_serie,   
           		:adt_movimento,   
           		:adc_valor,   
           		:al_pedido,   
           		null,   
           		:ivs_operador,   
           		getdate(),   
           		:as_chave_acesso,   
           		:as_motivo,
				:ll_Seq,
				:ivs_Nf_Compra_Pendente,
				:ls_Mult,
				:as_desconhecimento)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do log exporta$$HEX2$$e700e300$$ENDHEX$$o de exclus$$HEX1$$e300$$ENDHEX$$o de nota.~r" + is_Chave_Log + ".~r" + ls_Erro)
	Return False
End If

Return True
end function

on w_ge213_exclusao_nf_compra.create
int iCurrent
call super::create
this.cb_excluir=create cb_excluir
this.cb_1=create cb_1
this.cb_planilha=create cb_planilha
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_excluir
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_planilha
end on

on w_ge213_exclusao_nf_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_excluir)
destroy(this.cb_1)
destroy(this.cb_planilha)
end on

event open;call super::open;ivo_Fornecedor 	= Create uo_Fornecedor
ivo_ODBC 			= Create dc_uo_odbc 
ivo_DB_Filial		= Create dc_uo_transacao
ivo_Filial				= Create uo_Filial
ivo_Usuario		= Create uo_Usuario
OracleMult			= Create dc_uo_transacao

ivb_Desenvolvimento = False

// Desenvolvimento
//ivb_Desenvolvimento = True

If ivb_Desenvolvimento Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desenvolvimento.", Exclamation!)
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE213_EXCLUSAO_NF_COMPRA", ref ivs_Operador) Then 
	Close(This)
	Return
End If
end event

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy(ivo_ODBC)
Destroy(ivo_DB_Filial)
Destroy(ivo_Filial)
Destroy(OracleMult)
Destroy(ivo_Usuario)
end event

event ue_postopen;call super::ue_postopen;Date 		ltd_Termino
String	ls_msg

//This.ivm_Menu.mf_SalvarComo(True)

If Not wf_localiza_parametro_wms() Then
	Close(This)
	Return
End If

ltd_Termino = Date(gvo_Parametro.of_dh_Movimentacao())

dw_1.Object.dt_inicio		[1] = RelativeDate( ltd_Termino, -15 )
dw_1.Object.dt_termino	[1] = ltd_Termino

ivo_Usuario.of_Localiza_Matricula(ivs_Operador)

dw_1.SetFocus()

if Not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref lb_iniciado_operacao_sap, ref ls_msg) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg, Information!)
		
	return
End If
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge213_exclusao_nf_compra
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge213_exclusao_nf_compra
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge213_exclusao_nf_compra
integer x = 18
integer y = 516
integer width = 3387
integer height = 1228
string text = "Lista de Notas Fiscais"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge213_exclusao_nf_compra
integer x = 18
integer y = 8
integer width = 2674
integer height = 492
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge213_exclusao_nf_compra
integer x = 46
integer y = 64
integer width = 2629
integer height = 408
string dataobject = "dw_ge213_selecao"
end type

event dw_1::itemchanged;Boolean lb_Visivel

Integer li_Retorno

Long ll_Nulo

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_1.AcceptText()

SetNull(ls_Nulo)
SetNull(ll_Nulo)

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then	dw_2.Event ue_Reset()

Choose Case dwo.name
		
	Case "id_tipo"
				
		//Distribuidora
		If Data = "D" Then 
			This.Object.nm_fantasia_t.text = "Distribuidora:"
			lb_Visivel = True
		Else
			This.Object.nm_fantasia_t.text = "Fornecedor:"
			lb_Visivel = False
		End If
		
		ivo_fornecedor.of_Inicializa()
		This.Object.cd_Fornecedor		[1] 	= ivo_fornecedor.cd_Fornecedor
		This.Object.nm_Fornecedor		[1] 	= ivo_fornecedor.nm_Fantasia
		This.Object.cd_Fornecedor.visible		= (Not lb_Visivel )
		This.Object.nm_Fornecedor.visible	= (Not lb_Visivel)
		This.Object.cd_distribuidora.visible	= lb_Visivel
		
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial  		[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial		[1] = ivo_Filial.Nm_Fantasia			
		End If
		
	Case "nm_fornecedor"
		If Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_Fantasia Then
				Return 1
			End If	
		Else			
			
			ivo_fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor		[1] = ivo_fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor		[1] = ivo_fornecedor.Nm_Fantasia			
		End If
		
	Case "id_planilha"		
		If Data = "S" Then	
			
			If Not IsDate(String(dw_1.Object.Dt_Inicio[1], "dd/mm/yyyy")) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
				dw_1.Event ue_Pos(1, "dt_inicio")
				Return 1
			End If
			
			If Not IsDate(String(dw_1.Object.Dt_Termino[1], "dd/mm/yyyy")) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
				dw_1.Event ue_Pos(1, "dt_termino")
				Return 1
			End If
			
			If dw_1.Object.Dt_Inicio[1] > dw_1.Object.Dt_Termino[1] Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
				dw_1.Event ue_Pos(1, "dt_termino")
				Return 1
			End If
			
			/*Chamado 1436354*/
			If dw_1.Object.Id_Tipo[1]  = "D" Then 
				If IsNull(dw_1.Object.cd_distribuidora [1]) Or Trim(dw_1.Object.cd_distribuidora [1]) = "" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a " + String(This.Object.nm_fantasia_t.text) + ""  , Information!)
					dw_1.Event ue_Pos(1, "cd_distribuidora")
					Return 1
				End If
			Else
				If IsNull(dw_1.Object.cd_fornecedor [1]) Or Trim(dw_1.Object.cd_fornecedor [1]) = "" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o " + String(This.Object.nm_fantasia_t.text) + ""  , Information!)
					dw_1.Event ue_Pos(1, "cd_fornecedor")
					Return 1
				End If
			End If 
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r~r" + &
										+ "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo da Filial~r" + &
										+ "Coluna B = NF~r ")
			
			li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")
			
			If li_Retorno = 1 Then 
				dw_1.Object.Nm_Arquivo[1] = Upper(ls_Arquivo)
				
				dw_1.Object.Nr_NF[1] = ll_Nulo
				
				If Not wf_Le_Dados_Planilha(ls_Arquivo) Then Return 1
				
				dw_2.Event ue_Retrieve()
				dw_3.Event ue_Reset()
				
				If dw_2.RowCount() > 0 Then
					cb_Planilha.Enabled = True
					cb_Excluir.Enabled = False
				End If

			Else				
				dw_1.Object.Nm_Arquivo[1] = ls_Nulo
				cb_Planilha.Enabled = False
				Return 1
			End If	
			
		Else
			dw_1.Object.Nm_Arquivo[1] = ls_Nulo
			cb_Planilha.Enabled = False
		End If
End Choose
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
			
		Case "nm_filial"
	
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia
				
				ib_Filial_Fechada = False
			End If
		
		Case "nm_fornecedor"
	
			ivo_fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_fornecedor.Localizado Then
				This.Object.Cd_fornecedor	[1] = ivo_fornecedor.Cd_Fornecedor
				This.Object.Nm_fornecedor	[1] = ivo_fornecedor.Nm_Fantasia
			End If
			
	End Choose
		
End If
end event

event dw_1::editchanged;//OverRide

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	This.ivm_Menu.mf_SalvarComo(False)
	
	dw_2.Event ue_Reset()
	
End If

Choose Case dwo.Name
	Case "nr_nf"
		dw_1.Object.Id_Planilha[1] = "N"
		dw_3.Event ue_Reset()
End Choose
end event

event dw_1::constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"de_motivo"}
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge213_exclusao_nf_compra
integer x = 41
integer y = 576
integer width = 3342
integer height = 1136
string dataobject = "dw_ge213_lista"
end type

event dw_2::ue_recuperar;// Override

String lvs_Fornecedor, ls_Tipo

Date lvdt_Inicio, &
     lvdt_Termino
	 
Long lvl_Nota,&
		lvl_Filial
	  
dw_1.AcceptText()

ls_Tipo				= dw_1.Object.id_Tipo			[1]
lvdt_Inicio    		= dw_1.Object.Dt_Inicio    		[1]
lvdt_Termino   		= dw_1.Object.Dt_Termino   	[1]
lvl_Filial				= dw_1.Object.cd_Filial			[1]
lvl_Nota				= dw_1.Object.nr_nf				[1]

If ls_Tipo = 'D' Then
	lvs_Fornecedor 	= dw_1.Object.cd_distribuidora	[1]
Else
	lvs_Fornecedor 	= dw_1.Object.Cd_Fornecedor		[1]
End If

If Not IsDate(String(lvdt_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsDate(String(lvdt_Termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If IsNull(lvs_Fornecedor) or Trim(lvs_Fornecedor) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor ou a distribuidora.", Information!)
	dw_1.Event ue_Pos(1, "cd_fornecedor")
	Return -1
End If

//Se for exclus$$HEX1$$e300$$ENDHEX$$o normal
If IsNull(dw_1.Object.Nm_Arquivo[1]) Or dw_1.Object.Nm_Arquivo[1] = "" Then
	If IsNull(lvl_Nota) Or lvl_Nota = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a nota fiscal.", Information!)
		dw_1.Event ue_Pos(1, "nr_nf")
		Return -1
	End If

	If Not IsNull(lvl_Filial) Then
		This.of_AppendWhere_SubQuery("n.cd_filial = " + String(lvl_Filial), 2)
		This.of_AppendWhere_SubQuery("n.cd_filial = " + String(lvl_Filial), 4)
	End If
	
	If Not IsNull(lvl_Nota) And lvl_Nota <> 0 Then
		This.of_AppendWhere_SubQuery("n.nr_nf = " + String(lvl_Nota), 2)
		This.of_AppendWhere_SubQuery("n.nr_nf = " + String(lvl_Nota), 4)
	End If
	
Else
	
	This.of_AppendWhere_SubQuery("n.cd_filial in (" + is_Filial + ")", 2)
	This.of_AppendWhere_SubQuery("n.cd_filial in (" + is_Filial + ")", 4)
		
	This.of_AppendWhere_SubQuery("n.nr_nf in (" + is_Nr_NF + ")", 2)
	This.of_AppendWhere_SubQuery("n.nr_nf in (" + is_Nr_NF + ")", 4)
End If

Return This.Retrieve(lvs_Fornecedor, lvdt_Inicio, lvdt_Termino)
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		
lvs_Coluna = {"cd_filial", &
              "nr_nf", &
			  "dh_movimentacao_caixa", &
			  "nr_pedido_distribuidora",&
			  "de_especie",&
			  "de_serie"}

lvs_Nome = {"Filial", &
            "Nota Fiscal", &
			"Data", &
			"Pedido",&
			"Esp$$HEX1$$e900$$ENDHEX$$cie",&
			"S$$HEX1$$e900$$ENDHEX$$rie"}
				
This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Date	ld_dh_recebido_sap
Long	ll_for


If pl_Linhas > 0 Then
	If is_Tipo = "N" Then
		cb_Excluir.Enabled = True
	End If
	
	This.ivm_Menu.mf_SalvarComo(True)
	
	//Altera para casos onde notas n$$HEX1$$e300$$ENDHEX$$o foram localizadas
	If pl_Linhas < il_Linha_Planilha Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Uma ou mais notas da planilha n$$HEX1$$e300$$ENDHEX$$o foram localizadas.~r" + &
										"Verifique os par$$HEX1$$e200$$ENDHEX$$metros informados.")
	End If
	
	for ll_for = 1 to pl_linhas
		ld_dh_recebido_sap	= Date(this.GetItemDateTime(ll_for, 'dh_recebido_sap'))
		
		if not IsNull(ld_dh_recebido_sap) then
			this.SetItem(ll_for, 'id_excluir', 'N')
		end if
	next
Else
	cb_Excluir.Enabled = False
	This.ivm_Menu.mf_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::itemchanged;call super::itemchanged;Date ldh_Movimento, ld_dh_recebido_sap

Long ll_Filial

This.AcceptText()

ldh_Movimento	= Date(This.Object.dh_movimentacao_caixa	[row])
ll_Filial 				= This.Object.cd_filial	[row]

If ll_Filial = 534 Then
	If ldh_Movimento >= idt_data_inicio_operacao_wms and Not ivb_Desenvolvimento Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A partir de '" + String(idt_data_inicio_operacao_wms, "dd/mm/yyyy") +&
							"' n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ mais poss$$HEX1$$ed00$$ENDHEX$$vel excluir nota fiscal de compra do Perini.~r~r" +&
							"Motivo: In$$HEX1$$ed00$$ENDHEX$$cio da opera$$HEX2$$e700e300$$ENDHEX$$o do WMS.", StopSign!)
		Return 1
	End If
End If

Choose Case dwo.Name
	Case "id_excluir"
		
		If Data = "S" Then
			ld_dh_recebido_sap	= Date(this.GetItemDateTime(row, 'dh_recebido_sap'))
			
			if not IsNull(ld_dh_recebido_sap) then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel excluir uma nota de compra vinda do SAP por esta tela.', StopSign!)
				Return 1
			end if
			
			If dw_1.Object.Id_Planilha[1] = "S" Then
				If dw_2.Object.Id_Compra_Pendente[row] = "N" Then
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque da NF foi atualizado pela filial.~rDeseja prosseguir com a exclus$$HEX1$$e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 2 Then Return 1
				End If
			End If
		End If
End Choose

Return 0
end event

event dw_2::doubleclicked;call super::doubleclicked;If dwo.Name = 'p_1' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For lvl_Row = 1 To This.RowCount()				
		This.Object.Id_Excluir[lvl_Row] = lvs_Marcacao		
	Next
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge213_exclusao_nf_compra
integer x = 2711
integer y = 0
integer width = 306
integer height = 160
integer taborder = 50
string dataobject = "dw_ge213_lista_planilha"
end type

type cb_excluir from commandbutton within w_ge213_exclusao_nf_compra
integer x = 2711
integer y = 388
integer width = 553
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Excluir Notas Fiscais"
end type

event clicked;//Exclus$$HEX1$$e300$$ENDHEX$$o Normal

is_Tipo = "N"

wf_Valida_Exclusao()
end event

type cb_1 from commandbutton within w_ge213_exclusao_nf_compra
boolean visible = false
integer x = 2926
integer y = 164
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Informatica"
end type

event clicked;Long lvl_Filial, lvl_NF

STring lvs_Fornecedor, lvs_Especie, lvs_Serie, lvs_Chave_Acesso, ls_msg_email

Boolean lb_Exportada_Mult, lb_Exclusao, lb_Pagto

Date lvdh_Data_Caixa

lvl_Filial = 400
lvl_NF = 644998
lvs_Especie = 'NFE'
lvs_Fornecedor = '053400534'
lvs_Serie = '2'
lvs_Chave_Acesso = '42161282762824000163550020006449981311561776'
lvdh_Data_Caixa = date('20/12/2016')


ls_msg_email =  "Filial: " + String(lvl_Filial) 		+ "<br />" + &
													"Fornecedor: " + 'XXXXXXXX' 	+ "<br />" + &
													"Nota: " + String(99999999999) 				+ "<br />" + &
													"Esp$$HEX1$$e900$$ENDHEX$$cie: " + lvs_Especie 			+ "<br />" + &
													"S$$HEX1$$e900$$ENDHEX$$rie: " + lvs_Serie 					+ "<br />" + &
													"Data Movimento: " + String(lvdh_Data_Caixa, 'DD/MM/YYYY' + "<br />" + "<br />" + '***** SOMENTE TESTE *****')
													
gf_ge202_envia_email_automatico( 21, '', ls_msg_email, {''} )
													


//ivs_Nf_Compra_Pendente = 'N'
//
//If gvo_Aplicacao.ivs_DataSource = 'central' Then
//						
//		If Not wf_Verifica_Exportacao_mult(lvl_Filial, lvs_Fornecedor, lvl_NF, lvs_Especie, lvs_Serie, Ref lb_Exportada_Mult) Then Return
//		
//		//O sistema EX limpa os logs dos ultimos 30 dias
//		If ivs_Nf_Compra_Pendente = 'N' And Date(lvdh_Data_Caixa) < RelativeDate( date(gf_GetServerDate()),  -30)  Then lb_Exportada_Mult = True
//							
//		If lb_Exportada_Mult Then
//			
//			If Not gf_Conecta_Banco_Mult(OracleMult, 'CLAMPROD') Then Return						
//																	
//			If Not wf_permite_exclusao_mult( lvs_Chave_Acesso, Ref lb_Exclusao, Ref lb_Pagto ) Then Return
//			
//			If Not lb_Exclusao Then
//				
//				If lb_Pagto Then
//					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A NF " + String(lvl_NF) + " N$$HEX1$$c300$$ENDHEX$$O poder$$HEX1$$e100$$ENDHEX$$ ser exclu$$HEX1$$ed00$$ENDHEX$$da.~r~r" + &
//									"Motivo: Pagamento j$$HEX1$$e100$$ENDHEX$$ efetuado.",Exclamation!)								
//				Else
//					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A NF " + String(lvl_NF) + " N$$HEX1$$c300$$ENDHEX$$O poder$$HEX1$$e100$$ENDHEX$$ ser exclu$$HEX1$$ed00$$ENDHEX$$da.~r~r" + &
//									"Motivo: Per$$HEX1$$ed00$$ENDHEX$$odo fiscal fechado. Solicitar a reabertura junto ao depto. fiscal.",Exclamation!)
//				End If
//				
//				Return
//				
//			End If
//		End If
//						
//End If
end event

type cb_planilha from commandbutton within w_ge213_exclusao_nf_compra
integer x = 2711
integer y = 256
integer width = 553
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Excluir via Planilha"
end type

event clicked;//Exclus$$HEX1$$e300$$ENDHEX$$o por Planilha

is_Tipo = "P"

wf_Valida_Exclusao()
end event

