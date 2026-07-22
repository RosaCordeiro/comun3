HA$PBExportHeader$uo_ge481_is_melhor_compra.sru
forward
global type uo_ge481_is_melhor_compra from nonvisualobject
end type
end forward

global type uo_ge481_is_melhor_compra from nonvisualobject
end type
global uo_ge481_is_melhor_compra uo_ge481_is_melhor_compra

type variables
uo_ge470_sap_comum io_sap_comum

String is_Origem_Legado 		= "SYBASE"
Integer ii_Empresa				= 1000
String is_Termino_Cabecalho 	= '</I_CABECALHO>'
String is_Termino_Item 			= '</I_ITEM>'
String is_URL
String is_Inicio_XML
String is_Termino_XML
String is_Arquivo_Log
String is_Ambiente_SAP

String is_DS 				= 'ds_ge481_mc_produtos'
String is_Objeto 			= 'uo_ge481_is_melhor_compra'
String is_nome_arquivo 	= 'melhor_compra_distribuidora'

Integer	ii_log




end variables

forward prototypes
public function string of_monta_xml_cabecalho (string as_empresa, string as_nr_atualizacao, string as_dt_documento, string as_dt_contabilizacao, string as_cd_tipo_documento, string as_nr_documento_referencia, string as_texto_documento, string as_cd_moeda)
private function boolean of_processa_retorno (string as_cliente, string as_xml_retorno, ref string as_erro)
public function boolean of_ambiente_sap (ref string as_log)
public subroutine of_processa_envio ()
public function boolean of_abre_log (string as_nome_arquivo)
public function boolean of_monta_xml_item (datastore ps_ds, long pl_linha, ref string as_xml, ref string as_log)
public subroutine of_grava_xml (string as_xml)
public function boolean of_marca_produto_exportar (ref string as_log)
public function boolean of_atualiza_processado (long al_produto, string as_uf, ref string as_log)
public subroutine of_processa_envio (long pl_nr_atualizacao)
public function boolean of_busca_chave_log_exp (long pl_nr_atualizacao, ref long pl_cd_produto, ref string ps_cd_uf, ref string ps_log)
public function boolean of_grava_log_exportacao (datastore ps_ds, ref string ps_log)
end prototypes

public function string of_monta_xml_cabecalho (string as_empresa, string as_nr_atualizacao, string as_dt_documento, string as_dt_contabilizacao, string as_cd_tipo_documento, string as_nr_documento_referencia, string as_texto_documento, string as_cd_moeda);String	ls_XML_Cabecalho

ls_XML_Cabecalho = '<I_CABECALHO>'+&
							'<BUKRS>'+as_Empresa+'</BUKRS>'+&
							'<BELNR_EXT>' +as_nr_atualizacao+'</BELNR_EXT>'+&
							'<BLDAT>'+as_dt_documento+'</BLDAT>'+&
							'<BUDAT>'+as_dt_contabilizacao+'</BUDAT>'+&
							'<BLART>'+as_cd_tipo_documento+'</BLART>'+&
							'<XBLNR>'+as_nr_documento_referencia+'</XBLNR>'+&
							'<BKTXT>'+as_texto_documento+'</BKTXT>'+&
							'<WAERS>'+as_cd_moeda+'</WAERS>'+&
							'<ZSIST_ORIGEM>'+is_Origem_Legado+'</ZSIST_ORIGEM>'+&
							'<ZFIM_ENVIO>X</ZFIM_ENVIO>'

// ZFIM_ENVIO => Foi criado porque o documento da folha de pagamento possui mais de 29.000 lan$$HEX1$$e700$$ENDHEX$$amentos
							
Return ls_XML_Cabecalho
end function

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

public function boolean of_monta_xml_item (datastore ps_ds, long pl_linha, ref string as_xml, ref string as_log);Decimal ldc_VL_Liquido, ldc_vl_icms, ldc_VL_Juros_Decrescimo, ldc_vl_melhor_compra
Long	ll_cd_produto
String ls_XML_Item
String ls_Fornecedor
String ls_Produto
String ls_Preco_Bruto
String ls_PC_Desconto_Atual
String ls_PC_Repasse
String ls_VL_Repasse
String ls_PC_Desconto_Financeiro
String ls_Preco_Liquido
String ls_PC_Desconto_Midia
String ls_VL_ST
String ls_VL_Juros_Decrescimo
String ls_VL_Final
String ls_Dias_Pagamento
String ls_VL_ICMS
String ls_fornecedor_legado
String ls_pc_desconto_sellin

try 
	ls_Fornecedor 	= ps_ds.Object.cd_fornecedor_sap[pl_linha]
	ls_Produto 		= ps_ds.Object.cd_produto_sap[pl_linha]
	
	ls_Preco_Bruto 				= gf_Valor_Com_Ponto(ps_ds.Object.vl_preco_atual[pl_linha])
	ls_PC_Desconto_Atual 		= gf_Valor_Com_Ponto(ps_ds.Object.pc_desconto_atual[pl_linha])
	ls_PC_Repasse					= gf_Valor_Com_Ponto(ps_ds.Object.pc_repasse_icms[pl_linha])
	ls_VL_Repasse					= gf_Valor_Com_Ponto(ps_ds.Object.vl_repasse_icms[pl_linha])
	ls_PC_Desconto_Financeiro 	= gf_Valor_Com_Ponto(ps_ds.Object.pc_desconto_financeiro[pl_linha])
	ls_PC_Desconto_Midia	 		= gf_Valor_Com_Ponto(ps_ds.Object.pc_desconto_midia[pl_linha])
	ls_VL_ST							= gf_Valor_Com_Ponto(ps_ds.Object.vl_icms_st[pl_linha])
	ls_VL_Juros_Decrescimo		= gf_Valor_Com_Ponto(ps_ds.Object.vl_juros_decrescimo_dist[pl_linha])
	ls_Dias_Pagamento				= gf_Valor_Com_Ponto(ps_ds.Object.nr_dias_pagamento[pl_linha])
	ls_pc_desconto_sellin		= gf_Valor_Com_Ponto(ps_ds.Object.pc_desconto_acordo_sellin[pl_linha])
	
	ldc_VL_Liquido 	= Round(ps_ds.Object.vl_preco_atual[pl_linha] * (1 - (ps_ds.Object.pc_desconto_atual[pl_linha] / 100)), 2) - ps_ds.Object.vl_repasse_icms[pl_linha]
	ls_Preco_Liquido 	= gf_Valor_Com_Ponto(ldc_VL_Liquido)
	
	select top 1 cd_produto
	  into :ll_cd_produto
	  from produto_geral
	 where cd_produto_sap	= :ls_Produto;
	 
	Choose Case SQLCA.SQLCode
		Case -1
			as_log = "Erro ao recuperar os dados do produto." + SQLCA.SQLErrtext
			return False
		Case 100
			as_log = "N$$HEX1$$e300$$ENDHEX$$o foram encontrados os dados do produto " + ls_Produto + "."
			return False
	End Choose
	
	select Top 1 cd_fornecedor
	  into :ls_fornecedor_legado
	  from fornecedor
	 where cd_fornecedor_sap	= :ls_Fornecedor;
	 
	Choose Case SQLCA.SQLCode
		Case -1
			as_log = "Erro ao recuperar os dados do fornecedor." + SQLCA.SQLErrtext
			return False
		Case 100
			as_log = "N$$HEX1$$e300$$ENDHEX$$o foram encontrados os dados do fornecedor " + ls_Produto + "."
			return False
	End Choose

	ldc_vl_icms = 0
	
	select round(round((((vl_preco_atual) * ((100 - pc_desconto_atual ) / 100)) - vl_repasse) * (( 100 - pc_reducao_icms) / 100 ), 2) * ((pc_icms) / 100), 2),
			 vl_juros_decrescimo_dist,
			 vl_melhor_compra
	  into :ldc_vl_icms,
	  		 :ldc_VL_Juros_Decrescimo,
			 :ldc_vl_melhor_compra
	  from vw_preco_distribuidora
    where cd_produto 		= :ll_cd_produto
	   and cd_filial 			= 13
		and cd_distribuidora	= :ls_fornecedor_legado
		and qt_estoque_disponivel >= 50;
		
	Choose Case SQLCA.SQLCode
		Case -1
			as_log = "Erro ao recuperar os dados de icms do produto." + SQLCA.SQLErrtext
			return False
	End Choose
	
	if IsNull(ldc_vl_melhor_compra) then ldc_vl_melhor_compra = 0
	
	ls_VL_Final	= gf_Valor_Com_Ponto(ldc_vl_melhor_compra)
	
	if IsNull(ldc_VL_Juros_Decrescimo) then ldc_VL_Juros_Decrescimo = 0
	
	ls_VL_Juros_Decrescimo	= gf_Valor_Com_Ponto(ldc_VL_Juros_Decrescimo)
	
	if ISNull(ldc_vl_icms) then ldc_vl_icms = 0
	
	ls_VL_ICMS	= gf_Valor_Com_Ponto(ldc_vl_icms)
	
	as_xml +=		'<cd_fornecedor_sap>' + ls_Fornecedor + '</cd_fornecedor_sap>'+&
						'<cd_produto_sap>'+ ls_Produto + '</cd_produto_sap>'+&
						'<vl_preco_bruto>' + ls_Preco_Bruto + '</vl_preco_bruto>'+&
						'<pc_desconto_normal>'+ls_PC_Desconto_Atual + '</pc_desconto_normal>'+&
						'<pc_repasse_icms>'+ls_PC_Repasse+'</pc_repasse_icms>'+&
						'<vl_repasse_icms>'+ls_VL_Repasse+'</vl_repasse_icms>'+&
						'<vl_preco_liquido>'+ls_Preco_Liquido +'</vl_preco_liquido>'+&
						'<pc_desconto_financeiro>'+ls_PC_Desconto_Financeiro +'</pc_desconto_financeiro>'+&
						'<pc_desconto_midia>'+ls_PC_Desconto_Midia +'</pc_desconto_midia>'+&
						'<pc_desconto_sellin>'+ls_pc_desconto_sellin +'</pc_desconto_sellin>'+&
						'<vl_icms_st>'+ls_VL_ST + '</vl_icms_st>'+&
						'<vl_icms>'+ls_VL_ICMS + '</vl_icms>'+&
						'<vl_valor_decrescimo>'+ls_VL_Juros_Decrescimo+'</vl_valor_decrescimo>'+&
						'<vl_final>'+ls_VL_Final+'</vl_final>'+&
						'<nr_dias_pagamento>'+ls_Dias_Pagamento + '</nr_dias_pagamento>'
	
catch (RuntimeError lo_rte)
	as_log = "Erro ao recuperar os dados da DataStore [" + is_DS + "]', objeto [" + is_Objeto + "]. Erro: " + lo_rte.GetMessage()
	Return False
end try
							
Return True



           

end function

public subroutine of_grava_xml (string as_xml);String lvs_Path, lvs_Log

Integer li_Log

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If lvs_Path <> "" Then
	
	lvs_Log = lvs_Path + is_nome_arquivo + "_"  + String(year(today()), "0000") + String(Month(today()), "00") + String(Day(today()), "00") + "_" + String(Hour(Now()), "00") +  String(Minute(Now()), "00") + String(Second ( Now() ), "00") +  ".xml"
	
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

public function boolean of_marca_produto_exportar (ref string as_log);update distrib_produto_melhor_compra
set id_processado_sap = 'P'
where (dh_envio_sap is null or dh_atualizacao > dh_envio_sap)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento distrib_produto_melhor_compra 'of_marca_produto_exportar': " + SqlCa.SqlerrText
	Return False
End If

Sqlca.of_Commit();

Return True

end function

public function boolean of_atualiza_processado (long al_produto, string as_uf, ref string as_log);update distrib_produto_melhor_compra
set id_processado_sap = 'P', dh_envio_sap = getdate()
where cd_produto = :al_produto
	and cd_unidade_federacao = :as_uf
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento distrib_produto_melhor_compra 'of_marca_produto_exportar': " + SqlCa.SqlerrText
	Return False
End If

Return True

end function

public subroutine of_processa_envio (long pl_nr_atualizacao);Long ll_Log
Long ll_Linha
Long ll_Linhas
Long ll_Contador, ll_cd_produto, ll_progresso_geral
integer li_contador_xml = 100
String ls_log, ls_cd_Uf
String ls_Parametro_URL
String ls_Tipo_Log_Exp
String ls_Descricao_Tipo_Log
String ls_Grava_XML
String ls_Nome_Interface

String ls_XML_Item
String ls_XML
String ls_Xml_Retorno

String ls_LOG_XML
Decimal{2} ldc_divisao
long ll_qt_envios, ll_nr_xml=1

ls_Parametro_URL 		= 'CD_URL_MELHOR_COMPRA'
ls_Tipo_Log_Exp 			= 'MC'
ls_Descricao_Tipo_Log	= 'MELHOR COMPRA DISTRIBUIDORA'
ls_Nome_Interface 		= 'MELHOR COMPRA'

dc_uo_ds_base lds, lds_aux

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log )

gvs_Log_Geral = ''

ls_Grava_XML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "Grava_XML", "")

try 
	
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress.of_setmax(4)
		
		w_aguarde_3.wf_settext('Validando as configura$$HEX2$$e700f500$$ENDHEX$$es da interface...', 2)
	end if
		
	lds = Create dc_uo_ds_base
	lds_aux = Create dc_uo_ds_base
	
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
	
	If Not gf_retorna_pametro_sap(SQLCA, is_Ambiente_SAP, ls_Parametro_URL, ref is_URL, ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
	
//	if pl_nr_atualizacao > 0 Then
//		
//		if Not this.of_busca_chave_log_exp( pl_nr_atualizacao, ref ll_cd_produto, ref ls_cd_uf, ref ls_log) Then
//			lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
//			Return 
//		End If
//		
//		lds.of_appendwhere('d.cd_produto = ' + String(ll_cd_produto) )
//		lds.of_appendwhere("d.cd_unidade_federacao = '" + ls_cd_uf + "'" )
//		
//	else
	
	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
		
		w_aguarde_3.wf_settext('Atualizando produtos para exportado...', 2)
	end if
	
		If Not This.of_marca_produto_exportar(ref ls_log) Then
			lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
			Return 
		End If
		
//	end if
	
	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
		
		w_aguarde_3.wf_settext('Buscando informa$$HEX2$$e700f500$$ENDHEX$$es do banco de dados...', 2)
	end if
	
	ll_Linhas = lds.Retrieve()


	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
	end if

	If ll_Linhas > 0 Then
				
		//Calcula quantos XML ser$$HEX1$$e300$$ENDHEX$$o enviados.
		ldc_divisao = ll_linhas / li_contador_xml
		
		ll_qt_envios = integer(ldc_divisao)
		
		If ll_qt_envios - ldc_divisao > 0 Then
			ll_qt_envios ++
		End if
		
		if ldc_divisao > ll_qt_envios Then
			ll_qt_envios++
		end if	
			
		if isvalid(w_aguarde_3) then	
			w_Aguarde_3.wf_settext( "Enviando informa$$HEX2$$e700f500$$ENDHEX$$es para o SAP ...", 2 )
			
			w_aguarde_3.uo_progress_2.of_setmax(ll_qt_envios)
		end if		
			
		For ll_Linha = 1 To ll_Linhas

			// Se n$$HEX1$$e300$$ENDHEX$$o possuir o fornecedor ou produto do SAP n$$HEX1$$e300$$ENDHEX$$o envia o produto
			If IsNull(lds.Object.cd_fornecedor_sap[ll_Linha]) or IsNull(lds.Object.cd_produto_sap[ll_Linha]) Then
				w_aguarde.uo_progress.of_setprogress(ll_Linha)
				Continue
			End If
			
			if isvalid(w_aguarde_3) then	
				w_aguarde_3.wf_settext('Enviando XML: ' + String(ll_nr_xml) + ' de ' + String(ll_qt_envios) + '...' , 3)
				w_aguarde_3.wf_settext('Produto/UF: ' + String(lds.object.cd_produto[ll_Linha]) + '/' + lds.object.cd_unidade_federacao[ll_Linha] , 4)
			end if	
			
			ls_XML_Item +=	'<Dados>'
			
			If Not This.of_monta_xml_item(lds, ll_Linha, ref ls_XML_Item, Ref ls_log) Then 
				lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
				Return
			End If
			
			ls_XML_Item += '</Dados>'
			
			If IsNull(ls_XML_Item) or Trim(ls_XML_Item) = '' Then
				lf_ge470_log("Erro: Alguma informa$$HEX2$$e700e300$$ENDHEX$$o do produto '"+ string(lds.object.cd_produto[ll_Linha]) + "' anulou o XML de envio." , 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
				Return
			End If
			
			If Not This.of_atualiza_processado(lds.object.cd_produto[ll_Linha], lds.object.cd_unidade_federacao[ll_Linha], ref ls_Log) Then
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
				
				ls_XML =	is_Inicio_XML + ls_XML_Item + is_Termino_XML
				
				If ls_Grava_XML = "S" Then
					This.of_grava_xml(ls_XML)
				End If
				
				If io_sap_comum.of_Envia_Webservice(is_URL, ls_XML, Ref ls_Xml_Retorno, Ref ls_log) Then
					SqlCa.of_Commit()
				Else
					SqlCa.of_Rollback()
					lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
				End If
				
				// Inicializa
				ls_XML_Item 	= ''
				ll_Contador 		= 0
				
				if isvalid(w_aguarde_3) then
					w_aguarde_3.uo_progress_2.of_setprogress(ll_nr_xml)	
				end if
				
				ll_nr_xml++
				
			End If
			
		Next
		
		if isvalid(w_aguarde_3) then	
			ll_progresso_geral++
			w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
		end if	
		
	ElseIf ll_Linhas < 0 Then
		lf_ge470_log("Erro ao recuperar os dados da DW [" + is_DS + "] - " + is_Objeto + ".", 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	End If
		
	
catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o [" + is_DS + "], objeto ["+ is_Objeto +"]. Erro: "+lo_rte.GetMessage())
	Return
finally
	
If not gvb_Auto Then
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
end try
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

public function boolean of_grava_log_exportacao (datastore ps_ds, ref string ps_log);string ls_uf, ls_erro, ls_cd_fornecedor_sap, ls_nr_atualizacao, ls_cd_produto_sap
long ll_cd_produto, ll_for, ll_nr_atualizacao, ll_nr_dias_pagamento
date ldt_atual
decimal ldc_vl_preco_bruto, ldc_pc_desconto_normal, ldc_pc_repasse_icms, ldc_vl_repasse_icms, ldc_vl_preco_liquido, ldc_pc_desconto_financeiro
decimal ldc_pc_desconto_midia, ldc_vl_icms_st, ldc_vl_valor_decrescimo, ldc_vl_final
uo_ge473_comum luo_comum
str_log_export_sap lst_info

Try
	
	ldt_atual = date(gf_getserverdate())
	
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
		
	insert into log_exportacao_sap(nr_atualizacao,
											id_tipo_nf,	
											id_tipo_log,
											dh_exportacao,
											cd_empresa,
											id_situacao_docto,
											id_status_integracao,
											cd_ambiente_sap)
	Values( :ll_nr_atualizacao,
				'MCC',
				46,
				getdate(),
				1000,
				'C',
				'P',
				:is_Ambiente_SAP);
					
	if sqlca.sqlcode = -1 then 
		ps_log = 'Erro ao inserir registro na tabela "LOG_EXPORTACAO_SAP" (of_grava_log_exportacao): ' + sqlca.sqlerrtext
		return false
	end if
	
	ls_nr_atualizacao = string(ll_nr_atualizacao)
	
	for ll_for = 1 to ps_ds.rowcount()
	
		ls_cd_fornecedor_sap = ps_ds.object.cd_fornecedor_sap[ll_for]
		ls_cd_produto_sap = ps_ds.object.cd_produto_sap[ll_for]
		
		ldc_vl_preco_bruto = ps_ds.object.vl_preco_atual[ll_for]
		
		ldc_pc_desconto_normal = ps_ds.object.pc_desconto_atual[ll_for]
		ldc_pc_repasse_icms = ps_ds.object.pc_repasse_icms[ll_for]
		ldc_vl_repasse_icms = ps_ds.object.vl_repasse_icms[ll_for]
		
		ldc_vl_preco_liquido = Round(ps_ds.Object.vl_preco_atual[ll_for] * (1 - (ps_ds.Object.pc_desconto_atual[ll_for] / 100)), 2) - ps_ds.Object.vl_repasse_icms[ll_for]
		
		ldc_pc_desconto_financeiro = ps_ds.object.pc_desconto_financeiro[ll_for]
		ldc_pc_desconto_midia = ps_ds.object.pc_desconto_midia[ll_for]
		ldc_vl_icms_st = ps_ds.object.vl_icms_st[ll_for]
		
		ldc_vl_valor_decrescimo = ps_ds.object.vl_juros_decrescimo_dist[ll_for]
		
		ldc_vl_final = ps_ds.object.vl_melhor_compra[ll_for]
		
		ll_nr_dias_pagamento = ps_ds.object.nr_dias_pagamento[ll_for]
		
		
		insert into log_exportacao_sap_historico( nr_atualizacao,
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
															vl_documento)
					values(:ll_nr_atualizacao,
							:ls_nr_atualizacao,
							:ldt_atual,
							:ll_for,
							:ls_cd_fornecedor_sap,
							:ls_cd_produto_sap,
							:ldc_vl_preco_bruto,
							:ldc_pc_desconto_normal,
							:ldc_pc_repasse_icms,
							:ldc_vl_repasse_icms,
							:ldc_vl_preco_liquido,
							:ldc_pc_desconto_financeiro,
							:ldc_pc_desconto_midia,
							:ldc_vl_icms_st,
							:ldc_vl_valor_decrescimo,
							:ldc_vl_final,
							:ll_nr_dias_pagamento,
							'X', 
							0);
//				
				if sqlca.sqlcode = -1 then 
					ps_log = 'Erro ao inserir registro na tabela "LOG_EXPORTACAO_SAP_HISTORICO" (of_grava_log_exportacao): ' + sqlca.sqlerrtext
					return false
				end if

	next

Finally		
		


End Try

return True
end function

on uo_ge481_is_melhor_compra.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge481_is_melhor_compra.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_Abre_Log(is_nome_arquivo)

io_sap_comum = Create uo_ge470_sap_comum

is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_Condicao_Request>'
							
is_Termino_XML	=	'</imp:MT_Condicao_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
							

end event

event destructor;Destroy(io_sap_comum)

FileClose(ii_Log)
end event

