HA$PBExportHeader$uo_ge481_distribuidora_produto.sru
forward
global type uo_ge481_distribuidora_produto from nonvisualobject
end type
end forward

global type uo_ge481_distribuidora_produto from nonvisualobject
end type
global uo_ge481_distribuidora_produto uo_ge481_distribuidora_produto

type variables
uo_ge470_sap_comum io_sap_comum

String is_Origem_Legado 		= "SYBASE"
Integer ii_Empresa				= 1000
String is_Termino_Cabecalho 	= ""
String is_Termino_Item 			= '</ITEM>'
String is_URL
String is_Inicio_XML
String is_Termino_XML
String is_Arquivo_Log
String is_Ambiente_SAP

String is_DS 				= 'ds_ge481_envio_distribuidora_produto'
String is_Objeto 			= 'uo_ge481_distribuidora_produto'
String is_nome_arquivo 	= 'distribuidora_produto_F5'
String is_DS_UF			='ds_ge481_envio_distribuidora_produto_uf'		

Integer	ii_log




end variables

forward prototypes
private function boolean of_processa_retorno (string as_cliente, string as_xml_retorno, ref string as_erro)
public function boolean of_ambiente_sap (ref string as_log)
public subroutine of_processa_envio ()
public function boolean of_abre_log (string as_nome_arquivo)
public function boolean of_monta_xml_item (datastore ps_ds, long pl_linha, ref string as_xml, ref string as_log)
public subroutine of_processa_envio (long pl_nr_atualizacao)
public function boolean of_busca_chave_log_exp (long pl_nr_atualizacao, ref long pl_cd_produto, ref string ps_cd_uf, ref string ps_log)
public function boolean of_grava_log_exportacao (datastore ps_ds, ref string ps_log)
public function boolean of_atualiza_processado (long al_produto, string as_uf, string as_distribuidora, ref string as_log)
public subroutine of_grava_xml (string as_xml, string as_chave)
public function boolean of_monta_xml_cabecalho (string as_cd_uf, ref string as_cabecalho, ref string as_log, string as_fornecedor_sap)
public function boolean of_localiza_dados_view (long al_produto, string as_uf, string as_distribuidora, ref decimal ldc_vl_repasse, ref decimal ldc_vl_compra, ref decimal ldc_pc_desconto_financeiro, ref decimal ldc_vl_melhor_compra, ref decimal ldc_vl_juros_decrescimo_dist, ref decimal ldc_vl_preco_atual, ref decimal ldc_vl_icms_st, ref decimal ldc_vl_base_icms, ref decimal ldc_vl_icms, ref string as_log)
end prototypes

private function boolean of_processa_retorno (string as_cliente, string as_xml_retorno, ref string as_erro);String	ls_Status,&
		ls_Erro,&
		ls_Parte_Xml


Long	ll_Pos_1, &
		ll_Pos_2, &
		ll_Lenght

Try
	
	as_Erro = ""
	
	DO WHILE Pos(as_xml_retorno, "<ns0:MT_RESPONSE_CLI_IN xmlns:ns0='importa_sap.com'>") > 0
		
		ll_Pos_1	= Pos(as_xml_retorno, "<ns0:MT_RESPONSE_CLI_IN xmlns:ns0='importa_sap.com'>")
		ll_Pos_2	= Pos(as_xml_retorno, "</ns0:MT_RESPONSE_CLI_IN>")
		ll_Lenght	= Len( "</ns0:MT_RESPONSE_CLI_IN>")
		
		ls_Parte_Xml	= Mid(as_xml_retorno, ll_Pos_1, (ll_Pos_2 + ll_Lenght) - ll_Pos_1)

		ll_Pos_1	= Pos(ls_Parte_Xml, '<ZSTATUS_INT>')
		ll_Pos_2	= Pos(ls_Parte_Xml, '</ZSTATUS_INT>')
		ll_Lenght	= Len( '</ZSTATUS_INT>')		
		ls_Status = Mid(ls_Parte_Xml, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		//Integra$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso
		If ls_Status = "I" Then
			Return True
		End If
		
		ll_Pos_1	= Pos(ls_Parte_Xml, '<MESSAGE>')
		ll_Pos_2	= Pos(ls_Parte_Xml, '</MESSAGE>')
		ll_Lenght	= Len( '</MESSAGE>')		
		ls_Erro = Mid(ls_Parte_Xml, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		If as_Erro = "" Then
			as_Erro = ls_Erro
		Else
			as_Erro += "~r"+ ls_Erro
		End If
		
		as_xml_retorno = gf_Replace(as_xml_retorno, ls_Parte_Xml, '', 0)	//Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida	
	
	LOOP	
	
Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Processa_Retorno_Contabil', objeto 'uo_el100_sap'. Erro: "+lo_rte.GetMessage())
	Return False
End Try

If as_Erro = "" Then
	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o para processar o retorno."
End If
Return False
end function

public function boolean of_ambiente_sap (ref string as_log);return gf_ambiente_sap( ref is_ambiente_sap, ref as_log )
end function

public subroutine of_processa_envio ();of_processa_envio(0)
end subroutine

public function boolean of_abre_log (string as_nome_arquivo);String	lvs_Path

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If lvs_Path <> "" Then
	
	is_Arquivo_Log = lvs_Path + as_nome_arquivo + ".log"
	
	ii_log = FileOpen(is_Arquivo_Log, LineMode!, Write!, LockWrite!)
	
	If ii_log = -1 Then		
		Return False
	End If
Else
	Return False
End If

Return True
end function

public function boolean of_monta_xml_item (datastore ps_ds, long pl_linha, ref string as_xml, ref string as_log);String ls_Log
String ls_XML_Item
String ls_CD_PRODUTO_SAP
String ls_CD_FORNECEDOR_SAP
String ls_CD_PRODUTO_DISTRIB
String ls_QT_EMB_PDR_DISTRIB
String ls_QT_EST_DISPONIVEL
String ls_DT_ATUALZ_DISTRIB
String ls_VL_PRECO
String ls_PC_DESCONTO
String ls_VL_REPASSE_ICMS
String ls_VL_ICMS_ST
String ls_VL_COMPRA
String ls_NR_DIAS_PAGAMENTO
String ls_ID_SITUACAO
String ls_ID_SITUACAO_ANTERIOR
String ls_PC_ICMS
String ls_PC_REDUCAO_BASE_ICMS
String ls_VL_BASE_ICMS
String ls_VL_ICMS
String ls_PC_DESCONTO_FINANCEIRO
String ls_PC_COMISSAO_MIDIA
String ls_VL_JUROS
String ls_VL_PRECO_ORDEM
String ls_VL_PRECO_VENDA
String ls_DH_ATUALIZ_ESTOQUE

Long al_produto, ll_qt_embalagem_padrao_distribuidora
String lvs_UF
String lvs_Distribuidora


Decimal	ldc_VL_REPASSE_ICMS
Decimal	ldc_VL_PRECO_ORDEM
Decimal	ldc_PC_DESCONTO_FINANCEIRO
Decimal  ldc_PC_COMISSAO  
Decimal	ldc_VL_JUROS
Decimal	ldc_VL_PRECO_VENDA
Decimal	ldc_VL_ICMS_ST
Decimal	ldc_VL_BASE_ICMS
Decimal	ldc_VL_ICMS
Decimal	ldc_VL_PRECO
Decimal	ldc_VL_COMPRA
Decimal	ldc_PC_DESCONTO
Decimal	ldc_VL_PRECO_LIQUIDO
Decimal	ldc_PC_REDUCAO_BASE_ICMS



Try 
	al_produto							= ps_ds.Object.CD_PRODUTO [pl_linha]
	lvs_UF								= ps_ds.Object.CD_UF [pl_linha]
	lvs_Distribuidora					= ps_ds.Object.CD_DISTRIBUIDORA [pl_linha]
	ls_CD_FORNECEDOR_SAP				= String(ps_ds.Object.CD_FORNECEDOR_SAP [pl_linha])
	ls_CD_PRODUTO_SAP 				= ps_ds.Object.CD_PRODUTO_SAP [pl_linha]
	ldc_PC_REDUCAO_BASE_ICMS		= ps_ds.Object.PC_REDUCAO_BASE_ICMS[pl_linha]
	
	If IsNull(ls_CD_FORNECEDOR_SAP) Then Return False
	If IsNull(lvs_UF) Then Return False
	If IsNull(ls_CD_PRODUTO_SAP) Then Return False

	// Busca Campos na View
	If Not This.of_localiza_dados_view(al_produto,&
												 lvs_UF,&
												 lvs_Distribuidora,& 
												 Ref ldc_VL_REPASSE_ICMS,&
												 Ref ldc_VL_PRECO_ORDEM,&
												 Ref ldc_PC_DESCONTO_FINANCEIRO,&
												 Ref ldc_VL_PRECO_ORDEM,&
												 Ref ldc_VL_JUROS,&
												 Ref ldc_VL_PRECO_VENDA,&
												 Ref ldc_VL_ICMS_ST,&
												 Ref ldc_VL_BASE_ICMS,&
												 Ref ldc_VL_ICMS,&
												 Ref ls_log) 	 Then 																											

		Return False		
	End If 
	
	
	If IsNull(ldc_VL_REPASSE_ICMS) Then ldc_VL_REPASSE_ICMS = 0.00 
	If IsNull(ldc_VL_PRECO_ORDEM) Then ldc_VL_PRECO_ORDEM = 0.00 
	If IsNull(ldc_PC_DESCONTO_FINANCEIRO) Then ldc_PC_DESCONTO_FINANCEIRO = 0.00 
	If IsNull(ldc_VL_PRECO_ORDEM) Then ldc_VL_PRECO_ORDEM = 0.00 
	If IsNull(ldc_VL_JUROS) Then ldc_VL_JUROS = 0.00 
	If IsNull(ldc_VL_PRECO_VENDA) Then ldc_VL_PRECO_VENDA = 0.00 
	If IsNull(ldc_VL_ICMS_ST) Then ldc_VL_ICMS_ST = 0.00 
	If IsNull(ldc_VL_BASE_ICMS) Then ldc_VL_BASE_ICMS = 0.00 	
	If IsNull(ldc_VL_ICMS) Then ldc_VL_ICMS = 0.00 	

	ldc_VL_PRECO	= ps_ds.Object.VL_PRECO[pl_linha]
	
	ll_qt_embalagem_padrao_distribuidora	= ps_ds.Object.QT_EMB_PDR_DISTRIB[pl_linha]
	
	ldc_PC_DESCONTO	= ps_ds.Object.PC_DESCONTO[pl_linha]
	
	ldc_VL_PRECO_LIQUIDO	= round( ldc_VL_PRECO * ((100 -  ldc_PC_DESCONTO ) / 100), 2)
		
	ldc_VL_BASE_ICMS	= (ldc_VL_PRECO_LIQUIDO - ldc_VL_REPASSE_ICMS) * (( 100 - ldc_PC_REDUCAO_BASE_ICMS ) / 100)
	
	ldc_VL_COMPRA	= ((ldc_VL_PRECO_LIQUIDO - ldc_VL_REPASSE_ICMS) + ldc_VL_ICMS_ST) / ll_qt_embalagem_padrao_distribuidora
	
	// Trata os campos
	ls_VL_REPASSE_ICMS			= gf_Valor_Com_Ponto(ldc_VL_REPASSE_ICMS) 
	ls_VL_PRECO_ORDEM				= gf_Valor_Com_Ponto(ldc_VL_PRECO_ORDEM) 
	ls_PC_DESCONTO_FINANCEIRO= gf_Valor_Com_Ponto(ldc_PC_DESCONTO_FINANCEIRO) 
	ls_VL_JUROS						= gf_Valor_Com_Ponto(ldc_VL_JUROS) 
	ls_VL_PRECO_VENDA				= gf_Valor_Com_Ponto(ldc_VL_PRECO_VENDA) 
	ls_VL_ICMS_ST					= gf_Valor_Com_Ponto(ldc_VL_ICMS_ST) 
	ls_VL_BASE_ICMS					= gf_Valor_Com_Ponto(ldc_VL_BASE_ICMS) 
	ls_VL_ICMS							= gf_Valor_Com_Ponto(ldc_VL_ICMS) 
	
	ls_CD_PRODUTO_DISTRIB 		= ps_ds.Object.CD_PRODUTO_DISTRIBUIDORA[pl_linha]
	ls_QT_EST_DISPONIVEL			= String(ps_ds.Object.QT_EST_DISPONIVEL[pl_linha])	
	ls_QT_EMB_PDR_DISTRIB		= String(ll_qt_embalagem_padrao_distribuidora)	
		
	ls_DT_ATUALZ_DISTRIB 			= String(ps_ds.Object.DT_ATUALZ_DISTRIB[pl_linha])   
	ls_NR_DIAS_PAGAMENTO 		= String(ps_ds.Object.NR_DIAS_PAGAMENTO[pl_linha])	
	ls_VL_PRECO 						= gf_Valor_Com_Ponto(ldc_VL_PRECO) 
	ls_PC_DESCONTO 					= gf_Valor_Com_Ponto(ldc_PC_DESCONTO) 
	ls_VL_COMPRA						= gf_Valor_Com_Ponto(ldc_VL_COMPRA) 
	ls_ID_SITUACAO 					= ps_ds.Object.ID_SITUACAO[pl_linha]
	ls_ID_SITUACAO_ANTERIOR 	= ps_ds.Object.ID_SITUACAO_ANTERIOR[pl_linha]
	ls_PC_ICMS							= gf_Valor_Com_Ponto(ps_ds.Object.PC_ICMS[pl_linha]) 
	ls_PC_REDUCAO_BASE_ICMS	= gf_Valor_Com_Ponto(ldc_PC_REDUCAO_BASE_ICMS) 
	ls_PC_COMISSAO_MIDIA			= gf_Valor_Com_Ponto(ps_ds.Object.PC_COMISSAO_MIDIA[pl_linha]) 
	ls_DH_ATUALIZ_ESTOQUE 		= String(ps_ds.Object.DH_ATUALIZ_ESTOQUE[pl_linha])
	
	If IsNull(ls_DH_ATUALIZ_ESTOQUE)  or ls_DH_ATUALIZ_ESTOQUE='' Then ls_DH_ATUALIZ_ESTOQUE = "01/01/1900 00:00:00" 
	If IsNull(ls_DT_ATUALZ_DISTRIB)  or ls_DT_ATUALZ_DISTRIB='' Then ls_DT_ATUALZ_DISTRIB = "01/01/1900 00:00:00" 
	
	If IsNull(ls_QT_EST_DISPONIVEL) or ls_QT_EST_DISPONIVEL ='' Then ls_QT_EST_DISPONIVEL = '0' 
	If IsNull(ls_NR_DIAS_PAGAMENTO) or ls_NR_DIAS_PAGAMENTO ='' Then ls_NR_DIAS_PAGAMENTO = '0' 
	If IsNull(ls_VL_PRECO) or ls_VL_PRECO=''  Then ls_VL_PRECO = '0.00' 
	If IsNull(ls_VL_COMPRA) or ls_VL_COMPRA=''  Then ls_VL_COMPRA ='0.00' 
	If IsNull(ls_PC_COMISSAO_MIDIA)  or  ls_PC_COMISSAO_MIDIA=""  or len(ls_PC_COMISSAO_MIDIA)<=1  Then 
		ls_PC_COMISSAO_MIDIA ='0.00' 
	End If
	
	If IsNull(ls_PC_ICMS) or  ls_PC_ICMS ='' Then ls_PC_ICMS ='0.00' 
	If IsNull(ls_VL_ICMS) or ls_VL_ICMS='' Then ls_VL_ICMS ='0.00' 
	If IsNull(ls_VL_PRECO_ORDEM) or ls_VL_PRECO_ORDEM='' Then ls_VL_PRECO_ORDEM ='0.00' 
	If IsNull(ls_VL_JUROS) or ls_VL_JUROS='' Then ls_VL_JUROS ='0.00' 
	If IsNull(ls_VL_ICMS) or ls_VL_ICMS='' Then ls_VL_ICMS ='0.00' 
	
	as_xml +=		'<CD_PRODUTO_SAP>' + ls_CD_PRODUTO_SAP + '</CD_PRODUTO_SAP>'+&
						'<CD_PRODUTO_DISTRIB>'+ ls_CD_PRODUTO_DISTRIB + '</CD_PRODUTO_DISTRIB>'+&
						'<QT_EMB_PRD_DISTRIB>'+ls_QT_EMB_PDR_DISTRIB+'</QT_EMB_PRD_DISTRIB>'+&
						'<QT_EST_DISPONIVEL>'+ls_QT_EST_DISPONIVEL+'</QT_EST_DISPONIVEL>'+&
						'<DT_ATUALIZ_DISTRIB>'+ls_DT_ATUALZ_DISTRIB +'</DT_ATUALIZ_DISTRIB>'+&
						'<VL_PRECO>'+ls_VL_PRECO +'</VL_PRECO>'+&
						'<PC_DESCONTO>'+ls_PC_DESCONTO +'</PC_DESCONTO>'+&
						'<VL_REPASSE_ICMS>'+ls_VL_REPASSE_ICMS + '</VL_REPASSE_ICMS>'+&
						'<VL_ICMS_ST>'+ls_VL_ICMS_ST + '</VL_ICMS_ST>'+&						
						'<VL_COMPRA>'+ls_VL_COMPRA + '</VL_COMPRA>'+&
						'<NR_DIAS_PAGAMENTO>'+ls_NR_DIAS_PAGAMENTO + '</NR_DIAS_PAGAMENTO>'+&
						'<ID_SITUACAO>'+ls_ID_SITUACAO + '</ID_SITUACAO>'+&
						'<ID_SITUACAO_ANTERIOR>'+ls_ID_SITUACAO_ANTERIOR+'</ID_SITUACAO_ANTERIOR>'+&
						'<PC_ICMS>'+ls_PC_ICMS+'</PC_ICMS>'+&
						'<PC_REDUCAO_BASE_ICMS>'+ls_PC_REDUCAO_BASE_ICMS + '</PC_REDUCAO_BASE_ICMS>'+&
						'<VL_BASE_ICMS>'+ls_VL_BASE_ICMS + '</VL_BASE_ICMS>'+&					
						'<VL_ICMS>'+ls_VL_ICMS + '</VL_ICMS>'+&			
						'<PC_DESCONTO_FINANCEIRO>'+'0.00'+ '</PC_DESCONTO_FINANCEIRO>'+&
						'<PC_COMISSAO_MIDIA>'+ls_PC_DESCONTO_FINANCEIRO+ '</PC_COMISSAO_MIDIA>'+&
						'<VL_JUROS>'+ls_VL_JUROS + '</VL_JUROS>'+&
						'<VL_PRECO_ORDEM>'+ls_VL_PRECO_ORDEM + '</VL_PRECO_ORDEM>'+&
						'<VL_PRECO_VENDA>'+ls_VL_PRECO_VENDA + '</VL_PRECO_VENDA>'+&
						'<DH_ATUALIZACAO_ESTOQUE>'+ls_DH_ATUALIZ_ESTOQUE + '</DH_ATUALIZACAO_ESTOQUE>'

Catch (RuntimeError lo_rte)
	as_log = "Erro ao recuperar os dados da DataStore [" + is_DS + "]', objeto [" + is_Objeto + "]. Erro: " + lo_rte.GetMessage()
	Return False
End try
							
Return True



	


           

end function

public subroutine of_processa_envio (long pl_nr_atualizacao);Long ll_Log
Long ll_Linha
Long ll_Linhas
Long ll_Linha_uf
Long ll_Linhas_uf
Long ll_Contador, ll_cd_produto, ll_progresso_geral
integer li_contador_xml =100
String ls_log, ls_cd_uf
String ls_cd_uf_aux, ls_cd_fornecedor_aux

String ls_Parametro_URL
String ls_Tipo_Log_Exp
String ls_Descricao_Tipo_Log
String ls_Grava_XML
String ls_Nome_Interface
String ls_Cd_Fornecedor
String ls_XML_Item
String ls_XML
String ls_Xml_Retorno
String ls_Chave

String ls_XML_Cabecalho 

String ls_LOG_XML
Decimal{2} ldc_divisao
long ll_qt_envios, ll_nr_xml=1

ls_Parametro_URL 		= 'CD_URL_DISTRIBUIDORA_PRODUTO'
ls_Tipo_Log_Exp 			= 'DIS'
ls_Descricao_Tipo_Log	= 'DISTRIBUIDORA_PRODUTO'
ls_Nome_Interface 		= 'DISTRIBUIDORA_PRODUTO'

dc_uo_ds_base lds, lds_aux, lds_aux_uf

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log )

gvs_Log_Geral = ''

ls_Grava_XML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "Grava_XML", "")

Try 
	lds = Create dc_uo_ds_base
	lds_aux = Create dc_uo_ds_base
	lds_aux_uf = Create dc_uo_ds_base
	
	ll_Log = FileLength(is_Arquivo_Log)
	
	If Not of_ambiente_sap(ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
		
	If Not lds.of_ChangeDataObject(is_DS, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS + "' - " + is_Objeto, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not lds_aux.of_ChangeDataObject(is_DS, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS + "' - " + is_Objeto, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not lds_aux_uf.of_ChangeDataObject(is_DS_UF, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS_UF + "' - " + is_Objeto, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	End If
		
	
	If Not gf_retorna_pametro_sap(SQLCA, is_Ambiente_SAP, ls_Parametro_URL, ref is_URL, ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
	
	/// UF / Fornecedor
	ll_Linhas_Uf = lds_aux_uf.Retrieve()	


	// Entra se Tem Registros
	If ll_Linhas_Uf > 0  Then 		
		For ll_Linha_Uf = 1 to ll_Linhas_Uf
			// Limpa
			ls_XML = ""
			ls_XML_Item = ""
			ls_XML_Cabecalho		=	""
			
			// Para Carregando....
			If Not IsValid(w_aguarde) then
				Open(w_aguarde)
			End If	
			
			// Chave  UF / Fornecedor
			ls_cd_uf_aux = lds_aux_uf.object.cd_uf [ll_Linha_Uf]
			ls_cd_fornecedor_aux =   lds_aux_uf.object.cd_fornecedor_sap[ll_Linha_Uf]
			// Retrieve por UF/Fornecedor		
			ll_Linhas = lds.Retrieve(ls_cd_uf_aux,ls_cd_fornecedor_aux)
					
			w_aguarde.Title = "Distribuidora(F5) Produto UF:"
			w_aguarde.uo_progress.of_reset()
			w_aguarde.uo_progress.Of_SetMax(ll_Linhas)	
			
			If ll_Linhas > 0 Then 				
				// Limap os dados   					
				If Not This.of_monta_xml_cabecalho(ls_cd_uf_aux, Ref ls_XML_Cabecalho, Ref  ls_log, ls_cd_fornecedor_aux  ) Then 
					lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
					Return			
				End If 				
			Else
				Continue
			End If 

			If ls_XML_Cabecalho =""  or IsNull(ls_XML_Cabecalho) Then 
				lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
				Return	
			End If 
			
			// Se Tem Registros 
			If ll_Linhas > 0 Then					
				//Calcula quantos XML ser$$HEX1$$e300$$ENDHEX$$o enviados.
				ldc_divisao = ll_linhas / li_contador_xml
				ll_qt_envios = integer(ldc_divisao)
				
				If ll_qt_envios - ldc_divisao > 0 Then
					ll_qt_envios ++
				End if
				
				If ldc_divisao > ll_qt_envios Then
					ll_qt_envios++
				End if	
			
				/// Itens da UF / Fornecedor 
				For ll_Linha = 1 To ll_Linhas	
					// Se n$$HEX1$$e300$$ENDHEX$$o possuir o fornecedor ou produto do SAP n$$HEX1$$e300$$ENDHEX$$o envia o produto
					If IsNull(lds.Object.cd_fornecedor_sap[ll_Linha]) or IsNull(lds.Object.cd_uf[ll_Linha]) Then						
						Continue
					End If		
					
					w_aguarde.Title = "Distribuidora(F5) UF:"+String(ls_cd_uf_aux) + "/Distrib:"+String(ls_cd_fornecedor_aux)+" Linha:"+ String(ll_Linha)+" De :"+String(ll_Linhas)									
					
					// Abre Item
					ls_XML_Item +=	'<ITEM>'
					If Not This.of_monta_xml_item(lds, ll_Linha, ref ls_XML_Item, Ref ls_log) Then 
						lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
						Return
					End If			
					// Fecha Item
					ls_XML_Item +=	is_Termino_Item 
					
					// Valida Item 
					If IsNull(ls_XML_Item) or Trim(ls_XML_Item) = '' Then
						lf_ge470_log("Erro: Alguma informa$$HEX2$$e700e300$$ENDHEX$$o do produto '"+ string(lds.object.cd_produto[ll_Linha]) + "' anulou o XML de envio." , 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
						Return
					End If		
					
					//ATIVAR DEPOIS
					If Not This.of_atualiza_processado(lds.object.cd_produto[ll_Linha],&
																 lds.object.cd_uf[ll_Linha],&
																 lds.object.cd_distribuidora[ll_Linha],&
																 ref ls_Log) Then
						lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
						Return
					End If
					
					ll_Contador ++
					
					//Alimenta a datastore para gravar na log_exportacao_sap.
					lds.rowscopy( ll_linha, ll_linha, primary!, lds_aux, 1, primary!)
					
					If  ll_Contador >= li_contador_xml or ll_Linha = ll_Linhas Then
						If Not this.of_grava_log_exportacao( lds_aux, ref ls_log) Then
							lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
							Return
						End If
						
						lds_aux.reset()
						
						
						If IsNull(is_Inicio_XML) or is_Inicio_XML="" or len(is_Inicio_XML)<=1 Then 
							lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
							Return	
						End If 
						
						If IsNull(ls_XML_Cabecalho) or ls_XML_Cabecalho="" or len(ls_XML_Cabecalho)<=1 Then 
							lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
							Return	
						End If 
						
						If IsNull(ls_XML_Item) or ls_XML_Item="" or len(ls_XML_Item)<=1 Then 
							lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
							Return	
						End If 
											
						If IsNull(is_Termino_XML) or is_Termino_XML="" or len(is_Termino_XML)<=1 Then 
							lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
							Return	
						End If 
												
						
						// Fecha o XML
						ls_XML +=  is_Inicio_XML
						ls_XML +=  ls_XML_Cabecalho
						ls_XML +=  ls_XML_Item
						ls_XML +=  is_Termino_Cabecalho		
						ls_XML +=  is_Termino_XML
												
						If ls_Grava_XML = "S" Then
							ls_Chave = String(lds.object.cd_uf[ll_Linha])+'_'+String(lds.object.cd_distribuidora[ll_Linha])							
							This.of_grava_xml(ls_XML, ls_Chave )
						End If
						
						If io_sap_comum.of_Envia_Webservice(is_URL, ls_XML, Ref ls_Xml_Retorno, Ref ls_log) Then
							SqlCa.of_Commit()
						Else
							SqlCa.of_Rollback()
							lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
						End If					
						
						ll_Contador 		= 0
						
						// Para Carregando
						w_aguarde.uo_progress.Of_SetProgress(ll_Linhas)																					
						
						ll_nr_xml++						
						
						// Fecha o XML
						ls_XML_Item = ""
						ls_XML	= ""
						//Exit
					End If		
				
					// Para Carregando
					w_aguarde.uo_progress.Of_SetProgress(ll_Linha)																					
				Next						
			ElseIf ll_Linhas < 0 Then
				lf_ge470_log("Erro ao recuperar os dados da DW [" + is_DS + "] - " + is_Objeto + ".", 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
				Return
			End If			
		Next
	End If 	
catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o [" + is_DS + "], objeto ["+ is_Objeto +"]. Erro: "+lo_rte.GetMessage())
	Return
finally
	If Not gvb_Auto Then
		If FileLength(is_Arquivo_Log) > ll_Log Then
			dc_uo_api lo_api
			lo_api =Create dc_uo_api
			lo_api.of_Shell_execute('notepad.exe', is_Arquivo_Log)
			Destroy(lo_api)
		Else
			//MessageBox('Sucesso!','Os procedimentos foram executados sem erros! ',Information!,Ok!)
		End If
	Else
		If gvs_Log_Geral <> '' Then lf_ge470_email_log(gvs_Log_Geral,1)
	End If
	
	If IsValid(lds) Then Destroy lds
	If IsValid(lds_aux) Then Destroy lds_aux
	If IsValid(lds_aux_uf) Then Destroy lds_aux_uf
End Try
end subroutine

public function boolean of_busca_chave_log_exp (long pl_nr_atualizacao, ref long pl_cd_produto, ref string ps_cd_uf, ref string ps_log);string ls_chave

Select cd_produto, cd_chave
into :pl_cd_produto, :ls_chave
from log_exportacao_sap
where nr_atualizacao = :pl_nr_atualizacao;

if sqlca.sqlcode = -1 then 
	ps_log = 'Problemas ao consultar a tabela "log_exportacao_sap": ' + sqlca.sqlerrtext
	return false
end if

ps_cd_uf = Right(ls_chave,2)

Return True
end function

public function boolean of_grava_log_exportacao (datastore ps_ds, ref string ps_log);String ls_erro, ls_nr_atualizacao
String ls_Chave
Long ll_for, ll_nr_atualizacao

String ls_CD_PRODUTO_SAP
String ls_CD_FORNECEDOR_SAP
String ls_CD_PRODUTO_DISTRIB
String ls_ID_SITUACAO
String ls_ID_SITUACAO_ANTERIOR
String ls_CD_UF
DateTime  ldt_DT_ATUALZ_DISTRIB
DateTime  ldt_DH_ATUALIZ_ESTOQUE
Date 		  ldt_Data

Long  ll_QT_EMB_PDR_DISTRIB
Long  ll_QT_EST_DISPONIVEL
Long  ll_NR_DIAS_PAGAMENTO
Long  ll_cd_produto

Decimal{2}  ldc_VL_PRECO
Decimal{2}  ldc_PC_DESCONTO
Decimal{2}  ldc_VL_REPASSE_ICMS
Decimal{2}  ldc_VL_ICMS_ST
Decimal{2}  ldc_VL_COMPRA
Decimal{2} ldc_PC_ICMS
Decimal{2}  ldc_PC_REDUCAO_BASE_ICMS
Decimal{2}  ldc_VL_BASE_ICMS
Decimal{2}  ldc_VL_ICMS
Decimal{2}  ldc_PC_DESCONTO_FINANCEIRO
Decimal{2}  ldc_PC_COMISSAO_MIDIA
Decimal{2}  ldc_VL_JUROS
Decimal{2}  ldc_VL_PRECO_ORDEM
Decimal{2}  ldc_VL_PRECO_VENDA



uo_ge473_comum luo_comum
str_log_export_sap lst_info

Try
	
	ldt_Data	=	Date(gf_getserverdate())
	
	Declare sp_log Procedure for sp_log_exportacao_sap_prox_seq
	 @proximo_sequencial_retorno  = :ll_nr_atualizacao OUTPUT,
	 @mensagem_retorno = :ls_erro OUTPUT
	 USING SQLCA;
		
	Execute sp_log;
		
	If sqlca.sqlcode = -1 then 
		ps_log = 'Erro ao executar a procedure "SP_LOG_EXPORTACAO_SAP_PROX_SEQ" (of_grava_log_exportacao): ' + sqlca.sqlerrtext 
		return false
	end if
		
	Fetch sp_log Into :ll_nr_atualizacao, :ls_erro;
	
	Close sp_log;
	
	if ll_nr_atualizacao = -1 then
		ps_log = 'Erro ao executar a procedure "sp_log_exportacao_prox_seq" (of_grava_log_exportacao): ' + ls_erro
		return false
	end if

	ls_CD_UF = ps_ds.object.CD_UF[1]		
	ls_CD_FORNECEDOR_SAP =  ps_ds.object.cd_fornecedor_sap[1]		
	ls_Chave  = ls_CD_UF+'/'+ls_CD_FORNECEDOR_SAP


	insert into log_exportacao_sap(nr_atualizacao,
											id_tipo_nf,	
											id_tipo_log,
											dh_exportacao,
											cd_empresa,
											id_situacao_docto,
											id_status_integracao,
											cd_ambiente_sap, 
											cd_filial, 
											cd_chave,
											cd_tipo_documento)
	Values( :ll_nr_atualizacao,
				'DIS',
				69,
				getdate(),
				1000,
				'C',
				'P',
				:is_Ambiente_SAP, 
				534, 
				:ls_Chave,
				'DIS');
				
					
	If sqlca.sqlcode = -1 then 
		ps_log = 'Erro ao inserir registro na tabela "LOG_EXPORTACAO_SAP" (of_grava_log_exportacao): ' + sqlca.sqlerrtext
		Return False
	End if
	
	ls_nr_atualizacao = string(ll_nr_atualizacao)
	
	For ll_for = 1 to ps_ds.rowcount()
		ls_CD_PRODUTO_SAP 				= ps_ds.object.cd_produto_sap[ll_for]		
		ls_CD_FORNECEDOR_SAP 			= ps_ds.object.cd_fornecedor_sap[ll_for]
		ll_cd_produto							= ps_ds.Object.CD_PRODUTO [ll_for]
		ldt_DH_ATUALIZ_ESTOQUE			= ps_ds.object.DH_ATUALIZ_ESTOQUE[ll_for]
	 	ldt_DT_ATUALZ_DISTRIB				= ps_ds.object.DT_ATUALZ_DISTRIB[ll_for]
		ll_QT_EMB_PDR_DISTRIB			= ps_ds.object.QT_EMB_PDR_DISTRIB[ll_for]
		ll_QT_EST_DISPONIVEL				= ps_ds.object.QT_EST_DISPONIVEL[ll_for]
		ll_NR_DIAS_PAGAMENTO			= ps_ds.object.nr_dias_pagamento[ll_for]
		
		ldc_VL_ICMS_ST						= ps_ds.object.vl_icms_st[ll_for]
		ldc_VL_COMPRA						= ps_ds.object.vl_compra[ll_for]
	 	
		ls_ID_SITUACAO						= ps_ds.object.id_situacao[ll_for]
		ls_ID_SITUACAO_ANTERIOR		= ps_ds.object.id_situacao_anterior[ll_for]
		ldc_PC_ICMS							= ps_ds.object.pc_icms[ll_for]
		ldc_PC_REDUCAO_BASE_ICMS		= ps_ds.object.pc_reducao_base_icms[ll_for]
		ldc_VL_BASE_ICMS					= ps_ds.object.vl_base_icms[ll_for]
		
		ldc_PC_DESCONTO_FINANCEIRO	= ps_ds.object.PC_DESCONTO_FINANCEIRO[ll_for]
		ldc_PC_COMISSAO_MIDIA			= ps_ds.object.pc_comissao_midia[ll_for]
		ldc_VL_PRECO							= ps_ds.object.vl_preco[ll_for]
		ldc_PC_DESCONTO					= ps_ds.object.pc_desconto[ll_for]
		ldc_VL_PRECO_ORDEM				= ps_ds.object.VL_MELHOR_COMPRA[ll_for]
		ldc_VL_PRECO_VENDA				= ps_ds.object.VL_PRECO_ATUAL[ll_for]
		 

	
	
	
			
		Insert Into log_exportacao_sap_historico( nr_atualizacao,
															nr_documento,
															dh_documento,
															nr_item,
															cd_fornecedor_sap,
															cd_produto_sap,
															vl_preco_bruto,
															pc_desconto_normal,
															pc_repasse_icms,
															vl_repasse_icms,
															vl_preco_liquido,
															pc_desconto_financeiro,
															pc_desconto_midia,
															vl_icms_st,
															vl_valor_decrescimo,
															vl_final,
															nr_dias_pagamento,
															id_tipo_conta,
															vl_documento,
															cd_produto, 
															qt_estoque_produto,
															cd_filial,
															nr_documento_sap)
					Values(:ll_nr_atualizacao,
							:ls_nr_atualizacao,
							getdate(), 
							:ll_for,
							:ls_cd_fornecedor_sap,
							:ls_cd_produto_sap,
							:ldc_VL_PRECO,
							:ldc_PC_DESCONTO,
							:ldc_PC_ICMS,
							:ldc_VL_REPASSE_ICMS,
							:ldc_VL_PRECO_ORDEM,
							:ldc_PC_DESCONTO_FINANCEIRO,
							:ldc_PC_COMISSAO_MIDIA,
							:ldc_vl_icms_st,
							:ldc_VL_JUROS,
							:ldc_VL_PRECO_VENDA,
							:ll_NR_DIAS_PAGAMENTO,
							'X', 
							0,
							:ll_cd_produto,
							:ll_QT_EST_DISPONIVEL,
							534,
							:ls_Chave);
		
				If sqlca.sqlcode = -1 Then 
					ps_log = 'Erro ao inserir registro na tabela "LOG_EXPORTACAO_SAP_HISTORICO" (of_grava_log_exportacao): ' + sqlca.sqlerrtext
					Return false
				End if
	Next
Finally

End Try

Return True
end function

public function boolean of_atualiza_processado (long al_produto, string as_uf, string as_distribuidora, ref string as_log);update distribuidora_produto
set		  dh_exportacao_sap = getdate()
where  cd_produto = :al_produto
and	  cd_unidade_federacao = :as_uf
and	  cd_distribuidora=:as_distribuidora
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento distrib_produto_melhor_compra 'of_marca_produto_exportar': " + SqlCa.SqlerrText
	Return False
End If

Return True

end function

public subroutine of_grava_xml (string as_xml, string as_chave);String lvs_Path, lvs_Log

Integer li_Log

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If lvs_Path <> "" Then
	
	lvs_Log = lvs_Path + "\"+is_nome_arquivo+"_"+String(as_chave)+"_"+String(year(today()), "0000") + String(Month(today()), "00") + String(Day(today()), "00") + "_" + String(Hour(Now()), "00") +  String(Minute(Now()), "00") + String(Second ( Now() ), "00") +  ".xml"
	
	li_Log = FileOpen(lvs_Log, StreamMode!, Write!, LockReadWrite!, Replace!, EncodingUTF8!)
	
	If li_Log = -1 Then
		If Not gvb_Auto Then			
			Return
		End If
	End If
	
	If FileWrite(li_Log, as_xml) < 0 Then
		If Not gvb_Auto Then
			Return
		End If
	End If
	
	FileClose (li_Log)
Else
	If Not gvb_Auto Then
		Return
	End If
End If

end subroutine

public function boolean of_monta_xml_cabecalho (string as_cd_uf, ref string as_cabecalho, ref string as_log, string as_fornecedor_sap);String	ls_XML_Cabecalho



ls_XML_Cabecalho = 	'<CD_UNIDADE_FEDERACAO>' +as_cd_uf+'</CD_UNIDADE_FEDERACAO>'+&		
							'<CD_FORNECEDOR_SAP>' +as_fornecedor_sap+'</CD_FORNECEDOR_SAP>'
							
If IsNull(ls_XML_Cabecalho) Then 
	as_log = "Erro de Cabe$$HEX1$$e700$$ENDHEX$$alho"
	Return False
End If 

as_cabecalho = ls_XML_Cabecalho

Return True 
end function

public function boolean of_localiza_dados_view (long al_produto, string as_uf, string as_distribuidora, ref decimal ldc_vl_repasse, ref decimal ldc_vl_compra, ref decimal ldc_pc_desconto_financeiro, ref decimal ldc_vl_melhor_compra, ref decimal ldc_vl_juros_decrescimo_dist, ref decimal ldc_vl_preco_atual, ref decimal ldc_vl_icms_st, ref decimal ldc_vl_base_icms, ref decimal ldc_vl_icms, ref string as_log);long  al_Filial

Select  min(f.cd_filial)
Into :al_Filial 
From   filial f
Inner join cidade c  on c.cd_cidade  = f.cd_cidade 
Where f.id_situacao  = 'A'
And   f.cd_filial not in  (1,2,534)  
And   c.cd_unidade_federacao=:as_uf
Using SqlCA;

If sqlca.sqlcode = -1 then 
	as_log = 'Problemas ao consultar a tabela "filial de referencia": ' + sqlca.sqlerrtext
	Return False
End If

Select  vl_repasse,
          vl_compra,
          pc_desconto_financeiro,
          vl_melhor_compra,
          vl_juros_decrescimo_dist,
          vl_preco_atual,
         vl_icms_st,
		 round(( cast(vl_compra as decimal(9,2)) -   cast(vl_repasse as decimal(9,2) ) ) * (( 100 -  pc_reducao_icms ) / 100 ), 2),
		 vl_icms
Into 	:ldc_vl_repasse,
		:ldc_vl_compra,
		:ldc_pc_desconto_financeiro,
		:ldc_vl_melhor_compra,
		:ldc_vl_juros_decrescimo_dist,
		:ldc_vl_preco_atual,
		:ldc_vl_icms_st,
		:ldc_vl_base_icms,
		:ldc_vl_icms
From vw_preco_distribuidora
Where cd_produto               =:al_produto 
And cd_unidade_federacao  =:as_uf
And cd_distribuidora            =:as_distribuidora
And cd_filial                 	     =:al_Filial
Using SqlCA;

If sqlca.sqlcode = -1 then 
	as_log = 'Problemas ao consultar a tabela "vw_preco_distribuidora": ' + sqlca.sqlerrtext
	Return False
End If


Return True 
end function

on uo_ge481_distribuidora_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge481_distribuidora_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_Abre_Log(is_nome_arquivo)

io_sap_comum = Create uo_ge470_sap_comum

is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_CadastroProdutoDistribuidora_Request>'
							
is_Termino_XML	=	'</imp:MT_CadastroProdutoDistribuidora_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
							

end event

event destructor;Destroy(io_sap_comum)

FileClose(ii_Log)
end event

