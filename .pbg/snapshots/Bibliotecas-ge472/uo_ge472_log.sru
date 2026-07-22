HA$PBExportHeader$uo_ge472_log.sru
forward
global type uo_ge472_log from nonvisualobject
end type
end forward

global type uo_ge472_log from nonvisualobject
event type boolean ue_inicializa ( long pl_empresa,  string ps_modulo,  string ps_ambiente_sap,  string ps_tipo_docto,  string ps_tipo_integracao,  string ps_path_arquivos,  boolean pb_log_por_lote )
event type boolean ue_conecta_db ( string ps_database,  string ps_datasource,  string ps_conexao )
end type
global uo_ge472_log uo_ge472_log

type variables
Private:
Constant String DBMS_SYBASE = 'SYBASE'
Constant String DBMS_MULT 	 = 'ORACLE'

String Ambiente_SAP
Long Mandante
String Modulo
Long Empresa
String Path_Arquivos=""
String Registro
String Tipo_Documento
String Tipo_Integracao
String URL_Envio
Boolean Log_Por_Lote=False

Long Item
String Chave_Integracao
String Chave_Docto
String ID_Docto
String ID_Docto_Ref
Long ivl_Filial
Decimal{0} ivdc_Docto
Decimal{0} ivdc_Transacao
String ivs_Especie
String ivs_Fornecedor
String ivs_Serie

Longlong ivl_Lote_Envio
Longlong ivl_ID_Docto_Log
String Situacao_Docto = ""

Integer ivi_Arquivo_Log
String ivs_Arquivo_Log
String ivs_executor = ''

date ivdt_abertura_log

dc_uo_ds_base ivds_Log_Email
dc_uo_ds_base ivds_Controle

uo_ge472_webservice ivo_WebService

dc_uo_transacao ivtr_Log
dc_uo_transacao ivtr_Oracle
dc_uo_transacao ivtr_Sybase
end variables

forward prototypes
public function boolean of_retorna_log (string ps_setor, ref string ps_log, ref long pl_erros, ref long pl_advertencias, ref long pl_informacoes)
private function boolean of_carrega_arquivo_log ()
public function boolean of_grava_log (string ps_tipo_responsavel, string ps_tipo_log, string ps_mensagem, boolean pb_grava_bd)
public function boolean of_grava_log (string ps_tipo_responsavel, string ps_tipo_log, string ps_mensagem)
public function long of_retorna_status_exportacao_docto (string ps_chave_nf)
public function boolean of_retorna_resultado (ref long pl_erros, ref long pl_advertencias, ref long pl_informacoes)
public function boolean of_proximo_log (long pl_tentativa, ref longlong pl_id_log)
public function boolean of_altera_situacao_log (longlong pl_lote, string ps_situacao, string ps_mensagem)
public function boolean of_grava_log (string ps_tipo_responsavel, string ps_tipo_log, string ps_mensagem, boolean pb_grava_bd, boolean pb_envia_email, boolean pb_grava_arquivo)
public function Boolean of_grava_log (string ps_tipo_responsavel, string ps_tipo_log, string ps_mensagem, boolean pb_grava_bd, boolean pb_envia_email)
public function boolean of_limpa_log (boolean pb_email)
public function boolean of_altera_situacao_log_nr_atualizacao (longlong pl_nr_atualizacao, string ps_ambiente)
public function boolean of_retorna_informacoes_docto (string ps_chave_integracao, ref longlong pl_id_docto_log, ref string ps_chave_docto, ref long pl_filial, ref string ps_fornecedor, ref decimal pdc_docto, ref decimal pdc_transacao, ref string ps_especie, ref string ps_serie)
public function longlong of_retorna_id_tdf (longlong pll_id_docto)
public function boolean of_abre_log (string ps_chave_integracao, string ps_chave_docto, long pl_filial, decimal pdc_nf, decimal pdc_transacao, string ps_especie, string ps_serie, datetime pdh_docto, long pl_lote, ref longlong pl_log)
public function boolean of_abre_log (string ps_chave_integracao, string ps_chave_docto, string ps_docto_id, long pl_filial, string ps_fornecedor, decimal pdc_nf, decimal pdc_transacao, string ps_especie, string ps_serie, datetime pdh_docto, string ps_id_docto_ref, longlong pl_lote, ref longlong pl_log)
public function boolean of_abre_log (string ps_chave_integracao, string ps_chave_docto, string ps_id_docto, long pl_filial, string ps_fornecedor, decimal pdc_nf, decimal pdc_transacao, string ps_especie, string ps_serie, datetime pdh_docto, long pl_lote, ref longlong pl_log)
public function boolean of_envia_email (long pl_email_informatica, long pl_email_financeiro, long pl_email_fiscal, long pl_email_ecommerce, long pl_email_teste)
public function longlong of_retorna_id_tdf (string ps_tipo_id_docto)
public function boolean of_altera_bd_log (string ps_banco)
public function boolean of_set_transacao (dc_uo_transacao ao_transacao)
public function boolean of_set_item (any p_value)
public function boolean of_retorna_informacoes_docto (string p_cd_setor, string p_cd_tipo_log)
public function boolean of_grava_log_retorno (longlong pl_atualizacao_log, long pl_item_sequencial, string ps_tipo_log, string ps_classe_log, long pl_mensagem, string ps_log, string ps_complemento_log)
public function boolean of_grava_log_retorno (longlong pl_atualizacao_log, long pl_item_sequencial, string ps_tipo_log, string ps_setor, string ps_classe_log, long pl_mensagem, string ps_log, string ps_complemento_log)
public subroutine of_set_id_docto_log (longlong all_id_docto_log)
public function boolean of_grava_docsap (string ps_cd_chave_docto, string ps_docto_sap)
end prototypes

event type boolean ue_inicializa(long pl_empresa, string ps_modulo, string ps_ambiente_sap, string ps_tipo_docto, string ps_tipo_integracao, string ps_path_arquivos, boolean pb_log_por_lote);Try
	//Seta vari$$HEX1$$e100$$ENDHEX$$veis de sess$$HEX1$$e300$$ENDHEX$$o
	Ambiente_SAP			= ps_ambiente_sap
	Mandante				= IIF(IsNumber(Ambiente_SAP), Long(Mandante), 000)
	Modulo					= ps_modulo
	Empresa					= pl_empresa
	Tipo_Documento		= ps_tipo_docto
	Tipo_Integracao		= ps_tipo_integracao
	Path_Arquivos			= ps_path_arquivos
	Log_Por_Lote			= pb_log_por_lote
	If IsNull(Path_Arquivos) or (Trim(Path_Arquivos)="") Then	Path_Arquivos = gvo_aplicacao.ivs_path_arquivos
	
	//Zera vari$$HEX1$$e100$$ENDHEX$$veis de inst$$HEX1$$e200$$ENDHEX$$ncia
	Chave_Integracao	= ""
	Chave_Docto		= ""
	
	//Carrega Arquivo de Log
	If Not ivi_Arquivo_Log > 0 Then This.of_Carrega_Arquivo_Log()
	
	//Limpa Datawindow de controle
	ivds_Controle.Reset()

Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage())
	Return False

Finally
	//
End Try

Return True
end event

event type boolean ue_conecta_db(string ps_database, string ps_datasource, string ps_conexao);Try
	//Cria vari$$HEX1$$e100$$ENDHEX$$vel local
	dc_uo_transacao lvtr_Log
	//Conex$$HEX1$$e300$$ENDHEX$$o com BD (pode ser Mult ou Sybase)
	lvtr_Log = Create dc_uo_transacao
	lvtr_Log.of_SetDataBase(ps_database)
	lvtr_Log.Database = ps_database
	//Grava somente os logs na base, ent$$HEX1$$e300$$ENDHEX$$o pode ser autocommit
	lvtr_Log.AutoCommit = True
	//Efetua conex$$HEX1$$e300$$ENDHEX$$o
	If Not lvtr_Log.of_Connect( ps_datasource, ps_conexao) Then Return False
	
	//Seta transa$$HEX2$$e700e300$$ENDHEX$$o e armazena nas transaction de inst$$HEX1$$e200$$ENDHEX$$ncia
	If Not This.Of_Set_Transacao(lvtr_Log) Then Return False

Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage())
	Return False

Finally
	//
End Try

Return True
end event

public function boolean of_retorna_log (string ps_setor, ref string ps_log, ref long pl_erros, ref long pl_advertencias, ref long pl_informacoes);Long lvl_Linha
Long lvl_Count = 0
String lvs_Chave
String lvs_Log
String lvs_Tipo
String lvs_Tipo_Desc
String lvs_Tipo_Ant, lvs_grupo
Datetime lvdh_Log

Try
	
	ps_log = ""
	
	if ps_setor = 'FIN' then //financeiro cartoes
		lvs_grupo = ", Grupo Financeiro cart$$HEX1$$f500$$ENDHEX$$es"
	elseif ps_setor = 'FIS' then //fis
		lvs_grupo = ", Grupo Fiscal"
	elseif ps_setor = 'INF' then //inf
		lvs_grupo = ", Grupo Inform$$HEX1$$e100$$ENDHEX$$tica"
	elseif ps_setor = 'FIT' then //financeiro titulos
		lvs_grupo = ", Grupo Financeiro T$$HEX1$$ed00$$ENDHEX$$tulos"
	end if	
	
	if ivs_executor = 'CAR' then
		
		choose case ps_setor
			case 'FIN', 'FIS'
			
				if (hour(now()) >= 0 and hour(now()) < 10) then
	
					this.of_retorna_informacoes_docto(ps_setor, 'E' )				
			
					ivds_Log_Email.SetFilter("nr_atualizacao<>''")
					ivds_Log_Email.Filter()
					ivds_Log_Email.GroupCalc( )
					
					pl_erros			= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_erros")
					pl_advertencias	= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_advertencias")
					pl_informacoes	= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_informacao")
					
					For lvl_Linha = 1 To ivds_Log_Email.RowCount()
						lvdh_Log 	= ivds_Log_Email.Object.dh_log 				[lvl_Linha]
						lvs_Log		= ivds_Log_Email.Object.de_log 				[lvl_Linha]
						lvs_Tipo		= ivds_Log_Email.Object.cd_tipo_log			[lvl_Linha]
						lvs_Chave	= ivds_Log_Email.Object.cd_chave_docto	[lvl_Linha]
						
						If (Not IsNull(lvs_Log) and (Trim(lvs_Log) <> "")) Then
							If lvs_Tipo_Ant <> lvs_Tipo Then
								If lvl_Count > 0 then ps_log += "</ul><br />"
								ps_log += "<b>"+"Favor tratar o(s) caso(s) abaixo:"+"</b><br /><ul>"
							End If
							lvl_Count ++
							ps_log += "<li>"+IIF(lvs_Chave<>"",lvs_Chave+": ", "")+lvs_Log+"</li>~n"
							lvs_Tipo_Ant = lvs_Tipo
						End If
					Next
					
					If Not IsNull(ps_log) and (Trim(ps_log) <> "") Then ps_log += "</ul>~n~r"
					If Not IsNull(ps_log) and (Trim(ps_log) <> "") Then ps_log += "<br /><br /><b>AMBIENTE SAP: "+String(Ambiente_SAP)+"</b>~n~r"+lvs_grupo
					
				end if
				
			case else
		
				ivds_Log_Email.SetFilter("cd_setor='"+ps_setor+"'")
				ivds_Log_Email.Filter()
				ivds_Log_Email.GroupCalc( )
				
				pl_erros			= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_erros")
				pl_advertencias	= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_advertencias")
				pl_informacoes	= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_informacao")
				
				For lvl_Linha = 1 To ivds_Log_Email.RowCount()
					lvdh_Log 	= ivds_Log_Email.Object.dh_log 				[lvl_Linha]
					lvs_Log		= ivds_Log_Email.Object.de_log 				[lvl_Linha]
					lvs_Tipo		= ivds_Log_Email.Object.cd_tipo_log			[lvl_Linha]
					lvs_Chave	= ivds_Log_Email.Object.cd_chave_docto	[lvl_Linha]
					
					If (Not IsNull(lvs_Log) and (Trim(lvs_Log) <> "")) Then
						If lvs_Tipo_Ant <> lvs_Tipo Then
							If lvl_Count > 0 then ps_log += "</ul><br />"
							
							Choose Case lvs_Tipo
								Case "E"
									lvs_Tipo_Desc = "ERRO(S) - INFORMA$$HEX2$$c700d500$$ENDHEX$$ES"
								Case "V"
									lvs_Tipo_Desc = "ERRO(S) - VALIDA$$HEX2$$c700c300$$ENDHEX$$O CAR/TDF"
								Case "F"
									lvs_Tipo_Desc = "ERRO(S) - WEBSERVICE"
								Case "A"
									lvs_Tipo_Desc = "ALERTA(S)"
								Case Else
									lvs_Tipo_Desc = "INFORMA$$HEX2$$c700c300$$ENDHEX$$O($$HEX1$$d500$$ENDHEX$$ES)"
							End Choose
										
							ps_log += "<b>"+lvs_Tipo_Desc+"</b><br /><ul>"
						End If
						
						lvl_Count ++
						ps_log += "<li>"+IIF(lvs_Chave<>"",lvs_Chave+": ", "")+lvs_Log+"</li>~n"
					
						lvs_Tipo_Ant = lvs_Tipo
					End If
				Next
				
				If Not IsNull(ps_log) and (Trim(ps_log) <> "") Then ps_log += "</ul>~n~r"
				If Not IsNull(ps_log) and (Trim(ps_log) <> "") Then ps_log += "<br /><br /><b>AMBIENTE SAP: "+String(Ambiente_SAP)+"</b>~n~r"+lvs_grupo 

		end choose			
		
	else
		
		ivds_Log_Email.SetFilter("cd_setor='"+ps_setor+"'")
		ivds_Log_Email.Filter()
		ivds_Log_Email.GroupCalc( )
		
		pl_erros			= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_erros")
		pl_advertencias	= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_advertencias")
		pl_informacoes	= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_informacao")
		
		For lvl_Linha = 1 To ivds_Log_Email.RowCount()
			lvdh_Log 	= ivds_Log_Email.Object.dh_log 				[lvl_Linha]
			lvs_Log		= ivds_Log_Email.Object.de_log 				[lvl_Linha]
			lvs_Tipo		= ivds_Log_Email.Object.cd_tipo_log			[lvl_Linha]
			lvs_Chave	= ivds_Log_Email.Object.cd_chave_docto	[lvl_Linha]
			
			If (Not IsNull(lvs_Log) and (Trim(lvs_Log) <> "")) Then
				If lvs_Tipo_Ant <> lvs_Tipo Then
					If lvl_Count > 0 then ps_log += "</ul><br />"
					
					Choose Case lvs_Tipo
						Case "E"
							lvs_Tipo_Desc = "ERRO(S) - INFORMA$$HEX2$$c700d500$$ENDHEX$$ES"
						Case "V"
							lvs_Tipo_Desc = "ERRO(S) - VALIDA$$HEX2$$c700c300$$ENDHEX$$O CAR/TDF"
						Case "F"
							lvs_Tipo_Desc = "ERRO(S) - WEBSERVICE"
						Case "A"
							lvs_Tipo_Desc = "ALERTA(S)"
						Case Else
							lvs_Tipo_Desc = "INFORMA$$HEX2$$c700c300$$ENDHEX$$O($$HEX1$$d500$$ENDHEX$$ES)"
					End Choose
								
					ps_log += "<b>"+lvs_Tipo_Desc+"</b><br /><ul>"
				End If
				
				lvl_Count ++
				ps_log += "<li>"+IIF(lvs_Chave<>"",lvs_Chave+": ", "")+lvs_Log+"</li>~n"
			
				lvs_Tipo_Ant = lvs_Tipo
			End If
		Next
		
		If Not IsNull(ps_log) and (Trim(ps_log) <> "") Then ps_log += "</ul>~n~r"
		If Not IsNull(ps_log) and (Trim(ps_log) <> "") Then ps_log += "<br /><br /><b>AMBIENTE SAP: "+String(Ambiente_SAP)+"</b>~n~r"+lvs_grupo
		
	end if

Catch (RuntimeError lvo_rte)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_rte.RoutineName+"().~r"+lvo_rte.GetMessage())
	Return False

Finally
	ivds_Log_Email.SetFilter("")
	ivds_Log_Email.Filter()
End Try

Return True
end function

private function boolean of_carrega_arquivo_log ();Double lvl_tamanho_log
String lvs_log_antigo
String lvs_Dir_Log
Integer lvi_Tentativas
Integer lvi_Arquivo

Try
	//Localiza parametros para abertura do arquivo
	lvs_Dir_Log	= ProfileString(gvo_aplicacao.ivs_arquivo_ini,Modulo, "Diretorio_Log", "")
	lvs_Dir_Log	= IIF(lvs_Dir_Log="", Path_Arquivos, lvs_Dir_Log)
	lvs_Dir_Log	= IIF(lvs_Dir_Log="", gvo_aplicacao.ivs_path_arquivos, lvs_Dir_Log)
	If Not DirectoryExists(lvs_Dir_Log) Then CreateDirectory(lvs_Dir_Log)
	ivs_Arquivo_Log	= lvs_Dir_Log+"\"+Modulo+IIF(Ambiente_SAP="","", "_"+Ambiente_SAP)+".log"
	lvl_tamanho_log 	= FileLength(ivs_Arquivo_Log)
	
	//Verifica tamanho e se necess$$HEX1$$e100$$ENDHEX$$rio quebra o arquivo
	If lvl_tamanho_log > 5000000 Then
		
		dc_uo_api lvo_Api
		lvo_Api = Create dc_uo_api
			
		lvs_log_antigo = Mid(ivs_Arquivo_Log, 1, Len(ivs_Arquivo_Log) - 4)+"_" + String(Now(),'yyyymmdd_hhmmss') + ".log"
			
		lvo_Api.of_Rename_File(ivs_Arquivo_Log, lvs_log_antigo, True)
				
		Destroy(lvo_Api)	
		
	End If
	
	//Verifica se conseguiu resolver o nome do arquivo
	If IsNull(ivs_Arquivo_Log) or Trim(ivs_Arquivo_Log) = "" Then Return False
	
	// Se der erro, tenta realizar a abertura do log por at$$HEX1$$e900$$ENDHEX$$ 3 vezes antes de retornar FALSE
	Do 
		lvi_Tentativas++
		lvi_Arquivo = FileOpen( This.ivs_Arquivo_LOG, LineMode!, Write!, Shared!, Append! )
		
		If lvi_Arquivo = -1 Then Sleep(2)
		
		If lvi_Tentativas >= 3 Then Exit
		
	Loop While (lvi_Arquivo = -1 )
	
	//Verifica se obteve sucesso na abertura do arquivo
	If lvi_Arquivo = -1 Then
		If Not gvb_auto Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo: " + This.ivs_Arquivo_Log+".", StopSign!, Ok! )
		Else
			gvo_aplicacao.of_Grava_Log("Erro na abertura do arquivo: " + This.ivs_Arquivo_Log+".")
		End If
		
		Return False
	Else
		ivi_Arquivo_Log = lvi_Arquivo
	End If
	
Catch (RuntimeError lvo_Erro)
	gvo_aplicacao.Of_Grava_Log(This.ClassName()+"."+lvo_Erro.RoutineName+"(): Falha ao abrir log do "+Modulo+".~r"+lvo_Erro.GetMessage())
	Return False
	
Finally
	//
End Try

Return True
end function

public function boolean of_grava_log (string ps_tipo_responsavel, string ps_tipo_log, string ps_mensagem, boolean pb_grava_bd);Return This.Of_Grava_Log(ps_tipo_responsavel, ps_tipo_log, ps_mensagem, pb_grava_bd, True, True)
end function

public function boolean of_grava_log (string ps_tipo_responsavel, string ps_tipo_log, string ps_mensagem);Return This.Of_Grava_Log(ps_tipo_responsavel, ps_tipo_log, ps_mensagem, True)
end function

public function long of_retorna_status_exportacao_docto (string ps_chave_nf);Long lvl_Status

Try
	ivds_Log_Email.SetFilter("cd_chave_integracao='"+ps_chave_nf+"'")
	ivds_Log_Email.Filter()
	
	If ivds_Log_Email.RowCount() = 0 Then
		lvl_Status = 1
	ElseIf ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_erros") > 0 Then
		lvl_Status = 3
	ElseIf ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_advertencias") > 0 Then
		lvl_Status = 2
	Else
		lvl_Status = 1
	End If
	
Catch (RuntimeError lvo_rte)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_rte.RoutineName+"().~r"+lvo_rte.GetMessage())
	Return 3

Finally
	//
End Try

Return lvl_Status
end function

public function boolean of_retorna_resultado (ref long pl_erros, ref long pl_advertencias, ref long pl_informacoes);Try
	ivds_Log_Email.SetFilter("")
	ivds_Log_Email.Filter()
	
	pl_erros					= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_erros")
	pl_advertencias			= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_advertencias")
	pl_informacoes			= ivds_Log_Email.GetItemNumber(ivds_Log_Email.RowCount(), "qt_total_informacao")
	
Catch (RuntimeError lvo_rte)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_rte.RoutineName+"().~r"+lvo_rte.GetMessage())
	Return False

Finally
	//
End Try

Return True
end function

public function boolean of_proximo_log (long pl_tentativa, ref longlong pl_id_log);String lvs_Log
String lvs_ID_Docto_Log

Try
	//Tenta por 10x caso n$$HEX1$$e300$$ENDHEX$$o consiga retorna falso
	If pl_tentativa > 10 Then Return False
	
	//Localiza n$$HEX1$$fa00$$ENDHEX$$mero atual
	select coalesce(vl_parametro, '0')
	Into :lvs_Log
	from parametro_geral
	Where cd_parametro = 'NR_LOG_SAP'
	Using ivtr_Log;
	
	//Verifica erro SQL
	If ivtr_Log.SQLCode = -1 Then
		ivtr_Log.Of_RollBack()
		This.Of_Grava_Log( "INF", "E",  "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo n$$HEX1$$fa00$$ENDHEX$$mero da tabela log_exportacao_docto "+ivtr_Log.is_lasterrortext)
		Return False
	Else
		//Se n$$HEX1$$e300$$ENDHEX$$o encontrou o parametro
		If ivtr_Log.SQLCode = 100 Then
			//Busca o maior n$$HEX1$$fa00$$ENDHEX$$mero registrado
			select cast(coalesce(max(nr_atualizacao), 0) as varchar(40))
			Into :lvs_Log
			from log_exportacao_docto
			Using ivtr_Log;
			
			//Trata nulo
			If IsNull(lvs_Log) Then lvs_Log = '0'
			
			//Insere par$$HEX1$$e200$$ENDHEX$$metro
			Insert into parametro_geral(cd_parametro, vl_parametro) 
			Values ('NR_LOG_SAP', :lvs_Log)
			Using ivtr_Log;
			
			//Se der erro faz uma reentrada na fun$$HEX2$$e700e300$$ENDHEX$$o, caso outra sess$$HEX1$$e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ dado insert
			If ivtr_Log.SQLCode = -1 Then Return This.of_Proximo_Log(pl_tentativa+1, ref pl_id_log)
			
			//Commit
			ivtr_Log.Of_Commit()
		End If
		
		//Incrementa o n$$HEX1$$fa00$$ENDHEX$$mero atual
		ivl_ID_Docto_Log	= Long(lvs_Log) + 1
		lvs_ID_Docto_Log	= String(ivl_ID_Docto_Log)
		
		//Atualiza o par$$HEX1$$e200$$ENDHEX$$metro na base
		update parametro_geral
		set vl_parametro = :lvs_ID_Docto_Log
		Where cd_parametro	= 'NR_LOG_SAP'
			and coalesce(vl_parametro,'0')	= :lvs_Log
		Using ivtr_Log;
		
		//Verifica erro SQL
		If ivtr_Log.SQLCode = -1 Then
			ivtr_Log.Of_RollBack()
			This.Of_Grava_Log( "INF", "E",  "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial do lote. Erro: "+ivtr_Log.is_LastErrorText)
			Return False
		
		//Caso n$$HEX1$$e300$$ENDHEX$$o tenha conseguido atualizar a linha $$HEX1$$e900$$ENDHEX$$ porque o par$$HEX1$$e200$$ENDHEX$$metro j$$HEX1$$e100$$ENDHEX$$ foi alterado por outra transa$$HEX2$$e700e300$$ENDHEX$$o
		ElseIf ivtr_Log.SQLNrows = 0 Then
			//Tenta novamente buscar o log
			This.of_Proximo_Log(pl_tentativa + 1, ref pl_id_log)			
		End If
		
		//Commita
		ivtr_Log.Of_Commit()
	End If
	
	//Grava na vari$$HEX1$$e100$$ENDHEX$$vel de retorno
	pl_id_log = ivl_ID_Docto_Log

Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage())
	Return False

Finally
	//
End Try

Return True
end function

public function boolean of_altera_situacao_log (longlong pl_lote, string ps_situacao, string ps_mensagem);Try
	update log_exportacao_docto
	set id_situacao_log = :ps_situacao,
		id_revisado = case when :ps_situacao = 'P' then 'S' else id_revisado end
	Where nr_lote_envio = :pl_lote
	Using ivtr_Log;
	
	If ivtr_Log.SQLCode = -1 Then
		ivtr_Log.Of_RollBack()
		This.Of_Grava_log("INF", "E", This.ClassName()+".of_log_altera_situacao(): Erro ao atualizar id_situacao_log na tabela log_exportacao_docto.~r"+ivtr_Log.is_lasterrortext)
		Return False
	End If
	
	//Somente em caso de falha na comunica$$HEX2$$e700e300$$ENDHEX$$o/envio
	If ps_situacao = "F" Then
		dc_uo_transacao lvtr_Cursor
		lvtr_Cursor = Create dc_uo_transacao
		lvtr_Cursor.of_SetDataBase(gvo_aplicacao.ivs_database)
		lvtr_Cursor.Database = gvo_aplicacao.ivs_database
		
		lvtr_Cursor.of_Connect( gvo_aplicacao.ivs_datasource, gvo_aplicacao.ivo_Seguranca.Cd_Sistema + "_" + gvo_aplicacao.of_UserId())
		
		/*Utiliza$$HEX2$$e700e300$$ENDHEX$$o do cursor com SQL fixo*/
		DECLARE lcu_log CURSOR FOR
		SELECT 	a.nr_atualizacao,
					a.cd_chave_docto,
					a.id_tipo_docto,
					a.cd_filial,
					a.nr_nf,
					a.nr_transacao,
					a.de_especie,
					a.de_serie
		FROM log_exportacao_docto a
		WHERE nr_lote_envio = :pl_lote
		group by a.nr_atualizacao
		Using lvtr_Cursor;
		
		// Declara$$HEX2$$e700e300$$ENDHEX$$o vari$$HEX1$$e100$$ENDHEX$$veis de destino
		Longlong lvl_Atualizacao
		
		// Abrindo o cursor
		OPEN lcu_log;
		
		// Buscar a primeira linha do resultado
		FETCH lcu_log INTO :ivl_ID_Docto_Log, :Chave_Integracao, :Tipo_Documento, :ivl_Filial, :ivdc_Docto, :ivdc_Transacao, :ivs_Especie, :ivs_Serie;
		
		// Repetir Enquanto Houver Linhas
		DO WHILE lvtr_Cursor.SQLCode = 0
			Chave_Docto = String(ivl_Filial, "0000")+"/"+String(ivdc_Docto)+"/"+ivs_Especie+"/"+ivs_Serie
			This.Of_Grava_Log( "INF", ps_situacao, ps_mensagem)
			
			//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
			FETCH lcu_log INTO :ivl_ID_Docto_Log, :Chave_Integracao, :Tipo_Documento, :ivl_Filial, :ivdc_Docto, :ivdc_Transacao, :ivs_Especie, :ivs_Serie;
		LOOP
		
		If lvtr_Cursor.SQLCode = -1 Then
			This.Of_Grava_log("INF", "E", This.ClassName()+".of_documento_altera_situacao(): Erro ao inserir na tabela log_exportacao_docto_det.~r"+lvtr_Cursor.SQLErrText)
			Return False
		End If
		
		// No fim fechar o cursor
		CLOSE lcu_log;
		
		If IsValid(lvtr_Cursor) Then lvtr_Cursor.Of_Disconnect( )
	End If
	
	ivtr_Log.Of_Commit()
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage())
	Return False
	
Finally
	//
End Try

Return True
end function

public function boolean of_grava_log (string ps_tipo_responsavel, string ps_tipo_log, string ps_mensagem, boolean pb_grava_bd, boolean pb_envia_email, boolean pb_grava_arquivo);Long lvl_Linha
Integer lvi_Tentativas
Integer lvi_Status
String lvs_Mensagem

Try
	If Not IsNull(ps_mensagem) and (ps_mensagem<>"") Then
		//Caso o arquivo n$$HEX1$$e300$$ENDHEX$$o esteja aberto tenta abrir
		If Not ivi_Arquivo_Log > 0 Then This.Of_Carrega_Arquivo_Log( )
		//Tenta gravar se o arquivo estiver aberto
		If ivi_Arquivo_Log > 0 Then
			//Grava no arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o
			lvs_Mensagem =	String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + ": " + ps_mensagem
				
			// Se der erro, tenta realizar a grava$$HEX2$$e700e300$$ENDHEX$$o do log por at$$HEX1$$e900$$ENDHEX$$ 3 vezes antes de retornar FALSE
			lvi_Tentativas = 0
			Do 
				lvi_Tentativas++
				lvi_Status = FileWrite( This.ivi_Arquivo_Log, lvs_Mensagem )	
				
				If lvi_Status <> LenA( lvs_Mensagem ) Then Sleep( 2 )
				
			Loop While ( lvi_Status <> LenA( lvs_Mensagem ) Or lvi_Tentativas >= 3 )
		End If
				
		//Grava LOG na DW para envio por e-mail
		lvl_Linha = ivds_Log_Email.InsertRow(0)
		ivds_Log_Email.Object.cd_setor				[lvl_Linha] = ps_tipo_responsavel
		ivds_Log_Email.Object.cd_tipo_log				[lvl_Linha] = ps_tipo_log
		ivds_Log_Email.Object.cd_integracao			[lvl_Linha] = Tipo_Integracao
		ivds_Log_Email.Object.cd_chave_integracao[lvl_Linha] = Chave_Integracao
		ivds_Log_Email.Object.cd_chave_docto		[lvl_Linha] = Chave_Docto
		ivds_Log_Email.Object.cd_filial					[lvl_Linha] = ivl_Filial
		ivds_Log_Email.Object.cd_fornecedor			[lvl_Linha] = ivs_Fornecedor
		ivds_Log_Email.Object.nr_nf					[lvl_Linha] = ivdc_Docto
		ivds_Log_Email.Object.nr_transacao			[lvl_Linha] = ivdc_Transacao
		ivds_Log_Email.Object.de_especie				[lvl_Linha] = ivs_Especie
		ivds_Log_Email.Object.de_serie				[lvl_Linha] = ivs_Serie
		ivds_Log_Email.Object.de_log 					[lvl_Linha] = ps_mensagem
		ivds_Log_Email.Object.dh_log 					[lvl_Linha] = Datetime(Today(), Now())
		if ivs_executor = 'CAR' then ivds_Log_Email.Object.nr_atualizacao[lvl_Linha] = string(ivl_id_docto_log)
	
		//Capitalizar a mensagem de LOG
		ps_mensagem = Upper(ps_mensagem)
		
		If pb_grava_bd and ivl_ID_Docto_Log > 0 Then
			//Grava no BD
			If Pos(Upper(ivtr_Log.DBMS), 'SYBASE') > 0 Then 
				insert into log_exportacao_docto_det(nr_atualizacao_log, nr_atualizacao_item, nr_item_sequencial, cd_setor, id_tipo_log, id_classe_log, de_log)
				select :ivl_ID_Docto_Log, 
						 coalesce((select max(nr_atualizacao_item) from log_exportacao_docto_det x1 where nr_atualizacao_log = :ivl_ID_Docto_Log),0)+1, 
						 :Item, 
						 :ps_tipo_responsavel,
						 :ps_tipo_log, 
						 :Registro, 
						 :ps_mensagem
				from parametro
				Where id_parametro = '1'
				Using ivtr_Log;
			Else
				insert into log_exportacao_docto_det(nr_atualizacao_log, nr_atualizacao_item, nr_item_sequencial, cd_setor, id_tipo_log, id_classe_log, de_log)
				select :ivl_ID_Docto_Log, 
						 coalesce((select max(nr_atualizacao_item) from log_exportacao_docto_det x1 where nr_atualizacao_log = :ivl_ID_Docto_Log),0)+1, 
						 :Item,
						 :ps_tipo_responsavel,
						 :ps_tipo_log, 
						 :Registro, 
						 :ps_mensagem
				from dual
				Using ivtr_Log;
			End If
			
			If ivtr_Log.SQLCode = -1 Then
				This.Of_grava_log( "INF", "E", This.ClassName()+".of_grava_log(): Erro na inclus$$HEX1$$e300$$ENDHEX$$o do log_exportacao_docto_det: " + ivtr_Log.SQLErrText, False, True, True)
				Return False
			End If
		End If
	End If
	
	//Verifica se houve altera$$HEX2$$e700e300$$ENDHEX$$o de status
	If (Situacao_Docto <> ps_tipo_log) and (ps_tipo_log = "E" or ps_tipo_log = "F" or ps_tipo_log = "V") Then
			
			Update log_exportacao_docto
			Set id_situacao_log = :ps_tipo_log
			Where nr_atualizacao = :ivl_ID_Docto_Log
			Using ivtr_Log;
			
			If ivtr_Log.SQLCode = -1 Then
				This.Of_Grava_Log( "INF", "E", This.ClassName()+".of_Grava_Log(): Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do log_exportacao_docto: " + ivtr_Log.SQLErrText, False, True, True)
				Return False
			End If
			
			Situacao_Docto = ps_tipo_log
	ElseIf (Situacao_Docto <> ps_tipo_log) and (ps_tipo_log = "A") Then
		Situacao_Docto = ps_tipo_log
	End If
	
	ivtr_Log.Of_Commit()
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage(), False, True, True)
	Return False

Finally
	//
End Try

Return True
end function

public function Boolean of_grava_log (string ps_tipo_responsavel, string ps_tipo_log, string ps_mensagem, boolean pb_grava_bd, boolean pb_envia_email);Return This.Of_Grava_Log(ps_tipo_responsavel, ps_tipo_log, ps_mensagem, pb_grava_bd, pb_envia_email, True)
end function

public function boolean of_limpa_log (boolean pb_email);Try
	ivds_Controle.Reset()
	If pb_email Then ivds_Log_Email.Reset()

Catch (RuntimeError lvo_Erro)
	gvo_aplicacao.Of_Grava_Log("Erro ao limpar log")
	Return False
End Try

Return True
end function

public function boolean of_altera_situacao_log_nr_atualizacao (longlong pl_nr_atualizacao, string ps_ambiente);Try
	update log_exportacao_docto
	set id_situacao_log = 'X'
	Where nr_atualizacao 		= :pl_nr_atualizacao
	    and cd_ambiente_sap 	= :ps_ambiente
	Using ivtr_Log;
	
	If ivtr_Log.SQLCode = -1 Then
		ivtr_Log.Of_RollBack()
		This.Of_Grava_log("INF", "E", This.ClassName()+".of_altera_situacao_log_nr_atualizacao(): Erro ao atualizar id_situacao_log na tabela log_exportacao_docto.~r"+ivtr_Log.is_lasterrortext)
		Return False
	End If
	
	ivtr_Log.Of_Commit()
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage())
	Return False
	
Finally
	//
End Try

Return True
end function

public function boolean of_retorna_informacoes_docto (string ps_chave_integracao, ref longlong pl_id_docto_log, ref string ps_chave_docto, ref long pl_filial, ref string ps_fornecedor, ref decimal pdc_docto, ref decimal pdc_transacao, ref string ps_especie, ref string ps_serie);Long lvl_Find
Datetime lvdh_Docto

Try
	If Not ivds_Controle.RowCount() > 0 Then Return False
	
	lvl_Find = ivds_Controle.Find("cd_chave_integracao = '"+ps_chave_integracao+"'", 1 , ivds_Controle.RowCount())
	
	If lvl_Find > 0 Then
		ivl_ID_Docto_Log	= ivds_Controle.Object.nr_atualizacao_log [lvl_Find]
		Chave_Integracao	= ps_chave_integracao
		Chave_Docto		= ivds_Controle.Object.cd_chave_docto	[lvl_Find]
		ivl_Filial				= ivds_Controle.Object.cd_filial				[lvl_Find]
		ivs_Fornecedor		= ivds_Controle.Object.cd_fornecedor	[lvl_Find]
		ivdc_Docto			= ivds_Controle.Object.nr_docto			[lvl_Find]
		ivdc_Transacao		= ivds_Controle.Object.nr_transacao		[lvl_Find]
		ivs_Especie			= ivds_Controle.Object.de_especie		[lvl_Find]
		ivs_Serie				= ivds_Controle.Object.de_serie			[lvl_Find]
	Else
		//Busca na base de dados
		Select nr_atualizacao, 
				 cd_filial, 
				 nr_nf, 
				 nr_transacao, 
				 de_especie, 
				 de_serie,
				 dh_documento
		Into	:ivl_ID_Docto_Log, 
				:ivl_Filial, 
				:ivdc_Docto,
				:ivdc_Transacao,
				:ivs_Especie,
				:ivs_Serie,
				:lvdh_Docto
		From log_exportacao_docto
		Where cd_chave_docto = :ps_chave_integracao
			And cd_ambiente_sap = :Ambiente_SAP
			And id_situacao_log <> 'X'
		Using ivtr_Log;
		
		If Tipo_Documento = "RC" Then
			Chave_Docto = String(ivl_Filial, "0000")+"/"+String(lvdh_Docto, "YYYYMMDD")+"/"+String(ivdc_Transacao)
		Else
			Chave_Docto = String(ivl_Filial, "0000")+"/"+String(ivdc_Docto)+"/"+ivs_Especie+"/"+ivs_Serie
		End If
		
		Choose Case ivtr_Log.SQLCode
			Case -1
				This.Of_Grava_Log("INF", "E", "Erro ao localizar o registro com a chave "+ps_chave_integracao+"~r"+ivtr_Log.SQLErrText)
				Return False
				
			Case 100
				This.Of_Grava_Log("INF", "E", "N$$HEX1$$e300$$ENDHEX$$o encontrado o n$$HEX1$$fa00$$ENDHEX$$mero log para a chave "+ps_chave_integracao)
				Return False				
		End Choose
	End If
	
	pl_ID_Docto_Log	= ivl_ID_Docto_Log
	ps_Chave_Docto	= Chave_Docto
	pl_Filial				= ivl_Filial
	ps_fornecedor		= ivs_Fornecedor
	pdc_Docto			= ivdc_Docto
	pdc_Transacao		= ivdc_Transacao
	ps_Especie			= ivs_Especie
	ps_Serie				= ivs_Serie
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log( "INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage())
	Return False
	
Finally
	//
End Try

Return True
end function

public function longlong of_retorna_id_tdf (longlong pll_id_docto);Longlong lvll_ID_TDF

lvll_ID_TDF = pll_id_docto

Choose Case Modulo
	Case "TDF", "GUE"
		lvll_ID_TDF += 9000000000
	Case Else //CAR
		lvll_ID_TDF += 4000000000
End Choose

Return lvll_ID_TDF
end function

public function boolean of_abre_log (string ps_chave_integracao, string ps_chave_docto, long pl_filial, decimal pdc_nf, decimal pdc_transacao, string ps_especie, string ps_serie, datetime pdh_docto, long pl_lote, ref longlong pl_log);String lvs_Null

SetNull(lvs_Null)

Return This.Of_Abre_log( ps_chave_integracao, ps_chave_docto, lvs_Null, pl_filial, lvs_Null, pdc_nf, pdc_transacao, ps_especie, ps_serie, pdh_docto, lvs_Null, pl_lote, ref pl_log)
end function

public function boolean of_abre_log (string ps_chave_integracao, string ps_chave_docto, string ps_docto_id, long pl_filial, string ps_fornecedor, decimal pdc_nf, decimal pdc_transacao, string ps_especie, string ps_serie, datetime pdh_docto, string ps_id_docto_ref, longlong pl_lote, ref longlong pl_log);Long lvl_Row

Try
	Chave_Integracao 	= ps_chave_integracao
	Chave_Docto			= ps_chave_docto
	ID_Docto				= ps_docto_id
	ID_Docto_Ref		= ps_id_docto_ref
	ivl_Filial			= pl_filial
	ivs_Fornecedor		= ps_fornecedor
	ivdc_Docto			= pdc_nf
	ivdc_Transacao		= pdc_transacao
	ivs_Especie			= ps_especie
	ivs_Serie			= ps_serie
	ivl_Lote_Envio		= pl_lote
	Situacao_Docto		= ""
	
	//Para n$$HEX1$$e300$$ENDHEX$$o rodar instancia no proximo dia e a abertura do objeto foi dia anterior
	if date(ivdt_abertura_log) <> date(today())  Then Return False
	
	If Not This.Of_Proximo_Log( 1, ref ivl_ID_Docto_Log) Then Return False
	//Retorn log para a classe origem
	pl_log = ivl_ID_Docto_Log
	
	If Pos(Upper(ivtr_Log.DBMS), 'SYBASE') > 0 Then 
		insert into log_exportacao_docto(nr_atualizacao, cd_chave_docto, id_tipo_docto, cd_integracao, cd_filial, cd_fornecedor, nr_nf, nr_transacao, de_especie, de_serie, id_situacao_log, dh_documento, dh_exportacao, cd_ambiente_sap, nr_lote_envio, id_revisado, id_docto, id_docto_ref, id_interface)
		select :ivl_ID_Docto_Log, :ps_chave_integracao, :Tipo_Documento, :Tipo_Integracao, :pl_filial, :ps_fornecedor, :pdc_nf, :pdc_transacao, :ps_especie, :ps_serie, 'C', :pdh_docto, getdate(), :Ambiente_SAP, :ivl_Lote_Envio, 'P', :ID_Docto, :ID_Docto_Ref, :Modulo
		From parametro p
		Where p.id_parametro = '1'
			and not exists (	select 1 from log_exportacao_docto l1
								where l1.cd_ambiente_sap = :Ambiente_SAP
									and l1.cd_chave_docto = :ps_chave_integracao
									and l1.cd_integracao = :Tipo_Integracao
									and l1.cd_filial = :pl_filial
									and coalesce(l1.id_docto,'') = case when :Tipo_Documento='ENF' then :ID_Docto else coalesce(l1.id_docto,'') end
									and l1.nr_nf = :pdc_nf
									and l1.de_especie = :ps_especie
									and l1.de_serie = :ps_serie
									and l1.id_situacao_log <> 'X')
		Using ivtr_Log;
	Else
		insert into log_exportacao_docto(nr_atualizacao, cd_chave_docto, id_tipo_docto, cd_integracao, cd_filial, cd_fornecedor, nr_nf, nr_transacao, de_especie, de_serie, id_situacao_log, dh_documento, dh_exportacao, cd_ambiente_sap, nr_lote_envio, id_revisado, id_docto, id_docto_ref, id_interface)
		select :ivl_ID_Docto_Log, :ps_chave_integracao, :Tipo_Documento, :Tipo_Integracao, :pl_filial, :ps_fornecedor, :pdc_nf, :pdc_transacao, :ps_especie, :ps_serie, 'C', :pdh_docto, current_date, :Ambiente_SAP, :ivl_Lote_Envio, 'P', :ID_Docto, :ID_Docto_Ref, :Modulo
		From dual
		Where not exists (	select 1 from log_exportacao_docto l1
								where l1.cd_ambiente_sap = :Ambiente_SAP
									and l1.cd_chave_docto = :ps_chave_integracao
									and l1.cd_integracao = :Tipo_Integracao
									and l1.cd_filial = :pl_filial
									and l1.nr_nf = :pdc_nf
									and l1.de_especie = :ps_especie
									and l1.de_serie = :ps_serie
									and coalesce(l1.id_docto,'') = coalesce(:ID_Docto, '')
									and l1.id_situacao_log <> 'X')
		Using ivtr_Log;
	End If
	
	If ivtr_Log.SQLCode = -1 Then
		ivtr_Log.Of_RollBack()
		This.Of_Grava_Log( "INF", "E",  This.ClassName()+".of_documento_abre(): Erro na inser$$HEX2$$e700e300$$ENDHEX$$o de log na tabela log_exportacao_docto "+ivtr_Log.is_lasterrortext)
		Return False
		
	ElseIf ivtr_Log.SQLNRows < 1 Then
		//Log j$$HEX1$$e100$$ENDHEX$$ existe na base (nota pode estar sendo exportada por outra inst$$HEX1$$e200$$ENDHEX$$ncia)
		Return False
	End If
	
	ivtr_Log.Of_Commit()
	
	lvl_Row = ivds_Controle.InsertRow(0)
	ivds_Controle.Object.nr_atualizacao_log	[lvl_Row] = ivl_ID_Docto_Log
	ivds_Controle.Object.cd_chave_docto 		[lvl_Row] = ps_chave_docto
	ivds_Controle.Object.cd_chave_integracao 	[lvl_Row] = ps_chave_integracao
	ivds_Controle.Object.cd_filial 				[lvl_Row] = ivl_Filial
	ivds_Controle.Object.cd_fornecedor 			[lvl_Row] = ps_fornecedor
	ivds_Controle.Object.nr_docto 				[lvl_Row] = pdc_nf
	ivds_Controle.Object.nr_transacao 			[lvl_Row] = pdc_transacao
	ivds_Controle.Object.de_especie 				[lvl_Row] = ps_especie
	ivds_Controle.Object.de_serie		 			[lvl_Row] = ps_serie

Catch (RuntimeError lvo_rte)
	ivtr_Log.Of_Rollback()
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_rte.RoutineName+"().~r"+lvo_rte.GetMessage())
	Return False

Finally
	//
End Try

Return True
end function

public function boolean of_abre_log (string ps_chave_integracao, string ps_chave_docto, string ps_id_docto, long pl_filial, string ps_fornecedor, decimal pdc_nf, decimal pdc_transacao, string ps_especie, string ps_serie, datetime pdh_docto, long pl_lote, ref longlong pl_log);String lvs_Null

SetNull(lvs_Null)

Return This.Of_Abre_log( ps_chave_integracao, ps_chave_docto, ps_id_docto, pl_filial, ps_fornecedor, pdc_nf, pdc_transacao, ps_especie, ps_serie, pdh_docto, lvs_Null, pl_lote, ref pl_log)
end function

public function boolean of_envia_email (long pl_email_informatica, long pl_email_financeiro, long pl_email_fiscal, long pl_email_ecommerce, long pl_email_teste);Long lvl_Erros
Long lvl_Advert
Long lvl_Inform

String lvs_Log

Try
	
	If Not This.of_Retorna_Log( "INF", ref lvs_Log, ref lvl_Erros, ref lvl_Advert, ref lvl_Inform) Then Return False
	If Not IsNull(lvs_Log) and (Trim(lvs_Log)<>"") Then gf_ge202_envia_email_automatico(pl_email_informatica, "", lvs_Log, gvb_Auto)
	
	If Not This.of_Retorna_Log( "FIN", ref lvs_Log, ref lvl_Erros, ref lvl_Advert, ref lvl_Inform) Then Return False
	If Not IsNull(lvs_Log) and (Trim(lvs_Log)<>"") Then gf_ge202_envia_email_automatico(pl_email_financeiro, "", lvs_Log, gvb_Auto)
	
	If Not This.of_Retorna_Log( "FIS", ref lvs_Log, ref lvl_Erros, ref lvl_Advert, ref lvl_Inform) Then Return False
	If Not IsNull(lvs_Log) and (Trim(lvs_Log)<>"") Then gf_ge202_envia_email_automatico(pl_email_fiscal, "", lvs_Log, gvb_Auto)
	
	If Not This.of_Retorna_Log( "ECO", ref lvs_Log, ref lvl_Erros, ref lvl_Advert, ref lvl_Inform) Then Return False
	If Not IsNull(lvs_Log) and (Trim(lvs_Log)<>"") Then gf_ge202_envia_email_automatico(pl_email_ecommerce, "", lvs_Log, gvb_Auto)
	
	If Not This.of_Retorna_Log( "TST", ref lvs_Log, ref lvl_Erros, ref lvl_Advert, ref lvl_Inform) Then Return False
	If Not IsNull(lvs_Log) and (Trim(lvs_Log)<>"") Then gf_ge202_envia_email_automatico(pl_email_teste, "", lvs_Log, gvb_Auto)
		
Catch (RuntimeError lvo_rte)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_rte.RoutineName+"().~r"+lvo_rte.GetMessage())
	Return False

Finally
	
End Try

Return True
end function

public function longlong of_retorna_id_tdf (string ps_tipo_id_docto);Longlong lvll_ID_Log

if ps_tipo_id_docto = 'REF' then 			//Retornar o id_docto usando o id_docto_ref
	select min(nr_atualizacao)
	Into :lvll_ID_Log
	from log_exportacao_docto (index idx_id_docto)
	Where id_docto = (select min(id_docto_ref) from log_exportacao_docto (index idx_id_docto) Where id_docto = :ID_Docto)
	Using ivtr_Log;
else												//Casos que j$$HEX1$$e100$$ENDHEX$$ faziam a busca usando id_docto diretamente
	If Pos(Upper(ivtr_Log.DBMS), 'SYBASE') > 0 Then 
		select min(nr_atualizacao)
		Into :lvll_ID_Log
		from log_exportacao_docto (index idx_id_docto)
		Where id_docto = :ID_Docto
		Using ivtr_Log;
		
		If ivtr_Log.SQLCode <> -1 and (gf_coalesce(lvll_ID_Log,0)=0) Then
			//Se o conte$$HEX1$$fa00$$ENDHEX$$do do ID DOCTO for superior a 20, n$$HEX1$$e300$$ENDHEX$$o cabe no campo, ent$$HEX1$$e300$$ENDHEX$$o busca pela chave composta
			If Len(ID_Docto)>20 and Pos(Upper(ivtr_Log.DBMS), 'SYBASE')>0 Then
				select min(nr_atualizacao)
				Into :lvll_ID_Log
				from log_exportacao_docto (index idx_docto_ambiente)
				Where cd_filial = :ivl_Filial
					and nr_nf = :ivdc_Docto
					and nr_transacao = :ivdc_Transacao
					and de_especie = :ivs_Especie
					and de_serie = :ivs_Serie
					and id_tipo_docto = :Tipo_Documento
				Using ivtr_Log;
			End If
		End If
	Else
		select min(nr_atualizacao)
		Into :lvll_ID_Log
		from log_exportacao_docto
		Where id_docto = :ID_Docto
		Using ivtr_Log;
	End If
end if

Choose Case ivtr_Log.SQLCode
	Case -1
		This.Of_Grava_Log( "INF", "E",  This.ClassName()+".of_retorna_id_tdf(): Erro na sele$$HEX2$$e700e300$$ENDHEX$$o do MIN(nr_atualizacao) na log_exportacao_docto "+ivtr_Log.is_lasterrortext)
		SetNull(lvll_ID_Log)
		
	Case 100
		This.Of_Grava_Log( "INF", "E",  This.ClassName()+".of_retorna_id_tdf(): N$$HEX1$$e300$$ENDHEX$$o encontrado nenhum registro de log para a chave "+gf_coalesce(Chave_Integracao, '')+".")
		SetNull(lvll_ID_Log)
		
	Case 0
		lvll_ID_Log = This.Of_Retorna_ID_TDF(lvll_ID_Log)
	
End Choose

Return lvll_ID_Log
end function

public function boolean of_altera_bd_log (string ps_banco);String lvs_Datasource

Try
	//Se o DBMS do banco de dados for outro, ent$$HEX1$$e300$$ENDHEX$$o precisar$$HEX1$$e100$$ENDHEX$$ mudar
	If Pos(Upper(ivtr_Log.DBMS), ps_banco) <= 0 Then 
		//Decide qual DBMS (banco de dados) ser$$HEX1$$e100$$ENDHEX$$ gravado o log
		Choose Case Upper(ps_banco)
			Case DBMS_MULT //O Oracle da Mult, quando exporta$$HEX2$$e700e300$$ENDHEX$$o TDF conecta para o LOG
				If Not IsValid(ivtr_Oracle) Then
					lvs_Datasource = IIF(lower(gvo_aplicacao.ivs_datasource)="central", "CLAMPROD", "CLAMTESTE")
					This.Event ue_Conecta_DB( "MULT", lvs_Datasource, gvo_aplicacao.ivo_Seguranca.Cd_Sistema + "_LOG_" + gvo_aplicacao.of_UserId())
				End If
				
				//Seta a conex$$HEX1$$e300$$ENDHEX$$o anterior (salva quando alterada para o Sybase)
				ivtr_Log = ivtr_Oracle
				
			Case DBMS_SYBASE //O Sybase conecta com a aplica$$HEX2$$e700e300$$ENDHEX$$o SQLCa (mas n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ autocommit)
				//Caso n$$HEX1$$e300$$ENDHEX$$o esteja conectado, conecta
				If Not IsValid(ivtr_Sybase) Then
					This.Event ue_Conecta_DB( gvo_aplicacao.ivs_database, gvo_aplicacao.ivs_datasource, gvo_aplicacao.ivo_Seguranca.Cd_Sistema + "_LOG_" + gvo_aplicacao.of_UserId())
				End If
				
				//Seta a conex$$HEX1$$e300$$ENDHEX$$o SQLCa
				ivtr_Log = ivtr_Sybase
				
			Case Else
				This.Of_Grava_Log("INF", "E", This.ClassName()+".of_altera_bd_log(): Banco de dados inv$$HEX1$$e100$$ENDHEX$$lido ["+gf_coalesce(ps_banco,'')+"].", False, True, True)
				Return False
		End Choose
		
		//Altera datawindow LOG
		ivds_Log_Email.itr_Transacao = ivtr_Log
		ivds_Log_Email.SetTrans(ivtr_Log)
		
		//Altera datawindow Controle Exporta$$HEX2$$e700e300$$ENDHEX$$o	
		ivds_Controle.itr_Transacao = ivtr_Log
		ivds_Controle.SetTrans(ivtr_Log)
	End If
	
Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage(), False, True, True)
	Return False
Finally
	//
End Try

Return True
end function

public function boolean of_set_transacao (dc_uo_transacao ao_transacao);Try
	If Pos(Upper(ao_transacao.DBMS),DBMS_SYBASE)> 0 Then 
		ivtr_Sybase = ao_transacao
	ElseIf Pos(Upper(ao_transacao.DBMS), DBMS_MULT)> 0 Then
		ivtr_Oracle = ao_transacao
	Else
		Return False
	End If
	
	//Seta na inst$$HEX1$$e200$$ENDHEX$$ncia
	ivtr_Log = ao_transacao
	
	//Altera datawindow LOG
	if Not IsValid(ivds_Log_Email) Then ivds_Log_Email = Create dc_uo_ds_base
	If Not ivds_Log_Email.Of_ChangeDataObject("ds_ge472_log_email", False) Then Return False
	ivds_Log_Email.itr_Transacao = ivtr_Log
	ivds_Log_Email.SetTrans(ivtr_Log)
	
	//Altera datawindow Controle Exporta$$HEX2$$e700e300$$ENDHEX$$o	
	if Not IsValid(ivds_Controle) Then ivds_Controle = Create dc_uo_ds_base
	If Not ivds_Controle.Of_ChangeDataObject("ds_ge472_controle_log", False) Then Return False
	ivds_Controle.itr_Transacao = ivtr_Log
	ivds_Controle.SetTrans(ivtr_Log)
	
Catch (RuntimeError lvo_Erro)
	Return False
	
Finally
	
End Try

Return True
end function

public function boolean of_set_item (any p_value);
ivs_executor = p_value

return true
end function

public function boolean of_retorna_informacoes_docto (string p_cd_setor, string p_cd_tipo_log);Long lvl_Find, lvl_cd_filial, lvl_Linha
Datetime lvdh_Docto
string lvs_cd_setor, lvs_cd_integracao, lvs_cd_chave_docto, lvs_de_especie, lvs_de_serie, lvs_de_log
decimal lvdc_nr_nf, lvdc_nr_transacao, lvdc_nr_atualizacao	

Try
	ivds_Log_Email.SetFilter("")
	ivds_Log_Email.Filter()
	ivds_Log_Email.reset()
	if ivds_Log_Email.rowcount() = 1 then
		ivds_Log_Email.deleterow( 1 )
	end if
	ivds_Log_Email.update( )
	
	DECLARE lcur_log_nao_enviado_hoje CURSOR FOR
		select top 30 lf2.cd_setor, ld.cd_integracao, ld.id_docto, ld.cd_filial, ld.nr_nf, ld.nr_transacao, ld.de_especie, ld.de_serie, lf2.de_log, ld.nr_atualizacao										
			from log_exportacao_docto ld
			left outer join log_exportacao_docto_fin lf1
				on lf1.nr_atualizacao = ld.nr_atualizacao
			left outer join log_exportacao_docto_det lf2
				on lf2.nr_atualizacao_log = ld.nr_atualizacao
			where ld.dh_exportacao between dateadd(dd, -15, getdate()) and getdate()
				and ld.dh_documento between dateadd(dd, -15, getdate()) and getdate()
				and ld.cd_filial > 0
				and ld.id_tipo_docto = 'VD'
				and ld.id_situacao_log = 'E'
				and  coalesce(ld.id_revisado,'P') = 'P' 
				and ld.cd_ambiente_sap = 'PRD'
				and ld.nr_documento_sap is null
				and lf2.cd_setor = :p_cd_setor
				and lf2.de_log is not null
				and lf2.id_tipo_log = 'E'
				and ld.dh_exportacao < getdate()
				and ld.nr_atualizacao is not null
				and coalesce(ld.cd_fornecedor,'0') = '0'
				and ld.id_interface = 'CAR'
			using ivtr_log;
		
	open lcur_log_nao_enviado_hoje;
	
	fetch lcur_log_nao_enviado_hoje into :lvs_cd_setor, :lvs_cd_integracao, :lvs_cd_chave_docto, :lvl_cd_filial, :lvdc_nr_nf, :lvdc_nr_transacao, :lvs_de_especie, :lvs_de_serie, :lvs_de_log, :lvdc_nr_atualizacao;
	
	lvl_Linha = 0
	
	do while ivtr_Log.sqlcode = 0
		
		lvl_Linha = ivds_Log_Email.InsertRow(0)
		
		ivds_Log_Email.Object.cd_setor				[lvl_Linha] = lvs_cd_setor
		ivds_Log_Email.Object.cd_tipo_log				[lvl_Linha] = p_cd_tipo_log
		ivds_Log_Email.Object.cd_integracao			[lvl_Linha] = lvs_cd_integracao
		ivds_Log_Email.Object.cd_chave_integracao[lvl_Linha] = lvs_cd_chave_docto
		ivds_Log_Email.Object.cd_chave_docto		[lvl_Linha] = lvs_cd_chave_docto
		ivds_Log_Email.Object.cd_filial					[lvl_Linha] = lvl_cd_filial
		ivds_Log_Email.Object.nr_nf					[lvl_Linha] = ivdc_Docto
		ivds_Log_Email.Object.nr_transacao			[lvl_Linha] = lvdc_nr_nf
		ivds_Log_Email.Object.de_especie				[lvl_Linha] = lvs_de_especie
		ivds_Log_Email.Object.de_serie				[lvl_Linha] = lvs_de_serie
		ivds_Log_Email.Object.de_log 					[lvl_Linha] = lvs_de_log
		ivds_Log_Email.Object.dh_log 					[lvl_Linha] = Datetime(Today(), Now())
		ivds_Log_Email.Object.nr_atualizacao			[lvl_Linha] = string(lvdc_nr_atualizacao)
		
		update log_exportacao_docto set cd_fornecedor = '1' where nr_atualizacao = :lvdc_nr_atualizacao using sqlca;
		sqlca.of_commit( )
		
		lvl_Linha++
		fetch lcur_log_nao_enviado_hoje into :lvs_cd_setor, :lvs_cd_integracao, :lvs_cd_chave_docto, :lvl_cd_filial, :lvdc_nr_nf, :lvdc_nr_transacao, :lvs_de_especie, :lvs_de_serie, :lvs_de_log, :lvdc_nr_atualizacao;
	loop
	
	close lcur_log_nao_enviado_hoje;
	
Catch (RuntimeError lvo_Erro)
	close lcur_log_nao_enviado_hoje;
	This.Of_Grava_Log( "INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage())
	Return False
	
Finally
	close lcur_log_nao_enviado_hoje;
	Return True
End Try
end function

public function boolean of_grava_log_retorno (longlong pl_atualizacao_log, long pl_item_sequencial, string ps_tipo_log, string ps_classe_log, long pl_mensagem, string ps_log, string ps_complemento_log);String lvs_Setor = 'INF'

Return This.of_Grava_Log_Retorno(pl_atualizacao_log, pl_item_sequencial, ps_tipo_log, lvs_Setor, ps_classe_log, pl_mensagem, ps_log, ps_complemento_log)
end function

public function boolean of_grava_log_retorno (longlong pl_atualizacao_log, long pl_item_sequencial, string ps_tipo_log, string ps_setor, string ps_classe_log, long pl_mensagem, string ps_log, string ps_complemento_log);Datetime lvdh_DataHora

Try
	ps_classe_log			= Upper(ps_classe_log)
	ps_setor					= Upper(ps_setor)
	ps_log					= Upper(ps_log)
	ps_complemento_log	= Upper(ps_complemento_log)
	
	//Se n$$HEX1$$e300$$ENDHEX$$o tiver tipo de log, nem log, ent$$HEX1$$e300$$ENDHEX$$o nem grava na base...
	If gf_coalesce(ps_tipo_log,'')='' and gf_coalesce(ps_log, '')='' Then Return True
	
	//Se o envio for um lote e o retorno n$$HEX1$$e300$$ENDHEX$$o for individual (se aplica por exemplo ao envio de al$$HEX1$$ed00$$ENDHEX$$quota ICMS para o TDF)
	If Log_Por_Lote Then
		insert into log_exportacao_docto_det (nr_atualizacao_log, nr_atualizacao_item, nr_item_sequencial, id_tipo_log, cd_setor, id_classe_log, nr_mensagem, de_log, de_complemento_log)
		select l.nr_atualizacao, 
				 coalesce((select max(x.nr_atualizacao_item) from log_exportacao_docto_det x where x.nr_atualizacao_log = l.nr_atualizacao),0)+1,
				 :pl_item_sequencial,
				 :ps_tipo_log,
				 :ps_setor,
				 :ps_classe_log,
				 :pl_mensagem,
				 :ps_log,
				 :ps_complemento_log
		From log_exportacao_docto l
		Where l.nr_lote_envio = :ivl_Lote_Envio
			And cd_ambiente_sap = :Ambiente_SAP
		Using ivtr_Log;
	Else
		//Insere mensagem de erro no detalhamento
		If Pos(Upper(ivtr_Log.DBMS), 'SYBASE') > 0 Then 
			insert into log_exportacao_docto_det (nr_atualizacao_log, nr_atualizacao_item, nr_item_sequencial, id_tipo_log, cd_setor, id_classe_log, nr_mensagem, de_log, de_complemento_log)
			select :pl_atualizacao_log, 
					 coalesce((select max(x.nr_atualizacao_item) from log_exportacao_docto_det x where x.nr_atualizacao_log = :pl_atualizacao_log),0)+1,
					 :pl_item_sequencial,
					 :ps_tipo_log,
					 :ps_setor,
					 :ps_classe_log,
					 :pl_mensagem,
					 :ps_log,
					 :ps_complemento_log
			From parametro
			Where id_parametro = '1'
			Using ivtr_Log;
		Else
			insert into log_exportacao_docto_det (nr_atualizacao_log, nr_atualizacao_item, nr_item_sequencial, id_tipo_log, cd_setor, id_classe_log, nr_mensagem, de_log, de_complemento_log)
			select :pl_atualizacao_log, 
					 coalesce((select max(x.nr_atualizacao_item) from log_exportacao_docto_det x where x.nr_atualizacao_log = :pl_atualizacao_log),0)+1,
					 :pl_item_sequencial,
					 :ps_tipo_log,
					 :ps_setor,
					 :ps_classe_log,
					 :pl_mensagem,
					 :ps_log,
					 :ps_complemento_log
			From dual
			Using ivtr_Log;
		End If
	End If
	
	If ivtr_Log.SQLCode = -1 Then
		ivtr_Log.Of_Rollback()
		This.Of_Grava_log( "INF", "E", This.ClassName()+".of_grava_log_retorno(): Falha ao inserir log. ~rErro: "+ivtr_Log.is_lasterrortext)
		Return False
	End If
	
	lvdh_DataHora = gf_GetServerDate()
	
	//Se o envio for um lote e o retorno n$$HEX1$$e300$$ENDHEX$$o for individual (se aplica por exemplo ao envio de al$$HEX1$$ed00$$ENDHEX$$quota ICMS para o TDF)
	If Log_Por_Lote Then
		//Atualiza a situa$$HEX2$$e700e300$$ENDHEX$$o da exporta$$HEX2$$e700e300$$ENDHEX$$o da nota
		update log_exportacao_docto
		Set dh_processamento = :lvdh_DataHora,
			id_situacao_log = :ps_tipo_log,
			id_revisado = case when :ps_tipo_log = 'P' then 'S' else id_revisado end
		Where nr_lote_envio = :ivl_Lote_Envio
			And cd_ambiente_sap = :Ambiente_SAP
			And id_situacao_log <> 'V'
		Using ivtr_Log;
	Else
		//Atualiza a situa$$HEX2$$e700e300$$ENDHEX$$o da exporta$$HEX2$$e700e300$$ENDHEX$$o da nota
		update log_exportacao_docto
		Set dh_processamento = :lvdh_DataHora,
			id_situacao_log = :ps_tipo_log,
			id_revisado = case when :ps_tipo_log = 'P' then 'S' else id_revisado end
		Where nr_atualizacao = :pl_atualizacao_log
			And id_situacao_log <> 'V'
		Using ivtr_Log;
	End If
	
	If ivtr_Log.SQLCode = -1 Then
		ivtr_Log.Of_Rollback()
		This.Of_Grava_log( "INF", "E", This.ClassName()+".of_grava_log_retorno(): Falha ao atualizar log. ~rErro: "+ivtr_Log.is_lasterrortext)
		Return False
	End If
	
	//Commita
	ivtr_Log.Of_Commit()
	
	//Se for diferente de processado grava log
	If ps_tipo_log <> "P" Then This.Of_Grava_Log( "INF", ps_tipo_log, ps_log, False)

Catch (RuntimeError lvo_Erro)
	This.Of_Grava_Log("INF", "E", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o "+This.ClassName()+"."+lvo_Erro.RoutineName+"().~r"+lvo_Erro.GetMessage())
	Return False
	
Finally
	//
End Try

Return True
end function

public subroutine of_set_id_docto_log (longlong all_id_docto_log);ivl_ID_Docto_Log = all_ID_Docto_Log
end subroutine

public function boolean of_grava_docsap (string ps_cd_chave_docto, string ps_docto_sap);Try
	//Somente se houver valores
	If gf_coalesce(ps_cd_chave_docto,'')<>'' and gf_coalesce(ps_docto_sap,'')<>'' Then
		//Atualiza o nr_documento_sap (usado no Guepardo)
		Update log_exportacao_docto
		Set nr_documento_sap = :ps_docto_sap
		Where id_interface = :Modulo
			And cd_chave_docto = :ps_cd_chave_docto
			And id_situacao_log <> 'X'
			And cd_ambiente_sap = :Ambiente_SAP
		Using ivtr_Log;
		
		If ivtr_Log.SQLCode=-1 Then
			ivtr_Log.Of_Rollback()
			This.Of_Grava_log( 'INF', 'E', 'Falha na atualiza$$HEX2$$e700e300$$ENDHEX$$o de log.~rFun$$HEX2$$e700e300$$ENDHEX$$o: '+This.ClassName()+'.of_grava_docsap().~rErro BD: '+ivtr_Log.SQLErrText, True, True, True)
			Return False
		End If
	
		//Commita
		ivtr_Log.Of_Commit()
	End If
	
Catch (RuntimeError lvo_Erro)
	ivtr_Log.Of_Rollback()
	This.Of_Grava_log( 'INF', 'E', lvo_Erro.GetMessage(), True, True, True)
	Return False
Finally
	//
End Try

Return True
end function

on uo_ge472_log.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge472_log.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivds_Log_Email		= Create dc_uo_ds_base
ivds_Controle		= Create dc_uo_ds_base
ivtr_Log				= Create dc_uo_transacao

//ivtr_Log.of_SetDataBase(gvo_aplicacao.ivs_database)
//ivtr_Log.Database = gvo_aplicacao.ivs_database
//ivtr_Log.of_Connect( gvo_aplicacao.ivs_datasource, gvo_aplicacao.ivo_Seguranca.Cd_Sistema + "_LOG_" + gvo_aplicacao.of_UserId())

ivds_Log_Email.Of_ChangeDataObject("ds_ge472_log_email", False)
ivds_Log_Email.itr_Transacao = ivtr_Log
ivds_Log_Email.SetTrans(ivtr_Log)

ivds_Controle.Of_Changedataobject("ds_ge472_controle_log", False)
ivds_Controle.itr_Transacao = ivtr_Log
ivds_Controle.SetTrans(ivtr_Log)

ivdt_abertura_log = today()
end event

event destructor;If IsValid(ivds_Controle) Then Destroy(ivds_Controle)
If IsValid(ivds_Log_Email) Then Destroy(ivds_Log_Email)
If ivi_Arquivo_Log > 0 Then FileClose(ivi_Arquivo_Log)

If IsValid(ivtr_Log) Then
	ivtr_Log.Of_Commit()
	ivtr_Log.Of_Disconnect( )
	Destroy(ivtr_Log)
End If
end event

