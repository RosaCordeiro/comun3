HA$PBExportHeader$uo_ge481_planograma.sru
forward
global type uo_ge481_planograma from nonvisualobject
end type
end forward

global type uo_ge481_planograma from nonvisualobject
end type
global uo_ge481_planograma uo_ge481_planograma

type variables
uo_ge470_sap_comum io_sap_comum

String is_Origem_Legado 		= "SYBASE"
Integer ii_Empresa				= 1000
String is_URL
String is_Inicio_XML
String is_Termino_XML
String is_Arquivo_Log
String is_Ambiente_SAP

String is_DS 				= 'ds_ge481_planograma'
String is_Objeto 			= 'uo_ge481_planograma'
String is_nome_arquivo 	= 'planograma_xml'

Integer	ii_log

boolean ib_monitor_exp=false



end variables

forward prototypes
public function boolean of_ambiente_sap (ref string as_log)
public subroutine of_processa_envio ()
public function boolean of_abre_log (string as_nome_arquivo)
public function boolean of_atualiza_processado (long al_cd_planograma, ref string as_log)
public function boolean of_monta_xml_planograma (long pl_cd_planograma, ref string ps_xml, ref string ps_log)
public function boolean of_monta_xml_prod (long pl_cd_planograma, long pl_cd_produto, boolean pb_exclusao, ref string ps_xml, ref string ps_log)
public function boolean of_monta_xml_centros (long pl_cd_planograma, long pl_cd_filial, boolean pb_exclusao, ref string ps_xml, ref string ps_log)
public subroutine of_grava_xml (string as_xml, long pl_cd_planograma)
public function boolean of_valida_parametro_filial (long pl_cd_planograma, ref boolean pb_valida, ref string ps_log)
protected function boolean of_valida_situacao (ref datastore pds_dados, boolean pb_filial_valida, ref string ps_log)
public subroutine of_processa_envio (long pl_nr_atualizacao)
public function boolean of_grava_erro (long pl_nr_atualizacao, string ps_mensagem, ref string ps_log)
public function boolean of_monta_xml_est_minimo (long pl_cd_produto, long pl_cd_planograma, long pl_cd_filial, long pl_qt_estoque_minimo, ref string ps_xml, ref string ps_log)
end prototypes

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

public function boolean of_atualiza_processado (long al_cd_planograma, ref string as_log);update log_exportacao_sap
set id_status_integracao = 'P', dh_exportacao = getdate()
where cd_promocao_sos = :al_cd_planograma
and id_status_integracao = 'C'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_sap 'of_atualiza_processado': " + SqlCa.SqlerrText
	Return False
End If

Return True

end function

public function boolean of_monta_xml_planograma (long pl_cd_planograma, ref string ps_xml, ref string ps_log);String	ls_XML
String ls_descricao, ls_alteracao
datetime ldt_inicio, ldt_fim

//Busca os dados do Planograma.
select nm_promocao_sos, dh_inicio_estoque_minimo, dh_termino_estoque_minimo, id_filial_altera_estoque
into :ls_descricao, :ldt_inicio, :ldt_fim, :ls_alteracao
from promocao_sos
where cd_promocao_sos = :pl_cd_planograma;

If SQLCA.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela "promocao_sos": ' + SQlca.SQlerrtext
	return false
end if

ls_descricao = gf_retira_caracteres_especiais_xml(ls_descricao)

ps_xml += '<COD_PLANOGRAMA>' + String(pl_cd_planograma) + '</COD_PLANOGRAMA>' + &
			'<DESCRICAO>' + ls_descricao +'</DESCRICAO>' + &
			'<VIGENCIA_DE>' + string(ldt_inicio,'dd/mm/yyyy') + '</VIGENCIA_DE>' + &
			'<VIGENCIA_ATE>' + string(ldt_fim,'dd/mm/yyyy') + '</VIGENCIA_ATE>' + &
			'<PERMITE_ALTERACAO>' + ls_alteracao + '</PERMITE_ALTERACAO>' 
							
Return True
end function

public function boolean of_monta_xml_prod (long pl_cd_planograma, long pl_cd_produto, boolean pb_exclusao, ref string ps_xml, ref string ps_log);string ls_eliminado
String ls_cd_produto_sap
datetime ldt_inicio, ldt_inicio_planograma

if pb_exclusao = True Then
	ls_eliminado = '<ELIMINADO>X</ELIMINADO>'
else
	ls_eliminado = '<ELIMINADO/>'
End if
	
//Busca os dados do Produto.	
select pg.cd_produto_sap, ps.dh_inicio,
		(Select x.dh_inicio_estoque_minimo
			from promocao_sos x
			Where x.cd_promocao_sos = :pl_cd_planograma) as dh_inicio_planograma
	Into :ls_cd_produto_sap, :ldt_inicio, :ldt_inicio_planograma
	from produto_geral pg
			Left join promocao_sos_planograma ps on (ps.cd_planograma = pg.cd_planograma 
																	and ps.cd_promocao_sos = :pl_cd_planograma)
	where pg.cd_produto = :pl_cd_produto;

If SQLCA.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela "produto_geral". Planograma = ' + String(pl_cd_planograma) + ' ; Produto = ' + String(pl_cd_produto) + ' : ' + SQlca.SQlerrtext
	return false
end if

if isnull(ldt_inicio) Then
	ldt_inicio = ldt_inicio_planograma
end if

ps_xml += '<MATERIAIS>' + &
					'<COD_PLANOGRAMA>' + String(pl_cd_planograma) + '</COD_PLANOGRAMA>' + &
					'<MATERIAL>' + ls_cd_produto_sap +'</MATERIAL>' + &
					'<INICIO>' + string(ldt_inicio,'dd/mm/yyyy') + '</INICIO>' + &
					ls_eliminado + &
				'</MATERIAIS>'

return true
end function

public function boolean of_monta_xml_centros (long pl_cd_planograma, long pl_cd_filial, boolean pb_exclusao, ref string ps_xml, ref string ps_log);string ls_cd_filial_sap, ls_eliminado
datetime ldt_inicio, ldt_inicio_planograma
	
if pb_exclusao = True Then
	ls_eliminado = '<ELIMINADO>X</ELIMINADO>'
else
	ls_eliminado = '<ELIMINADO/>'
end if
	
//Busca os dados da Filial.	
select s.cd_chave_sap, pf.dh_inicio,
		(Select x.dh_inicio_estoque_minimo
			from promocao_sos x
			Where x.cd_promocao_sos = :pl_cd_planograma) as dh_inicio_planograma
into :ls_cd_filial_sap, :ldt_inicio, :ldt_inicio_planograma
from integracao_sap s
		left join promocao_sos_filial pf on (pf.cd_promocao_sos = :pl_cd_planograma
													and pf.cd_filial = :pl_cd_filial)
Where s.cd_empresa = 1000 
	and s.cd_tabela = 'FILIAL'
	and s.cd_chave_legado = cast(:pl_cd_filial as varchar) ;

If SQLCA.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela "promocao_sos_filial": ' + SQlca.SQlerrtext
	return false
end if

if isnull(ldt_inicio) Then
	ldt_inicio = ldt_inicio_planograma
end if

ps_xml += '<CENTROS>' + &
					'<COD_PLANOGRAMA>' + String(pl_cd_planograma) + '</COD_PLANOGRAMA>' + &
					'<CENTRO>' + ls_cd_filial_sap + '</CENTRO>' + &
					'<INICIO>' + String(ldt_inicio,'dd/mm/yyyy') + '</INICIO>' + &
					ls_eliminado + &	
				'</CENTROS>'

return true
end function

public subroutine of_grava_xml (string as_xml, long pl_cd_planograma);String lvs_Path, lvs_Log
blob lbl_xml
Integer li_Log

lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

lbl_xml = Blob(as_xml)

If lvs_Path <> "" Then
	
	lvs_Log = lvs_Path + is_nome_arquivo + "_"  + String(pl_cd_planograma) + "_" +  String(year(today()), "0000") + String(Month(today()), "00") + String(Day(today()), "00") + "_" + String(Hour(Now()), "00") +  String(Minute(Now()), "00") + String(Second ( Now() ), "00") + ".xml"
	
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

public function boolean of_valida_parametro_filial (long pl_cd_planograma, ref boolean pb_valida, ref string ps_log);long ll_existe

select count(*)
into :ll_existe
from promocao_sos_filial pf
Where pf.cd_promocao_sos = :pl_cd_planograma
    and Exists (Select 1 from parametro_loja pl where pl.cd_filial = pf.cd_filial and pl.cd_parametro = 'ID_ADM_FILIAL_SAP' and pl.vl_parametro = 'S')
    and Exists (Select 1 from parametro_loja pl where pl.cd_filial = pf.cd_filial and pl.cd_parametro = 'ID_FILIAL_RETAGUARDA_SAP' and pl.vl_parametro = 'N')
;

If sqlca.sqlcode = -1 then 
	ps_log = 'Problemas ao consultar a tabela "promocao_sos_filial": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe > 0 then 
	pb_valida = True
else
	pb_valida = false
end if

return true
end function

protected function boolean of_valida_situacao (ref datastore pds_dados, boolean pb_filial_valida, ref string ps_log);long ll_for, ll_nr_atualizacao
string ls_status, ls_obs, ls_situacao

for ll_for = 1 to pds_dados.rowcount()

	ll_nr_atualizacao = pds_dados.object.nr_atualizacao[ll_for]
	
	Select id_status_integracao
	into :ls_status
	from log_exportacao_sap
	where nr_atualizacao = :ll_nr_atualizacao
	Using SQLCA;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = "Erro ao consultar a tabela log_exportacao_sap 'of_valida_status': " + SqlCa.SqlerrText
		Return False
	End If

	//Se o registro estiver pendente, atualiza para exportado.
	if ls_status = 'C' or ls_status = 'E' Then
		
		if pb_filial_valida = False Then
			ls_situacao = 'E'
			ls_obs = 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ filiais v$$HEX1$$e100$$ENDHEX$$lidas vinculadas ao planograma no momento da exporta$$HEX2$$e700e300$$ENDHEX$$o.'
		else
			ls_situacao = 'P'
		end if
		
		Update log_exportacao_sap
		set id_status_integracao = :ls_situacao, dh_exportacao = getdate(), de_erro = :ls_obs
		where nr_atualizacao = :ll_nr_atualizacao
		Using SQLCA;
		
		If SqlCa.SqlCode = -1 Then
			ps_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_sap 'of_valida_status': " + SqlCa.SqlerrText
			Return False
		End if
		
	Else
		
		//Se o registro n$$HEX1$$e300$$ENDHEX$$o estiver mais pendente, exclui o registro da datastore (registro n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ mais usado).
		pds_dados.rowsdiscard(ll_for, ll_for, Primary!)
	
	End if
	
Next

return true
end function

public subroutine of_processa_envio (long pl_nr_atualizacao);Long ll_Log
Long ll_Linha
Long ll_Linhas, ll_linhas_plan, ll_qt_estoque_minimo
Long ll_cd_planograma, ll_row, ll_for, ll_cd_produto, ll_cd_filial, ll_nr_atualizacao, ll_progresso_geral=0

String ls_log
String ls_Parametro_URL
String ls_Tipo_Log_Exp
String ls_Descricao_Tipo_Log
String ls_Grava_XML
String ls_Nome_Interface

String ls_XML
String ls_Xml_Retorno

String ls_xml_planograma, ls_xml_Produto, ls_xml_centros, ls_xml_est_minimo

String ls_tipo_log, ls_tipo_registro
boolean lb_valido
boolean lb_sucesso = true

ls_Parametro_URL 		= 'CD_URL_EST_MINIMO_PROMO_PLA'
ls_Tipo_Log_Exp 			= 'PLA'
ls_Descricao_Tipo_Log	= 'PLANOGRAMA ALTERACAO'
ls_Nome_Interface 		= 'PLANOGRAMA'

dc_uo_ds_base lds, lds_planograma

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log )

gvs_Log_Geral = ''

ls_Grava_XML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "Grava_XML", "")

if pl_nr_atualizacao > 0 Then
	ib_monitor_exp = true
End if

try 
	
	if isvalid(w_aguarde_3) then	
		w_aguarde_3.uo_progress.of_setmax(3)
		
		w_aguarde_3.wf_settext('Validando as configura$$HEX2$$e700f500$$ENDHEX$$es da interface...', 2)
	end if
	
	//DataStore que armazenar$$HEX1$$e100$$ENDHEX$$ os registros da tabela de LOG de exporta$$HEX2$$e700e300$$ENDHEX$$o.
	lds = Create dc_uo_ds_base
	
	//DataStore que armazenar$$HEX1$$e100$$ENDHEX$$ a lista de Planogramas (Vindos da tabela de LOG).
	lds_planograma = Create dc_uo_ds_base
	
	ll_Log = FileLength(is_Arquivo_Log)
	
	If Not of_ambiente_sap(ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
		
	If Not lds.of_ChangeDataObject(is_DS, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS + "' - " + is_Objeto, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not lds_planograma.of_ChangeDataObject(is_DS, False) Then
		lf_ge470_log("Erro ao alterar a DW '" + is_DS + "' - " + is_Objeto, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return
	End If
	
	If Not gf_retorna_pametro_sap(SQLCA, is_Ambiente_SAP, ls_Parametro_URL, ref is_URL, ref ls_log) Then
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
		Return 
	End If
	
	if pl_nr_atualizacao > 0 then
		lds.of_appendwhere( 'nr_atualizacao = ' + String(pl_nr_atualizacao))
	else
		lds.of_appendwhere( "id_status_integracao = 'C' " )
	end if
	
	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
		
		w_aguarde_3.wf_settext('Buscando informa$$HEX2$$e700f500$$ENDHEX$$es do banco de dados...', 2)
	end if
	
	//Busca os registros pendentes da tabela de LOG.
	ll_Linhas = lds.Retrieve()
	
	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
	end if
	
	if ll_linhas  > 0 Then	
	
		//Faz uma lista com todos os planogramas.
		for ll_linha = 1 to ll_linhas
			
			ll_cd_planograma = lds.object.cd_planograma[ll_linha]
			
			if lds_planograma.find('cd_planograma = ' + string(ll_cd_planograma) , 1, lds_planograma.rowcount()) = 0 Then
				ll_row = lds_planograma.insertrow(0)
				lds_planograma.setitem(ll_row,'cd_planograma', ll_cd_planograma)
			end if
			
		next
		
		ll_linhas_plan = lds_planograma.rowcount()
		
		if isvalid(w_aguarde_3) then	
			w_Aguarde_3.wf_settext( "Enviando informa$$HEX2$$e700f500$$ENDHEX$$es para o SAP ...", 2 )
			
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas_plan)
		end if
		
		//Percorre cada planograma
		For ll_linha = 1 to ll_linhas_plan
			
			ls_xml = ''
			ls_xml_planograma = ''
			ls_xml_Produto = ''
			ls_xml_centros = ''
			ls_xml_est_minimo = ''
			
			ll_cd_planograma = lds_planograma.object.cd_planograma[ll_linha]
	
			if isvalid(w_aguarde_3) then	
				w_aguarde_3.wf_settext('Enviando Planograma: ' + String(ll_linha) + ' de ' + String(ll_linhas_plan) , 3)
				w_aguarde_3.wf_settext('Planograma: ' + String(ll_cd_planograma)  , 4)
			end if	
	
			//Filtra os registros da tabela de LOG para trazer apenas os de cada Planograma..
			lds.setfilter('cd_planograma = ' + String(ll_cd_planograma) )
			lds.filter()
			
			lds.setsort( 'nr_atualizacao')
			lds.sort()
			
			if this.of_valida_parametro_filial( ll_cd_planograma, ref lb_valido, ref ls_log) = False Then
				lb_sucesso = false
				return
			end if
			
			//Chama fun$$HEX2$$e700e300$$ENDHEX$$o para validar a situa$$HEX2$$e700e300$$ENDHEX$$o dos registros.
			if of_valida_situacao(ref lds, lb_valido, ref ls_log) = false then
				lb_sucesso = false
				return
			end if
					
			if lb_valido = False Then
				SqlCa.of_Commit()
				Continue
			end if
					
			ll_linhas = lds.rowcount( )
	
			//Monta o xml com os dados completos do planograma.
			if of_monta_xml_planograma(ll_cd_planograma, ref ls_xml_planograma, ref ls_log) = False Then
				lb_sucesso = false
				return
			end if
				
			
			//Percorre cada registro do LOG para montar o xml.
			for ll_for = 1 to ll_linhas
				
				ls_tipo_log = lds.object.id_tipo_log[ll_for]
				ll_cd_produto = lds.object.cd_produto[ll_for]
				ll_cd_filial = lds.object.cd_filial[ll_for]
				ls_tipo_registro = lds.object.id_tipo_registro[ll_for]
				ll_nr_atualizacao = lds.object.nr_atualizacao[ll_for]
				ll_qt_estoque_minimo = lds.object.qt_estoque_minimo[ll_for]
				
				Choose Case ls_tipo_log
						
					Case '151' //Produtos
						
						if isnull(ll_cd_produto) Then
							ls_log = 'C$$HEX1$$f300$$ENDHEX$$digo do Produto n$$HEX1$$e300$$ENDHEX$$o informado.'
							lb_sucesso = false
							return
						end if
						
						if ls_tipo_registro = 'E' then
							//Quando for exclus$$HEX1$$e300$$ENDHEX$$o de registro.
							if of_monta_xml_prod(ll_cd_planograma, ll_cd_produto, True, ref ls_xml_produto, ref ls_log) = False Then
								lb_sucesso = false
							end if
						else
							if of_monta_xml_prod(ll_cd_planograma, ll_cd_produto, False, ref ls_xml_produto, ref ls_log) = False Then
								lb_sucesso = false
								return
							end if
						end if
						
					Case '152' //Filiais
						
						if isnull(ll_cd_filial) Then
							ls_log =  'C$$HEX1$$f300$$ENDHEX$$digo da Filial n$$HEX1$$e300$$ENDHEX$$o informado.'
							lb_sucesso = false
							return
						end if
						
						if ls_tipo_registro = 'E' then
							//Quando for exclus$$HEX1$$e300$$ENDHEX$$o de registro.
							if of_monta_xml_centros(ll_cd_planograma, ll_cd_filial, True, ref ls_xml_centros, ref ls_log) = False Then
								lb_sucesso = false
								return 
							end if
						else
							if of_monta_xml_centros(ll_cd_planograma, ll_cd_filial, False, ref ls_xml_centros, ref ls_log) = False Then
								lb_sucesso = false
								return 
							end if
						end if
						
					Case '160' // 1319584 - estoque m$$HEX1$$ed00$$ENDHEX$$nimo
						
						if of_monta_xml_est_minimo(ll_cd_produto, ll_cd_planograma, ll_cd_filial, ll_qt_estoque_minimo, ref ls_xml_est_minimo, ref ls_log) = False Then
							lb_sucesso = false
							return 
						end if
						
				End Choose
				
			Next
			
			ls_XML =	 is_Inicio_XML 
			
			//Limpar caracteres especiais
			
			if ls_xml_planograma <> '' Then ls_xml += ls_xml_planograma
			if ls_xml_centros <> '' Then ls_xml += ls_xml_centros
			if ls_xml_produto <> '' Then ls_xml += ls_xml_produto
			if ls_xml_est_minimo <> '' Then ls_xml += ls_xml_est_minimo
			
			ls_xml += is_Termino_XML
				
			If ls_Grava_XML = "S" Then
				This.of_grava_xml(ls_XML, ll_cd_planograma)
			End If
			
			If not io_sap_comum.of_Envia_Webservice(is_URL, ls_XML, Ref ls_Xml_Retorno, Ref ls_log) Then
				lb_sucesso = false
				return
			End If
			
			If lb_sucesso = True Then
				SqlCa.of_Commit()
			end if
			
			if isvalid(w_aguarde_3) then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)	
			end if
			
		Next
		
	end if
		
	if isvalid(w_aguarde_3) Then
		ll_progresso_geral++
		w_aguarde_3.uo_progress.of_setprogress(ll_progresso_geral)
	end if	
		
catch (RuntimeError lo_rte)
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o [" + is_DS + "], objeto ["+ is_Objeto +"]. Erro: "+lo_rte.GetMessage())
	Return
finally
	
	If lb_sucesso = false Then
		SqlCa.of_Rollback()
		
		of_grava_erro(ll_nr_atualizacao, ls_log, ref ls_log)
		SqlCa.of_Commit()
		
		lf_ge470_log(ls_log, 1, ls_Tipo_Log_Exp, ls_Descricao_Tipo_Log, ii_log)
	End if
	
	If not gvb_Auto and ib_monitor_exp = false Then
		If FileLength(is_Arquivo_Log) > ll_Log Then
			
			if pl_nr_atualizacao = 0 Then
				dc_uo_api lo_api
				lo_api =Create dc_uo_api
				lo_api.of_Shell_execute('notepad.exe', is_Arquivo_Log)
				Destroy(lo_api)
			end if
		Else
			//MessageBox('Sucesso!','Os procedimentos foram executados sem erros! ',Information!,Ok!)
		End If
	Else
		If gvs_Log_Geral <> '' Then lf_ge470_email_log(gvs_Log_Geral,1)
	End If
		
	If IsValid(lds) Then Destroy lds
	If IsValid(lds_planograma) Then Destroy lds_planograma
	
end try
end subroutine

public function boolean of_grava_erro (long pl_nr_atualizacao, string ps_mensagem, ref string ps_log);update log_exportacao_sap
set id_status_integracao = 'E', de_erro = :ps_mensagem
where nr_atualizacao = :pl_nr_atualizacao;

if sqlca.sqlcode = -1 then 
	ps_log = sqlca.sqlerrtext
	return false
end if

return true
end function

public function boolean of_monta_xml_est_minimo (long pl_cd_produto, long pl_cd_planograma, long pl_cd_filial, long pl_qt_estoque_minimo, ref string ps_xml, ref string ps_log);string ls_cd_filial_sap, ls_cd_produto_sap
	
// Busca filial SAP
select s.cd_chave_sap
into :ls_cd_filial_sap
from integracao_sap s
Where s.cd_empresa = 1000 
	and s.cd_tabela = 'FILIAL'
	and s.cd_chave_legado = cast(:pl_cd_filial as varchar);

If SQLCA.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela "integracao_sap" para buscar o c$$HEX1$$f300$$ENDHEX$$digo da filial SAP: ' + SQlca.SQlerrtext
	return false
end if

// Busca produto SAP
select pg.cd_produto_sap
Into :ls_cd_produto_sap
from produto_geral pg
where pg.cd_produto = :pl_cd_produto;

If SQLCA.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela "produto_geral" para buscar o c$$HEX1$$f300$$ENDHEX$$digo do produto SAP.~rPlanograma = ' + String(pl_cd_planograma) + ' ; Produto = ' + String(pl_cd_produto) + ' Erro:~r' + SQlca.SQlerrtext
	return false
end if

ps_xml += '<DADOS>' + &
					'<PLANOGRAMA>' + String(pl_cd_planograma) + '</PLANOGRAMA>' + &
					'<CENTRO>' + ls_cd_filial_sap + '</CENTRO>' + &
					'<MATERIAL>' + String(ls_cd_produto_sap) + '</MATERIAL>' + &
					'<MINIMO_MAX>' + String(pl_qt_estoque_minimo) + '</MINIMO_MAX>' + &
				'</DADOS>'

return true
end function

on uo_ge481_planograma.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge481_planograma.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_Abre_Log(is_nome_arquivo)

io_sap_comum = Create uo_ge470_sap_comum

is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_Planograma_Request>'
							
is_Termino_XML	=	'</imp:MT_Planograma_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
							

end event

event destructor;Destroy(io_sap_comum)

FileClose(ii_Log)
end event

