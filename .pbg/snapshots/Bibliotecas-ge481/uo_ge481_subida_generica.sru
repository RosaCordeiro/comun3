HA$PBExportHeader$uo_ge481_subida_generica.sru
forward
global type uo_ge481_subida_generica from nonvisualobject
end type
end forward

global type uo_ge481_subida_generica from nonvisualobject
end type
global uo_ge481_subida_generica uo_ge481_subida_generica

type variables
uo_ge470_sap_comum io_sap_comum

String is_Origem_Legado 		= "SYBASE"
Integer ii_Empresa				= 1000
String is_URL
String is_Inicio_XML
String is_Termino_XML
String is_Arquivo_Log
String is_Ambiente_SAP

String is_DS
String is_Objeto
String is_nome_arquivo
String is_Parametro_URL
String is_Tipo_Log_Exp
String is_Descricao_Tipo_Log
String is_Nome_Interface

Integer	ii_log
Integer	ii_contador_xml = 100
Boolean ib_envia_webService=True
Boolean ib_usa_cabecalho=True
Boolean ib_monitor_exp=false
Boolean ib_validar_situacao = True
Boolean ib_continua_apos_erro_montar_xml = False //Serve para continuar o processamento dos demais arquivos caso um deles de problema (Aconselhavel usar quando envio apenas 1 XML por vez)

Long	il_timeout_webservice	= 120000
end variables

forward prototypes
public function boolean of_ambiente_sap (ref string as_log)
public function boolean of_abre_log (string as_nome_arquivo)
public subroutine of_grava_xml (string as_xml, long pl_sequencia)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_parametros ()
protected function boolean of_valida_situacao (datastore pds_itens, long pl_linha, ref long pl_situacao_pendente, ref string ps_log)
public function boolean _of_config_filtro_cab (datastore pds_cab, long pl_linha, ref datastore pds_itens, ref string ps_log)
public function boolean _of_config_lista_cab (datastore pds_itens, long pl_linha, ref datastore pds_cab, ref string ps_log)
public function boolean _of_monta_xml_cab (datastore pds_cab, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, string ps_status, ref string as_log)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log)
public function boolean of_atualiza_processado (long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string ps_log)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, ref string as_log)
public function string of_busca_valor (string as_xml, string as_tag, ref long al_pos)
public subroutine of_processa_envio (long pl_nr_atualizacao)
public subroutine of_processa_envio ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
end prototypes

public function boolean of_ambiente_sap (ref string as_log);return gf_ambiente_sap( ref is_ambiente_sap, ref as_log )
end function

public function boolean of_abre_log (string as_nome_arquivo);String	lvs_Path

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If lvs_Path <> "" Then
	
	is_Arquivo_Log = lvs_Path + as_nome_arquivo + ".log"
	
	if FileExists(is_Arquivo_Log) Then
		is_Arquivo_Log = lvs_Path + as_nome_arquivo + "A.log"
	end if
	
	ii_log = FileOpen(is_Arquivo_Log, LineMode!, Write!, LockWrite!)
	
	If ii_log = -1 Then		
		Return False
	End If
Else
	Return False
End If

Return True
end function

public subroutine of_grava_xml (string as_xml, long pl_sequencia);String lvs_Path, lvs_Log
blob lbl_xml
Integer li_Log

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

lbl_xml = Blob(as_xml)

If lvs_Path <> "" Then
	
	lvs_Log = lvs_Path + is_nome_arquivo + "_" + String(pl_sequencia) + "_" +  String(year(today()), "0000") + String(Month(today()), "00") + String(Day(today()), "00") + "_" + String(Hour(Now()), "00") +  String(Minute(Now()), "00") + String(Second ( Now() ), "00") + ".xml"
	
	li_Log = FileOpen(lvs_Log, StreamMode!, Write!, LockReadWrite!, Replace!, EncodingUTF8!)
	
	If li_Log = -1 Then
		If Not gvb_Auto Then			
			Return
		End If
	End If
	
	If FileWriteEx(li_Log, lbl_xml) < 0 Then
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

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);//decimal ldc_vl_preco, ldc_desconto
//string ls_cd_produto_sap
//
//
//
//select pg.cd_produto_sap, dp.vl_preco_atual, dp.pc_desconto_atual
//into :ls_cd_produto_sap, :ldc_vl_preco, :ldc_desconto
//from distribuidora_produto dp
//	inner join produto_geral pg on (pg.cd_produto = dp.cd_produto)
//where dp.cd_distribuidora = :ps_cd_fornecedor
//and dp.cd_produto = :pl_cd_produto
//and dp.cd_unidade_federacao = :ps_cd_uf;
//
//if Sqlca.sqlcode = -1 then
//	ps_log = 'Erro ao consultar a tabela "distribuidora_produto": ' + Sqlca.sqlerrtext
//	return false
//end if
//
//if ls_cd_produto_sap = '' or isnull(ls_cd_produto_sap) Then
//	ps_log = 'O produto ' + String(pl_cd_produto) + ' n$$HEX1$$e300$$ENDHEX$$o possui c$$HEX1$$f300$$ENDHEX$$digo SAP cadastrado.'
//	return false
//end if
//
//if isnull(ldc_vl_preco) Then ldc_vl_preco = 0
//if isnull(ldc_desconto) Then ldc_desconto = 0
//
//ps_xml += '<MATERIAIS>'
//ps_xml += '<MATERIAL>' + ls_cd_produto_sap + '</MATERIAL>'
//ps_xml += '<VALOR>' + String(ldc_vl_preco) + '</VALOR>'
//ps_xml += '<DESCONTO>' + String(ldc_desconto) + '</DESCONTO>'
//ps_xml += '</MATERIAIS>'

return true
end function

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:??>'
							
is_Termino_XML	=	'</imp:??>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'

is_DS = ''
is_Objeto = ''
is_nome_arquivo = ''
is_Parametro_URL = ''
is_Tipo_Log_Exp = ''
is_Descricao_Tipo_Log = ''
is_Nome_Interface = ''

return True
end function

protected function boolean of_valida_situacao (datastore pds_itens, long pl_linha, ref long pl_situacao_pendente, ref string ps_log);long ll_nr_atualizacao


ll_nr_atualizacao = pds_itens.object.nr_atualizacao[pl_linha]

if not ib_validar_situacao then
	Select 1
	into :pl_situacao_pendente
	from log_exportacao_sap
	where nr_atualizacao = :ll_nr_atualizacao
	Using SQLCA;
else
	Select 1
	into :pl_situacao_pendente
	from log_exportacao_sap
	where nr_atualizacao = :ll_nr_atualizacao
	and id_status_integracao = 'C'
	Using SQLCA;
end if

If SqlCa.SqlCode = -1 Then
	ps_log = "Erro ao consultar a tabela log_exportacao_sap 'of_valida_situacao': " + SqlCa.SqlerrText
	Return False
End If
	

return true
end function

public function boolean _of_config_filtro_cab (datastore pds_cab, long pl_linha, ref datastore pds_itens, ref string ps_log);//ls_cd_fornecedor = lds_cabecalho.object.cd_fornecedor[ll_linha]
//	
////Filtra os registros da tabela de LOG para trazer apenas os de cada Fornecedor.
//lds_itens.setfilter('cd_fornecedor = "' + ls_cd_fornecedor + '"') 
			
Return True
end function

public function boolean _of_config_lista_cab (datastore pds_itens, long pl_linha, ref datastore pds_cab, ref string ps_log);//ls_cd_fornecedor = lds_itens.object.cd_fornecedor[ll_linha]
//			
//if lds_cabecalho.find('cd_fornecedor = "' + ls_cd_fornecedor + '"' , 1, lds_cabecalho.rowcount()) = 0 Then
//	ll_row = lds_cabecalho.insertrow(0)
//	lds_cabecalho.setitem(ll_row,'cd_fornecedor', ls_cd_fornecedor)
//end if

return True
end function

public function boolean _of_monta_xml_cab (datastore pds_cab, long pl_linha, ref string ps_xml, ref string ps_log);//string ls_fornecedor_sap
//
//select cd_chave_sap 
//into :ls_fornecedor_sap
//from integracao_sap
//where cd_tabela = 'FORNECEDOR'
//and cd_chave_legado = :ps_cd_fornecedor;
//
//if Sqlca.sqlcode = -1 then 
//	ps_log = 'Erro ao consultar a tabela "integracao_sap": ' + Sqlca.sqlerrtext
//	return false
//end if
//
//if ls_fornecedor_sap = '' or isnull(ls_fornecedor_sap) Then
//	ps_log = 'O fornecedor ' + ps_cd_fornecedor + ' n$$HEX1$$e300$$ENDHEX$$o possui c$$HEX1$$f300$$ENDHEX$$digo SAP.'
//	return false
//end if
//
//ps_xml = '<FORNECEDOR>' + ls_fornecedor_sap + '</FORNECEDOR>'
//
return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);


return true
end function

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, string ps_status, ref string as_log);return this.of_atualiza_processado( pds_itens, pl_linha, 0, ps_status, '', ref as_log)
end function

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log);long ll_nr_atualizacao
String ls_status, ls_msg

// a interface de retorno uo_ge481_sap_pedido_retorno n$$HEX1$$e300$$ENDHEX$$o utiliza a LOG_EXPORTACAO_SAP
// ******** VAMOS ALTERAR para gravar na LOG_EXPORTACAO
If is_Nome_Interface = 'PEDIDO_RETORNO' Then Return True

if pl_nr_atualizacao = 0 or isnull(pl_nr_atualizacao) Then
	ll_nr_atualizacao = pds_itens.object.nr_atualizacao[pl_linha]
else
	ll_nr_atualizacao = pl_nr_atualizacao
end if

if ps_status = 'E' Then
	ls_status = 'E'
	ls_msg = as_mensagem
else
	ls_status = 'P'
	setnull(ls_msg)
end if

update log_exportacao_sap
set id_status_integracao = :ls_status, dh_exportacao = getdate(), de_erro = :ls_msg
where nr_atualizacao = :ll_nr_atualizacao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_sap 'of_atualiza_processado': " + SqlCa.SqlerrText
	Return False
End If

return true
end function

public function boolean of_atualiza_processado (long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string ps_log);datastore lds_nula

return this.of_atualiza_processado( lds_nula, 0, pl_nr_atualizacao, ps_status, as_mensagem, ref ps_log )


end function

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, ref string as_log);return this.of_atualiza_processado( pds_itens, pl_linha, 0, 'S', '', ref as_log)
end function

public function string of_busca_valor (string as_xml, string as_tag, ref long al_pos);string ls_retorno
string  ls_Xml_Aux
long ll_pos1, ll_pos2

as_Tag = gf_Replace(as_Tag, '/', '', 0)
as_Tag = gf_Replace(as_Tag, '<', '', 0)
as_Tag = gf_Replace(as_Tag, '>', '', 0)

ls_Xml_Aux = as_xml

ll_pos1 = Pos(ls_Xml_Aux, '<'+as_tag+'>', al_pos)
ll_pos2 = Pos(ls_Xml_Aux, '</'+as_tag+'>', al_pos)

 ls_retorno = Mid(	ls_Xml_Aux,  ll_pos1 + LenA(as_tag)+2, ll_pos2 - ( ll_pos1 + LenA(as_tag)+2))

al_pos = ll_pos2


return ls_retorno
end function

public subroutine of_processa_envio (long pl_nr_atualizacao);string ls_grava_xml
string ls_log
string ls_xml
string ls_xml_item
string ls_xml_cab
string ls_Xml_Retorno
long ll_log
long ll_linha
long ll_linhas, ll_linhas_cab
long ll_for
long ll_seq_xml=0
long ll_situacao_pendente
long ll_progresso, ll_progresso_geral=0, ll_qt_envios, ll_nr_xml=1
long ll_contador
decimal{2} ldc_divisao

dc_uo_ds_base lds_itens, lds_cabecalho

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log )

gvs_Log_Geral = ''

ls_Grava_XML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "Grava_XML", "")

if pl_nr_atualizacao > 0 Then
	//Interface est$$HEX1$$e100$$ENDHEX$$ sendo executada pelo monitor de exporta$$HEX2$$e700e300$$ENDHEX$$o.
	ib_monitor_exp = True
end if

try 
	
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress.of_setmax(3)
		
		w_aguarde_3.wf_settext('Validando configura$$HEX2$$e700f500$$ENDHEX$$es da interface...', 2)
		
	end if
	
	lds_itens = Create dc_uo_ds_base
	lds_cabecalho = Create dc_uo_ds_base
	
	ll_Log = FileLength(is_Arquivo_Log)
	
	If Not of_ambiente_sap(ref ls_log) Then
		lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return 
	End If
		
	If Not lds_itens.of_ChangeDataObject(is_DS, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS + "' - " + is_Objeto, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not lds_cabecalho.of_ChangeDataObject(is_DS, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS + "' - " + is_Objeto, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not gf_retorna_pametro_sap(SQLCA, is_Ambiente_SAP, is_Parametro_URL, ref is_URL, ref ls_log) Then
		lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return 
	End If
	
	if pl_nr_atualizacao > 0 Then
		if this._of_filtra_nr_atualizacao( ref lds_itens, pl_nr_atualizacao, ref ls_log) = false then return 
	else
		if this._of_filtra_nr_atualizacao( ref lds_itens, 0, ref ls_log) = false then return 
	end if
	
	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
		w_aguarde_3.wf_settext('Buscando informa$$HEX2$$e700f500$$ENDHEX$$es do banco de dados...', 2)
	end if
		
	ll_linhas = lds_itens.retrieve( )

	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
		w_aguarde_3.wf_settext('Enviando informa$$HEX2$$e700f500$$ENDHEX$$es ao SAP...', 2)
	end if

	if ll_linhas  > 0 Then
	
		//Calcula quantos XML ser$$HEX1$$e300$$ENDHEX$$o enviados.
		ldc_divisao = ll_linhas / ii_contador_xml
		ll_qt_envios = long(ldc_divisao)
		
		if ldc_divisao > ll_qt_envios Then
			ll_qt_envios++
		end if
		
		if ll_qt_envios = 0 or isnull(ll_qt_envios) then ll_qt_envios = 1
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_setmax(ll_qt_envios)
			w_aguarde_3.wf_settext('Enviando XML: ' + String(ll_nr_xml) + ' de ' + String(ll_qt_envios) + '...' , 3)
		end if
		
		if ib_usa_cabecalho = True Then
			
			//Faz uma lista dos registros de cabecalho.
			for ll_linha = 1 to ll_linhas
				
				if Not	this._of_config_lista_cab( lds_itens, ll_linha, ref lds_cabecalho, ref ls_log) Then
					lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					Return
				end if
				
			next
			
			ll_linhas_cab = lds_cabecalho.rowcount()
			
		else
			
			ll_linhas_cab = 1
			
		end if
		
		//Percorre cada registro de cabe$$HEX1$$e700$$ENDHEX$$alho
		For ll_linha = 1 to ll_linhas_cab
			
			ls_xml = ''
			ls_xml_cab = ''
			ls_xml_item = ''
			
			if ib_usa_cabecalho = True Then
				if Not this._of_config_filtro_cab( lds_cabecalho, ll_linha, ref lds_itens, ref ls_log ) Then
					lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					Return
				end if
			
				lds_itens.filter()
				
				lds_itens.sort()
			end if
					
			ll_linhas = lds_itens.rowcount( )
			
			//Percorre cada registro do LOG para montar o xml.
			for ll_for = 1 to ll_linhas
				
				ll_progresso++
			
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.wf_settext('Enviando XML ' + String(ll_nr_xml) + ' de ' + String(ll_qt_envios) + '...' , 3)
				end if
				
				//Verifica se a situa$$HEX2$$e700e300$$ENDHEX$$o do registro ainda est$$HEX1$$e100$$ENDHEX$$ pendente
				if of_valida_situacao(lds_itens, ll_for, ref ll_situacao_pendente, ref ls_log) = false then
					lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					Return
				end if
				
				if ll_situacao_pendente <> 1 Then 
					//w_aguarde.uo_progress.of_setprogress(ll_progresso)	
					continue
				end if
				
				//Atualiza situa$$HEX2$$e700e300$$ENDHEX$$o do registro para processado
				if of_atualiza_processado(lds_itens, ll_for, 'P', ref ls_log) = false then
					lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					Return
				end if
				
				ll_contador++
				
				if ll_contador = 1 Then
					if Not this._of_monta_xml_cab( lds_cabecalho, ll_linha, ref ls_xml_cab, ref ls_log ) Then
						lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
						return
					end if
				end if
				
				if Not this._of_monta_xml_item( lds_itens, ll_for, ref ls_xml_item, ref ls_log) Then
					
					of_atualiza_processado(lds_itens.Object.nr_atualizacao[ll_for], 'E', ls_log, ref ls_log)
					SqlCa.of_Commit(); // commita com erro
					
					lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					
					if ib_continua_apos_erro_montar_xml then
						Continue
					else
						return
					end if
				end if
				
				if ll_contador >= ii_contador_xml or ll_for >= ll_linhas Then
				
					if ls_xml_item = '' or isnull(ls_xml_item) Then 
						ls_log	= 'XML de envio para webservice est$$HEX1$$e100$$ENDHEX$$ em branco.'
						
						of_atualiza_processado(lds_itens.Object.nr_atualizacao[ll_for], 'E', ls_log, ref ls_log)
						SqlCa.of_Commit(); // commita com erro
						
						lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
						
						if ib_continua_apos_erro_montar_xml then
							Continue
						else
							return
						end if
							
					end if
			
					ls_XML =	 is_Inicio_XML 
					
					if ls_xml_cab <> '' Then ls_xml += ls_xml_cab
					if ls_xml_item <> '' Then ls_xml += ls_xml_item
					
					ls_xml += is_Termino_XML
					
					If ls_Grava_XML = "S" Then
						ll_seq_xml++
						This.of_grava_xml(ls_XML, ll_seq_xml)
					End If
					
					if ib_envia_webService = True Then
						If not io_sap_comum.of_Envia_Webservice(is_URL, ls_XML, Ref ls_Xml_Retorno, Ref ls_log, il_timeout_webservice) Then
							SqlCa.of_Rollback()
							lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
							return
						End If
						
						If not _of_processa_retorno_xml(ls_xml_retorno, ref ls_log) Then
							SqlCa.of_Rollback()
							lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
							return
						end if
						
					End if
					
					If FileLength(is_Arquivo_Log) > ll_Log Then
						SqlCa.of_Rollback()
					else
						SqlCa.of_Commit()
					end if
					
					ll_contador = 0
					
					ls_xml = ''
					ls_xml_cab = ''
					ls_xml_item = ''
					
					if isvalid(w_aguarde_3) Then
						w_aguarde_3.uo_progress_2.of_setprogress(ll_nr_xml)
					end if
					
					ll_nr_xml++
					
				end if
			
			Next
			
		Next
		
		if isvalid(w_aguarde_3) Then
			ll_progresso_geral++
			w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)	
		End if
		
	end if
	
catch (RuntimeError lo_rte)
	ls_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o [" + is_DS + "], objeto ["+ is_Objeto +"]. Erro: "+lo_rte.GetMessage()
	lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
	Return
finally
	
	If FileLength(is_Arquivo_Log) > ll_Log Then
		SqlCa.of_Rollback()
	End if
	
	If not gvb_Auto  and ib_monitor_exp = false Then
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
		
	If IsValid(lds_itens) Then Destroy lds_itens
	If IsValid(lds_cabecalho) Then Destroy lds_cabecalho
	
end try
end subroutine

public subroutine of_processa_envio ();of_processa_envio(0)
end subroutine

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);//Filtra a datastore para trazer um registro espec$$HEX1$$ed00$$ENDHEX$$fico.

pds_dados.of_appendwhere( 'nr_atualizacao = ' + String(pl_nr_atualizacao) )

return true
end function

on uo_ge481_subida_generica.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge481_subida_generica.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;this._of_parametros( )

of_Abre_Log(is_nome_arquivo)

io_sap_comum = Create uo_ge470_sap_comum

							
							

end event

event destructor;Destroy(io_sap_comum)

FileClose(ii_Log)
end event

