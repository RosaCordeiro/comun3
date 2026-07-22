HA$PBExportHeader$uo_ge481_historico_consumo.sru
forward
global type uo_ge481_historico_consumo from nonvisualobject
end type
end forward

global type uo_ge481_historico_consumo from nonvisualobject
end type
global uo_ge481_historico_consumo uo_ge481_historico_consumo

type variables
uo_ge470_sap_comum io_sap_comum

String is_Origem_Legado 		= "SYBASE"
Integer ii_Empresa				= 1000
String is_URL
String is_Inicio_XML
String is_Termino_XML
String is_Arquivo_Log
String is_Ambiente_SAP

String is_DS 				= 'ds_ge481_historico_consumo'
String is_Objeto 			= 'uo_ge481_historico_consumo'
String is_nome_arquivo 	= 'hist_consumo_xml'

Integer	ii_log

end variables

forward prototypes
public function boolean of_ambiente_sap (ref string as_log)
public subroutine of_processa_envio ()
public function boolean of_abre_log (string as_nome_arquivo)
public function boolean of_atualiza_processado (long pl_nr_movimento, long pl_cd_filial, long pl_cd_produto, datetime pdh_movimento, ref string as_log)
protected function boolean of_valida_situacao (long pl_nr_movimento, long pl_cd_filial, long pl_cd_produto, datetime pdh_movimento, ref long pl_situacao_pendente, ref string ps_log)
public subroutine of_grava_xml (string as_xml, long pl_cd_filial, long pl_sequencia)
public function boolean of_monta_xml_prod (datastore pds_hist_consumo, long pl_linha, ref string ps_xml, ref string ps_log)
end prototypes

public function boolean of_ambiente_sap (ref string as_log);return gf_ambiente_sap( ref is_ambiente_sap, ref as_log )
end function

public subroutine of_processa_envio ();string ls_tipo_log_exp
string ls_descricao_tipo_log
string ls_nome_interface
string ls_grava_xml
string ls_log
string ls_parametro_url
string ls_xml
string ls_cd_filial_sap
string ls_xml_produto
string ls_Xml_Retorno
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
datetime ldh_movimento, ldh_data_hora_ini_mov, ldh_data_filial
date ldh_data_ini_mov

ls_Parametro_URL 		= 'CD_URL_HISTORICO_CONSUMO'
ls_Tipo_Log_Exp 			= 'CON'
ls_Descricao_Tipo_Log	= 'HISTORICO_CONSUMO'
ls_Nome_Interface 		= 'HISTORICO_CONSUMO'

dc_uo_ds_base lds_filiais, lds_hist_consumo

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log )

gvs_Log_Geral = ''

ls_Grava_XML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "Grava_XML", "")

try 
	
	lds_filiais = Create dc_uo_ds_base
	lds_hist_consumo = Create dc_uo_ds_base
	
	ll_Log = FileLength(is_Arquivo_Log)
	
	If Not of_ambiente_sap(ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
		
	If Not lds_hist_consumo.of_ChangeDataObject(is_DS, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS + "' - " + is_Objeto, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not lds_filiais.of_ChangeDataObject('ds_ge481_filial_hist_con', False) Then
		lf_ge470_log("Erro ao alterar a DW 'ds_ge481_filial_parametro' - " + is_Objeto, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not gf_retorna_pametro_sap(SQLCA, is_Ambiente_SAP, ls_Parametro_URL, ref is_URL, ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
	
	Open(w_Aguarde)
	
	//Busca a lista de Filiais
	lds_filiais.retrieve( )
	
	for ll_linha = 1 to lds_filiais.rowcount( )
		
		ls_xml = ''
		
		ll_cd_filial = lds_filiais.object.cd_filial[ll_linha]
		
		ldh_data_hora_ini_mov = lds_filiais.object.dh_inicio_movimento[ll_linha]
		ldh_data_ini_mov = date(ldh_data_hora_ini_mov)
		
		ldh_data_filial = lds_filiais.object.dh_saldo_inicio_filial[ll_linha]

		ll_linhas = lds_hist_consumo.retrieve(ll_cd_filial,ldh_data_ini_mov, ldh_data_hora_ini_mov, ldh_data_filial)

		ll_contador = 0
		
		if ll_linhas > 0 Then
				
			w_aguarde.uo_progress.of_setmax(ll_linhas)
			w_Aguarde.Title = "Atualizando [" + ls_Nome_Interface + "] no SAP ..."
			
			ll_seq_xml = 0
			
			for ll_for = 1 to ll_linhas
		
				ll_nr_movimento = lds_hist_consumo.object.nr_movimento_estoque[ll_for]
				ll_cd_produto = lds_hist_consumo.object.cd_produto[ll_for]
				ll_cd_tipo = lds_hist_consumo.object.cd_tipo_movimento[ll_for]
				ldh_movimento = lds_hist_consumo.object.dh_movimento[ll_for]
		
				if this.of_valida_situacao( ll_nr_movimento, ll_cd_filial, ll_cd_produto, ldh_movimento, ref ll_situacao_pendente, ref ls_log) = False Then
					lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
					return
				end if
		
				if ll_situacao_pendente = 0 or isnull(ll_situacao_pendente) Then Continue
				
				if this.of_atualiza_processado(ll_nr_movimento, ll_cd_filial, ll_cd_produto, ldh_movimento, ref ls_log) = False Then
					lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
					return
				end if
				
				ll_contador++
				
				if ll_contador = 1 Then
					
					ls_cd_filial_sap = lds_hist_consumo.object.cd_filial_sap[ll_for]
					ls_xml_produto += '<CENTRO>' + ls_cd_filial_sap + '</CENTRO>'
					
				end if
				
				if this.of_monta_xml_prod(lds_hist_consumo, ll_for, ref ls_xml_produto, ref ls_log) = False Then
					lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
					return
				end if
				
				if ll_contador > 100 or ll_for >= ll_linhas Then
				
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
				
					If FileLength(is_Arquivo_Log) > ll_Log Then
						SqlCa.of_Rollback()
					else
						SqlCa.of_Commit()
					end if
					
					ls_xml_produto = ''
					ls_xml = ''
					
					ll_contador = 0
					
				end if
				
				w_aguarde.uo_progress.of_setprogress(ll_for)	
				
			Next
		
		end if
		
	Next
			
catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o [" + is_DS + "], objeto ["+ is_Objeto +"]. Erro: "+lo_rte.GetMessage())
	Return
finally
	
	If FileLength(is_Arquivo_Log) > ll_Log Then
		SqlCa.of_Rollback()
	end if
	
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
		
	If IsValid(lds_filiais) Then Destroy lds_filiais
	
end try
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

public function boolean of_atualiza_processado (long pl_nr_movimento, long pl_cd_filial, long pl_cd_produto, datetime pdh_movimento, ref string as_log);update movimento_estoque
set dh_exportacao_sap = getdate()
where nr_movimento_estoque = :pl_nr_movimento
and cd_filial_movimento = :pl_cd_filial
and cd_produto = :pl_cd_produto
and dh_movimento = :pdh_movimento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento movimento_estoque 'of_atualiza_processado': " + SqlCa.SqlerrText
	Return False
End If

Return True

end function

protected function boolean of_valida_situacao (long pl_nr_movimento, long pl_cd_filial, long pl_cd_produto, datetime pdh_movimento, ref long pl_situacao_pendente, ref string ps_log);long ll_existe
string ls_status
	
Select count(*)
	into :pl_situacao_pendente
from movimento_estoque
where nr_movimento_estoque = :pl_nr_movimento
	and cd_filial_movimento = :pl_cd_filial
	and cd_produto = :pl_cd_produto
	and dh_movimento = :pdh_movimento
	and dh_exportacao_sap is null
Using SQLCA;

If SqlCa.SqlCode = -1 Then
	ps_log = "Erro ao consultar a tabela movimento_estoque 'of_valida_situacao': " + SqlCa.SqlerrText
	Return False
End If

return true
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

public function boolean of_monta_xml_prod (datastore pds_hist_consumo, long pl_linha, ref string ps_xml, ref string ps_log);string ls_cd_filial, ls_cd_produto_sap
long ll_qt_movimento, ll_tp_movimento, ll_cd_produto
datetime ldh_movimento

ll_cd_produto = pds_hist_consumo.object.cd_produto[pl_linha]
ls_cd_produto_sap = pds_hist_consumo.object.cd_produto_sap[pl_linha]
ldh_movimento = pds_hist_consumo.object.dh_movimento[pl_linha]
ll_qt_movimento = pds_hist_consumo.object.qt_movimento[pl_linha]

if ls_cd_produto_sap = '' or isnull(ls_cd_produto_sap) Then
	ps_log = 'O produto ' + String(ll_cd_produto) + ' n$$HEX1$$e300$$ENDHEX$$o possui c$$HEX1$$f300$$ENDHEX$$digo SAP cadastrados.'
	return false
end if

ps_xml += '<MATERIAIS>'
ps_xml += '<MATERIAL>' + ls_cd_produto_sap + '</MATERIAL>'
ps_xml += '<DATA_MOVIMENTO>' + String(ldh_movimento,'dd/mm/yyyy') + '</DATA_MOVIMENTO>'
ps_xml += '<QUANTIDADE>' + String(ll_qt_movimento) + '</QUANTIDADE>'
ps_xml += '</MATERIAIS>'

return true
end function

on uo_ge481_historico_consumo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge481_historico_consumo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_Abre_Log(is_nome_arquivo)

io_sap_comum = Create uo_ge470_sap_comum

is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_hist_consumo_Request>'
							
is_Termino_XML	=	'</imp:MT_hist_consumo_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
							

end event

event destructor;Destroy(io_sap_comum)

FileClose(ii_Log)
end event

