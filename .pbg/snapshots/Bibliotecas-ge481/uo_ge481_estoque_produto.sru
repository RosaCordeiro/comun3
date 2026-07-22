HA$PBExportHeader$uo_ge481_estoque_produto.sru
forward
global type uo_ge481_estoque_produto from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_estoque_produto from uo_ge481_subida_generica autoinstantiate
end type

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public subroutine of_processa_envio (long pl_nr_atualizacao)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, ref string as_log)
public function boolean of_grava_log_exportacao (datastore ps_ds, ref string ps_log)
public function boolean of_atualiza_produto (datastore ads_produto, ref string as_log)
end prototypes

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:syn="http://Estoque_Filiais/SyncSOAP2Proxy">' + &
						'<soapenv:Header/>'+ &
						'<soapenv:Body>'+ &
					   '<syn:MT_Estoque_Request>'
							
is_Termino_XML	=	'</syn:MT_Estoque_Request>' + &
						'</soapenv:Body>' + &
						'</soapenv:Envelope>'

ib_usa_cabecalho      = False
is_DS                 = 'ds_ge481_estoque_produto'
is_Objeto             = this.ClassName ()
is_nome_arquivo       = 'saldo_produto_xml'
is_Parametro_URL      = 'CD_URL_SALDO_PRODUTO'
is_Tipo_Log_Exp       = 'SLP'
is_Descricao_Tipo_Log = 'SALDO_PRODUTO'
is_Nome_Interface     = 'SALDO PRODUTO'

ii_contador_xml       = 500

Return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);string ls_cd_produto_sap, ls_est_produto, ls_data, ls_hora

ls_cd_produto_sap = pds_dados.Object.cd_produto_sap      [pl_linha]
ls_est_produto    = String (pds_dados.Object.saldo_geral [pl_linha])
ls_data           = String (pds_dados.Object.data_hora   [pl_linha], 'yyyymmdd')
ls_hora           = String (pds_dados.Object.data_hora   [pl_linha], 'hhmm')

ps_xml += '<Dados>' 
ps_xml += '<Material>' + ls_cd_produto_sap + '</Material>'
ps_xml += '<Estoque>' + ls_est_produto + '</Estoque>'
ps_xml += '<Data>' + ls_data + '</Data>'
ps_xml += '<Hora>' + ls_hora + '</Hora>'
ps_xml += '</Dados>' 

Return True
end function

public subroutine of_processa_envio (long pl_nr_atualizacao);Date				ldt_saldo
Boolean			lb_Sucesso
Date				ldt_hoje
dc_uo_api		lo_api
dc_uo_ds_base	lds
Decimal{2}		ldc_divisao
Long				ll_Contador
Long				ll_Linha
Long				ll_Linhas
Long				ll_Log
Long				ll_nr_xml
Long				ll_qt_envios, ll_prd
String			ls_Log
String			ls_Grava_XML
String			ls_XML
String			ls_XML_Item
String			ls_Xml_Retorno

dc_uo_ds_base lds_aux

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abertura est$$HEX1$$e100$$ENDHEX$$ no construtor.
FileClose (io_sap_comum.ii_log)

lb_Sucesso    = True
gvs_Log_Geral = ''
ls_Grava_XML  = ProfileString (gvo_Aplicacao.ivs_Arquivo_INI, 'Configuracao', 'Grava_XML', '')

Try 
	lds     = Create dc_uo_ds_base
	
	ll_Log = FileLength (is_Arquivo_Log)
	
	If Not of_ambiente_sap (Ref ls_log) then
		lf_ge470_log (ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return
	End if
		
	If Not lds.of_ChangeDataObject (is_DS, False) then
		lf_ge470_log ("Erro ao alterar a DW '" + is_DS + "' - " + is_Objeto, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return
	End if
	
	If Not gf_retorna_pametro_sap (SQLCA, is_Ambiente_SAP, is_Parametro_URL, Ref is_URL, Ref ls_log) then
		lf_ge470_log (ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return
	End if
	
	// Limpa
	ls_XML           = ''
	ls_XML_Item      = ''
	
	// Carregando....
	If Not IsValid (w_aguarde) then
		Open (w_aguarde)
	End if
	
	ldt_hoje  = Date (gf_GetServerDate ())
	ldt_saldo = Date (Year (ldt_hoje), Month (ldt_hoje), 1)
	ll_Linhas = lds.Retrieve (ldt_saldo)

	w_aguarde.Title = 'Carregando o saldo dos produtos...'
	w_aguarde.uo_progress.of_Reset ()
	w_aguarde.uo_progress.Of_SetMax (ll_Linhas)
	
	lds_aux = Create dc_uo_ds_base
	If Not lds_aux.of_ChangeDataObject("ds_ge481_produtos_saldo", False) Then
		lf_ge470_log ("Erro ao usar ds_ge481_lista_produto", 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return 
	End If
	
	// Se Tem Registros 
	If ll_Linhas > 0 then
		//Calcula quantos XML ser$$HEX1$$e300$$ENDHEX$$o enviados.
		ldc_divisao = ll_linhas / ii_contador_xml
		ll_qt_envios = Integer (Ceiling (ldc_divisao))
		
		ll_nr_xml = 1
		lds_aux.reset( )
		
		For ll_Linha = 1 To ll_Linhas	
			w_aguarde.Title = 'Produto: ' + String (lds.Object.cd_produto [ll_Linha]) + ' Linha: ' + String (ll_Linha) + ' de: ' + String (ll_Linhas)
			
			If Not This._of_monta_xml_item (lds, ll_Linha, ref ls_XML_Item, Ref ls_log) then
				lf_ge470_log (ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
				lb_Sucesso = False
				Return
			End if
			
			// Valida Item 
			If IsNull (ls_XML_Item) or Trim (ls_XML_Item) = '' then
				lf_ge470_log ('Erro: Alguma informa$$HEX2$$e700e300$$ENDHEX$$o do produto ' + String (lds.object.cd_produto [ll_Linha]) + ' anulou o XML de envio.' , 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
				lb_Sucesso = False
				Return
			End if
			
			// Data Com os Produtos
			ll_prd = lds_aux.InsertRow(0)
			lds_aux.object.cd_produto[ll_prd] 	= lds.Object.cd_produto [ll_Linha]
			
			ll_Contador ++
			
			If ll_Contador >= ii_contador_xml or ll_Linha = ll_Linhas then
				
				If IsNull (is_Inicio_XML) or is_Inicio_XML = '' or Len (is_Inicio_XML) <= 1 then
					lf_ge470_log (ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					lb_Sucesso = False
					Return
				End if
				
				If IsNull (ls_XML_Item) or ls_XML_Item = '' or Len (ls_XML_Item) <= 1 then
					lf_ge470_log (ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					lb_Sucesso = False
					Return
				End if
				
				If IsNull (is_Termino_XML) or is_Termino_XML = '' or Len (is_Termino_XML) <= 1 then
					lf_ge470_log (ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					lb_Sucesso = False
					Return
				End if
				
				// Fecha o XML
				ls_XML +=  is_Inicio_XML
				ls_XML +=  ls_XML_Item
				ls_XML +=  is_Termino_XML
				
				If ls_Grava_XML = 'S' then
					This.of_grava_xml (ls_XML, ll_nr_xml)
				End if
				
				If io_sap_comum.of_Envia_Webservice (is_URL, ls_XML, Ref ls_Xml_Retorno, Ref ls_log) then

					If Not This.of_atualiza_produto( lds_aux, ref ls_log)  Then 
						lf_ge470_log (ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
						lb_Sucesso = False
						Return
					Else
						SQLCA.of_Rollback ()
						lf_ge470_log (ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					End If	
					// Reseta a DataStore.. 
					lds_aux.reset( )
				Else
					SQLCA.of_Rollback ()
					lf_ge470_log (ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
				End if
				
				ll_Contador = 0
				ll_nr_xml ++
				
				// Fecha o XML
				ls_XML_Item = ''
				ls_XML      = ''
			End if
			
			// Para Carregando
			w_aguarde.uo_progress.Of_SetProgress (ll_Linha)
		Next
	else
		If ll_Linhas < 0 then
			lf_ge470_log ('Erro ao recuperar os dados da DW [' + is_DS + '] - ' + is_Objeto + '.', 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
			Return
		End if
	End if
Catch (RuntimeError	lo_rte)
	MessageBox ('Erro', 'Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o [' + is_DS + '], objeto [' + is_Objeto + ']. Erro: ' + lo_rte.GetMessage ())
	Return
Finally
	If not lb_Sucesso then
		SQLCA.of_Rollback ()
	End if
	If Not gvb_Auto then
		If FileLength (is_Arquivo_Log) > ll_Log then
			lo_api = Create dc_uo_api
			lo_api.of_Shell_execute ('notepad.exe', is_Arquivo_Log)
			Destroy lo_api
		else
			MessageBox ('Sucesso!', 'Os procedimentos foram executados sem erros!', Information!, Ok!)
		End if
	else
		If gvs_Log_Geral <> '' then lf_ge470_email_log (gvs_Log_Geral, 1)
	End if
	
	If IsValid (lds)     Then Destroy lds
	If IsValid (lds_aux)     then Destroy lds_aux
	
	If IsValid (w_aguarde) then
		Close (w_aguarde)
	End if
	
End Try
end subroutine

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, ref string as_log);DateTime	ldt_datahora
Long		ll_cd_produto

ldt_datahora      = pds_itens.Object.data_hora      [pl_linha]
ll_cd_produto     = pds_itens.Object.cd_produto     [pl_linha]

UPDATE produto_central
	SET dh_envio_saldo_filial_sap	= :ldt_datahora
 WHERE cd_produto = :ll_cd_produto
 USING SQLCA;

If SQLCA.SQLCode = -1 then
	as_log = 'Erro ao atualizar o campo dh_envio_saldo_filial_sap da tabela produto_geral:~n~n~r' + SQLCA.SQLErrText
	Return False
End if

Return True
end function

public function boolean of_grava_log_exportacao (datastore ps_ds, ref string ps_log);
Return True
end function

public function boolean of_atualiza_produto (datastore ads_produto, ref string as_log);Long  ll_Produto
Long  ll_Linha, ll_Linhas
DateTime	ldt_datahora

ldt_datahora  = gf_GetServerDate ()


ll_Linhas = 	ads_produto.rowcount( )  
For ll_Linha  = 1 To ll_Linhas

	ll_Produto =	ads_produto.Object.cd_produto[ll_linha]  
	
	UPDATE produto_central
	SET dh_envio_saldo_filial_sap	= :ldt_datahora
	WHERE cd_produto = :ll_Produto
	USING SQLCA;

	If SQLCA.SQLCode = -1 then
		as_log = 'Erro ao atualizar o campo dh_envio_saldo_filial_sap da tabela produto_geral:~n~n~r' + SQLCA.SQLErrText
		Return False
	End if			
	SQLCA.of_Commit ()
Next   	

Return True 





end function

on uo_ge481_estoque_produto.create
call super::create
end on

on uo_ge481_estoque_produto.destroy
call super::destroy
end on

