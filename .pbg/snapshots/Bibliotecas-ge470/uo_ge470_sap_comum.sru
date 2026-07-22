HA$PBExportHeader$uo_ge470_sap_comum.sru
forward
global type uo_ge470_sap_comum from nonvisualobject
end type
end forward

global type uo_ge470_sap_comum from nonvisualobject
end type
global uo_ge470_sap_comum uo_ge470_sap_comum

type variables
dc_uo_transacao OracleMult
dc_uo_ds_base ids_contas

OleObject io_Xml_Http

String is_Origem_Legado 	= "SYBASE"
String is_URL					= ""
String	is_Usuario 				= 'PO_INTEGRACAO'
String	is_Senha 				= 'P0_INTEGRACAO$'
String is_Log					= ""


Integer ii_Empresa	= 1000
Integer ii_log

Boolean ib_Reprocessar

LongLong ill_Ultimo_Seq

Long il_Documentos_Retorno

Long il_Doc_Validar

String is_Termino_Cabecalho
String is_XML_Inicio
String is_XML_Termino
String is_tipo_doc


end variables

forward prototypes
public function boolean of_verifica_codigo_de_para (string as_cd_tabela, string as_cd_chave_legado, ref string as_cd_chave_sap, ref string as_log)
public function boolean of_envia_webservice (string as_url, string as_xml_envio, ref string as_xml_retorno, ref string as_erro)
public function boolean of_processa_retorno_contabil (string as_xml_retorno, ref string as_erro, ref string as_log)
public function boolean of_insere_log_integracao_sap (string as_nr_doc_externo, string as_dt_documento, string as_nr_item, string as_status_integracao, string as_mensagem_integracao, ref string as_log, string as_origem)
public function boolean of_conecta_db_mult ()
public function boolean of_grava_log (string as_mensagem, boolean ab_envia_email)
public function boolean of_envia_email (string as_mensagem)
public function boolean of_carrega_contas_mult ()
public function boolean of_insere_log_integracao_sap_commit (string as_nr_doc_externo, string as_dt_documento, string as_nr_item, string as_status_integracao, string as_mensagem_integracao, ref string as_log, string as_origem)
private function boolean of_processa_retorno_contabil_ret (string as_xml_retorno, ref string as_erro, ref string as_log)
public function boolean of_insere_log_exportacao_sap_hist (long al_nr_atualizacao, string as_nr_documento, date adt_documento, integer ai_nr_item, string as_id_tipo_conta, decimal adc_vl_documento, ref string as_log, string as_conta_contabil_sap, string as_nr_atribuicao)
public function boolean of_exclui_log_exportacao_sap_hist (long al_atualizacao, ref string as_log)
public function boolean of_verifica_codigo_de_para (string as_cd_tabela, string as_cd_chave_legado, string as_tipo_excecao, ref string as_cd_chave_sap, ref string as_log)
public function boolean of_verifica_codigo_de_para_sap (string as_cd_tabela, string as_cd_chave_sap, ref string as_cd_chave_legado, ref string as_log)
public function boolean of_insere_log_exportacao_sap (string as_filial, integer ai_tipo_log, string as_nr_documento, string as_id_tipo_nf, string as_dt_documento, string as_dt_contabilizacao, string as_cd_tipo_documento, string as_nr_documento_referencia, string as_texto_documento, string as_cd_moeda, string as_id_situacao_titulo, string as_dt_baixa, string as_dt_vencimento, decimal adc_vl_movimento, decimal adc_vl_icms, long al_cd_filial_nota, long al_nr_nf_nota, string as_especie_nota, string as_serie_nota, ref string as_log, ref long al_nr_atualizacao, string as_ambiente_sap)
public function boolean of_verifica_nr_atualizacao_baixa (integer ai_tipo_log, string as_cd_chave, integer ai_nr_item, ref long al_nr_atualizacao_baixa, ref date adt_documento, ref string as_log, string as_ambiente_sap)
public function boolean of_verifica_dados_baixa (integer ai_tipo_log, string as_cd_chave, integer ai_nr_item, ref long al_nr_atualizacao_baixa, ref string as_nr_documento_baixa, ref date adt_documento_baixa, ref string as_log, string as_ambiente_sap)
public function boolean of_estorna_documento (longlong all_nr_alteracao, string as_ambiente_sap)
public function string of_monta_xml_cabecalho_estorno (string as_empresa, string as_nr_atualizacao, string as_dt_documento, string as_dt_contabilizacao, string as_cd_tipo_documento, string as_nr_documento_referencia, string as_texto_documento, string as_cd_moeda, string as_doc_ext_estornar, string as_dh_doc_estornar)
public function boolean of_estorna_documento (string as_ambiente_sap)
public function string wf_get_value_tag (string as_xml, string as_tag, integer ai_pos)
public function boolean of_carrega_lanctos_mult_venda_pat (string as_docto_digitado, long al_nr_doc, decimal adc_vlr_nota, ref datastore ads_lanctos_mult)
public function boolean of_processa_integracao_contabil_ret_proc (string as_ambiente_sap)
public function boolean of_retorno_pendentes (ref long al_doc_pendente, string as_ambiente_sap)
public function boolean of_processa_integracao_contabil_ret (string as_ambiente_sap, long al_documentos)
public function boolean of_atualiza_nr_doc_sap (string as_nr_doc_externo, string as_dt_documento, string as_nr_doc_sap, string as_nr_doc_sap_comp, string as_nr_doc_sap_estorno, ref string as_log)
public function boolean of_monta_xml_contabil_ret (ref string as_xml, ref string as_erro, string as_ambiente_sap, ref longlong all_doc_externo)
public function boolean of_envia_webservice_new (string as_url, string as_xml_envio, ref string as_xml_retorno, ref string as_erro)
public subroutine of_seta_url_webservice (string as_url)
public function boolean of_altera_status_log_exportacao (long al_atualizacao, string as_status, ref string as_log, string as_erro)
public function boolean of_grava_erro_historico (long al_atualizacao, date adt_documento, long al_item, string as_erro, ref string as_log)
public function boolean of_insere_log_exportacao_sap (integer ai_tipo_log, string as_nr_documento, string as_id_tipo_nf, long al_cd_filial_nota, long al_nr_nf_nota, string as_especie_nota, string as_serie_nota, string as_fornecedor, long al_nr_lancamento_caixa, ref string as_log, ref long al_nr_atualizacao, string as_ambiente_sap, string as_chave_interface)
public function boolean of_abre_log (long pl_tentativa)
public function boolean of_processa_retorno_xml_interface (string as_xml)
public function string of_busca_valor (string as_xml, string as_tag, ref long al_pos)
public function boolean of_envia_webservice (string as_url, string as_xml_envio, ref string as_xml_retorno, ref string as_erro, long al_timeout)
public function boolean of_verifica_desc_centro_custo (long al_centro_custo, ref string as_centro_custo, ref string as_log)
end prototypes

public function boolean of_verifica_codigo_de_para (string as_cd_tabela, string as_cd_chave_legado, ref string as_cd_chave_sap, ref string as_log);Return of_verifica_codigo_de_para(as_cd_tabela, as_cd_chave_legado, "", ref as_cd_chave_sap, as_log) 
end function

public function boolean of_envia_webservice (string as_url, string as_xml_envio, ref string as_xml_retorno, ref string as_erro);Return of_envia_webservice(as_url, as_xml_envio, as_xml_retorno, as_erro, 120000)
end function

public function boolean of_processa_retorno_contabil (string as_xml_retorno, ref string as_erro, ref string as_log);String	ls_Xml_Aux

String	ls_Empresa, &
		ls_Nr_Doc_Externo, &
		ls_Dt_Documento, &
		ls_Nr_Item, &
		ls_Status_Integracao, &
		ls_Mensagem_Integracao

Long	ll_Pos_1, &
		ll_Pos_2, &
		ll_Lenght

Try
	
	
	
	Return TRUE
	
	
//	ll_Loop = 0
	
	DO WHILE Pos(as_xml_retorno, '<E_RETORNO>') > 0

		ll_Pos_1	= Pos(as_xml_retorno, '<E_RETORNO>')
		ll_Pos_2	= Pos(as_xml_retorno, '</E_RETORNO>')
		ll_Lenght	= Len( '</E_RETORNO>')		
		ls_Xml_Aux = Mid(as_xml_retorno, ll_Pos_1, (ll_Pos_2 + ll_Lenght) - ll_Pos_1)
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BUKRS>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BUKRS>')
		ll_Lenght	= Len( '</BUKRS>')		
		ls_Empresa = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BELNR_EXT>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BELNR_EXT>')
		ll_Lenght	= Len( '</BELNR_EXT>')		
		ls_Nr_Doc_Externo = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		ls_Nr_Doc_Externo = Mid(ls_Nr_Doc_Externo, 2, Len(ls_Nr_Doc_Externo))
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BLDAT>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BLDAT>')
		ll_Lenght	= Len( '</BLDAT>')		
		ls_Dt_Documento = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BUZEI>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BUZEI>')
		ll_Lenght	= Len( '</BUZEI>')		
		ls_Nr_Item = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<ZSTATUS_INT>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</ZSTATUS_INT>')
		ll_Lenght	= Len( '</ZSTATUS_INT>')		
		ls_Status_Integracao = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<MESSAGE>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</MESSAGE>')
		ll_Lenght	= Len( '</MESSAGE>')		
		ls_Mensagem_Integracao = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		This.of_Insere_Log_Integracao_SAP(ls_Nr_Doc_Externo, ls_Dt_Documento, ls_Nr_Item, ls_Status_Integracao, ls_Mensagem_Integracao, ref as_Log, 'SAP')
		
		as_xml_retorno = gf_Replace(as_xml_retorno, ls_Xml_Aux, '', 0)	//Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida		
	
	LOOP	
	
Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Processa_Retorno_Contabil', objeto 'uo_ge470_sap'. Erro: "+lo_rte.GetMessage())
	Return False
End Try

Return True
end function

public function boolean of_insere_log_integracao_sap (string as_nr_doc_externo, string as_dt_documento, string as_nr_item, string as_status_integracao, string as_mensagem_integracao, ref string as_log, string as_origem);Long ll_Nr_Doc_Externo, ll_Item

ll_Nr_Doc_Externo = Long(as_nr_doc_externo) 
ll_Item 				= Long(as_nr_item)

Insert Into log_exportacao_sap_integracao(nr_atualizacao_log, nr_item, de_mensagem_erro, id_situacao_log, de_origem)
Values(:ll_Nr_Doc_Externo, :ll_Item, :as_mensagem_integracao, :as_status_integracao, :as_origem)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do registro na tabela de log_integracao_sap: " + SqlCa.SqlerrText
	Return False
End If

//SqlCa.of_Commit()

Return True
end function

public function boolean of_conecta_db_mult ();// Se estiver conectado desconecta
If OracleMult.of_isConnected() Then OracleMult.of_Disconnect()

Return gf_conecta_banco_mult(OracleMult,'CLAMPROD')
end function

public function boolean of_grava_log (string as_mensagem, boolean ab_envia_email);String lvs_Mensagem

Integer lvi_Write

lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + &
               " - " + as_Mensagem

lvi_Write = FileWrite(ii_Log, lvs_Mensagem)

If lvi_Write = Len(lvs_Mensagem) Then
	
	If ab_envia_email Then
		of_envia_email(lvs_Mensagem)
	End If
	
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de LOG.", StopSign!)
	Return False
End If
end function

public function boolean of_envia_email (string as_mensagem);String ls_Anexo[]

If Not gf_ge202_envia_email_automatico(30, "", as_mensagem, ls_Anexo) Then
	Return False
End If

Return True
end function

public function boolean of_carrega_contas_mult ();Long ll_Linhas

If Not gvb_Carrega_Contas_Mult Then Return True

If Not of_conecta_db_mult() Then	Return False

dc_uo_ds_base lds_contas

Try 
	lds_contas = Create dc_uo_ds_base
	lds_contas.Of_SetTransObject(OracleMult)
	
	If Not lds_contas.of_ChangeDataObject("ds_ge470_contas_mult", False) Then
		of_Grava_Log("Erro ao alterar da 'ds_ge470_contas_mult'.", False)
		Return False
	End If
	
	ll_Linhas = lds_contas.Retrieve()
	
	If ll_Linhas > 0 Then
		If Not ids_contas.of_ChangeDataObject("ds_ge470_contas_mult", False) Then
			of_Grava_Log("Erro ao alterar da 'ds_ge470_contas_mult'.", False)
			Return False
		End If
		
		If lds_contas.RowsCopy(1, ll_Linhas, Primary!, ids_contas, 1, Primary!) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro copiar as contas da Mult.")
			Return False
		End If
	ElseIf ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as contas da Mult.")
		Return False
	ElseIf ll_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma conta foi localizada no BD da Mult.")
		Return False
	End If
		
Catch (RuntimeError lo_rte)
	This.of_Grava_Log("Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_carrega_contas_mult', objeto 'uo_ge470_sap_comum'. Erro: "+lo_rte.GetMessage(), False)
	Return False
Finally
	If IsValid(lds_contas) Then Destroy lds_contas
end try

Return True
end function

public function boolean of_insere_log_integracao_sap_commit (string as_nr_doc_externo, string as_dt_documento, string as_nr_item, string as_status_integracao, string as_mensagem_integracao, ref string as_log, string as_origem);Long ll_Nr_Doc_Externo, ll_Item

ll_Nr_Doc_Externo = Long(as_nr_doc_externo) 
ll_Item 				= Long(as_nr_item)

dc_uo_transacao 	lo_SqlCa

try
	lo_SqlCa	= create dc_uo_transacao
	lo_SqlCa.ivs_database = "SYBASE"
	
	If lo_SqlCa.of_Connect("") Then
		
		Insert Into log_exportacao_sap_integracao(nr_atualizacao_log, nr_item, de_mensagem_erro, id_situacao_log, de_origem)
		Values(:ll_Nr_Doc_Externo, :ll_Item, :as_mensagem_integracao, :as_status_integracao, :as_origem)
		Using lo_SqlCa;
		
		If lo_SqlCa.SqlCode = -1 Then
			as_Log += "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do registro na tabela de log_integracao_sap: " + SqlCa.SqlerrText
			Return False
		End If
		
		lo_SqlCa.of_Commit()
	End If	 

finally
	Destroy(lo_SqlCa)	 
end try
	 
Return True


end function

private function boolean of_processa_retorno_contabil_ret (string as_xml_retorno, ref string as_erro, ref string as_log);String	ls_Xml_Aux

String	ls_Empresa, &
		ls_Nr_Doc_Externo, &
		ls_Dt_Documento, &
		ls_Nr_Item, &
		ls_Status_Integracao, &
		ls_Mensagem_Integracao, &
		ls_Nr_Doc_SAP, &
		ls_Nr_Doc_SAP_Est, &
		ls_Nr_Doc_SAP_Comp, &
		ls_Nr_Item_Comp

Long	ll_Pos_1, &
		ll_Pos_2, &
		ll_Lenght

Try
	
//	ll_Loop = 0
	
	DO WHILE Pos(as_xml_retorno, '<E_RETORNO>') > 0

		ll_Pos_1	= Pos(as_xml_retorno, '<E_RETORNO>')
		ll_Pos_2	= Pos(as_xml_retorno, '</E_RETORNO>')
		ll_Lenght	= Len( '</E_RETORNO>')		
		ls_Xml_Aux = Mid(as_xml_retorno, ll_Pos_1, (ll_Pos_2 + ll_Lenght) - ll_Pos_1)
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BUKRS>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BUKRS>')
		ll_Lenght	= Len( '</BUKRS>')		
		ls_Empresa = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BELNR_EXT>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BELNR_EXT>')
		ll_Lenght	= Len( '</BELNR_EXT>')		
		ls_Nr_Doc_Externo = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		ls_Nr_Doc_Externo = Mid(ls_Nr_Doc_Externo, 2, Len(ls_Nr_Doc_Externo))
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BLDAT>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BLDAT>')
		ll_Lenght	= Len( '</BLDAT>')		
		ls_Dt_Documento = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BUZEI>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BUZEI>')
		ll_Lenght	= Len( '</BUZEI>')		
		ls_Nr_Item = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<ZSTATUS_INT>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</ZSTATUS_INT>')
		ll_Lenght	= Len( '</ZSTATUS_INT>')		
		ls_Status_Integracao = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BELNR_SAP>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BELNR_SAP>')
		ll_Lenght	= Len( '</BELNR_SAP>')		
		ls_Nr_Doc_SAP = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))		
		
//		If IsNull(ls_Nr_Doc_SAP) or ls_Nr_Doc_SAP = '' or ls_Nr_Doc_SAP = "$"  Then
//			//<BELNR_SAP_EST>
//			ll_Pos_1	= Pos(ls_Xml_Aux, '<BELNR_SAP_EST>')
//			ll_Pos_2	= Pos(ls_Xml_Aux, '</BELNR_SAP_EST>')
//			ll_Lenght	= Len( '</BELNR_SAP_EST>')		
//			ls_Nr_Doc_SAP = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))		
//		End If
				
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BELNR_SAP_EST>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BELNR_SAP_EST>')
		ll_Lenght	= Len( '</BELNR_SAP_EST>')		
		ls_Nr_Doc_SAP_Est = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))		
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BELNR_SAP_COMP>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BELNR_SAP_COMP>')
		ll_Lenght	= Len( '</BELNR_SAP_COMP>')		
		ls_Nr_Doc_SAP_Comp = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))		
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<BUZEI_SAP_COMP>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</BUZEI_SAP_COMP>')
		ll_Lenght	= Len( '</BUZEI_SAP_COMP>')		
		ls_Nr_Item_Comp = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))				
	
		ll_Pos_1	= Pos(ls_Xml_Aux, '<MESSAGE>')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</MESSAGE>')
		ll_Lenght	= Len( '</MESSAGE>')		
		ls_Mensagem_Integracao = Mid(ls_Xml_Aux, (ll_Pos_1 + ll_Lenght)-1 , ll_Pos_2 - (ll_Pos_1+ ll_Lenght - 1))
		
		//
				
		This.of_Insere_Log_Integracao_SAP(ls_Nr_Doc_Externo, ls_Dt_Documento, ls_Nr_Item, ls_Status_Integracao, ls_Mensagem_Integracao, ref as_Log, 'SAP')
		
		If ls_Nr_Doc_SAP <> "" and ls_Nr_Doc_SAP <> "$" Then
			This.of_Atualiza_Nr_Doc_SAP(ls_Nr_Doc_Externo, ls_Dt_Documento, ls_Nr_Doc_SAP, "", "", ref as_Log)
		End If
		
		If ls_Nr_Doc_SAP_Comp <> "" and ls_Nr_Doc_SAP_Comp <> "$" Then
			This.of_Atualiza_Nr_Doc_SAP(ls_Nr_Doc_Externo, ls_Dt_Documento, "", ls_Nr_Doc_SAP_Comp, "", ref as_Log)
		End If
		
		If ls_Nr_Doc_SAP_Est <> "" and ls_Nr_Doc_SAP_Est <> "$" Then
			This.of_Atualiza_Nr_Doc_SAP(ls_Nr_Doc_Externo, ls_Dt_Documento, "", "", ls_Nr_Doc_SAP_Est, ref as_Log)
		End If
		
		as_xml_retorno = gf_Replace(as_xml_retorno, ls_Xml_Aux, '', 0)	//Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida		
	
	LOOP	
	
Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Processa_Retorno_Contabil', objeto 'uo_ge470_sap'. Erro: "+lo_rte.GetMessage())
	Return False
End Try

Return True
end function

public function boolean of_insere_log_exportacao_sap_hist (long al_nr_atualizacao, string as_nr_documento, date adt_documento, integer ai_nr_item, string as_id_tipo_conta, decimal adc_vl_documento, ref string as_log, string as_conta_contabil_sap, string as_nr_atribuicao);//DateTime ldth_Documento

Long ll_Cont

//ldth_Documento = Datetime(adt_documento)

Select count(1)
Into :ll_Cont
From log_exportacao_sap_historico
Where nr_atualizacao		= :al_nr_atualizacao
    and nr_documento		= :as_nr_documento
    and dh_documento		= :adt_documento
	and nr_item				= :ai_nr_item
Using SqlCa;

If ll_Cont = 0 Then
	Insert Into log_exportacao_sap_historico(nr_atualizacao, nr_documento, dh_documento, nr_item, id_tipo_conta, vl_documento, nr_conta_contabil_sap, nr_atribuicao)
	Values(:al_nr_atualizacao, :as_nr_documento, :adt_documento, :ai_nr_item, :as_id_tipo_conta, :adc_vl_documento, :as_conta_contabil_sap, :as_nr_atribuicao)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log += "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o do registro na tabela log_exportacao_sap_historico: " + SqlCa.SqlerrText
		Return False
	End If
End If

//SqlCa.of_Commit()

Return True
end function

public function boolean of_exclui_log_exportacao_sap_hist (long al_atualizacao, ref string as_log);Delete From log_exportacao_sap_historico
Where nr_atualizacao = :al_Atualizacao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro ao excluir os registros da tabela log_exportacao_sap_historico: " + SqlCa.SqlerrText
	Return False
End If

Return True
end function

public function boolean of_verifica_codigo_de_para (string as_cd_tabela, string as_cd_chave_legado, string as_tipo_excecao, ref string as_cd_chave_sap, ref string as_log);Long ll_Find, ll_Linhas

// Utilizado para tratar as exce$$HEX2$$e700f500$$ENDHEX$$es
If Not IsNull(as_tipo_excecao) and Trim(as_tipo_excecao) <> "" Then
	Select vl_parametro
	Into :as_cd_chave_sap
	From integracao_sap_excecao
	Where cd_empresa	= :ii_Empresa
	 	and cd_tabela		= :as_Cd_Tabela
		and cd_chave		= :as_Cd_Chave_Legado
		and cd_tipo			= :as_tipo_excecao
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			as_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado a EXCECAO [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave:[" + as_Cd_Chave_Legado + "]"
			Return False
		Case -1
			as_Log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da EXCECAO [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave:[" + as_Cd_Chave_Legado + "] - EXCECAO: " + SqlCa.SqlerrText
			Return False
	End Choose
Else
	If as_cd_tabela = "CONTA_CONTABIL" Then
		ll_Linhas = ids_contas.RowCount()
		ll_Find 	= ids_contas.Find("CODIGO_DE = '" +  as_cd_chave_legado +  "'", 1, ids_contas.RowCount())
		
		Choose Case ll_Find
		Case 0
			as_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave legado:[" + iif(IsNull(as_Cd_Chave_Legado), '', as_Cd_Chave_Legado) + "]"
			Return False
		Case Is > 0
			as_cd_chave_sap = ids_contas.Object.CODIGO_PARA[ll_Find]
			If IsNull(as_cd_chave_sap) or  Trim(as_cd_chave_sap) = '' Then
				as_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave legado:[" + as_Cd_Chave_Legado + "]"
				Return False
			End If
		Case Else
			as_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave legado:[" + as_Cd_Chave_Legado + "]: " + SqlCa.SqlerrText
			Return False
		End Choose
	Else
		Select cd_chave_sap
		Into :as_cd_chave_sap
		From integracao_sap
		Where cd_empresa		= :ii_Empresa
		   and cd_tabela			= :as_Cd_Tabela
		   and cd_chave_legado	= :as_Cd_Chave_Legado
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
			Case 100
				as_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave legado:[" + iif(IsNull(as_Cd_Chave_Legado), '', as_Cd_Chave_Legado) + "]"
				Return False
			Case -1
				as_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave legado:[" + as_Cd_Chave_Legado + "]: " + SqlCa.SqlerrText
				Return False
		End Choose
	End If
End If

Return True
end function

public function boolean of_verifica_codigo_de_para_sap (string as_cd_tabela, string as_cd_chave_sap, ref string as_cd_chave_legado, ref string as_log);Select cd_chave_legado
Into :as_cd_chave_legado
From integracao_sap
Where cd_empresa		= :ii_Empresa
	and cd_tabela			= :as_Cd_Tabela
	and cd_chave_sap		= :as_Cd_Chave_SAP
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		as_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave SAP:[" + as_Cd_Chave_SAP + "]"
		Return False
	Case -1
		as_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave SAP:[" + as_Cd_Chave_SAP + "]: " + SqlCa.SqlerrText
		Return False
End Choose

Return True
end function

public function boolean of_insere_log_exportacao_sap (string as_filial, integer ai_tipo_log, string as_nr_documento, string as_id_tipo_nf, string as_dt_documento, string as_dt_contabilizacao, string as_cd_tipo_documento, string as_nr_documento_referencia, string as_texto_documento, string as_cd_moeda, string as_id_situacao_titulo, string as_dt_baixa, string as_dt_vencimento, decimal adc_vl_movimento, decimal adc_vl_icms, long al_cd_filial_nota, long al_nr_nf_nota, string as_especie_nota, string as_serie_nota, ref string as_log, ref long al_nr_atualizacao, string as_ambiente_sap);Long	ll_Nr_Atualizacao

Select nr_atualizacao
 Into :ll_Nr_Atualizacao
 From log_exportacao_sap
Where cd_empresa	= :ii_Empresa
	and id_tipo_log		= :ai_Tipo_Log
	and cd_chave		= :as_Nr_Documento
	and id_tipo_nf		= :as_Id_Tipo_Nf
	and cd_ambiente_sap = :as_ambiente_sap
	and coalesce(id_estornar, 'N') = 'N'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		
		If Not lf_ge470_proximo_sequencial_log(ref ll_Nr_Atualizacao, ref as_Log) Then Return False

		Insert Into log_exportacao_sap(nr_atualizacao, cd_empresa, id_tipo_log, cd_chave, id_tipo_nf, cd_filial, nr_nf, de_especie, de_serie, id_situacao_docto, id_status_integracao, dh_exportacao, cd_ambiente_sap)
		Values(:ll_Nr_Atualizacao, :ii_Empresa, :ai_Tipo_Log, :as_Nr_Documento, :as_Id_Tipo_Nf, :al_cd_filial_nota, :al_nr_nf_nota, :as_especie_nota, :as_serie_nota, 'C', 'C', getdate(), :as_ambiente_sap)
		Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			as_Log += "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o do registro na tabela log_exportacao_sap: " + SqlCa.SqlerrText
			Return False
		End If
		
	Case -1
		as_Log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do campo NR_ATUALIZACAO da tabela log_exportacao_sap: " + SqlCa.SqlerrText
		Return False
End Choose

al_nr_atualizacao = ll_Nr_Atualizacao

//SqlCa.of_Commit()

Return True
end function

public function boolean of_verifica_nr_atualizacao_baixa (integer ai_tipo_log, string as_cd_chave, integer ai_nr_item, ref long al_nr_atualizacao_baixa, ref date adt_documento, ref string as_log, string as_ambiente_sap);Select nr_atualizacao
Into :al_nr_atualizacao_baixa
From log_exportacao_sap
Where cd_empresa	= :ii_Empresa
    and id_tipo_log		= :ai_Tipo_Log
    and cd_chave		= :as_Cd_Chave
	and cd_ambiente_sap = :as_ambiente_sap
	and coalesce(id_estornar, 'N') = 'N'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo nr_atualizacao da tabela: log_exportacao_sap do registro: - empresa:[" + String(ii_Empresa) + "]-Tipo Log: " + String(ai_Tipo_Log) + "]-Chave:[" + as_Cd_Chave + "]: " + SqlCa.SqlerrText
	Return False
End If

Select dh_documento
Into :adt_documento
From log_exportacao_sap_historico
Where nr_atualizacao = :al_nr_atualizacao_baixa
    and nr_item			 = :ai_nr_item
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo nr_atualizacao da tabela: log_exportacao_sap_historico do registro: - nr_atualizacao:[" + String(al_nr_atualizacao_baixa) +": " + SqlCa.SqlerrText
	Return False
End If

Return True
end function

public function boolean of_verifica_dados_baixa (integer ai_tipo_log, string as_cd_chave, integer ai_nr_item, ref long al_nr_atualizacao_baixa, ref string as_nr_documento_baixa, ref date adt_documento_baixa, ref string as_log, string as_ambiente_sap);Select nr_atualizacao,
		 nr_documento_sap
Into 	:al_nr_atualizacao_baixa,
		:as_nr_documento_baixa
From log_exportacao_sap
Where cd_empresa			= :ii_Empresa
    and id_tipo_log				= :ai_Tipo_Log
    and cd_chave				= :as_Cd_Chave
	and cd_ambiente_sap 	= :as_ambiente_sap
	and coalesce(id_estornar, 'N') = 'N'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo nr_atualizacao da tabela: log_exportacao_sap do registro: - empresa:[" + String(ii_Empresa) + "]-Tipo Log: " + String(ai_Tipo_Log) + "]-Chave:[" + as_Cd_Chave + "]: " + SqlCa.SqlerrText
	Return False
End If

Select dh_documento
Into :adt_documento_baixa
From log_exportacao_sap_historico
Where nr_atualizacao = :al_nr_atualizacao_baixa
    and nr_item			 = :ai_nr_item
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo nr_atualizacao da tabela: log_exportacao_sap_historico do registro: - nr_atualizacao:[" + String(al_nr_atualizacao_baixa) +": " + SqlCa.SqlerrText
	Return False
End If

Return True
end function

public function boolean of_estorna_documento (longlong all_nr_alteracao, string as_ambiente_sap);DateTime ldh_Movimento

Integer li_Tipo_Log

Long ll_Linhas, ll_Linha, ll_Doc_Externo
Long ll_Filial, ll_NR_Lanc_CX, ll_Nota, ll_Empresa

String ls_Chave, ls_Id_Tipo_Nf, ls_Especie_Nota, ls_Serie_Nota, ls_Fornecedor, ls_Empresa
String ls_DT_Documento, ls_DT_Contabilizacao, ls_Tipo_Docto, ls_Docto_Externo, ls_Cabecalho
String ls_Docto_Refer, ls_Texto_Docto, ls_Moeda, ls_Xml_Retorno
String ls_Doc_Ext_Estornar, ls_DH_Doc_Estornar, ls_Log, ls_XML, ls_Nulo

SetNull(ls_Nulo)

Try
	
	SELECT  top 1	la.cd_empresa, la.cd_chave, la.id_tipo_nf, la.id_tipo_log,la.cd_filial, la.nr_nf, la.de_especie,la.de_serie,la.cd_fornecedor,lh.dh_documento  
	Into 	:ll_Empresa,:ls_Chave,:ls_Id_Tipo_Nf,:li_Tipo_Log,:ll_Filial,	:ll_Nota,:ls_Especie_Nota,:ls_Serie_Nota,:ls_Fornecedor,:ldh_Movimento
	FROM log_exportacao_sap  la
	inner join log_exportacao_sap_historico lh
		on lh.nr_atualizacao = la.nr_atualizacao
	where la.nr_atualizacao = :all_nr_alteracao
	    and la.cd_ambiente_sap = :as_ambiente_sap
	   and la.dh_estornado_sap is null
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
			ls_Doc_Ext_Estornar 	= 'S' + String(all_nr_alteracao)
			ls_DH_Doc_Estornar 	= String(ldh_Movimento	, 'yyyymmdd')
			//ll_NR_Lanc_CX			= lds.Object.nr_lancamento_caixa[ll_Linha]
			
			ls_Empresa				= String(ll_Empresa)
			ls_DT_Documento		=  String(ldh_Movimento	, 'yyyymmdd')
			ls_DT_Contabilizacao =  String(ldh_Movimento	, 'yyyymmdd')
			
			ls_Tipo_Docto 			= "" 
			ls_Docto_Refer			= ""  
			ls_Texto_Docto 		= ""
			ls_Moeda 				= ""
			
			If This.of_insere_log_exportacao_sap(li_Tipo_Log, '*' + ls_Chave, ls_Id_Tipo_Nf, ll_Filial, ll_Nota, ls_Especie_Nota, ls_Serie_Nota, &
																 ls_Fornecedor, ll_NR_Lanc_CX, Ref ls_Log, Ref ll_Doc_Externo, as_ambiente_sap, ls_Nulo) Then
				ls_Docto_Externo = 'S' + String(ll_Doc_Externo)
								
				ls_Cabecalho = This.of_monta_xml_cabecalho_estorno(	ls_Empresa, ls_Docto_Externo, ls_DT_Documento, ls_DT_Contabilizacao,& 
														 								ls_Tipo_Docto, ls_Docto_Refer, ls_Texto_Docto, ls_Moeda, ls_Doc_Ext_Estornar, ls_DH_Doc_Estornar) /*E - ESTORNO*/
			End If
						
			ls_XML =	is_XML_Inicio + ls_Cabecalho + is_Termino_Cabecalho + is_XML_Termino
			
			If Not IsNull(ls_XML) and trim(ls_XML) <> '' Then
				If This.of_envia_webservice(is_URL, ls_XML, Ref ls_Xml_Retorno, Ref ls_log) Then
					If lf_ge470_processa_retorno(ls_Xml_Retorno, 1, '', SQLCA, 'SYB', ref ls_log, 0 ) Then 
						Return True
					End If
				End If
				
				This.of_grava_log(ls_log, False)
				Return False
			Else
				This.of_grava_log("XML vazio", False)
				Return False
			End If
			
		Case 100
		Case -1
			of_grava_log("Erro ao localizar os dados para estornar o documento '" + String(all_nr_alteracao) + "': " + SqlCa.SqlerrText, False)
			Return False
	End Choose

Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_caixa', objeto 'uo_ge470_sap_caixa'. Erro: "+lo_rte.GetMessage())
	Return False
Finally
	//If IsValid(W_Aguarde) Then Close(w_Aguarde)
End Try

Return True

end function

public function string of_monta_xml_cabecalho_estorno (string as_empresa, string as_nr_atualizacao, string as_dt_documento, string as_dt_contabilizacao, string as_cd_tipo_documento, string as_nr_documento_referencia, string as_texto_documento, string as_cd_moeda, string as_doc_ext_estornar, string as_dh_doc_estornar);String	ls_XML_Cabecalho

ls_XML_Cabecalho = 					'<I_CABECALHO>'+&
											'<BUKRS>'+as_Empresa+'</BUKRS>'+&
											'<BELNR_EXT>' +as_nr_atualizacao+'</BELNR_EXT>'+&
											'<BLDAT>'+as_dt_documento+'</BLDAT>'+&
											'<BUDAT>'+as_dt_contabilizacao+'</BUDAT>'+&
											'<BLART>'+as_cd_tipo_documento+'</BLART>'+&
											'<XBLNR>'+as_nr_documento_referencia+'</XBLNR>'+&
											'<BKTXT>'+as_texto_documento+'</BKTXT>'+&
											'<WAERS>'+as_cd_moeda+'</WAERS>'+&
											'<ZSIST_ORIGEM>'+is_Origem_Legado+'</ZSIST_ORIGEM>'+&
/*I $$HEX1$$1320$$ENDHEX$$ Inserir / E $$HEX1$$1320$$ENDHEX$$ Estornar */		'<ZTIPO_LANC>E</ZTIPO_LANC>'+&
/*Empresa estornar*/				'<BUKRS_EST>' + as_Empresa + '</BUKRS_EST>'+&
/*Doc Ext estornar*/					'<BELNR_EST>' + as_doc_ext_estornar + '</BELNR_EST>'+&
/*Data doc estorar*/					'<BLDAT_EST>' + as_dh_doc_estornar + '</BLDAT_EST>'+&
											'<ZFIM_ENVIO>X</ZFIM_ENVIO>'
							
Return ls_XML_Cabecalho
end function

public function boolean of_estorna_documento (string as_ambiente_sap);Long ll_Linhas, ll_Linha

LongLong lll_NR_Atualizacao

String ls_Log

dc_uo_ds_base lds

Try
	If IsValid(W_Aguarde) Then Close(w_Aguarde)
	Open(w_Aguarde)
	
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge470_documento_estornar") Then Return False
	
	ll_Linhas = lds.Retrieve()

	If ll_Linhas > 0 Then
		
		w_aguarde.uo_progress.of_setmax(ll_Linhas)
						
		If Not gf_retorna_pametro_sap(SqlCa, as_ambiente_sap, 'CD_URL_CONTABIL_ENVIO', ref is_URL, ref ls_Log) Then
			MessageBox('Erro', ls_Log)
			Return False
		End If
					
		For ll_Linha = 1 To ll_Linhas
			
			w_Aguarde.Title = "Estornando documentos..." + String(ll_Linha) + ' de: ' + String(ll_Linhas)
		
			lll_NR_Atualizacao	= lds.Object.nr_atualizacao[ll_Linha]
						
			If of_estorna_documento(lll_NR_Atualizacao, as_ambiente_sap) Then
				
				Update log_exportacao_sap
					 Set	dh_estornado_sap = 	getdate()
				Where nr_atualizacao 	= :lll_NR_Atualizacao
				Using SqlCa;
			
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_RollBack()
					//wf_Grava_log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do registro na tabela de log_exportacao_sap - " + ls_Alterar_Excluir + "  " + ivtr_Mult.SqlerrText, 0)
					Return False
				End If
				
				If SqlCa.SQLNRows <> 1 Then
					SqlCa.of_RollBack()
					//wf_Grava_Log("Nenhum ou mais de um documento foi atualizado - " + ls_Alterar_Excluir + ".", 0)
					Return False
				End If
				
				SqlCa.of_Commit()
			
			End If	
			
			w_aguarde.uo_progress.of_setprogress(ll_Linha)
		Next	
		
	ElseIf ll_Linhas < 0 Then
		//wf_Grava_Log('Erro ao recuperar os dados da DW [' + is_DW + '].', 0)
//		Return False	
	End If	

Catch (RuntimeError lo_rte)
//	wf_Grava_Log("Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_documento_excluido', objeto 'w_el007_exportacao_mult'. Erro: "+lo_rte.GetMessage(), 0)
//	Return False
Finally
	If IsValid(W_Aguarde) Then Close(w_Aguarde)
	If IsValid(lds) Then Destroy lds
End Try

Return True



end function

public function string wf_get_value_tag (string as_xml, string as_tag, integer ai_pos);Integer li_Esp, li_i, li_Inicio, li_Fim
string  ls_Result, ls_Xml_Aux

as_Tag = gf_Replace(as_Tag, '/', '', 0)
as_Tag = gf_Replace(as_Tag, '<', '', 0)
as_Tag = gf_Replace(as_Tag, '>', '', 0)

If Pos(' ', as_Tag) > 0 Then 
	li_Esp = Pos(' ',as_Tag)
Else
	li_Esp = LenA(as_Tag)
End If	

li_Inicio = 1
ls_Xml_Aux = as_xml
for li_i = 1 to ai_Pos 
	 ls_Result = Mid(	ls_Xml_Aux,  &
	 						Pos(ls_Xml_Aux, '<'+as_tag+'>')+LenA(as_tag)+2, &
	 						Pos(ls_Xml_Aux, '</'+as_tag+'>') - (Pos(ls_Xml_Aux, '<'+as_tag+'>')+LenA(as_tag)+2))
	ls_Xml_Aux = Mid(ls_Xml_Aux, Pos(ls_Xml_Aux, '</'+as_tag+'>') +  LenA(as_tag)+3)
Next

Return ls_Result
end function

public function boolean of_carrega_lanctos_mult_venda_pat (string as_docto_digitado, long al_nr_doc, decimal adc_vlr_nota, ref datastore ads_lanctos_mult);Long ll_Linhas

If Not of_conecta_db_mult() Then	Return False

dc_uo_ds_base lds_lanctos

Try 
	lds_lanctos = Create dc_uo_ds_base
	lds_lanctos.Of_SetTransObject(OracleMult)
	
	If Not lds_lanctos.of_ChangeDataObject("ds_ge470_lanctos_venda_ativo_mult", False) Then
		of_Grava_Log("Erro ao alterar da 'ds_ge470_lanctos_venda_ativo_mult'.", False)
		Return False
	End If
	
	ll_Linhas = lds_lanctos.Retrieve(as_docto_digitado, al_nr_doc, adc_vlr_nota)
	
	If ll_Linhas > 0 Then
		If lds_lanctos.RowsCopy(1, ll_Linhas, Primary!, ads_lanctos_mult, 1, Primary!) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro copiar as contas da Mult.")
			Return False
		End If
	End If
		
Catch (RuntimeError lo_rte)
	This.of_Grava_Log("Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_carrega_lanctos_mult_venda_pat', objeto 'uo_ge470_sap_comum'. Erro: "+lo_rte.GetMessage(), False)
	Return False
Finally
	If IsValid(lds_lanctos) Then Destroy lds_lanctos
end try

Return True
end function

public function boolean of_processa_integracao_contabil_ret_proc (string as_ambiente_sap);String ls_Log

Long ll_Retornos_Pend, ll_Retornos_Pend_Ant

ill_Ultimo_Seq = 0

If Not gf_retorna_pametro_sap(SQLCA, as_ambiente_sap, 'CD_URL_CONTABIL_RETORNO', ref is_URL, ref ls_Log) Then
	MessageBox('Erro', ls_Log)
	Return False
End If

If Not of_retorno_pendentes(Ref ll_Retornos_Pend, as_ambiente_sap) Then Return False

il_Documentos_Retorno = 100

Do While ll_Retornos_Pend > 0

	If Not of_processa_integracao_contabil_ret(as_ambiente_sap, ll_Retornos_Pend) Then Return False
	
	If Not of_retorno_pendentes(Ref ll_Retornos_Pend, as_ambiente_sap) Then Return False
	
	If ll_Retornos_Pend = ll_Retornos_Pend_Ant Then
		Return True
	End If
	
	ll_Retornos_Pend_Ant = ll_Retornos_Pend
loop


Return True
end function

public function boolean of_retorno_pendentes (ref long al_doc_pendente, string as_ambiente_sap);If il_Doc_Validar > 0 Then
	If ill_Ultimo_Seq >0 Then
		SELECT	Count(s.nr_atualizacao)
		Into :al_doc_pendente
		FROM log_exportacao_sap  s
		where (s.nr_documento_sap is null or s.nr_documento_sap = '')
			and s.cd_ambiente_sap = :as_ambiente_sap
			and s.nr_atualizacao = :il_Doc_Validar
			and s.nr_atualizacao > :ill_Ultimo_Seq
		Using SqlCa;
	Else
		SELECT	Count(s.nr_atualizacao)
		Into :al_doc_pendente
		FROM log_exportacao_sap  s
		where (s.nr_documento_sap is null or s.nr_documento_sap = '')
			and s.cd_ambiente_sap = :as_ambiente_sap
			and s.nr_atualizacao = :il_Doc_Validar
			//and s.nr_atualizacao >= 143597
		Using SqlCa;
	End IF
Else

	If ill_Ultimo_Seq >0 Then
		
		If is_tipo_doc = 'CX'  Then
			SELECT	Count(s.nr_atualizacao)
			Into :al_doc_pendente
			FROM log_exportacao_sap  s
			where (s.nr_documento_sap is null or s.nr_documento_sap = '')
				and s.cd_ambiente_sap = :as_ambiente_sap
				and s.nr_atualizacao > :ill_Ultimo_Seq
				and s.id_tipo_log in (5)
			Using SqlCa;
		Else
			SELECT	Count(s.nr_atualizacao)
			Into :al_doc_pendente
			FROM log_exportacao_sap  s
			where (s.nr_documento_sap is null or s.nr_documento_sap = '')
				and s.cd_ambiente_sap = :as_ambiente_sap
				and s.nr_atualizacao > :ill_Ultimo_Seq
				and s.id_tipo_log not in (5)
			Using SqlCa;
		End If
		
	Else
		
		If is_tipo_doc = 'CX'  Then
			SELECT	Count(s.nr_atualizacao)
			Into :al_doc_pendente
			FROM log_exportacao_sap  s
			where (s.nr_documento_sap is null or s.nr_documento_sap = '')
				and s.cd_ambiente_sap = :as_ambiente_sap
				and s.id_tipo_log in (5)
			Using SqlCa;
		Else
			SELECT	Count(s.nr_atualizacao)
			Into :al_doc_pendente
			FROM log_exportacao_sap  s
			where (s.nr_documento_sap is null or s.nr_documento_sap = '')
				and s.cd_ambiente_sap = :as_ambiente_sap
				and s.id_tipo_log not in (5)
			Using SqlCa;
		End If
		
	End If
End If

If SqlCa.SqlCode = -1 Then
	//wf_grava_log("Verifica$$HEX2$$e700e300$$ENDHEX$$o do quantidade de documentos pendentes. " + ivtr_Mult.SqlerrText, 0)
	Return False
End If

Return True
end function

public function boolean of_processa_integracao_contabil_ret (string as_ambiente_sap, long al_documentos);String	ls_Xml,&
		ls_Xml_Retorno,&
		ls_Erro,&
		ls_Log
		
Boolean	lb_Sucesso = False

Longlong lll_Doc_Externo

Try
	
	If IsValid(W_Aguarde) Then Close(w_Aguarde)
	Open(w_Aguarde)
	w_Aguarde.Title = 'Retornos SAP -> Consultando ... '  + String(al_documentos)
	
	lll_Doc_Externo = 0
		
	If of_monta_xml_contabil_ret(Ref ls_Xml, Ref ls_Erro, as_ambiente_sap, ref lll_Doc_Externo) Then
		w_Aguarde.uo_Progress.of_reset()
		w_Aguarde.Title = 'Retornos SAP -> Enviando XML Consulta WService ... ' + String(al_documentos)
		If of_envia_webservice(is_URL, ls_Xml, Ref ls_Xml_Retorno, Ref ls_Erro) Then
			If lf_ge470_processa_retorno(ls_Xml_Retorno, 2, '', SqlCa, 'SYB', ref ls_Erro, lll_Doc_Externo) Then
			//If of_Processa_retorno_contabil_ret(ls_Xml_Retorno, Ref ls_Erro, Ref ls_Log) Then
				lb_Sucesso = True
			End If
		End If
	End If
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
		Return True
	Else
		SqlCa.of_RollBack()
//		MessageBox("Erro", ls_Erro)
		Return False
	End If
	
Catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Processa_Integracao_Contabil_Ret', objeto 'uo_ge470_sap'. Erro: "+lo_rte.GetMessage())
	Return False
Finally
	If IsValid(W_Aguarde) Then Close(w_Aguarde)
End Try


end function

public function boolean of_atualiza_nr_doc_sap (string as_nr_doc_externo, string as_dt_documento, string as_nr_doc_sap, string as_nr_doc_sap_comp, string as_nr_doc_sap_estorno, ref string as_log);Long ll_Nr_Doc_Externo, ll_Item

String ls_Atribuicao

ll_Nr_Doc_Externo = Long(as_nr_doc_externo)

Update log_exportacao_sap_historico
    Set 	nr_documento_sap = :as_nr_doc_sap,
	 		nr_documento_sap_compensacao = :as_nr_doc_sap_comp,
			 nr_documento_sap_estorno		= :as_nr_doc_sap_estorno
Where nr_atualizacao 	= :ll_Nr_Doc_Externo
   and nr_documento 		= :as_nr_doc_externo
   and dh_documento		= :as_dt_documento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do registro na tabela de log_exportacao_sap_historico: " + SqlCa.SqlerrText
	Return False
End If

SqlCa.of_Commit()

Select top 1 nr_atribuicao
 Into :ls_Atribuicao
From log_exportacao_sap_historico
Where nr_atualizacao 	= :ll_Nr_Doc_Externo
   and nr_documento 		= :as_nr_doc_externo
   and dh_documento		= :as_dt_documento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do registro de atribui$$HEX2$$e700e300$$ENDHEX$$o na tabela de log_exportacao_sap_historico: " + SqlCa.SqlerrText
	Return False
End If

If Not IsNull(as_nr_doc_sap_estorno) and as_nr_doc_sap_estorno <> '' Then
	as_nr_doc_sap = as_nr_doc_sap_estorno
	
	Update log_exportacao_sap
    Set nr_documento_sap 	= :as_nr_doc_sap,
	 	 dh_importacao			= getdate(),
		 id_status_integracao	= 'P',
		 id_situacao_docto 	= 'P'
	Where cd_empresa		= :ii_Empresa
		and nr_atualizacao	= :ll_Nr_Doc_Externo
	Using SqlCa;

Else
	Update log_exportacao_sap
    Set nr_documento_sap 	= :as_nr_doc_sap,
	 	 dh_importacao			= getdate(),
		 id_status_integracao	= 'P',
		 id_situacao_docto		= 'P'
	Where cd_empresa		= :ii_Empresa
		and cd_chave			= :ls_Atribuicao
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do registro na tabela de log_exportacao_sap_historico: " + SqlCa.SqlerrText
	Return False
End If

SqlCa.of_Commit()

Return True
end function

public function boolean of_monta_xml_contabil_ret (ref string as_xml, ref string as_erro, string as_ambiente_sap, ref longlong all_doc_externo);Long 	ll_Linha, &
		ll_Total_Linhas
		
String 	ls_Cd_Empresa, &
			ls_Nr_Documento_Ext, &
			ls_Dt_Documento

dc_uo_ds_base ds_log_exp
ds_log_exp = Create dc_uo_ds_base
ds_log_exp.of_ChangeDataObject('ds_ge470_log_exportacao_sap_retorno')
ds_log_exp.SetTransObject(SqlCa)

ds_log_exp.of_restoresqloriginal()
	
If ill_Ultimo_Seq > 0 Then
	ds_log_exp.of_appendwhere_subquery ("l.nr_atualizacao > " + String(ill_Ultimo_Seq), 2)
End If

If is_tipo_doc = 'CX' Then
	ds_log_exp.of_appendwhere_subquery ("l.id_tipo_log in (5)", 2)
Else
	ds_log_exp.of_appendwhere_subquery ("l.id_tipo_log not in (5)", 2)
End If

If il_Doc_Validar > 0 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Doc fixo para valida$$HEX2$$e700e300$$ENDHEX$$o")
	ds_log_exp.of_appendwhere_subquery ("l.nr_atualizacao = " + string(il_Doc_Validar), 2)
End If

ll_Total_Linhas = ds_log_exp.Retrieve(as_ambiente_sap)

Try
	as_XML = 	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
					'<soapenv:Header/>'+&
					'<soapenv:Body>' + &
					'<imp:MT_REQUEST_CONT_RET>'
					
	w_Aguarde.uo_Progress.of_reset()
	w_Aguarde.Title = 'Retornos SAP -> Montando XML de Consulta ...'
	w_Aguarde.uo_Progress.of_SetMax(ll_Total_Linhas)	
		
	If ll_Total_Linhas > il_Documentos_Retorno Then ll_Total_Linhas = il_Documentos_Retorno
	
	If ll_Total_Linhas > 0 Then
	
		For ll_Linha = 1 To ll_Total_Linhas
				
				ls_Cd_Empresa			= String(ds_log_exp.Object.Cd_Empresa[ll_Linha])
				ls_Nr_Documento_Ext	= String(ds_log_exp.Object.Nr_Atualizacao[ll_Linha])
				ls_Dt_Documento		= String(ds_log_exp.Object.Dh_Documento[ll_Linha], 'yyyymmdd')
				
				If ls_Nr_Documento_Ext = '1009413' Then
					ls_Nr_Documento_Ext = '1009413'
				End If
				
//				somente quando for de um em um
				If il_Documentos_Retorno = 1 Then
					all_doc_externo = ds_log_exp.Object.Nr_Atualizacao[ll_Linha]
				End If
							
				as_XML += 		'<I_RETORNO>'+&
										'<BUKRS>' + ls_Cd_Empresa + '</BUKRS>'+&
										'<BELNR_EXT>' + 'S' + ls_Nr_Documento_Ext + '</BELNR_EXT>'+&
										'<BLDAT>' + ls_Dt_Documento + '</BLDAT>'+&
									'</I_RETORNO>'
									
				w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)		
		Next
	
		ill_Ultimo_Seq = ds_log_exp.Object.Nr_Atualizacao[ll_Total_Linhas]
	End If
	
	as_XML += 	'</imp:MT_REQUEST_CONT_RET>'+&
					'</soapenv:Body>'+&
					'</soapenv:Envelope>'

Catch (RuntimeError lo_rte)
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Monta_XML_Contabil_Ret', objeto 'uo_ge470_sap'. Erro: "+lo_rte.GetMessage()
	Return False

Finally
	If IsValid(ds_log_exp) Then 	Destroy(ds_log_exp)
End Try

Return True
end function

public function boolean of_envia_webservice_new (string as_url, string as_xml_envio, ref string as_xml_retorno, ref string as_erro);String	ls_Status_Text

Long ll_Status_Code

Any la_Code

Try
	Try
		la_Code = io_Xml_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
		
		If la_Code = 0 Then
			io_Xml_Http.open ("POST", as_URL, False, is_Usuario, is_Senha)
			
			io_Xml_Http.SetTimeOuts(5000,5000,15000,15000)
			io_Xml_Http.SetAutomationTimeout(5000)
			
			io_Xml_Http.setRequestHeader("Content-Type", "text/xml") 
			
			io_Xml_Http.send(as_Xml_Envio)	
	
			//Pega a resposta do web service
			ls_Status_Text = io_Xml_Http.StatusText
			ll_Status_Code = io_Xml_Http.Status		
		
			If ll_Status_Code >= 300 Or ll_Status_Code = 0 Then
				as_Erro = "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
				Return False
			Else
				//Pega o retorno do web service
				as_Xml_Retorno = String(io_Xml_Http.ResponseText)
			End If
		Else
			as_Erro = "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o do novo objeto de conex$$HEX1$$e300$$ENDHEX$$o Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(la_Code)
		End If
	Finally
		//Disconecta		
		io_Xml_Http.DisconnectObject()
		
		GarbageCollect()
	End Try

Catch (RuntimeError lo_rte)
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_Envia_WebService_New', objeto 'uo_ge470_sap'. Erro: "+lo_rte.GetMessage()
	Return False
End Try

Return True
end function

public subroutine of_seta_url_webservice (string as_url);io_Xml_Http.open ("POST", as_URL, False, is_Usuario, is_Senha)
end subroutine

public function boolean of_altera_status_log_exportacao (long al_atualizacao, string as_status, ref string as_log, string as_erro);Update log_exportacao_sap
Set id_status_integracao  =:as_status, de_erro =:as_erro
Where nr_atualizacao = :al_Atualizacao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro ao atualizar log_exportacao_sap_historico: " + SqlCa.SqlerrText
	Return False
End If

Return True


end function

public function boolean of_grava_erro_historico (long al_atualizacao, date adt_documento, long al_item, string as_erro, ref string as_log);String ls_Doc

ls_Doc = String(al_atualizacao)

//of_grava_erro_historico(al_atuali, adt_documento, al_item, erro, log)

update log_exportacao_sap_historico
set de_erro = :as_erro
where nr_atualizacao = :al_atualizacao
	and nr_documento = :ls_Doc
	and dh_documento = :adt_documento
	and nr_item = :al_item
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do registro na tebela log_exportacao_sap_historico: " + SqlCa.SqlerrText
	Return False
End If

Return True


end function

public function boolean of_insere_log_exportacao_sap (integer ai_tipo_log, string as_nr_documento, string as_id_tipo_nf, long al_cd_filial_nota, long al_nr_nf_nota, string as_especie_nota, string as_serie_nota, string as_fornecedor, long al_nr_lancamento_caixa, ref string as_log, ref long al_nr_atualizacao, string as_ambiente_sap, string as_chave_interface);Long	ll_Nr_Atualizacao

If ib_Reprocessar Then
	
	// CAIXA
	If ai_tipo_log = 5 Then
		Select nr_atualizacao
		 Into :ll_Nr_Atualizacao
		 From log_exportacao_sap
		Where cd_empresa				= :ii_Empresa
			and cd_filial 					= :al_cd_filial_nota
			and nr_nf						= :al_nr_nf_nota
			and nr_lancamento_caixa 	= :al_nr_lancamento_caixa
			and id_tipo_nf		= :as_Id_Tipo_Nf
			and cd_ambiente_sap = :as_ambiente_sap
		Using SqlCa;
	Else
		Select nr_atualizacao
		 Into :ll_Nr_Atualizacao
		 From log_exportacao_sap
		Where cd_empresa	= :ii_Empresa
			and id_tipo_log		= :ai_Tipo_Log
			and cd_chave		= :as_Nr_Documento
			and id_tipo_nf		= :as_Id_Tipo_Nf
			and cd_ambiente_sap = :as_ambiente_sap
		Using SqlCa;
	End If
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			as_Log += "N$$HEX1$$e300$$ENDHEX$$o foi localizado o documento para ser reprocessado."
			Return False			
		Case -1
			as_Log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do campo NR_ATUALIZACAO da tabela log_exportacao_sap: " + SqlCa.SqlerrText
			Return False
	End Choose
Else
	If Not lf_ge470_proximo_sequencial_log(ref ll_Nr_Atualizacao, ref as_Log) Then Return False
	
	Insert Into log_exportacao_sap(nr_atualizacao, cd_empresa, id_tipo_log, cd_chave, id_tipo_nf, cd_filial, nr_nf, de_especie, de_serie, cd_fornecedor, id_situacao_docto, id_status_integracao, dh_exportacao, nr_lancamento_caixa, cd_ambiente_sap, cd_chave_interface)
	Values(:ll_Nr_Atualizacao, :ii_Empresa, :ai_Tipo_Log, :as_Nr_Documento, :as_Id_Tipo_Nf, :al_cd_filial_nota, :al_nr_nf_nota, :as_especie_nota, :as_serie_nota, :as_fornecedor, 'C', 'C', getdate(), :al_nr_lancamento_caixa, :as_ambiente_sap, :as_chave_interface)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log += "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o do registro na tabela log_exportacao_sap: " + SqlCa.SqlerrText
		Return False
	End If
	
End If

al_nr_atualizacao = ll_Nr_Atualizacao

//SqlCa.of_Commit()

Return True
end function

public function boolean of_abre_log (long pl_tentativa);String	lvs_Path

If pl_tentativa > 5 Then 
    MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo de log '" + is_Log + "'.", StopSign!)
	Return False
End If

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If lvs_Path <> "" Then
	
	is_Log = lvs_Path + "integracao_sap_" + String(Now(),'yyyymmdd_hhmmss') + ".log"
	
	ii_log = FileOpen(is_Log, LineMode!, Write!, LockWrite!)
	
	If ii_log = -1 Then 
		Sleep(1)
		Return This.Of_Abre_Log( pl_tentativa + 1)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio para grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de log n$$HEX1$$e300$$ENDHEX$$o foi localizado.~r~r" +&
						  "Verifique o INI da aplica$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_processa_retorno_xml_interface (string as_xml);long ll_contador=0
string ls_msg, ls_mensagem

DO 
	
	ls_msg = of_busca_valor(as_xml, '<nr_doc_externo>', ll_contador)
	
	if ls_msg = '' or isnull(ls_msg) Then
		ll_contador = 0
	else
		ll_contador++
		ls_mensagem += ls_msg
	end if
	
Loop While ll_contador > 0

ls_mensagem = ls_mensagem

return True
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

public function boolean of_envia_webservice (string as_url, string as_xml_envio, ref string as_xml_retorno, ref string as_erro, long al_timeout);String		ls_Status_Text

long   ll_Status_Code, ll_retorno

OleObject lo_Xml_Http

String	ls_Usuario,&
		ls_Senha

Try
	Try
		
		ls_Usuario = 'PO_INTEGRACAO';
		ls_Senha = 'P0_INTEGRACAO$';
		
		lo_Xml_Http = CREATE oleobject		
		lo_Xml_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")

		lo_Xml_Http.open ("POST", as_URL, False, is_Usuario, is_Senha)
		
		lo_Xml_Http.SetTimeOuts(5000,5000,30000,al_timeout)
		lo_Xml_Http.SetAutomationTimeout(al_timeout)

		lo_Xml_Http.setRequestHeader("Content-Type", "text/xml") 

		lo_Xml_Http.send(as_Xml_Envio)	

		//Pega a resposta do web service
		ls_Status_Text = lo_Xml_Http.StatusText
		ll_Status_Code = lo_Xml_Http.Status		
		as_Xml_Retorno = String(lo_Xml_Http.ResponseText) //Teste guilherme
		
		If ll_Status_Code >= 300 Or ll_Status_Code = 0 Then
			as_Erro = "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
			Return False
		Else
			//Pega o retorno do web service
			as_Xml_Retorno = String(lo_Xml_Http.ResponseText)
		End If
	Catch (RuntimeError lo_rte2)
		as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_Envia_WebService', objeto 'uo_ge470_sap'. Erro: "+lo_rte2.GetMessage()
		//Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", as_Erro)
		Return False
	Finally
		//Disconecta
		lo_Xml_Http.DisconnectObject()
		
		GarbageCollect()
		
		Destroy(lo_Xml_Http)
	End Try

Catch (RuntimeError lo_rte)
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_Envia_WebService', objeto 'uo_ge470_sap'. Erro: "+lo_rte.GetMessage()
	Return False
End Try

Return True
end function

public function boolean of_verifica_desc_centro_custo (long al_centro_custo, ref string as_centro_custo, ref string as_log);SetNull(as_centro_custo)

Select  de_centro_custo
Into  :as_centro_custo
From centro_custo  
Where cd_centro_custo  =:al_centro_custo
Using SqlCA;


If SqlCa.SqlCode = -1 Then
	as_Log += "N$$HEX1$$e300$$ENDHEX$$o foi localizado a Descri$$HEX2$$e700e300$$ENDHEX$$o Centro Custo Legado:[tabela:Centro_Custo]"+SqlCa.SqlerrText
	Return False
End If


Return True 
end function

on uo_ge470_sap_comum.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge470_sap_comum.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;OracleMult = Create dc_uo_transacao
ids_contas = Create dc_uo_ds_base

io_Xml_Http = Create OleObject
io_Xml_Http.ConnectToNewObject("Msxml2.XMLHTTP.6.0")

of_Abre_Log(1)

If gvb_Carrega_Contas_Mult Then
	of_carrega_contas_mult()
End If

ib_Reprocessar = False

is_Termino_Cabecalho = '</I_CABECALHO>'

is_XML_Inicio = 	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
				  		'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_REQUEST_CONTABIL>'
						
is_XML_Termino = '</imp:MT_REQUEST_CONTABIL>'+&
						'</soapenv:Body>'+&
						'</soapenv:Envelope>'



end event

event destructor;If IsValid(OracleMult) Then
	If OracleMult.Of_IsConnected( ) Then OracleMult.Of_disconnect( )
	Destroy(OracleMult)
End If

If IsValid(ids_Contas) Then Destroy ids_Contas

If IsValid(io_Xml_Http) Then Destroy io_Xml_Http

If IsValid(io_Xml_Http) Then io_Xml_Http.DisconnectObject()

//FileClose(ii_Log)

If ii_Log > 0 Then
	FileClose(ii_Log)
	
	If FileLength(is_Log) = 0 Then
		FileDelete(is_Log) 
	End If
End If




end event

