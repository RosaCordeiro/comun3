HA$PBExportHeader$uo_ge480_is_melhor_compra.sru
forward
global type uo_ge480_is_melhor_compra from nonvisualobject
end type
end forward

global type uo_ge480_is_melhor_compra from nonvisualobject
end type
global uo_ge480_is_melhor_compra uo_ge480_is_melhor_compra

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

String is_DS 				= 'ds_ge480_mc_produtos'
String is_Objeto 			= 'uo_ge480_is_melhor_compra'
String is_nome_arquivo 	= 'melhor_compra_distribuidora'

Integer	ii_log




end variables

forward prototypes
public function string of_monta_xml_cabecalho (string as_empresa, string as_nr_atualizacao, string as_dt_documento, string as_dt_contabilizacao, string as_cd_tipo_documento, string as_nr_documento_referencia, string as_texto_documento, string as_cd_moeda)
public function boolean of_grava_log_cliente (string as_mensagem, boolean ab_envia_email)
private function boolean of_processa_retorno (string as_cliente, string as_xml_retorno, ref string as_erro)
public function boolean of_ambiente_sap (ref string as_log)
public subroutine of_processa_envio ()
public function boolean of_abre_log (string as_nome_arquivo)
public function boolean of_monta_xml_item (datastore ps_ds, long pl_linha, ref string as_xml, ref string as_log)
public subroutine of_grava_xml (string as_xml)
public function boolean of_marca_produto_exportar (ref string as_log)
public function boolean of_atualiza_processado (long al_produto, string as_uf, ref string as_log)
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

public function boolean of_grava_log_cliente (string as_mensagem, boolean ab_envia_email);String lvs_Mensagem

Integer lvi_Write

String ls_Anexo[]

lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + &
               " - " + as_Mensagem

lvi_Write = FileWrite(ii_Log, lvs_Mensagem)

If lvi_Write = Len(lvs_Mensagem) Then
	
	If ab_envia_email Then		
		If Not gf_ge202_envia_email_automatico(158, "", lvs_Mensagem, ls_Anexo) Then
			Return False
		End If
	End If
	
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de LOG.", StopSign!)
	Return False
End If
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

public function boolean of_ambiente_sap (ref string as_log);is_Ambiente_SAP = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "AmbienteSap", "")

If IsNull(is_Ambiente_SAP) or  Trim(is_Ambiente_SAP) = "" Then is_Ambiente_SAP = 'PRD'

// Sybase(homologa) -> SAP(produ$$HEX2$$e700e300$$ENDHEX$$o)
If (gvo_Aplicacao.ivs_DataSource <> 'central') and (is_Ambiente_SAP = 'PRD') Then
	as_Log = "Ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o do SYBASE n$$HEX1$$e300$$ENDHEX$$o pode atualizar na base produ$$HEX2$$e700e300$$ENDHEX$$o do SAP."
	Return False
End If

// Sybase(central) -> SAP(DEV/QAS)
If (gvo_Aplicacao.ivs_DataSource = 'central') and (is_Ambiente_SAP <> 'PRD') Then
	as_Log = "Ambiente de produ$$HEX2$$e700e300$$ENDHEX$$o do SYBASE n$$HEX1$$e300$$ENDHEX$$o pode atualizar na base DEV/QAS do SAP."
	Return False
End If
end function

public subroutine of_processa_envio ();Long ll_Log
Long ll_Linha
Long ll_Linhas
Long ll_Contador

String ls_log
String ls_Parametro_URL
String ls_Tipo_Log_Exp
String ls_Descricao_Tipo_Log
String ls_Grava_XML
String ls_Nome_Interface

String ls_XML_Item
String ls_XML
String ls_Xml_Retorno

String ls_LOG_XML

String ls_teste

ls_Parametro_URL 		= 'CD_URL_MELHOR_COMPRA'
ls_Tipo_Log_Exp 			= 'MC'
ls_Descricao_Tipo_Log	= 'MELHOR COMPRA DISTRIBUIDORA'
ls_Nome_Interface 		= 'MELHOR COMPRA'

dc_uo_ds_base lds

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log )

gvs_Log_Geral = ''

ls_Grava_XML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "Grava_XML", "")

try 
	lds = Create dc_uo_ds_base
	
	ll_Log = FileLength(is_Arquivo_Log)
	
	If Not of_ambiente_sap(ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
		
	If Not lds.of_ChangeDataObject(is_DS, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS + "' - uo_ge480_interface", 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not gf_retorna_pametro_sap(SQLCA, is_Ambiente_SAP, ls_Parametro_URL, ref is_URL, ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
	
	If Not This.of_marca_produto_exportar(ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
	
	ll_Linhas = lds.Retrieve()

	If ll_Linhas > 0 Then
				
		Open(w_Aguarde)
		w_aguarde.uo_progress.of_setmax(ll_Linhas)
		w_Aguarde.Title = "Atualizando os [" + ls_Nome_Interface + "] no SAP ..."
		
		//ll_Linhas = 2
			
		For ll_Linha = 1 To ll_Linhas

			// Se n$$HEX1$$e300$$ENDHEX$$o possuir o fornecedor ou produto do SAP n$$HEX1$$e300$$ENDHEX$$o envia o produto
			If IsNull(lds.Object.cd_fornecedor_sap[ll_Linha]) or IsNull(lds.Object.cd_produto_sap[ll_Linha]) Then
				w_aguarde.uo_progress.of_setprogress(ll_Linha)
				Continue
			End If
			
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
			
			If  ll_Contador >= 50 or ll_Linha = ll_Linhas Then
				
				//Len(ls_XML_Item) >= 50000
				
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
			End If
				
			w_aguarde.uo_progress.of_setprogress(ll_Linha)			
			
		Next
		
		Sleep(1)
								
		SqlCa.of_Rollback()
				
					
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
		MessageBox('Sucesso!','Os procedimentos foram executados sem erros! ',Information!,Ok!)
	End If
Else
	If gvs_Log_Geral <> '' Then lf_ge470_email_log(gvs_Log_Geral,1)
End If
		
	If IsValid(lds) Then Destroy lds
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
end try
end subroutine

public function boolean of_abre_log (string as_nome_arquivo);String	lvs_Path

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If lvs_Path <> "" Then
	
	is_Arquivo_Log = lvs_Path + as_nome_arquivo + ".log"
	
	ii_log = FileOpen(is_Arquivo_Log, LineMode!, Write!, LockWrite!)
	
	If ii_log = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo de log '" + is_Arquivo_Log + "'.", StopSign!)
		Return False
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio para grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de log n$$HEX1$$e300$$ENDHEX$$o foi localizado.~r~r" +&
						  "Verifique o INI da aplica$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_monta_xml_item (datastore ps_ds, long pl_linha, ref string as_xml, ref string as_log);Decimal ldc_VL_Liquido

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

try 
	ls_Fornecedor 	= ps_ds.Object.cd_fornecedor_sap[pl_linha]
	ls_Produto 		= ps_ds.Object.cd_produto_sap[pl_linha]
	
	ls_Preco_Bruto 					= gf_Valor_Com_Ponto(ps_ds.Object.vl_preco_atual[pl_linha])
	ls_PC_Desconto_Atual 		= gf_Valor_Com_Ponto(ps_ds.Object.pc_desconto_atual[pl_linha])
	ls_PC_Repasse					= gf_Valor_Com_Ponto(ps_ds.Object.pc_repasse_icms[pl_linha])
	ls_VL_Repasse					= gf_Valor_Com_Ponto(ps_ds.Object.vl_repasse_icms[pl_linha])
	ls_PC_Desconto_Financeiro 	= gf_Valor_Com_Ponto(ps_ds.Object.pc_desconto_financeiro[pl_linha])
	ls_PC_Desconto_Midia	 	= gf_Valor_Com_Ponto(ps_ds.Object.pc_desconto_midia[pl_linha])
	ls_VL_ST							= gf_Valor_Com_Ponto(ps_ds.Object.vl_icms_st[pl_linha])
	ls_VL_Juros_Decrescimo		= gf_Valor_Com_Ponto(ps_ds.Object.vl_juros_decrescimo_dist[pl_linha])
	ls_VL_Final						= gf_Valor_Com_Ponto(ps_ds.Object.vl_melhor_compra[pl_linha])
	ls_Dias_Pagamento			= gf_Valor_Com_Ponto(ps_ds.Object.nr_dias_pagamento[pl_linha])
	
	ldc_VL_Liquido 		= Round(ps_ds.Object.vl_preco_atual[pl_linha] * (1 - (ps_ds.Object.pc_desconto_atual[pl_linha] / 100)), 2) - ps_ds.Object.vl_repasse_icms[pl_linha]
	ls_Preco_Liquido 	= gf_Valor_Com_Ponto(ldc_VL_Liquido)
	
	as_xml +=		'<cd_fornecedor_sap>' + ls_Fornecedor + '</cd_fornecedor_sap>'+&
						'<cd_produto_sap>'+ ls_Produto + '</cd_produto_sap>'+&
						 '<vl_preco_bruto>' + ls_Preco_Bruto + '</vl_preco_bruto>'+&
						'<pc_desconto_normal>'+ls_PC_Desconto_Atual + '</pc_desconto_normal>'+&
						'<pc_repasse_icms>'+ls_PC_Repasse+'</pc_repasse_icms>'+&
						'<vl_repasse_icms>'+ls_VL_Repasse+'</vl_repasse_icms>'+&
						'<vl_preco_liquido>'+ls_Preco_Liquido +'</vl_preco_liquido>'+&
						'<pc_desconto_financeiro>'+ls_PC_Desconto_Financeiro +'</pc_desconto_financeiro>'+&
						'<pc_desconto_midia>'+ls_PC_Desconto_Midia +'</pc_desconto_midia>'+&
						'<vl_icms_st>'+ls_VL_ST + '</vl_icms_st>'+&
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
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo de log '" + lvs_Log + "'.", StopSign!)
			Return
		End If
	End If
	
	If FileWrite(li_Log, as_xml) < 0 Then
		If Not gvb_Auto Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o arquivo.", StopSign!)
		End If
	End If
	
	FileClose (li_Log)
Else
	If Not gvb_Auto Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio para grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de log n$$HEX1$$e300$$ENDHEX$$o foi localizado.~r~r" +&
							  "Verifique o INI da aplica$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
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

Return True

end function

public function boolean of_atualiza_processado (long al_produto, string as_uf, ref string as_log);update distrib_produto_melhor_compra
set id_processado_sap = 'S', dh_envio_sap = getdate()
where cd_produto = :al_produto
	and cd_unidade_federacao = :as_uf
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento distrib_produto_melhor_compra 'of_marca_produto_exportar': " + SqlCa.SqlerrText
	Return False
End If

Return True

end function

on uo_ge480_is_melhor_compra.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge480_is_melhor_compra.destroy
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

