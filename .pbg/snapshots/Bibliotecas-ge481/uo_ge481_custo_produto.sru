HA$PBExportHeader$uo_ge481_custo_produto.sru
forward
global type uo_ge481_custo_produto from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_custo_produto from uo_ge481_subida_generica autoinstantiate
integer ii_contador_xml = 500
boolean ib_usa_cabecalho = false
end type

forward prototypes
public function boolean _of_parametros ()
public function boolean of_grava_log_exportacao (ref string ps_log)
public function boolean _of_monta_xml_cab (datastore pds_cab, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean of_processa_retorno (long al_nr_atualizacao, string as_xml, ref string as_log)
public subroutine of_processa_envio (long pl_nr_atualizacao)
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean of_busca_filial (long pl_nr_atualizacao, ref long pl_cd_filial, ref string ps_log)
public function boolean of_excluir_registro_invalido (ref string as_log)
end prototypes

public function boolean _of_parametros ();//is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
//						'<soapenv:Header/>'+&
//						'<soapenv:Body>'+&
//						'<exp:MT_Custo_Medio_Request>'
//							
//is_Termino_XML	=	'</exp:MT_Custo_Medio_Request>'+&
//							'</soapenv:Body>'+&
//							'</soapenv:Envelope>'
							
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">' + &
   '<soapenv:Header/>' + &
   '<soapenv:Body>' + &
   '<exp:MT_Custo_Medio_Request>'
							
is_Termino_XML = '</exp:MT_Custo_Medio_Request>' + &
   '</soapenv:Body>' + &
	'</soapenv:Envelope>'
	
	
is_DS = 'ds_ge481_custo_produto_historico'
is_Objeto = this.classname( )
is_nome_arquivo = 'custo_produto_xml'
is_Parametro_URL = 'CD_URL_ENVIO_FILIAL_CUSTO_SAP'
is_Tipo_Log_Exp = 'CUS'
is_Descricao_Tipo_Log = 'CUSTO_PRODUTO'
is_Nome_Interface = 'CUSTO PRODUTO'

return True
end function

public function boolean of_grava_log_exportacao (ref string ps_log);Boolean lb_Carga_Completa

decimal ldc_divisao, ldc_vl_custo_medio

long ll_linhas_filial, ll_for1, ll_for2, ll_for3, ll_nr_atualizacao, ll_cd_produto, ll_qt_saldo, ll_contador, ll_cd_filial, ll_linhas_prod, ll_progresso=0, ll_total_prod

string ls_filial, ls_erro, ls_nr_documento
string ls_DH_Carga_Completa
string ls_Ultima_Execucao

integer li_nr_envios

datetime ldt_data_hora, ldh_saldo

date ldt_data
date ldh_Carga_Completa

boolean lb_sucesso = true
dc_uo_ds_base lds_filiais, lds_produtos

Try

	lds_filiais = Create dc_uo_ds_base
	if Not lds_filiais.of_changedataobject( 'ds_ge481_custo_filial' ) Then
		ps_log = 'Erro ao localizar a datawindow "ds_ge481_custo_filial".'
		lb_sucesso = false
		return false
	end if
	
	lds_produtos = Create dc_uo_ds_base
	if Not lds_produtos.of_changedataobject( 'ds_ge481_custo_produto' ) Then
		ps_log = 'Erro ao localizar a datawindow "ds_ge481_custo_produto".'
		lb_sucesso = false
		return false
	end if
	
	ldt_data_hora = gf_getserverdate()
	ldt_data = date(ldt_data_hora)
	
	ll_linhas_filial = lds_filiais.retrieve( ldt_data )
	
	if ll_linhas_filial = 0 Then
		lb_sucesso = false
		return true
	end if
	
	for ll_for1 = 1 to ll_linhas_filial
	
		ll_cd_filial 					= lds_filiais.object.cd_filial			 		[ll_for1]
		ldh_saldo					= lds_filiais.object.dh_ultimo_saldo		[ll_for1]
		ls_DH_Carga_Completa 	= lds_filiais.object.dh_carga_completa	[ll_for1]
		
		If Not IsDate(ls_DH_Carga_Completa) Then
			ps_log = 'O par$$HEX1$$e200$$ENDHEX$$metro da loja DH_CARGA_COMPLETA_CUSTO_SD_SAP_PROXIMA n$$HEX1$$e300$$ENDHEX$$o esta com uma data v$$HEX1$$e100$$ENDHEX$$lida.'
			Return False
		End If
		
		ldh_Carga_Completa = Date(ls_DH_Carga_Completa)
	
		ls_filial = string(ll_cd_filial)
		
		lds_produtos.of_restoresqloriginal()
	
		If ldh_Carga_Completa  <= ldt_data Then
			lb_Carga_Completa = True
		Else
			lb_Carga_Completa = False
	   		lds_produtos.of_AppendWhere("coalesce(s.id_carregado_sap, 'N') = 'N'")
		End If
		
		ll_linhas_prod = lds_produtos.retrieve(ll_cd_filial, ldh_saldo)
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			if ll_linhas_prod = 0 Then
				w_aguarde_3.uo_progress_2.of_setmax(1)
			elseIf ll_linhas_prod < 0 Then
				ps_log = "Erro ao localizar os produtos da 'ds_ge481_custo_produto' (of_grava_log_exportacao)"
				//lds_produtos.GetLastErrorString()
				//ivo_dbError.ivs_SqlErrText 
				Return False
			Else
				w_aguarde_3.uo_progress_2.of_setmax(ll_linhas_prod)
			end if
			w_aguarde_3.wf_settext( "Filial: " + string(ll_cd_filial) + " (" + string(ll_for1) + " de " + string(ll_linhas_filial) + ")", 3)			
		end if
				
		if ll_linhas_prod = 0 Then
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			end if
			Continue
		end if
				
		ll_progresso = 0
		
		ldc_divisao = ll_linhas_prod / ii_contador_xml
		li_nr_envios = integer(ldc_divisao)
		
		if ldc_divisao > li_nr_envios Then
			li_nr_envios++
		end if
		
		ll_total_prod = 0
		
		for ll_for2 = 1 to li_nr_envios
			
			Declare sp_log Procedure for sp_log_exportacao_sap_prox_seq
			 @proximo_sequencial_retorno  = :ll_nr_atualizacao OUTPUT,
			 @mensagem_retorno = :ls_erro OUTPUT
			 USING SQLCA;
			
			 Execute sp_log;
			
			If sqlca.sqlcode = -1 then 
				ps_log = 'Erro ao executar a procedure "SP_LOG_EXPORTACAO_SAP_PROX_SEQ" (of_grava_log_exportacao): ' + sqlca.sqlerrtext 
				lb_sucesso = false
				return false
			end if
			
			Fetch sp_log Into :ll_nr_atualizacao, :ls_erro;
			
			Close sp_log;
			
			if ll_nr_atualizacao = -1 then
				ps_log = 'Erro ao executar a procedure "sp_log_exportacao_prox_seq" (of_grava_log_exportacao): ' + ls_erro
				lb_sucesso = false
				return false
			end if
			
			insert into log_exportacao_sap(nr_atualizacao,
													cd_filial, 
													id_tipo_nf,	
													dh_documento,
													dh_exportacao,
													cd_empresa,
													cd_chave,
													id_situacao_docto,
													id_status_integracao,
													cd_ambiente_sap)
			Values( :ll_nr_atualizacao,
						:ll_cd_filial,
						'CUS',
						:ldt_data,
						:ldt_data_hora,
						1000,
						:ls_filial,
						'C',
						'C',
						:is_Ambiente_SAP);
						
			if sqlca.sqlcode = -1 then 
				ps_log = 'Erro ao inserir registro na tabela "LOG_EXPORTACAO_SAP" (of_grava_log_exportacao): ' + sqlca.sqlerrtext
				lb_sucesso = false
				return false
			end if
			
			ll_contador = 0
			
			ll_linhas_prod = lds_produtos.rowcount( )
			
			if ll_total_prod = 0 or isnull(ll_total_prod) Then
				ll_total_prod = ll_linhas_prod
			end if
			
			for ll_for3 = 1 to ll_linhas_prod
		
				ldc_vl_custo_medio = lds_produtos.object.vl_custo_medio[ll_for3]
				ll_cd_produto = lds_produtos.object.cd_produto[ll_for3]
				ll_qt_saldo = lds_produtos.object.qt_saldo_final[ll_for3]
				ldh_saldo = lds_produtos.object.dh_saldo[ll_for3]
				
				ls_nr_documento = string(ll_for3)
		
				ll_progresso ++
		
				if isvalid(w_aguarde_3) Then
					w_Aguarde_3.wf_settext( 'Produto: ' + String(ll_cd_produto) + ' (' + String(ll_progresso) + ' de ' + string(ll_total_prod) + ')', 4)
				end if
		
				insert into log_exportacao_sap_historico( nr_atualizacao,
																	nr_documento,
																	dh_documento,
																	nr_item,
																	id_tipo_conta,
																	vl_documento,
																	cd_filial,
																	cd_produto,
																	qt_estoque_produto)
					values(:ll_nr_atualizacao,
							:ls_nr_documento,
							:ldt_data,
							:ll_for3,
							'X',
							:ldc_vl_custo_medio,
							:ll_cd_filial,
							:ll_cd_produto,
							:ll_qt_saldo);
				
				if sqlca.sqlcode = -1 then 
					ps_log = 'Erro ao inserir registro na tabela "LOG_EXPORTACAO_SAP_HISTORICO" (of_grava_log_exportacao): ' + sqlca.sqlerrtext
					lb_sucesso = false
					return false
				end if
				
				Update saldo_produto
				set id_carregado_sap = 'S'
				where cd_filial 			= :ll_cd_filial
					and cd_produto 	= :ll_cd_produto
					and dh_saldo 		= :ldh_saldo
				Using SqlCa;
					
				if sqlca.sqlcode = -1 then 
					ps_log = 'Erro ao atualizar registro na tabela "SALDO_PRODUTO" (of_grava_log_exportacao): ' + sqlca.sqlerrtext
					lb_sucesso = false
					return false
				end if
				
				if ll_for3 = ii_contador_xml Then
					lds_produtos.rowsdiscard(1,ll_for3, Primary!)
					Exit
				end if
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress_2.of_setprogress(ll_progresso)	
				end if
			
			next // produtos
			
			if lb_sucesso = True Then
				Commit;
			end if
			
		next // envios
		
		If lb_Carga_Completa Then
			
			update parametro_loja
			Set vl_parametro = '31/12/2099'
			Where cd_parametro = 'DH_CARGA_COMPLETA_CUSTO_SD_SAP_PROXIMA' 
				and cd_filial 		= :ll_cd_filial
			Using SqlCa;
			
			if sqlca.sqlcode = -1 then 
				ps_log = 'Erro ao atualizar par$$HEX1$$e200$$ENDHEX$$metro "DH_CARGA_COMPLETA_CUSTO_SD_SAP_PROXIMA" da loja (of_grava_log_exportacao): ' + sqlca.sqlerrtext
				lb_sucesso = false
				return false
			end if
			
			If Sqlca.SQLNRows = 0 Then
				ps_log = 'Par$$HEX1$$e200$$ENDHEX$$metro "DH_CARGA_COMPLETA_CUSTO_SD_SAP_PROXIMA" da loja (of_grava_log_exportacao)'
				lb_sucesso = false
				return false
			End If
			
			If Sqlca.SQLNRows > 1 Then
				ps_log = 'Foram atualizados mais par$$HEX1$$e200$$ENDHEX$$metos que o esperado 1 (of_grava_log_exportacao)'
				lb_sucesso = false
				return false
			End If
			
			ls_Ultima_Execucao = String(ldt_data, 'dd/mm/yyyy')
		
			update parametro_loja
			Set vl_parametro = :ls_Ultima_Execucao
			Where cd_parametro = 'DH_CARGA_COMPLETA_CUSTO_SD_SAP_ULTIMA' 
				and cd_filial 		= :ll_cd_filial
			Using SqlCa;
			
			if sqlca.sqlcode = -1 then 
				ps_log = 'Erro ao atualizar par$$HEX1$$e200$$ENDHEX$$metro "DH_CARGA_COMPLETA_CUSTO_SD_SAP_ULTIMA" da loja n$$HEX1$$e300$$ENDHEX$$o localizado (of_grava_log_exportacao): ' + sqlca.sqlerrtext
				lb_sucesso = false
				return false
			end if
			
			If Sqlca.SQLNRows > 1 Then
				ps_log = 'Foram atualizados mais par$$HEX1$$e200$$ENDHEX$$metos que o esperado 1 (of_grava_log_exportacao)'
				lb_sucesso = false
				return false
			End If
			
			If Sqlca.SQLNRows = 0 Then
				ps_log = 'Par$$HEX1$$e200$$ENDHEX$$metro "DH_CARGA_COMPLETA_CUSTO_SD_SAP_ULTIMA" da loja n$$HEX1$$e300$$ENDHEX$$o localizado (of_grava_log_exportacao)'
				lb_sucesso = false
				return false
			End If
		
		End If
		
		SqlCa.of_Commit();
			
	next // Filial
	
Finally
	
	if lb_sucesso = False Then
		Rollback;
	end if
	
	if isvalid(lds_produtos) Then Destroy(lds_produtos)
	if isvalid(lds_filiais) Then Destroy(lds_filiais)
	
End Try

return true
end function

public function boolean _of_monta_xml_cab (datastore pds_cab, long pl_linha, ref string ps_xml, ref string ps_log);
string ls_cd_filial

ls_cd_filial = pds_cab.object.cd_filial_sap[pl_linha]

ps_xml += '<cd_filial_sap>' + ls_cd_filial + '</cd_filial_sap>'

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);string ls_cd_filial_sap, ls_cd_produto_sap, ls_qt_estoque, ls_vl_custo

ls_cd_filial_sap = pds_dados.object.cd_filial_sap[pl_linha]
ls_cd_produto_sap = pds_dados.object.cd_produto_sap[pl_linha]
ls_qt_estoque = String(pds_dados.object.qt_estoque_produto[pl_linha])
ls_vl_custo = gf_Valor_Com_Ponto(pds_dados.object.vl_documento[pl_linha])

ps_xml += '<item>'
ps_xml += '<cd_filial_sap>' + ls_cd_filial_sap + '</cd_filial_sap>'
ps_xml += '<cd_produto_sap>' + ls_cd_produto_sap + '</cd_produto_sap>'
ps_xml += '<qt_estoque>' + ls_qt_estoque + '</qt_estoque>'
ps_xml += '<vl_custo_medio>' + ls_vl_custo + '</vl_custo_medio>'
ps_xml += '</item>'

return true
end function

public function boolean of_processa_retorno (long al_nr_atualizacao, string as_xml, ref string as_log);long ll_pos_ini, ll_pos_fim
string ls_tag_ini = '<status>', ls_tag_fim = '</status>', ls_resposta

ll_pos_ini = pos(as_xml, ls_tag_ini)

ll_pos_fim = pos(as_xml, ls_tag_fim)

if ll_pos_ini > 0 and ll_pos_fim > 0 Then
	
	ll_pos_ini = ll_pos_ini + len(ls_tag_ini)
	
	ls_resposta = mid( as_xml, ll_pos_ini, ll_pos_fim - ll_pos_ini )
	
	If ls_resposta = 'S' Then
		//Sucesso
		Return True
	else
		//Falha
		
		update log_exportacao_sap
		set id_status_integracao = 'E', dh_exportacao = getdate(), de_erro = 'WebService SAP retornou falha na integra$$HEX2$$e700e300$$ENDHEX$$o.'
		Where nr_atualizacao = :al_nr_atualizacao;
			
		if sqlca.sqlcode = -1 then
			as_log = 'Problemas ao atualizar registro na tabela "LOG_EXPORTACAO_SAP" (of_processa_retorno): ' + SQLCA.SQLErrtext
			return false
		end if	
			
		Commit;	
		
	end if
	
else
	//N$$HEX1$$e300$$ENDHEX$$o encontrou resposta
	as_log = 'Retorno do webservice SAP n$$HEX1$$e300$$ENDHEX$$o encontrado.'
	Return False
end if

return true
end function

public subroutine of_processa_envio (long pl_nr_atualizacao);string ls_grava_xml
string ls_log
string ls_xml
string ls_xml_item
string ls_xml_cab
string ls_Xml_Retorno
long ll_log
long ll_linha
long ll_linhas, ll_linhas_filial
long ll_for
long ll_seq_xml=0
long ll_situacao_pendente
long ll_progresso, ll_progresso_interface=0
long ll_contador
Long ll_cd_filial, ll_existe, ll_nr_atualizacao, ll_total_controles, ll_nr_atualizacao_ant
date ldt_data

dc_uo_ds_base lds_produtos, lds_filiais

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log )

gvs_Log_Geral = ''

ls_Grava_XML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "Grava_XML", "")

if pl_nr_atualizacao > 0 Then
	ib_monitor_exp=True
end if

try 
	
	If Not isValid(w_aguarde_3) Then 
		open(w_aguarde_3)
		w_aguarde_3.Title = 'Atualizando SALDO e CUSTO - SD'
		//w_aguarde_3.wf_settext('SALDO & CUSTO - SD', 1)
	End If
	
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress.of_setmax(5)
		w_aguarde_3.wf_settext('Validando configura$$HEX2$$e700f500$$ENDHEX$$es da interface...', 2)
	end if
	
	lds_produtos = Create dc_uo_ds_base
	lds_filiais = Create dc_uo_ds_base
	
	ll_Log = FileLength(is_Arquivo_Log)
	
	If Not of_ambiente_sap(ref ls_log) Then
		lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return 
	End If
		
	If Not lds_produtos.of_ChangeDataObject(is_DS, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS + "' - " + is_Objeto, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not lds_filiais.of_ChangeDataObject('ds_ge481_custo_filial_log', False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS + "' - " + is_Objeto, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	
	If Not gf_retorna_pametro_sap(SQLCA, is_Ambiente_SAP, is_Parametro_URL, ref is_URL, ref ls_log) Then
		lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return 
	End If
	
	ldt_data = date(gf_getserverdate())
	
	//Se for uma execu$$HEX2$$e700e300$$ENDHEX$$o individual pelo monitor de exporta$$HEX2$$e700e300$$ENDHEX$$o, n$$HEX1$$e300$$ENDHEX$$o executa as etapas a seguir.
	if Not ib_monitor_exp Then
	
		if isvalid(w_aguarde_3) Then
			ll_progresso_interface++
			w_aguarde_3.uo_progress.of_setprogress(ll_progresso_interface)
			w_aguarde_3.wf_settext('Excluindo registros inv$$HEX1$$e100$$ENDHEX$$lidos...', 2)
		end if
		
		if Not of_excluir_registro_invalido(ref ls_log) Then
			lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
			return 
		end if
		
		if isvalid(w_aguarde_3) Then
			ll_progresso_interface++
			w_aguarde_3.uo_progress.of_setprogress(ll_progresso_interface)
			w_aguarde_3.wf_settext('Gravando Log Exporta$$HEX2$$e700e300$$ENDHEX$$o...', 2)
		end if
		
		if Not this.of_grava_log_exportacao( ref ls_log) Then
			lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
			Return
		end if
		
	End if
	
	if isvalid(w_aguarde_3) Then
		ll_progresso_interface++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_interface)
		
		w_aguarde_3.wf_settext('Buscando filiais...', 2)
	end if
	
	ll_linhas_filial = lds_filiais.retrieve( ldt_data )
	
	if isvalid(w_aguarde_3) Then
		ll_progresso_interface++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_interface)
	end if
	
	if ll_linhas_filial = -1 then
		lf_ge470_log('Erro ao consultar o banco de dados. DW: ds_ge481_custo_filial_log' , 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
		Return
	end if
	
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.wf_settext('Enviando informa$$HEX2$$e700f500$$ENDHEX$$es para o SAP...', 2)
	end if
	
	if pl_nr_atualizacao > 0 Then
		
		this._of_filtra_nr_atualizacao( ref lds_produtos, pl_nr_atualizacao, ref ls_log )
		
		//Busca a filial relacionada ao registro
		if Not of_busca_filial(pl_nr_atualizacao, ref ll_cd_filial, ref ls_log) Then
			lf_ge470_log(ls_log , 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
			Return
		end if
		
		//Filtra a dataStore para deixar somente a filial do registro.
		if ll_cd_filial > 0 Then
			lds_filiais.setfilter('cd_filial = ' + string(ll_cd_filial) )
			lds_filiais.filter()
			
			ll_linhas_filial = lds_filiais.rowcount( )
		end if
	end if
	
	//Percorre cada filial
	For ll_linha = 1 to ll_linhas_filial
		
		ls_xml = ''
		ls_xml_cab = ''
		ls_xml_item = ''	
		
		ll_cd_filial = lds_filiais.object.cd_filial[ll_linha]
				
		ll_linhas = lds_produtos.retrieve(ll_cd_filial, ldt_data)
	
		if ll_linhas = -1 then
			lf_ge470_log('Erro ao consultar o banco de dados. DW: ds_ge481_custo_produto_historico' , 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
			Return
		end if		
		
		ll_progresso = 0
		
		ll_total_controles = lds_produtos.object.c_total_controles[ll_linhas]
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_total_controles)
			w_Aguarde_3.wf_settext( "Filial: " + string(ll_cd_filial) + " (" + string(ll_linha) + " de " + string(ll_linhas_filial) + ")", 3)
		end if
		
		//Percorre cada registro para montar o xml.
		for ll_for = 1 to ll_linhas
			
			ll_nr_atualizacao = lds_produtos.object.nr_atualizacao[ll_for]
			
			if ll_nr_atualizacao_ant <> ll_nr_atualizacao or ll_nr_atualizacao_ant = 0 or isnull(ll_nr_atualizacao_ant) Then
				
				ll_nr_atualizacao_ant = ll_nr_atualizacao
			
				ll_progresso++
				
				if isvalid(w_aguarde_3) Then
					w_Aguarde_3.wf_settext( 'Controle: ' + String(ll_nr_atualizacao) + ' (' + String(ll_progresso) + ' de ' + string(ll_total_controles) + ')', 4)
				end if
				
			end if
			
			ll_contador++
			
			if ll_contador = 1 Then
				if Not this._of_monta_xml_cab( lds_filiais, ll_linha, ref ls_xml_cab, ref ls_log ) Then
					lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					return
				end if
			end if
			
			if Not this._of_monta_xml_item( lds_produtos, ll_for, ref ls_xml_item, ref ls_log) Then
				lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
				return
			end if
			
			if ll_contador >= ii_contador_xml or ll_for >= ll_linhas Then
			
				if ls_xml_item = '' or isnull(ls_xml_item) Then Continue
		
				ls_XML =	 is_Inicio_XML 
				
				if ls_xml_cab <> '' Then ls_xml += ls_xml_cab
				if ls_xml_item <> '' Then ls_xml += ls_xml_item
				
				ls_xml += is_Termino_XML
				
				If ls_Grava_XML = "S" Then
					ll_seq_xml++
					This.of_grava_xml(ls_XML, ll_seq_xml)
				End If
				
				if ib_envia_webService = True Then
					If not io_sap_comum.of_Envia_Webservice(is_URL, ls_XML, Ref ls_Xml_Retorno, Ref ls_log) Then
						SqlCa.of_Rollback()
						lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					End If
					
					if Not of_processa_retorno(ll_nr_atualizacao, ls_xml_retorno, ref ls_log) Then
						lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
					end if
					
					//Atualiza situa$$HEX2$$e700e300$$ENDHEX$$o do registro para processado
					if of_atualiza_processado(lds_produtos, ll_for, ref ls_log) = false then
						lf_ge470_log(ls_log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
						Return
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
					w_aguarde_3.uo_progress_2.of_setprogress(ll_progresso)	
				end if
				
			end if
		
		Next
		
	Next
	
	if isvalid(w_aguarde_3) Then
		ll_progresso_interface++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_interface)
	end if
	
catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o [" + is_DS + "], objeto ["+ is_Objeto +"]. Erro: "+lo_rte.GetMessage())
	Return
finally
	
	If FileLength(is_Arquivo_Log) > ll_Log Then
		SqlCa.of_Rollback()
	End if
	
	If not gvb_Auto and ib_monitor_exp = false Then
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
	
end try
end subroutine

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);//Filtra a datastore para trazer um registro espec$$HEX1$$ed00$$ENDHEX$$fico.

if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere_subquery( 'ls.nr_atualizacao = ' + String(pl_nr_atualizacao), 2 )
else
	pds_dados.of_appendwhere_subquery( "ls.id_status_integracao = 'C' " , 2 )
end if

return true
end function

public function boolean of_busca_filial (long pl_nr_atualizacao, ref long pl_cd_filial, ref string ps_log);
Select cd_filial
into :pl_cd_filial
from log_exportacao_sap
where nr_atualizacao = :pl_nr_atualizacao;

if sqlca.sqlcode = -1 then 
	ps_log = 'Problemas ao consultar a tabela "log_exportacao_sap": ' + sqlca.sqlerrtext
	return false
end if

return true
end function

public function boolean of_excluir_registro_invalido (ref string as_log);Long ll_Atualizacao
Long ll_Filial
Long ll_Linhas
Long ll_Linha

DateTime ldh_Saldo

dc_uo_ds_base lds

try 
	lds = Create dc_uo_ds_base
		
	If Not lds.of_ChangeDataObject('ds_ge481_custo_log_exclusao', False) Then
		as_log = "Erro ao alterar a DW 'ds_ge481_custo_log_exclusao' - " + is_Objeto
		Return False
	End If
	
	ll_Linhas = lds.Retrieve()
	
	If ll_Linhas < 0 Then
		as_log = "Erro ao recuperar os dados da DW 'ds_ge481_custo_log_exclusao' - " + is_Objeto
		Return False
	End If
	
	For ll_Linha = 1 To ll_Linhas
		
		ll_Atualizacao 	= lds.Object.nr_atualizacao		[ll_Linha]
		ll_Filial 			= lds.Object.cd_filial				[ll_Linha]
		ldh_Saldo		= lds.Object.dh_ultimo_saldo	[ll_Linha]
		
		update log_exportacao_sap
		set id_status_integracao = 'X', dh_exportacao = getdate()
		Where nr_atualizacao = :ll_Atualizacao
		Using SqlCa;
			
		if sqlca.sqlcode = -1 then
			as_log = 'Problemas ao atualizar registro na tabela "LOG_EXPORTACAO_SAP" (of_excluir_registro_invalido): ' + SQLCA.SQLErrtext
			return false
		end if	
		
		update saldo_produto
		set id_carregado_sap = 'N'
		where cd_filial = :ll_Filial
		  and dh_saldo = :ldh_Saldo
		  and coalesce(id_carregado_sap, 'N') = 'S'
		  and cd_produto in ( select cd_produto from log_exportacao_sap_historico where nr_atualizacao = :ll_Atualizacao)
		Using SqlCa;
		
		if sqlca.sqlcode = -1 then
			as_log = 'Problemas ao atualizar registro na tabela "SALDO_PRODUTO" (of_excluir_registro_invalido): ' + SQLCA.SQLErrtext
			SqlCa.of_Rollback()
			return false
		end if	
		
		SqlCa.of_Commit()		
	Next

catch (RuntimeError lo_rte)
	as_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o [" + is_DS + "], objeto ["+ is_Objeto +"]. Erro: "+lo_rte.GetMessage()
	Return False
finally
	Destroy lds	
end try

return true
	


end function

on uo_ge481_custo_produto.create
call super::create
end on

on uo_ge481_custo_produto.destroy
call super::destroy
end on

