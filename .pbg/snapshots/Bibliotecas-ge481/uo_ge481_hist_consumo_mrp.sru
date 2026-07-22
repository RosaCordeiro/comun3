HA$PBExportHeader$uo_ge481_hist_consumo_mrp.sru
forward
global type uo_ge481_hist_consumo_mrp from nonvisualobject
end type
end forward

global type uo_ge481_hist_consumo_mrp from nonvisualobject autoinstantiate
end type

type variables
uo_ge470_sap_comum io_sap_comum

String is_Origem_Legado 		= "SYBASE"
Integer ii_Empresa				= 1000
String is_URL
String is_Inicio_XML
String is_Termino_XML
String is_Arquivo_Log
String is_Ambiente_SAP

String is_DS 				= 'ds_ge481_hist_consumo_mrp'
String is_Objeto 			= 'uo_ge481_hist_consumo_mrp'
String is_nome_arquivo 	= 'hist_consumo_mrp_xml'
String is_Nome_Interface =  'HISTORICO_MRP_LEGADO'

Integer	ii_log

boolean ib_monitor_exp=false
end variables

forward prototypes
public function boolean of_ambiente_sap (ref string as_log)
public function boolean of_abre_log (string as_nome_arquivo)
public subroutine of_grava_xml (string as_xml, long pl_cd_filial, long pl_sequencia)
public function boolean of_periodo_resumo (long al_filial, ref date adh_inicio_e, ref date adh_termino_e, ref date adh_inicio_s, ref date adh_termino_s, ref string as_log)
public function boolean of_processa_retorno_xml (string as_xml, ref string as_mensagem)
public function string of_busca_valor (string as_xml, string as_tag, ref long al_pos)
public subroutine of_processa_envio (long pl_nr_atualizacao)
public subroutine of_processa_envio ()
public function boolean of_grava_log_exportacao (ref string ps_log)
protected function boolean of_valida_situacao (long pl_nr_atualizacao, boolean pb_individual, ref long pl_situacao_pendente, ref string ps_log)
public function boolean of_atualiza_processado (long pl_nr_atualizacao, string ps_status, string ps_mensagem, ref string ps_log)
end prototypes

public function boolean of_ambiente_sap (ref string as_log);return gf_ambiente_sap( ref is_ambiente_sap, ref as_log )
end function

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

public subroutine of_grava_xml (string as_xml, long pl_cd_filial, long pl_sequencia);String lvs_Path, lvs_Log
blob lbl_xml
Integer li_Log

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

lbl_xml = Blob(as_xml)

If lvs_Path <> "" Then
	
	lvs_Log = lvs_Path + is_nome_arquivo + "_"  + String(pl_cd_filial) + "_" + String(pl_sequencia) + "_" +  String(year(today()), "0000") + String(Month(today()), "00") + String(Day(today()), "00") + "_" + String(Hour(Now()), "00") +  String(Minute(Now()), "00") + String(Second ( Now() ), "00") + ".xml"
	
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

public function boolean of_periodo_resumo (long al_filial, ref date adh_inicio_e, ref date adh_termino_e, ref date adh_inicio_s, ref date adh_termino_s, ref string as_log);Date ldh_Movimento

Long ll_Linhas

ldh_Movimento = Relativedate(Today(), -1)

//Sazonal

adh_inicio_S = relativedate(ldh_Movimento, -365)
adh_Termino_S = ldh_Movimento

//Est$$HEX1$$e100$$ENDHEX$$vel	
dc_uo_ds_base lds 

try
	lds = Create dc_uo_ds_base
	
	lds.of_ChangeDataObject("ds_el020_dias_estavel")
	
	ll_Linhas = lds.retrieve(al_Filial, 120, ldh_Movimento)
	
	If ll_Linhas > 0 Then
		adh_Inicio_E = Date(lds.Object.dh_resumo[ll_Linhas])
		adh_Termino_E = Date(lds.Object.dh_resumo[1])
	Else
		as_log = "Erro ao determinar a data de in$$HEX1$$ed00$$ENDHEX$$cio e t$$HEX1$$e900$$ENDHEX$$rmino para localizar o hist$$HEX1$$f300$$ENDHEX$$rico de vendas."
		Return False
	End If
	
	
finally
	Destroy	lds
end try

Return True
end function

public function boolean of_processa_retorno_xml (string as_xml, ref string as_mensagem);long ll_contador=0
string ls_status, ls_data, ls_log, ls_erro
long ll_cd_filial, ll_cd_produto
decimal ldc_qt_venda
datetime ldh_resumo
str_log_export_sap lst_log
uo_ge473_comum luo_comum

ll_contador = 1

return true

try

	luo_comum = create uo_ge473_comum
	
	DO 
		
		luo_comum.of_localiza_codigo_produto_legado( of_busca_valor(as_xml, '<cd_material>', ref ll_contador) , ref ll_cd_produto, ref ls_log )
		
		luo_comum.of_localiza_codigo_filial_legado( of_busca_valor(as_xml, '<cd_centro>', ref ll_contador) , ref ll_cd_filial, ref ls_log)
		
		//ls_data = gf_get_value(as_xml, '<cd_data>', ll_contador )
		ls_data = of_busca_valor(as_xml, '<cd_data>', ref ll_contador)
		
		ldh_resumo = Datetime( Date(ls_data), Time( ls_data ) )
		
		//ls_status =  gf_get_value(as_xml, '<status>', ll_contador)
		ls_status =  of_busca_valor(as_xml, '<status>', ref ll_contador)
		
		ldc_qt_venda = dec(gf_replace(of_busca_valor(as_xml, '<cd_quantidade>', ref ll_contador), '.', ',',0))
		
		if ls_status = '' or isnull(ls_status) Then
			Exit
		end if
		
		if upper(ls_status) = 'E' Then
			
//			if this.of_atualiza_processado(ll_nr_atualizacao, 'E', ref ls_log) = False Then
//				lf_ge470_log(ls_log, 1, 'HISTORICO MRP', 'HISTORICO_MRP', ii_log)
//				return false
//			end if
			
			ls_erro = 'Filial: ' + string(ll_cd_filial) + ' - Produto: ' + string(ll_cd_produto) + ' - Data: ' + ls_data + ' - Quantidade: ' + string(ldc_qt_venda) + ' - Erro ao importar o registro no SAP.'
			
		//	lf_ge470_log(ls_erro, 1, 'HISTORICO MRP', 'HISTORICO_MRP', ii_log)
			
			lst_log.cd_ambiente_sap = 'PRD'
			lst_log.cd_chave = string(ll_cd_produto) + '/' + string(ll_cd_filial)
			lst_log.cd_empresa = 1000
			lst_log.cd_filial = ll_Cd_filial
			lst_log.cd_produto = ll_Cd_produto
			lst_log.cd_tipo_documento = 'MRP'
			lst_log.de_erro = ls_erro
			lst_log.dh_documento = ldh_resumo
			lst_log.id_situacao_docto = 'C'
			lst_log.id_status_integracao = 'E'
			lst_log.id_tipo_log = 40
			lst_log.id_tipo_nf = 'MRP'
			
			luo_comum.of_grava_log_exportacao( lst_log, ref as_mensagem )
			
			gf_ge202_envia_email_automatico(187 , '', ls_erro, {''})
			
		end if
		
	Loop While ll_contador > 0

Finally

	Destroy(luo_comum)

End Try

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

public subroutine of_processa_envio (long pl_nr_atualizacao);string ls_tipo_log_exp
string ls_descricao_tipo_log
string ls_nome_interface
string ls_grava_xml
string ls_log
string ls_parametro_url
string ls_xml
string ls_cd_filial_sap
string ls_xml_produto
string ls_Xml_Retorno
String ls_tipo_reposicao
String ls_produto_sap
long ll_log
long ll_linha
long ll_cd_filial
long ll_linhas
long ll_contador
long ll_seq_xml
long ll_for
long ll_nr_movimento
long ll_cd_produto
long ll_cd_tipo
long ll_situacao_pendente
long ll_qt_venda
long ll_nr_atualizacao
long ll_progresso_geral=0
long ll_qt_envios, ll_nr_xml = 1
Decimal{2} ldc_divisao
integer li_contador_xml = 500
datetime ldh_resumo
date ldh_inicio_E, ldh_termino_E, ldh_inicio_S, ldh_termino_S

ls_Parametro_URL 		= 'CD_URL_HISTORICO_CONSUMO_MRP'
ls_Tipo_Log_Exp 			= 'HIM'
ls_Descricao_Tipo_Log	= 'HISTORICO CONSUMO MRP'
ls_Nome_Interface 		= 'HISTORICO_MRP_LEGADO'

dc_uo_ds_base lds_hist_consumo

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log )

gvs_Log_Geral = ''

ls_Grava_XML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "Grava_XML", "")

if pl_nr_atualizacao > 0 then
	ib_monitor_exp = True
end if

try 
	
	if isvalid(w_aguarde_3) then	
		if pl_nr_atualizacao > 0 Then
			w_aguarde_3.uo_progress.of_setmax(3)
		else
			w_aguarde_3.uo_progress.of_setmax(4)
		end if
		
		w_aguarde_3.wf_settext('Validando as configura$$HEX2$$e700f500$$ENDHEX$$es da interface...', 2)
	end if
	
	lds_hist_consumo = Create dc_uo_ds_base
	
	ll_Log = FileLength(is_Arquivo_Log)
	
	If Not of_ambiente_sap(ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
		
	If Not lds_hist_consumo.of_ChangeDataObject('ds_ge481_hist_con_mrp_log', False) Then
		lf_ge470_log("Erro ao alterar a DW '" + 'ds_ge481_hist_con_mrp_log' + "' - " + is_Objeto, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not gf_retorna_pametro_sap(SQLCA, is_Ambiente_SAP, ls_Parametro_URL, ref is_URL, ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
	
	if pl_nr_atualizacao > 0 Then

		
		lds_hist_consumo.of_appendwhere_subquery( 'ls.nr_atualizacao = ' + string(pl_nr_atualizacao),2 )
		
		
	else
		
		lds_hist_consumo.of_appendwhere_subquery( "ls.id_status_integracao = 'C' " ,2 )
		
		if isvalid(w_aguarde_3) then	
			ll_progresso_geral++
			w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
			
			w_aguarde_3.wf_settext('Gravando Log Exporta$$HEX2$$e700e300$$ENDHEX$$o...', 2)
		end if
		
		if this.of_grava_log_exportacao( ref ls_log) = False Then
			lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
			Return 
		end if
		
	end if
	
	if isvalid(w_aguarde_3) then	
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
		
		w_aguarde_3.wf_settext('Buscando informa$$HEX2$$e700f500$$ENDHEX$$es do banco de dados...', 2)
	end if
	
	ll_linhas = lds_hist_consumo.retrieve()

	ll_contador = 0
	
	if ll_linhas < 0 Then
		lf_ge470_log('Erro ao consultar hist$$HEX1$$f300$$ENDHEX$$rico de consumo mrp.', 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	end if
		
	if isvalid(w_aguarde_3) then	
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
	end if	
		
	if ll_linhas = 0 Then return
		
	//Calcula quantos XML ser$$HEX1$$e300$$ENDHEX$$o enviados.
	ldc_divisao = ll_linhas / li_contador_xml
	ll_qt_envios = integer(ldc_divisao)
	
	if ldc_divisao > ll_qt_envios Then
		ll_qt_envios++
	end if	
		
	if isvalid(w_aguarde_3) then	
		w_Aguarde_3.wf_settext( "Enviando informa$$HEX2$$e700f500$$ENDHEX$$es para o SAP ...", 2 )
		
		w_aguarde_3.uo_progress_2.of_setmax(ll_qt_envios)
	end if		
	
	ll_seq_xml = 0
		
	for ll_for = 1 to ll_linhas

		ll_contador++

		ll_nr_atualizacao = lds_hist_consumo.object.nr_atualizacao[ll_for]
		ll_cd_produto = lds_hist_consumo.object.cd_produto[ll_for]
		ls_produto_sap = lds_hist_consumo.object.cd_produto_sap[ll_for]
		ll_qt_venda = lds_hist_consumo.object.nr_lancamento[ll_for]
		ldh_resumo = lds_hist_consumo.object.dh_documento[ll_for]
		ls_cd_filial_sap = lds_hist_consumo.object.cd_filial_sap[ll_for]
		
		if isvalid(w_aguarde_3) then	
			w_aguarde_3.wf_settext('Enviando XML: ' + String(ll_nr_xml) + ' de ' + String(ll_qt_envios) + '...' , 3)
			w_aguarde_3.wf_settext('Produto: ' + String(ll_cd_produto) , 4)
		end if	
		
		if pl_nr_atualizacao > 0 Then
			//Processo individual chamado pelo Monitor de exporta$$HEX2$$e700e300$$ENDHEX$$o: Deve aceitar os status C e E.
			if this.of_valida_situacao( ll_nr_atualizacao, True, ref ll_situacao_pendente, ref ls_log) = False Then
				lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
				return
			end if
		else
			//Processo geral chamado pela tela de Exporta$$HEX2$$e700e300$$ENDHEX$$o Automatica: Deve aceitar apenas status C.
			if this.of_valida_situacao( ll_nr_atualizacao, False, ref ll_situacao_pendente, ref ls_log) = False Then
				lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
				return
			end if
		end if
	
		if ll_situacao_pendente = 0 or isnull(ll_situacao_pendente) Then Continue
		
		if this.of_atualiza_processado(ll_nr_atualizacao, 'S','', ref ls_log) = False Then
			lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
			return
		end if
		
		ls_xml_produto += '<dados>'
		ls_xml_produto += '<cd_centro>'+ ls_cd_filial_sap + '</cd_centro>'
		ls_xml_produto += '<cd_material>' + ls_produto_sap + '</cd_material>'
		ls_xml_produto += '<cd_quantidade>' + string(ll_qt_venda) + '</cd_quantidade>'
		ls_xml_produto += '<cd_data>' + String(ldh_resumo,'dd/mm/yyyy') + '</cd_data>'
		ls_xml_produto += '</dados>'
		
		if ll_contador >= li_contador_xml or ll_for >= ll_linhas Then
		
			ls_XML =	 is_Inicio_XML 
		
			if ls_xml_produto <> '' Then ls_xml += ls_xml_produto 
		
			ls_xml += is_Termino_XML
		
			If ls_Grava_XML = "S" Then
				ll_seq_xml++
				This.of_grava_xml(ls_XML, ll_cd_filial, ll_seq_xml)
			End If
		
			If not io_sap_comum.of_Envia_Webservice(is_URL, ls_XML, Ref ls_Xml_Retorno, Ref ls_log) Then
				SqlCa.of_Rollback()
				lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
			End If
			
			If Not of_processa_retorno_xml(ls_xml_retorno, ref ls_log) Then
				SqlCa.of_Rollback()
			end if
		
			If FileLength(is_Arquivo_Log) > ll_Log Then
				SqlCa.of_Rollback()
			else
				SqlCa.of_Commit()
			end if
			
			ls_xml_produto = ''
			ls_xml = ''
		
			ll_contador = 0
			
			if isvalid(w_aguarde_3) then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_nr_xml)	
			end if
			
			ll_nr_xml++
			
		end if
			
	Next
			
	if isvalid(w_aguarde_3) then	
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
	end if			
			
catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o [" + is_DS + "], objeto ["+ is_Objeto +"]. Erro: "+lo_rte.GetMessage())
	Return
finally
	
	If FileLength(is_Arquivo_Log) > ll_Log Then
		SqlCa.of_Rollback()
	end if
	
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
		
	If IsValid(lds_hist_consumo) Then Destroy lds_hist_consumo
	
end try
end subroutine

public subroutine of_processa_envio ();of_processa_envio(0)
end subroutine

public function boolean of_grava_log_exportacao (ref string ps_log);long ll_linhas_filial, ll_for1, ll_for2, ll_nr_atualizacao, ll_cd_produto, ll_contador, ll_cd_filial, ll_progresso=0, ll_linhas, ll_total_prod
datetime ldt_data_hora, ldh_resumo
date ldt_data, ldh_Parametro
boolean lb_sucesso = true
Date ldh_inicio_E, ldh_inicio_S, ldh_termino_E, ldh_termino_S
dc_uo_ds_base lds_filiais, lds_hist_consumo
uo_ge473_comum luo_comum
str_log_export_sap lst_info

if not isvalid(w_aguarde) Then Open(w_Aguarde)

Try

	luo_comum = create uo_ge473_comum

	lds_filiais = Create dc_uo_ds_base
	if Not lds_filiais.of_changedataobject( 'ds_ge481_hist_con_mrp_filial' ) Then
		ps_log = 'Erro ao localizar a datawindow "ds_ge481_hist_con_mrp_filial".'
		lb_sucesso = false
		return false
	end if
	
	lds_hist_consumo = Create dc_uo_ds_base
	if Not lds_hist_consumo.of_changedataobject( is_ds ) Then
		ps_log = 'Erro ao localizar a datawindow "' + String(is_ds) + '".'
		lb_sucesso = false
		return false
	end if
	
	ldt_data_hora = gf_getserverdate()
	
	ll_linhas_filial = lds_filiais.retrieve()
	
	if ll_linhas_filial = 0 Then
		lb_sucesso = false
		return true
	end if
	
	ll_contador = 0
	
	for ll_for1 = 1 to ll_linhas_filial
	
		ll_cd_filial = lds_filiais.object.cd_filial[ll_for1]
		
		If ll_cd_filial = 534 Then
			ldh_Parametro = Date(gf_GetServerDate())
			
			ldh_inicio_E 	  	= RelativeDate(ldh_Parametro, -91)
			ldh_termino_E 	= RelativeDate(ldh_Parametro, -1)
			
			ldh_inicio_S		= ldh_inicio_E
			ldh_termino_S	= ldh_termino_E
		Else
			if Not this.of_periodo_resumo( ll_Cd_filial, ref ldh_inicio_E, ref ldh_termino_E, ref ldh_inicio_S, ref ldh_termino_S, ref ps_log) Then
				Return false
			end if
		End If
		
		
		ll_linhas = lds_hist_consumo.retrieve(ll_cd_filial, ldh_inicio_E, ldh_termino_E, ldh_inicio_S, ldh_termino_S)
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			if ll_linhas = 0 Then
				w_aguarde_3.uo_progress_2.of_setmax(1)
			else
				w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
			end if
			w_aguarde_3.wf_settext( "Filial: " + string(ll_cd_filial) + " (" + string(ll_for1) + " de " + string(ll_linhas_filial) + ")", 3)			
		end if
		
		if ll_linhas = 0 Then
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			end if
			Continue
		end if
		
		if ll_total_prod = 0 or isnull(ll_total_prod) Then
			ll_total_prod = ll_linhas
		end if
		
		ll_progresso = 0
		
		for ll_for2 = 1 to ll_linhas
			
			ll_cd_produto = lds_hist_consumo.object.cd_produto[ll_for2]
			ldh_resumo = lds_hist_consumo.object.dh_resumo[ll_for2]
			
			ll_progresso++
			
			if isvalid(w_aguarde_3) Then
				w_Aguarde_3.wf_settext( 'Produto: ' + String(ll_cd_produto) + ' (' + String(ll_progresso) + ' de ' + string(ll_total_prod) + ')', 4)
			end if
			
			lst_info.cd_produto = ll_cd_produto
			lst_info.dh_documento = ldh_resumo
			
			lst_info.cd_filial = ll_cd_filial
			lst_info.cd_ambiente_sap = is_Ambiente_SAP
			lst_info.id_tipo_nf = 'MRP'
			lst_info.dh_exportacao = ldt_data_hora
			lst_info.cd_empresa = 1000
			lst_info.cd_chave = String(ll_cd_filial) + '#' + string(ll_cd_produto) + '#' + String(ldh_resumo,'dd/mm/yyyy')
			lst_info.id_situacao_docto = 'C'
			lst_info.id_status_integracao = 'C'
			lst_info.id_tipo_log = 45
			
			lst_info.nr_lancamento = lds_hist_consumo.object.qt_venda[ll_for2]
			
			if luo_comum.of_grava_log_exportacao( lst_info, ref ps_log ) = false then
				lb_sucesso = false
				return false
			end if
				
			Update resumo_movto_estq_prd
			set dh_exportacao_sap = :ldt_data_hora
			where cd_filial = :ll_cd_filial
				and cd_produto = :ll_cd_produto
				and dh_resumo = :ldh_resumo;
				
			if sqlca.sqlcode = -1 then 
				ps_log = 'Erro ao atualizar registro na tabela "resumo_movto_estq_prd" (of_grava_log_exportacao): ' + sqlca.sqlerrtext
				lb_sucesso = false
				return false
			end if	
			
			ll_contador++
			
			if ll_contador = 200 Then
				ll_contador = 0
				Commit;
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_progresso)	
			end if
			
		next
			
	next
	
Finally
	
	if lb_sucesso = False Then
		Rollback;
	else
		Commit;
	end if
	
	if isvalid(lds_hist_consumo) Then Destroy(lds_hist_consumo)
	if isvalid(lds_filiais) Then Destroy(lds_filiais)
	if isvalid(luo_comum) Then Destroy(luo_comum)
	
End Try

return true
end function

protected function boolean of_valida_situacao (long pl_nr_atualizacao, boolean pb_individual, ref long pl_situacao_pendente, ref string ps_log);if pb_individual =  True then

	Select 1
	into :pl_situacao_pendente
	from log_exportacao_sap
	where nr_atualizacao = :pl_nr_atualizacao
	and id_status_integracao in ('C','E')
	Using SQLCA;
	
else

	Select 1
	into :pl_situacao_pendente
	from log_exportacao_sap
	where nr_atualizacao = :pl_nr_atualizacao
	and id_status_integracao = 'C'
	Using SQLCA;

End If

If SqlCa.SqlCode = -1 Then
	ps_log = "Erro ao consultar a tabela log_exportacao_sap 'of_valida_situacao': " + SqlCa.SqlerrText
	Return False
End If

return true
end function

public function boolean of_atualiza_processado (long pl_nr_atualizacao, string ps_status, string ps_mensagem, ref string ps_log);If ps_status = 'E' Then

	update log_exportacao_sap
	set id_status_integracao = 'E', de_erro = :ps_mensagem
	where nr_atualizacao = :pl_nr_atualizacao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = "Erro ao atualizar registro na tabela resumo_movto_estq_prd 'of_atualiza_processado': " + SqlCa.SqlerrText
		Return False
	End If

else
	
	update log_exportacao_sap
	set id_status_integracao = 'P', de_erro = null
	where nr_atualizacao = :pl_nr_atualizacao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = "Erro ao atualizar registro na tabela resumo_movto_estq_prd 'of_atualiza_processado': " + SqlCa.SqlerrText
		Return False
	End If
	
end if

Return True

end function

on uo_ge481_hist_consumo_mrp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge481_hist_consumo_mrp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_Abre_Log(is_nome_arquivo)

io_sap_comum = Create uo_ge470_sap_comum

is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">' +&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_HistConsumo_Requesst>'
							
is_Termino_XML	=	'</exp:MT_HistConsumo_Requesst>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
							

end event

event destructor;Destroy(io_sap_comum)

FileClose(ii_Log)
end event

